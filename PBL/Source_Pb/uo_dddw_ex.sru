$PBExportHeader$uo_dddw_ex.sru
$PBExportComments$for  DDDW(eXternal dw)
forward
global type uo_dddw_ex from datawindow
end type
end forward

global type uo_dddw_ex from datawindow
integer width = 471
integer height = 100
integer taborder = 10
string dataobject = "d_dddw_ex"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uo_dddw_ex uo_dddw_ex

type variables
datastore ids_1
string is_edit
end variables

forward prototypes
public subroutine uf_set_dddw (string a_dataobj, string a_arg[10], string a_edit, integer a_percent, string a_insert)
end prototypes

public subroutine uf_set_dddw (string a_dataobj, string a_arg[10], string a_edit, integer a_percent, string a_insert);
// a_dataobj -> dddw dataobject
// a_arg[10] -> dddw Retrieval Arguments
// a_edit    -> dddw Allow Editing Option 'Y' - allow editing, 'N' - no
// a_percent -> dddw Width Percent
// a_insert  -> dddw dummy row insert flag

datawindowchild ldwc_1
int li_row

// Initialize

is_edit = a_edit

THIS.RESET();
THIS.InsertRow(0)
//THIS.GetChild('col', ldwc_1)
//ldwc_1.SetTransObject(sqlcmms)

// Change the dataobject
THIS.object.col.dddw.name = a_dataobj
THIS.GetChild('col', ldwc_1)
ldwc_1.SetTransObject(sqlcmms)
ldwc_1.Retrieve(a_arg[1], a_arg[2], a_arg[3], a_arg[4], a_arg[5], a_arg[6], a_arg[7], a_arg[8], a_arg[9], a_arg[10])

IF a_insert = 'Y' THEN
	li_row = ldwc_1.InsertRow(1)
	ldwc_1.SetItem(li_row, 'code', ' ')
	ldwc_1.SetItem(li_row, 'name', ' ')
END IF

IF a_edit = 'Y' THEN
	THIS.object.col.dddw.AllowEdit = 'Yes'
ELSE
	THIS.object.col.dddw.AllowEdit = 'No'
END IF
	
THIS.object.col.dddw.PercentWidth = a_percent

// Allow Editing 시 코드값의 validation check 용 datastore 생성
IF is_edit = 'Y' THEN
	ids_1 = create datastore
	ids_1.dataobject = a_dataobj
	ids_1.SetTransObject(sqlcmms)
	ids_1.Retrieve(a_arg[1], a_arg[2], a_arg[3], a_arg[4], a_arg[5], a_arg[6], a_arg[7], a_arg[8], a_arg[9], a_arg[10])
	IF a_insert = 'Y' THEN
		li_row = ids_1.InsertRow(1)
		ids_1.SetItem(li_row, 'code', ' ')
		ids_1.SetItem(li_row, 'name', ' ')
	END IF
	
END IF

end subroutine

event itemchanged;
IF is_edit <> 'Y' THEN RETURN

string ls_col, ls_search

ls_col = THIS.object.col.dddw.DataColumn

ls_search = ls_col + " = '" + data + "'" 

IF ids_1.Find(ls_search, 1, ids_1.RowCount()) < 1 THEN
	MessageBox("오류","입력값이 잘못되었습니다.")
	RETURN 1
END IF

end event

event itemerror;
RETURN 1

end event

event destructor;
destroy ids_1

end event

on uo_dddw_ex.create
end on

on uo_dddw_ex.destroy
end on

