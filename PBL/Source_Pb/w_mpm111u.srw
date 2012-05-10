$PBExportHeader$w_mpm111u.srw
$PBExportComments$W/C장비정보
forward
global type w_mpm111u from w_ipis_sheet01
end type
type dw_mpm111u_01 from u_vi_std_datawindow within w_mpm111u
end type
type dw_mpm111u_02 from u_vi_std_datawindow within w_mpm111u
end type
type dw_mpm111u_03 from datawindow within w_mpm111u
end type
type dw_mpm111u_04 from datawindow within w_mpm111u
end type
type cb_w_insert from commandbutton within w_mpm111u
end type
type cb_w_delete from commandbutton within w_mpm111u
end type
type cb_m_insert from commandbutton within w_mpm111u
end type
type cb_m_delete from commandbutton within w_mpm111u
end type
type cb_w_save from commandbutton within w_mpm111u
end type
type cb_m_save from commandbutton within w_mpm111u
end type
type st_1 from statictext within w_mpm111u
end type
type gb_1 from groupbox within w_mpm111u
end type
type gb_2 from groupbox within w_mpm111u
end type
end forward

global type w_mpm111u from w_ipis_sheet01
dw_mpm111u_01 dw_mpm111u_01
dw_mpm111u_02 dw_mpm111u_02
dw_mpm111u_03 dw_mpm111u_03
dw_mpm111u_04 dw_mpm111u_04
cb_w_insert cb_w_insert
cb_w_delete cb_w_delete
cb_m_insert cb_m_insert
cb_m_delete cb_m_delete
cb_w_save cb_w_save
cb_m_save cb_m_save
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_mpm111u w_mpm111u

on w_mpm111u.create
int iCurrent
call super::create
this.dw_mpm111u_01=create dw_mpm111u_01
this.dw_mpm111u_02=create dw_mpm111u_02
this.dw_mpm111u_03=create dw_mpm111u_03
this.dw_mpm111u_04=create dw_mpm111u_04
this.cb_w_insert=create cb_w_insert
this.cb_w_delete=create cb_w_delete
this.cb_m_insert=create cb_m_insert
this.cb_m_delete=create cb_m_delete
this.cb_w_save=create cb_w_save
this.cb_m_save=create cb_m_save
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm111u_01
this.Control[iCurrent+2]=this.dw_mpm111u_02
this.Control[iCurrent+3]=this.dw_mpm111u_03
this.Control[iCurrent+4]=this.dw_mpm111u_04
this.Control[iCurrent+5]=this.cb_w_insert
this.Control[iCurrent+6]=this.cb_w_delete
this.Control[iCurrent+7]=this.cb_m_insert
this.Control[iCurrent+8]=this.cb_m_delete
this.Control[iCurrent+9]=this.cb_w_save
this.Control[iCurrent+10]=this.cb_m_save
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_mpm111u.destroy
call super::destroy
destroy(this.dw_mpm111u_01)
destroy(this.dw_mpm111u_02)
destroy(this.dw_mpm111u_03)
destroy(this.dw_mpm111u_04)
destroy(this.cb_w_insert)
destroy(this.cb_w_delete)
destroy(this.cb_m_insert)
destroy(this.cb_m_delete)
destroy(this.cb_w_save)
destroy(this.cb_m_save)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

gb_1.Width = (newwidth * 2 / 5) - (ls_split * 2)
gb_1.Height = newheight - (ls_status + gb_1.y)

gb_2.x = gb_1.x + gb_1.Width + ls_split
gb_2.y = gb_1.y
gb_2.Width = (newwidth * 3 / 5) - ls_split
gb_2.Height = gb_1.Height

dw_mpm111u_01.Width = gb_1.Width	- (ls_split * 2)
dw_mpm111u_01.Height= (gb_1.Height * 2 / 3) - (ls_split + ls_status)

dw_mpm111u_03.x = dw_mpm111u_01.x
dw_mpm111u_03.y = dw_mpm111u_01.y + dw_mpm111u_01.Height + (ls_status * 2)
dw_mpm111u_03.Width = dw_mpm111u_01.Width
dw_mpm111u_03.Height = gb_1.Height - dw_mpm111u_03.y + 100

cb_w_insert.x = dw_mpm111u_03.x + 150
cb_w_insert.y = dw_mpm111u_03.y - 120

cb_w_save.x = cb_w_insert.x + cb_w_insert.width + 120
cb_w_save.y = cb_w_insert.y

cb_w_delete.x = cb_w_save.x + cb_w_save.width + 120
cb_w_delete.y = cb_w_insert.y

dw_mpm111u_02.x = gb_2.x + ls_split
dw_mpm111u_02.y = dw_mpm111u_01.y
dw_mpm111u_02.Width = gb_2.Width	- (ls_split * 2)
dw_mpm111u_02.Height= dw_mpm111u_01.Height

dw_mpm111u_04.x = dw_mpm111u_02.x
dw_mpm111u_04.y = dw_mpm111u_03.y
dw_mpm111u_04.Width = dw_mpm111u_02.Width
dw_mpm111u_04.Height = dw_mpm111u_03.Height

cb_m_insert.x = dw_mpm111u_04.x + 150
cb_m_insert.y = dw_mpm111u_04.y - 120

cb_m_save.x = cb_m_insert.x + cb_m_insert.width + 120
cb_m_save.y = cb_m_insert.y

cb_m_delete.x = cb_m_save.x + cb_m_save.width + 120
cb_m_delete.y = cb_m_insert.y

end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_mpm111u_01.SetTransObject(sqlmpms)
dw_mpm111u_02.SetTransObject(sqlmpms)
dw_mpm111u_03.SetTransObject(sqlmpms)
dw_mpm111u_04.SetTransObject(sqlmpms)

dw_mpm111u_03.GetChild('wgcode', ldwc)
f_pisc_set_dddw_width(dw_mpm111u_03,'wgcode',ldwc,'wgname',16)

dw_mpm111u_01.GetChild('wcgubun', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM001')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm111u_01,'wcgubun',ldwc,'codename',5)

This.Triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;integer li_rowcnt
string ls_wccode

dw_mpm111u_01.reset()
dw_mpm111u_02.reset()
dw_mpm111u_03.reset()
dw_mpm111u_04.reset()

li_rowcnt = dw_mpm111u_01.retrieve()
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm111u
end type

type dw_mpm111u_01 from u_vi_std_datawindow within w_mpm111u
integer x = 41
integer y = 268
integer width = 1467
integer height = 912
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm111u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_wccode

if currentrow < 1 then
	return -1
end if

dw_mpm111u_02.reset()
dw_mpm111u_03.reset()

This.selectrow( 0, False )
This.selectrow( currentrow, True )

ls_wccode = This.getitemstring(currentrow,"wccode")

dw_mpm111u_02.retrieve(ls_wccode)
dw_mpm111u_03.retrieve(ls_wccode)

dw_mpm111u_03.object.wccode.protect = 1
dw_mpm111u_03.setcolumn('wcname')
dw_mpm111u_03.setfocus()
end event

type dw_mpm111u_02 from u_vi_std_datawindow within w_mpm111u
integer x = 1673
integer y = 268
integer width = 1701
integer height = 912
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm111u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_wccode, ls_mchno

if currentrow < 1 then
	return -1
end if

This.selectrow( 0, False )
This.selectrow( currentrow, True )

ls_wccode = This.getitemstring(currentrow,"wccode")
ls_mchno  = This.getitemstring(currentrow,"mchno")

dw_mpm111u_04.retrieve(ls_wccode, ls_mchno)

dw_mpm111u_04.object.mchno.protect = 1
dw_mpm111u_04.setcolumn('mchname')
dw_mpm111u_04.setfocus()

end event

type dw_mpm111u_03 from datawindow within w_mpm111u
integer x = 41
integer y = 1340
integer width = 1467
integer height = 512
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm111u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mpm111u_04 from datawindow within w_mpm111u
integer x = 1673
integer y = 1340
integer width = 1701
integer height = 512
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm111u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_w_insert from commandbutton within w_mpm111u
integer x = 64
integer y = 1220
integer width = 320
integer height = 92
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "입력"
end type

event clicked;
dw_mpm111u_03.reset()
dw_mpm111u_03.insertrow(0)

dw_mpm111u_03.object.wccode.protect = 0

dw_mpm111u_03.setcolumn('wccode')
dw_mpm111u_03.setfocus()
end event

type cb_w_delete from commandbutton within w_mpm111u
integer x = 887
integer y = 1220
integer width = 320
integer height = 92
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "삭제"
end type

event clicked;int    li_rtn, li_totcnt, li_selrow
string ls_wccode

li_selrow = dw_mpm111u_01.getselectedrow(0)
if li_selrow < 1 then
	Messagebox("알림", "삭제할 W/C 코드를 선택바랍니다.")
	return -1
end if

ls_wccode = dw_mpm111u_03.getitemstring( 1, "wccode")

li_rtn = MessageBox("확인", ls_wccode + " W/C를 삭제하시겠습니까?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return -1
end if
// 해당업체에서 의뢰건이 접수된 적이 있는지 여부
SELECT COUNT(*) INTO :li_totcnt FROM TMACHINE
WHERE WCCODE = :ls_wccode using sqlmpms;

if li_totcnt > 0 then
	uo_status.st_message.text = "해당W/C로 장비가 등록되어 있습니다."
	return -1
end if

sqlmpms.Autocommit = False

DELETE FROM TWORKCENTER
WHERE WCCODE = :ls_wccode using sqlmpms;

if sqlmpms.sqlcode = 0 then
	Commit using sqlmpms;
	sqlmpms.Autocommit = True
	Parent.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "삭제되었습니다."
else
	Rollback using sqlmpms;
	sqlmpms.Autocommit = True
	uo_status.st_message.text = "삭제시에 에러가 발생하였습니다."
end if

end event

type cb_m_insert from commandbutton within w_mpm111u
integer x = 1687
integer y = 1216
integer width = 320
integer height = 92
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "입력"
end type

event clicked;integer li_selrow
string ls_wccode

li_selrow = dw_mpm111u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "선택된 W/C가 없습니다."
	return -1
end if
ls_wccode = dw_mpm111u_01.getitemstring(li_selrow,'wccode')

dw_mpm111u_04.reset()
dw_mpm111u_04.insertrow(0)
dw_mpm111u_04.object.mchno.protect = 0
dw_mpm111u_04.setitem(1, 'wccode', ls_wccode)
dw_mpm111u_04.setcolumn('mchno')
dw_mpm111u_04.setfocus()
end event

type cb_m_delete from commandbutton within w_mpm111u
integer x = 2601
integer y = 1216
integer width = 320
integer height = 92
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "삭제"
end type

event clicked;int    li_rtn, li_totcnt, li_selrow
string ls_wccode, ls_mchno

uo_status.st_message.text = ""
li_selrow = dw_mpm111u_02.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 Machine 코드를 선택바랍니다."
	return -1
end if

ls_wccode = dw_mpm111u_04.getitemstring( 1, "wccode")
ls_mchno = dw_mpm111u_04.getitemstring( 1, "mchno")

SELECT COUNT(*) INTO :li_rtn
FROM TWORKJOB
WHERE WCCODE = :ls_wccode AND MCHNO = :ls_mchno
using sqlmpms;

if li_rtn > 0 then
	uo_status.st_message.text = "해당장비의 사용내역이 존재합니다."
	return 0
end if

li_rtn = MessageBox("확인", ls_wccode + " Mchine를 삭제하시겠습니까?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return -1
end if

sqlmpms.Autocommit = False

DELETE FROM TMACHINE
WHERE WCCODE = :ls_wccode AND MCHNO = :ls_mchno using sqlmpms;

if sqlmpms.sqlcode = 0 then
	Commit using sqlmpms;
	sqlmpms.Autocommit = True
//	Parent.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "삭제되었습니다."
else
	Rollback using sqlmpms;
	sqlmpms.Autocommit = True
	uo_status.st_message.text = "삭제시에 에러가 발생하였습니다."
end if

end event

type cb_w_save from commandbutton within w_mpm111u
integer x = 475
integer y = 1220
integer width = 320
integer height = 92
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;integer li_findrow
string ls_wccode

dw_mpm111u_03.accepttext()

if f_mpms_mandantory_chk(dw_mpm111u_03) = -1 then
	uo_status.st_message.text = "필수입력사항을 누락되었습니다."
	return -1
end if

ls_wccode = dw_mpm111u_03.getitemstring(1, 'wccode')
sqlmpms.AutoCommit = False

if dw_mpm111u_03.update() = 1 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	Parent.Triggerevent("ue_retrieve")
	li_findrow = dw_mpm111u_01.find("wccode = '" + ls_wccode + "'", 1, dw_mpm111u_01.rowcount())
	if li_findrow > 0 then
		dw_mpm111u_01.Post Event RowFocusChanged(li_findrow)
		dw_mpm111u_01.scrolltorow(li_findrow)
		dw_mpm111u_01.setrow(li_findrow)
	end if
	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if
end event

type cb_m_save from commandbutton within w_mpm111u
integer x = 2144
integer y = 1216
integer width = 320
integer height = 92
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;integer li_findrow
string ls_wccode, ls_mchno

dw_mpm111u_04.accepttext()

if f_mpms_mandantory_chk(dw_mpm111u_04) = -1 then
	uo_status.st_message.text = "필수입력사항을 누락되었습니다."
	return -1
end if

ls_wccode = dw_mpm111u_04.getitemstring(1, 'wccode')
ls_mchno = dw_mpm111u_04.getitemstring(1, 'mchno')
sqlmpms.AutoCommit = False

if dw_mpm111u_04.update() = 1 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
//	Parent.Triggerevent("ue_retrieve")
//	li_findrow = dw_mpm111u_01.find("wccode = '" + ls_wccode + "'", 1, dw_mpm111u_01.rowcount())
//	if li_findrow > 0 then
//		dw_mpm111u_01.Post Event RowFocusChanged(li_findrow)
//		dw_mpm111u_01.scrolltorow(li_findrow)
//		dw_mpm111u_01.setrow(li_findrow)
//	end if
	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if
end event

type st_1 from statictext within w_mpm111u
integer x = 46
integer y = 56
integer width = 2528
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "알림 : W/C Code를 추가 및 삭제할 경우에는 시스템개발팀으로 연락바랍니다."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_mpm111u
integer x = 23
integer y = 152
integer width = 1531
integer height = 1736
integer taborder = 21
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "WorkCenter 정보"
end type

type gb_2 from groupbox within w_mpm111u
integer x = 1586
integer y = 152
integer width = 1911
integer height = 1736
integer taborder = 31
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "W/C별 장비정보"
end type

