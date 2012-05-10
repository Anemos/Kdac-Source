$PBExportHeader$w_bpm404c.srw
$PBExportComments$BOM미등록품체크(사업계획BOM생성후)
forward
global type w_bpm404c from w_ipis_sheet01
end type
type uo_year from uo_ccyy_mps within w_bpm404c
end type
type dw_bpm404c_01 from u_vi_std_datawindow within w_bpm404c
end type
type st_1 from statictext within w_bpm404c
end type
type pb_down from picturebutton within w_bpm404c
end type
type uo_2 from u_bpm_select_arev within w_bpm404c
end type
type st_2 from statictext within w_bpm404c
end type
type ddlb_gubun from dropdownlistbox within w_bpm404c
end type
type cb_stop from commandbutton within w_bpm404c
end type
type cb_go from commandbutton within w_bpm404c
end type
type gb_1 from groupbox within w_bpm404c
end type
type gb_2 from groupbox within w_bpm404c
end type
end forward

global type w_bpm404c from w_ipis_sheet01
integer width = 4251
integer height = 2552
uo_year uo_year
dw_bpm404c_01 dw_bpm404c_01
st_1 st_1
pb_down pb_down
uo_2 uo_2
st_2 st_2
ddlb_gubun ddlb_gubun
cb_stop cb_stop
cb_go cb_go
gb_1 gb_1
gb_2 gb_2
end type
global w_bpm404c w_bpm404c

on w_bpm404c.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.dw_bpm404c_01=create dw_bpm404c_01
this.st_1=create st_1
this.pb_down=create pb_down
this.uo_2=create uo_2
this.st_2=create st_2
this.ddlb_gubun=create ddlb_gubun
this.cb_stop=create cb_stop
this.cb_go=create cb_go
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.dw_bpm404c_01
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_gubun
this.Control[iCurrent+8]=this.cb_stop
this.Control[iCurrent+9]=this.cb_go
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
end on

on w_bpm404c.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.dw_bpm404c_01)
destroy(this.st_1)
destroy(this.pb_down)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.ddlb_gubun)
destroy(this.cb_stop)
destroy(this.cb_go)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_bpm404c_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bpm404c_01.Height= newheight - ( dw_bpm404c_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_bpm404c_01.settransobject(sqlca)

string ls_refyear,ls_taskstatus,ls_revno,ls_message

ls_message = Right(Message.StringParm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(False,  False,  False,  False,  False,      & 
			     False,  False,    False)
if f_bpm_check_ingflag(ls_refyear,ls_revno,'w_bpm404c') = 'C' then
	cb_stop.enabled = False
	cb_go.enabled = False
else
	SELECT TASKSTATUS INTO :ls_taskstatus 
	FROM PBBPM.BPM519
	WHERE COMLTD = :g_s_company AND XYEAR = :ls_refyear AND 
			REVNO = :ls_revno AND WINDOWID = 'w_bpm404c'
	using sqlca;
	
	if ls_taskstatus <> 'C' then
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(True,  False,  False,  False,  False,      & 
			     False,  False,    False)
	end if
	if f_bpm_check_jobemp(ls_refyear,ls_revno,'w_bpm404c',g_s_empno) <> -1 then
		if ls_taskstatus = 'C' then
			cb_stop.enabled = False
			cb_go.enabled = True
		else
			cb_stop.enabled = True
			cb_go.enabled = False
		end if
	else
		cb_stop.enabled = False
		cb_go.enabled = False
	end if
end if

if f_spacechk(ls_refyear) = -1 then
	uo_year.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
else
	uo_year.uf_reset(integer(ls_refyear))
end if

ddlb_gubun.text = '배분후'

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										ls_revno, &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_revno, ls_divcode, ls_expcode, ls_applydate

ls_year  = uo_year.uf_return()
ls_revno = uo_2.is_uo_revno

if ddlb_gubun.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if


ls_year = uo_year.uf_return()

//BOM생성 적용일자 가져오기
SELECT Jobstart INTO :ls_applydate
FROM PBBPM.BPM519
WHERE COMLTD = :g_s_company AND XYEAR = :ls_year AND 
		REVNO = :ls_revno AND Windowid = 'w_bpm407c'
using sqlca;

if f_dateedit(ls_applydate) = space(8) then
	uo_status.st_message.text = "BOM기준일자가 잘못 되었습니다."
	return 0
end if

dw_bpm404c_01.reset()
f_bpm_job_start(ls_year,ls_revno,'w_bpm404c',g_s_empno,'R','미등록품조회')
if dw_bpm404c_01.retrieve(g_s_company,ls_year,ls_revno,ls_divcode,ls_applydate) > 0 then
	uo_status.st_message.text = "미등록 제품이 조회되었습니다."
else
	uo_status.st_message.text = "조회된 미등록품이 없습니다."
end if
f_bpm_job_end(ls_year,ls_revno,'w_bpm404c',g_s_empno,'R','미등록품조회')

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm404c
end type

type uo_year from uo_ccyy_mps within w_bpm404c
integer x = 379
integer y = 56
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										'%', &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

type dw_bpm404c_01 from u_vi_std_datawindow within w_bpm404c
integer x = 27
integer y = 192
integer width = 3968
integer height = 1608
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bpm404c_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_1 from statictext within w_bpm404c
integer x = 69
integer y = 60
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

type pb_down from picturebutton within w_bpm404c
integer x = 3794
integer y = 32
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel_number(dw_bpm404c_01)
end event

type uo_2 from u_bpm_select_arev within w_bpm404c
integer x = 823
integer y = 56
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
end type

on uo_2.destroy
call u_bpm_select_arev::destroy
end on

type st_2 from statictext within w_bpm404c
integer x = 1797
integer y = 64
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

type ddlb_gubun from dropdownlistbox within w_bpm404c
integer x = 2144
integer y = 48
integer width = 439
integer height = 324
integer taborder = 40
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

type cb_stop from commandbutton within w_bpm404c
integer x = 2766
integer y = 52
integer width = 293
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정"
end type

event clicked;f_bpm_job_stop(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm404c',g_s_empno,'C','생성후 BOM미등록품체크 확정작업')

parent.PostEvent('ue_postopen')
end event

type cb_go from commandbutton within w_bpm404c
integer x = 3141
integer y = 52
integer width = 320
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정취소"
end type

event clicked;f_bpm_job_go(uo_year.uf_return(),uo_2.is_uo_revno,'w_bpm404c',g_s_empno,'C','생성후 BOM미등록품체크 확정취소작업')

parent.PostEvent('ue_postopen')
end event

type gb_1 from groupbox within w_bpm404c
integer x = 27
integer y = 16
integer width = 2661
integer height = 156
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_bpm404c
integer x = 2715
integer y = 12
integer width = 782
integer height = 160
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

