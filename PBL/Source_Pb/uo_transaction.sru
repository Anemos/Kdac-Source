$PBExportHeader$uo_transaction.sru
forward
global type uo_transaction from transaction
end type
end forward

global type uo_transaction from transaction
end type
global uo_transaction uo_transaction

type prototypes
subroutine SP_SAMP02(string I_CUSTCD,ref string O_CUSTNM) RPCFUNC ALIAS FOR "PBCOMMON.SP_SAMP02" 
subroutine SF_SEQ_01(string I_CUSTCD,ref string O_CUSTNM) RPCFUNC ALIAS FOR "PBSLE.SF_SEQ_01" 


end prototypes

on uo_transaction.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_transaction.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
this.DBMS       = "ODBC"
this.autocommit = true
this.DBParm = "ConnectString='DSN=CA/400 ODBC FOR PB;UID=casinv;PWD=dpainv',PBCatalogOwner='PBCOMMON',CommitOnDisconnect='No'" 

connect using this ;
end event

event destructor;disconnect using this ;
end event

