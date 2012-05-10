$PBExportHeader$w_mpm240i_01.srw
$PBExportComments$����ǰ������(POPUP)
forward
global type w_mpm240i_01 from window
end type
type cb_close from commandbutton within w_mpm240i_01
end type
type cb_save from commandbutton within w_mpm240i_01
end type
type pb_find from picturebutton within w_mpm240i_01
end type
type dw_mpm240i_01_right from datawindow within w_mpm240i_01
end type
type dw_mpm240i_01_left from datawindow within w_mpm240i_01
end type
type sle_input from singlelineedit within w_mpm240i_01
end type
type st_1 from statictext within w_mpm240i_01
end type
type rb_itnm from radiobutton within w_mpm240i_01
end type
type rb_itno from radiobutton within w_mpm240i_01
end type
type gb_1 from groupbox within w_mpm240i_01
end type
type gb_2 from groupbox within w_mpm240i_01
end type
type gb_3 from groupbox within w_mpm240i_01
end type
end forward

global type w_mpm240i_01 from window
integer width = 3456
integer height = 1656
boolean titlebar = true
string title = "����ǰ������ ������"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
pb_find pb_find
dw_mpm240i_01_right dw_mpm240i_01_right
dw_mpm240i_01_left dw_mpm240i_01_left
sle_input sle_input
st_1 st_1
rb_itnm rb_itnm
rb_itno rb_itno
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_mpm240i_01 w_mpm240i_01

forward prototypes
public function string wf_get_serialno ()
end prototypes

public function string wf_get_serialno ();string ls_serialno

DECLARE up_get_serialno PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'PUR'  
	 using sqlmpms;

Execute up_get_serialno;

if sqlmpms.sqlcode = 0 then
	fetch up_get_serialno into :ls_serialno;
	close up_get_serialno;
end if

return ls_serialno
end function

on w_mpm240i_01.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.pb_find=create pb_find
this.dw_mpm240i_01_right=create dw_mpm240i_01_right
this.dw_mpm240i_01_left=create dw_mpm240i_01_left
this.sle_input=create sle_input
this.st_1=create st_1
this.rb_itnm=create rb_itnm
this.rb_itno=create rb_itno
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_close,&
this.cb_save,&
this.pb_find,&
this.dw_mpm240i_01_right,&
this.dw_mpm240i_01_left,&
this.sle_input,&
this.st_1,&
this.rb_itnm,&
this.rb_itno,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_mpm240i_01.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.pb_find)
destroy(this.dw_mpm240i_01_right)
destroy(this.dw_mpm240i_01_left)
destroy(this.sle_input)
destroy(this.st_1)
destroy(this.rb_itnm)
destroy(this.rb_itno)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;string ls_orderno, ls_partno, ls_outserial
datawindow ldw_01
integer li_cnt, li_rowcnt, li_currow
dec{0} lc_stdunitcost, lc_outcost

dw_mpm240i_01_left.settransobject(sqlmpms)
dw_mpm240i_01_right.settransobject(sqlca)
ldw_01 = message.PowerObjectParm

dw_mpm240i_01_left.reset()
li_rowcnt = ldw_01.rowcount()
for li_cnt = 1 to li_rowcnt
	if ldw_01.getitemstring(li_cnt,"outcheck") = 'Y' then
		li_currow = dw_mpm240i_01_left.insertrow(0)
		dw_mpm240i_01_left.setitem(li_currow,"orderno",ldw_01.getitemstring(li_cnt,"orderno"))
		dw_mpm240i_01_left.setitem(li_currow,"partno",ldw_01.getitemstring(li_cnt,"partno"))
		dw_mpm240i_01_left.setitem(li_currow,"outserial",ldw_01.getitemstring(li_cnt,"outserial"))
		dw_mpm240i_01_left.setitem(li_currow,"stdunitcost",ldw_01.getitemdecimal(li_cnt,"stdunitcost"))
		dw_mpm240i_01_left.setitem(li_currow,"outcost",ldw_01.getitemdecimal(li_cnt,"outcost"))
	end if
next

return 0
end event

type cb_close from commandbutton within w_mpm240i_01
integer x = 2697
integer y = 1392
integer width = 457
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ݱ�"
end type

event clicked;CloseWithReturn(Parent,"CLOSE")
end event

type cb_save from commandbutton within w_mpm240i_01
integer x = 1966
integer y = 1392
integer width = 457
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;//*******************************
// ���ְ��� ����Ÿ������ ���̴� �ڷḦ ���ֳ��� ���̺�� �̵��Ѵ�.
// �̵��� �Ϸ�Ǹ� �ش� ���ְ�������Ÿ ���¸� ���ֻ��·� �ٲ۴�.
//*******************************
string ls_puritno, ls_serialno, ls_orderno, ls_message, ls_xunit
string ls_partno, ls_outserial
integer li_curcnt, li_rowcnt, li_selrow
dec{0} lc_outcost, lc_sum_outcost

li_selrow = dw_mpm240i_01_right.getselectedrow(0)

if li_selrow < 1 then
	Messagebox("�˸�","���õ� ����ǰ���� �����ϴ�.")
	return 0
else
	ls_orderno = dw_mpm240i_01_left.getitemstring(1,"orderno")
	SELECT COUNT(*) INTO :li_rowcnt
	FROM TOUTORDER
	WHERE OrderNo = :ls_orderno AND PurItno = :ls_puritno 
	using sqlmpms;
	
	if li_rowcnt > 0 then
		Messagebox("�˸�","�̹� ���ְ��������� ����� ����ǰ���Դϴ�.")
		return 0
	end if
	ls_puritno = dw_mpm240i_01_right.getitemstring(li_selrow,"itno")
	ls_xunit	= dw_mpm240i_01_right.getitemstring(li_selrow,"xunit")
end if

li_rowcnt = dw_mpm240i_01_left.rowcount()
if li_rowcnt > 1 and ls_xunit <> 'ST' then
	Messagebox("�˸�","������ ǰ���� ��Ʈǰ�� �ƴմϴ�.")
	return 0
elseif li_rowcnt = 1 and ls_xunit <> 'EA' then
	Messagebox("�˸�","������ ǰ���� ��ǰ�� �ƴմϴ�.")
	return 0
end if
ls_serialno = wf_get_serialno()
lc_sum_outcost = 0
sqlmpms.Autocommit = False

// ���� ���ε���Ÿ ����
for li_curcnt = 1 to li_rowcnt
	ls_orderno = dw_mpm240i_01_left.getitemstring(li_curcnt,"orderno")
	ls_partno = dw_mpm240i_01_left.getitemstring(li_curcnt,"partno")
	ls_outserial = dw_mpm240i_01_left.getitemstring(li_curcnt,"outserial")
	if li_rowcnt = 1 then
		// ��ǰ�� ��쿡 ���ְ����ܰ��� �����Ѵ�.
		lc_outcost = dw_mpm240i_01_left.getitemnumber(li_curcnt,"stdunitcost")
	else
		// ��Ʈǰ�� ��쿡�� ���ְ����ݾ��� �����Ѵ�.
		lc_outcost = dw_mpm240i_01_left.getitemnumber(li_curcnt,"outcost")
	end if
	lc_sum_outcost = lc_sum_outcost + lc_outcost
	
	INSERT INTO TOUTORDERDETAIL(SerialNo, OrderNo, PartNo, OutSerial, OutCost, LastEmp)
	VALUES(:ls_serialno, :ls_orderno, :ls_partno, :ls_outserial, :lc_outcost, :g_s_empno)
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "���� �������� ����� ����"
		goto RollBack_
	end if
	
	UPDATE TOUTPROCESS
	SET OutStatus = 'B', ConfirmEmp = :g_s_empno, ConfirmDate = :g_s_date
	WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
		OutSerial = :ls_outserial
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
		ls_message = "���ְ��� ���� ������Ʈ ����"
		goto RollBack_
	end if
	
	UPDATE TROUTING
		SET WorkStatus = 'C'
	FROM TROUTING aa INNER JOIN TOUTPROCESSDETAIL bb
		ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo AND
			aa.OperNo = bb.OperNo
		INNER JOIN TOUTPROCESS cc
		ON bb.OrderNo = cc.OrderNo AND bb.PartNo = cc.PartNo AND
			bb.OutSerial = cc.OutSerial
	WHERE cc.OrderNo = :ls_orderno AND cc.PartNo = :ls_partno AND
		cc.OutSerial = :ls_outserial
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
		ls_message = "�������� ���� ������Ʈ ����"
		goto RollBack_
	end if
next

// ���� ����Ÿ ����Ÿ ����
INSERT INTO TOUTORDER(SerialNo, OrderNo, PurItno, Xunit, OutStatus, OutCost, LastEmp)
VALUES(:ls_serialno, :ls_orderno, :ls_puritno, :ls_xunit, 'B', :lc_sum_outcost, :g_s_empno)
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "���� ����Ÿ ����� ����"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

MessageBox("�˸�","����Ǿ����ϴ�.")
CloseWithReturn(w_mpm240i_01,"SAVE")
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

MessageBox(ls_message,"����ÿ� ������ �߻��Ͽ����ϴ�.")

return 0
end event

type pb_find from picturebutton within w_mpm240i_01
integer x = 3099
integer y = 172
integer width = 238
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_itnoquery, ls_itnmquery

if f_spacechk(trim(sle_input.text)) = -1 then
	return 0
end if

if rb_itno.checked then
	ls_itnoquery = sle_input.text + '%'
	ls_itnmquery = '%'
else
	ls_itnmquery = sle_input.text + '%'
	ls_itnoquery = '%'
end if

dw_mpm240i_01_right.retrieve(ls_itnoquery, ls_itnmquery)
end event

type dw_mpm240i_01_right from datawindow within w_mpm240i_01
integer x = 1746
integer y = 320
integer width = 1655
integer height = 996
integer taborder = 40
string title = "none"
string dataobject = "d_mpm240i_01_right"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow > 0 then
	This.SelectRow(0, FALSE)
	This.SelectRow(currentrow, TRUE)
end if
end event

type dw_mpm240i_01_left from datawindow within w_mpm240i_01
integer x = 50
integer y = 108
integer width = 1627
integer height = 1380
integer taborder = 30
string title = "none"
string dataobject = "d_mpm240i_01_left"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_input from singlelineedit within w_mpm240i_01
integer x = 2103
integer y = 180
integer width = 955
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_mpm240i_01
integer x = 1787
integer y = 196
integer width = 320
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "�˻��ܾ�:"
boolean focusrectangle = false
end type

type rb_itnm from radiobutton within w_mpm240i_01
integer x = 2057
integer y = 108
integer width = 256
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "ǰ��"
end type

type rb_itno from radiobutton within w_mpm240i_01
integer x = 1769
integer y = 108
integer width = 256
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "ǰ��"
boolean checked = true
end type

type gb_1 from groupbox within w_mpm240i_01
integer x = 23
integer y = 24
integer width = 1682
integer height = 1496
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���ְ�������Ÿ����"
end type

type gb_2 from groupbox within w_mpm240i_01
integer x = 1719
integer y = 24
integer width = 1705
integer height = 1316
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "����ǰ��"
end type

type gb_3 from groupbox within w_mpm240i_01
integer x = 1719
integer y = 1348
integer width = 1705
integer height = 172
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

