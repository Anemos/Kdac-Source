$PBExportHeader$w_mpm421u.srw
$PBExportComments$WorkCalendar(O/T)
forward
global type w_mpm421u from w_ipis_sheet01
end type
type dw_mpm421u_01 from datawindow within w_mpm421u
end type
type uo_month from u_mpms_date_scroll_month within w_mpm421u
end type
type uo_wccode from u_mpms_select_wccode within w_mpm421u
end type
type gb_2 from groupbox within w_mpm421u
end type
end forward

global type w_mpm421u from w_ipis_sheet01
dw_mpm421u_01 dw_mpm421u_01
uo_month uo_month
uo_wccode uo_wccode
gb_2 gb_2
end type
global w_mpm421u w_mpm421u

type variables
boolean ib_cal_change
end variables

on w_mpm421u.create
int iCurrent
call super::create
this.dw_mpm421u_01=create dw_mpm421u_01
this.uo_month=create uo_month
this.uo_wccode=create uo_wccode
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm421u_01
this.Control[iCurrent+2]=this.uo_month
this.Control[iCurrent+3]=this.uo_wccode
this.Control[iCurrent+4]=this.gb_2
end on

on w_mpm421u.destroy
call super::destroy
destroy(this.dw_mpm421u_01)
destroy(this.uo_month)
destroy(this.uo_wccode)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm421u_01.Width = newwidth 	- ( dw_mpm421u_01.x + ls_split )
dw_mpm421u_01.Height= newheight - ( dw_mpm421u_01.y + ls_status )
end event

event ue_save;call super::ue_save;integer li_return 

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then	
		dw_mpm421u_01.accepttext()
		sqlmpms.AutoCommit = False
		
		if dw_mpm421u_01.update() = 1 then
			ib_cal_change	= False
			Commit using sqlmpms;
			sqlmpms.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하였습니다."
			TriggerEvent("ue_retrieve")
		else
			Rollback using sqlmpms;
			sqlmpms.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다."
			Return 0
		end if
	ElseIf li_return = 3 Then
		Return 0
	End If
End If

return 0
end event

event ue_retrieve;call super::ue_retrieve;int		li_return, li_shopcount, li_rowcnt
string   ls_wccode

dw_mpm421u_01.SetTransObject(sqlmpms)

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then	
		dw_mpm421u_01.accepttext()
		sqlmpms.AutoCommit = False
		
		if dw_mpm421u_01.update() = 1 then
			Commit using sqlmpms;
			sqlmpms.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하였습니다."
		else
			Rollback using sqlmpms;
			sqlmpms.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다."
			Return 0
		end if
	ElseIf li_return = 3 Then
		Return 0
	End If
End If

ib_cal_change = False
dw_mpm421u_01.reset()
//1
If dw_mpm421u_01.Retrieve(uo_month.is_uo_month, uo_wccode.is_uo_wccode) > 0 Then
	uo_status.st_message.text =  "Work Calendar 정보"
Else
	uo_status.st_message.text =  "Work Calendar 정보가 존재하지 않습니다."
	li_return = MessageBox("Work Calendar", "Work Calendar 정보가 존재하지 않습니다.~r~n" + &
												"Work Calendar 정보를 신규로 생성하시겠습니까?", Question!, YesNo!, 2)
	IF li_return = 1 THEN	//2
		Integer	li_i, li_weekno
		String	ls_date, ls_WorkGubun, ls_dayname
		Long		ll_DayNo
		
		sqlmpms.AutoCommit = False
		
		ls_wccode = '000'
		DO WHILE TRUE
			SELECT TOP 1 wccode INTO :ls_wccode
			FROM TWORKCENTER
			WHERE WcCode > :ls_wccode AND WcCode <> 'THT'
			ORDER BY wccode ASC
			using sqlmpms;
			
			if sqlmpms.sqlcode <> 0 or f_spacechk(ls_wccode) = -1 then
				exit
			end if
		
			For li_i = 1 To 31 Step 1
				ls_date = left(uo_month.is_uo_month, 7) + '.' + String(li_i, "00")
				If Not isDate( ls_date ) Then Exit
				li_weekno = DayNumber(Date(ls_date))
				If li_weekno = 1 Or li_weekno = 7 Then 
					ls_WorkGubun = 'H'
				Else 
					ls_WorkGubun = 'W'
				End If				
				ll_DayNo	= DaysAfter (Date( left(uo_month.is_uo_month, 4) + '.01.01'), Date(ls_date)) + 1
				  INSERT INTO TMPMCALENDAR  
							( ApplyMonth, ApplyDate, WcCode, DayNo, WorkGubun, 
							OverWork, DawnWork, NightWork, Remark, LastEmp, LastDate )  
				  VALUES (	:uo_month.is_uo_month,   
								:ls_date,
								:ls_wccode,
								:ll_DayNo,   
								:ls_WorkGubun,
								'N',
								'N',
								'N',
								Null,   
								'N',   	//Interface Flag 활용
								GetDate() )
					Using	sqlmpms	;
				If sqlmpms.Sqlcode <> 0 Then Goto Rollback_	
			Next
		LOOP
		
		Commit Using sqlmpms;
		sqlmpms.AutoCommit = True
		uo_status.st_message.text = "Work Calendar 생성에 성공하였습니다." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("Work Calendar", "Work Calendar 생성에 성공하였습니다.", Information!)
		This.TriggerEvent( "ue_retrieve" )
		Return 0
		
		Rollback_:
		Rollback Using sqlmpms;
		sqlmpms.AutoCommit = True
		uo_status.st_message.text = "Work Calendar 생성에 실패했습니다." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("Work Calendar", "Work Calendar 생성에 실패했습니다.", Information!)
		Return -1	
	END IF	//2
End If	//1

return 0

end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm421u
end type

type dw_mpm421u_01 from datawindow within w_mpm421u
integer x = 27
integer y = 176
integer width = 3017
integer height = 1564
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_mpm421u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String	ls_date, ls_workgubun, ls_modstring

This.AcceptText()
If row > 0 Then
	ib_cal_change = True

	uo_status.st_message.text =  "Work Calendar 정보가 변경되었습니다."
End If

return 0
end event

type uo_month from u_mpms_date_scroll_month within w_mpm421u
integer x = 96
integer y = 52
integer taborder = 11
boolean bringtotop = true
end type

on uo_month.destroy
call u_mpms_date_scroll_month::destroy
end on

type uo_wccode from u_mpms_select_wccode within w_mpm421u
integer x = 791
integer y = 52
integer height = 88
integer taborder = 21
boolean bringtotop = true
end type

on uo_wccode.destroy
call u_mpms_select_wccode::destroy
end on

type gb_2 from groupbox within w_mpm421u
integer x = 27
integer width = 1586
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

