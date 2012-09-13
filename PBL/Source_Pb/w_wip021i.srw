$PBExportHeader$w_wip021i.srw
$PBExportComments$사용실적조회
forward
global type w_wip021i from w_origin_sheet04
end type
type dw_list from datawindow within w_wip021i
end type
type dw_2 from datawindow within w_wip021i
end type
type dw_report from datawindow within w_wip021i
end type
type pb_down from picturebutton within w_wip021i
end type
type gb_1 from groupbox within w_wip021i
end type
end forward

global type w_wip021i from w_origin_sheet04
string title = "사용실적조회"
dw_list dw_list
dw_2 dw_2
dw_report dw_report
pb_down pb_down
gb_1 gb_1
end type
global w_wip021i w_wip021i

type variables
string i_s_adjdate
end variables

forward prototypes
public function integer wf_find_datachk ()
end prototypes

public function integer wf_find_datachk ();string ls_iocd, ls_plant, ls_dvsn, ls_vndr, ls_itno, ls_rtnvalue
string ls_fromdt, ls_todt, ls_errcolumn

dw_2.accepttext()
ls_errcolumn = ""
ls_vndr = dw_2.getitemstring(1,"vndr")
ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_2.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_2.getitemstring(1,"wip001_waiocd")
ls_fromdt = dw_2.getitemstring(1,"wip001_wainptdt") + '01'

if f_dateedit(ls_fromdt) = space(8) then
	dw_2.modify("wip001_wainptdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_wainptdt"
	end if
else
	dw_2.modify("wip001_wainptdt.background.color = 15780518")
end if

if mid(ls_fromdt,1,6) > mid(g_s_date,1,6) then
	dw_2.modify("wip001_wainptdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_wainptdt"
	end if
else
	dw_2.modify("wip001_wainptdt.background.color = 15780518")
end if

if f_spacechk(ls_errcolumn) <> -1 then
	dw_2.setcolumn(ls_errcolumn)
	dw_2.setfocus()
	return -1
else
	return 0
end if
end function

on w_wip021i.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_2=create dw_2
this.dw_report=create dw_report
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.gb_1
end on

on w_wip021i.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_2)
destroy(this.dw_report)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event open;call super:: open
datawindowchild dwc_01, dwc_02, dwc_03
dw_list.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_2.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_2.getchild("inv101_pdcd",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('A')

dw_2.insertrow(0)
dw_2.setitem(1,"wip001_waiocd",'1')

dw_list.dataobject = "d_sp_wip_03"
dw_list.settransobject(sqlca)
dw_report.dataobject = "d_sp_wip_03_rpt"
dw_report.settransobject(sqlca)
// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true, true, false, false, false, false, false, false, false)
  
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant,ls_dvsn,ls_iocd,ls_orct,ls_itno, ls_fromdt, ls_todt, ls_dd
string ls_yyyy, ls_mm, ls_mysql, ls_pdcd, ls_cttp, ls_chkdt
long ll_rowcnt

setpointer(hourglass!)
dw_list.reset()
dw_2.accepttext()
if f_wip_mandantory_chk( dw_2 ) = -1 then 
	uo_status.st_message.text = f_message("E010")
	return 0
end if

if wf_find_datachk() = -1 then
	uo_status.st_message.text = f_message("E010")
	return 0
end if

dw_2.accepttext()
uo_status.st_message.text = "조회중입니다..."
ls_plant  = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn   = dw_2.getitemstring(1,"wip001_wadvsn")
ls_iocd   = dw_2.getitemstring(1,"wip001_waiocd")
ls_fromdt = dw_2.getitemstring(1,"wip001_wainptdt")
ls_todt = ls_fromdt

if f_spacechk(ls_plant) <> -1 then
	ls_cttp = 'WIP' + ls_dvsn + '080'
	select wzeddt into :ls_chkdt from pbwip.wip090
	where wzcmcd = :g_s_company and wzplant = :ls_plant and wzcttp = :ls_cttp
	using sqlca;
		
	//상태코드 체크
	if ls_fromdt > ls_chkdt then
		uo_status.st_message.text = "이전달의 실적에 대한 재공상세정보만 조회할수 있습니다."
		return -1
	end if
end if

ls_fromdt = f_relativedate(uf_wip_addmonth(ls_fromdt,1) + '01', -1)
i_s_adjdate = ls_fromdt
ls_yyyy = mid(ls_fromdt,1,4)
ls_mm = mid(ls_fromdt,5,2)
ls_dd = mid(ls_fromdt,7,2)
ls_pdcd = trim(dw_2.getitemstring(1,"inv101_pdcd"))

if ls_iocd = '1' then
	DECLARE up_wip_03 PROCEDURE FOR PBWIP.SP_WIP_03  
				@CMCD = :g_s_company,   
				@PLANT = :ls_plant,   
				@DVSN = :ls_dvsn,
				@PDCD = :ls_pdcd,
				@YYYY = :ls_yyyy,   
				@MM = :ls_mm,
				@DD = :ls_dd;
	
	execute up_wip_03;
else
	if f_spacechk(ls_plant) = -1 then
		DECLARE up_wip_041 PROCEDURE FOR PBWIP.SP_WIP_041  
				@CMCD = :g_s_company,   
				@YYYY = :ls_yyyy,   
				@MM = :ls_mm,   
				@DD = :ls_dd  ;
	
		execute up_wip_041;
	else
		DECLARE up_wip_04 PROCEDURE FOR PBWIP.SP_WIP_04  
				@CMCD = :g_s_company,   
				@PLANT = :ls_plant,   
				@DVSN = :ls_dvsn,
				@PDCD = :ls_pdcd,
				@YYYY = :ls_yyyy,   
				@MM = :ls_mm,   
				@DD = :ls_dd  ;
	
		execute up_wip_04;
	end if
end if

ll_rowcnt = dw_list.retrieve(ls_yyyy,ls_mm)
ls_mysql = "DROP TABLE QTEMP.WIPTEMP01"
Execute Immediate :ls_mysql using sqlca;
if ll_rowcnt > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	return 0
end if
end event

event ue_print;call super::ue_print;integer l_n_rowcnt, i
string mod_string,l_s_plant,l_s_dvsn
string l_s_refdate, l_s_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
//this.TriggerEvent("ue_retrieve")
if dw_list.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_list.sharedata(dw_report)
l_s_plant  = f_get_coitname(g_s_company,'SLE220', trim(dw_list.object.twplant[1]))
l_s_dvsn   = f_get_coitname(g_s_company,'DAC030', trim(dw_list.object.twdvsn[1])) 

l_s_kijun = mid(i_s_adjdate,1,4) + '.' + mid(i_s_adjdate,5,2) + '.' + '01' + ' - ' + mid(i_s_adjdate,1,4) + '.' + mid(i_s_adjdate,5,2) + '.' + mid(i_s_adjdate,7,2)

mod_string =  "t_kijun.text = '( " + l_s_kijun + " )'" + "t_plant.text = '" + l_s_plant + "'" + &
										 "t_dvsn.text   = '" + l_s_dvsn + "'" 
	

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "재공 상세현황"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip021i
end type

type dw_list from datawindow within w_wip021i
integer x = 9
integer y = 392
integer width = 4608
integer height = 2080
boolean bringtotop = true
string dataobject = "d_sp_wip_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip021i
event ue_enterkey pbm_dwnkey
integer x = 64
integer y = 56
integer width = 3031
integer height = 288
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip021_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1,cdw_2

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   dw_2.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = dw_2.GetItemString(1,'wip001_waplant')
   dw_2.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF

if ls_colname = 'wip001_waiocd' then
	if data = '2' then
		dw_list.dataobject = "d_sp_wip_04"
		dw_list.settransobject(sqlca)
		dw_report.dataobject = "d_sp_wip_04_rpt"
		dw_report.settransobject(sqlca)
	else
		dw_list.dataobject = "d_sp_wip_03"
		dw_list.settransobject(sqlca)
		dw_report.dataobject = "d_sp_wip_03_rpt"
		dw_report.settransobject(sqlca)
	end if
end if

end event

type dw_report from datawindow within w_wip021i
boolean visible = false
integer x = 4302
integer y = 52
integer width = 251
integer height = 136
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_wip021i
integer x = 3648
integer y = 188
integer width = 334
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_list.rowcount() < 1 then
	return 0
end if

f_save_to_excel(dw_list)
end event

type gb_1 from groupbox within w_wip021i
integer x = 18
integer width = 4590
integer height = 372
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

