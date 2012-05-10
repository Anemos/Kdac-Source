$PBExportHeader$w_qctl102u.srw
$PBExportComments$PassWord 관리
forward
global type w_qctl102u from w_origin_sheet01
end type
type dw_1 from datawindow within w_qctl102u
end type
type dw_2 from datawindow within w_qctl102u
end type
end forward

global type w_qctl102u from w_origin_sheet01
dw_1 dw_1
dw_2 dw_2
end type
global w_qctl102u w_qctl102u

type variables
string i_s_selected
datawindowchild i_dwc_1
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();dw_2.object.emp_no.background.color	 = rgb(255,250,239)				// Cream
dw_2.object.emp_pwd.background.color = rgb(255,255,255)				// White

end subroutine

on w_qctl102u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_qctl102u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

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

event ue_insert;int Net

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

dw_2.reset()
dw_2.getchild("dept_cd",i_dwc_1)
i_dwc_1.settransobject(sqlcs)
i_dwc_1.retrieve("A03")
dw_2.insertrow(0)
dw_2.object.emp_no.Protect = False
dw_2.setfocus()
dw_2.setcolumn("emp_no")

wf_rgbclear()		//	항목 R.G.B Clear

dw_1.selectrow(0, false)

i_s_selected  = "i"

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_b_retrieve = True
i_b_insert   = True
i_b_save		 = True
i_b_delete	 = False
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;string l_s_emp_no, l_s_kor_nm
int Net

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

Setpointer(hourglass!)

dw_1.SetTransObject(sqlcs)


if dw_1.retrieve()	= 	0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
else
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
end if

dw_2.reset()

i_s_selected =	'r'

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_b_insert	=	True
i_b_save		=	False
i_b_delete	=	False
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

end event

event ue_save;string  l_s_emp_no,	 l_s_emp_pwd, l_s_errchk, l_s_column, l_s_message
integer l_n_rowcount, l_n_rcnt,    l_n_forcnt, l_n_findrow 

dw_2.accepttext()
l_n_rowcount	=  dw_1.GetSelectedRow(0)

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_rowcount = 0 then 
   	uo_status.st_message.text	=  f_message("U090")	// 저장할 자료를 선택한 후 처리바랍니다.
   	return
	end if
end if

l_s_emp_no	= trim(dw_2.getitemstring(1, "emp_no"))
l_s_emp_pwd	= Upper(trim(dw_2.getitemstring(1, "emp_pwd")))
	
//////////	   기존 Data 존재 여부 Check  	//////////
SELECT count(*) 	INTO :l_n_rcnt		
  FROM "COMM120"
 WHERE "EMP_NO" = :l_s_emp_no
 using sqlcs;

wf_rgbclear()
if i_s_selected = "i" then
	if l_n_rcnt  >  0  then
   	uo_status.st_message.text = f_message("A060")	// 입력할 자료가 이미 존재합니다 
	   dw_2.object.emp_no.Background.Color = rgb(255,255,0)
		dw_2.setcolumn("emp_no")
		dw_2.setfocus()
   	return
	end if
end if

SELECT count(*) 	INTO :l_n_forcnt  
  FROM "PBCOMMON"."DAC003"  
 WHERE "PBCOMMON"."DAC003"."PEEMPNO" = :l_s_emp_no using sqlca;
if l_n_forcnt =  0  then
	uo_status.st_message.text = "인사기본 자료가 없습니다."
	dw_2.object.emp_no.Background.Color = rgb(255,255,0)
	dw_2.setcolumn("emp_no")
	dw_2.setfocus()
	return
end if

///////////    	Body Editing Check Area		///////////
if f_spacechk(dw_2.getitemstring(1,"emp_no")) 	= -1  then
	dw_2.object.emp_no.background.color  = rgb(255,255,0)
	l_s_message = f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	if f_spacechk(l_s_column) = -1 then
		l_s_column 	= 	"emp_no"
	end if
end if
if f_spacechk(dw_2.getitemstring(1,"emp_pwd")) 	= -1  then
	dw_2.object.emp_pwd.background.color = rgb(255,255,0)
	l_s_message = f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	if f_spacechk(l_s_column) = -1 then
		l_s_column 	= 	"emp_pwd"
	end if
else
	// Asc("0") => 48, Asc("9") => 57, Asc("A") => 65, Asc("Z") => 90
	For l_n_forcnt = 1 to len(l_s_emp_pwd)
		if (Asc(mid(l_s_emp_pwd,l_n_forcnt,1)) > 47	and &
			 Asc(mid(l_s_emp_pwd,l_n_forcnt,1)) < 58)	or  &
			(Asc(mid(l_s_emp_pwd,l_n_forcnt,1)) > 64	and &
			 Asc(mid(l_s_emp_pwd,l_n_forcnt,1)) < 91)	then
		else
			dw_2.object.emp_pwd.background.color = rgb(255,255,0)
			l_s_message = "비밀번호는 [0-9, A-Z]만 가능합니다."
			if f_spacechk(l_s_column) = -1 then
				l_s_column 	= 	"emp_pwd"
			end if
		end if
	next
end if

if f_spacechk(dw_2.getitemstring(1,"emp_cd")) 	= -1  then
	dw_2.object.emp_cd.background.color  = rgb(255,255,0)
	l_s_message = f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	if f_spacechk(l_s_column) = -1 then
		l_s_column 	= 	"emp_cd"
	end if
end if

if len(l_s_column) > 0 then									// Editing Error
	dw_2.setcolumn(l_s_column)
	dw_2.setfocus()
	uo_status.st_message.text = l_s_message
	i_n_erreturn = -1
	return
end if

if i_s_selected = "r" and dw_2.ModifiedCount() = 0 then
	dw_1.setfocus()
   uo_status.st_message.text = f_message("E020")		// 변경내용이 없습니다.
   return
end if

Setpointer(hourglass!)

f_sysdate()
dw_2.settransobject(sqlcs)
if i_s_selected = "i" then
	dw_2.object.inpt_id[1]	= 	g_s_empno
	dw_2.object.inpt_dt[1] 	= 	g_s_datetime
end if
dw_2.object.emp_pwd[1]  	= 	l_s_emp_pwd
dw_2.object.updt_id[1]		= 	g_s_empno
dw_2.object.updt_dt[1] 		= 	g_s_datetime
dw_2.object.ip_addr[1] 		= 	g_s_ipaddr
dw_2.object.mac_addr[1]		= 	g_s_macaddr

if dw_2.update() = 1 then
	commit using sqlcs;

	if i_s_selected = "i" then
	   uo_status.st_message.text = f_message("A010")	// 입력되었습니다.
	else
      uo_status.st_message.text = f_message("U010")	// 저장되었습니다. 
	end if
	dw_1.settransobject(sqlcs)
	dw_1.retrieve(l_s_emp_no)
	dw_2.retrieve(l_s_emp_no)
	
	l_n_findrow = dw_1.find("EMP_NO = " + "'" + l_s_emp_no + "'", 1, dw_1.rowcount() )
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0, false)
		dw_1.selectrow(l_n_findrow, true)
	end if

	i_b_dprint		=	True	
	i_b_delete		=	True

	i_s_selected 	= 	"r"
else
	i_n_erreturn = -1
	rollback using sqlcs;
	if i_s_selected = "i" then
	   uo_status.st_message.text = f_message("A020")	// [입력 실패] 정보시스템팀으로 연락바랍니다. 
	else
	   uo_status.st_message.text = f_message("U020")	// [저장 실패] 정보시스템팀으로 연락바랍니다. 
	end if
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_delete;call super::ue_delete;integer l_n_row,       l_n_yesno,     l_n_rcnt, 	l_n_findrow
string  l_s_emp_no

dw_2.accepttext()
l_n_row = dw_2.GetRow()

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_row = 0 then 
		uo_status.st_message.text	=  f_message("D100")	// 삭제할 자료를 선택한 후 처리바랍니다.
   	return
	end if
end if

l_n_yesno = messagebox("삭제 확인","해당자료를 삭제 하시겠습니까?",Question!,OkCancel!,2)
if l_n_yesno <> 1  then
	Return
end if
l_s_emp_no = trim(dw_2.getitemstring(1, "emp_no"))

setpointer(hourglass!)

dw_2.SetTransObject(sqlcs)
dw_2.deleteRow(l_n_row)

if dw_2.update() = 1 then
	commit using sqlcs;
	uo_status.st_message.text	=  f_message("E010")		// 삭제되었습니다. 	

	dw_1.settransobject(sqlcs)
	l_n_findrow = dw_1.find("EMP_NO = " + "'" + l_s_emp_no + "'", 1, dw_1.rowcount() )
	dw_1.retrieve(l_s_emp_no)
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0, false)
		dw_1.selectrow(l_n_findrow, true)
	end if
	dw_2.reset()
else
	rollback using sqlcs;
	uo_status.st_message.text	=  f_message("D020")		// [삭제실패] 정보시스템팀으로 연락바랍니다. 
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	False
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

end event

event open;call super::open;connect using sqlcs;
if sqlcs.sqlcode <> 0 then
	messagebox("DB접속오류",sqlcs.sqlerrtext) 
	halt 
end if	

dw_1.getchild("dept_cd",i_dwc_1)
i_dwc_1.settransobject(sqlcs)
i_dwc_1.retrieve("A03")
end event

event close;call super::close;disconnect using sqlcs;
end event

type uo_status from w_origin_sheet01`uo_status within w_qctl102u
end type

type dw_1 from datawindow within w_qctl102u
integer x = 9
integer y = 60
integer width = 4599
integer height = 2092
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_qctl102u_011"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;int	 Net
string l_s_emp_no, l_s_emp_cd

if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
		Net = messagebox("확 인", f_message("U090"), Question!, YesNoCancel!,2)
		if Net = 1 then
			parent.TriggerEvent("ue_save")
			if i_n_erreturn = -1 then
				return
			end if
		elseif Net = 3 then
			return
		end if
	end if
end if

if row < 1 then
	return
end if

dw_2.settransobject(sqlcs)

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

wf_rgbclear()    //	항목 Clear
l_s_emp_no = this.getitemstring(row, "emp_no")
l_s_emp_cd = this.getitemstring(row, "emp_cd")
dw_2.getchild("dept_cd",i_dwc_1)
i_dwc_1.settransobject(sqlcs)
i_dwc_1.retrieve("A03")
choose case l_s_emp_cd
	case '1     ' 
		i_dwc_1.retrieve("A03")
	case '2     '
		i_dwc_1.retrieve("A04")
	case '3     '
		i_dwc_1.retrieve("A05")			
	case '5     '
	case '4     ' 
end choose

dw_2.retrieve(l_s_emp_no)
dw_2.object.emp_no.Protect = True
dw_2.setfocus()
dw_2.setrow(1)
dw_2.setcolumn("emp_pwd")

i_s_selected =	"s"

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_b_save		=	True
i_b_delete	=	True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)

end event

type dw_2 from datawindow within w_qctl102u
integer x = 9
integer y = 2176
integer width = 4599
integer height = 304
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_qctl102u_021"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;if dwo.name = 'emp_no' then
	string l_s_name
	long l_n_forcnt
	
	SELECT count(*)	INTO :l_n_forcnt
	  FROM "PBCOMMON"."DAC003"  
	 WHERE "PBCOMMON"."DAC003"."PEEMPNO" = :data using sqlca;
	if l_n_forcnt =  0  then
		messagebox("개인번호 오류" ,"인사기본 자료가 없습니다.")
		this.object.emp_no.Background.Color = rgb(255,255,0)
		this.setfocus()
		return	
	end if
	
	SELECT penamek	INTO :l_s_name
	  FROM "PBCOMMON"."DAC003"  
	 WHERE "PBCOMMON"."DAC003"."PEEMPNO" = :data using sqlca;
	 
	this.object.kor_nm[1] = l_s_name
elseif dwo.name = 'emp_cd' then
	this.getchild("dept_cd",i_dwc_1)
	i_dwc_1.settransobject(sqlcs)
	choose case data
		case '1     ' 
  			i_dwc_1.retrieve("A03")
		case '2     '
  			i_dwc_1.retrieve("A04")
		case '3     '
  			i_dwc_1.retrieve("A05")			
		case '5     '
	   case '4     ' 
	end choose
end if	
end event

