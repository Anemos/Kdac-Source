$PBExportHeader$w_wip053c.srw
$PBExportComments$�ǻ���ǰ�� ���
forward
global type w_wip053c from w_origin_sheet06
end type
type gb_2 from groupbox within w_wip053c
end type
type gb_1 from groupbox within w_wip053c
end type
type st_1 from statictext within w_wip053c
end type
type st_a1 from statictext within w_wip053c
end type
type st_3 from statictext within w_wip053c
end type
type st_daesang from statictext within w_wip053c
end type
type st_55 from statictext within w_wip053c
end type
type st_saeng from statictext within w_wip053c
end type
type uo_1 from uo_progress_bar within w_wip053c
end type
type dw_1 from datawindow within w_wip053c
end type
type cb_1 from commandbutton within w_wip053c
end type
type sle_1 from singlelineedit within w_wip053c
end type
type uo_2 from uo_yymm_boongi within w_wip053c
end type
type st_2 from statictext within w_wip053c
end type
type p_1 from picture within w_wip053c
end type
type p_2 from picture within w_wip053c
end type
type st_4 from statictext within w_wip053c
end type
type st_5 from statictext within w_wip053c
end type
type dw_2 from u_vi_std_datawindow within w_wip053c
end type
type dw_3 from u_vi_std_datawindow within w_wip053c
end type
type cb_save from commandbutton within w_wip053c
end type
type pb_down from picturebutton within w_wip053c
end type
type dw_4 from datawindow within w_wip053c
end type
type pb_realdown from picturebutton within w_wip053c
end type
type st_6 from statictext within w_wip053c
end type
type st_7 from statictext within w_wip053c
end type
type st_10 from statictext within w_wip053c
end type
type st_11 from statictext within w_wip053c
end type
type cb_retrieve from commandbutton within w_wip053c
end type
type st_8 from statictext within w_wip053c
end type
type st_9 from statictext within w_wip053c
end type
type gb_3 from groupbox within w_wip053c
end type
type gb_4 from groupbox within w_wip053c
end type
type ln_1 from line within w_wip053c
end type
end forward

global type w_wip053c from w_origin_sheet06
event ue_init ( )
gb_2 gb_2
gb_1 gb_1
st_1 st_1
st_a1 st_a1
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
uo_2 uo_2
st_2 st_2
p_1 p_1
p_2 p_2
st_4 st_4
st_5 st_5
dw_2 dw_2
dw_3 dw_3
cb_save cb_save
pb_down pb_down
dw_4 dw_4
pb_realdown pb_realdown
st_6 st_6
st_7 st_7
st_10 st_10
st_11 st_11
cb_retrieve cb_retrieve
st_8 st_8
st_9 st_9
gb_3 gb_3
gb_4 gb_4
ln_1 ln_1
end type
global w_wip053c w_wip053c

type variables
dec i_n_complete
end variables

event ue_init();String ls_adjdt, ls_stscd

SELECT DISTINCT WZSTDT, WZLSTSCD INTO :ls_adjdt, :ls_stscd
FROM PBWIP.WIP090
using sqlca;

uo_2.uf_reset(integer(mid(ls_adjdt,1,4)),integer(mid(ls_adjdt,5,2)))
end event

on w_wip053c.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.st_a1=create st_a1
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.uo_2=create uo_2
this.st_2=create st_2
this.p_1=create p_1
this.p_2=create p_2
this.st_4=create st_4
this.st_5=create st_5
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_save=create cb_save
this.pb_down=create pb_down
this.dw_4=create dw_4
this.pb_realdown=create pb_realdown
this.st_6=create st_6
this.st_7=create st_7
this.st_10=create st_10
this.st_11=create st_11
this.cb_retrieve=create cb_retrieve
this.st_8=create st_8
this.st_9=create st_9
this.gb_3=create gb_3
this.gb_4=create gb_4
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_a1
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_daesang
this.Control[iCurrent+7]=this.st_55
this.Control[iCurrent+8]=this.st_saeng
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.sle_1
this.Control[iCurrent+13]=this.uo_2
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.p_1
this.Control[iCurrent+16]=this.p_2
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.st_5
this.Control[iCurrent+19]=this.dw_2
this.Control[iCurrent+20]=this.dw_3
this.Control[iCurrent+21]=this.cb_save
this.Control[iCurrent+22]=this.pb_down
this.Control[iCurrent+23]=this.dw_4
this.Control[iCurrent+24]=this.pb_realdown
this.Control[iCurrent+25]=this.st_6
this.Control[iCurrent+26]=this.st_7
this.Control[iCurrent+27]=this.st_10
this.Control[iCurrent+28]=this.st_11
this.Control[iCurrent+29]=this.cb_retrieve
this.Control[iCurrent+30]=this.st_8
this.Control[iCurrent+31]=this.st_9
this.Control[iCurrent+32]=this.gb_3
this.Control[iCurrent+33]=this.gb_4
this.Control[iCurrent+34]=this.ln_1
end on

on w_wip053c.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_a1)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_save)
destroy(this.pb_down)
destroy(this.dw_4)
destroy(this.pb_realdown)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.cb_retrieve)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.ln_1)
end on

event ue_bcreate;decimal    l_n_totalcnt,l_n_loopcnt
decimal{4} l_n_phqt
string     l_s_plant,l_s_dvsn,l_s_itno, l_s_dept, l_s_year, l_s_month
integer    Net,l_n_chkcount

Net = messagebox("Ȯ ��", "�ش� ����, ���忡 ���� ������ �ǻ����ǰ���� ��� �����˴ϴ�. ~r" &
	+ "�ڷ���� �۾��� ���� �ϰڽ��ϱ�?",Question!, OkCancel!, 2)
if Net <> 1 then
	return 0
end if

setpointer(HourGlass!)
dw_1.accepttext()

l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "�ڷ� ó����(���� Ȯ����)..."

do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	
	l_s_plant = trim(dw_1.object.wjplant[l_n_loopcnt])
	l_s_dvsn  = trim(dw_1.object.wjdvsn[l_n_loopcnt])
	l_s_itno  = trim(dw_1.object.wjitno[l_n_loopcnt])
	l_s_dept  = trim(dw_1.object.wjdept[l_n_loopcnt])
	l_s_year 	 = trim(dw_1.object.wjyear[l_n_loopcnt])
	l_s_month  = trim(dw_1.object.wjmonth[l_n_loopcnt])
	
	if trim(dw_1.object.wjcmcd[l_n_loopcnt]) <> '01' then
		messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " + "ȸ�� �ڵ� ����  = " + l_s_plant)
      uo_status.st_message.text = f_message("E310")		//�ڷḦ ������ ó���ٶ��ϴ�.		
		return 0
	end if
	if f_spacechk(f_get_coflname('01','SLE220', l_s_plant)) = -1 then
		messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " + "���� �ڵ� ����  = " + l_s_plant)
      uo_status.st_message.text = f_message("E310")		//�ڷḦ ������ ó���ٶ��ϴ�.		
		return 0
	end if
	if f_spacechk(f_get_coflname('01','DAC030', l_s_dvsn)) = -1 then
		messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " +"���� �ڵ� ���� =  " + l_s_dvsn)
      uo_status.st_message.text = f_message("E310")		//�ڷḦ ������ ó���ٶ��ϴ�.		
		return 0
	end if
	
//	select count(*) into:l_n_chkcount from pbcommon.dac002
//		where comltd = :g_s_company and cogubun = 'DAC150' and 
//			cocode = :l_s_dept using sqlca;
//	if sqlca.sqlcode <> 0 or l_n_chkcount = 0 then
//		messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " +"���ڵ� ���� =  " + l_s_itno)
//      uo_status.st_message.text = f_message("E310")		//�ڷḦ ������ ó���ٶ��ϴ�.	
//		return
//	end if
	if len(l_s_dept) > 4 or l_s_dept = '9999' then
		messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " +"���ڵ� ���� =  " + l_s_itno)
		return 0
	end if
	
	select count(*) into:l_n_chkcount from pbinv.inv101
		where comltd = :g_s_company and xplant = :l_s_plant and 
				div = :l_s_dvsn and itno = :l_s_itno using sqlca;
	if sqlca.sqlcode <> 0 or l_n_chkcount = 0 then
		messagebox("�ڷ� ����",string(l_n_loopcnt) + "Row�� " +"ǰ �� ���� =  " + l_s_itno)
      uo_status.st_message.text = f_message("E310")		//�ڷḦ ������ ó���ٶ��ϴ�.	
		return 0
	end if
	
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

// �ǻ� ����üũ
if Not f_wip_check_applystatus('01',l_s_plant,l_s_dvsn, l_s_year + l_s_month) then
	uo_status.st_message.text = "�ǻ����� �ƴϰų� �ǻ簡 Ȯ���Ǿ����ϴ�."
	return -1
end if

uo_status.st_message.text = "���� ����. ������..."

Delete From PBWIP.WIP011
Where wjyear = :l_s_year and wjmonth = :l_s_month and
	wjcmcd = '01' and wjplant = :l_s_plant and wjdvsn = :l_s_dvsn
using sqlca;

if dw_1.update() <> 1 then
	messagebox("Error",string(sqlca.sqlcode) + sqlca.sqlerrtext)
	uo_status.st_message.text = f_message("U020")
	return 0
end if
uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//������ �Ǿ����ϴ�.

//Icon ����(�����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03
dw_1.settransobject(Sqlca)
dw_2.settransobject(Sqlca)
dw_3.settransobject(Sqlca)
dw_4.settransobject(sqlca)

dw_4.getchild("wip001_waplant",dwc_01)
	dwc_01.settransobject(sqlca)
	dwc_01.retrieve('SLE220')
dw_4.getchild("wip001_wadvsn",dwc_02)
	dwc_02.settransobject(sqlca)
	dwc_02.retrieve('D')
dw_4.getchild("inv101_pdcd",dwc_03)
	dwc_03.settransobject(sqlca)
	dwc_03.retrieve('A')
dw_4.insertrow(0)
// �����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(true, true, false, true, i_b_dchar)

This.PostEvent('ue_init')
end event

event close;call super::close;disconnect using sqlcs;
end event

type uo_status from w_origin_sheet06`uo_status within w_wip053c
end type

type gb_2 from groupbox within w_wip053c
integer x = 2235
integer y = 756
integer width = 2011
integer height = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "[ó������]"
end type

type gb_1 from groupbox within w_wip053c
integer x = 2235
integer y = 552
integer width = 2011
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
end type

type st_1 from statictext within w_wip053c
integer x = 110
integer y = 100
integer width = 1934
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "��  EXCEL �ڷ� LOAD  ��"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_a1 from statictext within w_wip053c
integer x = 2190
integer y = 244
integer width = 2345
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "1. �ڷ��θ� ���� ���������� �����ѵ� ���ε� Ȯ�� �Ͻʽÿ�. ( ���ڵ� 9999�� ������ )"
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip053c
integer x = 2363
integer y = 624
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "���Ǽ�"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_wip053c
integer x = 2688
integer y = 612
integer width = 389
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_55 from statictext within w_wip053c
integer x = 3355
integer y = 624
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "�����Ǽ�"
boolean focusrectangle = false
end type

type st_saeng from statictext within w_wip053c
integer x = 3694
integer y = 612
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_wip053c
event destroy ( )
integer x = 2501
integer y = 824
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_wip053c
integer x = 123
integer y = 220
integer width = 2007
integer height = 612
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053c_upload"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;//return 1
end event

event itemerror;return 1
end event

type cb_1 from commandbutton within w_wip053c
integer x = 343
integer y = 860
integer width = 302
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ڷ���"
end type

event clicked;//string ls_pathname,ls_filename
//GetFileOpenName("Select File", ls_pathname, ls_filename, "txt","Text Files (*.txt),*.txt,")
//sle_1.text = ls_pathname

string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

// UPLOAD�� ���������� �����Ѵ�
//
ll_rtn = GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")
if ll_rtn = 0 then
	return 0
end if
setpointer(hourglass!)
// ������ ���������� �ؽ�Ʈ ���Ϸ� ���� �ٲ۴�.(test.xls => test.txt)
//
ls_name = Mid(ls_docname, 1, Len(Trim(ls_docname)) -3) + 'txt'

// ������ �������ϸ�� ������ �ؽ�Ʈ ���ϸ��� ���翩�θ� üũ�Ѵ�
//
IF FileExists(ls_name) = TRUE THEN
	MessageBox('Ȯ ��', '�ش纯ȯ ������ �����մϴ�')
	RETURN
END IF

// ����Ÿ������ �ʱ�ȭ
//
dw_1.ReSet()

// �ű� ������Ʈ ����
//
lole_UploadObject = CREATE OLEObject

// ���� ������Ʈ�� �����Ѵ�
//
ll_rtn = lole_UploadObject.ConnectToNewObject("excel.application") 

IF ll_rtn = 0 THEN
	// �������� ���õ� ���������� �����Ѵ�
	//
	lole_UploadObject.workbooks.Open(ls_docname)
	// ���µ� ���������� �ؽ�Ʈ ���Ϸ� �����Ѵ�(3:text ������ ����)
	//
	lole_UploadObject.application.workbooks(1).saveas(ls_name, 3)
	// ���µ� ���������� �ݴ´�(���������� Ȯ������ �ʴ´�Close(0))
	//
	lole_UploadObject.application.workbooks(1).close(0)
	// ���� ������Ʈ�� ������ �����Ѵ�
	//
	lole_UploadObject.DisConnectObject()   
ELSE
	// ���� ������Ʈ�� ������ �����Ѵ�
	//
	lole_UploadObject.DisConnectObject()   
	//Excel�� ���� ����!
	//
	MessageBox("ConnectToNewObject Error!",string(ll_rtn))
END IF

// �ű� ������Ʈ�� �޸𸮿��� ����
//
DESTROY lole_UploadObject

// �ؽ�Ʈ ���Ϸ� ����� ����� ����Ÿ�����쿡 ����Ʈ��Ų��(Ÿ��Ʋ�� ������ 2���κ���)
// ����Ʈ�� �Ϸ�Ǹ� �ؽ�Ʈ ������ �����Ѵ�
//
ll_rtn = dw_1.ImportFile(ls_name, 2) 
IF ll_rtn > 0 THEN
	filedelete(ls_name)
ELSE
	// ����Ʈ ERROR
	//
	CHOOSE CASE ll_rtn
		CASE 0
			MessageBox("Ȯ ��", 'End of file; too many rows')
		CASE -1
			MessageBox("Ȯ ��", 'No rows')
		CASE -2
			MessageBox("Ȯ ��", 'Empty file')
		CASE -3
			MessageBox("Ȯ ��", 'Invalid argument')
		CASE -4
			MessageBox("Ȯ ��", 'Invalid input')
		CASE -5
			MessageBox("Ȯ ��", 'Could not open the file')
		CASE -6
			MessageBox("Ȯ ��", 'Could not close the file')
		CASE -7
			MessageBox("Ȯ ��", 'Error reading the text')
		CASE -8
			MessageBox("Ȯ ��", 'Not a TXT file')
	END CHOOSE
END IF

st_daesang.text = string(dw_1.rowcount())
end event

type sle_1 from singlelineedit within w_wip053c
integer x = 663
integer y = 860
integer width = 1266
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_2 from uo_yymm_boongi within w_wip053c
integer x = 389
integer y = 1220
integer taborder = 30
boolean bringtotop = true
end type

on uo_2.destroy
call uo_yymm_boongi::destroy
end on

type st_2 from statictext within w_wip053c
integer x = 78
integer y = 1232
integer width = 306
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���س��"
boolean focusrectangle = false
end type

type p_1 from picture within w_wip053c
integer x = 1934
integer y = 1628
integer width = 206
integer height = 272
integer taborder = 70
boolean bringtotop = true
string picturename = "C:\kdac\bmp\userright.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;long	ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long	ll_SaveRow[] 

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_2.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_2.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ����ȭ���� ���õ� �ڷḦ ����ȭ������ �̵��Ѵ�
// 
FOR ll_row = 1 TO ll_index - 1
	// ����ȭ�鿡 ���྿�� ����鼭 ����ȭ���� �ڷḦ ����ȭ�鿡 ��Ʈ�Ѵ�
	//
//	ll_LastRow = dw_3.InsertRow(0)
//	dw_3.SetItem(ll_LastRow, 'twyear'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'wjyear'))
//	dw_3.SetItem(ll_LastRow, 'twmonth'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'wjmonth'))
//	dw_3.SetItem(ll_LastRow, 'twcmcd'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'wjcmcd'))
//	dw_3.SetItem(ll_LastRow, 'twplant'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'wjplant'))
//	dw_3.SetItem(ll_LastRow, 'twdvsn'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'wjdvsn'))
//	dw_3.SetItem(ll_LastRow, 'twpdcd'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'pdcd'))
//	dw_3.SetItem(ll_LastRow, 'twitno'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'wjitno'))
//	dw_3.SetItem(ll_LastRow, 'twitnm'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'itnm'))
//	dw_3.SetItem(ll_LastRow, 'twcls'		, dw_2.GetitemString(ll_SaveRow[ll_row], 'cls'))
//	dw_3.SetItem(ll_LastRow, 'twsrce'	, dw_2.GetitemString(ll_SaveRow[ll_row], 'srce'))
//	dw_3.SetItem(ll_LastRow, 'twchk'	, 'X')
	dw_2.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_2.GetSelectedRow(0)

// �̵��� ���� ����ȭ���� �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_2.RowCount() to 1 step -1
	IF dw_2.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_2.DeleteRow(ll_row)
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
//IF ll_select_row >= dw_2.RowCount() THEN
//	f_SetHighlight(dw_2, dw_2.RowCount(), True)	
//ELSE
//	f_SetHighlight(dw_2, ll_select_row, True)	
//END IF
//
//f_sethighlight(dw_3,dw_3.RowCount(),TRUE)


end event

type p_2 from picture within w_wip053c
integer x = 1934
integer y = 1992
integer width = 206
integer height = 272
integer taborder = 80
boolean bringtotop = true
string picturename = "C:\kdac\bmp\userleft.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;long	ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long	ll_SaveRow[] 

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_3.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	MessageBox("Ȯ��","���õ����� �����ϴ�.")
	RETURN 0
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_3.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ������ȭ���� ���õ��࿡ ����ǥ�ø� ��Ʈ�Ѵ�
//
FOR ll_row = 1 TO ll_index - 1
	ll_LastRow = dw_2.InsertRow(0)
	dw_2.SetItem(ll_LastRow, 'wjyear'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twyear'))
	dw_2.SetItem(ll_LastRow, 'wjmonth'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twmonth'))
	dw_2.SetItem(ll_LastRow, 'wjcmcd'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twcmcd'))
	dw_2.SetItem(ll_LastRow, 'wjplant'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twplant'))
	dw_2.SetItem(ll_LastRow, 'wjdvsn'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twdvsn'))
	dw_2.SetItem(ll_LastRow, 'pdcd'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twpdcd'))
	dw_2.SetItem(ll_LastRow, 'wjitno'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twitno'))
	dw_2.SetItem(ll_LastRow, 'itnm'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twitnm'))
	dw_2.SetItem(ll_LastRow, 'cls'		, dw_3.GetitemString(ll_SaveRow[ll_row], 'twcls'))
	dw_2.SetItem(ll_LastRow, 'srce'	, dw_3.GetitemString(ll_SaveRow[ll_row], 'twsrce'))
	dw_2.SetItem(ll_LastRow, 'wjdept', dw_3.GetitemString(ll_SaveRow[ll_row], 'twkct'))
	
	dw_3.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'N')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_3.GetSelectedRow(0)

// �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_3.RowCount() to 1 step -1
	IF dw_3.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_3.DeleteRow(ll_row)
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_2.RowCount() THEN
	f_SetHighlight(dw_2, dw_2.RowCount(), True)	
ELSE
	f_SetHighlight(dw_2, ll_select_row, True)	
END IF

f_sethighlight(dw_2,dw_2.RowCount(),TRUE)


end event

type st_4 from statictext within w_wip053c
integer x = 41
integer y = 1376
integer width = 937
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12639424
string text = "����ǻ� ���ǰ��"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_5 from statictext within w_wip053c
integer x = 2171
integer y = 1376
integer width = 1120
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12639424
string text = "����ǻ� ���ǰ��"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_2 from u_vi_std_datawindow within w_wip053c
integer x = 37
integer y = 1472
integer width = 1865
integer height = 952
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_wip053c_left"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;string ls_colname, ls_chkdata

ls_colname = dwo.name

if ls_colname = 'wjdept' then
	if data = '9999' then
		messagebox("�˸�","9999 �� ���ڵ�� ����� �� �����ϴ�.")
		This.setitem(1,'wjdept','0000')
		return 1
	end if
end if
end event

type dw_3 from u_vi_std_datawindow within w_wip053c
integer x = 2171
integer y = 1472
integer width = 2414
integer height = 952
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_wip053c_right"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_save from commandbutton within w_wip053c
integer x = 1047
integer y = 1372
integer width = 384
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;dw_2.accepttext()

if dw_2.update() = 1 then
	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if
end event

type pb_down from picturebutton within w_wip053c
integer x = 3346
integer y = 1372
integer width = 192
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_3.rowcount() < 1 then
	uo_status.st_message.text = '������ ������ ����Ÿ�� �����ϴ�.'
	return 0
end if
f_save_to_excel(dw_3)
end event

type dw_4 from datawindow within w_wip053c
integer x = 914
integer y = 1188
integer width = 2811
integer height = 144
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053c_02"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_null, ls_dvsn
datawindowchild cdw_1, cdw_2

This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF
end event

type pb_realdown from picturebutton within w_wip053c
integer x = 1481
integer y = 1372
integer width = 192
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_2.rowcount() < 1 then
	uo_status.st_message.text = '������ ������ ����Ÿ�� �����ϴ�.'
	return 0
end if
f_save_to_excel(dw_2)
end event

type st_6 from statictext within w_wip053c
integer x = 2190
integer y = 148
integer width = 2126
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "*** �ش���庰�� ������ϵ� �ǻ�ǰ���� ������ �ڿ� ������ϹǷ� �����Ͻʽÿ�."
boolean focusrectangle = false
end type

type st_7 from statictext within w_wip053c
integer x = 2190
integer y = 76
integer width = 1879
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "*** ���庰 KeyMan�۾�!"
boolean focusrectangle = false
end type

type st_10 from statictext within w_wip053c
integer x = 2190
integer y = 412
integer width = 2263
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "3. ����,������ ������ ������ ��ȸ��ư�� Ŭ���Ͽ� ���ǰ��� ���ǰ���� Ȯ���Ѵ�."
boolean focusrectangle = false
end type

type st_11 from statictext within w_wip053c
integer x = 2190
integer y = 492
integer width = 2130
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "4. ���ǰ�񿡼� �����ư�� ����Ͽ� ���ڵ带 �����Ҽ� �ִ�."
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_wip053c
integer x = 3877
integer y = 1220
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��ȸ"
end type

event clicked;dec{0} ld_yyyymm
string ls_adjdt, ls_year, ls_month, ls_plant, ls_dvsn, ls_mysql, ls_pdcd
long ll_rowcnt

dw_2.reset()
dw_3.reset()

ld_yyyymm     = uo_2.uf_yyyymm()
ls_adjdt        = string(ld_yyyymm)
ls_year  = mid(ls_adjdt,1,4)
ls_month = mid(ls_adjdt,5,2)
ls_plant = dw_4.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_4.getitemstring(1, "wip001_wadvsn")
ls_pdcd = trim(dw_4.getitemstring(1,"inv101_pdcd"))

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = " ����, ������ ������ �ֽʽÿ�. "
	return 0
end if

// �ǻ� ����üũ
if Not f_wip_check_applystatus('01',ls_plant,ls_dvsn, ls_year + ls_month) then
	uo_status.st_message.text = "�ǻ����� �ƴϰų� �ǻ簡 Ȯ���Ǿ����ϴ�."
	cb_save.enabled = false
else
	cb_save.enabled = true
end if

if f_spacechk(ls_pdcd) = -1 then
	ls_pdcd = '%'
else
	ls_pdcd = ls_pdcd + '%'
end if

setpointer(hourglass!)

DECLARE up_wip_18 PROCEDURE FOR PBWIP.SP_WIP_18  
         A_CMCD = :g_s_company,   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_YEAR = :ls_year,   
         A_MONTH = :ls_month,
			A_APPLYDATE = :g_s_date
			using sqlca;

Execute up_wip_18;

dw_3.retrieve(ls_pdcd)

ls_mysql = "DROP TABLE QTEMP.WIPTEMP181"
Execute Immediate :ls_mysql using sqlca;

Close up_wip_18;

dw_2.retrieve(ls_year,ls_month,ls_plant,ls_dvsn,ls_pdcd)
uo_status.st_message.text = "��ȸ�Ǿ����ϴ�."
end event

type st_8 from statictext within w_wip053c
integer x = 2190
integer y = 328
integer width = 2345
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "2. �ڷ������������ Ŭ���Ͽ� ǰ���� ����Ѵ�."
boolean focusrectangle = false
end type

type st_9 from statictext within w_wip053c
integer x = 37
integer y = 1076
integer width = 2926
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
long textcolor = 33554432
long backcolor = 12632256
string text = "���� 2�⵿�� ����� ���� �Ǵ� ���� ���� �ִ� ǰ�񸮽�Ʈ ��ȸ(���� ~'10~',~'30~',~'50~')"
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_wip053c
integer x = 32
integer y = 1152
integer width = 4279
integer height = 196
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_wip053c
integer x = 32
integer y = 24
integer width = 4553
integer height = 968
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "[�ǻ���ǰ�� �������ε�]"
end type

type ln_1 from line within w_wip053c
integer linethickness = 10
integer beginx = 23
integer beginy = 1028
integer endx = 4576
integer endy = 1028
end type

