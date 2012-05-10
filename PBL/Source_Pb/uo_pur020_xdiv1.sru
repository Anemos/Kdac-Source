$PBExportHeader$uo_pur020_xdiv1.sru
$PBExportComments$지역/공장 (가로)
forward
global type uo_pur020_xdiv1 from userobject
end type
type dw_1 from datawindow within uo_pur020_xdiv1
end type
end forward

global type uo_pur020_xdiv1 from userobject
integer width = 1399
integer height = 96
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_xplant,  string ag_color )
event ue_item_change ( )
dw_1 dw_1
end type
global uo_pur020_xdiv1 uo_pur020_xdiv1

type variables
Private :
			String is_xplant, is_div
			DataWindowChild idwc
end variables

forward prototypes
public function string uf_get_xplant ()
public function string uf_get_div ()
end prototypes

event ue_constructor(string ag_xplant, string ag_color);///////////////////////////////
// 색상변경
//		argument : ag_color
//               				'S' - sky
//                         'W' - white
/////////////////////////////////////////////
is_xplant = ag_xplant

IF ag_color = 'S' Then
	dw_1.Modify("xplant.Background.Color = 15780518")	//sky	
	dw_1.Modify("div.Background.Color = 15780518")	//sky	
Else
	dw_1.Modify("xplant.Background.Color = 16777215")	//White
	dw_1.Modify("div.Background.Color = 16777215")	//sky	
End IF


end event

event ue_item_change();//ue_item_change
end event

public function string uf_get_xplant ();Return is_xplant
end function

public function string uf_get_div ();Return is_div
end function

on uo_pur020_xdiv1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_pur020_xdiv1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_pur020_xdiv1
integer width = 1417
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_pur010_xdiv"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)

//공장
This.GetChild("div",idwc)
idwc.SetTransObject(sqlca)
//idwc.Retrieve('D')
idwc.Retrieve(is_xplant)
This.InsertRow(0)

//is_xplant = 'D'
is_div = ' '

f_dddw_width_pura(This,"xplant",idwc,"code",0)
f_dddw_width_pura(This,"div",idwc,"code",0)

end event

event itemchanged;This.AcceptText()

IF dwo.name = "xplant" Then
	This.SetItem(1,'div', ' ')
	idwc.Retrieve(data)
End IF

is_xplant = This.object.xplant[row]
is_div = This.object.div[row]


//String ls_name
//ls_name = Trim(dwo.name)

uo_pur020_xdiv1 PO
PO = This.GetParent()
PO.Event Post ue_item_change()

//uo_pur020_xdiv1.Event ue_item_change()
end event

