$PBExportHeader$w_bpm103u.srw
$PBExportComments$�ξ�Ƽ����(2003�����Ļ�����)
forward
global type w_bpm103u from w_origin_sheet01
end type
type dw_1 from datawindow within w_bpm103u
end type
type dw_3 from datawindow within w_bpm103u
end type
type pb_1 from picturebutton within w_bpm103u
end type
end forward

global type w_bpm103u from w_origin_sheet01
dw_1 dw_1
dw_3 dw_3
pb_1 pb_1
end type
global w_bpm103u w_bpm103u

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
end prototypes

public subroutine wf_rgbclear ();
end subroutine

public subroutine wf_click_retrieve (long al_row);




end subroutine

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////
// * ȯ�� ��� *      2003.09.05.  ������
///////////////////////////////////////////////////////////////////////////////////////////

i_b_insert = True  // �Է°���.
i_b_dprint = True  // ȭ���μ� ����.

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

on w_bpm103u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.pb_1
end on

on w_bpm103u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.pb_1)
end on

event ue_insert;
// �ʼ��Է��׸� Check...
dw_3.SetItemStatus( 1, 0, Primary!, DataModified! )
If f_Mandatory_Chk(dw_3) = -1 Then 
	i_n_erreturn = -1
	Return  
End If

String ls_year

ls_year = dw_3.Object.xyear[1]

dw_1.SetReDraw(False)

If ib_insert = False then
   dw_1.Reset()
End if

dw_1.InsertRow( 0 )

dw_1.SetItemStatus(1, 0, Primary!, NotModified!)

dw_1.Object.xplant.BackGround.Color  = 15780518   // �ϴû�
dw_1.Object.div.BackGround.Color     = 15780518   // �ϴû�
dw_1.Object.itno.BackGround.Color    = 15780518   // �ϴû�
dw_1.Object.royamt.BackGround.Color  = 15780518   // �ϴû�
dw_1.Object.expdate.BackGround.Color = 1090519039 // ���

f_Color_Protect( dw_1 ) 

dw_1.SetColumn( 'xplant' )
dw_1.SetFocus()

dw_1.SetReDraw(True)

ib_Insert = True
i_b_save	 =	True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;//Choose Case f_dw_status(dw_1, i_s_level)	
//	Case 1 // ó�����δ� �۾� ����.
//		This.TriggerEvent('ue_save')
//		
//		If i_n_erreturn = -1  Then
//			uo_status.st_message.text = f_message("U040") // ������ �� �����ϴ�.
//			Return 1
//		End If
//	Case 3 // ���.
//		Return 1
//End Choose
//
//dw_3.SetItemStatus(1, 0, Primary!, DataModified!)
//If f_mandatory_chk( dw_3 ) = -1 Then
//	Return
//End If
//
//String ls_year
//
//ls_year = Trim(dw_3.Object.xyear[1])
//
//SetPointer(HourGlass!)
//
//Integer li_Rcnt
//
//li_Rcnt = dw_1.Retrieve( ls_year )
//
//If li_Rcnt = 0 Then
//	
//	uo_status.st_message.Text = f_message("I020")    // ��ȸ�� �ڷᰡ �����ϴ�.
//	i_b_save = False
//	
//Else
//	
//	dw_1.Object.xplant.BackGround.Color  = 536870912 // ȸ��
//	dw_1.Object.div.BackGround.Color     = 536870912 // ȸ��
//	dw_1.Object.itno.BackGround.Color    = 536870912 // ȸ��
//	dw_1.Object.royamt.BackGround.Color  = 536870912 // ȸ��
//	dw_1.Object.expdate.BackGround.Color = 536870912 // ȸ��
//	f_Color_Protect( dw_1 )
//	
//	uo_status.st_message.Text = f_message("I010")    // ��ȸ �Ǿ����ϴ�.
//	
//	ib_insert  = False
//	i_b_delete = True
//	i_b_save	  = True
//	
//End If
//
//wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
//              i_b_dprint,   i_b_dchar)
//
//
end event

event ue_save;//
//If dw_1.AcceptText( ) = -1 Then
//	MessageBox("Ȯ��!", "������ ������ ������ �� �����Ͻʽÿ�.", Exclamation!)
//	Return
//End If
//
//If f_Mandatory_Chk( dw_3 ) = -1 Then // �ʼ��Է��׸� Check...
//	i_n_erreturn = -1
//	Return  
//End If
//
//SetPointer(HourGlass!)
//	
//Int    li_Rtn	 
//Long   ll_Row, ll_i
//String ls_year
//
//ls_year = dw_3.Object.xyear[1]
//
//ll_Row = dw_1.RowCount()
//
//For ll_i = 1 to ll_Row
//	
//	dw_1.Object.comltd[ll_i] = g_s_company  // Key Input...(ȸ��)
//	dw_1.Object.xyear[ll_i]  = ls_year      // Key Input...(�⵵)	
//	
//	dw_1.Object.itnm[ll_i]   = Mid( f_get_itnm( dw_1.Object.itno[ll_i] ),1,30 ) // ǰ��
//	
//	f_Null_Kill(dw_1)      // NULL ���� Space�� 0���� Setting.
//
//	f_ExtColumn_Set(dw_1)  // ���/���� ����� ��¥, IP/MAC Address Setting.
//	
//Next
//
//li_Rtn = dw_1.Update(True, False)
//
//If li_Rtn = 1 Then
//
//	dw_1.ResetUpdate( )
//	Commit Using SQLCA ;
//	i_n_erreturn = 0
//	uo_status.st_message.Text = f_message('U010') // ����Ǿ����ϴ�.	
//	
//	ib_Insert = False
//
//Else 
//	
//	RollBack Using SQLCA ;
//	i_n_erreturn = -1
//	uo_status.st_message.text = f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�. 	
//	
//End If
//
//i_b_save = True
//
//wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
//              i_b_dprint,   i_b_dchar)
end event

event ue_delete;call super::ue_delete;//
//SetPointer( HourGlass! )
//
//Integer li_SelectedRowCnt
//
//li_SelectedRowCnt = f_Selected_Row( dw_1 )
//
//SetPointer( Arrow! ) 
//
//Integer li_YNC
//
//If li_SelectedRowCnt > 0 Then
//	li_YNC = MessageBox('Ȯ��!', '������ ' + String(li_SelectedRowCnt) + '���� ǰ���� �����Ͻðڽ��ϱ�?', &
//								Question!, YesNo!, 2)
//	
//	Integer li_Rtn
//	
//	If li_YNC = 1 Then
//		
//		f_Multi_Delete_Row( dw_1 )
//		
//		li_Rtn = dw_1.Update(True, False)
//		
//		If li_Rtn = 1 Then
//			
//			dw_1.ResetUpdate()
//			Commit Using SQLCA ;
//			
//			uo_status.st_message.Text = f_message('D010')  // ���� �Ǿ����ϴ�.
//			
//		Else
//			
//			RollBack Using SQLCA ;
//			uo_status.st_message.Text = f_message('D020')  // [��������] �����ý��������� �����ٶ��ϴ�.
//		
//		End If
//	End If
//Else
//	
//	MessageBox('Ȯ��!', '������ ǰ���� �����ϴ�.', Exclamation!)
//	
//End If
//
end event

type uo_status from w_origin_sheet01`uo_status within w_bpm103u
end type

type dw_1 from datawindow within w_bpm103u
integer x = 18
integer y = 192
integer width = 4599
integer height = 2292
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bpm103u_02"
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

event itemchanged;
Choose Case dwo.Name

	case 'itno'
			
		This.object.itnm[row] = Mid ( f_get_itnm( data ), 1, 30 ) 
			
End choose
end event

type dw_3 from datawindow within w_bpm103u
event ue_key_down pbm_dwnkey
integer x = 37
integer y = 8
integer width = 1015
integer height = 168
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm102u_01"
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
end event

event itemchanged;Choose Case f_dw_status( dw_1, i_s_level )	
	Case 1 // ó�����δ� �۾� ����.
		This.TriggerEvent('ue_save')
		
		If i_n_erreturn = -1  Then
			uo_status.st_message.text = f_message("U040") // ������ �� �����ϴ�.
			Return 1
		End If
End Choose 

dw_1.SetRedraw( False )
dw_1.Reset( )
dw_1.SetRedraw( True ) 


end event

type pb_1 from picturebutton within w_bpm103u
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

event clicked;If dw_3.AcceptText( ) = -1 Then
	MessageBox("Ȯ��!", "������ ������ ������ �� �����Ͻʽÿ�.", Exclamation!)
	Return
End If

dw_3.SetItemStatus(1, 0, Primary!, DataModified!)
If f_mandantory_chk( dw_3 ) = -1 Then  // �ʼ��Է��׸� check
	Return
End If

f_pur040_GetExcel( dw_1 )
	
i_b_save	  = True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)


		
	

end event

