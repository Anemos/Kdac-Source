$PBExportHeader$w_wip041i.srw
$PBExportComments$사용품목별 적용 모델 조회
forward
global type w_wip041i from w_origin_sheet04
end type
type dw_head from datawindow within w_wip041i
end type
type dw_detail from datawindow within w_wip041i
end type
type dw_report from datawindow within w_wip041i
end type
type dw_2 from datawindow within w_wip041i
end type
type gb_1 from groupbox within w_wip041i
end type
end forward

global type w_wip041i from w_origin_sheet04
string tag = "사용품번별 적용모델조회"
string title = "사용품번별 적용모델조회"
event key_down pbm_keydown
dw_head dw_head
dw_detail dw_detail
dw_report dw_report
dw_2 dw_2
gb_1 gb_1
end type
global w_wip041i w_wip041i

type variables
string i_s_year1,i_s_month1,i_s_yearmonth1
string i_s_year2,i_s_month2,i_s_yearmonth2

end variables

forward prototypes
public function integer wf_find_datachk (datawindow arg_dw)
end prototypes

event key_down;window l_s_wsheet

if key = keyenter! then
  	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if

return 0
end event

public function integer wf_find_datachk (datawindow arg_dw);string ls_rtnvalue, ls_errcolumn
string ls_plant, ls_dvsn, ls_iocd, ls_vndr, ls_itno, ls_fromdt, ls_todt

ls_vndr = arg_dw.getitemstring(1,"vndr")
ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
ls_iocd = arg_dw.getitemstring(1,"wip001_waiocd")
ls_itno = arg_dw.getitemstring(1,"wip001_waitno")
ls_fromdt = arg_dw.getitemstring(1,"wip001_wainptdt")
ls_todt = arg_dw.getitemstring(1,"wip001_waupdtdt")

//날짜 체크
if f_dateedit(ls_fromdt) = space(8) then
	arg_dw.modify("wip001_wainptdt.background.color = 65535")
	ls_errcolumn = "wip001_wainptdt"
else
	arg_dw.modify("wip001_wainptdt.background.color = 15780518")
end if
if f_dateedit(ls_todt) = space(8) then
	arg_dw.modify("wip001_waupdtdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_waupdtdt"
	end if
else
	arg_dw.modify("wip001_waupdtdt.background.color = 15780518")
end if
if ls_fromdt > ls_todt then
	arg_dw.modify("wip001_wainptdt.background.color = 65535")
	arg_dw.modify("wip001_waupdtdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_wainptdt"
	end if
else
	arg_dw.modify("wip001_wainptdt.background.color = 15780518")
	arg_dw.modify("wip001_waupdtdt.background.color = 15780518")
end if

//품번 및 사업자번호 체크
if ls_iocd = '1' then
	if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, arg_dw) = -1 then
		arg_dw.modify("wip001_waitno.background.color = 65535")
		ls_errcolumn = "wip001_waitno"
	else
		arg_dw.modify("wip001_waitno.background.color = 15780518")
		arg_dw.setitem(1,"wip001_waitno",ls_itno)
	end if
else
	ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
	if ls_rtnvalue <> '' then
		arg_dw.modify("vndr.background.color = 15780518")
		arg_dw.setitem(1,"vndnm",mid(ls_rtnvalue,6))
		arg_dw.setitem(1,"wip001_waorct",trim(mid(ls_rtnvalue,1,5)))
	else
		arg_dw.modify("vndr.background.color = 65535")
		ls_errcolumn = "vndr"
	end if
end if

if len(ls_errcolumn) > 0 then
	arg_dw.setcolumn(ls_errcolumn)
	arg_dw.setfocus()
	uo_status.st_message.text=f_message("E010")
	return -1
else
	return 0
end if
end function

on w_wip041i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.dw_detail=create dw_detail
this.dw_report=create dw_report
this.dw_2=create dw_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.dw_detail
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.gb_1
end on

on w_wip041i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.dw_detail)
destroy(this.dw_report)
destroy(this.dw_2)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02
dw_2.settransobject(sqlca)
dw_head.settransobject(sqlca)
dw_detail.settransobject(sqlca)

dw_2.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_2.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

dw_2.insertrow(0)
dw_2.setitem(1,"wip001_waiocd",'2')

// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, true, false, false, false, false, false, false, false)


end event

event ue_retrieve;call super::ue_retrieve;string ls_itno, ls_plant, ls_dvsn, ls_iocd, ls_orct, ls_fromdt, ls_todt
dec{4} lc_convqty

dw_head.reset()
dw_detail.reset()
SetPointer(HourGlass!)

dw_2.accepttext()
//필수입력 공백, Null 체크
if f_wip_mandantory_chk( dw_2 ) = -1 then return 0 
//조건데이타 체크
if wf_find_datachk( dw_2 ) = -1 then return 0

ls_itno   = dw_2.getitemstring(1,"wip001_waitno")
ls_plant  = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn   = dw_2.getitemstring(1,"wip001_wadvsn")
ls_iocd   = dw_2.getitemstring(1,"wip001_waiocd")

select convqty into :lc_convqty
from pbinv.inv101
where comltd = '01' and xplant = :ls_plant and
		div = :ls_dvsn and itno = :ls_itno using sqlca;

if ls_iocd = '1' then
	ls_orct = '9999'
else
	ls_orct   = dw_2.getitemstring(1,"wip001_waorct")
end if

ls_fromdt = dw_2.getitemstring(1,"wip001_wainptdt")
ls_todt   = dw_2.getitemstring(1,"wip001_waupdtdt")

//날짜 변수 셋팅
i_s_year1 = mid(ls_fromdt,1,4)
i_s_month1 = mid(ls_fromdt,5,2)
i_s_yearmonth1 = i_s_year1 + i_s_month1
i_s_year2 = mid(ls_todt,1,4)
i_s_month2 = mid(ls_todt,5,2)
i_s_yearmonth2 = i_s_year2 + i_s_month2


if dw_head.retrieve(g_s_company,ls_plant,ls_dvsn,ls_itno,ls_iocd,ls_orct,i_s_yearmonth1,i_s_yearmonth2,lc_convqty) > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	return 0
end if
end event

event ue_print;call super::ue_print;integer li_rowcnt,li_cntnum
string mod_string,ls_rownum,ls_plant,ls_dvsn,ls_chdept,ls_prdept
string ls_refdate,ls_udpt,ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

li_rowcnt = dw_detail.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_detail.sharedata(dw_report)

ls_plant  = f_get_coflname('01','ACC002', trim(dw_detail.object.wdplant[1]))
ls_dvsn   = f_get_coflname('01','DAC030', trim(dw_detail.object.wddvsn[1])) 
ls_chdept = trim(dw_detail.object.wdchdpt[1])
ls_prdept = trim(dw_detail.object.wdprdpt[1])
if ls_chdept = '9999' then
	ls_chdept = '라인'
elseif mid(ls_chdept,1,1) = 'D' then
	ls_chdept = mid(f_get_vendor02(g_s_company,ls_chdept),11,30)
else
	ls_chdept = ''
end if
if mid(ls_prdept,1,1) = 'D' then
	ls_prdept = mid(f_get_vendor02(g_s_company,ls_prdept),11,30)
elseif f_spacechk(ls_prdept) = -1 then
	ls_prdept = ''
else
	ls_prdept = f_get_deptnm(ls_prdept,'5')
end if

ls_kijun = i_s_year1 + '년 ' + i_s_month1 + '월' + ' - ' + i_s_year2 + '년 ' + i_s_month2 + '월'

mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + "t_plant.text = '" + ls_plant + "'" + &
										 "t_dvsn.text   = '" + ls_dvsn + "'"  + "t_chdept.text   = '" + ls_chdept + "'" + & 
										 "t_prdept.text = '" + ls_prdept + "'" + "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "완성품별 사용실적"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip041i
end type

type dw_head from datawindow within w_wip041i
integer x = 23
integer y = 372
integer width = 4576
integer height = 1052
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_wip041i_head"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_plant, ls_dvsn, ls_itno
dec{4} lc_convqty
integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

ls_plant = dw_head.object.wip004_wdplant[row]
ls_dvsn = dw_head.object.wip004_wddvsn[row]
ls_itno = dw_head.object.wip004_wditno[row]

select convqty into :lc_convqty
from pbinv.inv101
where comltd = '01' and xplant = :ls_plant and 
		div = :ls_dvsn and itno = :ls_itno using sqlca;

dw_report.sharedataoff()
dw_detail.retrieve(g_S_company,dw_head.object.wip004_wdplant[row],&
                   dw_head.object.wip004_wddvsn[row],dw_head.object.wip004_wdiocd[row],dw_head.object.wip004_wditno[row], &
						 dw_head.object.wip004_wdprno[row],dw_head.object.wip004_wdprdpt[row],dw_head.object.wip004_wdchdpt[row], &
						 i_s_yearmonth1,i_s_yearmonth2,lc_convqty)
						
end event

type dw_detail from datawindow within w_wip041i
integer x = 18
integer y = 1448
integer width = 4576
integer height = 1024
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_wip041i_detail"
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

type dw_report from datawindow within w_wip041i
boolean visible = false
integer x = 2784
integer y = 236
integer width = 411
integer height = 432
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip041i_detail_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip041i
event ue_dwkeydown pbm_dwnkey
integer x = 69
integer y = 52
integer width = 4329
integer height = 264
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip041i_01"
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

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(1,"wip001_waplant")
	ls_dvsn = This.getitemstring(1,"wip001_wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "지역이나 공장을 먼저 선택하십시요"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(1,"wip001_waitno", mid(ls_parm,1,15))
	end if
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

if ls_colname = "wip001_waiocd" then
	if data = '2' then
		This.modify("vndr_t.visible = true")
		This.modify("vndr.visible = true")
		This.modify("vsrno_t.visible = true")
		This.modify("vndnm.visible = true")
		This.modify("b_search.visible = true")
		This.setitem(1,"wip001_waorct",'')
		This.modify("vndr.background.color = 15780518")
	else
		This.setitem(1,"wip001_waorct",'9999')
		This.modify("vndr_t.visible = false")
		This.modify("vndr.visible = false")
		This.modify("vsrno_t.visible = false")
		This.modify("vndnm.visible = false")
		This.modify("b_search.visible = false")
		This.modify("vndr.background.color = 1090519039")
	end if
end if

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "정의되지 않은 품번입니다."
		return 0
	end if
end if

end event

type gb_1 from groupbox within w_wip041i
integer x = 18
integer width = 4581
integer height = 348
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

