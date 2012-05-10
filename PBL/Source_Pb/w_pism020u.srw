$PBExportHeader$w_pism020u.srw
$PBExportComments$시간단위 지원공수 등록 및 조회
forward
global type w_pism020u from w_pism_resp01
end type
type cb_retrieve from commandbutton within w_pism020u
end type
type cb_psupp_4 from commandbutton within w_pism020u
end type
type cb_msupp_4 from commandbutton within w_pism020u
end type
type cb_pdelete from commandbutton within w_pism020u
end type
type cb_mdelete from commandbutton within w_pism020u
end type
type dw_psupp from u_pism_dw within w_pism020u
end type
type dw_msupp from u_pism_dw within w_pism020u
end type
type st_3 from statictext within w_pism020u
end type
type st_2 from statictext within w_pism020u
end type
type st_hbar from u_pism_splitbar within w_pism020u
end type
type cb_psupp_2 from commandbutton within w_pism020u
end type
type cb_psupp_3 from commandbutton within w_pism020u
end type
type cb_psupp_1 from commandbutton within w_pism020u
end type
type cb_msupp_1 from commandbutton within w_pism020u
end type
type cb_close from commandbutton within w_pism020u
end type
type cb_save from commandbutton within w_pism020u
end type
type st_wday from statictext within w_pism020u
end type
type st_4 from statictext within w_pism020u
end type
type st_6 from statictext within w_pism020u
end type
type st_wcname from statictext within w_pism020u
end type
type gb_2 from groupbox within w_pism020u
end type
type gb_3 from groupbox within w_pism020u
end type
type st_wccode from statictext within w_pism020u
end type
type cb_msupp_2 from commandbutton within w_pism020u
end type
type cb_msupp_3 from commandbutton within w_pism020u
end type
end forward

global type w_pism020u from w_pism_resp01
integer width = 4050
integer height = 2500
string title = "시간단위 지원공수 등록"
boolean controlmenu = false
event ue_post_open ( )
cb_retrieve cb_retrieve
cb_psupp_4 cb_psupp_4
cb_msupp_4 cb_msupp_4
cb_pdelete cb_pdelete
cb_mdelete cb_mdelete
dw_psupp dw_psupp
dw_msupp dw_msupp
st_3 st_3
st_2 st_2
st_hbar st_hbar
cb_psupp_2 cb_psupp_2
cb_psupp_3 cb_psupp_3
cb_psupp_1 cb_psupp_1
cb_msupp_1 cb_msupp_1
cb_close cb_close
cb_save cb_save
st_wday st_wday
st_4 st_4
st_6 st_6
st_wcname st_wcname
gb_2 gb_2
gb_3 gb_3
st_wccode st_wccode
cb_msupp_2 cb_msupp_2
cb_msupp_3 cb_msupp_3
end type
global w_pism020u w_pism020u

type variables
String is_modChk, is_tmorrow 
Boolean ib_responseChk 
DateTime idt_regDayFrom, idt_regDayTo, &
			idt_regNightFrom, idt_regNightTo 

DataWindowChild idwc_m, idwc_p, idwc_emp

constant String REGMAN = '1', &
					 ETCMAN = '2', ETCMANCODE = '999999', & 
					 OTHERDIVMAN = '3', OTHERDIVMANCODE = 'XXXXXX' 
end variables

forward prototypes
public subroutine wf_delunvalidrow (datawindow adw)
public function integer wf_fromtimevalidchk (datawindow adw, long al_row, string as_data)
public subroutine wf_setsupdatetime (datawindow adw, string as_setdata)
public function integer wf_totimevalidchk (datawindow adw, long al_row, string as_data)
public function integer wf_emplabtacchk (string as_empno)
public subroutine wf_setsupppk (datawindow adw, string as_supcolumn, long al_row)
public function integer wf_setsuppempdngbn (datawindow adw, long al_row, string as_wc, string as_empno)
public function integer wf_empnamevalidchk (datawindow adw, long al_row, string as_wc, string as_data)
public function integer wf_empnovalidchk (datawindow adw, long al_row, string as_data)
public function integer wf_suppvalidchk (datawindow adw, string as_suppgubun)
public function integer wf_calcsuppmh (datawindow adw, long al_row, datetime adt_fromtime, datetime adt_totime)
public function integer wf_wcvalidchk (datawindow adw, long al_row, string as_data)
public function integer wf_findrow (datawindow adw, string as_empno, string as_suppgubun, string as_supworkcenter)
end prototypes

event ue_post_open();
st_wday.Text = istr_mh.wday 

If istr_mh.workGbn = 'H' Then 
	st_wday.BackColor = RGB(255, 200, 200)
Else
	st_wday.BackColor = RGB(192, 192, 192)
End If 

st_wccode.Text = istr_mh.wc; st_wcname.Text = f_pism_getwcname(istr_mh) 
is_tmorrow = String(RelativeDate( Date(istr_mh.wday), 1 ), "YYYY.MM.DD")

idt_regDayFrom = DateTime( Date(istr_mh.wday), Time('08:00') )
idt_regDayTo	= DateTime( Date(istr_mh.wday), Time('17:00') ) 

idt_regNightFrom = DateTime( Date(istr_mh.wday), Time('23:00') )
idt_regNightTo   = DateTime( Date(is_tmorrow), Time('08:00') ) 

This.TriggerEvent("ue_retrieve") 

end event

public subroutine wf_delunvalidrow (datawindow adw);String ls_find 
Long ll_findRow 

ls_find = "( tmhsupport_empno = '' or IsNull(tmhsupport_empno) )"
ls_find += " or ( IsNull(tmhsupport_workcenter) or tmhsupport_workcenter = '' )" 
ls_find += " or ( IsNull(tmhsupport_supworkcenter) or tmhsupport_supworkcenter = '' )" 
ll_findRow = adw.find(ls_find, 1, adw.RowCount())

Do While ll_findRow > 0 
	adw.DeleteRow(ll_findRow) 
	ll_findRow = adw.find(ls_find, 1, adw.RowCount())
Loop

end subroutine

public function integer wf_fromtimevalidchk (datawindow adw, long al_row, string as_data);DateTime ld_fromTime, ld_toTime 
String ls_frDay, ls_frTime 

ld_fromTime = f_pism_cvt_datetime(as_data, ls_frDay, ls_frTime) 
If ls_frDay < istr_mh.wday Then 
	f_pism_MessageBox(Information!, -1, "지원시각 입력오류", "지원From 시각이 작업일자 이전입니다.")
	Goto Error_Exit 
End If 

ld_toTime = adw.GetItemDateTime(al_row, "tmhsupport_totime") 

If ld_fromTime > ld_toTime Then 
	f_pism_MessageBox(Information!, -1, "지원시각 입력오류", "지원From 시각이 지원to 시각보다 큽니다.")
	Goto Error_Exit 
End If 

If ld_fromTime < idt_regdayfrom Then 
	f_pism_MessageBox(Information!, -1, "지원시각 입력오류", "지원From 시각이 정시 근무시각이 아닙니다.")
	Goto Error_Exit 
End If 

If Not ( IsNull(ld_fromTime) or IsNull(ld_toTime) ) Then wf_calcsuppmh(adw, al_row, ld_fromTime, ld_toTime) 

Return 1 

Error_Exit:

//SetNull(ld_fromTime) 
adw.SetItem(al_row, "tmhsupport_fromtime", idt_regdayfrom) 
Return -1 			

end function

public subroutine wf_setsupdatetime (datawindow adw, string as_setdata);DateTime ldt_supDateTime 
String ls_Date, ls_Time, ls_colNm 

ls_colNm = adw.GetColumnName()
ldt_supDateTime = f_pism_cvt_datetime(as_setData, ls_Date, ls_time) 
adw.SetItem(adw.GetRow(), ls_colNm, ldt_supDateTime) 
If ls_colNm = 'tmhsupport_fromtime' Then 
	adw.Event ItemChanged(adw.GetRow(), adw.Object.tmhsupport_fromtime, String(ldt_supDateTime, "YYYY.MM.DD HH:MM")) 
ElseIf ls_colNm = 'tmhsupport_totime' Then 
	adw.Event ItemChanged(adw.GetRow(), adw.Object.tmhsupport_totime, String(ldt_supDateTime, "YYYY.MM.DD HH:MM")) 
End If 
adw.SetColumn(adw.GetColumn()+1) 

end subroutine

public function integer wf_totimevalidchk (datawindow adw, long al_row, string as_data);DateTime ld_toTime, ld_fromTime 
String ls_toDay, ls_toTime 

ld_toTime = f_pism_cvt_datetime(as_data, ls_toDay, ls_toTime) 
If ls_toDay > String(RelativeDate( Date(istr_mh.wday), 1 ), "YYYY.MM.DD") Then 
	f_pism_MessageBox(Information!, -1, "지원시각 입력오류", "지원To 시각이 작업일자 이후입니다.")
	Goto Error_Exit
End If 

ld_fromTime = adw.GetItemDateTime(al_row, "tmhsupport_fromtime") 

If ld_toTime < ld_fromTime Then 
	f_pism_MessageBox(Information!, -1, "지원시각 입력오류", "지원to 시각이 지원from 시각보다 작습니다.")
	Goto Error_Exit
End If 

If ld_toTime > idt_regnightto Then 
	f_pism_MessageBox(Information!, -1, "지원시각 입력오류", "지원to 시각이 정시 근무시각이 아닙니다.")
	Goto Error_Exit 
End If 

If Not ( IsNull(ld_fromTime) or IsNull(ld_toTime) ) Then wf_calcsuppmh(adw, al_row, ld_fromTime, ld_toTime) 

Return 1 

Error_Exit:

//SetNull(ld_toTime) 
adw.SetItem(al_row, "tmhsupport_totime", idt_regnightto) 
Return -1 			

end function

public function integer wf_emplabtacchk (string as_empno);String ls_mhCode 

  SELECT IsNull(DGCD2R,'') + IsNull(DGCD3R,'') 
    INTO :ls_mhCode FROM TMHLABTAC 
   WHERE ( TMHLABTAC.DGEMPNO = :as_empNo ) AND  
         ( TMHLABTAC.DGDAY = :istr_mh.wday ) Using SqlPIS ;
If IsNull(ls_mhCode) Or ls_mhCode = '' Or ls_mhCode = '21' Then Return 1 	// 21(철야) 

Return -1 
end function

public subroutine wf_setsupppk (datawindow adw, string as_supcolumn, long al_row);DateTime ldt_DT, ldt_tmoDT 

adw.SetItem(al_row, "tmhsupport_areacode", istr_mh.area)
adw.SetItem(al_row, "tmhsupport_divisioncode", istr_mh.div)
adw.SetItem(al_row, as_supColumn, istr_mh.wc)
adw.SetItem(al_row, "tmhsupport_workday", istr_mh.wday)

end subroutine

public function integer wf_setsuppempdngbn (datawindow adw, long al_row, string as_wc, string as_empno);String ls_empNo, ls_DNGbn, ls_empWorkCenter 

//as_empNo = adw.GetItemString(al_row, "tmhsupport_empno") 
ls_DNGbn = f_pism_getemplabtac(istr_mh.wday, as_empNo, ls_empWorkCenter) 
If ls_DNGbn = '' Then 		// 주
	adw.SetItem(al_row, "tmhsupport_fromtime", idt_regdayfrom) 
	adw.SetItem(al_row, "tmhsupport_totime",   idt_regdayto)	
	
	adw.Event ItemChanged(al_row, adw.Object.tmhsupport_totime, String(idt_regdayto, "YYYY.MM.DD HH:MM")) 
ElseIf ls_DNGbn = 'N' Then // 야 
	adw.SetItem(al_row, "tmhsupport_fromtime", idt_regnightFrom) 
	adw.SetItem(al_row, "tmhsupport_totime",   idt_regnightto)	
	
	adw.Event ItemChanged(al_row, adw.Object.tmhsupport_totime, String(idt_regnightto, "YYYY.MM.DD HH:MM")) 
End If 
adw.SetItem(al_row, "dngubun", ls_DNGbn) 
If IsNull(as_wc) or as_wc = '' Then adw.SetItem(al_row, "tmhsupport_workcenter", ls_empWorkCenter) 

Return 1 
end function

public function integer wf_empnamevalidchk (datawindow adw, long al_row, string as_wc, string as_data);String ls_empNo, ls_empName, ls_supGbn 
Long ll_findRow, ll_row 
Integer li_retValue = 1 
DataWindowChild ldwc 

ls_empNo = ''; ls_empName = as_data 
If adw.GetChild('tmstemp_empname', ldwc) <> -1 Then 
	ll_row = ldwc.GetSelectedRow(0)
	If ll_row > 0 Then ls_empNo = ldwc.GetItemString(ll_row, "empno") 
End If 

If ls_empNo = '' Then 
	If f_pism_getemp(as_wc, ls_empNo, ls_empName) = -1 Then 
		f_pism_MessageBox(Information!, -1, "사번입력오류", "존재하지 않는 명칭입니다.")
		Goto Exit_pr 
	End If 
End If 

ls_supGbn = adw.GetItemString(al_row, "tmhsupport_supgubun")
ll_findRow = wf_findRow(adw, ls_empNo, ls_supGbn, '')
If ll_findRow > 0 And ll_findRow <> al_row Then 
	f_pism_MessageBox(Information!, -1, "사번입력오류", "이미 등록된 사번입니다.")
	Goto Exit_pr 
Else
	If wf_empLABTACChk(ls_empNo) = -1 Then 
		f_pism_MessageBox(Information!, -1, "사번입력오류", '[' + ls_empNo + ']' + ls_empName + "~n~n해당 사원은 " + & 
														"당일 근태가 발생되었습니다. 지원공수를 등록할 수 없습니다.")		
		Goto Exit_pr 
	End If 
End If 

adw.SetItem(al_row, 'tmhsupport_empno', ls_empNo) 
adw.SetItem(al_row, 'tmstemp_empname', ls_empName)

Return 1  

Exit_pr:
SetNull(ls_empNo); SetNull(ls_empName) 
adw.SetItem(al_row, 'tmhsupport_empno', ls_empNo) 
adw.SetItem(al_row, 'tmstemp_empname', ls_empName)

Return -1 
end function

public function integer wf_empnovalidchk (datawindow adw, long al_row, string as_data);String ls_empNo, ls_empName, ls_supGbn 
Long ll_findRow 

ls_empNo = as_data; ls_empName = '' 
If f_pism_getemp('', ls_empNo, ls_empName) = -1 Then 
	f_pism_MessageBox(Information!, -1, "사번입력오류", "존재하지 않는 사번입니다.")
	Goto Exit_pr 
Else
	ls_supGbn = adw.GetItemString(al_row, "tmhsupport_supgubun")	
	ll_findRow = wf_findRow(adw, ls_empNo, ls_supGbn, '') 
	If ll_findRow > 0 And ll_findRow <> al_row Then 
		f_pism_MessageBox(Information!, -1, "사번입력오류", "이미 등록된 사번입니다.")
		Goto Exit_pr 
	Else
		If wf_empLABTACChk(ls_empNo) = -1 Then 
			f_pism_MessageBox(Information!, -1, "사번입력오류", '[' + ls_empNo + ']' + ls_empName + "~n~n해당 사원은 " + & 
															"당일 근태가 발생되었습니다. 지원공수를 등록할 수 없습니다.")		
			Goto Exit_pr 
		End If 
	End If 
End If 
adw.SetItem(al_row, "tmstemp_empname", ls_empName) 

Return 1 

Exit_pr: 

SetNull(ls_empNo); SetNull(ls_empName) 
adw.SetItem(al_row, 'tmhsupport_empno', ls_empNo) 
adw.SetItem(al_row, 'tmstemp_empname', ls_empName) 

Return -1 
end function

public function integer wf_suppvalidchk (datawindow adw, string as_suppgubun);
If as_suppGubun = ETCMAN Then 
	If wf_findRow(adw, ETCMANCODE, ETCMAN, 'XXXX') > 0 Then Return -1 
ElseIf as_suppGubun = OTHERDIVMAN Then 
	If wf_findRow(adw, OTHERDIVMANCODE, OTHERDIVMAN, 'XXXX') > 0 Then Return -1 
End If 

Return 1 
end function

public function integer wf_calcsuppmh (datawindow adw, long al_row, datetime adt_fromtime, datetime adt_totime);Integer I, li_midMH, li_supMH, li_etcSupMH, li_etcmidMH, li_suppCnt, & 
		  li_restTime, li_calcRestTime, li_calcEtcRestTime 
DateTime ldt_suppFromTime[], ldt_suppToTime[], ldt_etcFromTime[], ldt_etcToTime[], &
			ldt_restFromTime, ldt_restToTime, ldt_Null 
String ls_tmorrow 

ls_tmorrow = String(RelativeDate( Date(istr_mh.wday), 1 ), "YYYY.MM.DD")

li_suppCnt++; SetNull(ldt_Null) 

If adt_fromTime >= idt_regDayFrom And &
	adt_fromTime <= idt_regDayTo Then	// 지원From시각이 08:00 ~ 17:00 
	If adt_toTime <= idt_regDayTo Then // 지원To시각이 17:00 이전 
		ldt_suppFromTime[li_suppCnt] = adt_fromTime; ldt_suppToTime[li_suppCnt] = adt_toTime 
		ldt_etcFromTime[li_suppCnt] = ldt_Null; ldt_etcToTime[li_suppCnt] = ldt_Null 
	ElseIf adt_toTime >= idt_regDayTo And &
			 adt_toTime <= idt_regNightFrom Then	// 지원To시각이 17:00 ~ 23:00 
		ldt_etcFromTime[li_suppCnt] = idt_regDayTo; ldt_etcToTime[li_suppCnt] = adt_toTime 
		ldt_suppFromTime[li_suppCnt] = adt_fromTime; ldt_suppToTime[li_suppCnt] = idt_regDayTo 
		
	ElseIf adt_toTime >= idt_regNightFrom And &
			 adt_toTime <= idt_regNightTo Then // 지원To시각이 23:00 ~ 08:00 
		ldt_etcFromTime[li_suppCnt] = idt_regDayTo; ldt_etcToTime[li_suppCnt] = idt_regNightFrom  
		ldt_suppFromTime[li_suppCnt] = adt_fromTime; ldt_suppToTime[li_suppCnt] = idt_regDayTo 
		
		li_suppCnt++		
		ldt_suppFromTime[li_suppCnt] = idt_regNightFrom; ldt_suppToTime[li_suppCnt] = adt_toTime 
		ldt_etcFromTime[li_suppCnt] = ldt_Null; ldt_etcToTime[li_suppCnt] = ldt_Null 
	Else // 지원To시각이 주간 08:00 이후 -> 입력불가!! 
	End If 
ElseIf adt_fromTime >= idt_regDayTo And &
		 adt_fromTime <= idt_regNightFrom Then // 지원From시각이 17:00 ~ 23:00 
		If adt_toTime >= idt_regDayTo And &
			 adt_toTime <= idt_regNightFrom Then	// 지원To시각이 17:00 ~ 23:00 
			 ldt_etcFromTime[li_suppCnt] = adt_fromTime; ldt_etcToTime[li_suppCnt] = adt_toTime  
	 		 ldt_suppFromTime[li_suppCnt] = ldt_Null; ldt_suppToTime[li_suppCnt] = ldt_Null 
		ElseIf adt_toTime >= idt_regNightFrom And &
				 adt_toTime <= idt_regNightTo Then // 지원To시각이 23:00 ~ 08:00 
			ldt_etcFromTime[li_suppCnt] = adt_fromTime; ldt_etcToTime[li_suppCnt] = idt_regNightFrom  
			ldt_suppFromTime[li_suppCnt] = idt_regNightFrom; ldt_suppToTime[li_suppCnt] = adt_toTime 
		Else // 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End If 
ElseIf adt_fromTime >= idt_regNightFrom And & 
		 adt_fromTime <= idt_regNightTo Then // 지원From시각이 23:00 ~ 08:00 
		If adt_toTime >= idt_regNightFrom And &
			adt_toTime <= idt_regNightTo Then // 지원To시각이 23:00 ~ 08:00 
		 ldt_suppFromTime[li_suppCnt] = adt_fromTime; ldt_suppToTime[li_suppCnt] = adt_toTime 
		 ldt_etcFromTime[li_suppCnt] = ldt_Null; ldt_etcToTime[li_suppCnt] = ldt_Null 
		Else // 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End If 
End If 

// 중식시간 등 법정휴게시간에 반영되지 않는 시간계산 

 DECLARE restTimeList_cur CURSOR FOR 
  SELECT Cast( :istr_mh.wday + ' ' + dayFrom as DateTime ) as restFrom,   
			Cast( :istr_mh.wday + ' ' + dayTo as DateTime) as restTo,
			dayRestTime as restTime 
	 FROM TMHRESTTIME  
	WHERE ( AreaCode = :istr_mh.area ) AND  
			( DivisionCode = :istr_mh.div ) AND  
			( substring(restGubun, 1, 1) = 'F' ) AND  
			( ApplyMonth = substring(:istr_mh.wday, 6, 2) )   
Union 
  SELECT Cast( :ls_tmorrow + ' ' + nightFrom as DateTime ),   
			Cast( :ls_tmorrow + ' ' + nightTo as DateTime ),
			nightRestTime 
	 FROM TMHRESTTIME  
	WHERE ( AreaCode = :istr_mh.area ) AND  
			( DivisionCode = :istr_mh.div ) AND  
			( substring(restGubun, 1, 1) = 'F' ) AND  
			( ApplyMonth = substring(:istr_mh.wday, 6, 2) ) Using SqlPIS ; 
OPEN restTimeList_cur ;
FETCH restTimeList_cur INTO :ldt_restFromTime, :ldt_restToTime, :li_restTime ;
Do WHILE SqlPIS.Sqlcode = 0 
	
	For I = 1 To li_suppCnt 
		// 정시 
		If ldt_suppFromTime[I] <= ldt_restFromTime And & 
			ldt_suppToTime[I] >= ldt_restToTime Then 
			li_calcRestTime = li_calcRestTime + li_restTime 
		End If
		// 정시외
		If ldt_etcFromTime[I] <= ldt_restFromTime And & 
			ldt_etcToTime[I] >= ldt_restToTime Then 
			li_calcEtcRestTime = li_calcEtcRestTime + li_restTime 
		End If
	Next 

	FETCH restTimeList_cur INTO :ldt_restFromTime, :ldt_restToTime, :li_restTime ;
Loop 
Close restTimeList_cur ;

For I = 1 To li_suppCnt 
	SELECT Top 1 DATEDIFF( mi, :ldt_suppFromTime[I], :ldt_suppToTime[I]) Into :li_midMH From sysusers Using SqlPIS ; 
	If IsNull(li_midMH) Then li_midMH = 0 
	li_SupMH		+= li_midMH 
	
	SELECT Top 1 DATEDIFF( mi, :ldt_etcFromTime[I], :ldt_etcToTime[I]) Into :li_etcmidMH From sysusers Using SqlPIS ; 
	If IsNull(li_etcmidMH) Then li_etcmidMH = 0 
	li_etcSupMH += li_etcmidMH
Next 

// 중식시간 제외 
li_SupMH 	-= li_calcRestTime 
li_etcSupMH -= li_calcEtcRestTime

If istr_mh.workGbn = 'H' Then 
	li_etcSupMH = li_etcSupMH + li_SupMH 
	li_SupMH = 0 
End If 

adw.SetItem(al_row, "tmhsupport_supmh", Round(li_SupMH / 60, 1))
adw.SetItem(al_row, "tmhsupport_etcsupmh", Round(li_etcSupMH / 60, 1)) 

Return 1 
end function

public function integer wf_wcvalidchk (datawindow adw, long al_row, string as_data);String ls_wc, ls_wcName, ls_dailyStatus, ls_empNo, ls_supGbn 
Long ll_findRow 

ls_wc = as_data; ls_wcName = '' 
//If f_pism_getworkcenter(istr_mh.area, istr_mh.div, ls_wc, ls_wcName) = -1 Then 
//	f_pism_MessageBox(Information!, -1, "조코드입력오류", "존재하지 않는 조코드입니다.")
//	adw.SetItem(al_row, adw.GetColumn(), ls_wc)
//	Return -1 
//End If 

ls_empNo = adw.GetItemString(al_row, "tmhsupport_empno") 
ls_supGbn = adw.GetItemString(al_row, "tmhsupport_supgubun")	
ll_findRow = wf_findRow(adw, ls_empNo, ls_supGbn, ls_wc) 
If ll_findRow > 0 And ll_findRow <> al_row Then 
	f_pism_MessageBox(Information!, -1, "입력실패", "이미 등록된 조입니다.")
	Goto Exit_pr 
End If 

ls_dailyStatus = f_pism_getdailystatus(istr_mh.area, istr_mh.div, ls_wc, istr_mh.wday) 
If ls_dailyStatus = '1' Then 
	f_pism_MessageBox(Information!, -1, ls_wcName, "해당조의 작업일보가 확정된 상태이므로 지원내역을 등록할 수 없습니다.")
	Goto Exit_pr 
End If 

Return 1 

Exit_pr:

SetNull(ls_wc); adw.SetItem(al_row, adw.GetColumn(), ls_wc)
Return -1 

end function

public function integer wf_findrow (datawindow adw, string as_empno, string as_suppgubun, string as_supworkcenter);String ls_find, ls_supWorkCenter 
Long ll_findRow 

If as_empNo = '' Then 
	If as_suppgubun = ETCMAN Then 			// 연수생/기타 
		ls_find = "tmhsupport_empno = '" + ETCMANCODE + "'"
	ElseIf as_suppgubun = OTHERDIVMAN Then // 타공장지원 
		ls_find = "tmhsupport_empno = '" + OTHERDIVMANCODE + "'"
	Else 
		ls_find = "( tmhsupport_empno = '' or IsNull(tmhsupport_empno) )"
	End If 
Else 
	ls_find = "tmhsupport_empno = '" + as_empNo + "'" 
End If 

ls_supWorkCenter = as_supWorkcenter

integer ln_row

ln_row =adw.GetRow()
if ln_row <> 0 then
// messagebox("AA",string(ln_row)) 
	If adw = dw_msupp Then 	// 지원해줌 
		If ls_supWorkCenter = '' Then  ls_supWorkCenter = adw.GetItemString(ln_row, "tmhsupport_supworkcenter") 
		If IsNull(ls_supWorkCenter) Then ls_supWorkCenter = ''
		ls_find += " And tmhsupport_supworkcenter = '" + ls_supWorkCenter + "'" 
	Else							// 지원받음 
		If ls_supWorkCenter = '' Then  ls_supWorkCenter = adw.GetItemString(ln_row, "tmhsupport_workcenter") 
		If IsNull(ls_supWorkCenter) Then ls_supWorkCenter = ''
		ls_find += " And tmhsupport_workcenter = '" + ls_supWorkCenter + "'" 
	End If 
end if

ll_findRow = adw.find(ls_find, 1, adw.RowCount())

Return ll_findRow 

end function

on w_pism020u.create
int iCurrent
call super::create
this.cb_retrieve=create cb_retrieve
this.cb_psupp_4=create cb_psupp_4
this.cb_msupp_4=create cb_msupp_4
this.cb_pdelete=create cb_pdelete
this.cb_mdelete=create cb_mdelete
this.dw_psupp=create dw_psupp
this.dw_msupp=create dw_msupp
this.st_3=create st_3
this.st_2=create st_2
this.st_hbar=create st_hbar
this.cb_psupp_2=create cb_psupp_2
this.cb_psupp_3=create cb_psupp_3
this.cb_psupp_1=create cb_psupp_1
this.cb_msupp_1=create cb_msupp_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.st_wday=create st_wday
this.st_4=create st_4
this.st_6=create st_6
this.st_wcname=create st_wcname
this.gb_2=create gb_2
this.gb_3=create gb_3
this.st_wccode=create st_wccode
this.cb_msupp_2=create cb_msupp_2
this.cb_msupp_3=create cb_msupp_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_retrieve
this.Control[iCurrent+2]=this.cb_psupp_4
this.Control[iCurrent+3]=this.cb_msupp_4
this.Control[iCurrent+4]=this.cb_pdelete
this.Control[iCurrent+5]=this.cb_mdelete
this.Control[iCurrent+6]=this.dw_psupp
this.Control[iCurrent+7]=this.dw_msupp
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_hbar
this.Control[iCurrent+11]=this.cb_psupp_2
this.Control[iCurrent+12]=this.cb_psupp_3
this.Control[iCurrent+13]=this.cb_psupp_1
this.Control[iCurrent+14]=this.cb_msupp_1
this.Control[iCurrent+15]=this.cb_close
this.Control[iCurrent+16]=this.cb_save
this.Control[iCurrent+17]=this.st_wday
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.st_6
this.Control[iCurrent+20]=this.st_wcname
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.gb_3
this.Control[iCurrent+23]=this.st_wccode
this.Control[iCurrent+24]=this.cb_msupp_2
this.Control[iCurrent+25]=this.cb_msupp_3
end on

on w_pism020u.destroy
call super::destroy
destroy(this.cb_retrieve)
destroy(this.cb_psupp_4)
destroy(this.cb_msupp_4)
destroy(this.cb_pdelete)
destroy(this.cb_mdelete)
destroy(this.dw_psupp)
destroy(this.dw_msupp)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_hbar)
destroy(this.cb_psupp_2)
destroy(this.cb_psupp_3)
destroy(this.cb_psupp_1)
destroy(this.cb_msupp_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.st_wday)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.st_wcname)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.st_wccode)
destroy(this.cb_msupp_2)
destroy(this.cb_msupp_3)
end on

event resize;call super::resize;Long ll_Height 

dw_msupp.Width = newwidth - ( dw_msupp.x + 20 ) 
st_hbar.Width = dw_msupp.Width 
dw_psupp.Width = dw_msupp.Width  

ll_Height = ( newheight - ( dw_msupp.y + ( dw_psupp.y - ( dw_msupp.y + dw_msupp.Height ) ) ) ) / 2 

dw_msupp.Height = ll_Height 

st_hbar.y = dw_msupp.y + dw_msupp.Height 
dw_psupp.y = dw_msupp.y + dw_msupp.Height + st_hbar.Height + 92 
st_3.y = dw_psupp.y - st_3.Height 

cb_psupp_1.y = dw_psupp.y - 85; cb_psupp_2.y = cb_psupp_1.y; cb_psupp_3.y = cb_psupp_1.y; cb_pdelete.y = cb_psupp_1.y 
dw_psupp.Height = newheight - ( dw_psupp.y + 10 ) 

cb_retrieve.x = newwidth - ( cb_retrieve.Width + cb_save.Width + cb_close.Width + 10 ) 
cb_save.x = cb_retrieve.x + cb_retrieve.Width 
cb_close.x = cb_save.x + cb_save.Width 
end event

event open;call super::open;f_pisc_win_center_move(This)

cb_save.Enabled = False 
cb_msupp_1.Enabled = m_frame.m_action.m_save.Enabled 
cb_msupp_2.Enabled = cb_msupp_1.Enabled 
cb_msupp_3.Enabled = cb_msupp_1.Enabled
cb_msupp_4.Enabled = cb_msupp_1.Enabled
cb_mdelete.Enabled = cb_msupp_1.Enabled
cb_psupp_1.Enabled = cb_msupp_1.Enabled 
cb_psupp_2.Enabled = cb_msupp_1.Enabled 
cb_psupp_3.Enabled = cb_msupp_1.Enabled 
cb_psupp_4.Enabled = cb_msupp_1.Enabled 
cb_pdelete.Enabled = cb_msupp_1.Enabled 

This.PostEvent("ue_post_open") 
end event

event ue_retrieve;call super::ue_retrieve;f_pism_working_msg(String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + &
						 st_wcname.Text + " 조", "지원공수 내역을 조회중입니다. 잠시만 기다려 주십시오.") 

dw_msupp.SetTransObject(SqlPIS); dw_psupp.SetTransObject(SqlPIS)
dw_msupp.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday)
dw_psupp.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday)

If IsValid(w_pism_working) Then Close(w_pism_working)


end event

event ue_save;call super::ue_save;
f_pism_working_msg(String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + &
						 st_wcname.Text + " 조", "지원내역을 저장중입니다. 잠시만 기다려 주십시오.") 

If dw_msupp.Event Save_data() = -1 Then Goto Exit_pr 
If dw_psupp.Event Save_data() = -1 Then Goto Exit_pr 

is_modchk = '1' 
cb_save.Enabled = False 

Exit_pr: 
If IsValid(w_pism_working) Then Close(w_pism_working) 
If Not cb_save.Enabled Then Return 1 

f_pism_MessageBox(StopSign!, -1, "저장실패", "해당 지원내역 저장에 실패했습니다.") 

Return -1 
end event

type cb_retrieve from commandbutton within w_pism020u
integer x = 2322
integer y = 32
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;Parent.TriggerEvent("ue_Retrieve") 
end event

type cb_psupp_4 from commandbutton within w_pism020u
boolean visible = false
integer x = 1829
integer y = 1072
integer width = 457
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간접조지원"
end type

event clicked;//dw_psupp.Event Insert_data(OSIDERMAN)
end event

type cb_msupp_4 from commandbutton within w_pism020u
boolean visible = false
integer x = 1371
integer y = 176
integer width = 457
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간접조지원"
end type

event clicked;//dw_msupp.Event Insert_data(OSIDERMAN)
end event

type cb_pdelete from commandbutton within w_pism020u
integer x = 1829
integer y = 1072
integer width = 457
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;dw_psupp.TriggerEvent("delete_data")

cb_save.Enabled = True 
end event

type cb_mdelete from commandbutton within w_pism020u
integer x = 1371
integer y = 172
integer width = 457
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;dw_msupp.TriggerEvent("delete_data")

cb_save.Enabled = True 
end event

type dw_psupp from u_pism_dw within w_pism020u
event type long insert_data ( string as_suppgubun )
integer x = 23
integer y = 1156
integer width = 3328
integer height = 588
integer taborder = 80
string dataobject = "d_pism020u_02"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 0
end type

event type long insert_data(string as_suppgubun);Long ll_insRow 
DateTime ldt_DT 

ll_insRow = wf_findRow(This, '', as_suppgubun, '')
If ll_insRow = 0 Then

	ll_insRow = This.InsertRow(0)
	wf_setsupppk(This, "tmhsupport_supworkcenter", ll_insRow) 
	If wf_suppValidChk(This, as_suppgubun) = -1 Then Return 0
	
	This.SetItem(ll_insRow, "tmhsupport_supgubun", as_suppgubun)
	If as_suppgubun = ETCMAN Then 			// 기타/연수생
		This.SetItem(ll_insRow, "tmhsupport_empno", ETCMANCODE)
		This.SetItem(ll_insrow, "tmhsupport_workcenter", "XXXX")
	ElseIf as_suppgubun = OTHERDIVMAN Then // 타공장지원 
		This.SetItem(ll_insRow, "tmhsupport_empno", OTHERDIVMANCODE)
		This.SetItem(ll_insrow, "tmhsupport_workcenter", "XXXX")
	End If 
End If 

This.ScrollToRow(ll_insRow) 
If as_suppgubun = '1' Then 
	This.Setcolumn("tmstemp_empname") 
Else
	This.Setcolumn("tmhsupport_supmh") 
End If 
This.SetFocus()

Return ll_insRow 
end event

event itemchanged;call super::itemchanged;String ls_dailyStatus, ls_Date, ls_Hour, ls_wc, ls_empNo, ls_NULL 
SetNull(ls_NULL) 

Choose Case String(dwo.Name) 
	Case 'tmhsupport_empno' 
		ls_wc = This.GetItemString(row, "tmhsupport_workcenter") 
		If wf_empnovalidchk(This, row, data) = -1 Then Return 1 
		wf_setsuppempdngbn(This, row, ls_wc, data) 

	Case 'tmstemp_empname'
		ls_wc = This.GetItemString(row, "tmhsupport_workcenter") 
		wf_empnamevalidchk(This, row, ls_wc, data)
		ls_empNo = This.GetItemString(row, "tmhsupport_empno") 
		wf_setsuppempdngbn(This, row, ls_wc, ls_empNo) 

		Return 1 
	Case 'tmhsupport_workcenter', 'tmhsupport_workcenter_1' 
		This.SetItem(row, "tmhsupport_empno", ls_NULL) 
		This.SetItem(row, "tmstemp_empname", ls_NULL) 

		If idwc_p.Find("workcenter = '" + data + "'", 1, idwc_p.RowCount()) = 0 Then 
			f_pism_MessageBox(Information!, -1, "조(부서)코드입력오류", "존재하지 않는 조(부서)코드입니다.")
			This.SetItem(row, String(dwo.Name), ls_NULL) 
			Return 1 
		End If 

		If wf_wcvalidchk(This, row, data) = -1 Then Return 1 
		
	Case "tmhsupport_fromtime" 
		ls_Date = Left(data,10); ls_Date = String(Date(ls_Date), "YYYY.MM.DD") 
		ls_Hour = Mid(data,12,2) 
		
		If ls_Date = istr_mh.wday And ( ls_Hour >= '00' And ls_Hour < '08' ) Then Return 1 
		If ls_Date = is_tmorrow   And ls_Hour > '08' Then Return 1 
		
		If wf_fromtimevalidchk(This, row, data) = -1 Then Return 1 
		
	Case "tmhsupport_totime" 
		ls_Date = Left(data,10); ls_Date = String(Date(ls_Date), "YYYY.MM.DD") 
		ls_Hour = Mid(data,12,2) 

		If ls_Date = istr_mh.wday And ( ls_Hour >= '00' And ls_Hour <= '08' ) Then Return 1 
		If ls_Date = is_tmorrow   And ls_Hour > '08' Then Return 1 

		If wf_totimevalidchk(This, row, data) = -1 Then Return 1 
		
End choose 

This.AcceptText() 
if m_frame.m_action.m_save.Enabled = true then
	cb_save.Enabled = True 
end if
end event

event itemerror;call super::itemerror;String ls_Hour, ls_setData, ls_Date, ls_Time 
DateTime ldt_supDateTime 

If dwo.Name = 'tmhsupport_fromtime' or dwo.Name = 'tmhsupport_totime' Then 
	ls_Date = Left(data,10); ls_Date = String(Date(ls_Date), "YYYY.MM.DD") 
	ls_Hour = Mid(data,12,2) 
	If ls_Date = istr_mh.wday And ( ls_Hour >= '00' And ls_Hour <= '08' ) Then 
		ls_setData = Replace(data, 1, 10, is_tmorrow) 
		wf_setSupDateTime(This, ls_setData) 
	ElseIf ls_Date = is_tmorrow   And ls_Hour > '08' Then 
		ls_setData = Replace(data, 1, 10, istr_mh.wday) 
		wf_setSupDateTime(This, ls_setData) 
	End If 	
End If 

Return 1 
end event

event itemfocuschanged;call super::itemfocuschanged;String ls_suppWC, ls_supGbn, ls_wcFilter, ls_empFilter 

If row <= 0 Then Return 

If dwo.Name = 'tmhsupport_fromtime' or dwo.Name = 'tmhsupport_totime' Then
	This.SelectText(12, 16) 
Else
	This.SelectText(1, 30) 
End If 

//If Not IsValid(idwc_p) Then Return 
//
//If String(dwo.Name) = 'tmhsupport_workcenter_1' Then 
//	ls_supGbn = This.GetItemString(row, "tmhsupport_supgubun")
//	If ls_supGbn = OSIDERMAN Then 
//		ls_wcFilter = "IsNull(WorkCenterGubun2) or WorkCenterGubun2 = ''" 	// 간접조만 Filter 
//	Else
//		ls_wcFilter = "if( isnull( workcentergubun2 ), '',  workcentergubun2 ) <> ''"   // 직접조만 Filter 
//	End If 
//Else
//	ls_wcFilter = '' 
//End If 
//
//idwc_p.SetFilter(ls_wcFilter)
//idwc_p.Filter(); idwc_p.Sort() 

If String(dwo.Name) = 'tmstemp_empname' Then 
	ls_suppWC = This.GetItemString(row, "tmhsupport_workcenter") 
	If IsNull(ls_suppWC) Then ls_suppWC = '' 
	ls_empFilter = "WorkCenter = '" + ls_suppWC + "'" 
	If ls_suppWC = '' Then ls_empFilter = '' 
Else
	ls_empFilter = '' 
End If 

idwc_emp.SetFilter(ls_empFilter)
idwc_emp.Filter(); idwc_emp.Sort() 

end event

event retrievestart;call super::retrievestart;DataWindowChild ldwc 

If This.GetChild('tmstemp_empname', idwc_emp) <> -1 Then 
	idwc_emp.SetTransObject(sqlPIS); idwc_emp.Retrieve('%', istr_mh.wday)  
End If 

If dw_psupp.GetChild('tmhsupport_workcenter_1', idwc_p) <> -1 Then 
	idwc_p.SetTransObject(sqlPIS); idwc_p.Retrieve(istr_mh.area, istr_mh.div, '%') 
	idwc_p.DeleteRow(idwc_p.Find("workcenter = '" + istr_mh.wc + "'", 1, idwc_p.RowCount())) 
	
	idwc_p.SetFilter(""); idwc_p.Filter(); idwc_p.Sort()
End If 

end event

event save_data;call super::save_data;wf_delunvalidrow(This)
Return f_pism_dwupdate(This, True)
end event

event delete_data;call super::delete_data;Long ll_delRow 
String ls_empNo, ls_empName, ls_dailyStatus, ls_supWc, ls_wcName 
str_pism_daily lstr_mh 

ll_delRow = This.GetRow() 

ls_empNo = This.GetItemString(ll_delRow, "tmhsupport_empno")
ls_empName = This.GetItemString(ll_delRow, "tmstemp_empname")
ls_supwc = This.GetItemString(ll_delRow, "tmhsupport_workcenter") 

ls_dailyStatus = f_pism_getdailystatus(istr_mh.area, istr_mh.div, ls_supwc, istr_mh.wday) 
If ls_dailyStatus = '1' Then 
	lstr_mh = istr_mh; lstr_mh.wc = ls_supwc 
	ls_wcName = f_pism_getwcname(lstr_mh) 
	f_pism_MessageBox(Information!, -1, "삭제실패", "[" + ls_supwc + "]" + ls_wcName + "~n~n해당조의 작업일보가 확정된 상태이므로 삭제할 수 없습니다.")
	Return -1 
End If 

If IsNull(ls_empNo) or IsNull(ls_supwc) Then Goto Del_row
If f_pism_MessageBox(Question!, 9999, "지원받음 삭제", '[' + ls_empNo + "] " + ls_empName + " 해당 사원의 " + & 
							"지원내역을 삭제하시겠습니까?") <> 1 Then Return 0 
	
Del_row:
	This.DeleteRow(ll_delRow) 

Return ll_delRow 
end event

type dw_msupp from u_pism_dw within w_pism020u
event type long insert_data ( string as_suppgubun )
integer x = 23
integer y = 252
integer width = 3328
integer height = 780
integer taborder = 60
string dataobject = "d_pism020u_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 0
end type

event type long insert_data(string as_suppgubun);Long ll_insRow 
DateTime ldt_DT 

ll_insRow = wf_findRow(This, '', as_suppgubun, '')
If ll_insRow = 0 Then 
	ll_insRow = This.InsertRow(0) 
	wf_setsupppk(This, "tmhsupport_workcenter", ll_insRow) 
	
	This.SetItem(ll_insRow, "tmhsupport_supgubun", as_suppgubun)
	If as_suppgubun = ETCMAN Then 
		This.SetItem(ll_insRow, "tmhsupport_empno", etcmancode)
	ElseIf as_suppgubun = OTHERDIVMAN Then 
		This.SetItem(ll_insRow, "tmhsupport_supworkcenter", 'XXXX')
	End If
	
End If 

This.ScrollToRow(ll_insRow) 
If as_suppgubun = ETCMAN Then 
	This.Setcolumn("tmhsupport_supworkcenter") 
Else 
	This.Setcolumn("tmstemp_empname") 
End If 
This.SetFocus() 

Return ll_insRow 
end event

event itemchanged;call super::itemchanged;String ls_dailyStatus, ls_Hour, ls_Date, ls_empNo, ls_empWC 

Choose Case String(dwo.Name) 
	Case 'tmhsupport_empno' 
		If wf_empnovalidchk(This, row, data) = -1 Then Return 1 
		ls_empNo = data
		wf_setsuppempdngbn(This, row, '', ls_empNo) 
		
		return 1
	Case 'tmstemp_empname'
		If wf_empnamevalidchk(This, row, istr_mh.wc, data) = -1 Then Return 1 
		ls_empNo = This.GetItemString(row, "tmhsupport_empno") 
		wf_setsuppempdngbn(This, row, '', ls_empNo) 
		
		Return 1 
	Case 'tmhsupport_supworkcenter', 'tmhsupport_supworkcenter_1' 
		If idwc_m.Find("workcenter = '" + data + "'", 1, idwc_m.RowCount()) = 0 Then 
			f_pism_MessageBox(Information!, -1, "조(부서)코드입력오류", "존재하지 않는 조(부서)코드입니다.")
			SetNull(ls_empWC); This.SetItem(row, String(dwo.Name), ls_empWC) 
			Return 1 
		End If 
		
		If wf_wcvalidchk(This, row, data) = -1 Then Return 1 
	
	Case "tmhsupport_fromtime" 
		ls_Date = Left(data,10); ls_Date = String(Date(ls_Date), "YYYY.MM.DD") 
		ls_Hour = Mid(data,12,2) 
		
		If ls_Date = istr_mh.wday And ( ls_Hour >= '00' And ls_Hour < '08' ) Then Return 1 
		If ls_Date = is_tmorrow   And ls_Hour > '08' Then Return 1 
		
		If wf_fromtimevalidchk(This, row, data) = -1 Then Return 1 
		
	Case "tmhsupport_totime" 
		ls_Date = Left(data,10); ls_Date = String(Date(ls_Date), "YYYY.MM.DD") 
		ls_Hour = Mid(data,12,2) 

		If ls_Date = istr_mh.wday And ( ls_Hour >= '00' And ls_Hour <= '08' ) Then Return 1 
		If ls_Date = is_tmorrow   And ls_Hour > '08' Then Return 1 

		If wf_totimevalidchk(This, row, data) = -1 Then Return 1 
		
End choose 

This.AcceptText() 
if m_frame.m_action.m_save.Enabled = true then
	cb_save.Enabled = True 
end if
end event

event itemerror;call super::itemerror;String ls_Hour, ls_setData, ls_Date, ls_Time 
DateTime ldt_supDateTime 

If dwo.Name = 'tmhsupport_fromtime' or dwo.Name = 'tmhsupport_totime' Then 
	ls_Date = Left(data,10); ls_Date = String(Date(ls_Date), "YYYY.MM.DD") 
	ls_Hour = Mid(data,12,2) 
	If ls_Date = istr_mh.wday And ( ls_Hour >= '00' And ls_Hour <= '08' ) Then 
		ls_setData = Replace(data, 1, 10, is_tmorrow) 
		wf_setSupDateTime(This, ls_setData)
	ElseIf ls_Date = is_tmorrow   And ls_Hour > '08' Then 
		ls_setData = Replace(data, 1, 10, istr_mh.wday) 
		wf_setSupDateTime(This, ls_setData) 
	End If 	
End If 

Return 1 

end event

event itemfocuschanged;call super::itemfocuschanged;String ls_supGbn, ls_Filter 

If row <= 0 Then Return 

If dwo.Name = 'tmhsupport_fromtime' or dwo.Name = 'tmhsupport_totime' Then
	This.SelectText(12, 16) 
Else
	This.SelectText(1, 30) 
End If 

//If Not IsValid(idwc_m) Then Return 
//
//If String(dwo.Name) = 'tmhsupport_supworkcenter_1' Then 
//	ls_supGbn = This.GetItemString(row, "tmhsupport_supgubun")
//	If ls_supGbn = OSIDERMAN Then 
//		ls_Filter = "IsNull(WorkCenterGubun2) or WorkCenterGubun2 = ''" 	// 간접조만 Filter 
//	Else
//		ls_Filter = "if( isnull( workcentergubun2 ), '',  workcentergubun2 ) <> ''"   // 직접조만 Filter 
//	End If 
//Else
//	ls_Filter = '' 
//End If 
//
//idwc_m.SetFilter(ls_Filter)
//idwc_m.Filter(); idwc_m.Sort() 

end event

event retrievestart;call super::retrievestart;DataWindowChild ldwc 

If This.GetChild('tmstemp_empname', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc, istr_mh.wday) 
End If 

If dw_msupp.GetChild('tmhsupport_supworkcenter_1', idwc_m) <> -1 Then 
	idwc_m.SetTransObject(sqlPIS); idwc_m.Retrieve(istr_mh.area, istr_mh.div, '%') 
	idwc_m.DeleteRow(idwc_m.Find("workcenter = '" + istr_mh.wc + "'", 1, idwc_m.RowCount())) 
	
	idwc_m.SetFilter(""); idwc_m.Filter(); idwc_m.Sort() 
End If 

end event

event save_data;call super::save_data;wf_delunvalidrow(This)
Return f_pism_dwupdate(This, False)
end event

event delete_data;call super::delete_data;Long ll_delRow 
String ls_empNo, ls_empName, ls_supWc, ls_dailyStatus, ls_wcName 
str_pism_daily lstr_mh

ll_delRow = This.GetRow() 

ls_empNo = This.GetItemString(ll_delRow, "tmhsupport_empno")
ls_empName = This.GetItemString(ll_delRow, "tmstemp_empname")
ls_supwc = This.GetItemString(ll_delRow, "tmhsupport_supworkcenter") 

ls_dailyStatus = f_pism_getdailystatus(istr_mh.area, istr_mh.div, ls_supwc, istr_mh.wday) 
If ls_dailyStatus = '1' Then 
	lstr_mh = istr_mh; lstr_mh.wc = ls_supwc 
	ls_wcName = f_pism_getwcname(lstr_mh) 
	f_pism_MessageBox(Information!, -1, "삭제실패", "[" + ls_supwc + "]" + ls_wcName + "~n~n해당조의 작업일보가 확정된 상태이므로 삭제할 수 없습니다.")
	Return -1 
End If 

If IsNull(ls_empNo) or IsNull(ls_supwc) Then Goto Del_row
If f_pism_MessageBox(Question!, 9999, "지원보냄 삭제",  '[' + ls_empNo + "] " + ls_empName + " 해당 사원의 " + & 
							"지원내역을 삭제하시겠습니까?") <> 1 Then Return 0 
	
Del_row:
	This.DeleteRow(ll_delRow) 

Return ll_delRow 
end event

event ue_key;call super::ue_key;////
end event

event clicked;call super::clicked;If row <= 0 Then Return 
This.SetRow(row); This.ScrollToRow(row); This.SetRedraw(True) 
end event

type st_3 from statictext within w_pism020u
integer x = 5
integer y = 1076
integer width = 425
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "[지원받음]"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pism020u
integer x = 5
integer y = 180
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[지원보냄]"
boolean focusrectangle = false
end type

type st_hbar from u_pism_splitbar within w_pism020u
integer x = 23
integer y = 1040
integer width = 1947
boolean bringtotop = true
end type

type cb_psupp_2 from commandbutton within w_pism020u
integer x = 914
integer y = 1072
integer width = 457
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기타직지원"
end type

event clicked;dw_psupp.Event Insert_data(ETCMAN)
end event

type cb_psupp_3 from commandbutton within w_pism020u
integer x = 1371
integer y = 1072
integer width = 457
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "타공장지원"
end type

event clicked;dw_psupp.Event Insert_data(OTHERDIVMAN)
end event

type cb_psupp_1 from commandbutton within w_pism020u
integer x = 457
integer y = 1072
integer width = 457
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일반지원"
end type

event clicked;dw_psupp.Event Insert_data(REGMAN)
end event

type cb_msupp_1 from commandbutton within w_pism020u
integer x = 457
integer y = 172
integer width = 457
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일반지원"
end type

event clicked;dw_msupp.Event Insert_data(REGMAN)
end event

type cb_close from commandbutton within w_pism020u
integer x = 3026
integer y = 32
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;If cb_save.Enabled Then 
	If f_pism_MessageBox(Question!, 999, "저장", "수정된 자료를 저장하시겠습니까?") = 1 Then Parent.TriggerEvent("ue_save") 
End If 

CloseWithReturn(Parent, is_modChk) 
end event

type cb_save from commandbutton within w_pism020u
integer x = 2674
integer y = 32
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;Parent.TriggerEvent("ue_save") 
end event

type st_wday from statictext within w_pism020u
integer x = 1591
integer y = 48
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pism020u
integer x = 64
integer y = 60
integer width = 142
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_pism020u
integer x = 1262
integer y = 60
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업일자:"
boolean focusrectangle = false
end type

type st_wcname from statictext within w_pism020u
integer x = 457
integer y = 48
integer width = 709
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_pism020u
integer x = 1230
integer width = 809
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pism020u
integer x = 14
integer width = 1211
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_wccode from statictext within w_pism020u
integer x = 197
integer y = 48
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_msupp_2 from commandbutton within w_pism020u
boolean visible = false
integer x = 914
integer y = 176
integer width = 457
integer height = 80
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기타직지원"
end type

event clicked;dw_msupp.Event Insert_data(ETCMAN)
end event

type cb_msupp_3 from commandbutton within w_pism020u
integer x = 914
integer y = 172
integer width = 457
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "타공장지원"
end type

event clicked;dw_msupp.Event Insert_data(OTHERDIVMAN)
end event

