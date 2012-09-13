$PBExportHeader$w_wip051b.srw
$PBExportComments$실사품목 KnockDown
forward
global type w_wip051b from w_origin_sheet06
end type
type gb_2 from groupbox within w_wip051b
end type
type gb_1 from groupbox within w_wip051b
end type
type st_1 from statictext within w_wip051b
end type
type st_a1 from statictext within w_wip051b
end type
type st_a2 from statictext within w_wip051b
end type
type st_3 from statictext within w_wip051b
end type
type st_daesang from statictext within w_wip051b
end type
type st_55 from statictext within w_wip051b
end type
type st_saeng from statictext within w_wip051b
end type
type uo_1 from uo_progress_bar within w_wip051b
end type
type dw_1 from datawindow within w_wip051b
end type
type cb_1 from commandbutton within w_wip051b
end type
type sle_1 from singlelineedit within w_wip051b
end type
type dw_2 from datawindow within w_wip051b
end type
type uo_2 from uo_wip_plandiv within w_wip051b
end type
type pb_down from picturebutton within w_wip051b
end type
type cb_2 from commandbutton within w_wip051b
end type
type cb_3 from commandbutton within w_wip051b
end type
type gb_3 from groupbox within w_wip051b
end type
type ln_1 from line within w_wip051b
end type
end forward

global type w_wip051b from w_origin_sheet06
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
uo_2 uo_2
pb_down pb_down
cb_2 cb_2
cb_3 cb_3
gb_3 gb_3
ln_1 ln_1
end type
global w_wip051b w_wip051b

type variables
dec i_n_complete
end variables

on w_wip051b.create
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
this.uo_2=create uo_2
this.pb_down=create pb_down
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_3=create gb_3
this.ln_1=create ln_1
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
this.Control[iCurrent+15]=this.uo_2
this.Control[iCurrent+16]=this.pb_down
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.cb_3
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.ln_1
end on

on w_wip051b.destroy
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
destroy(this.uo_2)
destroy(this.pb_down)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_3)
destroy(this.ln_1)
end on

event ue_bcreate;decimal    l_n_totalcnt,l_n_loopcnt
decimal{4} l_n_phqt
string     l_s_plant,l_s_dvsn,l_s_itno,l_s_date
integer    Net,l_n_chkcount

Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 2)
if Net <> 1 then
	return
end if

setpointer(HourGlass!)
 dw_1.accepttext()

l_s_plant = trim(dw_1.object.wgplant[1])
l_s_dvsn  = trim(dw_1.object.wgdvsn[1])

DELETE FROM PBWIP.WIP007
WHERE WGCMCD = '01' AND WGPLANT = :l_s_plant AND WGDVSN = :l_s_dvsn
using sqlca;

l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "자료 처리중(오류 확인중)..."

do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	
	l_s_plant = trim(dw_1.object.wgplant[l_n_loopcnt])
	l_s_dvsn  = trim(dw_1.object.wgdvsn[l_n_loopcnt])
	l_s_itno  = trim(dw_1.object.wgitno[l_n_loopcnt])
	l_n_phqt  = dw_1.object.wgphqt[l_n_loopcnt]
	l_s_date  = trim(dw_1.object.wginptdt[l_n_loopcnt])
	if f_spacechk(f_get_coflname('01','SLE220', l_s_plant)) = -1 then
		messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " + "지역 코드 오류  = " + l_s_plant)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.		
		return
	end if
	if f_spacechk(f_get_coflname('01','DAC030', l_s_dvsn)) = -1 then
		messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"공장 코드 오류 =  " + l_s_dvsn)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.		
		return
	end if
	
	select count(*) into:l_n_chkcount from pbinv.inv101
		where comltd = :g_s_company and xplant = :l_s_plant and 
			div = :l_s_dvsn and itno = :l_s_itno
			using sqlca;
	if sqlca.sqlcode <> 0 or l_n_chkcount = 0 then
		messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"품 번 오류 =  " + l_s_itno)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.	
		return
	end if
	
	if isnull(l_n_phqt)  or l_n_phqt = 0 then 
		messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"실사수량 오류 =  " + string(l_n_phqt))
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.	
		return
	end if
   
	if f_dateedit(l_s_date) = space(8) then
		messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"일자 오류 =  " + l_s_date)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.	
		return
	end if
	
//	if l_n_loopcnt <> dw_1.rowcount() then
//		if dw_1.find("wgitno = '" + l_s_itno + "'", l_n_loopcnt + 1, dw_1.rowcount()) > 0 then
//			messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"품번일치 오류 =  " + l_s_itno)
//			uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.	
//			return
//		end if
//	end if
	
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

uo_status.st_message.text = "오류 없음. 저장중..."
l_n_loopcnt = 0

dw_1.accepttext()
do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
	
	dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	
	dw_1.object.wgcmcd[l_n_loopcnt]       = g_s_company	
	dw_1.object.wgipaddr[l_n_loopcnt]     = g_s_ipaddr
	dw_1.object.wgmacaddr[l_n_loopcnt]    = g_s_macaddr
	dw_1.object.wgupdtdt[l_n_loopcnt]     = g_s_date
   i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

if dw_1.update() <> 1 then
	rollback using sqlca;
	messagebox("Error",sqlca.sqlerrtext)
	uo_status.st_message.text = f_message("U020")
	return 0
end if
commit using sqlca;
uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//저장이 되었습니다.

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;dw_1.settransobject(Sqlca)

// 대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, true, false, true, i_b_dchar)
end event

event close;call super::close;disconnect using sqlcs;
end event

event ue_dprint;call super::ue_dprint;integer l_n_rowcnt, i
string mod_string,l_s_plant,l_s_dvsn

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
//this.TriggerEvent("ue_retrieve")
if dw_2.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

//dw_2.sharedata(dw_report)

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_2
l_str_prt.dwsyntax = mod_string
//l_str_prt.title = "완성품별 사용실적"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type uo_status from w_origin_sheet06`uo_status within w_wip051b
end type

type gb_2 from groupbox within w_wip051b
integer x = 2240
integer y = 688
integer width = 2011
integer height = 256
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

type gb_1 from groupbox within w_wip051b
integer x = 2240
integer y = 388
integer width = 2011
integer height = 236
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type st_1 from statictext within w_wip051b
integer x = 201
integer y = 80
integer width = 1934
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

type st_a1 from statictext within w_wip051b
integer x = 2226
integer y = 180
integer width = 1733
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "1. 자료경로를 눌러 대상건수를 확인 하십시오."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_wip051b
integer x = 2222
integer y = 272
integer width = 1760
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "2. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip051b
integer x = 2409
integer y = 484
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
string text = "대상건수"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_wip051b
integer x = 2734
integer y = 468
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

type st_55 from statictext within w_wip051b
integer x = 3360
integer y = 484
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

type st_saeng from statictext within w_wip051b
integer x = 3698
integer y = 472
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

type uo_1 from uo_progress_bar within w_wip051b
event destroy ( )
integer x = 2505
integer y = 776
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_wip051b
integer x = 201
integer y = 192
integer width = 1934
integer height = 648
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip051b_upload"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type cb_1 from commandbutton within w_wip051b
integer x = 343
integer y = 868
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
ll_rtn = GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")
if ll_rtn <> 1 then
	return 0
end if
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

type sle_1 from singlelineedit within w_wip051b
integer x = 663
integer y = 868
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

type dw_2 from datawindow within w_wip051b
integer x = 87
integer y = 1304
integer width = 4439
integer height = 1140
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip051b_knockdown"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_2 from uo_wip_plandiv within w_wip051b
integer x = 151
integer y = 1160
integer taborder = 30
boolean bringtotop = true
end type

on uo_2.destroy
call uo_wip_plandiv::destroy
end on

type pb_down from picturebutton within w_wip051b
integer x = 3918
integer y = 1160
integer width = 315
integer height = 116
integer taborder = 40
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

event clicked;f_save_to_excel(dw_2)
end event

type cb_2 from commandbutton within w_wip051b
integer x = 2857
integer y = 1168
integer width = 933
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "50/04 품번 K/D생성"
end type

event clicked;datastore lds_01, lds_02
string ls_pitno, ls_plant, ls_dvsn, ls_date, ls_rtncd
string ls_itno, ls_opcd, ls_wkct, ls_itnm, ls_cls, ls_srce, ls_pdcd, ls_xunit
dec{4} lc_phqt, lc_convqty, lc_pqty, lc_qty1
integer li_chk, li_currow, li_currow2, li_rowcnt, li_rowcnt2
long ll_currow

lds_01 = create datastore
lds_01.dataobject = 'd_wip051b_01'
lds_01.settransobject(sqlca)

lds_02 = create datastore
lds_02.dataobject = 'd_wip051b_03'
lds_02.settransobject(sqlca)

dw_2.reset()
ls_rtncd = uo_2.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_dvsn = mid(ls_rtncd,2,1)
if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "지역과 공장을 선택하십시요"
	return 0
end if

setpointer(hourglass!)
li_rowcnt = lds_01.retrieve(g_s_company, ls_plant, ls_dvsn)

for li_currow = 1 to li_rowcnt
	ls_pitno = lds_01.getitemstring(li_currow,"wgitno")
	lc_phqt = lds_01.getitemdecimal(li_currow,"wgphqt")
	ls_date = lds_01.getitemstring(li_currow,"wginptdt")

	// 모품번 변환계수 적용
	SELECT CONVQTY, CLS, SRCE INTO :lc_convqty, :ls_cls, :ls_srce FROM PBINV.INV101
		WHERE COMLTD = :g_s_company AND XPLANT = :ls_plant AND
			DIV = :ls_dvsn AND ITNO = :ls_pitno
			using sqlca;
	
	if ls_cls = '50' and ls_srce = '04' then
		//pass
	else
		continue
	end if
	lc_pqty = lc_phqt * lc_convqty
	
	// BOM001 CHECK (LOGIC ADD 2004.01.05)
	select count(*) into :li_chk from pbpdm.bom001
		where pcmcd = :g_s_company AND plant = :ls_plant AND
				pdvsn = :ls_dvsn AND ppitn = :ls_pitno AND
				(( pedte = ' '  and pedtm <= :ls_date ) or
				( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
		using sqlca;
	if li_chk < 1 then
		messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_pitno)
		continue
	end if
	
	// bom temp db 생성
	DECLARE up_wip_16 PROCEDURE FOR PBWIP.SP_WIP_16 
				A_COMLTD = :g_s_company,   
				A_PLANT = :ls_plant,   
				A_DVSN = :ls_dvsn,   
				A_ITNO = :ls_pitno,   
				A_DATE = :ls_date,   
				A_CHK = 'I',
				A_DELCHK = 'Y'	using sqlca;
	Execute up_wip_16;
	Close up_wip_16;
	
	li_rowcnt2 = lds_02.retrieve(g_s_company, ls_plant, ls_dvsn )
	if li_rowcnt2 = 0 then
		messagebox("chk", ls_pitno)
	end if
	for li_currow2 = 1 to li_rowcnt2
		ls_itno = lds_02.getitemstring(li_currow2, "tcitn")
		ls_wkct = lds_02.getitemstring(li_currow2, "twkct")
		lc_qty1 = lds_02.getitemdecimal(li_currow2, "tqty1")
		
		SELECT "PBINV"."INV002"."ITNM",   
         	"PBINV"."INV101"."CLS",   
         	"PBINV"."INV101"."SRCE",   
         	"PBINV"."INV101"."PDCD",   
         	"PBINV"."INV101"."XUNIT",   
         	"PBINV"."INV101"."CONVQTY"  
    	INTO :ls_itnm,:ls_cls,:ls_srce,:ls_pdcd,:ls_xunit,:lc_convqty  
    	FROM "PBINV"."INV002",   
         	"PBINV"."INV101"  
   	WHERE ( "PBINV"."INV002"."COMLTD" = "PBINV"."INV101"."COMLTD" ) and  
         	( "PBINV"."INV002"."ITNO" = "PBINV"."INV101"."ITNO" ) and  
         	( ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         	( "PBINV"."INV101"."XPLANT" = :ls_plant  ) AND  
         	( "PBINV"."INV101"."DIV" = :ls_dvsn ) AND  
         	( "PBINV"."INV101"."ITNO" = :ls_itno ) )   
				using sqlca;
		
		ll_currow = dw_2.insertrow(0)
		dw_2.setitem(ll_currow,"plant",ls_plant)
		dw_2.setitem(ll_currow,"dvsn", ls_dvsn)
		dw_2.setitem(ll_currow,"pitno", ls_pitno )
		dw_2.setitem(ll_currow,"citno", ls_itno)
		dw_2.setitem(ll_currow,"citnm",ls_itnm)
		dw_2.setitem(ll_currow,"itcl",ls_cls)
		dw_2.setitem(ll_currow,"srce",ls_srce)
		dw_2.setitem(ll_currow,"pdcd",mid(ls_pdcd,1,2))
		dw_2.setitem(ll_currow,"unit",ls_xunit)
		dw_2.setitem(ll_currow,"convqty",lc_convqty)
		dw_2.setitem(ll_currow,"qty",(lc_qty1 / lc_convqty))
		dw_2.setitem(ll_currow,"pqty", lc_pqty )
		dw_2.setitem(ll_currow,"cqty", lc_pqty * (lc_qty1 / lc_convqty))	
	next
next

uo_status.st_message.text = "Knock Down 완료되었습니다."
end event

type cb_3 from commandbutton within w_wip051b
integer x = 1669
integer y = 1164
integer width = 869
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "30,10/03 품번 K/D생성"
end type

event clicked;datastore lds_01, lds_02
string ls_pitno, ls_plant, ls_dvsn, ls_date, ls_rtncd
string ls_itno, ls_opcd, ls_wkct, ls_itnm, ls_cls, ls_srce, ls_pdcd, ls_xunit
dec{4} lc_phqt, lc_convqty, lc_pqty, lc_qty1
integer li_chk, li_currow, li_currow2, li_rowcnt, li_rowcnt2
long ll_currow

lds_01 = create datastore
lds_01.dataobject = 'd_wip051b_01'
lds_01.settransobject(sqlca)

lds_02 = create datastore
lds_02.dataobject = 'd_wip051b_02'
lds_02.settransobject(sqlca)

dw_2.reset()
ls_rtncd = uo_2.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_dvsn = mid(ls_rtncd,2,1)
if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "지역과 공장을 선택하십시요"
	return 0
end if

setpointer(hourglass!)
li_rowcnt = lds_01.retrieve(g_s_company, ls_plant, ls_dvsn)

for li_currow = 1 to li_rowcnt
	ls_pitno = lds_01.getitemstring(li_currow,"wgitno")
	lc_phqt = lds_01.getitemdecimal(li_currow,"wgphqt")
	ls_date = lds_01.getitemstring(li_currow,"wginptdt")
	
	// 모품번 변환계수 적용
	SELECT CONVQTY, CLS, SRCE INTO :lc_convqty, :ls_cls, :ls_srce FROM PBINV.INV101
		WHERE COMLTD = :g_s_company AND XPLANT = :ls_plant AND
			DIV = :ls_dvsn AND ITNO = :ls_pitno
			using sqlca;
	
	if ls_cls <> '30' and ls_srce <> '03' then
		continue
	end if
	
	// BOM001 CHECK (LOGIC ADD 2004.01.05)
	select count(*) into :li_chk from pbpdm.bom001
		where pcmcd = :g_s_company AND plant = :ls_plant AND
				pdvsn = :ls_dvsn AND ppitn = :ls_pitno AND
				(( pedte = ' '  and pedtm <= :ls_date ) or
				( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
		using sqlca;
	if li_chk < 1 then
		messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_pitno)
		continue
	end if
	
	lc_pqty = lc_phqt * lc_convqty
	
	// bom temp db 생성
	DECLARE up_wip_16 PROCEDURE FOR PBWIP.SP_WIP_16 
				A_COMLTD = :g_s_company,   
				A_PLANT = :ls_plant,   
				A_DVSN = :ls_dvsn,   
				A_ITNO = :ls_pitno,   
				A_DATE = :ls_date,   
				A_CHK = 'H',
				A_DELCHK = 'Y'	using sqlca;
	Execute up_wip_16;
	Close up_wip_16;
	
	li_rowcnt2 = lds_02.retrieve(g_s_company, ls_plant, ls_dvsn )
	if li_rowcnt2 = 0 then
		messagebox("chk", ls_pitno)
	end if
	for li_currow2 = 1 to li_rowcnt2
		ls_itno = lds_02.getitemstring(li_currow2, "tcitn")
		ls_wkct = lds_02.getitemstring(li_currow2, "twkct")
		lc_qty1 = lds_02.getitemdecimal(li_currow2, "tqty1")
		
		SELECT "PBINV"."INV002"."ITNM",   
         	"PBINV"."INV101"."CLS",   
         	"PBINV"."INV101"."SRCE",   
         	"PBINV"."INV101"."PDCD",   
         	"PBINV"."INV101"."XUNIT",   
         	"PBINV"."INV101"."CONVQTY"  
    	INTO :ls_itnm,:ls_cls,:ls_srce,:ls_pdcd,:ls_xunit,:lc_convqty  
    	FROM "PBINV"."INV002",   
         	"PBINV"."INV101"  
   	WHERE ( "PBINV"."INV002"."COMLTD" = "PBINV"."INV101"."COMLTD" ) and  
         	( "PBINV"."INV002"."ITNO" = "PBINV"."INV101"."ITNO" ) and  
         	( ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         	( "PBINV"."INV101"."XPLANT" = :ls_plant  ) AND  
         	( "PBINV"."INV101"."DIV" = :ls_dvsn ) AND  
         	( "PBINV"."INV101"."ITNO" = :ls_itno ) )   
				using sqlca;

		if ls_srce = '03' then
			continue
		end if
		
		ll_currow = dw_2.insertrow(0)
		dw_2.setitem(ll_currow,"plant",ls_plant)
		dw_2.setitem(ll_currow,"dvsn", ls_dvsn)
		dw_2.setitem(ll_currow,"pitno", ls_pitno )
		dw_2.setitem(ll_currow,"citno", ls_itno)
		dw_2.setitem(ll_currow,"citnm",ls_itnm)
		dw_2.setitem(ll_currow,"itcl",ls_cls)
		dw_2.setitem(ll_currow,"srce",ls_srce)
		dw_2.setitem(ll_currow,"pdcd",mid(ls_pdcd,1,2))
		dw_2.setitem(ll_currow,"unit",ls_xunit)
		dw_2.setitem(ll_currow,"convqty",lc_convqty)
		dw_2.setitem(ll_currow,"qty",(lc_qty1 / lc_convqty))
		dw_2.setitem(ll_currow,"pqty", lc_pqty )
		dw_2.setitem(ll_currow,"cqty", lc_pqty * (lc_qty1 / lc_convqty))	
	next
next
//declare Wip_006 Cursor for
//	 SELECT "PBWIP"."WIP007"."WGITNO",   
//         "PBWIP"."WIP007"."WGPHQT",
//			"PBWIP"."WIP007"."WGINPTDT"
//    FROM "PBWIP"."WIP007"  
//   	WHERE ( "PBWIP"."WIP007"."WGCMCD" = :g_s_company ) AND  
//         	( "PBWIP"."WIP007"."WGPLANT" = :ls_plant ) AND  
//         	( "PBWIP"."WIP007"."WGDVSN" = :ls_dvsn )   
//				using sqlca;
//open Wip_006 ;
//	do while true
//		fetch Wip_006 into :ls_pitno,:lc_phqt,:ls_date ;
//		if sqlca.sqlcode <> 0 then
//			exit
//		end if
//		// BOM001 CHECK (LOGIC ADD 2004.01.05)
//		select count(*) into :li_chk from pbpdm.bom001
//			where pcmcd = :g_s_company AND plant = :ls_plant AND
//					pdvsn = :ls_dvsn AND ppitn = :ls_pitno AND
//					(( pedte = ' '  and pedtm <= :ls_date ) or
//					( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
//			using sqlca;
//		if li_chk < 1 then
//			messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_pitno)
//			continue
//		end if
//		if f_wip_knockdown(ls_plant,ls_dvsn,ls_pitno,ls_date, lc_phqt, dw_2) = -1 then
//			uo_status.st_message.text = "에러발생"
//			return 0
//		end if
//	loop
//close wip_006;

uo_status.st_message.text = "Knock Down 완료되었습니다."
end event

type gb_3 from groupbox within w_wip051b
integer x = 32
integer y = 16
integer width = 4549
integer height = 1020
integer taborder = 20
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type ln_1 from line within w_wip051b
integer linethickness = 10
integer beginx = 41
integer beginy = 1096
integer endx = 4567
integer endy = 1096
end type

