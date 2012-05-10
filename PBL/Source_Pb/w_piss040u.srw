$PBExportHeader$w_piss040u.srw
$PBExportComments$입고취소(간판read)
forward
global type w_piss040u from w_ipis_sheet01
end type
type dw_kb_scan from u_vi_std_datawindow within w_piss040u
end type
type cb_inputkb from commandbutton within w_piss040u
end type
type cb_confirm from commandbutton within w_piss040u
end type
type st_2 from statictext within w_piss040u
end type
type st_3 from statictext within w_piss040u
end type
type st_4 from statictext within w_piss040u
end type
type st_5 from statictext within w_piss040u
end type
type sle_itemname from singlelineedit within w_piss040u
end type
type sle_invdate from singlelineedit within w_piss040u
end type
type sle_rackqty from singlelineedit within w_piss040u
end type
type sle_invqty from singlelineedit within w_piss040u
end type
type uo_area from u_pisc_select_area within w_piss040u
end type
type uo_division from u_pisc_select_division within w_piss040u
end type
type dw_sheet from datawindow within w_piss040u
end type
type sle_reason from singlelineedit within w_piss040u
end type
type gb_1 from groupbox within w_piss040u
end type
type gb_2 from groupbox within w_piss040u
end type
type gb_3 from groupbox within w_piss040u
end type
type gb_4 from groupbox within w_piss040u
end type
type gb_5 from groupbox within w_piss040u
end type
end forward

global type w_piss040u from w_ipis_sheet01
integer width = 4530
string title = "입고취소"
event ue_cancel ( )
event ue_kbnopinut ( )
dw_kb_scan dw_kb_scan
cb_inputkb cb_inputkb
cb_confirm cb_confirm
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
sle_itemname sle_itemname
sle_invdate sle_invdate
sle_rackqty sle_rackqty
sle_invqty sle_invqty
uo_area uo_area
uo_division uo_division
dw_sheet dw_sheet
sle_reason sle_reason
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
end type
global w_piss040u w_piss040u

type variables
string is_security, is_kbno, is_asgubun, &
       is_workcenter, is_shift, is_linecode, &
       is_enddate, is_invdate, is_lotno,is_applydate_close,is_applydate,ls_applytime
integer ii_window_border = 10
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,il_kbloopsn
string is_itemcode,is_divisioncode,is_areacode,is_plandate,is_kbreleasedate
long   ii_kbreleaseseq,ii_stockqty,il_qty



end variables

forward prototypes
public subroutine wf_init ()
public subroutine wf_dw_sheet_insert ()
public function boolean wf_kb_valid_check (string fs_areacode, string fs_divisioncode, string fs_kbno)
public function boolean wf_update_tstockcancel_interface (string fs_close_date)
public function boolean wf_update ()
public function boolean wf_update_tkbhistrace (string fs_areacode, string fs_divisioncode, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq, string fs_itemcode, long fl_qty)
end prototypes

event ue_cancel;If wf_update() Then
	commit using sqlpis;
	SQLpis.AutoCommit	= True
	MessageBox("저장","입고취소 처리를 완료하였습니다.")
	dw_kb_scan.reset()
	dw_kb_scan.insertrow(1)
	wf_init()
else
	rollback using sqlpis;
	SQLpis.AutoCommit	= True	
	MessageBox("저장","입고취소 처리가 안되었읍니다.")
	dw_kb_scan.reset()
	dw_kb_scan.insertrow(1)
	wf_init()
End If
return 
end event

event ue_kbnopinut;wf_init()
end event

public subroutine wf_init ();sle_invdate.text	= ''
sle_invqty.text 	= ''
sle_itemname.text	= ''
sle_rackqty.text	= ''
sle_reason.text	= ''

ii_rackqty	  = 0
ii_cancelqty  = 0
is_itemcode	  = ''
is_workcenter = ''
is_linecode   = ''

dw_kb_scan.reset()
dw_kb_scan.insertrow(0)
dw_kb_scan.setfocus()
dw_kb_scan.setcolumn(1)


end subroutine

public subroutine wf_dw_sheet_insert ();dw_sheet.insertrow(1)
dw_sheet.object.itemcode[1]     = is_itemcode
dw_sheet.object.itemname[1]     = sle_itemname.text
dw_sheet.object.kbno[1]         = dw_kb_scan.object.kbno[1]
dw_sheet.object.prddate[1]      = left(sle_invdate.text,10)
dw_sheet.object.rackqty[1]      = long(sle_rackqty.text)
//dw_sheet.object.divisioncode[1] = is_divisioncode
dw_sheet.object.prddate[1]      = sle_invdate.text
dw_sheet.object.rackqty[1]      = ii_cancelqty





end subroutine

public function boolean wf_kb_valid_check (string fs_areacode, string fs_divisioncode, string fs_kbno);// 입고취소가 가능한 간판
// ActiveGubun = 'A', PrintFlag = 'Y', 간판 Status = 'D'
// fs_kbno	= is_plantcode + LineID + productgroup + ProductID + S/N

String	ls_plant, ls_lineid, ls_sn, ls_db_lineid, ls_modelcode,ls_applydate_close,ls_prddate,ls_itemcode
string ls_divisioncode
long		li_kbcount, li_originalqty
datetime ldt_apply_date_time
If mid(is_kbno,3,1) = 'Z' Then
	MessageBox("확인","현품표입니다.")
	Return False
End If
Select Count(*)
  Into :li_kbcount
  From tkb
 Where KBNo		      = :fs_kbno
   and AreaCode      = :fs_areacode
	and DivisionCode  = :fs_divisioncode
   And KBActiveGubun	= 'A'
	And KBStatusCode	= 'D' 
	And Printcount		> 0
	and invgubunflag  = 'N'
	and rackqty = currentqty
	using sqlpis;

If li_kbcount < 1 Then
	MessageBox("확인","잘못된 간판번호입니다. ~r~n" + &
					" 1. 간판 마스타에 등록되지 않는 간판번호이거나~r~n" + &
					" 2. Sleeping 상태의 간판이거나~r~n"	+ &
					" 3. 입고 되지 않은  간판입니다.~r~n"	+ &
					" 4. 이미 입고 취소된 간판입니다.~r~n"+  &
					" 5. 이미 출하된 간판입니다.")
	Return False
End If


Integer	li_invqty = 0
String	ls_itemname
DateTime	ldt_kbstocktime

Select	B.WorkCenter,
			B.LineCode,
			B.ItemCode,
			A.ItemName,
			B.StockQty,
			B.ASGubun,
			B.KBStockTime,
			B.Lotno
  Into 	:is_workcenter,
			:is_linecode,
			:is_itemcode,
  			:ls_itemname,
  			:ii_rackqty,
			:is_asgubun,
			:ldt_kbstocktime,
			:is_lotno
  From	tmstitem A,
  			tkb B
 Where	B.ItemCode		= A.ItemCode
   and   B.AreaCode     = :is_areacode
	and   B.DivisionCode = :is_divisioncode
	And	B.KBNo			= :fs_kbno
   And	KBActiveGubun		= 'A'
	And	KBStatusCode		= 'D' 
   And	PrintCount 		> 0
//	And	StockCancel 	= 'N'
	using sqlpis;

sle_invdate.text	= string(ldt_kbstocktime, 'YYYY.MM.DD HH:MM:SS')
sle_rackqty.text 	= string(ii_rackqty)

ii_cancelqty = ii_rackqty

Select max(kbreleasedate)
  Into :is_kbreleasedate
  From tkbhis
 Where AreaCode      = :fs_areacode
   and DivisionCode  = :fs_divisioncode
   and KBNo				= :fs_kbno
	And KBStatusCode	= 'D' 
//	And StockCancel 	= 'N'
	using sqlpis;

Select max(kbreleaseseq)
  Into :ii_kbreleaseseq
  From tkbhis
 Where AreaCode      = :is_areacode
   and DivisionCode  = :is_divisioncode
	and KBReleaseDate = :is_kbreleasedate
   and KBNo				= :fs_kbno
	And KBStatusCode	= 'D' 
//	And StockCancel 	= 'N'
	using sqlpis;
	
IF IsNull(ldt_kbstocktime) Then
	Messagebox('오 류', 'Reading 한 간판의 입고시간이 올바르지 않습니다.')
	return false
end if
	
//is_enddate 			= f_get_timetodate(ldt_endtime)
//is_invdate			= f_get_timetodate(ldt_kbstocktime)
//is_enddate			= is_invdate
select 	Invqty + repairqty
  Into	:li_invqty
  From	tinv
 Where	ItemCode	    = :is_itemcode
	and	AreaCode		 = :is_areacode
	and   DivisionCode = :is_divisioncode
	using sqlpis;
	
sle_itemname.text = ls_itemname
sle_invqty.text		= string(li_invqty)
//그냥 엔터를 칠경우 간판이 회수 상태가 되므로 위험함
//dw_cancelqty.setitem(1, 1, ii_rackqty)
//dw_cancelqty.setitem(1, 1, 0)
return true
end function

public function boolean wf_update_tstockcancel_interface (string fs_close_date);string ls_kbreleasedate,ls_workcenter,ls_linecode,ls_itemcode,ls_supplygubun,ls_hostworkcenter,ls_hostlinecode
string ls_stockdate
long ll_seqno,ll_kbreleaseseq
select top 1 kbreleasedate,kbreleaseseq,workcenter,linecode,itemcode,stockdate
  into :ls_kbreleasedate,:ll_kbreleaseseq,:ls_workcenter,:ls_linecode,:ls_itemcode,:ls_stockdate
  from tkbhis
 where kbno = :is_kbno
   and kbstatuscode = 'D'
 using sqlpis;
 
select top 1 supplygubun,hostworkcenter,hostlinecode
  into :ls_supplygubun,:ls_hostworkcenter,:ls_hostlinecode
  from tmstline
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and workcenter = :ls_workcenter
	and linecode = :ls_linecode
 using sqlpis;
if ls_supplygubun = 'Y' then
	ls_workcenter = ls_hostworkcenter
	ls_linecode   = ls_hostlinecode
end if	
 
if left(ls_stockdate,7) <> left(fs_close_date,7) then  //월이 틀리면
	 select max(seqno)
		into :ll_seqno
		from tstockcancel_interface
	  where kbno          = :is_kbno
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
	VALUES (:is_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_seqno,
			  :fs_close_date,:is_areacode,:is_divisioncode,:ls_workcenter,:ls_linecode,
			  :ls_itemcode,:ii_cancelqty,
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
		where kbno          = :is_kbno
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
	VALUES (:is_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_seqno,
			  :ls_stockdate,:is_areacode,:is_divisioncode,:ls_workcenter,:ls_linecode,
			  :ls_itemcode,:ii_cancelqty,
			  'D','Y',:g_s_empno,getdate())
		using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "tstock_interface error : " + sqlpis.sqlerrtext
		return false
	end if
end if
return true

end function

public function boolean wf_update ();////////////////////////////////////////////////////////////////////////////////////////
//		Function Name	: wf_update																		  //
//		Purpose			: 입고취소 수량을 입력받아 테이블에 Update시킨다.					  //
//								(tkb, tkbhis,tinv, tlotno, tprdstatus)	  		                 //
// 	Scope				: Protected																		  //
// 	Arguments		: None																			  //
// 	Returns			: Integer																		  //
//								SQL_Code 값을 Return 한다.												  //
////////////////////////////////////////////////////////////////////////////////////////

int		li_qty,li_order_row,li_results_row,li_loop_count,li_hit_count,li_order_result
long     ll_count,ll_cnt
String	ls_applydate, ls_kbno, ls_date,ls_applyfrom,ls_timecode,ls_close_date
datetime	ldt_stocktime,ldt_stand_datetime
string   ls_applydate_close,ls_prddate,ls_areacode,ls_divisioncode,ls_stockdate
string   ls_kbreleasedate,ls_kbstatuscode
long     ll_kbreleaseseq,ll_prdorder,ll_prdkborder
INTEGER	li_error_code
If MessageBox("확인","입고간판을 취소하시겠습니까?",Question!, YesNo!) = 2 Then
	messagebox('확인','작업이 취소되었습니다.')
	Return false
End If
setpointer(hourglass!)
SQLpis.AutoCommit	= False
ls_applydate_close	=	f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_close_date     	=	f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_applydate			=  f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())

select prddate,areacode,divisioncode,stockdate,timecode,timeapplyfrom
  into :ls_prddate,:ls_areacode,:ls_divisioncode,:ls_stockdate,:ls_timecode,:ls_applyfrom
  from tkb
 where kbno = :is_kbno
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
	and kbstatuscode = 'D'
 using sqlpis;

select top 1 kbreleasedate,kbreleaseseq
  into :ls_kbreleasedate,:ll_kbreleaseseq
  from tkbhis
 where kbno = :is_kbno
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
	and kbactivegubun = 'A'
	and kbstatuscode = 'D'
 using sqlpis;
if ls_PRDdate = ls_applydate_close then  //입고일자가 같으면
	DECLARE actual_delete	procedure for sp_piss040u_01
	@ps_areacode		= :is_areacode,
	@ps_divisioncode	= :is_divisioncode,
	@ps_workcenter		= :is_workcenter,
	@ps_linecode		= :is_linecode,
	@ps_kbno				= :is_kbno,
	@ps_com_code		= :g_s_empno,	
	@pi_err_code		= :li_error_code	output
	USING	SQLPIS;
	
	EXECUTE actual_delete ;
	
	FETCH actual_delete
		INTO :li_error_code ;
	CLOSE	actual_delete ;
   wf_dw_sheet_insert()	
	if li_error_code <> 0 then 
		uo_status.st_message.text = "procedure error : " + string(li_error_code)
		return false
	else
		return true
	end if	
end if	

if not wf_update_tstockcancel_interface(ls_close_date) then
	return false
end if	

if not wf_update_tkbhistrace(is_areacode,is_divisioncode,is_kbno,is_kbreleasedate,ii_kbreleaseseq,is_itemcode,ii_cancelqty) then
	return false
end if	

 
if ls_PRDdate = ls_applydate_close then  //입고일자가 같으면
else
	UPDATE tkb
		SET KBstatusCode	   = 'F',
			 stockCancel 	   = 'Y',
			 LastEmp			   = 'Y',
			 LastDate		   = GetDate()
	 WHERE KBNo				   = :is_kbno
	 using sqlpis;
end if	
If sqlpis.sqlcode <> 0 Then
	uo_status.st_message.text = '간판 정보 저장에 오류가 발생하였습니다. '+  sqlpis.sqlerrtext			
	return false
end if	
if ls_PRDdate = ls_applydate_close then  //입고일자가 같으면
ELSE
	UPDATE TKBHIS
		SET KBstatusCode	   = 'F',
			 stockCancel 	   = 'Y',
			 LastEmp			   = 'Y',
			 LastDate		   = GetDate()
	 WHERE KBNo					= :is_kbno
		and kbstatuscode     = 'D'
		AND KBActiveGubun		= 'A'
	 using sqlpis;
END IF
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = '간판his 정보 저장에 오류가 발생하였습니다. '+  sqlpis.sqlerrtext
	Return false
End If

//if ls_prddate = ls_applydate_close then //생산년월일이 같으면
//end if
//
//if ls_prddate = ls_applydate_close then //생산일자와 취소일자가 같으때
//end if
//
if left(ls_prddate,7) = left(ls_applydate_close,7) then //생산년월이 같으면
	select count(*)
	  into :ll_cnt
	  from tprd
	 WHERE	PrdDate			= :ls_prddate
		AND	AreaCode			= :is_areacode
		AND	DivisionCode		= :is_divisioncode
		AND	WorkCenter		= :is_workcenter
		AND	LineCode			= :is_linecode
		AND	ItemCode			= :is_itemcode
	 using sqlpis;
	if ll_cnt = 0 then  
		INSERT INTO TPRD  
				 (Prddate,AreaCode,DivisionCode,WorkCenter,LineCode,ItemCode,   
				  PlanQty,PrdQty,LastEmp,LastDate )  
		VALUES (:ls_prddate,:is_areacode,:is_divisioncode,:is_workcenter,:is_linecode,:is_itemcode,   
				  0,:ii_cancelqty * -1,'Y',getdate() ) 
		 using sqlpis;
	else
		UPDATE	TPRD
			SET	PrdQty			= PrdQty - :ii_cancelqty,
					lastemp        = 'Y',
					lastdate       = getdate()
		 WHERE	PrdDate			= :ls_prddate
			AND	AreaCode			= :is_areacode
			AND	DivisionCode	= :is_divisioncode
			AND	WorkCenter		= :is_workcenter
			AND	LineCode			= :is_linecode
			AND	ItemCode			= :is_itemcode
		 using sqlpis;
	end if
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = 'TPRD insert error : '+  sqlpis.sqlerrtext			
		Return false
	End If

else //생산년월이 틀리면
	select count(*)
	  into :ll_cnt
	  from tprd
	 WHERE	PrdDate			= :ls_applydate
		AND	AreaCode			= :is_areacode
		AND	DivisionCode	= :is_divisioncode
		AND	WorkCenter		= :is_workcenter
		AND	LineCode			= :is_linecode
		AND	ItemCode			= :is_itemcode
	 using sqlpis;
	if ll_cnt = 0 then  
		INSERT INTO TPRD  
				 (Prddate,AreaCode,DivisionCode,WorkCenter,LineCode,ItemCode,   
				  PlanQty,PrdQty,LastEmp,LastDate )  
		VALUES (:ls_applydate,:is_areacode,:is_divisioncode,:is_workcenter,:is_linecode,:is_itemcode,   
				  0,:ii_cancelqty * -1,'Y',getdate() ) 
		 using sqlpis;
	else
		UPDATE	TPRD
			SET	PrdQty			= PrdQty - :ii_cancelqty,
					lastemp        = 'Y',
					lastdate       = getdate()
		 WHERE	PrdDate			= :ls_applydate
			AND	AreaCode			= :is_areacode
			AND	DivisionCode	= :is_divisioncode
			AND	WorkCenter		= :is_workcenter
			AND	LineCode			= :is_linecode
			AND	ItemCode			= :is_itemcode
		 using sqlpis;
	end if
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = 'TPRD insert error : '+  sqlpis.sqlerrtext
		Return false
	End If
end if

if left(ls_prddate,7) = left(ls_applydate_close,7) then
	select count(*)
	  into :ll_cnt
	  from tprdtime
	 WHERE PrdDate			=	:ls_prddate
		AND AreaCode		=	:is_areacode
		AND DivisionCode	=	:is_divisioncode
		AND WorkCenter		=	:is_workcenter
		AND LineCode		=	:is_linecode
		AND ItemCode		=	:is_itemcode
		AND ApplyFrom		=	:ls_applyfrom
		AND TimeCode		=	:ls_timecode 
	 using sqlpis;
	 if ll_cnt = 0 then
	    INSERT INTO TPRDTIME  
                (PrdDate,AreaCode,DivisionCode,WorkCenter,LineCode,
			        ItemCode,ApplyFrom,TimeCode,   
                 PlanQty,PrdQty,LastEmp,LastDate )  
         VALUES (:ls_prddate,:is_areacode,:is_divisioncode,:is_workcenter,:is_linecode,   
                 :is_itemcode,:ls_applyfrom,:ls_timecode,   
                 0,:ii_cancelqty * -1,'Y',getdate() )
			 using sqlpis;
    else
		UPDATE	TPRDTIME
			SET	PrdQty			=	PrdQty - :ii_cancelqty,
					lastdate       = getdate(),
					lastemp        = 'Y'
		 WHERE	PrdDate			=	:ls_prddate
			AND	AreaCode			=	:is_areacode
			AND	DivisionCode	=	:is_divisioncode
			AND	WorkCenter		=	:is_workcenter
			AND	LineCode			=	:is_linecode
			AND	ItemCode			=	:is_itemcode
			AND	ApplyFrom		=	:ls_applyfrom
			AND	TimeCode			=	:ls_timecode 
		 using sqlpis;
	 end if
else
	select count(*)
	  into :ll_cnt
	  from tprdtime
	 WHERE PrdDate			=	:ls_applydate
		AND AreaCode		=	:is_areacode
		AND DivisionCode	=	:is_divisioncode
		AND WorkCenter		=	:is_workcenter
		AND LineCode		=	:is_linecode
		AND ItemCode		=	:is_itemcode
		AND ApplyFrom		=	:ls_applyfrom
		AND TimeCode		=	:ls_timecode 
	 using sqlpis;
	 if ll_cnt = 0 then
	    INSERT INTO TPRDTIME  
                (PrdDate,AreaCode,DivisionCode,WorkCenter,LineCode,
			        ItemCode,ApplyFrom,TimeCode,   
                 PlanQty,PrdQty,LastEmp,LastDate )  
         VALUES (:ls_applydate,:is_areacode,:is_divisioncode,:is_workcenter,:is_linecode,   
                 :is_itemcode,:ls_applyfrom,:ls_timecode,   
                 0,:ii_cancelqty * -1,'Y',getdate() )
			 using sqlpis;
    else
		UPDATE	TPRDTIME
			SET	PrdQty			=	PrdQty - :ii_cancelqty,
					lastdate       = getdate(),
					lastemp        = 'Y'
		 WHERE	PrdDate			=	:ls_applydate
			AND	AreaCode			=	:is_areacode
			AND	DivisionCode	=	:is_divisioncode
			AND	WorkCenter		=	:is_workcenter
			AND	LineCode			=	:is_linecode
			AND	ItemCode			=	:is_itemcode
			AND	ApplyFrom		=	:ls_applyfrom
			AND	TimeCode			=	:ls_timecode 
		 using sqlpis;
	 end if
end if	
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = 'TPRDTIME정보 저장에 오류가 발생하였습니다. '+  sqlpis.sqlerrtext
	Return false
End If

select count(*)
  into :ll_count
  from tlotno
 WHERE tracedate    = :ls_close_date
	and areacode     = :is_areacode
	and divisioncode = :is_divisioncode
   and LotNo		  = :is_lotno
	and itemcode     = :is_itemcode
	and custcode     = 'XXXXXX'
	and shipgubun    = 'X'
	using sqlpis;
if isnull(ll_count) then
	ll_count = 0
end if	
if ll_count > 0 then  
	UPDATE tlotno
		SET stockqty	= Stockqty - :ii_cancelqty,
			 PrdQty		= PrdQty	  - :ii_cancelqty,
			 LastEmp		= 'Y',				
			 LastDate	= GetDate()					 
	 WHERE tracedate    = :ls_close_date
		and areacode     = :is_areacode
		and divisioncode = :is_divisioncode
		and LotNo		  = :is_lotno
		and itemcode     = :is_itemcode
		and custcode     = 'XXXXXX'
		and shipgubun    = 'X'
		using sqlpis;
else
 	  INSERT INTO TLOTNO  
         ( TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,custcode,shipgubun,
			  shipusage,PrdQty,StockQty,ShipQty,
           LastEmp,LastDate )  
  VALUES ( :ls_close_date,:is_areacode,:is_divisioncode,:is_lotno,:is_itemcode,'XXXXXX','X',
           'X',:ii_cancelqty * -1,:ii_cancelqty * -1,0,   
           'Y',getdate() )  
			  using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = 'tlotno정보 저장에 오류가 발생하였습니다. '+  sqlpis.sqlerrtext
	Return false
End If
//

if ls_prddate = ls_applydate_close then //생산일자와 취소일자가 같으때
end if

UPDATE tinv
	SET invqty	     = invqty - :ii_cancelqty,
		 LastEmp		  = 'Y',
		 LastDate	  = GetDate()
 WHERE itemcode 	  = :is_itemcode
	And areacode     = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;
if sqlpis.sqlcode <> 0 then
   uo_status.st_message.text = '재고정보 저장에 오류가 발생하였습니다. '+  sqlpis.sqlerrtext
	Return false
End If

wf_dw_sheet_insert()
setpointer(arrow!)				
return true
end function

public function boolean wf_update_tkbhistrace (string fs_areacode, string fs_divisioncode, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq, string fs_itemcode, long fl_qty);long ll_count
string ls_reason
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())

ls_reason = sle_reason.text

select max(kbtraceseq)
  into :ll_count
  from TKBHISTRACE
 where kbno          = :fs_kbno
   and kbreleasedate = :fs_kbreleasedate
	and kbreleaseseq  = :fl_kbreleaseseq
	using sqlpis;

if ll_count = 0 or isnull(ll_count) then
	ll_count = 1
else
   ll_count = ll_count + 1
end if  
//생산은 처리안함
//INSERT INTO Tkbhistrace
//         ( KBNo,kbreleasedate,kbreleaseseq,kbtraceseq,
//			  KBtraceDate,AreaCode,DivisionCode,ItemCode,gubun,   
//           traceQty,kbtracetime,kbtracereason,
//			  empno,LastEmp,LastDate )  
//  VALUES ( :fs_kbno,:fs_kbreleasedate,:fl_kbreleaseseq,:ll_count,
//           :ls_close_date,:fs_areacode,:fs_divisioncode,:fs_itemcode,'1',   
//           :fl_qty,getdate(),:ls_reason,   
//           :g_s_empno,:g_s_empno,getdate() ) 
//  using sqlpis;
//if sqlpis.sqlcode <> 0 then
//	return false
//end if
INSERT INTO Tkbhistrace
         ( KBNo,kbreleasedate,kbreleaseseq,kbtraceseq,
			  KBtraceDate,AreaCode,DivisionCode,ItemCode,gubun,   
           traceQty,kbtracetime,kbtracereason,
			  empno,LastEmp,LastDate )  
  VALUES ( :fs_kbno,:fs_kbreleasedate,:fl_kbreleaseseq,:ll_count,
           :ls_close_date,:fs_areacode,:fs_divisioncode,:fs_itemcode,'2',   
           :fl_qty,getdate(),:ls_reason,   
           :g_s_empno,'Y',getdate() ) 
  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tkbhistrace insert error : " + sqlpis.sqlerrtext
	return false
end if
return true
end function

on w_piss040u.create
int iCurrent
call super::create
this.dw_kb_scan=create dw_kb_scan
this.cb_inputkb=create cb_inputkb
this.cb_confirm=create cb_confirm
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.sle_itemname=create sle_itemname
this.sle_invdate=create sle_invdate
this.sle_rackqty=create sle_rackqty
this.sle_invqty=create sle_invqty
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_sheet=create dw_sheet
this.sle_reason=create sle_reason
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_kb_scan
this.Control[iCurrent+2]=this.cb_inputkb
this.Control[iCurrent+3]=this.cb_confirm
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.sle_itemname
this.Control[iCurrent+9]=this.sle_invdate
this.Control[iCurrent+10]=this.sle_rackqty
this.Control[iCurrent+11]=this.sle_invqty
this.Control[iCurrent+12]=this.uo_area
this.Control[iCurrent+13]=this.uo_division
this.Control[iCurrent+14]=this.dw_sheet
this.Control[iCurrent+15]=this.sle_reason
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_4
this.Control[iCurrent+20]=this.gb_5
end on

on w_piss040u.destroy
call super::destroy
destroy(this.dw_kb_scan)
destroy(this.cb_inputkb)
destroy(this.cb_confirm)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_itemname)
destroy(this.sle_invdate)
destroy(this.sle_rackqty)
destroy(this.sle_invqty)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_sheet)
destroy(this.sle_reason)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_postopen;call super::ue_postopen;dw_kb_scan.settransobject(sqlpis)
dw_sheet.settransobject(sqlpis)
dw_kb_scan.reset()
dw_kb_scan.insertrow(0)
cb_confirm.enabled = m_frame.m_action.m_save.enabled
cb_inputkb.enabled = m_frame.m_action.m_save.enabled
end event

event activate;call super::activate;dw_kb_scan.settransobject(sqlpis)
dw_sheet.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss040u
end type

type dw_kb_scan from u_vi_std_datawindow within w_piss040u
event ue_enterkey pbm_dwnprocessenter
integer x = 1349
integer y = 72
integer width = 1065
integer height = 164
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss040u_01"
end type

event ue_enterkey;//String	ls_kbno
//dwobject ldwo_this
//
//is_kbno	= GetItemString(1,1)
//AcceptText()
//ls_kbno	= GetItemString(1,1)
//
//If is_kbno = ls_kbno Then
//	Post Event ItemChanged(1, ldwo_this, GetItemString(1,1))
//End If
//
//return 1
end event

event itemchanged;Int 		li_count	= 0
is_kbno	= data
//
if wf_kb_valid_check(is_areacode,is_divisioncode,Data) Then 
	cb_confirm.enabled = true
Else
	this.Reset()
	this.InsertRow(1)
//	this.SetItem(1,1, Data)
	this.SetItem(1,1, '')
	this.setfocus()
End If
//SetColumn(1)
//SetRow(1)
//SetFocus()
end event

event ue_key;call super::ue_key;IF KeyDown(KeyEnter!) then
	Parent.TriggerEvent("itemchanged!")
end if	

end event

type cb_inputkb from commandbutton within w_piss040u
integer x = 3685
integer y = 88
integer width = 379
integer height = 144
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판입력"
end type

event clicked;sle_invdate.text	= ''
sle_invqty.text 	= ''
sle_itemname.text	= ''
sle_rackqty.text	= ''

ii_rackqty		= 0
ii_cancelqty	= 0
is_itemcode	= ''
is_workcenter = ''
is_linecode = ''
dw_kb_scan.reset()
dw_kb_scan.insertrow(0)
dw_kb_scan.setfocus()


end event

type cb_confirm from commandbutton within w_piss040u
integer x = 4069
integer y = 88
integer width = 379
integer height = 144
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "입고취소"
end type

event clicked;Parent.TriggerEvent('ue_cancel')
end event

type st_2 from statictext within w_piss040u
integer x = 82
integer y = 340
integer width = 283
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
string text = "품    명"
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss040u
integer x = 1577
integer y = 344
integer width = 283
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
string text = "입고일자"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss040u
integer x = 2802
integer y = 344
integer width = 283
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
string text = "수 용 수"
boolean focusrectangle = false
end type

type st_5 from statictext within w_piss040u
integer x = 3547
integer y = 340
integer width = 283
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
string text = "현재고량"
boolean focusrectangle = false
end type

type sle_itemname from singlelineedit within w_piss040u
integer x = 370
integer y = 316
integer width = 1161
integer height = 92
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
end type

type sle_invdate from singlelineedit within w_piss040u
integer x = 1847
integer y = 320
integer width = 841
integer height = 92
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
end type

type sle_rackqty from singlelineedit within w_piss040u
integer x = 3099
integer y = 320
integer width = 357
integer height = 92
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
end type

type sle_invqty from singlelineedit within w_piss040u
integer x = 3826
integer y = 320
integer width = 357
integer height = 92
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
end type

type uo_area from u_pisc_select_area within w_piss040u
event destroy ( )
integer x = 59
integer y = 116
integer taborder = 70
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_kb_scan.settransobject(sqlpis)
dw_sheet.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,uo_area.is_uo_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
wf_init()
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
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,uo_area.is_uo_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss040u
event destroy ( )
integer x = 631
integer y = 120
integer taborder = 80
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_kb_scan.settransobject(sqlpis)
dw_sheet.settransobject(sqlpis)

is_divisioncode = is_uo_divisioncode
wf_init()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type dw_sheet from datawindow within w_piss040u
integer x = 37
integer y = 464
integer width = 2917
integer height = 432
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss040u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_reason from singlelineedit within w_piss040u
integer x = 2528
integer y = 116
integer width = 1051
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
end type

type gb_1 from groupbox within w_piss040u
integer x = 9
integer y = 8
integer width = 1253
integer height = 256
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

type gb_2 from groupbox within w_piss040u
integer x = 1294
integer width = 1166
integer height = 268
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "간판번호"
end type

type gb_3 from groupbox within w_piss040u
integer x = 23
integer y = 268
integer width = 4210
integer height = 172
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "간판정보"
end type

type gb_4 from groupbox within w_piss040u
integer x = 2491
integer y = 4
integer width = 1138
integer height = 264
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "취소사유"
end type

type gb_5 from groupbox within w_piss040u
integer x = 3648
integer y = 4
integer width = 827
integer height = 264
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "버튼정보"
end type

