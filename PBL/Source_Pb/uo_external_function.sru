$PBExportHeader$uo_external_function.sru
forward
global type uo_external_function from nonvisualobject
end type
end forward

global type uo_external_function from nonvisualobject
end type
global uo_external_function uo_external_function

type prototypes
function ulong GetCurrentDirectoryA(ulong size, ref string path) library "kernel32.dll"
end prototypes

on uo_external_function.create
TriggerEvent( this, "constructor" )
end on

on uo_external_function.destroy
TriggerEvent( this, "destructor" )
end on

