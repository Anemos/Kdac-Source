$PBExportHeader$w_pism230i.srw
$PBExportComments$����ǰ ���MH ��ȸ
forward
global type w_pism230i from w_pism_sheet02
end type
type dw_pism230i_01 from u_pism_dw within w_pism230i
end type
type dw_pism230i_02 from u_pism_dw within w_pism230i
end type
type cb_maiindown from commandbutton within w_pism230i
end type
type cb_detaildown from commandbutton within w_pism230i
end type
type dw_down from datawindow within w_pism230i
end type
end forward

global type w_pism230i from w_pism_sheet02
integer width = 3840
integer height = 2620
dw_pism230i_01 dw_pism230i_01
dw_pism230i_02 dw_pism230i_02
cb_maiindown cb_maiindown
cb_detaildown cb_detaildown
dw_down dw_down
end type
global w_pism230i w_pism230i

event open;call super::open;//wf_setRetCondition(STFROMTODATE) STDATE
wf_setRetCondition(STDATE)
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

//il_resize_count ++
//
//of_resize_register(dw_manottime, FULL)
//
//of_resize()
//

dw_pism230i_01.Width = newwidth 	- ( ls_gap * 4 )
dw_pism230i_01.Height= ( newheight * 2 / 5 ) - dw_pism230i_01.y

dw_pism230i_02.x = dw_pism230i_01.x
dw_pism230i_02.y = dw_pism230i_01.y + dw_pism230i_01.Height + ls_split
dw_pism230i_02.Width = dw_pism230i_01.Width
dw_pism230i_02.Height = newheight - ( dw_pism230i_01.y + dw_pism230i_01.Height + ls_split + ls_status)

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

//** ����ڰ� ��¥�� Ű����� �Է��ϰ� �ٸ�Ű ���۾��� ���콺�� ��ȸ�������� Ŭ���ϴ� ���
//** �ٲﳯ¥�� ��ȸ���� �ʴ°��� �����ϱ� ���� �̺�Ʈ ����
uo_date.TriggerEvent("ue_loasefocus")


f_pism_working_msg(uo_div.is_uo_divisionname + "����", dw_pism230i_01.Title + "�� ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.") 
 
dw_pism230i_01.SetTransObject(SqlPIS)
li_ret = dw_pism230i_01.Retrieve(istr_mh.area, istr_mh.div, uo_date.is_uo_date ) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "��ȸ����", " �ش� �������� MH������ �������� �ʽ��ϴ�.")

dw_pism230i_01.SetFocus() 
end event

on w_pism230i.create
int iCurrent
call super::create
this.dw_pism230i_01=create dw_pism230i_01
this.dw_pism230i_02=create dw_pism230i_02
this.cb_maiindown=create cb_maiindown
this.cb_detaildown=create cb_detaildown
this.dw_down=create dw_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pism230i_01
this.Control[iCurrent+2]=this.dw_pism230i_02
this.Control[iCurrent+3]=this.cb_maiindown
this.Control[iCurrent+4]=this.cb_detaildown
this.Control[iCurrent+5]=this.dw_down
end on

on w_pism230i.destroy
call super::destroy
destroy(this.dw_pism230i_01)
destroy(this.dw_pism230i_02)
destroy(this.cb_maiindown)
destroy(this.cb_detaildown)
destroy(this.dw_down)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism230i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism230i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism230i
integer x = 2043
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism230i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism230i
integer x = 1280
integer width = 667
integer height = 92
end type

type uo_month from w_pism_sheet02`uo_month within w_pism230i
boolean visible = false
integer x = 1285
integer y = 44
end type

type uo_year from w_pism_sheet02`uo_year within w_pism230i
boolean visible = false
integer x = 1289
integer y = 44
end type

type uo_date from w_pism_sheet02`uo_date within w_pism230i
boolean visible = false
integer x = 1275
integer y = 48
end type

type uo_area from w_pism_sheet02`uo_area within w_pism230i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism230i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism230i
boolean visible = false
integer x = 1271
integer y = 44
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism230i
boolean visible = false
integer x = 1925
integer y = 44
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism230i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism230i
boolean visible = false
integer x = 1280
integer y = 48
end type

type dw_pism230i_01 from u_pism_dw within w_pism230i
integer x = 18
integer y = 164
integer width = 3328
integer height = 716
integer taborder = 21
boolean bringtotop = true
string title = "����ǰ�� ���MH"
string dataobject = "d_pism230i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_modelno
integer li_rowcnt

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_modelno = This.getitemstring( currentrow, "zmdno" )

dw_pism230i_02.SetTransObject(sqlpis)
li_rowcnt = dw_pism230i_02.retrieve(istr_mh.area, istr_mh.div, uo_date.is_uo_date , ls_modelno)

return 0
end event

type dw_pism230i_02 from u_pism_dw within w_pism230i
integer x = 27
integer y = 1008
integer width = 3305
integer height = 768
integer taborder = 31
boolean bringtotop = true
string title = "��� MH ���γ���"
string dataobject = "d_pism230i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type cb_maiindown from commandbutton within w_pism230i
integer x = 2098
integer y = 24
integer width = 562
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
string text = "��ǰMH�ٿ�ε�"
end type

event clicked;f_save_to_excel_number(dw_pism230i_01)
end event

type cb_detaildown from commandbutton within w_pism230i
integer x = 2725
integer y = 24
integer width = 521
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
string text = "���γ����ٿ�ε�"
end type

event clicked;dw_down.reset()
dw_down.retrieve(istr_mh.area, istr_mh.div, uo_date.is_uo_date )
f_save_to_excel_number(dw_down)
end event

type dw_down from datawindow within w_pism230i
boolean visible = false
integer x = 3365
integer y = 24
integer width = 357
integer height = 184
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism230i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

