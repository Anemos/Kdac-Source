$PBExportHeader$w_pisq020i.srw
$PBExportComments$�˻���ؼ� ������Ȳ
forward
global type w_pisq020i from w_ipis_sheet01
end type
type dw_pisq020i from u_vi_std_datawindow within w_pisq020i
end type
type cb_examination from commandbutton within w_pisq020i
end type
type uo_area from u_pisc_select_area within w_pisq020i
end type
type uo_division from u_pisc_select_division within w_pisq020i
end type
type sle_date from singlelineedit within w_pisq020i
end type
type sle_suppliercode from singlelineedit within w_pisq020i
end type
type sle_suppliername from singlelineedit within w_pisq020i
end type
type st_2 from statictext within w_pisq020i
end type
type st_3 from statictext within w_pisq020i
end type
type pb_serch from picturebutton within w_pisq020i
end type
type cb_change from commandbutton within w_pisq020i
end type
type gb_1 from groupbox within w_pisq020i
end type
end forward

global type w_pisq020i from w_ipis_sheet01
integer width = 4800
integer height = 2136
string title = "�˻���ؼ� ������Ȳ"
dw_pisq020i dw_pisq020i
cb_examination cb_examination
uo_area uo_area
uo_division uo_division
sle_date sle_date
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
st_2 st_2
st_3 st_3
pb_serch pb_serch
cb_change cb_change
gb_1 gb_1
end type
global w_pisq020i w_pisq020i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq020i.create
int iCurrent
call super::create
this.dw_pisq020i=create dw_pisq020i
this.cb_examination=create cb_examination
this.uo_area=create uo_area
this.uo_division=create uo_division
this.sle_date=create sle_date
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.st_2=create st_2
this.st_3=create st_3
this.pb_serch=create pb_serch
this.cb_change=create cb_change
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq020i
this.Control[iCurrent+2]=this.cb_examination
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.sle_date
this.Control[iCurrent+6]=this.sle_suppliercode
this.Control[iCurrent+7]=this.sle_suppliername
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.pb_serch
this.Control[iCurrent+11]=this.cb_change
this.Control[iCurrent+12]=this.gb_1
end on

on w_pisq020i.destroy
call super::destroy
destroy(this.dw_pisq020i)
destroy(this.cb_examination)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.sle_date)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.pb_serch)
destroy(this.cb_change)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq020i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_enactmentdate	= sle_date.Text + '%'
ls_SupplierCode	= sle_suppliercode.Text + '%'

// Ʈ������� �����Ѵ�
//
dw_pisq020i.SetTransObject(SQLPIS)

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq020i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode, '%')

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq020i, 1, True)	

// Ÿ�̸� �̺�Ʈ�� 2�д����� ó���Ѵ�
//
timer(120)

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

//IF g_s_empno = '866209' or & 
//	g_s_empno = '866015' or &
//	g_s_empno = '021021' or &
//	g_s_empno = '851183' or &
//	g_s_empno = '866443' or &
//	g_s_empno = '951026' or &
//	g_s_empno = '862257' or &
//	g_s_empno = '867114' or &
//	g_s_empno = '923012' or &
//	g_s_empno = '852060' or &
//	g_s_empno = '951107' or &
//	g_s_empno = '956121' or &
//	g_s_empno = '862096' or &
//	g_s_empno = '971005' or &
//	g_s_empno = '866333' or &
//	g_s_empno = '866330' or &
//	g_s_empno = '861403' or &
//	g_s_empno = '876590' or &
//	g_s_empno = '876389' or &
//	g_s_empno = '876373' or &
//	g_s_empno = '866273' or &
//	g_s_empno = '861030' or &
//	g_s_empno = '021036' or &
//	g_s_empno = '881047' or &
//	g_s_empno = '886035' or &
//	g_s_empno = '886084' or &
//	g_s_empno = '892081' or &
//	g_s_empno = '901010' or &
//	g_s_empno = '876334' or &
//	g_s_empno = '876300' or &
//	g_s_empno = '876263' or &
//	g_s_empno = '876238' or &
//	g_s_empno = '876228' or &
//	g_s_empno = '871494' or &
//	g_s_empno = '951044' or &
//	g_s_empno = '951045' or &
//	g_s_empno = '866230' or &
//	g_s_empno = '871009' or &
//	g_s_empno = '960165' or &
//	g_s_empno = '867405' or &
//	g_s_empno = '852090' or &
//	g_s_empno = '952201' or &
//	g_s_empno = '021023' or &
//	g_s_empno = '956159' or &
//	g_s_empno = '001039' or &
//	g_s_empno = '961030' or &
//	g_s_empno = '961150' or &
//	g_s_empno = '961152' or &
//	g_s_empno = '966102' or &
//	g_s_empno = '966104' or &
//	g_s_empno = '966114' or &
//	g_s_empno = '851174' or &
//	g_s_empno = '861019' or &
//	g_s_empno = '999999' or &
//	g_s_empno = '861147' or &
//	g_s_empno = '856153' or &
//	g_s_empno = '866002' or &
//	g_s_empno = '876100' or &
//	g_s_empno = '876111' or &
//	g_s_empno = 'ADMIN' or &
//	g_s_empno = 'admin' THEN
//	//
//ELSE
//	CLOSE(This)
//END IF


end event

event ue_postopen;call super::ue_postopen;
// ������ ��ȸ�� ������ ����� ��ưó�� �Ұ�
//
cb_change.Enabled			= m_frame.m_action.m_save.Enabled
cb_examination.Enabled	= m_frame.m_action.m_save.Enabled

// Ʈ������� �����Ѵ�
//
dw_pisq020i.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// �����Ƿ� �ڷḦ �⺻������ ��ȸ�Ҽ� �ְ� ó���� ��ȸ�� �ѱ��
//
This.TriggerEvent("ue_retrieve")

end event

event timer;call super::timer;
This.TriggerEvent('ue_retrieve')
end event

event activate;// Ʈ������� �����Ѵ�
//
dw_pisq020i.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq020i
integer x = 18
integer width = 3598
end type

type dw_pisq020i from u_vi_std_datawindow within w_pisq020i
integer x = 18
integer y = 192
integer width = 4425
integer height = 1696
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_pisq020i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// ó���� �˻���ؼ� ����ó���� �Ѱ��ش�
	//
	cb_examination.TriggerEvent (Clicked!)
END IF
end event

type cb_examination from commandbutton within w_pisq020i
integer x = 4155
integer y = 48
integer width = 439
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���ؼ� ����"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno
String	ls_SanctionCode, ls_ChargeConsertFlag, ls_SanctionConsertFlag
Long		ll_saverow

// �۾������ ������ ó���� ���� �ʴ´�
//
IF dw_pisq020i.GetSelectedRow(0) = 0 THEN
	MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	RETURN
END IF

// ���ؼ����信 �ʿ��� ������ ���Ѵ�
//
ls_AreaCode					= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "SupplierCode")
ls_ItemCode					= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "ItemCode")
ls_StandardRevno			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "StandardRevno")
ls_SanctionCode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "SanctionCode")
ls_ChargeConsertFlag		= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "ChargeConsertFlag")
ls_SanctionConsertFlag	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "SanctionConsertFlag")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_ItemCode
istr_parms.String_arg[5] = ls_StandardRevno

// �α��� ����� �۾��� ������ ����� �������� üũ�Ѵ�
//
IF ls_ChargeConsertFlag = 'Y' AND ls_SanctionConsertFlag	= 'X' THEN		// ������ ó����
	IF g_s_empno <> ls_SanctionCode THEN
		MessageBox('Ȯ ��', '�α��� ����� �۾��� ������ ����� ��ġ���� �ʽ��ϴ�', StopSign!)
		RETURN
	END IF
END IF

// �۾����� ���� �����Ѵ�
//
ll_saverow = dw_pisq020i.GetSelectedRow(0)

// �˻���ؼ� ����ȭ�� ����
//
OpenWithParm(w_pisq030u, istr_parms)

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq020i.RowCount() THEN
	ll_saverow = dw_pisq020i.RowCount() 
END IF
	
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq020i, ll_saverow, True)	

end event

type uo_area from u_pisc_select_area within w_pisq020i
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

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

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// Ʈ������� �����Ѵ�
//
dw_pisq020i.SetTransObject(SQLPIS)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_pisq020i
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
// Ʈ������� �����Ѵ�
//
dw_pisq020i.SetTransObject(SQLPIS)

end event

type sle_date from singlelineedit within w_pisq020i
integer x = 1513
integer y = 60
integer width = 375
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;
IF f_checknullorspace(sle_date.Text) = FALSE THEN
	IF IsDate(sle_date.Text) = FALSE THEN
		MessageBox('Ȯ ��', '���ڸ� �ٸ��� �Է��ϼ���', StopSign!)
		sle_date.SetFocus()
	END IF
END IF

end event

type sle_suppliercode from singlelineedit within w_pisq020i
integer x = 2267
integer y = 60
integer width = 215
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// ��ü���� ���Ѵ�
//
sle_suppliername.Text = f_getsuppliername(sle_suppliercode.Text)



end event

type sle_suppliername from singlelineedit within w_pisq020i
integer x = 2491
integer y = 60
integer width = 750
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisq020i
integer x = 1211
integer y = 72
integer width = 293
integer height = 60
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

type st_3 from statictext within w_pisq020i
integer x = 1970
integer y = 72
integer width = 293
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���¾�ü:"
boolean focusrectangle = false
end type

type pb_serch from picturebutton within w_pisq020i
integer x = 3241
integer y = 52
integer width = 238
integer height = 96
integer taborder = 50
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
istr_partkb.flag		= 2			//���־�ü(����,����)
istr_partkb.remark	= sle_suppliercode.Text

OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_suppliercode.Text = lstr_Rtn.code
sle_suppliername.Text = lstr_Rtn.name


end event

type cb_change from commandbutton within w_pisq020i
integer x = 3671
integer y = 48
integer width = 457
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������ ����"
end type

event clicked;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno
String	ls_areadivision, ls_chargecode, ls_sanction_empname

ls_areacode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'areacode')
ls_divisioncode	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'divisioncode')
ls_suppliercode	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'suppliercode')
ls_itemcode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'itemcode')
ls_standardrevno	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'standardrevno')
ls_areadivision	= ls_areacode + ls_divisioncode
ls_chargecode		= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'chargecode')

IF f_checknullorspace(ls_chargecode) = TRUE THEN
	MessageBox('Ȯ ��', '���۾����Դϴ�', StopSign!)
	RETURN
END IF

// �α��� ����� ����� ����� ���Ѵ�
//
IF ls_chargecode <> g_s_empno THEN
	MessageBox('Ȯ ��', '�α��� ����� ����� ����� Ʋ���ϴ�', StopSign!)
	RETURN
END IF

// ������ ����ȭ�� ����
//
OpenWithParm(w_pisq031u, ls_areadivision)

IF f_checknullorspace(Message.StringParm) = TRUE THEN
	MessageBox('Ȯ ��', '���õ� �����ڰ� �����ϴ�', StopSign!)
	RETURN
END IF

// ������ ����ȭ�鿡�� ���õǾ��� �Ѿ�� ������ ����� ���̺� �����Ѵ�
//
UPDATE TQQCSTANDARD  
	SET SANCTIONCODE = RTrim(:Message.StringParm)
 WHERE AREACODE		= :ls_areacode
 	AND DIVISIONCODE	= :ls_divisioncode
 	AND SUPPLIERCODE	= :ls_suppliercode
 	AND ITEMCODE		= :ls_itemcode
 	AND STANDARDREVNO	= :ls_standardrevno
 USING SQLPIS;

// ���õǾ��� �Ѿ�� ������ ����� ���� ���Ѵ�
//
SELECT EmpName  
  INTO :ls_sanction_empname
  FROM TMSTEMP  
 WHERE EmpNo = RTrim(:Message.StringParm)
 USING SQLPIS;

dw_pisq020i.SetItem(dw_pisq020i.GetSelectedRow(0), 'sanction_empname', ls_sanction_empname)

end event

type gb_1 from groupbox within w_pisq020i
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

