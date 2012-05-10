$PBExportHeader$w_pisq041u.srw
$PBExportComments$검사기준서 이동 ( 업체변경 )
forward
global type w_pisq041u from w_ipis_sheet01
end type
type dw_pisq041u_left from u_vi_std_datawindow within w_pisq041u
end type
type dw_pisq041u_right from u_vi_std_datawindow within w_pisq041u
end type
type pb_move from picturebutton within w_pisq041u
end type
type pb_del from picturebutton within w_pisq041u
end type
type uo_area from u_pisc_select_area within w_pisq041u
end type
type uo_division from u_pisc_select_division within w_pisq041u
end type
type st_2 from statictext within w_pisq041u
end type
type st_3 from statictext within w_pisq041u
end type
type st_rightcnt from statictext within w_pisq041u
end type
type dw_print from datawindow within w_pisq041u
end type
type dw_print1 from datawindow within w_pisq041u
end type
type gb_2 from groupbox within w_pisq041u
end type
type st_leftcnt from statictext within w_pisq041u
end type
type st_4 from statictext within w_pisq041u
end type
type sle_suppliercode from singlelineedit within w_pisq041u
end type
type sle_suppliername from singlelineedit within w_pisq041u
end type
type pb_1 from picturebutton within w_pisq041u
end type
type st_5 from statictext within w_pisq041u
end type
type sle_modifycode from singlelineedit within w_pisq041u
end type
type sle_modifyname from singlelineedit within w_pisq041u
end type
type pb_2 from picturebutton within w_pisq041u
end type
type st_6 from statictext within w_pisq041u
end type
type st_7 from statictext within w_pisq041u
end type
type st_8 from statictext within w_pisq041u
end type
type gb_1 from groupbox within w_pisq041u
end type
end forward

global type w_pisq041u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "검사기준서이동(업체변경)"
dw_pisq041u_left dw_pisq041u_left
dw_pisq041u_right dw_pisq041u_right
pb_move pb_move
pb_del pb_del
uo_area uo_area
uo_division uo_division
st_2 st_2
st_3 st_3
st_rightcnt st_rightcnt
dw_print dw_print
dw_print1 dw_print1
gb_2 gb_2
st_leftcnt st_leftcnt
st_4 st_4
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
pb_1 pb_1
st_5 st_5
sle_modifycode sle_modifycode
sle_modifyname sle_modifyname
pb_2 pb_2
st_6 st_6
st_7 st_7
st_8 st_8
gb_1 gb_1
end type
global w_pisq041u w_pisq041u

type variables
str_pisr_partkb istr_partkb
boolean ib_open

end variables

on w_pisq041u.create
int iCurrent
call super::create
this.dw_pisq041u_left=create dw_pisq041u_left
this.dw_pisq041u_right=create dw_pisq041u_right
this.pb_move=create pb_move
this.pb_del=create pb_del
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.st_3=create st_3
this.st_rightcnt=create st_rightcnt
this.dw_print=create dw_print
this.dw_print1=create dw_print1
this.gb_2=create gb_2
this.st_leftcnt=create st_leftcnt
this.st_4=create st_4
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.pb_1=create pb_1
this.st_5=create st_5
this.sle_modifycode=create sle_modifycode
this.sle_modifyname=create sle_modifyname
this.pb_2=create pb_2
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq041u_left
this.Control[iCurrent+2]=this.dw_pisq041u_right
this.Control[iCurrent+3]=this.pb_move
this.Control[iCurrent+4]=this.pb_del
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_rightcnt
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.dw_print1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.st_leftcnt
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.sle_suppliercode
this.Control[iCurrent+16]=this.sle_suppliername
this.Control[iCurrent+17]=this.pb_1
this.Control[iCurrent+18]=this.st_5
this.Control[iCurrent+19]=this.sle_modifycode
this.Control[iCurrent+20]=this.sle_modifyname
this.Control[iCurrent+21]=this.pb_2
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.st_7
this.Control[iCurrent+24]=this.st_8
this.Control[iCurrent+25]=this.gb_1
end on

on w_pisq041u.destroy
call super::destroy
destroy(this.dw_pisq041u_left)
destroy(this.dw_pisq041u_right)
destroy(this.pb_move)
destroy(this.pb_del)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_rightcnt)
destroy(this.dw_print)
destroy(this.dw_print1)
destroy(this.gb_2)
destroy(this.st_leftcnt)
destroy(this.st_4)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.pb_1)
destroy(this.st_5)
destroy(this.sle_modifycode)
destroy(this.sle_modifyname)
destroy(this.pb_2)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.gb_1)
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
String	ls_areacode, ls_DivisionCode, ls_currentdate, ls_suppliercode, ls_xstop
String   ls_modifycode, ls_chkcode

// 조회조건을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_suppliercode	= trim(sle_suppliercode.text)
ls_modifycode	= trim(sle_modifycode.text)

ls_currentdate = string(f_getsysdatetime(),'YYYY.MM.DD')

dw_pisq041u_left.ReSet()
dw_pisq041u_right.ReSet()

if f_spacechk(ls_suppliercode) = -1 then
	uo_status.st_message.text = "알림 : 기존업체 와 변경업체를 입력하시기 바랍니다."
	return 0
end if

//select ISNULL(TMSTSUPPLIER.Xstop,'')   into :ls_xstop
//from tmstsupplier
//where suppliercode = :ls_suppliercode using sqlpis;
//
//if f_spacechk(ls_xstop) = -1 or ls_xstop <> 'X' then
//	uo_status.st_message.text = "알림 : 기존업체가 존재하지 않거나 외주기획에서 중단한 업체가 아닙니다."
//	return 0
//end if

select ISNULL(Xstop,'')  , suppliercode into :ls_xstop, :ls_chkcode
from tmstsupplier
where suppliercode = :ls_modifycode using sqlpis;

//if f_spacechk(ls_chkcode) = -1 or ls_xstop = 'X' then
//	uo_status.st_message.text = "알림 : 변경업체가 존재하지 않거나 거래중단된 업체입니다."
//	return 0
//end if
// 데이타를 조회한다(좌측화면)

dw_pisq041u_left.Retrieve(ls_areacode, ls_DivisionCode, ls_suppliercode)

// 데이타를 조회한다(우측화면)
//
dw_pisq041u_right.Retrieve(ls_areacode, ls_DivisionCode, ls_modifycode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq041u_left, 1, True)	
f_SetHighlight(dw_pisq041u_right, 1, True)	


end event

event ue_postopen;
// 권한이 조회만 가능한 사람은 버튼처리 불가
//
pb_move.Enabled	= m_frame.m_action.m_save.Enabled
pb_del.Enabled		= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
//
dw_pisq041u_left.SetTransObject(SQLPIS)
dw_pisq041u_right.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
ib_open = True

end event

event ue_save;Long		ll_save, ll_row
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_chkrevno
String 	ls_itemcode, ls_modifycode, ls_chkcode

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

FOR ll_row = 1 TO dw_pisq041u_right.RowCount()
	ls_chkcode = dw_pisq041u_right.getitemstring(ll_row,'DEL_CHK')
	if ls_chkcode <> 'A' then
		continue
	end if
	
	ls_areacode = dw_pisq041u_right.getitemstring( ll_row, 'AS_AREACODE')
	ls_divisioncode = dw_pisq041u_right.getitemstring( ll_row, 'AS_DIVISIONCODE')
	ls_itemcode = dw_pisq041u_right.getitemstring( ll_row, 'AS_ITEMCODE')
	ls_suppliercode = dw_pisq041u_right.getitemstring( ll_row, 'AS_CHKSUPPLIERCODE')
	ls_chkrevno = dw_pisq041u_right.getitemstring( ll_row, 'AS_CHKREVNO')
	ls_modifycode = dw_pisq041u_right.getitemstring( ll_row, 'AS_SUPPLIERCODE')
	
	DECLARE up_pisq041u_02 PROCEDURE FOR sp_pisq041u_02  
         @ps_areacode = :ls_areacode,   
         @ps_divisioncode = :ls_divisioncode,   
         @ps_suppliercode = :ls_suppliercode,   
         @ps_itemcode = :ls_itemcode,   
         @ps_standardrevno = :ls_chkrevno,   
         @ps_modifycode = :ls_modifycode,   
         @ps_empcode = :g_s_empno  using sqlpis;

	Execute up_pisq041u_02;
	
	if sqlpis.sqlcode < 0 then
		RollBack using SQLPIS ;
		SQLPIS.AUTOCommit = TRUE
		uo_status.st_message.text = " ERROR : 처리에 실패했습니다."
		return 0
	end if
NEXT

// Commit 처리
//
COMMIT USING SQLPIS ;
SQLPIS.AUTOCommit = TRUE
uo_status.st_message.text = "정상적으로 저장되었습니다."

// 데이타를 조회한다
//
This.TriggerEvent('ue_retrieve')

end event

event activate;call super::activate;
dw_pisq041u_left.SetTransObject(SQLPIS)
dw_pisq041u_right.SetTransObject(SQLPIS)

end event

event ue_print;call super::ue_print;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint
long		ll_rtn

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq041u_right.RowCount() = 0 THEN
	MessageBox('확 인', '출력대상이 없습니다', StopSign!)
	RETURN
END IF

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ll_rtn = MessageBox('확 인', '출력대상을 선택해 주세요.~r~n 예(Y)면 무검사성적서 관리품목 출력, 아니오(N)는 유검사품 출력입니다', &
							Exclamation!, YesNo!, 1)

IF ll_rtn = 1 THEN
	dw_pisq041u_right.ShareData(dw_print)
	lstr_prt.datawindow	= 	dw_print
ELSE
	dw_pisq041u_left.ShareData(dw_print1)
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

type uo_status from w_ipis_sheet01`uo_status within w_pisq041u
integer x = 18
integer y = 2592
integer width = 3598
end type

type dw_pisq041u_left from u_vi_std_datawindow within w_pisq041u
integer x = 41
integer y = 444
integer width = 2094
integer height = 2108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq041u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;
st_leftcnt.Text = String(rowcount, '#,###')
end event

type dw_pisq041u_right from u_vi_std_datawindow within w_pisq041u
integer x = 2514
integer y = 444
integer width = 2085
integer height = 2108
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisq041u_01"
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

dw_pisq041u_right.SetItem(row, 'LASTEMP'		, g_s_empno)
dw_pisq041u_right.SetItem(row, 'LASTDATE'		, f_getsysdatetime())
CHOOSE CASE ls_colname
	// 적용일자
	//
	CASE "applydatefrom"
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '적용일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			dw_pisq041u_right.setitem(row,ls_colname, String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
			RETURN 1
		END IF	
		
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '적용일자를 정확히 입력하시요', StopSign!)
			dw_pisq041u_right.setitem(row,ls_colname, String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
			RETURN 1
		END IF

		IF Date(ls_coldata) < Date(f_getsysdatetime()) THEN
			MessageBox('확 인', '적용일자는 작업일보다 커야합니다', StopSign!)
			dw_pisq041u_right.setitem(row,ls_colname, String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
			RETURN 1
		END IF
	// 종료일자
	//
	CASE "applydateto"
		ls_fromdt = This.getitemstring(row, 'applydatefrom')
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '종료일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			dw_pisq041u_right.SetItem(row, ls_colname, '2999.12.31')
			RETURN 1
		END IF	

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '종료일자를 정확히 입력하시요', StopSign!)
			dw_pisq041u_right.SetItem(row, ls_colname, '2999.12.31')
			RETURN 1
		END IF
		
		IF ls_coldata <= ls_fromdt THEN
			MessageBox('확 인', '완료일자는 적용일자보다 커야합니다.', StopSign!)
			dw_pisq041u_right.SetItem(row, ls_colname, '2999.12.31')
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

type pb_move from picturebutton within w_pisq041u
integer x = 2203
integer y = 1044
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
string picturename = "C:\kdac\bmp\userright.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long	ll_SaveRow[] 
string ls_modifycode
// 선택된 행이 있는지 체크한다
//
ls_modifycode = sle_modifycode.text
ll_row = dw_pisq041u_left.GetSelectedRow(0)
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
		ll_row = dw_pisq041u_left.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	//
	ll_LastRow = dw_pisq041u_right.InsertRow(0)
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_AREACODE', dw_pisq041u_left.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_DIVISIONCODE', dw_pisq041u_left.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_SUPPLIERCODE', ls_modifycode )
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_ITEMCODE', dw_pisq041u_left.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMCODE'))
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_ITEMNAME', dw_pisq041u_left.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMNAME'))
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_STANDARDREVNO', '00' )
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_CHKREVNO', dw_pisq041u_left.GetitemString(ll_SaveRow[ll_row], 'AS_STANDARDREVNO'))
	dw_pisq041u_right.SetItem(ll_LastRow, 'AS_CHKSUPPLIERCODE', dw_pisq041u_left.GetitemString(ll_SaveRow[ll_row], 'AS_CHKSUPPLIERCODE'))
	dw_pisq041u_right.SetItem(ll_LastRow, 'DEL_CHK', 'A')
	// 좌측화면의 선택된행에 삭제표시를 셋트한다
	dw_pisq041u_left.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq041u_left.GetSelectedRow(0)

// 이동이 끝난 좌측화면의 선택행은 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisq041u_left.RowCount() to 1 step -1
	IF dw_pisq041u_left.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq041u_left.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq041u_left.RowCount() THEN
	f_SetHighlight(dw_pisq041u_left, dw_pisq041u_left.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq041u_left, ll_select_row, True)	
END IF

f_sethighlight(dw_pisq041u_right,dw_pisq041u_right.RowCount(),TRUE)


end event

type pb_del from picturebutton within w_pisq041u
integer x = 2208
integer y = 1532
integer width = 261
integer height = 188
integer taborder = 60
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
string ls_suppliercode, ls_chk

// 선택된 행이 있는지 체크한다
//
ls_suppliercode = sle_suppliercode.text
ll_row = dw_pisq041u_right.GetSelectedRow(0)
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
		ll_row = dw_pisq041u_right.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	//
	ls_chk = dw_pisq041u_right.getitemstring(ll_SaveRow[ll_row], 'DEL_CHK')
	if ls_chk = 'S' then
		Messagebox("경고", "이동할수 없는 검사기준서 입니다.")
		continue
	end if
	ll_LastRow = dw_pisq041u_left.InsertRow(0)
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_AREACODE', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_DIVISIONCODE', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_SUPPLIERCODE', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_CHKSUPPLIERCODE') )
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_ITEMCODE', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMCODE'))
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_ITEMNAME', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMNAME'))
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_STANDARDREVNO', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_CHKREVNO') )
	dw_pisq041u_left.SetItem(ll_LastRow, 'AS_CHKREVNO', dw_pisq041u_right.GetitemString(ll_SaveRow[ll_row], 'AS_STANDARDREVNO'))
	dw_pisq041u_left.SetItem(ll_LastRow, 'DEL_CHK', 'S')
	// 좌측화면의 선택된행에 삭제표시를 셋트한다
	dw_pisq041u_right.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq041u_right.GetSelectedRow(0)

// 선택행을 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisq041u_right.RowCount() to 1 step -1
	IF dw_pisq041u_right.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq041u_right.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq041u_right.RowCount() THEN
	f_SetHighlight(dw_pisq041u_right, dw_pisq041u_right.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq041u_right, ll_select_row, True)	
END IF

//parent.TriggerEvent('ue_save')
end event

type uo_area from u_pisc_select_area within w_pisq041u
integer x = 59
integer y = 60
integer taborder = 40
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
End If

dw_pisq041u_left.SetTransObject(SQLPIS)
dw_pisq041u_right.SetTransObject(SQLPIS)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq041u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 70
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

dw_pisq041u_left.SetTransObject(SQLPIS)
dw_pisq041u_right.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq041u
integer x = 64
integer y = 228
integer width = 1106
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
string text = "< 기존업체 검사기준서 내역 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq041u
integer x = 2496
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
string text = "< 변경업체 검사기준서 내역 >"
boolean focusrectangle = false
end type

type st_rightcnt from statictext within w_pisq041u
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

type dw_print from datawindow within w_pisq041u
boolean visible = false
integer x = 2322
integer y = 800
integer width = 1138
integer height = 1148
integer taborder = 160
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq060u_02_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print1 from datawindow within w_pisq041u
boolean visible = false
integer x = 101
integer y = 636
integer width = 1271
integer height = 1340
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq060u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisq041u
integer x = 18
integer y = 12
integer width = 1198
integer height = 168
integer taborder = 170
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type st_leftcnt from statictext within w_pisq041u
integer x = 1678
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

type st_4 from statictext within w_pisq041u
integer x = 59
integer y = 336
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
string text = "기존업체:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_suppliercode from singlelineedit within w_pisq041u
integer x = 361
integer y = 324
integer width = 352
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// 업체명을 구한다
//
sle_suppliername.Text = f_getsuppliername(sle_suppliercode.Text)
dw_pisq041u_left.reset()
dw_pisq041u_right.reset()



end event

type sle_suppliername from singlelineedit within w_pisq041u
integer x = 736
integer y = 324
integer width = 809
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_pisq041u
integer x = 1559
integer y = 308
integer width = 238
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
string disabledname = "C:\kdac\bmp\not_search.gif"
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

type st_5 from statictext within w_pisq041u
integer x = 2501
integer y = 336
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
string text = "변경업체:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_modifycode from singlelineedit within w_pisq041u
integer x = 2802
integer y = 324
integer width = 352
integer height = 72
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// 업체명을 구한다
//
sle_modifyname.Text = f_getsuppliername(sle_modifycode.Text)
dw_pisq041u_right.reset()



end event

type sle_modifyname from singlelineedit within w_pisq041u
integer x = 3177
integer y = 324
integer width = 809
integer height = 72
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_pisq041u
integer x = 4000
integer y = 312
integer width = 238
integer height = 96
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
string disabledname = "C:\kdac\bmp\not_search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag		= 2			//외주업체(지역,공장)
istr_partkb.remark	= sle_modifycode.Text

OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_modifycode.Text = lstr_Rtn.code
sle_modifyname.Text = lstr_Rtn.name


end event

type st_6 from statictext within w_pisq041u
integer x = 1298
integer y = 20
integer width = 2030
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "1. 기존업체는 외주기획에서 사용중지한 업체일 경우만 가능합니다."
boolean focusrectangle = false
end type

type st_7 from statictext within w_pisq041u
integer x = 1298
integer y = 84
integer width = 2574
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "2. 변경된 업체로 저장이 완료된 검사기준서는 변경된 업체에서만 삭제할수 있습니다."
boolean focusrectangle = false
end type

type st_8 from statictext within w_pisq041u
integer x = 1298
integer y = 148
integer width = 2149
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "3. 변경업체에서는 기준서 승인현황에서 설계변경상태로 조회된다. ( IVAN Web )"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisq041u
integer x = 18
integer y = 196
integer width = 4608
integer height = 2380
integer taborder = 140
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

