$PBExportHeader$w_rtn016b.srw
$PBExportComments$부대작업업로드
forward
global type w_rtn016b from w_origin_sheet06
end type
type st_1 from statictext within w_rtn016b
end type
type st_a1 from statictext within w_rtn016b
end type
type st_a2 from statictext within w_rtn016b
end type
type st_3 from statictext within w_rtn016b
end type
type st_daesang from statictext within w_rtn016b
end type
type st_55 from statictext within w_rtn016b
end type
type st_saeng from statictext within w_rtn016b
end type
type uo_1 from uo_progress_bar within w_rtn016b
end type
type dw_1 from datawindow within w_rtn016b
end type
type dw_update from datawindow within w_rtn016b
end type
type st_2 from statictext within w_rtn016b
end type
type st_4 from statictext within w_rtn016b
end type
type st_5 from statictext within w_rtn016b
end type
type gb_1 from groupbox within w_rtn016b
end type
type gb_2 from groupbox within w_rtn016b
end type
end forward

global type w_rtn016b from w_origin_sheet06
st_1 st_1
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
dw_update dw_update
st_2 st_2
st_4 st_4
st_5 st_5
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn016b w_rtn016b

type variables
dec i_n_complete
end variables

on w_rtn016b.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.dw_update=create dw_update
this.st_2=create st_2
this.st_4=create st_4
this.st_5=create st_5
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_a1
this.Control[iCurrent+3]=this.st_a2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_daesang
this.Control[iCurrent+6]=this.st_55
this.Control[iCurrent+7]=this.st_saeng
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.dw_update
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
end on

on w_rtn016b.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.dw_update)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_bretrieve;call super::ue_bretrieve;setpointer(HourGlass!)
dw_1.reset()

//if f_pdm_GetfromExcel(dw_1) <> 0 then
//	i_b_bcreate	  	= False
//	i_b_bretrieve	= True
//	i_b_dretrieve	= False
//	i_b_dprint		= False
//	i_b_dchar		= False
//	
//	return
//end if
//i_b_bcreate	  	= True
//i_b_bretrieve	= False
//i_b_dretrieve	= False
//i_b_dprint		= False
//i_b_dchar		= False

//** Problem Occured : 2012.11.01
//* 업로드용 엑셀파일을 텍스트파일로 변환한 상태에서 업로드 하므로 정상 업로드 됨
//* 
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
	MessageBox('확 인', '해당변환 파일' + ls_name + '이 존재합니다')
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

st_daesang.text = string(dw_1.rowcount(),"###,### ")
uo_status.st_message.text = st_daesang.text + " 개의 정보가 Upload 대기 중입니다"
end event

event open;call super::open;i_b_bcreate	  	= True
i_b_bretrieve	= True
i_b_dretrieve	= False
i_b_dprint		= False
i_b_dchar		= False
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
dw_update.settransobject(sqlca) 
end event

event ue_bcreate;call super::ue_bcreate;decimal    l_n_totalcnt,l_n_loopcnt,l_n_count,l_n_errcount
string     l_s_plant,l_s_dvsn,l_s_itno,l_s_line1,l_s_line2,l_s_opno,l_s_nvmo, ls_rcnvcd
string 	  l_s_mcno, l_s_term, ls_message, ls_chtime, ls_nextdate, ls_chkdate, l_s_remk, ls_chkitno
integer    Net,l_n_chkcount
dec{4}     l_d_rdmctm,l_d_rdlbtm

Net = messagebox("확 인", "특정품번에 대한 특정대체라인을 수정해야 할때 사용하시기 바랍니다. ~r~n" &
	+ " 자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 1)
if Net <> 1 then
	return 0
end if
setpointer(HourGlass!)
l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "자료 처리중(오류 확인중)..."

dw_1.accepttext()
l_n_errcount = 0

if l_n_totalcnt > 0 then
	ls_chkitno = trim(dw_1.object.rdplant[1]) + &
	trim(dw_1.object.rddvsn[1]) + &
	trim(dw_1.object.rditno[1]) + &
	trim(dw_1.object.rdline1[1]) + &
	trim(dw_1.object.rdline2[1])
end if

do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	
	l_s_plant  = trim(dw_1.object.rdplant[l_n_loopcnt])
	l_s_dvsn   = trim(dw_1.object.rddvsn[l_n_loopcnt])
	l_s_itno   = trim(dw_1.object.rditno[l_n_loopcnt])
	l_s_line1  = trim(dw_1.object.rdline1[l_n_loopcnt])
	l_s_line2  = trim(dw_1.object.rdline2[l_n_loopcnt])
	l_s_opno   = upper(trim(dw_1.object.rdopno[l_n_loopcnt]))	
	
	if ls_chkitno <> (l_s_plant + l_s_dvsn + l_s_itno + l_s_line1 + l_s_line2) then
		ls_message = "대표품번이 다르거나 대체라인이 다른 행이 존재합니다."
	end if
	
	select count(*) into :l_n_count from pbrtn.rtn013
	where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and rcline1 = :l_s_line1 and rcline2 = :l_s_line2 and 
			rcopno = :l_s_opno
	using sqlca;
	if l_n_count < 1 then
		ls_message = "공정정보가 존재하지 않습니다. 에러공정:" + l_s_opno
		l_n_errcount = l_n_errcount + 1
	end if
	
	select count(*) into :l_n_count from pbrtn.rtn013
	where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and rcline1 = :l_s_line1 and rcline2 = :l_s_line2 and 
			rcinchk = 'Y' and rcdlchk = 'N'
	using sqlca;
	if l_n_count > 0 then
		ls_message = "공정정보가 결재진행중이므로 확인바랍니다."
		l_n_errcount = l_n_errcount + 1
	end if
	
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
	end if
loop
if l_n_errcount > 0 then
   uo_status.st_message.text = ls_message		//자료를 수정후 처리바랍니다.	
	return 0
end if

ls_chtime = f_get_systemdate(sqlca)
ls_nextdate = f_relativedate(g_s_date,1)
SQLCA.AUTOCOMMIT = FALSE

SELECT COUNT(*) INTO :l_n_chkcount
FROM PBRTN.RTN014  
WHERE RDCMCD = :g_s_company AND RDPLANT = :l_s_plant AND RDDVSN = :l_s_dvsn AND
		RDITNO = :l_s_itno AND RDLINE1 = :l_s_line1 AND RDLINE2 = :l_s_line2
using sqlca;
if l_n_chkcount > 0 then
	// 기존부대작업 리스트 일괄 삭제
	UPDATE PBRTN.RTN014  
	SET	RDFLAG = 'D',   
		RDEPNO = :g_s_empno,     
		RDIPAD = :g_s_ipaddr,   
		RDUPDT = :g_s_date,   
		RDSYDT = :g_s_date  
	WHERE RDCMCD = :g_s_company AND RDPLANT = :l_s_plant AND RDDVSN = :l_s_dvsn AND
			RDITNO = :l_s_itno AND RDLINE1 = :l_s_line1 AND RDLINE2 = :l_s_line2
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "기존부대작업 리스트 일괄 삭제시에 오류가 발생하였습니다." 
		goto Rollback_
	end if
end if

select count(*) into :l_n_chkcount
from pbrtn.rtn013
where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
		rcitno = :l_s_itno and rcline1 = :l_s_line1 and rcline2 = :l_s_line2
using sqlca;
if l_n_chkcount > 0 then
	// 기본정보의 부대작업 수치 초기화
	update pbrtn.rtn013
	set rcnvcd = 'N', rcnvmc = 0, rcnvlb  = 0,
		 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date,
		 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
		 rcplemp = '', rcplchk = 'N', rcpltime = '',
		 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
	where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and rcline1 = :l_s_line1 and rcline2 = :l_s_line2
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "기본정보의 부대작업 수치 초기화에 오류가 발생하였습니다." 
		goto Rollback_
	end if
end if

for l_n_loopcnt = 1 to l_n_totalcnt
	l_s_plant  = trim(dw_1.object.rdplant[l_n_loopcnt])
	l_s_dvsn   = trim(dw_1.object.rddvsn[l_n_loopcnt])
	l_s_itno   = trim(dw_1.object.rditno[l_n_loopcnt])
	l_s_line1  = trim(dw_1.object.rdline1[l_n_loopcnt])
	l_s_line2  = trim(dw_1.object.rdline2[l_n_loopcnt])	
	l_s_opno   = upper(trim(dw_1.object.rdopno[l_n_loopcnt]))
	l_s_nvmo   = trim(dw_1.object.rdnvmo[l_n_loopcnt])	
	l_s_mcno   = trim(dw_1.object.rdmcno[l_n_loopcnt])	
	l_s_term   = trim(dw_1.object.rdterm[l_n_loopcnt])		
	l_d_rdmctm = dw_1.object.rdmctm[l_n_loopcnt]
	if isnull(l_d_rdmctm) then l_d_rdmctm = 0
	l_d_rdlbtm = dw_1.object.rdlbtm[l_n_loopcnt]
	if isnull(l_d_rdlbtm) then l_d_rdlbtm = 0
	l_s_remk   = trim(dw_1.object.rdremk[l_n_loopcnt])
	
//	SELECT COUNT(*) INTO :l_n_chkcount FROM PBRTN.RTN014
//	WHERE RDLOGID = :ll_logid AND RDCMCD = :g_s_company AND RDPLANT = :l_s_plant AND RDDVSN = :l_s_dvsn AND
//			RDITNO = :l_s_itno AND RDLINE1 = :l_s_line1 AND RDLINE2 = :l_s_line2 AND
//			RDOPNO = :l_s_opno AND RDNVMO = :l_s_nvmo AND RDMCNO = :l_s_mcno AND
//			RDTERM = :l_s_term
//	using sqlca;
//	
//	if l_n_chkcount > 0 then
//		//부대정보
//		UPDATE PBRTN.RTN014  
//		SET RDNVMO = :l_s_nvmo,   
//			RDMCNO = :l_s_mcno,   
//			RDTERM = :l_s_term,   
//			RDMCTM = :l_d_rdmctm,   
//			RDLBTM = :l_d_rdlbtm,   
//			RDREMK = :l_s_remk,   
//			RDFLAG = 'R',   
//			RDEPNO = :g_s_empno,     
//			RDIPAD = :g_s_ipaddr,   
//			RDUPDT = :g_s_date,   
//			RDSYDT = :g_s_date  
//		WHERE RDLOGID = :ll_logid AND RDCMCD = :g_s_company AND RDPLANT = :l_s_plant AND RDDVSN = :l_s_dvsn AND
//				RDITNO = :l_s_itno AND RDLINE1 = :l_s_line1 AND RDLINE2 = :l_s_line2 AND
//				RDOPNO = :l_s_opno AND RDNVMO = :l_s_nvmo AND RDMCNO = :l_s_mcno AND
//				RDTERM = :l_s_term
//		using sqlca;
//		if sqlca.sqlnrows < 1 then
//			ls_message = "부대정보 수정시에 오류가 발생했습니다. : " + sqlca.sqlerrtext
//			goto Rollback_
//		end if
//	else
		INSERT INTO PBRTN.RTN014  
      ( RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
        RDTERM, RDMCTM,  RDLBTM, RDREMK, RDFLAG, RDEPNO, RDEDFM,   
        RDIPAD, RDUPDT, RDSYDT )  
		VALUES (:g_s_company,:l_s_plant,:l_s_dvsn,:l_s_itno,:l_s_line1,:l_s_line2,:l_s_opno,:l_s_nvmo,:l_s_mcno,
		  :l_s_term, :l_d_rdmctm, :l_d_rdlbtm, :l_s_remk, 'A', :g_s_empno, '',
		  :g_s_ipaddr, :g_s_date, :g_s_date )
		using sqlca;
		if sqlca.sqlcode <> 0 then
			ls_message = "부대정보 생성시에 오류가 발생했습니다. : " + sqlca.sqlerrtext
			goto Rollback_
		end if
//	end if
	
	select sum(rdmctm), sum(rdlbtm), count(*) into :l_d_rdmctm, :l_d_rdlbtm, :l_n_chkcount
	from pbrtn.rtn014
	WHERE rdcmcd = :g_s_company AND rdplant = :l_s_plant AND rddvsn = :l_s_dvsn AND
			rditno = :l_s_itno AND rdline1 = :l_s_line1 AND rdline2 = :l_s_line2 AND
			rdopno = :l_s_opno and rdflag <> 'D'
	using sqlca;
	
	if l_n_chkcount = 0 then
		ls_rcnvcd = 'N'
		l_d_rdmctm = 0
		l_d_rdlbtm = 0
	else
		ls_rcnvcd = 'Y'
	end if
	
	update pbrtn.rtn013
	set rcnvcd = :ls_rcnvcd, rcnvmc = :l_d_rdmctm, rcnvlb  = :l_d_rdlbtm,
		 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'R',
		 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
		 rcplemp = '', rcplchk = 'N', rcpltime = '',
		 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
	where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and rcline1 = :l_s_line1 and rcline2 = :l_s_line2 and 
			rcopno = :l_s_opno 
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "부대작업에 해당하는 공정정보가 없습니다." &
			+ l_s_itno + " : " + l_s_line1 + " : " + l_s_line2 + " : "  + l_s_opno
		goto Rollback_
	end if
next

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

uo_status.st_message.text = "오류 없음. 저장중..."
uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_totalcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//저장이 되었습니다.
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
Messagebox("알림",ls_message)

return -1

end event

type uo_status from w_origin_sheet06`uo_status within w_rtn016b
integer y = 2464
end type

type st_1 from statictext within w_rtn016b
integer x = 329
integer y = 32
integer width = 4059
integer height = 96
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  EXCEL UPLOAD  ◎"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_a1 from statictext within w_rtn016b
integer x = 1353
integer y = 1620
integer width = 2103
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
string text = "１.~'대상조회~'를 눌러 대상건수를 확인 하십시오."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_rtn016b
integer x = 1353
integer y = 1716
integer width = 2103
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
string text = "２. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_rtn016b
integer x = 1463
integer y = 1904
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

type st_daesang from statictext within w_rtn016b
integer x = 1787
integer y = 1896
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

type st_55 from statictext within w_rtn016b
integer x = 2514
integer y = 1904
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

type st_saeng from statictext within w_rtn016b
integer x = 2843
integer y = 1896
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

type uo_1 from uo_progress_bar within w_rtn016b
event destroy ( )
integer x = 1669
integer y = 2180
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_rtn016b
integer x = 329
integer y = 352
integer width = 4059
integer height = 1188
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_rtn016b_display"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_update from datawindow within w_rtn016b
boolean visible = false
integer x = 475
integer y = 352
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_rtn303b_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_rtn016b
integer x = 334
integer y = 112
integer width = 626
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "*** 주의사항 ***"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rtn016b
integer x = 343
integer y = 188
integer width = 2894
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "1. 특정대표품번에 대한 특정 대체라인정보만 업로드 할수 있게 자료를 작성해 주시기 바랍니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_rtn016b
integer x = 311
integer y = 268
integer width = 2990
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "2. 특정대표품번에 대한 특정 대체라인 전체공정에 대한 부대작업이 업로드 되도록 작성바랍니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_rtn016b
integer x = 1381
integer y = 1808
integer width = 2011
integer height = 236
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_rtn016b
integer x = 1381
integer y = 2084
integer width = 2011
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

