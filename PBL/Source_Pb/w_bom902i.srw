$PBExportHeader$w_bom902i.srw
$PBExportComments$M-BOM 조회 ( 제품군별 )
forward
global type w_bom902i from w_origin_sheet02
end type
type st_4 from statictext within w_bom902i
end type
type uo_1 from uo_plandiv_pdcd within w_bom902i
end type
type dw_pdcd_bom from datawindow within w_bom902i
end type
type str_bomdata_info from structure within w_bom902i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_bom902i from w_origin_sheet02
string title = "History 조회"
st_4 st_4
uo_1 uo_1
dw_pdcd_bom dw_pdcd_bom
end type
global w_bom902i w_bom902i

type variables

end variables

on w_bom902i.create
int iCurrent
call super::create
this.st_4=create st_4
this.uo_1=create uo_1
this.dw_pdcd_bom=create dw_pdcd_bom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_pdcd_bom
end on

on w_bom902i.destroy
call super::destroy
destroy(this.st_4)
destroy(this.uo_1)
destroy(this.dw_pdcd_bom)
end on

event open;call super::open;setpointer(HourGlass!)

this.uo_status.st_winid.text 	= this.classname()
this.uo_status.st_kornm.text 	= g_s_kornm
this.uo_status.st_date.text 	= string(g_s_date, "@@@@-@@-@@")
//Convert DATE



end event

event ue_retrieve;string 	ls_rtncd,ls_plant,ls_div,ls_pdcd

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= mid(ls_rtncd,1,1)
ls_div 		= mid(ls_rtncd,2,1)
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%'

f_creation_bom_dw_pdcd(g_s_date,ls_plant,ls_div,ls_pdcd,'30%','%','C')
dw_pdcd_bom.settransobject(sqlca)
dw_pdcd_bom.retrieve()

end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve") 
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom902i
integer y = 2468
end type

type st_4 from statictext within w_bom902i
boolean visible = false
integer x = 2519
integer y = 44
integer width = 279
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준일자"
boolean focusrectangle = false
end type

type uo_1 from uo_plandiv_pdcd within w_bom902i
integer x = 46
integer y = 4
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type dw_pdcd_bom from datawindow within w_bom902i
integer x = 46
integer y = 136
integer width = 4119
integer height = 2296
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_bom_temp_inv"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

