$PBExportHeader$w_pisr210u.srw
$PBExportComments$입고이력 반출처변경
forward
global type w_pisr210u from w_ipis_sheet01
end type
type dw_pisr210u_left from u_vi_std_datawindow within w_pisr210u
end type
type dw_pisr210u_right from u_vi_std_datawindow within w_pisr210u
end type
type pb_move from picturebutton within w_pisr210u
end type
type pb_del from picturebutton within w_pisr210u
end type
type st_2 from statictext within w_pisr210u
end type
type st_3 from statictext within w_pisr210u
end type
type st_leftcnt from statictext within w_pisr210u
end type
type st_rightcnt from statictext within w_pisr210u
end type
type dw_print from datawindow within w_pisr210u
end type
type dw_print1 from datawindow within w_pisr210u
end type
type dw_condition from datawindow within w_pisr210u
end type
type uo_division from u_pisc_select_division within w_pisr210u
end type
type uo_area from u_pisc_select_area within w_pisr210u
end type
type uo_fromdate from u_pisc_date_applydate within w_pisr210u
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisr210u
end type
type st_1 from statictext within w_pisr210u
end type
type dw_pisr210u_01 from datawindow within w_pisr210u
end type
type gb_3 from groupbox within w_pisr210u
end type
type gb_4 from groupbox within w_pisr210u
end type
type gb_2 from groupbox within w_pisr210u
end type
end forward

global type w_pisr210u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "입고이력반출처변경"
event ue_init ( )
dw_pisr210u_left dw_pisr210u_left
dw_pisr210u_right dw_pisr210u_right
pb_move pb_move
pb_del pb_del
st_2 st_2
st_3 st_3
st_leftcnt st_leftcnt
st_rightcnt st_rightcnt
dw_print dw_print
dw_print1 dw_print1
dw_condition dw_condition
uo_division uo_division
uo_area uo_area
uo_fromdate uo_fromdate
uo_todate uo_todate
st_1 st_1
dw_pisr210u_01 dw_pisr210u_01
gb_3 gb_3
gb_4 gb_4
gb_2 gb_2
end type
global w_pisr210u w_pisr210u

type variables
str_pisr_partkb istr_partkb
end variables

forward prototypes
public function integer wf_suppliervalid_chk (string as_colname, string as_suppcode)
public function integer wf_usecentervalid_chk (string as_colname, string as_usecode)
end prototypes

event ue_init();SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회
end event

public function integer wf_suppliervalid_chk (string as_colname, string as_suppcode);Integer li_Chk
String ls_Null

SetNull(ls_Null)

  SELECT count(SupplierCode)  
    INTO :li_Chk  
    FROM TMSTSUPPLIER  
   WHERE TMSTSUPPLIER.SupplierCode = :as_suppCode   
	USING sqlpis	;
If li_Chk > 0 Then 
	Return 1
End if
dw_pisr210u_01.SetItem( dw_pisr210u_01.GeTrow(), as_colName, ls_Null ) 

Return -1 
end function

public function integer wf_usecentervalid_chk (string as_colname, string as_usecode);String ls_useGubun, ls_Null
Integer li_Chk 

SetNull(ls_Null)
ls_useGubun = dw_pisr210u_01.GetItemString( dw_pisr210u_01.GetRow(), 'usecentergubun' )
If ls_useGubun = 'I' Then 	//조
 	SELECT	count(WorkCenter)  
 	INTO 		:li_Chk  
  	FROM 		TMSTWORKCENTER  
 	WHERE 	TMSTWORKCENTER.AreaCode			= :uo_area.is_uo_areacode  AND  
        		TMSTWORKCENTER.DivisionCode	= :uo_division.is_uo_divisioncode  AND  
        		TMSTWORKCENTER.WorkCenter 		= :as_useCode    
	USING		sqlpis	;
	
   If li_Chk > 0 Then Return 1 
ElseIf ls_useGubun = 'E' Then 	//외주업체 
	Return wf_suppliervalid_Chk( as_colName, as_useCode )
End If

dw_pisr210u_01.SetItem( dw_pisr210u_01.Getrow(), as_colName, ls_Null )

Return -1 
end function

on w_pisr210u.create
int iCurrent
call super::create
this.dw_pisr210u_left=create dw_pisr210u_left
this.dw_pisr210u_right=create dw_pisr210u_right
this.pb_move=create pb_move
this.pb_del=create pb_del
this.st_2=create st_2
this.st_3=create st_3
this.st_leftcnt=create st_leftcnt
this.st_rightcnt=create st_rightcnt
this.dw_print=create dw_print
this.dw_print1=create dw_print1
this.dw_condition=create dw_condition
this.uo_division=create uo_division
this.uo_area=create uo_area
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_1=create st_1
this.dw_pisr210u_01=create dw_pisr210u_01
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr210u_left
this.Control[iCurrent+2]=this.dw_pisr210u_right
this.Control[iCurrent+3]=this.pb_move
this.Control[iCurrent+4]=this.pb_del
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_leftcnt
this.Control[iCurrent+8]=this.st_rightcnt
this.Control[iCurrent+9]=this.dw_print
this.Control[iCurrent+10]=this.dw_print1
this.Control[iCurrent+11]=this.dw_condition
this.Control[iCurrent+12]=this.uo_division
this.Control[iCurrent+13]=this.uo_area
this.Control[iCurrent+14]=this.uo_fromdate
this.Control[iCurrent+15]=this.uo_todate
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.dw_pisr210u_01
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_4
this.Control[iCurrent+20]=this.gb_2
end on

on w_pisr210u.destroy
call super::destroy
destroy(this.dw_pisr210u_left)
destroy(this.dw_pisr210u_right)
destroy(this.pb_move)
destroy(this.pb_del)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_leftcnt)
destroy(this.st_rightcnt)
destroy(this.dw_print)
destroy(this.dw_print1)
destroy(this.dw_condition)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_1)
destroy(this.dw_pisr210u_01)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr210u_left.Width = (newwidth / 2) - (ls_gap * 6) - ( pb_move.width / 2 )
dw_pisr210u_left.Height= newheight - (dw_pisr210u_left.y + ls_status)

pb_move.x = dw_pisr210u_left.x + dw_pisr210u_left.width + ls_split
pb_del.x = pb_move.x
dw_pisr210u_01.x = pb_move.x
 
dw_pisr210u_right.x = (ls_gap * 6) + dw_pisr210u_left.Width + pb_move.width
st_3.x = dw_pisr210u_right.x
dw_pisr210u_right.y = dw_pisr210u_left.y
dw_pisr210u_right.Width = dw_pisr210u_left.Width
dw_pisr210u_right.Height= dw_pisr210u_left.Height
end event

event ue_retrieve;
Long 		ll_Row
String	ls_suppCode, ls_itemCode, ls_productGroup

uo_status.st_message.text = ""
dw_condition.AcceptText()
ll_Row		= dw_condition.GetRow()
ls_suppCode	= dw_condition.GetItemString(ll_Row, 'suppliercode')

If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then 
	ls_suppCode = '%'
End If
ls_itemCode	= dw_condition.GetItemString(ll_Row, 'itemcode' )
If isNull(ls_itemCode) Or Trim(ls_itemCode) = '' Then 
	uo_status.st_message.text = "품번이 입력되지 않았습니다."
	return 0
End If

If mid(f_pisr_get_today(),1,7) <> mid(uo_fromdate.is_uo_date,1,7) then
	uo_status.st_message.text = "현재월에 해당하는 입고이력만 조회가능합니다."
	return 0
end if

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.itemCode	= ls_itemCode

dw_pisr210u_left.SetTransObject(sqlpis)
dw_pisr210u_right.ReSet()
dw_pisr210u_01.Reset()
dw_pisr210u_01.insertrow(0)

ll_Row = dw_pisr210u_left.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_suppCode, ls_itemCode, uo_fromdate.is_uo_date, uo_todate.is_uo_date )

If ll_Row < 1 Then
	uo_status.st_message.text = "입고 이력이 존재하지 않습니다."
End If

return 0
// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisr210u_left, 1, True)	
//f_SetHighlight(dw_pisr210u_right, 1, True)	

end event

event ue_postopen;
// 권한이 조회만 가능한 사람은 버튼처리 불가
//
pb_move.Enabled	= m_frame.m_action.m_save.Enabled
pb_del.Enabled		= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)


end event

event open;call super::open;dw_condition.SetTransObject(sqlpis)
dw_condition.InsertRow(1)
dw_pisr210u_01.SetTransObject(sqlpis)
dw_pisr210u_01.InsertRow(1)

this.PostEvent ( "ue_init" )

//uo_fromdate.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
//uo_fromdate.is_uo_date = String(uo_fromdate.id_uo_date, 'YYYY.MM.DD')
//uo_fromdate.init_cal(uo_fromdate.id_uo_date)
//uo_fromdate.set_date_format ('yyyy.mm.dd')
//uo_fromdate.TriggerEvent("ue_variable_set")
//uo_fromdate.TriggerEvent("ue_select")
end event

event ue_save;call super::ue_save;long ll_cnt, ll_rowcnt
str_ipis_server lstr_ipis[]
string ls_areadivision[], ls_message
string ls_orderseq, ls_deliveryno, ls_usecenter, ls_costgubun, ls_applydate, ls_usecentergubun, ls_partkbno

dw_pisr210u_right.accepttext()
ll_rowcnt = dw_pisr210u_right.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "변경할 정보가 없습니다."
	return 0
end if

SetPointer(hourglass!)

ls_areadivision[1] = 'XZ'
lstr_ipis = f_ipis_server_set_transaction('EACH',ls_areadivision)
sqlpis.autocommit = false

For ll_cnt = 1 to ll_rowcnt
	if dw_pisr210u_right.getitemstring(ll_cnt,"oksign") = 'OK' then
		continue
	end if
	ls_partkbno = dw_pisr210u_right.getitemstring(ll_cnt,"partkbno")
	ls_orderseq = trim(dw_pisr210u_right.getitemstring(ll_cnt,"orderseq"))
	ls_deliveryno = trim(dw_pisr210u_right.getitemstring(ll_cnt,"deliveryno"))
	ls_applydate = dw_pisr210u_right.getitemstring(ll_cnt,"applydate")
	ls_usecenter = trim(dw_pisr210u_right.getitemstring(ll_cnt,"change_usecenter"))
	ls_costgubun = trim(dw_pisr210u_right.getitemstring(ll_cnt,"change_costgubun"))
	ls_usecentergubun = dw_pisr210u_right.getitemstring(ll_cnt,"change_usecentergubun")
	
	// 외주간판입고이력테이블 수정
	UPDATE TPARTKBHIS
	SET UseCenter = :ls_usecenter, UseCentergubun = :ls_usecentergubun
	WHERE PartkbNo = :ls_partkbno AND Applydate = :ls_applydate AND
			OrderSeq = :ls_orderseq
	using sqlpis;
	
	if sqlpis.sqlcode <> 0 or sqlpis.sqlnrows <> 1 then
		ls_message = "실패 : 입고이력테이블 수정실패"
		goto Rollback_
	end if
	// 자재 인터페이스 함수 호출
	If f_change_ipis_mis_usecenter( ls_message, ls_orderseq, ls_deliveryno, ls_usecenter, ls_costgubun, &
			g_s_empno, lstr_ipis ) = -1 Then
		ls_message = "실패 : " + ls_message
 		goto Rollback_
	Else
		commit using sqlpis;
		f_ipis_server_commit_only(lstr_ipis)
	End If
	
	// OKSign 표시 : 성공
	dw_pisr210u_right.setitem(ll_cnt,"oksign",'OK')
	continue
		
	Rollback_:
	rollback using sqlpis;
	f_ipis_server_rollback_only(lstr_ipis)
	// OKSign 표시 : 실패
	dw_pisr210u_right.setitem(ll_cnt,"oksign",ls_message)
			
Next

sqlpis.autocommit = true
f_ipis_server_destroy_only(lstr_ipis)
uo_status.st_message.text = "완료되었습니다. 처리결과를 확인하시기 바랍니다."

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr210u
integer x = 18
integer y = 2592
integer width = 3598
end type

type dw_pisr210u_left from u_vi_std_datawindow within w_pisr210u
integer x = 23
integer y = 576
integer width = 1554
integer height = 1976
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr210u_left"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;
st_leftcnt.Text = String(rowcount, '#,###')
end event

type dw_pisr210u_right from u_vi_std_datawindow within w_pisr210u
integer x = 2510
integer y = 576
integer width = 2094
integer height = 1976
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr210u_right"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;

String	ls_colname, ls_coldata

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// 적용일자
	//
	CASE "applydatefrom"
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '적용일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			RETURN 1
		END IF	
		
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '적용일자를 정확히 입력하시요')
			RETURN 1
		END IF

		IF Date(ls_coldata) <= Date(f_getsysdatetime()) THEN
			MessageBox('확 인', '적용일자는 작업일보다 커야합니다')
			RETURN 1
		END IF
			
	// 종료일자
	//
	CASE "applydateto"
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('확 인', '종료일자는 다음과 같은 형태로 입력하세요 ==> 2002.01.01', StopSign!)
			RETURN 1
		END IF	

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('확 인', '종료일자를 정확히 입력하시요')
			RETURN 1
		END IF
END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event retrieveend;call super::retrieveend;
st_rightcnt.Text = String(rowcount, '#,###')
end event

type pb_move from picturebutton within w_pisr210u
integer x = 1659
integer y = 1104
integer width = 791
integer height = 212
integer taborder = 20
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
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row, ll_currow
long	ll_SaveRow[] 
string ls_usecentergubun, ls_usecenter, ls_costgubun

dw_pisr210u_01.accepttext()
dw_pisr210u_right.reset()
// 선택된 행이 있는지 체크한다
//
ll_row = dw_pisr210u_left.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN -1
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisr210u_left.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 변경데이타 체크
ls_usecentergubun = dw_pisr210u_01.getitemstring(1,"usecentergubun")
ls_usecenter = dw_pisr210u_01.getitemstring(1,"usecenter")
ls_costgubun = dw_pisr210u_01.getitemstring(1,"costgubun")
if f_spacechk(ls_usecentergubun) = -1 then
	uo_status.st_message.text = "변경사용처구분이 선택되지 않았습니다."
	return -1
else
	if ls_usecentergubun = 'E' then
		if f_spacechk(ls_costgubun) = -1 then
			uo_status.st_message.text = "유/무상구분을 확인 할 수 없는 사용처입니다."
			return -1
		end if
	else
		SetNull(ls_costgubun)
	end if
end if
if f_spacechk(ls_usecentergubun) = -1 then
	uo_status.st_message.text = "변경사용처가 입력되지 않았습니다."
	return -1
end if
// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	//
	dw_pisr210u_left.RowsCopy(ll_SaveRow[ll_row], ll_SaveRow[ll_row], Primary!, dw_pisr210u_right, 1, Primary!)
	dw_pisr210u_right.SetItem( 1, "change_usecentergubun", ls_usecentergubun )
	dw_pisr210u_right.SetItem( 1, "change_usecenter", ls_usecenter )
	dw_pisr210u_right.SetItem( 1, "change_costgubun", ls_costgubun )
	// 좌측화면의 선택된행에 삭제표시를 셋트한다
	//
	dw_pisr210u_left.SetItem(ll_SaveRow[ll_row], 'del_chk', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisr210u_left.GetSelectedRow(0)

// 이동이 끝난 좌측화면의 선택행은 삭제한다(행의 맨뒤에서부터 삭제한다)

FOR ll_row = dw_pisr210u_left.RowCount() to 1 step -1
	IF dw_pisr210u_left.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisr210u_left.DeleteRow(ll_row)
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisr210u_left.RowCount() THEN
	f_SetHighlight(dw_pisr210u_left, dw_pisr210u_left.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisr210u_left, ll_select_row, True)	
END IF

f_sethighlight(dw_pisr210u_right,dw_pisr210u_right.RowCount(),TRUE)


end event

type pb_del from picturebutton within w_pisr210u
integer x = 1659
integer y = 1964
integer width = 791
integer height = 212
integer taborder = 30
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
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row, ll_currow 
long	ll_SaveRow[]

// 선택된 행이 있는지 체크한다
//
ll_row = dw_pisr210u_right.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		if dw_pisr210u_right.getitemstring(ll_row,"oksign") = 'OK' then
			continue
		end if
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisr210u_right.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 우측측화면의 선택된행에 삭제표시를 셋트한다
//
FOR ll_row = 1 TO ll_index - 1
	dw_pisr210u_right.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 선택된 행값을 구한다
//
ll_select_row = dw_pisr210u_right.GetSelectedRow(0)

// 선택행을 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_pisr210u_right.RowCount() to 1 step -1
	IF dw_pisr210u_right.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisr210u_right.RowsCopy(ll_row, ll_row, Primary!, dw_pisr210u_left, 1, Primary!)
		dw_pisr210u_left.setitem(1, "del_chk", 'N')
		dw_pisr210u_left.setitem(1, "oksign", '변경대상')
		dw_pisr210u_right.DeleteRow(ll_row)		
	END IF
NEXT

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisr210u_right.RowCount() THEN
	f_SetHighlight(dw_pisr210u_right, dw_pisr210u_right.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisr210u_right, ll_select_row, True)	
END IF

return 0
end event

type st_2 from statictext within w_pisr210u
integer x = 55
integer y = 496
integer width = 969
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
string text = "< 사용처 변경전 입고이력 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisr210u
integer x = 2345
integer y = 496
integer width = 969
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
string text = "< 사용처 변경후 입고이력 >"
boolean focusrectangle = false
end type

type st_leftcnt from statictext within w_pisr210u
integer x = 1106
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

type st_rightcnt from statictext within w_pisr210u
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

type dw_print from datawindow within w_pisr210u
boolean visible = false
integer x = 2322
integer y = 800
integer width = 1138
integer height = 1148
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq070u_02_PRINT"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print1 from datawindow within w_pisr210u
boolean visible = false
integer x = 101
integer y = 904
integer width = 1271
integer height = 1072
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq070u_02_PRINT1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_condition from datawindow within w_pisr210u
integer x = 82
integer y = 208
integer width = 2770
integer height = 216
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
			istr_partkb.flag = 3			//외주업체(지역,공장)
			OpenWithParm ( w_pisr012i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
			This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
			This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
	CASE 'b_item'
			istr_partkb.flag = 1			//외주자재list (지역,공장)
			OpenWithParm ( w_pisr013i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'itemcode'			, lstr_Rtn.code)
			This.SetItem(row,'itemname'			, lstr_Rtn.name)
			This.SetItem(row,'itemspec'			, lstr_Rtn.nicname)
	CASE ELSE
			Return
END CHOOSE

dw_pisr210u_left.Reset()
dw_pisr210u_right.Reset()

Return

end event

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_itemcode, ls_itemspec, ls_itemname
String	ls_Null 
//DataWindowChild ldwc

this.AcceptText ( )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode'
			ls_suppcode	= data
		  SELECT Top 1
					B.SupplierNo,   
					B.SupplierKorName  
			 INTO :ls_suppno,   
					:ls_suppname  
			 FROM TMSTPARTCYCLE	A,   
					TMSTSUPPLIER	B  
			WHERE A.SupplierCode = B.SupplierCode 			AND
					A.AreaCode 		= :istr_partkb.areacode AND  
					A.DivisionCode = :istr_partkb.divcode 	AND  
					A.SupplierCode = :ls_suppcode 
			Using	sqlpis	;
			
			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
				This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
				This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
				istr_partkb.suppcode = '%'
				Return 1
			End If
			This.SetItem( This.GetRow(), 'supplierno'			, ls_suppno )
			This.SetItem( This.GetRow(), 'supplierkorname'	, ls_suppname )
			istr_partkb.suppcode = ls_suppcode
	Case 'itemcode' 
			ls_itemcode	= data
			ls_suppcode	= This.GetItemString( This.GetRow(), 'suppliercode')
			If isNull(ls_suppcode) Or Trim(ls_suppcode) = '' Then ls_suppcode = '%'
		  SELECT Top 1
		  			B.ItemName,   
					B.ItemSpec  
			 INTO :ls_itemname,   
					:ls_itemspec  
			 FROM TMSTPARTKB		A,   
					TMSTITEM			B  
			WHERE A.ItemCode 		= B.ItemCode	 			AND
					A.AreaCode 		= :istr_partkb.areacode AND  
					A.DivisionCode = :istr_partkb.divcode 	AND  
					A.SupplierCode like :ls_suppcode 		AND
					A.ItemCode 		= :ls_itemcode 		
			Using	sqlpis	;
			
			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'itemcode', ls_Null )
				This.SetItem( This.GetRow(), 'itemspec', ls_Null )
				This.SetItem( This.GetRow(), 'itemname', ls_Null )
				istr_partkb.itemcode = '%'
				Return 1
			End If
			This.SetItem( This.GetRow(), 'itemname', ls_itemname )
			This.SetItem( This.GetRow(), 'itemspec', ls_itemspec )
			istr_partkb.itemcode = ls_itemcode
End Choose 

dw_pisr210u_left.Reset()
dw_pisr210u_right.Reset()

end event

event itemerror;Return 1
end event

type uo_division from u_pisc_select_division within w_pisr210u
event destroy ( )
integer x = 631
integer y = 72
integer taborder = 120
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_pisr210u_left.Reset()
dw_pisr210u_right.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr210u
event destroy ( )
integer x = 82
integer y = 72
integer taborder = 130
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;//ib_allflag = True
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode

dw_pisr210u_left.Reset()
dw_pisr210u_right.Reset()
end event

type uo_fromdate from u_pisc_date_applydate within w_pisr210u
event destroy ( )
integer x = 1285
integer y = 72
integer taborder = 130
boolean bringtotop = true
end type

on uo_fromdate.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;
dw_pisr210u_left.Reset()
dw_pisr210u_right.Reset()
end event

type uo_todate from u_pisc_date_applydate_1 within w_pisr210u
event destroy ( )
integer x = 2039
integer y = 72
integer taborder = 140
boolean bringtotop = true
end type

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_pisr210u_left.Reset()
dw_pisr210u_right.Reset()
end event

type st_1 from statictext within w_pisr210u
integer x = 1966
integer y = 72
integer width = 73
integer height = 52
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type dw_pisr210u_01 from datawindow within w_pisr210u
integer x = 1659
integer y = 1336
integer width = 791
integer height = 604
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_pisr210u_01"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;str_pisr_return lstr_Rtn
str_pisr_partkb lstr_partkb
String	ls_buttonname
String	ls_useGubun, ls_modelID, ls_costgubun
String	ls_Null
String	ls_pkChgChk = 'N'

SetNull(ls_Null)

if dw_pisr210u_left.rowcount() < 1 then
	uo_status.st_message.text = "사용처 변경전 입고이력이 없습니다."
	return -1
end if

ls_buttonname 	= dwo.name
lstr_partkb 	= istr_partkb

CHOOSE CASE ls_buttonname
	CASE 'b_use'
			ls_useGubun = This.GetItemString(row, 'usecentergubun')
			If ls_useGubun = 'E' Then
				lstr_partkb.flag = 2		//외주업체(전체)
			Else 
				lstr_partkb.flag = 1		//생산Line
			End If				
			OpenWithParm ( w_pisr012i, lstr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return -1
			
			//유무상 체크
			SELECT TOP 1 CostGubun INTO :ls_costgubun
			FROM TMSTPARTKB
			WHERE AreaCode = :istr_partkb.areacode AND DivisionCode = :istr_partkb.divcode AND
				UseCenter = :lstr_Rtn.code AND ItemCode = :istr_partkb.itemcode
			using sqlpis;
			
			if sqlpis.sqlcode <> 0 then
				SELECT "GUBUN"  INTO :ls_costgubun
				FROM  "PBINV"."INV108"
				WHERE "PBINV"."INV108"."COMLTD" = '01'    AND "PBINV"."INV108"."XPLANT" = :istr_partkb.areacode AND
						"PBINV"."INV108"."DIV"    = :istr_partkb.divcode AND "PBINV"."INV108"."ITNO"   = :istr_partkb.itemcode  AND
						"PBINV"."INV108"."VSRNO"  = :lstr_Rtn.code AND "PBINV"."INV108"."STRDT" <= :g_s_date AND
						"PBINV"."INV108"."STOP" <> 'S' using sqlca;
				IF sqlca.sqlcode <> 0 Then
					 SELECT "GUBUN"  INTO :ls_costgubun 
					 FROM  "PBINV"."INV109"
					 WHERE "PBINV"."INV109"."COMLTD" = '01'      AND "PBINV"."INV109"."XPLANT" = :istr_partkb.areacode AND
								"PBINV"."INV109"."DIV"    = :istr_partkb.divcode   AND "PBINV"."INV109"."ITNO"   = :istr_partkb.itemcode  AND
							  "PBINV"."INV109"."VSRNO"  = :lstr_Rtn.code AND "PBINV"."INV109"."TODT" >= :g_s_date AND
							  "PBINV"."INV109"."FRDT" <= :g_s_date   using sqlca;
					 If sqlca.sqlcode <> 0 Then
						  ls_costgubun = ''
					 Elseif ls_costgubun = 'Y' Then 
						  ls_costgubun = 'Y'
					 Else
						  ls_costgubun = 'N'
					 End If
				ELSEIF Trim(ls_costgubun) = 'Y' Then 
					 ls_costgubun = 'Y'
				Else
					 ls_costgubun = 'N'
				End If
			end if
			
			This.SetItem(row, 'costgubun'		, ls_costgubun)
			This.SetItem(row, 'usecenter'		, lstr_Rtn.code)
			This.Object.t_centername.Text 	= lstr_Rtn.name
	CASE ELSE
END CHOOSE
end event

event itemchanged;String 	ls_colName, ls_null
String	ls_centergubun, ls_useCenter, ls_CenterName, ls_costgubun

if dw_pisr210u_left.rowcount() < 1 then
	uo_status.st_message.text = "사용처 변경전 입고이력이 없습니다."
	return -1
end if

this.AcceptText ( )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'usecentergubun'
		If data = 'I' Then	//사용처 구분 'I'사내, 'E'외주업체
			This.SetItem(row, "costgubun", ls_Null) 
			This.Object.costgubun.Protect = 1
			This.Object.b_use.visible = 1
			This.Object.usecenter.Protect = 0
		Else
			SetNull(ls_useCenter)
			This.SetItem(row, "usecenter", ls_useCenter) 
			This.Object.t_centername.Text = ''
			This.Object.costgubun.Protect = 0
			This.Object.b_use.visible = 1
			This.Object.usecenter.Protect = 0
		End If
	Case 'usecenter'
		If wf_usecentervalid_Chk(ls_colName, data) = -1 Then Return 1
		ls_centerGubun	= this.GetItemString( row, "usecentergubun" )
		IF ls_centerGubun = 'I' THEN		//사용처 사내(I)
		  SELECT TMSTWORKCENTER.WorkCenterName
			 INTO :ls_useCenter   
			 FROM TMSTWORKCENTER
			WHERE TMSTWORKCENTER.AreaCode 		= :istr_partkb.areacode AND  
					TMSTWORKCENTER.DivisionCode 	= :istr_partkb.divcode	AND
					TMSTWORKCENTER.WorkCenter		= :data
			USING	sqlpis 	;
		ELSE										//사용처 외주업체(E)
		  SELECT TMSTSUPPLIER.SupplierKorName  
			 INTO :ls_useCenter   
			 FROM TMSTSUPPLIER  
			WHERE TMSTSUPPLIER.SupplierCode 		= :data   
			USING	sqlpis 	;

			//유무상 체크
			SELECT TOP 1 CostGubun INTO :ls_costgubun
			FROM TMSTPARTKB
			WHERE AreaCode = :istr_partkb.areacode AND DivisionCode = :istr_partkb.divcode AND
				UseCenter = :data AND ItemCode = :istr_partkb.itemcode
			using sqlpis;
			
			if sqlpis.sqlcode <> 0 then
				SELECT "GUBUN"  INTO :ls_costgubun
				FROM  "PBINV"."INV108"
				WHERE "PBINV"."INV108"."COMLTD" = '01'    AND "PBINV"."INV108"."XPLANT" = :istr_partkb.areacode AND
						"PBINV"."INV108"."DIV"    = :istr_partkb.divcode AND "PBINV"."INV108"."ITNO"   = :istr_partkb.itemcode  AND
						"PBINV"."INV108"."VSRNO"  = :data AND "PBINV"."INV108"."STRDT" <= :g_s_date AND
						"PBINV"."INV108"."STOP" <> 'S' using sqlca;
				IF sqlca.sqlcode <> 0 Then
					 SELECT "GUBUN"  INTO :ls_costgubun 
					 FROM  "PBINV"."INV109"
					 WHERE "PBINV"."INV109"."COMLTD" = '01'      AND "PBINV"."INV109"."XPLANT" = :istr_partkb.areacode AND
								"PBINV"."INV109"."DIV"    = :istr_partkb.divcode   AND "PBINV"."INV109"."ITNO"   = :istr_partkb.itemcode  AND
							  "PBINV"."INV109"."VSRNO"  = :data AND "PBINV"."INV109"."TODT" >= :g_s_date AND
							  "PBINV"."INV109"."FRDT" <= :g_s_date   using sqlca;
					 If sqlca.sqlcode <> 0 Then
						  ls_costgubun = ''
					 Elseif ls_costgubun = 'Y' Then 
						  ls_costgubun = 'Y'
					 Else
						  ls_costgubun = 'N'
					 End If
				ELSEIF Trim(ls_costgubun) = 'Y' Then 
					 ls_costgubun = 'Y'
				Else
					 ls_costgubun = 'N'
				End If
			end if	 
		END IF
		This.SetItem(row, "costgubun", ls_costgubun) 
		this.Object.t_centername.Text = ls_useCenter
End Choose 
end event

type gb_3 from groupbox within w_pisr210u
integer x = 27
integer width = 1202
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisr210u
integer x = 1243
integer width = 1275
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr210u
integer x = 27
integer y = 172
integer width = 2857
integer height = 276
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

