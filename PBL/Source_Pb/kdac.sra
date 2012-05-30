$PBExportHeader$kdac.sra
$PBExportComments$종합정보시스템 Appl
forward
global type kdac from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//업무별 Transaction 변환
Transaction		sqlcb, sqlcc, sqlce, sqlcs, sqlxx, sqlyy, sqlzz, sqlpis, sqleis
Transaction 	sqlcmms, sqlmpms, sqlbook,sqlfms  
//Pass Word 관련
String 		g_s_company, 	g_s_empno=""	, 	g_s_kornm=""	, 	g_s_wkcd=""		,	g_s_deptcd=""	, g_s_empcd="", &
				g_s_runparm,	g_s_winid		,	gs_areacode	, 	gs_divisioncode	, 	gs_servername	, gs_userlevel, &
				gs_appname ,	gs_inifile = "c:\kdac\kdac.ini"		,	g_s_serverarea		,	g_s_expired = 'N'

//도움말 관련		 
Dec    		g_n_tabno = 0
//권한 관련
String 		g_s_autarea	,	g_s_autplnt	,	g_s_autdiv,	g_s_autext1	,	g_s_autext2
String 		g_s_date		,	g_s_datetime, 	g_s_time
String 		g_s_ipaddr	,	g_s_macaddr
//connect check 용
String 		g_s_sugangfg
Ulong 		g_l_connect	,	g_l_open

String 		check_conn	=	'0'
Boolean 		gb_focus
String 		gs_kmarea	,	gs_kmdivision
String 		gs_tag		,	gs_path



end variables

global type kdac from application
string appname = "kdac"
end type
global kdac kdac

type prototypes
Function string  ef_dateproc(string s, string t, integer i, integer div, integer selection)   Library "DTPROC32.dll"
function int gethostname(ref string name, int namelen) library "wsock32.dll" 
function string GetHost(string lpszhost, ref blob lpszaddress) library "ip_addr.dll" 

function ulong CreateMutexA(ulong lpMutexAttributes, boolean bInitialOwner, &
                        					ref string lpName) library "kernel32.dll"
function ulong GetLastError() library "kernel32.dll"
function ulong CloseHandle(ulong hMutex) library "kernel32.dll"
function ulong FindWindowA(ulong classname, string windowname) library "user32.dll"
function boolean DeleteFileA(ref string filename) LIBRARY "Kernel32.dll"

// FUNCTION boolean GetComputerNameA(ref string  cname,ref long  nbuf) LIBRARY "Kernel32.dll"



end prototypes
type variables
n_macip uo_macip

end variables

forward prototypes
public subroutine wf_chk_tmstemp ()
public function boolean wf_authority_check (string ag_system)
public subroutine wf_connection ()
end prototypes

public subroutine wf_chk_tmstemp ();select	empname,deptcode into	:g_s_kornm,:g_s_deptcd	from tmstemp
where	empno = :g_s_empno using sqlpis ;

if 	g_s_deptcd >= '3900' and g_s_deptcd <= '3999' then  //자금팀//
	g_s_wkcd = '2' 
else
	g_s_wkcd = '1'
end if
end subroutine

public function boolean wf_authority_check (string ag_system);Integer	ln_count

if	ag_system	=	'MPMS'	then 
	select count(*) into :ln_count  from comm140
			where emp_no = :g_s_empno and rtrim(upper(substring(use_win,1,5))) in ('W_MPM','W_')
	using sqlpis ;
	if ln_count >= 1 then
		return true
	end if
elseif	ag_system	=	'CMMS'	then
	select count(*) into :ln_count  from comm140
			where emp_no = :g_s_empno and rtrim(upper(substring(use_win,1,6))) in ('W_PISM','W_PISF','W_','W_PIS')
	using sqlpis ;
	if ln_count >= 1 then
		return true
	end if
end if

return false
end function

public subroutine wf_connection ();string	ls_computer,ls_database,ls_logpass

//AS/400 Connection
SQLCA.DBMS       		= 	"ODBC"
SQLCA.autocommit 		=	true
SQLCA.DBParm     		= 	"ConnectString='DSN=CA/400 ODBC FOR PB;UID=casinv;PWD=dpainv',PBCatalogOwner='PBCOMMON',CommitOnDisconnect='No',DisableBind=1" 
//인사DB
SQLCC						= 	CREATE transaction
SQLCC.DBMS       		= 	"ODBC"
SQLCC.autocommit 		= 	true
SQLCC.DBParm 			= 	"ConnectString='DSN=CA/400 ODBC FOR PB;UID=PERPRF;PWD=DPHPER',PBCatalogOwner='PBCOMMON',CommitOnDisconnect='No',DisableBind=1"
//품질보증DB
SQLcs 					= 	CREATE transaction
SQLcs.DBMS       		= 	"MSS Microsoft SQL Server 6.x"
SQLcs.ServerName		= 	"121.182.131.132,1433"
SQLcs.Database   		= 	"DM"
SQLcs.LogID      		= 	"sa"
SQLcs.LogPass    		= 	"kdac2238"
SQLcs.AutoCommit 		= 	True
SQLcs.DBParm 			= 	"CommitOnDisconnect='No'"
//도서관리DB
SQLbook 					= 	CREATE transaction
SQLbook.DBMS       	= 	"MSS Microsoft SQL Server 6.x"
SQLbook.ServerName 	= 	"121.182.131.132,1433"
SQLbook.Database   	= 	"book"
SQLbook.LogID      	= 	"sa"
SQLbook.LogPass    	= 	"kdac2238"
SQLbook.AutoCommit 	= 	True
SQLbook.DBParm 		= 	"CommitOnDisconnect='No'"

connect using SQLCA ;
If sqlca.sqlcode <> 0 then
	g_l_connect = -1
else 
	g_l_connect = 0
end if

// Win 95, 98
RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\VNETSUP", "ComputerName", ls_computer)
ls_database		= 	trim(ProfileString(gs_inifile,g_s_serverarea,"DataBase",			" "))
ls_logpass     =	trim(ProfileString(gs_inifile,g_s_serverarea,"LogPass",		" "))
gs_servername	= 	ProfileString(gs_inifile,g_s_serverarea,"ServerName",	" ")
if ls_database	<>	'IPIS' then
	ls_database 	= 	'IPIS'
	ls_logpass 		= 	'goipis'
	gs_servername	= 	"121.182.130.30,1433" 
end if
SQLPIS 					= 	CREATE transaction
SQLPIS.ServerName 	=	gs_servername
SQLPIS.DBMS       	= 	ProfileString(gs_inifile,g_s_serverarea,"DBMS",			" ")
SQLPIS.Database   	= 	ls_database
SQLPIS.LogID      	= 	ProfileString(gs_inifile,g_s_serverarea,"LogId",			" ")
SQLPIS.LogPass    	= 	ls_logpass
SQLPIS.DBParm 			= 	"CommitOnDisconnect='No'"
SQLPIS.AutoCommit 	= 	True
gs_appname	      	=	ProfileString(gs_inifile,"PARAMETER","AppName",            " ")

Connect using SQLPIS;

If SQLPIS.sqlcode <> 0 then
	disconnect using sqlpis ;
	destroy sqlpis
	if 	g_l_connect = -1 then
		messagebox("확인","데이타베이스 연결 오류 [정보시스템팀]으로 연락바랍니다.")
      	halt close
	end if
	SQLPIS	= 	CREATE transaction
	SQLPIS 	=	SQLCA
	connect using SQLPIS;
	g_l_connect = -2
end if

//// 2007년 12월 4일 전장서버 부하문제로 수정
//// EIS DB
//SQLEIS 							= 	CREATE transaction
//SQLEIS.DBMS       			= 	ProfileString(gs_inifile,"DATABASE_EIS","DBMS",			" ")
//SQLEIS.ServerName 			= 	ProfileString(gs_inifile,"DATABASE_EIS","ServerName",	" ")
//SQLEIS.Database   			= 	ProfileString(gs_inifile,"DATABASE_EIS","Database",		" ")
//SQLEIS.LogID      				= 	ProfileString(gs_inifile,"DATABASE_EIS","LogId",			" ")
//SQLEIS.LogPass    			= 	ProfileString(gs_inifile,"DATABASE_EIS","LogPass",		" ")
//SQLEIS.DBParm 				= 	"CommitOnDisconnect='No'"
//SQLEIS.AutoCommit 			= 	True
//
//gs_appname						= 	ProfileString(gs_inifile,"PARAMETER","AppName"," ")
//
//connect using SQLEIS;
//
//If SQLEIS.sqlcode <> 0 then
//	disconnect using sqleis ;
//	destroy sqleis
//end if
////  끝

if wf_authority_check('CMMS') = true or f_spacechk(g_s_empno) = -1 then
	// CMMS DB
	SQLCMMS 					= 	CREATE transaction
	SQLCMMS.DBMS       	= 	ProfileString(gs_inifile,g_s_serverarea,"DBMS",			" ")
	SQLCMMS.ServerName 	= 	gs_servername
	SQLCMMS.Database   	= 	"CMMS"
	SQLCMMS.LogID      	= 	ProfileString(gs_inifile,g_s_serverarea,"LogId",			" ")
	SQLCMMS.LogPass    	= 	ProfileString(gs_inifile,g_s_serverarea,"LogPass",		" ")
	SQLCMMS.DBParm 		= 	"CommitOnDisconnect='No'"
	SQLCMMS.AutoCommit 	= 	True
	gs_appname				= 	ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
	Connect Using SQLCMMS;
end if

if wf_authority_check('MPMS') = true or f_spacechk(g_s_empno) = -1 then
	// ELE_SERVER MPMS DB
	SQLMPMS 					= 	CREATE transaction
	SQLMPMS.DBMS       	= 	ProfileString(gs_inifile,'DAEGU',"DBMS",			" ")
	SQLMPMS.ServerName 	= 	ProfileString(gs_inifile,"DAEGU","ServerName",	" ")
	SQLMPMS.Database   	= 	"MPMS"
	SQLMPMS.LogID      	= 	ProfileString(gs_inifile,"DAEGU","LogId",			" ")
	SQLMPMS.LogPass    	= 	ProfileString(gs_inifile,"DAEGU","LogPass",		" ")
	SQLMPMS.DBParm 		= 	"CommitOnDisconnect='No'"
	SQLMPMS.AutoCommit 	= 	True
	gs_appname				= 	ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
	Connect Using SQLMPMS;
end if


end subroutine

on kdac.create
appname="kdac"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on kdac.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String	ls_name = "kdac",	ls_file	=	"c:\kdac\pbl",	ls_profile,ls_registry,ls_devname = 'kdac - PowerBuilder'
Uint 		rc1, rc2,fc1,fc2

SetPointer(HourGlass!)
rc1		= 	CreateMutexA(0,false,ls_name )
rc2 	=	GetLastError()
if	FileExists(ls_file)	=	true then
else
	if	rc2	=	183 then
		messagebox("실행오류", "이미 KDAC 종합정보시스템이 실행중입니다")
		closehandle(rc1)
		halt close 
	end if
end if

//여주 공장내 IP 추가관련 -- 2007.01.15
if 	FileExists( "c:\kdac\kdac.ini") = false then
	messagebox("확인","kdac.ini 파일을 찾을 수 없습니다.시스템 개발팀으로 문의 바랍니다")
	halt close
else
	ls_profile = profilestring( "c:\kdac\kdac.ini", "IPADDR", "192.168.127", "")
	if ls_profile <> "YEO" then
		setprofilestring(  "c:\kdac\kdac.ini", "IPADDR", "192.168.127", '"YEO"')
	end if
end if 
// AS/400 ODBC IP 변경 관련 -- 2007년 7월 9일
registryget("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","SYSTEM",ls_registry)
if 	ls_registry <> "121.182.130.2" and ls_registry <> "121.182.130.7" then
	registryset("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","SYSTEM",RegString!, "121.182.130.2" )
end if
registryget("HKEY_USERS\.DEFAULT\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","SYSTEM",ls_registry)
if 	ls_registry <> "121.182.130.2" and ls_registry <> "121.182.130.7" then
	registryset("HKEY_USERS\.DEFAULT\SOFTWARE\ODBC\ODBC.INI\CA/400 ODBC for PB","SYSTEM",RegString!, "121.182.130.2" )
end if
//
commandline 		=	trim(commandline)
g_s_empno     		=	mid(commandline,1,6)
g_s_serverarea  	= 	trim(mid(commandline,7,5))

if mid(commandline,1,5)	=	'ADMIN' then
	g_s_empno      	= 	mid(commandline,1,5)
	g_s_serverarea		= 	trim(mid(commandline,6,5))
elseif	len(commandline) > 8 then 
	g_s_empno      	= 	mid(commandline,1,6)
	g_s_serverarea		= 	trim(mid(commandline,7,5))
elseif 	len(commandline) <= 8 then 	
	g_s_empno      	= 	mid(commandline,1,3)
	g_s_serverarea		= 	trim(mid(commandline,4,5))
end if

if f_spacechk(g_s_serverarea) = -1 or g_s_serverarea = 'SEOUL' or g_s_serverarea = 'ELE' or &
	g_s_serverarea = 'MOR' or g_s_serverarea = 'HVA'	then
	// DAEGU SERVER 추가 - 2012.03.08 추가
	ls_profile = profilestring( "c:\kdac\kdac.ini", "DAEGU", "ServerName", "")
	if ls_profile = "" then
		setprofilestring( "c:\kdac\kdac.ini",  "DAEGU", "DBMS",'"MSS Microsoft SQL Server"' ) 
		setprofilestring( "c:\kdac\kdac.ini",  "DAEGU", "ServerName",'"121.182.130.30,1433"')
		setprofilestring( "c:\kdac\kdac.ini",  "DAEGU", "Database",'"IPIS"')
		setprofilestring( "c:\kdac\kdac.ini",  "DAEGU", "LogId", '"sa"')
		setprofilestring( "c:\kdac\kdac.ini",  "DAEGU", "LogPass",'"goipis"')
		setprofilestring( "c:\kdac\kdac.ini",  "DAEGU", "DBParm",'"CommitOnDisconnect=' + "'No'" + '"')	
		
		setprofilestring( "c:\kdac\kdac.ini",  "ELE", "DBMS",'' ) 
		setprofilestring( "c:\kdac\kdac.ini",  "ELE", "ServerName",'')
		setprofilestring( "c:\kdac\kdac.ini",  "ELE", "Database",'')
		setprofilestring( "c:\kdac\kdac.ini",  "ELE", "LogId", '')
		setprofilestring( "c:\kdac\kdac.ini",  "ELE", "LogPass",'')
		setprofilestring( "c:\kdac\kdac.ini",  "ELE", "DBParm",'')	
		
		setprofilestring( "c:\kdac\kdac.ini",  "MOR", "DBMS",'' ) 
		setprofilestring( "c:\kdac\kdac.ini",  "MOR", "ServerName",'')
		setprofilestring( "c:\kdac\kdac.ini",  "MOR", "Database",'')
		setprofilestring( "c:\kdac\kdac.ini",  "MOR", "LogId", '')
		setprofilestring( "c:\kdac\kdac.ini",  "MOR", "LogPass",'')
		setprofilestring( "c:\kdac\kdac.ini",  "MOR", "DBParm",'')	
		
		setprofilestring( "c:\kdac\kdac.ini",  "HVA", "DBMS",'' ) 
		setprofilestring( "c:\kdac\kdac.ini",  "HVA", "ServerName",'')
		setprofilestring( "c:\kdac\kdac.ini",  "HVA", "Database",'')
		setprofilestring( "c:\kdac\kdac.ini",  "HVA", "LogId", '')
		setprofilestring( "c:\kdac\kdac.ini",  "HVA", "LogPass",'')
		setprofilestring( "c:\kdac\kdac.ini",  "HVA", "DBParm",'')	
	end if
	g_s_serverarea = 'DAEGU'
end if

wf_connection()

f_sysdate()

// Mac_address & Ip_address setting
uo_macip 	=	CREATE n_macip
uo_macip.uf_getmacaddr(g_s_macaddr)
uo_macip.uf_getipaddr(g_s_ipaddr)
Destroy		uo_macip 

g_s_company = '01'
if f_spacechk(g_s_empno) = -1 then
	fc1		= 	FindWindowA(0,ls_devname )
	if	fc1 <> 0 then
		open(w_top)	
	else
		messagebox("실행오류", "실행파일 선택 오류..kdac.exe가 아닌 ~r~n~r~nkdacdown.exe를 실행하시기 바랍니다")
		halt close 
	end if
else
	SELECT	autarea,autplnt, autdiv,autext1,out_emp_name	,emp_level 
		INTO 	:g_s_autarea, :g_s_autplnt, :g_s_autdiv,:g_s_autext1,:g_s_kornm ,:gs_userlevel  
	FROM 	pbcommon.comm121
	WHERE 	emp_no	=	:g_s_empno
	Using 	SqlCA ;
	g_s_wkcd	=	"1"				//회계전표처리 지역( 대구-1, 서울-2 )
	if	len(g_s_empno) = 6 and isnumber(g_s_empno) = true then
   		if 	g_l_connect <> -1 then
			SELECT	penamek,pedept	Into :g_s_kornm,:g_s_deptcd		FROM pbcommon.dac003
			WHERE 	peempno	=	:g_s_empno 
			USING 	SqlCa ;
			if 	g_s_deptcd >= '3900' and g_s_deptcd <= '3999' then  //자금팀//
				g_s_wkcd = '2' 
			else
				g_s_wkcd = '1'
			end if
		else
  			wf_chk_tmstemp()
		end if
	end if
	/* Open MDI frame window */
	Open(w_frame)
	Opensheet(w_menu, w_frame, 0, Layered!)
end if

end event

event systemerror;//
end event

