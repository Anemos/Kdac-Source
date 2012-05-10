$PBExportHeader$w_pisq400u.srw
$PBExportComments$RRPPM CLAIM수량 입력
forward
global type w_pisq400u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq400u
end type
type uo_division from u_pisc_select_division within w_pisq400u
end type
type dw_pisq400u_01 from u_vi_std_datawindow within w_pisq400u
end type
type gb_2 from groupbox within w_pisq400u
end type
type uo_custcode from u_piss_select_custcode within w_pisq400u
end type
type st_8 from statictext within w_pisq400u
end type
type uo_scustgubun from u_pisc_select_code within w_pisq400u
end type
type dw_pisq400u_02 from u_vi_std_datawindow within w_pisq400u
end type
type uo_month from u_pisc_date_scroll_month within w_pisq400u
end type
type gb_3 from groupbox within w_pisq400u
end type
type st_5 from statictext within w_pisq400u
end type
type cbx_all from checkbox within w_pisq400u
end type
end forward

global type w_pisq400u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "RRPPM CLAIM수량 입력"
uo_area uo_area
uo_division uo_division
dw_pisq400u_01 dw_pisq400u_01
gb_2 gb_2
uo_custcode uo_custcode
st_8 st_8
uo_scustgubun uo_scustgubun
dw_pisq400u_02 dw_pisq400u_02
uo_month uo_month
gb_3 gb_3
st_5 st_5
cbx_all cbx_all
end type
global w_pisq400u w_pisq400u

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

forward prototypes
public function boolean wf_checkcolumn ()
public function boolean wf_claimtofault ()
end prototypes

public function boolean wf_checkcolumn ();
Long		ll_row
Boolean	lb_rtn = TRUE

IF dw_pisq400u_02.AcceptText() <> 1 THEN RETURN FALSE

// 검사수량 체크
//
FOR ll_row = 1 TO dw_pisq400u_02.RowCount()
	// 결함수량 및 결함내용
	//
	IF dw_pisq400u_02.GetItemNumber(ll_row, 'faultqty') = 0 OR &
		IsNull(dw_pisq400u_02.GetItemNumber(ll_row, 'faultqty')) = TRUE THEN
		MessageBox('확 인', '결함수량을 입력하세요', StopSign!)
		dw_pisq400u_02.ScrollToRow(ll_row)
		f_SetHighlight(dw_pisq400u_02, ll_row, True)	
		dw_pisq400u_02.SetColumn('faultqty')
		dw_pisq400u_02.SetFocus()
		RETURN FALSE
	END IF
	IF f_checknullorspace(dw_pisq400u_02.GetItemString(ll_row, 'faultstatus')) = TRUE THEN
		MessageBox('확 인', '결함내용을 입력하세요', StopSign!)
		dw_pisq400u_02.ScrollToRow(ll_row)
		f_SetHighlight(dw_pisq400u_02, ll_row, True)	
		dw_pisq400u_02.SetColumn('faultstatus')
		dw_pisq400u_02.SetFocus()
		RETURN FALSE
	END IF
NEXT

RETURN lb_rtn

end function

public function boolean wf_claimtofault ();
Long		ll_row, ll_claimqty = 0, ll_faultqty = 0
Boolean	lb_rtn = TRUE

IF dw_pisq400u_01.AcceptText() <> 1 THEN RETURN FALSE
IF dw_pisq400u_02.AcceptText() <> 1 THEN RETURN FALSE

// CLAIM수량
//
ll_claimqty = dw_pisq400u_01.GetItemNumber(dw_pisq400u_01.GetSelectedRow(0), 'claimqty')

// 결함수량
//
IF dw_pisq400u_02.RowCount() = 0 THEN
	ll_faultqty = 0
ELSE
	FOR ll_row = 1 TO dw_pisq400u_02.RowCount()
		ll_faultqty = ll_faultqty + dw_pisq400u_02.GetItemNumber(ll_row, 'faultqty')
	NEXT
END IF

IF ll_claimqty <> ll_faultqty THEN
	MessageBox('확 인', 'CLAIM수량:' + String(ll_claimqty) + '개와 ' + &
							  '결함수량:'  + String(ll_faultqty) + '개가 일치하지 않습니다', StopSign!) 
	lb_rtn = FALSE
END IF

RETURN lb_rtn

end function

on w_pisq400u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq400u_01=create dw_pisq400u_01
this.gb_2=create gb_2
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.dw_pisq400u_02=create dw_pisq400u_02
this.uo_month=create uo_month
this.gb_3=create gb_3
this.st_5=create st_5
this.cbx_all=create cbx_all
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq400u_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.uo_custcode
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.uo_scustgubun
this.Control[iCurrent+8]=this.dw_pisq400u_02
this.Control[iCurrent+9]=this.uo_month
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.cbx_all
end on

on w_pisq400u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq400u_01)
destroy(this.gb_2)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.dw_pisq400u_02)
destroy(this.uo_month)
destroy(this.gb_3)
destroy(this.st_5)
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
String	ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode
String	ls_productgroup, ls_productgroupname, ls_raisedateFm, ls_raisedateTo
Long		ll_row, ll_shipqty

// 조회에 필요한 값을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_raisedate		= uo_month.is_uo_month
ls_customercode	= is_custcode
ls_raisedateFm		= uo_month.is_uo_month + '.01'
ls_raisedateTo		= uo_month.is_uo_month + '.' + String(f_get_lastday_of_month(uo_month.is_uo_month),'00')

// 전체가 선택되면
//
IF cbx_all.Checked = TRUE THEN
	ls_customercode = '%'
END IF

IF uo_month.is_uo_month >= String(f_getsysdatetime(), 'yyyy.mm') THEN
	MessageBox('확 인', '지난달 자료만 처리 가능합니다')
	RETURN
END IF

// 데이타를 조회한다
//
dw_pisq400u_01.Retrieve(ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode)

// 저장된 자료가 없으면 제품군 마스타의 제품군을 표시한다
//
IF dw_pisq400u_01.RowCount() = 0 THEN
	// 커서선언
	//
	DECLARE PRODUCT_CURS CURSOR FOR
		SELECT A.PRODUCTGROUP,   
         	 A.PRODUCTGROUPNAME  
        FROM TMSTPRODUCTGROUP  A
       WHERE A.AREACODE			= :ls_areacode
         AND A.DIVISIONCODE	= :ls_divisioncode
		USING SQLEIS;	
		
	// 커서오픈
	//
	OPEN PRODUCT_CURS ;	

	dw_pisq400u_01.SetRedraw(FALSE)
	
	DO WHILE SQLEIS.SQLCode = 0
		// DATA FETCH
		//
		FETCH PRODUCT_CURS INTO :ls_productgroup, :ls_productgroupname ;	
		// 마지막 한번 더 흐르는것을 방지
		//
		IF SQLEIS.SQLCode <> 0 THEN 
			EXIT
		END IF
		// 신규로우생성
		//
		ll_row = dw_pisq400u_01.InsertRow(0)
		// 테이블키 셋트
		//
		dw_pisq400u_01.SetItem(ll_row, 'areacode'				, ls_areacode)
		dw_pisq400u_01.SetItem(ll_row, 'DivisionCode'		, ls_DivisionCode)
		dw_pisq400u_01.SetItem(ll_row, 'raisedate'			, ls_raisedate)
		dw_pisq400u_01.SetItem(ll_row, 'customercode'		, ls_customercode)
		// FETCH한 그룹코드,명셋트
		//
		dw_pisq400u_01.SetItem(ll_row, 'productgroup'		, ls_productgroup)
		dw_pisq400u_01.SetItem(ll_row, 'productgroupname'	, ls_productgroupname)

		// 출하수량을 구한다
		//
		ll_shipqty = 0
		SELECT SUM(A.SHIPQTY)
		  INTO :ll_shipqty
		  FROM TLOTNO			A,
				 VMSTKB_MODEL	B
		 WHERE A.AREACODE		=  B.AREACODE		
			AND A.DIVISIONCODE=  B.DIVISIONCODE
			AND A.ITEMCODE		=  B.ITEMCODE
			AND B.PRODUCTGROUP=	:ls_productgroup
			AND A.AREACODE		=  :ls_areacode
			AND A.DIVISIONCODE=  :ls_DivisionCode
			AND A.TRACEDATE	>= :ls_raisedateFm
			AND A.TRACEDATE	<= :ls_raisedateTo
			AND A.CUSTCODE		=  :ls_customercode
			AND A.SHIPGUBUN	=  'A'
		 USING SQLEIS;	
 
		SQLEIS.SQLCode = 0

		dw_pisq400u_01.SetItem(ll_row, 'shipqty'	, ll_shipqty)
	LOOP

	// 커서크로즈
	//
	CLOSE PRODUCT_CURS ;	
	dw_pisq400u_01.SetRedraw(TRUE)
END IF

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq400u_01, 1, True)	

// 결함내용의 자료를 조회한다
//
ls_productgroup = dw_pisq400u_01.GetItemString(dw_pisq400u_01.GetSelectedRow(0), 'productgroup')
dw_pisq400u_02.Retrieve(ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode, ls_productgroup)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq400u_02, 1, True)	

dw_pisq400u_01.SetColumn('claimqty')
dw_pisq400u_01.SetFocus()

end event

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq400u_01.SetTransObject(SQLEIS)
dw_pisq400u_02.SetTransObject(SQLEIS)

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

event ue_insert;call super::ue_insert;
String	ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode, ls_productgroup
Long		ll_row


// 최종 입력행을 구한다
//
ll_row = dw_pisq400u_02.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_raisedate		= uo_month.is_uo_month
ls_customercode	= is_custcode
ls_productgroup	= dw_pisq400u_01.GetItemString(dw_pisq400u_01.GetSelectedRow(0), 'productgroup')

dw_pisq400u_02.SetItem(ll_row, 'areacode'			, ls_areacode)
dw_pisq400u_02.SetItem(ll_row, 'divisioncode'	, ls_divisioncode)
dw_pisq400u_02.SetItem(ll_row, 'raisedate'		, ls_raisedate)
dw_pisq400u_02.SetItem(ll_row, 'customercode'	, ls_customercode)
dw_pisq400u_02.SetItem(ll_row, 'productgroup'	, ls_productgroup)
dw_pisq400u_02.SetItem(ll_row, 'seqno'				, ll_row)

// 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq400u_02, ll_row, True)	

dw_pisq400u_02.SetColumn('faultqty')
dw_pisq400u_02.SetFocus()

end event

event ue_delete;call super::ue_delete;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno
Int		li_save, ll_select_row

IF dw_pisq400u_02.RowCount() = 0 THEN
	MessageBox('확 인', '삭제할 대상이 없습니다')
	RETURN
END IF

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq400u_02.GetSelectedRow(0)

// 선택된 행을 삭제한다
//
dw_pisq400u_02.DeleteRow(ll_select_row)

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq400u_02.RowCount() THEN
	f_SetHighlight(dw_pisq400u_02, dw_pisq400u_02.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq400u_02, ll_select_row, True)	
END IF

end event

event ue_save;call super::ue_save;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno, ls_productgroup, ls_modelgroup
Int	li_save

// 필수입력 항목을 체크한다
//
IF wf_checkcolumn() = FALSE THEN RETURN

// CLAIM수량과 결함수량의 일치여부체크
//
IF wf_claimtofault() = FALSE THEN RETURN

// AUTO COMMIT을 FASLE로 지정
//
SQLEIS.AUTOCommit = FALSE

// 저장한다
//
li_save = dw_pisq400u_01.Update()
IF li_save <> 1 THEN
	// RollBack 처리
	//
	ROLLBACK USING SQLEIS;
	SQLEIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// 저장한다
//
li_save = dw_pisq400u_02.Update()
IF li_save <> 1 THEN
	// RollBack 처리
	//
	ROLLBACK USING SQLEIS;
	SQLEIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

SQLEIS.AUTOCommit = TRUE

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

String ls_codegroup, ls_codegroupname, ls_codename
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq400u
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq400u
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

type uo_division from u_pisc_select_division within w_pisq400u
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
////	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
////						string			fs_areacode				조회하고자 하는 지역
////						string			fs_divisioncode		조회하고자 하는 공장 코드
////						string			fs_productgroup		조회하고자 하는 제품군 코드 (일반적으로 '%' 을 사용하도록)
////						boolean			fb_allflag				조회된 제품군 정보가 2개 이상의 Record 일 경우
////																		True : '전체' 항목 삽입 (제품군코드는 '%', 제품군명은 '전체')
////																		False : '전체' 항목 미 삽입
////						string			rs_productgroup		선택된 제품군 코드 (reference)
////						string			rs_productgroupname	선택된 제품군 명 (reference)
////	Returns		: none
////	Description	: 제품군을 선택하기 위한 DDDW 을 조회하기 위하여
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

type dw_pisq400u_01 from u_vi_std_datawindow within w_pisq400u
integer x = 46
integer y = 216
integer width = 1842
integer height = 2328
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq400u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;
String	ls_colname, ls_coldata
String	ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode, ls_itemcode, ls_smallgroupname

// 조회에 필요한 값을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 분석코드를 입력하면 해당명을 가져온다
	//
	CASE 'analyzecode'
		SELECT A.SMALLGROUPNAME  
		  INTO :ls_smallgroupname
		  FROM TQWARRANTYSMALL A
		 WHERE A.AREACODE			= :ls_areacode
		   AND A.DIVISIONCODE	= :ls_DivisionCode
			AND A.LARGEGROUPCODE	= SUBSTRING(:ls_coldata, 1, 1)
			AND A.MIDDLEGROUPCODE= SUBSTRING(:ls_coldata, 2, 1)
			AND A.SMALLGROUPCODE	= SUBSTRING(:ls_coldata, 3, 2)
		USING SQLEIS;

		IF SQLEIS.SQLCode = 0 THEN
			This.Setitem(row, 'smallgroupname', ls_smallgroupname)
		ELSE
			MessageBox('확 인', '해당코드는 미등록 코드입니다', StopSign!)
			This.SetColumn('analyzecode')
			This.SetFocus()
			RETURN 1
		END IF

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event rowfocuschanged;
String	ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode, ls_productgroup

// 조회에 필요한 값을 구한다
//
if uo_area.dw_1.GetRow() < 1 then
	return 0
end if
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_raisedate		= uo_month.is_uo_month
ls_customercode	= is_custcode

// 선택행이 바뀔때마다 결함내용의 자료를 조회한다
//
if dw_pisq400u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_productgroup = dw_pisq400u_01.GetItemString(dw_pisq400u_01.GetSelectedRow(0), 'productgroup')
dw_pisq400u_02.Retrieve(ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode, ls_productgroup)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq400u_02, 1, True)	



end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)

end event

type gb_2 from groupbox within w_pisq400u
integer x = 18
integer y = 12
integer width = 4229
integer height = 168
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_custcode from u_piss_select_custcode within w_pisq400u
event destroy ( )
integer x = 2944
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

type st_8 from statictext within w_pisq400u
integer x = 1902
integer y = 68
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "고객구분:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq400u
event destroy ( )
integer x = 2190
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
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
//dw_sheet.reset()

end event

event ue_post_constructor;string ls_custname
//is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type dw_pisq400u_02 from u_vi_std_datawindow within w_pisq400u
integer x = 1906
integer y = 216
integer width = 2304
integer height = 2328
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_pisq400u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;
String	ls_colname, ls_coldata
String	ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode, ls_itemcode, ls_smallgroupname

// 조회에 필요한 값을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 분석코드를 입력하면 해당명을 가져온다
	//
	CASE 'analyzecode'
		SELECT A.SMALLGROUPNAME  
		  INTO :ls_smallgroupname
		  FROM TQWARRANTYSMALL A
		 WHERE A.AREACODE			= :ls_areacode
		   AND A.DIVISIONCODE	= :ls_DivisionCode
			AND A.LARGEGROUPCODE	= SUBSTRING(:ls_coldata, 1, 1)
			AND A.MIDDLEGROUPCODE= SUBSTRING(:ls_coldata, 2, 1)
			AND A.SMALLGROUPCODE	= SUBSTRING(:ls_coldata, 3, 2)
		USING SQLEIS;

		IF SQLEIS.SQLCode = 0 THEN
			This.Setitem(row, 'smallgroupname', ls_smallgroupname)
		ELSE
			MessageBox('확 인', '해당코드는 미등록 코드입니다', StopSign!)
			This.SetColumn('analyzecode')
			This.SetFocus()
			RETURN 1
		END IF

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

type uo_month from u_pisc_date_scroll_month within w_pisq400u
event destroy ( )
integer x = 1248
integer y = 60
integer height = 80
integer taborder = 30
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type gb_3 from groupbox within w_pisq400u
integer x = 18
integer y = 184
integer width = 4229
integer height = 2388
integer taborder = 70
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type st_5 from statictext within w_pisq400u
integer x = 1234
integer y = 68
integer width = 229
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "발생월:"
boolean focusrectangle = false
end type

type cbx_all from checkbox within w_pisq400u
boolean visible = false
integer x = 3986
integer y = 68
integer width = 201
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "전체"
boolean lefttext = true
end type

