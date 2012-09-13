$PBExportHeader$w_pisq100u.srw
$PBExportComments$검사성적서 판정(간판용)
forward
global type w_pisq100u from w_ipis_sheet01
end type
type dw_pisq100u_detail from u_vi_std_datawindow within w_pisq100u
end type
type dw_pisq100u_head from datawindow within w_pisq100u
end type
type cb_exit from commandbutton within w_pisq100u
end type
type cb_save from commandbutton within w_pisq100u
end type
type dw_pisq100u_kb from datawindow within w_pisq100u
end type
type cb_detailsave from commandbutton within w_pisq100u
end type
type dw_stdev from datawindow within w_pisq100u
end type
type gb_1 from groupbox within w_pisq100u
end type
type gb_2 from groupbox within w_pisq100u
end type
end forward

global type w_pisq100u from w_ipis_sheet01
integer width = 4695
integer height = 2684
string title = ""
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq100u_detail dw_pisq100u_detail
dw_pisq100u_head dw_pisq100u_head
cb_exit cb_exit
cb_save cb_save
dw_pisq100u_kb dw_pisq100u_kb
cb_detailsave cb_detailsave
dw_stdev dw_stdev
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq100u w_pisq100u

type variables

datawindowchild	idwc_supplierlotno
String				is_array_lotno[100], is_revno
Long					il_array_cnt

end variables
forward prototypes
public subroutine wf_xrscalc ()
public function boolean wf_ipgocancel ()
end prototypes

public subroutine wf_xrscalc ();
String	ls_colname
Long		ll_row, ll_cnt, ll_incnt, ll_insrow
Dec		ld_tot, ld_x, ld_r, ld_s, ld_max, ld_min, ld_qcmeasurementx = 0

// 세부내역의 레코드 건수만큼 루프처리
// 
FOR ll_row = 1 to dw_pisq100u_detail.RowCount()
	ld_tot	= 0
	ll_incnt = 0
	ld_max	= 0
	ld_min	= 9999
	
	// 표준편차계산용 데이타윈도우를 리셋한다
	// 
	dw_stdev.ReSet()
	
	FOR ll_cnt = 1 TO 10
		ls_colname = 'qcmeasurementx' + Trim(String(ll_cnt))
		ld_qcmeasurementx = dw_pisq100u_detail.GetItemNumber(ll_row, ls_colname)

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
		dw_pisq100u_detail.SetItem(ll_row, 'qcmeasurementx', 0)
		dw_pisq100u_detail.SetItem(ll_row, 'qcmeasurementr', 0)
		dw_pisq100u_detail.SetItem(ll_row, 'qcmeasurements', 0)
	ELSE
		// 입력된 값이 있는 경우만 값을 계산한다
		//
		ld_x = ld_tot / ll_incnt
		ld_r = ld_max - ld_min
		// X셋트
		//
		dw_pisq100u_detail.SetItem(ll_row, 'qcmeasurementx', ld_x)
		// R셋트
		//
		dw_pisq100u_detail.SetItem(ll_row, 'qcmeasurementr', ld_r)
		// S셋트
		//
		dw_pisq100u_detail.SetItem(ll_row, 'qcmeasurements', dw_stdev.GetItemNumber(1, 'stdev'))
	END IF
NEXT
end subroutine

public function boolean wf_ipgocancel ();
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_DeliveryNo, ls_SupplierLotno 
Long		ll_count

ls_areacode			= istr_parms.String_arg[1]
ls_divisioncode	= istr_parms.String_arg[2]
ls_suppliercode	= istr_parms.String_arg[3]
ls_DeliveryNo		= istr_parms.String_arg[4]
ls_itemcode			= istr_parms.String_arg[5]

ll_count = 0

SELECT count(*)
  INTO :ll_count
  FROM TQQCRESULT A
 WHERE A.AREACODE      = :ls_AreaCode
   AND A.DIVISIONCODE  = :ls_DivisionCode
   AND A.SUPPLIERCODE  = :ls_SupplierCode
   AND A.DELIVERYNO	  = :ls_DeliveryNo
   AND A.ITEMCODE      = :ls_ItemCode
   AND A.DELIVERYDATE  IS NOT NULL 
   AND RTRIM(A.DELIVERYDATE) <> ''
 USING SQLPIS;
 
IF ll_count = 0 THEN
	// 판정처리중 입고취소된 자료 
	//
	RETURN TRUE
ELSE
	// 입고중인 자료
	//
	RETURN FALSE
END IF

end function

on w_pisq100u.create
int iCurrent
call super::create
this.dw_pisq100u_detail=create dw_pisq100u_detail
this.dw_pisq100u_head=create dw_pisq100u_head
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_pisq100u_kb=create dw_pisq100u_kb
this.cb_detailsave=create cb_detailsave
this.dw_stdev=create dw_stdev
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq100u_detail
this.Control[iCurrent+2]=this.dw_pisq100u_head
this.Control[iCurrent+3]=this.cb_exit
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_pisq100u_kb
this.Control[iCurrent+6]=this.cb_detailsave
this.Control[iCurrent+7]=this.dw_stdev
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_pisq100u.destroy
call super::destroy
destroy(this.dw_pisq100u_detail)
destroy(this.dw_pisq100u_head)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_pisq100u_kb)
destroy(this.cb_detailsave)
destroy(this.dw_stdev)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq030u, FULL)
//
//of_resize()
//
end event

event open;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode
String   ls_DeliveryNo, ls_SupplierLotno
Long		ll_idx, ll_rowcnt
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

// 레스폰스 윈도우의 좌표를 재설정한다
//
This.x = 1
This.y = 265

// 레스폰스 윈도우의 타이틀을 재설정한다
//
this.title = 'w_pisq100u(검사성적서 판정(간판용))'

// 트랜잭션을 연결한다
//
dw_pisq100u_head.SetTransObject(SQLPIS)
dw_pisq100u_detail.SetTransObject(SQLPIS)
dw_pisq100u_kb.SetTransObject(SQLPIS)
dw_stdev.SetTransObject(SQLPIS)

ls_areacode			= istr_parms.String_arg[1]
ls_divisioncode	= istr_parms.String_arg[2]
ls_suppliercode	= istr_parms.String_arg[3]
ls_DeliveryNo		= istr_parms.String_arg[4]
ls_itemcode			= istr_parms.String_arg[5]
is_revno          = istr_parms.String_arg[6]

// Child Datawindow 설정(업체LOT NO)
//
dw_pisq100u_head.GetChild ('as_supplierlotno', idwc_supplierlotno)
idwc_supplierlotno.SetTransObject( SQLPIS )

// Child Retrieve
//
idwc_supplierlotno.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode)

// 자료를 조회한다(HEAD)
//
dw_pisq100u_head.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode)

// 자료를 조회한다(DETAIL)
//
ls_SupplierLotno = dw_pisq100u_head.GetItemString(1, 'as_supplierlotno')
ll_rowcnt = dw_pisq100u_detail.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode, ls_SupplierLotno, is_revno)

// 자료를 조회한다(KB)
//
dw_pisq100u_kb.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode)

// 수용수에 따른 간판매수 입력화면은 선별처리시만 필요하므로 화면에 표시하지 않는다
//
dw_pisq100u_kb.Visible = FALSE

// 데이타윈도우에 포커스가 있는 행에 반전표시를 나타낸다(1행)
//
f_SetHighlight(dw_pisq100u_detail, 1, True)	

// 인스턴스로 선언된 어레이 및 어레이 카운터를 초기화한다
//
FOR ll_idx = 1 TO 15
	is_array_lotno[ll_idx] = ''
NEXT
il_array_cnt = 0

// 마이크로 헬프의 내용을 셋트한다
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")

return 0

end event

event closequery;call super::closequery;
// 설정된 메세지를 윈도우 처리메세지에 설정
//
message.powerobjectparm = istr_parms

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq100u
boolean visible = false
integer x = 41
integer y = 2492
integer width = 3602
end type

type dw_pisq100u_detail from u_vi_std_datawindow within w_pisq100u
integer x = 46
integer y = 1340
integer width = 4581
integer height = 1080
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq100u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_pisq100u_head from datawindow within w_pisq100u
integer x = 46
integer y = 264
integer width = 4581
integer height = 1068
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq100u_01"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
String	ls_colname, ls_coldata, ls_supplierlotno
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode
Long		ll_supplierdeliveryqty, ll_Rows, ll_foundrow, ll_lotqty

// Column Name 
//

ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 업체LOT NO가 바뀔때마다 검사성적서 세부내역을 재표시한다
	//
	CASE 'as_supplierlotno'
		// 검사세부내역의 수정여부를 확인한다
		//
		ll_Rows = dw_pisq100u_detail.ModifiedCount()		

		// 검사세부내역을 작업하고 저장 안했을경우
		//
		IF ll_Rows <> 0 THEN
			// 현작업중의 업체로트번호를 구한다
			//
			ls_supplierlotno = dw_pisq100u_detail.GetItemString(1, 'supplierlotno')
			// 차이드 데이타 윈도우에서 현작업중의 로트번호의 행번호를 구한다
			//
			ll_foundrow = idwc_supplierlotno.Find( "supplierlotno = '" + ls_supplierlotno + "'", 1, idwc_supplierlotno.RowCount())
			// 화면의 로트번호를 작업중의 로트번호로 재표시한다
			//
			idwc_supplierlotno.ScrollToRow(ll_foundrow)
			// 메세지를 표시하고 처리를 되돌린다
			//
			MessageBox('확 인', '검사 세부내역을 저장후 다른 LOT NO를 작업하세요')
			RETURN 1
		END IF
		
		// 조회에 필요한 항목을 구한다
		//
		ls_areacode			= This.GetItemString(row, 'a_areacode')
		ls_divisioncode	= This.GetItemString(row, 'a_divisioncode')
		ls_suppliercode	= This.GetItemString(row, 'a_suppliercode')
		ls_DeliveryNo		= This.GetItemString(row, 'a_DeliveryNo')
		ls_itemcode			= This.GetItemString(row, 'a_itemcode')

		// 로트수량을 구한다
		//
		SELECT TOp 1
				 A.lotqty  
		  INTO :ll_lotqty
		  FROM TQQCRESULTDETAIL A  
		 WHERE A.AREACODE			= :ls_areacode
		   AND A.DIVISIONCODE	= :ls_divisioncode
			AND A.SUPPLIERCODE	= :ls_suppliercode			
			AND A.DELIVERYNO		= :ls_DeliveryNo
			AND A.ITEMCODE			= :ls_itemcode
			AND A.SUPPLIERLOTNO	= :ls_coldata
       USING SQLPIS;

		dw_pisq100u_head.SetItem(1, 'as_lotqty', ll_lotqty)
				
		// 자료를 조회한다
		//
		dw_pisq100u_detail.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode, ls_coldata, is_revno)

		// 데이타윈도우에 포커스가 있는 행에 반전표시를 나타낸다(1행)
		//
		f_SetHighlight(dw_pisq100u_detail, 1, True)	

	// 합불판정에 따른 처리를 한다
	//
	CASE 'a_judgeflag'
		// 납품수량을 구한다
		//
		ll_supplierdeliveryqty = This.GetItemNumber(row, 'a_as_supplierdeliveryqty')
		CHOOSE CASE ls_coldata
			// 합격
			//
			CASE '1'
				// 수용수에 따른 간판매수 입력화면 비표시
				//
				dw_pisq100u_kb.Visible = FALSE

				This.SetItem(row, 'a_goodqty', ll_supplierdeliveryqty)
				This.SetItem(row, 'a_badqty' , 0)
			// 불합격
			//
			CASE '2'
				// 수용수에 따른 간판매수 입력화면 비표시
				//
				dw_pisq100u_kb.Visible = FALSE

				This.SetItem(row, 'a_goodqty', 0)
				This.SetItem(row, 'a_badqty' , ll_supplierdeliveryqty)
			// 선별
			//
			CASE '3'
				// 수용수에 따른 간판매수 입력화면 표시
				//
				dw_pisq100u_kb.Visible = TRUE
				dw_pisq100u_kb.SetFocus()

				This.SetItem(row, 'a_goodqty', 0)
				This.SetItem(row, 'a_badqty' , 0)
		END CHOOSE

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event itemerror;
RETURN 1
end event

type cb_exit from commandbutton within w_pisq100u
integer x = 4224
integer y = 56
integer width = 389
integer height = 124
integer taborder = 10
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

type cb_save from commandbutton within w_pisq100u
integer x = 3799
integer y = 56
integer width = 389
integer height = 124
integer taborder = 20
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
Long		ll_save, ll_supplierlotqty, ll_badqty, ll_minute, ll_hh, ll_mm
String	ls_judgeflag, ls_badreason, ls_deliverydatetime, ls_systemdatetime, ls_leadtime

ls_judgeflag		= dw_pisq100u_head.GetItemString(1, 'a_judgeflag')
ls_badreason		= dw_pisq100u_head.GetItemString(1, 'a_badreason')
ll_supplierlotqty	= dw_pisq100u_head.GetItemNumber(1, 'a_supplierlotqty')
ll_badqty			= dw_pisq100u_head.GetItemNumber(1, 'a_badqty')

// 판정중 가입고취소가 되었으면 처리를 중단한다
//
IF wf_ipgocancel() = TRUE THEN
	MessageBox('확 인', '판정중 가입고취소가 발생한 자료이므로 처리할수가 없습니다')
	RETURN
END IF

// LOT수만큼 로트세부내역이 저장되었는지 확인
//
IF ll_supplierlotqty <> il_array_cnt THEN
	MessageBox('확 인', '로트수:' + String(ll_supplierlotqty) + &
				' 검사성적서 검토횟수:' + String(il_array_cnt) + &
				'가 서로틀립니다. 검사성적서를 로트수만큼 검토하세요')
	RETURN
END IF

// 판정여부 확인
//
IF ls_judgeflag = '9' THEN
	MessageBox('확 인', '판정을 한후 저장하세요')
	RETURN
END IF

// 선별시 간판매수 선택 확인
//
IF ls_judgeflag = '3' AND ll_badqty = 0 THEN
	MessageBox('확 인', '선별시는 불량간판 매수를 입력하세요')
	RETURN
END IF

// 불합격, 선별시는 불량사유를 반드시 선택하여야 한다
//
IF ls_judgeflag = '2' or ls_judgeflag = '3' THEN
	IF f_checknullorspace(ls_badreason) = TRUE THEN
		MessageBox('확 인', '불량사유를 반드시 선택하세요')
		RETURN
	END IF
END IF

// 검사판정시 필요한 기본정보를 셋트한다
//
dw_pisq100u_head.SetItem(1, 'a_InspectorCode', g_s_empno)
dw_pisq100u_head.SetItem(1, 'a_confirmflag'	, 'N')
dw_pisq100u_head.SetItem(1, 'a_QCDate'			, String(f_getsysdatetime(), 'yyyy.mm.dd'))
dw_pisq100u_head.SetItem(1, 'a_QCTime'			, String(f_getsysdatetime(), 'hh:mm:ss'))
dw_pisq100u_head.SetItem(1, 'a_lastemp'		, 'Y')

ls_deliverydatetime	= dw_pisq100u_head.GetItemString(1, 'a_deliverydate') + ' ' +&
				  			  dw_pisq100u_head.GetItemString(1, 'a_deliverytime')

ls_systemdatetime		= String(f_getsysdatetime(), 'yyyy.mm.dd') + ' ' +&
							  String(f_getsysdatetime(), 'hh:mm:ss')

// 입고일자와 시스템일자간의 LEAD TIME을구한다(분으로) 
//
SELECT top 1 DATEDIFF(n, :ls_deliverydatetime, :ls_systemdatetime) 
  INTO :ll_minute
  FROM sysusers
 USING SQLPIS;

//// 구한 분으로 시간을 구한다
////
//ll_hh = ll_minute / 60
//// 시간으로 나눈 나머지를 구한다(분)
////
//ll_mm = Mod(ll_minute, 60)
//
//ls_leadtime	= String(ll_hh, '00000') + ':' + String(ll_mm, '00')

ls_leadtime	= String(ll_minute) 

// Lead Time을 셋트
//
dw_pisq100u_head.SetItem(1, 'a_QCLeadTime', ls_leadtime)

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// HEAD정보를 저장한다
//
ll_save = dw_pisq100u_head.Update()

IF ll_save <> 1 THEN
	// RollBack 처리
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// 선별시 불량간판매수 정보를 저장한다
//
ll_save = dw_pisq100u_kb.Update()

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


// 저장이 완료되면 처리를 종료한다
//
//cb_exit.TriggerEvent( Clicked! )


end event

type dw_pisq100u_kb from datawindow within w_pisq100u
integer x = 1490
integer y = 652
integer width = 549
integer height = 336
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq100u_03"
boolean vscrollbar = true
boolean livescroll = true
end type

event losefocus;
Long	ll_receptionqty, ll_kbcount, ll_goodqty, ll_badqty = 0, ll_cnt 
Long	ll_supplierdeliveryqty, ll_tqqcresult_as_kbcount

dw_pisq100u_kb.AcceptText()

FOR ll_cnt = 1 TO dw_pisq100u_kb.RowCount()
	// 수용수/매수를 구한다
	//
	ll_receptionqty = dw_pisq100u_kb.GetItemNumber(ll_cnt, 'receptionqty')
	ll_kbcount		 = dw_pisq100u_kb.GetItemNumber(ll_cnt, 'kbcount')

	// 총간판매수를 구한다
	//
	//ll_tqqcresult_as_kbcount = ll_tqqcresult_as_kbcount + ll_kbcount

	// 불합격수량을 계산한다
	//
	ll_badqty = ll_badqty + (ll_receptionqty * ll_kbcount)
NEXT

// 납품수량을 구한다
//
ll_supplierdeliveryqty = dw_pisq100u_head.GetItemNumber(1, 'a_as_supplierdeliveryqty')

// HEAD에 합격/불합격수량을 셋트한다
//
dw_pisq100u_head.SetItem(1, 'a_goodqty', ll_supplierdeliveryqty - ll_badqty)	// 납품수량 - 불합격수량
dw_pisq100u_head.SetItem(1, 'a_badqty' , ll_badqty)

// HEAD에 불량간판매수를 셋트한다
//
//dw_pisq100u_head.SetItem(1, 'tqqcresult_as_kbcount', ll_tqqcresult_as_kbcount)

end event

type cb_detailsave from commandbutton within w_pisq100u
integer x = 4128
integer y = 1000
integer width = 448
integer height = 288
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "세부내역저장"
end type

event clicked;Int		li_save, li_idx, li_supplierlotqty, li_check
String	ls_judgeflag, ls_badreason, ls_supplierlotno
string ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode, ls_kdacremark

ls_supplierlotno = dw_pisq100u_head.GetItemString(1, 'as_supplierlotno')
li_supplierlotqty = dw_pisq100u_head.GetItemNumber(1, 'a_supplierlotqty')
// 저장시마다 변경된 LOT NO를 ARRAY에 저장한다
//
li_check = 0
FOR li_idx = 1 TO li_supplierlotqty
	IF is_array_lotno[li_idx] = ls_supplierlotno THEN
		li_check = 1
		EXIT
	END IF
NEXT
IF li_check = 0 THEN
	FOR li_idx = 1 TO li_supplierlotqty
		IF f_checknullorspace(is_array_lotno[li_idx]) = TRUE THEN
			is_array_lotno[li_idx] = ls_supplierlotno
			// 저장된 LOT NO를 누적한다
			//
			il_array_cnt ++
			EXIT
		END IF
	NEXT
END IF

// 검사성적서 세부내역의 X,R,S를 계산하여 화면에 표시
//
wf_xrscalc()

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

// 검사성적서 세부내역 정보를 저장한다
//
li_save = dw_pisq100u_detail.Update()

IF li_save <> 1 THEN
	// RollBack 처리
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
	RETURN
END IF

// 검사성적서의 비고내용만을 저장한다 (추가 2003.03.17)
//
ls_AreaCode			= dw_pisq100u_head.GetItemString(1, "a_AreaCode")
ls_DivisionCode	= dw_pisq100u_head.GetItemString(1, "a_DivisionCode")
ls_SupplierCode	= dw_pisq100u_head.GetItemString(1, "a_SupplierCode")
ls_DeliveryNo		= dw_pisq100u_head.GetItemString(1, "a_DeliveryNo")
ls_ItemCode			= dw_pisq100u_head.GetItemString(1, "a_ItemCode")
ls_kdacremark 		= dw_pisq100u_head.GetItemString(1, 'a_kdacremark')

UPDATE TQQCRESULT 
	SET KDACREMARK		= :ls_kdacremark
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND DELIVERYNO		= :ls_DeliveryNo
	AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;

SQLPIS.AUTOCommit = TRUE

// 저장이 완료되면 처리를 종료한다
//
//cb_exit.TriggerEvent( Clicked! )

end event

type dw_stdev from datawindow within w_pisq100u
boolean visible = false
integer x = 1582
integer width = 2181
integer height = 488
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_stdev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq100u
integer x = 14
integer y = 224
integer width = 4645
integer height = 2224
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisq100u
integer x = 3744
integer width = 914
integer height = 216
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

