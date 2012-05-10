$PBExportHeader$w_bpm405b.srw
$PBExportComments$BOM������ �����۾�
forward
global type w_bpm405b from w_ipis_sheet01
end type
type uo_year from uo_ccyy_mps within w_bpm405b
end type
type dw_bpm405b_01 from u_vi_std_datawindow within w_bpm405b
end type
type st_1 from statictext within w_bpm405b
end type
type pb_down from picturebutton within w_bpm405b
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm405b
end type
type cbx_dvsn from checkbox within w_bpm405b
end type
type uo_2 from u_bpm_select_arev within w_bpm405b
end type
type st_2 from statictext within w_bpm405b
end type
type ddlb_gubun from dropdownlistbox within w_bpm405b
end type
type cb_stop from commandbutton within w_bpm405b
end type
type cb_go from commandbutton within w_bpm405b
end type
type st_3 from statictext within w_bpm405b
end type
type dw_bpm405b_02 from u_vi_std_datawindow within w_bpm405b
end type
type st_4 from statictext within w_bpm405b
end type
type pb_down2 from picturebutton within w_bpm405b
end type
type gb_1 from groupbox within w_bpm405b
end type
type gb_2 from groupbox within w_bpm405b
end type
end forward

global type w_bpm405b from w_ipis_sheet01
integer width = 4453
integer height = 2088
boolean minbox = true
uo_year uo_year
dw_bpm405b_01 dw_bpm405b_01
st_1 st_1
pb_down pb_down
uo_1 uo_1
cbx_dvsn cbx_dvsn
uo_2 uo_2
st_2 st_2
ddlb_gubun ddlb_gubun
cb_stop cb_stop
cb_go cb_go
st_3 st_3
dw_bpm405b_02 dw_bpm405b_02
st_4 st_4
pb_down2 pb_down2
gb_1 gb_1
gb_2 gb_2
end type
global w_bpm405b w_bpm405b

on w_bpm405b.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.dw_bpm405b_01=create dw_bpm405b_01
this.st_1=create st_1
this.pb_down=create pb_down
this.uo_1=create uo_1
this.cbx_dvsn=create cbx_dvsn
this.uo_2=create uo_2
this.st_2=create st_2
this.ddlb_gubun=create ddlb_gubun
this.cb_stop=create cb_stop
this.cb_go=create cb_go
this.st_3=create st_3
this.dw_bpm405b_02=create dw_bpm405b_02
this.st_4=create st_4
this.pb_down2=create pb_down2
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.dw_bpm405b_01
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.cbx_dvsn
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.ddlb_gubun
this.Control[iCurrent+10]=this.cb_stop
this.Control[iCurrent+11]=this.cb_go
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.dw_bpm405b_02
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.pb_down2
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
end on

on w_bpm405b.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.dw_bpm405b_01)
destroy(this.st_1)
destroy(this.pb_down)
destroy(this.uo_1)
destroy(this.cbx_dvsn)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.ddlb_gubun)
destroy(this.cb_stop)
destroy(this.cb_go)
destroy(this.st_3)
destroy(this.dw_bpm405b_02)
destroy(this.st_4)
destroy(this.pb_down2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_bpm405b_01.Width = newwidth / 2 	- ( ls_gap * 3 )
dw_bpm405b_01.Height= newheight - ( dw_bpm405b_01.y + ls_status )

dw_bpm405b_02.x = dw_bpm405b_01.x + dw_bpm405b_01.Width + ls_split
dw_bpm405b_02.Width = dw_bpm405b_01.Width
dw_bpm405b_02.Height = dw_bpm405b_01.Height

st_4.x = dw_bpm405b_02.x
pb_down2.x = dw_bpm405b_02.x + st_4.Width + (ls_split * 2)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_bpm405b_01.settransobject(sqlca)
dw_bpm405b_02.settransobject(sqlca)

string ls_refyear, ls_taskstatus, ls_message, ls_revno

ls_message = Right(Message.StringParm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(True,  False,  False,  False,  False,      & 
			     False,  False,    False)

if f_bpm_check_ingflag(ls_refyear,ls_revno,'w_bpm405b') = 'C' then	
	cb_stop.enabled = False
	cb_go.enabled = False
else
	if f_bpm_check_jobemp(ls_refyear,ls_revno,'w_bpm405b',g_s_empno) <> -1 then
		SELECT TASKSTATUS INTO :ls_taskstatus 
		FROM PBBPM.BPM519
		WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND 
				REVNO = :ls_revno AND WINDOWID = 'w_bpm405b'
		using sqlca;
		
		if ls_taskstatus = 'C' then
			cb_stop.enabled = False
			cb_go.enabled = True
		else
			// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
			wf_icon_onoff(True,  True,  True,  True,  False,      & 
					  False,  False,    False)
			cb_stop.enabled = True
			cb_go.enabled = False
		end if
	else
		cb_stop.enabled = False
		cb_go.enabled = False
	end if
end if

if f_spacechk(ls_refyear) = -1 then
	ls_refyear = mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)
	uo_year.uf_reset(integer(ls_refyear))
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

event ue_retrieve;call super::ue_retrieve;string ls_parm, ls_itno, ls_plant, ls_div, ls_pdcd, ls_year, ls_revno
string ls_divcode, ls_expcode, ls_applydate
ls_parm  = uo_1.uf_Return()

ls_plant = trim(mid(ls_parm,1,1))
ls_div   = trim(mid(ls_parm,2,1))
ls_pdcd  = trim(mid(ls_parm,3,2))
ls_year  = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

//BOM���� �������� ��������
SELECT Jobstart INTO :ls_applydate
FROM PBBPM.BPM519
WHERE COMLTD = :g_s_company AND XYEAR = :ls_year AND 
		REVNO = :ls_revno AND Windowid = 'w_bpm407c'
using sqlca;

if f_dateedit(ls_applydate) = space(8) then
	uo_status.st_message.text = "BOM�������ڰ� �߸� �Ǿ����ϴ�."
	return 0
end if

if ddlb_gubun.text = '�����' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'J'  // 10/06 ǰ�� ������
end if

ls_plant = ls_plant + '%'
ls_div   = ls_div + '%'
ls_pdcd  = ls_pdcd + '%'

dw_bpm405b_01.reset()
dw_bpm405b_02.reset()
if dw_bpm405b_01.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd) > 0 then
	uo_status.st_message.text = "������������ ��ȸ�Ǿ����ϴ�."
else
	uo_status.st_message.text = "��ȸ�� ������������ �����ϴ�."
end if

dw_bpm405b_02.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_applydate)

return 0
end event

event ue_insert;call super::ue_insert;string ls_year, ls_applydate, ls_divcode, ls_expcode, ls_revno
string ls_parm, ls_plant, ls_div, ls_pdcd
integer li_rtn

uo_status.st_message.text = "������������ ������Դϴ�..."
setpointer(HourGlass!)

ls_parm  = uo_1.uf_Return()

ls_plant = trim(mid(ls_parm,1,1))
ls_div   = trim(mid(ls_parm,2,1))
ls_pdcd  = trim(mid(ls_parm,3,2))

ls_year = uo_year.uf_return()

// ls_divcode 'A' : �����, 'B' : ����� 
//  ls_expcode 'A' : ȣȯ����, ������, 'D' : ȣȯ��ǰ��, �ش����, 'J' : ȣȯ����, �ش����, 10/06����
if ddlb_gubun.text = '�����' then
	ls_divcode = 'B'
	ls_expcode = 'A'
else
	ls_divcode = 'A'
	ls_expcode = 'J'
end if
ls_revno = uo_2.is_uo_revno

//BOM���� �������� ��������
ls_applydate = f_relativedate(g_s_date,1)

if cbx_dvsn.checked then
	// ���庰 ���������� ���
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_div) = -1 then
		uo_status.st_message.text = "���庰 ����������� ���ؼ��� ����,������ ���ùٶ��ϴ�."
		return 0
	else
		li_rtn = MessageBox("Ȯ��", "����:" + ls_plant + ",����:" + ls_div + " �� ���� ������������ �����Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2)
		if li_rtn = 1 then
			uo_status.st_message.text = "������������ ������Դϴ�..."
			setpointer(HourGlass!)
			f_bpm_job_start(ls_year,ls_revno,'w_bpm405b',g_s_empno,'C','����������������� :' + ls_plant + ls_div + ', ���:' + ls_revno + ls_divcode + ls_expcode)
			
			DECLARE sp_bpm_001 PROCEDURE FOR PBBPM.SP_BPM_001  
         	A_COMLTD = :g_s_company,   
         	A_PLANT = :ls_plant,   
         	A_DVSN = :ls_div,   
         	A_XYEAR = :ls_year,   
         	A_APPLYDATE = :ls_applydate,   
         	A_DIVCODE = :ls_divcode,   
         	A_EXPCODE = :ls_expcode,
				A_AREV = :ls_revno,
				A_LASTDATE = :g_s_date,
				A_LASTEMP = :g_s_empno
			using sqlca;
			
			execute sp_bpm_001;
			
			if sqlca.sqlcode < 0 then
				messagebox("��������","��������:" + sqlca.sqlerrtext)
			end if
			f_bpm_job_end(ls_year,ls_revno,'w_bpm405b',g_s_empno,'C','����������������� :' + ls_plant + ls_div)
		end if
	end if	
else
	li_rtn = MessageBox("Ȯ��", "�����忡 ���� ������������ �����Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2)
	if li_rtn = 1 then
		// ������ ������ ��������
		f_bpm_job_start(ls_year,ls_revno,'w_bpm405b',g_s_empno,'C','��������������� ��� :' + ls_revno + ls_divcode + ls_expcode)
		
		DECLARE sp_bpm_002 PROCEDURE FOR PBBPM.SP_BPM_002  
					A_COMLTD = :g_s_company,   
					A_XYEAR = :ls_year,   
					A_APPLYDATE = :ls_applydate,   
					A_DIVCODE = :ls_divcode,   
					A_EXPCODE = :ls_expcode,
					A_AREV = :ls_revno,
					A_LASTDATE = :g_s_date,
					A_LASTEMP = :g_s_empno
		using sqlca;
		
		execute sp_bpm_002;
		
		if sqlca.sqlcode < 0 then
			messagebox("��������","��������:" + sqlca.sqlerrtext)
		end if
		
		f_bpm_job_end(ls_year,ls_revno,'w_bpm405b',g_s_empno,'C','���������������')
	end if
end if

// �ӽ����� - ��ǰ����ǰ�� ������ ��������
update pbbpm.bpm508
set bprqt = 1000, bprqt1 = 1000
where comltd = :g_s_company and xyear = :ls_year and
  brev = :ls_revno and bgubun = :ls_divcode and bserno = 5 and
  bmdno = 'AS0140' and bprno = 'AS0140' and bchno = 'AS0140'
using sqlca;

update pbbpm.bpm508
set bprqt = 1000, bprqt1 = 1000
where comltd = :g_s_company and xyear = :ls_year and
  brev = :ls_revno and bgubun = :ls_divcode and bserno = 5 and
  bmdno = 'AS0036D' and bprno = 'AS0036D' and bchno = 'AS0036D'
using sqlca;

update pbbpm.bpm508
set bprqt = 1000, bprqt1 = 1000
where comltd = :g_s_company and xyear = :ls_year and
  brev = :ls_revno and bgubun = :ls_divcode and bserno = 5 and
  bmdno = 'AS0032' and bprno = 'AS0032' and bchno = 'AS0032'
using sqlca;

update pbbpm.bpm508
set bprqt = 1000, bprqt1 = 1000
where comltd = :g_s_company and xyear = :ls_year and
  brev = :ls_revno and bgubun = :ls_divcode and bserno = 5 and
  bmdno = 'AS0020' and bprno = 'AS0020' and bchno = 'AS0020'
using sqlca;

this.triggerevent("ue_retrieve")
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm405b
integer height = 88
end type

type uo_year from uo_ccyy_mps within w_bpm405b
integer x = 375
integer y = 52
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

type dw_bpm405b_01 from u_vi_std_datawindow within w_bpm405b
integer x = 27
integer y = 504
integer width = 1906
integer height = 1304
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bpm405b_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_1 from statictext within w_bpm405b
integer x = 82
integer y = 60
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

type pb_down from picturebutton within w_bpm405b
integer x = 832
integer y = 392
integer width = 311
integer height = 104
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

event clicked;f_save_to_excel_number(dw_bpm405b_01)
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm405b
integer x = 9
integer y = 160
integer width = 2569
integer height = 204
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type cbx_dvsn from checkbox within w_bpm405b
integer x = 2702
integer y = 60
integer width = 654
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���庰 ���������"
end type

type uo_2 from u_bpm_select_arev within w_bpm405b
integer x = 823
integer y = 56
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
end type

on uo_2.destroy
call u_bpm_select_arev::destroy
end on

type st_2 from statictext within w_bpm405b
integer x = 1801
integer y = 64
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

type ddlb_gubun from dropdownlistbox within w_bpm405b
integer x = 2135
integer y = 48
integer width = 439
integer height = 324
integer taborder = 30
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

type cb_stop from commandbutton within w_bpm405b
integer x = 3520
integer y = 52
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

event clicked;f_bpm_job_stop(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm405b',g_s_empno,'C','���������� ���� Ȯ���۾�')

parent.PostEvent('ue_postopen')
end event

type cb_go from commandbutton within w_bpm405b
integer x = 3872
integer y = 52
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

event clicked;f_bpm_job_go(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm405b',g_s_empno,'C','���������� Ȯ������۾�')

parent.PostEvent('ue_postopen')
end event

type st_3 from statictext within w_bpm405b
integer x = 27
integer y = 420
integer width = 741
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "BOM ����������"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_bpm405b_02 from u_vi_std_datawindow within w_bpm405b
integer x = 2025
integer y = 504
integer width = 1906
integer height = 1304
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_bpm405b_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_4 from statictext within w_bpm405b
integer x = 2034
integer y = 420
integer width = 1312
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "BOM ���������� �̻��� ����ǰ�� ����"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_down2 from picturebutton within w_bpm405b
integer x = 3557
integer y = 392
integer width = 311
integer height = 104
integer taborder = 30
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

event clicked;f_save_to_excel_number(dw_bpm405b_02)
end event

type gb_1 from groupbox within w_bpm405b
integer x = 27
integer y = 20
integer width = 3360
integer height = 140
integer taborder = 30
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_bpm405b
integer x = 3465
integer y = 20
integer width = 782
integer height = 140
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

