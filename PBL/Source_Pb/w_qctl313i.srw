$PBExportHeader$w_qctl313i.srw
$PBExportComments$월별라인불량현황
forward
global type w_qctl313i from w_origin_sheet05
end type
type dw_1 from datawindow within w_qctl313i
end type
type st_1 from statictext within w_qctl313i
end type
type em_1 from editmask within w_qctl313i
end type
type dw_2 from datawindow within w_qctl313i
end type
type dw_3 from datawindow within w_qctl313i
end type
type rb_customer from radiobutton within w_qctl313i
end type
type rb_dvsn from radiobutton within w_qctl313i
end type
type st_magnify from statictext within w_qctl313i
end type
type st_2 from statictext within w_qctl313i
end type
type st_3 from statictext within w_qctl313i
end type
type st_head_prt from statictext within w_qctl313i
end type
type st_detail_prt from statictext within w_qctl313i
end type
type dw_report from datawindow within w_qctl313i
end type
type gb_1 from groupbox within w_qctl313i
end type
end forward

global type w_qctl313i from w_origin_sheet05
dw_1 dw_1
st_1 st_1
em_1 em_1
dw_2 dw_2
dw_3 dw_3
rb_customer rb_customer
rb_dvsn rb_dvsn
st_magnify st_magnify
st_2 st_2
st_3 st_3
st_head_prt st_head_prt
st_detail_prt st_detail_prt
dw_report dw_report
gb_1 gb_1
end type
global w_qctl313i w_qctl313i

type variables
datawindowchild dw_child
string i_s_sql, i_s_clicknm
end variables

on w_qctl313i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.em_1=create em_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.rb_customer=create rb_customer
this.rb_dvsn=create rb_dvsn
this.st_magnify=create st_magnify
this.st_2=create st_2
this.st_3=create st_3
this.st_head_prt=create st_head_prt
this.st_detail_prt=create st_detail_prt
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.rb_customer
this.Control[iCurrent+7]=this.rb_dvsn
this.Control[iCurrent+8]=this.st_magnify
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_head_prt
this.Control[iCurrent+12]=this.st_detail_prt
this.Control[iCurrent+13]=this.dw_report
this.Control[iCurrent+14]=this.gb_1
end on

on w_qctl313i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.rb_customer)
destroy(this.rb_dvsn)
destroy(this.st_magnify)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_head_prt)
destroy(this.st_detail_prt)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event open;call super::open;connect using sqlcs;

em_1.text = string(today(),"yyyy/mm")
rb_customer.checked = true
rb_customer.triggerevent(clicked!)

end event

event ue_retrieve;call super::ue_retrieve;date l_d_sdt
string ls_todt, ls_fromdt, ls_tempdt

em_1.getdata(l_d_sdt)
ls_tempdt = uf_add_month(string(l_d_sdt,"yyyymm"), 1) + '01'
ls_todt = f_relativedate(ls_tempdt,-1)
ls_tempdt = uf_add_month(string(l_d_sdt,"yyyymm"), -12)
ls_fromdt = ls_tempdt + '01'

dw_1.retrieve(string(l_d_sdt,"yyyymm"))
dw_3.retrieve(ls_fromdt, ls_todt)
end event

type uo_status from w_origin_sheet05`uo_status within w_qctl313i
end type

type dw_1 from datawindow within w_qctl313i
integer x = 37
integer y = 280
integer width = 1705
integer height = 1132
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl313i_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string l_s_cust_cd, l_s_status, l_s_sql, ls_dvsn, ls_name
date   l_d_month
integer li_rowcnt

if row < 1 then
	return 0
end if

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

em_1.getdata(l_d_month)
if rb_customer.checked = true then
	l_s_cust_cd = this.object.cust_cd[row]
	l_s_sql = i_s_sql + " where process_dt like '" + string(l_d_month,"yyyymm") &
			+ "%' and cust_cd = '" + l_s_cust_cd + "'"
else
	ls_dvsn = This.object.dvsn[row]
	l_s_sql = i_s_sql + " where process_dt like '" + string(l_d_month,"yyyymm") &
			+ "%' and dvsn = '" + ls_dvsn + "'"
end if

if rb_customer.checked = true then
	ls_name = dw_1.Describe( "Evaluate('LookUpDisplay(cust_cd) ', " + string(row) + ")")
else
	ls_name = dw_1.Describe( "Evaluate('LookUpDisplay(dvsn) ', " + string(row) + ")")
end if

choose case dwo.name
	case 'open_cnt'
		i_s_clicknm = ls_name +' : ' +'Opened' 
		l_s_sql = l_s_sql + "and cur_status ='A06001'"
	case 'res_cnt'
		i_s_clicknm = ls_name +' : ' +'Resolved'
		l_s_sql = l_s_sql + "and cur_status ='A06002'"
	case 'close_cnt'
		i_s_clicknm = ls_name +' : ' +'Closed'
		l_s_sql = l_s_sql + "and cur_status ='A06003'"
	case 'tot_cnt'
		i_s_clicknm = ls_name + ' : ' + 'Total'
end choose

dw_2.settransobject(sqlcs)
dw_2.setsqlselect(l_s_sql)
dw_2.retrieve()   	
end event

type st_1 from statictext within w_qctl313i
integer x = 91
integer y = 68
integer width = 311
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "기준년월"
boolean focusrectangle = false
end type

type em_1 from editmask within w_qctl313i
integer x = 407
integer y = 56
integer width = 334
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm"
end type

type dw_2 from datawindow within w_qctl313i
integer x = 37
integer y = 1508
integer width = 4562
integer height = 948
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl313i_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_qctl313i
integer x = 1769
integer y = 196
integer width = 2830
integer height = 1292
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl313i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_customer from radiobutton within w_qctl313i
integer x = 859
integer y = 76
integer width = 402
integer height = 56
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "거래처별"
end type

event clicked;dw_1.dataobject = 'd_qctl313i_01'
dw_1.settransobject(sqlcs)
dw_2.dataobject = 'd_qctl313i_02'
dw_2.settransobject(sqlcs)
dw_3.dataobject = 'd_qctl313i_03'
dw_3.settransobject(sqlcs)
i_s_sql = dw_2.getsqlselect()
dw_1.GetChild('cust_cd', dw_child)
dw_child.settransobject(sqlcs)
dw_child.retrieve("A05")

parent.triggerevent('ue_retrieve')
end event

type rb_dvsn from radiobutton within w_qctl313i
integer x = 1317
integer y = 76
integer width = 357
integer height = 56
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공장별"
end type

event clicked;
dw_1.dataobject = 'd_qctl313i_04'
dw_1.settransobject(sqlcs)
dw_2.dataobject = 'd_qctl313i_06'
dw_2.settransobject(sqlcs)
dw_3.dataobject = 'd_qctl313i_05'
dw_3.settransobject(sqlcs)
i_s_sql = dw_2.getsqlselect()

parent.triggerevent('ue_retrieve')
end event

type st_magnify from statictext within w_qctl313i
integer x = 1783
integer y = 76
integer width = 512
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "그래프확대"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;string ls_gubun   // 'A' : 거래처별, 'B' : 공장별
string ls_yyyymm
date ld_adjdate

em_1.getdata(ld_adjdate)
ls_yyyymm = string(ld_adjdate,"yyyymm")
if rb_customer.checked = true then
	ls_gubun = 'A'
else
	ls_gubun = 'B'
end if

openwithparm(w_graph_magnify , ls_gubun + ls_yyyymm )

return 0
end event

type st_2 from statictext within w_qctl313i
integer x = 37
integer y = 200
integer width = 695
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "Header 정보내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_qctl313i
integer x = 37
integer y = 1428
integer width = 695
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "Detail 정보내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_head_prt from statictext within w_qctl313i
integer x = 773
integer y = 192
integer width = 338
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "출력"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;string mod_string
string ls_gubun, ls_kijun, ls_name
integer li_currow, li_rtn
date l_d_sdt

window 	l_to_open
str_easy l_str_prt
							
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

if dw_1.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_report.dataobject = 'd_qctl313i_01_rpt'
dw_report.settransobject(sqlcs)

for li_rtn = 1 to dw_1.rowcount()
	li_currow = dw_report.insertrow(0)
	if rb_customer.checked = true then
		ls_name = dw_1.Describe( "Evaluate('LookUpDisplay(cust_cd) ', " + string(li_rtn) + ")")
	else
		ls_name = dw_1.Describe( "Evaluate('LookUpDisplay(dvsn) ', " + string(li_rtn) + ")")
	end if
	dw_report.setitem(li_currow, 1, ls_name)
	dw_report.setitem(li_currow, 2, dw_1.getitemnumber(li_rtn,2))
	dw_report.setitem(li_currow, 3, dw_1.getitemnumber(li_rtn,3))
	dw_report.setitem(li_currow, 4, dw_1.getitemnumber(li_rtn,4))
	dw_report.setitem(li_currow, 5, dw_1.getitemnumber(li_rtn,5))
next

if rb_customer.checked = true then
	ls_gubun = '거래처'
else
	ls_gubun = '공장'
end if

ls_kijun = em_1.text
mod_string =  "t_kijun.text = '" + ls_kijun + "'" + "t_gubun.text = '" + ls_gubun + "'" &
					+ "t_title.text = '" + ls_gubun + "'"
	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlcs
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "월별 불량현황 출력"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type st_detail_prt from statictext within w_qctl313i
integer x = 773
integer y = 1420
integer width = 338
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "출력"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;string mod_string
string ls_gubun, ls_kijun

window 	l_to_open
str_easy l_str_prt
							
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

if dw_1.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

dw_report.dataobject = 'd_qctl313i_02_rpt'
dw_report.settransobject(sqlcs)

dw_2.sharedata(dw_report)

ls_kijun = em_1.text
mod_string =  "t_kijun.text = '" + ls_kijun + "'" + "t_gubun.text = '" + i_s_clicknm + "'"
	
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlcs
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "월별 불량현황 출력"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type dw_report from datawindow within w_qctl313i
boolean visible = false
integer x = 2761
integer y = 36
integer width = 686
integer height = 140
integer taborder = 20
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_qctl313i
integer x = 37
integer y = 16
integer width = 1714
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

