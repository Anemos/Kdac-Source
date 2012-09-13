$PBExportHeader$w_wip05di.srw
$PBExportComments$클레임현황조회(외개)
forward
global type w_wip05di from w_origin_sheet04
end type
type tab_1 from tab within w_wip05di
end type
type tabpage_1 from userobject within tab_1
end type
type pb_3 from picturebutton within tabpage_1
end type
type sle_vndm from singlelineedit within tabpage_1
end type
type em_vndr from editmask within tabpage_1
end type
type uo_from from uo_yymm_boongi within tabpage_1
end type
type dw_wip05di_01 from datawindow within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type pb_1 from picturebutton within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_3 pb_3
sle_vndm sle_vndm
em_vndr em_vndr
uo_from uo_from
dw_wip05di_01 dw_wip05di_01
st_3 st_3
pb_1 pb_1
st_1 st_1
end type
type tabpage_2 from userobject within tab_1
end type
type pb_2 from picturebutton within tabpage_2
end type
type uo_1 from uo_wip_plandiv within tabpage_2
end type
type em_vndr1 from editmask within tabpage_2
end type
type uo_to from uo_yymm_boongi within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type dw_wip05di_02 from datawindow within tabpage_2
end type
type pb_vndr from picturebutton within tabpage_2
end type
type st_vndr from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
pb_2 pb_2
uo_1 uo_1
em_vndr1 em_vndr1
uo_to uo_to
st_2 st_2
dw_wip05di_02 dw_wip05di_02
pb_vndr pb_vndr
st_vndr st_vndr
end type
type tab_1 from tab within w_wip05di
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_report from datawindow within w_wip05di
end type
type st_4 from statictext within w_wip05di
end type
end forward

global type w_wip05di from w_origin_sheet04
string tag = "Claim 현황 조회"
string title = "Claim 현황 조회"
event ue_filter pbm_custom31
tab_1 tab_1
dw_report dw_report
st_4 st_4
end type
global w_wip05di w_wip05di

type variables
string i_s_month1,i_s_year1,i_s_yearmonth1,i_s_month2,i_s_year2,i_s_yearmonth2
dec{0} i_d_yyyymm
string i_s_plant,i_s_dvsn,i_s_vndr1,i_s_vndr2
integer i_n_newindex

//현재 출력이나 정렬등에 사용될 datawindow
DATAWINDOW	idw_focused

end variables

event ue_filter;// Datawindow 걸러보기(filter)

STR_FILTER	lstr_filter

IF NOT IsValid( idw_focused ) THEN
	MessageBox("선택 오류","선택된 DataWindow가 없습니다")
	RETURN
END IF

lstr_filter.dw = idw_focused
lstr_filter.title = this.Title

OpenWithParm(w_dw_filter_r, lstr_filter )
end event

on w_wip05di.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_report=create dw_report
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.st_4
end on

on w_wip05di.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_report)
destroy(this.st_4)
end on

event open;call super::open;this.uo_status.st_winid.text = this.classname()
this.uo_status.st_kornm.text = g_s_kornm
this.uo_status.st_date.text = string(g_s_date, "@@@@-@@-@@")
tab_1.tabpage_1.dw_wip05di_01.settransobject(sqlca)
tab_1.tabpage_2.dw_wip05di_02.settransobject(sqlca)
i_b_retrieve = true
i_b_print    = true
wf_icon_onoff(i_b_retrieve, i_b_print,      i_b_first,   i_b_prev,   i_b_next,  & 
				  i_b_last,     i_b_dretrieve,  i_b_dprint,  i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;string l_s_vndr,l_s_vndm,l_s_vndr2, ls_fromdt, ls_todt
integer l_n_count

SetPointer(HourGlass!)
dw_Report.sharedataoff()
if i_n_newindex = 1 then
	// user object 에서 필요한 값 가져오기 - start
	i_d_yyyymm     = tab_1.tabpage_1.uo_from.uf_yyyymm()
	ls_todt        = string(i_d_yyyymm)
	ls_fromdt      = uf_wip_addmonth(ls_todt,-2)
	i_s_year1      = mid(string(i_d_yyyymm),1,4)
	i_s_month1     = mid(string(i_d_yyyymm),5,2)
	i_s_yearmonth1 = i_s_year1 + i_s_month1
	
	tab_1.tabpage_1.em_vndr.getdata(l_s_vndr)
	
	if f_spacechk(l_s_vndr) <> -1 then
		select vsrno,vndnm into:i_s_vndr1,:l_s_vndm from pbpur.pur101
			where comltd = :g_s_company and vsrno = :l_s_vndr and scgubun = 'S'
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			uo_status.st_message.text = "업체전산번호가 잘못 입력되었습니다."
			return 0
		end if
		l_s_vndr = i_s_vndr1 + '%'
		tab_1.tabpage_1.sle_vndm.text = l_s_vndm
	else
		l_s_vndr = '%'
	end if
   
	if tab_1.tabpage_1.dw_wip05di_01.retrieve(g_s_company,l_s_vndr,i_s_year1,i_s_month1) < 1 then
		uo_status.st_message.text = f_message("I020")
	else
		uo_status.st_message.text = f_message("I010")
	end if
elseif i_n_newindex = 2 then
	// user object 에서 필요한 값 가져오기 - start
	i_d_yyyymm     = tab_1.tabpage_2.uo_to.uf_yyyymm()
	ls_todt        = string(i_d_yyyymm)
	ls_fromdt      = uf_wip_addmonth(ls_todt,-2)
	i_s_year2      = mid(string(i_d_yyyymm),1,4)
	i_s_month2     = mid(string(i_d_yyyymm),5,2)
	i_s_yearmonth2 = i_s_year2 + i_s_month2
	i_s_plant = trim(tab_1.tabpage_2.uo_1.dw_1.getitemstring(1,'xplant'))
	if f_spacechk(i_s_plant) = -1 then
		i_s_plant = '%'
	else
		i_s_plant = i_s_plant + '%'
	end if
	i_s_dvsn  = trim(tab_1.tabpage_2.uo_1.dw_1.getitemstring(1,'div'))
	if f_spacechk(i_s_dvsn) = -1 then
		i_s_dvsn = '%'
	else
		i_s_dvsn = i_s_dvsn + '%'
	end if
	tab_1.tabpage_2.em_vndr1.getdata(l_s_vndr)
	if f_spacechk(l_s_vndr) <> -1 then
		select vsrno into:i_s_vndr2 from pbpur.pur101
			where comltd = :g_s_company and vsrno = :l_s_vndr and scgubun = 'S'
			using sqlca;
		if sqlca.sqlcode <> 0 then
			uo_status.st_message.text = "업체전산번호가 잘못 입력되었습니다."
			return 0
		end if
	else
		i_s_vndr2 = ''
	end if
	if f_spacechk(i_s_vndr2) = -1 then
		l_s_vndr2 = '%'
	else
		l_s_vndr2 = trim(i_s_vndr2) + '%'
	end if
	if tab_1.tabpage_2.dw_wip05di_02.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_vndr2,i_s_year2,i_s_month2) < 1 then
		uo_status.st_message.text = f_message("I020")
	else
		uo_status.st_message.text = f_message("I010")
	end if
end if

return 0
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_plant,ls_dvsn,ls_vndr,ls_vndm
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

if i_n_newindex = 1 then
	li_rowcnt = tab_1.tabpage_1.dw_wip05di_01.rowcount()
	dw_report.dataobject = 'd_wip05di_report01'
elseif i_n_newindex = 2 then
	li_rowcnt = tab_1.tabpage_2.dw_wip05di_02.rowcount()
	dw_report.dataobject = 'd_wip05di_report02'
end if

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if


if i_n_newindex = 1 then
	tab_1.tabpage_1.dw_wip05di_01.sharedata(dw_report)
	ls_kijun = i_s_year1 + '년 ' + i_s_month1 + '월' 
	mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + &
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
  l_str_prt.title = "업체별 CLAIM 현황"		
elseif i_n_newindex = 2 then
	tab_1.tabpage_2.dw_wip05di_02.sharedata(dw_report)
	ls_kijun = i_s_year2 + '년 ' + i_s_month2 + '월' 
	mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + & 
										 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
	l_str_prt.title = "공장별 CLAIM 현황"	
end if

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip05di
end type

type tab_1 from tab within w_wip05di
integer x = 18
integer y = 20
integer width = 4581
integer height = 2452
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;i_n_newindex = newindex
if newindex = 1 then
	idw_focused = tab_1.tabpage_1.dw_wip05di_01
else
	idw_focused = tab_1.tabpage_2.dw_wip05di_02
end if
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4544
integer height = 2336
long backcolor = 12632256
string text = "업체별 Claim 현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_3 pb_3
sle_vndm sle_vndm
em_vndr em_vndr
uo_from uo_from
dw_wip05di_01 dw_wip05di_01
st_3 st_3
pb_1 pb_1
st_1 st_1
end type

on tabpage_1.create
this.pb_3=create pb_3
this.sle_vndm=create sle_vndm
this.em_vndr=create em_vndr
this.uo_from=create uo_from
this.dw_wip05di_01=create dw_wip05di_01
this.st_3=create st_3
this.pb_1=create pb_1
this.st_1=create st_1
this.Control[]={this.pb_3,&
this.sle_vndm,&
this.em_vndr,&
this.uo_from,&
this.dw_wip05di_01,&
this.st_3,&
this.pb_1,&
this.st_1}
end on

on tabpage_1.destroy
destroy(this.pb_3)
destroy(this.sle_vndm)
destroy(this.em_vndr)
destroy(this.uo_from)
destroy(this.dw_wip05di_01)
destroy(this.st_3)
destroy(this.pb_1)
destroy(this.st_1)
end on

type pb_3 from picturebutton within tabpage_1
integer x = 3689
integer y = 16
integer width = 155
integer height = 132
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.tabpage_1.dw_wip05di_01.rowcount() < 1 then
	uo_status.st_message.text = "저장할 자료가 없습니다."
else
	f_save_to_excel(tab_1.tabpage_1.dw_wip05di_01)
end if
end event

type sle_vndm from singlelineedit within tabpage_1
integer x = 2080
integer y = 36
integer width = 1399
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type em_vndr from editmask within tabpage_1
event ue_keydown pbm_keydown
integer x = 1339
integer y = 36
integer width = 416
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!"
end type

event ue_keydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

type uo_from from uo_yymm_boongi within tabpage_1
event ue_keydown pbm_keydown
integer x = 320
integer y = 36
integer taborder = 10
end type

event ue_keydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

on uo_from.destroy
call uo_yymm_boongi::destroy
end on

type dw_wip05di_01 from datawindow within tabpage_1
integer x = 5
integer y = 156
integer width = 4530
integer height = 2168
string dataobject = "d_wip05di_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_1
integer x = 23
integer y = 52
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "기준년월"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within tabpage_1
integer x = 1797
integer y = 28
integer width = 238
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

openwithparm(w_find_001 , ' O')
l_s_parm = message.stringparm
if f_spacechk(l_s_parm) <> -1 then
	tab_1.tabpage_1.sle_vndm.text = mid(l_s_parm,16)
	tab_1.tabpage_1.em_vndr.text  = mid(l_s_parm,1,5)
end if
end event

type st_1 from statictext within tabpage_1
integer x = 942
integer y = 52
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "업체전산번호"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4544
integer height = 2336
long backcolor = 12632256
string text = "공장별 Claim 현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_2 pb_2
uo_1 uo_1
em_vndr1 em_vndr1
uo_to uo_to
st_2 st_2
dw_wip05di_02 dw_wip05di_02
pb_vndr pb_vndr
st_vndr st_vndr
end type

on tabpage_2.create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.em_vndr1=create em_vndr1
this.uo_to=create uo_to
this.st_2=create st_2
this.dw_wip05di_02=create dw_wip05di_02
this.pb_vndr=create pb_vndr
this.st_vndr=create st_vndr
this.Control[]={this.pb_2,&
this.uo_1,&
this.em_vndr1,&
this.uo_to,&
this.st_2,&
this.dw_wip05di_02,&
this.pb_vndr,&
this.st_vndr}
end on

on tabpage_2.destroy
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.em_vndr1)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.dw_wip05di_02)
destroy(this.pb_vndr)
destroy(this.st_vndr)
end on

type pb_2 from picturebutton within tabpage_2
integer x = 3534
integer y = 24
integer width = 155
integer height = 132
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.tabpage_2.dw_wip05di_02.rowcount() < 1 then
	uo_status.st_message.text = "저장할 자료가 없습니다."
else
	f_save_to_excel(tab_1.tabpage_2.dw_wip05di_02)
end if
end event

type uo_1 from uo_wip_plandiv within tabpage_2
integer x = 50
integer y = 32
integer taborder = 30
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type em_vndr1 from editmask within tabpage_2
event ue_keydown pbm_keydown
integer x = 2656
integer y = 44
integer width = 471
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!"
end type

event ue_keydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

type uo_to from uo_yymm_boongi within tabpage_2
event ue_keydown pbm_keydown
integer x = 1669
integer y = 44
integer taborder = 20
end type

event ue_keydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

on uo_to.destroy
call uo_yymm_boongi::destroy
end on

type st_2 from statictext within tabpage_2
integer x = 1381
integer y = 60
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월"
boolean focusrectangle = false
end type

type dw_wip05di_02 from datawindow within tabpage_2
integer x = 18
integer y = 164
integer width = 4512
integer height = 2152
string title = "none"
string dataobject = "d_wip05di_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_vndr from picturebutton within tabpage_2
integer x = 3159
integer y = 36
integer width = 238
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

openwithparm(w_find_001 , ' O')
l_s_parm = message.stringparm
if f_spacechk(l_s_parm) <> -1 then
	tab_1.tabpage_2.em_vndr1.text  = mid(l_s_parm,1,5)
end if
end event

type st_vndr from statictext within tabpage_2
integer x = 2254
integer y = 56
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "업체전산번호"
boolean focusrectangle = false
end type

type dw_report from datawindow within w_wip05di
boolean visible = false
integer x = 1435
integer y = 1944
integer width = 411
integer height = 432
integer taborder = 40
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_wip05di
integer x = 1605
integer y = 28
integer width = 1856
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 32768
long backcolor = 12639424
string text = "10만원이상 클레임금액 보기 : 필터 아이콘 이용"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

