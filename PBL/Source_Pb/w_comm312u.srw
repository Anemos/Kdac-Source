$PBExportHeader$w_comm312u.srw
$PBExportComments$KDAC 업무별 사용설명서 관리
forward
global type w_comm312u from w_origin_sheet01
end type
type st_1 from statictext within w_comm312u
end type
type st_2 from statictext within w_comm312u
end type
type dw_3 from datawindow within w_comm312u
end type
type sle_1 from singlelineedit within w_comm312u
end type
type dw_1 from datawindow within w_comm312u
end type
type dw_2 from datawindow within w_comm312u
end type
type mle_1 from multilineedit within w_comm312u
end type
end forward

global type w_comm312u from w_origin_sheet01
st_1 st_1
st_2 st_2
dw_3 dw_3
sle_1 sle_1
dw_1 dw_1
dw_2 dw_2
mle_1 mle_1
end type
global w_comm312u w_comm312u

type variables
DataWindowChild dw_child1
string  i_s_sys, i_s_selected, i_s_descd
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();dw_2.object.winid.background.color 	 = rgb(255,255,255)				// White
dw_2.object.tabno.background.color 	 = rgb(255,255,255)
dw_2.object.winnm.background.color   = rgb(255,255,255)
dw_2.object.tabnm.background.color   = rgb(255,255,255)
dw_2.object.sysid.background.color   = rgb(255,255,255)
end subroutine

on w_comm312u.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_3=create dw_3
this.sle_1=create sle_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.mle_1
end on

on w_comm312u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.mle_1)
end on

event open;call super::open;
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_3.GetChild('win_nm', dw_child1)
dw_child1.settransobject(sqlca)
dw_child1.retrieve()
dw_3.insertrow(0)

end event

event ue_retrieve;call super::ue_retrieve;string l_s_winid
int    l_n_row

setpointer(hourglass!)

l_s_winid = trim(sle_1.text)
//if f_spacechk(i_s_sys) = -1 then
//	uo_status.st_message.text = "시스템구분을 선택후 조회하세요."
//	return
//end if

l_n_row = dw_1.retrieve(l_s_winid + '%')
dw_2.reset()
mle_1.text = ''

if l_n_row > 0 then
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
else
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
end if

i_b_retrieve	=	True
i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	False
i_b_dprint		=	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
		  
setpointer(arrow!)
end event

event ue_insert;call super::ue_insert;
uo_status.st_message.text	=	''
wf_rgbclear()

dw_2.reset()
dw_2.insertrow(0)

dw_2.object.winid.protect = false

dw_2.setcolumn('winid')
dw_2.setfocus()

mle_1.text = ''

i_s_selected = "i"

i_b_save     = true 
i_b_retrieve = true
i_b_insert   = true
i_b_delete   = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_save;call super::ue_save;int    l_n_findrow, l_n_rowcnt, l_n_rcnt
string l_s_column, l_s_winid, l_s_descd, l_s_descd1
dec    l_n_tabno

dw_2.accepttext()

wf_rgbclear()
uo_status.st_message.text	=	''

l_s_winid = dw_2.object.winid[1]
if f_spacechk(l_s_winid) = -1 then
	dw_2.object.winid.Background.Color = rgb(255,255,0)
	l_s_column = "winid"
else
	select count(*)  into :l_n_rcnt
	from   "PBCOMMON"."COMM110"
	where  "PBCOMMON"."COMM110"."WIN_ID" = :l_s_winid using sqlca;
	if isnull(l_n_rcnt) then
		l_n_rcnt = 0
	end if
	if l_n_rcnt < 1 then
		dw_2.object.winid.Background.Color = rgb(255,255,0)
		uo_status.st_message.text	=	'입력된 WINDOW ID 가 존재 하지 않습니다.'
		return
	end if
end if
l_n_tabno = dw_2.object.tabno[1]

if i_s_selected = "i" then
	select count(*)  into :l_n_rcnt
	from   "PBCOMMON"."DAC110"
	WHERE  "PBCOMMON"."DAC110"."COMLTD" = :g_s_company and
	       "PBCOMMON"."DAC110"."WINID"  = :l_s_winid   and
			 "PBCOMMON"."DAC110"."TABNO"  = :l_n_tabno   using sqlca;
	if isnull(l_n_rcnt) then
		l_n_rcnt = 0
	end if
	if l_n_rcnt > 0 then
		dw_2.object.winid.Background.Color = rgb(255,255,0)
		if l_n_tabno <> 0 then
			dw_2.object.tabno.Background.Color = rgb(255,255,0)
		end if
		uo_status.st_message.text	=	'이미 등록된 WINDOW ID(TAB NO) 가 존재합니다.'
		return
	end if
end if

if f_spacechk(dw_2.object.winnm[1]) = -1 then
   dw_2.object.winnm.Background.Color = rgb(255,255,0)
   if len(l_s_column) < 1 then	
		l_s_column	=	"winnm"		
	end if	
end if
if l_n_tabno <> 0 then
	if f_spacechk(dw_2.object.tabnm[1]) = -1 then
		dw_2.object.tabnm.Background.Color = rgb(255,255,0)
		if len(l_s_column) < 1 then	
			l_s_column	=	"tabnm"		
		end if	
	end if
else
	if f_spacechk(dw_2.object.tabnm[1]) <> -1 then
		dw_2.object.tabnm.Background.Color = rgb(255,255,0)
		if len(l_s_column) < 1 then	
			l_s_column	=	"tabnm"		
		end if	
	end if
end if

if f_spacechk(dw_2.object.sysid[1]) = -1 then
   dw_2.object.sysid.Background.Color = rgb(255,255,0)
   if len(l_s_column) < 1 then	
		l_s_column	=	"sysid"		
	end if	
end if

l_s_descd = mle_1.text

if len(l_s_column)	> 0 then									// Editing Error
	dw_2.setcolumn(l_s_column)
	dw_2.setfocus()
	uo_status.st_message.text	=	f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	i_n_erreturn = -1
	return
elseif f_spacechk(l_s_descd) = -1 then
	uo_status.st_message.text	=	"도움말을 입력후 저장 바랍니다."
	return
end if

if i_s_selected = "r" and &
   ( dw_2.ModifiedCount() = 0 and i_s_descd = l_s_descd ) then
	dw_1.setfocus()
   uo_status.st_message.text  =	f_message("E020")		// 변경내용이 없습니다.
   return
end if

f_sysdate()       

dw_2.object.descd[1]    =  l_s_descd

if i_s_selected = "i" then
	dw_2.object.comltd[1]   =  g_s_company
	dw_2.object.inptdt[1] 	=  g_s_datetime
	dw_2.object.inptid[1] 	=  g_s_empno
else
   dw_2.object.updtid[1]	=  g_s_empno
   dw_2.object.updtdt[1] 	=  g_s_datetime
 end if
dw_2.object.ipaddr[1]	= 	g_s_ipaddr
dw_2.object.macaddr[1] 	= 	g_s_macaddr

if dw_2.update() = 1 then
   commit using sqlca;
	if i_s_selected 		= "i" then
  		uo_status.st_message.text	=  f_message("A010")	// 입력되었습니다. 
	else
  		uo_status.st_message.text	=  f_message("U010")	// 저장되었습니다.
	end if	  
	
   dw_1.retrieve(l_s_winid + '%')
   l_n_rowcnt  = dw_1.rowcount()
   l_n_findrow = dw_1.find("winid ='" + l_s_winid + "' and tabno = " + string(l_n_tabno) , 1 , l_n_rowcnt)
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_findrow,true)
	end if	
else
	i_n_erreturn 	= 	-1
	rollback using SQLCA;
	if i_s_selected 		= "i" then
	   uo_status.st_message.text 	= 	f_message("A020")	// [입력실패] 정보시스템팀으로 연락바랍니다. 
	else
	   uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 
	end if	
end if 

i_b_retrieve   = true 
i_b_insert     = true
i_b_save			= false
i_b_delete		= false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

event ue_delete;call super::ue_delete;int    l_n_yesno, l_n_row

setpointer(hourglass!)

uo_status.st_message.text	=  ""
wf_rgbclear()

l_n_yesno = messagebox("삭제 확인", "해당 WINDOW 도움말 정보를 정말 삭제 하시겠습니까?", Question!, OkCancel!, 2)
if l_n_yesno <> 1  then
	uo_status.st_message.text = "삭제 작업이 취소 되었습니다."
	Return
end if

dw_2.accepttext()
l_n_row   = dw_2.getrow()

dw_2.deleteRow(l_n_row)
if dw_2.update() = 1 then
   commit using sqlca;
	uo_status.st_message.text = '삭제 되었습니다.'
	dw_1.retrieve(trim(sle_1.text) + '%')
else
	i_n_erreturn = -1
	rollback using SQLCA;
	uo_status.st_message.text = '[삭제실패] 각 담당자는 확인 바랍니다.'	
end if

setpointer(arrow!)
end event

type uo_status from w_origin_sheet01`uo_status within w_comm312u
end type

type st_1 from statictext within w_comm312u
integer x = 23
integer y = 32
integer width = 338
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "시스템구분"
boolean focusrectangle = false
end type

type st_2 from statictext within w_comm312u
integer x = 23
integer y = 148
integer width = 338
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "WINDOW ID"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_comm312u
integer x = 366
integer y = 20
integer width = 690
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "dddw_comm110_c01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;i_s_sys = dw_child1.getitemstring(1, "menu_cd")
sle_1.text = 'w_' + i_s_sys 
end event

type sle_1 from singlelineedit within w_comm312u
event ue_keydown pbm_keydown
integer x = 366
integer y = 136
integer width = 457
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type dw_1 from datawindow within w_comm312u
integer x = 27
integer y = 240
integer width = 2706
integer height = 696
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm312u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string l_s_winid
dec    l_n_tabno

if row < 1 then
	return
end if

this.selectrow(0,false)
this.selectrow(row,true)

wf_rgbclear()
uo_status.st_message.text	=	''

l_s_winid = this.object.winid[row]
l_n_tabno = this.object.tabno[row]

dw_2.object.winid.protect = true

dw_2.retrieve(g_s_company, l_s_winid, l_n_tabno)
dw_2.setcolumn('winnm')
dw_2.setfocus()

select "PBCOMMON"."DAC110"."DESCD"
into   :i_s_descd
from   "PBCOMMON"."DAC110"
where  "PBCOMMON"."DAC110"."COMLTD" = :g_s_company and
       "PBCOMMON"."DAC110"."WINID"  = :l_s_winid   and
		 "PBCOMMON"."DAC110"."TABNO"  = :l_n_tabno   using sqlca ;
if sqlca.sqlcode <> 0 then
	i_s_descd = ''
end if

mle_1.text = i_s_descd

i_s_selected = "r"

i_b_save     = true 
i_b_retrieve = true
i_b_insert   = true
i_b_delete   = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

type dw_2 from datawindow within w_comm312u
integer x = 2743
integer y = 240
integer width = 1870
integer height = 696
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm312u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_1 from multilineedit within w_comm312u
integer x = 850
integer y = 944
integer width = 2871
integer height = 1540
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

