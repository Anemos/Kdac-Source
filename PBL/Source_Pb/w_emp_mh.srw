$PBExportHeader$w_emp_mh.srw
forward
global type w_emp_mh from window
end type
type dw_1 from datawindow within w_emp_mh
end type
end forward

global type w_emp_mh from window
integer width = 2272
integer height = 952
boolean titlebar = true
string title = "당일M/H조회"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_emp_mh w_emp_mh

on w_emp_mh.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_emp_mh.destroy
destroy(this.dw_1)
end on

event open;string aaa,bbb
bbb=message.stringparm
dw_1.settransobject(sqlcmms)

//aaa=dw_1.object.datawindow.table.select

//dw_1.object.datawindow.table.select = aaa+" and wo_emp.emp_code = '" +bbb+"' and convert(varchar(10),wo.wo_acc_date,120) = convert(varchar(10),getdate(),120) and wo.area_code='"+gs_kmarea+"' and wo.factory_code='"+gs_kmdivision+"'"
dw_1.retrieve(bbb,gs_kmarea,gs_kmdivision)
end event

type dw_1 from datawindow within w_emp_mh
integer width = 2231
integer height = 836
integer taborder = 10
string dataobject = "d_emp_mh"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

