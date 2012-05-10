$PBExportHeader$u_preview.sru
$PBExportComments$보고서 미리보기 버튼
forward
global type u_preview from UserObject
end type
type st_1 from statictext within u_preview
end type
type p_1 from picture within u_preview
end type
type cb_1 from commandbutton within u_preview
end type
end forward

global type u_preview from UserObject
int Width=197
int Height=176
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_click pbm_custom01
event type integer ue_enable ( boolean ab_enable )
st_1 st_1
p_1 p_1
cb_1 cb_1
end type
global u_preview u_preview

on u_preview.create
this.st_1=create st_1
this.p_1=create p_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.p_1,&
this.cb_1}
end on

on u_preview.destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_1)
end on

type st_1 from statictext within u_preview
int X=18
int Y=116
int Width=160
int Height=40
boolean Enabled=false
string Text="Preview"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-7
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within u_preview
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
int X=23
int Y=8
int Width=133
int Height=100
boolean Enabled=false
string PictureName="Pb_repor.bmp"
boolean FocusRectangle=false
end type

event ue_lbuttondown;Parent.borderStyle = StyleLowered!
//Parent.TriggerEvent('ue_click')
end event

event ue_lbuttonup;Parent.borderStyle = StyleRaised!
Parent.TriggerEvent('ue_click')
end event

type cb_1 from commandbutton within u_preview
int Width=187
int Height=168
int TabOrder=10
int TextSize=-9
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent('ue_click')
end event

