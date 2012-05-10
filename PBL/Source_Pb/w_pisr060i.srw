$PBExportHeader$w_pisr060i.srw
$PBExportComments$납품표발행현황조회
forward
global type w_pisr060i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr060i
end type
type uo_division from u_pisc_select_division within w_pisr060i
end type
type tv_partkb from u_pisr_treeview within w_pisr060i
end type
type st_vsplitbar from u_pism_splitbar within w_pisr060i
end type
type dw_pisr060i_01 from u_vi_std_datawindow within w_pisr060i
end type
type gb_1 from groupbox within w_pisr060i
end type
end forward

global type w_pisr060i from w_ipis_sheet01
event ue_init ( )
uo_area uo_area
uo_division uo_division
tv_partkb tv_partkb
st_vsplitbar st_vsplitbar
dw_pisr060i_01 dw_pisr060i_01
gb_1 gb_1
end type
global w_pisr060i w_pisr060i

type variables
str_pisr_partkb istr_partkb
end variables

event ue_init();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_pisr060i_01, st_vsplitbar.RIGHT)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

// TreeView 설정
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

on w_pisr060i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.tv_partkb=create tv_partkb
this.st_vsplitbar=create st_vsplitbar
this.dw_pisr060i_01=create dw_pisr060i_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.tv_partkb
this.Control[iCurrent+4]=this.st_vsplitbar
this.Control[iCurrent+5]=this.dw_pisr060i_01
this.Control[iCurrent+6]=this.gb_1
end on

on w_pisr060i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.tv_partkb)
destroy(this.st_vsplitbar)
destroy(this.dw_pisr060i_01)
destroy(this.gb_1)
end on

event open;call super::open;this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;
DateTime	ldt_nowTime
String	ls_toDay

ldt_nowTime	= f_pisc_get_date_nowtime()														//현재 시스템시간
istr_partKB.applydate = Left(String(ldt_nowTime, "yyyy.mm.dd hh:mm"), 10)

//messagebox("",istr_partKB.areaCode + istr_partKB.divCode + istr_partKB.suppCode + istr_partKB.applydate)
dw_pisr060i_01.SetRedraw(False)
dw_pisr060i_01.SetTransObject(Sqlpis)
dw_pisr060i_01.Retrieve(istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.applydate)
dw_pisr060i_01.SetRedraw(True)

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

tv_partkb.Height 		= newheight - ( tv_partkb.y 		+ ls_status )
dw_pisr060i_01.Height= tv_partkb.Height
dw_pisr060i_01.Width = newwidth 	- ( dw_pisr060i_01.x + ls_gap )

st_vsplitbar.y 		= tv_partkb.y
st_vsplitbar.Height 	= tv_partkb.Height

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

type uo_status from w_ipis_sheet01`uo_status within w_pisr060i
end type

type uo_area from u_pisc_select_area within w_pisr060i
event destroy ( )
integer x = 82
integer y = 76
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
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode,true)
end event

type uo_division from u_pisc_select_division within w_pisr060i
event destroy ( )
integer x = 631
integer y = 76
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

type tv_partkb from u_pisr_treeview within w_pisr060i
integer y = 192
integer width = 718
integer height = 1704
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;uf_setLevelGubun(2)
end event

event selectionchanged;call super::selectionchanged;istr_partkb = uistr_partKB

//MESSAGEBOX( "", istr_partkb.SUPPCODE )

Parent.TriggerEvent("ue_retrieve") 

end event

type st_vsplitbar from u_pism_splitbar within w_pisr060i
integer x = 713
integer y = 192
integer width = 18
integer height = 1704
boolean bringtotop = true
end type

type dw_pisr060i_01 from u_vi_std_datawindow within w_pisr060i
integer x = 727
integer y = 192
integer width = 2871
integer height = 1704
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pisr060i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_pisr060i
integer x = 18
integer width = 1202
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

