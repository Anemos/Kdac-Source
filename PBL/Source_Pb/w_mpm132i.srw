$PBExportHeader$w_mpm132i.srw
$PBExportComments$�μ�,�𵨺� �۾��Ϸ�ǥ
forward
global type w_mpm132i from w_ipis_sheet01
end type
type dw_mpm132i_01 from u_vi_std_datawindow within w_mpm132i
end type
type pb_down from picturebutton within w_mpm132i
end type
type uo_from from u_mpms_date_applydate within w_mpm132i
end type
type uo_to from u_mpms_date_applydate_1 within w_mpm132i
end type
type st_1 from statictext within w_mpm132i
end type
type dw_report from datawindow within w_mpm132i
end type
type rb_ing from radiobutton within w_mpm132i
end type
type rb_end from radiobutton within w_mpm132i
end type
type gb_1 from groupbox within w_mpm132i
end type
end forward

global type w_mpm132i from w_ipis_sheet01
dw_mpm132i_01 dw_mpm132i_01
pb_down pb_down
uo_from uo_from
uo_to uo_to
st_1 st_1
dw_report dw_report
rb_ing rb_ing
rb_end rb_end
gb_1 gb_1
end type
global w_mpm132i w_mpm132i

on w_mpm132i.create
int iCurrent
call super::create
this.dw_mpm132i_01=create dw_mpm132i_01
this.pb_down=create pb_down
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_1=create st_1
this.dw_report=create dw_report
this.rb_ing=create rb_ing
this.rb_end=create rb_end
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm132i_01
this.Control[iCurrent+2]=this.pb_down
this.Control[iCurrent+3]=this.uo_from
this.Control[iCurrent+4]=this.uo_to
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.rb_ing
this.Control[iCurrent+8]=this.rb_end
this.Control[iCurrent+9]=this.gb_1
end on

on w_mpm132i.destroy
call super::destroy
destroy(this.dw_mpm132i_01)
destroy(this.pb_down)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_1)
destroy(this.dw_report)
destroy(this.rb_ing)
destroy(this.rb_end)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_mpm132i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm132i_01.Height= newheight - ( dw_mpm132i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_mpm132i_01.dataobject = 'd_mpm132i_01'
dw_mpm132i_01.settransobject(sqlmpms)
end event

event ue_retrieve;call super::ue_retrieve;string ls_fromdt, ls_todt

dw_mpm132i_01.reset()

ls_fromdt = uo_from.is_uo_date
ls_todt = uo_to.is_uo_date

if dw_mpm132i_01.retrieve( ls_fromdt, ls_todt ) < 1 then
	uo_status.st_message.text = "��ȸ�� �ڷᰡ �����ϴ�."
else
	uo_status.st_message.text = "��ȸ�Ǿ����ϴ�."
end if
end event

event open;call super::open;// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_plant,ls_dvsn,ls_vndr,ls_vndm
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//��� �����쿡 Data ����, ��� ������ Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "��� �غ��� �Դϴ�..."

li_rowcnt = dw_mpm132i_01.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_mpm132i_01.sharedata(dw_report)
l_str_prt.title = "�μ��� MODEL�� �۾�����ǥ"
if rb_ing.checked then
	mod_string =  "t_kijun.text = '( ���� )'" + &
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"		
else
	mod_string =  "t_kijun.text = '( �Ϸ� )'" + & 
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
end if

//�μ� DataWindow ����
//w_easy_prt�� dwsyntax�� ���� modify()���� �߰���
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open�� ���Window �ݱ�
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm132i
end type

type dw_mpm132i_01 from u_vi_std_datawindow within w_mpm132i
integer x = 18
integer y = 184
integer width = 3136
integer height = 1700
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_mpm132i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type pb_down from picturebutton within w_mpm132i
integer x = 1966
integer y = 32
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_mpm132i_01)
end event

type uo_from from u_mpms_date_applydate within w_mpm132i
event destroy ( )
integer x = 686
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_from.destroy
call u_mpms_date_applydate::destroy
end on

type uo_to from u_mpms_date_applydate_1 within w_mpm132i
event destroy ( )
integer x = 1431
integer y = 64
integer taborder = 40
boolean bringtotop = true
end type

on uo_to.destroy
call u_mpms_date_applydate_1::destroy
end on

type st_1 from statictext within w_mpm132i
integer x = 1367
integer y = 60
integer width = 59
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_report from datawindow within w_mpm132i
boolean visible = false
integer x = 2139
integer y = 28
integer width = 686
integer height = 400
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_mpm132i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_ing from radiobutton within w_mpm132i
integer x = 73
integer y = 64
integer width = 242
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "����"
end type

event clicked;dw_mpm132i_01.dataobject = 'd_mpm132i_01'
dw_mpm132i_01.settransobject(sqlmpms)
end event

type rb_end from radiobutton within w_mpm132i
integer x = 338
integer y = 64
integer width = 242
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "�Ϸ�"
end type

event clicked;dw_mpm132i_01.dataobject = 'd_mpm132i_02'
dw_mpm132i_01.settransobject(sqlmpms)
end event

type gb_1 from groupbox within w_mpm132i
integer x = 18
integer width = 2199
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

