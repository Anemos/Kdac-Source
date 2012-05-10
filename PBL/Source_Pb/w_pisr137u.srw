$PBExportHeader$w_pisr137u.srw
$PBExportComments$사급품반출확인
forward
global type w_pisr137u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr137u
end type
type uo_division from u_pisc_select_division within w_pisr137u
end type
type dw_2 from u_vi_std_datawindow within w_pisr137u
end type
type dw_3 from u_vi_std_datawindow within w_pisr137u
end type
type st_hsplitbar from u_pism_splitbar within w_pisr137u
end type
type pb_1 from picturebutton within w_pisr137u
end type
type dw_scan from datawindow within w_pisr137u
end type
type gb_1 from groupbox within w_pisr137u
end type
type gb_2 from groupbox within w_pisr137u
end type
type gb_3 from groupbox within w_pisr137u
end type
end forward

global type w_pisr137u from w_ipis_sheet01
integer width = 4242
event ue_init ( )
uo_area uo_area
uo_division uo_division
dw_2 dw_2
dw_3 dw_3
st_hsplitbar st_hsplitbar
pb_1 pb_1
dw_scan dw_scan
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisr137u w_pisr137u

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
end variables

event ue_init();pb_1.Enabled =  m_frame.m_action.m_save.Enabled 

Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
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

end event

on w_pisr137u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_hsplitbar=create st_hsplitbar
this.pb_1=create pb_1
this.dw_scan=create dw_scan
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.st_hsplitbar
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.dw_scan
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_pisr137u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_hsplitbar)
destroy(this.pb_1)
destroy(this.dw_scan)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
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
dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1)
dw_scan.Object.scancode_t.Text = '차량번호:'

This.TriggerEvent( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;
String	ls_carNo
Long 		ll_Row

dw_scan.AcceptText()
ls_carNo	= dw_scan.GetItemString(1, 'scancode')

If isNull(ls_carNo) Or Trim(ls_carNo) = '' Then 
//	ls_carNo	= '%'
	MessageBox('확인', '조회할 차량번호를 입력하세요.', Information! )
	return
End If

ls_carNo = '%' + ls_carNo + '%'

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_carNo)

If ll_Row < 1 Then 
	MessageBox('확인', '작성된 반출송장이 존재하지 않습니다.', Information! )
	Return
End If	

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

event ue_save;call super::ue_save;           
Long 		ll_RowCnt, ll_selectChk
Integer	I, li_Cnt
DateTime	ldt_nowTime
Integer	li_Net

ll_RowCnt	= dw_2.RowCount()

If ll_RowCnt < 1 Then Return

ldt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
li_Cnt		= 0

For I = 1 To ll_RowCnt Step 1
	ll_selectChk	= dw_2.GetItemNumber( I, 'selectchk' )
	If ll_selectChk = 0 Then Continue
	li_Cnt			= li_Cnt + 1
	dw_2.SetItem(I, 'outemp'		, g_s_empno )
	dw_2.SetItem(I, 'outtime'		, ldt_nowTime )
	dw_2.SetItem(I, 'statusflag'	, 'E' )
	dw_2.SetItem(I, 'lastemp'		, 'Y' )	//Interface Flag 활용
	dw_2.SetItem(I, 'lastdate'		, ldt_nowTime )
Next

If li_Cnt < 1 Then 
	MessageBox("확인", "선택된 항목이 존재하지 않습니다. ", Information! )
	Return
End If

li_Net = MessageBox("반출확인", String(li_Cnt) + " 건의 반출증을 반출확인 하려고 합니다.~r~n" &
		                         + "~r~n반출확인처리 하시겠습니까?", Question!, YesNo!, 2)
IF li_Net <> 1 THEN
	MessageBox("반출취소", "반출확인 작업이 취소되었습니다.", Information! )
	Return 
END IF

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

dw_2.SetTransObject(Sqlpis)									//간판상태
If dw_2.Update() = -1 Then 
//	MessageBox("반출오류", "반출증정보 Update에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
MessageBox("반출완료", String(li_Cnt) + " 건의 반출증(송장) 반출확인 완료되었습니다.", Information! )
This.TriggerEvent( "ue_retrieve" )

Return  

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
MessageBox("반출오류", "반출증정보 Update에서 오류가 발생하였습니다.", StopSign! )

return 

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr137u
end type

type uo_area from u_pisc_select_area within w_pisr137u
integer x = 59
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

dw_scan.Reset()
dw_scan.InsertRow(1)
dw_2.Reset()
dw_3.Reset()


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr137u
integer x = 571
integer y = 84
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_scan.Reset()
dw_scan.InsertRow(1)

dw_2.Reset()
dw_3.Reset()

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_2 from u_vi_std_datawindow within w_pisr137u
integer x = 23
integer y = 220
integer width = 3058
integer height = 748
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr137u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
If currentrow <= 0 Or RowCount() = 0 Then Return 

String	ls_buybackno, ls_buybackdate
DateTime	ldt_buybacktime

ls_buybackno 		= This.GetItemString(currentrow, "buybackno") 
ldt_buybacktime 	= This.GetItemDateTime(currentrow, "buybacktime") 
ls_buybackdate		= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_buybacktime )	//기준일자 -8시간고려함

dw_3.SetRedraw(False)
dw_3.SetTransObject(Sqlpis)
dw_3.Retrieve(ls_buybackno, ls_buybackdate)
dw_3.SetRedraw(True)

end event

type dw_3 from u_vi_std_datawindow within w_pisr137u
integer x = 23
integer y = 984
integer width = 3054
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr135i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_hsplitbar from u_pism_splitbar within w_pisr137u
integer x = 18
integer y = 964
boolean bringtotop = true
end type

type pb_1 from picturebutton within w_pisr137u
integer x = 2638
integer y = 72
integer width = 288
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
boolean originalsize = true
end type

event clicked;
parent.TriggerEvent( "ue_save" )

dw_2.Reset()

dw_scan.SetItem(1, 'scancode', '' )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_scan from datawindow within w_pisr137u
integer x = 1211
integer y = 44
integer width = 1330
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;This.SelectText(1,15)
end event

event itemchanged;
If isNull(data) Or Trim(data) = '' then return 0
parent.TriggerEvent("ue_retrieve")

this.Event getfocus()
end event

type gb_1 from groupbox within w_pisr137u
integer x = 23
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

type gb_2 from groupbox within w_pisr137u
integer x = 2592
integer width = 375
integer height = 208
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisr137u
integer x = 1189
integer width = 1376
integer height = 208
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

