$PBExportHeader$w_mpsg000.srw
$PBExportComments$Connecting
forward
global type w_mpsg000 from window
end type
type st_3 from statictext within w_mpsg000
end type
type st_2 from statictext within w_mpsg000
end type
type st_1 from statictext within w_mpsg000
end type
end forward

global type w_mpsg000 from window
integer width = 1193
integer height = 284
windowtype windowtype = popup!
long backcolor = 67108864
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_mpsg000 w_mpsg000

type variables
Boolean	ib_close
end variables

on w_mpsg000.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_3,&
this.st_2,&
this.st_1}
end on

on w_mpsg000.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;f_centerwindow(this)

If ib_close = False Then
//	If f_pisc_download_count() > 0 Then
//		ib_close	= True
//	End If
End If

Close(This)

end event

event closequery;If ib_close Then
	//run('auto_down.exe	' + gs_appname)
ELSE
	Open(w_mpsg010b)
End If


end event
type st_3 from statictext within w_mpsg000
integer x = 430
integer y = 192
integer width = 704
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 67108864
string text = "Version 1.000 Since 2002"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpsg000
integer x = 9
integer y = 152
integer width = 1129
integer height = 16
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 8421504
boolean focusrectangle = false
end type

type st_1 from statictext within w_mpsg000
integer x = 32
integer y = 36
integer width = 1070
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 67108864
string text = "CONNECTING SYSYTEM"
alignment alignment = center!
boolean focusrectangle = false
end type

