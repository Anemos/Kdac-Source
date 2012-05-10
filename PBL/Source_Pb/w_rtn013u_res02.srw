$PBExportHeader$w_rtn013u_res02.srw
$PBExportComments$품번별 주,부 라인 선택[결재]
forward
global type w_rtn013u_res02 from window
end type
type uo_1 from uo_plandiv_bom within w_rtn013u_res02
end type
type cb_3 from commandbutton within w_rtn013u_res02
end type
type st_1 from statictext within w_rtn013u_res02
end type
type sle_1 from singlelineedit within w_rtn013u_res02
end type
type cb_1 from commandbutton within w_rtn013u_res02
end type
type dw_1 from datawindow within w_rtn013u_res02
end type
type sle_itno from singlelineedit within w_rtn013u_res02
end type
end forward

global type w_rtn013u_res02 from window
integer x = 901
integer y = 500
integer width = 1522
integer height = 1476
boolean titlebar = true
string title = "주 Line 선택"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
uo_1 uo_1
cb_3 cb_3
st_1 st_1
sle_1 sle_1
cb_1 cb_1
dw_1 dw_1
sle_itno sle_itno
end type
global w_rtn013u_res02 w_rtn013u_res02

type variables
string i_s_oldline1 , i_s_oldline2 , i_s_newline1 , i_s_newline2 , i_s_parm
datawindowchild child_div
end variables

on w_rtn013u_res02.create
this.uo_1=create uo_1
this.cb_3=create cb_3
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.sle_itno=create sle_itno
this.Control[]={this.uo_1,&
this.cb_3,&
this.st_1,&
this.sle_1,&
this.cb_1,&
this.dw_1,&
this.sle_itno}
end on

on w_rtn013u_res02.destroy
destroy(this.uo_1)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.sle_itno)
end on

event open;string l_s_plant,l_s_div, l_s_pitno
int    i, l_n_rows

i_s_oldline1 = '' 
i_s_oldline2 = ''
i_s_parm = message.stringparm
l_s_plant     = mid(i_s_parm,1,1)
l_s_div       = mid(i_s_parm,2,1)
l_s_pitno     = mid(i_s_parm,3,12)
uo_1.dw_1.SetItem(1,'xplant', l_s_plant )
uo_1.dw_1.SetItem(1,'div', l_s_div )
sle_itno.text = mid(i_s_parm,3,12)
dw_1.settransobject(sqlca)
if f_spacechk(l_s_plant) <> -1 and f_spacechk(l_s_div) <> -1 and f_spacechk(l_s_pitno) <> -1 then
	l_n_rows = dw_1.retrieve('01',l_s_plant,l_s_div,l_s_pitno)
	for i = 1 to l_n_rows 
		if dw_1.object.rcgrde[i] = 'A' then
			dw_1.selectrow(i,true)
			i_s_oldline1 = string(dw_1.object.rcline1[i],"@@@@@@@")
			i_s_oldline2 = dw_1.object.rcline2[i]
			exit
		end if
	next
end if


end event

type uo_1 from uo_plandiv_bom within w_rtn013u_res02
integer y = 4
integer taborder = 20
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type cb_3 from commandbutton within w_rtn013u_res02
integer x = 1253
integer y = 124
integer width = 229
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검 색"
end type

event clicked;string l_s_parm, l_s_plant,l_s_div , l_s_pdcd , l_s_itno , l_s_date
integer l_n_row,i

dw_1.reset()

l_s_parm  = uo_1.uf_return()
l_s_plant = mid(l_s_parm,1,1)
l_s_div   = mid(l_s_parm,2,1)
l_s_itno  = trim(sle_itno.text) 

dw_1.settransobject(sqlca)
if f_spacechk(l_s_plant) <> -1 and f_spacechk(l_s_div) <> -1 and f_spacechk(l_s_itno) <> -1 then
	l_n_row = dw_1.retrieve('01',l_s_plant,l_s_div,l_s_itno)
	for i = 1 to l_n_row 
		if dw_1.object.rcgrde[i] = 'A' then
			dw_1.selectrow(i,true)
			i_s_oldline1 = string(dw_1.object.rcline1[i],"@@@@@@@")
			i_s_oldline2 = dw_1.object.rcline2[i]
			exit
		end if
	next
else
	messagebox("확인","지역,공장,품번정보를 확인 후 검색하세요")
   return
end if

end event

type st_1 from statictext within w_rtn013u_res02
integer y = 144
integer width = 137
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rtn013u_res02
integer x = 27
integer y = 1152
integer width = 1449
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "주 Line 을 선택 후 확인 버튼을 누르세요"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_rtn013u_res02
integer x = 1184
integer y = 1256
integer width = 288
integer height = 112
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
boolean default = true
end type

event clicked;int i,a_chk
string l_s_plant,l_s_dvsn,l_s_itno,l_s_rcline1,l_s_rcline2,l_s_parm, ls_message,ls_flag, ls_chtime

dw_1.accepttext()

//for i = 1 to dw_1.rowcount()
//	if dw_1.object.rcgrde[i] = 'A' then
//		i_s_newline1 = string(dw_1.object.rcline1[i],"@@@@@")
//		i_s_newline2 = dw_1.object.rcline2[i]
//		a_chk = 1
//		exit
//	end if
//next

i = dw_1.getselectedrow(0)

if i < 1 then
	messagebox("확인","주 라인은 반드시 선택해야 합니다")
	return 0
end if

if trim(i_s_oldline1) = trim(i_s_newline1) and i_s_oldline2 = i_s_newline2 then
	l_s_parm = '1'
	closewithreturn(parent,l_s_parm)
end if
l_s_plant = dw_1.object.rcplant[i]
l_s_dvsn  = dw_1.object.rcdvsn[i]
l_s_itno  = trim(dw_1.object.rcitno[i])
l_s_rcline1 = string(dw_1.object.rcline1[i],"@@@@@@@")
l_s_rcline2 = dw_1.object.rcline2[i]

ls_chtime = f_get_systemdate(sqlca)

SQLCA.AUTOCOMMIT = FALSE

ls_flag = 'R'

update pbrtn.rtn013
set rcgrde = 'A',
	 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = :ls_flag,
	 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
	 rcplemp = '', rcplchk = 'N', rcpltime = '',
	 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and rcitno = :l_s_itno and
      rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2
using sqlca;
		
if sqlca.sqlnrows < 1 then
	ls_message = "공정별 세부내역정보 대체라인적용시에 오류가 발생했습니다."
	goto Rollback_
else
	ls_message = "정상적으로 처리되었습니다."
end if

if f_spacechk(i_s_oldline1) <> -1 and f_spacechk(i_s_oldline2) <> -1 then
	update pbrtn.rtn013
	set rcgrde = 'B',
		 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = :ls_flag,
		 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
		 rcplemp = '', rcplchk = 'N', rcpltime = '',
		 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
	where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and rcitno = :l_s_itno and
		  rcline1 = :i_s_oldline1 and rcline2 = :i_s_oldline2
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "공정별 세부내역정보 구 대체라인적용시에 오류가 발생했습니다."
		goto Rollback_
	else
		ls_message = "정상적으로 처리되었습니다."
	end if
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
Messagebox("확인",ls_message)
l_s_parm = '1'
closewithreturn(parent,l_s_parm)
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
Messagebox("확인",ls_message)
return -1
end event

type dw_1 from datawindow within w_rtn013u_res02
integer x = 9
integer y = 228
integer width = 1467
integer height = 908
string dataobject = "d_rtn01_dw_jubuline_select"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer i
string l_s_div,l_s_itno

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

//if dwo.name = 'rcgrde' then
//	if dwo.Primary[row] = 0 then
//		dwo.Primary[row] = 1
//	else
//		dwo.Primary[row] = 0
//	end if	
//end if
end event

type sle_itno from singlelineedit within w_rtn013u_res02
integer x = 160
integer y = 128
integer width = 517
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "          "
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

