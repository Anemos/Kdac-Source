$PBExportHeader$w_comm902u.srw
$PBExportComments$장비 vs IP 관리
forward
global type w_comm902u from w_origin_sheet09
end type
type tab_1 from tab within w_comm902u
end type
type tabpage_1 from userobject within tab_1
end type
type st_6 from statictext within tabpage_1
end type
type dw_ip from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_6 st_6
dw_ip dw_ip
end type
type tab_1 from tab within w_comm902u
tabpage_1 tabpage_1
end type
end forward

global type w_comm902u from w_origin_sheet09
event ue_open_after ( )
tab_1 tab_1
end type
global w_comm902u w_comm902u

type variables
Int 		ii_tabindex, ii_index, ii_index2
String 	is_colnm
Long		il_PreRow
datawindowchild idwc_1, idwc_2
datawindow idw_10, idw_11, idw_12, &
			  idw_20, idw_21, idw_22, idw_23, idw_24, &
			  idw_30, idw_31, idw_32, idw_33, &
		     idw_40, idw_41, idw_42, idw_43, &
			  idw_50, idw_51, idw_52, idw_53, &
			  idw_60, idw_61, idw_62, &
			  idw_70, idw_71, idw_72, &
			  idw_80, idw_81, &
			  idw_91, idw_92, idw_93, &
			  idw_ip
window iw_sheet


end variables

event ue_open_after();iw_sheet		=	w_frame.getactivesheet()
end event

on w_comm902u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_comm902u.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;This.Event Post	ue_open_after()

end event

event ue_dprint;call super::ue_dprint;f_screen_print(this)
end event

event ue_retrieve;call super::ue_retrieve;String    	ls_fchgdt,		ls_tchgdt ,		ls_xplant,	ls_div, 	ls_dept,		ls_devicegubun, &
			ls_specgubun, 	ls_empgubun, 	ls_stcd, 		ls_chid, 	ls_cogubun,	&
			ls_swlgubun,  	ls_swvgubun, 	ls_deptName			 
Long 	    	ll_rcnt, 			ll_row 
Integer   li_rtn

Setpointer(hourglass!)

CHOOSE CASE	ii_tabindex
	CASE 1
		idw_ip.Reset()
		IF g_s_empno = 'ADMIN' THEN
			ls_dept = '23%'
		ELSE
			SELECT PEDEPT	INTO	:ls_dept	FROM	PBCOMMON.DAC003
			WHERE	PEEMPNO 	=	:g_s_empno 
			Using		Sqlca	;
			IF 	SQLCA.SQLCode <> 0 THEN
				messageBox("확인","부서에 존재하지 않는 사원입니다. ")
				Return
			END IF
			
			SELECT COITNAME	INTO	:ls_deptName	FROM	PBCOMMON.DAC002  
			WHERE  COMLTD = '01'	AND	COGUBUN	=	'DAC150'	AND	COCODE	=	:ls_dept	
			Using		Sqlca	;
			IF 	SQLCA.SQLCode	<>	0	THEN
				MessageBox("확인","부서이름을 가져올수 없습니다.")
				Return
			END IF 
			ls_dept	=	Mid(ls_dept,1,2) + '%'
		END IF
		
		IF 	idw_ip.Retrieve(ls_dept) > 0 THEN
			uo_status.st_message.text	=	f_message("I010")
			wf_icon_onoff(true,false,true,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text	=	f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
END CHOOSE

Setpointer(Arrow!)

end event

event ue_save;call super::ue_save;SetPointer(hourglass!)

String	ls_chgdt, ls_chgdt_bef, ls_chid, ls_asid, ls_asdt, &
			ls_xplant, ls_div, ls_dept, ls_devicegubun, ls_specgubun, &
		   	ls_modelnm, ls_memory, ls_disk, ls_cdrwexist, ls_monitorsize, &
			ls_monitorgubun, ls_os, ls_empgubun, ls_empnm, ls_stcd, ls_comment, &
			ls_xplant_bef, ls_div_bef, ls_dept_bef, ls_cogubun, &
			ls_swlgubun, ls_swvgubun, ls_serialkey, ls_purdt, ls_swnm, ls_swkey, &
			ls_swkey_serl, ls_yy, ls_mm, ls_usbexist, ls_swnm_bef, ls_chid_bef
Long     	ll_row, ll_rcnt, ll_row_cnt
Integer  	li_rtn, ii, li_cnt, ii_temp

CHOOSE CASE ii_tabindex
	CASE 1
		idw_ip.AcceptText()
		Integer	jj
		String 	ls_ip[], data
		Long		ll_ip[], ll_pos, ll_length, ll_temp_pos[]
		
		FOR	jj = 1 To idw_ip.RowCount()

				IF	idw_ip.GetItemStatus(ii,0,Primary!) = DataModified! THEN 
					data	=	Trim(idw_ip.GetItemString(jj,'usingip'))
					li_cnt = 0 
					ll_pos = 0
					//길이 체크
					IF	Len(data) >= 1 AND	Len(data)	<	7	THEN
						MessageBox(	"Error", "IP 주소가 잘못되었습니다 : " + &
											"IP의 최소 길이는 7 보다 큽니다.( ex: 1.0.1.1 )")
						Return	1
					END IF
					
					IF Len(data) > 15 THEN
						MessageBox(	"Error", "IP 주소가 잘못되었습니다 : " + &
											"총 IP길이가 15 보다 클 수는 없습니다.")
						Return 	1
					END IF

					FOR	ii = 1	TO	4
							ll_pos = Pos(data, ".", ll_pos + 1)
							IF 	ll_pos <> 0 THEN
								li_cnt++
							END IF
					NEXT
					
					IF 	li_cnt <> 3 THEN
						MessageBox(	"Error", "IP 주소가 잘못되었습니다 : " + & 
											"구분자 '.' 이 세개 있어야 올바른 IP 입니다.")
						Return 	1
					END IF
					ll_pos = 0
					FOR ii = 1 TO 4
						ll_pos = Pos(data, ".", ll_pos + 1)
						
						ll_temp_pos[ii] = ll_pos
						
						IF ll_pos <> 0 THEN
							
							IF ii = 1 THEN
								ls_ip[ii] = Mid(data,ii,(ll_temp_pos[ii] - 1))
							ELSEIF ii = 2 THEN
								ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))
							ELSEIF ii = 3 THEN
								ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))	
							
							ELSE
								EXIT
							END IF
						ELSE
							IF ii = 4 THEN
								ls_ip[ii] = MId(data,(ll_temp_pos[ii - 1] + 1), (Len(data) - ll_temp_pos[ii - 1] )) 
							ELSE
								EXIT
							END IF
						END IF
						
						//MessageBox("확인",String(ll_pos) + " : " +ls_ip[ii] + " : " + String(Len(data)))
						
						IF Len(ls_ip[ii]) <= 0 THEN
							MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
											".사이의 숫자의 길이는 0 보다 커야 합니다.")
							Return 1	
						END IF	
						
						IF Len(ls_ip[ii]) > 3 THEN
							MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &  
											".사이의 숫자의 길이는 3 보다 작아야 합니다.")
							Return 1	
						END IF
						
						IF Len(ls_ip[ii]) = 2 THEN
							IF Mid(ls_ip[ii],1,1) = '0' THEN
								MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
												"첫번째 자리의 숫자는 0 일 수 없습니다.")
								Return 1	
							END IF
						END IF
						
						IF Len(ls_ip[ii]) = 3 THEN
							
							IF Mid(ls_ip[ii],1,1) = '0' THEN
			
								MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &
												"첫번째 자리의 숫자는 0 일 수 없습니다.")
								Return 1	
							END IF
						END IF	
						
						
						IF isNumber(ls_ip[ii]) = FALSE THEN
							MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
											"IP는 숫자이어야 합니다.")
							Return 1
						ELSE
							ll_ip[ii] = Long(ls_ip[ii])
							
							IF ll_ip[ii] > 255 OR ll_ip[ii] < 0 THEN
								MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
											"IP는 0 과 255 사이의 수이어야 합니다.")
								Return 1
							END IF
						END IF
						
					NEXT
				ELSE
					//messageBox("","not datamodified")
				END IF	
						
		NEXT
		
		//IF f_mandantory_chk(idw_ip) = -1 THEN Return
		
		//0, null, 입력자 Setting
		f_null_chk(idw_ip)
		f_inptid(idw_ip)
		
		uo_status.st_message.text	= '저장중입니다...'
	
		IF idw_ip.Update(true,false) = 1 THEN
			
			idw_ip.resetupdate()
			COMMIT USING SQLCA;
			triggerEvent("ue_retrieve")
			uo_status.st_message.text	=  f_message("U010")	// 입력되었습니다. 
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	=  f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다.
		END IF
		
		//triggerEvent("ue_retrieve")
		
		wf_icon_onoff(true, false, true, false, false, false, false, false, false)   
		
	///////////////////////////////////////////////////////////////////////////		
END CHOOSE		

end event

event ue_insert;call super::ue_insert;
CHOOSE CASE	ii_tabindex
	CASE 1
		MessageBox("확인","입력하실 수 없는 텝입니다.")
		Return
END CHOOSE


end event

event ue_delete;call super::ue_delete;Long    	ll_row, ll_rcnt, ll_delrow
Integer 	li_ok,  li_err, li_cnt
String  	ls_chid, ls_chgdt, ls_swkey

CHOOSE CASE ii_tabindex
	CASE 1
		MessageBox("확인","삭제하실 수 없는 텝입니다.")
		Return
END CHOOSE

end event

event ue_bcreate;call super::ue_bcreate;CHOOSE CASE	ii_tabindex
	CASE		1
		IF 	idw_ip.RowCount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_ip)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF	
END CHOOSE
end event

type uo_status from w_origin_sheet09`uo_status within w_comm902u
integer y = 2476
end type

type tab_1 from tab within w_comm902u
integer x = 32
integer y = 28
integer width = 4567
integer height = 2440
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;ii_tabindex = newindex
g_n_tabno = newindex
uo_status.st_message.text	=  ' '

idw_ip.AcceptText()

CHOOSE CASE ii_tabindex
	
	CASE 1
		IF idw_ip.rowcount() > 0 then
			wf_icon_onoff(true,false,true,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF	
END CHOOSE
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "장비 vs IP"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_6 st_6
dw_ip dw_ip
end type

on tabpage_1.create
this.st_6=create st_6
this.dw_ip=create dw_ip
this.Control[]={this.st_6,&
this.dw_ip}
end on

on tabpage_1.destroy
destroy(this.st_6)
destroy(this.dw_ip)
end on

type st_6 from statictext within tabpage_1
integer x = 27
integer y = 40
integer width = 2016
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217856
long backcolor = 12632256
string text = "장비를 실제 사용하고 있는 사람과 IP를 입력해주세요!"
boolean focusrectangle = false
end type

type dw_ip from datawindow within tabpage_1
event ue_up_and_down pbm_dwnkey
integer x = 9
integer y = 128
integer width = 4512
integer height = 2188
integer taborder = 80
string title = "none"
string dataobject = "d_aut322u_ip"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_up_and_down;If Not (Key = KeyUpArrow! Or Key = KeyDownArrow!) Then
	Return 0
End If

Long	ll_Row

ll_Row = This.GetRow( )

Choose Case Key
	Case KeyDownArrow!	
		
		If ll_Row <> This.RowCount( ) Then 
			ll_Row ++			
				
			This.ScrollToRow( ll_Row )
			f_Multi_Select_Row( This, ll_Row, 0 )			
			il_PreRow = ll_Row
			
			//wf_Click_Retrieve( ll_Row, idw_11, idw_12 )
			Return 1		
		End If
		 
	Case KeyUpArrow!
		
		If ll_Row <> 1 Then
			ll_Row --
					
			This.ScrollToRow( ll_Row )
			f_Multi_Select_Row( This, ll_Row, 0 )			
			il_PreRow = ll_Row
			
			//wf_Click_Retrieve( ll_Row, idw_11, idw_12 )
			Return 1
		End If
		
End Choose
end event

event constructor;This.SetTransObject(sqlca)
idw_ip = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'사용불가,변수값지정

//자료없는 부분 클릭시 선택 해제
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

event itemchanged;

CHOOSE CASE dwo.name
	CASE 'usingip'
		
		data = Trim(data)
		
		//변수
		String 	ls_ip[]
		Long		ll_ip[], ll_pos, ll_length, ll_temp_pos[]
		Int		ii, li_cnt
		
		//초기화.
		li_cnt = 0 
		ll_pos = 0
		
		////////////////////체크 일반////////////////////////////////
		//길이 체크
		IF Len(data) = 0 THEN
			Return
		END IF
		
		IF Len(data) >= 1 AND Len(data) < 7 THEN
			MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &
							"IP의 최소 길이는 7 보다 큽니다.( ex: 1.0.1.1 )")
			Return 1
			
		END IF
		
		IF Len(data) > 15 THEN
			MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &
							"총 IP길이가 15 보다 클 수는 없습니다.")
			Return 1
		END IF
		
		//.이 세번 나온다고 가정...
		FOR ii = 1 TO 4
			
			ll_pos = Pos(data, ".", ll_pos + 1)
			
			IF ll_pos <> 0 THEN
				li_cnt++
				
			ELSE
				EXIT
			END IF
		NEXT
		
		IF li_cnt <> 3 THEN
			MessageBox("Error", String(li_cnt) + "IP 주소가 잘못되었습니다 : " + & 
							"구분자 '.' 이 세개 있어야 올바른 IP 입니다.")
			Return 1
		END IF
		//////////////////////////////////////////////////////////////
		
		ll_pos = 0
		
		FOR ii = 1 TO 4
			ll_pos = Pos(data, ".", ll_pos + 1)
			
			ll_temp_pos[ii] = ll_pos
			
			IF ll_pos <> 0 THEN
				
				IF ii = 1 THEN
					ls_ip[ii] = Mid(data,ii,(ll_temp_pos[ii] - 1))
				ELSEIF ii = 2 THEN
					ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))
				ELSEIF ii = 3 THEN
					ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))	
				
				ELSE
					EXIT
				END IF
			ELSE
				IF ii = 4 THEN
					ls_ip[ii] = MId(data,(ll_temp_pos[ii - 1] + 1), (Len(data) - ll_temp_pos[ii - 1] )) 
				ELSE
					EXIT
				END IF
			END IF
			
			//MessageBox("확인",String(ll_pos) + " : " +ls_ip[ii] + " : " + String(Len(data)))
			
			IF Len(ls_ip[ii]) <= 0 THEN
				MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
								".사이의 숫자의 길이는 0 보다 커야 합니다.")
				Return 1	
			END IF	
			
			IF Len(ls_ip[ii]) > 3 THEN
				MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &  
								".사이의 숫자의 길이는 3 보다 작아야 합니다.")
				Return 1	
			END IF
			
			IF Len(ls_ip[ii]) = 2 THEN
				IF Mid(ls_ip[ii],1,1) = '0' THEN
					MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
									"첫번째 자리의 숫자는 0 일 수 없습니다.")
					Return 1	
				END IF
			END IF
			
			IF Len(ls_ip[ii]) = 3 THEN
				
				IF Mid(ls_ip[ii],1,1) = '0' THEN
//					IF Mid(ls_ip[ii],2,1) = '0' THEN
//						MessageBox("Error", "IP 주소가 잘못되었습니다. : " + &
//										"첫번째 자리의 숫자는 0 일 수 없습니다.")
//						Return 1	
//					END IF
					MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &
									"첫번째 자리의 숫자는 0 일 수 없습니다.")
					Return 1	
				END IF
			END IF	
			
			
			IF isNumber(ls_ip[ii]) = FALSE THEN
				MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
								"IP는 숫자이어야 합니다.")
				Return 1
			ELSE
				ll_ip[ii] = Long(ls_ip[ii])
				
				IF ll_ip[ii] > 255 OR ll_ip[ii] < 0 THEN
					MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
								"IP는 0 과 255 사이의 수이어야 합니다.")
					Return 1
				END IF
			END IF
			
		NEXT
		/*
		//네번째는 체크 못하네...
		ls_ip[4] = MId(data,(ll_temp_pos[3] + 1), (Len(data) - ll_temp_pos[3] )) 
		
		IF Len(ls_ip[4]) <= 0 THEN
			MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
							".사이의 숫자의 길이는 0 보다 커야 합니다.")
			Return 1	
		END IF	
		
		IF Len(ls_ip[4]) > 3 THEN
			MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &  
							".사이의 숫자의 길이는 3 보다 작아야 합니다.")
			Return 1	
		END IF
		
		IF Len(ls_ip[4]) = 2 THEN
			IF Mid(ls_ip[4],1,1) = '0' THEN
				MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
								"첫번째 자리의 숫자는 0 일 수 없습니다.")
				Return 1	
			END IF
		END IF
	
		IF Len(ls_ip[4]) = 3 THEN
			
			IF Mid(ls_ip[4],1,1) = '0' THEN
//					IF Mid(ls_ip[ii],2,1) = '0' THEN
//						MessageBox("Error", "IP 주소가 잘못되었습니다. : " + &
//										"첫번째 자리의 숫자는 0 일 수 없습니다.")
//						Return 1	
//					END IF
				MessageBox("Error", "IP 주소가 잘못되었습니다 : " + &
								"첫번째 자리의 숫자는 0 일 수 없습니다.")
				Return 1	
			END IF
		END IF	
		
		IF isNumber(ls_ip[4]) = FALSE THEN
			MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
							"IP는 숫자이어야 합니다.")
			Return 1
		ELSE
			ll_ip[4] = Long(ls_ip[4])
			
			IF ll_ip[4] > 255 OR ll_ip[4] < 0 THEN
				MessageBox("Error", "IP 주소가 잘못되었습니다 : " + & 
							"IP는 0 과 255 사이의 수이어야 합니다.")
				Return 1
			END IF
		END IF
	*/
END CHOOSE
end event

event itemerror;This.setFocus()
Return 1
end event

