$PBExportHeader$w_mpm130i.srw
$PBExportComments$Order별 작업정보
forward
global type w_mpm130i from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm130i
end type
type uo_fromdate from u_mpms_date_applydate within w_mpm130i
end type
type uo_todate from u_mpms_date_applydate_1 within w_mpm130i
end type
type st_2 from statictext within w_mpm130i
end type
type dw_mpm130i_01 from u_vi_std_datawindow within w_mpm130i
end type
type rb_ing from radiobutton within w_mpm130i
end type
type rb_end from radiobutton within w_mpm130i
end type
type st_3 from statictext within w_mpm130i
end type
type em_deptcode from editmask within w_mpm130i
end type
type pb_find from picturebutton within w_mpm130i
end type
type pb_down from picturebutton within w_mpm130i
end type
type dw_report from datawindow within w_mpm130i
end type
type gb_1 from groupbox within w_mpm130i
end type
end forward

global type w_mpm130i from w_ipis_sheet01
integer width = 4261
uo_1 uo_1
uo_fromdate uo_fromdate
uo_todate uo_todate
st_2 st_2
dw_mpm130i_01 dw_mpm130i_01
rb_ing rb_ing
rb_end rb_end
st_3 st_3
em_deptcode em_deptcode
pb_find pb_find
pb_down pb_down
dw_report dw_report
gb_1 gb_1
end type
global w_mpm130i w_mpm130i

on w_mpm130i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_2=create st_2
this.dw_mpm130i_01=create dw_mpm130i_01
this.rb_ing=create rb_ing
this.rb_end=create rb_end
this.st_3=create st_3
this.em_deptcode=create em_deptcode
this.pb_find=create pb_find
this.pb_down=create pb_down
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_fromdate
this.Control[iCurrent+3]=this.uo_todate
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_mpm130i_01
this.Control[iCurrent+6]=this.rb_ing
this.Control[iCurrent+7]=this.rb_end
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_deptcode
this.Control[iCurrent+10]=this.pb_find
this.Control[iCurrent+11]=this.pb_down
this.Control[iCurrent+12]=this.dw_report
this.Control[iCurrent+13]=this.gb_1
end on

on w_mpm130i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_2)
destroy(this.dw_mpm130i_01)
destroy(this.rb_ing)
destroy(this.rb_end)
destroy(this.st_3)
destroy(this.em_deptcode)
destroy(this.pb_find)
destroy(this.pb_down)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm130i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm130i_01.Height= newheight - ( dw_mpm130i_01.y + ls_status )

end event

event ue_retrieve;call super::ue_retrieve;string ls_orderno, ls_fromdate, ls_todate, ls_deptcode
long ll_rowcnt

dw_mpm130i_01.reset()
ls_orderno = uo_1.is_uo_orderno
ls_fromdate = uo_fromdate.is_uo_date
ls_todate = uo_todate.is_uo_date
em_deptcode.getdata(ls_deptcode)

if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if

if f_spacechk(ls_deptcode) = -1 then
	ls_deptcode = '%'
else
	ls_deptcode = ls_deptcode + '%'
end if

ll_rowcnt = dw_mpm130i_01.retrieve( ls_fromdate, ls_todate, ls_orderno, ls_deptcode)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event ue_postopen;call super::ue_postopen;
rb_ing.triggerevent('clicked')
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

li_rowcnt = dw_mpm130i_01.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_mpm130i_01.sharedata(dw_report)
l_str_prt.title = "Order별 작업정보"
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

type uo_status from w_ipis_sheet01`uo_status within w_mpm130i
end type

type uo_1 from u_mpms_select_orderno within w_mpm130i
integer x = 1746
integer y = 56
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event constructor;call super::constructor;is_option = '1'
end event

type uo_fromdate from u_mpms_date_applydate within w_mpm130i
integer x = 581
integer y = 72
integer taborder = 10
boolean bringtotop = true
end type

on uo_fromdate.destroy
call u_mpms_date_applydate::destroy
end on

type uo_todate from u_mpms_date_applydate_1 within w_mpm130i
integer x = 1312
integer y = 72
integer taborder = 20
boolean bringtotop = true
end type

on uo_todate.destroy
call u_mpms_date_applydate_1::destroy
end on

type st_2 from statictext within w_mpm130i
integer x = 1248
integer y = 72
integer width = 64
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_mpm130i_01 from u_vi_std_datawindow within w_mpm130i
integer x = 18
integer y = 204
integer width = 3461
integer height = 1680
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_mpm130i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type rb_ing from radiobutton within w_mpm130i
integer x = 73
integer y = 72
integer width = 242
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "진행"
boolean checked = true
end type

event clicked;dw_mpm130i_01.dataobject = 'd_mpm130i_01'
dw_mpm130i_01.settransobject(sqlmpms)
end event

type rb_end from radiobutton within w_mpm130i
integer x = 325
integer y = 72
integer width = 242
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "완료"
end type

event clicked;dw_mpm130i_01.dataobject = 'd_mpm130i_02'
dw_mpm130i_01.settransobject(sqlmpms)
end event

type st_3 from statictext within w_mpm130i
integer x = 2944
integer y = 80
integer width = 302
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "부서코드:"
boolean focusrectangle = false
end type

type em_deptcode from editmask within w_mpm130i
integer x = 3241
integer y = 68
integer width = 334
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXX"
end type

type pb_find from picturebutton within w_mpm130i
integer x = 3593
integer y = 60
integer width = 238
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_rtn

openwithparm(w_mpms_find_dept, ' ')
ls_rtn = message.stringparm
		
em_deptcode.text = ls_rtn

return 0
end event

type pb_down from picturebutton within w_mpm130i
integer x = 3959
integer y = 44
integer width = 155
integer height = 132
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_mpm130i_01)
end event

type dw_report from datawindow within w_mpm130i
boolean visible = false
integer x = 3520
integer y = 196
integer width = 407
integer height = 400
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm130i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm130i
integer x = 18
integer width = 4160
integer height = 188
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

