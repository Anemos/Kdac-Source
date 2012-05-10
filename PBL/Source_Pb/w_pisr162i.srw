$PBExportHeader$w_pisr162i.srw
$PBExportComments$개별간판이력조회( 간판번호별조회 )
forward
global type w_pisr162i from w_ipis_sheet01
end type
type dw_2 from datawindow within w_pisr162i
end type
type dw_3 from u_vi_std_datawindow within w_pisr162i
end type
type uo_area from u_pisc_select_area within w_pisr162i
end type
type uo_division from u_pisc_select_division within w_pisr162i
end type
type dw_scan from datawindow within w_pisr162i
end type
type uo_from from u_pisc_date_applydate within w_pisr162i
end type
type uo_to from u_pisc_date_applydate_1 within w_pisr162i
end type
type st_2 from statictext within w_pisr162i
end type
type gb_3 from groupbox within w_pisr162i
end type
type gb_4 from groupbox within w_pisr162i
end type
type gb_scan from groupbox within w_pisr162i
end type
type dw_print from datawindow within w_pisr162i
end type
end forward

global type w_pisr162i from w_ipis_sheet01
event ue_process ( )
event ue_init ( )
dw_2 dw_2
dw_3 dw_3
uo_area uo_area
uo_division uo_division
dw_scan dw_scan
uo_from uo_from
uo_to uo_to
st_2 st_2
gb_3 gb_3
gb_4 gb_4
gb_scan gb_scan
dw_print dw_print
end type
global w_pisr162i w_pisr162i

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowTime, is_jobDate, is_applyDate	//현재시간, 작업기준일자, 마감기준일자
DateTime	idt_nowTime										//현재시간
String	is_null
end variables

event ue_process();
Long		ll_Row
String	ls_areaCode, ls_divCode, ls_from, ls_to

dw_2.SetTransObject (sqlpis)
ll_Row = dw_2.Retrieve(is_partkbno, is_jobdate)
If ll_Row = 0 Then 
	MessageBox( "입력오류", "존재하지 않는 간판번호입니다. ", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return 
End If

ls_areaCode			= dw_2.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_2.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "입력오류", "해당 공장의 간판이 아닙니다.", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return 
End If

ls_from	= uo_from.is_uo_date
ls_to		= uo_to.is_uo_date

dw_3.SetTransObject(sqlpis)
dw_3.Retrieve(is_partkbno,ls_from,ls_to)

Return 

end event

event ue_init();
dw_print.Visible = False

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

on w_pisr162i.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_scan=create dw_scan
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_2=create st_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_scan=create gb_scan
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_scan
this.Control[iCurrent+6]=this.uo_from
this.Control[iCurrent+7]=this.uo_to
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.gb_scan
this.Control[iCurrent+12]=this.dw_print
end on

on w_pisr162i.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_scan)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_scan)
destroy(this.dw_print)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

end event

event open;call super::open;
SetNull(is_null)

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1) 

dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

this.PostEvent ( "ue_init" )

uo_from.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_from.is_uo_date = String(uo_from.id_uo_date, 'YYYY.MM.DD')
uo_from.init_cal(uo_from.id_uo_date)
uo_from.set_date_format ('yyyy.mm.dd')
uo_from.TriggerEvent("ue_variable_set")
uo_from.TriggerEvent("ue_select")

end event

event ue_postopen;call super::ue_postopen;
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

end event

event ue_print;call super::ue_print;
Long		ll_Row
//String	ls_partKBNo
str_easy lstr_prt

If isNull(is_partkbno) Or Trim(is_partkbno) = '' Then
	MessageBox( "확인","출력할 간판번호가 입력되지 않았습니다.", Information!)
	return 
End If

dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(is_partkbno, uo_from.is_uo_date, uo_to.is_uo_date)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '개별간판 이력현황출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  
	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr162i
integer y = 1884
end type

type dw_2 from datawindow within w_pisr162i
integer x = 18
integer y = 428
integer width = 3259
integer height = 588
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr150b_01"
boolean border = false
boolean livescroll = true
end type

event clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1
end event

type dw_3 from u_vi_std_datawindow within w_pisr162i
integer x = 14
integer y = 1036
integer width = 2642
integer height = 808
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisr161i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1
end event

type uo_area from u_pisc_select_area within w_pisr162i
event destroy ( )
integer x = 87
integer y = 88
integer taborder = 60
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;//ib_allflag = True
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode


dw_2.Reset()
dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

dw_3.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr162i
event destroy ( )
integer x = 635
integer y = 88
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_2.Reset()
dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

dw_3.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_scan from datawindow within w_pisr162i
integer x = 37
integer y = 244
integer width = 1330
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;
This.SelectText(1,15)
end event

event itemchanged;If len(data) <> 11 Then 
	MessageBox( "입력오류", "올바른 간판번호 가 아닙니다.", StopSign! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간고려함
//is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간,마감일 고려함

is_partkbno = data
parent.TriggerEvent( "ue_process" )

this.Event getfocus()
end event

type uo_from from u_pisc_date_applydate within w_pisr162i
integer x = 1289
integer y = 88
integer taborder = 80
boolean bringtotop = true
end type

on uo_from.destroy
call u_pisc_date_applydate::destroy
end on

type uo_to from u_pisc_date_applydate_1 within w_pisr162i
integer x = 2066
integer y = 88
integer taborder = 90
boolean bringtotop = true
end type

on uo_to.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_2 from statictext within w_pisr162i
integer x = 1989
integer y = 88
integer width = 73
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_pisr162i
integer x = 23
integer width = 1202
integer height = 208
integer taborder = 10
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

type gb_4 from groupbox within w_pisr162i
integer x = 1248
integer width = 1303
integer height = 208
integer taborder = 50
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

type gb_scan from groupbox within w_pisr162i
integer x = 23
integer y = 200
integer width = 1358
integer height = 208
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_pisr162i
integer x = 1874
integer y = 1084
integer width = 1285
integer height = 892
integer taborder = 31
boolean titlebar = true
string title = "개별간판이력 출력"
string dataobject = "d_pisr160i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

