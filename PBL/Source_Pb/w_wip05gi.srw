$PBExportHeader$w_wip05gi.srw
$PBExportComments$기준금액이상클레임업체조회
forward
global type w_wip05gi from w_origin_sheet04
end type
type st_1 from statictext within w_wip05gi
end type
type st_2 from statictext within w_wip05gi
end type
type em_refcost from editmask within w_wip05gi
end type
type dw_wip05gi_01 from datawindow within w_wip05gi
end type
type pb_down from picturebutton within w_wip05gi
end type
type dw_report from datawindow within w_wip05gi
end type
type uo_from from uo_yymm_boongi within w_wip05gi
end type
type gb_1 from groupbox within w_wip05gi
end type
end forward

global type w_wip05gi from w_origin_sheet04
st_1 st_1
st_2 st_2
em_refcost em_refcost
dw_wip05gi_01 dw_wip05gi_01
pb_down pb_down
dw_report dw_report
uo_from uo_from
gb_1 gb_1
end type
global w_wip05gi w_wip05gi

on w_wip05gi.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.em_refcost=create em_refcost
this.dw_wip05gi_01=create dw_wip05gi_01
this.pb_down=create pb_down
this.dw_report=create dw_report
this.uo_from=create uo_from
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_refcost
this.Control[iCurrent+4]=this.dw_wip05gi_01
this.Control[iCurrent+5]=this.pb_down
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.uo_from
this.Control[iCurrent+8]=this.gb_1
end on

on w_wip05gi.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_refcost)
destroy(this.dw_wip05gi_01)
destroy(this.pb_down)
destroy(this.dw_report)
destroy(this.uo_from)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_fromdt, ls_refcost
int    li_rowcnt
dec{0} ld_refcost

dw_wip05gi_01.reset()

ls_fromdt      = string(uo_from.uf_yyyymm())
em_refcost.getdata(ld_refcost)
messagebox("chk",string(ld_refcost))
li_rowcnt = dw_wip05gi_01.retrieve( '01', mid(ls_fromdt,1,4), mid(ls_fromdt,5,2), ld_refcost )
end event

event open;call super::open;dw_wip05gi_01.settransobject(sqlca)
em_refcost.text = '100000'

i_b_retrieve = true
i_b_print    = true
wf_icon_onoff(i_b_retrieve, i_b_print,      i_b_first,   i_b_prev,   i_b_next,  & 
				  i_b_last,     i_b_dretrieve,  i_b_dprint,  i_b_dchar)
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_plant,ls_dvsn,ls_vndr,ls_vndm
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

li_rowcnt = dw_wip05gi_01.rowcount()
dw_report.dataobject = 'd_wip05gi_02'

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_wip05gi_01.sharedata(dw_report)	
mod_string = "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
l_str_prt.title = "기준금액 업체별 CLAIM 현황"		

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip05gi
end type

type st_1 from statictext within w_wip05gi
integer x = 119
integer y = 72
integer width = 366
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_wip05gi
integer x = 1093
integer y = 72
integer width = 494
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준금액(원):"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_refcost from editmask within w_wip05gi
integer x = 1591
integer y = 52
integer width = 649
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type dw_wip05gi_01 from datawindow within w_wip05gi
integer x = 27
integer y = 192
integer width = 4571
integer height = 2280
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip05gi_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_wip05gi
integer x = 2496
integer y = 32
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip05gi_01.rowcount() < 1 then
	uo_status.st_message.text = "저장할 자료가 없습니다."
else
	f_save_to_excel(dw_wip05gi_01)
end if
end event

type dw_report from datawindow within w_wip05gi
boolean visible = false
integer x = 2857
integer y = 24
integer width = 686
integer height = 144
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_from from uo_yymm_boongi within w_wip05gi
event destroy ( )
integer x = 485
integer y = 56
integer taborder = 40
boolean bringtotop = true
end type

on uo_from.destroy
call uo_yymm_boongi::destroy
end on

type gb_1 from groupbox within w_wip05gi
integer x = 27
integer y = 4
integer width = 2373
integer height = 176
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

