$PBExportHeader$w_bom111i.srw
$PBExportComments$knock down list
forward
global type w_bom111i from w_origin_sheet02
end type
type ddlb_source from dropdownlistbox within w_bom111i
end type
type st_refdate from statictext within w_bom111i
end type
type st_srcchoice from statictext within w_bom111i
end type
type dw_part_report from datawindow within w_bom111i
end type
type st_itno from statictext within w_bom111i
end type
type sle_itno from singlelineedit within w_bom111i
end type
type pb_search from picturebutton within w_bom111i
end type
type uo_1 from uo_plandiv_pdcd within w_bom111i
end type
type gb_1 from groupbox within w_bom111i
end type
type dw_pridown from datawindow within w_bom111i
end type
type dw_detaildown from datawindow within w_bom111i
end type
type uo_today from uo_today_bom within w_bom111i
end type
end forward

global type w_bom111i from w_origin_sheet02
ddlb_source ddlb_source
st_refdate st_refdate
st_srcchoice st_srcchoice
dw_part_report dw_part_report
st_itno st_itno
sle_itno sle_itno
pb_search pb_search
uo_1 uo_1
gb_1 gb_1
dw_pridown dw_pridown
dw_detaildown dw_detaildown
uo_today uo_today
end type
global w_bom111i w_bom111i

type variables
datastore ids_impdata[3]
string is_refdate,is_plant,is_div,is_pdcd,is_modstring,is_source
long in_currow
end variables

forward prototypes
public function decimal wf_get_yearqty (string a_xplant, string a_div, string a_itno, string a_date)
end prototypes

public function decimal wf_get_yearqty (string a_xplant, string a_div, string a_itno, string a_date);decimal{1}	ln_inv402qty = 0,ln_inv101qty = 0
string		ls_date

ls_date	=	mid(a_date,1,4)	+	'%'

select	sum(intqty)	into :ln_inv402qty
	from 	pbinv.inv402
where		comltd	=	'01'		and	xplant	=	:a_xplant	and	
			div		=	:a_div	and	itno		=	:a_itno		and
			xyear	like	:ls_date
using	sqlca	;

if	sqlca.sqlcode	<> 	0	then
	ln_inv402qty	=	0
end if

if mid(a_date,1,6) >= mid(g_s_date,1,6) then
	select intqty	into :ln_inv101qty	
		from pbinv.inv101
	where comltd	=	'01'		and	xplant	=	:a_xplant	and
			div		=	:a_div	and	itno		=	:a_itno
	using	sqlca ;
	if	sqlca.sqlcode	<> 0	then
		ln_inv101qty	=	0
	end if
end if

return ln_inv402qty	+	ln_inv101qty
end function

on w_bom111i.create
int iCurrent
call super::create
this.ddlb_source=create ddlb_source
this.st_refdate=create st_refdate
this.st_srcchoice=create st_srcchoice
this.dw_part_report=create dw_part_report
this.st_itno=create st_itno
this.sle_itno=create sle_itno
this.pb_search=create pb_search
this.uo_1=create uo_1
this.gb_1=create gb_1
this.dw_pridown=create dw_pridown
this.dw_detaildown=create dw_detaildown
this.uo_today=create uo_today
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_source
this.Control[iCurrent+2]=this.st_refdate
this.Control[iCurrent+3]=this.st_srcchoice
this.Control[iCurrent+4]=this.dw_part_report
this.Control[iCurrent+5]=this.st_itno
this.Control[iCurrent+6]=this.sle_itno
this.Control[iCurrent+7]=this.pb_search
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_pridown
this.Control[iCurrent+11]=this.dw_detaildown
this.Control[iCurrent+12]=this.uo_today
end on

on w_bom111i.destroy
call super::destroy
destroy(this.ddlb_source)
destroy(this.st_refdate)
destroy(this.st_srcchoice)
destroy(this.dw_part_report)
destroy(this.st_itno)
destroy(this.sle_itno)
destroy(this.pb_search)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.dw_pridown)
destroy(this.dw_detaildown)
destroy(this.uo_today)
end on

event open;call super::open;call super:: open;
ddlb_source.text 				= "내자"
ids_impdata[1] 				= create datastore
ids_impdata[1].dataobject 	= "d_bom001_implo_03"
ids_impdata[2] 				= create datastore
ids_impdata[2].dataobject 	= "d_bom001_implo_03"
ids_impdata[3] 				= create datastore
ids_impdata[3].dataobject 	= "d_bom001_implo_03"

ids_impdata[1].settransobject(sqlca)
ids_impdata[2].settransobject(sqlca)
ids_impdata[3].settransobject(sqlca)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_insert 	= false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;setpointer(hourglass!)
long 		ll_cntrow,ll_cnt
string 	ls_pdcd,ls_itno,ls_itnm,ls_itspec,ls_itunit,ls_itprum,ls_itabc,ls_rtndata
string 	ls_pdcd1,ls_itclsb, ls_srce, ls_rtncd
dec{2} 	lc_itumcv,lc_itucan

f_pism_working_msg(This.title,"Knock-Down 정보를 조회중입니다. 잠시만 기다려 주십시오.")
ls_rtncd 	= uo_1.uf_return()
is_plant 	= mid(ls_rtncd,1,1)
is_div 		= mid(ls_rtncd,2,1)
ls_pdcd 		= mid(ls_rtncd,3)
is_source 	= ddlb_source.text

is_refdate 	= f_dateedit(uo_today.is_uo_date)

if f_spacechk(is_source) = -1 and f_spacechk(sle_itno.text) = -1 then
	uo_status.st_message.text 	= f_message("E284")
	ddlb_source.backcolor 		= rgb(255,255,0)
	ddlb_source.setfocus()
	return 0
else
	ddlb_source.backcolor 		= 15780518
	sle_itno.backcolor 			= rgb(255,255,255)
end if
dw_pridown.reset()
dw_detaildown.reset()
if f_spacechk(sle_itno.text) = -1 then 
	if is_source 		= '내자' then 
		is_source = '02'
	elseif is_source	= '외자' then
		is_source = '01'
	elseif is_source 	= '사급' then
		is_source = '04'
	elseif is_source 	= '자가' then
		is_source = '03' 
	elseif is_source 	= '타공장이체' then
		is_source = '05' 		
	elseif is_source 	= '타공장사급' then
		is_source = '06' 				
	end if
	is_pdcd 		= ls_pdcd
	ll_cntrow	= dw_pridown.retrieve(is_plant,is_div,ls_pdcd + '%',is_source + '%','%',is_refdate)
else
	ls_itno 		= trim(upper(sle_itno.text))
	
	SELECT	"PBINV"."INV101"."CLS",   
         	"PBINV"."INV101"."SRCE",   
         	"PBINV"."INV101"."PDCD"  
    INTO 	:ls_itclsb,   
         	:ls_srce,   
         	:ls_pdcd1  
    FROM "PBINV"."INV101"  
   WHERE ( "PBINV"."INV101"."COMLTD" 	= :g_s_company )	AND  
         ( "PBINV"."INV101"."XPLANT" 	= :is_plant ) 		AND  
         ( "PBINV"."INV101"."DIV" 		= :is_div ) 		AND  
         ( "PBINV"."INV101"."ITNO" 		= :ls_itno )   
			using sqlca;

	if f_spacechk(ls_itclsb) = -1 and f_spacechk(ls_srce) = -1 and f_spacechk(ls_pdcd1) = -1 then
		sle_itno.backcolor = rgb(255,255,0)
		sle_itno.setfocus()
		uo_status.st_message.text = f_message("E320")
		If IsValid(w_pism_working) Then Close(w_pism_working) 
		return 0
	else
		sle_itno.backcolor = rgb(255,255,255)
	end if
	ls_pdcd1 = mid(ls_pdcd1,1,2)
	uo_1.uf_set_pdcd(ls_pdcd1)

	if ls_srce 		= '02' then 
		ddlb_source.text = '내자'
	elseif ls_srce 	= '01' then
		ddlb_source.text = '외자'
	elseif ls_srce 	= '04' then
		ddlb_source.text = '사급'
	elseif ls_srce 	= '03' then
		ddlb_source.text = '자가'
	elseif ls_srce 	= '05' then
		ddlb_source.text = '타공장이체'
	elseif ls_srce 	= '06' then
		ddlb_source.text = '타공장사급'		
	end if
	is_pdcd 		= ls_pdcd1
	ll_cntrow 	= dw_pridown.retrieve(is_plant,is_div,is_pdcd + '%',ls_srce + '%',ls_itno + '%',is_refdate)
end if
if ll_cntrow > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	If IsValid(w_pism_working) Then Close(w_pism_working) 
	return 0
end if
If IsValid(w_pism_working) Then Close(w_pism_working) 
// Current Button Status Buffering
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_print = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
return 0

end event

event close;call super::close;destroy ids_impdata[1]
destroy ids_impdata[2]
destroy ids_impdata[3] 
end event

event ue_print;integer 	li_rowcnt,li_cntnum,li_currow
string 	mod_string
string 	ls_refdate,ls_divnm,ls_pdcd,ls_pdnm,ls_prtdate

window 	l_to_open
str_easy l_str_prt
									
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
dw_part_report.reset()

//Data transfer from dw_2 to dw_cost_report
li_rowcnt = dw_detaildown.rowcount()
for li_cntnum 	= 1 to li_rowcnt
	li_currow 	= dw_part_report.insertrow(0)
	dw_part_report.setitem(li_currow,"itno",dw_pridown.getitemstring(in_currow,"INV101_ITNO"))
	dw_part_report.setitem(li_currow,"itname",dw_pridown.getitemstring(in_currow,"INV002_ITNM"))
	dw_part_report.setitem(li_currow,"itnmsr",dw_pridown.getitemstring(in_currow,"INV002_XUNIT"))
	dw_part_report.setitem(li_currow,"itumcv",dw_pridown.object.INV101_CONVQTY[in_currow])
	dw_part_report.setitem(li_currow,"itprum",dw_pridown.object.INV101_XUNIT[in_currow])
	dw_part_report.setitem(li_currow,"itucan",dw_pridown.object.compute_1[in_currow])
	dw_part_report.setitem(li_currow,"itpqtym",dw_detaildown.object.itpqtym[li_cntnum])
	dw_part_report.setitem(li_currow,"itwkct",dw_detaildown.object.itwkct[li_cntnum])
	dw_part_report.setitem(li_currow,"itmodel",dw_detaildown.object.itmodel[li_cntnum])
	dw_part_report.setitem(li_currow,"itmdnm",dw_detaildown.object.itmdnm[li_cntnum])
	dw_part_report.setitem(li_currow,"cls",dw_detaildown.object.cls[li_cntnum])
	dw_part_report.setitem(li_currow,"srce",dw_detaildown.object.srce[li_cntnum])
	dw_part_report.setitem(li_currow,"totalqty",dw_detaildown.object.totalqty[li_cntnum])
	dw_part_report.setitem(li_currow,"soyoqty",dw_detaildown.object.soyoqty[li_cntnum])
next

//create header string for modify in sharedata datawindow
ls_prtdate = string(g_s_date,"@@@@.@@.@@")
mod_string = is_modstring + "prtdate.text = '" + ls_prtdate + "'"

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  	= sqlca
l_str_prt.datawindow   	= dw_part_report
l_str_prt.dwsyntax 		= mod_string
l_str_prt.title 			= "KNOCK-DOWN PART LIST"
l_str_prt.tag			  	= This.ClassName()

f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""
return 0

end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom111i
end type

type ddlb_source from dropdownlistbox within w_bom111i
integer x = 2862
integer y = 68
integer width = 375
integer height = 500
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean sorted = false
boolean vscrollbar = true
integer limit = 5
string item[] = {"내자","외자","자가","사급","타공장이체","타공장사급"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;sle_itno.text = ' '
//if f_spacechk(ddlb_source.text) = -1 then
//	sle_itno.enabled = true
//	sle_itno.displayonly = false
//	pb_search.enabled = true
//	pb_search.visible = true
//else
//	sle_itno.enabled =  false
//	sle_itno.displayonly = true
//	pb_search.enabled = false
//	pb_search.visible = false
//end if
//	
end event

type st_refdate from statictext within w_bom111i
integer x = 3333
integer y = 88
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준일자"
boolean focusrectangle = false
end type

type st_srcchoice from statictext within w_bom111i
integer x = 2560
integer y = 84
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "자재구분"
boolean focusrectangle = false
end type

type dw_part_report from datawindow within w_bom111i
boolean visible = false
integer x = 3227
integer y = 44
integer width = 256
integer height = 100
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_report_knockdown"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_itno from statictext within w_bom111i
integer x = 78
integer y = 196
integer width = 146
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_bom111i
event ue_keydown pbm_keydown
integer x = 233
integer y = 184
integer width = 549
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type pb_search from picturebutton within w_bom111i
integer x = 873
integer y = 176
integer width = 238
integer height = 108
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_div,ls_pdcd,ls_parm,ls_plant,ls_rtncd

ls_rtncd	= uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div 	= mid(ls_rtncd,2,1)
ls_pdcd  = mid(ls_rtncd,3)
ls_parm 	= ls_plant + ls_div + ls_pdcd

openwithparm(w_bom110u_res_03,ls_parm)

ls_parm 			= message.stringparm
sle_itno.text 	= ls_parm
end event

type uo_1 from uo_plandiv_pdcd within w_bom111i
integer x = 82
integer y = 44
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type gb_1 from groupbox within w_bom111i
integer x = 32
integer width = 4471
integer height = 300
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_pridown from datawindow within w_bom111i
integer x = 27
integer y = 328
integer width = 1321
integer height = 2148
string title = "none"
string dataobject = "d_bom001_111i_pridown"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;setpointer(hourglass!)
integer li_first,li_temp,li_second,li_third,i
long ll_cntrow1,ll_cntrow2,ll_currow3,ll_cntx,ll_cnty,ll_cntloop,ll_dcntrow,ll_currow,ll_chkcnt,ll_totalloop
string ls_itno,ls_modelno,ls_rtnitno, ls_wkct, ls_kijun_day
string ls_itnm,ls_spec,ls_nmsr,ls_prum,ls_avcd,ls_divnm,ls_pdcdnm,ls_pdcdcd,ls_srcnm,ls_srccd
string ls_plantnm, ls_plantcd
dec{3} lc_pqtym
dec{4} ls_umcv
dec{2} ls_ucan
dec{1} ln_yearqty

// boolean lb_chkcd
s_itemasa_data rtndata
s_invdata_info invdata
datawindowchild child_plant,child_pdcd

uo_status.st_message.text = ""
in_currow = row
ll_cntx = 1
ll_cntloop = 1
ll_totalloop = 1
li_first = 1
li_second = 2
li_third = 3
ids_impdata[li_first].reset()
ids_impdata[li_second].reset()
ids_impdata[li_third].reset()
dw_detaildown.reset()
//get a data for header in report
ls_divnm = f_get_coflname(g_s_company,'DAC030',is_div)
ls_pdcdnm = f_get_coflname(g_s_company,'DAC160',is_pdcd)
ls_pdcdcd = is_pdcd
ls_plantnm = f_get_coflname(g_s_company,'SLE220',is_plant)
ls_plantcd = is_plant
if f_spacechk(is_source) <> -1 then
	if is_source = '01' then
		ls_srcnm = '외자'
	elseif is_source = '02' then
		ls_srcnm = '내자' 
	elseif is_source = '03' then 
		ls_srcnm = '자가'
	elseif is_source = '04' then
		ls_srcnm = '사급' 
	else
		ls_srcnm = '제품'
	end if
end if   
ls_itno = dw_pridown.getitemstring(row,"INV101_ITNO")
ls_itnm = dw_pridown.getitemstring(row,"INV002_ITNM")
ls_spec = dw_pridown.getitemstring(row,"INV002_SPEC")
ls_nmsr = dw_pridown.getitemstring(row,"INV002_XUNIT")
ls_umcv = dw_pridown.getitemnumber(row,"INV101_CONVQTY")
ls_prum = dw_pridown.getitemstring(row,"INV101_XUNIT")
ls_ucan = dw_pridown.getitemnumber(row,"INV101_COSTLS")
ls_avcd = dw_pridown.getitemstring(row,"INV101_ABCCD")
ls_kijun_day = string(mid(is_refdate,1,8),"@@@@.@@.@@" + " 기준") 
is_modstring = "divnm.text = '" + ls_divnm + "'~tpdcdnm.text = '" + ls_pdcdnm + "'~t" &
				  + "pdcdcd.text = '(" + ls_pdcdcd + ")'~t" &
				  + "srcnm.text = '" + ls_srcnm + "'~tsrccd.text = '(" + is_source + ")'~t" &
				   + "kijun_day.text = '(" + ls_kijun_day + ")'~t" &
				  + "itspec.text = '" + ls_spec + "'~titavcd.text = '" + ls_avcd + "'"

//retrieve parent item about item dbclicked

ll_cntrow1 = ids_impdata[li_first].retrieve(is_plant,is_div,ls_itno,is_refdate)

if ll_cntrow1 < 1 then 
	uo_status.st_message.text = " 상위 모델이 존재하지 않습니다 "
	return
end if

for i = 1 to ll_cntrow1
	ls_itno = ids_impdata[li_first].object.ppitn[i]
	ls_rtnitno = f_option_chk_after(is_plant,is_div,ls_itno,is_refdate)
	if f_spacechk(ls_rtnitno) <> -1 and ls_rtnitno <> ls_itno then
		ids_impdata[li_first].object.pqtym[i] = 0
	end if
next

//호환품번 CHECK & 원단위량계산 & Finding Model_item
do while true
	do
		ls_itno = ids_impdata[li_first].object.ppitn[ll_cntloop]
		ls_wkct = ids_impdata[li_first].object.pwkct[ll_cntloop]
		ll_cntrow2 = ids_impdata[li_second].retrieve(is_plant,is_div,ls_itno,is_refdate)
		if mid(is_refdate,1,6) >= mid(g_s_date,1,6) then
			invdata = f_bom_get_curinv(is_plant,is_div,ls_itno)
		else
			invdata = f_bom_get_pastinv(is_plant,is_div,ls_itno,mid(is_refdate,1,4),integer(mid(is_refdate,5,2)))
		end if
		//if cur_item Arrive a Model_item
		if ll_cntrow2 < 1 then
			ll_currow = dw_detaildown.insertrow(0)
			dw_detaildown.object.itpqtym[ll_currow] 	= ids_impdata[li_first].object.pqtym[ll_cntloop]
			ln_yearqty											= wf_get_yearqty(is_plant,is_div,ls_itno,is_refdate)			
			dw_detaildown.object.soyoqty[ll_currow] 	= ln_yearqty
			dw_detaildown.object.totalqty[ll_currow] 	= invdata.it_mrcq 
			dw_detaildown.object.itwkct[ll_currow] 	= ls_wkct
			dw_detaildown.object.itmodel[ll_currow] 	= ids_impdata[li_first].object.ppitn[ll_cntloop]
			dw_detaildown.object.srce[ll_currow] 		= invdata.it_srce
			dw_detaildown.object.cls[ll_currow] 		= invdata.it_clsb
			rtndata 												= f_bom_get_itemasa(ids_impdata[li_first].object.ppitn[ll_cntloop])
			dw_detaildown.object.itmdnm[ll_currow] 	= rtndata.itname
			dw_detaildown.object.soyoqtym[ll_currow] 	= ln_yearqty * ids_impdata[li_first].object.pqtym[ll_cntloop] / ls_umcv
			dw_detaildown.object.totalqty[ll_currow] = invdata.it_mrcq * ids_impdata[li_first].object.pqtym[ll_cntloop] / ls_umcv
		else	
			do
				ls_itno    = trim(ids_impdata[li_second].object.ppitn[ll_cntx])
				ls_rtnitno = f_option_chk_after(is_plant,is_div,ls_itno,is_refdate)
			
				if f_spacechk(ls_rtnitno) <> -1 then
					if ls_rtnitno = ls_itno then
						ll_currow3 = ids_impdata[li_third].insertrow(0)
						ids_impdata[li_third].object.ppitn[ll_currow3] = ls_itno
						lc_pqtym = ids_impdata[li_first].object.pqtym[ll_cntloop] * ids_impdata[li_second].object.pqtym[ll_cntx]
						ids_impdata[li_third].object.pqtym[ll_currow3] = lc_pqtym
   //ids_impdata[li_third].object.pwkct[ll_currow3] = ids_impdata[li_second].object.pwkct[ll_cntx]
						ids_impdata[li_third].object.pwkct[ll_currow3] = ls_wkct
						
					else
						ll_currow3 = ids_impdata[li_third].insertrow(0)
						ids_impdata[li_third].object.ppitn[ll_currow3] = ls_itno
						ids_impdata[li_third].object.pqtym[ll_currow3] = 0
//						ids_impdata[li_third].object.pwkct[ll_currow3] = ids_impdata[li_second].object.pwkct[ll_cntx]	
						ids_impdata[li_third].object.pwkct[ll_currow3] = ls_wkct
					end if
				else
					ll_currow3 = ids_impdata[li_third].insertrow(0)
					ids_impdata[li_third].object.ppitn[ll_currow3] = ls_itno
					lc_pqtym = ids_impdata[li_second].object.pqtym[ll_cntx] * ids_impdata[li_first].object.pqtym[ll_cntloop] 
					ids_impdata[li_third].object.pqtym[ll_currow3] = lc_pqtym
//					ids_impdata[li_third].object.pwkct[ll_currow3] = ids_impdata[li_second].object.pwkct[ll_cntx]
					ids_impdata[li_third].object.pwkct[ll_currow3] = ls_wkct
				end if
				ll_cntx = ll_cntx + 1
			loop until ll_cntx > ll_cntrow2
		end if
		ll_cntx = 1
		ll_cntloop = ll_cntloop + 1
	loop until ll_cntloop > ll_cntrow1
	ids_impdata[li_third].accepttext()
	ids_impdata[li_first].reset()
	ids_impdata[li_second].reset()
	li_temp = li_first
	li_first = li_third
	li_third = li_second
	li_second = li_temp
	ll_cntrow1 = ids_impdata[li_first].rowcount()
	if ll_cntrow1 < 1 then
		ll_currow = dw_detaildown.rowcount()
		//calculate pqtym at a same model and delete row of this model
		ll_cntx = 1
		do
			ls_itno = dw_detaildown.object.itmodel[ll_cntx]
			for ll_cnty = ll_cntx + 1 to ll_currow
				ls_modelno = dw_detaildown.object.itmodel[ll_cnty]
				if ls_itno = ls_modelno and dw_detaildown.object.itpqtym[ll_cnty] <> 0 then
					if mid(is_refdate,1,6) >= mid(g_s_date,1,6) then
						invdata = f_bom_get_curinv(is_plant,is_div,ls_itno)
					else
						invdata = f_bom_get_pastinv(is_plant,is_div,ls_itno,mid(is_refdate,1,4),integer(mid(is_refdate,5,2)))
					end if
					lc_pqtym = dw_detaildown.object.itpqtym[ll_cntx] + dw_detaildown.object.itpqtym[ll_cnty]
					dw_detaildown.object.itpqtym[ll_cntx] 	= lc_pqtym
					ln_yearqty										= wf_get_yearqty(is_plant,is_div,ls_itno,is_refdate)
					dw_detaildown.object.soyoqty[ll_cntx] 	= ln_yearqty
//					dw_detaildown.object.soyoqty[ll_cntx] 	= ( lc_pqtym * invdata.it_mrcq )
					dw_detaildown.object.totalqty[ll_cntx] = invdata.it_mrcq 
					dw_detaildown.object.soyoqtym[ll_cntx] 	= ln_yearqty * lc_pqtym / ls_umcv
					dw_detaildown.object.totalqty[ll_cntx] = invdata.it_mrcq * lc_pqtym / ls_umcv
					dw_detaildown.object.itpqtym[ll_cnty] 	= 0
					dw_detaildown.object.srce[ll_cnty] 		= invdata.it_srce
					dw_detaildown.object.cls[ll_cnty] 		= invdata.it_clsb
				end if
			next
			ll_cntx = ll_cntx + 1
		loop until ll_cntx > ll_currow
		uo_status.st_message.text = f_message("I010")
		exit
	end if
	ll_cntx = 1
	ll_cntloop = 1
	ll_totalloop = ll_totalloop + 1
loop

//상위품번이 호환부품번인지를 check
//ll_chkcnt = 1
//ll_cntrow1 = dw_detaildown.rowcount()
//do 
//	lc_pqtym = dw_detaildown.object.itpqtym[ll_chkcnt]
//	if lc_pqtym <> 0 then
//		lb_chkcd = true
//		exit
//	end if
//	ll_chkcnt = ll_chkcnt + 1
//	lb_chkcd = false
//loop until ll_chkcnt > ll_cntrow1
//
dw_detaildown.accepttext()
dw_detaildown.setredraw(false)
dw_detaildown.setsort("itpqtym A,itwkct A,itmodel A,itmdnm A")
dw_detaildown.sort()
//if lb_chkcd = true then
dw_detaildown.setfilter("itpqtym <> 0")
dw_detaildown.filter()
//end if
dw_detaildown.setredraw(true)

// Current Button Status Buffering
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_print = true
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

event clicked;integer ln_rowcnt

ln_rowcnt = this.rowcount()
if row > 0 and row <= ln_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
dw_detaildown.reset()
end event

event constructor;this.settransobject(sqlca) ;

end event

type dw_detaildown from datawindow within w_bom111i
integer x = 1371
integer y = 328
integer width = 3127
integer height = 2148
string title = "none"
string dataobject = "d_bom001_111i_detaildown"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_today from uo_today_bom within w_bom111i
event ue_keydown pbm_keydown
event destroy ( )
integer x = 3621
integer y = 76
integer taborder = 80
boolean bringtotop = true
end type

on uo_today.destroy
call uo_today_bom::destroy
end on

