$PBExportHeader$n_kor_eng.sru
$PBExportComments$�ѿ���� NVO
forward
global type n_kor_eng from nonvisualobject
end type
end forward

global type n_kor_eng from nonvisualobject
end type
global n_kor_eng n_kor_eng

type prototypes
function LONG ImmGetContext ( long handle ) LIBRARY "IMM32.DLL"
function LONG ImmSetConversionStatus ( long hIMC, long fFlag, long cFlag ) LIBRARY "IMM32.DLL"
function LONG ImmReleaseContext ( long handle, long hIMC ) LIBRARY "IMM32.DLL"
end prototypes

on n_kor_eng.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_kor_eng.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

