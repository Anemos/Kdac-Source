$PBExportHeader$w_pisr137i.srw
$PBExportComments$사급품반출확인현황
forward
global type w_pisr137i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr137i
end type
type uo_division from u_pisc_select_division within w_pisr137i
end type
type dw_2 from u_vi_std_datawindow within w_pisr137i
end type
type uo_from from u_pisc_date_applydate within w_pisr137i
end type
type uo_to from u_pisc_date_applydate_1 within w_pisr137i
end type
type st_2 from statictext within w_pisr137i
end type
type gb_1 from groupbox within w_pisr137i
end type
type gb_4 from groupbox within w_pisr137i
end type
end forward

global type w_pisr137i from w_ipis_sheet01
integer width = 4242
event ue_init ( )
uo_area uo_area
uo_division uo_division
dw_2 dw_2
uo_from uo_from
uo_to uo_to
st_2 st_2
gb_1 gb_1
gb_4 gb_4
end type
global w_pisr137i w_pisr137i

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
end variables

event ue_init();
Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

end event

on w_pisr137i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_2=create st_2
this.gb_1=create gb_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_from
this.Control[iCurrent+5]=this.uo_to
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_4
end on

on w_pisr137i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.gb_4)
end on

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										True, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
ib_open = True
istr_partkb.areacode = uo_area.is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

end event

event open;call super::open;
//dw_condition.SetTransObject(sqlpis)
//dw_condition.Reset()
//dw_condition.InsertRow(1)
//

This.TriggerEvent( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;
String	ls_carNo
Long 		ll_Row

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, uo_from.is_uo_date, uo_to.is_uo_date)

If ll_Row < 1 Then 
	MessageBox('확인', '반출확인된 송장이 존재하지 않습니다.', Information! )
	Return
End If	

//dw_2.Event RowfocusChanged(1)
Return

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight - ( dw_2.y + ls_status )


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr137i
end type

type uo_area from u_pisc_select_area within w_pisr137i
integer x = 64
integer y = 84
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											True, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

End If

istr_partkb.areacode = is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_2.Reset()


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr137i
integer x = 576
integer y = 84
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_2.Reset()

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_2 from u_vi_std_datawindow within w_pisr137i
integer x = 23
integer y = 220
integer width = 3058
integer height = 748
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr137i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_from from u_pisc_date_applydate within w_pisr137i
integer x = 1257
integer y = 84
integer taborder = 70
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
dw_2.Reset()

end event

on uo_from.destroy
call u_pisc_date_applydate::destroy
end on

type uo_to from u_pisc_date_applydate_1 within w_pisr137i
event destroy ( )
integer x = 2034
integer y = 84
integer taborder = 40
boolean bringtotop = true
end type

on uo_to.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_2.Reset()
//dw_3.Reset()

end event

type st_2 from statictext within w_pisr137i
integer x = 1957
integer y = 84
integer width = 73
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisr137i
integer x = 27
integer width = 1147
integer height = 208
integer taborder = 50
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

type gb_4 from groupbox within w_pisr137i
integer x = 1198
integer width = 1335
integer height = 208
integer taborder = 60
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

