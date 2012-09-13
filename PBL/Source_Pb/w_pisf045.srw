$PBExportHeader$w_pisf045.srw
$PBExportComments$최다 정비시간 장비
forward
global type w_pisf045 from w_cmms_sheet01
end type
type em_2 from editmask within w_pisf045
end type
type cb_2 from commandbutton within w_pisf045
end type
type cb_1 from commandbutton within w_pisf045
end type
type em_1 from editmask within w_pisf045
end type
type st_2 from statictext within w_pisf045
end type
type st_1 from statictext within w_pisf045
end type
type dw_1 from uo_datawindow within w_pisf045
end type
type uo_area from u_cmms_select_area within w_pisf045
end type
type uo_division from u_cmms_select_division within w_pisf045
end type
type pb_1 from picturebutton within w_pisf045
end type
type gb_1 from groupbox within w_pisf045
end type
end forward

global type w_pisf045 from w_cmms_sheet01
string title = "최다 정비시간 장비"
em_2 em_2
cb_2 cb_2
cb_1 cb_1
em_1 em_1
st_2 st_2
st_1 st_1
dw_1 dw_1
uo_area uo_area
uo_division uo_division
pb_1 pb_1
gb_1 gb_1
end type
global w_pisf045 w_pisf045

type variables
string is_sql
boolean ib_opened = false
end variables

on w_pisf045.create
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
this.pb_1=create pb_1
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
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_pisf045.destroy
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
destroy(this.pb_1)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_1.width= newwidth - 50
dw_1.height = newheight - 300
end event

event ue_retrieve;call super::ue_retrieve;string sql
long ll_rowcnt

if gs_kmDivision = 'R' then
	ll_rowcnt = dw_1.retrieve(gs_kmarea,gs_kmdivision,em_1.text,em_2.text, '2')
else
	ll_rowcnt = dw_1.retrieve(gs_kmarea,gs_kmdivision,em_1.text,em_2.text, '1')
end if

if ll_rowcnt > 0 then
	uo_status.st_message.text = "조회되었읍니다."
else
	uo_status.st_message.text = "조회할 자료가 없읍니다."
end if
end event

event ue_postopen;call super::ue_postopen;dw_1.settransobject(sqlcmms)

this.triggerevent('ue_retrieve')

end event

event open;call super::open;dw_1.settransobject(sqlcmms)
is_sql=dw_1.object.datawindow.table.select

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

dw_1.settransobject(sqlcmms)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf045
end type

type em_2 from editmask within w_pisf045
integer x = 2130
integer y = 56
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

type cb_2 from commandbutton within w_pisf045
integer x = 1934
integer y = 60
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

type cb_1 from commandbutton within w_pisf045
integer x = 2542
integer y = 60
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

type em_1 from editmask within w_pisf045
integer x = 1522
integer y = 56
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

type st_2 from statictext within w_pisf045
integer x = 2048
integer y = 72
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

type st_1 from statictext within w_pisf045
integer x = 1358
integer y = 72
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

type dw_1 from uo_datawindow within w_pisf045
integer x = 14
integer y = 192
integer width = 2519
integer height = 1392
integer taborder = 10
string dataobject = "d_report6"
boolean ib_select_row = false
end type

type uo_area from u_cmms_select_area within w_pisf045
integer x = 82
integer y = 64
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

type uo_division from u_cmms_select_division within w_pisf045
integer x = 690
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type pb_1 from picturebutton within w_pisf045
integer x = 3008
integer y = 36
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_1)
end event

type gb_1 from groupbox within w_pisf045
integer x = 18
integer width = 3534
integer height = 176
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

