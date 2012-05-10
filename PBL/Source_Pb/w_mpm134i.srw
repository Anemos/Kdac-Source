$PBExportHeader$w_mpm134i.srw
$PBExportComments$장비별 작업시간 집계
forward
global type w_mpm134i from w_ipis_sheet01
end type
type uo_from from u_mpms_date_applydate within w_mpm134i
end type
type uo_to from u_mpms_date_applydate_1 within w_mpm134i
end type
type st_1 from statictext within w_mpm134i
end type
type uo_1 from u_mpms_select_orderno within w_mpm134i
end type
type dw_mpm134i_01 from u_vi_std_datawindow within w_mpm134i
end type
type dw_mpm134i_02 from datawindow within w_mpm134i
end type
type dw_mpm134i_03 from datawindow within w_mpm134i
end type
type pb_exceldown from picturebutton within w_mpm134i
end type
type gb_1 from groupbox within w_mpm134i
end type
end forward

global type w_mpm134i from w_ipis_sheet01
uo_from uo_from
uo_to uo_to
st_1 st_1
uo_1 uo_1
dw_mpm134i_01 dw_mpm134i_01
dw_mpm134i_02 dw_mpm134i_02
dw_mpm134i_03 dw_mpm134i_03
pb_exceldown pb_exceldown
gb_1 gb_1
end type
global w_mpm134i w_mpm134i

type variables

end variables

on w_mpm134i.create
int iCurrent
call super::create
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_mpm134i_01=create dw_mpm134i_01
this.dw_mpm134i_02=create dw_mpm134i_02
this.dw_mpm134i_03=create dw_mpm134i_03
this.pb_exceldown=create pb_exceldown
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_from
this.Control[iCurrent+2]=this.uo_to
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.dw_mpm134i_01
this.Control[iCurrent+6]=this.dw_mpm134i_02
this.Control[iCurrent+7]=this.dw_mpm134i_03
this.Control[iCurrent+8]=this.pb_exceldown
this.Control[iCurrent+9]=this.gb_1
end on

on w_mpm134i.destroy
call super::destroy
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_mpm134i_01)
destroy(this.dw_mpm134i_02)
destroy(this.dw_mpm134i_03)
destroy(this.pb_exceldown)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_fromdt, ls_todt, ls_orderno

dw_mpm134i_01.reset()
dw_mpm134i_02.reset()
dw_mpm134i_03.reset()

ls_fromdt = string(uo_from.id_uo_date,"yyyymmdd")
ls_todt = string(uo_to.id_uo_date,"yyyymmdd")

ls_orderno = uo_1.is_uo_orderno

if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
end if

if dw_mpm134i_01.retrieve( ls_fromdt, ls_todt, ls_orderno ) < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if

dw_mpm134i_03.retrieve()
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm134i_01.Width = newwidth 	- ( ls_gap * 4 )
dw_mpm134i_01.Height= (newheight * 4 / 6) - (dw_mpm134i_01.y + ls_status) - 20

dw_mpm134i_02.x = dw_mpm134i_01.x
dw_mpm134i_02.y = dw_mpm134i_01.y + dw_mpm134i_01.Height + ls_gap
dw_mpm134i_02.Width = dw_mpm134i_01.Width
dw_mpm134i_02.Height = (newheight * 1 / 6) + 90

dw_mpm134i_03.x = dw_mpm134i_01.x
dw_mpm134i_03.y = dw_mpm134i_02.y + dw_mpm134i_02.Height + ls_gap
dw_mpm134i_03.Width = dw_mpm134i_02.Width
dw_mpm134i_03.Height = (newheight * 1 / 6) - 50
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_postopen;call super::ue_postopen;dw_mpm134i_01.settransobject(sqlmpms)
dw_mpm134i_02.settransobject(sqlmpms)
dw_mpm134i_03.settransobject(sqlmpms)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm134i
end type

type uo_from from u_mpms_date_applydate within w_mpm134i
integer x = 87
integer y = 52
integer taborder = 60
boolean bringtotop = true
end type

on uo_from.destroy
call u_mpms_date_applydate::destroy
end on

type uo_to from u_mpms_date_applydate_1 within w_mpm134i
integer x = 837
integer y = 52
integer taborder = 70
boolean bringtotop = true
end type

on uo_to.destroy
call u_mpms_date_applydate_1::destroy
end on

type st_1 from statictext within w_mpm134i
integer x = 773
integer y = 52
integer width = 55
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_1 from u_mpms_select_orderno within w_mpm134i
integer x = 1330
integer y = 32
integer taborder = 80
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

type dw_mpm134i_01 from u_vi_std_datawindow within w_mpm134i
integer x = 23
integer y = 160
integer width = 3118
integer height = 968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm134i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_fromdt, ls_todt, ls_orderno

dw_mpm134i_02.reset()
dw_mpm134i_02.dataobject = "d_mpm134i_02"
dw_mpm134i_02.settransobject(sqlmpms)

ls_fromdt = string(uo_from.id_uo_date,"yyyymmdd")
ls_todt = string(uo_to.id_uo_date,"yyyymmdd")

if dw_mpm134i_01.rowcount() < 3 or currentrow < 3 then
	return 0
end if
ls_orderno = dw_mpm134i_01.getitemstring(currentrow,'orderno')

dw_mpm134i_02.retrieve( ls_fromdt, ls_todt, ls_orderno )
end event

type dw_mpm134i_02 from datawindow within w_mpm134i
integer x = 23
integer y = 1168
integer width = 3122
integer height = 296
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm134i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mpm134i_03 from datawindow within w_mpm134i
integer x = 23
integer y = 1484
integer width = 3122
integer height = 376
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm134i_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_exceldown from picturebutton within w_mpm134i
integer x = 2688
integer y = 28
integer width = 155
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_mpm134i_01)
end event

type gb_1 from groupbox within w_mpm134i
integer x = 18
integer width = 2912
integer height = 152
integer taborder = 10
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

