$PBExportHeader$w_pisq330u.srw
$PBExportComments$Warranty 분석결과 코드등록
forward
global type w_pisq330u from w_ipis_sheet01
end type
type gb_1 from groupbox within w_pisq330u
end type
type gb_4 from groupbox within w_pisq330u
end type
type gb_5 from groupbox within w_pisq330u
end type
type dw_pisq330u_01 from u_vi_std_datawindow within w_pisq330u
end type
type dw_pisq330u_02 from u_vi_std_datawindow within w_pisq330u
end type
type dw_pisq330u_03 from u_vi_std_datawindow within w_pisq330u
end type
type st_2 from statictext within w_pisq330u
end type
type st_3 from statictext within w_pisq330u
end type
type st_4 from statictext within w_pisq330u
end type
type cb_large_ins from commandbutton within w_pisq330u
end type
type cb_large_del from commandbutton within w_pisq330u
end type
type cb_large_save from commandbutton within w_pisq330u
end type
type cb_middle_save from commandbutton within w_pisq330u
end type
type cb_middle_del from commandbutton within w_pisq330u
end type
type cb_middle_ins from commandbutton within w_pisq330u
end type
type cb_small_ins from commandbutton within w_pisq330u
end type
type cb_small_del from commandbutton within w_pisq330u
end type
type cb_small_save from commandbutton within w_pisq330u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq330u
end type
type uo_area from u_pisc_select_area within w_pisq330u
end type
type uo_division from u_pisc_select_division within w_pisq330u
end type
type gb_2 from groupbox within w_pisq330u
end type
type gb_3 from groupbox within w_pisq330u
end type
end forward

global type w_pisq330u from w_ipis_sheet01
integer width = 4489
integer height = 2700
string title = "Warranty 분석결과 코드등록"
gb_1 gb_1
gb_4 gb_4
gb_5 gb_5
dw_pisq330u_01 dw_pisq330u_01
dw_pisq330u_02 dw_pisq330u_02
dw_pisq330u_03 dw_pisq330u_03
st_2 st_2
st_3 st_3
st_4 st_4
cb_large_ins cb_large_ins
cb_large_del cb_large_del
cb_large_save cb_large_save
cb_middle_save cb_middle_save
cb_middle_del cb_middle_del
cb_middle_ins cb_middle_ins
cb_small_ins cb_small_ins
cb_small_del cb_small_del
cb_small_save cb_small_save
uo_productgroup uo_productgroup
uo_area uo_area
uo_division uo_division
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq330u w_pisq330u

type variables

String	is_AreaCode, is_DivisionCode, is_productgroup
Boolean	ib_open

end variables

on w_pisq330u.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_5=create gb_5
this.dw_pisq330u_01=create dw_pisq330u_01
this.dw_pisq330u_02=create dw_pisq330u_02
this.dw_pisq330u_03=create dw_pisq330u_03
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.cb_large_ins=create cb_large_ins
this.cb_large_del=create cb_large_del
this.cb_large_save=create cb_large_save
this.cb_middle_save=create cb_middle_save
this.cb_middle_del=create cb_middle_del
this.cb_middle_ins=create cb_middle_ins
this.cb_small_ins=create cb_small_ins
this.cb_small_del=create cb_small_del
this.cb_small_save=create cb_small_save
this.uo_productgroup=create uo_productgroup
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.dw_pisq330u_01
this.Control[iCurrent+5]=this.dw_pisq330u_02
this.Control[iCurrent+6]=this.dw_pisq330u_03
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.cb_large_ins
this.Control[iCurrent+11]=this.cb_large_del
this.Control[iCurrent+12]=this.cb_large_save
this.Control[iCurrent+13]=this.cb_middle_save
this.Control[iCurrent+14]=this.cb_middle_del
this.Control[iCurrent+15]=this.cb_middle_ins
this.Control[iCurrent+16]=this.cb_small_ins
this.Control[iCurrent+17]=this.cb_small_del
this.Control[iCurrent+18]=this.cb_small_save
this.Control[iCurrent+19]=this.uo_productgroup
this.Control[iCurrent+20]=this.uo_area
this.Control[iCurrent+21]=this.uo_division
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.gb_3
end on

on w_pisq330u.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.dw_pisq330u_01)
destroy(this.dw_pisq330u_02)
destroy(this.dw_pisq330u_03)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_large_ins)
destroy(this.cb_large_del)
destroy(this.cb_large_save)
destroy(this.cb_middle_save)
destroy(this.cb_middle_del)
destroy(this.cb_middle_ins)
destroy(this.cb_small_ins)
destroy(this.cb_small_del)
destroy(this.cb_small_save)
destroy(this.uo_productgroup)
destroy(this.uo_area)
destroy(this.uo_division)
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
String	ls_LargeGroupCode, ls_MiddleGroupCode
long ll_rowcnt
// 조회에 필요한 정보를 구한다
//
dw_pisq330u_01.reset()
dw_pisq330u_02.reset()
dw_pisq330u_03.reset()

is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 

// 데이타를 조회한다
//
ll_rowcnt = dw_pisq330u_01.Retrieve(is_AreaCode, is_DivisionCode, is_productgroup)
if ll_rowcnt < 1 then
	return 0
end if

ls_LargeGroupCode = dw_pisq330u_01.GetItemString(1, 'LargeGroupCode')
ll_rowcnt = dw_pisq330u_02.Retrieve(is_AreaCode, is_DivisionCode, is_productgroup, ls_LargeGroupCode)
if ll_rowcnt < 1 then
	f_SetHighlight(dw_pisq330u_01, 1, True)
	return 0
end if
ls_MiddleGroupCode = dw_pisq330u_02.GetItemString(1, 'MiddleGroupCode')
dw_pisq330u_03.Retrieve(is_AreaCode, is_DivisionCode, is_productgroup, ls_LargeGroupCode, ls_MiddleGroupCode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq330u_01, 1, True)	
f_SetHighlight(dw_pisq330u_02, 1, True)	
f_SetHighlight(dw_pisq330u_03, 1, True)	


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


end event

event activate;call super::activate;// 트랜잭션을 연결한다
//
dw_pisq330u_01.SetTransObject(SQLPIS)
dw_pisq330u_02.SetTransObject(SQLPIS)
dw_pisq330u_03.SetTransObject(SQLPIS)

end event

event ue_postopen;call super::ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq330u_01.SetTransObject(SQLPIS)
dw_pisq330u_02.SetTransObject(SQLPIS)
dw_pisq330u_03.SetTransObject(SQLPIS)

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
										FALSE, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)


ib_open = True

// 처리를 조회로 넘긴다
//
This.PostEvent("ue_retrieve")

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq330u
integer x = 18
integer width = 3598
end type

type gb_1 from groupbox within w_pisq330u
integer x = 1499
integer y = 2376
integer width = 1435
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

type gb_4 from groupbox within w_pisq330u
integer x = 2953
integer y = 2376
integer width = 1435
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

type gb_5 from groupbox within w_pisq330u
integer x = 46
integer y = 2376
integer width = 1435
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

type dw_pisq330u_01 from u_vi_std_datawindow within w_pisq330u
integer x = 46
integer y = 320
integer width = 1435
integer height = 2040
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq330u_01"
boolean vscrollbar = true
end type

event rowfocuschanged;
String	ls_LargeGroupCode, ls_MiddleGroupCode

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
if dw_pisq330u_01.rowcount() < 1 or currentrow < 1 then
	return 0
end if

ls_LargeGroupCode	= dw_pisq330u_01.GetItemString(currentrow, 'LargeGroupCode')
dw_pisq330u_02.Retrieve(is_AreaCode, is_DivisionCode, is_productgroup, ls_LargeGroupCode)
if dw_pisq330u_02.rowcount() < 1 then
	dw_pisq330u_03.reset()
	return 0
end if
ls_MiddleGroupCode= dw_pisq330u_02.GetItemString(1, 'MiddleGroupCode')
dw_pisq330u_03.Retrieve(is_AreaCode, is_DivisionCode, is_productgroup, ls_LargeGroupCode, ls_MiddleGroupCode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq330u_02, 1, True)	
f_SetHighlight(dw_pisq330u_03, 1, True)	



end event

event clicked;call super::clicked;
//This.TriggerEvent(RowFocusChanged!)

end event

type dw_pisq330u_02 from u_vi_std_datawindow within w_pisq330u
integer x = 1499
integer y = 320
integer width = 1435
integer height = 2040
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq330u_02"
boolean vscrollbar = true
end type

event clicked;call super::clicked;
//This.TriggerEvent(RowFocusChanged!)
end event

event rowfocuschanged;
String	ls_LargeGroupCode, ls_MiddleGroupCode

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
if dw_pisq330u_02.rowcount() < 1 or currentrow < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq330u_02.GetItemString(currentrow, 'LargeGroupCode')
ls_MiddleGroupCode= dw_pisq330u_02.GetItemString(currentrow, 'MiddleGroupCode')
dw_pisq330u_03.Retrieve(is_AreaCode, is_DivisionCode, is_productgroup, ls_LargeGroupCode, ls_MiddleGroupCode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq330u_03, 1, True)	


end event

type dw_pisq330u_03 from u_vi_std_datawindow within w_pisq330u
integer x = 2953
integer y = 320
integer width = 1435
integer height = 2040
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq330u_03"
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisq330u
integer x = 73
integer y = 236
integer width = 718
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
string text = "< 분석결과 대분류 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq330u
integer x = 1527
integer y = 236
integer width = 786
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
string text = "< 분석결과 중분류 >"
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisq330u
integer x = 2981
integer y = 236
integer width = 786
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
string text = "< 분석결과 소분류 >"
boolean focusrectangle = false
end type

type cb_large_ins from commandbutton within w_pisq330u
integer x = 315
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입  력"
end type

event clicked;
Long	ll_ins_row

// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq330u_01.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
dw_pisq330u_01.SetItem(ll_ins_row, 'areacode', is_areacode)
dw_pisq330u_01.SetItem(ll_ins_row, 'divisioncode', is_divisioncode)
dw_pisq330u_01.SetItem(ll_ins_row, 'productgroup', is_productgroup)

// 포커스를 이동한다
//
dw_pisq330u_01.SetColumn('largegroupcode')
dw_pisq330u_01.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq330u_01, ll_ins_row, True)	

// 신규 입력건이 발생하면 하위분류의 데이타윈도우를 초기화한다
//
dw_pisq330u_02.ReSet()
dw_pisq330u_03.ReSet()


end event

type cb_large_del from commandbutton within w_pisq330u
integer x = 699
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭  제"
end type

event clicked;
Long	ll_select_row

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq330u_01.GetSelectedRow(0)

// 선택된 행의 중분류의 유무를 판단하여 없는경우만 삭제가 가능하다
//
IF dw_pisq330u_02.RowCount() > 0 THEN 
	MessageBox('확 인', '하위의 중분류가 없는경우만 삭제가 가능합니다', StopSign!)
	RETURN
END IF

// 선택된 행을 삭제한다
//
dw_pisq330u_01.DeleteRow(dw_pisq330u_01.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq330u_01.RowCount() THEN
	f_SetHighlight(dw_pisq330u_01, dw_pisq330u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq330u_01, ll_select_row, True)	
END IF

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
dw_pisq330u_01.TriggerEvent(RowFocusChanged!)
end event

type cb_large_save from commandbutton within w_pisq330u
integer x = 1083
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저  장"
end type

event clicked;
Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq330u_01.Update()

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
END IF



end event

type cb_middle_save from commandbutton within w_pisq330u
integer x = 2542
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저  장"
end type

event clicked;
Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq330u_02.Update()

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
END IF



end event

type cb_middle_del from commandbutton within w_pisq330u
integer x = 2158
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭  제"
end type

event clicked;
Long	ll_select_row

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq330u_02.GetSelectedRow(0)

// 선택된 행의 소분류의 유무를 판단하여 없는경우만 삭제가 가능하다
//
IF dw_pisq330u_03.RowCount() > 0 THEN 
	MessageBox('확 인', '하위의 소분류가 없는경우만 삭제가 가능합니다', StopSign!)
	RETURN
END IF

// 선택된 행을 삭제한다
//
dw_pisq330u_02.DeleteRow(dw_pisq330u_02.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq330u_02.RowCount() THEN
	f_SetHighlight(dw_pisq330u_02, dw_pisq330u_02.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq330u_02, ll_select_row, True)	
END IF

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
dw_pisq330u_02.TriggerEvent(RowFocusChanged!)
end event

type cb_middle_ins from commandbutton within w_pisq330u
integer x = 1774
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입  력"
end type

event clicked;
Long		ll_ins_row
String	ls_largegroupcode

// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq330u_02.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
ls_largegroupcode = dw_pisq330u_01.GetItemString(dw_pisq330u_01.GetSelectedRow(0), 'largegroupcode')
dw_pisq330u_02.SetItem(ll_ins_row, 'areacode'		, is_areacode)
dw_pisq330u_02.SetItem(ll_ins_row, 'divisioncode'	, is_divisioncode)
dw_pisq330u_02.SetItem(ll_ins_row, 'productgroup'	, is_productgroup)
dw_pisq330u_02.SetItem(ll_ins_row, 'largegroupcode', ls_largegroupcode)

// 포커스를 이동한다
//
dw_pisq330u_02.SetColumn('middlegroupcode')
dw_pisq330u_02.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq330u_02, ll_ins_row, True)	

// 신규 입력건이 발생하면 하위분류의 데이타윈도우를 초기화한다
//
dw_pisq330u_03.ReSet()

end event

type cb_small_ins from commandbutton within w_pisq330u
integer x = 3232
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입  력"
end type

event clicked;
Long		ll_ins_row
String	ls_largegroupcode, ls_middlegroupcode

// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq330u_03.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
ls_largegroupcode  = dw_pisq330u_02.GetItemString(dw_pisq330u_02.GetSelectedRow(0), 'largegroupcode')
ls_middlegroupcode = dw_pisq330u_02.GetItemString(dw_pisq330u_02.GetSelectedRow(0), 'middlegroupcode')
dw_pisq330u_03.SetItem(ll_ins_row, 'areacode'		 , is_areacode)
dw_pisq330u_03.SetItem(ll_ins_row, 'divisioncode'	 , is_divisioncode)
dw_pisq330u_03.SetItem(ll_ins_row, 'productgroup'	 , is_productgroup)
dw_pisq330u_03.SetItem(ll_ins_row, 'largegroupcode' , ls_largegroupcode)
dw_pisq330u_03.SetItem(ll_ins_row, 'middlegroupcode', ls_middlegroupcode)

// 포커스를 이동한다
//
dw_pisq330u_03.SetColumn('smallgroupcode')
dw_pisq330u_03.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq330u_03, ll_ins_row, True)	

end event

type cb_small_del from commandbutton within w_pisq330u
integer x = 3616
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭  제"
end type

event clicked;
Long	ll_select_row

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq330u_03.GetSelectedRow(0)

// 선택된 행을 삭제한다
//
dw_pisq330u_03.DeleteRow(dw_pisq330u_03.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq330u_03.RowCount() THEN
	f_SetHighlight(dw_pisq330u_03, dw_pisq330u_03.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq330u_03, ll_select_row, True)	
END IF

end event

type cb_small_save from commandbutton within w_pisq330u
integer x = 4000
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저  장"
end type

event clicked;
Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq330u_03.Update()

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
END IF

end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq330u
event destroy ( )
integer x = 1198
integer y = 60
integer taborder = 30
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
	// 처리를 조회로 넘긴다
	//
	Parent.TriggerEvent("ue_retrieve")
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

type uo_area from u_pisc_select_area within w_pisq330u
integer x = 59
integer y = 60
integer taborder = 40
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
											FALSE, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

End If

// 트랜잭션을 연결한다
//
dw_pisq330u_01.SetTransObject(SQLPIS)
dw_pisq330u_02.SetTransObject(SQLPIS)
dw_pisq330u_03.SetTransObject(SQLPIS)

dw_pisq330u_01.reset()
dw_pisq330u_02.reset()
dw_pisq330u_03.reset()

Parent.TriggerEvent("ue_retrieve")
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

type uo_division from u_pisc_select_division within w_pisq330u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 40
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
											FALSE, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
End If

// 트랜잭션을 연결한다
//
dw_pisq330u_01.SetTransObject(SQLPIS)
dw_pisq330u_02.SetTransObject(SQLPIS)
dw_pisq330u_03.SetTransObject(SQLPIS)

dw_pisq330u_01.reset()
dw_pisq330u_02.reset()
dw_pisq330u_03.reset()

Parent.TriggerEvent("ue_retrieve")



end event

type gb_2 from groupbox within w_pisq330u
integer x = 18
integer y = 188
integer width = 4402
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

type gb_3 from groupbox within w_pisq330u
integer x = 18
integer y = 12
integer width = 4402
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

