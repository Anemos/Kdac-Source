$PBExportHeader$w_pisq813i.srw
$PBExportComments$�Ⱓ Ŭ��������
forward
global type w_pisq813i from w_ipis_sheet01
end type
end forward

global type w_pisq813i from w_ipis_sheet01
end type
global w_pisq813i w_pisq813i

on w_pisq813i.create
int iCurrent
call super::create
end on

on w_pisq813i.destroy
call super::destroy
end on

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq813i
end type

