$PBExportHeader$w_pisr090c.srw
$PBExportComments$�԰��ù��ְ���ó��/���ֻ���(��ǰ��)
forward
global type w_pisr090c from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr090c
end type
type uo_division from u_pisc_select_division within w_pisr090c
end type
type dw_pisr090b_01 from datawindow within w_pisr090c
end type
type dw_pisr090b_02 from u_vi_std_datawindow within w_pisr090c
end type
type dw_scan from datawindow within w_pisr090c
end type
type dw_summary from datawindow within w_pisr090c
end type
type dw_lastedit from datawindow within w_pisr090c
end type
type rb_1 from radiobutton within w_pisr090c
end type
type rb_2 from radiobutton within w_pisr090c
end type
type pb_1 from picturebutton within w_pisr090c
end type
type dw_orderseq from datawindow within w_pisr090c
end type
type pb_2 from picturebutton within w_pisr090c
end type
type gb_3 from groupbox within w_pisr090c
end type
type gb_2 from groupbox within w_pisr090c
end type
type gb_scan from groupbox within w_pisr090c
end type
type gb_4 from groupbox within w_pisr090c
end type
end forward

global type w_pisr090c from w_ipis_sheet01
integer width = 4123
event ue_init ( )
event ue_process ( )
uo_area uo_area
uo_division uo_division
dw_pisr090b_01 dw_pisr090b_01
dw_pisr090b_02 dw_pisr090b_02
dw_scan dw_scan
dw_summary dw_summary
dw_lastedit dw_lastedit
rb_1 rb_1
rb_2 rb_2
pb_1 pb_1
dw_orderseq dw_orderseq
pb_2 pb_2
gb_3 gb_3
gb_2 gb_2
gb_scan gb_scan
gb_4 gb_4
end type
global w_pisr090c w_pisr090c

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowTime, is_jobDate, is_applyDate	//����ð�, �۾���������, ������������
DateTime	idt_nowTime										//����ð�
String	is_null
end variables

forward prototypes
public function integer wf_cancelset ()
public function integer wf_cancelvalid ()
public function integer wf_ordervalid (ref string fs_message)
end prototypes

event ue_init();pb_1.Enabled = m_frame.m_action.m_save.Enabled

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

event ue_process();//////////////////////////////////
//		�԰��� ���� �۾� Control
//////////////////////////////////
Long		ll_Row
String	ls_PartType, ls_partKBGubun
Integer	li_Net

SetPointer(HourGlass!)
CHOOSE CASE rb_1.Checked

CASE True		//���ֵ��
		ll_Row = f_pisr_incomevalidchk(dw_pisr090b_01, is_partkbno, istr_partkb.areacode, istr_partkb.divcode, is_jobdate)
		If ll_Row = -1 Then 
			dw_pisr090b_01.ReSet() 
			dw_pisr090b_01.InsertRow(1) 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.SetFocus()
			Goto EndReturn_
		End If
//�� ������ Reading �Ͽ� ��ȹǰ,�ӽð��� �̸� �԰� �ĺ���ǰ �̸� �԰��Ĺ����۾�����
//		ls_PartType = dw_pisr090b_01.GetItemString(ll_Row, 'parttype')
//		If ls_PartType = 'P' Then 
//			MessageBox( "�Է¿���", "��ȹ��ǰ�� ������ �԰��ù���ó���� �Ͻ� �� �����ϴ�.", StopSign! )
//			dw_pisr090b_01.ReSet() 
//			dw_pisr090b_01.InsertRow(1) 
//			dw_scan.SetItem(1, 'scancode', is_null )
//			dw_scan.SetFocus()
//			Goto EndReturn_
//		End If
//		ls_partKBGubun 	= dw_pisr090b_01.GetItemString( ll_Row, 'partkbgubun' )
//		If ls_partKBGubun = 'T' Then
//			li_Net = MessageBox("Ȯ�ο��",  "�Է��Ͻ� ������ �ӽð����Դϴ�. ~r~n" + &
//														"�԰�ó���� �ڵ�����ó�� �Ͻðڽ��ϱ�?.", &
//						Question!, OKCancel!, 2)
//			IF li_Net <> 1 THEN
//				dw_pisr090b_01.ReSet() 
//				dw_pisr090b_01.InsertRow(1) 
//				dw_scan.SetItem(1, 'scancode', is_null )
//				dw_scan.SetFocus()
//				Goto EndReturn_
//			END IF
//		END IF
		
		If f_pisr_setincomestatus(dw_pisr090b_01) = -1 Then Goto EndReturn_
		If dw_pisr090b_01.Event ue_save() = -1 Then Goto EndReturn_
CASE ELSE		//�������
		ll_Row = wf_cancelvalid()
		If ll_Row = -1 Then 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.Object.scancode.SetFocus()
			Goto EndReturn_
		End If
		If dw_pisr090b_01.Event ue_cancelsave() = -1 Then Goto EndReturn_
END CHOOSE

dw_pisr090b_01.RowsCopy(1,1, Primary!, dw_pisr090b_02, 1, Primary!)

EndReturn_:
SetPointer(Arrow!)
Return
end event

public function integer wf_cancelset ();/////////////////////////////////////////
// �������� ������ �������� DataSet
/////////////////////////////////////////
Long 		ll_Row
Integer	li_null
DateTime	ldt_null

SetNull(li_null)
SetNull(ldt_null)

ll_Row	= dw_pisr090b_01.GetRow()
  
dw_pisr090b_01.SetItem(ll_Row, 'partkbstatus'			, 'D')		//A����, B���԰�, C�԰�, D���ִ��
dw_pisr090b_01.SetItem(ll_Row, 'kborderpossible'		, 'Y')
dw_pisr090b_01.SetItem(ll_Row, 'orderchangeflag'		, 'N')
dw_pisr090b_01.SetItem(ll_Row, 'partordercancel'		, 'Y')
dw_pisr090b_01.SetItem(ll_Row, 'partreceiptcancel'		, 'N')
//
dw_pisr090b_01.SetItem(ll_Row, 'partorderdate'			, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'partordertime'			, ldt_null)
dw_pisr090b_01.SetItem(ll_Row, 'partforecastdate'		, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'partforecasteditno'	, li_null)
dw_pisr090b_01.SetItem(ll_Row, 'partforecasttime'		, ldt_null)
//
dw_pisr090b_01.SetItem(ll_Row, 'partreceiptdate'		, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'parteditno'				, li_null)
dw_pisr090b_01.SetItem(ll_Row, 'partreceipttime'		, ldt_null)
dw_pisr090b_01.SetItem(ll_Row, 'partincomedate'			, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'partincometime'			, ldt_null)
dw_pisr090b_01.SetItem(ll_Row, 'partorderno'				, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'deliveryno'				, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'orderchangetime'		, ldt_null)
dw_pisr090b_01.SetItem(ll_Row, 'orderchangecode'		, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'changeforecastdate'	, is_null)
dw_pisr090b_01.SetItem(ll_Row, 'changeforecasteditno'	, li_null)
dw_pisr090b_01.SetItem(ll_Row, 'changeforecasttime'	, ldt_null)
dw_pisr090b_01.SetItem(ll_Row, 'lastemp'					, 'Y')		//Interface Flag Ȱ��
dw_pisr090b_01.SetItem(ll_Row, 'lastdate'					, idt_nowTime)

return 0
end function

public function integer wf_cancelvalid ();
String	ls_areaCode, ls_divCode
String	ls_KBStatus, ls_OrderPossible, ls_useFlag, ls_ReprintFlag, ls_kbactivegubun
String	ls_DeliveryNo, ls_PartOrderNo
Long		ll_Row
DateTime ldt_orderTime
String	ls_orderDate

dw_pisr090b_01.SetTransObject (sqlpis)
ll_Row = dw_pisr090b_01.Retrieve(is_partkbno, is_jobdate)
If ll_Row = 0 Then 
	MessageBox( "�Է¿���", "�������� �ʴ� �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
End If

ls_areaCode			= dw_pisr090b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr090b_01.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "�Է¿���", "�ش� ������ ������ �ƴմϴ�.", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
End If

ls_useFlag			= dw_pisr090b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "�Է¿���", "����ߴܵ� �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
End If

ls_kbactivegubun	= dw_pisr090b_01.GetItemString( ll_Row, 'kbactivegubun' )
If ls_kbactivegubun = 'S' Then 
	MessageBox( "�Է¿���", "Sleeping ������ �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
End If

ls_KBStatus			= dw_pisr090b_01.GetItemString( ll_Row, 'partkbstatus' )
CHOOSE CASE ls_KBStatus
CASE 'B'
	MessageBox( "�Է¿���", "���� ���԰������ �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
CASE 'C', 'D'
	MessageBox( "�Է¿���", "���� ���ֵ��� ���� �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
END CHOOSE


ls_OrderPossible	= dw_pisr090b_01.GetItemString( ll_Row, 'kborderpossible' )
If ls_OrderPossible = 'Y' Then 
	MessageBox( "�Է¿���", "���� ���ֵ��� ���� �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
End If

////�� �������ڰ� ���� ������ ������ҺҰ��� ( 2002.11.11 ���¼����� )
//ldt_orderTime 		= dw_pisr090b_01.GetItemDateTime( ll_Row, 'partordertime' )
//ls_orderDate		= left(String(ldt_orderTime, "yyyy.mm.dd hh:mm"), 10)
//If ls_orderDate < left(is_nowtime, 10) Then
//	MessageBox( "������ҺҴ�", "�������ڰ� �����׸��� ������Ұ� �Ұ����մϴ�.", StopSign! )
//	dw_pisr090b_01.ReSet() 
//	dw_pisr090b_01.InsertRow(1) 
//	Return -1
//End If

ls_DeliveryNo 		= dw_pisr090b_01.GetItemString( ll_Row, 'deliveryno' )
If ( Not isNull( ls_DeliveryNo )) AND trim(ls_DeliveryNo) <> '' Then 
	MessageBox( "�Է¿���", "�̹� ��ǰǥ�� ����� �����Դϴ�. ", StopSign! )
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	Return -1
End If

ls_PartOrderNo		= dw_pisr090b_01.GetItemString( ll_Row, 'partorderno' )
If ( Not isNull( ls_PartOrderNo )) Or trim(ls_PartOrderNo) <> '' Then 
	MessageBox( "Ȯ��", "��ü�� ����Ǿ��ų� �����Ϸ��� �����Դϴ�. ", Information! )
End If

ls_ReprintFlag		= dw_pisr090b_01.GetItemString( ll_Row, 'reprintflag' )
If ls_ReprintFlag = 'Y' Then 
	MessageBox( "�����û", "�ű� �Ǵ� �⺻���� ������������ ������ �ʿ��� �����Դϴ�. ", Information! )
End If

return ll_Row
end function

public function integer wf_ordervalid (ref string fs_message);////////////////////////////////////////
// 	�� ���� ���� ���� Ȯ��
////////////////////////////////////////
String	ls_useFlag
String	ls_areaCode, ls_divCode, ls_suppCode, ls_itemCode, ls_ReprintFlag, ls_Chk 
Long		ll_Row

dw_pisr090b_01.SetTransObject (sqlpis)
ll_Row = dw_pisr090b_01.Retrieve(is_partkbno, is_jobdate) 

ls_useFlag			= dw_pisr090b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	fs_message = 'useFlag_Err'
//	MessageBox( "�Է¿���", "���� ����ߴܵ� �����Դϴ�. ~r~n" + &
//	                        "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
	Return -1
End If

ls_areaCode			= dw_pisr090b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr090b_01.GetItemString( ll_Row, 'divisioncode' )
ls_suppCode			= dw_pisr090b_01.GetItemString( ll_Row, 'suppliercode' )
ls_itemCode			= dw_pisr090b_01.GetItemString( ll_Row, 'itemcode' )
ls_ReprintFlag		= dw_pisr090b_01.GetItemString( ll_Row, 'reprintflag' )

  SELECT TMSTPARTCOST.XPAY  
    INTO :ls_Chk  
    FROM TMSTPARTCOST  
   WHERE TMSTPARTCOST.SupplierCode 	= :ls_suppCode AND  
         TMSTPARTCOST.ItemCode 		= :ls_itemCode   
	USING	sqlpis	;
If isNull(ls_Chk) Or Trim(ls_Chk) = '' Then 
	fs_message = 'XPAY_Err'
//	MessageBox( "���ֺҰ���", "���������� �������� ���� ǰ���̹Ƿ� ���ְ� �Ұ����մϴ�. ~r~n" + &
//	                        "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
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
	fs_message = 'Planner_Err'
//	MessageBox( "���ֺҰ���", "���Ŵ���ڰ� ������������ ǰ���̹Ƿ� ���ְ� �Ұ����մϴ�. ~r~n" + &
//	                        "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
	Return -1
End If

ls_ReprintFlag		= dw_pisr090b_01.GetItemString( ll_Row, 'reprintflag' )
If ls_ReprintFlag = 'Y' Then 
	fs_message = 'Reprint'
//	MessageBox( "�����û", "�⺻���� ������������ ������ �ʿ��� �����Դϴ�. ", Information! )
End If

return ll_Row
end function

on w_pisr090c.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisr090b_01=create dw_pisr090b_01
this.dw_pisr090b_02=create dw_pisr090b_02
this.dw_scan=create dw_scan
this.dw_summary=create dw_summary
this.dw_lastedit=create dw_lastedit
this.rb_1=create rb_1
this.rb_2=create rb_2
this.pb_1=create pb_1
this.dw_orderseq=create dw_orderseq
this.pb_2=create pb_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_scan=create gb_scan
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisr090b_01
this.Control[iCurrent+4]=this.dw_pisr090b_02
this.Control[iCurrent+5]=this.dw_scan
this.Control[iCurrent+6]=this.dw_summary
this.Control[iCurrent+7]=this.dw_lastedit
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.dw_orderseq
this.Control[iCurrent+12]=this.pb_2
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_scan
this.Control[iCurrent+16]=this.gb_4
end on

on w_pisr090c.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisr090b_01)
destroy(this.dw_pisr090b_02)
destroy(this.dw_scan)
destroy(this.dw_summary)
destroy(this.dw_lastedit)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.pb_1)
destroy(this.dw_orderseq)
destroy(this.pb_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_scan)
destroy(this.gb_4)
end on

event open;call super::open;
SetNull(is_null)

dw_summary.Visible 	= False
dw_lastedit.Visible 	= False
dw_orderseq.Visible 	= False
rb_1.Checked			= True	
rb_1.Weight 			= 700

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)

dw_pisr090b_01.SetTransObject (sqlpis)
dw_pisr090b_01.InsertRow(1) 

this.PostEvent ( "ue_init" )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

dw_pisr090b_02.Width = newwidth 	- ( dw_pisr090b_02.x + ls_gap * 2 )
dw_pisr090b_02.Height= newheight - ( dw_pisr090b_02.y + ls_status )

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

type uo_status from w_ipis_sheet01`uo_status within w_pisr090c
end type

type uo_area from u_pisc_select_area within w_pisr090c
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 80
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

dw_pisr090b_01.Reset()
dw_pisr090b_01.SetTransObject(sqlpis)
dw_pisr090b_01.InsertRow(1)

dw_pisr090b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr090c
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 90
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_pisr090b_01.Reset()
dw_pisr090b_01.SetTransObject(sqlpis)
dw_pisr090b_01.InsertRow(1)

dw_pisr090b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_pisr090b_01 from datawindow within w_pisr090c
event type integer ue_save ( )
event type integer ue_cancelsave ( )
integer x = 32
integer y = 380
integer width = 3982
integer height = 684
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr090b_01"
boolean border = false
boolean livescroll = true
end type

event type integer ue_save();///////////////////////////////////////////////////
//		�԰�ó�� �� �ڵ�����(�ĺ���ǰ)
///////////////////////////////////////////////////
String	ls_suppCode, ls_itemCode, ls_applyFrom
Long		ll_Row, ll_Qty, ll_qtySum
Integer	ri_errcode
String	ls_oldOrderDate , ls_oldIncomeDate	
DateTime	ldt_oldOrderTime, ldt_oldForecastTime	, ldt_oldReceiptTime	, ldt_oldIncomeTime
String	ls_autoFlag, ls_partkbGubun
String	ls_message = ''

this.AcceptText()
ll_Row					= this.GetRow()
ls_suppCode				= Upper(this.GetItemString(ll_Row	, 'suppliercode'))
ls_itemCode				= Upper(this.GetItemString(ll_Row	, 'itemcode'))
ls_applyFrom			= this.GetItemString(ll_Row	, 'applyfrom')
ll_Qty					= this.GetItemNumber(ll_Row	, 'rackqty')
ldt_oldOrderTime		= this.GetItemDateTime(ll_Row	, 'partordertime')
ls_oldOrderDate		= left(String(ldt_oldOrderTime, "yyyy.mm.dd hh:mm"),10)
ldt_oldForecastTime	= this.GetItemDateTime(ll_Row	, 'partforecasttime')
ldt_oldReceiptTime	= this.GetItemDateTime(ll_Row	, 'partreceipttime')
ls_oldIncomeDate		= this.GetItemString(ll_Row	, 'partincomedate')
ldt_oldIncomeTime		= this.GetItemDateTime(ll_Row	, 'partincometime')
ls_autoFlag				= this.GetItemString(ll_Row	, 'autoreorderflag')
ls_partkbGubun			= this.GetItemString(ll_Row	, 'partkbgubun')

////////////////////////////////////////////////
// 		�԰� ó�� 
////////////////////////////////////////////////
sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	�԰���� Summary���� 
// �� �԰���� ���� �ǽð�(�������� 15��,���� �����) ����
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_oldIncomeDate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, ls_oldIncomeDate )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		// Interface Flag Ȱ��
	dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partincomeqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partincomeqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )		// Interface Flag Ȱ��
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
		 :is_partkbno, :ls_oldOrderDate, :g_s_empno, @ri_errcode = 0 Output  
USING sqlpis ;

Execute proc_partkbhis ;
If f_pisr_Errorhandler(Sqlpis, "Execute proc_crKbNo", "Faild") = 0 Then 
	Fetch proc_partkbhis Into :ri_errcode ;
	If f_pisr_ErrorHandler(Sqlpis, "Fetch proc_crKbNo", "Failed") <> 0 Then
		ls_message = 'partkbhis_Err'
//		Messagebox( "�԰�ó������", "�ش� ������ History������ �����߽��ϴ�.", StopSign!)
		Close proc_partkbhis ;
		Goto RollBack_
	End If
Else
	ls_message = 'partkbhis_Err'
	Close proc_partkbhis ;
	Goto RollBack_
End If
Close proc_partkbhis ;

///////////////////////////////////////////////////
//		HOST ����Ÿ���� �ڷ����
///////////////////////////////////////////////////
String	ls_oldorderSeq, ls_oldreceiptDate, ls_usecenter, ls_costGubun, ls_usecentergubun, ls_deliveryno
Long 		ll_SeqNo

ls_oldorderSeq 	= this.GetItemString(ll_Row, 'orderseq')
ls_oldreceiptDate	= left(string(ldt_oldReceiptTime, "yyyy.mm.dd hh:mm"), 10)
ls_usecenter		= this.GetItemString(ll_Row, 'usecenter')
ls_deliveryno 		= this.GetItemString(ll_Row, 'deliveryno')
// �԰����ڱ��� �����󱸺�
  SELECT UseCenterGubun, CostGubun  
    INTO :ls_usecentergubun, :ls_costGubun  
    FROM TMSTPARTKBHIS  
   WHERE AreaCode 		= :istr_partkb.areacode AND  
         DivisionCode 	= :istr_partkb.divcode 	AND  
         SupplierCode 	= :ls_suppCode 			AND  
         ItemCode 		= :ls_itemCode 			AND  
         ApplyFrom 		<=:ls_oldOrderDate 		AND  
         ApplyTo 			>=:ls_oldOrderDate    
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
           :ls_oldOrderDate,   
           :ll_Qty,   
           :ls_oldIncomeDate,   
           :ls_oldreceiptDate,   
           :ls_costGubun,   
           :ls_usecenter,   
           :g_s_empno,   
           :idt_nowtime,
			  :ls_deliveryno )  
	USING	sqlpis	;
			  
If sqlpis.SqlCode <> 0 Then 
	ls_message = 'INCOME_INTERFACE_Err'
//	MessageBox("�԰����", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If
//			  

//////////////////////////////////////////////////////////////////////////////////////
//�� Reading ������ ��ȹǰ�̰ų� �ӽð��� �̸� ����ó�� ����  2002.11.07 �����弳��ȸ
//////////////////////////////////////////////////////////////////////////////////////
If ls_autoFlag = 'N' OR ls_partkbGubun = 'T' Then GoTo Commit_	

////////////////////////////////////////////////
// 		���� ó�� 
////////////////////////////////////////////////
String	ls_ordershiftdate, ls_orderdate, ls_forecastdate
DateTime	ldt_orderTime, ldt_forecastTime
String	ls_cycleDate, ls_compTime
Long 		ll_editNo

ll_Row = wf_ordervalid( ls_message )	// ���ְ��ɿ��� Checking
If ll_Row = -1 Then 
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
//	ls_message = 'ordervalid_Err'
	Goto RollBack_			
End If

If f_pisr_ordercalc_productgroup(dw_pisr090b_01, idt_nowtime, is_jobdate, is_applydate, ls_message) = -1 Then 
	If ls_message = "WorkCalendar_Err" Then
		MessageBox("���ֽ���", "���� Work Calendar�� �غ���� �ʾҽ��ϴ�.", Information!)
	ElseIf ls_message = "OrderTime_Err" Then
		MessageBox("���ֽ���", "���ֽð� ��꿡 �����߽��ϴ�." , StopSign! )
	ElseIf ls_message = "KBStatus_Err" Then
		MessageBox("���ֽ���", "�������� ������ ���������� �дµ� �����Ͽ����ϴ�." , StopSign! )
	ElseIf ls_message = "ForecastTime_Err" Then
		MessageBox("���ֽ���", "���Կ����ð� ��꿡 �����߽��ϴ�." , StopSign! )
	ElseIf ls_message = "tmstsupplier_err" Then
		MessageBox("���ֽ���", "�ŷ��ߴܵ� ��ü�Դϴ�." , StopSign! )
	ElseIf ls_message = "tmstpartcost_err" Then
		MessageBox("���ֽ���", "�ŷ��ߴܵ� ǰ���Դϴ�." , StopSign! )	
	End If
	
	dw_pisr090b_01.ReSet() 
	dw_pisr090b_01.InsertRow(1) 
	dw_scan.SetItem(1, 'scancode', is_null )
	dw_scan.Object.scancode.SetFocus()
//	ls_message = 'ordercalc_Err'
//	MessageBox( "���ֿ���", "���ְ���� ���з� ���� �԰��۾��� ó���� �� �����ϴ�. ~r~n" + &
//	                        "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
	Goto RollBack_			
End If	

If f_pisr_setorderstatus(dw_pisr090b_01, idt_nowtime) = -1 Then 
	ls_message = 'setorder_Err'
	Goto RollBack_
End IF

this.AcceptText()
ll_Row				= this.GetRow()
ls_ordershiftdate	= this.GetItemString(ll_Row	, 'partorderdate')
ldt_orderTime		= this.GetItemDateTime(ll_Row	, 'partordertime')
ls_orderdate		= left(String(ldt_orderTime	, "yyyy.mm.dd hh:mm"), 10)
//ls_forecastdate	= this.GetItemString(ll_Row	, 'partforecastdate')
ldt_forecastTime	= this.GetItemDateTime(ll_Row	, 'partforecasttime')
ls_forecastdate	= left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"), 10)
ll_Qty				= this.GetItemNumber(ll_Row	, 'rackqty')
ls_cycleDate		= this.GetItemString(ll_Row	, 'cycle_applyfrom')

//	���ּ��� Summary����
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_orderdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, ls_orderdate )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
	dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partorderqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partorderqty', ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)							//���� Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err1'
//	MessageBox("���ֿ���", "���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//	���Կ������� Summary����
dw_summary.SetTransObject(Sqlpis)			
If dw_summary.Retrieve(ls_forecastdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	dw_summary.InsertRow(1)
	dw_summary.SetItem( 1, 'applydate'		, ls_forecastdate )
	dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
	dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partforecastqty' )
ll_qtySum = ll_qtySum + ll_Qty
dw_summary.SetItem( 1, 'partforecastqty', ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//���Կ��� Summary
If dw_summary.Update() = -1 Then	
	ls_message = 'summaryUpdate_Err2'
//	MessageBox("���ֿ���", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//	(����)������ ���
dw_lastedit.SetTransObject(Sqlpis)				
If dw_lastedit.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode, 'A') = 0 then
	dw_lastedit.InsertRow(1)
	dw_lastedit.SetItem( 1, 'areacode'		, istr_partkb.areacode )
	dw_lastedit.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
	dw_lastedit.SetItem( 1, 'suppliercode'	, ls_suppCode )
	dw_lastedit.SetItem( 1, 'itemcode'		, ls_itemCode )
	dw_lastedit.SetItem( 1, 'ordergubun'	, 'A' )				//A:����, B:����(���԰�)
	dw_lastedit.SetItem( 1, 'lastemp'		, 'Y' )	// Interface Flag Ȱ��
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
//	MessageBox("���ֿ���", '���� �ð� ����� �ùٸ��� �ʽ��ϴ�.', StopSign!)
	Goto RollBack_			
End If
dw_lastedit.SetItem( 1, 'partlasteditdate', ls_ordershiftdate )
dw_lastedit.SetItem( 1, 'parteditno'		, ll_editNo )
dw_lastedit.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
dw_lastedit.SetItem( 1, 'lastdate'			, idt_nowtime )

dw_lastedit.SetTransObject(Sqlpis)							//(����)������ ���
If dw_lastedit.Update() = -1 Then 		
	ls_message = 'lasteditUpdate_Err'
//	MessageBox("���ֿ���", "������ ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

///////////////////////////////////////////////////////////////////
//	��������ȭ��ȣ ���� : ��(1)+��(2)+36����S/N(5)+����(1)+����(1)
///////////////////////////////////////////////////////////////////
String	ls_orderSeq, ls_applyMonth

ls_applyMonth  = left(ls_orderdate, 7)					//���ֳ��

dw_orderseq.SetTransObject(Sqlpis)			
If dw_orderseq.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_applyMonth) = 0 then
	dw_orderseq.InsertRow(1)
	dw_orderseq.SetItem(1, 'areacode'		, istr_partkb.areacode )
	dw_orderseq.SetItem(1, 'divisioncode'	, istr_partkb.divcode )
	dw_orderseq.SetItem(1, 'applymonth'		, ls_applyMonth )
	dw_orderseq.SetItem(1, 'seqno'			, '' )
	dw_orderseq.SetItem(1, 'orderseq'		, '' )
End If

//��������ȭ��ȣ �����Լ� ȣ��
ls_orderSeq = f_pisr_orderseq( dw_orderseq, ls_orderdate, idt_nowtime )
If trim(ls_orderSeq) = '' Then 
	ls_message = 'orderseq_Err'
	Goto RollBack_	
End If

dw_orderseq.SetTransObject(Sqlpis)						//���Կ��� Summary
If dw_orderseq.Update() = -1 Then	
	ls_message = 'orderseqUpdate_Err'
//	MessageBox("���ֿ���", "��������ȭ��ȣ�� �ùٷ� ��ϵ��� �ʾҽ��ϴ�.", StopSign! )
	Goto RollBack_			
End If

//	���ǻ�������
This.SetItem(1, 'orderseq', ls_orderSeq )
this.SetTransObject(Sqlpis)									//���ǻ���
If This.Update() = -1 Then 
	ls_message = 'ThisUpdate_Err'
//	MessageBox("���ֿ���", "���ְ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

///////////////////////////////////////////////////////
//		HOST ����Ÿ���� �ڷ����
///////////////////////////////////////////////////////
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
	ls_message = 'ORDER_INTERFACE_Err'
//	MessageBox("���ֿ���", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If
//

this.Object.t_partordertime.Text 		= String(ldt_oldOrderTime		, 'yyyy.mm.dd hh:mm') 
this.Object.t_partforecasttime.Text 	= String(ldt_oldForecastTime	, 'yyyy.mm.dd hh:mm')  
this.Object.t_partreceipttime.Text 		= string(ldt_oldReceiptTime	, 'yyyy.mm.dd hh:mm')  
this.Object.t_partincometime.Text 		= string(ldt_oldIncomeTime		, 'yyyy.mm.dd hh:mm')   

//	����
Commit_:
//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
////////// ���ְ��ɿ���Ȯ��(wf_ordervalid)���� ������ Messgaeó����
If	ls_message = 'Reprint' Then
	MessageBox("Ȯ��", "�⺻���� ������������ ������ �ʿ��� �����Դϴ�. ", Information! )
End If
////////// ���ְ��ɿ���Ȯ��(wf_ordervalid)���� ������ Messgaeó����
Return 1 

//	����
RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

// ���� �޼��� ó��
If	ls_message = 'summaryUpdate_Err' Then
	MessageBox("�԰����", "�԰� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err'Then
	MessageBox("�԰����", "�԰��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'partkbhis_Err' Then
	Messagebox("�԰����", "������ History������ �����߽��ϴ�.", StopSign!)
ElseIf ls_message = 'INCOME_INTERFACE_Err' Then
	MessageBox("�԰����", "�԰�Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
////////// ���ְ��ɿ���Ȯ��(wf_ordervalid)���� ������ Messgaeó����
ElseIF ls_message = 'useFlag_Err' Then
	MessageBox("�԰�/���ֽ���", "���� ����ߴܵ� �����Դϴ�. ~r~n" + &
	                        	 "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
ElseIf ls_message = 'XPAY_Err' Then
	MessageBox("�԰�/���ֽ���", "���������� �������� ���� ǰ���̹Ƿ� ���ְ� �Ұ����մϴ�. ~r~n" + &
	                        	 "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
ElseIf ls_message = 'Planner_Err' Then
	MessageBox("�԰�/���ֽ���", "���Ŵ���ڰ� ������������ ǰ���̹Ƿ� ���ְ� �Ұ����մϴ�. ~r~n" + &
	                        	 "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
////////// ���ְ��ɿ���Ȯ��(wf_ordervalid)���� ������ Messgaeó����
////////// ���ְ��(f_pisr_ordercalc)���� ������ Messgaeó����
//ElseIf ls_message = 'ordercalc_Err' Then
//	MessageBox("�԰�/���ֽ���", "���ְ���� ���з� ���� �԰��۾��� ó���� �� �����ϴ�. ~r~n" + &
//	                        	 "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
ElseIf ls_message = "WorkCalendar_Err" Then
	MessageBox("�԰�/���ֽ���", "���� Work Calendar�� �غ���� �ʾҽ��ϴ�.", Information!)
ElseIf ls_message = "OrderTime_Err" Then
	MessageBox("�԰�/���ֽ���" , "���ֽð� ��꿡 �����߽��ϴ�." , StopSign! )
ElseIf ls_message = "KBStatus_Err" Then
	MessageBox("�԰�/���ֽ���" , "�������� ������ ���������� �дµ� �����Ͽ����ϴ�." , StopSign! )
ElseIf ls_message = "ForecastTime_Err" Then
	MessageBox("�԰�/���ֽ���" , "���Կ����ð� ��꿡 �����߽��ϴ�." , StopSign! )
////////// ���ְ��(f_pisr_ordercalc)���� ������ Messgaeó����
ElseIf ls_message = 'setorder_Err' Then
	MessageBox("�԰�/���ֽ���", "�������������� ���з� ���� �԰��۾��� ó���� �� �����ϴ�. ~r~n" + &
	                        	 "�԰�ó��ȭ�鿡�� �԰��۾��� ó���Ͻñ� �ٶ��ϴ�.", Information! )
ElseIf ls_message = 'summaryUpdate_Err1' Then
	MessageBox("�԰�/���ֽ���", "���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err2' Then
	MessageBox("�԰�/���ֽ���", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'TMSTPARTEDIT_Err' Then
	MessageBox("�԰�/���ֽ���", '���� �ð� ����� �ùٸ��� �ʽ��ϴ�.', StopSign!)
ElseIf ls_message = 'lasteditUpdate_Err' Then
	MessageBox("�԰�/���ֽ���", "������ ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'orderseq_Err' Then
	MessageBox("�԰�/���ֽ���", "��������ȭ��ȣ�� �������� ���Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'orderseqUpdate_Err' Then
	MessageBox("�԰�/���ֽ���", "��������ȭ��ȣ�� �ùٷ� ��ϵ��� �ʾҽ��ϴ�.", StopSign! )
ElseIf ls_message = 'ThisUpdate_Err' Then
	MessageBox("�԰�/���ֽ���", "���ְ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'ORDER_INTERFACE_Err' Then
	MessageBox("�԰�/���ֽ���", "����Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
Else
	MessageBox("�԰�/���ֽ���", "�԰�/����ó���� �����Ͽ����ϴ�.", StopSign! )
End If

return -1

end event

event type integer ue_cancelsave();////////////////////////////////////////////////
//		���ְ��� ���(����)
////////////////////////////////////////////////
String	ls_suppCode, ls_itemCode
String	ls_orderdate, ls_forecastdate
Long		ll_Row, ll_Qty, ll_qtySum
DateTime	ldt_orderTime, ldt_forecastTime
String	ls_changeflag 
String	ls_message = ''

//String	ls_compMonth, ls_compMonth2
//ls_compMonth	= left(is_applydate, 7)

this.AcceptText()

ll_Row			= this.GetRow()
ls_suppCode		= Upper(this.GetItemString(ll_Row	, 'suppliercode'))
ls_itemCode		= Upper(this.GetItemString(ll_Row	, 'itemcode'))
//ls_orderdate		= this.GetItemString(ll_Row	, 'partorderdate')
//ls_forecastdate	= this.GetItemString(ll_Row	, 'partforecastdate')
ldt_orderTime		= this.GetItemDateTime(ll_Row	, 'partordertime')
ldt_forecastTime	= this.GetItemDateTime(ll_Row	, 'partforecasttime')
ls_orderdate		= left(String(ldt_orderTime	, "yyyy.mm.dd hh:mm"),10)
ls_changeflag		= this.GetItemString(ll_Row	, 'orderchangeflag')
If ls_changeflag  = 'Y' Then	//���Կ������� ������ ���
	ldt_forecastTime= this.GetItemDateTime(ll_Row, 'changeforecasttime')
End IF	
ls_forecastdate	= left(String(ldt_forecastTime, "yyyy.mm.dd hh:mm"),10)
ll_Qty				= this.GetItemNumber(ll_Row	, 'rackqty')

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	���ּ��� Summary����
dw_summary.SetTransObject(Sqlpis)				
If dw_summary.Retrieve(ls_orderdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err'
//	MessageBox("������ҿ���", "���� Summary������ ���� ���߽��ϴ�.", StopSign! )
	Goto RollBack_			
End If
//�� �������ڸ� ������� �ʰ� �ǽð� �����ϱ�� ��( 2002.10.31 )
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
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partorderqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partorderqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//���� Summary
If dw_summary.Update() = -1 Then 
	ls_message = 'summaryUpdate_Err'
//	MessageBox("���ֿ���", "���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//���Կ������� Summary����
dw_summary.SetTransObject(Sqlpis)			
If dw_summary.Retrieve(ls_forecastdate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
	ls_message = 'summaryRetrieve_Err'
//	MessageBox("������ҿ���", "���Կ��� Summary������ ���� ���߽��ϴ�.", StopSign! )
	Goto RollBack_			
End If
//ls_compMonth2 = left( ls_forecastdate, 7 )	//���Կ������ؿ�
//If ls_compMonth > ls_compMonth2 Then
//	dw_summary.SetTransObject(Sqlpis)			
//	If dw_summary.Retrieve(is_applydate, istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_itemCode) = 0 then
//		dw_summary.ReSet();	dw_summary.InsertRow(0)
//		dw_summary.SetItem( 1, 'applydate'		, ls_forecastdate )
//		dw_summary.SetItem( 1, 'areacode'		, istr_partkb.areacode )
//		dw_summary.SetItem( 1, 'divisioncode'	, istr_partkb.divcode )
//		dw_summary.SetItem( 1, 'suppliercode'	, ls_suppCode )
//		dw_summary.SetItem( 1, 'itemcode'		, ls_itemCode )
//		dw_summary.SetItem( 1, 'lastemp'			, 'Y' )	// Interface Flag Ȱ��
//		dw_summary.SetItem( 1, 'lastdate'		, idt_nowtime )
//	End If
//End If
ll_qtySum = dw_summary.GetItemNumber( 1, 'partforecastqty' )
ll_qtySum = ll_qtySum - ll_Qty
dw_summary.SetItem( 1, 'partforecastqty'	, ll_qtySum )
dw_summary.SetItem( 1, 'lastemp'				, 'Y' )	// Interface Flag Ȱ��
dw_summary.SetItem( 1, 'lastdate'			, idt_nowtime )

dw_summary.SetTransObject(Sqlpis)						//���Կ��� Summary
If dw_summary.Update() = -1 Then	
	ls_message = 'summaryUpdate_Err1'
//	MessageBox("���ֿ���", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

/////////////////////////////////////////////////
//		HOST ����Ÿ���� �ڷ����
/////////////////////////////////////////////////
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
	ls_message = 'INTERFACE_Err'
//	MessageBox("���ֿ���", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If
//

//	�������ǻ�������
If wf_cancelset() = -1 Then 
	ls_message = 'Update_Err'
	Goto RollBack_			
End IF

this.SetTransObject(Sqlpis)								//���ǻ���
If This.Update() = -1 Then
	ls_message = 'Update_Err'
//	MessageBox("���ֿ���", "������Ұ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
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
	MessageBox("������ҿ���", "���� Summary������ ���� ���߽��ϴ�.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err' Then
	MessageBox("������ҿ���", "���� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'INTERFACE_Err' Then
	MessageBox("������ҿ���", "Interface ���� ������ �����Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'Update_Err' Then
	MessageBox("������ҿ���", "������Ұ��� ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
ElseIf ls_message = 'summaryUpdate_Err1' Then
	MessageBox("������ҿ���", "���Կ��� Summary ���忡�� ������ �߻��Ͽ����ϴ�.", StopSign! )
Else 
	MessageBox("������ҿ���", "�������ó���� �����Ͽ����ϴ�.", StopSign! )
End If

return -1

end event

event clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1

end event

type dw_pisr090b_02 from u_vi_std_datawindow within w_pisr090c
integer x = 18
integer y = 1076
integer width = 3584
integer height = 812
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pisr090b_02"
end type

event clicked;call super::clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1

end event

type dw_scan from datawindow within w_pisr090c
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

type dw_summary from datawindow within w_pisr090c
integer x = 750
integer y = 1024
integer width = 832
integer height = 848
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "���Ǽ��� Summary"
string dataobject = "d_pisr110b_sum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_lastedit from datawindow within w_pisr090c
integer x = 1586
integer y = 1024
integer width = 645
integer height = 748
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "�����������������"
string dataobject = "d_pisr110b_last"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_pisr090c
integer x = 1312
integer y = 72
integer width = 690
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
string text = "�԰��ù��ֵ��"
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

dw_pisr090b_01.Reset()
dw_pisr090b_01.SetTransObject(sqlpis)
dw_pisr090b_01.InsertRow(1)

dw_pisr090b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type rb_2 from radiobutton within w_pisr090c
integer x = 2025
integer y = 72
integer width = 457
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
string text = "�������"
end type

event clicked;
rb_1.Weight = 400
rb_2.Weight = 700

dw_pisr090b_01.Reset()
dw_pisr090b_01.SetTransObject(sqlpis)
dw_pisr090b_01.InsertRow(1)

dw_pisr090b_02.Reset()

is_partkbno = is_Null
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type pb_1 from picturebutton within w_pisr090c
integer x = 2555
integer y = 64
integer width = 489
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
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

type dw_orderseq from datawindow within w_pisr090c
integer x = 2235
integer y = 1024
integer width = 626
integer height = 736
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "���������ȣ����"
string dataobject = "d_pisr_orderseq"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_pisr090c
integer x = 3063
integer y = 64
integer width = 489
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
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

type gb_3 from groupbox within w_pisr090c
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

type gb_2 from groupbox within w_pisr090c
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

type gb_scan from groupbox within w_pisr090c
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
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisr090c
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

