$PBExportHeader$w_disconnect.srw
$PBExportComments$사용중지시 자동종료
forward
global type w_disconnect from Window
end type
type cb_1 from commandbutton within w_disconnect
end type
type st_time from statictext within w_disconnect
end type
type st_4 from statictext within w_disconnect
end type
type st_3 from statictext within w_disconnect
end type
type st_2 from statictext within w_disconnect
end type
type st_1 from statictext within w_disconnect
end type
end forward

global type w_disconnect from Window
int X=1074
int Y=704
int Width=1586
int Height=840
boolean TitleBar=true
string Title="시스템 종료"
long BackColor=255
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
st_time st_time
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_disconnect w_disconnect

event open;Timer(1)
end event

event timer;int	li_left

li_left = dec(st_time.Text) - 1
st_time.Text = String(li_left,"#0")

IF	li_left = 0 THEN
	RollBack;
	DisConnect;
	Halt
END IF

end event

on w_disconnect.create
this.cb_1=create cb_1
this.st_time=create st_time
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.st_time,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_disconnect.destroy
destroy(this.cb_1)
destroy(this.st_time)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_disconnect
int X=690
int Y=596
int Width=247
int Height=108
int TabOrder=1
string Text="확인"
int TextSize=-12
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;CLOSE(Parent)
end event

type st_time from statictext within w_disconnect
int X=718
int Y=452
int Width=174
int Height=108
boolean Enabled=false
string Text="60"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=65535
long BackColor=255
int TextSize=-20
int Weight=700
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_disconnect
int X=114
int Y=328
int Width=1376
int Height=76
boolean Enabled=false
string Text="시스템이 종료됩니다."
boolean FocusRectangle=false
long TextColor=65535
long BackColor=255
int TextSize=-12
int Weight=700
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_disconnect
int X=114
int Y=240
int Width=1376
int Height=76
boolean Enabled=false
string Text="저장되지  않은  모든 작업은 취소되고"
boolean FocusRectangle=false
long TextColor=65535
long BackColor=255
int TextSize=-12
int Weight=700
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_disconnect
int X=114
int Y=152
int Width=1376
int Height=76
boolean Enabled=false
string Text="1분 이내에 확인버튼을 누르지 않으면"
boolean FocusRectangle=false
long TextColor=65535
long BackColor=255
int TextSize=-12
int Weight=700
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_disconnect
int X=114
int Y=64
int Width=1376
int Height=76
boolean Enabled=false
string Text="시스템이 사용되지 않고 있습니다."
boolean FocusRectangle=false
long TextColor=65535
long BackColor=255
int TextSize=-12
int Weight=700
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

