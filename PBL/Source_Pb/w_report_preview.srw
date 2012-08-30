$PBExportHeader$w_report_preview.srw
forward
global type w_report_preview from w_cmms_sheet01
end type
type ddlb_papersize from dropdownlistbox within w_report_preview
end type
type rb_3 from radiobutton within w_report_preview
end type
type rb_4 from radiobutton within w_report_preview
end type
type st_current_page from statictext within w_report_preview
end type
type em_zoom from editmask within w_report_preview
end type
type cbx_1 from checkbox within w_report_preview
end type
type st_1 from statictext within w_report_preview
end type
type gb_4 from groupbox within w_report_preview
end type
type gb_3 from groupbox within w_report_preview
end type
type gb_1 from groupbox within w_report_preview
end type
type dw_report from datawindow within w_report_preview
end type
end forward

global type w_report_preview from w_cmms_sheet01
string title = "미리보기"
event ue_preview_mode ( )
event ue_openwin ( )
ddlb_papersize ddlb_papersize
rb_3 rb_3
rb_4 rb_4
st_current_page st_current_page
em_zoom em_zoom
cbx_1 cbx_1
st_1 st_1
gb_4 gb_4
gb_3 gb_3
gb_1 gb_1
dw_report dw_report
end type
global w_report_preview w_report_preview

event ue_preview_mode();dw_report.object.datawindow.print.preview = 'yes'


end event

event ue_openwin();////w_main_frame.getactivesheet().TRIGGERevent('ue_openwin')
//string ls_empname, ls_original_sql
//
//if gs_check1='1' then
//	this.dw_report.dataobject = 'dr_mtbf'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve()
//elseif gs_check1='2' then
//	this.dw_report.dataobject = 'dr_stoptime_by_reason'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve(gd_from, gd_to)
//elseif gs_check1='3' then
//	this.dw_report.dataobject = 'dr_down_by_equiptype'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve(gd_from, gd_to)
//elseif gs_check1='4' then
//	choose case gs_check2
//		case '1'
//			this.dw_report.dataobject = 'dr_maint_cost_by_wono'
//		case '2'
//			this.dw_report.dataobject = 'dr_maint_cost_by_equiptype'
//		case '3'
//			this.dw_report.dataobject = 'dr_maint_cost_by_location'
//		case '4'
//			this.dw_report.dataobject = 'dr_maint_cost_by_equip'
//		case '5'
//			this.dw_report.dataobject = 'dr_maint_cost_by_worktype'
//	end choose
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve(gdttm_from, gdttm_to)
//elseif gs_check1='5' then
//	this.dw_report.dataobject = 'dr_wo_monthly_wotype_dg'
//	this.dw_report.SetTransObject(sqlcmms)
//
//	this.dw_report.Retrieve(gs_yyyymm)
//elseif gs_check1='6' then
//	
//	this.dw_report.dataobject = 'dr_wo_monthly'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve(gs_yyyymm)
//elseif gs_check1='7' then
//	this.dw_report.dataobject = 'dr_worktime_by_laborcode'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve(string(gdttm_from, 'yyyymmdd'), string(gdttm_to, 'yyyymmdd'))	
//elseif gs_check1='8' then
//	this.dw_report.dataobject = 'dr_ot_summary_by_emp'
//	this.dw_report.SetTransObject(sqlcmms)
//
//	select empname into :ls_empname from tmstemp where empcode = :gs_empcode_preview;
//	this.dw_report.Retrieve(string(gdttm_from, 'yyyymmdd'), string(gdttm_to, 'yyyymmdd'), gs_empcode_preview, ls_empname)	
//elseif gs_check1='9' then
//	this.dw_report.dataobject = 'dr_ot_summary_total'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve(string(gdttm_from, 'yyyymmdd'), string(gdttm_to, 'yyyymmdd'))	
//
//elseif gs_check1='10' then//위는 분석보고, 여기부터는 작업지시
//	this.dw_report.dataobject = 'dr_wo'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve()
//elseif gs_check1='11' then
//	this.dw_report.Dataobject = 'dr_wo'
//	this.dw_report.SetTransObject(sqlcmms)
//	ls_original_sql = this.dw_report.object.datawindow.table.select
//	this.dw_report.object.datawindow.table.select = ls_original_sql + ' ' + gs_where
//	this.dw_report.Retrieve()
//	this.triggerevent('ue_preview_mode')
//elseif gs_check1='12' then//위는 분석보고, 여기부터는 작업지시
//	this.dw_report.dataobject = 'dr_wo_history'
//	this.dw_report.SetTransObject(sqlcmms)
//	this.dw_report.Retrieve()
//elseif gs_check1='13' then
//	this.dw_report.Dataobject = 'dr_wo_history'
//	this.dw_report.SetTransObject(sqlcmms)
//	ls_original_sql = this.dw_report.object.datawindow.table.select
//	this.dw_report.object.datawindow.table.select = ls_original_sql + ' ' + gs_where
//	this.dw_report.Retrieve()
//	this.triggerevent('ue_preview_mode')
//end if
//int    li_page, li_page1
//
//	dw_report.scrollpriorpage()
//
//	li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
//	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
//	
//	st_current_page.text = string(li_page1) + '/' + string(li_page)
//this.TriggerEvent('ue_preview_mode')
//
end event

on w_report_preview.create
int iCurrent
call super::create
this.ddlb_papersize=create ddlb_papersize
this.rb_3=create rb_3
this.rb_4=create rb_4
this.st_current_page=create st_current_page
this.em_zoom=create em_zoom
this.cbx_1=create cbx_1
this.st_1=create st_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_papersize
this.Control[iCurrent+2]=this.rb_3
this.Control[iCurrent+3]=this.rb_4
this.Control[iCurrent+4]=this.st_current_page
this.Control[iCurrent+5]=this.em_zoom
this.Control[iCurrent+6]=this.cbx_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_report
end on

on w_report_preview.destroy
call super::destroy
destroy(this.ddlb_papersize)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.st_current_page)
destroy(this.em_zoom)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_report)
end on

event resize;call super::resize;dw_report.width = this.width - 50
dw_report.height = this.height - 455
end event

event ue_print;call super::ue_print;OpenWithParm(w_dw_print_setting, dw_report)
end event

event ue_first();///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the first page of the report 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row, li_page

dw_report.SetRedraw (false)

do 
	ll_row = dw_report.ScrollPriorPage()
loop until ll_row <= 1

dw_report.SetRedraw (true)

li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
st_current_page.text = "1" + '/' + string(li_page)

end event

event ue_prev();int    li_page, li_page1

	dw_report.scrollpriorpage()

	li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
	
	st_current_page.text = string(li_page1) + '/' + string(li_page)
end event

event ue_next();int    li_page, li_page1

	dw_report.scrollNextpage()

	li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
	
	st_current_page.text = string(li_page1) + '/' + string(li_page)
end event

event ue_last();///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the last page of the report 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row, ll_prev_row
int   li_page

	dw_report.SetRedraw (false)
	do 
		ll_prev_row = ll_row
		ll_row = dw_report.ScrollNextPage()
	loop until ll_row = ll_prev_row or ll_row <= 0

	dw_report.SetRedraw (True)

	
	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
	st_current_page.text = string(li_page) + '/' + string(li_page)

end event

event open;call super::open;int    li_page, li_page1

dw_report.scrollpriorpage()

li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))

st_current_page.text = string(li_page1) + '/' + string(li_page)

This.TriggerEvent('ue_preview_mode')

end event

type uo_status from w_cmms_sheet01`uo_status within w_report_preview
end type

type ddlb_papersize from dropdownlistbox within w_report_preview
integer x = 1147
integer y = 156
integer width = 256
integer height = 372
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"A4","B4","Letter"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_size

ls_size = Trim(this.text)

CHOOSE CASE ls_size
	CASE 'A4'
		dw_report.Modify("datawindow.Print.Paper.Size = 9 ")
	CASE 'B4'
		dw_report.Modify("datawindow.Print.Paper.Size = 12 ")
   CASE ELSE
		dw_report.Modify("datawindow.Print.Paper.Size = 1 ")
END CHOOSE
end event

type rb_3 from radiobutton within w_report_preview
integer x = 1499
integer y = 72
integer width = 347
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "가로방향"
end type

event clicked;int  li_page, li_page1

If This.Checked = True Then
	dw_report.object.datawindow.print.Orientation = 1
	
	li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
	
	st_current_page.text = string(li_page1) + '/' + string(li_page)
	
End if

end event

type rb_4 from radiobutton within w_report_preview
integer x = 1499
integer y = 160
integer width = 347
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "세로방향"
end type

event clicked;int  li_page, li_page1

If This.Checked = True Then
	dw_report.object.datawindow.print.Orientation = 2
	
	li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
	
	st_current_page.text = string(li_page1) + '/' + string(li_page)
		
End if
end event

type st_current_page from statictext within w_report_preview
integer x = 439
integer y = 120
integer width = 297
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 16711680
long backcolor = 80269524
boolean enabled = false
string text = "현재 페이지"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_zoom from editmask within w_report_preview
integer x = 82
integer y = 104
integer width = 247
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean autoskip = true
boolean spin = true
double increment = 10
string minmax = "50~~200"
end type

event constructor;this.text = '100'
end event

event modified;dw_report.modify('datawindow.zoom = ' + em_zoom.text)
end event

type cbx_1 from checkbox within w_report_preview
integer x = 869
integer y = 72
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "여백설정:"
boolean lefttext = true
end type

event clicked;if this.checked then
	dw_report.object.datawindow.print.preview.rulers = true
else
	dw_report.object.datawindow.print.preview.rulers = false
end if
end event

type st_1 from statictext within w_report_preview
integer x = 846
integer y = 176
integer width = 270
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "사이즈:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_report_preview
integer x = 791
integer y = 16
integer width = 1102
integer height = 240
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = " 용지 "
end type

type gb_3 from groupbox within w_report_preview
integer x = 398
integer y = 20
integer width = 384
integer height = 236
integer taborder = 130
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "현재 페이지"
end type

type gb_1 from groupbox within w_report_preview
integer x = 23
integer y = 20
integer width = 366
integer height = 236
integer taborder = 140
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = " Zoom "
end type

type dw_report from datawindow within w_report_preview
integer x = 18
integer y = 272
integer width = 3525
integer height = 1620
integer taborder = 40
string dataobject = "d_blank"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;f_show_dberror(sqldbcode)
return 1  // 1을 return 하면 시스템메시지가(파워필더가 내는) 나타나지 않는다.
end event

event scrollvertical;int    li_page, li_page1

	

	li_page1 = integer(dw_report.describe("evaluate('page()',1)"))
	li_page = integer(dw_report.describe("evaluate('pagecount()',1)"))
	
	parent.st_current_page.text = string(li_page1) + '/' + string(li_page)
end event

