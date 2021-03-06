$PBExportHeader$w_piss221u.srw
$PBExportComments$BACKSHIP
forward
global type w_piss221u from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_piss221u
end type
type uo_area from u_pisc_select_area within w_piss221u
end type
type uo_date from u_pisc_date_applydate within w_piss221u
end type
type st_8 from statictext within w_piss221u
end type
type uo_scustgubun from u_pisc_select_code within w_piss221u
end type
type uo_custcode from u_piss_select_custcode within w_piss221u
end type
type st_10 from statictext within w_piss221u
end type
type st_2 from statictext within w_piss221u
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss221u
end type
type sle_citno from singlelineedit within w_piss221u
end type
type st_11 from statictext within w_piss221u
end type
type ddlb_gubun from dropdownlistbox within w_piss221u
end type
type dw_save from datawindow within w_piss221u
end type
type dw_print from datawindow within w_piss221u
end type
type dw_3 from datawindow within w_piss221u
end type
type gb_1 from groupbox within w_piss221u
end type
type sle_1 from singlelineedit within w_piss221u
end type
type dw_4 from datawindow within w_piss221u
end type
type st_3 from statictext within w_piss221u
end type
type st_4 from statictext within w_piss221u
end type
type gb_2 from groupbox within w_piss221u
end type
type dw_sheet from u_vi_std_datawindow within w_piss221u
end type
type dw_2 from datawindow within w_piss221u
end type
type pb_excel from picturebutton within w_piss221u
end type
type rb_1 from radiobutton within w_piss221u
end type
type rb_2 from radiobutton within w_piss221u
end type
type gb_3 from groupbox within w_piss221u
end type
type gb_4 from groupbox within w_piss221u
end type
end forward

global type w_piss221u from w_ipis_sheet01
integer width = 4654
integer height = 2736
string title = ""
event ue_postopen ( )
uo_division uo_division
uo_area uo_area
uo_date uo_date
st_8 st_8
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
st_10 st_10
st_2 st_2
uo_1 uo_1
sle_citno sle_citno
st_11 st_11
ddlb_gubun ddlb_gubun
dw_save dw_save
dw_print dw_print
dw_3 dw_3
gb_1 gb_1
sle_1 sle_1
dw_4 dw_4
st_3 st_3
st_4 st_4
gb_2 gb_2
dw_sheet dw_sheet
dw_2 dw_2
pb_excel pb_excel
rb_1 rb_1
rb_2 rb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_piss221u w_piss221u

type variables
string is_date,is_date1, is_today,is_dtype = 'C'
int ii_window_border = 10
boolean ib_open
string is_areacode,is_divisioncode
LONG il_row,il_rcqty
string is_citno,is_custgubun,is_custcode,is_itemcode,is_stype,is_suse
long il_normalqty,il_repairqty,il_defectqty
string is_new
end variables

forward prototypes
public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount)
public function boolean wf_err_check ()
public function boolean wf_delete_tinv ()
public function boolean wf_delete ()
public function boolean wf_update_tinv ()
public function boolean wf_delete_tshipback ()
public function boolean wf_update_tshipback ()
public function boolean wf_save ()
public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty, string fs_date)
public function boolean wf_update_tlotno ()
public function boolean wf_delete_tlotno (string fs_lotno, long fl_shipqty)
end prototypes

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_4.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
ddlb_gubun.text = 'A 전체'
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_sheet.reset()
dw_2.reset()

end event

public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount);long ll_workspace, ll_width
integer li_i
string ls_position = ''

ll_workspace = (fl_printsize - fl_leftmargin) 

ll_width = ll_workspace / ( fi_modifycount + 1 )

FOR li_i = 1 TO fi_modifycount

	ls_position		= ls_position +&
						"qty"+String(li_i)+"_t.X = '"+ string( fl_startpoint + 5 * (li_i -1) + ll_width * (li_i - 1))+ " ' " + &
						"qty"+String(li_i)+".X = '"+ string( fl_startpoint + 5 * (li_i -1) + ll_width * (li_i - 1))+ " ' "
NEXT


return ls_position
end function

public function boolean wf_err_check ();dw_2.accepttext()
long ll_count,ll_normalqty,ll_defectqty,ll_repairqty
string ls_cancelconfirmdate,ls_billno

ll_count = dw_2.rowcount()
if ll_count <= 0 then
   return false
end if

ll_normalqty = dw_2.object.normalqty[1]
ll_defectqty = dw_2.object.defectqty[1]
ll_repairqty = dw_2.object.repairqty[1]
ls_billno    = dw_2.object.billno[1]
ls_cancelconfirmdate = dw_2.object.cancelconfirmdate[1]

if ll_normalqty + ll_defectqty + ll_repairqty = 0 then
	messagebox("확인","수량을 입력하세요.")
	dw_2.setfocus()
	dw_2.setcolumn('normalqty')
	return false
end if

if ll_normalqty + ll_defectqty + ll_repairqty <> il_rcqty then
	messagebox("확인","수량을 확인하세요�.")
	dw_2.setfocus()
	dw_2.setcolumn('normalqty')
	return false
end if
if ls_billno = '' or isnull(ls_billno) then
else
	if isdate(ls_cancelconfirmdate) then
	else
		messagebox("확인","취소일자를 확인하세요.")
		dw_2.setfocus()
		dw_2.setcolumn('cancelconfirmdate')
		return false
	end if
end if	
return true
end function

public function boolean wf_delete_tinv ();long ll_normalqty,ll_repairqty,ll_defectqty,ll_count

ll_normalqty = dw_2.object.normalqty[1]
ll_repairqty = dw_2.object.repairqty[1]
ll_repairqty = dw_2.object.repairqty[1]

select count(*)
  into :ll_count
  from tinv
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and itemcode = :is_itemcode
	using sqlpis;

if ll_count = 0 then
	insert into tinv
	     (areacode,divisioncode,itemcode,invqty,repairqty,defectqty,lastemp,lastdate)
		 values
		 (:is_areacode,:is_divisioncode,:is_itemcode,:ll_normalqty *-1,:ll_repairqty *-1,:ll_defectqty *-1,:g_s_empno,getdate())
		 using sqlpis;
else
   update tinv
	   set invqty    = invqty    - :ll_normalqty,
		    repairqty = repairqty - :ll_repairqty,
			 defectqty = defectqty - :ll_defectqty
    where areacode = :is_areacode
      and divisioncode = :is_divisioncode
	   and itemcode = :is_itemcode
	   using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tinv error"
	return false
end if
return true
end function

public function boolean wf_delete ();string ls_billno,ls_itemtype_check
ls_billno = dw_2.object.billno[1]
dw_2.accepttext()
dw_3.reset()
long ll_readingqty
if wf_delete_tshipback() then
else
	return false
end if
ls_itemtype_check = f_piss_itemtype_check(is_areacode,is_divisioncode,is_itemcode)
if ls_itemtype_check <> '2' THEN  //단품이 아니면
	if wf_delete_tinv() then
	else
		return false
	end if
END IF
//if wf_update_tkb() then
//else
//	return false
//end if
ll_readingqty = dw_2.object.rcqty[1]
if wf_delete_tlotno('XXXXXX',ll_readingqty) then
else
	return false
end if

return true
end function

public function boolean wf_update_tinv ();long ll_normalqty,ll_repairqty,ll_defectqty,ll_count

ll_normalqty = dw_2.object.normalqty[1]
ll_repairqty = dw_2.object.repairqty[1]
ll_defectqty = dw_2.object.defectqty[1]

select count(*)
  into :ll_count
  from tinv
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and itemcode = :is_itemcode
	using sqlpis;

if ll_count = 0 then
	insert into tinv
	     (areacode,divisioncode,itemcode,invqty,repairqty,defectqty,lastemp,lastdate)
		 values
		 (:is_areacode,:is_divisioncode,:is_itemcode,:ll_normalqty,:ll_repairqty,:ll_defectqty,'Y',getdate())
		 using sqlpis;
else
   update tinv
	   set invqty    = invqty + :ll_normalqty,
		    repairqty = repairqty + :ll_repairqty,
			 defectqty = defectqty + :ll_defectqty,
			 lastdate  = getdate(),
			 lastemp   = 'Y'
    where areacode     = :is_areacode
      and divisioncode = :is_divisioncode
	   and itemcode     = :is_itemcode
	   using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
  	uo_status.st_message.text = "tinv error"
	return false
end if
return true
end function

public function boolean wf_delete_tshipback ();string ls_billno,ls_max_billno,ls_date,ls_seq,ls_cancelconfirmdate,ls_csrno
string ls_srno,ls_csrno1,ls_csrno2
long ll_normalqty,ll_repairqty,ll_defectqty,ll_seqno
ls_billno = dw_2.object.billno[1]
ll_normalqty = dw_2.object.normalqty[1]
ll_repairqty = dw_2.object.repairqty[1]
ll_defectqty = dw_2.object.defectqty[1]
ls_csrno     = dw_2.object.csrno[1]
ls_csrno1    = dw_2.object.csrno1[1]
ls_csrno2    = dw_2.object.csrno2[1]
ls_srno      = dw_2.object.srno[1]
ls_cancelconfirmdate = dw_2.object.cancelconfirmdate[1]

update tshipback
  set  normalqty = 0,
		 repairqty = 0,
		 defectqty = 0,
		 cancelconfirmdate = null,
		 lastemp = 'Y',
		 lastdate = getdate()
 where xplant  = :is_areacode
   and div     = :is_divisioncode
	and csrno   = :ls_csrno
 using sqlpis;
if sqlpis.sqlcode <> 0 then
  	uo_status.st_message.text = "tshipback error"
   return false
end if	
dw_sheet.setredraw(false)
dw_sheet.object.normalqty[il_row] = 0
dw_sheet.object.repairqty[il_row] = 0
dw_sheet.object.defectqty[il_row] = 0
dw_sheet.setredraw(true)
select max(seqno)
  into :ll_seqno
  from tshipback_interface
 where csrno = :ls_csrno
   and csrno1 = :ls_csrno1
	and csrno2 = :ls_csrno2
	and srno   = :ls_srno
  using sqlpis;
if isnull(ll_seqno)  then
	ll_seqno = 0
end if

if ll_normalqty > 0 then //정품 
  ll_seqno = ll_seqno + 1
  INSERT INTO TSHIPBACK_INTERFACE  
         ( CSRNO,CSRNO1,CSRNO2,SRNo,BillNo,InvGubunFlag,SeqNo,   
           MISFlag,InterfaceFlag,CancelConfirmDate,CancelQty,   
           LastEmp,LastDate,shipgubun )  
  VALUES ( :ls_csrno,:ls_csrno1,:ls_csrno2,:ls_srno,:ls_billno,'N',:ll_seqno,
           'D','Y',:ls_cancelconfirmdate,:ll_normalqty,   
           :g_s_empno,getdate(),:is_dtype )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
   	uo_status.st_message.text = "tshipback_interface error"
		return false
   end if
end if
if ll_repairqty > 0 then //요수리
  ll_seqno = ll_seqno + 1
  INSERT INTO TSHIPBACK_INTERFACE  
         ( CSRNO,CSRNO1,CSRNO2,SRNo,BillNo,InvGubunFlag,SeqNo,   
           MISFlag,InterfaceFlag,CancelConfirmDate,CancelQty,   
           LastEmp,LastDate,shipgubun )  
  VALUES ( :ls_csrno,:ls_csrno1,:ls_csrno2,:ls_srno,:ls_billno,'R',:ll_seqno,
           'D','Y',:ls_cancelconfirmdate,:ll_repairqty,   
           :g_s_empno,getdate(),:is_dtype )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
   	uo_status.st_message.text = "tshipback_interface error"
		return false
   end if
end if
if ll_defectqty > 0 then //폐품
  ll_seqno = ll_seqno + 1
  INSERT INTO TSHIPBACK_INTERFACE  
         ( CSRNO,CSRNO1,CSRNO2,SRNo,BillNo,InvGubunFlag,SeqNo,   
           MISFlag,InterfaceFlag,CancelConfirmDate,CancelQty,   
           LastEmp,LastDate,shipgubun )  
  VALUES ( :ls_csrno,:ls_csrno1,:ls_csrno2,:ls_srno,:ls_billno,'D',:ll_seqno,
           'D','Y',:ls_cancelconfirmdate,:ll_defectqty,   
           :g_s_empno,getdate(),:is_dtype )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
   	uo_status.st_message.text = "tshipback_interface error"
		return false
   end if
end if

return true
end function

public function boolean wf_update_tshipback ();string ls_billno,ls_max_billno,ls_date,ls_seq,ls_cancelconfirmdate,ls_csrno
string ls_srno,ls_csrno1,ls_csrno2
long ll_normalqty,ll_repairqty,ll_defectqty,ll_seqno
ls_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_billno = dw_2.object.billno[1]
if ls_billno = '' or isnull(ls_billno) then
	select max(billno)
	  into :ls_max_billno
	  from tshipback
	 where xplant = :is_areacode
		and div = :is_divisioncode
		and cancelconfirmdate like substring(:ls_date,1,7) + '%'
	 using sqlpis;
	if ls_max_billno = '' or isnull(ls_max_billno) then
		ls_seq = '0000'
	else
		ls_seq = right(ls_max_billno,4)
	end if
	f_pisc_get_string_add(ls_seq,ls_seq)
	ls_billno = is_areacode + is_divisioncode + is_stype + mid(ls_date,4,1) + mid(ls_date,6,2) + ls_seq
	dw_2.object.billno[1] = ls_billno
	dw_2.object.cancelconfirmdate[1] = ls_date
end if
ll_normalqty = dw_2.object.normalqty[1]
ll_repairqty = dw_2.object.repairqty[1]
ll_defectqty = dw_2.object.defectqty[1]
ls_csrno     = dw_2.object.csrno[1]
ls_csrno1    = dw_2.object.csrno1[1]
ls_csrno2    = dw_2.object.csrno2[1]
ls_srno      = dw_2.object.srno[1]
ls_cancelconfirmdate = dw_2.object.cancelconfirmdate[1]

update tshipback
  set  billno = :ls_billno,
       normalqty = :ll_normalqty,
		 repairqty = :ll_repairqty,
		 defectqty = :ll_defectqty,
		 cancelconfirmdate = :ls_cancelconfirmdate,
		 lastemp = 'Y',
		 lastdate = getdate()
 where xplant  = :is_areacode
   and div     = :is_divisioncode
	and csrno   = :ls_csrno
 using sqlpis;
if sqlpis.sqlcode <> 0 then
  	uo_status.st_message.text = "tshipback error"	
   return false
end if	
dw_sheet.setredraw(false)
dw_sheet.object.normalqty[il_row] = ll_normalqty  
dw_sheet.object.repairqty[il_row] = ll_repairqty  
dw_sheet.object.defectqty[il_row] = ll_defectqty  
dw_sheet.setredraw(true)
select max(seqno)
  into :ll_seqno
  from tshipback_interface
 where csrno = :ls_csrno
   and csrno1 = :ls_csrno1
	and csrno2 = :ls_csrno2
	and srno   = :ls_srno
  using sqlpis;
if isnull(ll_seqno)  then
	ll_seqno = 0
end if

if ll_normalqty > 0 then //정품 
  ll_seqno = ll_seqno + 1
  INSERT INTO TSHIPBACK_INTERFACE  
         ( CSRNO,CSRNO1,CSRNO2,SRNo,BillNo,InvGubunFlag,SeqNo,   
           MISFlag,InterfaceFlag,CancelConfirmDate,CancelQty,   
           LastEmp,LastDate,shipgubun )  
  VALUES ( :ls_csrno,:ls_csrno1,:ls_csrno2,:ls_srno,:ls_billno,'N',:ll_seqno,
           'A','Y',:ls_cancelconfirmdate,:ll_normalqty,   
           :g_s_empno,getdate(),:is_dtype )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
   	uo_status.st_message.text = "tshipback_interface error"
		return false
   end if
end if
if ll_repairqty > 0 then //요수리
  ll_seqno = ll_seqno + 1
  INSERT INTO TSHIPBACK_INTERFACE  
         ( CSRNO,CSRNO1,CSRNO2,SRNo,BillNo,InvGubunFlag,SeqNo,   
           MISFlag,InterfaceFlag,CancelConfirmDate,CancelQty,   
           LastEmp,LastDate,shipgubun )  
  VALUES ( :ls_csrno,:ls_csrno1,:ls_csrno2,:ls_srno,:ls_billno,'R',:ll_seqno,
           'A','Y',:ls_cancelconfirmdate,:ll_repairqty,   
           :g_s_empno,getdate(),:is_dtype )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
   	uo_status.st_message.text = "tshipback_interface error"
		return false
   end if
end if
if ll_defectqty > 0 then //폐품
  ll_seqno = ll_seqno + 1
  INSERT INTO TSHIPBACK_INTERFACE  
         ( CSRNO,CSRNO1,CSRNO2,SRNo,BillNo,InvGubunFlag,SeqNo,   
           MISFlag,InterfaceFlag,CancelConfirmDate,CancelQty,   
           LastEmp,LastDate,shipgubun )  
  VALUES ( :ls_csrno,:ls_csrno1,:ls_csrno2,:ls_srno,:ls_billno,'D',:ll_seqno,
           'A','Y',:ls_cancelconfirmdate,:ll_defectqty,   
           :g_s_empno,getdate(),:is_dtype )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
   	uo_status.st_message.text = "tshipback_interface error"
		return false
   end if
end if
return true
end function

public function boolean wf_save ();string ls_billno,ls_itemtype_check
ls_itemtype_check = f_piss_itemtype_check(is_areacode,is_divisioncode,is_itemcode)
ls_billno = dw_2.object.billno[1]
dw_2.accepttext()
dw_3.reset()
/* 군산은 현품표미발행
	if wf_create_kbno() then
		wf_kb_print()
	else
		messagebox("확인","현품표 생성시 error")
		return false
	end if
end if
*/
if wf_update_tshipback() then
else
	return false
end if
if wf_update_tlotno() then
else
	return false
end if
IF ls_itemtype_check <> '2' then  //단품이 아니면
	if wf_update_tinv() then
	else
		return false
	end if
end if


return true
end function

public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty, string fs_date);string ls_Areacode,ls_Divisioncode,ls_itemcode,ls_partid
long ln_rowcount,ln_stockqty

select areacode,divisioncode,itemcode,partid into :ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid from tseqmstitem
	where customercode = :fs_custcode and customeritemcode = :fs_custitemcode
using sqlpis ;
if sqlpis.sqlcode <> 0 then
	return true
end if

select count(*) into :ln_rowcount from tseqinv
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid
using sqlpis ;
if isnull(ln_rowcount) or ln_rowcount = 0 then
	insert into tseqinv
		values	( :ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,:fl_shipqty,:g_s_empno,getdate() )
		using	sqlpis ;
	if sqlpis.sqlcode <> 0 then
		return false
	end if
elseif ln_rowcount = 1 then
	update	tseqinv
		set	stockqty	=	stockqty	+ :fl_shipqty
	where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
	and 	itemcode = :ls_itemcode and partid			= 	:ls_partid
	using sqlpis ;
	if sqlpis.sqlnrows <> 1 then
		return false
	end if
end if

ln_rowcount = 0
select count(*) into :ln_rowcount from tseqtrans
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid and tracedate	=	:fs_date 
using sqlpis ;

if isnull(ln_rowcount) or ln_rowcount = 0 then
		insert into tseqtrans
		values	( :fs_date,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,0,0,:fl_shipqty * (-1),:g_s_empno,getdate())
		using	sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
elseif ln_rowcount = 1 then
		update	tseqtrans
			set	shipqty	=	shipqty - :fl_shipqty
		where	areacode = :ls_areacode and divisioncode = :ls_divisioncode	
		and 	itemcode = :ls_itemcode and partid		= 	:ls_partid and tracedate = :fs_date
		using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
end if

return true
end function

public function boolean wf_update_tlotno ();long ll_count,ll_shipqty, ll_stockqty
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

ll_shipqty = dw_2.object.normalqty[1] + dw_2.object.repairqty[1] + dw_2.object.defectqty[1]

string ls_shift  //주야
ls_shift = f_pisc_get_date_shift_close('%','%',f_pisc_get_date_nowtime())

string ls_lotno
ls_lotno = f_pisc_get_lotno(is_areacode,is_divisioncode,ls_close_date,ls_shift)

string ls_itemtype_check
ls_itemtype_check = f_piss_itemtype_check(is_areacode,is_divisioncode,is_itemcode)

if ls_itemtype_check <> '2' then //단품이 아니면
	ll_stockqty = 0
else
	ll_stockqty = ll_shipqty
end if  
  
select count(*)
  into :ll_count
  from tlotno
  where tracedate    = :ls_close_date
    and areacode     = :is_areacode
	 and divisioncode = :is_divisioncode
	 and custcode     = :is_custcode
	 and itemcode     = :is_itemcode
	 and lotno        = :ls_lotno
	 and shipgubun    = :is_stype
	 using sqlpis;
	 
if ll_count = 0 then
   insert into tlotno
	     (tracedate,areacode,divisioncode,lotno,itemcode,custcode,shipgubun,
		   shipusage,prdqty,stockqty,shipqty,
			lastemp,lastdate)
		  values
		  (:ls_close_date,:is_areacode,:is_divisioncode,:ls_lotno,:is_itemcode,:is_custcode,:is_stype,
		   :is_suse,0,:ll_stockqty* -1,:ll_shipqty *- 1,'Y',getdate())
		  using sqlpis;
else
	update tlotno
	   set shipqty  = shipqty - :ll_shipqty,
		    stockqty  = stockqty - :ll_stockqty,
		    lastemp  = 'Y',
			 lastdate = getdate()
	  where tracedate    = :ls_close_date
		 and areacode     = :is_areacode
		 and divisioncode = :is_divisioncode
		 and custcode     = :is_custcode
		 and itemcode     = :is_itemcode
		 and lotno        = :ls_lotno
		 and shipgubun    = :is_stype
		 using sqlpis;
end if
if sqlpis.sqlcode <> 0 THEN
  	uo_status.st_message.text = "tlotno error"
	return false
end if
if is_dtype = 'C' then
	if wf_update_tseqinv(is_custcode,is_citno,ll_shipqty,ls_close_date) then
	else
		return false
	end if
end if
return true	 
end function

public function boolean wf_delete_tlotno (string fs_lotno, long fl_shipqty);long ll_count, ll_stockqty
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

string ls_itemtype_check
ls_itemtype_check = f_piss_itemtype_check(is_areacode,is_divisioncode,is_itemcode)

if ls_itemtype_check <> '2' then //단품이 아니면
	ll_stockqty = 0
else
	ll_stockqty = fl_shipqty
end if  

select count(*)
  into :ll_count
  from tlotno
  where tracedate    = :ls_close_date
    and areacode     = :is_areacode
	 and divisioncode = :is_divisioncode
	 and custcode     = :is_custcode
	 and itemcode     = :is_itemcode
	 and lotno        = :fs_lotno
	 and shipgubun    = :is_stype
	 using sqlpis;
if is_suse = '' or isnull(is_suse	 ) then
	is_suse = ''
end if	
if ll_count = 0 then
   insert into tlotno
	     (tracedate,areacode,divisioncode,lotno,itemcode,custcode,shipgubun,
		   shipusage,prdqty,stockqty,shipqty,
			lastemp,lastdate)
		  values
		  (:ls_close_date,:is_areacode,:is_divisioncode,:fs_lotno,:is_itemcode,:is_custcode,:is_stype,
		   :is_suse,0,:ll_stockqty,:fl_shipqty,'Y',getdate())
		  using sqlpis;
else
	update tlotno
	   set shipqty  = shipqty  + :fl_shipqty,
		    stockqty = stockqty + :ll_stockqty,
			 lastdate = getdate(),
			 lastemp  = 'Y'
	  where tracedate    = :ls_close_date
		 and areacode     = :is_areacode
		 and divisioncode = :is_divisioncode
		 and custcode     = :is_custcode
		 and itemcode     = :is_itemcode
		 and lotno        = :fs_lotno
		 and shipgubun    = :is_stype
		 using sqlpis;
end if
if sqlpis.sqlcode <> 0 THEN
	uo_status.st_message.text = "tlotno error"
	return false
end if	
//if is_dtype = 'C' then
if wf_update_tseqinv(is_custcode,is_citno,fl_shipqty,ls_close_date) then
else
	return false
end if
//end if

return true	 
end function

on w_piss221u.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.uo_date=create uo_date
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.st_10=create st_10
this.st_2=create st_2
this.uo_1=create uo_1
this.sle_citno=create sle_citno
this.st_11=create st_11
this.ddlb_gubun=create ddlb_gubun
this.dw_save=create dw_save
this.dw_print=create dw_print
this.dw_3=create dw_3
this.gb_1=create gb_1
this.sle_1=create sle_1
this.dw_4=create dw_4
this.st_3=create st_3
this.st_4=create st_4
this.gb_2=create gb_2
this.dw_sheet=create dw_sheet
this.dw_2=create dw_2
this.pb_excel=create pb_excel
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.uo_scustgubun
this.Control[iCurrent+6]=this.uo_custcode
this.Control[iCurrent+7]=this.st_10
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.sle_citno
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.ddlb_gubun
this.Control[iCurrent+13]=this.dw_save
this.Control[iCurrent+14]=this.dw_print
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.sle_1
this.Control[iCurrent+18]=this.dw_4
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.dw_sheet
this.Control[iCurrent+23]=this.dw_2
this.Control[iCurrent+24]=this.pb_excel
this.Control[iCurrent+25]=this.rb_1
this.Control[iCurrent+26]=this.rb_2
this.Control[iCurrent+27]=this.gb_3
this.Control[iCurrent+28]=this.gb_4
end on

on w_piss221u.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.uo_date)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.st_10)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.sle_citno)
destroy(this.st_11)
destroy(this.ddlb_gubun)
destroy(this.dw_save)
destroy(this.dw_print)
destroy(this.dw_3)
destroy(this.gb_1)
destroy(this.sle_1)
destroy(this.dw_4)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_2)
destroy(this.dw_sheet)
destroy(this.dw_2)
destroy(this.pb_excel)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;
//il_resize_count ++
//
//of_resize_register(dw_sheet, FULL)
//
//of_resize()
//
//
end event

event ue_retrieve;string ls_gubun,ls_custcode,ls_citno,ls_fromrpdt,ls_torpdt
ls_gubun = left(ddlb_gubun.text,1)
if is_dtype <> 'M' then
	ls_custcode = is_custcode
	ls_citno = sle_citno.text + '%'
else
	ls_custcode = '%'
	ls_citno = '%'
end if
ls_fromrpdt = is_date
ls_torpdt = is_date1
dw_2.reset()
dw_sheet.retrieve(ls_gubun,is_dtype,is_areacode,is_divisioncode,ls_custcode,ls_citno,ls_fromrpdt,ls_torpdt)

if dw_sheet.rowcount() = 0 then
	pb_excel.visible = false
	pb_excel.enabled = false
   messagebox("확인","조회 자료가 없읍니다.")
	return
end if	
pb_excel.visible = true
pb_excel.enabled = true
end event

event ue_save;string ls_billno
if is_new = 'N' then
   return
end if	
if dw_2.rowcount() = 0 then
   return 
end if

if wf_err_check() then
else
	return 
end if
sqlpis.autocommit = false
if wf_save() then
	dw_3.reset()
	commit using sqlpis;
   sqlpis.autocommit = true
   messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
   sqlpis.autocommit = true
   messagebox("확인","작업중 오류가 발생했읍니다.")	
end if

dw_2.reset()
dw_4.reset()
sle_1.text =''

end event

event ue_delete;string ls_billno
long ll_tot_normal,ll_tot_repair,ll_tot_defect

if is_dtype = 'M' then
	messagebox("확인","역이체는 삭제가 불가합니다")
	return
end if

if is_new = 'Y' then
   return
end if	

if dw_2.rowcount() = 0 then
	return
end if	
ls_billno = dw_2.object.billno[1]


sqlpis.autocommit = false

if wf_delete() then
	commit using sqlpis;
	sqlpis.autocommit = true
	messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	sqlpis.autocommit = true
	messagebox("확인","작업중 오류가 발생했읍니다.")	
end if	

dw_2.reset()
dw_4.reset()
sle_1.text =''

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_4.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
if is_dtype = "M" then
	i_b_delete     = false
else
	i_b_delete     = true
end if

wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss221u
integer y = 2504
integer width = 4599
end type

type uo_division from u_pisc_select_division within w_piss221u
integer x = 2574
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_4.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_2.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss221u
integer x = 1445
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_4.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_2.reset()

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_date from u_pisc_date_applydate within w_piss221u
integer x = 59
integer y = 96
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;is_date = is_uo_date


end event

event ue_losefocus;call super::ue_losefocus;is_date = is_uo_date
end event

event ue_select;is_date = is_uo_date
dw_sheet.reset()
dw_2.reset()
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type st_8 from statictext within w_piss221u
integer x = 626
integer y = 268
integer width = 329
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
string text = "거래처구분"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_piss221u
integer x = 960
integer y = 264
integer width = 709
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;//postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_sheet.reset()
dw_2.reset()

end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

type uo_custcode from u_piss_select_custcode within w_piss221u
integer x = 1911
integer y = 260
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_sheet.reset()
dw_2.reset()


end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

type st_10 from statictext within w_piss221u
integer x = 2981
integer y = 268
integer width = 334
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
string text = "거래처품번"
boolean focusrectangle = false
end type

type st_2 from statictext within w_piss221u
integer x = 741
integer y = 104
integer width = 105
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
string text = "->"
boolean focusrectangle = false
end type

type uo_1 from u_pisc_date_applydate_1 within w_piss221u
event destroy ( )
integer x = 823
integer y = 100
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_date1 = is_uo_date
end event

type sle_citno from singlelineedit within w_piss221u
integer x = 3310
integer y = 256
integer width = 727
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event modified;is_citno = this.text
end event

type st_11 from statictext within w_piss221u
integer x = 3323
integer y = 100
integer width = 151
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
string text = "구분"
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_piss221u
integer x = 3479
integer y = 92
integer width = 549
integer height = 272
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"A 전체","B 의뢰완료","C 의뢰미완료"}
borderstyle borderstyle = stylelowered!
end type

type dw_save from datawindow within w_piss221u
boolean visible = false
integer x = 2162
integer y = 1052
integer width = 937
integer height = 840
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss221u
boolean visible = false
integer x = 3141
integer y = 1452
integer width = 411
integer height = 432
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss310i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_piss221u
boolean visible = false
integer x = 1179
integer y = 1108
integer width = 411
integer height = 432
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss221u
integer x = 23
integer y = 28
integer width = 4421
integer height = 164
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

type sle_1 from singlelineedit within w_piss221u
boolean visible = false
integer x = 1152
integer y = 2008
integer width = 699
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;//If wf_kb_valid_check(is_areacode,is_divisioncode,This.Text) Then
//Else
////	MessageBox("확인", "올바르지 않은 간판입니다." + "~r~n"+ "간판번호를 확인한 후, Scanning하여 주십시오...")
//End if
//this.text = ''
//this.setfocus()
end event

type dw_4 from datawindow within w_piss221u
boolean visible = false
integer x = 1975
integer y = 1928
integer width = 2555
integer height = 564
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_piss221u
boolean visible = false
integer x = 1289
integer y = 2200
integer width = 384
integer height = 96
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "삭제시"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss221u
boolean visible = false
integer x = 1129
integer y = 2340
integer width = 736
integer height = 96
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "간판 Reading"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_piss221u
boolean visible = false
integer x = 1111
integer y = 1940
integer width = 777
integer height = 224
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "간판번호"
end type

type dw_sheet from u_vi_std_datawindow within w_piss221u
integer x = 18
integer y = 432
integer width = 4439
integer height = 1512
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_piss220u_02_rev1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;string ls_srno,ls_billno,ls_cancelconfirmdate,ls_divisioncode
long ll_normalqty,ll_repairqty,ll_defectqty
if row <= 0 then
	return
end if

string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

ls_srno = dw_sheet.object.Csrno[row]
is_itemcode = dw_sheet.object.itemcode[row]
is_citno 	= dw_sheet.object.citno[row]
ls_divisioncode = dw_sheet.object.divisioncode[row]
il_rcqty = dw_sheet.object.rcqty[row]
if is_dtype = 'M' then
	is_stype = is_dtype
else
	is_stype = dw_sheet.object.stype[row]
end if
is_suse = dw_sheet.object.suse[row]

il_row = row
dw_2.retrieve(is_areacode,ls_divisioncode,ls_srno,is_dtype)
dw_2.setfocus()

ls_billno            = dw_2.object.billno[1]
ll_normalqty         = dw_2.object.normalqty[1]
ll_repairqty         = dw_2.object.repairqty[1]
ll_defectqty         = dw_2.object.defectqty[1]

ls_cancelconfirmdate = dw_2.object.cancelconfirmdate[1]
if ll_normalqty + ll_repairqty + ll_defectqty = 0 then
	is_new = 'Y'
	sle_1.enabled = false
	dw_4.reset()
else
	is_new = 'N'	
	sle_1.enabled = true
	dw_4.reset()
end if	  

if ll_normalqty + ll_repairqty + ll_defectqty = 0 then
	dw_2.settaborder('normalqty',1)
	dw_2.settaborder('repairqty',2)
	dw_2.settaborder('defectqty',3)
	dw_2.Object.cancelconfirmdate.Background.Color = RGB(192,192,192)
	dw_2.Object.normalqty.Background.Color = RGB(255,255,255)
	dw_2.Object.repairqty.Background.Color = RGB(255,255,255)
	dw_2.Object.defectqty.Background.Color = RGB(255,255,255)
	dw_2.setfocus()
else
	dw_2.settaborder('normalqty',0)
	dw_2.settaborder('repairqty',0)
	dw_2.settaborder('defectqty',0)
	dw_2.Object.cancelconfirmdate.Background.Color = RGB(255,255,255)
	dw_2.Object.normalqty.Background.Color = RGB(192,192,192)
	dw_2.Object.repairqty.Background.Color = RGB(192,192,192)
	dw_2.Object.defectqty.Background.Color = RGB(192,192,192)
	sle_1.setfocus()
end if
il_normalqty = dw_2.object.normalqty[1]
il_repairqty = dw_2.object.repairqty[1]
il_defectqty = dw_2.object.defectqty[1]
if is_dtype = 'M' then
	dw_2.object.repairqty.protect = true
	dw_2.object.defectqty.protect = true	
else
	dw_2.object.repairqty.protect = false
	dw_2.object.defectqty.protect = false
end if

end event

type dw_2 from datawindow within w_piss221u
integer x = 1262
integer y = 1960
integer width = 983
integer height = 536
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_piss221u
boolean visible = false
integer x = 4274
integer y = 60
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_sheet)
end event

type rb_1 from radiobutton within w_piss221u
integer x = 59
integer y = 232
integer width = 402
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
string text = "BackShip"
boolean checked = true
end type

event clicked;st_8.visible          = true ; st_8.enabled          = true
st_10.visible         = true ; st_10.enabled         = true
uo_scustgubun.visible = true ; uo_scustgubun.enabled = true 
uo_custcode.visible   = true ; uo_custcode.enabled   = true 
sle_citno.visible     = true ; sle_citno.enabled     = true 

dw_2.reset()
dw_4.reset()
dw_sheet.reset() 

is_dtype = 'C'

i_b_delete     = true

wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_dretrieve,  i_b_dprint,    i_b_dchar)

end event

type rb_2 from radiobutton within w_piss221u
integer x = 59
integer y = 312
integer width = 366
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
string text = "역이체"
end type

event clicked;st_8.visible          = false ; st_8.enabled          = false
st_10.visible         = false ; st_10.enabled         = false
uo_scustgubun.visible = false ; uo_scustgubun.enabled = false 
uo_custcode.visible   = false ; uo_custcode.enabled   = false 
sle_citno.visible     = false ; sle_citno.enabled     = false 

is_dtype = 'M'

dw_2.reset()
dw_4.reset()
dw_sheet.reset() 

i_b_delete     = false

wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type gb_3 from groupbox within w_piss221u
integer x = 23
integer y = 172
integer width = 443
integer height = 228
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_piss221u
integer x = 475
integer y = 172
integer width = 3973
integer height = 228
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

