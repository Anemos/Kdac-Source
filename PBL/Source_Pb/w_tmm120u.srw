$PBExportHeader$w_tmm120u.srw
$PBExportComments$�����ǰ����
forward
global type w_tmm120u from w_ipis_sheet01
end type
type dw_tmm120u_01 from u_vi_std_datawindow within w_tmm120u
end type
end forward

global type w_tmm120u from w_ipis_sheet01
dw_tmm120u_01 dw_tmm120u_01
end type
global w_tmm120u w_tmm120u

on w_tmm120u.create
int iCurrent
call super::create
this.dw_tmm120u_01=create dw_tmm120u_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tmm120u_01
end on

on w_tmm120u.destroy
call super::destroy
destroy(this.dw_tmm120u_01)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_tmm120u_01.Width = newwidth	- (ls_gap * 4)
dw_tmm120u_01.Height= newheight - (dw_tmm120u_01.y + ls_status)
end event

event ue_postopen;call super::ue_postopen;
dw_tmm120u_01.settransobject(sqlca)
dw_tmm120u_01.retrieve()
end event

event ue_retrieve;call super::ue_retrieve;
dw_tmm120u_01.reset()
dw_tmm120u_01.retrieve()
end event

event ue_insert;call super::ue_insert;long ll_currow
ll_currow = dw_tmm120u_01.insertrow(0)
dw_tmm120u_01.setitem(ll_currow,"divcode",'N')
dw_tmm120u_01.setitem(ll_currow,"lastemp",g_s_empno)
dw_tmm120u_01.setitem(ll_currow,"lastdate",g_s_datetime)
end event

event ue_save;call super::ue_save;
dw_tmm120u_01.accepttext()

if dw_tmm120u_01.modifiedcount() < 1 and dw_tmm120u_01.deletedcount() < 1 then
	uo_status.st_message.text = "����� ����Ÿ�� �����ϴ�."
	return 0
end if

sqlca.AutoCommit = False

if dw_tmm120u_01.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "������ �����߽��ϴ�."
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

event ue_delete;call super::ue_delete;long ll_selrow

ll_selrow = dw_tmm120u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "������ ���� ������ �ֽʽÿ�"
	return 0
end if

if dw_tmm120u_01.getitemnumber(ll_selrow,"del_check") > 0 then
	uo_status.st_message.text = "�ش� ���������� �̹� �Ƿڳ��뿡 ����Ǿ� �ֽ��ϴ�."
	return 0
end if

dw_tmm120u_01.deleterow(ll_selrow)
end event

type uo_status from w_ipis_sheet01`uo_status within w_tmm120u
end type

type dw_tmm120u_01 from u_vi_std_datawindow within w_tmm120u
integer x = 18
integer y = 24
integer width = 2807
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_tmm120u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;String 	ls_colName
Long		ll_rowcnt
datawindowchild ldwc

this.AcceptText ( )

This.setitem( row, "lastemp", g_s_empno )
This.setitem( row, "lastdate", g_s_datetime )

ls_colName = dwo.name
Choose Case ls_colName
	Case 'productname'
		SELECT COUNT(*) INTO :ll_rowcnt
		FROM PBGMS.TMM008
		WHERE ProductName = :data
		using sqlca;
		
		if ll_rowcnt > 0 then
			Messagebox("Ȯ��","�̹� �Էµ� ��ǰ���Դϴ�.")
			This.Setitem( row, 'productname', '' )
			return 1
		end if
End Choose

return 0
end event

