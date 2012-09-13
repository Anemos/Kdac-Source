$PBExportHeader$w_piss430i.srw
$PBExportComments$��SR����
forward
global type w_piss430i from window
end type
type dw_srview from datawindow within w_piss430i
end type
type cb_3 from commandbutton within w_piss430i
end type
type cb_1 from commandbutton within w_piss430i
end type
type em_1 from editmask within w_piss430i
end type
type gb_1 from groupbox within w_piss430i
end type
type gb_2 from groupbox within w_piss430i
end type
end forward

global type w_piss430i from window
integer width = 4096
integer height = 2152
boolean titlebar = true
string title = "��SR����"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
event ue_reset ( )
dw_srview dw_srview
cb_3 cb_3
cb_1 cb_1
em_1 em_1
gb_1 gb_1
gb_2 gb_2
end type
global w_piss430i w_piss430i

type variables
string is_srno,is_areacode,is_divisioncode,is_date
boolean ib_open
end variables

event ue_reset;dw_srview.reset()
end event

on w_piss430i.create
this.dw_srview=create dw_srview
this.cb_3=create cb_3
this.cb_1=create cb_1
this.em_1=create em_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_srview,&
this.cb_3,&
this.cb_1,&
this.em_1,&
this.gb_1,&
this.gb_2}
end on

on w_piss430i.destroy
destroy(this.dw_srview)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;String ls_parm, ls_size, ls_srno

SetPointer(HourGlass!)

ls_parm 		= Message.StringParm
ls_size	= Left(ls_parm, 50)

//f_win_move(This, ls_size)
is_srno	   = Trim(Mid(ls_parm, 1,11))
is_date     = Trim(Mid(ls_parm, 12,10))
is_areacode = Trim(Mid(ls_parm,22,1))
is_divisioncode = Trim(Mid(ls_parm,23,1))
em_1.text = is_srno
dw_srview.SetTransObject(SQLPIS)

If Upper(ls_srno) = 'NO' Then
	em_1.setfocus()
else
    dw_srview.Retrieve(is_srno,is_date,is_areacode,is_divisioncode)
 
 	if dw_srview.rowcount() = 0 Then
		messagebox("Ȯ��","��ȸ�ϰ��� �ϴ� SR��ȣ�� �����ϴ�.")
	end if

end if

ib_open= true

end event

type dw_srview from datawindow within w_piss430i
integer x = 32
integer y = 244
integer width = 4000
integer height = 1804
integer taborder = 40
string title = "none"
string dataobject = "d_piss420i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_piss430i
integer x = 1760
integer y = 96
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_piss430i
integer x = 1440
integer y = 96
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��ȸ"
end type

event clicked;//If Len(is_srno) = 11 Then
	dw_srview.retrieve(is_srno,is_date,is_areacode,is_divisioncode)
	dw_srview.setfocus()
//End If


end event

type em_1 from editmask within w_piss430i
integer x = 82
integer y = 96
integer width = 608
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event modified;is_srno = this.text
end event

type gb_1 from groupbox within w_piss430i
integer x = 37
integer y = 32
integer width = 695
integer height = 200
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "SR��ȣ"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_piss430i
integer x = 1403
integer y = 24
integer width = 722
integer height = 208
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "��ư����"
borderstyle borderstyle = stylelowered!
end type

