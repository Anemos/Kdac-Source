$PBExportHeader$w_piss500u.srw
$PBExportComments$이체자료전송
forward
global type w_piss500u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss500u
end type
type uo_division from u_pisc_select_division within w_piss500u
end type
type dw_sheet from u_vi_std_datawindow within w_piss500u
end type
type dw_sheet_1 from u_vi_std_datawindow within w_piss500u
end type
type st_v_bar from uo_xc_splitbar within w_piss500u
end type
type gb_1 from groupbox within w_piss500u
end type
end forward

global type w_piss500u from w_ipis_sheet01
integer width = 5143
string title = "입고대기상태조회"
uo_area uo_area
uo_division uo_division
dw_sheet dw_sheet
dw_sheet_1 dw_sheet_1
st_v_bar st_v_bar
gb_1 gb_1
end type
global w_piss500u w_piss500u

type variables
string is_prddate,is_areacode,is_divisioncode
end variables

forward prototypes
public function boolean wf_update_tshipinv ()
end prototypes

public function boolean wf_update_tshipinv ();transaction sqlpis1
long ln_rowcount,i,ln_count
boolean lb_boolean = true
string ls_shipplandate,ls_divisioncode,ls_fromareacode,ls_fromdivisioncode,ls_srno,ls_shipdate,ls_lastemp
long ll_shipqty,ll_truckorder,ll_error,ll_cnt,ll_shipeditno,ll_shiporderqty 
string ls_sendflag,ls_truckno,ls_moveareacode,ls_itemcode,ls_custcode,ls_moverequireno

ln_rowcount = dw_sheet.rowcount()
SQLPIS1 = CREATE transaction
for i = 1 to ln_rowcount step 1
	uo_status.st_message.text = " " + string(i) + ' 번째 저장중'
	ls_shipplandate     = dw_sheet.object.shipplandate[i]
	ls_divisioncode     = dw_sheet.object.divisioncode[i]
	ls_fromareacode     = dw_sheet.object.fromareacode[i]
	ls_fromdivisioncode = dw_sheet.object.fromdivisioncode[i]
	ll_truckorder       = dw_sheet.object.truckorder[i]
	ls_truckno          = dw_sheet.object.truckno[i]
	ls_srno             = dw_sheet.object.srno[i]
	ls_shipdate         = dw_sheet.object.shipdate[i]
	ls_lastemp          = dw_sheet.object.lastemp[i]
	ll_shipqty          = dw_sheet.object.truckloadqty[i]
	ls_custcode         = dw_sheet.object.custcode[i]
	ls_itemcode         = dw_sheet.object.itemcode[i]	
	ll_shipeditno       = dw_sheet.object.shipeditno[i]	
	ll_shiporderqty     = dw_sheet.object.shiporderqty[i]	
	ls_moverequireno    = dw_sheet.object.moverequireno[i]	
	if f_connection_sqlserver_any(ls_fromareacode,ls_fromdivisioncode,sqlpis1) = false then
		continue
	end if
 	sqlpis.autocommit = false
	sqlpis1.autocommit = false
	update tshipinv
		set sendflag        = 'Y',
			 moveconfirmflag = 'Y',
			 moveconfirmdate = null,
			 moveconfirmtime = null,
			 lastemp         = 'Y',
			 lastdate        = getdate()
	 WHERE SHIPPLANDATE = :ls_shipplandate
		and areacode     = :is_areacode
		and divisioncode = :ls_divisioncode
		and srno         = :ls_srno
		and truckorder   = :ll_truckorder
		using sqlpis;
	if sqlpis.sqlnrows < 1 then
		rollback using sqlpis;
		continue
   end if

	update tshipsheet
		set deliveryflag = 'Y'
	where srno = :ls_srno 
	using sqlpis;
	if sqlpis.sqlnrows < 1 then
		rollback using sqlpis;
		continue
	end if
	
	select count(*) into :ln_count from TSHIPINV
	where ShipPlanDate     = :ls_shipplandate
	  and AreaCode         = :ls_fromareacode
	  and divisioncode     = :ls_fromdivisioncode
	  and srno             = :ls_srno
	  and truckorder       = :ll_truckorder
	  and fromareacode     = :is_areacode
	  and fromdivisioncode = :ls_divisioncode
	 using sqlpis1 ;
	if ln_count = 0  then
	  insert into TSHIPINV
				(ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
				FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
				ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
				TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
				SendFlag,LastEmp,LastDate)
			values (:ls_shipplandate,:ls_fromareacode,:ls_fromdivisioncode,:ls_srno,:ll_truckorder,
					  :is_areacode,:ls_divisioncode,:ls_truckno,:ls_shipdate,'M',
					  :ls_itemcode,:ls_custcode,:ll_shipeditno,:ls_shipdate,:ls_moverequireno,:ll_shiporderqty,
					  :ll_shipqty,0,'N','N',null,null,
					  'N','Y',getdate())
	  using sqlpis1 ;
	else
	  update TSHIPINV
		  set truckloadqty 		= :ll_shipqty,
				sendflag        	= 'N',
				moveconfirmflag 	= 'N',
				lastemp      		= 'Y',
				lastdate     		= getdate()
		where ShipPlanDate     	= :ls_shipplandate
		  and AreaCode         	= :ls_fromareacode
		  and divisioncode     	= :ls_fromdivisioncode
		  and srno             	= :ls_srno
		  and truckorder       	= :ll_truckorder
		  and fromareacode     	= :is_areacode
		  and fromdivisioncode 	= :ls_divisioncode
		using sqlpis1 ;
	end if
	if sqlpis1.sqlnrows < 1 then
		rollback using sqlpis1;
		rollback using sqlpis;
		continue
	end if
	commit using sqlpis1;
	commit using sqlpis;
next
sqlpis1.autocommit = true
sqlpis.autocommit = true
disconnect using sqlpis1 ;
destroy sqlpis1 
return lb_boolean
end function

on w_piss500u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_sheet=create dw_sheet
this.dw_sheet_1=create dw_sheet_1
this.st_v_bar=create st_v_bar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_sheet
this.Control[iCurrent+4]=this.dw_sheet_1
this.Control[iCurrent+5]=this.st_v_bar
this.Control[iCurrent+6]=this.gb_1
end on

on w_piss500u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_sheet)
destroy(this.dw_sheet_1)
destroy(this.st_v_bar)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, full)
//of_resize_register(st_v_bar, SPLIT)
//of_resize_register(dw_sheet_1, RIGHT)
//
of_resize()
end event

event ue_retrieve;call super::ue_retrieve;string ls_prddate,ls_areacode,ls_divisioncode
long ll_count

dw_sheet.settransobject(sqlpis)
dw_sheet_1.settransobject(sqlpis)
dw_sheet.reset()
dw_sheet_1.reset()
if dw_sheet.retrieve(is_areacode,is_divisioncode) <= 0 then
	messagebox('조 회' ,'조회할 정보가 없습니다')
	return
end if
dw_sheet_1.retrieve(is_areacode,is_divisioncode)

end event

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_sheet_1.settransobject(sqlpis)


end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_sheet_1.settransobject(sqlpis)


end event

event ue_save;call super::ue_save;setpointer(hourglass!)
//sqlpis.autocommit = false
if wf_update_tshipinv() then
//	commit using sqlpis;
// sqlpis.autocommit = true
	messagebox("확인","저장되었읍니다.")
else
//	rollback using sqlpis;
//	sqlpis.autocommit = true
	messagebox("오류","저장시 에러가 발생했읍니다.")	
end if

setpointer(Arrow!)
postevent('ue_retrieve')
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss500u
end type

type uo_area from u_pisc_select_area within w_piss500u
integer x = 82
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_sheet_1.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_sheet_1.reset()

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

type uo_division from u_pisc_select_division within w_piss500u
integer x = 654
integer y = 100
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode

end event

event ue_select;long l
dw_sheet.settransobject(sqlpis)
dw_sheet_1.settransobject(sqlpis)

is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_sheet_1.reset()
end event

type dw_sheet from u_vi_std_datawindow within w_piss500u
integer x = 27
integer y = 216
integer width = 2459
integer height = 1636
integer taborder = 11
boolean bringtotop = true
string title = "1"
string dataobject = "d_piss500u_01"
boolean vscrollbar = true
end type

type dw_sheet_1 from u_vi_std_datawindow within w_piss500u
boolean visible = false
integer x = 2313
integer y = 216
integer width = 2459
integer height = 1648
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "2"
string dataobject = "d_piss500u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_v_bar from uo_xc_splitbar within w_piss500u
boolean visible = false
integer x = 2126
integer y = 228
integer width = 18
boolean bringtotop = true
integer textsize = -9
end type

event constructor;call super::constructor;of_register(dw_sheet,LEFT)
of_register(dw_sheet_1,RIGHT)
end event

type gb_1 from groupbox within w_piss500u
integer x = 23
integer y = 28
integer width = 1225
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

