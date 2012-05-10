$PBExportHeader$w_pisq813i.srw
$PBExportComments$년간 클레임정산
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
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq813i
end type

