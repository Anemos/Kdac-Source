$PBExportHeader$w_reject_res.srw
$PBExportComments$품번 검색 Response Window(MRP용)
forward
global type w_reject_res from window
end type
type mle_1 from multilineedit within w_reject_res
end type
type st_1 from statictext within w_reject_res
end type
type st_msg from statictext within w_reject_res
end type
type cb_cancel from commandbutton within w_reject_res
end type
type cb_ok from commandbutton within w_reject_res
end type
type gb_2 from groupbox within w_reject_res
end type
end forward

global type w_reject_res from window
integer width = 1696
integer height = 1128
boolean titlebar = true
string title = "반려사유"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "C:\KDAC\kdac.ico"
event ue_opne_after ( )
mle_1 mle_1
st_1 st_1
st_msg st_msg
cb_cancel cb_cancel
cb_ok cb_ok
gb_2 gb_2
end type
global w_reject_res w_reject_res

type variables
String is_xplant, is_div, is_cls[], is_itno

// DataWindow Sort용~
String  is_PreColNm
Boolean ib_Sort_Desc

datawindowchild idwc_mlan


end variables

on w_reject_res.create
this.mle_1=create mle_1
this.st_1=create st_1
this.st_msg=create st_msg
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_2=create gb_2
this.Control[]={this.mle_1,&
this.st_1,&
this.st_msg,&
this.cb_cancel,&
this.cb_ok,&
this.gb_2}
end on

on w_reject_res.destroy
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.st_msg)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_2)
end on

event open;String ls_tvsrno

ls_tvsrno = Message.StringParm	

mle_1.setfocus( )

mle_1.text = "사급업체 : " + ls_tvsrno + &
             " 반려 사유" 
end event

event activate;/////////////////////////////////////
//
//배경색(Column):
//
//필수:         하늘색(15780518)
//필수(X):      흰색(1090519039)
//Edit_Disable: 회색(12632256)
//확정:         연두색(12639424)
/////////////////////////////////////


f_center_window(This)
end event

type mle_1 from multilineedit within w_reject_res
integer x = 18
integer y = 144
integer width = 1646
integer height = 760
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
alignment alignment = Left!
textcase textcase = upper!
integer tabstop[] = {0}
borderstyle borderstyle = StyleLowered!
boolean hideselection = false
end type

type st_1 from statictext within w_reject_res
integer x = 27
integer y = 52
integer width = 1623
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "분할공제관련 반려사유를 기입후 확인을 클릭하세요."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_msg from statictext within w_reject_res
boolean visible = false
integer x = 389
integer y = 1168
integer width = 1253
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean enabled = false
string text = "조건에 맞는 품번이 없습니다."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_reject_res
integer x = 1307
integer y = 912
integer width = 270
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "취소"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "")
end event

type cb_ok from commandbutton within w_reject_res
integer x = 965
integer y = 912
integer width = 270
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "확인"
end type

event clicked;String ls_body

ls_body = mle_1.text

If f_spacechk( ls_body ) = -1 then
	MessageBox("확인", "반려 사유를 적어주세요!", Exclamation!)
	Return
End if

CloseWithReturn(parent, ls_body)

end event

type gb_2 from groupbox within w_reject_res
integer x = 14
integer width = 1650
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

