$PBExportHeader$w_tmm320u.srw
$PBExportComments$작업일지관리[정밀측정]
forward
global type w_tmm320u from w_ipis_sheet01
end type
type st_1 from statictext within w_tmm320u
end type
type dw_tmm320u_01 from datawindow within w_tmm320u
end type
type dw_tmm320u_02 from datawindow within w_tmm320u
end type
type uo_applydate from u_tmm_date_applydate within w_tmm320u
end type
type dw_tmm320u_03 from datawindow within w_tmm320u
end type
type dw_tmm320u_04 from datawindow within w_tmm320u
end type
type st_4 from statictext within w_tmm320u
end type
type dw_tmm320u_05 from datawindow within w_tmm320u
end type
type cb_signcancel from commandbutton within w_tmm320u
end type
type cb_signok from commandbutton within w_tmm320u
end type
type st_sanctionemp from statictext within w_tmm320u
end type
type st_partemp from statictext within w_tmm320u
end type
type st_teamemp from statictext within w_tmm320u
end type
type cbx_sanction from checkbox within w_tmm320u
end type
type cbx_part from checkbox within w_tmm320u
end type
type cbx_team from checkbox within w_tmm320u
end type
type st_inform from statictext within w_tmm320u
end type
type gb_1 from groupbox within w_tmm320u
end type
type gb_3 from groupbox within w_tmm320u
end type
end forward

global type w_tmm320u from w_ipis_sheet01
st_1 st_1
dw_tmm320u_01 dw_tmm320u_01
dw_tmm320u_02 dw_tmm320u_02
uo_applydate uo_applydate
dw_tmm320u_03 dw_tmm320u_03
dw_tmm320u_04 dw_tmm320u_04
st_4 st_4
dw_tmm320u_05 dw_tmm320u_05
cb_signcancel cb_signcancel
cb_signok cb_signok
st_sanctionemp st_sanctionemp
st_partemp st_partemp
st_teamemp st_teamemp
cbx_sanction cbx_sanction
cbx_part cbx_part
cbx_team cbx_team
st_inform st_inform
gb_1 gb_1
gb_3 gb_3
end type
global w_tmm320u w_tmm320u

forward prototypes
public function integer wf_cal_summary (string ag_tmgubun, string ag_workdate, ref string ag_message)
end prototypes

public function integer wf_cal_summary (string ag_tmgubun, string ag_workdate, ref string ag_message);//반환값 성공 : 0 , 실패 : -1
string ls_startdate, ls_gaugeorder
dec{1} lc_totaltime, lc_measuretime
dec{0} lc_dayfee, lc_sumfee
integer li_count

ls_startdate = mid(ag_workdate,1,6) + '01'
// 집계데이타 생성
// 1. 전체시간 집계
SELECT SUM("PBGMS"."TMM006"."DUTYTIME")
INTO :lc_totaltime
FROM "PBGMS"."TMM006"
WHERE ( "PBGMS"."TMM006"."TMGUBUN" = :ag_tmgubun ) AND
		( "PBGMS"."TMM006"."WORKDATE" = :ag_workdate )
using sqlca;

if sqlca.sqlcode <> 0 then
	ag_message = "근무시간 집계에러"
	return -1
end if
// 2. 금일수수료금액 및 시험시간 집계
SELECT SUM("PBGMS"."TMM003"."TOOLTIME"), SUM("PBGMS"."TMM003"."FEE")
INTO :lc_measuretime, :lc_dayfee
 FROM "PBGMS"."TMM002",   
		"PBGMS"."TMM003"
WHERE ( "PBGMS"."TMM002"."ORDERNO" = "PBGMS"."TMM003"."ORDERNO" ) AND       
		( "PBGMS"."TMM002"."INGSTATUS" <> 'A' ) AND  
		( "PBGMS"."TMM002"."TMGUBUN" = :ag_tmgubun ) AND  
		( "PBGMS"."TMM002"."ORDERNO" = "PBGMS"."TMM003"."ORDERNO" ) AND  
		( "PBGMS"."TMM002"."ENDDATE" = :ag_workdate )  
using sqlca;

if sqlca.sqlcode <> 0 then
	ag_message = "수수료,시험시간 집계 에러"
	return -1	
end if
// 3. 월 누적금액 집계
SELECT SUM("PBGMS"."TMM003"."FEE")
INTO :lc_sumfee
 FROM "PBGMS"."TMM002",   
		"PBGMS"."TMM003"
WHERE ( "PBGMS"."TMM002"."ORDERNO" = "PBGMS"."TMM003"."ORDERNO" ) AND       
		( "PBGMS"."TMM002"."INGSTATUS" <> 'A' ) AND  
		( "PBGMS"."TMM002"."TMGUBUN" = :ag_tmgubun ) AND  
		( "PBGMS"."TMM002"."ORDERNO" = "PBGMS"."TMM003"."ORDERNO" ) AND
		( "PBGMS"."TMM002"."ENDDATE" >= :ls_startdate ) AND
		( "PBGMS"."TMM002"."ENDDATE" <= :ag_workdate )  
using sqlca;

if sqlca.sqlcode <> 0 then
	ag_message = "수수료,시험시간 집계 에러"
	return -1	
end if

if isnull(lc_totaltime) then lc_totaltime = 0
if isnull(lc_measuretime) then lc_measuretime = 0
if isnull(lc_dayfee) then lc_dayfee = 0
if isnull(lc_sumfee) then lc_sumfee = 0
dw_tmm320u_03.setitem(1,"totaltime",lc_totaltime)
dw_tmm320u_03.setitem(1,"measuretime",lc_measuretime)
dw_tmm320u_03.setitem(1,"dayfee",lc_dayfee)
dw_tmm320u_03.setitem(1,"sumfee",lc_sumfee)
dw_tmm320u_03.setitem(1,"lastemp", g_s_empno)
dw_tmm320u_03.setitem(1,"lastdate", g_s_date)

if dw_tmm320u_03.update() <> 1 then
	ag_message = "작업일지 저장에러"
	return -1
end if

//*************************************************
//* 4. 계측기 시간 생성로직추가 (2008.02.21)
//* tmm002 orderno 생성 : ag_tmgubun + ag_workdate + 'X'
//* tmm003 건수 1, 수량 1, tooltime 입력
//*************************************************
ls_gaugeorder = ag_tmgubun + ag_workdate + 'X'
lc_measuretime = dw_tmm320u_03.getitemnumber(1, "tooltime")
if isnull(lc_measuretime) then lc_measuretime = 0

if lc_measuretime > 0 then
	SELECT COUNT(*) INTO :li_count FROM "PBGMS"."TMM002" INNER JOIN "PBGMS"."TMM003"
	ON "PBGMS"."TMM002"."ORDERNO" = "PBGMS"."TMM003"."ORDERNO"
	WHERE "PBGMS"."TMM002"."ORDERNO" = :ls_gaugeorder
	using sqlca;
	
	if li_count = 1 then
		UPDATE PBGMS.TMM003
		SET ToolTime = :lc_measuretime
		WHERE OrderNo = :ls_gaugeorder
		using sqlca;
		
		if sqlca.sqlnrows < 1 then
			ag_message = "계측기시간 업데이트 에러"
			return -1
		end if
	else
		INSERT INTO PBGMS.TMM002 (
  		ORDERNO,TMGUBUN,DEPTGUBUN,ORDERMAN,ORDERDEPT,PRODUCTID,ITEMCODE,ITEMNAME,PROJECTNO,ITEMSPEC,
  		ORDERQTY,TESTITEM,RELATIVENAME,FOREDATE,ORDERCONTENT,URGENTFLAG,ORDERDATE,ORDEREMPNO,
  		ENDDATE,INGSTATUS,MEMO,LASTEMP,LASTDATE)
		VALUES(
		:ls_gaugeorder, :ag_tmgubun, '1', '시스템', '2102','04','','','','',
		1, 'R', '', :ag_workdate, '계측기시간입력용 자동생성 의뢰건','N',:ag_workdate,'',
		:ag_workdate, 'D', '', :g_s_empno, :g_s_datetime )
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ag_message = "계측기시간입력용 자동생성 의뢰건 생성에러"
			return -1
		end if
		
		INSERT INTO PBGMS.TMM003 ( 
		ORDERNO,TOOLID,RESULTQTY,MEASUREQTY,TOOLTIME,
  		ENDDATE,ENDDATETIME,FEE,LASTEMP,LASTDATE )
		VALUES (
		:ls_gaugeorder, '58', 1, 1, :lc_measuretime,
		'', '', 0, :g_s_empno, :g_s_datetime )
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ag_message = "계측기시간입력용 자동생성 의뢰건 결과생성 에러"
			return -1
		end if
	end if
else
	DELETE FROM PBGMS.TMM002
	WHERE ORDERNO = :ls_gaugeorder
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ag_message = "계측기시간입력용 자동생성 의뢰건 삭제에러"
		return -1
	end if
	
	DELETE FROM PBGMS.TMM003
	WHERE ORDERNO = :ls_gaugeorder
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ag_message = "계측기시간입력용 자동생성 의뢰건 결과 삭제에러"
		return -1
	end if
end if

return 0
end function

on w_tmm320u.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_tmm320u_01=create dw_tmm320u_01
this.dw_tmm320u_02=create dw_tmm320u_02
this.uo_applydate=create uo_applydate
this.dw_tmm320u_03=create dw_tmm320u_03
this.dw_tmm320u_04=create dw_tmm320u_04
this.st_4=create st_4
this.dw_tmm320u_05=create dw_tmm320u_05
this.cb_signcancel=create cb_signcancel
this.cb_signok=create cb_signok
this.st_sanctionemp=create st_sanctionemp
this.st_partemp=create st_partemp
this.st_teamemp=create st_teamemp
this.cbx_sanction=create cbx_sanction
this.cbx_part=create cbx_part
this.cbx_team=create cbx_team
this.st_inform=create st_inform
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_tmm320u_01
this.Control[iCurrent+3]=this.dw_tmm320u_02
this.Control[iCurrent+4]=this.uo_applydate
this.Control[iCurrent+5]=this.dw_tmm320u_03
this.Control[iCurrent+6]=this.dw_tmm320u_04
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.dw_tmm320u_05
this.Control[iCurrent+9]=this.cb_signcancel
this.Control[iCurrent+10]=this.cb_signok
this.Control[iCurrent+11]=this.st_sanctionemp
this.Control[iCurrent+12]=this.st_partemp
this.Control[iCurrent+13]=this.st_teamemp
this.Control[iCurrent+14]=this.cbx_sanction
this.Control[iCurrent+15]=this.cbx_part
this.Control[iCurrent+16]=this.cbx_team
this.Control[iCurrent+17]=this.st_inform
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.gb_3
end on

on w_tmm320u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_tmm320u_01)
destroy(this.dw_tmm320u_02)
destroy(this.uo_applydate)
destroy(this.dw_tmm320u_03)
destroy(this.dw_tmm320u_04)
destroy(this.st_4)
destroy(this.dw_tmm320u_05)
destroy(this.cb_signcancel)
destroy(this.cb_signok)
destroy(this.st_sanctionemp)
destroy(this.st_partemp)
destroy(this.st_teamemp)
destroy(this.cbx_sanction)
destroy(this.cbx_part)
destroy(this.cbx_team)
destroy(this.st_inform)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_tmm320u_01.Width = (newwidth * 2 / 5 )
dw_tmm320u_01.Height= ( newheight / 2 ) - ls_split

dw_tmm320u_02.x = dw_tmm320u_01.x + dw_tmm320u_01.Width + ls_gap
dw_tmm320u_02.y = dw_tmm320u_01.y
dw_tmm320u_02.Width = newwidth - ( dw_tmm320u_01.x + dw_tmm320u_01.Width + ls_gap * 3)
dw_tmm320u_02.Height = dw_tmm320u_01.Height * 3 / 5

dw_tmm320u_03.x = dw_tmm320u_02.x
dw_tmm320u_03.y = dw_tmm320u_01.y + dw_tmm320u_02.Height + ls_gap
dw_tmm320u_03.Width = dw_tmm320u_02.Width
dw_tmm320u_03.Height = dw_tmm320u_01.Height - ( dw_tmm320u_02.Height + ls_gap )

dw_tmm320u_04.x = dw_tmm320u_01.x
dw_tmm320u_04.y = dw_tmm320u_01.y + dw_tmm320u_01.Height + ls_gap
dw_tmm320u_04.Width = newwidth - ls_gap * 4
dw_tmm320u_04.Height = ( newheight - ( dw_tmm320u_04.y  + ls_status) ) * 3 / 5 - 40

dw_tmm320u_05.x = dw_tmm320u_01.x
dw_tmm320u_05.y = dw_tmm320u_04.y + dw_tmm320u_04.Height + ls_gap
dw_tmm320u_05.Width = newwidth - ls_gap * 4
dw_tmm320u_05.Height = newheight - ( dw_tmm320u_05.y  + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_tmm320u_01.settransobject(sqlca)
dw_tmm320u_02.settransobject(sqlca)
dw_tmm320u_03.settransobject(sqlca)
dw_tmm320u_04.settransobject(sqlca)
dw_tmm320u_05.settransobject(sqlca)

This.Triggerevent("ue_retrieve")

end event

event ue_retrieve;call super::ue_retrieve;string ls_workdate, ls_tmgubun, ls_message, ls_predate, ls_sanctionflag, ls_signdate
integer li_rtn

ls_tmgubun = 'M'
ls_workdate = string(date(uo_applydate.is_uo_date),"yyyymmdd")
ls_predate = f_relativedate(ls_workdate,-1)

if ls_workdate > g_s_date then
	uo_status.st_message.text = "기준일은 금일보다 같거나 적어야 합니다."
	return 0
end if

//if daynumber(date(uo_applydate.is_uo_date)) = 1 or &
//	daynumber(date(uo_applydate.is_uo_date)) = 7 then
//	li_rtn = MessageBox("확인", "선택한 날짜는 주말입니다. 근태정보를 입력하시겠습니까?", Exclamation!, OKCancel!, 2)
//	if li_rtn = 2 then
//		return 0
//	end if
//end if

//최종결재일 알림메트
SELECT MAX(Workdate) INTO :ls_signdate
FROM PBGMS.TMM007
WHERE SanctionFlag = 'Y' AND Tmgubun = :ls_tmgubun
using sqlca;

st_inform.text = "최종직장결재일은 " + string(ls_signdate,"@@@@.@@.@@") + " 입니다."

SELECT SanctionFlag INTO :ls_sanctionflag
FROM PBGMS.TMM007
WHERE Workdate = :ls_predate AND Tmgubun = :ls_tmgubun
using sqlca;

if isnull(ls_sanctionflag) or ls_sanctionflag <> 'Y' then
	uo_status.st_message.text = "전일 작업일지가 결재되지 않았습니다."
	return 0
end if

sqlca.autocommit = false

// 근태현황 생성
INSERT INTO PBGMS.TMM006(Workdate, Tmgubun, Empno, Dutytime, Overtime, 
		Event1, Event2, Memo, Lastemp, Lastdate )
SELECT :ls_workdate, aa.Tmgubun, aa.Empno, 0, 0,
		'', '', '', :g_s_empno, :g_s_datetime
FROM PBGMS.TMM005 aa
WHERE aa.Tmgubun = :ls_tmgubun AND aa.Useflag = 'N' AND
  NOT EXISTS ( SELECT bb.EmpNo FROM PBGMS.TMM006 bb WHERE aa.empno = bb.EmpNo AND
  					bb.Workdate = :ls_workdate AND bb.Tmgubun = :ls_tmgubun )
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "근태현황 생성에러"
	goto Rollback_
end if
// 작업일보 생성
SELECT COUNT(*) INTO :li_rtn
FROM PBGMS.TMM007
WHERE Workdate = :ls_workdate AND Tmgubun = :ls_tmgubun
using sqlca;

if li_rtn = 0 then
	INSERT INTO PBGMS.TMM007(Workdate, Tmgubun, Totaltime, Measuretime, 
		Dayfee, Sumfee, confirmflag, confirmemp, sanctionflag, sanctionemp, 
		partflag, partemp, teamflag, teamemp, specialnote, lastemp, lastdate )
	VALUES(:ls_workdate, :ls_tmgubun, 0, 0,
		0, 0, '', '', 'N', '', 
		'', '', '', '', '', :g_s_empno, :g_s_datetime)
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "작업일보 생성에러"
		goto Rollback_
	end if
end if

dw_tmm320u_03.retrieve(ls_workdate, ls_tmgubun, ls_tmgubun + ls_workdate + 'X')
if wf_cal_summary(ls_tmgubun, ls_workdate, ls_message) = -1 then
	goto Rollback_
end if

commit using sqlca;
sqlca.autocommit = true

dw_tmm320u_01.reset()
dw_tmm320u_02.reset()
dw_tmm320u_03.reset()
//**************************
//* CrossTab DW 인경우에 현재버전에서는 새로 설정하지 않는 이상 Reset이 안됨. 2008.02
//**************************
dw_tmm320u_04.dataobject = "d_tmm320u_04"
dw_tmm320u_04.settransobject(sqlca)
dw_tmm320u_04.reset()
dw_tmm320u_05.dataobject = "d_tmm320u_05"
dw_tmm320u_05.settransobject(sqlca)
dw_tmm320u_05.reset()

dw_tmm320u_01.retrieve(ls_workdate, ls_tmgubun)
dw_tmm320u_02.retrieve(ls_workdate, ls_tmgubun)
if dw_tmm320u_03.retrieve(ls_workdate, ls_tmgubun, ls_tmgubun + ls_workdate + 'X') < 1 then
	dw_tmm320u_03.insertrow(0)
end if
dw_tmm320u_04.retrieve(ls_workdate, ls_tmgubun)
dw_tmm320u_05.retrieve(ls_workdate, ls_tmgubun)

return 0

Rollback_:
rollback using sqlca;
sqlca.autocommit = true
uo_status.st_message.text = "근태정보생성에 실패했습니다. : " + ls_message
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= True
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_save;call super::ue_save;string ls_tmgubun, ls_workdate, ls_message
dec{1} lc_totaltime, lc_measuretime
dec{0} lc_dayfee

dw_tmm320u_02.accepttext()
dw_tmm320u_03.accepttext()
if dw_tmm320u_02.modifiedcount() < 1 and dw_tmm320u_03.modifiedcount() < 1 then
	uo_status.st_message.text = '수정된 데이타가 없습니다.'
	return 0
end if

ls_tmgubun = dw_tmm320u_02.getitemstring(1,"tmgubun")
ls_workdate = dw_tmm320u_02.getitemstring(1,"workdate")

sqlca.Autocommit = False

if dw_tmm320u_02.modifiedcount() > 0 then
	if dw_tmm320u_02.update() <> 1 then
		ls_message = "근태현황 저장에러"
		goto Rollback_	
	end if
	
	if wf_cal_summary(ls_tmgubun, ls_workdate, ls_message) = -1 then
		goto Rollback_
	end if
else
	if wf_cal_summary(ls_tmgubun, ls_workdate, ls_message) = -1 then
		goto Rollback_
	end if
end if

Commit using sqlca;
sqlca.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다. : ' + ls_message

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_tmm320u
end type

type st_1 from statictext within w_tmm320u
integer x = 55
integer y = 40
integer width = 270
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
string text = "조구분:"
alignment alignment = center!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_tmm320u_01 from datawindow within w_tmm320u
integer x = 23
integer y = 216
integer width = 1495
integer height = 796
integer taborder = 30
boolean bringtotop = true
string title = "시험분석건수집계"
string dataobject = "d_tmm320u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_tmm320u_02 from datawindow within w_tmm320u
integer x = 1545
integer y = 280
integer width = 1911
integer height = 376
integer taborder = 40
boolean bringtotop = true
string title = "근태현황"
string dataobject = "d_tmm320u_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type uo_applydate from u_tmm_date_applydate within w_tmm320u
event destroy ( )
integer x = 745
integer y = 36
integer taborder = 70
boolean bringtotop = true
end type

on uo_applydate.destroy
call u_tmm_date_applydate::destroy
end on

event ue_select;call super::ue_select;dw_tmm320u_01.reset()
dw_tmm320u_02.reset()
dw_tmm320u_03.reset()
dw_tmm320u_04.reset()
dw_tmm320u_05.reset()
cb_signok.visible = true
cb_signok.enabled = true
cb_signcancel.visible = false
cb_signcancel.enabled = false
cbx_sanction.checked = false
cbx_sanction.enabled = false
st_sanctionemp.text = "결재(인)"
cbx_part.checked = false
cbx_part.enabled = false
st_partemp.text = "결재(인)"
cbx_team.checked = false
cbx_team.enabled = false
st_teamemp.text = "결재(인)"
end event

type dw_tmm320u_03 from datawindow within w_tmm320u
integer x = 1550
integer y = 676
integer width = 1902
integer height = 336
integer taborder = 50
boolean bringtotop = true
string title = "작업일지"
string dataobject = "d_tmm320u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;string ls_empname, ls_signman

if rowcount = 1 then
	cb_signok.visible = true
	cb_signok.enabled = true
	cb_signcancel.visible = false
	cb_signcancel.enabled = false
	cbx_sanction.checked = false
	cbx_sanction.enabled = false
	st_sanctionemp.text = "결재(인)"
	cbx_part.checked = false
	cbx_part.enabled = false
	st_partemp.text = "결재(인)"
	cbx_team.checked = false
	cbx_team.enabled = false
	st_teamemp.text = "결재(인)"
	// 조장결재 완료시 수정불가
	if This.getitemstring(1,"sanctionflag") <> 'Y' then
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true,  false,  True,  false,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
	else
		ls_signman = This.getitemstring(1,"sanctionemp")
		SELECT PENAMEK INTO :ls_empname
		FROM PBCOMMON.DAC003
		WHERE PEEMPNO = :ls_signman
		using sqlca;
		
		cbx_sanction.checked = true
		cbx_sanction.enabled = true
		st_sanctionemp.text = ls_empname
		if This.getitemstring(1,"partflag") <> 'Y' then
			// pass
		else
			ls_signman = This.getitemstring(1,"partemp")
			SELECT PENAMEK INTO :ls_empname
			FROM PBCOMMON.DAC003
			WHERE PEEMPNO = :ls_signman
			using sqlca;
			
			cbx_sanction.enabled = false
			cbx_part.checked = true
			cbx_part.enabled = true
			st_partemp.text = ls_empname
			if This.getitemstring(1,"teamflag") <> 'Y' then
				// pass
			else
				ls_signman = This.getitemstring(1,"teamemp")
				SELECT PENAMEK INTO :ls_empname
				FROM PBCOMMON.DAC003
				WHERE PEEMPNO = :ls_signman
				using sqlca;
				
				cbx_sanction.enabled = false
				cbx_part.enabled = false
				cbx_team.checked = true
				cbx_team.enabled = true
				st_teamemp.text = ls_empname
				cb_signok.visible = false
				cb_signok.enabled = false
				cb_signcancel.visible = false
				cb_signcancel.enabled = false
			end if
		end if
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true,  false,  false,  false,  i_b_print,      & 
			  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
	end if
end if
end event

type dw_tmm320u_04 from datawindow within w_tmm320u
integer x = 27
integer y = 1068
integer width = 3419
integer height = 372
integer taborder = 60
boolean bringtotop = true
string title = "기종별현황"
string dataobject = "d_tmm320u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_tmm320u
integer x = 297
integer y = 40
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "정밀측정조"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_tmm320u_05 from datawindow within w_tmm320u
integer x = 27
integer y = 1456
integer width = 3419
integer height = 380
integer taborder = 70
boolean bringtotop = true
string title = "장비별현황"
string dataobject = "d_tmm320u_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_signcancel from commandbutton within w_tmm320u
integer x = 2830
integer y = 60
integer width = 398
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재취소"
end type

event clicked;string ls_workdate, ls_tmgubun, ls_message, ls_nextdate, ls_sanctionflag
integer li_rtn

if dw_tmm320u_03.rowcount() < 1 then
	return 0
else
	ls_workdate = dw_tmm320u_03.getitemstring(1,"workdate")
	ls_tmgubun = dw_tmm320u_03.getitemstring(1,"tmgubun")
end if

// 익일 결재여부
ls_nextdate = f_relativedate(ls_workdate,1)
SELECT SanctionFlag INTO :ls_sanctionflag
FROM PBGMS.TMM007
WHERE WorkDate = :ls_nextdate AND Tmgubun = :ls_tmgubun
using sqlca;
if ls_sanctionflag = 'Y' then
	uo_status.st_message.text = "익일결재가 완료된 상태입니다."
	return 0
end if

sqlca.Autocommit = False

if Not cbx_sanction.checked then
	SELECT COUNT(*) INTO :li_rtn FROM PBGMS.TMM005
	WHERE Empno = :g_s_empno AND Tmgubun <> 'T' AND
		Signgubun = 'S'
	using sqlca;
	
	if li_rtn <> 1 then
		ls_message = "직장 결재자에 해당하지 않습니다."
		goto RollBack_
	end if
	// 직장 결재
	UPDATE PBGMS.TMM007
	SET SanctionFlag = '',
		SanctionEmp = '',
		PartFlag = '',
		PartEmp = '',
		TeamFlag = '',
		TeamEmp = '',
		Lastemp = :g_s_empno,
		LastDate = :g_s_datetime
	WHERE WorkDate = :ls_workdate AND Tmgubun = :ls_tmgubun
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "직장결재 에러"
		goto RollBack_
	end if	
elseif Not cbx_part.checked then
	SELECT COUNT(*) INTO :li_rtn FROM PBGMS.TMM005
	WHERE Empno = :g_s_empno AND Tmgubun <> 'T' AND
		Signgubun = 'P'
	using sqlca;
	
	if li_rtn <> 1 then
		ls_message = "P/L 결재자에 해당하지 않습니다."
		goto RollBack_
	end if
	// P/L 결재
	UPDATE PBGMS.TMM007
	SET SanctionFlag = '',
		SanctionEmp = '',
		PartFlag = '',
		PartEmp = '',
		TeamFlag = '',
		TeamEmp = '',
		Lastemp = :g_s_empno,
		LastDate = :g_s_datetime
	WHERE WorkDate = :ls_workdate AND Tmgubun = :ls_tmgubun
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "P/L 결재 에러"
		goto RollBack_
	end if
elseif Not cbx_team.checked then
	SELECT COUNT(*) INTO :li_rtn FROM PBGMS.TMM005
	WHERE Empno = :g_s_empno AND Tmgubun <> 'T' AND
		Signgubun = 'T'
	using sqlca;
	
	if li_rtn <> 1 then
		ls_message = "팀장 결재자에 해당하지 않습니다."
		goto RollBack_
	end if
	// 팀장 결재
	UPDATE PBGMS.TMM007
	SET SanctionFlag = '',
		SanctionEmp = '',
		PartFlag = '',
		PartEmp = '',
		TeamFlag = '',
		TeamEmp = '',
		Lastemp = :g_s_empno,
		LastDate = :g_s_datetime
	WHERE WorkDate = :ls_workdate AND Tmgubun = :ls_tmgubun
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "팀장결재 에러"
		goto RollBack_
	end if
else
	ls_message = "결재취소를 할수 없는 상태입니다."
	goto RollBack_
end if

Commit using sqlca;
sqlca.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 결재 취소처리되었습니다.'
return 0

RollBack_:
Rollback using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end event

type cb_signok from commandbutton within w_tmm320u
integer x = 2830
integer y = 60
integer width = 398
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재"
end type

event clicked;string ls_workdate, ls_tmgubun, ls_message
integer li_rtn

if dw_tmm320u_03.rowcount() < 1 then
	return 0
else
	ls_workdate = dw_tmm320u_03.getitemstring(1,"workdate")
	ls_tmgubun = dw_tmm320u_03.getitemstring(1,"tmgubun")
end if

sqlca.Autocommit = False

if Not cbx_sanction.checked then
	SELECT COUNT(*) INTO :li_rtn FROM PBGMS.TMM005
	WHERE Empno = :g_s_empno AND Tmgubun <> 'T' AND
		Signgubun = 'S'
	using sqlca;
	
	if li_rtn <> 1 then
		ls_message = "직장 결재자에 해당하지 않습니다."
		goto RollBack_
	end if
	// 직장 결재
	UPDATE PBGMS.TMM007
	SET SanctionFlag = 'Y',
		SanctionEmp = :g_s_empno,
		PartFlag = '',
		PartEmp = '',
		TeamFlag = '',
		TeamEmp = '',
		Lastemp = :g_s_empno,
		LastDate = :g_s_datetime
	WHERE WorkDate = :ls_workdate AND Tmgubun = :ls_tmgubun
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "직장결재 에러"
		goto RollBack_
	end if
	
	if wf_cal_summary(ls_tmgubun, ls_workdate, ls_message) = -1 then
		goto Rollback_
	end if
elseif Not cbx_part.checked then
	SELECT COUNT(*) INTO :li_rtn FROM PBGMS.TMM005
	WHERE Empno = :g_s_empno AND Signgubun = 'P'
	using sqlca;
	
	if li_rtn <> 1 then
		ls_message = "P/L 결재자에 해당하지 않습니다."
		goto RollBack_
	end if
	// P/L 결재
	UPDATE PBGMS.TMM007
	SET PartFlag = 'Y',
		PartEmp = :g_s_empno,
		TeamFlag = '',
		TeamEmp = '',
		Lastemp = :g_s_empno,
		LastDate = :g_s_datetime
	WHERE WorkDate = :ls_workdate AND Tmgubun = :ls_tmgubun
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "P/L 결재 에러"
		goto RollBack_
	end if
elseif Not cbx_team.checked then
	SELECT COUNT(*) INTO :li_rtn FROM PBGMS.TMM005
	WHERE Empno = :g_s_empno AND Signgubun = 'T'
	using sqlca;
	
	if li_rtn <> 1 then
		ls_message = "팀장 결재자에 해당하지 않습니다."
		goto RollBack_
	end if
	// 팀장 결재
	UPDATE PBGMS.TMM007
	SET TeamFlag = 'Y',
		TeamEmp = :g_s_empno,
		Lastemp = :g_s_empno,
		LastDate = :g_s_datetime
	WHERE WorkDate = :ls_workdate AND Tmgubun = :ls_tmgubun
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "팀장결재 에러"
		goto RollBack_
	end if
else
	ls_message = "결재가 완료된 상태입니다."
	goto RollBack_
end if

Commit using sqlca;
sqlca.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end event

type st_sanctionemp from statictext within w_tmm320u
integer x = 1595
integer y = 112
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
long textcolor = 255
long backcolor = 12632256
string text = "결재(인)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_partemp from statictext within w_tmm320u
integer x = 1975
integer y = 112
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
long textcolor = 255
long backcolor = 12632256
string text = "결재(인)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_teamemp from statictext within w_tmm320u
integer x = 2354
integer y = 112
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
long textcolor = 255
long backcolor = 12632256
string text = "결재(인)"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_sanction from checkbox within w_tmm320u
integer x = 1595
integer y = 36
integer width = 370
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 15780518
string text = "직장"
end type

event clicked;if this.checked then
	cb_signok.visible = true
	cb_signok.enabled = true
	cb_signcancel.visible = false
	cb_signcancel.enabled = false
else
	cb_signcancel.visible = true
	cb_signcancel.enabled = true
	cb_signok.visible = false
	cb_signok.enabled = false
end if
end event

type cbx_part from checkbox within w_tmm320u
integer x = 1975
integer y = 36
integer width = 370
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 15780518
string text = "P/L"
end type

event clicked;if this.checked then
	cb_signok.visible = true
	cb_signok.enabled = true
	cb_signcancel.visible = false
	cb_signcancel.enabled = false
else
	cb_signcancel.visible = true
	cb_signcancel.enabled = true
	cb_signok.visible = false
	cb_signok.enabled = false
end if
end event

type cbx_team from checkbox within w_tmm320u
integer x = 2354
integer y = 36
integer width = 370
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 15780518
string text = "팀장"
end type

event clicked;if this.checked then
	cb_signok.visible = true
	cb_signok.enabled = true
	cb_signcancel.visible = false
	cb_signcancel.enabled = false
else
	cb_signcancel.visible = true
	cb_signcancel.enabled = true
	cb_signok.visible = false
	cb_signok.enabled = false
end if
end event

type st_inform from statictext within w_tmm320u
integer x = 123
integer y = 120
integer width = 1271
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
long backcolor = 12632256
string text = "최종직장결재일은 땡땡입니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_tmm320u
integer x = 23
integer width = 1504
integer height = 192
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_tmm320u
integer x = 1536
integer width = 1765
integer height = 192
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

