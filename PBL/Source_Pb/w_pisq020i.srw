$PBExportHeader$w_pisq020i.srw
$PBExportComments$검사기준서 관리현황
forward
global type w_pisq020i from w_ipis_sheet01
end type
type dw_pisq020i from u_vi_std_datawindow within w_pisq020i
end type
type cb_examination from commandbutton within w_pisq020i
end type
type uo_area from u_pisc_select_area within w_pisq020i
end type
type uo_division from u_pisc_select_division within w_pisq020i
end type
type sle_date from singlelineedit within w_pisq020i
end type
type sle_suppliercode from singlelineedit within w_pisq020i
end type
type sle_suppliername from singlelineedit within w_pisq020i
end type
type st_2 from statictext within w_pisq020i
end type
type st_3 from statictext within w_pisq020i
end type
type pb_serch from picturebutton within w_pisq020i
end type
type cb_change from commandbutton within w_pisq020i
end type
type gb_1 from groupbox within w_pisq020i
end type
end forward

global type w_pisq020i from w_ipis_sheet01
integer width = 4800
integer height = 2136
string title = "검사기준서 관리현황"
dw_pisq020i dw_pisq020i
cb_examination cb_examination
uo_area uo_area
uo_division uo_division
sle_date sle_date
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
st_2 st_2
st_3 st_3
pb_serch pb_serch
cb_change cb_change
gb_1 gb_1
end type
global w_pisq020i w_pisq020i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq020i.create
int iCurrent
call super::create
this.dw_pisq020i=create dw_pisq020i
this.cb_examination=create cb_examination
this.uo_area=create uo_area
this.uo_division=create uo_division
this.sle_date=create sle_date
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.st_2=create st_2
this.st_3=create st_3
this.pb_serch=create pb_serch
this.cb_change=create cb_change
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq020i
this.Control[iCurrent+2]=this.cb_examination
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.sle_date
this.Control[iCurrent+6]=this.sle_suppliercode
this.Control[iCurrent+7]=this.sle_suppliername
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.pb_serch
this.Control[iCurrent+11]=this.cb_change
this.Control[iCurrent+12]=this.gb_1
end on

on w_pisq020i.destroy
call super::destroy
destroy(this.dw_pisq020i)
destroy(this.cb_examination)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.sle_date)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.pb_serch)
destroy(this.cb_change)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq020i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode

// 조회에 필요한 정보를 구한다
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_enactmentdate	= sle_date.Text + '%'
ls_SupplierCode	= sle_suppliercode.Text + '%'

// 트랜잭션을 연결한다
//
dw_pisq020i.SetTransObject(SQLPIS)

// 데이타를 조회한다
//
dw_pisq020i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode, '%')

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq020i, 1, True)	

// 타이머 이벤트를 2분단위로 처리한다
//
timer(120)

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
//	g_s_empno = 'ADMIN' or &
//	g_s_empno = 'admin' THEN
//	//
//ELSE
//	CLOSE(This)
//END IF


end event

event ue_postopen;call super::ue_postopen;
// 권한이 조회만 가능한 사람은 버튼처리 불가
//
cb_change.Enabled			= m_frame.m_action.m_save.Enabled
cb_examination.Enabled	= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
//
dw_pisq020i.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// 승인의뢰 자료를 기본적으로 조회할수 있게 처리를 조회로 넘긴다
//
This.TriggerEvent("ue_retrieve")

end event

event timer;call super::timer;
This.TriggerEvent('ue_retrieve')
end event

event activate;// 트랜잭션을 연결한다
//
dw_pisq020i.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq020i
integer x = 18
integer width = 3598
end type

type dw_pisq020i from u_vi_std_datawindow within w_pisq020i
integer x = 18
integer y = 192
integer width = 4425
integer height = 1696
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_pisq020i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// 처리를 검사기준서 검토처리로 넘겨준다
	//
	cb_examination.TriggerEvent (Clicked!)
END IF
end event

type cb_examination from commandbutton within w_pisq020i
integer x = 4155
integer y = 48
integer width = 439
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기준서 검토"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno
String	ls_SanctionCode, ls_ChargeConsertFlag, ls_SanctionConsertFlag
Long		ll_saverow

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq020i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서검토에 필요한 정보를 구한다
//
ls_AreaCode					= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "SupplierCode")
ls_ItemCode					= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "ItemCode")
ls_StandardRevno			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "StandardRevno")
ls_SanctionCode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "SanctionCode")
ls_ChargeConsertFlag		= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "ChargeConsertFlag")
ls_SanctionConsertFlag	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), "SanctionConsertFlag")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_ItemCode
istr_parms.String_arg[5] = ls_StandardRevno

// 로그인 사번과 작업할 결재자 사번이 같은가를 체크한다
//
IF ls_ChargeConsertFlag = 'Y' AND ls_SanctionConsertFlag	= 'X' THEN		// 결재자 처리건
	IF g_s_empno <> ls_SanctionCode THEN
		MessageBox('확 인', '로그인 사번과 작업할 결재자 사번이 일치하지 않습니다', StopSign!)
		RETURN
	END IF
END IF

// 작업중인 행을 저장한다
//
ll_saverow = dw_pisq020i.GetSelectedRow(0)

// 검사기준서 검토화면 오픈
//
OpenWithParm(w_pisq030u, istr_parms)

// 처리가 완료후 화면의 자료를 다시 표시한다
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq020i.RowCount() THEN
	ll_saverow = dw_pisq020i.RowCount() 
END IF
	
// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq020i, ll_saverow, True)	

end event

type uo_area from u_pisc_select_area within w_pisq020i
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

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
dw_pisq020i.SetTransObject(SQLPIS)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_pisq020i
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
dw_pisq020i.SetTransObject(SQLPIS)

end event

type sle_date from singlelineedit within w_pisq020i
integer x = 1513
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

type sle_suppliercode from singlelineedit within w_pisq020i
integer x = 2267
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

type sle_suppliername from singlelineedit within w_pisq020i
integer x = 2491
integer y = 60
integer width = 750
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

type st_2 from statictext within w_pisq020i
integer x = 1211
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
string text = "제정일자:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq020i
integer x = 1970
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

type pb_serch from picturebutton within w_pisq020i
integer x = 3241
integer y = 52
integer width = 238
integer height = 96
integer taborder = 50
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

type cb_change from commandbutton within w_pisq020i
integer x = 3671
integer y = 48
integer width = 457
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재자 변경"
end type

event clicked;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno
String	ls_areadivision, ls_chargecode, ls_sanction_empname

ls_areacode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'areacode')
ls_divisioncode	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'divisioncode')
ls_suppliercode	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'suppliercode')
ls_itemcode			= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'itemcode')
ls_standardrevno	= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'standardrevno')
ls_areadivision	= ls_areacode + ls_divisioncode
ls_chargecode		= dw_pisq020i.GetItemString(dw_pisq020i.GetSelectedRow(0), 'chargecode')

IF f_checknullorspace(ls_chargecode) = TRUE THEN
	MessageBox('확 인', '미작업건입니다', StopSign!)
	RETURN
END IF

// 로그인 사번과 담당자 사번을 비교한다
//
IF ls_chargecode <> g_s_empno THEN
	MessageBox('확 인', '로그인 사번과 담당자 사번이 틀립니다', StopSign!)
	RETURN
END IF

// 결재자 선택화면 오픈
//
OpenWithParm(w_pisq031u, ls_areadivision)

IF f_checknullorspace(Message.StringParm) = TRUE THEN
	MessageBox('확 인', '선택된 결재자가 없습니다', StopSign!)
	RETURN
END IF

// 결재자 선택화면에서 선택되어져 넘어온 결재자 사번을 테이블에 수정한다
//
UPDATE TQQCSTANDARD  
	SET SANCTIONCODE = RTrim(:Message.StringParm)
 WHERE AREACODE		= :ls_areacode
 	AND DIVISIONCODE	= :ls_divisioncode
 	AND SUPPLIERCODE	= :ls_suppliercode
 	AND ITEMCODE		= :ls_itemcode
 	AND STANDARDREVNO	= :ls_standardrevno
 USING SQLPIS;

// 선택되어져 넘어온 결재자 사번의 명을 구한다
//
SELECT EmpName  
  INTO :ls_sanction_empname
  FROM TMSTEMP  
 WHERE EmpNo = RTrim(:Message.StringParm)
 USING SQLPIS;

dw_pisq020i.SetItem(dw_pisq020i.GetSelectedRow(0), 'sanction_empname', ls_sanction_empname)

end event

type gb_1 from groupbox within w_pisq020i
integer x = 18
integer y = 12
integer width = 4613
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

