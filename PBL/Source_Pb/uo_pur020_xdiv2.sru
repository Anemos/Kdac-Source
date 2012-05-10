$PBExportHeader$uo_pur020_xdiv2.sru
$PBExportComments$지역/공장 (세로)
forward
global type uo_pur020_xdiv2 from userobject
end type
type dw_1 from datawindow within uo_pur020_xdiv2
end type
end forward

global type uo_pur020_xdiv2 from userobject
integer width = 667
integer height = 204
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_xplant,  string ag_color )
dw_1 dw_1
end type
global uo_pur020_xdiv2 uo_pur020_xdiv2

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

public function string uf_get_xplant ();Return is_xplant
end function

public function string uf_get_div ();Return is_div
end function

on uo_pur020_xdiv2.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_pur020_xdiv2.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_pur020_xdiv2
integer width = 686
integer height = 196
integer taborder = 10
string title = "none"
string dataobject = "d_pur010_xdiv2"
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

end event

event itemchanged;This.AcceptText()

IF dwo.name = "xplant" Then
	This.SetItem(1,'div', ' ')
	idwc.Retrieve(data)
End IF

is_xplant = This.object.xplant[row]
is_div = This.object.div[row]
end event

