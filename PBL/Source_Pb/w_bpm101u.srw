$PBExportHeader$w_bpm101u.srw
$PBExportComments$��ȭ������ ȯ������
forward
global type w_bpm101u from w_origin_sheet01
end type
type dw_11 from datawindow within w_bpm101u
end type
type dw_10 from datawindow within w_bpm101u
end type
type pb_1 from picturebutton within w_bpm101u
end type
type cb_3 from commandbutton within w_bpm101u
end type
type cb_1 from commandbutton within w_bpm101u
end type
end forward

global type w_bpm101u from w_origin_sheet01
integer width = 4681
integer height = 2752
dw_11 dw_11
dw_10 dw_10
pb_1 pb_1
cb_3 cb_3
cb_1 cb_1
end type
global w_bpm101u w_bpm101u

type variables
String  is_Xplant, is_Div

Boolean ib_Insert = False

// Multi Select��~
Long il_preRow

// DataWindowChild
DataWindowChild idwc_xplant
DataWindowChild idwc_div


end variables

forward prototypes
public subroutine wf_rgbclear ()
public subroutine wf_click_retrieve (long al_row)
public function integer wf_stcd_chk (integer ll_tabno)
end prototypes

public subroutine wf_rgbclear ();
end subroutine

public subroutine wf_click_retrieve (long al_row);




end subroutine

public function integer wf_stcd_chk (integer ll_tabno);string ls_xyear, ls_stcd, ls_stcd1

//Choose case ll_tabno
//	case 1
	IF dw_10.accepttext() = -1  THEN
		MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
		uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
		Return -1
	END IF
	
	ls_xyear = trim(dw_10.object.xyear[1])
	IF ls_xyear = ''  THEN
		MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
		uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
		Return -1
	END IF
	
	select coalesce(max(ingflag),''),coalesce(max(taskstatus),'') 
		into :ls_stcd, :ls_stcd1
	from pbbpm.bpm519
	where comltd = '01'
	and   xyear = :ls_xyear
	and   seqno = '100';  //��ü���´� �ƹ��ڷᳪ �����͵� ��.
	
	IF ls_stcd <> 'G'  THEN
		MessageBox('�۾��Ұ�',ls_xyear + '�� �����ȹ��ü �۾��� ����Ǿ����ϴ�!')
		uo_status.st_message.text = ls_xyear + '�� �����ȹ��ü �۾��� ����Ǿ����ϴ�!'
		Return -1
	END IF
	IF ls_stcd1 <> 'G'  THEN
		MessageBox('�۾��Ұ�',ls_xyear + '�� �����ȹ �ش��۾��� �̹� Ȯ���Ǿ����ϴ�!')
		uo_status.st_message.text = ls_xyear + '�� �����ȹ �ش��۾��� �̹� Ȯ���Ǿ����ϴ�!'
		Return -1
	END IF
//case 2
//	IF idw_20.accepttext() = -1  THEN
//		MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
//		uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
//		Return -1
//	END IF
//	
//	ls_xyear = trim(idw_20.object.xyear[1])
//	IF ls_xyear = ''  THEN
//		MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
//		uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
//		Return -1
//	END IF
//	
//	select coalesce(max(ingflag),''),coalesce(max(taskstatus),'') 
//		into :ls_stcd, :ls_stcd1
//	from pbbpm.bpm519
//	where comltd = '01'
//	and   xyear = :ls_xyear
//	and   seqno = '160';  //��ü���´� �ƹ��ڷᳪ �����͵� ��.
//	
//	IF ls_stcd <> 'G'  THEN
//		MessageBox('�۾��Ұ�',ls_xyear + '�� �����ȹ��ü �۾��� ����Ǿ����ϴ�!')
//		uo_status.st_message.text = ls_xyear + '�� �����ȹ��ü �۾��� ����Ǿ����ϴ�!'
//		Return -1
//	END IF
//	IF ls_stcd1 <> 'P'  THEN
//		MessageBox('�۾��Ұ�',ls_xyear + '�� �����ȹ ǰ��⺻���� �����۾��� Ȯ���Ǿ����ϴ�!')
//		uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��⺻���� �����۾��� Ȯ���Ǿ����ϴ�!'
//		Return -1
//	END IF
//End choose
return 1
end function

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////
// * ȯ�� ��� *      2003.09.05.  ������
///////////////////////////////////////////////////////////////////////////////////////////

i_b_insert = True  // �Է°���.
i_b_dprint = True  // ȭ���μ� ����.

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

on w_bpm101u.create
int iCurrent
call super::create
this.dw_11=create dw_11
this.dw_10=create dw_10
this.pb_1=create pb_1
this.cb_3=create cb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_11
this.Control[iCurrent+2]=this.dw_10
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_1
end on

on w_bpm101u.destroy
call super::destroy
destroy(this.dw_11)
destroy(this.dw_10)
destroy(this.pb_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event ue_insert;
// �ʼ��Է��׸� Check...
dw_10.SetItemStatus( 1, 0, Primary!, DataModified! )
If f_Mandatory_Chk(dw_10) = -1 Then 
	i_n_erreturn = -1
	Return  
End If

String ls_year, ls_revno

ls_year = trim(dw_10.Object.xyear[1])
ls_revno = trim(dw_10.Object.revno[1])

if g_s_empno <> '970077' then
	IF wf_stcd_chk(1) = -1  THEN  //����Ȯ��
		Return
	END IF
end if

dw_11.SetReDraw(False)

If ib_insert = False then
   dw_11.Reset()
End if

dw_11.InsertRow( 0 )

dw_11.SetItemStatus(1, 0, Primary!, NotModified!)

dw_11.Object.curr.BackGround.Color = 15780518  // �ϴû�
dw_11.Object.exch.BackGround.Color = 15780518  // �ϴû�

f_Color_Protect( dw_11 ) 

dw_11.SetColumn( 'curr' )
dw_11.SetFocus()

dw_11.SetReDraw(True)

ib_Insert = True
i_b_save	 =	True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;Choose Case f_dw_status(dw_11, i_s_level)	
	Case 1 // ó�����δ� �۾� ����.
		This.TriggerEvent('ue_save')
		
		If i_n_erreturn = -1  Then
			uo_status.st_message.text = f_message("U040") // ������ �� �����ϴ�.
			Return 1
		End If
	Case 3 // ���.
		Return 1
End Choose

dw_10.SetItemStatus(1, 0, Primary!, DataModified!)
If f_mandatory_chk( dw_10 ) = -1 Then
	Return
End If

String ls_year, ls_revno

ls_year = Trim(dw_10.Object.xyear[1])
ls_revno = Trim(dw_10.Object.revno[1])

SetPointer(HourGlass!)

Integer li_Rcnt

li_Rcnt = dw_11.Retrieve( ls_year, ls_revno )

If li_Rcnt = 0 Then
	
	uo_status.st_message.Text = f_message("I020")    // ��ȸ�� �ڷᰡ �����ϴ�.
	i_b_save = False
	
Else
	
	dw_11.Object.curr.BackGround.Color = 536870912  // ȸ��
	dw_11.Object.exch.BackGround.Color = 536870912  // ȸ��
	f_Color_Protect( dw_11 )
	
	uo_status.st_message.Text = f_message("I010")    // ��ȸ �Ǿ����ϴ�.
	
	ib_insert  = False
	i_b_delete = True
	i_b_save	  = True
	
End If

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)


end event

event ue_save;Int    li_Rtn	 
Long   ll_row, ll_rcnt
String ls_xyear, ls_revno, ls_curr,ls_msg
dec ld_exch


setpointer(hourglass!)
uo_status.st_message.Text = '�ڷ�Ȯ����...'


If f_Mandatory_Chk( dw_10 ) = -1 Then // �ʼ��Է��׸� Check...
	i_n_erreturn = -1
	Return  
End If

If dw_10.AcceptText( ) = -1 Then
	MessageBox("Ȯ��!", "������ ������ ������ �� �����Ͻʽÿ�.", Exclamation!)
	uo_status.st_message.Text = "������ ������ ������ �� �����Ͻʽÿ�."
	Return
End If

ls_xyear = trim(dw_10.Object.xyear[1])
ls_revno = trim(dw_10.Object.revno[1])

IF g_s_empno <> '970077' then 
  if f_bpmstcd_chk('100',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
     MessageBox("Ȯ��!",ls_msg)
	  uo_status.st_message.text = ls_msg
	  Return
  END IF
end if


If dw_11.AcceptText( ) = -1 Then
	MessageBox("Ȯ��!", "������ ������ ������ �� �����Ͻʽÿ�.", Exclamation!)
	uo_status.st_message.Text = "������ ������ ������ �� �����Ͻʽÿ�."
	Return
End If

f_Null_Kill(dw_11)      // NULL ���� Space�� 0���� Setting.
	f_ExtColumn_Set(dw_11)  // ���/���� ����� ��¥, IP/MAC Address Setting.

For ll_row = 1 to dw_11.RowCount()
	
	//dw_11.Object.comltd[ll_row] = g_s_company  // Key Input...(ȸ��)
	dw_11.Object.xyear[ll_row]  = ls_xyear      // Key Input...(�⵵)	
	dw_11.Object.revno[ll_row]  = ls_revno 
	ls_curr = trim(dw_11.object.curr[ll_row])
	
	select count(*) into :ll_rcnt
	from pbbpm.bpm506
	where xyear = :ls_xyear
	and   revno = :ls_revno
	and   curr = :ls_curr;
	if ll_rcnt > 0 then
	//if dw_11.getitemstatus(ll_row,0,Primary!) = Newmodified! then
		dw_11.setitemstatus(ll_row,0,primary!,Datamodified!)
	//end if
   end if
Next

uo_status.st_message.Text = '�ڷ�������...'
li_Rtn = dw_11.Update(True, False)
If li_Rtn = 1 Then
	////���������ȹȯ������
   for ll_row = 1 to dw_11.rowcount()
		 ls_curr = trim(dw_11.object.curr[ll_row])
		 ld_exch = dw_11.object.exch[ll_row]
		 //ld_exch = round(ld_exch,2)
		 select count(*) into :ll_rcnt
		 from  pbsle.sle214
		 where cym = :ls_xyear || :ls_revno
		 and   cur = :ls_curr;
		 if ll_rcnt > 0 then
			update pbsle.sle214
			   set exc = :ld_exch,
				    exc2 = :ld_exch
			where cym = :ls_xyear || :ls_revno
			and   cur = :ls_curr;
		 else
			insert into pbsle.sle214
			(CYM,       CUR,         EXC,            EXTD,   
         INPTID,     INPTDT,      UPDTID,        UPDTDT,   
         IPADDR,     MACADDR,     EXC2  )
			values
			(:ls_xyear || :ls_revno, :ls_curr, :ld_exch,    '',
			:g_s_empno,  :g_s_date,  '',    :g_s_datetime,
			:g_s_ipaddr, :g_s_macaddr,  :ld_exch);
		 end if
	next
	dw_11.ResetUpdate( )
	Commit Using SQLCA ;
	i_n_erreturn = 0
	uo_status.st_message.Text = f_message('U010') // ����Ǿ����ϴ�.	
	
	ib_Insert = False

Else 
	
	RollBack Using SQLCA ;
	i_n_erreturn = -1
	uo_status.st_message.text = f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�. 	
	
End If
SetPointer(arrow!)

end event

event ue_delete;call super::ue_delete;
SetPointer( HourGlass! )


IF wf_stcd_chk(1) = -1  THEN  //����Ȯ��
	Return
END IF

Integer li_SelectedRowCnt


li_SelectedRowCnt = f_Selected_Row( dw_11 )

SetPointer( Arrow! ) 

Integer li_YNC

If li_SelectedRowCnt > 0 Then
	li_YNC = MessageBox('Ȯ��!', '������ ' + String(li_SelectedRowCnt) + '���� ȯ���� �����Ͻðڽ��ϱ�?', &
								Question!, YesNo!, 2)
	
	Integer li_Rtn
	
	If li_YNC = 1 Then
		
		f_Multi_Delete_Row( dw_11 )
		
		li_Rtn = dw_11.Update(True, False)
		
		If li_Rtn = 1 Then
			
			dw_11.ResetUpdate()
			Commit Using SQLCA ;
			
			uo_status.st_message.Text = f_message('D010')  // ���� �Ǿ����ϴ�.
			
		Else
			
			RollBack Using SQLCA ;
			uo_status.st_message.Text = f_message('D020')  // [��������] �����ý��������� �����ٶ��ϴ�.
		
		End If
	End If
Else
	
	MessageBox('Ȯ��!', '������ ȯ���� �����ϴ�.', Exclamation!)
	
End If

end event

type uo_status from w_origin_sheet01`uo_status within w_bpm101u
end type

type dw_11 from datawindow within w_bpm101u
integer x = 23
integer y = 192
integer width = 2030
integer height = 2292
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bpm101u_11"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If Upper(dwo.Type) = 'TEXT' Then
	f_Dw_Sorting( This, dwo )	// Text�� Click�� �� Text�������� ��ȸ DataWindow Sorting.
   Return
End If

If Upper(dwo.Type) <> 'COLUMN' Then Return

f_multi_select_Row(This, Row, il_preRow)
If Row > 0 Then il_preRow = Row

wf_Click_Retrieve( Row )

i_b_delete = True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event constructor;This.SetTransObject( SQLCA )
end event

type dw_10 from datawindow within w_bpm101u
event ue_key_down pbm_dwnkey
integer x = 27
integer y = 8
integer width = 1015
integer height = 168
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm101u_10"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;If key = KeyEnter! Then
	Parent.TriggerEvent('ue_retrieve')
	Return 1
End If
end event

event constructor;
This.InsertRow( 0 )

string ls_xyear
select coalesce(max(xyear || revno),'')
into :ls_xyear
from pbbpm.bpm519;

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)


end event

event itemchanged;Choose Case f_dw_status( dw_11, i_s_level )	
	Case 1 // ó�����δ� �۾� ����.
		This.TriggerEvent('ue_save')
		
		If i_n_erreturn = -1  Then
			uo_status.st_message.text = f_message("U040") // ������ �� �����ϴ�.
			Return 1
		End If
End Choose 

dw_11.SetRedraw( False )
dw_11.Reset( )
dw_11.SetRedraw( True ) 


end event

type pb_1 from picturebutton within w_bpm101u
integer x = 1093
integer y = 24
integer width = 155
integer height = 132
integer taborder = 110
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;If dw_10.AcceptText( ) = -1 Then
	MessageBox("Ȯ��!", "������ ������ ������ �� �����Ͻʽÿ�.", Exclamation!)
	Return
End If

dw_10.SetItemStatus(1, 0, Primary!, DataModified!)
If f_mandantory_chk( dw_10 ) = -1 Then  // �ʼ��Է��׸� check
	Return
End If

f_pur040_GetExcel( dw_11 )
	
i_b_save	  = True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)


		
	

end event

type cb_3 from commandbutton within w_bpm101u
integer x = 1303
integer y = 40
integer width = 361
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ�Ȯ��"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_itnm
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF


IF dw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(dw_10.object.xyear[1])
ls_revno = trim(dw_10.object.revno[1])

IF wf_stcd_chk(1) = -1  THEN  //����Ȯ��
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm506
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','Ȯ���� �ڷᰡ �����ϴ�! Ȯ���ϼ���!')
	uo_status.st_message.text = 'Ȯ���� �ڷᰡ �����ϴ�! Ȯ���ϼ���!'
	Return
end if


li_ok = MessageBox('Ȯ��','Ȯ���մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'C'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '100';

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ�� Ȯ���Ϸ�.'
SetPointer(arrow!)
return

end event

type cb_1 from commandbutton within w_bpm101u
integer x = 1691
integer y = 40
integer width = 361
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "Ȯ�����"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_itnm, ls_msg
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF


IF dw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(dw_10.object.xyear[1])
ls_revno = trim(dw_10.object.revno[1])

IF f_bpmstcd_chk1('100',ls_xyear, ls_revno, ls_msg) = -1  THEN  //����Ȯ��
   MessageBox('�۾��Ұ�',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF


li_ok = MessageBox('Ȯ��','Ȯ������մϴ�! ǰ������, ǰ��ܰ������� ������·� ���ÿ� ����˴ϴ�. Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'G'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '100';

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519_100) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519_100) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if
f_bpm_job_start(ls_xyear, ls_revno, 'w_bpm101u',g_s_empno,'X','ȯ������ �ڷ�Ȯ�� ���')


select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '150';
if ls_stcd <> 'G' then
	uo_status.st_message.text = 'ǰ������ Ȯ�������...'
	update pbbpm.bpm519
		set taskstatus = 'G'
	where comltd = '01'
	and   xyear = :ls_xyear
	and   revno = :ls_revno
	and   seqno = '150';
	
	if sqlca.sqlcode <> 0 then
		MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519_150) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.')
		uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519_150) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.'
		messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		Return
	end if
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm201u',g_s_empno,'X','ȯ��Ȯ����ҿ� ���� ǰ������ �ڵ�Ȯ�����')
end if
select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '200';
if ls_stcd <> 'G' then
	uo_status.st_message.text = 'ǰ��ܰ����� Ȯ�������...'
	update pbbpm.bpm519
		set taskstatus = 'G'
	where comltd = '01'
	and   xyear = :ls_xyear
	and   revno = :ls_revno
	and   seqno = '200';
	
	if sqlca.sqlcode <> 0 then
		MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519_200) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.')
		uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ����������(BPM519_200) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.'
		messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		Return
	end if
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'X','ȯ��Ȯ����ҿ� ���� �ܰ����� �ڵ�Ȯ�����')
end if

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ȯ�� Ȯ����ҿϷ�.'
SetPointer(arrow!)
return

end event

