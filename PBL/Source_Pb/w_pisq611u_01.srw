$PBExportHeader$w_pisq611u_01.srw
$PBExportComments$�����ڷ� ���ε�(�⺻����)
forward
global type w_pisq611u_01 from window
end type
type cb_close from commandbutton within w_pisq611u_01
end type
type cb_create from commandbutton within w_pisq611u_01
end type
type st_7 from statictext within w_pisq611u_01
end type
type sle_1 from singlelineedit within w_pisq611u_01
end type
type cb_1 from commandbutton within w_pisq611u_01
end type
type dw_1 from datawindow within w_pisq611u_01
end type
type uo_1 from uo_progress_bar within w_pisq611u_01
end type
type st_6 from statictext within w_pisq611u_01
end type
type st_5 from statictext within w_pisq611u_01
end type
type st_4 from statictext within w_pisq611u_01
end type
type st_1 from statictext within w_pisq611u_01
end type
type gb_1 from groupbox within w_pisq611u_01
end type
end forward

global type w_pisq611u_01 from window
integer width = 3648
integer height = 1788
boolean titlebar = true
string title = "�⺻���� ���ε�"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
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
global w_pisq611u_01 w_pisq611u_01

type variables
string is_cocode
end variables

on w_pisq611u_01.create
this.cb_close=create cb_close
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
this.Control[]={this.cb_close,&
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

on w_pisq611u_01.destroy
destroy(this.cb_close)
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

event open;str_pisqwc_parm lstr
datawindow ldw

lstr = Message.PowerObjectParm
is_cocode = lstr.s_parm[1]
ldw = lstr.dw_parm[2]
dw_1.dataobject = ldw.dataobject
dw_1.settransobject(sqleis)
//THIS.PostEvent('ue_postopen')
end event

type cb_close from commandbutton within w_pisq611u_01
integer x = 2185
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

event clicked;close(w_pisq611u_01)
end event

type cb_create from commandbutton within w_pisq611u_01
integer x = 1719
integer y = 1544
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

event clicked;string ls_itno, ls_itnm, ls_pdid, ls_area, ls_division, ls_gubun, ls_table
integer li_seqno, li_rowcnt, li_currow
dec{0}  lc_qty1, lc_qty2
dec{1}  lc_weight
dec{2}  lc_partcost
long ll_savecnt, ll_complete

if MessageBox("���", "�ش� �⺻������ ��λ����մϴ�. ~r" + &
		"���� ���ε��մϴ�. ����Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

setpointer(hourglass!)

dw_1.accepttext()

ll_savecnt = 0
li_rowcnt = dw_1.rowcount()

if li_rowcnt < 1 then
	return 0
end if

choose case is_cocode
	case 'A'	//����ǰ������
		ls_table = 'twaccountitem'
	case 'B'	//��ǰ������
		ls_table = 'twproductgroup'
	case 'C'	//���������
		ls_table = 'twcustomer'
	case 'D'	//�����ڵ����
		ls_table = 'twnation'
	case 'E'	//�����������
		ls_table = 'twdealer'
	case 'F'	//��������
		ls_table = 'twcarclass'
	case 'G'	//�����������
		ls_table = 'twcarstatus'
	case 'H' //��ǰ���Կ���
		ls_table = 'twcarreason'
	case 'I'	//����д���
		ls_table = 'twapplyallot'
	case 'J'	//�����Ⱓ Master
		ls_table = 'twassureterm'
	case 'K' //�����Ⱓ Code
		ls_table = 'twassurecode'
	case 'L'	//����д��� Code
		ls_table = 'twallotcode'
	case 'M'	//������ Mapping
		ls_table = 'twcustomermap'
	case 'N'
		ls_table = 'twwcgubun'
	case 'O'
		ls_table = 'twemail'
	case else
		messagebox("�˸�","�ý��۰��� ����ڿ��� �����ٶ��ϴ�.")
		return 0
end choose

sqleis.Autocommit = False

DECLARE up_eis_truncate_table PROCEDURE FOR sp_pisi_truncate_table  
	@ps_table = :ls_table  using sqleis;
EXECUTE up_eis_truncate_table;

if dw_1.update() = 1 then
	Commit using sqleis;
	sqleis.Autocommit = True

	ll_complete = (li_currow - 1) * 100 / li_rowcnt
	uo_1.uf_set_position (ll_complete)
	st_7.text = string(ll_savecnt,"###,### ")

	Messagebox("�˸�", "���������� ó���Ǿ����ϴ�.")
else
	Messagebox("chk2",string(sqleis.sqlcode) + sqleis.sqlerrtext)
	RollBack using sqleis;
	sqleis.Autocommit = True
	
	Messagebox("�˸�", "ó���߿� ������ �߻��Ͽ����ϴ�.")
end if
return 0
end event

type st_7 from statictext within w_pisq611u_01
integer x = 1152
integer y = 1476
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

type sle_1 from singlelineedit within w_pisq611u_01
integer x = 384
integer y = 1332
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

type cb_1 from commandbutton within w_pisq611u_01
integer x = 59
integer y = 1332
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

// ������ �������ϸ��� ������ �ؽ�Ʈ ���ϸ��� ���翩�θ� üũ�Ѵ�
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

type dw_1 from datawindow within w_pisq611u_01
integer x = 37
integer y = 172
integer width = 3543
integer height = 1056
integer taborder = 10
boolean bringtotop = true
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

type uo_1 from uo_progress_bar within w_pisq611u_01
event destroy ( )
integer x = 1760
integer y = 1352
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_pisq611u_01
integer x = 823
integer y = 1488
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

type st_5 from statictext within w_pisq611u_01
integer x = 366
integer y = 1476
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

type st_4 from statictext within w_pisq611u_01
integer x = 59
integer y = 1484
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

type st_1 from statictext within w_pisq611u_01
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
string text = "��  �⺻���� EXCEL �ڷ� LOAD  ��"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisq611u_01
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
