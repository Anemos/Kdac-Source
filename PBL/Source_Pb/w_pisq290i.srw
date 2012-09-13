$PBExportHeader$w_pisq290i.srw
$PBExportComments$Containment 불량현황(품번별)
forward
global type w_pisq290i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq290i
end type
type uo_division from u_pisc_select_division within w_pisq290i
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq290i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq290i
end type
type dw_pisq290i_01 from u_vi_std_datawindow within w_pisq290i
end type
type gb_2 from groupbox within w_pisq290i
end type
type cb_badtype from commandbutton within w_pisq290i
end type
type uo_date from u_pisc_date_applydate within w_pisq290i
end type
type st_4 from statictext within w_pisq290i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq290i
end type
end forward

global type w_pisq290i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment 불량현황(품번별)"
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_pisq290i_01 dw_pisq290i_01
gb_2 gb_2
cb_badtype cb_badtype
uo_date uo_date
st_4 st_4
uo_dateto uo_dateto
end type
global w_pisq290i w_pisq290i

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open

end variables

on w_pisq290i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_pisq290i_01=create dw_pisq290i_01
this.gb_2=create gb_2
this.cb_badtype=create cb_badtype
this.uo_date=create uo_date
this.st_4=create st_4
this.uo_dateto=create uo_dateto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_productgroup
this.Control[iCurrent+4]=this.uo_modelgroup
this.Control[iCurrent+5]=this.dw_pisq290i_01
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.cb_badtype
this.Control[iCurrent+8]=this.uo_date
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.uo_dateto
end on

on w_pisq290i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_pisq290i_01)
destroy(this.gb_2)
destroy(this.cb_badtype)
destroy(this.uo_date)
destroy(this.st_4)
destroy(this.uo_dateto)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq290i_01, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto
// 조회조건을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 

ls_datefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_dateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')

IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

// 데이타를 조회한다(검사내역)
//
dw_pisq290i_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq290i_01, 1, True)	


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

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq290i_01.SetTransObject(SQLPIS)

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

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq290i_01.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq290i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq290i
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
dw_pisq290i_01.SetTransObject(SQLPIS)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq290i
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
dw_pisq290i_01.SetTransObject(SQLPIS)

end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq290i
integer x = 1198
integer y = 60
integer taborder = 30
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

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq290i
integer x = 2130
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
//	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_pisq290i_01 from u_vi_std_datawindow within w_pisq290i
integer x = 18
integer y = 300
integer width = 3794
integer height = 2264
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq290i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// 처리를 검사기준서 검토처리로 넘겨준다
	//
	cb_badtype.TriggerEvent (Clicked!)
END IF
end event

type gb_2 from groupbox within w_pisq290i
integer x = 18
integer y = 12
integer width = 3794
integer height = 272
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

type cb_badtype from commandbutton within w_pisq290i
integer x = 3314
integer y = 144
integer width = 448
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "불량유형조희"
end type

event clicked;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto, ls_itemcode
Long		ll_cnt
// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq290i_01.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

// 불량유형조회에 필요한 정보를 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 
IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF
ls_datefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_dateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')
ls_itemcode			= dw_pisq290i_01.GetItemString(dw_pisq290i_01.GetSelectedRow(0), "as_code")
ll_cnt				= dw_pisq290i_01.GetItemNumber(dw_pisq290i_01.GetSelectedRow(0), "as_cnt")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_areacode  	
istr_parms.String_arg[2] = ls_DivisionCode	
istr_parms.String_arg[3] = ls_productgroup	
istr_parms.String_arg[4] = ls_modelgroup	
istr_parms.String_arg[5] = ls_datefm		
istr_parms.String_arg[6] = ls_dateto		
istr_parms.String_arg[7] = ls_itemcode		
istr_parms.long_arg[1]	 = ll_cnt

// 불량유형조회화면 오픈
//
OpenWithParm(w_pisq300i, istr_parms)


end event

type uo_date from u_pisc_date_applydate within w_pisq290i
event destroy ( )
integer x = 55
integer y = 172
integer taborder = 80
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type st_4 from statictext within w_pisq290i
integer x = 722
integer y = 184
integer width = 46
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type uo_dateto from u_pisc_date_applydate_1 within w_pisq290i
event destroy ( )
integer x = 768
integer y = 172
integer taborder = 90
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

