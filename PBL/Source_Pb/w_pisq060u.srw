$PBExportHeader$w_pisq060u.srw
$PBExportComments$(new)검사성적서 비대상
forward
global type w_pisq060u from w_ipis_sheet01
end type
type dw_pisq060u_left from u_vi_std_datawindow within w_pisq060u
end type
type dw_pisq060u_right from u_vi_std_datawindow within w_pisq060u
end type
type pb_move from picturebutton within w_pisq060u
end type
type pb_del from picturebutton within w_pisq060u
end type
type uo_area from u_pisc_select_area within w_pisq060u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq060u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq060u
end type
type uo_division from u_pisc_select_division within w_pisq060u
end type
type st_2 from statictext within w_pisq060u
end type
type st_3 from statictext within w_pisq060u
end type
type st_rightcnt from statictext within w_pisq060u
end type
type dw_print from datawindow within w_pisq060u
end type
type dw_print1 from datawindow within w_pisq060u
end type
type gb_1 from groupbox within w_pisq060u
end type
type gb_2 from groupbox within w_pisq060u
end type
type st_leftcnt from statictext within w_pisq060u
end type
end forward

global type w_pisq060u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "수입검사 무검사품 등록"
dw_pisq060u_left dw_pisq060u_left
dw_pisq060u_right dw_pisq060u_right
pb_move pb_move
pb_del pb_del
uo_area uo_area
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
uo_division uo_division
st_2 st_2
st_3 st_3
st_rightcnt st_rightcnt
dw_print dw_print
dw_print1 dw_print1
gb_1 gb_1
gb_2 gb_2
st_leftcnt st_leftcnt
end type
global w_pisq060u w_pisq060u

type variables

Boolean	ib_open

end variables

on w_pisq060u.create
int iCurrent
call super::create
this.dw_pisq060u_left=create dw_pisq060u_left
this.dw_pisq060u_right=create dw_pisq060u_right
this.pb_move=create pb_move
this.pb_del=create pb_del
this.uo_area=create uo_area
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.uo_division=create uo_division
this.st_2=create st_2
this.st_3=create st_3
this.st_rightcnt=create st_rightcnt
this.dw_print=create dw_print
this.dw_print1=create dw_print1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_leftcnt=create st_leftcnt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq060u_left
this.Control[iCurrent+2]=this.dw_pisq060u_right
this.Control[iCurrent+3]=this.pb_move
this.Control[iCurrent+4]=this.pb_del
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_productgroup
this.Control[iCurrent+7]=this.uo_modelgroup
this.Control[iCurrent+8]=this.uo_division
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_rightcnt
this.Control[iCurrent+12]=this.dw_print
this.Control[iCurrent+13]=this.dw_print1
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.st_leftcnt
end on

on w_pisq060u.destroy
call super::destroy
destroy(this.dw_pisq060u_left)
destroy(this.dw_pisq060u_right)
destroy(this.pb_move)
destroy(this.pb_del)
destroy(this.uo_area)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_rightcnt)
destroy(this.dw_print)
destroy(this.dw_print1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_leftcnt)
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
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_currentdate

// 조회조건을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 

ls_currentdate = string(f_getsysdatetime(),'YYYY.MM.DD')

IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

dw_pisq060u_left.ReSet()
dw_pisq060u_right.ReSet()

// 데이타를 조회한다(좌측화면)
//
dw_pisq060u_left.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// 데이타를 조회한다(우측화면)
//
dw_pisq060u_right.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_currentdate)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq060u_left, 1, True)	
f_SetHighlight(dw_pisq060u_right, 1, True)	


end event

event ue_postopen;
// 권한이 조회만 가능한 사람은 버튼처리 불가
//
pb_move.Enabled	= m_frame.m_action.m_save.Enabled
pb_del.Enabled		= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
//
dw_pisq060u_left.SetTransObject(SQLPIS)
dw_pisq060u_right.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

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

event ue_save;Long		ll_save, ll_row
String	ls_applydatefrom, ls_applydateto
dwItemStatus l_status

// 관리품목의 전체를 체크한다
//
FOR ll_row = 1 TO dw_pisq060u_right.RowCount()
	ls_applydatefrom	= dw_pisq060u_right.GetItemString(ll_row, 'APPLYDATEFROM')
	ls_applydateto		= dw_pisq060u_right.GetItemString(ll_row, 'APPLYDATETO')
	l_status 			= dw_pisq060u_right.GetItemStatus(ll_row, 'APPLYDATEFROM', primary!)

	// 수정된 칼럼의 상태를 체크한다(신규나 수정된 일자만을 체크한다)
	//	New!              Rows
	//	NewModified!      Rows
	//	NotModified!      Rows and columns
	//	DataModified!     Rows and columns
	//
	IF l_status <> NotModified! THEN
		IF Date(ls_applydatefrom) < Date(f_getsysdatetime()) THEN
			MessageBox('확 인', '적용일자는 작업일보다 커야합니다')
			dw_pisq060u_right.SetColumn('APPLYDATEFROM')
			dw_pisq060u_right.SetFocus()
			f_SetHighlight(dw_pisq060u_right, ll_row, True)	
			RETURN 0
		END IF
	END IF
	
	IF f_checknullorspace(ls_applydateto) = TRUE THEN
		dw_pisq060u_right.SetItem(ll_row, 'APPLYDATETO'		, '2999.12.31')
	END IF
NEXT

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

ll_save = dw_pisq060u_right.Update()

IF ll_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "저장되었습니다."
ELSE 
	// RollBack 처리
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "처리에 실패했습니다."
END IF

// 데이타를 조회한다
//
//This.TriggerEvent('ue_retrieve')

end event

event activate;call super::activate;
dw_pisq060u_left.SetTransObject(SQLPIS)
dw_pisq060u_right.SetTransObject(SQLPIS)

end event

event ue_print;call super::ue_print;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint
long		ll_rtn

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq060u_right.RowCount() = 0 THEN
	MessageBox('확 인', '출력대상이 없습니다', StopSign!)
	RETURN
END IF

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ll_rtn = MessageBox('확 인', '출력대상을 선택해 주세요.~r~n 예(Y)면 무검사성적서 관리품목 출력, 아니오(N)는 유검사품 출력입니다', &
							Exclamation!, YesNo!, 1)

IF ll_rtn = 1 THEN
	dw_pisq060u_right.ShareData(dw_print)
	lstr_prt.datawindow	= 	dw_print
ELSE
	dw_pisq060u_left.ShareData(dw_print1)
	lstr_prt.datawindow	= 	dw_print1
END IF

ls_trans	= SQLPIS

// 인쇄 DataWindow 저장
//
lstr_prt.transaction	=	ls_trans
//lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"비간판 관리품목 현황 출력"
lstr_prt.tag			= 	This.ClassName()
//lstr_prt.dwsyntax = "t_3.text   	= '" + ls_DeliveryNo + "'"

f_close_report("2", lstr_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq060u
integer x = 18
integer y = 2592
integer width = 3598
end type

type dw_pisq060u_left from u_vi_std_datawindow within w_pisq060u
integer x = 41
integer y = 296
integer width = 1545
integer height = 2256
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq060u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;
st_leftcnt.Text = String(rowcount, '#,###')
end event

type dw_pisq060u_right from u_vi_std_datawindow within w_pisq060u
integer x = 1883
integer y = 296
integer width = 2720
integer height = 2256
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq060u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;

String	ls_colname, ls_coldata, ls_fromdt

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

dw_pisq060u_right.SetItem(row, 'LASTEMP'		, g_s_empno)
dw_pisq060u_right.SetItem(row, 'LASTDATE'		, f_getsysdatetime())
CHOOSE CASE ls_colname
	// 적용일자
	//
	CASE "applydatefrom"
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '적용일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			dw_pisq060u_right.setitem(row,ls_colname, String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
			RETURN 1
		END IF	
		
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '적용일자를 정확히 입력하시요', StopSign!)
			dw_pisq060u_right.setitem(row,ls_colname, String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
			RETURN 1
		END IF

		IF Date(ls_coldata) < Date(f_getsysdatetime()) THEN
			MessageBox('확 인', '적용일자는 작업일보다 커야합니다', StopSign!)
			dw_pisq060u_right.setitem(row,ls_colname, String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
			RETURN 1
		END IF
	// 종료일자
	//
	CASE "applydateto"
		ls_fromdt = This.getitemstring(row, 'applydatefrom')
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '종료일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			dw_pisq060u_right.SetItem(row, ls_colname, '2999.12.31')
			RETURN 1
		END IF	

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '종료일자를 정확히 입력하시요', StopSign!)
			dw_pisq060u_right.SetItem(row, ls_colname, '2999.12.31')
			RETURN 1
		END IF
		
		IF ls_coldata <= ls_fromdt THEN
			MessageBox('확 인', '완료일자는 적용일자보다 커야합니다.', StopSign!)
			dw_pisq060u_right.SetItem(row, ls_colname, '2999.12.31')
			RETURN 1
		END IF
END CHOOSE

RETURN 0
//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event retrieveend;call super::retrieveend;
st_rightcnt.Text = String(rowcount, '#,###')
end event

type pb_move from picturebutton within w_pisq060u
integer x = 1605
integer y = 1044
integer width = 261
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
ll_row = dw_pisq060u_left.GetSelectedRow(0)
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
		ll_row = dw_pisq060u_left.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	//
	ll_LastRow = dw_pisq060u_right.InsertRow(0)
	dw_pisq060u_right.SetItem(ll_LastRow, 'AREACODE'			, dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'DIVISIONCODE'		, dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'PRODUCTGROUP'		, dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'AS_PRODUCTGROUP'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'MODELGROUP'			, dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'AS_MODELGROUP'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'ITEMCODE'			, dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'ITEMCODE'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'TMSTITEM_ITEMNAME', dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'ITEMNAME'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'SUPPLIERCODE'		, dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'SUPPLIERCODE'))
	dw_pisq060u_right.SetItem(ll_LastRow, 'TMSTSUPPLIER_SUPPLIERKORNAME'	, &
																				  dw_pisq060u_left.GetitemString(ll_SaveRow[ll_row], 'SUPPLIERKORNAME'))
	// 적용일자는 현재일 + 1일(작업일 익일부터 적용)
	//
	dw_pisq060u_right.SetItem(ll_LastRow, 'APPLYDATEFROM'		, &
	String(f_getsysdatetime(), 'yyyy.mm.dd') )
	dw_pisq060u_right.SetItem(ll_LastRow, 'APPLYDATETO'		, '2999.12.31')
	dw_pisq060u_right.SetItem(ll_LastRow, 'LASTEMP'		, g_s_empno)
	dw_pisq060u_right.SetItem(ll_LastRow, 'LASTDATE'		, f_getsysdatetime())

	// 좌측화면의 선택된행에 삭제표시를 셋트한다
	//
	dw_pisq060u_left.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq060u_left.GetSelectedRow(0)

// 이동이 끝난 좌측화면의 선택행은 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisq060u_left.RowCount() to 1 step -1
	IF dw_pisq060u_left.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq060u_left.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq060u_left.RowCount() THEN
	f_SetHighlight(dw_pisq060u_left, dw_pisq060u_left.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq060u_left, ll_select_row, True)	
END IF

f_sethighlight(dw_pisq060u_right,dw_pisq060u_right.RowCount(),TRUE)


end event

type pb_del from picturebutton within w_pisq060u
integer x = 1605
integer y = 1532
integer width = 261
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
string ls_fromdt, ls_todt, ls_currentdate

// 선택된 행이 있는지 체크한다
//
ls_currentdate = string(f_getsysdatetime(),'YYYY.MM.DD')
ll_row = dw_pisq060u_right.GetSelectedRow(0)
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
		ll_row = dw_pisq060u_right.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 우측측화면의 선택된행에 삭제표시를 셋트한다
//
FOR ll_row = 1 TO ll_index - 1
	ls_fromdt = dw_pisq060u_right.getitemstring(ll_SaveRow[ll_row], 'applydatefrom')
	ls_todt = dw_pisq060u_right.getitemstring(ll_SaveRow[ll_row], 'applydateto')
	//if ls_fromdt >= ls_currentdate or ls_todt < ls_currentdate then
		dw_pisq060u_right.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
	//end if
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq060u_right.GetSelectedRow(0)

// 선택행을 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisq060u_right.RowCount() to 1 step -1
	IF dw_pisq060u_right.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq060u_right.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq060u_right.RowCount() THEN
	f_SetHighlight(dw_pisq060u_right, dw_pisq060u_right.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq060u_right, ll_select_row, True)	
END IF

//parent.TriggerEvent('ue_save')
end event

type uo_area from u_pisc_select_area within w_pisq060u
integer x = 59
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
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

dw_pisq060u_left.SetTransObject(SQLPIS)
dw_pisq060u_right.SetTransObject(SQLPIS)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_productgroup from u_pisc_select_productgroup within w_pisq060u
integer x = 1198
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event constructor;call super::constructor;
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

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq060u
integer x = 2130
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

type uo_division from u_pisc_select_division within w_pisq060u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")

//PostEvent("ue_select")

end event

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

//	iw_this.TriggerEvent("ue_reset")
End If

dw_pisq060u_left.SetTransObject(SQLPIS)
dw_pisq060u_right.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq060u
integer x = 64
integer y = 228
integer width = 1467
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 비간판 거래명세표 관리품목 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq060u
integer x = 1906
integer y = 228
integer width = 1335
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 검사성적서비대상 관리품목 >"
boolean focusrectangle = false
end type

type st_rightcnt from statictext within w_pisq060u
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

type dw_print from datawindow within w_pisq060u
boolean visible = false
integer x = 2322
integer y = 800
integer width = 1138
integer height = 1148
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq060u_02_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print1 from datawindow within w_pisq060u
boolean visible = false
integer x = 101
integer y = 636
integer width = 1271
integer height = 1340
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq060u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq060u
integer x = 18
integer y = 196
integer width = 4608
integer height = 2380
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

type gb_2 from groupbox within w_pisq060u
integer x = 18
integer y = 12
integer width = 4608
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

type st_leftcnt from statictext within w_pisq060u
integer x = 1097
integer y = 240
integer width = 457
integer height = 56
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

