$PBExportHeader$w_pisq610u.srw
$PBExportComments$����Ÿ �ڵ� ���
forward
global type w_pisq610u from w_ipis_sheet01
end type
type dw_pisq610u_01 from u_vi_std_datawindow within w_pisq610u
end type
end forward

global type w_pisq610u from w_ipis_sheet01
dw_pisq610u_01 dw_pisq610u_01
end type
global w_pisq610u w_pisq610u

on w_pisq610u.create
int iCurrent
call super::create
this.dw_pisq610u_01=create dw_pisq610u_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq610u_01
end on

on w_pisq610u.destroy
call super::destroy
destroy(this.dw_pisq610u_01)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_pisq610u_01.Width = newwidth	- (ls_gap * 3)
dw_pisq610u_01.Height= newheight - (dw_pisq610u_01.y + ls_status)
end event

event open;call super::open;// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
if g_s_empno = 'ADMIN' then
	i_b_retrieve 	= True
	i_b_insert 	 	= True
	i_b_save 		= True
	i_b_delete 		= True
else
	i_b_retrieve 	= True
	i_b_insert 	 	= False
	i_b_save 		= False
	i_b_delete 		= False
end if
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_postopen;call super::ue_postopen;
dw_pisq610u_01.settransobject(sqleis)
dw_pisq610u_01.retrieve()
end event

event ue_insert;call super::ue_insert;dw_pisq610u_01.insertrow(0)
end event

event ue_save;call super::ue_save;
dw_pisq610u_01.accepttext()

if dw_pisq610u_01.modifiedcount() > 0 or dw_pisq610u_01.deletedcount() > 0 then
	// Pass
else
	uo_status.st_message.text = "����� ����Ÿ�� �����ϴ�."
	return 0
end if

sqlmpms.AutoCommit = False

if dw_pisq610u_01.update() = 1 then
	Commit using sqleis;
	sqleis.AutoCommit = True
	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	RollBack using sqleis;
	sqleis.AutoCommit = True
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if
end event

event ue_retrieve;call super::ue_retrieve;dw_pisq610u_01.reset()
dw_pisq610u_01.retrieve()
end event

event ue_delete;call super::ue_delete;integer li_selrow

li_selrow = dw_pisq610u_01.getselectedrow(0)

dw_pisq610u_01.deleterow(li_selrow)
end event

event activate;call super::activate;
if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if
end event

event close;call super::close;f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq610u
end type

type dw_pisq610u_01 from u_vi_std_datawindow within w_pisq610u
integer x = 18
integer y = 12
integer width = 2318
integer height = 1856
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq610u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

