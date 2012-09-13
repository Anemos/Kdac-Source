$PBExportHeader$w_pisq370i.srw
$PBExportComments$�߻����� Warranty �ҷ����� ��Ȳ
forward
global type w_pisq370i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq370i
end type
type uo_division from u_pisc_select_division within w_pisq370i
end type
type gb_2 from groupbox within w_pisq370i
end type
type dw_pisq370i_01 from datawindow within w_pisq370i
end type
type st_3 from statictext within w_pisq370i
end type
type sle_itemcode from singlelineedit within w_pisq370i
end type
type sle_itemname from singlelineedit within w_pisq370i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq370i
end type
type pb_serch from picturebutton within w_pisq370i
end type
type dw_print from datawindow within w_pisq370i
end type
type gb_3 from groupbox within w_pisq370i
end type
end forward

global type w_pisq370i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "�߻����� Warranty �ҷ����� ��Ȳ"
uo_area uo_area
uo_division uo_division
gb_2 gb_2
dw_pisq370i_01 dw_pisq370i_01
st_3 st_3
sle_itemcode sle_itemcode
sle_itemname sle_itemname
uo_month uo_month
pb_serch pb_serch
dw_print dw_print
gb_3 gb_3
end type
global w_pisq370i w_pisq370i

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open
str_pisr_partkb istr_partkb

end variables

on w_pisq370i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_2=create gb_2
this.dw_pisq370i_01=create dw_pisq370i_01
this.st_3=create st_3
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.uo_month=create uo_month
this.pb_serch=create pb_serch
this.dw_print=create dw_print
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_pisq370i_01
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_itemcode
this.Control[iCurrent+7]=this.sle_itemname
this.Control[iCurrent+8]=this.uo_month
this.Control[iCurrent+9]=this.pb_serch
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.gb_3
end on

on w_pisq370i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_2)
destroy(this.dw_pisq370i_01)
destroy(this.st_3)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.uo_month)
destroy(this.pb_serch)
destroy(this.dw_print)
destroy(this.gb_3)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq290i_01, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_itemcode, ls_date

// �ʼ� �Է��׸� üũ
//
IF f_checknullorspace(sle_itemcode.Text) = TRUE THEN
	MessageBox('Ȯ ��', 'ǰ���� �Է��ϼ���', StopSign!)
	sle_itemcode.SetFocus()
	RETURN
END IF

// ��ȸ������ ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_itemcode			= sle_itemcode.Text
ls_Date				= uo_month.is_uo_month + '.01'

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq370i_01.Retrieve(ls_areacode, ls_DivisionCode, ls_itemcode, ls_date)



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
dw_pisq370i_01.SetTransObject(SQLPIS)

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

event ue_print;call super::ue_print;
String		ls_area, ls_division, ls_date, ls_item
transaction	ls_trans
str_easy		lstr_prt
window		lw_open

dw_pisq370i_01.ShareData(dw_print)

ls_trans	= SQLPIS

ls_area		= uo_area.is_uo_areaname
ls_division	= uo_division.is_uo_divisionname
ls_date		= uo_month.is_uo_month
ls_item		= sle_itemcode.Text + '(' + sle_itemname.Text + ')'

MessageBox('Ȯ ��', '��½� ������ 97%�� �Ͽ� ����ϼ���')

// �μ� DataWindow ����
//
lstr_prt.transaction	= ls_trans
lstr_prt.datawindow	= dw_print
lstr_prt.title			= "�߻����� Warranty �ҷ����� ��Ȳ"
lstr_prt.tag			= This.ClassName()
lstr_prt.dwsyntax 	= "t_area.text = '" + ls_area + "'" + "t_division.text = '" + ls_division + "'" + "t_date.text = '" + ls_date + "'" + "t_item.text = '" + ls_item + "'" + &
							  "m_35_t.text = '" + mid(f_monthcalc( ls_date + '.01', 35),3,5) + "'" +&
							  "m_34_t.text = '" + mid(f_monthcalc( ls_date + '.01', 34),3,5) + "'" +&
							  "m_33_t.text = '" + mid(f_monthcalc( ls_date + '.01', 33),3,5) + "'" +&
							  "m_32_t.text = '" + mid(f_monthcalc( ls_date + '.01', 32),3,5) + "'" +&
							  "m_31_t.text = '" + mid(f_monthcalc( ls_date + '.01', 31),3,5) + "'" +&
							  "m_30_t.text = '" + mid(f_monthcalc( ls_date + '.01', 30),3,5) + "'" +&
							  "m_29_t.text = '" + mid(f_monthcalc( ls_date + '.01', 29),3,5) + "'" +&
							  "m_28_t.text = '" + mid(f_monthcalc( ls_date + '.01', 28),3,5) + "'" +&
							  "m_27_t.text = '" + mid(f_monthcalc( ls_date + '.01', 27),3,5) + "'" +&
							  "m_26_t.text = '" + mid(f_monthcalc( ls_date + '.01', 26),3,5) + "'" +&
							  "m_25_t.text = '" + mid(f_monthcalc( ls_date + '.01', 25),3,5) + "'" +&
							  "m_24_t.text = '" + mid(f_monthcalc( ls_date + '.01', 24),3,5) + "'" +&
							  "m_23_t.text = '" + mid(f_monthcalc( ls_date + '.01', 23),3,5) + "'" +&
							  "m_22_t.text = '" + mid(f_monthcalc( ls_date + '.01', 22),3,5) + "'" +&
							  "m_21_t.text = '" + mid(f_monthcalc( ls_date + '.01', 21),3,5) + "'" +&
							  "m_20_t.text = '" + mid(f_monthcalc( ls_date + '.01', 20),3,5) + "'" +&
							  "m_19_t.text = '" + mid(f_monthcalc( ls_date + '.01', 19),3,5) + "'" +&
							  "m_18_t.text = '" + mid(f_monthcalc( ls_date + '.01', 18),3,5) + "'" +&
							  "m_17_t.text = '" + mid(f_monthcalc( ls_date + '.01', 17),3,5) + "'" +&
							  "m_16_t.text = '" + mid(f_monthcalc( ls_date + '.01', 16),3,5) + "'" +&
							  "m_15_t.text = '" + mid(f_monthcalc( ls_date + '.01', 15),3,5) + "'" +&
							  "m_14_t.text = '" + mid(f_monthcalc( ls_date + '.01', 14),3,5) + "'" +&
							  "m_13_t.text = '" + mid(f_monthcalc( ls_date + '.01', 13),3,5) + "'" +&
							  "m_12_t.text = '" + mid(f_monthcalc( ls_date + '.01', 12),3,5) + "'" +&
							  "m_11_t.text = '" + mid(f_monthcalc( ls_date + '.01', 11),3,5) + "'" +&
							  "m_10_t.text = '" + mid(f_monthcalc( ls_date + '.01', 10),3,5) + "'" +&
							  "m_09_t.text = '" + mid(f_monthcalc( ls_date + '.01', 09),3,5) + "'" +&
							  "m_08_t.text = '" + mid(f_monthcalc( ls_date + '.01', 08),3,5) + "'" +&
							  "m_07_t.text = '" + mid(f_monthcalc( ls_date + '.01', 07),3,5) + "'" +&
							  "m_06_t.text = '" + mid(f_monthcalc( ls_date + '.01', 06),3,5) + "'" +&
							  "m_05_t.text = '" + mid(f_monthcalc( ls_date + '.01', 05),3,5) + "'" +&
							  "m_04_t.text = '" + mid(f_monthcalc( ls_date + '.01', 04),3,5) + "'" +&
							  "m_03_t.text = '" + mid(f_monthcalc( ls_date + '.01', 03),3,5) + "'" +&
							  "m_02_t.text = '" + mid(f_monthcalc( ls_date + '.01', 02),3,5) + "'" +&
							  "m_01_t.text = '" + mid(f_monthcalc( ls_date + '.01', 01),3,5) + "'" +&
							  "m_00_t.text = '" + mid(f_monthcalc( ls_date + '.01', 00),3,5) + "'" 


f_close_report("2", lstr_prt.title)						// Open�� ���Window �ݱ�
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq370i_01.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq370i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq370i
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

//string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
//datawindow 	ldw_division
//ldw_division = uo_division.dw_1
//ls_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
//

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

// Ʈ������� �����Ѵ�
//
dw_pisq370i_01.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq370i
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")

//PostEvent("ue_select")

end event

event ue_post_constructor;call super::ue_post_constructor;//
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
//string ls_productgroupname, ls_areacode, ls_productgroup, ls_DivisionCode
//datawindow 	ldw_productgroup
//
//ldw_productgroup	= uo_productgroup.dw_1
//ls_areacode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
//
//f_pisc_retrieve_dddw_productgroup(ldw_productgroup,ls_areacode,ls_DivisionCode,'%',true,ls_productgroup,ls_productgroupname)
//
//
end event

event ue_select;call super::ue_select;
// Ʈ������� �����Ѵ�
//
dw_pisq370i_01.SetTransObject(SQLPIS)

end event

type gb_2 from groupbox within w_pisq370i
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
integer taborder = 80
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_pisq370i_01 from datawindow within w_pisq370i
integer x = 41
integer y = 220
integer width = 4562
integer height = 2336
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq370i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_pisq370i
integer x = 1815
integer y = 72
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "ǰ��:"
boolean focusrectangle = false
end type

type sle_itemcode from singlelineedit within w_pisq370i
integer x = 1979
integer y = 60
integer width = 425
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;
String	ls_itemname

// ǰ���� ���Ѵ�
//
ls_itemname = f_getitemname(sle_itemcode.Text)

// �ش��ڵ��� ��������
//
IF f_checknullorspace(ls_itemname) = TRUE THEN
	Messagebox('Ȯ ��', '�ش��ϴ� ǰ���� �����ϴ�', StopSign!)
	sle_itemcode.SetFocus()
	sle_itemname.Text = ''
	RETURN
END IF

sle_itemname.Text = ls_itemname

end event

type sle_itemname from singlelineedit within w_pisq370i
integer x = 2409
integer y = 60
integer width = 873
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type uo_month from u_pisc_date_scroll_month within w_pisq370i
event destroy ( )
integer x = 1198
integer y = 60
integer height = 80
integer taborder = 50
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type pb_serch from picturebutton within w_pisq370i
integer x = 3282
integer y = 52
integer width = 238
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag = 2			// ��üǰ��
OpenWithParm ( w_pisr013i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_itemcode.Text = lstr_Rtn.code
sle_itemname.Text = lstr_Rtn.name

end event

type dw_print from datawindow within w_pisq370i
boolean visible = false
integer x = 41
integer y = 432
integer width = 3479
integer height = 1480
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq370i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisq370i
integer x = 18
integer y = 192
integer width = 4613
integer height = 2388
integer taborder = 100
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

