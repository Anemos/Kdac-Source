$PBExportHeader$orms.sra
$PBExportComments$Generated Application Object
forward
global type orms from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

String 		gs_inifile			// 환경설정 파일명 
String 		gs_line_name		// 라인명   
String 		gs_model_code		// 모델코드    
String 		gs_password			// 비밀번호     
Integer 		gi_Refresh			// 메인화면 Refresh 주기 (단위, Sec)    
Integer 		gi_CYCLE_OFFSET	// Refresh 주기 OFFSET     
Integer 		gi_CycleTime		// 마지막 생산모델 CYCLE TIME       
Integer 		gi_ProcTime			// 경과 TIME       

Boolean 		gb_focus				// User Object (일자) 선택시 Focus
String 		gs_cur_userid		// User Object (일자) 선택시 Focus
String 		gs_userid			// User Object (일자) 선택시 Focus
String 		gs_Screen_Top		// 1분 간격으로 화면을 제일 앞으로 사용여부 
String 		gs_ETC				// 기타 사용여부 (Y:전장 특이사항 사용, N:공통)
String 		gs_ETC_DATA			// 전장 특이사항 DATA 
String 		gs_ETC_TEXT			// 목표수량 TEXT 




end variables

global type orms from application
string appname = "orms"
end type
global orms orms

type prototypes
//------------------------------------------------------------------------------------------------
// Application 실행경로 알아내기 
//------------------------------------------------------------------------------------------------
FUNCTION ulong GetCurrentDirectoryA(ulong buffern, ref string path ) LIBRARY "Kernel32.dll"


//------------------------------------------------------------------------------------------------
// Application 실행중인지 알아내기 
//------------------------------------------------------------------------------------------------
Function ulong CreateMutexA (ulong lpMutexAttributes, int bInitialOwner, ref string lpName) library "kernel32.dll"	
Function boolean ReleaseMutex(UINT hMutex) Library "Kernel32.dll"


//------------------------------------------------------------------------------------------------
// Application 오류메시지 알아내기 
//------------------------------------------------------------------------------------------------
Function ulong GetLastError() library "kernel32.dll" 


end prototypes

on orms.create
appname="orms"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on orms.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//--------------------------------------------------------------------------
// Tool Version 	: PB9.0.3 Build 8004
// Event	 			: Application.Open
// Purpose			: Main Menu 어프리케이션 스크립트
//--------------------------------------------------------------------------
// Log:
// DATE		    NAME				REVISION
//--------------------------------------------------------------------------
// 2010.06.01	 FIT				신규생성
// 2011.06.10	 FIT				가동율 개선 (주간-OT, 야간-조출 적용)
//--------------------------------------------------------------------------


//-----------------------------------------
// 중복실행 Check
//-----------------------------------------
string 	ls_mutex_name
long 	 	ll_err
long 		li_mutex

If handle (GetApplication(), False) <> 0 then
	//Create the mutex. 
	//Since we're not going to do anything withit, 
	//			ignore the first two arguments
	ls_mutex_name	= This.AppName + Char (0)
	li_mutex	= CreateMutexA (0, 0, ls_mutex_name)
	ll_err	= GetLastError()
	
	If ll_err = 183 then    
		// 실행중이면
		//		프로그램 종료 
		MessageBox("중복실행","가동율현황~n ~n애플리케이션이 이미 실행중입니다.")
		ReleaseMutex(li_mutex)
		Halt close
		Return
	End if
else
	// Close Event
	ReleaseMutex(li_mutex)
End If


//-----------------------------------------
// Application 경로획득
//-----------------------------------------
string ls_curdir 
ulong  li_buf 

li_buf = 100 
ls_curdir = space(li_buf) 
GetCurrentDirectoryA(li_buf, ls_curdir) 

gs_inifile = ls_curdir + "\" + This.AppName + ".ini"

//-----------------------------------------
// DATABASE 설정정보  
//-----------------------------------------
SQLCA.DBMS   		= ProfileString(gs_inifile,"Database", "DBMS",        	"")
SQLCA.ServerName 	= ProfileString(gs_inifile,"Database", "ServerName",     "")
SQLCA.Database   	= ProfileString(gs_inifile,"Database",	"Database",       "")
SQLCA.LogID      	= ProfileString(gs_inifile,"Database", "LogID",          "")
SQLCA.LogPass    	= ProfileString(gs_inifile,"Database", "LogPass",      	"")


//-----------------------------------------
// 기타 설정정보  
//-----------------------------------------
gs_line_name		= ProfileString(gs_inifile,"Common", "LINE_NAME",        		"")
gi_Refresh			= Integer(ProfileString(gs_inifile,"Common", "REFRESH",  		"5")) 
gs_Screen_Top		= ProfileString(gs_inifile,"Common", "TOPMOST",          		"N")


SQLCA.DBParm = ''
SQLCA.AutoCommit	= true
Connect;

If (sqlca.Sqlcode = 0) Then
	OpenWithParm(w_main, "Show")
Else
	MessageBox("DB접속 오류","Database 접속에 장애가 발생하였습니다 !!!!" + &
									 "~n ~n 시스템관리자에게 연락주세요 !!!!")
	Halt Close
	Return
End If




end event

event close;// DATABASE 연결해제 
Disconnect;

end event

event systemerror;// 시스템 ERROR 발생시 
Open(w_error)



end event

