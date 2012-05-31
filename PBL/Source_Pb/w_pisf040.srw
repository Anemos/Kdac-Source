$PBExportHeader$w_pisf040.srw
$PBExportComments$작업이력보고서
forward
global type w_pisf040 from w_cmms_sheet01
end type
type em_2 from editmask within w_pisf040
end type
type cb_2 from commandbutton within w_pisf040
end type
type cb_1 from commandbutton within w_pisf040
end type
type em_1 from editmask within w_pisf040
end type
type st_2 from statictext within w_pisf040
end type
type st_1 from statictext within w_pisf040
end type
type dw_1 from uo_datawindow within w_pisf040
end type
type uo_area from u_cmms_select_area within w_pisf040
end type
type uo_division from u_cmms_select_division within w_pisf040
end type
type cbx_gubun from checkbox within w_pisf040
end type
type pb_down from picturebutton within w_pisf040
end type
type dw_condition from datawindow within w_pisf040
end type
type gb_1 from groupbox within w_pisf040
end type
end forward

global type w_pisf040 from w_cmms_sheet01
integer width = 4722
string title = "작업이력"
em_2 em_2
cb_2 cb_2
cb_1 cb_1
em_1 em_1
st_2 st_2
st_1 st_1
dw_1 dw_1
uo_area uo_area
uo_division uo_division
cbx_gubun cbx_gubun
pb_down pb_down
dw_condition dw_condition
gb_1 gb_1
end type
global w_pisf040 w_pisf040

type variables
boolean ib_opened = false
end variables

on w_pisf040.create
int iCurrent
call super::create
this.em_2=create em_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cbx_gubun=create cbx_gubun
this.pb_down=create pb_down
this.dw_condition=create dw_condition
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.uo_area
this.Control[iCurrent+9]=this.uo_division
this.Control[iCurrent+10]=this.cbx_gubun
this.Control[iCurrent+11]=this.pb_down
this.Control[iCurrent+12]=this.dw_condition
this.Control[iCurrent+13]=this.gb_1
end on

on w_pisf040.destroy
call super::destroy
destroy(this.em_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cbx_gubun)
destroy(this.pb_down)
destroy(this.dw_condition)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_1.width= newwidth - 50
dw_1.height = newheight - 420
end event

event ue_retrieve;call super::ue_retrieve;string sql, ls_sql
String ls_equipcode, ls_wo_div, ls_linecode
long ll_rowcnt

if cbx_gubun.checked = false then
	dw_1.dataobject = 'd_wo_report'
	dw_1.settransobject(sqlcmms)
else
	dw_1.dataobject = 'd_wo_report1'
	dw_1.settransobject(sqlcmms)
end if

dw_condition.AcceptText()
ls_equipcode = dw_condition.GetItemString(dw_condition.getrow(), 'equip_code')
if IsNull(ls_equipcode) or ls_equipcode = '' then 
	ls_equipcode = '%'
else
	ls_equipcode = ls_equipcode
end if

ls_wo_div = dw_condition.GetItemString(dw_condition.getrow(), 'wo_div_code')
if IsNull(ls_wo_div) or ls_wo_div = '' then 
	ls_wo_div = '%'
else 
	ls_wo_div = ls_wo_div
end if

ls_linecode = dw_condition.GetItemString(dw_condition.getrow(), 'line_code')
if IsNull(ls_linecode) or ls_linecode = '' then 
	ls_linecode = '%'
else 
	ls_linecode = ls_linecode
end if

ll_rowcnt = dw_1.retrieve(gs_kmarea,gs_kmdivision,em_1.text,em_2.text, ls_equipcode, ls_wo_div, ls_linecode)
if ll_rowcnt > 0 then
	uo_status.st_message.text = "조회되었읍니다."
else
	uo_status.st_message.text = "조회할 자료가 없읍니다."
end if

return 0

end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_condition.settransobject(sqlcmms)

dw_condition.GetChild('equip_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_condition.GetChild('equip_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(dw_condition, 'equip_code', ldwc, 'equip_name', 10)

dw_condition.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(dw_condition, 'wo_div_code', ldwc, 'wo_div_name', 10)

dw_condition.GetChild('line_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(dw_condition, 'line_code', ldwc, 'line_name', 10)

dw_condition.insertrow(0)
this.triggerevent('ue_retrieve')
end event

event open;call super::open;dw_1.settransobject(sqlcmms)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  false,  false,  false, false, false, false)
end event

event activate;call super::activate;if ib_opened then
	if uo_area.is_uo_areacode <> gs_kmarea then
		uo_area.is_uo_areacode = gs_kmarea
		uo_area.dw_1.setitem(1,"DDDWCode",gs_kmarea)
		uo_area.triggerevent('ue_select')
	end if
	uo_division.is_uo_divisioncode = gs_kmdivision
	uo_division.dw_1.setitem(1,"DDDWCode",gs_kmdivision)
end if
ib_opened = true

dw_condition.settransobject(sqlcmms)
dw_1.settransobject(sqlcmms)

return 0
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf040
end type

type em_2 from editmask within w_pisf040
integer x = 1865
integer y = 64
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean spin = true
end type

event constructor;this.text= string(g_s_date,"@@@@-@@-@@")
end event

type cb_2 from commandbutton within w_pisf040
integer x = 1723
integer y = 68
integer width = 87
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "▽"
end type

event clicked;str_xy str_lxy
string ls_return_dt
str_lxy.lx = iw_This.PointerX()
str_lxy.ly = iw_This.PointerY() + 350
openwithparm(w_today,str_lxy)
If isnull(message.Stringparm) Or message.Stringparm = '' then
	return
Else
	ls_return_dt = Message.StringParm   // powerobject
End If	
em_1.text = ls_return_dt
parent.triggerevent('ue_retrieve')
end event

type cb_1 from commandbutton within w_pisf040
integer x = 2277
integer y = 64
integer width = 87
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "▽"
end type

event clicked;str_xy str_lxy
string ls_return_dt
str_lxy.lx = iw_This.PointerX()
str_lxy.ly = iw_This.PointerY() + 350
openwithparm(w_today,str_lxy)
If isnull(message.Stringparm) Or message.Stringparm = '' then
	return
Else
	ls_return_dt = Message.StringParm   // powerobject
End If	
em_2.text = ls_return_dt
parent.triggerevent('ue_retrieve')
end event

type em_1 from editmask within w_pisf040
integer x = 1312
integer y = 64
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean spin = true
end type

event constructor;this.text= string(g_s_date,"@@@@-@@-@@")
end event

type st_2 from statictext within w_pisf040
integer x = 1819
integer y = 64
integer width = 82
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisf040
integer x = 1175
integer y = 76
integer width = 160
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "기간:"
boolean focusrectangle = false
end type

type dw_1 from uo_datawindow within w_pisf040
integer x = 23
integer y = 304
integer width = 2519
integer height = 1556
integer taborder = 10
string dataobject = "d_wo_report"
boolean ib_select_row = false
end type

type uo_area from u_cmms_select_area within w_pisf040
integer x = 78
integer y = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_cmms_select_area::destroy
end on

event ue_select;call super::ue_select;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

uo_division.triggerevent('ue_select')
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode

if f_spacechk(gs_kmdivision) = -1 then
	ls_divisioncode = '%'
else
	ls_divisioncode = gs_kmdivision
end if
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,ls_divisioncode,false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

type uo_division from u_cmms_select_division within w_pisf040
integer x = 576
integer y = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type cbx_gubun from checkbox within w_pisf040
integer x = 2496
integer y = 68
integer width = 649
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "작명번호별 인원제외"
end type

event clicked;if cbx_gubun.checked = false then
	dw_1.dataobject = 'd_wo_report'
	dw_1.settransobject(sqlcmms)
else
	dw_1.dataobject = 'd_wo_report1'
	dw_1.settransobject(sqlcmms)
end if
end event

type pb_down from picturebutton within w_pisf040
integer x = 3511
integer y = 52
integer width = 155
integer height = 120
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_1)
end event

type dw_condition from datawindow within w_pisf040
integer x = 46
integer y = 176
integer width = 3410
integer height = 88
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_wo_con"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_pisf040
integer x = 27
integer width = 3666
integer height = 296
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

