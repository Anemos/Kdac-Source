$PBExportHeader$w_comm103u.srw
$PBExportComments$User ����(Admin����)
forward
global type w_comm103u from w_origin_sheet01
end type
type tab_1 from tab within w_comm103u
end type
type tabpage_1 from userobject within tab_1
end type
type st_delete from statictext within tabpage_1
end type
type pb_delete from picturebutton within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_delete st_delete
pb_delete pb_delete
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_comm103u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_comm103u from w_origin_sheet01
integer height = 2724
tab_1 tab_1
end type
global w_comm103u w_comm103u

type variables
string is_selected,is_date
integer ii_LastRow = 0
end variables

forward prototypes
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw, integer a_lastrow)
public function boolean wf_server_update (string a_before_pwd, string a_after_pwd, string a_gubun)
end prototypes

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw, integer a_lastrow);integer	l_i_Idx, l_i_last_row

l_i_last_row = a_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If l_i_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if l_i_last_row > al_aclickedrow then
	For l_i_Idx = l_i_last_row to al_aclickedrow STEP -1
		dw.selectrow(l_i_Idx,TRUE)	
	end for	
else
	For l_i_Idx = l_i_last_row to al_aclickedrow 
		dw.selectrow(l_i_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public function boolean wf_server_update (string a_before_pwd, string a_after_pwd, string a_gubun);integer i
string  ls_area,ls_gubun

sqlxx = CREATE transaction
sqlxx.DBMS          = "MSS Microsoft SQL Server 6.x"

for i = 1 to 7
	// remote autodown ����
	if i = 1 then
		sqlxx.ServerName = "192.168.113.249,1433"
		sqlxx.Database   = "TPROJ"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = ""
		ls_area         = "����"
	elseif i = 2 then
		sqlxx.ServerName = "192.168.111.249,1433"
		sqlxx.Database   = "pbcommon"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = ""
		ls_area         = "����"
	elseif i = 3 then
		sqlxx.ServerName = "192.168.103.249,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		ls_area         = "����"
	elseif i = 4 then
		sqlxx.ServerName = "192.168.108.249,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		ls_area         = "���"
	elseif i = 5 then
		sqlxx.ServerName = "192.168.109.249,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		ls_area         = "����"
	elseif i = 6 then
		sqlxx.ServerName = "192.168.112.72,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		ls_area         = "��õ"
	elseif i = 7 then
		sqlxx.DBMS       = "ODBC"
		sqlxx.autocommit = false
		sqlxx.DBParm     = "ConnectString='DSN=CA/400 ODBC for PB;UID=CASINV;PWD=DPAINV',disablebind=1"
		ls_area         = "�뱸"	
	end if
	connect using sqlxx;
	if sqlxx.sqlcode <> 0 then
		messagebox('���',  ls_area + ' ������ ������� �ʽ��ϴ�. update �Ұ�.')
		destroy sqlxx 
		return false
	end if
	if a_gubun = 'D' then
		if sqlxx.dbms = "ODBC" then
			delete from pbcommon.comm122
			where pwd = :a_before_pwd using sqlxx ;	
		else
			delete from comm122
			where pwd = :a_before_pwd using sqlxx ;
		end if
		ls_gubun = '����'
	elseif a_gubun = 'R' then
		if sqlxx.dbms = "ODBC" then
			update pbcommon.comm122
			set pwd = :a_after_pwd,updtdt = :g_s_datetime,updtid = :g_s_empno
			where pwd = :a_before_pwd		
			using sqlxx ;
		else
			update comm122
			set pwd = :a_after_pwd,updtdt = :g_s_datetime,updtid = :g_s_empno
			where pwd = :a_before_pwd		
			using sqlxx ;	
		end if	
		ls_gubun = '����'
	elseif a_gubun = 'A' then
		if sqlxx.dbms = "ODBC" then
			insert into pbcommon.comm122 values 
			( :a_after_pwd,:g_s_empno,:g_s_datetime,:g_s_empno,:g_s_datetime,
			  :g_s_ipaddr ,:g_s_macaddr )
			using sqlxx ;
		else
			insert into comm122 values 
			( :a_after_pwd,:g_s_empno,:g_s_datetime,:g_s_empno,:g_s_datetime,
			  :g_s_ipaddr ,:g_s_macaddr )
			using sqlxx ;
		end if
		ls_gubun = '�Է�'
	end if
	if sqlxx.sqlcode = 0 then
		commit using sqlxx;
		uo_status.st_message.text = ls_gubun + " �Ϸ� " + "( " + ls_area + " )"
	else
		uo_status.st_message.text = ls_gubun + " ���� " + "( " + ls_area + " )"
		messagebox("Ȯ��",sqlxx.sqlerrtext)
		rollback using sqlxx;
		destroy sqlxx 
		return false
	end if
	disconnect using sqlxx;
next
destroy sqlxx 
return true
end function

on w_comm103u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_comm103u.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_insert;/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
integer ln_insertrow
tab_1.tabpage_2.dw_2.retrieve()
tab_1.tabpage_2.dw_2.setfocus()
ln_insertrow = tab_1.tabpage_2.dw_2.insertrow(0)
tab_1.tabpage_2.dw_2.scrolltorow(ln_insertrow)
i_b_retrieve = True
i_b_insert   = True
i_b_save		 = True
i_b_delete	 = False
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
if tab_1.selectedtab = 2 then
	i_b_insert	= True
	i_b_save	   = true
	i_b_delete	= true
	if tab_1.tabpage_2.dw_2.retrieve() > 0 then
		uo_status.st_message.text	=	f_message("I010")
	else
		uo_status.st_message.text	=	f_message("I020")
	end if
else
	i_b_insert  = false
	i_b_save	   = false
	i_b_delete	= false
	if tab_1.tabpage_1.dw_1.retrieve(is_date) > 0 then
		uo_status.st_message.text	=	f_message("I010")
	else
		uo_status.st_message.text	=	f_message("I020")
	end if
end if
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

end event
event ue_save;integer i,ln_rowcount
string ls_before_pwd,ls_after_pwd

setpointer(hourglass!)
tab_1.tabpage_2.dw_2.accepttext()
ln_rowcount = tab_1.tabpage_2.dw_2.rowcount()
for i = 1 to ln_rowcount
	if f_pisc_dw_check_duplicate(tab_1.tabpage_2.dw_2,'pwd',i,trim(tab_1.tabpage_2.dw_2.object.pwd[i])) = true then
		messagebox("Ȯ��",string(i) + " ��° ���� �н������ �Է��Ͻ� " + string(trim(tab_1.tabpage_2.dw_2.object.pwd[i])) + &
		                " �� ������ ���Դϴ�. Ȯ�� �� �� �Է¹ٶ��ϴ� " )
      return 							
	end if
next
for i = 1 to ln_rowcount
	ls_before_pwd	=	tab_1.tabpage_2.dw_2.getitemstring(i, "pwd",primary!,true)		
	ls_after_pwd	=	tab_1.tabpage_2.dw_2.getitemstring(i, "pwd",primary!,false)		
	if tab_1.tabpage_2.dw_2.GetItemStatus (i, 0 , primary!) = NewModified! then
		wf_server_update(ls_before_pwd,ls_after_pwd,'A')
	elseif tab_1.tabpage_2.dw_2.GetItemStatus (i, 0, primary!) = DataModified! then
		wf_server_update(ls_before_pwd,ls_after_pwd,'R')		
	end if
next
tab_1.tabpage_2.dw_2.retrieve()
i_b_retrieve = true
i_b_insert   = true
i_b_save	    = true
i_b_delete	 = true
tab_1.tabpage_2.dw_2.retrieve()
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

end event

event ue_delete;call super::ue_delete;string  ls_password
integer ln_row
long    ln_yesno
boolean lb_save

ln_row = tab_1.tabpage_2.dw_2.getselectedrow(0)
if ln_row <> 0 then
	ln_yesno = messagebox("����Ȯ��", "���õ� �н����带 �����Ͻðڽ��ϱ� ?",Question!,OkCancel!,2)
	if ln_yesno <> 1 then
		uo_status.st_message.text = f_message("D030")
		return 0
	end if
else
	uo_status.st_message.text = f_message("D100")
	return 0
end if
do until ln_row = 0 
	ls_password = trim(tab_1.tabpage_2.dw_2.getitemstring(ln_row,'pwd',primary!,true))
	if wf_server_update(ls_password,ls_password,'D') = false then
		messagebox("Ȯ��","������ ����ϴ� ���� ���� �߻��߽��ϴ�.�ý��� �������� ���ǹٶ��ϴ�")
		exit
	end if
	ln_row = tab_1.tabpage_2.dw_2.getselectedrow(ln_row)
loop
/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
tab_1.tabpage_2.dw_2.retrieve()
i_b_retrieve   =  true
i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	False
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
  
end event

event open;call super::open;is_date = string(f_relativedate(g_s_date,-120),'yyyy-mm-dd')
if g_s_empno = 'ADMIN' then
	tab_1.tabpage_1.st_delete.visible = true
	tab_1.tabpage_1.pb_delete.visible = true
	tab_1.tabpage_1.st_delete.enabled = true
	tab_1.tabpage_1.pb_delete.enabled = true
end if
end event

type uo_status from w_origin_sheet01`uo_status within w_comm103u
end type

type tab_1 from tab within w_comm103u
integer x = 23
integer y = 16
integer width = 4581
integer height = 2444
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event selectionchanged;is_date = string(f_relativedate(g_s_date,-120),'yyyy-mm-dd')
if newindex = 1 then
	i_b_retrieve = True
	i_b_insert   = false
	i_b_save		 = false
	i_b_delete	 = False
	wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
					  i_b_dprint,   i_b_dchar)
	tab_1.tabpage_1.tabtextcolor = rgb(255,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)
//	tab_1.tabpage_1.dw_1.retrieve(is_date)
elseif newindex = 2 then
	i_b_retrieve = True
	i_b_insert   = true
	i_b_save		 = true
	i_b_delete	 = False
	wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
					  i_b_dprint,   i_b_dchar)
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(255,0,0)	
//	tab_1.tabpage_2.dw_2.retrieve()
end if


end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4544
integer height = 2316
long backcolor = 12632256
string text = "�̻�� User ����"
long tabtextcolor = 255
long tabbackcolor = 12632256
long picturemaskcolor = 553648127
st_delete st_delete
pb_delete pb_delete
dw_1 dw_1
end type

on tabpage_1.create
this.st_delete=create st_delete
this.pb_delete=create pb_delete
this.dw_1=create dw_1
this.Control[]={this.st_delete,&
this.pb_delete,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.st_delete)
destroy(this.pb_delete)
destroy(this.dw_1)
end on

type st_delete from statictext within tabpage_1
boolean visible = false
integer x = 3813
integer y = 64
integer width = 517
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "�̻�� ID ����"
boolean focusrectangle = false
end type

type pb_delete from picturebutton within tabpage_1
boolean visible = false
integer x = 4343
integer y = 28
integer width = 169
integer height = 136
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string picturename = "Custom080!"
alignment htextalign = left!
end type

event clicked;integer i
string l_s_area

sqlxx = CREATE transaction
for i = 1 to 7
	if i = 1 then
		sqlxx.ServerName = "192.168.113.249,1433"
		sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
		sqlxx.Database   = "TPROJ"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = ""
		l_s_area         = "����"
	elseif i = 2 then
		sqlxx.ServerName = "192.168.111.249,1433"
		sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
		sqlxx.Database   = "pbcommon"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = ""
		l_s_area         = "����"
	elseif i = 3 then
		sqlxx.ServerName = "192.168.103.249,1433"
		sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "����"
	elseif i = 4 then
		sqlxx.ServerName = "192.168.108.249,1433"
		sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "���"
	elseif i = 5 then
		sqlxx.ServerName = "192.168.109.249,1433"
		sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "����"
	elseif i = 6 then
		sqlxx.ServerName = "192.168.112.72,1433"
		sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "��õ"
	elseif i = 7 then
		sqlxx.DBMS       = "ODBC"
		sqlxx.autocommit = false
		sqlxx.DBParm     = "ConnectString='DSN=CA/400 ODBC for PB;UID=CASINV;PWD=DPAINV',disablebind=1"
		l_s_area         = "�뱸"
	end if
	connect using sqlxx;
	if i = 7 then
	//	delete from pbcommon.comm140
	//		where emp_no in ( select emp_no from pbcommon.COMM121  where substring(UPDT_DT,1,10) < :is_date )
	//	using sqlxx ;
	//	delete from pbcommon.COMM121   
	//		where substring(UPDT_DT,1,10) < :is_date  
	//	using sqlxx ;
	else 
	//	delete from comm140
	//		where emp_no in ( select emp_no from COMM121  where substring(UPDT_DT,1,10) < :is_date )
	//	using sqlxx ;
	//	delete from COMM121   
	//		where substring(UPDT_DT,1,10) < :is_date  
	//	using sqlxx ;
	end if
	if sqlxx.sqlcode <> 0 then
		messagebox("", l_s_area + "  " + sqlxx.sqlerrtext)
	else
		commit using sqlxx;
	end if
	disconnect using sqlxx ;
next
destroy sqlxx

end event

type dw_1 from datawindow within tabpage_1
integer x = 9
integer y = 172
integer width = 4507
integer height = 2100
integer taborder = 20
string dataobject = "d_comm103u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4544
integer height = 2316
long backcolor = 12632256
string text = "���Ұ� �н����� ���"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
integer x = 18
integer y = 56
integer width = 4256
integer height = 2228
integer taborder = 10
string title = "none"
string dataobject = "d_comm103u_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

event clicked;if row <= 0 then
	return
end if
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this , ii_LastRow)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

