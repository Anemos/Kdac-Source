$PBExportHeader$w_mpm430u.srw
$PBExportComments$���ְ�����������
forward
global type w_mpm430u from w_ipis_sheet01
end type
type dw_mpm430u_01 from u_vi_std_datawindow within w_mpm430u
end type
end forward

global type w_mpm430u from w_ipis_sheet01
dw_mpm430u_01 dw_mpm430u_01
end type
global w_mpm430u w_mpm430u

type variables
boolean ib_cal_change
end variables

on w_mpm430u.create
int iCurrent
call super::create
this.dw_mpm430u_01=create dw_mpm430u_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm430u_01
end on

on w_mpm430u.destroy
call super::destroy
destroy(this.dw_mpm430u_01)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

dw_mpm430u_01.Width = newwidth 	- ( dw_mpm430u_01.x + ls_split )
dw_mpm430u_01.Height= newheight - ( dw_mpm430u_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;
dw_mpm430u_01.settransobject(sqlmpms)

This.Triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt

ll_rowcnt = dw_mpm430u_01.retrieve()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "��ȸ�� �ڷᰡ �����ϴ�."
	return 0
end if
end event

event ue_save;call super::ue_save;string ls_message

sqlmpms.AutoCommit = False

if dw_mpm430u_01.modifiedcount() > 0 then
	if dw_mpm430u_01.update() <> 1 then
		ls_message = "���ְ��� �۾�����ð� ����ÿ� ������ �߻��Ͽ����ϴ�."
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True
uo_status.st_message.text = "����Ǿ����ϴ�."

return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True
uo_status.st_message.text = ls_message

return -1
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm430u
end type

type dw_mpm430u_01 from u_vi_std_datawindow within w_mpm430u
integer x = 32
integer y = 28
integer width = 2958
integer height = 1760
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm430u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

