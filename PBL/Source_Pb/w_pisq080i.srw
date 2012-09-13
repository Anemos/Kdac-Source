$PBExportHeader$w_pisq080i.srw
$PBExportComments$검사 대기현황(간판용)
forward
global type w_pisq080i from w_ipis_sheet01
end type
type dw_pisq080i from u_vi_std_datawindow within w_pisq080i
end type
type cb_judge from commandbutton within w_pisq080i
end type
type cb_save from commandbutton within w_pisq080i
end type
type uo_area from u_pisc_select_area within w_pisq080i
end type
type uo_division from u_pisc_select_division within w_pisq080i
end type
type st_2 from statictext within w_pisq080i
end type
type sle_date from singlelineedit within w_pisq080i
end type
type st_3 from statictext within w_pisq080i
end type
type sle_suppliercode from singlelineedit within w_pisq080i
end type
type sle_suppliername from singlelineedit within w_pisq080i
end type
type pb_serch from picturebutton within w_pisq080i
end type
type cb_detail from commandbutton within w_pisq080i
end type
type cb_retry from commandbutton within w_pisq080i
end type
type gb_1 from groupbox within w_pisq080i
end type
end forward

global type w_pisq080i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "검사 대기현황(간판용)"
dw_pisq080i dw_pisq080i
cb_judge cb_judge
cb_save cb_save
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_date sle_date
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
pb_serch pb_serch
cb_detail cb_detail
cb_retry cb_retry
gb_1 gb_1
end type
global w_pisq080i w_pisq080i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq080i.create
int iCurrent
call super::create
this.dw_pisq080i=create dw_pisq080i
this.cb_judge=create cb_judge
this.cb_save=create cb_save
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_date=create sle_date
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.pb_serch=create pb_serch
this.cb_detail=create cb_detail
this.cb_retry=create cb_retry
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq080i
this.Control[iCurrent+2]=this.cb_judge
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_date
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.sle_suppliercode
this.Control[iCurrent+10]=this.sle_suppliername
this.Control[iCurrent+11]=this.pb_serch
this.Control[iCurrent+12]=this.cb_detail
this.Control[iCurrent+13]=this.cb_retry
this.Control[iCurrent+14]=this.gb_1
end on

on w_pisq080i.destroy
call super::destroy
destroy(this.dw_pisq080i)
destroy(this.cb_judge)
destroy(this.cb_save)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.pb_serch)
destroy(this.cb_detail)
destroy(this.cb_retry)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq080i, FULL)

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
dw_pisq080i.SetTransObject(SQLPIS)

// 데이타를 조회한다
//
dw_pisq080i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate, ls_SupplierCode, '%')

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq080i, 1, True)	

// 타이머 이벤트를 5분단위로 처리한다
//
timer(300)

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
//
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
//	g_s_empno = '001039' or &		
//	g_s_empno = '851183' or &
//	g_s_empno = '852090' or &
//	g_s_empno = '856042' or &
//	g_s_empno = '856132' or &
//	g_s_empno = '856153' or &
//	g_s_empno = '861019' or &
//	g_s_empno = '866002' or &
//	g_s_empno = '866120' or &
//	g_s_empno = '866477' or &
//	g_s_empno = '876099' or &
//	g_s_empno = '876100' or &
//	g_s_empno = '876108' or &
//	g_s_empno = '876111' or &
//	g_s_empno = '876160' or &
//	g_s_empno = '876400' or &
//	g_s_empno = '876507' or &
//	g_s_empno = '876534' or &
//	g_s_empno = '876543' or &
//	g_s_empno = '876562' or &
//	g_s_empno = '876587' or &
//	g_s_empno = '886080' or &
//	g_s_empno = '923012' or &
//	g_s_empno = '951044' or &
//	g_s_empno = '952201' or &
//	g_s_empno = '961152' or &
//	g_s_empno = '862093' or &
//	g_s_empno = '861403' or &
//	g_s_empno = '871009' or &
//	g_s_empno = '951107' or &
//	g_s_empno = '021036' or &
//	g_s_empno = '961030' or &
//	g_s_empno = '971005' or &
//	g_s_empno = '021023' or &
//	g_s_empno = '010031' or &
//	g_s_empno = '867414' or &
//	g_s_empno = '866351' or &
//	g_s_empno = '956165' or &
//	g_s_empno = '956169' or &
//	g_s_empno = '966269' or &
//	g_s_empno = '976127' or &
//	g_s_empno = '976126' or &
//	g_s_empno = '966216' or &
//	g_s_empno = '976157' or &
//	g_s_empno = '966189' or &
//	g_s_empno = '966280' or &
//	g_s_empno = '876219' or &
//	g_s_empno = '876039' or &
//	g_s_empno = '956123' or &
//	g_s_empno = '956123' or &
//	g_s_empno = '876219' or &
//	g_s_empno = '876039' or &
//	g_s_empno = '867248' or &
//	g_s_empno = '876071' or &
//	g_s_empno = 'ADMIN' or &
//	g_s_empno = 'admin' THEN
//	//
//ELSE
//	CLOSE(This)
//END IF

end event

event ue_postopen;call super::ue_postopen;// 권한이 조회만 가능한 사람은 버튼처리 불가
//
cb_judge.Enabled	= m_frame.m_action.m_save.Enabled
cb_save.Enabled	= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
//
dw_pisq080i.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

// 승인의뢰 자료를 기본적으로 조회할수 있게 처리를 조회로 넘긴다
//
This.TriggerEvent("ue_retrieve")

end event

event timer;call super::timer;
This.TriggerEvent('ue_retrieve')
end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq080i.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq080i
integer x = 18
integer width = 3598
end type

type dw_pisq080i from u_vi_std_datawindow within w_pisq080i
integer x = 18
integer y = 200
integer width = 3589
integer height = 1688
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq080i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// 처리를 검사성적서 판정처리로 넘겨준다
	//
	cb_judge.TriggerEvent (Clicked!)
END IF
end event

event retrieveend;call super::retrieveend;
Long		ll_idx
String	ls_datetime, ls_flag
DateTime	ldt_sysdatetime

// 4시간이 지난 자료는 적색으로 표시한다
//
FOR ll_idx = 1 TO rowcount
	// 시스템 일시를 구한다
	//
	ldt_sysdatetime = f_getsysdatetime()
	// 납품일시를 구한다
	//
	ls_datetime		 = dw_pisq080i.GetItemString(ll_idx, 'deliverydate') + ' ' +&
					  		dw_pisq080i.GetItemString(ll_idx, 'deliverytime')
	
	// 4시간 경과된 자료를 계산한다
	//
	SELECT top 1 CASE WHEN DATEADD(hh, +4, :ls_datetime) < :ldt_sysdatetime THEN 'Y' ELSE 'N' END 
	  INTO :ls_flag
	  FROM sysusers
	  USING SQLPIS;

	// 4시간 경과된 자료는 FLAG에 'Y'를 셋트하고 셋트된 자료를 가지고 데이타윈도우에서 
	// 해당 자료를 적색으로 바꾸고 깜박거리게 한다
	//
	IF ls_flag = 'Y' THEN
  		dw_pisq080i.SetItem(ll_idx, 'as_flag', 'Y')
	ELSE
  		dw_pisq080i.SetItem(ll_idx, 'as_flag', 'N')
	END IF
NEXT
end event

type cb_judge from commandbutton within w_pisq080i
integer x = 3241
integer y = 48
integer width = 357
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "성적서판정"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode
String   ls_DeliveryNo, ls_judgeflag, ls_revno
Long		ll_saverow

uo_status.st_message.text = ""
// 작업대상이 없으면 처리를 하지 않는다
//
IF i_s_level = "1" then
	uo_status.st_message.text = '판정권한이 없습니다. 확인바랍니다.'
	return 0
END IF
IF dw_pisq080i.GetSelectedRow(0) = 0 THEN
	//MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	uo_status.st_message.text = '작업대상이 없습니다'
	RETURN 0
END IF

// 판정이 끝난건은 처리를 하지 않는다
//
ls_judgeflag = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "judgeflag")
IF ls_judgeflag <> '9' THEN
	//MessageBox('확 인', '판정이 끝난건은 재판정 할수 없습니다~n확인작업을 하시기 바랍니다', StopSign!)
	uo_status.st_message.text = '판정이 끝난건은 재판정 할수 없습니다. 확인작업을 하시기 바랍니다'
	RETURN 0
END IF

// 성적서 판정에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "SupplierCode")
ls_ItemCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "ItemCode")
ls_DeliveryNo		= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "DeliveryNo")
ls_revno          = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "StandardRevno")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_DeliveryNo
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno

// 작업행을 저장한다
//
ll_saverow = dw_pisq080i.GetSelectedRow(0)

// 검사기준서 검토화면 오픈
//
OpenWithParm(w_pisq100u, istr_parms)

// 처리가 완료후 화면의 자료를 다시 표시한다
//
Parent.TriggerEvent("ue_retrieve")

IF ll_saverow > dw_pisq080i.RowCount() THEN
	ll_saverow = dw_pisq080i.RowCount()
END IF

// 데이타윈도우에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq080i, ll_saverow, True)	

end event

type cb_save from commandbutton within w_pisq080i
integer x = 3977
integer y = 48
integer width = 306
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
end type

event clicked;

String	ls_ConfirmFlag, ls_AreaCode, ls_DivisionCode, ls_SupplierCode
String	ls_DeliveryNo , ls_ItemCode, ls_judgeflag
Long		ll_low

uo_status.st_message.text = ""

IF i_s_level = "1" then
	uo_status.st_message.text = '판정권한이 없습니다. 확인바랍니다.'
	return 0
END IF

dw_pisq080i.AcceptText()

FOR ll_low = 1 TO dw_pisq080i.RowCount()
	ls_judgeflag 	= dw_pisq080i.GetItemString(ll_low, "judgeflag")
	ls_ConfirmFlag = dw_pisq080i.GetItemString(ll_low, 'ConfirmFlag')

	IF ls_ConfirmFlag = 'Y' THEN
		// 판정이 끝난건은 처리를 하지 않는다
		//
		ls_AreaCode			= dw_pisq080i.GetItemString(ll_low, "AreaCode")
		ls_DivisionCode	= dw_pisq080i.GetItemString(ll_low, "DivisionCode")
		ls_SupplierCode	= dw_pisq080i.GetItemString(ll_low, "SupplierCode")
		ls_DeliveryNo		= dw_pisq080i.GetItemString(ll_low, "DeliveryNo")
		ls_ItemCode			= dw_pisq080i.GetItemString(ll_low, "ItemCode")
		
		SELECT JUDGEFLAG INTO :ls_judgeflag FROM TQQCRESULT 
       WHERE AREACODE		= :ls_AreaCode
         AND DIVISIONCODE	= :ls_DivisionCode
         AND SUPPLIERCODE	= :ls_SupplierCode
         AND DELIVERYNO		= :ls_DeliveryNo
         AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;
		
		IF SQLPIS.SQLCODE <> 0 OR ls_judgeflag = '9' THEN
			MessageBox('확 인', String(ll_low) + '번행의 미판정건은 확인 작업을 할수없습니다', StopSign!)
			CONTINUE
		END IF

		UPDATE TQQCRESULT 
         SET CONFIRMFLAG   = 'Y'  ,
				 CONFIRMCODE   = :g_s_empno
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
	END IF
NEXT

// 처리가 완료후 화면의 자료를 다시 표시한다
//
Parent.TriggerEvent("ue_retrieve")

end event

type uo_area from u_pisc_select_area within w_pisq080i
integer x = 37
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
dw_pisq080i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq080i
event destroy ( )
integer x = 530
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
dw_pisq080i.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq080i
integer x = 1083
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

type sle_date from singlelineedit within w_pisq080i
integer x = 1376
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

type st_3 from statictext within w_pisq080i
integer x = 1769
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

type sle_suppliercode from singlelineedit within w_pisq080i
integer x = 2066
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

type sle_suppliername from singlelineedit within w_pisq080i
integer x = 2295
integer y = 60
integer width = 690
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

type pb_serch from picturebutton within w_pisq080i
integer x = 2985
integer y = 44
integer width = 238
integer height = 108
integer taborder = 60
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

type cb_detail from commandbutton within w_pisq080i
integer x = 3621
integer y = 48
integer width = 334
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사내역"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_Deliveryno
String   ls_ItemCode, ls_judgeflag, ls_revno

uo_status.st_message.text = ""
// 출력대상이 없으면 처리를 하지 않는다
//
IF dw_pisq080i.GetSelectedRow(0) = 0 THEN
	//MessageBox('확 인', '검사내역 대상이 없습니다', StopSign!)
	uo_status.st_message.text = '검사내역 대상이 없습니다'
	RETURN 0
END IF

// 판정이 끝난건만 처리한다
//
ls_judgeflag = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "judgeflag")
IF ls_judgeflag = '9' THEN
	//MessageBox('확 인', '판정이 끝난건만을 조회할수 있습니다.', StopSign!)
	uo_status.st_message.text = '판정이 끝난건만을 조회할수 있습니다.'
	RETURN 0
END IF

// 기준서출력에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "SupplierCode")
ls_Deliveryno		= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "Deliveryno")
ls_ItemCode			= dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "ItemCode")
ls_revno          = dw_pisq080i.GetItemString(dw_pisq080i.GetSelectedRow(0), "StandardRevno")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_Deliveryno
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno
istr_parms.String_arg[9] = 'INQ'

// 검사성적서 세부내역 화면 오픈
//
OpenWithParm(w_pisq116i, istr_parms)

end event

type cb_retry from commandbutton within w_pisq080i
integer x = 4302
integer y = 48
integer width = 306
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "재판정"
end type

event clicked;long ll_selrow, ll_rtn
string ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode
string ls_judgeflag, ls_status

uo_status.st_message.text = ""
ll_selrow = dw_pisq080i.getselectedrow(0)

IF i_s_level = "1" then
	uo_status.st_message.text = '판정권한이 없습니다. 확인바랍니다.'
	return 0
END IF

if ll_selrow < 1 then
	uo_status.st_message.text = "재판정할 품번을 선택하십시요"
	return 0
end if

ls_AreaCode			= dw_pisq080i.GetItemString(ll_selrow, "AreaCode")
ls_DivisionCode	= dw_pisq080i.GetItemString(ll_selrow, "DivisionCode")
ls_SupplierCode	= dw_pisq080i.GetItemString(ll_selrow, "SupplierCode")
ls_ItemCode			= dw_pisq080i.GetItemString(ll_selrow, "ItemCode")
ls_DeliveryNo		= dw_pisq080i.GetItemString(ll_selrow, "DeliveryNo")
ls_judgeflag 		= dw_pisq080i.GetItemString(ll_selrow, "judgeflag")

//판정여부 확인
if ls_judgeflag = '9' then
	uo_status.st_message.text = "미판정 상태입니다."
	return 0
end if

//해당납품번호의 해당품번의 간판이 가입고 상태여부확인
  SELECT COUNT(*)
  		INTO :ll_rtn 
    	FROM TPARTKBSTATUS  
   	WHERE ( TPARTKBSTATUS.AreaCode = :ls_areacode ) AND  
         	( TPARTKBSTATUS.DivisionCode = :ls_divisioncode ) AND  
         	( TPARTKBSTATUS.SupplierCode = :ls_suppliercode ) AND  
         	( TPARTKBSTATUS.ItemCode = :ls_itemcode ) AND  
         	( TPARTKBSTATUS.DeliveryNo = :ls_deliveryno ) AND
				( TPARTKBSTATUS.PartKBStatus = 'B' )
		using sqlpis;
		
if sqlpis.sqlcode <> 0 or ll_rtn < 1 then
	uo_status.st_message.text = "입고 또는 발주대기상태입니다. 재판정 할 수 없습니다."
	return 0
end if

// 확인 여부체크
SELECT CONFIRMFLAG INTO :ls_status
FROM TQQCRESULT  
   WHERE ( TQQCRESULT.AREACODE = :ls_areacode ) AND  
         ( TQQCRESULT.DIVISIONCODE = :ls_divisioncode ) AND  
         ( TQQCRESULT.SUPPLIERCODE = :ls_suppliercode ) AND  
         ( TQQCRESULT.DELIVERYNO = :ls_deliveryno ) AND  
         ( TQQCRESULT.ITEMCODE = :ls_itemcode )   
   using sqlpis;
if ls_status = 'Y' then
	uo_status.st_message.text = "확인이 완료된 검사성적서 입니다."
	return 0
end if
//해당검사성적서 미판정으로 셋팅
  UPDATE TQQCRESULT  
  	SET JUDGEFLAG = '9',   
         GOODQTY = 0,   
         BADQTY = 0,   
         BADREASON = ' ',   
         BADMEMO = ' ',   
         INSPECTORCODE = ' ',   
         CONFIRMCODE = ' ',   
         CONFIRMFLAG = 'N',   
         QCDATE = null  
   WHERE ( TQQCRESULT.AREACODE = :ls_areacode ) AND  
         ( TQQCRESULT.DIVISIONCODE = :ls_divisioncode ) AND  
         ( TQQCRESULT.SUPPLIERCODE = :ls_suppliercode ) AND  
         ( TQQCRESULT.DELIVERYNO = :ls_deliveryno ) AND  
         ( TQQCRESULT.ITEMCODE = :ls_itemcode )   
   using sqlpis;
	
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "데이타베이스 에러 : 시스템개발로 연락바랍니다."
else
	uo_status.st_message.text = "미판정상태로 초기화 되었습니다."
end if

return 0





end event

type gb_1 from groupbox within w_pisq080i
integer x = 18
integer y = 12
integer width = 4613
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

