$PBExportHeader$w_mpm340u.srw
$PBExportComments$작업일지관리
forward
global type w_mpm340u from w_ipis_sheet01
end type
type st_1 from statictext within w_mpm340u
end type
type rb_assem from radiobutton within w_mpm340u
end type
type rb_cut from radiobutton within w_mpm340u
end type
type uo_applydate from u_mpms_date_applydate within w_mpm340u
end type
type dw_mpm340u_01 from datawindow within w_mpm340u
end type
type dw_mpm340u_02 from datawindow within w_mpm340u
end type
type st_2 from statictext within w_mpm340u
end type
type cb_confirmok from commandbutton within w_mpm340u
end type
type cb_confirmcancel from commandbutton within w_mpm340u
end type
type st_3 from statictext within w_mpm340u
end type
type cb_sanctioncancel from commandbutton within w_mpm340u
end type
type cb_sanctionok from commandbutton within w_mpm340u
end type
type gb_1 from groupbox within w_mpm340u
end type
type gb_2 from groupbox within w_mpm340u
end type
type gb_3 from groupbox within w_mpm340u
end type
end forward

global type w_mpm340u from w_ipis_sheet01
st_1 st_1
rb_assem rb_assem
rb_cut rb_cut
uo_applydate uo_applydate
dw_mpm340u_01 dw_mpm340u_01
dw_mpm340u_02 dw_mpm340u_02
st_2 st_2
cb_confirmok cb_confirmok
cb_confirmcancel cb_confirmcancel
st_3 st_3
cb_sanctioncancel cb_sanctioncancel
cb_sanctionok cb_sanctionok
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_mpm340u w_mpm340u

on w_mpm340u.create
int iCurrent
call super::create
this.st_1=create st_1
this.rb_assem=create rb_assem
this.rb_cut=create rb_cut
this.uo_applydate=create uo_applydate
this.dw_mpm340u_01=create dw_mpm340u_01
this.dw_mpm340u_02=create dw_mpm340u_02
this.st_2=create st_2
this.cb_confirmok=create cb_confirmok
this.cb_confirmcancel=create cb_confirmcancel
this.st_3=create st_3
this.cb_sanctioncancel=create cb_sanctioncancel
this.cb_sanctionok=create cb_sanctionok
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.rb_assem
this.Control[iCurrent+3]=this.rb_cut
this.Control[iCurrent+4]=this.uo_applydate
this.Control[iCurrent+5]=this.dw_mpm340u_01
this.Control[iCurrent+6]=this.dw_mpm340u_02
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_confirmok
this.Control[iCurrent+9]=this.cb_confirmcancel
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.cb_sanctioncancel
this.Control[iCurrent+12]=this.cb_sanctionok
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_3
end on

on w_mpm340u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.rb_assem)
destroy(this.rb_cut)
destroy(this.uo_applydate)
destroy(this.dw_mpm340u_01)
destroy(this.dw_mpm340u_02)
destroy(this.st_2)
destroy(this.cb_confirmok)
destroy(this.cb_confirmcancel)
destroy(this.st_3)
destroy(this.cb_sanctioncancel)
destroy(this.cb_sanctionok)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm340u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm340u_01.Height= ( newheight * 2 / 5 ) - ls_split

dw_mpm340u_02.x = dw_mpm340u_01.x
dw_mpm340u_02.y = dw_mpm340u_01.y + dw_mpm340u_01.Height + ls_split
dw_mpm340u_02.Width = dw_mpm340u_01.Width
dw_mpm340u_02.Height = newheight - (dw_mpm340u_01.y + dw_mpm340u_01.Height + ls_split + ls_status)
end event

event ue_postopen;call super::ue_postopen;dw_mpm340u_01.settransobject(sqlmpms)
dw_mpm340u_02.settransobject(sqlmpms)

This.Triggerevent("ue_retrieve")

end event

event ue_retrieve;call super::ue_retrieve;string ls_workdate, ls_workgubun

ls_workdate = uo_applydate.is_uo_date

if ls_workdate >= string(g_s_date,"@@@@.@@.@@") then
	uo_status.st_message.text = "기준일은 금일보다 적어야 합니다."
	return 0
end if

if rb_assem.checked then
	ls_workgubun = 'A'
else
	ls_workgubun = 'M'
end if

dw_mpm340u_01.reset()
dw_mpm340u_02.reset()
dw_mpm340u_01.retrieve(ls_workgubun,ls_workdate)
dw_mpm340u_02.retrieve(ls_workgubun,ls_workdate)
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= True
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_save;call super::ue_save;string ls_workdate, ls_message

if dw_mpm340u_01.rowcount() < 1 then
	return 0
end if

sqlmpms.Autocommit = False

if dw_mpm340u_01.update() <> 1 then
	Rollback using sqlmpms;
	sqlmpms.Autocommit = True
	uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'
else
	Commit using sqlmpms;
	sqlmpms.Autocommit = True		
	uo_status.st_message.text = '정상적으로 처리되었습니다.'
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm340u
end type

type st_1 from statictext within w_mpm340u
integer x = 50
integer y = 76
integer width = 302
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "조구분:"
alignment alignment = center!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type rb_assem from radiobutton within w_mpm340u
integer x = 334
integer y = 64
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조립조"
end type

type rb_cut from radiobutton within w_mpm340u
integer x = 686
integer y = 64
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "가공조"
end type

type uo_applydate from u_mpms_date_applydate within w_mpm340u
integer x = 1083
integer y = 68
integer taborder = 60
boolean bringtotop = true
end type

on uo_applydate.destroy
call u_mpms_date_applydate::destroy
end on

event constructor;call super::constructor;string ls_postdate

ls_postdate = string(f_relativedate( g_s_date, -1),'@@@@-@@-@@')
This.id_uo_date = date( ls_postdate )
This.is_uo_date = string(f_relativedate( g_s_date, -1),'@@@@.@@.@@')
This.init_cal( date( ls_postdate ) )
This.set_date_format ('yyyy.mm.dd')
end event

type dw_mpm340u_01 from datawindow within w_mpm340u
integer x = 14
integer y = 196
integer width = 3150
integer height = 840
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm340u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;if rowcount = 1 then
	if This.getitemstring(1,"confirmflag") = 'N' then
		cb_confirmok.visible = true
		cb_confirmok.enabled = true
		cb_confirmcancel.visible = false
		cb_confirmcancel.enabled = false
		cb_sanctionok.visible = true
		cb_sanctionok.enabled = false
		cb_sanctioncancel.visible = false
		cb_sanctioncancel.enabled = false
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true,  false,  True,  false,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
	else
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true,  false,  false,  false,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
		if This.getitemstring(1,"sanctionflag") = 'N' then
			cb_confirmok.visible = false
			cb_confirmok.enabled = false
			cb_confirmcancel.visible = true
			cb_confirmcancel.enabled = true
			cb_sanctionok.visible = true
			cb_sanctionok.enabled = true
			cb_sanctioncancel.visible = false
			cb_sanctioncancel.enabled = false
		else
			cb_confirmok.visible = true
			cb_confirmok.enabled = false
			cb_confirmcancel.visible = false
			cb_confirmcancel.enabled = false
			cb_sanctionok.visible = false
			cb_sanctionok.enabled = false
			cb_sanctioncancel.visible = true
			cb_sanctioncancel.enabled = true
		end if
	end if
end if
end event

type dw_mpm340u_02 from datawindow within w_mpm340u
integer x = 14
integer y = 1052
integer width = 3150
integer height = 816
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm340u_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mpm340u
integer x = 1879
integer y = 76
integer width = 370
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "조장결재:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_confirmok from commandbutton within w_mpm340u
integer x = 2245
integer y = 56
integer width = 398
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재"
end type

event clicked;string ls_workdate, ls_message

if dw_mpm340u_01.rowcount() < 1 then
	return 0
else
	ls_workdate = dw_mpm340u_01.getitemstring(1,"workdate")
end if

sqlmpms.Autocommit = False

UPDATE TWORKREPORT
SET ConfirmFlag = 'Y',
	ConfirmEmp = :g_s_empno,
	LastDate = getdate()
WHERE WorkDate = :ls_workdate
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = 'save_err'
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'

return 0
end event

type cb_confirmcancel from commandbutton within w_mpm340u
integer x = 2245
integer y = 56
integer width = 398
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;string ls_workdate, ls_message

if dw_mpm340u_01.rowcount() < 1 then
	return 0
else
	ls_workdate = dw_mpm340u_01.getitemstring(1,"workdate")
end if

sqlmpms.Autocommit = False

UPDATE TWORKREPORT
SET ConfirmFlag = 'N',
	ConfirmEmp = :g_s_empno,
	LastDate = getdate()
WHERE WorkDate = :ls_workdate
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = 'save_err'
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'

return 0
end event

type st_3 from statictext within w_mpm340u
integer x = 2757
integer y = 76
integer width = 370
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "직장결재:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_sanctioncancel from commandbutton within w_mpm340u
integer x = 3131
integer y = 56
integer width = 398
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;string ls_workdate, ls_message

if dw_mpm340u_01.rowcount() < 1 then
	return 0
else
	ls_workdate = dw_mpm340u_01.getitemstring(1,"workdate")
end if

sqlmpms.Autocommit = False

UPDATE TWORKREPORT
SET SanctionFlag = 'N',
	SanctionEmp = :g_s_empno,
	LastDate = getdate()
WHERE WorkDate = :ls_workdate
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = 'save_err'
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'

return 0
end event

type cb_sanctionok from commandbutton within w_mpm340u
integer x = 3131
integer y = 56
integer width = 398
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재"
end type

event clicked;string ls_workdate, ls_message

if dw_mpm340u_01.rowcount() < 1 then
	return 0
else
	ls_workdate = dw_mpm340u_01.getitemstring(1,"workdate")
end if

sqlmpms.Autocommit = False

UPDATE TWORKREPORT
SET SanctionFlag = 'Y',
	SanctionEmp = :g_s_empno,
	LastDate = getdate()
WHERE WorkDate = :ls_workdate
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = 'save_err'
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'

return 0
end event

type gb_1 from groupbox within w_mpm340u
integer x = 23
integer width = 1810
integer height = 180
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_mpm340u
integer x = 1847
integer width = 864
integer height = 180
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_mpm340u
integer x = 2725
integer width = 864
integer height = 180
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

