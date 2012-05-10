$PBExportHeader$w_bom307i.srw
$PBExportComments$가공관리비 BOM 재료비조회 (일일결산용)
forward
global type w_bom307i from w_origin_sheet02
end type
type tab_1 from tab within w_bom307i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type st_display from statictext within tabpage_3
end type
type gb_2 from groupbox within tabpage_3
end type
type gb_1 from groupbox within tabpage_3
end type
type gr_view_cost from graph within tabpage_3
end type
type rb_data from radiobutton within tabpage_3
end type
type rb_graph from radiobutton within tabpage_3
end type
type rb_out from radiobutton within tabpage_3
end type
type rb_in from radiobutton within tabpage_3
end type
type rb_outp from radiobutton within tabpage_3
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_display st_display
gb_2 gb_2
gb_1 gb_1
gr_view_cost gr_view_cost
rb_data rb_data
rb_graph rb_graph
rb_out rb_out
rb_in rb_in
rb_outp rb_outp
dw_3 dw_3
end type
type tab_1 from tab within w_bom307i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type st_3 from statictext within w_bom307i
end type
type dw_cost_report from datawindow within w_bom307i
end type
type dw_ind_list from datawindow within w_bom307i
end type
type st_4 from statictext within w_bom307i
end type
type ddlb_dvd from dropdownlistbox within w_bom307i
end type
type uo_1 from uo_plandiv_pdcd within w_bom307i
end type
type pb_down from picturebutton within w_bom307i
end type
type dw_4 from datawindow within w_bom307i
end type
type cb_1 from commandbutton within w_bom307i
end type
type st_1 from statictext within w_bom307i
end type
type sle_fromdt from singlelineedit within w_bom307i
end type
type sle_todt from singlelineedit within w_bom307i
end type
type st_6 from statictext within w_bom307i
end type
type gb_3 from groupbox within w_bom307i
end type
type gb_4 from groupbox within w_bom307i
end type
end forward

global type w_bom307i from w_origin_sheet02
integer width = 4809
integer height = 3104
string title = "BOM 월간 정보 조회"
tab_1 tab_1
st_3 st_3
dw_cost_report dw_cost_report
dw_ind_list dw_ind_list
st_4 st_4
ddlb_dvd ddlb_dvd
uo_1 uo_1
pb_down pb_down
dw_4 dw_4
cb_1 cb_1
st_1 st_1
sle_fromdt sle_fromdt
sle_todt sle_todt
st_6 st_6
gb_3 gb_3
gb_4 gb_4
end type
global w_bom307i w_bom307i

type variables
string 	is_dvsn, is_pdcd,is_plant,is_year,is_month,is_modstring,is_modstringind
string 	is_itno	            
int 		in_tab_index,in_rowcnt
long 		in_tabcnt
string 	is_uochkplant,is_uochkdvsn, is_uochkpdcd
dec 		id_uochkyear
end variables

forward prototypes
public subroutine wf_set_valuelist (string a_pastdate, string a_comsec)
public subroutine wf_reset ()
end prototypes

public subroutine wf_set_valuelist (string a_pastdate, string a_comsec);integer 	ln_curmon,ln_write_cnt,i
long 		ln_currow,ln_m[12],ln_cntnum,ln_curdate,ln_year,ln_month
dec{0} 	ld_acst,ld_rcst,ld_scst,ld_ciac[12]
string 	ls_itno,ls_spec,ls_curdate,mod_string,ls_invdae_year,ls_plant,ls_dvsn,ls_applydate

ls_applydate = dw_4.getitemstring(1,"zdate")
ln_curdate 	= long(is_year + is_month)
ls_curdate 	= string(ln_curdate)
ln_month 	= long(is_month)
ln_year 		= long(is_year)

//데이타를 가져오기위한 년월을 배열에 대입
for ln_cntnum = 12 to 1 step -1
	ln_m[ln_cntnum] 	= ln_curdate
	ln_month 			= ln_month -1
	ln_curdate 			= ln_year * 100 + ln_month
	if ln_month < 1 then
		ln_month 	= 12
		ln_year 		= ln_year - 1
		ln_curdate 	= ln_year * 100 + ln_month
	end if
next

//modify column header in dw_2
mod_string = "m12_ciac_t.text = '" + mid(string(ln_m[12]),3,2) + "/" + mid(string(ln_m[12]),5,2)	+ "월'~tm11_ciac_t.text = '" 	+ mid(string(ln_m[11]),3,2)	+ "/" + mid(string(ln_m[11]),5,2) 	+ "월'~t" &
			  + "m10_ciac_t.text	= '" + mid(string(ln_m[10]),3,2) + "/" + mid(string(ln_m[10]),5,2)	+ "월'~tm9_ciac_t.text = '" 	+ mid(string(ln_m[9]),3,2) 	+ "/" + mid(string(ln_m[9]),5,2) 	+ "월'~t" &
			  + "m8_ciac_t.text 	= '" + mid(string(ln_m[8]),3,2) 	+ "/" + mid(string(ln_m[8]),5,2) 	+ "월'~tm7_ciac_t.text = '" 	+ mid(string(ln_m[7]),3,2) 	+ "/" + mid(string(ln_m[7]),5,2) 	+ "월'~t" &
			  + "m6_ciac_t.text 	= '" + mid(string(ln_m[6]),3,2) 	+ "/" + mid(string(ln_m[6]),5,2) 	+ "월'~tm5_ciac_t.text = '" 	+ mid(string(ln_m[5]),3,2) 	+ "/" + mid(string(ln_m[5]),5,2)	 	+ "월'~t" &
			  + "m4_ciac_t.text 	= '" + mid(string(ln_m[4]),3,2) 	+ "/" + mid(string(ln_m[4]),5,2) 	+ "월'~tm3_ciac_t.text = '" 	+ mid(string(ln_m[3]),3,2) 	+ "/" + mid(string(ln_m[3]),5,2) 	+ "월'~t" &
			  + "m2_ciac_t.text 	= '" + mid(string(ln_m[2]),3,2) 	+ "/" + mid(string(ln_m[2]),5,2) 	+ "월'~tm1_ciac_t.text = '" 	+ mid(string(ln_m[1]),3,2) 	+ "/" + mid(string(ln_m[1]),5,2) 	+ "월'~t" &
			  + "m0_ciac_t.text 	= '" + string(ls_applydate,"@@@@/@@/@@") + "'"
tab_1.tabpage_2.dw_2.modify(mod_string)
is_modstring = is_modstring + "~t" + mod_string

//품번별,년도별로 정열된 커서
ln_write_cnt	= 	tab_1.tabpage_2.dw_2.retrieve(is_plant,is_dvsn,is_pdcd + '%',ls_applydate,string(ln_m[1]),string(ln_m[12]) , &
               	mid(string(ln_m[1]),5,2), mid(string(ln_m[2]),5,2), mid(string(ln_m[3]),5,2), mid(string(ln_m[4]),5,2), &
					 	mid(string(ln_m[5]),5,2), mid(string(ln_m[6]),5,2), mid(string(ln_m[7]),5,2), mid(string(ln_m[8]),5,2), &			
                 	mid(string(ln_m[9]),5,2), mid(string(ln_m[10]),5,2), mid(string(ln_m[11]),5,2), mid(string(ln_m[12]),5,2),a_comsec)
if ln_write_cnt = 0 then
	uo_status.st_message.text = f_message("I020")
else
	for i = 1 to ln_write_cnt
		ls_itno	=	trim(tab_1.tabpage_2.dw_2.object.fmdno[i])
		ls_plant = trim(tab_1.tabpage_2.dw_2.object.BOM109d_fplant[i])
		ls_dvsn = trim(tab_1.tabpage_2.dw_2.object.BOM109d_fdvsn[i])
		tab_1.tabpage_2.dw_2.setitem(i,"qty0",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,mid(ls_applydate,1,6)))
		tab_1.tabpage_2.dw_2.setitem(i,"qty1",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[1])))
		tab_1.tabpage_2.dw_2.setitem(i,"qty2",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[2])))			
		tab_1.tabpage_2.dw_2.setitem(i,"qty3",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[3])))					
		tab_1.tabpage_2.dw_2.setitem(i,"qty4",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[4])))
		tab_1.tabpage_2.dw_2.setitem(i,"qty5",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[5])))			
		tab_1.tabpage_2.dw_2.setitem(i,"qty6",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[6])))							
		tab_1.tabpage_2.dw_2.setitem(i,"qty7",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[7])))
		tab_1.tabpage_2.dw_2.setitem(i,"qty8",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[8])))			
		tab_1.tabpage_2.dw_2.setitem(i,"qty9",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[9])))					
		tab_1.tabpage_2.dw_2.setitem(i,"qty10",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[10])))
		tab_1.tabpage_2.dw_2.setitem(i,"qty11",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[11])))			
		tab_1.tabpage_2.dw_2.setitem(i,"qty12",f_bom_get_invdae(ls_plant,ls_dvsn,ls_itno,string(ln_m[12])))									
	next	
	uo_status.st_message.text = f_message("I010")
end if

end subroutine

public subroutine wf_reset ();tab_1.tabpage_1.dw_1.reset()
tab_1.tabpage_2.dw_2.reset()
tab_1.tabpage_3.dw_3.reset()
end subroutine

on w_bom307i.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_3=create st_3
this.dw_cost_report=create dw_cost_report
this.dw_ind_list=create dw_ind_list
this.st_4=create st_4
this.ddlb_dvd=create ddlb_dvd
this.uo_1=create uo_1
this.pb_down=create pb_down
this.dw_4=create dw_4
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_fromdt=create sle_fromdt
this.sle_todt=create sle_todt
this.st_6=create st_6
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.dw_cost_report
this.Control[iCurrent+4]=this.dw_ind_list
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.ddlb_dvd
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.pb_down
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.sle_fromdt
this.Control[iCurrent+13]=this.sle_todt
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_4
end on

on w_bom307i.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_3)
destroy(this.dw_cost_report)
destroy(this.dw_ind_list)
destroy(this.st_4)
destroy(this.ddlb_dvd)
destroy(this.uo_1)
destroy(this.pb_down)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_fromdt)
destroy(this.sle_todt)
destroy(this.st_6)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;tab_1.tabpage_1.dw_1.settransobject(sqlca)
tab_1.tabpage_2.dw_2.settransobject(sqlca)
tab_1.tabpage_3.dw_3.settransobject(sqlca)
dw_ind_list.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_4.insertrow(0)
//1step 에서 조회 이벤트억제
in_tabcnt = 1
tab_1.tabpage_3.enabled = false
ddlb_dvd.selectitem(1)

i_b_retrieve = true
i_b_insert = false
i_b_save  = false
i_b_delete = false
i_b_print  = false
i_b_first = false
i_b_prev = false
i_b_next = false
i_b_last = false
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;setpointer(hourglass!)
int 		ln_row,ln_cntmon,ln_cntyea,ln_cntnum,ln_sqlcount
string 	ls_divnm,ls_pdnm,ls_pdcd,ls_rtncd,ls_plantnm,lc_yyyymm,ls_applydate
string 	ls_yearpst,ls_itemno,ls_itspec,is_yearmonth,ls_comsec,ls_comseccd
datawindowchild child_plant,child_pdcd

ls_rtncd 		= uo_1.uf_return()
is_plant 		= mid(ls_rtncd,1,1)
is_dvsn  		= mid(ls_rtncd,2,1)
is_pdcd  		= trim(mid(ls_rtncd,3))  

ls_applydate = dw_4.getitemstring(1,"zdate")
lc_yyyymm 		= mid(f_relative_month(ls_applydate,-1),1,6)
is_uochkdvsn 	= is_dvsn
is_uochkpdcd 	= is_pdcd
id_uochkyear 	= long(lc_yyyymm)
is_year 			= mid(lc_yyyymm,1,4)
is_month 		= mid(lc_yyyymm,5,2)
is_yearmonth 	= is_year + is_month

tab_1.tabpage_1.dw_1.reset()
tab_1.tabpage_2.dw_2.reset()
tab_1.tabpage_3.gr_view_cost.reset(category!)
tab_1.tabpage_3.gr_view_cost.reset(data!)
uo_status.st_message.text 	= ""
is_modstring 					= ""
ln_cntyea 						= integer(is_year)
ln_cntmon 						= integer(is_month)
//기준월로부터 12개월뒤의  년도와 월을 구함
for ln_cntnum 		= 1 to 11
	ln_cntmon 		= ln_cntmon - 1
	if ln_cntmon 	< 1 then
		ln_cntyea 	= ln_cntyea - 1
		ln_cntmon 	= 12
	end if
next
ls_yearpst	= string((ln_cntyea * 100) + ln_cntmon)
in_tabcnt 	= in_tabcnt + 1

if is_plant 		= 'D' then
	ls_plantnm 		= '대 구'
elseif is_plant 	= 'J' then
	ls_plantnm 		= '진 천'
elseif is_plant 	= 'K' then
	ls_plantnm 		= '군 산'
end if

ls_divnm = f_get_coflname(g_s_company,'DAC030',is_dvsn)

if f_spacechk(is_plant) = -1 then
	is_plant = '%'
else
	is_plant = is_plant + '%'
end if

if f_spacechk(is_dvsn) = -1 then
	is_dvsn = '%'
else
	is_dvsn = is_dvsn + '%'
end if

if f_spacechk(is_pdcd) <> -1 then
	ls_pdnm = f_get_coflname(g_s_company,'DAC160',is_pdcd)
	ls_pdcd = is_pdcd
	is_pdcd = is_pdcd + '%'
else
	ls_pdnm = '전체'
	ls_pdcd = ''
	is_pdcd = '%'
end if
ls_comsec = trim(ddlb_dvd.text)
if ls_comsec 	= "전사(공제전)" then
	ls_comseccd = 'A'
elseif ls_comsec = "공장별(공제전)" then
	ls_comseccd = 'B'
elseif ls_comsec = "전사(공제후)" then
	ls_comseccd = 'D'
else
	ls_comseccd = 'E'
end if
tab_1.tabpage_3.st_display.text = "(" + ls_comsec + ")"
//제품별재료비와 월별재료비의 구분
choose case in_tab_index
	case 1
		is_modstring	= "divnm.text = '" + ls_divnm + "'" &
							+ "~tplantnm.text = '" + ls_plantnm + "'" &
							+ "~tkijun_day.text = '(" + string(ls_applydate,"@@@@.@@.@@") + " " + ls_comsec + " 기준)'" &
							+ "~tprtdate.text = '" + string(g_s_date,"@@@@.@@.@@") + "'"
		
		tab_1.tabpage_1.dw_1.reset()
		f_pism_working_msg(This.title,"제품별 재료비 정보를 조회중입니다. 잠시만 기다려 주십시오.") 
		If IsValid(w_pism_working) Then Close(w_pism_working) 
		ln_row = tab_1.tabpage_1.dw_1.retrieve(ls_applydate,is_plant,is_dvsn,is_pdcd,ls_comseccd)
		if ln_row > 0 then
			uo_status.st_message.text = f_message("I010")
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
		end if
		
		//disable print icon
		i_b_print = true
		wf_icon_onoff(	i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  		i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  		i_b_dprint,    i_b_dchar)
	case 2
		//공장명,제품코드,제품명
		
		f_pism_working_msg(This.title,"월별 재료비 정보를 조회중입니다. 잠시만 기다려 주십시오.") 
		SELECT count(*)  
    		INTO :ln_sqlcount  
    	FROM "PBPDM"."BOM109D"  
   	WHERE	( "PBPDM"."BOM109D"."FCMCD" = :g_s_company ) AND  
         	( "PBPDM"."BOM109D"."FDATE" = :ls_applydate ) AND 
				( "PBPDM"."BOM109D"."FGUBUN" = :ls_comseccd ) AND
         	( "PBPDM"."BOM109D"."FPLANT" like :is_plant ) AND  
         	( "PBPDM"."BOM109D"."FDVSN" like :is_dvsn ) AND
				( "PBPDM"."BOM109D"."FPDCD" like :is_pdcd) 
      using sqlca;
		//set the data in 재료비list
		tab_1.tabpage_2.dw_2.reset()
		if ln_sqlcount > 0 then
			is_modstring	= "refdate_t.text = '(" + string(ls_applydate,"@@@@.@@.@@") + " " + ls_comsec + " 기준)'" &
			             	+ "~tplantnm.text = '" + ls_plantnm + "'" & 
							 	+ "~tdivnm_t.text = '" + ls_divnm + "'" &
								+ "~tprtdate_t.text = '" + string(g_s_date,"@@@@.@@.@@") + "'"
			wf_set_valuelist(ls_yearpst,ls_comseccd) 
		else
			uo_status.st_message.text	=	f_message("I020")
		end if
		If IsValid(w_pism_working) Then Close(w_pism_working)
		i_b_print = true
		wf_icon_onoff(	i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  		i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  		i_b_dprint,    i_b_dchar)
end choose
return 0
end event

event ue_print;integer 	li_rowcnt,li_cntnum,li_currow,ln_row
string 	mod_string,ls_comsec,ls_comseccd,ls_applydate

window 	l_to_open
str_easy l_str_prt
									
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
dw_cost_report.reset()
dw_ind_list.reset()

ls_comsec = trim(ddlb_dvd.text)
ls_applydate = dw_4.getitemstring(1,"zdate")
if ls_comsec 	= "전사(공제전)" then
	ls_comseccd = 'A'
elseif ls_comsec = "공장별(공제전)" then
	ls_comseccd = 'B'
elseif ls_comsec = "전사(공제후)" then
	ls_comseccd = 'D'
else
	ls_comseccd = 'E'
end if
//Data transfer from dw_2 to dw_cost_report
if in_tab_index 	= 1 then
	mod_string 		= is_modstring 
	ln_row 			= dw_ind_list.retrieve(is_plant,ls_comseccd,ls_applydate,is_dvsn,is_pdcd + '%')
	if ln_row < 1 then
		uo_status.st_message.text	=	f_message("P020")		// 조회할 자료가 없습니다.
	end if
	//인쇄 DataWindow 저장
	//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
	l_str_prt.transaction  	= sqlca
	l_str_prt.datawindow   	= dw_ind_list
	l_str_prt.dwsyntax 		= mod_string
	l_str_prt.title 			= "제품별재료비 List"
	l_str_prt.tag			  	= This.ClassName()
	
	f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
	Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	uo_status.st_message.Text = ""
	return 0
else 
	li_rowcnt 		= tab_1.tabpage_2.dw_2.rowcount()
	for li_cntnum 	= 1 to li_rowcnt
		li_currow 	= dw_cost_report.insertrow(0)
		dw_cost_report.setitem(li_currow,"plant",tab_1.tabpage_2.dw_2.object.BOM109d_fplant[li_cntnum])
		dw_cost_report.setitem(li_currow,"dvsn",tab_1.tabpage_2.dw_2.object.BOM109d_fdvsn[li_cntnum])
		dw_cost_report.setitem(li_currow,"pdcd",tab_1.tabpage_2.dw_2.object.BOM109d_fpdcd[li_cntnum])
		dw_cost_report.setitem(li_currow,"prname",tab_1.tabpage_2.dw_2.object.dac007_prname[li_cntnum])
		dw_cost_report.setitem(li_currow,"itno",tab_1.tabpage_2.dw_2.object.fmdno[li_cntnum])
		dw_cost_report.setitem(li_currow,"itspec",tab_1.tabpage_2.dw_2.object.inv002_spec[li_cntnum])
		dw_cost_report.setitem(li_currow,"m0_ciac",tab_1.tabpage_2.dw_2.object.qty0[li_cntnum])
		dw_cost_report.setitem(li_currow,"m0_acst",tab_1.tabpage_2.dw_2.object.tacst00[li_cntnum])
		dw_cost_report.setitem(li_currow,"m0_rcst",tab_1.tabpage_2.dw_2.object.trcst00[li_cntnum])
		dw_cost_report.setitem(li_currow,"m0_scst",tab_1.tabpage_2.dw_2.object.oscst00[li_cntnum])
		dw_cost_report.setitem(li_currow,"m2_ciac",tab_1.tabpage_2.dw_2.object.qty2[li_cntnum])
		dw_cost_report.setitem(li_currow,"m2_acst",tab_1.tabpage_2.dw_2.object.tacst02[li_cntnum])
		dw_cost_report.setitem(li_currow,"m2_rcst",tab_1.tabpage_2.dw_2.object.trcst02[li_cntnum])
		dw_cost_report.setitem(li_currow,"m2_scst",tab_1.tabpage_2.dw_2.object.oscst02[li_cntnum])
		dw_cost_report.setitem(li_currow,"m3_ciac",tab_1.tabpage_2.dw_2.object.qty3[li_cntnum])
		dw_cost_report.setitem(li_currow,"m3_acst",tab_1.tabpage_2.dw_2.object.tacst03[li_cntnum])
		dw_cost_report.setitem(li_currow,"m3_rcst",tab_1.tabpage_2.dw_2.object.trcst03[li_cntnum])
		dw_cost_report.setitem(li_currow,"m3_scst",tab_1.tabpage_2.dw_2.object.oscst03[li_cntnum])
		dw_cost_report.setitem(li_currow,"m4_ciac",tab_1.tabpage_2.dw_2.object.qty4[li_cntnum])
		dw_cost_report.setitem(li_currow,"m4_acst",tab_1.tabpage_2.dw_2.object.tacst04[li_cntnum])
		dw_cost_report.setitem(li_currow,"m4_rcst",tab_1.tabpage_2.dw_2.object.trcst04[li_cntnum])
		dw_cost_report.setitem(li_currow,"m4_scst",tab_1.tabpage_2.dw_2.object.oscst04[li_cntnum])
		dw_cost_report.setitem(li_currow,"m5_ciac",tab_1.tabpage_2.dw_2.object.qty5[li_cntnum])
		dw_cost_report.setitem(li_currow,"m5_acst",tab_1.tabpage_2.dw_2.object.tacst05[li_cntnum])
		dw_cost_report.setitem(li_currow,"m5_rcst",tab_1.tabpage_2.dw_2.object.trcst05[li_cntnum])
		dw_cost_report.setitem(li_currow,"m5_scst",tab_1.tabpage_2.dw_2.object.oscst05[li_cntnum])
		dw_cost_report.setitem(li_currow,"m6_ciac",tab_1.tabpage_2.dw_2.object.qty6[li_cntnum])
		dw_cost_report.setitem(li_currow,"m6_acst",tab_1.tabpage_2.dw_2.object.tacst06[li_cntnum])
		dw_cost_report.setitem(li_currow,"m6_rcst",tab_1.tabpage_2.dw_2.object.trcst06[li_cntnum])
		dw_cost_report.setitem(li_currow,"m6_scst",tab_1.tabpage_2.dw_2.object.oscst06[li_cntnum])
		dw_cost_report.setitem(li_currow,"m7_ciac",tab_1.tabpage_2.dw_2.object.qty7[li_cntnum])
		dw_cost_report.setitem(li_currow,"m7_acst",tab_1.tabpage_2.dw_2.object.tacst07[li_cntnum])
		dw_cost_report.setitem(li_currow,"m7_rcst",tab_1.tabpage_2.dw_2.object.trcst07[li_cntnum])
		dw_cost_report.setitem(li_currow,"m7_scst",tab_1.tabpage_2.dw_2.object.oscst07[li_cntnum])
		dw_cost_report.setitem(li_currow,"m8_ciac",tab_1.tabpage_2.dw_2.object.qty8[li_cntnum])
		dw_cost_report.setitem(li_currow,"m8_acst",tab_1.tabpage_2.dw_2.object.tacst08[li_cntnum])
		dw_cost_report.setitem(li_currow,"m8_rcst",tab_1.tabpage_2.dw_2.object.trcst08[li_cntnum])
		dw_cost_report.setitem(li_currow,"m8_scst",tab_1.tabpage_2.dw_2.object.oscst08[li_cntnum])
		dw_cost_report.setitem(li_currow,"m9_ciac",tab_1.tabpage_2.dw_2.object.qty9[li_cntnum])
		dw_cost_report.setitem(li_currow,"m9_acst",tab_1.tabpage_2.dw_2.object.tacst09[li_cntnum])
		dw_cost_report.setitem(li_currow,"m9_rcst",tab_1.tabpage_2.dw_2.object.trcst09[li_cntnum])
		dw_cost_report.setitem(li_currow,"m9_scst",tab_1.tabpage_2.dw_2.object.oscst09[li_cntnum])
		dw_cost_report.setitem(li_currow,"m10_ciac",tab_1.tabpage_2.dw_2.object.qty10[li_cntnum])
		dw_cost_report.setitem(li_currow,"m10_acst",tab_1.tabpage_2.dw_2.object.tacst10[li_cntnum])
		dw_cost_report.setitem(li_currow,"m10_rcst",tab_1.tabpage_2.dw_2.object.trcst10[li_cntnum])
		dw_cost_report.setitem(li_currow,"m10_scst",tab_1.tabpage_2.dw_2.object.oscst10[li_cntnum])
		dw_cost_report.setitem(li_currow,"m11_ciac",tab_1.tabpage_2.dw_2.object.qty11[li_cntnum])
		dw_cost_report.setitem(li_currow,"m11_acst",tab_1.tabpage_2.dw_2.object.tacst11[li_cntnum])
		dw_cost_report.setitem(li_currow,"m11_rcst",tab_1.tabpage_2.dw_2.object.trcst11[li_cntnum])
		dw_cost_report.setitem(li_currow,"m11_scst",tab_1.tabpage_2.dw_2.object.oscst11[li_cntnum])
		dw_cost_report.setitem(li_currow,"m12_ciac",tab_1.tabpage_2.dw_2.object.qty12[li_cntnum])
		dw_cost_report.setitem(li_currow,"m12_acst",tab_1.tabpage_2.dw_2.object.tacst12[li_cntnum])
		dw_cost_report.setitem(li_currow,"m12_rcst",tab_1.tabpage_2.dw_2.object.trcst12[li_cntnum])
		dw_cost_report.setitem(li_currow,"m12_scst",tab_1.tabpage_2.dw_2.object.oscst12[li_cntnum])
	next
	mod_string 					= is_modstring 
	l_str_prt.transaction  	= sqlca
	l_str_prt.datawindow   	= dw_cost_report
	l_str_prt.dwsyntax 		= mod_string
	l_str_prt.title 			= "월별재료비 내역 화면"
	l_str_prt.tag			  	= This.ClassName()
	
	f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
	Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
	uo_status.st_message.Text = ""
	return 0
end if
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve") 
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom307i
end type

type tab_1 from tab within w_bom307i
integer x = 18
integer y = 296
integer width = 4585
integer height = 2180
integer taborder = 40
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
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event constructor;tab_1.selectedtab = 1

end event

event selectionchanged;dec{0} 	lc_yyyymm
integer 	ln_modify 
window 	ls_wsheet
datawindowchild child_plant,child_pdcd

in_tab_index = newindex
uo_status.st_message.text = ""
if oldindex = newindex or in_tabcnt < 2 then
	return
end if
//uo_1.dw_plant.getchild("coitname",child_plant)
//uo_1.dw_pdcd.getchild("prname",child_pdcd)
//is_dvsn  = child_plant.getitemstring(uo_1.uf_plant_currow(),"cocode")
//is_pdcd  = child_pdcd.getitemstring(uo_1.uf_pdcd_currow(),"prprcd")
//call uf_yyyymm in uo_comm_yymm
// lc_yyyymm = uo_2.uf_yyyymm()
choose case newindex
	case 1
		uo_1.enabled 	= true
		i_b_print 		= true
		tab_1.tabpage_3.enabled = false
	case 2
		uo_1.enabled 	= true
		i_b_print 		= true
	case 3
		uo_1.enabled 	= false
		tab_1.tabpage_3.enabled = true
		tab_1.tabpage_3.rb_data.triggerevent("clicked")
end choose

wf_icon_onoff(	i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					i_b_dprint,    i_b_dchar)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2064
long backcolor = 12632256
string text = "제품별 재료비"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
integer width = 4539
integer height = 2056
integer taborder = 50
string title = "none"
string dataobject = "d_bom001_307i_01"
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

event doubleclicked;integer 	li_cntnum,li_cntmon,li_cntyea,li_rowcnt,li_srnbr
string 	ls_yearpst,ls_itnm,ls_comseccd,ls_yyyymm,ls_applydate,ls_comsec
double 	ld_mcst,ld_rcst,ld_acst7

tab_1.tabpage_3.enabled = true
tab_1.tabpage_3.dw_3.reset()

//조회할 년도와 월을 구함
ls_applydate = dw_4.getitemstring(1,"zdate")
ls_yyyymm = f_relative_month(ls_applydate,-1)
is_year  	= mid(ls_yyyymm,1,4)
is_month 	= mid(ls_yyyymm,5,2)
li_cntyea 	= integer(is_year)
li_cntmon 	= integer(is_month)
for li_cntnum = 1 to 10
	li_cntmon = li_cntmon - 1
	if li_cntmon < 1 then
		li_cntyea = li_cntyea - 1
		li_cntmon = 12
	end if
next
ls_yearpst 	= string((li_cntyea * 100) + li_cntmon)
is_itno 		= tab_1.tabpage_1.dw_1.object.BOM109d_fmdno[row]
ls_itnm 		= tab_1.tabpage_1.dw_1.object.inv002_itnm[row]

ls_comsec = trim(ddlb_dvd.text)
if ls_comsec 	= "전사(공제전)" then
	ls_comseccd = 'A'
elseif ls_comsec = "공장별(공제전)" then
	ls_comseccd = 'B'
elseif ls_comsec = "전사(공제후)" then
	ls_comseccd = 'D'
else
	ls_comseccd = 'E'
end if

//재료별 추이 retrieve
in_rowcnt = tab_1.tabpage_3.dw_3.retrieve((is_year + is_month),ls_yearpst,is_plant,is_dvsn,is_pdcd + '%',is_itno,ls_comseccd,ls_applydate)
tab_1.selecttab(3)
if tab_1.tabpage_3.rb_data.checked = false then
	tab_1.tabpage_3.rb_data.checked = true
end if
tab_1.tabpage_3.rb_data.triggerevent("clicked")
//set a title in graph
tab_1.tabpage_3.gr_view_cost.title = is_itno + " / " + ls_itnm
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2064
long backcolor = 12632256
string text = "월별  재료비"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
integer y = 4
integer width = 4544
integer height = 2052
integer taborder = 60
string dataobject = "d_bom001_307i_02"
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

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2064
long backcolor = 12632256
string text = "재료비 추이"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_display st_display
gb_2 gb_2
gb_1 gb_1
gr_view_cost gr_view_cost
rb_data rb_data
rb_graph rb_graph
rb_out rb_out
rb_in rb_in
rb_outp rb_outp
dw_3 dw_3
end type

on tabpage_3.create
this.st_display=create st_display
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gr_view_cost=create gr_view_cost
this.rb_data=create rb_data
this.rb_graph=create rb_graph
this.rb_out=create rb_out
this.rb_in=create rb_in
this.rb_outp=create rb_outp
this.dw_3=create dw_3
this.Control[]={this.st_display,&
this.gb_2,&
this.gb_1,&
this.gr_view_cost,&
this.rb_data,&
this.rb_graph,&
this.rb_out,&
this.rb_in,&
this.rb_outp,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.st_display)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gr_view_cost)
destroy(this.rb_data)
destroy(this.rb_graph)
destroy(this.rb_out)
destroy(this.rb_in)
destroy(this.rb_outp)
destroy(this.dw_3)
end on

type st_display from statictext within tabpage_3
integer x = 2862
integer y = 56
integer width = 965
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_3
integer x = 1481
integer width = 1326
integer height = 140
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Type"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_3
integer x = 498
integer width = 955
integer height = 140
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "View"
borderstyle borderstyle = styleraised!
end type

type gr_view_cost from graph within tabpage_3
boolean visible = false
integer y = 156
integer width = 3529
integer height = 1372
boolean border = true
grgraphtype graphtype = linegraph!
long textcolor = 33554432
long backcolor = 12632256
integer spacing = 100
string title = "(None)"
integer depth = 100
grlegendtype legend = atbottom!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

on gr_view_cost.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.TextSize=19
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="굴림체"
TitleDispAttr.FontCharSet=Hangeul!
TitleDispAttr.FontFamily=Modern!
TitleDispAttr.FontPitch=Fixed!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
Category.Label="기준년월"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Arial"
Category.DispAttr.FontCharSet=DefaultCharSet!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="굴림체"
Category.LabelDispAttr.FontCharSet=Hangeul!
Category.LabelDispAttr.FontFamily=Modern!
Category.LabelDispAttr.FontPitch=Fixed!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="단 가"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontCharSet=DefaultCharSet!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="굴림체"
Values.LabelDispAttr.FontCharSet=Hangeul!
Values.LabelDispAttr.FontFamily=Modern!
Values.LabelDispAttr.FontPitch=Fixed!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontCharSet=DefaultCharSet!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontCharSet=DefaultCharSet!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="Arial"
LegendDispAttr.FontCharSet=DefaultCharSet!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Arial"
PieDispAttr.FontCharSet=DefaultCharSet!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_view_cost.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

event constructor;tab_1.tabpage_3.gr_view_cost.addseries( "내자")
tab_1.tabpage_3.gr_view_cost.addseries( "외자")
tab_1.tabpage_3.gr_view_cost.addseries( "타공장")
tab_1.tabpage_3.gr_view_cost.addseries( "외주사급")


end event

type rb_data from radiobutton within tabpage_3
integer x = 699
integer y = 56
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Data"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;tab_1.tabpage_3.dw_3.show()
tab_1.tabpage_3.gr_view_cost.hide()
tab_1.tabpage_3.rb_in.enabled 	= false
tab_1.tabpage_3.rb_out.enabled 	= false
tab_1.tabpage_3.rb_outp.enabled	= false
end event

type rb_graph from radiobutton within tabpage_3
integer x = 1051
integer y = 56
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Graph"
borderstyle borderstyle = styleraised!
end type

event clicked;int 		li_cntmon,li_cntyea,li_cntnum
string 	ls_yearpst,lc_yyyymm,ls_applydate

//call uf_yyyymm in uo_comm_yymm
ls_applydate = dw_4.getitemstring(1,"zdate")
lc_yyyymm 		= mid(f_relative_month(ls_applydate,-1),1,6)
is_uochkplant 	= is_plant
is_uochkdvsn 	= is_dvsn
is_uochkpdcd 	= is_pdcd
id_uochkyear 	= long(lc_yyyymm)
is_year 			= mid(lc_yyyymm,1,4)
is_month 		= mid(lc_yyyymm,5,2)

tab_1.tabpage_3.gr_view_cost.reset(category!)
tab_1.tabpage_3.gr_view_cost.reset(data!)
li_cntyea 		= integer(is_year)
li_cntmon 		= integer(is_month)

//기준월로부터 12개월뒤의  년도와 월을 구함
for li_cntnum 	= 1 to 10
	li_cntmon 	= li_cntmon - 1
	if li_cntmon < 1 then
		li_cntyea = li_cntyea - 1
		li_cntmon = 12
	end if
next
ls_yearpst = string((li_cntyea * 100) + li_cntmon)

for li_cntnum = 1 to 12
	tab_1.tabpage_3.gr_view_cost.addcategory(ls_yearpst)
	li_cntmon 	= li_cntmon + 1
	if li_cntmon > 12 then
		li_cntyea = li_cntyea + 1
		li_cntmon = 1
	end if
	ls_yearpst = string((li_cntyea * 100) + li_cntmon)
next
tab_1.tabpage_3.dw_3.hide()
tab_1.tabpage_3.gr_view_cost.show()
tab_1.tabpage_3.rb_in.enabled 	= true
tab_1.tabpage_3.rb_out.enabled 	= true
tab_1.tabpage_3.rb_outp.enabled 	= true
tab_1.tabpage_3.rb_out.checked 	= true
tab_1.tabpage_3.rb_out.triggerevent("clicked")

end event

type rb_out from radiobutton within tabpage_3
integer x = 1650
integer y = 56
integer width = 352
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "최종입고"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;integer 	li_cntnum,li_srnbr
string 	ls_yearpst
double 	ld_drcst,ld_ircst,ld_dvont,ld_foscst
//Title in Graph
tab_1.tabpage_3.gr_view_cost.reset(data!)

//내자,외자,타공장의 최종입고단가
//select된 data를 Graph에 입력
for li_cntnum = 1 to in_rowcnt
	ls_yearpst	= tab_1.tabpage_3.dw_3.object.fdate[li_cntnum]
	ld_drcst 	= tab_1.tabpage_3.dw_3.object.fdrcst[li_cntnum]
	ld_ircst 	= tab_1.tabpage_3.dw_3.object.fircst[li_cntnum]
	ld_dvont 	= tab_1.tabpage_3.dw_3.object.fdvort[li_cntnum]
	ld_foscst 	= tab_1.tabpage_3.dw_3.object.foscst[li_cntnum]
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("내자")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_drcst,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("외자")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_ircst,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("타공장")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_dvont,ls_yearpst )	
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("외주사급")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_foscst,ls_yearpst )
next
end event

type rb_in from radiobutton within tabpage_3
integer x = 2034
integer y = 56
integer width = 352
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "이동평균"
borderstyle borderstyle = styleraised!
end type

event clicked;integer 	li_cntnum,li_srnbr
string 	ls_yearpst
double 	ld_dmcst,ld_imcst,ld_dvomt,ld_foscst
//Title in Graph
tab_1.tabpage_3.gr_view_cost.reset(data!)

//내자,외자,타공장의 이동평균단가
//select된 data를 Graph에 입력
for li_cntnum = 1 to in_rowcnt
	ls_yearpst 	= tab_1.tabpage_3.dw_3.object.fdate[li_cntnum]
	ld_dmcst 	= tab_1.tabpage_3.dw_3.object.fdmcst[li_cntnum]
	ld_imcst 	= tab_1.tabpage_3.dw_3.object.fimcst[li_cntnum]
	ld_dvomt 	= tab_1.tabpage_3.dw_3.object.fdvomt[li_cntnum]
	ld_foscst 	= tab_1.tabpage_3.dw_3.object.foscst[li_cntnum]
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("내자")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_dmcst,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("외자")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_imcst,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("타공장")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_dvomt,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("외주사급")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_foscst,ls_yearpst )
next
end event

type rb_outp from radiobutton within tabpage_3
integer x = 2409
integer y = 56
integer width = 352
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "불출평균"
borderstyle borderstyle = styleraised!
end type

event clicked;integer 	li_cntnum,li_srnbr
string 	ls_yearpst
double 	ld_dacst,ld_iacst,ld_dvoat,ld_foscst
//Title in Graph
tab_1.tabpage_3.gr_view_cost.reset(data!)

//내자,외자,타공장의 불출평균단가
//select된 data를 Graph에 입력
for li_cntnum = 1 to in_rowcnt
	ls_yearpst 	= tab_1.tabpage_3.dw_3.object.fdate[li_cntnum]
	ld_dacst 	= tab_1.tabpage_3.dw_3.object.fdacst[li_cntnum]
	ld_iacst 	= tab_1.tabpage_3.dw_3.object.fiacst[li_cntnum]
	ld_dvoat 	= tab_1.tabpage_3.dw_3.object.fdvoat[li_cntnum]
	ld_foscst 	= tab_1.tabpage_3.dw_3.object.foscst[li_cntnum]
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("내자")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_dacst,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("외자")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_iacst,ls_yearpst )
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("타공장")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_dvoat,ls_yearpst )	
	li_srnbr 	= tab_1.tabpage_3.gr_view_cost.FindSeries("외주사급")
	tab_1.tabpage_3.gr_view_cost.adddata(li_srnbr,ld_foscst,ls_yearpst )	
next
end event

type dw_3 from datawindow within tabpage_3
integer y = 152
integer width = 4215
integer height = 1904
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom001_307i_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_bom307i
integer x = 64
integer y = 168
integer width = 288
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

type dw_cost_report from datawindow within w_bom307i
boolean visible = false
integer x = 3255
integer y = 152
integer width = 123
integer height = 92
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_307i_report_costlist_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ind_list from datawindow within w_bom307i
boolean visible = false
integer x = 3406
integer y = 28
integer width = 160
integer height = 268
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_307i_report_indcost"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bom307i
integer x = 891
integer y = 172
integer width = 343
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "재료비구분"
boolean focusrectangle = false
end type

type ddlb_dvd from dropdownlistbox within w_bom307i
integer x = 1225
integer y = 160
integer width = 608
integer height = 424
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "none"
boolean sorted = false
string item[] = {"공장별(공제전)","전사(공제전)","공장별(공제후)","전사(공제후)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;wf_reset()
end event

type uo_1 from uo_plandiv_pdcd within w_bom307i
integer x = 69
integer y = 28
integer taborder = 70
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type pb_down from picturebutton within w_bom307i
integer x = 1897
integer y = 148
integer width = 274
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if in_tab_index = 1 then
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		f_save_to_excel(tab_1.tabpage_1.dw_1)
	else
		uo_status.st_message.text = "제품별재료비로 조회된 데이타가 없습니다."
	end if
end if

if in_tab_index = 2 then
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		f_save_to_excel(tab_1.tabpage_2.dw_2)
	else
		uo_status.st_message.text = "월별재료비로 조회된 데이타가 없습니다."
	end if
end if
end event

type dw_4 from datawindow within w_bom307i
integer x = 343
integer y = 160
integer width = 471
integer height = 88
integer taborder = 30
boolean bringtotop = true
string dataobject = "dddw_bom306i_select_zdate"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_bom307i
integer x = 2661
integer y = 48
integer width = 795
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일일결산용 재료비계산"
end type

event clicked;string ls_curtime
datawindowchild ldwc

if MessageBox("확인", "일일결산용 표준재료비 계산작업을 진행하시겠습니까?", Exclamation!, OKCancel!, 2) = 2 then
	return -1
end if

setpointer(hourglass!)

SELECT CAST(CURRENT TIME AS VARCHAR(10)) 
into :ls_curtime
FROM PBCOMMON.COMM000
using sqlca;
sle_fromdt.text = ls_curtime

//일일결산용 전공장 재료비계산 호출
DECLARE SP_BOM_002 PROCEDURE FOR PBPDM.SP_BOM_002  
         A_COMLTD = '01',   
         A_APPLYDATE = :g_s_date,   
         A_CREATEDATE = :g_s_date,   
         A_CHK = 'C'  
			using sqlca;

execute SP_BOM_002;

// 일일결산용 공장별 재료비계산 호출
// DECLARE SP_BOM_001 PROCEDURE FOR PBPDM.SP_BOM_001  
//         A_COMLTD = '01',   
//         A_PLANT = 'B',   
//         A_DVSN = 'H',   
//         A_APPLYDATE = :g_s_date,   
//         A_CREATEDATE = :g_s_date,   
//         A_CHK = 'C'  
//		using sqlca;
//
//execute SP_BOM_001;

SELECT CAST(CURRENT TIME AS VARCHAR(10))
into :ls_curtime
FROM PBCOMMON.COMM000
using sqlca;
sle_todt.text = ls_curtime

dw_4.GetChild('zdate', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve()

return 0
end event

type st_1 from statictext within w_bom307i
integer x = 2665
integer y = 188
integer width = 823
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "계산소요시간:90분~~120분"
boolean focusrectangle = false
end type

type sle_fromdt from singlelineedit within w_bom307i
integer x = 3749
integer y = 52
integer width = 809
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_todt from singlelineedit within w_bom307i
integer x = 3749
integer y = 152
integer width = 809
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_bom307i
integer x = 3529
integer y = 60
integer width = 201
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "시간:"
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_bom307i
integer x = 23
integer y = 12
integer width = 2537
integer height = 264
integer taborder = 70
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_bom307i
integer x = 2578
integer y = 12
integer width = 2016
integer height = 264
integer taborder = 70
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

