$PBExportHeader$w_piss340u.srw
$PBExportComments$출하관리(군산용)
forward
global type w_piss340u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss340u
end type
type uo_division from u_pisc_select_division within w_piss340u
end type
type uo_scustgubun from u_pisc_select_code within w_piss340u
end type
type uo_custcode from u_piss_select_custcode within w_piss340u
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss340u
end type
type st_5 from statictext within w_piss340u
end type
type st_4 from statictext within w_piss340u
end type
type st_3 from statictext within w_piss340u
end type
type em_1 from editmask within w_piss340u
end type
type gb_1 from groupbox within w_piss340u
end type
type dw_print from datawindow within w_piss340u
end type
type dw_hidden1 from datawindow within w_piss340u
end type
type dw_sheet from u_vi_std_datawindow within w_piss340u
end type
type dw_update_tshipsheet from datawindow within w_piss340u
end type
type dw_3 from datawindow within w_piss340u
end type
type em_2 from editmask within w_piss340u
end type
type st_2 from statictext within w_piss340u
end type
type st_6 from statictext within w_piss340u
end type
type dw_hidden from datawindow within w_piss340u
end type
type pb_excel from picturebutton within w_piss340u
end type
end forward

global type w_piss340u from w_ipis_sheet01
integer width = 4283
string title = "출하관리(군산)"
uo_area uo_area
uo_division uo_division
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
uo_shipoemgubun uo_shipoemgubun
st_5 st_5
st_4 st_4
st_3 st_3
em_1 em_1
gb_1 gb_1
dw_print dw_print
dw_hidden1 dw_hidden1
dw_sheet dw_sheet
dw_update_tshipsheet dw_update_tshipsheet
dw_3 dw_3
em_2 em_2
st_2 st_2
st_6 st_6
dw_hidden dw_hidden
pb_excel pb_excel
end type
global w_piss340u w_piss340u

type variables
string is_kbno,is_custgubun
string is_areacode,is_divisioncode,is_date,is_date1,is_itemcode,is_productgroup,is_shipgubun,is_custcode
long  il_qty,il_shipeditno = 0
boolean ib_open
end variables

forward prototypes
public function boolean wf_print_setting (string fs_shipsheetno)
public function boolean wf_update_tshipinv (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_itemcode, long fl_shipqty, string fs_shipgubun, string fs_custcode)
public function boolean wf_update_tshipkbhis (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipsheetno, long fl_shipqty)
public subroutine wf_hidden_check (string fs_srno, long fl_shipqty)
public subroutine wf_insert_hidden (integer fl_row)
public function boolean wf_update_tlotno (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_itemcode, long fl_shipqty, string fs_shipgubun, string fs_shipusage)
public function boolean wf_update_tinv (string fs_areacode, string fs_divisioncode, string fs_itemcode, long fl_shipqty, string fs_shipgubun)
public function boolean wf_update_tshipsheet ()
public function boolean wf_save_danpum_inv101 (integer a_row)
public function boolean wf_errchk (string fs_column, long fl_row)
public function boolean wf_update_tsrorder (string fs_areacode, string fs_divisioncode, string fs_srno, long fl_shipqty, long fl_shipremainqty, string fs_shipgubun)
public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty)
public function boolean wf_save ()
end prototypes

public function boolean wf_print_setting (string fs_shipsheetno);long i,ll_rowcount,j,k
datawindowchild dwc_1,dwc_2

dw_print.getchild("dw_1", dwc_1)
dw_print.getchild("dw_2", dwc_2)

dwc_1.settransobject(sqlpis)
dwc_2.settransobject(sqlpis)
dwc_1.reset()
dwc_2.reset()

string ls_TruckNo,ls_custcode,ls_custname,ls_custno,ls_custheadname,ls_custaddress
integer li_TruckOrder

ls_TruckNo      = dw_hidden1.object.truckno[1]
ls_custcode     = dw_hidden1.object.custcode[1]
ls_custname     = dw_hidden1.object.custname[1]
ls_custno       = dw_hidden1.object.custno[1]
ls_custheadname = dw_hidden1.object.custheadname[1]
ls_custaddress  = dw_hidden1.object.custaddress[1]
li_truckorder   = dw_hidden1.object.truckorder[1]

ll_rowcount = dw_hidden1.rowcount()

FOR i=1 TO ll_rowcount STEP 1
    dwc_1.insertrow(0)
    dwc_2.insertrow(0)
	 dwc_1.setitem(i,'shipsheetno',fs_shipsheetno)
	 dwc_1.setitem(i,'custno',ls_custno)
	 dwc_1.setitem(i,'custname',ls_custname)
	 dwc_1.setitem(i,'custheadname',ls_custheadname)
	 dwc_1.setitem(i,'custaddress',ls_custaddress)
	 dwc_1.setitem(i,'truckno',ls_truckno)
	 dwc_1.setitem(i,'cnt',string(i))
	 dwc_1.setitem(i,'itemcode',dw_hidden1.object.itemcode[i])
	 dwc_1.setitem(i,'itemname',dw_hidden1.object.itemname[i])
 	 dwc_1.setitem(i,'customeritemno',dw_hidden1.object.customeritemno[i])
    dwc_1.setitem(i,'srno',dw_hidden1.object.srno[i])
	 dwc_1.setitem(i,'shipusage',dw_hidden1.object.shipusage[i])
	 dwc_1.setitem(i,'shipqty',dw_hidden1.object.shipqty[i])
	 dwc_1.setitem(i,'checksrno',dw_hidden1.object.checksrno[i])
 	 dwc_2.setitem(i,'shipsheetno',fs_shipsheetno)
	 dwc_2.setitem(i,'custno',ls_custno)
	 dwc_2.setitem(i,'custname',ls_custname)
	 dwc_2.setitem(i,'custheadname',ls_custheadname)
	 dwc_2.setitem(i,'custaddress',ls_custaddress)
	 dwc_2.setitem(i,'truckno',ls_truckno)
	 dwc_2.setitem(i,'cnt',string(i))
	 dwc_2.setitem(i,'itemcode',dw_hidden1.object.itemcode[i])
	 dwc_2.setitem(i,'itemname',dw_hidden1.object.itemname[i])
 	 dwc_2.setitem(i,'customeritemno',dw_hidden1.object.customeritemno[i])
    dwc_2.setitem(i,'srno',dw_hidden1.object.srno[i])
	 dwc_2.setitem(i,'shipusage',dw_hidden1.object.shipusage[i])
	 dwc_2.setitem(i,'shipqty',dw_hidden1.object.shipqty[i])
	 dwc_2.setitem(i,'checksrno',dw_hidden1.object.checksrno[i])
NEXT
FOR k = i TO 10 STEP 1
    dwc_1.insertrow(0)
    dwc_2.insertrow(0)
	 dwc_1.setitem(k,'shipsheetno',fs_shipsheetno)	 
	 dwc_1.setitem(k,'custno',ls_custno)
	 dwc_1.setitem(k,'custname',ls_custname)
	 dwc_1.setitem(k,'custheadname',ls_custheadname)
	 dwc_1.setitem(k,'custaddress',ls_custaddress)
	 dwc_1.setitem(k,'truckno',ls_truckno)
//	 messagebox("jjjjj",dwc_1.getitemstring(i,'truckno'))	 
	 dwc_2.setitem(k,'shipsheetno',fs_shipsheetno)	 
	 dwc_2.setitem(k,'custno',ls_custno)
	 dwc_2.setitem(k,'custname',ls_custname)
	 dwc_2.setitem(k,'custheadname',ls_custheadname)
	 dwc_2.setitem(k,'custaddress',ls_custaddress)
	 dwc_2.setitem(k,'truckno',ls_truckno)
NEXT

return true
end function

public function boolean wf_update_tshipinv (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_itemcode, long fl_shipqty, string fs_shipgubun, string fs_custcode);string ls_truckno,ls_sendflag
long ll_error
dw_3.settransobject(sqlpis)
ls_sendflag = 'Y'
ls_sendflag = 'N'	

string ls_areacode,ls_divisioncode,ls_moverequireno
select moveareacode,movedivisioncode,moverequireno          //의뢰지역찾기
  into :ls_areacode,:ls_divisioncode,:ls_moverequireno
  from tsrorder
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and srno = :fs_srno
	using sqlpis;
  
  INSERT INTO TSHIPINV  
         ( ShipPlanDate,AreaCode,DivisionCode,
			  SRNo,TruckOrder,FromAreaCode,FromDivisionCode,   
           TruckNo,ShipDate,ShipGubun,ItemCode,CustCode,ShipEditNo,ApplyFrom,
			  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MOVEREQUIRENO,
           MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,SendFlag, 
           LastEmp,LastDate )  
  VALUES ( :is_date,:fs_areacode,:fs_divisioncode,   
           :fs_srno,0,:ls_areacode,:ls_divisioncode,
			  'zzzz',:is_date,:fs_shipgubun,:fs_itemcode,:fs_custcode,:il_shipeditno,:is_date,   
           :fl_shipqty,0,'N',:ls_moverequireno,'Y',null, null,'N',   
           'Y',getdate() )  
	  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "Tshipinv insert시 오류가 발생하였습니다."
	return false
end if
return true
end function

public function boolean wf_update_tshipkbhis (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_srno, string fs_shipsheetno, long fl_shipqty);INSERT INTO TSHIPKBHIS  
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
VALUES ( :fs_shipdate,   
		  :fs_areacode,   
		  :fs_divisioncode,   
		  :fs_srno,   
		  0,   
		  :fs_shipsheetno,   
		  'XXXXXXXXXXX',   
		  :fs_shipdate,   
		  1,   
		  :fl_shipqty,   
		  'Y',   
		  getdate() ) 
		  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "Tshipkbhis insert시 오류가 발생하였습니다."
	return false
end if
return true

end function

public subroutine wf_hidden_check (string fs_srno, long fl_shipqty);long ll_find
DO 
	ll_find = dw_hidden.find("psrno = '" + fs_srno + "'",1,dw_hidden.rowcount())
	if ll_find <= 0 then
		exit
	end if
	if ll_find > 0 and fl_shipqty = 0 then
		dw_hidden.deleterow(ll_find)
	end if
LOOP UNTIL false



end subroutine

public subroutine wf_insert_hidden (integer fl_row);long ll_parent_qty,ll_child_qty,ll_count,ll_shipeditno,ll_shipqty,ll_shipremainqty
string ls_srno,ls_itemcode,ls_custcode,ls_shipgubun,ls_psrno,ls_pcgubun,ls_kitgubun
boolean lb_commit
long l,ll_row

ls_psrno    = dw_sheet.object.psrno[fl_row]
ls_kitgubun = dw_sheet.object.kitgubun[fl_row]
ls_srno     = dw_sheet.object.srno[fl_row]
ll_shipqty  = dw_sheet.object.shipqty[fl_row]
if ls_kitgubun = 'N' then  //KIT품번이 아닌 경우
   l = dw_sheet.RowsCopy(fl_row,fl_row, Primary!, dw_hidden, 1, Primary!)
	return
end if	
//KIT품번
 dw_sheet.RowsCopy(fl_row,fl_row, Primary!, dw_hidden, 1, Primary!)

select shiporderqty
  into :ll_parent_qty
  from tsrorder
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and srno = :ls_psrno
	using sqlpis;
DECLARE tsroder_cur CURSOR FOR
 SELECT srno,shiporderqty,itemcode,
        shipeditno,custcode,shipgubun,
		  shipremainqty,pcgubun,kitgubun
	FROM tsrorder
  WHERE areacode = :is_areacode
    and divisioncode = :is_divisioncode
	 and psrno = :ls_srno
	 and pcgubun = 'C'
	 using sqlpis;
open tsroder_cur;	 

fetch tsroder_cur 
 into :ls_srno,:ll_child_qty,:ls_itemcode,
      :ll_shipeditno,:ls_custcode,:ls_shipgubun,
		:ll_shipremainqty,:ls_pcgubun,:ls_kitgubun;

DO WHILE sqlpis.sqlcode <> 100 

	ll_count = ll_child_qty / ll_parent_qty 
	ll_child_qty = ll_shipqty * ll_count
	dw_hidden.insertrow(0)
	ll_row = dw_hidden.rowcount()
   dw_hidden.object.divisioncode[ll_row]   = dw_sheet.object.divisioncode[fl_row]
   dw_hidden.object.productgroup[ll_row]   = dw_sheet.object.productgroup[fl_row]
   dw_hidden.object.itemcode[ll_row]       = ls_itemcode
   dw_hidden.object.customeritemno[ll_row] = dw_sheet.object.customeritemno[fl_row]
   dw_hidden.object.itemname[ll_row]       = ls_itemcode
   dw_hidden.object.srno[ll_row]           = ls_srno
   dw_hidden.object.checksrno[ll_row]      = dw_sheet.object.checksrno[fl_row]
   dw_hidden.object.shipeditno[ll_row]     = dw_sheet.object.shipeditno[fl_row]
   dw_hidden.object.shipremainqty[ll_row]  = ll_shipremainqty
   dw_hidden.object.shipqty[ll_row]        = ll_child_qty
   dw_hidden.object.shipusage[ll_row]      = dw_sheet.object.shipusage[fl_row]
   dw_hidden.object.custcode[ll_row]       = dw_sheet.object.custcode[fl_row]
   dw_hidden.object.shipgubun[ll_row]      = dw_sheet.object.shipgubun[fl_row]
   dw_hidden.object.psrno[ll_row]          = dw_sheet.object.psrno[fl_row]
	dw_hidden.object.pcgubun[ll_row]        = ls_pcgubun
	dw_hidden.object.kitgubun[ll_row]       = ls_kitgubun
   fetch tsroder_cur 
	 into :ls_srno,:ll_child_qty,:ls_itemcode,
	      :ll_shipeditno,:ls_custcode,:ls_shipgubun,
			:ll_shipremainqty,:ls_pcgubun,:ls_kitgubun;
LOOP

close tsroder_cur;	 

end subroutine

public function boolean wf_update_tlotno (string fs_areacode, string fs_divisioncode, string fs_srno, string fs_itemcode, long fl_shipqty, string fs_shipgubun, string fs_shipusage);long ll_count,ll_stockqty
select count(*)
  into :ll_count
  from tlotno
 where tracedate    = :is_date
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and lotno        = 'XXXXXX'
	and itemcode     = :fs_itemcode
	and custcode     = :is_custcode
	and shipgubun    = :fs_shipgubun
	using sqlpis;
if f_piss_itemtype_check(fs_areacode,fs_divisioncode,fs_itemcode) = '2' then //단품이면
   ll_stockqty = fl_shipqty
else
	ll_stockqty = 0
end if	
if ll_count > 0 then
	Update tlotno
		set stockqty = stockqty + :ll_stockqty,
		    shipqty	 = shipqty + :fl_shipqty,
			 LastEmp	 = 'Y',
			 LastDate = GetDate()
	 where tracedate    = :is_date
		and areacode     = :fs_areacode
		and divisioncode = :fs_divisioncode
		and lotno        = 'XXXXXX'
		and itemcode     = :fs_itemcode
		and custcode     = :is_custcode
		and shipgubun    = :fs_shipgubun
		using sqlpis;
else
	INSERT INTO Tlotno
		       (traceDate,AreaCode,DivisionCode,lotno,CustCode,ItemCode,ShipGubun,   
		        ShipUsage,prdqty,stockqty,ShipQty,LastEmp,LastDate)  
      VALUES (:is_date,:fs_areacode,:fs_divisioncode,'XXXXXX',:is_custcode,:fs_itemcode,:fs_shipgubun,   
		        :fs_shipusage,0,:ll_stockqty,:fl_shipqty,'Y',getdate() )
		 USING SQLPIS;
end if
if sqlpis.sqlcode = 0 then
	return true
Else
	uo_status.st_message.text = "Tlotno insert시 오류가 발생하였습니다."
	Return false
end if
end function

public function boolean wf_update_tinv (string fs_areacode, string fs_divisioncode, string fs_itemcode, long fl_shipqty, string fs_shipgubun);long ll_count,ll_shipinvqty,ll_moveinvqty,ll_stockqty
select count(*) 
  into :ll_count
  from tinv
 where ItemCode	= :fs_itemcode
	and areacode   = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if is_shipgubun = 'X' then  //이체시
	ll_shipinvqty = 0
	ll_moveinvqty = fl_shipqty
else
	ll_shipinvqty = fl_shipqty
	ll_moveinvqty = 0
end if	
if (fs_shipgubun >= 'O' and fs_shipgubun <= 'W') or (fs_shipgubun = 'M')then //수출은 영업진행재고 처리안함
   	ll_shipinvqty  = 0
end if		

if f_piss_itemtype_check(fs_areacode,fs_divisioncode,fs_itemcode) = '2' then //단품이면
   ll_stockqty = fl_shipqty
else
	ll_stockqty = 0
end if	
	
//창고 입고시 tinv
if ll_count > 0 then
	Update tinv
		set Invqty	   = invqty	- :fl_shipqty + :ll_stockqty,
		    moveinvqty = moveinvqty + :ll_moveinvqty,
			 shipinvqty = shipinvqty + :ll_shipinvqty,
			 LastEmp		= 'Y',
			 LastDate	= GetDate()
	 where ItemCode	= :fs_itemcode
		and areacode   = :fs_areacode
		and divisioncode = :fs_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty,moveinvqty,shipinvqty,Lastemp, lastDate)
			Values(:fs_areacode,:fs_divisioncode,:fs_itemcode, &
					 (:fl_shipqty * -1) + :ll_stockqty,:ll_moveinvqty,:ll_shipinvqty,'Y', Getdate())
	using sqlpis;
end if;
if sqlpis.sqlcode = 0 then
	return true
Else
	uo_status.st_message.text = "Tinv insert시 오류가 발생하였습니다."
	Return false
end if	

end function

public function boolean wf_update_tshipsheet ();string ls_shipgubun,ls_custcode,ls_year,ls_month,ls_seq,ls_srno,ls_shipsheetno
string ls_compare_shipgubun,ls_compare_custcode,ls_max_shipsheetno
string ls_pcgubun,ls_kitgubun,ls_org_srno
long i,ll_count,j,ll_shipqty,ll_seqno
boolean lb_commit
ls_compare_shipgubun = ' '
ls_compare_custcode = ' '
j = 0
ls_year = mid(is_date,4,1) 
ls_month = mid(is_date,6,2) 
lb_commit = true
ll_count = dw_hidden.rowcount()
for i = 1 to ll_count step 1
	ls_kitgubun = dw_hidden.object.kitgubun[i]
	ls_pcgubun  = dw_hidden.object.pcgubun[i]
	
	j = j + 1
	ls_custcode = dw_hidden.object.custcode[i]
	ls_shipgubun = dw_hidden.object.shipgubun[i]
	ls_srno = dw_hidden.object.srno[i]
	ll_shipqty = dw_hidden.object.shipqty[i]	
	if j > 10 or ls_custcode <> ls_compare_custcode or ls_shipgubun <> ls_compare_shipgubun then
		ls_compare_custcode = ls_custcode
		ls_compare_shipgubun = ls_shipgubun
		j = 1
		select max(shipsheetno)
		  into :ls_max_shipsheetno
		  from tshipsheet a,tsrorder b
		 where a.areacode = :is_areacode
			and a.divisioncode = :is_divisioncode
			and a.shipdate like substring(:is_date,1,7) + '%'
			and a.areacode = b.areacode
			and a.divisioncode = b.divisioncode
			and substring(a.shipsheetno,3,1) = :ls_shipgubun
			and a.srno = b.srno
		  using sqlpis;
		if ls_max_shipsheetno = '' or isnull(ls_max_shipsheetno) then
			ls_seq = '0000'
		else
			ls_seq = right(ls_max_shipsheetno,4) 
		end if
		f_pisc_get_string_add(ls_seq,ls_seq)
		ls_shipsheetno = is_areacode + is_divisioncode + ls_shipgubun + ls_year + ls_month + ls_seq
		dw_update_tshipsheet.insertrow(1)
		dw_update_tshipsheet.object.shipsheetno[1] = ls_shipsheetno
		dw_update_tshipsheet.object.srno[1]        = ls_srno
		dw_update_tshipsheet.object.truckorder[1]  = 0
		dw_update_tshipsheet.object.truckno[1]  = 'zzzz'
		dw_update_tshipsheet.object.custcode[1]  = ls_custcode
		dw_update_tshipsheet.object.shipqty[1]  = ll_shipqty
		dw_update_tshipsheet.object.divisioncode[1]  = is_divisioncode
	end if
	if ls_kitgubun = 'N' or ls_pcgubun = 'C' then
		if not wf_update_tshipkbhis(is_date,is_areacode,is_divisioncode,ls_srno,ls_shipsheetno,ll_shipqty) then
			uo_status.st_message.text = "Tshipkbhis insert시 오류가 발생하였습니다."
			lb_commit = false
			exit
		end if
	end if			
	INSERT INTO TSHIPSHEET  
				 (ShipDate,AreaCode,DivisionCode,SRNo,TruckOrder,ShipSheetNo,
				  TruckNo,CustCode,PrintCount,shipqty,SheetPrintDate,
				  ConfirmFlag,ConfirmDate,SaleConfirmFlag,SaleConfirmDate,
				  LastEmp,LastDate)  
		VALUES (:is_date,:is_areacode,:is_divisioncode,:ls_srno,0,:ls_shipsheetno,
				  'zzzz',:is_custcode,1,:ll_shipqty,:is_date,   
				  'N',null,'N',null,
				  'Y',getdate() )
   using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "Tshipsheet insert시 오류가 발생하였습니다."
		lb_commit = false
		exit
	end if
	if right(ls_srno,3) = 'P00' or right(ls_srno,3) = 'C00' then
		select top 1 substring(:ls_srno,1,len(:ls_srno) - 3) 
		  into :ls_org_srno
		  from sysusers
		  using sqlpis;
	else
		ls_org_srno = ls_srno
	end if
	if ls_shipgubun <> 'M' then //이체는 인터페이스안함
		select max(seqno)
		  into :ll_seqno
		  from tshipsheet_interface
		 where shipdate = :is_date
			and areacode = :is_areacode
			and divisioncode = :is_divisioncode
			and srno         = :ls_org_srno
			and misflag      = 'A'
		using sqlpis;
		if isnull(ll_seqno) then
			ll_seqno = 0 
		end if
		ll_seqno = ll_seqno + 1
		if ls_kitgubun = 'Y' then
			ls_kitgubun = ls_pcgubun
		else
			ls_kitgubun = ''
		end if
		insert into tshipsheet_interface
					  (ShipDate,AreaCode,DivisionCode,SRNo,SeqNo,
						ShipSheetNo,KITGubun,ShipQty,
						MISflag,InterfaceFlag,LastEmp,LastDate)
			 values (:is_date,:is_areacode,:is_divisioncode,:ls_org_srno,:ll_seqno,
						:ls_shipsheetno,:ls_kitgubun,:ll_shipqty,
						'A','Y',:g_s_empno,getdate())
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = "Tshipsheet_inetrface insert시 오류가 발생하였습니다."
			lb_commit = false
			exit
		end if
	end if
	
next	
return lb_commit
end function

public function boolean wf_save_danpum_inv101 (integer a_row);int i 
long ll_loadqty
string ls_itemcode,ls_itemtype,ls_divisioncode,ls_danpum_check

for i = 1 to a_row 
	ls_divisioncode = dw_hidden.object.divisioncode[i]
	ls_itemcode     = trim(dw_hidden.object.itemcode[i])
	ll_loadqty      = dw_hidden.object.shipqty[i]
	ls_itemtype     = f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
	if ( ls_itemtype = '2' or ls_itemtype = '4' )  then //단품,상품이면
		ls_danpum_check = f_piss_danpum_check(is_areacode,ls_divisioncode,ls_itemcode,ll_loadqty) 
		if ls_danpum_check = 'S' then
			uo_status.st_message.text = "공장 : " + is_divisioncode + " 단품  : "  + ls_itemcode + &
												 " 재고가 출하 수량보다 작습니다. KDAC 시스템에서 재고수량을 조정후 재 작업하십시오" 
			return false
		elseif ls_danpum_check = 'F' then
			uo_status.st_message.text = "현재 KDAC 생산 시스템에 접근불가 상태입니다"
			return false
		end if
	end if
next
for i = 1 to a_row 
	ls_divisioncode = dw_hidden.object.divisioncode[i]
	ls_itemcode     = trim(dw_hidden.object.itemcode[i])
	ls_itemtype     = f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
	ll_loadqty      = dw_hidden.object.shipqty[i]
	if ( ls_itemtype = '2' or ls_itemtype = '4' )  then //단품,상품이면
		update pbinv.inv101
			set iperp1 = iperp1 + : ll_loadqty
		where comltd = :g_s_company     and xplant = :is_areacode and
				div    = :ls_divisioncode and itno   = :ls_itemcode using sqlca ;
	end if
next
return true
end function

public function boolean wf_errchk (string fs_column, long fl_row);dw_sheet.accepttext()
long ll_shipqty,ll_shipremainqty,ll_invqty
string ls_srno,ls_psrno,ls_itemclass,ls_itembuysource
string ls_itemcode
ll_shipqty       	= dw_sheet.object.shipqty[fl_row]
ls_srno          	= dw_sheet.object.srno[fl_row]
ll_shipremainqty 	= dw_sheet.object.shipremainqty[fl_row]
ll_invqty			= dw_sheet.object.todayinv[fl_row]
ls_psrno         	= dw_sheet.object.psrno[fl_row]
ls_itemcode      	= dw_sheet.object.itemcode[fl_row]
CHOOSE CASE fs_column
	CASE 'shipqty'
		  if ll_shipqty > ll_shipremainqty then
			  messagebox("확인","출하수량이 출하잔량 보다 큽니다.")
			  dw_sheet.object.shipqty[fl_row] = 0
			  dw_sheet.setfocus()
			  wf_hidden_check(ls_psrno,0)
			  dw_sheet.setcolumn('shipqty')
			  return false
		  end if
		  if ll_shipqty > ll_invqty and f_piss_itemtype_check(is_Areacode,is_divisioncode,ls_itemcode) <> '2' then
			  messagebox("확인","출하수량이 재고수량보다 큽니다.")
			  dw_sheet.object.shipqty[fl_row] = 0
			  dw_sheet.setfocus()
			  wf_hidden_check(ls_psrno,0)
			  dw_sheet.setcolumn('shipqty')
			  return false
		  end if
		  select top 1 itemclass,itembuysource
		    into :ls_itemclass,:ls_itembuysource
			 from tmstmodel
			where areacode = :is_areacode
			  and divisioncode = :is_divisioncode
			  and itemcode     = :ls_itemcode
		   using sqlpis;
		  if ls_itemclass = '' or isnull(ls_itemclass) then
			  ls_itemclass = ' '
		  end if
		  if ls_itembuysource = '' or isnull(ls_itembuysource) then
			  ls_itembuysource = ' '
		  end if
        if ls_itemclass = '10' and (ls_itembuysource = '05' or ls_itembuysource = '06') then
			  messagebox("확인","출하할 수 없는 품번입니다.")
			  dw_sheet.object.shipqty[fl_row] = 0
			  dw_sheet.setfocus()
			  wf_hidden_check(ls_psrno,0)
			  dw_sheet.setcolumn('shipqty')
			  return false
		  end if
		  if ll_shipqty < 0 then
			  messagebox("확인","출하수량이 0 보다 작습니다.")
			  dw_sheet.object.shipqty[fl_row] = 0
			  dw_sheet.setfocus()
			  wf_hidden_check(ls_psrno,0)
			  dw_sheet.setcolumn('shipqty')
			  return false
		  end if

END CHOOSE
if ll_shipqty = 0 then
   wf_hidden_check(ls_psrno,0)
	return true
end if
wf_insert_hidden(fl_row)
return true
end function

public function boolean wf_update_tsrorder (string fs_areacode, string fs_divisioncode, string fs_srno, long fl_shipqty, long fl_shipremainqty, string fs_shipgubun);string ls_shipendgubun
//창고 출하시 tsrorder
if fs_shipgubun = 'M' then //이체시
   ls_shipendgubun = 'Y'
elseif fl_shipremainqty = fl_shipqty then
		ls_shipendgubun = 'Y'
else
	ls_shipendgubun = 'N'
end if	
update tsrorder
   set shipremainqty = shipremainqty - :fl_shipqty,
	    shipendgubun  = :ls_shipendgubun,
		 shipdate      = convert(char(10),getdate(),102),
		 lastdate      = getdate(),
		 lastemp       = 'Y'
where areacode = :fs_areacode
  and divisioncode = :fs_divisioncode
  and srno = :fs_srno
  using sqlpis;
if sqlpis.sqlcode = 0 then
	return true
Else
	uo_status.st_message.text = "Tsrorder update시 오류가 발생하였습니다."
	Return false
end if
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
	and	 	itemcode = :ls_itemcode and partid = :ls_partid and tracedate	=	:is_date 
using sqlpis ;

if isnull(ln_rowcount) or ln_rowcount = 0 then
		insert into tseqtrans
		values	( :is_date,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,0,0,:fl_shipqty,:g_s_empno,getdate())
		using	sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
elseif ln_rowcount = 1 then
		update	tseqtrans
			set	shipqty	=	shipqty + :fl_shipqty
		where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
		and 	itemcode = :ls_itemcode and partid			= 	:ls_partid and tracedate = :is_date
		using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
end if

return true
end function

public function boolean wf_save ();dw_sheet.accepttext()
long ll_shipqty,ll_count,i,ll_shipremainqty
string ls_divisioncode,ls_srno,ls_applyfrom,ls_shipgubun,ls_itemcode,ls_shipusage,ls_kitgubun,ls_pcgubun
string ls_shipsheetno,ls_custcode,ls_custitemcode
boolean lb_commit
lb_commit = true
setpointer(hourglass!)

ll_count = dw_hidden.rowcount()

for i = 1 to ll_count step 1
	ll_shipremainqty   = dw_hidden.object.shipremainqty[i]
	ll_shipqty         = dw_hidden.object.shipqty[i]
	ls_srno            = dw_hidden.object.srno[i]
	ls_applyfrom       = dw_hidden.object.applyfrom[i]
	ls_itemcode        = dw_hidden.object.itemcode[i]
	ls_shipgubun       = dw_hidden.object.shipgubun[i]
	ls_shipusage       = dw_hidden.object.shipusage[i]
	ls_pcgubun         = dw_hidden.object.pcgubun[i]
	ls_kitgubun        = dw_hidden.object.kitgubun[i]
	ls_custitemcode    = dw_hidden.object.customeritemno[i]
	ls_custcode        = dw_hidden.object.custcode[i]
	if (ls_kitgubun = 'N')  or (ls_pcgubun = 'C') then
		if wf_update_tinv(is_areacode,is_divisioncode,ls_itemcode,ll_shipqty,ls_shipgubun) then
		else
			lb_commit = false
			exit
		end if
		if wf_update_tlotno(is_areacode,is_divisioncode,ls_srno,ls_itemcode,ll_shipqty,ls_shipgubun,ls_shipusage) then
		else
			lb_commit = false
			exit
		end if
		if ls_shipgubun = 'M' then //이체시
			if wf_update_tshipinv(is_areacode,is_divisioncode,ls_srno,ls_itemcode,ll_shipqty,ls_shipgubun,ls_custcode) then
			else
				lb_commit = false
				exit
			end if
		end if
	end if
	if wf_update_tsrorder(is_areacode,is_divisioncode,ls_srno,ll_shipqty,ll_shipremainqty,ls_shipgubun) then
	else
		lb_commit = false
		exit
	end if
	if ls_shipgubun = 'D' OR ls_shipgubun = 'G' OR ls_shipgubun = 'H' OR ls_shipgubun = 'K' OR &
	   ls_shipgubun = 'R' OR ls_shipgubun = 'U' OR ls_shipgubun = 'V' OR ls_shipgubun = 'W' THEN // A/S,KD 일경우만..
		if not wf_update_tseqinv(ls_custcode,ls_custitemcode,ll_shipqty) then
			lb_commit = false
			exit
		end if
	end if
next
if lb_commit = true then
	if wf_update_tshipsheet() = true then  // AS400 BALANCE TABLE 참조 추가
	   if is_divisioncode <> 'Y' then 
			if wf_save_danpum_inv101(ll_count) = false then
				lb_commit = false
			end if
		end if
	else
		lb_commit = false
	end if
end if	
setpointer(arrow!)
return lb_commit
end function

on w_piss340u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.em_1=create em_1
this.gb_1=create gb_1
this.dw_print=create dw_print
this.dw_hidden1=create dw_hidden1
this.dw_sheet=create dw_sheet
this.dw_update_tshipsheet=create dw_update_tshipsheet
this.dw_3=create dw_3
this.em_2=create em_2
this.st_2=create st_2
this.st_6=create st_6
this.dw_hidden=create dw_hidden
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_scustgubun
this.Control[iCurrent+4]=this.uo_custcode
this.Control[iCurrent+5]=this.uo_shipoemgubun
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_print
this.Control[iCurrent+12]=this.dw_hidden1
this.Control[iCurrent+13]=this.dw_sheet
this.Control[iCurrent+14]=this.dw_update_tshipsheet
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.em_2
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.dw_hidden
this.Control[iCurrent+20]=this.pb_excel
end on

on w_piss340u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.uo_shipoemgubun)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.gb_1)
destroy(this.dw_print)
destroy(this.dw_hidden1)
destroy(this.dw_sheet)
destroy(this.dw_update_tshipsheet)
destroy(this.dw_3)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_6)
destroy(this.dw_hidden)
destroy(this.pb_excel)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;long ll_count,ll_toshipeditno
il_shipeditno = long(em_1.text)
ll_toshipeditno = long(em_2.text)
ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_custcode,is_shipgubun,il_shipeditno,ll_toshipeditno)
if ll_count = 0 then 
	pb_Excel.visible = false
	pb_Excel.enabled = false
	messagebox("확인","조회된 자료가 없읍니다.")
	return
end if	
dw_hidden.reset()
dw_sheet.setfocus()
dw_sheet.setcolumn('shipqty')
pb_Excel.visible = true
pb_Excel.enabled = true

end event

event ue_save;int net
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
is_date = ls_close_date  
sqlpis.autocommit = false
if wf_save() then
   commit using sqlpis;
   sqlpis.autocommit = true
   messagebox("확인","출하가 완료 되었읍니다.")
else
   rollback using sqlpis;
   sqlpis.autocommit = true	
   messagebox("확인","출하시 오류가 발생했습니다.")	
end if
postevent('ue_retrieve')
end event

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
dw_hidden.settransobject(sqlpis)
dw_hidden1.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
dw_sheet.setfocus()

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname
string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
ib_open = true


end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
dw_hidden.settransobject(sqlpis)
dw_hidden1.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss340u
end type

type uo_area from u_pisc_select_area within w_piss340u
integer x = 233
integer y = 92
integer height = 76
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
dw_hidden.settransobject(sqlpis)
dw_hidden1.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
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

type uo_division from u_pisc_select_division within w_piss340u
integer x = 878
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
dw_hidden.settransobject(sqlpis)
dw_hidden1.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_update_tshipsheet.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type uo_scustgubun from u_pisc_select_code within w_piss340u
event destroy ( )
integer x = 1815
integer y = 100
integer width = 709
integer taborder = 70
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;string ls_custgubun,ls_custname
datawindow ldw_custcode
ldw_custcode = uo_custcode.dw_1
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(ldw_custcode,is_custgubun,'%',false,is_custcode,ls_custname)
dw_sheet.reset()
end event

type uo_custcode from u_piss_select_custcode within w_piss340u
event destroy ( )
integer x = 2597
integer y = 104
integer taborder = 90
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

event constructor;call super::constructor;is_custcode = is_uo_custcode
end event

type uo_shipoemgubun from u_pisc_select_code within w_piss340u
event destroy ( )
integer x = 398
integer y = 188
integer taborder = 100
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;call super::ue_select;is_shipgubun = is_uo_codeid
if is_shipgubun = 'X' then //이체
   dw_sheet.dataobject = 'd_piss340u_02'
else
   dw_sheet.dataobject = 'd_piss340u_01'
end if	
dw_sheet.reset()
dw_sheet.settransobject(sqlpis)
end event

type st_5 from statictext within w_piss340u
integer x = 110
integer y = 196
integer width = 270
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
string text = "출하구분"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss340u
integer x = 1477
integer y = 108
integer width = 320
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

type st_3 from statictext within w_piss340u
integer x = 2592
integer y = 196
integer width = 265
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
string text = "출하편수"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss340u
integer x = 2862
integer y = 184
integer width = 160
integer height = 80
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#0"
end type

event modified;il_shipeditno = long(em_1.text)
dw_sheet.reset()
end event

event losefocus;il_shipeditno = long(em_1.text)
end event

type gb_1 from groupbox within w_piss340u
integer x = 23
integer y = 28
integer width = 4096
integer height = 272
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

type dw_print from datawindow within w_piss340u
boolean visible = false
integer x = 1266
integer y = 652
integer width = 1120
integer height = 588
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss150i_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hidden1 from datawindow within w_piss340u
boolean visible = false
integer x = 151
integer y = 832
integer width = 2747
integer height = 432
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss150i_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sheet from u_vi_std_datawindow within w_piss340u
integer x = 18
integer y = 320
integer width = 3991
integer height = 1568
integer taborder = 10
string dataobject = "d_piss340u_01"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;this.accepttext()
if wf_errchk(dwo.name,row) = false then
   return 1
end if	 
end event

event itemerror;call super::itemerror;return 1
end event

type dw_update_tshipsheet from datawindow within w_piss340u
boolean visible = false
integer x = 2094
integer y = 1200
integer width = 1152
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_piss340u
boolean visible = false
integer x = 2117
integer y = 364
integer width = 411
integer height = 432
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_13"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_piss340u
integer x = 3113
integer y = 184
integer width = 160
integer height = 80
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "99"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#0"
end type

event losefocus;il_shipeditno = long(em_1.text)
end event

event modified;il_shipeditno = long(em_1.text)
dw_sheet.reset()
end event

type st_2 from statictext within w_piss340u
integer x = 3022
integer y = 196
integer width = 87
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
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_piss340u
integer x = 1120
integer y = 200
integer width = 1486
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "(전체선택시 이체는 나타나지 않음)"
boolean focusrectangle = false
end type

type dw_hidden from datawindow within w_piss340u
boolean visible = false
integer y = 612
integer width = 2720
integer height = 1160
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss340u_03"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_piss340u
boolean visible = false
integer x = 3831
integer y = 72
integer width = 155
integer height = 132
integer taborder = 40
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

