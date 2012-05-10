$PBExportHeader$w_comm111u.srw
$PBExportComments$부서 단위 팀장 사용가능 Window
forward
global type w_comm111u from w_origin_sheet01
end type
type gb_1 from groupbox within w_comm111u
end type
type dw_menu from datawindow within w_comm111u
end type
type dw_3 from datawindow within w_comm111u
end type
type dw_1 from datawindow within w_comm111u
end type
type dw_2 from datawindow within w_comm111u
end type
type st_dept from statictext within w_comm111u
end type
type p_1 from picture within w_comm111u
end type
type p_2 from picture within w_comm111u
end type
type p_3 from picture within w_comm111u
end type
type dw_win_id from datawindow within w_comm111u
end type
type gb_2 from groupbox within w_comm111u
end type
type sle_dept from singlelineedit within w_comm111u
end type
type cb_copy from commandbutton within w_comm111u
end type
type dw_5 from datawindow within w_comm111u
end type
end forward

global type w_comm111u from w_origin_sheet01
integer height = 2752
event ue_keydown pbm_keydown
gb_1 gb_1
dw_menu dw_menu
dw_3 dw_3
dw_1 dw_1
dw_2 dw_2
st_dept st_dept
p_1 p_1
p_2 p_2
p_3 p_3
dw_win_id dw_win_id
gb_2 gb_2
sle_dept sle_dept
cb_copy cb_copy
dw_5 dw_5
end type
global w_comm111u w_comm111u

type variables
Boolean				ib_down
String  				is_selected,	is_emp_no
String  				is_menu_cd,	is_sql_select,is_getfocus	=	'0'
Integer				ii_LastRow
DataWindowChild 	child_menu
end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color)
public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun, string a_inputdetail)
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
end prototypes

event ue_keydown;if	key	=	keyenter!		then
	p_1.triggerevent("clicked")
end if
end event

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color);
end subroutine

public subroutine wf_server_update (datawindow a_dw, integer a_row, string a_gubun, string a_inputdetail);
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

on w_comm111u.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_menu=create dw_menu
this.dw_3=create dw_3
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_dept=create st_dept
this.p_1=create p_1
this.p_2=create p_2
this.p_3=create p_3
this.dw_win_id=create dw_win_id
this.gb_2=create gb_2
this.sle_dept=create sle_dept
this.cb_copy=create cb_copy
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_menu
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_dept
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.p_3
this.Control[iCurrent+10]=this.dw_win_id
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.sle_dept
this.Control[iCurrent+13]=this.cb_copy
this.Control[iCurrent+14]=this.dw_5
end on

on w_comm111u.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_menu)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_dept)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.dw_win_id)
destroy(this.gb_2)
destroy(this.sle_dept)
destroy(this.cb_copy)
destroy(this.dw_5)
end on

event open;call super::open;Setpointer(hourglass!)

DataWindowChild child_wkcd

//업무조회
dw_menu.GetChild("win_nm", child_menu)
child_menu.settransobject(sqlca)
child_menu.retrieve()
dw_menu.insertrow(0)


//Icon 제어(조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자)
i_b_retrieve		=	false
i_b_insert		=	false
i_b_save			=	false
i_b_delete		=	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              	   i_b_dprint,   i_b_dchar)

 
end event

event activate;call super::activate;f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)

end event

event ue_retrieve;call super::ue_retrieve;string	ls_win_id,ls_dept
long	ln_row
 
ln_row	=	dw_3.getselectedrow(0)
if	ln_row	>	0	then
	ls_win_id	=	trim(dw_3.object.win_id[ln_row])
	dw_win_id.visible		=	true
	dw_win_id.enabled	=	true
	dw_win_id.reset()
	dw_win_id.retrieve(ls_win_id)
else
	uo_status.st_message.text = "선택된 Window ID가 없습니다. 선택 후 작업하세요"
end if



end event

type uo_status from w_origin_sheet01`uo_status within w_comm111u
integer y = 2524
end type

type gb_1 from groupbox within w_comm111u
integer x = 3488
integer width = 763
integer height = 184
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "[업무조회]"
end type

type dw_menu from datawindow within w_comm111u
integer x = 3529
integer y = 64
integer width = 681
integer height = 96
integer taborder = 90
boolean bringtotop = true
string dataobject = "dddw_comm110_c01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;is_menu_cd	=	left(child_menu.getitemstring(child_menu.getrow(), "menu_cd"), 2)

Setpointer(hourglass!)
dw_3.retrieve(is_menu_cd)
end event

type dw_3 from datawindow within w_comm111u
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 3113
integer y = 196
integer width = 1490
integer height = 2308
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

event ue_mousemove;if	ib_down	then	this.Drag (begin!)


end event

event clicked;if 	row	<	1	then
	return
end if

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

event constructor;this.settransobject(Sqlca)
end event

event rbuttondown;MenuWinId NewMenu

NewMenu = CREATE MenuWinId
NewMenu.m_winid.PopMenu( parent.pointerx(), parent.pointery() + 200 )

destroy MenuWinId

end event

type dw_1 from datawindow within w_comm111u
integer x = 9
integer y = 196
integer width = 1408
integer height = 2308
integer taborder = 30
string dataobject = "d_comm111u_dept"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long	i
string	ls_dept  

if	dwo.name	=	'sel_col_t'		then
	if	this.object.sel_col_t.text	=	'전체선택'	then
		this.object.sel_col_t.text	=	'선택해제'
		for		i =	 1	to	this.rowcount()
				this.object.sel_col[i]	=	'Y'
		next	
	elseif	this.object.sel_col_t.text	=	'선택해제'	then
		this.object.sel_col_t.text		=	'전체선택'
		for		i =	 1	to	this.rowcount()
				this.object.sel_col[i]	=	'N'
		next	
	end if
end if

this.accepttext()

if 	row <= 0 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)

ls_dept	=	this.object.dcode[row] 
dw_2.reset()
if	dw_2.retrieve(ls_dept)	>	0	then
	cb_copy.enabled	=	true
else
	cb_copy.enabled	=	false
end if

//If Keydown(KeyShift!) then
////	wf_Shift_Highlight(row, this)
//ElseIf Keydown(KeyControl!) then
//	ii_LastRow = row
//	if this.IsSelected(row) Then
//		this.SelectRow(row,FALSE)
//	else
//		this.SelectRow(row,TRUE)
//	end if	
//Else
//	ii_LastRow = row
//	this.SelectRow(0, FALSE)
//	this.SelectRow(row, TRUE)
//End If
//
end event

event losefocus;//cb_2.enabled = false
end event

event constructor;this.settransobject(sqlca)
end event

type dw_2 from datawindow within w_comm111u
integer x = 1422
integer y = 196
integer width = 1659
integer height = 2308
integer taborder = 60
string dataobject = "d_comm111u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if 	row < 1 then
	return
end if

If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
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

event dragdrop;long 	 	ln_insrow, ln_sel3row
string	 	ls_win_id,ls_win_nm

if	dw_1.Find( "sel_col = 'Y'", 1, dw_1.RowCount())	<	1	then
	messagebox("확인","신규 등록시 반드시 하나이상의 부서를 선택하시기 바랍니다")
	return
end if

ln_sel3row 	= 	dw_3.getselectedrow(0)
//자료이동
ls_win_nm	=	dw_3.getitemstring(ln_sel3row, "win_nm")	// 개인번호
ls_win_id  	= 	dw_3.getitemstring(ln_sel3row, "win_id")		// Window Id

ln_insrow		=	this.insertrow(0)
this.object.win_nm[ln_insrow]					=	ls_win_nm
this.object.comm111_win_id[ln_insrow]		= 	ls_win_id

//this.object.win_nm.color							=	rgb(255,0,0)
//this.object.comm111_win_id.color				=	rgb(255,0,0)
end event

event constructor;//this.SetRowFocusIndicator(FocusRect!)
this.settransobject(sqlca)
end event

type st_dept from statictext within w_comm111u
integer x = 41
integer y = 84
integer width = 457
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8388608
long backcolor = 12632256
string text = "부서명 검색어 :"
boolean focusrectangle = false
end type

type p_1 from picture within w_comm111u
integer x = 1111
integer y = 76
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\조회.gif"
boolean focusrectangle = false
end type

event clicked;string		ls_dept

ls_dept	=	'%'	+	trim(sle_dept.text)	+	'%'
if	trim(sle_dept.text)	=	''	then	ls_dept	=	'%'

dw_1.reset()
dw_2.reset()
if	dw_1.retrieve(ls_dept)	>	0	then
	uo_status.st_message.text = "조회 완료"
else
	uo_status.st_message.text = "조회할 정보가 없습니다"
end if
end event

type p_2 from picture within w_comm111u
integer x = 1440
integer y = 76
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\삭제.gif"
boolean focusrectangle = false
end type

event clicked;long		ln_row,ln_yesno
string		ls_dept,ls_win_id

Setpointer(HourGlass!)

ln_row	=	dw_2.getselectedrow(0)
if 	ln_row 	<> 	0 then
	ln_yesno	=	messagebox("삭제확인", "선택된 윈도우 ID(들)를 삭제하시겠습니까 ?",Question!,OkCancel!,2)
	if 	ln_yesno 	<>	1 then
		uo_status.st_message.text		=	f_message("D030")
		return 0
	end if
else
	uo_status.st_message.text			=	f_message("D100")
	return 0
end if

do until ln_row = 0 
	ls_win_id		=	trim(dw_2.object.comm111_win_id[ln_row])
	ls_dept		=	trim(dw_2.object.dept_cd[ln_row])
	delete	from	pbcommon.comm111
		where		dept_cd	=	:ls_dept	and	win_id	=	:ls_win_id
	using		sqlca ;
	uo_status.st_message.text = "삭제 완료"
	ln_row = dw_2.getselectedrow(ln_row)
loop	

dw_2.reset()
dw_2.retrieve(dw_1.object.dcode[dw_1.getselectedrow(0)] )


end event

type p_3 from picture within w_comm111u
integer x = 1760
integer y = 76
integer width = 265
integer height = 84
boolean bringtotop = true
string picturename = "C:\KDAC\bmp\저장.gif"
boolean focusrectangle = false
end type

event clicked;long	ln_count,ln_row_dw_2,ln_row_dw_1,ln_row
string	ls_dept,ls_win_id,ls_use

Setpointer(HourGlass!)
uo_status.st_message.text = ""

ln_row	=	dw_2.rowcount()
for		ln_row_dw_2 = 1 to ln_row
		if 	dw_2.GetItemStatus (ln_row_dw_2, 0, primary!) = NewModified! then
			if	dw_1.Find( "sel_col = 'Y'", 1, dw_1.RowCount())	<	1	then
				messagebox("확인","신규 등록시 반드시 하나이상의 부서를 선택하시기 바랍니다")
				return
			end if
			for		ln_row_dw_1	=	1	to	dw_1.rowcount()
					if	trim(dw_1.object.sel_col[ln_row_dw_1])	=	'Y'	then
						ls_dept		=	trim(dw_1.object.dcode[ln_row_dw_1])
						ls_win_id		=	trim(dw_2.object.comm111_win_id[ln_row_dw_2])
						ls_use			=	trim(dw_2.object.comm111_win_st[ln_row_dw_2])
						
						select	count(*)	into	:ln_count		from	pbcommon.comm111
						where	dept_cd	=	:ls_dept	and win_id	=	:ls_win_id	using	sqlca ;
						
						if	ln_count	>	0	then
							update	pbcommon.comm111
								set		win_st	=	:ls_use,	updt_id	=	:g_s_empno,	updt_dt	=	:g_s_date,ip_addr	=	:g_s_ipaddr,	mac_addr	=	:g_s_macaddr
							where		dept_cd	=	:ls_dept	and win_id	=	:ls_win_id
							using		sqlca	;
						else
							insert	into	pbcommon.comm111
							values	(:ls_dept,	:ls_win_id,	:ls_use,	:g_s_empno,		:g_s_date,	:g_s_empno,		:g_s_date,	:g_s_ipaddr,	:g_s_macaddr )
							using		sqlca ;							
						end if
					end if
			next
		elseif	dw_2.GetItemStatus(ln_row_dw_2, 0, primary!) = DataModified! then
			ls_dept		=	trim(dw_2.object.comm111_dept_cd[ln_row_dw_2])
			ls_win_id		=	trim(dw_2.object.comm111_win_id[ln_row_dw_2])
			ls_use			=	trim(dw_2.object.comm111_win_st[ln_row_dw_2])
			update	pbcommon.comm111
				set		win_st	=	:ls_use,	updt_id	=	:g_s_empno,	updt_dt	=	:g_s_date,ip_addr	=	:g_s_ipaddr,	mac_addr	=	:g_s_macaddr
			where		dept_cd	=	:ls_dept	and	win_id	=	:ls_win_id
			using		sqlca	;
		end if
next
uo_status.st_message.text = "저장 완료"

dw_2.reset()
dw_2.retrieve(dw_1.object.dcode[dw_1.getselectedrow(0)] )

end event

type dw_win_id from datawindow within w_comm111u
boolean visible = false
integer x = 1221
integer y = 92
integer width = 2135
integer height = 1340
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "일괄 변경"
string dataobject = "d_comm111u_02"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "C:\KDAC\kdac.ico"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.visible	=	false
this.enabled	=	false
end event

event buttonclicked;this.accepttext()

if	dwo.name	=	'b_save'	then
	if	this.update()	<>	1	then
		messagebox("확인","일괄저장에 실패했습니다. 재 작업 바랍니다")
	else
		messagebox("확인","일괄저장 성공")
	end if
elseif	dwo.name	=	'b_delete'	then
	string	ls_win_id
	ls_win_id		=	trim(this.object.comm111_win_id[1])
	delete	from	pbcommon.comm111
	where		win_id	=	:ls_win_id
	using	sqlca ;
	messagebox("확인","일괄삭제 되었습니다")
end if
this.visible	=	false
this.enabled	=	false
dw_2.reset()
end event

event clicked;long	i

if	dwo.name	=	'comm111_win_st_t'		then
	if	this.object.comm111_win_st_t.text	=	'사용'	then
		this.object.comm111_win_st_t.text	=	'미사용'
		for		i =	 1	to	this.rowcount()
				this.object.comm111_win_st[i]	=	'Y'
		next	
	elseif	this.object.comm111_win_st_t.text	=	'미사용'	then
		this.object.comm111_win_st_t.text		=	'사용'
		for		i =	 1	to	this.rowcount()
				this.object.comm111_win_st[i]	=	'N'
		next	
	end if
end if
this.accepttext()
end event

event constructor;this.settransobject(Sqlca)
end event

type gb_2 from groupbox within w_comm111u
integer x = 14
integer width = 3072
integer height = 188
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8388608
long backcolor = 12632256
end type

type sle_dept from singlelineedit within w_comm111u
integer x = 494
integer y = 76
integer width = 498
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_copy from commandbutton within w_comm111u
integer x = 2537
integer y = 64
integer width = 507
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean enabled = false
string text = "사용부서 Copy"
end type

event clicked;Long	ln_count,i

if 	dw_2.rowcount() < 1 then
	messagebox("확인","기존 부서의 사용권한을 조회 한 후에 Copy 가능합니다")
	return
end if
dw_5.visible 	=	true
dw_5.enabled 	= 	true
dw_5.insertrow(0)
dw_5.setfocus()
dw_5.setcolumn("to_dept")
dw_5.object.from_dept[1] 	= 	dw_2.object.dept_cd[1]
dw_5.object.to_dept[1] 		= 	''

end event

type dw_5 from datawindow within w_comm111u
boolean visible = false
integer x = 2158
integer y = 496
integer width = 2341
integer height = 284
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "사용권한 Copy"
string dataobject = "d_comm111u_copy"
boolean controlmenu = true
string icon = "C:\KDAC\kdac.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;if 	dwo.name <> 'b_copy' then
	return
end if

Setpointer(hourglass!)

String 	ls_todept,ls_fromdept,ls_area,ls_display,ls_chgdate,ls_inputdetail
Long		ln_count = 0, i

this.accepttext()
ls_fromdept 		= 	trim(this.object.from_dept[row])
ls_todept 			= 	trim(this.object.to_dept[row])

insert	into	pbcommon.comm111
select		:ls_todept	,win_id,	win_st,:g_s_empno,		:g_s_date,	:g_s_empno,		:g_s_date,	:g_s_ipaddr,	:g_s_macaddr from pbcommon.comm111
where		dept_cd	=	:ls_fromdept	and win_id	not	in	(select	win_id	from pbcommon.comm111 where dept_Cd	=	:ls_todept	)
using		sqlca	;

uo_status.st_message.text = "Copy 완료 " 

this.visible 		=	false
this.enabled 	= 	false

end event

event losefocus;this.visible = false
this.enabled = false
end event

