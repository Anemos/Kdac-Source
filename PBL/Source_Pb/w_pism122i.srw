$PBExportHeader$w_pism122i.srw
$PBExportComments$공장별 일별 생산실적/실투입MH 현황(일일경영지표)
forward
global type w_pism122i from w_pism_sheet02
end type
type dw_pism122i_01 from u_pism_dw within w_pism122i
end type
type dw_pism122i_02 from u_pism_dw within w_pism122i
end type
type st_1 from statictext within w_pism122i
end type
type pb_down1 from picturebutton within w_pism122i
end type
type pb_down2 from picturebutton within w_pism122i
end type
end forward

global type w_pism122i from w_pism_sheet02
integer width = 3767
integer height = 2412
dw_pism122i_01 dw_pism122i_01
dw_pism122i_02 dw_pism122i_02
st_1 st_1
pb_down1 pb_down1
pb_down2 pb_down2
end type
global w_pism122i w_pism122i

event open;call super::open;wf_setRetCondition(STMONTH)

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pism122i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_pism122i_01.Height= ( newheight * 3 / 5 ) - dw_pism122i_01.y

st_1.x = dw_pism122i_01.x
st_1.y = dw_pism122i_01.y + dw_pism122i_01.Height + ls_split

pb_down2.x = st_1.x + st_1.width + ls_status
pb_down2.y = st_1.y

dw_pism122i_02.x = st_1.x
dw_pism122i_02.y = st_1.y + st_1.Height + ls_split
dw_pism122i_02.Width = dw_pism122i_01.Width
dw_pism122i_02.Height = newheight - ( dw_pism122i_01.y + dw_pism122i_01.Height + ls_split + ls_status)

end event

event ue_print;call super::ue_print;//str_pism_prt lstr_prt		//출력조건
//
//lstr_prt.Transaction = SqlPIS 
//
//lstr_prt.datawindow = dw_manottime
//lstr_prt.DataObject = 'd_pism180i_01_rev1_p' 
//lstr_prt.title = uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  " + dw_manottime.Title 
//
//lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" + &
//						  "t_3.Text = '" + uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  인당 O/T 현황"  + "'" 
//
//OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(uo_div.is_uo_divisionname + "공장 ", dw_pism122i_01.Title + "(을)를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_pism122i_01.SetTransObject(SqlPIS)
dw_pism122i_02.SetTransObject(SqlPIS)
li_ret = dw_pism122i_01.Retrieve(istr_mh.area, istr_mh.div, uo_frMonth.is_uo_month) 
dw_pism122i_02.Retrieve(istr_mh.area, istr_mh.div, '%', uo_frMonth.is_uo_month)
If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", " 해당 기준월의 일별 생산실적이 존재하지 않습니다.")

dw_pism122i_01.SetFocus() 
end event

on w_pism122i.create
int iCurrent
call super::create
this.dw_pism122i_01=create dw_pism122i_01
this.dw_pism122i_02=create dw_pism122i_02
this.st_1=create st_1
this.pb_down1=create pb_down1
this.pb_down2=create pb_down2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pism122i_01
this.Control[iCurrent+2]=this.dw_pism122i_02
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_down1
this.Control[iCurrent+5]=this.pb_down2
end on

on w_pism122i.destroy
call super::destroy
destroy(this.dw_pism122i_01)
destroy(this.dw_pism122i_02)
destroy(this.st_1)
destroy(this.pb_down1)
destroy(this.pb_down2)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism122i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism122i
boolean visible = false
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism122i
boolean visible = false
integer x = 2043
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism122i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism122i
boolean visible = false
integer x = 1280
integer width = 667
integer height = 80
end type

type uo_month from w_pism_sheet02`uo_month within w_pism122i
boolean visible = false
integer x = 1285
integer y = 44
end type

type uo_year from w_pism_sheet02`uo_year within w_pism122i
boolean visible = false
integer x = 1289
integer y = 44
end type

type uo_date from w_pism_sheet02`uo_date within w_pism122i
boolean visible = false
integer x = 1275
integer y = 48
end type

type uo_area from w_pism_sheet02`uo_area within w_pism122i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism122i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism122i
integer x = 1294
integer y = 48
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism122i
boolean visible = false
integer x = 1925
integer y = 44
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism122i
integer x = 1262
integer width = 645
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism122i
boolean visible = false
integer x = 1280
integer y = 48
end type

type dw_pism122i_01 from u_pism_dw within w_pism122i
integer x = 18
integer y = 160
integer width = 3163
integer height = 812
integer taborder = 21
boolean bringtotop = true
string title = "일별 생산실적"
string dataobject = "d_pism122i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

event doubleclicked;call super::doubleclicked;string ls_workcenter
integer li_ret

ls_workcenter = this.getitemstring(row,"workcenter")
dw_pism122i_02.reset()

f_pism_working_msg(uo_div.is_uo_divisionname + "공장 ", dw_pism122i_02.Title + "(을)를 조회중입니다. 잠시만 기다려 주십시오.") 
li_ret = dw_pism122i_02.Retrieve(istr_mh.area, istr_mh.div, ls_workcenter, uo_frMonth.is_uo_month)
If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", " 해당 기준월의 일별 생산실적이 존재하지 않습니다.")

dw_pism122i_02.SetFocus() 
end event

type dw_pism122i_02 from u_pism_dw within w_pism122i
integer x = 18
integer y = 1084
integer width = 3163
integer height = 696
integer taborder = 31
boolean bringtotop = true
string title = "품목별 생산실적 LPI"
string dataobject = "d_pism122i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type st_1 from statictext within w_pism122i
integer x = 18
integer y = 996
integer width = 965
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16777215
long backcolor = 128
string text = "품목별 생산실적 LPI 내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_down1 from picturebutton within w_pism122i
integer x = 1952
integer y = 40
integer width = 229
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_pism122i_01)
end event

type pb_down2 from picturebutton within w_pism122i
integer x = 1019
integer y = 988
integer width = 229
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_pism122i_02)
end event

