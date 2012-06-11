$PBExportHeader$w_bom308i.srw
$PBExportComments$가공관리비 BOM 단가미등록 (일일결산용)
forward
global type w_bom308i from w_origin_sheet02
end type
type tab_1 from tab within w_bom308i
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
type tab_1 from tab within w_bom308i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_3 from statictext within w_bom308i
end type
type dw_cost_report from datawindow within w_bom308i
end type
type dw_ind_list from datawindow within w_bom308i
end type
type st_4 from statictext within w_bom308i
end type
type ddlb_dvd from dropdownlistbox within w_bom308i
end type
type uo_1 from uo_plandiv_pdcd within w_bom308i
end type
type pb_down from picturebutton within w_bom308i
end type
type dw_4 from datawindow within w_bom308i
end type
type gb_3 from groupbox within w_bom308i
end type
end forward

global type w_bom308i from w_origin_sheet02
integer width = 4992
integer height = 3624
string title = "일일손익 BOM단가 미등록조회"
tab_1 tab_1
st_3 st_3
dw_cost_report dw_cost_report
dw_ind_list dw_ind_list
st_4 st_4
ddlb_dvd ddlb_dvd
uo_1 uo_1
pb_down pb_down
dw_4 dw_4
gb_3 gb_3
end type
global w_bom308i w_bom308i

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
end subroutine

on w_bom308i.create
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
this.gb_3=create gb_3
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
this.Control[iCurrent+10]=this.gb_3
end on

on w_bom308i.destroy
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
destroy(this.gb_3)
end on

event open;call super::open;tab_1.tabpage_1.dw_1.settransobject(sqlca)
tab_1.tabpage_2.dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_4.insertrow(0)
//1step 에서 조회 이벤트억제
in_tabcnt = 1
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
int 		ln_row,ln_cntnum,ln_sqlcount
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
uo_status.st_message.text 	= ""
is_modstring 					= ""

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

type uo_status from w_origin_sheet02`uo_status within w_bom308i
end type

type tab_1 from tab within w_bom308i
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

choose case newindex
	case 1
		uo_1.enabled 	= true
		i_b_print 		= true
	case 2
		uo_1.enabled 	= true
		i_b_print 		= true
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
string text = "BOM재료비 대비 실적재료비"
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
integer y = 8
integer width = 4539
integer height = 2048
integer taborder = 50
string title = "none"
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

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4549
integer height = 2064
long backcolor = 12632256
string text = "단가미정 품목정보"
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
integer y = 12
integer width = 4544
integer height = 2044
integer taborder = 60
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

type st_3 from statictext within w_bom308i
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

type dw_cost_report from datawindow within w_bom308i
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

type dw_ind_list from datawindow within w_bom308i
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

type st_4 from statictext within w_bom308i
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

type ddlb_dvd from dropdownlistbox within w_bom308i
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

type uo_1 from uo_plandiv_pdcd within w_bom308i
integer x = 69
integer y = 28
integer taborder = 70
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type pb_down from picturebutton within w_bom308i
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

type dw_4 from datawindow within w_bom308i
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

type gb_3 from groupbox within w_bom308i
integer x = 23
integer y = 12
integer width = 4562
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

