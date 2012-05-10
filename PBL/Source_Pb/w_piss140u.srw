$PBExportHeader$w_piss140u.srw
$PBExportComments$짜투리수량입력
forward
global type w_piss140u from window
end type
type st_check from statictext within w_piss140u
end type
type cb_2 from commandbutton within w_piss140u
end type
type cb_1 from commandbutton within w_piss140u
end type
type em_dansuqty from editmask within w_piss140u
end type
type st_10 from statictext within w_piss140u
end type
type st_rackqty from statictext within w_piss140u
end type
type st_modelid from statictext within w_piss140u
end type
type st_itemname from statictext within w_piss140u
end type
type st_itemcode from statictext within w_piss140u
end type
type st_4 from statictext within w_piss140u
end type
type st_3 from statictext within w_piss140u
end type
type st_2 from statictext within w_piss140u
end type
type st_1 from statictext within w_piss140u
end type
type st_kbno from statictext within w_piss140u
end type
type gb_1 from groupbox within w_piss140u
end type
type gb_2 from groupbox within w_piss140u
end type
type gb_3 from groupbox within w_piss140u
end type
type gb_4 from groupbox within w_piss140u
end type
end forward

global type w_piss140u from window
integer width = 1778
integer height = 948
boolean titlebar = true
string title = "짜투리수량입력"
windowtype windowtype = response!
long backcolor = 12632256
event ue_close ( )
st_check st_check
cb_2 cb_2
cb_1 cb_1
em_dansuqty em_dansuqty
st_10 st_10
st_rackqty st_rackqty
st_modelid st_modelid
st_itemname st_itemname
st_itemcode st_itemcode
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_kbno st_kbno
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_piss140u w_piss140u

type variables
string is_change
integer ii_dansuqty, ii_originalqty, ii_checkqty
end variables

event ue_close;string ls_rtn
ls_rtn			= Left(is_change	+ Space(5), 5)	+ &	
					  Left(string(ii_dansuqty)	+ Space(5), 5)
CloseWithReturn(w_piss140u, ls_rtn)
end event

on w_piss140u.create
this.st_check=create st_check
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_dansuqty=create em_dansuqty
this.st_10=create st_10
this.st_rackqty=create st_rackqty
this.st_modelid=create st_modelid
this.st_itemname=create st_itemname
this.st_itemcode=create st_itemcode
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_kbno=create st_kbno
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.st_check,&
this.cb_2,&
this.cb_1,&
this.em_dansuqty,&
this.st_10,&
this.st_rackqty,&
this.st_modelid,&
this.st_itemname,&
this.st_itemcode,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_kbno,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4}
end on

on w_piss140u.destroy
destroy(this.st_check)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_dansuqty)
destroy(this.st_10)
destroy(this.st_rackqty)
destroy(this.st_modelid)
destroy(this.st_itemname)
destroy(this.st_itemcode)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_kbno)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;String 	ls_argument, ls_kbno, ls_move,ls_itemcode,ls_itemname,ls_modelId,ls_areacode
Integer	li_originalqty

ls_argument 		= Message.StringParm
ls_areacode = Trim(Mid(ls_argument, 1, 1))
ls_itemcode = Trim(Mid(ls_argument, 2,12))
ls_modelid  = Trim(Mid(ls_argument, 14,4))
st_rackqty.text	= Trim(Mid(ls_argument, 18, 5))
st_check.text		= Trim(Mid(ls_argument, 23, 5))
st_kbno.text		= Trim(Mid(ls_argument, 28, 11))
em_dansuqty.text  = st_check.text
st_itemcode.text = ls_itemcode
st_modelid.text = ls_modelid
select itemname
  into :ls_itemname
  from tmstitem
  where itemcode = :ls_itemcode
  using sqlpis;
st_itemname.text = ls_itemname
st_modelid.text  = ls_modelid
ii_originalqty		= integer(st_rackqty.text)
ii_checkqty			= integer(st_check.text)	
ii_dansuqty			= integer(em_dansuqty.text)


ls_move			= Left('14'	+ Space(10), 10)	+ &
						Left('5' + Space(10), 10)	+ &
						Left('2181'	+ Space(10), 10)	+ &
						Left('909'	+ Space(10), 10)

//f_win_move(w_ipis_s_0140, ls_move)
end event

type st_check from statictext within w_piss140u
integer x = 891
integer y = 952
integer width = 718
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_piss140u
integer x = 1239
integer y = 640
integer width = 457
integer height = 156
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;is_change = 'NO'
Parent.TriggerEvent("ue_close")
end event

type cb_1 from commandbutton within w_piss140u
integer x = 1239
integer y = 484
integer width = 457
integer height = 156
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
end type

event clicked;is_change = 'YES'
Parent.TriggerEvent("ue_close")
end event

type em_dansuqty from editmask within w_piss140u
integer x = 1230
integer y = 148
integer width = 311
integer height = 136
integer taborder = 10
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0"
end type

event modified;integer li_dansuqty

ii_dansuqty = integer(em_dansuqty.text)

if (ii_originalqty < ii_dansuqty) or (ii_originalqty = ii_dansuqty)then
	Messagebox('짜투리수량', '짜투리 수량은 수용수보다 작아야 합니다.')
elseif ii_checkqty < ii_dansuqty then
	Messagebox('짜투리수량', '현재 입력된 수량은 상차계획 수량볻 큰 값이 입력되었습니다.')	
else
	ii_dansuqty = integer(em_dansuqty.text)
end if
end event

type st_10 from statictext within w_piss140u
integer x = 1559
integer y = 160
integer width = 146
integer height = 120
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "EA"
boolean focusrectangle = false
end type

type st_rackqty from statictext within w_piss140u
integer x = 279
integer y = 728
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_modelid from statictext within w_piss140u
integer x = 279
integer y = 636
integer width = 265
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_itemname from statictext within w_piss140u
integer x = 279
integer y = 544
integer width = 878
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_itemcode from statictext within w_piss140u
integer x = 279
integer y = 452
integer width = 585
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss140u
integer x = 73
integer y = 740
integer width = 215
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "수용수"
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss140u
integer x = 73
integer y = 648
integer width = 215
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "식별ID"
boolean focusrectangle = false
end type

type st_2 from statictext within w_piss140u
integer x = 73
integer y = 556
integer width = 215
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "품  명"
boolean focusrectangle = false
end type

type st_1 from statictext within w_piss140u
integer x = 73
integer y = 464
integer width = 215
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "품  번"
boolean focusrectangle = false
end type

type st_kbno from statictext within w_piss140u
integer x = 69
integer y = 128
integer width = 1070
integer height = 176
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss140u
integer x = 32
integer y = 48
integer width = 1147
integer height = 292
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "간판번호"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_piss140u
integer x = 32
integer y = 384
integer width = 1147
integer height = 460
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "간판정보"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_piss140u
integer x = 1198
integer y = 52
integer width = 535
integer height = 292
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "짜투리수량"
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_piss140u
integer x = 1198
integer y = 384
integer width = 535
integer height = 460
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "버튼정보"
borderstyle borderstyle = stylelowered!
end type

