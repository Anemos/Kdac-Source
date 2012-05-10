$PBExportHeader$uo_comm_yymm.sru
$PBExportComments$년월 증감(yyyymm)
forward
global type uo_comm_yymm from userobject
end type
type vsb_1 from vscrollbar within uo_comm_yymm
end type
type st_yyyymm from statictext within uo_comm_yymm
end type
end forward

shared variables

end variables

global type uo_comm_yymm from userobject
integer width = 507
integer height = 96
long backcolor = 12632256
long tabtextcolor = 16777215
long tabbackcolor = 16711680
long picturemaskcolor = 536870912
event ue_modify ( integer yyyy,  integer mm )
event ue_keydown pbm_keydown
vsb_1 vsb_1
st_yyyymm st_yyyymm
end type
global uo_comm_yymm uo_comm_yymm

type variables
integer i_n_yyyy, i_n_mm
end variables

forward prototypes
public subroutine uf_reset (integer a_n_yyyy, integer a_n_mm)
public function decimal uf_yyyymm ()
end prototypes

public subroutine uf_reset (integer a_n_yyyy, integer a_n_mm);i_n_yyyy = a_n_yyyy   // 공유 날자 입력...
i_n_mm   = a_n_mm

st_yyyymm.text = string(i_n_yyyy) + "년"  & 
               + right( space(1) + trim(string(i_n_mm)), 2) + "월"
return
end subroutine

public function decimal uf_yyyymm ();return i_n_yyyy * 100 + i_n_mm
end function

on uo_comm_yymm.create
this.vsb_1=create vsb_1
this.st_yyyymm=create st_yyyymm
this.Control[]={this.vsb_1,&
this.st_yyyymm}
end on

on uo_comm_yymm.destroy
destroy(this.vsb_1)
destroy(this.st_yyyymm)
end on

type vsb_1 from vscrollbar within uo_comm_yymm
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
integer x = 430
integer width = 73
integer height = 96
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

type st_yyyymm from statictext within uo_comm_yymm
event ue_keydown pbm_keydown
integer width = 434
integer height = 96
integer taborder = 1
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HourGlass!"
long backcolor = 15780518
boolean enabled = false
string text = "    년  월"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event ue_keydown;if 	key = keyenter!	then
	window	ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

