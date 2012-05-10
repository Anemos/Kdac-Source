$PBExportHeader$w_wip043i.srw
$PBExportComments$모델별 사용품목 조회
forward
global type w_wip043i from w_origin_sheet04
end type
type dw_head from datawindow within w_wip043i
end type
type dw_detail from datawindow within w_wip043i
end type
type dw_report from datawindow within w_wip043i
end type
type dw_2 from datawindow within w_wip043i
end type
type gb_1 from groupbox within w_wip043i
end type
end forward

global type w_wip043i from w_origin_sheet04
string tag = "모델별 사용항목 조회"
string title = "모델별 사용품목 조회"
dw_head dw_head
dw_detail dw_detail
dw_report dw_report
dw_2 dw_2
gb_1 gb_1
end type
global w_wip043i w_wip043i

type variables
string i_s_year1,i_s_month1,i_s_yearmonth1
string i_s_year2,i_s_month2,i_s_yearmonth2

end variables

on w_wip043i.create
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

on w_wip043i.destroy
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

event ue_retrieve;call super::ue_retrieve;string ls_plant,ls_dvsn, ls_itno, ls_fromdt, ls_todt

dw_head.reset()
dw_detail.reset()
dw_2.accepttext()
SetPointer(HourGlass!)

ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_2.getitemstring(1,"wip001_wadvsn")
ls_itno = dw_2.getitemstring(1,"wip001_waitno")
ls_fromdt = dw_2.getitemstring(1,"wip001_wainptdt")
ls_todt = dw_2.getitemstring(1,"wip001_waupdtdt")

i_s_year1 = mid(ls_fromdt,1,4)
i_s_month1 = mid(ls_fromdt,5,2)
i_s_yearmonth1 = i_s_year1 + i_s_month1

i_s_year2 = mid(ls_todt,1,4)
i_s_month2 = mid(ls_todt,5,2)
i_s_yearmonth2 = i_s_year2 + i_s_month2

if dw_head.retrieve(g_s_company,ls_plant,ls_dvsn,ls_fromdt,ls_todt,ls_itno) > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	return 0
end if
end event

event ue_print;call super::ue_print;integer li_rowcnt,li_cntnum
string mod_string,ls_rownum,ls_plant,ls_dvsn,ls_itno,ls_prno
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
//ls_itno   = mid(f_get_itemname(trim(dw_detail.object.wditno[1])),1,30)
//ls_prno   = mid(f_get_itemname(trim(dw_detail.object.wdprno[1])),1,30)

ls_kijun = i_s_year1 + '년 ' + i_s_month1 + '월' + ' - ' + i_s_year2 + '년 ' + i_s_month2 + '월'

mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + "t_plant.text = '" + ls_plant + "'" + &
										 "t_dvsn.text   = '" + ls_dvsn + "'"  + "t_itnm1.text   = '" + ls_itno + "'" + & 
										 "t_itnm2.text = '"  + ls_prno + "'" + "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "사용품별 사용실적"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip043i
end type

type dw_head from datawindow within w_wip043i
integer x = 23
integer y = 392
integer width = 4581
integer height = 916
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_wip043i_head"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt
dec{4} lc_convqty
string  ls_plant,ls_dvsn, ls_pitno, ls_citno, ls_usge, ls_iocd
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
dw_report.sharedataoff()
ls_plant = trim(This.getitemstring(row,"wip004_wdplant"))
ls_dvsn  = trim(This.getitemstring(row,"wip004_wddvsn"))
ls_pitno = This.getitemstring(row,"wip004_wdprno")
ls_citno = This.getitemstring(row,"wip004_wditno")
ls_usge = This.getitemstring(row,"wip004_wdusge")
ls_iocd = This.getitemstring(row,"wip004_wdiocd")

select convqty into :lc_convqty
from pbinv.inv101
where comltd = '01' and xplant = :ls_plant and
		div = :ls_dvsn and itno = :ls_citno using sqlca;

dw_detail.retrieve(g_s_company,ls_plant,ls_dvsn,ls_pitno,ls_citno,ls_iocd,ls_usge,i_s_yearmonth1,i_s_yearmonth2,lc_convqty)
end event

type dw_detail from datawindow within w_wip043i
integer x = 23
integer y = 1336
integer width = 4571
integer height = 1140
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_wip043i_detail"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from datawindow within w_wip043i
boolean visible = false
integer x = 2546
integer y = 76
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip043i_detail_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip043i
event ue_dwkeydown pbm_dwnkey
integer x = 87
integer y = 60
integer width = 3817
integer height = 256
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip043i_01"
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

event buttonclicked;string ls_parm

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

type gb_1 from groupbox within w_wip043i
integer x = 23
integer width = 4576
integer height = 352
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

