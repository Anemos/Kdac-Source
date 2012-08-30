$PBExportHeader$u_cmms_ftp.sru
$PBExportComments$FTP 관련 OBJECT
forward
global type u_cmms_ftp from nonvisualobject
end type
end forward

global type u_cmms_ftp from nonvisualobject
end type
global u_cmms_ftp u_cmms_ftp

type prototypes
FUNCTION ulong FtpGetFileA( ulong hService, string szRemoteFile, string szLocalFile, boolean bFailIfExist, ulong dwLocalFlags, ulong dwInetFals, ulong dwContext ) LIBRARY "wininet.dll"
FUNCTION ulong FtpPutFileA( ulong hService, string szLocalFile, string szRemoteFile, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll"
FUNCTION ulong InternetOpenA(string sAgent, long lAccessType, string sProxyName, string sProxyByPass, long lFlags) LIBRARY "wininet.dll"
FUNCTION ulong InternetConnectA(long hInternetSession, string sServerName, integer nServerPort, string sUserName, string sPassword, long lService, long lFlags, long lContext) LIBRARY "wininet.dll"
FUNCTION ulong InternetCloseHandle(long hInet) LIBRARY "wininet.dll"
FUNCTION ulong InternetGetLastResponseInfoA(long lpdwError, string lpszBuffer, long lpdwBufferLength) LIBRARY "wininet.dll"
FUNCTION ulong FtpDeleteFileA(ulong hSession, string lpszFileName) LIBRARY "wininet.dll"
FUNCTION ulong FtpGetCurrentDirectoryA( ulong hService, REF string szPath, REF ulong lpdwBuffLength ) LIBRARY "wininet.dll"
FUNCTION ulong FtpCreateDirectory( ulong hSession, string lpszDirectory ) LIBRARY "wininet.dll"
FUNCTION ulong FtpFindFirstFileA( ulong hSession, string szSearchFile, REF FINDDATA lpvData, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll"
FUNCTION ulong FtpRemoveDirectory( ulong hSession, string lpszDirectory ) LIBRARY "wininet.dll"
FUNCTION ulong FtpRenameFileA( ulong hSession, string lpszExisting, string lpszNew ) LIBRARY "wininet.dll"
FUNCTION ulong FtpSetCurrentDirectoryA( ulong hService, string szPath ) LIBRARY "wininet.dll"
FUNCTION ulong InternetFindNextFileA( ulong hFind, REF FINDDATA lpvData ) LIBRARY "wininet.dll"
FUNCTION ulong InternetGetConnectedState( REF ulong lpdwFlags, ulong dwReserved ) LIBRARY "wininet.dll"
FUNCTION ulong InternetReadFile( ulong hFile, REF string lpBuffer, ulong dwBytesToRead, REF ulong lpBytesRead ) LIBRARY "wininet.dll"
FUNCTION ulong InternetHangup( ulong dwConnection, ulong dwReserved ) LIBRARY "wininet.dll"
FUNCTION ulong GetLastError() LIBRARY "kernel32.dll"

Function Long SetCurrentDirectoryA (ref String lpPathName) LIBRARY "KERNEL32.DLL"
FUNCTION ULONG ShellExecuteA(ulong hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, INT nShowCmd) LIBRARY "shell32.dll"
FUNCTION ulong GetTempPathA(ulong BufferLength, ref String lpTmpPath) LIBRARY "KERNEL32.DLL"
FUNCTION ulong SHGetSpecialFolderPathA(ulong hwnd, ref String lpPath, int nFolder, Boolean bCreate) LIBRARY "Shell32.dll"
end prototypes

type variables
// Internet connection flags
CONSTANT uint CONNECTION_MODEM	= 1
CONSTANT uint CONNECTION_LAN		= 2
CONSTANT uint CONNECTION_PROXY	= 4
CONSTANT uint CONNECTION_MODEM_BUSY	= 8
CONSTANT ulong INTERNET_FLAG_ASYNC	= 268435456
CONSTANT ulong INTERNET_FLAG_SECURE	= 8388608

// Internet auto-dial flags
CONSTANT uint AUTODIAL_FORCE_ONLINE		= 1
CONSTANT uint AUTODIAL_FORCE_UNATTENDED	= 2
CONSTANT uint AUTODIAL_FAILIFSECURITYCHECK	= 4

// Internet dial flags
CONSTANT uint INTERNET_DIAL_UNATTENDED	= 32768

CONSTANT uint FTP_TRANSFER_TYPE_ASCII		= 1
CONSTANT uint FTP_TRANSFER_TYPE_BINARY	= 2

// Internet open flags
CONSTANT uint OPEN_TYPE_PRECONFIG	= 0
CONSTANT uint OPEN_TYPE_DIRECT	= 1
CONSTANT uint OPEN_TYPE_GATEWAY	= 2
CONSTANT uint OPEN_TYPE_PROXY		= 3

// Ports
CONSTANT uint INVALID_PORT_NUMBER	= 0
CONSTANT uint DEFAULT_FTP_PORT	= 21
CONSTANT uint DEFAULT_GOPHER_PORT	= 70
CONSTANT uint DEFAULT_HTTP_PORT	= 80
CONSTANT uint DEFAULT_HTTPS_PORT	= 443
CONSTANT uint DEFAULT_SOCKS_PORT	= 1080

// Service/Command types
CONSTANT uint FTP	= 1
CONSTANT uint GOPHER	= 2
CONSTANT uint HTTP	= 3

// Internet flags
CONSTANT ulong INTERNET_FLAG_RELOAD			= 2147483648
CONSTANT ulong INTERNET_FLAG_NO_CACJE_WRITE		= 67108864
CONSTANT ulong INTERNET_FLAG_RAW_DATA		= 1073741824

// Error messages
CONSTANT uint ERROR_NO_MORE_FILES			= 18
CONSTANT uint INTERNET_ERROR_BASE			= 12000
CONSTANT uint ERROR_INTERNET_OUT_OF_HANDLES		= (INTERNET_ERROR_BASE + 1)
CONSTANT uint ERROR_INTERNET_TIMEOUT			= (INTERNET_ERROR_BASE + 2)
CONSTANT uint ERROR_INTERNET_EXTENDED_ERROR		= (INTERNET_ERROR_BASE + 3)
CONSTANT uint ERROR_INTERNET_INTERNAL_ERROR		= (INTERNET_ERROR_BASE + 4)
CONSTANT uint ERROR_INTERNET_INVALID_URL			= (INTERNET_ERROR_BASE + 5)
CONSTANT uint ERROR_INTERNET_UNRECOGNIZED_SCHEME	= (INTERNET_ERROR_BASE + 6)
CONSTANT uint ERROR_INTERNET_NAME_NOT_RESOLVED	= (INTERNET_ERROR_BASE + 7)
CONSTANT uint ERROR_INTERNET_PROTOCOL_NOT_FOUND	= (INTERNET_ERROR_BASE + 8)
CONSTANT uint ERROR_INTERNET_INVALID_OPTION		= (INTERNET_ERROR_BASE + 9)
CONSTANT uint ERROR_INTERNET_BAD_OPTION_LENGTH        	= (INTERNET_ERROR_BASE + 10)
CONSTANT uint ERROR_INTERNET_OPTION_NOT_SETTABLE      	= (INTERNET_ERROR_BASE + 11)
CONSTANT uint ERROR_INTERNET_SHUTDOWN                 		= (INTERNET_ERROR_BASE + 12)
CONSTANT uint ERROR_INTERNET_INCORRECT_USER_NAME      	= (INTERNET_ERROR_BASE + 13)
CONSTANT uint ERROR_INTERNET_INCORRECT_PASSWORD       	= (INTERNET_ERROR_BASE + 14)
CONSTANT uint ERROR_INTERNET_LOGIN_FAILURE            		= (INTERNET_ERROR_BASE + 15)
CONSTANT uint ERROR_INTERNET_INVALID_OPERATION        	= (INTERNET_ERROR_BASE + 16)
CONSTANT uint ERROR_INTERNET_OPERATION_CANCELLED      	= (INTERNET_ERROR_BASE + 17)
CONSTANT uint ERROR_INTERNET_INCORRECT_HANDLE_TYPE    	= (INTERNET_ERROR_BASE + 18)
CONSTANT uint ERROR_INTERNET_INCORRECT_HANDLE_STATE   	= (INTERNET_ERROR_BASE + 19)
CONSTANT uint ERROR_INTERNET_NOT_PROXY_REQUEST        	= (INTERNET_ERROR_BASE + 20)
CONSTANT uint ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND	= (INTERNET_ERROR_BASE + 21)
CONSTANT uint ERROR_INTERNET_BAD_REGISTRY_PARAMETER   	= (INTERNET_ERROR_BASE + 22)
CONSTANT uint ERROR_INTERNET_NO_DIRECT_ACCESS         	= (INTERNET_ERROR_BASE + 23)
CONSTANT uint ERROR_INTERNET_NO_CONTEXT               		= (INTERNET_ERROR_BASE + 24)
CONSTANT uint ERROR_INTERNET_NO_CALLBACK              		= (INTERNET_ERROR_BASE + 25)
CONSTANT uint ERROR_INTERNET_REQUEST_PENDING          	= (INTERNET_ERROR_BASE + 26)
CONSTANT uint ERROR_INTERNET_INCORRECT_FORMAT         	= (INTERNET_ERROR_BASE + 27)
CONSTANT uint ERROR_INTERNET_ITEM_NOT_FOUND           	= (INTERNET_ERROR_BASE + 28)
CONSTANT uint ERROR_INTERNET_CANNOT_CONNECT           	= (INTERNET_ERROR_BASE + 29)
CONSTANT uint ERROR_INTERNET_CONNECTION_ABORTED       	= (INTERNET_ERROR_BASE + 30)
CONSTANT uint ERROR_INTERNET_CONNECTION_RESET         	= (INTERNET_ERROR_BASE + 31)
CONSTANT uint ERROR_INTERNET_FORCE_RETRY              		= (INTERNET_ERROR_BASE + 32)
CONSTANT uint ERROR_INTERNET_INVALID_PROXY_REQUEST    	= (INTERNET_ERROR_BASE + 33)
CONSTANT uint ERROR_INTERNET_NEED_UI                  		= (INTERNET_ERROR_BASE + 34)
CONSTANT uint ERROR_INTERNET_HANDLE_EXISTS            		= (INTERNET_ERROR_BASE + 36)
CONSTANT uint ERROR_INTERNET_SEC_CERT_DATE_INVALID    	= (INTERNET_ERROR_BASE + 37)
CONSTANT uint ERROR_INTERNET_SEC_CERT_CN_INVALID      	= (INTERNET_ERROR_BASE + 38)
CONSTANT uint ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR   	= (INTERNET_ERROR_BASE + 39)
CONSTANT uint ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR   	= (INTERNET_ERROR_BASE + 40)
CONSTANT uint ERROR_INTERNET_MIXED_SECURITY           		= (INTERNET_ERROR_BASE + 41)
CONSTANT uint ERROR_INTERNET_CHG_POST_IS_NON_SECURE   	= (INTERNET_ERROR_BASE + 42)
CONSTANT uint ERROR_INTERNET_POST_IS_NON_SECURE       	= (INTERNET_ERROR_BASE + 43)
CONSTANT uint ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED  	= (INTERNET_ERROR_BASE + 44)
CONSTANT uint ERROR_INTERNET_INVALID_CA               		= (INTERNET_ERROR_BASE + 45)
CONSTANT uint ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP    	= (INTERNET_ERROR_BASE + 46)
CONSTANT uint ERROR_INTERNET_ASYNC_THREAD_FAILED      	= (INTERNET_ERROR_BASE + 47)
CONSTANT uint ERROR_INTERNET_REDIRECT_SCHEME_CHANGE   	= (INTERNET_ERROR_BASE + 48)
CONSTANT uint ERROR_INTERNET_DIALOG_PENDING           		= (INTERNET_ERROR_BASE + 49)
CONSTANT uint ERROR_INTERNET_RETRY_DIALOG             		= (INTERNET_ERROR_BASE + 50)
CONSTANT uint ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR  	= (INTERNET_ERROR_BASE + 52)
CONSTANT uint ERROR_INTERNET_INSERT_CDROM             		= (INTERNET_ERROR_BASE + 53)
CONSTANT uint ERROR_FTP_TRANSFER_IN_PROGRESS          	= (INTERNET_ERROR_BASE + 110)
CONSTANT uint ERROR_FTP_DROPPED                       		= (INTERNET_ERROR_BASE + 111)
CONSTANT uint ERROR_FTP_NO_PASSIVE_MODE               		= (INTERNET_ERROR_BASE + 112)
CONSTANT uint ERROR_GOPHER_PROTOCOL_ERROR             	= (INTERNET_ERROR_BASE + 130)
CONSTANT uint ERROR_GOPHER_NOT_FILE                   		= (INTERNET_ERROR_BASE + 131)
CONSTANT uint ERROR_GOPHER_DATA_ERROR                 		= (INTERNET_ERROR_BASE + 132)
CONSTANT uint ERROR_GOPHER_END_OF_DATA                		= (INTERNET_ERROR_BASE + 133)
CONSTANT uint ERROR_GOPHER_INVALID_LOCATOR            		= (INTERNET_ERROR_BASE + 134)
CONSTANT uint ERROR_GOPHER_INCORRECT_LOCATOR_TYPE     	= (INTERNET_ERROR_BASE + 135)
CONSTANT uint ERROR_GOPHER_NOT_GOPHER_PLUS            	= (INTERNET_ERROR_BASE + 136)
CONSTANT uint ERROR_GOPHER_ATTRIBUTE_NOT_FOUND        	= (INTERNET_ERROR_BASE + 137)
CONSTANT uint ERROR_GOPHER_UNKNOWN_LOCATOR            	= (INTERNET_ERROR_BASE + 138)
CONSTANT uint ERROR_HTTP_HEADER_NOT_FOUND             	= (INTERNET_ERROR_BASE + 150)
CONSTANT uint ERROR_HTTP_DOWNLEVEL_SERVER             	= (INTERNET_ERROR_BASE + 151)
CONSTANT uint ERROR_HTTP_INVALID_SERVER_RESPONSE      	= (INTERNET_ERROR_BASE + 152)
CONSTANT uint ERROR_HTTP_INVALID_HEADER               		= (INTERNET_ERROR_BASE + 153)
CONSTANT uint ERROR_HTTP_INVALID_QUERY_REQUEST        	= (INTERNET_ERROR_BASE + 154)
CONSTANT uint ERROR_HTTP_HEADER_ALREADY_EXISTS        	= (INTERNET_ERROR_BASE + 155)
CONSTANT uint ERROR_HTTP_REDIRECT_FAILED              		= (INTERNET_ERROR_BASE + 156)
CONSTANT uint ERROR_HTTP_NOT_REDIRECTED               		= (INTERNET_ERROR_BASE + 160)
CONSTANT uint ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION    	= (INTERNET_ERROR_BASE + 161)
CONSTANT uint ERROR_HTTP_COOKIE_DECLINED              		= (INTERNET_ERROR_BASE + 162)
CONSTANT uint ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION  	= (INTERNET_ERROR_BASE + 168)
CONSTANT uint ERROR_INTERNET_SECURITY_CHANNEL_ERROR   	= (INTERNET_ERROR_BASE + 157)
CONSTANT uint ERROR_INTERNET_UNABLE_TO_CACHE_FILE     	= (INTERNET_ERROR_BASE + 158)
CONSTANT uint ERROR_INTERNET_TCPIP_NOT_INSTALLED      	= (INTERNET_ERROR_BASE + 159)
CONSTANT uint ERROR_INTERNET_DISCONNECTED             		= (INTERNET_ERROR_BASE + 163)
CONSTANT uint ERROR_INTERNET_SERVER_UNREACHABLE       	= (INTERNET_ERROR_BASE + 164)
CONSTANT uint ERROR_INTERNET_PROXY_SERVER_UNREACHABLE 	= (INTERNET_ERROR_BASE + 165)
CONSTANT uint ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT    		= (INTERNET_ERROR_BASE + 166)
CONSTANT uint ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT 	= (INTERNET_ERROR_BASE + 167)
CONSTANT uint ERROR_INTERNET_SEC_INVALID_CERT    		= (INTERNET_ERROR_BASE + 169)
CONSTANT uint ERROR_INTERNET_SEC_CERT_REVOKED    	= (INTERNET_ERROR_BASE + 170)
CONSTANT uint ERROR_INTERNET_FAILED_DUETOSECURITYCHECK	= (INTERNET_ERROR_BASE + 171)
CONSTANT uint INTERNET_ERROR_LAST                       		= ERROR_INTERNET_FAILED_DUETOSECURITYCHECK

// FTP 관련 
boolean ib_connected
Long il_ftp_maxsize
String is_ftp_ip
String is_ftp_id
String is_ftp_pwd
String is_localftp_folder = "c:\kdac\cmmsftp\"
String is_tmpftp_folder = "C:\temp\"



end variables

forward prototypes
public function string uf_get_remotepath ()
public function string uf_remote_dirlist ()
public function integer uf_remote_size ()
public function integer uf_disconnect ()
public function integer uf_chksize (long al_filesize, ref string rs_errmsg)
public function integer uf_putfile (string ls_localfile, string ls_remote, boolean bl_ascii, ref string rs_errmsg)
public function integer uf_remote_filedel (string ls_filepath, ref string rs_errmsg)
public function integer uf_remote_rename (string as_oldfilenam, string as_newfilenam, ref string rs_errmsg)
public function integer uf_set_remotepath (string ls_remotepath, ref string rs_errmsg)
public function integer uf_getftpinfo (ref string rs_errmsg)
public function string uf_getrealremotefilenam (string as_fileid, string as_filenam)
public function integer uf_connect (ref string rs_errmsg)
public function integer uf_getfile (string ls_remotefile, string ls_localpath, boolean bl_ascii, ref string rs_errmsg)
public function integer uf_delfileinfo (string as_fileid, ref string rs_msg)
public function integer uf_download (string as_fileid, string as_filenam, ref string rs_msg)
public function integer uf_chg (string as_fileid, string as_filenam, string as_filedesc, ref string rs_msg)
public function integer uf_isremotefileexist (string as_filenam, ref string rs_errmsg)
public function integer uf_exe (string as_fileid, string as_filenam, ref string rs_msg)
public function integer uf_upload (string as_equipcode, ref boolean ab_upopened, ref string rs_fileid, ref string rs_msg)
public function integer uf_del (string as_fileid, string as_filenam, ref string rs_msg)
end prototypes

public function string uf_get_remotepath ();Int li_ret
long li_chrCount
String ls_remoteDir

//li_ret = FtpGetCurrentDirectoryA(g_l_connect, ls_remoteDir, li_chrCount)

return ls_remoteDir
end function

public function string uf_remote_dirlist ();string ls_file
FINDDATA pData
ulong hFind, ul_rtn=1

hFind = FtpFindFirstFileA(g_l_connect, '*.*', pData, INTERNET_FLAG_RAW_DATA, 0)

IF hFind > 0 THEN
	IF pData.dwfileattrib <> 16 THEN
		ls_file += pData.cFilename + "~r~n"
	END IF
	DO WHILE ul_rtn > 0
		ul_rtn = InternetFindNextFileA(hFind, pData)
		IF ul_rtn > 0 THEN
			IF pData.dwfileattrib <> 16 THEN
				ls_file += pData.cFilename + "~r~n"
			END IF
		END IF
	LOOP
END IF

return ls_file
end function

public function integer uf_remote_size ();FINDDATA pData
long  ll_size = 0
ulong hFind, ul_rtn=1

hFind = FtpFindFirstFileA(g_l_connect, '*.*', pData, INTERNET_FLAG_RAW_DATA, 0)

IF hFind > 0 THEN
	IF pData.dwfileattrib <> 16 THEN
		ll_size += pData.nFileSizeLow
	END IF
	DO WHILE ul_rtn > 0
		ul_rtn = InternetFindNextFileA(hFind, pData)
		IF ul_rtn > 0 THEN
			IF pData.dwfileattrib <> 16 THEN
				ll_size += pData.nFileSizeLow
			END IF
		END IF
	LOOP
END IF

return ll_size
end function

public function integer uf_disconnect ();if g_l_connect <> 0 then
	InternetCloseHandle(g_l_connect)
	if g_l_open <> 0 then
		InternetCloseHandle(g_l_open)
		g_l_connect = 0
      g_l_open = 0
		ib_connected = False
		return 1
	else
		return -1
	end if
else
	return -1
end if

end function

public function integer uf_chksize (long al_filesize, ref string rs_errmsg);Long ll_remotDirSize
String ls_msg

if ib_connected = False then
	rs_errmsg = "[PATH:u_cmms_ftp/uf_chksize]~r~n" &
				+"]~r~n[에러내용:FTP 서버에 연결되지 않았읍니다.]"
	return -1
end if

ll_remotDirSize = uf_remote_size()
if (al_fileSize + ll_remotDirSize) > il_ftp_maxsize then
	rs_errmsg = "[PATH:u_cmms_ftp/uf_chksize]~r~n" &
				+"]~r~n[에러내용:현재 FTP서버 저장용량(" &
				+ String(il_ftp_maxsize/1000000000) + "G)이 부족합니다."
	return 0
end if

return 1

end function

public function integer uf_putfile (string ls_localfile, string ls_remote, boolean bl_ascii, ref string rs_errmsg);ulong ul_mode, ul_rtn

IF bl_ascii = TRUE then
	ul_mode = FTP_TRANSFER_TYPE_ASCII
ELSE
	ul_mode = FTP_TRANSFER_TYPE_BINARY
END IF

ul_rtn = FtpPutFileA(g_l_connect, ls_localfile, ls_remote, ul_mode, 0)

if ul_rtn <> 0 then
	return 1
else
	rs_errmsg = "[PATH:u_cmms_ftp/uf_putfile/FtpPutFileA]~r~n[에러코드:"+String(GetLastError()) &
					+"]~r~n[에러내용:파일을 FTP서버로 전송중 오류가 발생했읍니다.]"
	return -1
end if


end function

public function integer uf_remote_filedel (string ls_filepath, ref string rs_errmsg);ulong ul_rtn
Int	li_error

ul_rtn = FtpDeleteFileA(g_l_connect, ls_filepath)

if ul_rtn <> 0 then
	return 1
else
	rs_errmsg = "[PATH:u_cmms_ftp/uf_remote_filedel/FtpDeleteFileA]~r~n[에러코드:" &
					+String(GetLastError())+"]~r~n[에러내용:FTP파일을 삭제중 오류가 발생했읍니다.]"
	return -1
end if
end function

public function integer uf_remote_rename (string as_oldfilenam, string as_newfilenam, ref string rs_errmsg);ulong ll_rtn

ll_rtn = FtpRenameFileA(g_l_connect, as_oldFileNam, as_newFileNam)
if ll_rtn = 1 then
	return 1
else
	rs_errmsg = "[PATH:u_cmms_ftp/uf_remote_rename/FtpRenameFileA]~r~n[에러코드:" &
				+String(GetLastError())+"]~r~n[에러내용:FTP파일명 변경중 오류가 발생했읍니다.]"
	return -1
end if
end function

public function integer uf_set_remotepath (string ls_remotepath, ref string rs_errmsg);ulong ul_set

ul_set = FtpSetCurrentDirectoryA(g_l_connect, ls_remotepath)

if ul_set = 0 then
	rs_errmsg = "[PATH:u_cmms_ftp/uf_set_remotepath/FtpSetCurrentDirectoryA]~r~n[에러코드:" &
				+String(GetLastError())+"]~r~n[에러내용:FTP서버 경로 변경중 오류가 발생했읍니다.]"
	return -1
else
	return 1
end if

end function

public function integer uf_getftpinfo (ref string rs_errmsg);Int li_pos
li_pos = Pos(gs_servername, ',')
if li_pos > 0 then
	is_ftp_ip = Left(gs_servername, Len(gs_servername)-(Len(gs_servername)-li_pos)-1)
else
	is_ftp_ip = gs_servername
end if

Select USER_ID, USER_PW, FTP_MAXSIZE
  Into :is_ftp_id, :is_ftp_pwd, :il_ftp_maxsize
  From EQUIP_FTPUSER
 Where AREA_CODE = :gs_kmarea And FACTORY_CODE = :gs_kmdivision
 Using sqlcmms;
 
if sqlcmms.sqlcode <> 0 then
	rs_errmsg = "[PATH:u_cmms_ftp/uf_getftpinfo]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
						+"]~r~n[에러내용:"+sqlcmms.SQLErrText+"]~r~n" &
						+"FTP 정보를 가져오는중 에러가 발생했읍니다.~r~n[지역코드:" & 
						+gs_kmarea+"][공장코드:"+gs_kmdivision+"]"
	return -1
end if
			
return 1

end function

public function string uf_getrealremotefilenam (string as_fileid, string as_filenam);// 파일명이 한글일때 LASTPOS 결과가 이상해서

Int li_lastPos = 0, li_pos = 0
String ls_remoteFileNam

Do 
	li_lastPos = li_pos
	li_pos = Pos(as_fileNam, '.', li_pos+1)
Loop Until li_pos = 0

// FTP 서버 저장 파일명
if li_lastPos = 0 then 
	ls_remoteFileNam = as_fileNam + "(" + as_fileId + ")"
else 
	ls_remoteFileNam = Left(as_fileNam, li_lastPos -1) + "(" + as_fileId + ")" &
								+ Right(as_fileNam, Len(as_fileNam)-(li_lastPos -1))
end if

return ls_remoteFileNam
end function

public function integer uf_connect (ref string rs_errmsg);string ls_useragent = "pb wininet"
string ls_null

if Trim(is_ftp_ip)='' or Trim(is_ftp_id)='' or Trim(is_ftp_pwd)='' &
	or IsNull(is_ftp_ip) or IsNull(is_ftp_id) or IsNull(is_ftp_pwd) Then

	rs_errmsg = "[PATH:u_cmms_ftp/uf_connect]~r~n" &
					+"]~r~n[에러내용:Ftp 연결에 필요한 기초정보(IP,ID,PW)가 없읍니다.]"
	return -1
end if

SetNull(ls_null)

g_l_connect = 0
g_l_open = 0

g_l_open = InternetOpenA(ls_useragent, OPEN_TYPE_PRECONFIG, ls_null, ls_null, 0)

if g_l_open <> 0 then
	g_l_connect = InternetConnectA(g_l_open, is_ftp_ip, DEFAULT_FTP_PORT, is_ftp_id, is_ftp_pwd, FTP, 0, 0)
	if g_l_connect <> 0 then
		ib_connected = True
		return 1
	else
		ib_connected = False
		rs_errmsg = "[PATH:u_cmms_ftp/uf_connect/InternetConnectA]~r~n[에러코드:"+String(GetLastError()) &
						+"]~r~n[에러내용:Ftp 연결에 오류가 발생했읍니다.]"
		return -1
	end if
else
	ib_connected = False
	rs_errmsg = "[PATH:u_cmms_ftp/uf_connect/InternetOpenA]~r~n[에러코드:"+String(GetLastError()) &
					+"]~r~n[에러내용:InterNet Open에 오류가 발생했읍니다.]"
	return -1
end if

end function

public function integer uf_getfile (string ls_remotefile, string ls_localpath, boolean bl_ascii, ref string rs_errmsg);//nvo_ftp u_ftp
ulong ul_mode, ul_rtn
//u_ftp = Create nvo_ftp
IF bl_ascii = TRUE then
	ul_mode = FTP_TRANSFER_TYPE_ASCII
ELSE
	ul_mode = FTP_TRANSFER_TYPE_BINARY
END IF

ul_rtn = FtpGetFileA(g_l_connect, ls_remotefile, ls_localpath, FALSE, 0, ul_mode, 0)

if ul_rtn <> 0 then
	return 1
else
	rs_errmsg = "[PATH:u_cmms_ftp/uf_getfile/FtpGetFileA]~r~n[에러코드:"+String(GetLastError()) &
						+"]~r~n[에러내용:Ftp 파일을 가져오는중 오류가 발생했읍니다.]"
	return -1
end if

end function

public function integer uf_delfileinfo (string as_fileid, ref string rs_msg);
DELETE 
  FROM EQUIP_FTPFILE
 WHERE File_id = :as_fileid
 USING sqlcmms;
	 
if sqlcmms.sqlcode <> 0 then
	rs_msg = "[PATH:u_cmms_ftp/uf_delfileinfo/없는파일삭제]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
				+"]~r~n[에러내용:" + sqlcmms.sqlErrText+"]"
	return -1
end if
	
return 1
end function

public function integer uf_download (string as_fileid, string as_filenam, ref string rs_msg);Int li_rtn
String ls_filePath, ls_remoteFileNam

ls_filePath = is_localftp_folder

// DEFAULT DIR CHK
If DirectoryExists(ls_filePath) = False Then CreateDirectory (ls_filePath)

// DEFAULT 파일 저장 FULL 경로 
ls_filePath += as_fileNam

// FTP 서버 저장 파일명
ls_remoteFileNam = uf_getRealRemoteFileNam(as_fileid, as_fileNam)

// 로컬에 같은 파일 존재 유무
if FileExists(ls_filePath) = TRUE then 
	rs_msg = is_localftp_folder + "폴더에 ~r~n선택하신 파일(" + as_fileNam + ")이 있읍니다." &
							+ "~r~n다시 다운로드 하시겠읍니까?"
	if MessageBox("다운로드 파일 중복", rs_msg, Question!, YesNo!) = 2 then return 1
end if

li_rtn = GetFileSaveName("파일 저장", ls_filePath, as_fileNam, "*.*", &
										"All Files (*.*), *.*," + "Text Files (*.txt), *.txt," &
	 									+ "Doc Files (*.doc), *.doc," + "Xls Files (*.xls), *.xls")

if li_rtn <> 1 then return 1

// 실제 파일 존재 Chk
li_rtn = uf_isRemoteFileExist(ls_remoteFileNam, rs_msg)
if li_rtn = -1 then 
	return li_rtn
elseif li_rtn = 0 then
	MessageBox("확인", rs_msg)
	//DB 파일 정보 삭제
	li_rtn = uf_DelFileinfo(as_fileId, rs_msg)
	if li_rtn <> 1 then return li_rtn
end if

// 다운로드
return uf_getfile(".\" + ls_remoteFileNam, ls_filePath, FALSE, rs_msg)
end function

public function integer uf_chg (string as_fileid, string as_filenam, string as_filedesc, ref string rs_msg);Int li_rtn
String ls_filePath, ls_remoteFileNam, ls_chgfileNam, ls_chgfileDesc, ls_chgremoteFileNam
String ls_inDelPw, ls_dbDelPw
str_parm PwStr, ChgStr


// PW 확인
PwStr.s_parm[1] = "FTP 파일 변경"
OpenWithParm(w_ftpfile_pw, PwStr)
PwStr = Message.PowerObjectParm

//수정 취소
if PwStr.check = FALSE then return 1
ls_inDelPw = PwStr.s_array[1,1]

//수정 PW 정보 GET
SELECT DEL_PW
  INTO :ls_dbDelPw
  FROM EQUIP_FTPUSER
 WHERE AREA_CODE = :gs_kmarea AND FACTORY_CODE = :gs_kmdivision
 USING sqlcmms;

if sqlcmms.sqlcode <> 0 then
	rs_msg = "[PATH:u_cmms_ftp/uf_chg/패스워드체크]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
					+"]~r~n[에러내용:" + sqlcmms.sqlErrText+"]"
	return -1
end if 
//수정 PW 확인
if Upper(ls_dbDelPw) <> Upper(ls_inDelPw) then
	rs_msg = "삭제 패스워드가 틀립니다!!."
	return 0
end if

// 수정 사항 입력 다이얼로그
ChgStr.s_parm[1] = as_FileNam
ChgStr.s_parm[2] = as_FileDesc
OpenWithParm(w_ftpfile_chg, ChgStr)
ChgStr = Message.PowerObjectParm

//업로드 취소
if ChgStr.check = FALSE then return 1

ls_chgfileNam = trim(ChgStr.s_parm[1])
ls_chgfileDesc = trim(ChgStr.s_parm[2])
	
// FTP 에러시 대비 
sqlcmms.AutoCommit = False

//파일명 변경 X
if as_FileNam = ls_chgfileNam then
	//DB 파일 정보 변경
	UPDATE EQUIP_FTPFILE
		SET FILE_DESC = :ls_chgfileDesc
	 WHERE File_id = :as_FileId
	 USING sqlcmms;

	if sqlcmms.sqlcode <> 0 then
		rs_msg = "[PATH:u_cmms_ftp/uf_chg/파일내역변경]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
					+"]~r~n[에러내용:" + sqlcmms.sqlErrText+"]"
		RollBack Using SqlCmms;
		SqlCmms.AutoCommit = False

		return -1
	end if
// 파일명 변경 O
else
	//DB 파일 정보 변경
	UPDATE EQUIP_FTPFILE
		SET FILE_NAME = :ls_chgfileNam, FILE_DESC = :ls_chgfileDesc
	 WHERE File_id = :as_FileId
	 USING sqlcmms;

	if sqlcmms.sqlcode <> 0 then
		rs_msg = "[PATH:u_cmms_ftp/uf_chg/파일정보변경]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
					+"]~r~n[에러내용:" + sqlcmms.sqlErrText+"]"
		RollBack Using SqlCmms;
		SqlCmms.AutoCommit = False

		return -1
	end if
	
	// FTP 서버 저장 파일명
	ls_remoteFileNam = uf_getRealRemoteFileNam(as_FileId, as_FileNam)
	ls_chgremoteFileNam = uf_getRealRemoteFileNam(as_FileId, ls_chgfileNam)
	
	// 실제 파일 존재 Chk
	li_rtn = uf_isRemoteFileExist(ls_remoteFileNam, rs_msg)
	if li_rtn = -1 then 
		RollBack Using SqlCmms;
		SqlCmms.AutoCommit = False
		return -1
	elseif li_rtn = 0 then
		MessageBox("확인", rs_msg)
		//DB 파일 정보 삭제
		if uf_delfileinfo(as_FileId, rs_msg) <> 1 then
			RollBack Using SqlCmms;
			SqlCmms.AutoCommit = False
			return -1
		end if
	end if
	
	//파일명 변경
	li_rtn = uf_remote_rename(ls_remoteFileNam, ls_chgremoteFileNam, rs_msg)
	if li_rtn <> 1 then 
		RollBack Using SqlCmms;
		SqlCmms.AutoCommit = False
		return -1
	end if
		
end if
	
Commit Using sqlcmms;
sqlcmms.AutoCommit = true
return 1
end function

public function integer uf_isremotefileexist (string as_filenam, ref string rs_errmsg);//RETURN: 에러 -1, 없음: 0, 있음:1
Int li_pos
String ls_remoteFileList

if ib_connected = False then
	rs_errmsg = "[PATH:u_cmms_ftp/uf_IsRemoteFileExist]~r~n" &
						+"[에러내용:FTP 서버에 연결되지 않았읍니다.]"
	return -1
end if

ls_remoteFileList = uf_remote_dirlist()
li_pos = pos(Upper(ls_remoteFileList), Upper(as_fileNam))

if (li_pos > 0) then 
	return 1
else 
	rs_errmsg = "[PATH:u_cmms_ftp/uf_IsRemoteFileExist]~r~n" &
						+"[에러내용:FTP 서버에 파일이 존재하지 않읍니다.~r~n 파일정보를 삭제합니다.]"
	return 0
end if

end function

public function integer uf_exe (string as_fileid, string as_filenam, ref string rs_msg);Int li_rtn
String ls_filePath, ls_remoteFileNam, ls_eTmpFolder, ls_null

//윈도우 인터넷 TEMP PATH
RegistryGet("HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\EXPLORER\SHELL FOLDERS", "CACHE", ls_eTmpFolder)
if isNull(ls_eTmpFolder) Or trim(ls_eTmpFolder) = '' then
	If DirectoryExists(is_localftp_folder) = False Then CreateDirectory (is_localftp_folder)
	ls_filePath = is_localftp_folder
else 
	If DirectoryExists(ls_eTmpFolder) = False Then CreateDirectory (ls_eTmpFolder)
	ls_filePath = ls_eTmpFolder
end if 

// 파일 저장 FULL 경로
if Right(ls_filePath, 1) <> '\' then ls_filePath += '\'
ls_filePath += as_fileNam

// FTP 서버 저장 파일명
ls_remoteFileNam = uf_getRealRemoteFileNam(as_fileid, as_fileNam)
	
// 실제 파일 존재 Chk
li_rtn = uf_isRemoteFileExist(ls_remoteFileNam, rs_msg)
if li_rtn = -1 then 
	return li_rtn
elseif li_rtn = 0 then
	MessageBox("확인", rs_msg)
	//DB 파일 정보 삭제
	li_rtn = uf_remote_filedel(as_fileid, rs_msg)
	if li_rtn <> 1 then return li_rtn
end if

// 다운로드
li_rtn = uf_getfile(".\" + ls_remoteFileNam, ls_filePath, FALSE, rs_msg)
if li_rtn <> 1 then return li_rtn

// 실행
SetNull(ls_null)
li_rtn = ShellExecuteA(Handle(w_Frame.GetActiveSheet()), "open", ls_filePath, ls_null, ls_null, 1)
if li_rtn < 32 then
	run("rundll32.exe shell32.dll, OpenAs_RunDLL " + ls_filePath) 
end if

return 1
end function

public function integer uf_upload (string as_equipcode, ref boolean ab_upopened, ref string rs_fileid, ref string rs_msg);Long li_rtn, ll_localFileSize
String ls_filePath, ls_filedesc, ls_fileNam, ls_remoteFileNam, ls_tabufile, ls_extend
str_parm DescStr

// 디폴트 DIR
ls_filePath = is_localftp_folder

// default 디렉토리 설정
if ab_UpOpened = FALSE then SetCurrentDirectoryA(is_localftp_folder)
li_rtn = GetFileOpenName("업로드 파일 선택", ls_filePath, ls_FileNam, "*.*", &
										"All Files (*.*), *.*," + "Doc Files (*.doc), *.doc," &
										+ "Xls Files (*.xls), *.xls," + "Text Files (*.txt), *.txt")
if li_rtn <> 1 then return 1
ab_UpOpened = TRUE

// 파일명 길이 CHK
if Len(ls_FileNam) > 100 then
	rs_msg = "[PATH:u_cmms_ftp/uf_Upload/파일명길이체크]~r~n" &
					+"[에러내용:파일명이 너무 깁니다. 확장자 포함 100자까지 입니다..]"
	return 0
end if

// 업로드 파일 확장자 (.포함)
ls_extend = Right(ls_FileNam, Len(ls_FileNam) - Pos(ls_FileNam, ".") + 1)

// 파일 확장자 CHK (업로드 금지 파일)
SELECT TABU_FILE
  INTO :ls_tabufile
  FROM EQUIP_FTPUSER
 WHERE AREA_CODE = :gs_kmarea AND FACTORY_CODE = :gs_kmdivision
 USING SQLCMMS;

if SQLCMMS.sqlcode <> 0 then
	rs_msg = "[PATH:u_cmms_ftp/uf_Upload/금지파일체크]~r~n[에러코드:"+String(SQLCMMS.sqlcode) &
					+"]~r~n[에러내용:" + SQLCMMS.sqlErrText+"]"
	return -1
end if
//금지 파일 확인
if (trim(ls_tabufile) = '' Or isNull(ls_tabufile)) = FALSE then
	if Pos(Upper(ls_tabufile), Upper(ls_extend)) > 0 then
		rs_msg = "[PATH:u_cmms_ftp/uf_Upload/금지파일체크]~r~n[업로드 금지 파일 입니다.]"
		return 0
	end if
end if

// 파일 내역
DescStr.s_parm[1] = ls_filePath
OpenWithParm(w_ftpfile_desc, DescStr)
DescStr = Message.PowerObjectParm

//업로드 취소
if DescStr.check = FALSE then return 1
ls_fileDesc = DescStr.s_array[1,1]

//파일 사이즈 Chk
ll_localFileSize = FileLength(ls_filePath)
li_rtn = uf_chksize(ll_localFileSize, rs_msg)
if li_rtn = -1 or li_rtn = 0 then return li_rtn

//파일 사이즈 (KB 단위로 저장)
if (ll_localFileSize / 1000) = 0 then
	ll_localFileSize = 1
else 
	ll_localFileSize = (ll_localFileSize / 1000) + 1
end if 

// FTP 에러시 대비 
SQLCMMS.AutoCommit = False

// DB 파일 정보 Insert 및 파일 ID Get
DECLARE PROC_SET_FTPFILE PROCEDURE for SP_SET_FTPFILE 
			:gs_kmarea, :gs_kmdivision, :as_EquipCode, :ls_FileNam, 
			:ls_fileDesc, :ll_localFileSize, :g_s_empno, :rs_fileId
USING SQLCMMS;

Execute PROC_SET_FTPFILE;
if SQLCMMS.sqlcode = 0 then
	FETCH PROC_SET_FTPFILE INTO :rs_fileId;
	CLOSE PROC_SET_FTPFILE;
	if rs_fileId = 'XXXXXXXXXX' then
		rs_msg = "[PATH:u_cmms_ftp/uf_Upload/FTP파일ID생성]~r~n" &
					+"~r~n[에러내용:파일 ID가 FULL 상태입니다.~r~n 관리자에게 연락바랍니다!!]"
		RollBack Using SQLCMMS;
		SQLCMMS.AutoCommit = True
		return 0
	end if
else
	rs_msg = "[PATH:u_cmms_ftp/uf_Upload/FTP파일ID생성 및 저장]~r~n[에러코드:"+String(SQLCMMS.sqlcode) &
				+"]~r~n[에러내용:" + SQLCMMS.sqlErrText+"]"
	RollBack Using SQLCMMS;
	SQLCMMS.AutoCommit = True

	return -1
end if

// FTP 서버 저장 파일명
ls_remoteFileNam = uf_getRealRemoteFileNam(rs_fileId, ls_FileNam)
	
// UPLOAD
li_rtn = uf_putfile(ls_filePath, ".\" + ls_remoteFileNam, FALSE, rs_msg)
if li_rtn <> 1 then 
	RollBack Using SQLCMMS;
	SQLCMMS.AutoCommit = True

	return -1
end if

Commit Using SQLCMMS;
SQLCMMS.AutoCommit = true
return 1
end function

public function integer uf_del (string as_fileid, string as_filenam, ref string rs_msg);Int li_rtn
String ls_remoteFileNam, ls_inDelPw, ls_dbDelPw, ls_msg
str_parm PwStr, chgstr


ls_msg = "파일명: " + as_FileNam + "를 삭제 하시겠읍니까?"
if messagebox("파일삭제", ls_msg, Question!, YesNo!) <> 1 then	return 0

// 삭제 PW 확인
PwStr.s_parm[1] = "FTP 파일 삭제"
OpenWithParm(w_ftpfile_pw, PwStr)
PwStr = Message.PowerObjectParm

//삭제 취소
if PwStr.check = FALSE then return 0
ls_inDelPw = PwStr.s_array[1,1]

//삭제 PW 정보 GET
SELECT DEL_PW
  INTO :ls_dbDelPw
  FROM EQUIP_FTPUSER
 WHERE AREA_CODE = :gs_kmarea AND FACTORY_CODE = :gs_kmdivision
 USING sqlcmms;

if sqlcmms.sqlcode <> 0 then
	rs_msg = "[PATH:u_cmms_ftp/uf_del/패스워드체크]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
				+"]~r~n[에러내용:" + sqlcmms.sqlErrText+"]"
	return -1
end if 

//삭제 PW 확인
if Upper(ls_dbDelPw) <> Upper(ls_inDelPw) then
	rs_msg = "삭제 패스워드가 틀립니다."
	return 0
end if

// FTP 서버 저장 파일명
ls_remoteFileNam = uf_getRealRemoteFileNam(as_fileId, as_FileNam)

// 실제 파일 존재 Chk
li_rtn = uf_isRemoteFileExist(ls_remoteFileNam, rs_msg)
if li_rtn = -1 then 
	return li_rtn
elseif li_rtn = 1 then
	// 파일 삭제
	li_rtn = uf_remote_filedel(".\" + ls_remoteFileNam, rs_msg)
	if li_rtn <> 1 then return li_rtn
end if

//DB 파일 정보 삭제
Delete 
  FROM EQUIP_FTPFILE
 WHERE File_id = :as_fileId
 USING sqlcmms;
	
if sqlcmms.sqlcode <> 0 then
	rs_msg = "[PATH:u_cmms_ftp/uf_del/파일정보삭제]~r~n[에러코드:"+String(sqlcmms.sqlcode) &
				+"]~r~n[에러내용:" + sqlcmms.sqlErrText+"]"
	return -1
end if

return 1
end function

on u_cmms_ftp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_cmms_ftp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

