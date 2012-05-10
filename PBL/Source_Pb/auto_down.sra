$PBExportHeader$auto_down.sra
$PBExportComments$Generated Application Object
forward
global type auto_down from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_appname, gs_inifile = "ipis_gather.ini", gs_cur_dir
end variables

global type auto_down from application
string appname = "auto_down"
end type
global auto_down auto_down

type prototypes
FUNCTION ulong GetCurrentDirectoryA( ulong buffern, ref string path ) LIBRARY "Kernel32.dll"
end prototypes

on auto_down.create
appname="auto_down"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on auto_down.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// DB connect
SQLCA.DBMS       =ProfileString(gs_inifile,"DATABASE","DBMS",            " ")
SQLCA.ServerName =ProfileString(gs_inifile,"DATABASE","ServerName",      " ")
SQLCA.Database   =ProfileString(gs_inifile,"DATABASE","Database",        " ")
SQLCA.LogID      =ProfileString(gs_inifile,"DATABASE","LogId",           " ")
SQLCA.LogPass    =ProfileString(gs_inifile,"DATABASE","LogPass",     " ")
SQLCA.DbParm     =ProfileString(gs_inifile,"DATABASE","DbParm",          " ")
sqlca.autocommit = True
gs_appname	= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")

open(w_connect)

connect using sqlca;
If	SQLCA.SqlCode <> 0 Then
	close(w_connect)
	MessageBox ("설치오류", " DB와 연결되지 않았습니다." + "~r~n" + "환경설정을 확인하십시요.")
	return
End If
close(w_connect)

f_download()
end event

event systemerror;Open(w_system_error)
If Message.DoubleParm = 0 Then
	Halt Close
End if
end event

event close;Disconnect Using SQLCA;
end event

