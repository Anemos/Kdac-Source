$PBExportHeader$w_pisr165i.srw
$PBExportComments$실시간 미납,가입고 간판현황
forward
global type w_pisr165i from w_ipis_sheet01
end type
type dw_pisr165i_01 from u_vi_std_datawindow within w_pisr165i
end type
type uo_area from u_pisc_select_area within w_pisr165i
end type
type uo_division from u_pisc_select_division within w_pisr165i
end type
type uo_product from u_pisc_select_productgroup within w_pisr165i
end type
type pb_down from picturebutton within w_pisr165i
end type
type dw_pisr165i_02 from u_vi_std_datawindow within w_pisr165i
end type
type st_2 from statictext within w_pisr165i
end type
type st_hsplitbar from u_pism_splitbar within w_pisr165i
end type
type dw_condition from datawindow within w_pisr165i
end type
type pb_down2 from picturebutton within w_pisr165i
end type
type st_3 from statictext within w_pisr165i
end type
type st_4 from statictext within w_pisr165i
end type
type dw_down from datawindow within w_pisr165i
end type
type dw_report from datawindow within w_pisr165i
end type
type gb_1 from groupbox within w_pisr165i
end type
end forward

global type w_pisr165i from w_ipis_sheet01
integer width = 4663
event ue_init ( )
dw_pisr165i_01 dw_pisr165i_01
uo_area uo_area
uo_division uo_division
uo_product uo_product
pb_down pb_down
dw_pisr165i_02 dw_pisr165i_02
st_2 st_2
st_hsplitbar st_hsplitbar
dw_condition dw_condition
pb_down2 pb_down2
st_3 st_3
st_4 st_4
dw_down dw_down
dw_report dw_report
gb_1 gb_1
end type
global w_pisr165i w_pisr165i

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

st_hsplitbar.of_Register(dw_pisr165i_01, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_pisr165i_02, st_hsplitbar.BELOW)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

on w_pisr165i.create
int iCurrent
call super::create
this.dw_pisr165i_01=create dw_pisr165i_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.pb_down=create pb_down
this.dw_pisr165i_02=create dw_pisr165i_02
this.st_2=create st_2
this.st_hsplitbar=create st_hsplitbar
this.dw_condition=create dw_condition
this.pb_down2=create pb_down2
this.st_3=create st_3
this.st_4=create st_4
this.dw_down=create dw_down
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr165i_01
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_product
this.Control[iCurrent+5]=this.pb_down
this.Control[iCurrent+6]=this.dw_pisr165i_02
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_hsplitbar
this.Control[iCurrent+9]=this.dw_condition
this.Control[iCurrent+10]=this.pb_down2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.dw_down
this.Control[iCurrent+14]=this.dw_report
this.Control[iCurrent+15]=this.gb_1
end on

on w_pisr165i.destroy
call super::destroy
destroy(this.dw_pisr165i_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.pb_down)
destroy(this.dw_pisr165i_02)
destroy(this.st_2)
destroy(this.st_hsplitbar)
destroy(this.dw_condition)
destroy(this.pb_down2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_down)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 70 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr165i_01.Width = newwidth 	- ( dw_pisr165i_01.x + ls_gap * 2 )
dw_pisr165i_01.Height= ( newheight * 2 / 3 ) - ( dw_pisr165i_01.y + ls_status)

dw_pisr165i_02.x = dw_pisr165i_01.x
dw_pisr165i_02.y = dw_pisr165i_01.y + dw_pisr165i_01.Height + ls_split
dw_pisr165i_02.Width = dw_pisr165i_01.Width
dw_pisr165i_02.Height= newheight - (dw_pisr165i_02.y + ls_status)

st_hsplitbar.x 		= dw_pisr165i_01.x
st_hsplitbar.y 		= dw_pisr165i_02.y - ls_split
st_hsplitbar.Width 	= dw_pisr165i_01.Width 
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

event open;call super::open;dw_pisr165i_01.settransobject(sqlpis)
dw_pisr165i_02.settransobject(sqlpis)
dw_condition.settransobject(sqlpis)

dw_condition.insertrow(0)

this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;long ll_row

dw_pisr165i_02.reset()
dw_pisr165i_01.SetRedraw(False)
dw_pisr165i_01.SetTransObject(sqlpis)

dw_condition.AcceptText()
ll_Row		= dw_condition.GetRow()
istr_partkb.suppcode	= dw_condition.GetItemString(ll_Row, 'suppliercode')
If isNull(istr_partkb.suppcode) Or Trim(istr_partkb.suppcode) = '' Then 
	istr_partkb.suppcode = '%'
End If
istr_partkb.itemcode	= dw_condition.GetItemString(ll_Row, 'itemcode' )
If isNull(istr_partkb.itemcode) Or Trim(istr_partkb.itemcode) = '' Then 
	istr_partkb.itemcode = '%'
End If

ll_Row = dw_pisr165i_01.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	uo_product.is_uo_productgroup, istr_partkb.suppcode, istr_partkb.itemcode )
dw_pisr165i_01.SetRedraw(True)
end event

event ue_print;call super::ue_print;integer li_rowcnt
string mod_string

window 	l_to_open
str_easy l_str_prt

if dw_pisr165i_01.rowcount() < 1 then
	uo_status.st_message.text = "조회된 데이타가 없습니다."
	return 0
end if
								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_pisr165i_01.RowsCopy(1, dw_pisr165i_01.rowcount(), Primary!, dw_report, 1, Primary!)
dw_report.setfilter("mon2qtya > 0 or mon3qtya > 0 or mon6qtya > 0 or monnqtya > 0 " &
		+ " or mon2qtyb > 0 or mon3qtyb > 0 or mon6qtyb > 0 or monnqtyb > 0 ")
dw_report.filter()
//dw_mpm132i_01.sharedata(dw_report)
//l_str_prt.title = "부서별 MODEL별 작업완료표"
//mod_string =  "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"		

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr165i
end type

type dw_pisr165i_01 from u_vi_std_datawindow within w_pisr165i
integer x = 23
integer y = 516
integer width = 3127
integer height = 728
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr165i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;call super::doubleclicked;string ls_columnname, ls_partkbstatus, ls_areacode, ls_divisioncode, ls_itemcode
string ls_suppliercode
int li_fromday, li_today, li_row

if row < 1 then
	return 0
end if
ls_columnname = dwo.name

ls_areacode = This.getitemstring(row,'areacode')
ls_divisioncode = This.getitemstring(row,'divisioncode')
ls_itemcode = This.getitemstring(row,'itemcode')
ls_suppliercode = This.getitemstring(row,'suppliercode')
choose case ls_columnname
	case 'dayqtya'
		ls_partkbstatus = 'A'
		li_fromday = 1
		li_today = 0
	case 'day15qtya'
		ls_partkbstatus = 'A'
		li_fromday = 0
		li_today = -15
	case 'mon1qtya'
		ls_partkbstatus = 'A'
		li_fromday = -15
		li_today = -30
	case 'mon2qtya'
		ls_partkbstatus = 'A'
		li_fromday = -30
		li_today = -60
	case 'mon3qtya'
		ls_partkbstatus = 'A'
		li_fromday = -60
		li_today = -90
	case 'mon6qtya'
		ls_partkbstatus = 'A'
		li_fromday = -90
		li_today = -180
	case 'monnqtya'
		ls_partkbstatus = 'A'
		li_fromday = -180
		li_today = -9999
	case 'dayqtyb'
		ls_partkbstatus = 'B'
		li_fromday = 1
		li_today = 0
	case 'day15qtyb'
		ls_partkbstatus = 'B'
		li_fromday = 0
		li_today = -15
	case 'mon1qtyb'
		ls_partkbstatus = 'B'
		li_fromday = -15
		li_today = -30
	case 'mon2qtyb'
		ls_partkbstatus = 'B'
		li_fromday = -30
		li_today = -60
	case 'mon3qtyb'
		ls_partkbstatus = 'B'
		li_fromday = -60
		li_today = -90
	case 'mon6qtyb'
		ls_partkbstatus = 'B'
		li_fromday = -90
		li_today = -180
	case 'monnqtyb'
		ls_partkbstatus = 'B'
		li_fromday = -180
		li_today = -9999
	case else
		return 0
end choose

dw_pisr165i_02.SetRedraw(False)
dw_pisr165i_02.SetTransObject(sqlpis)

li_row = dw_pisr165i_02.Retrieve(ls_areacode, ls_divisioncode, &
	ls_suppliercode, ls_itemcode, ls_partkbstatus, li_fromday, li_today )
dw_pisr165i_02.SetRedraw(True)

return 0
end event

type uo_area from u_pisc_select_area within w_pisr165i
integer x = 105
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

dw_pisr165i_01.Reset()
end event

type uo_division from u_pisc_select_division within w_pisr165i
integer x = 599
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;istr_partkb.divcode = is_uo_divisioncode

dw_pisr165i_01.Reset()

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
end event

type uo_product from u_pisc_select_productgroup within w_pisr165i
integer x = 1161
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr165i_01.reset()
end event

type pb_down from picturebutton within w_pisr165i
integer x = 2930
integer y = 180
integer width = 343
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

ll_rowcnt = dw_pisr165i_01.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if
dw_down.reset()
dw_pisr165i_01.RowsCopy(1, dw_pisr165i_01.rowcount(), Primary!, dw_down, 1, Primary!)
dw_down.setfilter("mon2qtya > 0 or mon3qtya > 0 or mon6qtya > 0 or monnqtya > 0 " &
		+ " or mon2qtyb > 0 or mon3qtyb > 0 or mon6qtyb > 0 or monnqtyb > 0 ")
dw_down.filter()

f_save_to_excel_execute(dw_down,"1")
return 0
end event

type dw_pisr165i_02 from u_vi_std_datawindow within w_pisr165i
integer x = 32
integer y = 1264
integer width = 3104
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr165i_02"
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisr165i
integer x = 37
integer y = 432
integer width = 3022
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "미납간판 : 현재시각에서 납입예정일까지의 차이일    가입고간판 : 현재일에서 납입일까지의 차이일"
boolean focusrectangle = false
end type

type st_hsplitbar from u_pism_splitbar within w_pisr165i
integer x = 741
integer y = 1248
boolean bringtotop = true
end type

type dw_condition from datawindow within w_pisr165i
integer x = 55
integer y = 144
integer width = 2880
integer height = 224
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition"
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

dw_pisr165i_01.Reset()
dw_pisr165i_02.Reset()

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

dw_pisr165i_01.Reset()
dw_pisr165i_02.Reset()

end event

event itemerror;Return 1
end event

type pb_down2 from picturebutton within w_pisr165i
integer x = 3639
integer y = 172
integer width = 343
integer height = 112
integer taborder = 30
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
if dw_pisr165i_02.rowcount() < 1 then
	uo_status.st_message.text = "데이타가 없습니다."
	return -1
end if
f_save_to_excel_execute(dw_pisr165i_02,"1")
return 0
end event

type st_3 from statictext within w_pisr165i
integer x = 2930
integer y = 88
integer width = 603
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "전체내역 다운로드"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisr165i
integer x = 3639
integer y = 88
integer width = 640
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "상세내역 다운로드"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_down from datawindow within w_pisr165i
boolean visible = false
integer x = 3355
integer y = 504
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_pisr165i_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from datawindow within w_pisr165i
boolean visible = false
integer x = 3355
integer y = 964
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisr165i_03p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisr165i
integer x = 23
integer width = 4581
integer height = 380
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

