$PBExportHeader$w_itno_popup.srw
$PBExportComments$ǰ�� ����
forward
global type w_itno_popup from window
end type
type st_msg from statictext within w_itno_popup
end type
type rb_3 from radiobutton within w_itno_popup
end type
type st_3 from statictext within w_itno_popup
end type
type rb_2 from radiobutton within w_itno_popup
end type
type rb_1 from radiobutton within w_itno_popup
end type
type st_1 from statictext within w_itno_popup
end type
type st_2 from statictext within w_itno_popup
end type
type pb_2 from picturebutton within w_itno_popup
end type
type pb_confirm from picturebutton within w_itno_popup
end type
type pb_1 from picturebutton within w_itno_popup
end type
type sle_1 from singlelineedit within w_itno_popup
end type
type dw_1 from datawindow within w_itno_popup
end type
type gb_2 from groupbox within w_itno_popup
end type
type gb_1 from groupbox within w_itno_popup
end type
end forward

global type w_itno_popup from window
integer x = 357
integer y = 268
integer width = 2825
integer height = 1540
windowtype windowtype = response!
long backcolor = 67108864
st_msg st_msg
rb_3 rb_3
st_3 st_3
rb_2 rb_2
rb_1 rb_1
st_1 st_1
st_2 st_2
pb_2 pb_2
pb_confirm pb_confirm
pb_1 pb_1
sle_1 sle_1
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
end type
global w_itno_popup w_itno_popup

type variables
string i_s_selected, i_s_runparm , is_gubun
end variables

forward prototypes
public subroutine wf_dw_select ()
end prototypes

public subroutine wf_dw_select ();
Choose Case is_gubun
	Case "M"	//���ǰ
		IF rb_3.Checked = True Then
			dw_1.DataObject = 'd_inv101_itno41'	//ǰ��
		ElseIf rb_1.Checked = True Then	
			dw_1.DataObject = 'd_inv101_itno42'	//ǰ��
		ElseIf rb_2.Checked = True Then	
			dw_1.DataObject = 'd_inv101_itno43'	//�԰�
		End IF			
	Case "N" //������ǰ
		IF rb_3.Checked = True Then
			dw_1.DataObject = 'd_inv101_itno51'	//ǰ��
		ElseIf rb_1.Checked = True Then	
			dw_1.DataObject = 'd_inv101_itno52'	//ǰ��
		ElseIf rb_2.Checked = True Then	
			dw_1.DataObject = 'd_inv101_itno53'	//�԰�
		End IF			
	Case 'A'	//Item Balance DB
		IF rb_3.Checked = True Then
			dw_1.DataObject = 'd_inv101_itno01'	//ǰ��
		ElseIf rb_1.Checked = True Then	
			dw_1.DataObject = 'd_inv101_itno02'	//ǰ��
		ElseIf rb_2.Checked = True Then	
			dw_1.DataObject = 'd_inv101_itno03'	//�԰�
		End IF		
	Case "B1","B2","B3"
		//������ �ϴ� ��� �� - ������ ������� ������
		IF rb_3.Checked = True Then
			dw_1.DataObject = "d_inv101_itno31_01"	//ǰ��
		ElseIf rb_1.Checked = True Then	
			dw_1.DataObject = "d_inv101_itno32_01"	//ǰ��
		ElseIf rb_2.Checked = True Then	
			dw_1.DataObject = "d_inv101_itno33_01"	//�԰�
		End IF			

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
//	Case 'B3' //Item Balance DB - �ü�����
//		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_inv101_itno31'	//ǰ��
//		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno32'	//ǰ��
//		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_inv101_itno33'	//�԰�
//		End IF			
	Case 'D'	//��������ǰ
		IF rb_3.Checked = True Then
			dw_1.DataObject = 'd_pur010_itno11'	//ǰ��
		ElseIf rb_1.Checked = True Then	
			dw_1.DataObject = 'd_pur010_itno12'	//ǰ��
		ElseIf rb_2.Checked = True Then	
			dw_1.DataObject = 'd_pur010_itno13'	//�԰�
		End IF			
	Case 'C'	//��Ÿǰ��(����X) - Exception join
		IF rb_3.Checked = True Then
//			dw_1.DataObject = 'd_pur010_itno21'	//ǰ��
			dw_1.DataObject = 'd_pur010_itno31'	//ǰ��
		ElseIf rb_1.Checked = True Then	
//			dw_1.DataObject = 'd_pur010_itno22'	//ǰ��
			dw_1.DataObject = 'd_pur010_itno32'	//ǰ��
		ElseIf rb_2.Checked = True Then	
//			dw_1.DataObject = 'd_pur010_itno23'	//�԰�
			dw_1.DataObject = 'd_pur010_itno33'	//�԰�
		End IF		
	Case Else		//��,������ ����
		IF rb_3.Checked = True Then
			dw_1.DataObject = 'd_pur010_itno01'	//ǰ��
		ElseIf rb_1.Checked = True Then	
			dw_1.DataObject = 'd_pur010_itno02'	//ǰ��
		ElseIf rb_2.Checked = True Then	
			dw_1.DataObject = 'd_pur010_itno03'	//�԰�
		End IF			
End Choose
end subroutine

on w_itno_popup.create
this.st_msg=create st_msg
this.rb_3=create rb_3
this.st_3=create st_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.st_2=create st_2
this.pb_2=create pb_2
this.pb_confirm=create pb_confirm
this.pb_1=create pb_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_msg,&
this.rb_3,&
this.st_3,&
this.rb_2,&
this.rb_1,&
this.st_1,&
this.st_2,&
this.pb_2,&
this.pb_confirm,&
this.pb_1,&
this.sle_1,&
this.dw_1,&
this.gb_2,&
this.gb_1}
end on

on w_itno_popup.destroy
destroy(this.st_msg)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.st_2)
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

//�߰� �ѱ۷� default
//Choose Case dwo.Name 
//	Case 'itno'
		f_toggle( handle(This), 'KOR' ) // Ű���� �������� ����...
//End Choose

st_msg.text = ""
sle_1.setfocus()


end event

type st_msg from statictext within w_itno_popup
integer x = 46
integer y = 1400
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

type rb_3 from radiobutton within w_itno_popup
integer x = 187
integer y = 1144
integer width = 215
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "ǰ��"
end type

event clicked;//ǰ��
//dw_1.DataObject = 'd_pur010_itno01'
wf_dw_select()
dw_1.SetTransObject(sqlca)
sle_1.setfocus()
end event

type st_3 from statictext within w_itno_popup
integer x = 46
integer y = 1184
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

type rb_2 from radiobutton within w_itno_popup
integer x = 645
integer y = 1144
integer width = 224
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
string text = "�԰�"
end type

event clicked;//�԰�
//dw_1.DataObject = 'd_pur010_itno03'
wf_dw_select()
dw_1.SetTransObject(sqlca)
sle_1.setfocus()


end event

type rb_1 from radiobutton within w_itno_popup
integer x = 416
integer y = 1144
integer width = 219
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
string text = "ǰ��"
boolean checked = true
end type

event clicked;//ǰ��
//dw_1.DataObject = 'd_pur010_itno02'
wf_dw_select()
dw_1.SetTransObject(sqlca)
sle_1.setfocus()
end event

type st_1 from statictext within w_itno_popup
integer x = 46
integer y = 1124
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

type st_2 from statictext within w_itno_popup
integer x = 32
integer y = 1300
integer width = 1943
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "�� �ش�ǰ���� ������ �� ~'Ȯ��~'�� �����ʽÿ�."
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_itno_popup
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

type pb_confirm from picturebutton within w_itno_popup
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

event clicked;string	l_s_juso
integer	l_n_row

if isnull(i_s_selected) = True  then
	messagebox("Ȯ ��","���� ǰ�� �˻��� �Ͻ� �� ó�� �Ͻʽÿ�")
   Return
end if

//l_n_row	= 	dw_1.getrow()
l_n_row = dw_1.GetSelectedRow(0)
if l_n_row	<  1	then
	messagebox("Ȯ ��","�ش� ǰ���� ���� �Ͻ� �� Ȯ���� �����ʽÿ�")
   Return
end if

Choose Case is_gubun		
	Case "A","B1","B2","B3","M","N"
		l_s_juso	=	trim(dw_1.getitemstring(l_n_row,"inv101_itno"))		
	Case Else
		l_s_juso	=	trim(dw_1.getitemstring(l_n_row,"itno"))	

End Choose

closewithreturn(parent, l_s_juso)


end event

type pb_1 from picturebutton within w_itno_popup
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

event clicked;String ls_dongname, ls_gubun
integer ln_rows

ls_dongname = Upper(trim(sle_1.text))
dw_1.settransobject(sqlca)

if rb_1.checked then	//ǰ��
	ls_dongname = '%' + ls_dongname + '%'
elseIF rb_2.checked then	//�԰�
	ls_dongname = '%' + ls_dongname + '%'
elseIF rb_3.checked then	//ǰ��
	ls_dongname = '%' + ls_dongname + '%'
end if
st_msg.text = "�˻����Դϴ�. ��ø� ��ٷ��ּ���!"
SetPointer(Hourglass!)

IF dw_1.retrieve(ls_dongname, i_s_runparm) < 1 Then
	//messagebox(" �˻� ����"," ǰ�� �˻��� ������ �߻� �Ͽ����ϴ�.")
	st_msg.text = "��ȸ�� �ڷᰡ �����ϴ�."
	return
Else
	st_msg.text = "��ȸ�Ǿ����ϴ�."
End IF

dw_1.SelectRow(0, FALSE)
dw_1.SelectRow(1, TRUE)

i_s_selected	= 	"r"

end event

type sle_1 from singlelineedit within w_itno_popup
integer x = 887
integer y = 1128
integer width = 882
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

type dw_1 from datawindow within w_itno_popup
integer x = 18
integer y = 32
integer width = 2779
integer height = 1020
integer taborder = 10
string title = "none"
string dataobject = "d_pur010_itno01"
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
//MessageBox(g_s_runparm, is_gubun)
wf_dw_select()
This.SetTransObject(sqlca)
	
	
end event

type gb_2 from groupbox within w_itno_popup
integer x = 23
integer y = 1080
integer width = 2103
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

type gb_1 from groupbox within w_itno_popup
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

