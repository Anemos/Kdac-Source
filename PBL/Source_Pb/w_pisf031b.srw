$PBExportHeader$w_pisf031b.srw
$PBExportComments$임시불출(바코드)
forward
global type w_pisf031b from w_cmms_sheet01
end type
type uo_area from u_cmms_select_area within w_pisf031b
end type
type uo_division from u_cmms_select_division within w_pisf031b
end type
type cb_normal from commandbutton within w_pisf031b
end type
type cb_temp from commandbutton within w_pisf031b
end type
type dw_scan from datawindow within w_pisf031b
end type
type dw_pisf031b_01 from uo_datawindow within w_pisf031b
end type
type gb_1 from groupbox within w_pisf031b
end type
type gb_2 from groupbox within w_pisf031b
end type
type gb_3 from groupbox within w_pisf031b
end type
end forward

global type w_pisf031b from w_cmms_sheet01
integer width = 4128
string title = "임시불출입력"
event ue_init ( )
event ue_process ( )
uo_area uo_area
uo_division uo_division
cb_normal cb_normal
cb_temp cb_temp
dw_scan dw_scan
dw_pisf031b_01 dw_pisf031b_01
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisf031b w_pisf031b

type variables
String	is_partkbno
String	is_null
boolean ib_opened = false
end variables

forward prototypes
public subroutine wf_insert_dw_pisf031b_01 ()
end prototypes

event ue_init();is_partkbno = is_Null

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

event ue_process();//////////////////////////////////
//		임시불출 작업 Control
//////////////////////////////////
string ls_area, ls_plant, ls_itemcode
long ll_rowcnt

ls_area = mid(is_partkbno,1,1)
ls_plant = mid(is_partkbno,2,1)
ls_itemcode = mid(is_partkbno,3)

//품번체크
select count(*) into :ll_rowcnt
from part_master
where area_code = :ls_area and factory_code = :ls_plant and part_code = :ls_itemcode
using sqlcmms;

if ll_rowcnt < 1 then
	Messagebox("확인", "해당 공장으로 등록된 품번이 아닙니다.")
	return
end if

wf_insert_dw_pisf031b_01()

return
end event

public subroutine wf_insert_dw_pisf031b_01 ();string ls_area, ls_plant, ls_part_code, ls_part_name
string ls_part_spec, ls_part_unit, ls_message
long ll_currow

ls_area = mid(is_partkbno,1,1)
ls_plant = mid(is_partkbno,2,1)
ls_part_code = mid(is_partkbno,3)

select part_name, part_spec, part_unit
into :ls_part_name, :ls_part_spec, :ls_part_unit
from part_master
where area_code = :ls_area and factory_code = :ls_plant and
	part_code = :ls_part_code
using sqlcmms;

ll_currow = dw_pisf031b_01.insertrow(0)
dw_pisf031b_01.setitem(ll_currow, 'area_code', ls_area)
dw_pisf031b_01.setitem(ll_currow, 'factory_code', ls_plant)
dw_pisf031b_01.setitem(ll_currow, 'part_code', ls_part_code)
dw_pisf031b_01.setitem(ll_currow, 'part_name', ls_part_name)
dw_pisf031b_01.setitem(ll_currow, 'part_spec', ls_part_spec)
dw_pisf031b_01.setitem(ll_currow, 'part_unit', ls_part_unit)
dw_pisf031b_01.setitem(ll_currow, 'out_qty', 1)
String a, b, c
a = Left(string(f_cmms_sysdate()), 10)
if Left(string(f_cmms_sysdate()), 10) &
		>= Left(string(f_cmms_sysdate()),8)+f_date_end(string(g_s_date,"@@@@-@@-@@")) then
	dw_pisf031b_01.setitem(ll_currow, 'scandate',relativedate(date(string(f_cmms_sysdate())),1))
else
	dw_pisf031b_01.setitem(ll_currow, 'scandate', string(f_cmms_sysdate()))
end if

dw_pisf031b_01.setitem(ll_currow, 'flag', 'A')
dw_pisf031b_01.setitem(ll_currow, 'stscd', 'A')
dw_pisf031b_01.setitem(ll_currow, 'inptid', g_s_empno)
dw_pisf031b_01.setitem(ll_currow, 'inptdt', f_cmms_sysdate())
dw_pisf031b_01.setitem(ll_currow, 'ipaddr', g_s_ipaddr)
dw_pisf031b_01.setitem(ll_currow, 'macaddr', g_s_macaddr)

////////////////////////////////////////////////
// 		임시 불출 처리 
////////////////////////////////////////////////
sqlcmms.AutoCommit = False
SetPointer(HourGlass!)

If dw_pisf031b_01.Update() = -1 Then 
	ls_message = "임시불출데이타 저장에서 오류가 발생하였습니다."
	Goto RollBack_			
End If

//	성공
Commit Using sqlcmms;
sqlcmms.AutoCommit = True
this.PostEvent ('ue_retrieve')
SetPointer(Arrow!)
uo_status.st_message.text = "정상적으로 임시불출처리되었습니다."
Return 

//	실패
RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = True
SetPointer(Arrow!)

MessageBox("불출오류", ls_message, StopSign! )
this.PostEvent ('ue_retrieve')

return
end subroutine

on w_pisf031b.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_normal=create cb_normal
this.cb_temp=create cb_temp
this.dw_scan=create dw_scan
this.dw_pisf031b_01=create dw_pisf031b_01
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.cb_normal
this.Control[iCurrent+4]=this.cb_temp
this.Control[iCurrent+5]=this.dw_scan
this.Control[iCurrent+6]=this.dw_pisf031b_01
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_3
end on

on w_pisf031b.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_normal)
destroy(this.cb_temp)
destroy(this.dw_scan)
destroy(this.dw_pisf031b_01)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisf031b_01.Width = newwidth 	- ( ls_gap * 6 )
dw_pisf031b_01.Height = newheight - ( dw_pisf031b_01.y + ls_split * 3 )
end event

event activate;call super::activate;if ib_opened then
	if uo_area.is_uo_areacode <> gs_kmarea then
		uo_area.is_uo_areacode = gs_kmarea
		uo_area.dw_1.setitem(1,"DDDWCode",gs_kmarea)
		uo_area.triggerevent('ue_select')
	end if
	uo_division.is_uo_divisioncode = gs_kmdivision
	uo_division.dw_1.setitem(1,"DDDWCode",gs_kmdivision)
end if
ib_opened = true

dw_scan.SetTransObject(sqlcmms)
dw_pisf031b_01.settransobject(sqlcmms)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_scan.SetTransObject(sqlcmms)
dw_scan.InsertRow(1)

dw_pisf031b_01.settransobject(sqlcmms)


this.PostEvent ('ue_retrieve')
this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;dw_pisf031b_01.reset()

dw_pisf031b_01.retrieve(gs_kmarea,gs_kmdivision)

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
end event

event ue_delete;call super::ue_delete;long ll_selrow

ll_selrow = dw_pisf031b_01.getselectedrow(0)
if ll_selrow < 1 then
	MessageBox("확인","삭제하기 위한 선택된 데이타가 없습니다.")
	return 0
end if

dw_pisf031b_01.setitem(ll_selrow,'flag','D')
this.PostEvent ('ue_save')
end event

event ue_save;call super::ue_save;string ls_message
////////////////////////////////////////////////
// 		임시 불출 처리 
////////////////////////////////////////////////
dw_pisf031b_01.accepttext()
sqlcmms.AutoCommit = False
SetPointer(HourGlass!)

If dw_pisf031b_01.Update() = -1 Then 
	ls_message = "임시불출데이타 저장에서 오류가 발생하였습니다."
	Goto RollBack_			
End If

//	성공
Commit Using sqlcmms;
sqlcmms.AutoCommit = True
this.PostEvent ('ue_retrieve')
SetPointer(Arrow!)
uo_status.st_message.text = "정상적으로 처리되었습니다."
Return 

//	실패
RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = True
SetPointer(Arrow!)

MessageBox("불출오류", ls_message, StopSign! )
this.PostEvent ('ue_retrieve')

return
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf031b
end type

type uo_area from u_cmms_select_area within w_pisf031b
integer x = 73
integer y = 84
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_cmms_select_area::destroy
end on

event ue_select;call super::ue_select;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

uo_division.triggerevent('ue_select')
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode

if f_spacechk(gs_kmdivision) = -1 then
	ls_divisioncode = '%'
else
	ls_divisioncode = gs_kmdivision
end if
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,ls_divisioncode,false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

type uo_division from u_cmms_select_division within w_pisf031b
integer x = 571
integer y = 84
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type cb_normal from commandbutton within w_pisf031b
integer x = 1394
integer y = 80
integer width = 398
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "정상불출"
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
   WHERE WIN_ID = 'w_pisf031a' 
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

type cb_temp from commandbutton within w_pisf031b
integer x = 1847
integer y = 80
integer width = 398
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "임시불출"
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
   WHERE WIN_ID = 'w_pisf031b' 
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

type dw_scan from datawindow within w_pisf031b
integer x = 55
integer y = 244
integer width = 1737
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf_scan"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;This.SelectText(1,15)
end event

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "확인", "작업처리 권한이 부여되지 않았습니다.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

is_partkbno = data
parent.TriggerEvent( "ue_process" )

this.Event getfocus()
end event

type dw_pisf031b_01 from uo_datawindow within w_pisf031b
integer x = 27
integer y = 436
integer width = 3493
integer height = 724
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisf031b_01"
end type

event buttonclicked;call super::buttonclicked;long ll_currow, ll_rowcnt

if dwo.name = 'b_chk' then
	ll_rowcnt = This.rowcount()
	if ll_rowcnt < 1 then
		return 0
	end if
	for ll_currow = 1 to ll_rowcnt
		This.setitem(ll_currow,'flag','C')
		This.setitem(ll_currow,'updtid',g_s_empno)
		This.setitem(ll_currow,'updtdt',f_cmms_sysdate())
	next
end if

return 0
end event

type gb_1 from groupbox within w_pisf031b
integer x = 27
integer y = 8
integer width = 1184
integer height = 188
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

type gb_2 from groupbox within w_pisf031b
integer x = 1349
integer y = 8
integer width = 942
integer height = 188
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217730
long backcolor = 12632256
string text = "화면전환"
end type

type gb_3 from groupbox within w_pisf031b
integer x = 27
integer y = 200
integer width = 1838
integer height = 216
integer taborder = 30
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

