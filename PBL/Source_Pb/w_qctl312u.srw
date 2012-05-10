$PBExportHeader$w_qctl312u.srw
$PBExportComments$line품질조치사항 등록
forward
global type w_qctl312u from w_origin_sheet03
end type
type dw_1 from datawindow within w_qctl312u
end type
type st_1 from statictext within w_qctl312u
end type
type dw_9 from datawindow within w_qctl312u
end type
type em_1 from editmask within w_qctl312u
end type
type em_2 from editmask within w_qctl312u
end type
type st_2 from statictext within w_qctl312u
end type
type dw_3 from datawindow within w_qctl312u
end type
type st_3 from statictext within w_qctl312u
end type
type dw_4 from datawindow within w_qctl312u
end type
type st_4 from statictext within w_qctl312u
end type
type st_status from statictext within w_qctl312u
end type
type dw_5 from datawindow within w_qctl312u
end type
type dw_down from datawindow within w_qctl312u
end type
type pb_1 from picturebutton within w_qctl312u
end type
end forward

global type w_qctl312u from w_origin_sheet03
dw_1 dw_1
st_1 st_1
dw_9 dw_9
em_1 em_1
em_2 em_2
st_2 st_2
dw_3 dw_3
st_3 st_3
dw_4 dw_4
st_4 st_4
st_status st_status
dw_5 dw_5
dw_down dw_down
pb_1 pb_1
end type
global w_qctl312u w_qctl312u

type variables
string i_s_comm_cd, i_s_comm_rpst, i_s_comm_deta, &
         i_s_click_cd, i_s_selected, i_s_sqlselect
real i_n_ser_no			
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();//dw_2.object.cust_cd.background.color    = rgb(255,250,239)				// Cream
//dw_2.object.dvsn.background.color       = rgb(255,255,255)
//dw_2.object.prod_cd.background.color 	 = rgb(255,255,255)				// White
//dw_2.object.itno.background.color 	    = rgb(255,255,255)
//dw_2.object.car_cd.background.color 	 = rgb(255,255,255)
//dw_2.object.def_qty.background.color 	 = rgb(255,255,255)
//dw_2.object.lot_no.background.color 	 = rgb(255,255,255)
//dw_2.object.def_status.background.color = rgb(255,255,255)
//dw_2.object.action_cd.background.color	 = rgb(255,255,255)
end subroutine

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

event open;call super::open;DataWindowChild dw_child1
integer	l_n_rowcount
string   l_s_date, l_s_emp_cd, l_s_dvsn

em_1.text = string(relativedate(today(),-1),"yyyy/mm/dd")
em_2.text = em_1.text

connect using sqlcs;
select emp_cd, dept_cd into :l_s_emp_cd, :l_s_dvsn from comm120
 where emp_no = :g_s_empno using sqlcs;
 
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
if l_s_emp_cd = '2     ' then
	dw_4.object.dvsn[1] = l_s_dvsn
	dw_4.enabled = false
else
	dw_4.enabled = true
end if	

dw_5.GetChild('dvsn', dw_child1)
dw_5.settransobject(sqlcs)
dw_child1.settransobject(sqlcs)
l_n_rowcount = dw_child1.retrieve("A06")
dw_5.insertrow(0)

i_s_sqlselect = dw_1.getsqlselect()

dw_1.GetChild('bad_reason', dw_child1)
f_pisc_set_dddw_width(dw_1,'bad_reason',dw_child1,'comm_nm1',5)

dw_1.GetChild('bad_type', dw_child1)
f_pisc_set_dddw_width(dw_1,'bad_type',dw_child1,'comm_nm1',5)

//if l_n_rowcount	>	0	then
//	i_s_click_cd	=	dw_3.getitemstring(1, "custnm")
//end if
end event

event ue_dprint;call super::ue_dprint;dw_1.Print()
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
string l_s_sqlselect, l_s_custcd, l_s_dvsn, l_s_cur_status
date l_d_sdt, l_d_ldt

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

setpointer(hourglass!)

em_1.getdata(l_d_sdt)
em_2.getdata(l_d_ldt)
l_s_custcd     = dw_3.getitemstring(1,"dvsn")
l_s_dvsn       = dw_4.getitemstring(1,"dvsn")
l_s_cur_status = dw_5.getitemstring(1,"dvsn")

l_s_sqlselect = i_s_sqlselect + " where process_dt >= '" + string(l_d_sdt,"yyyymmdd") +  &
   "' and process_dt <= '" + string(l_d_ldt,"yyyymmdd") + "'" 
	
if not (isnull(l_s_dvsn) or l_s_dvsn = '***') then
	l_s_sqlselect = l_s_sqlselect + " and dvsn = '" + l_s_dvsn + "'"  
end if

if not (isnull(l_s_custcd) or l_s_custcd = '***') then
	l_s_sqlselect = l_s_sqlselect + " and cust_cd = '" + l_s_custcd + "'"
end if

if not (isnull(l_s_cur_status) or l_s_cur_status = '***') then
	l_s_sqlselect = l_s_sqlselect + " and cur_status = '" + l_s_cur_status + "'"
end if

dw_1.SetTransObject(sqlcs)
dw_1.setsqlselect(l_s_sqlselect)
dw_1.retrieve()

if dw_1.rowcount()	= 0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	i_b_preview	=	False		  
	i_b_dprint	=	False		  
else
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
	i_b_preview	=	True		  
	i_b_dprint	=	True		  
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자

i_b_insert		=	False
i_b_save			=	True
i_b_delete		=	False
wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)
				  
setpointer(Arrow!)
end event

event ue_save;string  l_s_cust_cd,  l_s_comm_rpst, l_s_dvsn, l_s_prod_cd, l_s_itno, l_s_errchk, &
        l_s_column,   l_s_message
integer l_n_rowcount, l_n_rcnt, l_n_findrow 
real    l_n_ser_no
DataWindowChild dw_child1

dw_1.accepttext()
	
wf_rgbclear()

if dw_1.ModifiedCount() = 0 then
	dw_1.setfocus()
   uo_status.st_message.text	=  f_message("E020")		// 변경내용이 없습니다.
   return
end if

setpointer(hourglass!)
f_sysdate()

if dw_1.update() = 1 then
	commit using sqlcs;
   uo_status.st_message.text	=  f_message("U010")	// 저장되었습니다. 
	i_b_delete		=	False
	i_b_dprint		=	True	
	i_b_preview		=	True		  
else
	i_n_erreturn = -1
	rollback using sqlcs;
   uo_status.st_message.text	=  f_message("A020")	// [저장 실패] 정보시스템팀으로 연락바랍니다. 
end if

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 미리보기, 상세조회, 화면인쇄, 특수문자

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

on w_qctl312u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.dw_9=create dw_9
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.dw_3=create dw_3
this.st_3=create st_3
this.dw_4=create dw_4
this.st_4=create st_4
this.st_status=create st_status
this.dw_5=create dw_5
this.dw_down=create dw_down
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_9
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.em_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_status
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.dw_down
this.Control[iCurrent+14]=this.pb_1
end on

on w_qctl312u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.dw_9)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.st_4)
destroy(this.st_status)
destroy(this.dw_5)
destroy(this.dw_down)
destroy(this.pb_1)
end on

event close;call super::close;disconnect using sqlcs;
end event

type uo_status from w_origin_sheet03`uo_status within w_qctl312u
end type

type dw_1 from datawindow within w_qctl312u
integer x = 27
integer y = 208
integer width = 4567
integer height = 2264
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_qctl312u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_qctl312u
integer x = 713
integer y = 64
integer width = 265
integer height = 76
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

type dw_9 from datawindow within w_qctl312u
boolean visible = false
integer x = 3607
integer y = 12
integer width = 265
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_qctl211p_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_qctl312u
integer x = 969
integer y = 60
integer width = 407
integer height = 96
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

type em_2 from editmask within w_qctl312u
integer x = 1440
integer y = 60
integer width = 402
integer height = 96
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

type st_2 from statictext within w_qctl312u
integer x = 1874
integer y = 64
integer width = 265
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

type dw_3 from datawindow within w_qctl312u
integer x = 2139
integer y = 56
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

type st_3 from statictext within w_qctl312u
integer x = 23
integer y = 64
integer width = 265
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

type dw_4 from datawindow within w_qctl312u
integer x = 270
integer y = 60
integer width = 347
integer height = 92
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl311u_dvsn"
boolean livescroll = true
end type

type st_4 from statictext within w_qctl312u
integer x = 1385
integer y = 76
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

type st_status from statictext within w_qctl312u
integer x = 2606
integer y = 64
integer width = 192
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

type dw_5 from datawindow within w_qctl312u
integer x = 2798
integer y = 56
integer width = 347
integer height = 88
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl311u_dvsn"
boolean livescroll = true
end type

type dw_down from datawindow within w_qctl312u
boolean visible = false
integer x = 3886
integer y = 12
integer width = 256
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl312d_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_qctl312u
integer x = 3269
integer y = 32
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;dw_down.reset()

if dw_1.rowcount() < 1 then
	return 0
end if

dw_1.RowsCopy( 1, dw_1.RowCount(), Primary!, dw_down, 1, Primary!)

f_save_to_excel(dw_down)

end event

