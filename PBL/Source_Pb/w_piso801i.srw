$PBExportHeader$w_piso801i.srw
$PBExportComments$여주납입 인터페이스 에러
forward
global type w_piso801i from w_ipis_sheet01
end type
type tab_1 from tab within w_piso801i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_err_partin from u_vi_std_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_err_partin dw_err_partin
end type
type tabpage_2 from userobject within tab_1
end type
type dw_err_partrelease from u_vi_std_datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_err_partrelease dw_err_partrelease
end type
type tabpage_3 from userobject within tab_1
end type
type dw_err_partreturn from u_vi_std_datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_err_partreturn dw_err_partreturn
end type
type tabpage_4 from userobject within tab_1
end type
type dw_err_partcancel from u_vi_std_datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_err_partcancel dw_err_partcancel
end type
type tab_1 from tab within w_piso801i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type pb_down from picturebutton within w_piso801i
end type
end forward

global type w_piso801i from w_ipis_sheet01
tab_1 tab_1
pb_down pb_down
end type
global w_piso801i w_piso801i

type variables
integer ii_tabindex
end variables

on w_piso801i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.pb_down
end on

on w_piso801i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.pb_down)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

tab_1.Width = newwidth 	- ( tab_1.x * 2 )
tab_1.Height= newheight - ( tab_1.y + ls_status )

tab_1.tabpage_1.dw_err_partin.Width = tab_1.Width - ( tab_1.tabpage_1.dw_err_partin.x * 7 )
tab_1.tabpage_1.dw_err_partin.Height = tab_1.Height - ( tab_1.tabpage_1.dw_err_partin.y * 12 )

tab_1.tabpage_2.dw_err_partrelease.Width = tab_1.Width - ( tab_1.tabpage_2.dw_err_partrelease.x * 7 )
tab_1.tabpage_2.dw_err_partrelease.Height = tab_1.Height - ( tab_1.tabpage_2.dw_err_partrelease.y * 12 )

tab_1.tabpage_3.dw_err_partreturn.Width = tab_1.Width - ( tab_1.tabpage_3.dw_err_partreturn.x * 7 )
tab_1.tabpage_3.dw_err_partreturn.Height = tab_1.Height - ( tab_1.tabpage_3.dw_err_partreturn.y * 12 )

tab_1.tabpage_4.dw_err_partcancel.Width = tab_1.Width - ( tab_1.tabpage_4.dw_err_partcancel.x * 7 )
tab_1.tabpage_4.dw_err_partcancel.Height = tab_1.Height - ( tab_1.tabpage_4.dw_err_partcancel.y * 12 )
end event

event open;call super::open;// ELE_SERVER INTERFACE DB
SQLXX = CREATE transaction
SQLXX.DBMS       = ProfileString(gs_inifile,'ELE',"DBMS",			" ")
SQLXX.ServerName = ProfileString(gs_inifile,"ELE","ServerName",	" ")
SQLXX.Database   = "INTERFACE"
SQLXX.LogID      = ProfileString(gs_inifile,"ELE","LogId",			" ")
SQLXX.LogPass    = ProfileString(gs_inifile,"ELE","LogPass",		" ")
SQLXX.DbParm     = " "
SQLXX.AutoCommit = True
gs_appname	= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
	
Connect Using SQLXX;
end event

event close;call super::close;DESTROY SQLXX
end event

event ue_postopen;call super::ue_postopen;ii_tabindex = 1
tab_1.selecttab(1)
tab_1.tabpage_1.dw_err_partin.settransobject(sqlxx)
tab_1.tabpage_2.dw_err_partrelease.settransobject(sqlxx)
tab_1.tabpage_3.dw_err_partreturn.settransobject(sqlxx)
tab_1.tabpage_4.dw_err_partcancel.settransobject(sqlxx)
end event

event ue_retrieve;call super::ue_retrieve;integer li_rowcnt
choose case ii_tabindex
	case 1
		tab_1.tabpage_1.dw_err_partin.reset()
		li_rowcnt = tab_1.tabpage_1.dw_err_partin.retrieve()
	case 2
		tab_1.tabpage_2.dw_err_partrelease.reset()
		li_rowcnt = tab_1.tabpage_2.dw_err_partrelease.retrieve()
	case 3
		tab_1.tabpage_3.dw_err_partreturn.reset()
		li_rowcnt = tab_1.tabpage_3.dw_err_partreturn.retrieve()
	case 4
		tab_1.tabpage_4.dw_err_partcancel.reset()
		li_rowcnt = tab_1.tabpage_4.dw_err_partcancel.retrieve()
end choose

if li_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_piso801i
end type

type tab_1 from tab within w_piso801i
integer x = 27
integer y = 36
integer width = 3346
integer height = 1820
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
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
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;ii_tabindex = newindex
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3310
integer height = 1704
long backcolor = 12632256
string text = "여주자재 입고정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_err_partin dw_err_partin
end type

on tabpage_1.create
this.dw_err_partin=create dw_err_partin
this.Control[]={this.dw_err_partin}
end on

on tabpage_1.destroy
destroy(this.dw_err_partin)
end on

type dw_err_partin from u_vi_std_datawindow within tabpage_1
integer x = 9
integer y = 12
integer width = 3273
integer height = 1660
integer taborder = 20
string dataobject = "d_piso801i_err_partin"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3310
integer height = 1704
long backcolor = 12632256
string text = "여주자재 불출정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_err_partrelease dw_err_partrelease
end type

on tabpage_2.create
this.dw_err_partrelease=create dw_err_partrelease
this.Control[]={this.dw_err_partrelease}
end on

on tabpage_2.destroy
destroy(this.dw_err_partrelease)
end on

type dw_err_partrelease from u_vi_std_datawindow within tabpage_2
integer x = 9
integer y = 12
integer width = 3273
integer height = 1668
integer taborder = 11
string dataobject = "d_piso801i_err_partrelease"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3310
integer height = 1704
long backcolor = 12632256
string text = "여주자재 반납정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_err_partreturn dw_err_partreturn
end type

on tabpage_3.create
this.dw_err_partreturn=create dw_err_partreturn
this.Control[]={this.dw_err_partreturn}
end on

on tabpage_3.destroy
destroy(this.dw_err_partreturn)
end on

type dw_err_partreturn from u_vi_std_datawindow within tabpage_3
integer x = 9
integer y = 12
integer width = 3278
integer height = 1680
integer taborder = 11
string dataobject = "d_piso801i_err_partreturn"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3310
integer height = 1704
long backcolor = 12632256
string text = "여주자재 입고취소정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_err_partcancel dw_err_partcancel
end type

on tabpage_4.create
this.dw_err_partcancel=create dw_err_partcancel
this.Control[]={this.dw_err_partcancel}
end on

on tabpage_4.destroy
destroy(this.dw_err_partcancel)
end on

type dw_err_partcancel from u_vi_std_datawindow within tabpage_4
integer x = 9
integer y = 12
integer width = 3287
integer height = 1688
integer taborder = 11
string dataobject = "d_piso801i_err_partcancel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type pb_down from picturebutton within w_piso801i
integer x = 2912
integer y = 12
integer width = 197
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;choose case ii_tabindex
	case 1
		f_save_to_excel(tab_1.tabpage_1.dw_err_partin)
	case 2
		f_save_to_excel(tab_1.tabpage_2.dw_err_partrelease)
	case 3
		f_save_to_excel(tab_1.tabpage_3.dw_err_partreturn)
	case 4
		f_save_to_excel(tab_1.tabpage_4.dw_err_partcancel)
end choose
end event

