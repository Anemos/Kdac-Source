$PBExportHeader$w_pism080i.srw
$PBExportComments$조내 품번별 LPI 및 작업효율 현황
forward
global type w_pism080i from w_pism_sheet03
end type
type dw_workrate from u_pism_dw within w_pism080i
end type
type tab_work from tab within w_pism080i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism080i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_lineworkrate from u_pism_dw within w_pism080i
end type
type dw_excel from datawindow within w_pism080i
end type
type pb_excel from picturebutton within w_pism080i
end type
end forward

global type w_pism080i from w_pism_sheet03
integer width = 4704
dw_workrate dw_workrate
tab_work tab_work
dw_lineworkrate dw_lineworkrate
dw_excel dw_excel
pb_excel pb_excel
end type
global w_pism080i w_pism080i

on w_pism080i.create
int iCurrent
call super::create
this.dw_workrate=create dw_workrate
this.tab_work=create tab_work
this.dw_lineworkrate=create dw_lineworkrate
this.dw_excel=create dw_excel
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_workrate
this.Control[iCurrent+2]=this.tab_work
this.Control[iCurrent+3]=this.dw_lineworkrate
this.Control[iCurrent+4]=this.dw_excel
this.Control[iCurrent+5]=this.pb_excel
end on

on w_pism080i.destroy
call super::destroy
destroy(this.dw_workrate)
destroy(this.tab_work)
destroy(this.dw_lineworkrate)
destroy(this.dw_excel)
destroy(this.pb_excel)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_allovereff, FULL)
//
//of_resize()

tab_work.Width = newwidth - ( tab_work.x + 10 ) 

dw_workrate.Width = newwidth - ( dw_workrate.x + 10 ) 
dw_workrate.Height = newheight - ( dw_workrate.y + uo_status.Height + 10 ) 

dw_lineworkrate.Width = dw_workrate.Width
dw_lineworkrate.Height = dw_workrate.Height 
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '년 ' + istr_mh.month + '월 ' + & 
						 uo_div.is_uo_divisionname + "공장 " + uo_wc.is_uo_workcentername + " 조", tab_work.Control[tab_work.SelectedTab].Text + "(을)를 조회중입니다. 잠시만 기다려 주십시오.") 

If tab_work.SelectedTab = 1 Then 
	dw_lineworkrate.SetTransObject(SqlPIS)
	li_ret = dw_lineworkrate.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_month.is_uo_month)  
Else
	dw_workrate.SetTransObject(SqlPIS)
	li_ret = dw_workrate.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_month.is_uo_month)  
	if li_Ret > 0 then
		dw_workrate.sharedata(dw_excel)
		pb_Excel.visible = true
	else
		pb_Excel.visible = false
	end if
End If 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년 ' + istr_mh.month + "월~n~n해당 기준월의 생산실적이 존재하지 않습니다.")

dw_workrate.SetFocus() 
end event

event open;call super::open;wf_setRetCondition(STMONTH)
ib_wcallview = True 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = dw_lineworkrate
	lstr_prt.DataObject = 'd_pism080i_01_p' 
	lstr_prt.title = istr_mh.year + '년 ' + istr_mh.month + '월 ' + uo_wc.is_uo_workcentername + " 조 " + dw_lineworkrate.Tag
Else
	lstr_prt.datawindow = dw_workrate
	lstr_prt.DataObject = 'd_pism080i_02_p' 
	lstr_prt.title = istr_mh.year + '년 ' + istr_mh.month + '월 ' + uo_wc.is_uo_workcentername + " 조 " + dw_workrate.Tag
	lstr_prt.prscale = '72'
End If

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

event ue_search;OpenWithParm(w_pism_finditem, dw_workrate) 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism080i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism080i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism080i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism080i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism080i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism080i
integer x = 2464
integer y = 148
integer width = 567
end type

type uo_month from w_pism_sheet03`uo_month within w_pism080i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism080i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism080i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism080i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism080i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism080i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism080i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism080i
end type

type dw_workrate from u_pism_dw within w_pism080i
string tag = "조내 품번별 LPI및 작업효율"
integer x = 9
integer y = 148
integer width = 3163
integer height = 1328
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism080i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type tab_work from tab within w_pism080i
integer x = 2962
integer y = 24
integer width = 1353
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;If newindex = 1 Then 
	dw_lineworkrate.Visible = True
	dw_workrate.Visible = False 
ElseIf newindex = 2 Then 
	dw_workrate.Visible = True 
	dw_lineworkrate.Visible = False 
End If 
	
end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 1317
integer height = -4
long backcolor = 12632256
string text = "라인별 작업효율"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 1317
integer height = -4
long backcolor = 12632256
string text = "라인내 품번별 상세조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_lineworkrate from u_pism_dw within w_pism080i
string tag = "조내 라인별 작업효율"
integer x = 9
integer y = 148
integer width = 1728
integer height = 1328
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pism080i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type dw_excel from datawindow within w_pism080i
boolean visible = false
integer x = 1006
integer y = 688
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pism080i_02_excel"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

type pb_excel from picturebutton within w_pism080i
boolean visible = false
integer x = 4466
integer y = 8
integer width = 155
integer height = 132
integer taborder = 30
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

event clicked;f_save_to_excel_execute(dw_excel,'1')

end event

