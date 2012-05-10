$PBExportHeader$w_comm102u.srw
$PBExportComments$사용자 등록
forward
global type w_comm102u from w_origin_sheet01
end type
type dw_1 from datawindow within w_comm102u
end type
type rb_1 from radiobutton within w_comm102u
end type
type rb_2 from radiobutton within w_comm102u
end type
type sle_1 from singlelineedit within w_comm102u
end type
type sle_2 from singlelineedit within w_comm102u
end type
type gb_1 from groupbox within w_comm102u
end type
type dw_2 from datawindow within w_comm102u
end type
type cb_1 from commandbutton within w_comm102u
end type
type ddlb_gubun from dropdownlistbox within w_comm102u
end type
type dw_wait from datawindow within w_comm102u
end type
type ddlb_input from dropdownlistbox within w_comm102u
end type
type sle_docno from singlelineedit within w_comm102u
end type
type gb_input from groupbox within w_comm102u
end type
end forward

global type w_comm102u from w_origin_sheet01
integer height = 2724
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
sle_1 sle_1
sle_2 sle_2
gb_1 gb_1
dw_2 dw_2
cb_1 cb_1
ddlb_gubun ddlb_gubun
dw_wait dw_wait
ddlb_input ddlb_input
sle_docno sle_docno
gb_input gb_input
end type
global w_comm102u w_comm102u

type variables
string		is_selected,is_sql_select,is_getfocus	=	'0' 
datawindowchild i_dwc_1
end variables

forward prototypes
public subroutine wf_rgbclear ()
public function string wf_out_empno (string a_out_vendor)
public subroutine wf_server_update (string a_empno, string a_autarea, string a_autplnt, string a_autdiv, string a_autext1, string a_autext2, string a_out_emp_name, string a_out_vendor, string a_gubun, string a_emp_level, string a_inputdetail)
end prototypes

public subroutine wf_rgbclear ();if dw_2.dataobject 		= 'd_comm102u_021' then
	dw_2.object.emp_no.background.color	= rgb(255,250,239)				
elseif dw_2.dataobject 	= 'd_comm102u_022' then
	dw_2.object.out_emp_name.background.color    = rgb(255,250,239)				
	dw_2.object.out_vendor.background.color      = rgb(255,250,239)
end if
dw_2.object.autarea.background.color   			= rgb(255,255,255)
dw_2.object.autplnt.background.color   			= rgb(255,255,255)
dw_2.object.autdiv.background.color   				= rgb(255,255,255)
dw_2.object.autext1.background.color  				= rgb(255,255,255)
dw_2.object.autext2.background.color  				= rgb(255,255,255)
end subroutine

public function string wf_out_empno (string a_out_vendor);String	ls_emp_no

select substring(max(emp_no),4,3) into :ls_emp_no from Comm121
where	out_vendor = :a_out_vendor
using sqlca ;
if 	f_spacechk(ls_emp_no) = -1 then
	return a_out_vendor + '001'
else
	return a_out_vendor + string(integer(ls_emp_no) + 1,'000')
end if


end function

public subroutine wf_server_update (string a_empno, string a_autarea, string a_autplnt, string a_autdiv, string a_autext1, string a_autext2, string a_out_emp_name, string a_out_vendor, string a_gubun, string a_emp_level, string a_inputdetail);string  	ls_area,ls_display,ls_chgdate
blob		ls_empno

ls_empno 	= 	blob('D' + a_empno + '0' )
a_gubun   	=	upper(a_gubun)

SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
FETCH FIRST 1 ROWS ONLY
Using SQLCA ;

insert into pbcommon.comm121his
(	emp_no,input_date,confirm_date,input_flag,emp_level,usests,autarea,autplnt,autdiv,autext1,autext2,
	out_emp_name,out_vendor,inpt_id,ip_addr,mac_addr,upgrade_detail)
values 
(	:a_empno,:ls_chgdate,'',:a_gubun,:a_emp_level,'',:a_autarea,:a_autplnt,:a_autdiv,:a_autext1,:a_autext2,
	:a_out_emp_name,:a_out_vendor,:g_s_empno,:g_s_ipaddr,:g_s_macaddr,:a_inputdetail)
Using	SqlCA ;

updateblob pbcommon.comm121his
	set 	emp_pwd	=	:ls_empno
where 	emp_no 		= 	:a_empno 
Using SqlCA ;

end subroutine

event open;call super::open;
cb_1.enabled 		=	false
ddlb_gubun.selectitem(1)
dw_1.settransobject(Sqlca)
dw_2.settransobject(Sqlca)

is_sql_select = dw_1.getsqlselect()
dw_2.getchild("autext1",i_dwc_1)
i_dwc_1.settransobject(sqlca)
i_dwc_1.retrieve('COM012')
is_sql_select = dw_1.getsqlselect()

gb_input.visible		=	false
gb_input.enabled	=	false
ddlb_input.visible	=	false
ddlb_input.enabled	=	false
sle_docno.visible	=	false
sle_docno.enabled	=	false

timer(0)
timer(30)



end event

on w_comm102u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.ddlb_gubun=create ddlb_gubun
this.dw_wait=create dw_wait
this.ddlb_input=create ddlb_input
this.sle_docno=create sle_docno
this.gb_input=create gb_input
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.sle_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.ddlb_gubun
this.Control[iCurrent+10]=this.dw_wait
this.Control[iCurrent+11]=this.ddlb_input
this.Control[iCurrent+12]=this.sle_docno
this.Control[iCurrent+13]=this.gb_input
end on

on w_comm102u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.ddlb_gubun)
destroy(this.dw_wait)
destroy(this.ddlb_input)
destroy(this.sle_docno)
destroy(this.gb_input)
end on

event ue_insert;int Net

dw_2.reset()
dw_2.insertrow(0)
dw_2.setfocus()
if 	dw_2.dataobject		=	'd_comm102u_021' then
	dw_2.object.emp_no.Protect = False
	dw_2.setcolumn("emp_no")
elseif dw_2.dataobject 	= 	'd_comm102u_022' then
	dw_2.object.out_emp_name.Protect 	=	False
	dw_2.object.out_vendor.Protect 	   	= 	False
	dw_2.setcolumn("out_emp_name")
end if

wf_rgbclear()		//	항목 R.G.B Clear

dw_1.selectrow(0, false)

is_selected  			= 	"a"
gb_input.visible		=	true
gb_input.enabled	=	true
ddlb_input.visible	=	true
ddlb_input.enabled	=	true
sle_docno.visible	=	true
sle_docno.enabled	=	true
i_b_retrieve 			= 	true
i_b_insert   			= 	true
i_b_save		 		= 	true
i_b_delete	 		= 	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;String 	ls_emp_no, ls_kor_nm,ls_new_sql
Integer	Net

uo_status.st_message.text	= ''
f_pism_working_msg(This.title,"사용자 정보를 조회중입니다. 잠시만 기다려 주십시오.") 
if 	dw_1.dataobject = 'd_comm102u_011' then
	if 	rb_1.checked	= 	True then
		ls_emp_no 		= 	trim(sle_1.text)
		sle_2.text		= 	trim(ls_kor_nm)
		ls_new_sql 		=	is_sql_select +  " and emp_no >= '" + ls_emp_no + "'" + " order by emp_no "
	elseif rb_2.checked = True then	
		ls_kor_nm 		= 	trim(sle_2.text)
		sle_1.text		= 	''	
		ls_new_sql 		=	is_sql_select +  " and penamek >= '" + ls_kor_nm + "'" + " order by penamek "
	end if
elseif 	dw_1.dataobject = 'd_comm102u_012' then	
	if 	rb_1.checked	= 	True then
		ls_emp_no 		= 	trim(sle_1.text)
		sle_2.text		= 	''
		ls_new_sql 		=	is_sql_select +  " and emp_no >= '" + ls_emp_no + "'" + " order by emp_no "
	elseif rb_2.checked = True then	
		ls_kor_nm 		= 	trim(sle_2.text)
		sle_1.text		= 	''	
		ls_new_sql 		= 	is_sql_select +  " and out_emp_name >= '" + ls_kor_nm + "'" + " order by out_emp_name "
	end if
end if

dw_1.reset()
dw_1.setsqlselect(ls_new_sql)
dw_1.retrieve()
dw_1.setsqlselect(is_sql_select)
dw_2.reset()

If	IsValid(w_pism_working)	Then	Close(w_pism_working)

is_selected 			=	'r'
gb_input.visible		=	false
gb_input.enabled	=	false
ddlb_input.visible	=	false
ddlb_input.enabled	=	false
sle_docno.visible	=	false
sle_docno.enabled	=	false
i_b_insert			=	true
i_b_save				=	false
i_b_delete			=	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

end event

event ue_save;String		ls_emp_no,	ls_emp_pwd,	ls_errchk, ls_column,	ls_message,	ls_new_sql,ls_emplevel,ls_deptcode,ls_inputdetail
Integer 	ln_rowcount,ln_rcnt,    ln_forcnt, ln_findrow,ln_teamleader
Blob    	lb_pwd

dw_2.accepttext()
ln_rowcount	=  dw_1.GetSelectedRow(0)

if 	f_spacechk(is_selected) = -1 or is_selected = "r" then
	if	ln_rowcount = 0 then 
   		uo_status.st_message.text	=  f_message("U090")	// 저장할 자료를 선택한 후 처리바랍니다.
   		return
	end if
end if

Setpointer(hourglass!)

ls_emp_no	= trim(dw_2.getitemstring(1, "emp_no"))
if 	dw_2.dataobject = 'd_comm102u_021' then
	SELECT 	count(*) 	INTO :ln_rcnt	FROM COMM121
	WHERE 	EMP_NO = :ls_emp_no
 	Using 	Sqlca;
	
	if 	is_selected = "a" then
		if 	ln_rcnt  >  0  then
			uo_status.st_message.text = f_message("A060")	// 입력할 자료가 이미 존재합니다 
			dw_2.object.emp_no.Background.Color = rgb(255,255,0)
			dw_2.setcolumn("emp_no")
			dw_2.setfocus()
			return
		end if
	end if
	if 	len(ls_emp_no) = 6 and isNumber(ls_emp_no) = true then
		if 	f_get_pername(ls_emp_no) = ' ' then
			uo_status.st_message.text = "인사기본 자료가 없습니다."
			dw_2.object.emp_no.Background.Color = rgb(255,255,0)
			dw_2.setcolumn("emp_no")
			dw_2.setfocus()
			return
		end if
	end if
elseif dw_2.dataobject = 'd_comm102u_022' 	And	is_selected = "a" then
	ls_emp_no = wf_out_empno(trim(dw_2.object.out_vendor[1]))
end if

if 	len(ls_column) > 0 then									// Editing Error
	dw_2.setcolumn(ls_column)
	dw_2.setfocus()
	uo_status.st_message.text = ls_message
	i_n_erreturn = -1
	return
end if

if 	is_selected = "r" and dw_2.ModifiedCount() = 0 then
	dw_1.setfocus()
   	uo_status.st_message.text = f_message("E020")		// 변경내용이 없습니다.
   	return
end if

If	is_selected = "a"	then
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
else
	ls_inputdetail	=	''
End if

f_sysdate()

SELECT	pedept	Into :ls_deptcode	FROM pbcommon.dac003
WHERE 	peempno	=	:ls_emp_no 
USING 	SqlCa ;

if	isNumber(ls_emp_no)	=	true	then
	if	ls_deptcode	=	'2300'	then
		ls_emplevel	=	'1'
	else
		ls_emplevel	=	'2'
	end if
else
	ls_emplevel	=	'3'
end if	

wf_server_update(trim(ls_emp_no),trim(dw_2.object.autarea[1]),&
				  		trim(dw_2.object.autplnt[1]),trim(dw_2.object.autdiv[1]),&
				  		trim(dw_2.object.autext1[1]),trim(dw_2.object.autext2[1]),trim(dw_2.object.out_emp_name[1]),&
				  		trim(dw_2.object.out_vendor[1]),is_selected,ls_emplevel,ls_inputdetail)
						  
if	Upper(is_selected)	=	"A"	and	len(ls_emp_no) = 6 and	isNumber(ls_emp_no) = true		then
	if	f_insert_comm140(trim(ls_emp_no))	=	true	then
		select count(*)	into	:ln_teamleader from pbcommon.dac001
		where 	duse   = ' ' and	dtodt   = 0   and	dsys1 = 'X' 		and	
					(dlevel2 	= '3' or ( dlevel2  = '4' and dunit = '1' ))	and 
						dempno  = :ls_emp_no ; 
		if	ln_teamleader	>	0	then
			if	f_teamleader_comm140(trim(ls_emp_no),'A')	=	false	then
				return
			end if
		end if
	else
		return
	end if
end if			  


ls_new_sql 		=	is_sql_select +  " and emp_no >= '" + ls_emp_no + "'" + " order by emp_no "
dw_1.setsqlselect(ls_new_sql)
dw_1.reset()
dw_1.retrieve()
dw_1.setsqlselect(is_sql_select)
dw_2.retrieve(ls_emp_no)
ln_findrow = dw_1.find("COMM121_emp_no = " + "'" + ls_emp_no + "'", 1, dw_1.rowcount() )
if 	ln_findrow > 0 then
	dw_1.scrolltorow(ln_findrow)
	dw_1.selectrow(0, false)
	dw_1.selectrow(ln_findrow, true)
end if
sle_1.setfocus()
gb_input.visible		=	false
gb_input.enabled	=	false
ddlb_input.visible	=	false
ddlb_input.enabled	=	false
sle_docno.visible	=	false
sle_docno.enabled	=	false
i_b_dprint			=	true	  
i_b_delete			=	true
is_selected 			= 	"r"
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)
dw_wait.retrieve('',g_s_empno)				  
end event

event ue_delete;call super::ue_delete;integer	ln_yesno,	ln_rcnt,		ln_findrow
string  	ls_emp_no,  ls_autarea,	ls_autplnt,	ls_autdiv,	ls_autext1,	ls_autext2,	ls_new_sql

setpointer(hourglass!)

dw_2.accepttext()
ln_yesno = messagebox("삭제 확인","해당자료를 삭제 하시겠습니까?",Question!,OkCancel!,2)
if 	ln_yesno <> 1  then
	Return
end if
ls_emp_no   =	trim(dw_2.getitemstring(1, "emp_no"))
sle_1.text	=	ls_emp_no
dw_2.deleteRow(1)
wf_server_update(ls_emp_no,'','','','','',' ',' ','D','','')
ls_new_sql 		=	is_sql_select +  " and emp_no >= '" + ls_emp_no + "'" + " order by emp_no "
dw_1.reset()
dw_1.setsqlselect(ls_new_sql)
dw_1.retrieve()
dw_1.setsqlselect(is_sql_select)
dw_2.reset()
dw_wait.retrieve('',g_s_empno)

gb_input.visible		=	false
gb_input.enabled	=	false
ddlb_input.visible	=	false
ddlb_input.enabled	=	false
sle_docno.visible	=	false
sle_docno.enabled	=	false
i_b_insert			=	true
i_b_save				=	false
i_b_delete			=	false
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

type uo_status from w_origin_sheet01`uo_status within w_comm102u
end type

type dw_1 from datawindow within w_comm102u
integer x = 9
integer y = 184
integer width = 2638
integer height = 1840
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "현재 사용자 List"
string dataobject = "d_comm102u_011"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Integer	Net
String 	ls_emp_no, ls_sts

if 	row < 1 then
	return
end if

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

wf_rgbclear()

ls_emp_no	=	this.getitemstring(row, 1)
dw_2.retrieve(ls_emp_no)
dw_2.object.emp_no.Protect 	= True

if 	dw_2.dataobject		= 	'd_comm102u_021' then
	dw_2.object.emp_no.background.color    = 	rgb(192,192,192)				
elseif dw_2.dataobject	= 	'd_comm102u_022' then
	dw_2.object.out_emp_name.Protect 				= 	True
	dw_2.object.out_vendor.Protect 	   				= 	True
	dw_2.object.out_emp_name.background.color 	= 	rgb(192,192,192)				
	dw_2.object.out_vendor.background.color      	= 	rgb(192,192,192)
end if

dw_2.setfocus()
gb_input.visible		=	false
gb_input.enabled	=	false
ddlb_input.visible	=	false
ddlb_input.enabled	=	false
sle_docno.visible	=	false
sle_docno.enabled	=	false
cb_1.enabled		=	true
i_b_save				=	true
i_b_delete			=	true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)

end event

event retrieveend;if	ddlb_gubun.text	=	'KDAC직원'	and	(trim(sle_1.text)	=	'ADMIN'	or	trim(sle_1.text)	=	''	)	then
	Integer	ln_row
	ln_row	=	dw_1.insertrow(1)
	dw_1.object.comm121_emp_no[ln_row]		=	'ADMIN'
	dw_1.object.dac003_penamek[ln_row]		=	'관리자'	
	dw_1.object.dac001_dname[ln_row]			=	'시스템개발팀'	
	ln_row	=	dw_1.insertrow(ln_row)
	dw_1.object.comm121_emp_no[ln_row]		=	'SYSMGR'
	dw_1.object.dac003_penamek[ln_row]		=	'관리자'	
	dw_1.object.dac001_dname[ln_row]			=	'시스템개발팀'	
end if
end event

type rb_1 from radiobutton within w_comm102u
integer x = 741
integer y = 64
integer width = 453
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

type rb_2 from radiobutton within w_comm102u
integer x = 1623
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

type sle_1 from singlelineedit within w_comm102u
event ue_keydown pbm_keydown
integer x = 1207
integer y = 56
integer width = 370
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = KeyEnter! then	
	parent.TriggerEvent("ue_retrieve")
end if
end event

event getfocus;rb_1.checked = true
this.SelectText(1, Len(this.Text))

end event

type sle_2 from singlelineedit within w_comm102u
event ue_keydown pbm_keydown
integer x = 1865
integer y = 56
integer width = 361
integer height = 84
integer taborder = 30
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

type gb_1 from groupbox within w_comm102u
integer x = 9
integer width = 4562
integer height = 172
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type dw_2 from datawindow within w_comm102u
integer x = 14
integer y = 2052
integer width = 3104
integer height = 400
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_comm102u_021"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_comm102u
integer x = 3931
integer y = 40
integer width = 626
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "비밀번호 초기화"
end type

event clicked;SetPointer(HourGlass!)

String	ls_empno

uo_status.st_message.text	= ''
dw_2.accepttext()
ls_empno  	= 	trim(dw_2.object.emp_no[1])
sle_1.text	=	ls_empno

if 	f_init_userid(ls_empno)	=	true then
	cb_1.enabled = false
	uo_status.st_message.text	=  '비밀번호가 초기화 되었습니다.'
else
	cb_1.enabled = true
	uo_status.st_message.text	=  '비밀번호 초기화 실패'
end if



end event

type ddlb_gubun from dropdownlistbox within w_comm102u
integer x = 55
integer y = 56
integer width = 617
integer height = 244
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 16777215
boolean sorted = false
string item[] = {"KDAC직원","외주업체직원"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;sle_1.text	=	''
sle_2.text 	= 	''
if 	index = 1 then
	dw_1.dataobject = 'd_comm102u_011'
	dw_2.dataobject = 'd_comm102u_021'
	dw_1.settransobject(Sqlca)
	dw_2.settransobject(Sqlca)
	is_sql_select = dw_1.getsqlselect()
	dw_2.getchild("autext1",i_dwc_1)
	i_dwc_1.settransobject(sqlca)
	i_dwc_1.retrieve('COM012')
elseif index = 2 then
	dw_1.dataobject = 'd_comm102u_012'
	dw_2.dataobject = 'd_comm102u_022'
	dw_1.settransobject(Sqlca)
	dw_2.settransobject(Sqlca)
	is_sql_select = dw_1.getsqlselect()
	dw_2.getchild("autext1",i_dwc_1)
	i_dwc_1.settransobject(sqlca)
	i_dwc_1.retrieve('COM012')
	dw_2.getchild("out_Vendor",i_dwc_1)
	i_dwc_1.settransobject(sqlca)
	i_dwc_1.retrieve('COM010')
end if

end event

type dw_wait from datawindow within w_comm102u
integer x = 2656
integer y = 188
integer width = 1920
integer height = 1832
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "승인대기 사용자 List - 자동 조회 (30초마다)"
string dataobject = "d_comm121his_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type ddlb_input from dropdownlistbox within w_comm102u
integer x = 3205
integer y = 2112
integer width = 882
integer height = 344
integer taborder = 90
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

type sle_docno from singlelineedit within w_comm102u
integer x = 3205
integer y = 2256
integer width = 882
integer height = 104
integer taborder = 100
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

event getfocus;sle_docno.text		=	''
sle_docno.textcolor	=	rgb(255,0,0)
is_getfocus	=	'1'
end event

type gb_input from groupbox within w_comm102u
integer x = 3136
integer y = 2016
integer width = 1024
integer height = 440
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 128
long backcolor = 12632256
string text = "신규 등록 사유"
borderstyle borderstyle = styleraised!
end type

