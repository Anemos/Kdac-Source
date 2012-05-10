$PBExportHeader$w_bpm426i.srw
$PBExportComments$호환품목별 입고수량조회
forward
global type w_bpm426i from w_origin_sheet04
end type
type pb_excel from picturebutton within w_bpm426i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm426i
end type
type dw_1 from datawindow within w_bpm426i
end type
type uo_2 from uo_ccyy_mps within w_bpm426i
end type
type st_4 from statictext within w_bpm426i
end type
type uo_3 from u_bpm_select_arev within w_bpm426i
end type
type st_5 from statictext within w_bpm426i
end type
type uo_from from uo_ccyymm_mps within w_bpm426i
end type
type st_6 from statictext within w_bpm426i
end type
type st_7 from statictext within w_bpm426i
end type
type uo_to from uo_ccyymm_mps within w_bpm426i
end type
type gb_1 from groupbox within w_bpm426i
end type
end forward

global type w_bpm426i from w_origin_sheet04
integer width = 4809
integer height = 3144
string title = "호환품목별 입고수량조회"
event keydown pbm_dwnkey
event ue_postopen ( )
pb_excel pb_excel
uo_1 uo_1
dw_1 dw_1
uo_2 uo_2
st_4 st_4
uo_3 uo_3
st_5 st_5
uo_from uo_from
st_6 st_6
st_7 st_7
uo_to uo_to
gb_1 gb_1
end type
global w_bpm426i w_bpm426i

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

uo_from.uf_reset(integer(mid(f_relativedate(ls_refyear + '0101',-1),1,4)),1)
uo_to.uf_reset(integer(mid(g_s_date,1,4)),integer(mid(f_relativedate(mid(g_s_date,1,6) + '01',-1),5,2)))

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

f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										ls_revno, &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

on w_bpm426i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.dw_1=create dw_1
this.uo_2=create uo_2
this.st_4=create st_4
this.uo_3=create uo_3
this.st_5=create st_5
this.uo_from=create uo_from
this.st_6=create st_6
this.st_7=create st_7
this.uo_to=create uo_to
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.uo_3
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.uo_from
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.uo_to
this.Control[iCurrent+12]=this.gb_1
end on

on w_bpm426i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.uo_2)
destroy(this.st_4)
destroy(this.uo_3)
destroy(this.st_5)
destroy(this.uo_from)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.uo_to)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_year,ls_revno
string ls_from, ls_to

dw_1.reset()
ls_parm  = uo_1.uf_Return()
ls_plant = trim(mid(ls_parm,1,1))
ls_div   = trim(mid(ls_parm,2,1))
ls_pdcd  = trim(mid(ls_parm,3,2)) + '%'

ls_year  = uo_2.uf_return()
ls_revno = uo_3.is_uo_revno
ls_from		=	uo_from.uf_yyyymm() + '01'
ls_to		=	uo_to.uf_yyyymm() + '31'

setpointer(hourglass!)

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_div) = -1 then
	uo_status.st_message.text	= "지역,공장은 필수입력입니다."
	return 0
end if

if dw_1.retrieve(ls_plant,ls_div,ls_pdcd,ls_from,ls_to) > 0 then
	pb_excel.visible = true
	pb_excel.enabled = true
	uo_status.st_message.text	=	"  " + string(dw_1.rowcount()) + " 개의 정보가 " + f_message("I010")
else
	pb_excel.visible = false
	pb_excel.enabled = false
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
end if

return 0




end event

event open;call super::open;// Post Open Event
THIS.PostEvent('ue_postopen')

end event

type uo_status from w_origin_sheet04`uo_status within w_bpm426i
end type

type pb_excel from picturebutton within w_bpm426i
integer x = 2693
integer y = 228
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

event clicked;f_save_to_excel_number(dw_1)
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm426i
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

type dw_1 from datawindow within w_bpm426i
integer x = 32
integer y = 408
integer width = 4571
integer height = 2068
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bpm426i_01"
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

type uo_2 from uo_ccyy_mps within w_bpm426i
integer x = 389
integer y = 56
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

type st_4 from statictext within w_bpm426i
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

type uo_3 from u_bpm_select_arev within w_bpm426i
integer x = 837
integer y = 60
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type st_5 from statictext within w_bpm426i
integer x = 1883
integer y = 60
integer width = 407
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "시작년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_from from uo_ccyymm_mps within w_bpm426i
event destroy ( )
integer x = 2313
integer y = 52
integer taborder = 70
boolean bringtotop = true
end type

on uo_from.destroy
call uo_ccyymm_mps::destroy
end on

type st_6 from statictext within w_bpm426i
integer x = 2903
integer y = 64
integer width = 69
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_bpm426i
integer x = 3045
integer y = 64
integer width = 293
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "완료년월"
boolean focusrectangle = false
end type

type uo_to from uo_ccyymm_mps within w_bpm426i
event destroy ( )
integer x = 3374
integer y = 56
integer taborder = 80
boolean bringtotop = true
end type

on uo_to.destroy
call uo_ccyymm_mps::destroy
end on

type gb_1 from groupbox within w_bpm426i
integer x = 37
integer y = 16
integer width = 4475
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

