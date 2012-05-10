$PBExportHeader$w_piss160u.srw
$PBExportComments$출하취소(간판)
forward
global type w_piss160u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss160u
end type
type sle_1 from singlelineedit within w_piss160u
end type
type uo_area from u_pisc_select_area within w_piss160u
end type
type uo_division from u_pisc_select_division within w_piss160u
end type
type dw_input_shipsheetno from datawindow within w_piss160u
end type
type uo_date from u_pisc_date_applydate within w_piss160u
end type
type dw_2 from datawindow within w_piss160u
end type
type dw_3 from datawindow within w_piss160u
end type
type gb_2 from groupbox within w_piss160u
end type
type gb_1 from groupbox within w_piss160u
end type
end forward

global type w_piss160u from w_ipis_sheet01
integer width = 4128
string title = "출하취소"
dw_sheet dw_sheet
sle_1 sle_1
uo_area uo_area
uo_division uo_division
dw_input_shipsheetno dw_input_shipsheetno
uo_date uo_date
dw_2 dw_2
dw_3 dw_3
gb_2 gb_2
gb_1 gb_1
end type
global w_piss160u w_piss160u

type variables
boolean ib_open, ib_change = false
string is_shipsheetno,  is_change = 'NO', is_applydate,is_areacode,is_divisioncode
string is_prddate,is_itemcode,is_shipdate
string is_security, is_modelcode, is_kbno, is_asgubun, &
         is_plantcode, is_workcenter, is_shift, is_linecode, &
         is_enddate, is_invdate, is_lotno
integer ii_window_border = 10,il_qty
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,  il_kbloopsn
string  is_deliveryflag

end variables

forward prototypes
public function boolean wf_update_tsrorder (string fs_srno, integer fi_shipqty, string fs_shipdate)
public subroutine wf_dw_2_update (string fs_srno, long fl_shipqty)
public function boolean wf_kb_valid_check (string fs_kbno)
public function boolean wf_referance_data (string fs_areacode, string fs_divisioncode, string fs_kbno)
public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, long fi_shipqty, string fs_shipgubun)
public function boolean wf_update_tkb (string fs_kbno, long fi_shipqty)
public function boolean wf_update_tkbhis (string fs_kbno, long fi_shipqty, string fs_divisioncode, string fs_kbreleasedate, integer fi_kbreleaseseq)
public function boolean wf_update_tlotno (string fs_lotno, string fs_itemcode, integer fi_shipqty, string fs_divisioncode, string fs_custcode, string fs_shipgubun)
public function boolean wf_update_tshipinv (string fs_shipdate, string fs_divisioncode, string fs_srno, integer fi_truckorder, long fl_shipqty)
public function boolean wf_update_tshipkbhis (string fs_divisioncode, string fs_srno, string fs_shipdate, integer fi_truckorder, string fs_kbreleasedate, integer fi_kbreleaseseq, string fs_kbno, string fs_shipsheetno, long fi_shipqty)
public function boolean wf_update_tshipsheet ()
public function boolean wf_update_tshipsheet_interface (string fs_srno, string fs_shipsheetno, string fs_misflag, long fl_shipqty)
public function boolean wf_update_tshipsheet_parent_interface ()
public function boolean wf_update_tloadplan (string fs_srno, string fs_shipplandate, long fi_truckorder, integer fi_shipqty)
end prototypes

public function boolean wf_update_tsrorder (string fs_srno, integer fi_shipqty, string fs_shipdate);integer li_shipremainqty, li_shiporderqty, li_updateqty
string ls_orderdate, ls_separateFlag, ls_shipendgubun

select ApplyFrom, 
		 shipremainqty,
		 shiporderqty
  Into :ls_orderdate, :li_shipremainqty, :li_shiporderqty
  From tsrorder
 Where srno         = :fs_srno
   and areacode     = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;

li_updateqty	= li_shipremainqty + fi_shipqty

//If li_shiporderqty = li_updateqty then 
//	ls_separateFlag = 'N'
//Else
//	ls_separateFlag = 'Y'
//end if
ls_shipendgubun = 'N'
//If ls_orderdate < fs_today then 
//	ls_shipgubun = 'M'
//Else
//	ls_shipgubun = 'N'
//End if
	
Update tsrorder
   set shipremainqty	= :li_updateqty,
	    ShipEndGubun	= :ls_shipendgubun,
		 LastEmp			= 'Y',
		 Lastdate		= GetDate()
 where srno = :fs_srno
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;

If sqlpis.sqlcode = 0 Then
	return True
Else
	return False
End if
end function

public subroutine wf_dw_2_update (string fs_srno, long fl_shipqty);long ll_find,ll_remainqty
dw_2.accepttext()
ll_find = dw_2.find("srno = '" + fs_srno + "'",1,dw_2.rowcount())
if ll_find > 0 then
	ll_remainqty = dw_2.object.remainqty[ll_find]
	dw_2.object.remainqty[ll_find] = ll_remainqty + fl_shipqty
end if	

end subroutine

public function boolean wf_kb_valid_check (string fs_kbno);Integer	li_count
string ls_kbstatuscode
SELECT Count(KBNO),kbstatuscode
  into :li_count,:ls_kbstatuscode
  FROM TKB
 WHERE	TKB.AreaCode	   = :is_areacode
   and   TKB.DivisionCode	= :is_divisioncode
   and	(TKB.KBStatusCode	= 'D' or	TKB.KBStatusCode	= 'F')
   and	TKB.KBNO				= :fs_kbno
   and	KBActiveGubun		= 'A'
	group by kbstatuscode
	using sqlpis;
If li_count > 0 then 
	Return True
Else
	
	Return False
End if

end function

public function boolean wf_referance_data (string fs_areacode, string fs_divisioncode, string fs_kbno);long ll_found,ll_cancelflag,ll_shipqty,ll_start
string ls_pcgubun,ls_kitgubun,ls_srno
ll_start = 1

ll_found = dw_sheet.Find("kbno = '" + fs_kbno + "'", ll_start,dw_sheet.rowcount())

if ll_found > 0 then
   DO UNTIL false
  	   ll_found = dw_sheet.Find("kbno = '" + fs_kbno + "'", ll_start,dw_sheet.rowcount())
		if ll_start > dw_sheet.rowcount() then
			exit
		end if
		if ll_found < 1 then
			exit
		end if
		ll_start = ll_found + 1
	   ls_srno = dw_sheet.object.srno[ll_found]
	   select pcgubun,kitgubun
  	     into :ls_pcgubun,:ls_kitgubun
	     from tsrorder
	    where areacode = :is_areacode
	      and divisioncode = :is_divisioncode
		   and srno     = :ls_srno
		 using sqlpis;
	   if ls_pcgubun = 'C' and ls_kitgubun = 'Y' then
		   return false
	   end if
	   ll_cancelflag = dw_sheet.object.cancelflag[ll_found]
	   ll_shipqty = dw_sheet.object.shipqty[ll_found]
	   if ll_cancelflag = 0 then 
		   dw_sheet.object.cancelflag[ll_found] = 1
		   wf_dw_2_update(ls_srno,ll_shipqty * -1)
	   else
		   dw_sheet.object.cancelflag[ll_found] = 0
		   wf_dw_2_update(ls_srno,ll_shipqty)
	   end if
	LOOP

else
	messagebox("확인","출고가 안된 간판입니다.")
	return false
end if


return true
end function

public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, long fi_shipqty, string fs_shipgubun);long ll_count
string ls_applydate
//ls_date = f_getcurrentdate()
//ls_date = is_date
long ll_moveinvqty,ll_shipinvqty
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

select count(*)
  Into :ll_count
  From tinv
 Where Itemcode	  = :fs_itemcode
	and divisioncode = :fs_divisioncode
	and areacode     = :is_areacode
	using sqlpis;

if ll_count = 0 then
	insert into tinv (areacode,divisioncode,itemcode,invqty,moveinvqty,shipinvqty,lastemp,lastdate)
	   values (:is_areacode,:fs_divisioncode,:fs_itemcode,:fi_shipqty,:ll_moveinvqty * -1,:ll_shipinvqty * -1,'Y',getdate())
		using sqlpis;
else		
	update tinv
	   set invqty   = invqty + :fi_shipqty,
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

public function boolean wf_update_tkb (string fs_kbno, long fi_shipqty);integer li_count, li_max

Select count(KBNO) 
  into :li_count
  From tkb
 Where kbno = :fs_kbno
	using sqlpis;
IF li_count = 1 then
	Update tkb
		set CurrentQty   = CurrentQty + :fi_shipqty,
		    KBStatusCode = 'D',			
			 shipdate     = :is_shipdate,				 
			 shipqty      = shipqty - :fi_shipqty,
			 KBShipTime	  = GetDate(),
			 Lastemp		  = 'Y',
			 LastDate	  = GetDate()
	 Where KBNO			  = :fs_kbno
		using sqlpis;
	 
	If sqlpis.sqlcode = 0 Then
		return true
	Else
		uo_status.st_message.text = "tkb 오류 : " +sqlpis.sqlerrtext
		return False
	End if
Else
	uo_status.st_message.text = "tkb 오류 : " +sqlpis.sqlerrtext
	Return False
End if

end function

public function boolean wf_update_tkbhis (string fs_kbno, long fi_shipqty, string fs_divisioncode, string fs_kbreleasedate, integer fi_kbreleaseseq);integer li_count, li_max

Select count(KBNO) 
  into :li_count
  From tkbhis
 Where kbno = :fs_kbno
	And KBActiveGubun	= 'A'
	and areacode      = :is_areacode
	and divisioncode  = :fs_divisioncode
	and kbreleasedate = :fs_kbreleasedate
	and kbreleaseseq  = :fi_kbreleaseseq
	using sqlpis;
	
IF li_count = 1 then
	Update tkbhis
		set CurrentQty = CurrentQty + :fi_shipqty,
			 shipqty    = shipqty - :fi_shipqty,
		    KBStatusCode = 'D',			
		    LastloopFlag	= 'N',								
			 KBShipTime	= GetDate(),
			 Lastemp		= 'Y',
			 shipdate   = :is_shipdate,
			 LastDate	= GetDate()
	 Where KBNO			= :fs_kbno
	   and areacode   = :is_areacode
		and divisioncode = :fs_divisioncode
		And KBActiveGubun	= 'A'
	   and kbreleasedate = :fs_kbreleasedate
	   and kbreleaseseq  = :fi_kbreleaseseq
		using sqlpis;
	 
	if sqlpis.sqlcode = 0 Then
		return true
	Else
		uo_status.st_message.text = 'tkbhis : ' + sqlpis.sqlerrtext
		return False
	End if
Else
	Return False
End if

end function

public function boolean wf_update_tlotno (string fs_lotno, string fs_itemcode, integer fi_shipqty, string fs_divisioncode, string fs_custcode, string fs_shipgubun);long ll_count, ll_shipqty
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

select count(LotNo),
		 ShipQty
  Into :ll_count,
  		 :ll_shipqty
  From tlotno
 Where DivisionCode = :fs_divisioncode
   and areacode     = :is_areacode
   and Lotno		  = :fs_lotno
   and ItemCode	  = :fs_itemcode
	and TraceDate	  = :is_shipdate
	and custcode     = :fs_custcode
	and shipgubun    = :fs_shipgubun
Group by ShipQty
using sqlpis;


	//출하일자의 같은 Lotno 의 테이타가 있다면 Update
if ll_count = 1 Then

	Update tlotno
	   Set shipqty		  = shipqty - :fi_shipqty,
		    lastemp      = 'Y',
			 lastdate     = getdate()
	 Where DivisionCode = :fs_divisioncode
		and areacode     = :is_areacode
		and Lotno		  = :fs_lotno
		and ItemCode	  = :fs_itemcode
		and TraceDate	  = :is_shipdate
		and custcode     = :fs_custcode
		and shipgubun    = :fs_shipgubun
		using sqlpis;
Else
	// 출고일자의 같은 lotno 가 없다면 insert
	Insert into tlotno 
	            (TraceDate,AreaCode,DivisionCode,Lotno,Itemcode,
				    custcode,shipgubun,shipQty,Lastemp, lastdate)
		  Values (:is_shipdate,:is_areacode,:fs_divisioncode,:fs_lotno,:fs_itemcode,
			       :fs_custcode,:fs_shipgubun,:fi_shipqty * -1,'Y', GetDate())
			using sqlpis;
end if
	
if Sqlpis.sqlcode = 0 then
	return true
else
	uo_status.st_message.text = "tlotnohis오류 : " + sqlpis.sqlerrtext
	return false
End if
end function

public function boolean wf_update_tshipinv (string fs_shipdate, string fs_divisioncode, string fs_srno, integer fi_truckorder, long fl_shipqty);string ls_truckno,ls_sendflag
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
dw_3.settransobject(sqlpis)
dw_3.retrieve(fs_shipdate,is_areacode,fs_divisioncode,fs_srno,fi_truckorder,ls_truckno,fs_shipdate,fl_shipqty,g_s_empno)
if dw_3.rowcount() <> 1 then
	ls_sendflag = 'N'	
end if
ll_error = dw_3.object.error[1]
if dw_3.object.error[1] <> 0 then
	ls_sendflag = 'N'
else
end if

update  tshipinv
   set truckloadqty  = truckloadqty - :fl_shipqty,
	    sendflag      = :ls_sendflag,
		 lastemp       = :g_s_empno,
		 lastdate      = getdate()
  where shipplandate = :fs_shipdate
    and areacode     = :is_areacode
	 and divisioncode = :fs_divisioncode
	 and srno         = :fs_srno
	 and truckorder   = :fi_truckorder
	 using sqlpis;
if sqlpis.sqlcode = 0 then
	return true
else
	uo_status.st_message.text = "tshipinv error : " + sqlpis.sqlerrtext
	return false
end if	

end function

public function boolean wf_update_tshipkbhis (string fs_divisioncode, string fs_srno, string fs_shipdate, integer fi_truckorder, string fs_kbreleasedate, integer fi_kbreleaseseq, string fs_kbno, string fs_shipsheetno, long fi_shipqty);delete from tshipkbhis
 where areacode      = :is_areacode
	and divisioncode  = :fs_divisioncode
	and srno          = :fs_srno
	and shipdate      = :is_shipdate
	and truckorder    = :fi_truckorder
	and kbreleasedate = :fs_kbreleasedate
	and kbreleaseseq  = :fi_kbreleaseseq
	and kbno          = :fs_kbno
 using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipkbhis 변경시 오류 " + sqlpis.sqlerrtext
	return false
end if	

return true

end function

public function boolean wf_update_tshipsheet ();long ll_rowcount,i,ll_shipqty,ll_remainqty
string ls_srno,ls_shipsheetno,ls_misflag
boolean lb_commit
lb_commit = true
ll_rowcount = dw_2.rowcount()
for i = 1 to ll_rowcount step 1
	ll_shipqty     = dw_2.object.shipqty[i]
	ll_remainqty   = dw_2.object.remainqty[i]
	ls_srno        = dw_2.object.srno[i]
	ls_shipsheetno = dw_2.object.shipsheetno[i]
	if ll_remainqty <> ll_shipqty then
		if ll_remainqty = 0 then
			delete from tshipsheet
			  where areacode     = :is_areacode
				 and divisioncode = :is_divisioncode
				 and shipsheetno  = :ls_shipsheetno
				 and srno         = :ls_srno
				 and shipdate     = :is_shipdate
			  using sqlpis;
			  ls_misflag = 'D'
		else
			update tshipsheet
				set shipqty  = :ll_remainqty,
					 lastemp  = 'Y',
					 lastdate = getdate()
			 where areacode      = :is_areacode
				 and divisioncode = :is_divisioncode
				 and shipsheetno  = :ls_shipsheetno
				 and srno         = :ls_srno
				 and shipdate     = :is_shipdate
			  using sqlpis;
			  ls_misflag = 'R'		  
		end if
		if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = '출하전표 오류' 
			lb_commit = false
			exit
		end if
		if mid(ls_shipsheetno,3,1) <> 'M' then //이체는 인터페이스안함
			if not wf_update_tshipsheet_interface(ls_srno,ls_shipsheetno,ls_misflag,ll_remainqty) then
				uo_status.st_message.text = '출하전표 INTERFACE 오류' 
				lb_commit = false
				exit
			end if
		end if
	end if
next
return true
end function

public function boolean wf_update_tshipsheet_interface (string fs_srno, string fs_shipsheetno, string fs_misflag, long fl_shipqty);long ll_seqno
string ls_kitgubun,ls_pcgubun
select kitgubun,pcgubun
  into :ls_kitgubun,:ls_pcgubun
  from tsrorder
  where srno = :fs_srno
    and srareacode = :is_areacode
	 and srdivisioncode = :is_divisioncode
using sqlpis;

if ls_kitgubun = 'Y' then
	ls_kitgubun = ls_pcgubun
else
	ls_kitgubun = ''
end if	

string ls_srno
select top 1 substring(:fs_srno,1,len(:fs_srno) - 3) 
  into :ls_srno
  from sysusers
  using sqlpis;

select max(seqno)
  into :ll_seqno
  from tshipsheet_interface
  where shipdate = :is_shipdate
    and areacode = :is_areacode
	 and divisioncode = :is_divisioncode
	 and srno         = :ls_srno
	 and shipsheetno  = :fs_shipsheetno
	 and misflag      = :fs_misflag
	using sqlpis;
if isnull(ll_seqno) then
	ll_seqno = 0
end if

if ll_seqno <> 0 then
	update tshipsheet_interface
	   set shipqty = :fl_shipqty
	  where shipdate = :is_shipdate
		 and areacode = :is_areacode
		 and divisioncode = :is_divisioncode
		 and srno         = :ls_srno
		 and shipsheetno  = :fs_shipsheetno
		 and misflag      = :fs_misflag
		using sqlpis;
else
	ll_seqno = 1
   INSERT INTO TSHIPSHEET_INTERFACE  
	       	  (ShipDate,AreaCode,DivisionCode,SRNo,SeqNo,   
		         ShipSheetNo,KITGubun,ShipQty,
		         MISflag,InterfaceFlag,LastEmp,LastDate )  
       VALUES (:is_shipdate,:is_areacode,:is_divisioncode,:ls_srno,:ll_seqno,
		         :fs_shipsheetno,:ls_kitgubun,:fl_shipqty,
		         :fs_misflag,'Y',:g_s_empno,getdate())
         using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tshipsheet_interface : " + sqlpis.sqlerrtext
	return false
end if	

return true
end function

public function boolean wf_update_tshipsheet_parent_interface ();//long ll_seqno
//string ls_kitgubun,ls_pcgubun
//select kitgubun,pcgubun
//  into :ls_kitgubun,:ls_pcgubun
//  from tsrorder
//  where srno = :fs_srno
//    and srareacode = :is_areacode
//	 and srdivisioncode = :is_divisioncode
//using sqlpis;
//
//if ls_kitgubun = 'Y' then
//	ls_kitgubun = ls_pcgubun
//else
//	ls_kitgubun = ''
//end if	
//
//string ls_srno
//select top 1 substring(:fs_srno,1,len(:fs_srno) - 3) 
//  into :ls_srno
//  from sysusers
//  using sqlpis;
//
//select max(seqno)
//  into :ll_seqno
//  from tshipsheet_interface
//  where shipdate = :is_shipdate
//    and areacode = :is_areacode
//	 and divisioncode = :is_divisioncode
//	 and srno         = :ls_srno
//	 and shipsheetno  = :fs_shipsheetno
//	 and misflag      = :fs_misflag
//	using sqlpis;
//if isnull(ll_seqno) then
//	ll_seqno = 0
//end if
//
//if ll_seqno <> 0 then
//	update tshipsheet_interface
//	   set shipqty = :fl_shipqty
//	  where shipdate = :is_shipdate
//		 and areacode = :is_areacode
//		 and divisioncode = :is_divisioncode
//		 and srno         = :ls_srno
//		 and shipsheetno  = :fs_shipsheetno
//		 and misflag      = :fs_misflag
//		using sqlpis;
//else
//	ll_seqno = 1
//   INSERT INTO TSHIPSHEET_INTERFACE  
//	       	  (ShipDate,AreaCode,DivisionCode,SRNo,SeqNo,   
//		         ShipSheetNo,KITGubun,ShipQty,
//		         MISflag,InterfaceFlag,LastEmp,LastDate )  
//       VALUES (:is_shipdate,:is_areacode,:is_divisioncode,:ls_srno,:ll_seqno,
//		         :fs_shipsheetno,:ls_kitgubun,:fl_shipqty,
//		         :fs_misflag,'Y',:g_s_empno,getdate())
//         using sqlpis;
//end if
//if sqlpis.sqlcode <> 0 then
//	SQLPIS.AUTOCOMMIT = TRUE
//	messagebox("확인","tshipsheet_interface : " + sqlpis.sqlerrtext)
//	return false
//end if	
//
return true
end function

public function boolean wf_update_tloadplan (string fs_srno, string fs_shipplandate, long fi_truckorder, integer fi_shipqty);long ll_shipqty
select truckloadqty 
  into :ll_shipqty
  from tloadplan
 where srno	        = :fs_srno
   and TruckOrder	  = :fi_truckorder
	and shipplanDate = :fs_shipplandate
	and areacode	  = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;
if ll_shipqty = fi_shipqty then
	delete from tloadplan
	 where srno	= :fs_srno
		and TruckOrder	= :fi_truckorder
		and shipplanDate	= :fs_shipplandate
		and areacode	= :is_areacode
		and divisioncode = :is_divisioncode
		using sqlpis;
else
	update tloadplan
		set truckloadqty = truckloadqty - :fi_shipqty,
			 lastdate     = getdate(),
			 lastemp      = :g_s_empno
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
		    lastdate     = getdate(),
		    lastemp      = :g_s_empno
    where srno	        = :fs_srno
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

on w_piss160u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.sle_1=create sle_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_input_shipsheetno=create dw_input_shipsheetno
this.uo_date=create uo_date
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_input_shipsheetno
this.Control[iCurrent+6]=this.uo_date
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
end on

on w_piss160u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.sle_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_input_shipsheetno)
destroy(this.uo_date)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_input_shipsheetno.settransobject(sqlpis)
dw_input_shipsheetno.insertrow(0)

end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;long ll_count

setpointer(hourglass!)
dw_input_shipsheetno.accepttext()
is_shipsheetno = dw_input_shipsheetno.object.shipsheetno_1[1] + dw_input_shipsheetno.object.shipsheetno_2[1] + dw_input_shipsheetno.object.shipsheetno_3[1]
ll_count = dw_2.retrieve(is_areacode,is_divisioncode,is_shipsheetno,is_shipdate)
ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_shipsheetno,is_shipdate)
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	dw_input_shipsheetno.setfocus()
	dw_input_shipsheetno.setcolumn('shipsheetno_1')	
	return
ELSE
	sle_1.text = ''
	sle_1.setfocus()
end if	

select count(*)
 into :ll_count 
 from tshipsheet
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and shipsheetno = :is_shipsheetno
	and deliveryflag = 'Y'
	using sqlpis;
if ll_count > 0 then
	is_deliveryflag = 'Y'
	messagebox("확인","이미 확정되어 수정할수 없습니다.")
	dw_2.reset()
	dw_sheet.reset()
	return
end if	

end event

event ue_save;long ll_cancelcount, ll_rowcount, ll_i, ll_find
LONG li_cancelflag, li_remainqty, li_shipqty, li_truckorder, li_rtn,li_kbreleaseseq
string ls_srno, ls_applydate, ls_srgubun, ls_itemcode, ls_today, ls_asgubun, ls_custcode,ls_kbno
string ls_lotno,ls_kbreleasedate,ls_shipgubun,ls_shipsheetno

boolean lb_commit = false
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
if left(is_shipdate,7) <> left(ls_close_date,7) then
	messagebox("확인","이미 마감된 월입니다.")
	return
end if	
ls_shipsheetno = dw_input_shipsheetno.object.shipsheetno_1[1] + dw_input_shipsheetno.object.shipsheetno_2[1] + dw_input_shipsheetno.object.shipsheetno_3[1]
ll_cancelcount	= dw_sheet.getitemNumber(1, 'cancelcount')

if ll_cancelcount = 0 then
	Messagebox('출고 취소', '선택된 출고전표가 없습니다....')
	is_change = 'NO'
	return
end if

ll_rowcount	= dw_sheet.rowcount()
ll_find 		= 0
ls_today = is_shipdate

//li_rtn = Messagebox('출하취소', '선택하신 출고 수량을 출고된 날짜의 재고 수량 까지 삭제 하시겠습니까?', Question!, YesNo!)
li_rtn = 0 
sqlpis.autocommit	= False
FOR ll_i = 1 TO ll_cancelcount
	
	ll_find		   = dw_sheet.find("cancelflag = 1", ll_find + 1, ll_rowcount)
	ls_srno		   = dw_sheet.GetItemString(ll_i, 'SRNo')
	ls_kbno		   = dw_sheet.GetItemString(ll_i, 'KBNo')
	li_truckorder  = dw_sheet.GetItemnumber(ll_i, 'truckorder')
	ls_applydate	= dw_sheet.GetItemString(ll_i, 'applydate')
	li_shipqty		= dw_sheet.GetItemNumber(ll_i, 'shipqty')
	ls_custcode		= dw_sheet.GetItemString(ll_i, 'CustCode')
	ls_itemcode	   = dw_sheet.GetItemString(ll_i, 'itemcode')	
	ls_srgubun		= dw_sheet.GetItemString(ll_i, 'SRGubun')
	ls_shipgubun   = ls_srgubun
	li_truckorder	= dw_sheet.GetItemNumber(ll_i, 'truckorder')		
		
	if not wf_update_tinv(is_divisioncode,ls_itemcode,li_shipqty,ls_shipgubun) then
		uo_status.st_message.text = "tinv update error"
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	if not wf_update_tkb(ls_kbno,li_shipqty) then
		uo_status.st_message.text = "tkb update error"
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	select top 1 kbreleasedate,kbreleaseseq
	  into :ls_kbreleasedate,:li_kbreleaseseq
	  from tshipkbhis
	 where areacode     = :is_areacode
	   and divisioncode = :is_divisioncode
		and kbno         = :ls_kbno
		and shipdate     = :is_shipdate
		and shipsheetno  = :ls_shipsheetno
		using sqlpis;
	if isnull(ls_kbreleasedate) or ls_kbreleasedate = '' then
	   ls_kbreleasedate = 'XXXX.XX.XX'
		li_kbreleaseseq = 1
	end if
	if not wf_update_tkbhis(ls_kbno,li_shipqty,is_divisioncode,ls_kbreleasedate,li_kbreleaseseq) then
		messagebox("확인","tkbhis update error")
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	if not wf_update_tloadplan(ls_srno,is_shipdate,li_truckorder,li_shipqty) then
		uo_status.st_message.text = "tkbhis update error"
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	select  lotno
	  into  :ls_lotno
	  from  tkbhis
	  where kbno = :ls_kbno
	    and kbreleasedate = :ls_kbreleasedate
		 and kbreleaseseq = :li_kbreleaseseq
	  using sqlpis;
	if isnull(ls_lotno) or ls_lotno = '' then
		ls_lotno = 'XXXXXX'
	end if
	if not wf_update_tlotno(ls_lotno,ls_itemcode,li_shipqty,is_divisioncode,ls_custcode,ls_shipgubun) then
		uo_status.st_message.text = "tlotno update error"
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	if not wf_update_tshipkbhis(is_divisioncode,ls_srno,ls_close_date,li_truckorder,ls_kbreleasedate,li_kbreleaseseq,ls_kbno,ls_shipsheetno,li_shipqty) then
		uo_status.st_message.text = "tshipkbhis update error"
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	if not wf_update_tsrorder(ls_srno, li_shipqty,ls_close_date) then
		uo_status.st_message.text = "tsrorder update error"
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
	if ls_srgubun = 'M' then
		if not wf_update_tshipinv(ls_close_date,is_divisioncode,ls_srno,li_truckorder,li_shipqty) then
			uo_status.st_message.text = "tshipinv update error"
			lb_commit = false
			exit;
		else
			lb_commit = true
		end if
   end if	
NEXT
if lb_commit = true then
	IF wf_update_tshipsheet() then
		lb_commit = true
	else
		lb_commit = false
	end if	
end if
if lb_commit = true then
	commit using sqlpis;
	SQLpis.AutoCommit	= True
	messagebox("확인","취소 작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	SQLpis.AutoCommit	= True
end if	

sle_1.text = ''
triggerevent('ue_retrieve')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_input_shipsheetno.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss160u
end type

type dw_sheet from u_vi_std_datawindow within w_piss160u
integer x = 23
integer y = 236
integer width = 3575
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss160u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type sle_1 from singlelineedit within w_piss160u
integer x = 2930
integer y = 76
integer width = 699
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;If wf_kb_valid_check(This.Text) Then
	if wf_referance_Data(is_areacode,is_divisioncode,this.text)  then
		this.text = ''
	   this.SetFocus()		
	else
	   MessageBox('확인', "미 출하된 간판이거나 KIT자품번입니다.")
		this.text = ''
	   this.SetFocus()		
	End if
Else
	MessageBox("확인", "올바르지 않은 간판입니다." + "~r~n"+ "간판번호를 확인한 후, Scanning하여 주십시오...")
	this.text = ''
	this.SetFocus()
End if
end event

type uo_area from u_pisc_select_area within w_piss160u
integer x = 818
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_input_shipsheetno.settransobject(sqlpis)
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

type uo_division from u_pisc_select_division within w_piss160u
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
dw_input_shipsheetno.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type dw_input_shipsheetno from datawindow within w_piss160u
integer x = 1961
integer y = 96
integer width = 891
integer height = 96
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss160u_02"
boolean border = false
boolean livescroll = true
end type

event itemchanged;dw_sheet.reset()


end event

type uo_date from u_pisc_date_applydate within w_piss160u
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

type dw_2 from datawindow within w_piss160u
boolean visible = false
integer x = 1376
integer y = 416
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss160u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_piss160u
boolean visible = false
integer x = 2117
integer y = 364
integer width = 411
integer height = 432
integer taborder = 210
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_13"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_piss160u
integer x = 2889
integer y = 8
integer width = 777
integer height = 224
integer taborder = 60
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

type gb_1 from groupbox within w_piss160u
integer x = 23
integer y = 28
integer width = 2848
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

