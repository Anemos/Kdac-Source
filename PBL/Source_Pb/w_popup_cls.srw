$PBExportHeader$w_popup_cls.srw
$PBExportComments$�����ڵ庸��
forward
global type w_popup_cls from window
end type
type rb_3 from radiobutton within w_popup_cls
end type
type rb_2 from radiobutton within w_popup_cls
end type
type rb_1 from radiobutton within w_popup_cls
end type
type st_msg from statictext within w_popup_cls
end type
type st_3 from statictext within w_popup_cls
end type
type st_1 from statictext within w_popup_cls
end type
type pb_2 from picturebutton within w_popup_cls
end type
type pb_confirm from picturebutton within w_popup_cls
end type
type pb_1 from picturebutton within w_popup_cls
end type
type sle_1 from singlelineedit within w_popup_cls
end type
type dw_1 from datawindow within w_popup_cls
end type
type gb_2 from groupbox within w_popup_cls
end type
type gb_1 from groupbox within w_popup_cls
end type
end forward

global type w_popup_cls from window
integer x = 357
integer y = 268
integer width = 2825
integer height = 1412
windowtype windowtype = response!
long backcolor = 67108864
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_msg st_msg
st_3 st_3
st_1 st_1
pb_2 pb_2
pb_confirm pb_confirm
pb_1 pb_1
sle_1 sle_1
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
end type
global w_popup_cls w_popup_cls

type variables
string i_s_selected, i_s_runparm , is_gubun
end variables

forward prototypes
public subroutine wf_dw_select ()
end prototypes

public subroutine wf_dw_select ();//
//Choose Case is_gubun
//	Case 'A'	//Item Balance DB
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno01'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno02'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno03'	//�԰�
//		End IF			
//	Case 'B1' //Item Balance DB
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno11'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno12'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno13'	//�԰�
//		End IF			
//	Case 'B2' //Item Balance DB
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno21'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno22'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno23'	//�԰�
//		End IF			
//	Case 'B3' //Item Balance DB
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno31'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno32'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno33'	//�԰�
//		End IF			
//	Case 'D'	//��������ǰ
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_pur010_itno11'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_pur010_itno12'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_pur010_itno13'	//�԰�
//		End IF			
//	Case 'C'	//��Ÿǰ��(����X) - Exception join
//		IF rb_3.Checked = True Then
////			dw_1.DataObject = 'd_pur010_itno21'	//ǰ��
//			dw_1.DataObject = 'd_pur010_itno31'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
////			dw_1.DataObject = 'd_pur010_itno22'	//ǰ��
//			dw_1.DataObject = 'd_pur010_itno32'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
////			dw_1.DataObject = 'd_pur010_itno23'	//�԰�
//			dw_1.DataObject = 'd_pur010_itno33'	//�԰�
//		End IF
//	Case "M"	//���ǰ
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno41'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno42'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno43'	//�԰�
//		End IF			
//	Case "Y" //������ǰ
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno51'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno52'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno53'	//�԰�
//		End IF			
//	Case Else		//��,������ ����
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_pur010_itno01'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_pur010_itno02'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_pur010_itno03'	//�԰�
//		End IF			
//End Choose
end subroutine

on w_popup_cls.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_msg=create st_msg
this.st_3=create st_3
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_confirm=create pb_confirm
this.pb_1=create pb_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_msg,&
this.st_3,&
this.st_1,&
this.pb_2,&
this.pb_confirm,&
this.pb_1,&
this.sle_1,&
this.dw_1,&
this.gb_2,&
this.gb_1}
end on

on w_popup_cls.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_msg)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_confirm)
destroy(this.pb_1)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;//i_s_runparm = Upper(Trim(g_s_runparm))
is_gubun = Message.StringParm	
//MessageBox(g_s_runparm , is_gubun)

st_msg.text = ""
sle_1.setfocus()
end event

type rb_3 from radiobutton within w_popup_cls
integer x = 201
integer y = 1196
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "��Ÿ"
end type

type rb_2 from radiobutton within w_popup_cls
integer x = 718
integer y = 1116
integer width = 480
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "����(������)"
end type

event clicked;IF dw_1.Retrieve("INV030") > 0 Then //������-����
	st_msg.text = "��ȸ�Ǿ����ϴ�."
Else
	st_msg.text = "��ȸ���ڷᰡ �����ϴ�."
End IF
end event

type rb_1 from radiobutton within w_popup_cls
integer x = 201
integer y = 1112
integer width = 480
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "����(������)"
boolean checked = true
end type

event clicked;IF dw_1.Retrieve("INV020") > 0 Then
	st_msg.text = "��ȸ�Ǿ����ϴ�."
Else
	st_msg.text = "��ȸ���ڷᰡ �����ϴ�."
End IF
end event

type st_msg from statictext within w_popup_cls
integer x = 32
integer y = 1304
integer width = 2162
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_popup_cls
integer x = 46
integer y = 1188
integer width = 142
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "����"
boolean focusrectangle = false
end type

type st_1 from statictext within w_popup_cls
integer x = 46
integer y = 1128
integer width = 137
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "��ȸ"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_popup_cls
integer x = 2478
integer y = 1108
integer width = 302
integer height = 136
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���"
vtextalign vtextalign = vcenter!
end type

event clicked;
close(parent)
//closewithreturn(parent, '')
end event

type pb_confirm from picturebutton within w_popup_cls
integer x = 2158
integer y = 1108
integer width = 302
integer height = 136
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ��"
vtextalign vtextalign = vcenter!
end type

event clicked;String ls_search
integer	l_n_row

l_n_row = dw_1.GetSelectedRow(0)

if l_n_row	<  1	then
	messagebox("Ȯ ��","�ش� ������ ���� �Ͻ� �� Ȯ���� �����ʽÿ�")
   Return
end if

ls_search	=	trim(dw_1.getitemstring(l_n_row,"cocode"))	

closewithreturn(parent, ls_search)


end event

type pb_1 from picturebutton within w_popup_cls
integer x = 1801
integer y = 1108
integer width = 302
integer height = 136
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�˻�"
boolean default = true
vtextalign vtextalign = vcenter!
end type

event clicked;String ls_search
ls_search = Upper(Trim(sle_1.text))
If rb_1.Checked Then
	ls_search = "INV020"	//����(������)
ElseIf rb_2.Checked Then
	ls_search = "INV030"	//����(������)	
Else

End If	
IF dw_1.Retrieve(ls_search) > 0 Then //������-����
	st_msg.text = "��ȸ�Ǿ����ϴ�."
Else
	st_msg.text = "��ȸ���ڷᰡ �����ϴ�."
End IF
end event

type sle_1 from singlelineedit within w_popup_cls
integer x = 1271
integer y = 1132
integer width = 498
integer height = 92
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_popup_cls
integer x = 18
integer y = 32
integer width = 2779
integer height = 1020
integer taborder = 10
string title = "none"
string dataobject = "d_comm261u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row	<	1	then
	Return
end if	

this.selectrow(0, False)
this.selectrow(row, TRUE)
end event

event dberror;return 1
end event

event constructor;is_gubun = Message.StringParm	
This.SetTransObject(sqlca)
This.Retrieve("INV020") //������-����

	
	
end event

type gb_2 from groupbox within w_popup_cls
integer x = 23
integer y = 1080
integer width = 2103
integer height = 192
integer taborder = 20
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_popup_cls
integer x = 2135
integer y = 1080
integer width = 667
integer height = 188
integer taborder = 20
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
end type

