$PBExportHeader$w_comm224u.srw
$PBExportComments$MESSAGE등록
forward
global type w_comm224u from w_origin_sheet01
end type
type st_1 from statictext within w_comm224u
end type
type gb_1 from groupbox within w_comm224u
end type
type dw_2 from datawindow within w_comm224u
end type
type dw_1 from datawindow within w_comm224u
end type
type sle_1 from singlelineedit within w_comm224u
end type
type rb_1 from radiobutton within w_comm224u
end type
type rb_2 from radiobutton within w_comm224u
end type
type st_2 from statictext within w_comm224u
end type
type gb_2 from groupbox within w_comm224u
end type
end forward

global type w_comm224u from w_origin_sheet01
st_1 st_1
gb_1 gb_1
dw_2 dw_2
dw_1 dw_1
sle_1 sle_1
rb_1 rb_1
rb_2 rb_2
st_2 st_2
gb_2 gb_2
end type
global w_comm224u w_comm224u

type variables
string   i_s_head_cd,  i_s_word_id, &
           i_s_addr_nm1, i_s_addr_nm2, i_s_addr_nm3, &
           i_s_addr_nm4, i_s_click_cd, i_s_selected
dec{0} i_n_seq_no
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();dw_2.object.word_id.background.color 	= rgb(255,250,239)				// Cream

dw_2.object.kor_word.background.color 	= rgb(255,255,255)				// White
end subroutine

on w_comm224u.create
int iCurrent
call super::create
this.st_1=create st_1
this.gb_1=create gb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.sle_1=create sle_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_2=create st_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.gb_2
end on

on w_comm224u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_2)
destroy(this.gb_2)
end on

event ue_delete;integer l_n_seq_no, l_n_row,  	 l_n_yesno,    l_n_findrow
string  l_s_word_id, l_s_newsql, l_s_oldsql

dw_2.accepttext()
l_n_row			=	dw_2.GetRow()
l_s_word_id    =  dw_2.object.word_id[l_n_row]

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_row		     =  0   then 
   	uo_status.st_message.text  =  f_message("E044")	// 삭제할 자료를 선택한 후 바랍니다.
   	return
	end if
end if

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_s_word_id	<> i_s_word_id then
		uo_status.st_message.text	=  f_message("I016")	// 조회시 Key와 다르면 처리할 수 없습니다.
		return
	end if
end if

l_n_yesno = messagebox("삭제 확인","해당자료를 삭제 하시겠습니까?",Question!,OkCancel!,2)
if l_n_yesno <> 1  then
	Return
end if

setpointer(hourglass!)

dw_2.SetTransObject(SQLCA)
dw_2.deleteRow(l_n_row)

if dw_2.update() = 1 then
	commit using sqlca;
	uo_status.st_message.text	=  f_message("E041")	// 삭제되었습니다. 	

	dw_1.SetTransObject(sqlca)
	l_s_oldsql    		   = 	dw_1.getsqlselect()
	l_s_newsql       	   = 	l_s_oldsql
	
	if rb_1.Checked      = 	True then
		l_s_newsql 		  += 	" ORDER BY word_id ASC "
	else
		l_s_newsql		  += 	" ORDER BY kor_word ASC, word_id ASC"	
	end if
	
	l_n_findrow = dw_1.find("word_id = '" + string(l_s_word_id) + "'", 1, dw_1.rowcount() )
	dw_1.SetSQLSelect(l_s_newsql)
	dw_1.retrieve()
	dw_1.SetSQLSelect(l_s_oldsql)

	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_findrow,true)
	end if
	dw_2.reset()
else
	rollback using sqlca;
	uo_status.st_message.text	=  f_message("E045")	// [삭제실패] 전산정보원으로 연락바랍니다. 
end if

i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	False

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

event ue_insert;datawindowChild dw_child1
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

dw_2.reset()

dw_2.settransobject(sqlca)
dw_2.insertrow(0)

wf_rgbclear()														//	항목 Clear	

//dw_2.object.addr_nm1.Protect 			=	False
dw_2.setfocus()
dw_2.setrow(1)
dw_2.setcolumn("word_id")

dw_1.selectrow( 0, false )

i_s_selected   =	"i"
i_b_insert		=	True
i_b_save			=	True
i_b_delete		=	False

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;string	l_s_oldsql, l_s_newsql, l_s_addr_nm1
int Net,l_n_rtcd

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

setpointer(hourglass!)

dw_1.SetTransObject(sqlca)

l_s_oldsql    		   = 	dw_1.getsqlselect()
l_s_newsql       	   = 	l_s_oldsql

if sle_1.text		   <>  '' then
   l_s_newsql			  += 	" WHERE word_id LIKE '" + sle_1.text + "%" + "' "
end if
if rb_1.Checked      = 	True then
	l_s_newsql 		  += 	" ORDER BY word_id ASC"
else
	l_s_newsql 		  += 	" ORDER BY kor_word ASC,word_id ASC"	
end if	
l_n_rtcd = dw_1.SetSQLSelect(l_s_newsql)
//messagebox("1",string(l_n_rtcd) + l_s_newsql)
dw_1.retrieve()
dw_1.SetSQLSelect(l_s_oldsql)

if dw_1.rowcount()	= 0	then
	uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
else
	uo_status.st_message.text 	= 	f_message("I010")		// 조회되었습니다.
end if
dw_2.reset()

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_s_selected	=	'r'

i_b_insert	=	True
i_b_save		=	False
i_b_delete	=	False

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
i_s_head_cd		=	i_s_click_cd								//	Key save
setpointer(Arrow!)
end event

event ue_save;string  l_s_word_id,  l_s_kor_word, l_s_errchk,   l_s_column,   l_s_message,  l_s_newsql,   l_s_oldsql
integer l_n_rowcount, l_n_rcnt,		l_n_findrow 

dw_2.accepttext()
l_n_rowcount	=  dw_1.GetSelectedRow(0)

if f_spacechk(i_s_selected) = -1 or i_s_selected = "r" then
	if l_n_rowcount     =  0   then 
   	uo_status.st_message.text	=  f_message("U070")	// 저장할 자료를 선택한 후 처리바랍니다."
   	return
	end if
end if

l_s_word_id		= 	trim(dw_2.getitemstring( 1, "WORD_ID"))
l_s_kor_word	= 	trim(dw_2.getitemstring( 1, "KOR_WORD"))

//////////	   기존 Data 존재 여부 Check  	//////////
SELECT count(*) 	INTO :l_n_rcnt		
  FROM PBCOMMON.COMM240  
 WHERE word_id 	= :l_s_word_id  using sqlca  ;

wf_rgbclear()
if i_s_selected	= "i" then
	if l_n_rcnt   	>  0  then
   	uo_status.st_message.text	=  f_message("A060")	// 입력할 자료가 이미 존재합니다 
	   dw_2.object.word_id.Background.Color		= 	rgb(255,255,0)
		dw_2.setcolumn("word_id")
		dw_2.setfocus()
   	return
	end if
end if

///////////    	Body Editing Check Area		///////////
if isnull(l_s_word_id) or len(l_s_word_id) <> 4 then	
   dw_2.object.word_id.Background.Color = rgb(255,255,0)	
	l_s_column	=	"word_id"		
end if

if f_spacechk(dw_2.getitemstring(1,"kor_word"))		= -1  then
   dw_2.object.kor_word.Background.Color = rgb(255,255,0)	
	if len(l_s_column) < 1 then			
	   l_s_column	=	"kor_word"			
	end if
end if

if len(l_s_column)	> 0 then									// Editing Error
	dw_2.setcolumn(l_s_column)
	dw_2.setfocus()
	uo_status.st_message.text	=	f_message("E010")		// 노랑색 항목을 수정 후 처리바랍니다.	
	i_n_erreturn = -1
	return
end if

if i_s_selected = "r" and dw_2.ModifiedCount() = 0 then
	dw_1.setfocus()
   uo_status.st_message.text  =	f_message("E020")		// 변경내용이 없습니다.
   return
end if

setpointer(hourglass!)
f_sysdate()
dw_2.settransobject(sqlca)
if i_s_selected 				= 	"i" then
	dw_2.object.inpt_id[1] 	= 	g_s_empno
	dw_2.object.inpt_dt[1] 	= 	g_s_datetime
end if
dw_2.object.updt_id[1]		= 	g_s_empno
dw_2.object.updt_dt[1] 		= 	g_s_datetime
dw_2.object.ip_addr[1] 		= 	g_s_ipaddr
dw_2.object.mac_addr[1]		= 	g_s_macaddr

if dw_2.update() = 1 then
	commit using sqlca;

	if i_s_selected 		= "i" then
	   uo_status.st_message.text	=	f_message("A010")	// 입력되었습니다.
	else
      uo_status.st_message.text 	= 	f_message("U010")	// 저장되었습니다. 
	end if

	dw_1.SetTransObject(sqlca)

	l_s_oldsql    		   = 	dw_1.getsqlselect()
	l_s_newsql       	   = 	l_s_oldsql
	
	if rb_1.Checked      = 	True then
		l_s_newsql 		  += 	" ORDER BY WORD_ID ASC "
	else
		l_s_newsql 		  += 	" ORDER BY KOR_WORD ASC, WORD_ID ASC"
	end if
	
	dw_1.SetSQLSelect(l_s_newsql)
	dw_1.retrieve()
	dw_1.SetSQLSelect(l_s_oldsql)
	dw_2.retrieve(l_s_word_id)
	
	l_n_findrow = dw_1.find("word_id = '" + string(l_s_word_id) + "'", 1, dw_1.rowcount() )
	if l_n_findrow > 0 then
		dw_1.scrolltorow(l_n_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_findrow,true)
	end if

	i_b_dprint		=	True	
	i_b_delete		=	True
	i_s_word_id		=	l_s_word_id
	i_s_selected 	= 	"r"
else
	i_n_erreturn 	= 	-1
	rollback using SQLCA;
	if i_s_selected 		= "i" then
	   uo_status.st_message.text 	= 	f_message("A020")	// [입력실패] 정보시스템팀으로 연락바랍니다. 
	else
	   uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 
	end if
end if

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)

setpointer(Arrow!)
end event

event closequery;int Net
//--	Return 0 : Closing, 	Return 1 : Not Closed	
if i_s_level = "5"	then
	dw_2.accepttext()
	if dw_2.modifiedcount() > 0 then
	
		this.SetPosition(ToTop!)
		this.WindowState	=	Normal!
		
		Net		= 	messagebox("확 인", f_message("U090"), Question!, YesNoCancel!,2)
		if 	Net	= 	1 then
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

type uo_status from w_origin_sheet01`uo_status within w_comm224u
integer x = 32
integer y = 2472
integer width = 4576
integer taborder = 10
end type

type st_1 from statictext within w_comm224u
integer x = 46
integer y = 60
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
boolean enabled = false
string text = "시작CODE"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_comm224u
integer x = 32
integer y = 12
integer width = 1147
integer height = 172
integer taborder = 20
integer textsize = -2
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_2 from datawindow within w_comm224u
integer x = 32
integer y = 2040
integer width = 4567
integer height = 428
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_comm224u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_comm224u
integer x = 32
integer y = 200
integer width = 4567
integer height = 1828
integer taborder = 50
string dataobject = "d_comm224u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;decimal{0}	l_n_seq_no
string  		l_s_word_id,   l_s_addr_nm1, l_s_addr_nm2, l_s_addr_nm3, l_s_addr_nm4
datawindowChild dw_child1
int Net

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

if row	< 1 then
  	uo_status.st_message.text	=  f_message("I017")		// 조회한 후 에 처리바랍니다.
	return
end if

dw_2.settransobject(sqlca)
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

wf_rgbclear()															//	항목 Clear	
l_s_word_id		=	this.getitemstring(row, "word_id")	
dw_2.retrieve(l_s_word_id)
dw_2.modify("word_id.taborder = 0")
dw_2.setfocus()
dw_2.setrow(1)
dw_2.setcolumn("kor_word")

i_s_selected   = 	"r"

i_b_save		=	True
i_b_delete	=	True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)

i_s_word_id		= l_s_word_id										// Key Save
end event

type sle_1 from singlelineedit within w_comm224u
integer x = 494
integer y = 48
integer width = 663
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_comm224u
integer x = 1710
integer y = 60
integer width = 347
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "코드순"
boolean checked = true
end type

event clicked;
dw_1.SetSort("WORD_ID A")
dw_1.Sort( )
dw_1.ScrollToRow(dw_1.GetSelectedRow(0))


end event

type rb_2 from radiobutton within w_comm224u
integer x = 2107
integer y = 60
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
string text = "Message명순"
end type

event clicked;
dw_1.SetSort("kor_word, word_id A")
dw_1.Sort( )
dw_1.ScrollToRow(dw_1.GetSelectedRow(0))
end event

type st_2 from statictext within w_comm224u
integer x = 1230
integer y = 60
integer width = 453
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
boolean enabled = false
string text = "조회순서⇒"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_comm224u
integer x = 1184
integer y = 12
integer width = 1541
integer height = 172
integer taborder = 30
integer textsize = -2
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

