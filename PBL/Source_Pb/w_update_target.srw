$PBExportHeader$w_update_target.srw
$PBExportComments$��ȹ���� ����
forward
global type w_update_target from window
end type
type sle_plan_new from singlelineedit within w_update_target
end type
type st_3 from statictext within w_update_target
end type
type st_plan_old from statictext within w_update_target
end type
type st_1 from statictext within w_update_target
end type
type cb_exit from commandbutton within w_update_target
end type
type cb_update from commandbutton within w_update_target
end type
end forward

global type w_update_target from window
integer x = 379
integer y = 428
integer width = 1787
integer height = 732
boolean titlebar = true
string title = "�� ��ǥ���� ����"
windowtype windowtype = response!
long backcolor = 78748035
string icon = "target.ico"
toolbaralignment toolbaralignment = alignatleft!
sle_plan_new sle_plan_new
st_3 st_3
st_plan_old st_plan_old
st_1 st_1
cb_exit cb_exit
cb_update cb_update
end type
global w_update_target w_update_target

on w_update_target.create
this.sle_plan_new=create sle_plan_new
this.st_3=create st_3
this.st_plan_old=create st_plan_old
this.st_1=create st_1
this.cb_exit=create cb_exit
this.cb_update=create cb_update
this.Control[]={this.sle_plan_new,&
this.st_3,&
this.st_plan_old,&
this.st_1,&
this.cb_exit,&
this.cb_update}
end on

on w_update_target.destroy
destroy(this.sle_plan_new)
destroy(this.st_3)
destroy(this.st_plan_old)
destroy(this.st_1)
destroy(this.cb_exit)
destroy(this.cb_update)
end on

event open;// ��ǥ���� Display 
st_plan_old.Text = gs_ETC_DATA



end event

type sle_plan_new from singlelineedit within w_update_target
integer x = 1047
integer y = 232
integer width = 672
integer height = 160
integer taborder = 10
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ����"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_update_target
integer x = 59
integer y = 240
integer width = 974
integer height = 136
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ����"
long textcolor = 33554432
long backcolor = 67108864
string text = "��ǥ���� (������)"
boolean focusrectangle = false
end type

type st_plan_old from statictext within w_update_target
integer x = 1047
integer y = 80
integer width = 672
integer height = 136
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ����"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_update_target
integer x = 59
integer y = 80
integer width = 974
integer height = 136
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ����"
long textcolor = 33554432
long backcolor = 67108864
string text = "��ǥ���� (������)"
boolean focusrectangle = false
end type

type cb_exit from commandbutton within w_update_target
integer x = 1243
integer y = 444
integer width = 480
integer height = 152
integer taborder = 40
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exit"
end type

event clicked;// �ݱ� 
Close(Parent) 

end event

type cb_update from commandbutton within w_update_target
integer x = 736
integer y = 448
integer width = 480
integer height = 152
integer taborder = 20
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Update"
end type

event clicked;// ���� 
String ls_PLAN_QTY

If Trim(sle_plan_new.Text) = '' Then
	Messagebox('����', '������ �Է��ϼ���.')
	Return
End If

If Not IsNumber(sle_plan_new.Text) Then 
	Messagebox('����', '������ ���ڷ� �Է��ϼ���.')
	Return
End If

ls_PLAN_QTY = String(Long(sle_plan_new.Text))

UPDATE TM_CODE
   SET CDNAME	= :ls_PLAN_QTY
 WHERE MCD		= '90'
   AND SCD		= '04';
	
If Sqlca.sqlcode = 0 Then
	Messagebox('����', '���������� ���� �Ǿ����ϴ�.')

	If IsNumber(ls_PLAN_QTY) Then
		gs_ETC_DATA = String(Long(ls_PLAN_QTY), "0,000")
	Else
		gs_ETC_DATA = ls_PLAN_QTY
	End If
Else
	Messagebox('����', '������ �����߻�...')
End If
end event
