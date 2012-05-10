$PBExportHeader$u_pisp_kbno_scan.sru
$PBExportComments$User Object for KB Number Scanning Area
forward
global type u_pisp_kbno_scan from datawindow
end type
end forward

global type u_pisp_kbno_scan from datawindow
integer width = 1065
integer height = 148
integer taborder = 1
string dataobject = "d_pisp_kbno_scan"
boolean border = false
boolean livescroll = true
event ue_enter pbm_dwnprocessenter
end type
global u_pisp_kbno_scan u_pisp_kbno_scan

type prototypes

end prototypes

event constructor;InsertRow(0)
end event

event getfocus;// ImmSetConversionStatus(lul_context, 0, 0)		- 영어 Toggle
// ImmSetConversionStatus(lul_context, 1, 0)		- 한글 Toggle

//ulong lul_handle,	lul_context
//
//lul_handle	= handle(This)
//lul_context	= ImmGetContext(lul_handle)
//
//ImmSetConversionStatus(lul_context, 0, 0)
end event

on u_pisp_kbno_scan.create
end on

on u_pisp_kbno_scan.destroy
end on

