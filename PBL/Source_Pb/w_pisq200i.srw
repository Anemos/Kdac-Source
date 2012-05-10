$PBExportHeader$w_pisq200i.srw
$PBExportComments$주간별 FTTQ 현황
forward
global type w_pisq200i from w_ipis_sheet01
end type
type gb_3 from groupbox within w_pisq200i
end type
type gb_2 from groupbox within w_pisq200i
end type
type uo_area from u_pisc_select_area within w_pisq200i
end type
type uo_division from u_pisc_select_division within w_pisq200i
end type
type dw_pisq200i_01_graph from datawindow within w_pisq200i
end type
type dw_pisq200i_01 from datawindow within w_pisq200i
end type
type st_countview2 from statictext within w_pisq200i
end type
type dw_pisq200i_00 from datawindow within w_pisq200i
end type
type cbx_process from checkbox within w_pisq200i
end type
type gb_1 from groupbox within w_pisq200i
end type
type rb_asemble from radiobutton within w_pisq200i
end type
type rb_all from radiobutton within w_pisq200i
end type
type rb_machine from radiobutton within w_pisq200i
end type
type rb_large from radiobutton within w_pisq200i
end type
type rb_middle from radiobutton within w_pisq200i
end type
type rb_small from radiobutton within w_pisq200i
end type
type uo_date from u_pisc_date_applydate within w_pisq200i
end type
type dw_pisq200i_01_com from datawindow within w_pisq200i
end type
type dw_pisq200i_02_com from datawindow within w_pisq200i
end type
type dw_pisq200i_03_com from datawindow within w_pisq200i
end type
type dw_pisq200i_04_com from datawindow within w_pisq200i
end type
end forward

global type w_pisq200i from w_ipis_sheet01
integer width = 4690
integer height = 2708
string title = "주간별 FTTQ 현황"
gb_3 gb_3
gb_2 gb_2
uo_area uo_area
uo_division uo_division
dw_pisq200i_01_graph dw_pisq200i_01_graph
dw_pisq200i_01 dw_pisq200i_01
st_countview2 st_countview2
dw_pisq200i_00 dw_pisq200i_00
cbx_process cbx_process
gb_1 gb_1
rb_asemble rb_asemble
rb_all rb_all
rb_machine rb_machine
rb_large rb_large
rb_middle rb_middle
rb_small rb_small
uo_date uo_date
dw_pisq200i_01_com dw_pisq200i_01_com
dw_pisq200i_02_com dw_pisq200i_02_com
dw_pisq200i_03_com dw_pisq200i_03_com
dw_pisq200i_04_com dw_pisq200i_04_com
end type
global w_pisq200i w_pisq200i

type variables

datawindowchild	idwc_largegroup, idwc_middlegroup, idwc_smallgroup

end variables

on w_pisq200i.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq200i_01_graph=create dw_pisq200i_01_graph
this.dw_pisq200i_01=create dw_pisq200i_01
this.st_countview2=create st_countview2
this.dw_pisq200i_00=create dw_pisq200i_00
this.cbx_process=create cbx_process
this.gb_1=create gb_1
this.rb_asemble=create rb_asemble
this.rb_all=create rb_all
this.rb_machine=create rb_machine
this.rb_large=create rb_large
this.rb_middle=create rb_middle
this.rb_small=create rb_small
this.uo_date=create uo_date
this.dw_pisq200i_01_com=create dw_pisq200i_01_com
this.dw_pisq200i_02_com=create dw_pisq200i_02_com
this.dw_pisq200i_03_com=create dw_pisq200i_03_com
this.dw_pisq200i_04_com=create dw_pisq200i_04_com
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_pisq200i_01_graph
this.Control[iCurrent+6]=this.dw_pisq200i_01
this.Control[iCurrent+7]=this.st_countview2
this.Control[iCurrent+8]=this.dw_pisq200i_00
this.Control[iCurrent+9]=this.cbx_process
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.rb_asemble
this.Control[iCurrent+12]=this.rb_all
this.Control[iCurrent+13]=this.rb_machine
this.Control[iCurrent+14]=this.rb_large
this.Control[iCurrent+15]=this.rb_middle
this.Control[iCurrent+16]=this.rb_small
this.Control[iCurrent+17]=this.uo_date
this.Control[iCurrent+18]=this.dw_pisq200i_01_com
this.Control[iCurrent+19]=this.dw_pisq200i_02_com
this.Control[iCurrent+20]=this.dw_pisq200i_03_com
this.Control[iCurrent+21]=this.dw_pisq200i_04_com
end on

on w_pisq200i.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq200i_01_graph)
destroy(this.dw_pisq200i_01)
destroy(this.st_countview2)
destroy(this.dw_pisq200i_00)
destroy(this.cbx_process)
destroy(this.gb_1)
destroy(this.rb_asemble)
destroy(this.rb_all)
destroy(this.rb_machine)
destroy(this.rb_large)
destroy(this.rb_middle)
destroy(this.rb_small)
destroy(this.uo_date)
destroy(this.dw_pisq200i_01_com)
destroy(this.dw_pisq200i_02_com)
destroy(this.dw_pisq200i_03_com)
destroy(this.dw_pisq200i_04_com)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq130i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_maflag, ls_QcDate, ls_QcDateB1
String	ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_groupflag

// 공정별은 소분류에서만 가능
//
IF rb_small.Checked = FALSE AND cbx_process.Checked = TRUE THEN
	MessageBox('확 인', '공정별은 소분류에서만 가능합니다', StopSign!)
	RETURN
END IF

// 조회에 필요한 정보를 구한다
//
ls_QcDate			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_QcDateB1			= String(RelativeDate(date(ls_QcDate), -365), 'yyyy.mm.dd')

ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_largegroupcode	= dw_pisq200i_00.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq200i_00.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq200i_00.GetItemString(1, 'smallgroupcode')

// 가공별 체크시
//
IF rb_machine.Checked = TRUE THEN
	ls_maflag = 'M'
END IF

// 조립별 체크시
//
IF rb_asemble.Checked = TRUE THEN
	ls_maflag = 'A'
END IF

// 전체 체크시
//
IF rb_all.Checked = TRUE THEN
	ls_maflag = '%'
END IF

// 대분류별 조회
//
IF rb_large.Checked = TRUE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_01'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_01_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// 데이타/그래프를 조회한다
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate)

	dw_pisq200i_01_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1)
END IF

// 중분류별 조회
//
IF rb_middle.Checked = TRUE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_02'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_02_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// 데이타/그래프를 조회한다
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_largegroupcode)

	dw_pisq200i_02_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode)
END IF

// 소분류별 조회
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = FALSE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_03'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_03_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// 데이타/그래프를 조회한다
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode, ls_middlegroupcode)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate,ls_largegroupcode, ls_middlegroupcode)

	dw_pisq200i_03_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode, ls_middlegroupcode)
END IF

// 소분류별공정별 조회
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = TRUE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_04'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_04_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// 데이타/그래프를 조회한다
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1,ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate,ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)

	dw_pisq200i_04_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1,ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
END IF


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

event ue_postopen;call super::ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow 설정(제품 대/중/소 분류)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

dw_pisq200i_00.PostEvent(Constructor!)

end event

event ue_print;call super::ue_print;
IF MessageBox('확 인', '그래프 출력은 별도의 화면없이 바로 출력됩니다.~r~n출력하시겠습니까?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

// 대분류별 출력
//
IF rb_large.Checked = TRUE THEN
	// 그래프 백그라운드 색상을 바꾼다
	//
	dw_pisq200i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_01_com.print()
END IF

// 중분류별 출력
//
IF rb_middle.Checked = TRUE THEN
	dw_pisq200i_02_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_02_com.print()
END IF

// 소분류별 출력
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = FALSE THEN
	dw_pisq200i_03_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_03_com.print()
END IF

// 소분류별공정별 출력
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = TRUE THEN
	dw_pisq200i_04_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_04_com.print()
END IF

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow 설정(제품 대/중/소 분류)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq200i
integer x = 18
integer y = 2124
integer width = 3598
end type

type gb_3 from groupbox within w_pisq200i
integer x = 3182
integer y = 40
integer width = 1033
integer height = 112
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

type gb_2 from groupbox within w_pisq200i
integer x = 3182
integer y = 148
integer width = 1033
integer height = 112
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_area from u_pisc_select_area within w_pisq200i
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
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow 설정(제품 대/중/소 분류)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

dw_pisq200i_00.PostEvent(Constructor!)
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

type uo_division from u_pisc_select_division within w_pisq200i
event destroy ( )
integer x = 594
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
// 압축기 공장만 가공/조립이 있고 그외는 무조건 전체
//
IF uo_division.is_uo_divisioncode = 'V' THEN
	rb_machine.Visible = TRUE
	rb_asemble.Visible = TRUE
	rb_all.Visible 	 = TRUE
ELSE
	rb_machine.Visible = FALSE
	rb_asemble.Visible = FALSE
	rb_all.Visible 	 = FALSE
END IF	

// 트랜잭션을 연결한다
//
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow 설정(제품 대/중/소 분류)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

dw_pisq200i_00.PostEvent(Constructor!)
end event

type dw_pisq200i_01_graph from datawindow within w_pisq200i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 18
integer y = 296
integer width = 4613
integer height = 1692
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_01_graph"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_rbuttonup;
st_countview2.Visible = FALSE

// 시스템 팝업메뉴 표시를 억제한다.
//
RETURN 1


end event

event rbuttondown;
//------------------------------------------------------------------------------
// 처리개요		:	Application Rbuttondown Script
//						- 그래프의 VALUE값을 표시한다.
// 사용인수		:	None
// 반환값		:	None
//------------------------------------------------------------------------------

// 그래프의 VALUE값을 표시하는 함수를 호출한다. (사용자 정의함수)
//
f_DisplayGraphValue (This, st_countview2)

//------------------------------------------------------------------------------
// End of Script
//------------------------------------------------------------------------------

end event

type dw_pisq200i_01 from datawindow within w_pisq200i
integer x = 18
integer y = 2004
integer width = 4613
integer height = 584
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_countview2 from statictext within w_pisq200i
boolean visible = false
integer x = 1513
integer y = 932
integer width = 224
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_pisq200i_00 from datawindow within w_pisq200i
integer x = 59
integer y = 164
integer width = 3118
integer height = 76
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq190i_00"
boolean border = false
boolean livescroll = true
end type

event constructor;
String	ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_date, ls_processcode, ls_badreasoncode
Long		ll_retrieverow 

if uo_area.dw_1.GetRow() < 1 then
	return 0
end if
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')

// Child Retrieve(대분류)
//
ll_retrieverow = idwc_largegroup.Retrieve(ls_AreaCode, ls_DivisionCode)
if ll_retrieverow < 1 then
	return 0
end if
// Child Window에서 대분류 코드를 구한다
//
ls_largegroupcode = idwc_largegroup.GetItemString(1, 'largegroupcode')

// Child Retrieve(중분류)
//
ll_retrieverow = idwc_middlegroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode)
if ll_retrieverow < 1 then
	return 0
end if
// Child Window에서 중분류 코드를 구한다
//
ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')

// Child Retrieve(소분류)
//
ll_retrieverow = idwc_smallgroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
if ll_retrieverow < 1 then
	return 0
end if
// Child Window에서 소분류 코드를 구한다
//
ls_smallgroupcode = idwc_smallgroup.GetItemString(1, 'smallgroupcode')

dw_pisq200i_00.InsertRow(0)
dw_pisq200i_00.SetItem(1, 'largegroupcode' , ls_largegroupcode)
dw_pisq200i_00.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
dw_pisq200i_00.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)

end event

event itemchanged;
String	ls_colname, ls_coldata, ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode

IF dw_pisq200i_00.AcceptText() <> 1 THEN RETURN

ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 대분류가 변경시
	//
	CASE 'largegroupcode'
		// 변경된 대분류 코드를 구한다
		//
		ls_largegroupcode = ls_coldata
		
		// Child Retrieve(중분류)
		//
		idwc_middlegroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode)

		// Child Window에서 중분류 코드를 구한다
		//
		ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')
		
		// Child Retrieve(소분류)
		//
		idwc_smallgroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		// Child Window에서 소분류 코드를 구한다
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')

		dw_pisq200i_00.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
		dw_pisq200i_00.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)

	// 중분류가 변경시
	//
	CASE 'middlegroupcode'
		// 대/중분류 코드를 구한다
		//
		ls_largegroupcode  = dw_pisq200i_00.GetItemString(1, 'largegroupcode')
		ls_middlegroupcode = ls_coldata
	
		// Child Retrieve(소분류)
		//
		idwc_smallgroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		// Child Window에서 소분류 코드를 구한다
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')
		dw_pisq200i_00.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
END CHOOSE

end event

type cbx_process from checkbox within w_pisq200i
integer x = 2843
integer y = 60
integer width = 288
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "공정별"
boolean lefttext = true
end type

type gb_1 from groupbox within w_pisq200i
integer x = 18
integer y = 12
integer width = 4613
integer height = 272
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

type rb_asemble from radiobutton within w_pisq200i
boolean visible = false
integer x = 3570
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
string text = "조립"
end type

event clicked;//
//// LOT별 조회용 데이타윈도우를 셋트한다
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_all from radiobutton within w_pisq200i
boolean visible = false
integer x = 3877
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
string text = "전체"
boolean checked = true
end type

event clicked;//
//// LOT별 조회용 데이타윈도우를 셋트한다
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_01'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_01_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_machine from radiobutton within w_pisq200i
boolean visible = false
integer x = 3264
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
string text = "가공"
end type

event clicked;//
//// LOT별 조회용 데이타윈도우를 셋트한다
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_large from radiobutton within w_pisq200i
integer x = 3264
integer y = 180
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
string text = "대분류"
boolean checked = true
end type

event clicked;//
//// LOT별 조회용 데이타윈도우를 셋트한다
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_middle from radiobutton within w_pisq200i
integer x = 3570
integer y = 180
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
string text = "중분류"
end type

event clicked;//
//// LOT별 조회용 데이타윈도우를 셋트한다
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_small from radiobutton within w_pisq200i
integer x = 3877
integer y = 180
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
string text = "소분류"
end type

event clicked;//
//// LOT별 조회용 데이타윈도우를 셋트한다
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_01'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_01_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type uo_date from u_pisc_date_applydate within w_pisq200i
event destroy ( )
integer x = 1198
integer y = 60
integer taborder = 70
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_pisq200i_01_com from datawindow within w_pisq200i
boolean visible = false
integer x = 32
integer y = 312
integer width = 2267
integer height = 1604
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq200i_02_com from datawindow within w_pisq200i
boolean visible = false
integer x = 366
integer y = 308
integer width = 2267
integer height = 1604
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_02_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq200i_03_com from datawindow within w_pisq200i
boolean visible = false
integer x = 773
integer y = 308
integer width = 2267
integer height = 1604
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_03_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq200i_04_com from datawindow within w_pisq200i
boolean visible = false
integer x = 1143
integer y = 316
integer width = 2267
integer height = 1604
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_04_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

