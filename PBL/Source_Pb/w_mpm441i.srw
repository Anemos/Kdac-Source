$PBExportHeader$w_mpm441i.srw
$PBExportComments$납기정보관리
forward
global type w_mpm441i from w_ipis_sheet01
end type
type dw_mpm441i_01 from u_vi_std_datawindow within w_mpm441i
end type
type tab_1 from tab within w_mpm441i
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tab_1 from tab within w_mpm441i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type dw_mpm441i_02 from u_vi_std_datawindow within w_mpm441i
end type
type dw_mpm441i_03 from u_vi_std_datawindow within w_mpm441i
end type
type dw_mpm441i_04 from datawindow within w_mpm441i
end type
type gb_1 from groupbox within w_mpm441i
end type
end forward

global type w_mpm441i from w_ipis_sheet01
dw_mpm441i_01 dw_mpm441i_01
tab_1 tab_1
dw_mpm441i_02 dw_mpm441i_02
dw_mpm441i_03 dw_mpm441i_03
dw_mpm441i_04 dw_mpm441i_04
gb_1 gb_1
end type
global w_mpm441i w_mpm441i

type variables
boolean ib_cal_change
end variables

on w_mpm441i.create
int iCurrent
call super::create
this.dw_mpm441i_01=create dw_mpm441i_01
this.tab_1=create tab_1
this.dw_mpm441i_02=create dw_mpm441i_02
this.dw_mpm441i_03=create dw_mpm441i_03
this.dw_mpm441i_04=create dw_mpm441i_04
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm441i_01
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_mpm441i_02
this.Control[iCurrent+4]=this.dw_mpm441i_03
this.Control[iCurrent+5]=this.dw_mpm441i_04
this.Control[iCurrent+6]=this.gb_1
end on

on w_mpm441i.destroy
call super::destroy
destroy(this.dw_mpm441i_01)
destroy(this.tab_1)
destroy(this.dw_mpm441i_02)
destroy(this.dw_mpm441i_03)
destroy(this.dw_mpm441i_04)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

tab_1.Width = newwidth - ( tab_1.x + 10 ) 

dw_mpm441i_01.Width = newwidth 	- ( dw_mpm441i_01.x + ls_split )
dw_mpm441i_01.Height= newheight - ( dw_mpm441i_01.y + ls_status )

dw_mpm441i_02.x = dw_mpm441i_01.x
dw_mpm441i_02.y = dw_mpm441i_01.y
dw_mpm441i_02.Width = newwidth 	- ( dw_mpm441i_02.x + ls_split )
dw_mpm441i_02.Height= newheight - ( dw_mpm441i_02.y + ls_status )

dw_mpm441i_03.x = dw_mpm441i_01.x
dw_mpm441i_03.y = dw_mpm441i_01.y
dw_mpm441i_03.Width = newwidth 	- ( dw_mpm441i_03.x + ls_split )
dw_mpm441i_03.Height= newheight - ( dw_mpm441i_03.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm441i_01.settransobject(sqlmpms)
dw_mpm441i_02.settransobject(sqlmpms)
dw_mpm441i_03.settransobject(sqlmpms)
dw_mpm441i_04.settransobject(sqlmpms)

dw_mpm441i_04.insertrow(0)
dw_mpm441i_04.GetChild('versionno', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM011')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm441i_04,'versionno',ldwc,'codename',5)
end event

event ue_retrieve;call super::ue_retrieve;string ls_versionno

ls_versionno = dw_mpm441i_04.getitemstring(1,"versionno")
if f_spacechk(ls_versionno) = -1 then
	uo_status.st_message.text = "납기버전을 선택해 주시기 바랍니다."
	return 0
end if

choose case tab_1.selectedtab
	case 1
		dw_mpm441i_01.reset()
		dw_mpm441i_01.retrieve(ls_versionno)
	case 2
		dw_mpm441i_02.reset()
		dw_mpm441i_02.retrieve(ls_versionno)
	case 3
		dw_mpm441i_03.reset()
		dw_mpm441i_03.retrieve(ls_versionno)
end choose

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm441i
end type

type dw_mpm441i_01 from u_vi_std_datawindow within w_mpm441i
integer x = 27
integer y = 332
integer width = 773
integer height = 1436
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm441i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type tab_1 from tab within w_mpm441i
integer x = 27
integer y = 184
integer width = 2949
integer height = 140
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;
Choose Case newindex 
	Case 1
		dw_mpm441i_01.ScrollToRow(1)
		dw_mpm441i_01.Visible = True 
		dw_mpm441i_02.Visible = False
		dw_mpm441i_03.Visible = False
		
	Case 2
		dw_mpm441i_02.ScrollToRow(1)
		dw_mpm441i_02.Visible = True 
		dw_mpm441i_01.Visible = False
		dw_mpm441i_03.Visible = False
		
	Case 3
		dw_mpm441i_03.ScrollToRow(1)
		dw_mpm441i_03.Visible = True 
		dw_mpm441i_01.Visible = False
		dw_mpm441i_02.Visible = False
End Choose 

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 132
integer width = 2912
integer height = -8
long backcolor = 12632256
string text = "OrderNo기준 납기정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 132
integer width = 2912
integer height = -8
long backcolor = 12632256
string text = "작업장기준 납기정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 132
integer width = 2912
integer height = -8
long backcolor = 12632256
string text = "작업일기준 납기정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_mpm441i_02 from u_vi_std_datawindow within w_mpm441i
integer x = 841
integer y = 332
integer width = 773
integer height = 1436
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm441i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_mpm441i_03 from u_vi_std_datawindow within w_mpm441i
integer x = 1655
integer y = 332
integer width = 773
integer height = 1436
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mpm441i_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_mpm441i_04 from datawindow within w_mpm441i
integer x = 46
integer y = 20
integer width = 1371
integer height = 132
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm410u_01_left"
boolean border = false
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_mpm441i
integer x = 27
integer y = 4
integer width = 1760
integer height = 164
integer taborder = 10
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

