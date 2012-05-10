$PBExportHeader$w_mpm120u.srw
$PBExportComments$Order ��Ϲװ���
forward
global type w_mpm120u from w_ipis_sheet01
end type
type dw_mpm120u_01 from u_vi_std_datawindow within w_mpm120u
end type
type dw_mpm120u_02 from datawindow within w_mpm120u
end type
type cb_confirm from commandbutton within w_mpm120u
end type
type uo_1 from u_mpms_select_orderno within w_mpm120u
end type
type cb_addorderno from commandbutton within w_mpm120u
end type
type cb_urgentprint from commandbutton within w_mpm120u
end type
type dw_report from datawindow within w_mpm120u
end type
type gb_1 from groupbox within w_mpm120u
end type
end forward

global type w_mpm120u from w_ipis_sheet01
dw_mpm120u_01 dw_mpm120u_01
dw_mpm120u_02 dw_mpm120u_02
cb_confirm cb_confirm
uo_1 uo_1
cb_addorderno cb_addorderno
cb_urgentprint cb_urgentprint
dw_report dw_report
gb_1 gb_1
end type
global w_mpm120u w_mpm120u

forward prototypes
public function string wf_get_orderno ()
public function integer wf_delete_chk (string ag_orderno)
end prototypes

public function string wf_get_orderno ();String ls_orderno

DECLARE up_get_orderno PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'ORD'  
	 using sqlmpms;

Execute up_get_orderno;

if sqlmpms.sqlcode = 0 then
	fetch up_get_orderno into :ls_orderno;
	close up_get_orderno;
end if

return ls_orderno
end function

public function integer wf_delete_chk (string ag_orderno);//-------------
// ��ǰ���������� �ִ°�� return -1, ������ return 0
//-------------
integer li_count

SELECT COUNT(*) INTO :li_count FROM TPARTLIST
WHERE ORDERNO = :ag_orderno
using sqlmpms;

if sqlmpms.sqlcode <> 0 or li_count > 0 then
	return -1
else
	return 0
end if
end function

on w_mpm120u.create
int iCurrent
call super::create
this.dw_mpm120u_01=create dw_mpm120u_01
this.dw_mpm120u_02=create dw_mpm120u_02
this.cb_confirm=create cb_confirm
this.uo_1=create uo_1
this.cb_addorderno=create cb_addorderno
this.cb_urgentprint=create cb_urgentprint
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm120u_01
this.Control[iCurrent+2]=this.dw_mpm120u_02
this.Control[iCurrent+3]=this.cb_confirm
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.cb_addorderno
this.Control[iCurrent+6]=this.cb_urgentprint
this.Control[iCurrent+7]=this.dw_report
this.Control[iCurrent+8]=this.gb_1
end on

on w_mpm120u.destroy
call super::destroy
destroy(this.dw_mpm120u_01)
destroy(this.dw_mpm120u_02)
destroy(this.cb_confirm)
destroy(this.uo_1)
destroy(this.cb_addorderno)
destroy(this.cb_urgentprint)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_mpm120u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm120u_01.Height= ( newheight * 3 / 5 ) - dw_mpm120u_01.y

dw_mpm120u_02.x = dw_mpm120u_01.x
dw_mpm120u_02.y = dw_mpm120u_01.y + dw_mpm120u_01.Height + ls_split
dw_mpm120u_02.Width = dw_mpm120u_01.Width
dw_mpm120u_02.Height = newheight - ( dw_mpm120u_01.y + dw_mpm120u_01.Height + ls_split + ls_status)


end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_mpm120u_01.SetTransObject(sqlmpms)
dw_mpm120u_02.SetTransObject(sqlmpms)
dw_report.settransobject(sqlmpms)

dw_mpm120u_01.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm120u_01,'ingstatus',ldwc,'codename',5)

dw_mpm120u_02.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm120u_02,'ingstatus',ldwc,'codename',5)

end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_orderno

dw_mpm120u_01.reset()
dw_mpm120u_02.reset()

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if
ll_rowcnt = dw_mpm120u_01.retrieve(ls_orderno)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "�������� �Ƿ������� �����ϴ�."
end if
return 0
end event

event ue_insert;call super::ue_insert;
dw_mpm120u_02.reset()
dw_mpm120u_02.insertrow(0)

dw_mpm120u_02.setitem( 1, 'ingstatus', '1' )
dw_mpm120u_02.setitem( 1, 'outflag', 'N' )
dw_mpm120u_02.setitem( 1, 'startdate', f_mpms_get_nowtime() )
end event

event ue_save;call super::ue_save;String ls_orderno
integer li_findrow

dw_mpm120u_02.accepttext()
if dw_mpm120u_02.modifiedcount() < 1 then
	uo_status.st_message.text = "������ ������ �����ϴ�."
	return -1
end if
if f_mpms_mandantory_chk(dw_mpm120u_02) = -1 then
	uo_status.st_message.text = "�ʼ��Է»����� �Է��Ͻʽÿ�."
	return -1
end if
ls_orderno = dw_mpm120u_02.getitemstring( 1, "orderno")

if f_spacechk(ls_orderno) = -1 then
	// �űԱ����� ���� OrderNo ��������
	ls_orderno = wf_get_orderno()
	dw_mpm120u_02.setitem(1, "orderno", ls_orderno)
end if

sqlmpms.AutoCommit = False

if dw_mpm120u_02.update() = 1 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_mpm120u_01.find("orderno = '" + ls_orderno + "'", 1, dw_mpm120u_01.rowcount())
	if li_findrow > 0 then
		dw_mpm120u_01.Post Event RowFocusChanged(li_findrow)
		dw_mpm120u_01.scrolltorow(li_findrow)
		dw_mpm120u_01.setrow(li_findrow)
	end if

	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	RollBack using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if

return 0
end event

event ue_delete;call super::ue_delete;//-------------------------------------------------------------
// �����Ƿڰ��� ������°� �Ƿ������� ��쿡�� ������ �� �ִ�.
//-------------------------------------------------------------
integer li_selrow, li_rtn
string ls_orderno

li_selrow = dw_mpm120u_01.getselectedrow(0)

if li_selrow < 1 then
	uo_status.st_message.text = '���õ� ����Ÿ�� �����ϴ�.'
	return 0
end if

ls_orderno = dw_mpm120u_01.getitemstring(li_selrow,'orderno')

if wf_delete_chk(ls_orderno) = -1 then
	uo_status.st_message.text = '��ǰ���������� ��ϵǾ� �ֽ��ϴ�.'
	return 0
end if

li_rtn = MessageBox("Ȯ��", ls_orderno + " �����Ƿڰ��� �����Ͻðڽ��ϱ�?" &
				, Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if

sqlmpms.Autocommit = False

DELETE FROM TORDER
WHERE ORDERNO = :ls_orderno
		using sqlmpms;
		
if sqlmpms.sqlcode = 0 then
	Commit using sqlmpms;
	sqlmpms.Autocommit = True
	
	iw_this.Triggerevent('ue_retrieve')
	uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
else
	RollBack using sqlmpms;
	sqlmpms.Autocommit = True
	li_selrow = dw_mpm120u_01.find("orderno = '" + ls_orderno + "'", 1, dw_mpm120u_01.rowcount())
	if li_selrow > 0 then
		dw_mpm120u_01.Post Event RowFocusChanged(li_selrow)
		dw_mpm120u_01.scrolltorow(li_selrow)
		dw_mpm120u_01.setrow(li_selrow)
	end if
	uo_status.st_message.text = '�����ÿ� ������ �߻��Ͽ����ϴ�.'
end if
end event

event open;call super::open;// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm120u
end type

type dw_mpm120u_01 from u_vi_std_datawindow within w_mpm120u
integer x = 18
integer y = 196
integer width = 3515
integer height = 704
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm120u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_orderno = This.getitemstring( currentrow, "orderno")

dw_mpm120u_02.retrieve(ls_orderno)
end event

type dw_mpm120u_02 from datawindow within w_mpm120u
integer x = 18
integer y = 944
integer width = 3525
integer height = 860
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm120u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_gubun, ls_rtnparm
str_mpms_xy str_lxy

choose case dwo.name 
	case 'b_dept'
		ls_gubun = This.getitemstring(1, 'deptgubun')
		
		openwithparm(w_mpms_find_dept,ls_gubun)
		ls_rtnparm = message.stringparm
		
		This.setitem( 1, 'orderdept', ls_rtnparm )
	case 'b_foredate'
		str_lxy.lx = iw_This.PointerX() - 645
		str_lxy.ly = iw_This.PointerY() - 270
		openwithparm(w_mpms_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return 0
		Else
			ls_rtnparm = Message.StringParm   // powerobject
		End If	
		
		This.SetItem(row, 'foredate', date(ls_rtnparm))
	case 'b_duedate'
		str_lxy.lx = iw_This.PointerX() - 645
		str_lxy.ly = iw_This.PointerY() - 270
		openwithparm(w_mpms_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return 0
		Else
			ls_rtnparm = Message.StringParm   // powerobject
		End If	
		
		This.SetItem(row, 'duedate', date(ls_rtnparm))
	case 'b_empno'
		openwithparm(w_mpms_find_empno, ' ')
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return 0
		Else
			ls_rtnparm = Message.StringParm   // powerobject
		End If	
		
		This.SetItem(row, 'designman', mid(ls_rtnparm,1,6))
		This.SetItem(row, 'empname', mid(ls_rtnparm,7))
end choose
end event

event itemchanged;String 	ls_colName, ls_null, ls_deptgubun, ls_chkdata
long ll_chkcnt
this.AcceptText ( )

SetNull(ls_Null)
//ls_colName = This.GetcolumnName()
ls_colName = dwo.name
Choose Case ls_colName
	Case 'deptgubun'
		This.Setitem( row, 'orderdept', ls_null )
	Case 'orderdept'
		ls_deptgubun = This.getitemstring(row, 'deptgubun')
		if ls_deptgubun = '1' then
			ls_chkdata = trim(data)
			
			SELECT DeptName INTO :ls_chkdata
			FROM TMSTDEPT
			WHERE DeptCode = :ls_chkdata  using sqlmpms;
			
			if f_spacechk(ls_chkdata) = -1 then
				Messagebox("Ȯ��","�ش� �系�μ��� �������� �ʽ��ϴ�.")
				This.Setitem( row, 'orderdept', ls_null )
				return 1
			else
				This.Setitem( row, 'deptname', ls_chkdata)
			end if
		elseif ls_deptgubun = '2' then
			SELECT CUSTCODE INTO :ls_chkdata
			FROM TCUSTOMER
			WHERE CUSTCODE = :data using sqlmpms;
			
			if f_spacechk(ls_chkdata) = -1 then
				Messagebox("Ȯ��","�ش� ��ܾ�ü�� �������� �ʽ��ϴ�.")
				This.Setitem( row, 'orderdept', ls_null )
				return 1
			end if
		else
			Messagebox("Ȯ��", "�Ƿ�ó������ ���� �����Ͻñ� �ٶ��ϴ�.")
			This.Setitem( row, 'orderdept', ls_null )
			return 1
		end if
	Case 'designman'
		select aa.empname into :ls_chkdata
		from tmstemp aa
		where aa.retiregubun <> 'Y' and
			aa.empno = :data
		using sqlmpms;

		if f_spacechk(ls_chkdata) = -1 then
			Messagebox("Ȯ��","��ϵ� ����� �ش����� �ʽ��ϴ�.")
			This.Setitem( row, 'designman', ls_null )
			return 1
		else
			this.setitem( row, 'empname', ls_chkdata)
		end if
End Choose

return 0
end event

type cb_confirm from commandbutton within w_mpm120u
integer x = 1321
integer y = 52
integer width = 553
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���鼳���û"
end type

event clicked;integer li_selrow, li_findrow
string ls_orderno, ls_status

li_selrow = dw_mpm120u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "���õ� ����Ÿ�� �����ϴ�."
	return 0
end if

ls_orderno = dw_mpm120u_01.getitemstring(li_selrow,'orderno')

ls_status = f_mpms_get_orderstatus(ls_orderno)
if ls_status = '1' then
	if f_mpms_set_orderstatus(ls_orderno, '2') = 0 then
		iw_this.Triggerevent("ue_retrieve")
		li_findrow = dw_mpm120u_01.find("orderno = '" + ls_orderno + "'", 1, dw_mpm120u_01.rowcount())
		if li_findrow > 0 then
			dw_mpm120u_01.Post Event RowFocusChanged(li_findrow)
			dw_mpm120u_01.scrolltorow(li_findrow)
			dw_mpm120u_01.setrow(li_findrow)
		end if
		uo_status.st_message.text = "���������� ó���Ǿ����ϴ�."
		return 0
	else
		uo_status.st_message.text = "ó���߿� ������ �߻��Ͽ����ϴ�."
	end if
else
	uo_status.st_message.text = "ó���� �� �� ���� �����Դϴ�."
end if

return 0

end event

type uo_1 from u_mpms_select_orderno within w_mpm120u
integer x = 50
integer y = 48
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;iw_this.Triggerevent('ue_retrieve')
end event

event constructor;call super::constructor;is_option = '1'
end event

type cb_addorderno from commandbutton within w_mpm120u
integer x = 1998
integer y = 52
integer width = 549
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Order No ����"
end type

event clicked;long ll_selrow, ll_rtn
integer li_findrow
string ls_orderno, ls_addorderno

ll_selrow = dw_mpm120u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "������ Order No�� �����Ͻʽÿ�"
	return 0
end if

ls_orderno = dw_mpm120u_01.getitemstring(ll_selrow,'orderno')

ll_rtn = MessageBox("Result", "OrderNo :" + ls_orderno + " �� �̿��Ͽ� OrderNo�� �߰��Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2)
if ll_rtn = 2 then
	return 0
end if

ls_addorderno = wf_get_orderno()

sqlmpms.AutoCommit = False
//orderno ����
INSERT INTO TORDER  
( OrderNo, ToolName, ProductNo, ProductName, DrawingNo, DesignMan, MoldGubun,   
  AssetFlag, OrderDept, DeptGubun, OrderMan, OrderTelNo, UrgentFlag, IngStatus,   
  OrderQty, ForeDate, DueDate, AccessCost, LaborCost, Remark, StartDate, EndDate, OutFlag, LastEmp )  
SELECT :ls_addorderno, ToolName, ProductNo, ProductName, DrawingNo, DesignMan, MoldGubun,   
  AssetFlag, OrderDept, DeptGubun, OrderMan, OrderTelNo, UrgentFlag, '1',   
  OrderQty, null, null, AccessCost, LaborCost, Remark, getdate(), null, OutFlag, :g_s_empno   
FROM TORDER  
WHERE TORDER.OrderNo = :ls_orderno   
using sqlmpms;

if sqlmpms.sqlcode = 0 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	
	Parent.Triggerevent("ue_retrieve")
	li_findrow = dw_mpm120u_01.find("orderno = '" + ls_addorderno + "'", 1, dw_mpm120u_01.rowcount())
	if li_findrow > 0 then
		dw_mpm120u_01.Post Event RowFocusChanged(li_findrow)
		dw_mpm120u_01.scrolltorow(li_findrow)
		dw_mpm120u_01.setrow(li_findrow)
	end if

	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	RollBack using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if

return 0

end event

type cb_urgentprint from commandbutton within w_mpm120u
integer x = 2670
integer y = 52
integer width = 603
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����۾����ü�"
end type

event clicked;//************************
//* 1. Order�� ��ϵǾ� �־�� �Ѵ�.
//* 2. ���������� ����( Moldgubun : R )�̾�� �Ѵ�.
//* 3. PartNo = '001000'�� PartList�� 1���� �����ϴ� ���
//* 3.1 ����۾����ü� ������Ѵ�.
//* 4. �������� �ʴ� ��� 
//* 4.1 Exec sp_mpm120u_02

String ls_orderno, ls_moldgubun, mod_string
long ll_selrow, ll_count
integer li_error_code
window 	l_to_open
str_easy l_str_prt

ll_selrow = dw_mpm120u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "���õ� ���� OrderNo�� �����ϴ�."
	return 0
end if

ls_orderno = dw_mpm120u_01.getitemstring(ll_selrow,"orderno")
ls_moldgubun = dw_mpm120u_02.getitemstring(1,"moldgubun")
if ls_moldgubun <> 'R' then
	uo_status.st_message.text = "����۾����ü��� ���������� �������� �մϴ�."
	return 0
end if

SELECT COUNT(*) INTO :ll_count
FROM TPARTLIST
WHERE OrderNo = :ls_orderno
using sqlmpms;

if ll_count = 0 then
	// Exec sp_mpm120u_02
	DECLARE up_mpm120u_02 procedure for sp_mpm120u_02
		@ps_orderno	= :ls_orderno,
		@pi_err_code		= :li_error_code	output
	USING	SQLMPMS ;

	EXECUTE up_mpm120u_02 ;

	FETCH up_mpm120u_02
		INTO :li_error_code ;
	CLOSE	up_mpm120u_02 ;

	if li_error_code <> 0 then
		uo_status.st_message.text = "����۾�ó���ÿ� ������ �߻��Ͽ����ϴ�."
		return 0
	end if
elseif ll_count = 1 then
	SELECT COUNT(*) INTO :ll_count
	FROM TPARTLIST
	WHERE OrderNo = :ls_orderno AND PartNo = '001000'
	using sqlmpms;
	
	if ll_count = 0 then
		uo_status.st_message.text = "���õ� OrderNo�� ����۾����ü��� �ش����� �ʽ��ϴ�."
		return 0
	end if
else
	uo_status.st_message.text = "���õ� OrderNo�� ����۾����ü��� �ش����� �ʽ��ϴ�."
	return 0
end if

//��� �����쿡 Data ����, ��� ������ Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "��� �غ��� �Դϴ�..."

dw_report.reset()
dw_report.retrieve(ls_orderno, '001000')

//�μ� DataWindow ����
//w_easy_prt�� dwsyntax�� ���� modify()���� �߰���
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open�� ���Window �ݱ�
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""
return 0

end event

type dw_report from datawindow within w_mpm120u
boolean visible = false
integer x = 2793
integer y = 156
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_mpm120u_03p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm120u
integer x = 18
integer width = 3406
integer height = 180
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

