$PBExportHeader$w_pisq612u.srw
$PBExportComments$보상관리대장
forward
global type w_pisq612u from w_ipis_sheet01
end type
type dw_pisq612u_01 from datawindow within w_pisq612u
end type
type dw_pisq612u_04 from datawindow within w_pisq612u
end type
type dw_pisq612u_02 from datawindow within w_pisq612u
end type
type dw_pisq612u_03 from u_vi_std_datawindow within w_pisq612u
end type
end forward

global type w_pisq612u from w_ipis_sheet01
dw_pisq612u_01 dw_pisq612u_01
dw_pisq612u_04 dw_pisq612u_04
dw_pisq612u_02 dw_pisq612u_02
dw_pisq612u_03 dw_pisq612u_03
end type
global w_pisq612u w_pisq612u

on w_pisq612u.create
int iCurrent
call super::create
this.dw_pisq612u_01=create dw_pisq612u_01
this.dw_pisq612u_04=create dw_pisq612u_04
this.dw_pisq612u_02=create dw_pisq612u_02
this.dw_pisq612u_03=create dw_pisq612u_03
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq612u_01
this.Control[iCurrent+2]=this.dw_pisq612u_04
this.Control[iCurrent+3]=this.dw_pisq612u_02
this.Control[iCurrent+4]=this.dw_pisq612u_03
end on

on w_pisq612u.destroy
call super::destroy
destroy(this.dw_pisq612u_01)
destroy(this.dw_pisq612u_04)
destroy(this.dw_pisq612u_02)
destroy(this.dw_pisq612u_03)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisq612u_01.Width = (newwidth * 2 / 5)	+ ls_status
dw_pisq612u_01.Height= (newheight * 1 / 3)

dw_pisq612u_04.x = dw_pisq612u_01.x + dw_pisq612u_01.Width + ls_split
dw_pisq612u_04.y = dw_pisq612u_01.y
dw_pisq612u_04.Width = (newwidth * 3 / 5) - ( ls_status * 2 ) + ls_split
dw_pisq612u_04.Height= (newheight * 2 / 3) - ( ls_status * 2 )

dw_pisq612u_02.x = dw_pisq612u_01.x
dw_pisq612u_02.y = dw_pisq612u_01.y + dw_pisq612u_01.Height + ls_split
dw_pisq612u_02.Width = dw_pisq612u_01.Width
dw_pisq612u_02.Height= (newheight * 1 / 3) - ( ls_status * 2 ) - ls_split

dw_pisq612u_03.x = dw_pisq612u_01.x
dw_pisq612u_03.y = dw_pisq612u_02.y + dw_pisq612u_02.Height + ls_split
dw_pisq612u_03.Width = newwidth - ls_status + ( ls_split * 2 )
dw_pisq612u_03.Height= (newheight * 1 / 3) + ls_status
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
dw_pisq612u_01.settransobject(sqleis)
dw_pisq612u_02.settransobject(sqleis)
dw_pisq612u_03.settransobject(sqleis)
dw_pisq612u_04.settransobject(sqleis)

dw_pisq612u_01.insertrow(0)
dw_pisq612u_01.setitem(1,'customercode','%')
dw_pisq612u_01.setitem(1,'exportgubun','%')
dw_pisq612u_01.setitem(1,'managegubun','%')

// SET CODE DATAWINDOW dw_pisq612u_04
dw_pisq612u_01.GetChild('customercode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq612u_01,'customercode',ldwc,'displayname',10)

dw_pisq612u_01.GetChild('documentno', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq612u_01,'documentno',ldwc,'documentno',10)

dw_pisq612u_04.GetChild('managegubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq612u_04,'managegubun',ldwc,'displayname',5)

dw_pisq612u_04.GetChild('exportgubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS003')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq612u_04,'exportgubun',ldwc,'displayname',5)

dw_pisq612u_04.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_pisq612u_04,'ingstatus',ldwc,'displayname',5)

// SET CODE DATAWINDOW dw_pisq612u_03
dw_pisq612u_03.GetChild('managegubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq612u_03,'managegubun',ldwc,'displayname',5)

dw_pisq612u_03.GetChild('exportgubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS003')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq612u_03,'exportgubun',ldwc,'displayname',5)

dw_pisq612u_03.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_pisq612u_03,'ingstatus',ldwc,'displayname',5)

dw_pisq612u_02.insertrow(0)
dw_pisq612u_04.insertrow(0)
dw_pisq612u_04.setitem( 1, 'docraisedate', mid(g_s_date,1,8))
dw_pisq612u_04.setitem( 1, 'doccheckdate', mid(g_s_date,1,8))
dw_pisq612u_04.setitem( 1, 'raisedate', mid(g_s_date,1,6))
dw_pisq612u_04.setitem( 1, 'accountdate', mid(g_s_date,1,6))
dw_pisq612u_04.setitem( 1, 'objectiondate', mid(g_s_date,1,8))
dw_pisq612u_04.setitem( 1, 'ingstatus', 'A')
end event

event ue_retrieve;call super::ue_retrieve;string ls_customercode, ls_documentno, ls_docraisefrom, ls_docraiseto
string ls_doccheckfrom, ls_doccheckto, ls_exportgubun, ls_managegubun

dw_pisq612u_01.accepttext()
dw_pisq612u_02.reset()
dw_pisq612u_03.reset()
dw_pisq612u_04.reset()

ls_customercode = dw_pisq612u_01.getitemstring(1, 'customercode')
ls_documentno = dw_pisq612u_01.getitemstring(1, 'documentno')
ls_docraisefrom = dw_pisq612u_01.getitemstring(1, 'docraisedate')
ls_docraiseto = dw_pisq612u_01.getitemstring(1, 'docraiseto')
ls_doccheckfrom = dw_pisq612u_01.getitemstring(1, 'doccheckdate')
ls_doccheckto = dw_pisq612u_01.getitemstring(1, 'doccheckto')
ls_exportgubun = dw_pisq612u_01.getitemstring(1, 'exportgubun')
ls_managegubun = dw_pisq612u_01.getitemstring(1, 'managegubun')

//if f_spacechk(ls_customercode) = -1 or ls_customercode = 'ALL' then
//	ls_customercode = '%'
//else
//	ls_customercode = ls_customercode + '%'
//end if

if f_spacechk(ls_documentno) = -1 or ls_documentno = 'ALL' then
	ls_documentno = '%'
else
	ls_documentno = ls_documentno
end if

if f_spacechk(ls_docraisefrom) = -1 then
	ls_docraisefrom = '19000101'
end if

if f_spacechk(ls_docraiseto) = -1 then
	ls_docraiseto = '99990101'
end if

if f_spacechk(ls_doccheckfrom) = -1 then
	ls_doccheckfrom = '19000101'
end if

if f_spacechk(ls_doccheckto) = -1 then
	ls_doccheckto = '99990101'
end if

dw_pisq612u_02.retrieve(ls_managegubun, ls_exportgubun, ls_customercode, ls_documentno, &
	ls_docraisefrom, ls_docraiseto, ls_doccheckfrom, ls_doccheckto)
	
dw_pisq612u_03.retrieve(ls_managegubun, ls_exportgubun, ls_customercode, ls_documentno, &
	ls_docraisefrom, ls_docraiseto, ls_doccheckfrom, ls_doccheckto)





end event

event ue_insert;call super::ue_insert;long ll_selrow, ll_shipamount, ll_payamount, ll_repayamount, ll_paysum, ll_repaysum
string ls_managegubun, ls_exportgubun, ls_documentno, ls_customercode
string ls_docraisedate, ls_doccheckdate, ls_raisedate, ls_accountdate
dec{2} lc_qty
string ls_objectionno, ls_objectiondate, ls_dutyman

ll_selrow = dw_pisq612u_03.getselectedrow(0)
dw_pisq612u_04.reset()
dw_pisq612u_04.insertrow(0)
if ll_selrow > 0 then
	ls_managegubun = dw_pisq612u_03.getitemstring(ll_selrow,'managegubun')
	ls_exportgubun = dw_pisq612u_03.getitemstring(ll_selrow,'exportgubun')
	ls_documentno = dw_pisq612u_03.getitemstring(ll_selrow,'documentno')
	ls_customercode = dw_pisq612u_03.getitemstring(ll_selrow,'customercode')
	ls_docraisedate = dw_pisq612u_03.getitemstring(ll_selrow,'docraisedate')
	ls_doccheckdate = dw_pisq612u_03.getitemstring(ll_selrow,'doccheckdate')
	ls_raisedate = dw_pisq612u_03.getitemstring(ll_selrow,'raisedate')
	ls_accountdate = dw_pisq612u_03.getitemstring(ll_selrow,'accountdate')
	lc_qty = dw_pisq612u_03.getitemnumber(ll_selrow,'qty')
	ll_shipamount = dw_pisq612u_03.getitemnumber(ll_selrow,'shipamount')
	ll_payamount = dw_pisq612u_03.getitemnumber(ll_selrow,'payamount')
	ll_repayamount = dw_pisq612u_03.getitemnumber(ll_selrow,'repayamount')
	ll_paysum = dw_pisq612u_03.getitemnumber(ll_selrow,'paysum')
	ll_repaysum = dw_pisq612u_03.getitemnumber(ll_selrow,'repaysum')
	ls_objectionno = dw_pisq612u_03.getitemstring(ll_selrow,'objectionno')
	ls_objectiondate = dw_pisq612u_03.getitemstring(ll_selrow,'objectiondate')
	
	dw_pisq612u_04.setitem( 1, 'managegubun', ls_managegubun)
	dw_pisq612u_04.setitem( 1, 'exportgubun', ls_exportgubun)
	dw_pisq612u_04.setitem( 1, 'documentno', ls_documentno)
	dw_pisq612u_04.setitem( 1, 'customercode', ls_customercode)
	dw_pisq612u_04.setitem( 1, 'docraisedate', ls_docraisedate)
	dw_pisq612u_04.setitem( 1, 'doccheckdate', ls_doccheckdate)
	dw_pisq612u_04.setitem( 1, 'raisedate', ls_raisedate)
	dw_pisq612u_04.setitem( 1, 'accountdate', ls_accountdate)
	dw_pisq612u_04.setitem( 1, 'qty', lc_qty)
	dw_pisq612u_04.setitem( 1, 'shipamount', ll_shipamount)
	dw_pisq612u_04.setitem( 1, 'payamount', ll_payamount)
	dw_pisq612u_04.setitem( 1, 'repayamount', ll_repayamount)
	dw_pisq612u_04.setitem( 1, 'paysum', ll_paysum)
	dw_pisq612u_04.setitem( 1, 'repaysum', ll_repaysum)
	dw_pisq612u_04.setitem( 1, 'objectionno', ls_objectionno)
	dw_pisq612u_04.setitem( 1, 'objectiondate', ls_objectiondate)
	dw_pisq612u_04.setitem( 1, 'ingstatus', 'A')
else
	dw_pisq612u_04.setitem( 1, 'docraisedate', mid(g_s_date,1,8))
	dw_pisq612u_04.setitem( 1, 'doccheckdate', mid(g_s_date,1,8))
	dw_pisq612u_04.setitem( 1, 'raisedate', mid(g_s_date,1,6))
	dw_pisq612u_04.setitem( 1, 'accountdate', mid(g_s_date,1,6))
	dw_pisq612u_04.setitem( 1, 'objectiondate', mid(g_s_date,1,8))
	dw_pisq612u_04.setitem( 1, 'ingstatus', 'A')
end if
dw_pisq612u_04.setitem( 1, 'dutyman', g_s_empno)
dw_pisq612u_04.setcolumn('managegubun')
dw_pisq612u_04.setfocus()
end event

event ue_save;call super::ue_save;string ls_manageno
integer li_findrow

dw_pisq612u_04.accepttext()

if f_mandantory_chk(dw_pisq612u_04) = -1 then
	uo_status.st_message.text = "필수입력사항이 누락되었습니다."
	return 0
end if
ls_manageno = dw_pisq612u_04.getitemstring(1, 'manageno')
if f_spacechk(ls_manageno) = -1 then
	//신규입력인 경우이므로 관리번호 가져오기
	DECLARE up_pisq_get_manageno PROCEDURE FOR sp_pisq_get_codeserial  
         @ps_codeid = 'BGC'  using sqleis;

	Execute up_pisq_get_manageno;

	if sqleis.sqlcode = 0 then
		fetch up_pisq_get_manageno into :ls_manageno;
		close up_pisq_get_manageno;
	else
		uo_status.st_message.text = "관리번호를 생성할때에 에러가 발생하였습니다."
		return 0
	end if
	dw_pisq612u_04.setitem(1, 'manageno', ls_manageno)
end if
dw_pisq612u_04.setitem(1, 'lastemp', g_s_empno)

sqleis.AutoCommit = False
if dw_pisq612u_04.update() = 1 then
	Commit using sqleis;
	sqleis.AutoCommit = True
	
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_pisq612u_03.find("manageno = '" + ls_manageno + "'", 1, dw_pisq612u_03.rowcount())
	if li_findrow > 0 then
		dw_pisq612u_03.Post Event RowFocusChanged(li_findrow)
		dw_pisq612u_03.scrolltorow(li_findrow)
		dw_pisq612u_03.setrow(li_findrow)
	end if

	uo_status.st_message.text = "저장되었습니다."
	
else
	RollBack using sqleis;
	sqleis.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if
end event

event ue_delete;call super::ue_delete;string ls_manageno, ls_ingstatus, ls_message
integer li_selrow, li_rtn

li_selrow = dw_pisq612u_03.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "선택된 보상관리번호가 없습니다."
	return 0
end if
ls_ingstatus = dw_pisq612u_03.getitemstring(li_selrow,'ingstatus')
if ls_ingstatus <> 'A' then
	uo_status.st_message.text = "진행상태가 청구접수상태가 아닙니다."
	return 0
end if
ls_manageno = dw_pisq612u_03.getitemstring(li_selrow,'manageno')
li_rtn = MessageBox("확인", "보상관리번호 " + ls_manageno + " 를 삭제하시겠습니까?", &
				Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if
dw_pisq612u_04.deleterow(1)

sqleis.AutoCommit = False
// 보상청구데이타 삭제
SELECT COUNT(*) INTO :li_rtn FROM TWCLAIMLIST
	WHERE manclaimno = :ls_manageno using sqleis;
	
if li_rtn > 0 then 
	DELETE FROM TWCLAIMLIST
	WHERE manclaimno = :ls_manageno using sqleis;
	
	if sqleis.sqlcode <> 0 then
		ls_message = "보상청구데이타 삭제 에러"
		goto RollBack_
	end if
end if

if dw_pisq612u_04.update() <> 1 then
	ls_message = "보상관리대장 삭제 에러"
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

MessageBox(ls_message,"삭제시에 오류가 발생하였습니다.")

return 0

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq612u
end type

type dw_pisq612u_01 from datawindow within w_pisq612u
integer x = 32
integer y = 28
integer width = 1595
integer height = 848
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq612u_01"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_pisq612u_04 from datawindow within w_pisq612u
integer x = 1646
integer y = 28
integer width = 1445
integer height = 1360
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq612u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;This.accepttext()
choose case dwo.name
	case 'payamount'
		This.setitem(row,'paysum', This.getitemnumber(row,'shipamount') + This.getitemnumber(row,'payamount'))
	case 'repayamount'
		This.setitem(row,'repaysum', This.getitemnumber(row,'shipamount') + This.getitemnumber(row,'repayamount'))
end choose
end event

type dw_pisq612u_02 from datawindow within w_pisq612u
integer x = 27
integer y = 892
integer width = 1595
integer height = 492
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq612u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq612u_03 from u_vi_std_datawindow within w_pisq612u
integer x = 23
integer y = 1404
integer width = 3063
integer height = 480
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisq612u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_manageno

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
dw_pisq612u_04.reset()
ls_manageno = dw_pisq612u_03.getitemstring(currentrow, 'manageno')

dw_pisq612u_04.retrieve(ls_manageno)





end event

