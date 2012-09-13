$PBExportHeader$w_mpm133i.srw
$PBExportComments$���� �μ��� M/H��Ȳ����
forward
global type w_mpm133i from w_ipis_sheet01
end type
type uo_1 from u_mpms_date_scroll_month within w_mpm133i
end type
type dw_mpm133i_01 from u_vi_std_datawindow within w_mpm133i
end type
type pb_down from picturebutton within w_mpm133i
end type
type dw_report from datawindow within w_mpm133i
end type
type gb_1 from groupbox within w_mpm133i
end type
end forward

global type w_mpm133i from w_ipis_sheet01
uo_1 uo_1
dw_mpm133i_01 dw_mpm133i_01
pb_down pb_down
dw_report dw_report
gb_1 gb_1
end type
global w_mpm133i w_mpm133i

on w_mpm133i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_mpm133i_01=create dw_mpm133i_01
this.pb_down=create pb_down
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_mpm133i_01
this.Control[iCurrent+3]=this.pb_down
this.Control[iCurrent+4]=this.dw_report
this.Control[iCurrent+5]=this.gb_1
end on

on w_mpm133i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_mpm133i_01)
destroy(this.pb_down)
destroy(this.dw_report)
destroy(this.gb_1)
end on

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

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_mpm133i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm133i_01.Height= newheight - ( dw_mpm133i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;
dw_mpm133i_01.settransobject(sqlmpms)
end event

event ue_retrieve;call super::ue_retrieve;string ls_fromdt, ls_yyyymm

dw_mpm133i_01.reset()

ls_fromdt = string(date(uo_1.is_uo_month + '.01'),'YYYYMMDD')
ls_yyyymm = mid(ls_fromdt,1,6)

if dw_mpm133i_01.retrieve( ls_yyyymm ) < 1 then
	uo_status.st_message.text = "��ȸ�� �ڷᰡ �����ϴ�."
else
	uo_status.st_message.text = "��ȸ�Ǿ����ϴ�."
end if
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_plant,ls_dvsn,ls_vndr,ls_vndm
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//��� �����쿡 Data ����, ��� ������ Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "��� �غ��� �Դϴ�..."

li_rowcnt = dw_mpm133i_01.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_mpm133i_01.sharedata(dw_report)
l_str_prt.title = "�μ��� M/H ��Ȳ"
mod_string =  "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"		

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

type uo_status from w_ipis_sheet01`uo_status within w_mpm133i
end type

type uo_1 from u_mpms_date_scroll_month within w_mpm133i
integer x = 91
integer y = 64
integer taborder = 11
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_date_scroll_month::destroy
end on

event constructor;call super::constructor;string ls_postdate

ls_postdate = string(f_relativedate( mid(g_s_date,1,6) + '01', -1),'@@@@-@@-@@')
This.uf_setdata( date( ls_postdate ) )
end event

type dw_mpm133i_01 from u_vi_std_datawindow within w_mpm133i
integer x = 23
integer y = 188
integer width = 3049
integer height = 1680
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm133i_01"
end type

type pb_down from picturebutton within w_mpm133i
integer x = 869
integer y = 36
integer width = 155
integer height = 132
integer taborder = 11
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

event clicked;f_save_to_excel(dw_mpm133i_01)
end event

type dw_report from datawindow within w_mpm133i
boolean visible = false
integer x = 2446
integer y = 56
integer width = 686
integer height = 400
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm133i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm133i
integer x = 23
integer width = 1083
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

