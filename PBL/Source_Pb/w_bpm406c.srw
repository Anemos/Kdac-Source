$PBExportHeader$w_bpm406c.srw
$PBExportComments$재료비생성및확인
forward
global type w_bpm406c from w_ipis_sheet01
end type
type uo_year from uo_ccyy_mps within w_bpm406c
end type
type dw_bpm406c_01 from u_vi_std_datawindow within w_bpm406c
end type
type st_1 from statictext within w_bpm406c
end type
type pb_down from picturebutton within w_bpm406c
end type
type cb_errorchk from commandbutton within w_bpm406c
end type
type cb_execute from commandbutton within w_bpm406c
end type
type uo_2 from u_bpm_select_arev within w_bpm406c
end type
type st_2 from statictext within w_bpm406c
end type
type ddlb_gubun from dropdownlistbox within w_bpm406c
end type
type cb_stop from commandbutton within w_bpm406c
end type
type cb_go from commandbutton within w_bpm406c
end type
type gb_1 from groupbox within w_bpm406c
end type
type gb_2 from groupbox within w_bpm406c
end type
end forward

global type w_bpm406c from w_ipis_sheet01
integer width = 4686
integer height = 2588
uo_year uo_year
dw_bpm406c_01 dw_bpm406c_01
st_1 st_1
pb_down pb_down
cb_errorchk cb_errorchk
cb_execute cb_execute
uo_2 uo_2
st_2 st_2
ddlb_gubun ddlb_gubun
cb_stop cb_stop
cb_go cb_go
gb_1 gb_1
gb_2 gb_2
end type
global w_bpm406c w_bpm406c

on w_bpm406c.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.dw_bpm406c_01=create dw_bpm406c_01
this.st_1=create st_1
this.pb_down=create pb_down
this.cb_errorchk=create cb_errorchk
this.cb_execute=create cb_execute
this.uo_2=create uo_2
this.st_2=create st_2
this.ddlb_gubun=create ddlb_gubun
this.cb_stop=create cb_stop
this.cb_go=create cb_go
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.dw_bpm406c_01
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.cb_errorchk
this.Control[iCurrent+6]=this.cb_execute
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.ddlb_gubun
this.Control[iCurrent+10]=this.cb_stop
this.Control[iCurrent+11]=this.cb_go
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_bpm406c.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.dw_bpm406c_01)
destroy(this.st_1)
destroy(this.pb_down)
destroy(this.cb_errorchk)
destroy(this.cb_execute)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.ddlb_gubun)
destroy(this.cb_stop)
destroy(this.cb_go)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_bpm406c_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bpm406c_01.Height= newheight - ( dw_bpm406c_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_bpm406c_01.settransobject(sqlca)

string ls_refyear, ls_taskstatus, ls_message, ls_revno

ls_message = Right(Message.StringParm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(True,  False,  False,  False,  False,      & 
			     False,  False,    False)

if f_bpm_check_ingflag(ls_refyear,ls_revno,'w_bpm406c') = 'C' then
	cb_errorchk.enabled = false
	cb_execute.enabled = false
	cb_stop.enabled = False
	cb_go.enabled = False
else
	if f_bpm_check_jobemp(ls_refyear,ls_revno,'w_bpm406c',g_s_empno) <> -1 then
		SELECT TASKSTATUS INTO :ls_taskstatus 
		FROM PBBPM.BPM519
		WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND 
				REVNO = :ls_revno AND WINDOWID = 'w_bpm406c'
		using sqlca;
		
		if ls_taskstatus = 'C' then
			cb_errorchk.enabled = false
			cb_execute.enabled = false
			cb_stop.enabled = False
			cb_go.enabled = True
		else
			// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
			wf_icon_onoff(True,  False,  False,  False,  False,      & 
			     False,  False,    False)
			cb_errorchk.enabled = true
			cb_execute.enabled = true
			cb_stop.enabled = True
			cb_go.enabled = False
		end if
	else
		cb_errorchk.enabled = false
		cb_execute.enabled = false
		cb_stop.enabled = False
		cb_go.enabled = False
	end if
end if

if f_spacechk(ls_refyear) = -1 then
	uo_year.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
else
	uo_year.uf_reset(integer(ls_refyear))
end if

ddlb_gubun.text = '배분후'

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										ls_revno, &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

event ue_retrieve;call super::ue_retrieve;dw_bpm406c_01.reset()
if dw_bpm406c_01.retrieve(uo_year.uf_return(), uo_2.is_uo_revno) > 0 then
	uo_status.st_message.text = "에러 항목이 조회되었습니다."
else
	uo_status.st_message.text = "조회된 에러항목이 없습니다."
end if

return 0
end event

event ue_save;call super::ue_save;string ls_message

dw_bpm406c_01.accepttext()

sqlca.AutoCommit = False

if dw_bpm406c_01.modifiedcount() > 0 or dw_bpm406c_01.deletedcount() > 0 then
	if dw_bpm406c_01.update() = 1 then
		ls_message = '저장되었습니다.'
	else
		ls_message = '저장중에 에러가 발생하였습니다.'
		goto RollBack_
	end if
end if

Commit using sqlca;
sqlca.AutoCommit = True
uo_status.st_message.text = ls_message
This.Triggerevent("ue_retrieve")
return 0

RollBack_:
RollBack using sqlca;
sqlca.AutoCommit = True
uo_status.st_message.text = ls_message
return -1
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm406c
end type

type uo_year from uo_ccyy_mps within w_bpm406c
integer x = 375
integer y = 36
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										'%', &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

type dw_bpm406c_01 from u_vi_std_datawindow within w_bpm406c
integer x = 27
integer y = 168
integer width = 4421
integer height = 1640
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bpm406c_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;
if dwo.name = 'errconfirm' then
	this.setitem(row, "updtid", g_s_empno )
end if
end event

event clicked;call super::clicked;string ls_colname
long ll_cnt

ls_colname = dwo.name
if ls_colname = "errconfirm_t" then
	for ll_cnt = 1 to this.rowcount()
		if this.getitemstring(ll_cnt,"errconfirm") = 'Y' then
			this.setitem(ll_cnt,"errconfirm",'N')
			this.setitem(ll_cnt,"updtid",g_s_empno)
		else
			this.setitem(ll_cnt,"errconfirm",'Y')
			this.setitem(ll_cnt,"updtid",g_s_empno)
		end if
	next
end if

return 0
end event

type st_1 from statictext within w_bpm406c
integer x = 64
integer y = 40
integer width = 297
integer height = 72
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
boolean focusrectangle = false
end type

type pb_down from picturebutton within w_bpm406c
integer x = 4270
integer y = 16
integer width = 201
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel_number(dw_bpm406c_01)
end event

type cb_errorchk from commandbutton within w_bpm406c
integer x = 2688
integer y = 36
integer width = 242
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사"
end type

event clicked;string ls_year, ls_revno, ls_divcode, ls_expcode

uo_status.st_message.text = "재료비대상품목 오류 검사중입니다..."
setpointer(HourGlass!)

ls_year  = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

if ddlb_gubun.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

f_bpm_job_start(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','재료비 오류검사')

UPDATE PBBPM.BPM512
SET ERRCONFIRM = 'Y'
WHERE XYEAR = :ls_year
using sqlca;

// 매출품목 품목기본정보 미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), AA.AYEAR,AA.AREV,'매출제품 품목기본정보 미등록',
AA.AMDNO,'','','',AA.APLANT,AA.ADIV,'','',
'','','','','N',''
FROM PBBPM.BPM501 AA
WHERE AA.COMLTD = '01' AND AA.AYEAR = :ls_year AND 
    AA.ACODE = :ls_divcode AND AA.AREV = :ls_revno AND AA.SEQGB <> 'S' AND AA.ATQTY <> 0
AND NOT EXISTS ( SELECT * FROM PBBPM.BPM502 DD
      WHERE AA.AYEAR = DD.XYEAR AND AA.AREV = DD.REVNO AND AA.AMDNO = DD.ITNO )
using sqlca;

if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 매출제품 품목기본정보 미등록")
end if
// 매출품목 품목상세정보 미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), AA.AYEAR,AA.AREV,'매출제품 품목상세정보 미등록',
AA.AMDNO,'','','',AA.APLANT,AA.ADIV,'','',
'','','','','N',''
FROM PBBPM.BPM501 AA
WHERE AA.COMLTD = '01' AND AA.AYEAR = :ls_year AND 
    AA.ACODE = :ls_divcode AND AA.AREV = :ls_revno AND AA.SEQGB <> 'S' AND AA.ATQTY <> 0
AND NOT EXISTS ( SELECT * FROM PBBPM.BPM503 DD
      WHERE AA.AYEAR = DD.XYEAR AND AA.APLANT = DD.XPLANT AND AA.AREV = DD.REVNO AND
            AA.ADIV = DD.DIV AND AA.AMDNO = DD.ITNO )
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 매출제품 품목상세정보 미등록")
end if  
// 원단위품 품목기본정보 미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'원단위품 품목기본정보 미등록',
BB.BMDNO,BB.BCHNO,'','',BB.BPLANT,BB.BDIV,'','',
'','','','','N',''
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0 ) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND AA.AREV = BB.BREV
WHERE NOT EXISTS ( SELECT * FROM PBBPM.BPM502 DD
      WHERE BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BCHNO = DD.ITNO )
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 원단위품 품목기본정보 미등록")
end if              
// 원단위품 품목상세정보 미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'원단위품 품목상세정보 미등록',
BB.BMDNO,BB.BCHNO,'','',BB.BALCD,BB.BDIV,'','',
'','','','','N',''
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0 ) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND AA.AREV = BB.BREV
WHERE NOT EXISTS ( SELECT * FROM PBBPM.BPM503 DD
      WHERE BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BALCD = DD.XPLANT AND 
            BB.BALDIV = DD.DIV AND BB.BCHNO = DD.ITNO )
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 원단위품 품목상세정보 미등록")
end if              
// 원단위품 단가정보 미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'원단위품 단가정보 미등록',
'',BB.BCHNO,DD.CLS,DD.SRCE,BB.BALCD,BB.BDIV,'','',
'','','','','N',BB.BYGCHK
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
  AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND AA.AREV = BB.BREV AND
  BB.BCUMORATE <> 0
INNER JOIN PBBPM.BPM503 DD
ON BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BALCD = DD.XPLANT AND 
BB.BALDIV = DD.DIV AND BB.BCHNO = DD.ITNO
WHERE DD.SRCE <> '03' AND DD.SRCE <> '05' AND DD.SRCE <> '06' AND
  DD.CLS <> '30' AND NOT EXISTS ( SELECT * FROM PBBPM.BPM509 CC
    WHERE CC.YCCYY = BB.XYEAR AND CC.REVNO = BB.BREV AND CC.YITNO = BB.BCHNO AND
          CC.YGUBUN = '10' AND CC.YGRAD = '1')
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 원단위품 단가정보 미등록")
end if           
// 외자단가정보 0인 품목
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'외자단가정보 0인 품목',
'',BB.BCHNO,DD.CLS,DD.SRCE,BB.BALCD,BB.BDIV,CC.YVNDSR,CC.YCURR,
CC.XUNIT,CC.XUNIT1,CC.YCHGE,CC.YPLAN,'N',BB.BYGCHK
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND 
	AA.AREV = BB.BREV AND BB.BCUMORATE <> 0
INNER JOIN PBBPM.BPM503 DD
ON BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BALCD = DD.XPLANT AND 
BB.BALDIV = DD.DIV AND BB.BCHNO = DD.ITNO
INNER JOIN PBBPM.BPM509 CC
ON BB.BCHNO = CC.YITNO AND BB.XYEAR = CC.YCCYY AND BB.BREV = CC.REVNO AND
  CC.YGUBUN = '10' AND CC.YGRAD = '1' AND CC.YCMCD <> 'O'
WHERE DD.SRCE <> '03' AND DD.SRCE <> '05' AND DD.SRCE <> '06' AND
  DD.CLS <> '30' AND CC.YCMCD <> 'O' AND CC.YSRCE = '01' AND CC.YCSTE = 0 
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 외자단가정보 0인 품목")
end if  
// 내자단가정보 0인 품목
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'내자단가정보 0인 품목',
'',BB.BCHNO,DD.CLS,DD.SRCE,BB.BALCD,BB.BDIV,CC.YVNDSR,CC.YCURR,
CC.XUNIT,CC.XUNIT1,CC.YCHGE,CC.YPLAN,'N',BB.BYGCHK
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND 
	AA.AREV = BB.BREV AND BB.BCUMORATE <> 0
INNER JOIN PBBPM.BPM503 DD
ON BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BALCD = DD.XPLANT AND 
BB.BALDIV = DD.DIV AND BB.BCHNO = DD.ITNO
INNER JOIN PBBPM.BPM509 CC
ON BB.BCHNO = CC.YITNO AND BB.XYEAR = CC.YCCYY AND BB.BREV = CC.REVNO AND
  CC.YGUBUN = '10' AND CC.YGRAD = '1' AND CC.YCMCD <> 'O'
WHERE DD.SRCE <> '03' AND DD.SRCE <> '05' AND DD.SRCE <> '06' AND
  DD.CLS <> '30' AND CC.YCMCD <> 'O' AND
  CC.YSRCE <> '01' AND BB.BYGCHK <> 'Y' AND
  ( (CC.CURRATE2 = 100 AND CC.YCSTE = 0 ) OR
	(CC.CURRATE2 <> 100 AND CC.YCSTD = 0 ) )
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 내자단가정보 0인 품목")
end if   
// 통화단위 미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'통화단위 미등록 품목',
'',BB.BCHNO,DD.CLS,DD.SRCE,BB.BALCD,BB.BDIV,CC.YVNDSR,CC.YCURR,
CC.XUNIT,CC.XUNIT1,CC.YCHGE,CC.YPLAN,'N',BB.BYGCHK
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND 
	AA.AREV = BB.BREV AND BB.BCUMORATE <> 0
INNER JOIN PBBPM.BPM503 DD
ON BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BALCD = DD.XPLANT AND 
BB.BALDIV = DD.DIV AND BB.BCHNO = DD.ITNO
INNER JOIN PBBPM.BPM509 CC
ON BB.BCHNO = CC.YITNO AND BB.XYEAR = CC.YCCYY AND BB.BREV = CC.REVNO AND
  CC.YGUBUN = '10' AND CC.YGRAD = '1'
WHERE CC.YCURR = '' OR CC.YCURR IS NULL
using sqlca;
if sqlca.sqlcode <> 0 then
	Messagebox("확인","오류 : 통화단위 미등록 품목")
end if

//10/03 사급품완성품 가공비 0인 품목
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'사급품완성품 가공비 0인 품목',
'',BB.BCHNO,DD.CLS,DD.SRCE,BB.BPLANT,BB.BDIV,CC.YVNDSR,CC.YCURR,
CC.XUNIT,CC.XUNIT1,CC.YCHGE,CC.YPLAN,'N',BB.BYGCHK
FROM (SELECT DISTINCT COMLTD,AYEAR,ACODE,AREV,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM501
  WHERE COMLTD = '01' AND AYEAR = :ls_year AND 
    ACODE = :ls_divcode AND AREV = :ls_revno AND SEQGB <> 'S' AND ATQTY <> 0) AA
INNER JOIN PBBPM.BPM508 BB
ON AA.COMLTD = BB.COMLTD AND AA.AYEAR = BB.XYEAR AND
  AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO AND AA.ACODE = BB.BGUBUN AND 
	AA.AREV = BB.BREV AND BB.BCUMORATE <> 0
INNER JOIN PBBPM.BPM503 DD
ON BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND BB.BALCD = DD.XPLANT AND 
BB.BALDIV = DD.DIV AND BB.BCHNO = DD.ITNO
INNER JOIN PBBPM.BPM509 CC
ON BB.XYEAR = CC.YCCYY AND BB.BREV = CC.REVNO AND BB.BCHNO = CC.YITNO AND
   CC.YGUBUN = '10' AND ((CC.YSRCE = '01' AND CC.YGRAD = '1') OR (CC.YSRCE <> '01' AND CC.YGRAD <> '9'))
WHERE BB.BYGCHK = 'Y' AND CC.YGCST = 0
using sqlca;

//10/03 유상사급품 단가미등록
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'10/03 유상사급품 단가정보 미등록',
'',BB.BCHNO,DD.CLS,DD.SRCE,BB.BALCD,BB.BDIV,'','',
'','','','','N',BB.BYGCHK
FROM PBBPM.BPM508 BB INNER JOIN PBBPM.BPM503 DD
		ON BB.XYEAR = DD.XYEAR AND BB.BREV = DD.REVNO AND
			BB.BPLANT = DD.XPLANT AND BB.BDIV = DD.DIV AND
			BB.BCHNO = DD.ITNO AND BB.BCUMORATE <> 0
   WHERE ( BB.COMLTD = '01' ) AND  
         ( BB.XYEAR = :ls_year ) AND  
         ( BB.BREV = :ls_revno ) AND  
         ( BB.BGUBUN = :ls_divcode ) AND  
			( DD.SRCE = '03' ) AND 
         ( BB.BWOCT = '8888' ) AND NOT EXISTS ( SELECT * FROM PBBPM.BPM509 CC
    WHERE CC.YCCYY = BB.XYEAR AND CC.REVNO = BB.BREV AND CC.YITNO = BB.BCHNO AND
          CC.YGUBUN = '10' AND CC.YGRAD = '1' )
using sqlca;

f_bpm_job_end(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','재료비 오류검사')

parent.triggerevent("ue_retrieve")
return 0
end event

type cb_execute from commandbutton within w_bpm406c
integer x = 3003
integer y = 36
integer width = 416
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "재료비생성"
end type

event clicked;string ls_year, ls_revno, ls_divcode, ls_expcode, ls_message

uo_status.st_message.text = "재료비를 계산중입니다..."
setpointer(HourGlass!)

ls_year  = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

if ddlb_gubun.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'J'
end if
f_bpm_job_start(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','재료비 생성 배분: ' + ls_revno + ls_divcode + ls_expcode)

//// 10/03 반제품 유상사급에 대한 재료비계산 - 로직변경으로 주석처리 2011.02.25
//if f_bpm_create_wipitem_bpm509(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
//	uo_status.st_message.text = ls_message
//	return -1
//end if

if ls_year = '2012' and (ls_revno = '0W' or ls_revno = '0X' or ls_revno = '0V') then
	// BOM조회 테이블에 데이타 생성( 가공비 적용 )
	if f_bpm_create_bpm514_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	
	// BOM조회 테이블에 데이타 생성( 사급완성품단가 적용 )
	if f_bpm_create_bpm514a_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	
	// 제품별재료비 데이타생성 ( 가공비 적용 )
	if f_bpm_create_bpm515_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	
	// 제품별재료비 데이타생성 ( 사급완성품 단가 적용 )
	if f_bpm_create_bpm515a_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	f_bpm_job_end(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','재료비 생성 완료')
	uo_status.st_message.text = "외자품 재료비계산이 완료되었습니다."
	return 0
end if
// BOM조회 테이블에 데이타 생성( 가공비 적용 )
if f_bpm_create_bpm514(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// BOM조회 테이블에 데이타 생성( 사급완성품단가 적용 )
if f_bpm_create_bpm514a(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// 제품별재료비 데이타생성 ( 가공비 적용 )
if f_bpm_create_bpm515(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// 제품별재료비 데이타생성 ( 사급완성품 단가 적용 )
if f_bpm_create_bpm515a(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

//품목별 재료비(기획팀) 생성
if f_bpm_create_bpm516(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// 품목별 재료비(기획팀_연동통화) 생성
if f_bpm_create_bpm516b(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

//품목별 재료비(구매팀) 생성
if f_bpm_create_bpm517(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

//품목별 재료비(구매팀_유상) 생성
if f_bpm_create_bpm518(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

f_bpm_job_end(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','재료비 생성 완료')
uo_status.st_message.text = "계산이 완료되었습니다."
end event

type uo_2 from u_bpm_select_arev within w_bpm406c
integer x = 818
integer y = 40
integer height = 88
integer taborder = 20
boolean bringtotop = true
end type

on uo_2.destroy
call u_bpm_select_arev::destroy
end on

type st_2 from statictext within w_bpm406c
integer x = 1787
integer y = 48
integer width = 329
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "배부기준:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_bpm406c
integer x = 2121
integer y = 32
integer width = 439
integer height = 324
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string item[] = {"배분전","배분후"}
borderstyle borderstyle = stylelowered!
end type

type cb_stop from commandbutton within w_bpm406c
integer x = 3538
integer y = 36
integer width = 293
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정"
end type

event clicked;f_bpm_job_stop(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm406c',g_s_empno,'C','재료비 생성 확정작업')

parent.PostEvent('ue_postopen')
end event

type cb_go from commandbutton within w_bpm406c
integer x = 3881
integer y = 36
integer width = 320
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정취소"
end type

event clicked;f_bpm_job_go(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm406c',g_s_empno,'C','재료비 생성 확정취소작업')

parent.PostEvent('ue_postopen')
end event

type gb_1 from groupbox within w_bpm406c
integer x = 27
integer width = 2578
integer height = 148
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_bpm406c
integer x = 2633
integer width = 1605
integer height = 148
integer taborder = 40
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

