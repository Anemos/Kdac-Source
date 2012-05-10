$PBExportHeader$uo_yymm_boongi.sru
$PBExportComments$년월 증감(yyyymm)- 분기별
forward
global type uo_yymm_boongi from userobject
end type
type vsb_1 from vscrollbar within uo_yymm_boongi
end type
type st_yyyymm from statictext within uo_yymm_boongi
end type
end forward

shared variables

end variables

global type uo_yymm_boongi from userobject
integer width = 507
integer height = 100
long backcolor = 12632256
long tabtextcolor = 16777215
long tabbackcolor = 16711680
long picturemaskcolor = 536870912
event ue_modify ( integer yyyy,  integer mm )
vsb_1 vsb_1
st_yyyymm st_yyyymm
end type
global uo_yymm_boongi uo_yymm_boongi

type variables
integer i_n_yyyy, i_n_mm
end variables

forward prototypes
public function decimal uf_yyyymm ()
public subroutine uf_reset (integer a_n_yyyy, integer a_n_mm)
end prototypes

public function decimal uf_yyyymm ();return i_n_yyyy * 100 + i_n_mm
end function

public subroutine uf_reset (integer a_n_yyyy, integer a_n_mm);i_n_yyyy = a_n_yyyy   // 공유 날자 입력...
i_n_mm   = a_n_mm

st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
return
end subroutine

on uo_yymm_boongi.create
this.vsb_1=create vsb_1
this.st_yyyymm=create st_yyyymm
this.Control[]={this.vsb_1,&
this.st_yyyymm}
end on

on uo_yymm_boongi.destroy
destroy(this.vsb_1)
destroy(this.st_yyyymm)
end on

event constructor;dec{1} l_n_month
integer l_n_year

l_n_year  = integer(mid(g_s_date,1,4))
l_n_month =  integer(mid(g_s_date,5,2)) / 3 
if l_n_month <= 1 then
	l_n_year  -= 1
	l_n_month = 12
elseif l_n_month <= 2 then
	l_n_month = 3
elseif l_n_month <= 3 then
	l_n_month = 6
elseif l_n_month <= 4 then
	l_n_month = 9
end if

uf_reset(l_n_year,l_n_month)
end event

type vsb_1 from vscrollbar within uo_yymm_boongi
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
integer x = 430
integer width = 73
integer height = 88
boolean bringtotop = true
boolean stdwidth = false
end type

event linedown;i_n_mm = i_n_mm - 3
if i_n_mm < 1 then
	i_n_yyyy --
	i_n_mm = 12
end if
st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
parent.event post ue_modify(i_n_yyyy, i_n_mm)					


end event

event lineup;i_n_mm = i_n_mm + 3
if i_n_mm > 12 then
	i_n_yyyy ++
	i_n_mm = 3
end if
st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
parent.event post ue_modify(i_n_yyyy, i_n_mm)					

end event

type st_yyyymm from statictext within uo_yymm_boongi
integer width = 434
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HourGlass!"
long backcolor = 15793151
boolean enabled = false
string text = "    년  월"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

