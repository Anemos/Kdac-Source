$PBExportHeader$w_purcrtdb.srw
$PBExportComments$엑셀양식레이아웃을SQL문장전환
forward
global type w_purcrtdb from w_origin_sheet09
end type
type tab_1 from tab within w_purcrtdb
end type
type tabpage_1 from userobject within tab_1
end type
type dw_11 from datawindow within tabpage_1
end type
type dw_10 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_11 dw_11
dw_10 dw_10
end type
type tab_1 from tab within w_purcrtdb
tabpage_1 tabpage_1
end type
end forward

global type w_purcrtdb from w_origin_sheet09
integer width = 4699
string title = "샘플정보등록"
event ue_open_after ( )
event ue_keydown pbm_keydown
tab_1 tab_1
end type
global w_purcrtdb w_purcrtdb

type prototypes
Function boolean SetCurrentDirectoryA(ref string path) library "kernel32.dll" 
end prototypes

type variables
datawindowchild  idwc_1
integer          ii_tabindex
window           iw_sheet
datawindow idw_11, idw_12, idw_13, idw_14, idw_21, idw_22, idw_23, idw_24,idw_25,idw_26
datawindow idw_10, idw_20, idw_30, idw_31, idw_32, idw_40, idw_41, idw_42
datawindow idw_50, idw_51, idw_60, idw_61, idw_62, idw_temp6
string   is_colnm, is_mail_body
str_easy i_str_prt

Long     il_lastclickedrow

end variables

forward prototypes
public function long wf_mail_tabpage3 ()
end prototypes

event ue_open_after();
iw_sheet = w_frame.getactivesheet()


end event

event ue_keydown;if key=keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

public function long wf_mail_tabpage3 ();//********************각담당자에게 메일발송
long ll_row
string ls_mail, ls_mail_opm,ls_dept
int li_rtn
uo_status.st_message.text = ''

setpointer(hourglass!)


OLEobject	Mail  // 등록한 컴포넌트를  OLE 객체로 선언.
Mail = Create OLEobject // OLE 객체 생성.


// 레지스트리에 등록된 외부 컴포넌트(AspEmail.dll)에 Access해서 파워빌더에서 사용가능한
// OLE 객체로 생성.
li_rtn = Mail.ConnectToNewObject("Persits.MailSender")

If li_rtn <> 0 Then // Access에 실패하면...
	//MessageBox("Error", "Could not create Mail Object!")
	MessageBox("Error", "메일 컴포넌트를 설치하시고 작업하시기 바랍니다(노츠자료실참조).")
	uo_status.st_message.text = "메일 컴포넌트를 설치하시고 작업하시기 바랍니다(노츠자료실참조)."
	Return -1
End If
//해당부서가져오기
//  SELECT "PBCOMMON"."DAC003"."PEDEPT"  
//  INTO :ls_dept  
//  FROM "PBCOMMON"."DAC003"  
//  WHERE "PBCOMMON"."DAC003"."PEEMPNO" = :g_s_empno ;  

	

//messagebox('is_mail_body',is_mail_body)

//  **담당자 메일보내기 *** //
Mail.Reset // Mail객체 초기화.
Mail.IsHTML 	= True  // 메일 내용을 HTML 형식으로 보낼것인가 여부를 결정.
Mail.Host   	= "kdacn01.kdac.co.kr"  // SMTP 서버(우리는 Notes!!) 설정.
Mail.From		= f_pur040_get_mailaddr(g_s_empno ,'1')  // 보내는 사람 주소 설정.
Mail.FromName  = g_s_empno + " " + g_s_kornm  // 보내는 사람 이름 설정.

ls_mail = f_pur040_get_mailaddr(g_s_empno ,'2')  //부서장
//ls_mail = f_pur040_get_mailaddr('970077' ,'1')  
if match(trim(ls_mail), '@kdac.co.kr') = false then
	return -2
end if
Mail.AddAddress( ls_mail ) // 받는 사람 메일주소 설정.	
Mail.Subject   = "샘플 발송 승인요청 메일입니다."   // 메일 제목 설정.
is_mail_body = is_mail_body + ' ~<~B~R~>' + ' ~<~B~R~>' + &
        '승인작업은 ~"KDAC시스템/관리/외자관리/쿠리어물품발송/샘플발송팀장승인~" 에서 작업하세요.' 
Mail.Body		= is_mail_body
 // 메일 내용 설정.	
Mail.Send  //   --->  메일 발송.




Mail.DisConnectObject( )

uo_status.st_message.text = '메일발송 완료'

setpointer(arrow!)
return 1




end function

on w_purcrtdb.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_purcrtdb.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_retrieve;call super::ue_retrieve;String  ls_lib, ls_dbid, ls_dbname, ls_dbsql, ls_dbdesc, ls_name, ls_length, ls_xdesc, ls_type 
string  ls_xnull, ls_xdefault, ls_comment, ls_dropsql,ls_pathname,ls_filename
long    ll_row, ll_rcnt, ll_len 
int  li_rtn

SetPointer(hourglass!)

CHOOSE CASE ii_tabindex  // 
	CASE 1
		IF idw_10.AcceptText() = -1 THEN
			MessageBox('확인','에러난 곳 수정후 조회하세요!',Exclamation!)
			Return
		END IF
		//IF f_mandantory_chk(idw_10) = -1 THEN Return
		ls_lib    = upper(trim(idw_10.object.lib[1]))
		ls_dbid   = upper(trim(idw_10.object.dbid[1]))
		ls_dbname   = upper(trim(idw_10.object.dbname[1]))
		
		if g_s_empno = '970077' then
//			ls_PathName = 'D:\내문서\2008구매프로세스개선\산출물\설계'
//			ls_FileName = 'D:\내문서\2008구매프로세스개선\산출물\설계\*.*'
			ls_PathName = 'D:\내문서\업무-운영\DB자료'
			ls_FileName = 'D:\내문서\업무-운영\DB자료\*.*'
		end if
		
		SetCurrentDirectorya(ls_pathname)  //디렉토리 설정
		
		idw_11.reset()
		f_pur040_getdbexcel(idw_11,ls_dbid)
		idw_11.accepttext()
		if idw_11.rowcount() = 0 then
			messagebox('확인','생성할 DB자료없음')
			return
//		else
//			messagebox('확인','저장할 위치를 지정하세요!')
		end if
		//return
		
		
		string  ls_docname, ls_named  
		long ll_file
		if g_s_empno = '970077' then
			ls_docname = 'D:\내문서\SQL및소스\DB생성\' + ls_dbid + '.sql'
		else
			ls_docname = 'C:\KDAC\PBL\' + ls_dbid + '.sql'
		end if
		li_Rtn = GetFileSaveName( "Save file", ls_DocName, ls_named, "sql", &
								  "SQL Files (*.sql), *.sql" )
      If li_Rtn = 0 Then
			uo_status.st_message.text = "파일저장취소."
			Return 
		end if
		
		uo_status.st_message.text = "파일생성중입니다."
		
		ls_dbsql = 'CREATE TABLE ~"' + ls_dbid + '~" ( ~r~n'
      for ll_row = 1 to idw_11.rowcount()
			ls_name = upper(trim(idw_11.object.name[ll_row]))
			ls_type = upper(trim(idw_11.object.type[ll_row]))
			ls_length = upper(trim(idw_11.object.length[ll_row]))
			ls_xnull  = upper(trim(idw_11.object.xnull[ll_row]))
			ls_xdefault = upper(trim(string(idw_11.object.xdefault[ll_row])))
			Choose case ls_type
				case 'C','S'
					ls_length = "CHAR(" + ls_length + ")"
				case 'V'
					ls_length = "VARCHAR(" + ls_length + ")"	
				case 'N'
					ls_length = "NUMERIC(" + ls_length + ")"
				case 'I'
					ls_length = "INT(" + ls_length + ")"
				case else
					ls_length = "CHAR(" + ls_length + ")"
			End choose
			
			//ls_length = Replace(ls_length, 1, 1, "CHAR")
						
			ls_dbsql = ls_dbsql + ' ~"' + ls_name + '~" ' + ls_length 
			if ls_xnull = 'Y' then
				ls_dbsql = ls_dbsql + ' NULL ' 
			else
				ls_dbsql = ls_dbsql + ' NOT NULL ' 
			end if
			if ls_type = 'C' OR ls_type = 'V' or ls_type = 'S' then
				ls_dbsql = ls_dbsql + ' DEFAULT ~'' + ls_xdefault + '~', ~r~n'   
			else
				if isnumber(ls_xdefault) = false or ls_xdefault <> '' or isnull(ls_xdefault) then
				   ls_xdefault = '0' 
				end if	
				ls_dbsql = ls_dbsql + ' DEFAULT ' + ls_xdefault + ', ~r~n'   
		   end if
		next
		ls_dbsql = ls_dbsql + 'PRIMARY KEY ('
		for ll_row = 1 to idw_11.rowcount()
			ls_name = upper(trim(idw_11.object.name[ll_row]))
			ls_comment = upper(trim(idw_11.object.comment[ll_row]))
			if upper(mid(ls_comment,1,3)) = 'KEY' then
				ls_dbsql = ls_dbsql + ' ~"' + ls_name + '~", ' 
			end if
		next
		ls_dbsql = righttrim(ls_dbsql)
		ls_dbsql = replace(ls_dbsql, len(ls_dbsql),1,' ')
		ls_dbsql = ls_dbsql + ')); ~r~n'
		ll_file = fileopen(ls_docname,LINEmode!,write!,lockwrite!,replace!)

		if ll_File <= 0 then 
			Messagebox("오류","파일을 생성할 수 없습니다.") 
			return
		end if 
		filewrite(ll_file,ls_dbsql)
		fileclose(ll_file)
		
		//db생성문에 컬럼속성 문장 추가
		ll_file = fileopen(ls_docname,LINEmode!,write!,lockwrite!,Append!)
		if ll_File <= 0 then 
			Messagebox("오류","파일을 생성할 수 없습니다.") 
			return
		end if 
		//db명칭 및 속성값등록
		ls_dbdesc = 'insert into ~"PBCOMMON~".pbcattbl' + &
		'(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)' + & 
		'values ( ~'' + ls_dbid + '~', ~'' + ls_lib + '~', 0, 400, ~'N~', ~'N~', 0, 0, ~'                  ~', 0, 400, ~'N~', ~'N~', 0, 0, ~'                  ~', 0, 400 , ~'N~', ~'N~', 0, 0, ~'                  ~', ' + &
		'~'' + ls_dbname + '~') ; ~r~n'
		//컬럼속성값 등록
		for ll_row = 1 to idw_11.rowcount()
			ls_name = upper(trim(idw_11.object.name[ll_row]))
			ls_type = upper(trim(idw_11.object.type[ll_row]))
			ls_xdesc = upper(trim(idw_11.object.xdesc[ll_row]))
			ls_dbdesc = ls_dbdesc + &
		   'insert into ~"PBCOMMON~".pbcatcol' + &
		   '(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt )' + &
		    ' values ( ~'' + ls_dbid + '~', ~'' + ls_lib + '~', ~'' + ls_name + '~', ~'' + ls_xdesc + &
			 '~', 23 , ~'' + ls_xdesc + '~', 25, ' 
			if ls_type = 'C' or ls_type = 'V' or ls_type = 'S' then
				ls_dbdesc = ls_dbdesc + '23 , 0 , 0 , 0 , ~'N~', ~'' + ls_xdesc + '~' ) ; ~r~n'
			else
				ls_dbdesc = ls_dbdesc + '24 , 0 , 0 , 0 , ~'N~', ~'' + ls_xdesc + '~' ) ; ~r~n'
			end if
			if len(ls_dbdesc) > 30000 then  //변수값 한계 
				filewrite(ll_file,ls_dbdesc)
				ls_dbdesc = ''
			end if
		next
		filewrite(ll_file,ls_dbdesc)
      fileclose(ll_file)
		
//		ls_dropsql = 'DROP TABLE ' + ls_lib + '.' + ls_dbid 
//		
//		EXECUTE IMMEDIATE :ls_dropsql;
//		if sqlca.sqlcode <> 0 then
//			messagebox('확인','drop table오류:' + ls_dropsql + ' sqlcode:' +string(sqlca.sqlcode))
//		end if
//		EXECUTE IMMEDIATE :ls_dbsql;
//      if sqlca.sqlcode <> 0 then
//			messagebox('확인','create table오류:' + ' sqlcode:' +string(sqlca.sqlcode) + ls_dbsql)
//		end if

				
		
		
		
//		ll_tot = len(l_file)
//		do while true 
//			ll_writ = filewrite(ll_file,blobmid(l_file,ll_written+1) )
//			if ll_writ = 0 then exit
//			ll_written += ll_writ
//			if ll_Written >= ll_tot then exit
//		loop 
		
		
		uo_status.st_message.text = ls_docname + " 파일생성완료"
//		messagebox('확인',ls_docname + " 파일생성완료")	
		
//		IF ll_rcnt > 0 THEN
//			wf_icon_onoff(true,true,true,true,false,true,false,true,false)  //I,A,U,D,P
//			uo_status.st_message.text = "조회완료"
//		ELSE
//			//idw_11.InsertRow(0)
//			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
//			uo_status.st_message.text = "해당정보없음"
//		END IF
		
END CHOOSE	

SetPointer(arrow!)



end event

event ue_dprint;call super::ue_dprint;f_screen_print(this)
end event

event open;call super::open;this.event post ue_open_after()
end event

event ue_bcreate;call super::ue_bcreate;CHOOSE CASE ii_tabindex
	CASE 1
		MessageBox("확인","파일받기를 할 수 없는 텝입니다.")
		Return
	CASE 2
		IF idw_21.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_21)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
	CASE 3
		IF idw_31.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_31)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
END CHOOSE
end event

event ue_delete;call super::ue_delete;SetPointer(hourglass!)

String   ls_stcd, ls_ivno
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

CHOOSE CASE ii_tabindex
	
	CASE 1
		IF idw_11.rowcount() = 0  THEN
			MessageBox('확인','삭제할 Invoice를 조회하세요!',Exclamation!)
			Return
		END IF
		
		//상태코드로 삭제할수 있는 데이터 구분.
		ls_stcd = trim(idw_11.GetItemString(1,"stcd"))
		ls_ivno = idw_11.GetItemString(1,"ivno")
		
		IF ls_stcd <> 'A' and ls_stcd <> 'X' THEN
			CHOOSE CASE ls_stcd
				CASE 'B'
					MessageBox("확인","삭제불가:팀장승인 요청된 건입니다.",exclamation!)		
				CASE 'C'
					MessageBox("확인","삭제불가:팀장승인 완료된 건입니다.",exclamation!)		
				CASE 'D'
					MessageBox("확인","삭제불가:외자관리 확정된 건입니다.",exclamation!)		
			END CHOOSE
			Return
		END IF
			
		li_ok = MessageBox("삭제확인", &
								 "해당 Invoice(" + ls_ivno + ")가 완전히 삭제됩니다.~r" + &
						  		 "확인키를 누르세요!", &
								 Exclamation!, OKCancel!, 2)
		
		IF li_ok <> 1 THEN
		  	 // Process CANCEL.
			 rollback using sqlca;
			 uo_status.st_message.text = f_message("D030")	//삭제가 취소되었습니다.
			 Return
		END IF
				
		FOR ll_row = idw_12.RowCount() TO 1 step -1
			idw_12.Deleterow(ll_row)
		NEXT
		FOR ll_row = idw_13.RowCount() TO 1 step -1
			idw_13.Deleterow(ll_row)
		NEXT
		IF idw_12.Update(True,False) <> 1 THEN  // 찾기 : DataWindow controls:DBError event
			messagebox('확인','Invoice상세 품목정보 삭제중 오류,연락바랍니다!',Exclamation!)
			ROLLBACK USING sqlca;
			uo_status.st_message.text = 'Invoice상세 품목정보 삭제중 오류,연락바랍니다!'
			return
		end if
		IF idw_13.Update(True,False) <> 1 THEN  // 찾기 : DataWindow controls:DBError event
			messagebox('확인','Invoice BOX정보 삭제중 오류,연락바랍니다!',Exclamation!)
			ROLLBACK USING sqlca;
			uo_status.st_message.text = 'Invoice BOX정보 삭제중 오류,연락바랍니다!'
			return
		end if
		idw_11.Deleterow(0)
		IF idw_11.Update(True,False) <> 1 THEN  // 찾기 : DataWindow controls:DBError event
			messagebox('확인','Invoice기본정보 삭제중 오류,연락바랍니다!',Exclamation!)
			ROLLBACK USING sqlca;
			uo_status.st_message.text = 'Invoice기본정보 삭제중 오류,연락바랍니다!'
			return
		end if	
		COMMIT USING sqlca;
		idw_11.ResetUpdate()
		idw_12.ResetUpdate()
		idw_13.ResetUpdate()
		//This.triggerevent('ue_retrieve')
		uo_status.st_message.text = f_message("D010") //삭제
	CASE 2,3
		MessageBox("확인","삭제 할 수 없는 텝입니다.")
		Return
END CHOOSE		

end event

type uo_status from w_origin_sheet09`uo_status within w_purcrtdb
integer y = 2468
end type

type tab_1 from tab within w_purcrtdb
event create ( )
event destroy ( )
integer y = 4
integer width = 4617
integer height = 2464
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;ii_tabindex = newindex
g_n_tabno = newindex
CHOOSE CASE newindex
	CASE 1
		IF idw_11.rowcount() > 0 THEN
			wf_icon_onoff(true,false,false,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
	CASE 2
		wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
	CASE 3
		IF idw_31.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
END CHOOSE

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4581
integer height = 2348
long backcolor = 12632256
string text = "DB생성문만들기"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_11 dw_11
dw_10 dw_10
end type

on tabpage_1.create
this.dw_11=create dw_11
this.dw_10=create dw_10
this.Control[]={this.dw_11,&
this.dw_10}
end on

on tabpage_1.destroy
destroy(this.dw_11)
destroy(this.dw_10)
end on

type dw_11 from datawindow within tabpage_1
integer x = 14
integer y = 124
integer width = 4549
integer height = 2204
integer taborder = 40
string title = "none"
string dataobject = "d_pur050_crtdb_11"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_11 = this

//this.insertrow(0)
end event

event itemchanged;Dec     ld_width, ld_length, ld_height, ld_boxamt, ld_volume
Dec{5}  ld_cwet, ld_gwet, ld_scost2, ld_exch
String  ls_curr,  ls_xcode , ls_coitname

This.AcceptText()

CHOOSE CASE dwo.Name
	case 'nation'  //발송국
		select coalesce(max(coitname),''),coalesce(max(coextend),'')
		into :ls_coitname, :ls_xcode
		from  pbcommon.dac002
		where comltd = '01'
		and   cogubun = 'RCD200'
		and   cocode  = :data ;
		if trim(ls_xcode) = '' then
			MessageBox("확인", &
						  "발송국가별 지역구분이 등록되어있지 않습니다.~r" + &
						  "담당자에게 등록 요청 하십시요.", Exclamation!)
			return 1
		end if
		this.object.dstn[1]  = ls_coitname
		this.object.xarea[1] = ls_xcode
		if this.object.gwet[row] > 0 then //국가변경시 운송비 다시 셋팅
			idw_11.event post itemchanged(1,idw_11.object.gwet,string(idw_11.object.gwet[1]))
		end if
	case 'chk'
		if isnull(data)  then
			data = '0'
		end if
		if data = '1' then  //포장비체크
			if this.object.volume[row] = 0 then
				MessageBox("확인", &
						  "포장비옵션을 선택하기전에 부피를 먼저 입력하세요!",  &
						  Exclamation!)
			   return 1
			end if
			ld_volume = this.object.volume[row]
			Select coalesce(min(scost2),0) into :ld_boxamt
			from pbrcd.rcd410
			where comltd = '01'
			and   gubun = 'B'
			and   volume >= :ld_volume ; 
			this.object.boxamt[row] = ld_boxamt 
			if this.object.xpay[row] ='C' then
			  This.SetItem(row,'tamt',ld_boxamt)
		   else
				this.object.tamt[row] = this.object.tamt[row] + ld_boxamt 
		   end if
		end if
	CASE 'gwet','width','length','height','curr','boxamt'
		
		//목재포장비 값 가져오기
		ld_boxamt = This.GetItemDecimal(row,'boxamt')
		
		//부피중량 환산 cwet 계산
//		ld_width  = This.GetItemDecimal(row,'width')
//		ld_length = This.GetItemDecimal(row,'length')
//		ld_height = This.GetItemDecimal(row,'height')
//		this.object.volume[1] = ld_width * ld_length * ld_height
		
		ld_cwet   = this.object.volume[1] / 6000
      this.object.cwet[1] = ld_cwet   //자리수 무시 입력 		
		
	   ls_xcode = this.object.xarea[1] 
		
		if this.object.xpay[row] ='C' then  //콜렉트 금액없음
			return
		end if
		// * 가장 최근의 운임단가를 가져와야 한다.
		// 1.중량으로 운임단가(달러) 가져와야 한다.
		// 2.부피중량환산 > 중량 이면 부피중량환산무게로 운임단가(달러)가져와야 한다.
		// * 운임등급별로 중량이 정해져야한다.=>운임단가 등록시 이거 체크 안함.
		
		//// 운임 단가 가져오기.////////////////////////////////////////////////////
		
		//총중량
		ld_gwet = This.GetItemDecimal(1,'gwet')
		//This.SetItem(row,'cwet',ld_cwet)  //부피중량
		
		IF ld_cwet > ld_gwet THEN
			ld_gwet = ld_cwet         
		END IF	
		
		SELECT VALUE(MIN(SCOST2),0) 
		INTO   :ld_scost2
		FROM PBRCD.RCD410
		WHERE COMLTD = '01'       AND
				gubun  = 'A'        and
				xcode  =  :ls_xcode and
				WEIGHT >= :ld_gwet ;
				
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("확인", &
						  "운임단가를 가져 올수 없습니다.~r" + &
						  "발송국과 총중량 먼저 입력하세요. 그래도 오류시 전산 담당자에게 문의 하십시요!")
			return 1
		END IF
//		messagebox('',string(ls_xcode))
//		messagebox('',string(ld_gwet))
		IF ld_scost2 = 0 THEN		
			MessageBox("Database Error", &
						  "해당중량의 운임단가가 없습니다.~r" + &
						  "전산 담당자에게 문의 하십시요!")
			return 1
		END IF
				
		////// Setting/////////////////////////////////////////////////////////////
		// 1.운임단가로 외화 운송금액 Setting
		// 2.환율로 원화 운송비 계산.
		// 3.운송금액합까지 계산해서 Setting 완료.
		
		ls_curr = This.GetItemString(row,'curr')
		
		//환율 Setting
		SELECT EXCH1
		INTO   :ld_exch
		FROM PBRCD.RCD110
		WHERE COMLTD = '01'  AND
				GUBUN  = 'A'   AND
				CURR   = :ls_curr AND
				ADJDT  = ( SELECT MAX(ADJDT)
							  FROM PBRCD.RCD110
							  WHERE COMLTD = '01'     AND
									  GUBUN  = 'A'      AND
									  CURR   = :ls_curr AND
									  ADJDT  < '99999999' ) ;
									  
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("확인", &
						  "환율이 등록되어있지 않습니다.~r" + &
						  "담당자에게 환율등록 요청 하십시요.", Exclamation!)
			return 1
		END IF
		
		This.SetItem(row,'exch',ld_exch)
		This.SetItem(row,'samt',ld_scost2)
		This.SetItem(row,'wamt',ld_scost2 * ld_exch)
		This.SetItem(row,'ddpc',0 )
		This.SetItem(row,'boxamt',ld_boxamt)
		This.SetItem(row,'etc', 0)
		This.SetItem(row,'tamt',(ld_scost2 * ld_exch) + ld_boxamt)
		if this.object.xpay[row] = 'P' and this.object.tamt[row] > 200000 then
			MessageBox("확인", &
						  "20만원이상은 사전에 임원결재를 거쳐야 합니다.~r" + &
						  "확인하십시요.", Exclamation!)
		end if
	case 'sdate'  //발송일자체크
	   if isnull(data)  then
			data = ''
		end if
		if trim(f_dateedit(data))  = '' then
			MessageBox("확인", &
						  "발송일자" + &
						  "확인하십시요.", Exclamation!)
			return 1			  
		end if
	case 'xpay'  //지불방식
	   if isnull(data)  then
			data = ''
		end if
		if trim(data)  = 'P' then
			this.object.courier[row] = ''
			this.object.account[row] = ''
			if this.object.gwet[row] > 0 then //지불조건변경시 운송비 다시 셋팅
				idw_11.event post itemchanged(1,idw_11.object.gwet,string(idw_11.object.gwet[1]))
			end if
		end if	
		if trim(data)  = 'C' then
			if this.object.wamt[row] > 0 then
				MessageBox("참고","COLLECT조건으로" + &
						  "운송비 0입니다. 참고하세요.", Exclamation!)
				this.object.samt[row] = 0		  
				this.object.wamt[row] = 0	
				this.object.tamt[row] = this.object.boxamt[row] 		  		  
			end if	
		end if	
END CHOOSE


end event

event itemerror;return 1
end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

type dw_10 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
integer x = 41
integer y = 16
integer width = 2560
integer height = 92
integer taborder = 170
boolean bringtotop = true
string title = "none"
string dataobject = "d_pur050_crtdb_10"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;this.settransobject(sqlca)
idw_10 = this

//this.GetChild("div",idwc_1)
//idwc_1.SetTransObject(Sqlca)
//idwc_1.Retrieve('D')
//
//this.GetChild("pdcd",idwc_1)
//idwc_1.SetTransObject(Sqlca)
//idwc_1.Retrieve('A')

this.insertrow(0)
if g_s_empno = '970077' then
	this.object.lib[1] = 'PBPUR'
	this.object.dbid[1] = 'OPM401'
end if
f_pur040_nullchk03(this)

//this.object.frdt[1] = f_pur040_relativedate(g_s_date,-180)
//this.object.todt[1] = g_s_date
end event

event itemerror;return 1
end event

event losefocus;f_pur040_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event itemfocuschanged;CHOOSE CASE DWO.NAME
	CASE 'dbname'
		f_pur040_toggle(handle(this),'KOR')
	case else
		f_pur040_toggle(handle(this),'ENG')
End choose
end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

