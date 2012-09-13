$PBExportHeader$w_pisq320u.srw
$PBExportComments$EXCEL 자료 UPLOAD
forward
global type w_pisq320u from w_ipis_sheet01
end type
type gb_2 from groupbox within w_pisq320u
end type
type cb_upload from commandbutton within w_pisq320u
end type
type cb_delete from commandbutton within w_pisq320u
end type
type cb_save from commandbutton within w_pisq320u
end type
type dw_pisq320u_02 from u_vi_std_datawindow within w_pisq320u
end type
type st_1 from statictext within w_pisq320u
end type
type st_2 from statictext within w_pisq320u
end type
type sle_manageno from singlelineedit within w_pisq320u
end type
type sle_manageseq from singlelineedit within w_pisq320u
end type
type dw_pisq320u_03 from u_vi_std_datawindow within w_pisq320u
end type
type dw_pisq320u_01 from u_vi_std_datawindow within w_pisq320u
end type
type gb_3 from groupbox within w_pisq320u
end type
end forward

global type w_pisq320u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment 불량현황(품번별)"
gb_2 gb_2
cb_upload cb_upload
cb_delete cb_delete
cb_save cb_save
dw_pisq320u_02 dw_pisq320u_02
st_1 st_1
st_2 st_2
sle_manageno sle_manageno
sle_manageseq sle_manageseq
dw_pisq320u_03 dw_pisq320u_03
dw_pisq320u_01 dw_pisq320u_01
gb_3 gb_3
end type
global w_pisq320u w_pisq320u

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open

end variables

on w_pisq320u.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.cb_upload=create cb_upload
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.dw_pisq320u_02=create dw_pisq320u_02
this.st_1=create st_1
this.st_2=create st_2
this.sle_manageno=create sle_manageno
this.sle_manageseq=create sle_manageseq
this.dw_pisq320u_03=create dw_pisq320u_03
this.dw_pisq320u_01=create dw_pisq320u_01
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.cb_upload
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_pisq320u_02
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.sle_manageno
this.Control[iCurrent+9]=this.sle_manageseq
this.Control[iCurrent+10]=this.dw_pisq320u_03
this.Control[iCurrent+11]=this.dw_pisq320u_01
this.Control[iCurrent+12]=this.gb_3
end on

on w_pisq320u.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.cb_upload)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.dw_pisq320u_02)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_manageno)
destroy(this.sle_manageseq)
destroy(this.dw_pisq320u_03)
destroy(this.dw_pisq320u_01)
destroy(this.gb_3)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq290i_01, FULL)
//
//of_resize()
//
end event

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq320u_01.SetTransObject(SQLEIS)
dw_pisq320u_03.SetTransObject(SQLEIS)

end event

event ue_save;call super::ue_save;
Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq320u_03.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
END IF



end event

event ue_retrieve;call super::ue_retrieve;
String	ls_manageno, ls_manageseq

ls_manageno		= sle_manageno.Text
ls_manageseq	= sle_manageseq.Text

dw_pisq320u_03.Visible = TRUE

dw_pisq320u_03.ReTrieve(ls_manageno, Long(ls_manageseq))

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if
end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq320u
integer x = 18
integer y = 2592
integer width = 3598
end type

type gb_2 from groupbox within w_pisq320u
integer x = 18
integer y = 12
integer width = 4590
integer height = 220
integer taborder = 80
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type cb_upload from commandbutton within w_pisq320u
integer x = 2354
integer y = 60
integer width = 713
integer height = 140
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "UPLOAD 대상 선택"
end type

event clicked;
string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

dw_pisq320u_01.Visible = TRUE

// UPLOAD할 엑셀파일을 선택한다
//
GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")

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
dw_pisq320u_01.ReSet()

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
ll_rtn = dw_pisq320u_01.ImportFile(ls_name, 2) 
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


end event

type cb_delete from commandbutton within w_pisq320u
integer x = 3854
integer y = 60
integer width = 713
integer height = 140
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "UPLOAD 자료 삭제"
end type

event clicked;
dw_pisq320u_02.Visible = TRUE
dw_pisq320u_02.ReSet()
dw_pisq320u_02.InsertRow(0)

cb_save.Enabled	= FALSE
cb_upload.Enabled = FALSE

end event

type cb_save from commandbutton within w_pisq320u
integer x = 3104
integer y = 60
integer width = 713
integer height = 140
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "UPLOAD 대상 저장"
end type

event clicked;
Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq320u_01.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
END IF



end event

type dw_pisq320u_02 from u_vi_std_datawindow within w_pisq320u
boolean visible = false
integer x = 1591
integer y = 984
integer width = 1440
integer height = 484
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq320u_02"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;String	ls_buttonname
String	ls_manageno
Long		ll_mseqfm,  ll_mseqto

This.AcceptText()

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	// 삭제
	//
	CASE 'b_del'
		IF MessageBox('확 인', '삭제 하시겠습니까?', Exclamation!, YesNo!, 2) = 2 THEN
			RETURN
		END IF 

		ls_manageno = This.GetItemString(1,  'manageno')
		ll_mseqfm	= This.GetItemNumber(1,  'mseqfm')
		ll_mseqto	= This.GetItemNumber(1,  'mseqto')

		// AUTO COMMIT을 FASLE로 지정
		//
		SQLEIS.AUTOCommit = FALSE
		
		DELETE FROM TQMANAGEMASTER  
		 WHERE MANAGENO	 = :ls_manageno
			AND MANAGESEQ	>= :ll_mseqfm
			AND MANAGESEQ	<= :ll_mseqto
		 USING SQLEIS;

		IF SQLEIS.SQLCode = 0 THEN
			COMMIT USING SQLEIS;			// Commit 처리
			MessageBox('확 인', '삭제되었습니다')
		ELSE 
			RollBack using SQLEIS ;		// RollBack 처리
			MessageBox('확 인', '삭제 처리에 실패했습니다')
		END IF
		SQLPIS.AUTOCommit = TRUE

	// 종료
	//
	CASE 'b_exit'
			dw_pisq320u_02.ReSet()
			dw_pisq320u_02.Visible = FALSE
			cb_save.Enabled 	= TRUE
			cb_delete.Enabled = TRUE
			cb_upload.Enabled = TRUE
END CHOOSE



end event

event clicked;//
end event

event rowfocuschanged;// 
end event

type st_1 from statictext within w_pisq320u
integer x = 82
integer y = 104
integer width = 398
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "보상관리번호"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisq320u
integer x = 1029
integer y = 104
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "일련번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_manageno from singlelineedit within w_pisq320u
integer x = 480
integer y = 88
integer width = 457
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 14
borderstyle borderstyle = stylelowered!
end type

type sle_manageseq from singlelineedit within w_pisq320u
integer x = 1330
integer y = 84
integer width = 457
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type dw_pisq320u_03 from u_vi_std_datawindow within w_pisq320u
integer x = 41
integer y = 268
integer width = 4539
integer height = 2284
integer taborder = 80
string dataobject = "d_pisq320u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;//
end event

event rowfocuschanged;//
end event

type dw_pisq320u_01 from u_vi_std_datawindow within w_pisq320u
integer x = 41
integer y = 268
integer width = 4539
integer height = 2284
integer taborder = 70
string dataobject = "d_pisq320u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_3 from groupbox within w_pisq320u
integer x = 18
integer y = 240
integer width = 4590
integer height = 2336
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

