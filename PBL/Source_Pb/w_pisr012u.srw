$PBExportHeader$w_pisr012u.srw
$PBExportComments$외주업체 납입주기등록 및 변경
forward
global type w_pisr012u from window
end type
type sle_division from singlelineedit within w_pisr012u
end type
type st_3 from statictext within w_pisr012u
end type
type sle_area from singlelineedit within w_pisr012u
end type
type st_2 from statictext within w_pisr012u
end type
type pb_3 from picturebutton within w_pisr012u
end type
type pb_2 from picturebutton within w_pisr012u
end type
type pb_1 from picturebutton within w_pisr012u
end type
type dw_oldtime from datawindow within w_pisr012u
end type
type dw_newtime from datawindow within w_pisr012u
end type
type dw_cycle from datawindow within w_pisr012u
end type
type gb_1 from groupbox within w_pisr012u
end type
end forward

global type w_pisr012u from window
integer width = 1819
integer height = 1900
boolean titlebar = true
string title = "납입주기등록및수정"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
sle_division sle_division
st_3 st_3
sle_area sle_area
st_2 st_2
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_oldtime dw_oldtime
dw_newtime dw_newtime
dw_cycle dw_cycle
gb_1 gb_1
end type
global w_pisr012u w_pisr012u

type variables
str_pisr_partkb 	istr_partkb
String 	is_hisFlag 	// 'N' : 신규등록, 'Y' : 수정후저장
String 	is_saveFlag 	// 'N' : 저장불능, 'Y' : 저장가능
String 	is_lastDate, is_inputDate
Boolean	ib_Open
Integer	ii_saveCount
end variables

forward prototypes
public function integer wf_setnapiptime (integer ai_editcnt, string as_pkchgchk)
public function integer wf_supplyterm_validchk (string as_colname, integer ai_suppterm, integer ai_suppeditno, integer ai_suppcycle)
public function integer wf_history_save (string as_suppcode, string as_applydate)
public function string wf_allinputchk (datawindow ad_dw, ref string as_colname)
public function integer wf_win_reset (string as_suppcode)
public function integer wf_setnapipeditno (string as_applyfrom)
end prototypes

public function integer wf_setnapiptime (integer ai_editcnt, string as_pkchgchk);Integer li_pCnt, I 
String ls_applyFrom
Long ll_insRow 

li_pCnt = ai_editCnt - dw_newtime.RowCount()
ls_applyFrom = dw_cycle.GetItemString( 1, "ApplyFrom" )

If as_pkchgChk = '' Then 
	
	If li_pCnt > 0 Then 
		For I = 1 To li_pCnt 
			wf_setnapipeditno(ls_applyFrom)
		Next 
	Else
		For I = 1 to abs(li_pCnt) 
			dw_newtime.DeleteRow(dw_newtime.RowCount()) 
		Next 
	End If 
Else
	dw_newtime.Reset() 
	For I = 1 To ai_editCnt 
		wf_setnapipeditno(ls_applyFrom)
	Next 
End If 

Return li_pCnt

end function

public function integer wf_supplyterm_validchk (string as_colname, integer ai_suppterm, integer ai_suppeditno, integer ai_suppcycle);String ls_mess 
Integer li_Null 

SetNull(li_Null)

If ai_suppTerm > 1 Then 
	If as_colname = 'supplyeditno' And ai_suppeditno <> 1 Then 
		ls_mess = '납입편수'
		Goto Valid_not 
	End If
	ai_suppEditNo = 1 
ElseIf ai_suppTerm = 1 Then
	If ai_suppEditNo > ai_suppCycle Then 
		If mod(ai_suppEditNo, ai_suppCycle) <> 0 Then 
			ls_mess = '납입편수'
			Goto Valid_not 
		End If
	ElseIf ai_suppCycle > ai_suppEditNo Then 
		If mod(ai_suppCycle, ai_suppEditNo) <> 0 Then 
			ls_mess = '납입Cycle'
			Goto Valid_not 
		End If
	End If
Else
	ls_mess = '납입Term'
	Goto Valid_not
End If 
Return 0 

Valid_not:
//f_MessageBox(Information!, 999, "입력오류", ls_mess + " 잘못된 값을 입력하셨습니다.")
MessageBox( "입력오류", ls_mess + " 잘못된 값을 입력하셨습니다.", Information!)

dw_cycle.SetItem( dw_cycle.GetRow(), as_colName, li_Null)

Return -1 
end function

public function integer wf_history_save (string as_suppcode, string as_applydate);String 	ls_applyto, ls_maxdate
Integer 	I
DateTime ldt_nowtime

ls_applyto = f_pisr_getdaybefore( as_applydate, -1 )		//적용종료일 신규적용시작일 - 1일
ls_maxdate = '9999.12.31'
ldt_nowtime = f_pisc_get_date_nowtime()		//현재 시스템시간
  
  UPDATE TMSTPARTCYCLE  
     SET ApplyTo 	= :ls_applyto,
	  		LastEmp 	= 'Y',
			LastDate = :ldt_nowtime
   WHERE AreaCode 		= :istr_partkb.areacode AND  
         DivisionCode 	= :istr_partkb.divcode 	AND  
         SupplierCode 	= :istr_partkb.suppcode AND  
         ApplyTo 	  		= :ls_maxdate    
   USING sqlpis     ;

IF sqlpis.SqlCode <> 0 THEN
	return -1
END IF

For I = 1 To dw_oldtime.RowCount() 
	dw_oldtime.SetItem(I, "applyto"	, ls_applyTo)
	dw_oldtime.SetItem(I, "lastemp"	, 'Y')
	dw_oldtime.SetItem(I, "lastdate"	, ldt_nowtime)
Next 
IF dw_oldtime.Update() = -1 THEN
	return -1
END IF

Return 0
	
end function

public function string wf_allinputchk (datawindow ad_dw, ref string as_colname);Long ll_getRow 
String ls_Data, ls_message 
Integer li_Data 

ll_getRow = ad_dw.GetRow()

ls_Data = ad_dw.GetItemString(ll_getRow, "areacode")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '지역코드' 
as_colname = 'divisioncode'; If ls_message <> '' Then Return ls_message
ls_Data = ad_dw.GetItemString(ll_getRow, "divisioncode")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '공장코드' 
as_colname = 'divisioncode'; If ls_message <> '' Then Return ls_message
ls_Data = ad_dw.GetItemString(ll_getRow, "suppliercode")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '업체코드'
as_colname = 'suppliercode';If ls_message <> '' Then Return ls_message
ls_Data = ad_dw.GetItemString(ll_getRow, "applyfrom")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '적용일자'
as_colname = 'applyfrom';If ls_message <> '' Then Return ls_message
li_Data = ad_dw.GetItemNumber(ll_getRow, "supplyterm")
If IsNull(li_Data) or trim(ls_data) = '' Then ls_message = '납기주기'
as_colname = 'supplyterm';If ls_message <> '' Then Return ls_message
li_Data = ad_dw.GetItemNumber(ll_getRow, "supplyeditno")
If IsNull(li_Data) or trim(ls_data) = '' Then ls_message = '납기주기'
as_colname = 'supplyeditno';If ls_message <> '' Then Return ls_message
li_Data = ad_dw.GetItemNumber(ll_getRow, "supplycycle")
If IsNull(li_Data) or trim(ls_data) = '' Then ls_message = '납기주기'
as_colname = 'supplycycle';If ls_message <> '' Then Return ls_message

Return '' 
end function

public function integer wf_win_reset (string as_suppcode);//////////////////////////////////////////////////////
//     선택한 외주업체가 변경된 경우 윈도우 리셋 
//////////////////////////////////////////////////////

dw_cycle.Reset()
dw_cycle.SetTransObject(sqlpis)
dw_cycle.InsertRow(1)

/////////→입력한 업체코드의 Valid Check
String	ls_suppNo, ls_suppName

  SELECT TMSTSUPPLIER.SupplierNo,   
			TMSTSUPPLIER.SupplierKorName  
	 INTO :ls_suppNo,   
			:ls_suppName  
	 FROM TMSTSUPPLIER  
	WHERE TMSTSUPPLIER.SupplierCode = :as_suppcode
	USING sqlpis	;

	IF sqlpis.SqlCode <> 0 THEN
		MessageBox( "입력오류", "입력하신 업체코드가 올바르지 않습니다.", StopSign! )
		is_saveFlag = 'N'			//저장불능
		return -1
	END IF

dw_cycle.SetItem(1 , "areacode"			, istr_partkb.areacode )
dw_cycle.SetItem(1 , "divisioncode"		, istr_partkb.divcode )
dw_cycle.SetItem(1 , "suppliercode"		, as_suppcode )
dw_cycle.SetItem(1 , "supplierno"		, ls_suppNo )
dw_cycle.SetItem(1 , "supplierkorname"	, ls_suppName )

/////////→해당업체 기존납입주기 확인
String 	ls_cycleDate, ls_mstDate, ls_orderDate
Integer	li_SupplyTerm, li_SupplyEditNo, li_SupplyCycle
String	ls_maxDate = '9999.12.31'
String	ls_jobDate
DateTime	ldt_nowTime
Long		ll_null
setNull(ll_null)

ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )	//기준일자 -8시간고려함
is_lastDate = f_pisr_getdaybefore( ls_jobDate, -1)		//시스템 기준의 어제일자

  SELECT TMSTPARTCYCLE.ApplyFrom,   
         TMSTPARTCYCLE.SupplyTerm,   
         TMSTPARTCYCLE.SupplyEditNo,   
         TMSTPARTCYCLE.SupplyCycle  
    INTO :ls_cycleDate,   					//최근 수정된 납입주기적용시작일
         :li_SupplyTerm,   
         :li_SupplyEditNo,   
         :li_SupplyCycle  
    FROM TMSTPARTCYCLE  
   WHERE TMSTPARTCYCLE.AreaCode 		= :istr_partkb.areacode AND  
         TMSTPARTCYCLE.DivisionCode = :istr_partkb.divcode  AND  
         TMSTPARTCYCLE.SupplierCode = :as_suppcode AND  
         TMSTPARTCYCLE.ApplyTo 		= :ls_maxDate    
	USING	sqlpis	;
	
	IF sqlpis.SqlCode <> 0 THEN
		ls_cycleDate	= is_lastDate		
		is_hisFlag 		= 'N'					//신규등록
      setNull(li_SupplyTerm); setNull(li_SupplyEditNo); setNull(li_SupplyCycle)    
	Else
		is_hisflag = 'Y'
	End If
	dw_cycle.Object.t_nowapplyfrom.Text 	= ls_cycleDate
	dw_cycle.Object.t_supplyterm.Text 	= String(li_SupplyTerm)
	dw_cycle.Object.t_supplyeditno.Text	= String(li_SupplyEditNo)
	dw_cycle.Object.t_supplycycle.Text 	= String(li_SupplyCycle)
	
	dw_oldtime.SetRedraw(False)
	dw_oldtime.SetTransObject(sqlpis) 
	dw_oldtime.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_cycleDate, as_suppcode) 
	dw_oldtime.SetRedraw(True)
	
//  SELECT Max( TMSTPARTKB.ApplyFrom )  
//    INTO :ls_mstDate  						//최근 수정된 외주간판적용시작일
//    FROM TMSTPARTKB  
//   WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode  AND  
//         TMSTPARTKB.DivisionCode = :istr_partkb.divcode   AND  
//         TMSTPARTKB.SupplierCode = :as_suppcode    
//   USING sqlpis      ;
//	IF sqlpis.SqlCode <> 0 THEN
//		ls_mstDate = is_lastDate
//	END IF

  SELECT Max( TPARTLASTEDIT.PartLastEditDate )  
    INTO :ls_orderDate  					//최근 간판발주일
    FROM TPARTLASTEDIT  
   WHERE TPARTLASTEDIT.AreaCode 		= :istr_partkb.areacode  AND  
         TPARTLASTEDIT.DivisionCode = :istr_partkb.divcode   AND  
         TPARTLASTEDIT.SupplierCode = :as_suppcode				 AND  
         TPARTLASTEDIT.OrderGubun 	= 'A'    
   USING sqlpis      ;

	IF sqlpis.SqlCode <> 0 THEN
		ls_orderDate = is_lastDate
	END IF

IF ls_cycleDate > is_lastDate THEN is_lastDate = ls_cycleDate
IF ls_mstDate 	 > is_lastDate THEN is_lastDate = ls_mstDate
IF ls_orderDate > is_lastDate THEN is_lastDate = ls_orderDate
is_lastDate = f_pisr_getdaybefore( is_lastDate, 1)

dw_cycle.SetItem(1 , "applyfrom"		, is_lastDate )
dw_cycle.SetItem(1 , "applyto"		, ls_maxDate )
dw_cycle.SetItem(1 , "SupplyTerm"	, ll_null )
dw_cycle.SetItem(1 , "SupplyEditNo"	, ll_null )
dw_cycle.SetItem(1 , "SupplyCycle"	, ll_null )

dw_newtime.ReSet()
dw_newtime.SetTransObject(sqlpis)

return 0

end function

public function integer wf_setnapipeditno (string as_applyfrom);Long ll_insRow 
String ls_maxdate = '9999.12.31'

ll_insRow = dw_newtime.InsertRow(0)

dw_newtime.SetItem(ll_insRow, "areacode"		, istr_partkb.areaCode)
dw_newtime.SetItem(ll_insRow, "divisioncode"	, istr_partkb.divCode)
dw_newtime.SetItem(ll_insRow, "suppliercode"	, istr_partkb.suppCode)
dw_newtime.SetItem(ll_insRow, "applyfrom"		, as_applyfrom)
dw_newtime.SetItem(ll_insRow, "parteditno"	, ll_insRow)
dw_newtime.SetItem(ll_insRow, "applyto"		, ls_maxdate)

Return 0 
end function

on w_pisr012u.create
this.sle_division=create sle_division
this.st_3=create st_3
this.sle_area=create sle_area
this.st_2=create st_2
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_oldtime=create dw_oldtime
this.dw_newtime=create dw_newtime
this.dw_cycle=create dw_cycle
this.gb_1=create gb_1
this.Control[]={this.sle_division,&
this.st_3,&
this.sle_area,&
this.st_2,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.dw_oldtime,&
this.dw_newtime,&
this.dw_cycle,&
this.gb_1}
end on

on w_pisr012u.destroy
destroy(this.sle_division)
destroy(this.st_3)
destroy(this.sle_area)
destroy(this.st_2)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_oldtime)
destroy(this.dw_newtime)
destroy(this.dw_cycle)
destroy(this.gb_1)
end on

event open;Long 		ll_rowcount
String	ls_sleText

ib_Open = True
ii_saveCount = 0

f_pisc_win_center_move(this)		//POPUP 화면가운데 정렬

istr_partkb = Message.PowerObjectParm	//Argumant 받기 

  SELECT TMSTAREA.AreaName  
    INTO :ls_sleText  
    FROM TMSTAREA  
   WHERE TMSTAREA.AreaCode = :istr_partkb.areacode   
	USING	sqlpis	;
	
sle_area.Text = ls_sleText

  SELECT TMSTDIVISION.DivisionName  
    INTO :ls_sleText  
    FROM TMSTDIVISION  
   WHERE TMSTDIVISION.AreaCode 		= :istr_partkb.areacode AND  
         TMSTDIVISION.DivisionCode 	= :istr_partkb.divcode   
	USING	sqlpis	;

sle_division.Text = ls_sleText

dw_cycle.ReSet()
dw_cycle.SetTransObject(sqlpis)
dw_cycle.InsertRow(1)
wf_win_reset( istr_partkb.suppcode )

end event

type sle_division from singlelineedit within w_pisr012u
integer x = 768
integer y = 60
integer width = 384
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_pisr012u
integer x = 581
integer y = 72
integer width = 187
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "공장:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_area from singlelineedit within w_pisr012u
integer x = 247
integer y = 60
integer width = 320
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisr012u
integer x = 69
integer y = 72
integer width = 201
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "지역:"
boolean focusrectangle = false
end type

type pb_3 from picturebutton within w_pisr012u
integer x = 681
integer y = 1656
integer width = 357
integer height = 136
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "복원"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;dw_cycle.TriggerEvent("undo_data")
end event

type pb_2 from picturebutton within w_pisr012u
integer x = 1403
integer y = 1656
integer width = 357
integer height = 136
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;closewithreturn(parent, String(ii_savecount))
end event

type pb_1 from picturebutton within w_pisr012u
integer x = 1042
integer y = 1656
integer width = 357
integer height = 136
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;dw_cycle.TriggerEvent("save_data")
end event

type dw_oldtime from datawindow within w_pisr012u
integer x = 919
integer y = 748
integer width = 841
integer height = 892
boolean enabled = false
string title = "none"
string dataobject = "d_pisr012u_03"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_newtime from datawindow within w_pisr012u
integer x = 18
integer y = 748
integer width = 841
integer height = 896
integer taborder = 30
string title = "none"
string dataobject = "d_pisr012u_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String 	ls_colName, ls_Null, ls_Time

setNull(ls_Null)

ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'inputtime'
		ls_Time = left( data, 2 ) + ':' + mid( data, 3, 2 )
		IF Not IsTime(ls_Time) THEN
			MessageBox( "입력오류", "입력값이 올바르지 않습니다. ~r~n" + &
											"납입시간을 HH:MM 형식으로 입력하세요!", Information! )
			this.SetItem( row, 'inputtime', ls_Null )
			this.SetFocus()
			Return 1
		END IF
		this.SetItem( row, 'partedittime', ls_Time )
End Choose 

return 0
end event

event itemerror;return 1
end event

type dw_cycle from datawindow within w_pisr012u
event type long save_data ( )
event type long undo_data ( )
integer x = 18
integer y = 188
integer width = 1742
integer height = 592
integer taborder = 20
string title = "none"
string dataobject = "d_pisr012u_01"
boolean border = false
boolean livescroll = true
end type

event type long save_data();String 	ls_suppcode, ls_mess, ls_chkColNm, ls_applyfrom, ls_Data
Long 		ll_getRow
Integer	I
String	ls_message = ''
Long		ll_oldterm, ll_oldeditno, ll_oldcycle
Long		ll_newterm, ll_neweditno, ll_newcycle
String	ls_maxdate = '9999.12.31'
DateTime ldt_nowtime

This.AcceptText()
dw_newtime.AcceptText()

If is_saveflag = 'N' Then Return -1 

ls_mess = wf_allinputChk(This, ls_chkColNm)
If ls_mess <> '' Then 
	MessageBox("입력오류", ls_mess + " 이(가) 입력되지 않았습니다.", StopSign!)
	This.Setcolumn(ls_chkColNm); This.SetFocus() 
	Return -1 
End If

ll_getRow = dw_newtime.GetRow()
For I = 1 To ll_getRow
	ls_Data = dw_newtime.GetItemString(I, "partedittime")
	If IsNull(ls_data) or trim(ls_data) = '' Then 
		MessageBox("입력오류", "납입시간" + " 이(가) 입력되지 않았습니다.", StopSign!)
		Return -1 
	End IF
Next

ls_suppcode 	= this.GetItemString( 1, "suppliercode" )
ls_applyfrom 	= this.GetItemString( 1, "applyfrom" )
ldt_nowtime 	= f_pisc_get_date_nowtime()		//현재 시스템시간

/////////////////////////////////////////////////// AutoCommit = False
sqlpis.AutoCommit = False
SetPointer(HourGlass!)


If is_hisflag <> 'N' Then //1. 업체납입주기 및 편수별 시간 History생성
	//이전 납입주기 
  SELECT SupplyTerm,   
         SupplyEditNo,   
         SupplyCycle  
    INTO :ll_oldterm,   
         :ll_oldeditno,   
         :ll_oldcycle  
    FROM TMSTPARTCYCLE  
   WHERE AreaCode 		= :istr_partkb.areacode AND  
         DivisionCode 	= :istr_partkb.divcode 	AND  
         SupplierCode 	= :istr_partkb.suppcode AND  
         ApplyTo 	  		= :ls_maxdate    
   USING	sqlpis	;
	
	//업체납입주기 및 편수별 시간 History생성
	If wf_history_save( ls_suppcode, ls_applyfrom ) <> 0 Then //2.
		ls_message = "wf_history_save"
		Goto RollBack_
	End If	//2.
	
	// 수정 납입주기
		ll_newterm 		= this.GetItemNumber( 1, "supplyterm" )
		ll_neweditno 	= this.GetItemNumber( 1, "supplyeditno" )
		ll_newcycle 	= this.GetItemNumber( 1, "supplycycle" )

	// 납입주기가 변경되면 개별 간판 재출력 메세지 설정
	If ll_oldterm <> ll_newterm Or ll_oldeditno <> ll_neweditno Or ll_oldcycle <> ll_newcycle Then //3.
		  UPDATE TPARTKBSTATUS  
			  SET RePrintFlag = 'Y',  
					LastEmp		= 'Y',
					LastDate		= :ldt_nowtime
			WHERE TPARTKBSTATUS.AreaCode 		= :istr_partkb.areacode AND  
					TPARTKBSTATUS.DivisionCode = :istr_partkb.divcode 	AND  
					TPARTKBSTATUS.SupplierCode = :ls_suppcode    
			USING	sqlpis        ;
		If sqlpis.SqlCode = -1 Then //4.
			ls_message = 'TPARTKBSTATUS'
			goto RollBack_	//개별 간판 재출력 요구
		End If	//4.
	End If	//3.
Else		//1.
	ii_savecount = ii_savecount + 1
End If	//1.

this.SetItem(1, 'lastemp'	, 'Y')
this.SetItem(1, 'lastdate'	, ldt_nowtime)

This.SetTransObject(sqlpis)
If This.Update() = -1 Then 
	ls_message = 'CycleUpdate'
	goto RollBack_	//업체납입주기 저장
End If

For I = 1 To dw_newtime.RowCount() 
	dw_newtime.SetItem(I, "lastemp"	, 'Y')
	dw_newtime.SetItem(I, "lastdate"	, ldt_nowtime)
Next 
dw_newtime.SetTransObject(sqlpis)
If dw_newtime.Update() = -1 Then 
	ls_message = 'TimeUpdate'
	goto RollBack_ //납입편수별 시간 저장
End If

//f_pisr_sqlchkopt(Sqlpis, True)
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox( "저장완료", "납입주기등록(변경)이 올바로 실행되었습니다.", Information! )

is_saveflag = 'N'
is_hisflag 	= 'N'
String	ls_Null

SetNull(ls_Null)

IF wf_win_reset(ls_suppcode) <> 0 THEN
	this.SetItem(1 , "supplierkorname"	, ls_Null )
	this.SetItem(1 , "supplierno"			, ls_Null )
	this.SetItem(1 , "suppliercode"		, ls_Null )
	this.SetFocus()
END IF

Return 0 

RollBack_:
ROLLBACK USING  Sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

CHOOSE CASE ls_message
	CASE 'wf_history_save'
		MessageBox( "실패", "납입주기 이력저장에 실패하였습니다.", StopSign! )
	CASE 'TPARTKBSTATUS'
		MessageBox( "실패", "개별간판정보 저장에 실패하였습니다.", StopSign! )
	CASE 'CycleUpdate'
		MessageBox( "실패", "납입주기등록(변경)을 실패하였습니다.", StopSign! )
	CASE 'TimeUpdate'
		MessageBox( "실패", "납입편수별시간저장에 실패하였습니다.", StopSign! )
	CASE ELSE
		MessageBox( "저장실패", "납입주기등록(변경)을 실패하였습니다.", StopSign! )
END CHOOSE

Return -1


end event

event type long undo_data();integer 	li_Net
String	ls_oldapplyfrom, ls_oldapplyto 
String 	ls_nowapplyfrom, ls_applyFrom	
Long		ll_oldTerm, ll_oldeditNo, ll_oldCycle
Long		ll_nowTerm, ll_noweditNo, ll_nowCycle, ll_Cnt
String	ls_DeleteKey
DateTime ldt_nowtime
String 	ls_maxDate = '9999.12.31'
String	ls_message = ''

  SELECT Top 1
         ApplyFrom,  
         SupplyTerm,  
         SupplyEditNo,  
         SupplyCycle  
    INTO :ls_nowapplyfrom,  
         :ll_nowTerm,  
         :ll_noweditNo,  
         :ll_nowCycle  
    FROM TMSTPARTCYCLE  
   WHERE AreaCode 		= :istr_partkb.areacode  AND  
         DivisionCode 	= :istr_partkb.divcode  AND  
         SupplierCode 	= :istr_partkb.suppcode  AND  
         ApplyTo 			= :ls_maxDate   
	USING sqlpis;
IF sqlpis.SqlCode <> 0 THEN
	MessageBox( "확인", istr_partkb.suppcode + " 업체의 납입주기가 등록되어있지 않습니다." , Information! )
	Return -1		//복원실패
END IF

ls_oldapplyto = f_pisr_getdaybefore( ls_nowapplyfrom, -1 )		//이전 적용종료일

  SELECT Top 1
         ApplyFrom,  
         SupplyTerm,  
         SupplyEditNo,  
         SupplyCycle  
    INTO :ls_oldapplyfrom,  
         :ll_oldTerm,  
         :ll_oldeditNo,  
         :ll_oldCycle  
    FROM TMSTPARTCYCLE  
   WHERE AreaCode 		= :istr_partkb.areacode  AND  
         DivisionCode 	= :istr_partkb.divcode   AND  
         SupplierCode 	= :istr_partkb.suppcode  AND  
         ApplyTo 			= :ls_oldapplyto   
	USING sqlpis;
//1. 이전 납입주기가 없을 경우
IF sqlpis.SqlCode <> 0 THEN //111
	li_Net = MessageBox( "확인", 	istr_partkb.suppcode + " 업체의 이전 납입주기가 존재하지 않습니다.~r~n" + &
											istr_partkb.suppcode + " 업체의 납입주기를 삭제하시겠습니까?", &
				Question!, YesNo!, 2)

	IF li_Net = 1 THEN	//000납입주기 삭제
	  SELECT Count(ItemCode)  
		 INTO :ll_Cnt  
		 FROM TMSTPARTKB  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode    
		Using sqlpis   ;

		If ll_Cnt > 0 Then 
			MessageBox( "삭제불능", istr_partkb.suppcode + " 업체에 간판이 등록되어 있습니다.", Information! )
			Return -1
		End If			
////////////////////////////////////////////////////////////////////////////////////////////////AutoCommit = False
	sqlpis.AutoCommit = False
	ldt_nowtime = f_pisc_get_date_nowtime()		//현재 시스템시간

	// TMSTPARTEDIT 삭제
	  INSERT INTO TDELETE  
	  SELECT 'TMSTPARTEDIT',
	  			AreaCode + '/' + DivisionCode + '/' + SupplierCode + '/' + ApplyFrom + '/' + RTrim(LTrim(Convert(Char(4), PartEditNo))),
				:ldt_nowtime, 
				:g_s_empno, 
				:ldt_nowtime 
	  	 FROM	TMSTPARTEDIT
		WHERE AreaCode 		= :istr_partkb.areacode 	AND  
				DivisionCode 	= :istr_partkb.divcode 		AND  
				SupplierCode 	= :istr_partkb.suppcode 	AND  
				ApplyTo	 		= :ls_maxDate    
		USING sqlpis	;
		IF sqlpis.SqlCode <> 0 THEN
			ls_message = 'TMSTPARTEDIT_Err'
//			MessageBox( "삭제실패", "현재 납입편수정보 삭제에 실패했습니다.", StopSign! )
			Goto Rollback_
		END IF
		
	  DELETE FROM TMSTPARTEDIT  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode AND  
				ApplyTo 			= :ls_maxDate
		Using sqlpis   ;
		IF sqlpis.SqlCode <> 0 THEN
			ls_message = 'TMSTPARTEDIT_Err'
//			MessageBox( "삭제실패", "현재 납입편수정보 삭제에 실패했습니다.", StopSign! )
			Goto Rollback_
		END IF
	
	// TMSTPARTCYCLE 삭제
	ls_DeleteKey = Trim(istr_partkb.areacode) +'/'+ Trim(istr_partkb.divcode) +'/'+ Trim(istr_partkb.suppcode) +'/'+ Trim(ls_nowapplyfrom) 
	  INSERT INTO TDELETE  
				( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
	  VALUES ( 'TMSTPARTCYCLE', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
		USING sqlpis	;
		IF sqlpis.SqlCode <> 0 THEN
			ls_message = 'TMSTPARTCYCLE_Err'
//			MessageBox( "삭제실패", "현재 납입주기의 삭제에 실패했습니다.", StopSign! )
			Goto Rollback_
		END IF
		
	  DELETE FROM TMSTPARTCYCLE  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode AND  
				ApplyTo 			= :ls_maxDate
		Using sqlpis   ;
		IF sqlpis.SqlCode <> 0 THEN
			ls_message = 'TMSTPARTCYCLE_Err'
//			MessageBox( "삭제실패", "현재 납입주기의 삭제에 실패했습니다.", StopSign! )
			Goto Rollback_
		END IF
	ELSE				//000납입주기 삭제
		Return -1	
	END IF			//000납입주기 삭제

//	f_pisr_sqlchkopt(Sqlpis, True)
	Commit Using sqlpis;
	sqlpis.AutoCommit = True
	
	ii_savecount = ii_savecount + 1		//외주업체 삭제 및 등록 회수
	MessageBox( "삭제완료", "해당업체의 납입주기를 삭제하였습니다.", Information! )
	Return 0			//복원성공

END IF //111 1. 이전 납입주기가 없을 경우

//2. 이전 납입주기가 있을 경우
li_Net = MessageBox("확인요청", "현재의 납입주기는 "+String(ll_nowTerm)+"-"+String(ll_noweditNo)+"-"+String(ll_nowCycle)+" 이고, ~r~n" + &
                                "복원할 납입주기는 "+String(ll_oldTerm)+"-"+String(ll_oldeditNo)+"-"+String(ll_oldCycle)+" 입니다., ~r~n~r~n" + &
										  "납입주기를 복원하시겠습니까?", &
			Question!, YesNo!, 2)

IF li_Net = 1 THEN	//납입주기 복원
	  SELECT Count(*)  
		 INTO :ll_Cnt  
		 FROM TPARTLASTEDIT  
		WHERE AreaCode 			= :istr_partkb.areacode AND  
				DivisionCode 		= :istr_partkb.divcode 	AND  
				SupplierCode 		= :istr_partkb.suppcode AND  
				OrderGubun 			= 'A' 						AND  
				PartLastEditDate 	>= :ls_nowapplyfrom 
	USING sqlpis;
	IF ll_Cnt > 0  THEN
		MessageBox( "복원불능", "현재 납입주기로 이미 발주처리된 간판이 존재합니다. ", Information!)
		Return -1		//복원실패
	END IF

/////////////////////////////////////////////////////////////////////////////////// AutoCommit = False
	sqlpis.AutoCommit = False
	ldt_nowtime = f_pisc_get_date_nowtime()		//현재 시스템시간
	
	// TMSTPARTEDIT 삭제
	  INSERT INTO TDELETE  
	  SELECT 'TMSTPARTEDIT',
				AreaCode + '/' + DivisionCode + '/' + SupplierCode + '/' + ApplyFrom + '/' + RTrim(LTrim(Convert(Char(4), PartEditNo))),
				:ldt_nowtime, 
				:g_s_empno, 
				:ldt_nowtime 
		 FROM	TMSTPARTEDIT
		WHERE AreaCode 		= :istr_partkb.areacode 	AND  
				DivisionCode 	= :istr_partkb.divcode 		AND  
				SupplierCode 	= :istr_partkb.suppcode 	AND  
				ApplyTo			= :ls_maxDate
		USING sqlpis	;
	IF sqlpis.SqlCode <> 0 THEN
		ls_message = 'TMSTPARTEDIT_Err'
//		MessageBox( "삭제실패", "현재 납입편수정보 삭제에 실패했습니다.", StopSign! )
		Goto Rollback_
	END IF
		
	  DELETE FROM TMSTPARTEDIT  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode AND  
				ApplyTo 			= :ls_maxDate
		Using sqlpis   ;
	IF sqlpis.SqlCode <> 0 THEN
		ls_message = 'TMSTPARTEDIT_Err'
//		MessageBox( "삭제실패", "현재 납입편수정보 삭제에 실패했습니다.", StopSign! )
		Goto Rollback_
	END IF
	
	// TMSTPARTEDIT 복원
	  UPDATE TMSTPARTEDIT  
		  SET ApplyTo 	= :ls_maxDate,  
				LastEmp	= 'Y',
				LastDate	= :ldt_nowtime
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode AND  
				ApplyFrom 		= :ls_oldapplyfrom 
		Using sqlpis   ;
	IF sqlpis.SqlCode <> 0 THEN
		ls_message = 'TMSTPARTEDIT_Err2'
	//	MessageBox( "복원실패", "이전 납입편수별 납입시간 복원에 실패했습니다.", StopSign! )
		Goto Rollback_
	END IF
	
	// TMSTPARTCYCLE 삭제
	ls_DeleteKey = Trim(istr_partkb.areacode) +'/'+ Trim(istr_partkb.divcode) +'/'+ Trim(istr_partkb.suppcode) +'/'+ Trim(ls_nowapplyfrom) 
	  INSERT INTO TDELETE  
				( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
	  VALUES ( 'TMSTPARTCYCLE', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
		USING sqlpis	;
	IF sqlpis.SqlCode <> 0 THEN
		ls_message = 'TMSTPARTCYCLE_Err'
	//	MessageBox( "삭제실패", "현재 납입주기의 삭제에 실패했습니다.", StopSign! )
		Goto Rollback_
	END IF

	  DELETE FROM TMSTPARTCYCLE  
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode AND  
				ApplyTo 			= :ls_maxDate 
		Using sqlpis   ;
	IF sqlpis.SqlCode <> 0 THEN
		ls_message = 'TMSTPARTCYCLE_Err'
	//	MessageBox( "복원실패", "현재 납입주기의 삭제에 실패했습니다.", StopSign! )
		Goto Rollback_
	END IF
	
	// TMSTPARTCYCLE 복원
	  UPDATE TMSTPARTCYCLE  
		  SET ApplyTo 	= :ls_maxDate,  
				LastEmp	= 'Y',
				LastDate	= :ldt_nowtime
		WHERE AreaCode 		= :istr_partkb.areacode AND  
				DivisionCode 	= :istr_partkb.divcode 	AND  
				SupplierCode 	= :istr_partkb.suppcode AND  
				ApplyFrom 		= :ls_oldapplyfrom 
		Using sqlpis   ;
	IF sqlpis.SqlCode <> 0 THEN
		ls_message = 'TMSTPARTCYCLE_Err2'
//		MessageBox( "복원실패", "이전 납입주기의 복원에 실패했습니다.", StopSign! )
		Goto Rollback_
	END IF
ELSE
	Return 1		//복원취소
END IF	//납입주기 복원

//f_pisr_sqlchkopt(Sqlpis, True)
Commit Using sqlpis;
sqlpis.AutoCommit = True

MessageBox( "복원완료", "이전의 납입주기를 복원하였습니다.", Information! )

is_saveflag = 'N'
is_hisflag 	= 'N'
String	ls_Null

SetNull(ls_Null)

IF wf_win_reset(istr_partkb.suppcode) <> 0 THEN
	this.SetItem(1 , "supplierkorname"	, ls_Null )
	this.SetItem(1 , "supplierno"			, ls_Null )
	this.SetItem(1 , "suppliercode"		, ls_Null )
	this.SetFocus()
END IF

Return 0			//복원완료

RollBack_:
ROLLBACK USING  Sqlpis;
sqlpis.AutoCommit = True

If	ls_message = 'TMSTPARTEDIT_Err' Then
	MessageBox( "삭제실패", "현재 납입편수정보 삭제에 실패했습니다.", StopSign! )
ElseIf ls_message = 'TMSTPARTCYCLE_Err' Then
	MessageBox( "삭제실패", "현재 납입주기의 삭제에 실패했습니다.", StopSign! )
ElseIf ls_message = 'TMSTPARTEDIT_Err2' Then
	MessageBox( "복원실패", "이전 납입편수별 납입시간 복원에 실패했습니다.", StopSign! )
ElseIf ls_message = 'TMSTPARTCYCLE_Err2' Then
	MessageBox( "복원실패", "이전 납입주기의 복원에 실패했습니다.", StopSign! )
Else 
	MessageBox( "복원실패", "납입주기의 복원에 실패했습니다.", StopSign! )
End If

Return -1		//복원실패

end event

event itemchanged;String 	ls_colName, ls_suppCode, ls_suppName, ls_Null, ls_Date
Integer 	li_suppTerm, li_suppCycle, li_suppEditNo, I 
Long		ll_Row

setNull(ls_Null)
DataWindowChild ldwc

ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode'
		IF wf_win_reset(data) <> 0 THEN
			this.SetItem(row , "suppliercode"	, ls_Null )
			this.SetItem(row , "supplierkorname", ls_Null )
			this.SetItem(row , "supplierno"		, ls_Null )
			this.SetFocus()
			return 1
		END IF
		istr_partkb.suppcode = data
	Case 'applyfrom'
		IF (Not isDate(data)) Then
			MessageBox( "입력오류", "적용시작일자를 YYYY.MM.DD 형식으로 입력하여주세요.", &
			            Information!)		
			this.SetItem(1 , "applyfrom", is_lastdate )
			Return 1			
		End IF
		f_pisc_get_date_convert(data, "YYYY.MM.DD", ls_Date) 
//		ls_Date = f_pisr_getdaybefore( data, 0 )		//입력한 날자를 YYYY.MM.DD 형식으로 변경
		If ls_Date < is_lastdate Then 
			MessageBox( "입력오류", "적용시작일자는 시스템일자,수정이전 적용시작일자, ~r~n " + &
			            "최근간판발주일자들보다 이후여야 합니다.", Information! )		
			this.SetItem(1 , "applyfrom", is_lastdate )
			this.SetFocus()
			return -1
		End If
		this.SetItem(1 , "applyfrom", ls_Date )
		is_inputDate = ls_Date 
		ll_Row = dw_newtime.GetRow()
		IF ll_Row > 0 THEN 
			FOR I = 1 TO ll_Row
				dw_newtime.SetItem(I , "applyfrom", ls_Date )
			NEXT
		END IF
	Case 'supplyterm'
		li_suppTerm = Integer(data) 
		If li_suppTerm > 1 Then 
			This.SetItem(row, "supplyeditno", 1)
			wf_setnapipTime(1, '')
		End IF 
	Case 'supplyeditno'
		li_suppEditNo 	= Integer(data)
		li_suppTerm 	= This.GetItemNumber(row, "supplyterm")
		li_suppCycle 	= This.GetItemNumber(row, "supplycycle")
		
		If wf_supplyTerm_validChk(ls_colName, li_suppTerm, li_suppEditNo, li_suppCycle) <> 0 Then Return 1 
		wf_setnapipTime(li_suppEditNo, '')
	Case 'supplycycle'
		li_suppCycle 	= Integer(data)
		li_suppTerm 	= This.GetItemNumber(row, "supplyterm")
		li_suppEditNo 	= This.GetItemNumber(row, "supplyeditno")
		If wf_supplyTerm_validChk(ls_colName, li_suppTerm, li_suppEditNo, li_suppCycle) <> 0 Then Return 1 
End Choose 

is_saveflag = 'Y'
return 0
end event

event itemerror;Return 1
end event

event retrieveend;//String 	ls_suppCode
//Long 		ll_Row
//
//ll_Row = this.GetRow()
//ls_suppCode	= this.GetItemString( ll_Row, 'suppliercode' )
//
//If wf_win_reset( ls_suppCode ) <> 0 Then return 
//
//
end event

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_Null
SetNull( ls_Null )

istr_partkb.flag = 2			//외주업체(전체)
OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)

IF wf_win_reset(lstr_Rtn.code) <> 0 THEN
	this.SetItem(row , "suppliercode"	, ls_Null )
	this.SetItem(row , "supplierkorname", ls_Null )
	this.SetItem(row , "supplierno"		, ls_Null )
	this.SetFocus()
	return 1
END IF

istr_partkb.suppcode = lstr_Rtn.code
is_saveflag = 'Y'

Return

end event

type gb_1 from groupbox within w_pisr012u
integer x = 18
integer width = 1175
integer height = 160
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

