$PBExportHeader$w_chgpwd.srw
$PBExportComments$비밀번호 변경
forward
global type w_chgpwd from window
end type
type dw_1 from datawindow within w_chgpwd
end type
type cb_2 from commandbutton within w_chgpwd
end type
type cb_1 from commandbutton within w_chgpwd
end type
type st_3 from statictext within w_chgpwd
end type
type sle_3 from singlelineedit within w_chgpwd
end type
type sle_2 from singlelineedit within w_chgpwd
end type
type sle_1 from singlelineedit within w_chgpwd
end type
type st_2 from statictext within w_chgpwd
end type
type st_1 from statictext within w_chgpwd
end type
type gb_1 from groupbox within w_chgpwd
end type
end forward

global type w_chgpwd from window
integer x = 937
integer y = 552
integer width = 1513
integer height = 1048
boolean titlebar = true
string title = "비밀번호변경"
windowtype windowtype = response!
long backcolor = 12632256
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
st_3 st_3
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_chgpwd w_chgpwd

forward prototypes
public subroutine wf_server_update (string a_empno, blob a_pwd)
end prototypes

public subroutine wf_server_update (string a_empno, blob a_pwd);Integer		i,ln_count 
String 		ls_area,ls_date

sqlxx 			=	CREATE transaction
ln_count		= 	dw_1.retrieve()

for	i	=	1	to	ln_count
		// remote autodown 관련
		ls_area 					= 	trim(dw_1.object.serverid[i])
		sqlxx.ServerName 		= 	trim(dw_1.object.servername[i])
		sqlxx.DBMS       		= 	trim(dw_1.object.serverdbms[i])
		sqlxx.Database   		= 	trim(dw_1.object.serverdatabase[i])
		sqlxx.LogId      		= 	trim(dw_1.object.serverlogid[i])
		sqlxx.LogPass    		= 	trim(dw_1.object.serverpassword[i])
		if 	trim(dw_1.object.serverautocommit[i]) = "T" then
			sqlxx.autocommit	= 	true
		else
			sqlxx.autocommit	= 	false
		end if
		
		sqlxx.DBParm     		= 	trim(dw_1.object.serverdbparm[i])
	
		connect using sqlxx;
	
		ls_date	=	f_Get_systemdate(sqlxx)
	
		If 	sqlxx.dbms	<>	"ODBC"	THEN
			UPDATEblob	comm121
				SET 	emp_pwd 	= 	:a_pwd 
			 WHERE	emp_no		= 	:a_empno
			USING 	sqlxx;
			
			UPDATE	comm121
				SET 	updt_dt 	= 	:ls_date,	updt_id		=	:a_empno,	ip_addr	=	:g_s_ipaddr,	mac_addr	=	:g_s_macaddr
			 WHERE emp_no  	= 	:a_empno
			USING 	sqlxx;
		Else
			UPDATEblob	pbcommon.comm121
				SET	emp_pwd	=	:a_pwd 
			 WHERE	emp_no 		=	:a_empno
			USING 	sqlxx;
			UPDATE	pbcommon.comm121
				SET 	updt_dt	= 	:ls_date,	updt_id		=	:a_empno,	ip_addr	=	:g_s_ipaddr,	mac_addr	=	:g_s_macaddr
			 WHERE emp_no  	= 	:a_empno
			USING 	sqlxx;
		END IF
		
		if sqlxx.sqlcode	<>	0	then
			messagebox("", ls_area + "  " + sqlxx.sqlerrtext)
		else
			commit using 	sqlxx;
		end if
		disconnect using 	sqlxx ;
next
destroy sqlxx  


end subroutine

on w_chgpwd.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1,&
this.st_3,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_chgpwd.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;st_3.visible 			= 	false
sle_3.visible 			= 	false
if 	g_s_expired 	= 	'Y'	then
	cb_2.visible 		= 	false
	cb_2.enabled 	= 	false
else
	cb_2.visible 		= 	true 
	cb_2.enabled 	= 	true
end if
end event

type dw_1 from datawindow within w_chgpwd
boolean visible = false
integer x = 101
integer y = 680
integer width = 686
integer height = 400
integer taborder = 10
boolean enabled = false
string title = "none"
string dataobject = "d_comm001_retrieve"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type cb_2 from commandbutton within w_chgpwd
boolean visible = false
integer x = 1170
integer y = 796
integer width = 274
integer height = 124
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean enabled = false
string text = "취소"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_chgpwd
integer x = 873
integer y = 796
integer width = 274
integer height = 124
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "확인"
boolean default = true
end type

event clicked;Setpointer(hourglass!)

Blob   lb_emp_pwd

if 	sle_1.text	=	"" 	then
	messagebox("비밀번호 오류", "변경전 비밀번호를 입력하시오.")
	sle_1.text 	=	""
	sle_1.setfocus()
	return
end if
if 	sle_2.text	=	"" 	then
	messagebox("비밀번호 오류", "변경후 비밀번호를 입력하시오.")
	sle_2.text 	=	""
	sle_2.setfocus()
	return
end if
if 	sle_3.text	=	"" 	then
	messagebox("비밀번호 오류", "비밀번호 확인을 입력하시오.")
	sle_3.text	=	""
	sle_3.setfocus()
	return
end if

if 	trim(sle_2.text)	<>	trim(sle_3.text) 	then
	messagebox("비밀번호 오류", "비밀번호 변경후의 암호와 비밀번호 확인의 암호가 일치하지 않습니다.")
	sle_3.text	=	""
	sle_3.setfocus()
	return
end if

lb_emp_pwd	=	blob(Upper(trim(sle_3.text)))
// disconnect using sqlca ;
wf_server_update(g_s_empno,lb_emp_pwd)
// connect using sqlca ;

close(parent)
end event

type st_3 from statictext within w_chgpwd
integer x = 146
integer y = 548
integer width = 608
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "비밀번호   확인"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_chgpwd
integer x = 795
integer y = 556
integer width = 549
integer height = 96
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_chgpwd
integer x = 795
integer y = 376
integer width = 549
integer height = 96
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

event losefocus;Integer	ln_forcnt
String 		ls_emp_pwd

if 	trim(sle_1.text)	=	''	or	trim(sle_2.text)	=	'' 	then
	return
end if
if 	trim(sle_1.text)	<>	trim(sle_2.text)	then
	ls_emp_pwd		=	upper(trim(sle_2.text))
	if 	f_check_password(ls_emp_pwd)	<>	'Y'	then
		messagebox("비밀번호 오류", "비밀번호 체계에 맞지 않는 비밀번호입니다. " )
		sle_2.text	=	""
		sle_3.text 	= 	""
		sle_2.setfocus()
		return
	end if
	st_3.visible  	= 	true
	sle_3.visible 	= 	true
	sle_3.setfocus()
else
	messagebox("비밀번호 오류", "변경전,후 비밀번호가 동일합니다." )
	sle_2.text 		= 	""
	sle_3.text 		= 	""
	sle_2.setfocus()
end if
end event

type sle_1 from singlelineedit within w_chgpwd
integer x = 795
integer y = 196
integer width = 549
integer height = 96
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 16
borderstyle borderstyle = stylelowered!
end type

event losefocus;if	trim(sle_1.text)	=	''	then
	return 
end if

Blob	lb_emppwd

if 	sqlca.dbms <> "ODBC" then
	SELECTblob 	emp_pwd	INTO :lb_emppwd	FROM comm121
	WHERE 		emp_no	=	:g_s_empno
	USING SQLCA;
else
	SELECTblob 	emp_pwd	INTO :lb_emppwd	FROM pbcommon.comm121
	WHERE 		emp_no 	= 	:g_s_empno
	USING SQLCA;
end if
 
if 	lb_emppwd	<>	Blob(Upper(trim(sle_1.text))) then
	messagebox("비밀번호 오류", "변경전 비밀번호 오류 입니다.")
	sle_1.text	=	""
	sle_1.setfocus()
end if

end event

type st_2 from statictext within w_chgpwd
integer x = 146
integer y = 376
integer width = 608
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8388736
long backcolor = 12632256
boolean enabled = false
string text = "변경후 비밀번호"
boolean focusrectangle = false
end type

type st_1 from statictext within w_chgpwd
integer x = 146
integer y = 200
integer width = 608
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 32768
long backcolor = 12632256
boolean enabled = false
string text = "변경전 비밀번호"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_chgpwd
integer x = 87
integer y = 72
integer width = 1353
integer height = 664
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "[Tab Key로 이동]"
end type

