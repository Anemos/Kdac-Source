$PBExportHeader$w_comm107i.srw
$PBExportComments$�μ��� ����� ��Ȳ
forward
global type w_comm107i from w_origin_sheet05
end type
type st_1 from statictext within w_comm107i
end type
type pb_1 from picturebutton within w_comm107i
end type
type st_2 from statictext within w_comm107i
end type
type dw_1 from datawindow within w_comm107i
end type
type pb_excel from picturebutton within w_comm107i
end type
type pb_print from picturebutton within w_comm107i
end type
type dw_report from datawindow within w_comm107i
end type
type cbx_inq from checkbox within w_comm107i
end type
type cbx_save from checkbox within w_comm107i
end type
type st_3 from statictext within w_comm107i
end type
type sle_pgm from singlelineedit within w_comm107i
end type
type sle_dept from editmask within w_comm107i
end type
type gb_1 from groupbox within w_comm107i
end type
type gb_2 from groupbox within w_comm107i
end type
end forward

global type w_comm107i from w_origin_sheet05
event ue_keydown pbm_keydown
st_1 st_1
pb_1 pb_1
st_2 st_2
dw_1 dw_1
pb_excel pb_excel
pb_print pb_print
dw_report dw_report
cbx_inq cbx_inq
cbx_save cbx_save
st_3 st_3
sle_pgm sle_pgm
sle_dept sle_dept
gb_1 gb_1
gb_2 gb_2
end type
global w_comm107i w_comm107i

type variables
string is_grade = '%' ,is_pgmid = '%'
end variables

event ue_keydown;if	key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

on w_comm107i.create
int iCurrent
call super::create
this.st_1=create st_1
this.pb_1=create pb_1
this.st_2=create st_2
this.dw_1=create dw_1
this.pb_excel=create pb_excel
this.pb_print=create pb_print
this.dw_report=create dw_report
this.cbx_inq=create cbx_inq
this.cbx_save=create cbx_save
this.st_3=create st_3
this.sle_pgm=create sle_pgm
this.sle_dept=create sle_dept
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.pb_excel
this.Control[iCurrent+6]=this.pb_print
this.Control[iCurrent+7]=this.dw_report
this.Control[iCurrent+8]=this.cbx_inq
this.Control[iCurrent+9]=this.cbx_save
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.sle_pgm
this.Control[iCurrent+12]=this.sle_dept
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_comm107i.destroy
call super::destroy
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.pb_excel)
destroy(this.pb_print)
destroy(this.dw_report)
destroy(this.cbx_inq)
destroy(this.cbx_save)
destroy(this.st_3)
destroy(this.sle_pgm)
destroy(this.sle_dept)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;st_2.text	=	''
dw_1.reset()
st_2.text 	= 	f_get_Deptnm(trim(sle_dept.text),'5')

if 	cbx_inq.checked = true then
	is_grade = '1%'
	if 	cbx_save.checked = true then
		is_grade = '%'
	end if
elseif cbx_save.checked = true then
	is_grade = '5%'
	if 	cbx_inq.checked = true then
		is_grade = '%'
	end if
end if
if 	f_spacechk(trim(sle_pgm.text)) <> -1 then
	is_pgmid = '%' + trim(sle_pgm.text) + '%'
else
	is_pgmid = '%'
end if
f_pism_working_msg(This.title,"�μ��� ����� ������ ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.") 

pb_excel.visible	= 	false
pb_excel.enabled 	= 	false
pb_print.visible 	= 	false
pb_print.enabled 	= 	false
if 	dw_1.retrieve(trim(sle_dept.text) + '%' ,is_grade,is_pgmid) > 0 then
	uo_status.st_message.text	=	f_message("I010")
	pb_excel.visible 	= 	true
	pb_excel.enabled 	= 	true
	pb_print.visible 	= 	true
	pb_print.enabled 	= 	true
else
	uo_status.st_message.text	=	f_message("I020")
end if

If	IsValid(w_pism_working) Then Close(w_pism_working)
end event

event open;call super::open;pb_excel.visible 		= 	false
pb_excel.enabled 		= 	false
pb_print.visible			= 	false
pb_print.enabled 		= 	false
if	trim(gs_userlevel)		>	'1'		then
	sle_dept.text			=	g_s_deptcd
	sle_dept.enabled 		= 	false
	sle_dept.backcolor 	= 	rgb(128,128,128)
	sle_pgm.setfocus() 
else
	sle_dept.text			=	''
	sle_dept.enabled 		= 	true
	sle_dept.backcolor 	= 	rgb(255,255,255)
	sle_dept.setfocus() 
end if
pb_1.visible 				= 	true
pb_1.enabled 			= 	true
st_2.text					=	f_get_Deptnm(trim(sle_dept.text),'5')
end event

type uo_status from w_origin_sheet05`uo_status within w_comm107i
integer y = 2464
end type

type st_1 from statictext within w_comm107i
integer x = 50
integer y = 60
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
string text = "�μ��ڵ�"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_comm107i
integer x = 1714
integer y = 48
integer width = 238
integer height = 108
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;String ls_parm

ls_parm = ' I'

openwithparm(w_find_001 , ls_parm)
ls_parm	=	message.stringparm

if 	f_spacechk(ls_parm) <> -1 then
	st_2.text 	= 	''
	st_2.text 	= 	mid(ls_parm,16,30)
	sle_dept.text	=	trim(mid(ls_parm,1,5))
end if

return 	0
end event

type st_2 from statictext within w_comm107i
integer x = 686
integer y = 52
integer width = 1006
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_comm107i
integer x = 18
integer y = 184
integer width = 4585
integer height = 2244
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_comm107i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type pb_excel from picturebutton within w_comm107i
integer x = 4411
integer y = 20
integer width = 174
integer height = 144
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

event clicked;f_save_to_Excel(dw_1)
end event

type pb_print from picturebutton within w_comm107i
integer x = 4192
integer y = 20
integer width = 174
integer height = 144
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\lprinter.bmp"
alignment htextalign = left!
end type

event clicked;dw_report.reset()
if 	cbx_inq.checked = true then
	is_grade = '1%'
	if 	cbx_save.checked = true then
		is_grade = '%'
	end if
elseif cbx_save.checked = true then
	is_grade = '5%'
	if 	cbx_inq.checked = true then
		is_grade = '%'
	end if
end if
if 	f_spacechk(trim(sle_pgm.text)) <> -1 then
	is_pgmid = '%' + trim(sle_pgm.text) + '%'
else
	is_pgmid = '%'
end if
if 	dw_report.retrieve(trim(sle_Dept.text) + '%' ,is_grade,is_pgmid) > 0 then
	dw_report.print()
else
	messagebox("Ȯ��","�Է��Ͻ� �μ��ڵ�( " + trim(sle_Dept.text) + " ) �� ����� ������ �����ϴ�")
end if

end event

type dw_report from datawindow within w_comm107i
boolean visible = false
integer x = 4046
integer y = 120
integer width = 686
integer height = 400
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_comm107i_01_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

type cbx_inq from checkbox within w_comm107i
integer x = 3296
integer y = 56
integer width = 347
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
string text = "��ȸ���"
boolean checked = true
end type

type cbx_save from checkbox within w_comm107i
integer x = 3703
integer y = 56
integer width = 347
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
string text = "������"
boolean checked = true
end type

type st_3 from statictext within w_comm107i
integer x = 2085
integer y = 60
integer width = 389
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
string text = "���α׷� ID"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_pgm from singlelineedit within w_comm107i
integer x = 2496
integer y = 52
integer width = 617
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

type sle_dept from editmask within w_comm107i
integer x = 320
integer y = 52
integer width = 338
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!"
boolean autoskip = true
end type

type gb_1 from groupbox within w_comm107i
integer x = 23
integer width = 3150
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_comm107i
integer x = 3205
integer width = 896
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

