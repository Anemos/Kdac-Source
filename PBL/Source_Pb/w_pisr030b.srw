$PBExportHeader$w_pisr030b.srw
$PBExportComments$Work Calendar(지역,공장별)
forward
global type w_pisr030b from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr030b
end type
type uo_division from u_pisc_select_division within w_pisr030b
end type
type uo_product from u_pisc_select_productgroup within w_pisr030b
end type
type uo_month from u_pisc_date_scroll_month within w_pisr030b
end type
type dw_pisr030b_01 from datawindow within w_pisr030b
end type
type gb_1 from groupbox within w_pisr030b
end type
type gb_2 from groupbox within w_pisr030b
end type
end forward

global type w_pisr030b from w_ipis_sheet01
uo_area uo_area
uo_division uo_division
uo_product uo_product
uo_month uo_month
dw_pisr030b_01 dw_pisr030b_01
gb_1 gb_1
gb_2 gb_2
end type
global w_pisr030b w_pisr030b

type variables
boolean ib_cal_change
end variables

on w_pisr030b.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.uo_month=create uo_month
this.dw_pisr030b_01=create dw_pisr030b_01
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_product
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.dw_pisr030b_01
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_pisr030b.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.uo_month)
destroy(this.dw_pisr030b_01)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;int		li_return, li_shopcount, li_rowcnt
string   ls_productgroup

dw_pisr030b_01.SetTransObject(sqlpis)
if uo_area.is_uo_areacode = 'D' and uo_division.is_uo_divisioncode = 'A' then
	// Pass
else
	uo_status.st_message.text = "제품군별로 Work Calendar를 관리하는 공장만 사용가능합니다."
	Return 0
end if

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then	
		dw_pisr030b_01.accepttext()
		sqlpis.AutoCommit = False
		
		if dw_pisr030b_01.update() = 1 then
			Commit using sqlpis;
			sqlpis.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하였습니다."
		else
			Rollback using sqlpis;
			sqlpis.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다."
			Return 0
		end if
	ElseIf li_return = 3 Then
		Return 0
	End If
End If

ib_cal_change = False
dw_pisr030b_01.reset()
//1
If dw_pisr030b_01.Retrieve(uo_month.is_uo_month, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, uo_product.is_uo_productgroup) > 0 Then
	uo_status.st_message.text =  "Work Calendar 정보"
Else
	uo_status.st_message.text =  "Work Calendar 정보가 존재하지 않습니다."
	li_return = MessageBox("Work Calendar", "Work Calendar 정보가 존재하지 않습니다.~r~n" + &
												"Work Calendar 정보를 신규로 생성하시겠습니까?", Question!, YesNo!, 2)
	IF li_return = 1 THEN	//2
		Integer	li_i, li_weekno
		String	ls_date, ls_WorkGubun, ls_dayname
		Long		ll_DayNo
		
		sqlpis.AutoCommit = False
		
		ls_productgroup = '00'
		DO WHILE TRUE
			SELECT TOP 1 ProductGroup INTO :ls_productgroup
			FROM TMSTPRODUCTGROUP
			WHERE AreaCode = :uo_area.is_uo_areacode  AND DivisionCode = :uo_division.is_uo_divisioncode AND
				ProductGroup > :ls_productgroup
			ORDER BY ProductGroup ASC
			using sqlpis;
			
			if sqlpis.sqlcode <> 0 or f_spacechk(ls_productgroup) = -1 then
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
							
				INSERT INTO TPARTCALENDARWORK  
						( AreaCode, DivisionCode, ProductGroup, ApplyMonth, ApplyDate, DayNo, WorkGubun, Remark, LastEmp, LastDate )  
				VALUES (	:uo_area.is_uo_areacode,   
							:uo_division.is_uo_divisioncode,
							:ls_productgroup,
							:uo_month.is_uo_month,   
							:ls_date,   
							:ll_DayNo,   
							:ls_WorkGubun,   
							Null,   
							'N',   	//Interface Flag 활용
							GetDate() )
				Using	sqlpis;
				If sqlpis.Sqlcode <> 0 Then Goto Rollback_	
			Next
		LOOP
		
		Commit Using sqlpis;
		sqlpis.AutoCommit = True
		uo_status.st_message.text = "Work Calendar 생성에 성공하였습니다." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("Work Calendar", "Work Calendar 생성에 성공하였습니다.", Information!)
		This.TriggerEvent( "ue_retrieve" )
		Return 0
		
		Rollback_:
		Rollback Using sqlpis;
		sqlpis.AutoCommit = True
		uo_status.st_message.text = "Work Calendar 생성에 실패했습니다." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("Work Calendar", "Work Calendar 생성에 실패했습니다.", Information!)
		Return -1	
	END IF	//2
End If	//1

return 0

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr030b_01.Width = newwidth 	- ( dw_pisr030b_01.x + ls_split )
dw_pisr030b_01.Height= newheight - ( dw_pisr030b_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
	
ib_cal_change = False
end event

event ue_save;call super::ue_save;integer li_return 

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then	
		dw_pisr030b_01.accepttext()
		sqlpis.AutoCommit = False
		
		if dw_pisr030b_01.update() = 1 then
			ib_cal_change	= False
			Commit using sqlpis;
			sqlpis.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하였습니다."
			TriggerEvent("ue_retrieve")
		else
			Rollback using sqlpis;
			sqlpis.AutoCommit = True
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다."
			Return 0
		end if
	ElseIf li_return = 3 Then
		Return 0
	End If
End If

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr030b
end type

type uo_area from u_pisc_select_area within w_pisr030b
integer x = 814
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
dw_pisr030b_01.reset()
end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr030b
integer x = 1362
integer y = 52
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
		uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
		uo_product.is_uo_productgroupname)
		
dw_pisr030b_01.reset()
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_product from u_pisc_select_productgroup within w_pisr030b
integer x = 1979
integer y = 52
integer taborder = 50
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr030b_01.reset()
end event

type uo_month from u_pisc_date_scroll_month within w_pisr030b
integer x = 73
integer y = 52
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

event ue_select;call super::ue_select;dw_pisr030b_01.reset()
end event

type dw_pisr030b_01 from datawindow within w_pisr030b
integer x = 27
integer y = 176
integer width = 3017
integer height = 1564
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pisr030b_01"
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

type gb_1 from groupbox within w_pisr030b
integer x = 754
integer width = 2176
integer height = 156
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr030b
integer x = 27
integer width = 690
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

