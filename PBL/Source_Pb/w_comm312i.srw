$PBExportHeader$w_comm312i.srw
$PBExportComments$도움말 조회
forward
global type w_comm312i from window
end type
type tab_1 from tab within w_comm312i
end type
type tabpage_1 from userobject within tab_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type mle_1 from multilineedit within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_2 st_2
st_1 st_1
mle_1 mle_1
end type
type tab_1 from tab within w_comm312i
tabpage_1 tabpage_1
end type
type pb_2 from picturebutton within w_comm312i
end type
type pb_confirm from picturebutton within w_comm312i
end type
type gb_1 from groupbox within w_comm312i
end type
end forward

global type w_comm312i from window
integer x = 357
integer y = 268
integer width = 2985
integer height = 2148
boolean titlebar = true
string title = "KDAC 종합정보시스템 도움말"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
tab_1 tab_1
pb_2 pb_2
pb_confirm pb_confirm
gb_1 gb_1
end type
global w_comm312i w_comm312i

type variables
string i_s_winnm
end variables

on w_comm312i.create
this.tab_1=create tab_1
this.pb_2=create pb_2
this.pb_confirm=create pb_confirm
this.gb_1=create gb_1
this.Control[]={this.tab_1,&
this.pb_2,&
this.pb_confirm,&
this.gb_1}
end on

on w_comm312i.destroy
destroy(this.tab_1)
destroy(this.pb_2)
destroy(this.pb_confirm)
destroy(this.gb_1)
end on

event open;string l_s_descd

f_win_center_move(w_comm312i)

if g_s_winid = 'w_menu' then
	tab_1.tabpage_1.mle_1.text = '원하는 업무의 해당기능을 클릭후 조회 하세요'
else
	select "PBCOMMON"."DAC110"."WINNM", "PBCOMMON"."DAC110"."DESCD"
	into   :i_s_winnm, :l_s_descd
	from   "PBCOMMON"."DAC110"
	where  "PBCOMMON"."DAC110"."COMLTD" = :g_s_company and
			 "PBCOMMON"."DAC110"."WINID"  = :g_s_winid   and
			 "PBCOMMON"."DAC110"."TABNO"  = :g_n_tabno   using sqlca ;
	if sqlca.sqlcode <> 0 then
		l_s_descd = ''
		i_s_winnm = ''
	end if
	if f_spacechk(l_s_descd) = -1 then
		l_s_descd = '죄송합니다... 도움말을 준비중입니다.'
	end if
	
	tab_1.tabpage_1.st_2.text  = i_s_winnm
	tab_1.tabpage_1.mle_1.text = l_s_descd
end if
end event

type tab_1 from tab within w_comm312i
integer x = 23
integer y = 32
integer width = 2907
integer height = 1824
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 2871
integer height = 1692
long backcolor = 12632256
string text = "현 화면 사용법"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
mle_1 mle_1
end type

on tabpage_1.create
this.st_2=create st_2
this.st_1=create st_1
this.mle_1=create mle_1
this.Control[]={this.st_2,&
this.st_1,&
this.mle_1}
end on

on tabpage_1.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_1)
end on

type st_2 from statictext within tabpage_1
integer x = 530
integer y = 16
integer width = 1371
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer x = 14
integer y = 16
integer width = 494
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "현화면 기능명 :"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within tabpage_1
integer y = 116
integer width = 2866
integer height = 1588
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 16777215
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_comm312i
integer x = 2583
integer y = 1896
integer width = 302
integer height = 116
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "종료"
vtextalign vtextalign = vcenter!
end type

event clicked;
close(parent)
//closewithreturn(parent, '')
end event

type pb_confirm from picturebutton within w_comm312i
integer x = 2267
integer y = 1896
integer width = 302
integer height = 116
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "인쇄"
vtextalign vtextalign = vcenter!
end type

event clicked;string l_s_prtdata
long   Job

l_s_prtdata = tab_1.tabpage_1.mle_1.text

Job = PrintOpen()

Print(Job, ' ' )
Print(Job, ' ' )
Print(Job, ' ' )
Print(Job, '업무명 : ' + i_s_winnm )
Print(Job, ' ' )
Print(Job, ' ' )
Print(Job, l_s_prtdata)

PrintClose(Job)
end event

type gb_1 from groupbox within w_comm312i
integer x = 2245
integer y = 1872
integer width = 663
integer height = 164
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

