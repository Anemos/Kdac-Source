$PBExportHeader$w_pisq710u_01.srw
$PBExportComments$�����ڷ� ���ε�(��������)
forward
global type w_pisq710u_01 from window
end type
type em_1 from editmask within w_pisq710u_01
end type
type cb_close from commandbutton within w_pisq710u_01
end type
type st_11 from statictext within w_pisq710u_01
end type
type cb_create from commandbutton within w_pisq710u_01
end type
type st_7 from statictext within w_pisq710u_01
end type
type sle_1 from singlelineedit within w_pisq710u_01
end type
type cb_1 from commandbutton within w_pisq710u_01
end type
type dw_1 from datawindow within w_pisq710u_01
end type
type uo_1 from uo_progress_bar within w_pisq710u_01
end type
type st_6 from statictext within w_pisq710u_01
end type
type st_5 from statictext within w_pisq710u_01
end type
type st_4 from statictext within w_pisq710u_01
end type
type st_1 from statictext within w_pisq710u_01
end type
type gb_1 from groupbox within w_pisq710u_01
end type
end forward

global type w_pisq710u_01 from window
integer width = 3648
integer height = 1788
boolean titlebar = true
string title = "�������� ���ε�"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
em_1 em_1
cb_close cb_close
st_11 st_11
cb_create cb_create
st_7 st_7
sle_1 sle_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
st_6 st_6
st_5 st_5
st_4 st_4
st_1 st_1
gb_1 gb_1
end type
global w_pisq710u_01 w_pisq710u_01

type variables
string is_manageno, is_custcode, is_exportgubun
end variables

on w_pisq710u_01.create
this.em_1=create em_1
this.cb_close=create cb_close
this.st_11=create st_11
this.cb_create=create cb_create
this.st_7=create st_7
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.em_1,&
this.cb_close,&
this.st_11,&
this.cb_create,&
this.st_7,&
this.sle_1,&
this.cb_1,&
this.dw_1,&
this.uo_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_1,&
this.gb_1}
end on

on w_pisq710u_01.destroy
destroy(this.em_1)
destroy(this.cb_close)
destroy(this.st_11)
destroy(this.cb_create)
destroy(this.st_7)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;datawindowchild ldwc

is_manageno = Message.StringParm

dw_1.settransobject(sqleis)
em_1.text = is_manageno

dw_1.GetChild('qcanalyzecontent', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS008')
f_pisc_set_dddw_width(dw_1,'qcanalyzecontent',ldwc,'codename',10)
end event

type em_1 from editmask within w_pisq710u_01
integer x = 571
integer y = 1292
integer width = 645
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XX-XXXX-XX-XXX"
end type

type cb_close from commandbutton within w_pisq710u_01
integer x = 2171
integer y = 1540
integer width = 398
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ݱ�"
end type

event clicked;close(w_pisq710u_01)
end event

type st_11 from statictext within w_pisq710u_01
integer x = 59
integer y = 1308
integer width = 466
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "���������ȣ:"
boolean focusrectangle = false
end type

type cb_create from commandbutton within w_pisq710u_01
integer x = 1714
integer y = 1540
integer width = 398
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;string 	ls_areacode, ls_divisioncode, ls_qcanalyzecontent, ls_qcapplyreference
integer 	li_seqno, li_rowcnt, li_currow, li_qcapplyratio
long 		ll_savecnt, ll_complete, ll_rtn
dec{2}   lc_payqty
dec{0}   lc_payamount

if MessageBox("���", "�ش� ����û���� ���� �������������� �����մϴ�. ~r" + &
		"����Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

setpointer(hourglass!)

dw_1.accepttext()

ll_savecnt = 0
li_rowcnt = dw_1.rowcount()

if li_rowcnt < 1 then
	return 0
end if

for li_currow = 1 to li_rowcnt
	dw_1.SelectRow(0, False)
	dw_1.SelectRow(li_currow, True)	
	dw_1.ScrollToRow(li_currow)
	
	//�ش� ����Ÿ üũ	
	if is_manageno <> dw_1.getitemstring(li_currow,'manclaimno') then
		MessageBox("Ȯ��", "����û����ȣ�� ��ġ���� �ʽ��ϴ�.")
		continue
	end if
	//����ǰ�� ��� ���� üũ
	ls_areacode = dw_1.getitemstring(li_currow,'areacode')
	ls_divisioncode = dw_1.getitemstring(li_currow,'divisioncode')
	ls_qcanalyzecontent = mid(right(dw_1.getitemstring(li_currow,'qcanalyzecontent'),2),1,1)
	ls_qcapplyreference = dw_1.getitemstring(li_currow,'qcapplyreference')
	li_seqno = dw_1.getitemnumber(li_currow,'seqno')
	li_qcapplyratio = dw_1.getitemnumber(li_currow,'qcapplyratio')
	
	SELECT isnull(Payqty,0), isnull(Payamount,0) INTO :lc_payqty, :lc_payamount
	FROM TWCLAIMLIST
	WHERE ManClaimNo = :is_manageno AND Seqno = :li_seqno
	using sqleis;
	
	if sqleis.sqlcode = 0 then
		// �������ⵥ��Ÿ ����
		UPDATE TWOBJECTIONLIST  
		SET QcAnalyzeContent = :ls_qcanalyzecontent,   
			 QcApplyReference = :ls_qcapplyreference,   
			 QcApplyRatio = :li_qcapplyratio,
			 ObjectionQty = ( :lc_payqty * :li_qcapplyratio / 100 ),
			 ObjectionAmount = ( :lc_payamount * :li_qcapplyratio / 100 )
		WHERE ManClaimno = :is_manageno AND Seqno = :li_seqno
		using sqleis;
	
		if sqleis.sqlcode <> 0 or sqleis.sqlnrows < 1 then
			Messagebox("����","�������ⵥ��Ÿ ���Žÿ� ������ �߻��Ͽ����ϴ�.")
		else
			ll_savecnt = ll_savecnt + 1
		end if
	else
		MessageBox("����", "�ش纸��û���� ������ �ش��ϴ� ���ڵ尡 �����ϴ�.")
	end if
	
	ll_complete = li_currow * 100 / li_rowcnt
	if mod(li_currow,5) = 0 then
		uo_1.uf_set_position (ll_complete)
	end if
next
	
ll_complete = (li_currow - 1) * 100 / li_rowcnt
uo_1.uf_set_position (ll_complete)
st_7.text = string(ll_savecnt,"###,### ")

Messagebox("�˸�", "���������� ó���Ǿ����ϴ�.")

return 0
end event

type st_7 from statictext within w_pisq710u_01
integer x = 1152
integer y = 1552
integer width = 407
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_pisq710u_01
integer x = 384
integer y = 1408
integer width = 1198
integer height = 92
integer taborder = 30
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

type cb_1 from commandbutton within w_pisq710u_01
integer x = 59
integer y = 1408
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

event clicked;
string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

// UPLOAD�� ���������� �����Ѵ�
//
ll_rtn = GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")
If ll_rtn <> 1 Then
	return -1
end if

setpointer(hourglass!)
dw_1.reset()
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

st_5.text = string(dw_1.rowcount())
sle_1.text = ls_name
end event

type dw_1 from datawindow within w_pisq710u_01
integer x = 37
integer y = 172
integer width = 3543
integer height = 1056
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq710u_01_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type uo_1 from uo_progress_bar within w_pisq710u_01
event destroy ( )
integer x = 1760
integer y = 1352
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_pisq710u_01
integer x = 823
integer y = 1564
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
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

type st_5 from statictext within w_pisq710u_01
integer x = 366
integer y = 1552
integer width = 389
integer height = 84
boolean bringtotop = true
integer textsize = -12
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

type st_4 from statictext within w_pisq710u_01
integer x = 59
integer y = 1560
integer width = 293
integer height = 76
boolean bringtotop = true
integer textsize = -10
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

type st_1 from statictext within w_pisq710u_01
integer x = 169
integer y = 60
integer width = 1746
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean enabled = false
string text = "��  �������� EXCEL �ڷ� LOAD  ��"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisq710u_01
integer x = 1710
integer y = 1264
integer width = 1618
integer height = 256
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "[ó������]"
end type

