$PBExportHeader$w_tmm110u.srw
$PBExportComments$��ܾ�ü����
forward
global type w_tmm110u from w_ipis_sheet01
end type
type dw_tmm110u_01 from u_vi_std_datawindow within w_tmm110u
end type
type dw_tmm110u_02 from datawindow within w_tmm110u
end type
end forward

global type w_tmm110u from w_ipis_sheet01
dw_tmm110u_01 dw_tmm110u_01
dw_tmm110u_02 dw_tmm110u_02
end type
global w_tmm110u w_tmm110u

on w_tmm110u.create
int iCurrent
call super::create
this.dw_tmm110u_01=create dw_tmm110u_01
this.dw_tmm110u_02=create dw_tmm110u_02
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tmm110u_01
this.Control[iCurrent+2]=this.dw_tmm110u_02
end on

on w_tmm110u.destroy
call super::destroy
destroy(this.dw_tmm110u_01)
destroy(this.dw_tmm110u_02)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_tmm110u_01.Width = newwidth 	- ( ls_gap * 2 )
dw_tmm110u_01.Height= ( newheight * 2 / 3 ) - dw_tmm110u_01.y

dw_tmm110u_02.x = dw_tmm110u_01.x
dw_tmm110u_02.y = dw_tmm110u_01.Height + dw_tmm110u_01.y + ls_gap
dw_tmm110u_02.Width = newwidth - ( ls_gap * 2 )
dw_tmm110u_02.Height = newheight - ( dw_tmm110u_02.y + ls_status )

end event

event ue_postopen;call super::ue_postopen;
dw_tmm110u_01.SetTransObject(sqlca)
dw_tmm110u_02.SetTransObject(sqlca)

This.Triggerevent('ue_retrieve')
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_custcd

dw_tmm110u_01.reset()
dw_tmm110u_02.reset()

ll_rowcnt = dw_tmm110u_01.retrieve()
if ll_rowcnt < 1 then
	dw_tmm110u_02.insertrow(0)
end if
end event

event ue_insert;call super::ue_insert;
dw_tmm110u_02.reset()
dw_tmm110u_02.insertrow(0)

dw_tmm110u_02.setitem(1,"lastemp",g_s_empno)
dw_tmm110u_02.setitem(1,"lastdate",g_s_datetime)
end event

event ue_save;call super::ue_save;int    li_findrow
string ls_custcode, ls_error

ls_custcode = dw_tmm110u_02.getitemstring( 1, "suppliercode")

if dw_tmm110u_02.modifiedcount() <= 0 then
	uo_status.st_message.text = "������ ����Ÿ�� �����ϴ�."
	return -1
end if

if f_spacechk(ls_custcode) = -1 then
	ls_custcode = f_tmm_get_serialno('CID',ls_error)
	if f_spacechk(ls_custcode) = -1 or ls_custcode = 'X' then
		Messagebox("�˸�", "��ü�ڵ带 �������µ� �����߽��ϴ�.")
		return -1
	end if
	dw_tmm110u_02.setitem( 1, "suppliercode", ls_custcode )
end if

sqlca.AutoCommit = False

if dw_tmm110u_02.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_tmm110u_01.find("suppliercode = '" + ls_custcode + "'", 1, dw_tmm110u_01.rowcount())
	if li_findrow > 0 then
		dw_tmm110u_01.Post Event RowFocusChanged(li_findrow)
		dw_tmm110u_01.scrolltorow(li_findrow)
		dw_tmm110u_01.setrow(li_findrow)
	end if
	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	Rollback using sqlca;
	sqlca.AutoCommit = False
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if


end event

event ue_delete;call super::ue_delete;int    li_rtn, li_totcnt
string ls_custcode

ls_custcode = dw_tmm110u_02.getitemstring( 1, "suppliercode")

if f_spacechk(ls_custcode) = -1 then
	Messagebox("�˸�", "������ ��ü�ڵ带 ���ùٶ��ϴ�.")
	return -1
end if

li_rtn = MessageBox("Ȯ��", ls_custcode + " ��ü�� �����Ͻðڽ��ϱ�?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return -1
end if
// �ش��ü���� �Ƿڰ��� ������ ���� �ִ��� ����
SELECT COUNT(*) INTO :li_totcnt FROM PBGMS.TMM002
WHERE Orderdept = :ls_custcode using sqlca;

if li_totcnt > 0 then
	uo_status.st_message.text = "�ش��ü�� �����Ƿڰ� ������ ������ �ֽ��ϴ�."
	return -1
end if

sqlca.AutoCommit = False

DELETE FROM PBGMS.TMM001
WHERE SupplierCode = :ls_custcode using sqlca;

if sqlca.sqlcode = 0 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	This.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "�����Ǿ����ϴ�."
else
	Rollback using sqlca;
	sqlca.AutoCommit = False
	uo_status.st_message.text = "�����ÿ� ������ �߻��Ͽ����ϴ�."
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

type uo_status from w_ipis_sheet01`uo_status within w_tmm110u
end type

type dw_tmm110u_01 from u_vi_std_datawindow within w_tmm110u
integer x = 9
integer y = 12
integer width = 2958
integer height = 708
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_tmm110u_01"
end type

event rowfocuschanged;call super::rowfocuschanged;integer li_rowcnt
String ls_custcode

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_custcode = This.getitemstring(currentrow,'suppliercode')

dw_tmm110u_02.retrieve(ls_custcode)
end event

type dw_tmm110u_02 from datawindow within w_tmm110u
integer x = 14
integer y = 744
integer width = 2953
integer height = 776
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_tmm110u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;This.setitem(row,"lastemp",g_s_empno)
This.setitem(row,"lastdate",g_s_datetime)
end event

