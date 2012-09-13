$PBExportHeader$w_bpm401b.srw
$PBExportComments$사업계획진행현황(관리)
forward
global type w_bpm401b from w_ipis_sheet01
end type
type dw_bpm401b_01 from u_vi_std_datawindow within w_bpm401b
end type
type uo_year from uo_ccyy_mps within w_bpm401b
end type
type st_1 from statictext within w_bpm401b
end type
type cb_begin from commandbutton within w_bpm401b
end type
type cb_end from commandbutton within w_bpm401b
end type
type cb_cancel from commandbutton within w_bpm401b
end type
type uo_2 from u_bpm_select_arev within w_bpm401b
end type
type cb_month from commandbutton within w_bpm401b
end type
type st_2 from statictext within w_bpm401b
end type
type cb_bomcopy from commandbutton within w_bpm401b
end type
type sle_target from singlelineedit within w_bpm401b
end type
type st_3 from statictext within w_bpm401b
end type
type gb_1 from groupbox within w_bpm401b
end type
end forward

global type w_bpm401b from w_ipis_sheet01
integer width = 4384
integer height = 2516
dw_bpm401b_01 dw_bpm401b_01
uo_year uo_year
st_1 st_1
cb_begin cb_begin
cb_end cb_end
cb_cancel cb_cancel
uo_2 uo_2
cb_month cb_month
st_2 st_2
cb_bomcopy cb_bomcopy
sle_target sle_target
st_3 st_3
gb_1 gb_1
end type
global w_bpm401b w_bpm401b

on w_bpm401b.create
int iCurrent
call super::create
this.dw_bpm401b_01=create dw_bpm401b_01
this.uo_year=create uo_year
this.st_1=create st_1
this.cb_begin=create cb_begin
this.cb_end=create cb_end
this.cb_cancel=create cb_cancel
this.uo_2=create uo_2
this.cb_month=create cb_month
this.st_2=create st_2
this.cb_bomcopy=create cb_bomcopy
this.sle_target=create sle_target
this.st_3=create st_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bpm401b_01
this.Control[iCurrent+2]=this.uo_year
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_begin
this.Control[iCurrent+5]=this.cb_end
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.cb_month
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cb_bomcopy
this.Control[iCurrent+11]=this.sle_target
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.gb_1
end on

on w_bpm401b.destroy
call super::destroy
destroy(this.dw_bpm401b_01)
destroy(this.uo_year)
destroy(this.st_1)
destroy(this.cb_begin)
destroy(this.cb_end)
destroy(this.cb_cancel)
destroy(this.uo_2)
destroy(this.cb_month)
destroy(this.st_2)
destroy(this.cb_bomcopy)
destroy(this.sle_target)
destroy(this.st_3)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_bpm401b_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bpm401b_01.Height= newheight - ( dw_bpm401b_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;string ls_refyear, ls_deptcode, ls_revno, ls_message

dw_bpm401b_01.settransobject(sqlca)
ls_message = Right(Message.StringParm,6)
ls_refyear = mid(ls_message,3,4)
ls_revno = mid(ls_message,1,2)

if f_spacechk(ls_refyear) = -1 then
	uo_year.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
else
	uo_year.uf_reset(integer(ls_refyear))
end if

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										ls_revno, &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')

SELECT DEPTCODE INTO :ls_deptcode
FROM PBBPM.BPM519
WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND 
		REVNO = :ls_revno AND Windowid = 'w_bpm401b'
using sqlca;

if g_s_deptcd = ls_deptcode then
	cb_begin.enabled = True
	cb_end.enabled = True
	cb_cancel.enabled = True
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	i_b_retrieve 	= True
	i_b_insert 	 	= True
	i_b_save 		= True
	i_b_delete 		= True
	i_b_print 		= False
	i_b_dretrieve 	= False
	i_b_dprint 		= False
	i_b_dchar 		= False
else
	cb_begin.enabled = False
	cb_end.enabled = False
	cb_cancel.enabled = False
	i_b_retrieve 	= True
	i_b_insert 	 	= False
	i_b_save 		= False
	i_b_delete 		= False
	i_b_print 		= False
	i_b_dretrieve 	= False
	i_b_dprint 		= False
	i_b_dchar 		= False
end if
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)

This.triggerevent('ue_retrieve')
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_revno

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

dw_bpm401b_01.reset()
dw_bpm401b_01.retrieve(ls_year,ls_revno)
end event

event ue_save;call super::ue_save;string ls_message, ls_year, ls_revno

dw_bpm401b_01.accepttext()

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

sqlca.AutoCommit = False

if dw_bpm401b_01.modifiedcount() > 0 or dw_bpm401b_01.deletedcount() > 0 then
	if dw_bpm401b_01.update() = 1 then
		ls_message = '저장되었습니다.'
	else
		ls_message = '저장중에 에러가 발생하였습니다.'
		goto RollBack_
	end if
end if

Commit using sqlca;
sqlca.AutoCommit = True
uo_status.st_message.text = ls_message
f_bpm_job_end(ls_year,ls_revno,'w_bpm401b',g_s_empno,'C','사업계획진행관리 입력,수정,삭제 작업 :' + ls_revno)
This.Triggerevent("ue_retrieve")
return 0

RollBack_:
RollBack using sqlca;
sqlca.AutoCommit = True
uo_status.st_message.text = ls_message
return -1
end event

event ue_insert;call super::ue_insert;long ll_currow
string ls_year, ls_ingflag, ls_revno

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

SELECT IFNULL(INGFLAG,'G') INTO :ls_ingflag 
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND XYEAR = :ls_year
FETCH FIRST 1 ROW ONLY
using sqlca;

ll_currow = dw_bpm401b_01.insertrow(0)

dw_bpm401b_01.setitem(ll_currow,"comltd",'01')
dw_bpm401b_01.setitem(ll_currow,"xyear",ls_year)
dw_bpm401b_01.setitem(ll_currow,"revno",ls_revno)
dw_bpm401b_01.setitem(ll_currow,"seqno",'000')
dw_bpm401b_01.setitem(ll_currow,"taskname",'')
dw_bpm401b_01.setitem(ll_currow,"taskstatus",'P')
dw_bpm401b_01.setitem(ll_currow,"jobstart",'')
dw_bpm401b_01.setitem(ll_currow,"jobend",'')
dw_bpm401b_01.setitem(ll_currow,"windowid",'')
dw_bpm401b_01.setitem(ll_currow,"taskmanager",'')
dw_bpm401b_01.setitem(ll_currow,"ingflag",ls_ingflag)
dw_bpm401b_01.setitem(ll_currow,"deptcode",'')
dw_bpm401b_01.setitem(ll_currow,"jobempno",'')
dw_bpm401b_01.setitem(ll_currow,"jobempno2",'')
dw_bpm401b_01.setitem(ll_currow,"ipaddr",'')
dw_bpm401b_01.setitem(ll_currow,"macaddr",'')
dw_bpm401b_01.setitem(ll_currow,"lastemp",g_s_empno)
dw_bpm401b_01.setitem(ll_currow,"lastdate",g_s_datetime)

end event

event ue_delete;call super::ue_delete;long ll_selrow

ll_selrow = dw_bpm401b_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "삭제할 작업을 선택해 주십시요."
	return -1
end if

dw_bpm401b_01.deleterow(ll_selrow)
end event

event timer;call super::timer;//this.triggerevent("ue_retrieve")
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm401b
end type

type dw_bpm401b_01 from u_vi_std_datawindow within w_bpm401b
integer x = 23
integer y = 312
integer width = 3451
integer height = 1612
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_bpm401b_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;if dwo.name = 'run_mode' then
	window		 l_to_open
	string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
	string		 l_s_st, l_s_winnm
	string       ls_ingflag, ls_seqno, ls_xyear, ls_revno
	
	setpointer(hourglass!)
	
	l_s_winid = This.getitemstring(row,"windowid")
	ls_seqno = This.getitemstring(row,"seqno")
	ls_xyear = This.getitemstring(row,"xyear")
	ls_revno = This.getitemstring(row,"revno")
	if f_spacechk(l_s_winid) = -1 then
		uo_status.st_message.text = "준비 않된 [화면]입니다."
		return -1
	end if
	
	if ls_seqno = '170' then
		openwithparm(w_bpm407c, uo_year.uf_return())
		return 0
	end if
	
	l_s_wingrd = ' '
	
	//입고만처리
	  SELECT WIN_ID,   
				WIN_NM,   
				WIN_RPT   
		 INTO :l_s_winid,   
				:l_s_winnm,   
				:g_s_runparm   
		 FROM COMM110  
		WHERE WIN_ID = :l_s_winid
		USING	sqlpis	;
		
	if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
		g_s_runparm = ' '
	end if
	
	this.setredraw(false)
	if f_open_sheet(l_s_winid) = 0 then
		if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm + ls_revno + ls_xyear, &
									l_s_winid, w_frame, 0, Layered!) = -1 then
			uo_status.st_message.text = "준비 않된 [화면]입니다."
			return -1
		end if
	end if
	
	this.setredraw(true)
end if
end event

event itemchanged;call super::itemchanged;string ls_colname, ls_deptcode, ls_deptname

ls_colname = dwo.name
	
if ls_colname = 'jobempno' then
	ls_deptcode = this.getitemstring(row,"deptcode")
	if f_spacechk(ls_deptcode) <> -1 then
		SELECT CC.DNAME INTO :ls_deptname 
		FROM PBCOMMON.DAC003 BB, PBCOMMON.DAC001 CC 
			WHERE ( CC.DCODE = BB.PEDEPT ) and ( BB.PEEMPNO = :data ) and
					( CC.DUSE = ' ' ) and ( CC.DTODT = 0  ) and
	      		( CC.DACTTODT = 0 )  and ( CC.DDIV2 <> '' ) and
		   		( CC.DFNAME1 <> '외주업체' ) AND ( BB.PEOUT <> '*' ) 
		using sqlca;
		if f_spacechk(ls_deptname) = -1 then
			this.setitem(row,"jobempno",'')
			uo_status.st_message.text = "해당부서에 속하는 담당자가 아닙니다."
			return 1
		else
			this.setitem(row,"deptname",ls_deptname)
		end if
	end if
end if
if ls_colname = 'jobempno2' then
	ls_deptcode = this.getitemstring(row,"deptcode")
	if f_spacechk(ls_deptcode) <> -1 then
		SELECT CC.DNAME INTO :ls_deptname 
		FROM PBCOMMON.DAC003 BB, PBCOMMON.DAC001 CC 
			WHERE ( CC.DCODE = BB.PEDEPT ) and ( BB.PEEMPNO = :data ) and
					( CC.DUSE = ' ' ) and ( CC.DTODT = 0  ) and
	      		( CC.DACTTODT = 0 )  and ( CC.DDIV2 <> '' ) and
		   		( CC.DFNAME1 <> '외주업체' ) AND ( BB.PEOUT <> '*' ) 
		using sqlca;
		if f_spacechk(ls_deptname) = -1 then
			this.setitem(row,"jobempno2",'')
			uo_status.st_message.text = "해당부서에 속하는 담당자가 아닙니다."
			return 1
		else
			this.setitem(row,"deptname",ls_deptname)
		end if
	end if
end if
if ls_colname = 'deptcode' then
	SELECT CC.DNAME INTO :ls_deptname 
	FROM PBCOMMON.DAC001 CC 
		WHERE ( CC.DCODE = :data ) and ( CC.DUSE = ' ' ) and ( CC.DTODT = 0  ) and
				( CC.DACTTODT = 0 )  and ( CC.DDIV2 <> '' ) 
	using sqlca;
	if f_spacechk(ls_deptname) = -1 then
		this.setitem(row,"deptcode",'')
		uo_status.st_message.text = "등록된 부서가 아닙니다."
		return 1
	else
		this.setitem(row,"deptname",ls_deptname)
	end if
end if

return 0
end event

type uo_year from uo_ccyy_mps within w_bpm401b
event destroy ( )
integer x = 375
integer y = 44
integer taborder = 31
boolean bringtotop = true
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;dw_bpm401b_01.reset()

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										'%', &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

type st_1 from statictext within w_bpm401b
integer x = 64
integer y = 52
integer width = 293
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_begin from commandbutton within w_bpm401b
integer x = 1874
integer y = 40
integer width = 585
integer height = 104
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "사업계획 착수"
end type

event clicked;string ls_applyyear, ls_message, ls_refyear, ls_revno, ls_ref_revno

ls_applyyear = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

SELECT XYEAR, REVNO INTO :ls_refyear,:ls_ref_revno
FROM PBBPM.BPM519
WHERE COMLTD = '01'
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if (ls_applyyear = ls_refyear and ls_revno = ls_ref_revno) or (ls_applyyear < ls_refyear) then
	uo_status.st_message.text = "이미 착수되었거나, 확정된 사업년도에 해당합니다."
	return -1
end if

if f_spacechk(ls_revno) = -1 then
	ls_revno = '0A'
end if

if mid(ls_revno,1,1) <> '0' then
	uo_status.st_message.text = "사업계획 버전에 해당하지 않습니다."
	return -1
end if

SQLCA.AUTOCOMMIT = FALSE

INSERT INTO "PBBPM"."BPM519"  
( "COMLTD", "XYEAR", "REVNO", "WINDOWID", "SEQNO", "TASKNAME", "TASKSTATUS", "JOBSTART", "JOBEND",   
  "TASKMANAGER", "INGFLAG", "DEPTCODE", "JOBEMPNO", "JOBEMPNO2", 
  "IPADDR", "MACADDR", "LASTEMP", "LASTDATE" )  
SELECT "COMLTD",:ls_applyyear,:ls_revno,"WINDOWID","SEQNO","TASKNAME",'G','','',
"TASKMANAGER", 'G', "DEPTCODE", "JOBEMPNO", "JOBEMPNO2",
:g_s_ipaddr,:g_s_macaddr,:g_s_empno,:g_s_datetime
FROM PBBPM.BPM519
WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND REVNO = :ls_ref_revno
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "착수 데이타생성시에 에러가 발생하였습니다."
	goto Rollback_
else
	ls_message = "사업계획착수가 완료되었습니다."
end if

COMMIT using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = ls_message
f_bpm_job_end(ls_applyyear,ls_revno,'w_bpm401b',g_s_empno,'C','사업계획진행관리 착수 작업종료 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type cb_end from commandbutton within w_bpm401b
integer x = 2528
integer y = 40
integer width = 585
integer height = 104
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "사업계획 확정"
end type

event clicked;string ls_year, ls_message, ls_revno

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

SQLCA.AUTOCOMMIT = FALSE

UPDATE PBBPM.BPM519
SET INGFLAG = 'C', LASTEMP = :g_s_empno, LASTDATE = :g_s_date
WHERE COMLTD = :g_s_company AND XYEAR = :ls_year AND REVNO = :ls_revno
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "확정시에 에러가 발생하였습니다."
	goto Rollback_
else
	ls_message = "확정되었습니다."
end if

COMMIT using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = ls_message
f_bpm_job_end(ls_year,ls_revno,'w_bpm401b',g_s_empno,'C','사업계획진행관리 확정 작업종료 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type cb_cancel from commandbutton within w_bpm401b
integer x = 3182
integer y = 40
integer width = 663
integer height = 104
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "사업계획 확정취소"
end type

event clicked;string ls_year, ls_message, ls_revno

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

SQLCA.AUTOCOMMIT = FALSE

UPDATE PBBPM.BPM519
SET INGFLAG = 'G', LASTEMP = :g_s_empno, LASTDATE = :g_s_date
WHERE COMLTD = :g_s_company AND XYEAR = :ls_year AND REVNO = :ls_revno
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "확정취소시에 에러가 발생하였습니다."
	goto Rollback_
else
	ls_message = "확정취소되었습니다."
end if

COMMIT using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = ls_message
f_bpm_job_end(ls_year,ls_revno,'w_bpm401b',g_s_empno,'C','사업계획진행관리 확정취소 작업종료 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type uo_2 from u_bpm_select_arev within w_bpm401b
event destroy ( )
integer x = 809
integer y = 44
integer taborder = 41
boolean bringtotop = true
end type

on uo_2.destroy
call u_bpm_select_arev::destroy
end on

event ue_select;call super::ue_select;if mid(this.is_uo_revno,1,1) = 'A' then
	st_2.text = "월별제품별 재료비작업 진행화면입니다."
else
	st_2.text = "사업계획시스템 진행화면입니다."
end if

iw_this.triggerevent('ue_retrieve')
end event

type cb_month from commandbutton within w_bpm401b
integer x = 3954
integer y = 44
integer width = 320
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "월별진행"
end type

event clicked;//* 월별재료비 계산 진행화면 생성
//* 1월 ('A1') ... 9월 ('A9') 10월 ('AX') 11월 ('AY') 12월 ('AZ')
string ls_applyyear, ls_message, ls_refyear, ls_revno, ls_ref_revno, ls_ref_month
integer li_chkcnt

ls_applyyear = mid(g_s_date,1,4)
ls_ref_month = mid(g_s_date,5,2)
if ls_ref_month = '01' then
	ls_applyyear = mid(f_relative_month(g_s_date,-1),1,4)
end if
Choose Case ls_ref_month
	case '01'
		ls_revno = 'AZ'
	case '02'
		ls_revno = 'A1'
	case '03'
		ls_revno = 'A2'
	case '04'
		ls_revno = 'A3'
	case '05'
		ls_revno = 'A4'
	case '06'
		ls_revno = 'A5'
	case '07'
		ls_revno = 'A6'
	case '08'
		ls_revno = 'A7'
	case '09'
		ls_revno = 'A8'
	case '10'
		ls_revno = 'A9'
	case '11'
		ls_revno = 'AX'
	case '12'
		ls_revno = 'AY'
End Choose

SELECT COUNT(*) INTO :li_chkcnt
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND XYEAR = :ls_applyyear  AND REVNO = :ls_revno
FETCH FIRST 1 ROW ONLY
using sqlca;

if li_chkcnt > 0 then
	uo_status.st_message.text = "해당월별재료비 작업이 착수된 상태입니다."
	return -1
end if

SELECT XYEAR, REVNO INTO :ls_refyear,:ls_ref_revno
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND SUBSTRING(REVNO,1,1) = '0'
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

SQLCA.AUTOCOMMIT = FALSE

INSERT INTO "PBBPM"."BPM519"  
( "COMLTD", "XYEAR", "REVNO", "WINDOWID", "SEQNO", "TASKNAME", "TASKSTATUS", "JOBSTART", "JOBEND",   
  "TASKMANAGER", "INGFLAG", "DEPTCODE", "JOBEMPNO", "JOBEMPNO2", 
  "IPADDR", "MACADDR", "LASTEMP", "LASTDATE" )  
SELECT "COMLTD",:ls_applyyear,:ls_revno,"WINDOWID","SEQNO","TASKNAME",'G','','',
"TASKMANAGER", 'G', "DEPTCODE", "JOBEMPNO", "JOBEMPNO2",
:g_s_ipaddr,:g_s_macaddr,:g_s_empno,:g_s_datetime
FROM PBBPM.BPM519
WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND REVNO = :ls_ref_revno
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "월별재료비 착수 데이타생성시에 에러가 발생하였습니다."
	goto Rollback_
else
	ls_message = "월별 재료비 계획착수가 완료되었습니다."
end if

COMMIT using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = ls_message
f_bpm_job_end(ls_applyyear,ls_revno,'w_bpm401b',g_s_empno,'C','월별재료비진행관리 착수 작업종료 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type st_2 from statictext within w_bpm401b
integer x = 23
integer y = 196
integer width = 1815
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_bomcopy from commandbutton within w_bpm401b
integer x = 3520
integer y = 192
integer width = 768
integer height = 92
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "사업계획BOM버전복사"
end type

event clicked;string ls_year, ls_revno, ls_target, ls_message

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

ls_target = sle_target.text

if f_bpm004_versioncopy(ls_year, ls_revno, ls_target, ls_message) = -1 then
	uo_status.st_message.text = "복사실패 : " + ls_message
else
	uo_status.st_message.text = "정상적으로 복사되었습니다."
end if
end event

type sle_target from singlelineedit within w_bpm401b
integer x = 3305
integer y = 188
integer width = 165
integer height = 92
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_bpm401b
integer x = 2953
integer y = 200
integer width = 347
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
string text = "목표버전:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bpm401b
integer x = 23
integer y = 8
integer width = 4288
integer height = 160
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

