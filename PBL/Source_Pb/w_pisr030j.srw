$PBExportHeader$w_pisr030j.srw
$PBExportComments$월간 자재소요량예시 간판매수(제품군)
forward
global type w_pisr030j from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr030j
end type
type uo_division from u_pisc_select_division within w_pisr030j
end type
type tv_partkb from u_pisr_treeview within w_pisr030j
end type
type dw_pisr030j_01 from u_vi_std_datawindow within w_pisr030j
end type
type uo_today from u_pisc_date_applydate within w_pisr030j
end type
type dw_pisr030j_02 from datawindow within w_pisr030j
end type
type st_vsplitbar from u_pism_splitbar within w_pisr030j
end type
type st_vsplitbar2 from u_pism_splitbar within w_pisr030j
end type
type gb_1 from groupbox within w_pisr030j
end type
type dw_print from datawindow within w_pisr030j
end type
end forward

global type w_pisr030j from w_ipis_sheet01
integer width = 3922
event ue_init ( )
uo_area uo_area
uo_division uo_division
tv_partkb tv_partkb
dw_pisr030j_01 dw_pisr030j_01
uo_today uo_today
dw_pisr030j_02 dw_pisr030j_02
st_vsplitbar st_vsplitbar
st_vsplitbar2 st_vsplitbar2
gb_1 gb_1
dw_print dw_print
end type
global w_pisr030j w_pisr030j

type variables
str_pisr_partkb istr_partkb
Boolean ib_Scrolling1, ib_Scrolling2, ib_Scrolling3
end variables

event ue_init();
dw_print.Visible 		= False

Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_pisr030j_01, st_vsplitbar.RIGHT)
st_vsplitbar2.of_Register(dw_pisr030j_01, st_vsplitbar.LEFT)
st_vsplitbar2.of_Register(dw_pisr030j_02, st_vsplitbar.RIGHT)

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

on w_pisr030j.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.tv_partkb=create tv_partkb
this.dw_pisr030j_01=create dw_pisr030j_01
this.uo_today=create uo_today
this.dw_pisr030j_02=create dw_pisr030j_02
this.st_vsplitbar=create st_vsplitbar
this.st_vsplitbar2=create st_vsplitbar2
this.gb_1=create gb_1
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.tv_partkb
this.Control[iCurrent+4]=this.dw_pisr030j_01
this.Control[iCurrent+5]=this.uo_today
this.Control[iCurrent+6]=this.dw_pisr030j_02
this.Control[iCurrent+7]=this.st_vsplitbar
this.Control[iCurrent+8]=this.st_vsplitbar2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_print
end on

on w_pisr030j.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.tv_partkb)
destroy(this.dw_pisr030j_01)
destroy(this.uo_today)
destroy(this.dw_pisr030j_02)
destroy(this.st_vsplitbar)
destroy(this.st_vsplitbar2)
destroy(this.gb_1)
destroy(this.dw_print)
end on

event open;call super::open;this.PostEvent ( "ue_init" )

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

tv_partkb.Height 		= newheight - ( tv_partkb.y 		+ ls_status )
dw_pisr030j_01.Height= tv_partkb.Height
dw_pisr030j_02.x 		= dw_pisr030j_01.x + dw_pisr030j_01.Width + ls_split
dw_pisr030j_02.Width = newwidth - ( dw_pisr030j_02.x + ls_gap )
dw_pisr030j_02.Height= tv_partkb.Height
//dw_pisr030j_02.x		= newwidth	- ( dw_pisr020i_02.Width + ls_gap )

st_vsplitbar.y 		= tv_partkb.y
st_vsplitbar.Height 	= tv_partkb.Height
st_vsplitbar2.x 		= dw_pisr030j_02.x - ls_split
st_vsplitbar2.Height	= tv_partkb.Height
st_vsplitbar2.y 		= tv_partkb.y
st_vsplitbar2.Height	= tv_partkb.Height

end event

event ue_retrieve;call super::ue_retrieve;istr_partKB.applydate = uo_today.is_uo_date

dw_pisr030j_01.SetRedraw(False)
dw_pisr030j_01.SetTransObject(Sqlpis)
dw_pisr030j_01.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.applydate)
dw_pisr030j_01.SetRedraw(True)

//MessageBox( "테스트", istr_partkb.areacode+','+istr_partkb.divcode+','+istr_partkb.suppcode+','+istr_partkb.itemcode+','+istr_partkb.applydate  )
dw_pisr030j_02.SetRedraw(False)
dw_pisr030j_02.SetTransObject(Sqlpis)
dw_pisr030j_02.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partKB.applydate )
dw_pisr030j_02.SetRedraw(True)

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

If istr_partkb.suppcode = '%' Then
	MessageBox( "선택오류", "원하는 업체를 선택하여 주세요.", Information!)
End If

dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(istr_partkb.areacode, istr_partkb.divcode, istr_partkb.suppcode, uo_today.is_uo_date)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '월간자재소요량예시표 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr030j
end type

type uo_area from u_pisc_select_area within w_pisr030j
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 40
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

type uo_division from u_pisc_select_division within w_pisr030j
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 50
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode,true)
end event

type tv_partkb from u_pisr_treeview within w_pisr030j
integer y = 192
integer height = 1692
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
end type

event selectionchanged;call super::selectionchanged;istr_partkb = uistr_partKB

//messagebox('', istr_partkb.suppcode )
Parent.TriggerEvent("ue_retrieve") 

end event

event constructor;call super::constructor;uf_setLevelGubun(2)
end event

type dw_pisr030j_01 from u_vi_std_datawindow within w_pisr030j
integer x = 727
integer y = 192
integer width = 2802
integer height = 1356
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr030j_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;If rowcount = 0 Then This.Tag = '' 

end event

event scrollvertical;call super::scrollvertical;If ib_Scrolling1  Then Return
ib_Scrolling2 = True
dw_pisr030j_02.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
ib_Scrolling2 = False
end event

type uo_today from u_pisc_date_applydate within w_pisr030j
event destroy ( )
integer x = 1230
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_today.destroy
call u_pisc_date_applydate::destroy
end on

type dw_pisr030j_02 from datawindow within w_pisr030j
integer x = 3538
integer y = 192
integer width = 462
integer height = 1692
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pisr030j_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event scrollvertical;If ib_Scrolling2  Then Return
ib_Scrolling1 = True
dw_pisr030j_01.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
ib_Scrolling1 = False
end event

type st_vsplitbar from u_pism_splitbar within w_pisr030j
integer x = 709
integer y = 192
integer width = 18
integer height = 1692
boolean bringtotop = true
long backcolor = 10789024
end type

type st_vsplitbar2 from u_pism_splitbar within w_pisr030j
integer x = 3525
integer y = 192
integer width = 18
integer height = 1692
boolean bringtotop = true
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr030j
integer x = 18
integer width = 1925
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

type dw_print from datawindow within w_pisr030j
integer x = 1294
integer y = 1060
integer width = 1618
integer height = 744
integer taborder = 21
boolean titlebar = true
string title = "월간자재소요량 예시표 출력"
string dataobject = "d_pisr030p_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

