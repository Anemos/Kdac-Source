$PBExportHeader$w_comm101n.srw
$PBExportComments$Program 등록
forward
global type w_comm101n from w_origin_sheet01
end type
type dw_1 from datawindow within w_comm101n
end type
type tv_1 from treeview within w_comm101n
end type
type dw_wait from datawindow within w_comm101n
end type
end forward

global type w_comm101n from w_origin_sheet01
integer height = 2720
string title = "프로그램 정보"
dw_1 dw_1
tv_1 tv_1
dw_wait dw_wait
end type
global w_comm101n w_comm101n

type variables
Datastore 	i_ds_data[]
long     	ii_LastRow
string		is_retrieve_value

end variables

forward prototypes
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public subroutine wf_add_picture (treeview ag_tvcurrent)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color)
public subroutine wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew)
public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun)
end prototypes

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);TreeViewItem	l_tvi_New
Integer			l_n_Cnt

For	l_n_Cnt	=	1	To		ag_Rows
		wf_set_items(ag_Level, l_n_Cnt, l_tvi_New)
		If 	ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
			Return -1
		End If
Next

Return 	ag_Rows

end function

public subroutine wf_add_picture (treeview ag_tvcurrent);ag_tvcurrent.PictureHeight = 15
ag_tvcurrent.PictureWidth = 16

ag_tvcurrent.AddPicture("Library!")
ag_tvcurrent.AddPicture("DosEdit!")
ag_tvcurrent.AddPicture("Custom050!")
ag_tvcurrent.AddStatePicture("Save!")

end subroutine

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			l_n_Level, l_n_rows
string			l_s_Parm
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

// Determine the Retrieval arguments for the new data

Choose Case l_n_Level
	case 1
		l_s_Parm = mid(string(l_tvi_Current.Data),1,1)
		i_ds_Data[2].reset()
		l_n_rows = i_ds_Data[2].Retrieve(l_s_Parm)
		wf_add_items(ag_handle,1,l_n_rows,ag_tvcurrent)
	case 2
		l_s_Parm = mid(string(l_tvi_Current.Data),1,2)
		i_ds_Data[3].reset()
		l_n_rows = i_ds_Data[3].Retrieve(l_s_Parm)
		wf_add_items(ag_handle,2,l_n_rows,ag_tvcurrent)
end choose

end subroutine

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	li_Idx, li_last_row

li_last_row = ii_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If li_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if li_last_row > al_aclickedrow then
	For li_Idx = li_last_row to al_aclickedrow STEP -1
		dw.selectrow(li_Idx,TRUE)	
	end for	
else
	For li_Idx = li_last_row to al_aclickedrow 
		dw.selectrow(li_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
dw_1.setredraw(False)
if ag_n_color 	= 	1	then
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(255,255,0), 15780518)'"
else
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(255,255,255))'"
end if

dw_1.Modify(l_s_command)
dw_1.setredraw(True)

end subroutine

public subroutine wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew);// Set the Lable and Data attributes for the new item from the data in the DataStore

Integer	l_n_Picture

Choose Case ag_Level
	Case 1
		ag_tviNew.Label = i_ds_Data[2].Object.win_nm[ag_row]
		ag_tviNew.Data  = i_ds_Data[2].Object.menu_cd[ag_Row]
		ag_tviNew.expanded = false
		ag_tviNew.children = true
	Case 2
		ag_tviNew.Label = i_ds_Data[3].Object.win_nm[ag_row]
		ag_tviNew.Data  = i_ds_Data[3].Object.menu_cd[ag_Row]
		ag_tviNew.expanded = false
		ag_tviNew.children = false
End Choose
ag_tviNew.SelectedPictureIndex = 4
ag_tviNew.PictureIndex = ag_Level
end subroutine

public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun);Integer 	ln_rcnt,i,ln_count
String		ls_area,ls_after_menu_cd,ls_before_menu_cd,ls_winid,ls_winnm,ls_winrpt,ls_winst,ls_chgdate 

ls_before_menu_cd	= 	a_dw.getitemstring(a_row,'menu_cd',primary!,true)
ls_after_menu_cd  		= 	a_dw.getitemstring(a_row,'menu_cd',primary!,false)
ls_winid  				= 	a_dw.object.win_id[a_row]
ls_winnm  				= 	a_dw.object.win_nm[a_row]	
ls_winrpt 				= 	a_dw.object.win_rpt[a_row]
ls_winst  				=	a_dw.object.win_st[a_row]

If	a_gubun = 'D' 	then	
	Select count(*)	Into	:ln_count		From pbcommon.comm110
	where menu_cd = :ls_after_menu_cd		Using Sqlca	;
	If	ln_count	<>	1	Then
		messagebox("확인",	ls_after_menu_cd	+	" 메뉴 코드가 존재하지 않습니다.")	
		return
	End if
ElseIf	a_gubun = 'R'	then	
	Select count(*)	Into	:ln_count		From pbcommon.comm110
	where menu_cd	= 	:ls_before_menu_cd	Using Sqlca	;
	If	ln_count	<>	1	Then
		messagebox("확인",	ls_before_menu_cd	+	" 메뉴 코드가 존재하지 않습니다.")
		return
	End if
ElseIf	a_gubun = 'A'	then	
	Select count(*)	Into	:ln_count		From pbcommon.comm110
	where menu_cd = :ls_after_menu_cd		Using Sqlca	;
	If	ln_count	<>	0	Then
		messagebox("확인",	ls_after_menu_cd	+	" 메뉴 코드가 이미 존재합니다.")
		return
	End if
End if
SELECT	CHAR(CURRENT TIMESTAMP) Into :ls_chgdate	FROM 	PBCOMMON.COMM000 
FETCH	FIRST 1 ROWS ONLY
Using Sqlca	;
		
Insert Into pbcommon.comm110his values
( 	:ls_after_menu_cd,:ls_chgdate,'',:a_gubun,:ls_winid,:ls_winnm,
	:ls_winrpt,:ls_winst,:g_s_empno ,:g_s_ipaddr,:g_s_macaddr,:ls_before_menu_cd )
Using SQLCA ;

//	if a_gubun = 'D' then
//		if sqlxx.dbms = "ODBC" then
//			delete from pbcommon.comm110
//				where menu_cd = :ls_after_menu_cd using sqlxx ;
//		else
//			delete from comm110
//				where menu_cd = :ls_after_menu_cd using sqlxx ;
//		end if
//	elseif a_gubun = 'R' then
//		if sqlxx.dbms = "ODBC" then
//			update pbcommon.comm110
//				set menu_cd = :ls_after_menu_cd,win_id  = :ls_winid ,win_nm = :ls_winnm,
//					 win_rpt = :ls_winrpt,win_st = :ls_winst,updt_id = 'ADMIN',
//					 updt_dt = :g_s_datetime
//			where menu_cd  = :ls_before_menu_cd using sqlxx ;
//		else
//			update comm110
//				set menu_cd = :ls_after_menu_cd,win_id  = :ls_winid ,win_nm = :ls_winnm,
//					 win_rpt = :ls_winrpt,win_st = :ls_winst,updt_id = 'ADMIN',
//					 updt_dt = :g_s_datetime
//			where menu_cd  = :ls_before_menu_cd using sqlxx ;
//		end if
//   elseif a_gubun = 'A' then
//		if sqlxx.dbms = "ODBC" then
//			insert into pbcommon.comm110 values
//				( :ls_after_menu_cd,:ls_winid,:ls_winnm,:ls_winrpt,:ls_winst,'ADMIN',
//				  :g_s_datetime,'ADMIN' ,:g_s_datetime ,:g_s_ipaddr,:g_s_macaddr )
//			using sqlxx ;
//		else
//			insert into comm110 values
//				( :ls_after_menu_cd,:ls_winid,:ls_winnm,:ls_winrpt,:ls_winst,'ADMIN',
//				  :g_s_datetime,'ADMIN' ,:g_s_datetime ,:g_s_ipaddr,:g_s_macaddr )
//			using sqlxx ;
//		end if
//	end if
	
end subroutine

on w_comm101n.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.tv_1=create tv_1
this.dw_wait=create dw_wait
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.dw_wait
end on

on w_comm101n.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.tv_1)
destroy(this.dw_wait)
end on

event ue_insert;Integer	ln_row

uo_status.st_message.text	= ""
ln_row	=	dw_1.insertrow(0)
dw_1.setfocus()
dw_1.ScrollToRow(ln_row)
dw_1.Setcolumn("menu_cd")

end event

event ue_delete;Integer 	ln_row, ln_yesno, ln_rowcount,ln_findrow,ln_pos
String  	ls_menucd, ls_menucd4

uo_status.st_message.text	= ""
dw_1.accepttext()
ln_row 			=	dw_1.getselectedrow(0)
ln_rowcount 	= 	dw_1.rowcount()
if 	ln_row <> 0 then
	ln_yesno = messagebox("삭제확인", "선택된 메뉴(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
	if 	ln_yesno <> 1 then
		uo_status.st_message.text 	= f_message("D030")
		return 
	end if
else
	uo_status.st_message.text 		= f_message("D100")
	return 
end if
do until	ln_row = 0 
	ln_pos		= 	pos(trim(dw_1.getitemstring(ln_row, "menu_cd")),'0')
	if 	ln_pos	=	0	then
		ln_pos	=	5
	end if
	ls_menucd	=	mid(trim(dw_1.getitemstring(ln_row, "menu_cd")),1,ln_pos - 1) + '%'
	select 	count(menu_cd)	into	:ln_findrow	from	comm110
	where	menu_cd like :ls_menucd 
	using 		sqlpis ;
	if 	ln_findrow > 1 then
		uo_status.st_message.text	=  '단위업무에 메뉴가 딸린경우 단위업무를 삭제할 수 없습니다.'  
	end if
	if 	dw_1.GetItemStatus(ln_row,"menu_cd", Primary!) <> NewModified!	then
		wf_server_update(dw_1,ln_row,'D')
	else
		uo_status.st_message.text		=  	f_message("D040")	// 삭제할수없습니다.		
	end if
	ln_row	=	dw_1.getselectedrow(ln_row)
loop
dw_1.reset()
dw_1.retrieve(is_retrieve_value)

end event

event open;call super::open;TreeViewItem	l_tvi_Root
treeview 	   		l_tv_Current
integer 			k,ln_rows,ln_root

Setpointer(hourglass!)

i_ds_Data[1]	=	Create DataStore
i_ds_Data[1].DataObject	=	"d_menu_00"	 
i_ds_Data[2] 	= 	Create DataStore
i_ds_Data[2].DataObject 	= 	"d_menu_01"	 
i_ds_Data[3] 	= 	Create DataStore
i_ds_Data[3].DataObject 	= 	"d_menu_02"	
 
Integer	ln_cnt

For 	ln_Cnt = 1 To 3
		i_ds_Data[ln_Cnt].SetTransObject(sqlpis)
Next

dw_1.settransobject(Sqlpis)
dw_1.reset()
ln_Rows	=	i_ds_Data[1].Retrieve()

For	k = 1 to ln_rows
		l_tvi_Root.Label 	= 	i_ds_Data[1].object.win_nm[k] + " (" + i_ds_Data[1].object.menu_cd[k] + ") "
		l_tvi_Root.Data  	= 	i_ds_Data[1].object.menu_cd[k]
		l_tvi_Root.PictureIndex	=	1
		l_tvi_Root.SelectedPictureIndex	=	1
		i_ds_data[2].reset()
		if 	i_ds_data[2].retrieve(mid(l_tvi_Root.Data,1,1)) > 0 then
			l_tvi_Root.Children = True
		else
			l_tvi_Root.Children = false
		end if
		ln_root = tv_1.insertitemlast(0,l_tvi_root)
	//	tv_1.expanditem(ln_root)
next
i_b_retrieve 		=	true  
i_b_insert 		= 	true
i_b_delete 		= 	true
i_b_save 		=	true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
timer(0)
timer(30)



end event

event ue_save;String		ls_menu_cd,  ls_menu_cd2,	ls_menu_cd4, ls_win_id,  	ls_win_nm, &
			ls_win_st,   ls_column, 		ls_error,	 ls_errchk	
Integer  	ln_rowcount, ln_row,      	ln_row2,	 ln_findrow,	ln_idx

uo_status.st_message.text	= ""
dw_1.accepttext() 
setpointer(Hourglass!)

ln_rowcount 	=	dw_1.rowcount()
for		ln_row	= 	1	to	ln_rowcount
		ls_error			=	''
		ls_menu_cd		= 	trim(dw_1.getitemstring(ln_row, "menu_cd"))
		ls_menu_cd2	= 	left(trim(dw_1.getitemstring(ln_row, "menu_cd")), 1)
		ls_menu_cd4	= 	right(trim(dw_1.getitemstring(ln_row, "menu_cd")), 1)
		ls_win_id			= 	trim(dw_1.getitemstring(ln_row, "win_id"))
		ls_win_nm		= 	trim(dw_1.getitemstring(ln_row, "win_nm"))
		ls_win_st			= 	trim(dw_1.getitemstring(ln_row, "win_st"))
		ls_errchk			=	''	
		//--	동일 메뉴코드가 입력된 경우 ( Duplicate ) 
		if 	dw_1.GetItemStatus (ln_row, 0, primary!) <> NotModified! then
			for	ln_idx	=	1 to ln_rowcount
				if 	ln_idx <> ln_row then
					if 	dw_1.find( "menu_cd = '" + ls_menu_cd + "'", 1, ln_rowcount) <> ln_row then
						ls_errchk	=	'Y'
					end if
				end if
			next
		end if
		if 	f_spacechk(ls_win_id)  = -1	or	(ls_menu_cd4 <> 	'0' and len(ls_win_id) < 9)  then
			ls_error 	=	ls_error + '1'
		else
			ls_error 	=	ls_error + ' '
		end if
		
		if 	f_spacechk(ls_win_nm)  = -1 then
			ls_error 	=	ls_error + '1'
		else
			ls_error 	=	ls_error + ' '
		end if
		dw_1.object.cp_chk[ln_row]	=	ls_error
next
wf_rgbset("menu_cd", 1, 1)
wf_rgbset("win_id",  2, 1)
wf_rgbset("win_nm",  3, 1)
wf_rgbset("win_st",  4, 1)

dw_1.SetRedraw(False)
ls_column	=	''
ls_error   	=	''
for		ln_row	=	1	to	ln_rowcount
		ls_error		= 	dw_1.getitemstring(ln_row, "cp_chk")
		ls_menu_cd	= 	dw_1.getitemstring(ln_row, "menu_cd")
		if 	f_spacechk(ls_error) =	0 then
			ln_findrow = dw_1.find("MENU_CD = '" + ls_menu_cd + "'", 1, dw_1.rowcount() )
			if 	ln_findrow > 0 then
				dw_1.scrolltorow(ln_findrow)
			end if
			
			if 	mid(ls_error, 1, 1) = "1" then
				if 	f_spacechk(ls_column)	= 	-1  then
					ls_column  =	"menu_cd"
					exit
				end if
			elseif mid(ls_error, 2, 1)	= 	"1" then
				if 	f_spacechk(ls_column) 	= 	-1	 then
					ls_column  =	"win_id"
					exit
				end if
			elseif mid(ls_error, 3, 1)	= 	"1" then
				if 	f_spacechk(ls_column) 	= 	-1	 then
					ls_column  =	"win_nm"
					exit
				end if
			elseif mid(ls_error, 4, 1)	= 	"1" then
				if 	f_spacechk(ls_column) 	= 	-1	 then
					ls_column  =	"win_st"
					exit
				end if
			end if
		end if
next
dw_1.SetRedraw(True)
if 	len(ls_column) > 0  then									// Editing Error
	dw_1.setrow(ln_row)
	dw_1.setcolumn(ls_column)
	dw_1.setfocus()
	uo_status.st_message.text	=  f_message("E010")		// 필수 항목을 수정 후 처리바랍니다.	
	return
end if

if 	dw_1.ModifiedCount() = 0 then
	dw_1.setfocus()
   	uo_status.st_message.text	=  f_message("E020")		// 변경내용이 없습니다.
   	return
end if
f_sysdate()
ln_rowcount	=	dw_1.rowcount()
for		ln_row	=	1	to	ln_rowcount
		if	dw_1.GetItemStatus (ln_row, 0 , primary!) = NewModified! then
			ls_menu_cd	=	dw_1.getitemstring(ln_row, "menu_cd")		
			dw_1.object.inpt_id[ln_row] 		= 	g_s_empno
			dw_1.object.inpt_dt[ln_row] 		= 	g_s_datetime
			wf_server_update(dw_1,ln_row,'A')
		end if
		dw_1.setitemstatus(ln_row, "cp_chk", primary!, NotModified!)
		if 	dw_1.GetItemStatus(ln_row, 0, primary!)	=	DataModified! then
			ls_menu_cd		=	dw_1.getitemstring(ln_row, "menu_cd")				
			dw_1.object.updt_id[ln_row]		= 	g_s_empno
			dw_1.object.updt_dt[ln_row] 		= 	g_s_datetime
			dw_1.object.ip_addr[ln_row] 		= 	g_s_ipaddr
			dw_1.object.mac_addr[ln_row]	= 	g_s_macaddr
			wf_server_update(dw_1,ln_row,'R')		
		end if
next
dw_1.reset()
dw_1.retrieve(is_retrieve_value)
dw_wait.retrieve('',g_s_empno)

end event

event activate;call super::activate;Integer	ln_cnt

For 	ln_cnt = 1 To 3
		i_ds_Data[ln_cnt].SetTransObject(sqlpis)
Next
dw_1.settransobject(sqlpis)
f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
dw_wait.retrieve('',g_s_empno)


end event

event ue_retrieve;call super::ue_retrieve;Long	tvi_hdl = 0

Do Until	tv_1.FindItem(RootTreeItem!, 0) = -1
	tv_1.DeleteItem(tvi_hdl)
Loop
this.triggerevent("open")
end event

event timer;call super::timer;//승인대기 List 조회
SetPointer(HourGlass!)
f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
dw_wait.retrieve('',g_s_empno)
SetPointer(Arrow!)
end event

type uo_status from w_origin_sheet01`uo_status within w_comm101n
integer taborder = 40
end type

type dw_1 from datawindow within w_comm101n
event ue_enter pbm_dwnkey
integer x = 1385
integer y = 28
integer width = 3237
integer height = 1624
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "사용중 프로그램 List"
string dataobject = "d_comm101u_01_new"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;//RETURN 1
end event

event itemerror;RETURN 1
end event

event clicked;if 	row	<=	0	then
	return
end if

If	Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if 	this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow	=	row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If

end event

type tv_1 from treeview within w_comm101n
integer x = 9
integer y = 28
integer width = 1371
integer height = 2456
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"Custom039!","Custom039!","Custom039!"}
long picturemaskcolor = 268435456
long statepicturemaskcolor = 536870912
end type

event clicked;Integer			ln_Level
TreeViewItem	l_tvi_Current

// Determine the level
setpointer(hourglass!)
dw_1.reset()
is_retrieve_value	=	''
tv_1.GetItem(handle, l_tvi_Current)
ln_Level = l_tvi_Current.Level
if ln_level < 4 then
	is_retrieve_value	=	mid(l_tvi_Current.Data, 1, ln_level) + '%'
	dw_1.retrieve(is_retrieve_value)
end if
 
end event

event constructor;treeview	l_tv_current

l_tv_current	= this

wf_add_picture(l_tv_current)
end event

event itempopulate;Integer			ln_level
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

// Determine the level
setpointer(hourglass!)
is_retrieve_value	=	''
tv_1.GetItem(handle, l_tvi_Current)
ln_level = l_tvi_Current.Level
if ln_level >= 4 then return
wf_itempopulate(handle, tv_1)
if ln_level < 4 then
	dw_1.reset()
	is_retrieve_value	=	mid(l_tvi_Current.Data, 1, ln_level) + '%'
	dw_1.retrieve(is_retrieve_value)
end if

end event

event selectionchanged;Integer			ln_Level
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

// Determine the level
setpointer(hourglass!)
tv_1.GetItem(newhandle, l_tvi_Current)
dw_1.reset()
is_retrieve_value	=	''
ln_Level = l_tvi_Current.Level
if ln_level < 4 then
	is_retrieve_value	=	mid(l_tvi_Current.Data, 1, ln_level) + '%'
	dw_1.retrieve(is_retrieve_value)
end if

end event

type dw_wait from datawindow within w_comm101n
integer x = 1399
integer y = 1664
integer width = 3214
integer height = 820
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "승인대기 프로그램 List - 자동 조회 (30초마다)"
string dataobject = "d_comm110his_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

