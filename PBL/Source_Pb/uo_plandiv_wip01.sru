$PBExportHeader$uo_plandiv_wip01.sru
forward
global type uo_plandiv_wip01 from userobject
end type
type em_vndr from editmask within uo_plandiv_wip01
end type
type pb_vndr from picturebutton within uo_plandiv_wip01
end type
type sle_vndm from singlelineedit within uo_plandiv_wip01
end type
type st_vndr from statictext within uo_plandiv_wip01
end type
type ddlb_1 from dropdownlistbox within uo_plandiv_wip01
end type
type st_1 from statictext within uo_plandiv_wip01
end type
type dw_1 from datawindow within uo_plandiv_wip01
end type
end forward

global type uo_plandiv_wip01 from userobject
integer width = 3634
integer height = 128
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_vndr em_vndr
pb_vndr pb_vndr
sle_vndm sle_vndm
st_vndr st_vndr
ddlb_1 ddlb_1
st_1 st_1
dw_1 dw_1
end type
global uo_plandiv_wip01 uo_plandiv_wip01

type variables
datawindowchild i_dwc_dvsn,i_dwc_plant
end variables

forward prototypes
public function string uf_return ()
end prototypes

public function string uf_return ();string l_s_iocd,l_s_plant,l_s_dvsn,l_s_vndr

l_s_plant = dw_1.GetItemString(1,'xplant')
l_s_dvsn  = dw_1.GetItemString(1,'div')
if ddlb_1.text = '라인' then
	l_s_iocd = '1'
elseif ddlb_1.text ='업체' then
	l_s_iocd = '2'
end if
em_vndr.getdata(l_s_vndr)

return l_s_plant + l_s_dvsn + l_s_iocd + l_S_vndr


	
end function

on uo_plandiv_wip01.create
this.em_vndr=create em_vndr
this.pb_vndr=create pb_vndr
this.sle_vndm=create sle_vndm
this.st_vndr=create st_vndr
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.em_vndr,&
this.pb_vndr,&
this.sle_vndm,&
this.st_vndr,&
this.ddlb_1,&
this.st_1,&
this.dw_1}
end on

on uo_plandiv_wip01.destroy
destroy(this.em_vndr)
destroy(this.pb_vndr)
destroy(this.sle_vndm)
destroy(this.st_vndr)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

event constructor;dw_1.GetChild("XPLANT",i_dwc_plant)
i_dwc_plant.SetTransObject(Sqlca)
i_dwc_plant.Retrieve('SLE220')
dw_1.GetChild("DIV",i_dwc_dvsn)
i_dwc_dvsn.SetTransObject(Sqlca)
i_dwc_dvsn.Retrieve('Z')
st_vndr.visible  = false
em_vndr.visible  = false
pb_vndr.visible  = false
sle_vndm.visible = false
dw_1.InsertRow(0)


end event

type em_vndr from editmask within uo_plandiv_wip01
integer x = 2053
integer y = 12
integer width = 457
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXX-XX-XXXXX"
boolean autoskip = true
end type

type pb_vndr from picturebutton within uo_plandiv_wip01
integer x = 2519
integer width = 238
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

openwithparm(w_find_001 , ' O')
l_s_parm = message.stringparm
if f_spacechk(l_s_parm) <> -1 then
	sle_vndm.text = mid(l_s_parm,16)
	em_vndr.text  = mid(l_s_parm,6,10)
end if
end event

type sle_vndm from singlelineedit within uo_plandiv_wip01
integer x = 2775
integer y = 12
integer width = 791
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_vndr from statictext within uo_plandiv_wip01
integer x = 1915
integer y = 28
integer width = 146
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "업체"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within uo_plandiv_wip01
integer x = 1536
integer y = 12
integer width = 338
integer height = 324
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
boolean sorted = false
integer limit = 2
string item[] = {"라인","업체"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	st_vndr.visible  = false
	em_vndr.visible  = false
	pb_vndr.visible  = false
	sle_vndm.visible = false
elseif index = 2 then
	st_vndr.visible  = true
	em_vndr.visible  = true
	pb_vndr.visible  = true
	sle_vndm.visible = true
end if
end event

type st_1 from statictext within uo_plandiv_wip01
integer x = 1253
integer y = 28
integer width = 270
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "재공구분"
boolean focusrectangle = false
end type

type dw_1 from datawindow within uo_plandiv_wip01
integer y = 4
integer width = 1262
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "dddw_plandiv_wip"
boolean border = false
boolean livescroll = true
end type

event itemchanged;DataWindowChild  cdw_1
String ls_data, ls_colnm

This.AcceptText()
ls_colnm = This.GetColumnName()
IF ls_colnm = 'xplant' Then
   dw_1.SetItem(1,'div', ' ')
   ls_data = dw_1.GetItemString(1,'xplant')
   dw_1.GetChild("DIV",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_data)
END IF


end event

