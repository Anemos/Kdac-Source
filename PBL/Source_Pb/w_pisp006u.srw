$PBExportHeader$w_pisp006u.srw
$PBExportComments$���� ����
forward
global type w_pisp006u from window
end type
type em_2 from editmask within w_pisp006u
end type
type em_1 from editmask within w_pisp006u
end type
type st_4 from statictext within w_pisp006u
end type
type st_3 from statictext within w_pisp006u
end type
type st_2 from statictext within w_pisp006u
end type
type dw_save_active from datawindow within w_pisp006u
end type
type dw_print_save from datawindow within w_pisp006u
end type
type dw_print from datawindow within w_pisp006u
end type
type dw_kbno_buffer from datawindow within w_pisp006u
end type
type st_rackqty from statictext within w_pisp006u
end type
type sle_kbcount from singlelineedit within w_pisp006u
end type
type st_kbcount from statictext within w_pisp006u
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp006u
end type
type uo_line from u_pisc_select_line within w_pisp006u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp006u
end type
type rb_2 from radiobutton within w_pisp006u
end type
type rb_1 from radiobutton within w_pisp006u
end type
type dw_kbno from datawindow within w_pisp006u
end type
type st_msg from statictext within w_pisp006u
end type
type uo_division from u_pisc_select_division within w_pisp006u
end type
type uo_area from u_pisc_select_area within w_pisp006u
end type
type cb_2 from commandbutton within w_pisp006u
end type
type cb_1 from commandbutton within w_pisp006u
end type
type dw_save_kbno from datawindow within w_pisp006u
end type
type gb_4 from groupbox within w_pisp006u
end type
type gb_5 from groupbox within w_pisp006u
end type
type gb_7 from groupbox within w_pisp006u
end type
type gb_3 from groupbox within w_pisp006u
end type
type gb_2 from groupbox within w_pisp006u
end type
type gb_8 from groupbox within w_pisp006u
end type
type sle_rackqty from singlelineedit within w_pisp006u
end type
type gb_1 from groupbox within w_pisp006u
end type
type gb_9 from groupbox within w_pisp006u
end type
type gb_6 from groupbox within w_pisp006u
end type
end forward

global type w_pisp006u from window
integer width = 3442
integer height = 2032
boolean titlebar = true
string title = "���� ����"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
em_2 em_2
em_1 em_1
st_4 st_4
st_3 st_3
st_2 st_2
dw_save_active dw_save_active
dw_print_save dw_print_save
dw_print dw_print
dw_kbno_buffer dw_kbno_buffer
st_rackqty st_rackqty
sle_kbcount sle_kbcount
st_kbcount st_kbcount
uo_item uo_item
uo_line uo_line
uo_workcenter uo_workcenter
rb_2 rb_2
rb_1 rb_1
dw_kbno dw_kbno
st_msg st_msg
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
dw_save_kbno dw_save_kbno
gb_4 gb_4
gb_5 gb_5
gb_7 gb_7
gb_3 gb_3
gb_2 gb_2
gb_8 gb_8
sle_rackqty sle_rackqty
gb_1 gb_1
gb_9 gb_9
gb_6 gb_6
end type
global w_pisp006u w_pisp006u

type variables
Boolean		ib_open, ib_save
string		is_tempgubun = "N"
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen();String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

uo_area.is_uo_areacode = istr_parms.string_arg[3]
uo_area.dw_1.SetItem(1, 'DDDWCode', uo_area.is_uo_areacode)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
uo_division.is_uo_divisioncode	= istr_parms.string_arg[4]
uo_division.dw_1.SetItem(1, 'DDDWCode', uo_division.is_uo_divisioncode)

f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										False, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)
uo_workcenter.is_uo_workcenter	= istr_parms.string_arg[5]
uo_workcenter.dw_1.SetItem(1, 'DDDWCode', uo_workcenter.is_uo_workcenter)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										False, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)
uo_line.is_uo_linecode	= istr_parms.string_arg[6]
uo_line.dw_1.SetItem(1, 'DDDWCode', uo_line.is_uo_linecode)

f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										uo_line.is_uo_linecode, &
										'%', &
										False, &
										uo_item.is_uo_itemcode, &
										uo_item.is_uo_itemname)
uo_item.is_uo_itemcode	= istr_parms.string_arg[7]
uo_item.dw_1.SetItem(1, 'DDDWCode', uo_item.is_uo_itemcode)

dw_kbno.SetTransObject(SQLPIS)
//dw_kbno_buffer.SetTransObject(SQLPIS)
dw_save_kbno.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_print_save.SetTransObject(SQLPIS)
dw_save_active.SetTransObject(SQLPIS)

wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();dw_kbno.ReSet()
dw_kbno_buffer.ReSet()
dw_save_kbno.ReSet()

dw_print.ReSet()
dw_print_save.ReSet()
dw_save_active.ReSet()

sle_kbcount.Text	= ""
sle_rackqty.Text	= ""

If dw_kbno.Retrieve(uo_area.is_uo_areacode,			uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						uo_item.is_uo_itemcode,				is_tempgubun) > 0 Then
Else
	MessageBox("���� ����", "���Ǹ����Ͱ� �������� �ʴ� ǰ���Դϴ�." + &
									"~r~n~r~n���Ǹ����͸� ����Ͽ� �ֽʽÿ�", Exclamation!)
	Return
End If

end subroutine

on w_pisp006u.create
this.em_2=create em_2
this.em_1=create em_1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_save_active=create dw_save_active
this.dw_print_save=create dw_print_save
this.dw_print=create dw_print
this.dw_kbno_buffer=create dw_kbno_buffer
this.st_rackqty=create st_rackqty
this.sle_kbcount=create sle_kbcount
this.st_kbcount=create st_kbcount
this.uo_item=create uo_item
this.uo_line=create uo_line
this.uo_workcenter=create uo_workcenter
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_kbno=create dw_kbno
this.st_msg=create st_msg
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_save_kbno=create dw_save_kbno
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_7=create gb_7
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_8=create gb_8
this.sle_rackqty=create sle_rackqty
this.gb_1=create gb_1
this.gb_9=create gb_9
this.gb_6=create gb_6
this.Control[]={this.em_2,&
this.em_1,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_save_active,&
this.dw_print_save,&
this.dw_print,&
this.dw_kbno_buffer,&
this.st_rackqty,&
this.sle_kbcount,&
this.st_kbcount,&
this.uo_item,&
this.uo_line,&
this.uo_workcenter,&
this.rb_2,&
this.rb_1,&
this.dw_kbno,&
this.st_msg,&
this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.dw_save_kbno,&
this.gb_4,&
this.gb_5,&
this.gb_7,&
this.gb_3,&
this.gb_2,&
this.gb_8,&
this.sle_rackqty,&
this.gb_1,&
this.gb_9,&
this.gb_6}
end on

on w_pisp006u.destroy
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_save_active)
destroy(this.dw_print_save)
destroy(this.dw_print)
destroy(this.dw_kbno_buffer)
destroy(this.st_rackqty)
destroy(this.sle_kbcount)
destroy(this.st_kbcount)
destroy(this.uo_item)
destroy(this.uo_line)
destroy(this.uo_workcenter)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_kbno)
destroy(this.st_msg)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_save_kbno)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_7)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_8)
destroy(this.sle_rackqty)
destroy(this.gb_1)
destroy(this.gb_9)
destroy(this.gb_6)
end on

event open;String		ls_size

//Pareant Window�� �߾����� Window�� �̵���Ű�� ���Ͽ� Parent Window�� X,Y,Width,Height ���� ���Ѵ�.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
//is_applymonth		= istr_parms.string_arg[2]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

event activate;dw_kbno.SetTransObject(SQLPIS)
dw_kbno_buffer.SetTransObject(SQLPIS)
dw_save_kbno.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_print_save.SetTransObject(SQLPIS)
dw_save_active.SetTransObject(SQLPIS)

end event

type em_2 from editmask within w_pisp006u
integer x = 3045
integer y = 244
integer width = 178
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
string text = "5"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
string minmax = "0~~"
end type

type em_1 from editmask within w_pisp006u
integer x = 2514
integer y = 244
integer width = 178
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
string text = "8"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
string minmax = "0~~"
end type

type st_4 from statictext within w_pisp006u
integer x = 2738
integer y = 252
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "������:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisp006u
integer x = 2213
integer y = 252
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���ʿ���:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisp006u
integer x = 37
integer y = 508
integer width = 1851
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���ÿ� �μ�˴ϴ�.(Active ���� �ڵ� ��ȯ)"
boolean focusrectangle = false
end type

type dw_save_active from datawindow within w_pisp006u
integer x = 1851
integer y = 1204
integer width = 526
integer height = 292
boolean bringtotop = true
boolean titlebar = true
string title = "Active ��ȯ"
string dataobject = "d_pisp251u_02_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_print_save from datawindow within w_pisp006u
integer x = 1271
integer y = 1204
integer width = 539
integer height = 288
boolean bringtotop = true
boolean titlebar = true
string title = "�μ� ���� ����"
string dataobject = "d_pisp241u_04_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_print from datawindow within w_pisp006u
integer x = 727
integer y = 1212
integer width = 517
integer height = 296
boolean bringtotop = true
boolean titlebar = true
string title = "���� ��ȣ �μ�"
string dataobject = "d_pisp241u_03"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_kbno_buffer from datawindow within w_pisp006u
integer x = 133
integer y = 832
integer width = 773
integer height = 300
boolean bringtotop = true
boolean titlebar = true
string title = "������ ���ǹ�ȣ �ӽ� ����"
string dataobject = "d_pisp006u_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type st_rackqty from statictext within w_pisp006u
integer x = 1509
integer y = 252
integer width = 242
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�����:"
alignment alignment = right!
boolean focusrectangle = false
end type

event constructor;Visible	= False
end event

type sle_kbcount from singlelineedit within w_pisp006u
integer x = 1157
integer y = 236
integer width = 315
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_kbcount from statictext within w_pisp006u
integer x = 850
integer y = 252
integer width = 297
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "����ż�:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_item from u_pisc_select_item_kb_line within w_pisp006u
event destroy ( )
integer x = 2464
integer y = 72
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type uo_line from u_pisc_select_line within w_pisp006u
event destroy ( )
integer x = 1833
integer y = 68
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp006u
event destroy ( )
integer x = 1147
integer y = 64
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type rb_2 from radiobutton within w_pisp006u
integer x = 421
integer y = 248
integer width = 352
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "�ӽð���"
end type

event clicked;If Checked Then
	is_tempgubun = "T"
	st_rackqty.Visible	= True
	sle_rackqty.Visible	= True
	wf_retrieve()
Else
	rb_1.Checked	= False
End If
end event

type rb_1 from radiobutton within w_pisp006u
integer x = 41
integer y = 248
integer width = 357
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���԰���"
boolean checked = true
end type

event clicked;If Checked Then
	is_tempgubun = "N"
	st_rackqty.Visible	= False
	sle_rackqty.Visible	= False
	wf_retrieve()
Else
	rb_2.Checked	= False
End If
end event

type dw_kbno from datawindow within w_pisp006u
integer x = 46
integer y = 704
integer width = 3301
integer height = 1164
string title = "none"
string dataobject = "d_pisp006u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If CurrentRow > 0 Then
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
End If
end event

type st_msg from statictext within w_pisp006u
integer x = 32
integer y = 424
integer width = 1865
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "~'���� ���� �� ����~' ��ư�� Ŭ���Ͻø� ���ǹ�ȣ�� �����ǰ�"
boolean focusrectangle = false
end type

type uo_division from u_pisc_select_division within w_pisp006u
integer x = 544
integer y = 64
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_kbno.SetTransObject(SQLPIS)
	//dw_kbno_buffer.SetTransObject(SQLPIS)
	dw_save_kbno.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	dw_print_save.SetTransObject(SQLPIS)
	dw_save_active.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type uo_area from u_pisc_select_area within w_pisp006u
integer x = 41
integer y = 64
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_kbno.SetTransObject(SQLPIS)
	//dw_kbno_buffer.SetTransObject(SQLPIS)
	dw_save_kbno.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	dw_print_save.SetTransObject(SQLPIS)
	dw_save_active.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type cb_2 from commandbutton within w_pisp006u
integer x = 2921
integer y = 436
integer width = 393
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� ��(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type cb_1 from commandbutton within w_pisp006u
integer x = 2203
integer y = 436
integer width = 713
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���� ���� �� ����(&P)"
end type

event clicked;Int		i, li_kbcount, li_rackqty, li_rowcount
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_applyfrom, ls_kbno, ls_kbsn, ls_normalkbsn, ls_tempkbsn, &
			ls_kbno_1, ls_kbno_2, ls_kbno_3, ls_errortext
Boolean	lb_error, lb_error_print

// ����ż� �� ������� ��Ȯ���� Ȯ������.
If is_tempgubun = "N" Then
	If IsNumber(Trim(sle_kbcount.Text)) = True Then
		//
	Else
		MessageBox("���� ����", "���� �ż��� ��Ȯ�� �Է��Ͽ� �ֽʽÿ�.", Exclamation!)
		Return
	End If
	
	If Integer(Trim(sle_kbcount.Text))	> 0 Then
		//
	Else
		MessageBox("���� ����", "���� �ż��� '0' ���� Ŀ�� �մϴ�.", Exclamation!)
		Return
	End If
Else
	If IsNumber(Trim(sle_kbcount.Text)) = True Then
		//
	Else
		MessageBox("���� ����", "���� �ż��� ��Ȯ�� �Է��Ͽ� �ֽʽÿ�.", Exclamation!)
		Return
	End If
	
	If Integer(Trim(sle_kbcount.Text))	> 0 Then
		//
	Else
		MessageBox("���� ����", "���� �ż��� '0' ���� Ŀ�� �մϴ�.", Exclamation!)
		Return
	End If

	If IsNumber(Trim(sle_rackqty.Text)) = True Then
		//
	Else
		MessageBox("���� ����", "������� ��Ȯ�� �Է��Ͽ� �ֽʽÿ�.", Exclamation!)
		Return
	End If
	
	If Integer(Trim(sle_rackqty.Text))	> 0 Then
		//
	Else
		MessageBox("���� ����", "������� '0' ���� Ŀ�� �մϴ�.", Exclamation!)
		Return
	End If
End If

// ������� ��ȣ���� �� �μ�
If MessageBox("���� ����", "������ ���� �Ͻðڽ��ϱ�?", Question!, YesNo!, 2) = 2 Then
	Return
End If

li_kbcount	= Integer(Trim(sle_kbcount.Text))

ls_areacode			= Trim(dw_kbno.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_kbno.GetItemString(1, "DivisionCode"))
ls_workcenter		= Trim(dw_kbno.GetItemString(1, "WorkCenter"))
ls_linecode			= Trim(dw_kbno.GetItemString(1, "LineCode"))
ls_itemcode			= Trim(dw_kbno.GetItemString(1, "ItemCode"))
//ls_applyfrom		= Trim(dw_kbno.GetItemString(1, "ApplyFrom"))
ls_applyfrom	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

Select	RackQty,
			NormalKBSN,
			TempKBSN
Into		:li_rackqty,
			:ls_normalkbsn,
			:ls_tempkbsn
From		tmstkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using	SQLPIS;

If is_tempgubun = "N" Then
	ls_kbno		= ls_normalkbsn
	li_rackqty	= li_rackqty
Else
	ls_kbno		= ls_tempkbsn
	li_rackqty	= Integer(Trim(sle_rackqty.Text))
End If

dw_kbno_buffer.ReSet()
dw_save_kbno.ReSet()

// ���� ��ȣ�� ��������.
SQLPIS.AutoCommit = False
For i = 1 To li_kbcount
	If is_tempgubun = "N" Then
		ls_kbsn	= Right(ls_kbno, 3)
		If f_pisc_get_kbno_next_normal(ls_kbsn, ls_kbsn) Then
			ls_kbno	= Left(ls_kbno, 8) + ls_kbsn
			dw_save_kbno.ReSet()
			If dw_save_kbno.Retrieve(	ls_kbno, &
										ls_areacode,			ls_divisioncode, &
										ls_workcenter,			ls_linecode, &
										ls_itemcode,			ls_applyfrom, &
										is_tempgubun,			'N', &
										li_rackqty,				g_s_empno) > 0 Then
				If Upper(dw_save_kbno.GetItemString(1, "Error")) = "00" Then
					lb_error	= False
					ls_errortext	= Trim(dw_save_kbno.GetItemString(1, "ErrorText"))
					dw_kbno_buffer.InsertRow(0)
					dw_kbno_buffer.SetItem(dw_kbno_buffer.RowCount(), "KBNo", ls_kbno)
				Else
					lb_error = True
					ls_errortext	= Trim(dw_save_kbno.GetItemString(1, "ErrorText"))
					Exit
				End If
			Else
				lb_error = True
				ls_errortext	= "���� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
				Exit
			End If
		Else
	//		MessageBox("���� ����", "���� ��ȣ�� �� �̻� ������ �� �����ϴ�.")
		End If
	Else
		ls_kbsn	= Right(ls_kbno, 2)
		If f_pisc_get_kbno_next_temp(ls_kbsn, ls_kbsn) Then
			ls_kbno	= Left(ls_kbno, 9) + ls_kbsn
			dw_save_kbno.ReSet()
			If dw_save_kbno.Retrieve(	ls_kbno, &
										ls_areacode,			ls_divisioncode, &
										ls_workcenter,			ls_linecode, &
										ls_itemcode,			ls_applyfrom, &
										is_tempgubun,			'N', &
										li_rackqty,				g_s_empno) > 0 Then
				If Upper(dw_save_kbno.GetItemString(1, "Error")) = "00" Then
					lb_error	= False
					ls_errortext	= Trim(dw_save_kbno.GetItemString(1, "ErrorText"))
					dw_kbno_buffer.InsertRow(0)
					dw_kbno_buffer.SetItem(dw_kbno_buffer.RowCount(), "KBNo", ls_kbno)
				Else
					lb_error = True
					ls_errortext	= Trim(dw_save_kbno.GetItemString(1, "ErrorText"))
					Exit
				End If
			Else
				lb_error = True
				ls_errortext	= "���� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
				Exit
			End If
		Else
	//		MessageBox("���� ����", "���� ��ȣ�� �� �̻� ������ �� �����ϴ�.")
		End If
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����","���� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Return
Else
	// ������ �ӽð��� ������ ����..�ƹ��͵� ���� ����..
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
End If

li_rowcount	= dw_kbno_buffer.RowCount()
If li_rowcount > 0 Then
	//
Else
	MessageBox("���� ����", "�μ��� �� �ִ� ������ �������� �ʽ��ϴ�." + &
									"~r~n~r~n���ǹ�ȣ�� ���������� �����Ǿ����ϴ�.", Exclamation!)
	Return
End If

dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_1.Text))*100 )  )
//dw_print.Modify("datawindow.print.margin.Right  = " + String( Integer(Trim(Em_Right.Text))*100 ) )
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_2.Text))*100 ) )
//dw_print.Modify("datawindow.print.margin.Bottom = " + String( Integer(Trim(Em_Bottom.Text))*100 ) )

// ������ʹ� �μ⸦ ����...
For i = 1 To li_rowcount
	dw_print.ReSet()
	CHOOSE CASE Mod(i, 3)
		CASE 1
			ls_kbno_1	= Trim(dw_kbno_buffer.GetItemString(i, "KBNo"))
			ls_kbno_2	= ""
			ls_kbno_3	= ""
			If i = li_rowcount Then
				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
					If dw_print.Print() = 1 Then
						dw_print_save.ReSet()
						If dw_print_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
							If Upper(dw_print_save.GetItemString(1, "Error")) = "00" Then
								lb_error	= False
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
							Else
								lb_error = True
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
								Exit
							End If
						Else
							lb_error = True
							ls_errortext	= "���� ���� �μ� ���� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
							Exit
						End If
					Else
						lb_error_print	= True
						Exit
					End If
				Else
					lb_error_print	= True
					Exit
				End If
			End If
		CASE 2
			ls_kbno_2	= Trim(dw_kbno_buffer.GetItemString(i, "KBNo"))
			ls_kbno_3	= ""
			If i = li_rowcount Then
				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
					If dw_print.Print() = 1 Then
						dw_print_save.ReSet()
						If dw_print_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
							If Upper(dw_print_save.GetItemString(1, "Error")) = "00" Then
								lb_error	= False
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
							Else
								lb_error = True
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
								Exit
							End If
						Else
							lb_error = True
							ls_errortext	= "���� �μ� ���� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
							Exit
						End If
					Else
						lb_error_print	= True
						Exit
					End If
				Else
					lb_error_print	= True
					Exit
				End If
			End If
		CASE 0
			ls_kbno_3	= Trim(dw_kbno_buffer.GetItemString(i, "KBNo"))
			If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
				If dw_print.Print() = 1 Then
					dw_print_save.ReSet()
					If dw_print_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
						If Upper(dw_print_save.GetItemString(1, "Error")) = "00" Then
							lb_error	= False
							ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
						Else
							lb_error = True
							ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
							Exit
						End If
					Else
						lb_error = True
						ls_errortext	= "���� �μ� ���� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
						Exit
					End If
				Else
					lb_error_print	= True
					Exit
				End If
			Else
				lb_error_print	= True
				Exit
			End If
	END CHOOSE
Next

If lb_error_print Then
	MessageBox("���� ����", "�μ� ����" + &
										"~r~n~r~n���ǹ�ȣ: " + ls_kbno_1 + " " + ls_kbno_2 + " " + ls_kbno_3 + &
										"~r~n~r~n�μ� �߿� ������ �߻��߽��ϴ�.", StopSign!)
	Return
End If

If lb_error Then
	MessageBox("���� ����","���� �μ� ������ �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
										"~r~n~r~n���ǹ�ȣ: " + ls_kbno_1 + " " + ls_kbno_2 + " " + ls_kbno_3 + &
										"~r~n~r~n���� �߿� ������ �߻��߽��ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Return
Else
//	MessageBox("���� ����", "���� �μ� ������ �����Ͽ����ϴ�.", Information!)
End If

// ������ʹ� Active ��ȯ
dw_save_active.ReSet()
SQLPIS.AutoCommit = False
For i = 1 To dw_kbno_buffer.RowCount()
	ls_kbno		= Trim(dw_kbno_buffer.GetItemString(i, "KBNo"))
	dw_save_active.ReSet()
	If dw_save_active.Retrieve(ls_kbno, 'A', g_s_empno) > 0 Then
		If Upper(dw_save_active.GetItemString(1, "Error")) = "00" Then
			lb_error	= False
			ls_errortext	= Trim(dw_save_active.GetItemString(1, "ErrorText"))
		Else
			lb_error = True
			ls_errortext	= Trim(dw_save_active.GetItemString(1, "ErrorText"))
			Exit
		End If
	Else
		lb_error = True
		ls_errortext	= "Active ���� ��ȯ ����� �õ��Ͽ����� ������ �߻��߽��ϴ�."
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����","Sleeping ���� ��ȯ ����� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����", "������ �����Ͽ����ϴ�.", Information!)
	wf_retrieve()
End If
end event

type dw_save_kbno from datawindow within w_pisp006u
integer x = 91
integer y = 1216
integer width = 603
integer height = 288
boolean bringtotop = true
boolean titlebar = true
string title = "���ǹ�ȣ ���� ����"
string dataobject = "d_pisp240u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_4 from groupbox within w_pisp006u
integer x = 1129
integer width = 1289
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisp006u
integer x = 2423
integer width = 960
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_7 from groupbox within w_pisp006u
integer x = 9
integer y = 632
integer width = 3374
integer height = 1268
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "���� ��ǰ�� ���� ��ȣ ����"
end type

type gb_3 from groupbox within w_pisp006u
integer x = 9
integer width = 1115
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisp006u
integer x = 9
integer y = 160
integer width = 800
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_8 from groupbox within w_pisp006u
integer x = 814
integer y = 160
integer width = 1321
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type sle_rackqty from singlelineedit within w_pisp006u
integer x = 1760
integer y = 236
integer width = 315
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp006u
integer x = 9
integer y = 348
integer width = 2126
integer height = 252
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_9 from groupbox within w_pisp006u
integer x = 2139
integer y = 160
integer width = 1243
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_6 from groupbox within w_pisp006u
integer x = 2139
integer y = 348
integer width = 1243
integer height = 252
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
end type

