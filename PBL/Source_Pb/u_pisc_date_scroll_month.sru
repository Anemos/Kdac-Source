$PBExportHeader$u_pisc_date_scroll_month.sru
$PBExportComments$일자 선택 - 월선택 - 스크롤 사용 - is_uo_month
forward
global type u_pisc_date_scroll_month from u_vi_cst_basic
end type
type st_1 from statictext within u_pisc_date_scroll_month
end type
type em_date from editmask within u_pisc_date_scroll_month
end type
type vsb_1 from vscrollbar within u_pisc_date_scroll_month
end type
end forward

global type u_pisc_date_scroll_month from u_vi_cst_basic
integer width = 576
integer height = 76
long backcolor = 12632256
event ue_select ( )
event ue_movefocus pbm_custom01
event ue_keydown pbm_keydown
st_1 st_1
em_date em_date
vsb_1 vsb_1
end type
global u_pisc_date_scroll_month u_pisc_date_scroll_month

type variables
string	is_uo_month
end variables

forward prototypes
public subroutine uf_setfocus ()
public subroutine uf_setdata (date ad_value)
end prototypes

event ue_movefocus;This.SetFocus()
 
end event

public subroutine uf_setfocus ();//Set Focus
em_date.SetFocus()
end subroutine

public subroutine uf_setdata (date ad_value);em_date.text = String( ad_value )
//Trigger Modified Event
//변수 설정
is_uo_month	= Left(Trim(em_date.text), 7)

TriggerEvent("ue_select")
end subroutine

event uf_getdata;This.SetFocus()
end event

event constructor;call super::constructor;//초기 값으로 현재일자를 보임
em_date.text = String (today())

//변수 설정
is_uo_month	= Left(Trim(em_date.text), 7)

TriggerEvent("ue_select")
end event

on u_pisc_date_scroll_month.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_date=create em_date
this.vsb_1=create vsb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_date
this.Control[iCurrent+3]=this.vsb_1
end on

on u_pisc_date_scroll_month.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_date)
destroy(this.vsb_1)
end on

type st_1 from statictext within u_pisc_date_scroll_month
integer y = 8
integer width = 224
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기준월:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within u_pisc_date_scroll_month
event ue_keyenter pbm_keydown
integer x = 233
integer width = 265
integer height = 68
integer taborder = 1
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm"
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
End If
end event

event losefocus;// 2001.12.06 - 날짜 입력시 잘못된 입력 막기
IF IsDate(This.text + '.01') = False THEN
	MessageBox("월 오류", "잘못된 월 입니다." + &
									"~r~n정확한 월 입력하십시요." + &
									"~r~n~r~n월 입력(예) : 2002.09 형식")
//	This.text = String(Today())
	This.text = is_uo_month + ".01"
	Return
END IF	

is_uo_month	= Left(Trim(em_date.text), 7)

Parent.TriggerEvent("ue_select")
end event

type vsb_1 from vscrollbar within u_pisc_date_scroll_month
integer x = 498
integer width = 73
integer height = 72
end type

event lineup;//////////////////////////////////////////////////////////////////////
// Increase the date by one month
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
IF li_ret <> 0 THEN
	em_date.text = String(Relativedate(ld_date, 35))
ELSE
	em_date.text = String(Today())
END IF

is_uo_month	= Left(Trim(em_date.text), 7)

Parent.TriggerEvent("ue_select")


end event

event linedown;//////////////////////////////////////////////////////////////////////
// Decrease the date by one month
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
INT		li_change_days
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
//현재 월이 몇일로 이루어 졌는지 구한다
IF li_ret <> 0 then 
	em_date.text = String(Relativedate(ld_date, -1))
ELSE
	em_date.text = String(Today())
END IF

is_uo_month	= Left(Trim(em_date.text), 7)

Parent.TriggerEvent("ue_select")


end event

