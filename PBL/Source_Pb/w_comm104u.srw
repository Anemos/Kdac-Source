$PBExportHeader$w_comm104u.srw
$PBExportComments$개인별 사용가능 Window
forward
global type w_comm104u from w_origin_sheet01
end type
type cb_1 from commandbutton within w_comm104u
end type
type gb_2 from groupbox within w_comm104u
end type
type gb_1 from groupbox within w_comm104u
end type
type dw_menu from datawindow within w_comm104u
end type
type rb_1 from radiobutton within w_comm104u
end type
type rb_2 from radiobutton within w_comm104u
end type
type dw_3 from datawindow within w_comm104u
end type
type sle_2 from singlelineedit within w_comm104u
end type
type sle_1 from singlelineedit within w_comm104u
end type
type dw_1 from datawindow within w_comm104u
end type
type dw_2 from datawindow within w_comm104u
end type
type cb_2 from commandbutton within w_comm104u
end type
type dw_4 from datawindow within w_comm104u
end type
type ddlb_gubun from dropdownlistbox within w_comm104u
end type
type dw_5 from datawindow within w_comm104u
end type
type dw_wait from datawindow within w_comm104u
end type
type ddlb_input from dropdownlistbox within w_comm104u
end type
type sle_docno from singlelineedit within w_comm104u
end type
type gb_input from groupbox within w_comm104u
end type
end forward

global type w_comm104u from w_origin_sheet01
integer height = 2716
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
dw_menu dw_menu
rb_1 rb_1
rb_2 rb_2
dw_3 dw_3
sle_2 sle_2
sle_1 sle_1
dw_1 dw_1
dw_2 dw_2
cb_2 cb_2
dw_4 dw_4
ddlb_gubun ddlb_gubun
dw_5 dw_5
dw_wait dw_wait
ddlb_input ddlb_input
sle_docno sle_docno
gb_input gb_input
end type
global w_comm104u w_comm104u

type variables
Boolean				ib_down
String  				is_selected,	is_emp_no
String  				is_menu_cd,	is_sql_select,is_getfocus	=	'0'
DataWindowChild 	child_menu
end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color)
public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun, string a_inputdetail)
end prototypes

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color);string ls_command
long 	 ll_color = 16777215	//white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
dw_2.setredraw(False)
if ag_n_color 	= 	1	then
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(255,255,0), 15780518)'"
else
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(255,255,255))'"
end if

dw_2.Modify(ls_command)

dw_2.setredraw(True)
end subroutine

public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun, string a_inputdetail);String		ls_empno,ls_usewin,ls_usegrd,ls_chgdate

ls_usewin	= 	a_dw.getitemstring(a_row, "use_win")
ls_usegrd	= 	a_dw.getitemstring(a_row, "use_grd")
ls_empno   	=	a_dw.getitemstring(a_row, "emp_no")

SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
FETCH FIRST 1 ROWS ONLY
Using SqlCA ; 

insert	into	pbcommon.comm140his	values
(	:ls_empno,	:ls_usewin,	:ls_chgdate,	''	,
	:a_gubun,	:ls_usegrd,	:g_s_empno,		:g_s_ipaddr,:g_s_macaddr,:a_inputdetail	)
Using	SqlCA;


end subroutine

on w_comm104u.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_menu=create dw_menu
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_3=create dw_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_4=create dw_4
this.ddlb_gubun=create ddlb_gubun
this.dw_5=create dw_5
this.dw_wait=create dw_wait
this.ddlb_input=create ddlb_input
this.sle_docno=create sle_docno
this.gb_input=create gb_input
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_menu
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.sle_2
this.Control[iCurrent+9]=this.sle_1
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.dw_2
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.dw_4
this.Control[iCurrent+14]=this.ddlb_gubun
this.Control[iCurrent+15]=this.dw_5
this.Control[iCurrent+16]=this.dw_wait
this.Control[iCurrent+17]=this.ddlb_input
this.Control[iCurrent+18]=this.sle_docno
this.Control[iCurrent+19]=this.gb_input
end on

on w_comm104u.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_menu)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_4)
destroy(this.ddlb_gubun)
destroy(this.dw_5)
destroy(this.dw_wait)
destroy(this.ddlb_input)
destroy(this.sle_docno)
destroy(this.gb_input)
end on

event open;call super::open;Setpointer(hourglass!)

DataWindowChild child_wkcd

ddlb_gubun.selectitem(1)
dw_1.settransobject(Sqlca)
is_sql_select = dw_1.getsqlselect()
//업무조회
dw_menu.GetChild("win_nm", child_menu)
child_menu.settransobject(sqlca)
child_menu.retrieve()
dw_menu.insertrow(0)
cb_1.PostEvent(Clicked!)

//Icon 제어(조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자)
i_b_insert	=	false
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)
timer(0)				  
timer(30)
end event

event ue_retrieve;call super::ue_retrieve;String	ls_kor_nm,ls_new_Sql

if 	dw_1.dataobject = 'd_comm104u_01' then
	if 	rb_1.checked	= 	True then
		is_emp_no 		= trim(sle_1.text)
		sle_2.text		= ''
		ls_new_sql 		=	is_sql_select +  " and emp_no >= '" + is_emp_no + "'" + " order by emp_no "
	elseif rb_2.checked = True then	
		ls_kor_nm 		= trim(sle_2.text)
		sle_1.text		= ''	
		ls_new_sql 		=	is_sql_select +  " and penamek >= '" + ls_kor_nm + "'" + " order by penamek "
	end if
elseif dw_1.dataobject = 'd_comm104u_04' then	
	if 	rb_1.checked	= 	True then
		is_emp_no 		= trim(sle_1.text)
		sle_2.text		= ''
		ls_new_sql 		=	is_sql_select +  " and PBCOMMON.COMM140.EMP_NO >= '" + is_emp_no + "'" + " order by PBCOMMON.COMM140.EMP_NO "
	elseif rb_2.checked = True then	
		ls_kor_nm 		= trim(sle_2.text)
		sle_1.text		= ''	
		ls_new_sql 		= is_sql_select +  " and out_emp_name >= '" + ls_kor_nm + "'" + " order by out_emp_name "
	end if
end if

//if rb_1.checked = True then
//	is_emp_no 	= 	trim(sle_1.text)
//	sle_2.text	=	''
//	ls_new_Sql 	= 	is_sql_select +  " and   emp_no >= '" + is_emp_no + "'" + " order by  emp_no"
//elseif rb_2.checked = True then	
//	ls_kor_nm  	= 	trim(sle_2.text)
//	sle_1.text 	= 	''
//	ls_new_sql 	=	is_sql_select +  " and  PENAMEK >= '" + ls_kor_nm + "'" + " order by  PENAMEK "
//end if

f_pism_working_msg(This.title,"사용자 정보를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_1.reset()
dw_1.setsqlselect(ls_new_sql)
dw_1.retrieve()
dw_1.setsqlselect(is_sql_select)

If	IsValid(w_pism_working) Then Close(w_pism_working)
if 	dw_1.rowcount()	= 0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
else
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
end if 

cb_2.enabled 	= 	false
i_b_insert		=	True
i_b_save			=	false
i_b_delete		=	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)

end event

event ue_insert;call super::ue_insert;Long	 	ln_row,	 	ln_rowcount,	ln_findrow
String		ls_kor_nm, ls_dept_nm,  	ls_wkpo_nm,	ls_wk_nm

if 	f_spacechk(is_emp_no) 	= -1 then
  	uo_status.st_message.text	=  f_message("I060")		// 조회한 후에 입력바랍니다.
	return
end if

if 	is_emp_no <> sle_1.text then
  	uo_status.st_message.text	=  f_message("I070")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if

Setpointer(hourglass!)

ln_rowcount	= 	dw_1.rowcount()
for	ln_row	=	1	to	ln_rowcount
		ln_findrow	=	dw_1.find("comm140_emp_no = '" + is_emp_no + "'", 1, dw_1.rowcount() )
		if	ln_findrow > 0 then
			messagebox("확 인", "이미 개인번호의 자료가 존재 합니다.")
			return
		end if
next
ln_rowcount		=	0

SELECT	count(*)	INTO	:ln_rowcount	FROM PBCOMMON.COMM121
WHERE 	EMP_NO		=	:is_emp_no
Using 		SqlCA	;
if	ln_rowcount		<	1	then
	messagebox("확 인", "사용자 ID가 등록되지 않았습니다.사용자 ID 등록 후 사용권한 등록하시기 바랍니다 ")
	return
end if

If	ddlb_gubun.text	=	'KDAC직원'	then
	SELECT	PENAMEK				INTO	:ls_kor_nm	FROM PBCOMMON.DAC003
	WHERE 	PEEMPNO	=	:is_emp_no
	Using 		SqlCA	;
else
	SELECT	OUT_EMP_NAME	INTO	:ls_kor_nm	FROM PBCOMMON.COMM121
	WHERE 	EMP_NO		=	:is_emp_no
	Using 		SqlCA	;
end if

ln_row	=	dw_1.insertrow(0)
dw_1.ScrollToRow(ln_row)

dw_1.object.comm140_emp_no[ln_row]	=	is_emp_no
dw_1.object.emp_name[ln_row]				=	ls_kor_nm
is_selected	=	"i"
//Icon 제어(조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자)
i_b_insert	=	True
i_b_save		=	false
i_b_delete	=	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)


end event

event ue_delete;call super::ue_delete;Integer 	ln_row,	ln_yesno,	ln_rowcount,	ls_empno,	ls_usewin
String  	ls_menucd,	ls_menucd4,		ls_inputdetail

Setpointer(HourGlass!)

dw_2.accepttext()
ln_row        	=	dw_2.GetRow()
ln_rowcount 	= 	dw_2.rowcount()

If	ln_row	<	1	THEN 
	uo_status.st_message.text	=  f_message("D100")		// 삭제할 자료를 확인한 후 처리바랍니다.
	Return
END IF

ln_yesno		=	Messagebox("삭제 확인", "선택된 (" + string(ln_row) + "번째 행)을 삭제 하시겠습니까?", Question!, YesNo!)
if 	ln_yesno	<>	1  then
	Return
end if

if	f_spacechk(sle_docno.text) = -1 or is_getfocus	=	'0' then
	if	ddlb_input.text	=	'서비스 요청서'	or	ddlb_input.text	=	'업무 연락'	then
		messagebox("확인","GWP 상의 문서번호를 반드시 입력하세요")
		uo_status.st_message.text = "GWP 상의 문서번호를 반드시 입력하세요"
		return
	elseif	ddlb_input.text	=	'긴급 요청'	then
		messagebox("확인","신청부서와 신청자명을 입력하세요")
		uo_status.st_message.text = "신청부서와 신청자명을 입력하세요"
		return
	end if
end if
ls_inputdetail	=	'[' + trim(ddlb_input.text) + ']-[' + trim(sle_docno.text) + ']'

dw_2.SetTransObject(sqlca)
if 	dw_2.GetItemStatus(ln_row, 0, Primary!)	<>	NewModified!	then
	wf_server_update(dw_2,ln_row,'D',ls_inputdetail)
end if
dw_2.deleteRow(ln_row)	
dw_wait.retrieve('',g_s_empno)

ln_rowcount 		= 	dw_2.rowcount()
if 	ln_rowcount		<	1	then
	i_b_save			=	False
	i_b_delete		=	False
end if

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)

end event

event ue_save;call super::ue_save;Integer 	ln_row, 		ln_rowcount, ln_findrow,	ln_number, 	&
		  	ln_orglen,	ln_newlen,   ln_selrow, 	ln_i
String  	ls_error,   	ls_column,   ls_message,	ls_winidkey,	ls_inputdetail
String		ls_use_win,	ls_use_grd,  ls_emp_no, 	ls_new_win

Setpointer(Hourglass!)

dw_2.accepttext()
if 	dw_2.ModifiedCount() = 0 then
	dw_2.setfocus()
   	uo_status.st_message.text	=  f_message("E020")		// 변경내용이 없습니다.
   	return
end if

ln_rowcount		=	dw_2.rowcount()
for		ln_row	= 	1 	to	ln_rowcount
		ls_error		=	""
		ls_use_win	= 	dw_2.getitemstring(ln_row, "use_win")
		ls_use_grd	= 	dw_2.getitemstring(ln_row, "use_grd")
		ls_emp_no  	=  dw_2.getitemstring(ln_row, "emp_no")
		ln_orglen	=	len(f_spacedel(ls_use_win))
		//사용가능Window Check
		if 	f_spacechk(ls_use_win) = -1 then
			ls_error 	=	"1"
		else
			ls_error 	=	"0"
		end if
		//사용등급 Check
		if 	f_spacechk(ls_use_grd) = -1 then
			ls_error 	=	ls_error + "1"
		else
			ls_error 	=	ls_error + "0"
		end if
		if 	dw_2.GetItemStatus (ln_row, "use_win", primary!) <> NotModified! or &
			dw_2.GetItemStatus (ln_row, "use_grd", primary!) <> NotModified! then
			for		ln_i = len(trim(ls_use_win)) -1 to 2 step -1
					ls_winidkey = mid(ls_use_win, 1, ln_i)
					if	dw_2.find(	"emp_no = '" + ls_emp_no +  "'" + " and use_win = '" + ls_winidkey + "'" + & 
										" and use_Grd = '5'",1,dw_2.rowcount()) > 0	Then
						ls_error = '11'
						exit
					end if
			next
		end if
		dw_2.object.cp_chk[ln_row] = ls_error
next

wf_rgbset("use_win", 1, 1) //ag_n_color [1->Cream(255,250,239), 2->White(255,255,255)]
wf_rgbset("use_grd", 2, 2) //ag_n_color [1->Cream(255,250,239), 2->White(255,255,255)]

dw_2.SetRedraw(False)
ls_column	=	""
ls_error   =  ""
for 	ln_row = 1 to ln_rowcount
		ls_error		=	dw_2.getitemstring(ln_row, "cp_chk")
		ls_use_win 	= 	dw_2.getitemstring(ln_row, "use_win")
		if 	f_spacechk(ls_error) =	0 then
			ln_findrow = dw_2.find("use_win = '" + ls_use_win + "'", 1, dw_2.rowcount() )
			if 	ln_findrow > 0 then
				dw_2.scrolltorow(ln_findrow)
			end if
			if 	mid(ls_error, 1, 1) = "1" then
				if 	f_spacechk(ls_column) = -1 then
					ls_column  =	"use_win"
					exit
				end if
			elseif mid(ls_error, 2, 1) = "1" then
				if 	f_spacechk(ls_column) = -1 then
					ls_column  =	"use_grd"
					exit
				end if
			end if
		end if
next
dw_2.SetRedraw(True)
if 	len(ls_column) > 0  then											// Editing Error
	dw_2.setrow(ln_row)
	dw_2.setcolumn(ls_column)
	dw_2.setfocus()
	uo_status.st_message.text	=  f_message("E010")		// 노란색 항목을 수정 후 처리바랍니다.	
	return
end if

if	f_spacechk(sle_docno.text) = -1 or is_getfocus	=	'0' then
	if	ddlb_input.text	=	'서비스 요청서'	or	ddlb_input.text	=	'업무 연락'	then
		messagebox("확인","GWP 상의 문서번호를 반드시 입력하세요")
		uo_status.st_message.text = "GWP 상의 문서번호를 반드시 입력하세요"
		return
	elseif	ddlb_input.text	=	'긴급 요청'	then
		messagebox("확인","신청부서와 신청자명을 입력하세요")
		uo_status.st_message.text = "신청부서와 신청자명을 입력하세요"
		return
	end if
end if
ls_inputdetail	=	'[' + trim(ddlb_input.text) + ']-[' + trim(sle_docno.text) + ']'


ln_selrow  	= 	dw_1.getselectedrow(0)
ls_emp_no	= 	dw_1.getitemstring(ln_selrow, "comm140_emp_no")			// 개인번호

f_sysdate()

dw_2.settransobject(sqlca)
ln_rowcount = dw_2.rowcount()

for	ln_row = 1 to ln_rowcount
		dw_2.setitemstatus(ln_row, "cp_chk", primary!, NotModified!)
		if 	dw_2.GetItemStatus (ln_row, 0, primary!) = NewModified! then
			dw_2.object.inpt_id[ln_row] 	= 	g_s_empno
			dw_2.object.inpt_dt[ln_row] 	= 	g_s_datetime
			dw_2.object.ip_addr[ln_row] 	= 	g_s_ipaddr
			dw_2.object.mac_addr[ln_row]	= 	g_s_macaddr
			wf_server_update(dw_2,ln_row,'A',ls_inputdetail)
		end if	
	
		if 	dw_2.GetItemStatus(ln_row, 0, primary!) = DataModified! then
			dw_2.object.updt_id[ln_row]	= 	g_s_empno
			dw_2.object.updt_dt[ln_row] 	= 	g_s_datetime
			dw_2.object.ip_addr[ln_row] 	= 	g_s_ipaddr
			dw_2.object.mac_addr[ln_row]	= 	g_s_macaddr
			wf_server_update(dw_2,ln_row,'R',ls_inputdetail)
		end if
next
dw_wait.retrieve('',g_s_empno)
i_b_insert	=	True
i_b_save		=	true
i_b_delete	=	true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)
							  
							  

end event

event timer;call super::timer;//승인대기 List 조회
SetPointer(HourGlass!)
f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
dw_wait.retrieve('',g_s_empno)
SetPointer(Arrow!)
end event

event activate;call super::activate;f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
dw_wait.retrieve('',g_s_empno)
end event

type uo_status from w_origin_sheet01`uo_status within w_comm104u
end type

type cb_1 from commandbutton within w_comm104u
integer x = 3968
integer y = 268
integer width = 448
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "프로그램조회"
end type

event clicked;Setpointer(hourglass!)

dw_3.settransobject(sqlca)
dw_3.retrieve(is_menu_cd)


end event

type gb_2 from groupbox within w_comm104u
integer x = 9
integer width = 4434
integer height = 172
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_comm104u
integer x = 3173
integer y = 200
integer width = 768
integer height = 204
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8388608
long backcolor = 12632256
string text = "[업무조회]"
end type

type dw_menu from datawindow within w_comm104u
integer x = 3214
integer y = 272
integer width = 681
integer height = 96
integer taborder = 90
boolean bringtotop = true
string dataobject = "dddw_comm110_c01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;is_menu_cd	=	left(child_menu.getitemstring(child_menu.getrow(), "menu_cd"), 2)
end event

type rb_1 from radiobutton within w_comm104u
integer x = 745
integer y = 64
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "사용자번호"
boolean checked = true
end type

event clicked;sle_1.setfocus()
end event

type rb_2 from radiobutton within w_comm104u
integer x = 1696
integer y = 64
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "이름"
end type

event clicked;sle_2.setfocus()
end event

type dw_3 from datawindow within w_comm104u
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 2912
integer y = 428
integer width = 1545
integer height = 1224
integer taborder = 110
string dragicon = "Information!"
boolean bringtotop = true
string dataobject = "d_comm104u_03"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "None!"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttondown;ib_down = true
end event

event ue_lbuttonup;ib_down = false
end event

event ue_mousemove;if ib_down then
	this.Drag (begin!)
end if

end event

event clicked;if 	row	<	1	then
	return
end if

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type sle_2 from singlelineedit within w_comm104u
event ue_keydown pbm_keydown
integer x = 1970
integer y = 56
integer width = 361
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 16777215
boolean autohscroll = false
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = KeyEnter! then	parent.TriggerEvent("ue_retrieve")
end event

event getfocus;rb_2.checked = true
this.SelectText(1, Len(this.Text))
end event

type sle_1 from singlelineedit within w_comm104u
event ue_keydown pbm_keydown
integer x = 1243
integer y = 56
integer width = 370
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = KeyEnter! then	parent.TriggerEvent("ue_retrieve")
end event

event getfocus;rb_1.checked = true
this.SelectText(1, Len(this.Text))
end event

type dw_1 from datawindow within w_comm104u
integer x = 9
integer y = 204
integer width = 1573
integer height = 1456
integer taborder = 30
string dataobject = "d_comm104u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;int 		Net,ln_count
string 	ls_emp_no

if row < 1 then
	return
end if

dw_2.settransobject(sqlca)
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

ls_emp_no = this.getitemstring(row, "comm140_emp_no")

ln_count = dw_2.retrieve(ls_emp_no)
if ln_count > 0 then
	cb_2.enabled = true
else
	cb_2.enabled = false
end if
is_selected =	"r"

//Icon제어( 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자)
i_b_save		=	True
i_b_delete	=	True
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)

end event

event losefocus;//cb_2.enabled = false
end event

event retrieveend;if	ddlb_gubun.text	=	'KDAC직원'	and	(trim(sle_1.text)	=	'ADMIN'	or	trim(sle_1.text)	=	''	)	then
	Integer	ln_row
	ln_row	=	dw_1.insertrow(1)
	dw_1.object.comm140_emp_no[ln_row]		=	'ADMIN'
	dw_1.object.emp_name[ln_row]					=	'관리자'	
	dw_1.object.dac001_dname[ln_row]			=	'시스템개발팀'	
	ln_row	=	dw_1.insertrow(ln_row)
	dw_1.object.comm140_emp_no[ln_row]		=	'SYSMGR'
	dw_1.object.emp_name[ln_row]					=	'관리자'	
	dw_1.object.dac001_dname[ln_row]			=	'시스템개발팀'	
end if
end event

type dw_2 from datawindow within w_comm104u
integer x = 1600
integer y = 200
integer width = 1298
integer height = 1456
integer taborder = 60
string dataobject = "d_comm104u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//if row < 1 then
//	return
//end if
//
//this.SelectRow(0, FALSE)
//this.SelectRow(row, TRUE)
//This.SetRow(row)
end event

event dragdrop;long 	 	ln_insrow, ln_sel1row, ln_sel3row
string		ls_emp_no, ls_win_id

ln_sel1row = dw_1.getselectedrow(0)
ln_sel3row = dw_3.getselectedrow(0)

//자료이동
ls_emp_no	= 	dw_1.getitemstring(ln_sel1row, "comm140_emp_no")		// 개인번호
ls_win_id  	= 	dw_3.getitemstring(ln_sel3row, "win_id")		// Window Id
if 	f_spacechk(ls_emp_no) = -1 then
	messagebox("확 인", "개인번호를 확인하거나 해당 Row를 Click후 작업 하세요")
	return
end if

ln_insrow		=	this.insertrow(0)
this.object.emp_no[ln_insrow]	=	ls_emp_no
this.object.use_win[ln_insrow] 	= 	ls_win_id

//Icon 제어(조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자)
i_b_insert	=	true
i_b_save		=	true
i_b_delete	=	true
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)
end event

event constructor;//this.SetRowFocusIndicator(FocusRect!)
end event

type cb_2 from commandbutton within w_comm104u
integer x = 3895
integer y = 44
integer width = 507
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean enabled = false
string text = "사용권한 Copy"
end type

event clicked;Long	ln_count,i

if 	dw_2.rowcount() < 1 then
	messagebox("확인","기존 사용자의 사용권한을 조회 한 후에 Copy 가능합니다")
	return
end if
dw_5.visible 	=	true
dw_5.enabled 	= 	true
dw_5.insertrow(0)
dw_5.setfocus()
dw_5.setcolumn("to_empno")
dw_5.object.from_empno[1] 	= 	dw_2.object.emp_no[1]
dw_5.object.to_empno[1] 		= 	''

end event

type dw_4 from datawindow within w_comm104u
boolean visible = false
integer x = 946
integer y = 1492
integer width = 686
integer height = 400
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_comm001_retrieve"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlpis)
end event

type ddlb_gubun from dropdownlistbox within w_comm104u
integer x = 41
integer y = 52
integer width = 617
integer height = 320
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean sorted = false
string item[] = {"KDAC직원","외주업체직원"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;sle_1.text = ''
sle_2.text = ''
if index = 1 then
	dw_1.dataobject = 'd_comm104u_01'
	dw_1.settransobject(Sqlca)
else
	dw_1.dataobject = 'd_comm104u_04'
	dw_1.settransobject(Sqlca)
end if
is_sql_select = dw_1.getsqlselect()

end event

type dw_5 from datawindow within w_comm104u
boolean visible = false
integer x = 1472
integer y = 212
integer width = 2903
integer height = 412
integer taborder = 100
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "사용권한 Copy"
string dataobject = "d_comm104u_copy"
boolean controlmenu = true
string icon = "C:\KDAC\kdac.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.visible = false
this.enabled = false
end event

event buttonclicked;if 	dwo.name <> 'b_delete_copy' and  dwo.name <> 'b_update_add' then
	return
end if

Setpointer(hourglass!)

String 	ls_toempno,ls_fromempno,ls_area,ls_display,ls_chgdate,ls_inputdetail
Long		ln_count = 0, i

this.accepttext()
ls_fromempno 		= 	trim(this.object.from_empno[row])
ls_toempno 		= 	trim(this.object.to_empno[row])
select count(*) into :ln_count from pbcommon.comm121
	where emp_no = :ls_toempno using sqlca ;
if 	isnull(ln_count) or ln_count = 0 then
	messagebox("확인","사용자등록이 되어있지 않습니다")
	return
end if

if	f_spacechk(sle_docno.text) = -1 or is_getfocus	=	'0' then
	if	ddlb_input.text	=	'서비스 요청서'	or	ddlb_input.text	=	'업무 연락'	then
		messagebox("확인","GWP 상의 문서번호를 반드시 입력하세요")
		uo_status.st_message.text = "GWP 상의 문서번호를 반드시 입력하세요"
		return
	elseif	ddlb_input.text	=	'긴급 요청'	then
		messagebox("확인","신청부서와 신청자명을 입력하세요")
		uo_status.st_message.text = "신청부서와 신청자명을 입력하세요"
		return
	end if
end if
ls_inputdetail	=	'[' + trim(ddlb_input.text) + ']-[' + trim(sle_docno.text) + ']'


SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
FETCH	FIRST 1 ROWS ONLY
Using 	SqlCA ;

if	dwo.name = 'b_delete_copy'	then
	insert 	into pbcommon.comm140his 	
	select 	cast(:ls_toempno as char(6)),use_win,:ls_chgdate,'','D',use_grd,:g_s_empno,
				cast(:g_s_ipaddr as char(30)),cast(:g_s_macaddr as char(30)),:ls_inputdetail from pbcommon.comm140 
	where 	emp_no = :ls_toempno 
	using 	sqlca ;
	
	SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
	FETCH	FIRST 1 ROWS ONLY
	Using 	SqlCA ;
	
	insert 	into pbcommon.comm140his 	
	select 	cast(:ls_toempno as char(6)),use_win,:ls_chgdate,'','A',use_grd,:g_s_empno,
					cast(:g_s_ipaddr as char(30)),cast(:g_s_macaddr as char(30)),:ls_inputdetail from pbcommon.comm140 
	where 	emp_no = :ls_fromempno
	using 	sqlca ;
elseif	dwo.name = 'b_update_add'	then
	insert 	into pbcommon.comm140his 	
	select 	cast(:ls_toempno as char(6)),use_win,:ls_chgdate,'','A',use_grd,:g_s_empno,
				cast(:g_s_ipaddr as char(30)),cast(:g_s_macaddr as char(30)),:ls_inputdetail from pbcommon.comm140 
	where 	emp_no = :ls_fromempno	and 	use_win not in ( select use_win from pbcommon.comm140 where emp_no = :ls_toempno )
	using 	sqlca ;
end if
	
uo_status.st_message.text = "Copy 완료 " 
dw_wait.retrieve('',g_s_empno)

this.visible 		=	false
this.enabled 	= 	false

end event

type dw_wait from datawindow within w_comm104u
integer x = 18
integer y = 1672
integer width = 2875
integer height = 784
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "승인대기 사용권한 List - 자동 조회 (30초마다)"
string dataobject = "d_comm140his_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type ddlb_input from dropdownlistbox within w_comm104u
integer x = 3291
integer y = 1920
integer width = 882
integer height = 344
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
string item[] = {"서비스 요청서","업무 연락","긴급 요청"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text	=	'서비스 요청서'
end event

event selectionchanged;if	index	=	1	then
	sle_docno.text			=	'서비스요청서 번호를 입력하세요'
elseif	index	=	2	then
	sle_docno.text			=	'업무연락 번호를 입력하세요'
elseif	index	=	3	then
	sle_docno.text			=	'신청부서와 신청자를 입력하세요'
end if
sle_docno.textcolor	=	rgb(255,0,0)
sle_docno.backcolor	=	15780518
sle_docno.enabled		=	true
is_getfocus				=	'0'
end event

type sle_docno from singlelineedit within w_comm104u
integer x = 3291
integer y = 2064
integer width = 882
integer height = 108
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 255
long backcolor = 15780518
string text = "서비스요청서 번호를 입력하세요"
borderstyle borderstyle = stylelowered!
end type

event getfocus;sle_docno.text			=	''
sle_docno.textcolor	=	rgb(255,0,0)
is_getfocus	=	'1'
end event

type gb_input from groupbox within w_comm104u
integer x = 3223
integer y = 1824
integer width = 1024
integer height = 440
integer taborder = 120
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 128
long backcolor = 12632256
string text = "사용권한 변경 사유"
borderstyle borderstyle = styleraised!
end type

