$PBExportHeader$w_pisr131u.srw
$PBExportComments$발주서발행및출력
forward
global type w_pisr131u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr131u
end type
type uo_division from u_pisc_select_division within w_pisr131u
end type
type dw_condition from datawindow within w_pisr131u
end type
type dw_2 from u_vi_std_datawindow within w_pisr131u
end type
type dw_scan from datawindow within w_pisr131u
end type
type rb_1 from radiobutton within w_pisr131u
end type
type rb_2 from radiobutton within w_pisr131u
end type
type dw_orderlist from datawindow within w_pisr131u
end type
type dw_print from datawindow within w_pisr131u
end type
type gb_1 from groupbox within w_pisr131u
end type
type gb_3 from groupbox within w_pisr131u
end type
type gb_2 from groupbox within w_pisr131u
end type
end forward

global type w_pisr131u from w_ipis_sheet01
integer width = 3963
event ue_init ( )
uo_area uo_area
uo_division uo_division
dw_condition dw_condition
dw_2 dw_2
dw_scan dw_scan
rb_1 rb_1
rb_2 rb_2
dw_orderlist dw_orderlist
dw_print dw_print
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
end type
global w_pisr131u w_pisr131u

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb

String	is_Null
end variables

forward prototypes
public function integer wf_setorderno ()
end prototypes

event ue_init();
SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

end event

public function integer wf_setorderno ();////////////////////////////////////
//	발주 List번호 생성 
// 발주 List번호(12) : 구분코드'8',지역(1),공장(1),업체(4),년(1),월(1),일(2),SEQ(1)
////////////////////////////////////

DateTime	ldt_nowTime
String	ls_jobDate, ls_orderNo, ls_Month
Integer	li_Month

ldt_nowTime		= f_pisc_get_date_nowtime()									//현재 시스템시간
//ls_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
ls_jobDate		= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//기준일자 -8시간고려함
//ls_applyDate	= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간,마감일 고려함
li_Month			= Integer(Mid(ls_jobDate,6,2))
CHOOSE CASE li_Month
	CASE Is<10
		ls_Month = String(li_Month)
	CASE 10
		ls_Month	= 'X'
	CASE 11
		ls_Month = 'Y'
	CASE 12
		ls_Month = 'Z'
END CHOOSE

If istr_partkb.suppcode = '%' Then Return -1

CHOOSE CASE rb_1.Checked
	CASE True
	  SELECT Max(PartOrderNo)  
		 INTO :ls_orderNo  
		 FROM TPARTORDERLIST	  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode	AND  	
				SupplierCode 	= :istr_partkb.suppcode AND  
				OrderPrintDate = :ls_jobDate    			AND
				OrderPrintFlag	= 'Y'
		USING sqlpis	;
		If isNull(ls_orderNo) Then 
			ls_orderNo = '8' + istr_partkb.areacode + istr_partkb.divcode + mid(istr_partkb.suppcode,2,4) &
			             + mid(ls_jobDate,4,1) + ls_Month + mid(ls_jobDate,9,2) + '1'
		Else 
			ls_orderNo = left(ls_orderNo, 11) + f_pisr_string1add(mid(ls_orderNo,12,1))
		End If		
		dw_scan.SetItem(1, 'scancode', ls_orderNo)

	CASE False
	  SELECT Max(PartOrderNo)  
		 INTO :ls_orderNo  
		 FROM TPARTORDERLIST	A  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode	AND  	
				SupplierCode 	= :istr_partkb.suppcode AND
				OrderPrintFlag	= 'Y'
		USING sqlpis	;
		If isNull(ls_orderNo) Then 
			MessageBox('확인', '이전에 발행된 발주서LIST가 존재하지 않습니다.', Information! )
			dw_scan.SetItem(1, 'scancode', is_null)
			Return -1
		End If		
		dw_scan.SetItem(1, 'scancode', ls_orderNo)
END CHOOSE

Return 0
end function

on w_pisr131u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_condition=create dw_condition
this.dw_2=create dw_2
this.dw_scan=create dw_scan
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_orderlist=create dw_orderlist
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_condition
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_scan
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.dw_orderlist
this.Control[iCurrent+9]=this.dw_print
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
end on

on w_pisr131u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_condition)
destroy(this.dw_2)
destroy(this.dw_scan)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_orderlist)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
ib_open = True
istr_partkb.areacode = uo_area.is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

end event

event open;call super::open;
SetNull(is_Null)

dw_condition.SetTransObject(sqlpis)
dw_condition.Reset()
dw_condition.InsertRow(1)

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)
dw_scan.Object.scancode_t.Text = '발행번호:'
dw_scan.Enabled 		= False
dw_orderlist.Visible = False
dw_print.Visible 		= False
rb_1.Checked 			= True
rb_1.Weight 			= 700

This.TriggerEvent( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;
//If istr_partkb.suppcode = '%' Then 
//	MessageBox('자료부족', '해당 업체를 선택하세요', Information! )
//	return
//End If

Long 		ll_Row
String	ls_OrderNo, ls_suppcode

dw_condition.AcceptText()
ls_suppcode = dw_condition.GetItemString(1, 'suppliercode')
If isNull(ls_suppcode) Or Trim(ls_suppcode) = '' Then
	MessageBox('자료부족', '발행할 업체를 선택하세요', Information! )
	return
End If
	

CHOOSE CASE rb_1.Checked
	CASE True
			ls_OrderNo = ''
			dw_2.SetTransObject(sqlpis)
			ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, istr_partkb.suppcode, ls_OrderNo )
			If ll_Row < 1 Then 
				MessageBox('확인', '최근 발주처리된 간판이 없습니다.', Information! )
			End If	
			
			Return
	CASE False
			dw_scan.AcceptText()
			ls_OrderNo = dw_scan.GetItemString(1, 'scancode')
			If isNull(ls_OrderNo) Or Trim(ls_OrderNo) = '' then 
				MessageBox('확인', '재발행할 발주서번호가 입력되지 않았습니다.', Information! )
				Return
			End If	
			ls_OrderNo = Trim(ls_OrderNo)
			dw_2.SetTransObject(sqlpis)
			ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, istr_partkb.suppcode, ls_OrderNo)
			
			If ll_Row < 1 Then 
				MessageBox('확인', '발주LIST 번호가 올바르지 않습니다.', Information! )
			End If	
			
			Return
END CHOOSE


end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight - ( dw_2.y + ls_status )

end event

event ue_print;call super::ue_print;
Long		ll_RowCnt
Integer	I
String	ls_suppcode, ls_orderNo
DateTime	ldt_null
str_easy lstr_prt
String	ls_message

dw_condition.AcceptText()
ls_suppcode = dw_condition.GetItemString(1, 'suppliercode')
If isNull(ls_suppcode) Or trim(ls_suppcode) = '' Then 
	MessageBox( '확인', '해당 업체가 선택되지  않았습니다.', Information! )
	Return
End If
	
dw_scan.AcceptText()
ls_orderNo = dw_scan.GetItemString( 1, 'scancode' )
If isNull(ls_orderNo) Or Trim(ls_orderNo) = '' Then
	MessageBox( '확인', '해당 발주LIST번호가 입력되지 않았습니다.', Information! )
	Return
End If

dw_2.AcceptText()
ll_RowCnt	= dw_2.RowCount()

If ll_RowCnt < 1 Then 
	MessageBox( '확인', '해당 발주LIST번호에 해당하는 간판이 존재하지 않습니다.', Information! )
	Return
End If

DateTime	ldt_nowTime
String	ls_jobDate

ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//기준일자 -8시간고려함

For I = 1 To ll_RowCnt Step 1
	dw_2.SetItem(I, 'partorderno'	, ls_orderNo)
	dw_2.SetItem(I, 'lastemp'		, 'Y')	//Interface Flag 활용
	dw_2.SetItem(I, 'lastdate'		, ldt_nowTime)
Next

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

dw_2.SetTransObject(Sqlpis)									//간판상태
If dw_2.Update() = -1 Then 
	ls_message = 'Update_Err'
//	MessageBox("저장오류", "발주LIST 정보 저장에 실패하였습니다..", StopSign! )
	Goto RollBack_			
End If

dw_orderlist.SetTransObject(Sqlpis)				
If dw_orderlist.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_orderNo) = 0 then
	//dw_orderlist.ReSet();	
	dw_orderlist.InsertRow(1)
	dw_orderlist.SetItem( 1, 'suppliercode'		, ls_suppCode )
	dw_orderlist.SetItem( 1, 'partorderno'			, ls_orderNo )
	dw_orderlist.SetItem( 1, 'partorderseq'		, right(ls_orderNo, 6))
	dw_orderlist.SetItem( 1, 'areacode'				, istr_partkb.areacode )
	dw_orderlist.SetItem( 1, 'divisioncode'		, istr_partkb.divcode )
End If

dw_orderlist.SetItem( 1, 'orderprintflag'		, 'Y' )
dw_orderlist.SetItem( 1, 'orderprintdate'		, ldt_nowTime )
SetNull(ldt_null)
dw_orderlist.SetItem( 1, 'orderreprintdate'	, ldt_null )
dw_orderlist.SetItem( 1, 'ordercancel'			, 'N' )
dw_orderlist.SetItem( 1, 'lastemp'				, 'Y' )	//Interface Flag 활용
dw_orderlist.SetItem( 1, 'lastdate'				, ldt_nowTime )

dw_orderlist.SetTransObject(Sqlpis)							//입고수량 Summary
If dw_orderlist.Update() = -1 Then 
	ls_message = 'orderlistUpdate_Err'
//	MessageBox("발주서출력오류", "발주LIST정보 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

/////
//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_orderNo)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '발주 LIST출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

If	ls_message = 'Update_Err' Then
	MessageBox("발주LIST 오류", "발주LIST 정보 저장에 실패하였습니다..", StopSign! )
ElseIf ls_message = 'orderlistUpdate_Err' Then
	MessageBox("발주LIST 오류", "발주LIST정보 저장에서 오류가 발생하였습니다.", StopSign! )
End If

return 
	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr131u
end type

type uo_area from u_pisc_select_area within w_pisr131u
integer x = 59
integer y = 72
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

End If

istr_partkb.areacode = is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)
dw_2.Reset()

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr131u
integer x = 571
integer y = 72
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)

dw_2.Reset()


end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_condition from datawindow within w_pisr131u
integer x = 50
integer y = 236
integer width = 2766
integer height = 124
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition3"
boolean border = false
boolean livescroll = true
end type

event itemchanged;str_pisr_return lstr_Rtn
String	ls_applyDate
Long		ll_Term, ll_editNo, ll_Cycle
String	ls_Null

SetNull(ls_Null)

dw_2.Reset()

lstr_Rtn.Code	= data

If isNull(lstr_Rtn.Code) Or Trim(lstr_Rtn.Code) = '' Then
	This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
	This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
	This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
	istr_partkb.suppcode = '%'
End If

  SELECT Top 1
			B.SupplierNo,   
			B.SupplierKorName  
	 INTO :lstr_Rtn.nicname,   
			:lstr_Rtn.name  
	 FROM TMSTPARTCYCLE	A,   
			TMSTSUPPLIER	B  
	WHERE A.SupplierCode = B.SupplierCode 			AND
			A.AreaCode 		= :istr_partkb.areacode AND  
			A.DivisionCode = :istr_partkb.divcode 	AND  
			A.SupplierCode = :data
	Using	sqlpis	;
	
If sqlpis.SqlCode <> 0 Then 
	MessageBox('입력오류', '업체코드가 올바르지 않습니다.', Information! )
	This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
	This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
	This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
	istr_partkb.suppcode = '%'
	Return 1
End If

This.SetItem( This.GetRow(), 'supplierno'			, lstr_Rtn.nicname )
This.SetItem( This.GetRow(), 'supplierkorname'	, lstr_Rtn.name )
istr_partkb.suppcode = lstr_Rtn.Code

wf_setorderno()

Return

end event

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_applyDate
Long		ll_Term, ll_editNo, ll_Cycle

dw_2.Reset()

istr_partkb.flag = 3			//외주업체(지역,공장)
OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then 
	istr_partkb.suppcode = '%'
	Return
End If
This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
istr_partkb.suppcode = lstr_Rtn.code

wf_setorderno()

Return

end event

event itemerror;
return 1
end event

type dw_2 from u_vi_std_datawindow within w_pisr131u
integer x = 18
integer y = 388
integer width = 2843
integer height = 1080
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr131u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_scan from datawindow within w_pisr131u
integer x = 2880
integer y = 216
integer width = 1335
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;This.SelectText(1,15)
end event

event itemchanged;
If len(data) <> 12 Or left(data,1) <> '8' Then 
	MessageBox( "입력오류", "올바른 발주LIST 번호가 아닙니다.", StopSign! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return 1
End If
end event

type rb_1 from radiobutton within w_pisr131u
integer x = 1248
integer y = 80
integer width = 466
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "신규발행"
borderstyle borderstyle = stylelowered!
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

dw_scan.Enabled = False
dw_2.Reset()
dw_scan.SetItem( 1, 'scancode', is_null )

wf_setorderno()
end event

type rb_2 from radiobutton within w_pisr131u
integer x = 1746
integer y = 80
integer width = 841
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "발주간판추가및재발행"
borderstyle borderstyle = stylelowered!
end type

event clicked;
rb_1.Weight = 400
rb_2.Weight = 700

dw_scan.Enabled = True
dw_2.Reset()
dw_scan.SetItem( 1, 'scancode', is_null )

wf_setorderno()
end event

type dw_orderlist from datawindow within w_pisr131u
integer x = 1253
integer y = 520
integer width = 1157
integer height = 1044
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "발주간판LIST 정보"
string dataobject = "d_pisr131u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_pisr131u
integer x = 2441
integer y = 516
integer width = 1093
integer height = 1032
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "발주간판LIST 출력"
string dataobject = "d_pisr131p_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisr131u
integer x = 23
integer width = 1147
integer height = 192
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

type gb_3 from groupbox within w_pisr131u
integer x = 1189
integer width = 1413
integer height = 192
integer taborder = 20
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

type gb_2 from groupbox within w_pisr131u
integer x = 23
integer y = 184
integer width = 2830
integer height = 192
integer taborder = 20
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

