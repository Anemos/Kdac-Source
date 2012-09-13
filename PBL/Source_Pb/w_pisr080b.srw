$PBExportHeader$w_pisr080b.srw
$PBExportComments$간판단위가입고취소처리(불량품)
forward
global type w_pisr080b from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr080b
end type
type uo_division from u_pisc_select_division within w_pisr080b
end type
type dw_pisr080b_02 from u_vi_std_datawindow within w_pisr080b
end type
type dw_scan from datawindow within w_pisr080b
end type
type dw_summary from datawindow within w_pisr080b
end type
type gb_3 from groupbox within w_pisr080b
end type
type gb_scan from groupbox within w_pisr080b
end type
type dw_pisr080b_01 from datawindow within w_pisr080b
end type
end forward

global type w_pisr080b from w_ipis_sheet01
integer width = 3653
event ue_process ( )
event ue_init ( )
uo_area uo_area
uo_division uo_division
dw_pisr080b_02 dw_pisr080b_02
dw_scan dw_scan
dw_summary dw_summary
gb_3 gb_3
gb_scan gb_scan
dw_pisr080b_01 dw_pisr080b_01
end type
global w_pisr080b w_pisr080b

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowTime, is_jobDate, is_applyDate	//현재시간, 작업기준일자, 마감기준일자
DateTime	idt_nowTime										//현재시간
String	is_null
end variables

forward prototypes
public function long wf_validchk ()
end prototypes

event ue_process();//////////////////////////////////
//	가입고 취소 작업 Control
//////////////////////////////////

SetPointer(HourGlass!)

If wf_validchk() = -1 Then 
	dw_pisr080b_01.ReSet() 
	dw_pisr080b_01.InsertRow(1) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.SetFocus()
	GoTo EndReturn_
End If

If dw_pisr080b_01.Event ue_save() = -1 Then 
	dw_pisr080b_01.ReSet() 
	dw_pisr080b_01.InsertRow(1) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.SetFocus()
	GoTo EndReturn_
End If

dw_pisr080b_01.RowsCopy(1,1, Primary!, dw_pisr080b_02, 1, Primary!)

EndReturn_:
SetPointer(Arrow!)
Return




end event

event ue_init();
SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

public function long wf_validchk ();
String	ls_areaCode, ls_divCode, ls_suppCode, ls_itemCode
String	ls_KBStatus, ls_useFlag, ls_kbactivegubun, ls_deliveryNo
Long		ll_Row, ll_Cnt, ll_rackQty

dw_pisr080b_01.SetTransObject (sqlpis)
ll_Row = dw_pisr080b_01.Retrieve(is_partkbno, '%')
If ll_Row = 0 Then 
	MessageBox( "입력오류", "존재하지 않는 간판입니다. ", StopSign! )
	Return -1
End If

ls_areaCode			= dw_pisr080b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr080b_01.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "입력오류", "해당 공장의 간판이 아닙니다.", StopSign! )
	Return -1
End If

ls_useFlag			= dw_pisr080b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "입력오류", "사용중단된 간판입니다. ", StopSign! )
	Return -1
End If

ls_kbactivegubun	= dw_pisr080b_01.GetItemString( ll_Row, 'kbactivegubun' )
If ls_kbactivegubun = 'S' Then 
	MessageBox( "입력오류", "Sleeping 상태의 간판입니다. ", StopSign! )
	Return -1
End If

ls_KBStatus			= dw_pisr080b_01.GetItemString( ll_Row, 'partkbstatus' )

CHOOSE CASE ls_KBStatus
CASE 'A'
	MessageBox( "입력오류", "아직 납품되지 않은 간판입니다.", StopSign! )
	Return -1
CASE 'C', 'D'
	MessageBox( "입력오류", "이미 입고처리되었거나 발주되지 않은 간판입니다.", StopSign! )
	Return -1
END CHOOSE

ls_suppCode			= dw_pisr080b_01.GetItemString( ll_Row, 'suppliercode' )
ls_itemCode			= dw_pisr080b_01.GetItemString( ll_Row, 'itemcode' )
ls_deliveryNo		= dw_pisr080b_01.GetItemString( ll_Row, 'deliveryno' )
ll_rackQty			= dw_pisr080b_01.GetItemNumber( ll_Row, 'rackqty' )

//////////////////////////////////////////////////
//		품질검사여부 확인
//////////////////////////////////////////////////
String	ls_ReceiptDate
Integer  li_Net

ls_ReceiptDate = dw_pisr080b_01.GetItemString( ll_Row, 'partreceiptdate' )
If ls_ReceiptDate < '2002.12.09' Then 
//	li_Net = MessageBox("간판확인요청", "구 시스템에서 납품받은 간판은 합격여부를 확인할 수 없습니다. ~r~n~r~n" + &
//													"해당 간판을 가입고취소처리 하시겠습니까 ?", &
//								Question!, YesNo!, 2)
//	IF li_Net <> 1 THEN	Return -1
	Return ll_Row
End If

String	ls_judgeFlag

  SELECT TQQCRESULT.JUDGEFLAG  
    INTO :ls_judgeFlag  
    FROM TQQCRESULT  
   WHERE TQQCRESULT.AREACODE 		= :ls_areaCode 	AND  
         TQQCRESULT.DIVISIONCODE = :ls_divCode 		AND  
         TQQCRESULT.SUPPLIERCODE = :ls_suppCode 	AND  
         TQQCRESULT.DELIVERYNO 	= :ls_deliveryNo 	AND  
         TQQCRESULT.ITEMCODE 		= :ls_itemCode   
	USING	sqlpis	;

CHOOSE CASE ls_judgeFlag
	CASE '1'
			MessageBox( "입력오류", "합격 처리된 간판입니다.", StopSign! )
			Return -1
//	CASE '2'
//			MessageBox( "입력오류", "불합격 처리된 간판입니다.", StopSign! )
//			Return -1
	CASE '3'
			  SELECT TQQCRESULTQTY.KBCOUNT
				 INTO :ll_Cnt  
				 FROM TQQCRESULTQTY  
				WHERE TQQCRESULTQTY.AREACODE 		= :ls_areaCode 	AND  
						TQQCRESULTQTY.DIVISIONCODE = :ls_divCode 		AND  
						TQQCRESULTQTY.SUPPLIERCODE = :ls_suppCode 	AND  
						TQQCRESULTQTY.DELIVERYNO 	= :ls_deliveryNo 	AND  
						TQQCRESULTQTY.ITEMCODE 		= :ls_itemCode 	AND  
						TQQCRESULTQTY.receptionqty	= :ll_rackQty
				USING	sqlpis	;
				
			If sqlpis.SqlCode <> 0 Then
				MessageBox( "입력오류", "품질검사여부를 확인할 수 없습니다.", StopSign! )
				Return -1
			End If	
			
			If isNull(ll_Cnt) Then ll_Cnt = 0
				
			If ll_Cnt < 1 Then
				MessageBox( "입력오류", "합격 처리된 간판입니다.", StopSign! )
				Return -1
			End If	
			li_Net = MessageBox("간판확인요청", "선별불합격 간판에 대해서는 불합격여부를 확인할 수 없습니다. ~r~n~r~n" + &
															"해당 간판을 가입고취소처리 하시겠습니까 ?", &
										Question!, OKCancel!, 2)
			IF li_Net <> 1 THEN	Return -1

	CASE '9'
			MessageBox( "입력오류", "품질검사가 완료되지 않은 간판입니다.", StopSign! )
			Return -1
END CHOOSE
 
return ll_Row


end function

on w_pisr080b.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisr080b_02=create dw_pisr080b_02
this.dw_scan=create dw_scan
this.dw_summary=create dw_summary
this.gb_3=create gb_3
this.gb_scan=create gb_scan
this.dw_pisr080b_01=create dw_pisr080b_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisr080b_02
this.Control[iCurrent+4]=this.dw_scan
this.Control[iCurrent+5]=this.dw_summary
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_scan
this.Control[iCurrent+8]=this.dw_pisr080b_01
end on

on w_pisr080b.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisr080b_02)
destroy(this.dw_scan)
destroy(this.dw_summary)
destroy(this.gb_3)
destroy(this.gb_scan)
destroy(this.dw_pisr080b_01)
end on

event open;call super::open;
SetNull(is_null)

dw_summary.Visible 		= False

dw_pisr080b_01.SetTransObject (sqlpis)
dw_pisr080b_01.InsertRow(1) 

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)

this.PostEvent ( "ue_init" )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr080b_02.Width = newwidth 	- ( dw_pisr080b_02.x + ls_gap * 2 )
dw_pisr080b_02.Height= newheight - ( dw_pisr080b_02.y + ls_status )

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

type uo_status from w_ipis_sheet01`uo_status within w_pisr080b
end type

type uo_area from u_pisc_select_area within w_pisr080b
event destroy ( )
integer x = 178
integer y = 88
integer taborder = 70
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

dw_pisr080b_01.Reset()
dw_pisr080b_01.SetTransObject(sqlpis)
dw_pisr080b_01.InsertRow(1)

dw_pisr080b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr080b
event destroy ( )
integer x = 763
integer y = 88
integer taborder = 80
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_pisr080b_01.Reset()
dw_pisr080b_01.SetTransObject(sqlpis)
dw_pisr080b_01.InsertRow(1)

dw_pisr080b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_pisr080b_02 from u_vi_std_datawindow within w_pisr080b
integer x = 14
integer y = 1104
integer width = 3584
integer height = 788
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr080b_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

return 1

end event

type dw_scan from datawindow within w_pisr080b
integer x = 32
integer y = 240
integer width = 1335
integer height = 148
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;This.SelectText(1,15)
end event

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "확인", "작업처리 권한이 부여되지 않았습니다.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 11 Then 
	MessageBox( "입력오류", "올바른 간판번호 가 아닙니다.", StopSign! )
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간고려함
is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간,마감일 고려함

is_partkbno = data
parent.TriggerEvent( "ue_process" )

this.Event getfocus()
end event

type dw_summary from datawindow within w_pisr080b
integer x = 1234
integer y = 1088
integer width = 832
integer height = 848
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "간판수량 Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisr080b
integer x = 18
integer width = 1358
integer height = 208
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

type gb_scan from groupbox within w_pisr080b
integer x = 18
integer y = 196
integer width = 1358
integer height = 208
integer taborder = 20
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

type dw_pisr080b_01 from datawindow within w_pisr080b
event type integer ue_save ( )
integer x = 5
integer y = 408
integer width = 3589
integer height = 696
integer taborder = 30
string title = "none"
string dataobject = "d_pisr080b_01"
boolean border = false
boolean livescroll = true
end type

event type integer ue_save();////////////////////////////////////////////////////////////
//		가입고취소 간판 저장
////////////////////////////////////////////////////////////
String	ls_suppCode, ls_itemCode
String	ls_receiptdate
DateTime	ldt_receiptTime
Long		ll_Row, ll_Qty, ll_qtySum
String	ls_compMonth, ls_compMonth2
Integer	li_null
DateTime ldt_null
String	ls_message = ''

SetNull( li_null )
SetNull( ldt_null )

ls_compMonth	= left(is_applydate, 7)

this.AcceptText()
ll_Row			= this.GetRow()
ls_suppCode		= this.GetItemString(ll_Row	, 'suppliercode')
ls_itemCode		= this.GetItemString(ll_Row	, 'itemcode')
//※ 가입고일자(Real), 월마감무시  2002.10.30
//ls_receiptdate	= this.GetItemString(ll_Row	, 'partreceiptdate')
ldt_receiptTime= this.GetItemDateTime(ll_Row	, 'partreceipttime')
ls_receiptdate	= left(String(ldt_receiptTime, "yyyy.mm.dd hh:mm"),10)
ll_Qty			= this.GetItemNumber(ll_Row	, 'rackqty')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	가입고 수량 Summary 저장
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_receiptdate, istr_partkb.areacode, istr_partkb.divCode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err'
//	MessageBox("가입고취소오류", "가입고 Summary정보를 읽지 못했습니다.", StopSign! )
	Goto RollBack_			
End If
////※ 가입고일자(Real), 월마감무시  2002.10.30
//ls_compMonth2 = left( ls_receiptdate, 7 )		//가입고기준월
//If ls_compMonth > ls_compMonth2 Then
//	dw_summary.SetTransObject(Sqlpis)				
//	If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divCode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.ReSet();	dw_summary.InsertRow(1)
//		dw_summary.SetItem( 1, 'applydate'		, is_applydate )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divCode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' ) //Interface Flag 활용
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partreceiptqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partreceiptqty', ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' ) //Interface Flag 활용
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)				//가입고취소 Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("가입고취소오류", "가입고취소간판 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

/////////////////////////////////////////////////////
//		가입고 간판 취소 Setting
/////////////////////////////////////////////////////
dw_pisr080b_01.SetItem(ll_Row, 'partkbstatus'		, 'A')	//발주상태로 전환
dw_pisr080b_01.SetItem(ll_Row, 'partreceiptcancel'	, 'Y')	//가입고취소 구분
dw_pisr080b_01.SetItem(ll_Row, 'partobeydateflag'	, 0)		//발주상태로 전환
dw_pisr080b_01.SetItem(ll_Row, 'partobeytimeflag'	, 0)		//발주상태로 전환
dw_pisr080b_01.SetItem(ll_Row, 'partreceiptdate'	, is_null )		//납입일자
dw_pisr080b_01.SetItem(ll_Row, 'parteditno'			, li_null )		//납입편수
dw_pisr080b_01.SetItem(ll_Row, 'partreceipttime'	, ldt_null )	//납입시간
dw_pisr080b_01.SetItem(ll_Row, 'DeliveryNo'			, is_null )		//납품표번호
dw_pisr080b_01.SetItem(ll_Row, 'lastemp'				, 'Y')	//Interface Flag 활용
dw_pisr080b_01.SetItem(ll_Row, 'lastdate'				, idt_nowTime)	//작업시간

this.SetTransObject(Sqlpis)									//간판상태
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("가입고취소오류", "가입고취소간판 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
Return 0

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
If ls_message = 'summaryRetrieve_Err' Then
	MessageBox("가입고취소오류", "가입고 Summary정보를 읽지 못했습니다.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err' Then
	MessageBox("가입고취소오류", "가입고취소간판 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("가입고취소오류", "가입고취소간판 저장에서 오류가 발생하였습니다.", StopSign! )
Else 
	MessageBox("가입고취소오류", "가입고취소처리에 실패하였습니다.", StopSign! )
End If
return -1


end event

event clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

