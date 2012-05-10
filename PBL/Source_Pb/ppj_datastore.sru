$PBExportHeader$ppj_datastore.sru
$PBExportComments$박병주가 만든 DataStore ( 하하하~~ )
forward
global type ppj_datastore from datastore
end type
end forward

global type ppj_datastore from datastore
end type
global ppj_datastore ppj_datastore

type variables
Window	iw_Sheet
end variables

event retrieverow;
iw_Sheet.TriggerEvent( 'ue_rowcount', 0, Row )
end event

on ppj_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ppj_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event retrievestart;
iw_Sheet = w_frame.GetActiveSheet()

end event

