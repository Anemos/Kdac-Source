$PBExportHeader$w_pisq270u.srw
$PBExportComments$Containment 유검사품 등록
forward
global type w_pisq270u from w_ipis_sheet01
end type
type dw_pisq270u_left from u_vi_std_datawindow within w_pisq270u
end type
type dw_pisq270u_right from u_vi_std_datawindow within w_pisq270u
end type
type pb_1 from picturebutton within w_pisq270u
end type
type pb_2 from picturebutton within w_pisq270u
end type
type uo_area from u_pisc_select_area within w_pisq270u
end type
type uo_division from u_pisc_select_division within w_pisq270u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq270u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq270u
end type
type st_2 from statictext within w_pisq270u
end type
type st_3 from statictext within w_pisq270u
end type
type gb_1 from groupbox within w_pisq270u
end type
type gb_2 from groupbox within w_pisq270u
end type
end forward

global type w_pisq270u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment 유검사품 등록"
dw_pisq270u_left dw_pisq270u_left
dw_pisq270u_right dw_pisq270u_right
pb_1 pb_1
pb_2 pb_2
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
st_2 st_2
st_3 st_3
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq270u w_pisq270u

type variables

Boolean	ib_open

end variables

on w_pisq270u.create
int iCurrent
call super::create
this.dw_pisq270u_left=create dw_pisq270u_left
this.dw_pisq270u_right=create dw_pisq270u_right
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.st_2=create st_2
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq270u_left
this.Control[iCurrent+2]=this.dw_pisq270u_right
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.uo_productgroup
this.Control[iCurrent+8]=this.uo_modelgroup
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_pisq270u.destroy
call super::destroy
destroy(this.dw_pisq270u_left)
destroy(this.dw_pisq270u_right)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.st_2)
destroy(this.st_3)
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

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup

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

// 데이타를 조회한다(좌측화면)
//
dw_pisq270u_left.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// 데이타를 조회한다(우측화면)
//
dw_pisq270u_right.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq270u_left, 1, True)	
f_SetHighlight(dw_pisq270u_right, 1, True)	


end event

event ue_postopen;// 트랜잭션을 연결한다
//
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)

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

event ue_save;Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq270u_right.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF

// 데이타를 조회한다
//
This.TriggerEvent('ue_retrieve')

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq270u
integer x = 18
integer y = 2592
integer width = 3598
end type

type dw_pisq270u_left from u_vi_std_datawindow within w_pisq270u
integer x = 46
integer y = 300
integer width = 1545
integer height = 2248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq270u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_pisq270u_right from u_vi_std_datawindow within w_pisq270u
integer x = 1929
integer y = 300
integer width = 2290
integer height = 2248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq270u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;

String	ls_colname, ls_coldata

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 적용일자
	//
	CASE "applydatefrom"
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '적용일자를 정확히 입력하시요')
			RETURN 1
		END IF

	// 종료일자
	//
	CASE "applydateto"
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '종료일자를 정확히 입력하시요')
			RETURN 1
		END IF
END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

type pb_1 from picturebutton within w_pisq270u
integer x = 1609
integer y = 672
integer width = 302
integer height = 188
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\userright.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row
long	ll_SaveRow[] 

// 선택된 행이 있는지 체크한다
//
ll_row = dw_pisq270u_left.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq270u_left.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	//
	ll_LastRow = dw_pisq270u_right.InsertRow(0)
	dw_pisq270u_right.SetItem(ll_LastRow, 'AREACODE'			, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'DIVISIONCODE'		, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'PRODUCTGROUP'		, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_PRODUCTGROUP'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'MODELGROUP'			, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_MODELGROUP'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'ITEMCODE'			, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMCODE'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'TMSTITEM_ITEMNAME', dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMNAME'))
	// 적용일자, 종료일자에 초기값을 셋트한다(시스템일자, 맥스일자)
	dw_pisq270u_right.SetItem(ll_LastRow, 'APPLYDATEFROM'		, String(f_getsysdatetime(), 'yyyy.mm.dd'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'APPLYDATETO'		, '2999.12.31')

	// 좌측화면의 선택된행에 삭제표시를 셋트한다
	//
	dw_pisq270u_left.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq270u_left.GetSelectedRow(0)

// 이동이 끝난 좌측화면의 선택행은 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisq270u_left.RowCount() to 1 step -1
	IF dw_pisq270u_left.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq270u_left.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq270u_left.RowCount() THEN
	f_SetHighlight(dw_pisq270u_left, dw_pisq270u_left.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq270u_left, ll_select_row, True)	
END IF

f_sethighlight(dw_pisq270u_right,dw_pisq270u_right.RowCount(),TRUE)

end event

type pb_2 from picturebutton within w_pisq270u
integer x = 1609
integer y = 1064
integer width = 302
integer height = 188
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\userleft.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row
long	ll_SaveRow[] 

// 선택된 행이 있는지 체크한다
//
ll_row = dw_pisq270u_right.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq270u_right.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 우측측화면의 선택된행에 삭제표시를 셋트한다
//
FOR ll_row = 1 TO ll_index - 1
	dw_pisq270u_right.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq270u_right.GetSelectedRow(0)

// 선택행을 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisq270u_right.RowCount() to 1 step -1
	IF dw_pisq270u_right.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq270u_right.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq270u_right.RowCount() THEN
	f_SetHighlight(dw_pisq270u_right, dw_pisq270u_right.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq270u_right, ll_select_row, True)	
END IF

Parent.TriggerEvent('ue_save')
end event

type uo_area from u_pisc_select_area within w_pisq270u
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
											FALSE, &
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
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)

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

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq270u
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
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)



end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq270u
integer x = 1198
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")


PostEvent("ue_select")


end event

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

event ue_post_constructor;//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		:	f_pisc_retrieve_dddw_modelgroup
////	Access		:	public
////	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
////						string			fs_areacode				조회하고자 하는 지역
////						string			fs_divisioncode		조회하고자 하는 공장 코드
////						string			fs_modelgroup		   조회하고자 하는 제품군 코드
////						string			fs_modelgroup			조회하고자 하는 모델군 코드 (일반적으로 '%' 을 사용하도록)
////						boolean			fb_allflag				조회된 모델군 정보가 2개 이상의 Record 일 경우
////																		True : '전체' 항목 삽입 (모델군코드는 '%', 모델군명은 '전체')
////																		False : '전체' 항목 미 삽입
////						string			rs_mdoelgroup			선택된 모델군 코드 (reference)
////						string			rs_modelgroupname		선택된 모델군 명 (reference)
////	Returns		: none
////	Description	: 모델군을 선택하기 위한 DDDW 을 조회하기 위하여
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Kim Jin-Su
//// Coded Date	: 2002.09.04
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//string ls_areacode, ls_productgroup, ls_DivisionCode, ls_modelgroupcode, ls_modelgroupname
//datawindow 	ldw_modelgroup
//
//ldw_modelgroup 	= uo_modelgroup.dw_1
//ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
//ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode')
//
//f_pisc_retrieve_dddw_modelgroup(ldw_modelgroup,ls_areacode,ls_DivisionCode,ls_productgroup,'%',true,ls_modelgroupcode,ls_modelgroupname)
//
//

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq270u
integer x = 2130
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

type st_2 from statictext within w_pisq270u
integer x = 69
integer y = 228
integer width = 457
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
string text = "< 무검사품 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq270u
integer x = 1952
integer y = 228
integer width = 457
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
string text = "< 유검사품 >"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisq270u
integer x = 18
integer y = 12
integer width = 4233
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

type gb_2 from groupbox within w_pisq270u
integer x = 18
integer y = 192
integer width = 4233
integer height = 2384
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

