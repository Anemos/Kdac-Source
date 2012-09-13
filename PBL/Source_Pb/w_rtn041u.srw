$PBExportHeader$w_rtn041u.srw
$PBExportComments$���������
forward
global type w_rtn041u from w_ipis_sheet01
end type
type dw_rtn041u_01 from u_vi_std_datawindow within w_rtn041u
end type
end forward

global type w_rtn041u from w_ipis_sheet01
dw_rtn041u_01 dw_rtn041u_01
end type
global w_rtn041u w_rtn041u

on w_rtn041u.create
int iCurrent
call super::create
this.dw_rtn041u_01=create dw_rtn041u_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rtn041u_01
end on

on w_rtn041u.destroy
call super::destroy
destroy(this.dw_rtn041u_01)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_rtn041u_01.Width = newwidth	- (ls_gap * 4)
dw_rtn041u_01.Height= newheight - (dw_rtn041u_01.y + ls_status)
end event

event open;call super::open;// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= False
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_postopen;call super::ue_postopen;dw_rtn041u_01.settransobject(sqlca)

this.triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;dw_rtn041u_01.reset()
dw_rtn041u_01.retrieve()
end event

event ue_insert;call super::ue_insert;long ll_rowcnt

SELECT COUNT(*) INTO :ll_rowcnt
FROM PBRTN.RTN019
WHERE Xcmcd = '01' AND Xinemp = :g_s_empno
using sqlca;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "������ PL�� �����Ǿ� �ֽ��ϴ�."
	return 0
end if

openwithparm(w_rtn_select_pl, '')

This.triggerevent("ue_retrieve")
end event

event ue_delete;call super::ue_delete;long ll_selrow, ll_rowcnt
string ls_xinemp, ls_xplemp

ll_selrow = dw_rtn041u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "������ ���� ������ �ֽʽÿ�"
	return -1
end if

ls_xinemp = dw_rtn041u_01.getitemstring(ll_selrow,"xinemp")
ls_xplemp = dw_rtn041u_01.getitemstring(ll_selrow,"xplemp")

if g_s_empno <> '000030' then
	if ls_xinemp <> g_s_empno then
		uo_status.st_message.text = "��ϵ� ����ڿ� �α����� ����� �������� �ʽ��ϴ�."
		return -1
	end if
end if

SELECT COUNT(*) INTO :ll_rowcnt
FROM PBRTN.RTN011
WHERE Raplemp = :ls_xplemp AND Raplchk = 'N'
using sqlca;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "�ش� PL�� �����ؾߵ� ����ǰ�������� �����մϴ�."
	return -1
end if

SELECT COUNT(*) INTO :ll_rowcnt
FROM PBRTN.RTN013
WHERE Rcplemp = :ls_xplemp AND Rcplchk = 'N'
using sqlca;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "�ش� PL�� �����ؾߵ� ���������� �����մϴ�."
	return -1
end if

dw_rtn041u_01.deleterow(ll_selrow)

this.postevent("ue_save")
return 0
end event

event ue_save;call super::ue_save;
dw_rtn041u_01.accepttext()

if dw_rtn041u_01.modifiedcount() < 1 and dw_rtn041u_01.deletedcount() < 1 then
	uo_status.st_message.text = "����� ����Ÿ�� �����ϴ�."
	return 0
end if

sqlca.AutoCommit = False

if dw_rtn041u_01.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "����Ǿ����ϴ�."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "������ �����߽��ϴ�."
end if
end event

type uo_status from w_ipis_sheet01`uo_status within w_rtn041u
end type

type dw_rtn041u_01 from u_vi_std_datawindow within w_rtn041u
integer x = 27
integer y = 24
integer width = 2601
integer height = 1476
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_rtn041u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;String 	ls_colName, ls_xinemp
Long		ll_rowcnt

ls_colName = dwo.name
Choose Case ls_colName
	Case 'xplemp'
		ls_xinemp = this.getitemstring(row,"xinemp")
		if ls_xinemp <> g_s_empno then
			Messagebox("Ȯ��","��ϵ� ���� �α��� ����� �������� �ʽ��ϴ�.")
			return 1
		end if
End Choose

return 0
end event

