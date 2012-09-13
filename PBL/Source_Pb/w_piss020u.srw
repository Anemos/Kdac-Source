$PBExportHeader$w_piss020u.srw
$PBExportComments$입고확정
forward
global type w_piss020u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss020u
end type
type sle_1 from singlelineedit within w_piss020u
end type
type uo_area from u_pisc_select_area within w_piss020u
end type
type uo_division from u_pisc_select_division within w_piss020u
end type
type st_2 from statictext within w_piss020u
end type
type gb_2 from groupbox within w_piss020u
end type
type gb_1 from groupbox within w_piss020u
end type
end forward

global type w_piss020u from w_ipis_sheet01
integer width = 3941
string title = "입고확정"
dw_sheet dw_sheet
sle_1 sle_1
uo_area uo_area
uo_division uo_division
st_2 st_2
gb_2 gb_2
gb_1 gb_1
end type
global w_piss020u w_piss020u

type variables
string is_kbno
string is_areacode,is_divisioncode,is_itemcode,is_prddate,is_workcenter,is_plandate
long  il_qty
end variables

forward prototypes
public function integer wf_referance_data (string fs_areacode, string fs_divisioncode, string fs_kbno)
public function boolean wf_update_tstock_interface (string fs_close_date)
public function boolean wf_kb_valid_check (string fs_kbno)
public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate, string fs_kbno, string fs_itemcode, long fl_qty)
end prototypes

public function integer wf_referance_data (string fs_areacode, string fs_divisioncode, string fs_kbno);string ls_prddate,ls_workcenter,ls_itemcode,ls_itemname,ls_modelid,ls_plandate
long   ll_prdqty,ll_row

// 생산일자,조코드,품번,품명,생산수량 select
select a.prddate,a.workcenter,a.itemcode,b.itemname,a.prdqty,a.plandate
  into :ls_prddate,:ls_workcenter,:ls_itemcode,:ls_itemname,:ll_prdqty,:ls_plandate
  from tkb a,tmstitem b
 where kbno = :fs_kbno
   and areacode = :fs_areacode
	and divisioncode = :fs_divisioncode
	and a.itemcode = b.itemcode
	using sqlpis;

//식별id select
select distinct modelid
  into :ls_modelid
  from tmstkb
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and itemcode = :ls_itemcode
	using sqlpis;

ll_row = dw_sheet.insertrow(0)

dw_sheet.object.prddate[ll_row] = ls_prddate
dw_sheet.object.workcenter[ll_row] = ls_workcenter
dw_sheet.object.itemcode[ll_row] = ls_itemcode
dw_sheet.object.itemname[ll_row] = ls_itemname
dw_sheet.object.modelid[ll_row] = ls_modelid
dw_sheet.object.kbno[ll_row] = fs_kbno
dw_sheet.object.kbqty[ll_row] = ll_prdqty

dw_sheet.selectrow(0,false)
dw_sheet.selectrow(ll_row,true)
dw_sheet.scrolltorow(ll_row)

il_qty = ll_prdqty
is_itemcode = ls_itemcode
is_kbno = fs_kbno
is_workcenter = ls_workcenter
is_plandate = ls_plandate
return 1


end function

public function boolean wf_update_tstock_interface (string fs_close_date);string ls_kbreleasedate,ls_workcenter,ls_linecode,ls_itemcode,ls_supplygubun,ls_hostworkcenter,ls_hostlinecode
long ll_seqno,ll_kbreleaseseq
select kbreleasedate,kbreleaseseq,workcenter,linecode,itemcode
  into :ls_kbreleasedate,:ll_kbreleaseseq,:ls_workcenter,:ls_linecode,:ls_itemcode
  from tkbhis
  where kbno = :is_kbno
    and kbstatuscode = 'C'
 using sqlpis;
select supplygubun,hostworkcenter,hostlinecode
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
select max(seqno)
   into :ll_seqno
	from tstock_interface
	where kbno = :is_kbno
	  and kbreleasedate = :ls_kbreleasedate
	  and kbreleaseseq = :ll_kbreleaseseq
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
        :fs_close_date,:is_areacode,:is_divisioncode,:ls_workcenter,:ls_linecode,
		  :ls_itemcode,:il_qty,
		  'A','Y',:g_s_empno,getdate())
	using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tstock_interface : " + sqlpis.sqlerrtext
	return false
end if
return true

end function

public function boolean wf_kb_valid_check (string fs_kbno);Integer	li_count
string ls_kbstatuscode,ls_kbactivegubun,ls_inspectgubun,ls_stockgubun
SELECT Count(a.KBNO),kbstatuscode,kbactivegubun,inspectgubun,stockgubun,prddate
  into :li_count,:ls_kbstatuscode,:ls_kbactivegubun,:ls_inspectgubun,:ls_stockgubun,:is_prddate
  FROM TKB a
 WHERE	a.AreaCode	   = :is_areacode
   and   a.DivisionCode	= :is_divisioncode
   and	a.KBNO			= :fs_kbno
	and	a.KBActiveGubun	= 'A'
GROUP BY kbstatuscode,kbactivegubun,inspectgubun,stockgubun,prddate
	using sqlpis;
if (li_count = 0) or isnull(li_count) then	
   messagebox("확인","올바르지 않는 간판입니다.")
   return false
end if
if (ls_kbstatuscode <> 'C') AND (ls_kbstatuscode <> 'D') then
   messagebox("확인","미생산된 간판입니다.")
   return false
end if	
if (ls_kbstatuscode = 'D') then
   messagebox("확인","이미 입고된 간판입니다.")
   return false
end if	
if (ls_inspectgubun = 'Y') or (ls_stockgubun = 'Y') then
else
   messagebox("확인","입고확정 필요 없는 간판입니다.")
   return false
end if	
Return True

end function

public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate, string fs_kbno, string fs_itemcode, long fl_qty);integer 	li_tinvhis_count,ll_tinv_count
Long		ll_CloseInv,ll_CloseMoveInv
String	ls_date,ls_lotno,ls_kbreleasedate
long     ll_kbreleaseseq,ll_count
string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

if not wf_update_tstock_interface(ls_close_date) then
	return false
end if

select lotno
  into :ls_lotno
  from tkb
 where areacode     = :fs_areacode
   and divisioncode = :fs_divisioncode
	and kbno         = :fs_kbno
	using sqlpis;
IF isnull(ls_lotno) or isnull(ls_lotno) then
	ls_lotno = 'XXXXXX'
end if	
select top 1 kbreleasedate,kbreleaseseq
  into :ls_kbreleasedate,:ll_kbreleaseseq
  from tkbhis
 where kbno         = :fs_kbno
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
//	AND kbreleasedate = :fs_applydate
	and kbstatuscode  = 'C'
	using sqlpis;
	
//창고 입고시 tlotnohis,Tkb,tkbhis,tkbhistrace,tinv
//         inspectflag   = case inspectgubun 
//			                      when 'Y' then 'Y' 
//									    else inspectflag
//								  end,
//         stockgubun     = case stockgubun 
//			                      when 'Y' then 'N' 
//									    else stockgubun
//								  end,
Update	tkb
   Set	KBStatusCode	= 'D',
	      inspectflag   = case inspectgubun 
			                      when 'Y' then 'Y' 
									    else inspectflag
								  end,
			KBStockTime		= GetDate(),
			Stockdate      = :ls_close_date,
			StockQty       = PrdQty,
			LastEmp			= 'Y',
			LastDate			= GetDate()
  Where	KBNo				= :fs_kbno
	using sqlpis;
If SQLPIS.SQLCode	<> 0 then
   uo_status.st_message.text = "TKB update시 오류가 발생하였습니다."
	Return false
End if 
//       inspectgubun   = case inspectgubun 
//			                    when 'Y' then 'N' 
//								     else inspectgubun
//								end,
//       stockgubun     = case stockgubun 
//			                    when 'Y' then 'N' 
//								     else stockgubun
//								end,
//
Update tkbhis
	Set KBStatusCode	= 'D',
		 inspectflag   = case inspectgubun 
									 when 'Y' then 'Y' 
									 else inspectflag
							  end,
		 KBStockTime		= GetDate(),
		 Stockdate      = :ls_close_date,
		 StockCancel    = 'N',
		 StockQty       = PrdQty,
		 LastEmp			 = 'Y',
		 LastDate		 = GetDate()
 Where KBNo				 = :fs_kbno
	and areacode       = :fs_areacode
	and divisioncode   = :fs_divisioncode
	and kbstatuscode   = 'C'
	using sqlpis;
if sqlpis.sqlcode <> 0 then		
   uo_status.st_message.text = "TKB update시 오류가 발생하였습니다."
	Return false
End if 
select count(*)
  into :ll_count
  from tlotno
 where tracedate    = :ls_close_date
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and lotno        = :ls_lotno
	and itemcode     = :fs_itemcode
	and custcode     = 'XXXXXX'
	and shipgubun    = 'X'
 using sqlpis;
if ll_count > 0 then
	update tlotno
		set stockqty     = stockqty + :fl_qty,
		    lastemp      = 'Y',
			 lastdate     = getdate()
	 where tracedate    = :ls_close_date
		and areacode     = :fs_areacode
		and divisioncode = :fs_divisioncode
		and lotno        = :ls_lotno
		and itemcode     = :fs_itemcode
		and custcode     = 'XXXXXX'
		and shipgubun    = 'X'
	 using sqlpis;
else
	  INSERT INTO TLOTNO
                (TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,custcode,shipgubun,
			        shipusage,prdQty,StockQty,ShipQty,
			        LastEmp,LastDate )  
         VALUES 
			      (:ls_close_date,:fs_areacode,:fs_divisioncode,:ls_lotno,:fs_itemcode,'XXXXXX','X',
                'X',0,:fl_qty,0,
					 'Y',getdate() ) 
			using sqlpis  ;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "Tlotno update시 오류가 발생하였습니다."
	return false
end if

select count(*) 
  into :ll_count 
  from tinv
 where ItemCode	  = :fs_itemcode
	and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if ll_count > 0 then
	Update tinv
		set Invqty	   = invqty	+ :fl_Qty,
			 LastEmp		= 'Y',
			 LastDate	= GetDate()
	 where ItemCode	  = :fs_itemcode
		and areacode     = :fs_areacode
		and divisioncode = :fs_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty,repairqty,defectqty, Lastemp, lastDate)
			Values(:fs_areacode,:fs_divisioncode,:fs_itemcode, &
					 :fl_qty,0,0, 'Y', Getdate())
	using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "Tinv update시 오류가 발생하였습니다."
	Return false
End if
/* 취소만 관리 */
/*select max(kbtraceseq)
  into :ll_count
  from TKBHISTrace
 where kbno = :fs_kbno
   and kbreleasedate = :ls_kbreleasedate
	and kbreleaseseq  = :ll_kbreleaseseq
	using sqlpis;

if ll_count = 0 or isnull(ll_count) then
	ll_count = 1
else
   ll_count = ll_count + 1
end if  
INSERT INTO Tkbhistrace  
         ( kbno,kbreleasedate,kbreleaseseq,kbtraceseq,
           kbtracedate,AreaCode,DivisionCode,itemcode,gubun,
			  traceqty,kbtracetime,kbtracereason,
			  empno,lastemp,lastdate)
  VALUES ( :fs_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_count,
           :ls_close_date,:fs_areacode,:fs_divisioncode,:fs_itemcode,'2',
           :fl_qty,getdate(),null,   
           :g_s_empno,:g_s_empno,getdate() ) 
  using sqlpis;
if sqlpis.sqlcode <> 0 then
	return false
end if
*/
return true
end function

on w_piss020u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.sle_1=create sle_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
end on

on w_piss020u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.sle_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;//long ll_count
//
//setpointer(hourglass!)
//ll_count = dw_1.retrieve(is_prddate,is_areacode,is_divisioncode)
//setpointer(arrow!)
//if ll_count = 0 then
//	messagebox("확인","조회된 자료가 없습니다.")
//	uo_date.setfocus()
//	return
//end if	
end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
sle_1.setfocus()
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss020u
end type

type dw_sheet from u_vi_std_datawindow within w_piss020u
integer x = 18
integer y = 252
integer width = 3575
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss020u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type sle_1 from singlelineedit within w_piss020u
integer x = 1335
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
	if wf_referance_Data(is_areacode,is_divisioncode,this.text) = 1 then
	   SQLPIS.Autocommit	= false
  	   If wf_save(is_areacode,is_divisioncode,is_prddate,is_kbno,is_itemcode,il_qty) then
 		   Commit USING SQLPIS;
		   SQLPIS.AutoCommit	= true
			this.text = ''
		   this.SetFocus()
	   Else
		   RollBack USING SQLPIS;
		   SQLpis.AutoCommit	= true		
		   MessageBox('에러', "입고 처리시 에러가 발생하였습니다.")
			this.text = ''
		   this.SetFocus()		
	   End if
   end if
Else
	this.text = ''
	this.SetFocus()
End if
sle_1.setfocus()
end event

type uo_area from u_pisc_select_area within w_piss020u
integer x = 69
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
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
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_piss020u
integer x = 640
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
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type st_2 from statictext within w_piss020u
integer x = 2121
integer y = 88
integer width = 1993
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
string text = "간판 scan시 입고 처리됩니다."
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_piss020u
integer x = 1294
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

type gb_1 from groupbox within w_piss020u
integer x = 23
integer y = 28
integer width = 1230
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

