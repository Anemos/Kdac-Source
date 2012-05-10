$PBExportHeader$w_pisr135i.srw
$PBExportComments$(new)사급품반출현황
forward
global type w_pisr135i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr135i
end type
type uo_division from u_pisc_select_division within w_pisr135i
end type
type uo_from from u_pisc_date_applydate within w_pisr135i
end type
type uo_to from u_pisc_date_applydate_1 within w_pisr135i
end type
type st_2 from statictext within w_pisr135i
end type
type dw_condition from datawindow within w_pisr135i
end type
type dw_2 from u_vi_std_datawindow within w_pisr135i
end type
type dw_3 from u_vi_std_datawindow within w_pisr135i
end type
type st_hsplitbar from u_pism_splitbar within w_pisr135i
end type
type gb_1 from groupbox within w_pisr135i
end type
type gb_3 from groupbox within w_pisr135i
end type
type gb_2 from groupbox within w_pisr135i
end type
end forward

global type w_pisr135i from w_ipis_sheet01
integer width = 3963
event ue_init ( )
uo_area uo_area
uo_division uo_division
uo_from uo_from
uo_to uo_to
st_2 st_2
dw_condition dw_condition
dw_2 dw_2
dw_3 dw_3
st_hsplitbar st_hsplitbar
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
end type
global w_pisr135i w_pisr135i

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
end variables

event ue_init();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_hsplitbar.of_Register(dw_2, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_3, st_hsplitbar.BELOW)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회


String	ls_deptname, ls_Null

SetNull(ls_Null)

  SELECT TMSTDEPT.DeptName  
	 INTO :ls_deptname  
	 FROM TMSTDEPT  
	WHERE TMSTDEPT.DeptCode = :g_s_deptcd
	USING	sqlpis	;

If sqlpis.SqlCode <> 0 Then 
	dw_condition.SetItem( dw_condition.GetRow(), 'deptcode', ls_Null )
	dw_condition.SetItem( dw_condition.GetRow(), 'deptname', ls_Null )
	Return 
End If
dw_condition.SetItem( dw_condition.GetRow(), 'deptcode', g_s_deptcd )
dw_condition.SetItem( dw_condition.GetRow(), 'deptname', ls_deptname )

end event

on w_pisr135i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_2=create st_2
this.dw_condition=create dw_condition
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_hsplitbar=create st_hsplitbar
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_from
this.Control[iCurrent+4]=this.uo_to
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_condition
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.st_hsplitbar
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
end on

on w_pisr135i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.dw_condition)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_hsplitbar)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
ib_open = True
istr_partkb.areacode = uo_area.is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

end event

event open;call super::open;
dw_condition.SetTransObject(sqlpis)
dw_condition.Reset()
dw_condition.InsertRow(1)

This.TriggerEvent( "ue_init" )

uo_from.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_from.is_uo_date = String(uo_from.id_uo_date, 'YYYY.MM.DD')
uo_from.init_cal(uo_from.id_uo_date)
uo_from.set_date_format ('yyyy.mm.dd')
uo_from.TriggerEvent("ue_variable_set")
uo_from.TriggerEvent("ue_select")


end event

event ue_retrieve;call super::ue_retrieve;String	ls_deptcode, ls_suppcode
String 	ls_From, ls_To
Long 		ll_Row

dw_condition.AcceptText()
ls_deptcode	= dw_condition.GetItemString(1, 'deptcode')
ls_suppcode	= dw_condition.GetItemString(1, 'suppliercode')

//If isNull(ls_deptcode) Or Trim(ls_deptcode) = '' Then 
//	MessageBox('확인', '조회할 부서코드를 입력하세요.', Information! )
//	return
//End If
If isNull(ls_deptcode) Or Trim(ls_deptcode) = '' Then ls_deptcode = '%'
If isNull(ls_suppcode) Or Trim(ls_suppcode) = '' Then ls_suppcode = '%'

ls_From	= uo_from.is_uo_date
ls_To		= uo_to.is_uo_date

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_deptcode, ls_suppcode, ls_From, ls_To)

If ll_Row < 1 Then 
	MessageBox('확인', '발행된 사급품반출LIST가 존재하지 않습니다.', Information! )
	Return
End If	

dw_2.selectrow(1,true)
dw_2.Event RowfocusChanged(1)
Return

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

st_hsplitbar.x 		= dw_3.x
st_hsplitbar.y 		= dw_3.y - ls_split
st_hsplitbar.Width 	= dw_3.Width 

end event

event ue_delete;call super::ue_delete;String	ls_BuyBackNo, ls_buybackdept, ls_statusflag, ls_null
long ll_selrow, ll_rtn, ll_rowcnt

setnull(ls_null)
ll_selrow = dw_2.getselectedrow(0)

if ll_selrow < 1 then
	uo_status.st_message.text = "삭제할 발행번호를 선택하십시요"
	return 0
end if

ls_buybackno = dw_2.getitemstring(ll_selrow,"buybackno")
ls_buybackdept = dw_2.getitemstring(ll_selrow,"buybackdept")
ls_statusflag = dw_2.getitemstring(ll_selrow,"statusflag")

if ls_statusflag = 'A' or ls_statusflag = '1' then
	//pass
else
	uo_status.st_message.text = "확정이 완료된 발행번호 입니다."
	return 0
end if

ll_rtn = MessageBox("알림", "반출번호 : " + ls_buybackno + " 데이타를 삭제하시겠습니까?", &
    Exclamation!, OKCancel!, 2)
if ll_rtn = 2 then
	return 0
end if
//자재반출 상세정보 삭제
	SELECT COUNT(*) INTO :ll_rowcnt FROM "PBINV"."INV303"  
			WHERE ( "PBINV"."INV303"."COMLTD" = '01' ) AND  
					( "PBINV"."INV303"."XPLANT" = :istr_partkb.areacode ) AND  
					( "PBINV"."INV303"."DIV" = :istr_partkb.divcode ) AND  
					( "PBINV"."INV303"."SLNO" = :ls_buybackno )   
			using sqlca;
	if ll_rowcnt > 0 then	
		DELETE FROM "PBINV"."INV303"  
				WHERE ( "PBINV"."INV303"."COMLTD" = '01' ) AND  
						( "PBINV"."INV303"."XPLANT" = :istr_partkb.areacode ) AND  
						( "PBINV"."INV303"."DIV" = :istr_partkb.divcode ) AND  
						( "PBINV"."INV303"."SLNO" = :ls_buybackno )   
				using sqlca;
		if sqlca.sqlcode <> 0 then
			uo_status.st_message.text = "삭제가 실패했습니다."
			return 0
		end if
	end if
			
// 자재반출 헤더정보 삭제
	SELECT COUNT(*) INTO :ll_rowcnt FROM "PBINV"."INV302"  
			WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
					( "PBINV"."INV302"."XPLANT" = :istr_partkb.areacode ) AND  
					( "PBINV"."INV302"."DIV" = :istr_partkb.divcode ) AND  
					( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
			using sqlca;
	if ll_rowcnt > 0 then		
		DELETE FROM "PBINV"."INV302"  
				WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
						( "PBINV"."INV302"."XPLANT" = :istr_partkb.areacode ) AND  
						( "PBINV"."INV302"."DIV" = :istr_partkb.divcode ) AND  
						( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
				using sqlca;
		if sqlca.sqlcode <> 0 then
			uo_status.st_message.text = "삭제가 실패했습니다."
			return 0
		end if
	end if
			
// 입고간판 히스토리 null로 셋팅
	SELECT COUNT(*) INTO :ll_rowcnt FROM TPARTKBHIS  
   		WHERE TPARTKBHIS.BuyBackNo = :ls_buybackno   
         using sqlpis;
	if ll_rowcnt > 0 then
		UPDATE TPARTKBHIS
		SET BUYBACKNO = :ls_null
				WHERE TPARTKBHIS.BuyBackNo = :ls_buybackno   
				using sqlpis;
		if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = "삭제가 실패했습니다."
			return 0
		end if
	end if

// 반출내역 테이블 삭제
	SELECT COUNT(*) INTO :ll_rowcnt FROM TPARTBUYBACK  
   		WHERE ( TPARTBUYBACK.AreaCode = :istr_partkb.areacode ) AND  
         		( TPARTBUYBACK.DivisionCode = :istr_partkb.divcode ) AND  
         		( TPARTBUYBACK.BuyBackNo = :ls_buybackno ) AND  
         		( TPARTBUYBACK.BuyBackDept = :ls_buybackdept )   
         using sqlpis;
			
	if ll_rowcnt > 0 then
		DELETE FROM TPARTBUYBACK  
				WHERE ( TPARTBUYBACK.AreaCode = :istr_partkb.areacode ) AND  
						( TPARTBUYBACK.DivisionCode = :istr_partkb.divcode ) AND  
						( TPARTBUYBACK.BuyBackNo = :ls_buybackno ) AND  
						( TPARTBUYBACK.BuyBackDept = :ls_buybackdept )   
				using sqlpis;
		if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = "삭제가 실패했습니다."
			return 0
		end if
	end if

uo_status.st_message.text = "삭제되었습니다."
return 0
end event

event activate;call super::activate;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  false,  true,  false,  false,  false, false)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr135i
end type

type uo_area from u_pisc_select_area within w_pisr135i
integer x = 59
integer y = 72
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

End If

istr_partkb.areacode = is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)
dw_2.Reset()
dw_3.Reset()


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr135i
integer x = 571
integer y = 72
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)

dw_2.Reset()
dw_3.Reset()

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_from from u_pisc_date_applydate within w_pisr135i
integer x = 1230
integer y = 72
integer taborder = 60
boolean bringtotop = true
end type

on uo_from.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;dw_2.Reset()
dw_3.Reset()

end event

type uo_to from u_pisc_date_applydate_1 within w_pisr135i
integer x = 2007
integer y = 72
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_2.Reset()
dw_3.Reset()

end event

type st_2 from statictext within w_pisr135i
integer x = 1929
integer y = 68
integer width = 73
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type dw_condition from datawindow within w_pisr135i
integer x = 50
integer y = 236
integer width = 2665
integer height = 216
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition5"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_deptcode, ls_deptname
String	ls_Null 
//DataWindowChild ldwc

this.AcceptText ( )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode'
			ls_suppcode	= data
		  SELECT A.SupplierNo,   
					A.SupplierKorName  
			 INTO :ls_suppno,   
					:ls_suppname  
			 FROM TMSTSUPPLIER	A  
			WHERE A.SupplierCode = :ls_suppcode 
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
	Case 'deptcode' 
			ls_deptcode	= data
		  SELECT TMSTDEPT.DeptName  
			 INTO :ls_deptname  
			 FROM TMSTDEPT  
			WHERE TMSTDEPT.DeptCode = :ls_deptcode
			USING	sqlpis	;

			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'deptcode', ls_Null )
				This.SetItem( This.GetRow(), 'deptname', ls_Null )
				Return 1
			End If
			This.SetItem( This.GetRow(), 'deptname', ls_deptname )
End Choose 


end event

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
			istr_partkb.flag = 2			//외주업체(전체)
			OpenWithParm ( w_pisr012i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
			This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
			This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
	CASE 'b_dept'
			OpenWithParm ( w_pisr016i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'deptcode'			, lstr_Rtn.code)
			This.SetItem(row,'deptname'			, lstr_Rtn.name)
	CASE ELSE
			Return
END CHOOSE

Return

end event

event itemerror;
return 1
end event

type dw_2 from u_vi_std_datawindow within w_pisr135i
integer x = 18
integer y = 476
integer width = 3058
integer height = 1156
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr135i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
If currentrow <= 0 Or RowCount() = 0 Then Return 

String	ls_buybackno, ls_buybackdate
DateTime	ldt_buybacktime

ls_buybackno = This.GetItemString(currentrow, "buybackno") 
//ls_buybackdate = This.GetItemString(currentrow, "buybackdate") 
ldt_buybacktime = This.GetItemDateTime(currentrow, "buybacktime") 

ls_buybackdate = String(ldt_buybacktime, 'YYYY.MM.DD' )

dw_3.SetRedraw(False)
dw_3.SetTransObject(Sqlpis)
dw_3.Retrieve(ls_buybackno, ls_buybackdate)
dw_3.SetRedraw(True)

end event

type dw_3 from u_vi_std_datawindow within w_pisr135i
integer x = 18
integer y = 1652
integer width = 3054
integer height = 244
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr135i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_hsplitbar from u_pism_splitbar within w_pisr135i
integer x = 14
integer y = 1632
boolean bringtotop = true
end type

type gb_1 from groupbox within w_pisr135i
integer x = 23
integer width = 1147
integer height = 192
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

type gb_3 from groupbox within w_pisr135i
integer x = 1189
integer width = 1303
integer height = 192
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

type gb_2 from groupbox within w_pisr135i
integer x = 23
integer y = 184
integer width = 2702
integer height = 276
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

