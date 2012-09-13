$PBExportHeader$uo_xdiv_itno_pura.sru
$PBExportComments$지역/공장 (가로)
forward
global type uo_xdiv_itno_pura from userobject
end type
type dw_1 from datawindow within uo_xdiv_itno_pura
end type
end forward

global type uo_xdiv_itno_pura from userobject
integer width = 3666
integer height = 104
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_xplant,  string ag_color )
dw_1 dw_1
end type
global uo_xdiv_itno_pura uo_xdiv_itno_pura

type variables
//Private :
			String is_xplant, is_div, is_pattno, is_pattser, is_itno
			DataWindowChild idwc
			
end variables

forward prototypes
public function string uf_get_xplant ()
public function string uf_get_div ()
public subroutine uf_set_value (string ag_pattno, string ag_pattser, string ag_xplant, string ag_div, string ag_itno)
public subroutine uf_set_width (integer ag_width)
public subroutine uf_get_value ()
public subroutine uf_set_color (string ag_color, integer ag_gubun)
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

public subroutine uf_set_value (string ag_pattno, string ag_pattser, string ag_xplant, string ag_div, string ag_itno);dw_1.Object.pattno[1] = ag_pattno
dw_1.Object.pattser[1] = ag_pattser
dw_1.Object.xplant[1] = ag_xplant
dw_1.Object.div[1] = ag_div
dw_1.Object.itno[1] = ag_itno

is_pattno = ag_pattno
is_pattser = ag_pattser
is_xplant = ag_xplant
is_div = ag_div
is_itno = ag_itno
end subroutine

public subroutine uf_set_width (integer ag_width);/*
	Argument    integer    ag_width
									0 - 형번호/제작순서/지역/공장/품번 :3666
									1 - 형번호/제작순서  
									2 - 형번호/제작순서/지역/공장									
*/

IF ag_width = 0 Then		//default
	This.Width = 3666
	dw_1.Width = 3666
	
ElseIF ag_width = 1 Then	//
	This.Width = 1184
	dw_1.Width = 1184

ElseIF ag_width = 2 Then	//
	This.Width = 2821
	dw_1.Width = 2821
End IF
end subroutine

public subroutine uf_get_value ();dw_1.AcceptText()

is_xplant = Trim(dw_1.object.xplant[1])
is_div = Trim(dw_1.object.div[1])

is_pattno = Trim(dw_1.Object.pattno[1])
is_pattser = Trim(dw_1.Object.pattser[1])

is_itno = Trim(dw_1.Object.itno[1])
end subroutine

public subroutine uf_set_color (string ag_color, integer ag_gubun);/*
	Argument  String  ag_color	
							"S"	- Sky
							"W"	- White
							"G"	- Gray
							"Y"	- Yellow
				 Int		ag_gubun
				 			 1		- 형번호,제작순서
							 2		- 지역,공장
							 3		- 품번
*/

IF ag_gubun = 1 Then	//형번호,제작순서
	f_set_color_dw_column(dw_1,"pattno",ag_color)
	f_set_color_dw_column(dw_1,"pattser",ag_color)	
ElseIF ag_gubun = 2 Then	//지역/공장
	f_set_color_dw_column(dw_1,"xplant",ag_color)
	f_set_color_dw_column(dw_1,"div",ag_color)	
Else 	//품번
	f_set_color_dw_column(dw_1,"itno",ag_color)	
End IF

//색상변경후 지역에 따라 바뀌는 공장이 변경안됨. 그래서 다시 호출함.
dw_1.Post Event Constructor()
end subroutine

on uo_xdiv_itno_pura.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_xdiv_itno_pura.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_xdiv_itno_pura
integer y = 4
integer width = 3666
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_xdiv_itno_pur"
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

is_pattno = This.Object.pattno[row]
is_pattser = This.Object.pattser[row]

is_itno = This.Object.itno[row]
end event

