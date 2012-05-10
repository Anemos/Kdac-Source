$PBExportHeader$w_pisq280u.srw
$PBExportComments$Containment 검사등록
forward
global type w_pisq280u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq280u
end type
type uo_division from u_pisc_select_division within w_pisq280u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq280u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq280u
end type
type dw_pisq280u_01 from u_vi_std_datawindow within w_pisq280u
end type
type dw_pisq280u_02 from u_vi_std_datawindow within w_pisq280u
end type
type dw_pisq280u_03 from u_vi_std_datawindow within w_pisq280u
end type
type gb_1 from groupbox within w_pisq280u
end type
type gb_2 from groupbox within w_pisq280u
end type
end forward

global type w_pisq280u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment 검사등록"
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_pisq280u_01 dw_pisq280u_01
dw_pisq280u_02 dw_pisq280u_02
dw_pisq280u_03 dw_pisq280u_03
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq280u w_pisq280u

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open

end variables

forward prototypes
public function boolean wf_checkcolumn ()
end prototypes

public function boolean wf_checkcolumn ();
Long		ll_row
Boolean	lb_rtn = TRUE

IF dw_pisq280u_01.AcceptText() <> 1 THEN RETURN FALSE

// 검사수량 체크
//
FOR ll_row = 1 TO dw_pisq280u_01.RowCount()
	// 검사여부가 검사인경우 검사수량이 입력되어야 한다
	//
	IF dw_pisq280u_01.GetItemString(ll_row, 'qcflag') = '0' THEN
		IF dw_pisq280u_01.GetItemNumber(ll_row, 'qcqty') = 0 OR &
			IsNull(dw_pisq280u_01.GetItemNumber(ll_row, 'qcqty')) = TRUE THEN
			MessageBox('확 인', '검사수량을 입력하세요', StopSign!)
			dw_pisq280u_01.ScrollToRow(ll_row)
			f_SetHighlight(dw_pisq280u_01, ll_row, True)	
			dw_pisq280u_01.SetColumn('qcqty')
			dw_pisq280u_01.SetFocus()
			RETURN FALSE
		END IF
	END IF
NEXT

RETURN lb_rtn

end function

on w_pisq280u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_pisq280u_01=create dw_pisq280u_01
this.dw_pisq280u_02=create dw_pisq280u_02
this.dw_pisq280u_03=create dw_pisq280u_03
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_productgroup
this.Control[iCurrent+4]=this.uo_modelgroup
this.Control[iCurrent+5]=this.dw_pisq280u_01
this.Control[iCurrent+6]=this.dw_pisq280u_02
this.Control[iCurrent+7]=this.dw_pisq280u_03
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_pisq280u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_pisq280u_01)
destroy(this.dw_pisq280u_02)
destroy(this.dw_pisq280u_03)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq020i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;call super::ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_prdenddate, ls_kbno, ls_badreason

// 조회조건을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 

IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

// 데이타를 조회한다(검사내역)
//
dw_pisq280u_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq280u_01, 1, True)	

// 데이타를 조회한다(불량내역)
//
if dw_pisq280u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq280u_02, 1, True)	

// 차일드 윈도우 표시(불량원인, 불량유형)
//
if idwc_badreason.Retrieve(ls_areacode, ls_DivisionCode) < 1 then
	return 0
end if
ls_badreason = idwc_badreason.GetItemString(1, 'containbadreasoncode')
idwc_badtype.Retrieve(ls_areacode, ls_DivisionCode, ls_badreason)

dw_pisq280u_03.ReSet()

end event

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

dw_pisq280u_03.GetChild ('badreasoncode' 	, idwc_badreason)
dw_pisq280u_03.GetChild ('badtypecode' 	, idwc_badtype)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)

f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										'%', &
										True, &
										uo_modelgroup.is_uo_modelgroup, &
										uo_modelgroup.is_uo_modelgroupname)
ib_open = True
end event

event ue_insert;call super::ue_insert;
String	ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno
String	ls_itemcode, ls_itemname

// 조회한자료가 없으면 리턴
//
IF dw_pisq280u_01.RowCount() < 1 THEN RETURN

// 최종 입력행을 구한다
//
dw_pisq280u_03.ReSet()
dw_pisq280u_03.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
ls_areacode  		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'areacode')
ls_DivisionCode	= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'DivisionCode')
ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')
ls_itemcode			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'itemcode')
ls_itemname			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'tmstitem_itemname')

dw_pisq280u_03.SetItem(1, 'areacode'		, ls_areacode)
dw_pisq280u_03.SetItem(1, 'divisioncode'	, ls_divisioncode)
dw_pisq280u_03.SetItem(1, 'prdenddate'		, ls_prdenddate)
dw_pisq280u_03.SetItem(1, 'kbno'				, ls_kbno)
dw_pisq280u_03.SetItem(1, 'as_itemcode'	, ls_itemcode)
dw_pisq280u_03.SetItem(1, 'as_itemname'	, ls_itemname)

// 포커스를 이동한다
//
dw_pisq280u_03.SetColumn('badreasoncode')
dw_pisq280u_03.SetFocus()


end event

event ue_delete;call super::ue_delete;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno
Int		li_save

IF dw_pisq280u_03.RowCount() = 0 THEN
	MessageBox('확 인', '삭제할 대상이 없습니다')
	RETURN
END IF


// 조회에 필요한 기본자료를 구한다
//
ls_areacode			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'areacode')
ls_divisioncode	= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'divisioncode')
ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')

// 선택된 행을 삭제한다
//
dw_pisq280u_03.DeleteRow(1)

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// 불량내역을 저장한다
//
li_save = dw_pisq280u_03.Update()
IF li_save = 1 THEN
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

// 불량내역 자료를 조회한다
//
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq280u_02, 1, True)	

dw_pisq280u_03.ReSet()

end event

event ue_save;call super::ue_save;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno, ls_productgroup, ls_modelgroup
Int	li_save, li_saverow

// 필수입력 항목을 체크한다
//
IF wf_checkcolumn() = FALSE THEN RETURN

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// 검사내역을 저장한다
//
li_save = dw_pisq280u_01.Update()
IF li_save <> 1 THEN
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// 불량내역을 저장한다
//
li_save = dw_pisq280u_03.Update()
IF li_save = 1 THEN
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

// 조회에 필요한 기본자료를 구한다
//
ls_areacode			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'areacode')
ls_divisioncode	= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'divisioncode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 
IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

// 조회전 반전행을 보관한다
//
li_saverow = dw_pisq280u_01.GetSelectedRow(0)

// 데이타를 조회한다(검사내역)
//
dw_pisq280u_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

IF li_saverow > dw_pisq280u_01.RowCount() THEN
	li_saverow = dw_pisq280u_01.RowCount() 
END IF

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq280u_01, li_saverow, True)	

ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')

// 데이타를 조회한다(불량내역)
//
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq280u_02, 1, True)	

dw_pisq280u_03.ReSet()
//cb_Ins.TriggerEvent(clicked!)


end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq280u
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq280u
integer x = 59
integer y = 60
integer taborder = 20
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
											True, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

// 트랜잭션을 연결한다
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq280u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_productgroup
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드
//						string			fs_productgroup		조회하고자 하는 제품군 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 제품군 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (제품군코드는 '%', 제품군명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_productgroup		선택된 제품군 코드 (reference)
//						string			rs_productgroupname	선택된 제품군 명 (reference)
//	Returns		: none
//	Description	: 제품군을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

If ib_open Then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
											
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)

End If

// 트랜잭션을 연결한다
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )


end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq280u
integer x = 1198
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_modelgroup
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드
//						string			fs_modelgroup		   조회하고자 하는 제품군 코드
//						string			fs_modelgroup			조회하고자 하는 모델군 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 모델군 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (모델군코드는 '%', 모델군명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_mdoelgroup			선택된 모델군 코드 (reference)
//						string			rs_modelgroupname		선택된 모델군 명 (reference)
//	Returns		: none
//	Description	: 모델군을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////


If ib_open Then
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq280u
integer x = 2130
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
//	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_pisq280u_01 from u_vi_std_datawindow within w_pisq280u
integer x = 41
integer y = 216
integer width = 3753
integer height = 1324
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq280u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
//This.Trigger Event RowFocusChanged(999)
This.TriggerEvent(RowFocusChanged!)

end event

event rowfocuschanged;call super::rowfocuschanged;
String	ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno

// 조회조건을 구한다
//
if dw_pisq280u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_prdenddate 		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno		  		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)
// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq280u_02, 1, True)	







end event

event itemchanged;call super::itemchanged;
String	ls_colname, ls_coldata

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 대분류가 변경시
	//
	CASE 'qcflag'
		// 생산수량을 검사수량에 셋트한다(검사자, 검사일자도 셋트한다)
		//
		IF ls_coldata = '0' THEN
			This.SetItem(row, 'qcqty'	, This.GetItemNumber(row, 'rackqty'))
			This.SetItem(row, 'qcempno', g_s_empno)
			This.SetItem(row, 'qcdate'	, String(f_getsysdatetime(), 'yyyy.mm.dd'))
		ELSE
			This.SetItem(row, 'qcqty'	, 0)
			This.SetItem(row, 'qcempno', '')
			This.SetItem(row, 'qcdate'	, '')
		END IF
END CHOOSE



end event

type dw_pisq280u_02 from u_vi_std_datawindow within w_pisq280u
integer x = 41
integer y = 1552
integer width = 3753
integer height = 812
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq280u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;
String	ls_itemcode, ls_itemname
Long		ll_idx 

dw_pisq280u_02.SetRedraw(FALSE)

ls_itemcode = dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'itemcode')
ls_itemname = dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'tmstitem_itemname')

// 검사내역에 선택된 품번, 품명을 불량내역 입력화면에 셋트한다
//
FOR ll_idx = 1 to rowcount
	dw_pisq280u_02.SetItem(ll_idx, 'as_itemcode', ls_itemcode)
	dw_pisq280u_02.SetItem(ll_idx, 'as_itemname', ls_itemname)
NEXT

dw_pisq280u_02.SetRedraw(TRUE)

end event

event doubleclicked;
String	ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno, ls_badreasoncode, ls_badtypecode
String	ls_itemcode, ls_itemname

// 조회조건을 구한다
//
ls_areacode  		= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'areacode')
ls_DivisionCode	= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'DivisionCode')
ls_prdenddate		= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'kbno')
ls_badreasoncode	= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'badreasoncode')
ls_badtypecode		= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'badtypecode')
ls_itemcode			= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'as_itemcode')
ls_itemname			= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'as_itemname')

dw_pisq280u_03.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno, ls_badreasoncode, ls_badtypecode)

idwc_badreason.Retrieve(ls_areacode, ls_DivisionCode)
idwc_badtype.Retrieve(ls_areacode, ls_DivisionCode, ls_badreasoncode)

dw_pisq280u_03.SetItem(1, 'as_itemcode', ls_itemcode)
dw_pisq280u_03.SetItem(1, 'as_itemname', ls_itemname)

end event

type dw_pisq280u_03 from u_vi_std_datawindow within w_pisq280u
integer x = 41
integer y = 2380
integer width = 3753
integer height = 172
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq280u_03"
boolean livescroll = false
end type

event rowfocuschanged;//
end event

event clicked;//
end event

event itemchanged;
String	ls_colname, ls_coldata, ls_areacode, ls_divisioncode, ls_badtypecode

IF dw_pisq280u_03.AcceptText() <> 1 THEN RETURN

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 불량원인이 변경시
	//
	CASE 'badreasoncode'
		ls_areacode			= dw_pisq280u_03.GetItemString(1, 'areacode')
		ls_divisioncode	= dw_pisq280u_03.GetItemString(1, 'divisioncode')
		
		// 불량유형 차일드윈도우를  조회한다
		//
		idwc_badtype.Retrieve(ls_AreaCode, ls_DivisionCode, ls_coldata)
		
		ls_badtypecode = idwc_badtype.GetItemString(row, 'badtypecode')

		dw_pisq280u_03.SetItem(row, 'badtypecode', ls_badtypecode)
		
END CHOOSE

end event

type gb_1 from groupbox within w_pisq280u
integer x = 18
integer y = 192
integer width = 3808
integer height = 2384
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

type gb_2 from groupbox within w_pisq280u
integer x = 18
integer y = 12
integer width = 3808
integer height = 168
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

