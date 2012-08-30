$PBExportHeader$uo_datastore2.sru
$PBExportComments$RetrieveStart : Return 2
forward
global type uo_datastore2 from datastore
end type
end forward

global type uo_datastore2 from datastore
end type
global uo_datastore2 uo_datastore2

event dberror;MessageBox ( "¿À·ù" , "DB Error Code = " + String ( sqldbcode ) + "~r~n" &
							+ sqlerrtext )
end event

on uo_datastore2.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_datastore2.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event retrievestart;Return 2
end event

