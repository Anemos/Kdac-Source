$PBExportHeader$w_pisp007u.srw
$PBExportComments$코드마스터 등록
forward
global type w_pisp007u from window
end type
type sle_codeid from singlelineedit within w_pisp007u
end type
type st_2 from statictext within w_pisp007u
end type
type st_1 from statictext within w_pisp007u
end type
type cb_1 from commandbutton within w_pisp007u
end type
type cb_2 from commandbutton within w_pisp007u
end type
type dw_1 from datawindow within w_pisp007u
end type
type st_msg from statictext within w_pisp007u
end type
type cb_3 from commandbutton within w_pisp007u
end type
type gb_1 from groupbox within w_pisp007u
end type
type gb_3 from groupbox within w_pisp007u
end type
type gb_4 from groupbox within w_pisp007u
end type
type gb_2 from groupbox within w_pisp007u
end type
type sle_codename from singlelineedit within w_pisp007u
end type
end forward

global type w_pisp007u from window
integer width = 3099
integer height = 2020
boolean titlebar = true
string title = "일일 생산계획 계산"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
sle_codeid sle_codeid
st_2 st_2
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
st_msg st_msg
cb_3 cb_3
gb_1 gb_1
gb_3 gb_3
gb_4 gb_4
gb_2 gb_2
sle_codename sle_codename
end type
global w_pisp007u w_pisp007u

type variables
Boolean		ib_open, ib_save
String		is_codegroup, is_codegroupname
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;is_codegroup		= istr_parms.string_arg[2]
is_codegroupname	= istr_parms.string_arg[3]

Title	= is_codegroupname
st_msg.Text = "'" + is_codegroupname + "'은 새로운 원인 추가만 가능합니다."

dw_1.SetTransObject(SQLPIS)

wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();dw_1.ReSet()
dw_1.Retrieve(is_codegroup, '%')
end subroutine

on w_pisp007u.create
this.sle_codeid=create sle_codeid
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.st_msg=create st_msg
this.cb_3=create cb_3
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_2=create gb_2
this.sle_codename=create sle_codename
this.Control[]={this.sle_codeid,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.st_msg,&
this.cb_3,&
this.gb_1,&
this.gb_3,&
this.gb_4,&
this.gb_2,&
this.sle_codename}
end on

on w_pisp007u.destroy
destroy(this.sle_codeid)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.st_msg)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.sle_codename)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size		= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type sle_codeid from singlelineedit within w_pisp007u
integer x = 357
integer y = 240
integer width = 567
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisp007u
integer x = 55
integer y = 360
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "원인명:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisp007u
integer x = 55
integer y = 252
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "원인코드:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pisp007u
integer x = 2560
integer y = 220
integer width = 411
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조 회(&R)"
end type

event clicked;wf_retrieve()

end event

type cb_2 from commandbutton within w_pisp007u
integer x = 2560
integer y = 320
integer width = 411
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장(&S)"
end type

event clicked;Int		li_count
String	ls_codeid, ls_codename

ls_codeid	= Trim(sle_codeid.Text)
ls_codename	= Trim(sle_codename.Text)

If Len(ls_codeid) > 0 Then
	//
Else
	MessageBox(is_codegroup, "정확한 원인코드를 등록하십시오.", StopSign!)
	Return
End If

If Len(ls_codename) > 0 Then
	//
Else
	MessageBox(is_codegroup, "정확한 원인명을 등록하십시오.", StopSign!)
	Return
End If

Select	Count(CodeID)
Into		:li_count
From		tmstcode
Where		CodeGroup	= :is_codegroup
And		CodeID		= :ls_codeid
Using		SQLPIS;

If li_count > 0 Then
	MessageBox(is_codegroup, "이미 등록되어 있는 원인코드 입니다.", StopSign!)
	Return
End If

Insert Into tmstcode	(CodeGroup,			CodeID,		CodeGroupName,			CodeName,
							CodeRef01,			CodeRef02,	CodeRef03,
							LastEmp,				LastDate)
Values					(:is_codegroup,	:ls_codeid,	:is_codegroupname,	:ls_codename,
							Null,					Null,			Null,
							'Y',					GetDate())
Using	SQLPIS;

If SQLPIS.sqlcode = 0 Then
	MessageBox(is_codegroupname, "원인 정보를 저장하였습니다.", Information!)
	ib_save	= True
	wf_retrieve()
Else
	MessageBox(is_codegroupname, "원인 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If
end event

type dw_1 from datawindow within w_pisp007u
event ue_vscroll pbm_vscroll
integer x = 50
integer y = 632
integer width = 2958
integer height = 1244
string title = "none"
string dataobject = "d_pisp007u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
End If
end event

type st_msg from statictext within w_pisp007u
integer x = 59
integer y = 80
integer width = 2962
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_pisp007u
integer x = 2560
integer y = 420
integer width = 411
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type gb_1 from groupbox within w_pisp007u
integer x = 14
integer width = 3031
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp007u
integer x = 2487
integer y = 160
integer width = 558
integer height = 380
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp007u
integer x = 14
integer y = 560
integer width = 3031
integer height = 1344
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "원인 내역"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp007u
integer x = 14
integer y = 160
integer width = 2464
integer height = 380
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_codename from singlelineedit within w_pisp007u
integer x = 357
integer y = 344
integer width = 2080
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 100
borderstyle borderstyle = stylelowered!
end type

