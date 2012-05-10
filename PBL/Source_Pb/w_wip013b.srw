$PBExportHeader$w_wip013b.srw
$PBExportComments$엑셀자료 업로드
forward
global type w_wip013b from window
end type
type st_12 from statictext within w_wip013b
end type
type st_11 from statictext within w_wip013b
end type
type st_10 from statictext within w_wip013b
end type
type st_9 from statictext within w_wip013b
end type
type st_8 from statictext within w_wip013b
end type
type dw_2 from datawindow within w_wip013b
end type
type cb_create from commandbutton within w_wip013b
end type
type st_7 from statictext within w_wip013b
end type
type sle_1 from singlelineedit within w_wip013b
end type
type cb_1 from commandbutton within w_wip013b
end type
type dw_1 from datawindow within w_wip013b
end type
type uo_1 from uo_progress_bar within w_wip013b
end type
type st_6 from statictext within w_wip013b
end type
type st_5 from statictext within w_wip013b
end type
type st_4 from statictext within w_wip013b
end type
type st_3 from statictext within w_wip013b
end type
type st_2 from statictext within w_wip013b
end type
type st_1 from statictext within w_wip013b
end type
type gb_1 from groupbox within w_wip013b
end type
type gb_2 from groupbox within w_wip013b
end type
end forward

global type w_wip013b from window
integer width = 4251
integer height = 2284
boolean titlebar = true
string title = "엑셀자료업로드"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
dw_2 dw_2
cb_create cb_create
st_7 st_7
sle_1 sle_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_wip013b w_wip013b

on w_wip013b.create
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.dw_2=create dw_2
this.cb_create=create cb_create
this.st_7=create st_7
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.dw_2,&
this.cb_create,&
this.st_7,&
this.sle_1,&
this.cb_1,&
this.dw_1,&
this.uo_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1,&
this.gb_2}
end on

on w_wip013b.destroy
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.dw_2)
destroy(this.cb_create)
destroy(this.st_7)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;st_12.text = mid(g_s_date,1,6)
end event

type st_12 from statictext within w_wip013b
integer x = 2459
integer y = 52
integer width = 462
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_11 from statictext within w_wip013b
integer x = 2149
integer y = 68
integer width = 338
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "적용년월:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_wip013b
integer x = 2158
integer y = 244
integer width = 1774
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "두번째라인 - 지역, 공장, 업체코드, 품번, Loss율, 반납율"
boolean focusrectangle = false
end type

type st_9 from statictext within w_wip013b
integer x = 2162
integer y = 172
integer width = 1783
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "엑셀파일형식 : 첫번째라인 - 제목"
boolean focusrectangle = false
end type

type st_8 from statictext within w_wip013b
integer x = 2112
integer y = 1300
integer width = 407
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "에러 데이타"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_wip013b
integer x = 2117
integer y = 1388
integer width = 2057
integer height = 760
integer taborder = 30
string title = "none"
string dataobject = "d_wip013b_upload"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_create from commandbutton within w_wip013b
integer x = 2162
integer y = 628
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

event clicked;string 	ls_plant, ls_dvsn, ls_orct, ls_itno, ls_adjdate, ls_year, ls_month
dec{2} 	lc_scrp, lc_retn
long 		ll_rowcnt, ll_currow, ll_complete, ll_rtncnt, ll_savecnt

setpointer(hourglass!)

dw_1.accepttext()
ls_adjdate      = uf_wip_addmonth(g_s_date, -1 )
ls_year = mid(ls_adjdate,1,4)
ls_month = mid(ls_adjdate,5,2)

ll_savecnt = 0
ll_rowcnt = dw_1.rowcount()

if ll_rowcnt < 1 then
	return 0
end if

for ll_currow = 1 to ll_rowcnt
	dw_1.SelectRow(0, False)
	dw_1.SelectRow(ll_currow, True)	
	dw_1.ScrollToRow(ll_currow)
	
	//해당 데이타 체크
	ls_plant = dw_1.getitemstring(ll_currow,'waplant')
	ls_dvsn 	= dw_1.getitemstring(ll_currow,'wadvsn')
	ls_orct	= dw_1.getitemstring(ll_currow,'waorct')
	ls_itno 	= dw_1.getitemstring(ll_currow,'waitno')
	lc_scrp 	= dw_1.getitemdecimal(ll_currow,'wascrp')
	lc_retn 	= dw_1.getitemdecimal(ll_currow,'waretn')
	
	SELECT COUNT(*) 
    	INTO :ll_rtncnt  
    	FROM "PBWIP"."WIP001"  
   	WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
         	( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         	( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         	( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         	( "PBWIP"."WIP001"."WAITNO" = :ls_itno ) AND
				( "PBWIP"."WIP001"."WAIOCD" = '2' )
				using sqlca;
	if ll_rtncnt < 1 then
		//해당행을 에러데이타로 이동
		dw_1.RowsCopy(ll_currow, ll_currow, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
	else
		//해당행의 불량율, 반납율 UPDATE
		ll_savecnt = ll_savecnt + 1
		UPDATE "PBWIP"."WIP001"  
     		SET "WASCRP" = :lc_scrp,   
         	"WARETN" = :lc_retn,
				"WAUPDTDT" = :g_s_date,
				"WAIPADDR" = :g_s_ipaddr,
				"WAMACADDR" = :g_s_empno
   		WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
         		( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         		( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         		( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         		( "PBWIP"."WIP001"."WAITNO" = :ls_itno ) AND
					( "PBWIP"."WIP001"."WAIOCD" = '2' )  
           		using sqlca;
					  
//		UPDATE "PBWIP"."WIP002"  
//     		SET "WBSCRP" = :lc_scrp,   
//         	"WBRETN" = :lc_retn  
//   		WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND 
//         		( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
//         		( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
//         		( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
//         		( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND
//					( "PBWIP"."WIP002"."WBYEAR" = :ls_year ) AND 
//					( "PBWIP"."WIP002"."WBMONTH" = :ls_month ) AND
//					( "PBWIP"."WIP002"."WBIOCD" = '2' )
//           		using sqlca;
		if sqlca.sqlcode <> 0 then
			//해당행을 에러데이타로 이동
			dw_1.RowsCopy(ll_currow, ll_currow, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
		end if
	end if

	ll_complete = ll_currow * 100 / ll_rowcnt
	if mod(ll_currow,5) = 0 then
		uo_1.uf_set_position (ll_complete)
		st_7.text = string(ll_savecnt,"###,### ")
	end if
next

ll_complete = (ll_currow - 1) * 100 / ll_rowcnt
uo_1.uf_set_position (ll_complete)
st_7.text = string(ll_savecnt,"###,### ")

return 0
end event

type st_7 from statictext within w_wip013b
integer x = 3310
integer y = 816
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

type sle_1 from singlelineedit within w_wip013b
integer x = 2482
integer y = 504
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

type cb_1 from commandbutton within w_wip013b
integer x = 2158
integer y = 504
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
GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")

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
end event

type dw_1 from datawindow within w_wip013b
integer x = 37
integer y = 172
integer width = 2048
integer height = 1976
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip013b_upload"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type uo_1 from uo_progress_bar within w_wip013b
event destroy ( )
integer x = 2213
integer y = 1072
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_wip013b
integer x = 2981
integer y = 828
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

type st_5 from statictext within w_wip013b
integer x = 2523
integer y = 816
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

type st_4 from statictext within w_wip013b
integer x = 2217
integer y = 824
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

type st_3 from statictext within w_wip013b
integer x = 2162
integer y = 404
integer width = 1801
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "２.  저장버튼을 눌러 저장한다."
boolean focusrectangle = false
end type

type st_2 from statictext within w_wip013b
integer x = 2162
integer y = 324
integer width = 1778
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "１. ~'자료경로~'를 눌러 대상건수를 확인한다."
boolean focusrectangle = false
end type

type st_1 from statictext within w_wip013b
integer x = 169
integer y = 60
integer width = 1550
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  EXCEL 자료 LOAD  ◎"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_wip013b
integer x = 2162
integer y = 984
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

type gb_2 from groupbox within w_wip013b
integer x = 2162
integer y = 744
integer width = 1614
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

