$PBExportHeader$w_pism110i.srw
$PBExportComments$���� ������ �� �ܾ��� ��Ȳ - �׷���
forward
global type w_pism110i from w_pism_sheet03
end type
type dw_buhajanup from u_pism_dw within w_pism110i
end type
end forward

global type w_pism110i from w_pism_sheet03
dw_buhajanup dw_buhajanup
end type
global w_pism110i w_pism110i

on w_pism110i.create
int iCurrent
call super::create
this.dw_buhajanup=create dw_buhajanup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_buhajanup
end on

on w_pism110i.destroy
call super::destroy
destroy(this.dw_buhajanup)
end on

event open;call super::open;wf_setRetCondition(STYEAR)

ib_wcallview = True 
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '�� ' + & 
						 uo_div.is_uo_divisionname + "���� " + uo_wc.is_uo_workcentername + " ��", '���� ' + dw_buhajanup.Title + "�� ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.") 

dw_buhajanup.SetTransObject(SqlPIS) 
li_ret = dw_buhajanup.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "��ȸ����", istr_mh.year + '��~n' + uo_wc.is_uo_workcentername + " ���� ��������� �������� �ʽ��ϴ�.")

dw_buhajanup.SetFocus() 
end event

event ue_postopen;call super::ue_postopen;//dw_buhajanup2.InsertRow(0)
end event

event resize;call super::resize;dw_buhajanup.Width = newwidth - ( dw_buhajanup.x + 10 ) 
dw_buhajanup.Height = newheight - ( dw_buhajanup.y + uo_status.Height + 10 ) 

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//�������

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_buhajanup 
lstr_prt.DataObject = 'd_pism110i_02_p' 
lstr_prt.title = istr_mh.year + '�� ' + uo_div.is_uo_divisionname + "���� " + dw_buhajanup.Title 

lstr_prt.dwsyntax = "title.text = '" + istr_mh.year + '�� ���� ����/�ܾ���' + "'	t_divwc.Text = '" + &
							uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + " " + uo_wc.is_uo_workcenterName + " ��'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! ) 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism110i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism110i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism110i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism110i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism110i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism110i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism110i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism110i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism110i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism110i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism110i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism110i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism110i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism110i
end type

type dw_buhajanup from u_pism_dw within w_pism110i
integer x = 9
integer y = 160
integer width = 3355
integer height = 1728
integer taborder = 11
boolean bringtotop = true
string title = "���� ����/�ܾ���"
string dataobject = "d_pism110i_02"
integer ii_selection = 0
end type

