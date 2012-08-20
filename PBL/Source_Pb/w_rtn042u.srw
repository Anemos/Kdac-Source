$PBExportHeader$w_rtn042u.srw
$PBExportComments$����/����
forward
global type w_rtn042u from w_ipis_sheet01
end type
type cb_signok from commandbutton within w_rtn042u
end type
type cb_signcancel from commandbutton within w_rtn042u
end type
type st_1 from statictext within w_rtn042u
end type
type dw_rtn042u_01 from u_vi_std_datawindow within w_rtn042u
end type
type st_2 from statictext within w_rtn042u
end type
type dw_rtn042u_02 from u_vi_std_datawindow within w_rtn042u
end type
type cb_delete from commandbutton within w_rtn042u
end type
type st_3 from statictext within w_rtn042u
end type
type st_4 from statictext within w_rtn042u
end type
type gb_1 from groupbox within w_rtn042u
end type
end forward

global type w_rtn042u from w_ipis_sheet01
integer width = 3694
integer height = 2204
cb_signok cb_signok
cb_signcancel cb_signcancel
st_1 st_1
dw_rtn042u_01 dw_rtn042u_01
st_2 st_2
dw_rtn042u_02 dw_rtn042u_02
cb_delete cb_delete
st_3 st_3
st_4 st_4
gb_1 gb_1
end type
global w_rtn042u w_rtn042u

type variables
// ��� : 'PE', PL : 'PL', ���� : 'DL'
string is_chk_status
end variables

forward prototypes
protected function integer wf_send_email_ok (string arg_title, string arg_empno, string arg_emailcontent)
public function integer wf_rtn018_create_history (string ag_inemp, string ag_inchk, string ag_intime, string ag_plemp, string ag_plchk, string ag_pltime, string ag_dlemp, string ag_dlchk, string ag_dltime, string ag_errortext)
public function integer wf_send_email_cancel (string arg_title, string arg_empno, string arg_emailcontent)
public function integer wf_rtn015_create_history (string ag_inemp, string ag_inchk, string ag_intime, string ag_plemp, string ag_plchk, string ag_pltime, string ag_dlemp, string ag_dlchk, string ag_dltime, ref string ag_errortext)
end prototypes

protected function integer wf_send_email_ok (string arg_title, string arg_empno, string arg_emailcontent);//***************************
//* �����庰�� ������ Ȯ���ڿ��� Ȯ����û���� �߼�.
//* ���� : 0, ���� : -1
//***************************
long ll_cnt, ll_rowcnt
string ls_emailtitle, ls_chtime, ls_flag, ls_email, ls_gubun, ls_message

if arg_title = 'RTN011' then
	ls_gubun = '����ǰ��'
else
	ls_gubun = '��������'
end if
ls_emailtitle = "<BR><B> [KDAC���������ý���]-[����]-[��������]-[�������]-[����/�������] ȭ�鿡�� �����ϸ� �˴ϴ�.</B></BR>" &
		+ "<BR>" + ls_gubun + " �� ���� �����û������ �Ʒ��� �����ϴ�. </BR>"

ls_email = f_empno_mailaddr(arg_empno)

// ������� �Է�
openwithparm(w_rtn042u_email_attach, '��������')
ls_message = message.stringparm

arg_emailcontent = arg_emailcontent + "<BR> ÷�γ��� : " + ls_message + " <BR> "
if f_SendMail_routing( "html", trim(ls_email), ls_gubun + " ����� ��������", ls_emailtitle + arg_emailcontent, "" ) = 1 then
	return -1
end if

return 0
end function

public function integer wf_rtn018_create_history (string ag_inemp, string ag_inchk, string ag_intime, string ag_plemp, string ag_plchk, string ag_pltime, string ag_dlemp, string ag_dlchk, string ag_dltime, string ag_errortext);//���� ��ȯ : 0, ���� ��ȯ : -1
long ll_cnt, ll_rowcnt, ll_chkcount
string ls_chtime, ls_plant, ls_dvsn, ls_itno, ls_itno1, ls_flag, ls_nextdate

dw_rtn042u_02.reset()
dw_rtn042u_02.dataobject = "d_rtn042u_02"
dw_rtn042u_02.settransobject(sqlca)

ll_rowcnt = dw_rtn042u_02.retrieve(ag_inemp,ag_inchk,ag_intime, &
		ag_plemp,ag_plchk,ag_pltime,ag_dlemp,ag_dlchk,ag_dltime,g_s_date)
if ll_rowcnt < 1 then
	ag_errortext = "����ǰ�񿡼� ������ ���γ��������� �������� �ʽ��ϴ�."
	return -1
end if
ls_nextdate = f_relativedate(g_s_date,1)
for ll_cnt = 1 to ll_rowcnt		
	ls_chtime = dw_rtn042u_02.getitemstring(ll_cnt, "rtn011_rachtime")
	if ls_chtime = "������" then continue
	
	ls_plant = dw_rtn042u_02.getitemstring(ll_cnt, "rtn011_raplant")
	ls_dvsn = dw_rtn042u_02.getitemstring(ll_cnt, "rtn011_radvsn")
	ls_itno = dw_rtn042u_02.getitemstring(ll_cnt, "rtn011_raitno")
	ls_itno1 = dw_rtn042u_02.getitemstring(ll_cnt, "rtn011_raitno1")
	ls_flag = dw_rtn042u_02.getitemstring(ll_cnt, "rtn011_raflag")

	// RTN018 �����κ�
	if ls_flag <> 'A' then
		UPDATE PBRTN.RTN018
		SET Rhedto = :g_s_date, Rhinemp = :ag_inemp, Rhinchk = :ag_inchk, Rhintime = :ag_intime,
			Rhplemp = :ag_plemp, Rhplchk = :ag_plchk, Rhpltime = :ag_pltime,
			Rhdlemp = :ag_dlemp, Rhdlchk = :ag_dlchk, Rhdltime = :ag_dltime, Rhflag = :ls_flag
		WHERE Rhcmcd ='01' AND Rhplant = :ls_plant AND Rhdvsn = :ls_dvsn AND
			Rhitno = :ls_itno AND Rhitno1 = :ls_itno1 AND Rhedto = '99991231'
		using sqlca;
		
		if sqlca.sqlnrows < 1 then
			INSERT INTO PBRTN.RTN018( RHCMCD , RHPLANT , RHDVSN , RHITNO , RHITNO1 , RHEDFM,
			RHEDTO, RHEPNO, RHIPAD, RHSYDT, RHINEMP, RHINCHK, RHINTIME,
			RHPLEMP, RHPLCHK, RHPLTIME, RHDLEMP, RHDLCHK, RHDLTIME, RHFLAG )
			VALUES('01', :ls_plant, :ls_dvsn, :ls_itno, :ls_itno1, :g_s_date,
			:g_s_date, :g_s_empno, :g_s_ipaddr, :g_s_date, :ag_inemp, :ag_inchk, :ag_intime,
			:ag_plemp, :ag_plchk, :ag_pltime, :ag_dlemp, :ag_dlchk, :ag_dltime, :ls_flag)
			using sqlca;
			
			if sqlca.sqlcode <> 0 then
				ag_errortext = "RTN018 �Ϸ��� ������ �����Ͽ����ϴ�."
				return -1
			end if
		end if
	end if
	
	if ls_flag <> 'D' then
		SELECT COUNT(*) INTO :ll_chkcount FROM PBRTN.RTN018
		WHERE Rhcmcd ='01' AND Rhplant = :ls_plant AND Rhdvsn = :ls_dvsn AND
			Rhitno = :ls_itno AND Rhitno1 = :ls_itno1 AND Rhedfm = :ls_nextdate
		using sqlca;
		if ll_chkcount >  0 then
			DELETE FROM PBRTN.RTN018
			WHERE Rhcmcd ='01' AND Rhplant = :ls_plant AND Rhdvsn = :ls_dvsn AND
				Rhitno = :ls_itno AND Rhitno1 = :ls_itno1 AND Rhedfm = :ls_nextdate
			using sqlca;
			if sqlca.sqlcode <> 0 then
				ag_errortext = "RTN018 ������ �����Ͽ����ϴ�. 01 "
				return -1
			end if
		end if
		INSERT INTO PBRTN.RTN018( RHCMCD , RHPLANT , RHDVSN , RHITNO , RHITNO1 , RHEDFM,
		RHEDTO, RHEPNO, RHIPAD, RHSYDT, RHINEMP, RHINCHK, RHINTIME,
		RHPLEMP, RHPLCHK, RHPLTIME, RHDLEMP, RHDLCHK, RHDLTIME, RHFLAG )
		VALUES('01', :ls_plant, :ls_dvsn, :ls_itno, :ls_itno1, :ls_nextdate,
		'99991231', :g_s_empno, :g_s_ipaddr, :g_s_date, :ag_inemp, :ag_inchk, :ag_intime,
		:ag_plemp, :ag_plchk, :ag_pltime, :ag_dlemp, :ag_dlchk, :ag_dltime, :ls_flag)
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ag_errortext = "RTN018 ������ �����Ͽ����ϴ�. 02"
			return -1
		end if
	else
		DELETE FROM PBRTN.RTN011
		WHERE Racmcd ='01' AND Raplant = :ls_plant AND Radvsn = :ls_dvsn AND
		Raitno = :ls_itno AND Raitno1 = :ls_itno1
		using sqlca;

		if sqlca.sqlcode <> 0 then
			ag_errortext = "RTN011 ���� ���� : " + sqlca.sqlerrtext
			return -1
		end if
	end if
next

return 0
end function

public function integer wf_send_email_cancel (string arg_title, string arg_empno, string arg_emailcontent);//***************************
//* �����庰�� ������ Ȯ���ڿ��� ��ҿ�û���� �߼�.
//* ���� : 0, ���� : -1
//***************************
long ll_cnt, ll_rowcnt
string ls_emailtitle, ls_chtime, ls_flag, ls_email, ls_gubun, ls_message

if arg_title = 'RTN011' then
	ls_gubun = '����ǰ��'
else
	ls_gubun = '��������'
end if
ls_emailtitle = "<BR><B> [KDAC���������ý���]-[����]-[��������]-[�������]-[����/�������] ȭ�鿡�� Ȯ���ϸ� �˴ϴ�.</B> </BR>" &
		+ "<BR>" + ls_gubun + " �� ���� ������ҳ����� �Ʒ��� �����ϴ�. </BR>"

ls_email = f_empno_mailaddr(arg_empno)

// ������� �Է�
openwithparm(w_rtn042u_email_attach, '�������')
ls_message = message.stringparm

arg_emailcontent = arg_emailcontent + "<BR> ÷�γ��� : " + ls_message + "<BR>"
if f_SendMail_routing( "html", trim(ls_email), ls_gubun + " �������", ls_emailtitle + arg_emailcontent, "" ) = 1 then
	return -1
end if

return 0
end function

public function integer wf_rtn015_create_history (string ag_inemp, string ag_inchk, string ag_intime, string ag_plemp, string ag_plchk, string ag_pltime, string ag_dlemp, string ag_dlchk, string ag_dltime, ref string ag_errortext);//���� ��ȯ : 0, ���� ��ȯ : -1
long ll_cnt, ll_rowcnt, ll_chkcount, ll_logid
string ls_chtime, ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2, ls_opno, ls_flag
string ls_rcmcyn, ls_rcnvcd, ls_nextdate, ls_rdflag
string l_s_rdnvmo,l_s_rdmcno,l_s_rdterm,l_s_rdremk,l_s_rdedfm
dec    l_s_rdmctm,l_s_rdlbtm

dw_rtn042u_02.reset()
dw_rtn042u_02.dataobject = "d_rtn042u_03"
dw_rtn042u_02.settransobject(sqlca)

ll_rowcnt = dw_rtn042u_02.retrieve(ag_inemp,ag_inchk,ag_intime,ag_plemp,ag_plchk, &
	ag_pltime,ag_dlemp,ag_dlchk,ag_dltime,g_s_date)
if ll_rowcnt < 1 then
	ag_errortext = "������������ ������ ���γ����� �������� �ʽ��ϴ�."
	return -1
end if

ls_nextdate = f_relativedate(g_s_date,1)
for ll_cnt = 1 to ll_rowcnt
	ls_chtime = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcchtime")
	if ls_chtime = "������" then continue
	
	ls_plant = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcplant")
	ls_dvsn = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcdvsn")
	ls_itno = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcitno")
	ls_line1 = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcline1")
	ls_line2 = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcline2")
	ls_opno = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcopno")
	ls_flag = dw_rtn042u_02.getitemstring(ll_cnt, "rtn013_rcflag")
	ls_rcmcyn = dw_rtn042u_02.getitemstring(ll_cnt,"rtn013_rcmcyn")
	ls_rcnvcd = dw_rtn042u_02.getitemstring(ll_cnt, "rtn013_rcnvcd")
	
	// RTN015 �����κ�
	SELECT COUNT(*) INTO :ll_chkcount
	FROM PBRTN.RTN015
	WHERE Recmcd = '01' AND Replant = :ls_plant AND
			Redvsn = :ls_dvsn AND Reitno = :ls_itno AND Reline1 = :ls_line1 AND
			Reline2 = :ls_line2 AND Reopno = :ls_opno AND Reedto = '99991231'
	using sqlca;
	
	if ll_chkcount > 0 then
		UPDATE PBRTN.RTN015
		SET Reedto = :g_s_date, Reflag = :ls_flag,
			Reinemp = :ag_inemp, Reinchk = :ag_inchk, Reintime = :ag_intime,
			Replemp = :ag_plemp, Replchk = :ag_plchk, Repltime = :ag_pltime,
			Redlemp = :ag_dlemp, Redlchk = :ag_dlchk, Redltime = :ag_dltime
		WHERE Recmcd = '01' AND Replant = :ls_plant AND
			Redvsn = :ls_dvsn AND Reitno = :ls_itno AND Reline1 = :ls_line1 AND
			Reline2 = :ls_line2 AND Reopno = :ls_opno AND Reedto = '99991231'
		using sqlca;
		
//		if sqlca.sqlnrows < 1 then
//			ag_errortext = "RTN015 �Ϸ��� ���������� �߻��Ͽ����ϴ� : " + sqlca.sqlerrtext
//			return -1
//		end if
	end if
	
	//���õ� Ÿ ���̺�( �δ�����, ������� ) �������� ó��
	//���� ����ÿ� ����
	if ls_rcmcyn = 'Y' then
		if ls_flag = 'D' then
			delete from pbrtn.rtn017
				where rgcmcd  = :g_s_company and rgplant = :ls_plant and rgdvsn = :ls_dvsn and rgitno = :ls_itno and 
					rgline1 = :ls_line1 and rgline2 = :ls_line2 and rgopno = :ls_opno
			using sqlca;
			if sqlca.sqlcode <> 0 then
				ag_errortext = "������ �����Ȳ���� �������ں���ÿ� ������ �����߽��ϴ�. : " + sqlca.sqlerrtext
				return -1
			end if
		else
			UPDATE PBRTN.RTN017
			SET RGEDFM = :ls_nextdate, 
				RGFLAG = :ls_flag,   
				RGEPNO = :g_s_empno,      
				RGIPAD = :g_s_ipaddr,   
				RGUPDT = :g_s_date,   
				RGSYDT = :g_s_date
			WHERE RGCMCD  = :g_s_company and RGPLANT = :ls_plant and RGDVSN = :ls_dvsn and RGITNO = :ls_itno and 
					RGLINE1 = :ls_line1 and RGLINE2 = :ls_line2 and RGOPNO = :ls_opno
			using sqlca;
			if sqlca.sqlcode <> 0 then
				ag_errortext = "������ �����Ȳ���� �������ں���ÿ� ������ �����߽��ϴ�. : " + sqlca.sqlerrtext
				return -1
			end if
		end if
	end if
	
	SELECT COUNT(*) INTO :ll_chkcount FROM pbrtn.rtn014
	WHERE rdcmcd  = :g_s_company  and rdplant = :ls_plant and rddvsn = :ls_dvsn and 
			rditno = :ls_itno and rdline1 = :ls_line1 and
			rdline2 = :ls_line2 and rdopno = :ls_opno
	using sqlca;
	
	if ll_chkcount > 0 then
		ll_logid = 0
		do while true
			select rdlogid,rdnvmo,rdmcno,rdterm,rdmctm,rdlbtm,rdremk,rdedfm,rdflag 
			into :ll_logid,:l_s_rdnvmo,:l_s_rdmcno,:l_s_rdterm,:l_s_rdmctm, &
					:l_s_rdlbtm,:l_s_rdremk,:l_s_rdedfm,:ls_rdflag
			from pbrtn.rtn014
			where rdlogid > :ll_logid and rdcmcd  = :g_s_company  and rdplant = :ls_plant and rddvsn = :ls_dvsn and 
					rditno = :ls_itno and rdline1 = :ls_line1 and
					rdline2 = :ls_line2 and rdopno = :ls_opno
			order by rdlogid
			fetch first 1 row only
			using sqlca ;
			
			if sqlca.sqlcode <> 0 then
				exit
			end if
	
			//�δ����� �̷°��� ���μ���
			SELECT COUNT(*) INTO :ll_chkcount FROM PBRTN.RTN016
			WHERE RFLOGID = :ll_logid AND RFCMCD = :g_s_company AND RFPLANT = :ls_plant AND RFDVSN = :ls_dvsn AND
					RFITNO = :ls_itno AND RFLINE1 = :ls_line1 AND RFLINE2 = :ls_line2 AND
					RFOPNO = :ls_opno AND RFNVMO = :l_s_rdnvmo AND RFMCNO = :l_s_rdmcno AND 
					RFTERM = :l_s_rdterm AND RFEDFM = :l_s_rdedfm
			using sqlca;
			
			if ll_chkcount < 1 and ls_rdflag <> 'D' then 
				INSERT INTO PBRTN.RTN016  
				( RFLOGID, RFCMCD, RFPLANT, RFDVSN, RFITNO, RFLINE1, RFLINE2, RFOPNO, RFNVMO, RFMCNO, 
				  RFTERM, RFMCTM, RFLBTM, RFREMK, RFFLAG, RFEPNO, RFEDFM,  
				  RFEDTO, RFIPAD, RFUPDT, RFSYDT )
				SELECT RDLOGID, RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
				  RDTERM, RDMCTM,  RDLBTM, RDREMK, :ls_rdflag, :g_s_empno, :ls_nextdate,   
				  '99991231', :g_s_ipaddr, :g_s_date, 'INS01'
				FROM PBRTN.RTN014
				WHERE RDLOGID = :ll_logid AND RDCMCD = :g_s_company AND RDPLANT = :ls_plant AND RDDVSN = :ls_dvsn AND
						RDITNO = :ls_itno AND RDLINE1 = :ls_line1 AND RDLINE2 = :ls_line2 AND
						RDOPNO = :ls_opno AND RDNVMO = :l_s_rdnvmo AND RDMCNO = :l_s_rdmcno AND 
						RDTERM = :l_s_rdterm
				using sqlca;
				
				if sqlca.sqlcode <> 0 then
					ag_errortext = "�δ��۾� �̷»����ÿ� �����߻� 1. : " + sqlca.sqlerrtext + " : "  + string(sqlca.sqlcode)
					return -1
				end if
			else
				if ls_rdflag = 'D' then
					UPDATE PBRTN.RTN016
					SET RFREMK = :l_s_rdremk,   
						RFFLAG = :ls_rdflag, 
						RFEDTO=  :g_s_date,
						RFEPNO = :g_s_empno,      
						RFIPAD = :g_s_ipaddr,   
						RFUPDT = :g_s_date,   
						RFSYDT = 'DEL01'
					WHERE RFLOGID = :ll_logid
					using sqlca;
					
					// Where���� �ӽ������� logid�� ������
//					WHERE RFLOGID = :ll_logid AND RFCMCD = :g_s_company AND RFPLANT = :ls_plant AND RFDVSN = :ls_dvsn AND
//							RFITNO = :ls_itno AND RFLINE1 = :ls_line1 AND RFLINE2 = :ls_line2 AND
//							RFOPNO = :ls_opno AND RFNVMO = :l_s_rdnvmo AND RFMCNO = :l_s_rdmcno AND 
//							RFTERM = :l_s_rdterm AND RFEDFM = :l_s_rdedfm
					
//					if sqlca.sqlnrows < 1 then
//						ag_errortext = "�δ��۾� �̷»����ÿ� �����߻� 2. : " + sqlca.sqlerrtext
//						return -1
//					end if
				else
					UPDATE PBRTN.RTN016
					SET RFFLAG = 'D', 
						RFEDTO=  :g_s_date,
						RFEPNO = :g_s_empno,      
						RFIPAD = :g_s_ipaddr,   
						RFUPDT = :g_s_date,   
						RFSYDT = 'DEL02'
					WHERE RFLOGID = :ll_logid
					using sqlca;
					
//						if sqlca.sqlnrows < 1 then
//							ag_errortext = "�δ��۾� �̷»����ÿ� �����߻� 3. : " + sqlca.sqlerrtext
//							return -1
//						end if
					
					SELECT COUNT(*) INTO :ll_chkcount FROM PBRTN.RTN016
					WHERE RFLOGID = :ll_logid AND RFCMCD = :g_s_company AND RFPLANT = :ls_plant AND RFDVSN = :ls_dvsn AND
							RFITNO = :ls_itno AND RFLINE1 = :ls_line1 AND RFLINE2 = :ls_line2 AND
							RFOPNO = :ls_opno AND RFNVMO = :l_s_rdnvmo AND RFMCNO = :l_s_rdmcno AND 
							RFTERM = :l_s_rdterm AND RFEDFM = :ls_nextdate
					using sqlca;
					
					if ll_chkcount > 0 then
						DELETE FROM PBRTN.RTN016
						WHERE RFLOGID = :ll_logid AND RFEDFM = :ls_nextdate
						using sqlca;
						if sqlca.sqlcode <> 0 then
							ag_errortext = "�δ��۾� �̷»����ÿ� �����߻� 5. : " + sqlca.sqlerrtext
							return -1
						end if
					end if
					
					INSERT INTO PBRTN.RTN016  
					( RFLOGID, RFCMCD, RFPLANT, RFDVSN, RFITNO, RFLINE1, RFLINE2, RFOPNO, RFNVMO, RFMCNO, 
					  RFTERM, RFMCTM, RFLBTM, RFREMK, RFFLAG, RFEPNO, RFEDFM,  
					  RFEDTO, RFIPAD, RFUPDT, RFSYDT )
					SELECT RDLOGID, RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
					  RDTERM, RDMCTM,  RDLBTM, RDREMK, :ls_rdflag, :g_s_empno, :ls_nextdate,   
					  '99991231', :g_s_ipaddr, :g_s_date, 'INS02'
					FROM PBRTN.RTN014
					WHERE RDLOGID = :ll_logid AND RDCMCD = :g_s_company AND RDPLANT = :ls_plant AND RDDVSN = :ls_dvsn AND
							RDITNO = :ls_itno AND RDLINE1 = :ls_line1 AND RDLINE2 = :ls_line2 AND
							RDOPNO = :ls_opno AND RDNVMO = :l_s_rdnvmo AND RDMCNO = :l_s_rdmcno AND 
							RDTERM = :l_s_rdterm
					using sqlca;
					
					if sqlca.sqlcode <> 0 then
						ag_errortext = "�δ��۾� �̷»����ÿ� �����߻� 4. : " + sqlca.sqlerrtext
						return -1
					end if
				end if
			end if
			
			if ls_rdflag = 'D' then
				DELETE FROM PBRTN.RTN014
				WHERE RDLOGID = :ll_logid
				using sqlca;
				if sqlca.sqlcode <> 0 then
					ag_errortext = "�δ��۾� �̷»����ÿ� �����߻� 1. : " + sqlca.sqlerrtext
					return -1
				end if
			else
				UPDATE PBRTN.RTN014  
				SET RDFLAG = :ls_rdflag,   
					RDEPNO = :g_s_empno,   
					RDEDFM = :ls_nextdate,   
					RDIPAD = :g_s_ipaddr,   
					RDUPDT = :g_s_date,   
					RDSYDT = 'UPT01'  
				WHERE RDLOGID = :ll_logid
				using sqlca;
//				if sqlca.sqlcode <> 0 then
//					ag_errortext = "�δ��۾� �������ں���ÿ� ������ �����߽��ϴ�. : " + sqlca.sqlerrtext
//					return -1
//				end if
			end if
		loop

// *** ���ʿ��� �������� �ּ�ó���� 2012.01.27
//		if ls_flag = 'D' then
//			DELETE FROM pbrtn.rtn014
//			WHERE rdcmcd = :g_s_company and rdplant = :ls_plant and rddvsn = :ls_dvsn and rditno = :ls_itno and 
//					rdline1 = :ls_line1 and rdline2 = :ls_line2 and rdopno = :ls_opno
//			using sqlca;
//			if sqlca.sqlcode <> 0 then
//				ag_errortext = "�δ��۾� �����ÿ� ������ �����߽��ϴ�. : " + sqlca.sqlerrtext
//				return -1
//			end if
//		else
//			UPDATE PBRTN.RTN014  
//			SET RDFLAG = :ls_rdflag,   
//				RDEPNO = :g_s_empno,   
//				RDEDFM = :ls_nextdate,   
//				RDIPAD = :g_s_ipaddr,   
//				RDUPDT = :g_s_date,   
//				RDSYDT = 'UPT01'  
//			where RDCMCD  = :g_s_company  and RDPLANT = :ls_plant and RDDVSN = :ls_dvsn and 
//					RDITNO = :ls_itno and RDLINE1 = :ls_line1 and
//					RDLINE2 = :ls_line2 and RDOPNO = :ls_opno
//			using sqlca;
//			if sqlca.sqlcode <> 0 then
//				ag_errortext = "�δ��۾� �������ں���ÿ� ������ �����߽��ϴ�. : " + sqlca.sqlerrtext
//				return -1
//			end if
//		end if
	end if
	
	if ls_flag <> 'D' then
		SELECT COUNT(*) INTO :ll_chkcount FROM PBRTN.RTN015
		WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND REDVSN = :ls_dvsn AND
				REITNO = :ls_itno AND RELINE1 = :ls_line1 AND RELINE2 = :ls_line2 AND
				REOPNO = :ls_opno AND REEDFM = :ls_nextdate
		using sqlca;
		
		if ll_chkcount > 0 then
			DELETE FROM PBRTN.RTN015
			WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND REDVSN = :ls_dvsn AND
					REITNO = :ls_itno AND RELINE1 = :ls_line1 AND RELINE2 = :ls_line2 AND
					REOPNO = :ls_opno AND REEDFM = :ls_nextdate
			using sqlca;
			if sqlca.sqlcode <> 0 then
				ag_errortext = "RTN015 ���� ����01 : " + sqlca.sqlerrtext
				return -1
			end if
		end if
		INSERT INTO PBRTN.RTN015( RECMCD, REPLANT, REDVSN, REITNO, RELINE1, RELINE2, REOPNO,
			REEDFM, REOPNM, REOPSQ, RELINE3, REGRDE, REMCYN, REBMTM, REBLTM,
			REBSTM, RENVCD, RENVMC, RENVLB, RELBCNT, REEDTO, REFLAG, 
			REEPNO, REIPAD, REUPDT, RESYDT, REINEMP, REINCHK, REINTIME,
			REPLEMP, REPLCHK, REPLTIME, REDLEMP, REDLCHK, REDLTIME )
		SELECT RCCMCD, RCPLANT, RCDVSN, RCITNO, RCLINE1, RCLINE2, RCOPNO,
			:ls_nextdate, RCOPNM, RCOPSQ, RCLINE3, RCGRDE, RCMCYN, RCBMTM, RCBLTM,
			RCBSTM, RCNVCD, RCNVMC, RCNVLB, RCLBCNT,'99991231',RCFLAG,
			:g_s_empno, :g_s_ipaddr, :g_s_date, :g_s_date, :ag_inemp, :ag_inchk, :ag_intime,
			:ag_plemp, :ag_plchk, :ag_pltime, :ag_dlemp, :ag_dlchk, :ag_dltime
		FROM PBRTN.RTN013
		WHERE Rcchtime = :ls_chtime AND Rccmcd = '01' AND Rcplant = :ls_plant AND
			Rcdvsn = :ls_dvsn AND Rcitno = :ls_itno AND Rcline1 = :ls_line1 AND
			Rcline2 = :ls_line2 AND Rcopno = :ls_opno
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ag_errortext = "RTN015 ���� ����02 : " + sqlca.sqlerrtext
			return -1
		end if
	else
		DELETE FROM PBRTN.RTN013
		WHERE Rcchtime = :ls_chtime AND Rccmcd = '01' AND Rcplant = :ls_plant AND
			Rcdvsn = :ls_dvsn AND Rcitno = :ls_itno AND Rcline1 = :ls_line1 AND
			Rcline2 = :ls_line2 AND Rcopno = :ls_opno
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ag_errortext = "RTN013 ���� ���� : " + sqlca.sqlerrtext
			return -1
		end if
	end if
next

return 0
end function

on w_rtn042u.create
int iCurrent
call super::create
this.cb_signok=create cb_signok
this.cb_signcancel=create cb_signcancel
this.st_1=create st_1
this.dw_rtn042u_01=create dw_rtn042u_01
this.st_2=create st_2
this.dw_rtn042u_02=create dw_rtn042u_02
this.cb_delete=create cb_delete
this.st_3=create st_3
this.st_4=create st_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_signok
this.Control[iCurrent+2]=this.cb_signcancel
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_rtn042u_01
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_rtn042u_02
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.gb_1
end on

on w_rtn042u.destroy
call super::destroy
destroy(this.cb_signok)
destroy(this.cb_signcancel)
destroy(this.st_1)
destroy(this.dw_rtn042u_01)
destroy(this.st_2)
destroy(this.dw_rtn042u_02)
destroy(this.cb_delete)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_rtn042u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_rtn042u_01.Height= ( newheight * 2 / 5 ) - dw_rtn042u_01.y

st_2.x = dw_rtn042u_01.x
st_2.y = dw_rtn042u_01.y + dw_rtn042u_01.Height + ls_split

dw_rtn042u_02.x = dw_rtn042u_01.x
dw_rtn042u_02.y = dw_rtn042u_01.y + dw_rtn042u_01.Height + st_2.Height + ls_split
dw_rtn042u_02.Width = dw_rtn042u_01.Width
dw_rtn042u_02.Height = newheight - ( st_2.y + st_2.Height + ls_status)
end event

event open;call super::open;// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_postopen;call super::ue_postopen;dw_rtn042u_01.settransobject(sqlca)
dw_rtn042u_02.settransobject(sqlca)

This.triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;// ��� : 'PE', PL : 'PL', ���� : 'DL'
string ls_dept, ls_inemp, ls_inchk, ls_plemp, ls_plchk, ls_dlemp, ls_dlchk
long ll_rowcnt

dw_rtn042u_01.reset()
dw_rtn042u_02.reset()

SELECT DISTINCT BB.Pedept INTO :ls_dept
	FROM PBRTN.RTN019 AA INNER JOIN PBCOMMON.DAC003 BB
		ON AA.Xinemp = BB.Peempno
WHERE AA.Xinemp = :g_s_empno
using sqlca;

if f_spacechk(ls_dept) = -1 then
	SELECT DISTINCT BB.Pedept INTO :ls_dept
	FROM PBRTN.RTN019 AA INNER JOIN PBCOMMON.DAC003 BB
		ON AA.Xplemp = BB.Peempno
	WHERE AA.Xplemp = :g_s_empno
	using sqlca;
	
	if f_spacechk(ls_dept) = -1 then
		SELECT Pedept INTO :ls_dept
		FROM PBCOMMON.DAC003
		WHERE Peempno = :g_s_empno AND Pejikchek = '3'
		using sqlca;
		
		if f_spacechk(ls_dept) = -1 then
			uo_status.st_message.text = "����/�������� ��ϵ��� ���� ����Դϴ�."
			return -1
		else
			// ����
			is_chk_status = 'DL'
			ls_inemp = '%'
			ls_inchk = 'Y'
			ls_plemp = '%'
			ls_plchk = 'Y'
			ls_dlemp = g_s_empno + '%'
			ls_dlchk = 'N'
		end if
	else
		// P/L
		is_chk_status = 'PL'
		ls_inemp = '%'
		ls_inchk = 'Y'
		ls_plemp = g_s_empno + '%'
		ls_plchk = 'N'
		ls_dlemp = '%'
		ls_dlchk = 'N'
	end if
else
	// �����
	is_chk_status = 'PE'
	ls_inemp = g_s_empno + '%'
	ls_inchk = 'N'
	ls_plemp = '%'
	ls_plchk = 'N'
	ls_dlemp = '%'
	ls_dlchk = 'N'
end if

if is_chk_status = 'PE' then
	cb_signcancel.enabled = true
	cb_delete.enabled = true
else
	cb_signcancel.enabled = true
	cb_delete.enabled = false
end if

if dw_rtn042u_01.retrieve( g_s_empno, ls_inchk, ls_plchk ) > 0 then
	dw_rtn042u_01.selectrow(0,false)
	dw_rtn042u_01.selectrow(1,true)
	dw_rtn042u_01.object.b_none.visible = True
	dw_rtn042u_01.object.b_yes.visible = False
else
	uo_status.st_message.text = "������ ������ �������� �ʽ��ϴ�."
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_rtn042u
end type

type cb_signok from commandbutton within w_rtn042u
integer x = 91
integer y = 76
integer width = 535
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;long ll_cnt, ll_chkcnt
string ls_sign_empno, ls_dept, ls_message, ls_flag, ls_gubun
string ls_chtime, ls_plant, ls_dvsn, ls_itno, ls_itno1, ls_line1, ls_line2, ls_opno, ls_dlempname
string ls_nowtime, ls_emailcontent, ls_inempname, ls_plempname, ls_nextdate
string ls_inemp, ls_inchk, ls_intime, ls_dlemp, ls_dlchk, ls_dltime, ls_plemp, ls_plchk, ls_pltime

setpointer(hourglass!)
ls_nowtime = f_get_systemdate(sqlca)
ls_nextdate = f_relativedate(g_s_date,1)

SQLCA.AUTOCOMMIT = FALSE
for ll_cnt = 1 to dw_rtn042u_01.rowcount()
	if dw_rtn042u_01.getitemstring(ll_cnt,"sel_chk") <> 'Y' then
		Continue
	end if
	
	ls_gubun = dw_rtn042u_01.getitemstring(ll_cnt, "gubun")
	ls_inemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rainemp")
	ls_inempname = dw_rtn042u_01.getitemstring(ll_cnt, "inempname")
	ls_inchk = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rainchk")
	ls_intime = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raintime")
	ls_plemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raplemp")
	ls_plempname = dw_rtn042u_01.getitemstring(ll_cnt, "plempname")
	ls_plchk = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raplchk")
	ls_pltime = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rapltime")
	ls_dlemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_radlemp")
	ls_dlempname = dw_rtn042u_01.getitemstring(ll_cnt, "dlempname")
	
	if ls_inchk = 'Y' and ls_plchk = 'Y' then
		is_chk_status = 'DL'
		ls_emailcontent = "<BR> " + ls_intime + " ������ ���ο�û���� " + ls_dlempname + " ������ ���������� �����Ͽ����ϴ�. <BR>" &
					+ " ���οϷ��Ͻô� " + ls_nowtime + " �Դϴ�.<BR>"
	elseif ls_inchk = 'Y' and ls_plchk = 'N' then
		is_chk_status = 'PL'
		ls_emailcontent =  "<BR> " + ls_intime + " ������ ���ο�û���� " + ls_plempname + " P/L�� ���ο�û�Ͽ����ϴ�. <BR>" &
					+ " ���ο�û�Ͻô� " + ls_nowtime + " �Դϴ�.<BR>"
	else
		is_chk_status = 'PE'
		ls_emailcontent =  "<BR> => " + ls_nowtime + " ������ ���ο�û���� " + ls_inempname + " ����� ���ο�û�Ͽ����ϴ�. <BR>" &
					+ " => ���ο�û�Ͻô� " + ls_nowtime + " �Դϴ�.<BR>"
	end if
	
	Choose case is_chk_status
		case 'PE'	//����� �����û
			SELECT Xplemp INTO :ls_sign_empno
			FROM PBRTN.RTN019
			WHERE Xinemp = :g_s_empno
			using sqlca;
			
			if f_spacechk(ls_sign_empno) = -1 then
				Messagebox("���","������ PL�� ����ѵڿ� �����û�Ͻñ� �ٶ��ϴ�.")
				goto Rollback_
			else
				select ifnull(pedept,'') into :ls_dept
				from pbcommon.dac003
				where peempno = :ls_sign_empno and peout <> '*'
				using sqlca;
				
				if g_s_deptcd <> ls_dept then
					Messagebox("���","������ PL�� ���� ����ѵڿ� �����û�Ͻñ� �ٶ��ϴ�.")
					goto Rollback_
				end if
			end if
			
			if ls_gubun = 'RTN011' then
				UPDATE PBRTN.RTN011
				SET Rainchk = 'Y', Raintime = :ls_nowtime,
					Raplemp = :ls_sign_empno, Raplchk = 'N', Rapltime = '',
					Radlemp = '', Radlchk = 'N', Radltime = ''
				WHERE Racmcd ='01' AND Rainemp = :ls_inemp AND Rainchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 PL���� ���� ����"
					goto Rollback_
				end if
			else
				UPDATE PBRTN.RTN013
				SET Rcinchk = 'Y', Rcintime = :ls_nowtime,
					Rcplemp = :ls_sign_empno, Rcplchk = 'N', Rcpltime = '',
					Rcdlemp = '', Rcdlchk = 'N', Rcdltime = ''
				WHERE Rccmcd ='01' AND Rcinemp = :ls_inemp AND Rcinchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 PL���� ���� ����"
					goto Rollback_
				end if
			end if
			//���Ϲ߼�
			if wf_send_email_ok( ls_gubun, ls_sign_empno, ls_emailcontent) = -1 then
				ls_message = "����ڰ��翡�� => " + ls_gubun + " ���Ϲ߼ۿ���"
				goto Rollback_
			end if
		case 'PL'	// P/L �����û
			SELECT BB.Pedept INTO :ls_dept
			FROM PBRTN.RTN019 AA INNER JOIN PBCOMMON.DAC003 BB
				ON AA.Xplemp = BB.Peempno
			WHERE AA.Xplemp = :g_s_empno
			using sqlca;
			
			if f_spacechk(ls_dept) = -1  then
				ls_message = "������������ P/L ���������� Ȯ���� �ֽñ� �ٶ��ϴ�."
				goto Rollback_
			end if
		
			SELECT Peempno INTO :ls_sign_empno
			FROM PBCOMMON.DAC003
			WHERE Pedept = :ls_dept AND Pejikchek = '3' AND Peout <> '*'
			using sqlca;
			
			// ����ýý��ۿ�� ���弳��
			if g_s_empno = '000030' then ls_sign_empno = '000030'
			
			if f_spacechk(ls_sign_empno) = -1 then
				ls_message = "���� ������ �������µ� �����߽��ϴ�."
				goto Rollback_
			end if
			
			if ls_gubun = 'RTN011' then
				UPDATE PBRTN.RTN011
				SET Raplchk = 'Y', Rapltime = :ls_nowtime,
					Radlemp = :ls_sign_empno, Radlchk = 'N', Radltime = ''
				WHERE Racmcd ='01' AND Rainemp = :ls_inemp AND Rainchk = 'Y' AND
					Raintime = :ls_intime AND Raplemp = :ls_plemp AND Raplchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 PL���� ���� ����"
					goto Rollback_
				end if
			else
				UPDATE PBRTN.RTN013
				SET Rcplchk = 'Y', Rcpltime = :ls_nowtime,
					Rcdlemp = :ls_sign_empno, Rcdlchk = 'N', Rcdltime = ''
				WHERE Rccmcd ='01' AND Rcinemp = :ls_inemp AND Rcinchk = 'Y' AND
					Rcintime = :ls_intime AND Rcplemp = :ls_plemp AND Rcplchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 PL���� ���� ����"
					goto Rollback_
				end if
			end if
			//���Ϲ߼�
			if wf_send_email_ok( ls_gubun, ls_sign_empno, ls_emailcontent) = -1 then
				ls_message = "P/L���翡�� => " + ls_gubun + " ���Ϲ߼ۿ���"
				goto Rollback_
			end if
		case 'DL'
			//******************************
			//* ������� ó������
			//* 1. RTN011, RTN013 ����Flag �� �������� ������Ʈ
			//* 2. ���� ���ڵ庰�� RTN018, RTN019�� ����Ÿ ó��
			//* 2.1 �Է��� ��쿡�� �������� ���Ϸ� �ؼ� �����͸� ����.
			//* 2.2 ����,������ ��쿡�� ��������Ÿ�� ���Ϸ� �����ϰ�, �����϶����� ���Ϸ� ����Ÿ�� ����.
			//******************************
			if ls_gubun = 'RTN011' then
				UPDATE PBRTN.RTN011
				SET Radlchk = 'Y', Radltime = :ls_nowtime, Raedfm = :ls_nextdate
				WHERE Racmcd ='01' AND Rainemp = :ls_inemp AND Rainchk = 'Y' AND
					Raintime = :ls_intime AND Raplemp = :ls_plemp AND Raplchk = 'Y' AND
					Rapltime = :ls_pltime AND Radlemp = :ls_dlemp AND Radlchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 ������� ���� ���� : " + sqlca.sqlerrtext
					goto Rollback_
				end if
				
				if wf_rtn018_create_history(ls_inemp,ls_inchk,ls_intime,ls_plemp,ls_plchk,ls_pltime, &
					ls_dlemp, 'Y', ls_nowtime, ls_message) = -1 then
					goto Rollback_
				end if
			else
				UPDATE PBRTN.RTN013
				SET Rcdlchk = 'Y', Rcdltime = :ls_nowtime, Rcedfm = :ls_nextdate
				WHERE Rccmcd ='01' AND Rcinemp = :ls_inemp AND Rcinchk = 'Y' AND
					Rcintime = :ls_intime AND Rcplemp = :ls_plemp AND Rcplchk = 'Y' AND
					Rcpltime = :ls_pltime AND Rcdlemp = :ls_dlemp AND Rcdlchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 ������� ���� ���� : " + sqlca.sqlerrtext
					goto Rollback_
				end if
				if wf_rtn015_create_history(ls_inemp,ls_inchk,ls_intime,ls_plemp,ls_plchk,ls_pltime, &
					ls_dlemp, 'Y', ls_nowtime, ls_message) = -1 then
					goto Rollback_
				end if
			end if
			//���Ϲ߼�
			if wf_send_email_ok( ls_gubun, ls_inemp, ls_emailcontent) = -1 then
				ls_message = "������翡�� => " + ls_gubun + " ���Ϲ߼ۿ���"
				goto Rollback_
			end if
		case else
			ls_message = "���� ���ǿ� ���� �ʴ� �����Դϴ�."
			goto Rollback_
	end choose
	
	COMMIT USING SQLCA;
	continue
	
	RollBack_:
	ROLLBACK USING SQLCA;
	Messagebox("Ȯ��", ls_message)
next

SQLCA.AUTOCOMMIT = True

iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
return 0
end event

type cb_signcancel from commandbutton within w_rtn042u
integer x = 741
integer y = 76
integer width = 535
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�������"
end type

event clicked;long ll_cnt
string ls_gubun, ls_inemp, ls_inempname, ls_inchk, ls_intime, ls_plemp, ls_plempname
string ls_plchk, ls_pltime, ls_dlemp, ls_dlempname, ls_emailcontent, ls_nowtime, ls_message, ls_dept

setpointer(hourglass!)
ls_nowtime = f_get_systemdate(sqlca)

SQLCA.AUTOCOMMIT = FALSE
for ll_cnt = 1 to dw_rtn042u_01.rowcount()
	if dw_rtn042u_01.getitemstring(ll_cnt,"sel_chk") <> 'Y' then
		Continue
	end if
	
	ls_gubun = dw_rtn042u_01.getitemstring(ll_cnt, "gubun")
	ls_inemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rainemp")
	ls_inempname = dw_rtn042u_01.getitemstring(ll_cnt, "inempname")
	ls_inchk = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rainchk")
	ls_intime = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raintime")
	ls_plemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raplemp")
	ls_plempname = dw_rtn042u_01.getitemstring(ll_cnt, "plempname")
	ls_plchk = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raplchk")
	ls_pltime = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rapltime")
	ls_dlemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_radlemp")
	ls_dlempname = dw_rtn042u_01.getitemstring(ll_cnt, "dlempname")
	
	if ls_inchk = 'Y' and ls_plchk = 'Y' then
		is_chk_status = 'DL'
		ls_emailcontent = " => " + ls_intime + " ������ ���ο�û���� " + ls_dlempname + " ������ ��������Ͽ����ϴ�. ~r~n" &
					+ " ��������Ͻô� " + ls_nowtime + " �Դϴ�.~r~n"
	elseif ls_inchk = 'Y' and ls_plchk = 'N' then
		is_chk_status = 'PL'
		ls_emailcontent = " => " + ls_intime + " ������ ���ο�û���� " + ls_plempname + " P/L�� ��������Ͽ����ϴ�.~r~n" &
					+ " ��������Ͻô� " + ls_nowtime + " �Դϴ�.~r~n"
	else
		is_chk_status = 'PE'
	end if
	
	Choose case is_chk_status
		case 'PE'	//����� �������
			continue
		case 'PL'
			SELECT BB.Pedept INTO :ls_dept
			FROM PBRTN.RTN019 AA INNER JOIN PBCOMMON.DAC003 BB
				ON AA.Xplemp = BB.Peempno
			WHERE AA.Xplemp = :g_s_empno
			using sqlca;
			
			if f_spacechk(ls_dept) = -1  then
				ls_message = "������������ P/L ���������� Ȯ���� �ֽñ� �ٶ��ϴ�."
				goto Rollback_
			end if
			
			if ls_gubun = 'RTN011' then
				UPDATE PBRTN.RTN011
				SET Rainchk = 'N', Raintime = '', Raplemp = '', Raplchk = 'N'
				WHERE Racmcd ='01' AND Rainemp = :ls_inemp AND Rainchk = 'Y' AND
					Raintime = :ls_intime AND Raplemp = :ls_plemp AND Raplchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 PL���� ���� ��ҿ���"
					goto Rollback_
				end if
			else
				UPDATE PBRTN.RTN013
				SET Rcinchk = 'N', Rcintime = '', Rcplemp = '', Rcplchk = 'N'
				WHERE Rccmcd ='01' AND Rcinemp = :ls_inemp AND Rcinchk = 'Y' AND
					Rcintime = :ls_intime AND Rcplemp = :ls_plemp AND Rcplchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 PL���� ���� ��ҿ���"
					goto Rollback_
				end if
			end if
			//���Ϲ߼�
			if wf_send_email_cancel( ls_gubun, ls_inemp, ls_emailcontent) = -1 then
				ls_message = "P/L������ҿ��� => " + ls_gubun + " ���Ϲ߼ۿ���"
				goto Rollback_
			end if
		case 'DL'
			if ls_gubun = 'RTN011' then
				UPDATE PBRTN.RTN011
				SET Raplchk = 'N', Rapltime = '', Radlemp = ''
				WHERE Racmcd ='01' AND Rainemp = :ls_inemp AND Rainchk = :ls_inchk AND
					Raintime = :ls_intime AND Raplemp = :ls_plemp AND Raplchk = :ls_plchk AND
					Rapltime = :ls_pltime AND Radlemp = :ls_dlemp AND Radlchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 PL���� ���� ��ҿ���"
					goto Rollback_
				end if
			else
				UPDATE PBRTN.RTN013
				SET Rcplchk = 'N', Rcpltime = '', Rcdlemp = ''
				WHERE Rccmcd ='01' AND Rcinemp = :ls_inemp AND Rcinchk = :ls_inchk AND
					Rcintime = :ls_intime AND Rcplemp = :ls_plemp AND Rcplchk = :ls_plchk AND
					Rcpltime = :ls_pltime AND Rcdlemp = :ls_dlemp AND Rcdlchk = 'N'
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 PL���� ���� ��ҿ���"
					goto Rollback_
				end if
			end if
			//���Ϲ߼�
			if wf_send_email_cancel( ls_gubun, ls_plemp, ls_emailcontent) = -1 then
				ls_message = "���������ҿ��� => " + ls_gubun + " ���Ϲ߼ۿ���"
				goto Rollback_
			end if
		case else
			ls_message = "���� ��ҿ� �����ʴ� ����Ÿ �Դϴ�."
			goto Rollback_
	end choose
	
	COMMIT USING SQLCA;
	continue
	
	Rollback_:
	ROLLBACK USING SQLCA;
	Messagebox("Ȯ��",ls_message)
next

SQLCA.AUTOCOMMIT = TRUE
iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
return 0
end event

type st_1 from statictext within w_rtn042u
integer x = 32
integer y = 260
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12639424
string text = "���系��"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn042u_01 from u_vi_std_datawindow within w_rtn042u
integer x = 37
integer y = 352
integer width = 3269
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn042u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;call super::buttonclicked;string ls_colname
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'b_none' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','Y')
	next
	This.object.b_none.visible = False
	This.object.b_yes.visible = True
elseif ls_colname = 'b_yes' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','N')
	next
	This.object.b_none.visible = True
	This.object.b_yes.visible = False
end if

return 0
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_chtime, ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime
string ls_dlemp, ls_dlchk, ls_dltime

if currentrow < 1 then
	return 0
end if

dw_rtn042u_02.reset()
if this.getitemstring(currentrow,"gubun") = 'RTN011' then
	dw_rtn042u_02.dataobject = "d_rtn042u_02"
else
	dw_rtn042u_02.dataobject = "d_rtn042u_03"
end if
dw_rtn042u_02.settransobject(sqlca)

ls_inemp = this.getitemstring(currentrow,"rtn011_rainemp") + '%'
ls_inchk = this.getitemstring(currentrow,"rtn011_rainchk") + '%'
ls_intime = this.getitemstring(currentrow,"rtn011_raintime") + '%'
ls_plemp = this.getitemstring(currentrow,"rtn011_raplemp") + '%'
ls_plchk = this.getitemstring(currentrow,"rtn011_raplchk") + '%'
ls_pltime = this.getitemstring(currentrow,"rtn011_rapltime") + '%'
ls_dlemp = this.getitemstring(currentrow,"rtn011_radlemp") + '%'
ls_dlchk = this.getitemstring(currentrow,"rtn011_radlchk") + '%'
ls_dltime = this.getitemstring(currentrow,"rtn011_radltime") + '%'
dw_rtn042u_02.retrieve(ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime, &
	ls_dlemp, ls_dlchk, ls_dltime, g_s_date)

return 0
end event

type st_2 from statictext within w_rtn042u
integer x = 32
integer y = 904
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "���系�� ��������"
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn042u_02 from u_vi_std_datawindow within w_rtn042u
integer x = 37
integer y = 992
integer width = 3269
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn042u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;call super::buttonclicked;string ls_colname
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'b_none' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','Y')
	next
	This.object.b_none.visible = False
	This.object.b_yes.visible = True
elseif ls_colname = 'b_yes' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','N')
	next
	This.object.b_none.visible = True
	This.object.b_yes.visible = False
end if

return 0
end event

type cb_delete from commandbutton within w_rtn042u
integer x = 1390
integer y = 76
integer width = 535
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���系������"
end type

event clicked;long ll_cnt
string ls_gubun, ls_inemp, ls_inempname, ls_inchk, ls_intime, ls_plemp, ls_plempname
string ls_plchk, ls_pltime, ls_dlemp, ls_dlempname, ls_emailcontent, ls_nowtime, ls_message, ls_dept

setpointer(hourglass!)
ls_nowtime = f_get_systemdate(sqlca)

SQLCA.AUTOCOMMIT = FALSE
for ll_cnt = 1 to dw_rtn042u_01.rowcount()
	if dw_rtn042u_01.getitemstring(ll_cnt,"sel_chk") <> 'Y' then
		Continue
	end if
	
	ls_gubun = dw_rtn042u_01.getitemstring(ll_cnt, "gubun")
	ls_inemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rainemp")
	ls_inempname = dw_rtn042u_01.getitemstring(ll_cnt, "inempname")
	ls_inchk = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rainchk")
	ls_intime = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raintime")
	ls_plemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raplemp")
	ls_plempname = dw_rtn042u_01.getitemstring(ll_cnt, "plempname")
	ls_plchk = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_raplchk")
	ls_pltime = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_rapltime")
	ls_dlemp = dw_rtn042u_01.getitemstring(ll_cnt, "rtn011_radlemp")
	ls_dlempname = dw_rtn042u_01.getitemstring(ll_cnt, "dlempname")
	
	Choose case is_chk_status
		case 'PE'	//����� ���系������
			if ls_gubun = 'RTN011' then
				UPDATE PBRTN.RTN011
				SET Raflag = 'R', Rainchk = 'Y', Raplchk = 'Y', Radlchk = 'Y'
				WHERE Racmcd ='01' AND Rainemp = :ls_inemp AND Rainchk = :ls_inchk AND
					Raintime = :ls_intime AND Raplemp = :ls_plemp AND Raplchk = :ls_plchk
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 ����� ���系�������ÿ� ������ �߻��߽��ϴ�"
					goto Rollback_
				end if
			else
				UPDATE PBRTN.RTN013
				SET Rcflag = 'R', Rcinchk = 'Y', Rcplchk = 'Y', Rcdlchk = 'Y'
				WHERE Rccmcd ='01' AND Rcinemp = :ls_inemp AND Rcinchk = :ls_inchk AND
					Rcintime = :ls_intime AND Rcplemp = :ls_plemp AND Rcplchk = :ls_plchk
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 ����� ���系�������ÿ� ������ �߻��߽��ϴ� : " + sqlca.sqlerrtext
					goto Rollback_
				end if
			end if
		case else
			ls_message = "���系�� ������ �Ұ����մϴ�."
			goto Rollback_
	end choose
	
	COMMIT USING SQLCA;
	continue
	
	Rollback_:
	ROLLBACK USING SQLCA;
	Messagebox("Ȯ��",ls_message)
next

SQLCA.AUTOCOMMIT = TRUE
iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
return 0
end event

type st_3 from statictext within w_rtn042u
integer x = 2025
integer y = 56
integer width = 1390
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "** �Է�,�������� ��������:����������� ����"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rtn042u
integer x = 2025
integer y = 144
integer width = 1390
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "** �������� �Ϸ�����:����������� ����"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_rtn042u
integer x = 32
integer y = 12
integer width = 1970
integer height = 212
integer taborder = 10
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

