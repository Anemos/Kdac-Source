$PBExportHeader$w_mpm210u_01.srw
$PBExportComments$�����ڷ� ���ε�
forward
global type w_mpm210u_01 from window
end type
type em_1 from editmask within w_mpm210u_01
end type
type cb_close from commandbutton within w_mpm210u_01
end type
type st_11 from statictext within w_mpm210u_01
end type
type cb_create from commandbutton within w_mpm210u_01
end type
type st_7 from statictext within w_mpm210u_01
end type
type sle_1 from singlelineedit within w_mpm210u_01
end type
type cb_1 from commandbutton within w_mpm210u_01
end type
type dw_1 from datawindow within w_mpm210u_01
end type
type uo_1 from uo_progress_bar within w_mpm210u_01
end type
type st_6 from statictext within w_mpm210u_01
end type
type st_5 from statictext within w_mpm210u_01
end type
type st_4 from statictext within w_mpm210u_01
end type
type st_1 from statictext within w_mpm210u_01
end type
type gb_1 from groupbox within w_mpm210u_01
end type
end forward

global type w_mpm210u_01 from window
integer width = 3648
integer height = 1788
boolean titlebar = true
string title = "�����ڷ���ε�"
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
global w_mpm210u_01 w_mpm210u_01

on w_mpm210u_01.create
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

on w_mpm210u_01.destroy
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

event open;string ls_orderno

ls_orderno = message.Stringparm

em_1.text = ls_orderno
end event

type em_1 from editmask within w_mpm210u_01
integer x = 571
integer y = 1292
integer width = 434
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####-####"
end type

type cb_close from commandbutton within w_mpm210u_01
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

event clicked;close(w_mpm210u_01)
end event

type st_11 from statictext within w_mpm210u_01
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
string text = "�����Ƿڹ�ȣ:"
boolean focusrectangle = false
end type

type cb_create from commandbutton within w_mpm210u_01
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

event clicked;string ls_partno, ls_orderno, ls_revno, ls_partname, ls_spec, ls_material, ls_remark
string ls_spec2, ls_spec4, ls_message, ls_outflag, ls_sizeflag
integer li_detailno, li_sheetno, li_rowcnt, li_currow, li_cnt
dec{0}  lc_qty1, lc_qty2
dec{3}  lc_weight, lc_weight2, lc_spec1, lc_spec3, lc_spec5
dec{2}  lc_partcost, lc_gravity, lc_unitprice
long ll_savecnt, ll_complete

if MessageBox("���", "�ش� Order�� ���� ǰ�񸮽�Ʈ �� ���泻���� �߰��մϴ�. ~r" + &
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

em_1.getdata(ls_orderno)

SELECT OutFlag INTO :ls_outflag
FROM TORDER
WHERE OrderNo = :ls_orderno
using sqlmpms;

sqlmpms.Autocommit = False

for li_currow = 1 to li_rowcnt
	dw_1.SelectRow(0, False)
	dw_1.SelectRow(li_currow, True)	
	dw_1.ScrollToRow(li_currow)
	
	//�ش� ����Ÿ üũ
	li_detailno 	= dw_1.getitemnumber(li_currow,'detailno')
	li_sheetno  	= dw_1.getitemnumber(li_currow,'sheetno')
	if li_detailno = 0 and li_sheetno = 0 then
		continue
	end if
	ls_partno      = f_mpms_create_partno(li_detailno,li_sheetno)
	
	SELECT COUNT(*) INTO :li_cnt FROM TPARTLIST
	WHERE ORDERNO = :ls_orderno AND DETAILNO = :li_detailno
	using sqlmpms;
	if li_cnt > 0 then
		continue
	end if
	
	ls_revno       = '00'
	ls_partname    = trim(dw_1.getitemstring(li_currow,'partname'))
	lc_spec1			= dw_1.getitemnumber(li_currow,'spec1')
	ls_spec2       = trim(dw_1.getitemstring(li_currow,'spec2'))
	lc_spec3			= dw_1.getitemnumber(li_currow,'spec3')
	ls_spec4       = trim(dw_1.getitemstring(li_currow,'spec4'))
	lc_spec5			= dw_1.getitemnumber(li_currow,'spec5')
	ls_material    = trim(dw_1.getitemstring(li_currow,'material'))
	ls_remark      = dw_1.getitemstring(li_currow,'remark')
	lc_qty1        = dw_1.getitemnumber(li_currow,'qty1')
	lc_qty2        = dw_1.getitemnumber(li_currow,'qty2')
	
	// ���翡 ���� ���߰� ��������
	SELECT Gravity, UnitPrice, SizeFlag INTO :lc_gravity, :lc_unitprice, :ls_sizeflag
	FROM TMATERIALPRICE
	WHERE Material = :ls_material
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		lc_weight = 0
		lc_weight = 0
		lc_partcost = 0
		if MessageBox("Ȯ��", "���簡��ǥ�� �������� �ʽ��ϴ�. �����Ͻðڽ��ϱ�?", &
				Exclamation!, OKCancel!, 1) = 2 then
			ls_message = "����� ��� �Ǿ����ϴ�."
			goto Rollback_
		end if
	else
		// �԰� �� ������ ���, Weight(��ó��), Weight2(����)
		if ls_spec4 <> 'X' or f_spacechk(ls_spec4) = -1 then
			// ������ ���
			ls_spec = String(lc_spec1,"#,##0.000") + ls_spec2 + String(lc_spec3,"#,##0.000")
			lc_weight = Round((Pi((lc_spec1^2) / 4) * lc_spec3 * lc_gravity) / (10^6),3)
			if ls_sizeflag = 'Y' then
				lc_weight2 = lc_weight
			else
				lc_weight2 = Round((Pi(((lc_spec1 + 5)^2) / 4) * (lc_spec3 + 5) * lc_gravity) / (10^6),3)
			end if
		else
			// ������ ���
			ls_spec = String(lc_spec1,"#,##0.000") + ls_spec2 + String(lc_spec3,"#,##0.000") & 
								+ ls_spec4 + String(lc_spec5,"#,##0.000")
			lc_weight = Round((lc_spec1 * lc_spec3 * lc_spec5 * lc_gravity) / (10^6),3)
			if ls_sizeflag = 'Y' then
				lc_weight2 = lc_weight
			else
				lc_weight2 = Round(((lc_spec1 + 5) * (lc_spec3 + 5) * (lc_spec5 + 5) * lc_gravity) / (10^6),3)
			end if
		end if
		// ����ܰ� ��� 
		lc_partcost		= lc_weight2 * lc_unitprice
	end if
	
	INSERT INTO TPARTLIST  
    ( DetailNo, OrderNo, RevNo, PartName, PartNo, SheetNo, Spec, Material,   
      Qty1, Qty2, Weight, Weight2, PartCost, Remark, SerialNo, OutFlag, 
		OutMaterialFlag, LastEmp, LastDate )  
  	VALUES ( :li_detailno, :ls_orderno, :ls_revno, :ls_partname, :ls_partno,   
           :li_sheetno, :ls_spec, :ls_material, :lc_qty1, :lc_qty2, :lc_weight, :lc_weight2,
			  :lc_partcost, :ls_remark, :li_currow, :ls_outflag, 'Y', :g_s_empno, getdate() )
  	using sqlmpms;
	  
	If sqlmpms.sqlcode <> 0 then
		ls_message = "����ÿ� ������ �߻��Ͽ����ϴ�."
		goto Rollback_
	End if 
	
	INSERT INTO TPARTLISTHIST  
    ( DetailNo, OrderNo, RevNo, RevEmp, RevDate, PartName, PartNo, SheetNo,   
     	Spec, Material, Qty1, Qty2, Weight, Weight2, PartCost, Remark, SerialNo, 
		OutFlag, OutMaterialFlag, LastEmp, LastDate )  
   VALUES ( :li_detailno, :ls_orderno, :ls_revno, :g_s_empno, :g_s_date,   
           :ls_partname, :ls_partno, :li_sheetno, :ls_spec, :ls_material,   
           :lc_qty1, :lc_qty2, :lc_weight, :lc_weight2, :lc_partcost, :ls_remark, :li_currow,  
           :ls_outflag, 'Y', :g_s_empno, getdate() )  
	using sqlmpms;

	If sqlmpms.sqlcode <> 0 then
		ls_message = "�̷�����ÿ� ������ �߻��Ͽ����ϴ�."
		goto Rollback_
	End if

	ll_complete = li_currow * 100 / li_rowcnt
	if mod(li_currow,5) = 0 then
		uo_1.uf_set_position (ll_complete)
		st_7.text = string(ll_savecnt,"###,### ")
	end if
next

Commit using sqlmpms;
sqlmpms.Autocommit = True

ll_complete = (li_currow - 1) * 100 / li_rowcnt
uo_1.uf_set_position (ll_complete)
st_7.text = string(ll_savecnt,"###,### ")

Messagebox("�˸�", "���������� ó���Ǿ����ϴ�.")
return 0

Rollback_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
Messagebox("Ȯ��", ls_message)
return 0
end event

type st_7 from statictext within w_mpm210u_01
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

type sle_1 from singlelineedit within w_mpm210u_01
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

type cb_1 from commandbutton within w_mpm210u_01
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

type dw_1 from datawindow within w_mpm210u_01
integer x = 37
integer y = 172
integer width = 3543
integer height = 1056
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_upload_partlist"
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

type uo_1 from uo_progress_bar within w_mpm210u_01
event destroy ( )
integer x = 1760
integer y = 1352
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_mpm210u_01
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

type st_5 from statictext within w_mpm210u_01
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

type st_4 from statictext within w_mpm210u_01
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

type st_1 from statictext within w_mpm210u_01
integer x = 169
integer y = 60
integer width = 1550
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

type gb_1 from groupbox within w_mpm210u_01
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

