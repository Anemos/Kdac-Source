$PBExportHeader$w_comm109u.srw
$PBExportComments$COMMIT/ROLLBACK TEST ( Not DW )
forward
global type w_comm109u from w_origin_sheet01
end type
type dw_1 from datawindow within w_comm109u
end type
type dw_2 from datawindow within w_comm109u
end type
type dw_3 from datawindow within w_comm109u
end type
end forward

global type w_comm109u from w_origin_sheet01
integer height = 2692
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_comm109u w_comm109u

on w_comm109u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
end on

on w_comm109u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;i_b_save       = true
i_b_delete     = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)

dw_1.insertrow(0)

end event

event ue_save;call super::ue_save;integer ln_count,ln_row
string ls_errtext,ls_serverid,ls_servername,ls_serverdbms,ls_serverdatabase,&
       ls_serverlogid,ls_serverpassword,ls_serverdbparm,ls_serverautocommit,ls_servergubun,ls_lastemp,ls_lastdate
long  ls_dbcode
dw_1.accepttext()
ls_serverid = TRIM(dw_1.object.serverid[1])
ls_servername = TRIM(dw_1.object.servername[1])
ls_serverdbms = dw_1.object.serverdbms[1]
ls_serverdatabase = dw_1.object.serverdatabase[1]
ls_serverlogid = dw_1.object.serverlogid[1]
ls_serverpassword = dw_1.object.serverpassword[1]
ls_serverdbparm = dw_1.object.serverdbparm[1]
ls_serverautocommit = dw_1.object.serverautocommit[1]
ls_servergubun = dw_1.object.servergubun[1]
ls_lastemp = dw_1.object.lastemp[1]
ls_lastdate = dw_1.object.lastdate[1]

select count(*) into :ln_count from commtstold
where serverid = :ls_serverid and servername = :ls_servername
using sqlca ;

//sqlca.autocommit = false
if ln_count = 0 then
	insert into commtstold 
	values ( :ls_serverid,:ls_servername,:ls_serverdbms,:ls_serverdatabase,:ls_serverlogid,:ls_serverpassword,
				:ls_serverdbparm,:ls_serverautocommit,:ls_servergubun,:ls_lastemp,:ls_lastdate )
   using sqlca ;
else
	update commtstold
	set serverdbms = :ls_serverdbms,serverdatabase = :ls_serverdatabase,serverlogid = :ls_serverlogid,serverpassword = :ls_serverpassword,
		 serverdbparm = :ls_serverdbparm,serverautocommit = :ls_serverautocommit,servergubun = :ls_servergubun,lastemp = :ls_lastemp,lastdate = :ls_lastdate
   where serverid = :ls_serverid and servername = :ls_servername
	using sqlca ;
end if

IF sqlca.sqlcode <> 0 theN
	ls_dbcode = sqlca.SQLDBCODE
	ls_errtext = sqlca.SQLERRTEXT
	ln_row =  DW_2.INSERTROW(0)
	DW_2.OBJECT.gubun[ln_row] = "Insert/Update Error"
	DW_2.OBJECT.SQLERRORCODE[ln_row] = ls_dbcode
	DW_2.OBJECT.SQLERRORTEXT[ln_row] = ls_errtext
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
//		sqlca.autocommit = true
		messagebox("B","B")
		RETURN
	END IF
END IF
//sqlca.autocommit = true
dw_2.reset()
messagebox("확인","저장완료" + string(sqlca.autocommit))
dw_3.retrieve()

end event

event ue_insert;call super::ue_insert;DW_1.INSERTROW(0)
end event

type uo_status from w_origin_sheet01`uo_status within w_comm109u
integer y = 2468
end type

type dw_1 from datawindow within w_comm109u
integer x = 2144
integer y = 28
integer width = 2459
integer height = 1308
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm108u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;THIS.SETTRANSOBJECT(SQLCA)
end event

event dberror;//string ls_errtext
//long ls_dbcode,ln_row
//
//ls_dbcode = SQLDBCODE
//ls_errtext = SQLERRTEXT
//ln_row =  DW_2.INSERTROW(0)
//DW_2.OBJECT.gubun[ln_row] = "Insert/Update Error"
//DW_2.OBJECT.SQLERRORCODE[ln_row] = ls_dbcode
//DW_2.OBJECT.SQLERRORTEXT[ln_row] = ls_errtext
//RETURN 1
end event

type dw_2 from datawindow within w_comm109u
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

type dw_3 from datawindow within w_comm109u
integer x = 32
integer y = 28
integer width = 2089
integer height = 1304
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm108u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

