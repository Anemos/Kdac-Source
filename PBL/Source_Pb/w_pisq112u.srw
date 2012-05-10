$PBExportHeader$w_pisq112u.srw
$PBExportComments$검사성적서 판정의 중복 거래명세표번호 표시(비간판용)
forward
global type w_pisq112u from w_ipis_sheet01
end type
type cb_ok from commandbutton within w_pisq112u
end type
type dw_pisq112u_01 from u_vi_std_datawindow within w_pisq112u
end type
type gb_1 from groupbox within w_pisq112u
end type
end forward

global type w_pisq112u from w_ipis_sheet01
integer width = 2912
integer height = 2176
string title = "거래명세표번호 선택"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
dw_pisq112u_01 dw_pisq112u_01
gb_1 gb_1
end type
global w_pisq112u w_pisq112u

type variables


end variables

on w_pisq112u.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_pisq112u_01=create dw_pisq112u_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_pisq112u_01
this.Control[iCurrent+3]=this.gb_1
end on

on w_pisq112u.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_pisq112u_01)
destroy(this.gb_1)
end on

event resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq030u, FULL)
//
//of_resize()
//
end event

event open;
String	ls_areacode, ls_divisioncode, ls_slno

// 윈도우간의 정보를 스트럭쳐 배열로 받는다
//
istr_parms = message.powerobjectparm

// 레스폰스 윈도우의 좌표를 재설정한다
//
This.x = 1
This.y = 265

// 레스폰스 윈도우의 타이틀을 재설정한다
//
this.title = 'w_pisq112u(거래명세표번호 선택)'

// 트랜잭션을 연결한다
//
dw_pisq112u_01.SetTransObject(SQLPIS)

ls_areacode			= istr_parms.String_arg[1]
ls_divisioncode	= istr_parms.String_arg[2]
ls_slno				= istr_parms.String_arg[3]

// 자료를 조회한다
//
dw_pisq112u_01.Retrieve(ls_areacode, ls_divisioncode, ls_slno)

// 데이타윈도우에 포커스가 있는 행에 반전표시를 나타낸다(1행)
//
f_SetHighlight(dw_pisq112u_01, 1, True)	


// 마이크로 헬프의 내용을 셋트한다
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq112u
integer x = 32
integer y = 2104
integer width = 3602
end type

type cb_ok from commandbutton within w_pisq112u
integer x = 2478
integer y = 1936
integer width = 384
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "선  택"
end type

event clicked;

String	ls_slno

// 결재자 선택행의 사번을 구한다
//
ls_slno = dw_pisq112u_01.GetItemString(dw_pisq112u_01.GetSelectedRow(0), "slno")

istr_parms.String_arg[4] = ls_slno

// 결재자 사번을 리턴한다
//
CloseWithReturn(Parent, istr_parms)
end event

type dw_pisq112u_01 from u_vi_std_datawindow within w_pisq112u
integer x = 32
integer y = 28
integer width = 2825
integer height = 1872
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq112u_01"
end type

event doubleclicked;call super::doubleclicked;
// 처리를 검사기준서 검토처리로 넘겨준다
//
cb_ok.TriggerEvent (Clicked!)
end event

type gb_1 from groupbox within w_pisq112u
integer x = 9
integer width = 2875
integer height = 2072
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

