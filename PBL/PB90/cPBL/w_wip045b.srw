$PBExportHeader$w_wip049i.srw
$PBExportComments$�ҿ����ǰ����ȸ(����)
forward
global type w_wip049i from w_ipis_sheet01
end type
type dw_wip049i_02 from u_vi_std_datawindow within w_wip049i
end type
type dw_wip049i_01 from datawindow within w_wip049i
end type
type pb_down from picturebutton within w_wip049i
end type
type st_1 from statictext within w_wip049i
end type
type gb_1 from groupbox within w_wip049i
end type
end forward

global type w_wip049i from w_ipis_sheet01
string title = "�𵨺� ����ҿ����� ��ȸ"
dw_wip049i_02 dw_wip049i_02
dw_wip049i_01 dw_wip049i_01
pb_down pb_down
st_1 st_1
gb_1 gb_1
end type
global w_wip049i w_wip049i

on w_wip049i.create
int iCurrent
call super::create
this.dw_wip049i_02=create dw_wip049i_02
this.dw_wip049i_01=create dw_wip049i_01
this.pb_down=create pb_down
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_wip049i_02
this.Control[iCurrent+2]=this.dw_wip049i_01
this.Control[iCurrent+3]=this.pb_down
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_wip049i.destroy
call super::destroy
destroy(this.dw_wip049i_02)
destroy(this.dw_wip049i_01)
destroy(this.pb_down)
destroy(this.st_1)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_iocd, ls_fromdt, ls_todt, ls_dategap

if f_wip_mandantory_chk( dw_wip049i_01 ) = -1 then 
	uo_status.st_message.text = f_message("E010")
	return 0
end if

ls_iocd   = dw_wip049i_01.getitemstring(1,"wip001_waiocd")

ls_dategap = trim(dw_wip049i_01.getitemstring(1,"inv101_xunit"))

ls_todt = dw_wip049i_01.getitemstring(1,"wip001_wainptdt")
if f_dateedit(ls_todt + '01') = space(8) then
	uo_status.st_message.text = "���س�¥�� �ùٸ��� �ʽ��ϴ�."
	return 0
end if

Choose case ls_dategap
	case '1'
		ls_fromdt = f_relative_month(ls_todt,-1)
	case '3'
		ls_fromdt = f_relative_month(ls_todt,-3)
	case '6'
		ls_fromdt = f_relative_month(ls_todt,-6)
	case '9'
		ls_fromdt = f_relative_month(ls_todt,-9)
	case '12'
		ls_fromdt = f_relative_month(ls_todt,-12)
	case else
		return 0
end choose

dw_wip049i_02.reset()
dw_wip049i_02.retrieve(mid(ls_fromdt,1,6),mid(ls_todt,1,4), mid(ls_todt,5,2),ls_todt)

uo_status.st_message.text = string(mid(ls_fromdt,1,6),"@@@@.@@") + " - " &
		+ string(mid(f_relative_month(ls_todt,-1),1,6),"@@@@.@@") + " �Ⱓ�� �ҿ���� ǰ�������Դϴ�."
end event

event ue_postopen;call super::ue_postopen;
dw_wip049i_01.settransobject(sqlca)
dw_wip049i_02.settransobject(sqlca)

dw_wip049i_01.insertrow(0)
dw_wip049i_01.setitem(1,"wip001_waiocd",'1')
dw_wip049i_01.setitem(1,"wip001_wainptdt",mid(g_s_date,1,6))
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_wip049i_02.Width = newwidth - ls_status
dw_wip049i_02.Height= newheight - (dw_wip049i_02.y + ls_status)

end event

type uo_status from w_ipis_sheet01`uo_status within w_wip049i
end type

type dw_wip049i_02 from u_vi_std_datawindow within w_wip049i
integer x = 23
integer y = 360
integer width = 3383
integer height = 1508
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip049i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_wip049i_01 from datawindow within w_wip049i
integer x = 50
integer y = 40
integer width = 3049
integer height = 172
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip049i_01"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1,cdw_2

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()

if ls_colname = 'wip001_waiocd' then
	if data = '2' then
		dw_wip049i_02.dataobject = "d_wip049i_03"
		dw_wip049i_02.settransobject(sqlca)
	else
		dw_wip049i_02.dataobject = "d_wip049i_02"
		dw_wip049i_02.settransobject(sqlca)
	end if
end if

end event

type pb_down from picturebutton within w_wip049i
integer x = 3173
integer y = 52
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip049i_02.rowcount() > 1 then
	f_save_to_excel_number(dw_wip049i_02)
end if
end event

type st_1 from statictext within w_wip049i
integer x = 27
integer y = 272
integer width = 2647
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "�ҿ����ǰ�� : �Ⱓ���ȿ� ������� �Ǵ� ��ǰ�԰� ���� ������ ������ ���� ǰ��"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_wip049i
integer x = 23
integer width = 3387
integer height = 232
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

