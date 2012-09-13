$PBExportHeader$uo_year_pur.sru
$PBExportComments$일자 선택 - 년선택 - 스크롤 사용 - is_uo_year
forward
global type uo_year_pur from u_vi_cst_basic
end type
type st_1 from statictext within uo_year_pur
end type
type em_date from editmask within uo_year_pur
end type
type vsb_1 from vscrollbar within uo_year_pur
end type
end forward

global type uo_year_pur from u_vi_cst_basic
integer width = 567
integer height = 73
long backcolor = 12632256
event ue_select ( )
event ue_movefocus pbm_custom01
st_1 st_1
em_date em_date
vsb_1 vsb_1
end type
global uo_year_pur uo_year_pur

type variables
string	is_uo_year
end variables

forward prototypes
public subroutine uf_setfocus ()
public function boolean uf_getdata (ref date ad_date)
public subroutine uf_setdata (date ad_value)
public subroutine uf_setcolor (string as_color)
end prototypes

event ue_movefocus;This.SetFocus()
end event

public subroutine uf_setfocus ();//Set Focus
em_date.SetFocus()
end subroutine

public function boolean uf_getdata (ref date ad_date);//선택된 일자(년월)을 반환한다
INT	li_ret	//함수의 결과값
li_ret = em_date.GetData(ad_date)
IF li_ret = 1  THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public subroutine uf_setdata (date ad_value);em_date.text = String( ad_value )
//Trigger Modified Event
//변수 설정
is_uo_year	= Left(Trim(em_date.text), 4)

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

event constructor;//초기 값으로 현재일자를 보임
em_date.text = String(Date(Mid(String(today(),'yyyymmdd'),1,4) + '.'+ '01' + '.' + '01'))

//변수 설정
is_uo_year	= Left(Trim(em_date.text), 4)

TriggerEvent("ue_select")
end event

on uo_year_pur.create
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

on uo_year_pur.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_date)
destroy(this.vsb_1)
end on

type st_1 from statictext within uo_year_pur
integer y = 8
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기준년도:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within uo_year_pur
event ue_keyenter pbm_keydown
integer x = 311
integer width = 178
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
string mask = "yyyy"
boolean autoskip = true
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
End If
end event

event losefocus;// 2001.12.06 - 날짜 입력시 잘못된 입력 막기
IF IsDate(This.text + '.01.01') = False THEN
	MessageBox("년 오류", "잘못된 년 입니다." + &
									"~r~n정확한 년 입력하십시요." + &
									"~r~n~r~n월 입력(예) : 2002 형식")
//	This.text = String(Today())
	This.text = is_uo_year + "01.01"
	Return
END IF	

is_uo_year	= Left(Trim(em_date.text), 4)

Parent.TriggerEvent("ue_select")
end event

type vsb_1 from vscrollbar within uo_year_pur
integer x = 489
integer width = 78
integer height = 72
end type

event lineup;//////////////////////////////////////////////////////////////////////
// Increase the date by one year
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
IF li_ret <> 0 THEN
	em_date.text = String(Relativedate(ld_date, 367))
ELSE
	em_date.text = String(Date(Mid(String(today(),'yyyymmdd'),1,4) + '.'+ '01' + '.' + '01'))
END If

//변수 설정
is_uo_year	= Left(Trim(em_date.text), 4)

Parent.TriggerEvent("ue_select")


end event

event linedown;//////////////////////////////////////////////////////////////////////
// Decrease the date by one year
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
INT		li_change_days
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
//
IF li_ret <> 0 then 
	em_date.text = String(Relativedate(ld_date, -1))
ELSE
	em_date.text = String(Date(Mid(String(today(),'yyyymmdd'),1,4) + '.'+ '01' + '.' + '01'))
END IF

//변수 설정
is_uo_year	= Left(Trim(em_date.text), 4)

Parent.TriggerEvent("ue_select")


end event

