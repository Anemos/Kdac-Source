$PBExportHeader$w_bpm107i.srw
$PBExportComments$사업계획 BOM 조회
forward
global type w_bpm107i from w_origin_sheet02
end type
type uo_1 from uo_plandiv_pdcd within w_bpm107i
end type
type st_2 from statictext within w_bpm107i
end type
type sle_1 from singlelineedit within w_bpm107i
end type
type dw_retrieve from datawindow within w_bpm107i
end type
type uo_2 from uo_ccyy_mps within w_bpm107i
end type
type st_1 from statictext within w_bpm107i
end type
type ddlb_gubun from dropdownlistbox within w_bpm107i
end type
type dw_print from datawindow within w_bpm107i
end type
type pb_down from picturebutton within w_bpm107i
end type
type dw_down from datawindow within w_bpm107i
end type
type gb_1 from groupbox within w_bpm107i
end type
end forward

global type w_bpm107i from w_origin_sheet02
string title = "BOM 이력 조회 ( 전체 )"
uo_1 uo_1
st_2 st_2
sle_1 sle_1
dw_retrieve dw_retrieve
uo_2 uo_2
st_1 st_1
ddlb_gubun ddlb_gubun
dw_print dw_print
pb_down pb_down
dw_down dw_down
gb_1 gb_1
end type
global w_bpm107i w_bpm107i

on w_bpm107i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_2=create st_2
this.sle_1=create sle_1
this.dw_retrieve=create dw_retrieve
this.uo_2=create uo_2
this.st_1=create st_1
this.ddlb_gubun=create ddlb_gubun
this.dw_print=create dw_print
this.pb_down=create pb_down
this.dw_down=create dw_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.dw_retrieve
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.ddlb_gubun
this.Control[iCurrent+8]=this.dw_print
this.Control[iCurrent+9]=this.pb_down
this.Control[iCurrent+10]=this.dw_down
this.Control[iCurrent+11]=this.gb_1
end on

on w_bpm107i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.dw_retrieve)
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.ddlb_gubun)
destroy(this.dw_print)
destroy(this.pb_down)
destroy(this.dw_down)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;SetPointer(HourGlass!)

string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_year,ls_gubun = 'D'

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
ls_itno  	= trim(sle_1.text) + '%'
ls_year  	= uo_2.uf_return()
if ddlb_gubun.text	=	'수출(E)'	then
	ls_gubun = 'E'
else
	ls_gubun = 'D'
end if

dw_retrieve.reset()
if dw_retrieve.retrieve(ls_gubun,ls_year,ls_plant,ls_div,ls_pdcd,ls_itno) < 1 then
	uo_status.st_message.text = f_message("I020")
//	pb_excel.enabled  = false
//	pb_excel.visible  = false
else
	uo_status.st_message.text = f_message("I010")
//	pb_excel.enabled  = true
//	pb_excel.visible  = true
end if

	


end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_print;call super::ue_print;SetPointer(HourGlass!)

string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_year,ls_gubun = 'D',mod_string
window 	l_to_open
str_easy	l_str_prt

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
ls_itno  	= trim(sle_1.text) + '%'
ls_year  	= uo_2.uf_return()
if ddlb_gubun.text	=	'수출(E)'	then
	ls_gubun = 'E'
else
	ls_gubun = 'D'
end if

if ls_itno = '%' then
	messagebox("확인","출력은 사업계획 매출 대상 품번 하나씩만 가능합니다.")
	return
end if

dw_print.reset()
if dw_print.retrieve(ls_gubun,ls_year,ls_plant,ls_div,ls_pdcd,ls_itno,g_s_date) < 1 then
	uo_status.st_message.text = "출력할 정보가 없습니다"
else
	dw_print.print()
	uo_status.st_message.text = "출력완료"
end if

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
//l_str_prt.transaction  	= sqlca
//l_str_prt.datawindow   	= dw_print
//l_str_prt.title 				= "BOM REPORT 화면"
//l_str_prt.dwsyntax 		= mod_string
//l_str_prt.tag			  	= This.ClassName()
//f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
//Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
//	
//uo_status.st_message.Text = ""	
//return 0
end event

event open;call super::open;i_b_print = true
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

type uo_status from w_origin_sheet02`uo_status within w_bpm107i
integer y = 2468
end type

type uo_1 from uo_plandiv_pdcd within w_bpm107i
integer x = 503
integer y = 44
integer taborder = 80
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type st_2 from statictext within w_bpm107i
integer x = 2976
integer y = 76
integer width = 160
integer height = 68
boolean bringtotop = true
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

type sle_1 from singlelineedit within w_bpm107i
event ue_keydown pbm_keydown
integer x = 3131
integer y = 60
integer width = 494
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type dw_retrieve from datawindow within w_bpm107i
integer x = 23
integer y = 216
integer width = 4581
integer height = 2232
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_bpm013i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca) ;
end event

type uo_2 from uo_ccyy_mps within w_bpm107i
integer x = 64
integer y = 64
integer taborder = 40
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

type st_1 from statictext within w_bpm107i
integer x = 3675
integer y = 80
integer width = 155
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "구분"
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_bpm107i
integer x = 3858
integer y = 64
integer width = 366
integer height = 324
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean sorted = false
string item[] = {"내수(D)","수출(E)"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = '내수(D)'
end event

type dw_print from datawindow within w_bpm107i
boolean visible = false
integer x = 2153
integer y = 584
integer width = 686
integer height = 400
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm013i_01_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca);
end event

type pb_down from picturebutton within w_bpm107i
integer x = 4338
integer y = 44
integer width = 247
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;dw_down.reset()
if dw_retrieve.rowcount() > 0 then
	dw_retrieve.sharedata(dw_down)
else
	return 0
end if

f_Save_to_Excel_number(dw_down)
end event

type dw_down from datawindow within w_bpm107i
boolean visible = false
integer x = 3712
integer y = 220
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm013i_01_down"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_bpm107i
integer x = 23
integer width = 4581
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

