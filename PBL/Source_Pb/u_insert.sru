$PBExportHeader$u_insert.sru
$PBExportComments$ÀÔ·Â ¹öÆ°
forward
global type u_insert from UserObject
end type
type st_1 from statictext within u_insert
end type
type p_1 from picture within u_insert
end type
type cb_1 from commandbutton within u_insert
end type
end forward

global type u_insert from UserObject
int Width=197
int Height=180
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_click pbm_custom01
event ue_enable ( boolean ab_enable )
event ue_disable ( )
st_1 st_1
p_1 p_1
cb_1 cb_1
end type
global u_insert u_insert

event ue_enable;st_1.textcolor = rgb(0,0,0)
cb_1.enabled = true
end event

event ue_disable;st_1.TextColor = rgb(233,233,233)
cb_1.enabled = false
end event

on u_insert.create
this.st_1=create st_1
this.p_1=create p_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.p_1,&
this.cb_1}
end on

on u_insert.destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_1)
end on

type st_1 from statictext within u_insert
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
int X=9
int Y=112
int Width=169
int Height=48
boolean Enabled=false
string Text="Ãß °¡"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event ue_lbuttondown;Parent.borderStyle = StyleLowered!
end event

event ue_lbuttonup;Parent.borderStyle = StyleRaised!
Parent.TriggerEvent('ue_click')
end event

type p_1 from picture within u_insert
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
int X=23
int Y=8
int Width=133
int Height=100
boolean Enabled=false
string PictureName="insert.bmp"
boolean FocusRectangle=false
end type

event ue_lbuttondown;Parent.borderStyle = StyleLowered!
//Parent.TriggerEvent('ue_click')
end event

event ue_lbuttonup;Parent.borderStyle = StyleRaised!
Parent.TriggerEvent('ue_click')
end event

type cb_1 from commandbutton within u_insert
int Width=187
int Height=168
int TabOrder=10
int TextSize=-9
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent('ue_click')
end event

