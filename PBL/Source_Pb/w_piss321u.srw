$PBExportHeader$w_piss321u.srw
$PBExportComments$제품입고정보입력(군산용)
forward
global type w_piss321u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss321u
end type
type uo_division from u_pisc_select_division within w_piss321u
end type
type uo_date from u_pisc_date_applydate within w_piss321u
end type
type dw_save from datawindow within w_piss321u
end type
type dw_print from datawindow within w_piss321u
end type
type gb_1 from groupbox within w_piss321u
end type
type dw_sheet from datawindow within w_piss321u
end type
end forward

global type w_piss321u from w_ipis_sheet01
integer width = 4517
string title = "제품입고정보입력"
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_save dw_save
dw_print dw_print
gb_1 gb_1
dw_sheet dw_sheet
end type
global w_piss321u w_piss321u

type variables
string is_kbno
string is_areacode,is_divisioncode,is_prddate,is_itemcode,is_productgroup
long  il_qty
end variables

forward prototypes
public function boolean wf_update_tlotno (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, long fl_stockqty)
public function boolean wf_update_tstock_interface (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_deptcode, string fs_itemcode, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq, long fl_stockqty)
public function boolean wf_update_tstocketc ()
public function boolean wf_errchk (string fs_column)
public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate)
end prototypes

public function boolean wf_update_tlotno (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, long fl_stockqty);long ll_count
select count(*) 
  into :ll_count
  from tlotno
  where tracedate    = :fs_close_date
    and areacode     = :fs_areacode
	 and divisioncode = :fs_divisioncode
	 and lotno        = :fs_lotno
	 and itemcode     = :fs_itemcode
	 and custcode     = 'XXXXXX'
	 and shipgubun    = 'X'
	 using sqlpis;
if isnull(ll_count)	 then
	ll_count = 0
end if	
if ll_count = 0 then
  INSERT INTO TLOTNO  
         ( TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,custcode,shipgubun,
           shipusage,PrdQty,StockQty,ShipQty,
           LastEmp,LastDate )  
  VALUES ( :fs_close_date,:fs_areacode,:fs_divisioncode,:fs_lotno,:fs_itemcode,'XXXXXX','X',
           'X',0,:fl_stockqty,0,   
           'Y',getdate() ) 
	  using sqlpis;
else			  
	update tlotno
	   set stockqty     = stockqty + :fl_stockqty,
		    lastemp      = 'Y',
			 lastdate     = getdate()
    where tracedate    = :fs_close_date
      and areacode     = :fs_areacode
	   and divisioncode = :fs_divisioncode
	   and lotno        = :fs_lotno
	   and itemcode     = :fs_itemcode
	   and custcode     = 'XXXXXX'
	   and shipgubun    = 'X'
	 using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tlotno error"
	return false
end if
return true

end function

public function boolean wf_update_tstock_interface (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_deptcode, string fs_itemcode, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq, long fl_stockqty);long ll_seqno
select max(seqno)
   into :ll_seqno
	from tstock_interface
	where kbno = :fs_kbno
	  and kbreleasedate = :fs_kbreleasedate
	  and kbreleaseseq  = :fl_kbreleaseseq
	  using sqlpis;
	  
if isnull(ll_seqno) then	  
	ll_seqno = 0
end if

ll_seqno = ll_seqno + 1

INSERT INTO Tstock_interface  
		( kbno,kbreleasedate,kbreleaseseq,seqno,
		  stockdate,areacode,divisioncode,workcenter,linecode,ItemCode,
		  stockQty,misflag,interfaceflag,LastEmp,LastDate )  
VALUES (:fs_kbno,:fs_kbreleasedate,:fl_kbreleaseseq,:ll_seqno,
        :fs_close_date,:fs_areacode,:fs_divisioncode,:fs_deptcode,'X',:fs_itemcode,
		  :fl_stockqty,'A','Y',:g_s_empno,getdate() )  
  using sqlpis;

if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tstock_interface error"
	return false
end if

return true

end function

public function boolean wf_update_tstocketc ();string ls_proofno,ls_deptcode,ls_itemcode,ls_proofno_seq,ls_year,ls_month
long ll_inputqty
string ls_close_date
ls_close_date = f_piss_getdate_close(is_areacode,is_divisioncode)

select max(substring(proofno,8,4))
  into :ls_proofno
  from tstocketc
  where areacode = :is_areacode
    and divisioncode = :is_divisioncode
	 and inputdate like substring(:ls_close_date,1,7) + '%'
    using sqlpis;
if ls_proofno = '' or isnull(ls_proofno) then
	ls_proofno_seq = 'Z000'
else
	ls_proofno_seq	= 'Z'+right(ls_proofno,3)
end if
ls_year = mid(ls_close_date,4,1) 
ls_month = mid(ls_close_date,6,2)		

f_pisc_get_string_add(ls_proofno_seq,ls_proofno_seq)

ls_proofno = is_areacode + is_divisioncode + is_productgroup + ls_year + ls_month  + ls_proofno_seq
dw_sheet.object.proofno[1] = ls_proofno
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ll_inputqty = dw_sheet.object.inputqty[1]
  INSERT INTO TSTOCKETC  
         ( AreaCode,   
           DivisionCode,   
           InputDate,   
           InputFlag,   
           ProofNo,   
           DeptCode,   
           ItemCode,   
           InputQty,   
           LastEmp,   
           LastDate )  
  VALUES ( :is_areacode,   
           :is_divisioncode,   
           :ls_close_date,   
           '1',   
           :ls_proofno,   
           :ls_deptcode,   
           :ls_itemcode,   
           :ll_inputqty,   
           'Y',   
           getdate() )  
			  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "stocketc error"
	return false
else
	return true
end if	
end function

public function boolean wf_errchk (string fs_column);string ls_deptcode,ls_deptname,ls_itemcode,ls_itemname,ls_itemspec,ls_itemtype,ls_item_check
long ll_inputqty,ll_count,ll_unitcost

ll_inputqty = dw_sheet.object.inputqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
CHOOSE CASE fs_column
	CASE 'deptcode'
		  select deptname
		    into :ls_deptname
			 from tmstdept
  		   where deptcode = :ls_deptcode
			using sqlpis;
		  if ls_deptname = '' or isnull(ls_deptname) then
			  messagebox("확인","미등록된 부서입니다.")
			  dw_sheet.object.deptcode[1] = ''
			  dw_sheet.object.deptname[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('deptcode')
			  return false
		  end if
		  dw_sheet.object.deptname[1] = ls_deptname
	CASE 'itemcode'
		  select itemname,itemspec
		    into :ls_itemname,:ls_itemspec
			 from tmstitem
			where itemcode = :ls_itemcode
//			  and areacode = :is_areacode
//			  and divisioncode = :is_divisioncode
			using sqlpis;
		  if sqlpis.sqlcode <> 0 then
			  messagebox("확인","미등록된 품번입니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  dw_sheet.object.itemname[1] = ls_itemname
		  dw_sheet.object.itemspec[1] = ls_itemspec
		  select top 1 productgroup
		    into :is_productgroup
			 from tmstmodel
			where areacode = :is_areacode
			  and divisioncode = :is_divisioncode
			  and itemcode = :ls_itemcode
			  using sqlpis;
		  if is_productgroup = '' or isnull(is_productgroup) then
			  is_productgroup = '00'
		  end if
		  ls_item_check = f_piss_itemtype_check(is_areacode,is_divisioncode,ls_itemcode)
		  if ls_item_check = 'ERROR' then
			  messagebox("확인","모델이 없는 품번입니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  if ls_item_check = '2' then //단품
			  messagebox("확인","단품은 입력할 수 없습니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
//		  messagebox("is_areacode",is_areacode)
		  if (ls_item_check = '3' or ls_item_check = '5')  and is_areacode <> 'Y' then //반제품 또는 완제품
		     select count(*) 
			    into :ll_count 
				 from tmstbom
				where areacode     = :is_areacode
				  and divisioncode = :is_divisioncode
				  and bompitemno   = :ls_itemcode
				  using sqlpis;
			  if ll_count = 0 then
				  messagebox("확인","BOM에 미등록된 품번입니다.")
				  dw_sheet.object.itemcode[1] = ''
				  dw_sheet.object.itemname[1] = ''
				  dw_sheet.object.itemspec[1] = ''
				  dw_sheet.setfocus()
				  dw_sheet.setcolumn('itemcode')
				  return false
			  end if
		     select unitcost 
			    into :ll_unitcost 
				 from tmstitemcost
				where areacode = :is_areacode
				  and divisioncode = :is_divisioncode
				  and itemcode = :ls_itemcode
				  using sqlpis;
			  if (ll_unitcost = 0) or isnull(ll_unitcost) then
				  messagebox("확인","단가가 없는 품번입니다.")
				  dw_sheet.object.itemcode[1] = ''
				  dw_sheet.object.itemname[1] = ''
				  dw_sheet.object.itemspec[1] = ''
				  dw_sheet.setfocus()
				  dw_sheet.setcolumn('itemcode')
				  return false
			  end if
		end if			     
	CASE 'inputqty'
		  if isnull(ll_inputqty) or ll_inputqty = 0 then
			  messagebox("확인","수량을 입력하세요.")
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('inputqty')
			  return false
		  end if
END CHOOSE


return true
end function

public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate);dw_sheet.accepttext()
string ls_kbno,ls_temp_kbno,ls_temp_seqno,ls_deptcode,ls_productgroup,ls_itemcode,ls_proofno
long ll_inputqty,ll_count
string ls_close_date,ls_apply_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_apply_date = f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())

ll_inputqty = dw_sheet.object.inputqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]

//창고 입고시 tinv
if wf_update_tstocketc() = false then
	uo_status.st_message.text = "Tstocketc insert시 오류가 발생하였습니다."
   Return false
End if
select count(*)
  into :ll_count
  from tinv
 where ItemCode		= :ls_itemcode
	and areacode    = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if ll_count > 0 then
	Update tinv
		set Invqty	 = invqty	+ :ll_inputqty,
			 LastEmp	 = 'Y',
			 LastDate = GetDate()
	 where ItemCode	  = :ls_itemcode
		and areacode     = :fs_areacode
		and divisioncode = :fs_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty, Lastemp, lastDate)
			Values(:fs_areacode,:fs_divisioncode,:ls_itemcode, &
					 :ll_inputqty, 'Y', Getdate())
	using sqlpis;
end if

if sqlpis.sqlcode = 0 then
Else
	uo_status.st_message.text = "Tinv insert시 오류가 발생하였습니다."
	Return false
End if

if not wf_update_tlotno(ls_close_date,is_areacode,is_divisioncode,'XXXXXX',ls_itemcode,ll_inputqty) then
	uo_status.st_message.text = "Tlotno insert시 오류가 발생하였습니다."
	return false
end if	

dw_sheet.accepttext()
ls_proofno = dw_sheet.object.proofno[1]
if not wf_update_tstock_interface(ls_close_date,is_areacode,is_divisioncode,ls_deptcode,ls_itemcode,ls_proofno,ls_apply_date,1,ll_inputqty) then
	uo_status.st_message.text = "Tstock_interface insert시 오류가 발생하였습니다."
	return false
end if	

return true
end function

on w_piss321u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_save=create dw_save
this.dw_print=create dw_print
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_save
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_sheet
end on

on w_piss321u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_save)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.dw_sheet)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

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

event ue_save;string ls_proofno,ls_deptcode,ls_itemcode
int net
long ll_inputqty
dw_sheet.accepttext()
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
if mid(is_prddate,1,7) <> mid(ls_close_date,1,7) then
	messagebox("확인","이미 마감된 월입니다.")
	return
end if	
ll_inputqty = dw_sheet.object.inputqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
if ls_deptcode = '' or isnull(ls_deptcode) then
   messagebox("확인","부서를 입력하세요.")
   dw_sheet.setfocus()
   dw_sheet.setcolumn('deptcode')
   return 
end if
if ls_itemcode = '' or isnull(ls_itemcode) then
   messagebox("확인","품번을 입력하세요.")
   dw_sheet.setfocus()
   dw_sheet.setcolumn('itemcode')
   return 
end if
if ll_inputqty = 0  then
   messagebox("확인","수량을 입력하세요.")
   dw_sheet.setfocus()
   dw_sheet.setcolumn('inputqty')
   return 
end if

sqlpis.autocommit = false
if wf_save(is_areacode,is_divisioncode,is_kbno) then
   commit using sqlpis;
   sqlpis.autocommit = true
	ls_proofno = dw_sheet.object.proofno[1]
	messagebox("확인",'증빙서 번호 : ' + mid(ls_proofno,1,4) + '-' + mid(ls_proofno,5,3) + '-' + right(ls_proofno,4))
else
   rollback using sqlpis;
   sqlpis.autocommit = true
end if

dw_sheet.reset()
dw_sheet.insertrow(0)
dw_sheet.setfocus()
dw_sheet.setcolumn('deptcode')
end event

event ue_postopen;call super::ue_postopen;dw_save.settransobject(sqlpis)
dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
dw_sheet.setfocus()
end event

event ue_insert;call super::ue_insert;dw_sheet.reset()
dw_sheet.setfocus()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss321u
end type

type uo_area from u_pisc_select_area within w_piss321u
integer x = 795
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
dw_sheet.setfocus()
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

type uo_division from u_pisc_select_division within w_piss321u
integer x = 1367
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
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
dw_sheet.setfocus()
end event

type uo_date from u_pisc_date_applydate within w_piss321u
integer x = 55
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;is_prddate = is_uo_date
end event

event ue_select;call super::ue_select;if is_prddate <> is_uo_date then
	dw_sheet.reset()
end if	
is_prddate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

type dw_save from datawindow within w_piss321u
boolean visible = false
integer x = 2162
integer y = 1052
integer width = 937
integer height = 840
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss321u
boolean visible = false
integer x = 283
integer y = 952
integer width = 2747
integer height = 556
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss310i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss321u
integer x = 32
integer y = 24
integer width = 2016
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

type dw_sheet from datawindow within w_piss321u
integer x = 41
integer y = 220
integer width = 3250
integer height = 1020
integer taborder = 50
string title = "none"
string dataobject = "d_piss320u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;return 1
end event

event itemchanged;this.accepttext()
if wf_errchk(dwo.name) = false then
    return 1
end if	 
end event

