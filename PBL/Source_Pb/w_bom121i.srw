$PBExportHeader$w_bom121i.srw
$PBExportComments$BOM변경이력조회
forward
global type w_bom121i from w_ipis_sheet01
end type
type dw_bom121i_01 from u_vi_std_datawindow within w_bom121i
end type
type pb_down from picturebutton within w_bom121i
end type
type uo_1 from uo_plandiv_bom within w_bom121i
end type
type st_1 from statictext within w_bom121i
end type
type sle_itno from singlelineedit within w_bom121i
end type
type st_2 from statictext within w_bom121i
end type
type sle_empno from singlelineedit within w_bom121i
end type
type pb_find from picturebutton within w_bom121i
end type
type gb_1 from groupbox within w_bom121i
end type
end forward

global type w_bom121i from w_ipis_sheet01
integer width = 3803
integer height = 2516
dw_bom121i_01 dw_bom121i_01
pb_down pb_down
uo_1 uo_1
st_1 st_1
sle_itno sle_itno
st_2 st_2
sle_empno sle_empno
pb_find pb_find
gb_1 gb_1
end type
global w_bom121i w_bom121i

on w_bom121i.create
int iCurrent
call super::create
this.dw_bom121i_01=create dw_bom121i_01
this.pb_down=create pb_down
this.uo_1=create uo_1
this.st_1=create st_1
this.sle_itno=create sle_itno
this.st_2=create st_2
this.sle_empno=create sle_empno
this.pb_find=create pb_find
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bom121i_01
this.Control[iCurrent+2]=this.pb_down
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_itno
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_empno
this.Control[iCurrent+8]=this.pb_find
this.Control[iCurrent+9]=this.gb_1
end on

on w_bom121i.destroy
call super::destroy
destroy(this.dw_bom121i_01)
destroy(this.pb_down)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.sle_itno)
destroy(this.st_2)
destroy(this.sle_empno)
destroy(this.pb_find)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_bom121i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bom121i_01.Height= newheight - ( dw_bom121i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_bom121i_01.settransobject(sqlca)
end event

event ue_retrieve;call super::ue_retrieve;string ls_from, ls_to, ls_rtncd, ls_plant, ls_div, ls_itno, ls_empno

ls_rtncd = uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div = mid(ls_rtncd,2,1)

//ls_from		=	string(date(uo_from.is_uo_date),"yyyy-mm-dd")
//ls_to		=	string(f_relativedate(string(date(uo_to.is_uo_date),"yyyymmdd"),1),"@@@@-@@-@@")
ls_itno = sle_itno.text
ls_empno = sle_empno.text

if f_spacechk(ls_itno) = -1 and f_spacechk(ls_empno) = -1 then
	uo_status.st_message.text = "품번 또는 수정자를 입력바랍니다."
	return -1
end if

if f_spacechk(ls_itno) <> -1 then
	select itno into :ls_itno
	from pbinv.inv101
	where comltd = '01' and xplant = :ls_plant and
		div = :ls_div and itno = :ls_itno
	using sqlca;
	
	if f_spacechk(ls_itno) = -1 then
		uo_status.st_message.text = "등록된 품번이 아닙니다.."
		return -1
	end if
	ls_itno = ls_itno + '%'
else
	ls_itno = '%'
end if

if f_spacechk(ls_empno) <> -1 then
	select peempno into :ls_empno
	from pbcommon.dac003
	where peempno = :ls_empno
	using sqlca;
	if f_spacechk(ls_empno) = -1 then
		uo_status.st_message.text = "등록된 품번이 아닙니다.."
		return -1
	end if
	ls_empno = ls_empno + '%'
else
	ls_empno = '%'
end if

dw_bom121i_01.reset()

if dw_bom121i_01.retrieve(ls_plant,ls_div,ls_itno,ls_empno) > 0 then
	uo_status.st_message.text = "작업이력이 조회되었습니다."
else
	uo_status.st_message.text = "조회된 작업이력이 없습니다."
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_bom121i
end type

type dw_bom121i_01 from u_vi_std_datawindow within w_bom121i
integer x = 27
integer y = 192
integer width = 3534
integer height = 1608
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bom121i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type pb_down from picturebutton within w_bom121i
integer x = 3479
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

event clicked;f_save_to_excel_number(dw_bom121i_01)
end event

type uo_1 from uo_plandiv_bom within w_bom121i
integer x = 96
integer y = 40
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type st_1 from statictext within w_bom121i
integer x = 1440
integer y = 68
integer width = 206
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번:"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_bom121i
integer x = 1646
integer y = 56
integer width = 576
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_bom121i
integer x = 2373
integer y = 68
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "수정자:"
boolean focusrectangle = false
end type

type sle_empno from singlelineedit within w_bom121i
integer x = 2619
integer y = 56
integer width = 517
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type pb_find from picturebutton within w_bom121i
integer x = 3177
integer y = 48
integer width = 238
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_rtn

openwithparm(w_bom_find_empno, '')
ls_rtn = message.stringparm

sle_empno.text = ls_rtn
end event

type gb_1 from groupbox within w_bom121i
integer x = 27
integer y = 16
integer width = 3424
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

