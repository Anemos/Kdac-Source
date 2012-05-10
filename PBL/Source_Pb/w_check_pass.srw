$PBExportHeader$w_check_pass.srw
$PBExportComments$ºñ¹Ð¹øÈ£ È®ÀÎÈ­¸é
forward
global type w_check_pass from window
end type
type pb_11 from picturebutton within w_check_pass
end type
type pb_10 from picturebutton within w_check_pass
end type
type pb_9 from picturebutton within w_check_pass
end type
type pb_8 from picturebutton within w_check_pass
end type
type pb_7 from picturebutton within w_check_pass
end type
type pb_6 from picturebutton within w_check_pass
end type
type pb_5 from picturebutton within w_check_pass
end type
type pb_4 from picturebutton within w_check_pass
end type
type pb_3 from picturebutton within w_check_pass
end type
type pb_2 from picturebutton within w_check_pass
end type
type pb_1 from picturebutton within w_check_pass
end type
type st_1 from statictext within w_check_pass
end type
type pb_cancel from picturebutton within w_check_pass
end type
type pb_ok from picturebutton within w_check_pass
end type
type sle_password from singlelineedit within w_check_pass
end type
type st_4 from statictext within w_check_pass
end type
end forward

global type w_check_pass from window
integer width = 1097
integer height = 1232
boolean titlebar = true
string title = "ºñ¹Ð¹øÈ£"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 0
string icon = "Form!"
boolean center = true
pb_11 pb_11
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
st_1 st_1
pb_cancel pb_cancel
pb_ok pb_ok
sle_password sle_password
st_4 st_4
end type
global w_check_pass w_check_pass

type variables

end variables

forward prototypes
public function boolean wf_passwordcheck (string as_passwd)
end prototypes

public function boolean wf_passwordcheck (string as_passwd);string 	ls_pass

//----------------------------------------------------------
//	»ç¿ëÀÚ ÆÐ½º¿öµå Ã¼Å© 
//----------------------------------------------------------
SELECT	CDNAME
  INTO	:ls_pass
  FROM	TM_CODE
 WHERE	MCD	= '90'
   AND   SCD	= '09';

If IsNull(ls_pass) Then
	Return False
End If

If ls_pass = as_passwd then
	Return True
else
	Return False
end if



end function

on w_check_pass.create
this.pb_11=create pb_11
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_1=create st_1
this.pb_cancel=create pb_cancel
this.pb_ok=create pb_ok
this.sle_password=create sle_password
this.st_4=create st_4
this.Control[]={this.pb_11,&
this.pb_10,&
this.pb_9,&
this.pb_8,&
this.pb_7,&
this.pb_6,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.st_1,&
this.pb_cancel,&
this.pb_ok,&
this.sle_password,&
this.st_4}
end on

on w_check_pass.destroy
destroy(this.pb_11)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.pb_cancel)
destroy(this.pb_ok)
destroy(this.sle_password)
destroy(this.st_4)
end on

event open;sle_password.SetFocus()


end event

event key;string ls_user_id, ls_pass

IF keydown(KeyEnter!) Then
//	ls_user_id = trim(sle_userid.text)
//	ls_pass = sle_pass.text
//
//	If ls_user_id <> "" Then
//		sle_pass.SetFocus()
//	End if
//
//	If ls_pass <> "" Then
//		sle_userid.SetFocus()
//	End If
//
//	If (ls_user_id <> "") AND (ls_pass <> "") Then
//		pb_ok.PostEvent(Clicked!)
//	End If

End If
end event

type pb_11 from picturebutton within w_check_pass
integer x = 539
integer y = 668
integer width = 466
integer height = 152
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "    CLEAR"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = ""



end event

type pb_10 from picturebutton within w_check_pass
integer x = 306
integer y = 668
integer width = 233
integer height = 152
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "0"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "0"
	





end event

type pb_9 from picturebutton within w_check_pass
integer x = 73
integer y = 668
integer width = 233
integer height = 152
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "9"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "9"
	





end event

type pb_8 from picturebutton within w_check_pass
integer x = 773
integer y = 516
integer width = 233
integer height = 152
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "8"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "8"
	





end event

type pb_7 from picturebutton within w_check_pass
integer x = 539
integer y = 516
integer width = 233
integer height = 152
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "7"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "7"
	





end event

type pb_6 from picturebutton within w_check_pass
integer x = 306
integer y = 516
integer width = 233
integer height = 152
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "6"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "6"
	





end event

type pb_5 from picturebutton within w_check_pass
integer x = 73
integer y = 516
integer width = 233
integer height = 152
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "5"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "5"
	





end event

type pb_4 from picturebutton within w_check_pass
integer x = 773
integer y = 364
integer width = 233
integer height = 152
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "4"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "4"
	





end event

type pb_3 from picturebutton within w_check_pass
integer x = 539
integer y = 364
integer width = 233
integer height = 152
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "3"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "3"





end event

type pb_2 from picturebutton within w_check_pass
integer x = 306
integer y = 364
integer width = 233
integer height = 152
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "2"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "2"





end event

type pb_1 from picturebutton within w_check_pass
integer x = 73
integer y = 364
integer width = 233
integer height = 152
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "1"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;sle_password.Text = sle_password.Text + "1"

	





end event

type st_1 from statictext within w_check_pass
integer x = 215
integer y = 12
integer width = 782
integer height = 120
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 65535
long backcolor = 16711680
string text = "ºñ¹Ð¹øÈ£ ÀÔ·Â"
boolean focusrectangle = false
end type

type pb_cancel from picturebutton within w_check_pass
integer x = 539
integer y = 884
integer width = 466
integer height = 208
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "  Ãë¼Ò"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// Ãë¼Ò
// 
Close(Parent) 
end event

type pb_ok from picturebutton within w_check_pass
integer x = 73
integer y = 884
integer width = 466
integer height = 208
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string pointer = "HyperLink!"
string text = "  È®ÀÎ"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// ºñ¹Ð¹øÈ£ È®ÀÎÈÄ
//		°ü¸®È­¸éÀ¸·Î ÀÌµ¿
// 
String ls_passwd
ls_passwd = trim(sle_password.Text) 

IF wf_PasswordCheck(ls_passwd) = False Then
	MessageBox("È®ÀÎ","ºñ¹Ð¹øÈ£¸¦ È®ÀÎÇÏ¼¼¿ä.")
	sle_password.setfocus()
	Return
End If

Close(w_check_pass)
Open(w_manage)


	





end event

type sle_password from singlelineedit within w_check_pass
integer x = 64
integer y = 208
integer width = 942
integer height = 128
integer taborder = 10
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_check_pass
integer width = 1111
integer height = 172
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 8388608
long backcolor = 16711680
boolean focusrectangle = false
end type

