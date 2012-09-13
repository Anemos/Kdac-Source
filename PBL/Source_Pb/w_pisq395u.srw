$PBExportHeader$w_pisq395u.srw
$PBExportComments$WARRANTY 목표율 등록
forward
global type w_pisq395u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq395u
end type
type uo_division from u_pisc_select_division within w_pisq395u
end type
type dw_pisq395u_01 from u_vi_std_datawindow within w_pisq395u
end type
type st_2 from statictext within w_pisq395u
end type
type sle_date from singlelineedit within w_pisq395u
end type
type gb_2 from groupbox within w_pisq395u
end type
type gb_3 from groupbox within w_pisq395u
end type
end forward

global type w_pisq395u from w_ipis_sheet01
integer width = 4709
integer height = 2700
string title = "WARRANTY 목표율 등록"
uo_area uo_area
uo_division uo_division
dw_pisq395u_01 dw_pisq395u_01
st_2 st_2
sle_date sle_date
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq395u w_pisq395u

type variables

String	is_AreaCode, is_DivisionCode
Long		il_selectcnt

end variables

forward prototypes
public subroutine wf_newinsert ()
public function boolean wf_checkcolumn ()
end prototypes

public subroutine wf_newinsert ();
Int		li_row
boolean	lb_rtn
String	ls_date, ls_productgroup
dec		ld_qty1, ld_qty2, ld_qty3, ld_qty4 , ld_qty5 , ld_qty6
dec		ld_qty7, ld_qty8, ld_qty9, ld_qty10, ld_qty11, ld_qty12, ld_qtyyeargoal
dec		ld_amount1, ld_amount2, ld_amount3, ld_amount4, ld_amount5, ld_amount6
dec		ld_amount7, ld_amount8, ld_amount9, ld_amount10, ld_amount11, ld_amount12, ld_amountyeargoal

ls_date = sle_date.Text

// AUTO COMMIT을 FASLE로 지정
//
SQLEIS.AUTOCommit = FALSE

// 전체의 자료만큼 LOOP처리를 하면서 자료를 인서트한다 
//
FOR li_row = 1 TO dw_pisq395u_01.RowCount()
	ls_productgroup= dw_pisq395u_01.GetItemString(li_row, 'tmstproductgroup_productgroup')
	ld_qty1			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty1')
	ld_qty2			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty2')
	ld_qty3			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty3')
	ld_qty4 			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty4')
	ld_qty5 			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty5')
	ld_qty6			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty6')
	ld_qty7			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty7')
	ld_qty8			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty8')
	ld_qty9			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty9')
	ld_qty10			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty10')
	ld_qty11			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty11')
	ld_qty12			= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qty12')
	ld_qtyyeargoal	= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_qtyyeargoal')
	ld_amount1		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount1')
	ld_amount2		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount2')
	ld_amount3		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount3')
	ld_amount4		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount4')
	ld_amount5		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount5')
	ld_amount6		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount6')
	ld_amount7		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount7')
	ld_amount8		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount8')
	ld_amount9		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount9')
	ld_amount10		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount10')
	ld_amount11		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount11')
	ld_amount12		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amount12')
	ld_amountyeargoal		= dw_pisq395u_01.GetItemNumber(li_row, 'tqwarrantygoalreject_amountyeargoal')

	INSERT INTO TQWARRANTYGOALREJECT  
			 ( AREACODE, DIVISIONCODE, STANDARDYEAR, PRODUCTGROUP,   
            qty1, qty2, qty3, qty4 , qty5 , qty6, 
				qty7, qty8, qty9, qty10, qty11, qty12, QTYYEARGOAL ,
				amount1, amount2, amount3, amount4, amount5, amount6,
				amount7, amount8, amount9, amount10, amount11, amount12, amountyeargoal)
   VALUES ( :is_areacode, :is_divisioncode, :ls_date, :ls_productgroup,
				:ld_qty1, :ld_qty2, :ld_qty3, :ld_qty4 , :ld_qty5 , :ld_qty6,
				:ld_qty7, :ld_qty8, :ld_qty9, :ld_qty10, :ld_qty11, :ld_qty12, :ld_qtyyeargoal,
				:ld_amount1, :ld_amount2, :ld_amount3, :ld_amount4, :ld_amount5, :ld_amount6,
				:ld_amount7, :ld_amount8, :ld_amount9, :ld_amount10, :ld_amount11, :ld_amount12, :ld_amountyeargoal)
	 USING SQLEIS;
NEXT

IF SQLEIS.SQLCode = 0 THEN
	// Commit 처리
	//
	COMMIT USING SQLEIS;
	lb_rtn = TRUE
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	RollBack using SQLEIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '대분류별 목표불량율 파일 처리에 실패했습니다')
END IF

end subroutine

public function boolean wf_checkcolumn ();
Int		li_row
Boolean	lb_rtn = TRUE

IF dw_pisq395u_01.AcceptText() <> 1 THEN RETURN FALSE

// 전체의 자료를 체크한다
//
FOR li_row = 1 TO dw_pisq395u_01.RowCount()
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month1') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month1')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 1월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month1')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month2') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month2')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 2월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month2')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month3') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month3')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 3월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month3')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month4') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month4')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 4월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month4')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month5') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month5')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 5월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month5')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month6') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month6')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 6월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month6')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month7') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month7')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 7월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month7')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month8') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month8')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 8월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month8')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month9') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month9')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 9월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month9')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month10') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month10')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 10월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month10')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month11') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month11')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 11월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month11')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_month12') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_month12')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 12월 불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_month12')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq395u_01.GetItemNumber(li_row, 'as_yeargoal') = 0 OR &
		IsNull(dw_pisq395u_01.GetItemNumber(li_row, 'as_yeargoal')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 년목표불량율를 입력하세요', StopSign!)
		dw_pisq395u_01.SetColumn('as_yeargoal')
		lb_rtn = FALSE
		EXIT
	END IF
NEXT

dw_pisq395u_01.ScrollToRow(li_row)
f_SetHighlight(dw_pisq395u_01, li_row, True)	
dw_pisq395u_01.SetFocus()

RETURN lb_rtn

end function

on w_pisq395u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq395u_01=create dw_pisq395u_01
this.st_2=create st_2
this.sle_date=create sle_date
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq395u_01
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_date
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_3
end on

on w_pisq395u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq395u_01)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.gb_2)
destroy(this.gb_3)
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
String	ls_date
Long		ll_insrow

// 조회에 필요한 정보를 구한다
//
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_date				= sle_date.Text

IF f_checknullorspace(ls_date) = TRUE THEN
	MessageBox('확 인', '기준년도를 입력후 조회하세요', StopSign!)
	sle_date.SetFocus()
	RETURN
END IF

// 신규건인지 수정건인지 확인한다(신규/수정건에 따라 처리방식이 틀리기때문)
//
il_selectcnt = 0
SELECT count(*)
  INTO :il_selectcnt
  FROM TQWARRANTYGOALREJECT  A
 WHERE A.AREACODE			= :is_AreaCode
   AND A.DIVISIONCODE	= :is_DivisionCode
   AND A.STANDARDYEAR	= :ls_date
 USING SQLEIS;

IF il_selectcnt = 0 THEN
	// 신규건
	//
	dw_pisq395u_01.dataobject = 'd_pisq395u_01'
ELSE
	// 수정건
	//
	dw_pisq395u_01.dataobject = 'd_pisq395u_02'
END IF

dw_pisq395u_01.SetTransObject(SQLEIS)
dw_pisq395u_01.Retrieve(is_AreaCode, is_DivisionCode, ls_date)

// 신규건일때는 토탈입력란을 마지막에 만들어준다
//
IF il_selectcnt = 0 THEN
	// 신규건
	//
	ll_insrow = dw_pisq395u_01.InsertRow(0)
	dw_pisq395u_01.SetItem(ll_insrow, 'tmstproductgroup_productgroup', 'ZZ')
	dw_pisq395u_01.SetItem(ll_insrow, 'tmstproductgroup_productgroupname', 'TOTAL')
ELSE
	dw_pisq395u_01.SetItem(dw_pisq395u_01.RowCount(), 'tmstproductgroup_productgroupname', 'TOTAL')
END IF

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq395u_01, 1, True)	

end event

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq395u_01.SetTransObject(SQLEIS)

sle_date.Text = String(f_getsysdatetime(), 'yyyy')
end event

event ue_save;call super::ue_save;
Int	li_save

// 자료 조회시 구해논 인스턴스 변수를 가지고 신규/수정건 판단을 한다
//
IF il_selectcnt = 0 THEN								// 신규건은 SQL로 처리한다
	// 필수입력 항목을 체크한다
	//
//	IF wf_checkcolumn() = FALSE THEN RETURN		// 에러 발생시 리턴
	// 신규건
	//
	wf_newinsert()
	This.TriggerEvent('ue_retrieve')
	RETURN
END IF

// 수정건은 파워빌더의 UPDATE함수를 이용하여 처리한다 
//
// AUTO COMMIT을 FASLE로 지정
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq395u_01.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF


end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

// 트랜잭션을 연결한다
//
dw_pisq395u_01.SetTransObject(SQLEIS)

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq395u
integer x = 18
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq395u
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
dw_pisq395u_01.SetTransObject(SQLEIS)

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

type uo_division from u_pisc_select_division within w_pisq395u
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
// 트랜잭션을 연결한다
//
dw_pisq395u_01.SetTransObject(SQLEIS)

end event

type dw_pisq395u_01 from u_vi_std_datawindow within w_pisq395u
integer x = 46
integer y = 228
integer width = 4558
integer height = 2324
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq395u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisq395u
integer x = 1211
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
string text = "기준년도:"
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_pisq395u
integer x = 1513
integer y = 60
integer width = 233
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisq395u
integer x = 18
integer y = 188
integer width = 4613
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

type gb_3 from groupbox within w_pisq395u
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
integer taborder = 100
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

