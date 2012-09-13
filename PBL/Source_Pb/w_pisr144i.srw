$PBExportHeader$w_pisr144i.srw
$PBExportComments$불합격간판조회
forward
global type w_pisr144i from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_pisr144i
end type
type uo_area from u_pisc_select_area within w_pisr144i
end type
type dw_2 from u_vi_std_datawindow within w_pisr144i
end type
type gb_3 from groupbox within w_pisr144i
end type
type dw_print from datawindow within w_pisr144i
end type
type st_2 from statictext within w_pisr144i
end type
type st_3 from statictext within w_pisr144i
end type
end forward

global type w_pisr144i from w_ipis_sheet01
event ue_init ( )
uo_division uo_division
uo_area uo_area
dw_2 dw_2
gb_3 gb_3
dw_print dw_print
st_2 st_2
st_3 st_3
end type
global w_pisr144i w_pisr144i

type variables
str_pisr_partkb istr_partkb
end variables

event ue_init();
SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

This.TriggerEvent( "ue_retrieve" )




end event

on w_pisr144i.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_2=create dw_2
this.gb_3=create gb_3
this.dw_print=create dw_print
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
end on

on w_pisr144i.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_2)
destroy(this.gb_3)
destroy(this.dw_print)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;
this.PostEvent ( "ue_init" )


end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight - ( dw_2.y + ls_status )

end event

event ue_retrieve;call super::ue_retrieve;Long  	ll_Row
DateTime	ldt_nowTime

ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간

dw_2.SetRedraw(False)
dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )
dw_2.SetRedraw(True)

If ll_Row < 1 Then 
	MessageBox( "확인", "현재 Lot불합격 처리상태의 간판이 존재하지 않습니다.", Information!)
End If

Return

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

event ue_print;call super::ue_print;
str_easy lstr_prt
Long  	ll_Row
DateTime	ldt_nowTime

ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간

dw_print.SetTransObject(sqlpis)
ll_Row = dw_print.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ldt_nowTime )
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= 'LOT불량처리간판리스트 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

Return  


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr144i
end type

type uo_division from u_pisc_select_division within w_pisr144i
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 90
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_2.Reset()
end event

type uo_area from u_pisc_select_area within w_pisr144i
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 100
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

dw_2.Reset()
end event

type dw_2 from u_vi_std_datawindow within w_pisr144i
integer x = 18
integer y = 196
integer width = 1422
integer height = 1332
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr144i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_3 from groupbox within w_pisr144i
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
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_pisr144i
integer x = 1445
integer y = 460
integer width = 1038
integer height = 460
integer taborder = 21
string title = "none"
string dataobject = "d_pisr144p_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisr144i
integer x = 1307
integer y = 36
integer width = 2226
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "※ 본 화면에서는 LOT불량처리된 간판만 조회가 가능합니다."
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisr144i
integer x = 1403
integer y = 108
integer width = 1806
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 67108864
string text = "선별불량간판의 경우에는 품질관리에서 확인하셔야 합니다."
boolean focusrectangle = false
end type

