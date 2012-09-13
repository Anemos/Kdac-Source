$PBExportHeader$uo_month_pur2.sru
$PBExportComments$일자 선택 - 월선택 - 스크롤 사용 - is_uo_month, is_uo_month2
forward
global type uo_month_pur2 from u_vi_cst_basic
end type
type vsb_2 from vscrollbar within uo_month_pur2
end type
type em_date2 from editmask within uo_month_pur2
end type
type st_2 from statictext within uo_month_pur2
end type
type st_1 from statictext within uo_month_pur2
end type
type em_date from editmask within uo_month_pur2
end type
type vsb_1 from vscrollbar within uo_month_pur2
end type
end forward

global type uo_month_pur2 from u_vi_cst_basic
integer width = 1038
integer height = 80
long backcolor = 12632256
event ue_select ( )
event ue_movefocus pbm_custom01
vsb_2 vsb_2
em_date2 em_date2
st_2 st_2
st_1 st_1
em_date em_date
vsb_1 vsb_1
end type
global uo_month_pur2 uo_month_pur2

type variables
string	is_uo_month, is_uo_month2
end variables

forward prototypes
public subroutine uf_setfocus ()
public subroutine uf_setdata (date ad_value)
public subroutine uf_setcolor (string as_color)
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

public subroutine uf_setcolor (string as_color);/*
	바탕색상 변경
*/
//	 l_l_color1 = 15780518 ,l_l_color2 = 16777215 ,l_l_color3 = 12632256  ,l_l_color4 = 65535
//	                 sky                     white                  gray                   yellow
as_color = Upper(Trim(as_color))

IF as_color = "S"  Then
	em_date.BackColor = 	15780518	//sky
ElseIf as_color = "G" Then
	em_date.BackColor = 	12632256	//gray
Else
	em_date.BackColor = 	16777215	//white
End IF

end subroutine

event uf_getdata;This.SetFocus()
end event

event constructor;call super::constructor;Date ld_date
String ls_bef_yymm

ls_bef_yymm = Left(String(today()),10)


SELECT top 1 
		 CONVERT(CHAR(10), DATEADD(month, -1, :ls_bef_yymm ), 102)
  INTO :ls_bef_yymm
  FROM sysusers USING SQLPIS;

ld_date = Date(ls_bef_yymm)

em_date2.text = String (ld_date)
is_uo_month2	= Left(Trim(em_date2.text), 7)

////초기 값으로 현재일자를 보임
//em_date2.text = String (today())
//
////변수 설정
//is_uo_month2	= Left(Trim(em_date2.text), 7)




//초기 값으로 현재일자를 기준으로 -12개월 한 값. (f_monthcalc 이용)
String ls_yymm 

ls_yymm = is_uo_month2 + ".01"


SELECT top 1 
		 CONVERT(CHAR(7), DATEADD(month, -11, :ls_yymm ), 102)
  INTO :is_uo_month
  FROM sysusers USING SQLPIS;

//변수 설정
//is_uo_month	= Left(Trim(em_date.text), 7)

em_date.text = is_uo_month
//
TriggerEvent("ue_select")

end event

on uo_month_pur2.create
int iCurrent
call super::create
this.vsb_2=create vsb_2
this.em_date2=create em_date2
this.st_2=create st_2
this.st_1=create st_1
this.em_date=create em_date
this.vsb_1=create vsb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.vsb_2
this.Control[iCurrent+2]=this.em_date2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_date
this.Control[iCurrent+6]=this.vsb_1
end on

on uo_month_pur2.destroy
call super::destroy
destroy(this.vsb_2)
destroy(this.em_date2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.vsb_1)
end on

type vsb_2 from vscrollbar within uo_month_pur2
integer x = 955
integer y = 4
integer width = 78
integer height = 72
end type

event linedown;//////////////////////////////////////////////////////////////////////
// Decrease the date by one month
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
INT		li_change_days

li_ret = em_date2.GetData(ld_date) //uf_chage_dateform(em_date.text)
//현재 월이 몇일로 이루어 졌는지 구한다
IF li_ret <> 0 then 
	em_date2.text = String(Relativedate(ld_date, -1))
ELSE
	em_date2.text = String(Today())
END IF

is_uo_month2	= Left(Trim(em_date2.text), 7)

Parent.TriggerEvent("ue_select")


end event

event lineup;//////////////////////////////////////////////////////////////////////
// Increase the date by one month
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
li_ret = em_date2.GetData(ld_date) //uf_chage_dateform(em_date.text)
IF li_ret <> 0 THEN
	em_date2.text = String(Relativedate(ld_date, 35))
ELSE
	em_date2.text = String(Today())
END IF

is_uo_month2	= Left(Trim(em_date2.text), 7)

Parent.TriggerEvent("ue_select")


end event

type em_date2 from editmask within uo_month_pur2
event ue_keyenter pbm_keydown
integer x = 686
integer y = 4
integer width = 265
integer height = 72
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm"
boolean autoskip = true
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
End If
end event

event losefocus;// 2001.12.06 - 날짜 입력시 잘못된 입력 막기
IF IsDate(This.text + '.01') = False THEN
	MessageBox("월 오류", "잘못된 월 입니다." + &
									"~r~n정확한 월 입력하십시요." + &
									"~r~n~r~n월 입력(예) : 2002.09 형식")
//	This.text = String(Today())
	This.text = is_uo_month2 + ".01"
	Return
END IF	

is_uo_month2	= Left(Trim(em_date2.text), 7)

Parent.TriggerEvent("ue_select")
end event

type st_2 from statictext within uo_month_pur2
integer x = 590
integer y = 8
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_month_pur2
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

type em_date from editmask within uo_month_pur2
event ue_keyenter pbm_keydown
integer x = 233
integer y = 4
integer width = 265
integer height = 68
integer taborder = 1
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy.mm"
boolean autoskip = true
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
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

type vsb_1 from vscrollbar within uo_month_pur2
integer x = 498
integer y = 4
integer width = 78
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

