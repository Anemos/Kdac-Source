$PBExportHeader$w_piss901u.srw
$PBExportComments$사내출하 및 반납 지시 입력 ( 여주용 )
forward
global type w_piss901u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss901u
end type
type uo_division from u_pisc_select_division within w_piss901u
end type
type uo_date from u_pisc_date_applydate within w_piss901u
end type
type gb_1 from groupbox within w_piss901u
end type
type dw_sheet from datawindow within w_piss901u
end type
end forward

global type w_piss901u from w_ipis_sheet01
integer width = 4571
integer height = 2356
string title = "제품입고정보입력"
uo_area uo_area
uo_division uo_division
uo_date uo_date
gb_1 gb_1
dw_sheet dw_sheet
end type
global w_piss901u w_piss901u

type variables
string is_kbno
string is_areacode,is_divisioncode,is_prddate,is_itemcode,is_productgroup
long  il_qty
end variables

forward prototypes
public function boolean wf_errchk (string fs_column)
public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate)
public function boolean wf_update_tshipetc_preorder ()
end prototypes

public function boolean wf_errchk (string fs_column);string ls_deptcode,ls_deptname,ls_itemcode,ls_itemname,ls_itemspec,ls_itemtype,ls_item_check
string ls_shipgubun,ls_seqno,ls_confirmno,ls_confirmno1,ls_yymm
long   ll_etcqty,ll_count
string ls_itemclass,ls_itembuysource
string ls_deptshortname4,ls_projectname,ls_projectno
ll_etcqty = dw_sheet.object.etcqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_shipgubun = dw_sheet.object.shipgubun[1]
ls_projectno = dw_sheet.object.projectno[1]

CHOOSE CASE fs_column
	CASE 'deptcode'
		  select deptname,isnull(deptshortname4,'X')
		    into :ls_deptname, :ls_deptshortname4
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
		  if ls_deptshortname4 <> 'D' then  //연구개발이 아니면
     		  dw_sheet.object.projectno[1] = ''
		     dw_sheet.object.projectname[1] = ''
			  dw_sheet.settaborder('projectno',0)
			  dw_sheet.setcolumn('itemcode')
			  dw_sheet.Object.projectno.Protect=1
		  else
//			  dw_sheet.settaborder('projectno',40)
			  dw_sheet.Object.projectno.Protect=0			  
		  end if
	CASE 'projectno'
		  select projectname
		    into :ls_projectname
			 from tmstproject
  		   where projectno = :ls_projectno
			using sqlpis;
		  if ls_projectname = '' or isnull(ls_projectname) then
			  messagebox("확인","미등록된 프로젝트번호입니다.")
			  dw_sheet.object.projectno[1] = ''
			  dw_sheet.object.projectname[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('projectno')
			  return false
		  end if
		  dw_sheet.object.projectname[1] = ls_projectname
	CASE 'itemcode'
		  select itemname,itemspec
		    into :ls_itemname,:ls_itemspec
			 from TMSTITEM
  		   where 
			  itemcode = :ls_itemcode
			  //and areacode = :is_areacode
			  //and divisioncode = :is_divisioncode
			using sqlpis;
		  if sqlpis.sqlcode <> 0 then
			  messagebox("확인","미등록된 품번입니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  dw_sheet.object.itemname[1] = ls_itemname
		  if f_piss_itemtype_check(is_areacode,is_divisioncode,ls_itemcode) = '2' then 
			  messagebox("확인","단품은 입력할 수 없습니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
			
//		  dw_sheet.object.itemspec[1] = ls_itemspec
		  select top 1 productgroup,itemclass,itembuysource
		    into :is_productgroup,:ls_itemclass,:ls_itembuysource
			 from tmstmodel
			where areacode = :is_areacode
			  and divisioncode = :is_divisioncode
			  and itemcode = :ls_itemcode
			  using sqlpis;
		  if is_productgroup = '' or isnull(is_productgroup) then
			  messagebox("확인","모델마스타에 없습니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
  		  if ls_itemclass = '' or isnull(ls_itemclass) then
			  ls_itemclass = ' '
		  end if
		  if ls_itembuysource = '' or isnull(ls_itembuysource) then
			  ls_itembuysource = ' '
		  end if
		  if ls_itemclass = '10' and (ls_itembuysource = '05' or ls_itembuysource = '06') then
			  messagebox("확인","출하할 수 없는 품번입니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if

	CASE 'etcqty'
		  if isnull(ll_etcqty) or ll_etcqty = 0 then
			  messagebox("확인","수량을 입력하세요.")
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('etcqty')
			  return false
		  end if
END CHOOSE

return true
end function

public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate);dw_sheet.accepttext()
	
//창고 입고시 tinv
if wf_update_tshipetc_preorder() = false then
	uo_status.st_message.text = "Tshipetc insert시 오류가 발생하였습니다."
   Return false
End if

return true
end function

public function boolean wf_update_tshipetc_preorder ();string ls_proofno,ls_deptcode,ls_itemcode,ls_proofno_seq,ls_year,ls_month,ls_inputflag,ls_projectno,ls_invgubunflag,ls_reason
string ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun
long ll_etcqty

string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

ls_shipgubun 		= dw_sheet.object.shipgubun[1]
ls_deptcode     	= dw_sheet.object.deptcode[1]
ls_inputflag    	= dw_sheet.object.inputflag[1]
ls_projectno    	= dw_sheet.object.projectno[1]
ls_invgubunflag 	= dw_sheet.object.invgubunflag[1]
ls_reason       	= dw_sheet.object.reason[1]
ls_itemcode     	= dw_sheet.object.itemcode[1]
ll_etcqty       	= dw_sheet.object.etcqty[1]

  INSERT INTO TshipEtc_PreOrder
         ( EtcGubun,
			  AreaCode,   
           DivisionCode,   
           ItemCode,   
           InputDate,   
           DeptCode,   
           ProjectNo,   
           ShipGubun,  
			  InvGubun,
           EtcQty,   
           Reason,  
			  EndGubun,
           LastEmp,   
			  LastDate)  
  VALUES ( :ls_inputflag,
  			  :is_areacode,   
           :is_divisioncode,   
           :ls_itemcode,   
           :ls_close_date,   
           :ls_deptcode,   
           :ls_projectno,   
			  :ls_shipgubun,
			  :ls_invgubunflag,   
           :ll_etcqty,   
           :ls_reason,   
           'N' ,			  
           :g_s_empno,   
			  getdate())
			  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tstocketc_preorder error : " + sqlpis.sqlerrtext
	return false
else
	return true
end if	
end function

on w_piss901u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_sheet
end on

on w_piss901u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.gb_1)
destroy(this.dw_sheet)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)

end event

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_sheet, FULL)
//
//of_resize()
//
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

event ue_save;int net
string ls_proofno
dw_sheet.accepttext()
string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_itemcode,ls_deptcode,ls_temp_kbno
long ll_invqty,ll_etcqty,i,ll_repairqty,ll_defectqty,ll_count,ll_totqty
string ls_projectno,ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun,ls_inputflag
string ls_deptshortname4
if dw_sheet.rowcount() = 0 then
	return 
end if	
ls_inputflag = dw_sheet.object.inputflag[1]
ll_etcqty = dw_sheet.object.etcqty[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_projectno = trim(dw_sheet.object.projectno[1])
ls_shipgubun = trim(dw_sheet.object.shipgubun[1])
ls_confirmno1 = trim(dw_sheet.object.confirmno1[1])
ls_seqno = trim(dw_sheet.object.seqno[1])
ls_yymm = trim(dw_sheet.object.yymm[1])
ls_confirmno = ls_confirmno1 + ls_yymm + ls_seqno
dw_sheet.object.confirmno[1] = ls_confirmno
//if ls_shipgubun = '' or isnull(ls_shipgubun) then
//	messagebox("확인","출하구분을 입력하세요.")
//	dw_sheet.setfocus()
//	dw_sheet.setcolumn('shipgubun')
//	return 
//end if	
if ls_deptcode = '' or isnull(ls_deptcode) then
	messagebox("확인","부서를 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('deptcode')
	return 
end if	
select isnull(deptshortname4,'X')
  into :ls_deptshortname4
  from tmstdept
 where deptcode = :ls_deptcode
 using sqlpis;
if ls_deptshortname4 = 'D' then  //연구개발
	if ls_projectno = '' or isnull(ls_projectno) then
		messagebox("확인","프로젝트번호를 입력하세요.")
		dw_sheet.setfocus()
		dw_sheet.setcolumn('projectno')
		return 
	end if	
end if

if ls_itemcode = '' or isnull(ls_itemcode) then
	messagebox("확인","품번을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('itemcode')
	return 
end if	
if ll_etcqty = 0 or isnull(ll_etcqty) then
	messagebox("확인","수량을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('etcqty')
	return 
end if	
if isnull(ls_deptcode) or ls_deptcode = '' then
	messagebox("확인","부서를 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('deptcode')
	return
end if	
if isnull(ls_itemcode) or ls_itemcode = '' then
	messagebox("확인","품번을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('itemcode')
	return
end if	
if isnull(ll_etcqty) or ll_etcqty <= 0 then
	messagebox("확인","수량을 확인하세요.")
	dw_sheet.object.etcqty[1] = 0
	dw_sheet.setfocus()
	dw_sheet.setcolumn('etcqty')
	return
end if	

sqlpis.autocommit = false
ls_inputflag = dw_sheet.object.inputflag[1]

if wf_save(is_areacode,is_divisioncode,is_kbno) then
   commit using sqlpis;
	sqlpis.autocommit = true
	ls_proofno = dw_sheet.object.confirmno[1]
   messagebox("확인",'증빙서 번호 : ' + mid(ls_proofno,1,3) + '-' + mid(ls_proofno,4,3) + '-' + right(ls_proofno,4))
else
	rollback using sqlpis;
	sqlpis.autocommit = true
end if

dw_sheet.reset()

dw_sheet.setfocus()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('inputflag')





end event

event ue_postopen;call super::ue_postopen;dw_sheet.insertrow(0)
//dw_sheet.setcolumn('shipgubun')
dw_sheet.setfocus()
end event

event ue_insert;call super::ue_insert;dw_sheet.reset()
dw_sheet.setfocus()
dw_sheet.insertrow(0)
//dw_sheet.setcolumn('shipgubun')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss901u
integer y = 2152
end type

type uo_area from u_pisc_select_area within w_piss901u
integer x = 795
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_sheet.insertrow(0)
//dw_sheet.setcolumn('shipgubun')
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

type uo_division from u_pisc_select_division within w_piss901u
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
dw_sheet.reset()
dw_sheet.insertrow(0)
is_divisioncode = is_uo_divisioncode
if dw_sheet.rowcount() > 0 then
	dw_sheet.object.confirmno1[1] = is_areacode + is_divisioncode + dw_sheet.object.shipgubun[1]
end if	
end event

type uo_date from u_pisc_date_applydate within w_piss901u
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
if dw_sheet.rowcount() > 0 then
	dw_sheet.object.confitm1[1] = is_areacode + is_divisioncode + dw_sheet.object.shipgubun[1]
	dw_sheet.object.yymm[1] = mid(is_prddate,4,1) + mid(is_prddate,6,2)
end if	
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

type gb_1 from groupbox within w_piss901u
integer x = 23
integer y = 28
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

type dw_sheet from datawindow within w_piss901u
event ue_post_change ( )
integer x = 32
integer y = 224
integer width = 3067
integer height = 752
integer taborder = 50
string title = "none"
string dataobject = "d_piss901u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
if dwo.name = 'inputflag' then
	postevent('ue_post_change')
end if	

if wf_errchk(dwo.name) = false then
    return 1
end if	 

end event

event itemerror;return 1
end event

event losefocus;dw_sheet.accepttext()
end event

