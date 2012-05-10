$PBExportHeader$w_pisz070i.srw
$PBExportComments$생산관련지표정보 조회
forward
global type w_pisz070i from w_ipis_sheet01
end type
type tab_1 from tab within w_pisz070i
end type
type tabpage_month from userobject within tab_1
end type
type dw_tabpage_1 from datawindow within tabpage_month
end type
type tabpage_month from userobject within tab_1
dw_tabpage_1 dw_tabpage_1
end type
type tabpage_year from userobject within tab_1
end type
type dw_tabpage_2 from datawindow within tabpage_year
end type
type tabpage_year from userobject within tab_1
dw_tabpage_2 dw_tabpage_2
end type
type tabpage_create from userobject within tab_1
end type
type cb_create from commandbutton within tabpage_create
end type
type dw_tabpage_3 from datawindow within tabpage_create
end type
type tabpage_create from userobject within tab_1
cb_create cb_create
dw_tabpage_3 dw_tabpage_3
end type
type tab_1 from tab within w_pisz070i
tabpage_month tabpage_month
tabpage_year tabpage_year
tabpage_create tabpage_create
end type
type uo_area from u_pisc_select_area within w_pisz070i
end type
type uo_division from u_pisc_select_division within w_pisz070i
end type
type uo_applymonth from u_pisc_date_scroll_month within w_pisz070i
end type
type uo_applyyear from u_pisc_date_scroll_year within w_pisz070i
end type
type pb_excel from picturebutton within w_pisz070i
end type
type gb_1 from groupbox within w_pisz070i
end type
end forward

global type w_pisz070i from w_ipis_sheet01
integer width = 4663
integer height = 2768
string title = "월일별출하현황"
tab_1 tab_1
uo_area uo_area
uo_division uo_division
uo_applymonth uo_applymonth
uo_applyyear uo_applyyear
pb_excel pb_excel
gb_1 gb_1
end type
global w_pisz070i w_pisz070i

type variables
boolean 	ib_open
string		is_areacode,is_divisioncode,is_applymonth,is_applyyear	
transaction	sqlele
end variables

on w_pisz070i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_applymonth=create uo_applymonth
this.uo_applyyear=create uo_applyyear
this.pb_excel=create pb_excel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_applymonth
this.Control[iCurrent+5]=this.uo_applyyear
this.Control[iCurrent+6]=this.pb_excel
this.Control[iCurrent+7]=this.gb_1
end on

on w_pisz070i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_applymonth)
destroy(this.uo_applyyear)
destroy(this.pb_excel)
destroy(this.gb_1)
end on

event key;call super::key;if key = keyenter!	then
	this.TriggerEvent("ue_retrieve")
end if
end event

event open;call super::open;sqlele	=	create	transaction 
if	f_connection_sqlserver_any('D','A',sqlele)	=	false	then
	messagebox("확인","생산지표 정보 서버 연결 오류 발생. 시스템 개발팀으로 연락바랍니다")
end if
tab_1.tabpage_month.dw_tabpage_1.settransobject(sqlele) ;
tab_1.tabpage_year.dw_tabpage_2.settransobject(sqlele) ;
tab_1.tabpage_create.dw_tabpage_3.settransobject(sqlele) ;
if	g_s_empno	=	'960165'	then
	tab_1.tabpage_create.cb_create.enabled	=	true
end if


end event

event closequery;call super::closequery;disconnect using sqlele ;
destroy sqlele ;
end event

event ue_retrieve;call super::ue_retrieve;integer	ln_rowcount

setpointer(hourglass!)
pb_excel.visible		=	false
pb_excel.enabled	=	false
if	tab_1.selectedtab	=	1	then
	ln_rowcount	=	tab_1.tabpage_month.dw_tabpage_1.retrieve(is_areacode,is_divisioncode,is_applymonth)	
elseif 	tab_1.selectedtab	=	2	then
	ln_rowcount	=	tab_1.tabpage_year.dw_tabpage_2.retrieve(is_areacode,is_divisioncode,is_applyyear)
elseif 	tab_1.selectedtab	=	3	then
//	if	is_Areacode	=	'%'		or	is_divisioncode	=	'%'		then
//		messagebox("확인","월별 기준정보는 지역과 공장을 반드시 선택하셔야 합니다")
//		return
//	end if
//	string	ls_fromdate,ls_todate
//	ls_fromdate	=	is_applymonth	+	'.01'
//	ls_todate		=	is_applymonth	+	'.31'
	ln_rowcount	=	tab_1.tabpage_create.dw_tabpage_3.retrieve(is_areacode,is_divisioncode,is_applymonth)
end if
if	ln_rowcount	>	0	then
	pb_excel.visible		=	true
	pb_excel.enabled	=	true
else
	messagebox("확인","조회할 정보가 없습니다.")
end if
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisz070i
integer x = 0
integer y = 2580
integer width = 4608
end type

type tab_1 from tab within w_pisz070i
event create ( )
event destroy ( )
integer y = 188
integer width = 4608
integer height = 2328
integer taborder = 50
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
tabpage_month tabpage_month
tabpage_year tabpage_year
tabpage_create tabpage_create
end type

on tab_1.create
this.tabpage_month=create tabpage_month
this.tabpage_year=create tabpage_year
this.tabpage_create=create tabpage_create
this.Control[]={this.tabpage_month,&
this.tabpage_year,&
this.tabpage_create}
end on

on tab_1.destroy
destroy(this.tabpage_month)
destroy(this.tabpage_year)
destroy(this.tabpage_create)
end on

event selectionchanged;if newindex = 1 then
	tab_1.tabpage_month.tabtextcolor 	= rgb(255,0,0)
	tab_1.tabpage_year.tabtextcolor 		= rgb(0,0,0)
	tab_1.tabpage_create.tabtextcolor 	= rgb(0,0,0)
	uo_applymonth.visible					= true
	uo_applymonth.enabled				= true	
	uo_applyyear.visible					= false
	uo_applyyear.enabled					= false	
elseif newindex = 2 then
	tab_1.tabpage_month.tabtextcolor 	= rgb(0,0,0)
	tab_1.tabpage_year.tabtextcolor 		= rgb(255,0,0)
	tab_1.tabpage_create.tabtextcolor 	= rgb(0,0,0)
	uo_applymonth.visible					= false
	uo_applymonth.enabled				= false	
	uo_applyyear.visible					= true
	uo_applyyear.enabled					= true	
elseif newindex = 3 then
	tab_1.tabpage_month.tabtextcolor 	= rgb(0,0,0)
	tab_1.tabpage_year.tabtextcolor 		= rgb(0,0,0)
	tab_1.tabpage_create.tabtextcolor 	= rgb(255,0,0)	
	uo_applymonth.visible					= true
	uo_applymonth.enabled				= true	
	uo_applyyear.visible					= false
	uo_applyyear.enabled					= false	
end if

end event

type tabpage_month from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4571
integer height = 2212
long backcolor = 12632256
string text = "월별 조회(12개월)"
long tabtextcolor = 255
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage_1 dw_tabpage_1
end type

on tabpage_month.create
this.dw_tabpage_1=create dw_tabpage_1
this.Control[]={this.dw_tabpage_1}
end on

on tabpage_month.destroy
destroy(this.dw_tabpage_1)
end on

type dw_tabpage_1 from datawindow within tabpage_month
integer x = 14
integer y = 20
integer width = 4544
integer height = 2188
integer taborder = 30
string title = "none"
string dataobject = "d_pisz070i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//tab_1.tabpage_month.gr_month.reset(category!)
//tab_1.tabpage_month.gr_month.reset(data!)

long	ll_curdate,ll_month,ll_year,ll_cntnum,ll_m[12],li_srnbr,i
string	ls_curdate,mod_string,ls_dept,ls_year,ls_month
dec	ln_ottime,ln_inwon

ll_curdate		= 	long(mid(is_applymonth,1,4) + mid(is_applymonth,6,2))
ls_curdate 	=	string(ll_curdate)
ll_month 		= 	long(mid(is_applymonth,6,2))
ll_year 		= 	long(mid(is_applymonth,1,4))

//데이타를 가져오기위한 년월을 배열에 대입
for ll_cntnum = 12 to 1 step -1
	ll_m[ll_cntnum] = ll_curdate
//	tab_1.tabpage_month.gr_month.addcategory(string(ll_curdate))
//	li_srnbr = tab_1.tabpage_month.gr_month.FindSeries("부하율")
//	tab_1.tabpage_month.gr_month.adddata(li_srnbr,100,string(ll_curdate) )
//	li_srnbr = tab_1.tabpage_month.gr_month.FindSeries("잔업율")
//	tab_1.tabpage_month.gr_month.adddata(li_srnbr,50,string(ll_curdate) )
	ll_month = ll_month -1
	ll_curdate = ll_year * 100 + ll_month
	if ll_month < 1 then
		ll_month = 12
		ll_year = ll_year - 1
		ll_curdate = ll_year * 100 + ll_month
	end if
next

mod_string =	"t_1.text = '" + mid(string(ll_m[1]),1,4) + "년~r~n" + mid(string(ll_m[1]),5,2) + "월'~tt_3.text = '" + mid(string(ll_m[2]),1,4) + "년~r~n" + mid(string(ll_m[2]),5,2) + "월'~t" &
			  + "t_5.text = '" + mid(string(ll_m[3]),1,4) + "년~r~n" + mid(string(ll_m[3]),5,2) + "월'~tt_7.text = '" + mid(string(ll_m[4]),1,4) + "년~r~n" + mid(string(ll_m[4]),5,2) + "월'~t" &
			  + "t_9.text = '" + mid(string(ll_m[5]),1,4) + "년~r~n" + mid(string(ll_m[5]),5,2) + "월'~tt_11.text = '" + mid(string(ll_m[6]),1,4) + "년~r~n" + mid(string(ll_m[6]),5,2) + "월'~t" &
			  + "t_13.text = '" + mid(string(ll_m[7]),1,4) + "년~r~n" + mid(string(ll_m[7]),5,2) + "월'~tt_15.text = '" + mid(string(ll_m[8]),1,4) + "년~r~n" + mid(string(ll_m[8]),5,2) + "월'~t" &
			  + "t_17.text = '" + mid(string(ll_m[9]),1,4) + "년~r~n" + mid(string(ll_m[9]),5,2) + "월'~tt_19.text = '" + mid(string(ll_m[10]),1,4) + "년~r~n" + mid(string(ll_m[10]),5,2) + "월'~t" &
			  + "t_21.text = '" + mid(string(ll_m[11]),1,4) + "년~r~n" + mid(string(ll_m[11]),5,2) + "월'~tt_23.text = '" + mid(string(ll_m[12]),1,4) + "년~r~n" + mid(string(ll_m[12]),5,2) + "월'" 
this.modify(mod_string)

for	i	=	1	to	rowcount
	ls_dept	=	this.object.workcenter[i]
	for	ll_cntnum	=	1	to	12
		ls_year	=	mid(string(ll_m[ll_cntnum]),1,4)
		ls_month	=	mid(string(ll_m[ll_cntnum]),5,2)
		ln_ottime	=	0
		ln_inwon	=	0
		
		select	coalesce(tottime,0),coalesce(tinwon,0) into	:ln_ottime,:ln_inwon	from	delabo.labt05
			where	tgubun	=	'1'	and	tyy	=	:ls_year	and	tmm	=	:ls_month	and	tdepte	=	:ls_dept
		using	sqlca	;
		
		this.setitem(i,"ottime_full_" 	+ string(ll_cntnum),ln_ottime)
		this.setitem(i,"otmh_full_" 	+ string(ll_cntnum),ln_inwon)
		
		ln_ottime	=	0
		ln_inwon	=	0		
		
		select	coalesce(tottime,0),coalesce(tinwon,0) into	:ln_ottime,:ln_inwon	from	delabo.labt05
			where	tgubun	=	'2'	and	tyy	=	:ls_year	and	tmm	=	:ls_month	and	tdepte	=	:ls_dept
		using	sqlca	;
		this.setitem(i,"ottime_temp_" 	+ string(ll_cntnum),ln_ottime)
		this.setitem(i,"otmh_temp_" 	+ string(ll_cntnum),ln_inwon)
	next
next



end event

type tabpage_year from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4571
integer height = 2212
long backcolor = 12632256
string text = "해당년도 조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage_2 dw_tabpage_2
end type

on tabpage_year.create
this.dw_tabpage_2=create dw_tabpage_2
this.Control[]={this.dw_tabpage_2}
end on

on tabpage_year.destroy
destroy(this.dw_tabpage_2)
end on

type dw_tabpage_2 from datawindow within tabpage_year
integer x = 9
integer y = 16
integer width = 4558
integer height = 2192
integer taborder = 20
string title = "none"
string dataobject = "d_pisz070i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;string	ls_dept,ls_year,ls_month
dec	ln_ottime,ln_inwon
int		i,ll_cntnum

for	i	=	1	to	rowcount 
	ls_dept	=	this.object.workcenter[i]
	for	ll_cntnum	=	1	to	12
		ls_year	=	is_applyyear
		ls_month	=	string(ll_cntnum,"00")
		ln_ottime	=	0
		ln_inwon	=	0
		select	coalesce(tottime,0),coalesce(tinwon,0) into	:ln_ottime,:ln_inwon	from	delabo.labt05
			where	tgubun	=	'1'	and	tyy	=	:ls_year	and	tmm	=	:ls_month	and	tdepte	=	:ls_dept
		using	sqlca	;
		
		this.setitem(i,"ottime_full_" 	+ string(ll_cntnum),ln_ottime)
		this.setitem(i,"otmh_full_" 	+ string(ll_cntnum),ln_inwon)
		
		ln_ottime	=	0
		ln_inwon	=	0		
		
		select	coalesce(tottime,0),coalesce(tinwon,0) into	:ln_ottime,:ln_inwon	from	delabo.labt05
			where	tgubun	=	'2'	and	tyy	=	:ls_year	and	tmm	=	:ls_month	and	tdepte	=	:ls_dept
		using	sqlca	;
		this.setitem(i,"ottime_temp_" 	+ string(ll_cntnum),ln_ottime)
		this.setitem(i,"otmh_temp_" 	+ string(ll_cntnum),ln_inwon)
	next
next

end event

type tabpage_create from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4571
integer height = 2212
long backcolor = 12632256
string text = "월별 기준정보 생성"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_create cb_create
dw_tabpage_3 dw_tabpage_3
end type

on tabpage_create.create
this.cb_create=create cb_create
this.dw_tabpage_3=create dw_tabpage_3
this.Control[]={this.cb_create,&
this.dw_tabpage_3}
end on

on tabpage_create.destroy
destroy(this.cb_create)
destroy(this.dw_tabpage_3)
end on

type cb_create from commandbutton within tabpage_create
integer x = 3945
integer y = 16
integer width = 622
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "월별기준정보생성"
end type

event clicked;integer	ln_count	
setpointer(hourglass!)
if	is_Areacode	=	'%'		or	is_divisioncode	=	'%'		then
	messagebox("확인","월별 기준정보는 지역과 공장을 반드시 선택하셔야 합니다")
	return
end if
select	count(*)	into	:ln_count	from	tmhsummary_ot
	where	areacode	=	:is_areacode		and	divisioncode	=	:is_divisioncode	and	applymonth	=	:is_applymonth
using	sqlele	;	
if	ln_count	>	0	then
	if	messagebox("확인","현재 해당월의 기준정보가 생성되어 있는 상태입니다.~r~n 재작업하시겠습니까?",Exclamation!, OKCancel!, 2)	<>	1	then
		return
	end if
end if

delete	from	tmhsummary_ot
	where	areacode	=	:is_areacode		and	divisioncode	=	:is_divisioncode	and	applymonth	=	:is_applymonth
using	sqlele	;	

DECLARE pism_update PROCEDURE for sp_pism_calc_otrate
				@ps_area 			= :is_areacode,
				@ps_div 				= :is_divisioncode, 
				@ps_applymonth	= :is_applymonth
Using SQLPIS;
EXECUTE pism_update ;






end event

type dw_tabpage_3 from datawindow within tabpage_create
integer x = 5
integer y = 124
integer width = 4553
integer height = 2096
integer taborder = 30
string title = "none"
string dataobject = "d_pisz070i_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_area from u_pisc_select_area within w_pisz070i
integer x = 59
integer y = 64
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;if	is_areacode	<>	is_uo_areacode	then
	pb_excel.visible		=	false
	pb_excel.enabled	=	false
	tab_1.tabpage_month.dw_tabpage_1.reset()
	tab_1.tabpage_year.dw_tabpage_2.reset()
	tab_1.tabpage_create.dw_tabpage_3.reset()
end if
is_areacode	=	is_uo_areacode
if	is_areacode	=	'%'	then
	DatawindowChild	ldwc_1
	uo_division.dw_1.GetChild('DDDWCode', ldwc_1)
	ldwc_1.reset()
	ldwc_1.InsertRow(1)
	ldwc_1.Setitem(1, 'DivisionCode', 'ALL')
	ldwc_1.Setitem(1, 'DivisionName', '전체')
	ldwc_1.Setitem(1, 'DivisionNameEng', 'ALL')
	ldwc_1.Setitem(1, 'DisplayName', '전체')
	uo_division.is_uo_divisioncode = '%'
	is_divisioncode	=	'%'
	uo_division.is_uo_divisionname = '전체'
	uo_division.is_uo_divisionnameeng = 'ALL'
	uo_division.dw_1.Setitem(1, 'DDDWCode', 'ALL')
	f_pisc_set_dddw_width(uo_division.dw_1, 'DDDWCode', ldwc_1, 'DivisionNameEng', 20)
else
	string ls_divisionname,ls_divisionnameeng
	f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
end if
end event

event ue_post_constructor;call super::ue_post_constructor;Datawindowchild ldwc_1

dw_1.GetChild('DDDWCode', ldwc_1)
ldwc_1.InsertRow(1)
ldwc_1.Setitem(1, 'AreaCode', 'ALL')
ldwc_1.Setitem(1, 'AreaName', '전체')
ldwc_1.Setitem(1, 'DisplayName', '전체')
is_uo_areacode = '%'
is_areacode	=	'%'
is_uo_areaname = '전체'
dw_1.Setitem(1, 'DDDWCode', 'ALL')
f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'AreaName', 5)

uo_division.dw_1.GetChild('DDDWCode', ldwc_1)
ldwc_1.InsertRow(1)
ldwc_1.Setitem(1, 'DivisionCode', 'ALL')
ldwc_1.Setitem(1, 'DivisionName', '전체')
ldwc_1.Setitem(1, 'DivisionNameEng', 'ALL')
ldwc_1.Setitem(1, 'DisplayName', '전체')
uo_division.is_uo_divisioncode = '%'
is_divisioncode	=	'%'
uo_division.is_uo_divisionname = '전체'
uo_division.is_uo_divisionnameeng = 'ALL'
uo_division.dw_1.Setitem(1, 'DDDWCode', 'ALL')
f_pisc_set_dddw_width(uo_division.dw_1, 'DDDWCode', ldwc_1, 'DivisionNameEng', 20)

//string ls_divisionname,ls_divisionnameeng
//is_areacode	=	is_uo_areacode
//f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

type uo_division from u_pisc_select_division within w_pisz070i
integer x = 626
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode	=	is_uo_divisioncode
end event

event ue_select;call super::ue_select;if	is_divisioncode	<>	is_uo_divisioncode	then
	pb_excel.visible		=	false
	pb_excel.enabled	=	false
	tab_1.tabpage_month.dw_tabpage_1.reset()
	tab_1.tabpage_year.dw_tabpage_2.reset()
	tab_1.tabpage_create.dw_tabpage_3.reset()
end if
is_divisioncode	=	is_uo_divisioncode


end event

type uo_applymonth from u_pisc_date_scroll_month within w_pisz070i
integer x = 1257
integer y = 64
integer taborder = 40
boolean bringtotop = true
end type

on uo_applymonth.destroy
call u_pisc_date_scroll_month::destroy
end on

event constructor;call super::constructor;is_applymonth	=	is_uo_month
end event

event ue_select;call super::ue_select;if	is_applymonth	<>	is_uo_month	then
	pb_excel.visible		=	false
	pb_excel.enabled	=	false
	tab_1.tabpage_month.dw_tabpage_1.reset()
	tab_1.tabpage_year.dw_tabpage_2.reset()
	tab_1.tabpage_create.dw_tabpage_3.reset()
end if
is_applymonth	=	is_uo_month
end event

type uo_applyyear from u_pisc_date_scroll_year within w_pisz070i
boolean visible = false
integer x = 1257
integer y = 64
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
end type

on uo_applyyear.destroy
call u_pisc_date_scroll_year::destroy
end on

event constructor;call super::constructor;is_applyyear	=	is_uo_year
end event

event ue_select;call super::ue_select;if	is_applyyear	<>	is_uo_year	then
	pb_excel.visible		=	false
	pb_excel.enabled	=	false
	tab_1.tabpage_month.dw_tabpage_1.reset()
	tab_1.tabpage_year.dw_tabpage_2.reset()
	tab_1.tabpage_create.dw_tabpage_3.reset()
end if
is_applyyear	=	is_uo_year
end event

type pb_excel from picturebutton within w_pisz070i
boolean visible = false
integer x = 4425
integer y = 24
integer width = 160
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.jpg"
alignment htextalign = left!
end type

event clicked;if	tab_1.selectedtab	=	1	then
	f_save_to_excel(tab_1.tabpage_month.dw_tabpage_1)
elseif	tab_1.selectedtab	=	2	then
	f_save_to_excel(tab_1.tabpage_year.dw_tabpage_2)	
elseif	tab_1.selectedtab	=	3	then
	f_save_to_excel(tab_1.tabpage_create.dw_tabpage_3)		
end if
end event

type gb_1 from groupbox within w_pisz070i
integer x = 5
integer width = 1879
integer height = 172
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

