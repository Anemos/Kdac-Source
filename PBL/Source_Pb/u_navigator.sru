$PBExportHeader$u_navigator.sru
$PBExportComments$·¹ÄÚµå ÀÌµ¿ ¹öÆ°
forward
global type u_navigator from UserObject
end type
type st_last from statictext within u_navigator
end type
type st_next from statictext within u_navigator
end type
type st_prev from statictext within u_navigator
end type
type st_first from statictext within u_navigator
end type
type p_4 from picture within u_navigator
end type
type p_3 from picture within u_navigator
end type
type p_2 from picture within u_navigator
end type
type p_1 from picture within u_navigator
end type
type cb_last from commandbutton within u_navigator
end type
type cb_first from commandbutton within u_navigator
end type
type cb_next from commandbutton within u_navigator
end type
type cb_previous from commandbutton within u_navigator
end type
end forward

global type u_navigator from UserObject
int Width=759
int Height=176
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_click pbm_custom01
event type integer ue_enable ( boolean ab_enable )
event ue_prev ( )
event ue_next ( )
event ue_first ( )
event ue_last ( )
event ue_disable_next ( )
event ue_enable_next ( )
event ue_disable_prev ( )
event ue_enable_prev ( )
st_last st_last
st_next st_next
st_prev st_prev
st_first st_first
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
cb_last cb_last
cb_first cb_first
cb_next cb_next
cb_previous cb_previous
end type
global u_navigator u_navigator

event ue_disable_next;st_next.textcolor = rgb(233,233,233) 
cb_next.enabled = false

st_last.textcolor = rgb(233,233,233) 
cb_last.enabled = false

end event

event ue_enable_next;st_next.textcolor = rgb(0,0,0) 
cb_next.enabled = true

st_last.textcolor = rgb(0,0,0) 
cb_last.enabled = true

end event

event ue_disable_prev;st_prev.textcolor = rgb(233,233,233) 
cb_previous.enabled = false

st_first.textcolor = rgb(233,233,233) 
cb_first.enabled = false

end event

event ue_enable_prev;st_first.textcolor = rgb(0,0,0) 
cb_first.enabled = true

st_prev.textcolor = rgb(0,0,0) 
cb_previous.enabled = true

end event

on u_navigator.create
this.st_last=create st_last
this.st_next=create st_next
this.st_prev=create st_prev
this.st_first=create st_first
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.cb_last=create cb_last
this.cb_first=create cb_first
this.cb_next=create cb_next
this.cb_previous=create cb_previous
this.Control[]={this.st_last,&
this.st_next,&
this.st_prev,&
this.st_first,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.cb_last,&
this.cb_first,&
this.cb_next,&
this.cb_previous}
end on

on u_navigator.destroy
destroy(this.st_last)
destroy(this.st_next)
destroy(this.st_prev)
destroy(this.st_first)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.cb_last)
destroy(this.cb_first)
destroy(this.cb_next)
destroy(this.cb_previous)
end on

type st_last from statictext within u_navigator
int X=576
int Y=112
int Width=165
int Height=44
boolean Enabled=false
string Text="¸¶Áö¸·"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_next from statictext within u_navigator
int X=407
int Y=112
int Width=142
int Height=44
boolean Enabled=false
string Text="´Ù À½"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_prev from statictext within u_navigator
int X=219
int Y=112
int Width=142
int Height=44
boolean Enabled=false
string Text="ÀÌ Àü"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_first from statictext within u_navigator
int X=27
int Y=112
int Width=142
int Height=44
boolean Enabled=false
string Text="Ã³ À½"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type p_4 from picture within u_navigator
int X=603
int Y=12
int Width=110
int Height=96
boolean Enabled=false
string PictureName="last.bmp"
boolean FocusRectangle=false
end type

type p_3 from picture within u_navigator
int X=416
int Y=12
int Width=110
int Height=96
boolean Enabled=false
string PictureName="next.bmp"
boolean FocusRectangle=false
end type

type p_2 from picture within u_navigator
int X=229
int Y=12
int Width=110
int Height=96
boolean Enabled=false
string PictureName="prev.bmp"
boolean FocusRectangle=false
end type

type p_1 from picture within u_navigator
int X=41
int Y=12
int Width=110
int Height=96
boolean Enabled=false
string PictureName="first.bmp"
boolean FocusRectangle=false
end type

type cb_last from commandbutton within u_navigator
int X=562
int Width=187
int Height=168
int TabOrder=10
int TextSize=-9
int Weight=700
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent('ue_last')
end event

type cb_first from commandbutton within u_navigator
int Width=187
int Height=168
int TabOrder=40
int TextSize=-9
int Weight=700
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent('ue_first')
end event

type cb_next from commandbutton within u_navigator
int X=375
int Width=187
int Height=168
int TabOrder=30
int TextSize=-9
int Weight=700
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent('ue_next')
end event

type cb_previous from commandbutton within u_navigator
int X=187
int Width=187
int Height=168
int TabOrder=20
int TextSize=-9
int Weight=700
string FaceName="±¼¸²"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;parent.TriggerEvent('ue_prev')
end event

