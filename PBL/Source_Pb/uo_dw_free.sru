$PBExportHeader$uo_dw_free.sru
$PBExportComments$Free form datawindow�� ǥ�� object
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
boolean	ib_enter = True		// Enterĥ�� ���÷� �Ѿ��
boolean	ib_toggle = true		//�ѿ��ڵ���ȯ
boolean	ib_date			//��¥window
string is_old_col                                      //column ��

end variables

event ue_enter;//
// Enter�� ������� Tab�� �����Ͱ� ���� ȿ���� �����Ѵ�.
//
If	ib_enter	Then
	Send(Handle(This),256,9,Long(0,0))
	return 1
End If
end event

event itemfocuschanged;string ls_new_col,ls_new_mod,ls_old_mod,ls_mod,ls_tag,ls_div
int li_pos

//���� Focus�� �ִ� �÷���
ls_new_col = dwo.name

//����� ȯ�濡 ���� �ڵ� �ѿ���ȯ ��� ����
If ib_toggle = false Then return

ls_new_col = dwo.name
//���� Column�� Tag
ls_mod = ls_new_col + ".Tag"
ls_tag = this.Describe(ls_mod)
//������ ���� ��� �ɼ��� üũ
li_pos = pos(ls_tag,"/")
ls_div = mid(ls_tag,li_pos + 1,1)
//�ɼǿ� ���� �ѿ���ȯ ó��
//Choose Case Upper(ls_div)
//	Case 'K'
//		f_toggle_kor(handle(this))
//	Case 'E'
//		f_toggle_eng(handle(this))
//End Choose
end event

event constructor;string ls_toggle_env

This.SetTransObject(sqlcmms)

////����ڼ����� Toggle = No �ΰ�� return
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

