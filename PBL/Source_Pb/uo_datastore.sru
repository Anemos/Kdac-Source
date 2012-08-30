$PBExportHeader$uo_datastore.sru
$PBExportComments$datastore userobject
forward
global type uo_datastore from datastore
end type
end forward

global type uo_datastore from datastore
end type
global uo_datastore uo_datastore

event dberror;MessageBox ( "¿À·ù" , "DB Error Code = " + String ( sqldbcode ) + "~r~n" &
							+ sqlerrtext )
end event

on uo_datastore.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_datastore.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

