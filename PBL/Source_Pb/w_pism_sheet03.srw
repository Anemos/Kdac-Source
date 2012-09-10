$PBExportHeader$w_pism_sheet03.srw
$PBExportComments$최상위 Sheet03 - 지역, 공장, 조, 기준년/기준월선택
forward
global type w_pism_sheet03 from w_ipis_sheet01
end type
type uo_wc from u_pism_select_workcenter within w_pism_sheet03
end type
type st_fromto from statictext within w_pism_sheet03
end type
type gb_1 from groupbox within w_pism_sheet03
end type
type uo_fromdate from u_pisc_date_firstday within w_pism_sheet03
end type
type uo_year from u_pisc_date_scroll_year within w_pism_sheet03
end type
type uo_month from u_pisc_date_scroll_month within w_pism_sheet03
end type
type uo_frmonth from u_pisc_date_scroll_month within w_pism_sheet03
end type
type gb_2 from groupbox within w_pism_sheet03
end type
type uo_tomonth from u_pisc_date_scroll_month within w_pism_sheet03
end type
type st_fromtomonth from statictext within w_pism_sheet03
end type
type uo_todate from u_pisc_date_yesterday_1 within w_pism_sheet03
end type
type uo_area from u_pisc_select_area within w_pism_sheet03
end type
type uo_div from u_pisc_select_division within w_pism_sheet03
end type
end forward

shared variables

end variables

global type w_pism_sheet03 from w_ipis_sheet01
integer width = 4901
long il_obj_above_y = 44139016
long il_obj_above_height = 44139912
long il_obj_split_v_x = 44138632
long il_obj_split_v_width = 53122472
long il_obj_split_v_y = 44183152
long il_obj_split_v_height = 24064208
long il_obj_split_h_x = 24097144
long il_obj_split_h_width = 44139400
long il_obj_split_h_y = 53122920
long il_obj_split_h_height = 44182064
event ue_retresult ( long rowcount )
event ue_download ( )
uo_wc uo_wc
st_fromto st_fromto
gb_1 gb_1
uo_fromdate uo_fromdate
uo_year uo_year
uo_month uo_month
uo_frmonth uo_frmonth
gb_2 gb_2
uo_tomonth uo_tomonth
st_fromtomonth st_fromtomonth
uo_todate uo_todate
uo_area uo_area
uo_div uo_div
end type
global w_pism_sheet03 w_pism_sheet03

type variables
str_pism_daily istr_mh
Boolean ib_divallview, ib_wcallView 
Integer ii_retCondition 
Constant Integer STYEAR = 1, &
					  STMONTH = 2, & 
					  STFROMTODATE = 3, & 
					  STFROMTOMONTH = 4 
end variables

forward prototypes
public subroutine wf_setretcondition (integer ai_condition)
public subroutine wf_setistrmh (str_pism_daily astr_mh)
public function str_pism_daily wf_getistr ()
end prototypes

event ue_retresult(long rowcount);this.uo_status.st_message.text = '조회결과 : ' + String(rowcount) 
end event

event ue_download();IF NOT IsValid( idw_focused ) THEN
	MessageBox("자료Download 실패","선택된 DataWindow가 없습니다")
	RETURN
END IF

string docname, named
integer value

If GetFileSaveName("Select File", docname, named, "DOC", "Excel Files (*.XLS),*.XLS," + &
              		 " EXCEL Files (*.XLS), *.XLS") = 1 Then 
	f_pism_exportexcel(idw_focused, docname)
End If

end event

public subroutine wf_setretcondition (integer ai_condition);
ii_retCondition = ai_condition

Choose Case ai_condition
	Case STYEAR	// 기준년 
		gb_2.Width = 600 
		uo_year.Visible = True 
		uo_month.Visible = False 
		
		uo_fromdate.Visible = False
		st_fromto.Visible = False
		uo_todate.Visible = False  
		uo_frmonth.Visible = False 
		st_fromtomonth.Visible = False 
		uo_tomonth.Visible = False 
		
		istr_mh.year = uo_year.is_uo_year

	Case STMONTH 	// 기준월 
		gb_2.Width = 677 
		uo_month.Visible = True 
		uo_year.Visible = False 

		uo_fromdate.Visible = False
		st_fromto.Visible = False
		uo_todate.Visible = False
		uo_frmonth.Visible = False 
		st_fromtomonth.Visible = False 
		uo_tomonth.Visible = False 
		
		istr_mh.year = Left(uo_month.is_uo_month, 4) 
		istr_mh.month = Right(uo_month.is_uo_month, 2) 			

	Case STFROMTODATE	// 기준기간 
		gb_2.Width = 1230
		uo_year.Visible = False
		uo_month.Visible = False 
		uo_frmonth.Visible = False 
		st_fromtomonth.Visible = False 
		uo_tomonth.Visible = False 
		
		uo_fromdate.Visible = True
		st_fromto.Visible = True 
		uo_todate.Visible = True 
		
	Case STFROMTOMONTH	// 기준년월(From ~ To) 
		gb_2.Width = 1230
		
		uo_year.Visible = False
		uo_month.Visible = False 
		uo_frmonth.Visible = False 
		uo_tomonth.Visible = False 
		uo_fromdate.Visible = False
		st_fromto.Visible = False 
		uo_todate.Visible = False  

		uo_tomonth.Visible = True 
		st_fromtomonth.Visible = True; st_fromtomonth.BringtoTop = True 
		uo_frmonth.Visible = True 

		uo_frmonth.uf_setdata(Date(String(Year(Today())) + ".01.01")) 
End Choose 

end subroutine

public subroutine wf_setistrmh (str_pism_daily astr_mh);
If IsNull(astr_mh.area) Then astr_mh.area = '' 
If IsNull(astr_mh.div) Then astr_mh.div = '' 
If IsNull(astr_mh.wc) Then astr_mh.wc = '' 

If uo_area.is_uo_areacode <> astr_mh.area Then
	f_pisc_retrieve_dddw_division(uo_div.dw_1, &
											g_s_empno, &
											astr_mh.area, &
											'%', &
											False, &
											astr_mh.div, &
											uo_div.is_uo_divisionname, &
											uo_div.is_uo_divisionnameeng)
End If 

If uo_div.is_uo_divisioncode <> astr_mh.div Then 
	f_pisc_retrieve_dddw_workcenter(uo_wc.dw_1, &
											astr_mh.area, &
											astr_mh.div, &
											'%', &
											False, &
											uo_wc.is_uo_workcenter, &
											uo_wc.is_uo_workcentername) 
End If

uo_area.dw_1.SetItem(uo_area.dw_1.Getrow(), "dddwcode", astr_mh.area) 
uo_div.dw_1.SetItem(uo_div.dw_1.GetRow(), "dddwcode", astr_mh.div) 

uo_wc.uf_setWorkcenter(astr_mh.area, astr_mh.div, astr_mh.wc) 

istr_mh = astr_mh

end subroutine

public function str_pism_daily wf_getistr ();Return istr_mh 
end function

on w_pism_sheet03.create
int iCurrent
call super::create
this.uo_wc=create uo_wc
this.st_fromto=create st_fromto
this.gb_1=create gb_1
this.uo_fromdate=create uo_fromdate
this.uo_year=create uo_year
this.uo_month=create uo_month
this.uo_frmonth=create uo_frmonth
this.gb_2=create gb_2
this.uo_tomonth=create uo_tomonth
this.st_fromtomonth=create st_fromtomonth
this.uo_todate=create uo_todate
this.uo_area=create uo_area
this.uo_div=create uo_div
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_wc
this.Control[iCurrent+2]=this.st_fromto
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.uo_fromdate
this.Control[iCurrent+5]=this.uo_year
this.Control[iCurrent+6]=this.uo_month
this.Control[iCurrent+7]=this.uo_frmonth
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.uo_tomonth
this.Control[iCurrent+10]=this.st_fromtomonth
this.Control[iCurrent+11]=this.uo_todate
this.Control[iCurrent+12]=this.uo_area
this.Control[iCurrent+13]=this.uo_div
end on

on w_pism_sheet03.destroy
call super::destroy
destroy(this.uo_wc)
destroy(this.st_fromto)
destroy(this.gb_1)
destroy(this.uo_fromdate)
destroy(this.uo_year)
destroy(this.uo_month)
destroy(this.uo_frmonth)
destroy(this.gb_2)
destroy(this.uo_tomonth)
destroy(this.st_fromtomonth)
destroy(this.uo_todate)
destroy(this.uo_area)
destroy(this.uo_div)
end on

event open;call super::open;//istr_mh = message.PowerObjectParm 

end event

event ue_postopen;call super::ue_postopen;String ls_area, ls_div 
str_pism_daily lstr_mh

//If IsValid(istr_mh) Then 
//	ls_area = istr_mh.area
//Else
	ls_area = uo_area.is_uo_areacode
//End If 

f_pisc_retrieve_dddw_division(uo_div.dw_1, &
										g_s_empno, &
										ls_area, &
										'%', &
										ib_divallview, &
										uo_div.is_uo_divisioncode, &
										uo_div.is_uo_divisionname, &
										uo_div.is_uo_divisionnameeng)
									
//If IsValid(istr_mh) Then 
//	ls_div  = istr_mh.div 
//Else
	ls_div  = uo_div.is_uo_divisioncode
//End If 
									
f_pisc_retrieve_dddw_workcenter(uo_wc.dw_1, &
										ls_area, &
										ls_div, &
										'%', &
										ib_wcallView, &
										uo_wc.is_uo_workcenter, &
										uo_wc.is_uo_workcentername) 

//If IsValid(istr_mh) Then 
//	wf_setistrmh(istr_mh)  
//Else
	istr_mh = lstr_mh 
	
	istr_mh.area = uo_area.is_uo_areacode
	istr_mh.div = uo_div.is_uo_divisioncode 
	istr_mh.wc = uo_wc.is_uo_workcenter 
	
	Choose Case ii_retcondition
		Case STYEAR
			istr_mh.year = uo_year.is_uo_year
		Case STMONTH
			istr_mh.year = Left(uo_month.is_uo_month, 4) 
			istr_mh.month = Right(uo_month.is_uo_month, 2) 	
		Case STFROMTODATE 
			If uo_fromdate.is_uo_date > uo_todate.is_uo_date Then 
				uo_fromdate.sle_date.Text = Left(uo_todate.is_uo_date, 7) + '.01' 
				uo_fromdate.id_uo_date = Date(uo_fromdate.sle_date.Text) 
				uo_fromdate.is_uo_date = String(uo_fromdate.id_uo_date, 'YYYY.MM.DD')
				uo_fromdate.init_cal(uo_fromdate.id_uo_date)
				uo_fromdate.set_date_format ('yyyy.mm.dd')
				uo_fromdate.TriggerEvent("ue_variable_set")
				uo_fromdate.TriggerEvent("ue_select")				
			End If 
			
			istr_mh.from_date = uo_fromdate.is_uo_date
			istr_mh.to_date = uo_todate.is_uo_date
	End Choose 
//End If 

end event

event close;call super::close;If IsValid(w_pism_finditem) Then Close(w_pism_finditem) 
end event

type uo_status from w_ipis_sheet01`uo_status within w_pism_sheet03
end type

type uo_wc from u_pism_select_workcenter within w_pism_sheet03
integer x = 1175
integer y = 44
integer width = 1056
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_wc.destroy
call u_pism_select_workcenter::destroy
end on

event ue_select;call super::ue_select;dw_1.AcceptText() 

istr_mh.wc = is_uo_workcenter
end event

type st_fromto from statictext within w_pism_sheet03
integer x = 2962
integer y = 56
integer width = 46
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pism_sheet03
integer x = 9
integer y = 4
integer width = 2240
integer height = 132
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_fromdate from u_pisc_date_firstday within w_pism_sheet03
integer x = 2281
integer y = 52
integer taborder = 30
end type

on uo_fromdate.destroy
call u_pisc_date_firstday::destroy
end on

event ue_select;call super::ue_select;If IsValid(istr_mh) Then istr_mh.from_date = uo_fromdate.is_uo_date

end event

type uo_year from u_pisc_date_scroll_year within w_pism_sheet03
integer x = 2309
integer y = 52
integer width = 507
integer height = 72
integer taborder = 40
end type

on uo_year.destroy
call u_pisc_date_scroll_year::destroy
end on

event dragdrop;call super::dragdrop;If IsValid(istr_mh) Then istr_mh.year = This.is_uo_year
end event

event ue_select;call super::ue_select;If IsValid(istr_mh) Then istr_mh.year = This.is_uo_year
end event

type uo_month from u_pisc_date_scroll_month within w_pism_sheet03
integer x = 2304
integer y = 52
integer width = 594
integer taborder = 30
end type

event ue_select;call super::ue_select;If IsValid(istr_mh) Then 
	istr_mh.year = Left(uo_month.is_uo_month, 4) 
	istr_mh.month = Right(uo_month.is_uo_month, 2) 
End If 
end event

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type uo_frmonth from u_pisc_date_scroll_month within w_pism_sheet03
integer x = 2286
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_frmonth.destroy
call u_pisc_date_scroll_month::destroy
end on

type gb_2 from groupbox within w_pism_sheet03
integer x = 2258
integer y = 4
integer width = 677
integer height = 132
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_tomonth from u_pisc_date_scroll_month within w_pism_sheet03
integer x = 2811
integer y = 52
integer taborder = 40
end type

on uo_tomonth.destroy
call u_pisc_date_scroll_month::destroy
end on

type st_fromtomonth from statictext within w_pism_sheet03
integer x = 2857
integer y = 48
integer width = 169
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_todate from u_pisc_date_yesterday_1 within w_pism_sheet03
integer x = 3008
integer y = 52
integer taborder = 50
end type

event ue_select;call super::ue_select;If IsValid(istr_mh) Then istr_mh.to_date = uo_todate.is_uo_date 

end event

on uo_todate.destroy
call u_pisc_date_yesterday_1::destroy
end on

type uo_area from u_pisc_select_area within w_pism_sheet03
integer x = 64
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_1.AcceptText() 

f_pisc_retrieve_dddw_division(uo_div.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										ib_divallview, &
										uo_div.is_uo_divisioncode, &
										uo_div.is_uo_divisionname, &
										uo_div.is_uo_divisionnameeng)

f_pisc_retrieve_dddw_workcenter(uo_wc.dw_1, &
										uo_area.is_uo_areacode, &
										uo_div.is_uo_divisioncode, &
										'%', &
										ib_wcallView, &
										uo_wc.is_uo_workcenter, &
										uo_wc.is_uo_workcentername)

istr_mh.area = uo_area.is_uo_areacode
uo_div.TriggerEvent("ue_select")
end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_div from u_pisc_select_division within w_pism_sheet03
integer x = 594
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_1.AcceptText() 

f_pisc_retrieve_dddw_workcenter(uo_wc.dw_1, &
										uo_area.is_uo_areacode, &
										uo_div.is_uo_divisioncode, &
										'%', &
										ib_wcallView, &
										uo_wc.is_uo_workcenter, &
										uo_wc.is_uo_workcentername)
										
istr_mh.div = uo_div.is_uo_divisioncode 
uo_wc.TriggerEvent("ue_select")
end event

on uo_div.destroy
call u_pisc_select_division::destroy
end on

