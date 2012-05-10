$PBExportHeader$uo_ccyymm_mps.sru
$PBExportComments$년월 증감(yyyymm)
forward
global type uo_ccyymm_mps from userobject
end type
type vsb_1 from vscrollbar within uo_ccyymm_mps
end type
type st_yyyymm from statictext within uo_ccyymm_mps
end type
end forward

shared variables

end variables

global type uo_ccyymm_mps from userobject
integer width = 521
integer height = 96
long backcolor = 12632256
long tabtextcolor = 16777215
long tabbackcolor = 16711680
long picturemaskcolor = 536870912
event ue_modify ( integer yyyy,  integer mm )
vsb_1 vsb_1
st_yyyymm st_yyyymm
end type
global uo_ccyymm_mps uo_ccyymm_mps

type variables
integer i_n_yyyy, i_n_mm
end variables

forward prototypes
public function string uf_yyyymm ()
public subroutine uf_reset (integer a_n_yyyy, integer a_n_mm)
end prototypes

public function string uf_yyyymm ();string l_s_ccyymm

l_s_ccyymm = string(i_n_yyyy * 100 + i_n_mm)

return l_s_ccyymm
end function

public subroutine uf_reset (integer a_n_yyyy, integer a_n_mm);i_n_yyyy = a_n_yyyy   // 공유 날자 입력...
i_n_mm   = a_n_mm

st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
return
end subroutine

on uo_ccyymm_mps.create
this.vsb_1=create vsb_1
this.st_yyyymm=create st_yyyymm
this.Control[]={this.vsb_1,&
this.st_yyyymm}
end on

on uo_ccyymm_mps.destroy
destroy(this.vsb_1)
destroy(this.st_yyyymm)
end on

event constructor;string l_s_date
l_s_date = uf_add_month_mps(mid(g_s_date,1,6),1)
this.uf_reset(integer(mid(l_s_date,1,4)),integer(mid(l_s_date,5,2)))

end event

type vsb_1 from vscrollbar within uo_ccyymm_mps
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
integer x = 430
integer width = 73
integer height = 80
boolean bringtotop = true
boolean stdwidth = false
end type

event linedown;i_n_mm --
if i_n_mm < 1 then
	i_n_yyyy --
	i_n_mm = 12
end if
st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
parent.event post ue_modify(i_n_yyyy, i_n_mm)					


end event

event lineup;i_n_mm ++
if i_n_mm > 12 then
	i_n_yyyy ++
	i_n_mm = 1
end if
st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
parent.event post ue_modify(i_n_yyyy, i_n_mm)					

end event

type st_yyyymm from statictext within uo_ccyymm_mps
integer width = 434
integer height = 84
boolean bringtotop = true
integer textsize = -10
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

