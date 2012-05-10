$PBExportHeader$w_frame.srw
$PBExportComments$KDAC의 Main-Frame화면
forward
global type w_frame from window
end type
type mdi_1 from mdiclient within w_frame
end type
end forward

global type w_frame from window
integer x = 5
integer y = 44
integer width = 4750
integer height = 3040
boolean titlebar = true
string title = "종합정보시스템"
string menuname = "m_frame"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = mdi!
long backcolor = 276856960
boolean clientedge = true
boolean center = true
event enableprint pbm_custom01
event syscommand pbm_syscommand
mdi_1 mdi_1
end type
global w_frame w_frame

type variables
string i_s_minimize
end variables

event enableprint;//boolean l_b_enable
//m_frame lm_genapp_frame
//
///* Enable or disable printing */
//lm_genapp_frame = menuid
//if message.wordparm <> 0 then
//	l_b_enable = true
//end if
////	lm_genapp_frame.m_file.m_print.enabled = l_b_enable
//
end event

event syscommand;//// window title-bar & button 제어
//
//if	message.wordparm	=	61472 then		//Minimize Button
//		i_s_minimize 			= 	"Y"
//end if
//
//if 	i_s_minimize	<>	"Y" then
//		if 	message.wordparm	= 	61728 then	//Maximize Button
//			message.processed   	= 	true
//			message.returnvalue	= 	1
//		end if
//end if
//
//if 	i_s_minimize 	= 	"Y" and	message.wordparm 	=	61728 then
//		i_s_minimize 	= 	"N"
//end if
//
//if 	message.wordparm	= 	61730 then		//double click
//		message.processed	= 	true
//		message.returnvalue	= 	1
//end if
//
//if 	message.wordparm	=	61458 then		//title click
//		message.processed   	= 	true
//		message.returnvalue	= 	1
//end if
//
if 	message.wordparm	= 	61536 then		//window close
	message.processed   	= 	true
	message.returnvalue	= 	1	
end if
//
//if 	message.wordparm	= 	61587 then		//window control menu
//		message.processed   	= 	true
//		message.returnvalue	= 	1
//end if
//
end event

on w_frame.create
if this.MenuName = "m_frame" then this.MenuID = create m_frame
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;String		ls_compname
Long   	ln_size

//Menu ToolBar Setting
this.SetToolbar(1, true)
this.SetToolbar(2, false)
m_frame.m_action.visible	=	false

ls_compname 	=	space(1024)
ln_size     		=	len(ls_compname)



end event

event closequery;Integer	ln_return

ln_return = messagebox("종료 확인!",'SYSTEM을 종료하시겠습니까?', &
          		          			Question!, YesNo!, 2)
if ln_return		=	1 then
//	if gs_usergubun	=	"U" then
	f_accesslog_create_kdac_pbl(g_s_empno,"O","")
//	end if
	close(this)
else
	return 1
end if

end event

event activate;integer 	li_rtn
boolean 	lb_visible2 

this.GetToolbar(2, lb_visible2)
if 	lb_visible2 = true then
	this.SetToolbar(2, true)
	this.SetToolbarPos(2, 2, 150, false)
end if

end event

type mdi_1 from mdiclient within w_frame
long BackColor=276856960
end type

