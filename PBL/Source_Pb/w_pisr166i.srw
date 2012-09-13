$PBExportHeader$w_pisr166i.srw
$PBExportComments$모델별수입검사시간현황
forward
global type w_pisr166i from w_ipis_sheet01
end type
type dw_pisr166i_01 from u_vi_std_datawindow within w_pisr166i
end type
type dw_condition3 from datawindow within w_pisr166i
end type
type uo_area from u_pisc_select_area within w_pisr166i
end type
type uo_division from u_pisc_select_division within w_pisr166i
end type
type uo_product from u_pisc_select_productgroup within w_pisr166i
end type
type pb_down from picturebutton within w_pisr166i
end type
type uo_fromdate from u_pisc_date_applydate within w_pisr166i
end type
type st_2 from statictext within w_pisr166i
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisr166i
end type
type gb_1 from groupbox within w_pisr166i
end type
end forward

global type w_pisr166i from w_ipis_sheet01
integer width = 4663
event ue_init ( )
dw_pisr166i_01 dw_pisr166i_01
dw_condition3 dw_condition3
uo_area uo_area
uo_division uo_division
uo_product uo_product
pb_down pb_down
uo_fromdate uo_fromdate
st_2 st_2
uo_todate uo_todate
gb_1 gb_1
end type
global w_pisr166i w_pisr166i

type variables
str_pisr_partkb istr_partkb
end variables

event ue_init();SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= True
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

on w_pisr166i.create
int iCurrent
call super::create
this.dw_pisr166i_01=create dw_pisr166i_01
this.dw_condition3=create dw_condition3
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.pb_down=create pb_down
this.uo_fromdate=create uo_fromdate
this.st_2=create st_2
this.uo_todate=create uo_todate
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr166i_01
this.Control[iCurrent+2]=this.dw_condition3
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_product
this.Control[iCurrent+6]=this.pb_down
this.Control[iCurrent+7]=this.uo_fromdate
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.uo_todate
this.Control[iCurrent+10]=this.gb_1
end on

on w_pisr166i.destroy
call super::destroy
destroy(this.dw_pisr166i_01)
destroy(this.dw_condition3)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.pb_down)
destroy(this.uo_fromdate)
destroy(this.st_2)
destroy(this.uo_todate)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr166i_01.Width = newwidth 	- ( dw_pisr166i_01.x + ls_gap * 2 )
dw_pisr166i_01.Height= newheight - ( dw_pisr166i_01.y + ls_status)
end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
	
uo_fromdate.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_fromdate.is_uo_date = String(uo_fromdate.id_uo_date, 'YYYY.MM.DD')
uo_fromdate.init_cal(uo_fromdate.id_uo_date)
uo_fromdate.set_date_format ('yyyy.mm.dd')
uo_fromdate.TriggerEvent("ue_variable_set")
uo_fromdate.TriggerEvent("ue_select")
end event

event open;call super::open;dw_pisr166i_01.settransobject(sqlpis)
dw_condition3.settransobject(sqlpis)

dw_condition3.insertrow(0)

this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;long ll_row
string ls_suppcode

uo_status.st_message.text = ""
dw_pisr166i_01.SetRedraw(False)
dw_pisr166i_01.SetTransObject(sqlpis)
dw_condition3.accepttext()
ll_Row		= dw_condition3.GetRow()
ls_suppCode = dw_condition3.GetItemString(ll_Row, 'suppliercode' )
If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then ls_suppCode = '%'
//uo_fromdate.is_uo_date, uo_todate.is_uo_date
ll_Row = dw_pisr166i_01.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	uo_product.is_uo_productgroup, ls_suppcode, uo_fromdate.is_uo_date, uo_todate.is_uo_date )
dw_pisr166i_01.SetRedraw(True)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr166i
end type

type dw_pisr166i_01 from u_vi_std_datawindow within w_pisr166i
integer x = 23
integer y = 296
integer width = 3127
integer height = 1440
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr166i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;String ls_itemcode, ls_colname

ls_colname = dwo.name
ls_itemcode = This.getitemstring(row,'itemcode')

return 0
end event

type dw_condition3 from datawindow within w_pisr166i
integer x = 1335
integer y = 152
integer width = 1893
integer height = 104
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition3"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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
			istr_partkb.suppcode = lstr_Rtn.code
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
dw_pisr166i_01.Reset()
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
dw_pisr166i_01.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr166i
integer x = 50
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode

dw_pisr166i_01.Reset()
end event

type uo_division from u_pisc_select_division within w_pisr166i
integer x = 544
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;istr_partkb.divcode = is_uo_divisioncode

dw_pisr166i_01.Reset()

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
end event

type uo_product from u_pisc_select_productgroup within w_pisr166i
integer x = 1106
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr166i_01.reset()
end event

type pb_down from picturebutton within w_pisr166i
integer x = 3383
integer y = 84
integer width = 320
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
f_save_to_excel(dw_pisr166i_01)
return 0
end event

type uo_fromdate from u_pisc_date_applydate within w_pisr166i
event destroy ( )
integer x = 46
integer y = 172
integer taborder = 80
boolean bringtotop = true
end type

on uo_fromdate.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;
dw_pisr166i_01.Reset()
end event

type st_2 from statictext within w_pisr166i
integer x = 727
integer y = 172
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

type uo_todate from u_pisc_date_applydate_1 within w_pisr166i
event destroy ( )
integer x = 800
integer y = 172
integer taborder = 90
boolean bringtotop = true
end type

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_pisr166i_01.Reset()
end event

type gb_1 from groupbox within w_pisr166i
integer x = 23
integer width = 3790
integer height = 280
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

