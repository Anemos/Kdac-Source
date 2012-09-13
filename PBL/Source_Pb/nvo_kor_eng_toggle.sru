$PBExportHeader$nvo_kor_eng_toggle.sru
$PBExportComments$한영토글 NVO
forward
global type nvo_kor_eng_toggle from nonvisualobject
end type
end forward

global type nvo_kor_eng_toggle from nonvisualobject
end type
global nvo_kor_eng_toggle nvo_kor_eng_toggle

type prototypes
function LONG ImmGetContext ( long handle ) LIBRARY "IMM32.DLL"
function LONG ImmSetConversionStatus ( long hIMC, long fFlag, long cFlag ) LIBRARY "IMM32.DLL"
function LONG ImmReleaseContext ( long handle, long hIMC ) LIBRARY "IMM32.DLL"
end prototypes

on nvo_kor_eng_toggle.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_kor_eng_toggle.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

