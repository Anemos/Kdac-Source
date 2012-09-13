$PBExportHeader$w_bpm101u.srw
$PBExportComments$통화단위별 환율관리
forward
global type w_bpm101u from w_origin_sheet01
end type
type dw_11 from datawindow within w_bpm101u
end type
type dw_10 from datawindow within w_bpm101u
end type
type pb_1 from picturebutton within w_bpm101u
end type
type cb_3 from commandbutton within w_bpm101u
end type
type cb_1 from commandbutton within w_bpm101u
end type
end forward

global type w_bpm101u from w_origin_sheet01
integer width = 4681
integer height = 2752
dw_11 dw_11
dw_10 dw_10
pb_1 pb_1
cb_3 cb_3
cb_1 cb_1
end type
global w_bpm101u w_bpm101u

type variables
String  is_Xplant, is_Div

Boolean ib_Insert = False

// Multi Select용~
Long il_preRow

// DataWindowChild
DataWindowChild idwc_xplant
DataWindowChild idwc_div


end variables

forward prototypes
public subroutine wf_rgbclear ()
public subroutine wf_click_retrieve (long al_row)
public function integer wf_stcd_chk (integer ll_tabno)
end prototypes

public subroutine wf_rgbclear ();
end subroutine

public subroutine wf_click_retrieve (long al_row);




end subroutine

public function integer wf_stcd_chk (integer ll_tabno);string ls_xyear, ls_stcd, ls_stcd1

//Choose case ll_tabno
//	case 1
	IF dw_10.accepttext() = -1  THEN
		MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
		uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
		Return -1
	END IF
	
	ls_xyear = trim(dw_10.object.xyear[1])
	IF ls_xyear = ''  THEN
		MessageBox('확인','사업계획년도를 확인하세요!')
		uo_status.st_message.text = '사업계획년도를 확인하세요!'
		Return -1
	END IF
	
	select coalesce(max(ingflag),''),coalesce(max(taskstatus),'') 
		into :ls_stcd, :ls_stcd1
	from pbbpm.bpm519
	where comltd = '01'
	and   xyear = :ls_xyear
	and   seqno = '100';  //전체상태는 아무자료나 가져와도 됨.
	
	IF ls_stcd <> 'G'  THEN
		MessageBox('작업불가',ls_xyear + '년 사업계획전체 작업이 종료되었습니다!')
		uo_status.st_message.text = ls_xyear + '년 사업계획전체 작업이 종료되었습니다!'
		Return -1
	END IF
	IF ls_stcd1 <> 'G'  THEN
		MessageBox('작업불가',ls_xyear + '년 사업계획 해당작업이 이미 확정되었습니다!')
		uo_status.st_message.text = ls_xyear + '년 사업계획 해당작업이 이미 확정되었습니다!'
		Return -1
	END IF
//case 2
//	IF idw_20.accepttext() = -1  THEN
//		MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
//		uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
//		Return -1
//	END IF
//	
//	ls_xyear = trim(idw_20.object.xyear[1])
//	IF ls_xyear = ''  THEN
//		MessageBox('확인','사업계획년도를 확인하세요!')
//		uo_status.st_message.text = '사업계획년도를 확인하세요!'
//		Return -1
//	END IF
//	
//	select coalesce(max(ingflag),''),coalesce(max(taskstatus),'') 
//		into :ls_stcd, :ls_stcd1
//	from pbbpm.bpm519
//	where comltd = '01'
//	and   xyear = :ls_xyear
//	and   seqno = '160';  //전체상태는 아무자료나 가져와도 됨.
//	
//	IF ls_stcd <> 'G'  THEN
//		MessageBox('작업불가',ls_xyear + '년 사업계획전체 작업이 종료되었습니다!')
//		uo_status.st_message.text = ls_xyear + '년 사업계획전체 작업이 종료되었습니다!'
//		Return -1
//	END IF
//	IF ls_stcd1 <> 'P'  THEN
//		MessageBox('작업불가',ls_xyear + '년 사업계획 품목기본정보 생성작업이 확정되었습니다!')
//		uo_status.st_message.text = ls_xyear + '년 사업계획 품목기본정보 생성작업이 확정되었습니다!'
//		Return -1
//	END IF
//End choose
return 1
end function

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////
// * 환율 등록 *      2003.09.05.  박진규
///////////////////////////////////////////////////////////////////////////////////////////

i_b_insert = True  // 입력가능.
i_b_dprint = True  // 화면인쇄 가능.

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

on w_bpm101u.create
int iCurrent
call super::create
this.dw_11=create dw_11
this.dw_10=create dw_10
this.pb_1=create pb_1
this.cb_3=create cb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_11
this.Control[iCurrent+2]=this.dw_10
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_1
end on

on w_bpm101u.destroy
call super::destroy
destroy(this.dw_11)
destroy(this.dw_10)
destroy(this.pb_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event ue_insert;
// 필수입력항목 Check...
dw_10.SetItemStatus( 1, 0, Primary!, DataModified! )
If f_Mandatory_Chk(dw_10) = -1 Then 
	i_n_erreturn = -1
	Return  
End If

String ls_year, ls_revno

ls_year = trim(dw_10.Object.xyear[1])
ls_revno = trim(dw_10.Object.revno[1])

if g_s_empno <> '970077' then
	IF wf_stcd_chk(1) = -1  THEN  //상태확인
		Return
	END IF
end if

dw_11.SetReDraw(False)

If ib_insert = False then
   dw_11.Reset()
End if

dw_11.InsertRow( 0 )

dw_11.SetItemStatus(1, 0, Primary!, NotModified!)

dw_11.Object.curr.BackGround.Color = 15780518  // 하늘색
dw_11.Object.exch.BackGround.Color = 15780518  // 하늘색

f_Color_Protect( dw_11 ) 

dw_11.SetColumn( 'curr' )
dw_11.SetFocus()

dw_11.SetReDraw(True)

ib_Insert = True
i_b_save	 =	True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;Choose Case f_dw_status(dw_11, i_s_level)	
	Case 1 // 처리중인던 작업 저장.
		This.TriggerEvent('ue_save')
		
		If i_n_erreturn = -1  Then
			uo_status.st_message.text = f_message("U040") // 저장할 수 없습니다.
			Return 1
		End If
	Case 3 // 취소.
		Return 1
End Choose

dw_10.SetItemStatus(1, 0, Primary!, DataModified!)
If f_mandatory_chk( dw_10 ) = -1 Then
	Return
End If

String ls_year, ls_revno

ls_year = Trim(dw_10.Object.xyear[1])
ls_revno = Trim(dw_10.Object.revno[1])

SetPointer(HourGlass!)

Integer li_Rcnt

li_Rcnt = dw_11.Retrieve( ls_year, ls_revno )

If li_Rcnt = 0 Then
	
	uo_status.st_message.Text = f_message("I020")    // 조회할 자료가 없습니다.
	i_b_save = False
	
Else
	
	dw_11.Object.curr.BackGround.Color = 536870912  // 회색
	dw_11.Object.exch.BackGround.Color = 536870912  // 회색
	f_Color_Protect( dw_11 )
	
	uo_status.st_message.Text = f_message("I010")    // 조회 되었습니다.
	
	ib_insert  = False
	i_b_delete = True
	i_b_save	  = True
	
End If

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)


end event

event ue_save;Int    li_Rtn	 
Long   ll_row, ll_rcnt
String ls_xyear, ls_revno, ls_curr,ls_msg
dec ld_exch


setpointer(hourglass!)
uo_status.st_message.Text = '자료확인중...'


If f_Mandatory_Chk( dw_10 ) = -1 Then // 필수입력항목 Check...
	i_n_erreturn = -1
	Return  
End If

If dw_10.AcceptText( ) = -1 Then
	MessageBox("확인!", "에러가 난곳을 수정한 후 저장하십시요.", Exclamation!)
	uo_status.st_message.Text = "에러가 난곳을 수정한 후 저장하십시요."
	Return
End If

ls_xyear = trim(dw_10.Object.xyear[1])
ls_revno = trim(dw_10.Object.revno[1])

IF g_s_empno <> '970077' then 
  if f_bpmstcd_chk('100',ls_xyear,ls_revno, ls_msg) = -1  THEN  //상태확인
     MessageBox("확인!",ls_msg)
	  uo_status.st_message.text = ls_msg
	  Return
  END IF
end if


If dw_11.AcceptText( ) = -1 Then
	MessageBox("확인!", "에러가 난곳을 수정한 후 저장하십시요.", Exclamation!)
	uo_status.st_message.Text = "에러가 난곳을 수정한 후 저장하십시요."
	Return
End If

f_Null_Kill(dw_11)      // NULL 값을 Space와 0으로 Setting.
	f_ExtColumn_Set(dw_11)  // 등록/수정 사번과 날짜, IP/MAC Address Setting.

For ll_row = 1 to dw_11.RowCount()
	
	//dw_11.Object.comltd[ll_row] = g_s_company  // Key Input...(회사)
	dw_11.Object.xyear[ll_row]  = ls_xyear      // Key Input...(년도)	
	dw_11.Object.revno[ll_row]  = ls_revno 
	ls_curr = trim(dw_11.object.curr[ll_row])
	
	select count(*) into :ll_rcnt
	from pbbpm.bpm506
	where xyear = :ls_xyear
	and   revno = :ls_revno
	and   curr = :ls_curr;
	if ll_rcnt > 0 then
	//if dw_11.getitemstatus(ll_row,0,Primary!) = Newmodified! then
		dw_11.setitemstatus(ll_row,0,primary!,Datamodified!)
	//end if
   end if
Next

uo_status.st_message.Text = '자료저장중...'
li_Rtn = dw_11.Update(True, False)
If li_Rtn = 1 Then
	////영업사업계획환율수정
   for ll_row = 1 to dw_11.rowcount()
		 ls_curr = trim(dw_11.object.curr[ll_row])
		 ld_exch = dw_11.object.exch[ll_row]
		 //ld_exch = round(ld_exch,2)
		 select count(*) into :ll_rcnt
		 from  pbsle.sle214
		 where cym = :ls_xyear || :ls_revno
		 and   cur = :ls_curr;
		 if ll_rcnt > 0 then
			update pbsle.sle214
			   set exc = :ld_exch,
				    exc2 = :ld_exch
			where cym = :ls_xyear || :ls_revno
			and   cur = :ls_curr;
		 else
			insert into pbsle.sle214
			(CYM,       CUR,         EXC,            EXTD,   
         INPTID,     INPTDT,      UPDTID,        UPDTDT,   
         IPADDR,     MACADDR,     EXC2  )
			values
			(:ls_xyear || :ls_revno, :ls_curr, :ld_exch,    '',
			:g_s_empno,  :g_s_date,  '',    :g_s_datetime,
			:g_s_ipaddr, :g_s_macaddr,  :ld_exch);
		 end if
	next
	dw_11.ResetUpdate( )
	Commit Using SQLCA ;
	i_n_erreturn = 0
	uo_status.st_message.Text = f_message('U010') // 저장되었습니다.	
	
	ib_Insert = False

Else 
	
	RollBack Using SQLCA ;
	i_n_erreturn = -1
	uo_status.st_message.text = f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다. 	
	
End If
SetPointer(arrow!)

end event

event ue_delete;call super::ue_delete;
SetPointer( HourGlass! )


IF wf_stcd_chk(1) = -1  THEN  //상태확인
	Return
END IF

Integer li_SelectedRowCnt


li_SelectedRowCnt = f_Selected_Row( dw_11 )

SetPointer( Arrow! ) 

Integer li_YNC

If li_SelectedRowCnt > 0 Then
	li_YNC = MessageBox('확인!', '선택한 ' + String(li_SelectedRowCnt) + '개의 환율을 삭제하시겠습니까?', &
								Question!, YesNo!, 2)
	
	Integer li_Rtn
	
	If li_YNC = 1 Then
		
		f_Multi_Delete_Row( dw_11 )
		
		li_Rtn = dw_11.Update(True, False)
		
		If li_Rtn = 1 Then
			
			dw_11.ResetUpdate()
			Commit Using SQLCA ;
			
			uo_status.st_message.Text = f_message('D010')  // 삭제 되었습니다.
			
		Else
			
			RollBack Using SQLCA ;
			uo_status.st_message.Text = f_message('D020')  // [삭제실패] 정보시스템팀으로 연락바랍니다.
		
		End If
	End If
Else
	
	MessageBox('확인!', '삭제할 환율이 없습니다.', Exclamation!)
	
End If

end event

type uo_status from w_origin_sheet01`uo_status within w_bpm101u
end type

type dw_11 from datawindow within w_bpm101u
integer x = 23
integer y = 192
integer width = 2030
integer height = 2292
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bpm101u_11"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If Upper(dwo.Type) = 'TEXT' Then
	f_Dw_Sorting( This, dwo )	// Text를 Click시 그 Text내용으로 조회 DataWindow Sorting.
   Return
End If

If Upper(dwo.Type) <> 'COLUMN' Then Return

f_multi_select_Row(This, Row, il_preRow)
If Row > 0 Then il_preRow = Row

wf_Click_Retrieve( Row )

i_b_delete = True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
end event

event constructor;This.SetTransObject( SQLCA )
end event

type dw_10 from datawindow within w_bpm101u
event ue_key_down pbm_dwnkey
integer x = 27
integer y = 8
integer width = 1015
integer height = 168
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm101u_10"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;If key = KeyEnter! Then
	Parent.TriggerEvent('ue_retrieve')
	Return 1
End If
end event

event constructor;
This.InsertRow( 0 )

string ls_xyear
select coalesce(max(xyear || revno),'')
into :ls_xyear
from pbbpm.bpm519;

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)


end event

event itemchanged;Choose Case f_dw_status( dw_11, i_s_level )	
	Case 1 // 처리중인던 작업 저장.
		This.TriggerEvent('ue_save')
		
		If i_n_erreturn = -1  Then
			uo_status.st_message.text = f_message("U040") // 저장할 수 없습니다.
			Return 1
		End If
End Choose 

dw_11.SetRedraw( False )
dw_11.Reset( )
dw_11.SetRedraw( True ) 


end event

type pb_1 from picturebutton within w_bpm101u
integer x = 1093
integer y = 24
integer width = 155
integer height = 132
integer taborder = 110
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;If dw_10.AcceptText( ) = -1 Then
	MessageBox("확인!", "에러가 난곳을 수정한 후 저장하십시요.", Exclamation!)
	Return
End If

dw_10.SetItemStatus(1, 0, Primary!, DataModified!)
If f_mandantory_chk( dw_10 ) = -1 Then  // 필수입력항목 check
	Return
End If

f_pur040_GetExcel( dw_11 )
	
i_b_save	  = True

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)


		
	

end event

type cb_3 from commandbutton within w_bpm101u
integer x = 1303
integer y = 40
integer width = 361
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "자료확정"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_itnm
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '작업에 대한 권한이 없습니다!'
	Return
END IF


IF dw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(dw_10.object.xyear[1])
ls_revno = trim(dw_10.object.revno[1])

IF wf_stcd_chk(1) = -1  THEN  //상태확인
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm506
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('확인','확정할 자료가 없습니다! 확인하세요!')
	uo_status.st_message.text = '확정할 자료가 없습니다! 확인하세요!'
	Return
end if


li_ok = MessageBox('확인','확정합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'C'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '100';

if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율 확정완료.'
SetPointer(arrow!)
return

end event

type cb_1 from commandbutton within w_bpm101u
integer x = 1691
integer y = 40
integer width = 361
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "확정취소"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_itnm, ls_msg
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '작업에 대한 권한이 없습니다!'
	Return
END IF


IF dw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(dw_10.object.xyear[1])
ls_revno = trim(dw_10.object.revno[1])

IF f_bpmstcd_chk1('100',ls_xyear, ls_revno, ls_msg) = -1  THEN  //상태확인
   MessageBox('작업불가',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF


li_ok = MessageBox('확인','확정취소합니다! 품목정보, 품목단가정보가 진행상태로 동시에 변경됩니다. 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'G'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '100';

if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519_100) 자료 확정중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519_100) 자료 확정중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if
f_bpm_job_start(ls_xyear, ls_revno, 'w_bpm101u',g_s_empno,'X','환율정보 자료확정 취소')


select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '150';
if ls_stcd <> 'G' then
	uo_status.st_message.text = '품목정보 확정취소중...'
	update pbbpm.bpm519
		set taskstatus = 'G'
	where comltd = '01'
	and   xyear = :ls_xyear
	and   revno = :ls_revno
	and   seqno = '150';
	
	if sqlca.sqlcode <> 0 then
		MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519_150) 자료 확정중 오류발생! 급히 연락바랍니다.')
		uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519_150) 자료 확정중 오류발생! 급히 연락바랍니다.'
		messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		Return
	end if
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm201u',g_s_empno,'X','환율확정취소에 의한 품목정보 자동확정취소')
end if
select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '200';
if ls_stcd <> 'G' then
	uo_status.st_message.text = '품목단가정보 확정취소중...'
	update pbbpm.bpm519
		set taskstatus = 'G'
	where comltd = '01'
	and   xyear = :ls_xyear
	and   revno = :ls_revno
	and   seqno = '200';
	
	if sqlca.sqlcode <> 0 then
		MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519_200) 자료 확정중 오류발생! 급히 연락바랍니다.')
		uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율내역상태(BPM519_200) 자료 확정중 오류발생! 급히 연락바랍니다.'
		messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		Return
	end if
	f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm301u',g_s_empno,'X','환율확정취소에 의한 단가정보 자동확정취소')
end if

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 환율 확정취소완료.'
SetPointer(arrow!)
return

end event

