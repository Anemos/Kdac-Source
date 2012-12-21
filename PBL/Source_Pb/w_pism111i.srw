$PBExportHeader$w_pism111i.srw
$PBExportComments$월별 부하율 및 잔업율 현황 - 그래프(표준대비)
forward
global type w_pism111i from w_pism_sheet03
end type
type dw_buhajanup from u_pism_dw within w_pism111i
end type
type cbx_holiday from checkbox within w_pism111i
end type
end forward

global type w_pism111i from w_pism_sheet03
dw_buhajanup dw_buhajanup
cbx_holiday cbx_holiday
end type
global w_pism111i w_pism111i

on w_pism111i.create
int iCurrent
call super::create
this.dw_buhajanup=create dw_buhajanup
this.cbx_holiday=create cbx_holiday
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_buhajanup
this.Control[iCurrent+2]=this.cbx_holiday
end on

on w_pism111i.destroy
call super::destroy
destroy(this.dw_buhajanup)
destroy(this.cbx_holiday)
end on

event open;call super::open;wf_setRetCondition(STYEAR)

ib_wcallview = True 
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 
String ls_check

if cbx_holiday.checked then
	ls_check = 'Y'
else
	ls_check = 'N'
end if

f_pism_working_msg(istr_mh.year + '년 ' + & 
						 uo_div.is_uo_divisionname + "공장 " + uo_wc.is_uo_workcentername + " 조", '월별 ' + dw_buhajanup.Title + "를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_buhajanup.SetTransObject(SqlPIS) 
li_ret = dw_buhajanup.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year, ls_check) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년~n' + uo_wc.is_uo_workcentername + " 조의 생산실적이 존재하지 않습니다.")

dw_buhajanup.SetFocus() 
end event

event ue_postopen;call super::ue_postopen;//dw_buhajanup2.InsertRow(0)
end event

event resize;call super::resize;dw_buhajanup.Width = newwidth - ( dw_buhajanup.x + 10 ) 
dw_buhajanup.Height = newheight - ( dw_buhajanup.y + uo_status.Height + 10 ) 

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_buhajanup 
lstr_prt.DataObject = 'd_pism111i_02_p' 
lstr_prt.title = istr_mh.year + '년 ' + uo_div.is_uo_divisionname + "공장 " + dw_buhajanup.Title 

lstr_prt.dwsyntax = "title.text = '" + istr_mh.year + '년 월별 부하/잔업율' + "'	t_divwc.Text = '" + &
							uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + " " + uo_wc.is_uo_workcenterName + " 조'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! ) 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism111i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism111i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism111i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism111i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism111i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism111i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism111i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism111i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism111i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism111i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism111i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism111i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism111i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism111i
end type

type dw_buhajanup from u_pism_dw within w_pism111i
integer x = 9
integer y = 160
integer width = 3355
integer height = 1728
integer taborder = 11
boolean bringtotop = true
string title = "월별 부하/잔업율"
string dataobject = "d_pism111i_02"
integer ii_selection = 0
end type

type cbx_holiday from checkbox within w_pism111i
boolean visible = false
integer x = 3570
integer y = 44
integer width = 398
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "휴일제외"
boolean automatic = false
end type

