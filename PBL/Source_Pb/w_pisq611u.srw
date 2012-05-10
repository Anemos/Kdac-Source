$PBExportHeader$w_pisq611u.srw
$PBExportComments$기본정보 등록
forward
global type w_pisq611u from w_ipis_sheet01
end type
type dw_pisq611u_01 from u_vi_std_datawindow within w_pisq611u
end type
type dw_pisq611u_02 from u_vi_std_datawindow within w_pisq611u
end type
type st_1 from statictext within w_pisq611u
end type
type dw_pisq611u_03 from datawindow within w_pisq611u
end type
type pb_down from picturebutton within w_pisq611u
end type
end forward

global type w_pisq611u from w_ipis_sheet01
dw_pisq611u_01 dw_pisq611u_01
dw_pisq611u_02 dw_pisq611u_02
st_1 st_1
dw_pisq611u_03 dw_pisq611u_03
pb_down pb_down
end type
global w_pisq611u w_pisq611u

type variables
string is_refcode
end variables

on w_pisq611u.create
int iCurrent
call super::create
this.dw_pisq611u_01=create dw_pisq611u_01
this.dw_pisq611u_02=create dw_pisq611u_02
this.st_1=create st_1
this.dw_pisq611u_03=create dw_pisq611u_03
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq611u_01
this.Control[iCurrent+2]=this.dw_pisq611u_02
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_pisq611u_03
this.Control[iCurrent+5]=this.pb_down
end on

on w_pisq611u.destroy
call super::destroy
destroy(this.dw_pisq611u_01)
destroy(this.dw_pisq611u_02)
destroy(this.st_1)
destroy(this.dw_pisq611u_03)
destroy(this.pb_down)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisq611u_01.Width = (newwidth * 1 / 6)	+ ls_status
dw_pisq611u_01.Height= newheight - (dw_pisq611u_01.y + ls_status)

dw_pisq611u_02.x = dw_pisq611u_01.x + dw_pisq611u_01.Width + ls_split
dw_pisq611u_02.y = dw_pisq611u_01.y
dw_pisq611u_02.Width = (newwidth * 5 / 6) - ( ls_status * 2 ) + ls_split
dw_pisq611u_02.Height= (dw_pisq611u_01.Height * 2 / 3)

dw_pisq611u_03.x = dw_pisq611u_02.x
dw_pisq611u_03.y = dw_pisq611u_01.y + dw_pisq611u_02.Height + ls_split
dw_pisq611u_03.Width = dw_pisq611u_02.Width
dw_pisq611u_03.Height= (dw_pisq611u_01.Height * 1 / 3) - ls_split
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

event ue_postopen;call super::ue_postopen;
dw_pisq611u_01.settransobject(sqleis)
dw_pisq611u_02.settransobject(sqleis)

dw_pisq611u_01.retrieve('WCS000')
end event

event ue_insert;call super::ue_insert;dw_pisq611u_03.reset()

dw_pisq611u_03.insertrow(0)
end event

event ue_save;call super::ue_save;long ll_selrow

choose case is_refcode
	case 'A'	//정산품번관리 'd_pisq611u_a' 
		
	case 'B'	//제품군관리 'd_pisq611u_b'
		
	case 'C'	//고객사관리 'd_pisq611u_c'
		
	case 'D'	//국가코드관리 'd_pisq611u_d'
		
	case 'E'	//정비딜러관리 'd_pisq611u_e'
		
	case 'F'	//차종관리 'd_pisq611u_f'
		
	case 'G'	//차량현상관리 'd_pisq611u_g'
		
	case 'H' //부품결함원인 'd_pisq611u_h'
		
	case 'I'	//적용분담율 'd_pisq611u_i' => 분담율 화면 이용
		
	case 'J'	//보증기간 Master 'd_pisq611u_j'
		
	case 'K' //보증기간 Code 'd_pisq611u_k'
		
	case 'L'	//적용분담율 Code 'd_pisq611u_l' => 분담율 화면 이용
		
	case 'M'	//고객사 Mapping 'd_pisq611u_m'
		
	case 'N'
		
end choose

ll_selrow = dw_pisq611u_02.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
end if
sqleis.autocommit = false
if dw_pisq611u_03.update() = 1 then
	Commit using sqleis;
	sqleis.autocommit = true
	dw_pisq611u_01.Post Event RowFocusChanged(dw_pisq611u_01.getselectedrow(0))
	dw_pisq611u_02.Post Event RowFocusChanged(ll_selrow)
	dw_pisq611u_02.SelectRow(0, FALSE)
	dw_pisq611u_02.SelectRow(ll_selrow, TRUE)
	dw_pisq611u_02.Setrow(ll_selrow)
	uo_status.st_message.text = '저장되었습니다.'
else
	Rollback using sqleis;
	sqleis.autocommit = true
	uo_status.st_message.text = '저장시에 에러가 발생하였습니다.'
	This.Triggerevent('ue_retrieve')
end if

return 0
end event

event ue_delete;call super::ue_delete;long ll_selrow

ll_selrow = dw_pisq611u_02.getselectedrow(0)
if ll_selrow < 1 then
	return 0
end if

dw_pisq611u_03.deleterow(1)
end event

event ue_retrieve;call super::ue_retrieve;long ll_selrow

ll_selrow = dw_pisq611u_01.getselectedrow(0)
dw_pisq611u_01.Post Event RowFocusChanged(ll_selrow)
end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq611u
end type

type dw_pisq611u_01 from u_vi_std_datawindow within w_pisq611u
integer x = 27
integer y = 128
integer width = 1312
integer height = 1752
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq_select_codemaster"
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_cocode
datawindowchild ldwc

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

ls_cocode = This.getitemstring(currentrow,'cocode')
is_refcode = ls_cocode

dw_pisq611u_03.reset()
choose case ls_cocode
	case 'A'	//정산품번관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_a'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_a1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('itemgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS007')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'itemgubun',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('productid', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'productid',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('accarea', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		f_pisc_set_dddw_width(dw_pisq611u_03,'accarea',ldwc,'areaname',10)

		dw_pisq611u_03.GetChild('accdivision', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%','%')
		f_pisc_set_dddw_width(dw_pisq611u_03,'accdivision',ldwc,'divisionname',10)
	case 'B'	//제품군관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_b'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_b1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('areacode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		f_pisc_set_dddw_width(dw_pisq611u_03,'areacode',ldwc,'areaname',10)

		dw_pisq611u_03.GetChild('divisioncode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%','%')
		f_pisc_set_dddw_width(dw_pisq611u_03,'divisioncode',ldwc,'divisionname',10)
		
		dw_pisq611u_03.GetChild('division', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS006')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'division',ldwc,'codename',10)
	case 'C'	//고객사관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_c'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_c1'
		dw_pisq611u_03.settransobject(sqleis)
	case 'D'	//국가코드관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_d'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_d1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'mapcode',ldwc,'codename',10)
	case 'E'	//정비딜러관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_e'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_e1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'mapcode',ldwc,'codename',10)
	case 'F'	//차종관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_f'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_f1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'mapcode',ldwc,'codename',10)
	case 'G'	//차량현상관리
		dw_pisq611u_02.dataobject = 'd_pisq611u_g'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_g1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'mapcode',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('exportgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS003')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'exportgubun',ldwc,'codename',10)
	case 'H' //부품결함원인
		dw_pisq611u_02.dataobject = 'd_pisq611u_h'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_h1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'mapcode',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('exportgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS003')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'exportgubun',ldwc,'codename',10)
	case 'I'	//적용분담율
		dw_pisq611u_02.dataobject = 'd_pisq611u_i'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_i1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('carcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'carcode',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('itemcheck', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS008')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'itemcheck',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('allotcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'allotcode',ldwc,'codename',10)
	case 'J'	//보증기간 Master
		dw_pisq611u_02.dataobject = 'd_pisq611u_j'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_j1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('custcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'custcode',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('exportgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS003')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'exportgubun',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('oagubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS004')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'oagubun',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('productid', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'productid',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('assurecode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'assurecode',ldwc,'codename',10)
	case 'K' //보증기간 Code
		dw_pisq611u_02.dataobject = 'd_pisq611u_k'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_k1'
		dw_pisq611u_03.settransobject(sqleis)
	case 'L'	//적용분담율 Code
		dw_pisq611u_02.dataobject = 'd_pisq611u_l'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_l1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('custcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'custcode',ldwc,'codename',10)
		
		dw_pisq611u_03.GetChild('itemcheck', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS008')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_pisq611u_03,'itemcheck',ldwc,'codename',10)
	case 'M'	//고객사 Mapping
		dw_pisq611u_02.dataobject = 'd_pisq611u_m'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_m1'
		dw_pisq611u_03.settransobject(sqleis)
	case 'N'
		dw_pisq611u_02.dataobject = 'd_pisq611u_n'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_n1'
		dw_pisq611u_03.settransobject(sqleis)
	case 'O'
		dw_pisq611u_02.dataobject = 'd_pisq611u_o'
		dw_pisq611u_02.settransobject(sqleis)
		dw_pisq611u_03.dataobject = 'd_pisq611u_o1'
		dw_pisq611u_03.settransobject(sqleis)
		
		dw_pisq611u_03.GetChild('areacode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		f_pisc_set_dddw_width(dw_pisq611u_03,'areacode',ldwc,'areaname',10)

		dw_pisq611u_03.GetChild('divisioncode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%','%')
		f_pisc_set_dddw_width(dw_pisq611u_03,'divisioncode',ldwc,'divisionname',10)
end choose

dw_pisq611u_02.retrieve()
dw_pisq611u_03.insertrow(0)
end event

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_pisqwc NewMenu
string ls_name, ls_data, ls_type, ls_col_type, ls_code
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

ls_code = This.getitemstring(row,'cocode')
//// 계산 끝
lstr_parm.s_parm[1] 	= ls_code
lstr_parm.w_parm		= iw_this
lstr_parm.dw_parm[1] = this
lstr_parm.dw_parm[2] = dw_pisq611u_02
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
	NewMenu.m_action.m_basicinfo.enabled = True
	NewMenu.m_action.m_insertinfo.enabled = False

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

type dw_pisq611u_02 from u_vi_std_datawindow within w_pisq611u
integer x = 1362
integer y = 128
integer width = 1760
integer height = 908
integer taborder = 11
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;datawindowchild ldwc

string ls_areacode, ls_divisioncode, ls_productgroup
string ls_custcode, ls_exportgubun, ls_oagubun, ls_productid, ls_assurecode

This.accepttext()
choose case is_refcode
	case 'A'	//정산품번관리 'd_pisq611u_a' 
		if dwo.name = 'accarea' then
			//지역변경시에 공장과 제품id를 변경
			This.GetChild('accdivision', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'accdivision',ldwc,'divisionname',10)
		end if
	case 'B'	//제품군관리 'd_pisq611u_b'
		if dwo.name = 'areacode' then
			//지역변경시에 공장과 제품id를 변경
			This.GetChild('divisioncode', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)
		end if
		if dwo.name = 'areacode' or dwo.name = 'divisioncode' or &
			dwo.name = 'productgroup' then
			ls_areacode = This.getitemstring(row,'areacode')
			ls_divisioncode = This.getitemstring(row,'divisioncode')
			ls_productgroup = This.getitemstring(row,'productgroup')
			
			This.setitem( row,'productid', ls_productgroup + ls_areacode + ls_divisioncode )
		end if
	case 'C'	//고객사관리 'd_pisq611u_c'
		
	case 'D'	//국가코드관리 'd_pisq611u_d'
		
	case 'E'	//정비딜러관리 'd_pisq611u_e'
		
	case 'F'	//차종관리 'd_pisq611u_f'
		
	case 'G'	//차량현상관리 'd_pisq611u_g'
		
	case 'H' //부품결함원인 'd_pisq611u_h'
		
	case 'I'	//적용분담율 'd_pisq611u_i' => 분담율 화면 이용
		
	case 'J'	//보증기간 Master 'd_pisq611u_j'
		if dwo.name = 'custcode' or dwo.name = 'exportgubun' or &
			dwo.name = 'oagubun' or dwo.name = 'productid' or dwo.name = 'assurecode' then
			ls_custcode = Trim(This.getitemstring(row,'custcode'))
			ls_exportgubun = This.getitemstring(row,'exportgubun')
			ls_oagubun = This.getitemstring(row,'oagubun')
			ls_productid = This.getitemstring(row,'productid')
			ls_assurecode = This.getitemstring(row, 'assurecode')
			
			This.setitem( row,'assureid', ls_custcode + ls_exportgubun &
				+ ls_oagubun + ls_productid + ls_assurecode )
		end if
	case 'K' //보증기간 Code 'd_pisq611u_k'
		
	case 'L'	//적용분담율 Code 'd_pisq611u_l' => 분담율 화면 이용
		
	case 'M'	//고객사 Mapping 'd_pisq611u_m'
		
	case 'N'
		
	case 'O'
		if dwo.name = 'areacode' then
			//지역변경시에 공장 변경
			This.GetChild('divisioncode', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)
		end if
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;datawindowchild ldwc
string ls_arg[]
string ls_allotcode

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

dw_pisq611u_03.reset()
This.accepttext()
choose case is_refcode
	case 'A'	//정산품번관리 'd_pisq611u_a' 
		ls_arg[1] = This.getitemstring(currentrow,'custcode')
		ls_arg[2] = This.getitemstring(currentrow,'reasonitemcode')
		
		dw_pisq611u_03.retrieve(ls_arg[1],ls_arg[2])
	case 'B'	//제품군관리 'd_pisq611u_b'
		ls_arg[1] = This.getitemstring(currentrow,'areacode')
		ls_arg[2] = This.getitemstring(currentrow,'divisioncode')
		ls_arg[3] = This.getitemstring(currentrow,'productgroup')
		
		dw_pisq611u_03.retrieve(ls_arg[1],ls_arg[2],ls_arg[3])
	case 'C'	//고객사관리 'd_pisq611u_c'
		ls_arg[1] = This.getitemstring(currentrow,'custcode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'D'	//국가코드관리 'd_pisq611u_d'
		ls_arg[1] = This.getitemstring(currentrow,'nationcode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'E'	//정비딜러관리 'd_pisq611u_e'
		ls_arg[1] = This.getitemstring(currentrow,'dealercode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'F'	//차종관리 'd_pisq611u_f'
		ls_arg[1] = This.getitemstring(currentrow,'carcode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'G'	//차량현상관리 'd_pisq611u_g'
		ls_arg[1] = This.getitemstring(currentrow,'statuscode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'H' //부품결함원인 'd_pisq611u_h'
		ls_arg[1] = This.getitemstring(currentrow,'reasoncode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'I'	//적용분담율 'd_pisq611u_i' => 분담율 화면 이용
		ls_arg[1] = This.getitemstring(currentrow,'reasonitemcode')
		ls_arg[2] = This.getitemstring(currentrow,'carcode')
		ls_arg[3] = This.getitemstring(currentrow,'assureid')
		
		dw_pisq611u_03.retrieve(ls_arg[1],ls_arg[2],ls_arg[3])
	case 'J'	//보증기간 Master 'd_pisq611u_j'
		ls_arg[1] = This.getitemstring(currentrow,'assureid')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'K' //보증기간 Code 'd_pisq611u_k'
		ls_arg[1] = This.getitemstring(currentrow,'assurecode')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'L'	//적용분담율 Code 'd_pisq611u_l' => 분담율 화면 이용
		ls_allotcode = This.getitemstring(currentrow,'allotcode')
		
		dw_pisq611u_03.retrieve(ls_allotcode)
	case 'M'	//고객사 Mapping 'd_pisq611u_m'
		ls_arg[1] = This.getitemstring(currentrow,'mapcode')
		ls_arg[2] = This.getitemstring(currentrow,'custcode')
		
		dw_pisq611u_03.retrieve(ls_arg[1],ls_arg[2])
	case 'N'
		ls_arg[1] = This.getitemstring(currentrow,'wcgubun')
		
		dw_pisq611u_03.retrieve(ls_arg[1])
	case 'O'
		ls_arg[1] = This.getitemstring(currentrow,'areacode')
		ls_arg[2] = This.getitemstring(currentrow,'divisioncode')
		ls_arg[3] = This.getitemstring(currentrow,'empno')
		
		dw_pisq611u_03.retrieve(ls_arg[1],ls_arg[2],ls_arg[3])
end choose
end event

type st_1 from statictext within w_pisq611u
integer x = 27
integer y = 24
integer width = 2807
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "청구,확정 업로드 및 이의제기 절차에 적용되는 기본데이타를 관리하는 화면입니다."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_pisq611u_03 from datawindow within w_pisq611u
integer x = 1367
integer y = 1060
integer width = 1746
integer height = 812
integer taborder = 21
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;datawindowchild ldwc

string ls_areacode, ls_divisioncode, ls_productgroup
string ls_custcode, ls_exportgubun, ls_oagubun, ls_productid, ls_assurecode

This.accepttext()
choose case is_refcode
	case 'A'	//정산품번관리 'd_pisq611u_a' 
		if dwo.name = 'accarea' then
			//지역변경시에 공장과 제품id를 변경
			This.GetChild('accdivision', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'accdivision',ldwc,'divisionname',10)
		end if
	case 'B'	//제품군관리 'd_pisq611u_b'
		if dwo.name = 'areacode' then
			//지역변경시에 공장과 제품id를 변경
			This.GetChild('divisioncode', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)
		end if
		if dwo.name = 'areacode' or dwo.name = 'divisioncode' or &
			dwo.name = 'productgroup' then
			ls_areacode = This.getitemstring(row,'areacode')
			ls_divisioncode = This.getitemstring(row,'divisioncode')
			ls_productgroup = This.getitemstring(row,'productgroup')
			
			This.setitem( row,'productid', ls_areacode + ls_divisioncode + ls_productgroup )
		end if
	case 'C'	//고객사관리 'd_pisq611u_c'
		
	case 'D'	//국가코드관리 'd_pisq611u_d'
		
	case 'E'	//정비딜러관리 'd_pisq611u_e'
		
	case 'F'	//차종관리 'd_pisq611u_f'
		
	case 'G'	//차량현상관리 'd_pisq611u_g'
		
	case 'H' //부품결함원인 'd_pisq611u_h'
		
	case 'I'	//적용분담율 'd_pisq611u_i' => 분담율 화면 이용
		
	case 'J'	//보증기간 Master 'd_pisq611u_j'
		if dwo.name = 'custcode' or dwo.name = 'exportgubun' or &
			dwo.name = 'oagubun' or dwo.name = 'productid' or dwo.name = 'assurecode' then
			ls_custcode = Trim(This.getitemstring(row,'custcode'))
			ls_exportgubun = This.getitemstring(row,'exportgubun')
			ls_oagubun = This.getitemstring(row,'oagubun')
			ls_productid = This.getitemstring(row,'productid')
			ls_assurecode = This.getitemstring(row, 'assurecode')
			
			This.setitem( row,'assureid', ls_custcode + ls_exportgubun &
				+ ls_oagubun + ls_productid + ls_assurecode )
		end if
	case 'K' //보증기간 Code 'd_pisq611u_k'
		
	case 'L'	//적용분담율 Code 'd_pisq611u_l' => 분담율 화면 이용
		
	case 'M'	//고객사 Mapping 'd_pisq611u_m'
		
	case 'N'
		
	case 'O'
		if dwo.name = 'areacode' then
			//지역변경시에 공장 변경
			This.GetChild('divisioncode', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)
		end if
end choose
end event

type pb_down from picturebutton within w_pisq611u
integer x = 2898
integer y = 8
integer width = 238
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
if dw_pisq611u_02.rowcount() < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
	return 0
end if

f_save_to_excel(dw_pisq611u_02)
end event

