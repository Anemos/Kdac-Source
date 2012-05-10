$PBExportHeader$w_pisq117p.srw
$PBExportComments$검사성적서 출력
forward
global type w_pisq117p from w_ipis_sheet01
end type
type dw_pisq117p_01 from datawindow within w_pisq117p
end type
type gb_1 from groupbox within w_pisq117p
end type
type gb_3 from groupbox within w_pisq117p
end type
type cb_print from commandbutton within w_pisq117p
end type
type cb_exit from commandbutton within w_pisq117p
end type
end forward

global type w_pisq117p from w_ipis_sheet01
integer width = 4699
integer height = 2804
string title = "검사기준서 출력"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq117p_01 dw_pisq117p_01
gb_1 gb_1
gb_3 gb_3
cb_print cb_print
cb_exit cb_exit
end type
global w_pisq117p w_pisq117p

type variables

String	is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_deliveryno, is_revno

end variables

on w_pisq117p.create
int iCurrent
call super::create
this.dw_pisq117p_01=create dw_pisq117p_01
this.gb_1=create gb_1
this.gb_3=create gb_3
this.cb_print=create cb_print
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq117p_01
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_exit
end on

on w_pisq117p.destroy
call super::destroy
destroy(this.dw_pisq117p_01)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.cb_print)
destroy(this.cb_exit)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq040p_head, FULL)
//
//of_resize()
//
end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// 툴바의 아이콘을 재설정한다
//
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

// 윈도우간의 정보를 스트럭쳐 배열로 받는다
//
istr_parms = message.powerobjectparm

is_areacode			= istr_parms.String_arg[1]
is_divisioncode	= istr_parms.String_arg[2]
is_suppliercode	= istr_parms.String_arg[3]
is_deliveryno		= istr_parms.String_arg[4]
is_itemcode			= istr_parms.String_arg[5]
is_revno          = istr_parms.String_arg[6]

// 레스폰스 윈도우의 좌표를 재설정한다
//
This.x = 1
This.y = 265

// 레스폰스 윈도우의 타이틀을 재설정한다
//
this.title = 'w_pisq117p(검사성적서 출력)'

// 트랜잭션을 연결한다
//
dw_pisq117p_01.SetTransObject(SQLPIS)

// 마이크로 헬프의 내용을 셋트한다
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

event ue_postopen;
// 자료를 출력한다
//
dw_pisq117p_01.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_deliveryno, is_itemcode, is_revno)


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq117p
integer x = 41
integer y = 2208
integer width = 3602
end type

type dw_pisq117p_01 from datawindow within w_pisq117p
integer x = 37
integer y = 236
integer width = 4581
integer height = 2328
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq117p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq117p
integer x = 14
integer y = 204
integer width = 4631
integer height = 2388
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisq117p
integer x = 14
integer width = 4631
integer height = 200
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
end type

type cb_print from commandbutton within w_pisq117p
integer x = 3785
integer y = 56
integer width = 389
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출  력"
end type

event clicked;
dw_pisq117p_01.Print()
//open(w_res_test)
end event

type cb_exit from commandbutton within w_pisq117p
integer x = 4215
integer y = 56
integer width = 389
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종  료"
end type

event clicked;

Close(parent)
end event

