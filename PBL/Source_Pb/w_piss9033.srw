$PBExportHeader$w_piss9033.srw
$PBExportComments$수량분할
forward
global type w_piss9033 from window
end type
type st_remainqty from statictext within w_piss9033
end type
type st_8 from statictext within w_piss9033
end type
type dw_truckorder from datawindow within w_piss9033
end type
type dw_change_truckload from datawindow within w_piss9033
end type
type cb_2 from commandbutton within w_piss9033
end type
type cb_save from commandbutton within w_piss9033
end type
type st_modelid from statictext within w_piss9033
end type
type st_rackqty from statictext within w_piss9033
end type
type st_notloadqty from statictext within w_piss9033
end type
type st_loadplan from statictext within w_piss9033
end type
type st_srno from statictext within w_piss9033
end type
type st_5 from statictext within w_piss9033
end type
type st_4 from statictext within w_piss9033
end type
type st_3 from statictext within w_piss9033
end type
type st_1 from statictext within w_piss9033
end type
type gb_1 from groupbox within w_piss9033
end type
type gb_2 from groupbox within w_piss9033
end type
end forward

global type w_piss9033 from window
integer x = 1056
integer y = 700
integer width = 2217
integer height = 1408
boolean titlebar = true
string title = "수량분할"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event ue_save ( )
st_remainqty st_remainqty
st_8 st_8
dw_truckorder dw_truckorder
dw_change_truckload dw_change_truckload
cb_2 cb_2
cb_save cb_save
st_modelid st_modelid
st_rackqty st_rackqty
st_notloadqty st_notloadqty
st_loadplan st_loadplan
st_srno st_srno
st_5 st_5
st_4 st_4
st_3 st_3
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_piss9033 w_piss9033

type variables
Boolean ib_change = False, ib_exit = False, ib_commit = False

string is_itemcode, is_srgubun,is_areacode,is_divisioncode, &
       is_applydate, is_srno, is_custcode, is_shipcount
LONG ii_remainqty, ii_oldremainqty, ii_rackqty, ii_loadqty, ii_truckorder
LONG ii_newload, ii_newdansuqty, ii_newtruckorder
LONG ii_error
string is_date,is_shipgubun
end variables

forward prototypes
public subroutine wf_info (string fs_srno, string fs_areacode, string fs_divisioncode, string fs_srgubun, string fs_applydate)
end prototypes

event ue_save();long ll_rowcount, ll_i,ll_rackqty
long li_truckorder, li_loadqty, li_dansuqty, ll_sumtotal,li_shipeditno,li_truckloadqty,li_truckdansuqty
string ls_areacode,ls_divisioncode
li_shipeditno = integer(is_shipcount)

ib_commit = false

dw_change_truckload.Accepttext()
ll_sumtotal = dw_change_truckload.GetitemNumber(1, 'totalsum')
if	ll_sumtotal > long(st_remainqty.text) then 
	MessageBox('확인', ' 현재 분할한 수량은 SR잔량보다 많습니다.')
	return
end if
ll_rackqty = long(st_rackqty.text)
//is_applydate = f_pisc_get_date_applyday()
is_applydate = is_date

ll_rowcount = dw_change_truckload.rowcount()

FOR  ll_i = ll_rowcount to 1 step -1
	li_truckorder = dw_change_truckload.GetitemNumber(ll_i, 'truckorder')
	li_truckloadqty = dw_change_truckload.GetitemNumber(ll_i, 'truckloadqty')
	li_truckdansuqty = dw_change_truckload.GetitemNumber(ll_i, 'truckdansuqty')
	If (li_truckorder = 0) or ( li_truckloadqty = 0 and li_truckdansuqty = 0) then
		dw_change_truckload.deleterow(ll_i)
	end if
NEXT

dw_change_truckload.accepttext()

ll_rowcount = dw_change_truckload.rowcount()

SQLPIS.Autocommit = false
FOR ll_i = 1 TO ll_rowcount
	If dw_change_truckload.GetitemNumber(ll_i, 'loadqty') > 0 then
		li_truckorder = dw_change_truckload.GetitemNumber(ll_i, 'truckorder')
		li_loadqty    = dw_change_truckload.GetitemNumber(ll_i, 'loadqty')
		li_dansuqty   = dw_change_truckload.GetitemNumber(ll_i, 'truckdansuqty')			
		delete from tloadplantest
	         where areacode     = :is_areacode
				  and divisioncode = :is_divisioncode
				  and srno         = :is_srno
				  and shipplandate = :is_applydate
				  AND TRUCKNO IS NULL
				  AND TRUCKORDER   = :li_truckorder
				  AND lastemp		 = :g_s_empno
		using sqlpis;
      if sqlpis.sqlcode <> 0 then
			ib_commit = false
		   exit
		end if
		insert into tloadplantest 
		       (shipplandate,areacode,divisioncode,SRNo, TruckOrder, CustCode, ApplyFrom, ShipEditNo,Truckno,
				  Itemcode,truckmodifyflag, TruckLoadQty, TruckDansuQty, LastEmp, LastDate)										
		Values (:is_applydate,:is_areacode,:is_divisioncode,:is_SRNo, :li_Truckorder, :is_custcode, :is_applydate, :li_shipeditno, NULL,
				  :is_itemcode,'N', :li_loadqty,0,:g_s_empno, GetDate())
		 using sqlpis;
		if SQLPIS.Sqlcode = 0 then
			ib_change = false
			ib_commit = true
		else
			ib_change = true
			ib_commit = false				
			EXIT
		end if
	end if
NEXT
if	ib_commit = true then
   commit using sqlpis;
   SQLpis.Autocommit = true	
else
   rollback using sqlpis;
   SQLpis.Autocommit = true	
	messagebox("오류","상차 계획 저장중 오류 발생 ")
end if	
	



end event

public subroutine wf_info (string fs_srno, string fs_areacode, string fs_divisioncode, string fs_srgubun, string fs_applydate);string ls_modelid
long li_truckloadqty,li_truckdansuqty,li_shipremainqty

Select ModelID
  Into :ls_modelid
  from tmstkb
 where ItemCode     = :is_Itemcode
   and AreaCode     = :is_areacode
	and DivisionCode = :is_DivisionCode
Group by modelID
using sqlpis;

st_modelid.text = ls_modelid


//SELECT SRNO			= :fs_srno,   
//	    shipRemainQty		= A.shipRemainQty
//  Into :is_srno ,
//	    :ii_remainqty
//  FROM tsrorder A
// WHERE A.srno 	= :fs_srno
//   and A.shipremainqty 	> 0 
//	and A.areacode = :fs_areacode
//	and A.divisioncode = :fs_divisioncode
//	using sqlpis;
//	

select truckloadqty,truckdansuqty
  into :li_truckloadqty,:li_truckdansuqty
  from tloadplantest
  where areacode = :is_areacode
    and divisioncode = :is_divisioncode
	 and shipplandate = :is_date
	 and srno = :is_srno
	 using sqlpis;
select shipremainqty
  into :li_shipremainqty
  from tsrorder
  where areacode     = :is_areacode
    and divisioncode = :is_divisioncode
	 and srno         = :is_srno
	 using sqlpis;
ii_remainqty = li_shipremainqty
//st_loadplan.text   = string(li_truckloadqty * ii_rackqty + li_truckdansuqty,'#,##0')	 
st_loadplan.text   = string(li_truckloadqty,'#,##0')
st_remainqty.text  = string(li_shipremainqty,'#,##0')  
st_notloadqty.text = string(li_shipremainqty - long(st_loadplan.text),'#,##0')
st_srno.text = is_srno

end subroutine

on w_piss9033.create
this.st_remainqty=create st_remainqty
this.st_8=create st_8
this.dw_truckorder=create dw_truckorder
this.dw_change_truckload=create dw_change_truckload
this.cb_2=create cb_2
this.cb_save=create cb_save
this.st_modelid=create st_modelid
this.st_rackqty=create st_rackqty
this.st_notloadqty=create st_notloadqty
this.st_loadplan=create st_loadplan
this.st_srno=create st_srno
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_remainqty,&
this.st_8,&
this.dw_truckorder,&
this.dw_change_truckload,&
this.cb_2,&
this.cb_save,&
this.st_modelid,&
this.st_rackqty,&
this.st_notloadqty,&
this.st_loadplan,&
this.st_srno,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_1,&
this.gb_1,&
this.gb_2}
end on

on w_piss9033.destroy
destroy(this.st_remainqty)
destroy(this.st_8)
destroy(this.dw_truckorder)
destroy(this.dw_change_truckload)
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.st_modelid)
destroy(this.st_rackqty)
destroy(this.st_notloadqty)
destroy(this.st_loadplan)
destroy(this.st_srno)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event closequery;integer li_rtn

if ib_change Then
	li_rtn = messagebox('종 료', '저장되지 않은 상차계획이 있습니다.~r~n저장 하시겠습니까?', Question!, YesNoCancel!)
	CHOOSE CASE li_rtn
		CASE 1			// 저장후 종료
			ib_exit	= True
			TriggerEvent('ue_save')
			If ib_change Then
				Return 1
			Else
				Return 0          
			End If
		CASE 2			// 기냥 종료
			Return 0
		CASE 3			// No Action
			Return 1
	END CHOOSE
Else
	Return 0
End If
end event

event open;string ls_argument, ls_size
LONG li_remainqty,li_rowcount
string ls_null,ls_shipgubun
setnull(ls_null)
ls_argument = Message.StringParm
is_areacode     = mid(ls_argument,1,1)							  
is_divisioncode = mid(ls_argument,2,1)							  
is_date         = trim(mid(ls_argument,3,10))
is_itemcode     = trim(mid(ls_argument,18,12))
ii_rackqty		 = LONG(Trim(Mid(ls_argument, 33,10)))
is_applydate	 = Trim(Mid(ls_argument, 43, 10))
is_srno	       = Trim(Mid(ls_argument, 53, 11))
is_srgubun		 = Trim(Mid(ls_argument, 64, 10))
li_remainqty	= LONG(Trim(Mid(ls_argument, 74, 5)))
is_shipcount	= Trim(Mid(ls_argument, 79, 5))
is_custcode		= Trim(Mid(ls_argument, 84, 10))
is_shipgubun		= Trim(Mid(ls_argument, 94, 10))

ls_size			= Right(ls_argument,40)

//f_win_move(This, ls_size)

st_srno.text 	= string(is_srno)
st_rackqty.text 	= string(ii_rackqty)
//st_notloadqty.text= string(li_remainqty, '#,##0')

ib_change 			= false

//is_applydate = f_pisc_get_date_applyday()

dw_change_truckload.SetTransObject(SQLPIS)
dw_truckorder.SetTransObject(SQLPIS)
dw_truckorder.retrieve(is_applydate,is_areacode,is_divisioncode)
dw_change_truckload.retrieve(is_srno, is_applydate,is_areacode,is_divisioncode, g_s_empno, ii_rackqty, is_srgubun)
dw_change_truckload.setrow(1)
dw_change_truckload.setcolumn(1)
dw_change_truckload.setfocus()

dw_change_truckload.insertrow(0)
li_rowcount = dw_change_truckload.rowcount()
dw_change_truckload.object.SRNo[li_rowcount] = is_srno
dw_change_truckload.object.truckorder[li_rowcount] = 0
dw_change_truckload.object.custcode[li_rowcount] = is_custcode
dw_change_truckload.object.applydate[li_rowcount] = is_date
//dw_change_truckload.object.shipeditno[li_rowcount] = is_shipcount
//dw_change_truckload.object.srgubun[li_rowcount] = is_srgubun
dw_change_truckload.object.truckno[li_rowcount] = ls_null
dw_change_truckload.object.itemcode[li_rowcount] = is_itemcode
dw_change_truckload.object.truckloadqty[li_rowcount] = 0
dw_change_truckload.object.truckdansuqty[li_rowcount] = 0
//dw_change_truckload.object.shipremainqty[li_rowcount] = ii_shipremainqty
dw_change_truckload.object.rackqty[li_rowcount] = ii_rackqty

dw_change_truckload.object.divisioncode[li_rowcount] = is_divisioncode
//messagebox("",is_srno+' ' +is_areacode+' ' +is_divisioncode+' ' +is_srgubun+' ' +is_applydate)
wf_info(is_srno,is_areacode,is_divisioncode, is_srgubun, is_applydate)

end event

type st_remainqty from statictext within w_piss9033
integer x = 439
integer y = 200
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_piss9033
integer x = 69
integer y = 216
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "SR잔량"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_truckorder from datawindow within w_piss9033
boolean visible = false
integer x = 1783
integer y = 884
integer width = 411
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "d_piss903u_08"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_change_truckload from datawindow within w_piss9033
event ue_enterkey pbm_dwnprocessenter
integer x = 283
integer y = 596
integer width = 1499
integer height = 704
integer taborder = 30
string title = "none"
string dataobject = "d_piss9033_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;CHOOSE CASE ii_error
	CASE 1
		dw_change_truckload.setcolumn('truckorder')
	CASE 2
		dw_change_truckload.setcolumn('truckloadqty')
	CASE 3
		dw_change_truckload.setcolumn('truckdansuqty')
END CHOOSE

end event

event itemchanged;string ls_find
integer li_truckorder, li_remainqty, li_dansuqty
long ll_find

cb_save.enabled 		= true

ib_change 				= true
ib_exit					= false
ii_error = 0
CHOOSE CASE Upper(dwo.name)
	CASE 'TRUCKORDER'
		li_truckorder	= integer(data)
		ls_find	= 'truckflag = 0 and Truckorder = ' + String(li_truckorder)
		ll_find	= dw_truckorder.find(ls_find, 1, dw_truckorder.rowcount())
		
		If ll_find > 0 Then
			MessageBox('확 인', '입력하신 트럭 순번은 이미 출하된 차량 호수입니다.~r~n다른 호수를 선택하십시오.')
			setcolumn('truckorder')
//			setitem(row, 'truckorder', 0)
//			ii_error = 1
//			TriggerEvent('ue_enterkey')
//			return
		else
			SetColumn('truckloadqty')
			SetFocus()
		End If
	CASE 'truckloadqty'
		If ii_remainqty < (integer(Data) * ii_rackqty) Then //입력한 수량이 분할 하려하는 잔량보다 많다면 에러
	
			setitem(row, 'truckloadqty', 0)
			MessageBox('확 인', '입력하신 수량이 잔량보다 많습니다.')
			setcolumn('truckloadqty')
			setfocus()
			AcceptText()						
			ii_error = 2
			TriggerEvent('ue_enterkey')			
			return
		else
			SetColumn('trcukdansuqty')
			SetFocus()
		End If
	CASE 'truck'
		li_dansuqty = integer(data)		
		If ii_rackqty < li_dansuqty  Then
			setitem(row, 'trcukdansuqty', 0)
			setfocus()
			AcceptText()			
			MessageBox('확 인', '입력하신 수량이 Rack 수량보다 많습니다.')
			ii_error = 3
			TriggerEvent('ue_enterkey')			
		elseif ii_remainqty < (li_dansuqty + ii_rackqty * This.GetitemNumber(1, 'truckloadqty')) then
			setitem(row, 'trcukdansuqty', 0)			
			setfocus()			
			AcceptText()			
			MessageBox('확 인', '입력하신 수량이 잔량보다 많습니다.')
			ii_error = 3
			TriggerEvent('ue_enterkey')			
		else
			cb_save.setfocus()
		End If
END CHOOSE

end event

type cb_2 from commandbutton within w_piss9033
integer x = 1673
integer y = 268
integer width = 457
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;If ib_change then
	CloseWithReturn(w_piss9033, 'YES')
Else
	CloseWithReturn(w_piss9033, 'NO')
End If
end event

type cb_save from commandbutton within w_piss9033
integer x = 1678
integer y = 124
integer width = 457
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;Parent.TriggerEvent('ue_save')
CloseWithReturn(parent, 'YES')


end event

type st_modelid from statictext within w_piss9033
integer x = 997
integer y = 80
integer width = 544
integer height = 204
integer textsize = -36
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_rackqty from statictext within w_piss9033
integer x = 1307
integer y = 300
integer width = 238
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_notloadqty from statictext within w_piss9033
integer x = 439
integer y = 408
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_loadplan from statictext within w_piss9033
integer x = 439
integer y = 312
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_srno from statictext within w_piss9033
integer x = 439
integer y = 96
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_piss9033
integer x = 960
integer y = 312
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "RACk수용수"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss9033
integer x = 69
integer y = 420
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "미상차수량"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss9033
integer x = 69
integer y = 324
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "상차수량"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_piss9033
integer x = 73
integer y = 108
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "SR번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss9033
integer x = 50
integer y = 32
integer width = 1536
integer height = 492
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "상차정보"
end type

type gb_2 from groupbox within w_piss9033
integer x = 1623
integer y = 24
integer width = 549
integer height = 388
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "버튼정보"
end type

