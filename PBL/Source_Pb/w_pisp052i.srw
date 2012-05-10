$PBExportHeader$w_pisp052i.srw
$PBExportComments$DDRS 현황
forward
global type w_pisp052i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp052i
end type
type uo_area from u_pisc_select_area within w_pisp052i
end type
type uo_division from u_pisc_select_division within w_pisp052i
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisp052i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisp052i
end type
type uo_date from u_pisc_date_applydate within w_pisp052i
end type
type dw_print from datawindow within w_pisp052i
end type
type gb_1 from groupbox within w_pisp052i
end type
type gb_2 from groupbox within w_pisp052i
end type
type gb_3 from groupbox within w_pisp052i
end type
end forward

global type w_pisp052i from w_ipis_sheet01
integer width = 4613
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
uo_date uo_date
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisp052i w_pisp052i

type variables
Boolean	ib_open
String	is_plandate[15]
end variables

forward prototypes
public subroutine wf_set_date ()
end prototypes

public subroutine wf_set_date ();String	ls_mod

is_plandate[1]		= ""
is_plandate[2]		= ""
is_plandate[3]		= ""
is_plandate[4]		= ""
is_plandate[5]		= ""
is_plandate[6]		= ""
is_plandate[7]		= ""
is_plandate[8]		= ""
is_plandate[9]		= ""
is_plandate[10]	= ""
is_plandate[11]	= ""
is_plandate[12]	= ""
is_plandate[13]	= ""
is_plandate[14]	= ""
is_plandate[15]	= ""

is_plandate[1]		= uo_date.is_uo_date
is_plandate[2]		= String(Relativedate(Date(is_plandate[1]), 1), "YYYY.MM.DD")
is_plandate[3]		= String(Relativedate(Date(is_plandate[2]), 1), "YYYY.MM.DD")
is_plandate[4]		= String(Relativedate(Date(is_plandate[3]), 1), "YYYY.MM.DD")
is_plandate[5]		= String(Relativedate(Date(is_plandate[4]), 1), "YYYY.MM.DD")
is_plandate[6]		= String(Relativedate(Date(is_plandate[5]), 1), "YYYY.MM.DD")
is_plandate[7]		= String(Relativedate(Date(is_plandate[6]), 1), "YYYY.MM.DD")
is_plandate[8]		= String(Relativedate(Date(is_plandate[7]), 1), "YYYY.MM.DD")
is_plandate[9]		= String(Relativedate(Date(is_plandate[8]), 1), "YYYY.MM.DD")
is_plandate[10]	= String(Relativedate(Date(is_plandate[9]), 1), "YYYY.MM.DD")
is_plandate[11]	= String(Relativedate(Date(is_plandate[10]), 1), "YYYY.MM.DD")
is_plandate[12]	= String(Relativedate(Date(is_plandate[11]), 1), "YYYY.MM.DD")
is_plandate[13]	= String(Relativedate(Date(is_plandate[12]), 1), "YYYY.MM.DD")
is_plandate[14]	= String(Relativedate(Date(is_plandate[13]), 1), "YYYY.MM.DD")
is_plandate[15]	= String(Relativedate(Date(is_plandate[14]), 1), "YYYY.MM.DD")

ls_mod	= "changeqty01_t.Text = '" + "~r~n" + Right(is_plandate[1], 5) + "'" + &
				"changeqty02_t.Text = '" + "~r~n" + Right(is_plandate[2], 5) + "'" + &
				"changeqty03_t.Text = '" + "~r~n" + Right(is_plandate[3], 5) + "'" + &
				"changeqty04_t.Text = '" + "~r~n" + Right(is_plandate[4], 5) + "'" + &
				"changeqty05_t.Text = '" + "~r~n" + Right(is_plandate[5], 5) + "'" + &
				"changeqty06_t.Text = '" + "~r~n" + Right(is_plandate[6], 5) + "'" + &
				"changeqty07_t.Text = '" + "~r~n" + Right(is_plandate[7], 5) + "'" + &
				"changeqty08_t.Text = '" + "~r~n" + Right(is_plandate[8], 5) + "'" + &
				"changeqty09_t.Text = '" + "~r~n" + Right(is_plandate[9], 5) + "'" + &
				"changeqty10_t.Text = '" + "~r~n" + Right(is_plandate[10], 5) + "'" + &
				"changeqty11_t.Text = '" + "~r~n" + Right(is_plandate[11], 5) + "'" + &
				"changeqty12_t.Text = '" + "~r~n" + Right(is_plandate[12], 5) + "'" + &
				"changeqty13_t.Text = '" + "~r~n" + Right(is_plandate[13], 5) + "'" + &
				"changeqty14_t.Text = '" + "~r~n" + Right(is_plandate[14], 5) + "'" + &
				"changeqty15_t.Text = '" + "~r~n" + Right(is_plandate[15], 5) + "'"
dw_1.Modify(ls_mod)
end subroutine

on w_pisp052i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.uo_date=create uo_date
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_modelgroup
this.Control[iCurrent+6]=this.uo_date
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_pisp052i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.uo_date)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)

f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										'%', &
										True, &
										uo_modelgroup.is_uo_modelgroup, &
										uo_modelgroup.is_uo_modelgroupname)

ib_open = True

iw_this.PostEvent("ue_reset")
end event

event ue_retrieve;String	ls_todate

iw_this.TriggerEvent("ue_reset")
ls_todate	= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

If dw_1.Retrieve(ls_todate, &
					is_plandate[1],							is_plandate[2], &
					is_plandate[3],							is_plandate[4], &
					is_plandate[5],							is_plandate[6], &
					is_plandate[7],							is_plandate[8], &
					is_plandate[9],							is_plandate[10], &
					is_plandate[11],							is_plandate[12], &
					is_plandate[13],							is_plandate[14], &
					is_plandate[15], &
					uo_area.is_uo_areacode,					uo_division.is_uo_divisioncode, &
					uo_productgroup.is_uo_productgroup, uo_modelgroup.is_uo_modelgroup) > 0 Then
	uo_status.st_message.text =  "DDRS 현황 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "DDRS 현황이 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("DDRS 현황", "DDRS 현황이 존재하지 않습니다")
End If
end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_print.ReSet()

wf_set_date()
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

ls_mod	= "changeqty01_t.Text = '" + "~r~n" + Right(is_plandate[1], 5) + "'" + &
				"changeqty02_t.Text = '" + "~r~n" + Right(is_plandate[2], 5) + "'" + &
				"changeqty03_t.Text = '" + "~r~n" + Right(is_plandate[3], 5) + "'" + &
				"changeqty04_t.Text = '" + "~r~n" + Right(is_plandate[4], 5) + "'" + &
				"changeqty05_t.Text = '" + "~r~n" + Right(is_plandate[5], 5) + "'" + &
				"changeqty06_t.Text = '" + "~r~n" + Right(is_plandate[6], 5) + "'" + &
				"changeqty07_t.Text = '" + "~r~n" + Right(is_plandate[7], 5) + "'" + &
				"changeqty08_t.Text = '" + "~r~n" + Right(is_plandate[8], 5) + "'" + &
				"changeqty09_t.Text = '" + "~r~n" + Right(is_plandate[9], 5) + "'" + &
				"changeqty10_t.Text = '" + "~r~n" + Right(is_plandate[10], 5) + "'" + &
				"changeqty11_t.Text = '" + "~r~n" + Right(is_plandate[11], 5) + "'" + &
				"changeqty12_t.Text = '" + "~r~n" + Right(is_plandate[12], 5) + "'" + &
				"changeqty13_t.Text = '" + "~r~n" + Right(is_plandate[13], 5) + "'" + &
				"changeqty14_t.Text = '" + "~r~n" + Right(is_plandate[14], 5) + "'" + &
				"changeqty15_t.Text = '" + "~r~n" + Right(is_plandate[15], 5) + "'"
				
dw_print.Modify(ls_mod)
	
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= 'DDRS 현황'
lstr_prt.tag			= 'DDRS 현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp052i
end type

type dw_1 from u_vi_std_datawindow within w_pisp052i
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 204
integer width = 3584
integer height = 1684
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisp052i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 

Long ll_scrollPos, ll_detail
String ls_Row, ls_vScrollPos, ls_Chk 

//ll_header		= Long(Describe("DataWindow.Header.Height"))
ll_detail		= Long(Describe("DataWindow.Detail.Height"))

If scrollcode = 0 Then 		// ▲ 
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 

	Return 1 
ElseIf scrollcode = 1 Then 	// ▼
	
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
	
	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
	If ls_Chk <> '' Then MessageBox("", ls_Chk)
	Return 1 
End If 

end event

type uo_area from u_pisc_select_area within w_pisp052i
integer x = 841
integer y = 72
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_division from u_pisc_select_division within w_pisp052i
integer x = 1353
integer y = 72
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_productgroup from u_pisc_select_productgroup within w_pisp052i
integer x = 2002
integer y = 72
integer height = 68
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If
end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisp052i
integer x = 2912
integer y = 72
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type uo_date from u_pisc_date_applydate within w_pisp052i
event destroy ( )
integer x = 64
integer y = 72
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_print from datawindow within w_pisp052i
integer x = 2222
integer y = 408
integer width = 622
integer height = 416
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp052i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp052i
integer x = 14
integer width = 786
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp052i
integer x = 805
integer width = 1147
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp052i
integer x = 1957
integer width = 1915
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

