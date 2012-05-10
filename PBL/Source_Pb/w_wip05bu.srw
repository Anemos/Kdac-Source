$PBExportHeader$w_wip05bu.srw
$PBExportComments$정산현황관리(외개)
forward
global type w_wip05bu from w_origin_sheet02
end type
type uo_1 from uo_wip_plandiv within w_wip05bu
end type
type uo_to from uo_yymm_boongi within w_wip05bu
end type
type st_1 from statictext within w_wip05bu
end type
type dw_wip05bu_01 from datawindow within w_wip05bu
end type
type dw_wip05bu_02 from datawindow within w_wip05bu
end type
type cb_confirm from commandbutton within w_wip05bu
end type
type pb_down from picturebutton within w_wip05bu
end type
type gb_1 from groupbox within w_wip05bu
end type
end forward

global type w_wip05bu from w_origin_sheet02
uo_1 uo_1
uo_to uo_to
st_1 st_1
dw_wip05bu_01 dw_wip05bu_01
dw_wip05bu_02 dw_wip05bu_02
cb_confirm cb_confirm
pb_down pb_down
gb_1 gb_1
end type
global w_wip05bu w_wip05bu

type variables
String is_adjdt
end variables

on w_wip05bu.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_to=create uo_to
this.st_1=create st_1
this.dw_wip05bu_01=create dw_wip05bu_01
this.dw_wip05bu_02=create dw_wip05bu_02
this.cb_confirm=create cb_confirm
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_to
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_wip05bu_01
this.Control[iCurrent+5]=this.dw_wip05bu_02
this.Control[iCurrent+6]=this.cb_confirm
this.Control[iCurrent+7]=this.pb_down
this.Control[iCurrent+8]=this.gb_1
end on

on w_wip05bu.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_to)
destroy(this.st_1)
destroy(this.dw_wip05bu_01)
destroy(this.dw_wip05bu_02)
destroy(this.cb_confirm)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;dec{0} ld_yyyymm
string ls_fromdt,ls_todt, ls_plant, ls_dvsn, ls_part
long ll_rowcnt

dw_wip05bu_01.reset()
dw_wip05bu_02.reset()

ld_yyyymm     = uo_to.uf_yyyymm()
is_adjdt        = string(ld_yyyymm)
ls_fromdt      = uf_wip_addmonth(is_adjdt,-2)
ls_plant = trim(uo_1.dw_1.getitemstring(1,'xplant'))
ls_dvsn  = trim(uo_1.dw_1.getitemstring(1,'div'))

if f_wip_check_stdt( g_s_company, is_adjdt ) then
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
	cb_confirm.enabled = true
else
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
	cb_confirm.enabled = false
end if

if f_spacechk(ls_plant) = -1 then
	ls_plant = '%'
else
	ls_plant = ls_plant + '%'
end if
if f_spacechk(ls_dvsn) = -1 then
	ls_dvsn = '%'
else
	ls_dvsn = ls_dvsn + '%'
end if

ll_rowcnt = dw_wip05bu_01.retrieve(mid(is_adjdt,1,4), mid(is_adjdt,5,2), '01', ls_plant, ls_dvsn)
if ll_rowcnt < 1 then
	uo_status.st_message.text = '조회할 자료가 없습니다.'
else
	uo_status.st_message.text = '조회되었습니다.'
end if
end event

event open;call super::open;
dw_wip05bu_01.settransobject(sqlca)
dw_wip05bu_02.settransobject(sqlca)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
end event

event ue_save;call super::ue_save;dw_wip05bu_01.accepttext()
dw_wip05bu_02.accepttext()

if dw_wip05bu_01.update() <> 1 then
	uo_status.st_message.text = '상태코드 저장이 실패했습니다.'
	return 0
end if

if dw_wip05bu_02.update() = 1 then
	uo_status.st_message.text = '저장되었습니다.'
else
	uo_status.st_message.text = '데이타 저장이 실패했습니다.'
end if

return 0
end event

type uo_status from w_origin_sheet02`uo_status within w_wip05bu
end type

type uo_1 from uo_wip_plandiv within w_wip05bu
integer x = 96
integer y = 64
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type uo_to from uo_yymm_boongi within w_wip05bu
integer x = 1778
integer y = 68
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call uo_yymm_boongi::destroy
end on

type st_1 from statictext within w_wip05bu
integer x = 1408
integer y = 80
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_wip05bu_01 from datawindow within w_wip05bu
integer x = 32
integer y = 224
integer width = 1705
integer height = 2244
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip05bu_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_chkdata
string ls_year, ls_month, ls_cmcd, ls_plant, ls_dvsn, ls_vendor

ls_colname = dwo.name

if ls_colname = 'wip009_wfstscd' then
	ls_chkdata = This.getitemstring(row,'wip009_wfstscd')
	ls_year = This.getitemstring(row,'wip009_wfyear')
	ls_month = This.getitemstring(row,'wip009_wfmonth')
	ls_cmcd = This.getitemstring(row,'wip009_wfcmcd')
	ls_plant = This.getitemstring(row,'wip009_wfplant')
	ls_dvsn = This.getitemstring(row,'wip009_wfdvsn')
	ls_vendor = This.getitemstring(row,'wip009_wfvendor')
	
	select distinct wfstscd into :ls_chkdata
	from pbwip.wip009
	where wfyear = :ls_year and wfmonth = :ls_month and
			wfcmcd = :ls_cmcd and wfplant = :ls_plant and
			wfdvsn = :ls_dvsn and wfvendor = :ls_vendor
	using sqlca;

	choose case ls_chkdata
		case '1'  	//입력완료
			if data > '2' then
				messagebox("경고", "1차 확정까지만 가능합니다.")
				This.setitem(row,'wip009_wfstscd',ls_chkdata)
				return 1
			end if
		case '2' 	//1차확정
			if data > '2' then
				messagebox("경고", "상태변경이 불가능합니다.")
				This.setitem(row,'wip009_wfstscd',ls_chkdata)
				return 1
			end if
		case '3' 	//클레임계산
			if data > '5' then
				messagebox("경고"," 상태변경이 불가능합니다.")
				This.setitem(row,'wip009_wfstscd',ls_chkdata)
				return 1
			end if
		case '4' 	//최종확정
			messagebox("경고","경리 담당자만 상태변경이 가능합니다.")
			This.setitem(row,'wip009_wfstscd',ls_chkdata)
			return 1
		case '5' 	//경리확정
			messagebox("경고","경리 담당자만 상태변경이 가능합니다.")
			This.setitem(row,'wip009_wfstscd',ls_chkdata)
			return 1
		case else 	//업체입력
			messagebox("경고", "업체담당자만 확정이 가능합니다.")
			This.setitem(row,'wip009_wfstscd',ls_chkdata)
			return 1
	end choose
end if

This.accepttext()
return 0
			
			
			
			
end event

event doubleclicked;String ls_plant, ls_dvsn, ls_year, ls_month, ls_vendor
long ll_rowcnt

ls_plant = This.getitemstring(row,'wip009_wfplant')
ls_dvsn = This.getitemstring(row,'wip009_wfdvsn')
ls_year = This.getitemstring(row,'wip009_wfyear')
ls_month = This.getitemstring(row,'wip009_wfmonth')
ls_vendor = This.getitemstring(row,'wip009_wfvendor')

ll_rowcnt = dw_wip05bu_02.retrieve('01',ls_plant,ls_dvsn,ls_vendor,ls_year,ls_month)
if ll_rowcnt < 1 then
	uo_status.st_message.text = '조회할 자료가 없습니다.'
else
	uo_status.st_message.text = '조회되었습니다.'
end if

return 0
end event

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

type dw_wip05bu_02 from datawindow within w_wip05bu
integer x = 1760
integer y = 224
integer width = 2839
integer height = 2244
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip05bu_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_confirm from commandbutton within w_wip05bu
integer x = 2501
integer y = 64
integer width = 741
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "업체입력확정(강제)"
end type

event clicked;long ll_selrow
string ls_plant, ls_dvsn, ls_vendor, ls_yyyy, ls_month

ll_selrow = dw_wip05bu_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "선택된 업체가 없습니다."
	return 0
else
	if f_spacechk(dw_wip05bu_01.getitemstring(ll_selrow,"wip009_wfstscd")) <> -1 then
		uo_status.st_message.text = "선택된 업체는 미확정상태가 아닙니다."
		return 0
	end if
end if

ls_plant = dw_wip05bu_01.getitemstring(ll_selrow,"wip009_wfplant")
ls_dvsn = dw_wip05bu_01.getitemstring(ll_selrow,"wip009_wfdvsn")
ls_vendor = dw_wip05bu_01.getitemstring(ll_selrow,"wip009_wfvendor")
ls_yyyy = mid(is_adjdt,1,4)
ls_month = mid(is_adjdt,5,2)

UPDATE PBWIP.WIP009
SET wfstscd = '1'
WHERE wfyear = :ls_yyyy AND wfmonth = :ls_month AND
	wfplant = :ls_plant AND wfdvsn = :ls_dvsn AND
	wfvendor = :ls_vendor
using sqlca;

if sqlca.sqlnrows < 1 then
	uo_status.st_message.text = "지역,공장,업체에 해당하는 데이타가 없습니다."
else
	Parent.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "정상적으로 상태변경이 완료되었습니다."
end if

return 0

end event

type pb_down from picturebutton within w_wip05bu
integer x = 3351
integer y = 60
integer width = 247
integer height = 132
integer taborder = 40
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

event clicked;
if dw_wip05bu_02.rowcount() < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
	return 0
end if

f_save_to_excel_number(dw_wip05bu_02)
end event

type gb_1 from groupbox within w_wip05bu
integer x = 27
integer width = 3291
integer height = 196
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

