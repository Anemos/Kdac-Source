$PBExportHeader$w_pisr051b.srw
$PBExportComments$�������� �ϰ� A/S��ȯ
forward
global type w_pisr051b from window
end type
type cb_close from commandbutton within w_pisr051b
end type
type cb_save from commandbutton within w_pisr051b
end type
type cb_view from commandbutton within w_pisr051b
end type
type st_message from statictext within w_pisr051b
end type
type st_sleeping from statictext within w_pisr051b
end type
type st_3 from statictext within w_pisr051b
end type
type st_active from statictext within w_pisr051b
end type
type st_1 from statictext within w_pisr051b
end type
type cb_s_to_a from commandbutton within w_pisr051b
end type
type cb_a_to_s from commandbutton within w_pisr051b
end type
type dw_pisr051b_01 from datawindow within w_pisr051b
end type
type dw_pisr051b_03 from u_vi_std_datawindow within w_pisr051b
end type
type gb_2 from groupbox within w_pisr051b
end type
type dw_pisr051b_02 from u_vi_std_datawindow within w_pisr051b
end type
type gb_1 from groupbox within w_pisr051b
end type
end forward

global type w_pisr051b from window
integer width = 1952
integer height = 1960
boolean titlebar = true
string title = "�������� A/S��ȯ"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event ue_retrieve ( )
cb_close cb_close
cb_save cb_save
cb_view cb_view
st_message st_message
st_sleeping st_sleeping
st_3 st_3
st_active st_active
st_1 st_1
cb_s_to_a cb_s_to_a
cb_a_to_s cb_a_to_s
dw_pisr051b_01 dw_pisr051b_01
dw_pisr051b_03 dw_pisr051b_03
gb_2 gb_2
dw_pisr051b_02 dw_pisr051b_02
gb_1 gb_1
end type
global w_pisr051b w_pisr051b

type variables
str_pisr_partKb 	istr_partKb 
Integer 				il_a_selected, il_s_selected
Long 					il_a_rownum[], il_s_rownum[]
String 				is_icon, is_null, is_shift
Boolean 				ib_ldown1, ib_ldown2, ib_move = False
// Mouse Button Up
Boolean 				ib_action_on_buttonup1 = False
Boolean 				ib_action_on_buttonup2 = False
// for multi-row highlight
Long  				il_LastClickedRow1, il_LastClickedRow2

DataStore 			ids_update, ids_buffer
Boolean 				ib_change, ib_modify

Datetime 			idt_null 
end variables

forward prototypes
public subroutine wf_dragicon_stop ()
public subroutine wf_move_kb (datawindow fdw_from, datawindow fdw_to)
public function integer wf_changekb (datawindow fdw_from, datawindow fdw_to)
end prototypes

event ue_retrieve();
dw_pisr051b_02.SetTransObject(sqlpis)
dw_pisr051b_03.SetTransObject(sqlpis)
dw_pisr051b_02.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, istr_partkb.itemCode)
dw_pisr051b_03.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, istr_partkb.itemCode)

ids_update.SetTransObject(sqlpis)
ids_update.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, istr_partkb.itemCode)
ids_buffer.Reset()

end event

public subroutine wf_dragicon_stop ();If dw_pisr051b_02.DragIcon <> 'StopSign!' Then
	dw_pisr051b_02.Dragicon = 'StopSign!'
End If
If dw_pisr051b_03.DragIcon <> 'StopSign!' Then
	dw_pisr051b_03.Dragicon	= 'StopSign!'
End If

//If st_message.Text	<> " �̰����δ� �ű�� �����ϴ�." Then
//	st_message.Text	= " �̰����δ� �ű�� �����ϴ�."
//End If

Return
end subroutine

public subroutine wf_move_kb (datawindow fdw_from, datawindow fdw_to);Long ll_selected_count, ll_selected_rows[], ll_rowcount 
Integer I 

SetPointer(HourGlass!)

st_message.Text = " ���� Status�� ��ȭ���Դϴ�."

ll_selected_count = f_pisr_return_selected (fdw_from, ll_selected_rows)
If ll_selected_count = 0 Then Return

fdw_from.SetRedraw(False)
fdw_to.SetRedraw(False)

If fdw_from = dw_pisr051b_02 Then
	For i = ll_selected_count To 1 Step -1
		fdw_from.RowsMove(ll_selected_rows[i], ll_selected_rows[i], Primary!, fdw_to, 1, Primary!)
	Next
Else
	For i = ll_selected_count To 1 Step -1
		fdw_from.RowsMove (ll_selected_rows[i], ll_selected_rows[i], Primary!, fdw_to, 1, primary!)
	Next
End If

fdw_to.Sort()
fdw_from.SetRedraw(True)
fdw_to.SetRedraw(True)

ll_rowcount = fdw_to.RowCount()
If Not cb_save.Enabled Then 
	cb_save.Enabled		= True
End If
ib_change			= True
st_active.Text		= '0'
st_sleeping.Text	= '0'
ib_move	= True
st_message.Text	= ' �����ư�� Ŭ���Ͽ� ���������� �����ϼ���'
Return
end subroutine

public function integer wf_changekb (datawindow fdw_from, datawindow fdw_to);/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		: wf_move_kb
////	Access		: protected
////	Arguments	: DataWindow fdw_from		Source DataWindow for Emp Move
//// 				  DataWindow fdw_to			Target DataWindow for Emp Move
////	Returns		: none
////	Description	: ������ ���¸� Active <=> Sleeping ��ȯ�Ѵ�.
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Lee Jong-il
//// Coded Date	: 1998. 05. 29
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Long		ll_find, i, ll_selected_rows[], 	ll_selected_count, ll_rowcount
//String	ls_kbno, ls_gubun
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Store the row numbers of the selected rows in an array
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SetPointer(HourGlass!)
//
//st_message.Text = " ���� Status�� ��ȭ���Դϴ�."
//
//ll_selected_count = f_return_selected (fdw_from, ll_selected_rows)
//If ll_selected_count = 0 Then Return
//
//fdw_from.SetRedraw(False)
//fdw_to.SetRedraw(False)
//
//// Sleeping => Active ��ȯ��
//// ActiveGubun('S' => 'A'), LastEmp(gs_empcode), Lastdate(datetime(Today(), now()))
//If fdw_from = dw_active Then
//	For i = ll_selected_count To 1 Step -1
//		ls_gubun	= fdw_from.GetItemString(ll_selected_rows[i], 'StatusCode')
//
//	// ���ʿ� Active=>Sleeping ��ȯ�� ����ϴ� ��츦 ����ؼ� Buffer�� Data�� Copy�� �д�.
//		If Not IsNull(ls_gubun) Then
//			fdw_from.RowsCopy(ll_selected_rows[i], ll_selected_rows[i], Primary!, ids_buffer, 1, Primary!)
//			fdw_from.RowsMove(ll_selected_rows[i], ll_selected_rows[i], Primary!, fdw_to, 1, Primary!)
//			// Active ������ ������ �ʱ�ȭ �Ѵ�.
//			
//			fdw_to.SetItem(1, 'ActiveGubun',		'S')
//			fdw_to.SetItem(1, 'StatusCode', 		is_null)
//			fdw_to.SetItem(1, 'ASGubun',			'N')
//			fdw_to.SetItem(1, 'ReleaseGubun',	is_null)
//			fdw_to.SetItem(1, 'CancelGubun',		'N')
//			fdw_to.SetItem(1, 'PrdShift',			is_shift)
//			fdw_to.SetItem(1, 'PrdWorkCenter',	is_workcenter)
//			fdw_to.SetItem(1, 'PrdLineCode',		is_linecode)
//			fdw_to.SetItem(1, 'ApplyDate',		is_null)
//			fdw_to.SetItem(1, 'ReleaseTime',		idt_null)
//			fdw_to.SetItem(1, 'StartTime',		idt_null)
//			fdw_to.SetItem(1, 'EndTime',			idt_null)
//			fdw_to.SetItem(1, 'StockTime',		idt_null)
//			fdw_to.SetItem(1, 'ShipTime',			idt_null)
//			fdw_to.SetItem(1, 'BackTime',			idt_null)
//			fdw_to.SetItem(1, 'LotNo',				is_null)
//			fdw_to.SetItem(1, 'LastEmp',			gs_empcode)
//			fdw_to.SetItem(1, 'LastDate',			f_get_nowtime())
//		// ���� Sleeping ���¿� �ִٰ� Active�� �ű��� ����� ���
//		// LastEmp�� ���� ����, LastDate�� SetItem�� �����ص� ū �ǹ̰� ����.
//		Else
//			fdw_from.RowsMove(ll_selected_rows[i], ll_selected_rows[i], Primary!, fdw_to, 1, Primary!)
//			fdw_to.SetItem(1, 'ActiveGubun', 'S')
//		End If
//	Next
//Else
//	For i = ll_selected_count To 1 Step -1
//		ls_kbno	= fdw_from.GetItemString(ll_selected_rows[i], 'KBNo')
//		ll_find		= ids_buffer.Find("KBNo = '" + ls_kbno + "'", 1, ids_buffer.RowCount())
//		
//		// Active���� Sleeping���� �ű��� �ٽ� Active�� �ű� ���
//		If ll_find > 0 Then
//			ids_buffer.RowsMove (ll_find, ll_find, Primary!, fdw_to, 1, primary!)
//			fdw_from.DeleteRow(ll_selected_rows[i])
//		// ���ʿ� Sleeping�� �ִٰ� Active�� ��ȯ�� ���
//		Else
//			fdw_from.RowsMove (ll_selected_rows[i], ll_selected_rows[i], Primary!, fdw_to, 1, primary!)
//			fdw_to.SetItem(1, 'ActiveGubun', 'A')
//			fdw_to.SetItem(1, 'LastEmp', gs_empcode)
//			fdw_to.SetItem(1, 'LastDate', f_get_nowtime())
//		End If
//	Next
//End If
//
//fdw_to.Sort()
//
//fdw_from.SetRedraw(True)
//fdw_to.SetRedraw(True)
//
//ll_rowcount = fdw_to.RowCount()
//If Not pb_save.Enabled Then 
//	pb_save.Enabled		= True
//	p_save.PictureName	= 'e_update.bmp'
//End If
//ib_change			= True
//st_active.Text		= '0'
//st_sleeping.Text	= '0'
//ib_move	= True
//st_message.Text	= ' �����ư�� Ŭ���Ͽ� ���������� �����ϼ���'
Return 1
end function

on w_pisr051b.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_view=create cb_view
this.st_message=create st_message
this.st_sleeping=create st_sleeping
this.st_3=create st_3
this.st_active=create st_active
this.st_1=create st_1
this.cb_s_to_a=create cb_s_to_a
this.cb_a_to_s=create cb_a_to_s
this.dw_pisr051b_01=create dw_pisr051b_01
this.dw_pisr051b_03=create dw_pisr051b_03
this.gb_2=create gb_2
this.dw_pisr051b_02=create dw_pisr051b_02
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_save,&
this.cb_view,&
this.st_message,&
this.st_sleeping,&
this.st_3,&
this.st_active,&
this.st_1,&
this.cb_s_to_a,&
this.cb_a_to_s,&
this.dw_pisr051b_01,&
this.dw_pisr051b_03,&
this.gb_2,&
this.dw_pisr051b_02,&
this.gb_1}
end on

on w_pisr051b.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_view)
destroy(this.st_message)
destroy(this.st_sleeping)
destroy(this.st_3)
destroy(this.st_active)
destroy(this.st_1)
destroy(this.cb_s_to_a)
destroy(this.cb_a_to_s)
destroy(this.dw_pisr051b_01)
destroy(this.dw_pisr051b_03)
destroy(this.gb_2)
destroy(this.dw_pisr051b_02)
destroy(this.gb_1)
end on

event open;istr_partkb = message.PowerObjectParm 

f_pisc_win_center_move(This)

ids_update	= Create DataStore
ids_buffer	= Create DataStore
ids_update.DataObject	= 'd_pisr051b_05'
ids_buffer.DataObject	= 'd_pisr051b_04'

//MessageBox( "test", istr_partkb.areaCode + ',' + istr_partkb.divCode+','+istr_partkb.suppCode+','+istr_partkb.itemCode )

dw_pisr051b_01.SetTransObject(sqlpis)
dw_pisr051b_01.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, istr_partkb.itemCode) 

cb_view.TriggerEvent("clicked")
cb_view.SetFocus()

ib_modify	= False

end event

event closequery;integer ls_Net

If ib_change Then
	ls_Net = MessageBox("Ȯ�ο�û", "����� Data�� �����Ͻðڽ��ϱ� ?", &
			Exclamation!, YesNo!, 2)
	IF ls_Net = 1 THEN
		cb_save.TriggerEvent(Clicked!)
		Return 1 
	ELSE
		Return 0
	END IF
End If 
end event

type cb_close from commandbutton within w_pisr051b
integer x = 1609
integer y = 1496
integer width = 293
integer height = 216
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event dragwithin;wf_dragicon_stop()
end event

event clicked;If ib_modify Then
	CloseWithReturn(Parent, 'CHANGE')
Else
	CloseWithReturn(Parent, 'CANCEL')
End If

end event

type cb_save from commandbutton within w_pisr051b
integer x = 1609
integer y = 1264
integer width = 293
integer height = 216
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event dragwithin;wf_dragicon_stop()
end event

event clicked;Long i, ll_rowcount
Integer li_chk
String ls_kbNo 

st_message.Text	= ' ���� Status ���� ������ �����մϴ�.'
sqlpis.AutoCommit = False
SetPointer(HourGlass!)

For i = 1 To dw_pisr051b_02.RowCount()
	ls_kbNo = dw_pisr051b_02.GetItemString(I, "partkbno")
	If f_pisr_chgkbactive(ls_kbNo, 'A') = -1 Then Goto RollBack_
Next

For i = 1 To dw_pisr051b_03.RowCount()
	ls_kbNo = dw_pisr051b_03.GetItemString(I, "partkbno")
	If f_pisr_chgkbactive(ls_kbNo, 'S') = -1 Then Goto RollBack_
Next

//f_pisr_sqlchkopt(sqlpis, True) 
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
st_message.Text	= "�ش� ����(��)�� Active/Sleeping ��ȯ�� �Ϸ�Ǿ����ϴ�."
MessageBox("����Ϸ�", "�ش� ����(��)�� Active/Sleeping ��ȯ�۾��� ���������� �����Ͽ����ϴ�.", Information!)
This.Enabled = False; ib_change = False 
ib_modify	= True

Return 

RollBack_:
RollBack Using sqlpis; 
sqlpis.AutoCommit = True 
SetPointer(Arrow!)

st_message.Text	= "����Ÿ���̽��� ������ �����Ͽ����ϴ�."
MessageBox("�������", "�ش� ����(��)�� Active/Sleeping ��ȯ�� �����߽��ϴ�.", StopSign!)

end event

type cb_view from commandbutton within w_pisr051b
integer x = 1609
integer y = 1032
integer width = 293
integer height = 216
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��ȸ"
end type

event dragwithin;wf_dragicon_stop()
end event

event clicked;Parent.TriggerEvent("ue_retrieve")

cb_a_to_s.Enabled		= False
cb_s_to_a.Enabled		= False
st_active.Text			= '0'
st_sleeping.Text		= '0'

cb_save.Enabled		= False

ib_change	= False
st_message.Text	= " ������ �����ϼ���"
end event

type st_message from statictext within w_pisr051b
integer x = 9
integer y = 1744
integer width = 1893
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_sleeping from statictext within w_pisr051b
integer x = 1381
integer y = 1620
integer width = 123
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "0"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisr051b
integer x = 965
integer y = 1628
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���õȰ���:"
boolean focusrectangle = false
end type

type st_active from statictext within w_pisr051b
integer x = 526
integer y = 1620
integer width = 123
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "0"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisr051b
integer x = 110
integer y = 1628
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���õȰ���:"
boolean focusrectangle = false
end type

type cb_s_to_a from commandbutton within w_pisr051b
integer x = 709
integer y = 1040
integer width = 183
integer height = 128
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;wf_move_kb(dw_pisr051b_03, dw_pisr051b_02)

// wf_move_kb ������ Button�� Desable ó���Ѵ�
If dw_pisr051b_03.GetSelectedRow(0) > 0 Then
	Enabled	= True
Else
	Enabled = False
End If

cb_save.SetFocus()
end event

event dragwithin;wf_dragicon_stop()
end event

type cb_a_to_s from commandbutton within w_pisr051b
integer x = 709
integer y = 856
integer width = 183
integer height = 128
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;wf_move_kb(dw_pisr051b_02, dw_pisr051b_03)

// wf_move_kb ������ Button�� Desable ó���Ѵ�
If dw_pisr051b_02.GetSelectedRow(0) > 0 Then
	Enabled	= True
Else
	Enabled = False
End If

cb_save.SetFocus()
end event

event dragwithin;wf_dragicon_stop()
end event

type dw_pisr051b_01 from datawindow within w_pisr051b
integer y = 8
integer width = 1920
integer height = 468
integer taborder = 10
string title = "none"
string dataobject = "d_pisr051b_01"
boolean border = false
boolean livescroll = true
end type

event dragwithin;wf_dragicon_stop()
end event

event itemchanged;String ls_itemCode 
Integer li_itemChk 

ls_itemCode = data

  SELECT count(ItemCode) INTO :li_itemChk FROM TMSTPARTKB  
   WHERE ( AreaCode 		= :istr_partkb.areaCode ) AND  
         ( DivisionCode = :istr_partkb.divCode ) AND  
         ( SupplierCode = :istr_partkb.suppCode ) AND  
         ( ItemCode 		= :ls_itemCode ) 
	USING	sqlpis	;

If li_itemChk = 0 Then 
	MessageBox("�Է¿���", "�Է��Ͻ� ǰ���� �ش� ��ü�� �������� �ʴ� ǰ���Դϴ�.", Information!)
	This.SetItem(row, "tmstpartkb_itemcode", istr_partkb.itemCode)
	Return 
End If 

This.AcceptText()
istr_partkb.itemCode = ls_itemCode 


dw_pisr051b_01.SetTransObject(sqlpis)
dw_pisr051b_01.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, istr_partkb.itemCode) 
cb_view.TriggerEvent("clicked")
cb_view.SetFocus()

end event

event retrievestart;DataWindowChild ldwc

If This.GetChild('tmstpartkb_divisioncode_1', ldwc) <> -1 Then
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
	If ldwc.Retrieve( g_s_empno, istr_partkb.areaCode, istr_partkb.divCode) = 0 Then ldwc.InsertRow(1)
End If 

If This.GetChild('tmstpartkb_suppliercode_1', ldwc) <> -1 Then
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
	If ldwc.Retrieve(istr_partkb.suppCode) = 0 Then ldwc.InsertRow(1)
End If 

If This.GetChild('itemname', ldwc) <> -1 Then
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
	If ldwc.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode) = 0 Then ldwc.InsertRow(1)
End If 

If This.GetChild('tmstpartkb_parttype_1', ldwc) <> -1 Then
	ldwc.ScrollToRow(ldwc.InsertRow(0))
End If 

end event

type dw_pisr051b_03 from u_vi_std_datawindow within w_pisr051b
event ue_post_click pbm_custom01
integer x = 919
integer y = 604
integer width = 635
integer height = 988
integer taborder = 80
string dataobject = "d_pisr051b_03"
boolean vscrollbar = true
end type

event ue_post_click;il_s_selected	= f_pisr_return_selected(This, il_s_rownum[])
st_sleeping.Text	= String(il_s_selected)

Long ll_selRow[] 

If f_pisr_return_selected(This, ll_selRow) > 0 Then
	cb_s_to_a.Enabled	= True
Else
	cb_s_to_a.Enabled = False
End If

end event

event clicked;call super::clicked;Integer 	li_i
Long 		ll_RowCnt

If row = 0 Then
	ll_RowCnt = this.Rowcount()
	FOR li_i = ll_RowCnt TO 1 STEP -1
		this.SelectRow(li_i,TRUE)
	NEXT
End If

PostEvent('ue_post_click')
end event

event getfocus;call super::getfocus;// Focus�� ��ġ������ dw_2�� Selected Row�� �ʱ�ȭ�Ѵ�.
dw_pisr051b_02.SelectRow(0, False)
cb_a_to_s.Enabled = False 

st_active.Text			= '0'
il_LastClickedRow1	= 0

If st_message.Text	<> " Active ��ȯ�� ������ �����ϼ���" Then
	If RowCount() > 0 Then
		st_message.Text	= " Active ��ȯ�� ������ �����ϼ���"
	End If
End If
end event

event retrieveend;Boolean lb_Chk 

If rowcount > 0 Then lb_Chk = True 
cb_s_to_a.Enabled = lb_Chk 
end event

event ue_key;call super::ue_key;// ���� ������ User�� Group�� �߰��Ѵ�.
// Member�� �̵��ϴ� �Լ��� �����Ѵ�.
// SelectedRow()�� ������ ��쿡�� �����Ѵ�.
If KeyDown (keyLeftArrow!) Then
	If This.GetSelectedRow(0) > 0 Then
		wf_move_kb(This, dw_pisr051b_02)
	End If
	// wf_move_kb ������ Button�� Desable ó���Ѵ�
	If dw_pisr051b_02.GetSelectedRow(0) > 0 Then
		cb_s_to_a.Enabled	= True
	Else
		cb_s_to_a.Enabled = False
	End If
End If
end event

type gb_2 from groupbox within w_pisr051b
integer x = 901
integer y = 516
integer width = 686
integer height = 1196
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "Sleeping����"
borderstyle borderstyle = stylelowered!
end type

type dw_pisr051b_02 from u_vi_std_datawindow within w_pisr051b
event ue_post_click pbm_custom01
integer x = 37
integer y = 604
integer width = 635
integer height = 988
integer taborder = 40
string dataobject = "d_pisr051b_02"
boolean vscrollbar = true
end type

event ue_post_click;il_a_selected	= f_pisr_return_selected(This, il_a_rownum[])
st_active.Text	= String(il_a_selected)
Long ll_selRow[] 

If f_pisr_return_selected(This, ll_selRow) > 0 Then
	cb_a_to_s.Enabled	= True
Else
	cb_a_to_s.Enabled = False
End If

end event

event clicked;call super::clicked;Integer 	li_i
Long 		ll_RowCnt

If row = 0 Then
	ll_RowCnt = this.Rowcount()
	FOR li_i = ll_RowCnt TO 1 STEP -1
		this.SelectRow(li_i,TRUE)
	NEXT
End If

PostEvent('ue_post_click')
end event

event getfocus;call super::getfocus;// Focus�� ��ġ������ dw_sleeping�� Selected Row�� �ʱ�ȭ�Ѵ�.
dw_pisr051b_03.SelectRow(0, False)
cb_s_to_a.Enabled = False 

st_sleeping.Text		= '0'

If st_message.Text	<> " Sleeping ��ȯ�� ������ �����ϼ���" Then
	If RowCount() > 0 Then
		st_message.Text	= " Sleeping ��ȯ�� ������ �����ϼ���"
	End If
End If
end event

event losefocus;st_message.Text	= ""
end event

event retrieveend;call super::retrieveend;Boolean lb_Chk 

If rowcount > 0 Then lb_Chk = True 
cb_a_to_s.Enabled = lb_Chk 
end event

event ue_key;call super::ue_key;// ���� ������ User�� �����Ѵ�.
// Member�� �̵��ϴ� �Լ��� �����Ѵ�.
// SelectedRow()�� ������ ��쿡�� �����Ѵ�.
If KeyDown (keyRightArrow!) Then
	If This.GetSelectedRow(0) > 0 Then
		wf_move_kb(This, dw_pisr051b_03)
	End If
	
	// wf_move_kb ������ Button�� Desable ó���Ѵ�
	If dw_pisr051b_02.GetSelectedRow(0) > 0 Then
		cb_a_to_s.Enabled	= True
	Else
		cb_a_to_s.Enabled = False
	End If
End If
end event

type gb_1 from groupbox within w_pisr051b
integer x = 14
integer y = 516
integer width = 686
integer height = 1196
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "Active����"
borderstyle borderstyle = stylelowered!
end type

