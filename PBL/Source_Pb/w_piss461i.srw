$PBExportHeader$w_piss461i.srw
$PBExportComments$출하요청서재출력
forward
global type w_piss461i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss461i
end type
type uo_division from u_pisc_select_division within w_piss461i
end type
type uo_area from u_pisc_select_area within w_piss461i
end type
type dw_2 from u_vi_std_datawindow within w_piss461i
end type
type dw_print from datawindow within w_piss461i
end type
type st_v_bar from uo_xc_splitbar within w_piss461i
end type
type uo_date from u_pisc_date_applydate within w_piss461i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss461i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss461i
end type
type st_5 from statictext within w_piss461i
end type
type ddlb_1 from dropdownlistbox within w_piss461i
end type
type rb_1 from radiobutton within w_piss461i
end type
type rb_2 from radiobutton within w_piss461i
end type
type dw_print1 from datawindow within w_piss461i
end type
type st_2 from statictext within w_piss461i
end type
type sle_custcode from singlelineedit within w_piss461i
end type
type gb_1 from groupbox within w_piss461i
end type
end forward

global type w_piss461i from w_ipis_sheet01
integer width = 4640
integer height = 2700
string title = "출하요청서재출력"
event ue_postopen ( )
dw_sheet dw_sheet
uo_division uo_division
uo_area uo_area
dw_2 dw_2
dw_print dw_print
st_v_bar st_v_bar
uo_date uo_date
uo_1 uo_1
uo_shipoemgubun uo_shipoemgubun
st_5 st_5
ddlb_1 ddlb_1
rb_1 rb_1
rb_2 rb_2
dw_print1 dw_print1
st_2 st_2
sle_custcode sle_custcode
gb_1 gb_1
end type
global w_piss461i w_piss461i

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,  is_mod[],is_custgubun
string is_shipoemgubun,is_areacode,is_divisioncode,is_shipdate,is_shipdate1
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function boolean wf_print ()
public function boolean wf_print1 ()
end prototypes

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_codegroup,ls_codegroupname,ls_codename
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
ddlb_1.text = '1.납품일기준'
end event

public function boolean wf_print ();string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

long ll_count,i,ll_cnt
string ls_stcd,ls_checksrno,ls_divisioncode,ls_areacode,ls_custcode,ls_shipgubun
ll_count = dw_sheet.rowcount()
for i = 1 to ll_count step 1
	 ls_stcd = dw_sheet.object.stcd[i]
	 if ls_stcd = 'Y' then
		ls_areacode  = is_areacode
      ls_checksrno = dw_sheet.object.srno[i]
      ls_divisioncode = dw_sheet.object.divisioncode[i]
		ls_shipgubun = dw_sheet.object.shipgubun[i]
		ls_custcode  = dw_sheet.object.custcode[i]
	   dw_sheet.object.stcd[i]	= 'N'
		if left(ls_custcode,1) = 'E' then
			dw_print.dataobject = 'd_piss460u_04'
		else
			dw_print.dataobject = 'd_piss460u_03'
		end if
		dw_print.settransobject(sqlpis)
		dw_print.retrieve(is_areacode,ls_divisioncode,ls_custcode,ls_checksrno)
		dw_print.print()
	end if
next
return true

end function

public function boolean wf_print1 ();string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

dw_print1.settransobject(sqlpis)
long ll_count,i,ll_cnt
string ls_stcd,ls_checksrno,ls_divisioncode,ls_areacode,ls_custcode,ls_shipgubun
ll_count = dw_sheet.rowcount()
for i = 1 to ll_count step 1
	 ls_stcd = dw_sheet.object.stcd[i]
	 if ls_stcd = 'Y' then
		ls_areacode  = is_areacode
      ls_checksrno = dw_sheet.object.srno[i]
      ls_divisioncode = dw_sheet.object.divisioncode[i]
		ls_shipgubun = dw_sheet.object.shipgubun[i]
		ls_custcode  = dw_sheet.object.custcode[i]
	   dw_sheet.object.stcd[i]	= 'N'
		dw_print1.retrieve(is_areacode,ls_divisioncode,ls_checksrno)
   	dw_print1.print()
	end if
next
return true

end function

on w_piss461i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_2=create dw_2
this.dw_print=create dw_print
this.st_v_bar=create st_v_bar
this.uo_date=create uo_date
this.uo_1=create uo_1
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_5=create st_5
this.ddlb_1=create ddlb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_print1=create dw_print1
this.st_2=create st_2
this.sle_custcode=create sle_custcode
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.st_v_bar
this.Control[iCurrent+7]=this.uo_date
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.uo_shipoemgubun
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.ddlb_1
this.Control[iCurrent+12]=this.rb_1
this.Control[iCurrent+13]=this.rb_2
this.Control[iCurrent+14]=this.dw_print1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.sle_custcode
this.Control[iCurrent+17]=this.gb_1
end on

on w_piss461i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_2)
destroy(this.dw_print)
destroy(this.st_v_bar)
destroy(this.uo_date)
destroy(this.uo_1)
destroy(this.uo_shipoemgubun)
destroy(this.st_5)
destroy(this.ddlb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_print1)
destroy(this.st_2)
destroy(this.sle_custcode)
destroy(this.gb_1)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_sheet, LEFT)
of_resize_register(st_v_bar, SPLIT)
of_resize_register(dw_2, RIGHT)

of_resize()
end event

event ue_retrieve;string ls_date_std,ls_custcode
ls_date_std = left(ddlb_1.text,1)
setpointer(hourglass!)
dw_2.reset()
dw_sheet.reset()
ls_custcode = trim(sle_custcode.text)
if ls_custcode = '' or isnull(ls_custcode) then
   	ls_custcode = '%'
else
	ls_custcode = ls_custcode + '%'
end if	

dw_sheet.retrieve(is_areacode,is_divisioncode,ls_custcode,is_shipdate,is_shipdate1,is_shipoemgubun,ls_date_std)
setpointer(arrow!)
if dw_sheet.rowcount() = 0 then
	messagebox("확인","조회할 자료가 없읍니다.")
	return
end if
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

event ue_print;setpointer(hourglass!)
if rb_1.checked = true then
	wf_print()
else
	wf_print1()
end if
setpointer(arrow!)


end event

type uo_status from w_ipis_sheet01`uo_status within w_piss461i
end type

type dw_sheet from u_vi_std_datawindow within w_piss461i
integer x = 18
integer y = 296
integer width = 2414
integer height = 2188
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss461i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;string ls_checksrno,ls_divisioncode,ls_custcode
if row > 0 then
	ls_checksrno    = dw_sheet.object.srno[row]
	ls_divisioncode = dw_sheet.object.divisioncode[row]
	ls_custcode     = dw_sheet.object.custcode[row]
	dw_2.retrieve(is_areacode,ls_divisioncode,ls_custcode,ls_checksrno)
end if	
end event

type uo_division from u_pisc_select_division within w_piss461i
integer x = 2409
integer y = 76
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss461i
integer x = 1874
integer y = 76
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type dw_2 from u_vi_std_datawindow within w_piss461i
integer x = 2478
integer y = 288
integer width = 1984
integer height = 2192
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_piss460u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type dw_print from datawindow within w_piss461i
boolean visible = false
integer x = 187
integer y = 364
integer width = 1326
integer height = 1384
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss460u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_v_bar from uo_xc_splitbar within w_piss461i
integer x = 2441
integer y = 228
integer width = 18
boolean bringtotop = true
integer textsize = -9
end type

event constructor;call super::constructor;of_register(dw_sheet,LEFT)
of_register(dw_2,RIGHT)
end event

type uo_date from u_pisc_date_applydate within w_piss461i
integer x = 87
integer y = 76
integer taborder = 60
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;if is_shipdate <> is_uo_date then
	dw_sheet.reset()
	dw_2.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_1 from u_pisc_date_applydate_1 within w_piss461i
event destroy ( )
integer x = 786
integer y = 76
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date
dw_2.reset()
dw_sheet.reset()
end event

type uo_shipoemgubun from u_pisc_select_code within w_piss461i
integer x = 315
integer y = 168
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_shipoemgubun = is_uo_codeid

dw_sheet.reset()
dw_2.reset()
dw_print.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_shipoemgubun = is_uo_codeid

end event

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

type st_5 from statictext within w_piss461i
integer x = 27
integer y = 176
integer width = 270
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
string text = "출하구분"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_piss461i
integer x = 1266
integer y = 76
integer width = 549
integer height = 324
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1.납품일기준","2.입력일기준"}
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_piss461i
integer x = 1088
integer y = 176
integer width = 242
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
string text = "정규"
boolean checked = true
end type

event clicked;rb_2.checked = false
dw_sheet.dataobject = 'd_piss461i_01'
dw_2.dataobject = 'd_piss460u_02'
dw_print.dataobject = 'd_piss460u_03'
dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_print.reset()
dw_2.reset()
dw_sheet.reset()
end event

type rb_2 from radiobutton within w_piss461i
integer x = 1358
integer y = 172
integer width = 233
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
string text = "취소"
end type

event clicked;rb_1.checked = false
dw_sheet.dataobject = 'd_piss461i_03'
dw_2.dataobject = 'd_piss461i_04'
dw_print.dataobject = 'd_piss420u_02'
dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_print.reset()
dw_sheet.reset()
dw_2.reset()
end event

type dw_print1 from datawindow within w_piss461i
boolean visible = false
integer x = 571
integer y = 676
integer width = 2935
integer height = 944
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss420u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_piss461i
integer x = 3013
integer y = 84
integer width = 242
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
string text = "거래처"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_custcode from singlelineedit within w_piss461i
integer x = 3255
integer y = 72
integer width = 320
integer height = 80
integer taborder = 190
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss461i
integer x = 5
integer y = 12
integer width = 4457
integer height = 256
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

