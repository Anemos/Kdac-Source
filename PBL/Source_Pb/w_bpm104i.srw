$PBExportHeader$w_bpm104i.srw
$PBExportComments$제품별 재료비 조회
forward
global type w_bpm104i from w_origin_sheet04
end type
type pb_excel from picturebutton within w_bpm104i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm104i
end type
type dw_2 from datawindow within w_bpm104i
end type
type st_1 from statictext within w_bpm104i
end type
type sle_1 from singlelineedit within w_bpm104i
end type
type pb_1 from picturebutton within w_bpm104i
end type
type st_2 from statictext within w_bpm104i
end type
type uo_2 from uo_ccyy_mps within w_bpm104i
end type
type st_sort from statictext within w_bpm104i
end type
type cb_sort from commandbutton within w_bpm104i
end type
type gb_2 from groupbox within w_bpm104i
end type
type gb_3 from groupbox within w_bpm104i
end type
end forward

global type w_bpm104i from w_origin_sheet04
integer height = 2728
event keydown pbm_dwnkey
pb_excel pb_excel
uo_1 uo_1
dw_2 dw_2
st_1 st_1
sle_1 sle_1
pb_1 pb_1
st_2 st_2
uo_2 uo_2
st_sort st_sort
cb_sort cb_sort
gb_2 gb_2
gb_3 gb_3
end type
global w_bpm104i w_bpm104i

type variables
datawindowchild i_dwc_nvmo,i_dwc_mcno
datastore ids_data1,ids_data2,ids_data3,ids_data4
string i_s_chkpt,i_s_ajdate,i_s_div,i_s_plant,i_s_pdcd
end variables

event keydown;if key = keyenter! then
	this.TriggerEvent("ue_retrieve")
end if


end event

on w_bpm104i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.dw_2=create dw_2
this.st_1=create st_1
this.sle_1=create sle_1
this.pb_1=create pb_1
this.st_2=create st_2
this.uo_2=create uo_2
this.st_sort=create st_sort
this.cb_sort=create cb_sort
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.st_sort
this.Control[iCurrent+10]=this.cb_sort
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
end on

on w_bpm104i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.st_sort)
destroy(this.cb_sort)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_itno,ls_year

ls_parm  = uo_1.uf_Return()
ls_itno  = trim(sle_1.text)       + '%'
ls_plant = trim(mid(ls_parm,1,1)) + '%'
ls_div   = trim(mid(ls_parm,2,1)) + '%'
ls_pdcd  = trim(mid(ls_parm,3,2)) + '%'
ls_year  = uo_2.uf_return()

f_pism_working_msg(This.title,ls_year + " 년도 제품별 재료비 정보를 조회중입니다. ~r~n잠시만 기다려 주십시오.") 

if dw_2.retrieve(ls_year,ls_plant,ls_div,ls_pdcd,ls_itno) > 0 then
	cb_sort.enabled  = true
	pb_excel.visible = true
	pb_excel.enabled = true
	uo_status.st_message.text	=	"  " + string(dw_2.rowcount()) + " 개의 정보가 " + f_message("I010")
else
	cb_sort.enabled  = false
	pb_excel.visible = false
	pb_excel.enabled = false
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
end if

If IsValid(w_pism_working) Then Close(w_pism_working)




end event

event open;call super::open;pb_excel.visible = false
pb_excel.enabled = false
end event

type uo_status from w_origin_sheet04`uo_status within w_bpm104i
end type

type pb_excel from picturebutton within w_bpm104i
integer x = 4475
integer y = 44
integer width = 155
integer height = 132
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel_number(dw_2)
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm104i
integer x = 475
integer width = 2505
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type dw_2 from datawindow within w_bpm104i
integer x = 32
integer y = 332
integer width = 4571
integer height = 2144
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm104i_01_rev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if row < 1 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)
end event

type st_1 from statictext within w_bpm104i
integer x = 2935
integer y = 84
integer width = 137
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

type sle_1 from singlelineedit within w_bpm104i
event ue_slekeydown pbm_keydown
integer x = 3090
integer y = 72
integer width = 393
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_bpm104i
integer x = 3502
integer y = 60
integer width = 238
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

l_s_parm  = uo_1.uf_Return()
//if trim(mid(l_s_parm,1,4)) = '' then
//	messagebox("확인",'지역,공장,제품군 정보를 입력 후 찾기 버튼을 Click 바랍니다')
//	return
//end if

openwithparm(w_rtn_find_item, g_s_date + l_s_parm)

l_s_parm = message.stringparm
sle_1.text = l_s_parm

end event

type st_2 from statictext within w_bpm104i
integer x = 3749
integer y = 72
integer width = 681
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_2 from uo_ccyy_mps within w_bpm104i
integer x = 50
integer y = 72
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

type st_sort from statictext within w_bpm104i
integer x = 32
integer y = 224
integer width = 3337
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_sort from commandbutton within w_bpm104i
integer x = 3387
integer y = 224
integer width = 201
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort ,dw_2)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

st_sort.text = l_str_rtn.dspsort
dw_2.setsort(l_str_rtn.rtnsort)
dw_2.setredraw(false)
dw_2.sort()
dw_2.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type gb_2 from groupbox within w_bpm104i
integer x = 2917
integer width = 1541
integer height = 192
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_bpm104i
integer x = 27
integer width = 448
integer height = 192
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

