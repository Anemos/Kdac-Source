$PBExportHeader$w_pisq180u.srw
$PBExportComments$공정불량등록
forward
global type w_pisq180u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq180u
end type
type uo_division from u_pisc_select_division within w_pisq180u
end type
type dw_pisq180u_01 from u_vi_std_datawindow within w_pisq180u
end type
type dw_pisq180u_02 from u_vi_std_datawindow within w_pisq180u
end type
type dw_pisq180u_03 from u_vi_std_datawindow within w_pisq180u
end type
type gb_2 from groupbox within w_pisq180u
end type
type gb_3 from groupbox within w_pisq180u
end type
type gb_1 from groupbox within w_pisq180u
end type
type dw_pisq180u_04 from u_vi_std_datawindow within w_pisq180u
end type
type cb_allins from commandbutton within w_pisq180u
end type
type cb_regtotal from commandbutton within w_pisq180u
end type
end forward

global type w_pisq180u from w_ipis_sheet01
integer width = 4709
integer height = 2700
string title = "공정불량 등록"
uo_area uo_area
uo_division uo_division
dw_pisq180u_01 dw_pisq180u_01
dw_pisq180u_02 dw_pisq180u_02
dw_pisq180u_03 dw_pisq180u_03
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
dw_pisq180u_04 dw_pisq180u_04
cb_allins cb_allins
cb_regtotal cb_regtotal
end type
global w_pisq180u w_pisq180u

type variables

String	is_AreaCode, is_DivisionCode
datawindowchild	idwc_largegroup, idwc_middlegroup, idwc_smallgroup
datawindowchild	idwc_badreason, idwc_badtype

end variables

forward prototypes
public function boolean wf_getprocesscost ()
public subroutine wf_detail_temp_insert ()
public function boolean wf_checkcolumn ()
public subroutine wf_detail_temp_delete ()
end prototypes

public function boolean wf_getprocesscost ();
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode
Long		ll_processcost = 0

IF dw_pisq180u_01.AcceptText() <> 1 THEN RETURN FALSE

// 셀렉트 조건의 자료를 구한다
//
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// 생산원가를 구한다(제품소분류별 최종공정의 제조원가)
//
SELECT A.PROCESSCOST  
  INTO :ll_processcost  
  FROM TQSMALLGROUPTOPROCESS  A
 WHERE A.AREACODE				= :is_areacode
   AND A.DIVISIONCODE		= :is_divisioncode
	AND A.LARGEGROUPCODE		= :ls_largegroupcode
	AND A.MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND A.SMALLGROUPCODE		= :ls_smallgroupcode
	AND A.FINALPROCESSFLAG	= '1' 
USING SQLPIS;

IF SQLPIS.SQLCode = 0 THEN
	dw_pisq180u_01.SetItem(1, 'processcost', ll_processcost)
ELSE
	MessageBox('확 인', '생산원가를 구하는데 실패했습니다', StopSign!)
	RETURN FALSE
END IF

// 공정별 제조원가를 구한다
//
SELECT A.PROCESSCOST  
  INTO :ll_processcost  
  FROM TQSMALLGROUPTOPROCESS  A
 WHERE A.AREACODE				= :is_areacode
   AND A.DIVISIONCODE		= :is_divisioncode
	AND A.LARGEGROUPCODE		= :ls_largegroupcode
	AND A.MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND A.SMALLGROUPCODE		= :ls_smallgroupcode
	AND A.PROCESSCODE			= :ls_processcode
USING SQLPIS;

IF SQLPIS.SQLCode = 0 THEN
	dw_pisq180u_04.SetItem(1, 'processcost', ll_processcost)
ELSE
	MessageBox('확 인', '공정별 제조원가를 구하는데 실패했습니다', StopSign!)
	RETURN FALSE
END IF

RETURN TRUE
end function

public subroutine wf_detail_temp_insert ();
String	ls_originationdate, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_processcode, ls_badreasoncode, ls_badtypecode, ls_memo
Long		ll_repairqty, ll_disuseqty, ll_totalqty, ll_processcost, ll_reccnt = 0

// 저장에 필요한 기본자료를 구한다
//
ls_originationdate= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')
ls_badreasoncode	= dw_pisq180u_04.GetItemString(1, 'badreasoncode')
ls_badtypecode		= dw_pisq180u_04.GetItemString(1, 'badtypecode')
ls_memo				= dw_pisq180u_04.GetItemString(1, 'memo')
ll_repairqty		= dw_pisq180u_04.GetItemNumber(1, 'repairqty')
ll_disuseqty		= dw_pisq180u_04.GetItemNumber(1, 'disuseqty')
ll_totalqty			= dw_pisq180u_04.GetItemNumber(1, 'totalqty')
ll_processcost		= dw_pisq180u_04.GetItemNumber(1, 'processcost')

// 신규인지 수정인지 확인한다
//
SELECT count(*)
  INTO :ll_reccnt
  FROM TQPROGRESSBADDETAIL_TEMP
 WHERE AREACODE			= :is_areacode
	AND DIVISIONCODE		= :is_divisioncode
	AND ORIGINATIONDATE	= :ls_originationdate
	AND LARGEGROUPCODE	= :ls_largegroupcode
	AND MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND SMALLGROUPCODE	= :ls_smallgroupcode
	AND PROCESSCODE		= :ls_processcode
	AND BADREASONCODE		= :ls_badreasoncode
	AND BADTYPECODE		= :ls_badtypecode
USING SQLPIS;

IF ll_reccnt = 0 THEN
	// 신규
	//
	INSERT INTO TQPROGRESSBADDETAIL_TEMP  
				 ( AREACODE,   
					DIVISIONCODE,   
					ORIGINATIONDATE,   
					LARGEGROUPCODE,   
					MIDDLEGROUPCODE,   
					SMALLGROUPCODE,   
					PROCESSCODE,   
					BADREASONCODE,   
					BADTYPECODE,   
					MEMO,   
					REPAIRQTY,   
					DISUSEQTY,   
					TOTALQTY,   
					PROCESSCOST,   
					LastEmp	)  
		VALUES ( :is_areacode,
					:is_divisioncode,
					:ls_originationdate,
					:ls_largegroupcode,
					:ls_middlegroupcode,
					:ls_smallgroupcode,
					:ls_processcode,
					:ls_badreasoncode,
					:ls_badtypecode,
					:ls_memo,
					:ll_repairqty,
					:ll_disuseqty,
					:ll_totalqty,
					:ll_processcost,
					'Y')
	USING SQLPIS;
ELSE
	// 수정
	//
	UPDATE TQPROGRESSBADDETAIL_TEMP  
		SET MEMO			= :ls_memo,
			 REPAIRQTY	= :ll_repairqty,
			 DISUSEQTY	= :ll_disuseqty,
			 TOTALQTY	= :ll_totalqty,
			 PROCESSCOST= :ll_processcost,
			 LastEmp		= 'Y'  
	 WHERE AREACODE			= :is_areacode
		AND DIVISIONCODE		= :is_divisioncode
		AND ORIGINATIONDATE	= :ls_originationdate
		AND LARGEGROUPCODE	= :ls_largegroupcode
		AND MIDDLEGROUPCODE	= :ls_middlegroupcode
		AND SMALLGROUPCODE	= :ls_smallgroupcode
		AND PROCESSCODE		= :ls_processcode
		AND BADREASONCODE		= :ls_badreasoncode
		AND BADTYPECODE		= :ls_badtypecode
	USING SQLPIS;
END IF

end subroutine

public function boolean wf_checkcolumn ();
Long		ll_repairqty, ll_disuseqty
Boolean	lb_rtn = TRUE

IF dw_pisq180u_01.AcceptText() <> 1 THEN RETURN FALSE
IF dw_pisq180u_04.AcceptText() <> 1 THEN RETURN FALSE

//// 생산수량 체크
////
//IF dw_pisq180u_01.GetItemNumber(1, 'productqty') = 0 OR &
//	IsNull(dw_pisq180u_01.GetItemNumber(1, 'productqty')) = TRUE THEN
//	MessageBox('확 인', '생산수량을 입력하세요', StopSign!)
//	dw_pisq180u_01.SetColumn('productqty')
//	dw_pisq180u_01.SetFocus()
//	RETURN FALSE
//END IF

// 입력이 없으면 체크에서 제외
//
IF dw_pisq180u_04.RowCount() < 1 THEN
	RETURN TRUE
END IF

// 불량원인 체크
//
IF f_checknullorspace(dw_pisq180u_04.GetItemString(1, 'badreasoncode')) = TRUE THEN
	MessageBox('확 인', '불량원인을 입력하세요', StopSign!)
	dw_pisq180u_04.SetColumn('badreasoncode')
	dw_pisq180u_04.SetFocus()
	RETURN FALSE
END IF

// 불량유형 체크
//
IF f_checknullorspace(dw_pisq180u_04.GetItemString(1, 'badtypecode')) = TRUE THEN
	MessageBox('확 인', '불량유형을 입력하세요', StopSign!)
	dw_pisq180u_04.SetColumn('badtypecode')
	dw_pisq180u_04.SetFocus()
	RETURN FALSE
END IF

// 수리/폐기 체크
//
ll_repairqty = dw_pisq180u_04.GetItemNumber(1, 'repairqty') 
ll_disuseqty = dw_pisq180u_04.GetItemNumber(1, 'disuseqty') 

IF IsNull(ll_repairqty) = TRUE THEN
	ll_repairqty = 0
END IF
IF IsNull(ll_disuseqty) = TRUE THEN
	ll_disuseqty = 0
END IF

IF ll_repairqty = 0 AND ll_disuseqty = 0 THEN
	MessageBox('확 인', '수리/폐기중 한쪽이라도 입력되어야 합니다', StopSign!)
	dw_pisq180u_04.SetColumn('repairqty')
	dw_pisq180u_04.SetFocus()
	RETURN FALSE
ELSE
	// 합계를 셋트한다
	//
	dw_pisq180u_04.SetItem(1, 'totalqty', ll_repairqty + ll_disuseqty)
END IF

RETURN lb_rtn

end function

public subroutine wf_detail_temp_delete ();
String	ls_originationdate, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_processcode, ls_badreasoncode, ls_badtypecode

// 삭제에 필요한 기본자료를 구한다
//
ls_originationdate= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')
ls_badreasoncode	= dw_pisq180u_04.GetItemString(1, 'badreasoncode')
ls_badtypecode		= dw_pisq180u_04.GetItemString(1, 'badtypecode')

// 삭제(실제로는 값만 초기화한다)
//
UPDATE TQPROGRESSBADDETAIL_TEMP  
	SET MEMO			= '',
		 REPAIRQTY	= 0,
		 DISUSEQTY	= 0,
		 TOTALQTY	= 0,
		 PROCESSCOST= 0,
		 LastEmp		= 'Y'  
 WHERE AREACODE			= :is_areacode
	AND DIVISIONCODE		= :is_divisioncode
	AND ORIGINATIONDATE	= :ls_originationdate
	AND LARGEGROUPCODE	= :ls_largegroupcode
	AND MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND SMALLGROUPCODE	= :ls_smallgroupcode
	AND PROCESSCODE		= :ls_processcode
	AND BADREASONCODE		= :ls_badreasoncode
	AND BADTYPECODE		= :ls_badtypecode
USING SQLPIS;

end subroutine

on w_pisq180u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq180u_01=create dw_pisq180u_01
this.dw_pisq180u_02=create dw_pisq180u_02
this.dw_pisq180u_03=create dw_pisq180u_03
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_pisq180u_04=create dw_pisq180u_04
this.cb_allins=create cb_allins
this.cb_regtotal=create cb_regtotal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq180u_01
this.Control[iCurrent+4]=this.dw_pisq180u_02
this.Control[iCurrent+5]=this.dw_pisq180u_03
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dw_pisq180u_04
this.Control[iCurrent+10]=this.cb_allins
this.Control[iCurrent+11]=this.cb_regtotal
end on

on w_pisq180u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq180u_01)
destroy(this.dw_pisq180u_02)
destroy(this.dw_pisq180u_03)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_pisq180u_04)
destroy(this.cb_allins)
destroy(this.cb_regtotal)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq080i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_date, ls_processcode
Long		ll_retrieverow

uo_status.st_message.text = ""
IF dw_pisq180u_01.AcceptText() <> 1 THEN RETURN

// 조회에 필요한 기본자료를 구한다
//
ls_date 				= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')

// 공정불량 헤드 자료를 조회한다
//
ll_retrieverow = dw_pisq180u_01.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)

IF ll_retrieverow = 0 THEN
	dw_pisq180u_01.ReSet()
	dw_pisq180u_01.InsertRow(0)
	dw_pisq180u_01.SetItem(1, 'originationdate', ls_date)
	dw_pisq180u_01.SetItem(1, 'largegroupcode' , ls_largegroupcode)
	dw_pisq180u_01.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
	dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
	dw_pisq180u_01.SetColumn('productqty')
END IF

// 공정을 조회한다
//
dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
ls_processcode		= dw_pisq180u_02.GetItemString(1, 'processcode')

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq180u_02, 1, True)	

// 공정불량 디테일 자료를 조회한다
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)

IF ll_retrieverow <> 0 THEN
	dw_pisq180u_03.SetColumn('badreasoncode')
	dw_pisq180u_03.SetFocus()
END IF

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

end event

event open;call super::open;
// 트랜잭션을 연결한다
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

// Child Datawindow 설정(제품 대/중/소 분류)
//
dw_pisq180u_01.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq180u_01.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq180u_01.GetChild ('smallgroupcode' , idwc_smallgroup)
dw_pisq180u_04.GetChild ('badreasoncode' 	, idwc_badreason)
dw_pisq180u_04.GetChild ('badtypecode' 	, idwc_badtype)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

uo_division.PostEvent('ue_select')


end event

event ue_insert;
uo_status.st_message.text = ""
dw_pisq180u_04.ReSet()
dw_pisq180u_04.InsertRow(0)

end event

event ue_delete;call super::ue_delete;
String	ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode
Long		ll_save, ll_selcount = 0

uo_status.st_message.text = ""
// 조회에 필요한 기본자료를 구한다
//
ls_date 				= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
if dw_pisq180u_02.GetSelectedRow(0) < 1 then
	uo_status.st_message.text = "삭제할 데이타를 선택하십시요"
	return 0
end if
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// InterFace용 템프파일도 삭제한다(실제로는 수량만 UPDATE)
//
wf_detail_temp_delete()

// 선택된 행을 삭제한다
//
dw_pisq180u_04.DeleteRow(1)

// 공정불량 디테일을 저장한다
//
ll_save = dw_pisq180u_04.Update()
IF ll_save = 1 THEN
//	// 남아있는 디데일 레코드수를 구한다
//	//
//	SELECT COUNT(*)
//     INTO :ll_selcount
//     FROM TQPROGRESSBADDETAIL 
//    WHERE AREACODE			= :is_AreaCode
//      AND DIVISIONCODE		= :is_DivisionCode
//      AND ORIGINATIONDATE	= :ls_date
//      AND LARGEGROUPCODE	= :ls_largegroupcode
//      AND MIDDLEGROUPCODE	= :ls_middlegroupcode
//      AND SMALLGROUPCODE	= :ls_smallgroupcode
//	 USING SQLPIS;
//
//	// 디데일이 없으면 마스타 자료도 삭제한다
//	//
//	IF ll_selcount = 0 THEN
//		DELETE 
//		  FROM TQPROGRESSBADMASTER 
//		 WHERE AREACODE			= :is_AreaCode
//			AND DIVISIONCODE		= :is_DivisionCode
//			AND ORIGINATIONDATE	= :ls_date
//			AND LARGEGROUPCODE	= :ls_largegroupcode
//			AND MIDDLEGROUPCODE	= :ls_middlegroupcode
//			AND SMALLGROUPCODE	= :ls_smallgroupcode
//		 USING SQLPIS;
//	END IF
	// Commit 처리
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// 공정불량 디테일 자료를 조회한다
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

dw_pisq180u_04.ReSet()

end event

event ue_save;call super::ue_save;
String	ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode
Int	li_save

uo_status.st_message.text = ""
ls_date = dw_pisq180u_01.GetItemString(1, 'originationdate')

IF Len(Trim((ls_date))) <> 10 THEN
	MessageBox('확 인', '일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF f_checknullorspace(ls_date) = TRUE THEN
	MessageBox('확 인', '일자를 입력하세요', StopSign!)
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF IsDate(ls_date) = FALSE THEN
	MessageBox('확 인', '일자를 바르게 입력하세요', StopSign!)
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

// 필수입력 항목을 체크한다
//
IF wf_checkcolumn() = FALSE THEN RETURN 0

// 생산원가와 공정별 제조원가를 구한다
//
IF wf_getprocesscost() = FALSE THEN RETURN 0

// 저장에 필요한 기본자료를 구한다
//
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// 테이블 키부분을 셋트한다
//
dw_pisq180u_01.SetItem(1, 'areacode'			, is_areacode)
dw_pisq180u_01.SetItem(1, 'divisioncode'		, is_divisioncode)

dw_pisq180u_04.SetItem(1, 'areacode'			, is_areacode)
dw_pisq180u_04.SetItem(1, 'divisioncode'		, is_divisioncode)
dw_pisq180u_04.SetItem(1, 'originationdate'	, ls_date)
dw_pisq180u_04.SetItem(1, 'largegroupcode'	, ls_largegroupcode)
dw_pisq180u_04.SetItem(1, 'middlegroupcode'	, ls_middlegroupcode)
dw_pisq180u_04.SetItem(1, 'smallgroupcode'	, ls_smallgroupcode)
dw_pisq180u_04.SetItem(1, 'processcode'		, ls_processcode)

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// 공정불량 헤드를 저장한다
//
li_save = dw_pisq180u_01.Update()
IF li_save <> 1 THEN
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// 공정불량 디테일를 저장한다
//
li_save = dw_pisq180u_04.Update()
IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "정상적으로 처리되었습니다."
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// InterFace용 템프파일에도 저장한다
//
wf_detail_temp_insert()

SQLPIS.AUTOCommit = TRUE

// 공정불량 디테일 자료를 조회한다
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

dw_pisq180u_04.ReSet()

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq180u
integer x = 18
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq180u
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
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

uo_division.PostEvent('ue_select')

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

type uo_division from u_pisc_select_division within w_pisq180u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_date, ls_processcode, ls_badreasoncode
Long		ll_retrieverow 

// 트랜잭션을 연결한다
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

// 차일드 윈도우 트랜잭션을 연결한다
//
idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )
//
if uo_area.dw_1.GetRow() < 1 then
	return 
end if
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

//데이타윈도우 리셋
dw_pisq180u_01.reset()
dw_pisq180u_02.reset()
dw_pisq180u_03.reset()

// Child Retrieve(대분류)
//
ll_retrieverow = idwc_largegroup.Retrieve(is_AreaCode, is_DivisionCode)
if ll_retrieverow > 0 then
	// Child Window에서 대분류 코드를 구한다
	//
	ls_largegroupcode = idwc_largegroup.GetItemString(1, 'largegroupcode')
else
	ls_largegroupcode = ' '
end if
// Child Retrieve(중분류)
//
ll_retrieverow = idwc_middlegroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode)
if ll_retrieverow > 0 then
	// Child Window에서 중분류 코드를 구한다
	//
	ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')
else
	ls_middlegroupcode = ' '
end if
// Child Retrieve(소분류)
//
ll_retrieverow = idwc_smallgroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
if ll_retrieverow > 0 then
	// Child Window에서 소분류 코드를 구한다
	//
	ls_smallgroupcode = idwc_smallgroup.GetItemString(1, 'smallgroupcode')
else
	ls_smallgroupcode = ' '
end if

dw_pisq180u_01.InsertRow(0)
dw_pisq180u_01.SetItem(1, 'originationdate', String(f_getsysdatetime(), 'yyyy.mm.dd'))
dw_pisq180u_01.SetItem(1, 'largegroupcode' , ls_largegroupcode)
dw_pisq180u_01.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)

// 불량원인/불량유형 차일드윈도우를  조회한다
//
idwc_badreason.Retrieve('QCPR01')
ls_badreasoncode = idwc_badreason.GetItemString(1, 'codeid')
idwc_badtype.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_badreasoncode)

// 공정을 조회한다
//
dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
f_SetHighlight(dw_pisq180u_02, 1, True)	

// 디테일 입력이 가능하게 1 ROW를 미리 생성해둔다
//
//cb_ins.TriggerEvent(Clicked!)



end event

type dw_pisq180u_01 from u_vi_std_datawindow within w_pisq180u
integer x = 46
integer y = 212
integer width = 4169
integer height = 188
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_pisq180u_01"
boolean livescroll = false
end type

event rowfocuschanged;
//
end event

event clicked;
//
end event

event itemchanged;
String	ls_colname, ls_coldata, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
long ll_rowcnt

IF dw_pisq180u_01.AcceptText() <> 1 OR ROW < 1 THEN RETURN 0

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	CASE 'originationdate'
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			dw_pisq180u_01.SetColumn('originationdate')		
			dw_pisq180u_01.SetFocus()
			RETURN 1
		END IF			

		IF f_checknullorspace(ls_coldata) = TRUE THEN
			MessageBox('확 인', '일자를 입력하세요', StopSign!)
			dw_pisq180u_01.SetColumn('originationdate')		
			dw_pisq180u_01.SetFocus()
			RETURN 1
		END IF			

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '일자를 바르게 입력하세요', StopSign!)
			dw_pisq180u_01.SetColumn('originationdate')		
			dw_pisq180u_01.SetFocus()
			RETURN 1
		END IF			
		
		Parent.TriggerEvent('ue_retrieve')
	// 대분류가 변경시
	//
	CASE 'largegroupcode'
		dw_pisq180u_02.reset()
		dw_pisq180u_03.reset()
		// 변경된 대분류 코드를 구한다
		//
		ls_largegroupcode = ls_coldata
		
		// Child Retrieve(중분류)
		//
		ll_rowcnt = idwc_middlegroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode)
		if ll_rowcnt < 1 then
			This.setitem(1,'middlegroupcode', '')
			This.setitem( 1, 'smallgroupcode', '')
			return 0
		end if
		// Child Window에서 중분류 코드를 구한다
		//
		ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')
		
		// Child Retrieve(소분류)
		//
		ll_rowcnt = idwc_smallgroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		if ll_rowcnt < 1 then
			This.setitem( 1, 'smallgroupcode', '')
			return 0
		end if
		// Child Window에서 소분류 코드를 구한다
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')

		dw_pisq180u_01.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
		dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
		// 공정을 조회한다
		//
		dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_coldata)
		// 소분류 변경에 따른 공정 및 공정불량 디테일 자료를 표시하기 위하여 처리를 넘긴다
		//
		Parent.TriggerEvent('ue_retrieve')

	// 중분류가 변경시
	//
	CASE 'middlegroupcode'
		dw_pisq180u_02.reset()
		dw_pisq180u_03.reset()
		// 대/중분류 코드를 구한다
		//
		ls_largegroupcode  = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
		ls_middlegroupcode = ls_coldata
	
		// Child Retrieve(소분류)
		//
		ll_rowcnt = idwc_smallgroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		if ll_rowcnt < 1 then
			This.setitem( 1, 'smallgroupcode', '')
			return 0
		end if
		// Child Window에서 소분류 코드를 구한다
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')
		dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
		// 공정을 조회한다
		//
		dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_coldata)
		// 소분류 변경에 따른 공정 및 공정불량 디테일 자료를 표시하기 위하여 처리를 넘긴다
		//
		Parent.TriggerEvent('ue_retrieve')

	// 소분류가 변경시
	//
	CASE 'smallgroupcode'
		dw_pisq180u_02.reset()
		dw_pisq180u_03.reset()
		ls_largegroupcode  = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
		ls_middlegroupcode = dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
		// 공정을 조회한다
		//
		dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_coldata)
		// 소분류 변경에 따른 공정 및 공정불량 디테일 자료를 표시하기 위하여 처리를 넘긴다
		//
		Parent.TriggerEvent('ue_retrieve')
END CHOOSE

return 0

end event

type dw_pisq180u_02 from u_vi_std_datawindow within w_pisq180u
integer x = 46
integer y = 416
integer width = 1408
integer height = 2124
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pisq180u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_date, ls_processcode

// 조회에 필요한 기본자료를 구한다
//
if dw_pisq180u_01.rowcount() < 1 then
	return 0
end if
ls_date 				= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
if dw_pisq180u_02.GetSelectedRow(0) < 1 then
	return 0
end if
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// 공정불량 디테일 자료를 조회한다
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)
dw_pisq180u_03.SetColumn('badreasoncode')
dw_pisq180u_03.SetFocus()

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

dw_pisq180u_02.SetFocus()

end event

event clicked;call super::clicked;
TriggerEvent(RowFocusChanged!)
end event

type dw_pisq180u_03 from u_vi_std_datawindow within w_pisq180u
integer x = 1467
integer y = 416
integer width = 2747
integer height = 1936
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq180u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
String	ls_originationdate, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_processcode, ls_badreasoncode, ls_badtypecode

// 선택된 자료를 구한다
//
ls_originationdate= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'originationdate')
ls_largegroupcode	= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'smallgroupcode')
ls_processcode		= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'processcode')
ls_badreasoncode	= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'badreasoncode')
ls_badtypecode		= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'badtypecode')

dw_pisq180u_04.Retrieve(is_areacode, is_divisioncode, ls_originationdate, ls_largegroupcode, &
			ls_middlegroupcode, ls_smallgroupcode, ls_processcode, ls_badreasoncode, ls_badtypecode)

end event

type gb_2 from groupbox within w_pisq180u
integer x = 18
integer y = 188
integer width = 4224
integer height = 2384
integer taborder = 40
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisq180u
integer x = 18
integer y = 12
integer width = 4224
integer height = 168
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisq180u
integer x = 1838
integer y = 1252
integer width = 549
integer height = 1300
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

type dw_pisq180u_04 from u_vi_std_datawindow within w_pisq180u
integer x = 1467
integer y = 2364
integer width = 2747
integer height = 176
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq180u_04"
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;
String	ls_colname, ls_coldata, ls_largegroupcode, ls_badtypecode

IF dw_pisq180u_03.AcceptText() <> 1 THEN RETURN

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 대분류가 변경시
	//
	CASE 'badreasoncode'
		ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
		
		// 불량유형 차일드윈도우를  조회한다
		//
		idwc_badtype.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_coldata)

		ls_badtypecode = idwc_badtype.GetItemString(row, 'badtypecode')

		dw_pisq180u_04.SetItem(row, 'badtypecode', ls_badtypecode)
END CHOOSE

end event

event clicked;//
end event

event rowfocuschanged;//
end event

type cb_allins from commandbutton within w_pisq180u
integer x = 2629
integer y = 44
integer width = 722
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "발생일생산수량등록"
end type

event clicked;
String	ls_date

ls_date = dw_pisq180u_01.GetitemString(1, 'originationdate')

IF Len(Trim((ls_date))) <> 10 THEN
	MessageBox('확 인', '일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF f_checknullorspace(ls_date) = TRUE THEN
	MessageBox('확 인', '일자를 입력하세요')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF IsDate(ls_date) = FALSE THEN
	MessageBox('확 인', '일자를 바르게 입력하세요')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			


SQLPIS.AUTOCommit = FALSE

// 생산수량 일괄등록 프로시져를 선언한다
//
DECLARE declare_sp_pisq180u_01 PROCEDURE for sp_pisq180u_01
	@ps_AreaCode        = :is_areacode   	,
	@ps_DivisionCode    = :is_divisioncode ,
   @ps_Date    		  = :ls_date
USING SQLPIS;

// 생산수량 일괄등록 프로시져를 실행한다
//
EXECUTE declare_sp_pisq180u_01 ;

SQLPIS.AUTOCommit = TRUE

MessageBox('확 인', '발생일 생산수량 등록이 완료 되었습니다')



//String	ls_date
//
//// 일괄등록 일자를 구한다
////
//ls_date = dw_pisq180u_01.GetitemString(1, 'originationdate')
//
//// AUTO COMMIT을 FASLE로 지정
////
//SQLPIS.AUTOCommit = FALSE
//
//// 기등록된 자료를 삭제한다
////
//DELETE FROM TQPROGRESSBADMASTER  
//		WHERE AREACODE				= :is_areacode
//		  AND DIVISIONCODE		= :is_divisioncode
//		  AND ORIGINATIONDATE	= :ls_date 
//USING SQLPIS;
//
//// QC소분류별 품번열결된 테이블에 등록된 품번을 가지고 작업일보의 생산수량을 가져오고
//// 최종공정의 생산원가도 함께구하여 공정불량마스타에 입력한다
////
//INSERT INTO TQPROGRESSBADMASTER  
//         ( AREACODE,   
//           DIVISIONCODE,   
//           ORIGINATIONDATE,   
//           LARGEGROUPCODE,   
//           MIDDLEGROUPCODE,   
//           SMALLGROUPCODE,   
//           PRODUCTQTY,   
//           PROCESSCOST )  
//			( SELECT AS_AREACODE,   
//						AS_DIVISIONCODE,   
//						AS_DATE,
//						AS_LARGEGROUPCODE,   
//						AS_MIDDLEGROUPCODE,   
//						AS_SMALLGROUPCODE,   
//						SUM(AS_QTY),
//						SUM(AS_AMT)
//				FROM (  SELECT A.AREACODE									AS AS_AREACODE,   
//									A.DIVISIONCODE								AS AS_DIVISIONCODE,   
//									:ls_date 									AS AS_DATE,
//									A.LARGEGROUPCODE							AS AS_LARGEGROUPCODE,   
//									A.MIDDLEGROUPCODE							AS AS_MIDDLEGROUPCODE,   
//									A.SMALLGROUPCODE							AS AS_SMALLGROUPCODE,   
//									SUM(B.DAYPQTY) + SUM(B.NIGHTPQTY)	AS AS_QTY,
//									0												AS AS_AMT
//							 FROM TQSMALLGROUPTOITEM	A,
//									TMHREALPROD				B
//							WHERE A.AREACODE		= B.AREACODE
//							  AND A.DIVISIONCODE	= B.DIVISIONCODE
//							  AND A.WORKCENTER	= B.WORKCENTER
//							  AND A.ITEMCODE		= B.ITEMCODE
//							  AND A.SUBLINECODE	= B.SUBLINECODE
//							  AND A.SUBLINENO		= B.SUBLINENO
//							  AND A.AREACODE		= :is_areacode
//							  AND A.DIVISIONCODE	= :is_divisioncode
//							  AND B.WORKDAY		= :ls_date
//						GROUP BY A.AREACODE			,
//									A.DIVISIONCODE		,
//									A.LARGEGROUPCODE	,
//									A.MIDDLEGROUPCODE	,
//									A.SMALLGROUPCODE
//							UNION ALL
//					
//						  SELECT A.AREACODE   								AS AS_AREACODE,       
//									A.DIVISIONCODE                      AS AS_DIVISIONCODE,   
//									:ls_date										AS AS_DATE,           
//									A.LARGEGROUPCODE                    AS AS_LARGEGROUPCODE, 
//									A.MIDDLEGROUPCODE                   AS AS_MIDDLEGROUPCODE,
//									A.SMALLGROUPCODE                    AS AS_SMALLGROUPCODE, 
//									0					                     AS AS_QTY,            
//									B.PROCESSCOST                       AS AS_AMT             
//							 FROM TQSMALLGROUPTOITEM		A,   
//									TQSMALLGROUPTOPROCESS	B 
//							WHERE A.AREACODE			= B.AREACODE
//							  AND A.DIVISIONCODE		= B.DIVISIONCODE
//							  AND A.LARGEGROUPCODE	= B.LARGEGROUPCODE
//							  AND A.MIDDLEGROUPCODE	= B.MIDDLEGROUPCODE
//							  AND A.SMALLGROUPCODE	= B.SMALLGROUPCODE
//							  AND A.AREACODE		= :is_areacode
//							  AND A.DIVISIONCODE	= :is_divisioncode
//							  AND B.FINALPROCESSFLAG= '1'
//						GROUP BY A.AREACODE,   
//									A.DIVISIONCODE,   
//									A.LARGEGROUPCODE,   
//									A.MIDDLEGROUPCODE,   
//									A.SMALLGROUPCODE,
//									B.PROCESSCOST
//					  ) TMP
//			 GROUP BY AS_AREACODE,   
//						 AS_DATE,
//						 AS_DIVISIONCODE,   
//						 AS_LARGEGROUPCODE,   
//						 AS_MIDDLEGROUPCODE,   
//						 AS_SMALLGROUPCODE
//			)
//USING SQLPIS;
//
//IF SQLPIS.SQLCode <> 0 THEN
//	MessageBox('확 인', '생산수량 일괄등록에 실패했습니다')
//END IF
//
//SQLPIS.AUTOCommit = TRUE
//
end event

type cb_regtotal from commandbutton within w_pisq180u
integer x = 3433
integer y = 44
integer width = 722
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생산수량일괄등록"
end type

event clicked;String	ls_datefrom, ls_dateto

ls_dateto = dw_pisq180u_01.GetitemString(1, 'originationdate')

IF Len(Trim((ls_dateto))) <> 10 THEN
	MessageBox('확 인', '발생일 일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF f_checknullorspace(ls_dateto) = TRUE THEN
	MessageBox('확 인', '발생일 일자를 입력하세요')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF IsDate(ls_dateto) = FALSE THEN
	MessageBox('확 인', '발생일 일자를 바르게 입력하세요')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

ls_datefrom = mid(ls_dateto,1,8) + '01'

if messagebox('확인', ls_datefrom + '일부터 ' + ls_dateto + ' 일까지 생산수량 ' &
		+ '일괄등록을 실행하시겠습니까?',Question!,YesNo!,2) = 2 then
	return 0
end if

SQLPIS.AUTOCommit = FALSE

// 생산수량 일괄등록 프로시져를 선언한다
//
 DECLARE procedure_sp_pisq180u_02 PROCEDURE FOR sp_pisq180u_02  
         @ps_AreaCode = :is_areacode,   
         @ps_DivisionCode = :is_divisioncode,   
         @ps_DateFrom = :ls_datefrom,   
         @ps_DateTo = :ls_dateto  
			USING SQLPIS;

//// 생산수량 일괄등록 프로시져를 실행한다
EXECUTE procedure_sp_pisq180u_02 ;

SQLPIS.AUTOCommit = TRUE

MessageBox('확 인', '생산수량 일괄등록이 완료 되었습니다')
end event

