$PBExportHeader$w_mpm131i.srw
$PBExportComments$Order별 작업집계표
forward
global type w_mpm131i from w_ipis_sheet01
end type
type rb_ing from radiobutton within w_mpm131i
end type
type rb_end from radiobutton within w_mpm131i
end type
type dw_mpm131i_01 from u_vi_std_datawindow within w_mpm131i
end type
type pb_down from picturebutton within w_mpm131i
end type
type uo_from from u_mpms_date_applydate within w_mpm131i
end type
type st_1 from statictext within w_mpm131i
end type
type uo_to from u_mpms_date_applydate_1 within w_mpm131i
end type
type dw_report from datawindow within w_mpm131i
end type
type gb_1 from groupbox within w_mpm131i
end type
end forward

global type w_mpm131i from w_ipis_sheet01
rb_ing rb_ing
rb_end rb_end
dw_mpm131i_01 dw_mpm131i_01
pb_down pb_down
uo_from uo_from
st_1 st_1
uo_to uo_to
dw_report dw_report
gb_1 gb_1
end type
global w_mpm131i w_mpm131i

on w_mpm131i.create
int iCurrent
call super::create
this.rb_ing=create rb_ing
this.rb_end=create rb_end
this.dw_mpm131i_01=create dw_mpm131i_01
this.pb_down=create pb_down
this.uo_from=create uo_from
this.st_1=create st_1
this.uo_to=create uo_to
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_ing
this.Control[iCurrent+2]=this.rb_end
this.Control[iCurrent+3]=this.dw_mpm131i_01
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.uo_from
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.uo_to
this.Control[iCurrent+8]=this.dw_report
this.Control[iCurrent+9]=this.gb_1
end on

on w_mpm131i.destroy
call super::destroy
destroy(this.rb_ing)
destroy(this.rb_end)
destroy(this.dw_mpm131i_01)
destroy(this.pb_down)
destroy(this.uo_from)
destroy(this.st_1)
destroy(this.uo_to)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm131i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm131i_01.Height= newheight - ( dw_mpm131i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;
rb_ing.triggerevent('clicked')
end event

event ue_retrieve;call super::ue_retrieve;string ls_option, ls_fromdt, ls_todt

dw_mpm131i_01.reset()

ls_fromdt = uo_from.is_uo_date
ls_todt = uo_to.is_uo_date

if dw_mpm131i_01.retrieve( ls_fromdt, ls_todt ) < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_plant,ls_dvsn,ls_vndr,ls_vndm
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

li_rowcnt = dw_mpm131i_01.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_mpm131i_01.sharedata(dw_report)
l_str_prt.title = "Order별 작업집계표"
if rb_ing.checked then
	mod_string =  "t_kijun.text = '( 진행 )'" + &
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"		
else
	mod_string =  "t_kijun.text = '( 완료 )'" + & 
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
end if

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

type uo_status from w_ipis_sheet01`uo_status within w_mpm131i
end type

type rb_ing from radiobutton within w_mpm131i
integer x = 73
integer y = 72
integer width = 375
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업진행"
end type

event clicked;dw_mpm131i_01.dataobject = 'd_mpm131i_01'
dw_mpm131i_01.settransobject(sqlmpms)
end event

type rb_end from radiobutton within w_mpm131i
integer x = 457
integer y = 68
integer width = 393
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업완료"
end type

event clicked;dw_mpm131i_01.dataobject = 'd_mpm131i_02'
dw_mpm131i_01.settransobject(sqlmpms)
end event

type dw_mpm131i_01 from u_vi_std_datawindow within w_mpm131i
integer x = 18
integer y = 192
integer width = 3200
integer height = 1688
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm131i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type pb_down from picturebutton within w_mpm131i
integer x = 2610
integer y = 40
integer width = 155
integer height = 120
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_mpm131i_01)
end event

type uo_from from u_mpms_date_applydate within w_mpm131i
event destroy ( )
integer x = 928
integer y = 64
integer taborder = 31
boolean bringtotop = true
end type

on uo_from.destroy
call u_mpms_date_applydate::destroy
end on

type st_1 from statictext within w_mpm131i
integer x = 1609
integer y = 72
integer width = 64
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type uo_to from u_mpms_date_applydate_1 within w_mpm131i
event destroy ( )
integer x = 1650
integer y = 64
integer taborder = 41
boolean bringtotop = true
end type

on uo_to.destroy
call u_mpms_date_applydate_1::destroy
end on

type dw_report from datawindow within w_mpm131i
boolean visible = false
integer x = 2871
integer y = 24
integer width = 338
integer height = 188
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm131i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm131i
integer x = 18
integer width = 2793
integer height = 168
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

