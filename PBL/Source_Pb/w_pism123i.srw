$PBExportHeader$w_pism123i.srw
$PBExportComments$���庰 �Ϻ� LPI��ȸ(���ϰ濵��ǥ)
forward
global type w_pism123i from w_pism_sheet02
end type
type dw_pism123i_01 from u_pism_dw within w_pism123i
end type
type pb_down1 from picturebutton within w_pism123i
end type
end forward

global type w_pism123i from w_pism_sheet02
integer width = 3913
integer height = 2828
dw_pism123i_01 dw_pism123i_01
pb_down1 pb_down1
end type
global w_pism123i w_pism123i

event open;call super::open;wf_setRetCondition(STMONTH)

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_pism123i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_pism123i_01.Height= newheight - dw_pism123i_01.y

end event

event ue_print;call super::ue_print;//str_pism_prt lstr_prt		//�������
//
//lstr_prt.Transaction = SqlPIS 
//
//lstr_prt.datawindow = dw_manottime
//lstr_prt.DataObject = 'd_pism180i_01_rev1_p' 
//lstr_prt.title = uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  " + dw_manottime.Title 
//
//lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" + &
//						  "t_3.Text = '" + uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  �δ� O/T ��Ȳ"  + "'" 
//
//OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(uo_div.is_uo_divisionname + "���� ", dw_pism123i_01.Title + "(��)�� ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.") 

dw_pism123i_01.SetTransObject(SqlPIS)
li_ret = dw_pism123i_01.Retrieve(istr_mh.area, istr_mh.div, uo_frMonth.is_uo_month) 
If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "��ȸ����", " �ش� ���ؿ��� �Ϻ� ��������� �������� �ʽ��ϴ�.")

dw_pism123i_01.SetFocus() 
end event

on w_pism123i.create
int iCurrent
call super::create
this.dw_pism123i_01=create dw_pism123i_01
this.pb_down1=create pb_down1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pism123i_01
this.Control[iCurrent+2]=this.pb_down1
end on

on w_pism123i.destroy
call super::destroy
destroy(this.dw_pism123i_01)
destroy(this.pb_down1)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism123i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism123i
boolean visible = false
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism123i
boolean visible = false
integer x = 2043
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism123i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism123i
boolean visible = false
integer x = 1280
integer width = 667
integer height = 80
end type

type uo_month from w_pism_sheet02`uo_month within w_pism123i
boolean visible = false
integer x = 1285
integer y = 44
end type

type uo_year from w_pism_sheet02`uo_year within w_pism123i
boolean visible = false
integer x = 1289
integer y = 44
end type

type uo_date from w_pism_sheet02`uo_date within w_pism123i
boolean visible = false
integer x = 1275
integer y = 48
end type

type uo_area from w_pism_sheet02`uo_area within w_pism123i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism123i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism123i
integer x = 1294
integer y = 48
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism123i
boolean visible = false
integer x = 1925
integer y = 44
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism123i
integer x = 1262
integer width = 645
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism123i
boolean visible = false
integer x = 1280
integer y = 48
end type

type dw_pism123i_01 from u_pism_dw within w_pism123i
integer x = 18
integer y = 160
integer width = 3163
integer height = 1624
integer taborder = 21
boolean bringtotop = true
string title = "�Ϻ� �������"
string dataobject = "d_pism123i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type pb_down1 from picturebutton within w_pism123i
integer x = 1952
integer y = 40
integer width = 229
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_pism123i_01)
end event

