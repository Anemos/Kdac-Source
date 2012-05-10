$PBExportHeader$uo_sle_button.sru
$PBExportComments$코드입력을 위한 user object (sle & button)
forward
global type uo_sle_button from userobject
end type
type code from singlelineedit within uo_sle_button
end type
type code_name from statictext within uo_sle_button
end type
type code_pb from picturebutton within uo_sle_button
end type
end forward

global type uo_sle_button from userobject
integer width = 1701
integer height = 88
long backcolor = 79741120
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event ue_action ( )
event ue_enter ( )
event ue_select ( )
code code
code_name code_name
code_pb code_pb
end type
global uo_sle_button uo_sle_button

type variables
datastore	ids_code
String		is_dataobject, is_where, is_code = ""
Int			ii_row, ii_col
Boolean		ib_retrieve, ok,ib_blank_able
Boolean		ib_toggle
String		is_toggle
Boolean   	ib_empnm_search = False
end variables

forward prototypes
public function boolean find_code (string as_code)
public subroutine set_code (string as_dataobject, string as_where, integer code_length)
end prototypes

event ue_enter;this.triggerevent("ue_action")
end event

event ue_select;this.triggerevent("ue_action")
end event

public function boolean find_code (string as_code);code.text = as_code

// Data 확인용 function call
ii_row = f_get_data(is_dataobject, as_code, is_where, ids_code)
If	ii_row > 0 Then
	code_name.Text = ids_code.GetItemString(ii_row, 2)
	return true
End if
return false

end function

public subroutine set_code (string as_dataobject, string as_where, integer code_length);long	ll_row, ii
string	old_select, new_select
string ls_where

// 처리조건들을 instance변수에 저장
is_dataobject = as_dataobject		// data object 명
is_where = UPPER(as_where)			// where 조건절

// data object 연결
ids_code.DataObject = is_dataobject
ids_code.SetTransObject(sqlcmms);

// 초기화(99.02.07 김지태)
code.text      = ""
code_name.text = ""

// Size 조정
code.width  = code_length * 36.5 + 50
code_pb.x   = code.width + 7
code_name.x = code.width + code_pb.width + 14
code_name.width = this.width - code.width - code_pb.width - 28
code.limit  = code_length
end subroutine

event constructor;string ls_toggle_env

ids_code = create datastore
//사용자설정이 Toggle = No 인경우 return
//ls_toggle_env = ProfileString(gs_ini, "USER", "TOGGLE", " ")
//If Upper(ls_toggle_env) = 'NO' Then
//	ib_toggle = false
//End if


end event

event destructor;destroy	ids_code
end event

on uo_sle_button.create
this.code=create code
this.code_name=create code_name
this.code_pb=create code_pb
this.Control[]={this.code,&
this.code_name,&
this.code_pb}
end on

on uo_sle_button.destroy
destroy(this.code)
destroy(this.code_name)
destroy(this.code_pb)
end on

type code from singlelineedit within uo_sle_button
event ue_keydown pbm_keydown
integer width = 352
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;If key = keyenter! Then
	Parent.TriggerEvent('ue_enter')
END IF

if key = keyf4! then
	code_pb.triggerevent(clicked!)
end if
end event

event getfocus;this.backcolor = rgb(200,255,200)
This.selecttext(1,Len(This.text))
//사용자 설정에 따라 한영자동 변환 여부 결정
//If ib_toggle = false Then return
//	
////설정에 따라 한영변환
//Choose Case Upper(is_toggle)
//	Case 'K'
//		f_toggle_kor(handle(this))
//	Case 'E'
//		f_toggle_eng(handle(this))
//End Choose


end event

event losefocus;this.backcolor = rgb(255,255,255)
end event

event modified;// gf_get_data를 이용하여 확인
// Data 확인용 function call
ii_row = f_get_data(is_dataobject, Trim(This.Text), is_where, ids_code)

// 결과확인
If	ii_row > 0 Then
	ok = True
	is_code = Trim(This.Text)
	code_name.Text = ids_code.GetItemString(ii_row, 2)
ElseIf	ib_blank_able = True and Trim(This.Text) = '' Then
	ok = True
	is_code = ''
	code_name.Text = ''
Else
	ok = False
	SetNull(is_code)
	code_name.Text = ''
	If	IsNull(Parent.Tag) = False and Trim(Parent.Tag) <> '' Then
		MessageBox('확인', Parent.Tag + '코드를 올바르게 입력하십시요!')
	End If
End If

end event

type code_name from statictext within uo_sle_button
integer x = 462
integer y = 12
integer width = 1211
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type code_pb from picturebutton within uo_sle_button
integer x = 357
integer width = 91
integer height = 88
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string picturename = ".\bmp\Ddlb.bmp"
string disabledname = ".\bmp\ddlb_dis.bmp"
end type

event clicked;string	ls_where, get_data[]
boolean	lb_rtn

//if trim(is_where) <> "" and isnull(trim(is_where)) = false then
//	ls_where = ' AND ' + is_where
//else
//	ls_where = ""
//end if

lb_rtn = f_code_search(is_dataobject, is_where, get_data[])
If	lb_rtn = true Then
	If ib_empnm_search = False Then
		code.Text = Trim(get_data[1])
	Else
		code_name.text = Trim(get_data[1])
	End If
	code.triggerevent("modified")
	Parent.TriggerEvent('ue_select')
End If

end event

