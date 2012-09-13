$PBExportHeader$w_pisq091i.srw
$PBExportComments$(new)�˻� �����Ȳ(���ǿ�)
forward
global type w_pisq091i from w_ipis_sheet01
end type
type dw_pisq090i_left from u_vi_std_datawindow within w_pisq091i
end type
type cb_judge from commandbutton within w_pisq091i
end type
type uo_area from u_pisc_select_area within w_pisq091i
end type
type uo_division from u_pisc_select_division within w_pisq091i
end type
type st_2 from statictext within w_pisq091i
end type
type sle_date from singlelineedit within w_pisq091i
end type
type st_3 from statictext within w_pisq091i
end type
type sle_suppliercode from singlelineedit within w_pisq091i
end type
type sle_suppliername from singlelineedit within w_pisq091i
end type
type st_4 from statictext within w_pisq091i
end type
type pb_serch from picturebutton within w_pisq091i
end type
type st_leftcnt from statictext within w_pisq091i
end type
type st_rightcnt from statictext within w_pisq091i
end type
type cb_save from commandbutton within w_pisq091i
end type
type cb_create from commandbutton within w_pisq091i
end type
type cb_rejudge from commandbutton within w_pisq091i
end type
type gb_1 from groupbox within w_pisq091i
end type
type gb_2 from groupbox within w_pisq091i
end type
end forward

global type w_pisq091i from w_ipis_sheet01
integer width = 4695
integer height = 2800
string title = "�˻� �����Ȳ(���ǿ�)"
dw_pisq090i_left dw_pisq090i_left
cb_judge cb_judge
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_date sle_date
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
st_4 st_4
pb_serch pb_serch
st_leftcnt st_leftcnt
st_rightcnt st_rightcnt
cb_save cb_save
cb_create cb_create
cb_rejudge cb_rejudge
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq091i w_pisq091i

type variables

str_pisr_partkb istr_partkb
end variables

forward prototypes
public function boolean wf_create_notqc (string as_areacode, string as_divisioncode, string as_suppliercode, string as_deliveryno, string as_itemcode)
public subroutine wf_remove_qcitem01 ()
end prototypes

public function boolean wf_create_notqc (string as_areacode, string as_divisioncode, string as_suppliercode, string as_deliveryno, string as_itemcode);

return true
end function

public subroutine wf_remove_qcitem01 ();// �˻缺���� ���ۼ� �ŷ���ǥ ����
String ls_areacode, ls_divisioncode

ls_areacode = uo_area.is_uo_areacode
ls_divisioncode = uo_division.is_uo_divisioncode

delete tqbusinesstemp
from tqbusinesstemp aa inner join  tqqcitem01 bb
	on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
		aa.itemcode = bb.itemcode and aa.suppliercode = bb.suppliercode
where aa.areacode = :ls_areacode and aa.divisioncode = :ls_divisioncode and
	aa.qcgubun = 'Q' and bb.applydateto = '2999.12.31' and aa.judgeflag = '9' and
	convert(varchar(10),cast(aa.deliverydate as datetime),102) >= bb.applydatefrom and
	not exists ( select * from tqqcresult cc
				where aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
					aa.slno = cc.deliveryno and aa.suppliercode = cc.suppliercode and
					aa.itemcode = cc.itemcode ) using sqlpis;
end subroutine

on w_pisq091i.create
int iCurrent
call super::create
this.dw_pisq090i_left=create dw_pisq090i_left
this.cb_judge=create cb_judge
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_date=create sle_date
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.st_4=create st_4
this.pb_serch=create pb_serch
this.st_leftcnt=create st_leftcnt
this.st_rightcnt=create st_rightcnt
this.cb_save=create cb_save
this.cb_create=create cb_create
this.cb_rejudge=create cb_rejudge
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq090i_left
this.Control[iCurrent+2]=this.cb_judge
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_date
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.sle_suppliercode
this.Control[iCurrent+9]=this.sle_suppliername
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.pb_serch
this.Control[iCurrent+12]=this.st_leftcnt
this.Control[iCurrent+13]=this.st_rightcnt
this.Control[iCurrent+14]=this.cb_save
this.Control[iCurrent+15]=this.cb_create
this.Control[iCurrent+16]=this.cb_rejudge
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
end on

on w_pisq091i.destroy
call super::destroy
destroy(this.dw_pisq090i_left)
destroy(this.cb_judge)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.st_4)
destroy(this.pb_serch)
destroy(this.st_leftcnt)
destroy(this.st_rightcnt)
destroy(this.cb_save)
destroy(this.cb_create)
destroy(this.cb_rejudge)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_pisq090i_left, LEFT)
////of_resize_register(st_v_bar, SPLIT)
//of_resize_register(dw_pisq090i_right, RIGHT)
//
//of_resize()
end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_enactmentdate	= sle_date.Text + '%'
ls_SupplierCode	= sle_suppliercode.Text + '%'

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq090i_left.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode, '%')

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq090i_left, 1, True)	

// Ÿ�̸� �̺�Ʈ�� 5�д����� ó���Ѵ�
//
timer(300)


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
//	g_s_empno = '001039' or &		
//	g_s_empno = '851183' or &
//	g_s_empno = '852090' or &
//	g_s_empno = '856042' or &
//	g_s_empno = '856132' or &
//	g_s_empno = '856153' or &
//	g_s_empno = '861019' or &
//	g_s_empno = '866002' or &
//	g_s_empno = '866120' or &
//	g_s_empno = '866477' or &
//	g_s_empno = '876099' or &
//	g_s_empno = '876100' or &
//	g_s_empno = '876108' or &
//	g_s_empno = '876111' or &
//	g_s_empno = '876160' or &
//	g_s_empno = '876400' or &
//	g_s_empno = '876507' or &
//	g_s_empno = '876534' or &
//	g_s_empno = '876543' or &
//	g_s_empno = '876562' or &
//	g_s_empno = '876587' or &
//	g_s_empno = '886080' or &
//	g_s_empno = '923012' or &
//	g_s_empno = '951044' or &
//	g_s_empno = '952201' or &
//	g_s_empno = '961152' or &
//	g_s_empno = '862093' or &
//	g_s_empno = '861403' or &
//	g_s_empno = '871009' or &
//	g_s_empno = '951107' or &
//	g_s_empno = '021036' or &
//	g_s_empno = '961030' or &
//	g_s_empno = '971005' or &
//	g_s_empno = '021023' or &
//	g_s_empno = '010031' or &
//	g_s_empno = '867414' or &
//	g_s_empno = '866351' or &
//	g_s_empno = '956165' or &
//	g_s_empno = '956169' or &
//	g_s_empno = '966269' or &
//	g_s_empno = '976127' or &
//	g_s_empno = '976126' or &
//	g_s_empno = '966216' or &
//	g_s_empno = '976157' or &
//	g_s_empno = '966189' or &
//	g_s_empno = '966280' or &
//	g_s_empno = '876219' or &
//	g_s_empno = '876039' or &
//	g_s_empno = '956123' or &
//	g_s_empno = '956123' or &
//	g_s_empno = '876219' or &
//	g_s_empno = '876039' or &
//	g_s_empno = '867248' or &
//	g_s_empno = '876071' or &
//	g_s_empno = 'ADMIN' or &
//	g_s_empno = 'admin' THEN
//	//
//ELSE
//	CLOSE(This)
//END IF
//


end event

event ue_postopen;call super::ue_postopen;
// ������ ��ȸ�� ������ ����� ��ưó�� �Ұ�
//
//cb_autoprocess.Enabled	= m_frame.m_action.m_save.Enabled
//cb_create.Enabled			= m_frame.m_action.m_save.Enabled
cb_judge.Enabled			= m_frame.m_action.m_save.Enabled

// Ʈ������� �����Ѵ�
//
dw_pisq090i_left.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// �����Ƿ� �ڷḦ �⺻������ ��ȸ�Ҽ� �ְ� ó���� ��ȸ�� �ѱ��
//
This.TriggerEvent("ue_retrieve")

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq090i_left.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

event timer;call super::timer;wf_remove_qcitem01()
This.Triggerevent("ue_retrieve")
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq091i
integer x = 18
integer y = 2604
integer width = 3598
end type

type dw_pisq090i_left from u_vi_std_datawindow within w_pisq091i
integer x = 41
integer y = 296
integer width = 4558
integer height = 2276
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq090i_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// ó���� �˻缺���� ����ó���� �Ѱ��ش�
	//
	If This.GetitemString(row,'StandardRevno') = 'XX' then
		cb_create.TriggerEvent (Clicked!)
	else
		cb_judge.TriggerEvent (Clicked!)
	end if
END IF
end event

event retrieveend;call super::retrieveend;
st_leftcnt.Text = String(rowcount, '#,###')
end event

type cb_judge from commandbutton within w_pisq091i
integer x = 3680
integer y = 56
integer width = 379
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����������"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode
string   ls_slno, ls_judgeflag, ls_revno, ls_qcgubun
Long		ll_saverow

// �۾������ ������ ó���� ���� �ʴ´�
//
IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF

IF dw_pisq090i_left.GetSelectedRow(0) = 0 THEN
	MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	RETURN
END IF

// ������ �������� ó���� ���� �ʴ´�
//
ls_judgeflag = dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "judgeflag")
IF ls_judgeflag <> '9' THEN
	MessageBox('Ȯ ��', '������ �������� ������ �Ҽ� �����ϴ�~nȮ���۾��� �Ͻñ� �ٶ��ϴ�', StopSign!)
	RETURN 0
END IF

//�˻������̺�(QCITEM) - ���˻���('C') = TQBUSINESSTEMP - ���˻���('Q')
IF dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "qcgubun") = 'Q' THEN
	uo_status.st_message.text = '���˻�ǰ�Դϴ�. Ȯ�ΰ����� �����մϴ�.'
	RETURN
END IF

// ������ ������ �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "SupplierCode")
ls_slno		= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "slno")
ls_ItemCode			= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "ItemCode")
ls_qcgubun        = dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "qcgubun")

//�˻缺���� �������� Ȯ��
select standardrevno into :ls_revno
from tqqcresult
where areacode = :ls_areacode and divisioncode = :ls_divisioncode and
		suppliercode = :ls_suppliercode and deliveryno = :ls_slno and
		itemcode = :ls_itemcode
using sqlpis;

if f_spacechk(ls_revno) = -1 then
	MessageBox('Ȯ ��', '�˻缺������ �������� �ʽ��ϴ�.~nȮ���۾��� �Ͻñ� �ٶ��ϴ�', StopSign!)
	RETURN 0
end if

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_slno
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno
istr_parms.String_arg[7] = ls_qcgubun

// �۾����� ���� �����Ѵ�
//
ll_saverow = dw_pisq090i_left.GetSelectedRow(0)

// �˻缺���� ����ȭ�� ����
//
OpenWithParm(w_pisq110u, istr_parms)

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq090i_left.RowCount() THEN
	ll_saverow = dw_pisq090i_left.RowCount() 
END IF
	
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq090i_left, ll_saverow, True)	

end event

type uo_area from u_pisc_select_area within w_pisq091i
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

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// Ʈ������� �����Ѵ�
//
dw_pisq090i_left.SetTransObject(SQLPIS)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq091i
event destroy ( )
integer x = 562
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
dw_pisq090i_left.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq091i
integer x = 1134
integer y = 72
integer width = 302
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
string text = "��ǰ����:"
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_pisq091i
integer x = 1431
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

type st_3 from statictext within w_pisq091i
integer x = 1851
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

type sle_suppliercode from singlelineedit within w_pisq091i
integer x = 2139
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

type sle_suppliername from singlelineedit within w_pisq091i
integer x = 2368
integer y = 60
integer width = 617
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

type st_4 from statictext within w_pisq091i
integer x = 50
integer y = 220
integer width = 1445
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< �ŷ���ǥ ���� >"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_serch from picturebutton within w_pisq091i
integer x = 2999
integer y = 52
integer width = 238
integer height = 96
integer taborder = 70
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

type st_leftcnt from statictext within w_pisq091i
integer x = 1947
integer y = 240
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type st_rightcnt from statictext within w_pisq091i
integer x = 4110
integer y = 240
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_pisq091i
integer x = 4096
integer y = 56
integer width = 219
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ��"
end type

event clicked;String	ls_ConfirmFlag, ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_message
String	ls_DeliveryNo , ls_ItemCode, ls_judgeflag, ls_qcgubun, ls_deliverydate
Long		ll_low, ll_chkcnt
Dec{1}   lc_deliveryqty

IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF

dw_pisq090i_left.AcceptText()

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

FOR ll_low = 1 TO dw_pisq090i_left.RowCount()
	ls_judgeflag 	= dw_pisq090i_left.GetItemString(ll_low, "judgeflag")
	ls_ConfirmFlag = dw_pisq090i_left.GetItemString(ll_low, 'ConfirmFlag')
	ls_qcgubun     = dw_pisq090i_left.GetItemString(ll_low, 'qcgubun')
	ls_AreaCode			= dw_pisq090i_left.GetItemString(ll_low, "AreaCode")
	ls_DivisionCode	= dw_pisq090i_left.GetItemString(ll_low, "DivisionCode")
	ls_SupplierCode	= dw_pisq090i_left.GetItemString(ll_low, "SupplierCode")
	ls_DeliveryNo		= dw_pisq090i_left.GetItemString(ll_low, "slno")
	ls_ItemCode			= dw_pisq090i_left.GetItemString(ll_low, "ItemCode")
	ls_deliverydate	= dw_pisq090i_left.GetItemString(ll_low, "DeliveryDate")
	lc_deliveryqty    = dw_pisq090i_left.GetItemDecimal(ll_low, "SupplierDeliveryQty")
	
	If ls_ConfirmFlag <> 'Y' then
		continue
	end if
	
	If ls_qcgubun = 'Q' then
		//���˻�ǰ �ۼ�
		select count(*) into :ll_chkcnt
			from	TQQCRESULT
			where	areacode = :ls_areacode
					and	divisioncode = :ls_divisioncode
					and suppliercode = :ls_suppliercode
					and	deliveryno = :ls_deliveryno
					and itemcode = :ls_itemcode
			using sqlpis;
			
		If ll_chkcnt < 1 then
			INSERT INTO TQQCRESULT  
				( AREACODE,	DIVISIONCODE,	SUPPLIERCODE,		DELIVERYNO,
				ITEMCODE,	MAKEDATE,	
				CHARGENAME,	STANDARDREVNO,
				SUPPLIERLOTQTY,	KBCOUNT,	SUPPLIERDELIVERYQTY,	QCMETHOD,
				REMARK,		KDACREMARK,	
				JUDGEFLAG,	GOODQTY,
				BADQTY,		BADREASON,	BADMEMO,		INSPECTORCODE,
				CONFIRMCODE,	CONFIRMFLAG,	PRINTFLAG,		QCDATE,
				QCTIME,							QCLEADTIME,	
				QCKBFLAG,	SLNO,
				DELIVERYDATE,	
				DELIVERYTIME,	LASTEMP)  
			VALUES	( :ls_areacode,	:ls_divisioncode,	:ls_suppliercode,		:ls_deliveryno,
				:ls_itemcode,		CONVERT(CHAR(10), getdate(), 102),   
				'������',	'00',
				1,		0,		:lc_deliveryqty,		'1',
				:ls_suppliercode,	'���˻�ǰ���� �ڵ� �ۼ��� �˻缺�����Դϴ�(������ ���� �ŷ���ǥ)',
				'1',		:lc_deliveryqty,
				0,		' ',		' ',			'kdac',
				:g_s_empno,	'Y',		'N',			CONVERT(CHAR(10), getdate(), 102),
				CONVERT(CHAR(8), getdate(), 108),			'0',
				'2',		:ls_deliveryno,
				substring(:ls_deliverydate,1,4) + '.' + substring(:ls_deliverydate,5,2) + '.' + substring(:ls_deliverydate,7,2),
				'00:00:00',	'Y') 
			using sqlpis;
			if sqlpis.sqlcode <> 0 then
				ls_message = 'Error'
				goto Rollback_
			end if
		Else						
			UPDATE TQQCRESULT 
			SET KDACREMARK		= '���˻�ǰ���� �ڵ� �ۼ��� �˻缺�����Դϴ�(������ �ִ� �ŷ���ǥ)',
					JUDGEFLAG		= '1',   
					GOODQTY			= :lc_deliveryqty,   
					BADQTY			= 0,
					INSPECTORCODE = 'kdac',   
					CONFIRMCODE	= :g_s_empno,   
					CONFIRMFLAG	= 'Y',   
					QCDATE			= CONVERT(CHAR(10), getdate(), 102),   
					QCTIME			= CONVERT(CHAR(8), getdate(), 108),   
					QCLEADTIME		= 0,   
					SLNO				= :ls_deliveryno,  
					QCKBFLAG         = '2' ,
					DELIVERYDATE	= substring(:ls_deliverydate,1,4) + '.' + substring(:ls_deliverydate,5,2) + '.' + substring(:ls_deliverydate,7,2),   
					DELIVERYTIME	= '00:00:00',
					LASTEMP			= 'Y'
			WHERE AREACODE		= :ls_areacode
			AND DIVISIONCODE = :ls_divisioncode
			AND SUPPLIERCODE = :ls_suppliercode
			AND DELIVERYNO	= :ls_deliveryno
			AND ITEMCODE		= :ls_itemcode
			using sqlpis;
			if sqlpis.sqlcode <> 0 then
				ls_message = 'Error'
				goto Rollback_
			end if
		End if
		//���˻� ��� ǰ��ó��
		DELETE FROM TQBUSINESSTEMP  
			WHERE TQBUSINESSTEMP.AREACODE		 = :ls_AreaCode
			  AND	TQBUSINESSTEMP.DIVISIONCODE = :ls_DivisionCode
			  AND	TQBUSINESSTEMP.SLNO			 = :ls_deliveryno
		USING SQLPIS;
		if sqlpis.sqlcode <> 0 then
			ls_message = 'Error'
			goto Rollback_
		end if
	Else
		IF ls_judgeflag = '9' THEN
			MessageBox('Ȯ ��', String(ll_low) + '������ ���������� Ȯ�� �۾��� �Ҽ������ϴ�', StopSign!)
			CONTINUE
		END IF
		
		UPDATE TQQCRESULT 
         SET CONFIRMFLAG   = 'Y'  ,
				 CONFIRMCODE   = :g_s_empno
       WHERE AREACODE		= :ls_AreaCode
         AND DIVISIONCODE	= :ls_DivisionCode
         AND SUPPLIERCODE	= :ls_SupplierCode
         AND DELIVERYNO		= :ls_DeliveryNo
         AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;
		
		IF SQLPIS.SQLCode <> 0 THEN
			ls_message = 'Error'
			goto Rollback_
		END IF
	End if
NEXT

Commit using sqlpis;
sqlpis.Autocommit = True
// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

return 0

Rollback_:
RollBack using sqlpis;
sqlpis.Autocommit = True
MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')

return 0
end event

type cb_create from commandbutton within w_pisq091i
integer x = 3287
integer y = 56
integer width = 370
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string text = "�������ۼ�"
end type

event clicked;
String	ls_AreaCode, ls_AreaName, ls_DivisionCode, ls_DivisionName, ls_SLNO, ls_DeliveryDate
String	ls_SupplierCode, ls_SupplierKorName, ls_ItemCode, ls_ItemName
Long		ll_SupplierDeliveryQty, ll_saverow

uo_status.st_message.text = ""
// �۾������ ������ ó���� ���� �ʴ´�
//
IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF

IF dw_pisq090i_left.GetSelectedRow(0) = 0 THEN
	//MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	uo_status.st_message.text = '�۾������ �����ϴ�'
	RETURN 0
END IF

IF dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "qcgubun") = 'Q' THEN
	//MessageBox('Ȯ ��', '���˻� ó������ �۾��ϼ���', StopSign!)
	uo_status.st_message.text = '���˻�ǰ�Դϴ�. Ȯ���۾��� �����մϴ�.'
	RETURN 0
END IF

// ������ �ۼ��� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "AreaCode")
ls_AreaName			= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "AreaName")
ls_DivisionCode	= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "DivisionCode")
ls_DivisionName	= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "DivisionName")
ls_SLNO				= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "SLNO")
ls_DeliveryDate	= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "DeliveryDate")
ls_SupplierCode	= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "SupplierCode")
ls_SupplierKorName= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "SupplierKorName")
ls_ItemCode			= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "ItemCode")
ls_ItemName			= dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "ItemName")
ll_SupplierDeliveryQty	= dw_pisq090i_left.GetItemNumber(dw_pisq090i_left.GetSelectedRow(0), "SupplierDeliveryQty")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[01] = ls_AreaCode			
istr_parms.String_arg[02] = ls_AreaName			
istr_parms.String_arg[03] = ls_DivisionCode		
istr_parms.String_arg[04] = ls_DivisionName		
istr_parms.String_arg[05] = ls_SLNO				
istr_parms.String_arg[06] = ls_DeliveryDate		
istr_parms.String_arg[07] = ls_SupplierCode		
istr_parms.String_arg[08] = ls_SupplierKorName	
istr_parms.String_arg[09] = ls_ItemCode			
istr_parms.String_arg[10] = ls_ItemName
istr_parms.Long_arg[01]   = ll_SupplierDeliveryQty

// �۾����� ���� �����Ѵ�
//
ll_saverow = dw_pisq090i_left.GetSelectedRow(0)

// �˻缺���� ����ȭ�� ����
//
OpenWithParm(w_pisq111u, istr_parms)

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq090i_left.RowCount() THEN
	ll_saverow = dw_pisq090i_left.RowCount() 
END IF
	
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq090i_left, ll_saverow, True)	
end event

type cb_rejudge from commandbutton within w_pisq091i
integer x = 4352
integer y = 56
integer width = 256
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������"
end type

event clicked;long ll_selrow, ll_rtn, ll_supplierdeliveryqty
string ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode
string ls_judgeflag, ls_status, ls_message, ls_inspectorcode, ls_deliverydate

uo_status.st_message.text = ""
ll_selrow = dw_pisq090i_left.getselectedrow(0)

IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF

if ll_selrow < 1 then
	uo_status.st_message.text = "�������� ǰ���� �����Ͻʽÿ�"
	return 0
end if

ls_AreaCode			= dw_pisq090i_left.GetItemString(ll_selrow, "AreaCode")
ls_DivisionCode	= dw_pisq090i_left.GetItemString(ll_selrow, "DivisionCode")
ls_SupplierCode	= dw_pisq090i_left.GetItemString(ll_selrow, "SupplierCode")
ls_ItemCode			= dw_pisq090i_left.GetItemString(ll_selrow, "ItemCode")
ls_DeliveryNo		= dw_pisq090i_left.GetItemString(ll_selrow, "Slno")
ls_judgeflag 		= dw_pisq090i_left.GetItemString(ll_selrow, "judgeflag")
ls_inspectorcode 		= dw_pisq090i_left.GetItemString(ll_selrow, "inspectorcode")
ll_supplierdeliveryqty = dw_pisq090i_left.GetItemNumber(ll_selrow, "SupplierDeliveryQty")

//�������� Ȯ��
if ls_judgeflag = '9' then
	uo_status.st_message.text = "������ �����Դϴ�."
	return 0
end if

//�������� Ȯ��
if ls_inspectorcode = 'kdac' then
	uo_status.st_message.text = "���˻�ǰ������ �������� �� �����ϴ�."
	return 0
end if

//�ش糳ǰ��ȣ�� �ش�ǰ���� ������ �˼���� ���� Ȯ��
if ls_areacode = 'Y' then
  SELECT COUNT(*)
  		INTO :ll_rtn 
    	FROM TPARTINREADY  
   	WHERE ( AreaCode = :ls_areacode ) AND  
         	( DivisionCode = :ls_divisioncode ) AND    
         	( Slno = :ls_deliveryno ) AND
				( ItemCode = :ls_itemcode ) AND
				( IncomeFlag = 'N' )
		using sqlpis;
		
	if ll_rtn = 1 then
		uo_status.st_message.text = "�԰�����Դϴ�. ������ �� �� �����ϴ�."
		return 0
	end if
else
  SELECT COUNT(*)
  		INTO :ll_rtn 
    	FROM PBINV.INV201  
   	WHERE ( comltd = '01' ) AND
				( xplant = :ls_areacode ) AND  
         	( div = :ls_divisioncode ) AND  
         	( slno = :ls_deliveryno ) AND
				( itno = :ls_itemcode )
		using sqlca;
		
	if sqlca.sqlcode <> 0 or ll_rtn < 1 then
		uo_status.st_message.text = "�԰�����Դϴ�. ������ �� �� �����ϴ�."
		return 0
	end if
end if

SELECT DCKDT INTO :ls_deliverydate
FROM PBINV.INV201  
WHERE ( comltd = '01' ) AND
		( xplant = :ls_areacode ) AND  
		( div = :ls_divisioncode ) AND  
		( slno = :ls_deliveryno ) AND
		( itno = :ls_itemcode )
FETCH FIRST 1 ROW ONLY
using sqlca;

sqlca.autocommit = false
sqlpis.autocommit = false

if ls_areacode = 'Y' then
	DELETE FROM TPARTINREADY
	WHERE ( AreaCode = :ls_areacode ) AND  
         	( DivisionCode = :ls_divisioncode ) AND    
         	( Slno = :ls_deliveryno ) AND
				( ItemCode = :ls_itemcode ) AND
				( IncomeFlag = 'Y' )
	using sqlpis;
		
	if sqlpis.sqlcode <> 0 then
		ls_message = "�԰�����Ȳ �����ÿ� ������ �߻��߽��ϴ�."
		goto Rollback_
	end if
end if

UPDATE PBINV.INV201
SET dexqt = 0, ndexqt = 0
WHERE ( comltd = '01' ) AND
			( xplant = :ls_areacode ) AND  
			( div = :ls_divisioncode ) AND  
			( slno = :ls_deliveryno ) AND
			( itno = :ls_itemcode )
using sqlca;
	
if sqlca.sqlcode = 0 and sqlca.sqlnrows > 0 then
	// pass
else
	ls_message = "��ǰ���� �ʱ�ȭ �۾��� ������ �߻��Ͽ����ϴ�."
	goto Rollback_
end if

// �˻������� ����
Insert Into TQBUSINESSTEMP
	(AreaCode,	Divisioncode,	SlNo,		
	DeliveryDate,
	SupplierCode,	ItemCode,	SupplierDeliveryQty,	QCGubun,
	JudgeFlag,	GoodQty,	BadQty,			LastEmp)
Values (:ls_areacode,	:ls_divisioncode,	:ls_deliveryno,	
	:ls_deliverydate,
	:ls_SupplierCode,	:ls_itemcode,	:ll_supplierdeliveryqty,		' ',
	'9',		0,		0,			'SYSTEM')
using sqlpis;

if sqlpis.sqlcode <> 0 then
	ls_message = "�˻������� �����ÿ� ������ �߻��߽��ϴ�."
	goto Rollback_
end if

//�ش�˻缺���� ���������� ����
  UPDATE TQQCRESULT  
  	SET JUDGEFLAG = '9',   
         GOODQTY = 0,   
         BADQTY = 0,   
         BADREASON = ' ',   
         BADMEMO = ' ',   
         INSPECTORCODE = ' ',   
         CONFIRMCODE = ' ',   
         CONFIRMFLAG = 'N',   
         QCDATE = null  
   WHERE ( TQQCRESULT.AREACODE = :ls_areacode ) AND  
         ( TQQCRESULT.DIVISIONCODE = :ls_divisioncode ) AND  
         ( TQQCRESULT.SUPPLIERCODE = :ls_suppliercode ) AND  
         ( TQQCRESULT.DELIVERYNO = :ls_deliveryno ) AND  
         ( TQQCRESULT.ITEMCODE = :ls_itemcode )   
   using sqlpis;
	
if sqlpis.sqlcode <> 0 then
	ls_message = "����Ÿ���̽� ���� : �ý��۰��߷� �����ٶ��ϴ�."
	goto Rollback_
end if

commit using sqlca;
commit using sqlpis;
sqlca.autocommit = true
sqlpis.autocommit = true
MessageBox("Ȯ��", "���������·� �ʱ�ȭ�� �Ϸ� �Ǿ����ϴ�.")
// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

return 0

Rollback_:
rollback using sqlca;
rollback using sqlpis;
sqlca.autocommit = true
sqlpis.autocommit = true
MessageBox("����", ls_message)

return -1



end event

type gb_1 from groupbox within w_pisq091i
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

type gb_2 from groupbox within w_pisq091i
integer x = 18
integer y = 184
integer width = 4613
integer height = 2408
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

