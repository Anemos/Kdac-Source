$PBExportHeader$w_pisr020i.srw
$PBExportComments$외주간판기본정보변경이력현황조회
forward
global type w_pisr020i from w_ipis_sheet01
end type
type tv_partkb from u_pisr_treeview within w_pisr020i
end type
type dw_pisr020i_01 from u_vi_std_datawindow within w_pisr020i
end type
type st_vsplitbar from u_pism_splitbar within w_pisr020i
end type
type uo_area from u_pisc_select_area within w_pisr020i
end type
type uo_division from u_pisc_select_division within w_pisr020i
end type
type dw_print from datawindow within w_pisr020i
end type
type gb_1 from groupbox within w_pisr020i
end type
end forward

global type w_pisr020i from w_ipis_sheet01
event ue_init ( )
tv_partkb tv_partkb
dw_pisr020i_01 dw_pisr020i_01
st_vsplitbar st_vsplitbar
uo_area uo_area
uo_division uo_division
dw_print dw_print
gb_1 gb_1
end type
global w_pisr020i w_pisr020i

type variables
str_pisr_partkb istr_partkb
end variables

event ue_init();
dw_print.Visible 		= False

Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_pisr020i_01, st_vsplitbar.RIGHT)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회
//dw_pisr010u_02.Object.Enabled = False

// TreeView 설정
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode,true)


end event

on w_pisr020i.create
int iCurrent
call super::create
this.tv_partkb=create tv_partkb
this.dw_pisr020i_01=create dw_pisr020i_01
this.st_vsplitbar=create st_vsplitbar
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_partkb
this.Control[iCurrent+2]=this.dw_pisr020i_01
this.Control[iCurrent+3]=this.st_vsplitbar
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.gb_1
end on

on w_pisr020i.destroy
call super::destroy
destroy(this.tv_partkb)
destroy(this.dw_pisr020i_01)
destroy(this.st_vsplitbar)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_print)
destroy(this.gb_1)
end on

event open;call super::open;
this.PostEvent ( "ue_init" )
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

tv_partkb.Height 		= newheight - ( tv_partkb.y 		+ ls_status )
dw_pisr020i_01.Width = newwidth 	- ( dw_pisr020i_01.X + ls_gap * 2 )
dw_pisr020i_01.Height= tv_partkb.Height
//dw_pisr020i_01.Width = newwidth 	- ( dw_pisr020i_01.x + dw_pisr020i_02.Width + ls_gap * 2 )
//dw_pisr020i_01.Height= tv_partkb.Height
//dw_pisr020i_02.x		= newwidth	- ( dw_pisr020i_02.Width + ls_gap )
//dw_pisr020i_02.Height= tv_partkb.Height

st_vsplitbar.y 		= tv_partkb.y
st_vsplitbar.Height 	= tv_partkb.Height

end event

event ue_retrieve;call super::ue_retrieve;dw_pisr020i_01.SetRedraw(False)
dw_pisr020i_01.SetTransObject(Sqlpis)
dw_pisr020i_01.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.itemCode)
dw_pisr020i_01.SetRedraw(True)

if dw_pisr020i_01.GetRow() < 1 then
	return 0
end if
istr_partKB.applydate = dw_pisr020i_01.GetItemString( dw_pisr020i_01.GetRow(), 'applyfrom' )
//istr_partKB.applydate = dw_pisr020i_01.GetItemString( currentrow, 'applyfrom' )
//MessageBox( "테스트", istr_partkb.areacode+','+istr_partkb.divcode+','+istr_partkb.suppcode+','+istr_partkb.itemcode+','+istr_partkb.applydate  )

//dw_pisr020i_02.SetRedraw(False)
//dw_pisr020i_02.SetTransObject(Sqlpis)
//dw_pisr020i_02.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.applydate )
//dw_pisr020i_02.SetRedraw(True)
////dw_pisr020i_02.SetRedraw(False)
////dw_pisr020i_02.SetTransObject(Sqlpis)
////dw_pisr020i_02.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.applydate )
////dw_pisr020i_02.SetRedraw(True)
//
end event

event ue_postopen;call super::ue_postopen;
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

end event

event ue_print;call super::ue_print;//OpenSheet( w_pisr010p, w_frame, 0, Layered!)
str_easy lstr_prt

dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(istr_partkb.areacode, istr_partkb.divcode, istr_partkb.suppcode, istr_partkb.itemcode)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '외주간판기본변경이력 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr020i
end type

type tv_partkb from u_pisr_treeview within w_pisr020i
integer x = 14
integer y = 192
integer width = 768
integer height = 1700
integer taborder = 20
boolean bringtotop = true
end type

event constructor;call super::constructor;uf_setLevelGubun(3)
end event

event selectionchanged;call super::selectionchanged;istr_partkb = uistr_partKB

Parent.TriggerEvent("ue_retrieve") 

end event

type dw_pisr020i_01 from u_vi_std_datawindow within w_pisr020i
integer x = 795
integer y = 192
integer width = 2752
integer height = 1700
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr020i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//istr_partKB.applydate = dw_pisr020i_01.GetItemString( currentrow, 'applyfrom' )
////MessageBox( "테스트", istr_partkb.areacode+','+istr_partkb.divcode+','+istr_partkb.suppcode+','+istr_partkb.itemcode+','+istr_partkb.applydate  )
//
//dw_pisr020i_02.SetRedraw(False)
//dw_pisr020i_02.SetTransObject(Sqlpis)
//dw_pisr020i_02.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.applydate )
//dw_pisr020i_02.SetRedraw(True)
//
end event

type st_vsplitbar from u_pism_splitbar within w_pisr020i
integer x = 782
integer y = 188
integer width = 18
integer height = 1700
boolean bringtotop = true
end type

type uo_area from u_pisc_select_area within w_pisr020i
event destroy ( )
integer x = 87
integer y = 68
integer taborder = 50
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;//ib_allflag = True
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										True, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode,true)
end event

type uo_division from u_pisc_select_division within w_pisr020i
event destroy ( )
integer x = 631
integer y = 68
integer taborder = 60
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode,true)
end event

type dw_print from datawindow within w_pisr020i
integer x = 923
integer y = 696
integer width = 1472
integer height = 780
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "간판기본정보 이력출력"
string dataobject = "d_pisr020p_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisr020i
integer x = 14
integer width = 1221
integer height = 180
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

