$PBExportHeader$w_pisr164u.srw
$PBExportComments$외주간판 안전재고율관리
forward
global type w_pisr164u from w_ipis_sheet01
end type
type dw_pisr164u_01 from u_vi_std_datawindow within w_pisr164u
end type
type dw_condition3 from datawindow within w_pisr164u
end type
type uo_area from u_pisc_select_area within w_pisr164u
end type
type uo_division from u_pisc_select_division within w_pisr164u
end type
type uo_product from u_pisc_select_productgroup within w_pisr164u
end type
type pb_down from picturebutton within w_pisr164u
end type
type gb_1 from groupbox within w_pisr164u
end type
end forward

global type w_pisr164u from w_ipis_sheet01
integer width = 4663
event ue_init ( )
dw_pisr164u_01 dw_pisr164u_01
dw_condition3 dw_condition3
uo_area uo_area
uo_division uo_division
uo_product uo_product
pb_down pb_down
gb_1 gb_1
end type
global w_pisr164u w_pisr164u

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

on w_pisr164u.create
int iCurrent
call super::create
this.dw_pisr164u_01=create dw_pisr164u_01
this.dw_condition3=create dw_condition3
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr164u_01
this.Control[iCurrent+2]=this.dw_condition3
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_product
this.Control[iCurrent+6]=this.pb_down
this.Control[iCurrent+7]=this.gb_1
end on

on w_pisr164u.destroy
call super::destroy
destroy(this.dw_pisr164u_01)
destroy(this.dw_condition3)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 70 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr164u_01.Width = newwidth 	- ( dw_pisr164u_01.x + ls_gap * 2 )
dw_pisr164u_01.Height= newheight - ( dw_pisr164u_01.y + ls_status)
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

event open;call super::open;dw_pisr164u_01.settransobject(sqlpis)
dw_condition3.settransobject(sqlpis)

dw_condition3.insertrow(0)

this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;long ll_row

uo_status.st_message.text = ""
dw_pisr164u_01.SetRedraw(False)
dw_pisr164u_01.SetTransObject(sqlpis)
dw_condition3.accepttext()

ll_Row = dw_pisr164u_01.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	uo_product.is_uo_productgroup, istr_partkb.suppcode )
dw_pisr164u_01.SetRedraw(True)
end event

event ue_save;call super::ue_save;long ll_rowcnt, ll_curcnt
String	ls_message = "", ls_areacode, ls_divisioncode, ls_suppliercode
String  	ls_itemcode, ls_applyfrom
dec{1}   ld_safetystock
DWItemStatus ldw_status

dw_pisr164u_01.accepttext()

ll_rowcnt = dw_pisr164u_01.rowcount()

sqlpis.AutoCommit = False
for ll_curcnt = 1 to ll_rowcnt
	ldw_status = dw_pisr164u_01.getitemstatus(ll_curcnt,'safetystock', Primary!)
	
	if ldw_status = DataModified!	then
		ls_areacode = dw_pisr164u_01.getitemstring(ll_curcnt,'areacode')
		ls_divisioncode = dw_pisr164u_01.getitemstring(ll_curcnt,'divisioncode')
		ls_suppliercode = dw_pisr164u_01.getitemstring(ll_curcnt,'suppliercode')
		ls_itemcode = dw_pisr164u_01.getitemstring(ll_curcnt,'itemcode')
		ls_applyfrom = dw_pisr164u_01.getitemstring(ll_curcnt,'applyfrom')
		ld_safetystock = dw_pisr164u_01.getitemdecimal(ll_curcnt,'safetystock')
		
		//외주간판 기본정보 히스토리 업데이트
		UPDATE TMSTPARTKBHIS
		SET SafetyStock = :ld_safetystock
		WHERE AreaCode = :ls_areacode AND DivisionCode = :ls_divisioncode AND
			SupplierCode = :ls_suppliercode AND ItemCode = :ls_itemcode AND
			ApplyFrom = :ls_applyfrom 
		using sqlpis;
		
		if sqlca.sqlcode <> 0 or sqlca.sqlnrows <> 1 then
			ls_message = "tmstpartkbhis_Err"
			goto RollBack_
		end if
		
		//외주간판 기본정보 마스타 업데이트
		UPDATE TMSTPARTKB
		SET SafetyStock = :ld_safetystock
		WHERE AreaCode = :ls_areacode AND DivisionCode = :ls_divisioncode AND
			SupplierCode = :ls_suppliercode AND ItemCode = :ls_itemcode
		using sqlpis;
		
		if sqlca.sqlcode <> 0 or sqlca.sqlnrows <> 1 then
			ls_message = "tmstpartkb_Err"
			goto RollBack_
		end if
	end if
next

Commit Using sqlpis;
sqlpis.AutoCommit = True
uo_status.st_message.text = "안전재고율의 변경사항을 저장하였습니다."
//MessageBox("저장완료", "안전재고율의 변경사항을 저장하였습니다." , Information! )
Return 1 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True

CHOOSE CASE ls_message
	CASE "tmstpartkbhis_Err"
		uo_status.st_message.text = "외주간판 히스토리 저장시에 실패했습니다."
		//MessageBox( "오류", "외주간판 히스토리 저장시에 실패했습니다.", StopSign! )
	CASE "tmstpartkb_Err"
		uo_status.st_message.text = "외주간판 마스타 저장시에 실패했습니다."
		//MessageBox( "오류", "외주간판 마스타 저장시에 실패했습니다.", StopSign! )
	Case Else
		uo_status.st_message.text = "안전재고율 저장에 실패했습니다."
		//MessageBox( "실패", "안전재고율 저장에 실패했습니다.", StopSign! )
END CHOOSE

return -1
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr164u
end type

type dw_pisr164u_01 from u_vi_std_datawindow within w_pisr164u
integer x = 23
integer y = 172
integer width = 3127
integer height = 1564
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr164u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;String ls_itemcode, ls_colname

ls_colname = dwo.name
ls_itemcode = This.getitemstring(row,'itemcode')

return 0
end event

type dw_condition3 from datawindow within w_pisr164u
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
dw_pisr164u_01.Reset()
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
dw_pisr164u_01.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr164u
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

dw_pisr164u_01.Reset()
end event

type uo_division from u_pisc_select_division within w_pisr164u
integer x = 544
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;istr_partkb.divcode = is_uo_divisioncode

dw_pisr164u_01.Reset()

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
end event

type uo_product from u_pisc_select_productgroup within w_pisr164u
integer x = 1106
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr164u_01.reset()
end event

type pb_down from picturebutton within w_pisr164u
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

event clicked;
f_save_to_excel(dw_pisr164u_01)
return 0
end event

type gb_1 from groupbox within w_pisr164u
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

