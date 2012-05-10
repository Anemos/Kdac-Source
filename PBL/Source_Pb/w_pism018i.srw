$PBExportHeader$w_pism018i.srw
$PBExportComments$작업일보 작성 현황
forward
global type w_pism018i from w_pism_sheet03
end type
type dw_dailystatus from u_pism_dw within w_pism018i
end type
type rb_all from radiobutton within w_pism018i
end type
type rb_ok from radiobutton within w_pism018i
end type
type rb_notok from radiobutton within w_pism018i
end type
type rb_not from radiobutton within w_pism018i
end type
type cb_dailycreate from commandbutton within w_pism018i
end type
type gb_3 from groupbox within w_pism018i
end type
end forward

global type w_pism018i from w_pism_sheet03
integer width = 4471
dw_dailystatus dw_dailystatus
rb_all rb_all
rb_ok rb_ok
rb_notok rb_notok
rb_not rb_not
cb_dailycreate cb_dailycreate
gb_3 gb_3
end type
global w_pism018i w_pism018i

forward prototypes
public function integer wf_dailyfilter ()
end prototypes

public function integer wf_dailyfilter ();String ls_Filter 

If rb_all.Checked Then 
	ls_Filter = '' 
ElseIf rb_ok.Checked Then 
	ls_Filter = "dailystatus = '1'" 
ElseIf rb_notok.Checked Then 
	ls_Filter = "dailystatus = '0'" 
ElseIf rb_not.Checked Then 
	ls_Filter = "dailystatus = 'X'" 
End If 

dw_dailystatus.SetFilter(ls_Filter)
dw_dailystatus.Filter() 

Return 1
end function

event open;call super::open;wf_setRetCondition(STFROMTODATE) 

ib_wcallview = True 
cb_dailycreate.Enabled = False 

end event

on w_pism018i.create
int iCurrent
call super::create
this.dw_dailystatus=create dw_dailystatus
this.rb_all=create rb_all
this.rb_ok=create rb_ok
this.rb_notok=create rb_notok
this.rb_not=create rb_not
this.cb_dailycreate=create cb_dailycreate
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dailystatus
this.Control[iCurrent+2]=this.rb_all
this.Control[iCurrent+3]=this.rb_ok
this.Control[iCurrent+4]=this.rb_notok
this.Control[iCurrent+5]=this.rb_not
this.Control[iCurrent+6]=this.cb_dailycreate
this.Control[iCurrent+7]=this.gb_3
end on

on w_pism018i.destroy
call super::destroy
destroy(this.dw_dailystatus)
destroy(this.rb_all)
destroy(this.rb_ok)
destroy(this.rb_notok)
destroy(this.rb_not)
destroy(this.cb_dailycreate)
destroy(this.gb_3)
end on

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

dw_dailystatus.SetRedraw(False) 
f_pism_working_msg(istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내" + & 
						 uo_wc.is_uo_workcentername + " 조", dw_dailystatus.Title + "을 조회중입니다. 잠시만 기다려 주십시오.") 

dw_dailystatus.Reset(); dw_dailystatus.SetTransObject(SqlPIS); dw_dailystatus.SetFilter('') 
ll_ret = dw_dailystatus.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.from_date, istr_mh.to_date) 
If ll_ret > 0 Then wf_dailyFilter() 

If IsValid(w_pism_working) Then Close(w_pism_working) 
dw_dailystatus.SetRedraw(True); dw_dailystatus.Setfocus() 
end event

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_dailystatus, FULL)

of_resize()

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_dailystatus
lstr_prt.DataObject = 'd_pism018i_01_p' 
lstr_prt.title = istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내 " + dw_dailystatus.Title 
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" + & 
							 " " + uo_wc.is_uo_workcenterName + " 조'	"

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event ue_postopen;call super::ue_postopen;//This.TriggerEvent("ue_retrieve") 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism018i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism018i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism018i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism018i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism018i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism018i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism018i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism018i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism018i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism018i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism018i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism018i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism018i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism018i
end type

type dw_dailystatus from u_pism_dw within w_pism018i
integer x = 5
integer y = 280
integer width = 2578
integer height = 1308
integer taborder = 11
boolean bringtotop = true
string title = "작업일보 작성현황"
string dataobject = "d_pism018i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_wcName, ls_wDay, ls_dailystatus 

If currentrow <= 0 Then  
	cb_dailycreate.Text = "작업일보 작성 및 조회" 
	cb_dailycreate.Enabled = False 
Else
	ls_WCName = This.GetitemString(currentrow, "workcentername") 
	ls_wDay = This.GetItemString(currentrow, "workday") 
	ls_dailystatus = This.GetItemString(currentrow, "dailystatus") 
	cb_dailycreate.Text = ls_wcName + "조 " + ls_wDay + " 일자 작업일보 " 
	If ls_dailystatus = '0' or ls_dailystatus = '1' Then 
		cb_dailycreate.Text += "조회"
	Else
		cb_dailycreate.Text += "작성"
	End If 
	cb_dailycreate.Enabled = m_frame.m_action.m_save.Enabled 
End If 
end event

event retrieveend;call super::retrieveend;If rowcount > 0 Then 
	This.ScrollToRow(1); This.SelectRow(1, True)
End If 

end event

event doubleclicked;call super::doubleclicked;If This.GetRow() <= 0 Or Not cb_dailycreate.Enabled Then Return 
cb_dailycreate.TriggerEvent(Clicked!) 
end event

type rb_all from radiobutton within w_pism018i
integer x = 78
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "전체"
boolean checked = true
end type

type rb_ok from radiobutton within w_pism018i
integer x = 407
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "확정"
end type

type rb_notok from radiobutton within w_pism018i
integer x = 763
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "미확정"
end type

type rb_not from radiobutton within w_pism018i
integer x = 1184
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "미작성"
end type

type cb_dailycreate from commandbutton within w_pism018i
integer x = 1577
integer y = 184
integer width = 1509
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "작업일보 작성 및 조회"
end type

event clicked;str_pism_daily lstr_daily 
Long ll_getRow 
String ls_dailystatus 

If f_pism_MessageBox(Question!, 999, "화면 이동", cb_dailycreate.Text + " 하시겠습니까?") <> 1 Then Return 

lstr_daily.area = istr_mh.area
lstr_daily.div  = istr_mh.div 

ll_getRow = dw_dailystatus.Getrow() 
If ll_getRow <= 0 Then Return 
lstr_daily.wc   = dw_dailystatus.GetItemString(ll_getRow, "workcenter") 
lstr_daily.wday = dw_dailystatus.GetItemString(ll_getRow, "workday") 
ls_dailystatus = dw_dailystatus.GetItemString(ll_getRow, "dailystatus") 
If ls_dailystatus = 'X' Then 
	lstr_daily.longparm = 1		// 작성 
Else
	lstr_daily.longparm = 2		// 조회 
End If

if f_open_sheet('w_pism010u') = 0 then
	OpenSheetWithParm(w_pism010u, lstr_daily, w_frame, 0, Layered!) 
	If IsValid(w_pism010u) Then w_pism010u.Title = '작업일보작성'
Else
	w_frame.GetActiveSheet().Dynamic wf_selectDaily(lstr_daily) 
End If 

end event

type gb_3 from groupbox within w_pism018i
integer x = 9
integer y = 152
integer width = 1545
integer height = 116
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

