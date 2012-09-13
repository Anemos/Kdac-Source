$PBExportHeader$uo_confirm_pur.sru
$PBExportComments$확정
forward
global type uo_confirm_pur from userobject
end type
type rb_2 from radiobutton within uo_confirm_pur
end type
type rb_1 from radiobutton within uo_confirm_pur
end type
end forward

global type uo_confirm_pur from userobject
integer width = 462
integer height = 72
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
rb_2 rb_2
rb_1 rb_1
end type
global uo_confirm_pur uo_confirm_pur

forward prototypes
public function string uf_get_confirm ()
public subroutine uf_set_confirm (string ag_gubun)
end prototypes

public function string uf_get_confirm ();////////////////////////////////////////////
//			확정			
//			전체 : '1'
//       개별 : '2'
////////////////////////////////////////////
IF rb_1.Checked = True Then
	Return "1"
ElseIF rb_2.Checked = True Then
	Return "2"
End IF
end function

public subroutine uf_set_confirm (string ag_gubun);///////////////////////////
//전체,개별 변경
//
//    전체 = '1'
//    개별 = '2'
///////////////////////////

IF ag_gubun = '1' Then	
	rb_1.Checked = True
Else
	rb_2.Checked = True
End IF
end subroutine

on uo_confirm_pur.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.Control[]={this.rb_2,&
this.rb_1}
end on

on uo_confirm_pur.destroy
destroy(this.rb_2)
destroy(this.rb_1)
end on

type rb_2 from radiobutton within uo_confirm_pur
integer x = 238
integer width = 219
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "개별"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Window ls_sheet

ls_sheet = w_frame.GetActiveSheet()

ls_sheet.Post Dynamic Event ue_clicked("P")


end event

type rb_1 from radiobutton within uo_confirm_pur
integer width = 238
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "전체"
borderstyle borderstyle = stylelowered!
end type

event clicked;Window ls_sheet

ls_sheet = w_frame.GetActiveSheet()

ls_sheet.Post Dynamic Event ue_clicked("A")

end event

