$PBExportHeader$w_bom118i.srw
$PBExportComments$신규등록품(INV101)
forward
global type w_bom118i from w_origin_sheet02
end type
type dw_part_report from datawindow within w_bom118i
end type
type uo_2 from uo_ccyymm_mps within w_bom118i
end type
type st_1 from statictext within w_bom118i
end type
type dw_1 from datawindow within w_bom118i
end type
type pb_excel from picturebutton within w_bom118i
end type
type gb_1 from groupbox within w_bom118i
end type
end forward

global type w_bom118i from w_origin_sheet02
integer height = 2712
dw_part_report dw_part_report
uo_2 uo_2
st_1 st_1
dw_1 dw_1
pb_excel pb_excel
gb_1 gb_1
end type
global w_bom118i w_bom118i

type variables
datastore ids_impdata[3]
string i_s_refdate,i_s_plant,i_s_div,i_s_pdcd,i_s_modstring,i_s_source
long i_l_currow
end variables

forward prototypes
public function decimal wf_get_yearqty (string a_xplant, string a_div, string a_itno, string a_date)
end prototypes

public function decimal wf_get_yearqty (string a_xplant, string a_div, string a_itno, string a_date);decimal {1} ln_inv402qty = 0,ln_inv101qty = 0
string	ls_date

ls_date	=	mid(a_date,1,4)	+	'%'

select	sum(intqty)	into :ln_inv402qty
	from 	pbinv.inv402
where		comltd	=	'01'		and	xplant	=	:a_xplant	and	
			div		=	:a_div	and	itno		=	:a_itno		and
			xyear	like	:ls_date
using	sqlca	;

if	sqlca.sqlcode	<> 	0	then
	ln_inv402qty	=	0
end if

if mid(a_date,1,6) >= mid(g_s_date,1,6) then
	select intqty	into :ln_inv101qty	
		from pbinv.inv101
	where comltd	=	'01'		and	xplant	=	:a_xplant	and
			div		=	:a_div	and	itno		=	:a_itno
	using	sqlca ;
	if	sqlca.sqlcode	<> 0	then
		ln_inv101qty	=	0
	end if
end if

return ln_inv402qty	+	ln_inv101qty
end function

on w_bom118i.create
int iCurrent
call super::create
this.dw_part_report=create dw_part_report
this.uo_2=create uo_2
this.st_1=create st_1
this.dw_1=create dw_1
this.pb_excel=create pb_excel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_part_report
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.pb_excel
this.Control[iCurrent+6]=this.gb_1
end on

on w_bom118i.destroy
call super::destroy
destroy(this.dw_part_report)
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.pb_excel)
destroy(this.gb_1)
end on

event open;call super::open;call super:: open;
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_insert = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;setpointer(hourglass!)
string ls_yyyymm
ls_yyyymm = uo_2.uf_yyyymm() + '%'
//ls_yearmonth = l_s_year + l_s_month 
uo_status.st_message.text = ""
dw_1.reset()
if dw_1.retrieve(ls_yyyymm) > 0 then
	uo_status.st_message.text = "조회 완료"
	pb_excel.enabled = true
else
	uo_status.st_message.text = "조회할 정보가 없습니다"	
	pb_excel.enabled = false
end if





// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_print = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
return 0

end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom118i
end type

type dw_part_report from datawindow within w_bom118i
boolean visible = false
integer x = 3227
integer y = 44
integer width = 256
integer height = 100
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_report_knockdown"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_2 from uo_ccyymm_mps within w_bom118i
event destroy ( )
integer x = 357
integer y = 72
integer taborder = 70
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyymm_mps::destroy
end on

event constructor;call super::constructor;this.uf_reset(integer(mid(g_s_date,1,4)),integer(mid(g_s_date,5,2)))

end event

type st_1 from statictext within w_bom118i
integer x = 78
integer y = 88
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_bom118i
integer x = 41
integer y = 216
integer width = 4462
integer height = 2260
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_bom118i_retrieve"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type pb_excel from picturebutton within w_bom118i
integer x = 4325
integer y = 56
integer width = 155
integer height = 132
integer taborder = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if  dw_1.rowcount() > 0 then
	f_Save_to_Excel_number(dw_1)
end if
end event

type gb_1 from groupbox within w_bom118i
integer x = 32
integer width = 4471
integer height = 196
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

