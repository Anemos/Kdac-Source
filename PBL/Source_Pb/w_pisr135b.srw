$PBExportHeader$w_pisr135b.srw
$PBExportComments$(new)사급품반출증작성및확정요청
forward
global type w_pisr135b from w_ipis_sheet01
end type
type gb_6 from groupbox within w_pisr135b
end type
type uo_area from u_pisc_select_area within w_pisr135b
end type
type uo_division from u_pisc_select_division within w_pisr135b
end type
type dw_condition from datawindow within w_pisr135b
end type
type dw_2 from u_vi_std_datawindow within w_pisr135b
end type
type rb_1 from radiobutton within w_pisr135b
end type
type rb_2 from radiobutton within w_pisr135b
end type
type gb_1 from groupbox within w_pisr135b
end type
type pb_1 from picturebutton within w_pisr135b
end type
type gb_5 from groupbox within w_pisr135b
end type
type gb_3 from groupbox within w_pisr135b
end type
type gb_2 from groupbox within w_pisr135b
end type
type dw_buyback from datawindow within w_pisr135b
end type
type st_2 from statictext within w_pisr135b
end type
type cbx_1 from checkbox within w_pisr135b
end type
type gb_4 from groupbox within w_pisr135b
end type
end forward

global type w_pisr135b from w_ipis_sheet01
integer width = 3963
event ue_init ( )
gb_6 gb_6
uo_area uo_area
uo_division uo_division
dw_condition dw_condition
dw_2 dw_2
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
pb_1 pb_1
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
dw_buyback dw_buyback
st_2 st_2
cbx_1 cbx_1
gb_4 gb_4
end type
global w_pisr135b w_pisr135b

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
String	is_deptname, is_empname, is_chkrb
end variables

forward prototypes
public function string wf_setbuybackno ()
public function string wf_getbuybackno ()
end prototypes

event ue_init();pb_1.Enabled =  m_frame.m_action.m_save.Enabled 

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

if f_spacechk(uo_area.is_uo_areacode) = -1 or &
   f_spacechk(uo_division.is_uo_divisioncode) = -1 then
	return 
end if
istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

/////////////////삭제할 부분
//if isNull(g_s_deptcd) Or Trim(g_s_deptcd) = '' Then g_s_deptcd = '731H'
/////////////////삭제할 부분

  SELECT TMSTDEPT.DeptName  
	 INTO :is_deptname  
	 FROM TMSTDEPT  
	WHERE TMSTDEPT.DeptCode = :g_s_deptcd
	USING	sqlpis	;

//  SELECT TMSTEMP.EmpName  g_s_kornm
//	 INTO :is_empname  
//	 FROM TMSTEMP  
//	WHERE TMSTEMP.EmpNo = :g_s_empno
//	USING	sqlpis	;
is_empname = g_s_kornm

dw_buyback.SetItem( 1, 'areacode'		, istr_partkb.areaCode )
dw_buyback.SetItem( 1, 'divisioncode'	, istr_partkb.divCode )
dw_buyback.SetItem( 1, 'buybackdept'	, g_s_deptcd )
dw_buyback.SetItem( 1, 'deptname'		, is_deptname )
dw_buyback.SetItem( 1, 'buybackemp'		, g_s_empno )
dw_buyback.SetItem( 1, 'empname'			, is_empname )

end event

public function string wf_setbuybackno ();////////////////////////////////////
//	반출증번호 생성 
// 반출증번호(11) : 부서코드(4),년(1),월(2),SEQ(4) - 간판품목 5001 ~ 9999 까지 생성
////////////////////////////////////

DateTime	ldt_nowTime
String	ls_buybackNo, ls_Month, ls_buybackSeq//, ls_applyDate 
String	ls_Null, ls_nowTime
Integer	li_Year
String	ls_appMonth

SetNull(ls_Null)

ldt_nowTime		= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_nowTime 		= String(ldt_nowTime, "yyyy.mm.dd hh:mm")
//ls_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//기준일자 -8시간고려함
//ls_applyDate	= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//기준일자 -8시간,마감일 고려함

//li_Year			= Integer(mid(ls_nowTime, 3,2))	//발주년도값
//
//CHOOSE CASE li_Year
//	CASE IS < 12	// Test시작년도 2002년 향후 10년 2012
//		ls_Month = mid(ls_nowTime, 4,1)
//	CASE 12 to 38	// 'A' ~ 'Z' 26자 가능
//		ls_Month = char(65 + li_Year - 12)			//2012년부터 ~ ('A','B'....~)
//	CASE ELSE
//		MessageBox("발주오류", "발주년도표기값의 범위를 초과하였습니다.", StopSign! )
//		Return ''
//END CHOOSE
//ls_Month	= ls_Month + Mid(ls_nowTime,6,2)
ls_appMonth = Left(ls_nowTime,7) 
ls_Month		= Mid(ls_nowTime,4,1) + Mid(ls_nowTime,6,2)

If istr_partkb.divcode = '%' Then 
	MessageBox('확인', '반출처를 선택하세요.', Information! )
	Return ''
End If

If isNull(g_s_deptcd) Or Trim(g_s_deptcd) = '' Then Return ''

CHOOSE CASE rb_1.Checked
	CASE True
	  SELECT Max(BuyBackNo)  
		 INTO :ls_buybackNo  
		 FROM TPARTBUYBACK	
		WHERE BuyBackDept = :g_s_deptcd 	And
				SubString(Convert(Char(10), buybacktime, 102), 1, 7) = :ls_appMonth
		USING sqlpis	;

		If isNull(ls_buybackNo) Then 
			ls_buybackNo = g_s_deptcd + ls_Month + '5001'
		Else 
			ls_buybackSeq= mid(ls_buybackNo,8,4)
			If ls_buybackSeq = '9999' Then
				MessageBox( "발행번호생성오류", "발행번호 최대치를 초과하였습니다.", StopSign!)
				Return ''
			End If
			ls_buybackNo = left(ls_buybackNo, 7) + String(integer(ls_buybackSeq) + 1, "0000")
//			ls_buybackNo = left(ls_buybackNo, 7) + f_pisr_string1add(mid(ls_buybackNo,12,1))
		End If		
		//dw_buyback.SetItem(1, 'buybackno', ls_buybackNo)

	CASE False
//	  SELECT Max(BuyBackNo)  
//		 INTO :ls_buybackNo  
//		 FROM TPARTBUYBACK	
//		WHERE BuyBackDept 					= :g_s_deptcd 	And
//				SubString(BuyBackNo,5,3) 	= :ls_Month 	And
//				StatusFlag	 					= 'A'
//		USING sqlpis	;
	  SELECT Max(BuyBackNo)  
		 INTO :ls_buybackNo  
		 FROM TPARTBUYBACK	
		WHERE BuyBackDept = :g_s_deptcd 	And
				SubString(Convert(Char(10), buybacktime, 102), 1, 7) = :ls_appMonth
		USING sqlpis	;

		If isNull(ls_buybackNo) Then 
			MessageBox('확인', '작성된 반출증이 없거나 이미 승인이 완료되었습니다.', Information! )
			//dw_buyback.SetItem(1, 'buybackno', ls_null)
			Return ''
		End If		
		//dw_buyback.SetItem(1, 'buybackno', ls_buybackNo)
END CHOOSE

Return ls_buybackNo
end function

public function string wf_getbuybackno ();////////////////////////////////////
//	반출증번호 생성 
// 반출증번호(11) : 부서코드(4),년(1),월(2),SEQ(4) - 간판품목 5001 ~ 9999 까지 생성
////////////////////////////////////

DateTime	ldt_nowTime
String	ls_buybackNo, ls_Month, ls_buybackSeq//, ls_applyDate 
String	ls_Null, ls_nowTime
Integer	li_Year
String	ls_appMonth

SetNull(ls_Null)

ldt_nowTime		= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_nowTime 		= String(ldt_nowTime, "yyyy.mm.dd hh:mm")
ls_appMonth = Left(ls_nowTime,7) 
ls_Month		= Mid(ls_nowTime,4,1) + Mid(ls_nowTime,6,2)

If istr_partkb.divcode = '%' Then 
	MessageBox('확인', '반출처를 선택하세요.', Information! )
	Return ''
End If

If isNull(g_s_deptcd) Or Trim(g_s_deptcd) = '' Then Return ''

SELECT Max(BuyBackNo)  
 	INTO :ls_buybackNo  
 	FROM TPARTBUYBACK	
	WHERE BuyBackDept = :g_s_deptcd 	And
			SubString(Convert(Char(10), buybacktime, 102), 1, 7) = :ls_appMonth
	USING sqlpis	;

If isNull(ls_buybackNo) Then 
	ls_buybackNo = g_s_deptcd + ls_Month + '5001'
Else 
	ls_buybackSeq= mid(ls_buybackNo,8,4)
	If ls_buybackSeq = '9999' Then
		MessageBox( "발행번호생성오류", "발행번호 최대치를 초과하였습니다.", StopSign!)
		Return ''
	End If
	ls_buybackNo = left(ls_buybackNo, 7) + String(integer(ls_buybackSeq) + 1, "0000")
//			ls_buybackNo = left(ls_buybackNo, 7) + f_pisr_string1add(mid(ls_buybackNo,12,1))
End If		

Return ls_buybackNo
end function

on w_pisr135b.create
int iCurrent
call super::create
this.gb_6=create gb_6
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_condition=create dw_condition
this.dw_2=create dw_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.pb_1=create pb_1
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.dw_buyback=create dw_buyback
this.st_2=create st_2
this.cbx_1=create cbx_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_condition
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.gb_5
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.dw_buyback
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.cbx_1
this.Control[iCurrent+16]=this.gb_4
end on

on w_pisr135b.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_condition)
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.dw_buyback)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.gb_4)
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

This.TriggerEvent( "ue_init" )
pb_1.enabled = false

wf_icon_onoff(true,  false,  true,  false,  false,  false,  false ,  false)

end event

event open;call super::open;
dw_condition.SetTransObject(sqlpis)
dw_condition.Reset()
dw_condition.InsertRow(1)
dw_condition.Object.suppliercode_t.Text = '반출처:'

dw_buyback.SetTransObject(sqlpis)
dw_buyback.reset()
dw_buyback.InsertRow(1)

rb_1.Checked = True
is_chkrb = 'rb_1'
// 새 반출증작성시에는 저장시에 반출번호가 적용됨.
dw_buyback.object.buybackno.protect = 1
rb_1.Weight = 700

end event

event ue_retrieve;call super::ue_retrieve;
String	ls_usecenter
Long 		ll_Row
String	ls_BuyBackNo, ls_status

dw_condition.AcceptText()
ls_usecenter	= dw_condition.GetItemString(1, 'suppliercode')

If isNull(ls_usecenter) Or Trim(ls_usecenter) = '' Then 
	ls_usecenter	= '%'
	MessageBox('확인', '조회할 반출처를 입력하세요.', Information! )
	return 0
else
	dw_buyback.setitem( 1, 'buybacksupplier', ls_usecenter)
End If

dw_buyback.AcceptText()
ls_BuyBackNo = dw_buyback.GetItemString(1, 'buybackno')				

if rb_2.checked = true then
	If isNull(ls_BuyBackNo) Or Trim(ls_BuyBackNo) = '' then 
		MessageBox('확인', '반출증번호가 입력되지 않았습니다.', Information! )
		Return 0
	End If
	ls_status = dw_buyback.GetItemString(1, 'StatusFlag')
	if ls_status = 'A' or ls_status = '1' then
		pb_1.enabled = true
	else
		pb_1.enabled = false
		wf_icon_onoff(true,  false,  false,  false,  false,  false,  false ,  false)
		uo_status.st_message.text = "승인된 반출증번호입니다."
		return 0
	end if
else
	ls_buybackno = 'new'
end if
dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, &
				ls_usecenter, ls_BuyBackNo)

If ll_Row < 1 Then 
	MessageBox('확인', '입고처리된 간판중 사용처가 외주업체인 간판이 존재하지 않습니다.', Information! )
End If	

Return 0


end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight 	- ( dw_2.y + ls_status )


end event

event ue_save;call super::ue_save;
Long 		ll_RowCnt, ll_selectChk, ll_rackqty
Long	I, li_Cnt, li_selectCnt
DateTime	ldt_nowTime
String	ls_BuyBackNo, ls_usecenter, ls_BuyBackSeq, ls_takingname
String   ls_buybackdate, ls_carno, ls_buybackflag, ls_itemcode, ls_xuse
String	ls_null, ls_status, ls_costgubun, ls_check, ls_time, ls_backcheck
String	ls_message = ''

setNull(ls_null)

ll_RowCnt	= dw_2.RowCount()

If ll_RowCnt < 1 Then 
	uo_status.st_message.text = "저장할 데이타가 없습니다."
	Return 0
end if 

if is_chkrb = 'rb_1' then
	ls_BuyBackNo   = wf_getbuybackno()
	dw_buyback.setitem( 1, 'buybackno', ls_BuyBackNo)
	dw_buyback.AcceptText()
else
	dw_buyback.AcceptText()
	ls_BuyBackNo	= dw_buyback.GetItemString( 1, 'buybackno' )
end if

ls_usecenter	= dw_buyback.GetItemString( 1, 'buybacksupplier' )
ls_status = dw_buyback.GetItemString( 1, 'StatusFlag')
ls_carno	= dw_buyback.GetItemString( 1, 'carno' )
If isNull(ls_usecenter) Or Trim(ls_usecenter) = '' Then 
	MessageBox("반출증작성오류", "반출처가 입력되지 않았습니다.", StopSign! )
	Return 0
End If	

If isNull(ls_BuyBackNo) Or Trim(ls_BuyBackNo) = '' Then 
	MessageBox("반출증작성오류", "발행번호가 입력되지 않았습니다.", StopSign! )
	Return 0
End If	
If len(trim(ls_BuyBackNo)) <> 11 Then 
	MessageBox("반출증작성오류", "발행번호가 올바르지 않았습니다.", StopSign! )
	Return 0
End If	

ls_BuyBackSeq	 = Mid(ls_BuyBackNo, 8, 4)
If ls_BuyBackSeq < '5001' Or ls_BuyBackSeq > '9999' Then 
	MessageBox("반출증작성오류", "발행번호가 올바르지 않았습니다.", StopSign! )
	Return 0
End If	

If isNull(ls_carno) Or Trim(ls_carno) = '' Then 
	MessageBox("반출증작성오류", "차량번호가 입력되지 않았습니다.", StopSign! )
	Return 0
End If	

ls_takingname	= dw_buyback.GetItemString( 1, 'takingname' )
If isNull(ls_takingname) Or Trim(ls_takingname) = '' Then 
	MessageBox("반출증작성오류", "인수자가 입력되지 않았습니다.", StopSign! )
	Return 0
End If	
ls_backcheck = dw_buyback.GetItemString(1,'backcheck')
If isNull(ls_backcheck) Or Trim(ls_backcheck) = '' Then 
	MessageBox("반출증작성오류", "반출구분이 입력되지 않았습니다.", StopSign! )
	Return 0
End If	
if ls_backcheck = 'A' or ls_backcheck = 'R' then
	ls_buybackflag = 'Y'
	dw_buyback.setitem(1,'buybackflag','Y')
else
	ls_buybackflag = 'N'
	dw_buyback.setitem(1,'buybackflag','N')
end if
ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_buybackdate = String(ldt_nowTime,"yyyymmdd")
li_Cnt		= 0
li_selectCnt= 0 
ls_time = mid(g_s_time,1,2) + mid(g_s_time,4,2) + mid(g_s_time,7,2)
//작성값 설정
dw_buyback.SetItem(1, 'buybacktime'	, ldt_nowTime )
dw_buyback.SetItem(1, 'lastemp'		, 'Y' )	//Interface Flag 활용
dw_buyback.SetItem(1, 'lastdate'		, ldt_nowTime )

sqlca.AutoCommit = False

DELETE FROM "PBINV"."INV302"  
		WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
				( "PBINV"."INV302"."XPLANT" = :istr_partkb.areacode ) AND  
				( "PBINV"."INV302"."DIV" = :istr_partkb.divcode ) AND  
				( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
		using sqlca;
	
DELETE FROM "PBINV"."INV303"  
		WHERE ( "PBINV"."INV303"."COMLTD" = '01' ) AND  
				( "PBINV"."INV303"."XPLANT" = :istr_partkb.areacode ) AND  
				( "PBINV"."INV303"."DIV" = :istr_partkb.divcode ) AND  
				( "PBINV"."INV303"."SLNO" = :ls_buybackno )   
		using sqlca;

//반출번호 Header 저장
INSERT INTO "PBINV"."INV302"  
( "COMLTD", "XPLANT","DIV","SLNO","VSRNO","XDATE","CARNO","RTNPRT","ITYPE",   
  "KBCD","MTYPE","COMREQPLN","COMREQDAT","COMREQTM","COMPLN","COMDAT",   
  "COMTM","DESREQPLN","DESREQDAT","DESREQTM","PRTPLN","PRTDAT","PRTTM",   
  "DESPLN","DESDAT","DESTM","DESCD","STCD","EXTD","INPTID","INPTDT",   
  "UPDTID","UPDTDT","IPADDR","MACADDR" )  
VALUES ( '01', :istr_partkb.areacode, :istr_partkb.divcode, :ls_buybackno,  
  :ls_usecenter,:ls_buybackdate,:ls_carno,:ls_buybackflag,'A',
  'K',' ',:g_s_empno,:g_s_date,:ls_time,' ',' ',
  ' ',' ',' ',' ',:ls_backcheck,' ',' ',
  ' ',' ',' ',' ',' ',' ',:g_s_empno,:g_s_date,
  ' ',' ',:g_s_ipaddr,:g_s_macaddr)  using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = '반출번호 Header저장 에러'
	Goto RollBack_
end if

For I = 1 To ll_RowCnt Step 1
	ll_selectChk	= dw_2.GetItemNumber( I, 'selectchk' )
	If ll_selectChk = 1 Then 
		li_Cnt		 = li_Cnt + 1
		li_selectCnt = li_selectCnt + 1
		dw_2.SetItem(I, 'buybackno'	, ls_BuyBackNo )
		dw_2.SetItem(I, 'lastemp'		, 'Y' )	//Interface Flag 활용
		dw_2.SetItem(I, 'lastdate'		, ldt_nowTime )
		
		ls_itemcode = dw_2.GetItemString( I, 'itemcode')
		if li_selectCnt = 1 then
			ls_check = ls_itemcode
		end if
		if ls_itemcode = ls_check then
//			ls_buybackflag = dw_2.GetItemString( I, 'buybackflag' )
			ll_rackqty = ll_rackqty + dw_2.GetItemNumber( I, 'rackqty')
			ls_costgubun = dw_2.GetItemString( I, 'costgubun')
			if ls_costgubun = 'Y' then
				ls_xuse = '07'
			elseif ls_costgubun = 'N' then
				ls_xuse = '04'
			else
				ls_xuse = ' '
			end if
			continue
		else
			//insert
			INSERT INTO "PBINV"."INV303"  
			( "COMLTD","XPLANT","DIV","SLNO","ITNO", "XUSE","QTY",   
			  "EXTD","INPTID","INPTDT","UPDTID","UPDTDT","IPADDR","MACADDR" )  
			VALUES ( '01', :istr_partkb.areacode, :istr_partkb.divcode, :ls_buybackno,  
			  :ls_check,:ls_xuse,:ll_rackqty,' ',:g_s_empno,:g_s_date,
			  ' ',' ',:g_s_ipaddr,:g_s_macaddr)  
			using sqlca;
			if sqlca.sqlcode <> 0 then
				ls_message = '반출번호 Detail저장 에러'
				Goto RollBack_
			end if
			ls_check = ls_itemcode
//			ls_buybackflag = dw_2.GetItemString( I, 'buybackflag' )
			ll_rackqty = dw_2.GetItemNumber( I, 'rackqty')
			ls_costgubun = dw_2.GetItemString( I, 'costgubun')
			if ls_costgubun = 'Y' then
				ls_xuse = '07'
			elseif ls_costgubun = 'N' then
				ls_xuse = '04'
			else
				ls_xuse = ' '
			end if
		end if	
	Else
		li_Cnt			= li_Cnt + 1
		dw_2.SetItem(I, 'buybackno'	, ls_null )
		dw_2.SetItem(I, 'lastemp'		, 'Y' )	//Interface Flag 활용
		dw_2.SetItem(I, 'lastdate'		, ldt_nowTime )
	End If
Next

//insert
INSERT INTO "PBINV"."INV303"  
( "COMLTD","XPLANT","DIV","SLNO","ITNO", "XUSE","QTY",   
  "EXTD","INPTID","INPTDT","UPDTID","UPDTDT","IPADDR","MACADDR" )  
VALUES ( '01', :istr_partkb.areacode, :istr_partkb.divcode, :ls_buybackno,  
  :ls_itemcode,:ls_xuse,:ll_rackqty,' ',:g_s_empno,:g_s_date,
  ' ',' ',:g_s_ipaddr,:g_s_macaddr)  
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = '마지막 반출번호 Detail저장 에러'
	Goto RollBack_
end if

//저장시작
sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//If li_selectCnt > 0 Then 
	dw_buyback.SetTransObject(Sqlpis)							//간판상태
	If dw_buyback.Update() = -1 Then 
		ls_message = 'buybackUpdate_Err'
	//	MessageBox("반출증작성오류", "반출증정보 저장에서 오류가 발생하였습니다.", StopSign! )
		Goto RollBack_			
	End If
//Else 
//	//?
//End If

dw_2.SetTransObject(Sqlpis)									//간판상태
If dw_2.Update() = -1 Then 
	ls_message = 'Update_Err'
//	MessageBox("반출증작성오류", "반출간판정보 Update에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
Commit Using sqlca;
sqlca.AutoCommit = True

rb_2.checked = true
This.TriggerEvent( "ue_retrieve" )
//SetPointer(Arrow!)
MessageBox("반출증작성완료", String(li_selectCnt) + " 건의 간판에 대한 반출증을 작성 하였습니다.", Information! )
pb_1.enabled = true
Return 0


RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
RollBack Using sqlca;
sqlca.AutoCommit = True
SetPointer(Arrow!)

If	ls_message = 'buybackUpdate_Err' Then
	MessageBox("반출증작성오류", "반출증정보 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'Update_Err' Then
	MessageBox("반출증작성오류", "반출간판정보 Update에서 오류가 발생하였습니다.", StopSign! )
Else
	MessageBox("반출증작성오류", "승인요청에 실패하였습니다.", StopSign! )
End If

return -1
end event

event activate;call super::activate;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  true,  false,  false,  false,  false, false)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr135b
end type

type gb_6 from groupbox within w_pisr135b
integer x = 1993
integer width = 539
integer height = 192
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_area from u_pisc_select_area within w_pisr135b
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
dw_condition.Object.suppliercode_t.Text = '반출처:'

dw_buyback.Reset()
dw_buyback.InsertRow(1)
//dw_scan.setItem(1, 'scancode', '')

dw_2.Reset()


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr135b
integer x = 571
integer y = 72
integer width = 539
integer height = 68
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)
dw_condition.Object.suppliercode_t.Text = '반출처:'

dw_buyback.Reset()
dw_buyback.InsertRow(1)
//dw_scan.setItem(1, 'scancode', '')

dw_2.Reset()

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_condition from datawindow within w_pisr135b
integer x = 114
integer y = 240
integer width = 2775
integer height = 100
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition3"
boolean border = false
end type

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_deptcode//, ls_deptname
String	ls_Null, ls_buybackNo 
//DataWindowChild ldwc

this.AcceptText()

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
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

If rb_1.Checked Then
	dw_buyback.Reset()
	dw_buyback.SetTransObject(sqlpis)
	dw_buyback.InsertRow(1)
	//ls_buybackNo = wf_setbuybackno()
	//dw_buyback.SetItem(1, 'buybackno'	, ls_buybackNo)
	dw_buyback.SetItem(1, 'areacode'		, istr_partkb.areaCode)
	dw_buyback.SetItem(1, 'divisioncode', istr_partkb.divCode)
	dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd)
	dw_buyback.SetItem(1, 'buybacksupplier', data )
	dw_buyback.SetItem(1, 'deptname'		, is_deptname)
	dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno)
	dw_buyback.SetItem(1, 'empname'		, is_empname)
	Return 0
Else
	rb_2.TriggerEvent("clicked")
//	dw_buyback.Reset()
//	dw_buyback.SetTransObject(sqlpis)
//	dw_buyback.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_buybackNo, g_s_deptcd)
End If

Return
	
end event

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname, ls_buybackNo

ls_buttonname 	= dwo.name

istr_partkb.flag = 2			//외주업체(전체)
OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)

If rb_1.Checked Then
	dw_buyback.SetTransObject(sqlpis)
	dw_buyback.reset()
	dw_buyback.InsertRow(1)
	//ls_buybackNo = wf_setbuybackno()
	//dw_buyback.SetItem(1, 'buybackno'	, ls_buybackNo)
	dw_buyback.SetItem(1, 'areacode'		, istr_partkb.areaCode)
	dw_buyback.SetItem(1, 'divisioncode', istr_partkb.divCode)
	dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd)
	dw_buyback.SetItem(1, 'buybacksupplier', lstr_Rtn.code )
	dw_buyback.SetItem(1, 'deptname'		, is_deptname)
	dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno)
	dw_buyback.SetItem(1, 'empname'		, is_empname)
	Return 0
Else
	rb_2.TriggerEvent("clicked")
//	dw_buyback.Reset()
//	dw_buyback.SetTransObject(sqlpis)
//	dw_buyback.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_buybackNo, g_s_deptcd)
End If

Return

end event

event itemerror;
return 1
end event

type dw_2 from u_vi_std_datawindow within w_pisr135b
integer x = 23
integer y = 828
integer width = 3058
integer height = 748
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr135b_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;call super::buttonclicked;
Long		ll_RowCnt
INteger	li_i

ll_RowCnt = This.RowCount()

If ll_RowCnt < 1 Then Return

FOR li_i = ll_RowCnt To 1 Step -1
	dw_2.SetItem( li_i, 'selectchk', 1 )
Next

Return
end event

type rb_1 from radiobutton within w_pisr135b
integer x = 1253
integer y = 80
integer width = 311
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "새반출"
end type

event clicked;
rb_1.Weight = 700
rb_2.Weight = 400

String	ls_buybackNo, ls_buybacksupplier

is_chkrb = 'rb_1'
dw_condition.Accepttext()
ls_buybacksupplier = dw_condition.GetItemString(1, 'suppliercode')
dw_2.Reset()

// 새 반출증작성시에는 저장시에 반출번호가 적용됨.
dw_buyback.object.buybackno.protect = 1
//ls_buybackNo = wf_setbuybackno()

dw_buyback.Reset()
dw_buyback.InsertRow(1)
//dw_buyback.SetItem(1, 'buybackno'	, ls_buybackNo)
dw_buyback.SetItem(1, 'areacode'		, istr_partkb.areaCode )
dw_buyback.SetItem(1, 'divisioncode', istr_partkb.divCode )
dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd )
dw_buyback.SetItem(1, 'deptname'		, is_deptname )
dw_buyback.SetItem(1, 'buybacksupplier', ls_buybacksupplier )
dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno )
dw_buyback.SetItem(1, 'empname'		, is_empname )


end event

type rb_2 from radiobutton within w_pisr135b
integer x = 1573
integer y = 80
integer width = 370
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기존반출"
end type

event clicked;rb_1.Weight = 400
rb_2.Weight = 700

String	ls_buybackNo

is_chkrb = 'rb_2'
dw_2.Reset()
dw_buyback.object.buybackno.protect = 0

//ls_buybackNo = wf_setbuybackno()
//If ls_buybackNo = '' Then
//	rb_1.Checked = True
//	rb_1.TriggerEvent( "clicked")
//	Return
//else
//	
//End If

//dw_buyback.Reset()
//dw_buyback.SetTransObject(sqlpis)
//dw_buyback.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_buybackNo, g_s_deptcd)

end event

type gb_1 from groupbox within w_pisr135b
integer x = 23
integer width = 1147
integer height = 192
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_1 from picturebutton within w_pisr135b
integer x = 2921
integer y = 44
integer width = 206
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\E-mail.gif"
string disabledname = "NotFound!"
vtextalign vtextalign = vcenter!
end type

event clicked;Int li_Rtn
string ls_mail, ls_buybackno, ls_buybackdept, ls_message

ls_buybackno = dw_buyback.getitemstring(1,"BuyBackno")
ls_buybackdept = dw_buyback.getitemstring(1,"BuyBackdept")

if f_spacechk(ls_buybackno) = -1 then
	uo_status.st_message.text = "반출정보가 존재하지 않습니다."
	return 0
end if
li_Rtn = MessageBox('확인!', '발행번호 : ' + ls_buybackno + &
					' 인 사급자재를 확정요청 하시겠습니까?', Question!, YesNo! )

If li_Rtn = 2 Then Return 0

SetPointer(HourGlass!)

//각공장별로 지정된 확정자에게 확정요청메일 발송.
DECLARE cur_getmail CURSOR FOR
  SELECT BB.PEMAIL 
    FROM "PBINV"."INV308" AA INNER JOIN "PBCOMMON"."DAC003" BB
		ON AA.XPLAN = BB.PEEMPNO
   WHERE ( AA."COMLTD" = '01' ) AND
			( AA."ITYPE" = 'A' ) AND
         ( AA."XPLANT" = :istr_partkb.areacode ) AND  
         ( AA."DIV" = :istr_partkb.divcode )   using sqlca;
open cur_getmail;
do while true
	fetch cur_getmail into :ls_mail;
	if sqlca.sqlcode <> 0 then
		exit
	end if
	if f_spacechk(ls_mail) <> -1 then
		if f_SendMail( trim(ls_mail), "사급자재(간판) 반출 확정요청", &
			"발행번호 : " + ls_buybackno + " 인 사급자재를 확정요청합니다. (" + &
			g_s_kornm + ") " + g_s_datetime, "" ) = 1 then
			uo_status.st_message.text = ""
			return 0
		end if
	end if
loop
close cur_getmail;

//확정요청 상태코드 업데이트
// 'A' : 반출입력, '1' : 확정요청, '2' : 확정, '3' : 승인요청, 'C' : 승인
sqlpis.AutoCommit = False
sqlca.AutoCommit = False

UPDATE TPARTBUYBACK  
     SET StatusFlag = '1'  
   WHERE ( TPARTBUYBACK.AreaCode = :istr_partkb.areacode ) AND  
         ( TPARTBUYBACK.DivisionCode = :istr_partkb.divcode ) AND  
         ( TPARTBUYBACK.BuyBackNo = :ls_buybackno ) AND  
         ( TPARTBUYBACK.BuyBackDept = :ls_buybackdept )   
	using sqlpis;

if sqlpis.sqlnrows < 1 then
	ls_message = "IPIS 확정요청업데이트 에러"
	goto Rollback_
end if

UPDATE "PBINV"."INV302"  
     SET "STCD" = '1'  
   WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
         ( "PBINV"."INV302"."XPLANT" = :istr_partkb.areacode ) AND  
         ( "PBINV"."INV302"."DIV" = :istr_partkb.divcode ) AND  
         ( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
	using sqlca;

if sqlca.sqlnrows < 1 then
	ls_message = "INV 확정요청업데이트 에러"
	goto Rollback_
end if

Commit using sqlpis;
sqlpis.AutoCommit = True
Commit using sqlca;
sqlca.AutoCommit = True

// 확정요청되었습니다.
uo_status.st_message.Text = "확정요청이 완료되었습니다."

//메일 전송완료
pb_1.enabled = false

return 0

Rollback_:
Rollback using sqlpis;
sqlpis.AutoCommit = True
Rollback using sqlca;
sqlca.AutoCommit = True

uo_status.st_message.Text = "확정요청이 실패하였습니다."
pb_1.enabled = true

return -1
end event

type gb_5 from groupbox within w_pisr135b
integer x = 1193
integer width = 777
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisr135b
integer x = 2560
integer width = 626
integer height = 192
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr135b
integer x = 23
integer y = 180
integer width = 2894
integer height = 188
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

type dw_buyback from datawindow within w_pisr135b
integer x = 32
integer y = 380
integer width = 3323
integer height = 420
integer taborder = 110
string title = "none"
string dataobject = "d_pisr135b_02"
boolean border = false
boolean livescroll = true
end type

event itemerror;
return 1
end event

event itemchanged;
//////////////////////////////////////
// 반출증 내용 편집
//////////////////////////////////////
String 	ls_colName
String	ls_deptname, ls_suppcode
String	ls_Null 
String	ls_areacode, ls_divcode, ls_BuyBackNo, ls_deptcode, ls_usecenter

SetNull(ls_Null)

dw_condition.AcceptText()
ls_suppcode = dw_condition.GetItemString(1, 'suppliercode')
If isNull(ls_suppcode) Or trim(ls_suppcode) = '' Then 
	MessageBox( "확인", "반출처가 선택되지 않았습니다.", StopSign! )
	This.SetItem(1, 'buybackno', ls_Null )
	This.SetFocus()
	Return 1
End If


ls_colName = This.GetcolumnName()

Choose Case ls_colName
	Case 'buybackno'

			dw_2.Reset()
			
//			If len(data) <> 10 Then 
//				MessageBox( "발행번호오류", "발행번호가 올바르지 않습니다.", StopSign! )
//				This.SetItem(1, 'buybackno', ls_Null )
//				This.SetFocus()
//				Return 1
//			End If
			
			  SELECT AreaCode, DivisionCode,	BuyBackNo, BuyBackDept,	BuyBackSupplier
				 INTO :ls_areacode, :ls_divcode, :ls_BuyBackNo, :ls_deptcode, :ls_usecenter
				 FROM TPARTBUYBACK  
				WHERE BuyBackNo = :data
				USING sqlpis       ;

			If sqlpis.SqlCode <> 0 Then 
				MessageBox( "발행번호확인", "발행번호가 올바르지 않거나 이미 승인처리된 번호입니다.", Information! )
				This.SetItem(1, 'buybackno', ls_Null )
				This.SetFocus()
				Return 1
			End If	
			If ls_areacode <> istr_partkb.areacode Then
				MessageBox( "발행번호확인", "해당 지역의 발행번호가 아닙니다.", Information! )
				This.SetItem(1, 'buybackno', ls_Null )
				This.SetFocus()
				Return 1
			End If				
			If ls_divcode <> istr_partkb.divcode Then
				MessageBox( "발행번호확인", "해당 공장의 발행번호가 아닙니다.", Information! )
				This.SetItem(1, 'buybackno', ls_Null )
				This.SetFocus()
				Return 1
			End If				
//			If ls_deptcode <> g_s_deptcd Then
//				MessageBox( "발행번호확인", "해당 부서의 발행번호가 아닙니다.", Information! )
//				This.SetItem(1, 'buybackno', ls_Null )
//				This.SetFocus()
//				Return 1
//			End If				
			If ls_usecenter <> ls_suppcode Then
				MessageBox( "발행번호확인", "해당 사용처의 발행번호가 아닙니다.", Information! )
				This.SetItem(1, 'buybackno', ls_Null )
				This.SetFocus()
				Return 1
			End If				
			dw_buyback.SetRedraw(False)
			dw_buyback.SetTransObject(sqlpis)
			dw_buyback.Retrieve( istr_partkb.areacode, istr_partkb.divcode, data, ls_deptcode )
			dw_buyback.SetRedraw(True)
	Case 'backcheck'
		choose case data
			case 'R'
				This.setitem(row,'carno','수작업')
			case 'D'
				This.setitem(row,'carno','직반출')
			case 'C'
				This.setitem(row,'carno','사내반출')
		end choose
	Case 'carno' 
	Case 'takingname' 
	Case 'remark' 
End Choose 


end event

type st_2 from statictext within w_pisr135b
integer x = 2592
integer y = 84
integer width = 325
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "확정요청"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_pisr135b
integer x = 2039
integer y = 84
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "반출증대상"
boolean lefttext = true
end type

event clicked;//Parent.Triggerevent('ue_retrieve')
end event

type gb_4 from groupbox within w_pisr135b
integer x = 23
integer y = 344
integer width = 3346
integer height = 468
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

