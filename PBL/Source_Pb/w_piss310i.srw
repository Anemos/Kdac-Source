$PBExportHeader$w_piss310i.srw
$PBExportComments$현품표재발행
forward
global type w_piss310i from w_ipis_sheet01
end type
type dw_shipsheet from u_vi_std_datawindow within w_piss310i
end type
type uo_area from u_pisc_select_area within w_piss310i
end type
type uo_division from u_pisc_select_division within w_piss310i
end type
type cb_1 from commandbutton within w_piss310i
end type
type dw_print from datawindow within w_piss310i
end type
type uo_date from u_pisc_date_applydate within w_piss310i
end type
type uo_1 from u_pisc_date_today_1 within w_piss310i
end type
type st_2 from statictext within w_piss310i
end type
type gb_1 from groupbox within w_piss310i
end type
end forward

global type w_piss310i from w_ipis_sheet01
string title = "출고전표"
event ue_post ( )
event ue_cancel pbm_custom49
dw_shipsheet dw_shipsheet
uo_area uo_area
uo_division uo_division
cb_1 cb_1
dw_print dw_print
uo_date uo_date
uo_1 uo_1
st_2 st_2
gb_1 gb_1
end type
global w_piss310i w_piss310i

type variables
string is_shipdate,is_shipdate1,is_areacode,is_divisioncode,is_cancel_divisioncode
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname
string is_fromdate, is_enddate, is_shipsheetno, is_canceldate
long il_selectrow

end variables

forward prototypes
public function boolean wf_update_kbno (string fs_areacode, string fs_divisioncode, string fs_kbno)
end prototypes

event ue_post;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)

ib_open	= True
end event

event ue_cancel;string ls_parm, ls_rtn
//is_shipsheetno = dw_shipsheet.getitemstring(il_selectrow, 'shipsheetno')
ls_parm	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
			  Left(String(WorkSpaceHeight()) + Space(10), 10) + &
			  Left(is_shipsheetno + Space(10), 10) + &
			  Left(is_canceldate + Space(10), 10)  + left(is_cancel_divisioncode + space(1),1)
			  
//openwithparm(w_piss0160u, ls_parm)

ls_rtn	 	= Message.StringParm
IF ls_rtn = 'YES' then
	TriggerEvent('ue_retireve')
End if
	
		
end event

public function boolean wf_update_kbno (string fs_areacode, string fs_divisioncode, string fs_kbno);update tkb
   set printcount  = printcount + 1,
	    kbprinttime = getdate(),
	    lastemp     = 'Y',
		 lastdate    = getdate()
 where kbno         = :fs_kbno
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if sqlpis.sqlcode <> 0 then
	return false
end if	
	
update tkbhis
   set printcount  = printcount + 1,
	    kbprinttime = getdate(),
	    lastemp     = 'Y',
		 lastdate    = getdate()
 where kbno         = :fs_kbno
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if sqlpis.sqlcode <> 0 then
	return false
end if	

return true
end function

on w_piss310i.create
int iCurrent
call super::create
this.dw_shipsheet=create dw_shipsheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_1=create cb_1
this.dw_print=create dw_print
this.uo_date=create uo_date
this.uo_1=create uo_1
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipsheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.uo_date
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.gb_1
end on

on w_piss310i.destroy
call super::destroy
destroy(this.dw_shipsheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_1)
destroy(this.dw_print)
destroy(this.uo_date)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

event open;call super::open;SetPointer(HourGlass!)
PostEvent('ue_post')
end event

event ue_retrieve;call super::ue_retrieve;Long ll_rowcount, ll_selected_row
ll_selected_row	= dw_shipsheet.GetSelectedRow(0)

ll_rowcount = dw_shipsheet.retrieve(is_areacode,is_divisioncode,is_shipdate,is_shipdate1)

If ll_rowcount > 0 THEN
	If ll_selected_row = 1 Then
		dw_shipsheet.Post Event RowFocusChanged(1)
	End If
ELSE
	messagebox('확인' , '발행할 현품표가 없습니다.')

END IF
dw_shipsheet.setfocus()

end event

event ue_print;long ll_reprintcount, ll_rowcount, ll_i, ll_find
string ls_kbno,ls_divisioncode
boolean lb_commit = true

ll_reprintcount	= dw_shipsheet.getitemNumber(1, 'reprintsum')
if ll_reprintcount = 0 then
	Messagebox('출 력', '선택된 현품표가 없습니다....')
	return
end if

ll_rowcount	= dw_shipsheet.rowcount()
ll_find 		= 0

setpointer(hourglass!)
SQLpis.AutoCommit	= False
FOR ll_i = 1 TO ll_reprintcount
	ll_find			= dw_shipsheet.find("reprint = 1", ll_find + 1, ll_rowcount)
	ls_kbno = dw_shipsheet.getitemstring(ll_find, 'kbno')
	ls_divisioncode = dw_shipsheet.getitemstring(ll_find, 'divisioncode')
   dw_print.retrieve(is_areacode,ls_divisioncode,ls_kbno)
	IF wf_update_kbno(is_areacode,ls_divisioncode,ls_kbno) then
		IF dw_print.print()	= 1 then		
			lb_commit = true
		else
			lb_commit = false
			Exit
		end if
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
   messagebox('출력', ' 출력 중 문제가 발생하였습니다...')	
else
	Commit USING SQLPIS;
	SQLpis.AutoCommit	= True
end if

end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_shipsheet, FULL)

of_resize()

end event

event activate;call super::activate;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss310i
end type

type dw_shipsheet from u_vi_std_datawindow within w_piss310i
integer x = 14
integer y = 232
integer width = 3584
integer height = 1648
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss310i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;If GetRow() > 0 then
	SelectRow (0, false)
	SelectRow (currentrow, true)
	il_selectrow = currentrow
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

event clicked;call super::clicked;If Getrow() > 0 then 
	il_selectrow = row
	is_shipsheetno = dw_shipsheet.getitemstring(il_selectrow, 'shipsheetno')
	is_canceldate  = dw_shipsheet.getitemstring(il_selectrow, 'applydate')	
	is_cancel_divisioncode = dw_shipsheet.getitemstring(il_selectrow, 'divisoncode')	
END IF
end event

type uo_area from u_pisc_select_area within w_piss310i
event destroy ( )
integer x = 1321
integer y = 96
integer taborder = 60
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_shipsheet.reset()
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss310i
event destroy ( )
integer x = 1893
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_shipsheet.settransobject(SQLPIS)
dw_print.settransobject(SQLPIS)
is_divisioncode = is_uo_divisioncode
dw_shipsheet.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type cb_1 from commandbutton within w_piss310i
integer x = 2551
integer y = 64
integer width = 457
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출력"
end type

event clicked;PARENT.TRIGGEREVEnT('ue_print')
end event

type dw_print from datawindow within w_piss310i
boolean visible = false
integer x = 727
integer y = 820
integer width = 1358
integer height = 772
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss310i_02"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_date from u_pisc_date_applydate within w_piss310i
event destroy ( )
integer x = 55
integer y = 96
integer taborder = 70
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;if is_shipdate <> is_uo_date then
	dw_shipsheet.reset()
end if	
is_shipdate = is_uo_date

end event

type uo_1 from u_pisc_date_today_1 within w_piss310i
event destroy ( )
integer x = 791
integer y = 100
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_today_1::destroy
end on

event ue_select;call super::ue_select;if is_shipdate1 <> is_uo_date then
	dw_shipsheet.reset()
end if	
is_shipdate1 = is_uo_date

end event

type st_2 from statictext within w_piss310i
integer x = 736
integer y = 104
integer width = 55
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

type gb_1 from groupbox within w_piss310i
integer x = 23
integer y = 28
integer width = 2501
integer height = 172
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
borderstyle borderstyle = stylelowered!
end type

