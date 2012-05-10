$PBExportHeader$w_tmm220u.srw
$PBExportComments$의뢰서결과입력
forward
global type w_tmm220u from w_ipis_sheet01
end type
type dw_tmm220u_02 from datawindow within w_tmm220u
end type
type dw_report from datawindow within w_tmm220u
end type
type st_1 from statictext within w_tmm220u
end type
type sle_orderno from singlelineedit within w_tmm220u
end type
type cb_complete from commandbutton within w_tmm220u
end type
type st_3 from statictext within w_tmm220u
end type
type sle_dept from singlelineedit within w_tmm220u
end type
type pb_finddept from picturebutton within w_tmm220u
end type
type uo_enddate from u_tmm_date_applydate_1 within w_tmm220u
end type
type uo_tmgubun from u_tmm_select_tmgubun within w_tmm220u
end type
type dw_tmm220u_01 from u_vi_std_datawindow within w_tmm220u
end type
type gb_1 from groupbox within w_tmm220u
end type
end forward

global type w_tmm220u from w_ipis_sheet01
integer width = 3886
integer height = 2136
dw_tmm220u_02 dw_tmm220u_02
dw_report dw_report
st_1 st_1
sle_orderno sle_orderno
cb_complete cb_complete
st_3 st_3
sle_dept sle_dept
pb_finddept pb_finddept
uo_enddate uo_enddate
uo_tmgubun uo_tmgubun
dw_tmm220u_01 dw_tmm220u_01
gb_1 gb_1
end type
global w_tmm220u w_tmm220u

on w_tmm220u.create
int iCurrent
call super::create
this.dw_tmm220u_02=create dw_tmm220u_02
this.dw_report=create dw_report
this.st_1=create st_1
this.sle_orderno=create sle_orderno
this.cb_complete=create cb_complete
this.st_3=create st_3
this.sle_dept=create sle_dept
this.pb_finddept=create pb_finddept
this.uo_enddate=create uo_enddate
this.uo_tmgubun=create uo_tmgubun
this.dw_tmm220u_01=create dw_tmm220u_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tmm220u_02
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_orderno
this.Control[iCurrent+5]=this.cb_complete
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_dept
this.Control[iCurrent+8]=this.pb_finddept
this.Control[iCurrent+9]=this.uo_enddate
this.Control[iCurrent+10]=this.uo_tmgubun
this.Control[iCurrent+11]=this.dw_tmm220u_01
this.Control[iCurrent+12]=this.gb_1
end on

on w_tmm220u.destroy
call super::destroy
destroy(this.dw_tmm220u_02)
destroy(this.dw_report)
destroy(this.st_1)
destroy(this.sle_orderno)
destroy(this.cb_complete)
destroy(this.st_3)
destroy(this.sle_dept)
destroy(this.pb_finddept)
destroy(this.uo_enddate)
destroy(this.uo_tmgubun)
destroy(this.dw_tmm220u_01)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_tmm220u_01.Width = newwidth 	- ( ls_gap * 4 )
dw_tmm220u_01.Height= ( newheight * 3 / 6 ) - dw_tmm220u_01.y

dw_tmm220u_02.x = dw_tmm220u_01.x
dw_tmm220u_02.y = dw_tmm220u_01.y + dw_tmm220u_01.Height + ls_split
dw_tmm220u_02.Width = dw_tmm220u_01.Width
dw_tmm220u_02.Height = newheight - ( dw_tmm220u_01.y + dw_tmm220u_01.Height + ls_split + ls_status)


end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_tmm220u_01.SetTransObject(sqlca)
dw_tmm220u_02.SetTransObject(sqlca)
dw_report.settransobject(sqlca)

dw_tmm220u_01.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('TMM005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

sle_orderno.setfocus()
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_orderno, ls_orderdept, ls_tmgubun

dw_tmm220u_01.reset()
dw_tmm220u_02.reset()

ls_orderno = trim(sle_orderno.text)
ls_orderdept = trim(sle_dept.text)
ls_tmgubun = uo_tmgubun.is_uo_cocode

if f_spacechk(ls_orderdept) <> -1 then
	SELECT COUNT(*) INTO :ll_rowcnt
	FROM "PBCOMMON"."DAC001"  
	WHERE ( "PBCOMMON"."DAC001"."DCODE" = :ls_orderdept ) AND
			( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
			( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
			( "PBCOMMON"."DAC001"."DACTTODT" = 0  )
	using sqlca;
	if ll_rowcnt = 0 then
		uo_status.st_message.text = "의뢰부서가 잘못 입력되었습니다."
		return 0
	end if
else
	ls_orderdept = '%'
end if

if f_spacechk(ls_orderno) = -1 then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if

ll_rowcnt = dw_tmm220u_01.retrieve(ls_orderno, ls_orderdept, ls_tmgubun)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 의뢰정보가 없습니다."
end if
return 0
end event

event ue_insert;call super::ue_insert;string ls_orderno, ls_ingstatus
long ll_selrow, ll_currow

ll_selrow = dw_tmm220u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "결과입력을 위한 대장번호를 선택해 주십시요"
	return 0
end if
ls_orderno = dw_tmm220u_01.getitemstring(ll_selrow,"orderno")
ls_ingstatus = dw_tmm220u_01.getitemstring(ll_selrow,"ingstatus")

ll_currow = dw_tmm220u_02.insertrow(0)

dw_tmm220u_02.setitem( ll_currow, "orderno", ls_orderno )
dw_tmm220u_02.setitem( ll_currow, "lastemp", g_s_empno )
dw_tmm220u_02.setitem( ll_currow, "lastdate", g_s_datetime )

dw_tmm220u_02.setrow(ll_currow)
dw_tmm220u_02.setcolumn("toolid")
dw_tmm220u_02.setfocus()

end event

event ue_save;call super::ue_save;String ls_orderno, ls_tmgubun, ls_error
integer li_findrow, li_selrow

dw_tmm220u_02.accepttext()
if dw_tmm220u_02.modifiedcount() < 1 and dw_tmm220u_02.deletedcount() = 0 then
	uo_status.st_message.text = "저장할 정보가 없습니다."
	return -1
end if

if f_tmm_mandantory_chk(dw_tmm220u_02) = -1 then
	uo_status.st_message.text = "필수입력사항을 입력하십시요."
	return -1
end if

li_selrow = dw_tmm220u_01.getselectedrow(0)
ls_orderno = dw_tmm220u_01.getitemstring(li_selrow,"orderno")

sqlca.AutoCommit = False

if dw_tmm220u_02.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_tmm220u_01.find("orderno = '" + ls_orderno + "'", 1, dw_tmm220u_01.rowcount())
	if li_findrow > 0 then
		dw_tmm220u_01.Post Event RowFocusChanged(li_findrow)
		dw_tmm220u_01.scrolltorow(li_findrow)
		dw_tmm220u_01.setrow(li_findrow)
	end if

	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if

return 0
end event

event ue_delete;call super::ue_delete;//-------------------------------------------------------------
// 금형의뢰건은 진행상태가 의뢰접수인 경우에만 삭제할 수 있다.
//-------------------------------------------------------------
integer li_selrow, li_rtn
string ls_orderno, ls_ingstatus

li_selrow = dw_tmm220u_02.getselectedrow(0)

if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

dw_tmm220u_02.deleterow(li_selrow)
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

type uo_status from w_ipis_sheet01`uo_status within w_tmm220u
end type

type dw_tmm220u_02 from datawindow within w_tmm220u
event ue_key pbm_dwnkey
integer x = 18
integer y = 944
integer width = 3525
integer height = 860
boolean bringtotop = true
string dataobject = "d_tmm220u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;If key = keyenter! Then
	iw_this.Triggerevent("ue_insert")
End If

return 0
end event

event rowfocuschanged;String ls_orderno, ls_tmgubun

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

event itemchanged;String 	ls_colName, ls_sanctionflag, ls_orderno, ls_tmgubun
integer  li_selrow

this.AcceptText ( )
uo_status.st_message.text = ''

ls_colName = dwo.name
Choose Case ls_colName
	Case 'enddate'
		if f_dateedit(data) = space(8) or data > g_s_date then
			uo_status.st_message.text = "날짜형식이 올바르지 않습니다."
			This.Setitem( row, 'enddate', '')
			return 1
		end if
		
		li_selrow = dw_tmm220u_01.getselectedrow(0)
		ls_orderno = dw_tmm220u_01.getitemstring(li_selrow,"orderno")
		ls_tmgubun = dw_tmm220u_01.getitemstring(li_selrow,"tmgubun")

		SELECT Sanctionflag INTO :ls_sanctionflag
		FROM PBGMS.TMM007
		WHERE Workdate = :data AND Tmgubun = :ls_tmgubun
		using sqlca;
		if isnull(ls_sanctionflag) or ls_sanctionflag = 'Y' then
			uo_status.st_message.text = "업무일지가 확정된 확정된 날짜입니다."
			This.Setitem( row, 'enddate', '')
			return 1
		end if
End Choose
end event

event error;// after finished dw Project, Please unComment.
//action = ExceptionIgnore! 
end event

type dw_report from datawindow within w_tmm220u
boolean visible = false
integer x = 2793
integer y = 156
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm120u_03p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_tmm220u
integer x = 933
integer y = 64
integer width = 315
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "접수번호:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_orderno from singlelineedit within w_tmm220u
integer x = 1243
integer y = 44
integer width = 558
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type cb_complete from commandbutton within w_tmm220u
integer x = 2784
integer y = 48
integer width = 530
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "의뢰완료처리"
end type

event clicked;long ll_selrow, ll_rtn
dec{0} lc_sum_fee
string ls_orderno, ls_enddate, ls_tmgubun, ls_signflag

ll_selrow  = dw_tmm220u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "완료할 대장번호를 선택해 주십시요"
	return 0
end if

ls_enddate = string(date(uo_enddate.is_uo_date),"yyyymmdd")
ls_tmgubun = dw_tmm220u_01.getitemstring(ll_selrow,"tmgubun")
ls_orderno = dw_tmm220u_01.getitemstring(ll_selrow,"orderno")

if f_dateedit(ls_enddate) = space(8) then
	uo_status.st_message.text = "완료일이 올바르지 않습니다."
	return 0
end if

SELECT COUNT(*) INTO :ll_rtn
FROM PBGMS.TMM003
WHERE OrderNo = :ls_orderno
using sqlca;

if ll_rtn < 1 then
	uo_status.st_message.text = "등록된 결과값이 하나도 없습니다."
	return 0
end if

if ls_tmgubun = 'T' then
	SELECT Confirmflag INTO :ls_signflag
	FROM PBGMS.TMM007
	WHERE Workdate = :ls_enddate AND Tmgubun = :ls_tmgubun
	using sqlca;
else
	SELECT Sanctionflag INTO :ls_signflag
	FROM PBGMS.TMM007
	WHERE Workdate = :ls_enddate AND Tmgubun = :ls_tmgubun
	using sqlca;
end if

if Not isnull(ls_signflag) and ls_signflag = 'Y' then
	uo_status.st_message.text = "결재가 완료된 날짜입니다."
	return 0
end if
// 대장번호에 대한 수수료 합계 및 완료일을 계산하여 대장에 기록한다.
SELECT SUM(Fee) INTO :lc_sum_fee
FROM PBGMS.TMM003
WHERE OrderNo = :ls_orderno
using sqlca;

ll_rtn = MessageBox("확인", "완료일:" + ls_enddate + ", 수수료합계:" + String(lc_sum_fee,"\#,##0") &
				+ " 로 ~r대장번호 " + ls_orderno + " 를 최종완료처리하시겠습니까?", Exclamation!, OKCancel!, 1)
if ll_rtn = 2 then
	return 0
end if

// PBGMS.TMM002 UPDATE
sqlca.AutoCommit = False

UPDATE PBGMS.TMM002
SET Enddate = :ls_enddate, Ingstatus = 'D'
WHERE OrderNo = :ls_orderno
using sqlca;

if sqlca.sqlnrows > 0 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	iw_this.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if

end event

type st_3 from statictext within w_tmm220u
integer x = 1856
integer y = 68
integer width = 325
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "의뢰부서:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_dept from singlelineedit within w_tmm220u
integer x = 2181
integer y = 48
integer width = 293
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type pb_finddept from picturebutton within w_tmm220u
integer x = 2487
integer y = 40
integer width = 238
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\search.gif"
end type

event clicked;string ls_rtnparm

openwithparm(w_tmm_find_dept,'1')
ls_rtnparm = message.stringparm
if f_spacechk(ls_rtnparm) <> -1 then
	sle_dept.text = ls_rtnparm	
end if	
end event

type uo_enddate from u_tmm_date_applydate_1 within w_tmm220u
integer x = 3323
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_enddate.destroy
call u_tmm_date_applydate_1::destroy
end on

type uo_tmgubun from u_tmm_select_tmgubun within w_tmm220u
integer x = 59
integer y = 48
integer height = 92
integer taborder = 30
boolean bringtotop = true
end type

on uo_tmgubun.destroy
call u_tmm_select_tmgubun::destroy
end on

type dw_tmm220u_01 from u_vi_std_datawindow within w_tmm220u
integer x = 18
integer y = 176
integer width = 3525
integer height = 752
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_tmm220u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno, ls_tmgubun
datawindowchild ldwc

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_orderno = This.getitemstring( currentrow, "orderno")
ls_tmgubun = This.getitemstring( currentrow, "tmgubun")

dw_tmm220u_02.GetChild('toolid', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve(ls_tmgubun)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_tmm220u_02,'toolid',ldwc,'displayname',5)

dw_tmm220u_02.retrieve(ls_orderno)
end event

type gb_1 from groupbox within w_tmm220u
integer x = 18
integer width = 3803
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

