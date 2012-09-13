$PBExportHeader$w_wip039e.srw
$PBExportComments$�����ü��Ȳ(������)
forward
global type w_wip039e from w_origin_sheet04
end type
type dw_1 from datawindow within w_wip039e
end type
type dw_2 from datawindow within w_wip039e
end type
type dw_3 from datawindow within w_wip039e
end type
type pb_1 from picturebutton within w_wip039e
end type
type gb_1 from groupbox within w_wip039e
end type
end forward

global type w_wip039e from w_origin_sheet04
string title = "�����ü��Ȳ(������)"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
pb_1 pb_1
gb_1 gb_1
end type
global w_wip039e w_wip039e

type variables
string i_s_iocd, i_s_fromdt, i_s_todt, i_s_adddt
end variables

forward prototypes
public function integer wf_find_datachk (string arg_plant, string arg_dvsn)
end prototypes

public function integer wf_find_datachk (string arg_plant, string arg_dvsn);string ls_iocd, ls_plant, ls_dvsn, ls_cttp, ls_rtnvalue
string ls_fromdt, ls_errcolumn, ls_chkcd, ls_chkdt

dw_3.accepttext()
ls_errcolumn = ""
ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_3.getitemstring(1,"wip001_waiocd")
ls_fromdt = dw_3.getitemstring(1,"wip001_wainptdt")

if f_dateedit(ls_fromdt + '01') = space(8) then
	dw_3.modify("wip001_wainptdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_wainptdt"
	end if
else
	dw_3.modify("wip001_wainptdt.background.color = 15780518")
end if

if f_spacechk(arg_plant) = -1 or f_spacechk(arg_dvsn) = -1 then
	ls_cttp = 'WIPA080'
	select wzeddt, wzstscd into :ls_chkdt, :ls_chkcd from pbwip.wip090
	where wzcmcd = :g_s_company and wzplant = 'D' and wzcttp = :ls_cttp
	using sqlca;
else
	ls_cttp = 'WIP' + arg_dvsn + '080'
	select wzeddt, wzstscd into :ls_chkdt, :ls_chkcd from pbwip.wip090
	where wzcmcd = :g_s_company and wzplant = :arg_plant and wzcttp = :ls_cttp
	using sqlca;
end if
	
//�����ڵ� üũ
if ls_fromdt > ls_chkdt then
	uo_status.st_message.text = "��ȸ�Ҽ� �����ϴ�."
	return -1
end if
if (ls_chkdt = ls_fromdt) and (ls_chkcd <> 'C') then
	uo_status.st_message.text = "�ܰ������ �Ϸ���� �ʾҽ��ϴ�."
	return -1
end if

if f_spacechk(ls_errcolumn) <> -1 then
	uo_status.st_message.text = "���������� ������ ��ȸ�ٶ��ϴ�."
	dw_3.setcolumn(ls_errcolumn)
	dw_3.setfocus()
	return -1
else
	return 0
end if
end function

on w_wip039e.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_wip039e.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.pb_1)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02
dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_3.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_3.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

dw_3.insertrow(0)
dw_3.setitem(1,"wip001_waiocd",'1')

// ��ȸ, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(true, false, false, false, false, false, false, false, false)

end event

event ue_retrieve;//*****************************************************************
// ���������Ȳ ( ����, ��ü, â�� )
// ���۳���� �Ϸ��� �Է°���
//*****************************************************************
integer l_n_rowcnt
string ls_plant,ls_dvsn,ls_orct, ls_vndr
string ls_cur_year, ls_cur_month, ls_post_year, ls_post_month

dw_3.accepttext()
if f_wip_mandantory_chk( dw_3 ) = -1 then return 0   //�ʼ��Է»���

ls_plant  = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn   = dw_3.getitemstring(1,"wip001_wadvsn")

if wf_find_datachk(ls_plant, ls_dvsn) = -1 then return 0
if f_spacechk(ls_dvsn) = -1 then 
	ls_dvsn = '%'
end if
i_s_iocd   = dw_3.getitemstring(1,"wip001_waiocd")
ls_vndr = dw_3.getitemstring(1,"vndr")

i_s_fromdt = dw_3.getitemstring(1,"wip001_wainptdt")
ls_cur_year = mid(i_s_fromdt,1,4)
ls_cur_month = mid(i_s_fromdt,5,2)
//i_s_todt = dw_3.getitemstring(1,"wip001_waupdtdt")
i_s_adddt = uf_wip_addmonth(i_s_fromdt,-1)
ls_post_year = mid(i_s_adddt,1,4)
ls_post_month = mid(i_s_adddt,5,2)

if i_s_iocd = '1' then
	l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_iocd, &
			i_s_fromdt, i_s_adddt)
elseif i_s_iocd = '2' then
	l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_iocd, &
			i_s_fromdt, i_s_adddt)
else
	l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, &
			i_s_fromdt, i_s_adddt)
end if

if l_n_rowcnt > 0 then 
   uo_status.st_message.text = f_message("I010")
	i_b_print = true
else
   uo_status.st_message.text = f_message("I020")
   i_b_print = false
end if

wf_icon_onoff(i_b_retrieve, i_b_print,      i_b_first,   i_b_prev,   i_b_next,  & 
 				  i_b_last,     i_b_dretrieve,  i_b_dprint,  i_b_dchar)
return 0

 
end event

event ue_print;integer l_n_rowcnt, i
string mod_string,l_s_plant,l_s_dvsn
string l_s_refdate, l_s_kijun

window 	l_to_open
str_easy l_str_prt

								
//��� �����쿡 Data ����, ��� ������ Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "��� �غ��� �Դϴ�..."
//this.TriggerEvent("ue_retrieve")
if dw_1.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_1.sharedata(dw_2)
//if i_s_iocd = '3' then
//	l_s_plant  = f_get_coitname(g_s_company,'SLE220', trim(dw_1.object.wip003_a_wcplant[1]))
//   l_s_dvsn   = f_get_coitname(g_s_company,'DAC030', trim(dw_1.object.wip003_a_wcdvsn[1])) 
//else
//	l_s_plant  = f_get_coitname(g_s_company,'SLE220', trim(dw_1.object.wip002_a_wbplant[1]))
//   l_s_dvsn   = f_get_coitname(g_s_company,'DAC030', trim(dw_1.object.wip002_a_wbdvsn[1])) 
//end if

l_s_refdate = f_RelativeDate(uf_wip_addmonth(i_s_todt,1) + '01',  - 1)

l_s_kijun = mid(i_s_fromdt,1,4) + '.' + mid(i_s_fromdt,5,2) + '.' + '01' + ' - ' + mid(l_s_refdate,1,4) + '.' + mid(l_s_refdate,5,2) + '.' + mid(l_s_refdate,7,2)

//mod_string =  "t_kijun.text = '( " + l_s_kijun + " )'" + "t_plant.text = '" + l_s_plant + "'" + &
//										 "t_dvsn.text   = '" + l_s_dvsn + "'" 
mod_string =  "t_kijun.text = '( " + l_s_kijun + " )'"	

//�μ� DataWindow ����
//w_easy_prt�� dwsyntax�� ���� modify()���� �߰���
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_2
l_str_prt.dwsyntax = mod_string
//l_str_prt.title = "�ϼ�ǰ�� ������"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open�� ���Window �ݱ�
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip039e
end type

type dw_1 from datawindow within w_wip039e
integer x = 14
integer y = 368
integer width = 4594
integer height = 2108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip039e_linelist"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

type dw_2 from datawindow within w_wip039e
boolean visible = false
integer x = 2519
integer y = 152
integer width = 411
integer height = 432
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip039e_linerpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_wip039e
event ue_dwkeydown pbm_dwnkey
integer x = 69
integer y = 44
integer width = 3483
integer height = 256
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip025e_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwkeydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = 'wip001_waiocd' then
	if data = '1' then
		dw_1.dataobject = 'd_wip039e_linelist'
		dw_1.settransobject(sqlca)
		dw_2.dataobject = 'd_wip039e_linerpt'
		dw_2.settransobject(sqlca)
	elseif data = '2' then
		dw_1.dataobject = 'd_wip039e_vndlist'
		dw_1.settransobject(sqlca)
		dw_2.dataobject = 'd_wip039e_vndrpt'
		dw_2.settransobject(sqlca) 
	else
		dw_1.dataobject = 'd_wip039e_stklist'
		dw_1.settransobject(sqlca)
		dw_2.dataobject = 'd_wip039e_stkrpt'
		dw_2.settransobject(sqlca)
	end if
end if
end event

type pb_1 from picturebutton within w_wip039e
integer x = 4050
integer y = 168
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_1)

end event

type gb_1 from groupbox within w_wip039e
integer x = 27
integer width = 4576
integer height = 320
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

