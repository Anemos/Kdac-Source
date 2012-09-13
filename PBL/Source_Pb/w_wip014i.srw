$PBExportHeader$w_wip014i.srw
$PBExportComments$당월(-)재공조회
forward
global type w_wip014i from w_ipis_sheet01
end type
type dw_wip014i_01 from datawindow within w_wip014i
end type
type dw_wip014i_02 from datawindow within w_wip014i
end type
type pb_down from picturebutton within w_wip014i
end type
type gb_1 from groupbox within w_wip014i
end type
end forward

global type w_wip014i from w_ipis_sheet01
integer width = 3941
integer height = 2136
dw_wip014i_01 dw_wip014i_01
dw_wip014i_02 dw_wip014i_02
pb_down pb_down
gb_1 gb_1
end type
global w_wip014i w_wip014i

on w_wip014i.create
int iCurrent
call super::create
this.dw_wip014i_01=create dw_wip014i_01
this.dw_wip014i_02=create dw_wip014i_02
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_wip014i_01
this.Control[iCurrent+2]=this.dw_wip014i_02
this.Control[iCurrent+3]=this.pb_down
this.Control[iCurrent+4]=this.gb_1
end on

on w_wip014i.destroy
call super::destroy
destroy(this.dw_wip014i_01)
destroy(this.dw_wip014i_02)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_wip014i_02.Width = newwidth	- (ls_gap * 3)
dw_wip014i_02.Height= newheight - (dw_wip014i_02.y + ls_status)
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant, ls_dvsn, ls_iocd, ls_pdcd

dw_wip014i_02.reset()
ls_plant = dw_wip014i_01.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_wip014i_01.getitemstring(1, "wip001_wadvsn")
ls_iocd = dw_wip014i_01.getitemstring(1,"wip001_waiocd")
ls_pdcd = trim(dw_wip014i_01.getitemstring(1,"inv101_pdcd"))
if f_spacechk(ls_dvsn) = -1 then
	ls_dvsn = '%'
else
	ls_dvsn = ls_dvsn + '%'
end if
if f_spacechk(ls_pdcd) = -1 then
	ls_pdcd = '%'
else
	ls_pdcd = ls_pdcd + '%'
end if

if dw_wip014i_02.retrieve(g_s_company,ls_plant,ls_dvsn,ls_iocd,ls_pdcd) > 0 then
	uo_status.st_message.text = "조회되었습니다."
else
	uo_status.st_message.text = "조회할 자료가 없습니다."
end if

return 0
end event

event open;call super::open;datawindowchild dwc_01,dwc_02,dwc_03

dw_wip014i_02.settransobject(sqlca)

dw_wip014i_01.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_wip014i_01.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_wip014i_01.getchild("inv101_pdcd",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('A')

dw_wip014i_01.insertrow(0)
dw_wip014i_01.setitem(1,"wip001_waiocd",'1')
end event

type uo_status from w_ipis_sheet01`uo_status within w_wip014i
end type

type dw_wip014i_01 from datawindow within w_wip014i
integer x = 41
integer y = 36
integer width = 3543
integer height = 144
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip014i_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1,cdw_2

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF
end event

type dw_wip014i_02 from datawindow within w_wip014i
integer x = 23
integer y = 224
integer width = 3429
integer height = 1576
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip014i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_wip014i
integer x = 3634
integer y = 40
integer width = 201
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip014i_02.rowcount() > 0 then
	f_save_to_excel(dw_wip014i_02)
else
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if
end event

type gb_1 from groupbox within w_wip014i
integer x = 23
integer y = 4
integer width = 3854
integer height = 192
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

