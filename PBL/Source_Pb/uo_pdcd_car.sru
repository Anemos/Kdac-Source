$PBExportHeader$uo_pdcd_car.sru
$PBExportComments$형번호, 제작순서, 제품군, 차종
forward
global type uo_pdcd_car from userobject
end type
type dw_1 from datawindow within uo_pdcd_car
end type
end forward

global type uo_pdcd_car from userobject
integer width = 2907
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_pattno_color,  string ag_pattser_color,  string ag_pdcd_color,  string ag_carcd_color )
dw_1 dw_1
end type
global uo_pdcd_car uo_pdcd_car

type variables
//Private :
			String is_pdcd, is_carcd, is_pattno, is_pattser
			DataWindowChild idwc_1, idwc_2
			str_string_return  lstr_return
end variables

forward prototypes
public subroutine uf_set_width (integer ag_width)
public function str_string_return uf_get_return ()
public subroutine uf_get_value ()
public subroutine uf_set_color (string ag_column, string ag_color)
end prototypes

event ue_constructor(string ag_pattno_color, string ag_pattser_color, string ag_pdcd_color, string ag_carcd_color);///////////////////////////////
// 색상변경
//		argument : ag_pattno_color , ag_pattser_color, ag_pdcd_color , ag_carcd_color
//               			  'S' - sky
//                         'W' - white
/////////////////////////////////////////////
dw_1.SetRedraw(False)
//형번호
IF ag_pattno_color = "S" Then
	dw_1.Modify("pattno.Background.Color = 15780518")	//sky	
Else
	dw_1.Modify("pattno.Background.Color = 16777215")	//White
End IF
//제작순서
IF ag_pattser_color = "S" Then
	dw_1.Modify("pattser.Background.Color = 15780518")	//sky	
Else
	dw_1.Modify("pattser.Background.Color = 16777215")	//White
End IF
//제품군
IF ag_pdcd_color = "S" Then
	dw_1.Modify("pdcd.Background.Color = 15780518")	//sky	
Else
	dw_1.Modify("pdcd.Background.Color = 16777215")	//White
End IF
//차종
IF ag_carcd_color = "S" Then
	dw_1.Modify("carcd.Background.Color = 15780518")	//sky	
Else
	dw_1.Modify("carcd.Background.Color = 16777215")	//White
End IF

dw_1.SetRedraw(True)
end event

public subroutine uf_set_width (integer ag_width);/*
	Argument    integer    ag_width
									0 - 형번호/제작순서/제품군/차종 : 2907	
									1 - 형번호/제작순서  : 1230
*/

IF ag_width = 0 Then		//default
	This.Width = 2907
	dw_1.Width = 2907
	
ElseIF ag_width = 1 Then	
	This.Width = 1230
	dw_1.Width = 1230
	
Else
	This.Width = ag_width
	dw_1.Width = ag_width
End IF
end subroutine

public function str_string_return uf_get_return ();dw_1.AcceptText()

lstr_return.pattno = Trim(dw_1.object.pattno[1])
lstr_return.pattser = Trim(dw_1.object.pattser[1])
lstr_return.pdcd = is_pdcd
lstr_return.carcd = is_carcd

Return lstr_return
end function

public subroutine uf_get_value ();dw_1.AcceptText()
is_pattno = dw_1.Object.pattno[1]
is_pattser = dw_1.Object.pattser[1]
is_pdcd = dw_1.object.pdcd[1]
is_carcd = dw_1.object.carcd[1]

end subroutine

public subroutine uf_set_color (string ag_column, string ag_color);f_set_color_dw_column(dw_1,ag_column,ag_color)


//String l_s_command
//long 	 l_l_color1 = 15780518 ,l_l_color2 = 16777215 ,l_l_color3 = 12632256  ,l_l_color4 = 65535
////	                 sky                     white                  gray                   yellow
//
//dw_1.SetRedraw(False)
//
//IF ag_color = "S" Then
//	l_s_command	=	ag_column + ".Background.Color = '" + String(l_l_color1) + "'"
//ElseIF ag_color = "W" Then
//	l_s_command	=	ag_column + ".Background.Color = '" + String(l_l_color2) + "'"
//ElseIF ag_color = "G" Then
//	l_s_command	=	ag_column + ".Background.Color = '" + String(l_l_color3) + "'"
//ElseIF ag_color = "Y" Then
//	l_s_command	=	ag_column + ".Background.Color = '" + String(l_l_color4) + "'"	
//End If
//
//dw_1.Modify(l_s_command)
//dw_1.SetRedraw(True)
end subroutine

on uo_pdcd_car.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_pdcd_car.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_pdcd_car
integer y = 4
integer width = 2907
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_pdcd_car"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)

//제품군
This.GetChild("pdcd",idwc_1)
idwc_1.SetTransObject(sqlca)
idwc_1.Retrieve()
//차종
This.GetChild("carcd",idwc_2)
idwc_2.SetTransObject(sqlca)
idwc_2.Retrieve()

This.InsertRow(0)

//width
f_dddw_width_pura(This,"pdcd",idwc_1,"cocode",0)
f_dddw_width_pura(This,"carcd",idwc_2,"cocode",0)


end event

event itemchanged;This.AcceptText()
is_pattno = This.Object.pattno[row]
is_pattser = This.Object.pattser[row]
is_pdcd = This.object.pdcd[row]
is_carcd = This.object.carcd[row]

end event

