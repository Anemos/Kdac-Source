$PBExportHeader$w_mpm112u.srw
$PBExportComments$�����ڵ�����
forward
global type w_mpm112u from w_ipis_sheet01
end type
type dw_mpm112u_01 from u_vi_std_datawindow within w_mpm112u
end type
end forward

global type w_mpm112u from w_ipis_sheet01
dw_mpm112u_01 dw_mpm112u_01
end type
global w_mpm112u w_mpm112u

on w_mpm112u.create
int iCurrent
call super::create
this.dw_mpm112u_01=create dw_mpm112u_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm112u_01
end on

on w_mpm112u.destroy
call super::destroy
destroy(this.dw_mpm112u_01)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_mpm112u_01.Width = newwidth	- (ls_gap * 3)
dw_mpm112u_01.Height= newheight - (dw_mpm112u_01.y + ls_status)
end event

event ue_postopen;call super::ue_postopen;
dw_mpm112u_01.settransobject(sqlmpms)
dw_mpm112u_01.retrieve()
end event

event ue_retrieve;call super::ue_retrieve;
dw_mpm112u_01.reset()
dw_mpm112u_01.retrieve()
end event

event ue_insert;call super::ue_insert;dw_mpm112u_01.insertrow(0)
end event

event ue_save;call super::ue_save;
dw_mpm112u_01.accepttext()

if dw_mpm112u_01.modifiedcount() < 1 then
	uo_status.st_message.text = "����� ����Ÿ�� �����ϴ�."
	return 0
end if

sqlmpms.AutoCommit = False

if dw_mpm112u_01.update() = 1 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	RollBack using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if
end event

event open;call super::open;// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm112u
end type

type dw_mpm112u_01 from u_vi_std_datawindow within w_mpm112u
integer x = 18
integer y = 24
integer width = 2807
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm112u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

