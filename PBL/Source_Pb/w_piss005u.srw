$PBExportHeader$w_piss005u.srw
$PBExportComments$소급작업
forward
global type w_piss005u from w_ipis_sheet01
end type
type gb_currentmonth from groupbox within w_piss005u
end type
type uo_area from u_pisc_select_area within w_piss005u
end type
type uo_division from u_pisc_select_division within w_piss005u
end type
type uo_date from u_pisc_date_applydate within w_piss005u
end type
type tab_1 from tab within w_piss005u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_tabpage1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_tabpage1 dw_tabpage1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tabpage2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tabpage2 dw_tabpage2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_tabpage3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_tabpage3 dw_tabpage3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_tabpage4 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_tabpage4 dw_tabpage4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_tabpage5 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_tabpage5 dw_tabpage5
end type
type tab_1 from tab within w_piss005u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type gb_1 from groupbox within w_piss005u
end type
type uo_item from u_pisc_select_item_model_kdac within w_piss005u
end type
type st_baseqty from statictext within w_piss005u
end type
type sle_baseqty from singlelineedit within w_piss005u
end type
type st_inqty from statictext within w_piss005u
end type
type sle_inqty from singlelineedit within w_piss005u
end type
type st_outqty from statictext within w_piss005u
end type
type sle_outqty from singlelineedit within w_piss005u
end type
type st_2 from statictext within w_piss005u
end type
type sle_invqty from singlelineedit within w_piss005u
end type
end forward

global type w_piss005u from w_ipis_sheet01
integer width = 4622
integer height = 2692
string title = "출고전표취소"
boolean minbox = true
gb_currentmonth gb_currentmonth
uo_area uo_area
uo_division uo_division
uo_date uo_date
tab_1 tab_1
gb_1 gb_1
uo_item uo_item
st_baseqty st_baseqty
sle_baseqty sle_baseqty
st_inqty st_inqty
sle_inqty sle_inqty
st_outqty st_outqty
sle_outqty sle_outqty
st_2 st_2
sle_invqty sle_invqty
end type
global w_piss005u w_piss005u

type variables
boolean ib_open, ib_change = false
string is_change = 'NO', is_applydate,is_areacode,is_divisioncode
string is_itemcode,is_shipdate,is_beforemonth,is_currentmonth
integer ii_window_border = 10,il_qty,ii_tabindex = 1



end variables

forward prototypes
public subroutine wf_qty_find (string fs_areacode, string fs_divisioncode, string fs_itemcode, string fs_currentmonth)
public function boolean wf_update_tshipetc_interface (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, string fs_inputflag, integer fn_seqno)
public function boolean wf_update_tshipsheet (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, integer fn_truckorder)
public function boolean wf_update_tstock_interface (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, string fs_kbreleasedate, integer fn_kbreleaseseq, integer fn_seqno)
public function boolean wf_update_tstockcancel_interface (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, string fs_kbreleasedate, integer fn_kbreleaseseq, integer fn_seqno)
public function boolean wf_update_tlotno (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_inputflag)
public function boolean wf_save (ref datawindow f_dw)
end prototypes

public subroutine wf_qty_find (string fs_areacode, string fs_divisioncode, string fs_itemcode, string fs_currentmonth);int li_baseqty,li_inqty,li_outqty,li_invqty

sle_baseqty.text = ''
sle_inqty.text		= ''
sle_outqty.text	= ''
sle_invqty.text	= ''

select isnull(invqty,0)+isnull(repairqty,0)+isnull(defectqty,0)+isnull(moveinvqty,0) into :li_baseqty from tinvhis
	where areacode 	= :fs_areacode and
			divisioncode	= :fs_divisioncode and
			itemcode		= :fs_itemcode and
			applymonth 	= :fs_currentmonth
using sqlpis ;

if sqlpis.sqlcode <> 0 then 	li_baseqty = 0

select isnull(invqty,0)+isnull(repairqty,0)+isnull(defectqty,0)+isnull(moveinvqty,0) into :li_invqty from tinv
	where areacode 	= :fs_areacode and
			divisioncode	= :fs_divisioncode and
			itemcode		= :fs_itemcode 
using sqlpis ;

if sqlpis.sqlcode <> 0 then 	li_invqty = 0

select isnull(sum(stockqty),0),isnull(sum(shipqty),0) into :li_inqty,:li_outqty from tlotno
	where areacode 	= :fs_areacode and
			divisioncode	= :fs_divisioncode and
			itemcode		= :fs_itemcode and
			tracedate		like :fs_currentmonth + '%'
using sqlpis ;

if sqlpis.sqlcode <> 0 then 	
	li_inqty = 0
	li_outqty = 0
end if

sle_baseqty.text = string(li_baseqty,"#,###,###,###")
sle_inqty.text		= string(li_inqty,"#,###,###,###")
sle_outqty.text	= string(li_outqty,"#,###,###,###")
sle_invqty.text	= string(li_invqty,"#,###,###,###")


end subroutine

public function boolean wf_update_tshipetc_interface (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, string fs_inputflag, integer fn_seqno);return true
end function

public function boolean wf_update_tshipsheet (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, integer fn_truckorder);update	tshipsheet
	set			shipdate	=	:fs_date
where		shipdate		=	:fs_beforedate	and	areacode		=	:is_areacode		and
			divisioncode	=	:is_divisioncode	and	srno			=	:fs_slipno			and	
			shipsheetno	=	:fs_etc1			and	truckorder	=	:fn_truckorder
using	sqlpis	;	
if	sqlpis.sqlcode	<>	0	then
	messagebox("확인","출하일자 수정시 Error 발생")
	return false
end	if

return true
end function

public function boolean wf_update_tstock_interface (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, string fs_kbreleasedate, integer fn_kbreleaseseq, integer fn_seqno);update	tstock_interface
	set		stockdate			=	:fs_date
where		kbno				=	:fs_slipno				and	kbreleasedate	=	:fs_kbreleasedate	and
			kbreleaseseq	=	:fn_kbreleaseseq	and	seqno				=	:fn_seqno				and	
			misflag			=	:fs_etc1
using		sqlpis	;
if	sqlpis.sqlcode	<>	0	then
	messagebox("확인","입고일자 수정시 Error 발생")
	return false
end if
return true
end function

public function boolean wf_update_tstockcancel_interface (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_slipno, string fs_etc1, string fs_kbreleasedate, integer fn_kbreleaseseq, integer fn_seqno);update	tstockcancel_interface
	set		stockdate			=	:fs_date
where		kbno				=	:fs_slipno				and	kbreleasedate	=	:fs_kbreleasedate	and
			kbreleaseseq	=	:fn_kbreleaseseq	and	seqno				=	:fn_seqno				and	
			misflag			=	:fs_etc1
using		sqlpis	;
if	sqlpis.sqlcode	<>	0	then
	messagebox("확인","입고일자 수정시 Error 발생")
	return false
end if
return true
end function

public function boolean wf_update_tlotno (string fs_beforedate, string fs_date, string fs_itemcode, integer fn_slipqty, string fs_inputflag);int ln_count,ln_shipqty,ln_stockqty
string	ls_lotno,ls_custcode,ls_shipgubun

if	ii_tabindex	=	1	then
	ln_shipqty		=	fn_slipqty
	ln_stockqty		=	0
elseif	ii_tabindex	=	2	then
	ln_stockqty		=	fn_slipqty
	ln_shipqty		=	0
elseif	ii_tabindex	=	3	then	
	ln_stockqty		=	fn_slipqty	*	(-1)
	ln_shipqty		=	0
elseif	ii_tabindex	=	4	then	
	if	fs_inputflag	=	"1"	then
		ln_shipqty	=	fn_slipqty
	elseif fs_inputflag	=	"2"	then
		ln_shipqty	=	fn_slipqty	*	(-1)
	end if
	ln_stockqty		=	0
else

end if
// 수정전 일자 update

select top 1	lotno,custcode,shipgubun	into	:ls_lotno,:ls_custcode,:ls_shipgubun		from	tlotno
	where		traceDate     	= :fs_beforedate
		and 	areacode      = :is_areacode
		and 	DivisionCode	= :is_divisioncode
		and 	ItemCode	   	= :fs_itemcode
using sqlpis;	
if sqlpis.sqlcode <> 0 then
		messagebox("확인","Tlotno Table 오류")
   	return false
end if

Update tlotno
	   Set 	shipqty			= shipqty 		- :ln_shipqty,
		    	stockqty  			= stockqty 	- :ln_stockqty,
		    	lastemp   			= 'Y',
			lastdate  			= getdate()
	 Where traceDate     	= :fs_beforedate
		and areacode      	= :is_areacode
		and DivisionCode	= :is_divisioncode
		and Lotno		   		= :ls_lotno
		and ItemCode	   	= :fs_itemcode
		and custcode      	= :ls_custcode
		and shipgubun     	= :ls_shipgubun
 	 using sqlpis;
if Sqlpis.sqlcode <> 0 then
	messagebox("확인","Tlotno Table 오류")
   	return false
end if	  

// 수정후 일자 update

select count(LotNo) Into :ln_count	From tlotno
	Where 	traceDate     	= :fs_date
		and 	areacode      = :is_areacode
		and 	DivisionCode	= :is_divisioncode
		and 	Lotno		   	= 'XXXXXX'
		and 	ItemCode	   	= :fs_itemcode
		and 	custcode      	= 'XXXXXX'
		and 	shipgubun     = 'X'
using sqlpis;
if isnull(ln_count) then
	ln_count = 0
end if	

//출하일자의 같은 Lotno 의 테이타가 있다면 Update
if ln_count > 0 Then
	Update tlotno
	   Set 	shipqty			= shipqty 		+ :ln_shipqty,
		    	stockqty  			= stockqty 	+ :ln_stockqty,
		    	lastemp   			= 'Y',
			lastdate  			= getdate()
	 Where traceDate     	= :fs_date
		and areacode      	= :is_areacode
		and DivisionCode	= :is_divisioncode
		and Lotno		   		= 'XXXXXX'
		and ItemCode	   	= :fs_itemcode
		and custcode      	= 'XXXXXX'
		and shipgubun     	= 'X'
 	 using sqlpis;
Else
	Insert into tlotno 
	           	(traceDate,AreaCode,DivisionCode,Lotno,
	            	Itemcode,custcode,shipgubun,
	            	shipusage,prdqty,shipQty,stockqty,Lastemp, lastdate)
     	Values 	(:fs_date,:is_areacode,:is_divisioncode,'XXXXXX',
			   	:fs_itemcode,'XXXXXX','X','X',0,:ln_shipqty,:ln_stockqty,'Y', GetDate())
	using sqlpis;
end if
if Sqlpis.sqlcode <> 0 then
	messagebox("확인","Tlotno Table 오류")
   	return false
end if
return true
end function

public function boolean wf_save (ref datawindow f_dw);string ls_date,ls_beforedate,ls_itemcode,ls_areacode,ls_divisioncode,ls_slipno,ls_etc1,ls_etc2
string ls_itemtype,ls_checkdate,ls_applymonth,ls_kbreleasedate,ls_inputflag = ''
int	ln_slipqty,i,ln_rowcount,ln_invqty,ln_baseqty,ln_checkqty,ln_truckorder,ln_kbreleaseseq,ln_seqno

ls_itemcode 		= 	f_dw.getitemstring(1,2,primary!,false)		
if 	ls_itemcode <> is_itemcode then
	messagebox("확인","입력하신 품번과 조회된 품번이 틀립니다.")
	return false
end if
wf_qty_find(is_areacode,is_divisioncode,is_itemcode,is_currentmonth)
ln_invqty	=	integer(sle_invqty.text)
ln_baseqty	=	integer(sle_baseqty.text)
ln_rowcount = 	f_dw.rowcount()
for i = 1 to ln_rowcount
	ls_beforedate	= 	f_dw.getitemstring(i,1,primary!,true)	//	수정전 일자
	ls_date 			= 	f_dw.getitemstring(i,1,primary!,false)	//	수정후	일자
	ls_itemcode 	= 	f_dw.getitemstring(i,2,primary!,false)		
	ln_slipqty 		= 	f_dw.getitemnumber(i,3,primary!,false)		
	ls_slipno 		= 	f_dw.getitemstring(i,4,primary!,false)	
	ls_etc1 			= 	f_dw.getitemstring(i,5,primary!,false)	
	ls_etc2 			= 	f_dw.getitemstring(i,6,primary!,false)		
	ls_itemtype		= 	f_dw.getitemstring(i,"itemtype",primary!,false)	
	ls_checkdate	=	trim(f_dateedit(ls_date))					//	20040101	Format 으로 수정후 일자 Return
	if	trim(ls_checkdate)	=	''	then	 
		messagebox("확인",string(i) + " 열의 수정일자를 확인바랍니다")
		return false
	end if
	if	ls_checkdate		>	g_s_date		then	 
		messagebox("확인",string(i) + " 열의 수정일자가 오늘 날짜보다 크면 입력이 안됩니다")
		return false
	end if
	if	abs(integer(mid(ls_checkdate,1,6))	-	integer(mid(is_currentmonth,1,4)	+	mid(is_currentmonth,6,2)))	>	1	then	 
		messagebox("확인",string(i) + " 열의 수정일자는 기준일자 전후 1개월 까지만 유효합니다")
		return false
	end if
	
	ls_date		=	string(ls_checkdate,"@@@@.@@.@@")
	
	if	mid(ls_beforedate,1,7)	=	mid(ls_date,1,7)	then	continue
	
	CHOOSE CASE ii_tabindex

		CASE	1	// 출하
			if	mid(ls_beforedate,1,7)	>	mid(ls_date,1,7)	then
				ls_applymonth	=	mid(ls_beforedate,1,7)
				select	isnull(invqty,0)	into	:ln_checkqty		from tinvhis
					where applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
							divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
				using	sqlpis	;
				if	ln_checkqty	<	ln_slipqty	then
					messagebox("확인",string(i) + " 열의 기준월 기초수량이 수정월 출하수량보다 작습니다")
					return false
				else	
					ln_checkqty	=	ln_slipqty
				end if
			else
				ls_applymonth	=	mid(ls_date,1,7)
				ln_checkqty		=	ln_slipqty	*	(-1)
			end if
			update	tinvhis
				set		invqty		=	invqty	-	:ln_checkqty	
			where		applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
						divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
			using	sqlpis ;
			if	sqlpis.sqlcode	<>	0	then
				return	false
			end if
			ln_truckorder	=	f_dw.getitemnumber(i,7,primary!,false)
			wf_update_tshipsheet(ls_beforedate,ls_date,ls_itemcode,ln_slipqty,ls_slipno,ls_etc1,ln_truckorder)

		CASE 	2	//	입고
			if	mid(ls_beforedate,1,7)	>	mid(ls_date,1,7)	then
				ls_applymonth	=	mid(ls_beforedate,1,7)
				ln_checkqty		=	ln_slipqty	*	(-1)
			else
				ls_applymonth	=	mid(ls_date,1,7)
				select	isnull(invqty,0)	into	:ln_checkqty	from tinvhis
					where applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
							divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
				using	sqlpis	;
				if	ln_checkqty	<	ln_slipqty	then
					messagebox("확인",string(i) + " 열의 기준월 기초수량이 수정월 입고수량보다 작습니다")
					return false
				else	
					ln_checkqty	=	ln_slipqty
				end if
			end if
			update	tinvhis
				set		invqty		=	invqty	-	:ln_checkqty	
			where		applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
						divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
			using	sqlpis ;
			if	sqlpis.sqlcode	<>	0	then
				return	false
			end if
			ls_kbreleasedate	=	f_dw.getitemstring(i,"tstock_interface_kbreleasedate")
			ln_kbreleaseseq	=	f_dw.getitemnumber(i,"tstock_interface_kbreleaseseq")
			ln_seqno				=	f_dw.getitemnumber(i,"tstock_interface_seqno")			
			wf_update_tstock_interface(ls_beforedate,ls_date,ls_itemcode,ln_slipqty,ls_slipno,ls_etc1,ls_kbreleasedate,ln_kbreleaseseq,ln_seqno)

		CASE 	3	//	입고취소
			if	mid(ls_beforedate,1,7)	>	mid(ls_date,1,7)	then
				ls_applymonth	=	mid(ls_beforedate,1,7)
				select	isnull(invqty,0)	into	:ln_checkqty	from tinvhis
					where applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
							divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
				using	sqlpis	;
				if	ln_checkqty	<	ln_slipqty	then
					messagebox("확인",string(i) + " 열의 기준월 기초수량이 수정월 입고 취소 수량보다 작습니다")
					return false
				else	
					ln_checkqty	=	ln_slipqty
				end if
			else
				ls_applymonth	=	mid(ls_date,1,7)
				ln_checkqty		=	ln_slipqty	* (-1)
			end if
			update	tinvhis
				set		invqty		=	invqty	-	:ln_checkqty	
			where		applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
						divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
			using	sqlpis ;
			if	sqlpis.sqlcode	<>	0	then
				return	false
			end if
			ls_kbreleasedate	=	f_dw.getitemstring(i,"tstock_interface_kbreleasedate")
			ln_kbreleaseseq		=	f_dw.getitemnumber(i,"tstock_interface_kbreleaseseq")
			ln_seqno				=	f_dw.getitemnumber(i,"tstock_interface_seqno")	
			if	ls_etc1			=	'A'	then
				wf_update_tstockcancel_interface(ls_beforedate,ls_date,ls_itemcode,ln_slipqty,ls_slipno,ls_etc1,ls_kbreleasedate,ln_kbreleaseseq,ln_seqno)
			else
				wf_update_tstock_interface(ls_beforedate,ls_date,ls_itemcode,ln_slipqty,ls_slipno,ls_etc1,ls_kbreleasedate,ln_kbreleaseseq,ln_seqno)
			end if

		CASE 	4	//	사내출하,반납
			ln_seqno		=	f_dw.getitemnumber(i,"tshipetc_interface_seqno")	
			ls_inputflag	=	f_dw.getitemstring(i,"tshipetc_interface_inputflag")				
			if ls_inputflag		=	'1'	then 	// 사내출하
				if	mid(ls_beforedate,1,7)	>	mid(ls_date,1,7)	then
					ls_applymonth	=	mid(ls_beforedate,1,7)
					select	isnull(invqty,0)	into	:ln_checkqty	from tinvhis
						where applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
								divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
					using	sqlpis	;
					if	ln_checkqty	<	ln_slipqty	then
						messagebox("확인",string(i) + " 열의 기준월 기초수량이 수정월 사내출하수량보다 작습니다")
						return false
					else	
						ln_checkqty	=	ln_slipqty
					end if
				else
					ls_applymonth	=	mid(ls_date,1,7)
					ln_checkqty		=	ln_slipqty	*	(-1)
				end if
				update	tinvhis
					set		invqty		=	invqty	-	:ln_checkqty	
				where		applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
							divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
				using	sqlpis ;
				if	sqlpis.sqlcode	<>	0	then
					return	false
				end if
			elseif ls_inputflag		=	'2'	then 	// 반납
				if	mid(ls_beforedate,1,7)	>	mid(ls_date,1,7)	then
					ls_applymonth	=	mid(ls_beforedate,1,7)
					ln_checkqty		=	ln_slipqty	*	(-1)
				else
					ls_applymonth	=	mid(ls_date,1,7)
					select	isnull(invqty,0)	into	:ln_checkqty	from tinvhis
						where applymonth		=	:ls_applymonth			and	areacode		=	:is_areacode		and
								divisioncode	=	:is_divisioncode		and	itemcode		=	:ls_itemcode	
					using	sqlpis	;
					if	ln_checkqty	<	ln_slipqty	then
						messagebox("확인",string(i) + " 열의 기준월 기초수량이 수정월 반납수량보다 작습니다")
						return false
					else	
						ln_checkqty	=	ln_slipqty
					end if
				end if
				update	tinvhis
					set		invqty		=	invqty	-	:ln_checkqty	
				where		applymonth		=	:ls_applymonth		and	areacode		=	:is_areacode		and
							divisioncode	=	:is_divisioncode	and	itemcode		=	:ls_itemcode	
				using	sqlpis ;
				if	sqlpis.sqlcode	<>	0	then
					return	false
				end if
			end if
			wf_update_tshipetc_interface(ls_beforedate,ls_date,ls_itemcode,ln_slipqty,ls_slipno,ls_etc1,ls_inputflag,ln_seqno)

		CASE 	5	//	이체
		
	END CHOOSE
	wf_update_tlotno(ls_beforedate,ls_date,ls_itemcode,ln_slipqty,ls_inputflag)	
next
return true



end function

on w_piss005u.create
int iCurrent
call super::create
this.gb_currentmonth=create gb_currentmonth
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.tab_1=create tab_1
this.gb_1=create gb_1
this.uo_item=create uo_item
this.st_baseqty=create st_baseqty
this.sle_baseqty=create sle_baseqty
this.st_inqty=create st_inqty
this.sle_inqty=create sle_inqty
this.st_outqty=create st_outqty
this.sle_outqty=create sle_outqty
this.st_2=create st_2
this.sle_invqty=create sle_invqty
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_currentmonth
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.uo_item
this.Control[iCurrent+8]=this.st_baseqty
this.Control[iCurrent+9]=this.sle_baseqty
this.Control[iCurrent+10]=this.st_inqty
this.Control[iCurrent+11]=this.sle_inqty
this.Control[iCurrent+12]=this.st_outqty
this.Control[iCurrent+13]=this.sle_outqty
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.sle_invqty
end on

on w_piss005u.destroy
call super::destroy
destroy(this.gb_currentmonth)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.tab_1)
destroy(this.gb_1)
destroy(this.uo_item)
destroy(this.st_baseqty)
destroy(this.sle_baseqty)
destroy(this.st_inqty)
destroy(this.sle_inqty)
destroy(this.st_outqty)
destroy(this.sle_outqty)
destroy(this.st_2)
destroy(this.sle_invqty)
end on

event ue_retrieve;long ll_count

setpointer(hourglass!)
if trim(is_itemcode) = '%' then
	messagebox("확인","품번을 입력바랍니다.")
	return
end if	
tab_1.triggerevent("ue_retrieve")

end event

event ue_save;datawindow ldw
if ii_tabindex = 1 then
	ldw = tab_1.tabpage_1.dw_tabpage1
elseif ii_tabindex = 2 then
	ldw = tab_1.tabpage_2.dw_tabpage2
elseif ii_tabindex = 3 then
	ldw = tab_1.tabpage_3.dw_tabpage3
elseif ii_tabindex = 4 then
	ldw = tab_1.tabpage_4.dw_tabpage4
elseif ii_tabindex = 5 then
	ldw = tab_1.tabpage_5.dw_tabpage5
end if
ldw.accepttext()
SQLPIS.AutoCommit	= False
if wf_save(ldw) = false then
	rollback using sqlpis ;
	SQLPIS.AutoCommit	= True
	return 
else
	commit using sqlpis ;
	SQLPIS.AutoCommit	= True
end if
postevent('ue_retrieve')


end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if 
end event

event open;call super::open;sle_baseqty.text = ''
sle_inqty.text		= ''
sle_outqty.text	= ''
sle_invqty.text	= ''

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss005u
integer y = 2476
integer width = 4553
end type

type gb_currentmonth from groupbox within w_piss005u
integer x = 41
integer y = 188
integer width = 3511
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type uo_area from u_pisc_select_area within w_piss005u
integer x = 818
integer y = 96
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)

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

type uo_division from u_pisc_select_division within w_piss005u
integer x = 1367
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;is_divisioncode = is_uo_divisioncode

end event

type uo_date from u_pisc_date_applydate within w_piss005u
integer x = 73
integer y = 96
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate <> is_uo_date then
	tab_1.tabpage_1.dw_tabpage1.reset()
	tab_1.tabpage_2.dw_tabpage2.reset()
	tab_1.tabpage_3.dw_tabpage3.reset()
	tab_1.tabpage_4.dw_tabpage4.reset()
	tab_1.tabpage_5.dw_tabpage5.reset()
end if	
is_shipdate = is_uo_date
is_currentmonth = mid(is_uo_date,1,7)
gb_currentmonth.text 	= is_currentmonth + '월'


end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type tab_1 from tab within w_piss005u
event create ( )
event destroy ( )
event ue_retrieve ( )
string tag = "출하일자소급"
integer x = 18
integer y = 420
integer width = 4539
integer height = 2116
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
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event ue_retrieve();integer li_count
if ii_tabindex = 1 then
	li_count = tab_1.tabpage_1.dw_tabpage1.retrieve(is_areacode,is_divisioncode,is_itemcode,is_shipdate)
elseif ii_tabindex = 2 then
	li_count = tab_1.tabpage_2.dw_tabpage2.retrieve(is_areacode,is_divisioncode,is_itemcode,is_shipdate)
elseif ii_tabindex = 3 then
	li_count = tab_1.tabpage_3.dw_tabpage3.retrieve(is_areacode,is_divisioncode,is_itemcode,is_shipdate)
elseif ii_tabindex = 4 then
	li_count = tab_1.tabpage_4.dw_tabpage4.retrieve(is_areacode,is_divisioncode,is_itemcode,is_shipdate)
elseif ii_tabindex = 5 then
	li_count = tab_1.tabpage_5.dw_tabpage5.retrieve(is_areacode,is_divisioncode,is_itemcode,is_shipdate)
end if 
if li_count <= 0 then
	messagebox("확인","조회할 정보가 없습니다")
end if
wf_qty_find(is_Areacode,is_divisioncode,is_itemcode,is_currentmonth)

end event

event selectionchanged;this.tabpage_1.tabtextcolor = rgb(0,0,0)
this.tabpage_2.tabtextcolor = rgb(0,0,0)
this.tabpage_3.tabtextcolor = rgb(0,0,0)
this.tabpage_4.tabtextcolor = rgb(0,0,0)
this.tabpage_5.tabtextcolor = rgb(0,0,0)
if newindex = 1 then
	this.tabpage_1.tabtextcolor = rgb(255,0,0)
elseif newindex = 2 then
	this.tabpage_2.tabtextcolor = rgb(255,0,0)
elseif newindex = 3 then
	this.tabpage_3.tabtextcolor = rgb(255,0,0)
elseif newindex = 4 then
	this.tabpage_4.tabtextcolor = rgb(255,0,0)
elseif newindex = 5 then
	this.tabpage_5.tabtextcolor = rgb(255,0,0)
end if
ii_tabindex = newindex


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4503
integer height = 2000
long backcolor = 12632256
string text = "출하정보소급"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage1 dw_tabpage1
end type

on tabpage_1.create
this.dw_tabpage1=create dw_tabpage1
this.Control[]={this.dw_tabpage1}
end on

on tabpage_1.destroy
destroy(this.dw_tabpage1)
end on

type dw_tabpage1 from datawindow within tabpage_1
integer x = 5
integer y = 16
integer width = 4480
integer height = 2180
integer taborder = 20
string title = "none"
string dataobject = "d_piss_005u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
if row < 1 then
	return
end if
this.selectrow(row,true)



end event

event constructor;this.settransobject(sqlpis)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4503
integer height = 2000
long backcolor = 12632256
string text = "입고정보소급"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage2 dw_tabpage2
end type

on tabpage_2.create
this.dw_tabpage2=create dw_tabpage2
this.Control[]={this.dw_tabpage2}
end on

on tabpage_2.destroy
destroy(this.dw_tabpage2)
end on

type dw_tabpage2 from datawindow within tabpage_2
integer x = 5
integer y = 12
integer width = 4494
integer height = 2176
integer taborder = 60
string title = "none"
string dataobject = "d_piss_005u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
if row < 1 then
	return
end if
this.selectrow(row,true)
end event

event constructor;this.settransobject(sqlpis)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4503
integer height = 2000
long backcolor = 12632256
string text = "입고취소소급"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage3 dw_tabpage3
end type

on tabpage_3.create
this.dw_tabpage3=create dw_tabpage3
this.Control[]={this.dw_tabpage3}
end on

on tabpage_3.destroy
destroy(this.dw_tabpage3)
end on

type dw_tabpage3 from datawindow within tabpage_3
integer x = 5
integer y = 12
integer width = 4494
integer height = 2180
integer taborder = 70
string title = "none"
string dataobject = "d_piss_005u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
if row < 1 then
	return
end if
this.selectrow(row,true)
end event

event constructor;this.settransobject(sqlpis)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4503
integer height = 2000
long backcolor = 12632256
string text = "사내출하,반납소급"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage4 dw_tabpage4
end type

on tabpage_4.create
this.dw_tabpage4=create dw_tabpage4
this.Control[]={this.dw_tabpage4}
end on

on tabpage_4.destroy
destroy(this.dw_tabpage4)
end on

type dw_tabpage4 from datawindow within tabpage_4
integer x = 5
integer y = 12
integer width = 4489
integer height = 2184
integer taborder = 70
string title = "none"
string dataobject = "d_piss_005u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
if row < 1 then
	return
end if
this.selectrow(row,true)
end event

event constructor;this.settransobject(sqlpis)
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4503
integer height = 2000
long backcolor = 12632256
string text = "이체정보소급"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage5 dw_tabpage5
end type

on tabpage_5.create
this.dw_tabpage5=create dw_tabpage5
this.Control[]={this.dw_tabpage5}
end on

on tabpage_5.destroy
destroy(this.dw_tabpage5)
end on

type dw_tabpage5 from datawindow within tabpage_5
integer x = 5
integer y = 12
integer width = 4494
integer height = 2180
integer taborder = 70
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
if row < 1 then
	return
end if
this.selectrow(row,true)
end event

event constructor;this.settransobject(sqlpis)
end event

type gb_1 from groupbox within w_piss005u
integer x = 23
integer y = 28
integer width = 4544
integer height = 384
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_item from u_pisc_select_item_model_kdac within w_piss005u
event destroy ( )
integer x = 1984
integer y = 76
integer taborder = 40
boolean bringtotop = true
end type

on uo_item.destroy
call u_pisc_select_item_model_kdac::destroy
end on

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode

end event

type st_baseqty from statictext within w_piss005u
integer x = 69
integer y = 272
integer width = 297
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "기초수량"
boolean focusrectangle = false
end type

type sle_baseqty from singlelineedit within w_piss005u
integer x = 357
integer y = 260
integer width = 366
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_inqty from statictext within w_piss005u
integer x = 814
integer y = 272
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "누적입고수량"
boolean focusrectangle = false
end type

type sle_inqty from singlelineedit within w_piss005u
integer x = 1298
integer y = 260
integer width = 366
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_outqty from statictext within w_piss005u
integer x = 1755
integer y = 272
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "누적불출수량"
boolean focusrectangle = false
end type

type sle_outqty from singlelineedit within w_piss005u
integer x = 2203
integer y = 260
integer width = 366
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_2 from statictext within w_piss005u
integer x = 2656
integer y = 272
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "현 재고수량"
boolean focusrectangle = false
end type

type sle_invqty from singlelineedit within w_piss005u
integer x = 3104
integer y = 260
integer width = 366
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

