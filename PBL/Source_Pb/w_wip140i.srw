$PBExportHeader$w_wip140i.srw
$PBExportComments$재공 단가미정품 조회(전사)
forward
global type w_wip140i from w_ipis_sheet01
end type
type dw_wip140i_01 from u_vi_std_datawindow within w_wip140i
end type
type pb_down from picturebutton within w_wip140i
end type
type uo_1 from uo_comm_yymm within w_wip140i
end type
type gb_1 from groupbox within w_wip140i
end type
end forward

global type w_wip140i from w_ipis_sheet01
integer width = 3950
integer height = 2932
string title = "미단가 재공품목 조회"
dw_wip140i_01 dw_wip140i_01
pb_down pb_down
uo_1 uo_1
gb_1 gb_1
end type
global w_wip140i w_wip140i

on w_wip140i.create
int iCurrent
call super::create
this.dw_wip140i_01=create dw_wip140i_01
this.pb_down=create pb_down
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_wip140i_01
this.Control[iCurrent+2]=this.pb_down
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_wip140i.destroy
call super::destroy
destroy(this.dw_wip140i_01)
destroy(this.pb_down)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_applyyear, ls_applymonth, ls_applydate, ls_lastdate

ls_applyyear = mid(string(uo_1.uf_yyyymm()),1,4)
ls_applymonth = mid(string(uo_1.uf_yyyymm()),5,2)

dw_wip140i_01.reset()
if dw_wip140i_01.retrieve(g_s_company,ls_applyyear, ls_applymonth) < 1 then
	uo_status.st_message.text = "조회된 미단가 품목이 없습니다."
else
	uo_status.st_message.text = "미단가 재공품목이 조회되었습니다."
end if

return 0
end event

event ue_postopen;call super::ue_postopen;string ls_lastmonth

dw_wip140i_01.settransobject(sqlca)

ls_lastmonth = f_relative_month(g_s_date,-1)
uo_1.uf_reset(integer(mid(ls_lastmonth,1,4)), integer(mid(ls_lastmonth,5,2)) )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_wip140i_01.Width = newwidth - ls_status + 40
dw_wip140i_01.Height= newheight - (dw_wip140i_01.y + ls_status)

end event

type uo_status from w_ipis_sheet01`uo_status within w_wip140i
end type

type dw_wip140i_01 from u_vi_std_datawindow within w_wip140i
integer x = 23
integer y = 256
integer width = 3383
integer height = 1556
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip140i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type pb_down from picturebutton within w_wip140i
integer x = 768
integer y = 60
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip140i_01.rowcount() > 1 then
	f_save_to_excel_number(dw_wip140i_01)
end if
end event

type uo_1 from uo_comm_yymm within w_wip140i
event destroy ( )
integer x = 114
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_comm_yymm::destroy
end on

type gb_1 from groupbox within w_wip140i
integer x = 18
integer width = 1038
integer height = 232
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

