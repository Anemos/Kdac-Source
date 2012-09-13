$PBExportHeader$w_bom110u_res_03.srw
$PBExportComments$품번 찾기(품명으로) Response Window
forward
global type w_bom110u_res_03 from window
end type
type cb_find from commandbutton within w_bom110u_res_03
end type
type sle_1 from singlelineedit within w_bom110u_res_03
end type
type cb_cancel from commandbutton within w_bom110u_res_03
end type
type cb_ok from commandbutton within w_bom110u_res_03
end type
type dw_1 from datawindow within w_bom110u_res_03
end type
type gb_1 from groupbox within w_bom110u_res_03
end type
end forward

global type w_bom110u_res_03 from window
integer x = 201
integer y = 500
integer width = 1947
integer height = 1440
boolean titlebar = true
string title = "품번 찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
cb_find cb_find
sle_1 sle_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
gb_1 gb_1
end type
global w_bom110u_res_03 w_bom110u_res_03

on w_bom110u_res_03.create
this.cb_find=create cb_find
this.sle_1=create sle_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_find,&
this.sle_1,&
this.cb_cancel,&
this.cb_ok,&
this.dw_1,&
this.gb_1}
end on

on w_bom110u_res_03.destroy
destroy(this.cb_find)
destroy(this.sle_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string ls_pdcd, ls_parm,ls_prname

dw_1.settransobject(sqlca)
dw_1.reset()
ls_parm = message.stringparm
ls_pdcd = mid(ls_parm,3,2)

SELECT "PBCOMMON"."DAC002"."COFLNAME"  
   INTO :ls_prname  
   FROM "PBCOMMON"."DAC002"  
   WHERE ( "PBCOMMON"."DAC002"."COMLTD" = :g_s_company ) AND  
         ( "PBCOMMON"."DAC002"."COGUBUN" = 'DAC160' ) AND  
         ( "PBCOMMON"."DAC002"."COCODE" = :ls_pdcd )   
			using sqlca;

sle_1.text = ls_prname

end event

type cb_find from commandbutton within w_bom110u_res_03
integer x = 1554
integer y = 184
integer width = 261
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검 색"
boolean default = true
end type

event clicked;string 	ls_parm, ls_div, ls_plant , ls_pdcd , ls_itno
integer 	ln_row

dw_1.reset()
ls_parm = message.stringparm
ls_plant = mid(ls_parm,1,1)
ls_div = mid(ls_parm,2,1)
ls_pdcd = mid(ls_parm,3,2) + "%"
if f_spacechk(sle_1.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if

ls_itno = "%" + upper(trim(sle_1.text)) + "%"
ln_row = dw_1.retrieve(ls_plant,ls_div,ls_pdcd,ls_itno)
if ln_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type sle_1 from singlelineedit within w_bom110u_res_03
integer x = 87
integer y = 120
integer width = 786
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_bom110u_res_03
integer x = 1527
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
end type

event clicked;string ls_itno
ls_itno = ""
closewithreturn(parent,ls_itno)
end event

type cb_ok from commandbutton within w_bom110u_res_03
integer x = 1202
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;string 	ls_itno
integer 	ln_row

ln_row 	= dw_1.getrow()
ls_itno 	= dw_1.getitemstring(ln_row, "inv101_itno")
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,ls_itno)
end if
end event

type dw_1 from datawindow within w_bom110u_res_03
integer x = 46
integer y = 336
integer width = 1783
integer height = 824
string title = "none"
string dataobject = "d_bom001_finditem"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_itno
this.selectrow(0,false)
this.selectrow(row,true)
ls_itno = dw_1.getitemstring(row,"inv101_itno")
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,ls_itno)
end if



end event

type gb_1 from groupbox within w_bom110u_res_03
integer x = 50
integer y = 32
integer width = 859
integer height = 252
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "검색어( 품명으로 검색 )"
end type

