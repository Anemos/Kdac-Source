$PBExportHeader$w_piss030u.srw
$PBExportComments$이체확정
forward
global type w_piss030u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss030u
end type
type uo_division from u_pisc_select_division within w_piss030u
end type
type uo_date from u_pisc_date_applydate within w_piss030u
end type
type gb_1 from groupbox within w_piss030u
end type
type dw_sheet from u_vi_std_datawindow within w_piss030u
end type
type st_2 from statictext within w_piss030u
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss030u
end type
end forward

global type w_piss030u from w_ipis_sheet01
string title = "이체확정"
uo_area uo_area
uo_division uo_division
uo_date uo_date
gb_1 gb_1
dw_sheet dw_sheet
st_2 st_2
uo_1 uo_1
end type
global w_piss030u w_piss030u

type variables
string is_applydate,is_applydate1,is_areacode,is_divisioncode
end variables

forward prototypes
public function boolean wf_save ()
public function boolean wf_update_tshipinv (string fs_shipplandate, string fs_areacode, string fs_divisioncode, string fs_srno, string fs_sendflag, long fl_truckorder, string fs_moverequireno, long fl_truckloadqty, string fs_fromareacode, string fs_fromdivisioncode, string fs_itemcode)
end prototypes

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
	   if not wf_update_tshipinv(ls_shipplandate,is_areacode,ls_divisioncode,ls_srno,ls_sendflag,ll_truckorder,ls_moverequireno,ll_totalqty,ls_moveareacode,ls_movedivisioncode,ls_itemcode) then
		   lb_commit = false
         exit
		else
			lb_commit = true
      end if
	end if
NEXT
return lb_commit
end function
public function boolean wf_update_tshipinv (string fs_shipplandate, string fs_areacode, string fs_divisioncode, string fs_srno, string fs_sendflag, long fl_truckorder, string fs_moverequireno, long fl_truckloadqty, string fs_fromareacode, string fs_fromdivisioncode, string fs_itemcode);transaction sqlpis1
string ls_close_date,ls_sendflag,ls_moverequireno
long ll_seqno,ll_truckloadqty
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

SQLPIS1 = CREATE transaction
if f_connection_sqlserver_any(fs_fromareacode,fs_fromdivisioncode,sqlpis1) = false then
	destroy sqlpis1 
	return false
end if
sqlpis.autocommit 	= false
sqlpis1.autocommit 	= false
update tshipinv
   set moveconfirmflag = 'Y',
	    sendflag        = 'Y',
		 moveconfirmdate = :ls_close_date,
		 moveconfirmtime = getdate(),
		 lastdate        = getdate(),
		 lastemp         = 'Y'
 where shipplandate = :fs_shipplandate
   and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	and srno         = :fs_srno
	and truckorder   = :fl_truckorder
	using sqlpis;
if sqlpis.sqlcode <> 0 then
	rollback using sqlpis ;
	rollback using sqlpis1 ;
	sqlpis1.autocommit = true
	sqlpis.autocommit = true
	disconnect using sqlpis1 ;
	destroy sqlpis1 
	return false
end if	

select max(seqno)
  into :ll_seqno
  from tshipinv_interface
 where moveconfirmdate = :ls_close_date  
   and moverequireno   = :fs_srno
	and misflag         = 'A'
	using sqlpis;
if isnull(ll_seqno) then
	ll_seqno = 0
end if
ll_seqno = ll_seqno + 1
INSERT INTO TSHIPINV_INTERFACE  
          ( MoveConfirmDate,MoveRequireNo,SeqNo,
			   MISFlag,InterfaceFlag,TruckLoadQty,LastEmp,LastDate )  
   VALUES ( :ls_close_date,:fs_srno,:ll_seqno,
	         'A','Y',:fl_truckloadqty,:g_s_empno,getdate() )
	using sqlpis;
if sqlpis.sqlcode <> 0 then
	rollback using sqlpis ;
	rollback using sqlpis1 ;
	sqlpis1.autocommit = true
	sqlpis.autocommit = true
	disconnect using sqlpis1 ;
	destroy sqlpis1 
	return false
end if	

update TINV
	set moveinvqty 	= moveinvqty - :fl_truckloadqty,
		 lastdate     	= getdate(),
		 lastemp      	= 'Y'       
where AreaCode     	= :fs_fromareacode
and divisioncode 		= :fs_fromdivisioncode
and itemcode     		= :fs_itemcode
using sqlpis1 ;
if sqlpis1.sqlnrows < 1 then
	rollback using sqlpis ;
	rollback using sqlpis1 ;
	sqlpis1.autocommit = true
	sqlpis.autocommit = true
	disconnect using sqlpis1 ;
	destroy sqlpis1 
	return false
end if	

update TSHIPINV
	set moveconfirmdate = convert(char(10),getdate(),102),
		 moveconfirmtime = getdate(),
		 lastdate        = getdate(),
		 lastemp        = 'Y'
where ShipPlanDate   = :fs_shipplandate
and AreaCode         = :fs_fromareacode
and divisioncode     = :fs_fromdivisioncode
and srno             = :fs_srno
and truckorder       = :fl_truckorder
and fromareacode     = :fs_areacode
and fromdivisioncode = :fs_divisioncode
using sqlpis1 ;
if sqlpis1.sqlnrows < 1 then
	rollback using sqlpis ;
	rollback using sqlpis1 ;
	sqlpis1.autocommit = true
	sqlpis.autocommit = true
	disconnect using sqlpis1 ;
	destroy sqlpis1 
	return false
end if	

commit using sqlpis  ;
commit using sqlpis1 ;
sqlpis1.autocommit = true
sqlpis.autocommit = true
disconnect using sqlpis1 ;
destroy sqlpis1 
return true
end function
on w_piss030u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
this.st_2=create st_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_sheet
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_1
end on

on w_piss030u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.gb_1)
destroy(this.dw_sheet)
destroy(this.st_2)
destroy(this.uo_1)
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

event ue_save;//sqlpis.autocommit = false
setpointer(hourglass!)
if wf_save() = true then
//	commit using sqlpis;
// sqlpis.autocommit = true	
	messagebox("확인","확정이 완료 되었습니다.")
else
//	rollback using sqlpis;
// sqlpis.autocommit = true	
	messagebox("확인","확정시 오류가 발생했읍니다.")	
end if;	
postevent('ue_retrieve')
setpointer(arrow!)
end event
event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss030u
end type

type uo_area from u_pisc_select_area within w_piss030u
event destroy ( )
integer x = 1317
integer y = 76
integer taborder = 40
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

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
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss030u
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

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()

end event

type uo_date from u_pisc_date_applydate within w_piss030u
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

type gb_1 from groupbox within w_piss030u
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
end type

type dw_sheet from u_vi_std_datawindow within w_piss030u
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

type st_2 from statictext within w_piss030u
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

type uo_1 from u_pisc_date_applydate_1 within w_piss030u
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

