$PBExportHeader$w_pisq090i.srw
$PBExportComments$�˻� �����Ȳ(���ǿ�)
forward
global type w_pisq090i from w_ipis_sheet01
end type
type dw_pisq090i_left from u_vi_std_datawindow within w_pisq090i
end type
type cb_judge from commandbutton within w_pisq090i
end type
type cb_create from commandbutton within w_pisq090i
end type
type uo_area from u_pisc_select_area within w_pisq090i
end type
type uo_division from u_pisc_select_division within w_pisq090i
end type
type st_2 from statictext within w_pisq090i
end type
type sle_date from singlelineedit within w_pisq090i
end type
type st_3 from statictext within w_pisq090i
end type
type sle_suppliercode from singlelineedit within w_pisq090i
end type
type sle_suppliername from singlelineedit within w_pisq090i
end type
type dw_pisq090i_right from u_vi_std_datawindow within w_pisq090i
end type
type st_4 from statictext within w_pisq090i
end type
type st_5 from statictext within w_pisq090i
end type
type pb_serch from picturebutton within w_pisq090i
end type
type st_leftcnt from statictext within w_pisq090i
end type
type st_rightcnt from statictext within w_pisq090i
end type
type cb_autoprocess from commandbutton within w_pisq090i
end type
type st_6 from statictext within w_pisq090i
end type
type st_7 from statictext within w_pisq090i
end type
type gb_1 from groupbox within w_pisq090i
end type
type gb_2 from groupbox within w_pisq090i
end type
end forward

global type w_pisq090i from w_ipis_sheet01
integer width = 4695
integer height = 2800
string title = "�˻� �����Ȳ(���ǿ�)"
dw_pisq090i_left dw_pisq090i_left
cb_judge cb_judge
cb_create cb_create
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_date sle_date
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
dw_pisq090i_right dw_pisq090i_right
st_4 st_4
st_5 st_5
pb_serch pb_serch
st_leftcnt st_leftcnt
st_rightcnt st_rightcnt
cb_autoprocess cb_autoprocess
st_6 st_6
st_7 st_7
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq090i w_pisq090i

type variables

str_pisr_partkb istr_partkb
end variables

forward prototypes
public function boolean wf_insertqcresult (integer al_leftrow, integer al_rightrow)
public function boolean wf_updateqcresult (integer al_leftrow, integer al_rightrow)
end prototypes

public function boolean wf_insertqcresult (integer al_leftrow, integer al_rightrow);Boolean	lb_rtn 
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode
String	ls_makedate, ls_chargename, ls_standardrevno
Long		ll_supplierlotqty, ll_kbcount, ll_supplierdeliveryqty
String	ls_qcmethod, ls_remark, ls_kdacremark, ls_judgeflag
Long		ll_goodqty, ll_badqty
String	ls_badreason, ls_badmemo, ls_inspectorcode, ls_confirmcode, ls_confirmflag
String	ls_printflag, ls_qcdate, ls_qctime, ls_qcleadtime,  ls_qckbflag, ls_slno
String	ls_deliverydate, ls_deliverytime, ls_lastemp


ls_areacode					= dw_pisq090i_left.GetItemString(al_leftrow, 'areacode') 
ls_divisioncode			= dw_pisq090i_left.GetItemString(al_leftrow, 'divisioncode') 
ls_suppliercode			= dw_pisq090i_left.GetItemString(al_leftrow, 'suppliercode') 
ls_deliveryno				= dw_pisq090i_left.GetItemString(al_leftrow, 'slno') 
ls_itemcode					= dw_pisq090i_left.GetItemString(al_leftrow, 'itemcode') 
ls_makedate					= String(Today(), 'yyyy.mm.dd')
ls_chargename				= '������'
ls_standardrevno			= '00'
ll_supplierlotqty			= 1
ll_kbcount					= 0
ll_supplierdeliveryqty	= dw_pisq090i_left.GetItemNumber(al_leftrow, 'supplierdeliveryqty')
ls_qcmethod					= '1'
ls_remark					= ''
ls_kdacremark				= '���˻�ǰ���� �ڵ� �ۼ��� �˻缺�����Դϴ�(������ ���� �ŷ���ǥ)'
ls_judgeflag				= '1'
ll_goodqty					= dw_pisq090i_left.GetItemNumber(al_leftrow, 'supplierdeliveryqty')
ll_badqty					= 0
ls_badreason				= ''
ls_badmemo					= ''
ls_inspectorcode			= g_s_empno
ls_confirmcode				= g_s_empno
ls_confirmflag				= 'Y'
ls_printflag				= 'N'
ls_qcdate					= String(f_getsysdatetime(), 'yyyy.mm.dd')
ls_qctime					= String(f_getsysdatetime(), 'hh:mm:ss')
ls_qcleadtime				= '0'
ls_qckbflag					= '2'
ls_slno						= dw_pisq090i_left.GetItemString(al_leftrow, 'slno')
ls_deliverydate			= dw_pisq090i_left.GetItemString(al_leftrow, 'deliverydate')
ls_deliverydate			= Mid(ls_deliverydate, 1, 4) + '.' + &
								  Mid(ls_deliverydate, 5, 2) + '.' + &
								  Mid(ls_deliverydate, 7, 2)
ls_deliverytime			= '00:00:00'
ls_lastemp					= 'Y'

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

lb_rtn = TRUE

INSERT INTO TQQCRESULT  
			 ( AREACODE,   
				DIVISIONCODE,   
				SUPPLIERCODE,   
				DELIVERYNO,   
				ITEMCODE,   
				MAKEDATE,   
				CHARGENAME,   
				STANDARDREVNO,   
				SUPPLIERLOTQTY,   
				KBCOUNT,   
				SUPPLIERDELIVERYQTY,   
				QCMETHOD,   
				REMARK,   
				KDACREMARK,   
				JUDGEFLAG,   
				GOODQTY,   
				BADQTY,   
				BADREASON,   
				BADMEMO,   
				INSPECTORCODE,   
				CONFIRMCODE,   
				CONFIRMFLAG,   
				PRINTFLAG,   
				QCDATE,   
				QCTIME,   
				QCLEADTIME,   
				QCKBFLAG,   
				SLNO,   
				DELIVERYDATE,   
				DELIVERYTIME,
				LASTEMP)  
   VALUES ( :ls_areacode,   
				:ls_divisioncode,   
				:ls_suppliercode,   
				:ls_deliveryno,   
				:ls_itemcode,   
				:ls_makedate,   
				:ls_chargename,   
				:ls_standardrevno,   
				:ll_supplierlotqty,   
				:ll_kbcount,   
				:ll_supplierdeliveryqty,   
				:ls_qcmethod,   
				:ls_remark,   
				:ls_kdacremark,   
				:ls_judgeflag,   
				:ll_goodqty,   
				:ll_badqty,   
				:ls_badreason,   
				:ls_badmemo,   
				:ls_inspectorcode,   
				:ls_confirmcode,   
				:ls_confirmflag,   
				:ls_printflag,   
				:ls_qcdate,   
				:ls_qctime,   
				:ls_qcleadtime,   
				:ls_qckbflag,   
				:ls_slno,   
				:ls_deliverydate,   
				:ls_deliverytime, 
				:ls_lastemp)  
	   USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	lb_rtn = FALSE
END IF

IF lb_rtn = TRUE THEN
	DELETE FROM TQBUSINESSTEMP  
			WHERE TQBUSINESSTEMP.AREACODE		 = :ls_areacode
			  AND	TQBUSINESSTEMP.DIVISIONCODE = :ls_divisioncode
			  AND	TQBUSINESSTEMP.SLNO			 = :ls_deliveryno
		USING SQLPIS;
	
	IF SQLPIS.SQLCode <> 0 THEN
		lb_rtn = FALSE
	END IF
END IF

SQLPIS.AUTOCommit = TRUE

RETURN lb_rtn
end function

public function boolean wf_updateqcresult (integer al_leftrow, integer al_rightrow);Boolean	lb_rtn 
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode
String	ls_makedate, ls_chargename, ls_standardrevno
Long		ll_supplierlotqty, ll_kbcount, ll_supplierdeliveryqty
String	ls_qcmethod, ls_remark, ls_kdacremark, ls_judgeflag
Long		ll_goodqty, ll_badqty
String	ls_badreason, ls_badmemo, ls_inspectorcode, ls_confirmcode, ls_confirmflag
String	ls_printflag, ls_qcdate, ls_qctime, ls_qcleadtime,  ls_qckbflag, ls_slno
String	ls_deliverydate, ls_deliverytime, ls_lastemp

ls_areacode					= dw_pisq090i_right.GetItemString(al_rightrow, 'areacode') 
ls_divisioncode			= dw_pisq090i_right.GetItemString(al_rightrow, 'divisioncode') 
ls_suppliercode			= dw_pisq090i_right.GetItemString(al_rightrow, 'suppliercode') 
ls_deliveryno				= dw_pisq090i_right.GetItemString(al_rightrow, 'deliveryno') 
ls_itemcode					= dw_pisq090i_right.GetItemString(al_rightrow, 'itemcode') 
ll_supplierdeliveryqty	= dw_pisq090i_right.GetItemNumber(al_rightrow, 'supplierdeliveryqty')
ls_kdacremark				= '���˻�ǰ���� �ڵ� �ۼ��� �˻缺�����Դϴ�(������ �ִ� �ŷ���ǥ)'
ls_judgeflag				= '1'
ll_goodqty					= dw_pisq090i_right.GetItemNumber(al_rightrow, 'supplierdeliveryqty')
ll_badqty					= 0
ls_inspectorcode			= g_s_empno
ls_confirmcode				= g_s_empno
ls_confirmflag				= 'Y'
ls_qcdate					= String(f_getsysdatetime(), 'yyyy.mm.dd')
ls_qctime					= String(f_getsysdatetime(), 'hh:mm:ss')
ls_qcleadtime				= '0'
ls_slno						= dw_pisq090i_left.GetItemString(al_leftrow, 'slno') 
ls_deliverydate			= dw_pisq090i_left.GetItemString(al_leftrow, 'deliverydate')
ls_deliverydate			= Mid(ls_deliverydate, 1, 4) + '.' + &
								  Mid(ls_deliverydate, 5, 2) + '.' + &
								  Mid(ls_deliverydate, 7, 2)
ls_deliverytime			= '00:00:00'
ls_lastemp					= 'Y'

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

lb_rtn = TRUE

UPDATE TQQCRESULT  
	SET KDACREMARK		= :ls_kdacremark,
		 JUDGEFLAG		= :ls_judgeflag,   
		 GOODQTY			= :ll_supplierdeliveryqty,   
		 BADQTY			= :ll_badqty,
		 INSPECTORCODE = :ls_inspectorcode,   
		 CONFIRMCODE	= :ls_confirmcode,   
		 CONFIRMFLAG	= :ls_confirmflag,   
		 QCDATE			= :ls_qcdate,   
		 QCTIME			= :ls_qctime,   
		 QCLEADTIME		= :ls_qcleadtime,   
		 SLNO				= :ls_slno,   
		 DELIVERYDATE	= :ls_deliverydate,   
		 DELIVERYTIME	= :ls_deliverytime,
		 LASTEMP			= :ls_lastemp
WHERE TQQCRESULT.AREACODE		= :ls_areacode
  AND TQQCRESULT.DIVISIONCODE = :ls_divisioncode
  AND TQQCRESULT.SUPPLIERCODE = :ls_suppliercode
  AND TQQCRESULT.DELIVERYNO	= :ls_deliveryno
  AND TQQCRESULT.ITEMCODE		= :ls_itemcode
USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	lb_rtn = FALSE
END IF

IF lb_rtn = TRUE THEN
	DELETE FROM TQBUSINESSTEMP  
			WHERE TQBUSINESSTEMP.AREACODE		 = :ls_areacode
			  AND	TQBUSINESSTEMP.DIVISIONCODE = :ls_divisioncode
			  AND	TQBUSINESSTEMP.SLNO			 = :ls_slno
		USING SQLPIS;
	
	IF SQLPIS.SQLCode <> 0 THEN
		lb_rtn = FALSE
	ELSE
		// Add Logic(2003.05.21) - �˻缺���� ����
		dw_pisq090i_right.Deleterow(al_rightrow)
	END IF
END IF

SQLPIS.AUTOCommit = TRUE

RETURN lb_rtn

end function

on w_pisq090i.create
int iCurrent
call super::create
this.dw_pisq090i_left=create dw_pisq090i_left
this.cb_judge=create cb_judge
this.cb_create=create cb_create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_date=create sle_date
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.dw_pisq090i_right=create dw_pisq090i_right
this.st_4=create st_4
this.st_5=create st_5
this.pb_serch=create pb_serch
this.st_leftcnt=create st_leftcnt
this.st_rightcnt=create st_rightcnt
this.cb_autoprocess=create cb_autoprocess
this.st_6=create st_6
this.st_7=create st_7
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq090i_left
this.Control[iCurrent+2]=this.cb_judge
this.Control[iCurrent+3]=this.cb_create
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_date
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.sle_suppliercode
this.Control[iCurrent+10]=this.sle_suppliername
this.Control[iCurrent+11]=this.dw_pisq090i_right
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.pb_serch
this.Control[iCurrent+15]=this.st_leftcnt
this.Control[iCurrent+16]=this.st_rightcnt
this.Control[iCurrent+17]=this.cb_autoprocess
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.st_7
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.gb_2
end on

on w_pisq090i.destroy
call super::destroy
destroy(this.dw_pisq090i_left)
destroy(this.cb_judge)
destroy(this.cb_create)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.dw_pisq090i_right)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.pb_serch)
destroy(this.st_leftcnt)
destroy(this.st_rightcnt)
destroy(this.cb_autoprocess)
destroy(this.st_6)
destroy(this.st_7)
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
dw_pisq090i_right.Retrieve(ls_AreaCode, ls_DivisionCode, '%', ls_SupplierCode, '%')

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq090i_left, 1, True)	
f_SetHighlight(dw_pisq090i_right, 1, True)

Timer(300)


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
cb_autoprocess.Enabled	= m_frame.m_action.m_save.Enabled
cb_create.Enabled			= m_frame.m_action.m_save.Enabled
cb_judge.Enabled			= m_frame.m_action.m_save.Enabled

// Ʈ������� �����Ѵ�
//
dw_pisq090i_left.SetTransObject(SQLPIS)
dw_pisq090i_right.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// �����Ƿ� �ڷḦ �⺻������ ��ȸ�Ҽ� �ְ� ó���� ��ȸ�� �ѱ��
//
This.TriggerEvent("ue_retrieve")

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq090i_left.SetTransObject(SQLPIS)
dw_pisq090i_right.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

event timer;call super::timer;This.TriggerEvent('ue_retrieve')
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq090i
integer x = 18
integer y = 2604
integer width = 3598
end type

type dw_pisq090i_left from u_vi_std_datawindow within w_pisq090i
integer x = 41
integer y = 296
integer width = 2400
integer height = 2276
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq090i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// ó���� �˻缺���� ����ó���� �Ѱ��ش�
	//
	cb_create.TriggerEvent (Clicked!)
END IF
end event

event retrieveend;call super::retrieveend;
st_leftcnt.Text = String(rowcount, '#,###')
end event

type cb_judge from commandbutton within w_pisq090i
integer x = 4215
integer y = 48
integer width = 384
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
string   ls_DeliveryNo, ls_judgeflag, ls_revno, ls_qcgubun
Long		ll_saverow

uo_status.st_message.text = ""
// �۾������ ������ ó���� ���� �ʴ´�
//
IF dw_pisq090i_right.GetSelectedRow(0) = 0 THEN
	//MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	uo_status.st_message.text = '�۾������ �����ϴ�'
	RETURN 0
END IF

//IF dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "qcgubun") = 'C' THEN
//	MessageBox('Ȯ ��', '���˻� ó������ �۾��ϼ���', StopSign!)
//	RETURN
//END IF

// ������ ������ �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "SupplierCode")
ls_DeliveryNo		= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "slno")
ls_ItemCode			= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "ItemCode")
ls_revno          = dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "StandardRevno")
ls_qcgubun        = dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "qcgubun")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_DeliveryNo
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno
istr_parms.String_arg[7] = ls_qcgubun

// �۾����� ���� �����Ѵ�
//
ll_saverow = dw_pisq090i_right.GetSelectedRow(0)

// �˻缺���� ����ȭ�� ����
//
OpenWithParm(w_pisq110u, istr_parms)

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq090i_right.RowCount() THEN
	ll_saverow = dw_pisq090i_right.RowCount() 
END IF
	
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq090i_right, ll_saverow, True)	

end event

type cb_create from commandbutton within w_pisq090i
integer x = 3808
integer y = 48
integer width = 384
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�������ۼ�"
end type

event clicked;
String	ls_AreaCode, ls_AreaName, ls_DivisionCode, ls_DivisionName, ls_SLNO, ls_DeliveryDate
String	ls_SupplierCode, ls_SupplierKorName, ls_ItemCode, ls_ItemName
Long		ll_SupplierDeliveryQty, ll_saverow

uo_status.st_message.text = ""
// �۾������ ������ ó���� ���� �ʴ´�
//
IF dw_pisq090i_left.GetSelectedRow(0) = 0 THEN
	//MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	uo_status.st_message.text = '�۾������ �����ϴ�'
	RETURN 0
END IF

IF dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "qcgubun") = 'C' THEN
	//MessageBox('Ȯ ��', '���˻� ó������ �۾��ϼ���', StopSign!)
	uo_status.st_message.text = '���˻� ó������ �۾��ϼ���'
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

type uo_area from u_pisc_select_area within w_pisq090i
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
dw_pisq090i_right.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq090i
event destroy ( )
integer x = 576
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
dw_pisq090i_right.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq090i
integer x = 1166
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

type sle_date from singlelineedit within w_pisq090i
integer x = 1467
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

type st_3 from statictext within w_pisq090i
integer x = 1911
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

type sle_suppliercode from singlelineedit within w_pisq090i
integer x = 2208
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

type sle_suppliername from singlelineedit within w_pisq090i
integer x = 2437
integer y = 60
integer width = 699
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

type dw_pisq090i_right from u_vi_std_datawindow within w_pisq090i
integer x = 2464
integer y = 296
integer width = 2139
integer height = 2276
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq090i_02"
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
st_rightcnt.Text = String(rowcount, '#,###')
end event

type st_4 from statictext within w_pisq090i
integer x = 50
integer y = 220
integer width = 736
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

type st_5 from statictext within w_pisq090i
integer x = 2482
integer y = 220
integer width = 736
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< �˻缺���� ���� >"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_serch from picturebutton within w_pisq090i
integer x = 3136
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

type st_leftcnt from statictext within w_pisq090i
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

type st_rightcnt from statictext within w_pisq090i
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

type cb_autoprocess from commandbutton within w_pisq090i
integer x = 3401
integer y = 48
integer width = 384
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���˻�ó��"
end type

event clicked;
Long		ll_Lrow, ll_Rrow, ll_qty, ll_rownum, ll_rtn
String	ls_suppliercode, ls_itemcode, ls_find, ls_qcgubun, ls_passflag

uo_status.st_message.text = ""
// �ŷ���ǥ ����ŭ ����ó���Ѵ�
//
FOR ll_Lrow = 1 TO dw_pisq090i_left.RowCount()
	// �ŷ���ǥ�� �˻缺���� ��Ī ó���� Ű���� ���Ѵ�(��ü�ڵ� + ǰ�� + ����)
	//
	ls_suppliercode	= dw_pisq090i_left.GetItemString(ll_Lrow, 'suppliercode')
	ls_itemcode			= dw_pisq090i_left.GetItemString(ll_Lrow, 'itemcode')
	ll_qty				= dw_pisq090i_left.GetItemNumber(ll_Lrow, 'supplierdeliveryqty')
	ls_qcgubun			= ''
	ls_qcgubun			= dw_pisq090i_left.GetItemString(ll_Lrow, 'qcgubun')

	// ���˻�ǰ���� ������� �Ѵ�
	//
	IF ls_qcgubun = 'Q' THEN
		// ��ġ�� ������ �����
		//
		ls_find = "suppliercode = '" + ls_suppliercode + "'" 
		ls_find = ls_find + " and itemcode= '" + ls_itemcode + "'" 
		ls_find = ls_find + " and supplierdeliveryqty = " + String(ll_qty)

		ls_passflag = 'Y'

		// �˻缺������ �ڷᰡ �Ѱǵ� ���°��� �ٷ� ����ó���� �Ѵ�
		//
		IF dw_pisq090i_Right.RowCount() = 0 THEN
			// �ŷ���ǥ�� ����ο츦 ����ǥ���Ѵ�
			//
			f_SetHighlight(dw_pisq090i_Left, ll_Lrow, True)	

			ll_rtn = MessageBox('Ȯ ��', '�ۼ��� �˻缺������ �����ϴ�. �ڵ����� �˻缺������ �ۼ��ϰڽ��ϱ�', &
										Exclamation!, OKCancel!, 2)
			IF ll_rtn = 1 THEN
				// �˻缺������ �űԷ� �ۼ��ϰ� �ŷ���ǥ ������ �����Ѵ�
				// �� �����ϳ�? => ���˻�ǰ�� ���ϼӺ����� �հݵǴ¼��� �԰�ó���Ǹ鼭 �������̽���
				// 	��Ű�� �ش������� �����ϹǷ� �������̽� ���ʿ䰡 ���⶧���� �����Ѵ�
				//
				IF wf_InsertQcResult(ll_Lrow, ll_rownum) = FALSE THEN
					MessageBox('Ȯ ��', '�˻缺���� �ۼ��� �����߽��ϴ�')
					RETURN 0
				END IF
			END IF				
		END IF
		
		// �˻缺���� ����ŭ ����ó���Ѵ�
		//
		FOR ll_Rrow = 1 TO dw_pisq090i_Right.RowCount()
			// ��ġ�� �Ѵ�. ��ġ�� �ڷᰡ ������ �ش� �ο찪�� �����ϰ� ������ 0
			//
			ll_rownum = dw_pisq090i_Right.find (ls_find, ll_Rrow, dw_pisq090i_Right.RowCount())
		
			// �ŷ���ǥ�� ����ο츦 ����ǥ���Ѵ�
			//
			f_SetHighlight(dw_pisq090i_Left, ll_Lrow, True)	

			// �˻缺������ ��ġ�� �ο츦 ����ǥ���Ѵ�
			//
			IF ll_rownum = 0 THEN
				f_SetHighlight(dw_pisq090i_Right, 1, True)	
			ELSE
				f_SetHighlight(dw_pisq090i_Right, ll_rownum, True)	
			END IF
	
			// ��ġ�� �˻缺������ ����
			//
			f_SetHighlight(dw_pisq090i_Right, ll_rownum, True)	
			
			IF ll_rownum = 0 and ls_passflag = 'Y' THEN
				ll_rtn = MessageBox('Ȯ ��', '�ۼ��� �˻缺������ �����ϴ�. �ڵ����� �˻缺������ �ۼ��ϰڽ��ϱ�', &
											Exclamation!, OKCancel!, 2)
				IF ll_rtn = 1 THEN
//					 �˻缺������ �űԷ� �ۼ��ϰ� �ŷ���ǥ ������ �����Ѵ�
//					 �� �����ϳ�? => ���˻�ǰ�� ���ϼӺ����� �հݵǴ¼��� �԰�ó���Ǹ鼭 �������̽���
//					 	��Ű�� �ش������� �����ϹǷ� �������̽� ���ʿ䰡 ���⶧���� �����Ѵ�
//					
					IF wf_InsertQcResult(ll_Lrow, ll_rownum) = FALSE THEN
						MessageBox('Ȯ ��', '�˻缺���� �ۼ��� �����߽��ϴ�')
						RETURN 0
					END IF
				END IF				
				EXIT
			END IF

			// ��ġ�� �˻缺������ �ִ�
			//
			IF ll_rownum <> 0 THEN

				// �˻缺������ �ѹ��̶� ��ġ�� �ڷ�� �˻缺���� �ű� �ۼ� ��ƾ���� �� �귯����
				//
				ls_passflag = 'N'

				// ��ġ�� �ο찪�� ���������� ��Ʈ�Ͽ� ��ġ�� ���ĺ��� ����ó���ǰ��Ѵ�
				//
				ll_Rrow = ll_rownum
				
				ll_rtn = MessageBox('Ȯ ��', '�ۼ��� �˻缺������ �ֽ��ϴ�. �հ�ó�� �Ͻðڽ��ϱ�?', &
											Exclamation!, OKCancel!, 2)
				IF ll_rtn = 1 THEN
//					 �˻缺������ �հ����� �����ϰ� �ŷ���ǥ ������ �����Ѵ�
					
					IF wf_UpdateQcResult(ll_Lrow, ll_rownum) = FALSE THEN
						MessageBox('Ȯ ��', '�˻缺���� �հ�ó���� �����߽��ϴ�')
						RETURN 0
					END IF
					// �ŷ���ǥ�� �ش��ϴ� �˻缺������ �ۼ������Ƿ� �˻缺���� ��ġ ������
					// �����ϰ� ���� ������ �̵��Ѵ�
					//
					EXIT
				END IF				
			END IF
		NEXT
	END IF
NEXT

// ó���� �Ϸ�Ǹ� �ڷḦ ����ȸ�Ѵ�
//
Parent.TriggerEvent('ue_retrieve')
end event

type st_6 from statictext within w_pisq090i
integer x = 805
integer y = 220
integer width = 681
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 30593702
string text = "���˻�ǰ"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.BackColor = RGB(166,210,210)
end event

type st_7 from statictext within w_pisq090i
integer x = 3241
integer y = 220
integer width = 681
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 30593702
string text = "���˻�ǰ"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.BackColor = RGB(166,210,210)
end event

type gb_1 from groupbox within w_pisq090i
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

type gb_2 from groupbox within w_pisq090i
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

