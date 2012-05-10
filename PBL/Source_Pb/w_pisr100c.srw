$PBExportHeader$w_pisr100c.srw
$PBExportComments$�԰���ó��/����(��ǰ��)
forward
global type w_pisr100c from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr100c
end type
type uo_division from u_pisc_select_division within w_pisr100c
end type
type dw_2 from datawindow within w_pisr100c
end type
type dw_3 from u_vi_std_datawindow within w_pisr100c
end type
type dw_summary from datawindow within w_pisr100c
end type
type rb_1 from radiobutton within w_pisr100c
end type
type rb_2 from radiobutton within w_pisr100c
end type
type gb_3 from groupbox within w_pisr100c
end type
type dw_scan from datawindow within w_pisr100c
end type
type pb_1 from picturebutton within w_pisr100c
end type
type pb_2 from picturebutton within w_pisr100c
end type
type gb_2 from groupbox within w_pisr100c
end type
type gb_scan from groupbox within w_pisr100c
end type
type gb_4 from groupbox within w_pisr100c
end type
end forward

global type w_pisr100c from w_ipis_sheet01
event ue_init ( )
event ue_process ( )
uo_area uo_area
uo_division uo_division
dw_2 dw_2
dw_3 dw_3
dw_summary dw_summary
rb_1 rb_1
rb_2 rb_2
gb_3 gb_3
dw_scan dw_scan
pb_1 pb_1
pb_2 pb_2
gb_2 gb_2
gb_scan gb_scan
gb_4 gb_4
end type
global w_pisr100c w_pisr100c

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowtime, is_jobdate, is_applydate	//����ð�, �۾���������, ������������
DateTime	idt_nowtime										//����ð�
String	is_null

String	is_olddate, is_incomedate		//�԰���� History Key
Long		il_oldseq							//�԰���� History Key
DateTime	idt_incometime
end variables

forward prototypes
public function integer wf_setcancel ()
public function integer wf_cancelvalid ()
end prototypes

event ue_init();pb_2.Enabled = m_frame.m_action.m_save.Enabled

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//��ȸasd

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()


end event

event ue_process();//////////////////////////////////
//	�԰�ó�� �۾� Control
//////////////////////////////////
Long		ll_Row

SetPointer(HourGlass!)

CHOOSE CASE rb_1.Checked
	CASE True
		ll_Row = f_pisr_incomevalidchk(dw_2, is_partkbno, istr_partkb.areacode, istr_partkb.divcode, is_jobdate)
		If ll_Row = -1 Then 
			dw_2.ReSet() 
			dw_2.InsertRow(1) 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.SetFocus()
			Goto EndReturn_
		End If
		If f_pisr_setincomestatus(dw_2) = -1 Then Goto EndReturn_
		If dw_2.Event ue_save() = -1 Then Goto EndReturn_
	CASE ELSE
		If wf_cancelvalid() = -1 Then Goto EndReturn_
		If wf_setcancel() = -1 Then Goto EndReturn_
		If dw_2.Event ue_cancelsave() = -1 Then Goto EndReturn_
END CHOOSE

dw_2.RowsCopy(1,1, Primary!, dw_3, 1, Primary!)

EndReturn_:
SetPointer(HourGlass!)
Return
end event

public function integer wf_setcancel ();////////////////////////////////////
// ���� History ���� ����
////////////////////////////////////

String	ls_applyFrom, ls_partType, ls_OrderChangeFlag, ls_PartOrderCancel
String	ls_PartReceiptCancel, ls_UseCenterGubun, ls_UseCenter, ls_PartOrderDate
String	ls_PartForeCastDate, ls_PartReceiptDate, ls_PartOrderNo, ls_DeliveryNo 
String	ls_BuybackNo, ls_OrderChangeCode, ls_ChangeForecastDate, ls_OrderSeq
Long		ll_RackQty, ll_PartObeyDateFlag, ll_PartObeyTimeFlag, ll_PartForecastEditNo
Long		ll_PartEditNo, ll_ChangeForecastEditNo
DateTime	ldt_PartOrderTime, ldt_PartForecastTime, ldt_PartReceiptTime, ldt_OrderChangeTime
DateTime ldt_ChangeForecastTime
String	ls_IncomeDate
DateTime	ldt_IncomeTime
	
SELECT 	ApplyFrom,
         PartType, 
         RackQty,   
         OrderChangeFlag,   
         PartOrderCancel,   
         PartReceiptCancel,   
         UseCenterGubun,   
         UseCenter,   
         PartObeyDateFlag,   
         PartObeyTimeFlag,   
         PartOrderDate,   
         PartOrderTime,   
         PartForeCastDate,   
         PartForecastEditNo,   
         PartForecastTime,   
         PartReceiptDate,   
         PartEditNo,   
         PartReceiptTime,   
         PartIncomeDate,   
         PartIncomeTime,   
         PartOrderNo,   		//���ֹ�ȣ
         DeliveryNo,   			//��ǰǥ��ȣ
         BuybackNo,   			//��������ȣ
         OrderChangeTime,   
         OrderChangeCode,   
         ChangeForecastDate,   
         ChangeForecastEditNo,   
         ChangeForecastTime,   
         OrderSeq   
	INTO 	:ls_ApplyFrom,
         :ls_PartType, 
         :ll_RackQty,   
         :ls_OrderChangeFlag,   
         :ls_PartOrderCancel,   
         :ls_PartReceiptCancel,   
         :ls_UseCenterGubun,   
         :ls_UseCenter,   
         :ll_PartObeyDateFlag,   
         :ll_PartObeyTimeFlag,   
         :ls_PartOrderDate,   
         :ldt_PartOrderTime,   
         :ls_PartForeCastDate,   
         :ll_PartForecastEditNo,   
         :ldt_PartForecastTime,   
         :ls_PartReceiptDate,   
         :ll_PartEditNo,   
         :ldt_PartReceiptTime,   
         :ls_IncomeDate,   
         :ldt_IncomeTime,   
         :ls_PartOrderNo,   			//���ֹ�ȣ
         :ls_DeliveryNo,   			//��ǰǥ��ȣ
         :ls_BuybackNo,   				//��������ȣ
         :ldt_OrderChangeTime,   
         :ls_OrderChangeCode,   
         :ls_ChangeForecastDate,   
         :ll_ChangeForecastEditNo,   
         :ldt_ChangeForecastTime,   
         :ls_OrderSeq   
   FROM	TPARTKBHIS 	 
  WHERE	PartKBNo 	 = :is_partkbno	And
  			ApplyDate 	 = :is_olddate		And
  			PartOrderSeq = :il_oldseq	
  USING  sqlpis	;
If sqlpis.SqlCode <> 0 Then 
	MessageBox( "�԰��������", "������ �������� �б⿡ �����߽��ϴ�.", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End IF

If (Not isNull(ls_BuybackNo)) And Trim(ls_BuybackNo) <> '' Then 
	MessageBox( "�Է¿���", "�������� �ۼ��� ������ �԰������ �� �����ϴ�.", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End IF

dw_2.SetItem(1, 'applyfrom'				, ls_ApplyFrom)
dw_2.SetItem(1, 'parttype'					, ls_PartType)
dw_2.SetItem(1, 'rackqty'					, ll_RackQty)
dw_2.SetItem(1, 'orderchangeflag'		, ls_OrderChangeFlag)
dw_2.SetItem(1, 'partordercancel'		, ls_PartOrderCancel)
dw_2.SetItem(1, 'partreceiptcancel'		, ls_PartReceiptCancel)
dw_2.SetItem(1, 'usecentergubun'			, ls_UseCenterGubun)
dw_2.SetItem(1, 'usecenter'				, ls_UseCenter)
dw_2.SetItem(1, 'partobeydateflag'		, ll_PartObeyDateFlag)
dw_2.SetItem(1, 'partobeytimeflag'		, ll_PartObeyTimeFlag)
dw_2.SetItem(1, 'partorderdate'			, ls_PartOrderDate)
dw_2.SetItem(1, 'partordertime'			, ldt_PartOrderTime)
dw_2.SetItem(1, 'partforecastdate'		, ls_PartForeCastDate)
dw_2.SetItem(1, 'partforecasteditno'	, ll_PartForecastEditNo)
dw_2.SetItem(1, 'partforecasttime'		, ldt_PartForecastTime)
dw_2.SetItem(1, 'partreceiptdate'		, ls_PartReceiptDate)
dw_2.SetItem(1, 'parteditno'				, ll_PartEditNo)
dw_2.SetItem(1, 'partreceipttime'		, ldt_PartReceiptTime)		
dw_2.SetItem(1, 'partincomedate'			, ls_IncomeDate)		//�԰����� Summary ������ ����
dw_2.SetItem(1, 'partincometime'			, ldt_IncomeTime)		//�԰����� Summary ������ ����
dw_2.SetItem(1, 'partorderno'				, ls_PartOrderNo)
dw_2.SetItem(1, 'deliveryno'				, ls_DeliveryNo)
dw_2.SetItem(1, 'orderchangetime'		, ldt_OrderChangeTime)
dw_2.SetItem(1, 'orderchangecode'		, ls_OrderChangeCode)
dw_2.SetItem(1, 'changeforecastdate'	, ls_ChangeForecastDate)
dw_2.SetItem(1, 'changeforecasteditno'	, ll_ChangeForecastEditNo)
dw_2.SetItem(1, 'changeforecasttime'	, ldt_ChangeForecastTime)
dw_2.SetItem(1, 'orderseq'					, ls_OrderSeq)

dw_2.SetItem(1, 'partkbstatus'			, 'B')			//���ǻ��� ���԰� ����
dw_2.SetItem(1, 'kborderpossible'		, 'N')			//���ֺҰ��� ó��
dw_2.SetItem(1, 'buybackno'				, is_null)
dw_2.SetItem(1, 'lastemp'					, 'Y'	)			//Interface Flag Ȱ��
dw_2.SetItem(1, 'lastdate'					, is_nowtime)

Return 0
end function

public function integer wf_cancelvalid ();
String	ls_areaCode, ls_divCode, ls_suppCode
String	ls_KBStatus, ls_OrderPossible, ls_useFlag, ls_ReprintFlag, ls_kbactivegubun
String	ls_DeliveryNo, ls_PartOrderNo, ls_oldincomedt
Long		ll_Row

dw_2.SetTransObject (sqlpis)
ll_Row = dw_2.Retrieve(is_partkbno, is_jobdate)
If ll_Row = 0 Then 
	MessageBox( "�Է¿���", "�������� �ʴ� �����Դϴ�. ", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

ls_areaCode			= dw_2.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_2.GetItemString( ll_Row, 'divisioncode' )
ls_suppCode			= dw_2.GetItemString( ll_Row, 'suppliercode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "�Է¿���", "�ش� ������ ������ �ƴմϴ�.", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

ls_useFlag			= dw_2.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "�Է¿���", "����ߴܵ� �����Դϴ�. ", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

ls_kbactivegubun	= dw_2.GetItemString( ll_Row, 'kbactivegubun' )
If ls_kbactivegubun = 'S' Then 
	MessageBox( "�Է¿���", "Sleeping ������ �����Դϴ�. ", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End If

ls_KBStatus			= dw_2.GetItemString( ll_Row, 'partkbstatus' )
CHOOSE CASE ls_KBStatus
	CASE 'A'
		MessageBox( "�Է¿���", "���� ���ֻ����� �����Դϴ�. ", StopSign! )
		dw_2.ReSet() 
		dw_2.InsertRow(1) 
		Return -1
	CASE 'B'
		MessageBox( "�Է¿���", "���� ���԰������ �����Դϴ�. ", StopSign! )
		dw_2.ReSet() 
		dw_2.InsertRow(1) 
		Return -1
//	CASE 'C', 'D'
//		MessageBox( "�Է¿���", "���� ���ֵ��� ���� �����Դϴ�. ", StopSign! )
//		dw_2.ReSet() 
//		dw_2.InsertRow(1) 
//		Return -1
END CHOOSE

ls_PartOrderNo		= dw_2.GetItemString( ll_Row, 'partorderno' )
If ( Not isNull( ls_PartOrderNo )) And trim(ls_PartOrderNo) <> '' Then 
	MessageBox( "Ȯ��", "��ü�� ����Ǿ��ų� �����Ϸ��� �����Դϴ�. ", Information! )
End If

////////////////////////////////////
// ���� History ���� ����
////////////////////////////////////

  SELECT A.ApplyDate, A.PartIncomeDate, Max(A.PartOrderSeq)
	 INTO	:is_olddate, :ls_oldincomedt, :il_oldseq		
 	 FROM	TPARTKBHIS 	A 
 	WHERE	A.PartKBNo 		= :is_partkbno And 
	 		A.PartKBStatus = 'C' And
  			A.ApplyDate 	= ( Select Max(ApplyDate) From TPARTKBHIS
			  						  Where PartKBNo = :is_partkbno )
GROUP BY A.ApplyDate, A.PartIncomeDate
	USING	sqlpis	;

If sqlpis.SqlCode <> 0 Then 
	MessageBox( "�Է¿���", "�԰�ó�� ����� �������� �ʴ� �����Դϴ�.", StopSign! )
	dw_2.ReSet() 
	dw_2.InsertRow(1) 
	Return -1
End IF

String	ls_incomeTime, ls_jsCode

  SELECT TMSTSUPPLIER.JSCode  
    INTO :ls_jsCode  
    FROM TMSTSUPPLIER  
   WHERE TMSTSUPPLIER.SupplierCode = :ls_suppCode
   USING	sqlpis	;
	
ls_incomeTime = String(f_pisr_get_incometime(sqlpis, ls_areaCode, ls_suppCode, idt_nowtime), 'yyyy.mm.dd hh:mm')
//������ - ��������
//If left(is_olddate, 7) <> left(ls_incomeTime, 7) Then Goto OverTime_
//15�ϸ���
//If ls_jsCode = 'H' Then
//	If Integer(mid(is_olddate,9,2)) < 16 And Integer(mid(ls_incomeTime,9,2)) > 15 Then 
//		Goto OverTime_
//	End If
//End If

// �԰����� �񱳷� ���� - 2004.03.15
//������
If left(ls_oldincomedt, 7) <> left(ls_incomeTime, 7) Then Goto OverTime_
//15�ϸ���
If ls_jsCode = 'H' Then
	If Integer(mid(ls_oldincomedt,9,2)) < 16 And Integer(mid(ls_incomeTime,9,2)) > 15 Then 
		Goto OverTime_
	End If
End If

return ll_Row

OverTime_:
MessageBox( "�Է¿���", "���긶���� ����� ������ �԰����ó���� �������� �ʽ��ϴ�.", StopSign! )
dw_2.ReSet() 
dw_2.InsertRow(1) 
Return -1

end function

on w_pisr100c.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_summary=create dw_summary
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_3=create gb_3
this.dw_scan=create dw_scan
this.pb_1=create pb_1
this.pb_2=create pb_2
this.gb_2=create gb_2
this.gb_scan=create gb_scan
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_summary
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.dw_scan
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_scan
this.Control[iCurrent+14]=this.gb_4
end on

on w_pisr100c.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_summary)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_3)
destroy(this.dw_scan)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.gb_2)
destroy(this.gb_scan)
destroy(this.gb_4)
end on

event open;call super::open;
SetNull(is_null)

dw_summary.Visible 	= False
rb_1.Checked			= True	
rb_1.Weight 			= 700

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)

dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

this.PostEvent ( "ue_init" )


end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

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

type uo_status from w_ipis_sheet01`uo_status within w_pisr100c
end type

type uo_area from u_pisc_select_area within w_pisr100c
event destroy ( )
integer x = 82
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

dw_2.Reset()
dw_2.SetTransObject (sqlpis)
dw_2.InsertRow(1) 

dw_3.Reset()

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr100c
event destroy ( )
integer x = 631
integer y = 68
integer taborder = 80
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

dw_3.Reset()

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_2 from datawindow within w_pisr100c
event type integer ue_save ( )
event type integer ue_cancelsave ( )
integer x = 23
integer y = 380
integer width = 3461
integer height = 780
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr100b_01"
boolean border = false
boolean livescroll = true
end type

event type integer ue_save();//////////////////////////////////////////////
//		�԰����۾� ����
//////////////////////////////////////////////
String	ls_suppCode, ls_itemCode, ls_applyFrom
Long		ll_Row, ll_Qty, ll_qtySum, ll_editNo
Integer	ri_errcode
String	ls_orderdate, ls_IncomeDate
DateTime	ldt_ordertime, ldt_IncomeTime
String	ls_message = ''

this.AcceptText()

ll_Row			= this.GetRow()
ls_suppCode		= Upper(this.GetItemString(ll_Row	, 'suppliercode'))
ls_itemCode		= Upper(this.GetItemString(ll_Row	, 'itemcode'))
ls_applyFrom	= this.GetItemString(ll_Row	, 'applyfrom')
ll_Qty			= this.GetItemNumber(ll_Row	, 'rackqty')
ldt_ordertime	= this.GetItemDateTime(ll_Row	, 'partordertime')
ls_orderdate	= left(String(ldt_ordertime, "yyyy.mm.dd hh:mm"),10)
ls_IncomeDate	= this.GetItemString(ll_Row	, 'partincomedate')
ldt_IncomeTime	= this.GetItemDateTime(ll_Row	, 'partincometime')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	�԰���� Summary����
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_IncomeDate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.ReSet();	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, ls_IncomeDate )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag Ȱ��
	dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partincomeqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partincomeqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)							//�԰���� Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("�԰����", "�԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//�������� ���� ����
this.SetTransObject(Sqlpis)									//���ǻ���
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("�԰����", "�԰��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

// �������� History����
Declare proc_partkbhis Procedure For sp_pisr100b_his &
		 :is_partkbno, :ls_orderdate, :g_s_empno, @ri_errcode = 0 Output  
USING sqlpis ;

Execute proc_partkbhis ;
If f_pisr_Errorhandler(Sqlpis, "Execute proc_crKbNo", "Faild") = 0 Then 
	Fetch proc_partkbhis Into :ri_errcode ;
	If f_pisr_ErrorHandler(Sqlpis, "Fetch proc_crKbNo", "Failed") <> 0 Then
		Close proc_partkbhis ;
		ls_message = 'partkbhis_Err'
//		Messagebox( "�԰�ó������", "�ش� ������ History������ �����߽��ϴ�.", StopSign!)
		Goto RollBack_			
	End If
Else
	Close proc_partkbhis ;
	ls_message = 'partkbhis_Err'
	Goto RollBack_			
End If
Close proc_partkbhis ;

//////////////////////////////////////////
//		HOST ����Ÿ���� �ڷ����
//////////////////////////////////////////
String	ls_oldorderSeq, ls_oldreceiptDate, ls_usecenter, ls_costGubun, ls_usecentergubun, ls_deliveryno
DateTime ldt_oldReceiptTime
Long		ll_SeqNo

ls_oldorderSeq 	= this.GetItemString(ll_Row, 'orderseq')
ldt_oldReceiptTime= this.GetItemDateTime(ll_Row, 'partreceipttime')
ls_oldreceiptDate	= left(string(ldt_oldReceiptTime, "yyyy.mm.dd hh:mm"), 10)
ls_usecenter		= this.GetItemString(ll_Row, 'usecenter')
ls_deliveryno		= this.GetItemString(ll_Row, 'deliveryno')

  SELECT UseCenterGubun, CostGubun  
    INTO :ls_usecentergubun, :ls_costGubun  
    FROM TMSTPARTKBHIS  
   WHERE AreaCode 		= :istr_partkb.areacode AND  
         DivisionCode 	= :istr_partkb.divcode 	AND  
         SupplierCode 	= :ls_suppCode 			AND  
         ItemCode 		= :ls_itemCode 			AND  
         ApplyFrom 		<=:ls_orderDate 		AND  
         ApplyTo 			>=:ls_orderDate    
   USING sqlpis        ;
If ls_usecentergubun = 'I' Then SetNull(ls_costGubun)

// �԰�ó�� ȸ��
  SELECT Max( SeqNo )
    INTO :ll_SeqNo  
    FROM TPARTKBINCOME_INTERFACE  
   WHERE OrderSeq = :ls_oldorderSeq AND  
         MISFlag 	= 'A' 
   USING sqlpis        ;
	
If isNull(ll_SeqNo) Then ll_SeqNo = 0
ll_SeqNo = ll_SeqNo + 1

  INSERT INTO TPARTKBINCOME_INTERFACE  
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
           PartIncomeDate,   
           PartReceiptDate,   
           CostGubun,   
           UseCenter,   
           LastEmp,   
           LastDate,
			  DeliveryNo )  
  VALUES ( :ls_oldorderSeq,   
           :ll_SeqNo,   
           'A',   
           'Y',   
           :istr_partkb.areacode,   
           :istr_partkb.divcode,   
           :ls_suppCode,   
           :ls_itemCode,   
           :is_partkbno,   
           :ls_orderdate,   
           :ll_Qty,   
           :ls_IncomeDate,   
           :ls_oldreceiptDate,   
           :ls_costGubun,   
           :ls_usecenter,   
           :g_s_empno,   
           :idt_nowtime,
			  :ls_deliveryno )  
	USING	sqlpis	;
			  
If sqlpis.SqlCode <> 0 Then 
	ls_message = 'INCOMEINTERFACE_Err'
//	MessageBox("�԰����", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
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

If ls_message = 'summaryUpdate_Err' Then
	MessageBox("�԰����", "�԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("�԰����", "�԰��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'partkbhis_Err' Then
	Messagebox("�԰����", "�ش� ������ History������ �����߽��ϴ�.", StopSign!)
ElseIf ls_message = 'INCOMEINTERFACE_Err' Then
	MessageBox("�԰����", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
Else
	MessageBox("�԰����", "�԰�ó���۾��� �����Ͽ����ϴ�.", StopSign! )
End If

return -1
end event

event type integer ue_cancelsave();////////////////////////////////////////////
//		�԰���� ����
////////////////////////////////////////////
String	ls_suppCode, ls_itemCode, ls_applyFrom, ls_IncomeDate
Long		ll_Row, ll_Qty, ll_qtySum, ll_editNo
Integer	ri_errcode
DateTime	ldt_IncomeTime
DateTime	ldt_null
String	ls_message = ''

SetNull(ldt_null)

this.AcceptText()

ll_Row			= this.GetRow()
ls_suppCode		= Upper(this.GetItemString(ll_Row	, 'suppliercode'))
ls_itemCode		= Upper(this.GetItemString(ll_Row	, 'itemcode'))
ls_applyFrom	= this.GetItemString(ll_Row	, 'applyfrom')
ll_Qty			= this.GetItemNumber(ll_Row	, 'rackqty')
ls_IncomeDate	= this.GetItemString(ll_Row	, 'partincomedate')
ldt_IncomeTime	= this.GetItemDateTime(ll_Row	, 'partincometime')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	�԰���� Summary����(����)
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_IncomeDate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err'
//	MessageBox("�԰���ҿ���", "�԰� Summary������ ���� ���߽��ϴ�.", StopSign! )
	Goto RollBack_			
End If
//ls_compMonth2 = left( ls_orderdate, 7 )		//���ֱ��ؿ�
//If ls_compMonth > ls_compMonth2 Then
//	dw_summary.SetTransObject(Sqlpis)				
//	If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.ReSet();	dw_summary.InsertRow(0)
//		dw_summary.SetItem( 1, 'applydate'		, is_applydate )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		// Interface Flag Ȱ��
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partorderqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partorderqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		// Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//���� Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("�԰���ҿ���", "�԰� Summary �������� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//�������� ���� ����
this.SetItem(ll_Row	, 'partincomedate', is_null)		//�԰����� ����
this.SetItem(ll_Row	, 'partincometime', ldt_null)		//�԰����� ����
this.SetItem(ll_Row	, 'lastemp'			, 'Y')			//Interface Flag Ȱ��
this.SetItem(ll_Row	, 'lastdate'		, idt_nowtime)	//�԰����� ����

this.SetTransObject(Sqlpis)									//���ǻ��� Update
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("�԰���ҿ���", "�԰������ ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

// Interface�� ���� Deleteó���� ������ ��ſ� ���ǻ��¸� Delete���� 'D'�� ��ȯ
  UPDATE TPARTKBHIS  
     SET PartKBStatus 	= 'D',
	  		LastEmp 			= 'Y',
	  		LastDate			= :idt_nowtime
   WHERE TPARTKBHIS.PartKBNo 		= :is_partkbno AND  
         TPARTKBHIS.ApplyDate 	= :is_olddate  AND  
         TPARTKBHIS.PartOrderSeq = :il_oldseq    
   USING	sqlpis        ;
//  DELETE FROM TPARTKBHIS  
//   WHERE TPARTKBHIS.PartKBNo 		= :is_partkbno AND  
//         TPARTKBHIS.ApplyDate 	= :is_olddate  AND  
//         TPARTKBHIS.PartOrderSeq = :il_oldseq    
//   USING	sqlpis        ;
If sqlpis.SqlCode <> 0 Then
	ls_message = 'TPARTKBHIS_Err'
//	MessageBox("�԰���ҿ���", "���� History������ �����Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//////////////////////////////////////////////////////
//		HOST ����Ÿ���� �ڷ����
//////////////////////////////////////////////////////
String	ls_orderSeq, ls_orderdate, ls_receiptDate, ls_usecenter, ls_costGubun, ls_usecentergubun, ls_deliveryno
DateTime ldt_ReceiptTime, ls_orderTime
Long		ll_SeqNo

ls_orderSeq 		= this.GetItemString(ll_Row	, 'orderseq')
ls_orderTime		= this.GetItemDateTime(ll_Row	, 'partordertime')
ls_orderdate		= left(string(ls_orderTime		, "yyyy.mm.dd hh:mm"), 10)
ldt_ReceiptTime	= this.GetItemDateTime(ll_Row	, 'partreceipttime')
ls_receiptDate		= left(string(ldt_ReceiptTime	, "yyyy.mm.dd hh:mm"), 10)
ls_usecenter		= this.GetItemString(ll_Row	, 'usecenter')
ls_deliveryno		= this.GetItemString(ll_Row	, 'deliveryno')

// �����󱸺�
  SELECT UseCenterGubun, CostGubun  
    INTO :ls_usecentergubun, :ls_costGubun  
    FROM TMSTPARTKBHIS  
   WHERE AreaCode 		= :istr_partkb.areacode AND  
         DivisionCode 	= :istr_partkb.divcode 	AND  
         SupplierCode 	= :ls_suppCode 			AND  
         ItemCode 		= :ls_itemCode 			AND  
         ApplyFrom 		<=:ls_IncomeDate 			AND  
         ApplyTo 			>=:ls_IncomeDate    
   USING sqlpis        ;

If ls_usecentergubun = 'I' Then SetNull(ls_costGubun)

// �԰�ó�� ȸ��
  SELECT Max( SeqNo )
    INTO :ll_SeqNo  
    FROM TPARTKBINCOME_INTERFACE  
   WHERE OrderSeq = :ls_orderSeq AND  
         MISFlag 	= 'D' 
   USING sqlpis        ;
	
If isNull(ll_SeqNo) Then ll_SeqNo = 0
ll_SeqNo = ll_SeqNo + 1

  INSERT INTO TPARTKBINCOME_INTERFACE  
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
           PartIncomeDate,   
           PartReceiptDate,   
           CostGubun,   
           UseCenter,   
           LastEmp,   
           LastDate,
			  DeliveryNo )  
  VALUES ( :ls_orderSeq,   
           :ll_SeqNo,   
           'D',   
           'Y',   
           :istr_partkb.areacode,   
           :istr_partkb.divcode,   
           :ls_suppCode,   
           :ls_itemCode,   
           :is_partkbno,   
           :ls_orderdate,   
           :ll_Qty,   
           :ls_IncomeDate,   
           :ls_receiptDate,   
           :ls_costGubun,   
           :ls_usecenter,   
           :g_s_empno,   
           :idt_nowtime,
			  :ls_deliveryno )  
	USING	sqlpis	;
			  
If sqlpis.SqlCode <> 0 Then 
	ls_message = 'INCOMEINTERFACE_Err'
//	MessageBox("�԰��������", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
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

If	ls_message = 'summaryRetrieve_Err' Then
	MessageBox("�԰���ҽ���", "�԰� Summary������ ���� ���߽��ϴ�.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err' Then
	MessageBox("�԰���ҽ���", "�԰� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("�԰���ҽ���", "�԰������ ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'TPARTKBHIS_Err' Then
	MessageBox("�԰���ҽ���", "���� History������ �����Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'INCOMEINTERFACE_Err' Then
	MessageBox("�԰���ҽ���", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
Else 
	MessageBox("�԰���ҽ���", "�԰�����۾��� �����Ͽ����ϴ�.", StopSign! )
End If

return -1
end event

event clicked;
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_3 from u_vi_std_datawindow within w_pisr100c
integer x = 18
integer y = 1168
integer width = 3584
integer height = 728
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr100b_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
return 1
end event

type dw_summary from datawindow within w_pisr100c
integer x = 750
integer y = 1024
integer width = 832
integer height = 848
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "���Ǽ��� Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_pisr100c
integer x = 1349
integer y = 68
integer width = 512
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�԰���"
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

dw_2.Reset()
dw_2.SetTransObject(sqlpis)
dw_2.InsertRow(1)

dw_3.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type rb_2 from radiobutton within w_pisr100c
integer x = 1911
integer y = 68
integer width = 430
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�԰����"
end type

event clicked;
rb_1.Weight = 400
rb_2.Weight = 700

dw_2.Reset()
dw_2.SetTransObject(sqlpis)
dw_2.InsertRow(1)

dw_3.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type gb_3 from groupbox within w_pisr100c
integer x = 18
integer width = 1202
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

type dw_scan from datawindow within w_pisr100c
integer x = 32
integer y = 212
integer width = 1330
integer height = 148
integer taborder = 40
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;This.SelectText(1,15)
end event

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "Ȯ��", "�۾�ó�� ������ �ο����� �ʾҽ��ϴ�.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 11 Then 
	MessageBox( "�Է¿���", "�ùٸ� ���ǹ�ȣ �� �ƴմϴ�.", StopSign! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//���� �ý��۽ð�
is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//�������� -8�ð������
is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//�������� -8�ð�,������ �����

is_partkbno = data
parent.TriggerEvent( "ue_process" )

this.Event getfocus()
end event

type pb_1 from picturebutton within w_pisr100c
integer x = 2555
integer y = 64
integer width = 489
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string text = "�԰�ó��"
boolean originalsize = true
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//�԰�ó��	
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110  
   WHERE WIN_ID = 'w_pisr100c' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("Ȯ��","�غ� �ʵ� [ȭ��]�Դϴ�.")
	end if
end if

this.setredraw(true)

end event

type pb_2 from picturebutton within w_pisr100c
integer x = 3063
integer y = 64
integer width = 489
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�԰��ù���"
boolean originalsize = true
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//�԰�ó��
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110  
   WHERE WIN_ID = 'w_pisr090c' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("Ȯ��","�غ� �ʵ� [ȭ��]�Դϴ�.")
	end if
end if

this.setredraw(true)

end event

type gb_2 from groupbox within w_pisr100c
integer x = 1243
integer width = 1253
integer height = 180
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_scan from groupbox within w_pisr100c
integer x = 18
integer y = 160
integer width = 1358
integer height = 216
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisr100c
integer x = 2519
integer width = 1070
integer height = 180
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "ȭ����ȯ"
end type

