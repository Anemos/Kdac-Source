$PBExportHeader$w_pisf014.srw
$PBExportComments$EIS데이타입력윈도우
forward
global type w_pisf014 from w_cmms_sheet01
end type
type st_2 from statictext within w_pisf014
end type
type dw_2 from uo_datawindow within w_pisf014
end type
type st_1 from statictext within w_pisf014
end type
type dw_1 from uo_datawindow within w_pisf014
end type
end forward

global type w_pisf014 from w_cmms_sheet01
string title = "EIS 데이터 입력"
st_2 st_2
dw_2 dw_2
st_1 st_1
dw_1 dw_1
end type
global w_pisf014 w_pisf014

type variables
datawindow id_dw_current

string is_original_sql_list 
string is_original_sql_property 
string is_original_sql_1 
string is_original_sql_2 
end variables

on w_pisf014.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_pisf014.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;setnull(id_dw_current)


	dw_1.settransobject(sqleis)
	dw_2.settransobject(sqleis)
	this.triggerevent('ue_retrieve')

end event

event resize;call super::resize;dw_1.width = newwidth
dw_2.width = newwidth
dw_2.height = newheight - 1220
end event

event ue_insert;call super::ue_insert;long ll_row
datawindow ld_dw

if isnull(id_dw_current) then return
ld_dw = id_dw_current
	
ll_Row = ld_dw.InsertRow(0)
ld_dw.SetRow(ll_Row)
ld_dw.ScrollToRow(ll_Row)
ld_dw.SetFocus()
ld_dw.setitem(ld_dw.getrow(),'area_code',gs_kmarea)
ld_dw.setitem(ld_dw.getrow(),'factory_code',gs_kmdivision)


end event

event ue_delete;call super::ue_delete;long ll_row

if not IsNull(id_dw_current) then
	ll_row = id_dw_current.GetRow()
	if ll_row > 0 then
		id_dw_current.DeleteRow(ll_row)
	end if
end if
ib_data_changed = true
end event

event ue_save;call super::ue_save;if dw_1.update() = - 1 then
	return 0
end if

if dw_2.update() = - 1 then
	return 0
end if
return 1
end event

event ue_retrieve;call super::ue_retrieve;dw_1.retrieve(gs_kmarea,gs_kmdivision)
dw_2.retrieve(gs_kmarea,gs_kmdivision)
end event

event activate;call super::activate;
end event

type st_2 from statictext within w_pisf014
integer x = 32
integer y = 1128
integer width = 658
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "EIS 기초데이터 입력 : "
boolean focusrectangle = false
end type

type dw_2 from uo_datawindow within w_pisf014
integer y = 1204
integer width = 2245
integer height = 996
integer taborder = 20
string dataobject = "dw_basis"
boolean ib_select_row = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_excel = false
boolean ib_print = false
boolean ib_toggle = false
boolean ib_date = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

type st_1 from statictext within w_pisf014
integer x = 23
integer y = 32
integer width = 827
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "설비고장율 계획 입력 : "
boolean focusrectangle = false
end type

type dw_1 from uo_datawindow within w_pisf014
integer y = 108
integer width = 2245
integer height = 996
integer taborder = 10
string dataobject = "dw_goal"
boolean ib_select_row = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_excel = false
boolean ib_print = false
boolean ib_toggle = false
boolean ib_date = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

