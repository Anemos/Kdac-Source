$PBExportHeader$w_mpm310u.srw
$PBExportComments$작업실적관리
forward
global type w_mpm310u from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm310u
end type
type uo_2 from u_mpms_select_partno within w_mpm310u
end type
type dw_mpm310u_01 from u_vi_std_datawindow within w_mpm310u
end type
type dw_mpm310u_02 from datawindow within w_mpm310u
end type
type st_2 from statictext within w_mpm310u
end type
type st_3 from statictext within w_mpm310u
end type
type tab_1 from tab within w_mpm310u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_mpm310u_03 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_mpm310u_03 dw_mpm310u_03
end type
type tabpage_2 from userobject within tab_1
end type
type dw_mpm310u_04 from u_vi_std_datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_mpm310u_04 dw_mpm310u_04
end type
type tab_1 from tab within w_mpm310u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_4 from statictext within w_mpm310u
end type
type cb_order_end from commandbutton within w_mpm310u
end type
type gb_1 from groupbox within w_mpm310u
end type
end forward

global type w_mpm310u from w_ipis_sheet01
integer width = 3653
uo_1 uo_1
uo_2 uo_2
dw_mpm310u_01 dw_mpm310u_01
dw_mpm310u_02 dw_mpm310u_02
st_2 st_2
st_3 st_3
tab_1 tab_1
st_4 st_4
cb_order_end cb_order_end
gb_1 gb_1
end type
global w_mpm310u w_mpm310u

type variables

end variables

forward prototypes
public function string wf_get_srno ()
public function integer wf_save_chk ()
public function integer wf_delete_chk (integer ag_selrow)
end prototypes

public function string wf_get_srno ();String ls_custcd

DECLARE up_get_custcode PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'SER'  
	 using sqlmpms;

Execute up_get_custcode;

if sqlmpms.sqlcode = 0 then
	fetch up_get_custcode into :ls_custcd;
	close up_get_custcode;
end if

return ls_custcd
end function

public function integer wf_save_chk ();//----------------
// 해당공정별로 불량실적은 한번만 입력할 수 있습니다.
// 정상이면 return 0, 아니면 return -1
//----------------
integer li_cnt, li_rowcnt, li_chk, li_findrow
string  ls_resultflag, ls_orderno, ls_partno, ls_badoperno, ls_baddate

li_rowcnt = tab_1.tabpage_1.dw_mpm310u_03.rowcount()

li_chk = 0
for li_cnt = 1 to li_rowcnt
	ls_resultflag = tab_1.tabpage_1.dw_mpm310u_03.getitemstring( li_cnt, 'resultflag')
	if ls_resultflag = 'E' then
		ls_orderno = tab_1.tabpage_1.dw_mpm310u_03.getitemstring( li_cnt, 'orderno')
		ls_partno = tab_1.tabpage_1.dw_mpm310u_03.getitemstring( li_cnt, 'partno')
		ls_badoperno = tab_1.tabpage_1.dw_mpm310u_03.getitemstring( li_cnt, 'operno')
		ls_baddate = tab_1.tabpage_1.dw_mpm310u_03.getitemstring( li_cnt, 'workdate')
		if li_cnt <> li_rowcnt then
			li_findrow = tab_1.tabpage_1.dw_mpm310u_03.find("resultflag = 'E' and " &
				+ " workdate = '" + ls_baddate + "'", li_cnt + 1, li_rowcnt)
			if li_findrow > 0 then
				li_chk = li_chk + 1
			end if
		end if
	end if
next

if li_chk > 1 then
	MessageBox("알림", "불량원인공정은 작업일에 한번만 가능합니다.")
	return -1
else
	return 0
end if


end function

public function integer wf_delete_chk (integer ag_selrow);//-------------------
// 불량작업실적인 경우에 불량보고서가 작성된 경우에는 삭제할 수 없다.
// 작성되어 있으면 return -1, 없으면 return 0
//-------------------
string ls_resultflag, ls_badstype, ls_badsrno
integer li_count

ls_badstype = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(ag_selrow,'stype')
ls_badsrno  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(ag_selrow,'srno')
ls_resultflag = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(ag_selrow,'resultflag')

if ls_resultflag = 'E' then
	SELECT COUNT(*) INTO :li_count FROM TBADHEAD
	WHERE STYPE = :ls_badstype AND SRNO = :ls_badsrno 
	using sqlmpms;
	if sqlmpms.sqlcode <> 0 or li_count > 0 then
		MessageBox("확인", "불량발생내역이 존재하는 작업실적입니다.")
		return -1
	else
		return 0
	end if
end if
	return 0
return 0
end function

on w_mpm310u.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_mpm310u_01=create dw_mpm310u_01
this.dw_mpm310u_02=create dw_mpm310u_02
this.st_2=create st_2
this.st_3=create st_3
this.tab_1=create tab_1
this.st_4=create st_4
this.cb_order_end=create cb_order_end
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.dw_mpm310u_01
this.Control[iCurrent+4]=this.dw_mpm310u_02
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.cb_order_end
this.Control[iCurrent+10]=this.gb_1
end on

on w_mpm310u.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_mpm310u_01)
destroy(this.dw_mpm310u_02)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.tab_1)
destroy(this.st_4)
destroy(this.cb_order_end)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm310u_01.Width = newwidth / 5
dw_mpm310u_01.Height = newheight - (dw_mpm310u_01.y + ls_status)
st_2.x = dw_mpm310u_01.x

dw_mpm310u_02.x = dw_mpm310u_01.x + dw_mpm310u_01.Width + ls_split
dw_mpm310u_02.y = dw_mpm310u_01.y
dw_mpm310u_02.Width = newwidth - ( dw_mpm310u_02.x + ls_gap * 3)
dw_mpm310u_02.Height= newheight / 3 - dw_mpm310u_02.y
st_3.x = dw_mpm310u_02.x

tab_1.x = dw_mpm310u_02.x
tab_1.y = dw_mpm310u_02.y + dw_mpm310u_02.Height + ls_split
tab_1.Width = dw_mpm310u_02.Width
tab_1.Height= newheight - ( tab_1.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm310u_01.settransobject(sqlmpms)
dw_mpm310u_02.settransobject(sqlmpms)
tab_1.tabpage_1.dw_mpm310u_03.settransobject(sqlmpms)
tab_1.tabpage_2.dw_mpm310u_04.settransobject(sqlmpms)

dw_mpm310u_02.insertrow(0)

dw_mpm310u_01.GetChild('workstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm310u_01,'workstatus',ldwc,'codename',5)

dw_mpm310u_02.GetChild('workstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm310u_02,'workstatus',ldwc,'codename',5)

dw_mpm310u_02.GetChild('outflag', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM003')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm310u_02,'outflag',ldwc,'codename',5)

tab_1.tabpage_1.dw_mpm310u_03.GetChild('resultflag', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM008')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(tab_1.tabpage_1.dw_mpm310u_03,'resultflag',ldwc,'codename',5)

tab_1.tabpage_2.dw_mpm310u_04.GetChild('resultflag', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM008')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(tab_1.tabpage_2.dw_mpm310u_04,'resultflag',ldwc,'codename',5)
end event

event ue_insert;call super::ue_insert;integer li_selrow, li_currow, li_cnt
string ls_orderno, ls_partno, ls_operno, ls_wccode, ls_status, ls_preoperno, ls_outflag
dec{0} ld_planqty, ld_stdheatcost

li_selrow = dw_mpm310u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '공정순서를 선택해 주십시요'
	return 0
end if
ls_status = dw_mpm310u_01.getitemstring(li_selrow,'workstatus')
ls_outflag = dw_mpm310u_01.getitemstring(li_selrow,'outflag')
if ls_status < '4' then
	MessageBox("알림","공정작업요청이 이루어지지 않았습니다.")
	return 0
end if
if ls_status = 'C' then
	MessageBox("알림","작업진행이 작업완료상태입니다.")
	return 0
end if
//***주석처리 2009.05.04일 외주가공공정 입력가능으로 수정
//if ls_outflag = 'P' then
//	MessageBox("알림","해당공순은 외주작업에 해당합니다.")
//	return 0
//end if
ls_orderno = dw_mpm310u_01.getitemstring(li_selrow,'orderno')
ls_status = f_mpms_get_orderstatus(ls_orderno)
if ls_status <> '4' then
	MessageBox("알림","해당 ORDER NO에 대한 진행상태가 공정작업상태가 아닙니다.")
	return 0
end if

ls_partno = dw_mpm310u_01.getitemstring(li_selrow,'partno')
ls_operno = dw_mpm310u_01.getitemstring(li_selrow,'operno')
ls_wccode = dw_mpm310u_01.getitemstring(li_selrow,'wccode')
ld_planqty = dw_mpm310u_02.getitemdecimal( 1, 'planqty')

// 전공정 실적입력 확인 - 당분가 체크보류 2007.06.28
//SELECT TOP 1 OPERNO, OUTFLAG  INTO :ls_preoperno, :ls_outflag 
//	FROM TROUTING  
//   WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
//			OPERNO < :ls_operno
//ORDER BY OPERNO DESC
//using sqlmpms;
//
//if f_spacechk(ls_preoperno) <> -1  and ls_outflag <> 'P' then
//	SELECT COUNT(*) INTO :li_cnt 
//	FROM TWORKJOB
//	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
//			OPERNO = :ls_preoperno
//	using sqlmpms;
//	if li_cnt < 1 then
//		MessageBox("경고", ls_preoperno + " 공순에 작업실적을 입력하지 않았습니다.")
//		return 0
//	end if
//end if

//workstatus변경
UPDATE TROUTING
SET WORKSTATUS = 'P', LASTEMP = :g_s_empno, LASTDATE = GETDATE()
WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
		OPERNO = :ls_operno 
using sqlmpms;

//예상 열처리비
ld_stdheatcost = 0
if ls_wccode = 'THT' then
	SELECT STDHEATCOST  INTO :ld_stdheatcost  
	FROM TROUTING  
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
			OPERNO  = :ls_operno
	ORDER BY OPERNO DESC
	using sqlmpms;
end if

tab_1.selecttab(1)
li_currow = tab_1.tabpage_1.dw_mpm310u_03.insertrow(0)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'stype','WC')
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'srno',wf_get_srno())
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'orderno',ls_orderno)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'partno',ls_partno)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'wccode',ls_wccode)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'operno',ls_operno)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'heatcost',ld_stdheatcost)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'finalqty',ld_planqty)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'resultflag','A')
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'lastemp',g_s_empno)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'workdate', g_s_date)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'chk', 0)
tab_1.tabpage_1.dw_mpm310u_03.setitem(li_currow,'processratio', 0)

tab_1.tabpage_1.dw_mpm310u_03.setrow(li_currow)
tab_1.tabpage_1.dw_mpm310u_03.setcolumn('workdate')
tab_1.tabpage_1.dw_mpm310u_03.setfocus()
end event

event ue_save;call super::ue_save;integer li_selrow, li_rowcnt, li_cnt, li_rtncnt, li_processratio
dec{0}  lc_finalqty, lc_planqty
string ls_operno, ls_message, ls_stype, ls_srno, ls_lastoperno, ls_orderno, ls_partno
string ls_wccode, ls_workman
str_mpms_parm lstr_1

dw_mpm310u_01.Accepttext()
tab_1.tabpage_1.dw_mpm310u_03.Accepttext()
li_selrow = dw_mpm310u_01.getselectedrow(0)
li_rowcnt = tab_1.tabpage_1.dw_mpm310u_03.rowcount()

if li_selrow < 1 then
	uo_status.st_message.text = "공정순서가 선택되지 않았습니다."
	return 0
end if

if dw_mpm310u_01.getitemstring(li_selrow,'workstatus') = 'C' then
	uo_status.st_message.text = '작업완료된 공순으로 저장할 수 없습니다.'
	return 0
end if

ls_orderno = dw_mpm310u_01.getitemstring(li_selrow, 'orderno')
ls_partno  = dw_mpm310u_01.getitemstring(li_selrow, 'partno')
if tab_1.tabpage_1.dw_mpm310u_03.modifiedcount() < 1 and tab_1.tabpage_1.dw_mpm310u_03.deletedcount() < 1 then
	uo_status.st_message.text = '변경된 데이타가 없습니다.'
	return 0
end if

if f_mpms_mandantory_chk(tab_1.tabpage_1.dw_mpm310u_03) = -1 then
	uo_status.st_message.text = '누락된 데이타가 있습니다.'
	return 0
end if
lc_finalqty = 0
li_processratio = 0
lc_planqty = dw_mpm310u_02.getitemnumber(1,'planqty')
for li_cnt = 1 to li_rowcnt
	if tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'resultflag') = 'E' then
		ls_message = 'B'
		ls_stype = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'stype')
		ls_srno  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'srno')
		SELECT BadOperNo INTO :ls_lastoperno
			FROM TBADHEAD
			WHERE STYPE = :ls_stype AND SRNO = :ls_srno
		using sqlmpms;
		if f_spacechk(ls_lastoperno) = -1 then
			lstr_1.s_parm[3] = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'orderno')
			lstr_1.s_parm[4] = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'partno')
			lstr_1.s_parm[5] = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'operno')
			lstr_1.s_parm[6] = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'workdate')
			lstr_1.s_parm[7] = ls_stype
			lstr_1.s_parm[8] = ls_srno
			lstr_1.i_parm[1] = tab_1.tabpage_1.dw_mpm310u_03.getitemnumber(li_cnt,'scrapqty')
			ls_wccode = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'wccode')
			ls_workman = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_cnt,'workemp')
			
			INSERT INTO TBADHEAD(Stype, Srno, OrderNo, PartNo, BadOperNo, 
				BadDate, WcCode, WorkMan, FindMan, PlanQty, ScrapQty, BadReason, 
				ResultFlag, LastEmp)
			VALUES(:ls_stype, :ls_srno, :lstr_1.s_parm[3], :lstr_1.s_parm[4], 
				:lstr_1.s_parm[5], :lstr_1.s_parm[6], :ls_wccode, :ls_workman, 
				'', :lc_planqty, :lstr_1.i_parm[1], '', 
				'N', :g_s_empno) using sqlmpms;
			
		else
			SELECT COUNT(*) INTO :li_rtncnt
				FROM TBADDETAIL
				WHERE STYPE = :ls_stype AND SRNO = :ls_srno
				using sqlmpms;
			if li_rtncnt < 1 then
				Messagebox("알림","작업불량관리에 재작업공정이 없습니다.")
				return 0
			end if
			// 불량내역 조회 및 처리
			li_cnt = f_mpms_workstatus_chk(ls_orderno, ls_partno, ls_lastoperno)
			if li_cnt = -1 then
				return 0
			end if
		end if
	end if
	li_processratio = li_processratio + tab_1.tabpage_1.dw_mpm310u_03.getitemnumber(li_cnt,'processratio')
	lc_finalqty = lc_finalqty + tab_1.tabpage_1.dw_mpm310u_03.getitemnumber(li_cnt,'finalqty')
next

//if ls_message = 'B' then
//	window lw_win
//	
//	lstr_1.s_parm[1] = '5'
//	lstr_1.s_parm[2] = '[금형공정관리]-[불량실적등록]'
//	OpenSheetwithparm(lw_win,lstr_1,'w_mpm320u',iw_this,0,Layered!)
//	return 0
//end if
// 처리 END

if lc_planqty < lc_finalqty then
	Messagebox("알림","합격수량은 지시수량과 같거나 적어야 합니다.")
	return 0
end if

if li_processratio < 100 then
	tab_1.tabpage_1.dw_mpm310u_03.setitem(li_rowcnt,'processratio',(100 - li_processratio))
elseif li_processratio > 100 then
	tab_1.tabpage_1.dw_mpm310u_03.setitem(li_rowcnt,'processratio',(li_processratio - 100))
end if

if wf_save_chk() = -1 then
	return 0
end if

ls_operno = dw_mpm310u_01.getitemstring(li_selrow,'operno')
sqlmpms.Autocommit = False

if dw_mpm310u_01.modifiedcount() > 0 then
	if dw_mpm310u_01.update() <> 1 then
		ls_message = '310u_01'
		goto RollBack_
	end if
end if
if tab_1.tabpage_1.dw_mpm310u_03.update() = 1 then
	//최종작업공정확인
	SELECT COUNT(*) INTO :li_rtncnt
	FROM TWORKJOB
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
			OPERNO = :ls_operno
	using sqlmpms;
	
	if li_rtncnt > 0 and ls_message <> 'B' then
		UPDATE TROUTING
		SET WORKSTATUS = 'C', LASTEMP = :g_s_empno, LASTDATE = GETDATE()
		WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
				OPERNO = :ls_operno
		using sqlmpms;
	else
		UPDATE TROUTING
		SET WORKSTATUS = 'P', LASTEMP = :g_s_empno, LASTDATE = GETDATE()
		WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
				OPERNO = :ls_operno
		using sqlmpms;
	end if
	
	if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
		ls_message = '공정작업상태변경시 에러'
		goto RollBack_
	end if
	//끝
	Commit using sqlmpms;
	sqlmpms.Autocommit = True
	uo_status.st_message.text = '정상적으로 처리되었습니다.'
	
	iw_this.triggerevent('ue_retrieve')
//	li_selrow = dw_mpm310u_01.find("operno = '" + ls_operno + "'", 1, dw_mpm310u_01.rowcount())
//	if li_selrow > 0 then
//		dw_mpm310u_01.Post Event RowFocusChanged(li_selrow)
//		dw_mpm310u_01.scrolltorow(li_selrow)
//		dw_mpm310u_01.setrow(li_selrow)
//	end if
	
	return 0
else
	ls_message = '310u_03'
end if

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다.' + ls_message

return 0
end event

event ue_delete;call super::ue_delete;integer li_selrow, li_rtn
string ls_orderno, ls_partno, ls_operno, ls_workemp, ls_mchno, ls_workdate
string ls_stype, ls_srno

li_selrow = dw_mpm310u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

li_selrow = tab_1.tabpage_1.dw_mpm310u_03.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

if wf_delete_chk(li_selrow) = -1 then
	return 0
end if

tab_1.tabpage_1.dw_mpm310u_03.DeleteRow(li_selrow)

// 해당 PartNo에 대해서 작업실적이 하나도 없으면 상태를 진행으로 박음
//if tab_1.tabpage_1.dw_mpm310u_03.rowcount() < 1 then
//	dw_mpm310u_01.setitem(li_selrow,'workstatus','P')
//end if
//ls_orderno = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'orderno')
//ls_partno  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'partno')
//ls_operno  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'operno')
//ls_workemp  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'workemp')
//ls_mchno  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'mchno')
//ls_workdate  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'workdate')
//ls_stype = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'stype')
//ls_srno  = tab_1.tabpage_1.dw_mpm310u_03.getitemstring(li_selrow,'srno')
//
//li_rtn = MessageBox("확인", ls_operno + "공정의 " + ls_workemp + " : " &
//		+ string(ls_workdate,'@@@@.@@.@@') + " 일자의 작업실적을 삭제하시겠습니까?" &
//		, Exclamation!, OKCancel!, 2)
//if li_rtn = 2 then
//	return 0
//end if
//
//sqlmpms.Autocommit = False
//
//DELETE FROM TWORKJOB
//WHERE STYPE = :ls_stype AND SRNO = :ls_srno 
//		using sqlmpms;
//		
//if sqlmpms.sqlcode = 0 then
//	Commit using sqlmpms;
//	sqlmpms.Autocommit = True
//
//	li_selrow = dw_mpm310u_01.find("operno = '" + ls_operno + "'", 1, dw_mpm310u_01.rowcount())
//	if li_selrow > 0 then
//		dw_mpm310u_01.Post Event RowFocusChanged(li_selrow)
//		dw_mpm310u_01.scrolltorow(li_selrow)
//		dw_mpm310u_01.setrow(li_selrow)
//	end if
//	uo_status.st_message.text = '정상적으로 처리되었습니다.'
//else
//	RollBack using sqlmpms;
//	sqlmpms.Autocommit = True
//	uo_status.st_message.text = '삭제시에 에러가 발생하였습니다.'
//end if
end event

event ue_retrieve;call super::ue_retrieve;string ls_status, ls_orderno, ls_enddate
integer li_rowcnt, li_findrow

ls_orderno = uo_1.is_uo_orderno
ls_status = f_mpms_get_orderstatus(ls_orderno)

if ls_status = 'C' then
	SELECT CONVERT(CHAR(6),ENDDATE,112) INTO :ls_enddate
	FROM TORDER
	WHERE ORDERNO = :ls_orderno
	using sqlmpms;
	
	if mid(g_s_date,1,6) <> ls_enddate then
		uo_status.st_message.text = "마감확정된 Order No 입니다."
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true,  false,  false,  false,  i_b_print, & 
					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
	end if
end if

dw_mpm310u_01.reset()

li_rowcnt = dw_mpm310u_01.retrieve( uo_1.is_uo_orderno, uo_2.is_uo_partno )
if li_rowcnt > 0 then
	li_findrow = dw_mpm310u_01.find("workstatus <> 'C'", 1, li_rowcnt)
	if li_findrow > 0 then
		dw_mpm310u_01.setrow(li_findrow)
		dw_mpm310u_01.selectrow(li_findrow,True)
	end if
end if
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm310u
end type

type uo_1 from u_mpms_select_orderno within w_mpm310u
integer x = 55
integer y = 48
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;
f_mpms_retrieve_dddw_partno(uo_2.dw_1, &
										uo_1.is_uo_orderno, &
										'%', &
										False, &
										uo_2.is_uo_partno, &
										uo_2.is_uo_partname )
										
uo_2.Triggerevent('ue_select')
										
end event

event ue_post_constructor;call super::ue_post_constructor;
f_mpms_retrieve_dddw_partno(uo_2.dw_1, &
										uo_1.is_uo_orderno, &
										'%', &
										False, &
										uo_2.is_uo_partno, &
										uo_2.is_uo_partname )
end event

type uo_2 from u_mpms_select_partno within w_mpm310u
integer x = 1275
integer y = 68
integer height = 84
boolean bringtotop = true
end type

on uo_2.destroy
call u_mpms_select_partno::destroy
end on

event ue_select;call super::ue_select;
iw_this.Triggerevent('ue_retrieve')

end event

type dw_mpm310u_01 from u_vi_std_datawindow within w_mpm310u
integer x = 27
integer y = 288
integer width = 1390
integer height = 1572
integer taborder = 20
boolean bringtotop = true
string title = "공정순서"
string dataobject = "d_mpm310u_01"
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_operno, ls_wccode
integer li_count
datawindowchild ldwc

if currentrow < 1 then
	return -1
end if

dw_mpm310u_02.reset()
tab_1.tabpage_1.dw_mpm310u_03.reset()
tab_1.tabpage_2.dw_mpm310u_04.reset()

ls_operno = This.getitemstring( currentrow, "operno" )
ls_wccode = This.getitemstring( currentrow, "wccode" )

tab_1.tabpage_1.dw_mpm310u_03.GetChild('mchno', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve(ls_wccode)

//f_pisc_set_dddw_width(tab_1.tabpage_1.dw_mpm310u_03,'mchno',ldwc,'mchname',0)

dw_mpm310u_02.retrieve( uo_1.is_uo_orderno, uo_2.is_uo_partno, ls_operno )
tab_1.tabpage_1.dw_mpm310u_03.retrieve( uo_1.is_uo_orderno, uo_2.is_uo_partno, ls_operno )
li_count = tab_1.tabpage_2.dw_mpm310u_04.retrieve( uo_1.is_uo_orderno, uo_2.is_uo_partno, ls_operno )
if li_count < 1 then
	tab_1.tabpage_2.enabled = false
else
	tab_1.tabpage_2.enabled = true
end if
this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
return 0
end event

event itemchanged;call super::itemchanged;string ls_orderno, ls_partno, ls_operno, ls_rtn

//if dwo.name = 'workstatus' then
//	ls_rtn = 'ERR'
//	if data = 'C' then
//		ls_orderno = This.getitemstring( row, 'orderno')
//		ls_partno = This.getitemstring( row, 'partno')
//		ls_operno = This.getitemstring( row, 'operno')
//		
//		DECLARE up_workstatus_chk PROCEDURE FOR sp_mpms_workstatus_chk  
//         @ps_orderno = :ls_orderno,   
//         @ps_partno = :ls_partno,   
//         @ps_operno = :ls_operno,   
//         @ps_rtn = :ls_rtn  OUTPUT
//			using sqlmpms;
//			
//		Execute up_workstatus_chk;
//
//		if SQLMPMS.sqlcode = 0 then
//			FETCH up_workstatus_chk INTO :ls_rtn;
//			CLOSE up_workstatus_chk;
//		end if
//		if ls_rtn <> 'OK' then
//			choose case ls_rtn
//				case 'ERR01'
//					Messagebox("경고", "불량에 대한 재작업실적이 미등록된 상태입니다.")
//					This.Setitem( row, 'workstatus', 'P')
//					return 1
//			end choose
//		end if
//	end if
//	This.Setitem( row, 'lastemp', g_s_empno )
//	This.Setitem( row, 'lastdate', f_mpms_get_nowtime() )
//end if

return 0
end event

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_mpms NewMenu
string ls_name, ls_data, ls_type, ls_col_type, ls_workstatus, ls_ingstatus
string ls_orderno
str_mpms_parm lstr_1

ls_type = dwo.type
If ls_type = 'column' Then
	ls_name = dwo.name
	ls_col_type = this.Describe(ls_name+".ColType")
	If pos(ls_col_type,'char',1) > 0 Then
		ls_data = dwo.Primary[row]
	Else
		ls_data = ''
	End if
End if

If row > 0 Then
	this.SelectRow(0,False)
	this.SelectRow(row, True)
	this.setfocus()
Else
	return 0
End if

ls_orderno = This.getitemstring(row,'orderno')
ls_ingstatus = f_mpms_get_orderstatus(ls_orderno)
if ls_ingstatus = 'C' then
	return 0
end if

lstr_1.w_parm = iw_this
lstr_1.dw_parm[1] = This
lstr_1.s_parm[1] = ls_orderno
lstr_1.s_parm[2] = This.getitemstring(row,'partno')
lstr_1.s_parm[3] = This.getitemstring(row,'operno')
ls_workstatus = This.getitemstring(row,'workstatus')
Message.PowerObjectParm = lstr_1

NewMenu = CREATE m_pop_mpms
//NewMenu.mf_get_dw(this, row, ls_name, ls_data)
//Popup Menu 조정

NewMenu.m_action.m_copy.enabled = False
NewMenu.m_action.m_matadd.enabled = False
NewMenu.m_action.m_subadd.enabled = False
NewMenu.m_action.m_modify.enabled = False
NewMenu.m_action.m_wccode.enabled = True
NewMenu.m_action.m_outcal.enabled = False
if ls_workstatus = 'C' then
	NewMenu.m_action.m_workstatus.enabled = True
else
	NewMenu.m_action.m_workstatus.enabled = False
end if

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

type dw_mpm310u_02 from datawindow within w_mpm310u
integer x = 1454
integer y = 288
integer width = 2121
integer height = 472
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm310u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mpm310u
integer x = 27
integer y = 200
integer width = 480
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "공정순서"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mpm310u
integer x = 1499
integer y = 200
integer width = 480
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "작업지시사항"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type tab_1 from tab within w_mpm310u
event resize pbm_size
integer x = 1454
integer y = 800
integer width = 2121
integer height = 1060
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event resize;tabpage_1.dw_mpm310u_03.Width = newwidth - ( tabpage_1.dw_mpm310u_03.x + 40 )
tabpage_1.dw_mpm310u_03.Height = newheight - ( tabpage_1.dw_mpm310u_03.y + 120 ) 

tabpage_2.dw_mpm310u_04.Width = newwidth - ( tabpage_2.dw_mpm310u_04.x + 40 ) 
tabpage_2.dw_mpm310u_04.Height = newheight - ( tabpage_2.dw_mpm310u_04.y + 120 ) 
end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2085
integer height = 944
long backcolor = 12632256
string text = "작업실적"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_mpm310u_03 dw_mpm310u_03
end type

on tabpage_1.create
this.dw_mpm310u_03=create dw_mpm310u_03
this.Control[]={this.dw_mpm310u_03}
end on

on tabpage_1.destroy
destroy(this.dw_mpm310u_03)
end on

type dw_mpm310u_03 from datawindow within tabpage_1
event ue_key pbm_dwnkey
integer y = 12
integer width = 2071
integer height = 920
integer taborder = 20
string title = "none"
string dataobject = "d_mpm310u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;If key = keyenter! Then
	iw_this.Triggerevent("ue_insert")
End If

return 0
end event

event itemchanged;String 	ls_colName, ls_null, ls_chkdate, ls_stype, ls_srno, ls_result
String   ls_orderno, ls_partno, ls_operno, ls_wccode, ls_empname
dec{0}   lc_qty
integer  li_count

this.AcceptText ( )
uo_status.st_message.text = ''
SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'resultflag'
		if data = 'E' then
			ls_orderno = This.getitemstring(row,'orderno')
			ls_partno = This.getitemstring(row,'partno')
			ls_operno = This.getitemstring(row,'operno')
			ls_chkdate = This.getitemstring(row,'workdate')
	
			SELECT COUNT(*) INTO :li_count FROM TBADHEAD
			WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
					BADOPERNO = :ls_operno AND BADDATE = :ls_chkdate
			using sqlmpms;
			if li_count > 0 then
				MessageBox("확인", "해당작업일에 작업지시근거에 대한 불량발생내역이 존재합니다.")
				This.setitem( row, 'workdate', ls_chkdate)
				return 1
			end if
		end if
	Case 'workdate'
		if f_dateedit(data) = space(8) then
			Messagebox("확인","날짜형식이 올바르지 않습니다.")
			This.Setitem( row, 'workdate', '')
			return 1
		end if
		ls_result = f_mpms_get_monthjob(mid(data,1,6))
		if ls_result = 'C' then
			Messagebox("확인","재료비 계산이 확정된 년월입니다.")
			This.Setitem( row, 'workdate', g_s_date)
			return 1
		end if
	Case 'mchno'
		ls_wccode = This.getitemstring(row, 'wccode')
		SELECT COUNT(*) INTO :li_count FROM TMACHINE
		WHERE MCHNO = :data AND WCCODE = :ls_wccode
		using sqlmpms;
		if li_count < 1 then
			MessageBox("확인", ls_wccode + " WC에 해당하는 장비가 아닙니다.")
			This.setitem( row, 'mchno', ls_null )
			return 1
		end if
	Case 'workemp'
		SELECT EMPNAME INTO :ls_empname
		FROM TMOLDEMPNO
		WHERE EMPNO = :data
		using sqlmpms;
		if f_spacechk(ls_empname) = -1 then
			MessageBox("확인", data + " 사번에 해당하는 정보가 없습니다..")
			This.setitem( row, 'workemp', ls_null )
			return 1
		else
			This.setitem( row, 'empname', ls_empname )
		end if
End Choose
end event

event rowfocuschanged;integer li_chk

if currentrow < 1 then
	return 0
end if

li_chk = This.getitemnumber( currentrow, 'chk' )

if li_chk = 1 then
	this.SelectRow(0,FALSE)
	//this.SelectRow(currentrow,FALSE)
else
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
end if
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2085
integer height = 944
long backcolor = 12632256
string text = "재작업실적정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_mpm310u_04 dw_mpm310u_04
end type

on tabpage_2.create
this.dw_mpm310u_04=create dw_mpm310u_04
this.Control[]={this.dw_mpm310u_04}
end on

on tabpage_2.destroy
destroy(this.dw_mpm310u_04)
end on

type dw_mpm310u_04 from u_vi_std_datawindow within tabpage_2
integer y = 12
integer width = 2080
integer height = 928
integer taborder = 11
string dataobject = "d_mpm310u_04"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;string ls_null, ls_colname

this.AcceptText ( )
uo_status.st_message.text = ''
SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'baddate'
		if f_dateedit(data) = space(8) then
			Messagebox("확인","날짜형식이 올바르지 않습니다.")
			This.Setitem( row, 'baddate', '')
			return 1
		end if
	Case 'workdate'
		if f_dateedit(data) = space(8) then
			Messagebox("확인","날짜형식이 올바르지 않습니다.")
			This.Setitem( row, 'workdate', '')
			return 1
		end if
End Choose
end event

type st_4 from statictext within w_mpm310u
integer x = 2281
integer y = 32
integer width = 1225
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
string text = "공정명변경 및 삭제는 오른쪽마우스 버튼사용"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_order_end from commandbutton within w_mpm310u
integer x = 2615
integer y = 92
integer width = 489
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "ORDER 완료"
end type

event clicked;//******************
//* Order작업을 강제적으로 종료시킬 필요가 있을경우에 사용한다.
//******************
integer li_cnt, li_rowcnt
string ls_orderno, ls_status, ls_enddate, ls_message, ls_close_date
string ls_srno, ls_partno, ls_operno, ls_wccode, ls_mchno
datastore lds_01

ls_orderno = uo_1.is_uo_orderno
ls_status = f_mpms_get_orderstatus(ls_orderno)

if ls_status = 'C' then
	uo_status.st_message.text = "마감확정된 Order No 입니다."
	return 0
end if

// 마감일자 가져오기
SELECT TOP 1 convert(varchar(10),dateadd(dd,-1,dateadd(mm,1,cast(YEARMM + '01' as datetime))),112)
	INTO :ls_close_date
FROM TMONTHJOB
WHERE RESULTFLAG = 'G'
ORDER BY YEARMM
using sqlmpms;

li_cnt = MessageBox("확인", "OrderNo :" + ls_orderno + "를 " + ls_close_date + " 일 날짜로 ~r" &
		+ "강제작업완료합니다. 처리하시겠습니까?", Exclamation!, OKCancel!, 2)

if li_cnt = 2 then
	return 0
end if

lds_01 = create datastore
lds_01.dataobject = "d_mpm310u_order_end"
lds_01.settransobject(sqlmpms)

li_rowcnt = lds_01.retrieve(ls_orderno)

if li_rowcnt < 1 then
	uo_status.st_message.text = "진행중인 공순이 존재하지 않습니다."
	return 0
end if

sqlmpms.Autocommit = False

//*** 작업실적 강제 생성.
for li_cnt = 1 to li_rowcnt
	ls_srno = wf_get_srno()
	ls_partno = lds_01.getitemstring(li_cnt,"partno")
	ls_operno = lds_01.getitemstring(li_cnt,"operno")
	ls_wccode = lds_01.getitemstring(li_cnt,"wccode")
	ls_mchno = lds_01.getitemstring(li_cnt,"mchno")
	
	INSERT INTO MPMS.dbo.TWORKJOB(Stype, Srno, OrderNo, PartNo, OperNo, 
		WcCode, WorkDate, WorkEmp, MchNo, HeatCost, OutCost, ScrapQty, FinalQty, 
		JobTime, MchTime1, MchTime2, MchTime3, ResultFlag, JobMemo, BadStype, 
		BadSrno, ProcessRatio, LastEmp, LastDate)
	VALUES('WC', :ls_srno, :ls_orderno, :ls_partno, :ls_operno,
		:ls_wccode, :ls_close_date, 'SYSTEM', :ls_mchno, 0, 0, 0, 0,
		0, 0, 0, 0, 'A', '강제공순완료처리건', null,
		null, 100, :g_s_empno, getdate() )
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "강제 작업실적등록시에 에러가 발생하였습니다."
		goto RollBack_
	end if
	
	UPDATE TROUTING
	SET WorkStatus = 'C'
	WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
		OperNo = :ls_operno
	using sqlmpms;
	
	if sqlmpms.sqlnrows < 1 then
		ls_message = "공정상태 작업완료처리시에 에러가 발생하였습니다."
		goto RollBack_
	end if
next

Commit using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = "정상적으로 처리되었습니다."
	
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = "저장중에 에러가 발생하였습니다. 내용 : " + ls_message

return 0
end event

type gb_1 from groupbox within w_mpm310u
integer x = 32
integer width = 2235
integer height = 172
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

