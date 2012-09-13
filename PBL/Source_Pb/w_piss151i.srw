$PBExportHeader$w_piss151i.srw
$PBExportComments$출고전표(군산용)
forward
global type w_piss151i from w_ipis_sheet01
end type
type dw_shipsheet from u_vi_std_datawindow within w_piss151i
end type
type uo_date from u_pisc_date_applydate within w_piss151i
end type
type uo_area from u_pisc_select_area within w_piss151i
end type
type uo_division from u_pisc_select_division within w_piss151i
end type
type dw_print from datawindow within w_piss151i
end type
type cb_1 from commandbutton within w_piss151i
end type
type cb_2 from commandbutton within w_piss151i
end type
type st_2 from statictext within w_piss151i
end type
type sle_truckno from singlelineedit within w_piss151i
end type
type st_3 from statictext within w_piss151i
end type
type em_fromtruckorder from editmask within w_piss151i
end type
type em_totruckorder from editmask within w_piss151i
end type
type st_4 from statictext within w_piss151i
end type
type st_h_bar from uo_xc_splitbar within w_piss151i
end type
type dw_3 from datawindow within w_piss151i
end type
type dw_2 from datawindow within w_piss151i
end type
type dw_4 from datawindow within w_piss151i
end type
type dw_print1 from datawindow within w_piss151i
end type
type cb_3 from commandbutton within w_piss151i
end type
type dw_5 from datawindow within w_piss151i
end type
type dw_6 from datawindow within w_piss151i
end type
type gb_1 from groupbox within w_piss151i
end type
end forward

global type w_piss151i from w_ipis_sheet01
integer width = 4471
string title = "출고전표"
boolean controlmenu = false
event ue_post ( )
event ue_cancel pbm_custom49
dw_shipsheet dw_shipsheet
uo_date uo_date
uo_area uo_area
uo_division uo_division
dw_print dw_print
cb_1 cb_1
cb_2 cb_2
st_2 st_2
sle_truckno sle_truckno
st_3 st_3
em_fromtruckorder em_fromtruckorder
em_totruckorder em_totruckorder
st_4 st_4
st_h_bar st_h_bar
dw_3 dw_3
dw_2 dw_2
dw_4 dw_4
dw_print1 dw_print1
cb_3 cb_3
dw_5 dw_5
dw_6 dw_6
gb_1 gb_1
end type
global w_piss151i w_piss151i

type variables
string is_shipdate,is_areacode,is_divisioncode,is_cancel_divisioncode
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname
string is_fromdate, is_enddate, is_shipsheetno, is_canceldate
long il_selectrow

end variables

forward prototypes
public subroutine wf_update_as400 (string fs_shipsheetno, string fs_shipdate)
public function boolean wf_shipsheet_update (string fs_shipsheetno, string fs_shipdate, string fs_divisioncode)
end prototypes

event ue_post;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
dw_2.settransobject(SQLPIS)
dw_3.settransobject(SQLPIS)
ib_open	= True
end event

event ue_cancel;//string ls_parm, ls_rtn
////is_shipsheetno = dw_shipsheet.getitemstring(il_selectrow, 'shipsheetno')
//ls_parm	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
//			  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
//			  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
//			  Left(String(WorkSpaceHeight()) + Space(10), 10) + &
//			  Left(is_shipsheetno + Space(10), 10) + &
//			  Left(is_canceldate + Space(10), 10)  + left(is_cancel_divisioncode + space(1),1)
//			  
////openwithparm(w_piss0160u, ls_parm)
//
//ls_rtn	 	= Message.StringParm
//IF ls_rtn = 'YES' then
//	TriggerEvent('ue_retireve')
//End if
//	
//		
end event

public subroutine wf_update_as400 (string fs_shipsheetno, string fs_shipdate);int i,ln_row
string ls_moverequireno,ls_fromareacode,ls_fromdivisioncode,ls_srno

dw_6.reset()
ln_row = dw_6.retrieve(fs_shipsheetno,fs_shipdate)
for i = 1 to ln_row
	ls_moverequireno 		= dw_6.object.moverequireno[i]
	ls_fromareacode 		= dw_6.object.fromareacode[i]
	ls_fromdivisioncode 	= dw_6.object.fromdivisioncode[i]
	ls_srno					= dw_6.object.srno[i] + '0'
	if mid(ls_moverequireno,3,2) = ( ls_fromareacode + ls_fromdivisioncode ) then
		if f_exkbno_slno(fs_shipsheetno,mid(ls_moverequireno,3,9),ls_srno) <> 0 then
			messagebox("확인","이체간판정보 (" + ls_moverequireno + ") 생성 실패,시스템 개발팀으로 문의하세요")
		end if 
	end if
next

end subroutine
public function boolean wf_shipsheet_update (string fs_shipsheetno, string fs_shipdate, string fs_divisioncode);int li_Printcount

select distinct Printcount into :li_Printcount From tshipsheet 
 Where shipsheetno  = :fs_shipsheetno
   and areacode     = :is_areacode
	and divisioncode = :fs_divisioncode
	and shipdate     = :fs_shipdate
	using sqlpis;

If sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = '출고전표 발행 오류'
	return false
end if

if li_Printcount < 1 or isnull(li_Printcount) then
	Update tshipsheet
		Set PrintCount	    = PrintCount + 1,
			 sheetprintdate = getdate(),
			 lastemp		    = 'Y',
			 lastdate       = getdate()
	 Where shipsheetno  = :fs_shipsheetno
		and areacode     = :is_areacode
		and divisioncode = :fs_divisioncode
		and shipdate     = :fs_shipdate
	using sqlpis;
	if mid(fs_shipsheetno,3,1) = 'M' then
		wf_update_as400(fs_shipsheetno,fs_shipdate)
	end if	
end if 

If sqlpis.sqlcode = 0 then
	uo_status.st_message.text = '출고전표 수정 완료'	
	return true
else
	uo_status.st_message.text = '출고전표 수정 오류'
	return false
end if
end function
on w_piss151i.create
int iCurrent
call super::create
this.dw_shipsheet=create dw_shipsheet
this.uo_date=create uo_date
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_print=create dw_print
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.sle_truckno=create sle_truckno
this.st_3=create st_3
this.em_fromtruckorder=create em_fromtruckorder
this.em_totruckorder=create em_totruckorder
this.st_4=create st_4
this.st_h_bar=create st_h_bar
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_4=create dw_4
this.dw_print1=create dw_print1
this.cb_3=create cb_3
this.dw_5=create dw_5
this.dw_6=create dw_6
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipsheet
this.Control[iCurrent+2]=this.uo_date
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.sle_truckno
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.em_fromtruckorder
this.Control[iCurrent+12]=this.em_totruckorder
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_h_bar
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.dw_4
this.Control[iCurrent+18]=this.dw_print1
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.dw_5
this.Control[iCurrent+21]=this.dw_6
this.Control[iCurrent+22]=this.gb_1
end on

on w_piss151i.destroy
call super::destroy
destroy(this.dw_shipsheet)
destroy(this.uo_date)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_print)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.sle_truckno)
destroy(this.st_3)
destroy(this.em_fromtruckorder)
destroy(this.em_totruckorder)
destroy(this.st_4)
destroy(this.st_h_bar)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.dw_print1)
destroy(this.cb_3)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.gb_1)
end on

event open;call super::open;SetPointer(HourGlass!)
PostEvent('ue_post')
end event

event ue_retrieve;call super::ue_retrieve;Long ll_rowcount, ll_selected_row,ll_fromtruckorder,ll_totruckorder
string ls_truckno
ls_truckno = sle_truckno.text + '%'
ll_selected_row	= dw_shipsheet.GetSelectedRow(0)
ll_fromtruckorder = long(trim(em_fromtruckorder.text))
ll_totruckorder   = long(trim(em_totruckorder.text))
if isnull(ll_fromtruckorder) or ll_fromtruckorder = 0 then
	ll_fromtruckorder = 0
end if	
if isnull(ll_totruckorder) or ll_totruckorder = 0 then
	ll_totruckorder = 99
end if	

ll_rowcount = dw_shipsheet.retrieve(is_areacode,is_divisioncode,is_shipdate,ls_truckno,ll_fromtruckorder,ll_totruckorder)

If ll_rowcount > 0 THEN
	cb_1.enabled = true
	cb_3.enabled = true
	dw_5.retrieve(is_areacode,is_divisioncode,is_shipdate,ls_truckno,ll_fromtruckorder,ll_totruckorder)
	If ll_selected_row = 1 Then
		dw_shipsheet.Post Event RowFocusChanged(1)
	End If
ELSE
	cb_1.enabled = false
	cb_3.enabled = false
	messagebox('조 회' , '발행할 출고전표가 없습니다.')
END IF
dw_shipsheet.setfocus()

end event

event ue_print;long ll_reprintcount, ll_rowcount, ll_i, ll_find
string ls_shipsheetno, ls_applydate,ls_divisioncode,ls_truckno,ls_custcode
boolean lb_commit = true

ll_reprintcount	= dw_shipsheet.getitemNumber(1, 'reprintsum')
if ll_reprintcount = 0 then
	Messagebox('출 력', '선택된 출고전표가 없습니다....')
	return
end if

ll_rowcount	= dw_shipsheet.rowcount()
ll_find 		= 0

setpointer(hourglass!)
SQLpis.AutoCommit	= False
FOR ll_i = 1 TO ll_reprintcount
	ll_find			 = dw_shipsheet.find("reprint = 1", ll_find + 1, ll_rowcount)
	ls_shipsheetno  = dw_shipsheet.getitemstring(ll_find, 'shipsheetno')
	ls_applydate    = is_shipdate
	ls_divisioncode = dw_shipsheet.getitemstring(ll_find, 'divisioncode')
	ls_truckno = dw_shipsheet.getitemstring(ll_find, 'truckno')
	ls_custcode = dw_shipsheet.getitemstring(ll_find, 'custcode')
	dw_print.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_applydate)
	
	dw_2.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_applydate)
	
	IF wf_shipsheet_update(ls_shipsheetno,ls_applydate,ls_divisioncode) then
		dw_print.print()
		dw_2.print()
	Else
		lb_commit = false
		Exit
	end if
	dw_shipsheet.setitem(ll_find, 'reprint', 0)
NEXT
setpointer(Arrow!)
if lb_commit = false then
	RollBack USING SQLPIS;
	SQLpis.AutoCommit	= True
	messagebox('출력',' 출력중 문제가 발생하였습니다...')		
else	
	commit using sqlpis;
   SQLpis.AutoCommit	= True	
	messagebox('출력','출력이 완료되었습니다.')
end if

end event

event resize;call super::resize;

il_resize_count ++

of_resize_register(dw_SHIPSHEET, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_3, BELOW)

of_resize()
end event

event activate;call super::activate;dw_shipsheet.settransobject(SQLPIS)
dw_3.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
dw_2.settransobject(SQLPIS)
dw_print1.settransobject(SQLPIS)
dw_5.settransobject(SQLPIS)
dw_6.settransobject(SQLPIS)

end event
type uo_status from w_ipis_sheet01`uo_status within w_piss151i
end type

type dw_shipsheet from u_vi_std_datawindow within w_piss151i
integer x = 14
integer y = 232
integer width = 3584
integer height = 816
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_piss150i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;If GetRow() > 0 then
	SelectRow (0, false)
	SelectRow (currentrow, true)
	il_selectrow = currentrow
//	this.triggerEvent("clicked")
End If
end event

event doubleclicked;call super::doubleclicked;If Getrow() > 0 then 
	il_selectrow = row
	is_shipsheetno = dw_shipsheet.getitemstring(il_selectrow, 'shipsheetno')
	is_canceldate  = dw_shipsheet.getitemstring(il_selectrow, 'applydate')	
	is_cancel_divisioncode = dw_shipsheet.getitemstring(il_selectrow, 'divisoncode')	
	Parent.TriggerEvent('ue_cancel')
END IF
end event

event clicked;call super::clicked;If row > 0 then 
	il_selectrow = row
	is_shipsheetno = dw_shipsheet.getitemstring(il_selectrow, 'shipsheetno')
	is_canceldate  = dw_shipsheet.getitemstring(il_selectrow, 'shipdate')	
	is_cancel_divisioncode = dw_shipsheet.getitemstring(il_selectrow, 'divisioncode')	
	string ls_divisioncode,ls_shipsheetno
	ls_divisioncode = dw_SHIPSHEET.object.divisioncode[row]
	ls_shipsheetno  = dw_SHIPSHEET.object.shipsheetno[row]
	dw_3.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,is_shipdate)	
END IF
end event

type uo_date from u_pisc_date_applydate within w_piss151i
event destroy ( )
integer x = 73
integer y = 96
integer taborder = 10
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate <> is_uo_date then
	dw_shipsheet.reset()
	dw_3.reset()
end if	
is_shipdate = is_uo_date

end event

type uo_area from u_pisc_select_area within w_piss151i
event destroy ( )
integer x = 795
integer y = 96
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
dw_3.settransobject(SQLPIS)
dw_2.settransobject(SQLPIS)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_shipsheet.reset()
dw_3.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss151i
event destroy ( )
integer x = 1367
integer y = 100
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
dw_3.settransobject(SQLPIS)
dw_2.settransobject(SQLPIS)
is_divisioncode = is_uo_divisioncode
dw_shipsheet.reset()
dw_3.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type dw_print from datawindow within w_piss151i
boolean visible = false
integer x = 128
integer y = 588
integer width = 2766
integer height = 700
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss150i_06_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_piss151i
integer x = 3557
integer y = 60
integer width = 457
integer height = 128
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "출고전표발행"
end type

event clicked;PARENT.TRIGGEREVEnT('ue_print')
end event

type cb_2 from commandbutton within w_piss151i
boolean visible = false
integer x = 3762
integer y = 432
integer width = 457
integer height = 128
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출하취소"
end type

event clicked;if dw_shipsheet.GetRow() > 0 Then
	is_shipsheetno = dw_shipsheet.getitemstring(il_selectrow, 'shipsheetno')
	Parent.TriggerEvent('ue_cancel')
End if
end event

type st_2 from statictext within w_piss151i
integer x = 2693
integer y = 104
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "차량번호"
boolean focusrectangle = false
end type

type sle_truckno from singlelineedit within w_piss151i
integer x = 2985
integer y = 88
integer width = 498
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_piss151i
integer x = 1929
integer y = 104
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "차량순번"
boolean focusrectangle = false
end type

type em_fromtruckorder from editmask within w_piss151i
integer x = 2203
integer y = 96
integer width = 169
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#0"
end type

type em_totruckorder from editmask within w_piss151i
integer x = 2437
integer y = 96
integer width = 169
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "99"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

type st_4 from statictext within w_piss151i
integer x = 2382
integer y = 108
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "-"
boolean focusrectangle = false
end type

type st_h_bar from uo_xc_splitbar within w_piss151i
integer x = 50
integer y = 1084
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_SHIPSHEET,ABOVE)
of_register(dw_3,BELOW)
end event

type dw_3 from datawindow within w_piss151i
integer x = 18
integer y = 1120
integer width = 1175
integer height = 712
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss400u_03_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_piss151i
boolean visible = false
integer x = 1216
integer y = 1352
integer width = 411
integer height = 432
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_piss150i_06_6"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_piss151i
boolean visible = false
integer x = 2112
integer y = 1464
integer width = 3781
integer height = 1704
integer taborder = 90
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_piss150i_07_report"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

type dw_print1 from datawindow within w_piss151i
boolean visible = false
integer x = 1614
integer y = 1320
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_piss150i_07_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;if rowcount > 0 then
//	string ls_return
//	int ln_mod,i
//	for i = 1 to rowcount
//		ls_return = f_piss_nonexam_item(trim(dw_print1.object.custcode[i]),trim(dw_print1.object.customeritemno[i]),trim(dw_print1.object.itemcode[i]))
//		if mid(ls_return,1,1) = 'Y' then
//			dw_print1.object.nonexam[i] = 'Y'
//		else
//			dw_print1.object.nonexam[i] = ' '
//		end if
//		if mid(ls_return,2,1) = 'Y' then
//			dw_print1.object.firstout[i] = 'Y'
//		else
//			dw_print1.object.firstout[i] = ' '
//		end if
	string ls_return,ls_custcode,ls_customeritemno,ls_date,ls_itemcode
	int ln_mod,i,ln_count
	for i = 1 to rowcount
		ls_custcode			=	trim(dw_print1.object.custcode[i])
		ls_customeritemno	=	trim(dw_print1.object.customeritemno[i])
		ls_itemcode			=	trim(dw_print1.object.itemcode[i])		
		ls_date				=	is_shipdate
		ls_return 			= 	f_piss_nonexam_item(ls_custcode,ls_customeritemno,ls_itemcode)
		if mid(ls_return,1,1) = 'Y' then
			dw_print1.object.nonexam[i] = 'Y'
		else
			dw_print1.object.nonexam[i] = ' '
		end if
		Select	isnull(count(*),0) into :ln_count
		  From	tshipsheet A,tsrorder B,tmstshipgubun D
		 Where	A.SRNo	        	= B.SrNO
			And	B.SRCancelGubun	= 'N'
			And	B.PCGubun			= 'P'
			and   A.Custcode			= :ls_custcode
			and	A.ShipDate 			< :ls_date
			and  	A.AreaCode      	= :is_areacode
			and  	A.DivisionCode  	like :is_divisioncode
			and  	A.AreaCode      	= B.srAreaCode
			and  	A.DivisionCode  	= B.srdivisionCode
			and   B.itemcode			= :ls_itemcode
			and	B.Shipgubun 		= D.shipgubun
			and	D.shipoemgubun 	= 'A'	using sqlpis ;
		if ln_count	=	0	then
			dw_print1.object.firstout[i] = 'Y'
		else
			dw_print1.object.firstout[i] = ' '
		end if
	next
	ln_mod	=	truncate(rowcount/25,0)	+ 25		
	for i = rowcount  + 1 to ln_mod
		dw_print1.insertrow(0)
	next
end if
end event

type cb_3 from commandbutton within w_piss151i
integer x = 4018
integer y = 60
integer width = 512
integer height = 128
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "검수내역서발행"
end type

event clicked;setpointer(hourglass!)
int i,ln_rowcount,ln_count
string ls_truckno,ls_applydate,ls_custcode,ls_divisioncode

ln_rowcount = dw_5.rowcount()

for i = 1 to ln_rowcount
	ls_truckno = dw_5.getitemstring(i, 'truckno')
	ls_applydate = dw_5.getitemstring(i, 'shipdate')
	ls_custcode = dw_5.getitemstring(i, 'custcode')
	ls_divisioncode = dw_5.getitemstring(i, 'divisioncode')
	if ls_custcode <> 'L10500' then continue
	dw_print1.reset()
	if dw_print1.retrieve(is_Areacode,ls_divisioncode,ls_applydate,ls_custcode,ls_truckno) > 0 then 
		ln_count = 1
		dw_print1.print()
	end if
next
if ln_count <> 1 then
	messagebox("확인","검수내역서 출력 대상 차량이 없습니다")
end if
end event

type dw_5 from datawindow within w_piss151i
boolean visible = false
integer x = 3223
integer y = 388
integer width = 686
integer height = 400
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss150i_01_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_6 from datawindow within w_piss151i
boolean visible = false
integer x = 1920
integer y = 1188
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_piss150i_08"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss151i
integer x = 23
integer y = 28
integer width = 3520
integer height = 172
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

