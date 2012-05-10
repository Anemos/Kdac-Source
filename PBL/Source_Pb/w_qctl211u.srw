$PBExportHeader$w_qctl211u.srw
$PBExportComments$공통코드등록
forward
global type w_qctl211u from w_origin_sheet03
end type
type dw_1 from datawindow within w_qctl211u
end type
type dw_2 from datawindow within w_qctl211u
end type
type dw_3 from datawindow within w_qctl211u
end type
type st_1 from statictext within w_qctl211u
end type
type gb_2 from groupbox within w_qctl211u
end type
type gb_1 from groupbox within w_qctl211u
end type
type dw_9 from datawindow within w_qctl211u
end type
type rb_1 from radiobutton within w_qctl211u
end type
type rb_2 from radiobutton within w_qctl211u
end type
type cbx_1 from checkbox within w_qctl211u
end type
end forward

global type w_qctl211u from w_origin_sheet03
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
st_1 st_1
gb_2 gb_2
gb_1 gb_1
dw_9 dw_9
rb_1 rb_1
rb_2 rb_2
cbx_1 cbx_1
end type
global w_qctl211u w_qctl211u

type variables
string i_s_comm_cd, i_s_comm_rpst, i_s_comm_deta, &
         i_s_click_cd, i_s_selected
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();dw_2.object.comm_rpst.background.color = rgb(255,250,239)				// Cream
dw_2.object.comm_deta.background.color	= rgb(255,250,239)
//dw_2.object.comm_cd.background.color = rgb(255,255,255)
dw_2.object.comm_nm1.background.color 	= rgb(255,255,255)				// White
dw_2.object.comm_nm2.background.color 	= rgb(255,255,255)
dw_2.object.comm_nm3.background.color 	= rgb(255,255,255)
dw_2.object.comm_nm4.background.color 	= rgb(255,255,255)
dw_2.object.comm_st.background.color 	= rgb(255,255,255)
//dw_2.object.comm_wk.background.color = rgb(255,255,255)
dw_2.object.comm_remk.background.color	= rgb(255,255,255)
dw_2.object.rel_cd.background.color 	= rgb(255,255,255)
end subroutine

event closequery;int Net
//--	Return 0 : Closing, 	Return 1 : Not Closed	
if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
	
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

event open;call super::open;DataWindowChild dw_child1
integer	l_n_rowcount

connect using sqlcs;
dw_3.GetChild('code_name', dw_child1)
dw_3.settransobject(sqlcs)
dw_child1.settransobject(sqlcs)
dw_child1.retrieve()
l_n_rowcount		=	dw_3.retrieve()

if l_n_rowcount	>	0	then
	i_s_click_cd	=	dw_3.getitemstring(1, "comm_deta")
end if
end event

event ue_delete;call super::ue_delete;integer l_n_row,  	  l_n_yesno,     l_n_rcnt, 	l_n_findrow
string  l_s_comm_rpst, l_s_comm_deta, l_s_comm_cd
DataWindowChild dw_child1

dw_2.accepttext()
l_n_row		=  dw_2.GetRow()

if f_spacechk(i_s_click_cd) 	= -1 then
  	uo_status.st_message.text	=	f_message("E243")		// 대표코드를 선택한 후 처리바랍니다.	  
	return
end if
if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_row		     =  0   then 
		uo_status.st_message.text	=  f_message("D100")	// 삭제할 자료를 확인한 후 바랍니다.
   	return
	end if
end if
if i_s_click_cd 	  	<> i_s_comm_rpst then
  	uo_status.st_message.text	=  f_message("I090")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if

l_s_comm_rpst	= 	trim(dw_2.getitemstring(1, "comm_rpst"))
l_s_comm_deta	= 	trim(dw_2.getitemstring(1, "comm_deta"))
l_s_comm_cd		= 	trim(dw_2.getitemstring(1, "comm_cd"))

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_s_comm_cd <> i_s_comm_cd then
		uo_status.st_message.text	=  f_message("I090")	// 조회시 Key와 다르면 처리할 수 없습니다.
		return
	end if
end if

 SELECT count(*) INTO :l_n_rcnt
  FROM COMM210
 WHERE comm_rpst = :l_s_comm_deta USING sqlcs;

if isnull(l_n_rcnt) then
	l_n_rcnt	=	0
end if

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
   if l_s_comm_rpst	= "A00" and l_n_rcnt	> 0 then 
		uo_status.st_message.text	=   "세부코드가 있는 경우에는 삭제할 수 없습니다."  	
		return
	end if
end if

l_n_yesno = messagebox("삭제 확인","해당자료를 삭제 하시겠습니까?",Question!,OkCancel!,2)
if l_n_yesno <> 1  then
	Return
end if
	
setpointer(hourglass!)

dw_2.SetTransObject(sqlcs)
dw_2.deleteRow(l_n_row)

if dw_2.update() = 1 then
	commit using sqlcs;
	uo_status.st_message.text	=  f_message("D010")	// 삭제되었습니다. 	

	if l_s_comm_rpst 	= "A00" then						// 대표코드 Retrieve
		dw_3.reset()
		dw_3.GetChild('code_name', dw_child1)
		dw_3.settransobject(sqlcs)
		dw_child1.settransobject(sqlcs)
		dw_child1.retrieve()
		dw_3.retrieve()
	
		l_n_findrow = dw_3.find("COMM_DETA = " + "'" + i_s_click_cd + "'", 1, dw_1.rowcount() )
		if l_n_findrow > 0 then
			dw_3.scrolltorow(l_n_findrow)
		end if
	end if
	dw_1.settransobject(sqlcs)
	l_n_findrow = dw_1.find("COMM_CD = " + "'" + l_s_comm_cd + "'", 1, dw_1.rowcount() )
	dw_1.retrieve(l_s_comm_rpst)
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_findrow,true)
	end if
	dw_2.reset()
else
	rollback using sqlcs;
	uo_status.st_message.text	=  f_message("D020")	// [삭제실패] 정보시스템팀으로 연락바랍니다. 
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자

i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	False
wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

event ue_dprint;call super::ue_dprint;dw_1.Print()
end event

event ue_insert;call super::ue_insert;int Net
string l_s_comm_rpst1

if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
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

if f_spacechk(i_s_click_cd)	= -1 then
  	uo_status.st_message.text	=	f_message("E243")		// 대표코드를 선택한 후 처리바랍니다.	  
	return
end if	

if f_spacechk(i_s_selected)	= -1 then
  	uo_status.st_message.text	=  f_message("I060")		// 조회한 후에 입력바랍니다.
	return
end if	
if i_s_click_cd	<>	i_s_comm_rpst then
  	uo_status.st_message.text	=  f_message("I090")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if
	
dw_2.reset()
dw_2.insertrow(0)

wf_rgbclear()														//	항목 Clear	

dw_2.object.comm_rpst[1]      	   = 	i_s_click_cd
l_s_comm_rpst1								=	left(i_s_click_cd, 1)
dw_2.object.comm_wk[1]					=	l_s_comm_rpst1
dw_2.object.comm_st[1]					=	'Y'				// 사용

dw_2.object.comm_deta.Protect 		=	False
dw_2.setfocus()
dw_2.setrow(1)
dw_2.setcolumn("comm_deta")

dw_1.selectrow( 0, false )

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자
i_s_selected   =	"i"
i_b_insert		=	True
i_b_save			=	True
i_b_delete		=	False
wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)
end event

event ue_preview;call super::ue_preview;window 	l_to_open
str_easy l_str_prt

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)

uo_status.st_message.Text = "출력 준비중 입니다..."
dw_9.SetTransObject(sqlcs)
dw_9.retrieve(i_s_click_cd)

string l_s_cbx_cd
if cbx_1.checked then
	l_s_cbx_cd = "a"
else
	l_s_cbx_cd = "d"
end if

if rb_1.checked then
	dw_9.setsort("comm_cd " + l_s_cbx_cd)
	dw_9.sort()
else
	dw_9.setsort("comm_nm1 " + l_s_cbx_cd)
	dw_9.sort()
end if
//인쇄 DataWindow 저장
l_str_prt.transaction  = sqlcs
l_str_prt.datawindow   = dw_9
l_str_prt.title = "공통코드 출력"
l_str_prt.tag			  = This.ClassName()

f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""	

end event

event ue_retrieve;call super::ue_retrieve;int Net

if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
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
  	uo_status.st_message.text	=	f_message("E243")		// 대표코드를 선택한 후 처리바랍니다.	  
	return
end if

setpointer(hourglass!)

dw_1.SetTransObject(sqlcs)
dw_1.retrieve(i_s_click_cd)
dw_2.settransobject(sqlcs)

if dw_1.rowcount()	= 0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	i_b_preview	=	False		  
	i_b_dprint	=	False		  
else
   string l_s_cbx_cd
	if cbx_1.checked then
		l_s_cbx_cd = "a"
	else
		l_s_cbx_cd = "d"
	end if

	if rb_1.checked then
		dw_1.setsort("comm_cd " + l_s_cbx_cd)
		dw_1.sort()
	else
		dw_1.setsort("comm_nm1 " + l_s_cbx_cd)
		dw_1.sort()
	end if
	
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
	i_b_preview	=	True		  
	i_b_dprint	=	True		  
end if
dw_2.reset()

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자
i_s_selected	=	'r'
i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	False
wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)
				  
i_s_comm_rpst	=	i_s_click_cd								// Key Save
setpointer(Arrow!)
end event

event ue_save;call super::ue_save;string  l_s_comm_cd,  l_s_comm_rpst, l_s_comm_deta, l_s_comm_deta1, l_s_comm_nm1, l_s_errchk, &
        l_s_column,   l_s_message
integer l_n_rowcount, l_n_rcnt, l_n_findrow 
DataWindowChild dw_child1

dw_2.accepttext()
l_n_rowcount	=  dw_1.GetSelectedRow(0)

if f_spacechk(i_s_click_cd) 	= 	-1 then
  	uo_status.st_message.text	=	f_message("E243")		// 대표코드를 선택한 후 처리바랍니다.	  
	return 0
end if

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_rowcount     =  0   then 
   	uo_status.st_message.text	=  f_message("U070")	// 저장할 자료를 선택한 후 처리바랍니다.
   	return 0
	end if
end if
if i_s_click_cd 	  	<> i_s_comm_rpst then
  	uo_status.st_message.text	=  f_message("I090")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return 0
end if

l_s_comm_rpst	= 	trim(dw_2.getitemstring( 1, "comm_rpst"))
l_s_comm_deta	= 	trim(dw_2.getitemstring( 1, "comm_deta"))
l_s_comm_cd		= 	trim(dw_2.getitemstring( 1, "comm_cd" ))
l_s_comm_nm1 	=	trim(dw_2.getitemstring( 1, "comm_nm1"))
if f_spacechk(l_s_comm_cd) = -1 then
	l_s_comm_cd	=	l_s_comm_rpst + l_s_comm_deta
end if
	
if i_s_selected		=  "r" then
	if l_s_comm_cd	 <> i_s_comm_cd then
	  	uo_status.st_message.text	=  f_message("I090") // 조회시 Key와 다르면 처리할 수 없습니다.
		return 0
	end if
end if	

//////////	   기존 Data 존재 여부 Check  	//////////
SELECT count(*) 	INTO :l_n_rcnt		
  FROM COMM210  
 WHERE comm_cd = :l_s_comm_cd using sqlcs  ;

wf_rgbclear()
if i_s_selected	= "i" then
	if l_n_rcnt   	>  0  then
   	uo_status.st_message.text	=  f_message("A060")	// 입력할 자료가 이미 존재합니다 
	   dw_2.object.comm_rpst.Background.Color = rgb(255,255,0)
	   dw_2.object.comm_deta.Background.Color = rgb(255,255,0)
		dw_2.setcolumn("comm_deta")
		dw_2.setfocus()
   	return 0
	end if
end if

///////////    	Body Editing Check Area		///////////
if isnull(l_s_comm_deta) or len(l_s_comm_deta) < 1 then	
   dw_2.object.comm_deta.Background.Color = rgb(255,255,0)	
	l_s_column	=	"comm_deta"		
end if
l_s_comm_deta1	=	left(l_s_comm_deta, 1)		
if l_s_comm_rpst = 'A00' then
	if l_s_comm_deta1 < 'A' or  l_s_comm_deta1 > 'Z' then
	   dw_2.object.comm_deta.Background.Color = rgb(255,255,0)	
		l_s_column	=	"comm_deta"		
	end if
end if
if f_spacechk(dw_2.getitemstring(1,"comm_nm1"))		= -1  then
   dw_2.object.comm_nm1.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"comm_nm1"			
	end if
end if
//if f_spacechk(dw_2.getitemstring(1,"comm_nm2"))		= -1  then
//   dw_2.object.comm_nm2.Background.Color = rgb(255,255,0)	
//   l_s_column	=	"comm_nm2"			
//end if
//if f_spacechk(dw_2.getitemstring(1,"comm_nm3"))		= -1  then
//   dw_2.object.comm_nm3.Background.Color = rgb(255,255,0)	
//   l_s_column	=	"comm_nm3"			
//end if
//if f_spacechk(dw_2.getitemstring(1,"comm_nm4"))		= -1  then
//   dw_2.object.comm_nm4.Background.Color = rgb(255,255,0)	
//   l_s_column	=	"comm_nm4"			
//end if
//if f_spacechk(dw_2.getitemstring(1,"comm_stat"))	= -1  then
//	dw_2.object.comm_stat.background.color	= rgb(255,255,0)
//	l_s_column 	= 	"comm_st"
//end if
//if f_spacechk(dw_2.getitemstring(1,"rel_cd")) 		= -1  then
//	dw_2.object.rel_cd.background.color 	= rgb(255,255,0)
//	l_s_column 	= 	"rel_cd"
//end if

if len(l_s_column)  > 0 then									// Editing Error
	dw_2.setcolumn(l_s_column)
	dw_2.setfocus()
	uo_status.st_message.text	=  f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	i_n_erreturn = -1
	return
end if

if i_s_selected = "r" and dw_2.ModifiedCount() = 0 then
	dw_1.setfocus()
   uo_status.st_message.text	=  f_message("E020")		// 변경내용이 없습니다.
   return
end if

dw_2.setitem( 1, "comm_cd", l_s_comm_cd)

setpointer(hourglass!)
f_sysdate()
dw_2.settransobject(sqlcs)
if i_s_selected = "i" then
	dw_2.object.inpt_id[1] 	= 	g_s_empno
	dw_2.object.inpt_dt[1] 	= 	g_s_datetime
end if
dw_2.object.updt_id[1]		= 	g_s_empno
dw_2.object.updt_dt[1] 		= 	g_s_datetime
dw_2.object.ip_addr[1] 		= 	g_s_ipaddr
dw_2.object.mac_addr[1]		= 	g_s_macaddr

if dw_2.update() = 1 then
	commit using sqlcs;

	if i_s_selected 		= "i" then
	   uo_status.st_message.text	=  f_message("A010")	// 입력되었습니다.
	else
      uo_status.st_message.text	=  f_message("U010")	// 저장되었습니다. 
	end if
	dw_1.settransobject(sqlcs)
	dw_1.retrieve(l_s_comm_rpst)
	dw_2.retrieve(l_s_comm_cd)
	
	l_n_findrow = dw_1.find("COMM_CD = " + "'" + l_s_comm_cd + "'", 1, dw_1.rowcount() )
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_findrow,true)
	end if

	i_b_delete		=	True
	i_b_dprint		=	True	
	i_b_preview		=	True		  
	i_s_comm_cd		=	l_s_comm_cd
	i_s_selected 	= 	"r"
else
	i_n_erreturn = -1
	rollback using sqlcs;
	if i_s_selected 		= "i" then
	   uo_status.st_message.text	=  f_message("A020")	// [입력 실패] 정보시스템팀으로 연락바랍니다. 
	else
	   uo_status.st_message.text	=  f_message("U020")	// [저장 실패] 정보시스템팀으로 연락바랍니다. 
	end if
end if

if l_s_comm_rpst = "A00" then									// 대표코드 Retrieve
	dw_3.reset()
	dw_3.GetChild('code_name', dw_child1)
	dw_3.settransobject(sqlcs)
	dw_child1.settransobject(sqlcs)
	dw_child1.retrieve()
	dw_3.retrieve()

	l_n_findrow = dw_3.find("COMM_DETA = " + "'" + i_s_click_cd + "'", 1, dw_1.rowcount() )
	if l_n_findrow > 0 then
		dw_3.scrolltorow(l_n_findrow)
	end if
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

on w_qctl211u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_9=create dw_9
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_9
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.cbx_1
end on

on w_qctl211u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_9)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_1)
end on

event close;call super::close;disconnect using sqlcs;
end event

type uo_status from w_origin_sheet03`uo_status within w_qctl211u
end type

type dw_1 from datawindow within w_qctl211u
integer x = 32
integer y = 212
integer width = 4567
integer height = 1508
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_qctl211u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;int Net
string l_s_comm_cd, l_s_comm_rpst

uo_status.st_message.text	=  ""

if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
		Net = messagebox("확 인", f_message("E028"), Question!, YesNoCancel!,2)
		if Net = 1 then
			parent.TriggerEvent("ue_save")
			if i_n_erreturn = -1 then
				return 0
			end if
		elseif Net = 3 then
			return 0
		end if
	end if
end if

if i_s_click_cd	<>	i_s_comm_rpst then
  	uo_status.st_message.text	=  f_message("I016")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return 0
end if

if row	< 1 then
  	uo_status.st_message.text	=  f_message("I017")		// 조회한 후 에 처리바랍니다.
	return 0
end if

dw_2.settransobject(sqlcs)
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

wf_rgbclear()														//	항목 Clear	
l_s_comm_cd				=	trim(this.getitemstring(row, "comm_cd"))	
dw_2.retrieve(l_s_comm_cd)

dw_2.object.comm_deta.Protect = True
dw_2.setfocus()
dw_2.setrow(1)
dw_2.setcolumn("comm_nm1")

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자
i_s_selected   = 	"r"
i_b_save			=	True
i_b_delete		=	True

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

i_s_comm_cd    = 	l_s_comm_cd									// Key Save
end event

type dw_2 from datawindow within w_qctl211u
integer x = 32
integer y = 1740
integer width = 4567
integer height = 728
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_qctl211u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_qctl211u
integer x = 411
integer y = 52
integer width = 1413
integer height = 100
integer taborder = 10
boolean bringtotop = true
string dataobject = "dddw_a00_s01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;DataWindowChild dw_child1

dw_3.GetChild('code_name', dw_child1)

i_s_click_cd	=	dw_3.getitemstring(dw_child1.getrow(), "comm_deta")	

end event

type st_1 from statictext within w_qctl211u
integer x = 64
integer y = 64
integer width = 338
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대표코드"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_qctl211u
integer x = 1906
integer width = 1669
integer height = 184
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_qctl211u
integer x = 37
integer y = 12
integer width = 1824
integer height = 172
integer textsize = -2
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_9 from datawindow within w_qctl211u
boolean visible = false
integer x = 3118
integer y = 4
integer width = 494
integer height = 360
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_qctl211p_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_qctl211u
integer x = 1998
integer y = 64
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "코드순"
boolean checked = true
end type

event clicked;string l_s_cbx_cd
if cbx_1.checked then
	l_s_cbx_cd = "a"
else
	l_s_cbx_cd = "d"
end if

dw_1.setsort("comm_cd " + l_s_cbx_cd)
dw_1.sort()

end event

type rb_2 from radiobutton within w_qctl211u
integer x = 2473
integer y = 60
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "코드명순"
end type

event clicked;string l_s_cbx_cd
if cbx_1.checked then
	l_s_cbx_cd = "a"
else
	l_s_cbx_cd = "d"
end if

dw_1.setsort("comm_nm1 " + l_s_cbx_cd)
dw_1.sort()

end event

type cbx_1 from checkbox within w_qctl211u
integer x = 3040
integer y = 60
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "오름차순"
boolean checked = true
end type

event clicked;string l_s_cbx_cd
if cbx_1.checked then
	l_s_cbx_cd = "a"
else
	l_s_cbx_cd = "d"
end if

if rb_1.checked then
	dw_1.setsort("comm_cd " + l_s_cbx_cd)
	dw_1.sort()
else
	dw_1.setsort("comm_nm1 " + l_s_cbx_cd)
	dw_1.sort()
end if

end event

