$PBExportHeader$w_pisp001u.srw
$PBExportComments$��ȹ�й��� ���� - ��ǰ�� ���κ�
forward
global type w_pisp001u from window
end type
type st_modelid from statictext within w_pisp001u
end type
type st_itemname from statictext within w_pisp001u
end type
type st_itemcode from statictext within w_pisp001u
end type
type cb_2 from commandbutton within w_pisp001u
end type
type cb_1 from commandbutton within w_pisp001u
end type
type gb_1 from groupbox within w_pisp001u
end type
type dw_divide from datawindow within w_pisp001u
end type
type gb_2 from groupbox within w_pisp001u
end type
type gb_3 from groupbox within w_pisp001u
end type
end forward

global type w_pisp001u from window
integer width = 3621
integer height = 1408
boolean titlebar = true
string title = "��ǰ�� ��ȹ�й��� ����"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
st_modelid st_modelid
st_itemname st_itemname
st_itemcode st_itemcode
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_divide dw_divide
gb_2 gb_2
gb_3 gb_3
end type
global w_pisp001u w_pisp001u

type variables
Boolean		ib_open
str_parms	istr_parms
end variables

event ue_postopen;dw_divide.SetTransObject(SQLPIS)

// Parent �����쿡�� �Ѿ�� ����...
st_itemcode.Text	= "ǰ��: " + istr_parms.string_arg[4]
st_itemname.Text	= "ǰ��: " + istr_parms.string_arg[5]
st_modelid.Text	= "�ĺ�ID: " + istr_parms.string_arg[6]

cb_1.Enabled = False
dw_divide.ReSet()
dw_divide.Retrieve(istr_parms.string_arg[2], istr_parms.string_arg[3], istr_parms.string_arg[4])

ib_open = True
end event

on w_pisp001u.create
this.st_modelid=create st_modelid
this.st_itemname=create st_itemname
this.st_itemcode=create st_itemcode
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_divide=create dw_divide
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.st_modelid,&
this.st_itemname,&
this.st_itemcode,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_divide,&
this.gb_2,&
this.gb_3}
end on

on w_pisp001u.destroy
destroy(this.st_modelid)
destroy(this.st_itemname)
destroy(this.st_itemcode)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_divide)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;String		ls_size

//Pareant Window�� �߾����� Window�� �̵���Ű�� ���Ͽ� Parent Window�� X,Y,Width,Height ���� ���Ѵ�.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type st_modelid from statictext within w_pisp001u
integer x = 73
integer y = 348
integer width = 2752
integer height = 108
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
string text = "�ĺ�ID :"
boolean focusrectangle = false
end type

type st_itemname from statictext within w_pisp001u
integer x = 146
integer y = 236
integer width = 2793
integer height = 68
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "ǰ�� :"
boolean focusrectangle = false
end type

type st_itemcode from statictext within w_pisp001u
integer x = 146
integer y = 116
integer width = 2789
integer height = 68
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "ǰ�� :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pisp001u
integer x = 3081
integer y = 280
integer width = 393
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� �� (&C)"
end type

event clicked;CloseWithReturn(Parent, "CANCEL")
end event

type cb_1 from commandbutton within w_pisp001u
integer x = 3081
integer y = 124
integer width = 393
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� �� (&S)"
end type

event clicked;int		i, li_dividerate
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

For i = 1 To dw_divide.RowCount()
	li_dividerate		= li_dividerate + dw_divide.GetItemNumber(i, "DivideRate")
Next

If li_dividerate <> 100 Then
	MessageBox("��ǰ�� ��ȹ�й��� ����", "���κ� ��ȹ�й����� ���� '100 %'�� �Ǿ�� �մϴ�.", StopSign!)
	Return
End If

If MessageBox("��ǰ�� ��ȹ�й��� ����","����� ��ȹ�й��� ������ �����Ͻðڽ��ϱ� ?", Question!, YesNo!) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False
For i = 1 To dw_divide.RowCount()
	ls_areacode			= Trim(dw_divide.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_divide.GetItemString(i, "DivisionCode"))
	ls_workcenter		= Trim(dw_divide.GetItemString(i, "WorkCenter"))
	ls_linecode			= Trim(dw_divide.GetItemString(i, "LineCode"))
	ls_itemcode			= Trim(dw_divide.GetItemString(i, "ItemCode"))
	li_dividerate		= dw_divide.GetItemNumber(i, "DivideRate")
	
	Update	tmstkb
		Set	DivideRate		= :li_dividerate,
				LastEmp			= 'Y',
				LastDate			= GetDate()
	 Where	AreaCode			= :ls_areacode
		And	DivisionCode	= :ls_divisioncode
		And	WorkCenter		= :ls_workcenter
		And	LineCode			= :ls_linecode
		And	ItemCode		= :ls_itemcode
	Using SQLPIS;
	If SQLPIS.sqlcode = 0 Then
		lb_error	= False
	Else
		lb_error = True
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
//	uo_status.st_message.text =  "Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("��ǰ�� ��ȹ�й��� ����", "��ȹ�й��� ���� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
//	uo_status.st_message.text =  "Work Calendar ������ �����Ͽ����ϴ�." // + f_message("Work Calendar ������ �����Ͽ����ϴ�.")
	MessageBox("��ǰ�� ��ȹ�й��� ����", "��ȹ�й��� ���� ������ �����Ͽ����ϴ�.", Information!)
End If

//CloseWithReturn(Parent, "CHANGE")
end event

type gb_1 from groupbox within w_pisp001u
integer x = 23
integer y = 20
integer width = 2953
integer height = 476
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "��ǰ ����"
borderstyle borderstyle = stylelowered!
end type

type dw_divide from datawindow within w_pisp001u
integer x = 59
integer y = 600
integer width = 3456
integer height = 644
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp001u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//Visible	= False
end event

event rowfocuschanged;If CurrentRow > 0 Then
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
End If
end event

event editchanged;AcceptText()
If row > 0 Then
	cb_1.Enabled = True
End If
end event

event itemerror;Return 1
end event

type gb_2 from groupbox within w_pisp001u
integer x = 23
integer y = 528
integer width = 3529
integer height = 748
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��ȹ�й��� ����"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp001u
integer x = 2999
integer y = 20
integer width = 553
integer height = 476
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

