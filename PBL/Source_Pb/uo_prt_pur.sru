$PBExportHeader$uo_prt_pur.sru
$PBExportComments$발행(전체발행, 재발행, 기간)
forward
global type uo_prt_pur from userobject
end type
type st_2 from statictext within uo_prt_pur
end type
type em_from from editmask within uo_prt_pur
end type
type em_to from editmask within uo_prt_pur
end type
type st_1 from statictext within uo_prt_pur
end type
type rb_2 from radiobutton within uo_prt_pur
end type
type rb_1 from radiobutton within uo_prt_pur
end type
end forward

global type uo_prt_pur from userobject
integer width = 1358
integer height = 200
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
em_from em_from
em_to em_to
st_1 st_1
rb_2 rb_2
rb_1 rb_1
end type
global uo_prt_pur uo_prt_pur

forward prototypes
public function string uf_get_prt ()
public subroutine uf_setfocus ()
public function string uf_get_date (string ag_gubun)
end prototypes

public function string uf_get_prt ();/////////////////////////
// 전체발행	: 1
// 재발행   : 2
//////////////////////////////

IF rb_1.Checked = True Then
	Return "1"
ElseIF rb_2.Checked = True Then
	Return "2"
End IF
end function

public subroutine uf_setfocus ();em_from.SetFocus()
em_from.SelectText(1,len(em_from.Text))
end subroutine

public function string uf_get_date (string ag_gubun);/////////////////////////////////////////
//			기간 
//       from : "1"
//       to   : "2"
////////////////////////////////////////

String ls_date
IF ag_gubun = "1" Then
	em_from.GetData(ls_date)	
	Return ls_date
Else
	em_to.GetData(ls_date)	
	Return ls_date
End IF
end function

on uo_prt_pur.create
this.st_2=create st_2
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.Control[]={this.st_2,&
this.em_from,&
this.em_to,&
this.st_1,&
this.rb_2,&
this.rb_1}
end on

on uo_prt_pur.destroy
destroy(this.st_2)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
end on

type st_2 from statictext within uo_prt_pur
integer x = 946
integer y = 112
integer width = 46
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "-"
boolean focusrectangle = false
end type

type em_from from editmask within uo_prt_pur
integer x = 590
integer y = 88
integer width = 352
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX/XX/XX"
boolean autoskip = true
end type

type em_to from editmask within uo_prt_pur
integer x = 987
integer y = 92
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX/XX/XX"
end type

type st_1 from statictext within uo_prt_pur
integer x = 462
integer y = 108
integer width = 137
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "기간"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within uo_prt_pur
integer x = 9
integer y = 104
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "재발행"
borderstyle borderstyle = stylelowered!
end type

event clicked;//Parent.Post Dynamic Event ue_onoff("2")
end event

type rb_1 from radiobutton within uo_prt_pur
integer x = 9
integer y = 12
integer width = 590
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "미발행분 전체발행"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Parent.Post Dynamic Event ue_onoff("1")
end event

