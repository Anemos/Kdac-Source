$PBExportHeader$uo_dw_free.sru
$PBExportComments$Free form datawindow의 표준 object
forward
global type uo_dw_free from datawindow
end type
end forward

global type uo_dw_free from datawindow
integer width = 494
integer height = 360
integer taborder = 1
borderstyle borderstyle = stylelowered!
event ue_rbuttondown pbm_rbuttondown
event ue_key pbm_dwnkey
event ue_enter pbm_dwnprocessenter
end type
global uo_dw_free uo_dw_free

type variables
boolean	ib_enter = True		// Enter칠때 한컬럼 넘어가기
boolean	ib_toggle = true		//한영자동전환
boolean	ib_date			//날짜window
string is_old_col                                      //column 명

end variables

event ue_enter;//
// Enter를 누른경우 Tab을 누른것과 같은 효과를 제공한다.
//
If	ib_enter	Then
	Send(Handle(This),256,9,Long(0,0))
	return 1
End If
end event

event itemfocuschanged;string ls_new_col,ls_new_mod,ls_old_mod,ls_mod,ls_tag,ls_div
int li_pos

//현재 Focus가 있는 컬럼명
ls_new_col = dwo.name

//사용자 환경에 따라 자동 한영변환 기능 설정
If ib_toggle = false Then return

ls_new_col = dwo.name
//현재 Column의 Tag
ls_mod = ls_new_col + ".Tag"
ls_tag = this.Describe(ls_mod)
//구분자 뒤의 토글 옵션을 체크
li_pos = pos(ls_tag,"/")
ls_div = mid(ls_tag,li_pos + 1,1)
//옵션에 따라 한영전환 처리
//Choose Case Upper(ls_div)
//	Case 'K'
//		f_toggle_kor(handle(this))
//	Case 'E'
//		f_toggle_eng(handle(this))
//End Choose
end event

event constructor;string ls_toggle_env

This.SetTransObject(sqlcmms)

////사용자설정이 Toggle = No 인경우 return
//ls_toggle_env = ProfileString(gs_ini,"USER","TOGGLE", " ")
//If Upper(ls_toggle_env) = 'NO' Then
//	ib_toggle = false
//End if

end event

event itemerror;return 1
end event

on uo_dw_free.create
end on

on uo_dw_free.destroy
end on

event dberror;//f_show_dberror(sqldbcode)
//
//return 1
end event

