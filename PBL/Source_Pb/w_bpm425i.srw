$PBExportHeader$w_bpm425i.srw
$PBExportComments$품목별재료비 단가추이리스트
forward
global type w_bpm425i from w_origin_sheet04
end type
type pb_excel from picturebutton within w_bpm425i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm425i
end type
type dw_2 from datawindow within w_bpm425i
end type
type uo_2 from uo_ccyy_mps within w_bpm425i
end type
type st_sort from statictext within w_bpm425i
end type
type cb_sort from commandbutton within w_bpm425i
end type
type st_4 from statictext within w_bpm425i
end type
type uo_3 from u_bpm_select_arev within w_bpm425i
end type
type st_3 from statictext within w_bpm425i
end type
type ddlb_divcode from dropdownlistbox within w_bpm425i
end type
type st_1 from statictext within w_bpm425i
end type
type sle_1 from singlelineedit within w_bpm425i
end type
type pb_1 from picturebutton within w_bpm425i
end type
type st_2 from statictext within w_bpm425i
end type
type st_8 from statictext within w_bpm425i
end type
type st_9 from statictext within w_bpm425i
end type
type st_10 from statictext within w_bpm425i
end type
type gb_1 from groupbox within w_bpm425i
end type
end forward

global type w_bpm425i from w_origin_sheet04
integer width = 4736
integer height = 2936
string title = "품목별재료비 단가추이"
event keydown pbm_dwnkey
event ue_postopen ( )
pb_excel pb_excel
uo_1 uo_1
dw_2 dw_2
uo_2 uo_2
st_sort st_sort
cb_sort cb_sort
st_4 st_4
uo_3 uo_3
st_3 st_3
ddlb_divcode ddlb_divcode
st_1 st_1
sle_1 sle_1
pb_1 pb_1
st_2 st_2
st_8 st_8
st_9 st_9
st_10 st_10
gb_1 gb_1
end type
global w_bpm425i w_bpm425i

type variables
datawindowchild i_dwc_nvmo,i_dwc_mcno
datastore ids_data1,ids_data2,ids_data3,ids_data4
string i_s_chkpt,i_s_ajdate,i_s_div,i_s_plant,i_s_pdcd
end variables

event keydown;if key = keyenter! then
	this.TriggerEvent("ue_retrieve")
end if


end event

event ue_postopen();pb_excel.visible = false
pb_excel.enabled = false

string ls_refyear, ls_message, ls_revno, ls_chkrevno

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

on w_bpm425i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.dw_2=create dw_2
this.uo_2=create uo_2
this.st_sort=create st_sort
this.cb_sort=create cb_sort
this.st_4=create st_4
this.uo_3=create uo_3
this.st_3=create st_3
this.ddlb_divcode=create ddlb_divcode
this.st_1=create st_1
this.sle_1=create sle_1
this.pb_1=create pb_1
this.st_2=create st_2
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.st_sort
this.Control[iCurrent+6]=this.cb_sort
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.uo_3
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.ddlb_divcode
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.sle_1
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.st_9
this.Control[iCurrent+17]=this.st_10
this.Control[iCurrent+18]=this.gb_1
end on

on w_bpm425i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.uo_2)
destroy(this.st_sort)
destroy(this.cb_sort)
destroy(this.st_4)
destroy(this.uo_3)
destroy(this.st_3)
destroy(this.ddlb_divcode)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_year,ls_revno,ls_divcode,ls_expcode,ls_itno

dw_2.reset()
ls_parm  = uo_1.uf_Return()
ls_plant = trim(mid(ls_parm,1,1)) + '%'
ls_div   = trim(mid(ls_parm,2,1)) + '%'
ls_pdcd  = trim(mid(ls_parm,3,2)) + '%'
ls_itno  = 	trim(sle_1.text)       + '%'
ls_year  = uo_2.uf_return()
ls_revno = uo_3.is_uo_revno

if ddlb_divcode.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

setpointer(hourglass!)
f_pism_working_msg(This.title,ls_year + " 년도 품목별 재료비 단가추이 정보를 조회중입니다. ~r~n잠시만 기다려 주십시오.") 

if dw_2.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_itno) > 0 then
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

event open;call super::open;// Post Open Event
THIS.PostEvent('ue_postopen')

end event

type uo_status from w_origin_sheet04`uo_status within w_bpm425i
end type

type pb_excel from picturebutton within w_bpm425i
integer x = 4078
integer y = 216
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

type uo_1 from uo_plandiv_pdcd_all within w_bpm425i
integer x = 18
integer y = 184
integer width = 2587
integer height = 220
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type dw_2 from datawindow within w_bpm425i
integer x = 32
integer y = 528
integer width = 4571
integer height = 1948
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bpm425i_01"
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

type uo_2 from uo_ccyy_mps within w_bpm425i
integer x = 389
integer y = 56
boolean bringtotop = true
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

type st_sort from statictext within w_bpm425i
integer x = 32
integer y = 424
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

type cb_sort from commandbutton within w_bpm425i
integer x = 3387
integer y = 424
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

type st_4 from statictext within w_bpm425i
integer x = 96
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
string text = "사업년도"
boolean focusrectangle = false
end type

type uo_3 from u_bpm_select_arev within w_bpm425i
integer x = 837
integer y = 60
integer height = 88
integer taborder = 40
boolean bringtotop = true
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type st_3 from statictext within w_bpm425i
integer x = 1806
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

type ddlb_divcode from dropdownlistbox within w_bpm425i
integer x = 2139
integer y = 52
integer width = 439
integer height = 324
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
string item[] = {"배분전","배분후"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_bpm425i
integer x = 2656
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

type sle_1 from singlelineedit within w_bpm425i
event ue_slekeydown pbm_keydown
integer x = 2811
integer y = 52
integer width = 393
integer height = 80
integer taborder = 70
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

type pb_1 from picturebutton within w_bpm425i
integer x = 3223
integer y = 40
integer width = 238
integer height = 108
integer taborder = 50
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

type st_2 from statictext within w_bpm425i
integer x = 3470
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

type st_8 from statictext within w_bpm425i
integer x = 2697
integer y = 204
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "1. BOM단위 * 자재변환계수 = 재고단위"
boolean focusrectangle = false
end type

type st_9 from statictext within w_bpm425i
integer x = 2697
integer y = 272
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "2. 재고단위 * 구매변환계수 = 구매단위"
boolean focusrectangle = false
end type

type st_10 from statictext within w_bpm425i
integer x = 2697
integer y = 340
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "3. BOM단위 * 통합변환계수 = 구매단위"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bpm425i
integer x = 37
integer y = 16
integer width = 4201
integer height = 160
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

