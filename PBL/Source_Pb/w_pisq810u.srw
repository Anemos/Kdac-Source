$PBExportHeader$w_pisq810u.srw
$PBExportComments$����Ȯ������
forward
global type w_pisq810u from w_ipis_sheet01
end type
end forward

global type w_pisq810u from w_ipis_sheet01
end type
global w_pisq810u w_pisq810u

on w_pisq810u.create
int iCurrent
call super::create
end on

on w_pisq810u.destroy
call super::destroy
end on

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq810u
end type

