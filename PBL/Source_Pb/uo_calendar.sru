$PBExportHeader$uo_calendar.sru
forward
global type uo_calendar from userobject
end type
type em_date from editmask within uo_calendar
end type
type vsb_1 from vscrollbar within uo_calendar
end type
type sle_month from singlelineedit within uo_calendar
end type
type sle_year from singlelineedit within uo_calendar
end type
type st_2 from statictext within uo_calendar
end type
type st_1 from statictext within uo_calendar
end type
type dw_1 from datawindow within uo_calendar
end type
type gb_1 from groupbox within uo_calendar
end type
end forward

global type uo_calendar from userobject
integer width = 1221
integer height = 708
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
event ue_construct ( string l_s_year,  string l_s_month,  string l_s_day )
event ue_visible ( )
em_date em_date
vsb_1 vsb_1
sle_month sle_month
sle_year sle_year
st_2 st_2
st_1 st_1
dw_1 dw_1
gb_1 gb_1
end type
global uo_calendar uo_calendar

type variables

end variables

forward prototypes
public subroutine visible_chk ()
public subroutine init_set ()
end prototypes

event ue_construct(string l_s_year, string l_s_month, string l_s_day);string l_s_div,l_s_daygubun,l_s_dateday[],l_s_year1,l_s_year2,l_s_chkday
long   l_s_row,l_s_chk_first
int    i
 
sle_year.text  = l_s_year
sle_month.text = string(integer(l_s_month))
l_s_year1 = mid(l_s_year,1,2)
l_s_year2 = mid(l_s_year,3,2)
dw_1.reset()
i = 1
do while i <= 31
	l_s_dateday[i] = string(i)
	l_s_chkday     = string(i,"00")
	l_s_daygubun = Dayname(date(string(l_s_year + l_s_month + l_s_chkday,"@@@@-@@-@@")))	
	if f_spacechk(f_dateedit(l_s_year + l_s_month + l_s_chkday)) = -1 then
		exit
	end if
	
	if trim(l_s_daygubun) = "Sunday" or l_s_chk_first = 0 then
		l_s_chk_first = 1
		l_s_row = dw_1.insertrow(0)
	end if 
	 
	Choose case l_s_daygubun
		case "Sunday"
			dw_1.setitem(l_s_row,"date1",l_s_dateday[i])
		case "Monday"
			dw_1.setitem(l_s_row,"date2",l_s_dateday[i])
		case "Tuesday"
			dw_1.setitem(l_s_row,"date3",l_s_dateday[i])
		case "Wednesday"
			dw_1.setitem(l_s_row,"date4",l_s_dateday[i])
		case "Thursday"
			dw_1.setitem(l_s_row,"date5",l_s_dateday[i])
		case "Friday"
			dw_1.setitem(l_s_row,"date6",l_s_dateday[i])
		case "Saturday"
			dw_1.setitem(l_s_row,"date7",l_s_dateday[i])
	End Choose
	i += 1
loop


end event

event ue_visible();sle_year.visible  = false
st_1.visible      = false
sle_month.visible = false
st_2.visible      = false
dw_1.visible      = false
gb_1.visible      = false

end event

public subroutine visible_chk ();
end subroutine

public subroutine init_set ();sle_year.visible  = false
st_1.visible      = false
sle_month.visible = false
st_2.visible      = false
dw_1.visible      = false


end subroutine

on uo_calendar.create
this.em_date=create em_date
this.vsb_1=create vsb_1
this.sle_month=create sle_month
this.sle_year=create sle_year
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.em_date,&
this.vsb_1,&
this.sle_month,&
this.sle_year,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.gb_1}
end on

on uo_calendar.destroy
destroy(this.em_date)
destroy(this.vsb_1)
destroy(this.sle_month)
destroy(this.sle_year)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event constructor;dw_1.settransobject(sqlca)
em_date.text = g_s_date

end event

type em_date from editmask within uo_calendar
integer x = 270
integer width = 571
integer height = 84
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

event getfocus;parent.EVENT ue_visible()
end event

type vsb_1 from vscrollbar within uo_calendar
integer x = 846
integer width = 55
integer height = 88
end type

event linedown;string l_s_dateyear,l_s_datemonth,l_s_dateday,l_s_date
int    l_s_daycnt,l_n_year,l_n_month


sle_year.visible  = true
st_1.visible      = true
sle_month.visible = true
st_2.visible      = true
dw_1.visible      = true

l_s_dateyear  = mid(em_date.text,1,4)
l_s_datemonth = mid(em_date.text,6,2)
l_s_dateday   = mid(em_date.text,9,2)
l_s_date      = l_s_dateyear + l_s_datemonth + l_s_dateday 
l_n_month = year(date(string(l_s_date,"@@@@-@@-@@"))) * 12 + & 
				month(date(string(l_s_date,"@@@@-@@-@@"))) - 1

l_n_year = integer(l_n_month / 12)

if mod(l_n_month, 12) = 0 then
	l_n_month = 12
	l_n_year -= 1
else
	l_n_month = mod(l_n_month,12) 
end if
l_s_date = string(l_n_year) + string(l_n_month,"00") + l_s_dateday
do while f_spacechk(f_dateedit(l_s_date)) = -1
	l_s_date = string(long(l_s_date) - 1,"00000000")
loop
em_date.text = l_s_date
l_s_dateyear   = mid(em_date.text,1,4)
l_s_datemonth  = mid(em_date.text,6,2)
sle_year.text  = l_s_dateyear
sle_month.text = string(l_s_datemonth,"@@")
parent.EVENT ue_construct(l_s_dateyear,l_s_datemonth,l_s_dateday)

end event

event lineup;string l_s_dateyear,l_s_datemonth,l_s_dateday,l_s_date
int    l_s_daycnt,l_n_month,l_n_year

sle_year.visible  = true
st_1.visible      = true
sle_month.visible = true
st_2.visible      = true
dw_1.visible      = true

l_s_dateyear  = mid(em_date.text,1,4)
l_s_datemonth = mid(em_date.text,6,2)
l_s_dateday   = mid(em_date.text,9,2)
l_s_date      = l_s_dateyear + l_s_datemonth + l_s_dateday 
l_n_month = year(date(string(l_s_date,"@@@@-@@-@@"))) * 12 + & 
				month(date(string(l_s_date,"@@@@-@@-@@"))) + 1

l_n_year = integer(l_n_month / 12)

if mod(l_n_month, 12) = 0 then
	l_n_month = 12
	l_n_year -= 1
else
	l_n_month = mod(l_n_month,12) 
end if
l_s_date = string(l_n_year) + string(l_n_month,"00") + l_s_dateday
do while f_spacechk(f_dateedit(l_s_date)) = -1
	l_s_date = string(long(l_s_date) - 1,"00000000")
loop
em_date.text = l_s_date
l_s_dateyear  = mid(em_date.text,1,4)
l_s_datemonth = mid(em_date.text,6,2)
sle_year.text = l_s_dateyear
sle_month.text = string(l_s_datemonth,"@@")
parent.EVENT ue_construct(l_s_dateyear,l_s_datemonth,l_s_Dateday)
end event

type sle_month from singlelineedit within uo_calendar
boolean visible = false
integer x = 654
integer y = 128
integer width = 101
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 12632256
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_year from singlelineedit within uo_calendar
boolean visible = false
integer x = 357
integer y = 128
integer width = 183
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 12632256
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within uo_calendar
boolean visible = false
integer x = 750
integer y = 128
integer width = 101
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 12632256
string text = "¿ù"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_calendar
boolean visible = false
integer x = 544
integer y = 128
integer width = 87
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 12632256
string text = "³â"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_1 from datawindow within uo_calendar
boolean visible = false
integer x = 23
integer y = 216
integer width = 1166
integer height = 448
string title = "none"
string dataobject = "calendar"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string  l_s_parm
integer l_n_row,l_n_column

l_n_row    = this.getclickedrow()
l_n_column = this.getclickedcolumn()
l_s_parm   = mid(em_date.text,1,4) + mid(em_Date.text,6,2)

Choose Case l_n_column
	Case 1
		l_s_parm += string(integer(this.object.date1[l_n_row]),"00")
	Case 2
		l_s_parm += string(integer(this.object.date2[l_n_row]),"00")
	Case 3
		l_s_parm += string(integer(this.object.date3[l_n_row]),"00")
	Case 4
		l_s_parm += string(integer(this.object.date4[l_n_row]),"00")
	Case 5
		l_s_parm += string(integer(this.object.date5[l_n_row]),"00")
	Case 6
		l_s_parm += string(integer(this.object.date6[l_n_row]),"00")
	Case 7
		l_s_parm += string(integer(this.object.date7[l_n_row]),"00")
End Choose
if f_spacechk(f_Dateedit(l_s_parm)) <> -1 then
	em_date.text = l_s_parm
	parent.EVENT ue_visible()
end if

end event

event clicked;string  l_s_parm
integer l_n_row,l_n_column

l_n_row    = this.getclickedrow()
l_n_column = this.getclickedcolumn()
l_s_parm   = mid(em_date.text,1,4) + mid(em_Date.text,6,2)
Choose Case l_n_column
	Case 1
		l_s_parm += string(integer(this.object.date1[l_n_row]),"00")
	Case 2
		l_s_parm += string(integer(this.object.date2[l_n_row]),"00")
	Case 3
		l_s_parm += string(integer(this.object.date3[l_n_row]),"00")
	Case 4
		l_s_parm += string(integer(this.object.date4[l_n_row]),"00")
	Case 5
		l_s_parm += string(integer(this.object.date5[l_n_row]),"00")
	Case 6
		l_s_parm += string(integer(this.object.date6[l_n_row]),"00")
	Case 7
		l_s_parm += string(integer(this.object.date7[l_n_row]),"00")
End Choose
if f_spacechk(f_Dateedit(l_s_parm)) <> -1 then
	em_date.text = l_s_parm
end if

end event

event losefocus;//parent.EVENT ue_visible()


end event

type gb_1 from groupbox within uo_calendar
integer y = 80
integer width = 1207
integer height = 616
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

