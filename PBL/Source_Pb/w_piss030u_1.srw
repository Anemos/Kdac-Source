$PBExportHeader$w_piss030u_1.srw
$PBExportComments$이체확정(sqlca)
forward
global type w_piss030u_1 from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss030u_1
end type
type uo_division from u_pisc_select_division within w_piss030u_1
end type
type uo_date from u_pisc_date_applydate within w_piss030u_1
end type
type gb_1 from groupbox within w_piss030u_1
end type
type dw_sheet from u_vi_std_datawindow within w_piss030u_1
end type
type dw_2 from datawindow within w_piss030u_1
end type
type st_2 from statictext within w_piss030u_1
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss030u_1
end type
type cb_1 from commandbutton within w_piss030u_1
end type
type cb_2 from commandbutton within w_piss030u_1
end type
end forward

global type w_piss030u_1 from w_ipis_sheet01
string title = "이체확정"
uo_area uo_area
uo_division uo_division
uo_date uo_date
gb_1 gb_1
dw_sheet dw_sheet
dw_2 dw_2
st_2 st_2
uo_1 uo_1
cb_1 cb_1
cb_2 cb_2
end type
global w_piss030u_1 w_piss030u_1

type variables
string is_applydate,is_applydate1,is_areacode,is_divisioncode
end variables

forward prototypes
public function boolean wf_update_tsrorder (string fs_srno, string fs_areacode, string fs_divisioncode, string fs_shipdate, long fl_totalqty)
public function boolean wf_update_tinv (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_itemcode, long fl_totalqty)
public function boolean wf_update_tlotno (string fs_areacode, string fs_divisioncode, string fs_itemcode, long fl_stockqty)
public function boolean wf_update_tshipinv (string fs_shipplandate, string fs_areacode, string fs_divisioncode, string fs_srno, string fs_sendflag, long fl_truckorder, string fs_moverequireno, long fl_truckloadqty)
public function boolean wf_save ()
end prototypes

public function boolean wf_update_tsrorder (string fs_srno, string fs_areacode, string fs_divisioncode, string fs_shipdate, long fl_totalqty);long ll_shipremainqty
string ls_shipendgubun

select ShipRemainQty
  into :ll_shipremainqty
  from tsrorder
 where SRNo = :fs_SRNo
   and SRAreaCode = :fs_areacode
	and SRDivisioncode = :fs_divisioncode
	using sqlca;

if ll_shipremainqty = fl_totalqty then  //완납이면
   ls_shipendgubun  = 'Y'
else
	ls_shipendgubun  = 'N'
end if	
//이체는 무조건 종료 
ls_shipendgubun = 'Y'
update tsrorder
   set ShipDate      = :fs_shipdate,
	    ShipremainQty = ShipremainQty - :fl_totalqty,
		 ShipEndGubun  = :ls_shipendgubun,
		 lastdate      = getdate(),
		 lastemp       = 'N'
 where SRNo = :fs_SRNo
   and SRAreaCode = :fs_areacode
	and SRDivisioncode = :fs_divisioncode
using sqlca;
if sqlca.sqlcode <> 0 then
	return false
else	
	return true
end if	
end function

public function boolean wf_update_tinv (string fs_shipdate, string fs_areacode, string fs_divisioncode, string fs_itemcode, long fl_totalqty);long ll_count,ll_closeinv
select count(*)
  into :ll_count
  from tinv
 where areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and itemcode     = :fs_itemcode
	using sqlca;
if ll_count = 0 then
	insert into tinv (areacode,divisioncode,itemcode,invqty,repairqty,defectqty,lastdate,lastemp)
	       values (:fs_areacode,:fs_divisioncode,:fs_itemcode,:fl_totalqty,0,0,getdate(),:g_s_empno)
			 using sqlca;
else						
   update tinv
      set invqty       = invqty + :fl_totalqty,
	       lastdate     = getdate(),
	 		 lastemp      = 'N'
    where areacode     = :fs_areacode
	   and divisioncode = :fs_divisioncode
	   and itemcode     = :fs_itemcode
		using sqlca;
end if	
if sqlca.sqlcode <> 0 then
	return false
else
	return true
end if	
end function

public function boolean wf_update_tlotno (string fs_areacode, string fs_divisioncode, string fs_itemcode, long fl_stockqty);long ll_count
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

select count(*)
  into :ll_count
  from tlotno
 where tracedate    = :ls_close_date
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and lotno        = 'XXXXXX'
	and itemcode     = :fs_itemcode
	and custcode     = 'XXXXXX'
	and shipgubun    = 'X'
	using sqlca;
if ll_count = 0 then
   INSERT INTO TLOTNO  
	           (TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,CustCode,ShipGubun,   
		         ShipUsage,PrdQty,StockQty,ShipQty,LastEmp,LastDate )  
       VALUES (:ls_close_date,:fs_areacode,:fs_divisioncode,'XXXXXX',:fs_itemcode,'XXXXXX','X',
               'X',0,:fl_stockqty,0,'Y',getdate())
		  using sqlca;
else
  update tlotno
     set stockqty = stockqty + :fl_stockqty
   where tracedate    = :ls_close_date
     and areacode     = :fs_areacode
	  and divisioncode = :fs_divisioncode
	  and lotno        = 'XXXXXX'
	  and itemcode     = :fs_itemcode
	  and custcode     = 'XXXXXX'
	  and shipgubun    = 'X'
	using sqlca;
end if
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "tlotno error : " + sqlca.sqlerrtext
	return false
end if
return true
end function

public function boolean wf_update_tshipinv (string fs_shipplandate, string fs_areacode, string fs_divisioncode, string fs_srno, string fs_sendflag, long fl_truckorder, string fs_moverequireno, long fl_truckloadqty);string ls_close_date,ls_sendflag,ls_moverequireno
long ll_seqno,ll_truckloadqty
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
update tshipinv
   set moveconfirmflag = 'Y',
	    sendflag        = :fs_sendflag,
		 moveconfirmdate = :ls_close_date,
		 moveconfirmtime = getdate(),
		 lastdate        = getdate(),
		 lastemp         = 'Y'
 where shipplandate = :fs_shipplandate
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and srno         = :fs_srno
	and truckorder   = :fl_truckorder
	using sqlca;
if sqlca.sqlcode <> 0 then
	return false
else
end if	
select max(seqno)
  into :ll_seqno
  from tshipinv_interface
 where moveconfirmdate = :ls_close_date  
   and moverequireno   = :fs_srno
	and misflag         = 'A'
	using sqlca;
if isnull(ll_seqno) then
	ll_seqno = 0
end if
ll_seqno = ll_seqno + 1
INSERT INTO TSHIPINV_INTERFACE  
          ( MoveConfirmDate,MoveRequireNo,SeqNo,
			   MISFlag,InterfaceFlag,TruckLoadQty,LastEmp,LastDate )  
   VALUES ( :ls_close_date,:fs_srno,:ll_seqno,
	         'A','Y',:fl_truckloadqty,:g_s_empno,getdate() )
	using sqlca;
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "tshipinv_inertface insert error : " + sqlca.sqlerrtext
   return false
end if	
return true
end function

public function boolean wf_save ();boolean lb_commit
long ll_count,i
string ls_confirmflag,ls_moverequireno,ls_srno,ls_shipdate
long ll_totalqty,ll_truckorder
string ls_areacode,ls_divisioncode,ls_itemcode,ls_moveareacode,ls_movedivisioncode,ls_shipplandate
string ls_sendflag
ll_count = dw_sheet.rowcount()
lb_commit = false
FOR i=1 TO ll_count STEP 1
	ls_confirmflag = dw_sheet.object.moveconfirmflag[i]
	if ls_confirmflag = 'Y' then    //이체확정하면
	   uo_status.st_message.text = string(i) + '처리중'
		ls_moverequireno    = dw_sheet.object.moverequireno[i]
		ls_srno             = dw_sheet.object.srno[i]
		ll_totalqty         = dw_sheet.object.totalqty[i]
		ls_divisioncode     = dw_sheet.object.srdivisioncode[i]
      ls_itemcode         = dw_sheet.object.itemcode[i]
      ls_moveareacode     = dw_sheet.object.fromareacode[i]
      ls_movedivisioncode = dw_sheet.object.fromdivisioncode[i]
      ll_truckorder       = dw_sheet.object.truckorder[i]		
      ls_shipplandate     = dw_sheet.object.shipplandate[i]		
		ls_sendflag = 'N'
		dw_2.settransobject(sqlca)
		dw_2.retrieve(is_areacode,ls_divisioncode,ls_moveareacode,ls_movedivisioncode,&
		              ls_shipplandate,ls_srno,ll_truckorder,ls_itemcode,ll_totalqty,g_s_empno) 
      if dw_2.rowcount() <> 1 then
			lb_commit = false
			exit
		end if
		if dw_2.rowcount() = 1 then
			if dw_2.object.error[1] = 0 then
			   ls_sendflag = 'Y'
			end if
		end if
		if dw_2.rowcount() = 1  and dw_2.object.error[1] <> 0 then
			ls_sendflag = 'N'
	      lb_commit = false
			exit
		end if
		if ls_sendflag = 'Y' then
		   if not wf_update_tshipinv(ls_shipplandate,is_areacode,ls_divisioncode,ls_srno,ls_sendflag,ll_truckorder,ls_moverequireno,ll_totalqty) then
			   lb_commit = false
            exit
			else
				lb_commit = true
         end if
	   end if
	end if
NEXT
return lb_commit
end function

on w_piss030u_1.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
this.dw_2=create dw_2
this.st_2=create st_2
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_sheet
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
end on

on w_piss030u_1.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.gb_1)
destroy(this.dw_sheet)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;long ll_count

setpointer(hourglass!)

ll_count = dw_sheet.retrieve(is_applydate,is_applydate1,is_areacode,is_divisioncode)
setpointer(Arrow!)
if ll_count = 0 then
   messagebox("확인","조회된 자료가 없습니다.")
	dw_sheet.reset()
	return
end if	

end event

event ue_save;sqlca.autocommit = false
setpointer(hourglass!)
if wf_save() = true then
	commit using sqlca;
   sqlca.autocommit = true	
	messagebox("확인","확정이 완료 되었습니다.")
else
	rollback using sqlca;
   sqlca.autocommit = true	
	messagebox("확인","확정시 오류가 발생했읍니다.")	
end if;	
postevent('ue_retrieve')
setpointer(arrow!)
end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlca)
dw_2.settransobject(sqlca)
end event

event activate;call super::activate;dw_sheet.settransobject(sqlca)
dw_2.settransobject(sqlca)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss030u_1
end type

type uo_area from u_pisc_select_area within w_piss030u_1
event destroy ( )
integer x = 1317
integer y = 76
integer taborder = 40
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlca)
dw_2.settransobject(sqlca)
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

type uo_division from u_pisc_select_division within w_piss030u_1
event destroy ( )
integer x = 1856
integer y = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlca)
dw_2.settransobject(sqlca)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()

end event

type uo_date from u_pisc_date_applydate within w_piss030u_1
event destroy ( )
integer x = 41
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;is_applydate = is_uo_date

end event

event ue_select;call super::ue_select;if is_applydate <> is_uo_date then
   dw_sheet.reset()
end if
is_applydate = is_uo_date


end event

event ue_losefocus;call super::ue_losefocus;is_applydate = is_uo_date
end event

type gb_1 from groupbox within w_piss030u_1
integer x = 9
integer y = 8
integer width = 2427
integer height = 180
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
borderstyle borderstyle = stylelowered!
end type

type dw_sheet from u_vi_std_datawindow within w_piss030u_1
integer x = 9
integer y = 196
integer width = 3593
integer height = 1692
integer taborder = 11
string dataobject = "d_piss030u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type dw_2 from datawindow within w_piss030u_1
boolean visible = false
integer x = 2254
integer y = 480
integer width = 805
integer height = 432
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss030u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_piss030u_1
integer x = 713
integer y = 88
integer width = 82
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

type uo_1 from u_pisc_date_applydate_1 within w_piss030u_1
integer x = 795
integer y = 84
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;is_applydate1 = is_uo_date
end event

event ue_select;call super::ue_select;is_applydate1 = is_uo_date
end event

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

type cb_1 from commandbutton within w_piss030u_1
boolean visible = false
integer x = 2574
integer y = 48
integer width = 503
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "이체자료작성"
end type

event clicked;string ls_areacode,ls_divisioncode,ls_moverequireno,ls_srno,ls_moveareacode,ls_movedivisioncode,ls_truckno,ls_shipdate,ls_shipgubun,ls_itemcode,ls_custcode
string ls_applyfrom
long   ll_shiporderqty,ll_shipqty,ll_truckorder,ll_cnt,ll_shipeditno
datetime ldt_lastdate
boolean lb_commit
sqlca.autocommit = false
DECLARE tshipsheet_cur CURSOR FOR
 SELECT a.areacode,a.divisioncode,b.moverequireno,a.srno,b.shipeditno,
        a.truckorder,b.moveareacode,b.movedivisioncode,a.truckno,b.applyfrom,
		  a.shipdate,b.shipgubun,b.itemcode,a.custcode,b.shiporderqty,
        a.shipqty,a.lastdate
	FROM tshipsheet a,tsrorder b
  WHERE a.areacode = :is_areacode
    and a.divisioncode like :is_divisioncode
	 and substring(a.shipsheetno,3,1) = 'M'
    and a.srno = b.srno
	 using sqlca;
open tshipsheet_cur;	 
fetch tshipsheet_cur into :ls_areacode,:ls_divisioncode,:ls_moverequireno,:ls_srno,:ll_shipeditno,
        :ll_truckorder,:ls_moveareacode,:ls_movedivisioncode,:ls_truckno,:ls_applyfrom,
		  :ls_shipdate,:ls_shipgubun,:ls_itemcode,:ls_custcode,:ll_shiporderqty,
        :ll_shipqty,:ldt_lastdate;

DO WHILE sqlca.sqlcode <> 100 
	ll_cnt = ll_cnt + 1
	uo_status.st_message.text = string(ll_cnt)
	  INSERT INTO TSHIPINV  
         ( ShipPlanDate,   
           AreaCode,   
           DivisionCode,   
           MoveRequireNo,   
           SRNo,   
           TruckOrder,   
           FromAreaCode,   
           FromDivisionCode,   
           TruckNo,   
           ShipDate,   
           ShipGubun,   
           ItemCode,   
           CustCode,   
           ShipEditNo,   
           ApplyFrom,   
           ShipOrderQty,   
           TruckLoadQty,   
           TruckDansuQty,   
           TruckModifyFlag,   
           MoveConfirmFlag,   
           MoveConfirmDate,   
           MoveConfirmTime,   
           SendFlag,   
           LastEmp,   
           LastDate )  
  VALUES ( :ls_shipdate,   
           :ls_areacode,   
           :ls_divisioncode,   
           :ls_moverequireno,   
           :ls_srno,   
           :ll_truckorder,   
           :ls_moveareacode,   
           :ls_movedivisioncode,   
           :ls_truckno,   
           :ls_shipdate,   
           :ls_shipgubun,   
           :ls_itemcode,   
           :ls_custcode,   
           :ll_shipeditno,   
           :ls_applyfrom,   
           :ll_shiporderqty,   
           :ll_shipqty,   
           0,   
           'N',   
           'Y',   
           null,   
           null,   
           'N',   
           'Y',   
           :ldt_lastdate )  ;
	if sqlca.sqlcode <> 0 then
		lb_commit = false
		exit;
   else
		lb_commit = true
	end if
   fetch tshipsheet_cur into :ls_areacode,:ls_divisioncode,:ls_moverequireno,:ls_srno,:ll_shipeditno,
        :ll_truckorder,:ls_moveareacode,:ls_movedivisioncode,:ls_truckno,:ls_applyfrom,
		  :ls_shipdate,:ls_shipgubun,:ls_itemcode,:ls_custcode,:ll_shiporderqty,
        :ll_shipqty,:ldt_lastdate;

LOOP

close tshipsheet_cur;	 
if lb_commit = true then
	commit using sqlca;
	sqlca.autocommit = true
else
	rollback using sqlca;
	sqlca.autocommit = true	
end if	
end event

type cb_2 from commandbutton within w_piss030u_1
boolean visible = false
integer x = 3077
integer y = 48
integer width = 576
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "모품번전표작성"
end type

event clicked;string ls_areacode,ls_divisioncode,ls_srno
long ll_shipqty,ll_shiporderqty
string ls_shipdate,ls_shipsheetno,ls_pcgubun,ls_psrno
string ls_min_srno,ls_parent_srno
long ll_mo_shiporderqty,ll_parent_qty
long ll_count,ll_cnt
boolean lb_commit
sqlca.autocommit = false
DECLARE tshipsheet_cur CURSOR FOR
SELECT a.areacode,a.divisioncode,a.srno,a.shipqty,b.shiporderqty,
       a.shipdate,a.shipsheetno,b.pcgubun,b.psrno
 	FROM tshipsheet a,tsrorder b
  WHERE a.areacode = :is_areacode
    and a.divisioncode like :is_divisioncode
    and a.srno = b.srno
	 and b.kitgubun = 'Y'
	 and b.pcgubun = 'C'
	 using sqlca;
open tshipsheet_cur;	 
fetch tshipsheet_cur into 
:ls_areacode,:ls_divisioncode,:ls_srno,
:ll_shipqty,:ll_shiporderqty,
:ls_shipdate,:ls_shipsheetno,:ls_pcgubun,:ls_psrno;

DO WHILE sqlca.sqlcode <> 100 
	ll_cnt = ll_cnt + 1
	uo_status.st_message.text = string(ll_cnt)
	select min(srno)
	  into :ls_min_srno
	  from tsrorder
	 where psrno = :ls_psrno
	   and pcgubun = 'C'
	 using sqlca;
	if ls_min_srno = ls_srno then
		select shiporderqty
		  into :ll_parent_qty
		  from tsrorder
		  where srno = :ls_psrno
		  using sqlca;
		ll_count      = ll_shiporderqty / ll_parent_qty 
	   ll_parent_qty = ll_shipqty / ll_count
		if right(ls_psrno,3) = 'P00' or right(ls_psrno,3) = 'C00' then
			select top 1 substring(:ls_psrno,1,len(:ls_psrno) - 3) 
			  into :ls_psrno
			  from sysusers
			  using sqlca;
		else
			ls_psrno = ls_psrno
		end if	

      INSERT INTO TSHIPSHEET_INTERFACE  
                ( ShipDate,AreaCode,DivisionCode,SRNo,ShipSheetNo,
					   SeqNo,MISFlag,InterfaceFlag,KITGubun,ShipQty,LastEmp,LastDate)  
         VALUES ( :ls_shipdate,:ls_areacode,:ls_divisioncode,:ls_psrno,:ls_shipsheetno,   
                  1,'A','Y','P',:ll_parent_qty,'ZZZ',getdate() )
				using sqlca;
	  if sqlca.sqlcode <> 0 then
		  lb_commit = false
		  exit;
     else
		  lb_commit = true
	  end if
	end if
   fetch tshipsheet_cur into 
		:ls_areacode,:ls_divisioncode,:ls_srno,
		:ll_shipqty,:ll_shiporderqty,
		:ls_shipdate,:ls_shipsheetno,:ls_pcgubun,:ls_psrno;
LOOP

close tshipsheet_cur;	 
if lb_commit = true then
	commit using sqlca;
	sqlca.autocommit = true
else
	rollback using sqlca;
	sqlca.autocommit = true	
end if	
end event

