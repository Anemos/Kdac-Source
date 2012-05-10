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

String 		gs_inifile			// ȯ�漳�� ���ϸ� 
String 		gs_line_name		// ���θ�   
String 		gs_model_code		// ���ڵ�    
String 		gs_password			// ��й�ȣ     
Integer 		gi_Refresh			// ����ȭ�� Refresh �ֱ� (����, Sec)    
Integer 		gi_CYCLE_OFFSET	// Refresh �ֱ� OFFSET     
Integer 		gi_CycleTime		// ������ ����� CYCLE TIME       
Integer 		gi_ProcTime			// ��� TIME       

Boolean 		gb_focus				// User Object (����) ���ý� Focus
String 		gs_cur_userid		// User Object (����) ���ý� Focus
String 		gs_userid			// User Object (����) ���ý� Focus
String 		gs_Screen_Top		// 1�� �������� ȭ���� ���� ������ ��뿩�� 
String 		gs_ETC				// ��Ÿ ��뿩�� (Y:���� Ư�̻��� ���, N:����)
String 		gs_ETC_DATA			// ���� Ư�̻��� DATA 
String 		gs_ETC_TEXT			// ��ǥ���� TEXT 




end variables

global type orms from application
string appname = "orms"
end type
global orms orms

type prototypes
//------------------------------------------------------------------------------------------------
// Application ������ �˾Ƴ��� 
//------------------------------------------------------------------------------------------------
FUNCTION ulong GetCurrentDirectoryA(ulong buffern, ref string path ) LIBRARY "Kernel32.dll"


//------------------------------------------------------------------------------------------------
// Application ���������� �˾Ƴ��� 
//------------------------------------------------------------------------------------------------
Function ulong CreateMutexA (ulong lpMutexAttributes, int bInitialOwner, ref string lpName) library "kernel32.dll"	
Function boolean ReleaseMutex(UINT hMutex) Library "Kernel32.dll"


//------------------------------------------------------------------------------------------------
// Application �����޽��� �˾Ƴ��� 
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
// Purpose			: Main Menu ���������̼� ��ũ��Ʈ
//--------------------------------------------------------------------------
// Log:
// DATE		    NAME				REVISION
//--------------------------------------------------------------------------
// 2010.06.01	 FIT				�űԻ���
// 2011.06.10	 FIT				������ ���� (�ְ�-OT, �߰�-���� ����)
//--------------------------------------------------------------------------


//-----------------------------------------
// �ߺ����� Check
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
		// �������̸�
		//		���α׷� ���� 
		MessageBox("�ߺ�����","��������Ȳ~n ~n���ø����̼��� �̹� �������Դϴ�.")
		ReleaseMutex(li_mutex)
		Halt close
		Return
	End if
else
	// Close Event
	ReleaseMutex(li_mutex)
End If


//-----------------------------------------
// Application ���ȹ��
//-----------------------------------------
string ls_curdir 
ulong  li_buf 

li_buf = 100 
ls_curdir = space(li_buf) 
GetCurrentDirectoryA(li_buf, ls_curdir) 

gs_inifile = ls_curdir + "\" + This.AppName + ".ini"

//-----------------------------------------
// DATABASE ��������  
//-----------------------------------------
SQLCA.DBMS   		= ProfileString(gs_inifile,"Database", "DBMS",        	"")
SQLCA.ServerName 	= ProfileString(gs_inifile,"Database", "ServerName",     "")
SQLCA.Database   	= ProfileString(gs_inifile,"Database",	"Database",       "")
SQLCA.LogID      	= ProfileString(gs_inifile,"Database", "LogID",          "")
SQLCA.LogPass    	= ProfileString(gs_inifile,"Database", "LogPass",      	"")


//-----------------------------------------
// ��Ÿ ��������  
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
	MessageBox("DB���� ����","Database ���ӿ� ��ְ� �߻��Ͽ����ϴ� !!!!" + &
									 "~n ~n �ý��۰����ڿ��� �����ּ��� !!!!")
	Halt Close
	Return
End If




end event

event close;// DATABASE �������� 
Disconnect;

end event

event systemerror;// �ý��� ERROR �߻��� 
Open(w_error)



end event

