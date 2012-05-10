$PBExportHeader$w_qctl311u.srw
$PBExportComments$line품질불량 등록
forward
global type w_qctl311u from w_origin_sheet03
end type
type dw_1 from datawindow within w_qctl311u
end type
type dw_2 from datawindow within w_qctl311u
end type
type st_1 from statictext within w_qctl311u
end type
type dw_9 from datawindow within w_qctl311u
end type
type em_1 from editmask within w_qctl311u
end type
type em_2 from editmask within w_qctl311u
end type
type st_2 from statictext within w_qctl311u
end type
type dw_3 from datawindow within w_qctl311u
end type
type st_3 from statictext within w_qctl311u
end type
type dw_4 from datawindow within w_qctl311u
end type
type st_4 from statictext within w_qctl311u
end type
type dw_5 from datawindow within w_qctl311u
end type
type st_status from statictext within w_qctl311u
end type
type st_5 from statictext within w_qctl311u
end type
type dw_6 from datawindow within w_qctl311u
end type
type gb_1 from groupbox within w_qctl311u
end type
end forward

global type w_qctl311u from w_origin_sheet03
dw_1 dw_1
dw_2 dw_2
st_1 st_1
dw_9 dw_9
em_1 em_1
em_2 em_2
st_2 st_2
dw_3 dw_3
st_3 st_3
dw_4 dw_4
st_4 st_4
dw_5 dw_5
st_status st_status
st_5 st_5
dw_6 dw_6
gb_1 gb_1
end type
global w_qctl311u w_qctl311u

type variables
string i_s_comm_cd, i_s_comm_rpst, i_s_comm_deta, &
         i_s_click_cd, i_s_selected, i_s_sqlselect
real i_n_ser_no			
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();dw_2.object.cust_cd.background.color    = rgb(255,250,239)				// Cream
dw_2.object.dvsn.background.color       = rgb(255,255,255)
dw_2.object.prod_cd.background.color 	 = rgb(255,255,255)				// White
dw_2.object.itno.background.color 	    = rgb(255,255,255)
dw_2.object.car_cd.background.color 	 = rgb(255,255,255)
dw_2.object.def_qty.background.color 	 = rgb(255,255,255)
dw_2.object.lot_no.background.color 	 = rgb(255,255,255)
dw_2.object.def_status.background.color = rgb(255,255,255)
dw_2.object.action_cd.background.color	 = rgb(255,255,255)
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
string   l_s_date

em_1.text = string(relativedate(today(),-1),"yyyy/mm/dd")
em_2.text = em_1.text
connect using sqlcs;

dw_3.GetChild('dvsn', dw_child1)
dw_3.settransobject(sqlcs)
dw_child1.settransobject(sqlcs)
l_n_rowcount = dw_child1.retrieve("A05")
dw_3.insertrow(0)

dw_4.GetChild('dvsn', dw_child1)
dw_4.settransobject(sqlcs)
dw_child1.settransobject(sqlcs)
l_n_rowcount = dw_child1.retrieve("A04")
dw_4.insertrow(0)

dw_5.GetChild('dvsn', dw_child1)
dw_5.settransobject(sqlcs)
dw_child1.settransobject(sqlcs)
l_n_rowcount = dw_child1.retrieve("A06")
dw_5.insertrow(0)

dw_6.GetChild('expo', dw_child1)
dw_6.settransobject(sqlcs)
dw_child1.settransobject(sqlcs)
l_n_rowcount = dw_child1.retrieve("A07")
dw_6.insertrow(0)

i_s_sqlselect = dw_1.getsqlselect()

//if l_n_rowcount	>	0	then
//	i_s_click_cd	=	dw_3.getitemstring(1, "custnm")
//end if
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
date l_d_process_dt

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

if f_spacechk(i_s_click_cd)	= -1 or i_s_click_cd = '*' then
  	uo_status.st_message.text	=	f_message("E241")		// 거래처를 선택한 후 처리바랍니다.	  
	return
end if	

//if f_spacechk(i_s_selected)	= -1 then
//  	uo_status.st_message.text	=  f_message("I060")		// 조회한 후에 입력바랍니다.
//	return
//end if	
//if i_s_click_cd	<>	i_s_comm_rpst then
//  	uo_status.st_message.text	=  f_message("I090")		// 조회시 Key와 다르면 처리할 수 없습니다.
//	return
//end if
	
dw_2.reset()
dw_2.insertrow(0)

wf_rgbclear()														//	항목 Clear	

dw_2.object.cust_cd[1]      	   = i_s_click_cd
dw_2.object.cur_status[1]        = 'A06001'    
em_1.getdata(l_d_process_dt)

dw_2.object.process_dt[1]        = string(l_d_process_dt,"yyyymmdd")

dw_2.setfocus()
dw_2.setrow(1)
dw_2.setcolumn("dvsn")

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

event ue_preview;call super::ue_preview;//window 	l_to_open
//str_easy l_str_prt
//
////출력 윈도우에 Data 전달, 출력 윈도우 Open 
//SetPointer(HourGlass!)
//
//uo_status.st_message.Text = "출력 준비중 입니다..."
//dw_9.SetTransObject(sqlcs)
//dw_9.retrieve(i_s_click_cd)
//
//string l_s_cbx_cd
//if cbx_1.checked then
//	l_s_cbx_cd = "a"
//else
//	l_s_cbx_cd = "d"
//end if
//
////end if
////인쇄 DataWindow 저장
//l_str_prt.transaction  = sqlcs
//l_str_prt.datawindow   = dw_9
//l_str_prt.title = "공통코드 출력"
//l_str_prt.tag			  = This.ClassName()
//
//f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
//Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
//
//uo_status.st_message.Text = ""	
//
end event

event ue_retrieve;call super::ue_retrieve;int Net
string l_s_sqlselect, l_s_custcd, l_s_dvsn, l_s_cur_status, l_s_expo_conn
date l_d_sdt, l_d_ldt

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
//if f_spacechk(i_s_click_cd) 	= 	-1 then
//  	uo_status.st_message.text	=	f_message("E243")		// 대표코드를 선택한 후 처리바랍니다.	  
//	return
//end if

setpointer(hourglass!)

em_1.getdata(l_d_sdt)
em_2.getdata(l_d_ldt)
l_s_custcd     = dw_3.getitemstring(1,"dvsn")
l_s_dvsn       = dw_4.getitemstring(1,"dvsn")
l_s_cur_status = dw_5.getitemstring(1,"dvsn")
l_s_expo_conn = dw_6.getitemstring(1,"expo")

l_s_sqlselect = i_s_sqlselect + " where process_dt >= '" + string(l_d_sdt,"yyyymmdd") +  &
   "' and process_dt <= '" + string(l_d_ldt,"yyyymmdd") + "'"   

if not (isnull(l_s_custcd) or l_s_custcd = '***') then
	l_s_sqlselect = l_s_sqlselect + " and cust_cd = '" + l_s_custcd + "'"
end if

if not (isnull(l_s_dvsn) or l_s_dvsn = '***') then
	l_s_sqlselect = l_s_sqlselect + " and dvsn = '" + l_s_dvsn + "'"
end if

if not (isnull(l_s_cur_status) or l_s_cur_status = '***') then
	l_s_sqlselect = l_s_sqlselect + " and cur_status = '" + l_s_cur_status + "'"
end if

if not (isnull(l_s_expo_conn) or l_s_expo_conn = '***') then
	l_s_sqlselect = l_s_sqlselect + " and expo_conn = '" + l_s_expo_conn + "'"
end if

dw_1.SetTransObject(sqlcs)
dw_1.setsqlselect(l_s_sqlselect)
dw_1.retrieve()
dw_2.settransobject(sqlcs)

if dw_1.rowcount()	= 0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	i_b_preview	=	False		  
	i_b_dprint	=	False		  
else
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

event ue_save;string  l_s_cust_cd,  l_s_comm_rpst, l_s_dvsn, l_s_prod_cd, l_s_itno, l_s_errchk, &
        l_s_column,   l_s_message
integer l_n_rowcount, l_n_rcnt, l_n_findrow 
real    l_n_ser_no
DataWindowChild dw_child1

dw_2.accepttext()
l_n_rowcount	=  dw_1.GetSelectedRow(0)

l_s_cust_cd	   = 	trim(dw_2.getitemstring( 1, "cust_cd"))
	
wf_rgbclear()
///////////    	Body Editing Check Area		///////////
if f_spacechk(dw_2.getitemstring(1,"dvsn"))		= -1  then
   dw_2.object.dvsn.Background.Color = rgb(255,255,0)	
   l_s_column	=	"dvsn"			
end if

if f_spacechk(dw_2.getitemstring(1,"prod_cd"))		= -1  then
   dw_2.object.prod_cd.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"prod_cd"			
	end if
end if

if f_spacechk(dw_2.getitemstring(1,"itno"))		= -1  then
   dw_2.object.itno.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"itno"			
	end if
end if

if f_spacechk(dw_2.getitemstring(1,"car_cd"))		= -1  then
   dw_2.object.car_cd.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"car_cd"			
	end if
end if

if f_spacechk(dw_2.getitemstring(1,"lot_no"))		= -1  then
   dw_2.object.lot_no.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"lot_no"			
	end if
end if

if f_numchk(string(dw_2.getitemnumber(1,"def_qty")))       = -1 or dw_2.getitemnumber(1,"def_qty") = 0 then
   dw_2.object.def_qty.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"def_qty"			
	end if
end if

if f_spacechk(dw_2.getitemstring(1,"def_status"))		= -1  then
   dw_2.object.def_status.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"car_status"			
	end if
end if

if f_spacechk(dw_2.getitemstring(1,"action_cd"))		= -1  then
   dw_2.object.action_cd.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then
	   l_s_column	=	"action_cd"			
	end if
end if

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
else
	l_n_ser_no = 1
	select max(ser_no) + 1 into :l_n_ser_no from main200
	 where cust_cd = :l_s_cust_cd using sqlcs;
	if isnull(l_n_ser_no) then l_n_ser_no = 1 
	dw_2.object.ser_no[1] 	= 	l_n_ser_no 
end if

setpointer(hourglass!)
f_sysdate()
dw_2.settransobject(sqlcs)
//if i_s_selected = "i" then
//	dw_2.object.inpt_id[1] 	= 	g_s_empno
//	dw_2.object.inpt_dt[1] 	= 	g_s_datetime
//end if
//dw_2.object.updt_id[1]		= 	g_s_empno
//dw_2.object.updt_dt[1] 		= 	g_s_datetime
//dw_2.object.ip_addr[1] 		= 	g_s_ipaddr
//dw_2.object.mac_addr[1]		= 	g_s_macaddr

if dw_2.update() = 1 then
	commit using sqlcs;

	if i_s_selected 		= "i" then
	   uo_status.st_message.text	=  f_message("A010")	// 입력되었습니다.
	else
      uo_status.st_message.text	=  f_message("U010")	// 저장되었습니다. 
	end if
	dw_1.settransobject(sqlcs)
	dw_1.retrieve()
	
	l_n_findrow = dw_1.find("cust_cd = " + "'" + l_s_cust_cd + "' and ser_no = " + string(l_n_ser_no) , 1, dw_1.rowcount() )
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_findrow,true)
	end if

	i_b_delete		=	True
	i_b_dprint		=	True	
	i_b_preview		=	True		  
	i_s_click_cd		=	l_s_cust_cd
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

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

on w_qctl311u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_9=create dw_9
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.dw_3=create dw_3
this.st_3=create st_3
this.dw_4=create dw_4
this.st_4=create st_4
this.dw_5=create dw_5
this.st_status=create st_status
this.st_5=create st_5
this.dw_6=create dw_6
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_9
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.em_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.st_status
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.dw_6
this.Control[iCurrent+16]=this.gb_1
end on

on w_qctl311u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_9)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.st_4)
destroy(this.dw_5)
destroy(this.st_status)
destroy(this.st_5)
destroy(this.dw_6)
destroy(this.gb_1)
end on

event close;call super::close;disconnect using sqlcs;
end event

type uo_status from w_origin_sheet03`uo_status within w_qctl311u
end type

type dw_1 from datawindow within w_qctl311u
integer x = 32
integer y = 208
integer width = 4562
integer height = 1508
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_qctl311u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;int Net
string l_s_comm_cd, l_s_comm_rpst
real l_n_ser_no

if row < 1 then
  return
end if

uo_status.st_message.text	=  ""

if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
		Net = messagebox("확 인", f_message("E028"), Question!, YesNoCancel!,2)
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

if i_s_click_cd	<>	i_s_comm_rpst then
  	uo_status.st_message.text	=  f_message("I016")		// 조회시 Key와 다르면 처리할 수 없습니다.
	return
end if

if row	< 1 then
  	uo_status.st_message.text	=  f_message("I017")		// 조회한 후 에 처리바랍니다.
	return
end if

dw_2.settransobject(sqlcs)
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

wf_rgbclear()														//	항목 Clear	
l_s_comm_cd				=	this.getitemstring(row, "cust_cd")	
l_n_ser_no				=	this.getitemnumber(row, "ser_no")
dw_2.retrieve(l_s_comm_cd,l_n_ser_no)

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
i_n_ser_no     =  l_n_ser_no
end event

type dw_2 from datawindow within w_qctl311u
integer x = 32
integer y = 1740
integer width = 4562
integer height = 728
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_qctl311u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_qctl311u
integer x = 87
integer y = 60
integer width = 261
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "발생일"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_9 from datawindow within w_qctl311u
boolean visible = false
integer x = 4050
integer y = 12
integer width = 494
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_qctl211p_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_qctl311u
integer x = 347
integer y = 60
integer width = 407
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
end type

type em_2 from editmask within w_qctl311u
integer x = 818
integer y = 60
integer width = 402
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
end type

type st_2 from statictext within w_qctl311u
integer x = 1262
integer y = 60
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "거래처"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_qctl311u
integer x = 1518
integer y = 60
integer width = 347
integer height = 88
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl311u_dvsn"
boolean livescroll = true
end type

event itemchanged;i_s_click_cd = this.gettext()
end event

type st_3 from statictext within w_qctl311u
integer x = 1906
integer y = 60
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "공 장"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_qctl311u
integer x = 2144
integer y = 60
integer width = 347
integer height = 92
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl311u_dvsn"
boolean livescroll = true
end type

type st_4 from statictext within w_qctl311u
integer x = 763
integer y = 68
integer width = 46
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "-"
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_qctl311u
integer x = 2729
integer y = 60
integer width = 347
integer height = 88
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl311u_dvsn"
boolean livescroll = true
end type

type st_status from statictext within w_qctl311u
integer x = 2542
integer y = 60
integer width = 183
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "상태"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_qctl311u
integer x = 3113
integer y = 64
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "지수연계"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_6 from datawindow within w_qctl311u
integer x = 3447
integer y = 60
integer width = 512
integer height = 88
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl311u_expo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_qctl311u
integer x = 32
integer width = 4009
integer height = 184
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylebox!
end type

