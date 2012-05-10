$PBExportHeader$uo_fix_xdiv.sru
$PBExportComments$지역/공장 (가로)
forward
global type uo_fix_xdiv from userobject
end type
type dw_1 from datawindow within uo_fix_xdiv
end type
end forward

global type uo_fix_xdiv from userobject
integer width = 2043
integer height = 112
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_xplant,  string ag_color )
dw_1 dw_1
end type
global uo_fix_xdiv uo_fix_xdiv

type variables
Private :
			String is_xplant, is_div
			DataWindowChild idwc
end variables

forward prototypes
public function string uf_get_xplant ()
public subroutine uf_set_modify_text ()
public subroutine uf_set_value (string ag_xplant, string ag_div)
public function string uf_get_div ()
public subroutine uf_set_color (string ag_color)
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

public subroutine uf_set_modify_text ();dw_1.Modify("t_1.Text='부품 지역  '")
dw_1.Modify("t_2.Text='부품 공장  '")
end subroutine

public subroutine uf_set_value (string ag_xplant, string ag_div);is_xplant = Trim(ag_xplant)
is_div = Trim(ag_div)

dw_1.Object.xplant[1] = is_xplant
dw_1.Object.div[1] = is_div
end subroutine

public function string uf_get_div ();Return is_div
end function

public subroutine uf_set_color (string ag_color);f_set_color_dw_column(dw_1,"xplant",ag_color)
f_set_color_dw_column(dw_1,"div",ag_color)

dw_1.Post Event Constructor()
end subroutine

on uo_fix_xdiv.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_fix_xdiv.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_fix_xdiv
integer y = 4
integer width = 2043
integer height = 104
integer taborder = 10
string title = "none"
string dataobject = "d_fix_xdiv"
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



end event

