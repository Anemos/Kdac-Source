$PBExportHeader$w_pisq080i.srw
$PBExportComments$�˻� �����Ȳ(���ǿ�)
forward
global type w_pisq080i from w_ipis_sheet01
end type
type dw_pisq080i from u_vi_std_datawindow within w_pisq080i
end type
type cb_judge from commandbutton within w_pisq080i
end type
type cb_save from commandbutton within w_pisq080i
end type
type uo_area from u_pisc_select_area within w_pisq080i
end type
type uo_division from u_pisc_select_division within w_pisq080i
end type
type st_2 from statictext within w_pisq080i
end type
type sle_date from singlelineedit within w_pisq080i
end type
type st_3 from statictext within w_pisq080i
end type
type sle_suppliercode from singlelineedit within w_pisq080i
end type
type sle_suppliername from singlelineedit within w_pisq080i
end type
type pb_serch from picturebutton within w_pisq080i
end type
type cb_detail from commandbutton within w_pisq080i
end type
type cb_retry from commandbutton within w_pisq080i
end type
type gb_1 from groupbox within w_pisq080i
end type
end forward

global type w_pisq080i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "�˻� �����Ȳ(���ǿ�)"
dw_pisq080i dw_pisq080i
cb_judge cb_judge
cb_save cb_save
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_date sle_date
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
pb_serch pb_serch
cb_detail cb_detail
cb_retry cb_retry
gb_1 gb_1
end type
global w_pisq080i w_pisq080i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq080i.create
int iCurrent
call super::create
this.dw_pisq080i=create dw_pisq080i
this.cb_judge=create cb_judge
this.cb_save=create cb_save
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_date=create sle_date
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.pb_serch=create pb_serch
this.cb_detail=create cb_detail
this.cb_retry=create cb_retry
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq080i
this.Control[iCurrent+2]=this.cb_judge
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_date
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.sle_suppliercode
this.Control[iCurrent+10]=this.sle_suppliername
this.Control[iCurrent+11]=this.pb_serch
this.Control[iCurrent+12]=this.cb_detail
this.Control[iCurrent+13]=this.cb_retry
this.Control[iCurrent+14]=this.gb_1
end on

on w_pisq080i.destroy
call super::destroy
destroy(this.dw_pisq080i)
destroy(this.cb_judge)
destroy(this.cb_save)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.pb_serch)
destroy(this.cb_detail)
destroy(this.cb_retry)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq080i, FULL)

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
dw_pisq080i.SetTransObject(SQLPIS)

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq080i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode, '%')

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq080i, 1, True)	

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
//
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

end event

event ue_postopen;call super::ue_postopen;// ������ ��ȸ�� ������ ����� ��ưó�� �Ұ�
//
cb_judge.Enabled	= m_frame.m_action.m_save.Enabled
cb_save.Enabled	= m_frame.m_action.m_save.Enabled

// Ʈ������� �����Ѵ�
//
dw_pisq080i.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// �����Ƿ� �ڷḦ �⺻������ ��ȸ�Ҽ� �ְ� ó���� ��ȸ�� �ѱ��
//
This.TriggerEvent("ue_retrieve")

end event

event timer;call super::timer;
This.TriggerEvent('ue_retrieve')
end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq080i.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq080i
integer x = 18
integer width = 3598
end type

type dw_pisq080i from u_vi_std_datawindow within w_pisq080i
integer x = 18
integer y = 200
integer width = 3589
integer height = 1688
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq080i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// ó���� �˻缺���� ����ó���� �Ѱ��ش�
	//
	cb_judge.TriggerEvent (Clicked!)
END IF
end event

event retrieveend;call super::retrieveend;
Long		ll_idx
String	ls_datetime, ls_flag
DateTime	ldt_sysdatetime

// 4�ð��� ���� �ڷ�� �������� ǥ���Ѵ�
//
FOR ll_idx = 1 TO rowcount
	// �ý��� �Ͻø� ���Ѵ�
	//
	ldt_sysdatetime = f_getsysdatetime()
	// ��ǰ�Ͻø� ���Ѵ�
	//
	ls_datetime		 = dw_pisq080i.GetItemString(ll_idx, 'deliverydate') + ' ' +&
					  		dw_pisq080i.GetItemString(ll_idx, 'deliverytime')
	
	// 4�ð� ����� �ڷḦ ����Ѵ�
	//
	SELECT top 1 CASE WHEN DATEADD(hh, +4, :ls_datetime) < :ldt_sysdatetime THEN 'Y' ELSE 'N' END 
	  INTO :ls_flag
	  FROM sysusers
	  USING SQLPIS;

	// 4�ð� ����� �ڷ�� FLAG�� 'Y'�� ��Ʈ�ϰ� ��Ʈ�� �ڷḦ ������ ����Ÿ�����쿡�� 
	// �ش� �ڷḦ �������� �ٲٰ� ���ڰŸ��� �Ѵ�
	//
	IF ls_flag = 'Y' THEN
  		dw_pisq080i.SetItem(ll_idx, 'as_flag', 'Y')
	ELSE
  		dw_pisq080i.SetItem(ll_idx, 'as_flag', 'N')
	END IF
NEXT
end event

type cb_judge from commandbutton within w_pisq080i
integer x = 3241
integer y = 48
integer width = 357
integer height = 104
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
String   ls_DeliveryNo, ls_judgeflag, ls_revno
Long		ll_saverow

uo_status.st_message.text = ""
// �۾������ ������ ó���� ���� �ʴ´�
//
IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF
IF dw_pisq080i.GetSelectedRow(0) = 0 THEN
	//MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	uo_status.st_message.text = '�۾������ �����ϴ�'
	RETURN 0
END IF

// ������ �������� ó���� ���� �ʴ´�
//
ls_judgeflag = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "judgeflag")
IF ls_judgeflag <> '9' THEN
	//MessageBox('Ȯ ��', '������ �������� ������ �Ҽ� �����ϴ�~nȮ���۾��� �Ͻñ� �ٶ��ϴ�', StopSign!)
	uo_status.st_message.text = '������ �������� ������ �Ҽ� �����ϴ�. Ȯ���۾��� �Ͻñ� �ٶ��ϴ�'
	RETURN 0
END IF

// ������ ������ �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "SupplierCode")
ls_ItemCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "ItemCode")
ls_DeliveryNo		= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "DeliveryNo")
ls_revno          = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "StandardRevno")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_DeliveryNo
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno

// �۾����� �����Ѵ�
//
ll_saverow = dw_pisq080i.GetSelectedRow(0)

// �˻���ؼ� ����ȭ�� ����
//
OpenWithParm(w_pisq100u, istr_parms)

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq080i.RowCount() THEN
	ll_saverow = dw_pisq080i.RowCount()
END IF

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq080i, ll_saverow, True)	

end event

type cb_save from commandbutton within w_pisq080i
integer x = 3977
integer y = 48
integer width = 306
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ  ��"
end type

event clicked;

String	ls_ConfirmFlag, ls_AreaCode, ls_DivisionCode, ls_SupplierCode
String	ls_DeliveryNo , ls_ItemCode, ls_judgeflag
Long		ll_low

uo_status.st_message.text = ""

IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF

dw_pisq080i.AcceptText()

FOR ll_low = 1 TO dw_pisq080i.RowCount()
	ls_judgeflag 	= dw_pisq080i.GetItemString(ll_low, "judgeflag")
	ls_ConfirmFlag = dw_pisq080i.GetItemString(ll_low, 'ConfirmFlag')

	IF ls_ConfirmFlag = 'Y' THEN
		// ������ �������� ó���� ���� �ʴ´�
		//
		ls_AreaCode			= dw_pisq080i.GetItemString(ll_low, "AreaCode")
		ls_DivisionCode	= dw_pisq080i.GetItemString(ll_low, "DivisionCode")
		ls_SupplierCode	= dw_pisq080i.GetItemString(ll_low, "SupplierCode")
		ls_DeliveryNo		= dw_pisq080i.GetItemString(ll_low, "DeliveryNo")
		ls_ItemCode			= dw_pisq080i.GetItemString(ll_low, "ItemCode")
		
		SELECT JUDGEFLAG INTO :ls_judgeflag FROM TQQCRESULT 
       WHERE AREACODE		= :ls_AreaCode
         AND DIVISIONCODE	= :ls_DivisionCode
         AND SUPPLIERCODE	= :ls_SupplierCode
         AND DELIVERYNO		= :ls_DeliveryNo
         AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;
		
		IF SQLPIS.SQLCODE <> 0 OR ls_judgeflag = '9' THEN
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

		// AUTO COMMIT�� FASLE�� ����
		//
		SQLPIS.AUTOCommit = FALSE
		
		IF SQLPIS.SQLCode = 0 THEN
			// Commit ó��
			//
			COMMIT USING SQLPIS;
			SQLPIS.AUTOCommit = TRUE
		ELSE 
			// RollBack ó��
			//
			RollBack using SQLPIS ;
			SQLPIS.AUTOCommit = TRUE
			MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
		END IF
	END IF
NEXT

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

end event

type uo_area from u_pisc_select_area within w_pisq080i
integer x = 37
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
dw_pisq080i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq080i
event destroy ( )
integer x = 530
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
dw_pisq080i.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq080i
integer x = 1083
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

type sle_date from singlelineedit within w_pisq080i
integer x = 1376
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

type st_3 from statictext within w_pisq080i
integer x = 1769
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

type sle_suppliercode from singlelineedit within w_pisq080i
integer x = 2066
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

type sle_suppliername from singlelineedit within w_pisq080i
integer x = 2295
integer y = 60
integer width = 690
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

type pb_serch from picturebutton within w_pisq080i
integer x = 2985
integer y = 44
integer width = 238
integer height = 108
integer taborder = 60
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

type cb_detail from commandbutton within w_pisq080i
integer x = 3621
integer y = 48
integer width = 334
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�˻系��"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_Deliveryno
String   ls_ItemCode, ls_judgeflag, ls_revno

uo_status.st_message.text = ""
// ��´���� ������ ó���� ���� �ʴ´�
//
IF dw_pisq080i.GetSelectedRow(0) = 0 THEN
	//MessageBox('Ȯ ��', '�˻系�� ����� �����ϴ�', StopSign!)
	uo_status.st_message.text = '�˻系�� ����� �����ϴ�'
	RETURN 0
END IF

// ������ �����Ǹ� ó���Ѵ�
//
ls_judgeflag = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "judgeflag")
IF ls_judgeflag = '9' THEN
	//MessageBox('Ȯ ��', '������ �����Ǹ��� ��ȸ�Ҽ� �ֽ��ϴ�.', StopSign!)
	uo_status.st_message.text = '������ �����Ǹ��� ��ȸ�Ҽ� �ֽ��ϴ�.'
	RETURN 0
END IF

// ���ؼ���¿� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "SupplierCode")
ls_Deliveryno		= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "Deliveryno")
ls_ItemCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "ItemCode")
ls_revno          = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "StandardRevno")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_Deliveryno
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno
istr_parms.String_arg[9] = 'INQ'

// �˻缺���� ���γ��� ȭ�� ����
//
OpenWithParm(w_pisq116i, istr_parms)

end event

type cb_retry from commandbutton within w_pisq080i
integer x = 4302
integer y = 48
integer width = 306
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������"
end type

event clicked;long ll_selrow, ll_rtn
string ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode
string ls_judgeflag, ls_status

uo_status.st_message.text = ""
ll_selrow = dw_pisq080i.getselectedrow(0)

IF i_s_level = "1" then
	uo_status.st_message.text = '���������� �����ϴ�. Ȯ�ιٶ��ϴ�.'
	return 0
END IF

if ll_selrow < 1 then
	uo_status.st_message.text = "�������� ǰ���� �����Ͻʽÿ�"
	return 0
end if

ls_AreaCode			= dw_pisq080i.GetItemString(ll_selrow, "AreaCode")
ls_DivisionCode	= dw_pisq080i.GetItemString(ll_selrow, "DivisionCode")
ls_SupplierCode	= dw_pisq080i.GetItemString(ll_selrow, "SupplierCode")
ls_ItemCode			= dw_pisq080i.GetItemString(ll_selrow, "ItemCode")
ls_DeliveryNo		= dw_pisq080i.GetItemString(ll_selrow, "DeliveryNo")
ls_judgeflag 		= dw_pisq080i.GetItemString(ll_selrow, "judgeflag")

//�������� Ȯ��
if ls_judgeflag = '9' then
	uo_status.st_message.text = "������ �����Դϴ�."
	return 0
end if

//�ش糳ǰ��ȣ�� �ش�ǰ���� ������ ���԰� ���¿���Ȯ��
  SELECT COUNT(*)
  		INTO :ll_rtn 
    	FROM TPARTKBSTATUS  
   	WHERE ( TPARTKBSTATUS.AreaCode = :ls_areacode ) AND  
         	( TPARTKBSTATUS.DivisionCode = :ls_divisioncode ) AND  
         	( TPARTKBSTATUS.SupplierCode = :ls_suppliercode ) AND  
         	( TPARTKBSTATUS.ItemCode = :ls_itemcode ) AND  
         	( TPARTKBSTATUS.DeliveryNo = :ls_deliveryno ) AND
				( TPARTKBSTATUS.PartKBStatus = 'B' )
		using sqlpis;
		
if sqlpis.sqlcode <> 0 or ll_rtn < 1 then
	uo_status.st_message.text = "�԰� �Ǵ� ���ִ������Դϴ�. ������ �� �� �����ϴ�."
	return 0
end if

// Ȯ�� ����üũ
SELECT CONFIRMFLAG INTO :ls_status
FROM TQQCRESULT  
   WHERE ( TQQCRESULT.AREACODE = :ls_areacode ) AND  
         ( TQQCRESULT.DIVISIONCODE = :ls_divisioncode ) AND  
         ( TQQCRESULT.SUPPLIERCODE = :ls_suppliercode ) AND  
         ( TQQCRESULT.DELIVERYNO = :ls_deliveryno ) AND  
         ( TQQCRESULT.ITEMCODE = :ls_itemcode )   
   using sqlpis;
if ls_status = 'Y' then
	uo_status.st_message.text = "Ȯ���� �Ϸ�� �˻缺���� �Դϴ�."
	return 0
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
	uo_status.st_message.text = "����Ÿ���̽� ���� : �ý��۰��߷� �����ٶ��ϴ�."
else
	uo_status.st_message.text = "���������·� �ʱ�ȭ �Ǿ����ϴ�."
end if

return 0





end event

type gb_1 from groupbox within w_pisq080i
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

