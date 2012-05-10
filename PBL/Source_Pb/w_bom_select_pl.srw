$PBExportHeader$w_bom_select_pl.srw
$PBExportComments$PL 지정(BOM018)
forward
global type w_bom_select_pl from window
end type
type dw_update from datawindow within w_bom_select_pl
end type
type st_2 from statictext within w_bom_select_pl
end type
type st_1 from statictext within w_bom_select_pl
end type
type cb_del from commandbutton within w_bom_select_pl
end type
type cb_add from commandbutton within w_bom_select_pl
end type
type cb_close from commandbutton within w_bom_select_pl
end type
type dw_bom018 from datawindow within w_bom_select_pl
end type
type dw_dac003 from datawindow within w_bom_select_pl
end type
end forward

global type w_bom_select_pl from window
integer x = 302
integer y = 500
integer width = 2706
integer height = 1188
boolean titlebar = true
string title = "부서 Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_update dw_update
st_2 st_2
st_1 st_1
cb_del cb_del
cb_add cb_add
cb_close cb_close
dw_bom018 dw_bom018
dw_dac003 dw_dac003
end type
global w_bom_select_pl w_bom_select_pl

type variables

end variables

on w_bom_select_pl.create
this.dw_update=create dw_update
this.st_2=create st_2
this.st_1=create st_1
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_bom018=create dw_bom018
this.dw_dac003=create dw_dac003
this.Control[]={this.dw_update,&
this.st_2,&
this.st_1,&
this.cb_del,&
this.cb_add,&
this.cb_close,&
this.dw_bom018,&
this.dw_dac003}
end on

on w_bom_select_pl.destroy
destroy(this.dw_update)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_bom018)
destroy(this.dw_dac003)
end on

event open;string ls_deptcode

f_sysdate()
if mid(g_s_deptcd,1,1) = 'K' then
	ls_deptcode = mid(g_s_deptcd,1,2) + '%'
else
	ls_deptcode = g_s_deptcd + '%'
end if
if dw_dac003.retrieve(g_s_deptcd)	<	1 then
	close(this)
end if
dw_bom018.retrieve(g_s_empno)

end event

type dw_update from datawindow within w_bom_select_pl
boolean visible = false
integer x = 1097
integer y = 512
integer width = 1097
integer height = 384
integer taborder = 40
boolean enabled = false
string title = "none"
string dataobject = "d_bom_bom018_update"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

type st_2 from statictext within w_bom_select_pl
integer x = 1467
integer y = 16
integer width = 558
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[담당 P/L List]"
boolean focusrectangle = false
end type

type st_1 from statictext within w_bom_select_pl
integer x = 5
integer y = 12
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[팀원 LIST]"
boolean focusrectangle = false
end type

type cb_del from commandbutton within w_bom_select_pl
integer x = 1317
integer y = 512
integer width = 142
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "◀"
end type

event clicked;integer	ln_selected_row
string		ls_pl_empno

ln_selected_row	=	dw_bom018.getselectedrow(0)

if	ln_selected_row	<	1	then
	messagebox("확인","담당 PL 사번을 선택한 후 Click하세요")
	return
end if

ls_pl_empno										=	dw_bom018.object.xplemp[ln_selected_row]
dw_bom018.deleterow(ln_selected_row)

delete	from	pbpdm.bom018
where			xinemp	=	:g_s_empno	and	xplemp	=	:ls_pl_empno
using	sqlca ;
if	sqlca.sqlcode	<>	0	then
	messagebox("확인","담당 PL 삭제중  에러발생. 시스템 개발팀으로 연락바랍니다")
else
	messagebox("확인","담당 PL 삭제 완료")
end if

 








end event

type cb_add from commandbutton within w_bom_select_pl
integer x = 1317
integer y = 384
integer width = 142
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "▶"
end type

event clicked;Setpointer(Hourglass!)

integer	ln_selected_row
string		ls_pl_empno

ln_selected_row	=	dw_dac003.getselectedrow(0)

if	ln_selected_row	<	1	then
	messagebox("확인","해당 팀원 사번을 선택한 후 Click하세요")
	return
end if
if	dw_bom018.rowcount()	>	0	then
	messagebox("확인","이미 담당 PL이 등록되어 있습니다.~r~n담당 PL변경시에는 현재 PL을 삭제 후 입력하십시오")
	return
end if

dw_bom018.insertrow(0)

dw_bom018.object.dac003_penamek_input[1]		=	g_s_kornm
dw_bom018.object.dac003_penamek_pl[1]			=	dw_dac003.object.penamek[ln_selected_row]
dw_bom018.object.xindt[1]							=	g_s_date
ls_pl_empno												=	dw_dac003.object.peempno[ln_selected_row]

insert	into	pbpdm.bom018
	(	xcmcd,	xinemp,	xplemp,	xmacaddr,	xipaddr,	xindt	)
values
	(	'01',	:g_s_empno,	:ls_pl_empno,:g_s_macaddr,:g_s_ipaddr,:g_s_date	)
using	sqlca ;
if	sqlca.sqlcode	<>	0	then
	messagebox("확인","담당 PL 저장중 에러발생. 시스템 개발팀으로 연락바랍니다")
	return
else
	if	f_win_auth_update(ls_pl_empno,'w_bom120i','1')	=	true	then
		messagebox("확인","담당 PL 선택 완료")
	else
		messagebox("확인","담당 PL 저장중 권한에러 발생. 시스템 개발팀으로 연락바랍니다")
		return
	end if
	close(parent)
end if

 








end event

type cb_close from commandbutton within w_bom_select_pl
integer x = 2176
integer y = 964
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;Close(Parent) 
end event

type dw_bom018 from datawindow within w_bom_select_pl
integer x = 1463
integer y = 96
integer width = 1193
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "d_bom_bom018"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
if row <= 0 then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

event constructor;this.settransobject(sqlca) ;
end event

type dw_dac003 from datawindow within w_bom_select_pl
integer y = 96
integer width = 1307
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "d_bom_dac003"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

event clicked;if row <= 0 then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

