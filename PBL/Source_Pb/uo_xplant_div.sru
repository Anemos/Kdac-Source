$PBExportHeader$uo_xplant_div.sru
$PBExportComments$지역,공장선택(MRP용) UserObject
forward
global type uo_xplant_div from userobject
end type
type dw_1 from datawindow within uo_xplant_div
end type
end forward

global type uo_xplant_div from userobject
integer width = 1353
integer height = 120
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_xplant_div uo_xplant_div

on uo_xplant_div.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_xplant_div.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_xplant_div
integer x = 5
integer width = 1344
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "d_xplant_div"
boolean border = false
boolean livescroll = true
end type

event itemchanged;DataWindowChild cdw_1
String ls_column, ls_data

dw_1.AcceptText()
ls_column = This.GetColumnName()

If ls_column = 'xplant' Then
	This.SetItem(1, 'div', "")
	
	ls_data = This.GetItemString(1, 'xplant')
	This.GetChild('div', cdw_1)
	cdw_1.SetTransObject(SQLCA)
	cdw_1.Retrieve(ls_data)
	
	This.SetColumn('div')
	This.SetFocus()
End If

end event

event constructor;DataWindowChild cdw_1

dw_1.GetChild('xplant', cdw_1)
cdw_1.SetTransObject(SQLCA)
cdw_1.Retrieve()

dw_1.InsertRow(0)
end event

