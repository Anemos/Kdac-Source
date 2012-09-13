$PBExportHeader$w_wip067i.srw
$PBExportComments$일간재공 변동추이정보
forward
global type w_wip067i from w_origin_sheet04
end type
type dw_1 from datawindow within w_wip067i
end type
type dw_3 from datawindow within w_wip067i
end type
type pb_1 from picturebutton within w_wip067i
end type
type gb_1 from groupbox within w_wip067i
end type
end forward

global type w_wip067i from w_origin_sheet04
integer width = 4773
integer height = 3000
string title = "일간재공 변동추이정보"
dw_1 dw_1
dw_3 dw_3
pb_1 pb_1
gb_1 gb_1
end type
global w_wip067i w_wip067i

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

on w_wip067i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_wip067i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.pb_1)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03
dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_3.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_3.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_3.getchild("inv101_pdcd",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('A')

dw_3.insertrow(0)
dw_3.setitem(1,"wip001_waiocd",'1')
dw_3.setitem(1,"wip001_wainptdt",f_relativedate(g_s_date,-1))
dw_3.setitem(1,"inv002_itnm", "추이정보는 " + string(f_relativedate(g_s_date,-1),"@@@@/@@/@@") + " 일 부터 2주간 정보 입니다.")

// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false, false, false, false, false, false)

end event

event ue_retrieve;//*****************************************************************
// 재공수불현황 ( 라인, 업체, 창고 )
// 시작년월과 완료년월 입력가능
//*****************************************************************
integer l_n_rowcnt
string ls_plant,ls_dvsn,ls_pdcd

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

i_s_iocd   = dw_3.getitemstring(1,"wip001_waiocd")
i_s_fromdt = dw_3.getitemstring(1,"wip001_wainptdt")
i_s_yesterday = f_relativedate(i_s_fromdt,-13)

dw_1.settransobject(sqlca)
l_n_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_iocd, ls_pdcd, i_s_yesterday, i_s_fromdt)

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

type uo_status from w_origin_sheet04`uo_status within w_wip067i
end type

type dw_1 from datawindow within w_wip067i
integer x = 14
integer y = 368
integer width = 4594
integer height = 2108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip067i_02"
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

type dw_3 from datawindow within w_wip067i
event ue_dwkeydown pbm_dwnkey
integer x = 69
integer y = 44
integer width = 3899
integer height = 256
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip067i_01"
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

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"vndnm",trim(mid(ls_parm,16)))
		This.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
		This.setitem(1,"wip001_waorct",trim(mid(ls_parm,1,5)))
	end if
end if

end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1, cdw_2

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

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF


if ls_colname = 'wip001_waiocd' then
	if data = '2' then
		This.modify("vndr_t.visible = true")
		This.modify("vndr.visible = true")
		This.modify("vsrno_t.visible = true")
		This.modify("vndnm.visible = true")
		This.modify("b_search.visible = true")
	else
		This.modify("vndr_t.visible = false")
		This.modify("vndr.visible = false")
		This.modify("vsrno_t.visible = false")
		This.modify("vndnm.visible = false")
		This.modify("b_search.visible = false")
	end if
end if

if ls_colname = "vndr" then
	string ls_rtnvalue
	ls_rtnvalue = f_get_vendor01(g_s_company, data)
	if ls_rtnvalue <> '' then		//사업자번호가 입력된경우
		This.setitem(1,"vndnm",mid(ls_rtnvalue,6))
		This.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
	else
		uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
		return 0
	end if
end if
end event

type pb_1 from picturebutton within w_wip067i
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

type gb_1 from groupbox within w_wip067i
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

