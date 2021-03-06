$PBExportHeader$w_pisq116i.srw
$PBExportComments$검사성적서 세부내역 현황
forward
global type w_pisq116i from w_ipis_sheet01
end type
type gb_3 from groupbox within w_pisq116i
end type
type dw_pisq116i_01 from datawindow within w_pisq116i
end type
type gb_1 from groupbox within w_pisq116i
end type
type cb_print from commandbutton within w_pisq116i
end type
type cb_exit from commandbutton within w_pisq116i
end type
type cb_save from commandbutton within w_pisq116i
end type
type dw_stdev from datawindow within w_pisq116i
end type
type st_1 from statictext within w_pisq116i
end type
type sle_1 from singlelineedit within w_pisq116i
end type
end forward

global type w_pisq116i from w_ipis_sheet01
integer width = 4663
integer height = 2700
string title = "검사성적서 세부내역 현황"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
gb_3 gb_3
dw_pisq116i_01 dw_pisq116i_01
gb_1 gb_1
cb_print cb_print
cb_exit cb_exit
cb_save cb_save
dw_stdev dw_stdev
st_1 st_1
sle_1 sle_1
end type
global w_pisq116i w_pisq116i

type variables

String	is_areacode, is_divisioncode, is_suppliercode, is_itemcode
String   is_deliveryno, is_revno

end variables

on w_pisq116i.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.dw_pisq116i_01=create dw_pisq116i_01
this.gb_1=create gb_1
this.cb_print=create cb_print
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_stdev=create dw_stdev
this.st_1=create st_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_pisq116i_01
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_exit
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.dw_stdev
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_1
end on

on w_pisq116i.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.dw_pisq116i_01)
destroy(this.gb_1)
destroy(this.cb_print)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_stdev)
destroy(this.st_1)
destroy(this.sle_1)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq040p_head, FULL)
//
//of_resize()
//
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

// 윈도우간의 정보를 스트럭쳐 배열로 받는다
//
istr_parms = message.powerobjectparm

is_areacode			= istr_parms.String_arg[1]
is_divisioncode	= istr_parms.String_arg[2]
is_suppliercode	= istr_parms.String_arg[3]
is_deliveryno		= istr_parms.String_arg[4]
is_itemcode			= istr_parms.String_arg[5]
is_revno          = istr_parms.String_arg[6]

IF istr_parms.String_arg[9] = 'INQ' THEN
	dw_pisq116i_01.DataObject = 'd_pisq116i_01'
	cb_save.Visible = FALSE
ELSE
	dw_pisq116i_01.DataObject = 'd_pisq116i_01_update'
	cb_save.Visible = TRUE
END IF

// 레스폰스 윈도우의 좌표를 재설정한다
//
This.x = 1
This.y = 265

// 레스폰스 윈도우의 타이틀을 재설정한다
//
this.title = 'w_pisq116i(검사성적서 세부내역 현황)'

// 트랜잭션을 연결한다
//
dw_pisq116i_01.SetTransObject(SQLPIS)

// 마이크로 헬프의 내용을 셋트한다
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

event ue_postopen;string ls_remark
// 자료를 조회한다
//
select kdacremark into :ls_remark
from tqqcresult
where areacode = :is_areacode and divisioncode = :is_divisioncode and
      suppliercode = :is_suppliercode and deliveryno = :is_deliveryno and
		itemcode = :is_itemcode using sqlpis;
if sqlpis.sqlcode = 0 then
	sle_1.text = trim(ls_remark)
else
	sle_1.text = ''
end if
dw_pisq116i_01.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_deliveryno, is_itemcode, is_revno)


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq116i
integer x = 41
integer y = 2208
integer width = 3602
end type

type gb_3 from groupbox within w_pisq116i
integer x = 14
integer width = 4626
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
end type

type dw_pisq116i_01 from datawindow within w_pisq116i
integer x = 37
integer y = 236
integer width = 4581
integer height = 2228
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq116i_01_update"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq116i
integer x = 14
integer y = 204
integer width = 4626
integer height = 2284
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_print from commandbutton within w_pisq116i
boolean visible = false
integer x = 2533
integer y = 56
integer width = 389
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출  력"
end type

event clicked;
//dw_pisq040p_01.Print()
//open(w_res_test)
end event

type cb_exit from commandbutton within w_pisq116i
integer x = 4197
integer y = 56
integer width = 389
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종  료"
end type

event clicked;

Close(parent)
end event

type cb_save from commandbutton within w_pisq116i
integer x = 3762
integer y = 56
integer width = 389
integer height = 112
integer taborder = 60
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
String	ls_colname, ls_remark
Long		ll_row, ll_cnt, ll_incnt, ll_insrow, ll_save
Dec		ld_tot, ld_x, ld_r, ld_s, ld_max, ld_min, ld_qcmeasurementx = 0

IF dw_pisq116i_01.AcceptText() <> 1 THEN RETURN

// 세부내역의 레코드 건수만큼 루프처리
// 
FOR ll_row = 1 to dw_pisq116i_01.RowCount()
	ld_tot	= 0
	ll_incnt = 0
	ld_max	= 0
	ld_min	= 9999
	
	// 표준편차계산용 데이타윈도우를 리셋한다
	// 
	dw_stdev.ReSet()
	
	FOR ll_cnt = 1 TO 10
		ls_colname = 'tqqcresultdetail_qcmeasurementx' + Trim(String(ll_cnt))
		ld_qcmeasurementx = dw_pisq116i_01.GetItemNumber(ll_row, ls_colname)

		// 값이 있는것만을 대상으로한다
		//
		IF ld_qcmeasurementx > 0 THEN

			// 표준편차계산용 데이타윈도우에 값을 셋트한다
			// 
			ll_insrow = dw_stdev.InsertRow(0)
			dw_stdev.SetItem(ll_insrow, 'an_stdev', ld_qcmeasurementx)
	
			// MAX를 구한다
			//
			IF ld_max < ld_qcmeasurementx THEN
				ld_max = ld_qcmeasurementx 
			END IF
				
			// MIN을 구한다
			//
			IF ld_min > ld_qcmeasurementx THEN
				ld_min = ld_qcmeasurementx 
			END IF

			// 값이 있는것의 값을 누적
			//
			ld_tot = ld_tot + ld_qcmeasurementx
			// 값이 있는것이 몇개인지 누적
			//
			ll_incnt ++
		END IF
	NEXT

	IF ld_tot = 0 THEN
		// 입력된 값이 전부 0인경우는 초기화한다
		//
		dw_pisq116i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementx', 0)
		dw_pisq116i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementr', 0)
		dw_pisq116i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurements', 0)
	ELSE
		// 입력된 값이 있는 경우만 값을 계산한다
		//
		ld_x = ld_tot / ll_incnt
		ld_r = ld_max - ld_min
		// X셋트
		//
		dw_pisq116i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementx', ld_x)
		// R셋트
		//
		dw_pisq116i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementr', ld_r)
		// S셋트
		//
		dw_pisq116i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurements', dw_stdev.GetItemNumber(1, 'stdev'))
	END IF
NEXT

//kdac remark 저장 -> 로직 추가 (2003.03.24)
ls_remark = trim(sle_1.text)
update tqqcresult
set kdacremark = :ls_remark
where areacode = :is_areacode and divisioncode = :is_divisioncode and
      suppliercode = :is_suppliercode and deliveryno = :is_deliveryno and
		itemcode = :is_itemcode using sqlpis;
		
// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// 수정정보를 저장한다
//
ll_save = dw_pisq116i_01.Update()

IF ll_save = 1 THEN
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
	RETURN
END IF

MessageBox('확 인', '처리가 완료되었습니다')

end event

type dw_stdev from datawindow within w_pisq116i
boolean visible = false
integer x = 2994
integer y = 12
integer width = 741
integer height = 200
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_stdev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_pisq116i
integer x = 119
integer y = 84
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "KDAC비고:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_pisq116i
integer x = 425
integer y = 64
integer width = 2043
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

