$PBExportHeader$w_pisq811i.srw
$PBExportComments$����Ŭ��������(����)
forward
global type w_pisq811i from w_ipis_sheet01
end type
end forward

global type w_pisq811i from w_ipis_sheet01
end type
global w_pisq811i w_pisq811i

on w_pisq811i.create
int iCurrent
call super::create
end on

on w_pisq811i.destroy
call super::destroy
end on

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq811i
end type

