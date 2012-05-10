$PBExportHeader$w_pisr141i.srw
$PBExportComments$가입고간판조회
forward
global type w_pisr141i from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_pisr141i
end type
type uo_area from u_pisc_select_area within w_pisr141i
end type
type rb_1 from radiobutton within w_pisr141i
end type
type rb_2 from radiobutton within w_pisr141i
end type
type dw_2 from u_vi_std_datawindow within w_pisr141i
end type
type uo_fromdate from u_pisc_date_applydate within w_pisr141i
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisr141i
end type
type st_2 from statictext within w_pisr141i
end type
type dw_condition from datawindow within w_pisr141i
end type
type dw_condition2 from datawindow within w_pisr141i
end type
type gb_3 from groupbox within w_pisr141i
end type
type gb_2 from groupbox within w_pisr141i
end type
type gb_4 from groupbox within w_pisr141i
end type
type gb_1 from groupbox within w_pisr141i
end type
type dw_print from datawindow within w_pisr141i
end type
type pb_down from picturebutton within w_pisr141i
end type
end forward

global type w_pisr141i from w_ipis_sheet01
event ue_init ( )
uo_division uo_division
uo_area uo_area
rb_1 rb_1
rb_2 rb_2
dw_2 dw_2
uo_fromdate uo_fromdate
uo_todate uo_todate
st_2 st_2
dw_condition dw_condition
dw_condition2 dw_condition2
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
gb_1 gb_1
dw_print dw_print
pb_down pb_down
end type
global w_pisr141i w_pisr141i

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

on w_pisr141i.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_2=create dw_2
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_2=create st_2
this.dw_condition=create dw_condition
this.dw_condition2=create dw_condition2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_print=create dw_print
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.uo_fromdate
this.Control[iCurrent+7]=this.uo_todate
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.dw_condition
this.Control[iCurrent+10]=this.dw_condition2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.dw_print
this.Control[iCurrent+16]=this.pb_down
end on

on w_pisr141i.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_2)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_2)
destroy(this.dw_condition)
destroy(this.dw_condition2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_print)
destroy(this.pb_down)
end on

event open;call super::open;
rb_1.Checked 			= True
rb_1.Weight = 700

//dw_pisr140i_01.SetTransObject (sqlpis)
//dw_pisr140i_01.InsertRow(1) 

dw_condition.SetTransObject(sqlpis)
dw_condition.InsertRow(1)
dw_condition2.SetTransObject(sqlpis)
dw_condition2.InsertRow(1)

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

event ue_retrieve;call super::ue_retrieve;Long 		ll_Row
String	ls_suppCode, ls_itemCode, ls_FromDate, ls_ToDate, ls_productGroup
DateTime	ldt_applytime, ldt_nowtime
String	ls_nowDate

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

ls_FromDate	= uo_fromdate.is_uo_date
ls_ToDate	= uo_todate.is_uo_date

IF rb_1.Checked THEN
	ldt_nowTime		 = f_pisc_get_date_nowtime()							//현재 시스템시간
	ls_nowDate		 = Left(String(ldt_nowTime, 'yyyy.mm.dd hh:mm'), 10)
	If ls_ToDate < ls_nowDate Then 
		ldt_applytime = DateTime( Date(ls_ToDate), Time('20:00') )
	Else
		ldt_applytime = ldt_nowTime
	End If
	dw_2.DataObject = "d_pisr141i_01"
	dw_2.SetRedraw(False)
	dw_2.SetTransObject(sqlpis)
	dw_2.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup, ldt_applytime)
	dw_2.SetRedraw(True)
ELSE
	dw_2.DataObject = "d_pisr141i_02"
	dw_2.SetRedraw(False)
	dw_2.SetTransObject(sqlpis)
	dw_2.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup, ls_FromDate, ls_ToDate)
	dw_2.SetRedraw(True)
END IF

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
String	ls_suppCode, ls_itemCode, ls_FromDate, ls_ToDate, ls_productGroup
DateTime	ldt_nowTime, ldt_applytime
String	ls_nowTime
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

ls_FromDate	= uo_fromdate.is_uo_date
ls_ToDate	= uo_todate.is_uo_date

IF rb_1.Checked THEN
	ldt_nowTime	= f_pisc_get_date_nowtime()					//현재 시스템시간
	ls_nowTime	= String(ldt_nowTime, "yyyy.mm.dd hh:mm")
	
	If ls_ToDate < Left(ls_nowTime, 10) Then 
		ldt_applytime = DateTime(Date(ls_ToDate), Time('20:00'))
	Else
		ldt_applytime = ldt_nowTime
	End If
	
	dw_print.DataObject = "d_pisr141p_01"
	dw_print.SetTransObject(Sqlpis)				
	dw_print.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup, ldt_applytime )		
	lstr_prt.transaction = sqlpis
	lstr_prt.datawindow	= dw_print
	lstr_prt.title			= '가입고간판리스트 출력'
	OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
ELSE
	dw_print.DataObject = "d_pisr141p_03"
	dw_print.SetTransObject(Sqlpis)				
	dw_print.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup, ls_FromDate, ls_ToDate)		
	lstr_prt.transaction = sqlpis
	lstr_prt.datawindow	= dw_print
	lstr_prt.title			= '간판가입고이력 출력'
	OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
END IF

return 
	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr141i
end type

type uo_division from u_pisc_select_division within w_pisr141i
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

type uo_area from u_pisc_select_area within w_pisr141i
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

type rb_1 from radiobutton within w_pisr141i
integer x = 2926
integer y = 244
integer width = 539
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "현재상태"
end type

event clicked;rb_1.Weight = 700
rb_2.Weight = 400

dw_2.Reset()
end event

type rb_2 from radiobutton within w_pisr141i
integer x = 2926
integer y = 344
integer width = 544
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기간별현황"
end type

event clicked;rb_1.Weight = 400
rb_2.Weight = 700

dw_2.Reset()
end event

type dw_2 from u_vi_std_datawindow within w_pisr141i
integer x = 18
integer y = 564
integer width = 2473
integer height = 1160
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr140i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_fromdate from u_pisc_date_applydate within w_pisr141i
integer x = 1275
integer y = 76
integer taborder = 60
boolean bringtotop = true
end type

on uo_fromdate.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;
dw_2.Reset()
end event

type uo_todate from u_pisc_date_applydate_1 within w_pisr141i
integer x = 2030
integer y = 76
integer taborder = 100
boolean bringtotop = true
end type

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_2.Reset()
end event

type st_2 from statictext within w_pisr141i
integer x = 1957
integer y = 76
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

type dw_condition from datawindow within w_pisr141i
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

type dw_condition2 from datawindow within w_pisr141i
integer x = 41
integer y = 424
integer width = 1998
integer height = 104
integer taborder = 110
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

type gb_3 from groupbox within w_pisr141i
integer x = 18
integer width = 1202
integer height = 180
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr141i
integer x = 2889
integer y = 172
integer width = 617
integer height = 264
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "조건선택1"
end type

type gb_4 from groupbox within w_pisr141i
integer x = 1234
integer y = 12
integer width = 1275
integer height = 168
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr141i
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
end type

type dw_print from datawindow within w_pisr141i
integer x = 2203
integer y = 576
integer width = 1093
integer height = 1032
integer taborder = 41
boolean titlebar = true
string title = "발주간판LIST 출력"
string dataobject = "d_pisr141p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_pisr141i
integer x = 2583
integer y = 44
integer width = 155
integer height = 132
integer taborder = 70
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

event clicked;f_save_to_excel(dw_2)
end event

