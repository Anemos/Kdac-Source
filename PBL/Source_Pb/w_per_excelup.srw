$PBExportHeader$w_per_excelup.srw
$PBExportComments$엑셀업로드
forward
global type w_per_excelup from window
end type
type dw_title from datawindow within w_per_excelup
end type
type p_1 from picture within w_per_excelup
end type
type st_2 from statictext within w_per_excelup
end type
type mle_1 from multilineedit within w_per_excelup
end type
type cb_4 from commandbutton within w_per_excelup
end type
type sle_2 from singlelineedit within w_per_excelup
end type
type cb_3 from commandbutton within w_per_excelup
end type
type cb_create from commandbutton within w_per_excelup
end type
type st_7 from statictext within w_per_excelup
end type
type dw_1 from datawindow within w_per_excelup
end type
type uo_1 from uo_progress_bar within w_per_excelup
end type
type st_6 from statictext within w_per_excelup
end type
type st_5 from statictext within w_per_excelup
end type
type st_4 from statictext within w_per_excelup
end type
type gb_1 from groupbox within w_per_excelup
end type
type gb_2 from groupbox within w_per_excelup
end type
type gb_4 from groupbox within w_per_excelup
end type
type dw_2 from datawindow within w_per_excelup
end type
end forward

global type w_per_excelup from window
integer width = 4347
integer height = 2232
boolean titlebar = true
string title = " 엑셀자료업로드"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_title dw_title
p_1 p_1
st_2 st_2
mle_1 mle_1
cb_4 cb_4
sle_2 sle_2
cb_3 cb_3
cb_create cb_create
st_7 st_7
dw_1 dw_1
uo_1 uo_1
st_6 st_6
st_5 st_5
st_4 st_4
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
dw_2 dw_2
end type
global w_per_excelup w_per_excelup

type prototypes
Function Long SetCurrentDirectoryA (ref String lpPathName) LIBRARY "KERNEL32.DLL"
end prototypes

type variables
//String is_xplant, is_div, is_cls[], is_itno
//
//DataStore	ids_carinfo_ins

String is_gubun, is_gubun2, is_yy, is_mm, is_grade


end variables

forward prototypes
public function long wf_errchk (datawindow adw_1)
public function integer wf_month_carcheck (string ag_ym, string ag_ficode)
public function integer wf_month_unbancheck (string ag_ym, string ag_ficode)
public function integer wf_existchk (string ag_empno, string ag_yy, string ag_no, string ag_xdate)
end prototypes

public function long wf_errchk (datawindow adw_1);//여기에서 모든 에러를 경우에 따라서 걸러내는 작업을 하는 곳이다.
string ls_cexamdate
Long ll_cnt, ll_errcnt, ll_cnt2, ll_count
string ls_empno, ls_namek, ls_cphone, ls_addr, ls_post, ls_tel	
string ls_resno

SetPointer(HourGlass!)

IF adw_1.RowCount() = 0 Then
	Messagebox('확인','UPLOAD할 자료가 없습니다!',Exclamation!)
	Return -1 
End IF

//Error Checking 
//Target_DataWindow로 엑셀 Sheet의 데이타를 Upload시 타입 체킹이 전부이다.

If f_Mandatory_Chk( adw_1 ) = -1 Then // 필수입력항목 Check...
	Return 1 
End If

choose case is_gubun
	case 'per001'		
		
		For ll_cnt = 1 To adw_1.RowCount()
			ls_empno = adw_1.object.empno[ll_cnt]		
			ls_empno = string(dec(ls_empno), '000000')			
			adw_1.object.empno[ll_cnt]   = ls_empno
			
			select penamek
			 into :ls_namek
			from pbper.per001
			where peempno = :ls_empno and peintdept like :is_gubun2 || '%' and peout <> '*' and
			      (peclass = '60' or peclass >= '7A' or pegubun ='2')
					using sqlcc;
			
			if sqlcc.sqlcode <> 0 then
				adw_1.object.errcol[ll_cnt] = '1'
				adw_1.object.errtext[ll_cnt] = "업로드부서의 생산직&재직자인지 사번을 확인바랍니다."
				ll_errcnt ++
			End if
			
//			adw_1.object.namek[ll_cnt] = ls_namek
			
			ls_post   = adw_1.object.silpost[ll_cnt]
			ls_addr   = adw_1.object.siladdr[ll_cnt]
			ls_tel    = adw_1.object.tel[ll_cnt]
			ls_cphone = adw_1.object.cphone[ll_cnt]
			
		   If f_spacechk(ls_cphone) = -1 or len(ls_cphone) < 10 then
				adw_1.object.errcol[ll_cnt] = '1'
				adw_1.object.errtext[ll_cnt] = "휴대폰번호를 확인바랍니다."
				ll_errcnt ++
		   End if
		   If f_spacechk(ls_addr) = -1 or len(f_replace_with(ls_addr,' ','')) < 18 then
				adw_1.object.errcol[ll_cnt] = '1'
				adw_1.object.errtext[ll_cnt] = "주소를 확인바랍니다."
				ll_errcnt ++
		   End if
		   If f_spacechk(ls_post) = -1 or len(ls_post) < 6 then
				adw_1.object.errcol[1] = '1'
				adw_1.object.errtext[1] = "우편번호를 확인바랍니다."
				ll_errcnt ++
		   End if
		   If f_spacechk(ls_tel) = -1 or len(ls_tel) < 7 then
				adw_1.object.errcol[ll_cnt] = '1'
				adw_1.object.errtext[ll_cnt] = "집전화번호를 확인바랍니다."
				ll_errcnt ++
		   End if
		Next		
		
		if adw_1.object.checkdouble[1]	=	1	then // 중복 체크
			adw_1.object.errcol[1] = '1'
			adw_1.object.errtext[1] = "같은 사번이 중복 입력되어 있습니다."
			ll_errcnt ++
		End if
		
	case 'per002'		
		For ll_cnt = 1 To adw_1.RowCount()
			ls_empno = adw_1.object.empno[ll_cnt]		
			ls_empno = string(dec(ls_empno), '000000')			
			adw_1.object.empno[ll_cnt]   = ls_empno
			
			ls_resno = adw_1.object.resno[ll_cnt]		
			ls_resno = f_replace_with(ls_resno,'-','')			
			adw_1.object.resno[ll_cnt]   = ls_resno
			
			select count(hkresno)
			 into :ll_count
			from pbpay.pay120
			where hkyy = :is_yy       and hkmm= :is_mm        and  hkempno = :ls_empno and
			      hkresno = :ls_resno and hkgubun = :is_grade 
					using sqlcc;
			
			if ll_count <> 1 then
				adw_1.object.errcol[ll_cnt] = '1'
				adw_1.object.errtext[ll_cnt] = "학자금관리에 해당월 자녀정보 미존재합니다."
				ll_errcnt ++
			End if
		next     
		
		if adw_1.object.checkdouble1[1]	=	1	then // 중복 체크
			adw_1.object.errcol[1] = '1'
			adw_1.object.errtext[1] = "자녀주민 번호 중복 입력되어 있습니다."
			ll_errcnt ++
		End if	
		
	case 'per003'		
		if adw_1.object.checkdouble1[1]	=	1	then // 중복 체크
			adw_1.object.errcol[1] = '1'
			adw_1.object.errtext[1] = "동일인이 중복 입력되어 있습니다."
			ll_errcnt ++
		End if
		
	case 'med001'
		if adw_1.object.checkdouble[1]	=	1	then // 중복 체크
			adw_1.object.errcol[1] = '1'
			adw_1.object.errtext[1] = "같은 품번이 두번이상 입력되었습니다."
			ll_errcnt ++
		End if
		
		For ll_cnt = 1 To adw_1.RowCount()
	
//			ls_cexamdate = adw_1.object.cexamdate[ll_cnt]	
//			
//			adw_1.object.cexamdate[ll_cnt] = Mid(trim(ls_cexamdate),1,4) + Mid(trim(ls_cexamdate),6,2) + Mid(trim(ls_cexamdate),9,2) 
		//	ls_ficode = adw_1.object.ficode[ll_cnt] 
		//	
		//	ld_km = adw_1.object.km[ll_cnt]
		//	ld_oil1 = adw_1.object.oil1[ll_cnt]
		//	ld_oil2 = adw_1.object.oil2[ll_cnt]
		//	ld_oilmeney = adw_1.object.oilmeney[ll_cnt]
		//	ld_repair = adw_1.object.repair[ll_cnt]
		//	ld_toll = adw_1.object.toll[ll_cnt]
		//	ld_parking = adw_1.object.parking[ll_cnt]
		//	ld_insurance = adw_1.object.insurance[ll_cnt]
		//	ld_fee = adw_1.object.fee[ll_cnt]
		//	ld_amt1 = adw_1.object.amt1[ll_cnt]
		//	
		//	ld_total_km = dec(ld_km)
		//	
		//	if dw_1.object.checkdouble[1]	=	1	then // 중복 체크
		//		adw_1.object.errcol[ll_cnt] = '1'
		//		adw_1.object.errtxt[ll_cnt] = "같은 품번이 두번이상 입력되었습니다."
		//		Return ll_cnt
		//	End if
		//	
		//	ll_diskm = ld_total_km - f_total_km( ls_ficode, is_yy + is_mm ) 
		//	
		//	if ll_diskm < 0 Or ll_diskm > 12000 then
		//		adw_1.object.errcol[ll_cnt] = '9'
		//		adw_1.object.errtext[ll_cnt] = "주행거리를 확인바랍니다."
		//	End if
		//	
		//	if is_gubun = 'A' then		
		//		if wf_month_carcheck( is_yy + is_mm , ls_ficode) <> 1 then
		//			adw_1.object.errcol[ll_cnt] = '1'
		//			adw_1.object.errtext[ll_cnt] = "해당월 차량유지비 입력 대상이 아닙니다."
		//			Return ll_cnt
		//		End if
		//	else 
		//		if wf_month_unbancheck( is_yy + is_mm , ls_ficode) <> 1 then
		//			adw_1.object.errcol[ll_cnt] = '1'
		//			adw_1.object.errtext[ll_cnt] = "해당월 운반구유지비 입력 대상이 아닙니다."
		//			Return ll_cnt
		//		End if
		//	End if
		//
		//	If f_spacechk(ld_km) = -1 then
		//		adw_1.object.km[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_oil1) = -1 then
		//		adw_1.object.oil1[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_oil2) = -1 then
		//		adw_1.object.oil2[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_oilmeney) = -1 then
		//		adw_1.object.oilmeney[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_repair) = -1 then
		//		adw_1.object.repair[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_toll) = -1 then
		//		adw_1.object.toll[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_parking) = -1 then
		//		adw_1.object.parking[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_insurance) = -1 then
		//		adw_1.object.insurance[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_fee) = -1 then
		//		adw_1.object.fee[ll_cnt] = '0'				
		//	End if
		//	If f_spacechk(ld_amt1) = -1 then
		//		adw_1.object.amt1[ll_cnt] = '0'				
		//	End if			
		Next
	case 'med002'
		if adw_1.object.checkdouble[1]	=	1	then // 중복 체크
			adw_1.object.errcol[1] = '1'
			adw_1.object.errtext[1] = "같은 품번이 두번이상 입력되었습니다."
			ll_errcnt ++
		End if
	case else
		
End choose


/********************************************************************/
//uo_status.st_message.text ="저장완료!!!"

return ll_errcnt
end function

public function integer wf_month_carcheck (string ag_ym, string ag_ficode);int li_cnt

	SELECT count(*)
	  Into :li_cnt
    FROM "PBGEN"."GEN210" LEFT OUTER JOIN "PBFIA"."FIA030"  
        ON "PBGEN"."GEN210"."FICODE" = "PBFIA"."FIA030"."FICODE"
   WHERE  "PBGEN"."GEN210"."CUSE" = 'Y'  AND
        ( 
         (SUBSTRING("PBGEN"."GEN210"."FICODE",1,3) IN ( 'E11','E12','E13','E14') AND
         ( "PBFIA"."FIA030"."FISTAGU" IN ( '1','4','6')   or
           ( "PBFIA"."FIA030"."FISTAGU"  IN ( '2','3') and   SUBSTRING("PBFIA"."FIA030"."FIACCDATE",1,6) >= :ag_ym  )
         )
         ) OR SUBSTRING("PBGEN"."GEN210"."FICODE",1,3) = 'Z11'
        ) AND "PBGEN"."GEN210"."FICODE" = :ag_ficode
	Using sqlcc;
	
if sqlcc.sqlcode <> 0 then
	Return 0
else
	Return li_cnt
End if
end function

public function integer wf_month_unbancheck (string ag_ym, string ag_ficode);int li_cnt

	SELECT count(*)
	  Into :li_cnt
    FROM "PBGEN"."GEN210" , "PBFIA"."FIA030" 
   WHERE "PBGEN"."GEN210"."FICODE" = "PBFIA"."FIA030"."FICODE" AND
         "PBGEN"."GEN210"."CUSE"   = 'Y'  AND
         SUBSTRING("PBGEN"."GEN210"."FICODE",1,3) IN ( 'E31','E33','E35','E39') AND
         ( "PBFIA"."FIA030"."FISTAGU"  IN ( '1','4','6')   or
           ("PBFIA"."FIA030"."FISTAGU"  IN ( '2','3') and   SUBSTRING("PBFIA"."FIA030"."FIACCDATE",1,6) >= :ag_ym  )
         ) AND
         "PBGEN"."GEN210"."FICODE" = :ag_ficode
	Using sqlcc;
	
if sqlcc.sqlcode <> 0 then
	Return 0
else
	Return li_cnt
End if
end function

public function integer wf_existchk (string ag_empno, string ag_yy, string ag_no, string ag_xdate);int li_cnt

	SELECT count(*)
	  Into :li_cnt
    FROM "PBMED"."MED130"    
	 WHERE "PBMED"."MED130"."CEMPNO" = :ag_empno AND
			 "PBMED"."MED130"."CYEAR"    = :ag_yy     AND
			 "PBMED"."MED130"."CNO"    = :ag_no AND
			 "PBMED"."MED130"."CEXAMDATE"    = :ag_xdate
	Using sqlcc;
	
if li_cnt > 0 then
	Return 1
else
	Return 0
End if
end function

on w_per_excelup.create
this.dw_title=create dw_title
this.p_1=create p_1
this.st_2=create st_2
this.mle_1=create mle_1
this.cb_4=create cb_4
this.sle_2=create sle_2
this.cb_3=create cb_3
this.cb_create=create cb_create
this.st_7=create st_7
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.dw_2=create dw_2
this.Control[]={this.dw_title,&
this.p_1,&
this.st_2,&
this.mle_1,&
this.cb_4,&
this.sle_2,&
this.cb_3,&
this.cb_create,&
this.st_7,&
this.dw_1,&
this.uo_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.gb_1,&
this.gb_2,&
this.gb_4,&
this.dw_2}
end on

on w_per_excelup.destroy
destroy(this.dw_title)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.cb_4)
destroy(this.sle_2)
destroy(this.cb_3)
destroy(this.cb_create)
destroy(this.st_7)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.dw_2)
end on

event open;////st_12.text = mid(g_s_date,1,6)
//
//Str_Open_Parm	lStr_Parm

String ls_parm

ls_Parm = Message.StringParm	

is_gubun = Mid(ls_parm, 1, 6)
is_gubun2 = mid(ls_parm, 7)

//is_yy    = Mid(ls_parm, 2, 4)
//is_mm	   = Mid(ls_parm, 6, 2)
//
//if is_gubun = 'A' then //차량유지비
//   st_1.text = is_yy + "년 " + is_mm + "월 차량유지비 일괄 입력" 
//	rb_2.checked = true
//	rb_1.enabled = false
//	dw_1.DataObject = "d_gen220b_01"
//	dw_1.SetTransObject( SQLCC )
//else 
//	st_1.text = is_yy + "년 " + is_mm + "월 운반구유지비 일괄 입력" 
//	rb_1.checked = true
//	rb_2.enabled = false
//	dw_1.DataObject = "d_gen220b_011"
//	dw_1.SetTransObject( SQLCC )
//End if
//
choose case is_gubun
	case 'per001' //생산직 개인정보 수정
		dw_1.Reset()
		dw_2.Reset()
		dw_1.DataObject = "d_per_excelup_per001"
		dw_2.DataObject = ""
		dw_1.SetTransObject( sqlcc )
		dw_2.SetTransObject( sqlcc )
	case 'per002' //학자금 중,고생 일괄입력
		is_yy 	 = mid(is_gubun2,1,4)
		is_mm 	 = mid(is_gubun2,5,2)
		is_grade = mid(is_gubun2,7,2)
		
		dw_1.Reset()
		dw_2.Reset()
		dw_1.DataObject = "d_per_excelup_per002"
		dw_2.DataObject = ""
		dw_1.SetTransObject( sqlcc )
		dw_2.SetTransObject( sqlcc )	
	case 'per003' //경조사 연락처일괄입력
				
		dw_1.Reset()
		dw_2.Reset()
		dw_1.DataObject = "d_per_excelup_per003"
		dw_2.DataObject = "d_per_excel_per301"
		dw_1.SetTransObject( sqlcc )
		dw_2.SetTransObject( sqlcc )	
	case 'med001'
		dw_1.Reset()
		dw_2.Reset()
		dw_1.DataObject = "d_per_excelup_med001"
		dw_2.DataObject = "d_per_excel_med130"
		dw_1.SetTransObject( sqlcc )
		dw_2.SetTransObject( sqlcc )
	case 'med002'
		dw_1.Reset()
		dw_2.Reset()
		dw_1.DataObject = "d_per_excelup_med002"
		dw_2.DataObject = "d_per_excel_med130"
		dw_1.SetTransObject( sqlcc )
		dw_2.SetTransObject( sqlcc )
	case else
End choose

dw_2.visible = false
end event

event activate;f_center_window(This)
end event

event close;//Destroy ids_carinfo_ins
end event

type dw_title from datawindow within w_per_excelup
integer x = 1819
integer y = 60
integer width = 1737
integer height = 144
integer taborder = 40
string title = "none"
string dataobject = "d_per_excelup_title"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_per_excelup
integer x = 306
integer y = 1844
integer width = 133
integer height = 72
string picturename = "C:\KDAC\bmp\blink1.gif"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_per_excelup
integer x = 18
integer y = 1840
integer width = 407
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12639424
string text = "정보화면:"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_per_excelup
integer x = 425
integer y = 1840
integer width = 3895
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217858
long backcolor = 15793151
string text = "엑셀파일 형식 : 1번째 라인은 위 화면 제목, 2번째 라인부터 데이타, 화면과 같은 양식의 값이여야 합니다! "
integer tabstop[] = {0}
boolean displayonly = true
borderstyle borderstyle = styleshadowbox!
end type

type cb_4 from commandbutton within w_per_excelup
integer x = 3945
integer y = 96
integer width = 379
integer height = 112
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
string pointer = "HyperLink!"
string text = "닫기"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "")

////close(w_frame.GetActiveSheet())
//
//close(w_inv101b)
end event

type sle_2 from singlelineedit within w_per_excelup
integer x = 297
integer y = 72
integer width = 1513
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
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_per_excelup
integer x = 41
integer y = 72
integer width = 261
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료경로"
end type

event clicked;String ls_PathName, ls_FileName, ls_msg
Int li_Rtn
Long ll_cnt, ll_rowcnt

IF dw_1.RowCount() > 0 Then		
	IF MessageBox("UPLOAD","작업중인 자료가 존재합니다. ~r~n~r~n무시하고 UPLOAD작업을 진행하시겠습니까?",Question!,YesNo!, 2)  =  2 THEN
		RETURN
	End IF	
END IF

dw_1.Reset()

//ls_PathName = "C:\Documents and Settings\내컴퓨터\바탕 화면"
//SetCurrentDirectoryA(ls_PathName)

SetPointer(HourGlass!)

li_Rtn = f_get_excel_per(dw_1,1,0, ls_PathName) //Target, 가로(제목), 세로(제목)

sle_2.text = ls_PathName

if li_rtn <> -1 then
  
  ll_rowcnt = dw_1.rowcount()
  
  st_5.text = string(ll_rowcnt)
  
  ll_cnt = wf_Errchk(dw_1)
  
	if ll_cnt = 0 then
		cb_create.enabled = True
		mle_1.text = "[정보생성]을 클릭하면 엑셀자료가 저장됩니다."
	else 
//		dw_1.scrolltorow(ll_cnt)
//		dw_1.selectrow(ll_cnt,true)
		mle_1.text = " 엑셀파일 오류 수정후 재업로드 해주세요. "
		cb_create.enabled = False
		Return -1
	End if  
	SetPointer(ARROW!)
   return 0
end if
	
MessageBox( '확인!', 'Excel UpLoad중 에러 발생! UpLoad 양식을 확인바랍니다.' )
Return -1
end event

type cb_create from commandbutton within w_per_excelup
integer x = 3561
integer y = 96
integer width = 379
integer height = 112
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
boolean enabled = false
string text = "정보생성"
end type

event clicked;long 	 ll_rowcnt, ll_currow, ll_complete, ll_rtncnt, ll_savecnt, ll_InsertRow
dec{0} ld_amt
Int    li_Rtn
Int    li_index, rtn, ll_insert
String ls_message, ls_cexamdate, ls_empno, ls_dept, ls_class
string ls_namek, ls_cphone, ls_addr, ls_post, ls_tel	
string ls_resno

If f_Mandatory_Chk( dw_1 ) = -1 Then // 필수입력항목 Check...
	Return 1 
End If

dw_1.accepttext()

ll_savecnt = 0
ll_rowcnt = dw_1.rowcount()

if ll_rowcnt < 1 then
	return 0
end if

dw_2.Reset()

setpointer(hourglass!)

f_sysdate()

choose case is_gubun
	case 'per001'//생산직 개인정보
		for ll_currow = 1 to ll_rowcnt
			dw_1.SelectRow(0, False)
			dw_1.SelectRow(ll_currow, True)	
			dw_1.ScrollToRow(ll_currow)
			
			ls_empno  = dw_1.object.empno[ll_currow]
			ls_cphone = dw_1.object.cphone[ll_currow] 
			ls_addr   = dw_1.object.siladdr[ll_currow]
			ls_post   = dw_1.object.silpost[ll_currow]
			ls_tel    = dw_1.object.tel[ll_currow]
			
			//인사자력
		  update pbper.per001
		  set pecphone   = :ls_cphone,
				 pesiladdr = :ls_addr,
				 pesilpost = :ls_post,
				 petel     = :ls_tel,
				 updtid    = :g_s_empno,
				 updtdt    = :g_s_datetime
		  where peempno = :ls_empno using sqlcc ;
		  
		  if sqlcc.sqlnrows  <> 1  then
			   f_per_errlog('u', 'per001', '(자력)생산직 개인정보 일괄업로드 :' + ls_empno )
				li_Rtn = 0
				goto skip_
			end if
			
			//공통자력
		  update pbcommon.dac003
		   set "PECPHONE"  = :ls_cphone,
				  "UPDTID"    = :g_s_empno,
				  "UPDTDT"    = :g_s_datetime 
		  where peempno = :ls_empno		using sqlcc ;

        if sqlcc.sqlnrows  <> 1  then
			    f_per_errlog('u', 'per001', '(공통)생산직 개인정보 일괄업로드 :' + ls_empno )
				li_Rtn = 0
				goto skip_
		   end if			
			
			ll_savecnt   = ll_savecnt +1	
			ll_complete = ll_currow * 100 / ll_rowcnt	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_savecnt,"###,### ")				
		Next
		
		li_Rtn = 1
		goto skip_
		
 case 'per002'//학자금 
		for ll_currow = 1 to ll_rowcnt
			dw_1.SelectRow(0, False)
			dw_1.SelectRow(ll_currow, True)	
			dw_1.ScrollToRow(ll_currow)
			
			ls_empno = dw_1.object.empno[ll_currow]
			ls_resno = dw_1.object.resno[ll_currow] 
			ld_amt   = dec(dw_1.object.amt[ll_currow])
			
			update pbpay.pay120
			set hkamt2    = :ld_amt,
				 hktotal   = decimal((hkamt1 + :ld_amt) * hkrate /100,10,0),
				 updtid    = :g_s_empno,
				 updtdt    = :g_s_datetime
			where hkyy = :is_yy       and hkmm= :is_mm        and  hkempno = :ls_empno and
			      hkresno = :ls_resno and hkgubun = :is_grade 
					using sqlcc;
		  
		  if sqlcc.sqlnrows  <> 1  then
			   f_per_errlog('u', 'per002', '학자금 일괄업로드 :' + ls_empno )
				li_Rtn = 0
				goto skip_
			end if			
			
			ll_savecnt   = ll_savecnt +1	
			ll_complete = ll_currow * 100 / ll_rowcnt	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_savecnt,"###,### ")				
		Next
		
		li_Rtn = 1
		goto skip_	
	
	case 'per003' //경조사통보 주소록
		for ll_currow = 1 to ll_rowcnt
			dw_1.SelectRow(0, False)
			dw_1.SelectRow(ll_currow, True)	
			dw_1.ScrollToRow(ll_currow)
			
			ll_savecnt   = ll_savecnt +1	
			ll_insert    = dw_2.InsertRow(0)
			
			ls_namek = dw_1.object.namek[ll_currow]				
			
			dw_2.object.emp_name[ll_insert]     = ls_namek
			dw_2.object.empno[ll_insert]     	 = ''
			dw_2.object.emp_group[ll_insert]    =	is_gubun2
			
			select count(*) into :li_Rtn
			from pbper.per301
			where emp_name = :ls_namek and emp_group = :is_gubun2 using sqlcc;
			
			if li_Rtn > 0 then
				dw_2.SetitemStatus( ll_insert, 0, primary!, datamodified! )
				dw_2.SetitemStatus( ll_insert, 0, primary!, NotModified! )
			End if
			
			dw_2.object.cphone[ll_insert]       = dw_1.object.cphone[ll_currow]
			dw_2.object.text[ll_insert]         = dw_1.object.text[ll_currow]
			
			
			ll_complete = ll_currow * 100 / ll_rowcnt	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_savecnt,"###,### ")	
			
		Next	
		
	case 'med001'
		for ll_currow = 1 to ll_rowcnt
			dw_1.SelectRow(0, False)
			dw_1.SelectRow(ll_currow, True)	
			dw_1.ScrollToRow(ll_currow)
			
			ll_savecnt   = ll_savecnt +1	
			ll_insert    = dw_2.InsertRow(0)
			
			dw_2.object.cempno[ll_insert]    = dw_1.object.cempno[ll_currow]
			dw_2.object.cyear[ll_insert]     = dw_1.object.cyear[ll_currow]
			dw_2.object.cno[ll_insert]       = dw_1.object.cno[ll_currow]
			dw_2.object.cexamdate[ll_insert] = dw_1.object.cexamdate[ll_currow]
			dw_2.object.CDEPTNM[ll_insert]   = f_deptnmrtn(dw_1.object.cempno[ll_currow], 'A')
			dw_2.object.HEIGHT[ll_insert]    = dec(dw_1.object.HEIGHT[ll_currow])
			dw_2.object.WEIGHT[ll_insert]    = dec(dw_1.object.WEIGHT[ll_currow])
			dw_2.object.FAT[ll_insert]       = dw_1.object.FAT[ll_currow]
			dw_2.object.LEYE[ll_insert]      = dec(dw_1.object.LEYE[ll_currow])
			dw_2.object.REYE[ll_insert]      = dec(dw_1.object.REYE[ll_currow])
//			dw_2.object.FLEYE[ll_insert]     = dec(dw_1.object.FLEYE[ll_currow])
//			dw_2.object.FREYE[ll_insert]     = dec(dw_1.object.FREYE[ll_currow])
			dw_2.object.LEAR1000[ll_insert]  = dw_1.object.LEAR1000[ll_currow]
			dw_2.object.REAR1000[ll_insert]  = dw_1.object.REAR1000[ll_currow]
			dw_2.object.LEAR4000[ll_insert]  = dec(dw_1.object.LEAR4000[ll_currow])
			dw_2.object.REAR4000[ll_insert]  = dec(dw_1.object.REAR4000[ll_currow])
			dw_2.object.EYECOLOR[ll_insert]  = dw_1.object.EYECOLOR[ll_currow]
			dw_2.object.HBP[ll_insert]       = dec(dw_1.object.HBP[ll_currow])
			dw_2.object.LBP[ll_insert]       = dec(dw_1.object.LBP[ll_currow])
			dw_2.object.ABOTYPE[ll_insert]   = dw_1.object.ABOTYPE[ll_currow]
			dw_2.object.RHTYPE[ll_insert]    = dw_1.object.RHTYPE[ll_currow]
			dw_2.object.UGLUCOSE[ll_insert]  = dw_1.object.UGLUCOSE[ll_currow]
			dw_2.object.UPROTEIN[ll_insert]  = dw_1.object.UPROTEIN[ll_currow]
			dw_2.object.UOCCBLOOD[ll_insert] = dw_1.object.UOCCBLOOD[ll_currow]
			dw_2.object.UPH[ll_insert]       = dec(dw_1.object.UPH[ll_currow])
			dw_2.object.BGLUCOSE[ll_insert]  = dec(dw_1.object.BGLUCOSE[ll_currow])
			dw_2.object.BHEMOGLOBIN[ll_insert] = dec(dw_1.object.BHEMOGLOBIN[ll_currow])
			dw_2.object.HCT[ll_insert]       = dec(dw_1.object.HCT[ll_currow])
			dw_2.object.AST[ll_insert]       = dec(dw_1.object.AST[ll_currow])
			dw_2.object.ALT[ll_insert]       = dec(dw_1.object.ALT[ll_currow])
			dw_2.object.RGPT[ll_insert]      = dec(dw_1.object.RGPT[ll_currow])
			dw_2.object.TCHOL[ll_insert]     = dec(dw_1.object.TCHOL[ll_currow])
			dw_2.object.HBSAG[ll_insert]     = dw_1.object.HBSAG[ll_currow]
			dw_2.object.HBSAB[ll_insert]     = dw_1.object.HBSAB[ll_currow]
			dw_2.object.HBSRESULT[ll_insert] = dw_1.object.HBSRESULT[ll_currow]
			dw_2.object.CHESTPA[ll_insert]   = dw_1.object.CHESTPA[ll_currow]
			dw_2.object.LUMBARPA[ll_insert]  = dw_1.object.LUMBARPA[ll_currow]
			dw_2.object.ECG[ll_insert]       = dw_1.object.ECG[ll_currow]
			dw_2.object.HISTORYA[ll_insert]  = dw_1.object.HISTORYA[ll_currow]
			dw_2.object.HISTORYB[ll_insert]  = dw_1.object.HISTORYB[ll_currow]
			dw_2.object.LIFEHABIT[ll_insert] = dw_1.object.LIFEHABIT[ll_currow]
			dw_2.object.STATUS[ll_insert]    = dw_1.object.STATUS[ll_currow]
			dw_2.object.DECISION[ll_insert]  = dw_1.object.DECISION[ll_currow]
			dw_2.object.OPINION[ll_insert]   = dw_1.object.OPINION[ll_currow]
			dw_2.object.ORDERS[ll_insert]    = dw_1.object.ORDERS[ll_currow]
			dw_2.object.HOSPITAL[ll_insert]  = dw_1.object.HOSPITAL[ll_currow]
			
			if wf_existchk(dw_1.object.cempno[ll_currow], dw_1.object.cyear[ll_currow], dw_1.object.cno[ll_currow],dw_1.object.cexamdate[ll_currow]) = 1 then
				dw_2.SetitemStatus( ll_insert, 0, primary!, datamodified! )
				dw_2.SetitemStatus( ll_insert, 0, primary!, NotModified! )
			End if
			
			ll_complete = ll_currow * 100 / ll_rowcnt	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_savecnt,"###,### ")	
			
		Next
	case 'med002'
		for ll_currow = 1 to ll_rowcnt
			dw_1.SelectRow(0, False)
			dw_1.SelectRow(ll_currow, True)	
			dw_1.ScrollToRow(ll_currow)
			
			ll_savecnt   = ll_savecnt +1	
			ll_insert    = dw_2.InsertRow(0)
			
			dw_2.object.cempno[ll_insert]    = dw_1.object.cempno[ll_currow]
			dw_2.object.cyear[ll_insert]     = dw_1.object.cyear[ll_currow]
			dw_2.object.cno[ll_insert]       = dw_1.object.cno[ll_currow]
			dw_2.object.cexamdate[ll_insert] = dw_1.object.cexamdate[ll_currow]
			dw_2.object.CDEPTNM[ll_insert]   = f_deptnmrtn(dw_1.object.cempno[ll_currow], 'A')
			dw_2.object.CHESTPA2[ll_insert]  = dw_1.object.CHESTPA2[ll_currow]
			dw_2.object.TUBERCLE2[ll_insert] = dw_1.object.TUBERCLE2[ll_currow]
			dw_2.object.TUBERCLE22[ll_insert]= dw_1.object.TUBERCLE22[ll_currow]
			dw_2.object.HBP2[ll_insert]      = dec(dw_1.object.HBP2[ll_currow])
			dw_2.object.LBP2[ll_insert]      = dec(dw_1.object.LBP2[ll_currow])
			dw_2.object.LEYEP2[ll_insert]    = dw_1.object.LEYEP2[ll_currow]
			dw_2.object.REYEP2[ll_insert]    = dw_1.object.REYEP2[ll_currow]
			dw_2.object.EYER2[ll_insert]     = dw_1.object.EYER2[ll_currow]
			dw_2.object.ECG2[ll_insert]      = dw_1.object.ECG2[ll_currow]
			dw_2.object.TRIGLY2[ll_insert]   = dec(dw_1.object.TRIGLY2[ll_currow])
			dw_2.object.HDLCHOL2[ll_insert]  = dec(dw_1.object.HDLCHOL2[ll_currow]) 
			dw_2.object.ALBUMIN2[ll_insert]  = dec(dw_1.object.ALBUMIN2[ll_currow])
			dw_2.object.TPROTEIN2[ll_insert] = dec(dw_1.object.TPROTEIN2[ll_currow])
			dw_2.object.TBILIRUBIN2[ll_insert] = dec(dw_1.object.TBILIRUBIN2[ll_currow])
			dw_2.object.DBILIRUBIN2[ll_insert] = dec(dw_1.object.DBILIRUBIN2[ll_currow])
			dw_2.object.ALP2[ll_insert]        = dec(dw_1.object.ALP2[ll_currow])
			dw_2.object.LDH2[ll_insert]        = dec(dw_1.object.LDH2[ll_currow])
			dw_2.object.AFP2[ll_insert]        = dw_1.object.AFP2[ll_currow]
			dw_2.object.HBSAG2[ll_insert]      = dw_1.object.HBSAG2[ll_currow]
			dw_2.object.HBSAB2[ll_insert]      = dw_1.object.HBSAB2[ll_currow]
			dw_2.object.HBSRESULT2[ll_insert]  = dw_1.object.HBSRESULT2[ll_currow]
			dw_2.object.RBC2[ll_insert]        = dec(dw_1.object.RBC2[ll_currow])
			dw_2.object.WBC2[ll_insert]        = dec(dw_1.object.WBC2[ll_currow])
			dw_2.object.BUN2[ll_insert]        = dec(dw_1.object.BUN2[ll_currow])
			dw_2.object.CREATININE2[ll_insert] = dec(dw_1.object.CREATININE2[ll_currow])
			dw_2.object.URICACID2[ll_insert]   = dec(dw_1.object.URICACID2[ll_currow])
			dw_2.object.HEMATOCRIT2[ll_insert] = dec(dw_1.object.HEMATOCRIT2[ll_currow])
			dw_2.object.WHITEB2[ll_insert]     = dec(dw_1.object.WHITEB2[ll_currow])
			dw_2.object.REDB2[ll_insert]       = dec(dw_1.object.REDB2[ll_currow])
			dw_2.object.BGLUCOSE2[ll_insert]   = dec(dw_1.object.BGLUCOSE2[ll_currow])
			dw_2.object.AGLUCOSE2[ll_insert]   = dec(dw_1.object.AGLUCOSE2[ll_currow])
			dw_2.object.GEYE2[ll_insert]       = dw_1.object.GEYE2[ll_currow]
			dw_2.object.ETC2[ll_insert]        = dw_1.object.ETC2[ll_currow]
			dw_2.object.DECISION2[ll_insert]   = dw_1.object.DECISION2[ll_currow]
			dw_2.object.OPINION2[ll_insert]    = dw_1.object.OPINION2[ll_currow]
			dw_2.object.ORDERS2[ll_insert]     = dw_1.object.ORDERS2[ll_currow]
			dw_2.object.HOSPITAL2[ll_insert]   = dw_1.object.HOSPITAL2[ll_currow]			
			
		   if wf_existchk(dw_1.object.cempno[ll_currow], dw_1.object.cyear[ll_currow], dw_1.object.cno[ll_currow],dw_1.object.cexamdate[ll_currow]) = 1 then
				dw_2.SetitemStatus( ll_insert, 0, primary!, datamodified! )
				dw_2.SetitemStatus( ll_insert, 0, primary!, NotModified! )
			End if
			
			ll_complete = ll_currow * 100 / ll_rowcnt	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_savecnt,"###,### ")	
			
		Next		
	case else
End choose

f_per_nullchk( dw_2 )
f_per_inptid( dw_2 )

li_Rtn = dw_2.Update(True, False)

If li_Rtn = 1 Then    
	dw_2.ResetUpdate( )	
   mle_1.text = "엑셀자료 저장 완료되었습니다."
Else	
	mle_1.text = "엑셀자료 저장 실패 되었습니다." 
End if

setpointer(arrow!) 

cb_create.enabled = False

return

skip_:
If li_Rtn = 1 Then    
   mle_1.text = "엑셀자료 저장 완료되었습니다."
Else	
	mle_1.text = "엑셀자료 저장 실패 되었습니다." 
End if

setpointer(arrow!) 

cb_create.enabled = False

return

end event

type st_7 from statictext within w_per_excelup
integer x = 1637
integer y = 2016
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

type dw_1 from datawindow within w_per_excelup
integer x = 18
integer y = 212
integer width = 4302
integer height = 1620
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_per_excelup_per003"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

event constructor;//dw_1.DataObject = "d_mmm203u_04"
THIS.SetTransObject( SQLCC )
end event

type uo_1 from uo_progress_bar within w_per_excelup
event destroy ( )
integer x = 2176
integer y = 2012
integer width = 1408
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_per_excelup
integer x = 1307
integer y = 2028
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

type st_5 from statictext within w_per_excelup
integer x = 846
integer y = 2016
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

type st_4 from statictext within w_per_excelup
integer x = 544
integer y = 2024
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

type gb_1 from groupbox within w_per_excelup
integer x = 2126
integer y = 1944
integer width = 1513
integer height = 196
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

type gb_2 from groupbox within w_per_excelup
integer x = 489
integer y = 1944
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

type gb_4 from groupbox within w_per_excelup
integer x = 27
integer y = 4
integer width = 1792
integer height = 196
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_2 from datawindow within w_per_excelup
integer x = 1408
integer y = 712
integer width = 1970
integer height = 772
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_per_excel_per301"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;THIS.SetTransObject( SQLCC )
end event

