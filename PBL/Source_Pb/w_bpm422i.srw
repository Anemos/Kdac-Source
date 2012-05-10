$PBExportHeader$w_bpm422i.srw
$PBExportComments$사업계획 제품별재료비
forward
global type w_bpm422i from w_ipis_sheet01
end type
type dw_bpm422i_01 from datawindow within w_bpm422i
end type
type tab_work from tab within w_bpm422i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_bpm422i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_bpm422i_02 from datawindow within w_bpm422i
end type
type dw_down from datawindow within w_bpm422i
end type
type pb_excel from picturebutton within w_bpm422i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm422i
end type
type st_1 from statictext within w_bpm422i
end type
type sle_1 from singlelineedit within w_bpm422i
end type
type pb_1 from picturebutton within w_bpm422i
end type
type st_2 from statictext within w_bpm422i
end type
type uo_2 from uo_ccyy_mps within w_bpm422i
end type
type st_sort from statictext within w_bpm422i
end type
type cb_sort from commandbutton within w_bpm422i
end type
type st_4 from statictext within w_bpm422i
end type
type uo_3 from u_bpm_select_arev within w_bpm422i
end type
type st_3 from statictext within w_bpm422i
end type
type ddlb_divcode from dropdownlistbox within w_bpm422i
end type
type cb_1 from commandbutton within w_bpm422i
end type
type dw_bpm422i_03 from datawindow within w_bpm422i
end type
type gb_1 from groupbox within w_bpm422i
end type
end forward

global type w_bpm422i from w_ipis_sheet01
integer width = 5038
integer height = 3728
dw_bpm422i_01 dw_bpm422i_01
tab_work tab_work
dw_bpm422i_02 dw_bpm422i_02
dw_down dw_down
pb_excel pb_excel
uo_1 uo_1
st_1 st_1
sle_1 sle_1
pb_1 pb_1
st_2 st_2
uo_2 uo_2
st_sort st_sort
cb_sort cb_sort
st_4 st_4
uo_3 uo_3
st_3 st_3
ddlb_divcode ddlb_divcode
cb_1 cb_1
dw_bpm422i_03 dw_bpm422i_03
gb_1 gb_1
end type
global w_bpm422i w_bpm422i

type variables

end variables

on w_bpm422i.create
int iCurrent
call super::create
this.dw_bpm422i_01=create dw_bpm422i_01
this.tab_work=create tab_work
this.dw_bpm422i_02=create dw_bpm422i_02
this.dw_down=create dw_down
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.st_1=create st_1
this.sle_1=create sle_1
this.pb_1=create pb_1
this.st_2=create st_2
this.uo_2=create uo_2
this.st_sort=create st_sort
this.cb_sort=create cb_sort
this.st_4=create st_4
this.uo_3=create uo_3
this.st_3=create st_3
this.ddlb_divcode=create ddlb_divcode
this.cb_1=create cb_1
this.dw_bpm422i_03=create dw_bpm422i_03
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bpm422i_01
this.Control[iCurrent+2]=this.tab_work
this.Control[iCurrent+3]=this.dw_bpm422i_02
this.Control[iCurrent+4]=this.dw_down
this.Control[iCurrent+5]=this.pb_excel
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.sle_1
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.uo_2
this.Control[iCurrent+12]=this.st_sort
this.Control[iCurrent+13]=this.cb_sort
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.uo_3
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.ddlb_divcode
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.dw_bpm422i_03
this.Control[iCurrent+20]=this.gb_1
end on

on w_bpm422i.destroy
call super::destroy
destroy(this.dw_bpm422i_01)
destroy(this.tab_work)
destroy(this.dw_bpm422i_02)
destroy(this.dw_down)
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.st_sort)
destroy(this.cb_sort)
destroy(this.st_4)
destroy(this.uo_3)
destroy(this.st_3)
destroy(this.ddlb_divcode)
destroy(this.cb_1)
destroy(this.dw_bpm422i_03)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

tab_work.Width = newwidth - ( tab_work.x + 20 )
dw_bpm422i_01.Width = newwidth	- (ls_gap * 5)
dw_bpm422i_01.Height= newheight - (dw_bpm422i_01.y + ls_status)

dw_bpm422i_02.x = dw_bpm422i_01.x
dw_bpm422i_02.y = dw_bpm422i_01.y
dw_bpm422i_02.Width = dw_bpm422i_01.Width
dw_bpm422i_02.Height= dw_bpm422i_01.Height
end event

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_itno,ls_year,ls_revno,ls_divcode,ls_expcode

ls_parm  = uo_1.uf_Return()
ls_itno  = trim(sle_1.text)       + '%'
ls_plant = trim(mid(ls_parm,1,1)) + '%'
ls_div   = trim(mid(ls_parm,2,1)) + '%'
ls_pdcd  = trim(mid(ls_parm,3,2)) + '%'
ls_year  = uo_2.uf_return()

ls_revno = uo_3.is_uo_revno

if ddlb_divcode.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

f_pism_working_msg(This.title,ls_year + " 년도 제품별 재료비 정보를 조회중입니다. ~r~n잠시만 기다려 주십시오.") 

choose case tab_work.selectedtab
	case 1
		dw_bpm422i_01.reset()
		if dw_bpm422i_01.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_itno) > 0 then
			cb_sort.enabled  = true
			pb_excel.visible = true
			pb_excel.enabled = true
			uo_status.st_message.text	=	"  " + string(dw_bpm422i_01.rowcount()) + " 개의 정보가 " + f_message("I010")
		else
			cb_sort.enabled  = false
			pb_excel.visible = false
			pb_excel.enabled = false
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
		end if
	case 2
		dw_bpm422i_02.reset()
		if dw_bpm422i_02.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_itno) > 0 then
			cb_sort.enabled  = true
			pb_excel.visible = true
			pb_excel.enabled = true
			uo_status.st_message.text	=	"  " + string(dw_bpm422i_02.rowcount()) + " 개의 정보가 " + f_message("I010")
		else
			cb_sort.enabled  = false
			pb_excel.visible = false
			pb_excel.enabled = false
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
		end if
end choose
If IsValid(w_pism_working) Then Close(w_pism_working)

return 0


end event

event ue_postopen;call super::ue_postopen;pb_excel.visible = false
pb_excel.enabled = false

string ls_refyear, ls_message, ls_revno, ls_chkrevno

dw_bpm422i_01.settransobject(sqlca)
dw_bpm422i_02.settransobject(sqlca)

ls_message = right(message.stringparm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

SELECT REVNO INTO :ls_chkrevno
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND XYEAR = :ls_refyear AND REVNO = :ls_revno
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if f_spacechk(ls_chkrevno) = -1 then
	SELECT XYEAR, REVNO INTO :ls_refyear,:ls_revno
	FROM PBBPM.BPM519
	WHERE COMLTD = '01'
	ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	
	uo_2.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
	ls_revno = '%'
else
	uo_2.uf_reset(integer(ls_refyear))
end if

ddlb_divcode.text = '배분후'

f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										ls_revno, &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm422i
integer x = 18
integer y = 2464
integer height = 88
end type

type dw_bpm422i_01 from datawindow within w_bpm422i
integer x = 23
integer y = 644
integer width = 1883
integer height = 1792
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_bpm422i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca) ;
end event

type tab_work from tab within w_bpm422i
event create ( )
event destroy ( )
integer x = 23
integer y = 508
integer width = 4283
integer height = 124
integer taborder = 70
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
end type

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;Choose Case newindex 
	Case 1
		dw_bpm422i_01.Visible = True 
		dw_bpm422i_02.Visible = False 
	Case 2
		dw_bpm422i_01.Visible = False 
		dw_bpm422i_02.Visible = True 
End Choose 
end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 4247
integer height = -4
long backcolor = 12632256
string text = "가공관리비적용 재료비"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 4247
integer height = -4
long backcolor = 12632256
string text = "완성품단가적용(CHECK)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_bpm422i_02 from datawindow within w_bpm422i
integer x = 1943
integer y = 644
integer width = 1719
integer height = 1792
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_bpm422i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_down from datawindow within w_bpm422i
boolean visible = false
integer x = 3712
integer y = 220
integer width = 686
integer height = 400
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm421i_01_down"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_bpm422i
integer x = 2624
integer y = 216
integer width = 155
integer height = 132
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;choose case tab_work.selectedtab
	case 1
		f_save_to_excel_number(dw_bpm422i_01)
	case 2
		f_save_to_excel_number(dw_bpm422i_02)
end choose

return 0
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm422i
event destroy ( )
integer x = 18
integer y = 176
integer height = 220
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type st_1 from statictext within w_bpm422i
integer x = 2642
integer y = 64
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

type sle_1 from singlelineedit within w_bpm422i
event ue_slekeydown pbm_keydown
integer x = 2798
integer y = 52
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

type pb_1 from picturebutton within w_bpm422i
integer x = 3209
integer y = 40
integer width = 238
integer height = 108
integer taborder = 10
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

type st_2 from statictext within w_bpm422i
integer x = 3456
integer y = 52
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

type uo_2 from uo_ccyy_mps within w_bpm422i
event destroy ( )
integer x = 357
integer y = 56
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										'%', &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

type st_sort from statictext within w_bpm422i
integer x = 32
integer y = 400
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

type cb_sort from commandbutton within w_bpm422i
integer x = 3387
integer y = 400
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

choose case tab_work.selectedtab
	case 1
		openwithparm(w_gms_setsort ,dw_bpm422i_01)
		l_str_rtn = message.powerobjectparm
		if f_spacechk(l_str_rtn.rtnsort) = -1 then 
			uo_status.st_message.text = "취소되었습니다."
			return 0
		else
			uo_status.st_message.text = "정열중입니다..."
		end if
		st_sort.text = l_str_rtn.dspsort
		dw_bpm422i_01.setsort(l_str_rtn.rtnsort)
		dw_bpm422i_01.setredraw(false)
		dw_bpm422i_01.sort()
		dw_bpm422i_01.setredraw(true)
	case 2
		openwithparm(w_gms_setsort ,dw_bpm422i_02)
		l_str_rtn = message.powerobjectparm
		if f_spacechk(l_str_rtn.rtnsort) = -1 then 
			uo_status.st_message.text = "취소되었습니다."
			return 0
		else
			uo_status.st_message.text = "정열중입니다..."
		end if
		st_sort.text = l_str_rtn.dspsort
		dw_bpm422i_02.setsort(l_str_rtn.rtnsort)
		dw_bpm422i_02.setredraw(false)
		dw_bpm422i_02.sort()
		dw_bpm422i_02.setredraw(true)
end choose

uo_status.st_message.text = "정열되었습니다."
end event

type st_4 from statictext within w_bpm422i
integer x = 64
integer y = 68
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
boolean focusrectangle = false
end type

type uo_3 from u_bpm_select_arev within w_bpm422i
event destroy ( )
integer x = 805
integer y = 60
integer height = 88
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type st_3 from statictext within w_bpm422i
integer x = 1774
integer y = 68
integer width = 329
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "배부기준:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_divcode from dropdownlistbox within w_bpm422i
integer x = 2107
integer y = 52
integer width = 439
integer height = 324
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string item[] = {"배분전","배분후"}
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_bpm422i
integer x = 3429
integer y = 224
integer width = 818
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "제품별재료비(0A/AX)비교"
end type

event clicked;dw_bpm422i_03.reset()

if ddlb_divcode.text = '배분전' then
	dw_bpm422i_03.dataobject = 'd_bpm422i_02_diff_before'
else
	dw_bpm422i_03.dataobject = 'd_bpm422i_02_diff_after'
end if
dw_bpm422i_03.settransobject(sqlca)

if dw_bpm422i_03.retrieve() > 0 then
	f_save_to_excel_number(dw_bpm422i_03)
end if

return 0
end event

type dw_bpm422i_03 from datawindow within w_bpm422i
boolean visible = false
integer x = 3771
integer y = 220
integer width = 311
integer height = 120
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_bpm422i_02_diff_after"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_bpm422i
integer x = 37
integer y = 16
integer width = 4210
integer height = 160
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

