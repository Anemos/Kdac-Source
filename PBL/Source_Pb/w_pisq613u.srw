$PBExportHeader$w_pisq613u.srw
$PBExportComments$보상청구/확정관리
forward
global type w_pisq613u from w_ipis_sheet01
end type
type dw_pisq613u_01 from datawindow within w_pisq613u
end type
type dw_pisq613u_02 from u_vi_std_datawindow within w_pisq613u
end type
type dw_pisq613u_03 from datawindow within w_pisq613u
end type
type dw_pisq613u_04 from datawindow within w_pisq613u
end type
end forward

global type w_pisq613u from w_ipis_sheet01
dw_pisq613u_01 dw_pisq613u_01
dw_pisq613u_02 dw_pisq613u_02
dw_pisq613u_03 dw_pisq613u_03
dw_pisq613u_04 dw_pisq613u_04
end type
global w_pisq613u w_pisq613u

type variables
str_pisqwc_parm istr_pisqwc
end variables

on w_pisq613u.create
int iCurrent
call super::create
this.dw_pisq613u_01=create dw_pisq613u_01
this.dw_pisq613u_02=create dw_pisq613u_02
this.dw_pisq613u_03=create dw_pisq613u_03
this.dw_pisq613u_04=create dw_pisq613u_04
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq613u_01
this.Control[iCurrent+2]=this.dw_pisq613u_02
this.Control[iCurrent+3]=this.dw_pisq613u_03
this.Control[iCurrent+4]=this.dw_pisq613u_04
end on

on w_pisq613u.destroy
call super::destroy
destroy(this.dw_pisq613u_01)
destroy(this.dw_pisq613u_02)
destroy(this.dw_pisq613u_03)
destroy(this.dw_pisq613u_04)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisq613u_01.Width = (newwidth * 2 / 5)	+ ls_status
dw_pisq613u_01.Height= (newheight * 1 / 3) - ls_status

dw_pisq613u_04.x = dw_pisq613u_01.x + dw_pisq613u_01.Width + ls_split
dw_pisq613u_04.y = dw_pisq613u_01.y
dw_pisq613u_04.Width = (newwidth * 3 / 5) - ( ls_status * 2 ) + ls_split
dw_pisq613u_04.Height= dw_pisq613u_01.Height

dw_pisq613u_02.x = dw_pisq613u_01.x
dw_pisq613u_02.y = dw_pisq613u_01.y + dw_pisq613u_01.Height + ls_split
dw_pisq613u_02.Width = newwidth - ls_status + ( ls_split * 2 )
dw_pisq613u_02.Height= (newheight * 1 / 3) - ( ls_status * 2 ) - ls_split

dw_pisq613u_03.x = dw_pisq613u_01.x
dw_pisq613u_03.y = dw_pisq613u_02.y + dw_pisq613u_02.Height + ls_split
dw_pisq613u_03.Width = newwidth - ls_status + ( ls_split * 2 )
dw_pisq613u_03.Height= (newheight * 1 / 3) + ( ls_status * 2 )
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_pisq613u_01.settransobject(sqleis)
dw_pisq613u_02.settransobject(sqleis)
dw_pisq613u_03.settransobject(sqleis)
dw_pisq613u_04.settransobject(sqleis)

//dw_pisq613u_01.GetChild('customername', ldwc)
//ldwc.settransobject(sqleis)
//ldwc.retrieve()
//if ldwc.RowCount() < 1 then
//	ldwc.InsertRow(0)
//end if
//f_pisc_set_dddw_width(dw_pisq613u_01,'customername',ldwc,'custname',5)
//
dw_pisq613u_01.insertrow(0)
dw_pisq613u_01.setitem(1,'customercode','%')
dw_pisq613u_01.setitem(1,'exportgubun','%')
dw_pisq613u_01.setitem(1,'managegubun','%')

// SET CODE DATAWINDOW dw_pisq612u_04
dw_pisq613u_01.GetChild('customercode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq613u_01,'customercode',ldwc,'displayname',10)

dw_pisq613u_01.GetChild('documentno', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq613u_01,'documentno',ldwc,'documentno',10)

dw_pisq613u_02.GetChild('managegubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq613u_02,'managegubun',ldwc,'codename',5)

dw_pisq613u_02.GetChild('exportgubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS003')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq613u_02,'exportgubun',ldwc,'codename',5)

dw_pisq613u_02.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_pisq613u_02,'ingstatus',ldwc,'codename',5)

dw_pisq613u_04.insertrow(0)
end event

event ue_retrieve;call super::ue_retrieve;string ls_customercode, ls_documentno, ls_docraisefrom, ls_docraiseto
string ls_doccheckfrom, ls_doccheckto, ls_exportgubun, ls_managegubun

dw_pisq613u_01.accepttext()
dw_pisq613u_02.reset()
dw_pisq613u_03.reset()
dw_pisq613u_04.reset()

ls_customercode = dw_pisq613u_01.getitemstring(1, 'customercode')
ls_documentno = dw_pisq613u_01.getitemstring(1, 'documentno')
ls_docraisefrom = dw_pisq613u_01.getitemstring(1, 'docraisedate')
ls_docraiseto = dw_pisq613u_01.getitemstring(1, 'docraiseto')
ls_doccheckfrom = dw_pisq613u_01.getitemstring(1, 'doccheckdate')
ls_doccheckto = dw_pisq613u_01.getitemstring(1, 'doccheckto')
ls_exportgubun = dw_pisq613u_01.getitemstring(1, 'exportgubun')
ls_managegubun = dw_pisq613u_01.getitemstring(1, 'managegubun')

if f_spacechk(ls_documentno) = -1 or ls_documentno = 'ALL' then
	ls_documentno = '%'
else
	ls_documentno = ls_documentno + '%'
end if

if f_spacechk(ls_docraisefrom) = -1 then
	ls_docraisefrom = '1900.01.01'
end if

if f_spacechk(ls_docraiseto) = -1 then
	ls_docraiseto = '9999.01.01'
end if

if f_spacechk(ls_doccheckfrom) = -1 then
	ls_doccheckfrom = '1900.01.01'
end if

if f_spacechk(ls_doccheckto) = -1 then
	ls_doccheckto = '9999.01.01'
end if

dw_pisq613u_02.retrieve(ls_managegubun, ls_exportgubun, ls_customercode, ls_documentno, &
	ls_docraisefrom, ls_docraiseto, ls_doccheckfrom, ls_doccheckto)
	
//dw_pisq613u_03.retrieve(ls_managegubun, ls_exportgubun, ls_customercode, ls_documentno, &
//	ls_docraisefrom, ls_docraiseto, ls_doccheckfrom, ls_doccheckto)
end event

event ue_save;call super::ue_save;string ls_manageno, ls_ingstatus, ls_message
integer li_selrow

li_selrow = dw_pisq613u_02.getselectedrow(0)
if li_selrow < 1 then
	return 0
end if

ls_ingstatus = dw_pisq613u_02.getitemstring(li_selrow,"ingstatus")
if ls_ingstatus <> 'A' then
	uo_status.st_message.text = "청구접수상태인 보상관리번호에 대해서 수정가능합니다."
	return 0
end if

sqleis.AutoCommit = False

if dw_pisq613u_03.update() <> 1 then
	ls_message = "보상청구데이타 수정오류"
	goto RollBack_
end if

Commit using sqleis;
sqleis.Autocommit = True

iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

RollBack_:
Rollback using sqleis;
sqleis.AutoCommit = True

MessageBox(ls_message,"저장시에 오류가 발생하였습니다.")

return 0

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq613u
end type

type dw_pisq613u_01 from datawindow within w_pisq613u
integer x = 32
integer y = 28
integer width = 1595
integer height = 848
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq612u_01"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_pisq613u_02 from u_vi_std_datawindow within w_pisq613u
integer x = 32
integer y = 896
integer width = 3063
integer height = 448
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisq612u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_pisqwc NewMenu
string ls_name, ls_data, ls_type, ls_col_type, ls_ingstatus, ls_manageno, ls_exportgubun
string ls_customercode, ls_managegubun
str_pisqwc_parm lstr_parm

ls_type = dwo.type
If ls_type = 'column' Then
	ls_name = dwo.name
	ls_col_type = this.Describe(ls_name+".ColType")
	If pos(ls_col_type,'char',1) > 0 Then
		ls_data = dwo.Primary[row]
	Else
		ls_data = ''
	End if
End if

If row > 0 Then
	this.SelectRow(0,False)
	this.SelectRow(row, True)
	this.setfocus()
Else
	return 0
End if

ls_ingstatus = This.getitemstring( row, 'ingstatus' ) 
ls_manageno = This.getitemstring( row, 'manageno' )
ls_customercode = This.getitemstring( row, 'customercode')
ls_exportgubun = This.getitemstring( row, 'exportgubun')
ls_managegubun = This.getitemstring( row, 'managegubun')

// 마우스 클릭 위치계산
if iw_This.PointerX() >= ( iw_This.Width / 2 ) then
	lstr_parm.l_parm[1] = iw_This.PointerX() - 1961
	lstr_parm.l_parm[2] = iw_This.PointerY() + 350
else
	lstr_parm.l_parm[1] = iw_This.PointerX() + 10
	lstr_parm.l_parm[2] = iw_This.PointerY() + 350
end if
// 계산 끝
lstr_parm.s_parm[1] 	= ls_manageno
lstr_parm.s_parm[2]  = ls_customercode
lstr_parm.s_parm[3]	= ls_exportgubun
lstr_parm.w_parm		= iw_this
lstr_parm.dw_parm[1] = this
lstr_parm.dw_parm[2] = dw_pisq613u_03
Message.PowerObjectParm = lstr_parm

NewMenu = CREATE m_pop_pisqwc

if ls_ingstatus = 'A' then			// 청구접수상태
	NewMenu.m_action.m_claimupload.enabled = True
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = True
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = False
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = False
elseif ls_ingstatus = 'B' then 	//이의제기상태
	NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = True
	NewMenu.m_action.m_confirmobjection.enabled = True
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = False
elseif ls_ingstatus = 'C' then	//이의확정상태
	NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = True
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = False
elseif ls_ingstatus = 'D' then	//청구확정상태
	NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = True
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = True
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = False
elseif ls_managegubun = 'C' then
	NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = True
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = False
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = False
else
	NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = False
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = False
end if

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_manageno, ls_managegubun
datawindowchild ldwc

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

ls_manageno = dw_pisq613u_02.getitemstring(currentrow, 'manageno')
ls_managegubun = dw_pisq613u_02.getitemstring(currentrow, 'managegubun')

dw_pisq613u_01.setitem(1,"documentno",ls_manageno)

if ls_managegubun = 'C' then
	dw_pisq613u_03.dataobject = 'd_pisq613u_03_02'
	dw_pisq613u_03.settransobject(sqleis)
else
	dw_pisq613u_03.dataobject = 'd_pisq613u_03_01'
	dw_pisq613u_03.settransobject(sqleis)
	
	dw_pisq613u_03.GetChild('status', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve('WCS005')
	if ldwc.RowCount() < 1 then
		ldwc.InsertRow(0)
	end if
	f_pisc_set_dddw_width(dw_pisq613u_03,'status',ldwc,'codename',5)
	
	dw_pisq613u_03.GetChild('qaanalyzecontent', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve('WCS008')
	f_pisc_set_dddw_width(dw_pisq613u_03,'qaanalyzecontent',ldwc,'codename',10)
	
	dw_pisq613u_03.GetChild('qcanalyzecontent', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve('WCS008')
	f_pisc_set_dddw_width(dw_pisq613u_03,'qcanalyzecontent',ldwc,'codename',10)
end if

dw_pisq613u_03.retrieve(ls_manageno)
dw_pisq613u_04.retrieve(ls_manageno)
end event

type dw_pisq613u_03 from datawindow within w_pisq613u
integer x = 32
integer y = 1368
integer width = 3063
integer height = 448
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq613u_03_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;//////////////////////////////////////////////////////////
//// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
//////////////////////////////////////////////////////////
//
//m_pop_pisqwc NewMenu
//string ls_name, ls_data, ls_type, ls_col_type, ls_ingstatus
//
//ls_type = dwo.type
//If ls_type = 'column' Then
//	ls_name = dwo.name
//	ls_col_type = this.Describe(ls_name+".ColType")
//	If pos(ls_col_type,'char',1) > 0 Then
//		ls_data = dwo.Primary[row]
//	Else
//		ls_data = ''
//	End if
//End if
//
//If row > 0 Then
//	this.SelectRow(0,False)
//	this.SelectRow(row, True)
//	this.setfocus()
//Else
//	return 0
//End if
//
//ls_ingstatus = This.getitemstring( row, 'ingstatus' ) 
//
//NewMenu = CREATE m_pop_pisqwc
////NewMenu.mf_get_dw(this, row, ls_name, ls_data)
////Popup Menu 조정
//
////if ls_ingstatus = 'A' then
////	NewMenu.m_action.m_claimupload.enabled = True
////	NewMenu.m_action.m_confirmupload.enabled = False
////elseif ls_ingstatus = 'D' then
////	NewMenu.m_action.m_claimupload.enabled = False
////	NewMenu.m_action.m_confirmupload.enabled = True
////else
//	NewMenu.m_action.m_claimupload.enabled = False
//	NewMenu.m_action.m_confirmupload.enabled = False
//	NewMenu.m_action.m_applyobjection.enabled = True
//	NewMenu.m_action.m_cancelobjection.enabled = True
//	NewMenu.m_action.m_confirmobjection.enabled = True
////end if
//
//NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())
//
//destroy NewMenu
end event

type dw_pisq613u_04 from datawindow within w_pisq613u
integer x = 1650
integer y = 28
integer width = 1440
integer height = 844
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq613u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

