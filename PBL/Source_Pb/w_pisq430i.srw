$PBExportHeader$w_pisq430i.srw
$PBExportComments$RRPPM �� ������Ȳ
forward
global type w_pisq430i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq430i
end type
type uo_division from u_pisc_select_division within w_pisq430i
end type
type dw_pisq430i_01 from u_vi_std_datawindow within w_pisq430i
end type
type gb_2 from groupbox within w_pisq430i
end type
type uo_custcode from u_piss_select_custcode within w_pisq430i
end type
type st_8 from statictext within w_pisq430i
end type
type uo_scustgubun from u_pisc_select_code within w_pisq430i
end type
type dw_print from datawindow within w_pisq430i
end type
type uo_year from u_pisc_date_scroll_year within w_pisq430i
end type
type st_5 from statictext within w_pisq430i
end type
type cbx_all from checkbox within w_pisq430i
end type
type gb_3 from groupbox within w_pisq430i
end type
end forward

global type w_pisq430i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "RRPPM �� ������Ȳ"
uo_area uo_area
uo_division uo_division
dw_pisq430i_01 dw_pisq430i_01
gb_2 gb_2
uo_custcode uo_custcode
st_8 st_8
uo_scustgubun uo_scustgubun
dw_print dw_print
uo_year uo_year
st_5 st_5
cbx_all cbx_all
gb_3 gb_3
end type
global w_pisq430i w_pisq430i

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

on w_pisq430i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq430i_01=create dw_pisq430i_01
this.gb_2=create gb_2
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.dw_print=create dw_print
this.uo_year=create uo_year
this.st_5=create st_5
this.cbx_all=create cbx_all
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq430i_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.uo_custcode
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.uo_scustgubun
this.Control[iCurrent+8]=this.dw_print
this.Control[iCurrent+9]=this.uo_year
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.cbx_all
this.Control[iCurrent+12]=this.gb_3
end on

on w_pisq430i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq430i_01)
destroy(this.gb_2)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.dw_print)
destroy(this.uo_year)
destroy(this.st_5)
destroy(this.cbx_all)
destroy(this.gb_3)
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
String	ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode

// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_raisedate		= uo_year.is_uo_year + '.12.01'
ls_customercode	= is_custcode

// ��ü�� ���õǸ�
//
IF cbx_all.Checked = TRUE THEN
	ls_customercode = '%'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq430i_01.Retrieve(ls_areacode, ls_divisioncode, ls_customercode, ls_raisedate)


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
dw_pisq430i_01.SetTransObject(SQLEIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
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
String		ls_year, ls_areaname, ls_divisionname
transaction	ls_trans
str_easy		lstr_prt
window		lw_open

dw_pisq430i_01.ShareData(dw_print)

ls_trans	= SQLEIS

//dw_print.modify("t_year.text   	= '" + ls_DeliveryNo + "'")

ls_year 			= uo_year.is_uo_year + '��'
ls_areaname		= uo_area.is_uo_areaname
ls_divisionname= uo_division.is_uo_divisionname

// �μ� DataWindow ����
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"WARRANTY ǰ������(�����ݾ�) - ����24���� ��� ���"
lstr_prt.tag			= 	This.ClassName()
lstr_prt.dwsyntax 	= "t_year.text   	= '" + ls_year + "'" + "t_areaname.text   	= '" + ls_areaname + "'" + "t_divisionname.text   	= '" + ls_divisionname + "'"

f_close_report("2", lstr_prt.title)						// Open�� ���Window �ݱ�
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq430i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq430i
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
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

If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
End If


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

type uo_division from u_pisc_select_division within w_pisq430i
event destroy ( )
integer x = 613
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		:	f_pisc_retrieve_dddw_productgroup
////	Access		:	public
////	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
////						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
////						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
////						string			fs_productgroup		��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
////						boolean			fb_allflag				��ȸ�� ��ǰ�� ������ 2�� �̻��� Record �� ���
////																		True : '��ü' �׸� ���� (��ǰ���ڵ�� '%', ��ǰ������ '��ü')
////																		False : '��ü' �׸� �� ����
////						string			rs_productgroup		���õ� ��ǰ�� �ڵ� (reference)
////						string			rs_productgroupname	���õ� ��ǰ�� �� (reference)
////	Returns		: none
////	Description	: ��ǰ���� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Kim Jin-Su
//// Coded Date	: 2002.09.04
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//If ib_open Then
//	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											'%', &
//											True, &
//											uo_productgroup.is_uo_productgroup, &
//											uo_productgroup.is_uo_productgroupname)
//											
//	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_productgroup.is_uo_productgroup, &
//											'%', &
//											True, &
//											uo_modelgroup.is_uo_modelgroup, &
//											uo_modelgroup.is_uo_modelgroupname)
//
////	iw_this.TriggerEvent("ue_reset")
//End If
//
//
//
end event

type dw_pisq430i_01 from u_vi_std_datawindow within w_pisq430i
integer x = 46
integer y = 216
integer width = 4535
integer height = 2332
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq430i_01"
boolean vscrollbar = true
end type

event rowfocuschanged;//
end event

event clicked;//
end event

type gb_2 from groupbox within w_pisq430i
integer x = 18
integer y = 12
integer width = 4594
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

type uo_custcode from u_piss_select_custcode within w_pisq430i
event destroy ( )
integer x = 2898
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

type st_8 from statictext within w_pisq430i
integer x = 1838
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
string text = "��������:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq430i
event destroy ( )
integer x = 2126
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

type dw_print from datawindow within w_pisq430i
boolean visible = false
integer x = 1202
integer y = 1016
integer width = 1943
integer height = 1064
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq430i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_year from u_pisc_date_scroll_year within w_pisq430i
event destroy ( )
integer x = 1248
integer y = 64
integer taborder = 50
boolean bringtotop = true
end type

on uo_year.destroy
call u_pisc_date_scroll_year::destroy
end on

type st_5 from statictext within w_pisq430i
integer x = 1243
integer y = 72
integer width = 233
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
string text = "�����:"
boolean focusrectangle = false
end type

type cbx_all from checkbox within w_pisq430i
integer x = 4027
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

type gb_3 from groupbox within w_pisq430i
integer x = 18
integer y = 184
integer width = 4594
integer height = 2392
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
