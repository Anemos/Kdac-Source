$PBExportHeader$w_piss271u.srw
$PBExportComments$출고전표취소
forward
global type w_piss271u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss271u
end type
type uo_area from u_pisc_select_area within w_piss271u
end type
type uo_division from u_pisc_select_division within w_piss271u
end type
type uo_date from u_pisc_date_applydate within w_piss271u
end type
type st_2 from statictext within w_piss271u
end type
type sle_truckno from singlelineedit within w_piss271u
end type
type dw_2 from datawindow within w_piss271u
end type
type dw_save from datawindow within w_piss271u
end type
type dw_kbno_create from datawindow within w_piss271u
end type
type dw_print from datawindow within w_piss271u
end type
type dw_3 from datawindow within w_piss271u
end type
type dw_4 from datawindow within w_piss271u
end type
type gb_1 from groupbox within w_piss271u
end type
end forward

global type w_piss271u from w_ipis_sheet01
integer width = 4128
string title = "출고전표취소"
boolean minbox = true
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
st_2 st_2
sle_truckno sle_truckno
dw_2 dw_2
dw_save dw_save
dw_kbno_create dw_kbno_create
dw_print dw_print
dw_3 dw_3
dw_4 dw_4
gb_1 gb_1
end type
global w_piss271u w_piss271u

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
public subroutine wf_item_check (string fs_divisioncode, long fl_shipqty, string fs_itemcode)
public function boolean wf_minus_tlotno (string fs_areacode, string fs_divisioncode, string fs_tracedate, string fs_custcode, string fs_itemcode, long fl_shipqty, string fs_shipgubun, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq)
public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, integer fi_shipqty, string fs_shipgubun)
public function boolean wf_update_tlotno (string fs_close_date, string fs_lotno, string fs_itemcode, integer fi_shipqty, string fs_divisioncode, string fs_custcode, string fs_shipgubun)
public function boolean wf_update_tshipcancel (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_srno, long fl_truckorder, long fl_shipqty, string fs_shipsheetno)
public function boolean wf_update_tshipinv (string fs_shipdate, string fs_divisioncode, string fs_srno, integer fi_truckorder, long fl_shipqty)
public function boolean wf_update_tsrorder (string fs_srno, integer fi_shipqty, string fs_shipdate)
public function boolean wf_update_tshipkbhis (string fs_divisioncode, string fs_srno, string fs_shipdate, integer fi_truckorder)
public function boolean wf_update_tshipsheet (string fs_areacode, string fs_divisioncode, string fs_shipsheetno)
public function boolean wf_update_tshipsheet_interface (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipdate, string fs_shipsheetno, long fl_shipqty, string fs_kitgubun)
public function boolean wf_update_tloadplan (string fs_srno, string fs_shipplandate, long fi_truckorder, integer fi_shipqty)
public function boolean wf_kbno_create ()
end prototypes

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

public function boolean wf_minus_tlotno (string fs_areacode, string fs_divisioncode, string fs_tracedate, string fs_custcode, string fs_itemcode, long fl_shipqty, string fs_shipgubun, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq);string ls_lotno
long ll_count
select lotno
  into :ls_lotno
  from tkbhis
 where kbno = :fs_kbno
   and kbreleasedate = :fs_kbreleasedate
	and kbreleaseseq = :fl_kbreleaseseq
using sqlpis;
if isnull(ls_lotno) or ls_lotno ='' then
	ls_lotno = 'XXXXXX'
end if

select count(*)
  into :ll_count
  from tlotno
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and lotno        = :ls_lotno
	and tracedate    = :fs_tracedate
	and custcode     = :fs_custcode
	and itemcode     = :fs_itemcode
	and shipgubun    = :fs_shipgubun
using sqlpis;
if ll_count = 0 then
   INSERT INTO TLOTNO  
         (TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,CustCode,ShipGubun,
          ShipUsage,PrdQty,StockQty,ShipQty,LastEmp,LastDate )  
  VALUES (:fs_tracedate,:fs_areacode,:fs_divisioncode,:ls_lotno,:fs_itemcode,:fs_custcode,:fs_shipgubun,   
          'X',0,0,:fl_shipqty * -1,'Y',getdate() ) 
   using sqlpis;
else
	update tlotno
	   set shipqty  = shipqty - :fl_shipqty,
		    lastdate = getdate(),
			 lastemp  = 'Y'
	 where areacode = :fs_areacode
		and divisioncode = :fs_divisioncode
		and lotno        = :ls_lotno
		and tracedate    = :fs_tracedate
		and custcode     = :fs_custcode
		and itemcode     = :fs_itemcode
		and shipgubun    = :fs_shipgubun
	using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tlotno minus error : " + sqlpis.sqlerrtext
	return false
end if
return true
end function

public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, integer fi_shipqty, string fs_shipgubun);long ll_count,ll_moveinvqty,ll_shipinvqty
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
if ll_count = 0 then
	insert into tinv (areacode,divisioncode,itemcode,invqty,moveinvqty,shipinvqty,lastemp,lastdate)
	   values (:is_areacode,:fs_divisioncode,:fs_itemcode,:fi_shipqty,:ll_moveinvqty * -1,:ll_shipinvqty * -1,'Y',getdate())
		using sqlpis;
else		
	update tinv
	   set invqty     = invqty + :fi_shipqty,
		    moveinvqty = moveinvqty - :ll_moveinvqty,
			 shipinvqty = shipinvqty - :ll_shipinvqty,
		    lastemp  = 'Y',
			 lastdate = getdate()
	 where areacode = :is_areacode
	   and divisioncode = :fs_divisioncode
		and itemcode = :fs_itemcode
		using sqlpis;
end if		

if Sqlpis.sqlcode = 0 then
	return true
else
	uo_status.st_message.text = "tinv오류 : " + sqlpis.sqlerrtext
	return false
End if

end function

public function boolean wf_update_tlotno (string fs_close_date, string fs_lotno, string fs_itemcode, integer fi_shipqty, string fs_divisioncode, string fs_custcode, string fs_shipgubun);long ll_count,ll_shipqty
string ls_
select count(*)
  Into :ll_count
  From tlotno
 Where DivisionCode	= :fs_divisioncode
   and areacode   = :is_areacode
   and Lotno		= :fs_lotno
   and ItemCode	= :fs_itemcode
	and TraceDate	= :is_shipdate
	and custcode   = :fs_custcode
	and shipgubun  = :fs_shipgubun
using sqlpis;
string ls_item_type
long ll_stockqty
ls_item_type = f_piss_itemtype_check(is_areacode,fs_divisioncode,fs_itemcode)
if ls_item_type = '2' then  //단품이면
   ll_stockqty = fi_shipqty
else
	ll_stockqty = 0
end if	
//출하일자의 같은 Lotno 의 테이타가 있다면 Update
if ll_count > 0 Then
	Update tlotno
	   Set shipqty       = shipqty  - :fi_shipqty,
		    stockqty      = stockqty - :ll_stockqty,
		    lastemp       = 'Y',
			 lastdate      = getdate()
	 Where DivisionCode	= :fs_divisioncode
	   and AreaCode   = :is_areacode
   	and Lotno		= :fs_lotno
	   and ItemCode	= :fs_itemcode
		and tracedate	= :is_shipdate
		and custcode   = :fs_custcode
		and shipgubun  = :fs_shipgubun
	 using sqlpis;
Else
	// 출고일자의 같은 lotno 가 없다면 insert
	Insert into tlotno (traceDate,AreaCode,DivisionCode,Lotno, Itemcode,custcode,shipgubun,stockqty,shipQty, Lastemp, lastdate)
			Values (:is_shipdate,:is_areacode,:fs_divisioncode, :fs_lotno, :fs_itemcode,:fs_custcode,:fs_shipgubun,:fi_shipqty * -1,:fi_shipqty * -1,'Y', GetDate())
			using sqlpis;
end if
	
if Sqlpis.sqlcode = 0 then
	return true
else
	return false
End if
end function

public function boolean wf_update_tshipcancel (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_srno, long fl_truckorder, long fl_shipqty, string fs_shipsheetno);long ll_delseq
select max(delseq)
  into :ll_delseq
  from tshipcancel
  where shipdate = :is_shipdate
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
  VALUES ( :is_shipdate,   
           :fs_areacode,   
           :fs_divisioncode,   
           :fs_srno,   
           :fl_truckorder,   
           :fs_shipsheetno,   
           :ll_delseq,   
           :fl_shipqty,   
           'Y',   
           getdate() ) 
using sqlpis;

if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipcancel error : " + sqlpis.sqlerrtext
	return false
end if
return true


end function

public function boolean wf_update_tshipinv (string fs_shipdate, string fs_divisioncode, string fs_srno, integer fi_truckorder, long fl_shipqty);string ls_truckno,ls_sendflag
long ll_error,ll_error_count
ll_error_count = 0
update tshipinv
   set truckloadqty  = truckloadqty - :fl_shipqty,
	    moveconfirmflag = 'Y',
	    sendflag      = 'N',
		 lastemp       = 'Y',
		 lastdate      = getdate()
  where shipplandate = :is_shipdate
    and areacode     = :is_areacode
	 and divisioncode = :fs_divisioncode
	 and srno         = :fs_srno
	 and truckorder   = :fi_truckorder
	 using sqlpis;

if sqlpis.sqlcode = 0 then
	return true
else
	return false
end if	

end function

public function boolean wf_update_tsrorder (string fs_srno, integer fi_shipqty, string fs_shipdate);long   li_shipremainqty, li_shiporderqty, li_updateqty,ll_child_qty,ll_parent_qty,ll_count
string ls_orderdate, ls_separateFlag, ls_shipendgubun,ls_psrno
string ls_min_srno,ls_shipgubun
select ApplyFrom, 
		 shipremainqty,
		 shiporderqty,
		 psrno,
		 shiporderqty,
		 shipgubun
  Into :ls_orderdate, :li_shipremainqty, :li_shiporderqty,:ls_psrno,:ll_child_qty,:ls_shipgubun
  From tsrorder
 Where srno         = :fs_srno
   and areacode     = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;

li_updateqty	= li_shipremainqty + fi_shipqty

if ls_shipgubun = 'M' then
   If li_shiporderqty = li_updateqty then 
	   ls_shipendgubun = 'N'
   Else
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

select min(srno)
  into :ls_min_srno
  from tsrorder
 where psrno = :ls_psrno
   and pcgubun  = 'C'
 using sqlpis;
 
//if (right(fs_srno,3) = 'C01') and (fs_srno <> ls_psrno) then
if (ls_min_srno = fs_srno) and (fs_srno <> ls_psrno) then
	select isnull(shiporderqty,0)
	  into :ll_parent_qty
	  from tsrorder
	 where areacode = :is_areacode
	   and divisioncode = :is_divisioncode
		and srno = :ls_psrno
		using sqlpis;
	if ll_parent_qty > 0 then
	   ll_count = (ll_child_qty / ll_parent_qty)
		ll_count = fi_shipqty / ll_count 
	   update tsrorder
		   set shipremainqty = shipremainqty + :ll_count,
			    shipendgubun  = 'N',
				 lastdate      = getdate(),
				 lastemp       = 'Y'
		 where areacode     = :is_areacode
			and divisioncode = :is_divisioncode
			and srno         = :ls_psrno
			using sqlpis;
      if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = "모 품번 tsrorder update error : " + sqlpis.sqlerrtext
			return false
		end if
	end if
end if	
return true
end function

public function boolean wf_update_tshipkbhis (string fs_divisioncode, string fs_srno, string fs_shipdate, integer fi_truckorder);delete from tshipkbhis
 where areacode      = :is_areacode
	and divisioncode  = :fs_divisioncode
	and srno          = :fs_srno
	and shipdate      = :is_shipdate
	and truckorder    = :fi_truckorder
 using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipkbhis 변경시 오류 " + sqlpis.sqlerrtext
	return false
end if	

//long ll_delseq
//
//select max(delseq)
//  into :ll_delseq
//  from tshipkbhisdel
// where areacode      = :is_areacode
//	and divisioncode  = :fs_divisioncode
//	and srno          = :fs_srno
//	and shipdate      = :fs_shipdate
//	and truckorder    = :fi_truckorder
//	and kbreleasedate = :fs_kbreleasedate
//	and kbreleaseseq  = :fi_kbreleaseseq
//	and kbno          = :fs_kbno
//  using sqlpis;
// if ll_delseq = 0 or isnull(ll_delseq) then
//	 ll_delseq = 1
//else
//	 ll_delseq = ll_delseq + 1
//end if
//
//  INSERT INTO TSHIPKBHISDEL  
//         ( ShipDate,   
//           AreaCode,   
//           DivisionCode,   
//           SRNo,   
//           TruckOrder,   
//           ShipSheetNo,   
//           KBNo,   
//           KBReleaseDate,   
//           KBReleaseSeq,   
//           DELSeq,   
//           ShipQty,   
//           LastEmp,   
//           LastDate )  
//  VALUES ( :fs_shipdate,   
//           :is_areacode,   
//           :fs_divisioncode,   
//           :fs_srno,   
//           :fi_truckorder,   
//           :fs_shipsheetno,   
//           :fs_kbno,   
//           :fs_kbreleasedate,   
//           :fi_kbreleaseseq,   
//           :ll_delseq,   
//           :fi_shipqty,   
//           :g_s_empno,   
//           getdate() )
//			  using sqlpis;
//if sqlpis.sqlcode <> 0 then
//	return false
//end if	
return true

end function

public function boolean wf_update_tshipsheet (string fs_areacode, string fs_divisioncode, string fs_shipsheetno);delete from tshipsheet
  where areacode = :fs_areacode
    and divisioncode = :fs_divisioncode
	 and shipsheetno = :fs_shipsheetno
	 using sqlpis;
if sqlpis.sqlcode <> 0 then
   return false
end if
return true

end function

public function boolean wf_update_tshipsheet_interface (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipdate, string fs_shipsheetno, long fl_shipqty, string fs_kitgubun);string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
string ls_srno
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
	and misflag = 'D'
	using sqlpis;
if isnull(ll_seqno) then
	ll_seqno = 0
end if
ll_seqno = ll_seqno + 1

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
           'D',   
           :g_s_empno,   
           getdate())
	using sqlpis;
if sqlpis.sqlcode <> 0 then
   uo_status.st_message.text = "tshipsheet_interface  error : " + sqlpis.sqlerrtext
	return false
end if
return true
end function

public function boolean wf_update_tloadplan (string fs_srno, string fs_shipplandate, long fi_truckorder, integer fi_shipqty);long ll_shipqty,ll_parent_qty,ll_count,ll_child_qty
string ls_psrno,ls_min_srno

select isnull(a.truckloadqty,0),b.psrno 
  into :ll_shipqty,:ls_psrno
  from tloadplan a,tsrorder b
 where a.srno	      = :fs_srno
   and a.TruckOrder	 = :fi_truckorder
	and a.shipplanDate = :fs_shipplandate
	and a.areacode	    = :is_areacode
	and a.divisioncode = :is_divisioncode
	and a.srno         = b.srno
	using sqlpis;
if ll_shipqty = fi_shipqty then
	delete from tloadplan
	 where srno	        = :fs_srno
		and TruckOrder	  = :fi_truckorder
		and shipplanDate = :fs_shipplandate
		and areacode	  = :is_areacode
		and divisioncode = :is_divisioncode
		using sqlpis;
else
	update tloadplan
		set truckloadqty = truckloadqty - :fi_shipqty,
			 lastdate = getdate(),
			 lastemp = :g_s_empno
	 where srno	        = :fs_srno
		and TruckOrder	  = :fi_truckorder
		and shipplanDate = :fs_shipplandate
		and areacode	  = :is_areacode
		and divisioncode = :is_divisioncode
		using sqlpis;
end if		
if Sqlpis.Sqlcode <> 0 then
	uo_status.st_message.text = "tloadplan error : " + sqlpis.sqlerrtext
	return false
end if
//모sr check
select min(srno)
  into :ls_min_srno
  from tsrorder
 where psrno = :ls_psrno
 using sqlpis;
 
//if (right(fs_srno,3) = 'C01') and (fs_srno <> ls_psrno) then
if (ls_min_srno = fs_srno) and (fs_srno <> ls_psrno) then
	select isnull(shiporderqty,0)
	  into :ll_parent_qty
	  from tsrorder
	 where srareacode = :is_areacode
	   and srdivisioncode = :is_divisioncode
		and srno = :ls_psrno
		using sqlpis;
	if ll_parent_qty > 0 then
	   ll_count = (ll_child_qty / ll_parent_qty)
		ll_count = fi_shipqty / ll_count 
	   update tsrorder
		   set shipremainqty = shipremainqty + :ll_count,
			    shipendgubun  = 'N'
		 where srareacode     = :is_areacode
			and srdivisioncode = :is_divisioncode
			and srno = :ls_psrno
			using sqlpis;
      if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = "모 품번 tsrorder update error : " + sqlpis.sqlerrtext
			return false
		end if
	end if
end if	

if ll_shipqty = fi_shipqty then
	delete from tloadplanhis
    where srno	        = :fs_srno
      and TruckOrder	  = :fi_truckorder
	   and shipplanDate = :fs_shipplandate
	   and areacode	  = :is_areacode
	   and divisioncode = :is_divisioncode
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
	 using sqlpis;
end if
if Sqlpis.Sqlcode <> 0 then
	uo_status.st_message.text = "tloadplanhis error : " + sqlpis.sqlerrtext
	return false
end if
return true
end function

public function boolean wf_kbno_create ();long i,ll_rowcount,ll_count
string ls_kbno,ls_seqno,ls_divisioncode,ls_temp_kbno,ls_itemcode,ls_deptcode
long ll_shipqty,j,ll_remainqty,ll_rackqty
string ls_close_date,ls_apply_date  //마감일자
string ls_shift  //주야
string ls_lotno  //LOT번호
string ls_custcode,ls_shipgubun
select deptcode
  into :ls_deptcode
  from tmstemp
 where empno = :g_s_empno
 using sqlpis;
if ls_deptcode = '' or isnull(ls_deptcode) then
   ls_deptcode = 'XXXX'
end if	
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_apply_date = f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())
ll_rowcount = dw_kbno_create.rowcount()
for i = 1 to ll_rowcount step 1
	ls_divisioncode = dw_kbno_create.object.divisioncode[i]
	ls_itemcode = dw_kbno_create.object.itemcode[i]
	ll_shipqty  = dw_kbno_create.object.shipqty[i]
	select top 1 rackqty
	  into :ll_rackqty
	  from tmstkb
	 where areacode = :is_areacode
		and divisioncode = :ls_divisioncode
		and itemcode = :ls_itemcode
		using sqlpis;
	ll_remainqty = ll_shipqty
	if ll_rackqty = 0 or isnull(ll_rackqty) then
		ll_rackqty = ll_remainqty
	end if
	ll_count = ceiling(ll_remainqty/ll_rackqty)
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
		If dw_save.Retrieve(ls_temp_kbno,is_areacode,ls_divisioncode,ls_deptcode,'X',ls_itemcode,ls_apply_date, &
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
						 lotno       = :ls_lotno,
						 lastdate    = getdate(),
						 lastemp     = 'Y'
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
						 kbreleaseseq = 1,
						 stockdate   = :ls_close_date,
						 stockqty    = :ll_rackqty,
						 lotno       = :ls_lotno,
						 lastdate    = getdate(),
						 lastemp     = 'Y'
					where kbno = :ls_temp_kbno
					  and areacode = :is_areacode
					  and divisioncode = :ls_divisioncode
					  using sqlpis;
//				  if not wf_update_tlotno(ls_close_date,ls_lotno,ls_itemcode,ll_rackqty,ls_divisioncode,'XXXXXX','X') then
//                 return false
//				  end if
				  dw_print.retrieve(is_areacode,ls_divisioncode,ls_temp_kbno)
				  dw_print.print()
			else
				uo_status.st_message.text = "임시간판 생성시 오류 발생"
				return false
			end if
	  end if
 next
next
return true
end function

on w_piss271u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.st_2=create st_2
this.sle_truckno=create sle_truckno
this.dw_2=create dw_2
this.dw_save=create dw_save
this.dw_kbno_create=create dw_kbno_create
this.dw_print=create dw_print
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_truckno
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_save
this.Control[iCurrent+9]=this.dw_kbno_create
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.dw_4
this.Control[iCurrent+13]=this.gb_1
end on

on w_piss271u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.st_2)
destroy(this.sle_truckno)
destroy(this.dw_2)
destroy(this.dw_save)
destroy(this.dw_kbno_create)
destroy(this.dw_print)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_1)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_2, FULL)

of_resize()

end event

event ue_retrieve;long ll_count
string ls_truckno
setpointer(hourglass!)
ls_truckno = TRIM(sle_truckno.text)
IF ls_truckno = '' or isnull(ls_truckno) then
	messagebox("확인","차량번호를 입력하세요.")
	sle_truckno.setfocus()
	return 
end if	
//ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,ls_truckno,is_shipdate)
ll_count = dw_2.retrieve(is_areacode,is_divisioncode,ls_truckno,is_shipdate)
//ll_count = dw_kbno_create.retrieve(is_areacode,is_divisioncode,ls_truckno,is_shipdate)
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	sle_truckno.text = ''
	sle_truckno.setfocus()
end if	

end event

event ue_save;long ll_cancelcount, ll_rowcount, ll_i, ll_find,ll_j,ll_count,ll_cancelflag,ll_child_qty,ll_parent_qty
LONG li_cancelflag, li_remainqty, li_shipqty, li_truckorder, li_rtn,ll_kbreleaseseq
string ls_srno, ls_applydate, ls_srgubun, ls_itemcode, ls_today, ls_asgubun, ls_custcode,ls_kbno
string ls_lotno,ls_kbreleasedate,ls_shipgubun,ls_shipsheetno,ls_truckno,ls_divisioncode
string ls_kitgubun,ls_item_type,ls_pcgubun
boolean lb_commit = true
string ls_psrno,ls_min_srno,ls_interface_pcgubun
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
if mid(is_shipdate,1,7) <> mid(ls_close_date,1,7) then
	messagebox("확인","이미 마감된 월입니다.")
	return
end if	
ls_truckno     = sle_truckno.text

ll_count	= dw_2.rowcount()
ll_find 		= 0
ls_today = is_shipdate

//li_rtn = Messagebox('출하취소', '선택하신 출고 수량을 출고된 날짜의 재고 수량 까지 삭제 하시겠습니까?', Question!, YesNo!)
li_rtn = 0 
sqlpis.autocommit	= False
for ll_j = 1 to ll_count
	ll_cancelflag = dw_2.GetItemNumber(ll_j, 'cancelflag')	
	if ll_cancelflag = 1 then
		ls_shipsheetno = dw_2.GetItemstring (ll_j,'shipsheetno')	
		li_truckorder  = dw_2.object.truckorder[ll_j]
		ls_divisioncode = dw_2.GetItemstring(ll_j,'divisioncode')	
	  	dw_sheet.retrieve(is_areacode,ls_divisioncode,ls_truckno,is_shipdate,ls_shipsheetno)
	  	dw_3.retrieve(is_areacode,ls_divisioncode,is_shipdate,ls_shipsheetno)
		ll_rowcount = dw_sheet.rowcount()
		FOR ll_i = 1 TO ll_rowcount
			ls_shipsheetno = dw_sheet.GetItemString(ll_i, 'shipsheetno')
			ls_srno		   = dw_sheet.GetItemString(ll_i, 'SRNo')
			li_truckorder  = dw_sheet.GetItemnumber(ll_i, 'truckorder')
			ls_applydate	= dw_sheet.GetItemString(ll_i, 'shipdate')
			ls_divisioncode = dw_sheet.GetItemString(ll_i,'divisioncode')
			li_shipqty		= dw_sheet.GetItemNumber(ll_i, 'shipqty')
			ls_custcode		= dw_sheet.GetItemString(ll_i, 'CustCode')
			ls_itemcode	   = dw_sheet.GetItemString(ll_i, 'itemcode')	
			ls_srgubun		= dw_sheet.GetItemString(ll_i, 'SRGubun')
			li_truckorder	= dw_sheet.GetItemNumber(ll_i, 'truckorder')		
			ls_kitgubun	   = dw_sheet.GetItemstring(ll_i, 'kitgubun')		
			ls_pcgubun      =dw_sheet.GetItemstring(ll_i, 'pcgubun')		
			ls_shipgubun   = ls_srgubun		
			ls_item_type = f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
			if ls_kitgubun = 'N' or (ls_kitgubun = 'Y' and ls_pcgubun = 'C' ) then
				if ls_item_type <> '2' then //단품이 아니면 
					if not wf_update_tinv(ls_divisioncode,ls_itemcode,li_shipqty,ls_srgubun) then
						uo_status.st_message.text = "tinv update error"
						lb_commit = false
						exit
					else
						lb_commit = true
					end if	
				end if
			end if
			if not wf_update_tshipkbhis(ls_divisioncode,ls_srno,is_shipdate,li_truckorder) then
				uo_status.st_message.text = "tinv update error"
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if
			if ls_kitgubun = 'N' or (ls_kitgubun = 'Y' and ls_pcgubun = 'C' ) then
				if ls_item_type <> '2' then  //단품이 아니면 현품표
					wf_item_check(ls_divisioncode,li_shipqty,ls_itemcode)
				end if
			end if
			if not wf_update_tloadplan(ls_srno,is_shipdate,li_truckorder,li_shipqty) then
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if	
			if ls_srgubun <> 'M' then  //이체가 아니면
			   if ls_kitgubun = 'N' then
					ls_interface_pcgubun = ''
				else
					ls_interface_pcgubun = ls_pcgubun
				end if
				if not wf_update_tshipsheet_interface(is_areacode,ls_divisioncode,ls_srno,is_shipdate,ls_shipsheetno,li_shipqty,ls_interface_pcgubun) then
					lb_commit = false
					exit;
				else
					lb_commit = true
				end if	
			end if
			if not wf_update_tsrorder(ls_srno, li_shipqty,is_shipdate) then
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if	
			if not wf_update_tshipcancel(is_shipdate,is_areacode,ls_divisioncode,ls_srno,li_truckorder,li_shipqty,ls_shipsheetno) then
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if	
			if ls_kitgubun = 'N' or (ls_kitgubun = 'Y' and ls_pcgubun = 'C' ) then
				if ls_srgubun = 'M' then
					if not wf_update_tshipinv(is_shipdate,is_divisioncode,ls_srno,li_truckorder,li_shipqty) then
						lb_commit = false
						exit;
					else
						lb_commit = true
					end if
				end if	
			end if
		next
		if lb_commit = false then
			exit;
		end if
	   if not wf_update_tshipsheet(is_areacode,ls_divisioncode,ls_shipsheetno) then
			lb_commit = false
			exit;
		else
			lb_commit = true
		end if	
		ll_rowcount = dw_3.rowcount()
		FOR ll_i = 1 TO ll_rowcount
			ls_divisioncode  = dw_3.GetItemString(ll_i, 'divisioncode')
			ls_shipsheetno   = dw_3.GetItemString(ll_i, 'shipsheetno')
			li_shipqty		  = dw_3.GetItemNumber(ll_i, 'shipqty')
			ls_custcode		  = dw_3.GetItemString(ll_i, 'CustCode')
			ls_itemcode	     = dw_3.GetItemString(ll_i, 'itemcode')	
			ls_srgubun		  = dw_3.GetItemString(ll_i, 'shipGubun')
			ls_kbno		     = dw_3.GetItemString(ll_i, 'kbno')
			ls_kbreleasedate = dw_3.GetItemString(ll_i, 'kbreleasedate')
			ll_kbreleaseseq  = dw_3.GetItemnumber(ll_i, 'kbreleaseseq')
			ls_shipgubun     = ls_srgubun		
			if not wf_minus_tlotno(is_areacode,ls_divisioncode,is_shipdate,ls_custcode,ls_itemcode,li_shipqty,ls_shipgubun,ls_kbno,ls_kbreleasedate,ll_kbreleaseseq) then
				lb_commit = false
				exit;
			else
				lb_commit = true
			end if	
		NEXT
   end if	
next
//f lb_commit then
//	if wf_kbno_create() then 
//		lb_commit = true
//	else
//		lb_commit = false
//	end if	
//end if
//
if lb_commit = true then
	commit using sqlpis;
   SQLpis.AutoCommit	= True	
	messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	SQLpis.AutoCommit	= True
end if	
sle_truckno.text = ''
dw_2.reset()
dw_sheet.reset()
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss271u
end type

type dw_sheet from u_vi_std_datawindow within w_piss271u
boolean visible = false
integer x = 2194
integer y = 228
integer width = 1504
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss270u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss271u
integer x = 818
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
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
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_piss271u
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
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_kbno_create.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type uo_date from u_pisc_date_applydate within w_piss271u
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

type st_2 from statictext within w_piss271u
integer x = 1989
integer y = 104
integer width = 274
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
string text = "차량번호"
boolean focusrectangle = false
end type

type sle_truckno from singlelineedit within w_piss271u
integer x = 2258
integer y = 88
integer width = 498
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_piss271u
integer x = 50
integer y = 236
integer width = 2103
integer height = 1636
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss270u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;long ll_count
string ls_shipsheetno
ls_shipsheetno = dw_2.object.shipsheetno[row]
select count(*)
  into :ll_count
  from tshipsheet
  where areacode     = :is_areacode
    and divisioncode = :is_divisioncode
	 and shipdate     = :is_shipdate
	 and shipsheetno  = :ls_shipsheetno
	 and deliveryflag = 'Y'
	 using sqlpis;
if ll_count > 0 then
	messagebox("확인","이미 확정된 출고전표입니다.")
	dw_2.object.cancelflag[row] = '0'
	return -1
end if	
	 
end event

event itemerror;return 1
end event

type dw_save from datawindow within w_piss271u
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

type dw_kbno_create from datawindow within w_piss271u
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

type dw_print from datawindow within w_piss271u
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

type dw_3 from datawindow within w_piss271u
boolean visible = false
integer x = 1819
integer y = 520
integer width = 411
integer height = 432
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss270u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_piss271u
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

type gb_1 from groupbox within w_piss271u
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

