$PBExportHeader$w_pisq120i.srw
$PBExportComments$선별현황 및 납품표출력
forward
global type w_pisq120i from w_ipis_sheet01
end type
type dw_pisq120i from u_vi_std_datawindow within w_pisq120i
end type
type cb_print from commandbutton within w_pisq120i
end type
type dw_print from datawindow within w_pisq120i
end type
type uo_area from u_pisc_select_area within w_pisq120i
end type
type uo_division from u_pisc_select_division within w_pisq120i
end type
type st_2 from statictext within w_pisq120i
end type
type sle_date from singlelineedit within w_pisq120i
end type
type st_3 from statictext within w_pisq120i
end type
type sle_suppliercode from singlelineedit within w_pisq120i
end type
type sle_suppliername from singlelineedit within w_pisq120i
end type
type cbx_reprint from checkbox within w_pisq120i
end type
type pb_serch from picturebutton within w_pisq120i
end type
type gb_1 from groupbox within w_pisq120i
end type
end forward

global type w_pisq120i from w_ipis_sheet01
integer width = 4699
integer height = 2136
string title = "선별현황 및 납품표출력"
dw_pisq120i dw_pisq120i
cb_print cb_print
dw_print dw_print
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_date sle_date
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
cbx_reprint cbx_reprint
pb_serch pb_serch
gb_1 gb_1
end type
global w_pisq120i w_pisq120i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq120i.create
int iCurrent
call super::create
this.dw_pisq120i=create dw_pisq120i
this.cb_print=create cb_print
this.dw_print=create dw_print
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_date=create sle_date
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.cbx_reprint=create cbx_reprint
this.pb_serch=create pb_serch
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq120i
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_date
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.sle_suppliercode
this.Control[iCurrent+10]=this.sle_suppliername
this.Control[iCurrent+11]=this.cbx_reprint
this.Control[iCurrent+12]=this.pb_serch
this.Control[iCurrent+13]=this.gb_1
end on

on w_pisq120i.destroy
call super::destroy
destroy(this.dw_pisq120i)
destroy(this.cb_print)
destroy(this.dw_print)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.cbx_reprint)
destroy(this.pb_serch)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq120i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_DeliveryDate, ls_PrintFlag

// 조회에 필요한 정보를 구한다
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_SupplierCode	= sle_suppliercode.Text + '%'
ls_ItemCode			= '%'
ls_DeliveryDate	= sle_date.Text + '%'

IF cbx_reprint.Checked = TRUE THEN
	ls_PrintFlag	= '%'
ELSE
	ls_PrintFlag	= 'N'
END IF

// 데이타를 조회한다
//
dw_pisq120i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_DeliveryDate, ls_SupplierCode, ls_ItemCode, ls_PrintFlag)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq120i, 1, True)	


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
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

end event

event ue_print;call super::ue_print;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq120i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

IF dw_pisq120i.AcceptText() <> 1 THEN RETURN

// 납품표 출력에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "SupplierCode")
ls_DeliveryNo		= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "DeliveryNo")
ls_ItemCode			= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "ItemCode")

ls_PrintFlag		= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "PrintFlag")
ls_RePrint			= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "as_RePrint")

// 출력여부를 확인한다(재발행이 체크가 안된 출력건은 출력할수없다)
// 
IF ls_PrintFlag = 'Y' AND ls_RePrint = 'N' THEN
	MessageBox('확 인', '기출력 자료입니다~r~n재출력 하시려면 재발행을 체크후 출력해주세요', StopSign!)
	RETURN
END IF

// 출력자료를 표시한다
//
dw_print.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode)


//dw_print.modify("t_3.text   	= '" + ls_DeliveryNo + "'")

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ls_trans	= SQLPIS

// 인쇄 DataWindow 저장
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"납품표 출력"
lstr_prt.tag			= 	This.ClassName()
//lstr_prt.dwsyntax = "t_3.text   	= '" + ls_DeliveryNo + "'"

f_close_report("2", lstr_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

UPDATE TQQCRESULT 
	SET PRINTFLAG		= 'Y'  
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND DELIVERYNO		= :ls_DeliveryNo
	AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

IF SQLPIS.SQLCode = 0 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF

// 처리가 완료후 화면의 자료를 다시 표시한다
//
This.TriggerEvent("ue_retrieve")

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq120i
integer x = 18
integer width = 3598
end type

type dw_pisq120i from u_vi_std_datawindow within w_pisq120i
integer x = 18
integer y = 196
integer width = 3589
integer height = 1692
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pisq120i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// 처리를 납품표 출력처리로 넘겨준다
	//
	cb_print.TriggerEvent (Clicked!)
END IF
end event

type cb_print from commandbutton within w_pisq120i
integer x = 4187
integer y = 44
integer width = 407
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "화면출력"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq120i.RowCount() = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

IF dw_pisq120i.AcceptText() <> 1 THEN RETURN

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ls_trans	= SQLPIS

// 인쇄 DataWindow 저장
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_pisq120i
lstr_prt.title			= 	"선별현황 출력"
lstr_prt.tag			= 	Parent.ClassName()

f_close_report("2", lstr_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

type dw_print from datawindow within w_pisq120i
boolean visible = false
integer x = 41
integer y = 268
integer width = 2414
integer height = 1480
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq120i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_area from u_pisc_select_area within w_pisq120i
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
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq120i
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
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq120i
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

type sle_date from singlelineedit within w_pisq120i
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

type st_3 from statictext within w_pisq120i
integer x = 1902
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

type sle_suppliercode from singlelineedit within w_pisq120i
integer x = 2199
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

type sle_suppliername from singlelineedit within w_pisq120i
integer x = 2427
integer y = 60
integer width = 718
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

type cbx_reprint from checkbox within w_pisq120i
integer x = 3552
integer y = 64
integer width = 448
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "출력건포함:"
boolean lefttext = true
end type

type pb_serch from picturebutton within w_pisq120i
integer x = 3145
integer y = 48
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

type gb_1 from groupbox within w_pisq120i
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
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

