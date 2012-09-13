$PBExportHeader$w_wip053b.srw
$PBExportComments$실사수량 엑셀파일 Upload
forward
global type w_wip053b from w_origin_sheet06
end type
type gb_2 from groupbox within w_wip053b
end type
type gb_1 from groupbox within w_wip053b
end type
type st_1 from statictext within w_wip053b
end type
type st_a1 from statictext within w_wip053b
end type
type st_a2 from statictext within w_wip053b
end type
type st_3 from statictext within w_wip053b
end type
type st_daesang from statictext within w_wip053b
end type
type st_55 from statictext within w_wip053b
end type
type st_saeng from statictext within w_wip053b
end type
type uo_1 from uo_progress_bar within w_wip053b
end type
type dw_1 from datawindow within w_wip053b
end type
type cb_1 from commandbutton within w_wip053b
end type
type sle_1 from singlelineedit within w_wip053b
end type
type dw_2 from datawindow within w_wip053b
end type
type st_2 from statictext within w_wip053b
end type
type st_4 from statictext within w_wip053b
end type
type pb_down from picturebutton within w_wip053b
end type
end forward

global type w_wip053b from w_origin_sheet06
gb_2 gb_2
gb_1 gb_1
st_1 st_1
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
dw_2 dw_2
st_2 st_2
st_4 st_4
pb_down pb_down
end type
global w_wip053b w_wip053b

type variables
dec i_n_complete
end variables

on w_wip053b.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.dw_2=create dw_2
this.st_2=create st_2
this.st_4=create st_4
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_a1
this.Control[iCurrent+5]=this.st_a2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_daesang
this.Control[iCurrent+8]=this.st_55
this.Control[iCurrent+9]=this.st_saeng
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.sle_1
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.pb_down
end on

on w_wip053b.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.pb_down)
end on

event ue_bretrieve;//long   l_n_count
//
//setpointer(HourGlass!)
//dw_1.reset()
//l_n_count = dw_1.importfile(sle_1.text)
//st_daesang.text = string(l_n_count,"###,### ")
//
//if l_n_count	  > 0 then
//	i_b_bcreate	  = True
//end if
//
////Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
//wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
//setpointer(Arrow!)
end event

event ue_bcreate;decimal    l_n_totalcnt,l_n_loopcnt
decimal{2} lc_phqt
decimal{4} lc_convqty
string     ls_plant,ls_dvsn,ls_itno,ls_date,ls_year,ls_month,ls_dept,ls_plan, ls_rtn, ls_cls, ls_srce
string     ls_chkplant, ls_chkdvsn, ls_error, ls_itnm, ls_spec, ls_unit, ls_chkpdcd, ls_pdnm
long 		  ll_tagno
integer    Net,l_n_chkcount

Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 1)
if Net <> 1 then
	return
end if

setpointer(HourGlass!)
//dw_1.accepttext()

ls_error = ' '
l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "자료 처리중(오류 확인중)..."

l_n_chkcount = 0
for l_n_loopcnt = 1 to l_n_totalcnt
	ls_itno   = trim(dw_1.object.wfitno[l_n_loopcnt])
	ls_plant  = trim(dw_1.object.wfplant[l_n_loopcnt])
	ls_dvsn   = trim(dw_1.object.wfdvsn[l_n_loopcnt])
	ls_year   = trim(dw_1.object.wfyear[l_n_loopcnt])
	ls_month  = trim(dw_1.object.wfmonth[l_n_loopcnt])
	if l_n_loopcnt <> l_n_totalcnt then
		if dw_1.find("wfitno = '" + ls_itno + "'", l_n_loopcnt + 1, dw_1.rowcount()) > 0 then
			messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"품번일치 오류 =  " + ls_itno)
			return 0
		end if
	end if
next

// 실사 상태체크
if Not f_wip_check_applystatus('01',ls_plant,ls_dvsn, ls_year + ls_month) then
	uo_status.st_message.text = "실사년월이 아니거나 실사가 확정되었습니다."
	return -1
end if

l_n_loopcnt = 0
do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	ls_year   = trim(dw_1.object.wfyear[l_n_loopcnt])
	ls_month  = trim(dw_1.object.wfmonth[l_n_loopcnt])
	ls_dept   = trim(dw_1.object.wfdept[l_n_loopcnt])
	ls_plant  = trim(dw_1.object.wfplant[l_n_loopcnt])
	ls_dvsn   = trim(dw_1.object.wfdvsn[l_n_loopcnt])
	ls_itno   = trim(dw_1.object.wfitno[l_n_loopcnt])
	ll_tagno	 = dw_1.object.wfserial[l_n_loopcnt]
	lc_phqt   = dw_1.object.wfphqt[l_n_loopcnt]

	if l_n_loopcnt = l_n_totalcnt then
		//pass
	else
		if dw_1.find("wfitno = '" + ls_itno + "'",(l_n_loopcnt + 1),l_n_totalcnt) > 0 then
			ls_error = 'E01 : 품번일치 오류' 	// 품번일치 오류
		end if
	end if
	if f_spacechk(ls_year) = -1 or mid(g_s_date,1,4) < ls_year then
		ls_error = 'E02 : 해당년도 오류'  	// 해당년도 오류
	end if
	if ls_month <> '12'  then
		ls_error = 'E03 : 해당월 오류'		// 해당월 오류
	end if
	if f_spacechk(ls_dept) = -1 or ls_dept <> '9999' then
		ls_error = 'E04 : 조코드 오류'		// 조코드 오류
	end if		
	if f_spacechk(f_get_coflname('01','SLE220', ls_plant)) = -1 then	
		ls_error = 'E05 : 지역코드 오류'		// 지역코드 오류
	end if
	if f_spacechk(f_get_coflname('01','DAC030', ls_dvsn)) = -1 then
		ls_error = 'E06 : 공장코드 오류'		// 공장코드 오류
	end if
	SELECT AA.ITNM, AA.SPEC, BB.XUNIT, SUBSTRING(BB.PDCD,1,2), BB.CONVQTY, BB.CLS, BB.SRCE
		INTO :ls_itnm, :ls_spec, :ls_unit, :ls_chkpdcd, :lc_convqty, :ls_cls, :ls_srce
		FROM PBINV.INV002 AA, PBINV.INV101 BB
		WHERE AA.COMLTD = BB.COMLTD AND AA.ITNO = BB.ITNO AND
				BB.COMLTD = :g_s_company AND BB.XPLANT = :ls_plant AND
				BB.DIV = :ls_dvsn AND BB.ITNO = :ls_itno
		using sqlca;

	if sqlca.sqlcode <> 0 then
		ls_error = 'E07 : 품번상세정보 에러'		// 품번상세정보 에러
	else
		select wbitno into :ls_rtn from pbwip.wip002
			where wbcmcd = :g_s_company and wbplant = :ls_plant and 
					wbdvsn = :ls_dvsn and wbitno = :ls_itno and
					wbyear = :ls_year and wbmonth = :ls_month and 
					wborct = '9999'
			using sqlca;
		if f_spacechk(ls_rtn) = -1 then
			ls_error = 'E08 : 재공이월품번 에러'	// 재공이월품번 에러
		else
			if ls_cls = '30' or ls_cls = '50' or ls_srce = '03' then
				ls_error = 'E13 : 실사대상품번이 아님'	// 실사대상품번이 아님
			else
				select wfitno into :ls_rtn from pbwip.wip006
				where wfcmcd = :g_s_company and wfplant = :ls_plant and 
						wfdvsn = :ls_dvsn and wfitno = :ls_itno and
						wfyear = :ls_year and wfmonth = :ls_month and 
						wfdept = '9999' and wfserial = 0
				using sqlca;
				if sqlca.sqlcode <> 0 or f_spacechk(ls_rtn) = -1 then
					ls_error = 'E09'	// 실사품번 미존제
				else
					//PASS
				end if
			end if
		end if
	end if
	
	if isnull(lc_phqt)  or lc_phqt < 0 then 
		ls_error = 'E10 : 실사수량 에러'			// 실사수량 에러
	else
		lc_phqt = lc_phqt * lc_convqty
	end if
   
	if f_spacechk(ls_error) <> -1 then
		// 에러가 발생한 품번
		if ls_error = 'E09' then
			INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
    			WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
    			WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
    			WFINPTDT,WFUPDTDT)
			VALUES( :ls_year, :ls_month, '01', :ls_plant, :ls_dvsn,
				'9999', :ls_itno,0,' ',' ',' ',:ls_chkpdcd,' ',
   			:ls_unit, 0, :lc_phqt, 'A', ' ', ' ', ' ', ' ', ' ') 
			using sqlca;
			if sqlca.sqlcode <> 0 then
				dw_1.setitem(l_n_loopcnt,"chk",ls_error)
				dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
			end if
		else
			dw_1.setitem(l_n_loopcnt,"chk",ls_error)
			dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
		end if
	else
		// 실사수량 업데이트
		UPDATE "PBWIP"."WIP006"  
     		SET "WFPHQT" = :lc_phqt  
			WHERE ( "PBWIP"."WIP006"."WFYEAR" = :ls_year ) AND  
					( "PBWIP"."WIP006"."WFMONTH" = :ls_month ) AND  
					( "PBWIP"."WIP006"."WFCMCD" = '01' ) AND  
					( "PBWIP"."WIP006"."WFPLANT" = :ls_plant ) AND  
					( "PBWIP"."WIP006"."WFDVSN" = :ls_dvsn ) AND  
					( "PBWIP"."WIP006"."WFITNO" = :ls_itno ) AND
					( "PBWIP"."WIP006"."WFDEPT" = '9999' ) AND
					( "PBWIP"."WIP006"."WFSERIAL" = 0 )
		using sqlca;
		if sqlca.sqlcode = 0 and sqlca.sqlnrows < 1 then
			// 에러가 발생한 품번
			ls_error = 'E12'
			dw_1.setitem(l_n_loopcnt,"chk",ls_error)
			dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
		end if
	end if
	ls_error = ' '
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//저장이 되었습니다.

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;dw_1.settransobject(sqlca)

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, TRUE, i_b_dretrieve, i_b_dprint, i_b_dchar)
end event

type uo_status from w_origin_sheet06`uo_status within w_wip053b
end type

type gb_2 from groupbox within w_wip053b
integer x = 2185
integer y = 1020
integer width = 2011
integer height = 188
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

type gb_1 from groupbox within w_wip053b
integer x = 2185
integer y = 820
integer width = 2011
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type st_1 from statictext within w_wip053b
integer x = 91
integer y = 28
integer width = 3456
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

type st_a1 from statictext within w_wip053b
integer x = 101
integer y = 860
integer width = 1998
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
string text = "1.~'자료경로~'를 눌러 대상엑셀파일을 선택바랍니다."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_wip053b
integer x = 101
integer y = 928
integer width = 2007
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
string text = "2. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip053b
integer x = 2354
integer y = 900
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
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

type st_daesang from statictext within w_wip053b
integer x = 2679
integer y = 884
integer width = 389
integer height = 92
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

type st_55 from statictext within w_wip053b
integer x = 3305
integer y = 900
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
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

type st_saeng from statictext within w_wip053b
integer x = 3625
integer y = 884
integer width = 389
integer height = 92
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

type uo_1 from uo_progress_bar within w_wip053b
event destroy ( )
integer x = 2450
integer y = 1080
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_wip053b
event ue_validation pbm_dwnitemvalidationerror
integer x = 91
integer y = 156
integer width = 4123
integer height = 648
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053b_upload"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type cb_1 from commandbutton within w_wip053b
integer x = 224
integer y = 1076
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

event clicked;//string ls_pathname,ls_filename
//GetFileOpenName("Select File", ls_pathname, ls_filename, "txt","Text Files (*.txt),*.txt,")
//sle_1.text = ls_pathname


string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

// UPLOAD할 엑셀파일을 선택한다
//
GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")

setpointer(hourglass!)
sle_1.text = ls_docname
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

st_daesang.text = string(dw_1.rowcount())
end event

type sle_1 from singlelineedit within w_wip053b
integer x = 544
integer y = 1072
integer width = 1266
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

type dw_2 from datawindow within w_wip053b
integer x = 91
integer y = 1372
integer width = 4123
integer height = 1092
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053b_upload"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_wip053b
integer x = 91
integer y = 1280
integer width = 791
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12639424
string text = "에러가 발생한 품번"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_4 from statictext within w_wip053b
integer x = 101
integer y = 1000
integer width = 2007
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "3. 품번중복불가, 조코드 ~'9999~', Tag번호 0 이어야 합니다."
boolean focusrectangle = false
end type

type pb_down from picturebutton within w_wip053b
integer x = 1061
integer y = 1232
integer width = 155
integer height = 132
integer taborder = 30
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

event clicked;f_save_to_excel(dw_2)
end event

