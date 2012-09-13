$PBExportHeader$w_mpm220u.srw
$PBExportComments$공정설계관리
forward
global type w_mpm220u from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm220u
end type
type dw_mpm220u_01 from u_vi_std_datawindow within w_mpm220u
end type
type dw_mpm220u_03 from datawindow within w_mpm220u
end type
type cb_confirm from commandbutton within w_mpm220u
end type
type dw_report from datawindow within w_mpm220u
end type
type st_2 from statictext within w_mpm220u
end type
type ddlb_print from dropdownlistbox within w_mpm220u
end type
type cb_print from commandbutton within w_mpm220u
end type
type uo_2 from u_mpms_select_wccode within w_mpm220u
end type
type dw_mpm220u_02 from datawindow within w_mpm220u
end type
type st_3 from statictext within w_mpm220u
end type
type gb_1 from groupbox within w_mpm220u
end type
type gb_2 from groupbox within w_mpm220u
end type
end forward

global type w_mpm220u from w_ipis_sheet01
integer width = 4041
uo_1 uo_1
dw_mpm220u_01 dw_mpm220u_01
dw_mpm220u_03 dw_mpm220u_03
cb_confirm cb_confirm
dw_report dw_report
st_2 st_2
ddlb_print ddlb_print
cb_print cb_print
uo_2 uo_2
dw_mpm220u_02 dw_mpm220u_02
st_3 st_3
gb_1 gb_1
gb_2 gb_2
end type
global w_mpm220u w_mpm220u

type variables
integer in_index
end variables

forward prototypes
public function string wf_add_operno ()
public function integer wf_delete_chk (string ag_orderno, string ag_partno, string ag_operno)
public function integer wf_each_voucher ()
public function integer wf_total_voucher ()
public function integer wf_total_order ()
public function integer wf_each_order ()
end prototypes

public function string wf_add_operno ();string ls_operno
integer li_rowcnt, li_midnum, li_firstnum

li_rowcnt = dw_mpm220u_02.rowcount()

if li_rowcnt = 1 then
	return '010'
end if

ls_operno = dw_mpm220u_02.getitemstring( li_rowcnt - 1,'operno')

li_firstnum = integer(mid(ls_operno,1,1))
li_midnum = integer(mid(ls_operno,2,1))

if li_midnum = 9 then
	li_firstnum = li_firstnum + 1
	li_midnum = 0
else
	li_midnum = li_midnum + 1
end if

return string(li_firstnum) + string(li_midnum) + '0'
end function

public function integer wf_delete_chk (string ag_orderno, string ag_partno, string ag_operno);//--------------
// tworkjob에 실적이 등록되어 있는 경우 => return -1, 없으면 => return 0
//--------------
integer li_count

SELECT COUNT(*) INTO :li_count FROM TWORKJOB
WHERE ORDERNO = :ag_orderno AND PARTNO = :ag_partno AND
		OPERNO = :ag_operno
		using sqlmpms;
		
if li_count > 0 or sqlmpms.sqlcode <> 0 then
	return -1
else
	return 0
end if
end function

public function integer wf_each_voucher ();integer li_rowcnt, li_selrow
string  mod_string, ls_orderno, ls_partno

window 	l_to_open
str_easy l_str_prt

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택해 주십시요."
	return 0
end if
li_selrow = dw_mpm220u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "도면부품번호를 선택해 주십시요."
	return 0
else
	dw_report.dataobject = 'd_mpm220u_03_quad'
	dw_report.settransobject(sqlmpms)
	
	ls_partno = dw_mpm220u_01.getitemstring(li_selrow, 'PartNo')
end if
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_report.retrieve(ls_orderno, ls_partno)

dw_report.print()
uo_status.st_message.text = "출력완료"
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
//l_str_prt.transaction  = sqlmpms
//l_str_prt.datawindow   = dw_report
//l_str_prt.dwsyntax     = mod_string
//l_str_prt.tag			  = This.ClassName()
//	
//f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
//Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
//
//uo_status.st_message.Text = ""
return 0
end function

public function integer wf_total_voucher ();integer li_rowcntx, li_rowcnty, li_selrow, li_cnt, li_currow, li_rowcnt
integer li_rowcntk, li_rowcntm, li_cntk, li_cntm
string  mod_string, ls_orderno, ls_wccode

window 	l_to_open
str_easy l_str_prt

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택해 주십시요."
	return 0
end if

ls_wccode = uo_2.is_uo_wccode
if ls_wccode = 'ALL' then
	ls_wccode = '%'
else
	ls_wccode = ls_wccode + '%'
end if
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.dataobject = 'd_mpm220u_04_quad'
dw_report.settransobject(sqlmpms)

dw_report.reset()
dw_report.retrieve(ls_orderno, ls_wccode)

dw_report.print()
uo_status.st_message.text = "출력완료"
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
//l_str_prt.transaction  = sqlmpms
//l_str_prt.datawindow   = dw_report
//l_str_prt.dwsyntax     = mod_string
//l_str_prt.tag			  = This.ClassName()
//	
//f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
//Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
//
//uo_status.st_message.Text = ""
return 0
end function

public function integer wf_total_order ();integer li_rowcnt, li_selrow
string  mod_string, ls_orderno, ls_partno

window 	l_to_open
str_easy l_str_prt

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택해 주십시요."
	return 0
end if

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.dataobject = 'd_mpm310u_06'
dw_report.settransobject(sqlmpms)

dw_report.reset()
dw_report.retrieve(ls_orderno)
	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlmpms
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

iw_this.Triggerevent('ue_retrieve')
uo_status.st_message.Text = ""
return 0
end function

public function integer wf_each_order ();integer li_rowcnt, li_selrow
string  mod_string, ls_orderno, ls_partno

window 	l_to_open
str_easy l_str_prt

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택해 주십시요."
	return 0
end if
li_selrow = dw_mpm220u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "도면부품번호를 선택해 주십시요."
	return 0
else
	dw_report.dataobject = 'd_mpm310u_05'
	dw_report.settransobject(sqlmpms)
	
	ls_partno = dw_mpm220u_01.getitemstring(li_selrow, 'PartNo')
end if
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_report.retrieve(ls_orderno, ls_partno)

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

iw_this.Triggerevent('ue_retrieve')
uo_status.st_message.Text = ""
return 0
end function

on w_mpm220u.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_mpm220u_01=create dw_mpm220u_01
this.dw_mpm220u_03=create dw_mpm220u_03
this.cb_confirm=create cb_confirm
this.dw_report=create dw_report
this.st_2=create st_2
this.ddlb_print=create ddlb_print
this.cb_print=create cb_print
this.uo_2=create uo_2
this.dw_mpm220u_02=create dw_mpm220u_02
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_mpm220u_01
this.Control[iCurrent+3]=this.dw_mpm220u_03
this.Control[iCurrent+4]=this.cb_confirm
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_print
this.Control[iCurrent+8]=this.cb_print
this.Control[iCurrent+9]=this.uo_2
this.Control[iCurrent+10]=this.dw_mpm220u_02
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_mpm220u.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_mpm220u_01)
destroy(this.dw_mpm220u_03)
destroy(this.cb_confirm)
destroy(this.dw_report)
destroy(this.st_2)
destroy(this.ddlb_print)
destroy(this.cb_print)
destroy(this.uo_2)
destroy(this.dw_mpm220u_02)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm220u_03.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm220u_03.Height= ( newheight * 1 / 5 ) - ls_split

dw_mpm220u_01.x = dw_mpm220u_03.x
dw_mpm220u_01.y = dw_mpm220u_03.y + dw_mpm220u_03.Height + ls_split
dw_mpm220u_01.Width = (newwidth * 1 / 4)	- (ls_gap * 2)
dw_mpm220u_01.Height= newheight - (dw_mpm220u_01.y + ls_status)

dw_mpm220u_02.x = (ls_gap * 3) + dw_mpm220u_01.Width
dw_mpm220u_02.y = dw_mpm220u_01.y
dw_mpm220u_02.Width = (newwidth * 3 / 4) - (ls_gap * 3)
dw_mpm220u_02.Height= dw_mpm220u_01.Height
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

in_index = 1
dw_mpm220u_01.settransobject(sqlmpms)
dw_mpm220u_02.settransobject(sqlmpms)
dw_mpm220u_03.settransobject(sqlmpms)

dw_mpm220u_03.insertrow(0)

dw_mpm220u_02.GetChild('wccode', ldwc)
f_pisc_set_dddw_width(dw_mpm220u_02,'wccode',ldwc,'wcname',16)

dw_mpm220u_02.GetChild('outflag_1', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM003')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm220u_02,'outflag_1',ldwc,'codename',5)

dw_mpm220u_02.GetChild('workstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm220u_02,'workstatus',ldwc,'codename',5)

end event

event ue_retrieve;call super::ue_retrieve;string ls_status

dw_mpm220u_03.reset()
dw_mpm220u_02.reset()
dw_mpm220u_01.reset()
//ls_status = f_mpms_get_orderstatus(uo_1.is_uo_orderno)
//if ls_status < '3' then
//	choose case ls_status
//		case '1'
//			uo_status.st_message.text = '해당금형은 금형의뢰접수 상태입니다.'
//		case '2'
//			uo_status.st_message.text = '해당금형은 도면설계 진행 상태입니다.'
//	end choose
//	return 0
//else
//	if ls_status = 'C' then
//		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
//		wf_icon_onoff(true,  false,  false,  false,  i_b_print, & 
//					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
//	end if
//end if

dw_mpm220u_03.retrieve(uo_1.is_uo_orderno)
dw_mpm220u_01.retrieve(uo_1.is_uo_orderno)
end event

event ue_save;call super::ue_save;integer li_selrow, li_error_code
long ll_rowcnt
string ls_partno, ls_orderno, ls_message

dw_mpm220u_02.accepttext()

li_selrow = dw_mpm220u_01.getselectedrow(0)
ls_partno = dw_mpm220u_01.getitemstring(li_selrow,'partno')
ls_orderno = dw_mpm220u_03.getitemstring(1,'orderno')

if dw_mpm220u_02.modifiedcount() < 1 and dw_mpm220u_02.deletedcount() < 1 then
	uo_status.st_message.text = '저장할 데이타가 없습니다.'
	return 0
end if

if f_mpms_mandantory_chk(dw_mpm220u_02) = -1 then
	uo_status.st_message.text = '필수 입력사항이 누락되었습니다.'
	return 0
end if

sqlmpms.Autocommit = False

if dw_mpm220u_02.update() = 1 then
	//*외주가공공순 처리절차
	// Start
	DECLARE actual_recording procedure for sp_mpm220u_05
		@ps_orderno  	= :ls_orderno,
		@ps_partno 		= :ls_partno,
		@ps_empno 		= :g_s_empno,
		@pi_err_code		= :li_error_code	output
	USING	SQLMPMS ;

	EXECUTE actual_recording ;

	FETCH actual_recording
		INTO :li_error_code ;
	CLOSE	actual_recording ;

   if li_error_code <> 0 then
		ls_message = "ERR01"
		goto RollBack_
	end if
else
	ls_message = "ERR02"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

li_selrow = dw_mpm220u_01.find("partno = '" + ls_partno + "'", 1, dw_mpm220u_01.rowcount())
if li_selrow > 0 then
	dw_mpm220u_01.Post Event RowFocusChanged(li_selrow + 1)
	dw_mpm220u_01.scrolltorow(li_selrow + 1)
	dw_mpm220u_01.setrow(li_selrow + 1)
end if

uo_status.st_message.text = '저장되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'ERR01'
		uo_status.st_message.text = "외주공정등록시에 에러가 발생하였습니다."
	case 'ERR02'
		uo_status.st_message.text = "라우팅등록시에 에러가 발생하였습니다."
end choose

return 0
end event

event ue_insert;call super::ue_insert;string ls_partno, ls_outflag
Dec{0} lc_planqty
long ll_selrow, ll_currow

ll_selrow = dw_mpm220u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = '선택된 품번이 없습니다.'
	return 0
end if
ls_partno = dw_mpm220u_01.getitemstring(ll_selrow,'partno')
ls_outflag = dw_mpm220u_01.getitemstring(ll_selrow,'outflag')
lc_planqty = dw_mpm220u_01.getitemnumber(ll_selrow,'planqty')

ll_currow = dw_mpm220u_02.insertrow(0)
dw_mpm220u_02.setitem(ll_currow,'operno', wf_add_operno() )
dw_mpm220u_02.setitem(ll_currow,'partno',ls_partno)
dw_mpm220u_02.setitem(ll_currow,'orderno',uo_1.is_uo_orderno)
dw_mpm220u_02.setitem(ll_currow,'planqty',lc_planqty)
dw_mpm220u_02.setitem(ll_currow,'workstatus','N')
dw_mpm220u_02.setitem(ll_currow,'workstart', f_mpms_get_nowtime() )

if ls_outflag = 'P' then
	dw_mpm220u_02.Modify("outflag.background.color='12632256'")
	dw_mpm220u_02.object.outflag.background.color
	dw_mpm220u_02.object.outflag.protect = 1
	dw_mpm220u_02.setitem( ll_currow, "outflag", 'P' )
else
	dw_mpm220u_02.Modify("outflag.background.color='15780518'")
	dw_mpm220u_02.object.outflag.protect = 0
	dw_mpm220u_02.setitem( ll_currow, "outflag", 'N' )
end if

dw_mpm220u_02.setrow(ll_currow)
dw_mpm220u_02.setcolumn('wccode')
dw_mpm220u_02.setfocus()

end event

event ue_delete;call super::ue_delete;integer li_selrow, li_rtn
string ls_orderno, ls_partno, ls_operno, ls_outstatus

li_selrow = dw_mpm220u_02.getselectedrow(0)

if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

ls_orderno = dw_mpm220u_02.getitemstring(li_selrow,'orderno')
ls_partno  = dw_mpm220u_02.getitemstring(li_selrow,'partno')
ls_operno  = dw_mpm220u_02.getitemstring(li_selrow,'operno')

if wf_delete_chk(ls_orderno,ls_partno,ls_operno) = -1 then
	uo_status.st_message.text = '작업실적이 등록되어 있는 공정입니다.'
	return 0
end if

// 외주공정 체크
SELECT TOP 1 OutStatus INTO :ls_outstatus
FROM TOUTPROCESS aa INNER JOIN TOUTPROCESSDETAIL bb
	ON aa.Orderno = bb.Orderno AND aa.PartNo = bb.PartNo AND
		aa.OutSerial = bb.OutSerial
WHERE bb.OrderNo = :ls_orderno AND bb.PartNo = :ls_partno AND
	bb.OperNo = :ls_operno
using sqlmpms;

If f_spacechk(ls_outstatus) = -1 or ls_outstatus = 'A' then
	// Pass
else
	uo_status.st_message.text = '외주공정작업이 확정상태에 있습니다.'
	return 0
end if

dw_mpm220u_02.deleterow(li_selrow)

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

type uo_status from w_ipis_sheet01`uo_status within w_mpm220u
end type

type uo_1 from u_mpms_select_orderno within w_mpm220u
integer x = 41
integer y = 48
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;
iw_this.Triggerevent('ue_retrieve')
end event

type dw_mpm220u_01 from u_vi_std_datawindow within w_mpm220u
integer x = 27
integer y = 704
integer width = 1221
integer height = 1088
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm220u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_mpms NewMenu
string ls_name, ls_data, ls_type, ls_col_type, ls_ingstatus
str_mpms_parm lstr_1

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

lstr_1.dw_parm[1] = dw_mpm220u_01
Message.PowerObjectParm = lstr_1

ls_ingstatus = dw_mpm220u_03.getitemstring( 1, 'ingstatus' ) 
NewMenu = CREATE m_pop_mpms
//NewMenu.mf_get_dw(this, row, ls_name, ls_data)
//Popup Menu 조정

if ls_ingstatus = 'C' then
	NewMenu.m_action.m_copy.enabled = False
else
	NewMenu.m_action.m_copy.enabled = True
end if
NewMenu.m_action.m_matadd.enabled = False
NewMenu.m_action.m_subadd.enabled = False
NewMenu.m_action.m_modify.enabled = False
NewMenu.m_action.m_wccode.enabled = False
NewMenu.m_action.m_workstatus.enabled = False
NewMenu.m_action.m_outcal.enabled = True

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_partno, ls_outflag

dw_mpm220u_02.reset()

If currentrow < 1 Then
	return 0
End If

this.SelectRow(0,False)
this.SelectRow(currentrow, True)

ls_partno = This.getitemstring( currentrow, 'partno')
ls_outflag = This.getitemstring( currentrow, 'outflag')

dw_mpm220u_02.retrieve( uo_1.is_uo_orderno, ls_partno )

if ls_outflag = 'P' then
	dw_mpm220u_02.Modify("outflag.background.color='12632256'")
	dw_mpm220u_02.object.outflag.background.color
	dw_mpm220u_02.object.outflag.protect = 1
else
	dw_mpm220u_02.Modify("outflag.background.color='15780518'")
	dw_mpm220u_02.object.outflag.protect = 0
end if
end event

type dw_mpm220u_03 from datawindow within w_mpm220u
integer x = 27
integer y = 244
integer width = 3374
integer height = 400
boolean bringtotop = true
string dataobject = "d_mpms_comm_order"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_confirm from commandbutton within w_mpm220u
integer x = 1266
integer y = 56
integer width = 507
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "공정작업요청"
end type

event clicked;integer li_selrow
string ls_orderno, ls_status, ls_message

li_selrow = dw_mpm220u_03.rowcount()
if li_selrow < 1 then
	uo_status.st_message.text = "선택된 데이타가 없습니다."
	return 0
end if

sqlmpms.autocommit = false

ls_orderno = dw_mpm220u_03.getitemstring(1,'orderno')
ls_status = f_mpms_get_orderstatus(ls_orderno)
if ls_status <= '4' then
	if f_mpms_set_orderstatus(ls_orderno, '4') = 0 then
		
		UPDATE TROUTING
			SET WORKSTATUS = 'R'
			WHERE ORDERNO = :ls_orderno AND WORKSTATUS = 'N'
			using sqlmpms;
		
		ls_message = "정상적으로 처리되었습니다."
	else
		ls_message = "처리중에 에러가 발생하였습니다."
		goto RollBack_
	end if
else
	ls_message = "처리를 할 수 없는 상태입니다."
	goto RollBack_
end if

//품목정보 우선순위 배정 SP
DECLARE up_mpms_setpriority_partlist PROCEDURE FOR sp_mpms_setpriority_partlist  
         @ps_orderno = :ls_orderno  using sqlmpms;
Execute up_mpms_setpriority_partlist;

if sqlmpms.sqlcode = -1 then
	ls_message = "품목정보 우선순위 배정 중에 에러가 발생하였습니다. : " + string(sqlmpms.sqlcode)
	goto RollBack_
end if

COMMIT using sqlmpms;
sqlmpms.autocommit = true
iw_this.Triggerevent("ue_retrieve")
uo_status.st_message.text = ls_message
return 0

RollBack_:
ROLLBACK using sqlmpms;
sqlmpms.autocommit = true
uo_status.st_message.text = ls_message

return -1
end event

type dw_report from datawindow within w_mpm220u
boolean visible = false
integer x = 2935
integer y = 20
integer width = 421
integer height = 204
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm310u_05"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mpm220u
integer x = 1906
integer y = 76
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출력물:"
boolean focusrectangle = false
end type

type ddlb_print from dropdownlistbox within w_mpm220u
integer x = 2149
integer y = 60
integer width = 773
integer height = 356
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
string item[] = {"품번별작업지시서","일괄작업지시서","품번별작업지시전표","공정별작업지시전표"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;in_index = index
end event

type cb_print from commandbutton within w_mpm220u
integer x = 3662
integer y = 52
integer width = 247
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "인쇄"
end type

event clicked;integer li_rtn

choose case in_index
	case 1
		li_rtn = wf_each_order()
	case 2
		li_rtn = wf_total_order()
	case 3
		li_rtn = wf_each_voucher()
	case 4
		li_rtn = wf_total_voucher()
	case else
		return 0
end choose

return 0
end event

type uo_2 from u_mpms_select_wccode within w_mpm220u
integer x = 2921
integer y = 64
integer taborder = 60
boolean bringtotop = true
end type

on uo_2.destroy
call u_mpms_select_wccode::destroy
end on

type dw_mpm220u_02 from datawindow within w_mpm220u
event ue_key pbm_dwnkey
integer x = 1280
integer y = 704
integer width = 2121
integer height = 1084
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm220u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;If key = keyenter! Then
	iw_this.Triggerevent("ue_insert")
End If

return 0
end event

event itemchanged;String 	ls_colName, ls_null, ls_wccode, ls_preoperno
String 	ls_orderno, ls_partno, ls_operno, ls_outstatus

this.AcceptText ( )

SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'operno'
		if data = '000' then
			This.setitem( row, 'operno', ls_null )
			return 1
		end if
		if Not Isnumber(data) or len(data) <> 3 then
			This.setitem( row, 'operno', ls_null )
			return 1
		end if
	Case 'stdtime'
		ls_wccode = This.getitemstring( row, 'wccode')
		if ls_wccode = 'THT' then
			if integer(data) <> 0 then
				This.setitem( row, ls_colName, 0 )
				return 1
			end if
		else
			if integer(data) = 0 then
				Messagebox("알림", "예상시간을 입력바랍니다.")
			end if
		end if
	Case 'outflag'
		ls_orderno = This.getitemstring( row, 'orderno')
		ls_partno = This.getitemstring( row, 'partno')
		ls_operno = This.getitemstring( row, 'operno')
		
		// 외주공정 체크
		SELECT TOP 1 OutStatus INTO :ls_outstatus
		FROM TOUTPROCESS aa INNER JOIN TOUTPROCESSDETAIL bb
			ON aa.Orderno = bb.Orderno AND aa.PartNo = bb.PartNo AND
				aa.OutSerial = bb.OutSerial
		WHERE bb.OrderNo = :ls_orderno AND bb.PartNo = :ls_partno AND
			bb.OperNo = :ls_operno
		using sqlmpms;
		
		If f_spacechk(ls_outstatus) = -1 or ls_outstatus = 'A' then
			// Pass
		else
			This.setitem( row, ls_colName, 'P' )
			return 1
		end if
End Choose
end event

event rowfocuschanged;integer li_chk

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
end event

event buttonclicked;long ll_cnt, ll_rowcnt

if dwo.name = 'b_all' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,"outflag",'P')
	next
end if

return 0
end event

type st_3 from statictext within w_mpm220u
integer x = 32
integer y = 184
integer width = 1797
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
string text = "공정복사, 외주가공재계산 => PartNo화면에서 오른쪽 마우스버튼 사용"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_mpm220u
integer x = 27
integer width = 1801
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mpm220u
integer x = 1861
integer width = 2085
integer height = 176
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

