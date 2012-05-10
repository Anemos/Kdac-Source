$PBExportHeader$w_top.srw
$PBExportComments$KDAC 초기화면
forward
global type w_top from window
end type
type dw_1 from datawindow within w_top
end type
type p_2 from picture within w_top
end type
type p_3 from picture within w_top
end type
type p_4 from picture within w_top
end type
type p_1 from picture within w_top
end type
type cb_1 from commandbutton within w_top
end type
type cb_2 from commandbutton within w_top
end type
type em_empno from editmask within w_top
end type
type sle_pwdno from singlelineedit within w_top
end type
end forward

global type w_top from window
string tag = "로그인 화면"
integer x = 750
integer y = 500
integer width = 2149
integer height = 1220
boolean border = false
windowtype windowtype = popup!
boolean center = true
event syscommand pbm_syscommand
dw_1 dw_1
p_2 p_2
p_3 p_3
p_4 p_4
p_1 p_1
cb_1 cb_1
cb_2 cb_2
em_empno em_empno
sle_pwdno sle_pwdno
end type
global w_top w_top

type variables
int i_n_errcnt
end variables

forward prototypes
public subroutine wf_server_update (string a_empno)
public function integer wf_uswin (string ag_empno, string ag_emppwd)
end prototypes

event syscommand;// window title-bar & button 제어
if 	message.wordparm	  	=	61730 then		//double click
	message.processed   		= 	true
	message.returnvalue 		=	1
end if

if 	message.wordparm	  	= 	61458 then		//title click
	message.processed   		= 	true
	message.returnvalue 		= 	1
end if

if 	message.wordparm	  	= 	61536 then		//window close
	message.processed   		= 	true
	message.returnvalue 		= 	1
end if

if 	message.wordparm	  	= 	61587 then		//window control menu
	message.processed   		= 	true
	message.returnvalue 		= 	1
end if

end event

public subroutine wf_server_update (string a_empno);Integer 	i,ln_count
String 	ls_area,ls_date

sqlxx 		=	CREATE transaction
ln_count 	= 	dw_1.retrieve()
for i = 1 to ln_count
	// remote autodown 관련
	ls_area 				= 	trim(dw_1.object.serverid[i])
	sqlxx.ServerName 	= 	trim(dw_1.object.servername[i])
	sqlxx.DBMS       	= 	trim(dw_1.object.serverdbms[i])
	sqlxx.Database  	= 	trim(dw_1.object.serverdatabase[i])
	sqlxx.LogId      	= 	trim(dw_1.object.serverlogid[i])
	sqlxx.LogPass   	= 	trim(dw_1.object.serverpassword[i])
	sqlxx.autocommit 	= 	true
	sqlxx.DBParm     	= 	trim(dw_1.object.serverdbparm[i])

	connect using sqlxx;
   	ls_date	=	f_Get_systemdate(sqlxx)
	if 	sqlxx.dbms <> "ODBC" THEN
		UPDATE comm121
			SET 	usests  		= '*' , updt_dt = :ls_date,		updt_id		=	:a_empno,	ip_addr	=	:g_s_ipaddr,	mac_addr	=	:g_s_macaddr
		 WHERE 	EMP_NO  	= :a_empno
		USING 	SQLXX;
	ELSE
		UPDATE pbcommon.comm121
			SET 	usests  		= '*' , updt_dt = :ls_date,		updt_id		=	:a_empno,	ip_addr	=	:g_s_ipaddr,	mac_addr	=	:g_s_macaddr
		 WHERE 	EMP_NO  	= :a_empno
		USING 	SQLXX;
	END IF
	if 	sqlxx.sqlcode <> 0 then
		messagebox("", ls_area + "  " + sqlxx.sqlerrtext)
	else
		commit using sqlxx;
	end if
	disconnect using sqlxx ;
next
destroy sqlxx
end subroutine

public function integer wf_uswin (string ag_empno, string ag_emppwd);////////////////////////////////////////////////////////////////////////
//	기능 : 개인번호로 비밀번호및 사용가능 Window, 접근 Level을 
//			 Check하는 Function으로
//        개인번호 오류시 -1 Return, 비밀번호 오류시 -2 Return
//			 input : 개인번호(string) + 비밀번호(string)
////////////////////////////////////////////////////////////////////////

string	ls_sts
blob   	lb_emppwd

//개인번호 & 비밀번호 check
g_s_empno	=	ag_empno			//개인번호
if	g_l_connect	=	-1	then
	SELECT 	usests	INTO :ls_sts	from comm121
		WHERE emp_no = :ag_empno
	USING sqlpis;
	
	if sqlpis.sqlcode <> 0 or isnull(ls_sts) = true  then
		return -1
	end if
	if ls_sts = '*' then
		return -2
	end if
	
	SELECTBLOB	EMP_PWD	INTO :lb_emppwd	FROM COMM121
		WHERE 	EMP_NO = :ag_empno
	USING sqlpis;
	if lb_emppwd <> blob(ag_emppwd) or sqlpis.sqlcode <> 0 or isnull(lb_emppwd)  =  true then
		return -3
	end if
else
	SELECT 	usests	INTO :ls_sts	FROM pbcommon.comm121
		WHERE emp_no = :ag_empno
	USING SQLca;
	
	if sqlca.sqlcode <> 0 or isnull(ls_sts) = true  then
		return -1
	end if
	if ls_sts = '*' then
		return -2
	end if
	
	SELECTBLOB EMP_PWD	INTO :lb_emppwd
		FROM PBCOMMON.COMM121
	WHERE EMP_NO = :ag_empno
	USING SQLca;
	if lb_emppwd <> blob(ag_emppwd) or sqlca.sqlcode <> 0 or isnull(lb_emppwd)  =  true then
		return -3
	end if
end if

return 0
end function

on w_top.create
this.dw_1=create dw_1
this.p_2=create p_2
this.p_3=create p_3
this.p_4=create p_4
this.p_1=create p_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.em_empno=create em_empno
this.sle_pwdno=create sle_pwdno
this.Control[]={this.dw_1,&
this.p_2,&
this.p_3,&
this.p_4,&
this.p_1,&
this.cb_1,&
this.cb_2,&
this.em_empno,&
this.sle_pwdno}
end on

on w_top.destroy
destroy(this.dw_1)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.p_4)
destroy(this.p_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.em_empno)
destroy(this.sle_pwdno)
end on

event open;SetPointer(HourGlass!)

i_n_errcnt 			= 	0
em_empno.text  	=	''
sle_pwdno.text		= 	'' 


end event

type dw_1 from datawindow within w_top
boolean visible = false
integer x = 389
integer y = 148
integer width = 686
integer height = 400
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "d_comm001_retrieve"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlpis)
end event

type p_2 from picture within w_top
integer x = 859
integer y = 900
integer width = 270
integer height = 112
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\topcon.jpg"
end type

event clicked;integer    	ln_return, ln_count
String 	ls_check_Date,ls_updt

SetPointer(HourGlass!)

//사용가능 확인
ln_return = wf_uswin(trim(em_empno.text), Upper(trim(sle_pwdno.text)))

if 	ln_return = -1 then
	f_accesslog_create_kdac_pbl(g_s_empno,"F","ID01")
	em_empno.setfocus()
	messagebox("확인", "등록되지 않은 사번입니다.~r~n GWP 서비스 요청서로 사용자 등록을 신청하십시오")
	return
elseif	ln_return = -2 then
	f_accesslog_create_kdac_pbl(g_s_empno,"F","ID02")
	em_empno.setfocus()
	messagebox("확인", "비밀번호 4회 입력 오류로 인해 사용불가 상태입니다.")
	return
elseif	ln_return = -3 then
	f_accesslog_create_kdac_pbl(g_s_empno,"F","PW01")
	sle_pwdno.setfocus()
	messagebox("확인", "비밀번호 입력 오류입니다.")
	sle_pwdno.text = ""
	i_n_errcnt ++ 
	if 	i_n_errcnt >= 4 then
		wf_server_update(g_s_empno)
		i_n_errcnt = 0
	end if
	return
end if
//if g_s_empno <> 'ADMIN' then
	ls_check_date 		=	f_get_systemdate(sqlca)
	ls_check_date		=	mid(ls_check_date,1,4) + mid(ls_check_date,6,2) 
	
	SELECT	updt_dt	INTO	:ls_updt	FROM pbcommon.comm121
	WHERE 	emp_no = :g_s_empno
	USING 	SqlCa	;
	if 	(mid(ls_updt,1,4) + mid(ls_updt,6,2)) <> ls_check_date & 
		or upper(trim(sle_pwdno.text)) = 'D' + g_s_empno + '0'  then
		g_s_expired = 'Y'
		open(w_chgpwd)
	else
		g_s_expired = 'N'
	end if
//end if

g_s_company = '01'

SELECT	autarea,			autplnt,			autdiv,			autext1,			out_emp_name	,emp_level 
	INTO	:g_s_autarea,	:g_s_autplnt,	:g_s_autdiv,		:g_s_autext1,	:g_s_kornm		,:gs_userlevel
FROM 	pbcommon.comm121
WHERE 	emp_no	=	:g_s_empno
USING 	SqlCa ;

g_s_wkcd		=	"1"					//회계전표처리 지역( 대구-1, 서울-2 )

if 	len(g_s_empno) = 6	and	isnumber(g_s_empno) = true then
	SELECT 	penamek,	pedept	INTO	:g_s_kornm,	:g_s_deptcd		FROM pbcommon.dac003
	WHERE 	PEEMPNO	=	:g_s_empno 
	USING 	SqlCa ;
	if 	g_s_deptcd >= '3900' and g_s_deptcd <= '3999' then  //자금팀//
		g_s_wkcd = '2' 
	else
		g_s_wkcd = '1'
	end if
end if
f_accesslog_create_kdac_pbl(g_s_empno,"I","")
Open(w_frame)
Opensheet(w_menu, w_frame, 0, Layered!)
close(parent)


end event

type p_3 from picture within w_top
integer x = 1111
integer y = 900
integer width = 270
integer height = 112
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\topeoj.jpg"
end type

event clicked;disconnect using	SQLCA;
close(parent) 

end event

type p_4 from picture within w_top
integer x = 1358
integer y = 900
integer width = 270
integer height = 112
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\topkey.jpg"
end type

event clicked;Blob	lb_emppwd

g_s_empno	=	trim(em_empno.text)
//if g_s_empno = 'ADMIN' then
//	messagebox("오류", "ADMIN 의 비밀번호 변경은 시스템 관리자만 가능" )
//	return
//end if
SELECTblob	EMP_PWD	INTO	:lb_emppwd		FROM	PBCOMMON.COMM121
WHERE     	EMP_NO 	= 		:g_s_empno 	
Using 		SqlCa	;

if	sqlca.sqlcode <> 0 or isnull(lb_emppwd) then
	messagebox("오류", "등록되지 않은 사번 입니다.~r~n시스템 개발팀에 등록 요청 하십시오" )
	return
end if

sle_pwdno.text = ''
sle_pwdno.setfocus()

open(w_chgpwd)

end event

type p_1 from picture within w_top
integer width = 2149
integer height = 1220
boolean originalsize = true
string picturename = "C:\KDAC\bmp\initmenu.jpg"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_top
integer x = 1614
integer y = 1132
integer width = 247
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
boolean default = true
end type

event clicked;p_2.PostEvent(Clicked!)
end event

type cb_2 from commandbutton within w_top
integer x = 1851
integer y = 1132
integer width = 247
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
boolean cancel = true
end type

event clicked;p_3.PostEvent(Clicked!)
end event

type em_empno from editmask within w_top
integer x = 1157
integer y = 664
integer width = 439
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!"
boolean autoskip = true
end type

type sle_pwdno from singlelineedit within w_top
integer x = 1157
integer y = 796
integer width = 439
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

