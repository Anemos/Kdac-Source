$PBExportHeader$w_bpm301u.srw
$PBExportComments$�����ȹ�ܰ����
forward
global type w_bpm301u from w_origin_sheet09
end type
type tab_1 from tab within w_bpm301u
end type
type tabpage_1 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_10 from commandbutton within tabpage_1
end type
type st_13 from statictext within tabpage_1
end type
type st_12 from statictext within tabpage_1
end type
type st_11 from statictext within tabpage_1
end type
type st_10 from statictext within tabpage_1
end type
type cb_nothing from commandbutton within tabpage_1
end type
type cb_4 from commandbutton within tabpage_1
end type
type cb_7 from commandbutton within tabpage_1
end type
type cb_6 from commandbutton within tabpage_1
end type
type cb_xstop from commandbutton within tabpage_1
end type
type st_9 from statictext within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_10 from datawindow within tabpage_1
end type
type dw_11 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_1 cb_1
cb_10 cb_10
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
cb_nothing cb_nothing
cb_4 cb_4
cb_7 cb_7
cb_6 cb_6
cb_xstop cb_xstop
st_9 st_9
st_8 st_8
cb_5 cb_5
st_4 st_4
cb_3 cb_3
cb_2 cb_2
st_2 st_2
st_1 st_1
dw_10 dw_10
dw_11 dw_11
end type
type tabpage_2 from userobject within tab_1
end type
type st_15 from statictext within tabpage_2
end type
type st_14 from statictext within tabpage_2
end type
type st_7 from statictext within tabpage_2
end type
type st_6 from statictext within tabpage_2
end type
type dw_20 from datawindow within tabpage_2
end type
type dw_21 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_15 st_15
st_14 st_14
st_7 st_7
st_6 st_6
dw_20 dw_20
dw_21 dw_21
end type
type tabpage_3 from userobject within tab_1
end type
type cb_8 from commandbutton within tabpage_3
end type
type dw_prt from datawindow within tabpage_3
end type
type dw_31 from datawindow within tabpage_3
end type
type dw_30 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_8 cb_8
dw_prt dw_prt
dw_31 dw_31
dw_30 dw_30
end type
type tabpage_4 from userobject within tab_1
end type
type dw_41 from datawindow within tabpage_4
end type
type dw_40 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_41 dw_41
dw_40 dw_40
end type
type tabpage_5 from userobject within tab_1
end type
type cb_9 from commandbutton within tabpage_5
end type
type st_5 from statictext within tabpage_5
end type
type dw_50 from datawindow within tabpage_5
end type
type st_3 from statictext within tabpage_5
end type
type dw_51 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_9 cb_9
st_5 st_5
dw_50 dw_50
st_3 st_3
dw_51 dw_51
end type
type tabpage_6 from userobject within tab_1
end type
type dw_61 from datawindow within tabpage_6
end type
type dw_60 from datawindow within tabpage_6
end type
type pb_1 from picturebutton within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_61 dw_61
dw_60 dw_60
pb_1 pb_1
end type
type tabpage_7 from userobject within tab_1
end type
type st_17 from statictext within tabpage_7
end type
type st_16 from statictext within tabpage_7
end type
type dw_70 from datawindow within tabpage_7
end type
type dw_71 from datawindow within tabpage_7
end type
type tabpage_7 from userobject within tab_1
st_17 st_17
st_16 st_16
dw_70 dw_70
dw_71 dw_71
end type
type tab_1 from tab within w_bpm301u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
end forward

global type w_bpm301u from w_origin_sheet09
integer width = 4718
integer height = 2772
string title = "��ü�繫�м���������"
event ue_keydown pbm_keydown
event ue_open_after ( )
tab_1 tab_1
end type
global w_bpm301u w_bpm301u

type variables
integer ii_tabindex
String is_year, is_vsrno, is_colnm
datawindowchild idwc_1
window iw_sheet
str_easy	i_str_prt
datawindow idw_10,idw_11,idw_20,idw_21,idw_30, idw_31
datawindow idw_40, idw_41,idw_50,idw_51,idw_60, idw_61, idw_prt
datawindow idw_70, idw_71
end variables

forward prototypes
public subroutine wf_save_tabpage5 ()
public subroutine wf_save_tabpage1 ()
public subroutine wf_insert_tabpage1 ()
public subroutine wf_insert_tabpage2 ()
public subroutine wf_save_tabpage2 ()
public function integer wf_cost_update (string ls_xyear, string ls_revno, string ls_itno)
end prototypes

event ue_keydown;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event ue_open_after();iw_sheet = w_frame.getactivesheet()
idw_30.setfocus()

tab_1.selectedtab = 3  //�ܰ���ȸ����
end event

public subroutine wf_save_tabpage5 ();String ls_xyear, ls_revno, ls_vsrno, ls_itno, ls_itnm, ls_spec, ls_xplant, ls_div, ls_div1, ls_stcd,ls_stcd1
string ls_curr, ls_ychge, ls_ycmcd, ls_msg, ls_jobcode 
string ls_cls,ls_srce,ls_pdcd, ls_bomunit, ls_xunit, ls_xunit1, ls_xplan, ls_ycode, ls_ycode1, ls_ygrad, ls_yalt
string ls_pedtm, ls_pedte, ls_popcd, ls_update
dec    ld_convinv, ld_convpur, ld_convqty, ld_ydper, ld_yeper
dec    ld_ycstd, ld_ycste, ld_ygcst, ld_dcost
dec    ld_ycstr , ld_ycstc1
long ll_row, ll_rcnt, ll_rtn


setpointer(hourglass!)
if idw_50.AcceptText() = -1 then
	messagebox('Ȯ��','�����ȹ ���س⵵�� �������� ������ �����ϼ���!')
	uo_status.st_message.text = '�����ȹ ���س⵵�� �������� ������ �����ϼ���!'
	return
end if
ls_xyear = trim(idw_50.object.xyear[1])
ls_revno = trim(idw_50.object.revno[1])
if idw_51.AcceptText() = -1 then
	messagebox('Ȯ��','����ȭ�鳻�� �������� ������ �����ϼ���!')
	uo_status.st_message.text = '����ȭ�鳻�� �������� ������ �����ϼ���!'
	return
end if
if idw_51.rowcount() = 0 then
	messagebox('Ȯ��','������ �ڷᰡ �����ϴ�!')
	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�!'
	return
end if

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

uo_status.st_message.text = '������ �ڷḦ Ȯ����....'
f_null_chk(idw_51)

for ll_row = 1 to idw_51.rowcount()
	ls_itno   = trim(idw_51.object.yitno[ll_row])
	ls_xplant = trim(idw_51.object.yplant[ll_row])
	ls_div    = trim(idw_51.object.ydiv[ll_row])
	ls_vsrno  = trim(idw_51.object.yvndsr[ll_row])
	ls_xplan  = trim(idw_51.object.yplan[ll_row])
	ls_ychge  = trim(idw_51.object.ychge[ll_row])      //CD����
	ls_ycode1  = trim(idw_51.object.ycode1[ll_row])   //ǰ�񱸺�
//	ls_ycmcd = trim(idw_51.object.ycmcd[ll_row])
	ld_ycstr  =  idw_51.object.ycstr[ll_row]
	ld_ycstc1  =  idw_51.object.ycstc1[ll_row]   //���ű��شܰ�
	if ld_ycstc1 = 0 then
		ld_ycstc1 = ld_ycstr
	end if
	ld_ygcst  =  idw_51.object.ygcst[ll_row]
	
	uo_status.st_message.text = '��:' + string(ll_row) + ' �� �ڷḦ Ȯ����....'
	idw_51.scrolltorow(ll_row)
	idw_51.SelectRow(0,False)
   idw_51.SelectRow(ll_row,True)
//	////�⵵/��ü/ǰ�� ����ũ.
//	SELECT count(*)
//	INTO :ll_row  
//	FROM pbbpm.bpm509  
//	WHERE yccyy = :ls_xyear
//	and   yitno = :ls_itno
//	and   yvndsr = :ls_vsrno
//	//and   yplant = :ls_xplant
//	//and   ydiv = :ls_div
//	and   ygubun = '10';
//	if ll_row > 0 then
//		idw_51.retrieve(ls_xyear,ls_itno,ls_vsrno,'','','10')
//		messagebox('Ȯ��','��:' + string(ll_row) + ' �⵵/��ü/ǰ��������� �̹� �Էµ� ǰ���Դϴ�!')
//		uo_status.st_message.text = '��:' + string(ll_row) + ' �⵵/��ü/ǰ��������� �̹� �Էµ� ǰ���Դϴ�!'
//		return
//	end if
	select count(*) into :ll_rcnt
	from  pbpur.pur101
	where comltd = '01'
	and   scgubun = 'S'
	and   digubun = 'D'
	and   vsrno = :ls_vsrno;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ��ü�ڵ� Ȯ���ϼ���. ��ü�⺻����(PUR101)����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ��ü�ڵ� Ȯ���ϼ���. ��ü�⺻����(PUR101)����!'
		return
	end if
	if trim(ls_xplant) = '' or trim(ls_div) = '' then
		messagebox('Ȯ��','��:' + string(ll_row) + ' �Է½� ����,���� �ʼ��Դϴ�!',Exclamation!)
		uo_status.st_message.text = '��:' + string(ll_row) + ' �Է½� ����,���� �ʼ��Դϴ�!'
		return
	end if
	
	SELECT count(*), coalesce(max(itnm),''),
		 coalesce(max(spec),''),coalesce(max(xunit),'')
	INTO :ll_rcnt, :ls_itnm,:ls_spec,:ls_bomunit  
	FROM pbbpm.bpm502  
	WHERE xyear = :ls_xyear
	and   revno = :ls_revno
	and   itno = :ls_itno;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' �����ȹ ǰ��⺻����(BPM502)����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' �����ȹ ǰ��⺻����(BPM502)����!'
		return
	end if
	////�����ȹǰ������� Ȯ��
	SELECT count(*), coalesce(max(cls),''),
			 coalesce(max(srce),''),coalesce(max(pdcd),''),
			 coalesce(max(xunit),''),
			 coalesce(max(convqty),0),coalesce(max(comcd),'')
	INTO :ll_rcnt, :ls_cls,:ls_srce,:ls_pdcd,
		  :ls_xunit,:ld_convqty,:ls_ycmcd   
	FROM pbbpm.bpm503  
	WHERE xyear = :ls_xyear
	and   revno = :ls_revno
	and   xplant = :ls_xplant
	and   div = :ls_div
	and   itno = :ls_itno;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!'
		return
	end if
	if ls_srce = '01' then
		messagebox('Ȯ��','��:' + string(ll_row) + ' �ش�ǰ���� ���ڷ� ��ϵǾ� �ֽ��ϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' �ش�ǰ���� ���ڷ� ��ϵǾ� �ֽ��ϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!'
		return
	end if
//	////�����ȹBOM��Ͽ���	
//	SELECT count(*),coalesce(max(pedtm),''),coalesce(max(pedte),''),
//			 coalesce(max(popcd),'')
//	INTO :ll_rcnt,:ls_pedtm,:ls_pedte,:ls_popcd
//	FROM pbbpm.bpm504  
//	WHERE pcmcd = '01'
//	and   xyear = :ls_xyear
//	and   plant = :ls_xplant
//	and   pdvsn = :ls_div
//	and   (ppitn = :ls_itno or pcitn = :ls_itno)	;
//	if ll_rcnt = 0 then
//		messagebox('Ȯ��','��:' + string(ll_row) + ' �����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!')
//		uo_status.st_message.text = '��:' + string(ll_row) + ' �����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!'
//		return
//	end if
	SELECT count(*)
	INTO :ll_rcnt
	FROM pbbpm.bpm508  
	WHERE comltd = '01'
	and   xyear = :ls_xyear
	and   brev = :ls_revno
//	and   bplant = :ls_xplant
//	and   bdiv = :ls_div
	//AND  bfmdt = '' OR bfmdt <= :g_s_date  
	//AND  btodt = '' OR btodt >= :g_s_date   
	and  (bprno = :ls_itno or bchno = :ls_itno)	;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','�����ȹBOM�������� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM������ ����(BPM508)����!')
		uo_status.st_message.text = '�����ȹBOM�������� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM������ ����(BPM508)����!'
		return
	end if
	
	SELECT COUNT(*)
		INTO :ll_rcnt  
	FROM PBBPM.BPM503
	WHERE xyear = :ls_xyear  
	and   revno = :ls_revno
	  AND XPLANT = :ls_xplant
	  AND DIV    = :ls_div
	  AND ITNO   = :ls_itno
	USING SQLCA;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!'
		return
	end if
//***���Ŵ��
	SELECT COUNT(*)
		INTO :ll_rcnt  
	FROM PBcommon.dac002
	WHERE comltd  = '01'
	  AND cogubun = 'INV050'   //����,����,���ְ��ߴ��
	  AND cocode  = :ls_xplan;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ���Ŵ���ڵ� Ȯ���ϼ���! ��Ͼȵ��ڵ�.')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ���Ŵ���ڵ� Ȯ���ϼ���! ��Ͼȵ��ڵ�.'
		return
	end if
//***CD����	
	SELECT COUNT(*)
		INTO :ll_rcnt  
	FROM PBcommon.dac002
	WHERE comltd  = '01'
	  AND cogubun = 'BPM030'
	  AND cocode  = :ls_ychge;

	if ls_ychge <> '' and ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' CD�����ڵ� Ȯ���ϼ���! ��Ͼȵ��ڵ�.')
		uo_status.st_message.text = '��:' + string(ll_row) + ' CD�����ڵ� Ȯ���ϼ���! ��Ͼȵ��ڵ�.'
		return
	end if
//***������ǰ�񱸺�	
	SELECT COUNT(*)
		INTO :ll_rcnt  
	FROM PBcommon.dac002
	WHERE comltd  = '01'
	  AND cogubun = 'BPM040'
	  AND cocode  = :ls_ycode1;
		if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ǰ�񱸺��� Ȯ���ϼ���! ��Ͼȵ��ڵ�.')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ǰ�񱸺��� Ȯ���ϼ���! ��Ͼȵ��ڵ�.'
		return
	end if	
//****************�����ȹ�ܰ�Ȯ��	
	SELECT count(*),coalesce(max(ycstr),0)
	INTO :ll_rcnt, :ld_dcost 
	FROM pbbpm.bpm509  
	WHERE yccyy = :ls_xyear
	and   revno = :ls_revno
	and   yitno = :ls_itno
	and   yvndsr = :ls_vsrno
	//and   yplant = :ls_xplant
	//and   ydiv = :ls_div
	and   ygubun = '10';
	if ll_rcnt = 0 and ls_ycode1 = '3' Then
		 messagebox('Ȯ��','��:' + string(ll_row) + ' ��������� �ڷḦ Ȯ���ϼ���. ��ü/ǰ��ܰ������� �����ϴ�!')
		 uo_status.st_message.text = '��:' + string(ll_row) + ' ��������� �ڷḦ Ȯ���ϼ���. ��ü/ǰ��ܰ������� �����ϴ�!'
		 return
	end if
	if ll_rcnt > 0 and ls_ycode1 = '5' Then
		 messagebox('Ȯ��','��:' + string(ll_row) + ' �̹� ��ü/ǰ��ܰ������� �ֽ��ϴ�! ǰ�񱸺м����ϼ���.')
		 uo_status.st_message.text = '��:' + string(ll_row) + ' �̹� ��ü/ǰ��ܰ������� �ֽ��ϴ�! ǰ�񱸺м����ϼ���.'
		 return
	end if
	if ld_ycstr <= 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ���شܰ��� �Է��ϼ���!',Exclamation!)
		uo_status.st_message.text = '��:' + string(ll_row) + ' ���شܰ��� �Է��ϼ���!'
		return
	end if
	if ll_rcnt = 0 and ld_ycstc1 <= 0 then //�ű��Է� �϶� ���ű��شܰ� �־�� �Ѵ�.
		messagebox('Ȯ��','��:' + string(ll_row) + ' ���ű��شܰ��� �Է��ϼ���!',Exclamation!)
		uo_status.st_message.text = '��:' + string(ll_row) + ' ���ű��شܰ��� �Է��ϼ���!'
		return
	end if
//	if f_pur040_mandchk03(idw_51) = -1 then return
	
next

ll_rtn = MessageBox("Ȯ��","�ش� �ڷḦ Ȯ���մϴ�. Ȯ�ι�ư�� ��������!", + &
							 Exclamation!, OKCancel!, 2)
IF ll_rtn = 2 Then
  uo_status.st_message.text	=  f_message("D030")	 						  
  return
end if

uo_status.st_message.text = '�ڷ� Ȯ�οϷ�.  �ڷ� �����غ���....'
sqlca.autocommit = false

for ll_row = 1 to idw_51.rowcount()
	ls_itno   = trim(idw_51.object.yitno[ll_row])
	ls_xplant = trim(idw_51.object.yplant[ll_row])
	ls_div    = trim(idw_51.object.ydiv[ll_row])
	ls_vsrno  = trim(idw_51.object.yvndsr[ll_row])
	ls_xplan  = trim(idw_51.object.yplan[ll_row])
	ls_ychge  = trim(idw_51.object.ychge[ll_row])      //CD����
	ls_ycode1  = trim(idw_51.object.ycode1[ll_row])   //ǰ�񱸺�
	if ls_ycode1 = '3' then  //����ǰ
		ls_ygrad = '9'
	else
		ls_ygrad = ''
	end if
//	ls_ycmcd = trim(idw_51.object.ycmcd[ll_row])
	ld_ycstr  =  idw_51.object.ycstr[ll_row]
	ld_ycstc1  =  idw_51.object.ycstc1[ll_row]   //���ű��شܰ�
	if ld_ycstc1 = 0 then
		ld_ycstc1 = ld_ycstr
	end if
	ld_ygcst  =  idw_51.object.ygcst[ll_row]
	
	uo_status.st_message.text = '��:' + string(ll_row) + ' �� �ڷḦ ������....'
	idw_51.scrolltorow(ll_row)
	idw_51.SelectRow(0,False)
   idw_51.SelectRow(ll_row,True)
	
	
	////ǰ��⺻���� Ȯ��
	SELECT count(*), coalesce(max(itnm),''),
		 coalesce(max(spec),''),coalesce(max(xunit),'')
	INTO :ll_rcnt, :ls_itnm,:ls_spec,:ls_bomunit  
	FROM pbbpm.bpm502  
	WHERE xyear = :ls_xyear
	and   revno = :ls_revno
	and   itno = :ls_itno;
	////�����ȹǰ������� Ȯ��
	SELECT count(*), coalesce(max(cls),''),
			 coalesce(max(srce),''),coalesce(max(pdcd),''),
			 coalesce(max(xunit),''),
			 coalesce(max(convqty),0),coalesce(max(comcd),'')
	INTO :ll_rcnt, :ls_cls,:ls_srce,:ls_pdcd,
		  :ls_xunit,:ld_convqty,:ls_ycmcd   
	FROM pbbpm.bpm503  
	WHERE xyear = :ls_xyear
	and   revno = :ls_revno
	and   xplant = :ls_xplant
	and   div = :ls_div
	and   itno = :ls_itno;
	
	
	ld_CONVinv = ld_convqty
	ld_CONVPUR = 1
	////����,����δ����
	ls_curr = 'KRW'
	ld_ydper = 0
	ld_yeper = 0
	
	ld_ycstd = ld_ycstr  //��ȯ�ܰ�
	ld_ycste = ld_ycstr  //��ȯ�ܰ�
   ls_ycode = ''      //���ڼ�������
   ls_xunit1 = ls_xunit

   if ls_xplant = 'Y' then                    //���ֿ�
		f_pur040_setxplan1(ls_itno,ls_xplan)
	else
		f_pur040_setxplan(ls_itno,ls_xplan)
	end if
	//�����ȹǰ���
	update pbbpm.bpm503
		set xplan = :ls_xplan
	where xyear = :ls_xyear
	and   revno = :ls_revno
	and   itno = :ls_itno;
   
   ////�⵵/��ü/ǰ�� ����ũ.
	SELECT count(*),coalesce(max(ycstr),0)
	INTO :ll_rcnt, :ld_dcost 
	FROM pbbpm.bpm509  
	WHERE yccyy = :ls_xyear
	and   revno = :ls_revno
	and   yitno = :ls_itno
	and   yvndsr = :ls_vsrno
	//and   yplant = :ls_xplant
	//and   ydiv = :ls_div
	and   ygubun = '10';
	ls_update = 'Y'
	if ll_rcnt = 1 and ls_ycode1 = '3' then  //����ǰ�̸鼭 �ܰ� 1��
	   ls_update = 'N'
   end if
	if ll_rcnt > 0 then  //����,  ���ű��شܰ� ��������. �����۾�
	   update pbbpm.bpm509
		   set ygrad = :ls_ygrad,
			    ycstr = :ld_ycstr,
			    ycstd = :ld_ycstd,
				 ycste = :ld_ycste,
//				 ydper = :ld_ydper,
//				 yeper = :ld_yeper,
				 ygcst = :ld_ygcst,
				 ychge = :ls_ychge,
				 ycode1 = :ls_ycode1, 
				 yplan = :ls_xplan,
				 ycmcd = :ls_ycmcd,
				 yredt = :g_s_date,
				 updtid = :g_s_empno,
				 updtdt = :g_s_datetime
		where yccyy = :ls_xyear
		and   revno = :ls_revno
		and   yitno = :ls_itno
		and   yvndsr = :ls_vsrno;
		IF sqlca.sqlnrows <= 0 THEN  ////����� ������ �޴� ���� ��
			uo_status.st_message.text	=  '��:' + string(ll_row) + ' �����ȹ�ܰ�(BPM509)���� ������ �����߻�!. ���� �����ٶ��ϴ�!'
			MessageBox("Ȯ��",'��:' + string(ll_row) + ' �����ȹ�ܰ�(BPM509)���� ������ �����߻�!. ���� �����ٶ��ϴ�!')
			messagebox('Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
			Rollback Using sqlca;
			sqlca.autocommit = true
			Return
		end if	
		if ls_update = 'Y' then  //1���ܰ� ������ ������
			wf_cost_update(ls_xyear,ls_revno, ls_itno)
		end if
		ld_dcost = idw_21.GetItemNumber(1,'ycstr',Primary!,true)
		ls_jobcode = 'S'
		ls_msg = 'ǰ��:' + ls_itno + ' ��ü:' + ls_vsrno + ' �ܰ�:' + string(ld_dcost) + ' ���ε��۾����� ������'
		f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,ls_jobcode,ls_msg)
		continue
   end if
	////�ű��Է�
	insert into pbbpm.bpm509
	(YCCYY,         revno,           YITNO,          YVNDSR,         YPLANT,            YDIV,   
    YGUBUN,        YGRAD,           YSRCE,          YPLAN,            YCLSB,   
    YPDCD,         BOMUNIT,         XUNIT,         XUNIT1,           CONVINV,   
    CONVPUR,       CONVQTY,         YCHGE,          YCURR,           YCSTC,   
    YADJDT,        YCSTR,           YCSTD,   
    YCSTE,         YGCST,           YCODE,          YALT,            YEXPT,   
    YCODE1,        YCMCD,           YDATE,          YREDT,           UPDTID,   
    UPDTDT,        CRTDT,           ycstc1) 
    values
	 (:ls_xyear,        :ls_revno,           :ls_ITNO,            :ls_vsrno,          :ls_xPLANT,          :ls_DIV,   
    '10',              :ls_ygrad,           :ls_SRCE,           :ls_xPLAN,           :ls_CLS,   
    :ls_PDCD,          :ls_BOMUNIT,         :ls_XUNIT,          :ls_XUNIT1,          :ld_CONVINV,   
    :ld_CONVPUR,       :ld_CONVQTY,         :ls_YCHGE,          :ls_CURR,            0,   
    '',                :ld_YCSTR,           :ld_YCSTD,   
    :ld_YCSTE,         :ld_YGCST,           :ls_YCODE,          :ls_YALT,            '',   
    :ls_YCODE1,        :ls_YCMCD,           :g_s_DATE,          :g_s_DATE,          :g_s_empno,   
    :g_s_datetime,      '',           :ld_ycstc1) ;
    IF sqlca.sqlcode  <> 0 THEN
		uo_status.st_message.text	=  '��:' + string(ll_row) + ' �����ȹ�ܰ�(BPM509)���� ������ �����߻�!. ���� �����ٶ��ϴ�!'
		MessageBox("Ȯ��",'��:' + string(ll_row) + ' �����ȹ�ܰ�(BPM509)���� ������ �����߻�!. ���� �����ٶ��ϴ�!')
		messagebox('Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		Rollback Using sqlca;
		sqlca.autocommit = true
		Return
	end if	
	wf_cost_update(ls_xyear,ls_revno, ls_itno)
	ld_dcost = ld_YCSTR
	ls_jobcode = 'C'
	ls_msg = 'ǰ��:' + ls_itno + ' ��ü:' + ls_vsrno + ' �ܰ�:' + string(ld_dcost) + ' ���ε��۾����� �Էµ�.'
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,ls_jobcode,ls_msg)
next

Commit Using sqlca;
sqlca.autocommit = true
uo_status.st_message.text = string(idw_51.rowcount()) + '���� �����ȹ�ܰ��� �Է� �Ǵ� �����Ǿ����ϴ�.'
idw_51.Reset()

setpointer(arrow!)
			
	
end subroutine

public subroutine wf_save_tabpage1 ();String ls_xyear, ls_revno, ls_vsrno, ls_xyear1, ls_itno, ls_xplant, ls_div, ls_div1, ls_stcd,ls_stcd1, ls_xplan,ls_jobcode,ls_msg
string ls_curr, ls_xplant_all, ls_div_all, ls_xunit1, ls_xunit2
dec {6} ld_dcost,ld_ecost, ld_convqty
long ll_row, ll_rcnt
String ls_ycmcd

setpointer(hourglass!)
if idw_11.AcceptText() = -1 then
	messagebox('Ȯ��','����ȭ�鳻�� �������� ������ �����ϼ���!')
	uo_status.st_message.text = '����ȭ�鳻�� �������� ������ �����ϼ���!'
	return
end if
if idw_11.rowcount() = 0 then
	messagebox('Ȯ��','������ �ڷᰡ �����ϴ�!')
	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�!'
	return
end if
ls_xyear = trim(idw_11.object.yccyy[1])
ls_revno = trim(idw_11.object.revno[1])

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  and g_s_deptcd <> '2300' THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

ls_xplant = trim(idw_11.object.yplant[1])
ls_div    = trim(idw_11.object.ydiv[1])
ls_itno   = trim(idw_11.object.yitno[1])
ls_vsrno   = trim(idw_11.object.yvndsr[1])

//ls_ycmcd = trim(idw_11.object.ycmcd[1])

SELECT COUNT(*)
	INTO :ll_row  
FROM PBBPM.BPM503
WHERE xyear = :ls_xyear 
  and revno = :ls_revno
  AND XPLANT = :ls_xplant
  AND DIV    = :ls_div
  AND ITNO   = :ls_itno
USING SQLCA;
if ll_row = 0 then
	messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!')
	uo_status.st_message.text = '����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!'
	return
end if
	
////ycode1 ��������.
//IF idw_11.GetItemStatus(1,0,Primary!) <> NewModified!  &
//and idw_11.object.ycode1[1] = '3' Then
//	 messagebox('Ȯ��','�̹� ������ ǰ���Դϴ�!',Exclamation!)
//	 uo_status.st_message.text = '�̹� ������ ǰ���Դϴ�!'
//	 return
//end if
ld_dcost = idw_11.GetItemNumber(1,'ycstr',Primary!,true)
if idw_11.object.ycstr[1] = 0 and trim(idw_11.object.yplan[1]) <> '7E' then
	messagebox('Ȯ��','���شܰ��� �Է��ϼ���!',Exclamation!)
	uo_status.st_message.text = '���شܰ��� �Է��ϼ���!'
	return
end if
//IF idw_11.GetItemStatus(1,0,Primary!) = NewModified! & 
//or idw_11.GetItemStatus(1,'convpur',Primary!) = DataModified! then 
//   ls_xunit1 = trim(idw_11.object.xunit[1])  //������
//	ls_xunit2 = trim(idw_11.object.xunit1[1]) //���Ŵ���
//	ld_convqty = idw_11.object.convpur[1]
//   if f_chk_convfactor(ls_xunit2,ls_xunit1,ld_convqty,ls_msg) = -1 then
//		messagebox('Ȯ��',ls_msg)
//	   uo_status.st_message.text = ls_msg
//		idw_11.object.convpur[1] = ld_convqty
//	   return
//	end if
//end if
if f_pur040_mandchk03(idw_11) = -1 then return
//Save
IF idw_11.GetItemStatus(1,0,Primary!) = NewModified! then
   idw_11.object.ydate[1] = g_s_date
	idw_11.object.yredt[1] = g_s_date
	idw_11.object.ycode1[1] = '5'  //�űԵ��
else
	idw_11.object.yredt[1] = g_s_date
end if
if idw_11.object.ycode1[1] = '3' Then
	idw_11.object.ygrad[1] = '9'
else
	idw_11.object.ygrad[1] = ''
end if
////����,����δ����
idw_11.object.ycurr[1] = 'KRW'
//idw_11.object.ydper[1] = 0
//idw_11.object.yeper[1] = 0

//idw_11.object.ycstd[1] = idw_11.object.ycstr[1]  //��ȯ�ܰ�
//idw_11.object.ycste[1] = idw_11.object.ycstr[1]  //��ȯ�ܰ�

ls_xplan   = trim(idw_11.object.yplan[1])  //���Ŵ�����
if ls_xplan = '7E' then  //������ �ܰ� 0
	idw_11.object.ycstr[1] = 0
end if
if ls_xplant = 'Y' then                    //���ֿ�
	f_pur040_setxplan1(ls_itno,ls_xplan)
else
	f_pur040_setxplan(ls_itno,ls_xplan)
end if
//���� ������
//IF idw_11.GetItemStatus(1,'ycmcd',Primary!) = NewModified! & 
ls_ycmcd   = trim(idw_11.object.ycmcd[1])  
//�����ȹǰ���
update pbbpm.bpm503
   set xplan = :ls_xplan,
	    comcd = :ls_ycmcd
where xyear = :ls_xyear
and   revno = :ls_revno
and   itno = :ls_itno;


f_null_chk(idw_11)
f_pur040_inptid(idw_11)


IF idw_11.GetItemStatus(1,0,Primary!) = NewModified! then
	ld_dcost = idw_11.GetItemNumber(1,'ycstr',Primary!,false)
	ls_jobcode = 'C'
	ls_msg = 'ǰ��:' + ls_itno + ' ��ü:' + ls_vsrno + ' �ܰ�:' + string(ld_dcost) + ' �Էµ�.'
else
	ld_dcost = idw_11.GetItemNumber(1,'ycstr',Primary!,true)
	ls_jobcode = 'S'
	ls_msg = 'ǰ��:' + ls_itno + ' ��ü:' + ls_vsrno + ' �ܰ�:' + string(ld_dcost) + ' ������'
end if

IF idw_11.Update(True,False) = 1 Then		//BPM103	
	Commit Using sqlca;
	//sqlca.autocommit = true
	wf_cost_update(ls_xyear, ls_revno, ls_itno) ////�켱������ ������Ʈ
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,ls_jobcode,ls_msg)
	uo_status.st_message.text = f_message("U010") //����
	idw_11.ResetUpdate()
Else
	Rollback Using sqlca;
	//sqlca.autocommit = true
	uo_status.st_message.text = f_message("U020") //�������
End IF
setpointer(arrow!)
return			
	
end subroutine

public subroutine wf_insert_tabpage1 ();string ls_xyear, ls_revno, ls_xyear_pre, ls_vsrno, ls_itno, ls_itnm, ls_spec,ls_msg 
string ls_xplant, ls_div, ls_stcd,ls_stcd1
string ls_pdcd,ls_srce,ls_cls,ls_bomunit,ls_xunit,ls_xplan,ls_yalt,ls_costdiv,ls_cmcd			
string ls_pedtm,ls_pedte,ls_popcd,ls_pwkct 
string ls_arr
long ll_row, ll_rcnt,ll_rcnt1

dec {5} ld_ecost
dec {2} ld_dcost,ld_gcost
dec {6} ld_convqty

setpointer(hourglass!)
uo_status.st_message.text = '�Է��ڷ� ������....'
if idw_10.accepttext() = -1 then
	messagebox('Ȯ��','�Է������� �������� ������ �Է��ϼ���!')
	uo_status.st_message.text = '�Է������� �������� ������ �Է��ϼ���!'
	return
end if
ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

		
f_pur040_nullchk03(idw_10)
if f_pur040_mandchk03(idw_10) = -1 then return

ls_vsrno  = trim(idw_10.object.vsrno[1])
ls_itno   = trim(idw_10.object.itno[1])
ls_xplant = trim(idw_10.object.xplant[1])
ls_div    = trim(idw_10.object.div[1])

////�⵵/��ü/ǰ��/�� ����ũ.
SELECT count(*)
INTO :ll_row  
FROM pbbpm.bpm509  
WHERE yccyy = :ls_xyear
and   revno = :ls_revno
and   yitno = :ls_itno
and   yvndsr = :ls_vsrno
//and   yplant = :ls_xplant
//and   ydiv = :ls_div
and   ygubun = '10';
if ll_row > 0 then
	idw_11.retrieve(ls_xyear,ls_revno,ls_itno,ls_vsrno,'','','10')
	messagebox('Ȯ��','�⵵/����/�ش��ü/ǰ������ �̹� �Էµ� ǰ���Դϴ�!')
	uo_status.st_message.text = '�⵵/����/�ش��ü/ǰ������ �̹� �Էµ� ǰ���Դϴ�!'
	return
end if

if trim(ls_xplant) = '' or trim(ls_div) = '' then
	messagebox('Ȯ��','�Է½� ����,���� �ʼ��Դϴ�!',Exclamation!)
	uo_status.st_message.text = '�Է½� ����,���� �ʼ��Դϴ�!'
	return
end if
////�����ȹǰ������� Ȯ��
SELECT count(*), coalesce(max(cls),''),
		 coalesce(max(srce),''),coalesce(max(pdcd),''),
		 coalesce(max(xunit),''),coalesce(max(xplan),''),
		 coalesce(max(convqty),0),coalesce(max(comcd),'')
INTO :ll_row, :ls_cls,:ls_srce,:ls_pdcd,
	  :ls_xunit,:ls_xplan,:ld_convqty,:ls_cmcd   
FROM pbbpm.bpm503  
WHERE xyear = :ls_xyear
and   revno = :ls_revno
and   xplant = :ls_xplant
and   div = :ls_div
and   itno = :ls_itno;
if ll_row = 0 then
	messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!')
	uo_status.st_message.text = '����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!'
	return
end if
if ls_srce = '01' then
	messagebox('Ȯ��','�ش�ǰ���� ���ڷ� ��ϵǾ� �ֽ��ϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!')
	uo_status.st_message.text = '�ش�ǰ���� ���ڷ� ��ϵǾ� �ֽ��ϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!'
	return
end if
////�����ȹBOM��Ͽ���	
//SELECT count(*),coalesce(max(pedtm),''),coalesce(max(pedte),''),
//		 coalesce(max(popcd),'')
//INTO :ll_rcnt,:ls_pedtm,:ls_pedte,:ls_popcd
//FROM pbbpm.bpm504  
//WHERE pcmcd = '01'
//and   xyear = :ls_xyear
//and   plant = :ls_xplant
//and   pdvsn = :ls_div
////AND  pEDTM = '' OR pEDTM <= :g_s_date  
////AND  pEDTE = '' OR pEDTE >= :g_s_date   
//and  (ppitn = :ls_itno or pcitn = :ls_itno)	;
//if ll_rcnt = 0 then
//	messagebox('Ȯ��','�����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!')
//	uo_status.st_message.text = '�����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!'
//	return
//end if
SELECT count(*)
INTO :ll_rcnt
FROM pbbpm.bpm508  
WHERE comltd = '01'
and   xyear = :ls_xyear
and   brev = :ls_revno
and   bplant = :ls_xplant
and   bdiv = :ls_div
//AND  bfmdt = '' OR bfmdt <= :g_s_date  
//AND  btodt = '' OR btodt >= :g_s_date   
and  (bprno = :ls_itno or bchno = :ls_itno)	;
if ll_rcnt = 0 then
	messagebox('Ȯ��','�����ȹBOM�������� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM������ ����(BPM508)����!')
	uo_status.st_message.text = '�����ȹBOM�������� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM������ ����(BPM508)����!'
	return
end if


SELECT count(*) 
INTO :ll_rcnt1
FROM pbbpm.bpm504  
WHERE pcmcd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   plant = :ls_xplant
and   pdvsn = :ls_div
and   ppitn = :ls_itno
and   pwkct = '8888';
if ll_rcnt1 > 0 then
	idw_11.object.yysung[1] = 'Y'  //��޿ϼ�ǰ 
end if
SELECT count(*) 
INTO :ll_rcnt1
FROM pbbpm.bpm504  
WHERE pcmcd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   plant = :ls_xplant
and   pdvsn = :ls_div
and   pcitn = :ls_itno
and   pwkct = '8888';
if ll_rcnt1 > 0 then
	idw_11.object.ysakub[1] = 'Y'  //������ǰ
end if


idw_11.Reset()
idw_11.InsertRow(0)
idw_11.object.yccyy[1]  = ls_xyear
idw_11.object.revno[1]  = ls_revno
idw_11.object.yitno[1]  = ls_itno
idw_11.object.yvndsr[1] = ls_vsrno
idw_11.object.yplant[1] = ls_xplant
idw_11.object.ydiv[1]   = ls_div
idw_11.object.ygubun[1]  = '10'

SELECT count(*), coalesce(max(itnm),''),
		 coalesce(max(spec),''),coalesce(max(xunit),'')
INTO :ll_row, :ls_itnm,:ls_spec,:ls_bomunit  
FROM pbbpm.bpm502  
WHERE xyear = :ls_xyear
and   revno = :ls_revno
and   itno = :ls_itno;
idw_11.object.itnm[1]  = ls_itnm		
idw_11.object.spec[1]  = ls_spec	
idw_11.object.bomunit[1]  = ls_bomunit

idw_11.object.yclsb[1] = ls_cls
idw_11.object.ysrce[1] = ls_srce
idw_11.object.ypdcd[1] = ls_pdcd
idw_11.object.xunit[1] = ls_xunit
idw_11.object.xunit1[1] = ls_xunit
idw_11.object.yplan[1] = ls_xplan
idw_11.object.convinv[1] = ld_convqty  //������ȯ����
idw_11.object.convpur[1] = 1           //������ȯ����
idw_11.object.convqty[1] = ld_convqty  //BOM��ȯ����(BOM����<=>���Ŵ���) 
idw_11.object.ycmcd[1] = ls_cmcd    //�����ޱ���Y-����,O-���� 

////BOMȣȯ���� Ȯ��
SELECT count(*)
INTO :ll_row  
FROM PBBPM.BPM505  
WHERE  OCMCD = '01'  
and   xyear = :ls_xyear
and  revno  = :ls_revno
AND  OPLANT = :ls_xplant 
AND  ODVSN = :ls_div 
AND  OPITN = :ls_itno 
AND  (OEDTM = '' OR OEDTM <= :g_s_date)  
AND  (OEDTE = '' OR OEDTE >= :g_s_date)   ;
if ll_row > 0 then //ȣȯ��ǰ�� 
	idw_11.object.yalt[1] = '1'
end if	
SELECT count(*)
INTO :ll_row  
FROM PBBPM.BPM505  
WHERE  OCMCD = '01'  
and   xyear = :ls_xyear
and  revno  = :ls_revno
AND  OPLANT = :ls_xplant 
AND  ODVSN = :ls_div 
AND  OFITN = :ls_itno 
AND  (OEDTM = '' OR OEDTM <= :g_s_date)  
AND  (OEDTE = '' OR OEDTE >= :g_s_date)   ;
if ll_row > 0 then //ȣȯ��ǰ�� 
	idw_11.object.yalt[1] = '2'
else
	idw_11.object.yalt[1] = ' '
end if	
////��޿ϼ�ǰ������
select coalesce(max(gcost),0) into :ld_gcost
from  pbpur.pur103a
where comltd = '01'
and   vsrno = :ls_vsrno
and   itno = :ls_itno;
idw_11.object.ygcst[1] = ld_gcost

idw_11.setfocus()
idw_11.setcolumn('ycstr')
uo_status.st_message.text = '�Է��ϼ���'
wf_icon_onoff(true,true,true,false,false,false,false,true,false)  //I,A,U,D,P
setpointer(arrow!)



end subroutine

public subroutine wf_insert_tabpage2 ();string ls_xyear, ls_revno, ls_xyear_pre, ls_vsrno, ls_itno, ls_itnm, ls_spec,ls_msg 
string ls_xplant, ls_div, ls_stcd,ls_stcd1
string ls_pdcd,ls_srce,ls_cls,ls_bomunit,ls_xunit,ls_xplan,ls_yalt,ls_costdiv,ls_cmcd			
string ls_pedtm,ls_pedte,ls_popcd 
string ls_arr
long ll_row, ll_rcnt, ll_rcnt1

dec {5} ld_ecost
dec {2} ld_dcost,ld_gcost
dec {6} ld_convqty

setpointer(hourglass!)
uo_status.st_message.text = '�Է��ڷ� ������....'
if idw_20.accepttext() = -1 then
	messagebox('Ȯ��','�Է������� �������� ������ �Է��ϼ���!')
	uo_status.st_message.text = '�Է������� �������� ������ �Է��ϼ���!'
	return
end if
ls_xyear = trim(idw_20.object.xyear[1])
ls_revno = trim(idw_20.object.revno[1])

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF
		
f_pur040_nullchk03(idw_20)
if f_pur040_mandchk03(idw_20) = -1 then return

ls_vsrno  = trim(idw_20.object.vsrno[1])
ls_itno   = trim(idw_20.object.itno[1])
ls_xplant = trim(idw_20.object.xplant[1])
ls_div    = trim(idw_20.object.div[1])

////�⵵/��ü/ǰ�� ����ũ.
SELECT count(*)
INTO :ll_row  
FROM pbbpm.bpm509  
WHERE yccyy = :ls_xyear
and   revno = :ls_revno
and   yitno = :ls_itno
and   yvndsr = :ls_vsrno
//and   yplant = :ls_xplant
//and   ydiv = :ls_div
and   ygubun = '10';
if ll_row > 0 then
	idw_21.retrieve(ls_xyear,ls_revno, ls_itno,ls_vsrno,'','','10')
	messagebox('Ȯ��','�̹� �Էµ� ǰ���Դϴ�!',Exclamation!)
	uo_status.st_message.text = ''
	return
end if

if trim(ls_xplant) = '' or trim(ls_div) = '' then
	messagebox('Ȯ��','�Է½� ����,���� �ʼ��Դϴ�!',Exclamation!)
	uo_status.st_message.text = '�Է½� ����,���� �ʼ��Դϴ�!'
	return
end if
////�����ȹǰ������� Ȯ��
SELECT count(*), coalesce(max(cls),''),
		 coalesce(max(srce),''),coalesce(max(pdcd),''),
		 coalesce(max(xunit),''),coalesce(max(xplan),''),
		 coalesce(max(convqty),0),coalesce(max(comcd),'')
INTO :ll_row, :ls_cls,:ls_srce,:ls_pdcd,
	  :ls_xunit,:ls_xplan,:ld_convqty,:ls_cmcd   
FROM pbbpm.bpm503  
WHERE xyear = :ls_xyear
and   revno = :ls_revno
and   xplant = :ls_xplant
and   div = :ls_div
and   itno = :ls_itno;
if ll_row = 0 then
	messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!')
	uo_status.st_message.text = '����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!'
	return
end if
if ls_srce <> '01' then
	messagebox('Ȯ��','�ش�ǰ���� ���ڰ� �ƴմϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!')
	uo_status.st_message.text = '�ش�ǰ���� ���ڰ� �ƴմϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!'
	return
end if
////�����ȹBOM��Ͽ���	
//SELECT count(*),coalesce(max(pedtm),''),coalesce(max(pedte),''),
//		 coalesce(max(popcd),'')
//INTO :ll_row,:ls_pedtm,:ls_pedte,:ls_popcd
//FROM pbbpm.bpm504  
//WHERE pcmcd = '01'
//and   xyear = :ls_xyear
//and   plant = :ls_xplant
//and   pdvsn = :ls_div
//and   (ppitn = :ls_itno or pcitn = :ls_itno)	;
//if ll_row = 0 then
//	messagebox('Ȯ��','�����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!')
//	uo_status.st_message.text = '�����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!'
//	return
//end if
SELECT count(*)
INTO :ll_rcnt
FROM pbbpm.bpm508  
WHERE comltd = '01'
and   xyear = :ls_xyear
and   brev = :ls_revno
and   bplant = :ls_xplant
and   bdiv = :ls_div
//AND  bfmdt = '' OR bfmdt <= :g_s_date  
//AND  btodt = '' OR btodt >= :g_s_date   
and  (bprno = :ls_itno or bchno = :ls_itno)	;
if ll_rcnt = 0 then
	messagebox('Ȯ��','�����ȹBOM�������� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM������ ����(BPM508)����!')
	uo_status.st_message.text = '�����ȹBOM�������� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM������ ����(BPM508)����!'
	return
end if


SELECT count(*) 
INTO :ll_rcnt1
FROM pbbpm.bpm504  
WHERE pcmcd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   plant = :ls_xplant
and   pdvsn = :ls_div
and   ppitn = :ls_itno
and   pwkct = '8888';
if ll_rcnt1 > 0 then
	idw_21.object.yysung[1] = 'Y'  //��޿ϼ�ǰ 
end if
SELECT count(*) 
INTO :ll_rcnt1
FROM pbbpm.bpm504  
WHERE pcmcd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   plant = :ls_xplant
and   pdvsn = :ls_div
and   pcitn = :ls_itno
and   pwkct = '8888';
if ll_rcnt1 > 0 then
	idw_21.object.ysakub[1] = 'Y'  //������ǰ
end if


idw_21.Reset()
idw_21.InsertRow(0)
idw_21.object.yccyy[1]  = ls_xyear
idw_21.object.revno[1]  = ls_revno
idw_21.object.yitno[1]  = ls_itno
idw_21.object.yvndsr[1] = ls_vsrno
idw_21.object.yplant[1] = ls_xplant
idw_21.object.ydiv[1]   = ls_div
idw_21.object.ygubun[1]  = '10'

SELECT count(*), coalesce(max(itnm),''),
		 coalesce(max(spec),''),coalesce(max(xunit),'')
INTO :ll_row, :ls_itnm,:ls_spec,:ls_bomunit  
FROM pbbpm.bpm502  
WHERE xyear = :ls_xyear
and   revno = :ls_revno
and   itno = :ls_itno;
idw_21.object.itnm[1]  = ls_itnm		
idw_21.object.spec[1]  = ls_spec	
idw_21.object.bomunit[1]  = ls_bomunit

idw_21.object.ycurr[1] = 'USD'
idw_21.object.yclsb[1] = ls_cls
idw_21.object.ysrce[1] = ls_srce
idw_21.object.ypdcd[1] = ls_pdcd
idw_21.object.xunit[1] = ls_xunit
idw_21.object.xunit1[1] = ls_xunit
idw_21.object.yplan[1] = ls_xplan
idw_21.object.convinv[1] = ld_convqty  //������ȯ����
idw_21.object.convpur[1] = 1           //������ȯ����
idw_21.object.convqty[1] = ld_convqty  //BOM��ȯ����(BOM����<=>���Ŵ���) 
idw_21.object.ycmcd[1] = ls_cmcd    //�����ޱ���Y-����,O-���� 

////BOMȣȯ���� Ȯ��
SELECT count(*)
INTO :ll_row  
FROM PBBPM.BPM505  
WHERE  OCMCD = '01'  
and   xyear = :ls_xyear
and  revno = :ls_revno
AND  OPLANT = :ls_xplant 
AND  ODVSN = :ls_div 
AND  OPITN = :ls_itno 
AND  (OEDTM = '' OR OEDTM <= :g_s_date)  
AND  (OEDTE = '' OR OEDTE >= :g_s_date)   ;
if ll_row > 0 then //ȣȯ��ǰ�� 
	idw_21.object.yalt[1] = '1'
end if	
SELECT count(*)
INTO :ll_row  
FROM PBBPM.BPM505  
WHERE  OCMCD = '01'  
and   xyear = :ls_xyear
and  revno = :ls_revno
AND  OPLANT = :ls_xplant 
AND  ODVSN = :ls_div 
AND  OFITN = :ls_itno 
AND  (OEDTM = '' OR OEDTM <= :g_s_date)  
AND  (OEDTE = '' OR OEDTE >= :g_s_date)   ;
if ll_row > 0 then //ȣȯ��ǰ�� 
	idw_21.object.yalt[1] = '2'
else
	idw_21.object.yalt[1] = ' '
end if	
////��޿ϼ�ǰ������
select coalesce(max(gcost),0) into :ld_gcost
from  pbpur.pur103a
where comltd = '01'
and   vsrno = :ls_vsrno
and   itno = :ls_itno;
idw_21.object.ygcst[1] = ld_gcost

idw_21.setfocus()
idw_21.setcolumn('ycstr')
uo_status.st_message.text = '�Է��ϼ���'
wf_icon_onoff(true,true,true,false,false,false,false,true,false)  //I,A,U,D,P
setpointer(arrow!)



end subroutine

public subroutine wf_save_tabpage2 ();String ls_xyear, ls_revno, ls_vsrno, ls_xyear1, ls_itno, ls_xplant, ls_div, ls_div1, ls_stcd,ls_stcd1, ls_xplan,ls_msg,ls_jobcode
string ls_curr, ls_xplant_all, ls_div_all,ls_xunit1,ls_xunit2
dec ld_dcost,ld_ecost,ld_convqty
dec {5} ld_dper, ld_eper
long ll_row, ll_rcnt
String ls_ycmcd

setpointer(hourglass!)
if idw_21.AcceptText() = -1 then
	messagebox('Ȯ��','����ȭ�鳻�� �������� ������ �����ϼ���!')
	uo_status.st_message.text = '����ȭ�鳻�� �������� ������ �����ϼ���!'
	return
end if
if idw_21.rowcount() = 0 then
	messagebox('Ȯ��','������ �ڷᰡ �����ϴ�!')
	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�!'
	return
end if
ls_xyear = trim(idw_21.object.yccyy[1])
ls_revno = trim(idw_21.object.revno[1])


IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  and g_s_deptcd <> '2300' THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

ls_xplant = trim(idw_21.object.yplant[1])
ls_div    = trim(idw_21.object.ydiv[1])
ls_itno   = trim(idw_21.object.yitno[1])
ls_vsrno   = trim(idw_21.object.yvndsr[1])
//ls_ycmcd = trim(idw_21.object.ycmcd[1])

SELECT COUNT(*)
	INTO :ll_row  
FROM PBBPM.BPM503
WHERE xyear = :ls_xyear  
  and revno = :ls_revno
  AND XPLANT = :ls_xplant
  AND DIV    = :ls_div
  AND ITNO   = :ls_itno
USING SQLCA;
if ll_row = 0 then
	messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!')
	uo_status.st_message.text = '����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!'
	return
end if
	
////ycode1 ��������.
//IF idw_21.GetItemStatus(1,0,Primary!) <> NewModified!  &
//and idw_21.object.ycode1[1] = '3' Then
//	 messagebox('Ȯ��','�̹� ������ ǰ���Դϴ�!',Exclamation!)
//	 uo_status.st_message.text = '�̹� ������ ǰ���Դϴ�!'
//	 return
//end if
if idw_21.object.ycstr[1] = 0 then
	messagebox('Ȯ��','���شܰ��� �Է��ϼ���!',Exclamation!)
	 uo_status.st_message.text = '���شܰ��� �Է��ϼ���!'
	return
end if

IF idw_21.GetItemStatus(1,0,Primary!) = NewModified! & 
or idw_21.GetItemStatus(1,'convpur',Primary!) = DataModified! then 
   ls_xunit1 = trim(idw_21.object.xunit[1])  //������
	ls_xunit2 = trim(idw_21.object.xunit1[1]) //���Ŵ���
	ld_convqty = idw_21.object.convpur[1]
   if f_chk_convfactor(ls_xunit2,ls_xunit1,ld_convqty,ls_msg) = -1 then
		messagebox('Ȯ��',ls_msg)
	   uo_status.st_message.text = ls_msg
		idw_21.object.convpur[1] = ld_convqty
	   return
	end if
end if

if f_pur040_mandchk03(idw_21) = -1 then return
//Save
IF idw_21.GetItemStatus(1,0,Primary!) = NewModified! then
   idw_21.object.ydate[1] = g_s_date
	idw_21.object.yredt[1] = g_s_date
	idw_21.object.ycode1[1] = '5'  //�űԵ��
else
	idw_21.object.yredt[1] = g_s_date
end if
if idw_21.object.ycode1[1] = '3' Then
	idw_21.object.ygrad[1] = '9'
else
	idw_21.object.ygrad[1] = ''
end if
////����,����δ����
//idw_21.object.ycurr[1] = 'KRW'
//select coalesce(max(dper),0),coalesce(max(eper),0)
//  into :ld_dper, :ld_eper
//from  pbbpm.bpm507
//where  xyear = :ls_xyear
//and   xplant = :ls_xplant;
////and   div    = :ls_div;

//idw_21.object.ydper[1] = ld_dper
//idw_21.object.yeper[1] = ld_eper
//
//idw_21.object.ycstd[1] = idw_21.object.ycstr[1] + idw_21.object.ycstr[1] * ld_dper /100 //��ȯ�ܰ�-����
//idw_21.object.ycste[1] = idw_21.object.ycstr[1] + idw_21.object.ycstr[1] * ld_eper /100 //��ȯ�ܰ�-����

ls_xplan   = trim(idw_21.object.yplan[1])  //���Ŵ�����
//if ls_xplant = 'Y' then                    //���ֿ�
//	f_pur040_setxplan1(ls_itno,ls_xplan)
//else
//	f_pur040_setxplan(ls_itno,ls_xplan)
//end if
ls_ycmcd   = trim(idw_21.object.ycmcd[1]) 
//�����ȹǰ���
update pbbpm.bpm503
   set xplan = :ls_xplan,
	    comcd = :ls_ycmcd
where xyear = :ls_xyear
and   revno = :ls_revno
and   itno = :ls_itno;

IF idw_21.GetItemStatus(1,0,Primary!) = NewModified! then
	ld_dcost = idw_21.GetItemNumber(1,'ycstr',Primary!,false)
	ls_jobcode = 'C'
	ls_msg = 'ǰ��:' + ls_itno + ' ��ü:' + ls_vsrno + ' �ܰ�:' + string(ld_dcost) + ' �Էµ�.'
else
	ld_dcost = idw_21.GetItemNumber(1,'ycstr',Primary!,true)
	ls_jobcode = 'S'
	ls_msg = 'ǰ��:' + ls_itno + ' ��ü:' + ls_vsrno + ' �ܰ�:' + string(ld_dcost) + ' ������'
end if

f_null_chk(idw_21)
f_pur040_inptid(idw_21)

IF idw_21.Update(True,False) = 1 Then		//BPM103	
	Commit Using sqlca;
	wf_cost_update(ls_xyear, ls_revno, ls_itno)
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,ls_jobcode,ls_msg)
	uo_status.st_message.text = f_message("U010") //����
	idw_21.ResetUpdate()
Else
	Rollback Using sqlca;
	uo_status.st_message.text = f_message("U020") //�������
End IF
setpointer(arrow!)
			
	
end subroutine

public function integer wf_cost_update (string ls_xyear, string ls_revno, string ls_itno);SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok


//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm509
//where yccyy = :ls_xyear;
//IF ll_rcnt = 0  THEN
//	MessageBox('Ȯ��','������ �ڷᰡ �����ϴ�. �ڷ���� ����� ����ϼ���!')
//	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�. �ڷ���� ����� ����ϼ���!'
//	Return				 
//end if


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����. ǰ��:' + ls_itno &
          + ' ǰ�� ����������...'					 



//uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
//          + '�� �����Ϸ�.  ��������ȭ�ܰ� ������Ʈ��...'	

update pbbpm.bpm509 a
   set a.ycstd =  
			(select coalesce(sum(x.ycstr),0) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycste =  
			(select coalesce(sum(x.ycstr),0) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycstd1 = a.ycstr,	
		a.ycste1 = a.ycstr,
		a.xunit1 = a.xunit,
		a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end)
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ygrad <> '9'
and   a.ysrce <> '01'
and   a.yitno = :ls_itno
;
//if sqlca.sqlcode <> 0 then
//	MessageBox('Ȯ��',ls_xyear + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.')
//	uo_status.st_message.text = ls_xyear + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.'
//	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//	Return -1
//end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����. ǰ��:' + ls_itno &
          + '  ��ȯ����, ��ȯ�ܰ�($), ��ȯ�ܰ�(\) ������Ʈ��...'	

update pbbpm.bpm509 a
  set 
      a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end),
  		a.ycstd1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(dper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and   x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(dper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  

		a.ycste1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(eper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and   x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(eper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  
		a.ycstd = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(dper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and   x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(dper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and   x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and   x.revno = a.revno
							and    x.curr = a.ycurr), 	
		a.ycste = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(eper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and   x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(eper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and   x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and   x.revno = a.revno
							and    x.curr = a.ycurr) 						
	
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ysrce = '01'
and   a.yitno = :ls_itno;
//if sqlca.sqlcode <> 0 then
//	MessageBox('Ȯ��',ls_xyear + '�� �����ȹ ǰ��ܰ�����(BPM509) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
//	uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�����(BPM509) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
//	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//	Return -1
//end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����. ǰ��:' + ls_itno &
          + '  �켱���� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ygrad = ''
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   ygrad <> '9'
and   yitno = :ls_itno;


update pbbpm.bpm509 a
  set a.ygrad = '1'
where yccyy = :ls_xyear
and   revno = :ls_revno
and   yitno = :ls_itno
and  trim(yitno) || char(ycstd) || trim(yvndsr)
     in (
			select coalesce(max(trim(yitno) || char(ycstd) || trim(yvndsr)),'') 
			from pbbpm.bpm509
			where yccyy = :ls_xyear
			and   revno = :ls_revno
			and   ygubun = '10'
			and   yitno = :ls_itno
			and   ygrad <> '9'
			group by yitno)
;
if sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) �켱���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) �켱���� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return -1
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ް������� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ysakub = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504  
										WHERE pcmcd = '01'
										and   xyear = a.yccyy
										and   revno = a.revno
										and   plant = a.yplant
										and   pdvsn = a.ydiv
										and   pcitn = a.yitno
										and   pwkct = '8888') > 0 then 'Y' else 'N' end),
  
      a.yysung = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504  
										WHERE pcmcd = '01'
										and   xyear = a.yccyy
										and   revno = a.revno
										and   plant = a.yplant
										and   pdvsn = a.ydiv
										and   pcitn = a.yitno
										and   pwkct = '8888') > 0 then 'Y' else 'N' end),
		a.ygcst = (select coalesce(max(x.gcost),0) from pbpur.pur140 x
		           where  x.caldt = '19990101'
					  and    x.xplant = a.yplant
					  and    x.div =  a.ydiv
					  and    x.pitno = a.yitno
					  and    x.yvsrno = a.yvndsr)
where yccyy = :ls_xyear
and   revno = :ls_revno
and   yitno = :ls_itno;
//if sqlca.sqlnrows <= 0 then
//	MessageBox('Ȯ��',ls_xyear + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
//	uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
//	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//	Return -1
//end if		

//tab_1.tabpage_1.cb_xstop.triggerevent('clicked')

//f_bpm_job_start(ls_xyear,'w_bpm301u',g_s_empno,'E',string(ll_rcnt) + '��' + 'ǰ��ܰ����� �ڷ��߰����� �۾��Ϸ�')


SetPointer(arrow!)
return 1



end function

on w_bpm301u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_bpm301u.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;this.event post ue_open_after()

end event

event ue_insert;call super::ue_insert;Choose Case ii_tabindex
	Case 1   //�����ȹ�ܰ�����(����)
      wf_insert_tabpage1()
	case 2   //�����ȹ�ܰ�����(����)
		wf_insert_tabpage2()
End choose





end event

event ue_retrieve;call super::ue_retrieve;String ls_xyear, ls_revno, ls_vsrno, ls_itno,ls_xplant, ls_div,ls_digubun,ls_gubun,ls_xplan,ls_comcd
long ll_rtn
SetPointer(Hourglass!)	

Choose Case ii_tabindex
	Case 1 //�����ȹ�ܰ�����(����)
		if idw_10.accepttext() =  -1 then
			MessageBox("Ȯ��","�������� ������ ��ȸ�ϼ���",Exclamation!)
			Return
		end if
		if f_pur040_mandchk03(idw_10) = -1 then return
		
      ls_xyear  = trim(idw_10.object.xyear[1])
		ls_revno  = trim(idw_10.object.revno[1])
      ls_vsrno  = trim(idw_10.object.vsrno[1])
		ls_itno   = trim(idw_10.object.itno[1])
		ls_xplant = trim(idw_10.object.xplant[1])
		ls_div    = trim(idw_10.object.div[1])
      uo_status.st_message.text = '��ȸ���Դϴ�...'
		If idw_11.Retrieve(ls_xyear, ls_revno, ls_itno, ls_vsrno,ls_xplant,ls_div,'10') > 0 Then
			idw_11.setfocus() 
			idw_11.setcolumn('ycstr')  //�����ܰ�-�Է´ܰ�
			uo_status.st_message.text = f_message("I010") //��ȸ
			wf_icon_onoff(true,true,true,true,false,false,false,true,false)  //I,A,U,D,P
		Else
			uo_status.st_message.text = f_message("I020") //��ȸ����
			idw_11.Reset()
			idw_11.InsertRow(0)
			wf_icon_onoff(true,true,true,false,false,false,false,true,false)  //I,A,U,D,P
		End IF
	Case 2 //�����ȹ�ܰ�����(����)
		if idw_20.accepttext() =  -1 then
			MessageBox("Ȯ��","�������� ������ ��ȸ�ϼ���",Exclamation!)
			Return
		end if
		if f_pur040_mandchk03(idw_20) = -1 then return
		
      ls_xyear  = trim(idw_20.object.xyear[1])
		ls_revno  = trim(idw_20.object.revno[1])
      ls_vsrno = trim(idw_20.object.vsrno[1])
		ls_itno  = trim(idw_20.object.itno[1])
		ls_xplant = trim(idw_20.object.xplant[1])
		ls_div    = trim(idw_20.object.div[1])
		uo_status.st_message.text = '��ȸ���Դϴ�...'
		If idw_21.Retrieve(ls_xyear, ls_revno, ls_itno, ls_vsrno, ls_xplant,ls_div,'10') > 0 Then
			idw_21.setfocus() 
			idw_21.setcolumn('ycstr')
			uo_status.st_message.text = f_message("I010") //��ȸ
			wf_icon_onoff(true,true,true,true,false,false,false,true,false)  //I,A,U,D,P
		Else
			uo_status.st_message.text = f_message("I020") //��ȸ����
			wf_icon_onoff(true,true,true,false,false,false,false,true,false)  //I,A,U,D,P
			idw_21.SetRedraw(False)
			idw_21.Reset()
			idw_21.InsertRow(0)
			idw_21.SetRedraw(True)
		End IF
	Case 3 //�����ȹ�ܰ���ȸ
		if idw_30.accepttext() =  -1 then
			MessageBox("Ȯ��","�������� ������ ��ȸ�ϼ���",Exclamation!)
			Return
		end if
		if f_pur040_mandchk03(idw_30) = -1 then return
		
      ls_xyear   = trim(idw_30.object.xyear[1])
		ls_revno  = trim(idw_30.object.revno[1])
      ls_xplant = trim(idw_30.object.xplant[1])
		ls_div    = trim(idw_30.object.div[1])
		ls_itno   = trim(idw_30.object.itno[1])
		ls_vsrno =  trim(idw_30.object.vsrno[1])
		ls_digubun =  trim(idw_30.object.digubun[1])
		ls_gubun =   trim(idw_30.object.gubun[1])
		ls_xplan =   trim(idw_30.object.xplan[1])
		ls_comcd =   trim(idw_30.object.comcd[1])
		uo_status.st_message.text = '��ȸ���Դϴ�...'
		idw_31.reset()
		If idw_31.Retrieve(ls_xyear, ls_revno, ls_xplant,ls_div,ls_itno,ls_vsrno,ls_digubun,ls_gubun,ls_xplan,ls_comcd) > 0 Then
			uo_status.st_message.text = f_message("I010") //��ȸ
			wf_icon_onoff(true,false,false,false,true,true,false,true,false)  //I,A,U,D,P
		Else
			uo_status.st_message.text = f_message("I020") //��ȸ����
			wf_icon_onoff(true,false,false,false,true,false,false,true,false)  //I,A,U,D,P
		End IF
	Case 4 //�����ȹ����������ȸ
		if idw_40.accepttext() =  -1 then
			MessageBox("Ȯ��","�������� ������ ��ȸ�ϼ���",Exclamation!)
			Return
		end if
		if f_pur040_mandchk03(idw_40) = -1 then return
		
      ls_xyear   = trim(idw_40.object.xyear[1])
		ls_revno  = trim(idw_40.object.revno[1])
      ls_xplant = trim(idw_40.object.xplant[1])
		ls_div    = trim(idw_40.object.div[1])
		uo_status.st_message.text = '��ȸ���Դϴ�...'
		idw_41.reset()
		If idw_41.Retrieve(ls_xyear, ls_revno, ls_xplant,ls_div) > 0 Then
			uo_status.st_message.text = f_message("I010") //��ȸ
			wf_icon_onoff(true,false,false,false,false,true,false,true,false)  //I,A,U,D,P
		Else
			uo_status.st_message.text = f_message("I020") //��ȸ����
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)  //I,A,U,D,P
		End IF	
	Case 5   //�����ȹ ���ڴܰ� ���ε�Excel UpLoad
	   idw_51.reset()
		uo_status.st_message.text	= 'ó�����Դϴ�'
		ll_rtn = f_pur040_getexcel(idw_51)
		if ll_rtn <> -1 and idw_51.rowcount() > 0 then
			uo_status.st_message.text	= 'upload�Ϸ�, Ȯ���� �����ϼ���.'
			wf_icon_onoff(true,false,true,false,false,false,false,true,false) //I,A,U,D,P	
		else
			uo_status.st_message.text	= ''
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P	
		end if	
	case 6	
			  
		if idw_60.accepttext() = -1 then
			messagebox('Ȯ��','��ȸ������ ����Ÿ ������ �ڷ��ֽ��ϴ�.')
			uo_status.st_message.text	=	'��ȸ������ ����Ÿ ������ �ڷ��ֽ��ϴ�.'
			return
		end if
		
		ls_xyear = trim(idw_60.object.xyear[1])
		ls_gubun = trim(idw_60.object.gubun[1])
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���.')
			uo_status.st_message.text	=	'�����ȹ�⵵�� Ȯ���ϼ���.'
			return
		end if
		uo_status.st_message.text	= '��ȸ���Դϴ�...'   
		idw_61.reset() 
	   if idw_61.retrieve(ls_xyear,'w_bpm301u', ls_gubun) > 0 then
			uo_status.st_message.text	=	f_message("I010")		// ��ȸ�Ǿ����ϴ�.
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// ��ȸ�� �ڷᰡ �����ϴ�.
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		end if			
	case 7	
			  
		if idw_70.accepttext() = -1 then
			messagebox('Ȯ��','��ȸ������ ����Ÿ ������ �ڷ��ֽ��ϴ�.')
			uo_status.st_message.text	=	'��ȸ������ ����Ÿ ������ �ڷ��ֽ��ϴ�.'
			return
		end if
		
		ls_xyear = trim(idw_70.object.xyear[1])
		ls_revno  = trim(idw_70.object.revno[1])
//		ls_xplant = trim(idw_70.object.xplant[1])
//		ls_div    = trim(idw_70.object.div[1])
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���.')
			uo_status.st_message.text	=	'�����ȹ�⵵�� Ȯ���ϼ���.'
			return
		end if
		if trim(ls_revno) = '' then
			messagebox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���.')
			uo_status.st_message.text	=	'�����ȹ�⵵/������ Ȯ���ϼ���.'
			return
		end if
		uo_status.st_message.text	= '��ȸ���Դϴ�...'   
		idw_71.reset() 
	   if idw_71.retrieve(ls_xyear,ls_revno) > 0 then
			uo_status.st_message.text	=	f_message("I010")		// ��ȸ�Ǿ����ϴ�.
			wf_icon_onoff(true,false,false,false,false,true,false,true,false) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// ��ȸ�� �ڷᰡ �����ϴ�.
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		end if				
End Choose

SetPointer(Arrow!)				 		
end event

event ue_save;call super::ue_save;Choose Case ii_tabindex
	Case 1 //�����ȹ�ܰ����(����)
      wf_save_tabpage1()
	case 2
		wf_save_tabpage2()
	case 5
		wf_save_tabpage5()	
End choose

//String ls_xyear, ls_vsrno, ls_xyear1, ls_itno, ls_xplant, ls_div, ls_div1,ls_stcd,ls_xplan
//string ls_curr
//dec ld_dcost,ld_ecost
//long ll_row, ll_rcnt
//String ls_bpm103_ycmcd
//
//Choose Case ii_tabindex
//	Case 1 //�����ȹ�ܰ����(����)
//		ls_xyear = idw_10.object.xyear[1]
//	  SELECT coalesce(max("PBINV"."INV403"."RMRT"),' ')  
//		 INTO :ls_stcd  
//		 FROM "PBINV"."INV403"  
//		WHERE ( "PBINV"."INV403"."COMLTD" = '01' ) AND  
//				( "PBINV"."INV403"."CKEY" = 'PLAN-P' )  and 
//				 substr("PBINV"."INV403"."XYEAR",1,4) = :ls_xyear    
//				;
//		if ls_stcd = 'C' then
//			 messagebox('Ȯ��','�����ȹ Ȯ���Ǿ����ϴ�.',Exclamation!)
//			 return
//		end if		
//		if idw_11.AcceptText() = -1 then
//			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
//			return
//		end if
//		
//		
//		ls_xplant = idw_11.object.yplant[1]
//		ls_div    = idw_11.object.ydiv[1]
//		ls_itno   = idw_11.object.yitno[1]
//				
//		//2009.02.20 :������ ���� �䱸����
//		ls_bpm103_ycmcd = trim(idw_11.object.bpm103_ycmcd[1])
//		
//		IF ls_bpm103_ycmcd = "Y" Then //���� ����
//			SELECT COUNT(*)
//				INTO :ll_row  
//			FROM PBBPM.BPM102
//			WHERE COMLTD = '01'  
//			  AND XPLANT = :ls_xplant
//			  AND DIV    = :ls_div
//			  AND ITNO   = :ls_itno
//			USING SQLCA;
//			
//			if ll_row = 0 then
//			   messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�, [BPM102 �����ȹ ǰ�������� ����!]',Exclamation!)
//				return
//			end if
//			
//		Else
//			//��������
//			SELECT count(*)
//			INTO :ll_row  
//			FROM "PBINV"."INV101"  
//			WHERE ( "PBINV"."INV101"."COMLTD" = '01' )       AND  
//					( "PBINV"."INV101"."XPLANT" = :ls_xplant ) AND  
//					( "PBINV"."INV101"."DIV"    = :ls_div )    AND  
//					( "PBINV"."INV101"."ITNO" = :ls_itno )  ;
//			 if ll_row = 0 then
//				 messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�, ǰ��BALANCE����!',Exclamation!)
//				 return
//			 end if
//		End If
//		//END :2009.02.20 
////	//��������
////		SELECT count(*)
////		INTO :ll_row  
////		FROM "PBINV"."INV101"  
////		WHERE ( "PBINV"."INV101"."COMLTD" = '01' )       AND  
////				( "PBINV"."INV101"."XPLANT" = :ls_xplant ) AND  
////				( "PBINV"."INV101"."DIV"    = :ls_div )    AND  
////				( "PBINV"."INV101"."ITNO" = :ls_itno )  ;
////		 if ll_row = 0 then
////			 messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�, ǰ��BALANCE����!',Exclamation!)
////			 return
////		 end if
//		 IF idw_11.GetItemStatus(1,0,Primary!) <> NewModified!  &
//		 and idw_11.object.ycode1[1] = '3' Then
//			 messagebox('Ȯ��','�̹� ������ ǰ���Դϴ�!',Exclamation!)
//			 return
//		end if
//		if idw_11.object.ycstd0[1] = 0 and idw_11.object.ycste0[1] = 0 then
//			messagebox('Ȯ��','������ ���� ���شܰ��� �ϳ��̻��� �Է��ϼ���!',Exclamation!)
//			return
//		end if
////		if f_pur040_mandchk03(idw_11) = -1 then return
//		//Save
//		idw_11.object.ydate[1] = g_s_date
////		if idw_11.object.ycode1[1] = '4' then
////			idw_11.object.ycode1[1] = '1'
////		else
////			idw_11.object.ycode1[1] = '2'
////		end if
//		ls_xplan   = trim(idw_11.object.yplan[1])  //���Ŵ�����
//	   if ls_xplant = 'Y' then      //���ֿ�
//			f_pur040_setxplan1(ls_itno,ls_xplan)
//		else
//			f_pur040_setxplan(ls_itno,ls_xplan)
//		end if
//		
//		long ll_rowid
//		ll_row = 2
//		
//		if idw_11.GetItemStatus(1,0,Primary!) <> NewModified!  then 
//		ll_rowid = idw_11.GetRowIDFromRow(ll_row)	
//		Do while ll_rowid > 0  
//			idw_11.object.ycstd0[ll_row] = idw_11.object.ycstd0[1]						
//			idw_11.object.ycstd01[ll_row] = idw_11.object.ycstd01[1]						
//			idw_11.object.ycstd01m[ll_row] = idw_11.object.ycstd01m[1]						
//			
//			idw_11.object.ycstd1[ll_row] = idw_11.object.ycstd1[1]						
//			idw_11.object.ycstd2[ll_row] = idw_11.object.ycstd2[1]						
//			idw_11.object.ycstd3[ll_row] = idw_11.object.ycstd3[1]						
//			idw_11.object.ycstd4[ll_row] = idw_11.object.ycstd4[1]						
//			idw_11.object.ycstd5[ll_row] = idw_11.object.ycstd5[1]						
//			idw_11.object.ycstd6[ll_row] = idw_11.object.ycstd6[1]
//			idw_11.object.ycstd7[ll_row] = idw_11.object.ycstd7[1]						
//			idw_11.object.ycstd8[ll_row] = idw_11.object.ycstd8[1]						
//			idw_11.object.ycstd9[ll_row] = idw_11.object.ycstd9[1]						
//			idw_11.object.ycstda[ll_row] = idw_11.object.ycstda[1]						
//			idw_11.object.ycstdb[ll_row] = idw_11.object.ycstdb[1]						
//			idw_11.object.ycstdc[ll_row] = idw_11.object.ycstdc[1]						
//			
//			idw_11.object.ycste0[ll_row] = idw_11.object.ycste0[1]						
//			idw_11.object.ycste1[ll_row] = idw_11.object.ycste1[1]						
//			idw_11.object.ycste2[ll_row] = idw_11.object.ycste2[1]						
//			idw_11.object.ycste3[ll_row] = idw_11.object.ycste3[1]						
//			idw_11.object.ycste4[ll_row] = idw_11.object.ycste4[1]						
//			idw_11.object.ycste5[ll_row] = idw_11.object.ycste5[1]						
//			idw_11.object.ycste6[ll_row] = idw_11.object.ycste6[1]
//			idw_11.object.ycste7[ll_row] = idw_11.object.ycste7[1]						
//			idw_11.object.ycste8[ll_row] = idw_11.object.ycste8[1]						
//			idw_11.object.ycste9[ll_row] = idw_11.object.ycste9[1]						
//			idw_11.object.ycstea[ll_row] = idw_11.object.ycstea[1]						
//			idw_11.object.ycsteb[ll_row] = idw_11.object.ycsteb[1]						
//			idw_11.object.ycstec[ll_row] = idw_11.object.ycstec[1]						
//			
//			idw_11.object.ycode1[ll_row] = idw_11.object.ycode1[1]
//			idw_11.object.ychge[ll_row]  = idw_11.object.ychge[1]						
//			
//			idw_11.object.bpm103_ycmcd[ll_row]  = idw_11.object.bpm103_ycmcd[1]		//2009.02.20 :������ ���� �䱸����
//			
//		   ll_row = ll_row + 1
//			ll_rowid = idw_11.GetRowIDFromRow(ll_row)
//		Loop
//	   end if
//		//�Է½� ���庰�ڵ��Է�
////      if idw_11.GetItemStatus(1,0,Primary!) = NewModified!  then 
////			ls_div1  = trim(idw_10.object.div1[1])
////			ls_xyear = trim(idw_11.object.yccyy[1])
////			ls_vsrno = trim(idw_11.object.vsrno[1])
////			ls_itno  = trim(idw_11.object.yitno[1])
////		   for ll_rcnt = 3 to len(ls_div1) step 2
////             ls_xplant = mid(ls_div1,ll_rcnt,1)		
////				 ls_div    = mid(ls_div1,ll_rcnt + 1,1)
////				 if trim(ls_xplant) = '' or isnull(ls_xplant) then
////					exit
////				 end if
////				SELECT count(*)
////				INTO :ll_row  
////				FROM "PBBPM"."BPM103"  
////				WHERE ( "PBBPM"."BPM103"."COMLTD" = '01' ) AND  
////						( "PBBPM"."BPM103"."YCCYY"  = :ls_xyear ) AND 
////						( "PBBPM"."BPM103"."YVNDSR" = :ls_vsrno ) AND  
////						( "PBBPM"."BPM103"."YITNO"  = :ls_itno ) AND  
////						( "PBBPM"."BPM103"."YPLANT" = :ls_xplant ) AND  
////						( "PBBPM"."BPM103"."YDIV"   = :ls_div )   
////						  ;
////				if ll_row > 0 then
////					continue
////				end if
////				
////				ll_row = idw_11.insertrow(0)
////				idw_11.object.comltd[ll_row] = '01'
////				idw_11.object.yplant[ll_row] = ls_xplant
////				idw_11.object.ydiv[ll_row]   = ls_div
////				idw_11.object.yitno[ll_row]  = idw_11.object.yitno[1]
////				
////				idw_11.object.yccyy[ll_row]  = idw_11.object.yccyy[1]
////				idw_11.object.yvndsr[ll_row] = idw_11.object.yvndsr[1]
////				idw_11.object.yclsb[ll_row]  = idw_11.object.yclsb[1]
////				idw_11.object.ysrce[ll_row]  = idw_11.object.ysrce[1]
////				idw_11.object.ypdcd[ll_row]  = idw_11.object.ypdcd[1]
////				idw_11.object.yunit[ll_row]  = idw_11.object.yunit[1]
////				idw_11.object.yplan[ll_row]  = idw_11.object.yplan[1]
////				idw_11.object.yalt[ll_row]   = idw_11.object.yalt[1]
////				
////				idw_11.object.ycstd0[ll_row] = idw_11.object.ycstd0[1]						
////				idw_11.object.ycstd1[ll_row] = idw_11.object.ycstd1[1]						
////				idw_11.object.ycstd2[ll_row] = idw_11.object.ycstd2[1]						
////				idw_11.object.ycstd3[ll_row] = idw_11.object.ycstd3[1]						
////				idw_11.object.ycstd4[ll_row] = idw_11.object.ycstd4[1]						
////				idw_11.object.ycstd5[ll_row] = idw_11.object.ycstd5[1]						
////				idw_11.object.ycstd6[ll_row] = idw_11.object.ycstd6[1]
////				idw_11.object.ycstd7[ll_row] = idw_11.object.ycstd7[1]						
////				idw_11.object.ycstd8[ll_row] = idw_11.object.ycstd8[1]						
////				idw_11.object.ycstd9[ll_row] = idw_11.object.ycstd9[1]						
////				idw_11.object.ycstda[ll_row] = idw_11.object.ycstda[1]						
////				idw_11.object.ycstdb[ll_row] = idw_11.object.ycstdb[1]						
////				idw_11.object.ycstdc[ll_row] = idw_11.object.ycstdc[1]						
////				
////				idw_11.object.ycste0[ll_row] = idw_11.object.ycste0[1]						
////				idw_11.object.ycste1[ll_row] = idw_11.object.ycste1[1]						
////				idw_11.object.ycste2[ll_row] = idw_11.object.ycste2[1]						
////				idw_11.object.ycste3[ll_row] = idw_11.object.ycste3[1]						
////				idw_11.object.ycste4[ll_row] = idw_11.object.ycste4[1]						
////				idw_11.object.ycste5[ll_row] = idw_11.object.ycste5[1]						
////				idw_11.object.ycste6[ll_row] = idw_11.object.ycste6[1]
////				idw_11.object.ycste7[ll_row] = idw_11.object.ycste7[1]						
////				idw_11.object.ycste8[ll_row] = idw_11.object.ycste8[1]						
////				idw_11.object.ycste9[ll_row] = idw_11.object.ycste9[1]						
////				idw_11.object.ycstea[ll_row] = idw_11.object.ycstea[1]						
////				idw_11.object.ycsteb[ll_row] = idw_11.object.ycsteb[1]						
////				idw_11.object.ycstec[ll_row] = idw_11.object.ycstec[1]						
////				
////				idw_11.object.ycode1[ll_row] = idw_11.object.ycode1[1]
////				idw_11.object.ychge[ll_row]  = idw_11.object.ychge[1]						
////				
////				//ll_row = ll_row + 1
////				//ll_rowid = idw_11.GetRowIDFromRow(ll_row)
////			next
////	   end if
//		
//		
//		f_null_chk(idw_11)
//		f_pur040_inptid(idw_11)
//		
//		IF idw_11.Update(True,False) = 1 Then		//BPM103	
//			Commit Using sqlca;
//			uo_status.st_message.text = f_message("U010") //����
//			idw_11.ResetUpdate()
//		Else
//			Rollback Using sqlca;
//			uo_status.st_message.text = f_message("U020") //�������
//		End IF
//			
//	Case 2 //**********************************************�����ȹ�ܰ����(����)
//		ls_xyear = idw_20.object.xyear[1]
//	  SELECT coalesce(max("PBINV"."INV403"."RMRT"),' ')  
//		 INTO :ls_stcd  
//		 FROM "PBINV"."INV403"  
//		WHERE ( "PBINV"."INV403"."COMLTD" = '01' ) AND  
//				( "PBINV"."INV403"."CKEY" = 'PLAN-P' )  and 
//				 substr("PBINV"."INV403"."XYEAR",1,4) = :ls_xyear    
//				;
//		if ls_stcd = 'C' then
//			 messagebox('Ȯ��','�����ȹ Ȯ���Ǿ����ϴ�.',Exclamation!)
//			 return
//		end if		
//		
//		if idw_21.AcceptText() = -1 then
//			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
//			return
//		end if
//		ls_xplant = trim(idw_21.object.yplant[1])
//		ls_div    = trim(idw_21.object.ydiv[1])
//		ls_itno   = trim(idw_21.object.yitno[1])
//		
//		SELECT count(*)
//		INTO :ll_row  
//		FROM "PBINV"."INV101"  
//		WHERE ( "PBINV"."INV101"."COMLTD" = '01' )       AND  
//				( "PBINV"."INV101"."XPLANT" = :ls_xplant ) AND  
//				( "PBINV"."INV101"."DIV"    = :ls_div )    AND  
//				( "PBINV"."INV101"."ITNO"   = :ls_itno )  ;
//       if ll_row = 0 then
//			 messagebox('Ȯ��','����/����� ǰ���� ���� �ʽ��ϴ�, ǰ��BALANCE����!',Exclamation!)
//			 return
//		 end if
////		 IF idw_21.GetItemStatus(1,0,Primary!) = DataModified!  &
////		 and idw_21.object.ycode1[1] = '3' Then
////			 messagebox('Ȯ��','�̹� ������ ǰ���Դϴ�!',Exclamation!)
////			 return
////		end if
//		if idw_21.object.ycstd0[1] = 0 and idw_21.object.ycste0[1] = 0 then
//			messagebox('Ȯ��','������ ���� ���شܰ��� �ϳ��̻��� �Է��ϼ���!',Exclamation!)
//			return
//		end if
//		if f_pur040_mandchk03(idw_21) = -1 then return
//		ls_curr = idw_21.object.ycure[1]
//		select count(*) into :ll_rcnt
//		from pbbpm.bpm104
//		where comltd = '01'
//		and   cyear = :ls_xyear
//		and   ccur = :ls_curr;
//		if ll_rcnt = 0 then
//			 messagebox('Ȯ��',ls_xyear + '�⵵ �����ȹ ��ȭ������ �����ϴ�! ��ȹ�����ǿ��.',Exclamation!)
//			 return
//		end if
//				
//		//Save
//		idw_21.object.ydate[1] = g_s_date
////		if idw_11.object.ycode1[1] = '4' then
////			idw_11.object.ycode1[1] = '1'
////		else
////			idw_11.object.ycode1[1] = '2'
////		end if
//      ls_xplan   = trim(idw_21.object.yplan[1])  //���Ŵ�����
//	   f_pur040_setxplan(ls_itno,ls_xplan)
//		
//      ll_row = 2
//		
//		if idw_21.GetItemStatus(1,0,Primary!) <> NewModified!  then 
//		ll_rowid = idw_21.GetRowIDFromRow(ll_row)	
//		Do while ll_rowid > 0  
//			idw_21.object.ycste0[ll_row] = idw_21.object.ycste0[1]						
//			idw_21.object.ycste1[ll_row] = idw_21.object.ycste1[1]						
//			idw_21.object.ycste2[ll_row] = idw_21.object.ycste2[1]						
//			idw_21.object.ycste3[ll_row] = idw_21.object.ycste3[1]						
//			idw_21.object.ycste4[ll_row] = idw_21.object.ycste4[1]						
//			idw_21.object.ycste5[ll_row] = idw_21.object.ycste5[1]						
//			idw_21.object.ycste6[ll_row] = idw_21.object.ycste6[1]
//			idw_21.object.ycste7[ll_row] = idw_21.object.ycste7[1]						
//			idw_21.object.ycste8[ll_row] = idw_21.object.ycste8[1]						
//			idw_21.object.ycste9[ll_row] = idw_21.object.ycste9[1]						
//			idw_21.object.ycstea[ll_row] = idw_21.object.ycstea[1]						
//			idw_21.object.ycsteb[ll_row] = idw_21.object.ycsteb[1]						
//			idw_21.object.ycstec[ll_row] = idw_21.object.ycstec[1]						
//			
//			idw_21.object.ycode1[ll_row] = idw_21.object.ycode1[1]
//			idw_21.object.ychge[ll_row]  = idw_21.object.ychge[1]						
//			idw_21.object.ycure[ll_row]  = idw_21.object.ycure[1]	
//			idw_21.object.ycode[ll_row] = idw_21.object.ycode[1]
//			
//		   ll_row = ll_row + 1
//			ll_rowid = idw_21.GetRowIDFromRow(ll_row)
//		Loop
//	   end if
//
//
//		f_null_chk(idw_21)
//		f_pur040_inptid(idw_21)
//					
//		IF idw_21.Update(True,False) = 1 Then
//			Commit Using sqlca;
//			uo_status.st_message.text = f_message("U010") //����
//			idw_21.ResetUpdate()
//		Else
//			Rollback Using sqlca;
//			uo_status.st_message.text = f_message("U020") //�������
//		End IF
//	case 5
//		wf_save_tabpage5()
//End Choose

end event

event ue_dprint;call super::ue_dprint;f_screen_print(this)
end event

event ue_delete;call super::ue_delete;long ll_rcnt , ll_row
int li_ok
dec  ld_dcost
string ls_xyear, ls_revno, ls_vsrno, ls_stcd,ls_stcd1,ls_itno,ls_msg

Choose Case ii_tabindex
	Case 1 
			
		if idw_11.accepttext() = -1 then
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			uo_status.st_message.text = '�������� ������ �����ϼ���!'
			return
		end if
		if idw_11.rowcount() = 0 then
			messagebox('Ȯ��','��ȸ�� �����ϼ���!',Exclamation!)
			uo_status.st_message.text = '��ȸ�� �����ϼ���!'
			return
		end if
		if idw_11.ModifiedCount() > 0 then
			messagebox('Ȯ��','������ ǰ�� �����Ұ��մϴ�!',Exclamation!)
			uo_status.st_message.text = '������ ǰ�� �����Ұ��մϴ�!'
			return
		end if
		if idw_11.object.ycode1[1] = '3' then
			messagebox('Ȯ��','�̹� ������ ǰ���Դϴ�!',Exclamation!)
			uo_status.st_message.text = '�̹� ������ ǰ���Դϴ�!'
			return
		end if
		ls_xyear = trim(idw_11.object.yccyy[1])
		ls_revno = trim(idw_11.object.revno[1])
		ls_itno  = trim(idw_11.object.yitno[1])
		IF ls_xyear = ''  THEN
			MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
			uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
			Return
		END IF
		IF ls_revno = ''  THEN
			MessageBox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���!')
			uo_status.st_message.text = '�����ȹ�⵵/������ Ȯ���ϼ���!'
			Return
		END IF
		
		
		IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab�� �������Ȯ��
			messagebox('Ȯ��',ls_msg)
			uo_status.st_message.text	= ls_msg
			Return
		END IF
				
		ll_row = MessageBox("Ȯ��","�ش� data�� �����Ͻðڽ��ϱ�? " + char(10) + &
							 ' ', + &
						 Exclamation!, OKCancel!, 2)
	   IF ll_row = 2 Then
		  uo_status.st_message.text	=  f_message("D030")	 						  
		  return
		else
			idw_11.object.ycode1[1] = '3'  //������ǰ�񱸺�3-����
			idw_11.object.ygrad[1] = '9'
			idw_11.object.yredt[1] = g_s_date
			f_null_chk(idw_11)
		   f_pur040_inptid(idw_11)
		End IF
		if idw_11.update(true,false) = 1 then
			wf_cost_update(ls_xyear,ls_revno, ls_itno)
	      f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'D','ǰ��:' + ls_itno + ' ����ó��.')
			uo_status.st_message.text = f_message("D010")	//����
		   idw_11.ResetUpdate()	
		else
			uo_status.st_message.text	=  f_message("D020")	 						  
			return
		end if
//***********************************************************************************//		
	Case 2 
		 
		if idw_21.accepttext() = -1 then
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			return
		end if
		if idw_21.rowcount() = 0 then
			messagebox('Ȯ��','��ȸ�� �����ϼ���!',Exclamation!)
			return
		end if
		if idw_21.ModifiedCount() > 0 then
			messagebox('Ȯ��','������ ǰ�� �����Ұ��մϴ�!',Exclamation!)
			return
		end if
		if idw_21.object.ycode1[1] = '3' then
			messagebox('Ȯ��','�̹� ������ ǰ���Դϴ�!',Exclamation!)
			return
		end if
		ls_xyear = trim(idw_21.object.yccyy[1])
		ls_revno = trim(idw_21.object.revno[1])
		ls_itno  = trim(idw_21.object.yitno[1])
		IF ls_xyear = ''  THEN
			MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
			uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
			Return
		END IF
		IF ls_revno = ''  THEN
			MessageBox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���!')
			uo_status.st_message.text = '�����ȹ�⵵/������ Ȯ���ϼ���!'
			Return
		END IF
		
		IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab�� �������Ȯ��
			messagebox('Ȯ��',ls_msg)
			uo_status.st_message.text	= ls_msg
			Return
		END IF
		
		ll_row = MessageBox("Ȯ��","�ش� data�� �����Ͻðڽ��ϱ�? " + char(10) + &
							 ' ', + &
						 Exclamation!, OKCancel!, 2)
	   IF ll_row = 2 Then
		  uo_status.st_message.text	=  f_message("D030")	 						  
		  return
		else
			idw_21.object.ycode1[1] = '3'  //������ǰ�񱸺�3-����
			idw_21.object.ygrad[1] = '9' 
			idw_21.object.yredt[1] = g_s_date
			f_null_chk(idw_21)
		   f_pur040_inptid(idw_21)
		End IF
		if idw_21.update(true,false) = 1 then
			wf_cost_update(ls_xyear,ls_revno, ls_itno)
	      f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'D','ǰ��:' + ls_itno + ' ����ó��.')
		   uo_status.st_message.text = f_message("D010")	//����
		   idw_21.ResetUpdate()	
		else
			uo_status.st_message.text	=  f_message("D020")	 						  
			return
		end if	
End Choose



end event

event ue_bcreate;call super::ue_bcreate;Choose case ii_tabindex
	
	case 3
		if idw_31.rowcount() > 0 then
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_31)
			uo_status.st_message.text	=	' '
		else
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		end if		
	case 4
		if idw_41.rowcount() > 0 then
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_41)
			uo_status.st_message.text	=	' '
		else
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		end if		
	case 5
		if idw_51.rowcount() > 0 then
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_51)
			uo_status.st_message.text	=	' '
		else
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		end if		
	case 6
		if idw_61.rowcount() > 0 then
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_61)
			uo_status.st_message.text	=	' '
		else
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		end if		
	case 7
		if idw_71.rowcount() > 0 then
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_71)
			uo_status.st_message.text	=	' '
		else
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		end if				
End choose
end event

event ue_print;call super::ue_print;String ls_xyear, ls_revno, ls_vsrno, ls_itno,ls_xplant, ls_div,ls_digubun,ls_gubun,ls_xplan,ls_comcd
long ll_rtn
Window l_to_open

SetPointer(Hourglass!)
CHOOSE CASE ii_tabindex
    case 3
		if idw_30.accepttext() =  -1 then
			MessageBox("Ȯ��","�������� ������ ��ȸ�ϼ���",Exclamation!)
			uo_status.st_message.text = "�������� ������ ��ȸ�ϼ���"
			Return
		end if
		if f_pur040_mandchk03(idw_30) = -1 then return
		
      ls_xyear   = trim(idw_30.object.xyear[1])
		ls_revno   = trim(idw_30.object.revno[1])
      ls_xplant = trim(idw_30.object.xplant[1])
		ls_div    = trim(idw_30.object.div[1])
		ls_itno   = trim(idw_30.object.itno[1])
		ls_vsrno =  trim(idw_30.object.vsrno[1])
		ls_digubun =  trim(idw_30.object.digubun[1])
		ls_gubun =   trim(idw_30.object.gubun[1])
		ls_xplan =   trim(idw_30.object.xplan[1])
		ls_comcd =   trim(idw_30.object.comcd[1])
		uo_status.st_message.text = '��ȸ���Դϴ�...'
		idw_prt.reset()
		If idw_prt.Retrieve(ls_xyear, ls_revno, ls_xplant,ls_div,ls_itno,ls_vsrno,ls_digubun,ls_gubun,ls_xplan,ls_comcd) = 0 Then
			MessageBox("Ȯ��","����� �ڷᰡ �����ϴ�!")
			uo_status.st_message.text = "����� �ڷᰡ �����ϴ�!"
		   Return
		End IF
		//-- �μ� DataWindow ����  "str_easy" ���
				i_str_prt.transaction   =	sqlca
				i_str_prt.datawindow		= 	idw_prt
				
				//i_str_prt.dwsyntax      =  ls_syntax
				//i_str_prt.tag			  = 	Parent.ClassName()
				f_close_report("2", i_str_prt.title) // Open�� ���Window �ݱ�
				Opensheetwithparm(l_to_open, i_str_prt, "w_prt", w_frame, 0, Layered!)
		uo_status.st_message.text = "�����Ͻ� �ڷᰡ ����Ǿ����ϴ�."		

	////*******************************************************************************	
//    case 6
//		if idw_61.rowcount() = 0 then
//			MessageBox("Ȯ��","����� �ڷḦ ��ȸ�� �����ϼ���!")
//			uo_status.st_message.text = "����� �ڷḦ ��ȸ�� �����ϼ���!"
//		   Return
//		end if
//		ll_rcnt = f_pur040_selectcnt(idw_61)
//
//		if ll_rcnt = 0 then
//			MessageBox("Ȯ��","����� �ڷḦ �����ϼ���!")
//			uo_status.st_message.text = "����� �ڷḦ �����ϼ���!"
//		   Return
//		end if
//		////�Ƿڼ��� �ش��ϴ� ��� ��ü ���
//		FOR ll_row = 1 TO idw_61.RowCount()
//			if idw_61.isselected(ll_row) = false then CONTINUE
//			
//
//				ls_mgno = trim(idw_61.object.mgno[ll_row])
//				ls_rcnt = trim(idw_61.object.rcnt[ll_row])
//				idw_prt.reset()
//				if idw_prt.Retrieve(ls_mgno,ls_rcnt) > 0 then
//					
//				end if
//			
//				
//				//-- �μ� DataWindow ����  "str_easy" ���
//				i_str_prt.transaction   =	sqlca
//				i_str_prt.datawindow		= 	idw_prt
//				
//				//i_str_prt.dwsyntax      =  ls_syntax
//				//i_str_prt.tag			  = 	Parent.ClassName()
//				f_close_report("2", i_str_prt.title) // Open�� ���Window �ݱ�
//				Opensheetwithparm(l_to_open, i_str_prt, "w_prt", w_frame, 0, Layered!)
//		NEXT
//		//iw_sheet.triggerevent('ue_retrieve')
//		uo_status.st_message.text = "�����Ͻ� �ڷᰡ ����Ǿ����ϴ�."		
END CHOOSE
SetPointer(Arrow!)




end event

type uo_status from w_origin_sheet09`uo_status within w_bpm301u
end type

type tab_1 from tab within w_bpm301u
integer x = 14
integer y = 8
integer width = 4585
integer height = 2480
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

event selectionchanged;ii_tabindex = newindex
g_n_tabno = newindex
uo_status.st_message.text	=  ''
Choose Case newindex
	Case 1
		if idw_11.rowcount() > 0 then
			wf_icon_onoff(true,true,true,true,false,false,false,true,false)  //I,A,U,D,P
		else
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)  //I,A,U,D,P
		end if
	Case 2
		if idw_21.rowcount() > 0 then
			wf_icon_onoff(true,true,true,false,false,false,false,true,false)  //I,A,U,D,P
		else
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)  //I,A,U,D,P
		end if
	Case 3
		if idw_31.rowcount() > 0 then
			wf_icon_onoff(true,false,false,false,true,true,false,true,false)  //I,A,U,D,P
		else
			wf_icon_onoff(true,false,false,false,true,false,false,true,false)  //I,A,U,D,P
		end if
	Case 4
		if idw_41.rowcount() > 0 then
			wf_icon_onoff(true,false,false,false,false,true,false,true,false)  //I,A,U,D,P
		else
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)  //I,A,U,D,P
		end if
	Case 5
		if idw_51.rowcount() > 0 then
			wf_icon_onoff(true,false,true,false,false,false,false,true,false)  //I,A,U,D,P
		else
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)  //I,A,U,D,P
		end if	
	Case 7
		if idw_71.rowcount() > 0 then
			wf_icon_onoff(true,false,false,false,false,true,false,true,false)  //I,A,U,D,P
		else
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)  //I,A,U,D,P
		end if		
End Choose

              
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "�����ȹ�ܰ�����(����)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_1 cb_1
cb_10 cb_10
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
cb_nothing cb_nothing
cb_4 cb_4
cb_7 cb_7
cb_6 cb_6
cb_xstop cb_xstop
st_9 st_9
st_8 st_8
cb_5 cb_5
st_4 st_4
cb_3 cb_3
cb_2 cb_2
st_2 st_2
st_1 st_1
dw_10 dw_10
dw_11 dw_11
end type

on tabpage_1.create
this.cb_1=create cb_1
this.cb_10=create cb_10
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.cb_nothing=create cb_nothing
this.cb_4=create cb_4
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_xstop=create cb_xstop
this.st_9=create st_9
this.st_8=create st_8
this.cb_5=create cb_5
this.st_4=create st_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_2=create st_2
this.st_1=create st_1
this.dw_10=create dw_10
this.dw_11=create dw_11
this.Control[]={this.cb_1,&
this.cb_10,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.cb_nothing,&
this.cb_4,&
this.cb_7,&
this.cb_6,&
this.cb_xstop,&
this.st_9,&
this.st_8,&
this.cb_5,&
this.st_4,&
this.cb_3,&
this.cb_2,&
this.st_2,&
this.st_1,&
this.dw_10,&
this.dw_11}
end on

on tabpage_1.destroy
destroy(this.cb_1)
destroy(this.cb_10)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.cb_nothing)
destroy(this.cb_4)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_xstop)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.cb_5)
destroy(this.st_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_10)
destroy(this.dw_11)
end on

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 2962
integer y = 1604
integer width = 603
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ��߰�(10-03)"
end type

event clicked;//****************10-03������ �ܰ� �߰�
SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� �������� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� �������� Ȯ���ϼ���!'
	Return
END IF


IF g_s_empno <> '970077' and f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','������ �ڷᰡ �����ϴ�. �ڷ���� ����� ����ϼ���!')
	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�. �ڷ���� ����� ����ϼ���!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm503
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹǰ�� ������ �����ϴ�. Ȯ�� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹǰ�� ������ �����ϴ�. Ȯ�� �ٶ��ϴ�!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm508
where comltd = '01' 
and  xyear = :ls_xyear
and  brev = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹ ������������ �����ϴ�. ���������� �۾������� Ȯ�� �Ͻñ� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹ ������������ �����ϴ�. ���������� �۾������� Ȯ�� �Ͻñ� �ٶ��ϴ�!'
	Return				 
end if

li_ok = MessageBox('Ȯ��','�۾��� �����մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 

select count(*) into :ll_rcnt
FROM PBinv.inv304 a, pbinv.inv101 b
where a.comltd = '01'
and   a.comltd = b.comltd
and   a.xplant = b.xplant
and   a.div  = b.div
and   a.itno = b.itno
and   b.cls = '10'
and   b.srce = '03'
and   a.vsrno <> ''
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy  = :ls_xyear
							and   x.revno  = :ls_revno
							and   x.ygubun = '10')
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev  = :ls_revno)
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev  = :ls_revno)
		);
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�߰��� 10-03�����޴ܰ������� �����ϴ�. Ȯ���Ͻñ� �ٶ��ϴ�!')
	uo_status.st_message.text = '�߰��� 10-03�����޴ܰ������� �����ϴ�. Ȯ���Ͻñ� �ٶ��ϴ�!'
	Return				 
end if


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ����� �߰� ������...'
sqlca.autocommit = false

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT,             ycstc1,         yscost)  
select  
         :ls_xyear,        :ls_revno,        a.ITNO,          a.vsrno,       
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
			   and   (x.bprno = a.itno or x.bchno = a.itno)),1,1),           //yplant
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
            and   (x.bprno = a.itno or x.bchno = a.itno)),2,1),            //ydiv
         '10',            '',          
			b.srce,          b.xplan,         b.cls,   
         b.pdcd,            
         (select coalesce(max(xunit),'') from pbinv.inv002 x
          where x.comltd = '01'
          and   x.itno = a.itno),  //bomunit
         b.xunit,  
         b.xunit, 
         1,
			1,
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         'KRW',
         a.xcost,     //ycstd00,    //YCSTC-�����ܰ�,   
         a.adjdt,   //YADJDT,      
         a.xcost,    //YCSTR-�����ܰ�,  
         a.xcost, a.xcost,
         a.xcost,    //ycstd1 
			a.xcost,    //ycstE1,       
         (select coalesce(max(gcost),0) from pbpur.pur103a x
			 where  x.comltd = '01'
			 and    x.vsrno = a.vsrno
			 and    x.itno = a.itno),     //ycostd0a,       // YGCST,      
		   '',  //ycode
			'',   // YALT,            
         '',   //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			:g_s_date,    //YDATE,  ǰ���߰���         
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date,  //CRTDT
			a.xcost,     //YCSTC1-�����ܰ�,  
			a.xcost
FROM PBinv.inv304 a, pbinv.inv101 b
where a.comltd = '01'
and   a.comltd = b.comltd
and   a.xplant = b.xplant
and   a.div  = b.div
and   a.itno = b.itno
and   b.cls = '10'
and   b.srce = '03'
and   a.vsrno <> ''
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy  = :ls_xyear
							and   x.revno  = :ls_revno
							and   x.ygubun = '10')
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno
					 and   x.bgubun = 'A')
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno
					 and   x.bgubun = 'A')
		);

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if					 
commit using sqlca;
sqlca.autocommit = true

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   YDATE = :g_s_date
and   yredt = '';

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����.' + string(ll_rcnt) &
          + '�� �߰������Ϸ�.  ��Ÿ���� ������Ʈ��...'					 

update pbbpm.bpm509 a
  set  
     															
		
	   a.ycmcd = (select coalesce(max(x.comcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno)
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ysrce = '03'
and   YDATE = :g_s_date
and   yredt = '';														
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		



//uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
//          + '�� �����Ϸ�.  ��������ȭ�ܰ� ������Ʈ��...'	
//
//update pbbpm.bpm509 a
//   set a.ycstd =  
//			(select coalesce(sum(x.ycstr),1) 
//			from pbbpm.bpm509 x
//			where x.yccyy = a.yccyy
//			and   x.revno = a.revno
//			and   x.ygubun = '10'
//			and   x.ygrad <> '9'
//			and   x.ysrce <> '01'
//			and   x.yitno = a.yitno) /
//			(select coalesce(count(*),1) 
//			from pbbpm.bpm509 x
//			where x.yccyy = a.yccyy
//			and   x.revno = a.revno
//			and   x.ygubun = '10'
//			and   x.ygrad <> '9'
//			and   x.ysrce <> '01'
//			and   x.yitno = a.yitno),
//		a.ycste =  
//			(select coalesce(sum(x.ycstr),1) 
//			from pbbpm.bpm509 x
//			where x.yccyy = a.yccyy
//			and   x.revno = a.revno
//			and   x.ygubun = '10'
//			and   x.ygrad <> '9'
//			and   x.ysrce <> '01'
//			and   x.yitno = a.yitno) /
//			(select coalesce(count(*),1) 
//			from pbbpm.bpm509 x
//			where x.yccyy = a.yccyy
//			and   x.revno = a.revno
//			and   x.ygubun = '10'
//			and   x.ygrad <> '9'
//			and   x.ysrce <> '01'
//			and   x.yitno = a.yitno),
//		a.ycstd1 = a.ycstr,	
//		a.ycste1 = a.ycstr,
//		a.xunit1 = a.xunit,
//		a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end)
//where a.yccyy = :ls_xyear
//and   a.revno = :ls_revno
//and   a.ygubun = '10'
//and   a.ygrad <> '9'
//and   a.ysrce <> '01'
//;
//if sqlca.sqlcode <> 0 then
//	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.')
//	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.'
//	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//	Return
//end if		




uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ���������.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  �켱���� ������Ʈ��...'	

//update pbbpm.bpm509 a
//  set a.ygrad = ''
//where yccyy = :ls_xyear
//and   revno = :ls_revno
//and   ygubun = '10'
//and   ygrad <> '9'
//;

update pbbpm.bpm509 a
  set a.ygrad = '1'
where yccyy = :ls_xyear
and   revno = :ls_revno
and   YDATE = :g_s_date
and   a.ysrce = '03'
and   yredt = ''			
and  trim(yitno) || char(ycstd) || trim(yvndsr)
     in (
			select coalesce(max(trim(yitno) || char(ycstd) || trim(yvndsr)),'') 
			from pbbpm.bpm509
			where yccyy = :ls_xyear
			and   revno = :ls_revno
			and   YDATE = :g_s_date
			and   a.ysrce = '03'
         and   yredt = ''			
			and   ygubun = '10'
			and   ygrad <> '9'
			group by yitno)
;
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) �켱���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) �켱���� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ް������� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ysakub = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x  
										WHERE x.pcmcd = '01'
										and   x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.plant = a.yplant
										and   x.pdvsn = a.ydiv
										and   x.pcitn = a.yitno
										and   x.pwkct = '8888') > 0 then 'Y' else 'N' end),
  
      a.yysung = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x  
										WHERE x.pcmcd = '01'
										and   x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.plant = a.yplant
										and   x.pdvsn = a.ydiv
										and   x.pcitn = a.yitno
										and   x.pwkct = '8888') > 0 then 'Y' else 'N' end),
		a.ygcst = (select coalesce(max(x.gcost),0) from pbpur.pur140 x
		           where  x.caldt = '19990101'
					  and    x.xplant = a.yplant
					  and    x.div =  a.ydiv
					  and    x.pitno = a.yitno
					  and    x.yvsrno = a.yvndsr)
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   a.ysrce = '03'
and   a.YDATE = :g_s_date
and   a.yredt = '';	
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) ��ް������� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ�����(BPM509) ��ް������� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

//tab_1.tabpage_1.cb_xstop.triggerevent('clicked')

f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'E',string(ll_rcnt) + '��' + '10-03�����޴ܰ����� �ڷ��߰����� �۾��Ϸ�')

//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm509
//where yccyy = :ls_xyear
//and   ygubun = '10'
//and   YDATE = :g_s_date
//and   yredt = '';	

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ 10-03�����޴ܰ����� �����Ϸ�. ' + string(ll_rcnt) + '�� ǰ��.' 
SetPointer(arrow!)
return



end event

type cb_10 from commandbutton within tabpage_1
boolean visible = false
integer x = 3063
integer y = 2232
integer width = 1211
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ܰ�������������(�渮������ �۾�)"
end type

event clicked;////�������۾� BPM509A�� ���ں� ������ ����
////����-�ܰ�������, ����-�԰��ϱ���
SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg, ls_yymm
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

string   ls_ITNO,   ls_itno_chk,       ls_vsrno,          ls_xplant,   ls_DIV   
string   ls_XDATE,          ls_CURR,          ls_XPAY,       ls_XUNIT, ls_purno 
long     ll_index
dec {6}  ld_cost, ld_cost_chk

////�μ��ڵ�Ȯ��
IF  g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵/������ Ȯ���ϼ���!'
	Return
END IF

ls_yymm = f_pur040_relativemonth(mid(g_s_date,1,6), -1)  //�۾��ϱ��� ������������

//ls_yymm = '201002'

select count(*)
   into :ll_rcnt
from pbbpm.bpm509a
where yccyy = :ls_xyear
and   revno = :ls_revno
and   xdate > :ls_yymm || '31' ;
IF ll_rcnt > 0  THEN
	MessageBox('Ȯ��',ls_yymm + ' �������ؿ� ���Ŀ�  ������ �ڷᰡ �ֽ��ϴ�. Ȯ���ϼ���!')
	uo_status.st_message.text = ls_yymm + ' �������ؿ� ���Ŀ�  ������ �ڷᰡ �ֽ��ϴ�. Ȯ���ϼ���!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm509a
where yccyy = :ls_xyear
and   revno = :ls_revno
and   xdate between :ls_yymm || '01' and :ls_yymm || '31' ;
//IF ll_rcnt > 0  THEN
//	MessageBox('Ȯ��','�̹� ������ �ڷᰡ �ֽ��ϴ�. Ȯ���ϼ���!')
//	uo_status.st_message.text = '�̹� ������ �ڷᰡ �ֽ��ϴ�. Ȯ���ϼ���!'
//	Return				 
//end if


li_ok = MessageBox('Ȯ��', ls_yymm + '�� �ܰ��������� �����۾��� �����մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�����۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 

IF ll_rcnt > 0  THEN
	li_ok = MessageBox('Ȯ��', ls_yymm + '�� �ܰ����������� �ֽ��ϴ�! ����� �Ϸ��� Ȯ��Ű�� ��������!', &
						 Exclamation!, OKCancel!, 2)
	IF li_ok <> 1 THEN
		uo_status.st_message.text = '�����۾��� ��ҵǾ����ϴ�.'
		Return
	END IF	
	
	delete from pbbpm.bpm509a
	where yccyy = :ls_xyear
	and   revno = :ls_revno
	and   xdate between :ls_yymm || '01' and :ls_yymm || '31' ;

end if


SetPointer(hourglass!)

uo_status.st_message.text = ls_xyear + '��:' + ls_yymm + '���ؿ� �ܰ��������� ������...'
//sqlca.autocommit = false

uo_status.st_message.text = ls_xyear + '��:' + ls_yymm + '���ؿ� ���ڴܰ��������� ������...'

declare cur_1 cursor for
 select b.xplant, b.div, a.vsrno, a.itno, a.dadjdt,
        a.dcost, (case when a.dcurr = '' then 'KRW' else a.dcurr end),
        b.xunit
 from  pbpur.pur103 a, pbinv.inv101 b
 where a.comltd = '01'
 and   a.comltd = b.comltd
 and   a.itno = b.itno
 and   a.vsrc = 'D'
 and   a.dept in ('D','Y','P')
 and   b.cls in ('10','50')
 and   b.srce <> '01'
 and   a.dadjdt between :ls_yymm || '01' and :ls_yymm || '31'
 order by 1,2,3,4,5;
 


open cur_1;
do while true
	fetch cur_1 into :ls_xplant, :ls_div, :ls_vsrno, 
	                 :ls_itno, :ls_xdate, :ld_cost, :ls_curr,  :ls_xunit;
	if sqlca.sqlcode <> 0 then
		exit
	end if
	select coalesce(max(yindex),0) into :ll_index
	from pbbpm.bpm509a
	where  yccyy = :ls_xyear
	and    revno = :ls_revno
	and    yitno = :ls_itno
	and    yvndsr = :ls_vsrno
	and    yplant = :ls_xplant
	and    ydiv = :ls_div;
   ll_index = ll_index + 1
	if ll_index > 999 then
		continue
	end if
	
   insert into pbbpm.bpm509a
       ( YCCYY,           revno,             YITNO,            YVNDSR,             YPLANT,   
         YDIV,            YINDEX,            XDATE,            CURR,   
         COST,            XPAY,              XUNIT,              EXTD,   
         INPTID,            INPTDT,            UPDTID,           UPDTDT,   
         IPADDR,            MACADDR  )
   values(:ls_xyear,         :ls_revno,       :ls_ITNO,          :ls_vsrno,         :ls_xplant,   
         :ls_div,            :ll_INDEX,          :ls_XDATE,         :ls_CURR,   
         :ld_COST,           :ls_XPAY,           :ls_XUNIT,         '',   
         :g_s_empno,         :g_s_date,           '',             :g_s_datetime,   
         :g_s_IPADDR,        :g_s_MACADDR);	
	if sqlca.sqlcode <> 0 then
		MessageBox('Ȯ��',ls_yymm + '���ؿ� �ܰ���������(BPM509A) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
		uo_status.st_message.text = ls_yymm + '���ؿ� �ܰ���������(BPM509A) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
		messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		//rollback using sqlca;
		//sqlca.autocommit = true
		Return
	end if				
loop
close cur_1;

uo_status.st_message.text = ls_xyear + '��:' + ls_yymm + '���ؿ� ���ڴܰ������Ϸ�.  ���ڴܰ��������� ������...'

declare cur_2 cursor for
 select a.xplant, a.div, a.vndr, a.itno, a.tdte4,
        a.curr, a.purno
 from  pbinv.inv401 a
 where a.comltd = '01'
 and   a.sliptype = 'RF'
 and  a.cls = '10'
 and  a.srce = '01'
 and  a.vndr <> ''
 and   a.tdte4 between :ls_yymm || '01' and :ls_yymm || '31'
 order by 1,2,3,4,5;
 


open cur_2;
do while true
	fetch cur_2 into :ls_xplant, :ls_div, :ls_vsrno,  :ls_itno, :ls_xdate,
	                 :ls_curr,   :ls_purno;
	if sqlca.sqlcode <> 0 then
		exit
	end if
	select coalesce(max(b.xcost),0), coalesce(max(a.tod),''),
	       coalesce(max(b.xunit1),'')
	into :ld_cost, :ls_xpay, :ls_xunit 		 
	from pbpur.opm101 a, pbpur.opm102 b
	where a.comltd = '01'
	and   a.purno = b.purno
	and   b.purno = :ls_purno
	and   b.itno = :ls_itno;
	////���� �����԰�� ���ϴܰ� ����
	if ls_itno = ls_itno_chk and ld_cost = ld_cost_chk then
		continue
	else
		ls_itno_chk = ls_itno
		ld_cost_chk = ld_cost
	end if
	   
	
	select coalesce(max(coitnamee),'')
	  into :ls_xpay
	from pbcommon.dac002 
	where comltd = '01'
	and   cogubun = 'INV161'
	and   cocode = :ls_xpay;
		
	select coalesce(max(yindex),0) into :ll_index
	from pbbpm.bpm509a
	where  yccyy = :ls_xyear
	and    revno = :ls_revno
	and    yitno = :ls_itno
	and    yvndsr = :ls_vsrno
	and    yplant = :ls_xplant
	and    ydiv = :ls_div;
   ll_index = ll_index + 1
	if ll_index > 999 then
		continue
	end if
	
   insert into pbbpm.bpm509a
       ( YCCYY,           revno,             YITNO,            YVNDSR,             YPLANT,   
         YDIV,            YINDEX,            XDATE,            CURR,   
         COST,            XPAY,              XUNIT,              EXTD,   
         INPTID,            INPTDT,            UPDTID,           UPDTDT,   
         IPADDR,            MACADDR  )
   values(:ls_xyear,         :ls_revno,          :ls_ITNO,          :ls_vsrno,         :ls_xplant,   
         :ls_div,            :ll_INDEX,          :ls_XDATE,         :ls_CURR,   
         :ld_COST,           :ls_XPAY,           :ls_XUNIT,         '',   
         :g_s_empno,         :g_s_date,           '',             :g_s_datetime,   
         :g_s_IPADDR,        :g_s_MACADDR);	
	if sqlca.sqlcode <> 0 then
		MessageBox('Ȯ��',ls_yymm + '���ؿ� �ܰ���������(BPM509A) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
		uo_status.st_message.text = ls_yymm + '���ؿ� �ܰ���������(BPM509A) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
		messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		//rollback using sqlca;
		//sqlca.autocommit = true
		Return
	end if				
loop
close cur_2;

			 
//commit using sqlca;
//sqlca.autocommit = true



uo_status.st_message.text = ls_yymm + '���ؿ� �ܰ���������(BPM509A) �ڷ� �����Ϸ�.'
SetPointer(arrow!)
return



end event

type st_13 from statictext within tabpage_1
integer x = 37
integer y = 2044
integer width = 2935
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "4. �ߴ�ǰ��_����(����31)- �����ȹ�����������߿��� ����10�� ���� �ߴܵ� �ܰ���üǰ��"
boolean focusrectangle = false
end type

type st_12 from statictext within tabpage_1
integer x = 37
integer y = 2220
integer width = 2798
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "6. �ܰ���������_����(����50)- �����ȹ�����������߿��� ����10,20,30�� ���� ǰ��"
boolean focusrectangle = false
end type

type st_11 from statictext within tabpage_1
integer x = 37
integer y = 2132
integer width = 2798
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "5. �ܰ���������_����(����40)- �����ȹ�����������߿��� ����10,20,30�� ���� ǰ��"
boolean focusrectangle = false
end type

type st_10 from statictext within tabpage_1
integer x = 37
integer y = 1960
integer width = 3072
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "3. ���ؽ�������_����(����30)- �����ȹ�����������߿��� ����10�� ���� �ߴܵ� �ܰ���üǰ��"
boolean focusrectangle = false
end type

type cb_nothing from commandbutton within tabpage_1
boolean visible = false
integer x = 3086
integer y = 2088
integer width = 1326
integer height = 100
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ����(�ܰ�����ǰ��-����40,����50)"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵/������ Ȯ���ϼ���!'
	Return
END IF


IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

sqlca.autocommit = false

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����ǰ������(����40_����) ������...'

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,         YPLANT,         YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,          YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,         CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,        YCSTE1,   
         YGCST,            YCODE,           YALT,          YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,       c.bchno,          '',       
			c.bplant,
			c.bdiv,
         '40',            '',          
			(select coalesce(max(srce),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno),  //c.srce,          
			(select coalesce(max(xplan),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.xplan,         
			(select coalesce(max(cls),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.cls,   
         (select coalesce(max(pdcd),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.pdcd,            
         (select coalesce(max(xunit),'') from pbbpm.bpm502 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
          and   x.itno = c.bchno),  //bomunit
         (select coalesce(max(xunit),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.xunit,      
         (select coalesce(max(xunit),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.xunit1,  
         1,
			1,
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         'KRW', 
         0,     //ycstd00,    //YCSTC-�����ܰ�,   
         '',   //YADJDT,      
         0,    //YCSTR-�����ܰ�,  
         0,0,
         0, //ycstd1 
			0, //ycstE1,       
         0,     //ycostd0a,       // YGCST,      
		   '',  //ycode
			'',   // YALT,            
         '', //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT

from (		
SELECT  distinct a.BPLANT,   
         a.BDIV,   
         a.BCHNO
FROM PBBPM.BPM508 a, PBBPM.BPM503 b  
where a.comltd = '01'
and   a.xyear  = b.xyear
and   a.brev = b.revno
and   a.bplant = b.xplant
and   a.bdiv  = b.div
and   a.bchno = b.itno
and   b.srce not in ('03','05','06')
and   b.srce <> '01'
and   b.cls <> '30'
and   a.xyear = :ls_xyear
and   a.brev = :ls_revno
and   a.bchno
      not in (select yitno from pbbpm.bpm509 x
              where x.yccyy = a.xyear
				  and   x.revno = a.brev)

) c;
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����40) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����40) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,         YPLANT,         YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,          YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,         CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,        YCSTE1,   
         YGCST,            YCODE,           YALT,          YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,      c.bprno,          '',       
			c.bplant,
			c.bdiv,
         '40',            '',          
			(select coalesce(max(srce),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno),  //c.srce,          
			(select coalesce(max(xplan),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.xplan,         
			(select coalesce(max(cls),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.cls,   
         (select coalesce(max(pdcd),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.pdcd,            
         (select coalesce(max(xunit),'') from pbbpm.bpm502 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
          and   x.itno = c.bprno),  //bomunit
         (select coalesce(max(xunit),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.xunit,   
         (select coalesce(max(xunit),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.xunit1,   
         1,
			1,
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         'KRW', 
         0,     //ycstd00,    //YCSTC-�����ܰ�,   
         '',   //YADJDT,      
         0,    //YCSTR-�����ܰ�,  
         0,0,
         0, //ycstd1 
			0, //ycstE1,       
         0,     //ycostd0a,       // YGCST,      
		   '',  //ycode
			'',   // YALT,            
         '', //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT

from (		
SELECT  distinct a.BPLANT,   
         a.BDIV,   
         a.BprNO
FROM PBBPM.BPM508 a, PBBPM.BPM503 b  
where a.comltd = '01'
and   a.xyear  = b.xyear
and   a.brev  =  b.revno
and   a.bplant = b.xplant
and   a.bdiv  = b.div
and   a.bprno = b.itno
and   b.srce not in ('03','05','06')
and   b.srce <> '01'
and   b.cls <> '30'
and   a.xyear = :ls_xyear 
and   a.brev  = :ls_revno
and   a.bprno
      not in (select yitno from pbbpm.bpm509 x
              where x.yccyy = a.xyear
				  and   x.revno = a.brev)

) c;
		
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����40) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����40) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����ǰ������(����50_����) ������...'

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,         YPLANT,         YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,          YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,         CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,        YCSTE1,   
         YGCST,            YCODE,           YALT,          YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,       c.bchno,          '',       
			c.bplant,
			c.bdiv,
         '50',            '',          
			(select coalesce(max(srce),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno),  //c.srce,          
			(select coalesce(max(xplan),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.xplan,         
			(select coalesce(max(cls),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.cls,   
         (select coalesce(max(pdcd),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bchno), //c.pdcd,            
         (select coalesce(max(xunit),'') from pbbpm.bpm502 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
          and   x.itno = c.bchno),  //bomunit
         '',  
         '', 
         1,
			1,
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         'KRW', 
         0,     //ycstd00,    //YCSTC-�����ܰ�,   
         '',   //YADJDT,      
         0,    //YCSTR-�����ܰ�,  
         0,0,
         0, //ycstd1 
			0, //ycstE1,       
         0,     //ycostd0a,       // YGCST,      
		   '',  //ycode
			'',   // YALT,            
         '', //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT

from (		
SELECT  distinct a.BPLANT,   
         a.BDIV,   
         a.BCHNO
FROM PBBPM.BPM508 a, PBBPM.BPM503 b  
where a.comltd = '01'
and   a.xyear  = b.xyear
and   a.brev  =  b.revno
and   a.bplant = b.xplant
and   a.bdiv  = b.div
and   a.bchno = b.itno
and   b.srce not in ('03','05','06')
and   b.srce = '01'
and   b.cls <> '30'
and   a.xyear = :ls_xyear 
and   a.brev  = :ls_revno
and   a.bchno
      not in (select yitno from pbbpm.bpm509 x
              where x.yccyy = a.xyear
				  and   x.revno = a.brev)

) c;
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����50) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����50) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,         YPLANT,         YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,          YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,         CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,        YCSTE1,   
         YGCST,            YCODE,           YALT,          YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,       c.bprno,          '',       
			c.bplant,
			c.bdiv,
         '50',            '',          
			(select coalesce(max(srce),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno),  //c.srce,          
			(select coalesce(max(xplan),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.xplan,         
			(select coalesce(max(cls),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.cls,   
         (select coalesce(max(pdcd),'') from pbbpm.bpm503 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
			 and   x.xplant = c.bplant
			 and   x.div = c.bdiv
          and   x.itno = c.bprno), //c.pdcd,            
         (select coalesce(max(xunit),'') from pbbpm.bpm502 x
          where x.xyear = :ls_xyear
			 and   x.revno = :ls_revno
          and   x.itno = c.bprno),  //bomunit
         '',  
         '', 
         1,
			1,
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         'KRW', 
         0,     //ycstd00,    //YCSTC-�����ܰ�,   
         '',   //YADJDT,      
         0,    //YCSTR-�����ܰ�,  
         0,0,
         0, //ycstd1 
			0, //ycstE1,       
         0,     //ycostd0a,       // YGCST,      
		   '',  //ycode
			'',   // YALT,            
         '', //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT

from (		
SELECT  distinct a.BPLANT,   
         a.BDIV,   
         a.BprNO
FROM PBBPM.BPM508 a, PBBPM.BPM503 b  
where a.comltd = '01'
and   a.xyear  = b.xyear
and   a.brev  = b.revno
and   a.bplant = b.xplant
and   a.bdiv  = b.div
and   a.bprno = b.itno
and   b.srce not in ('03','05','06')
and   b.srce = '01'
and   b.cls <> '30'
and   a.xyear = :ls_xyear 
and   a.brev  = :ls_revno
and   a.bprno
      not in (select yitno from pbbpm.bpm509 x
              where x.yccyy = a.xyear
				  and   x.revno = a.brev   )

) c;
		
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����50) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����50) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	




commit using sqlca;
sqlca.autocommit = true



select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun in ('40','50');

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����40,50) �����Ϸ�. ' + string(ll_rcnt) + '�� ǰ��.' 
SetPointer(arrow!)
return



end event

type cb_4 from commandbutton within tabpage_1
boolean visible = false
integer x = 4018
integer y = 1780
integer width = 361
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�����ڿ�"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF


IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm509
//where yccyy = :ls_xyear;
//IF ll_rcnt > 0  THEN
//	MessageBox('Ȯ��','�̹� ������ �ڷᰡ �ֽ��ϴ�. �ڷ��߰� ����� ����ϼ���!')
//	uo_status.st_message.text = '�̹� ������ �ڷᰡ �ֽ��ϴ�. �ڷ��߰� ����� ����ϼ���!'
//	Return				 
//end if
//
//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm503
//where xyear = :ls_xyear;
//IF ll_rcnt = 0  THEN
//	MessageBox('Ȯ��','�����ȹǰ�� ������ �����ϴ�. ǰ������ �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!')
//	uo_status.st_message.text = '�����ȹǰ�� ������ �����ϴ�. ǰ������ �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!'
//	Return				 
//end if
//
//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm508
//where comltd = '01' 
//and  xyear = :ls_xyear;
//IF ll_rcnt = 0  THEN
//	MessageBox('Ȯ��','�����ȹ ������������ �����ϴ�. ���������� �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!')
//	uo_status.st_message.text = '�����ȹ ������������ �����ϴ�. ���������� �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!'
//	Return				 
//end if

li_ok = MessageBox('Ȯ��','�۾��� �����մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 

uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ����� ������...'
//sqlca.autocommit = false


delete from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno;


uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ����� �����Ϸ�. ' 
SetPointer(arrow!)
return



end event

event constructor;//if g_s_empno = '970077' then
//	this.visible = true
//end if
end event

type cb_7 from commandbutton within tabpage_1
integer x = 1248
integer y = 1608
integer width = 361
integer height = 100
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "Ȯ�����"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF
IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])

IF f_bpmstcd_chk1('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

////ǰ�� Ȯ��Ȯ��
//select coalesce(max(taskstatus),'')
//into :ls_stcd
//from pbbpm.bpm519
//where comltd = '01'
//and   xyear = :ls_xyear
//and   seqno = '150';
//IF ls_stcd <> 'C'  THEN
//	MessageBox('Ȯ��','�����ȹ ǰ�������� Ȯ�����Դϴ�. ǰ������ Ȯ���� �۾��ϼ���!')
//	uo_status.st_message.text = '�����ȹ ǰ�������� Ȯ�����Դϴ�. ǰ������ Ȯ���� �۾��ϼ���!'
//	Return	 
//END IF

li_ok = MessageBox('Ȯ��','Ȯ������մϴ�!' + & 
                  '~r�۾� 180:BOM�̵��üũ, 190:������BOM����, 220:��������׿���Ȯ�� �۾��� ���� Ȯ����ҵ˴ϴ�.' + & 
						'~rȮ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'G'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno in ('200','180','190','220');
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ����������(BPM519) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ����������(BPM519) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'X','ǰ��ܰ����� �ڷ�Ȯ�� ���')

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ����� Ȯ����� �Ϸ�. '
SetPointer(arrow!)
return

end event

type cb_6 from commandbutton within tabpage_1
integer x = 439
integer y = 1608
integer width = 361
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ��߰�"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� �������� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� �������� Ȯ���ϼ���!'
	Return
END IF


IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','������ �ڷᰡ �����ϴ�. �ڷ���� ����� ����ϼ���!')
	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�. �ڷ���� ����� ����ϼ���!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm503
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹǰ�� ������ �����ϴ�. Ȯ�� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹǰ�� ������ �����ϴ�. Ȯ�� �ٶ��ϴ�!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm508
where comltd = '01' 
and  xyear = :ls_xyear
and  brev = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹ ������������ �����ϴ�. ���������� �۾������� Ȯ�� �Ͻñ� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹ ������������ �����ϴ�. ���������� �۾������� Ȯ�� �Ͻñ� �ٶ��ϴ�!'
	Return				 
end if

li_ok = MessageBox('Ȯ��','�۾��� �����մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 

select count(*) into :ll_rcnt
FROM PBpur.pur103 a
where a.comltd = '01'
and   a.dept in ('D','P','I','Y')
and   a.xstop = 'O'
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy  = :ls_xyear
							and   x.revno  = :ls_revno
							and   x.ygubun = '10')
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev  = :ls_revno)
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev  = :ls_revno)
		);
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','���� �߰��� ǰ��ܰ������� �����ϴ�. Ȯ���Ͻñ� �ٶ��ϴ�!')
	uo_status.st_message.text = '���� �߰��� ǰ��ܰ������� �����ϴ�. Ȯ���Ͻñ� �ٶ��ϴ�!'
	Return				 
end if


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ����� �߰� ������...'
sqlca.autocommit = false

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT,             ycstc1)  
select  
         :ls_xyear,        :ls_revno,        a.ITNO,          a.vsrno,       
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
			   and   (x.bprno = a.itno or x.bchno = a.itno)),1,1),           //yplant
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
            and   (x.bprno = a.itno or x.bchno = a.itno)),2,1),            //ydiv
         '10',            '',          
			'',          '',         '',   
         '',            
         (select coalesce(max(xunit),'') from pbinv.inv002 x
          where x.comltd = '01'
          and   x.itno = a.itno),  //bomunit
         '',  
         a.unit1, 
         1,
			(case when a.dept = 'I' then (case when a.convqty1 = 0 then 
		         	(CASE WHEN a.dcost = 0 THEN 1 else -A.DCOST end) else a.convqty1 end ) else 1 end),
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         (case when a.dept = 'I' then a.ecurr else (case when a.dcurr <> '' then a.dcurr else 'KRW' end) end),
         (case when a.dept = 'I' then a.ecost else a.dcost end),     //ycstd00,    //YCSTC-�����ܰ�,   
         (case when a.dept = 'I' then a.eadjdt else a.dadjdt end),   //YADJDT,      
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //YCSTR-�����ܰ�,  
         0,0,
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstd1 
			(case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstE1,       
         (select coalesce(max(gcost),0) from pbpur.pur103a x
			 where  x.comltd = '01'
			 and    x.dept = a.dept
			 and    x.vsrno = a.vsrno
			 and    x.itno = a.itno),     //ycostd0a,       // YGCST,      
		  (case	when a.dept = 'I'  then (select coalesce(max(coextend),'F') from pbcommon.dac002 x
													 where x.comltd = '01'
													 and   x.cogubun = 'INV161'
													 and   x.cocode = a.arr) else '' end),  //ycode
			'',   // YALT,            
         (case when a.dept = 'I' then  (case when substr(a.esheet,1,4) = 'EXPT' then 'K' else  '' end) 
		       else (case when substr(a.dsheet,1,4) = 'EXPT' then 'K' else '' end) end),   //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			:g_s_date,    //YDATE,  ǰ���߰���         
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date,  //CRTDT
			(case when a.dept = 'I' then a.ecost else a.dcost end)     //YCSTC-�����ܰ�,   
FROM PBpur.pur103 a
where a.comltd = '01'
and   a.dept in ('D','P','I','Y')
and   (a.dept <> 'I' or a.dept = 'I' and a.itno in (select itno from pbpur.opm102 x
                                                    where x.comltd = '01'
																	 and x.inptdt >= :ls_xyear || '0101'
																	 and x.inptdt <= :ls_xyear || '1020') 
      )																	 
and   a.xstop = 'O'
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy  = :ls_xyear
							and   x.revno  = :ls_revno
							and   x.ygubun = '10')
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno
					 and   x.bgubun = 'A')
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno
					 and   x.bgubun = 'A')
		);

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if					 
commit using sqlca;
sqlca.autocommit = true

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   YDATE = :g_s_date
and   yredt = '';

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �߰������Ϸ�.  ��Ÿ���� ������Ʈ��...'					 

update pbbpm.bpm509 a
  set  
     																
		a.ysrce = (select coalesce(max(x.srce),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yplan = (select coalesce(max(x.xplan),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yclsb = (select coalesce(max(x.cls),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.ypdcd = (select coalesce(max(x.pdcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),	
		a.xunit = (select coalesce(max(x.xunit),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.convinv = (select coalesce(max(x.convqty),1) from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
	   a.ycmcd = (select coalesce(max(x.comcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yscost = (select coalesce(max(x.xcost),0) from pbinv.inv304 x
		          where  x.comltd = '01'
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno)						 
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   YDATE = :g_s_date
and   yredt = '';														
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ����ǰ�� ��ȭ�ܰ� ��ȯ��...'		
			 
update pbbpm.bpm509 a
  set  
      ycstc = ycstc * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 
		ycstr = ycstr * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 					 
		ycstd1 = ycstd1 * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 					 
		ycste1 = ycste1 * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr) 					 
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   ysrce <> '01'
and   ycurr <> 'KRW'
and   YDATE = :g_s_date
and   yredt = '';																			
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ����ǰ�� ��ȭ�ܰ� ��ȯ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ����ǰ�� ��ȭ�ܰ� ��ȯ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��������ȭ�ܰ� ������Ʈ��...'	

update pbbpm.bpm509 a
   set a.ycstd =  
			(select coalesce(sum(x.ycstr),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycste =  
			(select coalesce(sum(x.ycstr),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycstd1 = a.ycstr,	
		a.ycste1 = a.ycstr,
		a.xunit1 = a.xunit,
		a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end)
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ygrad <> '9'
and   a.ysrce <> '01'
;
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ȯ����, ��ȯ�ܰ�($), ��ȯ�ܰ�(\) ������Ʈ��...'	

update pbbpm.bpm509 a
  set 
      a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end),
  		a.ycstd1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(dper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and   x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(dper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  

		a.ycste1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(eper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and   x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(eper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  
		a.ycstd = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(dper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and   x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(dper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and   x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and    x.revno = a.revno
							and    x.curr = a.ycurr), 	
		a.ycste = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(eper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and   x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(eper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and   x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and   x.revno = a.revno
							and    x.curr = a.ycurr) 						
	
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ysrce = '01'
and   a.YDATE = :g_s_date
and   a.yredt = '';	
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  �켱���� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ygrad = ''
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   ygrad <> '9'
;

update pbbpm.bpm509 a
  set a.ygrad = '1'
where yccyy = :ls_xyear
and   revno = :ls_revno
and  trim(yitno) || char(ycstd) || trim(yvndsr)
     in (
			select coalesce(max(trim(yitno) || char(ycstd) || trim(yvndsr)),'') 
			from pbbpm.bpm509
			where yccyy = :ls_xyear
			and   revno = :ls_revno
			and   ygubun = '10'
			and   ygrad <> '9'
			group by yitno)
;
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) �켱���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�(BPM509) �켱���� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ް������� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ysakub = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x  
										WHERE x.pcmcd = '01'
										and   x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.plant = a.yplant
										and   x.pdvsn = a.ydiv
										and   x.pcitn = a.yitno
										and   x.pwkct = '8888') > 0 then 'Y' else 'N' end),
  
      a.yysung = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x  
										WHERE x.pcmcd = '01'
										and   x.xyear = a.yccyy
										and   x.revno = a.revno
										and   x.plant = a.yplant
										and   x.pdvsn = a.ydiv
										and   x.pcitn = a.yitno
										and   x.pwkct = '8888') > 0 then 'Y' else 'N' end),
		a.ygcst = (select coalesce(max(x.gcost),0) from pbpur.pur140 x
		           where  x.caldt = '19990101'
					  and    x.xplant = a.yplant
					  and    x.div =  a.ydiv
					  and    x.pitno = a.yitno
					  and    x.yvsrno = a.yvndsr)
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   a.YDATE = :g_s_date
and   a.yredt = '';	
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

//tab_1.tabpage_1.cb_xstop.triggerevent('clicked')

f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'E',string(ll_rcnt) + '��' + 'ǰ��ܰ����� �ڷ��߰����� �۾��Ϸ�')

//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm509
//where yccyy = :ls_xyear
//and   ygubun = '10'
//and   YDATE = :g_s_date
//and   yredt = '';	

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ����� �����Ϸ�. ' + string(ll_rcnt) + '�� ǰ��.' 
SetPointer(arrow!)
return



end event

type cb_xstop from commandbutton within tabpage_1
boolean visible = false
integer x = 3136
integer y = 1964
integer width = 1230
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ����(�ߴ�ǰ-����20,����30,31)"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵//������ Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵/������ Ȯ���ϼ���!'
	Return
END IF

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

//select count(*)
//   into :ll_rcnt
//from pbbpm.bpm509
//where yccyy = :ls_xyear;
//IF ll_rcnt > 0  THEN
//	MessageBox('Ȯ��','�̹� ������ �ڷᰡ �ֽ��ϴ�. �ڷ��߰� ����� ����ϼ���!')
//	uo_status.st_message.text = '�̹� ������ �ڷᰡ �ֽ��ϴ�. �ڷ��߰� ����� ����ϼ���!'
//	Return				 
//end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm503
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹǰ�� ������ �����ϴ�. ǰ������ �����Ŀ� �۾��ϱ�� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹǰ�� ������ �����ϴ�. ǰ������ �����Ŀ� �۾��ϱ�� �ٶ��ϴ�!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm508
where comltd = '01' 
and  xyear = :ls_xyear
and  brev = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹ ������������ �����ϴ�. ���������� �����Ŀ� �۾��ϱ�� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹ ������������ �����ϴ�. ���������� �����Ŀ� �۾��ϱ�� �ٶ��ϴ�!'
	Return				 
end if

//li_ok = MessageBox('Ȯ��','�����۾��� �����մϴ�! Ȯ��Ű�� ��������!', &
//					 Exclamation!, OKCancel!, 2)
//IF li_ok <> 1 THEN
//	uo_status.st_message.text = '�����۾��� ��ҵǾ����ϴ�.'
//	Return
//END IF					 

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����20_����) ������...'
sqlca.autocommit = false

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,       a.ITNO,          a.vsrno,       
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
			   and   (x.bprno = a.itno or x.bchno = a.itno)),1,1),           //yplant
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
            and   (x.bprno = a.itno or x.bchno = a.itno)),2,1),            //ydiv
         '20',            '',          
			'',          '',         '',   
         '',            
         (select coalesce(max(xunit),'') from pbinv.inv002 x
          where x.comltd = '01'
          and   x.itno = a.itno),  //bomunit
         '',  
         a.unit1, 
         1,
			(case when a.dept = 'I' then (case when a.convqty1 = 0 then 
		         	(CASE WHEN a.dcost = 0 THEN 1 else -A.DCOST end) else a.convqty1 end ) else 1 end),
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         (case when a.dept = 'I' then a.ecurr else (case when a.dcurr <> '' then a.dcurr else 'KRW' end) end),
         (case when a.dept = 'I' then a.ecost else a.dcost end),     //ycstd00,    //YCSTC-�����ܰ�,   
         (case when a.dept = 'I' then a.eadjdt else a.dadjdt end),   //YADJDT,      
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //YCSTR-�����ܰ�,  
         0,0,
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstd1 
			(case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstE1,       
         (select coalesce(max(gcost),0) from pbpur.pur103a x
			 where  x.comltd = '01'
			 and    x.dept = a.dept
			 and    x.vsrno = a.vsrno
			 and    x.itno = a.itno),     //ycostd0a,       // YGCST,      
		  (case	when a.dept = 'I'  then (select coalesce(max(coextend),'F') from pbcommon.dac002 x
													 where x.comltd = '01'
													 and   x.cogubun = 'INV161'
													 and   x.cocode = a.arr) else '' end),  //ycode
			'',   // YALT,            
         (case when a.dept = 'I' then  (case when substr(a.esheet,1,4) = 'EXPT' then 'K' else  '' end) 
		       else (case when substr(a.dsheet,1,4) = 'EXPT' then 'K' else '' end) end),   //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT
FROM PBpur.pur103 a
where a.comltd = '01'
and   a.dept in ('D','P','Y')
and   a.xstop <> 'O'
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy = :ls_xyear
							and   x.revno = :ls_revno
							and   x.ygubun = '10')
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno)
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno)
		);
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����20) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����20) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����30_���ڱ��ؽ�������) ������...'
insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,       a.ITNO,          a.vsrno,       
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
			   and   (x.bprno = a.itno or x.bchno = a.itno)),1,1),           //yplant
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
            and   (x.bprno = a.itno or x.bchno = a.itno)),2,1),            //ydiv
         '30',            '',          
			'',          '',         '',   
         '',            
         (select coalesce(max(xunit),'') from pbinv.inv002 x
          where x.comltd = '01'
          and   x.itno = a.itno),  //bomunit
         '',  
         a.unit1, 
         1,
			(case when a.dept = 'I' then (case when a.convqty1 = 0 then 
		         	(CASE WHEN a.dcost = 0 THEN 1 else -A.DCOST end) else a.convqty1 end ) else 1 end),
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         (case when a.dept = 'I' then a.ecurr else (case when a.dcurr <> '' then a.dcurr else 'KRW' end) end),
         (case when a.dept = 'I' then a.ecost else a.dcost end),     //ycstd00,    //YCSTC-�����ܰ�,   
         (case when a.dept = 'I' then a.eadjdt else a.dadjdt end),   //YADJDT,      
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //YCSTR-�����ܰ�,  
         0,0,
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstd1 
			(case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstE1,       
         (select coalesce(max(gcost),0) from pbpur.pur103a x
			 where  x.comltd = '01'
			 and    x.dept = a.dept
			 and    x.vsrno = a.vsrno
			 and    x.itno = a.itno),     //ycostd0a,       // YGCST,      
		  (case	when a.dept = 'I'  then (select coalesce(max(coextend),'F') from pbcommon.dac002 x
													 where x.comltd = '01'
													 and   x.cogubun = 'INV161'
													 and   x.cocode = a.arr) else '' end),  //ycode
			'',   // YALT,            
         (case when a.dept = 'I' then  (case when substr(a.esheet,1,4) = 'EXPT' then 'K' else  '' end) 
		       else (case when substr(a.dsheet,1,4) = 'EXPT' then 'K' else '' end) end),   //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT
FROM PBpur.pur103 a
where a.comltd = '01'
and   (a.dept = 'I' and trim(a.vsrno) || trim(a.itno) in (select trim(y.vsrno) || trim(x.itno) from pbpur.opm102 x, pbpur.opm101 y
                                                                      where x.comltd = '01'
																							  and  x.comltd = y.comltd
																							  and  x.purno = y.purno
																	                    and x.inptdt >= '20000101'
																	                    and x.inptdt <= '20091231')  
      )																	 
and   a.xstop = 'O'
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy = :ls_xyear
							and   x.revno = :ls_revno
							and   x.ygubun = '10')
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno)
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno)
		);

if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����30) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����30) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����31_�����ߴ�) ������...'
insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT)  
select  
         :ls_xyear,        :ls_revno,       a.ITNO,          a.vsrno,       
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
			   and   (x.bprno = a.itno or x.bchno = a.itno)),1,1),           //yplant
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev  = :ls_revno
            and   (x.bprno = a.itno or x.bchno = a.itno)),2,1),            //ydiv
         '31',            '',          
			'',          '',         '',   
         '',            
         (select coalesce(max(xunit),'') from pbinv.inv002 x
          where x.comltd = '01'
          and   x.itno = a.itno),  //bomunit
         '',  
         a.unit1, 
         1,
			(case when a.dept = 'I' then (case when a.convqty1 = 0 then 
		         	(CASE WHEN a.dcost = 0 THEN 1 else -A.DCOST end) else a.convqty1 end ) else 1 end),
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         (case when a.dept = 'I' then a.ecurr else (case when a.dcurr <> '' then a.dcurr else 'KRW' end) end),
         (case when a.dept = 'I' then a.ecost else a.dcost end),     //ycstd00,    //YCSTC-�����ܰ�,   
         (case when a.dept = 'I' then a.eadjdt else a.dadjdt end),   //YADJDT,      
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //YCSTR-�����ܰ�,  
         0,0,
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstd1 
			(case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstE1,       
         (select coalesce(max(gcost),0) from pbpur.pur103a x
			 where  x.comltd = '01'
			 and    x.dept = a.dept
			 and    x.vsrno = a.vsrno
			 and    x.itno = a.itno),     //ycostd0a,       // YGCST,      
		  (case	when a.dept = 'I'  then (select coalesce(max(coextend),'F') from pbcommon.dac002 x
													 where x.comltd = '01'
													 and   x.cogubun = 'INV161'
													 and   x.cocode = a.arr) else '' end),  //ycode
			'',   // YALT,            
         (case when a.dept = 'I' then  (case when substr(a.esheet,1,4) = 'EXPT' then 'K' else  '' end) 
		       else (case when substr(a.dsheet,1,4) = 'EXPT' then 'K' else '' end) end),   //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date  //CRTDT
FROM PBpur.pur103 a
where a.comltd = '01'
and   a.dept = 'I' 												 
and   a.xstop <> 'O'
and   (select count(*) from pbbpm.bpm503 x
       where x.xyear = :ls_xyear
		 and   x.revno = :ls_revno
		 and   x.itno  = a.itno
		 and   x.srce = '01') > 0 
and   a.itno not in (select x.yitno from pbbpm.bpm509 x
                     where x.yccyy = :ls_xyear
							and   x.revno = :ls_revno
							and   x.ygubun in ('10','20','30'))
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno)
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno)
		);

if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����31) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����31) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if	


commit using sqlca;
sqlca.autocommit = true

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun in ('20','30','31');


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����-����20,30,31' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��Ÿ���� ������Ʈ��...'					 

update pbbpm.bpm509 a
  set  
     																
		a.ysrce = (select coalesce(max(x.srce),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yplan = (select coalesce(max(x.xplan),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yclsb = (select coalesce(max(x.cls),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.ypdcd = (select coalesce(max(x.pdcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),	
		a.xunit = (select coalesce(max(x.xunit),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.convinv = (select coalesce(max(x.convqty),1) from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
	   a.ycmcd = (select coalesce(max(x.comcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno)
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun in ('20','30','31');														
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509-����20,30,31) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509-����20,30,31) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����20).' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ����ǰ�� ��ȭ�ܰ� ��ȯ��...'		
			 
update pbbpm.bpm509 a
  set  
      ycstc = ycstc * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 
		ycstr = ycstr * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 					 
		ycstd1 = ycstd1 * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 					 
		ycste1 = ycste1 * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr) 					 
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun in ('20')
and   ysrce <> '01'
and   ycurr <> 'KRW';																			
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509-����20) ����ǰ�� ��ȭ�ܰ� ��ȯ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509-����20) ����ǰ�� ��ȭ�ܰ� ��ȯ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��������ȭ�ܰ� ������Ʈ��...'	

update pbbpm.bpm509 a
   set 
	   a.ycstd =  
			(select coalesce(sum(x.ycstr),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and    x.revno = a.revno
			and   x.ygubun = '20'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and    x.revno = a.revno
			and   x.ygubun = '20'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycste =  
			(select coalesce(sum(x.ycstr),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and    x.revno = a.revno
			and   x.ygubun = '20'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and    x.revno = a.revno
			and   x.ygubun = '20'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycstd1 = a.ycstr,	
		a.ycste1 = a.ycstr,
		a.xunit1 = a.xunit,
		a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end)
where a.yccyy = :ls_xyear
and    a.revno = :ls_revno
and   a.ygubun = '20'
//and   a.ygrad <> '9'
and   a.ysrce <> '01'
;
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509-����20) �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509-����20) �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����30,31).' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ȯ����, ��ȯ�ܰ�($), ��ȯ�ܰ�(\) ������Ʈ��...'	

update pbbpm.bpm509 a
  set 
      a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end),
  		a.ycstd1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(dper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and    x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(dper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and    x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  

		a.ycste1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(eper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and    x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(eper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and    x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  
		a.ycstd = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(dper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and    x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(dper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and    x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and    x.revno = a.revno
							and    x.curr = a.ycurr), 	
		a.ycste = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(eper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and   x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(eper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and   x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and    x.revno = a.revno
							and    x.curr = a.ycurr) 						
	
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun in ('30','31')
and   a.ysrce = '01';	
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����30) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509-����30,31) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

//uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
//          + '�� �����Ϸ�.  �켱���� ������Ʈ��...'	
//
//update pbbpm.bpm509 a
//  set a.ygrad = '1'
//where yccyy = :ls_xyear
//and  trim(yitno) || char(ycstd) || trim(yvndsr)
//     in (
//			select coalesce(max(trim(yitno) || char(ycstd) || trim(yvndsr)),'') 
//			from pbbpm.bpm509
//			where yccyy = :ls_xyear
//			and   ygubun = '20'
//			and   ygrad <> '9'
//			group by yitno)
//;
//if sqlca.sqlcode <> 0 then
//	MessageBox('Ȯ��',ls_xyear + '�� �����ȹ ǰ��ܰ�(BPM509-����20) �켱���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
//	uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�(BPM509-����20) �켱���� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
//	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//	Return
//end if		
uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ް������� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ysakub = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x 
										WHERE pcmcd = '01'
										and   xyear = a.yccyy
										and   x.revno = a.revno
										and   plant = a.yplant
										and   pdvsn = a.ydiv
										and   pcitn = a.yitno
										and   pwkct = '8888') > 0 then 'Y' else 'N' end),
  
      a.yysung = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x 
										WHERE pcmcd = '01'
										and   xyear = a.yccyy
										and   x.revno = a.revno
										and   plant = a.yplant
										and   pdvsn = a.ydiv
										and   pcitn = a.yitno
										and   pwkct = '8888') > 0 then 'Y' else 'N' end),
		a.ygcst = (select coalesce(max(x.gcost),0) from pbpur.pur140 x
		           where  x.caldt = '19990101'
					  and    x.xplant = a.yplant
					  and    x.div =  a.ydiv
					  and    x.pitno = a.yitno
					  and    x.yvsrno = a.yvndsr)
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun in ('20','30','31');

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun in ('20','30','31');

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ߴ� ǰ��ܰ�����(����20,30,31) �����Ϸ�. ' + string(ll_rcnt) + '�� ǰ��.' 
SetPointer(arrow!)
return



end event

type st_9 from statictext within tabpage_1
integer x = 41
integer y = 1880
integer width = 2935
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "2. �ߴ�ǰ��_����(����20)- �����ȹ�����������߿��� ����10�� ���� �ߴܵ� �ܰ���üǰ��"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_1
integer x = 41
integer y = 1800
integer width = 2478
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "1. �����ڷ�(����10)- �����ȹ�����������߿��� ������� �ܰ���üǰ��"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within tabpage_1
boolean visible = false
integer x = 3954
integer y = 1648
integer width = 517
integer height = 92
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�׽�Ʈ"
end type

event clicked;string ls_msg
//f_chk_convfactor('LB','KG',111,ls_msg)
messagebox('',ls_msg)
end event

event constructor;//if g_s_empno = '970077' then
//	this.visible = true
//end if
end event

type st_4 from statictext within tabpage_1
integer x = 50
integer y = 1728
integer width = 2478
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "�ڷ��������"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within tabpage_1
integer x = 846
integer y = 1608
integer width = 361
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ�Ȯ��"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg, ls_stcd
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF
IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

////ǰ�� Ȯ��Ȯ��
select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '150';
IF ls_stcd <> 'C'  THEN
	MessageBox('Ȯ��','�⵵/����:' + ls_xyear + ls_revno + '  �����ȹ ǰ�������� Ȯ�����Դϴ�. ǰ������ Ȯ���� �۾��ϼ���!')
	uo_status.st_message.text = '�⵵/����:' + ls_xyear + ls_revno + ' �����ȹ ǰ�������� Ȯ�����Դϴ�. ǰ������ Ȯ���� �۾��ϼ���!'
	Return	 
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10';
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','Ȯ���� �ڷᰡ �����ϴ�! Ȯ���ϼ���!')
	uo_status.st_message.text = 'Ȯ���� �ڷᰡ �����ϴ�! Ȯ���ϼ���!'
	Return	 
END IF

li_ok = MessageBox('Ȯ��','Ȯ���մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
   Return
END IF					 

update pbbpm.bpm519
   set taskstatus = 'C'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '200';

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ����������(BPM519) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ����������(BPM519) �ڷ� Ȯ���� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'T','ǰ��ܰ����� �ڷ�Ȯ��')

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ����� Ȯ���Ϸ�. '
SetPointer(arrow!)
return




end event

type cb_2 from commandbutton within tabpage_1
integer x = 32
integer y = 1608
integer width = 361
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "�ڷ����"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵/������ Ȯ���ϼ���!'
	Return
END IF

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt > 0  THEN
	MessageBox('Ȯ��','�̹� ������ �ڷᰡ �ֽ��ϴ�. �ڷ��߰� ����� ����ϼ���!')
	uo_status.st_message.text = '�̹� ������ �ڷᰡ �ֽ��ϴ�. �ڷ��߰� ����� ����ϼ���!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm503
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹǰ�� ������ �����ϴ�. ǰ������ �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹǰ�� ������ �����ϴ�. ǰ������ �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!'
	Return				 
end if

select count(*)
   into :ll_rcnt
from pbbpm.bpm508
where comltd = '01' 
and  xyear = :ls_xyear
and  brev = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('Ȯ��','�����ȹ ������������ �����ϴ�. ���������� �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!')
	uo_status.st_message.text = '�����ȹ ������������ �����ϴ�. ���������� �����Ŀ� �۾��Ͻñ� �ٶ��ϴ�!'
	Return				 
end if

li_ok = MessageBox('Ȯ��','�����۾��� �����մϴ�! Ȯ��Ű�� ��������!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�����۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 

uo_status.st_message.text = ls_xyear + '�� �����ȹ ǰ��ܰ����� ������...'
sqlca.autocommit = false

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT,            ycstc1,          yscost )  
select  
         :ls_xyear,        :ls_revno,      a.ITNO,          a.vsrno,       
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
			   and   (x.bprno = a.itno or x.bchno = a.itno)),1,1),           //yplant
			substr(
			  (select coalesce(max(bplant || bdiv),'') from pbbpm.bpm508 x
            where x.xyear = :ls_xyear
				and   x.brev = :ls_revno
            and   (x.bprno = a.itno or x.bchno = a.itno)),2,1),            //ydiv
         '10',            '',          
			'',          '',         '',   
         '',            
         (select coalesce(max(xunit),'') from pbinv.inv002 x
          where x.comltd = '01'
          and   x.itno = a.itno),  //bomunit
         '',  
         a.unit1, 
         1,
			(case when a.dept = 'I' then (case when a.convqty1 = 0 then 
		         	(CASE WHEN a.dcost = 0 THEN 1 else -A.DCOST end) else a.convqty1 end ) else 1 end),
         1,      //��ȯ����-���߿����        
         '',     //YCHGE,          
         (case when a.dept = 'I' then a.ecurr else (case when a.dcurr <> '' then a.dcurr else 'KRW' end) end),
         (case when a.dept = 'I' then a.ecost else a.dcost end),     //ycstd00,    //YCSTC-�����ܰ�,   
         (case when a.dept = 'I' then a.eadjdt else a.dadjdt end),   //YADJDT,      
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //YCSTR-�����ܰ�,  
         0,0,
         (case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstd1 
			(case when a.dept = 'I' then a.ecost else a.dcost end),    //ycstE1,       
         (select coalesce(max(gcost),0) from pbpur.pur103a x
			 where  x.comltd = '01'
			 and    x.dept = a.dept
			 and    x.vsrno = a.vsrno
			 and    x.itno = a.itno),     //ycostd0a,       // YGCST,      
		  (case	when a.dept = 'I'  then (select coalesce(max(coextend),'F') from pbcommon.dac002 x
													 where x.comltd = '01'
													 and   x.cogubun = 'INV161'
													 and   x.cocode = a.arr) else '' end),  //ycode
			'',   // YALT,            
         (case when a.dept = 'I' then  (case when substr(a.esheet,1,4) = 'EXPT' then 'K' else  '' end) 
		       else (case when substr(a.dsheet,1,4) = 'EXPT' then 'K' else '' end) end),   //YEXPT,         
         '',   //YCODE1,   
         '',   //YCMCD,            
			'',    //YDATE,           
			'',   //YREDT,         
			:g_s_empno,   //UPDTID,          
			:g_s_datetime,   //UPDTDT,       
			:g_s_date,  //CRTDT,
			(case when a.dept = 'I' then a.ecost else a.dcost end),     //YCSTC1-�����ܰ�,  
			0  //�����޴ܰ�
FROM PBpur.pur103 a
where a.comltd = '01'
and   a.dept in ('D','P','I','Y')
and   a.xstop = 'O'
and   (a.dept <> 'I' or a.dept = 'I' and trim(a.vsrno) || trim(a.itno) in (select trim(y.vsrno) || trim(x.itno) from pbpur.opm102 x, pbpur.opm101 y
                                                                      where x.comltd = '01'
																							  and  x.comltd = y.comltd
																							  and  x.purno = y.purno
																	                    and x.inptdt >= '20100101'
																	                    and x.inptdt <= '20101020') 
      ) 
and   (a.itno  in (select x.itno from pbbpm.bpm503 x
                where x.xyear = :ls_xyear
					 and   x.revno = :ls_revno
					 and   x.srce in ('01','02','04','06')))  //������ �� ��ް���ǰ��		
and   (a.itno  in (select bchno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno
					 and   x.bgubun = 'A')  //�����
	    or a.itno in (select bprno from pbbpm.bpm508 x
                where x.comltd = '01'
					 and   x.xyear = :ls_xyear
					 and   x.brev = :ls_revno
					 and   x.bgubun = 'A')
		);

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if					 
commit using sqlca;
sqlca.autocommit = true

select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10';


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��Ÿ���� ������Ʈ��...'					 

update pbbpm.bpm509 a
  set  
     																
		a.ysrce = (select coalesce(max(x.srce),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yplan = (select coalesce(max(x.xplan),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yclsb = (select coalesce(max(x.cls),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.ypdcd = (select coalesce(max(x.pdcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),	
		a.xunit = (select coalesce(max(x.xunit),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.convinv = (select coalesce(max(x.convqty),1) from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
	   a.ycmcd = (select coalesce(max(x.comcd),'') from pbbpm.bpm503 x
		          where  x.xyear = a.yccyy
					 and    x.revno = a.revno
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno),
		a.yscost = (select coalesce(max(x.xcost),0) from pbinv.inv304 x
		          where  x.comltd = '01'
					 and    x.xplant = a.yplant
					 and    x.div    = a.ydiv
					 and    x.itno  = a.yitno)			 
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10';
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� �����ȹ �ܰ�����(BPM509) ��Ÿ���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ����ǰ�� ��ȭ�ܰ� ��ȯ��...'		
			 
update pbbpm.bpm509 a
  set  
      ycstc = ycstc * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 
		ycstr = ycstr * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 					 
		ycstd1 = ycstd1 * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr), 					 
		ycste1 = ycste1 * (select coalesce(max(exch),1) from pbbpm.bpm506 x
				          where  x.xyear = a.yccyy
							 and    x.revno = a.revno
				          and    x.curr = a.ycurr) 					 
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10'
and   ysrce <> '01'
and   ycurr <> 'KRW';																			
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ����ǰ�� ��ȭ�ܰ� ��ȯ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ �ܰ�����(BPM509) ����ǰ�� ��ȭ�ܰ� ��ȯ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��������ȭ�ܰ� ������Ʈ��...'	

update pbbpm.bpm509 a
   set a.ycstd =  
			(select coalesce(sum(x.ycstr),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and   x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycste =  
			(select coalesce(sum(x.ycstr),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and    x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno) /
			(select coalesce(count(*),1) 
			from pbbpm.bpm509 x
			where x.yccyy = a.yccyy
			and    x.revno = a.revno
			and   x.ygubun = '10'
			and   x.ygrad <> '9'
			and   x.ysrce <> '01'
			and   x.yitno = a.yitno),
		a.ycstd1 = a.ycstr,	
		a.ycste1 = a.ycstr,
		a.xunit1 = a.xunit,
		a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end)
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ygrad <> '9'
and   a.ysrce <> '01'
;
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ��������ȭ�ܰ� ������Ʈ��(BPM509) �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		


uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ���� ��ȯ����, ��ȯ�ܰ�($), ��ȯ�ܰ�(\) ������Ʈ��...'	

update pbbpm.bpm509 a
  set 
      a.convqty = (case when a.convpur < 0 then a.convinv * -a.convpur else a.convinv/a.convpur end),
  		a.ycstd1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(dper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and    x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(dper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and    x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  

		a.ycste1 = ycstr + ( case when yplant = 'Y' then
										(select coalesce(max(eper),0) from pbbpm.bpm507 x
										  where x.xyear = a.yccyy
										  and    x.revno = a.revno
										  and   x.gubun = 'A'
										  and   x.xplant = a.yplant) 
									else
									  (select coalesce(max(eper),0) from pbbpm.bpm507 x
										where x.xyear = a.yccyy
										and    x.revno = a.revno
										and   x.gubun = 'B'
										and   x.xplant = a.ycode
										and   x.div = '') end) * ycstr /100,  
		a.ycstd = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(dper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and    x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(dper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and    x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and    x.revno = a.revno
							and    x.curr = a.ycurr), 	
		a.ycste = (ycstr + (case when yplant = 'Y' then
											(select coalesce(max(eper),0) from pbbpm.bpm507 x
											  where x.xyear = a.yccyy
											  and    x.revno = a.revno
											  and   x.gubun = 'A'
											  and   x.xplant = a.yplant) 
										else
										  (select coalesce(max(eper),0) from pbbpm.bpm507 x
											where x.xyear = a.yccyy
											and    x.revno = a.revno
											and   x.gubun = 'B'
											and   x.xplant = a.ycode
											and   x.div = '') end) * ycstr /100)  
						* (select coalesce(max(exch),1) from pbbpm.bpm506 x
						   where  x.xyear = a.yccyy
							and    x.revno = a.revno
							and    x.curr = a.ycurr) 						
	
where a.yccyy = :ls_xyear
and   a.revno = :ls_revno
and   a.ygubun = '10'
and   a.ysrce = '01';	
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) ������ȯ�ܰ� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  �켱���� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ygrad = '1'
where yccyy = :ls_xyear
and   revno = :ls_revno
and  trim(yitno) || char(ycstd) || trim(yvndsr)
     in (
			select coalesce(max(trim(yitno) || char(ycstd) || trim(yvndsr)),'') 
			from pbbpm.bpm509
			where yccyy = :ls_xyear
			and   revno = :ls_revno
			and   ygubun = '10'
			and   ygrad <> '9'
			group by yitno)
;
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) �켱���� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) �켱���� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����.' + string(ll_rcnt) &
          + '�� �����Ϸ�.  ��ް������� ������Ʈ��...'	

update pbbpm.bpm509 a
  set a.ysakub = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x  
										WHERE pcmcd = '01'
										and   xyear = a.yccyy
										and   x.revno = a.revno
										and   plant = a.yplant
										and   pdvsn = a.ydiv
										and   pcitn = a.yitno
										and   pwkct = '8888') > 0 then 'Y' else 'N' end),
  
      a.yysung = (case when (SELECT count(*) 
									 FROM pbbpm.bpm504 x 
										WHERE pcmcd = '01'
										and   xyear = a.yccyy
										and   x.revno = a.revno
										and   plant = a.yplant
										and   pdvsn = a.ydiv
										and   pcitn = a.yitno
										and   pwkct = '8888') > 0 then 'Y' else 'N' end),
		a.ygcst = (select coalesce(max(x.gcost),0) from pbpur.pur140 x
		           where  x.caldt = '19990101'
					  and    x.xplant = a.yplant
					  and    x.div =  a.ydiv
					  and    x.pitno = a.yitno
					  and    x.yvsrno = a.yvndsr)
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10';
if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�(BPM509) ��ް������� ������Ʈ�� �����߻�! �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if		



tab_1.tabpage_1.cb_xstop.triggerevent('clicked') ///�ߴ�ǰ��-gubun-20,30
tab_1.tabpage_1.cb_nothing.triggerevent('clicked') ///�ܰ����³���-gubun-40,50


select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun = '10';

select count(*)
   into :ll_rcnt1
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   ygubun in ('20','30','31','40','50');

f_bpm_job_start(ls_xyear, ls_revno, 'w_bpm301u',g_s_empno,'A','����:' + string(ll_rcnt) + '��' + '�ߴܿ�:' + string(ll_rcnt1) + '��' + &
                     ' ǰ��ܰ����� �ڷ���� �۾��Ϸ�')

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ����� �����Ϸ�. ' + string(ll_rcnt) + '�� ǰ��. �ߴ�ǰ��:' + &
                            string(ll_rcnt1) + '�� ǰ��.'
SetPointer(arrow!)
return



end event

type st_2 from statictext within tabpage_1
integer x = 1691
integer y = 1520
integer width = 1326
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(������ ������ǰ�񱸺��� 3-������ �����)"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer x = 9
integer y = 1520
integer width = 1678
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(�Է½� ��ü�� ǰ���� ���� �� �Է¾������� ��������)"
boolean focusrectangle = false
end type

type dw_10 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
integer x = 23
integer y = 12
integer width = 4480
integer height = 192
integer taborder = 30
string title = "none"
string dataobject = "d_bpm301u_10"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;string ls_colnm

if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
elseif key = keytab! then
//	f_pur040_getobjph(this,ls_colnm)
	ls_colnm = this.GetColumnName()
//	messagebox('',ls_colnm)
	if ls_colnm = 'div' then
		iw_sheet.triggerevent('ue_insert')
   end if
end if
end event

event constructor;this.settransobject(sqlca)
idw_10 = this
This.getChild("div", idwc_1)
idwc_1.SetTransObject(SQLCA)
idwc_1.retrieve('D')	
this.insertrow(0)

////�����ֱ� �⵵/������������ 
string ls_xyear, ls_revno, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)
//if ls_stcd = 'C' then
//   this.object.xyear[1] = string(dec(mid(g_s_date,1,4)) + 1,"0000" ) 
//else 
//	this.object.xyear[1] = string(dec(mid(g_s_date,1,4)),"0000" ) 
//end if
f_pur040_nullchk03(this)
end event

event itemchanged;string ls_xplant, ls_div, ls_xyear, ls_revno
idw_11.reset()
idw_11.insertrow(0)
ls_xyear = trim(this.object.xyear[1])
ls_revno = trim(this.object.revno[1])
Choose case dwo.name
	case 'vsrno'
		if isnull(data) then
			data = ''
		end if
		this.object.vsrno1[1] = data
	case 'vsrno1'
		if isnull(data) then
			data = ''
		end if
		this.object.vsrno[1] = data
	case 'itno'
		if isnull(data) then
			data = ''
		end if
		select coalesce(max(xplant || div),'') into :ls_xplant
		from   pbbpm.bpm503
		where  xyear = :ls_xyear
		and    revno = :ls_revno
		and    itno = :data;
		this.object.xplant[1] = mid(ls_xplant,1,1)
		this.object.div[1] = mid(ls_xplant,2,1)
		this.setitem(1,'div1', f_pur040_getmultidiv(data)) //���ð���ä���
	case 'xplant'
		This.getChild("div", idwc_1)
      idwc_1.SetTransObject(SQLCA)
      idwc_1.retrieve(data)	
End choose
end event

event itemfocuschanged;Choose case dwo.name
	case 'vsrno'
		f_pur040_toggle(handle(this),'KOR')
	case else
		f_pur040_toggle(handle(this),'EUR')
End choose
end event

event losefocus;f_pur040_toggle(handle(this),'EUR')
end event

event itemerror;return 1
end event

event doubleclicked;//string ls_xyear, ls_vsrno, ls_itno, ls_xplant = 'D', ls_div = 'A'
//
//ls_xyear = trim(this.object.xyear[1])
//
//select yvndsr, yitno
//  into :ls_vsrno, :ls_itno
//from   pbbpm.bpm509
//where  yccyy = :ls_xyear
//and    ysrce <> '01'
//and    yplant = :ls_xplant
//and    ydiv = :ls_div
//fetch first 1 rows only;
//
//
//this.object.vsrno[1] = ls_vsrno
//this.object.vsrno1[1] = ls_vsrno
//this.object.itno[1]  = ls_itno
//this.event itemchanged(1,this.object.itno,this.object.itno[1])
//this.object.xplant[1]  = ls_xplant
//this.object.div[1]  = ls_div
end event

type dw_11 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
integer y = 252
integer width = 4512
integer height = 1228
integer taborder = 20
string title = "none"
string dataobject = "d_bpm301u_11"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_save')
end if
end event

event constructor;this.settransobject(sqlca)
idw_11 = this
this.insertrow(0)

this.object.ycode.Background.Color = 16777215  //white
this.object.ycode.visible = false
this.object.ycode_t.visible = false
this.object.ycstd1.visible = false
this.object.ycste1.visible = false
this.object.ycstd1_t.visible = false
this.object.ycstd11_t.visible = false

this.object.xunit1.Background.Color = 553648127  //����
this.object.xunit1.protect = 1
this.object.ycurr.Background.Color = 553648127  //����
this.object.ycurr.protect = 1
this.object.convpur.Background.Color = 553648127  //����
this.object.convpur.protect = 1
end event

event itemerror;return 1
end event

event itemchanged;Choose case dwo.name
	case 'ycode1', 'ychge'
		if isnull(data) then
			data = ''
		end if
	case 'ycstr','ygcst'
		if isnull(data) then
			data = '0'
		end if
		IF this.GetItemStatus(1,0,Primary!) = NewModified! then
			this.object.ycstc1[row] = dec(data)
		end if
	case 'yplan'   //���Ŵ��
		if isnull(data) then
			data = ''
		end if
		if data = '7E' then
			//messagebox('����','���������� �ܰ� ������ 0�Դϴ�.')
			this.object.ycstr[row] = 0
		end if   	
End choose

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "�ܰ�����(����)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_15 st_15
st_14 st_14
st_7 st_7
st_6 st_6
dw_20 dw_20
dw_21 dw_21
end type

on tabpage_2.create
this.st_15=create st_15
this.st_14=create st_14
this.st_7=create st_7
this.st_6=create st_6
this.dw_20=create dw_20
this.dw_21=create dw_21
this.Control[]={this.st_15,&
this.st_14,&
this.st_7,&
this.st_6,&
this.dw_20,&
this.dw_21}
end on

on tabpage_2.destroy
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.dw_20)
destroy(this.dw_21)
end on

type st_15 from statictext within tabpage_2
integer x = 46
integer y = 1912
integer width = 3488
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(�ܰ������� �����ܰ� => �δ�����ܰ��� ȯ�� => ��ȭ��ȯ�ܰ��� �ǰ�, ��ȭ��ȯ�ܰ��� ���� ����.)"
boolean focusrectangle = false
end type

type st_14 from statictext within tabpage_2
integer x = 41
integer y = 1828
integer width = 1678
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(���������� ��üǰ��ܰ��� �ε����ǿ��� ������.)"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_2
integer x = 32
integer y = 1744
integer width = 4517
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(������ ������ǰ�񱸺� ����(3),�켱����(9)�� �����. �Է´ܰ��� �켱����1�� �͸� ����. �켱����1�� �ƴ�ǰ���� �����ʿ����.)"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_2
integer x = 27
integer y = 1652
integer width = 3931
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(�Է½� ��ü�� ǰ���� ���� �� �Է¾������� ��������. �����Ҷ� ��3������ ��ȸ�� ����Ŭ���ϸ� �ٷ���ȸ�˴ϴ�.)"
boolean focusrectangle = false
end type

type dw_20 from datawindow within tabpage_2
event ue_dwnkey pbm_dwnkey
integer y = 8
integer width = 4549
integer height = 204
integer taborder = 40
string title = "none"
string dataobject = "d_bpm301u_20"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;string ls_colnm

if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
elseif key = keytab! then
//	f_pur040_getobjph(this,ls_colnm)
	ls_colnm = this.GetColumnName()
//	messagebox('',ls_colnm)
	if ls_colnm = 'div' then
		iw_sheet.triggerevent('ue_insert')
   end if
end if
end event

event constructor;this.settransobject(sqlca)
idw_20 = this
This.getChild("div", idwc_1)
idwc_1.SetTransObject(SQLCA)
idwc_1.retrieve('D')	
this.insertrow(0)

////�����ֱ� �⵵/������������ 
string ls_xyear, ls_revno, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)
//if ls_stcd = 'C' then
//   this.object.xyear[1] = string(dec(mid(g_s_date,1,4)) + 1,"0000" ) 
//else 
//	this.object.xyear[1] = string(dec(mid(g_s_date,1,4)),"0000" ) 
//end if
f_pur040_nullchk03(this)
end event

event itemchanged;idw_21.reset()
idw_21.insertrow(0)
Choose case dwo.name
	case 'vsrno'
		if isnull(data) then
			data = ''
		end if
		this.object.vsrno1[1] = data
	case 'vsrno1'
		if isnull(data) then
			data = ''
		end if
		this.object.vsrno[1] = data
	case 'itno'
		if isnull(data) then
			data = ''
		end if
		this.setitem(1,'div1', f_pur040_getmultidiv(data))
		this.setitem(1,'xplant', mid(f_pur040_getmultidiv(data),1,1))
		this.setitem(1,'div', mid(f_pur040_getmultidiv(data),2,1))
	case 'xplant'
		This.getChild("div", idwc_1)
		idwc_1.SetTransObject(SQLCA)
		idwc_1.retrieve(data)	
End choose
end event

event itemfocuschanged;Choose case dwo.name
	case 'vsrno'
		f_pur040_toggle(handle(this),'EUR')
	case else
		f_pur040_toggle(handle(this),'EUR')
End choose
end event

event losefocus;f_pur040_toggle(handle(this),'EUR')
end event

type dw_21 from datawindow within tabpage_2
event ue_dwnkey pbm_dwnkey
integer y = 228
integer width = 4526
integer height = 1320
integer taborder = 20
string title = "none"
string dataobject = "d_bpm301u_11"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_save')
end if
end event

event constructor;
this.object.yplan.dddw.name = 'dddw_pur030_xplan1'
this.settransobject(sqlca)
this.object.ycstc1_t.visible = false  //���ű��شܰ�-���ű�ȹ
this.object.ycstc1.visible = false
idw_21 = this
this.insertrow(0)

//this.object.convpur.Background.Color = 15780518//sky 16777215  //white
//this.object.convpur.protect = 0
//this.object.ycode_t.visible = false
end event

event itemchanged;Choose case dwo.name
	case 'ycode1', 'ychge'
		if isnull(data) then
			data = ''
		end if
	case 'ycstr','ygcst'
		if isnull(data) then
			data = '0'
		end if
End choose

end event

event itemerror;return 1
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "�ܰ���ȸ(������)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_8 cb_8
dw_prt dw_prt
dw_31 dw_31
dw_30 dw_30
end type

on tabpage_3.create
this.cb_8=create cb_8
this.dw_prt=create dw_prt
this.dw_31=create dw_31
this.dw_30=create dw_30
this.Control[]={this.cb_8,&
this.dw_prt,&
this.dw_31,&
this.dw_30}
end on

on tabpage_3.destroy
destroy(this.cb_8)
destroy(this.dw_prt)
destroy(this.dw_31)
destroy(this.dw_30)
end on

type cb_8 from commandbutton within tabpage_3
integer x = 3895
integer y = 104
integer width = 485
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string pointer = "HyperLink!"
string text = "���شܰ�����"
end type

event clicked;SetPointer(hourglass!)

String   ls_gubun, ls_vsrno, ls_itno, ls_xplan, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt,ll_rcnt1
Integer  li_rtn, li_ok

////�μ��ڵ�Ȯ��
//IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
//	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
//	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
//	Return
//END IF

IF idw_30.accepttext() = -1  THEN
	MessageBox('Ȯ��','��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!')
	uo_status.st_message.text = '��ȸ�����ڷῡ �����߻�! Ȯ���ϼ���!'
	Return
END IF

ls_xyear = trim(idw_30.object.xyear[1])
ls_revno = trim(idw_30.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵�� Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵�� Ȯ���ϼ���!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('Ȯ��','�����ȹ�⵵/������ Ȯ���ϼ���!')
	uo_status.st_message.text = '�����ȹ�⵵/���� Ȯ���ϼ���!'
	Return
END IF

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

IF idw_31.rowcount() = 0  THEN
	MessageBox('Ȯ��','��ȸ �� �����Ŀ� �۾��ϼ���!')
	uo_status.st_message.text = '��ȸ �� �����Ŀ� �۾��ϼ���!'
	Return
END IF
ll_row = idw_31.GetSelectedRow(0)
If ll_row = 0 Then
	uo_status.st_message.text = '���شܰ��� ��ȯ�� ǰ���� ������ ó���ٶ��ϴ�.'
	messagebox('Ȯ��','���شܰ��� ��ȯ�� ǰ���� ������ ó���ٶ��ϴ�.')
	Return
End If
ls_gubun = trim(idw_31.object.ygubun[ll_row])
ls_vsrno = trim(idw_31.object.yvndsr[ll_row])
ls_itno = trim(idw_31.object.yitno[ll_row])
ls_xplan = trim(idw_31.object.yplan[ll_row])

IF ls_gubun = '10'  THEN
	MessageBox('Ȯ��','������ ������ ���شܰ��Դϴ�. ��������� �ƴմϴ�!' )
	uo_status.st_message.text = '������ ������ ���شܰ��Դϴ�. ��������� �ƴմϴ�!'
	Return				 
end if
select count(*)
   into :ll_rcnt
from pbbpm.bpm509
where yccyy = :ls_xyear
and   revno = :ls_revno
and   yvndsr = :ls_vsrno
and   yitno = :ls_itno
and   ygubun = '10';
IF ll_rcnt > 0  THEN
	MessageBox('Ȯ��','�ش� ��ü/ǰ���� ���شܰ� ������ �̹� �ֽ��ϴ�.' )
	uo_status.st_message.text = '�ش� ��ü/ǰ���� ���شܰ� ������ �̹� �ֽ��ϴ�.'
	Return				 
end if


li_ok = MessageBox('Ȯ��','�����մϴ�! ������ ��Ұ� �ȵ˴ϴ�! Ȯ���ϼ���!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '�۾��� ��ҵǾ����ϴ�.'
	Return
END IF					 

uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ���شܰ� ������...'
sqlca.autocommit = false

insert into pbbpm.bpm509
         (YCCYY,           revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         YGUBUN,           YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,          YCSTC,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,     YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            YDATE,           YREDT,         UPDTID,          UPDTDT,   
         CRTDT,            ysakub,          yysung)  
select  
         YCCYY,            revno,          YITNO,          YVNDSR,        YPLANT,          YDIV,   
         '10',             YGRAD,          YSRCE,          YPLAN,         YCLSB,   
         YPDCD,            BOMUNIT,        XUNIT,          XUNIT1,        CONVINV,   
         CONVPUR,          CONVQTY,        YCHGE,          YCURR,            0,   
         YADJDT,           YCSTR,           
         YCSTD,            YCSTE,           YCSTD1,        YCSTE1,   
         YGCST,            YCODE,           YALT,           YEXPT,         YCODE1,   
         YCMCD,            :g_s_date,       :g_s_date,      :g_s_empno,    :g_s_datetime,   
         '',              ysakub,           yysung  
FROM pbbpm.bpm509 a
where a.yccyy  = :ls_xyear
and   a.revno  = :ls_revno
and   a.yvndsr = :ls_vsrno
and   a.yitno  = :ls_itno
and   a.ygubun = :ls_gubun;

if sqlca.sqlcode <> 0 then
	MessageBox('Ȯ��',ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.')
	uo_status.st_message.text = ls_xyear + '�� REV:' + ls_revno + '�� �����ȹ ǰ��ܰ�����(BPM509) �ڷ� ������ �����߻�! ���� �����ٶ��ϴ�.'
	messagebox('�ý��� ���Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if					 
commit using sqlca;
sqlca.autocommit = true

wf_cost_update(ls_xyear, ls_revno, ls_itno) ////�켱������ ������Ʈ
f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'C','��ü�ڵ�:' + ls_vsrno  + ' ǰ��:' + ls_itno + ' ��������:' + ls_gubun + &
                     ' ���شܰ����� �����۾��Ϸ�')

uo_status.st_message.text = '���شܰ��� �����Ϸ�. ' 
SetPointer(arrow!)
return



end event

type dw_prt from datawindow within tabpage_3
boolean visible = false
integer x = 4375
integer y = 16
integer width = 146
integer height = 84
integer taborder = 40
string title = "none"
string dataobject = "d_bpm301u_12p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;idw_prt = this
this.settransobject(sqlca)
end event

type dw_31 from datawindow within tabpage_3
integer x = 9
integer y = 228
integer width = 4521
integer height = 2136
integer taborder = 40
string title = "none"
string dataobject = "d_bpm301u_31"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_31 = this
//This.getChild("div", idwc_1)
//idwc_1.SetTransObject(SQLCA)
//idwc_1.retrieve('D')	
//this.insertrow(0)
//
//this.object.xyear[1] = string(dec(mid(g_s_date,1,4)) + 1,"0000" ) 
//f_pur040_nullchk03(this)
end event

event clicked;if isnull(row) then
	row = getrow()
end if

//This.SelectRow(0,False)
//This.SelectRow(row,True)
f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������
//�ڷ���� �κ� Ŭ���� ���� ����

//IF dwo.name = "datawindow" Then
//	This.SelectRow(0,false)
//End IF
setpointer(hourglass!)
IF row < 1  THEN
	this.SetRedraw(False)
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 return
END IF







end event

event doubleclicked;if row < 0 or isnull(row) then
	return
end if

string ls_xyear, ls_revno, ls_vsrno, ls_xplant, ls_div, ls_itno

ls_xyear  = trim(idw_30.object.xyear[1])
ls_revno  = trim(idw_30.object.revno[1])
ls_vsrno  = trim(this.object.yvndsr[row])
ls_xplant  = trim(this.object.yplant[row])
ls_div   = trim(this.object.ydiv[row])
ls_itno  = trim(this.object.yitno[row])

if trim(this.object.ysrce[row]) = '01' then
	idw_20.object.xyear[1] = ls_xyear
	idw_20.object.revno[1] = ls_revno
	idw_20.object.vsrno[1] = ls_vsrno
	idw_20.object.vsrno1[1] = ls_vsrno
	idw_20.object.xplant[1] = ls_xplant
	idw_20.object.div[1]  = ls_div
	idw_20.object.itno[1] = ls_itno
	tab_1.selectedtab = 2
	iw_sheet.triggerevent('ue_retrieve')
else
	idw_10.object.xyear[1] = ls_xyear
	idw_10.object.revno[1] = ls_revno
	idw_10.object.vsrno[1] = ls_vsrno
	idw_10.object.vsrno1[1] = ls_vsrno
	idw_10.object.xplant[1] = ls_xplant
	idw_10.object.div[1]  = ls_div
	idw_10.object.itno[1] = ls_itno
	tab_1.selectedtab = 1
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

type dw_30 from datawindow within tabpage_3
event ue_dwnkey pbm_dwnkey
integer x = 27
integer y = 28
integer width = 3735
integer height = 164
integer taborder = 30
string title = "none"
string dataobject = "d_bpm301u_30"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event itemchanged;
Choose case dwo.name
	case 'xyear'
		if isnull(data) or isnumber(trim(data)) = false or len(trim(data)) <> 4 then
			messagebox('Ȯ��','�⵵Ȯ���ϼ���!',Exclamation!)
			data = string(dec(mid(g_s_date,1,4)) + 1,"0000" ) 
			//return 1
		end if
	case 'xplant'
		This.getChild("div", idwc_1)
		idwc_1.SetTransObject(SQLCA)
		idwc_1.retrieve(data)	
	case 'itno'
		if isnull(data) then
			data = ''
		end if
		//this.setitem(1,'div1', f_pur040_getmultidiv(data))
	
	case 'vsrno'
		if isnull(data) then
			data = ''
		end if	
	case 'digubun'
		if isnull(data) then
			data = ''
		end if		
		if data = 'D' then
			this.object.xplan.dddw.name = 'dddw_pur030_xplan5'  //������ü
		else
			this.object.xplan.dddw.name = 'dddw_pur030_xplan1'   //����
		end if
		This.getChild("xplan", idwc_1)
		idwc_1.SetTransObject(SQLCA)
		idwc_1.retrieve('')	
End choose
end event

event constructor;this.settransobject(sqlca)
idw_30 = this
This.getChild("div", idwc_1)
idwc_1.SetTransObject(SQLCA)
idwc_1.retrieve('D')	
this.insertrow(0)

string ls_xyear, ls_revno, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)
f_pur040_nullchk03(this)
end event

event itemerror;return 1
end event

event itemfocuschanged;Choose case dwo.name
	case 'vsrno'
		f_pur040_toggle(handle(this),'KOR')
	case else
		f_pur040_toggle(handle(this),'EUR')
End choose
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "�����ܰ�Ȯ��"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_41 dw_41
dw_40 dw_40
end type

on tabpage_4.create
this.dw_41=create dw_41
this.dw_40=create dw_40
this.Control[]={this.dw_41,&
this.dw_40}
end on

on tabpage_4.destroy
destroy(this.dw_41)
destroy(this.dw_40)
end on

type dw_41 from datawindow within tabpage_4
integer x = 23
integer y = 140
integer width = 4517
integer height = 2212
integer taborder = 50
string title = "none"
string dataobject = "d_bpm301u_41a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//this.object.yvndsr.dddw.name = 'dddw_pur030_vnd06'
//this.object.yplan.dddw.name  = 'dddw_pur030_xplan1'

this.settransobject(sqlca)
idw_41 = this
end event

event doubleclicked;if row < 0 or isnull(row) then
	return
end if


string ls_xyear, ls_revno, ls_vsrno, ls_xplant, ls_div, ls_itno,ls_srce

ls_xyear  = trim(idw_40.object.xyear[1])
ls_revno  = trim(idw_40.object.revno[1])
ls_itno  = trim(this.object.yitno[row])
ls_srce  = trim(this.object.ysrce[row])

if this.dataobject = 'd_bpm301u_41a' then
	idw_30.object.xyear[1] = ls_xyear
	idw_30.object.revno[1] = ls_revno
	if ls_srce = '01' then
		idw_30.object.digubun[1] = 'I'
	else
		idw_30.object.digubun[1] = 'D'
	end if
	idw_30.object.xplant[1]  = ''
	idw_30.object.div[1]  = ''
	idw_30.object.gubun[1]  = ''
	idw_30.object.xplan[1]  = ''
	idw_30.object.gubun[1]  = ''
	idw_30.object.itno[1] = ls_itno
	tab_1.selectedtab = 3
	iw_sheet.triggerevent('ue_retrieve')
	return
end if

ls_vsrno  = trim(this.object.yvndsr[row])
ls_xplant  = trim(this.object.yplant[row])
ls_div   = trim(this.object.ydiv[row])

if trim(this.object.ysrce[row]) = '01' then
	idw_20.object.xyear[1] = ls_xyear
	idw_20.object.revno[1] = ls_revno
	idw_20.object.vsrno[1] = ls_vsrno
	idw_20.object.vsrno1[1] = ls_vsrno
	idw_20.object.xplant[1] = ls_xplant
	idw_20.object.div[1]  = ls_div
	idw_20.object.itno[1] = ls_itno
	tab_1.selectedtab = 2
	iw_sheet.triggerevent('ue_retrieve')
else
	idw_10.object.xyear[1] = ls_xyear
	idw_10.object.revno[1] = ls_revno
	idw_10.object.vsrno[1] = ls_vsrno
	idw_10.object.vsrno1[1] = ls_vsrno
	idw_10.object.xplant[1] = ls_xplant
	idw_10.object.div[1]  = ls_div
	idw_10.object.itno[1] = ls_itno
	tab_1.selectedtab = 1
	iw_sheet.triggerevent('ue_retrieve')
end if

end event

event clicked;if isnull(row) then
	row = getrow()
end if

//This.SelectRow(0,False)
//This.SelectRow(row,True)
f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������
//�ڷ���� �κ� Ŭ���� ���� ����

//IF dwo.name = "datawindow" Then
//	This.SelectRow(0,false)
//End IF
setpointer(hourglass!)
IF row < 1  THEN
	this.SetRedraw(False)
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 return
END IF







end event

type dw_40 from datawindow within tabpage_4
event ue_dwnkey pbm_dwnkey
integer x = 23
integer y = 20
integer width = 3616
integer height = 88
integer taborder = 50
string title = "none"
string dataobject = "d_bpm301u_40"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;//this.object.vsrno.dddw.name = 'dddw_pur030_vnd06a'

this.settransobject(sqlca)
idw_40 = this
This.getChild("div", idwc_1)
idwc_1.SetTransObject(SQLCA)
idwc_1.retrieve('D')	

this.insertrow(0)

string ls_xyear, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)
f_pur040_nullchk03(this)
end event

event itemchanged;
Choose case dwo.name
	case 'xyear'
		if isnull(data) or isnumber(trim(data)) = false or len(trim(data)) <> 4 then
			messagebox('Ȯ��','�⵵Ȯ���ϼ���!',Exclamation!)
			data = string(dec(mid(g_s_date,1,4)) + 1,"0000" ) 
			//return 1
		end if
	case 'xplant'
		This.getChild("div", idwc_1)
		idwc_1.SetTransObject(SQLCA)
		idwc_1.retrieve(data)	
	case 'itno'
		if isnull(data) then
			data = ''
		end if
		//this.setitem(1,'div1', f_pur040_getmultidiv(data))
	
	case 'gubun'
		if isnull(data) then
			data = ''
		end if
		if data = 'A' then
		   idw_41.dataobject = 'd_bpm301u_41a'
		elseif data = 'B' then  //���Լ�����
			idw_41.dataobject = 'd_bpm301u_41b'
		elseif data = 'C' then  //�ݾ��̻�
			idw_41.dataobject = 'd_bpm301u_41c'	
		elseif data = 'D' then  //������ȯ�����̻�
			idw_41.dataobject = 'd_bpm301u_41d'	
		elseif data = 'E' then
  		   idw_41.dataobject = 'd_bpm301u_41e'	
		end if
		idw_41.settransobject(sqlca)
End choose
end event

event itemerror;return 1
end event

event itemfocuschanged;Choose case dwo.name
	case 'itno'
		f_pur040_toggle(handle(this),'EUR')
	case else
		f_pur040_toggle(handle(this),'EUR')
End choose
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "�ܰ����ε�(����)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_9 cb_9
st_5 st_5
dw_50 dw_50
st_3 st_3
dw_51 dw_51
end type

on tabpage_5.create
this.cb_9=create cb_9
this.st_5=create st_5
this.dw_50=create dw_50
this.st_3=create st_3
this.dw_51=create dw_51
this.Control[]={this.cb_9,&
this.st_5,&
this.dw_50,&
this.st_3,&
this.dw_51}
end on

on tabpage_5.destroy
destroy(this.cb_9)
destroy(this.st_5)
destroy(this.dw_50)
destroy(this.st_3)
destroy(this.dw_51)
end on

type cb_9 from commandbutton within tabpage_5
integer x = 3689
integer y = 72
integer width = 832
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��縸����(��Ͼȳ���)"
end type

event clicked;String ls_xyear, ls_revno, ls_vsrno, ls_itno, ls_itnm, ls_spec, ls_xplant, ls_div, ls_div1, ls_stcd,ls_stcd1
string ls_curr, ls_ychge, ls_ycmcd, ls_msg, ls_jobcode 
string ls_cls,ls_srce,ls_pdcd, ls_bomunit, ls_xunit, ls_xunit1, ls_xplan, ls_ycode, ls_ycode1, ls_yalt
string ls_pedtm, ls_pedte, ls_popcd
dec    ld_convinv, ld_convpur, ld_convqty, ld_ydper, ld_yeper
dec    ld_ycstd, ld_ycste, ld_ygcst, ld_dcost
dec    ld_ycstr 
long ll_row, ll_rcnt, ll_rtn


setpointer(hourglass!)
if idw_50.AcceptText() = -1 then
	messagebox('Ȯ��','�����ȹ ���س⵵�� �������� ������ �����ϼ���!')
	uo_status.st_message.text = '�����ȹ ���س⵵�� �������� ������ �����ϼ���!'
	return
end if
ls_xyear = trim(idw_50.object.xyear[1])
ls_revno = trim(idw_50.object.revno[1])
if idw_51.AcceptText() = -1 then
	messagebox('Ȯ��','����ȭ�鳻�� �������� ������ �����ϼ���!')
	uo_status.st_message.text = '����ȭ�鳻�� �������� ������ �����ϼ���!'
	return
end if
if idw_51.rowcount() = 0 then
	messagebox('Ȯ��','������ �ڷᰡ �����ϴ�!')
	uo_status.st_message.text = '������ �ڷᰡ �����ϴ�!'
	return
end if

IF f_bpmstcd_chk('200',ls_xyear,ls_revno, ls_msg) = -1  THEN  //����Ȯ��
	MessageBox('Ȯ��',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

////�μ��ڵ�Ȯ��
//IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
//	MessageBox('Ȯ��','�۾��� ���� ������ �����ϴ�!')
//	uo_status.st_message.text = '�۾��� ���� ������ �����ϴ�!'
//	Return
//END IF

uo_status.st_message.text = '������ �ڷḦ Ȯ����....'
f_null_chk(idw_51)

for ll_row = 1 to idw_51.rowcount()
	ls_itno   = trim(idw_51.object.yitno[ll_row])
	ls_xplant = trim(idw_51.object.yplant[ll_row])
	ls_div    = trim(idw_51.object.ydiv[ll_row])
	ls_vsrno  = trim(idw_51.object.yvndsr[ll_row])
	ls_xplan  = trim(idw_51.object.yplan[ll_row])
	ls_ychge  = trim(idw_51.object.ychge[ll_row])      //CD����
	ls_ycode1  = trim(idw_51.object.ycode1[ll_row])   //ǰ�񱸺�
//	ls_ycmcd = trim(idw_51.object.ycmcd[ll_row])
	ld_ycstr  =  idw_51.object.ycstr[ll_row]
	ld_ygcst  =  idw_51.object.ygcst[ll_row]
	
	uo_status.st_message.text = '��:' + string(ll_row) + ' �� �ڷḦ Ȯ����....'
	idw_51.scrolltorow(ll_row)
	idw_51.SelectRow(0,False)
   idw_51.SelectRow(ll_row,True)
//	////�⵵/��ü/ǰ�� ����ũ.
//	SELECT count(*)
//	INTO :ll_row  
//	FROM pbbpm.bpm509  
//	WHERE yccyy = :ls_xyear
//	and   yitno = :ls_itno
//	and   yvndsr = :ls_vsrno
//	//and   yplant = :ls_xplant
//	//and   ydiv = :ls_div
//	and   ygubun = '10';
//	if ll_row > 0 then
//		idw_51.retrieve(ls_xyear,ls_itno,ls_vsrno,'','','10')
//		messagebox('Ȯ��','��:' + string(ll_row) + ' �⵵/��ü/ǰ��������� �̹� �Էµ� ǰ���Դϴ�!')
//		uo_status.st_message.text = '��:' + string(ll_row) + ' �⵵/��ü/ǰ��������� �̹� �Էµ� ǰ���Դϴ�!'
//		return
//	end if
//	select count(*) into :ll_rcnt
//	from  pbpur.pur101
//	where comltd = '01'
//	and   scgubun = 'S'
//	and   digubun = 'D'
//	and   vsrno = :ls_vsrno;
//	if ll_rcnt = 0 then
//		messagebox('Ȯ��','��:' + string(ll_row) + ' ��ü�ڵ� Ȯ���ϼ���. ��ü�⺻����(PUR101)����!')
//		uo_status.st_message.text = '��:' + string(ll_row) + ' ��ü�ڵ� Ȯ���ϼ���. ��ü�⺻����(PUR101)����!'
//		return
//	end if
	if trim(ls_xplant) = '' or trim(ls_div) = '' then
		messagebox('Ȯ��','��:' + string(ll_row) + ' �Է½� ����,���� �ʼ��Դϴ�!',Exclamation!)
		uo_status.st_message.text = '��:' + string(ll_row) + ' �Է½� ����,���� �ʼ��Դϴ�!'
		return
	end if
	
	SELECT count(*), coalesce(max(itnm),''),
		 coalesce(max(spec),''),coalesce(max(xunit),'')
	INTO :ll_rcnt, :ls_itnm,:ls_spec,:ls_bomunit  
	FROM pbbpm.bpm502  
	WHERE xyear = :ls_xyear
	and   revno = :ls_revno
	and   itno = :ls_itno;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' �����ȹ ǰ��⺻����(BPM502)����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' �����ȹ ǰ��⺻����(BPM502)����!'
		return
	end if
	////�����ȹǰ������� Ȯ��
	SELECT count(*), coalesce(max(cls),''),
			 coalesce(max(srce),''),coalesce(max(pdcd),''),
			 coalesce(max(xunit),''),
			 coalesce(max(convqty),0),coalesce(max(comcd),'')
	INTO :ll_rcnt, :ls_cls,:ls_srce,:ls_pdcd,
		  :ls_xunit,:ld_convqty,:ls_ycmcd   
	FROM pbbpm.bpm503  
	WHERE xyear = :ls_xyear
	and   revno = :ls_revno
	and   xplant = :ls_xplant
	and   div = :ls_div
	and   itno = :ls_itno;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�, �����ȹ ǰ�������(BPM503)����!'
		return
	end if
	if ls_srce = '01' then
		messagebox('Ȯ��','��:' + string(ll_row) + ' �ش�ǰ���� ���ڷ� ��ϵǾ� �ֽ��ϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' �ش�ǰ���� ���ڷ� ��ϵǾ� �ֽ��ϴ�. �����ȹ ǰ�������(BPM503)�� Ȯ���Ͻʽÿ�!'
		return
	end if
//	////�����ȹBOM��Ͽ���	
//	SELECT count(*),coalesce(max(pedtm),''),coalesce(max(pedte),''),
//			 coalesce(max(popcd),'')
//	INTO :ll_rcnt,:ls_pedtm,:ls_pedte,:ls_popcd
//	FROM pbbpm.bpm504  
//	WHERE pcmcd = '01'
//	and   xyear = :ls_xyear
//	and   plant = :ls_xplant
//	and   pdvsn = :ls_div
//	and   (ppitn = :ls_itno or pcitn = :ls_itno)	;
//	if ll_rcnt = 0 then
//		messagebox('Ȯ��','��:' + string(ll_row) + ' �����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!')
//		uo_status.st_message.text = '��:' + string(ll_row) + ' �����ȹBOM�� ��Ͼȵ� ǰ���Դϴ�. �����ȹBOM����(BPM504)����!'
//		return
//	end if
	
	
	SELECT COUNT(*)
		INTO :ll_rcnt  
	FROM PBBPM.BPM503
	WHERE xyear = :ls_xyear  
	  and revno = :ls_revno
	  AND XPLANT = :ls_xplant
	  AND DIV    = :ls_div
	  AND ITNO   = :ls_itno
	USING SQLCA;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ����/����� ǰ���� ���� �ʽ��ϴ�. �����ȹǰ���(BPM503)���� ����!'
		return
	end if
	
//   SELECT count(*),coalesce(max(ycstr),0)
//	INTO :ll_rcnt, :ld_dcost 
//	FROM pbbpm.bpm509  
//	WHERE yccyy = :ls_xyear
//	and   yitno = :ls_itno
//	and   yvndsr = :ls_vsrno
//	//and   yplant = :ls_xplant
//	//and   ydiv = :ls_div
//	and   ygubun = '10';
//	if ll_rcnt = 0 then
//		messagebox('Ȯ��','��:' + string(ll_row) + ' �����ȹ�ܰ����� �����ϴ�!' )
//		uo_status.st_message.text = '��:' + string(ll_row) + ' �����ȹ�ܰ����� �����ϴ�!'
//		return
//	end if
	//***���Ŵ��
	SELECT COUNT(*)
		INTO :ll_rcnt  
	FROM PBcommon.dac002
	WHERE comltd  = '01'
	  AND cogubun = 'INV050'   //����,����,���ְ��ߴ��
	  AND cocode  = :ls_xplan;
	if ll_rcnt = 0 then
		messagebox('Ȯ��','��:' + string(ll_row) + ' ���Ŵ���ڵ� Ȯ���ϼ���! ��Ͼȵ��ڵ�.')
		uo_status.st_message.text = '��:' + string(ll_row) + ' ���Ŵ���ڵ� Ȯ���ϼ���! ��Ͼȵ��ڵ�.'
		return
	end if
next

ll_rtn = MessageBox("Ȯ��","�ش� �ڷḦ Ȯ���մϴ�. Ȯ�ι�ư�� ��������!", + &
							 Exclamation!, OKCancel!, 2)
IF ll_rtn = 2 Then
  uo_status.st_message.text	=  f_message("D030")	 						  
  return
end if

uo_status.st_message.text = '�ڷ� Ȯ�οϷ�.  �ڷ� �����غ���....'
sqlca.autocommit = false

for ll_row = 1 to idw_51.rowcount()
	ls_itno   = trim(idw_51.object.yitno[ll_row])
	ls_xplant = trim(idw_51.object.yplant[ll_row])
	ls_div    = trim(idw_51.object.ydiv[ll_row])
	ls_vsrno  = trim(idw_51.object.yvndsr[ll_row])
	ls_xplan  = trim(idw_51.object.yplan[ll_row])
	ls_ychge  = trim(idw_51.object.ychge[ll_row])      //CD����
	ls_ycode1  = trim(idw_51.object.ycode1[ll_row])   //ǰ�񱸺�
//	ls_ycmcd = trim(idw_51.object.ycmcd[ll_row])
	ld_ycstr  =  idw_51.object.ycstr[ll_row]
	ld_ygcst  =  idw_51.object.ygcst[ll_row]
	
	uo_status.st_message.text = '��:' + string(ll_row) + ' �� �ڷḦ ������....'
	idw_51.scrolltorow(ll_row)
	idw_51.SelectRow(0,False)
   idw_51.SelectRow(ll_row,True)
	
	
//	////ǰ��⺻���� Ȯ��
//	SELECT count(*), coalesce(max(itnm),''),
//		 coalesce(max(spec),''),coalesce(max(xunit),'')
//	INTO :ll_rcnt, :ls_itnm,:ls_spec,:ls_bomunit  
//	FROM pbbpm.bpm502  
//	WHERE xyear = :ls_xyear
//	and   itno = :ls_itno;
//	////�����ȹǰ������� Ȯ��
//	SELECT count(*), coalesce(max(cls),''),
//			 coalesce(max(srce),''),coalesce(max(pdcd),''),
//			 coalesce(max(xunit),''),
//			 coalesce(max(convqty),0),coalesce(max(comcd),'')
//	INTO :ll_rcnt, :ls_cls,:ls_srce,:ls_pdcd,
//		  :ls_xunit,:ld_convqty,:ls_ycmcd   
//	FROM pbbpm.bpm503  
//	WHERE xyear = :ls_xyear
//	and   xplant = :ls_xplant
//	and   div = :ls_div
//	and   itno = :ls_itno;
	


   if ls_xplant = 'Y' then                    //���ֿ�
		f_pur040_setxplan1(ls_itno,ls_xplan)
	else
		f_pur040_setxplan(ls_itno,ls_xplan)
	end if
	//�����ȹǰ���
	update pbbpm.bpm503
		set xplan = :ls_xplan
	where xyear = :ls_xyear
	and   revno = :ls_revno
	and   itno = :ls_itno;
   
  
	
	   update pbbpm.bpm509
		   set yplan = :ls_xplan,
				 updtid = :g_s_empno,
				 updtdt = :g_s_datetime
		where yccyy = :ls_xyear
		and   revno = :ls_revno
		and   yitno = :ls_itno;
		//and   yvndsr = :ls_vsrno;
		IF sqlca.sqlnrows <= 0 THEN  ////����� ������ �޴� ���� ��
			uo_status.st_message.text	=  '��:' + string(ll_row) + ' �����ȹ�ܰ�(BPM509)���� ������ �����߻�!. ���� �����ٶ��ϴ�!'
			MessageBox("Ȯ��",'��:' + string(ll_row) + ' �����ȹ�ܰ�(BPM509)���� ������ �����߻�!. ���� �����ٶ��ϴ�!')
			messagebox('Ȯ��','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
			Rollback Using sqlca;
			sqlca.autocommit = true
			Return
		end if	
		
next

Commit Using sqlca;
sqlca.autocommit = true
uo_status.st_message.text = string(idw_51.rowcount()) + '���� �����ȹ�ܰ��� �Է� �Ǵ� �����Ǿ����ϴ�.'
idw_51.Reset()

setpointer(arrow!)
			
	
end event

type st_5 from statictext within tabpage_5
integer x = 699
integer y = 108
integer width = 2857
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(���� �ڷ�� �ű��Է�, �����ڷ�� �����˴ϴ�.���ű��شܰ��� �ű��Է� ���� �ݿ���.)"
boolean focusrectangle = false
end type

type dw_50 from datawindow within tabpage_5
integer x = 32
integer y = 20
integer width = 626
integer height = 92
integer taborder = 40
string title = "none"
string dataobject = "d_bpm301u_30"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;f_pur_protecton(this)
f_pur_gray(this)

this.settransobject(sqlca)
idw_50 = this
This.getChild("div", idwc_1)
idwc_1.SetTransObject(SQLCA)
idwc_1.retrieve('D')	
this.insertrow(0)

string ls_xyear, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)

f_pur040_nullchk03(this)
end event

type st_3 from statictext within tabpage_5
integer x = 699
integer y = 32
integer width = 1920
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "(��ȸ���������� ���ε�, Ȯ���� ����������� ��������)"
boolean focusrectangle = false
end type

type dw_51 from datawindow within tabpage_5
integer x = 9
integer y = 188
integer width = 4526
integer height = 2168
integer taborder = 50
string title = "none"
string dataobject = "d_bpm301u_51"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_51 = this
end event

event dberror;//messagebox("A",sqldbcode)
//messagebox("A",sqlerrtext)
//messagebox("A",sqlsyntax)
end event

event clicked;if isnull(row) then
	row = getrow()
end if

//This.SelectRow(0,False)
//This.SelectRow(row,True)
f_pur040_mselect(this, row)  //reference 'this'���Ұ�, ����������
//�ڷ���� �κ� Ŭ���� ���� ����

//IF dwo.name = "datawindow" Then
//	This.SelectRow(0,false)
//End IF
//setpointer(hourglass!)
//IF row < 1  THEN
//	this.SetRedraw(False)
//   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
//		this.setsort(is_colnm)
//      this.sort()
//	 END IF
//	 this.SetRedraw(True)
//	 return
//END IF







end event

type tabpage_6 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "�۾��̷���ȸ"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_61 dw_61
dw_60 dw_60
pb_1 pb_1
end type

on tabpage_6.create
this.dw_61=create dw_61
this.dw_60=create dw_60
this.pb_1=create pb_1
this.Control[]={this.dw_61,&
this.dw_60,&
this.pb_1}
end on

on tabpage_6.destroy
destroy(this.dw_61)
destroy(this.dw_60)
destroy(this.pb_1)
end on

type dw_61 from datawindow within tabpage_6
integer x = 5
integer y = 144
integer width = 4553
integer height = 2180
integer taborder = 110
string title = "none"
string dataobject = "d_bpm201u_31"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_colnm) = 1 THEN
   	f_dw_sort(THIS,is_colnm)
   END IF
END IF
THIS.SetRedraw(True)

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
else
   return	
end if	


end event

event constructor;idw_61 = this
This.SetTransObject(Sqlca)
//is_orgsql1 = This.getsqlselect()


//// ���� ����
//This.getchild("cls",i_dwc_cls)  
//i_dwc_cls.SetTransObject(sqlca)	
//i_dwc_cls.retrieve('INV020')
//	
//// ���Լ� ����
//This.getchild("srce",i_dwc_srce) 
//i_dwc_srce.SetTransObject(sqlca)	
//i_dwc_srce.retrieve('DAC040')
//
//// ������	
//This.getchild("mlan",i_dwc_mlan) 
//i_dwc_mlan.SetTransObject(sqlca)	
//i_dwc_mlan.retrieve('INV070')
	
// ���Ŵ��
//This.getchild("xplan",i_dwc_plan) 
//i_dwc_plan.SetTransObject(sqlca)	
//i_dwc_plan.retrieve('INV050')	

end event

event retrieveend;
//idw_dw5.Object.tdte4_1.Protect = "0~tif ( chk = 1, 0, 1 )"
//i_dwc_mlan.retrieve('INV070')
end event

type dw_60 from datawindow within tabpage_6
event ue_key_down pbm_dwnkey
integer x = 18
integer y = 16
integer width = 1705
integer height = 104
integer taborder = 20
string title = "none"
string dataobject = "d_bpm201u_30"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;If key = KeyEnter! Then
	iw_Sheet.TriggerEvent('ue_retrieve')
End If
end event

event constructor;this.SetTransObject(Sqlca)
idw_60 = this
// ����
//This.getchild("xplant",idwc_1)       
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('SLE220')
	
//// ����
//This.getchild("div",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('D')

//// ��ǰ ����
//This.getchild("pdcd",idwc_1)       
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('')
//	
// ���� ����
//This.getchild("cls",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV021')
	
//// ���Լ� ����
//This.getchild("srce",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('10')


This.insertrow(0)
string ls_xyear, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)

f_pur040_nullchk03(this)

end event

event itemchanged;if isnull(data) then
	data = ''
end if
//String ls_data, ls_colnm, ls_null
//
//This.AcceptText()
//ls_colnm = This.GetColumnName()
//IF ls_colnm = 'xplant' Then
//   idw_20.SetItem(1,'div', ' ' ) //SetNull(ls_null))
//   ls_data = idw_20.GetItemString(1,'xplant')
//   idw_20.GetChild("div",idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(ls_data)
//END IF
//
//IF ls_colnm = 'div' Then
//	idw_20.SetItem(1,'pdcd', ' ')
//   idw_20.GetChild('pdcd', idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(data) 
//END IF
//
//IF ls_colnm = 'cls' Then
//   idw_20.SetItem(1,'srce', ' ' ) //SetNull(ls_null))
//   ls_data = idw_20.GetItemString(1,'cls')
//   idw_20.GetChild("srce",idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(ls_data)
//END IF
end event

event itemerror;return 1 
end event

type pb_1 from picturebutton within tabpage_6
boolean visible = false
integer x = 4000
integer y = 12
integer width = 155
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
If idw_31.RowCount( ) = 0 Then
	MessageBox('Ȯ��!', '������ ������ ������ �����ϴ�. ��ȸ�� �۾��ϼ���.')
	uo_status.st_message.text = '������ ������ ������ �����ϴ�. ��ȸ�� �۾��ϼ���.'
	Return
End If
f_Save_To_Excel( idw_31)
setpointer(arrow!)
return



		
	

end event

type tabpage_7 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4549
integer height = 2364
long backcolor = 12632256
string text = "��޿ϼ�ǰ��ȸ"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_17 st_17
st_16 st_16
dw_70 dw_70
dw_71 dw_71
end type

on tabpage_7.create
this.st_17=create st_17
this.st_16=create st_16
this.dw_70=create dw_70
this.dw_71=create dw_71
this.Control[]={this.st_17,&
this.st_16,&
this.dw_70,&
this.dw_71}
end on

on tabpage_7.destroy
destroy(this.st_17)
destroy(this.st_16)
destroy(this.dw_70)
destroy(this.dw_71)
end on

type st_17 from statictext within tabpage_7
integer x = 1307
integer y = 100
integer width = 1664
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "ǰ�ǽ� �����޴ܰ��� �ߴܻ������ �ְ� ����"
boolean focusrectangle = false
end type

type st_16 from statictext within tabpage_7
integer x = 1303
integer y = 28
integer width = 2729
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���شܰ�(10),�켱����(1),���Լ�(01,02,04,05,06)������ BOM������������(8888)�ڷ� ����"
boolean focusrectangle = false
end type

type dw_70 from datawindow within tabpage_7
event ue_key_down pbm_dwnkey
integer x = 18
integer y = 16
integer width = 1275
integer height = 104
integer taborder = 50
string title = "none"
string dataobject = "d_bpm301u_70"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;If key = KeyEnter! Then
	iw_Sheet.TriggerEvent('ue_retrieve')
End If
end event

event constructor;this.SetTransObject(Sqlca)
idw_70 = this
//// ����
////This.getchild("xplant",idwc_1)       
////idwc_1.SetTransObject(sqlca)	
////idwc_1.retrieve('SLE220')
//	
////// ����
////This.getchild("div",idwc_1)  
////idwc_1.SetTransObject(sqlca)	
////idwc_1.retrieve('D')

This.insertrow(0)
string ls_xyear, ls_stcd
SELECT coalesce(max(xyear || revno),''),
       coalesce(max(ingflag),'')    
INTO :ls_xyear, :ls_stcd  
FROM pbbpm.bpm519
WHERE comltd = '01';

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)

f_pur040_nullchk03(this)
//
end event

event itemchanged;Choose case dwo.name
	case 'gubun'

   if data = 'A' then  //SUM
	   idw_71.dataobject = 'd_bpm301u_71a'
	else   //RAW
		idw_71.dataobject = 'd_bpm301u_71'
	end if
   idw_71.settransobject(sqlca)
END Choose
//
//IF ls_colnm = 'div' Then
//	idw_20.SetItem(1,'pdcd', ' ')
//   idw_20.GetChild('pdcd', idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(data) 
//END IF


end event

event itemerror;return 1 
end event

type dw_71 from datawindow within tabpage_7
integer x = 5
integer y = 180
integer width = 4539
integer height = 2180
integer taborder = 120
string title = "none"
string dataobject = "d_bpm301u_71"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_colnm) = 1 THEN
   	f_dw_sort(THIS,is_colnm)
   END IF
END IF
THIS.SetRedraw(True)

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
else
   return	
end if	


end event

event constructor;idw_71 = this
This.SetTransObject(Sqlca)
//is_orgsql1 = This.getsqlselect()


//// ���� ����
//This.getchild("cls",i_dwc_cls)  
//i_dwc_cls.SetTransObject(sqlca)	
//i_dwc_cls.retrieve('INV020')
//	
//// ���Լ� ����
//This.getchild("srce",i_dwc_srce) 
//i_dwc_srce.SetTransObject(sqlca)	
//i_dwc_srce.retrieve('DAC040')
//
//// ������	
//This.getchild("mlan",i_dwc_mlan) 
//i_dwc_mlan.SetTransObject(sqlca)	
//i_dwc_mlan.retrieve('INV070')
	
// ���Ŵ��
//This.getchild("xplan",i_dwc_plan) 
//i_dwc_plan.SetTransObject(sqlca)	
//i_dwc_plan.retrieve('INV050')	

end event

event retrieveend;
//idw_dw5.Object.tdte4_1.Protect = "0~tif ( chk = 1, 0, 1 )"
//i_dwc_mlan.retrieve('INV070')
end event

