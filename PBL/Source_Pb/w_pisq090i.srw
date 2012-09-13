$PBExportHeader$w_pisq090i.srw
$PBExportComments$검사 대기현황(비간판용)
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
string title = "검사 대기현황(비간판용)"
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
ls_chargename				= '델파이'
ls_standardrevno			= '00'
ll_supplierlotqty			= 1
ll_kbcount					= 0
ll_supplierdeliveryqty	= dw_pisq090i_left.GetItemNumber(al_leftrow, 'supplierdeliveryqty')
ls_qcmethod					= '1'
ls_remark					= ''
ls_kdacremark				= '무검사품으로 자동 작성된 검사성적서입니다(성적서 없는 거래명세표)'
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

// AUTO COMMIT을 FASLE로 지정
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
ls_kdacremark				= '무검사품으로 자동 작성된 검사성적서입니다(성적서 있는 거래명세표)'
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

// AUTO COMMIT을 FASLE로 지정
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
		// Add Logic(2003.05.21) - 검사성적서 제거
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

// 조회에 필요한 정보를 구한다
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_enactmentdate	= sle_date.Text + '%'
ls_SupplierCode	= sle_suppliercode.Text + '%'

// 데이타를 조회한다
//
dw_pisq090i_left.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode, '%')
dw_pisq090i_right.Retrieve(ls_AreaCode, ls_DivisionCode, '%', ls_SupplierCode, '%')

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq090i_left, 1, True)	
f_SetHighlight(dw_pisq090i_right, 1, True)

Timer(300)


end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// 툴바의 아이콘을 재설정한다
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
// 권한이 조회만 가능한 사람은 버튼처리 불가
//
cb_autoprocess.Enabled	= m_frame.m_action.m_save.Enabled
cb_create.Enabled			= m_frame.m_action.m_save.Enabled
cb_judge.Enabled			= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
//
dw_pisq090i_left.SetTransObject(SQLPIS)
dw_pisq090i_right.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// 승인의뢰 자료를 기본적으로 조회할수 있게 처리를 조회로 넘긴다
//
This.TriggerEvent("ue_retrieve")

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
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
	// 처리를 검사성적서 판정처리로 넘겨준다
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
string facename = "굴림체"
string text = "성적서판정"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode
string   ls_DeliveryNo, ls_judgeflag, ls_revno, ls_qcgubun
Long		ll_saverow

uo_status.st_message.text = ""
// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq090i_right.GetSelectedRow(0) = 0 THEN
	//MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	uo_status.st_message.text = '작업대상이 없습니다'
	RETURN 0
END IF

//IF dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "qcgubun") = 'C' THEN
//	MessageBox('확 인', '무검사 처리에서 작업하세요', StopSign!)
//	RETURN
//END IF

// 성적서 판정에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "SupplierCode")
ls_DeliveryNo		= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "slno")
ls_ItemCode			= dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "ItemCode")
ls_revno          = dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "StandardRevno")
ls_qcgubun        = dw_pisq090i_right.GetItemString(dw_pisq090i_right.GetSelectedRow(0), "qcgubun")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_DeliveryNo
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno
istr_parms.String_arg[7] = ls_qcgubun

// 작업중인 행을 저장한다
//
ll_saverow = dw_pisq090i_right.GetSelectedRow(0)

// 검사성적서 판정화면 오픈
//
OpenWithParm(w_pisq110u, istr_parms)

// 처리가 완료후 화면의 자료를 다시 표시한다
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq090i_right.RowCount() THEN
	ll_saverow = dw_pisq090i_right.RowCount() 
END IF
	
// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
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
string facename = "굴림체"
string text = "성적서작성"
end type

event clicked;
String	ls_AreaCode, ls_AreaName, ls_DivisionCode, ls_DivisionName, ls_SLNO, ls_DeliveryDate
String	ls_SupplierCode, ls_SupplierKorName, ls_ItemCode, ls_ItemName
Long		ll_SupplierDeliveryQty, ll_saverow

uo_status.st_message.text = ""
// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq090i_left.GetSelectedRow(0) = 0 THEN
	//MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	uo_status.st_message.text = '작업대상이 없습니다'
	RETURN 0
END IF

IF dw_pisq090i_left.GetItemString(dw_pisq090i_left.GetSelectedRow(0), "qcgubun") = 'C' THEN
	//MessageBox('확 인', '무검사 처리에서 작업하세요', StopSign!)
	uo_status.st_message.text = '무검사 처리에서 작업하세요'
	RETURN 0
END IF

// 성적서 작성에 필요한 정보를 구한다
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

// 인스턴스 스트럭쳐에 값을 저장한다
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

// 작업중인 행을 저장한다
//
ll_saverow = dw_pisq090i_left.GetSelectedRow(0)

// 검사성적서 판정화면 오픈
//
OpenWithParm(w_pisq111u, istr_parms)

// 처리가 완료후 화면의 자료를 다시 표시한다
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq090i_left.RowCount() THEN
	ll_saverow = dw_pisq090i_left.RowCount() 
END IF
	
// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
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
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// 트랜잭션을 연결한다
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
// 트랜잭션을 연결한다
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
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "납품일자:"
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
string facename = "굴림체"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;
IF f_checknullorspace(sle_date.Text) = FALSE THEN
	IF IsDate(sle_date.Text) = FALSE THEN
		MessageBox('확 인', '일자를 바르게 입력하세요', StopSign!)
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
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "협력업체:"
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
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// 업체명을 구한다
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
string facename = "굴림체"
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
	// 처리를 검사성적서 판정처리로 넘겨준다
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
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 거래명세표 정보 >"
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
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 검사성적서 정보 >"
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
string facename = "굴림체"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag		= 2			//외주업체(지역,공장)
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
string facename = "굴림체"
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
string facename = "굴림체"
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
string facename = "굴림체"
string text = "무검사처리"
end type

event clicked;
Long		ll_Lrow, ll_Rrow, ll_qty, ll_rownum, ll_rtn
String	ls_suppliercode, ls_itemcode, ls_find, ls_qcgubun, ls_passflag

uo_status.st_message.text = ""
// 거래명세표 수만큼 루프처리한다
//
FOR ll_Lrow = 1 TO dw_pisq090i_left.RowCount()
	// 거래명세표와 검사성적서 매칭 처리할 키값을 구한다(업체코드 + 품번 + 수량)
	//
	ls_suppliercode	= dw_pisq090i_left.GetItemString(ll_Lrow, 'suppliercode')
	ls_itemcode			= dw_pisq090i_left.GetItemString(ll_Lrow, 'itemcode')
	ll_qty				= dw_pisq090i_left.GetItemNumber(ll_Lrow, 'supplierdeliveryqty')
	ls_qcgubun			= ''
	ls_qcgubun			= dw_pisq090i_left.GetItemString(ll_Lrow, 'qcgubun')

	// 무검사품만을 대상으로 한다
	//
	IF ls_qcgubun = 'Q' THEN
		// 서치할 조건을 만든다
		//
		ls_find = "suppliercode = '" + ls_suppliercode + "'" 
		ls_find = ls_find + " and itemcode= '" + ls_itemcode + "'" 
		ls_find = ls_find + " and supplierdeliveryqty = " + String(ll_qty)

		ls_passflag = 'Y'

		// 검사성적서의 자료가 한건도 없는경우는 바로 판정처리를 한다
		//
		IF dw_pisq090i_Right.RowCount() = 0 THEN
			// 거래명세표의 현재로우를 역상표시한다
			//
			f_SetHighlight(dw_pisq090i_Left, ll_Lrow, True)	

			ll_rtn = MessageBox('확 인', '작성된 검사성적서가 없습니다. 자동으로 검사성적서를 작성하겠습니까', &
										Exclamation!, OKCancel!, 2)
			IF ll_rtn = 1 THEN
				// 검사성적서를 신규로 작성하고 거래명세표 정보는 삭제한다
				// 왜 삭제하냐? => 무검사품은 입하속보에서 합격되는순간 입고처리되면서 인터페이스만
				// 	시키고 해당정보를 삭제하므로 인터페이스 할필요가 없기때문에 삭제한다
				//
				IF wf_InsertQcResult(ll_Lrow, ll_rownum) = FALSE THEN
					MessageBox('확 인', '검사성적서 작성에 실패했습니다')
					RETURN 0
				END IF
			END IF				
		END IF
		
		// 검사성적서 수만큼 루프처리한다
		//
		FOR ll_Rrow = 1 TO dw_pisq090i_Right.RowCount()
			// 서치를 한다. 서치된 자료가 있으면 해당 로우값을 리턴하고 없으면 0
			//
			ll_rownum = dw_pisq090i_Right.find (ls_find, ll_Rrow, dw_pisq090i_Right.RowCount())
		
			// 거래명세표의 현재로우를 역상표시한다
			//
			f_SetHighlight(dw_pisq090i_Left, ll_Lrow, True)	

			// 검사성적서의 서치된 로우를 역상표시한다
			//
			IF ll_rownum = 0 THEN
				f_SetHighlight(dw_pisq090i_Right, 1, True)	
			ELSE
				f_SetHighlight(dw_pisq090i_Right, ll_rownum, True)	
			END IF
	
			// 서치된 검사성적서가 없다
			//
			f_SetHighlight(dw_pisq090i_Right, ll_rownum, True)	
			
			IF ll_rownum = 0 and ls_passflag = 'Y' THEN
				ll_rtn = MessageBox('확 인', '작성된 검사성적서가 없습니다. 자동으로 검사성적서를 작성하겠습니까', &
											Exclamation!, OKCancel!, 2)
				IF ll_rtn = 1 THEN
//					 검사성적서를 신규로 작성하고 거래명세표 정보는 삭제한다
//					 왜 삭제하냐? => 무검사품은 입하속보에서 합격되는순간 입고처리되면서 인터페이스만
//					 	시키고 해당정보를 삭제하므로 인터페이스 할필요가 없기때문에 삭제한다
//					
					IF wf_InsertQcResult(ll_Lrow, ll_rownum) = FALSE THEN
						MessageBox('확 인', '검사성적서 작성에 실패했습니다')
						RETURN 0
					END IF
				END IF				
				EXIT
			END IF

			// 서치된 검사성적서가 있다
			//
			IF ll_rownum <> 0 THEN

				// 검사성적서가 한번이라도 서치된 자료는 검사성적서 신규 작성 루틴으로 못 흘러가게
				//
				ls_passflag = 'N'

				// 서치된 로우값을 루프변수에 셋트하여 서치된 이후부터 루프처리되게한다
				//
				ll_Rrow = ll_rownum
				
				ll_rtn = MessageBox('확 인', '작성된 검사성적서가 있습니다. 합격처리 하시겠습니까?', &
											Exclamation!, OKCancel!, 2)
				IF ll_rtn = 1 THEN
//					 검사성적서를 합격으로 수정하고 거래명세표 정보는 삭제한다
					
					IF wf_UpdateQcResult(ll_Lrow, ll_rownum) = FALSE THEN
						MessageBox('확 인', '검사성적서 합격처리에 실패했습니다')
						RETURN 0
					END IF
					// 거래명세표에 해당하는 검사성적서를 작성했으므로 검사성적서 서치 루프를
					// 종료하고 상위 루프로 이동한다
					//
					EXIT
				END IF				
			END IF
		NEXT
	END IF
NEXT

// 처리가 완료되면 자료를 재조회한다
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
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 30593702
string text = "무검사품"
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
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 30593702
string text = "무검사품"
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
string facename = "굴림체"
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
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

