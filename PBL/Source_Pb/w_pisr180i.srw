$PBExportHeader$w_pisr180i.srw
$PBExportComments$납기준수현황
forward
global type w_pisr180i from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_pisr180i
end type
type uo_area from u_pisc_select_area within w_pisr180i
end type
type dw_2 from u_vi_std_datawindow within w_pisr180i
end type
type uo_fromdate from u_pisc_date_applydate within w_pisr180i
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisr180i
end type
type st_2 from statictext within w_pisr180i
end type
type dw_condition from datawindow within w_pisr180i
end type
type gb_3 from groupbox within w_pisr180i
end type
type gb_4 from groupbox within w_pisr180i
end type
type gb_1 from groupbox within w_pisr180i
end type
type dw_print from datawindow within w_pisr180i
end type
type pb_downexcel from picturebutton within w_pisr180i
end type
end forward

global type w_pisr180i from w_ipis_sheet01
event ue_init ( )
uo_division uo_division
uo_area uo_area
dw_2 dw_2
uo_fromdate uo_fromdate
uo_todate uo_todate
st_2 st_2
dw_condition dw_condition
gb_3 gb_3
gb_4 gb_4
gb_1 gb_1
dw_print dw_print
pb_downexcel pb_downexcel
end type
global w_pisr180i w_pisr180i

type variables
str_pisr_partkb istr_partkb
end variables

event ue_init();
dw_print.Visible = False

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

end event

on w_pisr180i.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_2=create dw_2
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_2=create st_2
this.dw_condition=create dw_condition
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_print=create dw_print
this.pb_downexcel=create pb_downexcel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_fromdate
this.Control[iCurrent+5]=this.uo_todate
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_condition
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_print
this.Control[iCurrent+12]=this.pb_downexcel
end on

on w_pisr180i.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_2)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_2)
destroy(this.dw_condition)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_print)
destroy(this.pb_downexcel)
end on

event open;call super::open;
dw_condition.SetTransObject(sqlpis)
dw_condition.InsertRow(1)

this.PostEvent ( "ue_init" )

uo_fromdate.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_fromdate.is_uo_date = String(uo_fromdate.id_uo_date, 'YYYY.MM.DD')
uo_fromdate.init_cal(uo_fromdate.id_uo_date)
uo_fromdate.set_date_format ('yyyy.mm.dd')
uo_fromdate.TriggerEvent("ue_variable_set")
uo_fromdate.TriggerEvent("ue_select")

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight - ( dw_2.y + ls_status )

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

event ue_retrieve;call super::ue_retrieve;Long 		ll_Row
String	ls_suppCode

dw_condition.AcceptText()
ll_Row		= dw_condition.GetRow()
ls_suppCode = dw_condition.GetItemString(ll_Row, 'suppliercode' )
If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then ls_suppCode = '%'

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_suppCode, uo_fromdate.is_uo_date, uo_todate.is_uo_date )
//ll_Row = dw_2.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_productGroup, ls_itemCode, uo_fromdate.is_uo_date, uo_todate.is_uo_date )

If ll_Row < 1 Then 
	MessageBox("확인", "납입 이력이 존재하지 않습니다.", Information! )
End If

Return

end event

event ue_print;call super::ue_print;Long 		ll_Row
String	ls_suppCode, ls_itemCode, ls_FromDate, ls_ToDate, ls_productGroup
DateTime	ldt_nowTime, ldt_applytime
str_easy lstr_prt

dw_condition.AcceptText()

ll_Row		= dw_condition.GetRow()
ls_suppCode	= dw_condition.GetItemString(ll_Row, 'suppliercode')
If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then ls_suppCode = '%'

ls_FromDate	= uo_fromdate.is_uo_date
ls_ToDate	= uo_todate.is_uo_date

dw_print.DataObject = "d_pisr180p_01"
dw_print.SetTransObject(sqlpis)
dw_print.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_suppCode, ls_FromDate, ls_ToDate )
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '간판준수현황 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

return 
	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr180i
end type

type uo_division from u_pisc_select_division within w_pisr180i
event destroy ( )
integer x = 622
integer y = 72
integer taborder = 100
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_2.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr180i
event destroy ( )
integer x = 73
integer y = 72
integer taborder = 110
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;ib_allflag = False
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										True, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode

dw_2.Reset()
end event

type dw_2 from u_vi_std_datawindow within w_pisr180i
integer x = 18
integer y = 368
integer width = 2139
integer height = 1000
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr180i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_fromdate from u_pisc_date_applydate within w_pisr180i
integer x = 1275
integer y = 72
integer taborder = 70
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
dw_2.Reset()
end event

on uo_fromdate.destroy
call u_pisc_date_applydate::destroy
end on

type uo_todate from u_pisc_date_applydate_1 within w_pisr180i
integer x = 2030
integer y = 72
integer taborder = 80
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
dw_2.Reset()
end event

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_2 from statictext within w_pisr180i
integer x = 1957
integer y = 72
integer width = 73
integer height = 52
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type dw_condition from datawindow within w_pisr180i
integer x = 37
integer y = 220
integer width = 2793
integer height = 116
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition3"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
			istr_partkb.flag = 3			//외주업체(지역,공장)
			OpenWithParm ( w_pisr012i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
			This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
			This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
	CASE 'b_item'
			istr_partkb.flag = 1			//외주자재list (지역,공장)
			OpenWithParm ( w_pisr013i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'itemcode'			, lstr_Rtn.code)
			This.SetItem(row,'itemname'			, lstr_Rtn.name)
			This.SetItem(row,'itemspec'			, lstr_Rtn.nicname)
	CASE ELSE
			Return
END CHOOSE

dw_2.Reset()

Return

end event

event itemchanged;String 	ls_suppcode, ls_suppno, ls_suppname//, ls_colName 
String	ls_Null 

this.AcceptText ( )

SetNull(ls_Null)
ls_suppcode	= data
  SELECT Top 1
			B.SupplierNo,   
			B.SupplierKorName  
	 INTO :ls_suppno,   
			:ls_suppname  
	 FROM TMSTPARTCYCLE	A,   
			TMSTSUPPLIER	B  
	WHERE A.SupplierCode = B.SupplierCode 			AND
			A.AreaCode 		= :istr_partkb.areacode AND  
			A.DivisionCode = :istr_partkb.divcode 	AND  
			A.SupplierCode = :ls_suppcode 
	Using	sqlpis	;
	
If sqlpis.SqlCode <> 0 Then 
	This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
	This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
	This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
	istr_partkb.suppcode = '%'
	Return 1
End If
This.SetItem( This.GetRow(), 'supplierno'			, ls_suppno )
This.SetItem( This.GetRow(), 'supplierkorname'	, ls_suppname )
istr_partkb.suppcode = ls_suppcode

dw_2.Reset()


end event

event itemerror;Return 1
end event

type gb_3 from groupbox within w_pisr180i
integer x = 18
integer width = 1202
integer height = 180
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

type gb_4 from groupbox within w_pisr180i
integer x = 1234
integer width = 1275
integer height = 180
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr180i
integer x = 18
integer y = 168
integer width = 2821
integer height = 184
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_print from datawindow within w_pisr180i
integer x = 2203
integer y = 576
integer width = 987
integer height = 1032
integer taborder = 61
boolean titlebar = true
string title = "납기준수현황출력"
string dataobject = "d_pisr180p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_downexcel from picturebutton within w_pisr180i
integer x = 2565
integer y = 40
integer width = 155
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_2.rowcount() < 1 then
	return 0
end if

f_save_to_excel_execute(dw_2,"1")

return 1
end event

