$PBExportHeader$w_bpm408i.srw
$PBExportComments$작업변경이력조회
forward
global type w_bpm408i from w_ipis_sheet01
end type
type uo_year from uo_ccyy_mps within w_bpm408i
end type
type dw_bpm408i_01 from u_vi_std_datawindow within w_bpm408i
end type
type st_1 from statictext within w_bpm408i
end type
type pb_down from picturebutton within w_bpm408i
end type
type uo_from from uo_today_bom within w_bpm408i
end type
type uo_to from uo_today_bom within w_bpm408i
end type
type st_2 from statictext within w_bpm408i
end type
type st_3 from statictext within w_bpm408i
end type
type st_4 from statictext within w_bpm408i
end type
type gb_1 from groupbox within w_bpm408i
end type
end forward

global type w_bpm408i from w_ipis_sheet01
uo_year uo_year
dw_bpm408i_01 dw_bpm408i_01
st_1 st_1
pb_down pb_down
uo_from uo_from
uo_to uo_to
st_2 st_2
st_3 st_3
st_4 st_4
gb_1 gb_1
end type
global w_bpm408i w_bpm408i

on w_bpm408i.create
int iCurrent
call super::create
this.uo_year=create uo_year
this.dw_bpm408i_01=create dw_bpm408i_01
this.st_1=create st_1
this.pb_down=create pb_down
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_year
this.Control[iCurrent+2]=this.dw_bpm408i_01
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.uo_from
this.Control[iCurrent+6]=this.uo_to
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.gb_1
end on

on w_bpm408i.destroy
call super::destroy
destroy(this.uo_year)
destroy(this.dw_bpm408i_01)
destroy(this.st_1)
destroy(this.pb_down)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_bpm408i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_bpm408i_01.Height= newheight - ( dw_bpm408i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;dw_bpm408i_01.settransobject(sqlca)

string ls_refyear

ls_refyear = Right(Message.StringParm,4)
//SELECT XYEAR INTO :ls_refyear
//FROM PBBPM.BPM519
//WHERE COMLTD = '01'
//ORDER BY XYEAR DESC, SEQNO ASC
//FETCH FIRST 1 ROW ONLY
//using sqlca;

if f_spacechk(ls_refyear) = -1 then
	uo_year.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
else
	uo_year.uf_reset(integer(ls_refyear))
end if
end event

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_revno, ls_divcode, ls_expcode, ls_from, ls_to

ls_year  = uo_year.uf_return()
ls_from		=	string(date(uo_from.is_uo_date),"yyyy-mm-dd")
ls_to		=	string(f_relativedate(string(date(uo_to.is_uo_date),"yyyymmdd"),1),"@@@@-@@-@@")

dw_bpm408i_01.reset()

if dw_bpm408i_01.retrieve(ls_year,'%',ls_from,ls_to) > 0 then
	uo_status.st_message.text = "작업이력이 조회되었습니다."
else
	uo_status.st_message.text = "조회된 작업이력이 없습니다."
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm408i
end type

type uo_year from uo_ccyy_mps within w_bpm408i
integer x = 379
integer y = 56
integer taborder = 10
boolean bringtotop = true
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

type dw_bpm408i_01 from u_vi_std_datawindow within w_bpm408i
integer x = 27
integer y = 192
integer width = 3534
integer height = 1608
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bpm_common_bpm521"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type st_1 from statictext within w_bpm408i
integer x = 69
integer y = 60
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
boolean focusrectangle = false
end type

type pb_down from picturebutton within w_bpm408i
integer x = 2665
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

event clicked;f_save_to_excel_number(dw_bpm408i_01)
end event

type uo_from from uo_today_bom within w_bpm408i
integer x = 1239
integer y = 64
integer taborder = 20
boolean bringtotop = true
end type

on uo_from.destroy
call uo_today_bom::destroy
end on

type uo_to from uo_today_bom within w_bpm408i
integer x = 2066
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call uo_today_bom::destroy
end on

type st_2 from statictext within w_bpm408i
integer x = 937
integer y = 68
integer width = 283
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
string text = "시작일자"
boolean focusrectangle = false
end type

type st_3 from statictext within w_bpm408i
integer x = 1778
integer y = 72
integer width = 274
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
string text = "완료일자"
boolean focusrectangle = false
end type

type st_4 from statictext within w_bpm408i
integer x = 1696
integer y = 72
integer width = 69
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bpm408i
integer x = 27
integer y = 16
integer width = 2583
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

