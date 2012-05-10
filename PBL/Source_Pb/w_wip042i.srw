$PBExportHeader$w_wip042i.srw
$PBExportComments$사용품목 수정 내역조회
forward
global type w_wip042i from w_origin_sheet04
end type
type dw_head from datawindow within w_wip042i
end type
type dw_detail from datawindow within w_wip042i
end type
type dw_report from datawindow within w_wip042i
end type
type dw_2 from datawindow within w_wip042i
end type
type pb_1 from picturebutton within w_wip042i
end type
type gb_1 from groupbox within w_wip042i
end type
end forward

global type w_wip042i from w_origin_sheet04
string tag = "사용품목수정내역조회"
string title = "사용품목수정내역조회"
dw_head dw_head
dw_detail dw_detail
dw_report dw_report
dw_2 dw_2
pb_1 pb_1
gb_1 gb_1
end type
global w_wip042i w_wip042i

type variables
string i_s_year1,i_s_month1,i_s_yearmonth1
string i_s_year2,i_s_month2,i_s_yearmonth2

end variables

on w_wip042i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.dw_detail=create dw_detail
this.dw_report=create dw_report
this.dw_2=create dw_2
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.dw_detail
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_wip042i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.dw_detail)
destroy(this.dw_report)
destroy(this.dw_2)
destroy(this.pb_1)
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

event key;call super::key;window l_s_wsheet

if key = keyenter! then
  	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if

return 0
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant,ls_dvsn,ls_iocd,ls_vndr,ls_orct
string ls_fromdt, ls_todt

dw_head.reset()
dw_detail.reset()
dw_2.accepttext()
SetPointer(HourGlass!)

ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_2.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_2.getitemstring(1,"wip001_waiocd")
ls_orct = dw_2.getitemstring(1,"wip001_waorct")
ls_vndr = dw_2.getitemstring(1,"vndr")
ls_fromdt = dw_2.getitemstring(1,"wip001_wainptdt")
ls_todt = dw_2.getitemstring(1,"wip001_waupdtdt")

i_s_year1 = mid(ls_fromdt,1,4)
i_s_month1 = mid(ls_fromdt,5,2)
i_s_yearmonth1 = i_s_year1 + i_s_month1

i_s_year2 = mid(ls_todt,1,4)
i_s_month2 = mid(ls_todt,5,2)
i_s_yearmonth2 = i_s_year2 + i_s_month2

if ls_iocd = '2' then
	if f_spacechk(ls_vndr) = -1 then
		ls_orct = '%'
	else
		ls_orct = f_get_vendor01('01',ls_vndr)
		if f_spacechk(ls_vndr) = -1 then
			uo_status.st_message.text = "사업자번호가 잘못 입력되었습니다."
			return 0
		else
			dw_2.setitem(1,"vndnm",mid(ls_orct,6))
			ls_orct = mid(ls_orct,1,5) + '%'
		end if
	end if
else
	ls_orct = '9999%'
end if

if dw_head.retrieve(g_s_company,ls_plant,ls_dvsn,ls_iocd,ls_orct,ls_fromdt,ls_todt,mid(ls_todt,1,6)) > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	return 0
end if
end event

event ue_print;call super::ue_print;integer li_rowcnt,li_cntnum
string mod_string,ls_rownum,ls_plant,ls_dvsn,ls_chdept
string ls_refdate,ls_udpt,ls_kijun,ls_itnm

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

ls_plant  = f_get_coflname('01','ACC002', trim(dw_detail.object.wip004_wdplant[1]))
ls_dvsn   = f_get_coflname('01','DAC030', trim(dw_detail.object.wip004_wddvsn[1])) 
ls_chdept = trim(dw_detail.object.wdchdpt[1])
//ls_itnm   = mid(f_get_itemname(trim(dw_detail.object.wip004_wditno[1])),1,30)
if ls_chdept = '9999' then
	ls_chdept = '라인'
elseif mid(ls_chdept,1,1) = 'D' then
	ls_chdept = mid(f_get_vendor02(g_s_company,ls_chdept),11,30)
else
	ls_chdept = ''
end if

ls_kijun = i_s_year1 + '년 ' + i_s_month1 + '월' + ' - ' + i_s_year2 + '년 ' + i_s_month2 + '월'

mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + "t_plant.text = '" + ls_plant + "'" + &
										 "t_dvsn.text   = '" + ls_dvsn + "'"  + "t_chdept.text   = '" + ls_chdept + "'" + & 
										 "t_itnm.text   = '" + ls_itnm + "'" + "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "사용품목 수정내역"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip042i
end type

type dw_head from datawindow within w_wip042i
integer x = 23
integer y = 360
integer width = 4581
integer height = 980
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_wip042i_head"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long ll_rowcnt
string ls_plant, ls_dvsn, ls_itno
dec{4} lc_convqty

ll_rowcnt = this.rowcount()
if row > 0 and row <= ll_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
else
	return 0
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
						 dw_head.object.wip004_wdprdpt[row],i_s_yearmonth1,i_s_yearmonth2,lc_convqty)
end event

type dw_detail from datawindow within w_wip042i
integer x = 14
integer y = 1356
integer width = 4585
integer height = 1112
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip042i_detail"
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

type dw_report from datawindow within w_wip042i
boolean visible = false
integer x = 2592
integer y = 804
integer width = 411
integer height = 432
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip042i_detail_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip042i
event ue_dwkeydown pbm_dwnkey
integer x = 64
integer y = 48
integer width = 4325
integer height = 256
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip042i_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
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

type pb_1 from picturebutton within w_wip042i
integer x = 1856
integer y = 176
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_head)
end event

type gb_1 from groupbox within w_wip042i
integer x = 23
integer width = 4576
integer height = 328
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

