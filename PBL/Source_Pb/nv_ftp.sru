$PBExportHeader$nv_ftp.sru
forward
global type nv_ftp from nonvisualobject
end type
end forward

global type nv_ftp from nonvisualobject
end type
global nv_ftp nv_ftp

type prototypes
//FTP관련 함수들...
FUNCTION INT FTPConnect (String IP_ADDRESS, String USER_ID, String PASSWORD) LIBRARY "FTP.DLL"
FUNCTION INT FTPDisconnect ( ) LIBRARY "FTP.DLL"
FUNCTION INT FTPgetCurrentDir (REF BLOB DATA) LIBRARY "FTP.DLL"
FUNCTION INT FTPsetCurrentDirUp () LIBRARY "FTP.DLL"
FUNCTION INT FTPsetCurrentDir (String CURR_DIR) LIBRARY "FTP.DLL"
FUNCTION INT FTPfileList ( REF BLOB DATA ) LIBRARY "FTP.DLL"
FUNCTION INT FTPgetFile ( String REMOTE_FILE, String LOCAL_FILE, integer BINARY_OR_TEXT ) LIBRARY "FTP.DLL"
FUNCTION INT FTPcreateDir ( String NEW_DIR ) LIBRARY "FTP.DLL"
FUNCTION INT FTPdeleteFile ( String DEL_FILE ) LIBRARY "FTP.DLL"
FUNCTION INT FTPdeleteDir ( String DEL_DIR ) LIBRARY "FTP.DLL"
FUNCTION INT FTPrenameDir ( String CURR_DIR, String NEW_DIR ) LIBRARY "FTP.DLL"
FUNCTION INT FTPputFile ( String LOCAL_FILE, String REMOTE_FILE, integer BINARY_OR_TEXT ) LIBRARY "FTP.DLL"
FUNCTION INT FTPping ( String IPaddress ) LIBRARY "FTP.DLL"


end prototypes

type variables
CONSTANT Int BINARY_MODE = 0
CONSTANT Int TEXT_MODE = 1
end variables

forward prototypes
public function integer of_ftpconnect (string as_ftp, string as_ftpid, string as_ftppwd)
public function integer of_ftpdisconnect ()
public function integer of_ftpping (string as_ftp)
public function integer of_setcurrdir (string as_newpath)
public function integer of_createdir (string as_newdirname)
public function integer of_deletedir (string as_deletedir)
public function integer of_renamedir (string as_olddirname, string as_newdirname)
public function integer of_deletefile (string as_deletefile)
public function integer of_getfile (string as_server_filepath, string as_client_filepath, integer ai_mode)
public function integer of_putfile (string as_clientpath, string as_serverpath, integer ai_mode)
public function integer of_filelist (listbox alb_1)
public function integer of_getcurrdir (ref string as_currdir)
public function integer of_setcurrdirup (ref string as_dirup)
end prototypes

public function integer of_ftpconnect (string as_ftp, string as_ftpid, string as_ftppwd);Int li_rtn

li_rtn = FTPConnect (as_ftp, as_ftpid, as_ftppwd)

Return li_rtn
end function

public function integer of_ftpdisconnect ();Int li_rtn

li_rtn = FTPDisconnect()

Return li_rtn
end function

public function integer of_ftpping (string as_ftp); Int li_rtn
 
 li_rtn = FTPping(as_ftp)
 
 Return li_rtn
end function

public function integer of_setcurrdir (string as_newpath);Int li_rtn

li_rtn = FTPsetCurrentDir(as_newpath) 

choose case li_rtn
	case 0
		// 성공
	case -1
		MessageBox( "알림!", "Permission denied!" )
	case else
		MessageBox( "알림!", "FTPsetCurrentDir() 함수 오류! newpath=" + as_newpath + ", errcode=" + String( li_rtn ) )
end choose

Return li_rtn
end function

public function integer of_createdir (string as_newdirname);Int li_rtn

li_rtn = FTPcreateDir(as_newdirname)
IF li_rtn < 0 THEN MessageBox("알림!", "FTPcreateDir() 함수 실패!")

Return li_rtn

end function

public function integer of_deletedir (string as_deletedir);Int li_rtn

li_rtn = FTPdeleteDir(as_deletedir)
IF li_rtn < 0 THEN MessageBox("알림!", "FTPdeleteDir() 함수 실패!")

Return li_rtn
end function

public function integer of_renamedir (string as_olddirname, string as_newdirname);Int li_rtn

li_rtn = FTPrenameDir (as_olddirname, as_newdirname)
IF li_rtn < 0 THEN MessageBox("알림!", "FTPdeleteDir() 함수 실패!")

Return li_rtn
end function

public function integer of_deletefile (string as_deletefile);Int li_rtn

li_rtn = FTPdeleteFile (as_deletefile)
IF li_rtn < 0 THEN MessageBox("알림!", "FTPdeleteFile() 함수 실패!")

Return li_rtn

end function

public function integer of_getfile (string as_server_filepath, string as_client_filepath, integer ai_mode);Int li_rtn

li_rtn = FTPgetFile (as_server_filepath, as_client_filepath, ai_mode) 
IF li_rtn < 0 THEN MessageBox("알림!" + String(li_rtn), "FTP서버로 부터 파일 가져오기를 실패했습니다.")

Return li_rtn

end function

public function integer of_putfile (string as_clientpath, string as_serverpath, integer ai_mode);Int li_rtn

//gnv_ftp.of_setcurrdir(as_serverpath)
li_rtn = FTPputFile (as_clientpath, as_serverpath, ai_mode) 
IF li_rtn < 0 THEN MessageBox("알림!" + String(li_rtn), "FTP서버에 파일 쓰기를 실패했습니다.")

Return li_rtn
end function

public function integer of_filelist (listbox alb_1);Blob lb_data
String ls_data, ls_temp
Long ll_list, ll_start = 1, ll_size
Int li_rtn

alb_1.Reset()

lb_data = Blob (space (2048))
li_rtn = FTPfileList (ref lb_data)
IF li_rtn < 0 THEN
	//MessageBox("알림!", "FTPfileList() 함수 오류!")
	//File이 없음... 
	Return li_rtn
END IF

ls_data = Trim(string(lb_data))

ll_list = pos (ls_data, "~t", 1)
DO WHILE ll_list > 0
	ls_temp = mid(ls_data, ll_start, ll_list - ll_start)
	alb_1.additem (ls_temp)
	ls_temp = ""
	ll_start = ll_list + 1
	ll_list = pos (ls_data, "~t", ll_start)
LOOP

Return li_rtn

end function

public function integer of_getcurrdir (ref string as_currdir);Int li_rtn
Blob lb_data

lb_data = Blob(Space(2048))

li_rtn = FTPgetCurrentDir(ref lb_data)
IF li_rtn < 0 THEN MessageBox("알림", "FTPgetCurrentDir() Error!")

as_currDir = Trim(String(lb_data))

Return li_rtn
end function

public function integer of_setcurrdirup (ref string as_dirup);Int li_rtn
Blob lb_data

li_rtn = FTPsetCurrentDirUp()
IF li_rtn < 0 THEN
	MessageBox("알림!", "FTPsetCurrentDirUp() 함수 오류!")
	Return li_rtn
END IF

lb_data = Blob(Space(2048))

li_rtn = FTPgetCurrentDir (ref lb_data)
IF li_rtn < 0 THEN
	MessageBox("알림", "FTPgetCurrentDir() Error!")
	Return li_rtn
END IF

as_dirup = Trim(String(lb_data))

Return li_rtn
end function

on nv_ftp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_ftp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

