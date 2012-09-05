$PBExportHeader$w_pism121i.srw
$PBExportComments$조내 일별 생산실적/실투입MH 현황
forward
global type w_pism121i from w_pism_sheet03
end type
type dw_realprod from u_pism_dw within w_pism121i
end type
type pb_excel from picturebutton within w_pism121i
end type
type cbx_1 from checkbox within w_pism121i
end type
type gb_3 from groupbox within w_pism121i
end type
end forward

global type w_pism121i from w_pism_sheet03
integer width = 4507
dw_realprod dw_realprod
pb_excel pb_excel
cbx_1 cbx_1
gb_3 gb_3
end type
global w_pism121i w_pism121i

on w_pism121i.create
int iCurrent
call super::create
this.dw_realprod=create dw_realprod
this.pb_excel=create pb_excel
this.cbx_1=create cbx_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_realprod
this.Control[iCurrent+2]=this.pb_excel
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.gb_3
end on

on w_pism121i.destroy
call super::destroy
destroy(this.dw_realprod)
destroy(this.pb_excel)
destroy(this.cbx_1)
destroy(this.gb_3)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_allovereff, FULL)
//
//of_resize()

dw_realprod.Width = newwidth - ( dw_realprod.x + 10 ) 
dw_realprod.Height = newheight - ( dw_realprod.y + uo_status.Height + 10 ) 
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '년 ' + istr_mh.month + '월 ' + & 
						 uo_div.is_uo_divisionname + "공장 " + uo_wc.is_uo_workcentername + " 조", dw_realprod.Tag + "를 조회중입니다. 잠시만 기다려 주십시오.") 
dw_realprod.SetTransObject(SqlPIS)
li_ret = dw_realprod.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_month.is_uo_month)  

If IsValid(w_pism_working) Then Close(w_pism_working)  
If li_ret = 0 Then 
	f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년 ' + istr_mh.month + "월~n~n해당 기준년도의 생산실적이 존재하지 않습니다.")
	pb_excel.enabled = false
	pb_excel.visible = false
else
	pb_excel.enabled = true
	pb_excel.visible = true
end if


dw_realprod.Setfocus() 
end event

event open;call super::open;pb_excel.enabled = false
pb_excel.visible = false
wf_setRetCondition(STMONTH)
ib_wcallview = True 
end event

event ue_print;call super::ue_print;//str_pism_prt lstr_prt		//출력조건
//
//lstr_prt.Transaction = SqlPIS 
//
//lstr_prt.datawindow = dw_realprod
//lstr_prt.DataObject = 'd_pism120i_01_p' 
//lstr_prt.title = istr_mh.year + '년 ' + istr_mh.month + '월 ' + uo_wc.is_uo_workcentername + " 조 " + dw_realprod.Tag
//
//lstr_prt.dwsyntax = "title.text = '" + istr_mh.year + '년 ' + istr_mh.month + '월 조내 일별 생산실적' + "'	t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
//						  " " + uo_wc.is_uo_workcenterName + " 조'" 
//
//OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

messagebox("확인","엑셀 다운로드만 가능합니다")
end event

event ue_search;OpenWithParm(w_pism_finditem, dw_realprod) 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism121i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism121i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism121i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism121i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism121i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism121i
integer x = 2464
integer y = 148
integer width = 567
end type

type uo_month from w_pism_sheet03`uo_month within w_pism121i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism121i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism121i
integer width = 663
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism121i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism121i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism121i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism121i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism121i
end type

type dw_realprod from u_pism_dw within w_pism121i
string tag = "조내 일별 생산실적"
integer x = 9
integer y = 148
integer width = 3163
integer height = 1328
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism121i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type pb_excel from picturebutton within w_pism121i
integer x = 4297
integer y = 24
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_realprod)
end event

type cbx_1 from checkbox within w_pism121i
integer x = 2971
integer y = 40
integer width = 576
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번별 상세정보"
end type

event clicked;if cbx_1.checked = false then
	dw_realprod.dataobject = 'd_pism121i_01'
else
	dw_realprod.dataobject = 'd_pism121i_01_rev1'
end if
end event

type gb_3 from groupbox within w_pism121i
integer x = 2939
integer y = 4
integer width = 622
integer height = 132
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

