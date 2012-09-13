$PBExportHeader$w_mpm330i.srw
$PBExportComments$공정현황표
forward
global type w_mpm330i from w_ipis_sheet01
end type
type dw_mpm330i_01 from u_vi_std_datawindow within w_mpm330i
end type
type uo_1 from u_mpms_select_orderno within w_mpm330i
end type
type dw_report from datawindow within w_mpm330i
end type
type gb_1 from groupbox within w_mpm330i
end type
end forward

global type w_mpm330i from w_ipis_sheet01
dw_mpm330i_01 dw_mpm330i_01
uo_1 uo_1
dw_report dw_report
gb_1 gb_1
end type
global w_mpm330i w_mpm330i

on w_mpm330i.create
int iCurrent
call super::create
this.dw_mpm330i_01=create dw_mpm330i_01
this.uo_1=create uo_1
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm330i_01
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.gb_1
end on

on w_mpm330i.destroy
call super::destroy
destroy(this.dw_mpm330i_01)
destroy(this.uo_1)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm330i_01.Width = newwidth - ( ls_gap * 2 )
dw_mpm330i_01.Height = newheight - ( dw_mpm330i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_mpm330i_01.settransobject(sqlmpms)
end event

event ue_retrieve;call super::ue_retrieve;dw_mpm330i_01.reset()

if dw_mpm330i_01.retrieve(uo_1.is_uo_orderno) < 1 then
	uo_status.st_message.text = "조회할 데이타가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string, ls_orderno

window 	l_to_open
str_easy l_str_prt

//if dw_mpm330i_01.rowcount() < 1 then
//	uo_status.st_message.text = "출력할 데이타가 없습니다."
//	return 0
//end if
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_mpm330i_01.sharedata(dw_report)

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm330i
end type

type dw_mpm330i_01 from u_vi_std_datawindow within w_mpm330i
integer x = 23
integer y = 200
integer width = 3319
integer height = 1652
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm330i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_1 from u_mpms_select_orderno within w_mpm330i
integer x = 50
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

type dw_report from datawindow within w_mpm330i
boolean visible = false
integer x = 2080
integer y = 48
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm330p_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm330i
integer x = 23
integer width = 1289
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

