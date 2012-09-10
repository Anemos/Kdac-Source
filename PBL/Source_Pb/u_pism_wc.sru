$PBExportHeader$u_pism_wc.sru
$PBExportComments$조선택 : 조코드포함
forward
global type u_pism_wc from userobject
end type
type st_1 from statictext within u_pism_wc
end type
type dw_wc from datawindow within u_pism_wc
end type
type gb_wc from groupbox within u_pism_wc
end type
end forward

global type u_pism_wc from userobject
integer width = 1271
integer height = 168
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
dw_wc dw_wc
gb_wc gb_wc
end type
global u_pism_wc u_pism_wc

forward prototypes
public subroutine of_enabled (boolean ab_enabled)
public subroutine of_register ()
public subroutine of_register (str_pism_daily astr_wc)
end prototypes

public subroutine of_enabled (boolean ab_enabled);Integer li_protect = 0 

If Not ab_enabled Then li_protect = 1 
dw_wc.SetItem(dw_wc.GetRow(), "protect", li_protect) 

dw_wc.SetRedraw(True)
end subroutine

public subroutine of_register ();//
//DataWindowChild ldwc 
//
//dw_wc.Reset(); dw_wc.SetTransObject(SqlPIS) 
//If dw_wc.GetChild('workcenter', ldwc) <> -1 THEN 
//	ldwc.Reset(); ldwc.SetTransObject(SqlPIS)
//	If ldwc.Retrieve(gstr_userInfo.areaGubun, gstr_userInfo.divCode) = 0 Then ldwc.InsertRow(0) 
//	dw_wc.InsertRow(0)
//End If 
//
end subroutine

public subroutine of_register (str_pism_daily astr_wc);
DataWindowChild ldwc 

dw_wc.Reset(); dw_wc.SetTransObject(SqlPIS) 
If dw_wc.GetChild('workcenter', ldwc) <> -1 THEN 
	ldwc.Reset(); ldwc.SetTransObject(SqlPIS)
	If ldwc.Retrieve(astr_wc.area, astr_wc.div) = 0 Then ldwc.InsertRow(0) 
	dw_wc.InsertRow(0)
End If 

dw_wc.SetItem(dw_wc.GetRow(), "workcenter", astr_wc.wc) 
end subroutine

on u_pism_wc.create
this.st_1=create st_1
this.dw_wc=create dw_wc
this.gb_wc=create gb_wc
this.Control[]={this.st_1,&
this.dw_wc,&
this.gb_wc}
end on

on u_pism_wc.destroy
destroy(this.st_1)
destroy(this.dw_wc)
destroy(this.gb_wc)
end on

event constructor;//f_wcselect_init(dw_wc) 
end event

type st_1 from statictext within u_pism_wc
integer x = 32
integer y = 72
integer width = 133
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
string text = "조:"
boolean focusrectangle = false
end type

type dw_wc from datawindow within u_pism_wc
integer x = 165
integer y = 48
integer width = 1015
integer height = 96
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism_workcenter_ctrl"
boolean border = false
boolean livescroll = true
end type

type gb_wc from groupbox within u_pism_wc
integer x = 5
integer width = 1207
integer height = 156
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

