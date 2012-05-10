$PBExportHeader$w_comm108u.srw
$PBExportComments$COMMIT/ROLLBACK TEST
forward
global type w_comm108u from w_origin_sheet01
end type
type dw_1 from datawindow within w_comm108u
end type
type dw_2 from datawindow within w_comm108u
end type
end forward

global type w_comm108u from w_origin_sheet01
integer height = 2692
dw_1 dw_1
dw_2 dw_2
end type
global w_comm108u w_comm108u

on w_comm108u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_comm108u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;call super::open;i_b_save       = true
i_b_delete     = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)

dw_1.retrieve()
end event

event ue_save;call super::ue_save;integer ln_row 
string ls_errtext
long  ls_dbcode
//sqlca.autocommit = false
IF DW_1.UPDATE() <> 1 THEN
	ROLLBACK USING SQLCA ;
	IF SQLCA.SQLCODE <> 0 THEN 
		ls_dbcode = SQLCA.SQLDBCODE
		ls_errtext = SQLCA.SQLERRTEXT
		ln_row = DW_2.INSERTROW(0)
		DW_2.OBJECT.gubun[ln_row] = "ROLLBACK Error"
		DW_2.OBJECT.SQLERRORCODE[ln_row] = ls_dbcode
		DW_2.OBJECT.SQLERRORTEXT[ln_row] = ls_errtext
	END IF
//	sqlca.autocommit = true
   messagebox("A","A")
	RETURN
else
	commit USING SQLCA ;
	IF SQLCA.SQLCODE <> 0 THEN 
		ls_dbcode = SQLCA.SQLDBCODE
	   ls_errtext = SQLCA.SQLERRTEXT
		ln_row = DW_2.INSERTROW(0)
		DW_2.OBJECT.gubun[ln_row] = "COMMIT Error"
		DW_2.OBJECT.SQLERRORCODE[ln_row] = ls_dbcode
		DW_2.OBJECT.SQLERRORTEXT[ln_row] = ls_errtext
	//	sqlca.autocommit = true
		messagebox("B","B")
		RETURN
	END IF
END IF
//sqlca.autocommit = true
dw_2.reset()
messagebox("확인","저장완료" + string(sqlca.autocommit))
dw_1.retrieve()

end event

event ue_retrieve;call super::ue_retrieve;dw_1.reset()
dw_2.reset()
dw_1.retrieve()
end event

event ue_insert;call super::ue_insert;DW_1.INSERTROW(0)
end event

type uo_status from w_origin_sheet01`uo_status within w_comm108u
integer y = 2468
end type

type dw_1 from datawindow within w_comm108u
integer x = 23
integer y = 36
integer width = 3648
integer height = 1308
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm108u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;THIS.SETTRANSOBJECT(SQLCA)
end event

event dberror;string ls_errtext
long ls_dbcode,ln_row

ls_dbcode = SQLDBCODE
ls_errtext = SQLERRTEXT
ln_row =  DW_2.INSERTROW(0)
DW_2.OBJECT.gubun[ln_row] = "DW Update Error"
DW_2.OBJECT.SQLERRORCODE[ln_row] = ls_dbcode
DW_2.OBJECT.SQLERRORTEXT[ln_row] = ls_errtext
RETURN 1
end event

type dw_2 from datawindow within w_comm108u
integer x = 23
integer y = 1364
integer width = 4585
integer height = 1072
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm108u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

