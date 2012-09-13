$PBExportHeader$w_pisr135p.srw
$PBExportComments$사급품반출증출력
forward
global type w_pisr135p from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr135p
end type
type uo_division from u_pisc_select_division within w_pisr135p
end type
type dw_2 from u_vi_std_datawindow within w_pisr135p
end type
type dw_3 from u_vi_std_datawindow within w_pisr135p
end type
type st_hsplitbar from u_pism_splitbar within w_pisr135p
end type
type rb_1 from radiobutton within w_pisr135p
end type
type rb_2 from radiobutton within w_pisr135p
end type
type gb_1 from groupbox within w_pisr135p
end type
type gb_3 from groupbox within w_pisr135p
end type
type dw_print from datawindow within w_pisr135p
end type
end forward

global type w_pisr135p from w_ipis_sheet01
integer width = 3963
event ue_init ( )
uo_area uo_area
uo_division uo_division
dw_2 dw_2
dw_3 dw_3
st_hsplitbar st_hsplitbar
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
gb_3 gb_3
dw_print dw_print
end type
global w_pisr135p w_pisr135p

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
end variables

event ue_init();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_hsplitbar.of_Register(dw_2, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_3, st_hsplitbar.BELOW)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

/////////////////삭제할 부분
//if isNull(g_s_deptcd) Or Trim(g_s_deptcd) = '' Then g_s_deptcd = '731H'
/////////////////삭제할 부분

end event

on w_pisr135p.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_hsplitbar=create st_hsplitbar
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.st_hsplitbar
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.dw_print
end on

on w_pisr135p.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_hsplitbar)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_print)
end on

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
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

rb_1.Checked = True
rb_1.Weight  = 700

dw_print.Visible = False

This.TriggerEvent( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;Long 		ll_Row

IF rb_1.Checked THEN
	dw_2.DataObject = "d_pisr135p_01"
Else 
	dw_2.DataObject = "d_pisr135p_02"
END IF

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, g_s_deptcd)

//If ll_Row < 1 Then 
//	MessageBox('확인', '승인완료된 사급품반출증LIST가 존재하지 않습니다.', Information! )
//	dw_3.Reset()
//	Return
//End If	

dw_2.Event RowfocusChanged(1)
Return

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

st_hsplitbar.x 		= dw_3.x
st_hsplitbar.y 		= dw_3.y - ls_split
st_hsplitbar.Width 	= dw_3.Width 

end event

event ue_print;call super::ue_print;
Long 		ll_selectRow
Integer	li_Cnt
DateTime	ldt_nowTime
String	ls_buybackdate
str_easy lstr_prt
String	ls_buybackNo

ll_selectRow 	= dw_2.GetRow()

If ll_selectRow < 1 Then Return

ldt_nowTime		= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_buybackdate	= left(String(ldt_nowTime, "yyyy.mm.dd hh:mm"), 10)

li_Cnt			= 0

dw_2.SetItem(ll_selectRow, 'buybackdate'	, ls_buybackdate)
dw_2.SetItem(ll_selectRow, 'statusflag'	, 'D')
dw_2.SetItem(ll_selectRow, 'lastemp'		, 'Y')	//Interface Flag 활용
dw_2.SetItem(ll_selectRow, 'lastdate'		, ldt_nowTime)

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

dw_2.SetTransObject(Sqlpis)									//간판상태
If dw_2.Update() = -1 Then 
//	MessageBox("반출증출력실패", "반출증정보 Update에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

ls_buybackNo			= dw_2.GetItemString(ll_selectRow, 'buybackno' )
dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(ls_buybackNo, ls_buybackdate)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '반출증(송장)출력'
//OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
OpenSheetWithParm(w_pisr136p, lstr_prt, w_frame, 0, Layered!)

This.TriggerEvent( "ue_retrieve" )

Return 0 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
MessageBox("반출증출력실패", "반출증정보 Update에서 오류가 발생하였습니다.", StopSign! )

return -1


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr135p
end type

type uo_area from u_pisc_select_area within w_pisr135p
integer x = 59
integer y = 72
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

End If

istr_partkb.areacode = is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

//dw_condition.Reset()
//dw_condition.InsertRow(1)
dw_2.Reset()
dw_3.Reset()


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr135p
integer x = 571
integer y = 72
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

//dw_condition.Reset()
//dw_condition.InsertRow(1)

//dw_2.Reset()
//dw_3.Reset()
Parent.TriggerEvent("ue_retrieve")
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_2 from u_vi_std_datawindow within w_pisr135p
integer x = 23
integer y = 208
integer width = 3058
integer height = 748
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr135p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;
If currentrow <= 0 Or RowCount() = 0 Then Return 

String	ls_buybackno, ls_buybackdate
DateTime	ldt_buybacktime

ls_buybackno 		= This.GetItemString(currentrow, "buybackno") 
ldt_buybacktime 	= This.GetItemDateTime(currentrow, "buybacktime") 
//ls_buybackdate		= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_buybacktime )	//기준일자 -8시간고려함
ls_buybackdate		= left(String(ldt_buybacktime, "yyyy.mm.dd hh:mm"), 10)

dw_3.SetRedraw(False)
dw_3.SetTransObject(Sqlpis)
dw_3.Retrieve(ls_buybackno, ls_buybackdate)
dw_3.SetRedraw(True)

end event

type dw_3 from u_vi_std_datawindow within w_pisr135p
integer x = 23
integer y = 972
integer width = 3054
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr135i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_hsplitbar from u_pism_splitbar within w_pisr135p
integer x = 18
integer y = 952
boolean bringtotop = true
end type

type rb_1 from radiobutton within w_pisr135p
integer x = 1248
integer y = 80
integer width = 581
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "미발행반출증"
borderstyle borderstyle = stylelowered!
end type

event clicked;String	ls_buybackNo

rb_1.Weight = 700
rb_2.Weight = 400

parent.TriggerEvent("ue_retrieve")
//dw_2.Reset()
//
//ls_buybackNo = wf_setbuybackno()
//dw_buyback.Reset()
//dw_buyback.InsertRow(1)
//dw_buyback.SetItem(1, 'buybackno'	, ls_buybackNo)
//dw_buyback.SetItem(1, 'areacode'		, istr_partkb.areaCode )
//dw_buyback.SetItem(1, 'divcode'		, istr_partkb.divCode )
//dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd )
//dw_buyback.SetItem(1, 'deptname'		, is_deptname )
//dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno )
//dw_buyback.SetItem(1, 'empname'		, is_empname )
//
//
end event

type rb_2 from radiobutton within w_pisr135p
integer x = 1851
integer y = 80
integer width = 585
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "재발행반출증"
borderstyle borderstyle = stylelowered!
end type

event clicked;
String	ls_buybackNo
rb_1.Weight = 400
rb_2.Weight = 700

parent.TriggerEvent("ue_retrieve")
//
//ls_buybackNo = wf_setbuybackno()
//If ls_buybackNo = '' Then
//	rb_1.Checked = True
//	rb_1.TriggerEvent( "clicked")
//	Return
//End If
//
//dw_buyback.Reset()
//dw_buyback.SetTransObject(sqlpis)
//dw_buyback.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_buybackNo, g_s_deptcd)

end event

type gb_1 from groupbox within w_pisr135p
integer x = 23
integer width = 1147
integer height = 192
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

type gb_3 from groupbox within w_pisr135p
integer x = 1189
integer width = 1275
integer height = 192
integer taborder = 20
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

type dw_print from datawindow within w_pisr135p
integer x = 745
integer y = 1152
integer width = 1618
integer height = 700
integer taborder = 21
boolean titlebar = true
string title = "반출증출력"
string dataobject = "d_pisr135p_prt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;
long 		li_pgline = 19
Long 		LastRow
integer 	iLastLine, li_ColNo, I, li_Line, li_Col, iFirstLine
integer 	iChkLine, li_FpgNo, li_LpgNo, li_SpcLine
String 	ls_Tab
//DataWindowChild dw_print
//
//If dw_print.GetChild( 'dw_p1', dw_print) = -1 Then Return


//IF Not SpaceLine Or dw_print.RowCount() = 0 THEN return
IF dw_print.RowCount() = 0 THEN return
iLastLine  = 0
iFirstLine = 1

SetPointer(HourGlass!)
dw_print.SetReDraw( FALSE )

   /* 다음 페이지 이전까지 공백 삽입 */
   iChkLine = dw_print.ScrollNextPage()
   /* 마지막 페이지로 이동 */
   DO WHILE iFirstLine <> iChkLine
	   iChkLine = iFirstLine
   	iFirstLine = dw_print.ScrollNextPage()
   LOOP 

   iLastLine = 0

   If Not IsNull(li_pgline) And li_pgline > 0 Then
      If rowcount <= li_pgline Then
	      li_Line = li_pgline - rowcount
      Else
	      li_Line = 0
      End If
   End If
   iLastLine = li_Line + rowcount

   For I = 1 To li_Line Step 1
	  ls_Tab = ls_Tab + "~r~n"
   Next 
   dw_print.importString(ls_Tab)

   ls_Tab = "~r~n"
   iChkLine = dw_print.ScrollNextPage()
 
   DO WHILE iFirstLine = iChkLine // li_FpgNo = li_LpgNo //AND iLastLine < 40
      dw_print.importString(ls_Tab)
   	iLastLine++
	   iChkLine = dw_print.ScrollNextPage()
   LOOP
//
Long  ll_RowCnt 
String	ls_Value

ll_RowCnt = dw_print.RowCount()
if ll_RowCnt > 1 Then
	ls_Value = This.GetItemString(1,"carno") 
	This.SetItem( ll_RowCnt,"carno",ls_Value )
	ls_Value = This.GetItemString(1,"takingname")
	This.SetItem( ll_RowCnt,"takingname",ls_Value )
end if
//
SetPointer(Arrow!)
end event

