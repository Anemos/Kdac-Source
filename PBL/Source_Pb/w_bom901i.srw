$PBExportHeader$w_bom901i.srw
$PBExportComments$M-BOM History 조회
forward
global type w_bom901i from w_origin_sheet02
end type
type st_3 from statictext within w_bom901i
end type
type sle_1 from singlelineedit within w_bom901i
end type
type rb_1 from radiobutton within w_bom901i
end type
type rb_2 from radiobutton within w_bom901i
end type
type st_4 from statictext within w_bom901i
end type
type em_1 from editmask within w_bom901i
end type
type gb_divfind from groupbox within w_bom901i
end type
type st_5 from statictext within w_bom901i
end type
type st_6 from statictext within w_bom901i
end type
type st_7 from statictext within w_bom901i
end type
type sle_ininv from singlelineedit within w_bom901i
end type
type sle_outinv from singlelineedit within w_bom901i
end type
type sle_osinv from singlelineedit within w_bom901i
end type
type ddlb_choice from dropdownlistbox within w_bom901i
end type
type dw_mbom_report from datawindow within w_bom901i
end type
type pb_1 from picturebutton within w_bom901i
end type
type st_8 from statictext within w_bom901i
end type
type tab_history from tab within w_bom901i
end type
type tabpage_indent from userobject within tab_history
end type
type dw_indentlist from datawindow within tabpage_indent
end type
type tv_indent from treeview within tabpage_indent
end type
type tabpage_indent from userobject within tab_history
dw_indentlist dw_indentlist
tv_indent tv_indent
end type
type tabpage_partlist from userobject within tab_history
end type
type dw_partlist from datawindow within tabpage_partlist
end type
type tabpage_partlist from userobject within tab_history
dw_partlist dw_partlist
end type
type tabpage_single from userobject within tab_history
end type
type dw_single from datawindow within tabpage_single
end type
type tabpage_single from userobject within tab_history
dw_single dw_single
end type
type tab_history from tab within w_bom901i
tabpage_indent tabpage_indent
tabpage_partlist tabpage_partlist
tabpage_single tabpage_single
end type
type uo_1 from uo_plandiv_pdcd within w_bom901i
end type
type str_bomdata_info from structure within w_bom901i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_bom901i from w_origin_sheet02
string title = "History 조회"
st_3 st_3
sle_1 sle_1
rb_1 rb_1
rb_2 rb_2
st_4 st_4
em_1 em_1
gb_divfind gb_divfind
st_5 st_5
st_6 st_6
st_7 st_7
sle_ininv sle_ininv
sle_outinv sle_outinv
sle_osinv sle_osinv
ddlb_choice ddlb_choice
dw_mbom_report dw_mbom_report
pb_1 pb_1
st_8 st_8
tab_history tab_history
uo_1 uo_1
end type
global w_bom901i w_bom901i

type variables
datastore ids_data1[],ids_data2,ids_data3
protected:
string 	root_nm , is_setdate ,is_plant[],is_div[], is_chk_option
integer 	in_pos,in_mid ,in_curlevel,in_tabindex1,in_chk_level,in_first
integer 	in_hold,in_wkhold   //재료비계산에서 쓰이는 변수
dec{3} 	id_set_pqtym[]      //[a,b] a:레벨 b:자동핸들부여값
dec{6} 	idc_ininv,idc_outinv,idc_osinv,idc_fosinv			//이동평균재료비
dec{6} 	idc_inmasa,idc_outmasa,idc_osmasa,idc_fosmasa		//불출평균재료비
dec{6} 	idc_inucan,idc_outucan,idc_osucan,idc_fosucan		//최종입고재료비
long 		in_cnt


end variables

forward prototypes
private function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, ref treeview ag_this)
public function str_bomdata_info wf_get_bomdata (string a_plant, string a_div, string a_pitno, string a_citno, string a_date)
private subroutine wf_itempopulate (long ag_handle, ref treeview ag_tvcurrent)
public subroutine wf_lvitempop (long ag_handle, ref treeview ag_tvcurrent, string ag_chk)
private function long wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew, long ag_phandle, ref treeview ag_this)
public subroutine wf_singlelevel_list (string a_plant, string a_div, string a_itno, string a_date)
public subroutine wf_sort_partlist ()
end prototypes

private function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, ref treeview ag_this);long 		ln_rtn
Integer	ln_Cnt
TreeViewItem	l_tvi_New
For ln_Cnt = 1 To ag_Rows
	// TreeView에 Item에 각각의 값을 Setting시킨다.
	if ag_level = 1 and ln_cnt = ag_rows then
		l_tvi_new.label 		= "  "
		l_tvi_new.data 		= "END"
		l_tvi_new.expanded 	= false
		l_tvi_new.children 	= false
		l_tvi_new.SelectedPictureIndex 	= 3
		l_tvi_new.PictureIndex 				= 3
		ln_rtn 					= ag_this.InsertItemLast(ag_parent,l_tvi_new)
		ag_this.expandall(ln_rtn)
	else
		ln_rtn 					= wf_set_items(ag_Level, ln_Cnt, l_tvi_New , ag_parent, ag_this)
	end if
	if ln_rtn = -1 then
		return -1
	end if
Next
Return ag_Rows

end function

public function str_bomdata_info wf_get_bomdata (string a_plant, string a_div, string a_pitno, string a_citno, string a_date);str_bomdata_info a_str
string 	ls_midval
integer 	ln_cnt

select pwkct,pedtm,pedte 
	into :a_str.it_wkct,:a_str.it_edtm,:a_str.it_edte
from "PBPDM"."BOM999" a
where a.plant = :a_plant 	and
		a.pdvsn = :a_div 		and
		a.ppitn = :a_pitno 	and
		a.pcitn = :a_citno 	and 
		a.pchdt = :a_date 
using sqlca;
ls_midval = f_option_chk_after_901(a_plant,a_div,a_citno,is_Setdate) 
if f_spacechk(ls_midval) <> -1 then
	if ls_midval = a_citno then
		ls_midval = '*'
	end if
end if
a_str.it_opcd = ls_midval
return a_str
end function

private subroutine wf_itempopulate (long ag_handle, ref treeview ag_tvcurrent);Integer			ln_Level,ln_rows,ln_cnt
string			ls_Parm,ls_plant,ls_div,ls_itno,ls_choice,ls_rtncd
TreeViewItem	l_tvi_curset
Treeview			l_tv_current

SetPointer(HourGlass!)

// Determine the level
l_tv_current 	= ag_tvcurrent
ag_tvcurrent.GetItem(ag_handle,l_tvi_curset)
ln_level 		= l_tvi_curset.level
in_curlevel 	= ln_level
ls_parm 			= trim(mid(l_tvi_curset.data,1,12))
ls_rtncd 		= uo_1.uf_return()
ls_plant 		= mid(ls_rtncd,1,1)
ls_div 			= mid(ls_rtncd,2,1)
if ls_parm 		= "END" then
	return
end if
if rb_1.checked = true then
	ls_choice = trim(ddlb_choice.text)
	if trim(ls_choice) = "전체 전개" then
		if ln_level 				= 1 then
			is_div[ag_handle] 	= ls_div
			is_plant[ag_handle] 	= ls_plant
		end if
		ids_data1[ln_level].reset()
		ln_rows = ids_data1[ln_level].retrieve(is_plant[ag_handle],is_div[ag_handle],ls_parm,is_setdate)
		
		if ln_rows < 1 then
		else
			if ln_level = 1 then
				ln_rows 	= ln_rows + 1
			end if
			wf_add_items(ag_handle,ln_level,ln_rows,l_tv_current)
		end if			
	else
		if ln_level = 1 then
			is_div[ag_handle] 	= ls_div
			is_plant[ag_handle] 	= ls_plant
		end if
		ids_data1[ln_level].reset()
		ln_rows = ids_data1[ln_level].retrieve(ls_plant,ls_div,ls_parm,is_setdate)
	
		if ln_rows < 1 then
			//uo_status.st_message.text = f_message("M040")
		else
			if ln_level = 1 then
				ln_rows 	= ln_rows + 1
			end if
			wf_add_items(ag_handle,ln_level,ln_rows,l_tv_current)			
		end if	
	end if
end if



end subroutine

public subroutine wf_lvitempop (long ag_handle, ref treeview ag_tvcurrent, string ag_chk);integer 	ln_level,ln_cntdsp,ln_cntpart,ln_cntnum
long 		ln_curempty,ln_phandle,ln_itdvd,ln_qtym
dec{6} 	ld_wk_amt1,ld_wk_amt2,ld_wk_amt3
string 	ls_adddot
string 	ls_itno,ls_itnm,ls_div,ls_rtn,ls_unmsr,ls_chdt,ls_itno1      //tab_history.tabpage_indent.dw_indentlist에 쓰이는 변수
string 	ls_rvno,ls_spec,mod_string,ls_plant,ls_rtncd				 				//report에 쓰이는 변수
treeviewitem 		l_tvi_cur
s_invdata_info 	invdata
str_bomdata_info 	rtndata

ag_tvcurrent.getitem(ag_handle , l_tvi_cur)
ln_level = l_tvi_cur.level

ls_rtncd = uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div 	= mid(ls_rtncd,2,1)
ln_itdvd = 1

ls_itno 	= trim(mid(l_tvi_cur.data,1,12))
ls_chdt 	= mid(l_tvi_cur.data,13,8)

if ls_itno = "END" then
	return
end if
//check the div
if trim(ddlb_choice.text) = "전체 전개" then
	if ln_level = 1 then
		ls_div   = is_div[1]
		ls_plant = is_plant[1]
	else
		ls_div   = trim(is_div[ag_handle])
		ls_plant = trim(is_plant[ag_handle])
	end if
end if

if mid(is_setdate,1,6) >= mid(g_s_date,1,6) then
	invdata = f_bom_get_curinv(ls_plant,ls_div,ls_itno)
else
	invdata = f_bom_get_pastinv(ls_plant,ls_div,ls_itno,mid(is_setdate,1,4),integer(mid(is_setdate,5,2)))
end if

SELECT	"PBINV"."INV002"."SPEC",   
        	"PBINV"."INV002"."RVNO"  
	INTO	:ls_spec,   
	 		:ls_rvno  
FROM 		"PBINV"."INV002"  
WHERE ( 	"PBINV"."INV002"."COMLTD" 	= :g_s_company ) AND  
		( 	"PBINV"."INV002"."ITNO" 	= :ls_itno )   
using sqlca;
	
//get a itnm and unit of bom
ls_rtn 		= trim(f_bom_get_itemname(ls_itno))
ln_curempty = len(ls_rtn)
ls_itnm 		= mid(ls_rtn,1,(ln_curempty - 2))
ls_unmsr 	= right(ls_rtn,2)

if ln_level = 1 then
	ln_cntdsp = tab_history.tabpage_indent.dw_indentlist.insertrow(0)
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"lev", string((ln_level - 1)))
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itemno", ls_itno)
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itemnm", ls_itnm)
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itclsb", invdata.it_clsb)
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itsrce", invdata.it_srce)
	return
else
	ln_phandle 	= ag_tvcurrent.finditem(parenttreeitem!,ag_handle)
	ag_tvcurrent.getitem(ln_phandle,l_tvi_cur)
	ls_itno1 	= mid(l_tvi_cur.data,1,12)
	rtndata 		= wf_get_bomdata(ls_plant,ls_div,ls_itno1,ls_itno,ls_chdt)
end if

//Apply conversion factor
if invdata.it_iumcv <> 0 then
	invdata.it_ucav  = truncate(invdata.it_ucav / invdata.it_iumcv,6)
	invdata.it_imasa = truncate(invdata.it_imasa / invdata.it_iumcv,6)
	invdata.it_iucan = truncate(invdata.it_iucan / invdata.it_iumcv,6)
end if
//insert the item in datawindow tab_history.tabpage_indent.dw_indentlist,dw_mbom_report
ln_cntdsp 	= tab_history.tabpage_indent.dw_indentlist.insertrow(0)
ln_cntpart 	= tab_history.tabpage_partlist.dw_partlist.insertrow(0)
if f_spacechk(rtndata.it_opcd) <> -1 and trim(rtndata.it_opcd) <> '*' then
	if ln_level <= in_chk_level or f_spacechk(is_chk_option) = -1 then
		in_chk_level 	= ln_level
	end if
	is_chk_option 		= '*'
else
	if ln_level <= in_chk_level and (f_spacechk(rtndata.it_opcd) = -1 or trim(rtndata.it_opcd) = '*' ) then
		is_chk_option 	= ' '
	end if
end if

ls_adddot 		= ""
for ln_cntnum 	= 1 to (ln_level - 1)
	ls_adddot 	= ls_adddot + "."
next
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"lev", ls_adddot + string((ln_level - 1)))	

if invdata.it_ucav = 0 then
	invdata.it_ucav = truncate(invdata.it_iucan,6)
end if
if invdata.it_imasa = 0 and invdata.it_iucan <> 0 then
	invdata.it_imasa = truncate(invdata.it_iucan,6)
elseif invdata.it_imasa = 0 and invdata.it_iucan = 0 then
	invdata.it_imasa = truncate(invdata.it_ucav,6)
end if

if invdata.it_srce 	= '05' or invdata.it_srce = '03' or f_spacechk(invdata.it_srce) = -1  then
   invdata.it_ucav 	= 0 
	invdata.it_imasa 	= 0
	invdata.it_iucan 	= 0
end if
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itemno", ls_itno)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itrev", ls_rvno)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itemnm", ls_itnm)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itspec", ls_spec)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itunmsr", ls_unmsr)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itpqtym", id_set_pqtym[ag_handle])
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itiumcv", invdata.it_iumcv)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itclsb", invdata.it_clsb)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itsrce", invdata.it_srce)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itabc", invdata.it_iavcd)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itlot", invdata.it_lot)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itlead", invdata.it_lead)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itimasa", truncate(invdata.it_imasa,2))
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itprum", invdata.it_prum)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itucav", truncate(invdata.it_ucav,2))

ld_wk_amt1 = truncate(invdata.it_imasa * id_set_pqtym[ag_handle],3)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"issueamt", truncate(ld_wk_amt1,3))
ld_wk_amt2 = truncate(invdata.it_ucav * id_set_pqtym[ag_handle],3)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"moveamt", truncate(ld_wk_amt2,3) )

tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itiucan", truncate(invdata.it_iucan,2))
ld_wk_amt3 = truncate(invdata.it_iucan * id_set_pqtym[ag_handle],3)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"receiveamt", truncate(ld_wk_amt3,3) )
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itiucan",truncate(invdata.it_iucan,2))
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itwkct", rtndata.it_wkct)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itopcd", rtndata.it_opcd)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itedtm", rtndata.it_edtm)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"itedte", rtndata.it_edte)
tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"tvhandle", ag_handle)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itdvd", ln_itdvd)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"option_chk", ' ')
if invdata.it_srce = '03' or f_spacechk(invdata.it_srce) = -1 or rtndata.it_wkct = '8888' or invdata.it_clsb = '20' then
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"option_chk", '*')
	if rtndata.it_wkct = '8888' or invdata.it_clsb = '20' then
		ln_itdvd = 2
		tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itdvd", ln_itdvd)
		tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"option_chk", '*')
	end if
else
	tab_history.tabpage_indent.dw_indentlist.setitem(ln_cntdsp,"option_chk", is_chk_option)
end if
if is_chk_option = '*' then
	ln_itdvd = 2
	tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itdvd", ln_itdvd)
	tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"option_chk", '*')
end if
//set a data in bom_partlist
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itemno",ls_itno)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itrev", ls_rvno)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itemnm", ls_itnm)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itspec", ls_spec)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itunmsr", ls_unmsr)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itpqtym", id_set_pqtym[ag_handle])
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itiumcv", invdata.it_iumcv)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itprum", invdata.it_prum)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itclsb", invdata.it_clsb)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itsrce", invdata.it_srce)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itabc", invdata.it_iavcd)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itlot", invdata.it_lot)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itlead", invdata.it_lead)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itimasa", truncate(invdata.it_imasa,2))
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itucav", truncate(invdata.it_ucav,2))
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itwkct", rtndata.it_wkct)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itopcd", rtndata.it_opcd)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itedtm", rtndata.it_edtm)
tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itedte", rtndata.it_edte)
//재료비 계산 Logic	
if in_wkhold >= ln_level then																	//유상사급품제외
	if rtndata.it_wkct <> "8888" and invdata.it_clsb <> '20' then
		in_wkhold = 99
		if in_hold >= ln_level then																//호환부품번제외
			if trim(rtndata.it_opcd) = "" or trim(rtndata.it_opcd) = "*" then
				in_hold = 99
				choose case integer(invdata.it_clsb)
					case 10
						if invdata.it_srce = "02" or invdata.it_srce = "04"  then
							idc_ininv  	= idc_ininv  + ld_wk_amt2
							idc_inmasa 	= idc_inmasa + ld_wk_amt1
							idc_inucan 	= idc_inucan + ld_wk_amt3
						end if
						if invdata.it_srce ="01" then
							idc_outinv  = idc_outinv  + ld_wk_amt2
							idc_outmasa = idc_outmasa + ld_wk_amt1
							idc_outucan = idc_outucan + ld_wk_amt3
						end if
			
						if invdata.it_srce = '06' then
							idc_fosinv  = idc_fosinv  + ld_wk_amt2
							idc_fosmasa = idc_fosmasa + ld_wk_amt1
							idc_fosucan = idc_fosucan + ld_wk_amt3
						end if
					case 40 to 50
						if invdata.it_srce = "04"  then
							idc_osinv  	= idc_osinv  + ld_wk_amt2
							idc_osmasa 	= idc_osmasa + ld_wk_amt1
							idc_osucan 	= idc_osucan + ld_wk_amt3
						end if
				end choose
			else
				ln_itdvd = 2
				in_hold = ln_level
				tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itdvd", ln_itdvd)
				tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"option_chk", '*')
			end if
		else	
			if trim(rtndata.it_opcd) = "" or trim(rtndata.it_opcd) = "*" then
				//pass
			else
				ln_itdvd = 2
				tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"itdvd", ln_itdvd)
				tab_history.tabpage_partlist.dw_partlist.setitem(ln_cntpart,"option_chk", '*')
			end if
		end if
	else
		//조코드가 8888 즉 40/04 인 품번의 하위레벨CHECK
		in_wkhold = ln_level
	end if
end if

	

end subroutine

private function long wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew, long ag_phandle, ref treeview ag_this);// Set the Lable and Data attributes for the new item from the data in the DataStore
long		ln_check,ln_check1,ln_handle
dec{3} 	ld_pqtym
string 	ls_citno,ls_div,ls_plant,ls_curdiv,ls_chdt,ls_citno1,ls_choice,ls_rtncd
listviewitem l_lvi_cur

ls_rtncd	= uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div 	= mid(ls_rtncd,2,1)
ls_citno = trim(ids_data1[ag_level].object.pcitn[ag_row])
ls_chdt 	= trim(ids_data1[ag_level].object.pchdt[ag_row])	
//원단위수량계산
if ag_level = 1 then
	ld_pqtym = id_set_pqtym[1] * (ids_data1[ag_level].object.pqtym[ag_row])
else
	ld_pqtym = id_set_pqtym[ag_phandle] * (ids_data1[ag_level].object.pqtym[ag_row])
end if
ls_citno1 				= string(ls_citno,"@@@@@@@@@@@@")
ag_tvinew.data 		= ls_citno1	+ ls_chdt
ag_tvinew.expanded 	= true

select count(*) into :ln_check from "PBPDM"."BOM999" 
where ("PBPDM"."BOM999"."PPITN"= :ls_citno) AND
		("PBPDM"."BOM999"."PLANT"= :ls_plant) AND
		("PBPDM"."BOM999"."PDVSN"= :ls_div) AND
		(( trim("PBPDM"."BOM999"."PEDTE") =  ''  and "PBPDM"."BOM999"."PEDTM" <= :is_setdate ) or  
		(  trim("PBPDM"."BOM999"."PEDTE") <> ''  and "PBPDM"."BOM999"."PEDTM" <= :is_setdate  and "PBPDM"."BOM999"."PEDTE" >= :is_setdate ))
using sqlca;

if ln_check < 1 then
   ag_tvinew.children = false
else 
	ag_tvinew.children = true
end if
ag_tviNew.SelectedPictureIndex = 2
ag_tviNew.PictureIndex = 1
ln_handle = ag_this.InsertItemLast(ag_phandle,ag_tvinew)
	
if f_spacechk(ids_data1[ag_level].object.pexdv[ag_row]) <> -1 then
	is_plant[ln_handle] 		= ids_data1[ag_level].object.pexplant[ag_row]
	is_div[ln_handle] 		= ids_data1[ag_level].object.pexdv[ag_row]
else
	if is_plant[ag_phandle] <> ls_plant then
		is_div[ln_handle] 	= is_div[ag_phandle]
		is_plant[ln_handle] 	= is_plant[ag_phandle]
	else
		is_div[ln_handle] 	= ls_div
		is_plant[ln_handle] 	= ls_plant
	end if
end if

ag_this.expandall(ln_handle)
id_set_pqtym[ln_handle] 	= ld_pqtym
return ln_handle
end function

public subroutine wf_singlelevel_list (string a_plant, string a_div, string a_itno, string a_date);integer 	ln_rows,i,ln_curempty
string 	ls_itnm,ls_unmsr,ls_rvno,ls_spec,ls_itno,ls_rtn,ls_edtm,ls_edte,ls_wkct,ls_opcd
decimal 	ld_qtym
s_invdata_info invdata1
str_bomdata_info rtndata1

if rb_1.checked = true then
	ln_rows = ids_data3.retrieve(a_plant,a_div,a_itno,a_date)
	if ln_rows < 1 then
		uo_status.st_message.text = f_message("I020")
		return
	end if
	
   for i = 1 to ln_rows
		tab_history.tabpage_single.dw_single.insertrow(0)
		ls_itno = ids_data3.object.pcitn[i]
		ld_qtym = ids_data3.object.pqtym[i]
		ls_edtm = ids_data3.object.pedtm[i]
		ls_edte = ids_data3.object.pedte[i]
		ls_wkct = ids_data3.object.pwkct[i]
		 if mid(a_date,1,6) = mid(g_s_date,1,6) then
			invdata1 = f_bom_get_curinv(a_plant,a_div,ls_itno)
		else
			invdata1 = f_bom_get_pastinv(a_plant,a_div,ls_itno,mid(a_date,1,4),integer(mid(a_date,5,2)))
		end if
		
		SELECT	"PBINV"."INV002"."SPEC",   
         	 	"PBINV"."INV002"."RVNO"  
    		INTO 	:ls_spec,   
         	  	:ls_rvno  
		FROM 		"PBINV"."INV002"  
		WHERE ( 	"PBINV"."INV002"."COMLTD" 	= :g_s_company ) AND  
				( 	"PBINV"."INV002"."ITNO" 	= :ls_itno )   
		using sqlca;
			
		//get a itnm and unit of bom
		ls_rtn 		= trim(f_bom_get_itemname(ls_itno))
		ln_curempty = len(ls_rtn)
		ls_itnm 		= mid(ls_rtn,1,(ln_curempty - 2))
		ls_unmsr 	= right(ls_rtn,2)
		tab_history.tabpage_single.dw_single.setitem(i,"itemno", ls_itno)
		tab_history.tabpage_single.dw_single.setitem(i,"itemnm", ls_itnm)
		tab_history.tabpage_single.dw_single.setitem(i,"itclsb", invdata1.it_clsb)
		tab_history.tabpage_single.dw_single.setitem(i,"itsrce", invdata1.it_srce)
		if invdata1.it_iumcv <> 0 then
			invdata1.it_ucav  = truncate(invdata1.it_ucav / invdata1.it_iumcv,6)
			invdata1.it_imasa = truncate(invdata1.it_imasa / invdata1.it_iumcv,6)
			invdata1.it_iucan = truncate(invdata1.it_iucan / invdata1.it_iumcv,6)
		end if
		if invdata1.it_ucav = 0 then
			invdata1.it_ucav = truncate(invdata1.it_iucan,6)
		end if
		if invdata1.it_imasa = 0 and invdata1.it_iucan <> 0 then
			invdata1.it_imasa = truncate(invdata1.it_iucan,6)
		elseif invdata1.it_imasa = 0 and invdata1.it_iucan = 0 then
			invdata1.it_imasa = truncate(invdata1.it_ucav,6)
		end if
		
		tab_history.tabpage_single.dw_single.setitem(i,"itemno", ls_itno)
		tab_history.tabpage_single.dw_single.setitem(i,"itrev", ls_rvno)
		tab_history.tabpage_single.dw_single.setitem(i,"itemnm", ls_itnm)
		tab_history.tabpage_single.dw_single.setitem(i,"itspec", ls_spec)
		tab_history.tabpage_single.dw_single.setitem(i,"itunmsr", ls_unmsr)
		tab_history.tabpage_single.dw_single.setitem(i,"itpqtym", ld_qtym)
		tab_history.tabpage_single.dw_single.setitem(i,"itiumcv", invdata1.it_iumcv)
		tab_history.tabpage_single.dw_single.setitem(i,"itclsb", invdata1.it_clsb)
		tab_history.tabpage_single.dw_single.setitem(i,"itsrce", invdata1.it_srce)
		tab_history.tabpage_single.dw_single.setitem(i,"itabc", invdata1.it_iavcd)
		tab_history.tabpage_single.dw_single.setitem(i,"itlot", invdata1.it_lot)
		tab_history.tabpage_single.dw_single.setitem(i,"itlead", invdata1.it_lead)
		tab_history.tabpage_single.dw_single.setitem(i,"itimasa", truncate(invdata1.it_imasa,2))
		tab_history.tabpage_single.dw_single.setitem(i,"itprum", invdata1.it_prum)
		tab_history.tabpage_single.dw_single.setitem(i,"itucav", truncate(invdata1.it_ucav,2))
		//if mid(a_date,1,6) = mid(g_s_date,1,6) then
			tab_history.tabpage_single.dw_single.setitem(i,"itiucan", truncate(invdata1.it_iucan,2))
		//else
		//	tab_history.tabpage_single.dw_single.setitem(i,"itiucan", invdata1.it_ucav)
		//end if
		ls_opcd = f_option_chk_after_901(a_plant,a_div,ls_itno,a_date) 
		if f_spacechk(ls_opcd) <> -1 then
			if trim(ls_opcd) 	= trim(ls_itno) then
				ls_opcd 			= '*'
			end if
		end if
		if invdata1.it_clsb 	= '20' then
			ls_opcd 				= '저장품'
		end if
		tab_history.tabpage_single.dw_single.setitem(i,"itwkct", ls_wkct)
		tab_history.tabpage_single.dw_single.setitem(i,"itopcd", ls_opcd)
		tab_history.tabpage_single.dw_single.setitem(i,"itedtm", ls_edtm)
		tab_history.tabpage_single.dw_single.setitem(i,"itedte", ls_edte)
	next
else
	ln_rows = ids_data2.retrieve(a_plant,a_div,a_itno,a_date)
	if ln_rows < 1 then
		uo_status.st_message.text = f_message("I020")
		return
	end if
	ls_opcd 		= f_option_chk_after_901(a_plant,a_div,a_itno,a_date) 
	if ls_opcd 	<> '    ' then
		if ls_opcd = a_itno then
			ls_opcd = '*'
		end if
	end if
	for i = 1 to ln_rows
		tab_history.tabpage_single.dw_single.insertrow(0)
		ls_itno = ids_data2.object.ppitn[i]
		ld_qtym = ids_data2.object.pqtym[i]
		ls_edtm = ids_data2.object.pedtm[i]
		ls_edte = ids_data2.object.pedte[i]
		ls_wkct = ids_data2.object.pwkct[i]
		if mid(a_date,1,6) = mid(g_s_date,1,6) then
			invdata1 = f_bom_get_curinv(a_plant,a_div,ls_itno)
		else
			invdata1 = f_bom_get_pastinv(a_plant,a_div,ls_itno,mid(a_date,1,4),integer(mid(a_date,5,2)))
		end if
		
		SELECT 	"PBINV"."INV002"."SPEC",   
         	 	"PBINV"."INV002"."RVNO"  
  			INTO 	:ls_spec,   
         	  	:ls_rvno  
		FROM 		"PBINV"."INV002"  
		WHERE ( 	"PBINV"."INV002"."COMLTD" 	= :g_s_company ) AND  
				( 	"PBINV"."INV002"."ITNO" 	= :ls_itno )   
		using sqlca;
		//get a itnm and unit of bom
		ls_rtn 		= trim(f_bom_get_itemname(ls_itno))
		ln_curempty = len(ls_rtn)
		ls_itnm 		= mid(ls_rtn,1,(ln_curempty - 2))
		ls_unmsr 	= right(ls_rtn,2)
		if invdata1.it_clsb = '20' then
			ls_opcd 	= '저장품'
		end if
		tab_history.tabpage_single.dw_single.setitem(i,"itemno", ls_itno)
		tab_history.tabpage_single.dw_single.setitem(i,"itemnm", ls_itnm)
		tab_history.tabpage_single.dw_single.setitem(i,"itclsb", invdata1.it_clsb)
		tab_history.tabpage_single.dw_single.setitem(i,"itsrce", invdata1.it_srce)
		if invdata1.it_iumcv <> 0 then
			invdata1.it_ucav  = truncate(invdata1.it_ucav / invdata1.it_iumcv,6)
			invdata1.it_imasa = truncate(invdata1.it_imasa / invdata1.it_iumcv,6)
			invdata1.it_iucan = truncate(invdata1.it_iucan / invdata1.it_iumcv,6)
		end if
			
		if invdata1.it_ucav 	= 0 then
			invdata1.it_ucav 	= truncate(invdata1.it_iucan,6)
		end if
		if invdata1.it_imasa = 0 and invdata1.it_iucan <> 0 then
			invdata1.it_imasa = truncate(invdata1.it_iucan,6)
		elseif invdata1.it_imasa = 0 and invdata1.it_iucan = 0 then
			invdata1.it_imasa = truncate(invdata1.it_ucav,6)
		end if
		
		tab_history.tabpage_single.dw_single.setitem(i,"itemno", ls_itno)
		tab_history.tabpage_single.dw_single.setitem(i,"itrev", ls_rvno)
		tab_history.tabpage_single.dw_single.setitem(i,"itemnm", ls_itnm)
		tab_history.tabpage_single.dw_single.setitem(i,"itspec", ls_spec)
		tab_history.tabpage_single.dw_single.setitem(i,"itunmsr", ls_unmsr)
		tab_history.tabpage_single.dw_single.setitem(i,"itpqtym", ld_qtym)
		tab_history.tabpage_single.dw_single.setitem(i,"itiumcv", invdata1.it_iumcv)
		tab_history.tabpage_single.dw_single.setitem(i,"itclsb", invdata1.it_clsb)
		tab_history.tabpage_single.dw_single.setitem(i,"itsrce", invdata1.it_srce)
		tab_history.tabpage_single.dw_single.setitem(i,"itabc", invdata1.it_iavcd)
		tab_history.tabpage_single.dw_single.setitem(i,"itlot", invdata1.it_lot)
		tab_history.tabpage_single.dw_single.setitem(i,"itlead", invdata1.it_lead)
		tab_history.tabpage_single.dw_single.setitem(i,"itimasa", truncate(invdata1.it_imasa,2))
		tab_history.tabpage_single.dw_single.setitem(i,"itprum", invdata1.it_prum)
		tab_history.tabpage_single.dw_single.setitem(i,"itucav", truncate(invdata1.it_ucav,2))
		//if mid(a_date,1,6) = mid(g_s_date,1,6) then
			tab_history.tabpage_single.dw_single.setitem(i,"itiucan", truncate(invdata1.it_iucan,2))
		//else
		//	tab_history.tabpage_single.dw_single.setitem(i,"itiucan", invdata1.it_ucav)
		//end if
		tab_history.tabpage_single.dw_single.setitem(i,"itwkct", ls_wkct)
		tab_history.tabpage_single.dw_single.setitem(i,"itopcd", ls_opcd)
		tab_history.tabpage_single.dw_single.setitem(i,"itedtm", ls_edtm)
		tab_history.tabpage_single.dw_single.setitem(i,"itedte", ls_edte)
	next
end if

end subroutine

public subroutine wf_sort_partlist ();integer 	ln_cntx,ln_cnty,ln_cntrow,ln_currow
long 		ln_itdvdx,ln_itdvdy
dec{3} 	ld_pqtym
string 	ls_itno,ls_modelno,ls_itopcdx,ls_itopcdy

ln_currow = tab_history.tabpage_partlist.dw_partlist.rowcount()
//calculate pqtym at a same model and delete row of this model,호환품번 제거루틴
ln_cntx = 1
do
	ls_itno 		= tab_history.tabpage_partlist.dw_partlist.object.itemno[ln_cntx]
	ls_itopcdx 	= tab_history.tabpage_partlist.dw_partlist.object.itopcd[ln_cntx]
	ld_pqtym 	= tab_history.tabpage_partlist.dw_partlist.object.itpqtym[ln_cntx]
	ln_itdvdx 	= tab_history.tabpage_partlist.dw_partlist.object.itdvd[ln_cntx]
//	if ln_itdvd = 1 then
	for ln_cnty 	= ln_cntx + 1 to ln_currow
		ls_modelno 	= tab_history.tabpage_partlist.dw_partlist.object.itemno[ln_cnty]
		ls_itopcdy 	= tab_history.tabpage_partlist.dw_partlist.object.itopcd[ln_cnty]
		ln_itdvdy 	= tab_history.tabpage_partlist.dw_partlist.object.itdvd[ln_cnty]
		if ls_itno 	= ls_modelno and ln_itdvdx = ln_itdvdy and ls_itopcdx = ls_itopcdy  then
			ld_pqtym = tab_history.tabpage_partlist.dw_partlist.object.itpqtym[ln_cntx] &
						+ tab_history.tabpage_partlist.dw_partlist.object.itpqtym[ln_cnty]
			tab_history.tabpage_partlist.dw_partlist.object.itpqtym[ln_cntx] = ld_pqtym
			tab_history.tabpage_partlist.dw_partlist.object.itpqtym[ln_cnty] = 0
		end if
	next
//	end if
	ln_cntx = ln_cntx + 1
loop until ln_cntx > ln_currow

tab_history.tabpage_partlist.dw_partlist.setredraw( false)
tab_history.tabpage_partlist.dw_partlist.setfilter("itpqtym <> 0")
tab_history.tabpage_partlist.dw_partlist.filter()
tab_history.tabpage_partlist.dw_partlist.setsort("itdvd A,itclsb A,itsrce A,itemno A")
tab_history.tabpage_partlist.dw_partlist.sort()
tab_history.tabpage_partlist.dw_partlist.setredraw( true)
end subroutine

on w_bom901i.create
int iCurrent
call super::create
this.st_3=create st_3
this.sle_1=create sle_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_4=create st_4
this.em_1=create em_1
this.gb_divfind=create gb_divfind
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.sle_ininv=create sle_ininv
this.sle_outinv=create sle_outinv
this.sle_osinv=create sle_osinv
this.ddlb_choice=create ddlb_choice
this.dw_mbom_report=create dw_mbom_report
this.pb_1=create pb_1
this.st_8=create st_8
this.tab_history=create tab_history
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.gb_divfind
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.sle_ininv
this.Control[iCurrent+12]=this.sle_outinv
this.Control[iCurrent+13]=this.sle_osinv
this.Control[iCurrent+14]=this.ddlb_choice
this.Control[iCurrent+15]=this.dw_mbom_report
this.Control[iCurrent+16]=this.pb_1
this.Control[iCurrent+17]=this.st_8
this.Control[iCurrent+18]=this.tab_history
this.Control[iCurrent+19]=this.uo_1
end on

on w_bom901i.destroy
call super::destroy
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_4)
destroy(this.em_1)
destroy(this.gb_divfind)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.sle_ininv)
destroy(this.sle_outinv)
destroy(this.sle_osinv)
destroy(this.ddlb_choice)
destroy(this.dw_mbom_report)
destroy(this.pb_1)
destroy(this.st_8)
destroy(this.tab_history)
destroy(this.uo_1)
end on

event open;call super::open;long 		ln_root,ln_rows
integer 	ln_cnt
date 		ld_curdate
string 	ls_chgdate
treeviewitem l_tvi_root

setpointer(HourGlass!)

this.uo_status.st_winid.text 	= this.classname()
this.uo_status.st_kornm.text 	= g_s_kornm
this.uo_status.st_date.text 	= string(g_s_date, "@@@@-@@-@@")
ls_chgdate 	= string(g_s_date,"@@@@-@@-@@")
ld_curdate	= date(ls_chgdate)
em_1.text 	= string(ld_curdate,"yyyymmdd")
sle_1.setfocus()
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
i_b_insert = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)


end event

event close;call super::close;integer 	ln_cnt
for ln_cnt = 1 to 16
	destroy ids_Data1[ln_cnt] 
next
destroy ids_Data2
destroy ids_data3
end event

event ue_retrieve;Long				ln_Root,ln_tvi
integer			ln_cntnum = 0,ln_strnum	//초기화 변수
long           ln_rows,ln_cnt,ln_cnt1,ln_cnt2,ln_hdlf,ln_midsum ,ln_fihandle,ln_fhandle,ln_loopvar, &
					ln_loopvar1,ln_endhandle,ln_parent_handle[50,500],ln_itnolen,ln_itnmlen
string         ls_div,ls_pdcd,ls_pdcd1,ls_div1,ls_itno,root_data 
string         ls_plant,ls_itnm,ls_itclsb,ls_srce,mod_string,ls_rtncd
date           ld_refdate
TreeViewItem	l_tvi_Root
treeview       l_tv_cur

uo_status.st_message.text = ""
f_pism_working_msg(This.title,"BOM 정보를 조회중입니다. 잠시만 기다려 주십시오.") 

in_wkhold	= 99
in_hold 		= 99
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
if in_tabindex1 <> 3 then
   i_b_print 	= true
else
	i_b_print 	= false
end if
if in_first = 0 then
	for ln_cnt = 1 to 16
		ids_data1[ln_cnt] 				= create datastore
		ids_data1[ln_cnt].dataobject 	= "d_bom999_explo_03"
		ids_data1[ln_cnt].settransobject(sqlca)	
	next
	ids_data2 	= create datastore
	ids_data2.dataobject = "d_bom999_implo_03"
	ids_data3	= create datastore
	ids_data3.dataobject = "d_bom999_explo_03"
	ids_data2.settransobject(sqlca)	
	ids_data3.settransobject(sqlca)
	in_first		= 1
end if
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
ls_rtncd		= uo_1.uf_return()
ls_plant 	= mid(ls_rtncd,1,1)
ls_div 		= mid(ls_rtncd,2,1)
ls_pdcd  	= mid(ls_rtncd,3)
//ls_pdcd1  = trim(uo_1.dw_pdcd.gettext()) + "%"
ls_itno 		= upper(trim(sle_1.text))
ld_refdate 	= date(em_1.text)
is_setdate 	= f_dateedit(string(ld_refdate,"yyyy/mm/dd"))
if is_setdate = space(8) then
	uo_status.st_message.text = f_message("E290")
	em_1.backcolor = rgb(255,255,0)
	em_1.setfocus()
	If IsValid(w_pism_working) Then Close(w_pism_working)
	return 0
else
	em_1.backcolor = rgb(255,255,255)
end if
if f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = f_message("I020")
	sle_1.backcolor = rgb(255,255,0)
	sle_1.setfocus()
	If IsValid(w_pism_working) Then Close(w_pism_working)
	return 0
else
	sle_1.backcolor = rgb(255,255,255)
end if

SELECT 	"PBINV"."INV101"."PDCD"  
	INTO	:ls_pdcd1  
FROM 		"PBINV"."INV101"  
WHERE ( 	"PBINV"."INV101"."COMLTD" 	= :g_s_company ) 	AND  
		( 	"PBINV"."INV101"."XPLANT" 	= :ls_plant ) 		AND  
		( 	"PBINV"."INV101"."DIV" 		= :ls_div ) 		AND  
		( 	"PBINV"."INV101"."ITNO" 	= :ls_itno )   
using sqlca;

if f_spacechk(ls_pdcd1) = -1 then
	sle_1.backcolor = rgb(255,255,0)
	sle_1.setfocus()
	uo_status.st_message.text = f_message("E320")
	If IsValid(w_pism_working) Then Close(w_pism_working)
	return 0
else
	sle_1.backcolor = rgb(255,255,255)
end if
ls_pdcd1 = mid(ls_pdcd1,1,2)
uo_1.uf_set_pdcd(ls_pdcd1)
if in_tabindex1 = 3 then
	tab_history.tabpage_single.dw_single.reset()
	wf_singlelevel_list(ls_plant,ls_div,ls_itno,is_setdate)
	If IsValid(w_pism_working) Then Close(w_pism_working)
	return 0
end if
in_mid 		= 0
idc_ininv 	= 0
idc_outinv 	= 0
idc_osinv 	= 0
idc_fosinv 	= 0
idc_inmasa 	= 0
idc_outmasa = 0
idc_osmasa 	= 0
idc_fosmasa = 0
idc_inucan 	= 0
idc_outucan = 0
idc_fosucan = 0
idc_osucan 	= 0
in_hold 		= 99
in_wkhold 	= 99
sle_ininv.text		= ""
sle_outinv.text 	= ""
sle_osinv.text 	= ""
tab_history.tabpage_indent.tv_indent.DeleteItem(0)
tab_history.tabpage_indent.dw_indentlist.reset()
tab_history.tabpage_partlist.dw_partlist.reset()

l_tv_cur 	= tab_history.tabpage_indent.tv_indent
tab_history.tabpage_indent.tv_indent.indent = 95
id_set_pqtym[1] = 1.000

//tab_history.tabpage_indent.dw_indentlist.modify("itucav_t.text = '이동단가(" + mid(is_setdate,5,2) + ")'")
ls_itnm 		= trim(f_bom_get_itemname(ls_itno))
ln_itnolen 	= len(ls_itno)
ln_itnmlen 	= len(ls_itnm)
ls_itclsb 	= f_bom_get_itcls(ls_plant,ls_div,ls_itno)
ls_srce 		= f_bom_get_srce(ls_plant,ls_div,ls_itno)	
root_nm 		= ls_itno
root_data 	= ls_itno
l_tvi_Root.Label 			= root_nm 
l_tvi_root.data  			= root_data
l_tvi_Root.PictureIndex = 1

l_tvi_Root.SelectedPictureIndex = 2
l_tvi_Root.Children 	= True
l_tvi_Root.expanded 	= true
ln_Root 					= tab_history.tabpage_indent.tv_indent.InsertItemLast(0, l_tvi_Root)
tab_history.tabpage_indent.tv_indent.Expandall(ln_Root)
wf_itempopulate(ln_root, l_tv_cur)
ln_hdlf = tab_history.tabpage_indent.tv_indent.finditem(childtreeitem!,ln_root)
if ln_hdlf = -1 then
	uo_status.st_message.text = f_message("I020")
	If IsValid(w_pism_working) Then Close(w_pism_working)
	return 0
end if
for in_cnt = 1 to 16
	if in_cnt = 1 then
		ln_fhandle = ln_hdlf
		//lower item population logic
		do while true
        	wf_itempopulate(ln_hdlf,l_tv_cur)
			ln_midsum = tab_history.tabpage_indent.tv_indent.finditem(nexttreeitem!,ln_hdlf)
			if ln_midsum <> -1 then
				ln_hdlf = ln_midsum
			else
				exit
			end if
		loop
		// check the sibling item which has child
		ln_cntnum = 0
		do while true
			ln_loopvar = tab_history.tabpage_indent.tv_indent.finditem( childtreeitem!,ln_fhandle)
			if ln_loopvar <> -1 then
				do while true
					ln_cntnum = ln_cntnum + 1
					ln_parent_handle[1,ln_cntnum] = ln_loopvar
					ln_midsum = tab_history.tabpage_indent.tv_indent.finditem(nexttreeitem!,ln_loopvar)
					if ln_midsum = -1 then
						exit
					else
						ln_loopvar = ln_midsum
					end if
				loop
			end if
			ln_midsum = tab_history.tabpage_indent.tv_indent.finditem(nexttreeitem!,ln_fhandle)
			if ln_midsum <> -1 then
				ln_fhandle = ln_midsum
			else
				exit
			end if
		loop
		if ln_cntnum = 0 then
			tab_history.tabpage_indent.tv_indent.selectitem(ln_root)
			tab_history.tabpage_indent.tv_indent.setfocus()
			continue
		end if
	else
		ln_strnum = ln_cntnum
		//lower item population logic
		for ln_cnt1 = 1 to ln_strnum
			ln_fhandle =ln_parent_handle[in_cnt - 1,ln_cnt1]
			wf_itempopulate(ln_fhandle,l_tv_cur)
		next
		ln_cntnum = 0
		for ln_cnt1 = 1 to ln_strnum
			ln_fhandle = ln_parent_handle[in_cnt - 1,ln_cnt1]
			// check the number which has child
			ln_loopvar = tab_history.tabpage_indent.tv_indent.finditem( childtreeitem!,ln_fhandle)
			if ln_loopvar <> -1 then
				do while true
					ln_cntnum = ln_cntnum + 1
					ln_parent_handle[in_cnt,ln_cntnum] = ln_loopvar
					ln_midsum = tab_history.tabpage_indent.tv_indent.finditem(nexttreeitem!,ln_loopvar)
					if ln_midsum = -1 then
						exit
					else
						ln_loopvar = ln_midsum
					end if
				loop
			end if
	   next
		if ln_cntnum = 0 then
			tab_history.tabpage_indent.tv_indent.selectitem(ln_root)
			tab_history.tabpage_indent.tv_indent.setfocus()
			continue
		end if
	end if
next

//datawindow display logic
ln_fihandle = ln_Root
do while true
	wf_lvitempop(ln_fihandle,l_tv_cur,"V")
	ln_fhandle = tab_history.tabpage_indent.tv_indent.finditem(childtreeitem!,ln_fihandle)
	if ln_fhandle <> -1 then
		ln_fihandle = ln_fhandle
	else
		do while true
			ln_fhandle = tab_history.tabpage_indent.tv_indent.finditem(nexttreeitem!,ln_fihandle)
			if ln_fhandle <> -1 then
				ln_fihandle = ln_fhandle
				exit
			else
				do while true
					ln_fhandle = tab_history.tabpage_indent.tv_indent.finditem(parenttreeitem!,ln_fihandle)
					if ln_fhandle = 1 then
						sle_ininv.text 	= string(truncate(idc_ininv,0),"#,##0")
						sle_outinv.text 	= string(truncate(idc_outinv,0),"#,##0")
						sle_osinv.text 	= string(truncate(idc_osinv,0),"#,##0")
						wf_sort_partlist()
						uo_status.st_message.text = f_message("I010")
						If IsValid(w_pism_working) Then Close(w_pism_working)
						return 0
					else
						ln_fihandle = tab_history.tabpage_indent.tv_indent.finditem(nexttreeitem!,ln_fhandle)
						if ln_fihandle = -1 then
							ln_fihandle = ln_fhandle
						else
							exit
						end if
					end if
				loop
				exit
			end if
		loop
	end if
loop
If IsValid(w_pism_working) Then Close(w_pism_working)
return 0

end event

event ue_print;string 	ls_endcheck,mod_string,mod_costring
string 	ls_refdate,ls_divnm,ls_modelno,ls_itpdcd,ls_modelnm,ls_prtdate
string 	ls_plant,ls_div,ls_rtncd
integer 	ln_cntnum,ln_cntrow,ln_currow
long 		ln_fhandle,ln_fihandle,ln_handle
dec{0} 	ldc_total,ldc_total1,ldc_total2
treeviewitem l_tvi_cur
window 	l_to_open
str_easy l_str_prt
									
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
f_pism_working_msg(This.title,"BOM 정보를 출력준비중입니다. 잠시만 기다려 주십시오.") 

uo_status.st_message.Text = "출력 준비중 입니다..."

//create header string for modify in sharedata datawindow
ls_refdate		= 	string(mid(is_setdate,1,8),"@@@@.@@.@@")
ls_rtncd 		= 	uo_1.uf_return()
ls_plant 		= 	mid(ls_rtncd,1,1)
ls_div 			= 	mid(ls_rtncd,2,1)
ls_divnm 		= 	f_bom_get_divname(ls_plant,ls_div)
ln_handle 		= 	tab_history.tabpage_indent.tv_indent.finditem(roottreeitem!,0)
tab_history.tabpage_indent.tv_indent.GetItem(ln_handle, l_tvi_cur)
ls_modelno 		= 	trim(l_tvi_cur.data)
ls_itpdcd 		= 	mid(ls_rtncd,3)
ls_modelnm 		=	mid(f_bom_get_itemname(ls_modelno),1,30)
ls_prtdate 		= 	string(g_s_date,"@@@@.@@.@@")
mod_costring 	= "refdate_t.text = '" + ls_refdate +"'~tdivnm_t.text = '" + ls_divnm &
					+ "'~tmodelno_t.text = '" + ls_modelno + "'~titpdcd_t.text = '" + ls_itpdcd &
					+ "'~tprtdate_t.text = '" + ls_prtdate + "'"
if in_tabindex1 = 1 then
	dw_mbom_report.reset()
	dw_mbom_report.dataobject = "d_report_bomlist_901"
	ldc_total  	= truncate(idc_ininv,0)  + truncate(idc_outinv,0)  + truncate(idc_fosinv,0)
	ldc_total1 	= truncate(idc_inmasa,0) + truncate(idc_outmasa,0) + truncate(idc_fosmasa,0)
	ldc_total2 	= truncate(idc_inucan,0) + truncate(idc_outucan,0) + truncate(idc_fosucan,0)
	mod_string 	= mod_costring &
					+ "~tinucav_t.text = '" + string(truncate(idc_ininv,0),"#,##0") + "'~toutucav_t.text = '" + string(truncate(idc_outinv,0),"#,##0") +"'~t" &
					+ "fosucav_t.text = '" + string(truncate(idc_fosinv,0),"#,##0") + "'~ttotalucav_t.text = '" &
					+ string(truncate(ldc_total,0),"#,##0") + "'~tosucav_t.text = '" + string(truncate(idc_osinv,0),"#,##0") + "'~t" &
					+ "inmasa_t.text = '" + string(truncate(idc_inmasa,0),"#,##0") + "'~toutmasa_t.text = '" + string(truncate(idc_outmasa,0),"#,##0") +"'~t" &
					+ "fosmasa_t.text = '" + string(truncate(idc_fosmasa,0),"#,##0") + "'~ttotalmasa_t.text = '" &
					+ string(truncate(ldc_total1,0),"#,##0") + "'~tosmasa_t.text = '" + string(truncate(idc_osmasa,0),"#,##0") + "'~t" &
					+ "inucan_t.text = '" + string(truncate(idc_inucan,0),"#,##0") + "'~toutucan_t.text = '" + string(truncate(idc_outucan,0),"#,##0") +"'~t" &
					+ "fosucan_t.text = '" + string(truncate(idc_fosucan,0),"#,##0") + "'~ttotalucan_t.text = '" &
					+ string(truncate(ldc_total2,0),"#,##0") + "'~tosucan_t.text = '" + string(truncate(idc_osucan,2),"#,##0") + "'~tmodelnm_t.text = '" + ls_modelnm + "'"
	ln_cntrow 	= tab_history.tabpage_indent.dw_indentlist.rowcount()
	for ln_cntnum = 2 to ln_cntrow
		ln_currow 												= dw_mbom_report.insertrow(0)
		dw_mbom_report.object.lev[ln_currow] 			= right(tab_history.tabpage_indent.dw_indentlist.object.lev[ln_cntnum],6)
		dw_mbom_report.object.itemno[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itemno[ln_cntnum]
		dw_mbom_report.object.itrev[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itrev[ln_cntnum]
		dw_mbom_report.object.itemnm[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itemnm[ln_cntnum]
		dw_mbom_report.object.itspec[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itspec[ln_cntnum]
		dw_mbom_report.object.itunmsr[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itunmsr[ln_cntnum]
		dw_mbom_report.object.itpqtym[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itpqtym[ln_cntnum]
		dw_mbom_report.object.itiumcv[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itiumcv[ln_cntnum]
		dw_mbom_report.object.itprum[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itprum[ln_cntnum]
		dw_mbom_report.object.itclsb[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itclsb[ln_cntnum]
		dw_mbom_report.object.itsrce[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itsrce[ln_cntnum]
		dw_mbom_report.object.itabc[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itabc[ln_cntnum]
//		dw_mbom_report.object.itlot[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itlot[ln_cntnum]
//		dw_mbom_report.object.itlead[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itlead[ln_cntnum]
		dw_mbom_report.object.itimasa[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itimasa[ln_cntnum]
		dw_mbom_report.object.itucav[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itucav[ln_cntnum]
		dw_mbom_report.object.itiucan[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itiucan[ln_cntnum]
		dw_mbom_report.object.itwkct[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itwkct[ln_cntnum]
		dw_mbom_report.object.itopcd[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itopcd[ln_cntnum]
		dw_mbom_report.object.issueamt[ln_currow] 	= tab_history.tabpage_indent.dw_indentlist.object.issueamt[ln_cntnum]
		dw_mbom_report.object.moveamt[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.moveamt[ln_cntnum]
		dw_mbom_report.object.receiveamt[ln_currow] 	= tab_history.tabpage_indent.dw_indentlist.object.receiveamt[ln_cntnum]
//		dw_mbom_report.object.danga_chk[ln_currow] 	= tab_history.tabpage_indent.dw_indentlist.object.danga_chk[ln_cntnum]
//		dw_mbom_report.object.itedtm[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itedtm[ln_cntnum]
//		dw_mbom_report.object.itedte[ln_currow] 		= tab_history.tabpage_indent.dw_indentlist.object.itedte[ln_cntnum]
		if tab_history.tabpage_indent.dw_indentlist.object.option_chk[ln_cntnum] = '*'	then
			dw_mbom_report.object.itoption[ln_currow]	= 'X'
		else
			dw_mbom_report.object.itoption[ln_currow] = ' '
		end if
	next
else
	dw_mbom_report.reset()
	dw_mbom_report.dataobject = "d_report_partlist_901"
	mod_string 	= mod_costring
	ln_cntrow 	= tab_history.tabpage_partlist.dw_partlist.rowcount()
	for ln_cntnum = 1 to ln_cntrow
		ln_currow 												= dw_mbom_report.insertrow(0)
		dw_mbom_report.object.itemno[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itemno[ln_cntnum]
		dw_mbom_report.object.itrev[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itrev[ln_cntnum]
		dw_mbom_report.object.itemnm[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itemnm[ln_cntnum]
		dw_mbom_report.object.itspec[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itspec[ln_cntnum]
		dw_mbom_report.object.itunmsr[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itunmsr[ln_cntnum]
		dw_mbom_report.object.itpqtym[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itpqtym[ln_cntnum]
		dw_mbom_report.object.itiumcv[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itiumcv[ln_cntnum]
		dw_mbom_report.object.itprum[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itprum[ln_cntnum]
		dw_mbom_report.object.itclsb[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itclsb[ln_cntnum]
		dw_mbom_report.object.itsrce[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itsrce[ln_cntnum]
		dw_mbom_report.object.itabc[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itabc[ln_cntnum]
		dw_mbom_report.object.itlot[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itlot[ln_cntnum]
		dw_mbom_report.object.itlead[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itlead[ln_cntnum]
		dw_mbom_report.object.itimasa[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itimasa[ln_cntnum]
		dw_mbom_report.object.itucav[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itucav[ln_cntnum]
		dw_mbom_report.object.itiucan[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itiucan[ln_cntnum]
		dw_mbom_report.object.itwkct[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itwkct[ln_cntnum]
		dw_mbom_report.object.itopcd[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itopcd[ln_cntnum]
		dw_mbom_report.object.itedtm[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itedtm[ln_cntnum]
		dw_mbom_report.object.itedte[ln_currow] 		= tab_history.tabpage_partlist.dw_partlist.object.itedte[ln_cntnum]
		if tab_history.tabpage_partlist.dw_partlist.object.option_chk[ln_cntnum] = '*'	then
			dw_mbom_report.object.itoption[ln_currow] = 'X'
		else
			dw_mbom_report.object.itoption[ln_currow] = ' '
		end if
	next
end if
			
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  	= sqlca
l_str_prt.datawindow   	= dw_mbom_report
l_str_prt.title 			= "MBOM REPORT 화면"
l_str_prt.dwsyntax 		= mod_string
l_str_prt.tag			  	= This.ClassName()
If IsValid(w_pism_working) Then Close(w_pism_working)	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""	
return 0
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom901i
end type

type st_3 from statictext within w_bom901i
integer x = 41
integer y = 152
integer width = 137
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
string text = "품번"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_bom901i
event ue_slekeydown pbm_keydown
integer x = 197
integer y = 144
integer width = 512
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_bom901i
integer x = 3401
integer y = 84
integer width = 389
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
string text = "하위 조회"
boolean checked = true
end type

type rb_2 from radiobutton within w_bom901i
integer x = 3401
integer y = 144
integer width = 389
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
boolean enabled = false
string text = "상위 조회"
end type

type st_4 from statictext within w_bom901i
boolean visible = false
integer x = 2519
integer y = 44
integer width = 279
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
string text = "기준일자"
boolean focusrectangle = false
end type

type em_1 from editmask within w_bom901i
event ue_keydown pbm_keydown
boolean visible = false
integer x = 2802
integer y = 28
integer width = 416
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
boolean autoskip = true
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type gb_divfind from groupbox within w_bom901i
integer x = 3374
integer y = 28
integer width = 430
integer height = 212
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회구분"
end type

type st_5 from statictext within w_bom901i
integer x = 3817
integer y = 48
integer width = 261
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
string text = "내   자"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_bom901i
integer x = 3817
integer y = 116
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "외   자"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_bom901i
integer x = 3826
integer y = 184
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "외주사급"
boolean focusrectangle = false
end type

type sle_ininv from singlelineedit within w_bom901i
integer x = 4082
integer y = 36
integer width = 507
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
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type sle_outinv from singlelineedit within w_bom901i
integer x = 4082
integer y = 104
integer width = 507
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
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type sle_osinv from singlelineedit within w_bom901i
integer x = 4082
integer y = 172
integer width = 507
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
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type ddlb_choice from dropdownlistbox within w_bom901i
integer x = 1586
integer y = 140
integer width = 489
integer height = 336
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
string text = "전체 전개"
boolean sorted = false
string item[] = {"전체 전개","공장별 전개"}
borderstyle borderstyle = stylelowered!
end type

type dw_mbom_report from datawindow within w_bom901i
boolean visible = false
integer x = 2112
integer y = 136
integer width = 215
integer height = 88
integer taborder = 70
string title = "none"
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_bom901i
integer x = 837
integer y = 136
integer width = 238
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_parm, ls_plant,ls_div, ls_pdcd, ls_rtncd

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= mid(ls_rtncd,1,1)
ls_div 		= mid(ls_rtncd,2,1)
ls_pdcd  	= trim(mid(ls_rtncd,3))
ls_parm 		= ls_plant + ls_div + ls_pdcd
openwithparm(w_bom110u_res_03,ls_parm)
ls_parm 		= message.stringparm
sle_1.text 	= ls_parm

end event

type st_8 from statictext within w_bom901i
integer x = 1271
integer y = 156
integer width = 274
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
string text = "전개구분"
boolean focusrectangle = false
end type

type tab_history from tab within w_bom901i
integer x = 27
integer y = 260
integer width = 4562
integer height = 2216
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_indent tabpage_indent
tabpage_partlist tabpage_partlist
tabpage_single tabpage_single
end type

on tab_history.create
this.tabpage_indent=create tabpage_indent
this.tabpage_partlist=create tabpage_partlist
this.tabpage_single=create tabpage_single
this.Control[]={this.tabpage_indent,&
this.tabpage_partlist,&
this.tabpage_single}
end on

on tab_history.destroy
destroy(this.tabpage_indent)
destroy(this.tabpage_partlist)
destroy(this.tabpage_single)
end on

event selectionchanged;window ls_wsheet

in_tabindex1 	= newindex
i_b_print 		= true
i_b_dprint 		= false
if in_tabindex1 = 3 then
	i_b_print 		= false	
	rb_2.visible 	= true
	rb_2.enabled 	= true
   if f_spacechk(sle_1.text) <> -1  then
		tab_history.tabpage_single.dw_single.reset()
		ls_wsheet = w_frame.GetActiveSheet()
		ls_wsheet.TriggerEvent("ue_retrieve")
	end if
else
	rb_2.visible 	= false
	rb_2.enabled 	= false
	rb_2.checked 	= false
	rb_1.checked 	= true
end if
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)

end event

type tabpage_indent from userobject within tab_history
integer x = 18
integer y = 100
integer width = 4526
integer height = 2100
long backcolor = 12632256
string text = "Indented BOM"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_indentlist dw_indentlist
tv_indent tv_indent
end type

on tabpage_indent.create
this.dw_indentlist=create dw_indentlist
this.tv_indent=create tv_indent
this.Control[]={this.dw_indentlist,&
this.tv_indent}
end on

on tabpage_indent.destroy
destroy(this.dw_indentlist)
destroy(this.tv_indent)
end on

type dw_indentlist from datawindow within tabpage_indent
integer y = 8
integer width = 4512
integer height = 2088
integer taborder = 40
string dataobject = "d_bom001_901i_listview"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tv_indent from treeview within tabpage_indent
event ue_tvvscroll pbm_vscroll
boolean visible = false
integer x = 965
integer y = 548
integer width = 146
integer height = 152
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
integer indent = 1
boolean disabledragdrop = false
boolean tooltips = false
string picturename[] = {"Custom039!","Custom050!","Exit!","","","","","","","","","","","","",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type tabpage_partlist from userobject within tab_history
integer x = 18
integer y = 100
integer width = 4526
integer height = 2100
long backcolor = 12632256
string text = "Part List"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_partlist dw_partlist
end type

on tabpage_partlist.create
this.dw_partlist=create dw_partlist
this.Control[]={this.dw_partlist}
end on

on tabpage_partlist.destroy
destroy(this.dw_partlist)
end on

type dw_partlist from datawindow within tabpage_partlist
integer x = 5
integer y = 8
integer width = 4494
integer height = 2080
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom001_901i_partlist"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_single from userobject within tab_history
integer x = 18
integer y = 100
integer width = 4526
integer height = 2100
long backcolor = 12632256
string text = "Single Level"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_single dw_single
end type

on tabpage_single.create
this.dw_single=create dw_single
this.Control[]={this.dw_single}
end on

on tabpage_single.destroy
destroy(this.dw_single)
end on

type dw_single from datawindow within tabpage_single
integer y = 8
integer width = 4507
integer height = 2080
integer taborder = 20
string title = "none"
string dataobject = "d_bom001_901i_singlelevel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_plandiv_pdcd within w_bom901i
integer x = 46
integer y = 4
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

