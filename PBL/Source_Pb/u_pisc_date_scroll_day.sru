$PBExportHeader$u_pisc_date_scroll_day.sru
$PBExportComments$일자 선택 - 금일 - 스크롤 사용 - is_uo_date
forward
global type u_pisc_date_scroll_day from userobject
end type
type st_1 from statictext within u_pisc_date_scroll_day
end type
type vsb_1 from vscrollbar within u_pisc_date_scroll_day
end type
type em_date from editmask within u_pisc_date_scroll_day
end type
type st_dayname from statictext within u_pisc_date_scroll_day
end type
end forward

global type u_pisc_date_scroll_day from userobject
integer width = 741
integer height = 80
long backcolor = 12632256
long tabtextcolor = 33554432
event ue_select ( )
event ue_movefocus pbm_custom01
event ue_keydown pbm_keydown
st_1 st_1
vsb_1 vsb_1
em_date em_date
st_dayname st_dayname
end type
global u_pisc_date_scroll_day u_pisc_date_scroll_day

type variables
string	is_uo_date
end variables

forward prototypes
public subroutine uf_set_dayname ()
public subroutine uf_setfocus ()
public subroutine uf_setdata (date ad_value)
public function boolean uf_getdata (ref date ad_date)
end prototypes

event ue_movefocus;This.SetFocus()
 
end event

public subroutine uf_set_dayname ();INT		li_ret
INT		li_DayNumber
DATE		ld_date
STRING	ls_date


li_ret = em_date.Getdata(ld_date)

IF li_ret = 1 THEN
	//요일을 나타내는 숫자를 가져와서는
	li_DayNumber = DayNumber(ld_date)
	CHOOSE CASE li_DayNumber
		CASE 1	//일요일
			st_dayname.text = "일"
			st_dayname.TextColor = 255
		CASE 2	//월요일
			st_dayname.text = "월"
			st_dayname.TextColor = 0
		CASE 3	//화요일
			st_dayname.text = "화"
			st_dayname.TextColor = 0
		CASE 4	//수요일
			st_dayname.text = "수"
			st_dayname.TextColor = 0
		CASE 5	//목요일
			st_dayname.text = "목"
			st_dayname.TextColor = 0
		CASE 6	//금요일
			st_dayname.text = "금"
			st_dayname.TextColor = 0
		CASE 7	//토요일
			st_dayname.text = "토"
				st_dayname.TextColor = 0	
	END CHOOSE
ELSE
	st_dayname.text = "?"
	st_dayname.TextColor = 255
END IF
end subroutine

public subroutine uf_setfocus ();//Set Focus
em_date.SetFocus()
end subroutine

public subroutine uf_setdata (date ad_value);em_date.text = String(ad_value)

//요일설정
uf_set_dayname()

//변수 설정
is_uo_date	= Trim(em_date.text)

TriggerEvent("ue_select")


end subroutine

public function boolean uf_getdata (ref date ad_date);//선택된 일자을 반환한다
INT	li_ret	//함수의 결과값
li_ret = em_date.GetData(ad_date)
if li_ret = 1  then
	return TRUE
else
	return FALSE
end if
end function

event constructor;em_date.text = String (today())

//요일설정
uf_set_dayname()

//변수 설정
is_uo_date	= Trim(em_date.text)

TriggerEvent("ue_select")
end event

on u_pisc_date_scroll_day.create
this.st_1=create st_1
this.vsb_1=create vsb_1
this.em_date=create em_date
this.st_dayname=create st_dayname
this.Control[]={this.st_1,&
this.vsb_1,&
this.em_date,&
this.st_dayname}
end on

on u_pisc_date_scroll_day.destroy
destroy(this.st_1)
destroy(this.vsb_1)
destroy(this.em_date)
destroy(this.st_dayname)
end on

type st_1 from statictext within u_pisc_date_scroll_day
integer y = 8
integer width = 224
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "기준일:"
alignment alignment = right!
boolean focusrectangle = false
end type

type vsb_1 from vscrollbar within u_pisc_date_scroll_day
integer x = 594
integer width = 73
integer height = 72
end type

event lineup;//////////////////////////////////////////////////////////////////////
// Increase the date by one day
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
IF li_ret <> 0 THEN
	em_date.text = String(Relativedate(ld_date, 1))
ELSE
	em_date.text = String(Today())
END IF

//요일설정
uf_set_dayname()

//변수 설정
is_uo_date	= Trim(em_date.text)

Parent.TriggerEvent("ue_select")
end event

event linedown;//////////////////////////////////////////////////////////////////////
// Decrease the date by one day
//////////////////////////////////////////////////////////////////////
DATE		ld_date
INT		li_ret		
li_ret = em_date.GetData(ld_date) //uf_chage_dateform(em_date.text)
IF li_ret <> 0 THEN
	em_date.text = String(Relativedate(ld_date, -1))
ELSE
	em_date.text = String(Today())
END IF

//요일설정
uf_set_dayname()

//변수 설정
is_uo_date	= Trim(em_date.text)

Parent.TriggerEvent("ue_select")

end event

type em_date from editmask within u_pisc_date_scroll_day
event ue_keyenter pbm_keydown
integer x = 233
integer width = 361
integer height = 68
integer taborder = 10
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
string mask = "yyyy.mm.dd"
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
End If
end event

event losefocus;// 2001.12.06 - 날짜 입력시 잘못된 입력 막기
IF IsDate(This.text) = False THEN
	MessageBox("일자 오류", "잘못된 일자 입니다." + &
									"~r~n정확한 일자를 입력하십시요." + &
									"~r~n~r~n일자 입력(예) : 2002.09.09 형식")
//	This.text = String(Today())
	This.text = is_uo_date	
	Return
END IF	

is_uo_date	= Trim(em_date.text)
uf_set_dayname()

Parent.TriggerEvent("ue_select")
end event

type st_dayname from statictext within u_pisc_date_scroll_day
integer x = 672
integer y = 12
integer width = 69
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "월"
alignment alignment = center!
boolean focusrectangle = false
end type

