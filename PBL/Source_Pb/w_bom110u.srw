$PBExportHeader$w_bom110u.srw
$PBExportComments$M-BOM Update
forward
global type w_bom110u from w_origin_sheet01
end type
type tv_bom from treeview within w_bom110u
end type
type st_3 from statictext within w_bom110u
end type
type sle_1 from singlelineedit within w_bom110u
end type
type cb_insert from commandbutton within w_bom110u
end type
type cb_edit from commandbutton within w_bom110u
end type
type cb_impcopy from commandbutton within w_bom110u
end type
type cb_delete from commandbutton within w_bom110u
end type
type cb_expcopy from commandbutton within w_bom110u
end type
type dw_edit from datawindow within w_bom110u
end type
type rb_1 from radiobutton within w_bom110u
end type
type rb_2 from radiobutton within w_bom110u
end type
type cb_retrieve from commandbutton within w_bom110u
end type
type cb_save from commandbutton within w_bom110u
end type
type pb_find from picturebutton within w_bom110u
end type
type gb_2 from groupbox within w_bom110u
end type
type gb_framemove from groupbox within w_bom110u
end type
type dw_explo from datawindow within w_bom110u
end type
type dw_implo from datawindow within w_bom110u
end type
type uo_plant from uo_plandiv_pdcd within w_bom110u
end type
type cb_filter from commandbutton within w_bom110u
end type
type st_1 from statictext within w_bom110u
end type
type cb_change from commandbutton within w_bom110u
end type
type st_2 from statictext within w_bom110u
end type
type cb_pl from commandbutton within w_bom110u
end type
type st_4 from statictext within w_bom110u
end type
type gb_1 from groupbox within w_bom110u
end type
end forward

global type w_bom110u from w_origin_sheet01
string title = "M-BOM 등록"
boolean minbox = false
tv_bom tv_bom
st_3 st_3
sle_1 sle_1
cb_insert cb_insert
cb_edit cb_edit
cb_impcopy cb_impcopy
cb_delete cb_delete
cb_expcopy cb_expcopy
dw_edit dw_edit
rb_1 rb_1
rb_2 rb_2
cb_retrieve cb_retrieve
cb_save cb_save
pb_find pb_find
gb_2 gb_2
gb_framemove gb_framemove
dw_explo dw_explo
dw_implo dw_implo
uo_plant uo_plant
cb_filter cb_filter
st_1 st_1
cb_change cb_change
st_2 st_2
cb_pl cb_pl
st_4 st_4
gb_1 gb_1
end type
global w_bom110u w_bom110u

type variables
datawindowchild		idwc_child
datastore 			ids_data1[],ids_data2[], ids_data3
treeviewitem 			i_tvi_drag_object, i_tvi_drag_parent
string 					root_nm , is_sel
integer 				in_pos, is_populate_no, is_populate,in_first
decimal 				in_tm
long    				ii_LastRow

end variables

forward prototypes
public subroutine wf_item_clear ()
public subroutine wf_add_picture (treeview ag_tvcurrent)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
public subroutine wf_history_update_01 (string a_plant, string a_div, string a_ppitno, string a_pcitno, string a_pchdt, string a_pedtm, string a_pedte)
public subroutine wf_option_update (string a_plant, string a_div, string a_first_itno, string a_second_itno, string a_update_code, string a_from_date, string a_to_date)
public function integer wf_history_update (string a_plant, string a_div, string a_ppitno, string a_pcitno, string a_chkdate)
public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew)
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public subroutine wf_rgbclear ()
public function boolean wf_emp_chk ()
end prototypes

public subroutine wf_item_clear ();
end subroutine

public subroutine wf_add_picture (treeview ag_tvcurrent);ag_tvcurrent.PictureHeight = 15
ag_tvcurrent.PictureWidth = 16

ag_tvcurrent.AddPicture("Library!")
ag_tvcurrent.AddPicture("DosEdit!")
ag_tvcurrent.AddPicture("Custom050!")
ag_tvcurrent.AddStatePicture("Save!")

end subroutine

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			ln_Level, ln_rows
string				ls_Parm , ls_div, ls_plant, ls_rtncd
Treeview			l_tv_current
TreeViewItem		l_tvi_Current

SetPointer(HourGlass!)
// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)

ln_Level 	=	l_tvi_Current.Level

ls_rtncd 	=	uo_plant.uf_return()
ls_plant 	=	mid(ls_rtncd,1,1)
ls_div 		=	mid(ls_rtncd,2,1)
// Determine the Retrieval arguments for the new data
// if ln_level <> 1 and rb_2.checked = true then
if rb_2.checked = true then
	ids_data2[ln_level].reset()
	ln_rows = ids_data2[ln_level].retrieve(ls_plant,ls_div,l_tvi_current.data, g_s_date)
	if ln_rows > 0 then
		wf_add_items(ag_handle,ln_level,ln_rows,ag_tvcurrent)
	end if
end if
// if ln_level <> 1 and rb_1.checked = true then
if rb_1.checked = true then	
	ids_data1[ln_level].reset()
	ln_rows = ids_data1[ln_level].retrieve(ls_plant,ls_div,l_tvi_current.data, g_s_date)
	if ln_rows > 0 then
		wf_add_items(ag_handle,ln_level,ln_rows,ag_tvcurrent)
	end if
 end if


end subroutine

public subroutine wf_history_update_01 (string a_plant, string a_div, string a_ppitno, string a_pcitno, string a_pchdt, string a_pedtm, string a_pedte);string ls_chdt, ls_pedte, ls_pedtm, ls_div , ls_ppitn , ls_pcitn , ls_plant
string ls_chk_date

ls_div 		= 	trim(a_div)
ls_plant 	= 	trim(a_plant)
ls_ppitn 	= 	trim(a_ppitno)
ls_pcitn 	= 	trim(a_pcitno)

update PBPDM.bom001 set pedte = :a_pedte 
	where plant = :ls_plant and pdvsn = :ls_div and pcmcd = '01' and 
			ppitn = :ls_ppitn and pcitn = :ls_pcitn and pchdt = :a_pchdt 
using sqlca;
if sqlca.sqlcode = 0 then
	commit using sqlca;
end if

select 	"PBPDM"."BOM001"."PCHDT", "PBPDM"."BOM001"."PEDTE","PBPDM"."BOM001"."PEDTM"  into :ls_chdt,:ls_pedte,:ls_pedtm from "PBPDM"."BOM001"
where 	"PBPDM"."BOM001"."PCMCD" = '01' and 
			"PBPDM"."BOM001"."PCITN" = :ls_pcitn and 
			"PBPDM"."BOM001"."PPITN" = :ls_ppitn and
	  		"PBPDM"."BOM001"."PLANT" = :ls_plant AND "PBPDM"."BOM001"."PDVSN" = :ls_div AND 
	  		(( "PBPDM"."BOM001"."PEDTE" = '' ) OR  
	  		( "PBPDM"."BOM001"."PEDTE" <> '' AND "PBPDM"."BOM001"."PEDTM" > :a_pedtm and
			"PBPDM"."BOM001"."PEDTE" >= :g_s_date AND  "PBPDM"."BOM001"."PEDTE" >= "PBPDM"."BOM001"."PEDTM"))   
order by "PBPDM"."BOM001"."PEDTM" , "PBPDM"."BOM001"."PEDTE" asc 
using SQLCA ;
if sqlca.sqlcode = 0 then
	ls_chk_date = f_relativedate(a_pedte, 1)
	if ls_pedtm <> ls_chk_date then	 
		update PBPDM.bom001 set pedtm = :ls_chk_date 
		where pcmcd = '01' and
				plant = :ls_plant and 
				pdvsn = :a_div and 
				ppitn = :a_ppitno and pcitn = :a_pcitno and pchdt = :ls_chdt 
		using sqlca;
		if sqlca.sqlcode = 0 then
		   commit using sqlca;
		end if
	end if
end if

delete from PBPDM.bom001
  where  	pcmcd = '01' and
  			plant = :ls_plant and 
  			pdvsn = :ls_div and 
  			ppitn = :ls_ppitn and pcitn = :ls_pcitn and pchdt = :g_s_date and
        		( pedte <> '' and pedtm <> '' and pedtm > pedte )
using sqlca ;
if sqlca.sqlcode = 0 then
	commit using sqlca;
end if
end subroutine

public subroutine wf_option_update (string a_plant, string a_div, string a_first_itno, string a_second_itno, string a_update_code, string a_from_date, string a_to_date);string ls_citno,ls_cedtm,ls_cedte,ls_chk_citno[]
integer i,j,k

if a_update_code = 'D' then
	UPDATE 	"PBPDM"."BOM003"
		SET 	"OEDTE" = :g_s_date,
				"OCHCD" = :a_update_code 
		WHERE "PBPDM"."BOM003"."OCMCD" 	= '01' AND
				"PBPDM"."BOM003"."OPLANT" 	= :a_plant AND
				"PBPDM"."BOM003"."ODVSN" 	= :a_div AND
				"PBPDM"."BOM003"."OPITN"	= :a_second_itno  and	
			( 	"PBPDM"."BOM003"."OEDTE" 	= '' OR "PBPDM"."BOM003"."OEDTE" >= :a_to_date )
		using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return
	else
		commit using sqlca;
	end if
	UPDATE 	"PBPDM"."BOM003"
		SET 	"OEDTE"= :g_s_date,"OCHCD" = :a_update_code 
	WHERE 	"PBPDM"."BOM003"."OCMCD" 	= '01' AND
				"PBPDM"."BOM003"."OPLANT" 	= :a_plant AND
				"PBPDM"."BOM003"."ODVSN" 	= :a_div AND	
				"PBPDM"."BOM003"."OFITN" 	= :a_second_itno  and
			( 	"PBPDM"."BOM003"."OEDTE" 	= '' OR "PBPDM"."BOM003"."OEDTE" >= :a_to_date )
	using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return
	else
		commit using sqlca;
	end if
else
	declare optchk_cur_01 cursor for 
		select 	"PBPDM"."BOM003"."OEDTM", "PBPDM"."BOM003"."OEDTE" from "PBPDM"."BOM003"
		  where 	"PBPDM"."BOM003"."OCMCD" 	= '01' 				and
		  			"PBPDM"."BOM003"."OPITN" 	= :a_first_itno 	and 
		  			"PBPDM"."BOM003"."OFITN" 	= :a_second_itno 	and
				   "PBPDM"."BOM003"."ODVSN" 	= :a_div 			and
				 	"PBPDM"."BOM003"."OPLANT" 	= :a_plant 			and
				 ( "PBPDM"."BOM003"."OEDTE" 	= ''  				or  
				 	"PBPDM"."BOM003"."OEDTE" 	>= :g_s_date )
	using SQLCA ;
	j = 0 
	open optchk_cur_01 ;
		do while true
			fetch optchk_cur_01 into :ls_cedtm,:ls_cedte ;
			if sqlca.sqlcode <> 0 then
				exit
			end if
			j = j + 1
			if j = 1 and ls_cedtm <> a_from_date and ls_cedtm > g_s_date then
				UPDATE 	"PBPDM"."BOM003"
					SET 	"OEDTM"	= :a_from_date, "OCHCD" 	= :a_update_code 
				WHERE 	"PBPDM"."BOM003"."OCMCD" 	= '01' and
							"PBPDM"."BOM003"."OPLANT" 	= :a_plant and
							"PBPDM"."BOM003"."ODVSN" 	= :a_div and	
							"PBPDM"."BOM003"."OPITN" 	= :a_first_itno and
							"PBPDM"."BOM003"."OFITN" 	= :a_second_itno  and
							"PBPDM"."BOM003"."OEDTM" 	= :ls_cedtm and 
							"PBPDM"."BOM003"."OEDTE" 	= :ls_cedte
				using sqlca;
				if sqlca.sqlcode = 0 then
					commit using sqlca;
				end if
			end if
			if ( ls_cedte <> a_to_date and  ls_cedte > a_to_date ) &
				 or ( ls_cedte <> a_to_date and f_spacechk(ls_cedte) = -1 ) then
				UPDATE 	"PBPDM"."BOM003"
					SET 	"OEDTE"	= :a_to_date, "OCHCD" = :a_update_code 
				WHERE 	"PBPDM"."BOM003"."OCMCD" 	= '01' and
							"PBPDM"."BOM003"."OPLANT" 	= :a_plant and
							"PBPDM"."BOM003"."ODVSN" 	= :a_div and	
							"PBPDM"."BOM003"."OPITN" 	= :a_first_itno and
							"PBPDM"."BOM003"."OFITN" 	= :a_second_itno  and
							"PBPDM"."BOM003"."OEDTM" 	= :ls_cedtm and 
							"PBPDM"."BOM003"."OEDTE" 	= :ls_cedte
				using sqlca;
				if sqlca.sqlcode = 0 then
					commit using sqlca;
				end if
			end if
		loop
	close optchk_cur_01 ;
end if
end subroutine

public function integer wf_history_update (string a_plant, string a_div, string a_ppitno, string a_pcitno, string a_chkdate);string 	ls_chdt, ls_pedte, ls_pedtm, ls_div ,ls_plant , ls_ppitn , ls_pcitn 
integer 	k 
string 	ls_chk_edtm[], ls_chk_edte[], ls_chk_chdt[], ls_chk_date
k 			= 0
ls_div 	= trim(a_div)
ls_plant = trim(a_plant)
ls_ppitn = trim(a_ppitno)
ls_pcitn = trim(a_pcitno) 
declare bomchk_cur cursor for 
  select "PBPDM"."BOM001"."PCHDT", "PBPDM"."BOM001"."PEDTE","PBPDM"."BOM001"."PEDTM"  from "PBPDM"."BOM001"
     where 	"PBPDM"."BOM001"."PCMCD" 	= '01' 			and
	  			"PBPDM"."BOM001"."PCITN" 	= :ls_pcitn 	and 
	  			"PBPDM"."BOM001"."PPITN" 	= :ls_ppitn 	and
	  			"PBPDM"."BOM001"."PLANT" 	= :ls_plant 	and
	         		"PBPDM"."BOM001"."PDVSN" 	= :ls_div 		and
         			(( 	"PBPDM"."BOM001"."PEDTE" 	= '' ) 			or  
         			( 	"PBPDM"."BOM001"."PEDTE" 	<> '' 			and
         				"PBPDM"."BOM001"."PEDTE" 	>= :g_s_date 	and  "PBPDM"."BOM001"."PEDTE" >= "PBPDM"."BOM001"."PEDTM"))     
		order by "PBPDM"."BOM001"."PEDTM" , "PBPDM"."BOM001"."PEDTE" asc 
     using SQLCA ;

open bomchk_cur ;
  do while true
	fetch bomchk_cur into :ls_chdt,:ls_pedte,:ls_pedtm ;
	if sqlca.sqlcode <> 0 then
		exit
	end if
	if f_spacechk(ls_pedte) <> -1 and ls_pedte < ls_pedtm then
		delete from "PBPDM"."BOM001" 
		where "PBPDM"."BOM001"."PCMCD" 	= '01' and
				"PBPDM"."BOM001"."PCITN" 	= :ls_pcitn and 
				"PBPDM"."BOM001"."PPITN" 	= :ls_ppitn and
	         		"PBPDM"."BOM001"."PDVSN" 	= :ls_div AND  "PBPDM"."BOM001"."PLANT" = :ls_plant and
				"PBPDM"."BOM001"."PCHDT" 	= :g_s_date and
				"PBPDM"."BOM001"."PEDTM" 	= :ls_pedtm and "PBPDM"."BOM001"."PEDTE" = :ls_pedte
		using sqlca;
		if sqlca.sqlcode = 0 then
		   commit using sqlca;
		end if
	end if
	
	k = k + 1
	ls_chk_edtm[k] = ls_pedtm
	ls_chk_edte[k] = ls_pedte
	ls_chk_chdt[k] = ls_chdt
	if k <> 1 then
		if f_spacechk(ls_chk_edte[k - 1]) = -1 then
			ls_chk_edte[k] = ls_chk_edte[k - 1]
			UPDATE  	"PBPDM"."BOM001" 
				SET 	"PCHCD" = 'R' , "PEDTE" = :g_s_date
			where 	"PCMCD" = '01' and
						"PLANT" = :ls_plant and 
						"PDVSN" = :ls_div and 
						"PPITN" = :ls_ppitn AND "PCITN" = :ls_pcitn AND "PCHDT" = :ls_chdt 
			using sqlca;
			if sqlca.sqlcode = 0 then
		   	commit using sqlca;
			end if
			// IPIS Temp DB Write 추가
	   else 
			ls_chk_date = f_relativedate(ls_chk_edtm[k], -1)
			if ls_chk_edte[k - 1] <> ls_chk_date then	 
				Update 	PBPDM.bom001 
					Set 	pedte = :ls_chk_date 
				Where 	pcmcd = '01' and
							plant = :ls_plant and 
							pdvsn = :ls_div and 
							ppitn = :ls_ppitn and pcitn = :ls_pcitn and pchdt = :ls_chk_chdt[k - 1] 
				using sqlca;
			end if
			if sqlca.sqlcode = 0 then
		   	commit using sqlca;
			end if
		end if   
   end if
  loop
close bomchk_cur ;
if k = 0 then
	return 0
else 
	return 1 
end if

end function

public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew);// Set the Lable and Data attributes for the new item from the data in the DataStore
long		ln_check
string 	ls_citno , ls_plant,ls_div, ls_itnm , ls_clsbsrce

ls_plant 	= uo_plant.uf_return()
ls_div 		= mid(ls_plant,2,1)
ls_plant 	= mid(ls_plant,1,1)

if rb_1.checked = true then
	if f_spacechk(sle_1.text) = -1 and ag_level = 1  then
		ls_citno = ids_data3.object.itno[ag_row]
		ag_tvinew.label = ls_citno 
		ag_tvinew.data = ls_citno
		ag_tvinew.expanded = false
	else
		ls_citno = string(ids_data1[ag_level].object.pcitn[ag_row],"@@@@@@@@@@@@")
		ls_clsbsrce = f_bom_get_balance(ls_plant,ls_div, ls_citno)
		ag_tvinew.label =  ls_citno + "   " + ls_clsbsrce 
		ag_tvinew.data = ls_citno
		ag_tvinew.expanded = false
	end if
end if
if f_spacechk(sle_1.text) <> -1 and rb_2.checked = true then
	ls_citno = string(ids_data2[ag_level].object.ppitn[ag_row],"@@@@@@@@@@@@")
	ls_clsbsrce = f_bom_get_balance(ls_plant,ls_div, ls_citno)
	ag_tvinew.label = ls_citno + "   " + ls_clsbsrce
	ag_tvinew.data = ls_citno
	ag_tvinew.expanded = false
end if

if rb_2.checked	=	true then
	SELECT 	count(*) INTO :ln_check FROM "PBPDM"."BOM001" 
   	WHERE 	"PBPDM"."BOM001"."PCMCD" 	= 	'01'		and
				"PBPDM"."BOM001"."PLANT" 	= 	:ls_plant 	and
				"PBPDM"."BOM001"."PCITN" 	= 	:ls_citno 	and
				"PBPDM"."BOM001"."PDVSN" 	= 	:ls_div		and  
         			(("PBPDM"."BOM001"."PEDTE" 	= 	'' )			or  
         			( "PBPDM"."BOM001"."PEDTE" 	<> 	'' 			and  
         			"PBPDM"."BOM001"."PEDTE" 	>= 	:g_s_date	and  
				"PBPDM"."BOM001"."PEDTE" 	>= 	"PBPDM"."BOM001"."PEDTM"))   
	Using sqlca;
else
	SELECT	count(*)	INTO	:ln_check	FROM "PBPDM"."BOM001" 
	WHERE	"PBPDM"."BOM001"."PCMCD" 	= 	'01' 		and
				"PBPDM"."BOM001"."PLANT" 	= 	:ls_plant 	and
				"PBPDM"."BOM001"."PPITN" 	= 	:ls_citno 	and
				"PBPDM"."BOM001"."PDVSN" 	= 	:ls_div		and   
				(("PBPDM"."BOM001"."PEDTE" 	= 	'' )			or  
				( "PBPDM"."BOM001"."PEDTE" 	<> 	'' 			and  
				"PBPDM"."BOM001"."PEDTE" 	>= 	:g_s_date	and  
				"PBPDM"."BOM001"."PEDTE" 	>= 	"PBPDM"."BOM001"."PEDTM"))       
	using sqlca;
end if
if 	ln_check	<	1 then
	ag_tvinew.children = false
else 
	ag_tvinew.children = true
end if
ag_tviNew.SelectedPictureIndex = 2
ag_tviNew.PictureIndex = 1
end subroutine

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	li_Idx, li_last_row

li_last_row = ii_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If li_last_row = 0 then
	dw.setredraw(true) 
	Return 1
end if

if li_last_row > al_aclickedrow then
	For li_Idx = li_last_row to al_aclickedrow STEP -1
		dw.selectrow(li_Idx,TRUE)	
	end for	
else
	For li_Idx = li_last_row to al_aclickedrow 
		dw.selectrow(li_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			ln_Cnt
TreeViewItem	l_tvi_New
For ln_Cnt = 1 To ag_Rows
	// TreeView에 Item에 각각의 값을 Setting시킨다.
	wf_set_items(ag_Level, ln_Cnt, l_tvi_New)
	//messagebox("dd",string(l_tvi_new.label))
	// TreeView에 Item을 추가시킨다.
	If ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
		Return -1
	End If
Next
Return ag_Rows

end function

public subroutine wf_rgbclear ();dw_edit.object.pcitn.background.color 		= 15780518
dw_edit.object.pqtym.background.color 		= 15780518
dw_edit.object.pwkct.background.color 		= 15780518
dw_edit.object.pexdv.background.color 		= rgb(255,255,255)
dw_edit.object.pexplant.background.color 	= rgb(255,255,255)
dw_edit.object.pedtm.background.color 		= rgb(255,255,255)
dw_edit.object.pedte.background.color 		= rgb(255,255,255)

end subroutine

public function boolean wf_emp_chk ();string	ls_xplemp

select	xplemp	into	:ls_xplemp	from	pbpdm.bom018
where	xcmcd =	'01'	and	xinemp	=	:g_s_empno
using	sqlca	;
if	f_spacechk(ls_xplemp)	=	-1	then
	messagebox("확인","담당 PL 이 지정되지 않은 입력자입니다.~r~n P/L선택 버튼을 클릭후 P/L선택 후 작업을 계속하시기 바랍니다 ")
	return	false
end if
return	true
end function

on w_bom110u.create
int iCurrent
call super::create
this.tv_bom=create tv_bom
this.st_3=create st_3
this.sle_1=create sle_1
this.cb_insert=create cb_insert
this.cb_edit=create cb_edit
this.cb_impcopy=create cb_impcopy
this.cb_delete=create cb_delete
this.cb_expcopy=create cb_expcopy
this.dw_edit=create dw_edit
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_retrieve=create cb_retrieve
this.cb_save=create cb_save
this.pb_find=create pb_find
this.gb_2=create gb_2
this.gb_framemove=create gb_framemove
this.dw_explo=create dw_explo
this.dw_implo=create dw_implo
this.uo_plant=create uo_plant
this.cb_filter=create cb_filter
this.st_1=create st_1
this.cb_change=create cb_change
this.st_2=create st_2
this.cb_pl=create cb_pl
this.st_4=create st_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_bom
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.cb_edit
this.Control[iCurrent+6]=this.cb_impcopy
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.cb_expcopy
this.Control[iCurrent+9]=this.dw_edit
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.cb_retrieve
this.Control[iCurrent+13]=this.cb_save
this.Control[iCurrent+14]=this.pb_find
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_framemove
this.Control[iCurrent+17]=this.dw_explo
this.Control[iCurrent+18]=this.dw_implo
this.Control[iCurrent+19]=this.uo_plant
this.Control[iCurrent+20]=this.cb_filter
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.cb_change
this.Control[iCurrent+23]=this.st_2
this.Control[iCurrent+24]=this.cb_pl
this.Control[iCurrent+25]=this.st_4
this.Control[iCurrent+26]=this.gb_1
end on

on w_bom110u.destroy
call super::destroy
destroy(this.tv_bom)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.cb_insert)
destroy(this.cb_edit)
destroy(this.cb_impcopy)
destroy(this.cb_delete)
destroy(this.cb_expcopy)
destroy(this.dw_edit)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_retrieve)
destroy(this.cb_save)
destroy(this.pb_find)
destroy(this.gb_2)
destroy(this.gb_framemove)
destroy(this.dw_explo)
destroy(this.dw_implo)
destroy(this.uo_plant)
destroy(this.cb_filter)
destroy(this.st_1)
destroy(this.cb_change)
destroy(this.st_2)
destroy(this.cb_pl)
destroy(this.st_4)
destroy(this.gb_1)
end on

event open;call super::open;sle_1.setfocus()
setpointer(HourGlass!)
is_populate_no = 0
i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = false
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
cb_insert.enabled = true
cb_edit.enabled = false
cb_delete.enabled = false
cb_expcopy.enabled = false
cb_impcopy.enabled = false
cb_retrieve.enabled = true
cb_save.enabled = false
cb_change.enabled	=	false
st_2.disabledlook	=	true

//wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
//  	           i_b_dprint,   i_b_dchar)

end event

event close;call super::close;integer ln_cnt
for ln_cnt = 1 to 30
	destroy ids_Data1[ln_cnt]
   destroy ids_Data2[ln_cnt]
next

destroy ids_data3     

end event

event ue_retrieve;int            		net,ln_check
Long			ln_Root,ln_tvi
long           	ln_rows,ln_cnt
string         	ls_plant,ls_div,ls_pdcd,ls_pdcd1,ls_div1,ls_itno,root_data,ls_clsbsrce
string         	ls_rtncd
TreeViewItem	l_tvi_Root
treeview       	l_tv_current

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

if in_first = 0 then
	for ln_cnt = 1 to 20
		ids_data1[ln_cnt] = create datastore
		ids_data1[ln_cnt].dataobject = "d_bom001_explo_01"
		ids_data2[ln_cnt] = create datastore
		ids_data2[ln_cnt].dataobject = "d_bom001_implo_01"
		ids_data1[ln_cnt].settransobject(sqlca)	
		ids_data2[ln_cnt].settransobject(sqlca)	
	next
	ids_data3 = Create datastore
	ids_data3.dataobject = "d_bom001_pdcd_01"
	ids_data3.settransobject(sqlca)
	in_first = 1
end if

// SetPointer(HourGlass!)
f_pism_working_msg(This.title,"BOM 정보를 조회중입니다. 잠시만 기다려 주십시오.") 

is_sel = "I"

l_tv_current 						=	tv_bom
uo_status.st_message.text 	= 	""
ln_tvi = tv_bom.FindItem(roottreeitem!, 0)
tv_bom.DeleteItem(ln_tvi)

dw_edit.reset()

if rb_1.checked		=	true then
	dw_explo.reset()
	dw_explo.visible	=	true
	dw_implo.visible = 	false
	
	cb_change.enabled	=	true
	st_2.disabledlook	=	false
end if
if rb_2.checked		=	true then
	dw_implo.reset()
	dw_implo.visible	=	true
	dw_explo.visible	=	false
	
	cb_change.enabled	=	true
	st_2.disabledlook	=	false
end if

ls_rtncd	=	uo_plant.uf_return()
ls_plant 	=	mid(ls_rtncd,1,1)
ls_div 		=	mid(ls_rtncd,2,1)
ls_pdcd  	= 	mid(ls_rtncd,3,2) 
//ls_pdcd1  = trim(uo_plant.dw_pdcd.gettext()) + "%"
ls_itno 	=	upper(trim(sle_1.text))

if f_spacechk(ls_itno) = -1  and rb_1.checked = true then 
	 ls_div1 		= 	ls_div
	 root_nm 		= 	f_get_coflname(g_s_company, 'DAC160', ls_pdcd) 
	 ln_rows 		= 	ids_data3.retrieve(ls_plant,ls_div,ls_pdcd)
	 ln_check 	= 	1
else
	if f_spacechk(ls_itno)	=	-1  and rb_2.checked	=	true then
		uo_status.st_message.text = f_message("I080")
		If IsValid(w_pism_working) Then Close(w_pism_working) 
		return 0
	end if
	
	Select 	"PBINV"."INV101"."PDCD"  	Into :ls_pdcd1  From 	"PBINV"."INV101"  
	Where  	"PBINV"."INV101"."COMLTD" 	= :g_s_company 	and
			 	"PBINV"."INV101"."XPLANT" 		= :ls_plant  			and
			 	"PBINV"."INV101"."DIV" 			= :ls_div  				and
			 	"PBINV"."INV101"."ITNO"			= :ls_itno   
	Using sqlca;
	
	if f_spacechk(ls_pdcd1) = -1 then
		uo_status.st_message.text = f_message("E320")
		If IsValid(w_pism_working) Then Close(w_pism_working) 
		return 0
	end if
	ls_pdcd1 = mid(ls_pdcd1,1,2)
	uo_plant.uf_set_pdcd(ls_pdcd1)
	if f_spacechk(sle_1.text) <> -1 and rb_1.checked = true then
		ls_clsbsrce	= 	f_bom_get_balance(ls_plant,ls_div, ls_itno)
		ls_itno 		= 	string(ls_itno, "@@@@@@@@@@@@" )
		root_nm 		= 	ls_itno  + "    "  + ls_clsbsrce
		root_data 		=	ls_itno
		ln_rows 		= 	ids_data1[1].retrieve(ls_plant,ls_div,ls_itno, g_s_date)
	else 
		if f_spacechk(sle_1.text) <> -1 and rb_2.checked = true then
			ls_clsbsrce 	= 	f_bom_get_balance(ls_plant,ls_div, ls_itno)
			ls_itno 		= 	string(ls_itno, "@@@@@@@@@@@@" )
			root_nm 		= 	ls_itno  + "    "  + ls_clsbsrce
			root_data 		= 	ls_itno
			ln_rows 		= 	ids_data2[1].retrieve(ls_plant,ls_div,ls_itno, g_s_date)
		end if
	end if
end if
if ln_rows < 1 then
	uo_status.st_message.text = f_message("I020")
	If IsValid(w_pism_working) Then Close(w_pism_working) 
	return 0
end if

i_b_retrieve 				= 	true
i_b_insert 				=	true
i_b_delete 				= 	true
i_b_save 					= 	false
cb_insert.enabled		= 	true
cb_edit.enabled 			= 	true
cb_delete.enabled 		= 	true
cb_expcopy.enabled 	= 	true
cb_impcopy.enabled 	= 	true
cb_retrieve.enabled 	= 	true
cb_save.enabled 		= 	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
is_populate 				= 	0
l_tvi_root.label 			= 	root_nm 
l_tvi_root.data  			= 	root_data
l_tvi_Root.PictureIndex 	= 	1
l_tvi_Root.SelectedPictureIndex 	=	1
l_tvi_Root.Children		= 	True
ln_Root					= 	tv_bom.InsertItemLast(0, l_tvi_Root)
tv_bom.Expanditem(ln_Root)
if ln_check = 1 then
	wf_add_items(1,1,ln_rows,l_tv_current)
	ln_check = 0
end if
If IsValid(w_pism_working) Then Close(w_pism_working) 
return 0
end event

event ue_insert;string 	ls_plant,ls_div,ls_itclsb,ls_srce,ls_ppitn,ls_pdcd,ls_rtncd
integer 	ln_cnt,net,ln_count
long 		ln_handle
treeviewitem l_tvi_item

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net = messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net = 1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
uo_status.st_message.text = ""
if rb_2.checked = true then
   uo_status.st_message.text = f_message("I080")
   return 0
end if
ls_rtncd 		=	uo_plant.uf_return()
ls_div  		= 	mid(ls_rtncd,2,1)
ls_plant 		= 	mid(ls_rtncd,1,1)
//ls_pdcd 	= upper(trim(uo_plant.dw_pdcd.gettext())) + "%"
ln_handle 	= tv_bom.finditem(CurrentTreeItem!, 0)
if ln_handle	= 	-1	or	ln_handle	=	1 then
	ls_ppitn = upper(trim(sle_1.text))
	SELECT 	"PBINV"."INV101"."PDCD" 	INTO 	:ls_pdcd  
   	FROM 	"PBINV"."INV101"  
   	WHERE "PBINV"."INV101"."COMLTD" 	= :g_s_company AND  
         	"PBINV"."INV101"."XPLANT" 	= :ls_plant  	AND  
         	"PBINV"."INV101"."DIV" 		= :ls_div		AND  
         	"PBINV"."INV101"."ITNO" 	= :ls_ppitn 
	using sqlca;
				
	if f_spacechk(ls_pdcd) = -1 then
		uo_status.st_message.text = f_message("E320")
		return 0
	end if
	ls_pdcd = mid(ls_pdcd,1,2)
else
	tv_bom.getitem(ln_handle,l_tvi_item)
	ls_ppitn = upper(trim(l_tvi_item.data))
end if
if f_spacechk(ls_ppitn) = -1 then
	uo_status.st_message.text = f_message("E320")
   return 0
end if
ls_rtncd 	= f_bom_get_balance(ls_plant,ls_div,ls_ppitn)
ls_itclsb 	= mid(ls_rtncd,1,2)
ls_srce   	= mid(ls_rtncd,6,2)
if ls_itclsb = "10" and ( ls_srce = "01"  or ls_srce = "05" or ls_srce = "06" ) then
   	uo_status.st_message.text = f_message("A041")
	return 0
end if
dw_edit.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
if ls_srce = '03' or trim(ls_srce) = '' then
	select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
	if	ln_count	>	0	then
		idwc_child.retrieve(g_s_empno)
	else
		idwc_child.insertrow(0) 
		idwc_child.setitem(1,"dac001_dcode",'')
		idwc_child.setitem(1,"dac001_dname",'')
		idwc_child.setitem(1,"display",'')
	end if
elseif ls_srce = '02' then
	dw_edit.getchild("pwkct",idwc_child)
	idwc_child.settransobject(sqlca)
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')
elseif ls_srce = '04' and ls_itclsb <> '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'9999')
	idwc_child.setitem(1,"dac001_dname",'무상사급')
	idwc_child.setitem(1,"display",'9999 무상사급')
elseif ls_srce = '04' and ls_itclsb  =  '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')	
	idwc_child.insertrow(0) 
	idwc_child.setitem(2,"dac001_dcode",'9999')
	idwc_child.setitem(2,"dac001_dname",'무상사급')
	idwc_child.setitem(2,"display",'9999 무상사급')	
end if
dw_edit.reset()
dw_edit.insertrow(0)
dw_edit.setfocus()
dw_edit.object.ppitn[1] = ls_ppitn
wf_rgbclear()

// 입력 Field Check Routine 
is_sel = "A"
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_insert.enabled = true
cb_edit.enabled = true
cb_delete.enabled = true
cb_expcopy.enabled = true
cb_impcopy.enabled = true
cb_retrieve.enabled = true
cb_save.enabled = true

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
dw_edit.object.pcitn.protect = false
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pexdv.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false
dw_edit.setcolumn("pcitn")
cb_save.enabled = true
return 0
end event

event ue_delete;if	wf_emp_chk()	=	false	then
	return
end if

integer 	ln_row,ln_yesno,ln_rcnt,ls_lolevchk,ln_row1,net, ln_sqlcount, ln_routing_chk, i
string 		ls_edte,ls_citno, ls_plant, ls_div, ls_edtm, ls_ppitn, ls_chdt, ls_rout,  ls_chkitno, &
		 	ls_oscd, ls_ebst, ls_exdv, ls_empno , ls_wkct, ls_indt, ls_parm, ls_errchk
string 		ls_explant, ls_rtncd
long 		ls_handle, ls_nexthandle
dec{3} 	ls_qtym, ls_qtye
treeviewitem l_tvi_item

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
f_pism_working_msg(This.title,"BOM 정보를 삭제중입니다. 잠시만 기다려 주십시오.") 
uo_status.st_message.text = ""
ls_rtncd 	= 	uo_plant.uf_return()
ls_plant 	= 	mid(ls_rtncd,1,1)
ls_div 		= 	mid(ls_rtncd,2,1)

if rb_1.checked = true then
	ln_row		=	dw_explo.getselectedrow(0)
	if ln_row 	<> 	0 then
		ln_yesno		=	messagebox("삭제확인", "선택된 품번(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
		if ln_yesno 	<>	1 then
			uo_status.st_message.text		=	f_message("D030")
			If IsValid(w_pism_working) Then Close(w_pism_working)
			return 0
		end if
	else
		uo_status.st_message.text			=	f_message("D100")
		If IsValid(w_pism_working) Then Close(w_pism_working)
		return 0
	end if
	do until ln_row = 0 
		ls_citno		= 	trim(dw_explo.getitemstring(ln_row,"pcitn"))
		ls_ppitn 		= 	trim(dw_explo.getitemstring(ln_row,"ppitn"))
		ls_chdt 		= 	trim(dw_explo.getitemstring(ln_row,"pchdt"))
		ls_rout 		= 	trim(dw_explo.getitemstring(ln_row,"prout"))
		ls_edtm 		= 	trim(dw_explo.getitemstring(ln_row,"pedtm"))
		ls_edte 		= 	trim(dw_explo.getitemstring(ln_row,"pedte"))
		ls_oscd 		= 	dw_explo.getitemstring(ln_row,"poscd")
		ls_ebst 		= 	dw_explo.getitemstring(ln_row,"pebst")
		ls_explant 	= 	dw_explo.getitemstring(ln_row,"pexplant")
		ls_exdv 		= 	dw_explo.getitemstring(ln_row,"pexdv")
		ls_empno 	= 	dw_explo.getitemstring(ln_row,"pemno")
		ls_qtym 		= 	dw_explo.getitemnumber(ln_row,"pqtym")
		ls_qtye 		= 	dw_explo.getitemnumber(ln_row,"pqtye")
		ls_wkct 		= 	dw_explo.getitemstring(ln_row,"pwkct")
		ls_indt 		= 	dw_explo.getitemstring(ln_row,"pindt")
//		SELECT count(*)  
//    		INTO :ln_sqlcount  
//    		FROM "PBRTNG"."RTN003"  
//   		WHERE ( "PBRTNG"."RTN003"."RCCMCD" = :g_s_company ) AND  
//         		( "PBRTNG"."RTN003"."RCDVSN" = :ls_div ) AND  
//         		( "PBRTNG"."RTN003"."RCITNO" = :ls_citno )   
//           		using sqlca;
//
//		if ln_sqlcount > 0 then
//			uo_status.st_message.text = f_message("D040")
//			return 0
//		end if
		ls_chkitno = f_option_chk_after(ls_plant,ls_div,ls_citno,f_relativedate(g_s_date,1))
		if f_spacechk(ls_chkitno) <> -1 then
			if f_option_check(ls_plant,ls_div,ls_chkitno) = 0 then
				ls_chkitno 	= 	mid(ls_chkitno,1,12)
				ls_parm 		= 	ls_plant + ls_div + ls_chkitno 
				openwithparm(w_bom110u_res_04, ls_parm)
				ls_parm 		= 	message.stringparm
				ls_errchk 		=	mid(ls_parm,1,1)
				if ls_errchk 	= 	"C" then
					uo_status.st_message.text = f_message("D030")
					If IsValid(w_pism_working) Then Close(w_pism_working)
					return 0
				end if 
				uo_status.st_message.text = f_message("D010")
			end if
		else	
			Update  	"PBPDM"."BOM001" 
				Set  	"PEDTE" 	= 	:g_s_date,	"PCHCD" 	= 'D'
			where 	"PCMCD" 	= 	'01' 		and "PLANT" 	= :ls_plant and "PDVSN" = :ls_div and "PPITN" = :ls_ppitn AND 
						"PROUT" 	= 	:ls_rout 	and "PCITN" 	= :ls_citno and "PCHDT" = :ls_chdt 
    			using sqlca;
			if sqlca.sqlcode = 0 then
				commit using sqlca;
				uo_status.st_message.text = f_message("D010")
			else
				rollback using sqlca;
				uo_status.st_message.text = f_message("D020")
				If IsValid(w_pism_working) Then Close(w_pism_working)
				return 0
			end if
		end if
	   	wf_history_update_01(ls_plant,ls_div,ls_ppitn,ls_citno,ls_chdt,ls_edtm,g_s_date)
//		승인 Process 추가 - 2007.12.17
		if	f_bom_approve(ls_plant,ls_div,ls_citno,ls_ppitn,'B','D',dw_explo,g_s_date,ln_row)	<>	0	then
			messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
			return
		end if
//		승인 Process 끝

//	   	ls_lolevchk = 	f_lolev_update1(ls_plant,ls_div,ls_citno)
//	   	if ls_lolevchk = 1 then
//		   f_lolev_update(ls_plant,ls_div,ls_citno)
//	   	end if
	   	ln_row = dw_explo.getselectedrow(ln_row)
	loop
 	dw_explo.reset()
    	dw_explo.retrieve(ls_plant,ls_div,ls_ppitn, g_s_date)
end if
	
if rb_2.checked = true then
	ln_rcnt 	= 0 
	ln_row1 	= dw_implo.rowcount()
	ln_row 	= dw_implo.getselectedrow(0)
	if ln_row <> 0 then
		ln_yesno = messagebox("삭제확인", "선택된 품번(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
		if ln_yesno <> 1 then
			uo_status.st_message.text = f_message("D030")
			If IsValid(w_pism_working) Then Close(w_pism_working)
			return 0
		end if
	else
		uo_status.st_message.text = f_message("D100")
		If IsValid(w_pism_working) Then Close(w_pism_working)
		return 0
	end if
	do until ln_row = 0
		ln_row = dw_implo.getselectedrow(ln_row)
		ln_rcnt = ln_rcnt + 1
	loop
   	ln_row			= 	dw_implo.getselectedrow(0)
	ls_citno 		= 	trim(dw_implo.getitemstring(ln_row,"pcitn"))
	ls_chkitno 	=	f_option_chk_after(ls_plant,ls_div,ls_citno,f_relativedate(g_s_date,1))
	if ln_rcnt <> ln_row1 then	
		if f_spacechk(ls_chkitno) <> -1 then
			if f_option_check(ls_plant,ls_div,ls_chkitno) = 0 then
				ls_parm 		= 	ls_plant + ls_div + ls_chkitno 
				openwithparm(w_bom110u_res_04, ls_parm)
				ls_parm 		= 	message.stringparm
				ls_errchk 		=	mid(ls_parm,1,1)
				if ls_errchk 	= 	"C" then
					uo_status.st_message.text = f_message("D030")
				else
					uo_status.st_message.text = f_message("D010")
				end if
				If IsValid(w_pism_working) Then Close(w_pism_working)
				return 0
			end if
		end if
	else
		if f_spacechk(ls_chkitno) <> -1 then
			ln_yesno = messagebox("Option 해제 확인",  ls_citno + " 은 Option 품목입니다. Option을 해제하겠습니까 ?" ,Question!,OkCancel!,2)
			if ln_yesno <> 1 then
				uo_status.st_message.text = f_message("D030")
				If IsValid(w_pism_working) Then Close(w_pism_working)
				return 0
			else
				wf_option_update(ls_plant,ls_div,ls_chkitno,ls_citno,'D', '   ' , g_s_date)
				//		승인 Process 추가 - 2007.12.17
				if	f_bom_approve(ls_plant,ls_div,ls_citno,ls_chkitno,'O','D',dw_explo,g_s_date,ln_row)	<>	0	then
					messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
					return
				end if
		//		승인 Process 끝
			end if
		end if
	end if
	do until ln_row 	= 	0
		ls_citno 		=	trim(dw_implo.getitemstring(ln_row,"pcitn"))
		ls_ppitn 		= 	trim(dw_implo.getitemstring(ln_row,"ppitn"))
		ls_chdt 		= 	trim(dw_implo.getitemstring(ln_row,"pchdt"))
		ls_rout 		= 	trim(dw_implo.getitemstring(ln_row,"prout"))
		ls_edtm 		= 	trim(dw_implo.getitemstring(ln_row,"pedtm"))
		ls_edte 		= 	trim(dw_implo.getitemstring(ln_row,"pedte"))
		ls_oscd 		= 	dw_implo.getitemstring(ln_row,"poscd")
		ls_ebst 		= 	dw_implo.getitemstring(ln_row,"pebst")
		ls_explant	= 	dw_implo.getitemstring(ln_row,"pexplant")
		ls_exdv 		= 	dw_implo.getitemstring(ln_row,"pexdv")
		ls_empno 	= 	dw_implo.getitemstring(ln_row,"pemno")
		ls_qtym 		= 	dw_implo.getitemnumber(ln_row,"pqtym")
		ls_qtye 		= 	dw_implo.getitemnumber(ln_row,"pqtye")
		ls_wkct 		= 	dw_implo.getitemstring(ln_row,"pwkct")
		ls_indt 		= 	dw_implo.getitemstring(ln_row,"pindt")
		
//		SELECT count(*)  
//    		INTO :ln_sqlcount  
//    		FROM "PBRTNG"."RTN003"  
//   		WHERE ( "PBRTNG"."RTN003"."RCCMCD" = :g_s_company ) AND  
//         		( "PBRTNG"."RTN003"."RCDVSN" = :ls_div ) AND  
//         		( "PBRTNG"."RTN003"."RCITNO" = :ls_citno )   
//           		using sqlca;
//	
//		if ln_sqlcount > 0 then
//			uo_status.st_message.text = f_message("D040")
//			return 0
//		end if
		Update	"PBPDM"."BOM001" 
			Set 	"PCHCD" = 'D' , "PEDTE" = :g_s_date
		Where 	"PCMCD" = '01' AND "PLANT" = :ls_plant and "PDVSN" = :ls_div and "PPITN" = :ls_ppitn AND 
					"PROUT" = :ls_rout AND "PCITN" = :ls_citno AND "PCHDT" = :ls_chdt 
		using sqlca;
		if sqlca.sqlcode = 0 then
			commit using sqlca;
			uo_status.st_message.text = f_message("D010")
		else
			rollback using sqlca;
			uo_status.st_message.text = f_message("D020")
			If IsValid(w_pism_working) Then Close(w_pism_working)
			return 0
		end if
	   	wf_history_update_01(ls_plant,ls_div,ls_ppitn,ls_citno,ls_chdt,ls_edtm,g_s_date)
//		승인 Process 추가 - 2007.12.17
		if	f_bom_approve(ls_plant,ls_div,ls_citno,ls_ppitn,'B','D',dw_implo,g_s_date,ln_row)		<>	0	then
			messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
			return
		end if
//		승인 Process 끝
//		ls_lolevchk = 	f_lolev_update1(ls_plant,ls_div,ls_citno)
//		if ls_lolevchk = 1 then
//		  f_lolev_update(ls_plant,ls_div,ls_citno)
//		end if
		ln_row = dw_implo.getselectedrow(ln_row)
	loop
	dw_implo.reset()
	dw_implo.retrieve(ls_plant,ls_div,ls_citno,g_s_date)
end if

//구매담당자에게 메일발송로직
f_bom_xplan_email(g_s_empno)

If IsValid(w_pism_working) Then Close(w_pism_working)
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_insert.enabled = true
cb_edit.enabled = true
cb_delete.enabled = true
cb_expcopy.enabled = true
cb_impcopy.enabled = true
cb_retrieve.enabled = true
cb_save.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
return 0

end event

event ue_save;if	wf_emp_chk()	=	false	then
	return
end if

string 		ls_plant,ls_div,ls_wkct,ls_ppitn,ls_pcitn,ls_edtm,ls_edte, ls_exdv, ls_srce, ls_item, ls_chkitno
string 		ls_itclsb,ls_today,ls_column,ls_rout,ls_oscd,ls_ebst,ls_chdt, ls_edte1, ls_explant, ls_rtncd
integer 		ln_cnt, net,ln_chkcase,ln_tree_value, i , k, ln_yesno,ln_row,ln_errchk
long  		ln_handle,ln_nexthandle,ln_root,ln_handle1
dec{3} 		ld_chkqtym,ld_qtym,ld_qtye 
string 		ls_chkchdt,ls_chkedtm, ls_chkedte, ls_chkwkct, ls_chkexdv, ls_chgedtm, ls_chgedte, ls_parm, ls_srce1
string 		ls_oitno[],ls_chkitno1, ls_bar, ls_valid_date, ls_valid_date1, ls_valid_date2, ls_message
treeviewitem l_tvi_item

SetPointer(HourGlass!)
ls_chkedtm 	= dw_edit.object.pedtm[1]
ls_chkedte 	= dw_edit.object.pedte[1]
ls_chkwkct 	= dw_edit.object.pwkct[1]
ls_chkwkct  = dw_edit.getitemstring(1,"pwkct",primary!,true)
ls_chkexdv 	= dw_edit.object.pexdv[1]
ld_chkqtym 	= dw_edit.object.pqtym[1]
ls_chkchdt 	= dw_edit.object.pchdt[1]

dw_edit.accepttext()
if f_mandatory_chk(dw_edit) <> 1 then
	return
end if

ln_errchk 	= 0
ln_cnt 		= 0

f_sysdate()
uo_status.st_message.text = ''
wf_rgbclear()

ls_wkct 		= upper(trim(dw_edit.object.pwkct[1]))
ls_exdv 		= upper(trim(dw_edit.object.pexdv[1]))
ls_explant 	= upper(trim(dw_edit.object.pexplant[1]))
ls_edtm 		= dw_edit.object.pedtm[1]
if f_spacechk(ls_edtm) = -1 then
	ls_edtm = f_relativedate(g_s_date,1)
end if
if isnull(ls_exdv) then 
	ls_exdv = ''
end if
if isnull(ls_explant) then 
	ls_explant = ''
end if

ls_edte 	= 	dw_edit.object.pedte[1]
ls_rtncd 	= 	uo_plant.uf_return()
ls_div  	= 	mid(ls_rtncd,2,1)
ls_plant 	=	mid(ls_rtncd,1,1)

ln_handle = tv_bom.finditem(CurrentTreeItem!, 0)
if rb_1.checked = true then
	ls_pcitn = upper(trim(dw_edit.object.pcitn[1]))
	if ln_handle = -1 or ln_handle = 1 then
		ls_ppitn = upper(trim(sle_1.text))
	else
		tv_bom.getitem(ln_handle,l_tvi_item)
		ls_ppitn = upper(trim(l_tvi_item.data))
	end if
elseif rb_2.checked = true then
	ls_ppitn = upper(trim(dw_edit.object.ppitn[1]))
	if ln_handle = -1 or ln_handle = 1 then
		ls_pcitn = upper(trim(sle_1.text))
	else
		tv_bom.getitem(ln_handle,l_tvi_item)
		ls_pcitn = upper(trim(l_tvi_item.data))
	end if
end if
ld_qtym 		= dw_edit.object.pqtym[1]
ls_itclsb 	= f_bom_get_balance(ls_plant,ls_div,ls_ppitn)
ls_srce   	= mid(ls_itclsb,6,2)
ls_itclsb 	= mid(ls_itclsb,1,2)

if ls_ppitn = ls_pcitn then
	uo_status.st_message.text = "모품번과 자품번이 동일합니다."
	return 0
end if

// 유무상 호환동일 적용(2011.09.30)
if f_bom_check_wkct(g_s_company,ls_plant,ls_div,ls_ppitn,ls_pcitn,ls_wkct,ls_edtm,ls_message) = -1 then
	uo_status.st_message.text = ls_message
	return 0
end if

if is_sel = "A" then
	select 	count(*) into : ln_cnt from "PBINV"."INV101"
		where "PBINV"."INV101"."COMLTD" = :g_s_company and
				"PBINV"."INV101"."XPLANT" 	= :ls_plant and
				"PBINV"."INV101"."DIV" 		= :ls_div and 
				"PBINV"."INV101"."ITNO" 	= :ls_pcitn 
	using sqlca;

	if ln_cnt = 0 then
		ln_errchk = 1
		uo_status.st_message.text = f_message("E320") 
	else
		select 	count(*) into : ln_cnt from "PBPDM"."BOM001"
			where "PBPDM"."BOM001"."PCMCD" 	= '01' 			AND
					"PBPDM"."BOM001"."PLANT" 	= :ls_plant 	AND 
					"PBPDM"."BOM001"."PDVSN" 	= :ls_div 		AND 
					"PBPDM"."BOM001"."PCITN" 	= :ls_pcitn 	AND 
					"PBPDM"."BOM001"."PPITN" 	= :ls_ppitn 	AND 
					"PBPDM"."BOM001"."PCHDT" 	= :g_s_date 
		using sqlca;
		if ln_cnt > 0 then
			ln_errchk = 1
			uo_status.st_message.text = f_message("A060")
		else
		  	if ls_ppitn = ls_pcitn then
			  	ln_errchk = 1
			  	uo_status.st_message.text = f_message("E330")
		  	else
				if f_chk_bom(ls_plant,ls_div,ls_ppitn,ls_pcitn) = 1 then	
					ln_errchk = 1 
					uo_status.st_message.text = f_message("E330")
				else
					select count(*) into : ln_cnt from "PBPDM"."BOM001"
						where "PBPDM"."BOM001"."PCMCD" 	= 	'01' 		AND
								"PBPDM"."BOM001"."PLANT" 	= 	:ls_plant	AND 
								"PBPDM"."BOM001"."PDVSN" 	= 	:ls_div 	AND 
								"PBPDM"."BOM001"."PCITN" 	= 	:ls_pcitn	AND	
								"PBPDM"."BOM001"."PPITN" 	= 	:ls_ppitn AND 
 								( ("PBPDM"."BOM001"."PEDTM" <= "PBPDM"."BOM001"."PEDTE" AND "PBPDM"."BOM001"."PEDTE" <> ' ' AND "PBPDM"."BOM001"."PEDTE" > :g_s_date )
             						OR  
           						( "PBPDM"."BOM001"."PEDTE" = ' ' AND "PBPDM"."BOM001"."PEDTM" <= :g_s_date ))
					using sqlca;
					if ln_cnt > 0 then
						ln_errchk = 1
						uo_status.st_message.text = "이미 입력된 정보입니다."
					end if
				end if
		  	end if
		end if
  	end if
end if
if ln_errchk = 1 and f_spacechk(ls_column) = -1 then
	ls_column = "pcitn"
	dw_edit.object.pcitn.background.color = rgb(255,255,0)
end if
ln_errchk = 0
if isNull(ld_qtym)  = True  or   ld_qtym <= 0 then
	ln_errchk = 1
	dw_edit.object.pqtym.background.color = rgb(255,255,0)
end if
if ln_errchk = 1 and f_spacechk(ls_column) = -1 then
	ls_column = "pqtym"
end if

ln_errchk 	= 0
if f_spacechk(ls_wkct) = -1 then
	ln_errchk = 1
else
	if ls_wkct <> "8888" and ls_wkct <> "9999" then
		select count(*) into :ln_cnt from pbcommon.dac001
		       where duse = ' ' and dtodt = 0 and dcode = :ls_wkct and dacttodt = 0 using sqlca;
		if ln_cnt < 1 then
			ln_errchk = 1
		end if
	end if
	if ls_itclsb = "40" or ls_itclsb = "50" then
		if ls_wkct <> "9999" then
			ln_errchk = 1
		end if
	end if
	if ls_itclsb = "10" and ls_srce = "02" then
		if ls_wkct <> "8888" then
			ln_errchk = 1
		end if
	end if
	if ( ls_itclsb = "30" or ls_srce = "03" ) and ( ls_wkct = "8888" or ls_wkct = "9999" ) then
			ln_errchk = 1
	end if
	if ls_itclsb = "10" and ls_srce = "04" then
		if ls_wkct <> "8888" and ls_wkct <> "9999" then
			ln_errchk = 1
		end if
	end if
end if
if ln_errchk = 1 then
	dw_edit.object.pwkct.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column = "pwkct"	
	end if
end if

ln_errchk 		=	0
ls_srce1   	= 	f_bom_get_srce(ls_plant,ls_div,ls_pcitn)
if ls_srce1 	= 	"05" or ls_srce1 = "06" then
	if f_spacechk(ls_exdv) = -1 or f_spacechk(ls_explant)  = -1 then
		ln_errchk = 1
	else
		if ( ls_plant <> ls_explant ) then
			ln_errchk = 0		   
		else
			ln_errchk = 1
		end if
		select count(*) into :ln_cnt from pbinv.inv101 
				where comltd 	= :g_s_company and
						xplant 	= :ls_explant and
						div 		= :ls_exdv and 
						itno 		= :ls_pcitn using sqlca;
		if ln_cnt = 0 then
			ln_errchk = 1
		end if
	end if
else
	if ls_srce1 = '01' or ls_srce = '02' then
		// 원재료이체인 경우에 상위품번에 대해서 동일한 이체지역,공장이 들어가야 한다.
		SELECT count(*) into :ln_cnt
		FROM PBPDM.BOM001 B
		WHERE B.PCMCD = '01' AND B.PLANT = :ls_plant AND B.PDVSN = :ls_div
		AND B.PCITN = :ls_pcitn AND B.PLANT||B.PDVSN||B.PCITN IN (
			SELECT DISTINCT A.PLANT||A.PDVSN||A.PCITN
			FROM PBPDM.BOM001 A
			WHERE A.PCMCD = '01' AND A.PLANT = :ls_plant AND A.PDVSN = :ls_div
			AND A.PCITN = :ls_pcitn AND TRIM(A.PEXDV) <> '' 
			AND (( a.pedte = ' '  and a.pedtm <= :g_s_date ) or
				( a.pedte <> ' ' and a.pedtm <= :g_s_date
						 and a.pedte >= :g_s_date )))
		AND (( B.pedte = ' '  and B.pedtm <= :g_s_date ) or
			( B.pedte <> ' ' and B.pedtm <= :g_s_date
						 and B.pedte >= :g_s_date ))
		using sqlca;
		
		if ln_cnt > 0 and f_spacechk(ls_exdv) = -1 then
			ln_errchk = 1
		end if
		
		if f_spacechk(ls_explant) <> -1 then
			select count(*) into :ln_cnt from pbinv.inv101 
			where comltd 	= :g_s_company and
					xplant 	= :ls_explant and
					div 		= :ls_exdv and 
					itno 		= :ls_pcitn using sqlca;
			if ln_cnt = 0 then
				ln_errchk = 1
			end if
		end if
	else
		if f_spacechk(ls_exdv) <> -1 then
			ln_errchk = 1
		end if
	end if
end if
if ln_errchk = 1 then
	dw_edit.object.pexdv.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
	   ls_column = "pexdv"
   end if
end if
ln_errchk = 0
if f_spacechk(ls_edtm) <> -1 and f_spacechk(ls_edte) = -1 then
	if f_dateedit(ls_edtm) <> "        " then 
		if ls_edtm <= g_s_date then
			dw_edit.object.pedtm.background.color = rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
				ls_column = "pedtm"
			end if
		end if
	else
		dw_edit.object.pedtm.background.color = rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
		 ls_column = "pedtm"
		end if
	end if
end if
if f_spacechk(ls_edte) <> -1 and f_spacechk(ls_edtm) = -1 then
	if f_dateedit(ls_edte) <> "        " then 
		if ls_edte <= g_s_date then
			if f_spacechk(ls_column) = -1 then
				ls_column = "pedte"
			end if
			dw_edit.object.pedte.background.color = rgb(255,255,0)
		end if
	else
		if f_spacechk(ls_column) = -1 then
			ls_column = "pedte"
		end if
		dw_edit.object.pedte.background.color = rgb(255,255,0)
	end if
end if
if f_spacechk(ls_edte) <> -1 and f_spacechk(ls_edtm) <> -1 then
	if ls_edte <= g_s_date then
		if f_spacechk(ls_column) = -1 then
			ls_column = "pedte"
		end if
		dw_edit.object.pedte.background.color = rgb(255,255,0)
	end if
	if ls_edtm <= g_s_date then
		if f_spacechk(ls_column) = -1 then
			ls_column = "pedtm"
		end if
		dw_edit.object.pedtm.background.color = rgb(255,255,0)
	end if
	if ls_edte < ls_edtm then
		if f_spacechk(ls_column) = -1 then
			ls_column = "pedte"
		end if
		dw_edit.object.pedtm.background.color = rgb(255,255,0)
	end if
	if f_dateedit(ls_edtm) <> "        " then
		if f_dateedit(ls_edte) <> "        " then
			if ls_edtm > ls_edte then
				dw_edit.object.pedtm.background.color = rgb(255,255,0)
				if f_spacechk(ls_column) = -1 then
					ls_column = "pedtm"
				end if      		
         		end if
		else
			dw_edit.object.pedte.background.color = rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
				ls_column = "pedte"
			end if      		
		end if
	else
		dw_edit.object.pedtm.background.color = rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column = "pedtm"
		end if      		
	end if
end if
if is_sel = "C" then
	if f_spacechk(ls_edte) <> -1 then
		if ls_edte < f_relativedate(g_s_date,1) then
			dw_edit.object.pedte.background.color = rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
					ls_column = "pedte"
			end if
		end if
	end if
end if

if len(ls_column) > 0 then
	dw_edit.setcolumn(ls_column)
	dw_edit.setfocus()
//	if ls_column <> "pcitn" then
	   uo_status.st_message.text = f_message("E010")
//  	end if
	i_n_erreturn = -1
	return 0
end if

ls_rout 	= 	''
ld_qtye 	=	0
ls_ebst 	= 	''
if ls_wkct 		= "8888" then 
	ls_oscd 		= '1'
elseif ls_wkct	= "9999" then 
	ls_oscd 		= '2'
else		
	ls_oscd		=	''
end if

if is_sel = 'A' then
	ls_today 		=	g_s_date
	ls_chdt  		= 	g_s_date
	ls_chkitno 	= 	f_option_chk_after(ls_plant,ls_div,ls_pcitn,ls_edtm) 
	if f_spacechk(ls_chkitno) <> -1 and f_option_check(ls_plant,ls_div,ls_chkitno) = 0 then
		ln_yesno = messagebox("Option 품목 Check", "현재 상위품번에 전체 Option 품목을 추가하시겠습니까 ?",Question!,OkCancel!,2)
		if ln_yesno <> 1 then
			uo_status.st_message.text = f_message("A030")
			i_n_erreturn = -1
			return 0
		end if
		INSERT INTO "PBPDM"."BOM001"  
				( 	"PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
				  	"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
		  			"PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
		VALUES (	:g_s_company,:ls_plant,:ls_div,:ls_ppitn,:ls_rout,:ls_chkitno,:ls_chdt,:ld_qtym,:ld_qtye,
		  			:ls_wkct,:ls_edtm,:ls_edte,'',:ls_explant,:ls_exdv,'A',:ls_oscd,:ls_ebst,
		  			:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,'')
		using sqlca;
		if sqlca.sqlcode <> 0 then
			rollback using sqlca;
			uo_status.st_message.text = f_message("A020")
			i_n_erreturn = -1
			return 0
		else
			INSERT INTO "PBPDM"."BOM001"  
				select		:g_s_company,:ls_plant,:ls_div,:ls_ppitn,:ls_rout,"PBPDM"."BOM003"."OFITN",:ls_chdt,:ld_qtym,:ld_qtye,
							:ls_wkct,:ls_edtm,:ls_edte,'',:ls_explant,:ls_exdv,'A',:ls_oscd,:ls_ebst,
							:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,'' from "PBPDM"."BOM003"
				where 	"PBPDM"."BOM003"."OCMCD" 	= '01' AND
							"PBPDM"."BOM003"."OPITN" 	= :ls_chkitno AND
							"PBPDM"."BOM003"."ODVSN" 	= :ls_div AND  
							("PBPDM"."BOM003"."OEDTE" 	= ''  OR  
							"PBPDM"."BOM003"."OEDTE" 	>= :g_s_date ) 
			using sqlca ;			
			if sqlca.sqlcode <> 0 then
				rollback using sqlca;
				uo_status.st_message.text = f_message("A020")
				i_n_erreturn = -1
				return 0
			else
				commit using sqlca;
				uo_status.st_message.text = f_message("A010")
			end if
		end if
		ln_tree_value = 1
// 	f_lolev_update(ls_plant,ls_div,ls_ppitn)
	else
		INSERT INTO "PBPDM"."BOM001"  
				 ( "PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
			  		"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
			  		"PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
		VALUES (	:g_s_company,:ls_plant,:ls_div,:ls_ppitn,:ls_rout,:ls_pcitn,:ls_chdt,:ld_qtym,:ld_qtye,
			  		:ls_wkct,:ls_edtm,:ls_edte,'',:ls_explant,:ls_exdv,'A',:ls_oscd,:ls_ebst,
			  		:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,'')
		using sqlca;
		if sqlca.sqlcode <> 0 then
			messagebox("확인",sqlca.sqlerrtext)
			i_n_erreturn = -1
			rollback using sqlca;
			uo_status.st_message.text = f_message("A020")
			return 0
		else
			commit using sqlca;
			uo_status.st_message.text = f_message("A010")
		end if
		ln_tree_value = 1
	//	f_lolev_update(ls_plant,ls_div,ls_ppitn) 
   end if
	//		승인 Process 추가 - 2007.12.17
	if	f_bom_approve(ls_plant,ls_div,ls_pcitn,ls_ppitn,'B','A',dw_edit,ls_edtm,1)	<>	0	then
		messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
		return
	end if
	//		승인 Process 끝		
else
	if ls_chkedte <> ls_edte then
		ln_chkcase = 1
	end if
	ls_chdt 		= 	dw_edit.object.pchdt[1]
	ls_edte1 		= 	ls_edte
	if ls_chdt 		=	g_s_date then
		update 	"PBPDM"."BOM001" 
			set 	"PEDTE" = :ls_edte , "PQTYM" = :ld_qtym , "PWKCT" = :ls_wkct , "PEDTM" = :ls_edtm  , "PEXDV" = :ls_exdv
			where "PCMCD" = '01' AND "PLANT" = :ls_plant and "PDVSN" = :ls_div and 
					"PPITN" = :ls_ppitn AND "PCITN" = :ls_pcitn AND "PCHDT" = :ls_chdt 
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
	         	i_n_erreturn = -1
			rollback using sqlca;
			uo_status.st_message.text = f_message("U020")
		   	return 0
		else
			commit using sqlca;
			uo_status.st_message.text = f_message("U010")
		end if
		ln_tree_value 	=	0
		ls_chdt  			=	g_s_date
	else
		ls_edte = f_relativedate(ls_edtm,-1)
		update 	"PBPDM"."BOM001" 
			set 	"PEDTE" = :ls_edte
			where "PCMCD" = '01' AND "PLANT" = :ls_plant and "PDVSN" = :ls_div and 
					"PPITN" = :ls_ppitn AND "PROUT" = :ls_rout AND "PCITN" = :ls_pcitn AND "PCHDT" = :ls_chdt 
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			i_n_erreturn = -1
			rollback using sqlca;
			uo_status.st_message.text = f_message("U020")
		   return 0
		else
			commit using sqlca;
		end if
		ln_tree_value = 0
		ls_chdt = g_s_date
		ls_edte = ls_edte1
		select 	count(*) into : ln_cnt from "PBPDM"."BOM001"
			where "PBPDM"."BOM001"."PCMCD" = '01' 			and
					"PBPDM"."BOM001"."PLANT" = :ls_plant 	and 
					"PBPDM"."BOM001"."PDVSN" = :ls_div	 	and 
					"PBPDM"."BOM001"."PCITN" = :ls_pcitn 	and
					"PBPDM"."BOM001"."PPITN" = :ls_ppitn 	and 
					"PBPDM"."BOM001"."PCHDT" = :ls_chdt 	and  
				(( "PBPDM"."BOM001"."PEDTE" = '' ) 			or  
				( 	"PBPDM"."BOM001"."PEDTE" <> '' 			and  
					"PBPDM"."BOM001"."PEDTE" >= :g_s_date  and  
					"PBPDM"."BOM001"."PEDTE" >= "PBPDM"."BOM001"."PEDTM"))    		
		using sqlca;
	   	if ln_cnt > 0 then
			update 	"PBPDM"."BOM001" 
				set 	"PEDTE" = :ls_edte , "PQTYM" = :ld_qtym , "PWKCT" = :ls_wkct , "PEDTM" = :ls_edtm  , "PEXDV" = :ls_exdv
				where "PCMCD" = '01' AND "PLANT" = :ls_plant AND "PDVSN" = :ls_div and "PPITN" = :ls_ppitn AND 
						"PROUT" = :ls_rout AND "PCITN" = :ls_pcitn AND "PCHDT" = :ls_chdt 
			using sqlca;
			ln_tree_value = 0
		else 	
			INSERT INTO "PBPDM"."BOM001"  
					 ( "PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
					  "PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
					  "PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
			VALUES (	:g_s_company,:ls_plant,:ls_div,:ls_ppitn,:ls_rout,:ls_pcitn,:ls_chdt,:ld_qtym,:ld_qtye,
				  		:ls_wkct,:ls_edtm,:ls_edte,'',:ls_explant,:ls_exdv,'R',:ls_oscd,:ls_ebst,
				  		:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
			using sqlca;
			ln_tree_value = 0
		end if
		if sqlca.sqlcode <> 0 then
			i_n_erreturn = -1
			rollback using sqlca;
			uo_status.st_message.text = f_message("U020")
			return 0
		else
			commit using sqlca;
			uo_status.st_message.text = f_message("U010")
		end if
	end if
	wf_history_update(ls_plant,ls_div,ls_ppitn,ls_pcitn,ls_edtm)
	if ln_chkcase = 1 and f_spacechk(ls_edte) <> -1 then				
		wf_history_update_01(ls_plant,ls_div,ls_ppitn,ls_pcitn,ls_chdt,ls_edtm,ls_edte)
	end if
	
//		승인 Process 추가 - 2007.12.17
	if	f_bom_approve(ls_plant,ls_div,ls_pcitn,ls_ppitn,'B','R',dw_edit,ls_edtm,1)	<>	0	then
		messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
		return
	end if
//		승인 Process 끝	

//	ls_chkitno = f_option_chk_after(ls_plant,ls_div,ls_pcitn,g_s_date) 
//	if f_spacechk(ls_chkitno) <> -1 and ls_chkitno <> ls_pcitn then
//		if	messagebox("Option 해제 확인",  ls_pcitn + " 은 Option 품목입니다. Option을 해제하겠습니까 ?" ,Question!,OkCancel!,2)	=	1	then
//			ls_valid_date 	= f_vaild_datechk(ls_plant,ls_div,ls_ppitn,ls_pcitn,'  ','  ')
//			ls_valid_date1 = mid(ls_valid_date , 1, 8)
//			ls_valid_date2 = mid(ls_valid_date , 9, 8)
//			wf_option_update(ls_plant,ls_div,ls_chkitno,ls_pcitn,'R',ls_valid_date1,ls_valid_date2)
//		end if
//	else
//		if ls_chkitno = ls_pcitn  then
//			messagebox("확인", "Option 주품번입니다. Option 정보를 확인하십시오.")
//		end if
//	end if
	ls_chkitno = f_option_chk_after(ls_plant,ls_div,ls_pcitn,ls_edtm) 
	if f_spacechk(ls_chkitno) <> -1	then
		messagebox("확인", "품번 " + ls_pcitn	+	" 은 Option 품목입니다.~r~nOption 해제하려면 Option 품목 등록 프로그램에서 삭제하시기 바랍니다.")
	end if
end if

//구매담당자에게 메일발송로직
f_bom_xplan_email(g_s_empno)

if ln_tree_value = 1 then
	l_tvi_item.data 		= trim(ls_pcitn)
	l_tvi_item.label 		= trim(ls_pcitn) 
	l_tvi_item.children 	= false
	is_populate_no 		= 1
	ln_handle 			= tv_bom.finditem(CurrentTreeItem!, 0)
	l_tvi_item.SelectedPictureIndex 	= 2
   	l_tvi_item.PictureIndex 				= 1
	tv_bom.insertitemlast(ln_handle, l_tvi_item)
	tv_bom.setredraw(true)
end if

if rb_1.checked = true then
	dw_explo.reset()
	dw_edit.reset()
	dw_explo.retrieve(ls_plant ,ls_div,ls_ppitn, g_s_date)
	ln_row		=	dw_explo.find("pcitn = '" + ls_pcitn + "'",1,dw_explo.rowcount())
	dw_explo.selectrow(ln_row,true)
	dw_explo.scrolltorow(ln_row)
elseif rb_2.checked = true then
	dw_implo.reset()
	dw_edit.reset()
   	dw_implo.retrieve(ls_plant,ls_div,ls_pcitn, g_s_date)
	ln_row		=	dw_implo.find("ppitn = '" + ls_ppitn + "'",1,dw_implo.rowcount())
	dw_implo.selectrow(ln_row,true)
	dw_implo.scrolltorow(ln_row)	
end if

i_b_retrieve 				= true  
i_b_insert 				= true
i_b_delete 				= true
i_b_save 					= false
cb_insert.enabled 		= true
cb_edit.enabled 			= true
cb_delete.enabled 		= true
cb_expcopy.enabled 	= true
cb_impcopy.enabled 	= true
cb_retrieve.enabled 	= true
cb_save.enabled 		= false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
return 0
end event

event closequery;call super::closequery;int net

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet01`uo_status within w_bom110u
integer y = 2472
end type

type tv_bom from treeview within w_bom110u
integer x = 14
integer y = 312
integer width = 1467
integer height = 2144
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean disabledragdrop = false
boolean hideselection = false
boolean tooltips = false
string picturename[] = {"Custom039!","Custom050!","","","","","","","","","","","","","",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event itempopulate;Integer			ln_Level
TreeViewItem	l_tvi_Current, l_tvi_root
Treeview			l_tv_current
String         ls_data 
long           ln_rows

if is_populate_no = 1 then
	is_populate_no = 0
	return 
end if

// Determine the level
tv_bom.GetItem(handle, l_tvi_Current)
ln_Level = l_tvi_Current.Level

if ln_level >= 30 then 
	return
end if
if is_populate <> 0 then		
	wf_itempopulate(handle, tv_bom)
end if
is_populate = 1

end event

event selectionchanged;treeviewitem l_tvi_current
integer ln_level, net
string  ls_div, ls_plant, ls_rtncd

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
uo_status.st_message.text = ""

tv_bom.getitem(newhandle,l_tvi_current)
ln_level = l_tvi_current.level

ls_rtncd = uo_plant.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div 	= mid(ls_rtncd,2,1)

dw_edit.reset()

sle_1.text 	= l_tvi_current.data
if ln_level = 1 and f_spacechk(sle_1.text) <> -1 then
	l_tvi_current.data = sle_1.text
end if
if ln_level <> 1 or f_spacechk(sle_1.text) <> -1  then
	if rb_1.checked = true then
		dw_explo.reset()
		dw_explo.retrieve(ls_plant,ls_div,l_tvi_current.data,g_s_date)
	end if
	if rb_2.checked = true then
		dw_implo.reset()
		dw_implo.retrieve(ls_plant,ls_div,l_tvi_current.data,g_s_date)
	end if
end if


end event

event dragdrop;treeviewitem 	ltv_i
string  		ls_plant,ls_div, ls_ppitn, ls_rout, ls_pcitn, ls_chdt, ls_wkct, ls_edtm, ls_edte
string  		ls_explant,ls_exdv , ls_oscd, ls_ebst, ls_today, ls_parm, ls_srce
dec{3}  		ls_qtym, ls_qtye
integer 		ln_cnt, ln_yesno, i , k
string  		ls_chkitno, ls_chkitno1, ls_oitno[], ls_itclsb, ls_rtncd

ls_rtncd		=	uo_plant.uf_return()
ls_div  		=	mid(ls_rtncd,2,1)
ls_plant 		=	mid(ls_rtncd,1,1)

ls_ppitn 		=	i_tvi_drag_parent.data
ls_pcitn 		=	i_tvi_drag_object.data
ls_rout 		=	""

select "PQTYM" , "PQTYE", "PWKCT",  "PEDTE", "PEXDV", "PEXPLANT" , "POSCD" , "PEBST"  
	into :ls_qtym, :ls_qtye, :ls_wkct, :ls_edte, :ls_exdv,:ls_explant , :ls_oscd, :ls_ebst	from "PBPDM"."BOM001"
where "PBPDM"."BOM001"."PCMCD" 	= 	'01' 		and 
	  	"PBPDM"."BOM001"."PPITN" 	= 	:ls_ppitn 	and 
	  	"PBPDM"."BOM001"."PCITN" 	= 	:ls_pcitn 	and 
	  	"PBPDM"."BOM001"."PLANT" 	= 	:ls_plant 	and
	  	"PBPDM"."BOM001"."PDVSN" 	= 	:ls_div 	and  "PBPDM"."BOM001"."PROUT" = :ls_rout 	and
		(( "PBPDM"."BOM001"."PEDTE" 	= ' ' ) 		or  
		( "PBPDM"."BOM001"."PEDTE" 	<> ' ' 			and
		"PBPDM"."BOM001"."PEDTE" >= :g_s_date 	and  "PBPDM"."BOM001"."PEDTE" >= "PBPDM"."BOM001"."PEDTM"))   
using SQLCA ;
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = f_message("E330")
	return
end if
this.getitem(handle,ltv_i)
ls_ppitn 	= ltv_i.data
ln_yesno 	= messagebox("Copy 확인", ls_ppitn + "의 하위 구조에 현재 품번을 Copy 하시겠습니까 ?",Question!,OkCancel!,2)
if ln_yesno <> 1 then
	return
end if
ls_srce 	=	f_bom_get_balance(ls_plant,ls_div,ls_ppitn)
ls_itclsb 	= 	mid(ls_srce,1,2)
ls_srce 	=	mid(ls_srce,6,2)
if ls_itclsb	= "10" and ( ls_srce = "01" or ls_srce = "05" or ls_srce = "06" ) then
	uo_status.st_message.text = f_message("A041")
	return
end if
ls_edtm 	=	f_relativedate(g_s_date,1)
select	count(*) into : ln_cnt from "PBPDM"."BOM001"
where "PBPDM"."BOM001"."PCMCD" 	= 	'01' 		and
		"PBPDM"."BOM001"."PLANT" 	= 	:ls_plant 	and 
		"PBPDM"."BOM001"."PDVSN" 	= 	:ls_div 	and 
		"PBPDM"."BOM001"."PCITN" 	= 	:ls_pcitn 	and	"PBPDM"."BOM001"."PPITN"	=	:ls_ppitn	and
		(( "PBPDM"."BOM001"."PEDTE" = 	' ' ) 		or		( "PBPDM"."BOM001"."PEDTE" 	<> 	' ' and  
		"PBPDM"."BOM001"."PEDTE" 	>=	:g_s_date	and  	"PBPDM"."BOM001"."PEDTE" 	>= 	"PBPDM"."BOM001"."PEDTM"))       
using sqlca;
if ln_cnt > 0 then
	uo_status.st_message.text = f_message("A060")
	return
else
	if ls_ppitn = ls_pcitn then
		uo_status.st_message.text = f_message("E330")
		return
	else
		if f_chk_bom(ls_plant,ls_div,ls_ppitn,ls_pcitn) = 1 then	
		  	uo_status.st_message.text = f_message("E330")
		  	return
		end if
	end if
end if
if ls_itclsb = "40" or ls_itclsb = "50" then
	if ls_wkct <> "9999" then
		ls_wkct = "9999"
	end if
end if
if ls_itclsb = "10" and ls_srce = "02" then
	if ls_wkct <> "8888" then
		ls_wkct = "8888"
	  end if
end if
if ls_itclsb = "30" and ( ls_wkct = "8888" or ls_wkct = "9999" ) then
	uo_status.st_message.text = "조코드를 확인하세요"
	return
end if
if ls_itclsb = "10" and ls_srce = "04" then
	if ls_wkct <> "8888" and ls_wkct <> "9999" then
		ls_wkct = "9999"
	end if
end if


ls_chkitno = f_option_chk_after(ls_plant,ls_div,ls_pcitn,ls_edtm) 

if f_spacechk(ls_chkitno) <> -1 and f_option_check(ls_plant,ls_div,ls_chkitno) = 0  then
	ln_yesno = messagebox("Option 품목 Check", "현재 상위품번에 전체 Option 품목을 추가하시겠습니까 ?",Question!,OkCancel!,2)
	if ln_yesno <> 1 then
		uo_status.st_message.text = f_message("A030")
		return
	end if
	declare optchk_cur cursor for 
	select "PBPDM"."BOM003"."OFITN" from "PBPDM"."BOM003"
  	where "PBPDM"."BOM003"."OCMCD" 		= 	'01' 			and
		  	"PBPDM"."BOM003"."OPITN" 		= 	:ls_chkitno 	and
		  	"PBPDM"."BOM003"."OPLANT" 		= 	:ls_plant  		and
			 "PBPDM"."BOM003"."ODVSN" 		= 	:ls_div 		and
			(( "PBPDM"."BOM003"."OEDTE" 	= 	' ' ) 			or
			( "PBPDM"."BOM003"."OEDTE" 		<> 	' ' 				and
			"PBPDM"."BOM003"."OEDTE" 		>= 	:g_s_date ))    
	using SQLCA ;

	open optchk_cur ;
		ls_oitno[1] = ls_chkitno
		i = 1
		do while true
			fetch optchk_cur into :ls_chkitno1 ;
			if sqlca.sqlcode <> 0 then
				exit
			end if 
			i = i + 1
			ls_oitno[i] = trim(ls_chkitno1)
		loop
	close optchk_cur ;
	for k = 1 to i
		INSERT INTO "PBPDM"."BOM001"  
         	( 	"PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
           	"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
		 	"PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
		VALUES 
		(	:g_s_company,:ls_plant,:ls_div,:ls_ppitn,:ls_rout,:ls_oitno[k],:g_s_date,:ls_qtym,:ls_qtye,
		  	:ls_wkct,:ls_edtm,:ls_edte,' ',:ls_explant,:ls_exdv,'A',:ls_oscd,:ls_ebst,
		  	:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
		using sqlca;
	
		if sqlca.sqlcode <> 0 then
			rollback using sqlca;
			uo_status.st_message.text = f_message("A020")
			return     
		else
			commit using sqlca;
			uo_status.st_message.text = f_message("A010")
		end if
	 next
//	f_lolev_update(ls_plant,ls_div,ls_ppitn)
else
	INSERT INTO "PBPDM"."BOM001"  
	( 	"PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
		"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
		"PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
	VALUES 
	(	:g_s_company,:ls_plant,:ls_div,:ls_ppitn,:ls_rout,:ls_pcitn,:g_s_date,:ls_qtym,:ls_qtye,
		:ls_wkct,:ls_edtm,:ls_edte,' ',:ls_explant,:ls_exdv,'A',:ls_oscd,:ls_ebst,
		:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
	Using sqlca;
		
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		uo_status.st_message.text = f_message("A020")
		return
	else
		commit using sqlca;
		uo_status.st_message.text = f_message("A010")
	end if
//	 f_lolev_update(ls_plant,ls_div,ls_ppitn)
end if
//this.setdrophighlight(handle)
is_populate_no	=	1
this.insertitemfirst(handle, i_tvi_drag_object)
//this.expanditem(handle)
this.setredraw(true)

end event

event begindrag;long itemnum,itemnum1

this.drag(begin!)
itemnum 	= this.finditem(CurrentTreeItem!, 0)
itemnum1 = this.finditem(parenttreeitem!, itemnum)
this.getitem(itemnum,i_tvi_drag_object)
this.getitem(itemnum1,i_tvi_drag_parent)



end event

event rightclicked;MenuBOM NewMenu

NewMenu = CREATE MenuBOM
newmenu.m_kew.m_delete.enabled = false
newmenu.m_kew.m_save.enabled = false

NewMenu.m_kew.PopMenu( parent.PointerX(), parent.PointerY() + 200 )
destroy MenuBOM











end event

type st_3 from statictext within w_bom110u
integer x = 2610
integer y = 44
integer width = 160
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

type sle_1 from singlelineedit within w_bom110u
event ue_keydown pbm_keydown
integer x = 2766
integer y = 28
integer width = 695
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type cb_insert from commandbutton within w_bom110u
integer x = 55
integer y = 176
integer width = 302
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입 력"
end type

event clicked;window ls_wsheet

ls_wsheet = w_frame.GetActiveSheet()
ls_wsheet.TriggerEvent("ue_insert")

end event

type cb_edit from commandbutton within w_bom110u
integer x = 402
integer y = 176
integer width = 302
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "수 정"
end type

event clicked;string 		ls_plant,ls_div, ls_itno1, ls_itno2, ls_date, ls_rtncd,ls_itclsb1,ls_srce1,ls_rtninv
integer  	ln_row, net,ln_count

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
is_sel = "C"

ls_rtncd = uo_plant.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div 	= mid(ls_rtncd,2,1)

if rb_1.checked = true then
	ln_row = dw_explo.getrow()
	if ln_row < 1 then
		uo_status.st_message.text = f_message("E030")
		return
	end if
	ls_itno1 	= dw_explo.getitemstring(ln_row,"ppitn") 
   	ls_itno2 	= dw_explo.getitemstring(ln_row,"pcitn")
	ls_date 	= dw_explo.getitemstring(ln_row,"pchdt")
end if
if rb_2.checked = true then
	ln_row = dw_implo.getrow()
	if ln_row < 1 then
		uo_status.st_message.text = f_message("E030")
		return
	end if
	ls_itno1 	=	dw_implo.getitemstring(ln_row,"ppitn") 
   	ls_itno2 	= 	dw_implo.getitemstring(ln_row,"pcitn")
	ls_date 	= 	dw_implo.getitemstring(ln_row,"pchdt")
end if

ls_rtninv 	= 	f_bom_get_balance(ls_plant, ls_div, ls_itno1)
ls_itclsb1 	= 	mid(ls_rtninv,1,2)
ls_srce1  	= 	mid(ls_rtninv,6,2)
dw_edit.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
if ls_srce1 = '03' or trim(ls_srce1) = '' then
	select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
	if	ln_count	>	0	then
		idwc_child.retrieve(g_s_empno)
	else
		idwc_child.insertrow(0) 
		idwc_child.setitem(1,"dac001_dcode",'')
		idwc_child.setitem(1,"dac001_dname",'')
		idwc_child.setitem(1,"display",'')
	end if
elseif ls_srce1 = '02' then
//	dw_edit.getchild("pwkct",idwc_child)
//	idwc_child.settransobject(sqlca)
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')
elseif ls_srce1 = '04' and ls_itclsb1 <> '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'9999')
	idwc_child.setitem(1,"dac001_dname",'무상사급')
	idwc_child.setitem(1,"display",'9999 무상사급')
elseif ls_srce1 = '04' and ls_itclsb1  =  '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')	
	idwc_child.insertrow(0) 
	idwc_child.setitem(2,"dac001_dcode",'9999')
	idwc_child.setitem(2,"dac001_dname",'무상사급')
	idwc_child.setitem(2,"display",'9999 무상사급')	
end if

wf_rgbclear()
dw_edit.retrieve(ls_plant,ls_div, ls_itno1, ls_itno2,ls_date)
dw_edit.setcolumn("pqtym")
dw_edit.object.pcitn.protect = true
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pexdv.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false

dw_edit.object.pcitn.border = 0
dw_edit.object.pqtym.border = 5
dw_edit.object.pwkct.border = 5
dw_edit.object.pexdv.border = 5
dw_edit.object.pedtm.border = 5
dw_edit.object.pedte.border = 5
uo_status.st_message.text = ""
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_insert.enabled = true
cb_edit.enabled = true
cb_delete.enabled = true
cb_expcopy.enabled = true
cb_impcopy.enabled = true
cb_retrieve.enabled = true
cb_save.enabled = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

type cb_impcopy from commandbutton within w_bom110u
integer x = 1454
integer y = 176
integer width = 320
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상위복사"
end type

event clicked;if	wf_emp_chk()	=	false	then
	return
end if

long ls_handle
treeviewitem l_tvi_item
string ls_ppitn, ls_plant, ls_div, ls_ppitn_01, ls_errchk, ls_parm,  ls_chkitno
string ls_rtncd
integer ln_rows, i, net

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

//if rb_1.checked = true then
//	messagebox("확인","조회구분을 재 선택후 작업을 하세요")
//	return
//end if

f_sysdate()

ls_rtncd = uo_plant.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div = mid(ls_rtncd,2,1)

ls_handle = tv_bom.finditem(CurrentTreeItem!, 0)
if ls_handle = -1 or ls_handle = 1 then
	ls_ppitn = upper(trim(sle_1.text))
else
	tv_bom.getitem(ls_handle,l_tvi_item)
   ls_ppitn = upper(trim(l_tvi_item.data))
end if
ls_ppitn_01 = mid(ls_ppitn,1,12)
ls_parm = ls_plant + ls_div + ls_ppitn_01 + ls_errchk

openwithparm(w_bom110u_res_02, ls_parm)

ls_parm = message.stringparm
ls_plant = mid(ls_parm,1,1)
ls_div = mid(ls_parm,2,1)
ls_ppitn = mid(ls_parm,3,12)
ls_errchk = mid(ls_parm,15,1)

if ls_errchk = "C" then
	uo_status.st_message.text = f_message("A030")
	return
end if
if ls_errchk = "E" then
	uo_status.st_message.text = f_message("E330")
	return
end if

uo_status.st_message.text = f_message("A010")

ls_chkitno = f_option_chk_after(ls_plant,ls_div,ls_ppitn,g_s_date) 	

if ls_chkitno <> "" then
	ls_parm = ""
   if f_option_check(ls_plant,ls_div,ls_chkitno) = 1 then
		ls_parm = ls_plant + ls_div + ls_chkitno 
      openwithparm(w_bom110u_res_04, ls_parm)	
	end if
end if

i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_insert.enabled = true
cb_edit.enabled = true
cb_delete.enabled = true
cb_expcopy.enabled = true
cb_impcopy.enabled = true
cb_retrieve.enabled = true
cb_save.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

type cb_delete from commandbutton within w_bom110u
integer x = 741
integer y = 176
integer width = 302
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭 제"
end type

event clicked;window ls_wsheet

ls_wsheet = w_frame.GetActiveSheet()
ls_wsheet.TriggerEvent("ue_delete")

end event

type cb_expcopy from commandbutton within w_bom110u
integer x = 1093
integer y = 176
integer width = 320
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "하위복사"
end type

event clicked;if	wf_emp_chk()	=	false	then
	return
end if

long 		ln_handle
string 	ls_ppitn,ls_plant,ls_div,ls_ppitn_01,ls_errchk,ls_parm,ls_rtncd
long   	ld_pqtym,ld_pqtye		 
integer 	ln_rows,i,net
treeviewitem l_tvi_item

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
//if rb_2.checked = true then
//	messagebox("확인","조회구분을 재 선택후 작업을 하세요")
//	return
//end if

f_sysdate()
ls_rtncd = uo_plant.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div 	= mid(ls_rtncd,2,1)

ln_handle	= tv_bom.finditem(CurrentTreeItem!, 0)
if ln_handle = -1 or ln_handle = 1 then
	ls_ppitn	= upper(trim(sle_1.text))
else
	tv_bom.getitem(ln_handle,l_tvi_item)
   ls_ppitn = upper(trim(l_tvi_item.data))
end if
ls_ppitn_01 = mid(ls_ppitn,1,12)
ls_parm 		= ls_plant + ls_div + ls_ppitn_01 + ls_errchk

openwithparm(w_bom110u_res_01, ls_parm)

ls_parm 		= message.stringparm
ls_div 		= mid(ls_parm,1,1)
ls_ppitn 	= mid(ls_parm,2,12)
ls_errchk 	= mid(ls_parm,14,1)

if ls_errchk = "C" then
	uo_status.st_message.text = f_message("A030")
	return
end if
if ls_errchk = "E" then
	uo_status.st_message.text = f_message("E330")
	return
end if

uo_status.st_message.text = f_message("A010")

i_b_retrieve 	= true  
i_b_insert 		= true
i_b_delete 		= true
i_b_save 		= false
cb_insert.enabled 	= true
cb_edit.enabled 	= true
cb_delete.enabled 	= true
cb_expcopy.enabled 	= true
cb_impcopy.enabled 	= true
cb_retrieve.enabled 	= true
cb_save.enabled 	= false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

type dw_edit from datawindow within w_bom110u
event keydown pbm_keydown
event ue_keydown pbm_keydown
integer x = 1504
integer y = 1568
integer width = 3095
integer height = 892
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_bom001_110u_update"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;MenuBOM NewMenu

NewMenu = CREATE MenuBOM
newmenu.m_kew.m_insert.enabled = false
newmenu.m_kew.m_delete.enabled = false
newmenu.m_kew.m_retrieve.enabled = false
NewMenu.m_kew.PopMenu( parent.pointerx(), parent.pointery() + 200)
destroy MenuBOM

end event

event itemchanged;integer li_rtn
window ls_wsheet

if KeyDown(KeyEnter!) = true then
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_save")
end if

if dwo.name = 'pexplant' then
	dw_edit.getchild("pexdv",idwc_child)
	idwc_child.settransobject(sqlca)
	idwc_child.retrieve(data)
end if
end event

event constructor;dw_edit.settransobject(sqlca)
dw_edit.getchild("pexplant",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.retrieve('SLE220')
dw_edit.getchild("pexdv",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.retrieve('D')


end event

event clicked;if dwo.name	=	'p_calendar_from' then
	openwithparm(w_bom_calendar,string(this.object.pedtm[1]))
	if	f_spacechk(trim(message.stringparm))	<>	-1	then
		this.object.pedtm[1] 		= trim(message.stringparm)
	end if
elseif dwo.name	=	'p_calendar_to' then
	openwithparm(w_bom_calendar,string(this.object.pedte[1]))
	if	f_spacechk(trim(message.stringparm))	<>	-1	then
		this.object.pedte[1] 		= trim(message.stringparm)
	end if
end if
end event

event retrievestart;//string 	ls_div,ls_plant,ls_itno1,ls_rtncd,ls_srce1,ls_itclsb1,ls_rtninv
//int    	net,ln_count
//
//ls_rtncd 	= 	uo_plant.uf_return()
//ls_div 		= 	mid(ls_rtncd,2,1)
//ls_plant 	= 	mid(ls_rtncd,1,1)
//ls_itno1	=	trim(this.object.ppitn[1])
//ls_rtninv 	= 	f_bom_get_balance(ls_plant, ls_div, ls_itno1)
//ls_itclsb1 	= 	mid(ls_rtninv,1,2)
//ls_srce1  	= 	mid(ls_rtninv,6,2)
//dw_edit.getchild("pwkct",idwc_child)
//idwc_child.settransobject(sqlca)
//idwc_child.reset()
//if ls_srce1 = '03' or trim(ls_srce1) = '' then
//	select	count(*)	into	:ln_count	from pbpdm.bom014
//	where	comltd	=	'01'	and	empno	=	:g_s_empno
//	using	sqlca	;
//	if	ln_count	>	0	then
//		idwc_child.retrieve(g_s_empno)
//	else
//		idwc_child.insertrow(0) 
//		idwc_child.setitem(1,"dac001_dcode",'')
//		idwc_child.setitem(1,"dac001_dname",'')
//		idwc_child.setitem(1,"display",'')
//	end if
//elseif ls_srce1 = '02' then
////	dw_edit.getchild("pwkct",idwc_child)
////	idwc_child.settransobject(sqlca)
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(1,"dac001_dcode",'8888')
//	idwc_child.setitem(1,"dac001_dname",'유상사급')
//	idwc_child.setitem(1,"display",'8888 유상사급')
//elseif ls_srce1 = '04' and ls_itclsb1 <> '10' then
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(1,"dac001_dcode",'9999')
//	idwc_child.setitem(1,"dac001_dname",'무상사급')
//	idwc_child.setitem(1,"display",'9999 무상사급')
//elseif ls_srce1 = '04' and ls_itclsb1  =  '10' then
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(1,"dac001_dcode",'8888')
//	idwc_child.setitem(1,"dac001_dname",'유상사급')
//	idwc_child.setitem(1,"display",'8888 유상사급')	
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(2,"dac001_dcode",'9999')
//	idwc_child.setitem(2,"dac001_dname",'무상사급')
//	idwc_child.setitem(2,"display",'9999 무상사급')	
//end if
end event

type rb_1 from radiobutton within w_bom110u
integer x = 4187
integer y = 188
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
string text = "하위 조회"
boolean checked = true
end type

type rb_2 from radiobutton within w_bom110u
integer x = 3776
integer y = 188
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
string text = "상위 조회"
end type

type cb_retrieve from commandbutton within w_bom110u
integer x = 2162
integer y = 176
integer width = 302
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조 회"
end type

event clicked;window ls_wsheet
ls_wsheet = w_frame.GetActiveSheet()
ls_wsheet.TriggerEvent("ue_retrieve")

end event

type cb_save from commandbutton within w_bom110u
integer x = 1824
integer y = 176
integer width = 302
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장"
end type

event clicked;window ls_wsheet

ls_wsheet = w_frame.GetActiveSheet()
ls_wsheet.TriggerEvent("ue_save")

end event

type pb_find from picturebutton within w_bom110u
integer x = 3493
integer y = 20
integer width = 238
integer height = 108
integer taborder = 150
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
vtextalign vtextalign = top!
end type

event clicked;string l_s_parm, l_s_div, l_s_pdcd, l_s_plant
int net
if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

l_s_plant 	= uo_plant.uf_return()
l_s_div 		= mid(l_s_plant,2,1)
l_s_pdcd  	= mid(l_s_plant,3)
l_s_plant 	= mid(l_s_plant,1,1)

l_s_parm = l_s_plant + l_s_div + l_s_pdcd

openwithparm(w_bom110u_res_03,l_s_parm)

l_s_parm = message.stringparm
sle_1.text = l_s_parm

end event

type gb_2 from groupbox within w_bom110u
integer x = 3744
integer y = 124
integer width = 850
integer height = 164
integer taborder = 20
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

type gb_framemove from groupbox within w_bom110u
event ue_gbmousedown pbm_lbuttondown
event ue_gbmousemove pbm_mousemove
event ue_gbmouseup pbm_lbuttonup
boolean visible = false
integer x = 9
integer y = 304
integer width = 1499
integer height = 2176
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
end type

event ue_gbmousedown;setpointer(sizeWE!)
end event

event ue_gbmousemove;integer li_border, li_curwidth
li_border = this.x + this.width
//if (li_border - 20) <= xpos and (li_border + 20) >= xpos then
setpointer(sizeWE!)
//end if
if flags = 1 then
	li_curwidth = this.width + (xpos - this.width)
	this.resize( li_curwidth,this.height)
end if
end event

event ue_gbmouseup;integer li_tvwidth,li_lvwidth
li_tvwidth = xpos - (tv_bom.x + tv_bom.width) 
tv_bom.resize((tv_bom.width + li_tvwidth - 20),tv_bom.height)
li_lvwidth = 3607 - (xpos + 9)
dw_explo.x = xpos + 9
dw_explo.width = li_lvwidth
dw_implo.x = xpos + 9
dw_implo.width = li_lvwidth
dw_edit.x = xpos + 9
dw_edit.width = li_lvwidth

end event

event constructor;this.x = 14
this.y = 224
this.width = 1499
this.height = 1650
end event

type dw_explo from datawindow within w_bom110u
integer x = 1499
integer y = 312
integer width = 3095
integer height = 1236
integer taborder = 110
string title = "none"
string dataobject = "d_bom001_explo_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string 	ls_div,ls_plant,ls_itno1,ls_itno2,ls_chdt,ls_rtncd,ls_srce1,ls_itclsb1,ls_rtninv,ls_itclsb2,ls_srce2
int    	net,ln_count

if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
this.selectrow(row,true)
is_sel 		= 	"C"
ls_rtncd 	= 	uo_plant.uf_return()
ls_div 		= 	mid(ls_rtncd,2,1)
ls_plant 	= 	mid(ls_rtncd,1,1)
ls_itno1 	= 	dw_explo.getitemstring(row,"ppitn") 
ls_itno2 	= 	dw_explo.getitemstring(row,"pcitn")
ls_chdt 	= 	dw_explo.getitemstring(row,"pchdt")
ls_rtninv 	= 	f_bom_get_balance(ls_plant, ls_div, ls_itno1)
ls_itclsb1 	= 	mid(ls_rtninv,1,2)
ls_srce1  	= 	mid(ls_rtninv,6,2)
dw_edit.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
if ls_srce1 = '03' or trim(ls_srce1) = '' then
	select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
	if	ln_count	>	0	then
		idwc_child.retrieve(g_s_empno)
	else
		idwc_child.insertrow(0) 
		idwc_child.setitem(1,"dac001_dcode",'')
		idwc_child.setitem(1,"dac001_dname",'')
		idwc_child.setitem(1,"display",'')
	end if
elseif ls_srce1 = '02' then
//	dw_edit.getchild("pwkct",idwc_child)
//	idwc_child.settransobject(sqlca)
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')
elseif ls_srce1 = '04' and ls_itclsb1 <> '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'9999')
	idwc_child.setitem(1,"dac001_dname",'무상사급')
	idwc_child.setitem(1,"display",'9999 무상사급')
elseif ls_srce1 = '04' and ls_itclsb1  =  '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')	
	idwc_child.insertrow(0) 
	idwc_child.setitem(2,"dac001_dcode",'9999')
	idwc_child.setitem(2,"dac001_dname",'무상사급')
	idwc_child.setitem(2,"display",'9999 무상사급')	
end if

wf_rgbclear()
dw_edit.retrieve(ls_plant,ls_div, ls_itno1, ls_itno2,ls_chdt)
ls_rtninv 	= 	f_bom_get_balance(ls_plant, ls_div, ls_itno2)
ls_itclsb2 	= 	mid(ls_rtninv,1,2)
ls_srce2   	= 	mid(ls_rtninv,6,2)

dw_edit.object.pexplant.protect 	= false
dw_edit.object.pexdv.protect 		= false
dw_edit.object.pcitn.protect = true
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false
dw_edit.setfocus()
dw_edit.setcolumn("pqtym")
uo_status.st_message.text = ""
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_insert.enabled = true
cb_edit.enabled = true
cb_delete.enabled = true
cb_expcopy.enabled = true
cb_impcopy.enabled = true
cb_retrieve.enabled = true
cb_save.enabled = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

event clicked;if row <= 0 then
	return
end if
dw_edit.reset()
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event rbuttondown;MenuBOM NewMenu

NewMenu = CREATE MenuBOM
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_insert.enabled = false
newmenu.m_kew.m_save.enabled = false

NewMenu.m_kew.PopMenu( parent.pointerx(), parent.pointery() + 200 )
destroy MenuBOM

end event

event constructor;dw_explo.settransobject(sqlca)

end event

event retrieveend;string ls_midval
integer i

for i = 1 to rowcount
	ls_midval = f_option_chk_after(this.object.plant[i],this.object.pdvsn[i],trim(this.object.pcitn[i]),g_s_date) 
	if f_spacechk(ls_midval) <> -1 then
		if trim(ls_midval) = trim(this.object.pcitn[i]) then
			ls_midval = '*'
		end if
	end if
	this.object.opt_itno[i] = ls_midval
next


end event

type dw_implo from datawindow within w_bom110u
boolean visible = false
integer x = 1504
integer y = 316
integer width = 3099
integer height = 1244
integer taborder = 160
string dataobject = "d_bom001_implo_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string 		ls_div,ls_plant, ls_itno1, ls_itno2, ls_chdt,ls_rtninv,ls_srce1,ls_itclsb1,ls_srce2,ls_itclsb2
integer 	net,ln_count
if i_s_level = "5" then
	dw_edit.accepttext()
	if dw_edit.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
this.selectrow(row,true)
is_sel = "C"

ls_plant 		= uo_plant.uf_return()
ls_div 			= mid(ls_plant,2,1)
ls_plant 		= mid(ls_plant,1,1)
ls_itno1 		= dw_implo.getitemstring(row,"ppitn") 
ls_itno2 		= dw_implo.getitemstring(row,"pcitn")
ls_chdt 		= dw_implo.getitemstring(row,"pchdt")
ls_rtninv 		= f_bom_get_balance(ls_plant, ls_div, ls_itno1)
ls_itclsb1 		= mid(ls_rtninv,1,2)
ls_srce1   	= mid(ls_rtninv,6,2)
dw_edit.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
if ls_srce1 = '03' or trim(ls_srce1) = '' then
	select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
	if	ln_count	>	0	then
		idwc_child.retrieve(g_s_empno)
	else
		idwc_child.insertrow(0) 
		idwc_child.setitem(1,"dac001_dcode",'')
		idwc_child.setitem(1,"dac001_dname",'')
		idwc_child.setitem(1,"display",'')
	end if
elseif ls_srce1 = '02' then
//	dw_edit.getchild("pwkct",idwc_child)
//	idwc_child.settransobject(sqlca)
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')
elseif ls_srce1 = '04' and ls_itclsb1 <> '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'9999')
	idwc_child.setitem(1,"dac001_dname",'무상사급')
	idwc_child.setitem(1,"display",'9999 무상사급')
elseif ls_srce1 = '04' and ls_itclsb1  =  '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')	
	idwc_child.insertrow(0) 
	idwc_child.setitem(2,"dac001_dcode",'9999')
	idwc_child.setitem(2,"dac001_dname",'무상사급')
	idwc_child.setitem(2,"display",'9999 무상사급')	
end if
wf_rgbclear()
dw_edit.retrieve(ls_plant,ls_div, ls_itno1, ls_itno2,ls_chdt)
ls_rtninv 	= 	f_bom_get_balance(ls_plant, ls_div, ls_itno2)
ls_itclsb2 	= 	mid(ls_rtninv,1,2)
ls_srce2   	= 	mid(ls_rtninv,6,2)

dw_edit.object.pexplant.protect 	= false
dw_edit.object.pexdv.protect 		= false
dw_edit.object.pcitn.protect 			= true
dw_edit.object.pqtym.protect 			= false
dw_edit.object.pwkct.protect 			= false
dw_edit.object.pedtm.protect 			= false
dw_edit.object.pedte.protect 			= false
dw_edit.setfocus()
dw_edit.setcolumn("pqtym")
uo_status.st_message.text = ""
i_b_retrieve 	= true  
i_b_insert 		= true
i_b_delete 		= true
i_b_save 		= true
cb_insert.enabled 	= true
cb_edit.enabled 	= true
cb_delete.enabled 	= true
cb_expcopy.enabled 	= true
cb_impcopy.enabled 	= true
cb_retrieve.enabled 	= true
cb_save.enabled 	= true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )



end event

event clicked;if row <= 0 then
	return
end if
dw_edit.reset()
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event rbuttondown;MenuBOM NewMenu

NewMenu 	= CREATE MenuBOM
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_insert.enabled 	= false
newmenu.m_kew.m_save.enabled 		= false
NewMenu.m_kew.PopMenu( parent.pointerx(), parent.pointery() + 200 )
destroy MenuBOM

end event

event constructor;dw_implo.settransobject(sqlca)

end event

event retrieveend;string 	ls_midval
integer 	i

for i = 1 to rowcount
	ls_midval = f_option_chk_after(this.object.plant[i],this.object.pdvsn[i],trim(this.object.pcitn[i]),g_s_date) 
	if f_spacechk(ls_midval) <> -1 then
		if trim(ls_midval) 	= trim(this.object.pcitn[i]) then
			ls_midval = '*'
		end if
	end if
	this.object.opt_itno[i] = ls_midval
next

end event

type uo_plant from uo_plandiv_pdcd within w_bom110u
integer x = 27
integer y = 8
boolean bringtotop = true
end type

on uo_plant.destroy
call uo_plandiv_pdcd::destroy
end on

type cb_filter from commandbutton within w_bom110u
integer x = 2885
integer y = 176
integer width = 448
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
end type

event clicked;open(w_bom_dept_filter)
end event

type st_1 from statictext within w_bom110u
integer x = 2894
integer y = 196
integer width = 430
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "투입처FILTER"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_change from commandbutton within w_bom110u
integer x = 2496
integer y = 176
integer width = 352
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
end type

event clicked;if	wf_emp_chk()	=	false	then
	return
end if

treeviewitem	l_tvi_item
string			ls_rtncd,ls_div,ls_plant,ls_itclsb,ls_srce,ls_pcitn,ls_parm,ls_errchk
long			ln_handle

ls_rtncd 		= 	uo_plant.uf_return()
ls_div  		= 	mid(ls_rtncd,2,1)
ls_plant 		= 	mid(ls_rtncd,1,1)
ln_handle 	= 	tv_bom.finditem(CurrentTreeItem!, 0)
if ln_handle 	= 	-1 or ln_handle = 1 then
	ls_pcitn 	= 	upper(trim(sle_1.text))
else
	tv_bom.getitem(ln_handle,l_tvi_item)
	ls_pcitn = upper(trim(l_tvi_item.data))
end if
if f_spacechk(ls_pcitn) = -1 then
	uo_status.st_message.text = f_message("E320")
	return 0
end if
ls_rtncd 		= 	f_bom_get_balance(ls_plant,ls_div,ls_pcitn)
ls_itclsb 		= 	mid(ls_rtncd,1,2)
ls_srce   		= 	mid(ls_rtncd,6,2)
if rb_1.checked =	true then
	if ls_itclsb = '10' and ls_srce <> '03' then
		// 하위품번 유/무상 수정
		ls_parm 	= 	ls_plant + ls_div + ls_pcitn + ls_errchk
		openwithparm(w_bom110u_res_06,ls_parm)
		ls_parm 		= 	message.stringparm
		ls_errchk 		= 	mid(ls_parm,15,1)
		if	ls_errchk	=	'C'	then
		elseif	ls_errchk	=	'E'	then
			messagebox("확인","해당 품번의 하위 BOM 이 구성되어 있지 않습니다")
			return
		elseif	ls_errchk	=	''	then
			dw_edit.reset()
			dw_explo.reset()
			dw_explo.retrieve(ls_plant,ls_div,ls_pcitn,g_s_date)
		end if
	else
		uo_status.st_message.text = "유/무상 전환을 할수 없는 품번입니다."
		return -1
	end if
else
	if ls_itclsb = '10' then
		// 상위품번 유/무상 수정
		ls_parm 	= 	ls_plant + ls_div + ls_pcitn + ls_errchk
		openwithparm(w_bom110u_res_05,ls_parm)
		ls_parm 		= 	message.stringparm
		ls_errchk 		= 	mid(ls_parm,15,1)
		if	ls_errchk	=	'C'	then
		elseif	ls_errchk	=	'E'	then
			messagebox("확인","해당 품번의 상위 BOM 이 구성되어 있지 않습니다")
			return
		elseif	ls_errchk	=	''	then
			dw_edit.reset()
			dw_implo.reset()
			dw_implo.retrieve(ls_plant,ls_div,ls_pcitn,g_s_date)
		end if
	else
		uo_status.st_message.text = "유/무상 전환을 할수 없는 품번입니다."
		return -1
	end if
end if

return 0
end event

type st_2 from statictext within w_bom110u
integer x = 2510
integer y = 196
integer width = 311
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "유무상전환"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_pl from commandbutton within w_bom110u
integer x = 3365
integer y = 176
integer width = 302
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
end type

event clicked;open(w_bom_select_pl)
end event

type st_4 from statictext within w_bom110u
integer x = 3365
integer y = 196
integer width = 297
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "P/L선택"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bom110u
integer x = 14
integer y = 120
integer width = 3703
integer height = 164
integer taborder = 130
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

