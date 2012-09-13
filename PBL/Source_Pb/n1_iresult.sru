$PBExportHeader$n1_iresult.sru
$PBExportComments$InternetResult Standard Class Object
forward
global type n1_iresult from internetresult
end type
end forward

global type n1_iresult from internetresult
end type
global n1_iresult n1_iresult

type variables
Blob ib_photo
end variables

forward prototypes
public function integer internetdata (blob data)
end prototypes

public function integer internetdata (blob data);ib_photo = data

Return 1
end function

on n1_iresult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n1_iresult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

