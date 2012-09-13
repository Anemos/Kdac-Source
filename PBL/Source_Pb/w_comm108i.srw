$PBExportHeader$w_comm108i.srw
$PBExportComments$»ç¿ëÀÚ Á¢¼ÓÇöÈ²
forward
global type w_comm108i from w_origin_sheet05
end type
type dw_1 from datawindow within w_comm108i
end type
type pb_excel from picturebutton within w_comm108i
end type
type uo_fromdate from uo_today_kdac within w_comm108i
end type
type uo_todate from uo_today_kdac within w_comm108i
end type
type st_1 from statictext within w_comm108i
end type
type st_2 from statictext within w_comm108i
end type
type st_3 from statictext within w_comm108i
end type
type ddlb_gubun from dropdownlistbox within w_comm108i
end type
type st_4 from statictext within w_comm108i
end type
type sle_empno from singlelineedit within w_comm108i
end type
type pb_find from picturebutton within w_comm108i
end type
type st_5 from statictext within w_comm108i
end type
type sle_ipaddr from singlelineedit within w_comm108i
end type
type gb_1 from groupbox within w_comm108i
end type
end forward

global type w_comm108i from w_origin_sheet05
event ue_keydown pbm_keydown
dw_1 dw_1
pb_excel pb_excel
uo_fromdate uo_fromdate
uo_todate uo_todate
st_1 st_1
st_2 st_2
st_3 st_3
ddlb_gubun ddlb_gubun
st_4 st_4
sle_empno sle_empno
pb_find pb_find
st_5 st_5
sle_ipaddr sle_ipaddr
gb_1 gb_1
end type
global w_comm108i w_comm108i

type variables
string is_grade = '%' ,is_pgmid = '%'
end variables

event ue_keydown;if 	key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

on w_comm108i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_excel=create pb_excel
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.ddlb_gubun=create ddlb_gubun
this.st_4=create st_4
this.sle_empno=create sle_empno
this.pb_find=create pb_find
this.st_5=create st_5
this.sle_ipaddr=create sle_ipaddr
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_excel
this.Control[iCurrent+3]=this.uo_fromdate
this.Control[iCurrent+4]=this.uo_todate
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.ddlb_gubun
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.sle_empno
this.Control[iCurrent+11]=this.pb_find
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.sle_ipaddr
this.Control[iCurrent+14]=this.gb_1
end on

on w_comm108i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.pb_excel)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.ddlb_gubun)
destroy(this.st_4)
destroy(this.sle_empno)
destroy(this.pb_find)
destroy(this.st_5)
destroy(this.sle_ipaddr)
destroy(this.gb_1)
end on

event open;call super::open;pb_excel.visible 	=	false
pb_excel.enabled 	= 	false 
 
end event

event ue_retrieve;call super::ue_retrieve;string		ls_fromdate,ls_todate
string		ls_gubun,ls_empno,ls_ipaddr

dw_1.reset()
ls_fromdate		=	uo_fromdate.is_uo_date
ls_todate			=	uo_todate.is_uo_date
if	ddlb_gubun.text	=	'ÀüÃ¼'	then
	ls_gubun				=	'%'
elseif ddlb_gubun.text	=	'Log-In'	then
	ls_gubun				=	'I%'
elseif ddlb_gubun.text	=	'Log-Out'	then
	ls_gubun				=	'O%'	
elseif ddlb_gubun.text	=	'Log-In½ÇÆÐ'	then
	ls_gubun				=	'F%'
end if
if	f_spacechk(sle_empno.text)	=	-1	then
	ls_empno	=	'%'
else
	ls_empno	=	trim(sle_empno.text) + '%'
end if
if	f_spacechk(sle_ipaddr.text)	=	-1	then
	ls_ipaddr	=	'%'
else
	ls_ipaddr	=	trim(sle_ipaddr.text) + '%'
end if

if	dw_1.retrieve(date(ls_fromdate),date(ls_todate),ls_gubun,ls_empno,ls_ipaddr)	<	1	then
	uo_status.st_message.text	=	'Á¶È¸ÇÒ Á¤º¸°¡ ¾ø½À´Ï´Ù'
	pb_excel.visible 	= 	false
	pb_excel.enabled 	=	false
else
	uo_status.st_message.text 	= 	"  " + string(dw_1.rowcount()) + ' °Ç Á¶È¸¿Ï·á'
	pb_excel.visible 	=	true
	pb_excel.enabled 	= 	true
end if
	
end event

type uo_status from w_origin_sheet05`uo_status within w_comm108i
integer y = 2464
end type

type dw_1 from datawindow within w_comm108i
integer x = 37
integer y = 180
integer width = 3854
integer height = 2272
boolean bringtotop = true
string dataobject = "d_comm008i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if row	<	1	then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type pb_excel from picturebutton within w_comm108i
integer x = 3904
integer y = 40
integer width = 174
integer height = 124
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

event clicked;f_save_to_Excel_number(dw_1)

end event

type uo_fromdate from uo_today_kdac within w_comm108i
event destroy ( )
integer x = 402
integer y = 64
integer taborder = 20
boolean bringtotop = true
end type

on uo_fromdate.destroy
call uo_today_kdac::destroy
end on

type uo_todate from uo_today_kdac within w_comm108i
event destroy ( )
integer x = 914
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_todate.destroy
call uo_today_kdac::destroy
end on

type st_1 from statictext within w_comm108i
integer x = 73
integer y = 64
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "Á¢¼ÓÀÏÀÚ :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_comm108i
integer x = 846
integer y = 68
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "»õ±¼¸²"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_comm108i
integer x = 1358
integer y = 64
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "Á¢¼Ó±¸ºÐ :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_comm108i
integer x = 1682
integer y = 56
integer width = 549
integer height = 324
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 15780518
boolean sorted = false
string item[] = {"ÀüÃ¼","Log-In","Log-Out","Log-In½ÇÆÐ"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text	=	'ÀüÃ¼'
end event

type st_4 from statictext within w_comm108i
integer x = 2240
integer y = 64
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "»ç¿ëÀÚ :"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_empno from singlelineedit within w_comm108i
integer x = 2496
integer y = 64
integer width = 402
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type pb_find from picturebutton within w_comm108i
integer x = 2935
integer y = 52
integer width = 238
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "»õ±¼¸²"
string picturename = "C:\KDAC\bmp\search.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;String	ls_parm

openwithparm(w_dacmaq_find,ls_parm)
ls_parm	=	message.stringparm
if 	f_spacechk(ls_parm) <> -1 then
	sle_empno.text = mid(ls_parm,1,6)
else
	sle_empno.text = ''
end if
end event

type st_5 from statictext within w_comm108i
integer x = 3182
integer y = 68
integer width = 174
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "IP :"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_ipaddr from singlelineedit within w_comm108i
integer x = 3328
integer y = 68
integer width = 526
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_comm108i
integer x = 37
integer width = 3854
integer height = 172
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "»õ±¼¸²"
long textcolor = 33554432
long backcolor = 12632256
end type

