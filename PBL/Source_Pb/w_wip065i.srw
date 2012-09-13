$PBExportHeader$w_wip065i.srw
$PBExportComments$일일재공이체현황(공제분)
forward
global type w_wip065i from w_origin_sheet04
end type
type dw_1 from datawindow within w_wip065i
end type
type dw_2 from datawindow within w_wip065i
end type
type dw_3 from datawindow within w_wip065i
end type
type pb_1 from picturebutton within w_wip065i
end type
type gb_1 from groupbox within w_wip065i
end type
end forward

global type w_wip065i from w_origin_sheet04
integer width = 4736
integer height = 2896
string title = "일간재공 이체현황(공제분)"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
pb_1 pb_1
gb_1 gb_1
end type
global w_wip065i w_wip065i

type variables
string i_s_iocd, i_s_fromdt, i_s_yesterday, i_s_adddt
end variables

forward prototypes
public function string wf_find_datachk (string arg_plant, string arg_dvsn)
end prototypes

public function string wf_find_datachk (string arg_plant, string arg_dvsn);//** 재공마감년월일자 반환

string ls_iocd, ls_plant, ls_dvsn, ls_vndr, ls_cttp, ls_rtnvalue
string ls_fromdt, ls_todt, ls_errcolumn, ls_chkcd, ls_chkdt

dw_3.accepttext()
ls_errcolumn = ""
ls_vndr = dw_3.getitemstring(1,"vndr")
ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_3.getitemstring(1,"wip001_waiocd")
ls_fromdt = dw_3.getitemstring(1,"wip001_wainptdt")

if ls_iocd = '1' then
	
else
	if f_spacechk(ls_vndr) <> -1 then
		ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
		if f_spacechk(ls_rtnvalue) <> -1 then		//사업자번호가 입력된경우
			dw_3.modify("vndr.background.color = 1090519039")
			dw_3.setitem(1,"vndnm",mid(ls_rtnvalue,6))
			dw_3.setitem(1,"wip001_waorct",trim(mid(ls_rtnvalue,1,5)))
		else
			dw_3.modify("vndr.background.color = 65535")
			if f_spacechk(ls_errcolumn) = -1 then
				ls_errcolumn = "vndr"
			end if
		end if
	end if
end if

if f_dateedit(ls_fromdt) = space(8) then
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
	
//상태코드 체크
if ls_fromdt >= g_s_date then
	uo_status.st_message.text = "마감되지 않은 적용일자 입니다."
	dw_3.modify("wip001_wainptdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_wainptdt"
	end if
else
	dw_3.modify("wip001_wainptdt.background.color = 15780518")
end if

if f_spacechk(ls_errcolumn) <> -1 then
	uo_status.st_message.text = "에러사항을 수정후 조회바랍니다."
	dw_3.setcolumn(ls_errcolumn)
	dw_3.setfocus()
	return '190001'
else
	return ls_chkdt
end if
end function

on w_wip065i.create
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

on w_wip065i.destroy
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
dw_3.setitem(1,"wip001_wainptdt",f_relativedate(g_s_date,-1))

// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false, false, false, false, false, false)

end event

event ue_retrieve;//*****************************************************************
// 재공수불현황 ( 라인, 업체, 창고 )
// 시작년월과 완료년월 입력가능
//*****************************************************************
integer l_n_rowcnt
string ls_plant,ls_dvsn,ls_pdcd
string ls_cur_year, ls_cur_month, ls_post_year, ls_post_month

dw_3.accepttext()
if f_wip_mandantory_chk( dw_3 ) = -1 then return 0   //필수입력사항

ls_plant  = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn   = dw_3.getitemstring(1,"wip001_wadvsn")
ls_pdcd   = dw_3.getitemstring(1,"inv101_pdcd")
if f_spacechk(ls_pdcd) = -1 then
	ls_pdcd = '%'
else
	ls_pdcd = ls_pdcd + '%'
end if

i_s_adddt = wf_find_datachk(ls_plant, ls_dvsn)
if i_s_adddt = '190001' then return 0

if f_spacechk(ls_dvsn) = -1 then 
	ls_dvsn = '%'
end if
i_s_iocd   = dw_3.getitemstring(1,"wip001_waiocd")

i_s_fromdt = dw_3.getitemstring(1,"wip001_wainptdt")
i_s_yesterday = f_relativedate(i_s_fromdt,-1)
if i_s_iocd = '1' then
	l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_iocd, ls_pdcd, i_s_fromdt, i_s_adddt, i_s_yesterday)
elseif i_s_iocd = '2' then
	l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_iocd, ls_pdcd, i_s_fromdt, i_s_adddt, i_s_yesterday)
else
	l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, ls_pdcd, i_s_fromdt, i_s_adddt, i_s_yesterday)
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

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
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

l_s_refdate = i_s_fromdt

l_s_kijun = mid(i_s_fromdt,1,4) + '.' + mid(i_s_fromdt,5,2) + '.' + '01' + ' - ' + mid(l_s_refdate,1,4) + '.' + mid(l_s_refdate,5,2) + '.' + mid(l_s_refdate,7,2)

//mod_string =  "t_kijun.text = '( " + l_s_kijun + " )'" + "t_plant.text = '" + l_s_plant + "'" + &
//										 "t_dvsn.text   = '" + l_s_dvsn + "'" 
mod_string =  "t_kijun.text = '( " + l_s_kijun + " )'"	

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_2
l_str_prt.dwsyntax = mod_string
//l_str_prt.title = "완성품별 사용실적"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip065i
end type

type dw_1 from datawindow within w_wip065i
integer x = 14
integer y = 368
integer width = 4594
integer height = 2108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip065i_linelist"
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

type dw_2 from datawindow within w_wip065i
boolean visible = false
integer x = 2519
integer y = 152
integer width = 411
integer height = 432
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip065i_linerpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_wip065i
event ue_dwkeydown pbm_dwnkey
integer x = 69
integer y = 44
integer width = 3483
integer height = 256
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip064i_01"
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
		dw_1.dataobject = 'd_wip065i_linelist'
		dw_1.settransobject(sqlca)
		dw_2.dataobject = 'd_wip065i_linerpt'
		dw_2.settransobject(sqlca)
	elseif data = '2' then
		dw_1.dataobject = 'd_wip065i_vndlist'
		dw_1.settransobject(sqlca)
		dw_2.dataobject = 'd_wip065i_vndrpt'
		dw_2.settransobject(sqlca) 
	else
		dw_1.dataobject = 'd_wip065i_stklist'
		dw_1.settransobject(sqlca)
		dw_2.dataobject = 'd_wip065i_stkrpt'
		dw_2.settransobject(sqlca)
	end if
end if
end event

type pb_1 from picturebutton within w_wip065i
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

type gb_1 from groupbox within w_wip065i
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

