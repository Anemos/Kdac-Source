$PBExportHeader$u_st_vertical.sru
$PBExportComments$Vertical Bar
forward
global type u_st_vertical from statictext
end type
end forward

global type u_st_vertical from statictext
int Width=106
int Height=93
boolean FocusRectangle=false
long BackColor=0
string Pointer="Ve_split.cur"
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
global u_st_vertical u_st_vertical

event ue_mousedown;//When mouse clicked, show Bar in Black
BackColor = 0
end event

