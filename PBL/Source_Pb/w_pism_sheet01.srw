$PBExportHeader$w_pism_sheet01.srw
$PBExportComments$최상위 Sheet01 - 지역, 공장, 조선택
forward
global type w_pism_sheet01 from w_ipis_sheet01
end type
type uo_wc from u_pism_select_workcenter within w_pism_sheet01
end type
type uo_area from u_pisc_select_area within w_pism_sheet01
end type
type uo_div from u_pisc_select_division within w_pism_sheet01
end type
type cb_wcfilter from commandbutton within w_pism_sheet01
end type
type gb_1 from groupbox within w_pism_sheet01
end type
end forward

shared variables

end variables

global type w_pism_sheet01 from w_ipis_sheet01
event ue_retresult ( long rowcount )
event ue_download ( )
uo_wc uo_wc
uo_area uo_area
uo_div uo_div
cb_wcfilter cb_wcfilter
gb_1 gb_1
end type
global w_pism_sheet01 w_pism_sheet01

type variables
str_pism_daily istr_mh, istr_retrieveMH 
Boolean ib_divallview, ib_wcallView 
Boolean ib_chgArea, ib_chgDiv, ib_chgWC 
end variables

forward prototypes
public function str_pism_daily wf_getistr ()
public subroutine wf_setistrmh (str_pism_daily astr_mh)
public function integer wf_autworkcenter (boolean ab_chk)
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

public function str_pism_daily wf_getistr ();
Return istr_mh
end function

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
											uo_div.is_uo_divisioncode, &
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
cb_wcfilter.Text = '담당조 FILTER' 
end subroutine

public function integer wf_autworkcenter (boolean ab_chk);String ls_Filter, ls_selWC, ls_autWC 

If ab_chk Then 
 DECLARE EmpAUTWC_cur CURSOR FOR  
  SELECT AutWorkCenter  
    FROM TMHEMPAUTWC  
   WHERE EmpNo = :g_s_empno And 
			AreaCode = :istr_mh.area And 
			DivisionCode = :istr_mh.div Using SqlPIS ;
	Open EmpAUTWC_cur ;
	Fetch EmpAUTWC_cur Into :ls_autWC; 
	Do While SqlPIS.SqlCode = 0 
		If ls_Filter <> '' Then ls_Filter += " Or " 
		ls_Filter += "WorkCenter = '" + ls_autWC + "'" 
		
		Fetch EmpAUTWC_cur Into :ls_autWC; 
	Loop
	Close EmpAUTWC_cur ;
	
	cb_wcfilter.Text = '담당조 FILTER 취소'
Else
	ls_Filter = ''
	
	cb_wcfilter.Text = '담당조 FILTER'
End If 

ls_selWC = uo_wc.us_setFilter(ls_Filter) 
If ls_selWC <> '' Then uo_wc.uf_setworkcenter(istr_mh.area, istr_mh.div, ls_selWC) 

uo_wc.TriggerEvent("ue_select")

Return 1 
end function

on w_pism_sheet01.create
int iCurrent
call super::create
this.uo_wc=create uo_wc
this.uo_area=create uo_area
this.uo_div=create uo_div
this.cb_wcfilter=create cb_wcfilter
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_wc
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_div
this.Control[iCurrent+4]=this.cb_wcfilter
this.Control[iCurrent+5]=this.gb_1
end on

on w_pism_sheet01.destroy
call super::destroy
destroy(this.uo_wc)
destroy(this.uo_area)
destroy(this.uo_div)
destroy(this.cb_wcfilter)
destroy(this.gb_1)
end on

event open;call super::open;istr_mh = message.PowerObjectParm 


end event

event ue_postopen;call super::ue_postopen;String ls_area, ls_div 
str_pism_daily lstr_mh
If IsValid(istr_mh) Then 
	ls_area = istr_mh.area
Else
	ls_area = uo_area.is_uo_areacode
End If 

f_pisc_retrieve_dddw_division(uo_div.dw_1, &
										g_s_empno, &
										ls_area, &
										'%', &
										ib_divallview, &
										uo_div.is_uo_divisioncode, &
										uo_div.is_uo_divisionname, &
										uo_div.is_uo_divisionnameeng)
									
If IsValid(istr_mh) Then 
	ls_div  = istr_mh.div 
Else
	ls_div  = uo_div.is_uo_divisioncode
End If 

f_pisc_retrieve_dddw_workcenter(uo_wc.dw_1, &
										ls_area, &
										ls_div, &
										'%', &
										ib_wcallView, &
										uo_wc.is_uo_workcenter, &
										uo_wc.is_uo_workcentername) 

If IsValid(istr_mh) Then 
	wf_setistrmh(istr_mh)  
Else
	istr_mh = lstr_mh 
	
	istr_mh.area 	= uo_area.is_uo_areacode
	istr_mh.div 	= uo_div.is_uo_divisioncode
	istr_mh.wc 		= uo_wc.is_uo_workcenter 
End If


end event

event close;call super::close;If IsValid(w_pism_finditem) Then Close(w_pism_finditem) 
end event

type uo_status from w_ipis_sheet01`uo_status within w_pism_sheet01
integer y = 1888
end type

type uo_wc from u_pism_select_workcenter within w_pism_sheet01
integer x = 1111
integer y = 40
integer width = 1047
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_wc.destroy
call u_pism_select_workcenter::destroy
end on

event ue_select;call super::ue_select;ib_chgWC = True 

dw_1.AcceptText() 

istr_mh.wc = is_uo_workcenter

end event

type uo_area from u_pisc_select_area within w_pism_sheet01
integer x = 32
integer y = 48
integer height = 76
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;ib_chgArea = True 

dw_1.AcceptText() 

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

type uo_div from u_pisc_select_division within w_pism_sheet01
integer x = 544
integer y = 48
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;call super::ue_select;ib_chgDiv = True 

dw_1.AcceptText() 

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

type cb_wcfilter from commandbutton within w_pism_sheet01
integer x = 2208
integer y = 40
integer width = 649
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "담당조 FILTER 취소"
end type

event clicked;String ls_Filter, ls_selWC 

If This.Text = '담당조 FILTER' Then 
	OpenWithParm(w_pism010u_02, istr_mh) 
	wf_autworkcenter(True) 
Else
	wf_autworkcenter(False) 
End If 

end event

type gb_1 from groupbox within w_pism_sheet01
integer x = 9
integer y = 4
integer width = 2162
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

