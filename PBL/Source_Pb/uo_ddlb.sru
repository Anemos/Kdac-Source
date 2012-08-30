$PBExportHeader$uo_ddlb.sru
$PBExportComments$코드입력을 위한 user object (ddlb)
forward
global type uo_ddlb from dropdownlistbox
end type
end forward

global type uo_ddlb from dropdownlistbox
integer width = 1125
integer height = 600
integer taborder = 1
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 16777215
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
event ue_action ( )
end type
global uo_ddlb uo_ddlb

type variables
datastore	ids_code
string	is_dataobject, is_where
string	is_code


end variables

forward prototypes
public subroutine uf_find_code (string as_name)
public subroutine set_code (string as_dataobject, string as_where)
end prototypes

public subroutine uf_find_code (string as_name);int li_row

For li_row = 1 To ids_code.RowCount()
	If	ids_code.GetItemString(li_row, 2) = as_name Then
		is_code = Trim(ids_code.GetItemString(li_row, 1))
		return
	End If
Next

is_code = ' '
end subroutine

public subroutine set_code (string as_dataobject, string as_where);long	ll_row, ii
string	old_select, new_select

// 처리조건들을 instance변수에 저장
is_dataobject = as_dataobject
is_where = Trim(as_where)

If as_where = "" Then
	is_where = '' 
Else
	is_where = 'WHERE ' + as_where 
End if

// data object 연결
ids_code.DataObject = is_dataobject
ids_code.SetTransObject(sqlcmms);

// 조건문 변경
If	is_where <> "" and IsNull(is_where) = False Then
   old_select = ids_code.GetSQLSelect( )
	new_select = old_select +  is_where
	ids_code.SetSQLSelect(new_select)
End If

// Data Retrieve
ll_row = ids_code.retrieve();
For ii = ll_row To 1 Step -1
	If mid(ids_code.GetItemString(ii,1),1,1) <> '*' Then		// TXA30에서 코드구분명을 제외한다.
		This.InsertItem(ids_code.GetItemString(ii,2),1)
	End If
Next
ids_code.SetSQLSelect(old_select)
// Width 조정
this.width = this.width - 5
end subroutine

event constructor;ids_code = create datastore
end event

event destructor;destroy ids_code
end event

event selectionchanged;uf_find_code(this.text)
end event

on uo_ddlb.create
end on

on uo_ddlb.destroy
end on

