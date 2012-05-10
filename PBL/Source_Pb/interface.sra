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

