$PBExportHeader$w_piss001i.srw
$PBExportComments$Tshipsheet Interface Error Window
forward
global type w_piss001i from w_origin_sheet05
end type
type ddlb_table from dropdownlistbox within w_piss001i
end type
type dw_1 from datawindow within w_piss001i
end type
type pb_excel from picturebutton within w_piss001i
end type
end forward

global type w_piss001i from w_origin_sheet05
string tag = "입고,출하 Interface"
integer width = 4667
string title = "입고,출하 Interface"
event ue_keydown pbm_keydown
ddlb_table ddlb_table
dw_1 dw_1
pb_excel pb_excel
end type
global w_piss001i w_piss001i

type variables
string is_areacode,is_divisioncode
long in_index = 1
end variables

event ue_keydown;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if



end event

on w_piss001i.create
int iCurrent
call super::create
this.ddlb_table=create ddlb_table
this.dw_1=create dw_1
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_table
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.pb_excel
end on

on w_piss001i.destroy
call super::destroy
destroy(this.ddlb_table)
destroy(this.dw_1)
destroy(this.pb_excel)
end on

event ue_retrieve;call super::ue_retrieve;integer ln_count

f_pism_working_msg(This.title, ddlb_table.text + " 오류사항을(를) 조회중입니다. 잠시만 기다려 주십시오.") 
If IsValid(w_pism_working) Then Close(w_pism_working) 
ln_count = dw_1.retrieve()

if ln_count > 0 then
	pb_excel.enabled = true
	pb_excel.visible = true
	uo_status.st_message.text = f_message("I010")
else
	pb_excel.enabled = false
	pb_excel.visible = false
	uo_status.st_message.text = f_message("I020")
end if
end event

event open;call super::open;sqlxx = CREATE transaction
sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
sqlxx.ServerName = "192.168.103.249,1433"
sqlxx.Database   = "INTERFACE"
sqlxx.LogId      = "sa"
sqlxx.LogPass    = "goipis"
connect using sqlxx;
if sqlxx.sqlcode <> 0 then
	messagebox('경고',  'Interface 서버가 연결되지 않습니다.')
	disconnect using sqlxx ;
   return
end if
pb_excel.enabled = false
pb_excel.visible = false


end event

event closequery;call super::closequery;disconnect using sqlxx ;
destroy sqlxx 
end event

type uo_status from w_origin_sheet05`uo_status within w_piss001i
integer y = 2448
end type

type ddlb_table from dropdownlistbox within w_piss001i
integer x = 32
integer y = 20
integer width = 873
integer height = 348
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
boolean sorted = false
boolean vscrollbar = true
string item[] = {"출하취소","사내출하","이체","출하","제품입고","제품입고취소"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_1.dataobject = 'd_piss_001i_' + string(index,"00")
in_index = index
dw_1.settransobject(sqlxx)
parent.triggerevent("ue_retrieve")



end event

type dw_1 from datawindow within w_piss001i
integer x = 32
integer y = 136
integer width = 4571
integer height = 2288
integer taborder = 20
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_piss001i
integer x = 4448
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_Excel(dw_1)
end event

