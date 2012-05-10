$PBExportHeader$w_pism_resp01.srw
$PBExportComments$√÷ªÛ¿ß Response01
forward
global type w_pism_resp01 from window
end type
end forward

global type w_pism_resp01 from window
integer width = 2533
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event ue_retrieve ( )
event type integer ue_save ( )
end type
global w_pism_resp01 w_pism_resp01

type variables
str_pism_daily istr_mh
end variables

forward prototypes
public subroutine wf_setistrmh (str_pism_daily astr_mh)
end prototypes

public subroutine wf_setistrmh (str_pism_daily astr_mh);
istr_mh = astr_mh

end subroutine

on w_pism_resp01.create
end on

on w_pism_resp01.destroy
end on

event open;f_pisc_win_center_move(This)

str_pism_daily lstr_mh

lstr_mh = message.PowerObjectParm 
If IsValid(lstr_mh) Then wf_setistrmh(lstr_mh)
end event

