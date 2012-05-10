$PBExportHeader$w_bpm401a.srw
$PBExportComments$사업계획진행현황
forward
global type w_bpm401a from w_ipis_sheet01
end type
type dw_bpm401a_01 from u_vi_std_datawindow within w_bpm401a
end type
type cb_end from commandbutton within w_bpm401a
end type
type cb_cancel from commandbutton within w_bpm401a
end type
type cb_begin from commandbutton within w_bpm401a
end type
type uo_year from uo_ccyy_mps within w_bpm401a
end type
type st_1 from statictext within w_bpm401a
end type
type uo_2 from u_bpm_select_arev within w_bpm401a
end type
type st_2 from statictext within w_bpm401a
end type
type gb_1 from groupbox within w_bpm401a
end type
end forward

global type w_bpm401a from w_ipis_sheet01
integer width = 4306
integer height = 2412
dw_bpm401a_01 dw_bpm401a_01
cb_end cb_end
cb_cancel cb_cancel
cb_begin cb_begin
uo_year uo_year
st_1 st_1
uo_2 uo_2
st_2 st_2
gb_1 gb_1
end type
global w_bpm401a w_bpm401a

on w_bpm401a.create
int iCurrent
call super::create
this.dw_bpm401a_01=create dw_bpm401a_01
this.cb_end=create cb_end
this.cb_cancel=create cb_cancel
this.cb_begin=create cb_begin
this.uo_year=create uo_year
this.st_1=create st_1
this.uo_2=create uo_2
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bpm401a_01
this.Control[iCurrent+2]=this.cb_end
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_begin
this.Control[iCurrent+5]=this.uo_year
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.gb_1
end on

on w_bpm401a.destroy
call super::destroy
destroy(this.dw_bpm401a_01)
destroy(this.cb_end)
destroy(this.cb_cancel)
destroy(this.cb_begin)
destroy(this.uo_year)
destroy(this.st_1)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_bpm401a_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bpm401a_01.Height= newheight - ( dw_bpm401a_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;string ls_refyear

dw_bpm401a_01.settransobject(sqlca)

SELECT XYEAR INTO :ls_refyear
FROM PBBPM.BPM519
WHERE COMLTD = '01'
ORDER BY XYEAR DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if f_spacechk(ls_refyear) = -1 then
	uo_year.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
else
	uo_year.uf_reset(integer(ls_refyear))
end if

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										'%', &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')

wf_icon_onoff(true,  false,  false,  false,  false,  false,  false,    false)

This.triggerevent('ue_retrieve')

timer(10)
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_ingflag, ls_revno

ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

dw_bpm401a_01.reset()
dw_bpm401a_01.retrieve(ls_year, ls_revno)

if f_bpm_check_jobemp(ls_year,ls_revno,'w_bpm401a',g_s_empno) <> -1 then
	SELECT INGFLAG INTO :ls_ingflag FROM PBBPM.BPM519
	WHERE COMLTD = :g_s_company AND XYEAR = :ls_year AND REVNO = :ls_revno
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	if f_spacechk(ls_ingflag) = -1 then
		cb_begin.enabled = true
		cb_end.enabled = false
		cb_cancel.enabled = false
	else
		cb_begin.enabled = false
		if ls_ingflag = 'C' then
			cb_end.enabled = false
			cb_cancel.enabled = true
		else
			cb_end.enabled = true
			cb_cancel.enabled = false
		end if
	end if
else
	ls_year = mid(f_relativedate(ls_year + '0101',-1),1,4)
	if f_bpm_check_jobemp(ls_year,ls_revno,'w_bpm401a',g_s_empno) <> -1 then
		cb_begin.enabled = true
		cb_end.enabled = false
		cb_cancel.enabled = false
	else
		cb_begin.enabled = false
		cb_end.enabled = false
		cb_cancel.enabled = false
	end if
end if
end event

event timer;call super::timer;this.triggerevent("ue_retrieve")
end event

event activate;call super::activate;dw_bpm401a_01.settransobject(sqlca)
This.triggerevent('ue_retrieve')
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm401a
end type

type dw_bpm401a_01 from u_vi_std_datawindow within w_bpm401a
integer x = 23
integer y = 284
integer width = 3451
integer height = 1524
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_bpm401a_01"
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
	
	if l_s_winid = 'w_bpm407c' then
		openwithparm(w_bpm407c, ls_revno + uo_year.uf_return())
		return 0
	end if
	
	if l_s_winid = 'w_bpm401b' and g_s_deptcd <> '2300' then
		uo_status.st_message.text = "시스템개발팀 담당자만 이동할수 있습니다."
		return -1
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
		if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm + ls_seqno + ls_revno + ls_xyear, &
									l_s_winid, w_frame, 0, Layered!) = -1 then
			uo_status.st_message.text = "준비 않된 [화면]입니다."
			return -1
		end if
	end if
	
	this.setredraw(true)
end if
end event

type cb_end from commandbutton within w_bpm401a
integer x = 2647
integer y = 36
integer width = 677
integer height = 104
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
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
f_bpm_job_end(ls_year,ls_revno,'w_bpm401a',g_s_empno,'C','사업계획진행관리 확정 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type cb_cancel from commandbutton within w_bpm401a
integer x = 3415
integer y = 36
integer width = 677
integer height = 104
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
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
f_bpm_job_end(ls_year,ls_revno,'w_bpm401a',g_s_empno,'C','사업계획진행관리 확정취소 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type cb_begin from commandbutton within w_bpm401a
integer x = 1879
integer y = 36
integer width = 677
integer height = 104
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "사업계획 착수"
end type

event clicked;string ls_applyyear, ls_message, ls_refyear, ls_ref_revno, ls_revno

ls_applyyear = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

SELECT XYEAR, REVNO INTO :ls_refyear, :ls_ref_revno
FROM PBBPM.BPM519
WHERE COMLTD = '01'
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if (ls_applyyear = ls_refyear and ls_revno = ls_ref_revno) or (ls_applyyear < ls_refyear) then
	uo_status.st_message.text = "이미 착수되었거나, 확정된 사업년도에 해당합니다."
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
f_bpm_job_end(ls_applyyear,ls_revno,'w_bpm401a',g_s_empno,'C','사업계획진행관리 착수 :' + ls_revno)
return 0

Rollback_:
ROLLBACK using sqlca;
SQLCA.AUTOCOMMIT = TRUE 
uo_status.st_message.text = ls_message

return -1
end event

type uo_year from uo_ccyy_mps within w_bpm401a
event destroy ( )
integer x = 375
integer y = 44
integer taborder = 31
boolean bringtotop = true
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;dw_bpm401a_01.reset()

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										'%', &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

type st_1 from statictext within w_bpm401a
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

type uo_2 from u_bpm_select_arev within w_bpm401a
integer x = 800
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
	string ls_taskname, ls_year, ls_revno
	
	ls_year = uo_year.uf_return()
	ls_revno = this.is_uo_revno
	select taskname into :ls_taskname
	from pbbpm.bpm522
	where comltd = '01' and xyear = :ls_year and revno = :ls_revno
	using sqlca;
	
	if f_spacechk(ls_taskname) = -1 then
		st_2.text = "사업계획시스템 진행화면입니다."
	else
		st_2.text = "버전정보 : " + ls_taskname
	end if
end if

iw_this.triggerevent('ue_retrieve')
end event

type st_2 from statictext within w_bpm401a
integer x = 64
integer y = 160
integer width = 2487
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
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bpm401a
integer x = 23
integer y = 8
integer width = 4110
integer height = 260
integer taborder = 41
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

