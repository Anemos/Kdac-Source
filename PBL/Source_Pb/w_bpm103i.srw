$PBExportHeader$w_bpm103i.srw
$PBExportComments$품목별 재료비 조회
forward
global type w_bpm103i from w_origin_sheet04
end type
type pb_excel from picturebutton within w_bpm103i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm103i
end type
type st_1 from statictext within w_bpm103i
end type
type sle_1 from singlelineedit within w_bpm103i
end type
type pb_1 from picturebutton within w_bpm103i
end type
type st_2 from statictext within w_bpm103i
end type
type uo_2 from uo_ccyy_mps within w_bpm103i
end type
type tab_1 from tab within w_bpm103i
end type
type tabpage_1 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type st_sort1 from statictext within tabpage_1
end type
type dw_3 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_1 cb_1
st_sort1 st_sort1
dw_3 dw_3
end type
type tabpage_2 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_2
end type
type st_sort2 from statictext within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_2 cb_2
st_sort2 st_sort2
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_3
end type
type st_sort3 from statictext within tabpage_3
end type
type dw_4 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_3 cb_3
st_sort3 st_sort3
dw_4 dw_4
end type
type tabpage_4 from userobject within tab_1
end type
type dw_5 from datawindow within tabpage_4
end type
type cb_4 from commandbutton within tabpage_4
end type
type st_sort4 from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_5 dw_5
cb_4 cb_4
st_sort4 st_sort4
end type
type tab_1 from tab within w_bpm103i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type gb_2 from groupbox within w_bpm103i
end type
type gb_3 from groupbox within w_bpm103i
end type
end forward

global type w_bpm103i from w_origin_sheet04
integer width = 4677
integer height = 2728
event keydown pbm_dwnkey
pb_excel pb_excel
uo_1 uo_1
st_1 st_1
sle_1 sle_1
pb_1 pb_1
st_2 st_2
uo_2 uo_2
tab_1 tab_1
gb_2 gb_2
gb_3 gb_3
end type
global w_bpm103i w_bpm103i

type variables
datawindowchild i_dwc_nvmo,i_dwc_mcno
datastore ids_data1,ids_data2,ids_data3,ids_data4
string i_s_chkpt,i_s_ajdate,i_s_div,i_s_plant,i_s_pdcd
end variables

event keydown;if key = keyenter! then
	this.TriggerEvent("ue_retrieve")
end if


end event

on w_bpm103i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.st_1=create st_1
this.sle_1=create sle_1
this.pb_1=create pb_1
this.st_2=create st_2
this.uo_2=create uo_2
this.tab_1=create tab_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_bpm103i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.tab_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_itno,ls_year,ls_pdnm

ls_parm  	= 	uo_1.uf_Return()
ls_itno  	= 	trim(sle_1.text)       + '%'
ls_plant 	= 	trim(mid(ls_parm,1,1)) + '%'
ls_div   	= 	trim(mid(ls_parm,2,1)) + '%'
ls_pdcd  	= 	trim(mid(ls_parm,3,2))
ls_year  	=	uo_2.uf_return()

select prname into :ls_pdnm from pbcommon.dac007
	where comltd = '01' and prprcd = :ls_pdcd using sqlca ;
if sqlca.sqlcode <> 0 then
	ls_pdnm = '%'
end if
ls_pdnm = trim(mid(ls_pdnm,1,30)) + '%'
setpointer(hourglass!)
//f_pism_working_msg(This.title,ls_year + " 년도 품목별 재료비 정보를 조회중입니다. ~r~n잠시만 기다려 주십시오.") 
if tab_1.selectedtab = 2 then
	if tab_1.tabpage_2.dw_2.retrieve(ls_plant,ls_div,ls_pdnm,ls_itno) > 0 then
		tab_1.tabpage_2.cb_2.enabled = true 
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	=	"  " + string(tab_1.tabpage_2.dw_2.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_2.cb_2.enabled = false		
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if
elseif tab_1.selectedtab = 1 then
	if tab_1.tabpage_1.dw_3.retrieve(ls_plant,ls_div,ls_pdcd + '%',ls_itno) > 0 then
		tab_1.tabpage_1.cb_1.enabled = true
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	= "  " + string(tab_1.tabpage_1.dw_3.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_1.cb_1.enabled = false
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if
elseif tab_1.selectedtab = 3 then	
	if tab_1.tabpage_3.dw_4.retrieve(ls_plant,ls_div,ls_pdcd + '%',ls_itno) > 0 then
		tab_1.tabpage_3.cb_3.enabled = true
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	=	"  " +  string(tab_1.tabpage_3.dw_4.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_3.cb_3.enabled = false
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if
elseif tab_1.selectedtab = 4 then	
	if tab_1.tabpage_4.dw_5.retrieve(ls_plant,ls_div,ls_pdnm,ls_itno) > 0 then
		tab_1.tabpage_4.cb_4.enabled = true
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	=	"  " +  string(tab_1.tabpage_4.dw_5.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_4.cb_4.enabled = false
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if	
end if
//If IsValid(w_pism_working) Then Close(w_pism_working)




end event

event open;call super::open;pb_excel.visible = false
pb_excel.enabled = false
end event

type uo_status from w_origin_sheet04`uo_status within w_bpm103i
end type

type pb_excel from picturebutton within w_bpm103i
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

event clicked;if tab_1.selectedtab = 1 then
	f_save_to_excel_number(tab_1.tabpage_1.dw_3)
elseif tab_1.selectedtab = 2 then
	f_save_to_excel_number(tab_1.tabpage_2.dw_2)	
elseif tab_1.selectedtab = 3 then
	f_save_to_excel_number(tab_1.tabpage_3.dw_4)
elseif tab_1.selectedtab = 4 then
	f_save_to_excel_number(tab_1.tabpage_4.dw_5)
end if
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm103i
integer x = 475
integer width = 2505
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type st_1 from statictext within w_bpm103i
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

type sle_1 from singlelineedit within w_bpm103i
event ue_slekeydown pbm_keydown
integer x = 3090
integer y = 72
integer width = 393
integer height = 80
integer taborder = 10
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

type pb_1 from picturebutton within w_bpm103i
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

type st_2 from statictext within w_bpm103i
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

type uo_2 from uo_ccyy_mps within w_bpm103i
integer x = 50
integer y = 72
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

type tab_1 from tab within w_bpm103i
integer x = 46
integer y = 208
integer width = 4576
integer height = 2280
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;if newindex = 1 then
	tab_1.tabpage_1.tabtextcolor = rgb(255,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_3.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_4.tabtextcolor = rgb(0,0,0)  
elseif newindex = 2 then
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(255,0,0)	
	tab_1.tabpage_3.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_4.tabtextcolor = rgb(0,0,0)  
elseif newindex = 3 then
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)	
	tab_1.tabpage_3.tabtextcolor = rgb(255,0,0)	
	tab_1.tabpage_4.tabtextcolor = rgb(0,0,0)  
elseif newindex = 4 then
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)	
	tab_1.tabpage_3.tabtextcolor = rgb(0,0,0)	
	tab_1.tabpage_4.tabtextcolor = rgb(255,0,0)  
end if

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4539
integer height = 2152
long backcolor = 12632256
string text = " 기획팀 "
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_1 cb_1
st_sort1 st_sort1
dw_3 dw_3
end type

on tabpage_1.create
this.cb_1=create cb_1
this.st_sort1=create st_sort1
this.dw_3=create dw_3
this.Control[]={this.cb_1,&
this.st_sort1,&
this.dw_3}
end on

on tabpage_1.destroy
destroy(this.cb_1)
destroy(this.st_sort1)
destroy(this.dw_3)
end on

type cb_1 from commandbutton within tabpage_1
integer x = 3365
integer y = 32
integer width = 201
integer height = 84
integer taborder = 30
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

openwithparm(w_gms_setsort ,tab_1.tabpage_1.dw_3)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_1.st_sort1.text = l_str_rtn.dspsort
tab_1.tabpage_1.dw_3.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_1.dw_3.setredraw(false)
tab_1.tabpage_1.dw_3.sort()
tab_1.tabpage_1.dw_3.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort1 from statictext within tabpage_1
integer x = 9
integer y = 32
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

type dw_3 from datawindow within tabpage_1
integer x = 5
integer y = 140
integer width = 4521
integer height = 1992
integer taborder = 100
string title = "none"
string dataobject = "d_bpm103i_02"
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

event retrieveend;//setpointer(hourglass!)
//
//string 	ls_return
//dec{1} 	ln_outqty
//dec		ln_outamt
//integer	i,ln_pos
//
//for	i	=	1	to	rowcount
//	ls_return	=	f_inv402_outqty(	trim(this.object.wplant[i]),&
//												trim(this.object.wdvsn[i]),&
//												trim(this.object.witno[i]),&										
//												'200610'	)
//	ln_pos		=	pos(ls_return,',')
//	if ln_pos	=	0	then
//		ln_outqty	=	0
//		ln_outamt	=	0
//	else
//		ln_outqty	=	dec(mid(ls_return,1,ln_pos - 1))
//		ln_outamt	=	dec(mid(ls_return,ln_pos + 1,len(ls_return)))
//	end if
//	this.object.wcostyr[i]		=	ln_outqty
//	this.object.wcostyrbom[i]	=	ln_outamt
//next
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4539
integer height = 2152
long backcolor = 12632256
string text = "외주기획"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_2 cb_2
st_sort2 st_sort2
dw_2 dw_2
end type

on tabpage_2.create
this.cb_2=create cb_2
this.st_sort2=create st_sort2
this.dw_2=create dw_2
this.Control[]={this.cb_2,&
this.st_sort2,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.st_sort2)
destroy(this.dw_2)
end on

type cb_2 from commandbutton within tabpage_2
integer x = 3374
integer y = 48
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

openwithparm(w_gms_setsort ,tab_1.tabpage_2.dw_2)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_2.st_sort2.text = l_str_rtn.dspsort
tab_1.tabpage_2.dw_2.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_2.dw_2.setredraw(false)
tab_1.tabpage_2.dw_2.sort()
tab_1.tabpage_2.dw_2.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort2 from statictext within tabpage_2
integer x = 18
integer y = 48
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

type dw_2 from datawindow within tabpage_2
integer x = 14
integer y = 164
integer width = 4517
integer height = 1980
integer taborder = 30
string dataobject = "d_bpm103i_01"
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

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4539
integer height = 2152
long backcolor = 12632256
string text = "외자구매"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_3 cb_3
st_sort3 st_sort3
dw_4 dw_4
end type

on tabpage_3.create
this.cb_3=create cb_3
this.st_sort3=create st_sort3
this.dw_4=create dw_4
this.Control[]={this.cb_3,&
this.st_sort3,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.cb_3)
destroy(this.st_sort3)
destroy(this.dw_4)
end on

type cb_3 from commandbutton within tabpage_3
integer x = 3369
integer y = 28
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

openwithparm(w_gms_setsort ,tab_1.tabpage_3.dw_4)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_3.st_sort3.text = l_str_rtn.dspsort
tab_1.tabpage_3.dw_4.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_3.dw_4.setredraw(false)
tab_1.tabpage_3.dw_4.sort()
tab_1.tabpage_3.dw_4.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort3 from statictext within tabpage_3
integer x = 14
integer y = 28
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

type dw_4 from datawindow within tabpage_3
integer y = 128
integer width = 4535
integer height = 2008
integer taborder = 40
string dataobject = "d_bpm103i_03"
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

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4539
integer height = 2152
long backcolor = 12632256
string text = "외주기획(유상)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_5 dw_5
cb_4 cb_4
st_sort4 st_sort4
end type

on tabpage_4.create
this.dw_5=create dw_5
this.cb_4=create cb_4
this.st_sort4=create st_sort4
this.Control[]={this.dw_5,&
this.cb_4,&
this.st_sort4}
end on

on tabpage_4.destroy
destroy(this.dw_5)
destroy(this.cb_4)
destroy(this.st_sort4)
end on

type dw_5 from datawindow within tabpage_4
integer x = 5
integer y = 112
integer width = 4521
integer height = 2004
integer taborder = 30
string dataobject = "d_bpm103i_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type cb_4 from commandbutton within tabpage_4
integer x = 3365
integer y = 20
integer width = 201
integer height = 84
integer taborder = 50
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

openwithparm(w_gms_setsort ,tab_1.tabpage_4.dw_5)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_4.st_sort4.text = l_str_rtn.dspsort
tab_1.tabpage_4.dw_5.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_4.dw_5.setredraw(false)
tab_1.tabpage_4.dw_5.sort()
tab_1.tabpage_4.dw_5.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort4 from statictext within tabpage_4
integer x = 9
integer y = 20
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

type gb_2 from groupbox within w_bpm103i
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

type gb_3 from groupbox within w_bpm103i
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

