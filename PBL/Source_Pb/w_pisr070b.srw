$PBExportHeader$w_pisr070b.srw
$PBExportComments$��ǰǥ���� ���԰�/���԰����
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
String	is_nowTime, is_jobDate, is_applyDate	//����ð�, �۾���������, ������������
DateTime	idt_nowTime										//����ð�
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
CASE True		//���԰���
		dw_pisr070b_01.SetRedraw ( False )
		dw_pisr070b_01.SetTransObject( sqlpis )
		ll_Row = dw_pisr070b_01.Retrieve( is_deliveryno, 'A', ls_nowDate )		//'A'���ֻ���
		dw_pisr070b_01.SetRedraw ( True )
		If ll_Row < 1 Then 
			MessageBox( "��ǰǥ ����", "��ǰ�� ���簡 �������� �ʴ� ��ȣ �Դϴ�.", StopSign! )
			GoTo EndReturn_
		End If

		If wf_receiptcalc( ll_Row ) = -1 Then GoTo EndReturn_
		If dw_pisr070b_01.Event ue_save() = -1 Then 
			st_totkbcnt.Text = '0 ��'
			GoTo EndReturn_
		Else
			uo_status.st_message.text =  String(ll_Row, '#,##0') + ' ���� ������ ���԰�ó�� �Ǿ����ϴ�.'
			st_totkbcnt.Text = String(ll_Row, '#,##0') + ' ��'
		End If

CASE ELSE		//���԰����
		dw_pisr070b_01.SetRedraw ( False )
		dw_pisr070b_01.SetTransObject( sqlpis )
		ll_Row = dw_pisr070b_01.Retrieve( is_deliveryno, 'B', ls_nowDate )		//'B'���԰����

		dw_pisr070b_01.SetRedraw ( True )
		If dw_pisr070b_01.Event ue_cancelsave() = -1 Then 
			st_totkbcnt.Text = '0 ��'
			GoTo EndReturn_
		Else
			uo_status.st_message.text =  String(ll_Row, '#,##0') + ' ���� ������ ���԰���� �Ǿ����ϴ�.'
			st_totkbcnt.Text = String(ll_Row, '#,##0') + ' ��'
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
istr_partkb.flag		= 1		//��ȸ

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  '���԰� ó��������Դϴ�.'
st_totkbcnt.Text = '0 ��'

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

public function integer wf_lastedit (str_pisr_partkb astr_partkb, long al_editno);////////////////////////////////////
// 	������ ��� ����
////////////////////////////////////

dw_lastedit.ReSet()
dw_lastedit.SetTransObject(Sqlpis)				
If dw_lastedit.Retrieve(astr_partkb.areacode, astr_partkb.divcode, astr_partkb.suppCode, astr_partkb.itemCode, 'B') = 0 then	//���԰�
	dw_lastedit.InsertRow(1)
	dw_lastedit.SetItem(1, 'areacode'		, astr_partkb.areacode )
	dw_lastedit.SetItem(1, 'divisioncode'	, astr_partkb.divcode )
	dw_lastedit.SetItem(1, 'suppliercode'	, astr_partkb.suppCode )
	dw_lastedit.SetItem(1, 'itemcode'		, astr_partkb.itemCode )
	dw_lastedit.SetItem(1, 'ordergubun'		, 'B' )				//A:����, B:����(���԰�)
	dw_lastedit.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag Ȱ��
	dw_lastedit.SetItem(1, 'lastdate'		, idt_nowTime )
End If
dw_lastedit.SetItem(1, 'partlasteditdate'	, astr_partkb.applydate )
dw_lastedit.SetItem(1, 'parteditno'			, al_editno )
dw_lastedit.SetItem(1, 'lastemp'				, 'Y' )		//Interface Flag Ȱ��
dw_lastedit.SetItem(1, 'lastdate'			, idt_nowTime )

dw_lastedit.SetTransObject(Sqlpis)									//(����)������ ���
If dw_lastedit.Update() = -1 Then 		
//	MessageBox("���԰����", "������ ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Return -1
End If

Return 0
end function

public function integer wf_sumadd (str_pisr_partkb astr_partkb, long al_qty);////////////////////////////////////////
//		���԰� ���� Summary����(����)
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
	dw_summary.SetItem(1, 'lastemp'		, 'Y' )		//Interface FlagȰ��
	dw_summary.SetItem(1, 'lastdate'		, idt_nowTime )
End If

ll_qtySum = dw_summary.GetItemNumber(1	, 'partreceiptqty' )
ll_qtySum = ll_qtySum + al_qty									//���԰��������
dw_summary.SetItem(1, 'partreceiptqty'	, ll_qtySum )
dw_summary.SetItem(1, 'lastemp'			, 'Y' )		//Interface FlagȰ��
dw_summary.SetItem(1, 'lastdate'			, idt_nowTime )

dw_summary.SetTransObject(Sqlpis)								//���� Summary
If dw_summary.Update() = -1 Then 
//	MessageBox("���԰����", "���԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
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
	MessageBox("��ǰǥ����", "�������� �ʴ� ��ȣ �Դϴ�.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox("��ǰǥ����", "�ش� ���忡 ��ǰ�� ��ǰǥ��ȣ�� �ƴմϴ�.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If ls_PrintFlag = 'N' Then 
	MessageBox("��ǰǥ����", "���� ������� �ʴ� ��ȣ �Դϴ�.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If rb_1.Checked Then				//���԰���
	If ls_Confirm = 'Y' Then 
		MessageBox("��ǰǥ����", "�̹� ��ǰó���� ��ǰǥ��ȣ�Դϴ�.", StopSign!) 
		dw_scan.SetItem(1, 'scancode', is_null )
		dw_scan.Object.scancode.SetFocus()
		Return -1
	End If
Else									//���԰� ����� ���
	If ls_Confirm = 'N' Then 
		MessageBox("���԰���ҺҴ�", "���� ���Ե��� ���� ��ǰǥ��ȣ�Դϴ�.", StopSign!) 
		dw_scan.SetItem(1, 'scancode', is_null )
		dw_scan.Object.scancode.SetFocus()
		Return -1
	End If
End If

If ls_Cancel = 'Y' Then 
	MessageBox("��ǰǥ����", "��ǰ ��� �� ��ȣ�Դϴ�.", StopSign!) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
	Return -1
End If

If rb_2.Checked Then					//���԰� ����� ���

	  SELECT Count(partKBNo)
		 INTO :ll_Cnt
		 FROM TPARTKBHIS	   
		WHERE AreaCode 			= :ls_areaCode 	And
				DivisionCode		= :ls_divCode 		And
				SupplierCode		= :ls_suppCode 	And
				DeliveryNo 			= :is_deliveryno 	
		USING	sqlpis	;
		
	If ll_Cnt > 0 Then 
		MessageBox("���԰���ҺҴ�", "�̹� �԰�ó���� ������ �����մϴ�.", StopSign!)
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
//				PartKBStatus 		= 'A' 	//'A'���ֻ���( �ҷ�ǰȮ���� ���Ǵ��� ���԰���� )
//		USING	sqlpis	;
//		
//	If ll_Cnt > 0 Then 
//		MessageBox("���԰���ҺҴ�", "�̹� ǰ���˻� �� ���԰���� ó���� ������ �����մϴ�.", StopSign!)
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
		MessageBox("���԰���ҺҴ�", "�̹� ǰ���˻簡 ����� �׸��� �����մϴ�.", StopSign!)
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

ll_worstGap	= 25		//�Ϸ� 24�ð� + 1 

dw_pisr070b_01.AcceptText()

ls_suppCode = dw_pisr070b_01.GetItemString( 1, 'suppliercode' )	//��ǰ��ü �ڵ�

/////////////////////////////////////////////
// �ߴܾ�ü�� ��쿡 ���԰� �Ұ� - 2004.09.17
/////////////////////////////////////////////
SELECT ISNULL(TMSTSUPPLIER.Xstop,'')  
	INTO :ls_chkstop  
	FROM TMSTSUPPLIER  
	WHERE TMSTSUPPLIER.SupplierCode = :ls_suppCode   
	using sqlpis;

if ls_chkstop = 'X' then
	MessageBox( "���԰����" ,"�ŷ��ߴܵ� ���־�ü�Դϴ�.", StopSign! )
	Return -1
end if
/////////////////////////////////////////////
//	���� ��� ���
/////////////////////////////////////////////
dw_partedit.SetTransObject( sqlpis )
ll_Row = dw_partedit.Retrieve(istr_partkb.areacode, istr_partkb.divcode, is_jobdate, ls_suppCode)
If ll_Row < 1 Then 
	MessageBox( "���԰����" ,"���־�ü ������� ������ �����ϴ�.", StopSign! )
	Return -1
End If

For I = 1 To ll_Row Step 1
	ls_editTime 	 = dw_partedit.GetItemString( I, 'partedittime' )						//��ü ���Կ����ð�
	If ls_editTime >= '00:00' AND ls_editTime < '08:00' Then
		ldt_editTime = DateTime(Date(f_pisr_getdaybefore( is_jobdate, 1 )),Time(ls_editTime))
	Else 
		ldt_editTime = DateTime(Date(is_jobdate), Time(ls_editTime))
	End If
	ll_Gap	= Abs(f_pisr_datediff('Hour', ldt_editTime, idt_nowTime, sqlpis))
	If ll_worstGap > ll_Gap Then
		ll_editNo	= dw_partedit.GetItemNumber( I, 'parteditno' )						//��ü �������
		ll_worstGap	= ll_Gap
	End If
Next

////////////////////////////////////////////////////////////////
// �� ���� �����ؼ� ���ΰ�� �� �������� �� �ð���� �������
////////////////////////////////////////////////////////////////
For I = 1 To al_rowcount Step 1
	ls_PartKBNo			= dw_pisr070b_01.GetItemString( I, 'partkbno' )
	ls_ChangeFlag 		= dw_pisr070b_01.GetItemString( I, 'orderchangeflag' )
	CHOOSE CASE Upper(ls_ChangeFlag)
	CASE 'Y'		//���Կ����Ϻ���
			ls_ForecastDate	= dw_pisr070b_01.GetItemString( I	, 'changeforecastdate' )
			ll_ForecastEditNo	= dw_pisr070b_01.GetItemNumber( I	, 'changeforecasteditno' )
			ldt_ForecastTime	= dw_pisr070b_01.GetItemDateTime( I	, 'changeforecasttime' )
	CASE 'N'		//�̺���
			ls_ForecastDate	= dw_pisr070b_01.GetItemString( I	, 'partforecastdate' )
			ll_ForecastEditNo	= dw_pisr070b_01.GetItemNumber( I	, 'partforecasteditno' )
			ldt_ForecastTime	= dw_pisr070b_01.GetItemDateTime( I	, 'partforecasttime' )
	CASE ELSE	//����Flag����
			MessageBox("���԰� ����", ls_PartKBNo + " ���ǿ��� ���ֺ���Flag�� �߸��� ������ �ԷµǾ����ϴ�.", StopSign!)
			Return -1
	END CHOOSE
	If is_jobdate = ls_ForecastDate Then 									//���� �ؼ�
		dw_pisr070b_01.SetItem( I, 'partobeydateflag', 1 )				
		If Abs(f_pisr_datediff( 'minute', ldt_ForecastTime, idt_nowTime, sqlpis )) <= 60 Then 	
			dw_pisr070b_01.SetItem( I, 'partobeytimeflag', 1 )			//�ð� �ؼ� ��1�ð�
		Else																			
			dw_pisr070b_01.SetItem( I, 'partobeytimeflag', 0 )			//���Խð� ���ؼ� 
		End If
	Else																				//���� ���ؼ�
		dw_pisr070b_01.SetItem( I, 'partobeydateflag', 0 )	
		dw_pisr070b_01.SetItem( I, 'partobeytimeflag', 0 )
	End If
	dw_pisr070b_01.SetItem( I, 'partreceiptdate'	, is_jobdate )		//��������(Shift���� ����)
	dw_pisr070b_01.SetItem( I, 'parteditno'		, ll_editNo )		//�������
	dw_pisr070b_01.SetItem( I, 'partreceipttime'	, idt_nowTime )	//���Խð�(�������Խð�)

//	���԰��� ����
	dw_pisr070b_01.SetItem( I, 'partkbstatus'			, 'B' )			//���� -> ���԰���·� ��ȯ
//	dw_pisr070b_01.SetItem( I, 'partreceiptcalcel'	, 'N' )			//���԰� ���
	dw_pisr070b_01.SetItem( I, 'lastemp'				, 'Y' )	//Interface Flag Ȱ��
	dw_pisr070b_01.SetItem( I, 'lastdate'				, idt_nowTime )//�۾��ð�
	
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
dw_scan.Object.scancode_t.Text = '��ǰǥ��ȣ:'

this.PostEvent ( "ue_init" )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

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
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���԰���"
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  '���԰� ó��������Դϴ�.'
st_totkbcnt.Text = '0 ��'

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
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���԰����"
end type

event clicked;
rb_1.Weight = 400
rb_2.Weight = 700

dw_pisr070b_01.Reset()
is_deliveryno = is_Null
uo_status.st_message.text =  '���԰� ����������Դϴ�.'
st_totkbcnt.Text = '0 ��'


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
String	ls_receiptDate				//��������
DateTime	ldt_receiptTime			//���Խð�
Integer	I								//÷��
String	ls_nowDate, ls_nowTime	//��������,���Խð�
String	ls_olditemCode	= ''		//����ǰ��
Long		ll_editNo					//�������
Long     ll_oldeditNo            //����ǰ���������
Long 		ll_RowCount					//�Ѱ��Ǹż�
Long		ll_RackQty					//�����
Long		ll_oldRackQty	= 0		//���������
Long		ll_kbCnt			= 0		//���Ǹż�
Long		ll_napipQty		= 0		//���Լ���
Long		ll_qcCnt						//���˻�ǰ Ȯ�� 0���� Ŀ�� ���˻�ǰ
Long		ll_Sum						//��갪
str_pisr_partkb	lstr_partkb
String	ls_message= ''

////////////////////////////////////////////////
//		����ð� �� �������� String ����
////////////////////////////////////////////////
ls_nowDate		= Left(is_nowtime, 10)
ls_nowTime		= Mid(is_nowtime, 12, 5) + ':00'

this.AcceptText()

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

////////////////////////////////////////////////
// 	���԰� �������� ����
////////////////////////////////////////////////
this.SetTransObject(Sqlpis)									//���ǻ���
If This.Update() = -1 Then 
//	MessageBox("���԰����", "���԰� �������� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	ls_message = 'Update_Err'
	Goto RollBack_			
End If

ll_RowCount		= this.RowCount()

////////////////////////////////////////////////
//		���԰� ���� 
////////////////////////////////////////////////
For I = 1 To ll_RowCount Step 1
	ls_suppCode		= this.GetItemString(I	, 'suppliercode')
	ls_itemCode		= this.GetItemString(I	, 'itemcode')
	ll_RackQty		= this.GetItemNumber(I	, 'rackqty')
	ll_editNo		= this.GetItemNumber(I	, 'parteditno')

	//	�˻缺���� �� ���԰���� Summary, ������ ������� ����( ó�� ~ �������׸� ���� )
	If ls_olditemCode <> ls_itemCode Then
		If ls_olditemCode <> '' Then
			lstr_partkb.areacode	= istr_partkb.areacode	//����
			lstr_partkb.divcode	= istr_partkb.divcode	//����
			lstr_partkb.suppcode	= ls_suppCode				//��ü
			lstr_partkb.itemcode	= ls_olditemCode			//ǰ��
			//������������� ����
			lstr_partkb.applydate= is_jobdate				//���԰�����(Shift��������)
			IF wf_lastedit(lstr_partkb, ll_oldeditNo) = -1 Then 
//				MessageBox("���԰����", "������ ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
				ls_message = 'wf_lastedit_Err'
				Goto RollBack_
			End If
			//���԰���� Summary����
			lstr_partkb.applydate= ls_nowDate				//���԰�����(������������)
			IF wf_sumadd(lstr_partkb, ll_napipQty) = -1 Then 
//				MessageBox("���԰����", "���԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
				ls_message = 'wf_sumadd_Err'
				Goto RollBack_
			End If

			dw_pisr070b_03.SetTransObject(Sqlpis)				
			If dw_pisr070b_03.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, is_deliveryno, ls_olditemCode) = 0 then	
//				MessageBox("���԰����", ls_olditemCode + "�׸��� �˻缺������ ������� �ʾҽ��ϴ�.", StopSign! )
				ls_message = 'tqqcresult_Err'
				Goto RollBack_			
			End If
			//���˻�ǰ��
			If f_pisr_tqqcitem(sqlpis, lstr_partkb) Then 		
				dw_pisr070b_03.SetItem(1, 'judgeflag'	, '1')				//'1'�հ�,'2'���հ�,'3'����,'9'�˻�����
				ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'goodqty')		//�հݼ���
				If isNull(ll_Sum) Then ll_Sum = 0
				ll_Sum = ll_Sum + ll_napipQty
				dw_pisr070b_03.SetItem(1, 'goodqty'		, ll_Sum )			
				dw_pisr070b_03.SetItem(1, 'confirmflag', 'Y' )				//�˻�Ȯ��
				dw_pisr070b_03.SetItem(1, 'qcdate'		, ls_nowDate )		//�˻�����
				dw_pisr070b_03.SetItem(1, 'qctime'		, ls_nowTime )		//�˻�ð�
				dw_pisr070b_03.SetItem(1, 'qcleadtime'	, '0'			 )		//�˻�LeadTime
				dw_pisr070b_03.SetItem(1, 'inspectorcode'	, '���˻�')		//���˻�ǰ
			End If
			
			ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'kbcount')			//���Ǹż�
			If isNull(ll_Sum) Then ll_Sum = 0
			ll_Sum = ll_Sum + ll_napipQty
			dw_pisr070b_03.SetItem(1, 'kbcount'			, ll_kbCnt )		
			dw_pisr070b_03.SetItem(1, 'deliverydate'	, ls_nowDate )		//��������
			dw_pisr070b_03.SetItem(1, 'deliverytime'	, ls_nowTime )		//���Խð�
			dw_pisr070b_03.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag Ȱ��
			dw_pisr070b_03.SetItem(1, 'lastdate'		, idt_nowtime )	//���� �۾��ð�
			
			dw_pisr070b_03.SetTransObject(Sqlpis)									
			If dw_pisr070b_03.Update() = -1 Then 		
//				MessageBox("���԰����", "�˻缺�����׸� ������ ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
				ls_message = 'tqqcresultUpdate_Err'
				Goto RollBack_			
			End If
			ll_kbCnt 		= 0			//���Ǹż� Count (�˻缺���� ���Ǹż� ����)
			ll_napipQty 	= 0			//���Լ�������
			ll_oldRackQty	= 0
		End If	//ls_olditemCode <> '' Then
		ls_olditemCode = ls_itemCode
	End If	//ls_olditemCode <> ls_itemCode Then

//	ǰ���˻��׸� ����Ʈ ���� TQQCRESULTQTY
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
//				MessageBox("���԰����", "ǰ���˻��׸񸮽�Ʈ �������� ������ �߻��Ͽ����ϴ�.", StopSign! )
				ls_message = 'TQQCRESULTQTY_Err'
				Goto RollBack_			
			End If
		End If	//dw_pisr070b_02.Retrieve
		ll_oldRackQty = ll_RackQty
	End If	//ll_oldRackQty <> ll_RackQty Then
	
	ll_oldeditNo = ll_editNo
	ll_kbCnt 	= ll_kbCnt 	  + 1						//���Ǹż� Count (�˻缺���� ���Ǹż� ����)
	ll_napipQty	= ll_napipQty + ll_RackQty			//���Լ�������
Next

//	�˻缺���� �� ���԰���� Summary, ������ ������� ����( �������׸� )
If ls_olditemCode <> '' Then
	lstr_partkb.areacode	= istr_partkb.areacode	//����
	lstr_partkb.divcode	= istr_partkb.divcode	//����
	lstr_partkb.suppcode	= ls_suppCode				//��ü
	lstr_partkb.itemcode	= ls_olditemCode			//ǰ��
	//������������� ����
	lstr_partkb.applydate= is_jobdate				//���԰�����(Shift��������)
	IF wf_lastedit(lstr_partkb, ll_editNo) = -1 Then 
		ls_message = 'wf_lastedit_Err'
		Goto RollBack_
	End If
	//���԰���� Summary����
	lstr_partkb.applydate= ls_nowDate				//���԰�����(������������)
	IF wf_sumadd(lstr_partkb, ll_napipQty) = -1 Then
		ls_message = 'wf_sumadd_Err'
		Goto RollBack_
	End If
	//	�˻缺���� �׸� ��ǰȮ��( ó�� ~ �������׸� ���� )
	dw_pisr070b_03.SetTransObject(Sqlpis)				
	If dw_pisr070b_03.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, is_deliveryno, ls_olditemCode) = 0 then	
//		MessageBox("���԰����", ls_olditemCode + "�׸��� �˻缺������ ������� �ʾҽ��ϴ�.", StopSign! )
		ls_message = 'tqqcresult_Err'
		Goto RollBack_			
	End If
	//���˻�ǰ��
	If f_pisr_tqqcitem(sqlpis, lstr_partkb) Then 		
		dw_pisr070b_03.SetItem(1, 'judgeflag'	, '1')				//'1'�հ�,'2'���հ�,'3'����,'9'�˻�����
		ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'goodqty')		//�հݼ���
		If isNull(ll_Sum) Then ll_Sum = 0
		ll_Sum = ll_Sum + ll_napipQty
		dw_pisr070b_03.SetItem(1, 'goodqty'		, ll_Sum )			
		dw_pisr070b_03.SetItem(1, 'confirmflag', 'Y' )				//�˻�Ȯ��
		dw_pisr070b_03.SetItem(1, 'qcdate'		, ls_nowDate )		//�˻�����
		dw_pisr070b_03.SetItem(1, 'qctime'		, ls_nowTime )		//�˻�ð�
		dw_pisr070b_03.SetItem(1, 'qcleadtime'	, '0'			 )		//�˻�LeadTime
		dw_pisr070b_03.SetItem(1, 'inspectorcode'	, '���˻�')		//���˻�ǰ
	End If	//f_pisr_tqqcitem(sqlpis, lstr_partkb) Then 	//���˻�ǰ��
	
	ll_Sum = dw_pisr070b_03.GetItemNumber(1, 'kbcount')			//���Ǹż�
	If isNull(ll_Sum) Then ll_Sum = 0
	ll_Sum = ll_Sum + ll_napipQty
	dw_pisr070b_03.SetItem(1, 'kbcount'			, ll_kbCnt )		
	dw_pisr070b_03.SetItem(1, 'deliverydate'	, ls_nowDate )		//��������
	dw_pisr070b_03.SetItem(1, 'deliverytime'	, ls_nowTime )		//���Խð�
	dw_pisr070b_03.SetItem(1, 'lastemp'			, 'Y' )		//Interface Flag Ȱ��
	dw_pisr070b_03.SetItem(1, 'lastdate'		, idt_nowtime )	//���� �۾��ð�
	
	dw_pisr070b_03.SetTransObject(Sqlpis)									
	If dw_pisr070b_03.Update() = -1 Then 		
//		MessageBox("���԰����", "�˻缺�����׸� ������ ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
		ls_message = 'tqqcresultUpdate_Err'
		Goto RollBack_			
	End If
	ll_kbCnt 		= 0			//���Ǹż� Count (�˻缺���� ���Ǹż� ����)
	ll_napipQty 	= 0			//���Լ�������
	ll_oldRackQty	= 0
End If	//ls_olditemCode <> '' Then

//////////////////////////////////////////////////////////
//		��ǰǥ���� Update
//////////////////////////////////////////////////////////
  UPDATE TDELIVERYLIST  
     SET DeliveryConfirm 		= 'Y',   			//��ǰȮ��
         DeliveryReceiptDate 	= :ls_nowDate,  
         LastEmp 					= 'Y'		//Interface Flag Ȱ��  
   WHERE SupplierCode			= :ls_suppCode		AND   
   		DeliveryNo 				= :is_deliveryno   
   USING sqlpis       ;

If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("���԰����", "��ǰǥ ���� Update�� ���� �Ͽ����ϴ�.", StopSign! )
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
		MessageBox("���԰����", "���԰� �������� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE 'wf_lastedit_Err'
		MessageBox("���԰����", "������ ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE 'wf_sumadd_Err'
		MessageBox("���԰����", "���԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE 'tqqcresult_Err'
		MessageBox("���԰����", ls_olditemCode + "�׸��� �˻缺������ ������� �ʾҽ��ϴ�.", StopSign! )
	CASE 'tqqcresultUpdate_Err'
		MessageBox("���԰����", "�˻缺�����׸� ������ ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE 'TQQCRESULTQTY_Err'
		MessageBox("���԰����", "ǰ���˻��׸񸮽�Ʈ �������� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE 'TDELIVERYLIST_Err'
		MessageBox("���԰����", "��ǰǥ ���� Update�� ���� �Ͽ����ϴ�.", StopSign! )
	CASE ELSE
		MessageBox("����", "���԰� ó���� �����߽��ϴ�.", StopSign! )
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
//		���԰� Summary ���� (����)
////////////////////////////////////////////////
For I = 1 To ll_RowCount Step 1
	ls_suppCode		= this.GetItemString(I	, 'suppliercode')
	ls_itemCode		= this.GetItemString(I	, 'itemcode')
	ll_Qty			= this.GetItemNumber(I	, 'rackqty')
	//�� ���԰�����(Real) 2002.10.30
	//ls_receiptDate	= this.GetItemString(I	, 'partreceiptdate')
	ldt_receiptTime= this.GetItemDateTime(I, 'partreceipttime')
	ls_receiptDate	= left(String(ldt_receiptTime, "yyyy.mm.dd hh:mm"), 10)
	
	dw_summary.SetTransObject(Sqlpis)				
	If dw_summary.Retrieve(ls_receiptDate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		MessageBox("���԰���ҿ���", "���԰���� Summary������ ���� ���߽��ϴ�.", StopSign! )
		ls_message = 'summaryRetrieve_Err'
		Goto RollBack_			
	End If

//�� ���԰�����(Real), ����������  2002.10.30
//	ls_compMonth2 = left( ls_receiptDate, 7 )		//���԰���ؿ�
//	If ls_compMonth > ls_compMonth2 Then
//		dw_summary.SetTransObject(Sqlpis)				
//		If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//			dw_summary.ReSet();	dw_summary.InsertRow(0)
//			dw_summary.SetItem( 1, 'applydate'		, is_applydate )
//			dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//			dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//			dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//			dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//			dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	//Interface Flag Ȱ��
//			dw_summary.SetItem( 1, 'lastdate'		, idt_nowTime )
//		End If
//	End If
	
	ll_qtySum = dw_summary.GetItemNumber( 1, 'partreceiptqty' )
	ll_qtySum = ll_qtySum - ll_Qty									//���԰���� ����
	dw_summary.SetItem( 1, 'partreceiptqty', ll_qtySum )
	
	dw_summary.SetTransObject(Sqlpis)							//���� Summary
	If dw_summary.Update() = -1 Then 
//		MessageBox("���԰���ҿ���", "���԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
		ls_message = 'summaryUpdate_Err'
		Goto RollBack_			
	End If

	This.SetItem( I, 'partkbstatus'		, 'A' )			//���԰� -> ���ֻ��·� ��ȯ
//	This.SetItem( I, 'partreceiptcalcel', 'Y' )			//���԰� ���
	This.SetItem( I, 'partobeydateflag'	, 0 )				//���Թ��ؼ�ó��
	This.SetItem( I, 'partobeytimeflag'	, 0 )				//���Թ��ؼ�ó��
	This.SetItem( I, 'partreceiptdate'	, is_Null )		//��������
	This.SetItem( I, 'parteditno'			, li_Null )		//�������
	This.SetItem( I, 'partreceipttime'	, ldt_Null )		//���Խð�
	This.SetItem( I, 'lastemp'				, 'Y' )	//Interface FlagȰ��
	This.SetItem( I, 'lastdate'			, idt_nowTime )//�۾��ð�
Next

//	ǰ���˻� �׸񸮽�Ʈ ����
  DELETE FROM TQQCRESULTQTY  
   WHERE TQQCRESULTQTY.AREACODE 		= :istr_partkb.areacode AND  
         TQQCRESULTQTY.DIVISIONCODE = :istr_partkb.divcode 	AND  
         TQQCRESULTQTY.SUPPLIERCODE = :ls_suppCode 			AND  
         TQQCRESULTQTY.DELIVERYNO 	= :is_deliveryno 			
   USING sqlpis	;
If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("���԰���ҿ���", "ǰ���˻� �׸񸮽�Ʈ ������ ���� �Ͽ����ϴ�.", StopSign! )
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
         LASTEMP 			= 'Y'  			//Interface FlagȰ��
   WHERE TQQCRESULT.AREACODE 		= :istr_partkb.areacode AND  
         TQQCRESULT.DIVISIONCODE = :istr_partkb.divcode 	AND  
         TQQCRESULT.SUPPLIERCODE = :ls_suppCode 			AND  
         TQQCRESULT.DELIVERYNO 	= :is_deliveryno 
	USING	sqlpis	;
If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("���԰���ҿ���", "�˻缺���� ���������� �����Ͽ����ϴ�.", StopSign! )
	ls_message = 'TQQCRESULT_Err'
	Goto RollBack_			
End If

//	��ǰǥ ���� Update
  UPDATE TDELIVERYLIST  
     SET DeliveryConfirm 		= 'N',   			//��ǰ���
         DeliveryReceiptDate 	= :is_null,			//��ǰ����
			LastEmp			 		= 'Y',   //Interface FlagȰ��
         LastDate 				= :idt_nowTime    //�۾��ð�
   WHERE SupplierCode 			= :ls_suppCode 	AND  
   		DeliveryNo 				= :is_deliveryno   
   USING sqlpis       ;

If sqlpis.SqlCode <> 0 Then 		
//	MessageBox("���԰���ҿ���", "��ǰǥ ���� ������ ���� �Ͽ����ϴ�.", StopSign! )
	ls_message = 'TDELIVERYLIST_Err'
	Goto RollBack_			
End If

//	���԰� ��� ���ǻ��� ����
//If wf_cancelset( ll_RowCount ) = -1 Then Goto RollBack_

////////////////////////////////////////////////
// 	���԰� �������� ����
////////////////////////////////////////////////
this.SetTransObject(Sqlpis)									//���ǻ���
If This.Update() = -1 Then 
//	MessageBox("���԰����", "���԰� �������� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
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
		MessageBox("���԰���ҿ���", "���԰���� Summary������ ���� ���߽��ϴ�.", StopSign! )
	CASE 'summaryUpdate_Err'
		MessageBox("���԰���ҿ���", "���԰���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE 'TQQCRESULTQTY_Err'
		MessageBox("���԰���ҿ���", "ǰ���˻� �׸񸮽�Ʈ ������ ���� �Ͽ����ϴ�.", StopSign! )
	CASE 'TQQCRESULT_Err'
		MessageBox("���԰���ҿ���", "�˻缺���� ���������� �����Ͽ����ϴ�.", StopSign! )
	CASE 'TDELIVERYLIST_Err'
		MessageBox("���԰���ҿ���", "��ǰǥ ���� ������ ���� �Ͽ����ϴ�.", StopSign! )
	CASE 'thisUpdate_Err'
		MessageBox("���԰���ҿ���", "���԰� �������� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	CASE ELSE
		MessageBox("���԰���ҿ���", "���԰� ���ó���� ���� �Ͽ����ϴ�.", StopSign! )
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
st_totkbcnt.Text = '0 ��'

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
st_totkbcnt.Text = '0 ��'

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
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�Ѱ��Ǹż�: "
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
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "0 ��"
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
string title = "��������� ���Խð�"
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
string title = "���Ǽ��� Summary"
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
string title = "�����������������"
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
string title = "ǰ���˻�ǰ�����"
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
string title = "�˻缺��������"
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
string facename = "����ü"
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
	MessageBox( "Ȯ��", "�۾�ó�� ������ �ο����� �ʾҽ��ϴ�.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 12 Then 
	MessageBox( "�Է¿���", "�ùٸ� ��ǰǥ��ȣ �� �ƴմϴ�.", StopSign! )
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//���� �ý��۽ð�
is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
// ������
//is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//�������� -8�ð������
//is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//�������� -8�ð�,������ �����
// ������ : 2003.12
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
string facename = "����ü"
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
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

