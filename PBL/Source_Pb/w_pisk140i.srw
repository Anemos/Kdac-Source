$PBExportHeader$w_pisk140i.srw
$PBExportComments$평준화준수율 - 월별
forward
global type w_pisk140i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisk140i
end type
type uo_area from u_pisc_select_area within w_pisk140i
end type
type uo_division from u_pisc_select_division within w_pisk140i
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisk140i
end type
type uo_line from u_pisc_select_line within w_pisk140i
end type
type dw_detail from datawindow within w_pisk140i
end type
type st_h_bar from uo_xc_splitbar within w_pisk140i
end type
type uo_year from u_pisc_date_scroll_year within w_pisk140i
end type
type dw_data from datawindow within w_pisk140i
end type
type dw_print from datawindow within w_pisk140i
end type
type gb_1 from groupbox within w_pisk140i
end type
type gb_2 from groupbox within w_pisk140i
end type
type gb_3 from groupbox within w_pisk140i
end type
end forward

global type w_pisk140i from w_ipis_sheet01
integer width = 3689
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
dw_detail dw_detail
st_h_bar st_h_bar
uo_year uo_year
dw_data dw_data
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisk140i w_pisk140i

type variables
Boolean	ib_open
end variables

on w_pisk140i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.uo_year=create uo_year
this.dw_data=create dw_data
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.uo_year
this.Control[iCurrent+9]=this.dw_data
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisk140i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.uo_year)
destroy(this.dw_data)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_data.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										True, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)
										
ib_open = True
end event

event ue_retrieve;//iw_this.TriggerEvent("ue_reset")
//
//If dw_1.Retrieve(	uo_year.is_uo_year, &
//						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
//						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
//
//	uo_status.st_message.text =  "월별 평준화 준수율 정보" //+ f_message("변경된 데이타가 없습니다.")
//Else
//	uo_status.st_message.text =  "월별 평준화 준수율 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
//	MessageBox("월별 평준화 준수율", "월별 평준화 준수율 정보가 존재하지 않습니다")
//End If

String	ls_import, &
			ls_workcenter, ls_workcenter_sub, ls_workcentername, ls_workcentername_sub, &
			ls_linecode, ls_linename
Long		i, j, ll_rowcount, &
			ll_release_all, ll_prd_all, &
			ll_release[12], ll_prd[12], &
			ll_release_all_sub, ll_prd_all_sub, &
			ll_release_sub[12], ll_prd_sub[12], &
			ll_release_all_total, ll_prd_all_total, &
			ll_release_total[12], ll_prd_total[12]
Decimal	ld_prdrate_all, ld_prdrate[12], &
			ld_prdrate_all_sub, ld_prdrate_sub[12], &
			ld_prdrate_all_total, ld_prdrate_total[12]

iw_this.TriggerEvent("ue_reset")

ll_rowcount = dw_data.Retrieve(	uo_year.is_uo_year, &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode)

If ll_rowcount > 0 Then
	//
Else
	MessageBox("월별 간판 평준화율", "월별 간판 평준화율 정보가 존재하지 않습니다.", &
												Exclamation!)
	Return
End If

For i = 1 To ll_rowcount
	ls_workcenter			= Trim(dw_data.GetItemString(i, "WorkCenter"))
	ls_workcentername		= Trim(dw_data.GetItemString(i, "WorkCenterName"))
	ls_linecode				= Trim(dw_data.GetItemString(i, "LineCode"))
	ls_linename				= Trim(dw_data.GetItemString(i, "LineFullName"))
	
// 소계인지 확인한 후에 소계를 처리하자.
	If i > 1 Then
		If ls_workcenter <> ls_workcenter_sub Then
			// 소계의 누계 준수율을 처리하자
			If ll_release_all_sub = 0 Then
				If ll_prd_all_sub > 0 Then
					ld_prdrate_all_sub	= 100.0
				Else
					ld_prdrate_all_sub	= 0.0000000001
				End If
			Else
				If ll_prd_all_sub > 0 Then
//					ld_prdrate_all_sub	= Round((((ll_prd_all_sub - ll_different_all_sub) * 1.0) / ll_release_all_sub) * 100.0, 2)
					ld_prdrate_all_sub	= Round(((ll_prd_all_sub * 1.0) / ll_release_all_sub) * 100.0, 2)
				Else
					ld_prdrate_all_sub	= 0
				End If
			End If

			If ld_prdrate_all_sub > 100.0 Then
				ld_prdrate_all_sub = 100.0
			End If

			ls_import = ls_import + &
							'' + '~t' + '' + '~t' + '' + '~t' + '' + '~t' + &
							ls_workcenter_sub + '~t' + ls_workcentername_sub + '~t' + &
							'XX' + '~t' + ' 소계' + '~t' + &
							String(ld_prdrate_all_sub) + '~t'
			// 소계의 준수율 처리
			For j = 1 To 12
				If ll_release_sub[j] = 0 Then
					If ll_prd_sub[j] > 0 Then
						ld_prdrate_sub[j]	= 100.0
					Else
						ld_prdrate_sub[j]	= 0.0000000001
					End If
				Else
					If ll_prd_sub[j] > 0 Then
//						ld_prdrate_sub[j]	= Round((((ll_prd_sub[j] - ll_different_sub[j]) * 1.0) / ll_release_sub[j]) * 100.0, 2)
						ld_prdrate_sub[j]	= Round(((ll_prd_sub[j] * 1.0) / ll_release_sub[j]) * 100.0, 2)
					Else
						ld_prdrate_sub[j]	= 0
					End If
				End If

				If ld_prdrate_sub[j] > 100.0 Then
					ld_prdrate_sub[j] = 100.0
				End If

				ls_import = ls_import + &
								String(ld_prdrate_sub[j]) + '~t'
			Next

			ls_import = ls_import + &
							'~t' + '~r~n'
			
			// 소계값 초기화
			ll_release_all_sub	= 0
			ll_prd_all_sub			= 0
			ld_prdrate_all_sub	= 0
			For j = 1 To 12
				ll_release_sub[j]		= 0
				ll_prd_sub[j]			= 0
				ld_prdrate_sub[j]		= 0
			Next
			ls_workcenter_sub = ls_workcenter
			ls_workcentername_sub = ls_workcentername
		End If
	End If	
// 공장별 구하기
	// 계획 및 실적 구하기
	ll_release_all		= dw_data.GetItemNumber(i, "ReleaseCount")
	ll_prd_all			= dw_data.GetItemNumber(i, "HitCount")
	For j = 1 To 12
		ll_release[j]		= dw_data.GetItemNumber(i, "ReleaseCount" + Right('0' + String(j), 2))
		ll_prd[j]			= dw_data.GetItemNumber(i, "HitCount" + Right('0' + String(j), 2))
	Next

// 공장별 준수율을 구하자
	// 누계 준수율을 처리하자
	If ll_release_all = 0 Then
		If ll_prd_all > 0 Then
			ld_prdrate_all	= 100.0
		Else
			ld_prdrate_all	= 0.0000000001
		End If
	Else
		If ll_prd_all > 0 Then
//			ld_prdrate_all	= Round((((ll_prd_all - ll_different_all) * 1.0) / ll_release_all) * 100.0, 2)
			ld_prdrate_all	= Round(((ll_prd_all * 1.0) / ll_release_all) * 100.0, 2)
		Else
			ld_prdrate_all	= 0
		End If
	End If

	If ld_prdrate_all > 100.0 Then
		ld_prdrate_all = 100.0
	End If

	ls_import = ls_import + &
					'' + '~t' + '' + '~t' + '' + '~t' + '' + '~t' + &
					ls_workcenter + '~t' + ls_workcentername + '~t' + &
					ls_linecode + '~t' + ls_linename + '~t' + &
					String(ld_prdrate_all) + '~t'
	// 준수율 처리
	For j = 1 To 12
		If ll_release[j] = 0 Then
			If ll_prd[j] > 0 Then
				ld_prdrate[j]	= 100.0
			Else
				ld_prdrate[j]	= 0.0000000001
			End If
		Else
			If ll_prd[j] > 0 Then
//				ld_prdrate[j]	= Round((((ll_prd[j] - ll_different[j]) * 1.0) / ll_release[j]) * 100.0, 2)
				ld_prdrate[j]	= Round(((ll_prd[j] * 1.0) / ll_release[j]) * 100.0, 2)
			Else
				ld_prdrate[j]	= 0
			End If
		End If

		If ld_prdrate[j] > 100.0 Then
			ld_prdrate[j] = 100.0
		End If

		ls_import = ls_import + &
						String(ld_prdrate[j]) + '~t'
	Next

	ls_import = ls_import + &
					'~t' + '~r~n'

// 소계 구하기
	ls_workcenter_sub	= ls_workcenter
	ls_workcentername_sub 	= ls_workcentername	
	ll_release_all_sub	= ll_release_all_sub + ll_release_all
	ll_prd_all_sub			= ll_prd_all_sub + ll_prd_all
	For j = 1 To 12
		ll_release_sub[j]		= ll_release_sub[j] + ll_release[j]
		ll_prd_sub[j]			= ll_prd_sub[j] + ll_prd[j]
	Next
	
// 합계 구하기
	ll_release_all_total		= ll_release_all_total + ll_release_all
	ll_prd_all_total			= ll_prd_all_total + ll_prd_all
	For j = 1 To 12
		ll_release_total[j]		= ll_release_total[j] + ll_release[j]
		ll_prd_total[j]			= ll_prd_total[j] + ll_prd[j]
	Next

// 공장이 하나만 조회됐을 경우 와 마지막 공장일 경우 소계 구하기
	If ll_rowcount = i Then
		// 소계의 누계 준수율을 처리하자
		If ll_release_all_sub = 0 Then
			If ll_prd_all_sub > 0 Then
				ld_prdrate_all_sub	= 100.0
			Else
				ld_prdrate_all_sub	= 0.0000000001
			End If
		Else
			If ll_prd_all_sub > 0 Then
//				ld_prdrate_all_sub	= Round((((ll_prd_all_sub - ll_different_all_sub) * 1.0) / ll_release_all_sub) * 100.0, 2)
				ld_prdrate_all_sub	= Round(((ll_prd_all_sub * 1.0) / ll_release_all_sub) * 100.0, 2)
			Else
				ld_prdrate_all_sub	= 0
			End If
		End If

		If ld_prdrate_all_sub > 100.0 Then
			ld_prdrate_all_sub = 100.0
		End If

		ls_import = ls_import + &
						'' + '~t' + '' + '~t' + '' + '~t' + '' + '~t' + &
						ls_workcenter_sub + '~t' + ls_workcentername_sub + '~t' + &
						'XX' + '~t' + ' 소계' + '~t' + &
						String(ld_prdrate_all_sub) + '~t'
		// 소계의 준수율 처리
		For j = 1 To 12
			If ll_release_sub[j] = 0 Then
				If ll_prd_sub[j] > 0 Then
					ld_prdrate_sub[j]	= 100.0
				Else
					ld_prdrate_sub[j]	= 0.0000000001
				End If
			Else
				If ll_prd_sub[j] > 0 Then
//					ld_prdrate_sub[j]	= Round((((ll_prd_sub[j] - ll_different_sub[j]) * 1.0) / ll_release_sub[j]) * 100.0, 2)
					ld_prdrate_sub[j]	= Round(((ll_prd_sub[j] * 1.0) / ll_release_sub[j]) * 100.0, 2)
				Else
					ld_prdrate_sub[j]	= 0
				End If
			End If

			If ld_prdrate_sub[j] > 100.0 Then
				ld_prdrate_sub[j] = 100.0
			End If

			ls_import = ls_import + &
							String(ld_prdrate_sub[j]) + '~t'
		Next

		ls_import = ls_import + &
						'~t' + '~r~n'
	End If
Next

If uo_workcenter.is_uo_workcenter = '%' Then
	// 합계의 누계 준수율을 처리하자
	If ll_release_all_total = 0 Then
		If ll_prd_all_total > 0 Then
			ld_prdrate_all_total	= 100.0
		Else
			ld_prdrate_all_total	= 0.0000000001
		End If
	Else
		If ll_prd_all_total > 0 Then
			ld_prdrate_all_total	= Round(((ll_prd_all_total * 1.0) / ll_release_all_total) * 100.0, 2)
		Else
			ld_prdrate_all_total	= 0
		End If
	End If

	If ld_prdrate_all_total > 100.0 Then
		ld_prdrate_all_total = 100.0
	End If

	ls_import = ls_import + &
					'' + '~t' + '' + '~t' + '' + '~t' + '' + '~t' + &
					'' + '~t' + '' + '~t' + &
					'YY' + '~t' + ' 합계' + '~t' + &
					String(ld_prdrate_all_total) + '~t'
	// 합계의 준수율 처리
	For j = 1 To 12
		If ll_release_total[j] = 0 Then
			If ll_prd_total[j] > 0 Then
				ld_prdrate_total[j]	= 100.0
			Else
				ld_prdrate_total[j]	= 0.0000000001
			End If
		Else
			If ll_prd_total[j] > 0 Then
				ld_prdrate_total[j]	= Round(((ll_prd_total[j] * 1.0) / ll_release_total[j]) * 100.0, 2)
			Else
				ld_prdrate_total[j]	= 0
			End If
		End If

		If ld_prdrate_total[j] > 100.0 Then
			ld_prdrate_total[j] = 100.0
		End If

		ls_import = ls_import + &
						String(ld_prdrate_total[j]) + '~t'
	Next
	
	ls_import = ls_import + &
					'~t' + '~r~n'
End If

dw_1.ImportString(ls_import)
dw_print.ImportString(ls_import)

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
dw_data.ReSet()
dw_print.ReSet()
end event

event activate;call super::activate;	dw_data.SetTransObject(SQLPIS)
end event

event ue_print;call super::ue_print;String	ls_mod, ls_date, ls_title
str_easy	lstr_prt

ls_title	= '월별 간판 평준화율'
ls_date	= "기준년 : " + uo_year.is_uo_year

ls_mod	= "st_title.Text = '" + ls_title + "' " + "st_msg.Text = '" + ls_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '월별 간판 평준화율'
lstr_prt.tag			= '월별 간판 평준화율'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisk140i
end type

type dw_1 from u_vi_std_datawindow within w_pisk140i
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 645
integer height = 1496
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisk_month"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;//

end event

event rowfocuschanged;////
//string	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode
//
//If CurrentRow > 0 Then
//	SelectRow(0,FALSE)
//	SelectRow(currentrow,TRUE)
//	
//	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
//	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
//	ls_workcenter		= Trim(GetItemString(CurrentRow, "WorkCenter"))
//	ls_linecode			= Trim(GetItemString(CurrentRow, "LineCode"))
//
//	dw_detail.Retrieve(	uo_year.is_uo_year, &
//								ls_areacode,				ls_divisioncode, &
//								ls_workcenter,				ls_linecode)
//
//End If

String	ls_import, ls_date, ls_workcenter, &
			ls_linecode, ls_linename, ls_linecode_t
Long		i, j
Decimal	ld_prd[12]

If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
	SetFocus()
Else
	Return
End If

dw_detail.ReSet()

ls_import		= ''
ls_workcenter	= Trim(dw_1.GetItemString(CurrentRow, "WorkCenter"))
ls_linecode		= Trim(dw_1.GetItemString(CurrentRow, "LineCode"))

If ls_linecode = 'YY' Then
	ls_linename	= Trim(dw_1.GetItemString(currentrow, "LineFullName"))
	For j = 1 To 12
		ls_date	= Right('0' + String(j), 2)
		//준수율을 구하자
		ld_prd[j]	= dw_1.GetItemNumber(currentrow, "KBRate" + ls_date)
		ls_import = ls_import + &
						ls_date + ls_date + '~t' + &
						Right('0' + String(i), 2) + ls_linename + '~t' + &
						String(ld_prd[j]) + '~t' + '~r~n'
	Next
Else
	For i = 1 To dw_1.RowCount()
		If ls_workcenter = Trim(dw_1.GetItemString(i, "WorkCenter")) Then
			ls_linecode_t	= Trim(dw_1.GetItemString(i, "LineCode"))
			ls_linename	= Trim(dw_1.GetItemString(i, "LineFullName"))
			If ls_linecode = ls_linecode_t Or ls_linecode_t = 'XX' Then
				For j = 1 To 12
					ls_date	= Right('0' + String(j), 2)
					//준수율을 구하자
					ld_prd[j]	= dw_1.GetItemNumber(i, "KBRate" + ls_date)
					ls_import = ls_import + &
									ls_date + ls_date + '~t' + &
									Right('0' + String(i), 2) + ls_linename + '~t' + &
									String(ld_prd[j]) + '~t' + '~r~n'
				Next
			End If
		End If
	Next
End If

dw_detail.ImportString(ls_import)

//dw_2.visible = false
//f_set_graph(idw_2, 12)
//dw_2.visible = true
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisk140i
integer x = 635
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
	dw_data.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_division from u_pisc_select_division within w_pisk140i
integer x = 1134
integer y = 68
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_data.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisk140i
integer x = 1733
integer y = 68
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_line from u_pisc_select_line within w_pisk140i
integer x = 2409
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_detail from datawindow within w_pisk140i
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisk_graph_line_series"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_pisk140i
integer x = 14
integer y = 1612
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type uo_year from u_pisc_date_scroll_year within w_pisk140i
integer x = 55
integer y = 68
boolean bringtotop = true
end type

on uo_year.destroy
call u_pisc_date_scroll_year::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_data from datawindow within w_pisk140i
integer x = 1006
integer y = 304
integer width = 411
integer height = 432
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisk140i_01"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible = false
end event

type dw_print from datawindow within w_pisk140i
integer x = 1001
integer y = 840
integer width = 411
integer height = 416
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisk_month_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible = false
end event

type gb_1 from groupbox within w_pisk140i
integer x = 599
integer width = 1111
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisk140i
integer x = 1714
integer width = 1280
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisk140i
integer x = 14
integer width = 581
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

