$PBExportHeader$w_pisr160i.srw
$PBExportComments$개별간판이력조회
forward
global type w_pisr160i from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_pisr160i
end type
type uo_area from u_pisc_select_area within w_pisr160i
end type
type tv_partkb from u_pisr_treeview within w_pisr160i
end type
type dw_2 from u_vi_std_datawindow within w_pisr160i
end type
type dw_3 from u_vi_std_datawindow within w_pisr160i
end type
type st_vsplitbar from u_pism_splitbar within w_pisr160i
end type
type st_hsplitbar from u_pism_splitbar within w_pisr160i
end type
type dw_print from datawindow within w_pisr160i
end type
type uo_from from u_pisc_date_applydate within w_pisr160i
end type
type uo_to from u_pisc_date_applydate_1 within w_pisr160i
end type
type st_2 from statictext within w_pisr160i
end type
type gb_1 from groupbox within w_pisr160i
end type
type gb_3 from groupbox within w_pisr160i
end type
end forward

global type w_pisr160i from w_ipis_sheet01
event ue_init ( )
uo_division uo_division
uo_area uo_area
tv_partkb tv_partkb
dw_2 dw_2
dw_3 dw_3
st_vsplitbar st_vsplitbar
st_hsplitbar st_hsplitbar
dw_print dw_print
uo_from uo_from
uo_to uo_to
st_2 st_2
gb_1 gb_1
gb_3 gb_3
end type
global w_pisr160i w_pisr160i

type variables
str_pisr_partkb istr_partkb
end variables

event ue_init();
Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_2, st_vsplitbar.RIGHT)
st_vsplitbar.of_Register(dw_3, st_vsplitbar.RIGHT)
st_vsplitbar.of_Register(st_hsplitbar, st_vsplitbar.RIGHT)		

st_hsplitbar.of_Register(dw_2, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_3, st_hsplitbar.BELOW)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회
//dw_3.Object.Enabled = False

// TreeView 설정
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)


end event

on w_pisr160i.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.tv_partkb=create tv_partkb
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_vsplitbar=create st_vsplitbar
this.st_hsplitbar=create st_hsplitbar
this.dw_print=create dw_print
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_2=create st_2
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.tv_partkb
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.st_vsplitbar
this.Control[iCurrent+7]=this.st_hsplitbar
this.Control[iCurrent+8]=this.dw_print
this.Control[iCurrent+9]=this.uo_from
this.Control[iCurrent+10]=this.uo_to
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisr160i.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.tv_partkb)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_vsplitbar)
destroy(this.st_hsplitbar)
destroy(this.dw_print)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event open;call super::open;
dw_print.Visible = False

this.PostEvent ( "ue_init" )

uo_from.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_from.is_uo_date = String(uo_from.id_uo_date, 'YYYY.MM.DD')
uo_from.init_cal(uo_from.id_uo_date)
uo_from.set_date_format ('yyyy.mm.dd')
uo_from.TriggerEvent("ue_variable_set")
uo_from.TriggerEvent("ue_select")

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

tv_partkb.Height 	= newheight - ( tv_partkb.y + ls_status )
dw_2.Width 			= newwidth 	- ( dw_2.x + ls_gap )
dw_3.Height			= newheight - ( dw_2.y + dw_2.Height + ls_status + ls_split )
dw_3.Width 			= newwidth 	- ( dw_3.x + ls_gap * 2 )

st_vsplitbar.y 		= tv_partkb.y
st_vsplitbar.Height 	= tv_partkb.Height
st_hsplitbar.x 		= dw_2.x
st_hsplitbar.y 		= dw_3.y - ls_split
st_hsplitbar.Width 	= dw_2.Width 

end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

end event

event ue_retrieve;call super::ue_retrieve;//tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode)

//dw_2.SetRedraw(False)
//dw_2.SetTransObject(Sqlpis)
//dw_2.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
//dw_2.SetRedraw(True)
//
//dw_pisr010u_03.SetRedraw(False)
//dw_pisr010u_03.SetTransObject(Sqlpis)
//dw_pisr010u_03.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
//dw_pisr010u_03.SetRedraw(True)
String	ls_arg, ls_Rtn
String	ls_partkbno, ls_from, ls_to
Long		ll_Row

ll_Row = dw_3.GetRow()
If ll_Row < 1 Then 
	MessageBox( "확인", "조회할 간판번호번 선택하여주세요.", Information! )
	Return
End If
ls_partkbno = dw_3.GetItemString( ll_Row, 'partkbno' )
ls_from		= uo_from.is_uo_date
ls_to			= uo_to.is_uo_date
ls_arg		= ls_partkbno + '@' + ls_from + '@' + ls_to

OpenWithParm ( w_pisr161i, ls_arg )
ls_Rtn = Message.StringParm

If ls_Rtn = 'Print' Then
	This.TriggerEvent( "ue_print" )
End If

Return
end event

event ue_print;call super::ue_print;
Long		ll_Row
String	ls_partKBNo
str_easy lstr_prt

ll_Row = dw_3.GetRow()

If ll_Row < 1 Then 
	MessageBox( '확인', '출력할 간판번호가 선택되지  않았습니다.', Information! )
	Return
End If

ls_partKBNo	= dw_3.GetItemString(ll_Row, 'partkbno')
	
dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(ls_partKBNo, uo_from.is_uo_date, uo_to.is_uo_date)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '개별간판 이력현황출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  
	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr160i
end type

type uo_division from u_pisc_select_division within w_pisr160i
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 90
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

type uo_area from u_pisc_select_area within w_pisr160i
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 100
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

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
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

type tv_partkb from u_pisr_treeview within w_pisr160i
integer x = 5
integer y = 196
integer width = 782
integer height = 1700
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;uf_setLevelGubun(2)

end event

event selectionchanged;call super::selectionchanged;istr_partkb = uistr_partKB

//Parent.TriggerEvent( "ue_retrieve" )
dw_2.SetRedraw(False)
dw_2.SetTransObject(Sqlpis)
dw_2.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
dw_2.SetRedraw(True)

end event

type dw_2 from u_vi_std_datawindow within w_pisr160i
integer x = 800
integer y = 196
integer width = 2217
integer height = 812
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr160i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 1
end type

event retrieveend;call super::retrieveend;If rowcount = 0 Then 
	dw_3.Reset()
//	dw_3.ScrolltoRow(dw_3.InsertRow(0))
//	IF wf_initvalue(0) = -1 THEN RETURN
//	dw_3.SetItem(1, "areacode", istr_partkb.areacode )
//	dw_3.SetItem(1, "divisioncode", istr_partkb.divcode )
//	dw_3.SetItem(1, "suppliercode", istr_partkb.suppcode )
	RETURN 
End If

This.SelectRow ( 1, True )

This.Event RowfocusChanged(1)
end event

event rowfocuschanged;call super::rowfocuschanged;
If currentrow <= 0 Or RowCount() = 0 Then Return 

istr_partkb.suppCode = This.GetItemString(currentrow, "suppliercode") 
istr_partkb.itemCode = This.GetItemString(currentrow, "itemcode") 

dw_3.SetRedraw(False)
dw_3.SetTransObject(Sqlpis)
dw_3.Retrieve(istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partkb.itemCode)
dw_3.SetRedraw(True)

dw_3.SelectRow ( 1, True )

//dw_3.Reset()
//dw_3.ScrolltoRow(dw_3.InsertRow(0))
//IF wf_initvalue( currentrow ) = -1 THEN 
//	RETURN 
//End If

end event

type dw_3 from u_vi_std_datawindow within w_pisr160i
integer x = 800
integer y = 1020
integer width = 1824
integer height = 708
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr160i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 1
end type

event doubleclicked;call super::doubleclicked;
Parent.TriggerEvent("ue_retrieve")
Return
end event

type st_vsplitbar from u_pism_splitbar within w_pisr160i
integer x = 786
integer y = 200
integer width = 18
integer height = 1700
boolean bringtotop = true
end type

type st_hsplitbar from u_pism_splitbar within w_pisr160i
integer x = 800
integer y = 1004
integer width = 2802
boolean bringtotop = true
end type

type dw_print from datawindow within w_pisr160i
integer x = 485
integer y = 488
integer width = 1285
integer height = 892
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "개별간판이력 출력"
string dataobject = "d_pisr160i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_from from u_pisc_date_applydate within w_pisr160i
integer x = 1294
integer y = 76
integer taborder = 70
boolean bringtotop = true
end type

on uo_from.destroy
call u_pisc_date_applydate::destroy
end on

type uo_to from u_pisc_date_applydate_1 within w_pisr160i
integer x = 2071
integer y = 76
integer taborder = 80
boolean bringtotop = true
end type

on uo_to.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_2 from statictext within w_pisr160i
integer x = 1993
integer y = 72
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

type gb_1 from groupbox within w_pisr160i
integer x = 18
integer width = 1221
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisr160i
integer x = 1253
integer width = 1303
integer height = 188
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

