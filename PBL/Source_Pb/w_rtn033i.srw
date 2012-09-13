$PBExportHeader$w_rtn033i.srw
$PBExportComments$부대작업조회용 윈도우[결재]
forward
global type w_rtn033i from w_origin_sheet04
end type
type tab_1 from tab within w_rtn033i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_jobdetail from datawindow within tabpage_1
end type
type dw_mcnoinfo from datawindow within tabpage_1
end type
type dw_secjobinfo from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_jobdetail dw_jobdetail
dw_mcnoinfo dw_mcnoinfo
dw_secjobinfo dw_secjobinfo
end type
type tabpage_2 from userobject within tab_1
end type
type gr_view_nvmo from graph within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gr_view_nvmo gr_view_nvmo
end type
type tab_1 from tab within w_rtn033i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_2 from statictext within w_rtn033i
end type
type st_3 from statictext within w_rtn033i
end type
type st_4 from statictext within w_rtn033i
end type
type st_1 from statictext within w_rtn033i
end type
type em_ajdate from editmask within w_rtn033i
end type
type ddlb_1 from dropdownlistbox within w_rtn033i
end type
type ddlb_2 from dropdownlistbox within w_rtn033i
end type
type ddlb_3 from dropdownlistbox within w_rtn033i
end type
type uo_1 from uo_plandiv_bom within w_rtn033i
end type
type gb_1 from groupbox within w_rtn033i
end type
end forward

global type w_rtn033i from w_origin_sheet04
event ue_keydown pbm_keydown
tab_1 tab_1
st_2 st_2
st_3 st_3
st_4 st_4
st_1 st_1
em_ajdate em_ajdate
ddlb_1 ddlb_1
ddlb_2 ddlb_2
ddlb_3 ddlb_3
uo_1 uo_1
gb_1 gb_1
end type
global w_rtn033i w_rtn033i

type variables
datawindowchild i_dwc_secjob,i_dwc_secjob2,i_dwc_secjob3,i_dwc_nvmo,i_dwc_mcno
string i_s_plant,i_s_div,i_s_ajdate
end variables

event ue_keydown;if key = keyenter! then
//	window l_s_wsheet
//	l_s_wsheet = w_frame.GetActiveSheet()
	this.TriggerEvent("ue_retrieve")
end if

return 0
end event

on w_rtn033i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_1=create st_1
this.em_ajdate=create em_ajdate
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
this.ddlb_3=create ddlb_3
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_ajdate
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.ddlb_2
this.Control[iCurrent+9]=this.ddlb_3
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_rtn033i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.em_ajdate)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
destroy(this.ddlb_3)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event open;call super::open;
//유형 
// f_window_resize(this)
f_populate_ddlb_from_Dac002('RTN010',ddlb_1)
f_populate_ddlb_from_Dac002('RTN020',ddlb_2)
f_populate_ddlb_from_Dac002('RTN030',ddlb_3)
ddlb_1.text = ' '
ddlb_2.text = ' '
ddlb_3.text = ' '
tab_1.tabpage_1.dw_jobdetail.getchild("rdnvmo",i_dwc_nvmo)
i_dwc_nvmo.settransobject(sqlca)
i_dwc_nvmo.retrieve('RTN010')
tab_1.tabpage_1.dw_jobdetail.getchild("rdmcno",i_dwc_mcno)
i_dwc_mcno.settransobject(sqlca)
i_dwc_mcno.retrieve('RTN020')

em_ajdate.text = g_s_date

tab_1.tabpage_1.dw_secjobinfo.settransobject(sqlca)
tab_1.tabpage_1.dw_mcnoinfo.settransobject(sqlca)
tab_1.tabpage_1.dw_jobdetail.settransobject(sqlca)

return 0

end event

event ue_retrieve;long ll_rowcnt,ll_cntnvmo
string ls_nvmo,ls_mcno,ls_term
datastore lds_chartdata

setpointer(hourglass!)
uo_status.st_message.text = ""
tab_1.tabpage_1.dw_secjobinfo.reset()
tab_1.tabpage_1.dw_mcnoinfo.reset()
tab_1.tabpage_1.dw_jobdetail.reset()
em_ajdate.getdata(i_s_ajdate)
if f_spacechk(i_s_ajdate) = -1 or f_dateedit(i_s_ajdate) = space(8) then
	em_ajdate.backcolor = rgb(255,255,0)
	return 0
else
	em_ajdate.backcolor = rgb(255,250,239)
end if
string l_s_parm
l_s_parm  	= 	uo_1.uf_Return()
i_s_plant 		=	mid(l_s_parm,1,1)
i_s_div   		= 	mid(l_s_parm,2,1)
ls_nvmo   	= 	right(ddlb_1.text,2)
ls_mcno   	= 	right(ddlb_2.text,1)
ls_term   		= 	right(ddlb_3.text,1)
if f_spacechk(ls_nvmo) = -1 then
	ls_nvmo = '%'
else
	ls_nvmo = ls_nvmo + '%'
end if
if f_spacechk(ls_mcno) = -1 then
	ls_mcno = '%'
else
	ls_mcno = ls_mcno + '%'
end if
if f_spacechk(ls_term) = -1 then
	ls_term = '%'
else
	ls_term = ls_term + '%'
end if
ll_rowcnt = tab_1.tabpage_1.dw_secjobinfo.retrieve(g_s_company,i_s_plant,i_s_div,ls_nvmo,ls_mcno,ls_term,i_s_ajdate)

if ll_rowcnt > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
end if

//SETUP GRAPH
//  tab_1.tabpage_2.gr_view_nvmo.title = uo_1.uf_name() + "(기준일: " + string(i_s_ajdate,"@@@@.@@.@@") + " )"
tab_1.tabpage_2.gr_view_nvmo.title = "(기준일: " + string(i_s_ajdate,"@@@@.@@.@@") + " )"
lds_chartdata = create Datastore
lds_chartdata.dataobject = "d_rtn033i_chartdata"
lds_chartdata.settransobject(sqlca)
ll_rowcnt = lds_chartdata.retrieve(g_s_company,i_s_plant,i_s_div,i_s_ajdate)

boolean lb_found
long ll_breakrow

lb_found = false
ll_breakrow = 0

do while not (lb_found)
		ll_breakrow = lds_chartdata.FindGroupChange(ll_breakrow, 1)

		// If no breaks are found, exit.
		IF ll_breakrow <= 0 THEN EXIT

		// Have we found the section for Dept 121?
		ls_nvmo = lds_chartdata.getitemstring(ll_breakrow, "rdnvmo")
		ll_cntnvmo = lds_chartdata.getitemnumber(ll_breakrow,"com_sum")
		choose case ls_nvmo
			case '01'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"WHEEL DRESSING")
			case '02'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"TOOL교체 및 SETUP")
			case '03'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"자주검사")
			case '04'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"초물검사 및 SETUP")
			case '05'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"원소재교체 및 BATCH LODING")
			case '06'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"액보충 및 교체")
			case '99'
				tab_1.tabpage_2.gr_view_nvmo.adddata(1,ll_cntnvmo,"기타")
		end choose
		
		// Increment starting row to find next break
		ll_breakrow = ll_breakrow + 1
		if ll_rowcnt = ll_breakrow then
			lb_found = true
		end if
loop

destroy lds_chartdata

return 0
end event

type uo_status from w_origin_sheet04`uo_status within w_rtn033i
end type

type tab_1 from tab within w_rtn033i
integer y = 212
integer width = 4608
integer height = 2244
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;uo_status.st_message.text = ""

return 0
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4571
integer height = 2116
long backcolor = 12632256
string text = "세부내용"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Custom041!"
long picturemaskcolor = 536870912
dw_jobdetail dw_jobdetail
dw_mcnoinfo dw_mcnoinfo
dw_secjobinfo dw_secjobinfo
end type

on tabpage_1.create
this.dw_jobdetail=create dw_jobdetail
this.dw_mcnoinfo=create dw_mcnoinfo
this.dw_secjobinfo=create dw_secjobinfo
this.Control[]={this.dw_jobdetail,&
this.dw_mcnoinfo,&
this.dw_secjobinfo}
end on

on tabpage_1.destroy
destroy(this.dw_jobdetail)
destroy(this.dw_mcnoinfo)
destroy(this.dw_secjobinfo)
end on

type dw_jobdetail from datawindow within tabpage_1
integer x = 974
integer y = 1164
integer width = 3570
integer height = 948
integer taborder = 50
string title = "none"
string dataobject = "d_rtn01_opno_secjobinfo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mcnoinfo from datawindow within tabpage_1
integer y = 1164
integer width = 965
integer height = 944
integer taborder = 40
string title = "none"
string dataobject = "d_rtn01_opno_mcnoinfo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_secjobinfo from datawindow within tabpage_1
integer y = 16
integer width = 4544
integer height = 1128
integer taborder = 20
string title = "none"
string dataobject = "d_rtn033i_detail_secjobinfo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_itno, ls_line1, ls_line2, ls_opno
long ll_rowcnt,ll_rowcnt1,ll_rowcnt2

if row <= 0 then
	return 0
end if

tab_1.tabpage_1.dw_mcnoinfo.reset()
tab_1.tabpage_1.dw_jobdetail.reset()
uo_status.st_message.text = ""

ls_line1 = trim(tab_1.tabpage_1.dw_secjobinfo.object.rtn015_reline1[row])
ls_line2 = tab_1.tabpage_1.dw_secjobinfo.object.rtn015_reline2[row]
 
ls_itno = tab_1.tabpage_1.dw_secjobinfo.object.rtn015_reitno[row]
ls_opno = tab_1.tabpage_1.dw_secjobinfo.object.rtn015_reopno[row]

ll_rowcnt1 = tab_1.tabpage_1.dw_mcnoinfo.retrieve(g_s_company,i_s_plant,i_s_div,ls_itno,ls_line1,ls_line2,ls_opno)
ll_rowcnt2 = tab_1.tabpage_1.dw_jobdetail.retrieve(g_s_company,i_s_plant,i_s_div,ls_itno,ls_line1,ls_line2,ls_opno,i_s_ajdate)

ll_rowcnt = ll_rowcnt1 + ll_rowcnt2
choose case ll_rowcnt
	case 0
		uo_status.st_message.text = " 공정에 대한 장비및 부대작업내역이 없습니다."
	case else
		if ll_rowcnt1 = 0 then
			uo_status.st_message.text = "공정에 대한 장비내역이 없습니다."
		elseif ll_rowcnt2 = 0 then
			uo_status.st_message.text = "공정에 대한 부대작업내역이 없습니다."
		end if
end choose

return 0
end event

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
else
	this.selectrow(0,false)
end if

return 0
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4571
integer height = 2116
long backcolor = 12632256
string text = "통계"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Custom073!"
long picturemaskcolor = 536870912
gr_view_nvmo gr_view_nvmo
end type

on tabpage_2.create
this.gr_view_nvmo=create gr_view_nvmo
this.Control[]={this.gr_view_nvmo}
end on

on tabpage_2.destroy
destroy(this.gr_view_nvmo)
end on

type gr_view_nvmo from graph within tabpage_2
integer x = 9
integer y = 12
integer width = 4553
integer height = 2076
boolean border = true
grgraphtype graphtype = pie3d!
long backcolor = 12632256
integer spacing = 100
string title = "(None)"
integer elevation = -28
integer perspective = 1
integer depth = 70
grlegendtype legend = atright!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
grsorttype seriessort = ascending!
grsorttype categorysort = ascending!
end type

on gr_view_nvmo.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="굴림체"
TitleDispAttr.FontCharSet=Hangeul!
TitleDispAttr.FontFamily=Modern!
TitleDispAttr.FontPitch=Fixed!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="(None)"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Arial"
Category.DispAttr.FontCharSet=DefaultCharSet!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Arial"
Category.LabelDispAttr.FontCharSet=DefaultCharSet!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="(None)"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontCharSet=DefaultCharSet!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="Arial"
Values.LabelDispAttr.FontCharSet=DefaultCharSet!
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontCharSet=DefaultCharSet!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontCharSet=DefaultCharSet!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="굴림체"
LegendDispAttr.FontCharSet=Hangeul!
LegendDispAttr.FontFamily=Modern!
LegendDispAttr.FontPitch=Fixed!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression=" category "
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="굴림체"
PieDispAttr.FontCharSet=Hangeul!
PieDispAttr.FontFamily=Modern!
PieDispAttr.FontPitch=Fixed!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_view_nvmo.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

event constructor;tab_1.tabpage_2.gr_view_nvmo.addseries( "a")

tab_1.tabpage_2.gr_view_nvmo.addcategory( "WHEEL DRESSING")
tab_1.tabpage_2.gr_view_nvmo.addcategory( "TOOL교체 및 SETUP")
tab_1.tabpage_2.gr_view_nvmo.addcategory( "자주검사")
tab_1.tabpage_2.gr_view_nvmo.addcategory( "초물검사 및 SETUP")
tab_1.tabpage_2.gr_view_nvmo.addcategory( "원소재교체 및 BATCH LODING")
tab_1.tabpage_2.gr_view_nvmo.addcategory( "액보충 및 교체")
tab_1.tabpage_2.gr_view_nvmo.addcategory( "기타")
end event

type st_2 from statictext within w_rtn033i
integer x = 1349
integer y = 68
integer width = 151
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "유형"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rtn033i
integer x = 2345
integer y = 68
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "구분"
boolean focusrectangle = false
end type

type st_4 from statictext within w_rtn033i
integer x = 3159
integer y = 68
integer width = 155
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "빈도"
boolean focusrectangle = false
end type

type st_1 from statictext within w_rtn033i
integer x = 3904
integer y = 68
integer width = 229
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준일"
boolean focusrectangle = false
end type

type em_ajdate from editmask within w_rtn033i
event ue_keydown pbm_keydown
integer x = 4114
integer y = 60
integer width = 425
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type ddlb_1 from dropdownlistbox within w_rtn033i
integer x = 1504
integer y = 56
integer width = 768
integer height = 376
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15793151
string text = "none"
boolean border = false
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_2 from dropdownlistbox within w_rtn033i
integer x = 2505
integer y = 56
integer width = 585
integer height = 376
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15793151
string text = "none"
boolean border = false
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if mid(ddlb_2.text,31,1) = '0' then
	f_populate_ddlb_from_Dac002('RTN030',ddlb_3)
elseif mid(ddlb_2.text,31,1) = '1' then
	f_populate_ddlb_from_Dac002('RTN040',ddlb_3)	
end if
end event

type ddlb_3 from dropdownlistbox within w_rtn033i
integer x = 3301
integer y = 56
integer width = 539
integer height = 376
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15793151
string text = "none"
boolean border = false
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_plandiv_bom within w_rtn033i
integer x = 37
integer y = 36
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type gb_1 from groupbox within w_rtn033i
integer x = 23
integer width = 4562
integer height = 172
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

