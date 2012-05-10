$PBExportHeader$w_per005u.srw
$PBExportComments$공지사항 입력
forward
global type w_per005u from w_origin_sheet09
end type
type dw_1 from datawindow within w_per005u
end type
type st_1 from statictext within w_per005u
end type
type mle_1 from multilineedit within w_per005u
end type
type dw_prm from datawindow within w_per005u
end type
type dw_2 from datawindow within w_per005u
end type
type rr_1 from roundrectangle within w_per005u
end type
end forward

global type w_per005u from w_origin_sheet09
dw_1 dw_1
st_1 st_1
mle_1 mle_1
dw_prm dw_prm
dw_2 dw_2
rr_1 rr_1
end type
global w_per005u w_per005u

type variables
string  i_s_gubun_idx1 ,i_s_gubun_idx2 ,i_s_selected , i_s_yy , i_s_gubun, is_win_id
int     i_i_LastRow ,	i_n_tabindex ,i_n_errcnt 

str_easy	 i_str_prt
end variables

on w_per005u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.mle_1=create mle_1
this.dw_prm=create dw_prm
this.dw_2=create dw_2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.dw_prm
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.rr_1
end on

on w_per005u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.mle_1)
destroy(this.dw_prm)
destroy(this.dw_2)
destroy(this.rr_1)
end on

event open;call super::open;string RunParm

datawindowchild cdw_1

RunParm = g_s_runparm   // Open시 KDAC종합정보시스템으로 부터 실행 파라미터를 받는다.
// Run_Parameter로 해당 업무처리.
Choose Case RunParm
	Case 'S' //협력사원
		dw_prm.getchild('code', cdw_1)
		cdw_1.SetTransObject(sqlcc)
		cdw_1.Retrieve('w_psm')		
		is_win_id = 'w_psm111u'
		dw_prm.object.code[1] = is_win_id
	Case 'Y'//연말정산관리
		dw_prm.getchild('code', cdw_1)
		cdw_1.SetTransObject(sqlcc)
		cdw_1.Retrieve('w_pay0')		
		is_win_id = 'w_pay066u'
		dw_prm.object.code[1] = is_win_id
	case '' //시스템관리
		dw_prm.getchild('code', cdw_1)
		cdw_1.SetTransObject(sqlcc)
		cdw_1.Retrieve('w_')		
		is_win_id = 'w_acnt002u'
		dw_prm.object.code[1] = is_win_id
End Choose

dw_prm.setfocus()

i_b_insert	  =	true
i_b_save		  =	false
i_b_delete	  =	false
i_b_retrieve = true
i_b_print    = FALSE
i_b_dprint   = FALSE

//this.postevent("ue_retrieve")

/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
					  i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;int     ln_cnt

if f_spacechk(is_win_id) = -1  then
	messagebox('프로그램 선택','공지할 프로그램을 선택 후 조회바랍니다.')
	RETURN
END IF

ln_cnt  = dw_1.retrieve(is_win_id)

if ln_cnt > 0  then	
	uo_status.st_message.text	= string(ln_cnt) + ' 건이 조회되었습니다.'
else	
	uo_status.st_message.text	= '조회할 DATA가 존재하지 않습니다.'
end if


i_b_insert	 =	true
i_b_save		 =	true
i_b_delete	 =	false
i_b_retrieve = true
i_b_print    = FALSE
i_b_dprint   = FALSE



/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
					  i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)
end event

event ue_save;call super::ue_save;Int    li_Rtn
string ls_descrip

dw_2.accepttext()
ls_descrip  = trim(mle_1.text)

If f_Mandatory_Chk( dw_2 ) = -1 Then // 필수입력항목 Check...
	Return 1 
End If

IF dw_2.ModifiedCount() < 1 and f_spacechk(ls_descrip) = -1 Then
	MessageBox("확인!", "변경된 데이터가 없습니다. ", Exclamation!)
	Return
End if

setpointer(hourglass!)

f_sysdate()
dw_2.object.text[1] = ls_descrip

f_per_nullchk( dw_2 )
f_per_inptid( dw_2 )

li_Rtn = dw_2.Update(True, False)

If li_rtn = 1 Then		
	dw_2.ResetUpdate( )	
   uo_status.st_message.Text = f_message('U010') // 저장되었습니다.		
Else	
	uo_status.st_message.text = f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다. 	
	return
End If

this.triggerevent("ue_retrieve")

setpointer(arrow!)


i_b_insert	  = false
i_b_save		  = true
i_b_delete	  = false
i_b_retrieve = true
i_b_print    = FALSE
i_b_dprint   = FALSE



/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
					  i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_insert;call super::ue_insert;dw_2.SetReDraw(False)

dw_2.Reset()
dw_2.InsertRow( 0 )
mle_1.text = ''


dw_2.SetItemStatus(1, 0, Primary!, NotModified!)

dw_2.object.win_id[1] = is_win_id  

f_Color_Protect( dw_2 )

dw_2.SetColumn( 'frdt' )
dw_2.SetFocus()

dw_2.SetReDraw(True)

i_b_save	 =	True

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
					  i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)

end event

event ue_delete;call super::ue_delete;Int li_Rtn, li_cnt
long ll_cnt, ll_row, ll_rowcnt

ll_rowcnt = dw_1.GetSelectedRow(0)

If ll_rowcnt = 0 Then
	MessageBox('확인!', "삭제할 정보가 없습니다.", Exclamation!)
	Return
End If

li_Rtn = MessageBox('확인!', "선택한 정보를 정말 삭제하시겠습니까?", Question!, YesNo!, 2)

If li_Rtn = 2 Then Return

dw_1.DeleteRow( ll_rowcnt )    // 정보 Primary Buffer에서 삭제.

li_Rtn = dw_1.Update(True, False )
		
If li_Rtn = 1 Then
	
	dw_1.ResetUpdate()
	Commit Using SQLCC ;
	uo_status.st_message.Text = f_message('D010')  // 삭제 되었습니다.
	
Else
	
	RollBack Using SQLCC ;
	uo_status.st_message.Text = f_message('D020')  // [삭제실패] 정보시스템팀으로 연락바랍니다.

End If

this.triggerevent("ue_retrieve")

end event

type uo_status from w_origin_sheet09`uo_status within w_per005u
end type

type dw_1 from datawindow within w_per005u
integer x = 9
integer y = 116
integer width = 2295
integer height = 2368
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_per005u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlcc)
end event

event clicked;string  ls_win_id,ls_frdt, ls_descrip

//if f_spacechk(mle_1.text) <> -1 then
//	parent.triggerevent("ue_save")
//end if

this.selectrow(0, false)
if row > 0 then
	i_s_selected = 'r'
	this.selectrow(row,true)
	
	ls_win_id  = dw_1.GetItemString( row, "win_id")
	ls_frdt    = dw_1.GetItemString( row, "frdt")
	mle_1.text = ''
	ls_descrip = ''
//	dw_2.reset()
	dw_2.retrieve(ls_win_id,ls_frdt)
	
	select text
	into :ls_descrip
	from  pbper.perdsp
	where win_id = :ls_win_id   and
	      frdt   = :ls_frdt
	using sqlcc ;
	
	if sqlcc.sqlcode  <> 0  then
		return
	end if
	if ls_descrip = ''  or isnull(ls_descrip)  then
		uo_status.st_message.text	= '조회할 DATA가 존재하지 않습니다.'
		ls_descrip = ''
	else
	   uo_status.st_message.text	= '조회되었습니다'		
	end if
	mle_1.text = ls_descrip
//	i_b_insert	 =	false
	i_b_save		 =	true
	i_b_delete	 =	true
	i_b_retrieve = true
	i_b_print    = FALSE
	i_b_dprint   = FALSE
end if


/////////////////////////////////////////////////////////
// Buffered Button Status Setting
/////////////////////////////////////////////////////////
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
					  i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)
end event

event rowfocuschanging;//parent.triggerevent("ue_save")
end event

type st_1 from statictext within w_per005u
integer x = 27
integer y = 32
integer width = 430
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "적용프로그램"
alignment alignment = right!
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_per005u
integer x = 2327
integer y = 676
integer width = 2277
integer height = 1760
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;f_toggle( handle(This), 'KOR' )
end event

type dw_prm from datawindow within w_per005u
event ue_keydown pbm_dwnkey
integer x = 457
integer width = 1362
integer height = 112
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_per005u_01"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

event constructor;datawindowchild cdw_1

this.settransobject(sqlcc)
this.insertrow(0)
this.getchild('code', cdw_1)
cdw_1.SetTransObject(sqlcc)
cdw_1.Retrieve('')

end event

event itemchanged;
Choose Case	dwo.Name
	
	Case 'code'  //코드 선택	
		is_win_id = data		
		
End choose

parent.triggerevent("ue_retrieve")
end event

type dw_2 from datawindow within w_per005u
integer x = 2327
integer y = 260
integer width = 2281
integer height = 404
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_per005u_03"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlcc)
end event

event getfocus;f_toggle( handle(This), 'KOR' )
end event

event itemchanged;string ls_win_id, ls_frdt, ls_todt
int li_cnt

ls_win_id = this.object.win_id[row]

Choose Case dwo.Name
	Case 'frdt' 				
		ls_todt = this.object.todt[row]
		
		if ls_todt < data then
			MessageBox("확인!", "시작일보다 늦을순 없습니다.", Exclamation!)
			Return 1
		End if
		
		select Max(todt) into :ls_todt
		from pbper.perdsp
		where win_id = :ls_win_id and todt < :ls_todt  using sqlcc;
		
		If IsDate( f_To_DateType( data ) ) = False Then
			MessageBox("확인!", "입력한 날짜가 형식에 맞지 않습니다.", Exclamation!)
			Return 1
		End If
		
		if f_spacechk(ls_todt) <> -1 and ls_todt >= data  then	
			MessageBox("확인!", "이전 게시기간과 포함됩니다.", Exclamation!)
			Return 1
		end if
		
				
	case 'todt'
		ls_frdt = this.object.frdt[row]
		
		if ls_frdt > data then
			MessageBox("확인!", "시작일보다 빠를순 없습니다.", Exclamation!)
			Return 1
		End if
		
		select Min(frdt) into :ls_frdt
		from pbper.perdsp
		where win_id = :ls_win_id and frdt > :ls_frdt  using sqlcc;
		
		If IsDate( f_To_DateType( data ) ) = False Then
			MessageBox("확인!", "입력한 날짜가 형식에 맞지 않습니다.", Exclamation!)
			Return 1
		End If
		
		if f_spacechk(ls_frdt) <> -1 and ls_frdt <= data  then	
			MessageBox("확인!", "이전 게시기간과 포함됩니다.", Exclamation!)
			Return 1
		end if
	
End Choose
end event

event itemerror;This.SetFocus( )
Return 1
end event

type rr_1 from roundrectangle within w_per005u
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 32435434
integer x = 2313
integer y = 124
integer width = 2309
integer height = 2356
integer cornerheight = 40
integer cornerwidth = 55
end type

