$PBExportHeader$w_piss470u.srw
$PBExportComments$출고전표수정
forward
global type w_piss470u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss470u
end type
type uo_area from u_pisc_select_area within w_piss470u
end type
type uo_division from u_pisc_select_division within w_piss470u
end type
type uo_date from u_pisc_date_applydate within w_piss470u
end type
type dw_save from datawindow within w_piss470u
end type
type dw_kbno_create from datawindow within w_piss470u
end type
type dw_print from datawindow within w_piss470u
end type
type dw_3 from datawindow within w_piss470u
end type
type gb_1 from groupbox within w_piss470u
end type
end forward

global type w_piss470u from w_ipis_sheet01
integer width = 4128
string title = "출고전표취소"
boolean minbox = true
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_save dw_save
dw_kbno_create dw_kbno_create
dw_print dw_print
dw_3 dw_3
gb_1 gb_1
end type
global w_piss470u w_piss470u

type variables
boolean ib_open, ib_change = false
string is_shipsheetno,  is_change = 'NO', is_applydate,is_areacode,is_divisioncode
string is_prddate,is_itemcode,is_shipdate
string is_security, is_modelcode, is_kbno, is_asgubun, &
         is_plantcode, is_workcenter, is_shift, is_linecode, &
         is_enddate, is_invdate, is_lotno
integer ii_window_border = 10,il_qty
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,  il_kbloopsn


end variables

forward prototypes
public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, integer fi_shipqty, string fs_shipgubun)
public function boolean wf_update_tshipcancel (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_srno, long fl_truckorder, long fl_shipqty, string fs_shipsheetno)
public function boolean wf_update_tshipinv (string fs_shipdate, string fs_divisioncode, string fs_srno, integer fi_truckorder, long fl_shipqty)
public function boolean wf_update_tshipkbhis (string fs_divisioncode, string fs_srno, string fs_shipdate, integer fi_truckorder, string fs_shipsheetno, long fi_shipqty)
public function boolean wf_update_tshipsheet (string fs_areacode, string fs_divisioncode, string fs_shipsheetno, string fs_srno, long fl_shipqty)
public function boolean wf_update_tshipsheet_parent_interface (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipdate, string fs_shipsheetno, long fl_shipqty, string fs_kitgubun)
public function boolean wf_err_check (long fl_row)
public function boolean wf_referance_data (long fl_row)
public subroutine wf_item_check (string fs_divisioncode, long fl_shipqty, string fs_itemcode)
public function boolean wf_update_tshipsheet_interface (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipdate, string fs_shipsheetno, long fl_shipqty)
public function boolean wf_update_tsrorder (string fs_srno, long fi_shipqty, string fs_shipdate)
public function boolean wf_update_tlotno (string fs_close_date, string fs_divisioncode, string fs_srno, long fi_shipqty)
public function boolean wf_update_tstock_interface (string fs_areacode, string fs_divisioncode, string fs_itemcode, string fs_kbno, long fl_cancelqty)
public function boolean wf_save_stockcancel (string fs_areacode, string fs_divisioncode, string fs_itemcode, string fs_kbno, long fl_cancelqty)
public function boolean wf_update_tloadplan (string fs_srno, string fs_shipplandate, long fi_truckorder, integer fi_shipqty)
public function boolean wf_kbno_create ()
public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty)
end prototypes

public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, integer fi_shipqty, string fs_shipgubun);uo_status.st_message.text = '재고 수정중(wf_update_tinv)'
long ll_count,ll_moveinvqty,ll_shipinvqty
string ls_applydate
//ls_date = f_getcurrentdate()
//ls_date = is_date

select count(*)
  Into :ll_count
  From tinv
 Where Itemcode	  = :fs_itemcode
	and divisioncode = :fs_divisioncode
	and areacode     = :is_areacode
	using sqlpis;
if fs_shipgubun = 'M' then //이체
   ll_moveinvqty = fi_shipqty
	ll_shipinvqty = 0
else
   ll_moveinvqty = 0
	ll_shipinvqty = fi_shipqty
end if	
if fs_shipgubun >= 'O' and fs_shipgubun <= 'W' then //수출은 영업진행재고 처리안함
   	ll_shipinvqty  = 0
end if		

if ll_count = 0 then
	insert into tinv (areacode,divisioncode,itemcode,invqty,moveinvqty,shipinvqty,lastemp,lastdate)
	   values (:is_areacode,:fs_divisioncode,:fs_itemcode,:fi_shipqty,:ll_moveinvqty * -1,:ll_shipinvqty * -1,'Y',getdate())
		using sqlpis;
else		
	update tinv
	   set invqty     = invqty     + :fi_shipqty,
		    moveinvqty = moveinvqty - :ll_moveinvqty,
			 shipinvqty = shipinvqty - :ll_shipinvqty,
		    lastemp    = 'Y',
			 lastdate   = getdate()
	 where areacode     = :is_areacode
	   and divisioncode = :fs_divisioncode
		and itemcode     = :fs_itemcode
		using sqlpis;
end if		
uo_status.st_message.text = '재고 수정완료(wf_update_tinv)'
if Sqlpis.sqlcode = 0 then
	return true
else
	uo_status.st_message.text = "tinv오류 : " + sqlpis.sqlerrtext
	return false
End if

end function

public function boolean wf_update_tshipcancel (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_srno, long fl_truckorder, long fl_shipqty, string fs_shipsheetno);uo_status.st_message.text = '출하취소 수정중(wf_update_tshipcancel)'
long ll_delseq
select max(delseq)
  into :ll_delseq
  from tshipcancel
  where shipdate = :fs_shipdate
    and areacode = :fs_areacode
	 and divisioncode = :fs_divisioncode
	 and srno = :fs_srno
	 and truckorder = :fl_truckorder
	 and shipsheetno = :fs_shipsheetno
	 using sqlpis;
if isnull(ll_delseq)	 then
	ll_delseq = 0
end if
ll_delseq = ll_delseq + 1
INSERT INTO TSHIPCANCEL  
         ( ShipDate,   
           AreaCode,   
           DivisionCode,   
           SRNo,   
           TruckOrder,   
           ShipSheetNo,   
           DELSeq,   
           ShipQty,   
           LastEmp,   
           LastDate )  
  VALUES ( :fs_shipdate,   
           :fs_areacode,   
           :fs_divisioncode,   
           :fs_srno,   
           :fl_truckorder,   
           :fs_shipsheetno,   
           :ll_delseq,   
           :fl_shipqty,   
           :g_s_empno,   
           getdate() ) 
using sqlpis;

if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipcancel error : " + sqlpis.sqlerrtext
	return false
end if
uo_status.st_message.text = '출하취소 수정완료(wf_update_tshipcancel)'
return true


end function

public function boolean wf_update_tshipinv (string fs_shipdate, string fs_divisioncode, string fs_srno, integer fi_truckorder, long fl_shipqty);uo_status.st_message.text = '이체 수정중(wf_update_tshipinv)'
string ls_truckno,ls_sendflag
long ll_error
select truckno
  into :ls_truckno
  from tshipinv
  where shipplandate = :fs_shipdate
    and areacode     = :is_areacode
	 and divisioncode = :fs_divisioncode
	 and srno         = :fs_srno
	 and truckorder   = :fi_truckorder
	 using sqlpis;

update  tshipinv
   set truckloadqty  = truckloadqty - :fl_shipqty,
	    moveconfirmflag = 'Y',
	    sendflag      = 'N',
		 lastemp       = :g_s_empno,
		 lastdate      = getdate()
  where shipplandate = :fs_shipdate
    and areacode     = :is_areacode
	 and divisioncode = :fs_divisioncode
	 and srno         = :fs_srno
	 and truckorder   = :fi_truckorder
	 using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipinv error : " + sqlpis.sqlerrtext
	return false
end if	
uo_status.st_message.text = '이체수정완료(wf_update_tshipinv)'
return true
end function

public function boolean wf_update_tshipkbhis (string fs_divisioncode, string fs_srno, string fs_shipdate, integer fi_truckorder, string fs_shipsheetno, long fi_shipqty);uo_status.st_message.text = '출하간판 수정중(wf_update_tshipkbhis)'
delete from tshipkbhis
 where areacode      = :is_areacode
	and divisioncode  = :fs_divisioncode
	and srno          = :fs_srno
	and shipdate      = :fs_shipdate
	and truckorder    = :fi_truckorder
	and shipsheetno   = :fs_shipsheetno
 using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipkbhis delete시 오류 " + sqlpis.sqlerrtext
	return false
end if	
if fi_shipqty > 0 then
	INSERT INTO TSHIPKBHIS  
			( ShipDate,   
			  AreaCode,   
			  DivisionCode,   
			  SRNo,   
			  TruckOrder,   
			  ShipSheetNo,   
			  KBNo,   
			  KBReleaseDate,   
			  KBReleaseSeq,   
			  ShipQty,   
			  LastEmp,   
			  LastDate )  
	VALUES (:fs_shipdate,   
			  :is_areacode,   
			  :fs_divisioncode,   
			  :fs_srno,   
			  :fi_truckorder,   
			  :fs_shipsheetno,   
			  'XXXXXXXXXXX',   
			  :fs_shipdate,   
			  1,   
			  :fi_shipqty,   
			  'Y',   
			  getdate() )  
	 using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "tshipkbhis insert시 오류 " + sqlpis.sqlerrtext
		return false
	end if	
end if
uo_status.st_message.text = '출하간판 수정완료(wf_update_tshipkbhis)'
return true

end function

public function boolean wf_update_tshipsheet (string fs_areacode, string fs_divisioncode, string fs_shipsheetno, string fs_srno, long fl_shipqty);uo_status.st_message.text = '출하전표 수정중(wf_update_tshipsheet)'
long   ll_shipqty
select shipqty
  into :ll_shipqty
  from tshipsheet
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
   and shipsheetno = :fs_shipsheetno
	and srno        = :fs_srno
	using sqlpis;
if ll_shipqty = fl_shipqty then	//전량수정시
	delete from tshipsheet
	  where areacode     = :fs_areacode
		 and divisioncode = :fs_divisioncode
		 and shipsheetno  = :fs_shipsheetno
		 and srno         = :fs_srno
		 using sqlpis;
else		 
	update tshipsheet
	   set shipqty = shipqty - :fl_shipqty
	 where areacode = :fs_areacode
		and divisioncode = :fs_divisioncode
		and shipsheetno = :fs_shipsheetno
		and srno        = :fs_srno
		using sqlpis;
	end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "wf_update_tshipsheet ereror : " + sqlpis.sqlerrtext
   return false
end if
uo_status.st_message.text = '출하전표 수정완료(wf_update_tshipsheet)'
return true

end function

public function boolean wf_update_tshipsheet_parent_interface (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipdate, string fs_shipsheetno, long fl_shipqty, string fs_kitgubun);string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
string ls_srno,ls_misflag 
if right(fs_srno,3) = 'P00' or right(fs_srno,3) = 'C00' then
	select top 1 substring(:fs_srno,1,len(:fs_srno) - 3) 
	  into :ls_srno
	  from sysusers
	  using sqlpis;
else
	ls_srno = fs_srno
end if
long ll_seqno
select max(seqno)
  into :ll_seqno
  from tshipsheet_interface
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and srno = :ls_srno
	and shipdate = :is_shipdate
	using sqlpis;
if isnull(ll_seqno) then
	ll_seqno = 0
end if
ll_seqno = ll_seqno + 1
if fl_shipqty = 0 then
	ls_misflag = 'D'
else
	ls_misflag = 'R'
end if	
INSERT INTO Tshipsheet_interface  
         ( AreaCode,   
           DivisionCode,   
           srno,   
           shipdate,   
           shipsheetno,   
           seqno,   
           SHIPQty,   
			  kitgubun,
           misflag,   
           interfaceflag,   
           LastEmp,   
           LastDate )  
  VALUES ( :fs_areacode,   
           :fs_divisioncode,   
           :ls_srno,   
           :is_shipdate,   
           :fs_shipsheetno,   
           :ll_seqno,   
           :fl_shipqty,   
			  :fs_kitgubun,
           'Y',   
           :ls_misflag,   
           :g_s_empno,   
           getdate())
	using sqlpis;
if sqlpis.sqlcode <> 0 then
   uo_status.st_message.text = "tshipsheet_interface parent error : " + sqlpis.sqlerrtext
	return false
end if
return true
end function

public function boolean wf_err_check (long fl_row);long ll_shipqty,ll_cancelqty,ll_pshiporderqty,ll_cshiporderqty,ll_count,ll_mod
string ls_psrno,ls_kitgubun,ls_srno

ll_shipqty   = dw_sheet.object.shipqty[fl_row]
ll_cancelqty = dw_sheet.object.cancelqty[fl_row]
ls_psrno     = dw_sheet.object.psrno[fl_row]
ls_srno     = dw_sheet.object.srno[fl_row]
ls_kitgubun  = dw_sheet.object.kitgubun[fl_row]

if ll_cancelqty < 0 then
	messagebox("확인","변경수량이 0보다 작습니다.")
	dw_sheet.object.cancelqty[fl_row] = ll_shipqty
	dw_sheet.setfocus()
	dw_sheet.setcolumn('cancelqty')
	dw_sheet.setrow(fl_row)
	return false
end if

if ll_cancelqty > ll_shipqty then
	messagebox("확인","변경수량이 출하수량 보다 큽니다.")
	dw_sheet.object.cancelqty[fl_row] = ll_shipqty
	dw_sheet.setfocus()
	dw_sheet.setcolumn('cancelqty')
	dw_sheet.setrow(fl_row)
	return false
end if

if ls_kitgubun = 'N' then  //KIT제품이 아니면 
	return true
end if
//select shiporderqty        //모제품 수량
//  into :ll_pshiporderqty
//  from tsrorder
// where srno = :ls_psrno
// using sqlpis; 
//select shiporderqty        //자제품 수량
//  into :ll_cshiporderqty
//  from tsrorder
// where srno = :ls_srno
// using sqlpis;
// 
//ll_count = ll_cshiporderqty / ll_pshiporderqty
//ll_mod   = mod(ll_cancelqty,ll_count)
//if ll_mod <> 0 then
//	dw_sheet.object.cancelqty[fl_row] = ll_shipqty	
//   messagebox("확인","KIT제품은 " + string(ll_count) + " 배수이어야 합니다.")
//	return false
//end if	
wf_referance_data(fl_row)	
return true
end function

public function boolean wf_referance_data (long fl_row);long ll_count,ll_cancelflag,i,ll_mod,ll_pshiporderqty,ll_cshiporderqty
string ls_pcgubun,ls_kitgubun,ls_srno,ls_psrno,ls_ppsrno
long ll_cancelqty,ll_qty,ll_ptruckorder,ll_truckorder

ls_ppsrno  = dw_sheet.object.srno[fl_row]
ll_cancelqty  = dw_sheet.object.cancelqty[fl_row]
ll_ptruckorder = dw_sheet.object.truckorder[fl_row]
//if ls_psrno = ls_srno then  //KIT제품이 아니면
//	return true
//end if	
select shiporderqty 
  into :ll_pshiporderqty
  from tsrorder
 where srno = :ls_ppsrno
 using sqlpis;

FOR i = fl_row + 1 TO dw_sheet.rowcount() STEP 1
	 ls_psrno      = dw_sheet.object.psrno[i]
	 ls_srno       = dw_sheet.object.srno[i]
	 ll_truckorder = dw_sheet.object.truckorder[i]
	 if (ls_psrno <> ls_ppsrno) or (ll_truckorder <> ll_ptruckorder) then
		 exit
	 end if
    ls_kitgubun = dw_sheet.object.kitgubun[i]
    select shiporderqty
      into :ll_cshiporderqty
	   from tsrorder
     where srno = :ls_srno
     using sqlpis;
    ll_mod   = ll_cshiporderqty/ll_pshiporderqty     // 배수 찿기
//    ll_count = ll_cancelqty / ll_mod               //실제 몇배 인가...
    ll_qty = ll_cancelqty * (ll_mod)
    dw_sheet.object.cancelqty[i] = ll_qty
NEXT

return true
end function

public subroutine wf_item_check (string fs_divisioncode, long fl_shipqty, string fs_itemcode);long ll_find,ll_shipqty
string ls_find
ls_find = "divisioncode = '" + fs_divisioncode + "'"
ls_find = ls_find + " and itemcode = '" + fs_itemcode + "'"
ll_find = dw_kbno_create.find(ls_find,1,dw_kbno_create.rowcount())
if ll_find > 0 then
	ll_shipqty = dw_kbno_create.object.shipqty[ll_find]
	dw_kbno_create.object.shipqty[ll_find] = ll_shipqty + fl_shipqty
else
	dw_kbno_create.insertrow(1)
	dw_kbno_create.object.divisioncode[1] = fs_divisioncode
	dw_kbno_create.object.itemcode[1] = fs_itemcode
	dw_kbno_create.object.shipqty[1] = fl_shipqty
end if	
end subroutine

public function boolean wf_update_tshipsheet_interface (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipdate, string fs_shipsheetno, long fl_shipqty);uo_status.st_message.text = '출하전표interface 수정중(wf_update_tshipsheet_interface)'
string ls_close_date  //마감일자
string ls_srno
string ls_misflag,ls_kitgubun,ls_pcgubun
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
long ll_shipqty,ll_length
long ll_seqno
select kitgubun,pcgubun
  into :ls_kitgubun,:ls_pcgubun
  from tsrorder
 where srareacode     = :fs_areacode
   and srdivisioncode = :fs_divisioncode
	and srno           = :fs_srno
//	and shipdate       = :fs_shipdate
	using sqlpis;
if ls_kitgubun = 'Y' then
	ls_kitgubun = ls_pcgubun
else
	ls_kitgubun = ''
end if	
if right(fs_srno,3) = 'C00' or right(fs_srno,3) = 'P00' then
	select top 1 substring(:fs_srno,1,len(:fs_srno) - 3) 
	  into :ls_srno
	  from sysusers
	  using sqlpis;
else
	ls_srno = fs_srno
end if	
select shipqty
  into :ll_shipqty
  from tshipsheet
 where shipdate     = :fs_shipdate
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and shipsheetno  = :fs_shipsheetno
	and srno         = :fs_srno
	using sqlpis;
if ll_shipqty = fl_shipqty then
	ls_misflag = 'D'
else
	ls_misflag = 'R'
end if	

select max(seqno)
  into :ll_seqno
  from tshipsheet_interface
 where areacode     = :fs_areacode
   and divisioncode = :fs_divisioncode
	and srno         = :ls_srno
	and shipdate     = :fs_shipdate
	and misflag      = :ls_misflag
	using sqlpis;
if isnull(ll_seqno) then
	ll_seqno = 0
end if
ll_seqno = ll_seqno + 1
INSERT INTO Tshipsheet_interface  
         ( shipdate,AreaCode,DivisionCode,srno,seqno,
           shipsheetno,kitgubun,shipQty,   
           misflag,interfaceflag,LastEmp,LastDate )  
  VALUES ( :fs_shipdate,:fs_areacode,:fs_divisioncode,:ls_srno,:ll_seqno,
           :fs_shipsheetno,:ls_kitgubun,:ll_shipqty - :fl_shipqty,   
           :ls_misflag,'Y',:g_s_empno,getdate())
	using sqlpis;
if sqlpis.sqlcode <> 0 then
   uo_status.st_message.text = "tshipsheet_interface : " + sqlpis.sqlerrtext
	return false
end if
uo_status.st_message.text = '출하전표interface 수정완료(wf_update_tshipsheet_interface)'
return true
end function

public function boolean wf_update_tsrorder (string fs_srno, long fi_shipqty, string fs_shipdate);uo_status.st_message.text = 'SR 수정중(wf_update_tsrorder)'
long   li_shipremainqty, li_shiporderqty, li_updateqty,ll_child_qty,ll_parent_qty,ll_count
string ls_orderdate, ls_separateFlag, ls_shipendgubun,ls_psrno
string ls_min_srno,ls_shipgubun
select ApplyFrom, 
		 shipremainqty,
		 shiporderqty,
		 psrno,
		 shiporderqty,shipgubun
  Into :ls_orderdate, :li_shipremainqty, :li_shiporderqty,:ls_psrno,:ll_child_qty, :ls_shipgubun
  From tsrorder
 Where srno           = :fs_srno
   and srareacode     = :is_areacode
	and srdivisioncode = :is_divisioncode
	using sqlpis;

li_updateqty	= li_shipremainqty + fi_shipqty
if ls_shipgubun = 'M' then
	if li_shiporderqty = li_updateqty then
	   ls_shipendgubun = 'N'
	else
		ls_shipendgubun = 'Y'
	end if
else
	ls_shipendgubun = 'N'
end if	
	
Update tsrorder
   set shipremainqty	= :li_updateqty,
	    ShipEndGubun	= :ls_shipendgubun,
		 LastEmp			= 'Y',
		 Lastdate		= GetDate()
 where srno = :fs_srno
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;

If sqlpis.sqlcode <> 0 Then
	return False
End if

//select min(srno)
//  into :ls_min_srno
//  from tsrorder
// where psrno = :ls_psrno
// using sqlpis;
// 
////if (right(fs_srno,3) = 'C01') and (fs_srno <> ls_psrno) then
//if (ls_min_srno = fs_srno) and (fs_srno <> ls_psrno) then
//	select isnull(shiporderqty,0)
//	  into :ll_parent_qty
//	  from tsrorder
//	 where srareacode = :is_areacode
//	   and srdivisioncode = :is_divisioncode
//		and srno = :ls_psrno
//		using sqlpis;
//	if ll_parent_qty > 0 then
//	   ll_count = (ll_child_qty / ll_parent_qty)
//		ll_count = fi_shipqty / ll_count 
//	   update tsrorder
//		   set shipremainqty = shipremainqty + :ll_count,
//			    shipendgubun  = 'N',
//             lastemp = 'Y',
//				 lastdate = getdate()
//		 where srareacode     = :is_areacode
//			and srdivisioncode = :is_divisioncode
//			and srno = :ls_psrno
//			using sqlpis;
//      if sqlpis.sqlcode <> 0 then
//			uo_status.st_message.text = "모 품번 tsrorder update error : " + sqlpis.sqlerrtext
//			return false
//		end if
//	end if
//end if	
uo_status.st_message.text = 'SR 수정완료(wf_update_tsrorder)'
return true
end function

public function boolean wf_update_tlotno (string fs_close_date, string fs_divisioncode, string fs_srno, long fi_shipqty);uo_status.st_message.text = '일집계 수정중(wf_update_tlotno)'
long ll_count,ll_shipqty,ll_inout_count
string ls_itemcode,ls_shipgubun,ls_shipusage,ls_custcode
select itemcode,shipgubun,shipusage,custcode
  into :ls_itemcode,:ls_shipgubun,:ls_shipusage,:ls_custcode
  from tsrorder
 where srno = :fs_srno
   and srareacode = :is_areacode
	and divisioncode = :fs_divisioncode
using sqlpis;

select count(LotNo)
  Into :ll_count
  From tlotno
 Where DivisionCode	= :fs_divisioncode
   and areacode   = :is_areacode
   and Lotno		= 'XXXXXX'
   and ItemCode	= :ls_itemcode
	and shipgubun  = :ls_shipgubun
	and traceDate	= :fs_close_date
	and shipgubun  = :ls_shipgubun
	and custcode   = :ls_custcode
Group by ShipQty
using sqlpis;
string ls_item_type
long ll_stockqty
ls_item_type 	= f_piss_itemtype_check(is_areacode,fs_divisioncode,ls_itemcode)
ll_inout_count = f_piss_inoutitem_check(is_areacode,fs_divisioncode,ls_itemcode)
if ls_item_type = '2' or ll_inout_count >= 1 then //단품,동시입고출하품번이면
   ll_stockqty = fi_shipqty
else
	ll_stockqty = 0
end if	
//출하일자의 같은 Lotno 의 테이타가 있다면 Update
if ll_count > 0 Then
	Update tlotno
	   Set shipqty    = shipqty  - :fi_shipqty,
		    stockqty   = stockqty - :ll_stockqty,
		    lastemp    = 'N',
			 lastdate   = getdate()
	 Where DivisionCode	= :fs_divisioncode
		and areacode   = :is_areacode
		and Lotno		= 'XXXXXX'
		and ItemCode	= :ls_itemcode
		and shipgubun  = :ls_shipgubun
		and traceDate	= :fs_close_date
		and custcode   = :ls_custcode
		and shipgubun  = :ls_shipgubun
		using sqlpis;
Else
	// 출고일자의 같은 lotno 가 없다면 insert
	Insert into tlotno 
	           (traceDate,AreaCode,DivisionCode,Lotno,Itemcode,custcode,shipgubun,
				   shipusage,prdqty,shipQty,stockqty, Lastemp, lastdate)
			Values (:fs_close_date,:is_areacode,:fs_divisioncode,'XXXXXX', :ls_itemcode,:ls_custcode,:ls_shipgubun,
			        :ls_shipusage,0,:fi_shipqty * -1,:ll_stockqty * -1,'N', GetDate())
			using sqlpis;
end if
	
if Sqlpis.sqlcode = 0 then
	uo_status.st_message.text = '일집계 수정완료(wf_update_tlotno)'
	return true
else
	uo_status.st_message.text = "tlotno error "
	return false
End if
end function

public function boolean wf_update_tstock_interface (string fs_areacode, string fs_divisioncode, string fs_itemcode, string fs_kbno, long fl_cancelqty);string ls_kbreleasedate,ls_workcenter,ls_linecode,ls_itemcode,ls_supplygubun,ls_hostworkcenter,ls_hostlinecode
string ls_stockdate,ls_invgubunflag,ls_deptcode,ls_releasegubun

string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

long ll_seqno,ll_kbreleaseseq,ll_rackqty,ll_cancelqty 

select kbreleasedate,kbreleaseseq,workcenter,linecode,itemcode,stockdate,invgubunflag,releasegubun,rackqty
  into :ls_kbreleasedate,:ll_kbreleaseseq,:ls_workcenter,:ls_linecode,:ls_itemcode,:ls_stockdate,:ls_invgubunflag,:ls_releasegubun,:ll_rackqty
  from tkbhis
  where kbno = :fs_kbno
    and kbstatuscode = 'D'
 using sqlpis;
select supplygubun,hostworkcenter,hostlinecode
  into :ls_supplygubun,:ls_hostworkcenter,:ls_hostlinecode
  from tmstline
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and workcenter = :ls_workcenter
	and linecode = :ls_linecode
 using sqlpis;
if ls_supplygubun = 'Y' then
	ls_workcenter = ls_hostworkcenter
	ls_linecode   = ls_hostlinecode
end if	

if (left(ls_stockdate,7) <> left(ls_close_date,7)) or (ls_workcenter = 'XXXX') or & 
   trim(ls_releasegubun) = 'C' or ( fl_cancelqty <> ll_rackqty ) then  //월이 틀리거나 조가 'XXXX' , 출하 취소건인경우
	  if ls_workcenter = 'XXXX' then 
   	   select deptcode
         into :ls_deptcode
         from tmstemp
         where empno = :g_s_empno
         using sqlpis;
	  end if	
      
		if ls_deptcode = '' or isnull(ls_deptcode) then
       	ls_deptcode = 'XXXX'
      end if
		
		select max(seqno)
		into :ll_seqno
		from tstockcancel_interface
		where kbno          = :fs_kbno
		  and kbreleasedate = :ls_kbreleasedate
		  and kbreleaseseq  = :ll_kbreleaseseq
		  and misflag       = 'D'
		  using sqlpis;
	if isnull(ll_seqno) then	  
		ll_seqno = 0
	end if
	ll_seqno = ll_seqno + 1
	
	INSERT INTO Tstockcancel_interface  
			( kbno,kbreleasedate,kbreleaseseq,seqno,   
			  stockdate,areacode,divisioncode,workcenter,linecode,
			  itemcode,stockqty,
			  misflag,interfaceflag,lastemp,lastdate)
	VALUES (:fs_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_seqno,
			  :ls_close_date,:is_areacode,:is_divisioncode,:ls_deptcode,:ls_invgubunflag,
			  :ls_itemcode,:fl_cancelqty,
			  'A','Y',:g_s_empno,getdate())
		using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "tstockcancel_interface error : " + sqlpis.sqlerrtext
		return false
	end if
else   //월이 같으면 
	select max(seqno)
		into :ll_seqno
		from tstock_interface
		where kbno          = :fs_kbno
		  and kbreleasedate = :ls_kbreleasedate
		  and kbreleaseseq  = :ll_kbreleaseseq
		  and misflag       = 'D'
		  using sqlpis;
	if isnull(ll_seqno) then	  
		ll_seqno = 0
	end if
	ll_seqno = ll_seqno + 1
	INSERT INTO Tstock_interface  
			( kbno,kbreleasedate,kbreleaseseq,seqno,   
			  stockdate,areacode,divisioncode,workcenter,linecode,
			  itemcode,stockqty,
			  misflag,interfaceflag,lastemp,lastdate)
	VALUES (:fs_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_seqno,
			  :ls_stockdate,:is_areacode,:is_divisioncode,:ls_workcenter,:ls_linecode,
			  :ls_itemcode,:fl_cancelqty,
			  'D','Y',:g_s_empno,getdate())
		using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "tstock_interface error : " + sqlpis.sqlerrtext
		return false
	end if
end if
return true

end function

public function boolean wf_save_stockcancel (string fs_areacode, string fs_divisioncode, string fs_itemcode, string fs_kbno, long fl_cancelqty);long ll_rowcount,i,ll_currentqty,ll_count,ll_invqty,ll_defectqty,ll_repairqty
string ls_kbstatuscode,ls_invgubunflag,ls_lotno,ls_item_type
boolean lb_commit

lb_commit = true


if fl_cancelqty > 0 then
 	if not wf_update_tstock_interface(fs_areacode,fs_divisioncode,fs_itemcode,fs_kbno,fl_cancelqty) then
	 	lb_commit = false
	 	return lb_commit
 	end if
	select invgubunflag,lotno
		into :ls_invgubunflag,:ls_lotno
		from tkb
	where  areacode     =	:fs_areacode
		and divisioncode = 	:fs_divisioncode
		and kbno         = 	:fs_kbno
	using sqlpis;
	if ls_invgubunflag = 'D' then
		ll_defectqty = fl_cancelqty
	elseif ls_invgubunflag = 'R' then
		ll_repairqty = fl_cancelqty
	else 
		ll_invqty = fl_cancelqty
	end if
			  
	update tkb
	set currentqty   	= currentqty - :fl_cancelqty,
		 kbstatuscode 	= case currentqty - :fl_cancelqty when 0 then 'F' else 'D' end,
		 lastemp      	= 'Y',
		 lastdate     	= getdate()
	where areacode    = :fs_areacode
	and divisioncode 	= :fs_divisioncode
	and kbno         	= :fs_kbno
	using sqlpis;
	if sqlpis.sqlcode <> 0 then
		lb_commit = false
		return lb_commit
	end if
	update tkbhis
	set currentqty   = currentqty - :fl_cancelqty,
		 kbstatuscode = case currentqty - :fl_cancelqty when 0 then 'F' else 'D' end,
		 lastdate     = getdate(),
		 lastemp      = 'Y'
	where areacode   = :fs_areacode
	and divisioncode = :fs_divisioncode
	and kbno         = :fs_kbno
	and kbstatuscode = 'D'
	using sqlpis;
	if sqlpis.sqlcode <> 0 then
		lb_commit = false
		return lb_commit
	end if
end if
return lb_commit
end function

public function boolean wf_update_tloadplan (string fs_srno, string fs_shipplandate, long fi_truckorder, integer fi_shipqty);uo_status.st_message.text = '상차계획 수정중(wf_update_tloadplan)'
long ll_shipqty
select truckloadqty 
  into :ll_shipqty
  from tloadplan
 where srno	         = :fs_srno
   and TruckOrder	   = :fi_truckorder
	and shipplanDate	= :fs_shipplandate
	and areacode	   = :is_areacode
	and divisioncode  = :is_divisioncode
	and truckno       is not null
	using sqlpis;
if ll_shipqty = fi_shipqty then
	delete from tloadplan
	 where srno	        = :fs_srno
		and TruckOrder	  = :fi_truckorder
		and shipplanDate = :fs_shipplandate
		and areacode	  = :is_areacode
		and divisioncode = :is_divisioncode
		and truckno      is not null
		using sqlpis;
else
	update tloadplan
		set truckloadqty = truckloadqty - :fi_shipqty,
			 lastdate = getdate(),
			 lastemp  = :g_s_empno
	 where srno	        = :fs_srno
		and TruckOrder	  = :fi_truckorder
		and shipplanDate = :fs_shipplandate
		and areacode	  = :is_areacode
		and divisioncode = :is_divisioncode
		and truckno      is not null
		using sqlpis;
end if		
if Sqlpis.Sqlcode <> 0 then
	uo_status.st_message.text = "tloadplan error : " + sqlpis.sqlerrtext
	return false
end if

if ll_shipqty = fi_shipqty then
	delete from tloadplanhis
    where srno	        = :fs_srno
      and TruckOrder	  = :fi_truckorder
	   and shipplanDate = :fs_shipplandate
	   and areacode	  = :is_areacode
	   and divisioncode = :is_divisioncode
		and truckno is not null
	  using sqlpis;
else
	update tloadplanhis
      set truckloadqty = truckloadqty - :fi_shipqty,
		    lastdate = getdate(),
		    lastemp = :g_s_empno
    where srno	= :fs_srno
      and TruckOrder	  = :fi_truckorder
	   and shipplanDate = :fs_shipplandate
	   and areacode	  = :is_areacode
	   and divisioncode = :is_divisioncode
		and truckno is not null
	 using sqlpis;
end if
if Sqlpis.Sqlcode <> 0 then
	uo_status.st_message.text = "tloadplanhis error : " + sqlpis.sqlerrtext
	return false
end if
uo_status.st_message.text = '상차계획 수정완료(wf_update_tloadplan)'
return true
end function

public function boolean wf_kbno_create ();uo_status.st_message.text = '간판 수정중(wf_kbno_create)'
long i,ll_rowcount,ll_count,ll_inout_count, ll_chkcnt
string ls_kbno,ls_seqno,ls_divisioncode,ls_temp_kbno,ls_itemcode,ls_deptcode
long ll_shipqty,j,ll_remainqty,ll_rackqty
string ls_close_date,ls_apply_date  //마감일자
string ls_shift  //주야
string ls_lotno  //LOT번호
boolean lb_commit
lb_commit = true
//select deptcode
//  into :ls_deptcode
//  from tmstemp
// where empno = :g_s_empno
// using sqlpis;
//if ls_deptcode = '' or isnull(ls_deptcode) then
//	ls_deptcode = 'XXXX'
//end if	
ls_deptcode = 'XXXX'
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_apply_date = f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())
ll_rowcount = dw_kbno_create.rowcount()
for i = 1 to ll_rowcount step 1
	ls_divisioncode = dw_kbno_create.object.divisioncode[i]
	ls_itemcode = dw_kbno_create.object.itemcode[i]
	ll_shipqty  = dw_kbno_create.object.shipqty[i]
	// 로직변경 => Top1이 데이타가 없을 경우에 0 또는 null 값을 가져오지 않음. 2004.11.23
	ll_remainqty = ll_shipqty
	
	select count(*)
	  into :ll_chkcnt
	  from tmstkb
	 where areacode = :is_areacode
		and divisioncode = :ls_divisioncode
		and itemcode = :ls_itemcode
		using sqlpis;

	if ll_chkcnt = 0 then
		ll_rackqty = ll_remainqty
	else
		select top 1 rackqty
		  into :ll_rackqty
		  from tmstkb
		 where areacode = :is_areacode
			and divisioncode = :ls_divisioncode
			and itemcode = :ls_itemcode
			using sqlpis;
		//ll_remainqty = ll_shipqty
		if ll_rackqty = 0 or isnull(ll_rackqty) then
			ll_rackqty = ll_remainqty
		end if
	end if
	// 로직변경 끝
	ll_count = ceiling(ll_remainqty/ll_rackqty)
	ll_inout_count	=	f_piss_inoutitem_check(is_areacode,ls_divisioncode,ls_itemcode)
	for j = 1 to ll_count step 1
		select max(kbno)
		  into :ls_kbno
		  from tkb 
		where areacode     = :is_areacode
		  and divisioncode = :ls_divisioncode
		  and applyfrom    like substring(:ls_apply_date,1,7) + '%'
		  and substring(kbno,3,1) = 'Z'
		  using sqlpis;
		if ll_remainqty <= ll_rackqty then
			ll_rackqty = ll_remainqty
		else
			ll_remainqty = ll_remainqty - ll_rackqty
		end if
		if isnull(ls_kbno) or ls_kbno = '' then
			ls_seqno = '0000'
		else
			ls_seqno = right(ls_kbno,4)
		end if
		f_pisc_get_string_add(ls_seqno,ls_seqno)
		ls_temp_kbno = is_areacode + ls_divisioncode + 'Z' + mid(ls_apply_date,3,2) + mid(ls_apply_date,6,2) + ls_seqno
		dw_save.ReSet()
		If dw_save.Retrieve(ls_temp_kbno,is_areacode,ls_divisioncode,ls_deptcode,'N',ls_itemcode,ls_apply_date, &
								  'T','N',ll_rackqty,g_s_empno) > 0 Then
			If Upper(dw_save.GetItemString(1, "Error")) = "00" Then

				ls_shift = f_pisc_get_date_shift_close(is_areacode,ls_divisioncode,f_pisc_get_date_nowtime())
				ls_lotno = f_pisc_get_lotno(is_areacode,ls_divisioncode,ls_close_date,ls_shift)
				
				dw_kbno_create.object.kbno[i] = ls_temp_kbno
				update tkb 
					set kbstatuscode = 'D',
						 kbactivegubun = 'A',
						 printcount = 1,
						 kbstocktime = getdate(),
						 kbprinttime = getdate(),
						 stockdate   = :ls_close_date,
						 stockqty    = :ll_rackqty,
						 lotno       = :ls_lotno
					where kbno = :ls_temp_kbno
					  using sqlpis;
				update tkbhis 
					set kbstatuscode = 'D',
						 kbactivegubun = 'A',
						 lastloopflag = 'Y',
						 printcount = 1,
						 kbstocktime = getdate(),
						 kbprinttime = getdate(),
						 kbreleasedate = :ls_apply_date,
						 kbreleaseseq  = 1,
						 stockdate   = :ls_close_date,
						 stockqty    = :ll_rackqty,
						 lotno       = :ls_lotno
					where kbno = :ls_temp_kbno
					  and areacode = :is_areacode
					  and divisioncode = :ls_divisioncode
					  using sqlpis;
					if ll_inout_count < 1 then				  
						dw_print.retrieve(is_areacode,ls_divisioncode,ls_temp_kbno)
						dw_print.print()
					end if
			else
				uo_status.st_message.text = "임시간판 생성시 오류 발생"
				lb_commit = false
				exit
			end if
	  	end if 
	  	if ll_inout_count >= 1 then
			if wf_save_stockcancel(is_Areacode,ls_divisioncode,ls_itemcode,ls_temp_kbno,ll_rackqty) = false then
				return false
			end if
		end if
	next
next
uo_status.st_message.text = '간판 수정 완료(wf_kbno_create)'
return lb_commit
end function

public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty);string ls_Areacode,ls_Divisioncode,ls_itemcode,ls_partid
long ln_rowcount,ln_stockqty

select areacode,divisioncode,itemcode,partid into :ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid from tseqmstitem
	where customercode = :fs_custcode and customeritemcode = :fs_custitemcode
using sqlpis ;
if sqlpis.sqlcode <> 0 then
	return true
end if

select stockqty into :ln_stockqty from tseqinv
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid
using sqlpis ;
if isnull(ln_stockqty) or ( ln_stockqty - fl_shipqty ) < 0 then
	return false
elseif ln_rowcount = 1 then
	update	tseqinv
		set	stockqty	=	stockqty	- :fl_shipqty
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
	and	 	itemcode = :ls_itemcode and partid = :ls_partid and tracedate	=	:is_shipdate 
using sqlpis ;

if isnull(ln_rowcount) or ln_rowcount = 0 then
		insert into tseqtrans
		values	( :is_shipdate,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,0,0,:fl_shipqty,:g_s_empno,getdate())
		using	sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
elseif ln_rowcount = 1 then
		update	tseqtrans
			set	shipqty	=	shipqty + :fl_shipqty
		where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
		and 	itemcode = :ls_itemcode and partid			= 	:ls_partid and tracedate = :is_shipdate
		using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
end if

return true
end function

on w_piss470u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_save=create dw_save
this.dw_kbno_create=create dw_kbno_create
this.dw_print=create dw_print
this.dw_3=create dw_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.dw_save
this.Control[iCurrent+6]=this.dw_kbno_create
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.gb_1
end on

on w_piss470u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_save)
destroy(this.dw_kbno_create)
destroy(this.dw_print)
destroy(this.dw_3)
destroy(this.gb_1)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;long ll_count

setpointer(hourglass!)
dw_kbno_create.reset() //로직추가 2004.11.22
ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_shipdate)
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	return
end if	

end event

event ue_save;dw_sheet.accepttext()
string ls_close_date  //마감일자
string ls_kitgubun,ls_psrno,ls_min_srno
long ll_child_qty,ll_parent_qty,ll_count,ll_inout_count
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

if left(is_shipdate,7) <> left(ls_close_date,7) then
	messagebox("확인","마감이 되어 수정할수 없읍니다.")
	return
end if	
long ll_cancelcount, ll_rowcount, ll_i, ll_find,ll_cancelqty,ll_shipqty,ll_changeqty
LONG li_cancelflag, li_remainqty, li_shipqty, li_truckorder, li_rtn,li_kbreleaseseq
string ls_srno, ls_applydate, ls_srgubun, ls_itemcode, ls_today, ls_asgubun, ls_custcode,ls_kbno,ls_custitemcode
string ls_lotno,ls_kbreleasedate,ls_shipgubun,ls_shipsheetno,ls_truckno,ls_divisioncode
string ls_item_type_check,ls_pcgubun
boolean lb_commit = false

ll_find 		= 0
ls_today = is_shipdate
ll_rowcount = dw_sheet.rowcount()
//li_rtn = Messagebox('출하취소', '선택하신 출고 수량을 출고된 날짜의 재고 수량 까지 삭제 하시겠습니까?', Question!, YesNo!)
li_rtn = 0 
sqlpis.autocommit	= False

for ll_i = 1 to ll_rowcount
	ll_shipqty   = dw_sheet.GetItemNumber(ll_i, 'shipqty')	
	ll_cancelqty = dw_sheet.GetItemNumber(ll_i, 'cancelqty')	
	ll_changeqty = ll_shipqty - ll_cancelqty
	if ll_changeqty > 0 then
		ls_shipsheetno  = dw_sheet.GetItemstring (ll_i,'shipsheetno')	
		ls_truckno      = dw_sheet.GetItemstring (ll_i,'truckno')	
		li_truckorder   = dw_sheet.object.truckorder[ll_i]
		ls_divisioncode = dw_sheet.GetItemstring(ll_i,'divisioncode')	
//		ls_shipsheetno  = dw_sheet.GetItemString(ll_i, 'shipsheetno')
		ls_srno		    = dw_sheet.GetItemString(ll_i, 'SRNo')
		li_truckorder   = dw_sheet.GetItemnumber(ll_i, 'truckorder')
		ls_applydate	 = dw_sheet.GetItemString(ll_i, 'shipdate')
		ls_divisioncode = dw_sheet.GetItemString(ll_i,'divisioncode')
		li_shipqty		 = dw_sheet.GetItemNumber(ll_i, 'shipqty')
		ls_custcode		 = dw_sheet.GetItemString(ll_i, 'CustCode')
		ls_custitemcode = dw_sheet.GetItemString(ll_i, 'customeritemno')		
		ls_itemcode	    = dw_sheet.GetItemString(ll_i, 'itemcode')	
		ls_srgubun		 = dw_sheet.GetItemString(ll_i, 'SRGubun')
		li_truckorder	 = dw_sheet.GetItemNumber(ll_i, 'truckorder')		
		ls_shipgubun    = ls_srgubun		
		ls_kitgubun     = dw_sheet.object.kitgubun[ll_i]
		ls_pcgubun      = dw_sheet.object.pcgubun[ll_i]
      	ls_item_type_check 	= f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
		ll_inout_count			= f_piss_inoutitem_check(is_areacode,ls_divisioncode,ls_itemcode)
		if ls_kitgubun = 'N' or (ls_kitgubun = 'Y' and ls_pcgubun = 'C') then
			if ls_item_type_check <> '2' and ll_inout_count < 1 then //단품,동시입고출하품번이 아니면
				if not wf_update_tinv(ls_divisioncode,ls_itemcode,ll_changeqty,ls_srgubun) then
					uo_status.st_message.text = "tinv update error"
					lb_commit = false
					exit;
				else
					lb_commit = true
				end if	
			end if
			if not wf_update_tshipkbhis(ls_divisioncode,ls_srno,is_shipdate,li_truckorder,ls_shipsheetno,ll_cancelqty) then
				uo_status.st_message.text = "tinv update error"
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if	
			if not wf_update_tlotno(is_shipdate,ls_divisioncode,ls_srno,ll_changeqty) then
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if
			//현품표발행품번체크
			if ls_item_type_check <> '2' then  //단품이 아니면
				wf_item_check(ls_divisioncode,ll_changeqty,ls_itemcode)
			end if
	   end if
		if ls_shipgubun = 'D' OR ls_shipgubun = 'G' OR ls_shipgubun = 'H' OR ls_shipgubun = 'K' OR &
			ls_shipgubun = 'R' OR ls_shipgubun = 'U' OR ls_shipgubun = 'V' OR ls_shipgubun = 'W' THEN // A/S,KD 일경우만..
			if not wf_update_tseqinv(ls_custcode,ls_custitemcode,ll_changeqty * -1) then
				lb_commit = false
				exit
			end if
		end if
		if not wf_update_tloadplan(ls_srno,is_shipdate,li_truckorder,ll_changeqty) then
			lb_commit = false
			exit;
		else
			lb_commit = true
		end if	

		if ls_shipgubun <> 'M' then //이체는 인터페이스안함 
			if not wf_update_tshipsheet_interface(is_areacode,ls_divisioncode,ls_srno,is_shipdate,ls_shipsheetno,ll_changeqty) then
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if	
		end if
		if not wf_update_tsrorder(ls_srno,ll_changeqty,is_shipdate) then
			uo_status.st_message.text = "tsrorder update error"
			lb_commit = false
			exit;
		else
			lb_commit = true
		end if
		if not wf_update_tshipcancel(is_shipdate,is_areacode,ls_divisioncode,ls_srno,li_truckorder,ll_changeqty,ls_shipsheetno) then
			lb_commit = false
			exit;
		else
			lb_commit = true
		end if	
		if ls_srgubun = 'M' then
			if not wf_update_tshipinv(is_shipdate,ls_divisioncode,ls_srno,li_truckorder,ll_changeqty) then
            uo_status.st_message.text = "tshipinv update error"
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if
		end if	
	   if not wf_update_tshipsheet(is_areacode,ls_divisioncode,ls_shipsheetno,ls_srno,ll_changeqty) then
         uo_status.st_message.text = "tshipsheet update error"
			lb_commit = false
			exit;
		else
			lb_commit = true
		end if	
		
   end if
next
if lb_commit then
	if wf_kbno_create() then 
		lb_commit = true
	else
		uo_status.st_message.text = "현품표 작성시 error"
		lb_commit = false
	end if	
end if

if lb_commit = true then
	commit using sqlpis;
   SQLpis.AutoCommit	= True
   messagebox("확인","수정처리가 완료되었읍니다.")
else
	rollback using sqlpis;
   SQLpis.AutoCommit	= True	
   messagebox("확인","수정처리에 실패했읍니다.")	
end if	

postevent('ue_retrieve')


end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss470u
end type

type dw_sheet from u_vi_std_datawindow within w_piss470u
integer x = 32
integer y = 268
integer width = 2789
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss470u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;this.accepttext()
if wf_err_check(row) = false then
    return 1
end if	
end event

type uo_area from u_pisc_select_area within w_piss470u
integer x = 818
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
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

type uo_division from u_pisc_select_division within w_piss470u
integer x = 1367
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type uo_date from u_pisc_date_applydate within w_piss470u
integer x = 73
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate <> is_uo_date then
	dw_sheet.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_save from datawindow within w_piss470u
boolean visible = false
integer x = 2341
integer y = 452
integer width = 937
integer height = 840
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_kbno_create from datawindow within w_piss470u
boolean visible = false
integer x = 421
integer y = 492
integer width = 1358
integer height = 584
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss270u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss470u
boolean visible = false
integer x = 997
integer y = 1116
integer width = 411
integer height = 432
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss310i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_piss470u
boolean visible = false
integer x = 2117
integer y = 364
integer width = 411
integer height = 432
integer taborder = 220
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_13"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss470u
integer x = 23
integer y = 28
integer width = 2775
integer height = 172
integer taborder = 50
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

