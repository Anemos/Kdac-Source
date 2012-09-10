$PBExportHeader$u_pism_year-1.sru
$PBExportComments$기준년도 : 전년도
forward
global type u_pism_year-1 from userobject
end type
type em_year from editmask within u_pism_year-1
end type
type st_1 from statictext within u_pism_year-1
end type
type gb_1 from groupbox within u_pism_year-1
end type
end forward

global type u_pism_year-1 from userobject
integer width = 722
integer height = 164
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_variable_change ( string as_year )
em_year em_year
st_1 st_1
gb_1 gb_1
end type
global u_pism_year-1 u_pism_year-1

type variables
String uis_appYear 
end variables

forward prototypes
public function string uf_setapplyyear (str_pism_daily astr_mh)
end prototypes

public function string uf_setapplyyear (str_pism_daily astr_mh);String	ls_applyYear
DateTime ld_curDay 

If astr_mh.Year = '' Then 
	Select Top 1 getdate() Into :ld_curDay From sysusers Using SQLPIS; 
	
	If Not f_pisc_get_date_convert(f_pisc_get_date_applydate(astr_mh.area, astr_mh.div, ld_curDay), 'YYYY', ls_applyYear) Then
		ls_applyYear = String(Year(Today()))
	End If
	ls_applyYear = String(Integer(Left(ls_applyYear, 4)) - 1)
Else
	ls_applyYear = astr_mh.Year  	
End If 
uis_appYear = ls_applyYear; em_year.Text = ls_applyYear

Return ls_applyYear 
end function

on u_pism_year-1.create
this.em_year=create em_year
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.em_year,&
this.st_1,&
this.gb_1}
end on

on u_pism_year-1.destroy
destroy(this.em_year)
destroy(this.st_1)
destroy(this.gb_1)
end on

type em_year from editmask within u_pism_year-1
integer x = 343
integer y = 52
integer width = 288
integer height = 68
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
end type

event modified;String ls_applyYear

uis_appYear = Text 

Parent.Event ue_variable_change(uis_appYear)
end event

type st_1 from statictext within u_pism_year-1
integer x = 23
integer y = 60
integer width = 334
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within u_pism_year-1
integer x = 9
integer width = 645
integer height = 136
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

