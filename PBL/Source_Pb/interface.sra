$PBExportHeader$interface.sra
$PBExportComments$MIS Interface
forward
global type interface from application
end type
global uo_transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_ini_file, g_s_date, g_s_time, g_s_datetime
boolean gb_focus
end variables
global type interface from application
string appname = "interface"
end type
global interface interface

on interface.create
appname="interface"
message=create message
sqlca=create uo_transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on interface.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_select_inifile)
end event

ing 		g_s_date="", g_s_datetime="", g_s_time=""
string 		g_s_ipaddr="", g_s_macaddr=""
//connect check ¿ë
string 		g_s_sugangfg
ulong 		g_l_connect, g_l_open

string 		check_conn = '0'
boolean 		gb_focus
string 		gs_kmarea, gs_kmdivision
string 		gs_tag, gs_path
end variables
global type interface from application
string appname = "interface"
end type
global interface interface

on interface.create
appname="interface"
message=create message
sqlca=create uo_transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on interface.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_select_inifile)
end event

