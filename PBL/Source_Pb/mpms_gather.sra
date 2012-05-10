$PBExportHeader$mpms_gather.sra
$PBExportComments$금형현장관리 Application Object
forward
global type mpms_gather from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//STRING	gs_area_code			// 지역 코드
//STRING	gs_division_code		// 공장 코드

STRING	gs_area_name			// WorkGroup
STRING	gs_division_name		// WorkGroup 명

STRING	gs_workcenter_code[]	// 조코드	배열
STRING	gs_line_code[]			// 라인코드	배열

STRING	gs_workcenter_name[]	// 조명		배열
STRING	gs_line_name[]			// 라인명	배열

STRING	gs_SerialFlag			// 씨리얼 통신 FLAG

INTEGER	gi_show_count[]		// 조회리스트 카운터
INTEGER	gi_tot_tab_count		// 단말기를 사용하는 라인수
INTEGER	gi_tab_index			// 선택된어진 라인 INDEX
INTEGER	gi_page_index			// 선택된어진 페이지 INDEX

STRING	gs_appname, gs_inifile		= "MPMS_GATHER.INI"

BOOLEAN	gb_focus
STRING   gs_main_path = "C:\kdac\mpms_gather"

TRANSACTION SQLPIS

end variables
global type mpms_gather from application
string appname = "mpms_gather"
end type
global mpms_gather mpms_gather

type prototypes
FUNCTION long SetLocalTime(ref str_system_time lpSystemTime ) LIBRARY "kernel32.dll"
FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll"
FUNCTION boolean SetCurrentDirectoryA(ref string cdir) LIBRARY "kernel32.dll"

end prototypes

on mpms_gather.create
appname="mpms_gather"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on mpms_gather.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String	ls_computer
//ulong ul_BufferLen
//
//ul_BufferLen = 100 
//gs_main_path = space(ul_BufferLen) 
//GetCurrentDirectoryA(ul_BufferLen, gs_main_path) 

gs_appname	= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")

// Win 95, 98
RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\VNETSUP", "ComputerName", ls_computer)
// Windows 2000
//RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\MSTCP", "HostName", ls_computer)

// Profile MPMS
SQLCA.DBMS			= ProfileString(gs_inifile, "Database", "DBMS", "")
SQLCA.Database		= ProfileString(gs_inifile, "Database", "DataBase", "")
SQLCA.ServerName	= ProfileString(gs_inifile, "Database", "ServerName", "")
SQLCA.LogId			= ProfileString(gs_inifile, "Database", "LogId", "")
SQLCA.LogPass		= ProfileString(gs_inifile, "Database", "LogPass", "")
//SQLCA.DBParm		= ProfileString(gs_inifile, "Database", "DbParm", "")
SQLCA.DbParm     = "appname='MPMS_GATHER for KDAC', host='" + ls_computer + "'"
SQLCA.AutoCommit	= TRUE

connect Using SQLCA;

// 연결체크
If SQLCA.SQLCode <> 0 Then
	Open(w_mpsg001b)
	Halt
END IF

Open(w_mpsg000)

end event

