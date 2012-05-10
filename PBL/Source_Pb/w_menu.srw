$PBExportHeader$w_menu.srw
$PBExportComments$KDAC Main-Menu
forward
global type w_menu from window
end type
type gb_2 from groupbox within w_menu
end type
type gb_9 from groupbox within w_menu
end type
type gb_8 from groupbox within w_menu
end type
type gb_7 from groupbox within w_menu
end type
type gb_6 from groupbox within w_menu
end type
type gb_5 from groupbox within w_menu
end type
type gb_4 from groupbox within w_menu
end type
type gb_3 from groupbox within w_menu
end type
type uo_status from uo_commonstatus within w_menu
end type
type tv_1 from treeview within w_menu
end type
type lv_1 from listview within w_menu
end type
type p_1 from picture within w_menu
end type
type gb_1 from groupbox within w_menu
end type
type p_11 from picture within w_menu
end type
type p_14 from picture within w_menu
end type
type p_12 from picture within w_menu
end type
type p_13 from picture within w_menu
end type
type p_15 from picture within w_menu
end type
type p_2 from picture within w_menu
end type
type p_3 from picture within w_menu
end type
type p_4 from picture within w_menu
end type
type p_연구 from picture within w_menu
end type
type p_영업 from picture within w_menu
end type
type p_구매 from picture within w_menu
end type
type p_생산 from picture within w_menu
end type
type p_관리 from picture within w_menu
end type
type p_ipis from picture within w_menu
end type
type p_설비 from picture within w_menu
end type
type p_공통 from picture within w_menu
end type
end forward

global type w_menu from window
boolean visible = false
integer x = 5
integer y = 212
integer width = 4663
integer height = 2708
boolean titlebar = true
string title = "종합정보시스템-메뉴"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 12632256
event ue_chglistview ( string ag_newview )
event syscommand pbm_syscommand
gb_2 gb_2
gb_9 gb_9
gb_8 gb_8
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
uo_status uo_status
tv_1 tv_1
lv_1 lv_1
p_1 p_1
gb_1 gb_1
p_11 p_11
p_14 p_14
p_12 p_12
p_13 p_13
p_15 p_15
p_2 p_2
p_3 p_3
p_4 p_4
p_연구 p_연구
p_영업 p_영업
p_구매 p_구매
p_생산 p_생산
p_관리 p_관리
p_ipis p_ipis
p_설비 p_설비
p_공통 p_공통
end type
global w_menu w_menu

type variables
Datastore 	i_ds_data[]
String			root_nm
Integer		i_n_pos
Decimal   	i_n_tm
String			i_s_title1, i_s_title2, i_s_title3,  i_s_title4 
end variables

forward prototypes
public subroutine wf_add_picture (treeview ag_tvcurrent)
public function integer wf_add_lv_items (integer ag_level, integer ag_rows, listview ag_lvcurrent)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public function string wf_chk_facility_user ()
public subroutine wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent, listview ag_lvcurrent)
public subroutine wf_item_clear ()
public subroutine wf_init_kdacini ()
public subroutine wf_set_listview (integer ag_level, integer ag_row, ref listviewitem ag_lvinew)
end prototypes

event ue_chglistview(string ag_newview);Choose Case	ag_newview
	Case	"LargeIcon"
		lv_1.View = 	ListViewLargeIcon!
	Case 	"SmallIcon"
		lv_1.View = 	ListViewSmallIcon!
	Case 	"List"
		lv_1.View = 	ListViewList!
End Choose

end event

event syscommand;// window title-bar & button 제어
if message.wordparm	  	=	61730 then		//double click
	message.processed		= 	true
	message.returnvalue 		= 	1
end if

if message.wordparm	  	= 	61458 then		//title click
	message.processed   		= 	true
	message.returnvalue 		= 	1
end if

if message.wordparm	  	= 	61536 then		//window close
	message.processed   		= 	true
	message.returnvalue 		= 	1
end if

if message.wordparm	  	= 	61587 then		//window control menu
	message.processed   		= 	true
	message.returnvalue 		= 	1
end if

end event

public subroutine wf_add_picture (treeview ag_tvcurrent);ag_tvcurrent.PictureHeight	= 	15
ag_tvcurrent.PictureWidth 	=	16

ag_tvcurrent.AddPicture("Library!")
ag_tvcurrent.AddPicture("DosEdit!")
ag_tvcurrent.AddPicture("Custom050!")
ag_tvcurrent.AddStatePicture("Save!")

end subroutine

public function integer wf_add_lv_items (integer ag_level, integer ag_rows, listview ag_lvcurrent);Integer			ln_Cnt
ListViewItem		l_lvi_New

// ListView에 Item을 추가
For 	ln_Cnt = 1 To ag_Rows
		// ListView에 Item에 값을 추가	
		wf_set_listview(ag_Level, ln_Cnt, l_lvi_New)
		If ag_lvcurrent.AddItem(l_lvi_New) < 1 Then
			Return -1
		End If
Next

Return 	ag_Rows

end function

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			ln_Cnt
TreeViewItem	l_tvi_New

For	ln_Cnt =	1	To	ag_Rows
		// TreeView에 Item에 각각의 값을 Setting시킨다.
		wf_set_items(ag_Level, ln_Cnt, l_tvi_New)
		// TreeView에 Item을 추가시킨다.
		If 	ag_this.InsertItemLast(ag_Parent, l_tvi_New)	<	1	Then
			Return -1
		End If
Next
Return	ag_Rows

end function

public function string wf_chk_facility_user ();Integer	ln_count

select 	count(*)	into	:ln_count	from comm140
where 	emp_no 	= :g_s_empno and substring(use_win,3,3) in ( 'pis' , '') 
using 	sqlpis ;

if ln_count > 0 then
	return 'Y'
end if
return 	'N'
end function

public subroutine wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew);Integer	ln_Picture

Choose Case ag_Level
	Case 1
		ag_tviNew.Label		=	i_ds_Data[2].Object.win_nm[ag_row]
		ag_tviNew.Data  		= 	i_ds_Data[2].Object.menu_cd[ag_Row]
		ag_tviNew.expanded	= 	false
		ag_tviNew.Children 	= 	false
End Choose

ag_tviNew.SelectedPictureIndex	=	4
ag_tviNew.PictureIndex 			= 	ag_Level
end subroutine

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent, listview ag_lvcurrent);TreeViewItem	l_tvi_Current
Treeview			l_tv_current
Integer			ln_Level, ln_rows,ln_deleterow
String				ls_Parm

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
ln_Level	=	l_tvi_Current.Level

//Determine the Retrieval arguments for the new data

Choose Case ln_Level
	case 1
		ls_Parm	= 	mid(string(l_tvi_Current.Data),1,2)
		ln_rows 	=	i_ds_Data[2].Retrieve(ls_Parm)
		wf_add_items(ag_handle,1,ln_rows,ag_tvcurrent)
	case 2
		if isnull(l_tvi_Current.Data) or string(l_tvi_Current.Data) < '' then
			ls_Parm 	= 	'1'	
		else
			ls_Parm 	= 	mid(string(l_tvi_Current.Data),1,3)
		end if
		
		i_ds_Data[3].Reset()
		ln_rows	=	i_ds_Data[3].Retrieve(ls_Parm)
		if	g_s_deptcd	<>	'2300'	then
			ln_deleterow	=	i_ds_Data[3].find("win_id = 'w_accm907u'",1,ln_rows)
			if	ln_deleterow	>	0	then
				i_ds_Data[3].Deleterow(ln_deleterow)
				ln_rows	=	i_ds_Data[3].rowcount()
			end if
		end if
		//ListView에 Item을 추가
		ag_lvcurrent.DeleteItems()
		wf_add_lv_items(ln_Level, ln_rows, ag_lvcurrent)
end choose
end subroutine

public subroutine wf_item_clear ();Long				ln_Root, ln_tvi
TreeViewItem	l_tvi_Root

lv_1.Deleteitems()
do until tv_1.FindItem(roottreeitem!, 0) = -1 
    ln_tvi = tv_1.FindItem(roottreeitem!, 0)
    tv_1.DeleteItem(ln_tvi)
loop

end subroutine

public subroutine wf_init_kdacini ();String			ls_profile
Datastore 	ls_datastore
Integer 		i,ln_count

ls_datastore 	=	create datastore
ls_datastore.dataobject	=	"d_comm002_retrieve"
ls_datastore.settransobject(sqlpis) ;
ln_count = ls_datastore.retrieve()
for i = 1 to ln_count
	ls_profile = profilestring( "c:\kdac\kdac.ini", "IPADDR", '"' + trim(ls_datastore.object.cclassip[i]) + '"', "")
	if 	ls_profile <> trim(ls_datastore.object.serverid[i]) then
		setprofilestring( "c:\kdac\kdac.ini", "IPADDR", trim(ls_datastore.object.cclassip[i]), '"' + trim(ls_datastore.object.serverid[i]) + '"')
	end if
next

ls_datastore.reset()

ls_datastore.dataobject = "d_comm001_retrieve"
ls_datastore.settransobject(sqlpis) ;
ln_count = ls_datastore.retrieve()
for i = 1 to ln_count
	if trim(ls_datastore.object.servergubun[i]) = 'A' then
		continue
	end if
	ls_profile = profilestring( "c:\kdac\kdac.ini", trim(ls_datastore.object.serverid[i]), "ServerName", "")
	if ls_profile <> trim(ls_datastore.object.servername[i]) then
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "DBMS",'"' 				+ trim(ls_datastore.object.serverdbms[i]) 		+ '"' )
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "ServerName",'"' 		+ trim(ls_datastore.object.servername[i]) 		+ '"' )
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "Database",'"' 		+ trim(ls_datastore.object.serverdatabase[i]) 	+ '"' )
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "LogId", '"' 			+ trim(ls_datastore.object.serverlogid[i]) 		+ '"' )
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "LogPass",'"' 			+ trim(ls_datastore.object.serverpassword[i]) 	+ '"' )
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "DBParm",'"' 			+ trim(ls_datastore.object.serverdbparm[i]) 		+ '"' )
	end if
	ls_profile = profilestring( "c:\kdac\kdac.ini", trim(ls_datastore.object.serverid[i]), "DBParm", "")
	if ls_profile <> trim(ls_datastore.object.serverdbparm[i]) then
		setprofilestring( "c:\kdac\kdac.ini",  trim(ls_datastore.object.serverid[i]), "DBParm",'"' 		+ trim(ls_datastore.object.serverdbparm[i]) 	+ '"' )
	end if
next
destroy ls_datastore

ls_profile = profilestring( "c:\kdac\kdac.ini", "DATABASE_EIS", "ServerName", "")
if ls_profile <> "121.182.130.30,1433" then
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "DBMS",'"MSS Microsoft SQL Server"' ) 
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "ServerName",'"121.182.130.30,1433"')
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "Database",'"EIS"')
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "LogId", '"sa"')
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "LogPass",'"goipis"')
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "DBParm",'"CommitOnDisconnect=' + "'No'" + '"')	
end if
ls_profile = profilestring( "c:\kdac\kdac.ini", "DATABASE_EIS", "DBParm", "")
if trim(ls_profile) <> "CommitOnDisconnect='No'"  then
	setprofilestring( "c:\kdac\kdac.ini",  "DATABASE_EIS", "DBParm",'"CommitOnDisconnect=' + "'No'" + '"')	
end if



end subroutine

public subroutine wf_set_listview (integer ag_level, integer ag_row, ref listviewitem ag_lvinew);///////////////////////////////////////////////////////////////////////
// 기능 : ListView에 Icon을 보여주는 Function
//
//			 input => ag_level(int), ag_row(int), ag_lvinew(listviewitem)
///////////////////////////////////////////////////////////////////////
String		ls_winid, ls_usewin, ls_usegrd, ls_useyesno, ls_winidkey, ls_empno
Integer  	ln_i

//등록된 Window Display
ag_lviNew.Label 	= 	i_ds_Data[3].Object.win_nm[ag_Row]
ag_lviNew.Data  	= 	i_ds_Data[3].Object.menu_cd[ag_Row] + i_ds_Data[3].Object.win_id[ag_Row]

if i_ds_Data[3].Object.win_st[ag_Row] = 'Y' or i_ds_Data[3].Object.win_id[ag_Row] = 'w_comm107i' then
	ag_lviNew.PictureIndex	=	1
else
	ag_lviNew.PictureIndex 	= 	2
end if

//사용가능 Window 확인
ls_winid		=	i_ds_Data[3].Object.win_id[ag_Row]
ls_empno 	= 	g_s_empno

//개인별
if	ls_winid	=	'w_comm107i' then
	ag_lviNew.Data	=	'5' + ag_lviNew.Data
	ls_useyesno 		= 	"YES"
else
	for		ln_i	=	len(trim(ls_winid))	to	2	step	-1
			ls_winidkey		=	mid(ls_winid, 1, ln_i)
			select		use_grd	into	:ls_usegrd	from	comm140
			where  	emp_no		=	:ls_empno 	and
					 	use_win 		= 	:ls_winidkey
			using sqlpis ;
			if 	sqlpis.sqlcode 		=	0 then
				ag_lviNew.Data	=	ls_usegrd + ag_lviNew.Data
				ls_useyesno			=	"YES"
				exit
			end if
	next
end if
//사용불가 Window Setting
if 	ls_useyesno	<>	"YES" then
	if 	ag_lviNew.PictureIndex = 1  then
		ag_lviNew.PictureIndex = 3
	end if
end if

 
end subroutine

on w_menu.create
this.gb_2=create gb_2
this.gb_9=create gb_9
this.gb_8=create gb_8
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.uo_status=create uo_status
this.tv_1=create tv_1
this.lv_1=create lv_1
this.p_1=create p_1
this.gb_1=create gb_1
this.p_11=create p_11
this.p_14=create p_14
this.p_12=create p_12
this.p_13=create p_13
this.p_15=create p_15
this.p_2=create p_2
this.p_3=create p_3
this.p_4=create p_4
this.p_연구=create p_연구
this.p_영업=create p_영업
this.p_구매=create p_구매
this.p_생산=create p_생산
this.p_관리=create p_관리
this.p_ipis=create p_ipis
this.p_설비=create p_설비
this.p_공통=create p_공통
this.Control[]={this.gb_2,&
this.gb_9,&
this.gb_8,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.uo_status,&
this.tv_1,&
this.lv_1,&
this.p_1,&
this.gb_1,&
this.p_11,&
this.p_14,&
this.p_12,&
this.p_13,&
this.p_15,&
this.p_2,&
this.p_3,&
this.p_4,&
this.p_연구,&
this.p_영업,&
this.p_구매,&
this.p_생산,&
this.p_관리,&
this.p_ipis,&
this.p_설비,&
this.p_공통}
end on

on w_menu.destroy
destroy(this.gb_2)
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.uo_status)
destroy(this.tv_1)
destroy(this.lv_1)
destroy(this.p_1)
destroy(this.gb_1)
destroy(this.p_11)
destroy(this.p_14)
destroy(this.p_12)
destroy(this.p_13)
destroy(this.p_15)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.p_4)
destroy(this.p_연구)
destroy(this.p_영업)
destroy(this.p_구매)
destroy(this.p_생산)
destroy(this.p_관리)
destroy(this.p_ipis)
destroy(this.p_설비)
destroy(this.p_공통)
end on

event open;TreeViewItem	l_tvi_Root
Environment 	Env
String				ls_registry
Long				ln_Root,	ln_Rows
Integer			ln_Cnt,i

SetPointer(HourGlass!)
GetEnvironment(env)  
// 해상도가 800X600이면 변경하지 않는다. 
If env.screenwidth = 800 and env.screenheight = 600 Then
	lv_1.width = 1778
end if  
i_s_title1 = "종합정보시스템"
// Status Line Setting
if 	g_s_kornm	=	"" then
	g_s_kornm 	= 	g_s_empno
end if

this.uo_status.st_winid.text 		= 	This.ClassName()
this.uo_status.st_kornm.text 	=	g_s_kornm
f_sysdate()
this.uo_status.st_date.text = string(g_s_date, "@@@@-@@-@@")
//Menu ToolBar Setting
w_frame.SetToolbar(1, true)
w_frame.SetToolbar(2, false)
m_frame.m_action.visible = false
//Create DataStores used by this example
//Tree_View
i_ds_Data[1]	=	Create DataStore
i_ds_Data[1].DataObject = "d_menu_01"	//중Menu-관리
i_ds_Data[2] 	= 	Create DataStore
i_ds_Data[2].DataObject = "d_menu_02"	//소Menu-처리
i_ds_Data[3] 	= 	Create DataStore
i_ds_Data[3].DataObject = "d_menu_03"	//단위화면

if g_l_connect 	= -1 then
	p_4.enabled  	= 	false
	p_11.enabled 	= 	false
	p_12.enabled 	= 	false
	p_13.enabled 	= 	false
	p_14.enabled 	= 	false
	p_15.enabled	= 	false
	p_연구.visible 	= 	true
	p_영업.visible 	= 	true
	p_생산.visible 	= 	true
	p_관리.visible 	= 	true
	p_구매.visible 	= 	true
	p_공통.visible 	= 	true
	p_ipis.visible		= 	false
	p_설비.visible 	=	false
	messagebox("확인","현재 AS/400 SERVER에 접속할 수 없습니다. IPIS 와 설비 시스템만 사용가능합니다")
elseif	g_l_connect		= 	-2	then
	p_2.enabled 		= 	false
	p_3.enabled 		= 	false
	p_연구.visible 		= 	false
	p_영업.visible 		= 	false
	p_생산.visible 		= 	false
	p_관리.visible 		= 	false
	p_구매.visible 		= 	false
	p_공통.visible 		= 	false
	p_ipis.visible 		= 	true
	p_설비.visible 		= 	true
	messagebox("확인","현재 IPIS SERVER에 접속할 수 없습니다. IPIS 와 설비 시스템 사용불가")	
end if

wf_init_kdacini() 

registryget("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","COMMITMODE",ls_registry)
if 	ls_registry <> "2" then
	registryset("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","COMMITMODE",RegString!, "2" )
end if
registryget("HKEY_USERS\.DEFAULT\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","COMMITMODE",ls_registry)
if 	ls_registry <> "2" then
	registryset("HKEY_USERS\.DEFAULT\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","COMMITMODE",RegString!, "2" )
end if
registryget("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","EXTENDEDDYNAMIC",ls_registry)
if 	ls_registry <> "0" then
	registryset("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","EXTENDEDDYNAMIC",RegString!, "0" )
end if
registryget("HKEY_USERS\.DEFAULT\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","EXTENDEDDYNAMIC",ls_registry)
if 	ls_registry <> "0" then
	registryset("HKEY_USERS\.DEFAULT\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","EXTENDEDDYNAMIC",RegString!, "0" )
end if

if FileExists("C:\WINDOWS\Fonts\malgun.ttf") = false then 
	messagebox("확인","신규 글꼴을 설치합니다.글꼴 설치에 동의하시고 확인버튼 클릭하시면 글꼴이 자동 설치됩니다.~r~n" + &
						"설치된 글꼴은 종합정보시스템 재접속시 자동 적용됩니다")
	run("c:\kdac\VistaFont_KOR.EXE")
end if
if FileExists("C:\KDAC\drivers\PSCRIPT.DLL") = false then
	messagebox("확인","PDF 파일 관련 프로그램을 설치합니다. ~r~n" + &
						"다음 --> 설치시작 --> Setup --> Install 버튼을 차례로 클릭하면 설치가 완료됩니다.")
	run("c:\kdac\kdac_email.exe")
end if
//if	FileExists("C:\WINDOWS\system32\aspemail.dll") = true or FileExists("C:\KDAC\aspemail.dll") = true then
//	run("c:\kdac\aspemail_del.bat",minimized!)
//end if  
// sasmtp 메일 추가	- 2012.01.16
if 	FileExists("C:\WINDOWS\system32\sasmtp.dll") = false then
	run("c:\kdac\sasmtp_reg.bat",minimized!)
end if
//
if FileExists("c:\kdac\kdacdw.exe") = true then
	messagebox("확인","KDAC 종합정보시스템 설정사항이 변경되었습니다.~r~n확인 버튼을 click 하신후 KDAC 종합정보시스템을 재접속 하십시오.")
	run("c:\kdac\kdacdw.bat",minimized!)
	halt close
end if





end event

event timer;f_sysdate()
uo_status.st_date.text  = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
end event

event close;Integer	ln_Cnt

// Destroy DataStores used by this example
For 	ln_Cnt = 1 To 3
		Destroy i_ds_Data[ln_Cnt]
Next

end event

event activate;Integer	ln_cnt

// ToolBar 2 Setting Off  (전체공통)
w_frame.SetToolbar(1, true)
w_frame.SetToolbar(2, false)
w_frame.SetToolbarPos(1, 2, 1, false)
// Action Menu All Off Setting
m_frame.m_action.visible = false 
For 	ln_Cnt = 1 To 3
		i_ds_Data[ln_Cnt].SetTransObject(Sqlpis)
Next
timer(30)

end event

type gb_2 from groupbox within w_menu
integer x = 110
integer y = 392
integer width = 549
integer height = 208
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_9 from groupbox within w_menu
integer x = 110
integer y = 1980
integer width = 549
integer height = 208
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within w_menu
integer x = 110
integer y = 1756
integer width = 549
integer height = 208
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_menu
integer x = 110
integer y = 1532
integer width = 549
integer height = 208
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within w_menu
integer x = 110
integer y = 1308
integer width = 549
integer height = 208
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_menu
integer x = 110
integer y = 1084
integer width = 549
integer height = 208
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_menu
integer x = 110
integer y = 860
integer width = 549
integer height = 208
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_menu
integer x = 110
integer y = 624
integer width = 549
integer height = 208
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_status from uo_commonstatus within w_menu
integer x = 18
integer y = 2468
integer width = 4626
integer height = 84
integer taborder = 60
boolean enabled = false
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

type tv_1 from treeview within w_menu
event constructor pbm_constructor
event itempopulate pbm_tvnitempopulate
event selectionchanged pbm_tvnselchanged
integer x = 727
integer y = 40
integer width = 1253
integer height = 2400
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"Custom039!","Custom039!","Custom039!"}
long picturemaskcolor = 268435456
long statepicturemaskcolor = 536870912
end type

event constructor;treeview	l_tv_current

l_tv_current	= this

wf_add_picture(l_tv_current)
end event

event itempopulate;Integer			ln_Level
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

// Determine the level
setpointer(hourglass!)
tv_1.GetItem(handle, l_tvi_Current)
ln_Level 	=	l_tvi_Current.Level

if ln_level >= 2 then return
//if tv_1.finditem(Childtreeitem!,handle) < 0 then
wf_itempopulate(handle, tv_1, lv_1)
//end if
end event

event selectionchanged;Integer			ln_Level
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

// Determine the level
Setpointer(hourglass!)
tv_1.GetItem(newhandle, l_tvi_Current)
ln_Level = l_tvi_Current.Level

if ln_Level < 2 then
	lv_1.Deleteitems()
	return
end if

wf_itempopulate(newhandle, tv_1, lv_1)

end event

event clicked;string         		ls_menucd
Integer			ln_Level, ln_row
TreeViewItem	l_tvi_Current

// Determine the level
Setpointer(hourglass!)
tv_1.GetItem(handle, l_tvi_Current)
ln_Level = l_tvi_Current.Level

if 	ln_level = 2 then
	ls_menucd = mid(l_tvi_Current.Data, 1, 2) + '00'
	select		win_nm	into	:i_s_title3	from   comm110
	where  	menu_cd	=	:ls_menucd 
	Using 		SqlPis	;
	i_s_title4	= 	"-[" + f_spacedel(l_tvi_Current.label) + "]"
   	i_s_title3 	=	"-[" + trim(i_s_title3) + "]"
end if
w_frame.title 	= 	i_s_title1 + i_s_title2 + i_s_title3 + i_s_title4


end event

type lv_1 from listview within w_menu
event doubleclicked pbm_lvndoubleclicked
event rightclicked pbm_lvnrclicked
integer x = 1993
integer y = 40
integer width = 2624
integer height = 2400
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean buttonheader = false
listviewview view = listviewlist!
string largepicturename[] = {"Window!","Move!","Debug!"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 268435456
string smallpicturename[] = {"Window!","Move!","Debug!"}
integer smallpicturewidth = 32
integer smallpictureheight = 16
long smallpicturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event doubleclicked;Setpointer(hourglass!)

Window		 	l_to_open
Long 			 	ln_i, ln_j
String		 		ls_menu_cd, ls_winid, ls_wingrd, ls_menucd
String				ls_st, ls_winnm,ls_sqlcc 
listviewitem		l_lvi_new

If	Index <= 0 Then Return
If 	this.GetItem(Index, l_lvi_new) = -1 Then Return

ls_wingrd 		= 	mid(string(l_lvi_new.Data), 1, 1)
ls_menucd 		= 	mid(string(l_lvi_new.Data), 2, 4)
ls_winid  		= 	trim(mid(string(l_lvi_new.Data),  6, 10))
ls_winnm  		= 	f_spacedel(string(l_lvi_new.Label))
ls_sqlcc 			=	upper(mid(ls_winid,3,3))

if 	mid(ls_winid,1,1)	=	'_' then // 시스템 개발팀일때 개발중인 화면 들어갈수 있게 얍씨리하게 수정 
	ls_winid		=	'w' + ls_winid
	ls_wingrd		=	'5'
	ls_menucd	= 	mid(string(l_lvi_new.Data), 1, 4)
	ls_sqlcc 		=	upper(mid(ls_winid,3,3))
end if

select		win_rpt	into :g_s_runparm	from   comm110
where 	menu_cd	=	:ls_menucd 
using 		SqlPis;

if 	sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ''
end if

if 	l_lvi_new.PictureIndex = 2 then
	if 	g_s_deptcd <> '2300' then // 시스템 개발팀일때 개발중인 화면 들어갈수 있게 얍씨리하게 수정 
		messagebox("확인","개발 중입니다.")
		return
	end if
elseif 	l_lvi_new.PictureIndex = 3 then
	if	g_s_deptcd <> '2300' then // 시스템 개발팀일때 개발중인 화면 들어갈수 있게 얍씨리하게 수정 
		messagebox("확인","접근 권한이 없습니다.")
		return
	end if
end if

// SQLCC Connection Check 
if 	ls_sqlcc = 'PSM' or ls_sqlcc = 'MED' or ls_sqlcc = 'PER' or ls_sqlcc = 'PAY' or ls_sqlcc = 'GEN' or &
	ls_sqlcc = 'ACN' or ls_sqlcc = 'SUG' or ls_sqlcc = 'PES' then
	f_connect(sqlcc)
end if
 
this.setredraw(false)

if 	f_open_sheet(ls_winid) 	=	0	then
	integer ls_systemerror 	=	0
	try 
		ls_systemerror = Opensheetwithparm(l_to_open, ls_wingrd + ls_winnm, ls_winid, w_frame, 0, Layered!) 
	catch ( runtimeerror ne )
		ls_systemerror = -1
	end try 
	if 	ls_systemerror = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

event rightclicked;Long			ln_Parent
m_lv_rmb	lm_PopMenu

lm_PopMenu	=	Create	m_lv_rmb
lm_PopMenu.m_action.PopMenu(X + PointerX(),Y + PointerY())
end event

type p_1 from picture within w_menu
integer x = 110
integer y = 176
integer width = 539
integer height = 112
boolean enabled = false
string picturename = "c:\kdac\bmp\menu1.gif"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//string ls_path
//ls_path = "C:\Program Files\Internet Explorer\iexplore.exe http://login.daum.net/Mail-bin/login.cgi?url=http://cafe.daum.net/hhtabletennis/?_top_target=cafe&webmsg=-1&id=greatkew&pw=15903547&loginmode=normal&x=20&y=5"
//run(ls_path)
end event

type gb_1 from groupbox within w_menu
integer x = 50
integer y = 12
integer width = 658
integer height = 2428
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

type p_11 from picture within w_menu
event clicked pbm_bnclicked
integer x = 137
integer y = 444
integer width = 489
integer height = 136
boolean bringtotop = true
string picturename = "c:\kdac\bmp\yungu1.gif"
boolean focusrectangle = false
end type

event clicked;TreeViewItem	l_tvi_Root
treeview 	   		l_tv_Current
Long				ln_Root, ln_Rows, ln_Cnt
String         		l_s_current_path
Integer        		k

setpointer(hourglass!)
i_s_title2			= 	"-[연구개발]"
w_frame.title 	=	i_s_title1 + i_s_title2

root_nm 					=	"연구개발"
l_tv_Current 			= 	tv_1
l_s_current_path 		=	"c:\kdac\"
p_11.PictureName 		= 	'c:\kdac\bmp\yungu2.gif'
p_12.PictureName 		= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 		= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 		=	'c:\kdac\bmp\young1.gif'
p_15.PictureName 		= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  		= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  		= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  		= 	'c:\kdac\bmp\FACILITY1.gif'

wf_item_clear()
i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('1')

for k = 1 to ln_rows
	l_tvi_Root.Label	= 	i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  	=	i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	if i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,2)) > 0 then
		l_tvi_Root.Children	=	true
	else
		l_tvi_Root.Children	=	false
	end if
	i_ds_data[2].reset()
	ln_root	=	tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next

end event

type p_14 from picture within w_menu
event clicked pbm_bnclicked
integer x = 137
integer y = 676
integer width = 498
integer height = 140
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\young1.gif"
boolean focusrectangle = false
end type

event clicked;TreeViewItem	l_tvi_Root
treeview 	   	l_tv_Current
Long				ln_Root, ln_Rows, ln_Cnt
integer        	k

// f_connect(sqlca)
i_s_title2				= 	"-[영업업무]"
w_frame.title 			=	i_s_title1 + i_s_title2

root_nm 					= 	'영업업무'
l_tv_Current 			= 	tv_1

p_11.PictureName 	= 	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young2.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY1.gif'

wf_item_clear()
i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('4')
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	l_tvi_Root.Children = True
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
	tv_1.expanditem(ln_root)
next
end event

type p_12 from picture within w_menu
event clicked pbm_bnclicked
integer x = 137
integer y = 912
integer width = 498
integer height = 140
boolean bringtotop = true
string picturename = "c:\kdac\bmp\gumae1.gif"
boolean focusrectangle = false
end type

event clicked;Long				ln_Root, ln_Rows, ln_Cnt
TreeViewItem	l_tvi_Root
treeview 	   l_tv_Current

i_s_title2 		= 	"-[구매업무]"
w_frame.title 	=	i_s_title1 + i_s_title2

root_nm 			= 	'구매업무'
l_tv_Current 	= 	tv_1

p_11.PictureName	=	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae2.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young1.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY1.gif'

wf_item_clear()
i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('2')
integer        k
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	if i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,2)) > 0 then
		l_tvi_Root.Children	= 	true
	else
		l_tvi_Root.Children 	=	false
	end if
	i_ds_data[2].reset()
//	wf_add_items(1, 1, ln_rows, l_tv_Current)
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next
end event

type p_13 from picture within w_menu
event clicked pbm_bnclicked
integer x = 137
integer y = 1136
integer width = 489
integer height = 136
boolean bringtotop = true
string picturename = "c:\kdac\bmp\saeng1.gif"
boolean focusrectangle = false
end type

event clicked;Long				ln_Root, ln_Rows, ln_Cnt
TreeViewItem	l_tvi_Root
treeview 	   	l_tv_Current

// f_connect(sqlca)
i_s_title2 		=	"-[생산업무]"
w_frame.title 	= 	i_s_title1 + i_s_title2

root_nm 			= 	"생산업무"
l_tv_Current 	= 	tv_1

p_11.PictureName 	= 	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng2.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young1.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY1.gif'

wf_item_clear()
i_ds_Data[1].reset()
ln_Rows = i_ds_Data[1].Retrieve('3')
integer k 
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	if i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,2)) > 0 then
		l_tvi_Root.Children	=	true
	else
		l_tvi_Root.Children 	= 	false
	end if
	i_ds_data[2].reset()
//	wf_add_items(1, 1, ln_rows, l_tv_Current)
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next

end event

type p_15 from picture within w_menu
event clicked pbm_bnclicked
integer x = 137
integer y = 1360
integer width = 489
integer height = 136
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\gwan1.gif"
boolean focusrectangle = false
end type

event clicked;Long				ln_Root, ln_Rows, ln_Cnt
TreeViewItem	l_tvi_Root
treeview 	   	l_tv_Current

i_s_title2 		= 	"-[관리업무]"
w_frame.title 	=	i_s_title1 + i_s_title2

root_nm 			= 	'관리업무'
l_tv_Current 	= 	tv_1

p_11.PictureName 	= 	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young1.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan2.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY1.gif'

wf_item_clear()

i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('6')

integer        k
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	if i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,2)) > 0 then
		l_tvi_Root.Children	=	true
	else
		l_tvi_Root.Children	=	false
	end if
	i_ds_data[2].reset()
//	wf_add_items(1, 1, ln_rows, l_tv_Current)
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next
end event

type p_2 from picture within w_menu
integer x = 137
integer y = 1584
integer width = 489
integer height = 136
boolean bringtotop = true
string picturename = "c:\kdac\bmp\IPIS1.gif"
boolean focusrectangle = false
end type

event clicked;Long				ln_Root, ln_Rows, ln_Cnt
TreeViewItem	l_tvi_Root
treeview 	   	l_tv_Current

i_s_title2 		=	"-[IPIS]"
w_frame.title 	= 	i_s_title1 + i_s_title2

root_nm 			= 	'IPIS'
l_tv_Current 	= 	tv_1

p_11.PictureName 	=	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young1.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS2.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY1.gif'

wf_item_clear()

i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('7')

integer        k
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	if i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,2)) > 0 then
		l_tvi_Root.Children = True
	else
		l_tvi_Root.Children = false
	end if
	i_ds_data[2].reset()
//	wf_add_items(1, 1, ln_rows, l_tv_Current)
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next
end event

type p_3 from picture within w_menu
integer x = 137
integer y = 1808
integer width = 489
integer height = 136
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\facility1.gif"
boolean focusrectangle = false
end type

event clicked;Long				ln_Root, ln_Rows, ln_Cnt
TreeViewItem	l_tvi_Root
treeview 	   	l_tv_Current

i_s_title2 		=	"-[IPIS]"
w_frame.title 	= 	i_s_title1 + i_s_title2

root_nm 			= 	'IPIS'
l_tv_Current 	= 	tv_1

p_11.PictureName 	= 	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young1.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt1.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY2.gif'

wf_item_clear()

i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('8')

integer        k
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	l_tvi_Root.Children = True
//	wf_add_items(1, 1, ln_rows, l_tv_Current)
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next

end event

type p_4 from picture within w_menu
integer x = 137
integer y = 2032
integer width = 489
integer height = 136
boolean bringtotop = true
string picturename = "c:\kdac\bmp\gongt1.gif"
boolean focusrectangle = false
end type

event clicked;Long				ln_Root, ln_Rows, ln_Cnt
TreeViewItem	l_tvi_Root
treeview 	   	l_tv_Current

i_s_title2 		=	"-[공통업무]"
w_frame.title 	=	i_s_title1 + i_s_title2

root_nm 			=	'공통업무'
l_tv_Current 	= 	tv_1

p_11.PictureName 	= 	'c:\kdac\bmp\yungu1.gif'
p_12.PictureName 	= 	'c:\kdac\bmp\gumae1.gif'
p_13.PictureName 	= 	'c:\kdac\bmp\saeng1.gif'
p_14.PictureName 	= 	'c:\kdac\bmp\young1.gif'
p_15.PictureName 	= 	'c:\kdac\bmp\gwan1.gif'
p_4.PictureName  	= 	'c:\kdac\bmp\gongt2.gif'
p_2.PictureName  	= 	'c:\kdac\bmp\IPIS1.gif'
p_3.PictureName  	= 	'c:\kdac\bmp\FACILITY1.gif'
wf_item_clear()

i_ds_Data[1].Reset()
ln_Rows = i_ds_Data[1].Retrieve('5')

integer        k
for k = 1 to ln_rows
	l_tvi_Root.Label = i_ds_Data[1].object.win_nm[k]
	l_tvi_Root.Data  = i_ds_Data[1].object.menu_cd[k]
	l_tvi_Root.PictureIndex = 1
	l_tvi_Root.SelectedPictureIndex = 1
	if i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,2)) > 0 then
		l_tvi_Root.Children = True
	else
		l_tvi_Root.Children = false
	end if
	i_ds_data[2].reset()
//	wf_add_items(1, 1, ln_rows, l_tv_Current)
	ln_root = tv_1.insertitemlast(0,l_tvi_root)
//	tv_1.expanditem(ln_root)
next
 
end event

type p_연구 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 468
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_영업 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 696
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_구매 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 932
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_생산 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 1156
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_관리 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 1384
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_ipis from picture within w_menu
boolean visible = false
integer x = 302
integer y = 1604
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_설비 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 1828
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

type p_공통 from picture within w_menu
boolean visible = false
integer x = 302
integer y = 2056
integer width = 169
integer height = 96
boolean bringtotop = true
string picturename = "Debug!"
boolean focusrectangle = false
end type

