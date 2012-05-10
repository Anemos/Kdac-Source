$PBExportHeader$u_retrieve.sru
$PBExportComments$Á¶È¸ ¹öÆ°
forward
global type u_retrieve from UserObject
end type
type st_1 from statictext within u_retrieve
end type
type p_1 from picture within u_retrieve
end type
type cb_1 from commandbutton within u_retrieve
end type
end forward

global type u_retrieve from UserObject
int Width=197
int Height=176
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_click pbm_custom01
event ue_enable ( )
event ue_disable ( )
st_1 st_1
p_1 p_1
cb_1 cb_1
end type
global u_retrieve u_retrieve

event ue_enable;st_1.textcolor = rgb(0,0,0)
cb_1.enabled = true
end event

event ue_disable;
st_1.textcolor = rgb( 233,233,233)
cb_1.enabled = false
end event

on u_retrieve.create
this.st_1=create st_1
this.p_1=create p_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.p_1,&
this.cb_1}
end on

on u_retrieve.destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_1)
end on

type st_1 from statictext within u_retrieve
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
int X=18
int Y=112
int Width=151
int Height=44
boolean Enabled=false
string Text="Á¶ È¸"
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

type p_1 from picture within u_retrieve
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
int X=41
int Y=12
int Width=105
int Height=88
boolean Enabled=false
string PictureName="pb_retri.bmp"
boolean FocusRectangle=false
end type

event ue_lbuttondown;Parent.borderStyle = StyleLowered!
//Parent.TriggerEvent('ue_click')
end event

event ue_lbuttonup;Parent.borderStyle = StyleRaised!
Parent.TriggerEvent('ue_click')
end event

type cb_1 from commandbutton within u_retrieve
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

