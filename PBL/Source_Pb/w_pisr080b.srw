$PBExportHeader$w_pisr080b.srw
$PBExportComments$���Ǵ������԰����ó��(�ҷ�ǰ)
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
String	is_nowTime, is_jobDate, is_applyDate	//����ð�, �۾���������, ������������
DateTime	idt_nowTime										//����ð�
String	is_null
end variables

forward prototypes
public function long wf_validchk ()
end prototypes

event ue_process();//////////////////////////////////
//	���԰� ��� �۾� Control
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
istr_partkb.flag		= 1		//��ȸ

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
	MessageBox( "�Է¿���", "�������� �ʴ� �����Դϴ�. ", StopSign! )
	Return -1
End If

ls_areaCode			= dw_pisr080b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr080b_01.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "�Է¿���", "�ش� ������ ������ �ƴմϴ�.", StopSign! )
	Return -1
End If

ls_useFlag			= dw_pisr080b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "�Է¿���", "����ߴܵ� �����Դϴ�. ", StopSign! )
	Return -1
End If

ls_kbactivegubun	= dw_pisr080b_01.GetItemString( ll_Row, 'kbactivegubun' )
If ls_kbactivegubun = 'S' Then 
	MessageBox( "�Է¿���", "Sleeping ������ �����Դϴ�. ", StopSign! )
	Return -1
End If

ls_KBStatus			= dw_pisr080b_01.GetItemString( ll_Row, 'partkbstatus' )

CHOOSE CASE ls_KBStatus
CASE 'A'
	MessageBox( "�Է¿���", "���� ��ǰ���� ���� �����Դϴ�.", StopSign! )
	Return -1
CASE 'C', 'D'
	MessageBox( "�Է¿���", "�̹� �԰�ó���Ǿ��ų� ���ֵ��� ���� �����Դϴ�.", StopSign! )
	Return -1
END CHOOSE

ls_suppCode			= dw_pisr080b_01.GetItemString( ll_Row, 'suppliercode' )
ls_itemCode			= dw_pisr080b_01.GetItemString( ll_Row, 'itemcode' )
ls_deliveryNo		= dw_pisr080b_01.GetItemString( ll_Row, 'deliveryno' )
ll_rackQty			= dw_pisr080b_01.GetItemNumber( ll_Row, 'rackqty' )

//////////////////////////////////////////////////
//		ǰ���˻翩�� Ȯ��
//////////////////////////////////////////////////
String	ls_ReceiptDate
Integer  li_Net

ls_ReceiptDate = dw_pisr080b_01.GetItemString( ll_Row, 'partreceiptdate' )
If ls_ReceiptDate < '2002.12.09' Then 
//	li_Net = MessageBox("����Ȯ�ο�û", "�� �ý��ۿ��� ��ǰ���� ������ �հݿ��θ� Ȯ���� �� �����ϴ�. ~r~n~r~n" + &
//													"�ش� ������ ���԰����ó�� �Ͻðڽ��ϱ� ?", &
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
			MessageBox( "�Է¿���", "�հ� ó���� �����Դϴ�.", StopSign! )
			Return -1
//	CASE '2'
//			MessageBox( "�Է¿���", "���հ� ó���� �����Դϴ�.", StopSign! )
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
				MessageBox( "�Է¿���", "ǰ���˻翩�θ� Ȯ���� �� �����ϴ�.", StopSign! )
				Return -1
			End If	
			
			If isNull(ll_Cnt) Then ll_Cnt = 0
				
			If ll_Cnt < 1 Then
				MessageBox( "�Է¿���", "�հ� ó���� �����Դϴ�.", StopSign! )
				Return -1
			End If	
			li_Net = MessageBox("����Ȯ�ο�û", "�������հ� ���ǿ� ���ؼ��� ���հݿ��θ� Ȯ���� �� �����ϴ�. ~r~n~r~n" + &
															"�ش� ������ ���԰����ó�� �Ͻðڽ��ϱ� ?", &
										Question!, OKCancel!, 2)
			IF li_Net <> 1 THEN	Return -1

	CASE '9'
			MessageBox( "�Է¿���", "ǰ���˻簡 �Ϸ���� ���� �����Դϴ�.", StopSign! )
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

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

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
	MessageBox( "Ȯ��", "�۾�ó�� ������ �ο����� �ʾҽ��ϴ�.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 11 Then 
	MessageBox( "�Է¿���", "�ùٸ� ���ǹ�ȣ �� �ƴմϴ�.", StopSign! )
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

type dw_summary from datawindow within w_pisr080b
integer x = 1234
integer y = 1088
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
string facename = "����ü"
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
string facename = "����ü"
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
//		���԰���� ���� ����
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
//�� ���԰�����(Real), ����������  2002.10.30
//ls_receiptdate	= this.GetItemString(ll_Row	, 'partreceiptdate')
ldt_receiptTime= this.GetItemDateTime(ll_Row	, 'partreceipttime')
ls_receiptdate	= left(String(ldt_receiptTime, "yyyy.mm.dd hh:mm"),10)
ll_Qty			= this.GetItemNumber(ll_Row	, 'rackqty')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	���԰� ���� Summary ����
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_receiptdate, istr_partkb.areacode, istr_partkb.divCode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err'
//	MessageBox("���԰���ҿ���", "���԰� Summary������ ���� ���߽��ϴ�.", StopSign! )
	Goto RollBack_			
End If
////�� ���԰�����(Real), ����������  2002.10.30
//ls_compMonth2 = left( ls_receiptdate, 7 )		//���԰���ؿ�
//If ls_compMonth > ls_compMonth2 Then
//	dw_summary.SetTransObject(Sqlpis)				
//	If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divCode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.ReSet();	dw_summary.InsertRow(1)
//		dw_summary.SetItem( 1, 'applydate'		, is_applydate )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divCode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' ) //Interface Flag Ȱ��
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partreceiptqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partreceiptqty', ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' ) //Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)				//���԰���� Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("���԰���ҿ���", "���԰���Ұ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

/////////////////////////////////////////////////////
//		���԰� ���� ��� Setting
/////////////////////////////////////////////////////
dw_pisr080b_01.SetItem(ll_Row, 'partkbstatus'		, 'A')	//���ֻ��·� ��ȯ
dw_pisr080b_01.SetItem(ll_Row, 'partreceiptcancel'	, 'Y')	//���԰���� ����
dw_pisr080b_01.SetItem(ll_Row, 'partobeydateflag'	, 0)		//���ֻ��·� ��ȯ
dw_pisr080b_01.SetItem(ll_Row, 'partobeytimeflag'	, 0)		//���ֻ��·� ��ȯ
dw_pisr080b_01.SetItem(ll_Row, 'partreceiptdate'	, is_null )		//��������
dw_pisr080b_01.SetItem(ll_Row, 'parteditno'			, li_null )		//�������
dw_pisr080b_01.SetItem(ll_Row, 'partreceipttime'	, ldt_null )	//���Խð�
dw_pisr080b_01.SetItem(ll_Row, 'DeliveryNo'			, is_null )		//��ǰǥ��ȣ
dw_pisr080b_01.SetItem(ll_Row, 'lastemp'				, 'Y')	//Interface Flag Ȱ��
dw_pisr080b_01.SetItem(ll_Row, 'lastdate'				, idt_nowTime)	//�۾��ð�

this.SetTransObject(Sqlpis)									//���ǻ���
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("���԰���ҿ���", "���԰���Ұ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
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
	MessageBox("���԰���ҿ���", "���԰� Summary������ ���� ���߽��ϴ�.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err' Then
	MessageBox("���԰���ҿ���", "���԰���Ұ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("���԰���ҿ���", "���԰���Ұ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
Else 
	MessageBox("���԰���ҿ���", "���԰����ó���� �����Ͽ����ϴ�.", StopSign! )
End If
return -1


end event

event clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

