$PBExportHeader$uo_sle_ddlb.sru
$PBExportComments$코드입력을 위한 user object (sle & ddlb)
forward
global type uo_sle_ddlb from userobject
end type
type code_name from dropdownlistbox within uo_sle_ddlb
end type
type code from singlelineedit within uo_sle_ddlb
end type
end forward

global type uo_sle_ddlb from userobject
integer width = 992
integer height = 88
long backcolor = 79741120
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event ue_action ( )
event ue_enter ( )
event ue_selectionchanged ( )
code_name code_name
code code
end type
global uo_sle_ddlb uo_sle_ddlb

type variables
datastore	ids_code
string	is_dataobject, is_where, is_code = ""
int	ii_row
boolean	ok, ib_blank_able = true
boolean	ib_toggle
string	is_toggle

end variables

forward prototypes
public function integer reset_item ()
public function boolean find_code (string as_code)
public subroutine set_code (string as_dataobject, string as_where, integer code_length)
end prototypes

event ue_enter;this.triggerevent("ue_action")
end event

event ue_selectionchanged;this.triggerevent("ue_action")
end event

public function integer reset_item ();int ii,li_item

this.ids_code.reset()
is_code = ''
code.text = ''
code_name.Clear()
li_item = code_name.TotalItems()
For ii = li_item To 1 Step -1 
	code_name.deleteitem(ii)
Next
return 1

end function

public function boolean find_code (string as_code);//code값 및 명 setting

code.text = as_code

For ii_row = 1 To ids_code.RowCount()
	If	Trim(ids_code.GetItemString(ii_row, 1)) = trim(as_code) Then
		code_name.Text = ids_code.GetItemString(ii_row, 2)
		return true
	End If
Next
return false

end function

public subroutine set_code (string as_dataobject, string as_where, integer code_length);long	ll_row, ii
string	old_select, new_select

// data object 연결
is_dataobject = as_dataobject

ids_code.DataObject = is_dataobject
ids_code.SetTransObject(sqlcmms);


// 처리조건들을 instance변수에 저장
old_select = ids_code.GetSQLSelect( )

If as_where = "" Then
	is_where = '' 
ElseIf pos(upper(old_select), 'WHERE') <= 0 then
	is_where = ' WHERE ' + as_where 
ElseIf pos(upper(old_select), 'WHERE') > 0 then
	is_where = ' AND ' + as_where 
End if

reset_item();

// 조건문 변경
If	is_where <> "" and IsNull(is_where) = False Then
	new_select = old_select +  is_where
	ids_code.SetSQLSelect(new_select)
End If

// Data Retrieve
ll_row = ids_code.retrieve();
For ii = ll_row To 1 Step -1
	If mid(ids_code.GetItemString(ii,1),1,1) <> '*' Then		// TXA30에서 코드구분명을 제외한다.
		code_name.InsertItem(ids_code.GetItemString(ii,2),1)
	End If
Next
ids_code.SetSQLSelect(old_select)

// Size 조정
code.width = code_length * 36.5 + 70
code_name.x = code.width + 7
code_name.width = this.width - code.width - 13
code.limit = code_length
end subroutine

event constructor;string ls_toggle_env,ls_path
ids_code = create datastore

////사용자설정이 Toggle = No 인경우 Return
//ls_toggle_env = ProfileString(gs_ini, "USER", "TOGGLE", " ")
//If Upper(ls_toggle_env) = 'NO' Then
//	ib_toggle = false
//End if

end event

event destructor;destroy	ids_code
end event

on uo_sle_ddlb.create
this.code_name=create code_name
this.code=create code
this.Control[]={this.code_name,&
this.code}
end on

on uo_sle_ddlb.destroy
destroy(this.code_name)
destroy(this.code)
end on

type code_name from dropdownlistbox within uo_sle_ddlb
integer x = 224
integer width = 763
integer height = 644
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 79741120
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//
// Data Store를 뒤져가면서 확인
//
For ii_row = 1 To ids_code.RowCount()
	If	ids_code.GetItemString(ii_row, 2) = This.Text Then
		ok = True
		is_code = Trim(ids_code.GetItemString(ii_row, 1))
		code.Text = Trim(ids_code.GetItemString(ii_row, 1))
		Parent.TriggerEvent('ue_selectionchanged')
		Return
	End If
Next
end event

type code from singlelineedit within uo_sle_ddlb
event ue_keydown pbm_keydown
integer width = 215
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;If key = keyenter! Then
	
	IF ib_blank_able	Then
		OK = TRUE
	End If
	
	IF ok	Then
		Parent.TriggerEvent('ue_enter')
	End If
	
	
END IF
end event

event getfocus;this.backcolor = rgb(200,255,200)
This.selecttext(1,Len(This.text))

////사용자 설정에 따라 한영자동 변환 여부 결정
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

event modified;//
// Data Store를 뒤져가면서 확인
//
For ii_row = 1 To ids_code.RowCount()
	If	Trim(ids_code.GetItemString(ii_row, 1)) = Trim(This.Text) Then
		ok = True
		is_code = Trim(This.Text)
		//code_name.Text = ids_code.GetItemString(ii_row, 2)
		code_name.SelectItem(ii_row)
		Parent.TriggerEvent('ue_action')
		Return
	End If
Next

//
// code에 아무것도 입력하지 않은 경우
//
If	ib_blank_able and Trim(this.text) = '' Then
	ok = True
	is_code = ''
	code_name.allowedit = True
	code_name.text = ''
	code_name.allowedit = False
	Return
End if
	
//
// 잘못된 code 입력
//
// 입력오류
ok = False
SetNull(is_code)
code_name.AllowEdit = True
code_name.Text = ""
code_name.AllowEdit = False
If	IsNull(Parent.Tag) = False and Trim(Parent.Tag) <> '' Then
	MessageBox('확인', Parent.Tag + '코드를 올바르게 입력하십시요!')
	code.setfocus()
End If


end event

event losefocus;this.backcolor = rgb(255,255,255)

end event

