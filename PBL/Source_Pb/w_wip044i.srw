$PBExportHeader$w_wip044i.srw
$PBExportComments$항목별 내역 조회
forward
global type w_wip044i from w_origin_sheet04
end type
type dw_head from datawindow within w_wip044i
end type
type dw_detail from datawindow within w_wip044i
end type
type dw_report from datawindow within w_wip044i
end type
type dw_2 from datawindow within w_wip044i
end type
type gb_1 from groupbox within w_wip044i
end type
end forward

global type w_wip044i from w_origin_sheet04
string tag = "투입/사용 항목별 내역 조회"
string title = "투입/사용 항목별 내역조회"
dw_head dw_head
dw_detail dw_detail
dw_report dw_report
dw_2 dw_2
gb_1 gb_1
end type
global w_wip044i w_wip044i

type variables
string l_s_plant,l_s_div,l_s_iocd,l_s_vndr,l_s_itno,l_s_year1,l_s_month1,& 
       l_s_yearmonth1,l_s_orct,l_s_return,i_s_gubun
dec{0} lc_yyyymm
end variables

on w_wip044i.create
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

on w_wip044i.destroy
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

event ue_retrieve;long ll_rowcnt
decimal{4} l_n_wainqt,l_n_wausqt1,l_n_wausqt2,l_n_wausqt3,l_n_wausqt4,l_n_wausqt5,&
           l_n_wausqt6,l_n_wausqt7,l_n_wausqt8
decimal{0} l_n_wainat
string l_s_vender
string ls_date

dw_head.reset()
dw_detail.reset()
dw_2.accepttext()
SetPointer(HourGlass!)			  

i_s_gubun = ' '
			  
// user object 에서 필요한 값 가져오기 - start

ls_date = dw_2.getitemstring(1,"wip001_wainptdt")
//lc_yyyymm      = uo_from.uf_yyyymm()
l_s_year1      = mid(ls_date,1,4)
l_s_month1     = mid(ls_date,5,2)
l_s_yearmonth1 = l_s_year1 + l_s_month1

//l_s_return = uo_1.uf_return()
l_s_plant  = dw_2.getitemstring(1,"wip001_waplant")
l_s_div    = dw_2.getitemstring(1,"wip001_wadvsn")
l_s_iocd   = dw_2.getitemstring(1,"wip001_waiocd")

if l_s_iocd = '2' then
	//l_s_vender = f_get_vendor_1(mid(l_s_return,4,10))
	l_s_vndr   = dw_2.getitemstring(1,"wip001_waorct")
	//uo_1.sle_vndm.text   = mid(l_s_vender,6,30) 
end if
l_s_itno   = dw_2.getitemstring(1,"wip001_waitno")

// 여기까지 - end 

if l_s_iocd = '1' then
	l_s_orct = '9999'
else 
	l_s_orct = l_s_vndr
end if

if l_s_yearmonth1 = mid(g_s_date,1,6) then
	select wainqt,(wainat1 + wainat3) wainat,wausqt1,wausqt2,wausqt3,wausqt4,wausqt5,wausqt6,wausqt7,wausqt8 into
			:l_n_wainqt,:l_n_wainat,:l_n_wausqt1,:l_n_wausqt2,:l_n_wausqt3,:l_n_Wausqt4,:l_n_wausqt5,
			:l_n_wausqt6,:l_n_wausqt7,:l_n_wausqt8 from "PBWIP"."WIP001"
		where wacmcd = :g_s_company and waplant = :l_s_plant and wadvsn = :l_s_div and 
				waorct = :l_s_orct and waitno = :l_s_itno
	using sqlca ;
	
	dw_head.insertrow(0)
	dw_head.setitem(1,"wbinqt",l_n_wainqt)
	dw_head.setitem(1,"wbinat",l_n_wainat)
	dw_head.setitem(1,"wbusqt1", l_n_wausqt1)
	dw_head.setitem(1,"wbusat1", 0)
	dw_head.setitem(1,"wbusqt2", l_n_wausqt2)
	dw_head.setitem(1,"wbusat2", 0)
	dw_head.setitem(1,"wbusqt3", l_n_wausqt3)
	dw_head.setitem(1,"wbusat3", 0)
	dw_head.setitem(1,"wbusqt4", l_n_wausqt4)
	dw_head.setitem(1,"wbusat4", 0)
	dw_head.setitem(1,"wbusqt5", l_n_wausqt5)
	dw_head.setitem(1,"wbusat5", 0)
	dw_head.setitem(1,"wbusqt6", l_n_wausqt6)
	dw_head.setitem(1,"wbusat6", 0)
	dw_head.setitem(1,"wbusqt7", l_n_wausqt7)
	dw_head.setitem(1,"wbusat7", 0)
	dw_head.setitem(1,"wbusqt8", l_n_wausqt8)
	dw_head.setitem(1,"wbusat8", 0)
	dw_head.setitem(1,"wbusat9", 0)
	dw_head.setitem(1,"wbusqta", 0)
	dw_head.setitem(1,"wbusata", 0)
	uo_status.st_message.text = f_message("I010")
	
else 
	ll_rowcnt = dw_head.retrieve(g_s_company,l_s_plant,l_s_div,l_s_orct, l_s_itno, l_s_year1,l_s_month1)
	if ll_rowcnt < 1 then
		uo_status.st_message.text = "조회할 자료가 없습니다."
	else
		uo_status.st_message.text = "조회되었습니다"
	end if
end if

i_s_gubun = 'I'







end event

event ue_print;call super::ue_print;integer li_rowcnt,li_cntnum
string mod_string,ls_rownum,ls_plant,ls_dvsn,ls_itno,ls_usge
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
ls_kijun = l_s_year1 + '년 ' + l_s_month1 + '월' 
//ls_itno   = mid(f_get_itemname(l_s_itno),1,30)
if dw_report.dataobject = 'd_wip044i_detail_02_report' then
	ls_plant  = f_get_coflname('01','ACC002', trim(dw_detail.object.wip004_wdplant[1]))
	ls_dvsn   = f_get_coflname('01','DAC030', trim(dw_detail.object.wip004_wddvsn[1])) 
	ls_usge   = trim(dw_detail.object.wip004_wdusge[1])
	mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + "t_plant.text = '" + ls_plant + "'" + &
										 "t_dvsn.text   = '" + ls_dvsn + "'"  + "t_itno.text   = '" + l_s_itno + "'" + & 
										 "t_itnm.text = '"  + ls_itno + "'" + "t_usge.text   = '" + ls_usge + "'" + &
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
   l_str_prt.title = "품번별 사용실적"							
elseif dw_report.dataobject = 'd_wip044i_detail_01_report' then
	ls_plant  = f_get_coitname('01','ACC002', trim(dw_detail.object.xplant[1]))
	ls_dvsn   = f_get_coitname('01','DAC030', trim(dw_detail.object.div[1])) 
	mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + "t_plant.text = '" + ls_plant + "'" + &
										 "t_dvsn.text   = '" + ls_dvsn + "'"  + "t_itnm.text   = '" + ls_itno + "'" + & 
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
   l_str_prt.title = "품번별 투입실적"	
end if


	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip044i
end type

type dw_head from datawindow within w_wip044i
integer x = 18
integer y = 388
integer width = 4558
integer height = 420
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip041i_header"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string l_s_newsql,l_s_oldsql,l_s_usge
long   l_n_count

if i_s_gubun <> 'I' then
	return
end if

SetPointer(HourGlass!)			  
uo_status.st_message.text = ' '

if mid(dwo.name,1,9) = 'input_qty' then
	dw_detail.dataobject = 'd_wip044i_detail_01'
	dw_report.dataobject = 'd_wip044i_detail_01_report'
elseif mid(dwo.name,1,3) = 'use' then
	dw_detail.dataobject = 'd_wip044i_detail_02'
	dw_report.dataobject = 'd_wip044i_detail_02_report'
else
	return
end if

dw_detail.settransobject(sqlca)
dw_report.sharedataoff()
if mid(dwo.name,1,9) = "input_qty" then
	l_s_oldsql = dw_detail.getsqlselect()
	if l_s_orct <> '9999' then
		l_s_newsql = l_s_oldsql + " and comltd = '" + g_s_company + "'" + " and xplant = '" + l_s_plant + "'" + &
	              	 " and div = '" + l_s_div + "'" + " and itno = '" + l_s_itno + "'" + &
						 " and substring(tdte4,1,6) = '" + l_s_yearmonth1 + "'" + " and dept = '" + l_s_orct + "'"  + &
						 " order by tdte4 "
	else
		l_s_newsql = l_s_oldsql + " and comltd = '" + g_s_company + "'" + " and xplant = '" + l_s_plant + "'" + &
	             	 " and div = '" + l_s_div + "'" + " and itno = '" + l_s_itno + "'" + " and dept not like 'D%'" + &
						 " and substring(tdte4,1,6) = '" + l_s_yearmonth1 + "'" + " order by tdte4 "
	end if
	dw_detail.setsqlselect(l_s_newsql)
	l_n_count = dw_detail.retrieve()
	dw_detail.setsqlselect(l_s_oldsql)
elseif mid(dwo.name,1,3) = "use" then
	l_s_usge = '0' + mid(dwo.name,8,1)
	l_n_count = dw_detail.retrieve(g_s_company,l_s_plant,l_s_div,l_s_itno,l_s_orct,l_s_iocd,l_s_yearmonth1,l_s_usge)
end if
if l_n_count > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
end if
			  






end event

event buttonclicked;string l_s_usge, ls_itcl, ls_srce, ls_slty[]
dec{5} lc_costav
dec{4} lc_convqty
long   l_n_count

if i_s_gubun <> 'I' then
	return
end if

SetPointer(HourGlass!)			  
uo_status.st_message.text = ' '
dw_detail.reset()

ls_itcl = dw_head.getitemstring(1,"wbitcl")
ls_srce = dw_head.getitemstring(1,"wbsrce")
lc_convqty = This.getitemdecimal(1,"inv101_convqty")

if dwo.name = 'b_inqt' then
	//투입수량,투입금액 계산
	if l_s_orct = '9999' then
		choose case ls_itcl
			case '40'
				ls_slty[1] = 'IS'
				ls_slty[2] = 'IP'
				ls_slty[3] = 'RS'
				ls_slty[4] = 'IE'
				dw_detail.dataobject = 'd_wip044i_work_01'
			case '50'
				ls_slty[1] = 'RP'
				dw_detail.dataobject = 'd_wip044i_work_01'
			case else
				ls_slty[1] = 'IS'
				ls_slty[2] = 'IP'
				ls_slty[3] = 'RS'
				ls_slty[4] = 'IE'
				dw_detail.dataobject = 'd_wip044i_line_01'
		end choose
	else
		if ls_srce = '04' then
			ls_slty[1] = 'IS'
			ls_slty[2] = 'IP'
			ls_slty[3] = 'RS'
			ls_slty[4] = 'IE'
			dw_detail.dataobject = 'd_wip044i_work_02'
		else
			ls_slty[1] = 'IS'
			ls_slty[2] = 'IP'
			ls_slty[3] = 'RS'
			ls_slty[4] = 'IE'
			dw_detail.dataobject = 'd_wip044i_vndr_01'
		end if
	end if
	dw_report.dataobject = 'd_wip044i_detail_01_report'
else
	//사용용도별 계산
	l_s_usge = '0' + mid(dwo.name,7,1)
	choose case l_s_usge
		case '01','02','03','06'
			lc_costav = This.getitemdecimal(1,"wbavrg1")
			dw_detail.dataobject = 'd_wip044i_detail_02'
		case '08'
			dw_detail.dataobject = 'd_wip044i_detail_03'
		case else
			return 0
	end choose
	dw_report.dataobject = 'd_wip044i_detail_02_report'
end if

dw_detail.settransobject(sqlca)
dw_report.sharedataoff()
if dwo.name = 'b_inqt' then
	if l_s_orct <> '9999' then
		l_n_count = dw_detail.retrieve(ls_slty,g_s_company,l_s_plant,l_s_div,l_s_itno,l_s_yearmonth1,l_s_orct)
	else
		l_n_count = dw_detail.retrieve(ls_slty,g_s_company,l_s_plant,l_s_div,l_s_itno,l_s_yearmonth1)
	end if
else
	l_n_count = dw_detail.retrieve(g_s_company,l_s_plant,l_s_div,l_s_itno,l_s_orct,l_s_iocd,l_s_yearmonth1,l_s_usge,lc_costav,lc_convqty)
end if
if l_n_count > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
end if
end event

type dw_detail from datawindow within w_wip044i
integer x = 14
integer y = 824
integer width = 4576
integer height = 1652
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from datawindow within w_wip044i
boolean visible = false
integer x = 2395
integer y = 192
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip044i
event ue_dwkeydown pbm_dwnkey
integer x = 91
integer y = 56
integer width = 4315
integer height = 260
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip044i_01"
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

type gb_1 from groupbox within w_wip044i
integer x = 23
integer width = 4549
integer height = 356
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

