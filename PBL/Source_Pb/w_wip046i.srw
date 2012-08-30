$PBExportHeader$w_wip046i.srw
$PBExportComments$무상사급품목다운로드(기간별)
forward
global type w_wip046i from w_ipis_sheet01
end type
type dw_wip046i_01 from u_vi_std_datawindow within w_wip046i
end type
end forward

global type w_wip046i from w_ipis_sheet01
dw_wip046i_01 dw_wip046i_01
end type
global w_wip046i w_wip046i

on w_wip046i.create
int iCurrent
call super::create
this.dw_wip046i_01=create dw_wip046i_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_wip046i_01
end on

on w_wip046i.destroy
call super::destroy
destroy(this.dw_wip046i_01)
end on

type uo_status from w_ipis_sheet01`uo_status within w_wip046i
end type

type dw_wip046i_01 from u_vi_std_datawindow within w_wip046i
integer x = 32
integer y = 252
integer width = 3483
integer height = 1592
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip046i_01"
end type

