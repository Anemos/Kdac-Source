$PBExportHeader$w_pism150i.srw
$PBExportComments$조별 부가작업/유휴/능률저하 공수 발생내역 & 비가동 WORST 현황
forward
global type w_pism150i from w_pism_sheet03
end type
type tab_work from tab within w_pism150i
end type
type tabpage_1 from userobject within tab_work
end type
type rb_mhcode from radiobutton within tabpage_1
end type
type rb_day from radiobutton within tabpage_1
end type
type cbx_wcorall from checkbox within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type ddlb_mhgubun from dropdownlistbox within tabpage_1
end type
type dw_submh from u_pism_dw within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type gb_5 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_work
rb_mhcode rb_mhcode
rb_day rb_day
cbx_wcorall cbx_wcorall
st_2 st_2
ddlb_mhgubun ddlb_mhgubun
dw_submh dw_submh
gb_3 gb_3
gb_5 gb_5
end type
type tabpage_2 from userobject within tab_work
end type
type dw_notoperation from u_pism_dw within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type rb_tpg2_wcmhgbn from radiobutton within tabpage_2
end type
type rb_tpg2_mhgbn from radiobutton within tabpage_2
end type
type rb_tpg2_wc from radiobutton within tabpage_2
end type
type rb_tpg2_all from radiobutton within tabpage_2
end type
type tabpage_2 from userobject within tab_work
dw_notoperation dw_notoperation
gb_4 gb_4
rb_tpg2_wcmhgbn rb_tpg2_wcmhgbn
rb_tpg2_mhgbn rb_tpg2_mhgbn
rb_tpg2_wc rb_tpg2_wc
rb_tpg2_all rb_tpg2_all
end type
type tabpage_3 from userobject within tab_work
end type
type dw_equip from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_work
dw_equip dw_equip
end type
type tab_work from tab within w_pism150i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_pism150i from w_pism_sheet03
integer width = 4471
tab_work tab_work
end type
global w_pism150i w_pism150i

type variables
String is_retCondition1 = '%', is_retCondition2 = '0' 
end variables

forward prototypes
public function string wf_colvisibechk ()
end prototypes

public function string wf_colvisibechk ();String ls_ModString 

If tab_work.tabpage_2.rb_tpg2_all.Checked Then 
	ls_ModString = "workcenternm.Visible = 0	mhgubun.Visible = 0"
//	tab_work.tabpage_2.dw_notoperation.Object.workcenternm.Visible = False
//	tab_work.tabpage_2.dw_notoperation.Object.mhgubun.Visible = False
End If 
	
If tab_work.tabpage_2.rb_tpg2_wc.Checked Then 
	ls_ModString = "workcenternm.Visible = 1	mhgubun.Visible = 0"
//	tab_work.tabpage_2.dw_notoperation.Object.workcenternm.Visible = True
//	tab_work.tabpage_2.dw_notoperation.Object.mhgubun.Visible = False
End If 

If tab_work.tabpage_2.rb_tpg2_mhgbn.Checked Then 
	ls_ModString = "workcenternm.Visible = 0	mhgubun.Visible = 1"

//	tab_work.tabpage_2.dw_notoperation.Object.workcenternm.Visible = False
//	tab_work.tabpage_2.dw_notoperation.Object.mhgubun.Visible = True 
End If 
	
If tab_work.tabpage_2.rb_tpg2_wcmhgbn.Checked Then 
	ls_ModString = "workcenternm.Visible = 1	mhgubun.Visible = 1"

//	tab_work.tabpage_2.dw_notoperation.Object.workcenternm.Visible = True 
//	tab_work.tabpage_2.dw_notoperation.Object.mhgubun.Visible = True 
End If 

Return ls_ModString 
end function

event open;call super::open;wf_setRetCondition(STFROMTODATE)  
ib_wcallview = True 
end event

on w_pism150i.create
int iCurrent
call super::create
this.tab_work=create tab_work
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
end on

on w_pism150i.destroy
call super::destroy
destroy(this.tab_work)
end on

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 ) 
tab_work.Height = newheight - ( tab_work.y + 100 ) 
end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

tab_work.control[tab_work.SelectedTab].SetRedraw(False)

f_pism_working_msg(istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내" + & 
						 uo_wc.is_uo_workcentername + " 조", tab_work.control[tab_work.SelectedTab].Tag + "를 조회중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
tab_work.control[tab_work.SelectedTab].SetRedraw(True)

//If ll_ret = 0 Then f_pism_messagebox(Information!, -1, "결과값 없음", istr_mh.From_Date + "∼" + istr_mh.To_Date + &
//																		 "~n~n해당 기간내의 발생공수가 존재하지 않습니다.")
tab_work.control[tab_work.SelectedTab].SetFocus()
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건
String ls_ModString 

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = tab_work.tabpage_1.dw_submh
	lstr_prt.DataObject = tab_work.tabpage_1.dw_submh.DataObject + '_p' 
ElseIF tab_work.SelectedTab = 2 Then 
	lstr_prt.datawindow = tab_work.tabpage_2.dw_notoperation
	lstr_prt.DataObject = 'd_pism150i_03_01_p' 
ElseIF tab_work.SelectedTab = 3 Then 
	lstr_prt.datawindow = tab_work.tabpage_3.dw_equip
	lstr_prt.DataObject = 'd_pism150i_01_04_p' 
End If 

lstr_prt.title = istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내" + tab_work.control[tab_work.SelectedTab].Tag 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'	" + & 
						  "t_frdate.Text = '" + istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내'" 
If ls_ModString <> '' Then lstr_prt.dwsyntax += "	" + ls_ModString 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event ue_postopen;call super::ue_postopen;f_populate_ddlb_from_tmhcode(tab_work.tabpage_1.ddlb_mhgubun)
end event

type uo_status from w_pism_sheet03`uo_status within w_pism150i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism150i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism150i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism150i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism150i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism150i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism150i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism150i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism150i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism150i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism150i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism150i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism150i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism150i
end type

type tab_work from tab within w_pism150i
event resize pbm_size
event type integer ue_retrieve ( integer ai_selectedtab )
integer x = 5
integer y = 152
integer width = 3397
integer height = 1512
integer taborder = 30
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
tabpage_3 tabpage_3
end type

event resize;tabpage_1.dw_submh.Width 	= newwidth 	- ( tabpage_1.dw_submh.x + 40 )
tabpage_1.dw_submh.Height 	= newheight - ( tabpage_1.dw_submh.y + 120 )

tabpage_2.dw_notoperation.Width 	= newwidth 	- ( tabpage_2.dw_notoperation.x + 40 ) 
tabpage_2.dw_notoperation.Height = newheight - ( tabpage_2.dw_notoperation.y + 120 ) 

tabpage_3.dw_equip.Width  = newwidth  - ( tabpage_3.dw_equip.x + 40 ) 
tabpage_3.dw_equip.Height = newheight - ( tabpage_3.dw_equip.y + 120 ) 


end event

event type integer ue_retrieve(integer ai_selectedtab);Long ll_ret 
String ls_DataObject 

If ai_selectedTab = 1 Then 
	tabpage_1.dw_submh.SetRedraw(False) 
	
	If tabpage_1.cbx_wcorall.Checked Then 
		If tabpage_1.rb_day.Checked Then 
			ls_DataObject = 'd_pism150i_01_01'
		Else
			ls_DataObject = 'd_pism150i_01_02'
		End If 
	Else
		If tabpage_1.rb_day.Checked Then 
			ls_DataObject = 'd_pism150i_02_01'
		Else
			ls_DataObject = 'd_pism150i_02_02'
		End If 
	End If 
	If tabpage_1.dw_submh.DataObject <> ls_DataObject Then tabpage_1.dw_submh.DataObject = ls_DataObject 
	tabpage_1.dw_submh.SetTransObject(SqlPIS)
	ll_ret = tabpage_1.dw_submh.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.From_date, istr_mh.To_date, is_retcondition1) 
	tabpage_1.dw_submh.SetRedraw(True) 
	Return ll_ret
ElseIf ai_selectedtab = 2 then
	
	If tabpage_2.rb_tpg2_all.Checked Then 
		tabpage_2.dw_notoperation.DataObject = 'd_pism150i_03_01'
	ElseIf tabpage_2.rb_tpg2_wc.Checked Then 
		tabpage_2.dw_notoperation.DataObject = 'd_pism150i_03_02'
	ElseIf tabpage_2.rb_tpg2_mhgbn.Checked Then 
		tabpage_2.dw_notoperation.DataObject = 'd_pism150i_03_03'
	ElseIf tabpage_2.rb_tpg2_wcmhgbn.Checked Then 
		tabpage_2.dw_notoperation.DataObject = 'd_pism150i_03_04'
	End If 
	tabpage_2.dw_notoperation.SetTransObject(SqlPIS) 
	// 조건별 조회 Default = '0' 차후 체크버튼으로 조정가능토록 
	Return tabpage_2.dw_notoperation.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.From_date, istr_mh.To_date, is_retcondition2) 
ElseIf ai_selectedtab = 3 then	
	tabpage_3.dw_equip.SetTransObject(SqlPIS) 	
	Return tabpage_3.dw_equip.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.From_date, istr_mh.To_date )
End If 

Return 0 
end event

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_work
string tag = "부가작업/유휴/능률저하 발생내역"
integer x = 18
integer y = 100
integer width = 3360
integer height = 1396
long backcolor = 12632256
string text = "부가작업/유휴/능률저하 발생내역"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
rb_mhcode rb_mhcode
rb_day rb_day
cbx_wcorall cbx_wcorall
st_2 st_2
ddlb_mhgubun ddlb_mhgubun
dw_submh dw_submh
gb_3 gb_3
gb_5 gb_5
end type

on tabpage_1.create
this.rb_mhcode=create rb_mhcode
this.rb_day=create rb_day
this.cbx_wcorall=create cbx_wcorall
this.st_2=create st_2
this.ddlb_mhgubun=create ddlb_mhgubun
this.dw_submh=create dw_submh
this.gb_3=create gb_3
this.gb_5=create gb_5
this.Control[]={this.rb_mhcode,&
this.rb_day,&
this.cbx_wcorall,&
this.st_2,&
this.ddlb_mhgubun,&
this.dw_submh,&
this.gb_3,&
this.gb_5}
end on

on tabpage_1.destroy
destroy(this.rb_mhcode)
destroy(this.rb_day)
destroy(this.cbx_wcorall)
destroy(this.st_2)
destroy(this.ddlb_mhgubun)
destroy(this.dw_submh)
destroy(this.gb_3)
destroy(this.gb_5)
end on

type rb_mhcode from radiobutton within tabpage_1
integer x = 2085
integer y = 76
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공수항목별"
end type

type rb_day from radiobutton within tabpage_1
integer x = 1714
integer y = 76
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "일자별"
boolean checked = true
end type

type cbx_wcorall from checkbox within tabpage_1
integer x = 46
integer y = 76
integer width = 265
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조별"
end type

type st_2 from statictext within tabpage_1
integer x = 366
integer y = 80
integer width = 219
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "구분 :"
boolean focusrectangle = false
end type

type ddlb_mhgubun from dropdownlistbox within tabpage_1
integer x = 608
integer y = 64
integer width = 969
integer height = 472
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_retCondition1 = trim(mid(text,1,2)) + '%'
end event

event constructor;is_retCondition1 = trim(mid(text,1,2)) + '%'
end event

event getfocus;is_retCondition1 = trim(mid(text,1,2)) + '%'
end event

type dw_submh from u_pism_dw within tabpage_1
string tag = "부가작업/유휴/능률저하 발생내역"
integer y = 168
integer width = 3333
integer height = 1020
integer taborder = 11
string dataobject = "d_pism150i_01_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

event retrieveend;call super::retrieveend;//This.Modify("gr_row1.Width = 0")
//This.Modify("gr_row2.Width = 0")
end event

type gb_3 from groupbox within tabpage_1
integer x = 1623
integer y = 28
integer width = 974
integer height = 128
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_5 from groupbox within tabpage_1
integer x = 9
integer y = 28
integer width = 1600
integer height = 128
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type tabpage_2 from userobject within tab_work
string tag = "비가동WORST"
integer x = 18
integer y = 100
integer width = 3360
integer height = 1396
long backcolor = 12632256
string text = "비가동WORST"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_notoperation dw_notoperation
gb_4 gb_4
rb_tpg2_wcmhgbn rb_tpg2_wcmhgbn
rb_tpg2_mhgbn rb_tpg2_mhgbn
rb_tpg2_wc rb_tpg2_wc
rb_tpg2_all rb_tpg2_all
end type

on tabpage_2.create
this.dw_notoperation=create dw_notoperation
this.gb_4=create gb_4
this.rb_tpg2_wcmhgbn=create rb_tpg2_wcmhgbn
this.rb_tpg2_mhgbn=create rb_tpg2_mhgbn
this.rb_tpg2_wc=create rb_tpg2_wc
this.rb_tpg2_all=create rb_tpg2_all
this.Control[]={this.dw_notoperation,&
this.gb_4,&
this.rb_tpg2_wcmhgbn,&
this.rb_tpg2_mhgbn,&
this.rb_tpg2_wc,&
this.rb_tpg2_all}
end on

on tabpage_2.destroy
destroy(this.dw_notoperation)
destroy(this.gb_4)
destroy(this.rb_tpg2_wcmhgbn)
destroy(this.rb_tpg2_mhgbn)
destroy(this.rb_tpg2_wc)
destroy(this.rb_tpg2_all)
end on

type dw_notoperation from u_pism_dw within tabpage_2
integer y = 168
integer width = 3296
integer height = 972
integer taborder = 11
string dataobject = "d_pism150i_03"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

type gb_4 from groupbox within tabpage_2
integer x = 5
integer y = 4
integer width = 1874
integer height = 152
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_tpg2_wcmhgbn from radiobutton within tabpage_2
integer x = 1198
integer y = 72
integer width = 667
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조별 + 공수구분별"
end type

event clicked;is_retCondition2 = '3' 
end event

type rb_tpg2_mhgbn from radiobutton within tabpage_2
integer x = 699
integer y = 72
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공수구분별"
end type

event clicked;is_retCondition2 = '2' 
end event

type rb_tpg2_wc from radiobutton within tabpage_2
integer x = 375
integer y = 72
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조별"
end type

event clicked;is_retCondition2 = '1' 
end event

type rb_tpg2_all from radiobutton within tabpage_2
integer x = 50
integer y = 72
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "전체"
boolean checked = true
end type

event clicked;is_retCondition2 = '0' 
end event

type tabpage_3 from userobject within tab_work
string tag = "장비 현황"
integer x = 18
integer y = 100
integer width = 3360
integer height = 1396
long backcolor = 12632256
string text = "장비 현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_equip dw_equip
end type

on tabpage_3.create
this.dw_equip=create dw_equip
this.Control[]={this.dw_equip}
end on

on tabpage_3.destroy
destroy(this.dw_equip)
end on

type dw_equip from datawindow within tabpage_3
integer x = 9
integer y = 16
integer width = 3323
integer height = 1352
integer taborder = 70
string title = "none"
string dataobject = "d_pism150i_01_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer i
string  ls_equipname,ls_workcenter,ls_area,ls_div,ls_equipcode
f_cmms_set_server_ipis(istr_mh.area,istr_mh.div)
for i = 1 to rowcount
	ls_workcenter 		= this.object.workcenter[i]
	ls_area			 	= this.object.areacode[i]
	ls_div	 		   = this.object.divisioncode[i]	
	ls_equipcode	   = this.object.equipcode[i]	
	select equip_name into :ls_equipname from equip_master
		WHERE ( equip_master.cc_code = :ls_workcenter ) And
			( equip_master.area_code = :ls_area ) AND  
         ( equip_master.factory_code = :ls_div ) AND  
			( equip_master.equip_code = :ls_equipcode ) 
//			AND  
//       (( equip_master.equip_div_code = '1' ) OR  
//       ( equip_master.equip_div_code = '2' )   )
	using sqlcmms ;
	this.object.equipname[i] = ls_equipname
next
end event

