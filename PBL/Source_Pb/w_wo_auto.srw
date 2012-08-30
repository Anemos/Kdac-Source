$PBExportHeader$w_wo_auto.srw
$PBExportComments$작업명령 분류
forward
global type w_wo_auto from window
end type
type cb_2 from commandbutton within w_wo_auto
end type
type cb_1 from commandbutton within w_wo_auto
end type
type dw_1 from uo_datawindow within w_wo_auto
end type
end forward

global type w_wo_auto from window
integer width = 1792
integer height = 944
boolean titlebar = true
string title = "다음작명번호"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_wo_auto w_wo_auto

on w_wo_auto.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_wo_auto.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_orgsql, ls_where2

//ls_where2= " where wo_autonumber.area_code='" + gs_kmarea +"' and wo_autonumber.factory_code='"+gs_kmdivision+"'"

f_win_center(this)

dw_1.settransobject(sqlcmms)
//ls_orgsql = dw_1.object.datawindow.table.select
//dw_1.object.datawindow.table.select = ls_orgsql + ls_where2
dw_1.retrieve(gs_kmarea, gs_kmdivision)
//dw_1.object.datawindow.table.select = ls_orgsql




end event

type cb_2 from commandbutton within w_wo_auto
integer x = 910
integer y = 728
integer width = 402
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_wo_auto
integer x = 471
integer y = 728
integer width = 402
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "선택"
boolean default = true
end type

event clicked;string aaa, ls_no_code, ls_next, ls_dummy, ls_dummy1,ls_dummy2,ls_dummy3, ls_date
long ll_count, ll_count1

if dw_1.getrow() < 1 then return 0

aaa = dw_1.getitemstring(dw_1.getrow(),'no_code')

CloseWithReturn(parent, aaa)
end event

type dw_1 from uo_datawindow within w_wo_auto
integer width = 1778
integer height = 688
integer taborder = 20
string dataobject = "d_wo_auto"
boolean ib_enter = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_excel = false
boolean ib_print = false
boolean ib_toggle = false
boolean ib_date = false
end type

