$PBExportHeader$w_pisq614u.srw
$PBExportComments$분담율 관리
forward
global type w_pisq614u from w_ipis_sheet01
end type
type dw_pisq614u_01 from datawindow within w_pisq614u
end type
type st_1 from statictext within w_pisq614u
end type
type st_2 from statictext within w_pisq614u
end type
type dw_pisq614u_02 from u_vi_std_datawindow within w_pisq614u
end type
type dw_pisq614u_03 from u_vi_std_datawindow within w_pisq614u
end type
type st_vsplitbar from uo_xc_splitbar within w_pisq614u
end type
end forward

global type w_pisq614u from w_ipis_sheet01
integer width = 3977
dw_pisq614u_01 dw_pisq614u_01
st_1 st_1
st_2 st_2
dw_pisq614u_02 dw_pisq614u_02
dw_pisq614u_03 dw_pisq614u_03
st_vsplitbar st_vsplitbar
end type
global w_pisq614u w_pisq614u

on w_pisq614u.create
int iCurrent
call super::create
this.dw_pisq614u_01=create dw_pisq614u_01
this.st_1=create st_1
this.st_2=create st_2
this.dw_pisq614u_02=create dw_pisq614u_02
this.dw_pisq614u_03=create dw_pisq614u_03
this.st_vsplitbar=create st_vsplitbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq614u_01
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_pisq614u_02
this.Control[iCurrent+5]=this.dw_pisq614u_03
this.Control[iCurrent+6]=this.st_vsplitbar
end on

on w_pisq614u.destroy
call super::destroy
destroy(this.dw_pisq614u_01)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_pisq614u_02)
destroy(this.dw_pisq614u_03)
destroy(this.st_vsplitbar)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisq614u_02.Width = (newwidth * 1 / 7)	+ ls_status
dw_pisq614u_02.Height= newheight - (dw_pisq614u_02.y + ls_status)

dw_pisq614u_03.x = dw_pisq614u_02.x + dw_pisq614u_02.Width + ls_split
dw_pisq614u_03.y = dw_pisq614u_02.y
dw_pisq614u_03.Width = (newwidth * 6 / 7) - ( ls_status * 2 ) + ls_split
dw_pisq614u_03.Height= dw_pisq614u_02.Height

st_1.x = dw_pisq614u_02.x
st_2.x = dw_pisq614u_03.x

st_vsplitbar.x 		= dw_pisq614u_02.x + dw_pisq614u_02.width
st_vsplitbar.y 		= dw_pisq614u_02.y
st_vsplitbar.Height 	= dw_pisq614u_02.Height
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

event ue_postopen;call super::ue_postopen;long ll_currow
datawindowchild ldwc

dw_pisq614u_01.settransobject(sqleis)
dw_pisq614u_02.settransobject(sqleis)
dw_pisq614u_03.settransobject(sqleis)

//splitbar 설정
st_vsplitbar.of_Register(dw_pisq614u_02, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_pisq614u_03, st_vsplitbar.RIGHT)

dw_pisq614u_01.GetChild('areacode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','%')
ll_currow = ldwc.InsertRow(0)
ldwc.Setitem(ll_currow, 'AreaCode', '%')
ldwc.Setitem(ll_currow, 'AreaName', 'ALL')
f_pisc_set_dddw_width(dw_pisq614u_01,'areacode',ldwc,'areaname',10)

dw_pisq614u_01.GetChild('divisioncode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','%','%')
ll_currow = ldwc.InsertRow(0)
ldwc.Setitem(ll_currow, 'DivisionCode', '%')
ldwc.Setitem(ll_currow, 'DivisionName', 'ALL')
f_pisc_set_dddw_width(dw_pisq614u_01,'divisioncode',ldwc,'divisionname',10)

dw_pisq614u_01.GetChild('custcode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq614u_01,'custcode',ldwc,'displayname',10)

dw_pisq614u_01.GetChild('productid', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','%')
f_pisc_set_dddw_width(dw_pisq614u_01,'productid',ldwc,'displayname',10)

dw_pisq614u_01.insertrow(0)
dw_pisq614u_01.setitem(1,'areacode','%')
dw_pisq614u_01.setitem(1,'divisioncode','%')
dw_pisq614u_01.setitem(1,'custcode','%')
dw_pisq614u_01.setitem(1,'productid','%')
dw_pisq614u_01.setitem(1,'exportgubun','%')
dw_pisq614u_01.setitem(1,'oagubun','%')
end event

event ue_retrieve;call super::ue_retrieve;string ls_areacode, ls_divisioncode, ls_exportgubun, ls_oagubun
string ls_custcode, ls_productid

dw_pisq614u_01.accepttext()
ls_areacode = dw_pisq614u_01.getitemstring(1,'areacode')
ls_divisioncode = dw_pisq614u_01.getitemstring(1,'divisioncode')
ls_exportgubun = dw_pisq614u_01.getitemstring(1,'exportgubun')
ls_oagubun = dw_pisq614u_01.getitemstring(1,'oagubun')
ls_custcode = dw_pisq614u_01.getitemstring(1,'custcode')
ls_productid = dw_pisq614u_01.getitemstring(1,'productid')

dw_pisq614u_02.retrieve(ls_areacode, ls_divisioncode, ls_custcode, &
			ls_exportgubun, ls_oagubun)
end event

event ue_insert;call super::ue_insert;long ll_selrow, ll_currow
string ls_assureid

ll_selrow = dw_pisq614u_02.getselectedrow(0)
if ll_selrow < 1 then
	return 0
end if
ls_assureid = dw_pisq614u_02.getitemstring(ll_selrow,'assureid')

ll_currow = dw_pisq614u_03.insertrow(0)
dw_pisq614u_03.setitem(ll_currow,'assureid',ls_assureid)
dw_pisq614u_03.setitem(ll_currow,'lastemp',g_s_empno)

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq614u
end type

type dw_pisq614u_01 from datawindow within w_pisq614u
integer x = 23
integer y = 24
integer width = 3849
integer height = 276
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq614u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_areacode, ls_divisioncode
long ll_currow
datawindowchild ldwc

if dwo.name = 'areacode' then
	//지역변경시에 공장과 제품id를 변경
	This.GetChild('divisioncode', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve('%',data,'%')
	ll_currow = ldwc.InsertRow(0)
	ldwc.Setitem(ll_currow, 'DivisionCode', '%')
	ldwc.Setitem(ll_currow, 'DivisionName', 'ALL')
	f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)

	This.GetChild('productid', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve(data,'%')
	f_pisc_set_dddw_width(This,'productid',ldwc,'codename',10)
elseif dwo.name = 'divisioncode' then
	//공장변경시에 제품id 를 변경
	ls_areacode = This.getitemstring(row,'areacode')
	This.GetChild('productid', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve(ls_areacode,data)
	f_pisc_set_dddw_width(This,'productid',ldwc,'codename',10)
end if
end event

type st_1 from statictext within w_pisq614u
integer x = 32
integer y = 316
integer width = 594
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "분담율 MASTER"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisq614u
integer x = 1554
integer y = 316
integer width = 1083
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "분담율 정보 ( 품번, 차종별 )"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_pisq614u_02 from u_vi_std_datawindow within w_pisq614u
integer x = 32
integer y = 404
integer width = 1490
integer height = 1468
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisq614u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_assureid, ls_productid, ls_custcode
datawindowchild ldwc

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

ls_assureid = This.getitemstring(currentrow, 'assureid')
ls_productid = This.getitemstring(currentrow, 'productid')
ls_custcode	= This.getitemstring(currentrow, 'custcode')

dw_pisq614u_03.GetChild('reasonitemcode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve(ls_custcode, ls_productid)
f_pisc_set_dddw_width(dw_pisq614u_03,'reasonitemcode',ldwc,'displayname',10)

dw_pisq614u_03.GetChild('carcode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve(ls_custcode)
f_pisc_set_dddw_width(dw_pisq614u_03,'carcode',ldwc,'displayname',10)

dw_pisq614u_03.GetChild('itemcheck', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS008')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq614u_03,'itemcheck',ldwc,'displayname',10)

dw_pisq614u_03.GetChild('allotcode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve(ls_custcode)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_pisq614u_03,'allotcode',ldwc,'displayname',10)

dw_pisq614u_03.retrieve(ls_assureid)
end event

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_pisqwc NewMenu
string ls_name, ls_data, ls_type, ls_col_type, ls_code
str_pisqwc_parm lstr_parm

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

//// 계산 끝
lstr_parm.s_parm[1] 	= 'J'
lstr_parm.w_parm		= iw_this
lstr_parm.dw_parm[1] = this
lstr_parm.dw_parm[2] = dw_pisq614u_02
Message.PowerObjectParm = lstr_parm

NewMenu = CREATE m_pop_pisqwc

NewMenu.m_action.m_claimupload.enabled = False
	NewMenu.m_action.m_claimdownload.enabled = False
	NewMenu.m_action.m_confirmupload.enabled = False
	NewMenu.m_action.m_applyobjection.enabled = False
	NewMenu.m_action.m_cancelobjection.enabled = False
	NewMenu.m_action.m_confirmobjection.enabled = False
	NewMenu.m_action.m_canceldivision.enabled = False
	NewMenu.m_action.m_confirmdivision.enabled = False
	NewMenu.m_action.m_basicinfo.enabled = False
	NewMenu.m_action.m_insertinfo.enabled = True

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

type dw_pisq614u_03 from u_vi_std_datawindow within w_pisq614u
integer x = 1554
integer y = 404
integer width = 1755
integer height = 1468
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisq614u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;
if dwo.name = 'reasonitemname' then
	
end if
end event

type st_vsplitbar from uo_xc_splitbar within w_pisq614u
integer x = 1527
integer y = 404
boolean bringtotop = true
end type

