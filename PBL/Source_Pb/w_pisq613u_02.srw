$PBExportHeader$w_pisq613u_02.srw
$PBExportComments$엑셀자료 업로드(보상확정)
forward
global type w_pisq613u_02 from window
end type
type em_1 from editmask within w_pisq613u_02
end type
type cb_close from commandbutton within w_pisq613u_02
end type
type st_11 from statictext within w_pisq613u_02
end type
type cb_create from commandbutton within w_pisq613u_02
end type
type st_7 from statictext within w_pisq613u_02
end type
type sle_1 from singlelineedit within w_pisq613u_02
end type
type cb_1 from commandbutton within w_pisq613u_02
end type
type dw_1 from datawindow within w_pisq613u_02
end type
type uo_1 from uo_progress_bar within w_pisq613u_02
end type
type st_6 from statictext within w_pisq613u_02
end type
type st_5 from statictext within w_pisq613u_02
end type
type st_4 from statictext within w_pisq613u_02
end type
type st_1 from statictext within w_pisq613u_02
end type
type gb_1 from groupbox within w_pisq613u_02
end type
end forward

global type w_pisq613u_02 from window
integer width = 3648
integer height = 1788
boolean titlebar = true
string title = "보상정산 업로드"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
em_1 em_1
cb_close cb_close
st_11 st_11
cb_create cb_create
st_7 st_7
sle_1 sle_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
st_6 st_6
st_5 st_5
st_4 st_4
st_1 st_1
gb_1 gb_1
end type
global w_pisq613u_02 w_pisq613u_02

type variables
string is_manageno, is_custcode, is_exportgubun
end variables

on w_pisq613u_02.create
this.em_1=create em_1
this.cb_close=create cb_close
this.st_11=create st_11
this.cb_create=create cb_create
this.st_7=create st_7
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.em_1,&
this.cb_close,&
this.st_11,&
this.cb_create,&
this.st_7,&
this.sle_1,&
this.cb_1,&
this.dw_1,&
this.uo_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_1,&
this.gb_1}
end on

on w_pisq613u_02.destroy
destroy(this.em_1)
destroy(this.cb_close)
destroy(this.st_11)
destroy(this.cb_create)
destroy(this.st_7)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;datawindowchild ldwc
str_pisqwc_parm lstr

lstr 		= Message.PowerObjectParm
is_manageno = lstr.s_parm[1]
is_custcode = lstr.s_parm[2]
is_exportgubun = lstr.s_parm[3]

dw_1.settransobject(sqleis)
em_1.text = is_manageno

dw_1.GetChild('oagubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS004')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_1,'oagubun',ldwc,'codename',5)

dw_1.GetChild('repaygubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS001')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_1,'repaygubun',ldwc,'codename',5)
end event

type em_1 from editmask within w_pisq613u_02
integer x = 727
integer y = 1292
integer width = 759
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XX-XXXX-XX-XXX"
end type

type cb_close from commandbutton within w_pisq613u_02
integer x = 2171
integer y = 1540
integer width = 398
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(w_pisq613u_02)
end event

type st_11 from statictext within w_pisq613u_02
integer x = 59
integer y = 1308
integer width = 677
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "보상관리번호(확정):"
boolean focusrectangle = false
end type

type cb_create from commandbutton within w_pisq613u_02
integer x = 1714
integer y = 1540
integer width = 398
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;string 	ls_getdate, ls_reasonitemcode, ls_reasonitemname, ls_rtn, ls_manclaimno
string 	ls_areacode, ls_divisioncode, ls_productgroup, ls_oagubun, ls_carcode
integer 	li_seqno, li_rowcnt, li_currow
dec{0}  	lc_qty1, lc_qty2
dec{1}  	lc_weight
dec{2}  	lc_partcost
long 		ll_savecnt, ll_complete, ll_rtn
str_pisqwc_parm lstr

if MessageBox("경고", "해당 보상정산에 대한 정산정보을 삭제합니다. ~r" + &
		"계속하시겠습니까?", Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

setpointer(hourglass!)

dw_1.accepttext()

ll_savecnt = 0
li_rowcnt = dw_1.rowcount()

if li_rowcnt < 1 then
	return 0
end if

for li_currow = 1 to li_rowcnt
	dw_1.SelectRow(0, False)
	dw_1.SelectRow(li_currow, True)	
	dw_1.ScrollToRow(li_currow)
	
	//해당 데이타 체크	
	if is_manageno <> dw_1.getitemstring(li_currow,'manconfirmno') then
		MessageBox("확인", "보상확정번호가 일치하지 않습니다.")
		return 0
	end if
	// 코드 테이블 체크
	ls_manclaimno = dw_1.getitemstring(li_currow,'manclaimno')
	select ingstatus into :ls_rtn from twadminlist
	where manageno = :ls_manclaimno
	using sqleis;
	
	if ls_rtn <> 'D' then
		messagebox("확인","해당 보상청구데이타를 확인바랍니다.")
		return 0
	end if
	
	dw_1.setitem(li_currow,'lastemp',g_s_empno)
	
	ll_complete = li_currow * 100 / li_rowcnt
	if mod(li_currow,5) = 0 then
		uo_1.uf_set_position (ll_complete)
	end if
	ll_savecnt = ll_savecnt + 1
next
	
ll_complete = (li_currow - 1) * 100 / li_rowcnt
uo_1.uf_set_position (ll_complete)
st_7.text = string(ll_savecnt,"###,### ")


sqleis.Autocommit = False

DELETE FROM TWCONFIRMLIST
WHERE manconfirmno = :is_manageno using sqleis;

if dw_1.update() = 1 then
	Commit using sqleis;
	sqleis.Autocommit = True
	
	UPDATE TWADMINLIST
	SET INGSTATUS = 'E'
	WHERE MANAGENO IN (:ls_manclaimno, :is_manageno) using sqleis;
	
	ll_complete = (li_currow - 1) * 100 / li_rowcnt
	uo_1.uf_set_position (ll_complete)
	st_7.text = string(ll_savecnt,"###,### ")

	Messagebox("알림", "정상적으로 처리되었습니다.")
else
	Messagebox("chk",sqleis.sqlerrtext)
	RollBack using sqleis;
	sqleis.Autocommit = True
	
	Messagebox("알림", "처리중에 에러가 발생하였습니다.")
end if
return 0
end event

type st_7 from statictext within w_pisq613u_02
integer x = 1152
integer y = 1552
integer width = 407
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_pisq613u_02
integer x = 384
integer y = 1408
integer width = 1198
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_pisq613u_02
integer x = 59
integer y = 1408
integer width = 302
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료경로"
end type

event clicked;
string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

// UPLOAD할 엑셀파일을 선택한다
//
ll_rtn = GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")
If ll_rtn <> 1 Then
	return -1
end if

setpointer(hourglass!)
// 선택한 엑셀파일을 텍스트 파일로 명을 바꾼다.(test.xls => test.txt)
//
ls_name = Mid(ls_docname, 1, Len(Trim(ls_docname)) -3) + 'txt'

// 선택한 엑셀파일명과 동일한 텍스트 파일명의 존재여부를 체크한다
//
IF FileExists(ls_name) = TRUE THEN
	MessageBox('확 인', '해당변환 파일이 존재합니다')
	RETURN
END IF

// 데이타위도우 초기화
//
dw_1.ReSet()

// 신규 오브젝트 생성
//
lole_UploadObject = CREATE OLEObject

// 엑셀 오브젝트를 연결한다
//
ll_rtn = lole_UploadObject.ConnectToNewObject("excel.application") 

IF ll_rtn = 0 THEN
	// 엑셀에서 선택된 엑셀파일을 오픈한다
	//
	lole_UploadObject.workbooks.Open(ls_docname)
	// 오픈된 엑셀파일을 텍스트 파일로 저장한다(3:text 형태의 저장)
	//
	lole_UploadObject.application.workbooks(1).saveas(ls_name, 3)
	// 오픈된 엑셀파일을 닫는다(저장유무를 확인하지 않는다Close(0))
	//
	lole_UploadObject.application.workbooks(1).close(0)
	// 엑셀 오브젝트의 연결을 해제한다
	//
	lole_UploadObject.DisConnectObject()   
ELSE
	// 엑셀 오브젝트의 연결을 해제한다
	//
	lole_UploadObject.DisConnectObject()   
	//Excel에 연결 실패!
	//
	MessageBox("ConnectToNewObject Error!",string(ll_rtn))
END IF

// 신규 오브젝트를 메모리에서 해제
//
DESTROY lole_UploadObject

// 텍스트 파일로 저장된 대상을 데이타윈도우에 임포트시킨다(타이틀을 제외한 2라인부터)
// 임포트가 완료되면 텍스트 파일을 삭제한다
//
ll_rtn = dw_1.ImportFile(ls_name, 2) 
IF ll_rtn > 0 THEN
	filedelete(ls_name)
ELSE
	// 임포트 ERROR
	//
	CHOOSE CASE ll_rtn
		CASE 0
			MessageBox("확 인", 'End of file; too many rows')
		CASE -1
			MessageBox("확 인", 'No rows')
		CASE -2
			MessageBox("확 인", 'Empty file')
		CASE -3
			MessageBox("확 인", 'Invalid argument')
		CASE -4
			MessageBox("확 인", 'Invalid input')
		CASE -5
			MessageBox("확 인", 'Could not open the file')
		CASE -6
			MessageBox("확 인", 'Could not close the file')
		CASE -7
			MessageBox("확 인", 'Error reading the text')
		CASE -8
			MessageBox("확 인", 'Not a TXT file')
	END CHOOSE
END IF

st_5.text = string(dw_1.rowcount())
sle_1.text = ls_name
end event

type dw_1 from datawindow within w_pisq613u_02
integer x = 37
integer y = 172
integer width = 3543
integer height = 1056
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq613u_uploadconfirm"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type uo_1 from uo_progress_bar within w_pisq613u_02
event destroy ( )
integer x = 1760
integer y = 1352
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_pisq613u_02
integer x = 823
integer y = 1564
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "생성건수"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisq613u_02
integer x = 366
integer y = 1552
integer width = 389
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisq613u_02
integer x = 59
integer y = 1560
integer width = 293
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대상건수"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisq613u_02
integer x = 169
integer y = 60
integer width = 1746
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  보상정산 EXCEL 자료 LOAD  ◎"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisq613u_02
integer x = 1710
integer y = 1264
integer width = 1618
integer height = 256
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[처리상태]"
end type

