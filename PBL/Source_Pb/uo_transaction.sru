$PBExportHeader$uo_transaction.sru
$PBExportComments$DB2 sp
forward
global type uo_transaction from transaction
end type
end forward

global type uo_transaction from transaction
end type
global uo_transaction uo_transaction

type prototypes
subroutine SP_RGZPF01(string LIB,string FIL) RPCFUNC 


end prototypes

on uo_transaction.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_transaction.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

