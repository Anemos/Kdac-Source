$PBExportHeader$w_pisq420i.srw
$PBExportComments$RRPPM ����(����, CUSTOMER��)
forward
global type w_pisq420i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq420i
end type
type dw_pisq420i_01 from u_vi_std_datawindow within w_pisq420i
end type
type gb_2 from groupbox within w_pisq420i
end type
type uo_custcode from u_piss_select_custcode within w_pisq420i
end type
type st_8 from statictext within w_pisq420i
end type
type uo_scustgubun from u_pisc_select_code within w_pisq420i
end type
type uo_monthto from u_pisc_date_scroll_month within w_pisq420i
end type
type gb_3 from groupbox within w_pisq420i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq420i
end type
type st_3 from statictext within w_pisq420i
end type
type st_5 from statictext within w_pisq420i
end type
type dw_print from datawindow within w_pisq420i
end type
type cbx_all from checkbox within w_pisq420i
end type
end forward

global type w_pisq420i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "RRPPM ����(����, CUSTOMER��)"
uo_area uo_area
dw_pisq420i_01 dw_pisq420i_01
gb_2 gb_2
uo_custcode uo_custcode
st_8 st_8
uo_scustgubun uo_scustgubun
uo_monthto uo_monthto
gb_3 gb_3
uo_month uo_month
st_3 st_3
st_5 st_5
dw_print dw_print
cbx_all cbx_all
end type
global w_pisq420i w_pisq420i

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

on w_pisq420i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.dw_pisq420i_01=create dw_pisq420i_01
this.gb_2=create gb_2
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.uo_monthto=create uo_monthto
this.gb_3=create gb_3
this.uo_month=create uo_month
this.st_3=create st_3
this.st_5=create st_5
this.dw_print=create dw_print
this.cbx_all=create cbx_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.dw_pisq420i_01
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.uo_custcode
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.uo_scustgubun
this.Control[iCurrent+7]=this.uo_monthto
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.uo_month
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.dw_print
this.Control[iCurrent+13]=this.cbx_all
end on

on w_pisq420i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.dw_pisq420i_01)
destroy(this.gb_2)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.uo_monthto)
destroy(this.gb_3)
destroy(this.uo_month)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.dw_print)
destroy(this.cbx_all)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq020i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_raisedateFm, ls_raisedateTo, ls_customercode

// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_customercode	= is_custcode
ls_raisedateFm		= uo_month.is_uo_month
ls_raisedateTo		= uo_monthto.is_uo_month

// ��ü�� ���õǸ�
//
IF cbx_all.Checked = TRUE THEN
	ls_customercode = '%'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq420i_01.Retrieve(ls_areacode, ls_customercode, ls_raisedatefm, ls_raisedateto)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq420i_01, 1, True)	

end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// ������ �������� �缳���Ѵ�
//
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )


end event

event ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq420i_01.SetTransObject(SQLEIS)

ib_open = True
end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

String ls_codegroup, ls_codegroupname, ls_codename
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

event ue_print;call super::ue_print;
String		ls_date, ls_areaname
transaction	ls_trans
str_easy		lstr_prt
window		lw_open

dw_pisq420i_01.ShareData(dw_print)

ls_trans	= SQLEIS

ls_date		= uo_month.is_uo_month + ' - ' + uo_monthto.is_uo_month
ls_areaname	= uo_area.is_uo_areaname

// �μ� DataWindow ����
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"RRPPM ����(����, CUSTOMER��)"
lstr_prt.tag			= 	This.ClassName()
lstr_prt.dwsyntax 	= "t_date.text = '" + ls_date + "'" + "t_areaname.text = '" + ls_areaname + "'"

f_close_report("2", lstr_prt.title)						// Open�� ���Window �ݱ�
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq420i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq420i
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_empno					��ȸ�ϰ��� �ϴ� ��� (������/���庰 ���ѿ� ���� ��ȸ�� ���Ͽ�)
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ���� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�����ڵ�� '%', ������� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_divisioncode		���õ� ���� �ڵ� (reference)
//						string			rs_divisionname		���õ� ���� �� (reference)
//						string			rs_divisionnameeng	���õ� ���� ���� �� (reference)
//	Returns		: none
//	Description	: ������ �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//If ib_open Then
//	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
//											g_s_empno, &
//											uo_area.is_uo_areacode, &
//											'%', &
//											TRUE, &
//											uo_division.is_uo_divisioncode, &
//											uo_division.is_uo_divisionname, &
//											uo_division.is_uo_divisionnameeng)
//	
//End If


end event

event ue_post_constructor;call super::ue_post_constructor;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_empno					��ȸ�ϰ��� �ϴ� ��� (������/���庰 ���ѿ� ���� ��ȸ�� ���Ͽ�)
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ���� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�����ڵ�� '%', ������� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_divisioncode		���õ� ���� �ڵ� (reference)
//						string			rs_divisionname		���õ� ���� �� (reference)
//						string			rs_divisionnameeng	���õ� ���� ���� �� (reference)
//	Returns		: none
//	Description	: ������ �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
//datawindow 	ldw_division
//ldw_division = uo_division.dw_1
//ls_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
//

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type dw_pisq420i_01 from u_vi_std_datawindow within w_pisq420i
integer x = 46
integer y = 216
integer width = 4169
integer height = 2320
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq420i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_pisq420i
integer x = 18
integer y = 12
integer width = 4229
integer height = 168
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_custcode from u_piss_select_custcode within w_pisq420i
event destroy ( )
integer x = 2793
integer y = 60
integer width = 987
integer taborder = 50
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
//dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type st_8 from statictext within w_pisq420i
integer x = 1714
integer y = 68
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "������:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq420i
event destroy ( )
integer x = 2011
integer y = 60
integer width = 713
integer taborder = 40
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event constructor;call super::constructor;postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)
//dw_sheet.reset()

end event

event ue_post_constructor;string ls_custname
//is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)


end event

type uo_monthto from u_pisc_date_scroll_month within w_pisq420i
event destroy ( )
integer x = 1024
integer y = 60
integer height = 80
integer taborder = 50
boolean bringtotop = true
end type

on uo_monthto.destroy
call u_pisc_date_scroll_month::destroy
end on

type gb_3 from groupbox within w_pisq420i
integer x = 18
integer y = 184
integer width = 4229
integer height = 2380
integer taborder = 70
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_month from u_pisc_date_scroll_month within w_pisq420i
event destroy ( )
integer x = 622
integer y = 60
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type st_3 from statictext within w_pisq420i
integer x = 1193
integer y = 60
integer width = 59
integer height = 68
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisq420i
integer x = 622
integer y = 68
integer width = 229
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�߻���:"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_pisq420i
boolean visible = false
integer x = 41
integer y = 432
integer width = 3479
integer height = 1480
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq420i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_all from checkbox within w_pisq420i
integer x = 3899
integer y = 68
integer width = 201
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��ü"
boolean lefttext = true
end type

