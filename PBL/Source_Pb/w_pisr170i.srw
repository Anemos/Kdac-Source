$PBExportHeader$w_pisr170i.srw
$PBExportComments$납기지연간판조회
forward
global type w_pisr170i from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_pisr170i
end type
type uo_area from u_pisc_select_area within w_pisr170i
end type
type dw_condition from datawindow within w_pisr170i
end type
type dw_2 from u_vi_std_datawindow within w_pisr170i
end type
type uo_date from u_pisc_date_applydate within w_pisr170i
end type
type st_2 from statictext within w_pisr170i
end type
type sle_1 from singlelineedit within w_pisr170i
end type
type dw_condition2 from datawindow within w_pisr170i
end type
type sle_2 from singlelineedit within w_pisr170i
end type
type st_3 from statictext within w_pisr170i
end type
type gb_3 from groupbox within w_pisr170i
end type
type gb_4 from groupbox within w_pisr170i
end type
type gb_1 from groupbox within w_pisr170i
end type
type dw_print from datawindow within w_pisr170i
end type
end forward

global type w_pisr170i from w_ipis_sheet01
event ue_init ( )
uo_division uo_division
uo_area uo_area
dw_condition dw_condition
dw_2 dw_2
uo_date uo_date
st_2 st_2
sle_1 sle_1
dw_condition2 dw_condition2
sle_2 sle_2
st_3 st_3
gb_3 gb_3
gb_4 gb_4
gb_1 gb_1
dw_print dw_print
end type
global w_pisr170i w_pisr170i

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

on w_pisr170i.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_condition=create dw_condition
this.dw_2=create dw_2
this.uo_date=create uo_date
this.st_2=create st_2
this.sle_1=create sle_1
this.dw_condition2=create dw_condition2
this.sle_2=create sle_2
this.st_3=create st_3
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_condition
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.uo_date
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_1
this.Control[iCurrent+8]=this.dw_condition2
this.Control[iCurrent+9]=this.sle_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.dw_print
end on

on w_pisr170i.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_condition)
destroy(this.dw_2)
destroy(this.uo_date)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.dw_condition2)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_print)
end on

event open;call super::open;
dw_condition.SetTransObject(sqlpis)
dw_condition.InsertRow(1)
dw_condition2.SetTransObject(sqlpis)
dw_condition2.InsertRow(1)

this.PostEvent ( "ue_init" )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight - ( dw_2.y + ls_status )

end event

event ue_retrieve;call super::ue_retrieve;Long 		ll_Row
String	ls_suppCode, ls_itemCode, ls_productGroup
DateTime ldt_nowTime
String	ls_sletext, ls_text1, ls_text2
Integer	li_day1, li_day2, li_i

ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
//ls_nowTime	= String(ldt_nowTime, 'yyyy.mm.dd hh:mm:ss')

dw_condition.AcceptText()
ll_Row		= dw_condition.GetRow()
ls_suppCode	= dw_condition.GetItemString(ll_Row, 'suppliercode')
If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then 
	ls_suppCode = '%'
End If
ls_itemCode	= dw_condition.GetItemString(ll_Row, 'itemcode' )
If isNull(ls_itemCode) Or Trim(ls_itemCode) = '' Then 
	ls_itemCode = '%'
End If

dw_condition2.AcceptText()
ll_Row				= dw_condition2.GetRow()
ls_productGroup	= dw_condition2.GetItemString(ll_Row, 'productgroup')
If isNull(ls_productGroup) Or Trim(ls_productGroup) = '' Then 
	ls_productGroup = '%'
End If

ls_text1 = sle_1.Text; ls_text2 = sle_2.Text;
//ls_sletext = sle_1.Text
//If isNull(ls_sletext) Or Trim(ls_sletext) = '' Then
//	ls_text1 = '0'; ls_text2 = '3650';
//Else
//	For li_i = 1 To len(ls_sletext) Step 1
//		ls_text1 = mid(ls_sletext, li_i, 1)
//		If ls_text1 = '-' Then Exit
//	Next
//	If li_i >= len(ls_sletext) Then 
//		ls_text1	= ls_sletext; ls_text2 = ls_sletext
//	Else
//		ls_text1	= left(ls_sletext, li_i - 1 )
//		ls_text2	= mid(ls_sletext, li_i + 1, len(ls_sletext) )
//	End If 
//End If

If isNumber(ls_text1) Then 
	li_day1 = Integer(ls_text1)
Else 
	MessageBox("입력오류", "납기지연일수 항목의 입력값을 확인하세요.", Information! )
	Return
End If

If isNumber(ls_text2) Then 
	li_day2 = Integer(ls_text2)
Else 
	MessageBox("입력오류", "납기지연일수 항목의 입력값을 확인하세요.", Information! )
	Return
End If

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_suppCode, ls_itemCode, ls_productGroup, li_day1, li_day2, ldt_nowTime )

If ll_Row < 1 Then 
	MessageBox("확인", "납기 지연된 간판이 존재하지 않습니다.", Information! )
End If

Return

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

event ue_print;call super::ue_print;Long 		ll_Row
String	ls_suppCode, ls_itemCode, ls_productGroup
DateTime	ldt_nowTime
str_easy lstr_prt
Long		ll_days1, ll_days2

dw_condition.AcceptText()

ll_Row		= dw_condition.GetRow()
ls_suppCode	= dw_condition.GetItemString(ll_Row, 'suppliercode')
If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then ls_suppCode = '%'

ls_itemCode	= dw_condition.GetItemString(ll_Row, 'itemcode' )
If isNull(ls_itemCode) Or Trim(ls_itemCode) = '' Then ls_itemCode = '%'

dw_condition2.AcceptText()
ll_Row				= dw_condition2.GetRow()
ls_productGroup	= dw_condition2.GetItemString(ll_Row, 'productgroup')
If isNull(ls_productGroup) Or Trim(ls_productGroup) = '' Then ls_productGroup = '%'

ll_days1	= Long(sle_1.Text)
ll_days2	= Long(sle_2.Text)

ldt_nowTime	= f_pisc_get_date_nowtime()					//현재 시스템시간
dw_print.DataObject = "d_pisr170p_01"
dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_suppCode, ls_itemCode, ls_productGroup, ll_days1, ll_days2, ldt_nowTime )
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '납기지연간판리스트 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

return 
	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr170i
end type

type uo_division from u_pisc_select_division within w_pisr170i
event destroy ( )
integer x = 1390
integer y = 72
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_2.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr170i
event destroy ( )
integer x = 841
integer y = 72
integer taborder = 20
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
end event

type dw_condition from datawindow within w_pisr170i
integer x = 73
integer y = 200
integer width = 2770
integer height = 216
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition"
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

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_itemcode, ls_itemspec, ls_itemname
String	ls_Null 
//DataWindowChild ldwc

this.AcceptText ( )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode'
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
	Case 'itemcode' 
			ls_itemcode	= data
			ls_suppcode	= This.GetItemString( This.GetRow(), 'suppliercode')
			If isNull(ls_suppcode) Or Trim(ls_suppcode) = '' Then ls_suppcode = '%'
		  SELECT Top 1
		  			B.ItemName,   
					B.ItemSpec  
			 INTO :ls_itemname,   
					:ls_itemspec  
			 FROM TMSTPARTKB		A,   
					TMSTITEM			B  
			WHERE A.ItemCode 		= B.ItemCode	 			AND
					A.AreaCode 		= :istr_partkb.areacode AND  
					A.DivisionCode = :istr_partkb.divcode 	AND  
					A.SupplierCode like :ls_suppcode 		AND
					A.ItemCode 		= :ls_itemcode 		
			Using	sqlpis	;
			
			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'itemcode', ls_Null )
				This.SetItem( This.GetRow(), 'itemspec', ls_Null )
				This.SetItem( This.GetRow(), 'itemname', ls_Null )
				istr_partkb.itemcode = '%'
				Return 1
			End If
			This.SetItem( This.GetRow(), 'itemname', ls_itemname )
			This.SetItem( This.GetRow(), 'itemspec', ls_itemspec )
			istr_partkb.itemcode = ls_itemcode
End Choose 

dw_2.Reset()

end event

event itemerror;Return 1
end event

type dw_2 from u_vi_std_datawindow within w_pisr170i
integer x = 14
integer y = 552
integer width = 2194
integer height = 1000
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisr170i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;DataWindowChild ldwc

If This.GetChild('orderchangecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet(); 
	If ldwc.Retrieve( istr_partkb.areacode, istr_partkb.divcode) = 0 Then ldwc.InsertRow(1) 
End If 

end event

type uo_date from u_pisc_date_applydate within w_pisr170i
integer x = 59
integer y = 72
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
dw_2.Reset()
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type st_2 from statictext within w_pisr170i
integer x = 1993
integer y = 432
integer width = 425
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "납기지연일수:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_pisr170i
integer x = 2423
integer y = 420
integer width = 169
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type dw_condition2 from datawindow within w_pisr170i
integer x = 46
integer y = 416
integer width = 1947
integer height = 104
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition6"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname

//			istr_partkb.flag = 3			//외주업체(지역,공장)
OpenWithParm ( w_pisr015i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
This.SetItem(row,'productgroup'		, lstr_Rtn.code)
This.SetItem(row,'productgroupname'	, lstr_Rtn.name)
Return

end event

event itemchanged;String 	ls_colName, ls_product, ls_productname
String	ls_Null 
//DataWindowChild ldwc

this.AcceptText ( )

SetNull(ls_Null)
ls_product	= data
  SELECT Top 1 TMSTPRODUCTGROUP.ProductGroupName  
	 INTO :ls_productname  
	 FROM TMSTPRODUCTGROUP  
	WHERE TMSTPRODUCTGROUP.AreaCode 		= :istr_partkb.areacode AND  
			TMSTPRODUCTGROUP.DivisionCode = :istr_partkb.divcode AND  
			TMSTPRODUCTGROUP.ProductGroup = :ls_product 
	Using	sqlpis	;
	
	If sqlpis.SqlCode <> 0 Then 
		This.SetItem( This.GetRow(), 'productgroup'		, ls_Null )
		This.SetItem( This.GetRow(), 'productgroupname'	, ls_Null )
		Return 1
	End If
	This.SetItem( This.GetRow(), 'productgroupname'	, ls_productname )

end event

event itemerror;Return 1
end event

type sle_2 from singlelineedit within w_pisr170i
integer x = 2670
integer y = 420
integer width = 178
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "3650"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_pisr170i
integer x = 2601
integer y = 416
integer width = 64
integer height = 76
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_pisr170i
integer x = 786
integer width = 1202
integer height = 180
integer taborder = 90
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

type gb_4 from groupbox within w_pisr170i
integer x = 18
integer width = 750
integer height = 180
integer taborder = 100
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

type gb_1 from groupbox within w_pisr170i
integer x = 18
integer y = 152
integer width = 2857
integer height = 388
integer taborder = 110
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_pisr170i
integer x = 2085
integer y = 584
integer width = 987
integer height = 1032
integer taborder = 61
boolean titlebar = true
string title = "납기지연간판LIST 출력"
string dataobject = "d_pisr170p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

