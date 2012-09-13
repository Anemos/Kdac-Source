$PBExportHeader$u_pisp_itemcode_input.sru
$PBExportComments$ItemCode Input Area
forward
global type u_pisp_itemcode_input from datawindow
end type
end forward

global type u_pisp_itemcode_input from datawindow
integer width = 1070
integer height = 84
integer taborder = 1
string dataobject = "d_pisp_itemcode_input"
boolean border = false
boolean livescroll = true
event ue_enter pbm_dwnprocessenter
end type
global u_pisp_itemcode_input u_pisp_itemcode_input

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

on u_pisp_itemcode_input.create
end on

on u_pisp_itemcode_input.destroy
end on

