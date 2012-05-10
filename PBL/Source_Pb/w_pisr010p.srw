$PBExportHeader$w_pisr010p.srw
$PBExportComments$외주간판기본정보 List 출력
forward
global type w_pisr010p from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_pisr010p
end type
type uo_area from u_pisc_select_area within w_pisr010p
end type
type dw_2 from u_vi_std_datawindow within w_pisr010p
end type
type dw_condition from datawindow within w_pisr010p
end type
type dw_condition2 from datawindow within w_pisr010p
end type
type gb_3 from groupbox within w_pisr010p
end type
type gb_1 from groupbox within w_pisr010p
end type
type dw_print from datawindow within w_pisr010p
end type
end forward

global type w_pisr010p from w_ipis_sheet01
event ue_init ( )
uo_division uo_division
uo_area uo_area
dw_2 dw_2
dw_condition dw_condition
dw_condition2 dw_condition2
gb_3 gb_3
gb_1 gb_1
dw_print dw_print
end type
global w_pisr010p w_pisr010p

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

on w_pisr010p.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_2=create dw_2
this.dw_condition=create dw_condition
this.dw_condition2=create dw_condition2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_condition
this.Control[iCurrent+5]=this.dw_condition2
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.dw_print
end on

on w_pisr010p.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_2)
destroy(this.dw_condition)
destroy(this.dw_condition2)
destroy(this.gb_3)
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

//dw_2.DataObject = "d_pisr010p_03"
dw_2.SetRedraw(False)
dw_2.SetTransObject(sqlpis)
dw_2.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup )
dw_2.SetRedraw(True)

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
str_easy lstr_prt

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

//dw_print.DataObject = "d_pisr010p_01"
dw_print.SetTransObject(sqlpis)
dw_print.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup )
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '외주간판기본정보 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr010p
end type

type uo_division from u_pisc_select_division within w_pisr010p
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

dw_2.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr010p
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 100
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

type dw_2 from u_vi_std_datawindow within w_pisr010p
integer x = 18
integer y = 564
integer width = 2857
integer height = 1004
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr010p_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_condition from datawindow within w_pisr010p
integer x = 69
integer y = 208
integer width = 2770
integer height = 216
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition"
boolean border = false
boolean livescroll = true
end type

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

type dw_condition2 from datawindow within w_pisr010p
integer x = 41
integer y = 424
integer width = 1998
integer height = 104
integer taborder = 100
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

type gb_3 from groupbox within w_pisr010p
integer x = 18
integer width = 1202
integer height = 180
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

type gb_1 from groupbox within w_pisr010p
integer x = 18
integer y = 172
integer width = 2853
integer height = 376
integer taborder = 110
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

type dw_print from datawindow within w_pisr010p
integer x = 1637
integer y = 808
integer width = 1595
integer height = 920
integer taborder = 30
boolean enabled = false
boolean titlebar = true
string title = "외주간판기본정보 출력"
string dataobject = "d_pisr010p_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

