$PBExportHeader$w_pisr122u.srw
$PBExportComments$���Կ������ں��� - ���Ǵ���
forward
global type w_pisr122u from w_ipis_sheet01
end type
type dw_2 from datawindow within w_pisr122u
end type
type dw_3 from u_vi_std_datawindow within w_pisr122u
end type
type uo_area from u_pisc_select_area within w_pisr122u
end type
type uo_division from u_pisc_select_division within w_pisr122u
end type
type dw_scan from datawindow within w_pisr122u
end type
type pb_1 from picturebutton within w_pisr122u
end type
type gb_3 from groupbox within w_pisr122u
end type
type gb_scan from groupbox within w_pisr122u
end type
type gb_1 from groupbox within w_pisr122u
end type
type dw_summary from datawindow within w_pisr122u
end type
end forward

global type w_pisr122u from w_ipis_sheet01
integer width = 4498
event ue_process ( )
event ue_init ( )
dw_2 dw_2
dw_3 dw_3
uo_area uo_area
uo_division uo_division
dw_scan dw_scan
pb_1 pb_1
gb_3 gb_3
gb_scan gb_scan
gb_1 gb_1
dw_summary dw_summary
end type
global w_pisr122u w_pisr122u

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowTime, is_jobDate, is_applyDate	//����ð�, �۾���������, ������������
DateTime	idt_nowTime										//����ð�
String	is_oldflag, is_changeflag					//���� ���ֺ��� Flag
end variables

forward prototypes
public function integer wf_validchk ()
public function integer wf_sumadd (long al_row, string as_date, datetime adt_nowtime)
public function integer wf_sumsubtract (long al_row, string as_date, datetime adt_nowtime)
end prototypes

event ue_process();//////////////////////////////////
//		���Կ����� ���� Control
//////////////////////////////////
Long		ll_Row
String	ls_null

SetNull(ls_null)

ll_Row = wf_validchk()
If ll_Row = -1 Then 
	dw_scan.SetItem(1, 'scancode', ls_null )
	dw_scan.SetColumn('scancode')
	dw_scan.SetFocus()
	Return
End If

dw_2.SetColumn('changeforecastdate')
dw_2.SetFocus()

Return 


end event

event ue_init();
pb_1.Enabled = m_frame.m_action.m_save.Enabled

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//��ȸ

dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

public function integer wf_validchk ();/////////////////////////////////////////////////////////
//		���Կ����� ���� ������ Chech�Ѵ�.
/////////////////////////////////////////////////////////
String	ls_areaCode, ls_divCode
String	ls_KBStatus, ls_OrderPossible, ls_useFlag, ls_ReprintFlag, ls_kbactivegubun
Long		ll_Row
String	ls_DeliveryNo
DateTime ldt_ForecastTime

  SELECT AreaCode,   
         DivisionCode,   
         PartKBStatus,   
         DeliveryNo,
			PartforecastTime
    INTO :ls_areaCode,
	 		:ls_divCode,
			:ls_KBStatus,   
         :ls_DeliveryNo,
			:ldt_ForecastTime
    FROM TPARTKBSTATUS  
   WHERE PartKBNo = :is_partkbno
   USING sqlpis;

If sqlpis.SqlCode <> 0 Then 
	MessageBox( "�Է¿���", "�������� �ʴ� ���ǹ�ȣ�Դϴ�. ", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "�Է¿���", "�ش� ������ ������ �ƴմϴ�.", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

CHOOSE CASE ls_KBStatus
	CASE 'B'
			MessageBox( "Ȯ��", "���� ���԰� ������ �����Դϴ�.", Information! )
			dw_2.ReSet() 
			dw_2.InsertRow(1) 
			Return -1
	CASE 'C', 'D'
			MessageBox( "Ȯ��", "���ֵ��� ���� �����Դϴ�.", Information! )
			dw_2.ReSet() 
			dw_2.InsertRow(1) 
			Return -1
	CASE ELSE
END CHOOSE

If Not ( isNull(ls_DeliveryNo) Or Trim(ls_DeliveryNo) = '' ) Then 
	MessageBox( "Ȯ��", "��ǰǥ�� ����� ������ ���Կ������� ������ �� �����ϴ�.", Information! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

If ldt_ForecastTime <= idt_nowtime Then 
	MessageBox( "Ȯ��", "���Կ������ڰ� ���� ������ ���Կ������� ������ �� �����ϴ�.", Information! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

dw_2.SetTransObject (sqlpis)
ll_Row = dw_2.Retrieve(is_partkbno)

is_oldflag 		= dw_2.GetItemString(1, "orderchangeflag")
is_changeflag 	= 'N'

return ll_Row


end function

public function integer wf_sumadd (long al_row, string as_date, datetime adt_nowtime);/////////////////////////////////
//	 ���Կ��� Summary���� 
/////////////////////////////////
String	ls_suppCode, ls_itemCode
Long		ll_Qty, ll_qtySum

ls_suppCode		= dw_2.GetItemString( al_row, 'suppliercode' )
ls_itemCode		= dw_2.GetItemString( al_row, 'itemcode' )
ll_Qty			= dw_2.GetItemNumber( al_row, 'rackqty' )
	
//	���Կ������� Summary���� (����)
dw_summary.SetTransObject(Sqlpis)			
If dw_summary.Retrieve(as_date, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, as_date )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag Ȱ��
	dw_summary.SetItem( 1, 'lastdate'		, adt_nowTime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partforecastqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partforecastqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'				, 'Y' )	//Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'			, adt_nowTime )

dw_summary.SetTransObject(Sqlpis)						//���Կ��� Summary
If dw_summary.Update() = -1 Then	
//	MessageBox("���ֺ������", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Return -1
End If

return 0
end function

public function integer wf_sumsubtract (long al_row, string as_date, datetime adt_nowtime);///////////////////////
String	ls_suppCode, ls_itemCode
Long		ll_Qty, ll_qtySum

ls_suppCode		= dw_2.GetItemString( al_row, 'suppliercode' )
ls_itemCode		= dw_2.GetItemString( al_row, 'itemcode' )
ll_Qty			= dw_2.GetItemNumber( al_row, 'rackqty' )
	
//���Կ������� Summary���� (���)
dw_summary.SetTransObject(Sqlpis)			
If dw_summary.Retrieve(as_date, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//	MessageBox("���ֺ������", "���Կ��� Summary������ ���� ���߽��ϴ�.", StopSign! )
	Return -1
End If
//�� �������� ����� �ʿ��������� 2002.10.31
//String	ls_applyMonth, ls_Month 
//ls_applyMonth	= left(as_applydate, 7)
//ls_Month = left( as_date, 7 )	//���Կ������ؿ�
//If ls_applymonth > ls_Month Then
//	dw_summary.SetTransObject(Sqlpis)			
//	If dw_summary.Retrieve(as_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.InsertRow(1)
//		dw_summary.SetItem( 1, 'applydate'		, as_date )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag Ȱ��
//		dw_summary.SetItem( 1, 'lastdate'		, adt_nowTime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partforecastqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partforecastqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'				, 'Y' )	//Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'			, adt_nowTime )

dw_summary.SetTransObject(Sqlpis)						//���Կ��� Summary
If dw_summary.Update() = -1 Then	
//	MessageBox("���ֺ������", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Return -1			
End If

return 0
end function

on w_pisr122u.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_scan=create dw_scan
this.pb_1=create pb_1
this.gb_3=create gb_3
this.gb_scan=create gb_scan
this.gb_1=create gb_1
this.dw_summary=create dw_summary
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_scan
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_scan
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_summary
end on

on w_pisr122u.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_scan)
destroy(this.pb_1)
destroy(this.gb_3)
destroy(this.gb_scan)
destroy(this.gb_1)
destroy(this.dw_summary)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

end event

event open;call super::open;
dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1) 

dw_summary.Visible = False

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

DataWindowChild ldwc

dw_2.SetTransObject (sqlpis)
If dw_2.GetChild('orderchangecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet(); 
	If ldwc.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode) = 0 Then ldwc.InsertRow(1) 
End If 
dw_2.InsertRow(1) 

end event

event ue_save;call super::ue_save;/////////////////////////////////////////
//		���Կ������� ���泻�� ����
/////////////////////////////////////////
String	ls_partKBNo, ls_suppCode
String	ls_orderdate, ls_forecastdate, ls_changeDate, ls_partEditTime
Long		ll_changeNo
String	ls_changeCode
String	ls_compDate
DateTime	ldt_nowTime, ldt_ordertime, ldt_forecasttime
DateTime	ldt_changetime //,ldt_forecasttime 	//���泳�Կ����ð�, ���Կ����ð�
String	ls_Message = ''

ldt_nowTime		= f_pisc_get_date_nowtime()		//���� �ý��۽ð�

dw_2.AcceptText()

//	�������� Ȯ��
ls_partKBNo		= dw_2.GetItemString(1, 'partkbno')
If isNull(ls_partKBNo) Or Trim(ls_partKBNo) = '' then 
	MessageBox("Ȯ��", "���õ� ������ �����ϴ�.", Information! )
	Return -1 
End If

ls_changeDate	= dw_2.GetItemString(1, 'changeforecastdate')
ll_changeNo		= dw_2.GetItemNumber(1, 'changeforecasteditno')
ls_changeCode 	= dw_2.GetItemString(1, 'orderchangecode')

If isNull(ls_changeDate) Or Trim(ls_changeDate) = '' Then 
	MessageBox("Ȯ��", "���泳�Կ������� �Էµ��� �ʾҽ��ϴ�.", Information! )
	dw_2.SetColumn('changeforecastdate')
	dw_2.SetFocus()
	Return 1
End If
If isNull(ll_changeNo) Or ll_changeNo = 0 Then 
	MessageBox("Ȯ��", "��������� �Էµ��� �ʾҽ��ϴ�.", Information! )
	dw_2.SetColumn('changeforecasteditno')
	dw_2.SetFocus()
	Return 1
End If
If isNull(ls_changeCode) Or Trim(ls_changeCode) = '' Then 
	MessageBox("Ȯ��", "��������� ���õ��� �ʾҽ��ϴ�.", Information! )
	dw_2.SetColumn('orderchangecode')
	dw_2.SetFocus()
	Return 1
End If

ls_suppCode		= dw_2.GetItemString(1, 'suppliercode')
ls_orderdate	= dw_2.GetItemString(1, 'partorderdate')
ls_changeDate	= dw_2.GetItemString(1, 'changeforecastdate')
ls_forecastdate = dw_2.GetItemString(1, 'partforecastdate')

If ( Not isNull(ls_changeDate)) And (Not isDate(ls_changeDate)) Then
	MessageBox( "�Է¿���", ls_partKBNo + "�������ڸ� YYYY.MM.DD �������� �Է��Ͽ��ּ���.", StopSign!)		
	dw_2.SetColumn('changeforecastdate')
	dw_2.SetFocus()
	Return -1			
End If
//�����Է���������
f_pisc_get_date_convert(ls_changeDate, "YYYY.MM.DD", ls_changeDate) 
dw_2.SetItem(1 , "changeforecastdate", ls_changeDate )

If Not isNull(ll_changeNo) Then
	  SELECT TMSTPARTEDIT.PartEditTime  
		 INTO :ls_partEditTime  
		 FROM TMSTPARTEDIT  
		WHERE TMSTPARTEDIT.AreaCode 		= :istr_partkb.areacode 	AND  
				TMSTPARTEDIT.DivisionCode 	= :istr_partkb.divcode 		AND  
				TMSTPARTEDIT.SupplierCode 	= :ls_suppCode 	AND  
				TMSTPARTEDIT.ApplyFrom 		<=:ls_orderDate 	AND  
				TMSTPARTEDIT.ApplyTo 		>=:ls_orderDate   AND
				TMSTPARTEDIT.PartEditNo 	= :ll_changeNo   
		USING	sqlpis	;
	If sqlpis.SqlCode <> 0 Then 
		MessageBox( "�Է¿���", ls_partKBNo + " ������ ������� �Է��� �ùٸ��� �ʽ��ϴ�.", StopSign! )
		dw_2.SetColumn('changeforecasteditno')
		dw_2.SetFocus()
		return -1
	End If
End If
If ( Not isNull(ls_changeDate)) And ( Not isNull(ll_changeNo)) Then
	If ls_partEditTime >= '00:00' And ls_partEditTime < '08:00' Then
		ls_compDate = f_pisr_getdaybefore( ls_changeDate, 1 ) 
	Else
		ls_compDate = ls_changeDate 
	End If
	ldt_changetime = DateTime(Date(ls_compDate), Time(ls_partEditTime))
	dw_2.SetItem(1 , "changeforecasttime", ldt_changetime )
End If

ldt_forecasttime	= DateTime(Date(ls_forecastdate), Time(ls_partEditTime))
ldt_ordertime = dw_2.GetItemDateTime(1, 'partordertime')
If ldt_ordertime > ldt_forecasttime Then 
	MessageBox( "�Է¿���", "���ֽð� ���� ���� �ð����δ� ������ �� �����ϴ�.", StopSign! )
	dw_2.SetColumn('changeforecasteditno')
	dw_2.SetFocus()
	return -1
End If
If ldt_nowTime > ldt_forecasttime Then 
	MessageBox( "�Է¿���", "����ð� ���� ���� �ð����δ� ������ �� �����ϴ�.", StopSign! )
	dw_2.SetColumn('changeforecasteditno')
	dw_2.SetFocus()
	return -1
End If

is_changeflag = "Y"	//���ֺ���

/////////////////////////////////////////////
//		���� ���氪  ����
/////////////////////////////////////////////
dw_2.SetItem(1, "changeforecastdate"	, ls_changeDate )
dw_2.SetItem(1, "changeforecasteditno"	, ll_changeNo )
dw_2.SetItem(1, "orderchangeflag"		, is_changeflag )
dw_2.SetItem(1, "orderchangetime"		, ldt_nowTime )
dw_2.SetItem(1, "lastemp"					, 'Y' )	//Interface Flag Ȱ��
dw_2.SetItem(1, "lastdate"					, ldt_nowTime )

SetPointer(HourGlass!)
sqlpis.AutoCommit = False
/////////////////////////////////////////////
//		���ֺ������ Summary���� �� Ȯ��
/////////////////////////////////////////////
DateTime	ldt_oldTime 								//�������泳�Կ����ð�
String	ls_summaryDate
String	ls_Null
Integer	li_null

SetNull(ls_Null)
SetNull(li_null)

SELECT TPARTKBSTATUS.ChangeForecastTime  
	INTO :ldt_oldTime
FROM TPARTKBSTATUS  
WHERE TPARTKBSTATUS.PartKBNo = :ls_partKBNo
USING	sqlpis	;

CHOOSE CASE is_oldflag
	CASE 'Y'
		ls_summaryDate = left(String(ldt_oldTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumsubtract(1, ls_summaryDate, ldt_nowTime) 	= -1 Then 
			ls_Message = "Summary"
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_changeTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumadd(1, ls_summaryDate, ldt_nowTime) 	 	= -1 Then 
			ls_Message = "Summary"
			Goto RollBack_			
		End If
	CASE 'N'
		ls_summaryDate = left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumsubtract(1, ls_summaryDate, ldt_nowTime) 	= -1 Then 
			ls_Message = "Summary"
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_changeTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumadd(1, ls_summaryDate, ldt_nowTime) 			= -1 Then 
			ls_Message = "Summary"
			Goto RollBack_			
		End If
END CHOOSE

//	���ǻ�������
dw_2.SetTransObject(Sqlpis)									//���ǻ���
If dw_2.Update() = -1 Then 
	ls_Message = "PartKB"
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
dw_2.RowsCopy(1,1, Primary!, dw_3, 1, Primary!)

dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 0 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

CHOOSE CASE ls_Message
	CASE "Summary"
		MessageBox("���ֺ������", "���Կ��� Summary���忡 ���� �Ͽ����ϴ�.", StopSign! )
	CASE "PartKB"
		MessageBox("���ֺ������", "���ֺ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
END CHOOSE
return -1


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr122u
integer y = 1884
end type

type dw_2 from datawindow within w_pisr122u
event ue_key pbm_dwnkey
integer y = 220
integer width = 4384
integer height = 872
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr122u_01"
boolean border = false
boolean livescroll = true
end type

event ue_key;If key = KeyEnter! or key = KeyDownArrow! Then 
	send(handle(this), 256, 9, long(0,0))
	Return 1
End If 
end event

event itemchanged;String	ls_areaCode, ls_divCode, ls_suppCode
String 	ls_colName, ls_Data
String	ls_changeDate, ls_changeFlag, ls_orderDate
DateTime	ldt_forecasttime
String	ls_compDate, ls_partEditTime
String	ls_Null
Integer	li_Null
String	ls_partkbno

SetNull(ls_Null)
SetNull(li_Null)

ls_colName 			= This.GetcolumnName()
ls_partkbno			= This.GetItemString(row, 'partkbno')
IF isNull(ls_partkbno) Or Trim(ls_partkbno) = '' Then Return 1

ls_areaCode			= This.GetItemString(row, 'areacode')
ls_divCode			= This.GetItemString(row, 'divisioncode')
ls_suppCode			= This.GetItemString(row, 'suppliercode')
ls_orderDate		= This.GetItemString(row, 'partorderdate')
ls_changeDate 		= This.GetItemString(row, 'changeforecastdate')
ldt_forecasttime	= This.GetItemDateTime(row, 'partforecasttime')
ls_changeFlag		= 'N'

Choose Case ls_colName
	Case 'changeforecastdate'
		ls_Data = data
		IF (Not isDate(data)) or len(data) <> 10 Then
			MessageBox( "�Է¿���", "�������ڸ� YYYY.MM.DD �������� �Է��Ͽ��ּ���.", &
			            Information!)		
			this.SetItem(row , "changeforecastdate", ls_Null )
			Return 1			
		End IF
		f_pisc_get_date_convert(ls_Data, "YYYY.MM.DD", ls_Data) 
		this.SetItem(row , "changeforecastdate", ls_Data )
		If Not isNull(ldt_forecasttime) Then
			ls_partEditTime= mid(String( ldt_forecasttime, 'yyyy.mm.dd hh:mm' ), 12, 5 )
			If ls_partEditTime >= '00:00' And ls_partEditTime < '08:00' Then
				ls_compDate = f_pisr_getdaybefore( ls_Data, 1 ) 
			Else
				ls_compDate = ls_Data 
			End If
		End If
		ldt_forecasttime	= DateTime(Date(ls_compDate), Time(ls_partEditTime))
		this.SetItem(row , "changeforecasttime", ldt_forecasttime )
		ls_changeFlag = 'Y'
		
	Case 'changeforecasteditno'
		If	Trim(ls_changeDate) = '' Or isNull(ls_changeDate) Then 
			MessageBox( "�Է¿���", "�������ڸ� YYYY.MM.DD �������� �Է��Ͽ��ּ���.", &
			            Information!)		
			this.SetItem(row , "changeforecasteditno", li_null )
			this.SetFocus()
			return 1
		End If

		  SELECT TMSTPARTEDIT.PartEditTime  
			 INTO :ls_partEditTime  
			 FROM TMSTPARTEDIT  
			WHERE TMSTPARTEDIT.AreaCode 		= :ls_areaCode 	AND  
					TMSTPARTEDIT.DivisionCode 	= :ls_divCode 		AND  
					TMSTPARTEDIT.SupplierCode 	= :ls_suppCode 	AND  
					TMSTPARTEDIT.ApplyFrom 		<=:ls_orderDate 	AND  
					TMSTPARTEDIT.ApplyTo 		>=:ls_orderDate   AND
					TMSTPARTEDIT.PartEditNo 	= :data   
			USING	sqlpis	;
		If sqlpis.SqlCode <> 0 Then 
			MessageBox( "�Է¿���", "�����Ǿ� ���� ���� ����Դϴ�. ", StopSign! )
			this.SetItem(row , "changeforecasteditno", li_null )
			this.SetFocus()
			return 1
		End If
		If ls_partEditTime >= '00:00' AND ls_partEditTime < '08:00' Then
			ls_compDate = f_pisr_getdaybefore( ls_changeDate, 1 )
		Else
			ls_compDate = ls_changeDate
		End IF
		ldt_forecasttime	= DateTime(Date(ls_compDate), Time(ls_partEditTime))
		this.SetItem(row , "changeforecasttime", ldt_forecasttime )
		ls_changeFlag = 'Y'

	Case 'orderchangecode'
		If Not isNull(ldt_forecasttime) Then	ls_changeFlag = 'Y'
End Choose 

return 0
end event

event retrievestart;DataWindowChild ldwc

If This.GetChild('orderchangecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet(); 
	If ldwc.Retrieve( istr_partkb.areacode, istr_partkb.divcode) = 0 Then ldwc.InsertRow(1) 
End If 

end event

type dw_3 from u_vi_std_datawindow within w_pisr122u
integer x = 14
integer y = 1096
integer width = 2889
integer height = 716
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisr122u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1
end event

event retrievestart;call super::retrievestart;DataWindowChild ldwc

If This.GetChild('orderchangecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet(); 
	If ldwc.Retrieve( istr_partkb.areacode, istr_partkb.divcode) = 0 Then ldwc.InsertRow(1) 
End If 

end event

type uo_area from u_pisc_select_area within w_pisr122u
event destroy ( )
integer x = 82
integer y = 84
integer taborder = 10
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
dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

//dw_pisr150b_02.Reset()
SetNull(is_partkbno)

dw_scan.SetItem(1, 'scancode', is_partkbno )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr122u
event destroy ( )
integer x = 631
integer y = 84
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_2.Reset()
dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

//dw_pisr150b_02.Reset()
SetNull(is_partkbno)

dw_scan.SetItem(1, 'scancode', is_partkbno )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_scan from datawindow within w_pisr122u
integer x = 1257
integer y = 44
integer width = 1330
integer height = 148
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;
This.SelectText(1,15)
end event

event itemchanged;
SetNull(is_partkbno)

If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "Ȯ��", "�۾�ó�� ������ �ο����� �ʾҽ��ϴ�.", Information! )
	This.SetItem(1, 'scancode', is_partkbno )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 11 Then 
	MessageBox( "Ȯ��", "�ùٸ� ���ǹ�ȣ �� �ƴմϴ�.", Information! )
	This.SetItem(1, 'scancode', is_partkbno )
	This.Object.scancode.SetFocus()
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//���� �ý��۽ð�
//is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
//is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//�������� -8�ð������
//is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//�������� -8�ð�,������ �����

is_partkbno = data
Parent.TriggerEvent( "ue_process" )

return 0

end event

type pb_1 from picturebutton within w_pisr122u
integer x = 2674
integer y = 64
integer width = 457
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
boolean originalsize = true
end type

event clicked;
Parent.PostEvent("ue_save")

end event

type gb_3 from groupbox within w_pisr122u
integer x = 18
integer width = 1202
integer height = 208
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_scan from groupbox within w_pisr122u
integer x = 1243
integer width = 1358
integer height = 208
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr122u
integer x = 2624
integer width = 549
integer height = 208
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_summary from datawindow within w_pisr122u
integer x = 2976
integer y = 1116
integer width = 1001
integer height = 848
integer taborder = 50
boolean titlebar = true
string title = "���Ǽ��� Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

