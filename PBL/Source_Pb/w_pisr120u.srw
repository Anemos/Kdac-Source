$PBExportHeader$w_pisr120u.srw
$PBExportComments$���Կ������ں���ȭ�� - ���Կ������ں�����
forward
global type w_pisr120u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr120u
end type
type uo_division from u_pisc_select_division within w_pisr120u
end type
type dw_pisr120u_01 from u_vi_std_datawindow within w_pisr120u
end type
type dw_summary from datawindow within w_pisr120u
end type
type uo_date from u_pisc_date_applydate_1 within w_pisr120u
end type
type st_2 from statictext within w_pisr120u
end type
type dw_condition from datawindow within w_pisr120u
end type
type dw_condition2 from datawindow within w_pisr120u
end type
type gb_3 from groupbox within w_pisr120u
end type
type gb_2 from groupbox within w_pisr120u
end type
type gb_1 from groupbox within w_pisr120u
end type
end forward

global type w_pisr120u from w_ipis_sheet01
event ue_init ( )
uo_area uo_area
uo_division uo_division
dw_pisr120u_01 dw_pisr120u_01
dw_summary dw_summary
uo_date uo_date
st_2 st_2
dw_condition dw_condition
dw_condition2 dw_condition2
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_pisr120u w_pisr120u

type variables
str_pisr_partkb istr_partkb
Long		il_lastRow
String	is_date
end variables

forward prototypes
public function integer wf_sumadd (long al_row, string as_date, datetime adt_nowtime)
public function integer wf_sumsubtract (long al_row, string as_date, datetime adt_nowtime)
end prototypes

event ue_init();
SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//��ȸ

//���� �۾����� 
DateTime	ldt_nowTime
String	ls_applyDate 

ldt_nowTime	= f_pisc_get_date_nowtime()				//���� �ý��۽ð�
ls_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//�������� -8�ð�,������ �����
//MessageBox('', ls_applyDate )
//is_date		= f_pisr_nextworkday(istr_partkb.areacode, istr_partkb.divcode, ls_applyDate, 1)
//If isNull(is_date) Or is_date = '' Then	Return
is_date = ls_applydate
//MessageBox('', ls_nextDate )

uo_date.is_uo_date 	= is_date
uo_date.sle_date.Text= is_date
uo_date.id_uo_date 	= Date(is_date)

end event

public function integer wf_sumadd (long al_row, string as_date, datetime adt_nowtime);String	ls_suppCode, ls_itemCode
Long		ll_Qty, ll_qtySum

ls_suppCode		= dw_pisr120u_01.GetItemString( al_row, 'suppliercode' )
ls_itemCode		= dw_pisr120u_01.GetItemString( al_row, 'itemcode' )
ll_Qty			= dw_pisr120u_01.GetItemNumber( al_row, 'rackqty' )
	
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
ELSE
	return 0
End If

end function

public function integer wf_sumsubtract (long al_row, string as_date, datetime adt_nowtime);String	ls_suppCode, ls_itemCode
Long		ll_Qty, ll_qtySum

ls_suppCode		= dw_pisr120u_01.GetItemString( al_row, 'suppliercode' )
ls_itemCode		= dw_pisr120u_01.GetItemString( al_row, 'itemcode' )
ll_Qty			= dw_pisr120u_01.GetItemNumber( al_row, 'rackqty' )
	
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
else
	return 0
End If

end function

on w_pisr120u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisr120u_01=create dw_pisr120u_01
this.dw_summary=create dw_summary
this.uo_date=create uo_date
this.st_2=create st_2
this.dw_condition=create dw_condition
this.dw_condition2=create dw_condition2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisr120u_01
this.Control[iCurrent+4]=this.dw_summary
this.Control[iCurrent+5]=this.uo_date
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_condition
this.Control[iCurrent+8]=this.dw_condition2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
end on

on w_pisr120u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisr120u_01)
destroy(this.dw_summary)
destroy(this.uo_date)
destroy(this.st_2)
destroy(this.dw_condition)
destroy(this.dw_condition2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;
il_lastRow = 0

dw_summary.Visible = False

dw_condition.SetTransObject (sqlpis)
dw_condition.InsertRow(1) 
dw_condition2.SetTransObject (sqlpis)
dw_condition2.InsertRow(1) 

this.PostEvent ( "ue_init" )
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

dw_pisr120u_01.Width = newwidth 	- ( dw_pisr120u_01.x + ls_gap * 2 )
dw_pisr120u_01.Height= newheight - ( dw_pisr120u_01.y + ls_status )

end event

event ue_retrieve;call super::ue_retrieve;String	ls_suppCode, ls_itemCode 
String	ls_forcastdate, ls_productgroup
Long		ll_Row, ll_RowCnt

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

ls_forcastdate		= uo_date.is_uo_date
If isNull(ls_forcastdate) Or Trim(ls_forcastdate) = '' Then 
//	ldt_nowTime		= f_pisc_get_date_nowtime()														//���� �ý��۽ð�
//	ls_jobdate		= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//�������� -8�ð������
//	ls_forcastdate = f_pisr_getdaybefore( ls_jobdate, 1 )	//���� ����
	uo_status.st_message.text =  "�˻��� ���Կ������ڸ� �����Ͽ��ּ���." 
	MessageBox('Ȯ��','�˻��� ���Կ������ڸ� �����Ͽ��ּ���', Information!)
	Return
End If

dw_pisr120u_01.SetRedraw(False)
dw_pisr120u_01.SetTransObject (sqlpis)
ll_RowCnt = dw_pisr120u_01.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, ls_productGroup, ls_forcastdate )
dw_pisr120u_01.SetRedraw(True)

//If isNull(ls_productgroup) Or Trim(ls_productgroup) = '' Then 
//	dw_pisr120u_01.DataObject = "d_pisr120u_01"		//ǰ��,���Կ����Ͽ� ���� �˻�
//	dw_pisr120u_01.SetRedraw(False)
//	dw_pisr120u_01.SetTransObject (sqlpis)
//	ll_RowCnt = dw_pisr120u_01.Retrieve( istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode, ls_forcastdate )
//	dw_pisr120u_01.SetRedraw(True)
//Else
//	dw_pisr120u_01.DataObject = "d_pisr120u_02"		//��ǰ��,ǰ��,���Կ����Ͽ� ���� �˻�
//	dw_pisr120u_01.SetRedraw(False)
//	dw_pisr120u_01.SetTransObject (sqlpis)
//	ll_RowCnt = dw_pisr120u_01.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_productgroup, istr_partkb.itemcode, ls_forcastdate )
//	dw_pisr120u_01.SetRedraw(True)
//End IF

If ll_RowCnt < 1 Then 
	uo_status.st_message.text =  "�ش��Ͽ� ���Ե� ������ �������� �ʽ��ϴ�."
	MessageBox("Ȯ��", "�ش��Ͽ� ���Ե� ������ �������� �ʽ��ϴ�.", Information!)
End If



end event

event ue_save;call super::ue_save;/////////////////////////////////////////
//		���� ���泻�� ����
/////////////////////////////////////////

String	ls_suppCode
String	ls_partKBNo, ls_orderdate, ls_forecastdate, ls_changeDate, ls_partEditTime
Long		ll_changeNo
String	ls_changeCode
String	ls_Flag, ls_compDate
DateTime	ldt_nowTime, ldt_forecasttime
String	ls_message = ''

If il_lastRow = 0 Then 
	MessageBox( "����", "���������� �������� �ʽ��ϴ�.", Information! )
	Return 0
End If

dw_pisr120u_01.accepttext()
ldt_nowTime		= f_pisc_get_date_nowtime()		//���� �ý��۽ð�

//	������ ���� ���� ValidChk
ls_partKBNo		= dw_pisr120u_01.GetItemString(il_lastRow	, 'partkbno')
ls_suppCode		= dw_pisr120u_01.GetItemString(il_lastRow	, 'suppliercode')
ls_orderdate	= dw_pisr120u_01.GetItemString(il_lastRow	, 'partorderdate')
ls_changeDate	= dw_pisr120u_01.GetItemString(il_lastRow	, 'changeforecastdate')
//messagebox(string(il_lastRow), ls_partKBNo + ' ' + ls_forecastdate)
If ( Not isNull(ls_changeDate)) And (Not isDate(ls_changeDate)) Then
	MessageBox( "�Է¿���", ls_partKBNo + "������ �������ڸ� YYYY.MM.DD �������� �Է��Ͽ��ּ���.", StopSign!)		
	Return -1			
End If

//�����Է���������
If Not isNull(ls_changeDate) Then
	f_pisc_get_date_convert(ls_changeDate, "YYYY.MM.DD", ls_changeDate) 
	dw_pisr120u_01.SetItem(il_lastRow , "changeforecastdate", ls_changeDate )
End If

ll_changeNo		= dw_pisr120u_01.GetItemNumber(il_lastRow	, 'changeforecasteditno')
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
		return -1
	End If
End If
If ( Not isNull(ls_changeDate)) And ( Not isNull(ll_changeNo)) Then
	If ls_partEditTime >= '00:00' And ls_partEditTime < '08:00' Then
		ls_compDate = f_pisr_getdaybefore( ls_changeDate, 1 ) 
	Else
		ls_compDate = ls_changeDate 
	End If
	ldt_forecasttime	= DateTime(Date(ls_compDate), Time(ls_partEditTime))
	dw_pisr120u_01.SetItem(il_lastRow , "changeforecasttime", ldt_forecasttime )
	ls_Flag = 'Y'	//���ֺ���
Else
	ls_Flag = 'N'	//���ֹ̺���
End If

/////////////////////////////////////////////
//		���� ���氪  ����
/////////////////////////////////////////////
dw_pisr120u_01.SetItem(il_lastRow, "changeforecastdate"	, ls_changeDate )
dw_pisr120u_01.SetItem(il_lastRow, "changeforecasteditno", ll_changeNo )
dw_pisr120u_01.SetItem(il_lastRow, "orderchangeflag"		, ls_Flag )
dw_pisr120u_01.SetItem(il_lastRow, "orderchangetime"		, ldt_nowTime )
dw_pisr120u_01.SetItem(il_lastRow, "lastemp"					, 'Y' )	//Interface Flag Ȱ��
dw_pisr120u_01.SetItem(il_lastRow, "lastdate"				, ldt_nowTime )

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

/////////////////////////////////////////////
//		���ֺ������ Summary���� �� Ȯ��
/////////////////////////////////////////////
Integer	I, ll_rowCnt, li_changeCnt				//÷��, line��, ������μ�
String	ls_oldFlag//, ls_Flag					//���� ���ֺ���Flag, ���ֺ���Flag
//String	ls_changeDate								//���泳�Կ�����
DateTime	ldt_changetime //,ldt_forecasttime 	//���泳�Կ����ð�, ���Կ����ð�
DateTime	ldt_oldTime 								//�������泳�Կ����ð�
String	ls_summaryDate
String	ls_Null
Integer	li_null

SetNull(ls_Null)
SetNull(li_null)

ll_rowCnt = dw_pisr120u_01.RowCount()

If ll_rowCnt < 1 Then Return -1

li_changeCnt = 0

For I = 1 To ll_rowCnt Step 1
	ls_partKBNo			= dw_pisr120u_01.GetItemString( I, 'partkbno' )
	ls_changeCode		= dw_pisr120u_01.GetItemString( I, 'orderchangecode' )
	ls_forecastdate	= dw_pisr120u_01.GetItemString( I, 'partforecastdate' )
	ls_changeDate		= dw_pisr120u_01.GetItemString( I, 'changeforecastdate' )
	ll_changeNo			= dw_pisr120u_01.GetItemNumber( I, 'changeforecasteditno' )
	ls_Flag				= dw_pisr120u_01.GetItemString( I, 'orderchangeflag' )
	ldt_forecasttime	= dw_pisr120u_01.GetItemDateTime( I, 'partforecasttime' )
	ldt_changetime		= dw_pisr120u_01.GetItemDateTime( I, 'changeforecasttime' )
	
	  SELECT TPARTKBSTATUS.OrderChangeFlag,  
	  			TPARTKBSTATUS.ChangeForecastTime  
		 INTO :ls_oldFlag,
		 		:ldt_oldTime
		 FROM TPARTKBSTATUS  
		WHERE TPARTKBSTATUS.PartKBNo = :ls_partKBNo
		USING	sqlpis	;
	IF sqlpis.SqlCode <> 0 Then 
		ls_message = 'TPARTKBSTATUS_Err'
//		MessageBox( "���ֺ������", ls_partKBNo + "������ ���������� ã�� �� �����ϴ�.",StopSign! )
		Goto RollBack_			
	End IF
	
	If ls_oldFlag = 'N' And ls_Flag = 'N' Then Continue
	If ls_oldFlag = 'N' And ls_Flag = 'Y' Then 
		If isNull(ls_changeDate) Or trim(ls_changeDate) = '' Then 
			ls_message = 'changeDate_Err'
//			MessageBox( "���ֺ������", ls_partKBNo + " ������ �������ڰ� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
			Goto RollBack_			
		End If
		If isNull(ll_changeNo) Or ll_changeNo = 0 Then 
			ls_message = 'changeNo_Err'
//			MessageBox( "���ֺ������", ls_partKBNo + " ������ ����� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
			Goto RollBack_			
		End If
		If isNull(ls_changeCode) Or ls_changeCode = '' Then 
			ls_message = 'changeCode_Err'
//			MessageBox( "���ֺ������", ls_partKBNo + " ������ ��������� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumsubtract(I, ls_summaryDate, ldt_nowTime) 	= -1 Then 
			ls_message = 'sumsubtract_Err'
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_changeTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumadd(I, ls_summaryDate, ldt_nowTime) 			= -1 Then
			ls_message = 'sumadd_Err'
			Goto RollBack_			
		End If
		li_changeCnt = li_changeCnt + 1
	End If
	If ls_oldFlag = 'Y' And ls_Flag = 'N' Then 
		dw_pisr120u_01.SetItem( I, 'changeforecastdate'		, ls_Null )
		dw_pisr120u_01.SetItem( I, 'changeforecasteditno'	, li_Null )
		dw_pisr120u_01.SetItem( I, 'orderchangeflag'			, ls_Null )
		dw_pisr120u_01.SetItem( I, 'lastemp'					, 'Y' )	//Interface Flag Ȱ��
		dw_pisr120u_01.SetItem( I, 'lastdate'					, ldt_nowTime )
		ls_summaryDate = left(String(ldt_oldTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumsubtract(I, ls_summaryDate, ldt_nowTime) 	= -1 Then 
			ls_message = 'sumsubtract_Err'
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumadd(I, ls_summaryDate, ldt_nowTime) 		= -1 Then 
			ls_message = 'sumadd_Err'
			Goto RollBack_
		End If
		li_changeCnt = li_changeCnt + 1
	End If
	If ls_oldFlag = 'Y' And ls_Flag = 'Y' Then 
		If isNull(ls_changeDate) Or trim(ls_changeDate) = '' Then 
			ls_message = 'changeDate_Err'
//			MessageBox( "���ֺ������", ls_partKBNo + " ������ �������ڰ� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
			Goto RollBack_			
		End If
		If isNull(ll_changeNo) Or ll_changeNo = 0 Then 
			ls_message = 'changeNo_Err'
//			MessageBox( "���ֺ������", ls_partKBNo + " ������ ����� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
			Goto RollBack_			
		End If
		If isNull(ls_changeCode) Or ls_changeCode = '' Then 
			ls_message = 'changeCode_Err'
//			MessageBox( "���ֺ������", ls_partKBNo + " ������ ��������� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_oldTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumsubtract(I, ls_summaryDate, ldt_nowTime) 	= -1 Then
			ls_message = 'sumsubtract_Err'
			Goto RollBack_			
		End If
		ls_summaryDate = left(String(ldt_changeTime, "yyyy.mm.dd hh:mm"), 10)
		If wf_sumadd(I, ls_summaryDate, ldt_nowTime) 	 	= -1 Then 
			ls_message = 'sumadd_Err'
			Goto RollBack_			
		End If
		li_changeCnt = li_changeCnt + 1
	End If
Next

//	���ǻ�������
dw_pisr120u_01.SetTransObject(Sqlpis)									//���ǻ���
If dw_pisr120u_01.Update() = -1 Then 
	ls_message = 'Update_Err'
//	MessageBox("���ֺ������", "���ֺ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox("���ֺ���Ϸ�", String(li_changeCnt) +"���� ���Կ����� ����ó�� �Ǿ����ϴ�.", Information! )
Return 0 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

If	ls_message = 'TPARTKBSTATUS_Err' Then
	MessageBox("�����ϼ�������", ls_partKBNo + "������ ���������� ã�� �� �����ϴ�.",StopSign! )
ElseIf ls_message = 'changeDate_Err' Then
	MessageBox("�����ϼ�������", ls_partKBNo + "������ �������ڰ� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
ElseIf ls_message = 'changeNo_Err' Then
	MessageBox("�����ϼ�������", ls_partKBNo + "������ ����� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
ElseIf ls_message = 'changeCode_Err' Then
	MessageBox("�����ϼ�������", ls_partKBNo + "������ ��������� �Էµ��� �ʾҽ��ϴ�.", StopSign! )
ElseIf ls_message = 'sumsubtract_Err' Then
	MessageBox("�����ϼ�������", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'sumadd_Err' Then
	MessageBox("�����ϼ�������", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'Update_Err' Then
	MessageBox("�����ϼ�������", "�������忡 �����Ͽ����ϴ�.", StopSign! )
Else 
	MessageBox("�����ϼ�������", "���Կ����ϼ����� �����Ͽ����ϴ�.", StopSign! )
End If

return -1

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

type uo_status from w_ipis_sheet01`uo_status within w_pisr120u
end type

type uo_area from u_pisc_select_area within w_pisr120u
event destroy ( )
integer x = 64
integer y = 68
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

end event

type uo_division from u_pisc_select_division within w_pisr120u
event destroy ( )
integer x = 626
integer y = 68
integer taborder = 80
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
end event

type dw_pisr120u_01 from u_vi_std_datawindow within w_pisr120u
integer x = 14
integer y = 564
integer width = 3584
integer height = 1452
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr120u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;String	ls_areaCode, ls_divCode, ls_suppCode, ls_orderDate
String 	ls_colName, ls_Data
String	ls_changeDate, ls_changeFlag
DateTime	ldt_forecasttime
String	ls_compDate, ls_partEditTime
String	ls_Null
Integer	li_null

setNull(ls_Null)
setNull(li_Null)

ls_colName 			= This.GetcolumnName()
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
			this.SetItem(row , "orderchangecode", ls_Null )
			Return 1			
		End IF
		f_pisc_get_date_convert(ls_Data, "YYYY.MM.DD", ls_Data) 
		this.SetItem(row , "changeforecastdate", ls_Data )
		If Not isNull(ldt_forecasttime) Then
			ls_partEditTime		= mid(String( ldt_forecasttime, 'yyyy.mm.dd hh:mm' ), 12, 5 )
			If ls_partEditTime >= '00:00' And ls_partEditTime < '08:00' Then
				ls_compDate = f_pisr_getdaybefore( ls_Data, 1 ) 
			Else
				ls_compDate = ls_Data 
			End If
		End If
		ldt_forecasttime	= DateTime(Date(ls_compDate), Time(ls_partEditTime))
		this.SetItem(row , "orderchangecode", '1' )
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
		il_lastRow = row
		If Not isNull(ldt_forecasttime) Then	ls_changeFlag = 'Y'
End Choose 

/////////////////////////////////////////////
//		���� ���氪  ����
/////////////////////////////////////////////
String	ls_nowTime, ls_jobDate, ls_applyDate
DateTime	ldt_nowTime
String	ls_orderChangeFlag
Long		ll_EditNo

This.AcceptText()
ls_changeDate 	= This.GetItemString(row, 'changeforecastdate')
ll_EditNo		= This.GetItemNumber(row, 'changeforecasteditno')

If isNull(ls_changeDate) Or isNull(ll_EditNo) Then 
	ls_orderChangeFlag = 'N'
Else	
	ls_orderChangeFlag = 'Y'
End If
	
ldt_nowTime	= f_pisc_get_date_nowtime()														//���� �ý��۽ð�

If ls_changeFlag = 'Y' Then
	this.SetItem(row , "orderchangeflag", ls_orderChangeFlag )
	this.SetItem(row , "orderchangetime", ldt_nowTime )
	this.SetItem(row , "lastemp"			, 'Y' )	//Interface Flag Ȱ��
	this.SetItem(row , "lastdate"			, ldt_nowTime )
End IF

return 0
end event

event retrievestart;call super::retrievestart;DataWindowChild ldwc

If This.GetChild('orderchangecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet(); 
	If ldwc.Retrieve( istr_partkb.areacode, istr_partkb.divcode) = 0 Then ldwc.InsertRow(1) 
End If 

end event

event editchanged;call super::editchanged;///////////////////////////////
//		���� �������� 
///////////////////////////////

il_lastRow = row
end event

event retrieveend;call super::retrieveend;//String	ls_colList, ls_col, ls_ColX
//
//If This.HSplitScroll Then  
//	ls_colList = This.Tag
//	ls_col = Left(ls_colList, Pos(ls_colList, ',') - 1 )
//	If ls_col <> '' Then 
//		ls_ColX = This.Describe(ls_col + ".X")
//		This.Object.DataWindow.HorizontalScrollSplit = String( Integer( Ls_Colx ) )
//		This.Object.DataWindow.HorizontalScrollPosition = '0'
//	End If 
//	
//	ls_col = Right(ls_colList, Len(ls_colList) - Pos(ls_colList, ',') )
//	If ls_col <> '' Then 
//		ls_ColX = This.Describe(ls_col + ".X")
//		This.Object.DataWindow.HorizontalScrollPosition2 = String( Integer( Ls_Colx ) )
//	End If 
//End If 
end event

event ue_key;call super::ue_key;If key = KeyEnter! or key = KeyDownArrow! Then 
	send(handle(this), 256, 9, long(0,0))
	Return 1
End If 
end event

type dw_summary from datawindow within w_pisr120u
integer x = 768
integer y = 872
integer width = 1001
integer height = 848
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "���Ǽ��� Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_date from u_pisc_date_applydate_1 within w_pisr120u
integer x = 1728
integer y = 68
integer taborder = 30
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
If uo_date.is_uo_date  < is_date Then
	uo_status.st_message.text =  "�̹� �������� �̰ų� ���� ���Ե� �׸��� ������ �� �����ϴ�." 
	MessageBox('Ȯ��','�̹� �������� �̰ų� ���� ���Ե� �׸��� ������ �� �����ϴ�.', StopSign!)
	uo_date.is_uo_date 	= is_date
	uo_date.sle_date.Text= is_date
	uo_date.id_uo_date 	= Date(is_date)
End If
end event

type st_2 from statictext within w_pisr120u
integer x = 1262
integer y = 76
integer width = 457
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���Կ�������:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_condition from datawindow within w_pisr120u
integer x = 69
integer y = 204
integer width = 2807
integer height = 216
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
			istr_partkb.flag = 3			//���־�ü(����,����)
			OpenWithParm ( w_pisr012i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
			This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
			This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
	CASE 'b_item'
			istr_partkb.flag = 1			//��������list (����,����)
			OpenWithParm ( w_pisr013i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'itemcode'			, lstr_Rtn.code)
			This.SetItem(row,'itemname'			, lstr_Rtn.name)
			This.SetItem(row,'itemspec'			, lstr_Rtn.nicname)
	CASE ELSE
			Return
END CHOOSE

dw_pisr120u_01.Reset()

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
			WHERE A.SupplierCode = B.SupplierCode 				AND
					A.AreaCode 		= :istr_partkb.areacode 	AND  
					A.DivisionCode = :istr_partkb.divcode 		AND  
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

dw_pisr120u_01.Reset()


end event

event itemerror;Return 1
end event

type dw_condition2 from datawindow within w_pisr120u
integer x = 41
integer y = 420
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

//			istr_partkb.flag = 3			//���־�ü(����,����)
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
  SELECT TMSTPRODUCTGROUP.ProductGroupName  
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

type gb_3 from groupbox within w_pisr120u
integer x = 18
integer width = 1211
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr120u
integer x = 1243
integer width = 969
integer height = 180
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr120u
integer x = 18
integer y = 172
integer width = 2875
integer height = 376
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

