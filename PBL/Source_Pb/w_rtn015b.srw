$PBExportHeader$w_rtn015b.srw
$PBExportComments$기본정보업로드
forward
global type w_rtn015b from w_origin_sheet06
end type
type st_1 from statictext within w_rtn015b
end type
type st_a1 from statictext within w_rtn015b
end type
type st_a2 from statictext within w_rtn015b
end type
type st_3 from statictext within w_rtn015b
end type
type st_daesang from statictext within w_rtn015b
end type
type st_55 from statictext within w_rtn015b
end type
type st_saeng from statictext within w_rtn015b
end type
type uo_1 from uo_progress_bar within w_rtn015b
end type
type dw_1 from datawindow within w_rtn015b
end type
type dw_update from datawindow within w_rtn015b
end type
type gb_1 from groupbox within w_rtn015b
end type
type gb_2 from groupbox within w_rtn015b
end type
end forward

global type w_rtn015b from w_origin_sheet06
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
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn015b w_rtn015b

type variables
dec i_n_complete
end variables

on w_rtn015b.create
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
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_rtn015b.destroy
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
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_bretrieve;call super::ue_bretrieve;setpointer(HourGlass!)
dw_1.reset()
st_daesang.text 	= ''
st_saeng.text 		= ''

//** Problem Occured : 2012.11.01
//* 다른 엑셀파일을 열어둔 상태에서 업로드파일을 선택하여 업로드하면 열어둔 엑셀파일자료로 선택되어짐
//* 
//if f_pdm_GetfromExcel(dw_1) <> 0 then
//	i_b_bcreate	  	= False
//	i_b_bretrieve	= True
//	i_b_dretrieve	= False
//	i_b_dprint		= False
//	i_b_dchar		= False
//	wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
//	return 0
//end if

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

//데이타 정열
dw_1.SetSort("RCPLANT,RCDVSN,RCITNO,RCLINE1,RCLINE2")
dw_1.Sort()

st_daesang.text 	= string(dw_1.rowcount(),"###,### ")
 
end event

event open;call super::open;i_b_bcreate	  	= True
i_b_bretrieve	= True
i_b_dretrieve	= False 
i_b_dprint		= False
i_b_dchar		= False
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
dw_update.settransobject(sqlca) 
end event

event ue_bcreate;call super::ue_bcreate;long    l_n_totalcnt,l_n_loopcnt,l_n_count,l_n_errcount
string     l_s_plant,l_s_dvsn,l_s_itno,l_s_rcline1,l_s_rcline2,l_s_rcopno, ls_chtime, ls_message
integer    Net,l_n_chkcount, l_n_rcopsq, l_n_rclbcnt
string 	l_s_rcedfm, l_s_rcopnm, l_s_rcline3, l_s_rcmcyn, l_s_rcnvcd, l_s_rcgrde
string 	l_s_cls, l_s_srce, l_s_pdcd, l_s_nextdate
dec{4}   l_d_rcbmtm, l_d_rcbltm, l_d_rcbstm, l_d_rcnvmc, l_d_rcnvlb
dec{5}   l_d_rcpower


Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 1)
if Net <> 1 then
	return 0
end if

setpointer(HourGlass!)
dw_1.accepttext()
l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "자료 처리중(오류 확인중)..."
l_s_plant  = trim(dw_1.object.rcplant[1])
l_s_dvsn   = trim(dw_1.object.rcdvsn[1])
l_d_rcpower = 0
l_s_nextdate = f_relativedate(g_s_date,1)
do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	l_s_plant  = trim(dw_1.object.rcplant[l_n_loopcnt])
	l_s_dvsn   = trim(dw_1.object.rcdvsn[l_n_loopcnt])
	l_s_itno   = trim(dw_1.object.rcitno[l_n_loopcnt])
	l_s_rcline1  = trim(dw_1.object.rcline1[l_n_loopcnt])
	l_s_rcline2  = trim(dw_1.object.rcline2[l_n_loopcnt])
	l_s_rcline3 = upper(trim((dw_1.getitemstring(l_n_loopcnt,"rcline3"))))
	l_s_rcopno   = Upper(trim(dw_1.object.rcopno[l_n_loopcnt]))
	l_d_rcpower  = l_d_rcpower + dw_1.getitemnumber(l_n_loopcnt,"rcpower")
	if isnull(l_d_rcpower) then l_d_rcpower = 0
	
	select count(*) into :l_n_chkcount
	from pbrtn.rtn013
	where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2 and
			rcinchk = 'Y' and rcdlchk = 'N'
	using sqlca;
	if l_n_chkcount > 0 then
		dw_1.setitem(l_n_loopcnt,"errortext","결재가 진행중에 있는 공정정보입니다.")
		l_n_errcount ++	
	end if
	
	select cls, srce, substring(pdcd,1,2) into :l_s_cls, :l_s_srce, :l_s_pdcd
	from pbinv.inv101
	where comltd = '01' and xplant = :l_s_plant and
		div = :l_s_dvsn and itno = :l_s_itno
	using sqlca;
	
	// 사내외주가공품 코스트센터 설정
	if l_s_cls = '50' and l_s_srce = '04' then
		SELECT center into :l_s_rcline3
		from pbrtn.costcenter
		where plant = :l_s_plant and div = :l_s_dvsn and pdcd = :l_s_pdcd
		using sqlca;
		
		dw_1.setitem(l_n_loopcnt,"rcline3",l_s_rcline3)
	end if
	// 사내라인 또는 조코드 체크
	if len(l_s_rcline3) = 4 then
		ls_message = f_get_deptnm(l_s_rcline3,'5')
	end if
	if f_spacechk(ls_message) = -1 then
		dw_1.setitem(l_n_loopcnt,"errortext","등록된 조코드가 아닙니다. : " + l_s_rcline3)
		l_n_errcount ++	
	end if
	
	//유사품번 등록여부 체크
	ls_message = f_rtn02_conv_itno(l_s_plant,l_s_dvsn,l_s_itno,g_s_date)
	if l_s_rcline1 = 'DUMMY' and l_s_rcline2 = '1' then
		DELETE FROM PBRTN.RTN011
		WHERE RACMCD = '01' AND RAPLANT = :l_s_plant AND
			RADVSN = :l_s_dvsn AND RAITNO1 = :l_s_itno
		using sqlca;
		
		DELETE FROM PBRTN.RTN018
		WHERE RHCMCD = '01' AND RHPLANT = :l_s_plant AND
			RHDVSN = :l_s_dvsn AND RHITNO1 = :l_s_itno
		using sqlca;
	else
		if ls_message <> l_s_itno then
			dw_1.setitem(l_n_loopcnt,"errortext","유사품번으로 등록되어 있는 품목입니다.")
			l_n_errcount ++	
		end if
	end if
	
	if l_s_rcline1 = 'DUMMY' and l_s_rcline2 = '1' then
		// pass
	else
		if l_s_cls = '50' and l_s_srce = '04' then
		  SELECT count(*) into :l_n_count from "PBPDM"."BOM001"
		  WHERE "PBPDM"."BOM001"."PLANT" = :l_s_PLANT AND "PBPDM"."BOM001"."PCITN" = :l_s_itno AND "PBPDM"."BOM001"."PDVSN" = :l_s_dvsn and
				  ( ("PBPDM"."BOM001"."PEDTM" <= "PBPDM"."BOM001"."PEDTE" AND "PBPDM"."BOM001"."PEDTE" <> ' ' AND "PBPDM"."BOM001"."PEDTE" >= :g_s_date )
				  OR  
			  ( "PBPDM"."BOM001"."PEDTE" = '' AND "PBPDM"."BOM001"."PEDTM" <= :g_s_date ))
		  using SQLCA ;
		else
			SELECT count(*) into :l_n_count from "PBPDM"."BOM001"
		  WHERE "PBPDM"."BOM001"."PLANT" = :l_s_PLANT AND "PBPDM"."BOM001"."PPITN" = :l_s_itno AND "PBPDM"."BOM001"."PDVSN" = :l_s_dvsn and
				  ( ("PBPDM"."BOM001"."PEDTM" <= "PBPDM"."BOM001"."PEDTE" AND "PBPDM"."BOM001"."PEDTE" <> ' ' AND "PBPDM"."BOM001"."PEDTE" >= :g_s_date )
				  OR  
			  ( "PBPDM"."BOM001"."PEDTE" = '' AND "PBPDM"."BOM001"."PEDTM" <= :g_s_date ))
		  using SQLCA ;
		end if
	   if	l_n_count <= 0 then
			dw_1.setitem(l_n_loopcnt,"errortext","BOM미등록품입니다.")
			l_n_errcount ++	
	   end if
   end if
  
  	select count(*) into :l_n_count from pbrtn.rtn012
		where rbcmcd = '01' and rbplant = :l_s_plant and rbdvsn = :l_s_dvsn and rbline1 = :l_s_rcline1 
	using sqlca;
	if l_n_count < 1 then 
		dw_1.setitem(l_n_loopcnt,"errortext","등록된 대체라인이 아닙니다.")
		l_n_errcount ++	
	end if
  
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
	end if
loop
if l_n_errcount > 0 or l_n_totalcnt < 1 then
	uo_status.st_message.text = "에러처리후 재작업 바랍니다."
	return -1
end if

if l_s_rcline1 = 'DUMMY' and l_s_rcline2 = '1' then
	//pass
else
	if l_d_rcpower <= 0 then
		uo_status.st_message.text = "소비전력이 입력되지 않았습니다. 재작업 바랍니다."
		return -1
	end if
end if

l_d_rcpower = 0

uo_status.st_message.text = "오류 없음. 저장중..."
l_n_loopcnt = 0

ls_chtime = f_get_systemdate(sqlca)
SQLCA.AUTOCOMMIT = FALSE

l_s_plant  = trim(dw_1.object.rcplant[1])
l_s_dvsn   = trim(dw_1.object.rcdvsn[1])
l_s_itno   = trim(dw_1.object.rcitno[1])
l_s_rcline1  = trim(dw_1.object.rcline1[1])
l_s_rcline2  = trim(dw_1.object.rcline2[1])

select count(*) into :l_n_chkcount
from pbrtn.rtn013
where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
		rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2
using sqlca;

if l_n_chkcount > 0 then
	update pbrtn.rtn013
	set rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'D',
		 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
		 rcplemp = '', rcplchk = 'N', rcpltime = '',
		 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
	where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
		rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2
	using sqlca;
	if sqlca.sqlnrows < 1 then
		ls_message = "기존 기본정보 삭제에러"
		goto Rollback_
	end if
end if

for l_n_loopcnt = 1 to l_n_totalcnt
	if ( l_s_plant <> trim(dw_1.object.rcplant[l_n_loopcnt]) ) or &
		( l_s_dvsn <> trim(dw_1.object.rcdvsn[l_n_loopcnt]) ) or &
		( l_s_itno  <> trim(dw_1.object.rcitno[l_n_loopcnt]) ) or &
		( l_s_rcline1 <> trim(dw_1.object.rcline1[l_n_loopcnt]) ) or &
		( l_s_rcline2 <> trim(dw_1.object.rcline2[l_n_loopcnt]) ) then
		
		l_s_plant  = trim(dw_1.object.rcplant[l_n_loopcnt])
		l_s_dvsn   = trim(dw_1.object.rcdvsn[l_n_loopcnt])
		l_s_itno   = trim(dw_1.object.rcitno[l_n_loopcnt])
		l_s_rcline1  = trim(dw_1.object.rcline1[l_n_loopcnt])
		l_s_rcline2  = trim(dw_1.object.rcline2[l_n_loopcnt])
		
		select count(*) into :l_n_chkcount
		from pbrtn.rtn013
		where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
				rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2
		using sqlca;
		
		if l_n_chkcount > 0 then
			update pbrtn.rtn013
			set rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'D',
				 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
				 rcplemp = '', rcplchk = 'N', rcpltime = '',
				 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
			where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
				rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2
			using sqlca;
			if sqlca.sqlnrows < 1 then
				ls_message = "기존 기본정보 삭제에러"
				goto Rollback_
			end if
		end if
	end if
	l_s_plant  = trim(dw_1.object.rcplant[l_n_loopcnt])
	l_s_dvsn   = trim(dw_1.object.rcdvsn[l_n_loopcnt])
	l_s_itno   = trim(dw_1.object.rcitno[l_n_loopcnt])
	l_s_rcline1  = trim(dw_1.object.rcline1[l_n_loopcnt])
	l_s_rcline2  = trim(dw_1.object.rcline2[l_n_loopcnt])
	l_s_rcopno  = upper(dw_1.getitemstring(l_n_loopcnt,"rcopno"))
	l_s_rcedfm  = dw_1.getitemstring(l_n_loopcnt,"rcedfm")
	l_s_rcopnm  = upper(dw_1.getitemstring(l_n_loopcnt,"rcopnm"))
	l_n_rcopsq  = dw_1.getitemnumber(l_n_loopcnt,"rcopsq")
	l_s_rcline3 = upper(trim((dw_1.getitemstring(l_n_loopcnt,"rcline3"))))
	l_s_rcmcyn  = 'N'
	l_d_rcbmtm  = dw_1.getitemnumber(l_n_loopcnt,"rcbmtm")
	l_d_rcbltm  = dw_1.getitemnumber(l_n_loopcnt,"rcbltm")
	l_d_rcbstm  = dw_1.getitemnumber(l_n_loopcnt,"rcbstm")
	l_n_rclbcnt = dw_1.getitemnumber(l_n_loopcnt,"rclbcnt")
	l_d_rcpower  = dw_1.getitemnumber(l_n_loopcnt,"rcpower")
	l_s_rcnvcd  = 'N'
	l_s_rcgrde  = ''
	if isnull(l_d_rcpower) then l_d_rcpower = 0
	
	if l_s_rcline1 = 'DUMMY' and l_s_rcline2 = '1' then
		// DUMMY Item 등록 2012.11.05
		delete from pbrtn.rtn013
		where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2
		using sqlca;
		
		delete from pbrtn.rtn015
		where recmcd = '01' and replant = :l_s_plant and redvsn = :l_s_dvsn and 
			reitno = :l_s_itno and reline1 = :l_s_rcline1 and reline2 = :l_s_rcline2
		using sqlca;
		
		insert into pbrtn.rtn013
			( rccmcd,rcplant,rcdvsn,rcitno,rcline1,rcline2,rcopno,rcchtime,rcedfm,
			rcopnm,rcopsq,rcline3,rcgrde,rcmcyn,rcbmtm,rcbltm,rcbstm,
			rcnvcd,rcnvmc,rcnvlb,rclbcnt,rcflag,rcepno,rcipad,rcupdt,rcsydt,
			rcinemp, rcinchk, rcintime, rcplemp, rcplchk, rcpltime,
			rcdlemp, rcdlchk, rcdltime, rcpower )
		values
			( '01',:l_s_plant,:l_s_dvsn,:l_s_itno,:l_s_rcline1,:l_s_rcline2,:l_s_rcopno,:ls_chtime,'',
			:l_s_rcopnm,:l_n_rcopsq,:l_s_rcline3,:l_s_rcgrde,:l_s_rcmcyn,:l_d_rcbmtm,:l_d_rcbltm,:l_d_rcbstm,
			:l_s_rcnvcd,:l_d_rcnvmc,:l_d_rcnvlb,:l_n_rclbcnt,'A',:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date,
			:g_s_empno, 'Y', '', '', 'Y','',
			'', 'Y','', :l_d_rcpower)
		using sqlca;
		if sqlca.sqlcode <> 0 then
			ls_message = "공정별 세부내역정보 입력할때 오류가 발생했습니다."
			goto Rollback_
		end if
		
		INSERT INTO PBRTN.RTN015( RECMCD, REPLANT, REDVSN, REITNO, RELINE1, RELINE2, REOPNO,
			REEDFM, REOPNM, REOPSQ, RELINE3, REGRDE, REMCYN, REBMTM, REBLTM,
			REBSTM, RENVCD, RENVMC, RENVLB, RELBCNT, REEDTO, REFLAG, 
			REEPNO, REIPAD, REUPDT, RESYDT, REINEMP, REINCHK, REINTIME,
			REPLEMP, REPLCHK, REPLTIME, REDLEMP, REDLCHK, REDLTIME, REPOWER )
		VALUES
			( '01',:l_s_plant,:l_s_dvsn,:l_s_itno,:l_s_rcline1,:l_s_rcline2,:l_s_rcopno,
			:l_s_nextdate,:l_s_rcopnm,:l_n_rcopsq,:l_s_rcline3,:l_s_rcgrde,:l_s_rcmcyn,:l_d_rcbmtm,:l_d_rcbltm,
			:l_d_rcbstm,:l_s_rcnvcd,:l_d_rcnvmc,:l_d_rcnvlb,:l_n_rclbcnt,'99991231','A',
			:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date,:g_s_empno, 'Y', '',
			:g_s_empno,'Y','',:g_s_empno, 'Y','', :l_d_rcpower)
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ls_message = "DUMMY 품번 입력시에 오류가 발생했습니다."
			goto Rollback_
		end if
		
		continue
	end if
	
	// 장비유무 체크
	select count(*) into :l_n_chkcount from pbrtn.rtn017
	where rgcmcd = '01' and rgplant = :l_s_plant and rgdvsn = :l_s_dvsn and rgitno = :l_s_itno and 
			rgline1 = :l_s_rcline1 and rgline2 = :l_s_rcline2 and rgopno = :l_s_rcopno using sqlca;
	if l_n_chkcount > 0 then
		l_s_rcmcyn = 'Y'
	else
		l_s_rcmcyn = 'N'
	end if
	
	// 부대작업 체크
	select sum(rdmctm), sum(rdlbtm), count(*) into :l_d_rcnvmc, :l_d_rcnvlb, :l_n_chkcount
	from pbrtn.rtn014
	WHERE rdcmcd = :g_s_company AND rdplant = :l_s_plant AND rddvsn = :l_s_dvsn AND
			rditno = :l_s_itno AND rdline1 = :l_s_rcline1 AND rdline2 = :l_s_rcline2 AND
			rdopno = :l_s_rcopno and rdflag <> 'D'
	using sqlca;
	
	if l_n_chkcount = 0 then
		l_s_rcnvcd = 'N'
		l_d_rcnvmc = 0
		l_d_rcnvlb = 0
	else
		l_s_rcnvcd = 'Y'
	end if
	// End
	
	if isnull(l_d_rcbmtm)  = true then l_d_rcbmtm  = 0 
	if isnull(l_d_rcbltm)  = true then l_d_rcbltm  = 0 
	if isnull(l_d_rcbstm)  = true then l_d_rcbstm  = 0 
	if isnull(l_d_rcnvmc)  = true then l_d_rcnvmc  = 0 
	if isnull(l_d_rcnvlb)  = true then l_d_rcnvlb  = 0 
	if isnull(l_n_rcopsq)  = true then l_n_rcopsq  = 0 
	if isnull(l_n_rclbcnt) = true then l_n_rclbcnt = 0 
	
	select count(*) into :l_n_chkcount
	from pbrtn.rtn013
	where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
			rcitno = :l_s_itno and trim(rcline1) = :l_s_rcline1 and rcline2 = :l_s_rcline2 and
			rcopno = :l_s_rcopno
	using sqlca;
		
	if l_n_chkcount > 0 then
		update pbrtn.rtn013
		set rcopnm  = :l_s_rcopnm , rcopsq = :l_n_rcopsq , rcline3 = :l_s_rcline3 ,
			 rcmcyn = :l_s_rcmcyn , rcbmtm = :l_d_rcbmtm , rcbltm  = :l_d_rcbltm  , rcbstm = :l_d_rcbstm,
			 rcnvcd = :l_s_rcnvcd , rcnvmc = :l_d_rcnvmc , rcnvlb  = :l_d_rcnvlb  , rclbcnt = :l_n_rclbcnt,
			 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'R',
			 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
			 rcplemp = '', rcplchk = 'N', rcpltime = '',
			 rcdlemp = '', rcdlchk = 'N', rcdltime = '',
			 rcpower = :l_d_rcpower
		where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_dvsn and 
				rcitno = :l_s_itno and rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2 and 
				rcopno = :l_s_rcopno 
		using sqlca;
				
		if sqlca.sqlnrows < 1 then
			ls_message = "공정별 세부내역정보 수정할때 오류가 발생했습니다."
			goto Rollback_
		end if
	else	
		insert into pbrtn.rtn013
			( rccmcd,rcplant,rcdvsn,rcitno,rcline1,rcline2,rcopno,rcchtime,rcedfm,
			rcopnm,rcopsq,rcline3,rcgrde,rcmcyn,rcbmtm,rcbltm,rcbstm,
			rcnvcd,rcnvmc,rcnvlb,rclbcnt,rcflag,rcepno,rcipad,rcupdt,rcsydt,
			rcinemp, rcinchk, rcintime, rcplemp, rcplchk, rcpltime,
			rcdlemp, rcdlchk, rcdltime, rcpower )
		values
			( '01',:l_s_plant,:l_s_dvsn,:l_s_itno,:l_s_rcline1,:l_s_rcline2,:l_s_rcopno,:ls_chtime,'',
			:l_s_rcopnm,:l_n_rcopsq,:l_s_rcline3,:l_s_rcgrde,:l_s_rcmcyn,:l_d_rcbmtm,:l_d_rcbltm,:l_d_rcbstm,
			:l_s_rcnvcd,:l_d_rcnvmc,:l_d_rcnvlb,:l_n_rclbcnt,'A',:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date,
			:g_s_empno, 'N', '', '', 'N','',
			'', 'N','', :l_d_rcpower)
		using sqlca;
		if sqlca.sqlcode <> 0 then
			ls_message = "공정별 세부내역정보 입력할때 오류가 발생했습니다."
			goto Rollback_
		end if
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
uo_status.st_message.text = ls_message
return -1

end event

type uo_status from w_origin_sheet06`uo_status within w_rtn015b
integer x = 0
integer y = 2464
integer height = 96
end type

type st_1 from statictext within w_rtn015b
integer x = 219
integer y = 40
integer width = 4169
integer height = 92
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

type st_a1 from statictext within w_rtn015b
integer x = 1321
integer y = 1544
integer width = 2103
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
string text = "１.~'대상조회~'를 눌러 대상건수를 확인 하십시오."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_rtn015b
integer x = 1317
integer y = 1648
integer width = 2103
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
string text = "２. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_rtn015b
integer x = 1426
integer y = 1852
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

type st_daesang from statictext within w_rtn015b
integer x = 1751
integer y = 1844
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

type st_55 from statictext within w_rtn015b
integer x = 2478
integer y = 1852
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

type st_saeng from statictext within w_rtn015b
integer x = 2807
integer y = 1844
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

type uo_1 from uo_progress_bar within w_rtn015b
event destroy ( )
integer x = 1632
integer y = 2128
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_rtn015b
integer x = 219
integer y = 192
integer width = 4169
integer height = 1280
integer taborder = 10
boolean bringtotop = true
string title = "dw_1"
string dataobject = "d_rtn015b_display"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_update from datawindow within w_rtn015b
boolean visible = false
integer x = 256
integer y = 1504
integer width = 1134
integer height = 384
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_rtn302b_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;MESSAGEBOX("확인",String(row) + "   " + String(dwo.name))
end event

event dberror;messagebox("DatawindowError",string(row) + " 번째 행에서 오류발생~r~n" + sqlerrtext )
return 1

end event

type gb_1 from groupbox within w_rtn015b
integer x = 1344
integer y = 1756
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

type gb_2 from groupbox within w_rtn015b
integer x = 1344
integer y = 2032
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

