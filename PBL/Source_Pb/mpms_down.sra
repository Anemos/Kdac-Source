$PBExportHeader$mpms_down.sra
$PBExportComments$Generated Application Object
forward
global type mpms_down from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_appname = "mpms_gather", gs_inifile = "mpms_gather.ini", gs_cur_dir
Transaction sqlpis
end variables
global type mpms_down from application
string appname = "mpms_down"
end type
global mpms_down mpms_down

type prototypes
FUNCTION ulong GetCurrentDirectoryA( ulong buffern, ref string path ) LIBRARY "Kernel32.dll"
end prototypes

on mpms_down.create
appname="mpms_down"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on mpms_down.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//gs_appname	= CommandParm()
//gs_appname	= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
//gs_inifile = "ipis.ini"
//gs_inifile = gs_appname + ".ini"

SQLPIS = CREATE transaction
SQLPIS.DBMS       =ProfileString(gs_inifile,"ELE","DBMS",            " ")
SQLPIS.ServerName =ProfileString(gs_inifile,"ELE","ServerName",      " ")
SQLPIS.Database   =ProfileString(gs_inifile,"ELE","Database",        " ")
SQLPIS.LogID      =ProfileString(gs_inifile,"ELE","LogId",           " ")
SQLPIS.LogPass    =ProfileString(gs_inifile,"ELE","LogPass",     " ")
SQLPIS.DbParm     =ProfileString(gs_inifile,"ELE","DbParm",          " ")
SQLPIS.autocommit = True

open(w_connect)

connect using sqlpis;
If	SQLPIS.SqlCode <> 0 Then
	close(w_connect)
	MessageBox ("설치오류 (" + gs_appname + ")", " DB와 연결되지 않았습니다." + "~r~n" + "환경설정을 확인하십시요.")
End If
close(w_connect)

f_download()
end event

event systemerror;Open(w_system_error)
If Message.DoubleParm = 0 Then
	Halt Close
End if
end event

event close;Disconnect using SQLPIS;
end event

