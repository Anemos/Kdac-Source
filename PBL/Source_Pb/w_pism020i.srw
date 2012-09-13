$PBExportHeader$w_pism020i.srw
$PBExportComments$시간단위 지원공수 조회
forward
global type w_pism020i from w_pism_sheet01
end type
type st_hbar from u_pism_splitbar within w_pism020i
end type
type st_2 from statictext within w_pism020i
end type
type st_3 from statictext within w_pism020i
end type
type dw_msupp from u_pism_dw within w_pism020i
end type
type dw_psupp from u_pism_dw within w_pism020i
end type
type uo_workday from u_pisc_date_today within w_pism020i
end type
type gb_4 from groupbox within w_pism020i
end type
end forward

global type w_pism020i from w_pism_sheet01
integer width = 3854
integer height = 2292
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
st_hbar st_hbar
st_2 st_2
st_3 st_3
dw_msupp dw_msupp
dw_psupp dw_psupp
uo_workday uo_workday
gb_4 gb_4
end type
global w_pism020i w_pism020i

type variables
String is_modChk 
Boolean ib_responseChk 

constant String ETCMAN = '2', ETCMANCODE = '999999'
constant String OTHERDIVMAN = '3', OTHERDIVMANCODE = 'XXXXXX'
constant String REGMAN = '1' 
end variables

event resize;call super::resize;Long ll_Height 

dw_msupp.Width = newwidth - ( dw_msupp.x + 20 ) 
st_hbar.Width = dw_msupp.Width 
dw_psupp.Width = dw_msupp.Width  

ll_Height = ( newheight - ( dw_msupp.y + ( dw_psupp.y - ( dw_msupp.y + dw_msupp.Height ) ) + uo_status.Height ) ) / 2 

dw_msupp.Height = ll_Height 

st_hbar.y = dw_msupp.y + dw_msupp.Height 
dw_psupp.y = dw_msupp.y + dw_msupp.Height + st_hbar.Height + 92 
st_3.y = dw_psupp.y - st_3.Height 

dw_psupp.Height = newheight - ( dw_psupp.y + uo_status.Height + 10 ) 

end event

on w_pism020i.create
int iCurrent
call super::create
this.st_hbar=create st_hbar
this.st_2=create st_2
this.st_3=create st_3
this.dw_msupp=create dw_msupp
this.dw_psupp=create dw_psupp
this.uo_workday=create uo_workday
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_hbar
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_msupp
this.Control[iCurrent+5]=this.dw_psupp
this.Control[iCurrent+6]=this.uo_workday
this.Control[iCurrent+7]=this.gb_4
end on

on w_pism020i.destroy
call super::destroy
destroy(this.st_hbar)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_msupp)
destroy(this.dw_psupp)
destroy(this.uo_workday)
destroy(this.gb_4)
end on

event ue_retrieve;call super::ue_retrieve;dw_msupp.SetTransObject(SqlPIS); dw_psupp.SetTransObject(SqlPIS)
dw_msupp.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday)
dw_psupp.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday)
end event

event ue_postopen;call super::ue_postopen;DataWindowChild ldwc 
If dw_msupp.GetChild('tmhsupport_empno', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 
If dw_msupp.GetChild('tmstemp_empname', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 
If dw_msupp.GetChild('tmhsupport_supworkcenter_1', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.area, istr_mh.div, '%') 
End If 

If dw_psupp.GetChild('tmhsupport_empno', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 
If dw_psupp.GetChild('tmstemp_empname', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 
If dw_psupp.GetChild('tmhsupport_supworkcenter_1', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.area, istr_mh.div, '%') 
End If 

istr_mh.wday = uo_workday.is_uo_date
end event

type uo_status from w_pism_sheet01`uo_status within w_pism020i
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pism020i
end type

type uo_area from w_pism_sheet01`uo_area within w_pism020i
end type

type uo_div from w_pism_sheet01`uo_div within w_pism020i
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pism020i
end type

type st_hbar from u_pism_splitbar within w_pism020i
integer y = 1040
integer width = 1947
boolean bringtotop = true
end type

type st_2 from statictext within w_pism020i
integer x = 5
integer y = 184
integer width = 443
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[ 지원보냄 ]"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pism020i
integer x = 5
integer y = 1084
integer width = 443
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[ 지원받음 ]"
boolean focusrectangle = false
end type

type dw_msupp from u_pism_dw within w_pism020i
integer y = 260
integer width = 3328
integer height = 780
integer taborder = 11
string dataobject = "d_pism020u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;DataWindowChild ldwc 
If This.GetChild('tmhsupport_empno', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 

If This.GetChild('tmstemp_empname', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 

If dw_msupp.GetChild('tmhsupport_supworkcenter_1', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.area, istr_mh.div, '%') 
End If 


end event

type dw_psupp from u_pism_dw within w_pism020i
integer y = 1156
integer width = 3328
integer height = 588
integer taborder = 21
string dataobject = "d_pism020u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;DataWindowChild ldwc 
If This.GetChild('tmhsupport_empno', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 

If This.GetChild('tmstemp_empname', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.wc) 
End If 

If dw_psupp.GetChild('tmhsupport_supworkcenter_1', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlPIS); ldwc.Retrieve(istr_mh.area, istr_mh.div, '%') 
End If 

end event

type uo_workday from u_pisc_date_today within w_pism020i
integer x = 2368
integer y = 52
integer taborder = 40
end type

on uo_workday.destroy
call u_pisc_date_today::destroy
end on

event ue_select;call super::ue_select;istr_mh.wday = is_uo_date
end event

type gb_4 from groupbox within w_pism020i
integer x = 2331
integer y = 4
integer width = 745
integer height = 132
integer taborder = 60
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

