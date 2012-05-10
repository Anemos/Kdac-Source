$PBExportHeader$wip_execute_day.sra
$PBExportComments$Generated Application Object
forward
global type wip_execute_day from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_ini_file, g_s_date, g_s_time, g_s_gubun, g_s_plant, g_s_datetime
boolean gb_focus
end variables
global type wip_execute_day from application
string appname = "wip_execute_day"
end type
global wip_execute_day wip_execute_day

on wip_execute_day.create
appname="wip_execute_day"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on wip_execute_day.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open( w_select_inifile )
end event

