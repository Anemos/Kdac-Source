$PBExportHeader$w_bpm407c.srw
$PBExportComments$사업계획BOM생성 Response 윈도우
forward
global type w_bpm407c from window
end type
type uo_2 from u_bpm_select_arev within w_bpm407c
end type
type cb_go from commandbutton within w_bpm407c
end type
type cb_stop from commandbutton within w_bpm407c
end type
type cb_create from commandbutton within w_bpm407c
end type
type dw_bpm407c_02 from datawindow within w_bpm407c
end type
type st_message from statictext within w_bpm407c
end type
type cb_close from commandbutton within w_bpm407c
end type
type dw_bpm407c_01 from datawindow within w_bpm407c
end type
type cb_retrieve from commandbutton within w_bpm407c
end type
type st_2 from statictext within w_bpm407c
end type
type em_mmday from editmask within w_bpm407c
end type
type st_1 from statictext within w_bpm407c
end type
type uo_year from uo_ccyy_mps within w_bpm407c
end type
type gb_1 from groupbox within w_bpm407c
end type
type gb_2 from groupbox within w_bpm407c
end type
end forward

global type w_bpm407c from window
integer width = 4306
integer height = 1804
boolean titlebar = true
string title = "사업계획 BOM 생성화면"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
event ue_postopen ( )
uo_2 uo_2
cb_go cb_go
cb_stop cb_stop
cb_create cb_create
dw_bpm407c_02 dw_bpm407c_02
st_message st_message
cb_close cb_close
dw_bpm407c_01 dw_bpm407c_01
cb_retrieve cb_retrieve
st_2 st_2
em_mmday em_mmday
st_1 st_1
uo_year uo_year
gb_1 gb_1
gb_2 gb_2
end type
global w_bpm407c w_bpm407c

event ue_postopen();string ls_refyear,ls_taskstatus,ls_message,ls_revno

dw_bpm407c_01.settransobject(sqlca)
dw_bpm407c_02.settransobject(sqlca)

ls_message = right(message.stringparm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

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

if f_bpm_check_ingflag(ls_refyear,ls_revno,'w_bpm407c') = 'C' then
	cb_create.enabled = false
	cb_stop.enabled = false
	cb_go.enabled = false
else
	if f_bpm_check_jobemp(ls_refyear,ls_revno,'w_bpm407c',g_s_empno) <> -1 then
		SELECT TASKSTATUS INTO :ls_taskstatus 
		FROM PBBPM.BPM519
		WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND 
				REVNO = :ls_revno AND WINDOWID = 'w_bpm407c'
		using sqlca;
		
		if ls_taskstatus = 'C' then
			cb_stop.enabled = False
			cb_create.enabled = false
			cb_go.enabled = True
		else
			cb_stop.enabled = True
			cb_create.enabled = True
			cb_go.enabled = False
		end if
	else
		cb_stop.enabled = False
		cb_create.enabled = False
		cb_go.enabled = False
	end if
end if
end event

on w_bpm407c.create
this.uo_2=create uo_2
this.cb_go=create cb_go
this.cb_stop=create cb_stop
this.cb_create=create cb_create
this.dw_bpm407c_02=create dw_bpm407c_02
this.st_message=create st_message
this.cb_close=create cb_close
this.dw_bpm407c_01=create dw_bpm407c_01
this.cb_retrieve=create cb_retrieve
this.st_2=create st_2
this.em_mmday=create em_mmday
this.st_1=create st_1
this.uo_year=create uo_year
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.uo_2,&
this.cb_go,&
this.cb_stop,&
this.cb_create,&
this.dw_bpm407c_02,&
this.st_message,&
this.cb_close,&
this.dw_bpm407c_01,&
this.cb_retrieve,&
this.st_2,&
this.em_mmday,&
this.st_1,&
this.uo_year,&
this.gb_1,&
this.gb_2}
end on

on w_bpm407c.destroy
destroy(this.uo_2)
destroy(this.cb_go)
destroy(this.cb_stop)
destroy(this.cb_create)
destroy(this.dw_bpm407c_02)
destroy(this.st_message)
destroy(this.cb_close)
destroy(this.dw_bpm407c_01)
destroy(this.cb_retrieve)
destroy(this.st_2)
destroy(this.em_mmday)
destroy(this.st_1)
destroy(this.uo_year)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;// Post Open Event
THIS.PostEvent('ue_postopen')
end event

type uo_2 from u_bpm_select_arev within w_bpm407c
event destroy ( )
integer x = 759
integer y = 48
integer taborder = 40
boolean enabled = false
end type

on uo_2.destroy
call u_bpm_select_arev::destroy
end on

type cb_go from commandbutton within w_bpm407c
integer x = 3867
integer y = 52
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정취소"
end type

event clicked;f_bpm_job_go(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm407c',g_s_empno,'C','BOM 생성 확정작업')
cb_create.enabled = true
cb_stop.enabled = true
cb_go.enabled = false
end event

type cb_stop from commandbutton within w_bpm407c
integer x = 3515
integer y = 52
integer width = 293
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정"
end type

event clicked;f_bpm_job_stop(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm407c',g_s_empno,'C','BOM 생성 확정작업')
cb_create.enabled = false
cb_stop.enabled = False
cb_go.enabled = true
end event

type cb_create from commandbutton within w_bpm407c
integer x = 2747
integer y = 52
integer width = 279
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생성"
end type

event clicked;//*******************************
//* 1. 기준일자 이후에 등록된 품목을 대상으로 함 => 교체된건도 있기 땜시...
//*    수정일자가 기준일자 보다 같거나 큰것을 대상으로 함
//* 2. BOM적용기준일자 담기 => BOM생성 JOBSTART에 업데이트
//*******************************
string ls_applydate, ls_gubun, ls_message, ls_year, ls_revno, ls_chkno
long ll_rtn, ll_bpmcnt

st_message.text = ""
em_mmday.getdata(ls_applydate)
ls_year = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

if f_dateedit(ls_applydate) = space(8) then
	st_message.text = "적용월일을 다시 확인바랍니다."
	return -1
end if

SELECT COUNT(*) INTO :ll_bpmcnt
FROM "PBBPM"."BPM504"
WHERE ( "PBBPM"."BPM504"."PCMCD" = '01' ) AND
		( "PBBPM"."BPM504"."XYEAR" = :ls_year ) AND
		( "PBBPM"."BPM504"."REVNO" = :ls_revno )
using sqlca;

if ll_bpmcnt <> 0 then
	Messagebox("확인","생성된 사업계획BOM이 존재합니다. 재생성할수 없습니다.") 
	return -1
end if

setpointer(HourGlass!)
f_bpm_job_start(ls_year,ls_revno,'w_bpm407c',g_s_empno,'C','사업계획BOM 생성 :' + ls_revno)

sqlca.AutoCommit = FALSE

if (ls_revno = '0A' or mid(ls_revno,1,1) <> '0') then
	// 생성로직 BPM504
	INSERT INTO PBBPM.BPM504
	( PCMCD,XYEAR,REVNO,PLANT,PDVSN,PPITN,PROUT,PCITN,PCHDT,PQTYM,PQTYE,PWKCT,PEDTM,
		PEDTE,POPCD,PEXPLANT,PEXDV,PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK )
	SELECT A.PCMCD,:ls_year,:ls_revno,A.PLANT,A.PDVSN,A.PPITN,A.PROUT,A.PCITN,A.PCHDT,A.PQTYM,A.PQTYE,A.PWKCT,A.PEDTM,
		A.PEDTE,A.POPCD,A.PEXPLANT,A.PEXDV,A.PCHCD,A.POSCD,A.PEBST,A.PMACADDR,A.PIPADDR,:g_s_date,A.PEMNO,A.PREMK
	FROM PBPDM.BOM001 A
	WHERE ( A.PCMCD = '01' ) AND ( A.PQTYM <> 0 ) AND
		( (A.PEDTM <= A.PEDTE AND A.PEDTE <> ' ' AND A.PEDTE >= :ls_applydate ) OR  ( A.PEDTE = ' ' ))
		AND NOT EXISTS ( SELECT * FROM PBBPM.BPM504 B
			WHERE A.PCMCD = B.PCMCD AND A.PLANT = B.PLANT AND A.PDVSN = B.PDVSN AND
				A.PROUT = B.PROUT AND A.PCITN = B.PCITN AND A.PPITN = B.PPITN AND
				B.XYEAR = :ls_year AND B.REVNO = :ls_revno AND
				( (B.PEDTM <= B.PEDTE AND B.PEDTE <> ' ' AND B.PEDTE >= :ls_applydate ) OR  ( B.PEDTE = ' ' )) )
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "사업계획 BOM생성시에 오류가 발생하였습니다."
		goto Roll_back
	end if
			
	//생성로직 BPM505
	INSERT INTO PBBPM.BPM505
	( OCMCD,XYEAR,REVNO,OPLANT,ODVSN,OPITN,OFITN,OCHDT,OEDTM,OEDTE,ORATE,OCHCD,
		OFOCD,OMACADDR,OIPADDR,OEMNO,OINDT )
	SELECT A.OCMCD,:ls_year,:ls_revno,A.OPLANT,A.ODVSN,A.OPITN,A.OFITN,A.OCHDT,A.OEDTM,A.OEDTE,A.ORATE,A.OCHCD,
		A.OFOCD,A.OMACADDR,A.OIPADDR,A.OEMNO,:g_s_date
	FROM PBPDM.BOM003 A
	WHERE ( A.OCMCD = '01' ) AND
		( (A.OEDTM <= A.OEDTE AND A.OEDTE <> ' ' AND A.OEDTE >= :ls_applydate ) OR ( A.OEDTE = ' ' )) AND
		NOT EXISTS ( SELECT * FROM PBBPM.BPM505 B
			WHERE A.OCMCD = B.OCMCD AND A.OPLANT = B.OPLANT AND A.ODVSN = B.ODVSN AND
				A.OPITN = B.OPITN AND A.OFITN = B.OFITN AND A.OPITN = B.OPITN AND
				B.XYEAR = :ls_year AND B.REVNO = :ls_revno AND
				( (B.OEDTM <= B.OEDTE AND B.OEDTE <> ' ' AND B.OEDTE >= :ls_applydate ) OR ( B.OEDTE = ' ' )) )
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "사업계획 호환BOM생성시에 오류가 발생하였습니다."
		goto Roll_back
	end if
else
	SELECT REVNO INTO :ls_chkno
	FROM PBBPM.BPM504
	WHERE PCMCD = :g_s_company AND XYEAR = :ls_year AND REVNO < :ls_revno
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	
	if sqlca.sqlcode <> 0 or f_spacechk(ls_chkno) = -1 then
		ls_message = "사업계획 BOM생성을 위한 전버전이 존재하지 않습니다."
		goto Roll_back
	end if
	
	// 생성로직 BPM504
	INSERT INTO PBBPM.BPM504
	SELECT * FROM PBBPM.BPM504
	WHERE PCMCD = :g_s_company AND XYEAR = :ls_year AND
			REVNO = :ls_chkno
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "사업계획 BOM생성시에 오류가 발생하였습니다."
		goto Roll_back
	end if
	
	//생성로직 BPM505
	INSERT INTO PBBPM.BPM505
	SELECT * FROM PBBPM.BPM505
	WHERE OCMCD = :g_s_company AND XYEAR = :ls_year AND
			REVNO = :ls_chkno
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "사업계획 호환BOM생성시에 오류가 발생하였습니다."
		goto Roll_back
	end if
end if

// 2. BOM적용기준일자 담기 => BOM생성 JOBSTART에 업데이트	
UPDATE PBBPM.BPM519
SET Jobstart = :ls_applydate
WHERE COMLTD = :g_s_company AND XYEAR = :ls_year AND 
		REVNO = :ls_revno AND Windowid = 'w_bpm407c'
using sqlca;
if sqlca.sqlnrows < 1 then
	ls_message = "사업계획 BOM생성시에 적용일자 오류가 발생하였습니다."
	goto Roll_back
end if
	
COMMIT USING sqlca;
sqlca.AutoCommit = TRUE
cb_retrieve.triggerevent(Clicked!)
st_message.text = "사업계획 BOM생성작업이 정상적으로 수행되었습니다."
f_bpm_job_end(ls_year,ls_revno,'w_bpm407c',g_s_empno,'C','사업계획BOM 생성')
return 0

Roll_back:
ROLLBACK USING sqlca;
sqlca.AutoCommit = TRUE
st_message.text = ls_message
return -1


end event

type dw_bpm407c_02 from datawindow within w_bpm407c
integer x = 18
integer y = 516
integer width = 4229
integer height = 1064
integer taborder = 40
string title = "none"
string dataobject = "d_bpm_common_bpm521"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_message from statictext within w_bpm407c
integer x = 18
integer y = 1624
integer width = 4229
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_bpm407c
integer x = 3081
integer y = 52
integer width = 315
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(w_bpm407c)
end event

type dw_bpm407c_01 from datawindow within w_bpm407c
integer x = 18
integer y = 184
integer width = 4229
integer height = 308
integer taborder = 30
string dataobject = "d_bpm407c_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;st_message.text = ""
if dwo.name = 'run_mode' then
	string ls_gubun, ls_message, ls_year, ls_date
	long ll_rtn, ll_bpmcnt
	
	sqlca.AutoCommit = FALSE
	ls_year = this.getitemstring(row,"apply_year")
	ls_date = this.getitemstring(row,"apply_date")
	ls_gubun = this.getitemstring(row,"cnt_name")
	ll_bpmcnt = this.getitemnumber(row,"bpm_cnt")
	ls_message = "정상적으로 생성이 완료되었습니다."
	if ls_gubun = 'BOM001' then
		if ll_bpmcnt <> 0 then
			ll_rtn = Messagebox("확인","생성된 사업계획BOM이 존재합니다. 재생성하겠습니까?" , &
					Exclamation!, OKCancel!, 2)
			if ll_rtn = 2 then
				return -1
			else
				DELETE FROM "PBBPM"."BPM504"
				WHERE "PBBPM"."BPM504"."PCMCD" = '01' AND "PBBPM"."BPM504"."XYEAR" = :ls_year
				using sqlca;
			end if
		end if
		
		// 생성로직
		INSERT INTO "PBBPM"."BPM504"
		( "PCMCD","XYEAR","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE","PWKCT","PEDTM",
		"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST","PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )
		SELECT "PCMCD",:ls_year,"PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE","PWKCT","PEDTM",
		"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST","PMACADDR","PIPADDR","PINDT","PEMNO","PREMK"
		FROM "PBPDM"."BOM001"
		WHERE ( "PBPDM"."BOM001"."PCMCD" = '01' ) AND  
		( ("PBPDM"."BOM001"."PEDTM" <= "PBPDM"."BOM001"."PEDTE" AND "PBPDM"."BOM001"."PEDTE" <> ' '
			AND "PBPDM"."BOM001"."PEDTE" >= :ls_date ) 
			OR  ( "PBPDM"."BOM001"."PEDTE" = ' ' ))
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ls_message = "사업계획 BOM생성시에 오류가 발생하였습니다."
			goto Roll_back
		end if
	else
		if ll_bpmcnt <> 0 then
			ll_rtn = Messagebox("확인","생성된 사업계획 호환BOM이 존재합니다. 재생성하겠습니까?" , &
					Exclamation!, OKCancel!, 2)
			if ll_rtn = 2 then
				return -1
			else
				DELETE FROM "PBBPM"."BPM505"
				WHERE "PBBPM"."BPM505"."OCMCD" = '01' AND "PBBPM"."BPM505"."XYEAR" = :ls_year
				using sqlca;
			end if
		end if
		//생성로직
		INSERT INTO "PBBPM"."BPM505"
		( "OCMCD","XYEAR","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE","OCHCD",
		"OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )
		SELECT "OCMCD",:ls_year,"OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE","OCHCD",
		"OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT"
		FROM "PBPDM"."BOM003"  
		WHERE ( "PBPDM"."BOM003"."OCMCD" = '01' ) AND
		( ("PBPDM"."BOM003"."OEDTM" <= "PBPDM"."BOM003"."OEDTE" AND "PBPDM"."BOM003"."OEDTE" <> ' ' AND 
		 "PBPDM"."BOM003"."OEDTE" >= :ls_date )
		 OR ( "PBPDM"."BOM003"."OEDTE" = ' ' )) 
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ls_message = "사업계획 호환BOM생성시에 오류가 발생하였습니다."
			goto Roll_back
		end if
	end if
	
	COMMIT USING sqlca;
	sqlca.AutoCommit = TRUE
	cb_retrieve.triggerevent(Clicked!)
	st_message.text = ls_message
	return 0
	
	Roll_back:
	ROLLBACK USING sqlca;
	sqlca.AutoCommit = TRUE
	st_message.text = ls_message
	return -1
end if
end event

type cb_retrieve from commandbutton within w_bpm407c
integer x = 2418
integer y = 52
integer width = 279
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;string ls_applydate, ls_from, ls_to

st_message.text = ""
em_mmday.getdata(ls_applydate)
ls_from		=	string(mid(ls_applydate,1,4) + '1001',"@@@@-@@-@@")
ls_to		=	string(f_relativedate(g_s_date,1),"@@@@-@@-@@")

if f_dateedit(ls_applydate) = space(8) then
	st_message.text = "적용월일을 다시 확인바랍니다."
	return -1
end if

dw_bpm407c_01.reset()
dw_bpm407c_02.reset()
dw_bpm407c_01.retrieve(uo_year.uf_return(),uo_2.is_uo_revno,ls_applydate)
dw_bpm407c_02.retrieve(uo_year.uf_return(), 'w_bpm407c%',ls_from,ls_to)


end event

type st_2 from statictext within w_bpm407c
integer x = 1664
integer y = 56
integer width = 270
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "적용월일"
boolean focusrectangle = false
end type

type em_mmday from editmask within w_bpm407c
integer x = 1934
integer y = 48
integer width = 411
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

type st_1 from statictext within w_bpm407c
integer x = 73
integer y = 56
integer width = 270
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
boolean focusrectangle = false
end type

type uo_year from uo_ccyy_mps within w_bpm407c
integer x = 357
integer y = 52
integer taborder = 10
boolean enabled = false
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

type gb_1 from groupbox within w_bpm407c
integer x = 18
integer y = 16
integer width = 3433
integer height = 152
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_bpm407c
integer x = 3461
integer y = 16
integer width = 782
integer height = 152
integer taborder = 30
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

