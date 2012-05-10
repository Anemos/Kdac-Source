$PBExportHeader$u_st_horizontal.sru
$PBExportComments$Horizontal Var
forward
global type u_st_horizontal from statictext
end type
end forward

global type u_st_horizontal from statictext
int Width=106
int Height=93
boolean FocusRectangle=false
long BackColor=0
string Pointer="Ho_split.cur"
int TextSize=-10
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
event ue_mousedown pbm_lbuttondown
event ue_mouseup pbm_lbuttonup
event ue_mousemove pbm_mousemove
end type
global u_st_horizontal u_st_horizontal

event ue_mousedown;//When mouse clicked, show Bar in Black
BackColor = 0
end event

