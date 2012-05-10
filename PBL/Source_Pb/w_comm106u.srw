$PBExportHeader$w_comm106u.srw
$PBExportComments$����� �� ���� ��� excel file �̿� upload
forward
global type w_comm106u from w_origin_sheet06
end type
type dw_1 from datawindow within w_comm106u
end type
type dw_2 from datawindow within w_comm106u
end type
type dw_menu from datawindow within w_comm106u
end type
type cb_1 from commandbutton within w_comm106u
end type
type dw_3 from datawindow within w_comm106u
end type
type st_3 from statictext within w_comm106u
end type
type st_daesang from statictext within w_comm106u
end type
type st_55 from statictext within w_comm106u
end type
type st_saeng from statictext within w_comm106u
end type
type uo_1 from uo_progress_bar within w_comm106u
end type
type rb_1 from radiobutton within w_comm106u
end type
type rb_2 from radiobutton within w_comm106u
end type
type gb_1 from groupbox within w_comm106u
end type
type gb_2 from groupbox within w_comm106u
end type
type gb_3 from groupbox within w_comm106u
end type
type gb_4 from groupbox within w_comm106u
end type
type st_dept from statictext within w_comm106u
end type
type em_dept from editmask within w_comm106u
end type
type pb_find from picturebutton within w_comm106u
end type
type st_4 from statictext within w_comm106u
end type
type gb_5 from groupbox within w_comm106u
end type
type cb_2 from commandbutton within w_comm106u
end type
type sle_1 from singlelineedit within w_comm106u
end type
type dw_4 from datawindow within w_comm106u
end type
type ddlb_input from dropdownlistbox within w_comm106u
end type
type sle_docno from singlelineedit within w_comm106u
end type
type gb_input from groupbox within w_comm106u
end type
end forward

global type w_comm106u from w_origin_sheet06
string title = "������ �ϰ� ���"
event ue_keydown pbm_keydown
dw_1 dw_1
dw_2 dw_2
dw_menu dw_menu
cb_1 cb_1
dw_3 dw_3
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
st_dept st_dept
em_dept em_dept
pb_find pb_find
st_4 st_4
gb_5 gb_5
cb_2 cb_2
sle_1 sle_1
dw_4 dw_4
ddlb_input ddlb_input
sle_docno sle_docno
gb_input gb_input
end type
global w_comm106u w_comm106u

type variables
boolean	ib_down
string  	is_selected,	is_getfocus	=	'0'
string  	is_emp_no,  is_menu_cd
dec 		in_complete
DataWindowChild child_menu
end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
end prototypes

event ue_keydown;if 	key	=	keyenter! then
	this.triggerevent("ue_bretrieve")
end if
end event

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);String 	ls_command
Long 	 	ll_color = 16777215						//	white

//--	Argument	=> ag_s_column = column ��, 
//--       				ag_n_number = column ����,
//--  					ag_n_color  = column ����( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
ag_dw_1.setredraw(False)
if 	ag_n_color 	= 	1	then
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(err_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(255,255,0), rgb(255,250,239))'"
elseif ag_n_color 	= 	2	then
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(err_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(255,255,255))'"
else
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(err_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(192,192,192))'"
end if
ag_dw_1.Modify(ls_command)
ag_dw_1.setredraw(True)
end subroutine

on w_comm106u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_menu=create dw_menu
this.cb_1=create cb_1
this.dw_3=create dw_3
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.st_dept=create st_dept
this.em_dept=create em_dept
this.pb_find=create pb_find
this.st_4=create st_4
this.gb_5=create gb_5
this.cb_2=create cb_2
this.sle_1=create sle_1
this.dw_4=create dw_4
this.ddlb_input=create ddlb_input
this.sle_docno=create sle_docno
this.gb_input=create gb_input
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_menu
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_daesang
this.Control[iCurrent+8]=this.st_55
this.Control[iCurrent+9]=this.st_saeng
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.rb_2
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.st_dept
this.Control[iCurrent+18]=this.em_dept
this.Control[iCurrent+19]=this.pb_find
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.gb_5
this.Control[iCurrent+22]=this.cb_2
this.Control[iCurrent+23]=this.sle_1
this.Control[iCurrent+24]=this.dw_4
this.Control[iCurrent+25]=this.ddlb_input
this.Control[iCurrent+26]=this.sle_docno
this.Control[iCurrent+27]=this.gb_input
end on

on w_comm106u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_menu)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.st_dept)
destroy(this.em_dept)
destroy(this.pb_find)
destroy(this.st_4)
destroy(this.gb_5)
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.dw_4)
destroy(this.ddlb_input)
destroy(this.sle_docno)
destroy(this.gb_input)
end on

event open;SetPointer(HourGlass!)

DataWindowChild child_wkcd
//������ȸ
dw_menu.GetChild("win_nm", child_menu)
child_menu.settransobject(sqlca)
child_menu.retrieve()
dw_menu.insertrow(0)

//cb_1.PostEvent(Clicked!)
this.triggerevent("activate")
i_b_bretrieve	=	true
i_b_bcreate	  	= 	false
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)


end event

event ue_bretrieve;call super::ue_bretrieve;Long   ln_count

Setpointer(HourGlass!)

dw_1.reset()
if 	rb_1.checked = true then
	if 	f_spacechk(sle_1.text) = -1 then
		uo_status.st_message.text = "�ڷ��θ� ������ �����ȸ ��ư�� Ŭ���ϼ���."	
		return
	end if
	ln_count 	=	dw_1.importfile(sle_1.text)
elseif rb_2.checked = true then
	if 	f_spacechk(em_dept.text) = -1 then
		uo_status.st_message.text = "�μ� �ڵ带 �Է� �� �����ȸ ��ư�� Ŭ���ϼ���."	
		return
	end if
	ln_count		=	dw_1.retrieve(trim(em_dept.text) + '%')
end if

st_daesang.text = string(ln_count,"###,### ")

if 	ln_count		> 	0 then
	i_b_bcreate	= 	True
end if
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)

end event

event ue_bcreate;Setpointer(HourGlass!)

String 	ls_error, ls_column, ls_empno, ls_use_win, ls_use_grd, ls_new_win,ls_chgdate
String		ls_gubun,ls_deptcode,ls_emplevel,ls_inputdetail
Integer	Net, ln_orglen, ln_newlen, ln_number
Long   	ln_ser_no, ln_totalcnt, ln_loopcnt, ln_count, ln_row, ln_rowcount,ln_findrow
Blob   	lb_pwd

uo_status.st_message.text = "Upload �ڷ� error check �� ..."
dw_1.accepttext()
ln_rowcount = dw_1.rowcount()
for 	ln_row	= 	1 	to	ln_rowcount
		ls_error 	= 	''
		ls_empno = dw_1.getitemstring(ln_row, "dac003_peempno")
		select count(*) into :net
		from   "PBCOMMON"."DAC003"
		where  "PBCOMMON"."DAC003"."PEEMPNO" = :ls_empno and "PBCOMMON"."DAC003"."PEOUT" <> '*'  using sqlca;
		if 	net < 1 then
			ls_error =	'1'
		else
			ls_error =	' '				
		end if
		dw_1.object.err_chk[ln_row] = ls_error
next
wf_rgbset("dac003_peempno",  1, 3, dw_1)
dw_1.SetRedraw(False)
ls_column	=	''
ls_error   	=	''
for 	ln_row = 1 to ln_rowcount
		ls_error = dw_1.getitemstring(ln_row, "err_chk")
		ls_empno = dw_1.getitemstring(ln_row, "dac003_peempno")
		if 	f_spacechk(ls_error) =	0 then
			ln_findrow = dw_1.find("dac003_peempno = '" + ls_empno + "'", 1, dw_1.rowcount() )
			if 	ln_findrow > 0 then
				dw_1.scrolltorow(ln_findrow)
			end if
			if 	ls_error = "1" then
				if 	f_spacechk(ls_column)	= 	-1  then
					ls_column  =	"dac003_peempno"
					exit
				end if
			end if
		end if
next
dw_1.SetRedraw(True)

if 	len(ls_column)  > 0 then
	dw_1.setrow(ln_row)
	dw_1.setcolumn(ls_column)
	dw_1.setfocus()
	uo_status.st_message.text = "��� error ������ �ڷ���� ��ư�� Ŭ���ϼ���."	
	return
end if

dw_2.accepttext()
if 	dw_2.ModifiedCount() = 0 then
	dw_2.setfocus()
   	uo_status.st_message.text	=  "Window ������ ������ �ڷ���� ��ư�� Ŭ���ϼ���"
   	return
end if

ln_rowcount = dw_2.rowcount()
for		ln_row		=	1	to	ln_rowcount
		ls_error		=	""
		ls_use_win	= 	dw_2.getitemstring(ln_row, "use_win")
		ls_use_grd	= 	dw_2.getitemstring(ln_row, "use_grd")
		ln_orglen		=	len(f_spacedel(ls_use_win))
		//��밡��Window Check
		if 	f_spacechk(ls_use_win) = -1 then
			ls_error 	=	"1"
		else
			ls_error 	=	"0"
		end if
		//����� Check
		if 	f_spacechk(ls_use_grd) = -1 then
			ls_error 	=	ls_error + "1"
		else
			ls_error 	=	ls_error + "0"
		end if
		dw_2.object.cp_chk[ln_row] = ls_error
next

wf_rgbset("use_win", 1, 1, dw_2)  
wf_rgbset("use_grd", 2, 2, dw_2)  

dw_2.SetRedraw(False)
ls_column	=	""
ls_error   	=  ""
for 	ln_row = 1 to ln_rowcount
		ls_error		= 	dw_2.getitemstring(ln_row, "cp_chk")
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

if	f_spacechk(sle_docno.text) = -1 or is_getfocus	=	'0' then
	if	ddlb_input.text	=	'���� ��û��'	or	ddlb_input.text	=	'���� ����'	then
		messagebox("Ȯ��","GWP ���� ������ȣ�� �ݵ�� �Է��ϼ���")
		uo_status.st_message.text = "GWP ���� ������ȣ�� �ݵ�� �Է��ϼ���"
		return
	elseif	ddlb_input.text	=	'��� ��û'	then
		messagebox("Ȯ��","��û�μ��� ��û�ڸ��� �Է��ϼ���")
		uo_status.st_message.text = "��û�μ��� ��û�ڸ��� �Է��ϼ���"
		return
	end if
end if
ls_inputdetail	=	'[' + trim(ddlb_input.text) + ']-[' + trim(sle_docno.text) + ']'


dw_2.SetRedraw(True)

if 	len(ls_column) > 0  then											// Editing Error
	dw_2.setrow(ln_row)
	dw_2.setcolumn(ls_column)
	dw_2.setfocus()
	uo_status.st_message.text	=  f_message("E010")		// ����� �׸��� ���� �� ó���ٶ��ϴ�.	
	return
end if

ln_totalcnt =	dec(st_daesang.text)
uo_status.st_message.text = 	"�ڷ� ó���� ..."

do while true
	if	ln_loopcnt = ln_totalcnt  then exit
	ln_loopcnt ++
	dw_1.scrolltorow(ln_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(ln_loopcnt,true)
   	ls_empno 	=	trim(dw_1.object.dac003_peempno[ln_loopcnt])
	ls_deptcode	=	trim(dw_1.object.dac001_dcode[ln_loopcnt])
	
	select		count(*)	into	:net	from	"PBCOMMON"."COMM121"
	where  	"PBCOMMON"."COMM121"."EMP_NO" = :ls_empno using Sqlca;
	
	if 	net	<	1	then
		SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
		FETCH FIRST 1 ROWS ONLY
		Using SQLCA ;
		
		if	isNumber(ls_empno)	=	true	then
			if	ls_deptcode	=	'2300'	then
				ls_emplevel	=	'1'
			else
				ls_emplevel	=	'2'
			end if
		else
			ls_emplevel	=	'3'
		end if	
		
		insert into pbcommon.comm121his
		(	emp_no,input_date,confirm_date,input_flag,emp_level,usests,autarea,autplnt,autdiv,autext1,autext2,
			out_emp_name,out_vendor,inpt_id,ip_addr,mac_addr,upgrade_detail)
		values 
		(	:ls_empno,:ls_chgdate,'','A',:ls_emplevel,'','','','','','','','',:g_s_empno,:g_s_ipaddr,:g_s_macaddr,:ls_inputdetail)
		Using	SqlCA ;
		
		lb_pwd		=	Blob('D' + ls_empno + '0')
		
		updateblob pbcommon.comm121his
			set 	emp_pwd	=	:lb_pwd
		where 	emp_no 		= 	:ls_empno 	Using 	SqlCA ;
		if 	sqlca.sqlcode <> 0 then
			rollback using sqlca;
			uo_status.st_message.text	=  f_message("U020")	// [���� ����] �����ý��������� �����ٶ��ϴ�. 						  
			return
		end if
	end if

	ln_rowcount 	= 	dw_2.rowcount()
   	for 	ln_row 	= 	1 	to	ln_rowcount
			ls_use_win	= 	trim(dw_2.getitemstring(ln_row, "use_win"))
			ls_use_grd	= 	dw_2.getitemstring(ln_row, "use_grd")
			select	count(*)	into	:net	from	"PBCOMMON"."COMM140"
			where  	"PBCOMMON"."COMM140"."EMP_NO"  	= 	:ls_empno   and
					 	"PBCOMMON"."COMM140"."USE_WIN" 	=	:ls_use_win using sqlca;
			if 	net	<	1	then
				ls_gubun	=	'A'
			else
				ls_gubun	=	'R'
			end if
			SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
			FETCH FIRST 1 ROWS ONLY
			Using SqlCA ;

			insert	into	pbcommon.comm140his	values
			(:ls_empno,:ls_use_win,:ls_chgdate,'',:ls_gubun,	:ls_use_grd,:g_s_empno,:g_s_ipaddr,:g_s_macaddr,:ls_inputdetail)
			Using	SqlCA;
			if 	sqlca.sqlcode <> 0 then
				rollback using sqlca;
				uo_status.st_message.text	=  f_message("U020")	// [���� ����] �����ý��������� �����ٶ��ϴ�. 						  
				return
			end if
	next
	in_complete	=	ln_loopcnt * 100 / ln_totalcnt
	uo_1.uf_set_position (in_complete)
	st_saeng.text	=	String(ln_loopcnt,"###,### ")
	commit using 	sqlca;
loop
uo_1.uf_set_position (in_complete)
st_saeng.text	=	String(ln_loopcnt,"###,### ")
messagebox("Ȯ��","�ý��� �����ڿ��� ����� ���� �ϰ���� ���ο�û�� �Ϸ��߽��ϴ�")
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)

end event

type uo_status from w_origin_sheet06`uo_status within w_comm106u
integer y = 2456
end type

type dw_1 from datawindow within w_comm106u
event ue_keydown pbm_dwnkey
integer x = 206
integer y = 280
integer width = 2697
integer height = 1028
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm106u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;long ln_row,ln_yesno

ln_row = this.getselectedrow(0)

if ln_row  < 1 then
	return 0
end if
if key = keydelete! then
	ln_yesno		=	Messagebox("���� Ȯ��", "���õ� (" + string(ln_row) + "��° ��)�� ���� �Ͻðڽ��ϱ�?", Question!, YesNo!)
	if ln_yesno	<>	1  then
		Return
	end if
	this.deleterow(ln_row)
	this.setredraw(true)
	st_daesang.text = string(long(st_daesang.text) - 1)
end if
return 0

end event

event clicked;if row < 1 then
	return
end if

this.selectrow(0,false)
this.selectrow(row,true)
end event

event constructor;this.settransobject(Sqlca)
end event

type dw_2 from datawindow within w_comm106u
event ue_keydown pbm_dwnkey
integer x = 3026
integer y = 280
integer width = 1266
integer height = 1028
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm104u_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;long ln_row,ln_yesno

ln_row = this.getselectedrow(0)

if ln_row  < 1 then
	return 0
end if
if key = keydelete! then
	ln_yesno		=	Messagebox("���� Ȯ��", "���õ� (" + string(ln_row) + "��° ��)�� ���� �Ͻðڽ��ϱ�?", Question!, YesNo!)
	if ln_yesno	<>	1  then
		Return
	end if
	this.deleterow(ln_row)
	this.setredraw(true)
end if
return 0

end event

event dragdrop;long 	 l_n_insrow, l_n_sel3row
string l_s_win_id

l_n_sel3row = dw_3.getselectedrow(0)

//�ڷ��̵�
l_s_win_id  = dw_3.getitemstring(l_n_sel3row, "win_id")		// Window Id
l_n_insrow	= this.insertrow(0)
this.object.use_win[l_n_insrow] = l_s_win_id

end event

event clicked;if row < 1 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)
end event

event constructor;this.settransobject(sqlca) 
end event

type dw_menu from datawindow within w_comm106u
integer x = 288
integer y = 1380
integer width = 690
integer height = 96
integer taborder = 60
boolean bringtotop = true
string dataobject = "dddw_comm110_c01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;is_menu_cd	=	left(child_menu.getitemstring(child_menu.getrow(), "menu_cd"), 2)
end event

type cb_1 from commandbutton within w_comm106u
integer x = 379
integer y = 1548
integer width = 448
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
string text = "���α׷���ȸ"
end type

event clicked;Setpointer(hourglass!)

string l_s_menu_cd

//f_connect(sqlca)
dw_3.settransobject(sqlca)
dw_3.retrieve(is_menu_cd)
//f_disconnect(sqlca)

end event

type dw_3 from datawindow within w_comm106u
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 1038
integer y = 1324
integer width = 3259
integer height = 904
integer taborder = 50
string dragicon = "Information!"
boolean bringtotop = true
string dataobject = "d_comm104u_03"
boolean vscrollbar = true
string icon = "None!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttondown;ib_down = true
end event

event ue_lbuttonup;ib_down = false
end event

event ue_mousemove;if 	ib_down 	then
	this.Drag (begin!)
end if

end event

event clicked;if 	row < 1 then
	return
end if

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type st_3 from statictext within w_comm106u
integer x = 251
integer y = 2284
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long backcolor = 12632256
boolean enabled = false
string text = "���Ǽ�"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_comm106u
integer x = 571
integer y = 2284
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_55 from statictext within w_comm106u
integer x = 1074
integer y = 2284
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long backcolor = 12632256
boolean enabled = false
string text = "�����Ǽ�"
boolean focusrectangle = false
end type

type st_saeng from statictext within w_comm106u
integer x = 1399
integer y = 2284
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_comm106u
event destroy ( )
integer x = 2309
integer y = 2284
integer taborder = 80
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type rb_1 from radiobutton within w_comm106u
integer x = 238
integer y = 68
integer width = 503
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
string text = "Text  ����"
boolean checked = true
end type

event clicked;cb_2.visible  		=	true
cb_2.enabled  		= 	true
sle_1.visible 		= 	true
sle_1.enabled 		= 	true
st_dept.visible  	= 	false
st_dept.enabled  	= 	false
em_dept.visible 	= 	false
em_dept.enabled 	= 	false
pb_find.visible  	= 	false
pb_find.enabled  	= 	false
st_4.visible 		= 	false
st_4.enabled 		= 	false

end event

type rb_2 from radiobutton within w_comm106u
integer x = 238
integer y = 148
integer width = 489
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 12632256
string text = "�μ��� ���"
end type

event clicked;cb_2.visible  		=	false
cb_2.enabled  		= 	false
sle_1.visible 		= 	false
sle_1.enabled 		= 	false
st_dept.visible  	= 	true
st_dept.enabled  	= 	true
em_dept.visible 	= 	true
em_dept.enabled 	= 	true
pb_find.visible  	= 	true
pb_find.enabled  	= 	true
st_4.visible 		= 	true
st_4.enabled 		= 	true

end event

type gb_1 from groupbox within w_comm106u
integer x = 201
integer y = 1316
integer width = 823
integer height = 204
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 8388608
long backcolor = 12632256
string text = "[������ȸ]"
end type

type gb_2 from groupbox within w_comm106u
integer x = 201
integer y = 2228
integer width = 1650
integer height = 188
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_comm106u
integer x = 1870
integer y = 2228
integer width = 2423
integer height = 188
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 8388608
long backcolor = 12632256
string text = "[ó������]"
end type

type gb_4 from groupbox within w_comm106u
integer x = 206
integer y = 24
integer width = 576
integer height = 212
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_dept from statictext within w_comm106u
boolean visible = false
integer x = 910
integer y = 108
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "�μ��ڵ�"
boolean focusrectangle = false
end type

type em_dept from editmask within w_comm106u
boolean visible = false
integer x = 1211
integer y = 96
integer width = 338
integer height = 92
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
boolean enabled = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!"
boolean autoskip = true
end type

type pb_find from picturebutton within w_comm106u
boolean visible = false
integer x = 1591
integer y = 96
integer width = 238
integer height = 108
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

l_s_parm = ' I'

openwithparm(w_find_001 , l_s_parm)
l_s_parm = message.stringparm

if f_spacechk(l_s_parm) <> -1 then
	st_4.text = ''
	st_4.text = mid(l_s_parm,16,30)
	em_dept.text = trim(mid(l_s_parm,1,5))
end if

return 0
end event

type st_4 from statictext within w_comm106u
boolean visible = false
integer x = 1879
integer y = 104
integer width = 1006
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_comm106u
integer x = 800
integer y = 24
integer width = 2103
integer height = 212
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_2 from commandbutton within w_comm106u
integer x = 841
integer y = 100
integer width = 302
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
string text = "�ڷ���"
end type

event clicked;String ls_pathname, ls_filename

GetFileOpenName("Select File", ls_pathname, ls_filename, "txt", "dBase Files (*.txt),*.txt,")
sle_1.text = ls_pathname
end event

type sle_1 from singlelineedit within w_comm106u
integer x = 1170
integer y = 100
integer width = 937
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_comm106u
boolean visible = false
integer x = 393
integer y = 632
integer width = 2391
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_comm001_retrieve"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlpis)
end event

type ddlb_input from dropdownlistbox within w_comm106u
integer x = 270
integer y = 1812
integer width = 704
integer height = 344
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long backcolor = 15780518
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
string item[] = {"���� ��û��","���� ����","��� ��û"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text	=	'���� ��û��'
end event

event selectionchanged;if	index	=	1	then
	sle_docno.text			=	'���񽺿�û�� ��ȣ�� �Է��ϼ���'
elseif	index	=	2	then
	sle_docno.text			=	'�������� ��ȣ�� �Է��ϼ���'
elseif	index	=	3	then
	sle_docno.text			=	'��û�μ��� ��û�ڸ� �Է��ϼ���'
end if
sle_docno.textcolor	=	rgb(255,0,0)
sle_docno.backcolor	=	15780518
sle_docno.enabled		=	true
is_getfocus				=	'0'
end event

type sle_docno from singlelineedit within w_comm106u
integer x = 270
integer y = 1956
integer width = 704
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 255
long backcolor = 15780518
string text = "���񽺿�û�� ��ȣ�� �Է��ϼ���"
borderstyle borderstyle = stylelowered!
end type

event getfocus;sle_docno.text		=	''
sle_docno.textcolor	=	rgb(255,0,0)
is_getfocus	=	'1'
end event

type gb_input from groupbox within w_comm106u
integer x = 201
integer y = 1716
integer width = 823
integer height = 424
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 128
long backcolor = 12632256
string text = "�ϰ� ��� ����"
borderstyle borderstyle = styleraised!
end type

