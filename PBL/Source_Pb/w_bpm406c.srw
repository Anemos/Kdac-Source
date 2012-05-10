$PBExportHeader$w_bpm406c.srw
$PBExportComments$���������Ȯ��
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

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_bpm406c_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bpm406c_01.Height= newheight - ( dw_bpm406c_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_bpm406c_01.settransobject(sqlca)

string ls_refyear, ls_taskstatus, ls_message, ls_revno

ls_message = Right(Message.StringParm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
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
			// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
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

ddlb_gubun.text = '�����'

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
	uo_status.st_message.text = "���� �׸��� ��ȸ�Ǿ����ϴ�."
else
	uo_status.st_message.text = "��ȸ�� �����׸��� �����ϴ�."
end if

return 0
end event

event ue_save;call super::ue_save;string ls_message

dw_bpm406c_01.accepttext()

sqlca.AutoCommit = False

if dw_bpm406c_01.modifiedcount() > 0 or dw_bpm406c_01.deletedcount() > 0 then
	if dw_bpm406c_01.update() = 1 then
		ls_message = '����Ǿ����ϴ�.'
	else
		ls_message = '�����߿� ������ �߻��Ͽ����ϴ�.'
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
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���س⵵"
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
string facename = "���� ���"
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
string facename = "����ü"
string text = "�˻�"
end type

event clicked;string ls_year, ls_revno, ls_divcode, ls_expcode

uo_status.st_message.text = "������ǰ�� ���� �˻����Դϴ�..."
setpointer(HourGlass!)

ls_year  = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

if ddlb_gubun.text = '�����' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

f_bpm_job_start(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','���� �����˻�')

UPDATE PBBPM.BPM512
SET ERRCONFIRM = 'Y'
WHERE XYEAR = :ls_year
using sqlca;

// ����ǰ�� ǰ��⺻���� �̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), AA.AYEAR,AA.AREV,'������ǰ ǰ��⺻���� �̵��',
AA.AMDNO,'','','',AA.APLANT,AA.ADIV,'','',
'','','','','N',''
FROM PBBPM.BPM501 AA
WHERE AA.COMLTD = '01' AND AA.AYEAR = :ls_year AND 
    AA.ACODE = :ls_divcode AND AA.AREV = :ls_revno AND AA.SEQGB <> 'S' AND AA.ATQTY <> 0
AND NOT EXISTS ( SELECT * FROM PBBPM.BPM502 DD
      WHERE AA.AYEAR = DD.XYEAR AND AA.AREV = DD.REVNO AND AA.AMDNO = DD.ITNO )
using sqlca;

if sqlca.sqlcode <> 0 then
	Messagebox("Ȯ��","���� : ������ǰ ǰ��⺻���� �̵��")
end if
// ����ǰ�� ǰ������� �̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), AA.AYEAR,AA.AREV,'������ǰ ǰ������� �̵��',
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
	Messagebox("Ȯ��","���� : ������ǰ ǰ������� �̵��")
end if  
// ������ǰ ǰ��⺻���� �̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'������ǰ ǰ��⺻���� �̵��',
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
	Messagebox("Ȯ��","���� : ������ǰ ǰ��⺻���� �̵��")
end if              
// ������ǰ ǰ������� �̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'������ǰ ǰ������� �̵��',
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
	Messagebox("Ȯ��","���� : ������ǰ ǰ������� �̵��")
end if              
// ������ǰ �ܰ����� �̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'������ǰ �ܰ����� �̵��',
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
	Messagebox("Ȯ��","���� : ������ǰ �ܰ����� �̵��")
end if           
// ���ڴܰ����� 0�� ǰ��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'���ڴܰ����� 0�� ǰ��',
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
	Messagebox("Ȯ��","���� : ���ڴܰ����� 0�� ǰ��")
end if  
// ���ڴܰ����� 0�� ǰ��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'���ڴܰ����� 0�� ǰ��',
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
	Messagebox("Ȯ��","���� : ���ڴܰ����� 0�� ǰ��")
end if   
// ��ȭ���� �̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'��ȭ���� �̵�� ǰ��',
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
	Messagebox("Ȯ��","���� : ��ȭ���� �̵�� ǰ��")
end if

//10/03 ���ǰ�ϼ�ǰ ������ 0�� ǰ��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'���ǰ�ϼ�ǰ ������ 0�� ǰ��',
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

//10/03 ������ǰ �ܰ��̵��
INSERT INTO PBBPM.BPM512
( CHGDATE,XYEAR,REVNO,ERRGUBUN,
ERRMDNO,ERRITNO,ERRCLS,ERRSRCE,ERRPLANT,ERRDIV,ERRVNDSR,ERRCUR,
ERRUNIT1,ERRUNIT2,ERRCHGE,ERRPLAN,ERRCONFIRM,UPDTID )
SELECT DISTINCT CHAR(CURRENT TIMESTAMP), BB.XYEAR,BB.BREV,'10/03 ������ǰ �ܰ����� �̵��',
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

f_bpm_job_end(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','���� �����˻�')

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
string facename = "����ü"
string text = "�������"
end type

event clicked;string ls_year, ls_revno, ls_divcode, ls_expcode, ls_message

uo_status.st_message.text = "���� ������Դϴ�..."
setpointer(HourGlass!)

ls_year  = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

if ddlb_gubun.text = '�����' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'J'
end if
f_bpm_job_start(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','���� ���� ���: ' + ls_revno + ls_divcode + ls_expcode)

//// 10/03 ����ǰ �����޿� ���� ������ - ������������ �ּ�ó�� 2011.02.25
//if f_bpm_create_wipitem_bpm509(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
//	uo_status.st_message.text = ls_message
//	return -1
//end if

if ls_year = '2012' and (ls_revno = '0W' or ls_revno = '0X' or ls_revno = '0V') then
	// BOM��ȸ ���̺� ����Ÿ ����( ������ ���� )
	if f_bpm_create_bpm514_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	
	// BOM��ȸ ���̺� ����Ÿ ����( ��޿ϼ�ǰ�ܰ� ���� )
	if f_bpm_create_bpm514a_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	
	// ��ǰ������ ����Ÿ���� ( ������ ���� )
	if f_bpm_create_bpm515_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	
	// ��ǰ������ ����Ÿ���� ( ��޿ϼ�ǰ �ܰ� ���� )
	if f_bpm_create_bpm515a_tax(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
		uo_status.st_message.text = ls_message
		return -1
	end if
	f_bpm_job_end(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','���� ���� �Ϸ�')
	uo_status.st_message.text = "����ǰ �������� �Ϸ�Ǿ����ϴ�."
	return 0
end if
// BOM��ȸ ���̺� ����Ÿ ����( ������ ���� )
if f_bpm_create_bpm514(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// BOM��ȸ ���̺� ����Ÿ ����( ��޿ϼ�ǰ�ܰ� ���� )
if f_bpm_create_bpm514a(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// ��ǰ������ ����Ÿ���� ( ������ ���� )
if f_bpm_create_bpm515(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// ��ǰ������ ����Ÿ���� ( ��޿ϼ�ǰ �ܰ� ���� )
if f_bpm_create_bpm515a(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

//ǰ�� ����(��ȹ��) ����
if f_bpm_create_bpm516(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

// ǰ�� ����(��ȹ��_������ȭ) ����
if f_bpm_create_bpm516b(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

//ǰ�� ����(������) ����
if f_bpm_create_bpm517(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

//ǰ�� ����(������_����) ����
if f_bpm_create_bpm518(g_s_company,ls_year,ls_revno,ls_divcode,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return -1
end if

f_bpm_job_end(ls_year,ls_revno,'w_bpm406c',g_s_empno,'C','���� ���� �Ϸ�')
uo_status.st_message.text = "����� �Ϸ�Ǿ����ϴ�."
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
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "��α���:"
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
string facename = "����ü"
long textcolor = 33554432
string item[] = {"�����","�����"}
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
string facename = "����ü"
string text = "Ȯ��"
end type

event clicked;f_bpm_job_stop(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm406c',g_s_empno,'C','���� ���� Ȯ���۾�')

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
string facename = "����ü"
string text = "Ȯ�����"
end type

event clicked;f_bpm_job_go(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm406c',g_s_empno,'C','���� ���� Ȯ������۾�')

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
string facename = "���� ���"
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
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
end type

