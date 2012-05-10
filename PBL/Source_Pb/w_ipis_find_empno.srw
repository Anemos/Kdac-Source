$PBExportHeader$w_ipis_find_empno.srw
$PBExportComments$이름찾기
forward
global type w_ipis_find_empno from window
end type
type cb_2 from commandbutton within w_ipis_find_empno
end type
type cb_1 from commandbutton within w_ipis_find_empno
end type
type cb_find from commandbutton within w_ipis_find_empno
end type
type sle_name from singlelineedit within w_ipis_find_empno
end type
type dw_1 from datawindow within w_ipis_find_empno
end type
type gb_1 from groupbox within w_ipis_find_empno
end type
end forward

global type w_ipis_find_empno from window
integer x = 599
integer y = 900
integer width = 2117
integer height = 1468
boolean titlebar = true
string title = "이름찾기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_2 cb_2
cb_1 cb_1
cb_find cb_find
sle_name sle_name
dw_1 dw_1
gb_1 gb_1
end type
global w_ipis_find_empno w_ipis_find_empno

on w_ipis_find_empno.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_find=create cb_find
this.sle_name=create sle_name
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_find,&
this.sle_name,&
this.dw_1,&
this.gb_1}
end on

on w_ipis_find_empno.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_find)
destroy(this.sle_name)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(Sqlpis)
dw_1.reset()
end event

type cb_2 from commandbutton within w_ipis_find_empno
integer x = 1797
integer y = 1216
integer width = 288
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "취 소"
end type

event clicked;String	ls_empno

ls_empno = ""
closewithreturn(parent,ls_empno)
end event

type cb_1 from commandbutton within w_ipis_find_empno
integer x = 1481
integer y = 1216
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "확 인"
end type

event clicked;String		ls_return_code
Integer 	ls_row

ls_row = dw_1.getrow()

ls_return_code = dw_1.object.tmstemp_empno[ls_row] + string(dw_1.object.tmstemp_empname[ls_row],"@@@@@@@@@@") 
						
if 	f_spacechk(ls_return_code) = -1 then
	messagebox("확인","코드를 선택하세요")
	return
else
	closewithreturn(parent,ls_return_code)
end if
end event

type cb_find from commandbutton within w_ipis_find_empno
integer x = 1819
integer y = 148
integer width = 261
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "검 색"
boolean default = true
end type

event clicked;String 	ls_parm, ls_rbdvsn , ls_rbvend, ls_find_word
Integer 	ln_row

ls_parm	=	message.stringparm
if 	f_spacechk(sle_name.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if

dw_1.reset()

ls_find_word		=	"%" + upper(trim(sle_name.text)) + "%"
if 	dw_1.retrieve(ls_find_word) < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type sle_name from singlelineedit within w_ipis_find_empno
integer x = 50
integer y = 112
integer width = 645
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type dw_1 from datawindow within w_ipis_find_empno
integer y = 272
integer width = 2071
integer height = 916
string dataobject = "d_pisc_select_empno"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

event doubleclicked;String	ls_return_code

ls_return_code = dw_1.object.peempno[row] + string(dw_1.object.penamek[row],"@@@@@@@@@@") 
						
if 	f_spacechk(ls_return_code) = -1 then
	messagebox("확인","코드를 선택하세요")
	return
else
	closewithreturn(parent,ls_return_code)
end if
end event

type gb_1 from groupbox within w_ipis_find_empno
integer x = 9
integer y = 12
integer width = 722
integer height = 252
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "검색어"
end type

