$PBExportHeader$w_pisf010.srw
$PBExportComments$장비기본정보
forward
global type w_pisf010 from w_cmms_sheet01
end type
type dw_group from datawindow within w_pisf010
end type
type ddlb_filter from dropdownlistbox within w_pisf010
end type
type dw_list from uo_datawindow within w_pisf010
end type
type tab_1 from tab within w_pisf010
end type
type tp_1 from userobject within tab_1
end type
type dw_property from datawindow within tp_1
end type
type tp_1 from userobject within tab_1
dw_property dw_property
end type
type tp_2 from userobject within tab_1
end type
type dw_1 from uo_datawindow within tp_2
end type
type tp_2 from userobject within tab_1
dw_1 dw_1
end type
type tp_3 from userobject within tab_1
end type
type dw_3 from datawindow within tp_3
end type
type tp_3 from userobject within tab_1
dw_3 dw_3
end type
type tp_4 from userobject within tab_1
end type
type dw_4_1 from datawindow within tp_4
end type
type dw_4 from uo_datawindow within tp_4
end type
type tp_4 from userobject within tab_1
dw_4_1 dw_4_1
dw_4 dw_4
end type
type tp_5 from userobject within tab_1
end type
type sle_date from singlelineedit within tp_5
end type
type cb_arrange from commandbutton within tp_5
end type
type dw_5 from uo_datawindow within tp_5
end type
type tp_5 from userobject within tab_1
sle_date sle_date
cb_arrange cb_arrange
dw_5 dw_5
end type
type tp_6 from userobject within tab_1
end type
type dw_6 from uo_datawindow within tp_6
end type
type tp_6 from userobject within tab_1
dw_6 dw_6
end type
type tp_7 from userobject within tab_1
end type
type dw_7_1 from uo_datawindow within tp_7
end type
type dw_7 from uo_datawindow within tp_7
end type
type tp_7 from userobject within tab_1
dw_7_1 dw_7_1
dw_7 dw_7
end type
type tp_8 from userobject within tab_1
end type
type dw_8 from uo_datawindow within tp_8
end type
type tp_8 from userobject within tab_1
dw_8 dw_8
end type
type tp_9 from userobject within tab_1
end type
type sle_equipcd from singlelineedit within tp_9
end type
type st_4 from statictext within tp_9
end type
type cb_copy from commandbutton within tp_9
end type
type st_3 from statictext within tp_9
end type
type dw_10 from datawindow within tp_9
end type
type st_7 from statictext within tp_9
end type
type dw_div from datawindow within tp_9
end type
type dw_2 from datawindow within tp_9
end type
type dw_9 from uo_datawindow within tp_9
end type
type cb_2 from commandbutton within tp_9
end type
type tp_9 from userobject within tab_1
sle_equipcd sle_equipcd
st_4 st_4
cb_copy cb_copy
st_3 st_3
dw_10 dw_10
st_7 st_7
dw_div dw_div
dw_2 dw_2
dw_9 dw_9
cb_2 cb_2
end type
type tp_10 from userobject within tab_1
end type
type em_1 from editmask within tp_10
end type
type st_6 from statictext within tp_10
end type
type st_5 from statictext within tp_10
end type
type st_2 from statictext within tp_10
end type
type dw_10_03 from uo_datawindow within tp_10
end type
type dw_10_02 from uo_datawindow within tp_10
end type
type cb_1 from commandbutton within tp_10
end type
type ddlb_1 from dropdownlistbox within tp_10
end type
type st_1 from statictext within tp_10
end type
type dw_10_01 from uo_datawindow within tp_10
end type
type tp_10 from userobject within tab_1
em_1 em_1
st_6 st_6
st_5 st_5
st_2 st_2
dw_10_03 dw_10_03
dw_10_02 dw_10_02
cb_1 cb_1
ddlb_1 ddlb_1
st_1 st_1
dw_10_01 dw_10_01
end type
type tp_11 from userobject within tab_1
end type
type dw_11 from uo_datawindow within tp_11
end type
type tp_11 from userobject within tab_1
dw_11 dw_11
end type
type tab_1 from tab within w_pisf010
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
tp_4 tp_4
tp_5 tp_5
tp_6 tp_6
tp_7 tp_7
tp_8 tp_8
tp_9 tp_9
tp_10 tp_10
tp_11 tp_11
end type
type uo_area from u_cmms_select_area within w_pisf010
end type
type uo_division from u_cmms_select_division within w_pisf010
end type
type gb_1 from groupbox within w_pisf010
end type
end forward

global type w_pisf010 from w_cmms_sheet01
integer width = 4677
integer height = 2724
string title = "장비"
dw_group dw_group
ddlb_filter ddlb_filter
dw_list dw_list
tab_1 tab_1
uo_area uo_area
uo_division uo_division
gb_1 gb_1
end type
global w_pisf010 w_pisf010

type prototypes
Function Long SetCurrentDirectoryA (ref String lpPathName) LIBRARY "KERNEL32.DLL"
FUNCTION ULONG ShellExecuteA(ulong hwnd, string lpOperation, string lpFile, &
    string lpParameters, string lpDirectory, INT nShowCmd) LIBRARY "shell32.dll"
	 
FUNCTION ulong GetTempPathA(ulong BufferLength, ref String lpTmpPath) LIBRARY "KERNEL32.DLL"

FUNCTION ulong SHGetSpecialFolderPathA(ulong hwnd, ref String lpPath, int nFolder, Boolean bCreate) LIBRARY "Shell32.dll"
end prototypes

type variables
datawindow id_dw_current
datawindow id_dw_property 
datawindow id_dw_1 
datawindow id_dw_2 
datawindow id_dw_3 
datawindow id_dw_4 
datawindow id_dw_5 
datawindow id_dw_6 
datawindow id_dw_7 
datawindow id_dw_7_1 
datawindow id_dw_8
datawindow id_dw_9
datawindow id_dw_9_1
datawindow id_dw_10_01
datawindow id_dw_10_02
datawindow id_dw_10_03
datawindow id_dw_11

string is_original_sql_list 
string is_original_sql_property 
string is_original_sql_1 
string is_original_sql_2 
string is_original_sql_3 
string is_original_sql_4 
string is_original_sql_5 
string is_original_sql_6 
string is_original_sql_7 
string is_original_sql_7_1 
string is_original_sql_8 
string is_original_sql_9 
string is_original_sql_9_1 
string is_original_sql_10_01 
string is_original_sql_10_02
string is_original_sql_10_03
string is_original_sql_11 

long il_row
long check_data

boolean ib_target_chg = false

// FTP 관련 
boolean ib_upOpened = FALSE	//업로드시 파일폴더열면 이전의 파일폴더 open
Long il_FtpScrollPos

u_cmms_ftp u_ftp

boolean ib_opened = false
end variables

on w_pisf010.create
int iCurrent
call super::create
this.dw_group=create dw_group
this.ddlb_filter=create ddlb_filter
this.dw_list=create dw_list
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_group
this.Control[iCurrent+2]=this.ddlb_filter
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.gb_1
end on

on w_pisf010.destroy
call super::destroy
destroy(this.dw_group)
destroy(this.ddlb_filter)
destroy(this.dw_list)
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_list.width = newwidth - ddlb_filter.WIDTH

tab_1.width = newwidth
tab_1.height = newheight - 1100

tab_1.tp_1.dw_property.width = tab_1.width - 40
tab_1.tp_1.dw_property.height = tab_1.height - 200

tab_1.tp_2.dw_1.width = tab_1.width - 40
tab_1.tp_2.dw_1.height = tab_1.height - 200

tab_1.tp_3.dw_3.width = tab_1.width - 40
tab_1.tp_3.dw_3.height = tab_1.height - 200

tab_1.tp_4.dw_4.height = tab_1.height - 200
tab_1.tp_4.dw_4_1.width = tab_1.width - 40 -tab_1.tp_4.dw_4.width
tab_1.tp_4.dw_4_1.height = tab_1.height - 200

tab_1.tp_5.dw_5.width = tab_1.width - 40
tab_1.tp_5.dw_5.height = tab_1.height - 200

tab_1.tp_6.dw_6.width = tab_1.width - 40
tab_1.tp_6.dw_6.height = tab_1.height - 200

tab_1.tp_7.dw_7.width = tab_1.width - 40
tab_1.tp_7.dw_7_1.width = tab_1.width - 40
tab_1.tp_7.dw_7_1.height = tab_1.height - 200 - tab_1.tp_7.dw_7.height

tab_1.tp_8.dw_8.width = tab_1.width - 40  
tab_1.tp_8.dw_8.height = tab_1.height - 200

tab_1.tp_9.dw_9.width  = tab_1.width  - 40
tab_1.tp_9.dw_9.height = tab_1.height - 200 - tab_1.tp_9.cb_2.height

tab_1.tp_10.dw_10_01.height = tab_1.height - 300
tab_1.tp_10.dw_10_02.height = tab_1.height - 300
tab_1.tp_10.dw_10_03.height = tab_1.height - 300

tab_1.tp_10.dw_10_01.width = (tab_1.width - 40) /3

tab_1.tp_10.dw_10_02.x = tab_1.tp_10.dw_10_01.width
tab_1.tp_10.dw_10_02.width = (tab_1.width - 40) /3

tab_1.tp_10.dw_10_03.x = tab_1.tp_10.dw_10_01.width*2
tab_1.tp_10.dw_10_03.width = (tab_1.width - 40) /3
tab_1.tp_10.st_2.x=tab_1.tp_10.dw_10_01.x
tab_1.tp_10.st_5.x=tab_1.tp_10.dw_10_02.x
tab_1.tp_10.st_6.x=tab_1.tp_10.dw_10_03.x

tab_1.tp_11.dw_11.width = tab_1.width - 40
tab_1.tp_11.dw_11.height = tab_1.height - 200
end event

event open;call super::open;datawindowchild ldwc

ib_saved = false
ib_data_changed = false
long i, ll_row

for i = 1 to 11
	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms)   
tab_1.tp_4.dw_4.settransobject(sqlcmms)   
tab_1.tp_4.dw_4_1.settransobject(sqlcmms)   
tab_1.tp_5.dw_5.settransobject(sqlcmms)   
tab_1.tp_6.dw_6.settransobject(sqlcmms)   
tab_1.tp_7.dw_7.settransobject(sqlcmms)   
tab_1.tp_7.dw_7_1.settransobject(sqlcmms)   
tab_1.tp_8.dw_8.settransobject(sqlcmms)   
tab_1.tp_9.dw_9.settransobject(sqlcmms)   
tab_1.tp_9.dw_div.settransobject(sqlcmms)
tab_1.tp_9.dw_div.insertrow(0)
tab_1.tp_10.dw_10_01.settransobject(sqlcmms)   
tab_1.tp_10.dw_10_02.settransobject(sqlcmms)   
tab_1.tp_10.dw_10_03.settransobject(sqlcmms)   
tab_1.tp_10.ddlb_1.selectitem(1)
tab_1.tp_11.dw_11.settransobject(sqlcmms)

id_dw_property = tab_1.tp_1.dw_property
id_dw_1 = tab_1.tp_2.dw_1
id_dw_3= tab_1.tp_3.dw_3
id_dw_4= tab_1.tp_4.dw_4
id_dw_5= tab_1.tp_5.dw_5
id_dw_6= tab_1.tp_6.dw_6
id_dw_7= tab_1.tp_7.dw_7
id_dw_7_1= tab_1.tp_7.dw_7_1
id_dw_8= tab_1.tp_8.dw_8
id_dw_9= tab_1.tp_9.dw_9
id_dw_10_01= tab_1.tp_10.dw_10_01
id_dw_10_02= tab_1.tp_10.dw_10_02
id_dw_10_03= tab_1.tp_10.dw_10_03
id_dw_11= tab_1.tp_11.dw_11

is_original_sql_list = dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_property.object.datawindow.table.select
is_original_sql_1 = id_dw_1.object.datawindow.table.select
is_original_sql_3 = id_dw_3.object.datawindow.table.select
is_original_sql_4 = id_dw_4.object.datawindow.table.select
is_original_sql_5 = id_dw_5.object.datawindow.table.select
is_original_sql_6 = id_dw_6.object.datawindow.table.select
is_original_sql_7 = id_dw_7.object.datawindow.table.select
is_original_sql_7_1 = id_dw_7_1.object.datawindow.table.select
is_original_sql_8 = id_dw_8.object.datawindow.table.select
is_original_sql_9 = id_dw_9.object.datawindow.table.select
is_original_sql_10_01 = id_dw_10_01.object.datawindow.table.select
is_original_sql_10_02 = id_dw_10_02.object.datawindow.table.select
is_original_sql_10_03 = id_dw_10_03.object.datawindow.table.select
is_original_sql_11 = id_dw_11.object.datawindow.table.select

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end event

event ue_delete;call super::ue_delete;long ll_row
long ll_cnt, ll_rowcnt
Boolean lb_Updated = False
String ls_equip
String ls_tarArea, ls_tarFactory
String ls_message

ls_tarArea = ""
ls_tarFactory = ""
uo_status.st_message.text = ""

ls_equip = id_dw_current.getitemstring(id_dw_current.getrow(),'equip_code')

if not IsNull(id_dw_current) then
	ll_row = id_dw_current.GetRow()
	
	if ll_row > 0 then
		choose case tab_1.selectedTab
			case 1
				ls_tarArea = id_dw_current.object.target_area[ll_row]
				ls_tarFactory = id_dw_current.object.target_factory[ll_row]
		
				if (not (gs_kmArea = 'D' And gs_kmDivision = 'R')) And (ls_tarArea = 'D' And ls_tarFactory = 'R') then
					uo_status.st_message.text = '해당장비는 연구소 장비이므로 타공장에서 수정할 수 없읍니다.!!'
					return 0
				end if
				
				if messagebox("확인", "해당장비를 삭제하시겠읍니까?", Question!, YesNo!) <> 1 Then
					return 0
				end if
				
				SELECT COUNT(*)  
					INTO :ll_rowcnt
					FROM wo_hist  
					WHERE area_code = :gs_kmarea and factory_code = :gs_kmdivision and wo_hist.equip_code = :ls_equip   
					using sqlcmms;
				
				if ll_rowcnt = 0 then
					id_dw_current.DeleteRow(ll_row)
					lb_Updated = True
				else
					uo_status.st_message.text = '작명이 발행된 장비는 삭제할수 없습니다.'
					return 0
				end if

				if ls_tarArea <> '' and ls_tarFactory <> '' then
					transaction tar_conn
					tar_conn = Create Transaction
					
					if f_cmms_setserver_any(ls_tarArea, ls_tarFactory, tar_conn) = False then
						DESTROY tar_conn
						ls_message = "타켓지역: "+ls_tarArea+" 타켓공장: "+ls_tarFactory &
									+ " 서버와의 연결이 끊어졌습니다.잠시후에 재작업하십시오"
						uo_status.st_message.text = ls_message
						messagebox("연결오류", ls_message)
						return 0
					end if

					// 타켓 공장의 작명 체크
					SELECT COUNT(*)
						INTO :ll_rowcnt
						FROM wo_hist  
						WHERE area_code = :ls_tarArea and factory_code = :ls_tarFactory and wo_hist.equip_code = :ls_equip   
						using tar_conn;
					
					if ll_rowcnt = 0 then
						id_dw_current.DeleteRow(ll_row)
						lb_Updated = True
					else
						uo_status.st_message.text = '타켓공장에서 작명이 발행되었으므로 삭제할수 없습니다.'
						return 0
					end if
				end if
			case 2
				if messagebox("확인", "해당자재를 삭제하시겠읍니까?", Question!, YesNo!) <> 1 Then
					return 0
				end if
				
				//A:예비 D:전용(공무자재 기본정보에서 맵핑 데이터 전용으로 다운)
				if id_dw_current.getitemstring(ll_row,'part_flag') <> 'A' then
					uo_status.st_message.text = '해당 자재는 공무자재기본정보에서 수정하셔야 합니다.'
				else
					id_dw_current.DeleteRow(ll_row)
					lb_Updated = True
				end if
					
			case 3
			case 4
			case 5
			case 6
				if messagebox("확인", "해당자료를 삭제하시겠읍니까?", Question!, YesNo!) <> 1 Then
					return 0
				end if
				
				id_dw_current.DeleteRow(ll_row)
		
				for ll_cnt = 1 to id_dw_current.rowcount()
					id_dw_current.setitem(ll_cnt,2,ll_cnt)
				next
				lb_Updated = True
				
			case 7
			case 8
			case 9
				//2007.05.08
				//전장 김진열 조장 요청사항
				ls_message = string(ll_row) + "행의 ~r~n" + id_dw_current.getitemstring(ll_row,'class_item') &
							+ "~r~n점검항목을 삭제 하시겠읍니까?"
				if messagebox("확인", ls_message, Question!, YesNo!) <> 1 Then
					return 0
				end if
				
				id_dw_current.DeleteRow(ll_row)
				lb_Updated = True

			case 10
			case 11
	//			id_dw_current.DeleteRow(ll_row)
	//	
	//			for i= 1 to id_dw_current.rowcount()
	//				if check_data=1 then
	//					id_dw_current.setitem(i,'daily_order',i)
	//				end if
	//				if check_data=2 then
	//					id_dw_current.setitem(i,'daily_order',i+10)
	//				end if
	//				if check_data=3 then
	//					id_dw_current.setitem(i,'daily_order',i+15)
	//				end if
	//			next
		end choose
	end if
end if

if lb_Updated Then
	sqlcmms.AutoCommit = false
	tar_conn.AutoCommit = false
	id_dw_current.accepttext()
	
	if tab_1.selectedTab = 1 then
		if ls_tarArea <> '' and ls_tarFactory <> '' then
			DELETE FROM EQUIP_MASTER 
			WHERE EQUIP_CODE = :ls_equip
					AND AREA_CODE = :ls_tarArea
					AND FACTORY_CODE = :ls_tarFactory
			USING tar_conn;
			
			if tar_conn.sqlcode <> 0 then
				ls_message = tar_conn.SqlErrText
				goto Rollback_
			end if
		end if
	end if
	if id_dw_current.Update() = -1 then
		ls_message = sqlcmms.sqlerrtext
		goto Rollback_
	else		
		if tab_1.selectedTab = 1 then
			if ls_tarArea <> '' and ls_tarFactory <> '' then
				COMMIT USING tar_conn;
				tar_conn.AutoCommit = true
				DisConnect Using tar_conn;
				DESTROY tar_conn
			end if
		end if
		Commit Using sqlcmms;
		sqlcmms.AutoCommit = true
		uo_status.st_message.text = "삭제되었읍니다."
		messagebox("삭제성공", uo_status.st_message.text)
		
		ib_data_changed = true
	end if
	
	this.triggerevent('ue_retrieve')
	dw_list.scrolltorow(dw_list.find("equip_code='"+ls_equip+"'",1,dw_list.rowcount()))
end if

return 0

Rollback_:
if tab_1.selectedTab = 1 then
	if ls_tarArea <> '' and ls_tarFactory <> '' then
		ROLLBACK USING tar_conn;
		tar_conn.AutoCommit = true
		DisConnect Using tar_conn;
		DESTROY tar_conn
	end if
end if

RollBack Using sqlcmms;
sqlcmms.AutoCommit = true
uo_status.st_message.text = "삭제실패 : " + ls_message

return -1
end event

event ue_insert;call super::ue_insert;long ll_row
string ls_null
datawindow ld_dw
uo_status.st_message.text = ''

SetNull(ls_null)
choose case tab_1.selectedTab
	case 1
		if isnull(id_dw_current) then return 0
		ld_dw = id_dw_property
		ld_dw.reset()
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		id_dw_property.setitem(id_dw_property.getrow(),'area_code',gs_kmarea)
		id_dw_property.setitem(id_dw_property.getrow(),'factory_code',gs_kmdivision)
		id_dw_property.setitem(id_dw_property.getrow(),'target_area',ls_null)
		id_dw_property.setitem(id_dw_property.getrow(),'target_factory',ls_null)
		id_dw_property.setitem(id_dw_property.getrow(),'code_gubun','1')
		id_dw_property.object.equip_code.TabSequence = 10
		id_dw_property.SetColumn('equip_code')
		id_dw_property.object.cc_code_1.visible = 1
		id_dw_property.object.cc_code_2.visible = 0

	case 2,3,8,9
		if dw_list.getrow() < 1 then return 0
		if isnull(id_dw_current) then return 0
		ld_dw = id_dw_current
		if tab_1.selectedTab = 3 then
			ld_dw.reset()
		end if
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
		ld_dw.setitem(ld_dw.getrow(),'Area_Code', gs_kmarea)
		ld_dw.setitem(ld_dw.getrow(),'Factory_Code', gs_kmdivision)
		if tab_1.selectedTab = 2 then
			ld_dw.setitem(ld_dw.getrow(),'part_flag','A')
		end if
	case 4
		if dw_list.getrow()<1 then return 0
		if isnull(id_dw_current) then return 0
		ld_dw = tab_1.tp_4.dw_4
//		ld_dw.reset()
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
		tab_1.tp_4.dw_4_1.insertrow(0)
		ld_dw.setitem(ld_dw.getrow(),'equip_guide_area_code', gs_kmarea)
		ld_dw.setitem(ld_dw.getrow(),'equip_guide_factory_code', gs_kmdivision)
	case 6
		if dw_list.getrow()<1 then return
		if isnull(id_dw_current) then return
		ld_dw = id_dw_6
//		ld_dw.reset()
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
		ld_dw.setitem(ld_dw.getrow(),2,ld_dw.getrow())
		ld_dw.setitem(ld_dw.getrow(),'Area_Code', gs_kmarea)
		ld_dw.setitem(ld_dw.getrow(),'Factory_Code', gs_kmdivision)
	case 10,11
//		if dw_list.getrow()<1 then return
//		if isnull(id_dw_current) then return
//		ld_dw = id_dw_current
//		
//		if isnull(ld_dw) then return
//			
//		if check_data=1 then
//			if ld_dw.rowcount() > 9 then return
//			ll_Row = ld_dw.InsertRow(0)
//			ld_dw.SetRow(ll_Row)
//			ld_dw.ScrollToRow(ll_Row)
//			ld_dw.SetFocus()
//			ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
//			ld_dw.setitem(ld_dw.getrow(),3,ld_dw.getrow())
//			id_dw_10_01.setitem(id_dw_10_01.getrow(),2,tab_1.tp_10.ddlb_1.text)
//		end if
//		if check_data=2 then
//			if ld_dw.rowcount() > 4 then return
//			ll_Row = ld_dw.InsertRow(0)
//			ld_dw.SetRow(ll_Row)
//			ld_dw.ScrollToRow(ll_Row)
//			ld_dw.SetFocus()
//			ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
//			ld_dw.setitem(ld_dw.getrow(),3,ld_dw.getrow()+10)
//			id_dw_10_02.setitem(id_dw_10_02.getrow(),2,tab_1.tp_10.ddlb_1.text)
//		end if
//		if check_data=3 then
//			if ld_dw.rowcount() > 6 then return
//			ll_Row = ld_dw.InsertRow(0)
//			ld_dw.SetRow(ll_Row)
//			ld_dw.ScrollToRow(ll_Row)
//			ld_dw.SetFocus()
//			ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
//			ld_dw.setitem(ld_dw.getrow(),3,ld_dw.getrow()+15)
//			id_dw_10_03.setitem(id_dw_10_03.getrow(),2,tab_1.tp_10.ddlb_1.text)
//		end if
end choose
end event

event ue_retrieve;call super::ue_retrieve;int li_current_tab_page
string ls_where, ls_and, ls_code
long ll_row
string ls_factory, ls_area

ls_area=gs_kmarea
ls_factory=gs_kmdivision

li_current_tab_page = tab_1.SelectedTab

ll_row = dw_group.GetRow()
if (ll_row > 0) then
	ls_code = dw_group.GetItemString(ll_row, 'code')
end if

CHOOSE CASE ddlb_filter.text
		
	CASE '전체목록',''
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and equip_div_code <> 'X' ORDER BY equip_master.equip_code"
	case '구분별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and equip_div_code='"+ls_code+"' ORDER BY equip_master.equip_code"
	case 'C/C별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and cc_code='"+ls_code+"' ORDER BY equip_master.equip_code"
	case '라인별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and line_code='"+ls_code+"' ORDER BY equip_master.equip_code"
	case '운영부서별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and dept_code_op='"+ls_code+"' ORDER BY equip_master.equip_code"		
	case '사용부서별'		
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and dept_code_use='"+ls_code+"' ORDER BY equip_master.equip_code"
	case '구입처별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and comp_code_vender='"+ls_code+"' ORDER BY equip_master.equip_code"
	case '국내Agent별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and comp_code_agent='"+ls_code+"' ORDER BY equip_master.equip_code"

end choose
		
dw_list.object.datawindow.table.select = is_original_sql_list + ls_where 

dw_list.retrieve()  

dw_list.selectrow(0, false)
dw_list.SetRow(1)
dw_list.selectrow(1, true)

this.triggerevent('ue_retrieve_each_tab')

ib_refreshed_tab[li_current_tab_page] = true





end event

event ue_retrieve_each_tab;call super::ue_retrieve_each_tab;string ls_area, ls_division, ls_eqcode
string ls_where, ls_where1,ls_and,ls_and1,ls_and2, ls_and3, ls_cccode
long li_current_tab_page, ll_rowcnt

li_current_tab_page = tab_1.SelectedTab

if dw_list.getrow()<1 then
	id_dw_property.reset()
	id_dw_1.reset()	
	id_dw_3.reset()		
	id_dw_4.reset()		
	id_dw_5.reset()		
	id_dw_6.reset()		
	id_dw_7.reset()		
	id_dw_7_1.reset()		
	id_dw_8.reset()		
	id_dw_9.reset()		
	id_dw_10_01.reset()		
	id_dw_10_02.reset()		
	id_dw_10_03.reset()		
	
	return
end if
ls_where = ' where equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_where1 = ' where equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "' and daily_div='"+tab_1.tp_10.ddlb_1.text+"'"

ls_and = ' and equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_and1 = ' and task_hist.equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_and2 = ' where wo_hist.equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_and3 = ' and Area_Code = ' + "'" + gs_kmarea + "' and Factory_Code = '" + gs_kmdivision + "'" 
choose case li_current_tab_page
	case 1  							
		id_dw_property.object.equip_code.TabSequence = 0
		
		id_dw_property.object.datawindow.table.select = is_original_sql_property + ls_where + ls_and3
		ll_rowcnt = id_dw_property.retrieve()
		if ll_rowcnt < 1 then
			return 
		end if
		ls_cccode = id_dw_property.getitemstring(1,'cc_code') 
		if mid(ls_cccode,1,1) = 'D' then
			id_dw_property.setitem(1,'code_gubun','2')
			id_dw_property.object.cc_code_1.visible = 0
			id_dw_property.object.cc_code_2.visible = 1
		else
			id_dw_property.setitem(1,'code_gubun','1')
			id_dw_property.object.cc_code_1.visible = 1
			id_dw_property.object.cc_code_2.visible = 0
		end if
		id_dw_current = id_dw_property
	case 2  						
		id_dw_1.retrieve(gs_kmarea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),1))
		id_dw_current = id_dw_1
	case 3  						
		id_dw_3.object.datawindow.table.select = is_original_sql_3 + ls_where + ls_and3
		id_dw_3.retrieve()
		id_dw_current = id_dw_3
	case 4  						
		id_dw_4.retrieve(gs_kmarea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),1))
		id_dw_current = id_dw_4
	case 5  						
		id_dw_5.retrieve(gs_kmarea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),1))
		id_dw_current = id_dw_5
	case 6 
		id_dw_6.object.datawindow.table.select = is_original_sql_6 + ls_where + ls_and3
		id_dw_6.retrieve()
		id_dw_current = id_dw_6
	case 7 //정비이력
		id_dw_7.object.datawindow.table.select = is_original_sql_7 + ls_where + ls_and3
		id_dw_7.retrieve()
		id_dw_7_1.object.datawindow.table.select = is_original_sql_7_1 + ls_and1 &
			+ ' and task_hist.Area_Code = ' + "'" + gs_kmarea + "' and task_hist.Factory_Code = '" + gs_kmdivision + "'" 
		id_dw_7_1.retrieve()
		id_dw_current = id_dw_7
	case 8 
		id_dw_8.object.datawindow.table.select = is_original_sql_8 + ls_where + ls_and3
		id_dw_8.retrieve()
		id_dw_current = id_dw_8
	case 9 //예방항목
		id_dw_9.retrieve(gs_kmarea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),1))
	case 10 //작업자 점검
		id_dw_10_01.object.datawindow.table.select = is_original_sql_10_01 + ls_and + ls_and3
		id_dw_10_02.object.datawindow.table.select = is_original_sql_10_02 + ls_and + ls_and3
		id_dw_10_03.object.datawindow.table.select = is_original_sql_10_03 + ls_and + ls_and3
		id_dw_10_01.retrieve()
		id_dw_10_02.retrieve()
		id_dw_10_03.retrieve()
	case 11
		id_dw_11.object.datawindow.table.select = is_original_sql_11 + ls_where + ls_and3
		id_dw_11.retrieve()
//		ls_area=gs_kmarea
//		ls_division=gs_kmdivision
//		ls_eqcode = dw_list.getitemstring(dw_list.getrow(),1)
//		id_dw_11.retrieve(ls_area, ls_division, ls_eqcode)
end choose

ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_save;call super::ue_save;long ll_row
datawindow ld_dw
string ls_null, ls_old_equip_div
string ls_now, ls_equip_code, ls_cccode, ls_codenm, ls_equip_div
string ls_tarArea, ls_tarFactory, ls_OldtarArea, ls_OldtarFactory, ls_msg

string ls_equip_name, ls_asset_code, ls_equip_spec, ls_equip_use, ls_line_code, ls_dept_code
string ls_equip_short_name, ls_equip_process_number
string ls_dept_code_op, ls_dept_code_use, ls_comp_code_vender, ls_comp_code_agent
string ls_equip_gas, ls_equip_etc, ls_area_code, ls_factory_code
integer li_equip_air, li_equip_water_iw, li_equip_water_pw, li_equip_water_cw, li_equip_water_mh
integer li_equip_cost, li_equip_year, li_equip_pwr_v, li_equip_pwr_p, li_equip_pwr_kva
integer li_equip_steam, li_equip_weight, li_equip_width, li_equip_length, li_equip_height
integer ld_equip_dep_cost, ld_equip_remain_cost
Boolean lb_updated = false
datetime ld_equip_install_date
dwItemStatus ls_status
transaction tar_conn, old_tar_conn

uo_status.st_message.text = ''
choose case tab_1.selectedTab
	case 1
		id_dw_property.accepttext()
		ls_status = id_dw_property.GetItemStatus(id_dw_property.getrow(), 0, Primary!)
		
		ls_equip_code = id_dw_property.object.equip_code[id_dw_property.getrow()]
		ls_equip_name = id_dw_property.object.equip_name[id_dw_property.getrow()] 
		ls_asset_code = id_dw_property.object.asset_code[id_dw_property.getrow()] 
		ls_equip_div = id_dw_property.object.equip_div_code[id_dw_property.getrow()]
		ls_equip_spec = id_dw_property.object.equip_spec[id_dw_property.getrow()] 
		ls_equip_use = id_dw_property.object.equip_use[id_dw_property.getrow()]
		ls_cccode = id_dw_property.object.cc_code[id_dw_property.getrow()] 
		ls_line_code = id_dw_property.object.line_code[id_dw_property.getrow()]
		ls_dept_code = id_dw_property.object.dept_code[id_dw_property.getrow()]
		ls_equip_short_name = id_dw_property.object.equip_short_name[id_dw_property.getrow()]
		ld_equip_install_date = id_dw_property.object.equip_install_date[id_dw_property.getrow()]
		li_equip_cost = id_dw_property.object.equip_cost[id_dw_property.getrow()]
		li_equip_year = id_dw_property.object.equip_year[id_dw_property.getrow()] 
		ls_equip_process_number = id_dw_property.object.equip_process_number[id_dw_property.getrow()]
		ld_equip_dep_cost = id_dw_property.object.equip_dep_cost[id_dw_property.getrow()] 
		ld_equip_remain_cost = id_dw_property.object.equip_remain_cost[id_dw_property.getrow()]
		ls_dept_code_op = id_dw_property.object.dept_code_op[id_dw_property.getrow()] 
		ls_dept_code_use = id_dw_property.object.dept_code_use[id_dw_property.getrow()]
		ls_comp_code_vender = id_dw_property.object.comp_code_vender[id_dw_property.getrow()]
		ls_comp_code_agent = id_dw_property.object.comp_code_agent[id_dw_property.getrow()]
		ls_tarArea = id_dw_property.object.target_area[id_dw_property.getrow()]
		ls_tarFactory = id_dw_property.object.target_factory[id_dw_property.getrow()]
		li_equip_pwr_v = id_dw_property.object.equip_pwr_v[id_dw_property.getrow()] 
		li_equip_pwr_p = id_dw_property.object.equip_pwr_p[id_dw_property.getrow()]
		li_equip_pwr_kva = id_dw_property.object.equip_pwr_kva[id_dw_property.getrow()] 
		li_equip_air = id_dw_property.object.equip_air[id_dw_property.getrow()]
		li_equip_water_iw = id_dw_property.object.equip_water_iw[id_dw_property.getrow()]
		li_equip_water_pw = id_dw_property.object.equip_water_pw[id_dw_property.getrow()]
		li_equip_water_cw = id_dw_property.object.equip_water_cw[id_dw_property.getrow()]
		li_equip_water_mh = id_dw_property.object.equip_water_mh[id_dw_property.getrow()]
		li_equip_steam = id_dw_property.object.equip_steam[id_dw_property.getrow()] 
		ls_equip_gas = id_dw_property.object.equip_gas[id_dw_property.getrow()]
		ls_equip_etc = id_dw_property.object.equip_etc[id_dw_property.getrow()] 
		li_equip_weight = id_dw_property.object.equip_weight[id_dw_property.getrow()] 
		li_equip_width = id_dw_property.object.equip_width[id_dw_property.getrow()]
		li_equip_length = id_dw_property.object.equip_length[id_dw_property.getrow()]
		li_equip_height = id_dw_property.object.equip_height[id_dw_property.getrow()]
										
		if id_dw_property.getrow() > 0 then
			//연구소 장비 타공장에서 수정 불가
			if (not (gs_kmArea = 'D' And gs_kmDivision = 'R')) And (ls_tarArea <> '' Or ls_tarFactory <> '') then
				uo_status.st_message.text = '해당장비는 연구소 장비이므로 타공장에서 수정할 수 없읍니다.!!'
				return 0
			end if
		
			if len(ls_equip_code) < 6 Or IsNull(ls_equip_code) then
				uo_status.st_message.text = '장비코드가 잘못되었습니다.'
				return 0				
			end if
			
			if (gs_kmArea = 'D' and gs_kmDivision = 'F' and mid(ls_equip_code,1,2) <> 'DF') then
				uo_status.st_message.text = '시설장비코드는 DF로 시작되어야 합니다.'
				return 0
			end if
			if ls_equip_div = '' Or IsNull(ls_equip_div) then
				uo_status.st_message.text = '장비 구분 코드를 선택하세요!!'
				id_dw_property.setcolumn("equip_div_code")
				id_dw_property.setfocus()
				return 0
			end if

			if id_dw_property.getitemstring(1,'code_gubun') = '1' then
				select cc_name into :ls_codenm
				from cc_master
				where area_code in (:gs_kmarea, 'X') and factory_code in (:gs_kmdivision, 'X')
						And cc_code = :ls_cccode using sqlcmms;

				if sqlcmms.sqlcode <> 0 then
					id_dw_property.setcolumn("cc_code")
					id_dw_property.setfocus()
					uo_status.st_message.text = '라인 C/C코드가 잘못되었습니다.'
					return 0
				end if
			else
				select comp_name into :ls_codenm
				from comp_master
				where comp_code = :ls_cccode using sqlcmms;
				
				if sqlcmms.sqlcode <> 0 then
					id_dw_property.setcolumn("cc_code")
					id_dw_property.setfocus()
					uo_status.st_message.text = '업체 C/C코드가 잘못되었습니다.'
					return 0
				end if
			end if
		end if
		
		sqlcmms.AutoCommit = False
		if id_dw_property.update() = -1 then
			messagebox("err_chk",sqlcmms.sqlerrtext)
			RollBack Using sqlcmms;
			sqlcmms.AutoCommit = true
			return 0
		else
			if id_dw_property.getrow() > 0 then
				ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'equip_code')
			end if
		end if
		
		//연구소 일때 타켓공장에 장비등록
		if gs_kmarea = 'D' And gs_kmdivision = 'R' And (Not(gs_kmarea = ls_tarArea And gs_kmdivision = ls_tarFactory)) And (ls_tarArea <> '' And ls_tarFactory <> '') then
			
			// UPDATE
			if ls_status <> newmodified! then
				ls_OldtarArea = dw_list.object.target_area[dw_list.getrow()]
				ls_OldtarFactory = dw_list.object.target_factory[dw_list.getrow()]
				
				//기존 등록된 타켓과 틀릴경우
				if ls_OldtarArea <> ls_tarArea Or ls_OldtarFactory <> ls_tarFactory Then
					ls_msg = "이전 타켓공장에 등록된 장비는 용도를 불용으로 변경합니다.~r~n" &
								+ "저장하시겠읍니까?"
					if messagebox("확인", ls_msg, Question!, YesNo!) <> 1 Then
						RollBack Using sqlcmms;
						sqlcmms.AutoCommit = true
						return 0
					end if
					
					lb_updated = True
					old_tar_conn = Create Transaction
					
					if f_cmms_setserver_any(ls_OldtarArea, ls_OldtarFactory, old_tar_conn) = False then
						DESTROY old_tar_conn
						RollBack Using sqlcmms;
						sqlcmms.AutoCommit = true
	
						ls_msg = "타켓지역: "+ls_OldtarArea+" 타켓공장: "+ls_OldtarFactory &
									+ " (구타켓공장) 서버와의 연결이 끊어졌습니다.잠시후에 재작업하십시오"
						uo_status.st_message.text = ls_msg
						messagebox("연결오류", ls_msg)
						return 0
					end if
					old_tar_conn.AutoCommit = false
					
					//이전공장 불용으로 업데이트
					UPDATE EQUIP_MASTER
					SET EQUIP_DIV_CODE = '9'
					WHERE EQUIP_CODE = :ls_equip_code 
							And AREA_CODE = :ls_OldtarArea 
							AND FACTORY_CODE = :ls_OldtarFactory
					USING old_tar_conn;
				
					if old_tar_conn.sqlcode <> 0 then
						ls_msg = old_tar_conn.SqlErrText
				
						RollBack Using old_tar_conn;
						old_tar_conn.AutoCommit = true
						DisConnect Using old_tar_conn;
						DESTROY old_tar_conn
						
						RollBack Using sqlcmms;
						sqlcmms.AutoCommit = true
						
						uo_status.st_message.text = ls_msg
						messagebox("불용처리 오류", ls_msg)
						return 0
					end if
				end if
			end if
		
			tar_conn = Create Transaction
			
			if f_cmms_setserver_any(ls_tarArea, ls_tarFactory, tar_conn) = False then
				DESTROY tar_conn
				
				if lb_updated then
					RollBack Using old_tar_conn;
					old_tar_conn.AutoCommit = true
					DisConnect Using old_tar_conn;
					DESTROY old_tar_conn
				end if
				
				RollBack Using sqlcmms;
				sqlcmms.AutoCommit = true

				ls_msg = "타켓지역: "+ls_tarArea+" 타켓공장: "+ls_tarFactory &
							+ " 서버와의 연결이 끊어졌습니다.잠시후에 재작업하십시오"
				uo_status.st_message.text = ls_msg
				messagebox("연결오류", ls_msg)
				return 0
			end if
			tar_conn.AutoCommit = false

			DELETE EQUIP_MASTER
			WHERE EQUIP_CODE = :ls_equip_code 
					And AREA_CODE = :ls_tarArea 
					AND FACTORY_CODE = :ls_tarFactory
			USING tar_conn;
		
			if tar_conn.sqlcode <> 0 then
				ls_msg = tar_conn.SqlErrText
		
				RollBack Using tar_conn;
				tar_conn.AutoCommit = true
				DisConnect Using tar_conn;
				DESTROY tar_conn
				
				if lb_updated then
					RollBack Using old_tar_conn;
					old_tar_conn.AutoCommit = true
					DisConnect Using old_tar_conn;
					DESTROY old_tar_conn
				end if
				
				RollBack Using sqlcmms;
				sqlcmms.AutoCommit = true
				
				uo_status.st_message.text = ls_msg
				messagebox("타켓업데이트오류", ls_msg)
				return 0
			end if
			
			INSERT INTO EQUIP_MASTER (equip_code, equip_name, asset_code, equip_div_code,
												equip_spec, equip_use, cc_code, line_code, dept_code, 
												equip_short_name, equip_install_date, equip_cost, equip_year,
												equip_process_number, equip_dep_cost, equip_remain_cost, 
												dept_code_op, dept_code_use, comp_code_vender, comp_code_agent, 
												area_code, factory_code, equip_pwr_v, equip_pwr_p, equip_pwr_kva,
												equip_air, equip_water_iw, equip_water_pw, equip_water_cw, 
												equip_water_mh, equip_steam, equip_gas, equip_etc, equip_weight, 
												equip_width, equip_length, equip_height, target_area, target_factory)
						VALUES(:ls_equip_code, :ls_equip_name, :ls_asset_code, :ls_equip_div, :ls_equip_spec, 
								:ls_equip_use, :ls_cccode, :ls_line_code, :ls_dept_code, :ls_equip_short_name,
								:ld_equip_install_date, :li_equip_cost, :li_equip_year, :ls_equip_process_number, 
								:ld_equip_dep_cost, :ld_equip_remain_cost, :ls_dept_code_op, :ls_dept_code_use, 
								:ls_comp_code_vender, :ls_comp_code_agent, :ls_tarArea, :ls_tarFactory, 
								:li_equip_pwr_v, :li_equip_pwr_p, :li_equip_pwr_kva, :li_equip_air, :li_equip_water_iw, 
								:li_equip_water_pw, :li_equip_water_cw, :li_equip_water_mh, :li_equip_steam, 
								:ls_equip_gas, :ls_equip_etc, :li_equip_weight, :li_equip_width, :li_equip_length, 
								:li_equip_height, :gs_kmarea, :gs_kmdivision)
			USING tar_conn;
			
			if tar_conn.sqlcode <> 0 then
				ls_msg = tar_conn.SqlErrText
		
				RollBack Using tar_conn;
				tar_conn.AutoCommit = true
				DisConnect Using tar_conn;
				DESTROY tar_conn
				
				if lb_updated then
					RollBack Using old_tar_conn;
					old_tar_conn.AutoCommit = true
					DisConnect Using old_tar_conn;
					DESTROY old_tar_conn
				end if
				
				RollBack Using sqlcmms;
				sqlcmms.AutoCommit = true
				
				uo_status.st_message.text = ls_msg
				messagebox("타켓 INSERT 오류", ls_msg)

				return 0
			end if
	
			Commit Using tar_conn;
			tar_conn.AutoCommit = true
			DisConnect Using tar_conn;
			DESTROY tar_conn
			
			if lb_updated then
				Commit Using old_tar_conn;
				old_tar_conn.AutoCommit = true
				DisConnect Using old_tar_conn;
				DESTROY old_tar_conn
			end if
		end if
			
		Commit Using sqlcmms;
		sqlcmms.AutoCommit = true
		
	case 2
		
		if id_dw_1.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if
	case 3
		
		if id_dw_3.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if
	case 4
		
		if id_dw_4.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if

		if id_dw_4.getrow() < 1 then return 0

		if id_dw_4.getitemstring(id_dw_4.getrow(),2) = '' or isnull(id_dw_4.getitemstring(id_dw_4.getrow(),2)) then
		else
			id_dw_4.gettext()
			tab_1.tp_4.dw_4_1.setitem(tab_1.tp_4.dw_4_1.getrow(),1,id_dw_4.getitemstring(id_dw_4.getrow(),2))
			tab_1.tp_4.dw_4_1.setitem(tab_1.tp_4.dw_4_1.getrow(),3,id_dw_4.getitemstring(id_dw_4.getrow(),3))
		end if
		
		if tab_1.tp_4.dw_4_1.update() = -1 then
			return 0
		end if

	case 5
		
		if id_dw_5.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if	
	case 6
		
		if id_dw_6.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if	
	case 8
		
		if id_dw_8.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if	
	case 9
		//연구소 장비 타공장에서 수정 불가
		ls_tarArea = trim(dw_list.getitemstring(dw_list.getrow(),'target_area'))
		ls_tarFactory = trim(dw_list.getitemstring(dw_list.getrow(),'target_factory'))
		if (not (gs_kmArea = 'D' And gs_kmDivision = 'R')) And (ls_tarArea <> '' Or ls_tarFactory <> '') then
			uo_status.st_message.text = '해당장비는 연구소 장비이므로 타공장에서 수정할 수 없읍니다.!!'
			return 0
		end if
			
		if id_dw_9.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
			end if
		end if	
		
	case 10
	case 11	
//		if id_dw_10_01.update() = - 1 then
//			return 0
//		else
//			if dw_list.getrow() > 0 then
//				ls_now=dw_list.getitemstring(dw_list.getrow(),'equip_code')
//			end if
//		end if
//		if id_dw_10_02.update() = - 1 then
//			return 0
//		end if
//		if id_dw_10_03.update() = - 1 then
//			return 0
//		end if
end choose

ib_data_changed = FALSE
this.triggerevent('ue_retrieve')
dw_list.scrolltorow(dw_list.find("equip_code='"+ls_now+"'",1,dw_list.rowcount()))
uo_status.st_message.text = '처리가 정상적으로 완료되었습니다.'

return 1
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms)   
tab_1.tp_4.dw_4.settransobject(sqlcmms)   
tab_1.tp_4.dw_4_1.settransobject(sqlcmms)   
tab_1.tp_5.dw_5.settransobject(sqlcmms)   
tab_1.tp_6.dw_6.settransobject(sqlcmms)   
tab_1.tp_7.dw_7.settransobject(sqlcmms)   
tab_1.tp_7.dw_7_1.settransobject(sqlcmms)   
tab_1.tp_8.dw_8.settransobject(sqlcmms)   
tab_1.tp_9.dw_9.settransobject(sqlcmms)   
tab_1.tp_9.dw_div.settransobject(sqlcmms)
tab_1.tp_9.dw_div.insertrow(0)
tab_1.tp_10.dw_10_01.settransobject(sqlcmms)   
tab_1.tp_10.dw_10_02.settransobject(sqlcmms)   
tab_1.tp_10.dw_10_03.settransobject(sqlcmms)   
tab_1.tp_10.ddlb_1.selectitem(1)
tab_1.tp_11.dw_11.settransobject(sqlcmms)

ddlb_filter.selectitem(1)
dw_group.reset()
// 장비리스트 초기화
dw_list.GetChild('cc_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('dept_code_op', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('dept_code_use', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('equip_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('line_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

// 등록정보 탭 초기화
id_dw_property.GetChild('cc_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code_op', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code_use', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('equip_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('target_area', ldwc)
ldwc.settransobject(sqlpis)
ldwc.retrieve(g_s_empno, gs_kmarea)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_property, 'target_area', ldwc, 'areaname', 10)

id_dw_property.GetChild('target_factory', ldwc)
ldwc.settransobject(sqlpis)
ldwc.retrieve(g_s_empno, gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_property, 'target_factory', ldwc, 'divisionname', 10)

//id_dw_property.GetChild('dept_code_use', ldwc)
//ldwc.settransobject(sqlcmms)
//ldwc.retrieve(gs_kmarea, gs_kmdivision)
//if ldwc.RowCount() < 1 then
//	ldwc.InsertRow(0)
//end if

id_dw_property.GetChild('cc_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('cc_code_2', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code_op_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code_use_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

//예비부품탭 초기화
id_dw_1.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_1, 'part_code', ldwc, 'part_spec', 10)
//예방항목 탭 초기화
id_dw_9.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_9, 'part_code', ldwc, 'part_spec', 10)

id_dw_9.GetChild('class_div', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_9, 'class_div', ldwc, 'class_div_name', 10)

tab_1.tp_9.dw_div.GetChild('class_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(tab_1.tp_9.dw_div, 'class_div_code', ldwc, 'class_div_name', 10)

id_dw_9.GetChild('class_process', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_9, 'class_process', ldwc, 'process_name', 10)

id_dw_9.GetChild('cycle_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_9, 'cycle_code', ldwc, 'cycle_name', 10)

id_dw_9.GetChild('class_spot', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_9, 'class_spot', ldwc, 'team_name', 10)

//정비이력탭 초기화
id_dw_7_1.GetChild('status_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_7_1.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

//id_dw_property.GetChild('cc_code', ldwc)
//f_dddw_width(id_dw_property, 'cc_code', ldwc, 'cc_name', 10)

id_dw_property.GetChild('equip_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
f_dddw_width(id_dw_property, 'equip_div_code', ldwc, 'equip_div_name', 10)

id_dw_property.GetChild('line_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
f_dddw_width(id_dw_property, 'line_code', ldwc, 'line_name', 10)

id_dw_property.GetChild('dept_code_op', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
f_dddw_width(id_dw_property, 'dept_code_op', ldwc, 'cc_name', 10)

id_dw_property.GetChild('dept_code_use', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
f_dddw_width(id_dw_property, 'dept_code_use', ldwc, 'cc_name', 10)

id_dw_property.GetChild('comp_code_vender', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve()
f_dddw_width(id_dw_property, 'comp_code_vender', ldwc, 'comp_name', 10)

id_dw_property.GetChild('comp_code_agent', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve()
f_dddw_width(id_dw_property, 'comp_code_agent', ldwc, 'comp_name', 10)

//id_dw_4.GetChild('guide_code', ldwc)
//f_dddw_width(id_dw_4, 'guide_code', ldwc, 'guide_name', 10)

//uo_1.dw_area.setitem(uo_1.dw_area.getrow(),1,gs_kmarea)
//uo_1.dw_factory.setitem(uo_1.dw_factory.getrow(),1,gs_kmdivision)
this.triggerevent('ue_retrieve')
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

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms)   
tab_1.tp_4.dw_4.settransobject(sqlcmms)   
tab_1.tp_4.dw_4_1.settransobject(sqlcmms)   
tab_1.tp_5.dw_5.settransobject(sqlcmms)   
tab_1.tp_6.dw_6.settransobject(sqlcmms)   
tab_1.tp_7.dw_7.settransobject(sqlcmms)   
tab_1.tp_7.dw_7_1.settransobject(sqlcmms)   
tab_1.tp_8.dw_8.settransobject(sqlcmms)   
tab_1.tp_9.dw_9.settransobject(sqlcmms)   
tab_1.tp_9.dw_div.settransobject(sqlcmms)
tab_1.tp_10.dw_10_01.settransobject(sqlcmms)   
tab_1.tp_10.dw_10_02.settransobject(sqlcmms)   
tab_1.tp_10.dw_10_03.settransobject(sqlcmms)   
tab_1.tp_11.dw_11.settransobject(sqlcmms)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf010
integer x = 18
integer y = 1824
end type

type dw_group from datawindow within w_pisf010
integer y = 88
integer width = 690
integer height = 788
integer taborder = 40
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)

parent.triggerevent('ue_retrieve')
end event

type ddlb_filter from dropdownlistbox within w_pisf010
integer width = 690
integer height = 520
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean sorted = false
string item[] = {"전체목록","구분별","C/C별","라인별","운영부서별","사용부서별","구입처별","국내Agent별"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE this.text
	CASE '구분별'
		dw_group.dataobject = 'd_group_equip_div'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmArea, gs_kmDivision)		
	CASE 'C/C별'
		dw_group.dataobject = 'd_group_cc'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmArea, gs_kmDivision)		
	CASE '라인별'
		dw_group.dataobject = 'd_group_line'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmArea, gs_kmDivision)		
	CASE '운영부서별','사용부서별'
		dw_group.dataobject = 'd_group_cc'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmArea, gs_kmDivision)
	CASE '구입처별','국내Agent별'
		dw_group.dataobject = 'd_group_comp'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve()
	CASE '전체목록'
		dw_group.reset()
		parent.triggerevent('ue_retrieve')
END CHOOSE
end event

type dw_list from uo_datawindow within w_pisf010
integer x = 699
integer width = 3342
integer height = 1076
integer taborder = 20
string dataobject = "d_equip_list"
end type

event rowfocuschanged;call super::rowfocuschanged;int li_count

parent.triggerevent('ue_retrieve_each_tab')

for li_count = 1 to 11
	ib_refreshed_tab[li_count] = false
next
end event

event doubleclicked;call super::doubleclicked;if row <= 0 then return 0

string ls_wono

ls_wono = this.GetItemString(row, 'equip_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '장비를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = "[설비관리]-[작명]"
lstr.s_parm[3] = ' '

OpenSheetwithparm(lw_win,lstr,'w_pisf020',iw_this,0,Layered!)
end event

type tab_1 from tab within w_pisf010
integer y = 1108
integer width = 4613
integer height = 1524
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
tp_4 tp_4
tp_5 tp_5
tp_6 tp_6
tp_7 tp_7
tp_8 tp_8
tp_9 tp_9
tp_10 tp_10
tp_11 tp_11
end type

on tab_1.create
this.tp_1=create tp_1
this.tp_2=create tp_2
this.tp_3=create tp_3
this.tp_4=create tp_4
this.tp_5=create tp_5
this.tp_6=create tp_6
this.tp_7=create tp_7
this.tp_8=create tp_8
this.tp_9=create tp_9
this.tp_10=create tp_10
this.tp_11=create tp_11
this.Control[]={this.tp_1,&
this.tp_2,&
this.tp_3,&
this.tp_4,&
this.tp_5,&
this.tp_6,&
this.tp_7,&
this.tp_8,&
this.tp_9,&
this.tp_10,&
this.tp_11}
end on

on tab_1.destroy
destroy(this.tp_1)
destroy(this.tp_2)
destroy(this.tp_3)
destroy(this.tp_4)
destroy(this.tp_5)
destroy(this.tp_6)
destroy(this.tp_7)
destroy(this.tp_8)
destroy(this.tp_9)
destroy(this.tp_10)
destroy(this.tp_11)
end on

event selectionchanged;uo_status.st_message.text = ""
setnull(id_dw_current)
if dw_list.getrow() < 1 then return

ii_old_tab = oldindex
ii_current_tab = newindex

if not ib_readonly then
	parent.triggerevent('ue_set_buttons')
end if

if newindex = 5 then 
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true, false, false, false, false, false, false, false)
else
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end if 

// 이미 최신 데이터를 조회중이면 다시 조회하지 않는다.
if ib_refreshed_tab[newindex] then
	return
else
	parent.triggerevent('ue_retrieve_each_tab')	
end if
end event

type tp_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 79741120
string text = "등록정보"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_property dw_property
end type

on tp_1.create
this.dw_property=create dw_property
this.Control[]={this.dw_property}
end on

on tp_1.destroy
destroy(this.dw_property)
end on

type dw_property from datawindow within tp_1
integer width = 4571
integer height = 1252
integer taborder = 30
string title = "none"
string dataobject = "d_equip_property"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;// messagebox("chk_err",string(sqldbcode) + sqlerrtext + sqlsyntax)
f_show_dberror(sqldbcode)

return 1
end event

event buttonclicked;string ls_return_dt, ls_data[]
str_xy str_lxy

choose case dwo.name
	case 'b_3'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'equip_install_date', date(ls_return_dt))
	case 'b_findcode'
		This.accepttext()
		if This.getitemstring(row,'code_gubun') = '1' then
			f_code_search('d_lookup_cc_a', '', ls_data[])
			This.Setitem(row, 'cc_code', ls_data[1])
		else
			f_code_search('d_lookup_comp', '', ls_data[])
			This.SetItem(row, 'cc_code', ls_data[1])
		end if		
//	case 'b_finduse'
//		This.accepttext()
//		if This.getitemstring(row,'code_gubun') = '1' then
//			f_code_search('d_lookup_cc_a', '', ls_data[])
//			This.Setitem(row, 'cc_code', ls_data[1])
//		else
//			f_code_search('d_lookup_comp', '', ls_data[])
//			This.SetItem(row, 'cc_code', ls_data[1])
//		end if		
end choose
end event

event clicked;id_dw_current = this

if dwo.name = 'target_area' then
	
end if

end event

event doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return

Choose Case dwo.name 
	Case 'cc_code'
//		IF f_code_search('d_lookup_cc', '', ls_data[]) THEN
//			This.SetItem(row, 'cc_code', ls_data[1])
//		END IF
	Case 'equip_div_code'
		IF f_code_search('d_lookup_equip_div', '', ls_data[]) THEN
			This.SetItem(row, 'equip_div_code', ls_data[1])
		END IF
	Case 'line_code'
		IF f_code_search('d_lookup_line', '', ls_data[]) THEN
			This.SetItem(row, 'line_code', ls_data[1])
		END IF
	Case 'dept_code_op'
		IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
			This.SetItem(row, 'dept_code_op', ls_data[1])
		END IF		
	Case 'dept_code_use'
//		IF f_code_search('d_lookup_cc', '', ls_data[]) THEN
//			This.SetItem(row, 'dept_code_use', ls_data[1])
//		END IF		
	Case 'comp_code_vender'
		IF f_code_search('d_lookup_comp', '', ls_data[]) THEN
			This.SetItem(row, 'comp_code_vender', ls_data[1])
		END IF		
	Case 'comp_code_agent'
		IF f_code_search('d_lookup_comp', '', ls_data[]) THEN
			This.SetItem(row, 'comp_code_agent', ls_data[1])
		END IF				
End Choose		
ib_data_changed = true
setpointer(arrow!)
end event

event editchanged;ib_data_changed = true
end event

event itemchanged;datawindowchild ldwc
string ls_colname, ls_codenm, ls_area, ls_division

ls_colname = dwo.name

choose case ls_colname
	case 'code_gubun'
		if data = '1' then
			This.object.cc_code_1.visible = 1
			This.object.cc_code_2.visible = 0
			This.setitem(1,"cc_code",'')
			This.setitem(1,"dept_code_use",'')
		else
			This.object.cc_code_1.visible = 0
			This.object.cc_code_2.visible = 1
			This.setitem(1,"cc_code",'')
			This.setitem(1,"dept_code_use",'')
		end if
	case 'cc_code'
		if This.getitemstring(1,'code_gubun') = '1' then
			select cc_name into :ls_codenm
			from cc_master
			where area_code = :gs_kmarea and factory_code = :gs_kmdivision and
				cc_code = :data using sqlcmms;
			
			if sqlcmms.sqlcode <> 0 then
				This.setitem(1,"cc_code",' ')
			else
//				This.setitem(1,"dept_code_use",data)
			end if
		else
			select comp_name into :ls_codenm
			from comp_master
			where comp_code = :data using sqlcmms;
			
			if sqlcmms.sqlcode <> 0 then
				This.setitem(1,"cc_code",' ')
			else
//				This.setitem(1,"dept_code_use",data)
			end if
		end if
	case 'target_area'
		this.GetChild('target_factory', ldwc)
		ldwc.settransobject(sqlpis)
		ldwc.retrieve(g_s_empno, data, '%')

	case 'target_factory'
	
end choose
This.accepttext()
ib_data_changed = true
return 0
end event

type tp_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "예비부품"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tp_2.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tp_2.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_datawindow within tp_2
integer width = 3342
integer height = 1076
integer taborder = 30
string dataobject = "d_equip_part"
boolean ib_select_row = false
end type

event doubleclicked;call super::doubleclicked;str_parm lstr
long ll_upper_bound, i, ll_insert
datawindowchild ldwc

if lower(string(dwo.name)) = 'part_code' then

	lstr.s_parm[1] = 'd_lookup_part'
	lstr.s_parm[2] = ''	
	lstr.s_parm[3] = '1'	
	lstr.Check = true
	
	OpenWithParm(w_cd_search_multi,lstr)
	
	lstr = Message.PowerObjectParm
	
	ll_upper_bound = UpperBound(lstr.s_array, 1)
	
	if ll_upper_bound < 1 then return
	
	for i = 1 to ll_upper_bound
		if IsNull(lstr.s_array[i, 1]) or lstr.s_array[i, 1] = '' then exit
		
		if i = 1 then
			this.SetItem(row, 'part_code', lstr.s_array[i, 1])
			ll_insert = row
		else
			ll_insert = this.InsertRow(0)
			this.SetItem(ll_insert, 'part_code', lstr.s_array[i, 1])
		end if
		dw_1.GetChild('part_code', ldwc)
		ldwc.settransobject(sqlcmms)
		ldwc.retrieve(gs_kmarea, gs_kmdivision)
		f_dddw_width(dw_1, 'part_code', ldwc, 'part_spec', 10)
		
		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
	next
end if
end event

event clicked;call super::clicked;id_dw_current = this
end event

event itemchanged;call super::itemchanged;//iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_spec, ls_part_location, ls_part_code, ls_part_unit
long ls_part_invy
ls_colname = dwo.name

if ls_colname = 'part_code' then
	this.GetChild('part_code', ldwc)
	This.AcceptText()
	ls_part_code = This.GetItemString(row,'part_code')
	If isnull(ls_part_code) or ls_part_code = '' then Return

	ll_row = f_dddw_getrow(This,row,'part_code',ls_part_code)
	//ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_part_name = ldwc.GetItemString(ll_row, 'part_name')
		ls_part_spec = ldwc.GetItemstring(ll_row, 'part_spec')
		ls_part_location = ldwc.GetItemstring(ll_row, 'part_location')
		ls_part_unit = ldwc.GetItemstring(ll_row, 'part_unit')
		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'part_spec', ls_part_spec)
		this.SetItem(row, 'part_location', ls_part_location)
		this.SetItem(row, 'part_unit', ls_part_unit)

	end if
end if
end event

type tp_3 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "안전환경"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tp_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tp_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tp_3
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "d_equip_safe"
borderstyle borderstyle = stylelowered!
end type

event clicked;id_dw_current = this
end event

type tp_4 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "작업지침"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_4_1 dw_4_1
dw_4 dw_4
end type

on tp_4.create
this.dw_4_1=create dw_4_1
this.dw_4=create dw_4
this.Control[]={this.dw_4_1,&
this.dw_4}
end on

on tp_4.destroy
destroy(this.dw_4_1)
destroy(this.dw_4)
end on

type dw_4_1 from datawindow within tp_4
integer x = 1824
integer y = 4
integer width = 1545
integer height = 1396
integer taborder = 40
string title = "none"
string dataobject = "d_equip_guide_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;id_dw_current = this
end event

event dberror;f_show_dberror(sqldbcode)

return 1
end event

type dw_4 from uo_datawindow within tp_4
integer width = 1819
integer height = 1076
integer taborder = 10
string dataobject = "d_equip_guide"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

event doubleclicked;call super::doubleclicked;//str_parm lstr
//long ll_upper_bound, i, ll_insert
//
//if lower(string(dwo.name)) = 'guide_code' then
//
//	lstr.s_parm[1] = 'd_lookup_guide'
//	lstr.s_parm[2] = ''	
//	lstr.s_parm[3] = '1'	
//	lstr.Check = true
//	
//	OpenWithParm(w_cd_search_multi,lstr)
//	
//	lstr = Message.PowerObjectParm
//	
//	ll_upper_bound = UpperBound(lstr.s_array, 1)
//	
//	if ll_upper_bound < 1 then return
//	
//	for i = 1 to ll_upper_bound
//		if IsNull(lstr.s_array[i, 1]) or lstr.s_array[i, 1] = '' then exit
//		
//		if i = 1 then
//			this.SetItem(row, 'guide_code', lstr.s_array[i, 1])
//			ll_insert = row
//		else
//			ll_insert = this.InsertRow(0)
//			this.SetItem(ll_insert, 'guide_code', lstr.s_array[i, 1])
//		end if
//		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
//	next
//end if
end event

event itemchanged;call super::itemchanged;//iw_this.TriggerEvent('ue_set_data_changed')
//
//if row <= 0 then return
//
//string ls_colname
//datawindowchild ldwc
//long ll_row
//string ls_guide_code, ls_guide_name
//ls_colname = dwo.name
//
//if ls_colname = 'guide_code' then
//	this.GetChild('guide_code', ldwc)
//	This.AcceptText()
//	ls_guide_code = This.GetItemString(row,'guide_code')
//	If isnull(ls_guide_code) or ls_guide_code = '' then Return
//
//	ll_row = f_dddw_getrow(This,row,'guide_code',ls_guide_code)
//	//ll_row = ldwc.GetRow()
//	if ll_row > 0 then
//		ls_guide_name = ldwc.GetItemString(ll_row, 'guide_name')
//		
//		this.SetItem(row, 'guide_name', ls_guide_name)
//		
//	end if
//	this.triggerevent('rowfocuschanged')
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then 
	dw_4_1.reset()
return
end if
string sql
string origin_sql

origin_sql = dw_4_1.object.datawindow.table.select

sql = " where guide_code='"+dw_4.getitemstring(dw_4.getrow(),'guide_code')+"'"

dw_4_1.object.datawindow.table.select = dw_4_1.object.datawindow.table.select + sql &
	+ ' and Area_Code = ' + "'" + gs_kmarea + "' and Factory_Code = '" + gs_kmdivision + "'" 

if dw_4_1.getrow() > 0 then
	if dw_4_1.retrieve() < 1 then
		tab_1.tp_4.dw_4_1.insertrow(0)
	end if
else
	tab_1.tp_4.dw_4_1.insertrow(0)
end if
dw_4_1.object.datawindow.table.select =origin_sql



end event

type tp_5 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "첨부파일"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_date sle_date
cb_arrange cb_arrange
dw_5 dw_5
end type

on tp_5.create
this.sle_date=create sle_date
this.cb_arrange=create cb_arrange
this.dw_5=create dw_5
this.Control[]={this.sle_date,&
this.cb_arrange,&
this.dw_5}
end on

on tp_5.destroy
destroy(this.sle_date)
destroy(this.cb_arrange)
destroy(this.dw_5)
end on

type sle_date from singlelineedit within tp_5
boolean visible = false
integer x = 357
integer y = 1284
integer width = 571
integer height = 112
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 6
borderstyle borderstyle = stylelowered!
end type

type cb_arrange from commandbutton within tp_5
boolean visible = false
integer x = 955
integer y = 1288
integer width = 402
integer height = 116
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "파일ID정리"
end type

event clicked;//Int li_seq = 1, li_cnt = 1, li_fileSeq, li_rtn
//String ls_fileId, ls_fileNam, ls_date, ls_newFileId
//String ls_oldremoteFileNam, ls_newremoteFileNam, ls_msg
//string as_fileId[], as_fileNam[]
//
//ls_date = sle_date.Text
//Trim(ls_date)
//if Len(ls_date) <> 6 then 
//	MessageBox("확인", "날짜는 6자리입니다.")
//	return
//end if
//
//DECLARE FileId_Get CURSOR FOR
//SELECT FILE_ID, FILE_NAME
//  FROM EQUIP_FTPFILE
// WHERE LEFT(FILE_ID, 6) = :ls_date
// ORDER BY FILE_ID
//USING sqlcmms;
//
//OPEN FileId_Get;
//Do While True
//	FETCH FileId_Get 
//	 INTO :ls_fileId, :ls_fileNam;
//	if sqlcmms.sqlcode <> 0 then
//		exit
//	end if
//	
//	as_fileId[li_seq] = ls_fileId
//	as_fileNam[li_seq] = ls_fileNam
//	li_seq++
//Loop
//CLOSE FileId_Get;
//
//// FTP 에러시 대비 
//sqlcmms.AutoCommit = False
//
//For li_cnt = 1 to UpperBound(as_fileId[])
//	ls_fileId = as_fileId[li_cnt]
//	ls_fileNam = as_fileNam[li_cnt]
//	li_fileSeq = Integer(Right(trim(ls_fileId), 4))
//	
//	if li_cnt <> li_fileSeq then
//		ls_newFileId = ls_date + String(li_cnt, "0000")
//				
//		// FTP 서버 저장 파일명
//		ls_oldremoteFileNam = of_getRealRemoteFileNam(ls_fileId, ls_fileNam)
//		ls_newremoteFileNam = of_getRealRemoteFileNam(ls_newFileId, ls_fileNam)
//		
//		// FTP 정보 GET
//		if of_GetFtpInfo() <> 1 then return
//			
//		// FTP 연결
//		if of_Ftpconn() <> 1 then return
//
//		// 실제 파일 존재 Chk
//		li_rtn = of_isRemoteFileExist(ls_oldremoteFileNam)
//		if li_rtn = -1 then 
//			exit
//		elseif li_rtn = 0 then
//			ls_msg = "파일명: " + ls_oldremoteFileNam + "이 FTP 서버에 없읍니다.!! ~r~n삭제하시겠읍니까?"
//			if MessageBox("에러", ls_msg, Exclamation!, OKCancel!) = 1 then
//				DELETE 
//				  FROM EQUIP_FTPFILE
//				 WHERE File_id = :ls_fileId
//				 USING sqlcmms;
//			else
//				exit
//			end if
//		
//			continue
//		end if
//		
//		UPDATE EQUIP_FTPFILE SET FILE_ID = :ls_newFileId WHERE FILE_ID = :ls_fileId Using sqlcmms;
//		if sqlcmms.sqlcode <> 0 then
//			MessageBox("에러", "File_Id: " + ls_newFileId + "에서 에러가 발생했읍니다.")
//			RollBack Using sqlcmms;
//			exit
//		end if
//
//		li_rtn = u_ftp.uf_remote_rename(".\" + ls_oldremoteFileNam, ".\" + ls_newremoteFileNam)
//		if li_rtn <> 1 then 
//			ls_msg = "FTP 파일명 ~r~n" + ls_oldremoteFileNam + "-> " + ls_newremoteFileNam &
//						+ "~r~n변경 실패!!~r~n 에러코드: " + String(GetLastError())
//			MessageBox("확인", ls_msg)
//			RollBack Using sqlcmms;
//			exit
//		end if 
//
//		of_FtpClose()
//		Commit Using sqlcmms;
//	end if
//
//Next
//
//of_FtpClose()
//sqlcmms.AutoCommit = true
//MessageBox("확인", "파일 ID 정리 완료!!")
//// REFRISH
//dw_list.triggerevent('rowfocuschanged')
end event

type dw_5 from uo_datawindow within tp_5
integer width = 4535
integer height = 1356
integer taborder = 10
string dataobject = "d_equip_ftpfile"
end type

event scrollhorizontal;call super::scrollhorizontal;
if il_FtpScrollPos < scrollpos then
	this.object.b_exe.X = String(Long(this.object.b_exe.X) + scrollpos - il_FtpScrollPos)
	this.object.b_down.X = String(Long(this.object.b_down.X) + scrollpos - il_FtpScrollPos)
	this.object.b_upload.X = String(Long(this.object.b_upload.X) + scrollpos - il_FtpScrollPos)
	this.object.b_chg.X = String(Long(this.object.b_chg.X) + scrollpos - il_FtpScrollPos)
	this.object.b_del.X = String(Long(this.object.b_del.X) + scrollpos - il_FtpScrollPos)
else
	this.object.b_exe.X = String(Long(this.object.b_exe.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_down.X = String(Long(this.object.b_down.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_upload.X = String(Long(this.object.b_upload.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_chg.X = String(Long(this.object.b_chg.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_del.X = String(Long(this.object.b_del.X) - (il_FtpScrollPos - scrollpos))
end if

il_FtpScrollPos = scrollpos
end event

event buttonclicked;call super::buttonclicked;String ls_fileNam, ls_fileId, ls_fileDesc, ls_equip, ls_btnName, ls_msg

ls_btnName = dwo.name

if this.getrow() <= 0 And ls_btnName <> 'b_upload' then return

if ls_btnName <> 'b_upload' then
	ls_fileId = this.getitemstring(this.getrow(),1)
	ls_fileNam = this.getitemstring(this.getrow(),5)
	ls_fileDesc = this.getitemstring(this.getrow(),6)
	trim(ls_fileId); trim(ls_fileNam);
	if isNull(ls_fileId) Or ls_fileId = '' then
		MessageBox("확인", "리스트에서 파일을 선택하세요!!")
		return
	end if
else 
	ls_equip = dw_list.getitemstring(dw_list.getrow(), 'equip_code')
	if isNull(ls_equip) Or ls_equip = '' Then 
		MessageBox("확인", "리스트에서 장비를 선택하세요!!")
		return
	end if
end if

//FTP 객체 생성
u_ftp = create u_cmms_ftp
If isvalid(u_ftp) = FALSE then 
	ls_msg = "FTP 객체생성을 실패했읍니다.~r~n 재시도하세요!!"
	goto ERR_CLOSE
END IF

// FTP 정보 GET
if u_ftp.uf_GetFtpInfo(ls_msg) <> 1 then goto ERR_CLOSE

// FTP 연결
if u_ftp.uf_connect(ls_msg) <> 1 then goto ERR_CLOSE

SetPointer(HourGlass!)
Choose Case ls_btnName
	Case 'b_exe'

		uo_status.st_message.text	=	'파일 다운로드 중.....'
		if u_ftp.uf_exe(ls_fileId, ls_fileNam, ls_msg) <> 1 then goto ERR_CLOSE
		uo_status.st_message.text = '파일 다운로드 완료'

	Case 'b_down'

		uo_status.st_message.text	=	'파일 다운로드 중.....'
		if u_ftp.uf_download(ls_fileId, ls_fileNam, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '파일 다운로드 완료'
		
	Case 'b_upload'
			
		uo_status.st_message.text	=	'파일 전송 중.....'
		if u_ftp.uf_Upload(ls_equip, ib_upOpened, ls_fileId, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '파일 전송 완료'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		// hiright
		this.ScrollToRow(this.Find("File_Id = '" + ls_fileId + "'", 1, this.RowCount()))

	Case 'b_chg'
		uo_status.st_message.text = '파일명 변경 중.....'
		//파일명 변경
		if u_ftp.uf_chg(ls_fileId, ls_fileNam, ls_fileDesc, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '변경 완료..'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		// hiright
		this.ScrollToRow(this.Find("File_Id = '" + ls_fileId + "'", 1, this.RowCount()))
	Case 'b_del'
		uo_status.st_message.text = '파일 삭제 중.....'
		// 파일 삭제
		if u_ftp.uf_Del(ls_fileId, ls_fileNam, ls_msg) = -1 Then goto ERR_CLOSE
		uo_status.st_message.text = '파일 삭제 완료'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		
End Choose

SetPointer(Arrow!)
u_ftp.uf_disconnect()
DESTROY u_ftp
SetNull(u_ftp)
return

ERR_CLOSE:
	MessageBox("확인", ls_msg)
	SetPointer(Arrow!)
	u_ftp.uf_disconnect()
	DESTROY u_ftp
	SetNull(u_ftp)
	return
end event

type tp_6 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 79741120
string text = "자료리스트"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tp_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tp_6.destroy
destroy(this.dw_6)
end on

type dw_6 from uo_datawindow within tp_6
integer width = 3515
integer height = 1076
integer taborder = 10
string dataobject = "d_equip_list_tab"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

type tp_7 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "정비이력"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_7_1 dw_7_1
dw_7 dw_7
end type

on tp_7.create
this.dw_7_1=create dw_7_1
this.dw_7=create dw_7
this.Control[]={this.dw_7_1,&
this.dw_7}
end on

on tp_7.destroy
destroy(this.dw_7_1)
destroy(this.dw_7)
end on

type dw_7_1 from uo_datawindow within tp_7
integer y = 688
integer width = 3534
integer height = 632
integer taborder = 20
string dataobject = "d_equip_task_list"
boolean ib_select_row = false
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono, ls_date

ls_wono = this.GetItemString(row, 'task_code')
ls_date = string(this.GetItemdatetime(row, 'exam_date'))

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[예방정비이력]'
lstr.s_parm[3] = ls_wono
lstr.s_parm[4] = ls_date

OpenSheetwithparm(lw_win,lstr,'w_pisf024',iw_this,0,Layered!)


end event

type dw_7 from uo_datawindow within tp_7
integer width = 3534
integer height = 688
integer taborder = 10
string dataobject = "d_equip_wo"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono,ls_date

ls_wono = this.GetItemString(row, 'wo_code')
ls_date = string(this.GetItemdatetime(row, 'wo_float_date'))

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[작명이력]'
lstr.s_parm[3] = ls_wono
lstr.s_parm[4] = ls_date

OpenSheetwithparm(lw_win,lstr,'w_pisf021',iw_this,0,Layered!)


end event

type tp_8 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "변동이력"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_8 dw_8
end type

on tp_8.create
this.dw_8=create dw_8
this.Control[]={this.dw_8}
end on

on tp_8.destroy
destroy(this.dw_8)
end on

type dw_8 from uo_datawindow within tp_8
integer width = 3177
integer height = 1076
integer taborder = 10
string dataobject = "d_equip_change"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

type tp_9 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "예방항목"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_equipcd sle_equipcd
st_4 st_4
cb_copy cb_copy
st_3 st_3
dw_10 dw_10
st_7 st_7
dw_div dw_div
dw_2 dw_2
dw_9 dw_9
cb_2 cb_2
end type

on tp_9.create
this.sle_equipcd=create sle_equipcd
this.st_4=create st_4
this.cb_copy=create cb_copy
this.st_3=create st_3
this.dw_10=create dw_10
this.st_7=create st_7
this.dw_div=create dw_div
this.dw_2=create dw_2
this.dw_9=create dw_9
this.cb_2=create cb_2
this.Control[]={this.sle_equipcd,&
this.st_4,&
this.cb_copy,&
this.st_3,&
this.dw_10,&
this.st_7,&
this.dw_div,&
this.dw_2,&
this.dw_9,&
this.cb_2}
end on

on tp_9.destroy
destroy(this.sle_equipcd)
destroy(this.st_4)
destroy(this.cb_copy)
destroy(this.st_3)
destroy(this.dw_10)
destroy(this.st_7)
destroy(this.dw_div)
destroy(this.dw_2)
destroy(this.dw_9)
destroy(this.cb_2)
end on

type sle_equipcd from singlelineedit within tp_9
integer x = 2894
integer width = 462
integer height = 80
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within tp_9
integer x = 2656
integer y = 20
integer width = 242
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "장비번호"
boolean focusrectangle = false
end type

type cb_copy from commandbutton within tp_9
integer x = 3369
integer width = 526
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "예방정비항목복사"
end type

event clicked;string ls_equipcd
string ls_area, ls_factory, ls_equip, ls_div, ls_taskno
string ls_equipcode, ls_classdiv, ls_classspot, ls_classitem, ls_message
long i,ll_row, ll_count

setpointer(hourglass!)
uo_status.st_message.text = ''
ls_equipcd = trim(sle_equipcd.text)
ls_area = gs_kmarea
ls_factory = gs_kmdivision
ls_equip = dw_list.getitemstring(dw_list.getrow(),1)
ls_div = dw_div.gettext()

SELECT equip_master.equip_code  
	INTO :ls_equipcd  
   FROM equip_master  
   WHERE ( equip_master.area_code = :gs_kmarea ) AND  
         ( equip_master.factory_code = :gs_kmdivision ) AND  
         ( equip_master.equip_code = :ls_equipcd )   
	using sqlcmms;

if f_spacechk(ls_equipcd) = -1 or ls_equip = ls_equipcd then
	uo_status.st_message.text = '장비번호를 확인하시기 바랍니다.'
	return 0
end if

dw_9.accepttext()
sqlcmms.AutoCommit = False
ll_row = dw_9.find("class_div = '" + ls_div + "' and item_chk = 1", 1, dw_9.RowCount())
ll_count =0

DO WHILE ll_row > 0
	if ll_row > 0 then
		// 예방항목을 대상장비로 복사
		ls_equipcode = dw_9.getitemstring( ll_row, 'equip_code' )
		ls_classdiv = dw_9.getitemstring( ll_row, 'class_div' )
		ls_classspot = dw_9.getitemstring( ll_row, 'class_spot' )
		ls_classitem = dw_9.getitemstring( ll_row, 'class_item' )
		
		INSERT INTO equip_class  
      ( equip_code, class_div, class_spot, class_item, class_basis, class_process,   
        class_cycle, cycle_code, class_est_date, class_est_time_hour,   
        class_est_time_min, part_code, class_qty, area_code, factory_code )
		SELECT :ls_equipcd, class_div, class_spot, class_item, class_basis, class_process,   
        class_cycle, cycle_code, class_est_date, class_est_time_hour,   
        class_est_time_min, part_code, class_qty, area_code, factory_code
 		FROM equip_class
		WHERE area_code = :ls_area and factory_code= :ls_factory and
				equip_code = :ls_equip and class_div = :ls_classdiv and
				class_spot = :ls_classspot and class_item = :ls_classitem
		using sqlcmms;

		if sqlcmms.sqlcode <> 0 then
			goto rollback_
		end if	
	end if
	ll_row=ll_row + 1
	if dw_9.rowcount() < ll_row then
		ll_row = 0 
	else
		ll_row = dw_9.find("class_div = '" + ls_div + "' and item_chk = 1", ll_row, dw_9.RowCount())
	end if
LOOP

Commit Using sqlcmms;
sqlcmms.AutoCommit = true
uo_status.st_message.text = '예방항목 복사가 성공적으로 수행되었습니다.'
return 1

RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = true
uo_status.st_message.text = '예방항목 복사가 실패하였습니다. '
return -1
end event

type st_3 from statictext within tp_9
integer x = 1152
integer y = 20
integer width = 1399
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 12632256
string text = "선택란에 체크된것만 예방정비가 수동으로 생성됩니다."
boolean focusrectangle = false
end type

type dw_10 from datawindow within tp_9
boolean visible = false
integer x = 1760
integer y = 312
integer width = 686
integer height = 400
integer taborder = 50
string title = "none"
string dataobject = "sp_next_date"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within tp_9
integer y = 16
integer width = 146
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "구분 :"
boolean focusrectangle = false
end type

type dw_div from datawindow within tp_9
integer x = 165
integer width = 686
integer height = 84
integer taborder = 50
string title = "none"
string dataobject = "d_div"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return
Choose Case dwo.name 
	Case 'class_div_code'
		IF f_code_search('d_lookup_class_div', '', ls_data[]) THEN
			This.SetItem(row, 'class_div_code', ls_data[1])
		END IF
End Choose		
end event

event itemchanged;long ll_rowcnt, ll_curcnt
string ls_classdiv

if dwo.name = 'class_div_code' then
	if data = '04' then
		messagebox("알림","일상점검은 예방정비수동생성을 할 수 없습니다.")
		This.setitem(row,dwo.name,' ')
	else
		ll_rowcnt = tab_1.tp_9.dw_9.rowcount()
		for ll_curcnt = 1 to ll_rowcnt
			ls_classdiv = tab_1.tp_9.dw_9.getitemstring(ll_curcnt,'class_div')
			if ls_classdiv = data then
				tab_1.tp_9.dw_9.setitem(ll_curcnt,'item_chk',1)
			else
				tab_1.tp_9.dw_9.setitem(ll_curcnt,'item_chk',0)
			end if
		next
	end if
end if

return 0
end event

type dw_2 from datawindow within tp_9
boolean visible = false
integer x = 928
integer y = 328
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "sp_create_task"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_9 from uo_datawindow within tp_9
integer y = 92
integer width = 3415
integer height = 852
integer taborder = 10
string dataobject = "d_equip_class"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

event doubleclicked;call super::doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return 0

Choose Case dwo.name 
	Case 'class_div'
		IF f_code_search('d_lookup_class_div', '', ls_data[]) THEN
			This.SetItem(row, 'class_div', ls_data[1])
		END IF
	Case 'class_process'
		IF f_code_search('d_lookup_process', '', ls_data[]) THEN
			This.SetItem(row, 'class_process', ls_data[1])
		END IF
	Case 'cycle_code'
		IF f_code_search('d_lookup_cycle', '', ls_data[]) THEN
			This.SetItem(row, 'cycle_code', ls_data[1])
		END IF
	Case 'class_spot'
		IF f_code_search('d_lookup_team', '', ls_data[]) THEN
			This.SetItem(row, 'class_spot', ls_data[1])
		END IF
End Choose		


str_parm lstr
long ll_upper_bound, i, ll_insert

if lower(string(dwo.name)) = 'part_code' then

	lstr.s_parm[1] = 'd_lookup_part'
	lstr.s_parm[2] = ''	
	lstr.s_parm[3] = '1'	
	lstr.Check = true
	
	OpenWithParm(w_cd_search_multi,lstr)
	
	lstr = Message.PowerObjectParm
	
	ll_upper_bound = UpperBound(lstr.s_array, 1)
	
	if ll_upper_bound < 1 then return 0
	
	for i = 1 to ll_upper_bound
		if IsNull(lstr.s_array[i, 1]) or lstr.s_array[i, 1] = '' then exit
		
		if i = 1 then
			this.SetItem(row, 'part_code', lstr.s_array[i, 1])
			ll_insert = row
		else
			ll_insert = this.InsertRow(0)
			this.SetItem(ll_insert, 'part_code', lstr.s_array[i, 1])
		end if
		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
	next
end if

return 0
end event

event itemchanged;call super::itemchanged;uo_status.st_message.text = ""
iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name, ls_div
string ls_part_spec, ls_part_location, ls_part_code
long ls_part_invy
ls_colname = dwo.name

if ls_colname = 'part_code' then
	this.GetChild('part_code', ldwc)	
	This.AcceptText()
	ls_part_code = This.GetItemString(row,'part_code')
	
	If isnull(ls_part_code) or ls_part_code = '' then Return

	ll_row = f_dddw_getrow(This,row,'part_code',ls_part_code)
	//ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_part_name = ldwc.GetItemString(ll_row, 'part_name')
		ls_part_spec = ldwc.GetItemstring(ll_row, 'part_spec')
		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'part_spec', ls_part_spec)
	end if
end if

if ls_colname = 'cycle_code' then
	datetime ld_date, ld_dummy
	long ll_date
	ld_date = dw_list.getitemdatetime(dw_list.getrow(),'equip_install_date')
	//ld_date = datetime(date(string(g_s_date,"@@@@-@@-@@")))
	ll_date = this.getitemnumber(this.getrow(),'class_cycle')

	if ll_date < 1  then return
	
	if isdate(string(date(ld_date))) then
		//dw_10.settransobject(sqlcmms)
		//dw_10.retrieve(data, ll_date, ld_date,ld_dummy)
		//this.setitem(this.getrow(),'class_est_date',dw_10.getitemdatetime(1,1))
		this.setitem(this.getrow(),'class_est_date',f_cmms_sysdate())
//		elseif data='week' then  
//			this.setitem(this.getrow(),'class_est_date',relativedate(date(ld_date),ll_date*7))
//		elseif data='month' then
//			this.setitem(this.getrow(),'class_est_date',relativedate(date(ld_date),ll_date*30))
//		elseif data='year' then  
//			this.setitem(this.getrow(),'class_est_date',relativedate(date(ld_date),ll_date*365))
//		end if
	end if	
end if

if ls_colname = 'cycle_item' then
	if len(data) > 63 then
		messagebox("알림","입력할수 있는 글자수는 32입니다.")
		return 1
	end if
end if

if ls_colname = 'item_chk' then
	ls_div = dw_div.gettext()
	if data = '1' then
		if ls_div <> This.getitemstring(row,'class_div') then
			uo_status.st_message.text = '구분이 같은 행만 선택할 수 있습니다.'
			return 1
		end if
	end if
end if

return 0
end event

type cb_2 from commandbutton within tp_9
integer x = 617
integer width = 512
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "예방정비 수동생성"
end type

event clicked;string ls_area, ls_factory, ls_equip, ls_div, ls_taskno, ls_equipchk
string ls_equipcode, ls_classdiv, ls_classspot, ls_classitem, ls_message
long i,ll_row, ll_count
datetime ld_dummy

uo_status.st_message.text = ""
if dw_list.getrow() < 1 then return 0

if dw_div.gettext() = '' or isnull(dw_div.gettext()) then 
	uo_status.st_message.text = "구분에서 해당항목을 선택해 주십시요."
	return 0
end if
ls_area = gs_kmarea
ls_factory = gs_kmdivision
ls_equip = dw_list.getitemstring(dw_list.getrow(),1)
ls_equipchk = dw_list.getitemstring(dw_list.getrow(),4)
if ls_equipchk = 'X' or ls_equipchk = '9' or ls_equipchk = '8' then
	uo_status.st_message.text = "해당장비는 불용,폐기,매각 된 장비입니다."
	return 0
end if
ls_div = dw_div.gettext()

// 구 버전 로직 : dw_2 : exec sp_create_task(예방정비 생성)
//dw_2.SetTransObject(sqlcmms)
//dw_2.Retrieve(ls_area,ls_factory,ls_equip,ls_div)

// 신규수정로직 : 체크박스 추가. 금일날짜로 해당장비에 대한 예방작명의 예정일을 계산한다.
// -- 1. 예방작명번호를 가져온다.
// -- 2. 해당예방정비번호에 해당하는 예방작명을 생성한다. ( TASK, TASK_PART )
// -- 3. 선택된 클래스구분에 대한 클래스( TASK_CLASS )을 생성한다

// -- 1. 예방작명번호 생성
DECLARE up_get_nexttaskno PROCEDURE FOR SP_GET_NEXTTASKNO  
			@area = :ls_area,   
         @factory = :ls_factory, 
         @psNOCODE = 'PM',   
         @NEXTTASKNO = :ls_taskno  
			using sqlcmms;

EXECUTE up_get_nexttaskno;
if sqlcmms.sqlcode = 0 then
	FETCH up_get_nexttaskno INTO :ls_taskno;
	CLOSE up_get_nexttaskno;
else
	uo_status.st_message.text = "예방정비번호를 가져오는데 실패했습니다."
	return 0
end if
ls_taskno = trim(ls_taskno)
dw_9.accepttext()
sqlcmms.AutoCommit = False
ll_row = dw_9.find("class_div = '" + ls_div + "' and item_chk = 1", 1, dw_9.RowCount())
ll_count =0
if ll_row > 0 then
	ls_equipcode = dw_9.getitemstring( ll_row, 'equip_code' )
	ls_classdiv = dw_9.getitemstring( ll_row, 'class_div' )
	ls_classspot = dw_9.getitemstring( ll_row, 'class_spot' )
	ls_classitem = dw_9.getitemstring( ll_row, 'class_item' )
	// -- 2. 예방항목 생성
	insert into task
	(task_code, area_code, factory_code, equip_code, exam_date, status_code)
	select :ls_taskno, area_code, factory_code, equip_code, getdate(), '계획'
	from equip_master
	where area_code = :ls_area and factory_code= :ls_factory and
			equip_code = :ls_equipcode
	using sqlcmms;
	
	if sqlcmms.sqlcode <> 0 then
		messagebox("err",sqlcmms.sqlerrtext)
		ls_message = 'task_err'
		goto RollBack_
	end if
	
	//예방 항목에 따른 소요 자재 생성
	INSERT INTO TASK_part(area_code, factory_code, task_code, part_code, est_qty) 
	SELECT :ls_area, :ls_factory, :ls_taskno,  part_code, sum(class_qty)
	from equip_class
	where area_code = :ls_area and factory_code= :ls_factory and
			equip_code = :ls_equipcode and class_div = :ls_classdiv and 
			class_spot = :ls_classspot and class_item = :ls_classitem and
			part_code<>''
	group by part_code
	using sqlcmms;
	
	if sqlcmms.sqlcode <> 0 then
		messagebox("err",sqlcmms.sqlerrtext)
		ls_message = 'task_part_err'
		goto RollBack_
	end if
end if

DO WHILE ll_row > 0
	if ll_row > 0 then
		ls_equipcode = dw_9.getitemstring( ll_row, 'equip_code' )
		ls_classdiv = dw_9.getitemstring( ll_row, 'class_div' )
		ls_classspot = dw_9.getitemstring( ll_row, 'class_spot' )
		ls_classitem = dw_9.getitemstring( ll_row, 'class_item' )
		// -- 3.
		INSERT INTO TASK_CLASS
		(task_code, class_div,class_spot, class_item, class_basis,class_process, 
		class_est_time_hour, class_est_time_min, part_code, class_est_qty,
		area_code, factory_code) 
		SELECT :ls_taskno, class_div,class_spot, class_item, class_basis,class_process, 
			class_est_time_hour, class_est_time_min, part_code,class_qty,
			area_code, factory_code
		from equip_class
		where area_code = :ls_area and factory_code= :ls_factory and
				equip_code = :ls_equipcode and class_div = :ls_classdiv and
				class_spot = :ls_classspot and class_item = :ls_classitem 
		using sqlcmms;
		
		if sqlcmms.sqlcode <> 0 then
			messagebox("err",sqlcmms.sqlerrtext)
			ls_message = 'task_class_err'
			goto RollBack_
		end if
		
		// dw_10 : exec sp_get_nextdate
		// 사이클 주기에 맞는 다음수행예정일을 생성한다.
		dw_10.settransobject(sqlcmms)
		dw_10.retrieve(dw_9.getitemstring(ll_row,8),dw_9.getitemnumber(ll_row,7),f_cmms_sysdate(),ld_dummy) 
		dw_9.setitem(ll_row,9,dw_10.getitemdatetime(1,1))
	end if
	ll_row=ll_row + 1
	if dw_9.rowcount() < ll_row then
		ll_row = 0 
	else
		ll_row = dw_9.find("class_div = '" + ls_div + "' and item_chk = 1", ll_row, dw_9.RowCount())
	end if
LOOP

if dw_9.update() <> 1 then
	messagebox("err",sqlcmms.sqlerrtext)
	ls_message = 'equip_class_err'
	goto RollBack_
end if

Commit Using sqlcmms;
sqlcmms.AutoCommit = true
uo_status.st_message.text = '예방정비 생성이 성공적으로 수행되었습니다.'
return 1

RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = true
uo_status.st_message.text = '예방정비 생성이 실패하였습니다. 에러 : ' + ls_message
return -1
end event

type tp_10 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "작업자점검"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
em_1 em_1
st_6 st_6
st_5 st_5
st_2 st_2
dw_10_03 dw_10_03
dw_10_02 dw_10_02
cb_1 cb_1
ddlb_1 ddlb_1
st_1 st_1
dw_10_01 dw_10_01
end type

on tp_10.create
this.em_1=create em_1
this.st_6=create st_6
this.st_5=create st_5
this.st_2=create st_2
this.dw_10_03=create dw_10_03
this.dw_10_02=create dw_10_02
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.dw_10_01=create dw_10_01
this.Control[]={this.em_1,&
this.st_6,&
this.st_5,&
this.st_2,&
this.dw_10_03,&
this.dw_10_02,&
this.cb_1,&
this.ddlb_1,&
this.st_1,&
this.dw_10_01}
end on

on tp_10.destroy
destroy(this.em_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.dw_10_03)
destroy(this.dw_10_02)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.dw_10_01)
end on

type em_1 from editmask within tp_10
integer x = 247
integer y = 4
integer width = 402
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12639424
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm"
boolean spin = true
end type

type st_6 from statictext within tp_10
integer x = 1097
integer y = 124
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "월간점검 :"
boolean focusrectangle = false
end type

type st_5 from statictext within tp_10
integer x = 613
integer y = 124
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "주간점검 :"
boolean focusrectangle = false
end type

type st_2 from statictext within tp_10
integer y = 124
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "일일점검 :"
boolean focusrectangle = false
end type

type dw_10_03 from uo_datawindow within tp_10
integer x = 2034
integer y = 184
integer width = 1481
integer height = 852
integer taborder = 30
string dataobject = "d_equip_daily_3"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
check_data =3
end event

type dw_10_02 from uo_datawindow within tp_10
integer x = 1527
integer y = 184
integer width = 1518
integer height = 852
integer taborder = 20
string dataobject = "d_equip_daily_2"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
check_data =2
end event

type cb_1 from commandbutton within tp_10
integer x = 672
integer y = 8
integer width = 402
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "인쇄 미리보기"
end type

event clicked;string ls_equip,ls_div

ls_equip=dw_list.getitemstring(dw_list.getrow(),1)
ls_div=ddlb_1.text

OpenSheet(w_report_preview, w_frame, 0, Layered!)

//w_report_preview.dw_report.dataobject = 'dr_daily_report'
//w_report_preview.dw_report.SetTransObject(sqlcmms)
//w_report_preview.dw_report.retrieve(ls_equip, em_1.text)

w_report_preview.dw_report.dataobject = 'dr_daily_report_new'
w_report_preview.dw_report.SetTransObject(sqlcmms)
w_report_preview.dw_report.retrieve(ls_equip, em_1.text)

w_report_preview.TriggerEvent('ue_preview_mode')
end event

type ddlb_1 from dropdownlistbox within tp_10
boolean visible = false
integer x = 1691
integer y = 16
integer width = 603
integer height = 300
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string item[] = {"일일안전점검표"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;iw_this.triggerevent('ue_retrieve_each_tab')
	

end event

type st_1 from statictext within tp_10
integer x = 14
integer y = 20
integer width = 215
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "점검월 :"
boolean focusrectangle = false
end type

type dw_10_01 from uo_datawindow within tp_10
integer y = 184
integer width = 1509
integer height = 852
integer taborder = 10
string dataobject = "d_equip_daily_1"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
check_data =1
end event

type tp_11 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 12632256
string text = "자재사용내역"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_11 dw_11
end type

on tp_11.create
this.dw_11=create dw_11
this.Control[]={this.dw_11}
end on

on tp_11.destroy
destroy(this.dw_11)
end on

type dw_11 from uo_datawindow within tp_11
integer width = 3342
integer height = 1076
integer taborder = 10
string dataobject = "d_wo_part_hist"
boolean ib_select_row = false
end type

event clicked;call super::clicked;Integer li_cnt
datetime ld_lastdate
String ls_equcode, ls_partcode, ls_podate, ls_Item

id_dw_current = this

if lower(dwo.Name) <> 'lastdate' then return

ls_equcode = dw_list.getitemstring(dw_list.getrow(), 1)
ls_partcode = GetItemString(row, 2)
ld_lastdate = dwo.Primary[row]

li_cnt = 0
DECLARE Date_cur CURSOR FOR
	Select out_date
	  From Part_Out
	 Where equip_code = :ls_equcode And Part_Code = :ls_partcode
	 ORDER BY out_date DESC
USING sqlcmms;

OPEN Date_cur;
Do While True
	FETCH Date_cur 
	 INTO :ld_lastdate;
	if sqlcmms.sqlcode <> 0 then
		exit
	end if
	
	li_cnt++
	ls_Item = ls_Item + string(ld_lastdate) + '~t' + String(li_cnt) + '/'
Loop
CLOSE Date_cur;

if ls_Item = '' or IsNull(ls_Item) then return
this.object.lastdate.values = ls_Item


end event

event doubleclicked;call super::doubleclicked;/*
str_parm lstr
long ll_upper_bound, i, ll_insert

if lower(string(dwo.name)) = 'part_code' then

	lstr.s_parm[1] = 'd_lookup_part'
	lstr.s_parm[2] = ''	
	lstr.s_parm[3] = '1'	
	lstr.Check = true
	
	OpenWithParm(w_cd_search_multi,lstr)
	
	lstr = Message.PowerObjectParm
	
	ll_upper_bound = UpperBound(lstr.s_array, 1)
	
	if ll_upper_bound < 1 then return
	
	for i = 1 to ll_upper_bound
		if IsNull(lstr.s_array[i, 1]) or lstr.s_array[i, 1] = '' then exit
		
		if i = 1 then
			this.SetItem(row, 'part_code', lstr.s_array[i, 1])
			ll_insert = row
		else
			ll_insert = this.InsertRow(0)
			this.SetItem(ll_insert, 'part_code', lstr.s_array[i, 1])
		end if
		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
	next
end if
*/
end event

event itemchanged;call super::itemchanged;/*
iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_spec, ls_part_location, ls_part_code, ls_part_unit
long ls_part_invy
ls_colname = dwo.name

if ls_colname = 'part_code' then
	this.GetChild('part_code', ldwc)
	This.AcceptText()
	ls_part_code = This.GetItemString(row,'part_code')
	If isnull(ls_part_code) or ls_part_code = '' then Return

	ll_row = f_dddw_getrow(This,row,'part_code',ls_part_code)
	//ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_part_name = ldwc.GetItemString(ll_row, 'part_name')
		ls_part_spec = ldwc.GetItemstring(ll_row, 'part_spec')
		ls_part_location = ldwc.GetItemstring(ll_row, 'part_location')
		ls_part_unit = ldwc.GetItemstring(ll_row, 'part_unit')
		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'part_spec', ls_part_spec)
		this.SetItem(row, 'part_location', ls_part_location)
		this.SetItem(row, 'part_unit', ls_part_unit)

	end if
end if
*/
end event

type uo_area from u_cmms_select_area within w_pisf010
event destroy ( )
integer x = 91
integer y = 904
integer taborder = 60
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

type uo_division from u_cmms_select_division within w_pisf010
event destroy ( )
integer x = 91
integer y = 988
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type gb_1 from groupbox within w_pisf010
integer x = 14
integer y = 856
integer width = 677
integer height = 220
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

