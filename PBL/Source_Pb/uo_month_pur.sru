$PBExportHeader$uo_month_pur.sru
$PBExportComments$���� ���� - ������ - ��ũ�� ��� - is_uo_month
forward
global type uo_month_pur from u_vi_cst_basic
end type
type st_1 from statictext within uo_month_pur
end type
type em_date from editmask within uo_month_pur
end type
type vsb_1 from vscrollbar within uo_month_pur
end type
end forward

global type uo_month_pur from u_vi_cst_basic
integer width = 576
integer height = 76
long backcolor = 12632256
event ue_select ( )
event ue_movefocus pbm_custom01
st_1 st_1
em_date em_date
vsb_1 vsb_1
end type
global uo_month_pur uo_month_pur

type variables
string	is_uo_month
end variables

forward prototypes
public subroutine uf_setfocus ()
public subroutine uf_setdata (date ad_value)
public subroutine uf_setcolor (string as_color)
end prototypes

event ue_movefocus;This.SetFocus()
end event

public subroutine uf_setfocus ();//Set Focus
em_date.SetFocus()
end subroutine

public subroutine uf_setdata (date ad_value);em_date.text = String( ad_value )
//Trigger Modified Event
//���� ����
is_uo_month	= Left(Trim(em_date.text), 7)

TriggerEvent("ue_select")
end subroutine

public subroutine uf_setcolor (string as_color);/*
	�������� ����
*/
//	 l_l_color1 = 15780518 ,l_l_color2 = 16777215 ,l_l_color3 = 12632256  ,l_l_color4 = 65535
//	                 sky                     white                  gray                   yellow
as_color = Upper(Trim(as_color))

IF as_color = "S"  Then
	em_date.BackColor = 	15780518	//sky
ElseIf as_color = "G" Then
	em_date.BackColor = 	12632256	//gray
Else
	em_date.BackColor = 	16777215	//white
End IF

end subroutine

event uf_getdata;This.SetFocus()
end event

event constructor;call super::constructor;//�ʱ� ������ �������ڸ� ����
em_date.text = String (today())

//���� ����
is_uo_month	= Left(Trim(em_date.text), 7)

TriggerEvent("ue_select")
end event

on uo_month_pur.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_date=create em_date
this.vsb_1=create vsb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_date
this.Control[iCurrent+3]=this.vsb_1
end on

on uo_month_pur.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_date)
destroy(this.vsb_1)
end on

type st_1 from statictext within uo_month_pur
integer y = 8
integer width = 224
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���ؿ�:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within uo_month_pur
event ue_keyenter pbm_keydown
integer x = 233
integer width = 265
integer height = 68
integer taborder = 1
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm"
boolean autoskip = true
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
End If
end event

event losefocus;// 2001.12.06 - ��¥ �Է½� �߸��� �Է� ����
IF IsDate(This.text + '.01') = False THEN
	MessageBox("�� ����", "�߸��� �� �Դϴ�." + &
									"~r~n��Ȯ�� �� �Է��Ͻʽÿ�." + &
									"~r~n~r~n�� �Է�(��) : 2002.09 ����")
//	This.text = String(Today())
	This.text = is_uo_month + ".01"
	Return
END IF	

is_uo_month	= Left(Trim(em_date.text), 7)

Parent.TriggerEvent("ue_select")
end event

type vsb_1 from vscrollbar within uo_month_pur
integer x = 498
integer width = 73
integer height = 72
end type

event lineup;//////////////////////////////////////////////////////////////////////
// Increase the date by one month
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
IF li_ret <> 0 THEN
	em_date.text = String(Relativedate(ld_date, 35))
ELSE
	em_date.text = String(Today())
END IF

is_uo_month	= Left(Trim(em_date.text), 7)

Parent.TriggerEvent("ue_select")


end event

event linedown;//////////////////////////////////////////////////////////////////////
// Decrease the date by one month
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
INT		li_change_days
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
//���� ���� ���Ϸ� �̷�� ������ ���Ѵ�
IF li_ret <> 0 then 
	em_date.text = String(Relativedate(ld_date, -1))
ELSE
	em_date.text = String(Today())
END IF

is_uo_month	= Left(Trim(em_date.text), 7)

Parent.TriggerEvent("ue_select")


end event

