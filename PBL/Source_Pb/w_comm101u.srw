$PBExportHeader$w_comm101u.srw
$PBExportComments$Program 등록
forward
global type w_comm101u from w_origin_sheet01
end type
type dw_1 from datawindow within w_comm101u
end type
type gb_1 from groupbox within w_comm101u
end type
type st_1 from statictext within w_comm101u
end type
type dw_3 from datawindow within w_comm101u
end type
end forward

global type w_comm101u from w_origin_sheet01
string title = "사용자 등록"
dw_1 dw_1
gb_1 gb_1
st_1 st_1
dw_3 dw_3
end type
global w_comm101u w_comm101u

type variables
string  i_s_menu_cd, i_s_click_cd, i_s_selected
DataWindowChild dw_child1
end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color)
public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun)
end prototypes

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
dw_1.setredraw(False)
if ag_n_color 	= 	1	then
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(255,255,0), rgb(255,250,239))'"
else
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(255,255,255))'"
end if

dw_1.Modify(l_s_command)
dw_1.setredraw(True)

end subroutine

public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun);integer l_n_rcnt,i
string  l_s_area,l_s_after_menu_cd,l_s_before_menu_cd,l_s_winid,l_s_winnm,l_s_winrpt,l_s_winst

l_s_before_menu_cd = a_dw.getitemstring(a_row,'menu_cd',primary!,true)
l_s_after_menu_cd  = a_dw.getitemstring(a_row,'menu_cd',primary!,false)
l_s_winid  = a_dw.object.win_id[a_row]
l_s_winnm  = a_dw.object.win_nm[a_row]	
l_s_winrpt = a_dw.object.win_rpt[a_row]
l_s_winst  = a_dw.object.win_st[a_row]
sqlxx = CREATE transaction
sqlxx.DBMS       = "MSS Microsoft SQL Server 6.x"
for i = 1 to 4
	// remote autodown 관련
	if i = 1 then
		sqlxx.ServerName = "192.168.103.249,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "전장"
	elseif i = 2 then
		sqlxx.ServerName = "192.168.108.249,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "기계"
	elseif i = 3 then
		sqlxx.ServerName = "192.168.109.249,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "공조"
	elseif i = 4 then	
		sqlxx.ServerName = "192.168.112.72,1433"
		sqlxx.Database   = "IPIS"
		sqlxx.LogId      = "sa"
		sqlxx.LogPass    = "goipis"
		l_s_area         = "진천"
	end if
	connect using sqlxx;
	if sqlxx.sqlcode <> 0 then
		messagebox('경고',  l_s_area + ' 서버가 연결되지 않습니다. update 불가.')
		continue
	end if
	if a_gubun = 'D' then
		delete from comm110
			where menu_cd = :l_s_after_menu_cd using sqlxx ;
	elseif a_gubun = 'R' then
		update comm110
			set menu_cd = :l_s_after_menu_cd,win_id  = :l_s_winid ,win_nm = :l_s_winnm,
			    win_rpt = :l_s_winrpt,win_st = :l_s_winst,updt_id = :g_s_empno,
				 updt_dt = :g_s_datetime
		where menu_cd  = :l_s_before_menu_cd using sqlxx ;
   elseif a_gubun = 'A' then
		insert into comm110 values
			( :l_s_after_menu_Cd,:l_s_winid,:l_s_winnm,:l_s_winrpt,:l_s_winst,:g_s_empno,
			  :g_s_datetime,:g_s_empno ,:g_s_datetime ,:g_s_ipaddr,:g_s_macaddr )
		using sqlxx ;
	end if
	if sqlxx.sqlcode <> 0 then
		messagebox("확인",string(sqlxx.sqlerrtext))
		rollback using sqlxx ;
	else
		commit using sqlxx ;
		uo_status.st_message.text = l_s_winnm + " 저장 완료 " + "( " + l_s_area + " )"
	end if
	disconnect using sqlxx;
next

destroy sqlxx
end subroutine
on w_comm101u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.st_1=create st_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_3
end on

on w_comm101u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.dw_3)
end on

event ue_retrieve;int Net

if i_s_level = "5"	then
	dw_1.accepttext()
	if dw_1.modifiedcount() > 0 then
		Net = messagebox("확 인", f_message("U090"), Question!, YesNoCancel!,2)
		if Net = 1 then
			TriggerEvent("ue_save")
			if i_n_erreturn = -1 then
				return
			end if
		elseif Net = 3 then
			return
		end if
	end if
end if

dw_1.reset()

if f_spacechk(i_s_click_cd) 	= 	-1 then
  	uo_status.st_message.text	=	f_message("E242")		// 단위업무를 선택한 후 처리바랍니다.	  
	return
end if

setpointer(hourglass!)

dw_1.retrieve(i_s_click_cd + '%')

if dw_1.rowcount()	= 0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	i_b_dprint	=	False		  
else
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.

	dw_1.Setrow(1)
	dw_1.SetColumn('win_id')	
	dw_1.SetFocus()

	i_b_save		=	True
	i_b_delete	=	True
	i_b_dprint	=	True		  
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_s_selected	=	'r'

i_b_insert	=	True
//i_b_save		=	False
//i_b_delete	=	False

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
i_s_menu_cd		=	i_s_click_cd								// Key Save
setpointer(Arrow!)
end event

event ue_insert;integer l_n_row

if f_spacechk(i_s_click_cd) 	= 	-1 then
  	uo_status.st_message.text	=	f_message("E242")		// 단위업무를 선택한 후 처리바랍니다.	  
	return
end if	
	
if i_s_click_cd	<>	i_s_menu_cd then
  	uo_status.st_message.text	=  f_message("I090")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if

l_n_row	=	dw_1.insertrow(0)
dw_1.ScrollToRow(l_n_row)

i_s_selected   =	"i"

i_b_insert	=	True
i_b_save		=	True
i_b_delete	=	True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_delete;integer l_n_row, l_n_yesno, l_n_rowcount
string  l_s_menucd, l_s_menucd4

dw_1.accepttext()
l_n_row        =  dw_1.GetRow()
l_n_rowcount 	= 	dw_1.rowcount()

if f_spacechk(i_s_click_cd) 	= 	-1 then
  	uo_status.st_message.text	=	f_message("E242")		// 단위업무를 선택한 후 처리바랍니다.	  
	return
end if	
IF l_n_row 		< 1 THEN 
	uo_status.st_message.text	=  f_message("D100")		// 삭제할 자료를 확인한 후 처리바랍니다.
	RETURN
END IF

l_s_menucd		= 	trim(dw_1.getitemstring(l_n_row, "menu_cd"))
l_s_menucd4		= 	mid(l_s_menucd, 3, 2)

if i_s_click_cd	<> i_s_menu_cd	then
  	uo_status.st_message.text	=  f_message("I090")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if
if l_s_menucd4 = '00' and l_n_rowcount > 1 then
  	uo_status.st_message.text	=  '단위업무에 메뉴가 딸린경우 단위업무를 삭제할 수 없습니다.'  
	return
end if

l_n_yesno		=	Messagebox("삭제 확인", "선택된 (" + string(l_n_row) + "번째 행)을 삭제 하시겠습니까?", Question!, YesNo!)
if l_n_yesno	<>	1  then
	Return
end if

if dw_1.GetItemStatus(l_n_row,"menu_cd", Primary!) <> NewModified!	then
	delete from pbcommon.comm110
		where menu_Cd = :l_s_menucd using sqlca ;
	if sqlca.sqlcode = 0 then	
		commit using sqlca;
		wf_server_update(dw_1,l_n_row,'D')
		uo_status.st_message.text	=  f_message("D010")	// 삭제되었습니다.
		dw_1.reset()		
		dw_1.retrieve(i_s_click_cd + '%')
	else
		messagebox("확인",sqlca.sqlerrtext + " " + string(sqlca.sqlcode))
		rollback using sqlca;
		uo_status.st_message.text	=  f_message("D020")	// [삭제실패] 정보시스템팀으로 연락바랍니다. 
	end if
else
	uo_status.st_message.text		=  f_message("D040")	// 삭제할수없습니다.		
end if

l_n_rowcount 		= 	dw_1.rowcount()
if l_n_rowcount	<	1	then
	i_b_save			=	False
	i_b_delete		=	False
end if

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event open;call super::open;
setpointer(hourglass!)

integer	l_n_rowcount

dw_3.GetChild('win_nm', dw_child1)
dw_child1.settransobject(sqlca)
dw_child1.retrieve()
dw_3.insertrow(0)

end event

event closequery;int Net
//--	Return 0 : Closing, 	Return 1 : Not Closed	
if i_s_level = "5"	then
	dw_1.accepttext()
	if dw_1.modifiedcount() > 0 then
	
		this.SetPosition(ToTop!)
		this.WindowState	=	Normal!
		
		Net		= 	messagebox("확 인", f_message("U090"), Question!, YesNoCancel!,2)
		if Net	= 	1 then
			TriggerEvent("ue_save")
			if i_n_erreturn	=	-1 then
				return	1
			end if
		elseif Net	= 	3 then
			return	1
		end if
	end if
end if
end event

event ue_save;string     l_s_menu_cd,  l_s_menu_cd2, l_s_menu_cd4, l_s_win_id,   l_s_win_nm, &
			  l_s_win_st,   l_s_column, 	l_s_error,	  l_s_errchk	
integer    l_n_rowcount, l_n_row,      l_n_row2,	  l_n_findrow,	 l_n_idx

dw_1.accepttext()

if f_spacechk(i_s_click_cd) 	= 	-1 then
  	uo_status.st_message.text	=	f_message("E242")		// 단위업무를 선택한 후 처리바랍니다.	  
	return
end if	

l_n_rowcount = dw_1.getrow()
if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_rowcount     =  0   then    
   	uo_status.st_message.text	=  f_message("U070")	// 저장할 자료를 선택한 후 처리바랍니다.
   	return
	end if
end if
if i_s_click_cd	<> i_s_menu_cd then
  	uo_status.st_message.text	=  f_message("I070")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if

///////////    	Body Editing Check Area		///////////
l_n_rowcount 	= 	dw_1.rowcount()
for l_n_row		= 	1 to l_n_rowcount
	l_s_error		=	''
	
	l_s_menu_cd		= 	trim(dw_1.getitemstring(l_n_row, "menu_cd"))
	l_s_menu_cd2	= 	left(trim(dw_1.getitemstring(l_n_row, "menu_cd")), 1)
	l_s_menu_cd4	= 	right(trim(dw_1.getitemstring(l_n_row, "menu_cd")), 1)
	l_s_win_id		= 	trim(dw_1.getitemstring(l_n_row, "win_id"))
	l_s_win_nm		= 	trim(dw_1.getitemstring(l_n_row, "win_nm"))
	l_s_win_st		= 	trim(dw_1.getitemstring(l_n_row, "win_st"))

	l_s_errchk		=	''	
	//--	동일 메뉴코드가 입력된 경우 ( Duplicate ) 
	if dw_1.GetItemStatus (l_n_row, 0, primary!) <> NotModified! then
		for l_n_idx	=	1 to l_n_rowcount
			if l_n_idx <> l_n_row then
				if dw_1.find( "menu_cd = '" + l_s_menu_cd + "'", 1, l_n_rowcount) <> l_n_row then
					l_s_errchk	=	'Y'
				end if
			end if
		next
	end if
	
	if f_spacechk(l_s_menu_cd) = -1 or len(l_s_menu_cd) <>  4 or &
		mid(i_s_click_cd,1,1) <> l_s_menu_cd2 or l_s_errchk	=	'Y'	then
		l_s_error 	=	'1'
	else
		l_s_error 	=	' '
   end if

	if f_spacechk(l_s_win_id)  = -1 or &
	  	(l_s_menu_cd4 = '0' 	and l_s_win_id <> '.') 	 or &
		(l_s_menu_cd4 <> '0' and len(l_s_win_id) < 9)  then
		l_s_error 	=	l_s_error + '1'
	else
		l_s_error 	=	l_s_error + ' '
   end if
	
	if f_spacechk(l_s_win_nm)  = -1 then
		l_s_error 	=	l_s_error + '1'
	else
		l_s_error 	=	l_s_error + ' '
   end if
	
	if f_spacechk(l_s_win_st)  = -1  then
		l_s_error 	=	l_s_error + '1'
	else
		l_s_error 	=	l_s_error + ' '
   end if

	dw_1.object.cp_chk[l_n_row] = l_s_error
next

wf_rgbset("menu_cd", 1, 1)
wf_rgbset("win_id",  2, 2)
wf_rgbset("win_nm",  3, 2)
wf_rgbset("win_st",  4, 2)

dw_1.SetRedraw(False)
l_s_column	=	''
l_s_error   =  ''
for l_n_row = 1 to l_n_rowcount
	l_s_error	= 	dw_1.getitemstring(l_n_row, "cp_chk")
	l_s_menu_cd	= 	dw_1.getitemstring(l_n_row, "menu_cd")
	if f_spacechk(l_s_error) =	0 then
		l_n_findrow = dw_1.find("MENU_CD = '" + l_s_menu_cd + "'", 1, dw_1.rowcount() )
		if l_n_findrow > 0 then
			dw_1.scrolltorow(l_n_findrow)
		end if
		
		if mid(l_s_error, 1, 1) = "1" then
			if f_spacechk(l_s_column)	= 	-1  then
				l_s_column  =	"menu_cd"
				exit
			end if
		elseif mid(l_s_error, 2, 1)	= 	"1" then
			if f_spacechk(l_s_column) 	= 	-1	 then
				l_s_column  =	"win_id"
				exit
			end if
		elseif mid(l_s_error, 3, 1)	= 	"1" then
			if f_spacechk(l_s_column) 	= 	-1	 then
				l_s_column  =	"win_nm"
				exit
			end if
		elseif mid(l_s_error, 4, 1)	= 	"1" then
			if f_spacechk(l_s_column) 	= 	-1	 then
				l_s_column  =	"win_st"
				exit
			end if
		end if
	end if
next
dw_1.SetRedraw(True)

if len(l_s_column) > 0  then									// Editing Error
	dw_1.setrow(l_n_row)
	dw_1.setcolumn(l_s_column)
	dw_1.setfocus()
	uo_status.st_message.text	=  f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	return
end if

if dw_1.ModifiedCount() = 0 then
	dw_1.setfocus()
   uo_status.st_message.text	=  f_message("E020")		// 변경내용이 없습니다.
   return
end if

setpointer(hourglass!)
f_sysdate()
l_n_rowcount = dw_1.rowcount()

for l_n_row = 1 to l_n_rowcount
	
	if dw_1.GetItemStatus (l_n_row, 0 , primary!) = NewModified! then
	 	l_s_menu_cd	=	dw_1.getitemstring(l_n_row, "menu_cd")		
		dw_1.object.inpt_id[l_n_row] 		= 	g_s_empno
		dw_1.object.inpt_dt[l_n_row] 		= 	g_s_datetime
		wf_server_update(dw_1,l_n_row,'A')
	end if
	
	dw_1.setitemstatus(l_n_row, "cp_chk", primary!, NotModified!)
	
	if dw_1.GetItemStatus (l_n_row, 0, primary!) = DataModified! then
		l_s_menu_cd	=	dw_1.getitemstring(l_n_row, "menu_cd")				
		dw_1.object.updt_id[l_n_row]		= 	g_s_empno
		dw_1.object.updt_dt[l_n_row] 		= 	g_s_datetime
		dw_1.object.ip_addr[l_n_row] 		= 	g_s_ipaddr
		dw_1.object.mac_addr[l_n_row]		= 	g_s_macaddr
		wf_server_update(dw_1,l_n_row,'R')		
	end if
next

dw_1.SetRedraw(False)

if dw_1.update() = 1 then
	commit using sqlca;
   uo_status.st_message.text	=  f_message("U010")	// 저장되었습니다. 
	dw_1.retrieve(i_s_click_cd + '%')
	l_n_findrow = dw_1.find("MENU_CD = '" + l_s_menu_cd + "'", 1, dw_1.rowcount())
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
	end if

	i_b_dprint	=	True	
else
	i_n_erreturn = -1
	rollback using SQLCA;
   uo_status.st_message.text	=  f_message("U020")	// [저장 실패] 정보시스템팀으로 연락바랍니다. 
end if
dw_1.SetRedraw(True)

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

event ue_dprint;call super::ue_dprint;dw_1.Print()
end event

type uo_status from w_origin_sheet01`uo_status within w_comm101u
integer taborder = 10
end type

type dw_1 from datawindow within w_comm101u
event ue_enter pbm_dwnkey
integer x = 18
integer y = 272
integer width = 4585
integer height = 2212
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_comm101u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;//RETURN 1
end event

event itemerror;RETURN 1
end event

event constructor;this.settransobject(sqlca)
end event

type gb_1 from groupbox within w_comm101u
integer x = 32
integer y = 32
integer width = 1184
integer height = 200
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type st_1 from statictext within w_comm101u
integer x = 96
integer y = 100
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "단위업무"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_comm101u
integer x = 457
integer y = 84
integer width = 690
integer height = 96
boolean bringtotop = true
string dataobject = "dddw_comm110_c01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;i_s_click_cd	=	left(dw_child1.getitemstring(dw_child1.getrow(), "menu_cd"), 2)
end event

