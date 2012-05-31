$PBExportHeader$uo_ccyy_mps.sru
$PBExportComments$년 증감(yyyy)
forward
global type uo_ccyy_mps from userobject
end type
type vsb_1 from vscrollbar within uo_ccyy_mps
end type
type st_yyyymm from statictext within uo_ccyy_mps
end type
end forward

shared variables

end variables

global type uo_ccyy_mps from userobject
integer width = 407
integer height = 92
long backcolor = 12632256
long tabtextcolor = 16777215
long tabbackcolor = 16711680
long picturemaskcolor = 536870912
event ue_modify ( integer yyyy )
event ue_keydown pbm_keydown
vsb_1 vsb_1
st_yyyymm st_yyyymm
end type
global uo_ccyy_mps uo_ccyy_mps

type variables
integer in_yyyy, in_mm
end variables

forward prototypes
public subroutine uf_reset (integer a_n_yyyy)
public function string uf_return ()
end prototypes

public subroutine uf_reset (integer a_n_yyyy);in_yyyy = a_n_yyyy   // 공유 날자 입력...
st_yyyymm.text = string(in_yyyy) + "년" 
return
end subroutine

public function string uf_return ();return string(in_yyyy)
end function

on uo_ccyy_mps.create
this.vsb_1=create vsb_1
this.st_yyyymm=create st_yyyymm
this.Control[]={this.vsb_1,&
this.st_yyyymm}
end on

on uo_ccyy_mps.destroy
destroy(this.vsb_1)
destroy(this.st_yyyymm)
end on

event constructor;this.uf_reset(integer(mid(g_s_date,1,4)) + 1)

end event

type vsb_1 from vscrollbar within uo_ccyy_mps
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
integer x = 334
integer width = 69
integer height = 80
boolean bringtotop = true
boolean stdwidth = false
end type

event linedown;in_yyyy --
st_yyyymm.text = string(in_yyyy)  + "년"
parent.event post ue_modify(in_yyyy)					


end event

event lineup;in_yyyy ++
st_yyyymm.text = string(in_yyyy) + "년" 
parent.event post ue_modify(in_yyyy)					

end event

type st_yyyymm from statictext within uo_ccyy_mps
event ue_keydown pbm_keydown
integer width = 329
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HourGlass!"
long backcolor = 15780518
boolean enabled = false
string text = "    년"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event ue_keydown;if key = keyenter!	then
	window 	ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

