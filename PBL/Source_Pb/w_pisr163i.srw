$PBExportHeader$w_pisr163i.srw
$PBExportComments$실시간 간판운영매수 조회
forward
global type w_pisr163i from w_ipis_sheet01
end type
type dw_pisr163i_01 from u_vi_std_datawindow within w_pisr163i
end type
type dw_condition3 from datawindow within w_pisr163i
end type
type uo_area from u_pisc_select_area within w_pisr163i
end type
type uo_division from u_pisc_select_division within w_pisr163i
end type
type uo_product from u_pisc_select_productgroup within w_pisr163i
end type
type pb_down from picturebutton within w_pisr163i
end type
type st_3 from statictext within w_pisr163i
end type
type st_5 from statictext within w_pisr163i
end type
type st_6 from statictext within w_pisr163i
end type
type st_7 from statictext within w_pisr163i
end type
type st_8 from statictext within w_pisr163i
end type
type st_2 from statictext within w_pisr163i
end type
type st_9 from statictext within w_pisr163i
end type
type st_11 from statictext within w_pisr163i
end type
type dw_down from datawindow within w_pisr163i
end type
type st_4 from statictext within w_pisr163i
end type
type gb_1 from groupbox within w_pisr163i
end type
type gb_2 from groupbox within w_pisr163i
end type
end forward

global type w_pisr163i from w_ipis_sheet01
integer width = 4663
event ue_init ( )
dw_pisr163i_01 dw_pisr163i_01
dw_condition3 dw_condition3
uo_area uo_area
uo_division uo_division
uo_product uo_product
pb_down pb_down
st_3 st_3
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_2 st_2
st_9 st_9
st_11 st_11
dw_down dw_down
st_4 st_4
gb_1 gb_1
gb_2 gb_2
end type
global w_pisr163i w_pisr163i

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
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

on w_pisr163i.create
int iCurrent
call super::create
this.dw_pisr163i_01=create dw_pisr163i_01
this.dw_condition3=create dw_condition3
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.pb_down=create pb_down
this.st_3=create st_3
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_2=create st_2
this.st_9=create st_9
this.st_11=create st_11
this.dw_down=create dw_down
this.st_4=create st_4
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr163i_01
this.Control[iCurrent+2]=this.dw_condition3
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_product
this.Control[iCurrent+6]=this.pb_down
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.st_8
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_11
this.Control[iCurrent+15]=this.dw_down
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
end on

on w_pisr163i.destroy
call super::destroy
destroy(this.dw_pisr163i_01)
destroy(this.dw_condition3)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.pb_down)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_2)
destroy(this.st_9)
destroy(this.st_11)
destroy(this.dw_down)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 70 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr163i_01.Width = newwidth 	- ( dw_pisr163i_01.x + ls_gap * 2 )
dw_pisr163i_01.Height= newheight - ( dw_pisr163i_01.y + ls_status)
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
end event

event open;call super::open;dw_pisr163i_01.settransobject(sqlpis)
dw_condition3.settransobject(sqlpis)

dw_condition3.insertrow(0)

this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;long ll_row

dw_pisr163i_01.SetRedraw(False)
dw_pisr163i_01.SetTransObject(sqlpis)
dw_condition3.accepttext()

ll_Row = dw_pisr163i_01.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	uo_product.is_uo_productgroup, istr_partkb.suppcode )
dw_pisr163i_01.SetRedraw(True)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr163i
end type

type dw_pisr163i_01 from u_vi_std_datawindow within w_pisr163i
integer x = 23
integer y = 496
integer width = 3127
integer height = 1240
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr163i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;// dupchk = 1 이면 이원화 업체 정보 보여줌
String ls_itemcode, ls_colname
long ll_dupchk

if row < 1 then
	return 0
end if

ls_colname = dwo.name
ls_itemcode = This.getitemstring(row,'itemcode')
ll_dupchk = This.getitemnumber(row,'dupchk')

if ll_dupchk = 1 and ls_colname = 'comp_chk' then
	istr_partkb.itemcode = ls_itemcode
	OpenWithParm ( w_pisr145r, istr_partkb )
end if
return 0
end event

type dw_condition3 from datawindow within w_pisr163i
integer x = 2007
integer y = 44
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
dw_pisr163i_01.Reset()
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
dw_pisr163i_01.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr163i
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

dw_pisr163i_01.Reset()
end event

type uo_division from u_pisc_select_division within w_pisr163i
integer x = 544
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;istr_partkb.divcode = is_uo_divisioncode

dw_pisr163i_01.Reset()

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
end event

type uo_product from u_pisc_select_productgroup within w_pisr163i
integer x = 1106
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr163i_01.reset()
end event

type pb_down from picturebutton within w_pisr163i
integer x = 4050
integer y = 36
integer width = 155
integer height = 112
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

event clicked;long ll_rowcnt

ll_rowcnt = dw_pisr163i_01.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if
dw_down.reset()
dw_pisr163i_01.sharedata(dw_down)
f_save_to_excel(dw_down)
return 0
end event

type st_3 from statictext within w_pisr163i
integer x = 59
integer y = 264
integer width = 1554
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "2. 총발행간판 : 발행된 총간판수"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisr163i
integer x = 59
integer y = 336
integer width = 1554
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "3. Active간판 : 간판이 Active상태 인 것"
boolean focusrectangle = false
end type

type st_6 from statictext within w_pisr163i
integer x = 59
integer y = 420
integer width = 1554
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "4. Sleep간판 : 간판이 Sleep상태인것"
boolean focusrectangle = false
end type

type st_7 from statictext within w_pisr163i
integer x = 2304
integer y = 188
integer width = 1723
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "5. 현재운영매수 : 간판의 상태가 발주, 가입고상태인것"
boolean focusrectangle = false
end type

type st_8 from statictext within w_pisr163i
integer x = 2304
integer y = 264
integer width = 736
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "6. 이론운영매수"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisr163i
integer x = 1065
integer y = 256
integer width = 878
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = " (= Active간판 + Sleep간판)"
boolean focusrectangle = false
end type

type st_9 from statictext within w_pisr163i
integer x = 2304
integer y = 420
integer width = 1472
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "7. 차이운영매수 : 이론운영매수 - 현재운영매수"
boolean focusrectangle = false
end type

type st_11 from statictext within w_pisr163i
integer x = 59
integer y = 188
integer width = 2181
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "1. 대상간판 : 임시간판 + 정규간판 ( Warning&운영품번등록=>대상품번 )"
boolean focusrectangle = false
end type

type dw_down from datawindow within w_pisr163i
boolean visible = false
integer x = 3502
integer y = 648
integer width = 251
integer height = 400
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_pisr163i_01_p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pisr163i
integer x = 2368
integer y = 336
integer width = 2222
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = " = (일일소요량/수용수) * (납입Term*(1+납입Cycle)/납입편수+안전재고일)"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisr163i
integer x = 23
integer width = 4581
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr163i
integer x = 23
integer y = 144
integer width = 4585
integer height = 348
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

