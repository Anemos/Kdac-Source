$PBExportHeader$w_pisr110b.srw
$PBExportComments$발주간판처리/삭제
forward
global type w_pisr110b from w_ipis_sheet01
end type
type rb_1 from radiobutton within w_pisr110b
end type
type rb_2 from radiobutton within w_pisr110b
end type
type dw_pisr110b_01 from datawindow within w_pisr110b
end type
type dw_pisr110b_02 from u_vi_std_datawindow within w_pisr110b
end type
type uo_area from u_pisc_select_area within w_pisr110b
end type
type uo_division from u_pisc_select_division within w_pisr110b
end type
type dw_scan from datawindow within w_pisr110b
end type
type dw_lastedit from datawindow within w_pisr110b
end type
type dw_summary from datawindow within w_pisr110b
end type
type dw_orderseq from datawindow within w_pisr110b
end type
type cb_1 from commandbutton within w_pisr110b
end type
type cb_2 from commandbutton within w_pisr110b
end type
type gb_2 from groupbox within w_pisr110b
end type
type gb_3 from groupbox within w_pisr110b
end type
type gb_scan from groupbox within w_pisr110b
end type
type gb_1 from groupbox within w_pisr110b
end type
end forward

global type w_pisr110b from w_ipis_sheet01
event ue_process ( )
event ue_init ( )
rb_1 rb_1
rb_2 rb_2
dw_pisr110b_01 dw_pisr110b_01
dw_pisr110b_02 dw_pisr110b_02
uo_area uo_area
uo_division uo_division
dw_scan dw_scan
dw_lastedit dw_lastedit
dw_summary dw_summary
dw_orderseq dw_orderseq
cb_1 cb_1
cb_2 cb_2
gb_2 gb_2
gb_3 gb_3
gb_scan gb_scan
gb_1 gb_1
end type
global w_pisr110b w_pisr110b

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowTime, is_jobDate, is_applyDate	//현재시간, 작업기준일자, 마감기준일자
DateTime	idt_nowTime										//현재시간
String	is_null
end variables

forward prototypes
public function integer wf_cancelset ()
public function integer wf_ordervalid ()
public function integer wf_cancelvalid ()
end prototypes

event ue_process();//////////////////////////////////
//		발주 작업 Control
//////////////////////////////////
Long		ll_Row
integer i
String	ls_message = ''

//SetPointer(HourGlass!)
CHOOSE CASE rb_1.Checked

CASE True		//발주등록
 		ll_Row = wf_ordervalid()
		If ll_Row = -1 Then 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.Object.scancode.SetFocus()
			Goto EndReturn_
		End If
		If f_pisr_ordercalc(dw_pisr110b_01, idt_nowtime, is_jobdate, is_applydate, ls_message) = -1 Then 
			If ls_message = "WorkCalendar_Err" Then
				MessageBox("발주실패", "자재 Work Calendar가 준비되지 않았습니다.", Information!)
			ElseIf ls_message = "OrderTime_Err" Then
				MessageBox("발주실패", "발주시간 계산에 실패했습니다." , StopSign! )
			ElseIf ls_message = "KBStatus_Err" Then
				MessageBox("발주실패", "발주일자 기준의 간판정보를 읽는데 실패하였습니다." , StopSign! )
			ElseIf ls_message = "ForecastTime_Err" Then
				MessageBox("발주실패", "납입예정시간 계산에 실패했습니다." , StopSign! )
			ElseIf ls_message = "tmstsupplier_err" Then
				MessageBox("발주실패", "거래중단된 업체입니다." , StopSign! )
			ElseIf ls_message = "tmstpartcost_err" Then
				MessageBox("발주실패", "거래중단된 품목입니다." , StopSign! )	
			End If
			dw_pisr110b_01.ReSet() 
			dw_pisr110b_01.InsertRow(1) 
			Goto EndReturn_
		End If
		If f_pisr_setorderstatus(dw_pisr110b_01, idt_nowtime) = -1 Then Goto EndReturn_
		If dw_pisr110b_01.Event ue_save() = -1 Then Goto EndReturn_
CASE ELSE		//발주취소
		ll_Row = wf_cancelvalid()
		If ll_Row = -1 Then 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.Object.scancode.SetFocus()
			Goto EndReturn_
		End If
		If dw_pisr110b_01.Event ue_cancelsave() = -1 Then Goto EndReturn_
END CHOOSE

dw_pisr110b_01.Object.t_nowtime.Text 	= is_nowtime
dw_pisr110b_01.RowsCopy(1,1, Primary!, dw_pisr110b_02, 1, Primary!)

EndReturn_:
//SetPointer(Arrow!)
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

dw_pisr110b_01.SetTransObject (sqlpis)
dw_pisr110b_01.InsertRow(1) 

dw_pisr110b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

public function integer wf_cancelset ();/////////////////////////////////////////
// 발주일자 기준의 개별간판 DataSet
/////////////////////////////////////////
Long 		ll_Row
Integer 	li_null
DateTime	ldt_null

setNull(li_null)
setNull(ldt_null)

ll_Row	= dw_pisr110b_01.GetRow()
  
dw_pisr110b_01.SetItem(ll_Row, 'partkbstatus'			, 'D')		//A발주, B가입고, C입고, D발주대기
dw_pisr110b_01.SetItem(ll_Row, 'kborderpossible'		, 'Y')
dw_pisr110b_01.SetItem(ll_Row, 'orderchangeflag'		, 'N')
dw_pisr110b_01.SetItem(ll_Row, 'partordercancel'		, 'Y')
dw_pisr110b_01.SetItem(ll_Row, 'partreceiptcancel'		, 'N')
//
dw_pisr110b_01.SetItem(ll_Row, 'partorderdate'			, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'partordertime'			, ldt_null)
dw_pisr110b_01.SetItem(ll_Row, 'partforecastdate'		, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'partforecasteditno'	, li_null)
dw_pisr110b_01.SetItem(ll_Row, 'partforecasttime'		, ldt_null)
//
dw_pisr110b_01.SetItem(ll_Row, 'partreceiptdate'		, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'parteditno'				, li_null)
dw_pisr110b_01.SetItem(ll_Row, 'partreceipttime'		, ldt_null)
dw_pisr110b_01.SetItem(ll_Row, 'partincomedate'			, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'partincometime'			, ldt_null)
dw_pisr110b_01.SetItem(ll_Row, 'partorderno'				, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'deliveryno'				, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'orderchangetime'		, ldt_null)
dw_pisr110b_01.SetItem(ll_Row, 'orderchangecode'		, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'changeforecastdate'	, is_null)
dw_pisr110b_01.SetItem(ll_Row, 'changeforecasteditno'	, li_null)
dw_pisr110b_01.SetItem(ll_Row, 'changeforecasttime'	, ldt_null)
dw_pisr110b_01.SetItem(ll_Row, 'lastemp'					, 'Y')	//Interface Flag 활용
dw_pisr110b_01.SetItem(ll_Row, 'lastdate'					, idt_nowTime)

return 0
end function

public function integer wf_ordervalid ();
String	ls_areaCode, ls_divCode
String	ls_KBStatus, ls_OrderPossible, ls_useFlag, ls_ReprintFlag, ls_kbactivegubun
Long		ll_Row

dw_pisr110b_01.SetTransObject (sqlpis)
ll_Row = dw_pisr110b_01.Retrieve(is_partkbno, is_jobdate)
If ll_Row = 0 Then 
	MessageBox( "입력오류", "존재하지 않는 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_areaCode			= dw_pisr110b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr110b_01.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "입력오류", "해당 공장의 간판이 아닙니다.", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_useFlag			= dw_pisr110b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "입력오류", "사용중단된 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_kbactivegubun	= dw_pisr110b_01.GetItemString( ll_Row, 'kbactivegubun' )
If ls_kbactivegubun = 'S' Then 
	MessageBox( "입력오류", "Sleeping 상태의 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_KBStatus			= dw_pisr110b_01.GetItemString( ll_Row, 'partkbstatus' )
CHOOSE CASE ls_KBStatus
	CASE 'A','B'
		MessageBox( "입력오류", "이미 발주된 간판입니다. ", StopSign! )
		dw_pisr110b_01.ReSet() 
		dw_pisr110b_01.InsertRow(1) 
		Return -1
END CHOOSE

ls_OrderPossible	= dw_pisr110b_01.GetItemString( ll_Row, 'kborderpossible' )
If ls_OrderPossible = 'N' Then 
	MessageBox( "입력오류", "발주가 불가능한 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

String	ls_suppCode, ls_itemCode, ls_Chk 

ls_suppCode			= dw_pisr110b_01.GetItemString( ll_Row, 'suppliercode' )
ls_itemCode			= dw_pisr110b_01.GetItemString( ll_Row, 'itemcode' )

  SELECT TMSTPARTCOST.XPAY  
    INTO :ls_Chk  
    FROM TMSTPARTCOST  
   WHERE TMSTPARTCOST.SupplierCode 	= :ls_suppCode AND  
         TMSTPARTCOST.ItemCode 		= :ls_itemCode   
	USING	sqlpis	;
If isNull(ls_Chk) Or Trim(ls_Chk) = '' Then 
	MessageBox( "발주불가능", "결재조건이 결정되지 않은 품번이므로 발주가 불가능합니다.", Information! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

  SELECT Top 1 TMSTMODEL.Planner  
    INTO :ls_Chk  
    FROM TMSTMODEL  
   WHERE TMSTMODEL.AreaCode 		= :ls_areaCode AND  
         TMSTMODEL.DivisionCode 	= :ls_divCode 	AND  
         TMSTMODEL.ItemCode 		= :ls_itemCode   
	USING	sqlpis	;
If isNull(ls_Chk) Or Trim(ls_Chk) = '' Then 
	MessageBox( "발주불가능", "구매담당자가 설정되지않은 품번이므로 발주가 불가능합니다.", Information! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_ReprintFlag		= dw_pisr110b_01.GetItemString( ll_Row, 'reprintflag' )
If ls_ReprintFlag = 'Y' Then 
	MessageBox( "발행요청", "기본정보 변경으로인해 발행이 필요한 간판입니다. ", Information! )
End If

return ll_Row
end function

public function integer wf_cancelvalid ();
String	ls_areaCode, ls_divCode
String	ls_KBStatus, ls_OrderPossible, ls_useFlag, ls_ReprintFlag, ls_kbactivegubun
String	ls_DeliveryNo, ls_PartOrderNo
Long		ll_Row
DateTime ldt_orderTime
String	ls_orderDate

dw_pisr110b_01.SetTransObject (sqlpis)
ll_Row = dw_pisr110b_01.Retrieve(is_partkbno, is_jobdate)
If ll_Row = 0 Then 
	MessageBox( "입력오류", "존재하지 않는 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_areaCode			= dw_pisr110b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr110b_01.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "입력오류", "해당 공장의 간판이 아닙니다.", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_useFlag			= dw_pisr110b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "입력오류", "사용중단된 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_kbactivegubun	= dw_pisr110b_01.GetItemString( ll_Row, 'kbactivegubun' )
If ls_kbactivegubun = 'S' Then 
	MessageBox( "입력오류", "Sleeping 상태의 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_KBStatus			= dw_pisr110b_01.GetItemString( ll_Row, 'partkbstatus' )
CHOOSE CASE ls_KBStatus
CASE 'B'
	MessageBox( "입력오류", "현재 가입고상태의 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
CASE 'C', 'D'
	MessageBox( "입력오류", "아직 발주되지 않은 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
END CHOOSE

ls_OrderPossible	= dw_pisr110b_01.GetItemString( ll_Row, 'kborderpossible' )
If ls_OrderPossible = 'Y' Then 
	MessageBox( "입력오류", "아직 발주되지 않은 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

////※ 발주일자가 지난 간판은 발주취소불가능 ( 2002.11.11 조태섭과장 )
ldt_orderTime 		= dw_pisr110b_01.GetItemDateTime( ll_Row, 'partordertime' )
ls_orderDate		= left(String(ldt_orderTime, "yyyy.mm.dd hh:mm"), 10)
//If ls_orderDate < left(is_nowtime, 10) Then
//	MessageBox( "발주취소불능", "발주일자가 지난항목은 발주취소가 불가능합니다.", StopSign! )
//	dw_pisr110b_01.ReSet() 
//	dw_pisr110b_01.InsertRow(1) 
//	Return -1
//End If

ls_DeliveryNo 		= dw_pisr110b_01.GetItemString( ll_Row, 'deliveryno' )
If ( Not isNull( ls_DeliveryNo )) And trim(ls_DeliveryNo) <> '' Then 
	MessageBox( "입력오류", "이미 납품표가 발행된 간판입니다. ", StopSign! )
	dw_pisr110b_01.ReSet() 
	dw_pisr110b_01.InsertRow(1) 
	Return -1
End If

ls_PartOrderNo		= dw_pisr110b_01.GetItemString( ll_Row, 'partorderno' )
If ( Not isNull( ls_PartOrderNo )) And trim(ls_PartOrderNo) <> '' Then 
	MessageBox( "확인", "업체로 불출되었거나 불출하려는 간판입니다. ", Information! )
End If

ls_ReprintFlag		= dw_pisr110b_01.GetItemString( ll_Row, 'reprintflag' )
If ls_ReprintFlag = 'Y' Then 
	MessageBox( "발행요청", "신규 또는 기본정보 변경으로인해 발행이 필요한 간판입니다. ", Information! )
End If

return ll_Row
end function

on w_pisr110b.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_pisr110b_01=create dw_pisr110b_01
this.dw_pisr110b_02=create dw_pisr110b_02
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_scan=create dw_scan
this.dw_lastedit=create dw_lastedit
this.dw_summary=create dw_summary
this.dw_orderseq=create dw_orderseq
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_scan=create gb_scan
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.dw_pisr110b_01
this.Control[iCurrent+4]=this.dw_pisr110b_02
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.dw_scan
this.Control[iCurrent+8]=this.dw_lastedit
this.Control[iCurrent+9]=this.dw_summary
this.Control[iCurrent+10]=this.dw_orderseq
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.gb_scan
this.Control[iCurrent+16]=this.gb_1
end on

on w_pisr110b.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_pisr110b_01)
destroy(this.dw_pisr110b_02)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_scan)
destroy(this.dw_lastedit)
destroy(this.dw_summary)
destroy(this.dw_orderseq)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_scan)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr110b_02.Width = newwidth 	- ( dw_pisr110b_02.x + ls_gap * 2 )
dw_pisr110b_02.Height= newheight - ( dw_pisr110b_02.y + ls_status )

end event

event open;call super::open;
SetNull(is_null)
rb_1.Checked 			= True
rb_1.Weight 			= 700

dw_summary.Visible 	= False
dw_lastedit.Visible 	= False
dw_orderseq.Visible 	= False

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)

this.PostEvent ( "ue_init" )

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

event activate;call super::activate;dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr110b
integer y = 1884
end type

type rb_1 from radiobutton within w_pisr110b
integer x = 1303
integer y = 72
integer width = 425
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
string text = "발주등록"
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

dw_pisr110b_01.Reset()
dw_pisr110b_01.SetTransObject (sqlpis)
dw_pisr110b_01.InsertRow(1) 

dw_pisr110b_02.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

return 0


end event

type rb_2 from radiobutton within w_pisr110b
integer x = 1751
integer y = 72
integer width = 425
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
string text = "발주취소"
end type

event clicked;
rb_1.Weight = 400
rb_2.Weight = 700

dw_pisr110b_01.Reset()
dw_pisr110b_01.SetTransObject (sqlpis)
dw_pisr110b_01.InsertRow(1) 

dw_pisr110b_02.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()


end event

type dw_pisr110b_01 from datawindow within w_pisr110b
event type integer ue_save ( )
event type integer ue_cancelsave ( )
integer x = 18
integer y = 376
integer width = 3259
integer height = 684
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr110b_01"
boolean border = false
boolean livescroll = true
end type

event type integer ue_save();String	ls_suppCode, ls_itemCode
String	ls_orderdate, ls_ordershiftdate, ls_forecastdate
Long		ll_Row, ll_Qty, ll_qtySum, ll_editNo
DateTime	ldt_orderTime, ldt_forecastTime
String	ls_cycleDate, ls_compTime
String	ls_message = ''

this.AcceptText()

ll_Row				= this.GetRow()
ls_suppCode			= Upper(this.GetItemString(ll_Row	, 'suppliercode'))
ls_itemCode			= Upper(this.GetItemString(ll_Row	, 'itemcode'))
ls_ordershiftdate	= this.GetItemString(ll_Row	, 'partorderdate')
ldt_orderTime		= this.GetItemDateTime(ll_Row	, 'partordertime')
ls_orderdate		= left(String(ldt_orderTime	, "yyyy.mm.dd hh:mm"), 10)
//ls_forecastdate	= this.GetItemString(ll_Row	, 'partforecastdate')
ldt_forecastTime	= this.GetItemDateTime(ll_Row	, 'partforecasttime')
ls_forecastdate	= left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"), 10)
ll_Qty				= this.GetItemNumber(ll_Row	, 'rackqty')
ls_cycleDate		= this.GetItemString(ll_Row	, 'cycle_applyfrom')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	발주수량 Summary저장
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_orderdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, ls_orderdate )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag 활용
	dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partorderqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partorderqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag 활용
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)							//발주 Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("발주오류", "발주수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//	납입예정수량 Summary저장
dw_summary.SetTransObject(Sqlpis)			
If dw_summary.Retrieve(ls_forecastdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, ls_forecastdate )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag 활용
	dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partforecastqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partforecastqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'				, 'Y' )	//Interface Flag 활용
dw_summary.SetItem( 1, 'lastdate'			, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//납입예정 Summary
If dw_summary.Update() = -1 Then	
	ls_message = 'summaryUpdate_Err'
//	MessageBox("발주오류", "납입예정 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//	(발주)마지막 편수
dw_lastedit.SetTransObject(Sqlpis)				
If dw_lastedit.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, 'A') = 0 then
	dw_lastedit.InsertRow(1)
	dw_lastedit.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_lastedit.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_lastedit.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_lastedit.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_lastedit.SetItem( 1, 'ordergubun'	, 'A' )				//A:발주, B:납입(가입고)
	dw_lastedit.SetItem( 1, 'lastemp'		, 'Y' )	//Interface Flag 활용
	dw_lastedit.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ls_compTime = mid(String(ldt_orderTime, 'yyyy.mm.dd hh:mm'), 12, 5 )
  SELECT Min(TMSTPARTEDIT.PartEditNo)
    INTO :ll_editNo  
    FROM TMSTPARTEDIT  
   WHERE TMSTPARTEDIT.AreaCode 		= :istr_partkb.areacode  AND  
         TMSTPARTEDIT.DivisionCode 	= :istr_partkb.divcode   AND  
         TMSTPARTEDIT.SupplierCode 	= :ls_suppCode  AND  
         TMSTPARTEDIT.ApplyFrom 		= :ls_cycleDate AND  
         TMSTPARTEDIT.PartEditTime 	= :ls_compTime    
   USING	sqlpis    ;
If isNull(ll_editNo) Then 
	ls_message = 'TMSTPARTEDIT_Err'
//	MessageBox("발주오류", '발주 시간 계산이 올바르지 않습니다.', StopSign!)
	Goto RollBack_			
End If
dw_lastedit.SetItem( 1, 'partlasteditdate', ls_ordershiftdate )
dw_lastedit.SetItem( 1, 'parteditno'		, ll_editNo )
dw_lastedit.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag 활용
dw_lastedit.SetItem( 1, 'lastdate'			, idt_nowtime )

dw_lastedit.SetTransObject(Sqlpis)							//(발주)마지막 편수
If dw_lastedit.Update() = -1 Then 
	ls_message = 'lasteditUpdate_Err'
//	MessageBox("발주오류", "발주편수정보 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

///////////////////////////////////////////////////////////////////
//	발주전산화번호 생성 : 년(1)+월(2)+36진수S/N(5)+지역(1)+공장(1)
///////////////////////////////////////////////////////////////////
String	ls_orderSeq, ls_applyMonth

ls_applyMonth  = left(ls_orderdate, 7)					//발주년월

dw_orderseq.SetTransObject(Sqlpis)			
If dw_orderseq.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_applyMonth) = 0 then
	dw_orderseq.InsertRow(1)
	dw_orderseq.SetItem(1, 'areacode'		, istr_partkb.areacode )
	dw_orderseq.SetItem(1, 'divisioncode'	, istr_partkb.divcode )
	dw_orderseq.SetItem(1, 'applymonth'		, ls_applyMonth )
	dw_orderseq.SetItem(1, 'seqno'			, '' )
	dw_orderseq.SetItem(1, 'orderseq'		, '' )
End If

//발주전산화번호 생성함수 호출
ls_orderSeq = f_pisr_orderseq( dw_orderseq, ls_orderdate, idt_nowtime )
If trim(ls_orderSeq) = '' Then 
	ls_message = 'orderseq_Err'
	Goto RollBack_	
End If

dw_orderseq.SetTransObject(Sqlpis)						//납입예정 Summary
If dw_orderseq.Update() = -1 Then	
	ls_message = 'orderseqUpdate_Err'
//	MessageBox("발주오류", "발주전산화번호가 올바로 등록되지 않았습니다.", StopSign! )
	Goto RollBack_			
End If

//	간판상태저장
this.SetItem(1,'orderseq', ls_orderSeq)
this.SetTransObject(Sqlpis)									//간판상태
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("발주오류", "발주간판 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

////////////////////////////////////////
//HOST 데이타전달 자료생성
////////////////////////////////////////
  INSERT INTO TPARTKBORDER_INTERFACE  
         ( OrderSeq,   
           SeqNo,   
           MISFlag,   
           InterfaceFlag,   
           AreaCode,   
           DivisionCode,   
           SupplierCode,   
           ItemCode,   
           PartKBNo,   
           PartOrderDate,   
           RackQty,   
           PartForecastDate,   
           LastEmp,   
           LastDate )  
  VALUES ( :ls_orderSeq,   
           1,   
           'A',   
           'Y',   
           :istr_partkb.areacode,   
           :istr_partkb.divcode,   
           :ls_suppCode,   
           :ls_itemCode,   
           :is_partkbno,   
           :ls_orderdate,   
           :ll_Qty,   
           :ls_forecastdate,   
           :g_s_empno,   
           :idt_nowtime )  
	USING	sqlpis ;
	
If sqlpis.SqlCode <> 0 Then 
	ls_message = 'ORDERINTERFACE_Err'
//	MessageBox("발주오류", "Interface 정보 생성에 실패하였습니다.", StopSign! )
	Goto RollBack_			
End If
//

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
Return 1 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

If	ls_message = 'summaryUpdate_Err' Then
	MessageBox("발주실패", "발주수량 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'TMSTPARTEDIT_Err' Then
	MessageBox("발주실패", '발주 시간 계산이 올바르지 않습니다.', StopSign!)
ElseIf ls_message = 'summaryUpdate_Err' Then
	MessageBox("발주실패", "납입예정 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'lasteditUpdate_Err' Then
	MessageBox("발주실패", "발주편수정보 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'orderseq_Err' Then
	MessageBox("발주실패", "발주전산화번호를 생성하지 못하였습니다.", StopSign! )
ElseIf ls_message = 'orderseqUpdate_Err' Then
	MessageBox("발주실패", "발주전산화번호가 올바로 등록되지 않았습니다.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("발주실패", "발주간판 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'ORDERINTERFACE_Err' Then
	MessageBox("발주실패", "Interface 정보 생성에 실패하였습니다.", StopSign! )
Else 
	MessageBox("발주실패", "Interface 정보 생성에 실패하였습니다.", StopSign! )
End If

return -1

end event

event type integer ue_cancelsave();///////////////////////////////////////////
//		발주취소작업처리
///////////////////////////////////////////
String	ls_suppCode, ls_itemCode
String	ls_orderdate, ls_forecastdate
Long		ll_Row, ll_Qty, ll_qtySum
DateTime	ldt_orderTime, ldt_forecastTime
String	ls_changeflag 
String	ls_message = ''
//String	ls_compMonth, ls_compMonth2
//ls_compMonth	= left(is_applydate, 7)

this.AcceptText()

ll_Row				= this.GetRow()
ls_suppCode			= Upper(this.GetItemString(ll_Row	, 'suppliercode'))
ls_itemCode			= Upper(this.GetItemString(ll_Row	, 'itemcode'))
//ls_orderdate		= this.GetItemString(ll_Row	, 'partorderdate')
//ls_forecastdate	= this.GetItemString(ll_Row	, 'partforecastdate')
ldt_orderTime		= this.GetItemDateTime(ll_Row	, 'partordertime')
ldt_forecastTime	= this.GetItemDateTime(ll_Row	, 'partforecasttime')
ls_orderdate		= left(String(ldt_orderTime	, "yyyy.mm.dd hh:mm"),10)
ls_changeflag		= this.GetItemString(ll_Row	, 'orderchangeflag')
If ls_changeflag  = 'Y' Then	//납입예정일이 수정된 경우
	ldt_forecastTime= this.GetItemDateTime(ll_Row, 'changeforecasttime')
End IF	
ls_forecastdate	= left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"),10)
ll_Qty				= this.GetItemNumber(ll_Row	, 'rackqty')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	발주수량 Summary저장
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_orderdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err'
//	MessageBox("발주취소오류", "발주 Summary정보를 읽지 못했습니다.", StopSign! )
	Goto RollBack_			
End If
//※ 마감일자를 고려하지 않고 실시간 집계하기로 함( 2002.10.31 )
//ls_compMonth2 = left( ls_orderdate, 7 )		//발주기준월
//If ls_compMonth > ls_compMonth2 Then
//	dw_summary.SetTransObject(Sqlpis)				
//	If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.ReSet();	dw_summary.InsertRow(0)
//		dw_summary.SetItem( 1, 'applydate'		, is_applydate )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		//Interface Flag 활용
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partorderqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partorderqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		//Interface Flag 활용
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//발주 Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("발주오류", "발주 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//납입예정수량 Summary저장
dw_summary.SetTransObject(Sqlpis)			
If dw_summary.Retrieve(ls_forecastdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err1'
//	MessageBox("발주취소오류", "납입예정 Summary정보를 읽지 못했습니다.", StopSign! )
	Goto RollBack_			
End If
//ls_compMonth2 = left( ls_forecastdate, 7 )	//납입예정기준월
//If ls_compMonth > ls_compMonth2 Then
//	dw_summary.SetTransObject(Sqlpis)			
//	If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.ReSet();	dw_summary.InsertRow(0)
//		dw_summary.SetItem( 1, 'applydate'		, ls_forecastdate )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		//Interface Flag 활용
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partforecastqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partforecastqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'				, 'Y' )		//Interface Flag 활용
dw_summary.SetItem( 1, 'lastdate'			, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//납입예정 Summary
If dw_summary.Update() = -1 Then	
	ls_message = 'summaryUpdate_Err1'
//	MessageBox("발주오류", "납입예정 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//HOST 데이타전달 자료생성
String	ls_orderSeq
ls_orderSeq	= This.GetItemString(ll_Row	, 'orderseq')

  INSERT INTO TPARTKBORDER_INTERFACE  
         ( OrderSeq,    
           SeqNo,   
           MISFlag,   
           InterfaceFlag,   
           AreaCode,   
           DivisionCode,   
           SupplierCode,   
           ItemCode,   
           PartKBNo,   
           PartOrderDate,   
           RackQty,   
           PartForecastDate,   
           LastEmp,   
           LastDate )  
  VALUES ( :ls_orderSeq,   
           1,   
           'D',   
           'Y',   
           :istr_partkb.areacode,   
           :istr_partkb.divcode,   
           :ls_suppCode,   
           :ls_itemCode,   
           :is_partkbno,   
           :ls_orderdate,   
           :ll_Qty,   
           :ls_forecastdate,   
           :g_s_empno,   
           :idt_nowtime )  
	USING	sqlpis ;
	
If sqlpis.SqlCode <> 0 Then 
	ls_message = 'ORDERINTERFACE_Err'
//	MessageBox("발주오류", "Interface 정보 생성에 실패하였습니다." + sqlpis.sqlerrtext, StopSign! )
	Goto RollBack_			
End If
//
//	개별간판상태저장
If wf_cancelset() = -1 Then 
	ls_message = 'cancelset_Err'
	Goto RollBack_			
End If
		
this.SetTransObject(Sqlpis)								//간판상태
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("발주오류", "발주취소간판 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
Return 1 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

If ls_message = 'summaryRetrieve_Err' Then
	MessageBox("발주취소실패", "발주 Summary정보를 읽지 못했습니다.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err' Then
	MessageBox("발주취소실패", "발주 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'summaryRetrieve_Err1' Then
	MessageBox("발주취소실패", "납입예정 Summary정보를 읽지 못했습니다.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err1' Then
	MessageBox("발주취소실패", "납입예정 Summary 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'ORDERINTERFACE_Err' Then
	MessageBox("발주취소실패", "Interface 정보 생성에 실패하였습니다.", StopSign! )
ElseIf ls_message = 'cancelset_Err' Then
	MessageBox("발주취소실패", "발주취소간판설정에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("발주취소실패", "발주취소간판 저장에서 오류가 발생하였습니다.", StopSign! )
Else
	MessageBox("발주취소실패", "발주취소작업을 실패하였습니다.", StopSign! )
End If

return -1

end event

event clicked;dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1

end event

type dw_pisr110b_02 from u_vi_std_datawindow within w_pisr110b
integer x = 9
integer y = 1072
integer width = 3589
integer height = 800
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisr110b_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1
end event

type uo_area from u_pisc_select_area within w_pisr110b
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 60
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

dw_pisr110b_01.Reset()
dw_pisr110b_01.SetTransObject (sqlpis)
dw_pisr110b_01.InsertRow(1) 

dw_pisr110b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr110b
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_pisr110b_01.Reset()
dw_pisr110b_01.SetTransObject (sqlpis)
dw_pisr110b_01.InsertRow(1) 

dw_pisr110b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_scan from datawindow within w_pisr110b
integer x = 32
integer y = 212
integer width = 1330
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

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "확인", "작업처리 권한이 부여되지 않았습니다.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 11 Then 
	MessageBox( "입력오류", "올바른 간판번호 가 아닙니다.", StopSign! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
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

type dw_lastedit from datawindow within w_pisr110b
integer x = 1586
integer y = 1024
integer width = 645
integer height = 884
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "마지막납입편수저장"
string dataobject = "d_pisr110b_last"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_summary from datawindow within w_pisr110b
integer x = 750
integer y = 1024
integer width = 832
integer height = 980
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "간판수량 Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_orderseq from datawindow within w_pisr110b
integer x = 2235
integer y = 1024
integer width = 626
integer height = 736
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "발주전산번호관리"
string dataobject = "d_pisr_orderseq"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_pisr110b
integer x = 2267
integer y = 64
integer width = 553
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "발주및발주취소"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110  
   WHERE WIN_ID = 'w_pisr110b' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type cb_2 from commandbutton within w_pisr110b
integer x = 2857
integer y = 64
integer width = 704
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "개별간판Active전환"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110
   WHERE WIN_ID = 'w_pisr150b' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type gb_2 from groupbox within w_pisr110b
integer x = 1234
integer width = 978
integer height = 180
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

type gb_3 from groupbox within w_pisr110b
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

type gb_scan from groupbox within w_pisr110b
integer x = 18
integer y = 168
integer width = 1358
integer height = 208
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr110b
integer x = 2226
integer width = 1362
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217730
long backcolor = 12632256
end type

