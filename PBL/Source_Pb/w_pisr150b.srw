$PBExportHeader$w_pisr150b.srw
$PBExportComments$개별간판 Active, Sleeping 전환
forward
global type w_pisr150b from w_ipis_sheet01
end type
type rb_1 from radiobutton within w_pisr150b
end type
type rb_2 from radiobutton within w_pisr150b
end type
type dw_pisr150b_01 from datawindow within w_pisr150b
end type
type dw_pisr150b_02 from u_vi_std_datawindow within w_pisr150b
end type
type uo_area from u_pisc_select_area within w_pisr150b
end type
type uo_division from u_pisc_select_division within w_pisr150b
end type
type dw_scan from datawindow within w_pisr150b
end type
type cb_1 from commandbutton within w_pisr150b
end type
type cb_2 from commandbutton within w_pisr150b
end type
type gb_2 from groupbox within w_pisr150b
end type
type gb_3 from groupbox within w_pisr150b
end type
type gb_scan from groupbox within w_pisr150b
end type
type gb_1 from groupbox within w_pisr150b
end type
end forward

global type w_pisr150b from w_ipis_sheet01
event ue_process ( )
event ue_init ( )
rb_1 rb_1
rb_2 rb_2
dw_pisr150b_01 dw_pisr150b_01
dw_pisr150b_02 dw_pisr150b_02
uo_area uo_area
uo_division uo_division
dw_scan dw_scan
cb_1 cb_1
cb_2 cb_2
gb_2 gb_2
gb_3 gb_3
gb_scan gb_scan
gb_1 gb_1
end type
global w_pisr150b w_pisr150b

type variables
str_pisr_partkb istr_partkb
String	is_partkbno
String	is_nowTime, is_jobDate, is_applyDate	//현재시간, 작업기준일자, 마감기준일자
DateTime	idt_nowTime										//현재시간
String	is_null
end variables

forward prototypes
public function integer wf_validchk (string as_activegubun)
end prototypes

event ue_process();//////////////////////////////////
//		발주 작업 Control
//////////////////////////////////
Long		ll_Row

CHOOSE CASE rb_1.Checked

CASE True		//Active →Sleeping 전환
		ll_Row = wf_validchk('A')
		If ll_Row = -1 Then 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.Object.scancode.SetFocus()
			Return
		End If
		dw_pisr150b_01.SetItem(ll_Row, 'kbactivegubun'	, 'S')
		dw_pisr150b_01.SetItem(ll_Row, 'partkbstatus'	, 'D')
		dw_pisr150b_01.SetItem(ll_Row, 'kborderpossible', 'N')
		dw_pisr150b_01.SetItem(ll_Row, 'lastemp'			, 'Y')	// Interface Flag 활용
		dw_pisr150b_01.SetItem(ll_Row, 'lastdate'			, idt_nowtime)
CASE ELSE		//Sleeping →Active 전환
		ll_Row = wf_validchk('S')
		If ll_Row = -1 Then 
			dw_scan.SetItem(1, 'scancode', is_null )
			dw_scan.Object.scancode.SetFocus()
			Return
		End If
		dw_pisr150b_01.SetItem(ll_Row, 'kbactivegubun'	, 'A')
		dw_pisr150b_01.SetItem(ll_Row, 'partkbstatus'	, 'D')
		dw_pisr150b_01.SetItem(ll_Row, 'kborderpossible', 'Y')
		dw_pisr150b_01.SetItem(ll_Row, 'lastemp'			, 'Y')	// Interface Flag 활용
		dw_pisr150b_01.SetItem(ll_Row, 'lastdate'			, idt_nowtime)
END CHOOSE

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

//	간판상태저장
dw_pisr150b_01.SetTransObject(Sqlpis)									//간판상태
If dw_pisr150b_01.Update() = -1 Then
//	MessageBox("실패", "간판 운용전환에 실패하였습니다.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

dw_pisr150b_01.RowsCopy(1,1, Primary!, dw_pisr150b_02, 1, Primary!)

Return

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox("실패", "간판 운용전환에 실패하였습니다.", StopSign! )

Return 

end event

event ue_init();
SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

public function integer wf_validchk (string as_activegubun);
String	ls_areaCode, ls_divCode
String	ls_KBStatus, ls_OrderPossible, ls_useFlag, ls_ReprintFlag, ls_kbactivegubun
Long		ll_Row

dw_pisr150b_01.SetTransObject (sqlpis)
ll_Row = dw_pisr150b_01.Retrieve(is_partkbno, is_jobdate)
If ll_Row = 0 Then 
	MessageBox( "입력오류", "존재하지 않는 간판번호입니다. ", StopSign! )
	dw_pisr150b_01.ReSet() 
	dw_pisr150b_01.InsertRow(1) 
	Return -1
End If

ls_areaCode			= dw_pisr150b_01.GetItemString( ll_Row, 'areacode' )
ls_divCode			= dw_pisr150b_01.GetItemString( ll_Row, 'divisioncode' )
If ls_areaCode <> istr_partkb.areacode Or ls_divCode <> istr_partkb.divcode Then 
	MessageBox( "입력오류", "해당 공장의 간판이 아닙니다.", StopSign! )
	dw_pisr150b_01.ReSet() 
	dw_pisr150b_01.InsertRow(1) 
	Return -1
End If

ls_useFlag			= dw_pisr150b_01.GetItemString( ll_Row, 'useflag' )
If ls_useFlag = 'Y' Then 
	MessageBox( "입력오류", "사용중단된 간판입니다. ", StopSign! )
	dw_pisr150b_01.ReSet() 
	dw_pisr150b_01.InsertRow(1) 
	Return -1
End If

ls_kbactivegubun	= dw_pisr150b_01.GetItemString( ll_Row, 'kbactivegubun' )
CHOOSE CASE as_activegubun
	CASE 'A'
			If ls_kbactivegubun = 'S' Then 
				MessageBox( "입력오류", "Sleeping 상태의 간판입니다. ", StopSign! )
				dw_pisr150b_01.ReSet() 
				dw_pisr150b_01.InsertRow(1) 
				Return -1
			End If
	CASE 'S'
			If ls_kbactivegubun = 'A' Then 
				MessageBox( "입력오류", "Active 상태의 간판입니다. ", StopSign! )
				dw_pisr150b_01.ReSet() 
				dw_pisr150b_01.InsertRow(1) 
				Return -1
			End If

			ls_ReprintFlag		= dw_pisr150b_01.GetItemString( ll_Row, 'reprintflag' )
			If ls_ReprintFlag = 'Y' Then 
			MessageBox( "발행요청", "신규 또는 기본정보 변경으로인해 발행이 필요한 간판입니다. ", Information! )
			End If
END CHOOSE

ls_KBStatus			= dw_pisr150b_01.GetItemString( ll_Row, 'partkbstatus' )
CHOOSE CASE ls_KBStatus
	CASE 'A'
			MessageBox( "입력오류", "이미 발주처리된 간판은 전환이 불가능합니다.", StopSign! )
			dw_pisr150b_01.ReSet() 
			dw_pisr150b_01.InsertRow(1) 
			Return -1
	CASE 'B'
			MessageBox( "입력오류", "현재 가입고상태의 간판은 전환이 불가능합니다.", StopSign! )
			dw_pisr150b_01.ReSet() 
			dw_pisr150b_01.InsertRow(1) 
			Return -1
	CASE ELSE
END CHOOSE

return ll_Row


end function

on w_pisr150b.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_pisr150b_01=create dw_pisr150b_01
this.dw_pisr150b_02=create dw_pisr150b_02
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_scan=create dw_scan
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_scan=create gb_scan
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.dw_pisr150b_01
this.Control[iCurrent+4]=this.dw_pisr150b_02
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.dw_scan
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_scan
this.Control[iCurrent+13]=this.gb_1
end on

on w_pisr150b.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_pisr150b_01)
destroy(this.dw_pisr150b_02)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_scan)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_scan)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr150b_02.Width = newwidth 	- ( dw_pisr150b_02.x + ls_gap * 2 )
dw_pisr150b_02.Height= newheight - ( dw_pisr150b_02.y + ls_status )

end event

event open;call super::open;
SetNull(is_null)
rb_1.Checked 			= True
rb_1.Weight = 700

dw_scan.SetTransObject(sqlpis)
dw_scan.InsertRow(1) 

dw_pisr150b_01.SetTransObject (sqlpis)
dw_pisr150b_01.InsertRow(1) 

this.PostEvent ( "ue_init" )

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

event activate;call super::activate;dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr150b
integer y = 1884
end type

type rb_1 from radiobutton within w_pisr150b
integer x = 1312
integer y = 72
integer width = 914
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "Active →Sleeping 전환"
end type

event clicked;rb_1.Weight = 700
rb_2.Weight = 400

dw_pisr150b_01.Reset()
dw_pisr150b_01.SetTransObject (sqlpis)
dw_pisr150b_01.InsertRow(1) 

dw_pisr150b_02.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type rb_2 from radiobutton within w_pisr150b
integer x = 2240
integer y = 72
integer width = 914
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "Sleeping →Active 전환"
end type

event clicked;rb_1.Weight = 400
rb_2.Weight = 700

dw_pisr150b_01.Reset()
dw_pisr150b_01.SetTransObject (sqlpis)
dw_pisr150b_01.InsertRow(1) 

dw_pisr150b_02.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_pisr150b_01 from datawindow within w_pisr150b
integer x = 18
integer y = 376
integer width = 3259
integer height = 588
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr150b_01"
boolean border = false
boolean livescroll = true
end type

event clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1
end event

type dw_pisr150b_02 from u_vi_std_datawindow within w_pisr150b
integer x = 9
integer y = 976
integer width = 2766
integer height = 808
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisr150b_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
Return 1
end event

type uo_area from u_pisc_select_area within w_pisr150b
event destroy ( )
integer x = 82
integer y = 76
integer taborder = 60
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


dw_pisr150b_01.Reset()
dw_pisr150b_01.SetTransObject (sqlpis)
dw_pisr150b_01.InsertRow(1) 

dw_pisr150b_02.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type uo_division from u_pisc_select_division within w_pisr150b
event destroy ( )
integer x = 631
integer y = 76
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode

dw_pisr150b_01.Reset()
dw_pisr150b_01.SetTransObject (sqlpis)
dw_pisr150b_01.InsertRow(1) 

dw_pisr150b_02.Reset()
is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

type dw_scan from datawindow within w_pisr150b
integer x = 32
integer y = 212
integer width = 1330
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_scan"
boolean border = false
boolean livescroll = true
end type

event getfocus;
This.SelectText(1,15)
end event

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "확인", "작업처리 권한이 부여되지 않았습니다.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

If len(data) <> 11 Then 
	MessageBox( "입력오류", "올바른 간판번호 가 아닙니다.", StopSign! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

idt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간고려함
is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간,마감일 고려함

is_partkbno = data
parent.TriggerEvent( "ue_process" )

this.Event getfocus()
end event

type cb_1 from commandbutton within w_pisr150b
integer x = 1925
integer y = 228
integer width = 553
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "발주및발주취소"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110  
   WHERE WIN_ID = 'w_pisr110b' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type cb_2 from commandbutton within w_pisr150b
integer x = 2514
integer y = 228
integer width = 704
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "개별간판Active전환"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110
   WHERE WIN_ID = 'w_pisr150b' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type gb_2 from groupbox within w_pisr150b
integer x = 1243
integer width = 2002
integer height = 180
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisr150b
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

type gb_scan from groupbox within w_pisr150b
integer x = 18
integer y = 168
integer width = 1358
integer height = 208
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr150b
integer x = 1883
integer y = 164
integer width = 1362
integer height = 180
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217730
long backcolor = 12632256
end type

