$PBExportHeader$w_piss9031.srw
$PBExportComments$��������
forward
global type w_piss9031 from window
end type
type dw_print from datawindow within w_piss9031
end type
type dw_shipqty_view from datawindow within w_piss9031
end type
type cb_3 from commandbutton within w_piss9031
end type
type cb_2 from commandbutton within w_piss9031
end type
type cb_1 from commandbutton within w_piss9031
end type
type st_6 from statictext within w_piss9031
end type
type st_2 from statictext within w_piss9031
end type
type em_endtruck from editmask within w_piss9031
end type
type em_fromtruck from editmask within w_piss9031
end type
type st_1 from statictext within w_piss9031
end type
type st_date from statictext within w_piss9031
end type
type gb_1 from groupbox within w_piss9031
end type
type gb_2 from groupbox within w_piss9031
end type
end forward

global type w_piss9031 from window
integer width = 4439
integer height = 2084
boolean titlebar = true
string title = "��������"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
event ue_reset ( )
event ue_retrieve ( )
dw_print dw_print
dw_shipqty_view dw_shipqty_view
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_6 st_6
st_2 st_2
em_endtruck em_endtruck
em_fromtruck em_fromtruck
st_1 st_1
st_date st_date
gb_1 gb_1
gb_2 gb_2
end type
global w_piss9031 w_piss9031

type variables
string is_fromtruck, is_endtruck, is_date,is_areacode,is_divisioncode,is_empno
end variables

event ue_reset;dw_shipqty_view.reset()
end event

event ue_retrieve();dw_shipqty_view.retrieve( is_areacode,is_divisioncode,integer(is_fromtruck), integer(is_endtruck) , is_date, is_empno )

if dw_shipqty_view.rowcount() >0 then
	dw_shipqty_view.setfocus()
end if


//st_truckorder.text= is_fromtruck + 'ȣ ���� ' +  is_endtruck + 'ȣ������ ������ȹ�Դϴ�.'
//dw_shipqty_view.Modify("Header.text = '" + st_date.text + "  " + st_truckorder.text + "'")

end event

on w_piss9031.create
this.dw_print=create dw_print
this.dw_shipqty_view=create dw_shipqty_view
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_6=create st_6
this.st_2=create st_2
this.em_endtruck=create em_endtruck
this.em_fromtruck=create em_fromtruck
this.st_1=create st_1
this.st_date=create st_date
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_print,&
this.dw_shipqty_view,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_6,&
this.st_2,&
this.em_endtruck,&
this.em_fromtruck,&
this.st_1,&
this.st_date,&
this.gb_1,&
this.gb_2}
end on

on w_piss9031.destroy
destroy(this.dw_print)
destroy(this.dw_shipqty_view)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.st_2)
destroy(this.em_endtruck)
destroy(this.em_fromtruck)
destroy(this.st_1)
destroy(this.st_date)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;string ls_argument, ls_truckorder, ls_size 

ls_argument 		= Message.StringParm

is_areacode       = mid(ls_argument,1,1)
is_divisioncode   = mid(ls_argument,2,1)
is_date				= Trim(Mid(ls_argument, 3, 10))
ls_truckorder		= Trim(Mid(ls_argument, 13, 10))
is_empno				= Trim(Mid(ls_argument,23,6))
ls_size				= Right(ls_argument, 40)
is_fromtruck		= ls_truckorder
is_endtruck			= ls_truckorder
em_fromtruck.text	= is_fromtruck
em_endtruck.text	= is_endtruck

dw_shipqty_view.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_shipqty_view.retrieve(is_areacode,is_divisioncode, integer(is_fromtruck), integer(is_endtruck),is_date,is_empno)

if dw_shipqty_view.rowcount() >0 then
	dw_shipqty_view.setfocus()
end if
dw_shipqty_view.sharedata(dw_print)

st_date.text 		= is_date
//st_truckorder.text= is_fromtruck + 'ȣ ���� ' +  is_endtruck + 'ȣ������ ������ȹ�Դϴ�.'
//dw_shipqty_view.Modify("Header.text = '" + st_date.text + "  " + st_truckorder.text + "'")


end event

type dw_print from datawindow within w_piss9031
boolean visible = false
integer x = 1687
integer y = 416
integer width = 411
integer height = 432
integer taborder = 30
string title = "none"
string dataobject = "d_piss9031_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_shipqty_view from datawindow within w_piss9031
integer x = 9
integer y = 304
integer width = 4407
integer height = 1684
integer taborder = 20
string title = "none"
string dataobject = "d_piss9031_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_piss9031
integer x = 3525
integer y = 156
integer width = 347
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

type cb_2 from commandbutton within w_piss9031
integer x = 3173
integer y = 156
integer width = 347
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���"
end type

event clicked;If dw_shipqty_view.rowcount() > 0 then
	dw_print.print()
Else
	MessageBox('�� ��', '�μ��� ������ �����ϴ�.')
end if
end event

type cb_1 from commandbutton within w_piss9031
integer x = 2821
integer y = 156
integer width = 347
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

event clicked;Parent.TriggerEvent("ue_retrieve")
end event

type st_6 from statictext within w_piss9031
integer x = 827
integer y = 176
integer width = 270
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "��������"
boolean focusrectangle = false
end type

type st_2 from statictext within w_piss9031
integer x = 1362
integer y = 184
integer width = 78
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "��"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_endtruck from editmask within w_piss9031
integer x = 1440
integer y = 164
integer width = 256
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 1
string minmax = "1~~999"
end type

event modified;parent.TriggerEvent("ue_reset")
is_endtruck = em_endtruck.text
end event

type em_fromtruck from editmask within w_piss9031
integer x = 1106
integer y = 160
integer width = 256
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 1
string minmax = "1~~999"
end type

event modified;Parent.TriggerEvent("ue_reset")
is_fromtruck = em_fromtruck.text

end event

type st_1 from statictext within w_piss9031
integer x = 37
integer y = 176
integer width = 334
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "���ϰ�ȹ��"
boolean focusrectangle = false
end type

type st_date from statictext within w_piss9031
integer x = 375
integer y = 156
integer width = 425
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss9031
integer x = 9
integer y = 92
integer width = 1710
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "��ȸ����"
end type

type gb_2 from groupbox within w_piss9031
integer x = 2779
integer y = 92
integer width = 1138
integer height = 196
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
end type

