$PBExportHeader$w_pisq710u.srw
$PBExportComments$이의제기 관리
forward
global type w_pisq710u from w_ipis_sheet01
end type
type dw_pisq710u_01 from datawindow within w_pisq710u
end type
type dw_pisq710u_02 from u_vi_std_datawindow within w_pisq710u
end type
type dw_pisq710u_04 from datawindow within w_pisq710u
end type
type uo_area from u_pisc_select_area within w_pisq710u
end type
type uo_division from u_pisc_select_division within w_pisq710u
end type
type st_vsplitbar from uo_xc_splitbar within w_pisq710u
end type
type pb_down from picturebutton within w_pisq710u
end type
type cb_upload from commandbutton within w_pisq710u
end type
type gb_1 from groupbox within w_pisq710u
end type
type dw_pisq710u_03 from u_vi_std_datawindow within w_pisq710u
end type
end forward

global type w_pisq710u from w_ipis_sheet01
dw_pisq710u_01 dw_pisq710u_01
dw_pisq710u_02 dw_pisq710u_02
dw_pisq710u_04 dw_pisq710u_04
uo_area uo_area
uo_division uo_division
st_vsplitbar st_vsplitbar
pb_down pb_down
cb_upload cb_upload
gb_1 gb_1
dw_pisq710u_03 dw_pisq710u_03
end type
global w_pisq710u w_pisq710u

on w_pisq710u.create
int iCurrent
call super::create
this.dw_pisq710u_01=create dw_pisq710u_01
this.dw_pisq710u_02=create dw_pisq710u_02
this.dw_pisq710u_04=create dw_pisq710u_04
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_vsplitbar=create st_vsplitbar
this.pb_down=create pb_down
this.cb_upload=create cb_upload
this.gb_1=create gb_1
this.dw_pisq710u_03=create dw_pisq710u_03
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq710u_01
this.Control[iCurrent+2]=this.dw_pisq710u_02
this.Control[iCurrent+3]=this.dw_pisq710u_04
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_vsplitbar
this.Control[iCurrent+7]=this.pb_down
this.Control[iCurrent+8]=this.cb_upload
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_pisq710u_03
end on

on w_pisq710u.destroy
call super::destroy
destroy(this.dw_pisq710u_01)
destroy(this.dw_pisq710u_02)
destroy(this.dw_pisq710u_04)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_vsplitbar)
destroy(this.pb_down)
destroy(this.cb_upload)
destroy(this.gb_1)
destroy(this.dw_pisq710u_03)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisq710u_01.Width = (newwidth * 2 / 5)	+ ls_status
dw_pisq710u_01.Height= (newheight * 1 / 3) - ls_status

dw_pisq710u_04.x = dw_pisq710u_01.x + dw_pisq710u_01.Width + ls_split
dw_pisq710u_04.y = dw_pisq710u_01.y
dw_pisq710u_04.Width = (newwidth * 3 / 5) - ( ls_status * 2 ) + ls_split
dw_pisq710u_04.Height= dw_pisq710u_01.Height

dw_pisq710u_02.x = dw_pisq710u_01.x
dw_pisq710u_02.y = dw_pisq710u_01.y + dw_pisq710u_01.Height + ls_split
dw_pisq710u_02.Width = (newwidth / 4) - ( ls_status * 3 )
dw_pisq710u_02.Height= (newheight * 2 / 3) - ( ls_status * 2 ) + 40

dw_pisq710u_03.x = dw_pisq710u_02.x + dw_pisq710u_02.Width + ls_split
dw_pisq710u_03.y = dw_pisq710u_02.y
dw_pisq710u_03.Width = (newwidth * 3 / 4) + ( ls_status * 2 ) + ls_split
dw_pisq710u_03.Height= dw_pisq710u_02.Height

st_vsplitbar.x 		= dw_pisq710u_02.x + dw_pisq710u_02.width
st_vsplitbar.y 		= dw_pisq710u_02.y
st_vsplitbar.Height 	= dw_pisq710u_02.Height
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_pisq710u_01.settransobject(sqleis)
dw_pisq710u_02.settransobject(sqleis)
dw_pisq710u_03.settransobject(sqleis)
dw_pisq710u_04.settransobject(sqleis)

dw_pisq710u_01.insertrow(0)
dw_pisq710u_01.setitem(1,'customercode','%')
dw_pisq710u_01.setitem(1,'objectionno','%')
dw_pisq710u_01.setitem(1,'exportgubun','%')
dw_pisq710u_01.setitem(1,'ingstatus','%')

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										TRUE, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
// SET CODE DATAWINDOW dw_pisq612u_04
dw_pisq710u_01.GetChild('customercode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq710u_01,'customercode',ldwc,'displayname',10)

dw_pisq710u_01.GetChild('objectionno', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq710u_01,'objectionno',ldwc,'objectionno',10)

dw_pisq710u_04.GetChild('areacode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','%')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq710u_04,'areacode',ldwc,'areaname',5)

dw_pisq710u_04.GetChild('divisioncode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','%','%')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_pisq710u_04,'divisioncode',ldwc,'divisionname',5)

dw_pisq710u_02.GetChild('status', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq710u_02,'status',ldwc,'displayname',5)

dw_pisq710u_03.GetChild('qaanalyzecontent', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS008')
f_pisc_set_dddw_width(dw_pisq710u_03,'qaanalyzecontent',ldwc,'displayname',10)

dw_pisq710u_03.GetChild('qcanalyzecontent', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS008')
f_pisc_set_dddw_width(dw_pisq710u_03,'qcanalyzecontent',ldwc,'displayname',10)

//splitbar 설정
st_vsplitbar.of_Register(dw_pisq710u_02, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_pisq710u_03, st_vsplitbar.RIGHT)

end event

event ue_retrieve;call super::ue_retrieve;string ls_customercode, ls_objectionno, ls_objectiondate, ls_objectiondateto
string ls_exportgubun, ls_ingstatus

dw_pisq710u_01.accepttext()
dw_pisq710u_02.reset()
dw_pisq710u_03.reset()

ls_customercode = dw_pisq710u_01.getitemstring(1, 'customercode')
ls_objectionno = dw_pisq710u_01.getitemstring(1, 'objectionno')
ls_objectiondate = dw_pisq710u_01.getitemstring(1, 'objectiondate')
ls_objectiondateto = dw_pisq710u_01.getitemstring(1, 'objectiondateto')
ls_exportgubun = dw_pisq710u_01.getitemstring(1, 'exportgubun')
ls_ingstatus = dw_pisq710u_01.getitemstring(1, 'ingstatus')

if f_spacechk(ls_objectiondate) = -1 then
	ls_objectiondate = '1900.01.01'
end if

if f_spacechk(ls_objectiondateto) = -1 then
	ls_objectiondateto = '9999.01.01'
end if

dw_pisq710u_02.retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	ls_ingstatus, ls_exportgubun, ls_customercode, &
	ls_objectionno, ls_objectiondate, ls_objectiondateto)
end event

event ue_save;call super::ue_save;string ls_errormsg, ls_manclaimno, ls_areacode, ls_divisioncode
integer li_findrow, li_seqno, li_selrow, li_count

dw_pisq710u_03.accepttext()
dw_pisq710u_04.accepttext()

li_selrow = dw_pisq710u_03.getselectedrow(0)
if li_selrow < 1 then
	return 0
end if
ls_manclaimno = dw_pisq710u_03.getitemstring(li_selrow,'manclaimno')
li_seqno = dw_pisq710u_03.getitemnumber(li_selrow,'seqno')

if dw_pisq710u_03.modifiedcount() > 0 or dw_pisq710u_04.modifiedcount() > 0 then
	//pass
else
	uo_status.st_message.text = "변경된 정보가 없습니다."
	return 0
end if
sqleis.AutoCommit = False

if dw_pisq710u_03.modifiedcount() > 0 then
	if dw_pisq710u_03.update() <> 1 then
		ls_errormsg = "이의제기정보를 저장할때에 에러가 발생했습니다."
		Goto RollBack_
	end if
end if

if dw_pisq710u_04.modifiedcount() > 0 then
	//	바뀐공장에 대한 이의제기정보 생성
	Select AreaCode, DivisionCode Into :ls_areacode, :ls_divisioncode
	From TWCLAIMLIST
	Where ManClaimNo = :ls_manclaimno and SeqNo = :li_seqno
	using sqleis;
	
	if ls_areacode <> dw_pisq710u_04.getitemstring(1,'areacode') or &
			ls_divisioncode <> dw_pisq710u_04.getitemstring(1,'divisioncode') then
		// 보상청구데이타 지역,공장 수정
		ls_areacode = dw_pisq710u_04.getitemstring(1,'areacode')
		ls_divisioncode = dw_pisq710u_04.getitemstring(1,'divisioncode')
		
		UPDATE TWCLAIMLIST
		SET AreaCode = :ls_areacode, DivisionCode = :ls_divisioncode
		WHERE ManClaimNo = :ls_manclaimno and SeqNo = :li_seqno
		using sqleis;
		
		if sqleis.sqlnrows < 1 then
			Messagebox("chk",sqleis.sqlerrtext)
				ls_errormsg = "보상청구데이타 지역,공장 저장시에 에러가 발생했습니다."
			Goto RollBack_
		end if
		
		Select Count(*) Into :li_count
		From TWOBJECTIONLIST
		Where ManClaimNo = :ls_manclaimno and SeqNo = :li_seqno and
			AreaCode = :ls_areacode and DivisionCode = :ls_divisioncode
		using sqleis;
		
		if li_count = 0 then
			Insert Into TWOBJECTIONLIST
			(	ManClaimNo, SeqNo, AreaCode, DivisionCode, PassDay, 
				AssureTerm, ItemGubun, QcAnalyzeContent, QcApplyReference, QcApplyRatio, 
				ObjectionQty, ObjectionAmount, LastEmp)
			Select  ManageNo = A.ManClaimNo,
				SeqNo = A.SeqNo,
				AreaCode = :ls_areacode,
				DivisionCode = :ls_divisioncode,
				PassDay = datediff(dd,cast(A.CarOutDate as datetime),cast(A.CarRepairDate as datetime)),
				AssureTerm = ' ',
				ItemGubun = ' ', 
				QcAnalyzeContent = ' ', 
				QcApplyReference = ' ', 
				QcApplyRatio = 0, 
				ObjectionQty = 0, 
				ObjectionAmount = 0,
				:g_s_empno
			From  twclaimlist   A 
			Where A.ManClaimNo = :ls_manclaimno and A.SeqNo = :li_seqno
			using sqleis;
			
			if sqleis.sqlcode <> 0 then
				Messagebox("chk",sqleis.sqlerrtext)
				ls_errormsg = "지역,공장의 이의제기데이타 저장할때에 에러가 발생했습니다."
				Goto RollBack_
			end if
		end if
	end if
	// End
end if

Commit using sqleis;
sqleis.AutoCommit = True

// 화면 Refesh
li_selrow = dw_pisq710u_02.getselectedrow(0)
dw_pisq710u_02.Post Event RowFocusChanged(li_selrow)
li_findrow = dw_pisq710u_03.find("manclaimno = '" + ls_manclaimno &
		+ "' and seqno = " + string(li_seqno), 1, dw_pisq710u_03.rowcount())
if li_findrow > 0 then
	dw_pisq710u_03.Post Event RowFocusChanged(li_findrow)
end if

uo_status.st_message.text = "저장되었습니다."
return 0
	
RollBack_:
RollBack using sqleis;
sqleis.AutoCommit = True
uo_status.st_message.text = ls_errormsg

return 0
end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq710u
end type

type dw_pisq710u_01 from datawindow within w_pisq710u
integer x = 32
integer y = 172
integer width = 1595
integer height = 796
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq710u_01"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_pisq710u_02 from u_vi_std_datawindow within w_pisq710u
integer x = 32
integer y = 984
integer width = 1225
integer height = 864
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisq710u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_pisqwc NewMenu
string ls_name, ls_data, ls_type, ls_col_type, ls_ingstatus, ls_manageno
string ls_areacode, ls_divisioncode
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
ls_areacode = uo_area.is_uo_areacode
ls_divisioncode = uo_division.is_uo_divisioncode

lstr_parm.s_parm[1] 	= ls_manageno
lstr_parm.s_parm[2] 	= ls_areacode
lstr_parm.s_parm[3] 	= ls_divisioncode
lstr_parm.w_parm		= iw_this
lstr_parm.dw_parm[1] = this
lstr_parm.dw_parm[2] = dw_pisq710u_03
Message.PowerObjectParm = lstr_parm

NewMenu = CREATE m_pop_pisqwc

if ls_ingstatus = 'B' or ls_ingstatus = 'C' then 	//이의제기상태
	NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = False
	NewMenu.m_action.m_canceldivision.enabled = True
	NewMenu.m_action.m_confirmdivision.enabled = True
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

event rowfocuschanged;call super::rowfocuschanged;string ls_manageno, ls_status
integer li_seqno

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

ls_manageno = This.getitemstring(currentrow, 'manageno')
ls_status = This.getitemstring(currentrow,'status')
if ls_status = 'B' then
	i_b_save = True
else
	i_b_save = False
end if
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
				  
dw_pisq710u_03.retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_manageno)

end event

type dw_pisq710u_04 from datawindow within w_pisq710u
integer x = 1650
integer y = 172
integer width = 1440
integer height = 796
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq710u_04"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string ls_colname
datawindowchild ldwc

ls_colname = dwo.name

if ls_colname = 'areacode' then
	This.GetChild('divisioncode', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve('%',data,'%')
	
	This.Setitem(row,'divisioncode',' ')
end if
end event

type uo_area from u_pisc_select_area within w_pisq710u
integer x = 91
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											TRUE, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
end event

event constructor;call super::constructor;ib_allflag = True
end event

type uo_division from u_pisc_select_division within w_pisq710u
integer x = 622
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type st_vsplitbar from uo_xc_splitbar within w_pisq710u
integer x = 1275
integer y = 1004
boolean bringtotop = true
end type

type pb_down from picturebutton within w_pisq710u
integer x = 1317
integer y = 24
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
if dw_pisq710u_03.rowcount() > 0 then
	f_save_to_excel(dw_pisq710u_03)
else
	uo_status.st_message.text = "다운로드할 데이타가 없습니다."
end if
end event

type cb_upload from commandbutton within w_pisq710u
integer x = 1646
integer y = 36
integer width = 731
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
string text = "이의제기 업로드"
end type

event clicked;string ls_manageno, ls_ingstatus
long ll_selrow

ll_selrow = dw_pisq710u_02.getselectedrow(0)

if ll_selrow < 1 then
	uo_status.st_message.text = "선택된 보상청구건이 없습니다."
	return 0
end if

ls_manageno = dw_pisq710u_02.getitemstring(ll_selrow,'manageno')
ls_ingstatus = dw_pisq710u_02.getitemstring(ll_selrow,'ingstatus')

if ls_ingstatus <> 'B' then
	Messagebox("알림","해당보상청구건은 이의제기상태가 아닙니다.")
	return 0
end if

openwithparm(w_pisq710u_01,ls_manageno)

dw_pisq710u_02.Post Event RowFocusChanged(ll_selrow)
dw_pisq710u_02.scrolltorow(ll_selrow)
dw_pisq710u_02.setrow(ll_selrow)
end event

type gb_1 from groupbox within w_pisq710u
integer x = 32
integer width = 1239
integer height = 164
integer taborder = 10
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type dw_pisq710u_03 from u_vi_std_datawindow within w_pisq710u
integer x = 1317
integer y = 984
integer width = 1778
integer height = 864
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisq710u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;datawindowchild ldwc
string ls_manageno, ls_areacode, ls_divisioncode
integer li_seqno

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

ls_manageno = dw_pisq710u_03.getitemstring(currentrow, 'manclaimno')
li_seqno		= dw_pisq710u_03.getitemnumber(currentrow, 'seqno')
ls_areacode = dw_pisq710u_03.getitemstring(currentrow, 'areacode')
ls_divisioncode = dw_pisq710u_03.getitemstring(currentrow, 'divisioncode')

dw_pisq710u_04.retrieve(ls_manageno, li_seqno, ls_areacode, ls_divisioncode)

dw_pisq710u_04.GetChild('divisioncode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%',ls_areacode,'%')
end event

event itemchanged;call super::itemchanged;dec{2} lc_payqty
long ll_payamount, ll_applyratio, ll_selrow
string ls_applyreference, ls_custcode

if dwo.name = 'qcapplyratio' then
	lc_payqty = This.getitemnumber( row, 'payqty')
	ll_payamount = This.getitemnumber( row, 'payamount')
	this.setitem( row, 'objectionqty', lc_payqty * long(data) / 100 )
	this.setitem( row, 'objectionamount', ll_payamount * long(data) / 100 )
end if

if dwo.name = 'qcanalyzecontent' then
	ll_selrow = dw_pisq710u_02.getselectedrow(0)
	choose case data
		case 'A','B','C'
			lc_payqty = This.getitemnumber( row, 'payqty')
			ll_payamount = This.getitemnumber( row, 'payamount')
			ls_custcode = dw_pisq710u_02.getitemstring(ll_selrow,'customercode')
			
			SELECT isnull(ApplyReference,'KDAC 0%'), isnull(ApplyRatio,100) 
				INTO :ls_applyreference, :ll_applyratio
			FROM TWALLOTCODE
			WHERE CustCode = :ls_custcode AND ItemCheck = :data 
			using sqleis;
			
			This.setitem( row, 'qcapplyreference', ls_applyreference )
			This.setitem( row, 'qcapplyratio', ll_applyratio )
			this.setitem( row, 'objectionqty', lc_payqty * ll_applyratio / 100 )
			this.setitem( row, 'objectionamount', ll_payamount * ll_applyratio / 100 )
		case else
			This.setitem( row, 'qcapplyreference', '미지정' )
			This.setitem( row, 'qcapplyratio', 0 )
	end choose
end if

this.setitem( row, 'lastemp', g_s_empno )
return 0
end event

