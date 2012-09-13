$PBExportHeader$w_pisr070b.srw
$PBExportComments$납품표단위 가입고/가입고삭제
forward
global type w_pisr070b from w_ipis_sheet01
end type
type rb_1 from radiobutton within w_pisr070b
end type
type rb_2 from radiobutton within w_pisr070b
end type
type dw_pisr070b_01 from u_vi_std_datawindow within w_pisr070b
end type
type uo_area from u_pisc_select_area within w_pisr070b
end type
type uo_division from u_pisc_select_division within w_pisr070b
end type
type st_2 from statictext within w_pisr070b
end type
type st_totkbcnt from statictext within w_pisr070b
end type
type dw_partedit from datawindow within w_pisr070b
end type
type dw_summary from datawindow within w_pisr070b
end type
type dw_lastedit from datawindow within w_pisr070b
end type
type dw_pisr070b_02 from datawindow within w_pisr070b
end type
type dw_pisr070b_03 from datawindow within w_pisr070b
end type
type gb_2 from groupbox within w_pisr070b
end type
type dw_scan from datawindow within w_pisr070b
end type
type gb_3 from groupbox within w_pisr070b
end type
type gb_scan from groupbox within w_pisr070b
end type
end forward

global type w_pisr070b from w_ipis_sheet01
event ue_process ( )
event ue_init ( )
rb_1 rb_1
rb_2 rb_2
dw_pisr070b_01 dw_pisr070b_01
uo_area uo_area
uo_division uo_division
st_2 st_2
st_totkbcnt st_totkbcnt
dw_partedit dw_partedit
dw_summary dw_summary
dw_lastedit dw_lastedit
dw_pisr070b_02 dw_pisr070b_02
dw_pisr070b_03 dw_pisr070b_03
gb_2 gb_2
dw_scan dw_scan
gb_3 gb_3
gb_scan gb_scan
end type
global w_pisr070b w_pisr070b

type variables
str_pisr_partkb istr_partkb
String	is_deliveryno
String	is_nowTime, is_jobDate, is_applyDate	//현재시간, 작업기준일자, 마감기준일자
DateTime	idt_nowTime										//현재시간
String	is_null
end variables

forward prototypes
public function integer wf_lastedit (str_pisr_partkb astr_partkb, long al_editno)
public function integer wf_sumadd (str_pisr_partkb astr_partkb, long al_qty)
public function integer wf_validchk ()
public function integer wf_receiptcalc (long al_rowcount)
end prototypes

event ue_process();Long		ll_Row
String	ls_nowDate

ls_nowDate	= left(is_nowtime, 10)

SetPointer(HourGlass!)
If wf_validchk() = -1 Then GoTo EndReturn_

CHOOSE CASE rb_1.Checked
CASE True		//가입고등록
		dw_pisr070b_01.SetRedraw ( False )
		dw_pisr070b_01.SetTransObject( sqlpis )
		ll_Row = dw_pisr070b_01.Retrieve( is_deliveryno, 'A', ls_nowDate )		//'A'발주상태
		dw_pisr070b_01.SetRedraw ( True )
		If ll_Row < 1 Then 
			MessageBox( "납품표 오류", "납품할 자재가 존재하지 않는 번호 입니다.", StopSign! )
			GoTo EndReturn_
		End If

		If wf_receiptcalc( ll_Row ) = -1 Then GoTo EndReturn_
		If dw_pisr070b_01.Event ue_save() = -1 Then 
			st_totkbcnt.Text = '0 매'
			GoTo EndReturn_
		Else
			uo_status.st_message.text =  String(ll_Row, '#,##0') + ' 매의 간판이 가입고처리 되었습니다.'
			st_totkbcnt.Text = String(ll_Row, '#,##0') + ' 매'
		End If

CASE ELSE		//가입고취소
		dw_pisr070b_01.SetRedraw ( False )
		dw_pisr070b_01.SetTransObject( sqlpis )
		ll_Row = dw_pisr070b_01.Retrieve( is_deliveryno, 'B', ls_nowDate )		//'B'가입고상태

		dw_pisr070b_01.SetRedraw ( True )
		If dw_pisr070b_01.Event ue_cancelsave() = -1 Then 
			st_totkbcnt.Text = '0 매'
			GoTo EndReturn_
		Else
			uo_status.st_message.text =  String(ll_Row, '#,##0') + ' 매의 간판이 가입고삭제 되었습니다.'
			st_totkbcnt.Text = String(ll_Row, '#,##0') + ' 매'
		End If
END CHOOSE

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

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  '가입고 처리대기중입니다.'
st_totkbcnt.Text = '0 매'

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

public function integer wf_lastedit (str_pisr_partkb astr_partkb, long al_editno);////////////////////////////////////
// 	마지막 편수 저장
////////////////////////////////////

dw_lastedit.ReSet()
dw_lastedit.SetTransObject(Sqlpis)				
If dw_lastedit.Retrieve(astr_partkb.areacode, astr_partkb.divcode, astr_partkb.suppCode, astr_partkb.itemCode, 'B') = 0 then	//가입고
	dw_lastedit.InsertRow(1)
	dw_lastedit.SetItem(1, 'areacode'		, astr_partkb.areacode )
	dw_lastedit.SetItem(1, 'divisioncode'	, astr_partkb.divcode )
	dw_lastedit.SetItem(1, 'suppliercode'	, astr_partkb.suppCode )
	dw_lastedit.SetItem(1, 'itemcode'		, astr_partkb.itemCode )
	dw_lastedit.SetItem(1, 'ordergubun'		, 'B' )				//A:발주, B:납입(가입고)
	dw_lastedit.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag 활용
	dw_lastedit.SetItem(1, 'lastdate'		, idt_nowTime )
End If
dw_lastedit.SetItem(1, 'partlasteditdate'	, astr_partkb.applydate )
dw_lastedit.SetItem(1, 'parteditno'			, al_editno )
dw_lastedit.SetItem(1, 'lastemp'				, 'Y' )		//Interface Flag 활용
dw_lastedit.SetItem(1, 'lastdate'			, idt_nowTime )

dw_lastedit.SetTransObject(Sqlpis)									//(발주)마지막 편수
If dw_lastedit.Update() = -1 Then 		
//	MessageBox("가입고오류", "마지막 편수 저장에서 오류가 발생하였습니다.", StopSign! )
	Return -1
End If

Return 0
end function

public function integer wf_sumadd (str_pisr_partkb astr_partkb, long al_qty);////////////////////////////////////////
//		가입고 수량 Summary저장(증가)
////////////////////////////////////////
Long ll_qtySum
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(astr_partkb.applydate, astr_partkb.areacode, astr_partkb.divcode, astr_partkb.suppcode, astr_partkb.itemcode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem(1, 'applydate'	, astr_partkb.applydate )
	dw_summary.SetItem(1, 'areacode'		, astr_partkb.areacode )
	dw_summary.SetItem(1, 'divisioncode', astr_partkb.divcode )
	dw_summary.SetItem(1, 'suppliercode', astr_partkb.suppCode )
	dw_summary.SetItem(1, 'itemcode'		, astr_partkb.itemCode )
	dw_summary.SetItem(1, 'lastemp'		, 'Y' )		//Interface Flag활용
	dw_summary.SetItem(1, 'lastdate'		, idt_nowTime )
End If

ll_qtySum = dw_summary.GetItemNumber(1	, 'partreceiptqty' )
ll_qtySum = ll_qtySum + al_qty									//가입고수량증가
dw_summary.SetItem(1, 'partreceiptqty'	, ll_qtySum )
dw_summary.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag활용
dw_summary.SetItem(1, 'lastdate'			, idt_nowTime )

dw_summary.SetTransObject(Sqlpis)								//발주 Summary
If dw_summary.Update() = -1 Then 
//	MessageBox("가입고오류", "가입고수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	Return -1			
End If

Return 0
end function

public function integer wf_validchk ();String	ls_areaCode, ls_divCode, ls_suppCode
String	ls_PrintFlag, ls_Confirm, ls_Cancel
Long		ll_Cnt
str_pisr_partkb lstr_partkb

  SELECT TDELIVERYLIST.Suppliercode,   
         TDELIVERYLIST.AreaCode,   
         TDELIVERYLIST.DivisionCode,   
         TDELIVERYLIST.DeliveryPrintFlag,   
         TDELIVERYLIST.DeliveryConfirm,   
         TDELIVERYLIST.DeliveryCancel   
    INTO :ls_suppCode,   
         :ls_areaCode,   
         :ls_divCode,   
         :ls_PrintFlag,   
         :ls_Confirm,   
         :ls_Cancel   
    FROM TDELIVERYLIST  
   WHERE TDELIVERYLIST.DeliveryNo = :is_deliveryno
   USING	sqlpis	;
	
If sqlpis.SqlCode <> 0 Then 
	MessageBox("납품표오류", "존재하지 않는 번호 입니다.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox("납품표오류", "해당 공장에 납품될 납품표번호가 아닙니다.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If ls_PrintFlag = 'N' Then 
	MessageBox("납품표오류", "아직 발행되지 않는 번호 입니다.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If rb_1.Checked Then				//가입고등록
	If ls_Confirm = 'Y' Then 
		MessageBox("납품표오류", "이미 납품처리된 납품표번호입니다.", StopSign!) 
		dw_scan.SetItem(1, 'scancode', is_null )
		dw_scan.Object.scancode.SetFocus()
		Return -1
	End If
Else									//가입고 취소일 경우
	If ls_Confirm = 'N' Then 
		MessageBox("가입고취소불능", "아직 납입되지 않은 납품표번호입니다.", StopSign!) 
		dw_scan.SetItem(1, 'scancode', is_null )
		dw_scan.Object.scancode.SetFocus()
		Return -1
	End If
End If

If ls_Cancel = 'Y' Then 
	MessageBox("납품표오류", "납품 취소 된 번호입니다.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If rb_2.Checked Then					//가입고 취소일 경우

	  SELECT Count(partKBNo)
		 INTO :ll_Cnt
		 FROM TPARTKBHIS	   
		WHERE AreaCode 			= :ls_areaCode 	And
				DivisionCode		= :ls_divCode 		And
				SupplierCode		= :ls_suppCode 	And
				DeliveryNo 			= :is_deliveryno 	
		USING	sqlpis	;
		
	If ll_Cnt > 0 Then 
		MessageBox("가입고취소불능", "이미 입고처리된 간판이 존재합니다.", StopSign!)
		dw_scan.SetItem(1, 'scancode', is_null )
		dw_scan.Object.scancode.SetFocus()
		Return -1
	End If

//	  SELECT Count(partKBNo)
//		 INTO :ll_Cnt
//		 FROM TPARTKBSTATUS	   
//		WHERE AreaCode 			= :ls_areaCode 	And
//				DivisionCode		= :ls_divCode 		And
//				SupplierCode		= :ls_suppCode 	And
//				PartReceiptCancel = 'Y'				 	And
//				DeliveryNo 			= :is_deliveryno 	And
//				PartKBStatus 		= 'A' 	//'A'발주상태( 불량품확정시 간판단위 가입고취소 )
//		USING	sqlpis	;
//		
//	If ll_Cnt > 0 Then 
//		MessageBox("가입고취소불능", "이미 품질검사 후 가입고취소 처리된 간판이 존재합니다.", StopSign!)
//		dw_scan.SetItem(1, 'scancode', is_null )
//		dw_scan.Object.scancode.SetFocus()
//		Return -1
//	End If

	  SELECT count(A.DELIVERYNO)  
		 INTO :ll_Cnt  
		 FROM TQQCRESULT 	A 
		WHERE A.AREACODE 		= :ls_areaCode 	AND  
				A.DIVISIONCODE = :ls_divCode 		AND  
				A.SUPPLIERCODE = :ls_suppCode 	AND  
				A.DELIVERYNO 	= :is_deliveryno 	AND  
				A.JUDGEFLAG 	<> '9'    			AND
				(Not Exists ( Select 	* 
							from 		TQQCITEM		B
							Where 	A.AREACODE 		= B.AREACODE 		And
										A.DIVISIONCODE = B.DIVISIONCODE 	And
										A.ITEMCODE 		= B.ITEMCODE 		And
										A.SUPPLIERCODE = B.SUPPLIERCODE 	And 
										B.QCGUBUN 		= 'C' 				And 
										B.APPLYDATEFROM <= :is_jobdate	))
		USING	sqlpis	;
		
	If ll_Cnt > 0 Then 
		MessageBox("가입고취소불능", "이미 품질검사가 종료된 항목이 존재합니다.", StopSign!)
		dw_scan.SetItem(1, 'scancode', is_null )
		dw_scan.Object.scancode.SetFocus()
		Return -1
	End If
End If

Return 0

end function

public function integer wf_receiptcalc (long al_rowcount);String	ls_PartKBNo, ls_suppCode, ls_chkstop
Integer	I
String	ls_ChangeFlag, ls_ForecastDate
Long		ll_ForecastEditNo, ll_Row, ll_editNo
Datetime	ldt_ForecastTime, ldt_editTime
String	ls_editTime
Long 		ll_Gap, ll_worstGap

ll_worstGap	= 25		//하루 24시간 + 1 

dw_pisr070b_01.AcceptText()

ls_suppCode = dw_pisr070b_01.GetItemString( 1, 'suppliercode' )	//납품업체 코드

/////////////////////////////////////////////
// 중단업체인 경우에 가입고 불가 - 2004.09.17
/////////////////////////////////////////////
SELECT ISNULL(TMSTSUPPLIER.Xstop,'')  
	INTO :ls_chkstop  
	FROM TMSTSUPPLIER  
	WHERE TMSTSUPPLIER.SupplierCode = :ls_suppCode   
	using sqlpis;

if ls_chkstop = 'X' then
	MessageBox( "가입고오류" ,"거래중단된 외주업체입니다.", StopSign! )
	Return -1
end if
/////////////////////////////////////////////
//	납입 편수 계산
/////////////////////////////////////////////
dw_partedit.SetTransObject( sqlpis )
ll_Row = dw_partedit.Retrieve(istr_partkb.areacode, istr_partkb.divcode, is_jobdate, ls_suppCode)
If ll_Row < 1 Then 
	MessageBox( "가입고오류" ,"외주업체 납입편수 정보가 없습니다.", StopSign! )
	Return -1
End If

For I = 1 To ll_Row Step 1
	ls_editTime 	 = dw_partedit.GetItemString( I, 'partedittime' )						//업체 납입예정시간
	If ls_editTime >= '00:00' AND ls_editTime < '08:00' Then
		ldt_editTime = DateTime(Date(f_pisr_getdaybefore( is_jobdate, 1 )),Time(ls_editTime))
	Else 
		ldt_editTime = DateTime(Date(is_jobdate), Time(ls_editTime))
	End If
	ll_Gap	= Abs(f_pisr_datediff('Hour', ldt_editTime, idt_nowTime, sqlpis))
	If ll_worstGap > ll_Gap Then
		ll_editNo	= dw_partedit.GetItemNumber( I, 'parteditno' )						//업체 납입편수
		ll_worstGap	= ll_Gap
	End If
Next

////////////////////////////////////////////////////////////////
// 각 간판 납입준수 여부계산 및 납입일자 및 시간계산 수량계산
////////////////////////////////////////////////////////////////
For I = 1 To al_rowcount Step 1
	ls_PartKBNo			= dw_pisr070b_01.GetItemString( I, 'partkbno' )
	ls_ChangeFlag 		= dw_pisr070b_01.GetItemString( I, 'orderchangeflag' )
	CHOOSE CASE Upper(ls_ChangeFlag)
	CASE 'Y'		//납입예정일변경
			ls_ForecastDate	= dw_pisr070b_01.GetItemString( I	, 'changeforecastdate' )
			ll_ForecastEditNo	= dw_pisr070b_01.GetItemNumber( I	, 'changeforecasteditno' )
			ldt_ForecastTime	= dw_pisr070b_01.GetItemDateTime( I	, 'changeforecasttime' )
	CASE 'N'		//미변경
			ls_ForecastDate	= dw_pisr070b_01.GetItemString( I	, 'partforecastdate' )
			ll_ForecastEditNo	= dw_pisr070b_01.GetItemNumber( I	, 'partforecasteditno' )
			ldt_ForecastTime	= dw_pisr070b_01.GetItemDateTime( I	, 'partforecasttime' )
	CASE ELSE	//변경Flag오류
			MessageBox("가입고 오류", ls_PartKBNo + " 간판에서 발주변경Flag에 잘못된 정보가 입력되었습니다.", StopSign!)
			Return -1
	END CHOOSE
	If is_jobdate = ls_ForecastDate Then 									//날자 준수
		dw_pisr070b_01.SetItem( I, 'partobeydateflag', 1 )				
		If Abs(f_pisr_datediff( 'minute', ldt_ForecastTime, idt_nowTime, sqlpis )) <= 60 Then 	
			dw_pisr070b_01.SetItem( I, 'partobeytimeflag', 1 )			//시간 준수 ±1시간
		Else																			
			dw_pisr070b_01.SetItem( I, 'partobeytimeflag', 0 )			//납입시간 미준수 
		End If
	Else																				//날자 미준수
		dw_pisr070b_01.SetItem( I, 'partobeydateflag', 0 )	
		dw_pisr070b_01.SetItem( I, 'partobeytimeflag', 0 )
	End If
	dw_pisr070b_01.SetItem( I, 'partreceiptdate'	, is_jobdate )		//납입일자(Shift단위 일자)
	dw_pisr070b_01.SetItem( I, 'parteditno'		, ll_editNo )		//납입편수
	dw_pisr070b_01.SetItem( I, 'partreceipttime'	, idt_nowTime )	//납입시간(실제납입시간)

//	가입고간판 설정
	dw_pisr070b_01.SetItem( I, 'partkbstatus'			, 'B' )			//발주 -> 가입고상태로 전환
//	dw_pisr070b_01.SetItem( I, 'partreceiptcalcel'	, 'N' )			//가입고 취소
	dw_pisr070b_01.SetItem( I, 'lastemp'				, 'Y' )	//Interface Flag 활용
	dw_pisr070b_01.SetItem( I, 'lastdate'				, idt_nowTime )//작업시간
	
Next

Return 0
end function

on w_pisr070b.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_pisr070b_01=create dw_pisr070b_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.st_totkbcnt=create st_totkbcnt
this.dw_partedit=create dw_partedit
this.dw_summary=create dw_summary
this.dw_lastedit=create dw_lastedit
this.dw_pisr070b_02=create dw_pisr070b_02
this.dw_pisr070b_03=create dw_pisr070b_03
this.gb_2=create gb_2
this.dw_scan=create dw_scan
this.gb_3=create gb_3
this.gb_scan=create gb_scan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.dw_pisr070b_01
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_totkbcnt
this.Control[iCurrent+8]=this.dw_partedit
this.Control[iCurrent+9]=this.dw_summary
this.Control[iCurrent+10]=this.dw_lastedit
this.Control[iCurrent+11]=this.dw_pisr070b_02
this.Control[iCurrent+12]=this.dw_pisr070b_03
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.dw_scan
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_scan
end on

on w_pisr070b.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_pisr070b_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.st_totkbcnt)
destroy(this.dw_partedit)
destroy(this.dw_summary)
destroy(this.dw_lastedit)
destroy(this.dw_pisr070b_02)
destroy(this.dw_pisr070b_03)
destroy(this.gb_2)
destroy(this.dw_scan)
destroy(this.gb_3)
destroy(this.gb_scan)
end on

event open;call super::open;
SetNull(is_null)
rb_1.Checked 	= True
rb_1.Weight 	= 700


dw_partedit.Visible 		= False
dw_summary.Visible 		= False
dw_lastedit.Visible 		= False
dw_pisr070b_02.Visible 	= False
dw_pisr070b_03.Visible 	= False

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)
dw_scan.Object.scancode_t.Text = '납품표번호:'

this.PostEvent ( "ue_init" )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr070b_01.Width = newwidth 	- ( dw_pisr070b_01.x + ls_gap * 2 )
dw_pisr070b_01.Height= newheight - ( dw_pisr070b_01.y + ls_status )

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

type uo_status from w_ipis_sheet01`uo_status within w_pisr070b
end type

type rb_1 from radiobutton within w_pisr070b
integer x = 1312
integer y = 68
integer width = 521
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "가입고등록"
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  '가입고 처리대기중입니다.'
st_totkbcnt.Text = '0 매'

is_deliveryno	 = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type rb_2 from radiobutton within w_pisr070b
integer x = 1856
integer y = 68
integer width = 521
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "가입고삭제"
end type

event clicked;
rb_1.Weight = 400
rb_2.Weight = 700

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  '가입고 삭제대기중입니다.'
st_totkbcnt.Text = '0 매'


dw_scan.SetItem(1, 'scancode', is_Null )
//dw_scan.Object.scancode.SetFocus()
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
//dw_scan.SelectRow(1,True)

end event

type dw_pisr070b_01 from u_vi_std_datawindow within w_pisr070b
event type integer ue_save ( )
event type integer ue_cancelsave ( )
integer x = 14
integer y = 392
integer width = 3584
integer height = 1504
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr070b_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event type integer ue_save();String	ls_suppCode, ls_itemCode, ls_DeliveryNo
String	ls_receiptDate				//납입일자
DateTime	ldt_receiptTime			//납입시간
Integer	I								//첨자
String	ls_nowDate, ls_nowTime	//납일일자,납입시간
String	ls_olditemCode	= ''		//이전품번
Long		ll_editNo					//납입편수
Long     ll_oldeditNo            //이전품번납입편수
Long 		ll_RowCount					//총간판매수
Long		ll_RackQty					//수용수
Long		ll_oldRackQty	= 0		//이전수용수
Long		ll_kbCnt			= 0		//간판매수
Long		ll_napipQty		= 0		//납입수량
Long		ll_qcCnt						//유검사품 확인 0보다 커면 유검사품
Long		ll_Sum						//계산값
str_pisr_partkb	lstr_partkb
String	ls_message= ''

////////////////////////////////////////////////
//		현재시간 및 현재일자 String 설정
////////////////////////////////////////////////
ls_nowDate		= Left(is_nowtime, 10)
ls_nowTime		= Mid(is_nowtime, 12, 5) + ':00'

this.AcceptText()

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

////////////////////////////////////////////////
// 	가입고 간판정보 저장
////////////////////////////////////////////////
this.SetTransObject(Sqlpis)									//간판상태
If This.Update() = -1 Then 
//	MessageBox("가입고오류", "가입고 간판정보 저장에서 오류가 발생하였습니다.", StopSign! )
	ls_message = 'Update_Err'
	Goto RollBack_			
End If

ll_RowCount		= this.RowCount()

////////////////////////////////////////////////
//		가입고 저장 
////////////////////////////////////////////////
For I = 1 To ll_RowCount Step 1
	ls_suppCode		= this.GetItemString(I	, 'suppliercode')
	ls_itemCode		= this.GetItemString(I	, 'itemcode')
	ll_RackQty		= this.GetItemNumber(I	, 'rackqty')
	ll_editNo		= this.GetItemNumber(I	, 'parteditno')

	//	검사성적서 및 가입고수량 Summary, 마지막 납입편수 저장( 처음 ~ 마지막항목 이전 )
	If ls_olditemCode <> ls_itemCode Then
		If ls_olditemCode <> '' Then
			lstr_partkb.areacode	= istr_partkb.areacode	//지역
			lstr_partkb.divcode	= istr_partkb.divcode	//공장
			lstr_partkb.suppcode	= ls_suppCode				//업체
			lstr_partkb.itemcode	= ls_olditemCode			//품번
			//마지막납입편수 저장
			lstr_partkb.applydate= is_jobdate				//가입고일자(Shift단위일자)
			IF wf_lastedit(lstr_partkb, ll_oldeditNo) = -1 Then 
//				MessageBox("가입고오류", "마지막 편수 저장에서 오류가 발생하였습니다.", StopSign! )
				ls_message = 'wf_lastedit_Err'
				Goto RollBack_
			End If
			//가입고수량 Summary저장
			lstr_partkb.applydate= ls_nowDate				//가입고일자(실제납입일자)
			IF wf_sumadd(lstr_partkb, ll_napipQty) = -1 Then 
//				MessageBox("가입고오류", "가입고수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
				ls_message = 'wf_sumadd_Err'
				Goto RollBack_
			End If

			dw_pisr070b_03.SetTransObject(Sqlpis)				
			If dw_pisr070b_03.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, is_deliveryno, ls_olditemCode) = 0 then	
//				MessageBox("가입고오류", ls_olditemCode + "항목의 검사성적서가 발행되지 않았습니다.", StopSign! )
				ls_message = 'tqqcresult_Err'
				Goto RollBack_			
			End If
			//무검사품목
			If f_pisr_tqqcitem(sqlpis, lstr_partkb) Then 		
				dw_pisr070b_03.SetItem(1, 'judgeflag'	, '1')				//'1'합격,'2'불합격,'3'선별,'9'검사이전
				ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'goodqty')		//합격수량
				If isNull(ll_Sum) Then ll_Sum = 0
				ll_Sum = ll_Sum + ll_napipQty
				dw_pisr070b_03.SetItem(1, 'goodqty'		, ll_Sum )			
				dw_pisr070b_03.SetItem(1, 'confirmflag', 'Y' )				//검사확인
				dw_pisr070b_03.SetItem(1, 'qcdate'		, ls_nowDate )		//검사일자
				dw_pisr070b_03.SetItem(1, 'qctime'		, ls_nowTime )		//검사시간
				dw_pisr070b_03.SetItem(1, 'qcleadtime'	, '0'			 )		//검사LeadTime
				dw_pisr070b_03.SetItem(1, 'inspectorcode'	, '무검사')		//무검사품
			End If
			
			ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'kbcount')			//간판매수
			If isNull(ll_Sum) Then ll_Sum = 0
			ll_Sum = ll_Sum + ll_napipQty
			dw_pisr070b_03.SetItem(1, 'kbcount'			, ll_kbCnt )		
			dw_pisr070b_03.SetItem(1, 'deliverydate'	, ls_nowDate )		//납입일자
			dw_pisr070b_03.SetItem(1, 'deliverytime'	, ls_nowTime )		//납입시간
			dw_pisr070b_03.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag 활용
			dw_pisr070b_03.SetItem(1, 'lastdate'		, idt_nowtime )	//최종 작업시간
			
			dw_pisr070b_03.SetTransObject(Sqlpis)									
			If dw_pisr070b_03.Update() = -1 Then 		
//				MessageBox("가입고오류", "검사성적서항목 수정후 저장에서 오류가 발생하였습니다.", StopSign! )
				ls_message = 'tqqcresultUpdate_Err'
				Goto RollBack_			
			End If
			ll_kbCnt 		= 0			//간판매수 Count (검사성적서 간판매수 저장)
			ll_napipQty 	= 0			//납입수량집계
			ll_oldRackQty	= 0
		End If	//ls_olditemCode <> '' Then
		ls_olditemCode = ls_itemCode
	End If	//ls_olditemCode <> ls_itemCode Then

//	품질검사항목 리스트 생성 TQQCRESULTQTY
	If ll_oldRackQty <> ll_RackQty Then
		dw_pisr070b_02.SetTransObject(Sqlpis)				
		If dw_pisr070b_02.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, is_deliveryno, ls_itemCode, ll_RackQty) = 0 then	
			dw_pisr070b_02.ReSet();	dw_pisr070b_02.InsertRow(1)
			dw_pisr070b_02.SetItem(1, 'areacode'		, istr_partkb.areacode )
			dw_pisr070b_02.SetItem(1, 'divisioncode'	, istr_partkb.divcode )
			dw_pisr070b_02.SetItem(1, 'suppliercode'	, ls_suppCode )
			dw_pisr070b_02.SetItem(1, 'deliveryno'		, is_deliveryno )
			dw_pisr070b_02.SetItem(1, 'itemcode'		, ls_itemCode )
			dw_pisr070b_02.SetItem(1, 'receptionqty'	, ll_RackQty )
			dw_pisr070b_02.SetItem(1, 'kbcount'			, 0 )
			
			dw_pisr070b_02.SetTransObject(Sqlpis)									
			If dw_pisr070b_02.Update() = -1 Then 		
//				MessageBox("가입고오류", "품질검사항목리스트 생성에서 오류가 발생하였습니다.", StopSign! )
				ls_message = 'TQQCRESULTQTY_Err'
				Goto RollBack_			
			End If
		End If	//dw_pisr070b_02.Retrieve
		ll_oldRackQty = ll_RackQty
	End If	//ll_oldRackQty <> ll_RackQty Then
	
	ll_oldeditNo = ll_editNo
	ll_kbCnt 	= ll_kbCnt 	  + 1						//간판매수 Count (검사성적서 간판매수 저장)
	ll_napipQty	= ll_napipQty + ll_RackQty			//납입수량집계
Next

//	검사성적서 및 가입고수량 Summary, 마지막 납입편수 저장( 마지막항목 )
If ls_olditemCode <> '' Then
	lstr_partkb.areacode	= istr_partkb.areacode	//지역
	lstr_partkb.divcode	= istr_partkb.divcode	//공장
	lstr_partkb.suppcode	= ls_suppCode				//업체
	lstr_partkb.itemcode	= ls_olditemCode			//품번
	//마지막납입편수 저장
	lstr_partkb.applydate= is_jobdate				//가입고일자(Shift단위일자)
	IF wf_lastedit(lstr_partkb, ll_editNo) = -1 Then 
		ls_message = 'wf_lastedit_Err'
		Goto RollBack_
	End If
	//가입고수량 Summary저장
	lstr_partkb.applydate= ls_nowDate				//가입고일자(실제납입일자)
	IF wf_sumadd(lstr_partkb, ll_napipQty) = -1 Then
		ls_message = 'wf_sumadd_Err'
		Goto RollBack_
	End If
	//	검사성적서 항목 납품확인( 처음 ~ 마지막항목 이전 )
	dw_pisr070b_03.SetTransObject(Sqlpis)				
	If dw_pisr070b_03.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, is_deliveryno, ls_olditemCode) = 0 then	
//		MessageBox("가입고오류", ls_olditemCode + "항목의 검사성적서가 발행되지 않았습니다.", StopSign! )
		ls_message = 'tqqcresult_Err'
		Goto RollBack_			
	End If
	//무검사품목
	If f_pisr_tqqcitem(sqlpis, lstr_partkb) Then 		
		dw_pisr070b_03.SetItem(1, 'judgeflag'	, '1')				//'1'합격,'2'불합격,'3'선별,'9'검사이전
		ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'goodqty')		//합격수량
		If isNull(ll_Sum) Then ll_Sum = 0
		ll_Sum = ll_Sum + ll_napipQty
		dw_pisr070b_03.SetItem(1, 'goodqty'		, ll_Sum )			
		dw_pisr070b_03.SetItem(1, 'confirmflag', 'Y' )				//검사확인
		dw_pisr070b_03.SetItem(1, 'qcdate'		, ls_nowDate )		//검사일자
		dw_pisr070b_03.SetItem(1, 'qctime'		, ls_nowTime )		//검사시간
		dw_pisr070b_03.SetItem(1, 'qcleadtime'	, '0'			 )		//검사LeadTime
		dw_pisr070b_03.SetItem(1, 'inspectorcode'	, '무검사')		//무검사품
	End If	//f_pisr_tqqcitem(sqlpis, lstr_partkb) Then 	//무검사품목
	
	ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'kbcount')			//간판매수
	If isNull(ll_Sum) Then ll_Sum = 0
	ll_Sum = ll_Sum + ll_napipQty
	dw_pisr070b_03.SetItem(1, 'kbcount'			, ll_kbCnt )		
	dw_pisr070b_03.SetItem(1, 'deliverydate'	, ls_nowDate )		//납입일자
	dw_pisr070b_03.SetItem(1, 'deliverytime'	, ls_nowTime )		//납입시간
	dw_pisr070b_03.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag 활용
	dw_pisr070b_03.SetItem(1, 'lastdate'		, idt_nowtime )	//최종 작업시간
	
	dw_pisr070b_03.SetTransObject(Sqlpis)									
	If dw_pisr070b_03.Update() = -1 Then 		
//		MessageBox("가입고오류", "검사성적서항목 수정후 저장에서 오류가 발생하였습니다.", StopSign! )
		ls_message = 'tqqcresultUpdate_Err'
		Goto RollBack_			
	End If
	ll_kbCnt 		= 0			//간판매수 Count (검사성적서 간판매수 저장)
	ll_napipQty 	= 0			//납입수량집계
	ll_oldRackQty	= 0
End If	//ls_olditemCode <> '' Then

//////////////////////////////////////////////////////////
//		납품표정보 Update
//////////////////////////////////////////////////////////
  UPDATE TDELIVERYLIST  
     SET DeliveryConfirm 		= 'Y',   			//납품확인
         DeliveryReceiptDate 	= :ls_nowDate,  
         LastEmp 					= 'Y'		//Interface Flag 활용  
   WHERE SupplierCode			= :ls_suppCode		AND   
   		DeliveryNo 				= :is_deliveryno   
   USING sqlpis       ;

If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("가입고오류", "납품표 정보 Update에 실패 하였습니다.", StopSign! )
	ls_message = 'TDELIVERYLIST_Err'
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
dw_pisr070b_01.Reset ();

CHOOSE CASE ls_message
	CASE 'Update_Err'
		MessageBox("가입고오류", "가입고 간판정보 저장에서 오류가 발생하였습니다.", StopSign! )
	CASE 'wf_lastedit_Err'
		MessageBox("가입고오류", "마지막 편수 저장에서 오류가 발생하였습니다.", StopSign! )
	CASE 'wf_sumadd_Err'
		MessageBox("가입고오류", "가입고수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	CASE 'tqqcresult_Err'
		MessageBox("가입고오류", ls_olditemCode + "항목의 검사성적서가 발행되지 않았습니다.", StopSign! )
	CASE 'tqqcresultUpdate_Err'
		MessageBox("가입고오류", "검사성적서항목 수정후 저장에서 오류가 발생하였습니다.", StopSign! )
	CASE 'TQQCRESULTQTY_Err'
		MessageBox("가입고오류", "품질검사항목리스트 생성에서 오류가 발생하였습니다.", StopSign! )
	CASE 'TDELIVERYLIST_Err'
		MessageBox("가입고오류", "납품표 정보 Update에 실패 하였습니다.", StopSign! )
	CASE ELSE
		MessageBox("오류", "가입고 처리에 실패했습니다.", StopSign! )
END CHOOSE
return -1

end event

event type integer ue_cancelsave();String	ls_suppCode, ls_itemCode
Long		ll_Qty, ll_qtySum
String	ls_receiptDate
DateTime	ldt_receiptTime
Long 		ll_RowCount
Integer	I
Integer	li_null
DateTime	ldt_null
String	ls_message = ''

SetNull( li_null )
SetNull( ldt_null )

this.AcceptText()

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

ll_RowCount		= this.RowCount()

////////////////////////////////////////////////
//		가입고 Summary 저장 (감소)
////////////////////////////////////////////////
For I = 1 To ll_RowCount Step 1
	ls_suppCode		= this.GetItemString(I	, 'suppliercode')
	ls_itemCode		= this.GetItemString(I	, 'itemcode')
	ll_Qty			= this.GetItemNumber(I	, 'rackqty')
	//※ 가입고일자(Real) 2002.10.30
	//ls_receiptDate	= this.GetItemString(I	, 'partreceiptdate')
	ldt_receiptTime= this.GetItemDateTime(I, 'partreceipttime')
	ls_receiptDate	= left(String(ldt_receiptTime, "yyyy.mm.dd hh:mm"), 10)
	
	dw_summary.SetTransObject(Sqlpis)				
	If dw_summary.Retrieve(ls_receiptDate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		MessageBox("가입고취소오류", "가입고수량 Summary정보를 읽지 못했습니다.", StopSign! )
		ls_message = 'summaryRetrieve_Err'
		Goto RollBack_			
	End If

//※ 가입고일자(Real), 월마감무시  2002.10.30
//	ls_compMonth2 = left( ls_receiptDate, 7 )		//가입고기준월
//	If ls_compMonth > ls_compMonth2 Then
//		dw_summary.SetTransObject(Sqlpis)				
//		If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//			dw_summary.ReSet();	dw_summary.InsertRow(0)
//			dw_summary.SetItem( 1, 'applydate'		, is_applydate )
//			dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//			dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//			dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//			dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//			dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag 활용
//			dw_summary.SetItem( 1, 'lastdate'		, idt_nowTime )
//		End If
//	End If
	
	ll_qtySum = dw_summary.GetItemNumber( 1, 'partreceiptqty' )
	ll_qtySum = ll_qtySum - ll_Qty									//가입고수량 감소
	dw_summary.SetItem( 1, 'partreceiptqty', ll_qtySum )
	
	dw_summary.SetTransObject(Sqlpis)							//발주 Summary
	If dw_summary.Update() = -1 Then 
//		MessageBox("가입고취소오류", "가입고수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
		ls_message = 'summaryUpdate_Err'
		Goto RollBack_			
	End If

	This.SetItem( I, 'partkbstatus'		, 'A' )			//가입고 -> 발주상태로 전환
//	This.SetItem( I, 'partreceiptcalcel', 'Y' )			//가입고 취소
	This.SetItem( I, 'partobeydateflag'	, 0 )				//납입미준수처리
	This.SetItem( I, 'partobeytimeflag'	, 0 )				//납입미준수처리
	This.SetItem( I, 'partreceiptdate'	, is_Null )		//납입일자
	This.SetItem( I, 'parteditno'			, li_Null )		//납입편수
	This.SetItem( I, 'partreceipttime'	, ldt_Null )		//납입시간
	This.SetItem( I, 'lastemp'				, 'Y' )	//Interface Flag활용
	This.SetItem( I, 'lastdate'			, idt_nowTime )//작업시간
Next

//	품질검사 항목리스트 삭제
  DELETE FROM TQQCRESULTQTY  
   WHERE TQQCRESULTQTY.AREACODE 		= :istr_partkb.areacode AND  
         TQQCRESULTQTY.DIVISIONCODE = :istr_partkb.divcode 	AND  
         TQQCRESULTQTY.SUPPLIERCODE = :ls_suppCode 			AND  
         TQQCRESULTQTY.DELIVERYNO 	= :is_deliveryno 			
   USING sqlpis	;
If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("가입고취소오류", "품질검사 항목리스트 삭제에 실패 하였습니다.", StopSign! )
	ls_message = 'TQQCRESULTQTY_Err'
	Goto RollBack_			
End If

  UPDATE TQQCRESULT  
     SET KBCOUNT 			= :li_null,   
         JUDGEFLAG		= '9',   
			GOODQTY			= :li_null,	
			CONFIRMFLAG		= 'N',	
			QCDATE			= :is_null,
			QCTIME			= :is_null,
			QCLEADTIME		= :is_null,
			inspectorcode	= :is_null,
         DELIVERYDATE 	= :is_null,   
         DELIVERYTIME 	= :is_null,  
         LASTEMP 			= 'Y'  			//Interface Flag활용
   WHERE TQQCRESULT.AREACODE 		= :istr_partkb.areacode AND  
         TQQCRESULT.DIVISIONCODE = :istr_partkb.divcode 	AND  
         TQQCRESULT.SUPPLIERCODE = :ls_suppCode 			AND  
         TQQCRESULT.DELIVERYNO 	= :is_deliveryno 
	USING	sqlpis	;
If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("가입고취소오류", "검사성적서 정보수정에 실패하였습니다.", StopSign! )
	ls_message = 'TQQCRESULT_Err'
	Goto RollBack_			
End If

//	납품표 정보 Update
  UPDATE TDELIVERYLIST  
     SET DeliveryConfirm 		= 'N',   			//납품대기
         DeliveryReceiptDate 	= :is_null,			//납품일자
			LastEmp			 		= 'Y',   //Interface Flag활용
         LastDate 				= :idt_nowTime    //작업시간
   WHERE SupplierCode 			= :ls_suppCode 	AND  
   		DeliveryNo 				= :is_deliveryno   
   USING sqlpis       ;

If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("가입고취소오류", "납품표 정보 수정에 실패 하였습니다.", StopSign! )
	ls_message = 'TDELIVERYLIST_Err'
	Goto RollBack_			
End If

//	가입고 취소 간판상태 설정
//If wf_cancelset( ll_RowCount ) = -1 Then Goto RollBack_

////////////////////////////////////////////////
// 	가입고 간판정보 저장
////////////////////////////////////////////////
this.SetTransObject(Sqlpis)									//간판상태
If This.Update() = -1 Then 
//	MessageBox("가입고오류", "가입고 간판정보 저장에서 오류가 발생하였습니다.", StopSign! )
	ls_message = 'thisUpdate_Err'
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
CHOOSE CASE ls_message
	CASE 'summaryRetrieve_Err'
		MessageBox("가입고취소오류", "가입고수량 Summary정보를 읽지 못했습니다.", StopSign! )
	CASE 'summaryUpdate_Err'
		MessageBox("가입고취소오류", "가입고수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	CASE 'TQQCRESULTQTY_Err'
		MessageBox("가입고취소오류", "품질검사 항목리스트 삭제에 실패 하였습니다.", StopSign! )
	CASE 'TQQCRESULT_Err'
		MessageBox("가입고취소오류", "검사성적서 정보수정에 실패하였습니다.", StopSign! )
	CASE 'TDELIVERYLIST_Err'
		MessageBox("가입고취소오류", "납품표 정보 수정에 실패 하였습니다.", StopSign! )
	CASE 'thisUpdate_Err'
		MessageBox("가입고취소오류", "가입고 간판정보 저장에서 오류가 발생하였습니다.", StopSign! )
	CASE ELSE
		MessageBox("가입고취소오류", "가입고 취소처리에 실패 하였습니다.", StopSign! )
END CHOOSE

return -1

end event

event clicked;call super::clicked;dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

Return 1
end event

type uo_area from u_pisc_select_area within w_pisr070b
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 50
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

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  ''
st_totkbcnt.Text = '0 매'

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr070b
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 60
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  ''
st_totkbcnt.Text = '0 매'

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type st_2 from statictext within w_pisr070b
integer x = 1413
integer y = 256
integer width = 453
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "총간판매수: "
boolean focusrectangle = false
end type

event clicked;dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type st_totkbcnt from statictext within w_pisr070b
integer x = 1870
integer y = 248
integer width = 1449
integer height = 76
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "0 매"
boolean focusrectangle = false
end type

event clicked;dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_partedit from datawindow within w_pisr070b
integer x = 37
integer y = 1028
integer width = 709
integer height = 432
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "납입편수별 납입시간"
string dataobject = "d_pisr012u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_summary from datawindow within w_pisr070b
integer x = 750
integer y = 1024
integer width = 832
integer height = 848
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "간판수량 Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_lastedit from datawindow within w_pisr070b
integer x = 1586
integer y = 1024
integer width = 645
integer height = 748
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "마지막납입편수저장"
string dataobject = "d_pisr110b_last"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisr070b_02 from datawindow within w_pisr070b
integer x = 2235
integer y = 1024
integer width = 585
integer height = 716
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "품질검사품목생성"
string dataobject = "d_pisr070b_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisr070b_03 from datawindow within w_pisr070b
integer x = 2825
integer y = 1024
integer width = 585
integer height = 716
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "검사성적서수정"
string dataobject = "d_pisr070b_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisr070b
integer x = 1243
integer width = 1175
integer height = 180
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_scan from datawindow within w_pisr070b
integer x = 32
integer y = 212
integer width = 1326
integer height = 148
integer taborder = 20
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "확인", "작업처리 권한이 부여되지 않았습니다.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 12 Then 
	MessageBox( "입력오류", "올바른 납품표번호 가 아닙니다.", StopSign! )
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
// 변경전
//is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간고려함
//is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간,마감일 고려함
// 변경후 : 2003.12
is_jobDate		= 	String(idt_nowTime, "yyyy.mm.dd")
is_applyDate	= 	String(idt_nowTime, "yyyy.mm.dd")

is_deliveryno = data
parent.TriggerEvent( "ue_process" )

this.Event getfocus()
end event

event getfocus;This.SelectText(1,15)
end event

type gb_3 from groupbox within w_pisr070b
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
end type

type gb_scan from groupbox within w_pisr070b
integer x = 18
integer y = 168
integer width = 1358
integer height = 212
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

