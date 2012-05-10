$PBExportHeader$w_piss400u.srw
$PBExportComments$영업현장확인
forward
global type w_piss400u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss400u
end type
type uo_area from u_pisc_select_area within w_piss400u
end type
type uo_division from u_pisc_select_division within w_piss400u
end type
type st_2 from statictext within w_piss400u
end type
type sle_truckno from singlelineedit within w_piss400u
end type
type dw_3 from datawindow within w_piss400u
end type
type st_h_bar from uo_xc_splitbar within w_piss400u
end type
type dw_2 from u_vi_std_datawindow within w_piss400u
end type
type gb_1 from groupbox within w_piss400u
end type
end forward

global type w_piss400u from w_ipis_sheet01
integer width = 4128
string title = "영업현장확인"
boolean minbox = true
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_truckno sle_truckno
dw_3 dw_3
st_h_bar st_h_bar
dw_2 dw_2
gb_1 gb_1
end type
global w_piss400u w_piss400u

type variables
boolean ib_open, ib_change = false
string is_shipsheetno,  is_change = 'NO', is_applydate,is_areacode,is_divisioncode
string is_prddate,is_itemcode
string is_security, is_modelcode, is_kbno, is_asgubun, &
         is_plantcode, is_workcenter, is_shift, is_linecode, &
         is_enddate, is_invdate, is_lotno
integer ii_window_border = 10,il_qty
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,  il_kbloopsn


end variables

forward prototypes
public function boolean wf_update_tshipsheet ()
public function boolean wf_update_tinv ()
end prototypes

public function boolean wf_update_tshipsheet ();long ll_i,ll_rowcount,ll_truckorder
string ls_divisioncode,ls_truckno,ls_shipsheetno,ls_shipdate
boolean lb_commit
long ll_count
ll_rowcount = dw_2.rowcount()

FOR ll_i = 1 TO ll_rowcount
	ll_truckorder	 = dw_2.object.truckorder[ll_i]
	ls_shipsheetno  = dw_2.object.shipsheetno[ll_i]
	ls_shipdate     = dw_2.object.shipdate[ll_i]	
	update tshipsheet
	   set saleconfirmflag = 'Y',
		    saleconfirmdate = getdate(),
			 lastemp = 'Y',
			 lastdate = getdate()
	  where areacode     = :is_areacode
	    and divisioncode = :is_divisioncode
		 and truckorder   = :ll_truckorder
		 and shipsheetno  = :ls_shipsheetno
		 and shipdate     = :ls_shipdate
		 using sqlpis;
	if sqlpis.sqlcode <> 0 then
      uo_status.st_message.text = 'tshipsheet update error(wf_update_tshipsheet)'
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
NEXT

return lb_commit
end function

public function boolean wf_update_tinv ();long ll_i,ll_rowcount,ll_shipqty,ll_count
string ls_divisioncode,ls_itemcode
boolean lb_commit

ll_rowcount = dw_sheet.rowcount()

FOR ll_i = 1 TO ll_rowcount
	ll_shipqty		 = dw_sheet.GetItemNumber(ll_i, 'shipqty')
	ls_itemcode	    = dw_sheet.GetItemString(ll_i, 'itemcode')	
	ls_divisioncode = dw_sheet.GetItemString(ll_i, 'divisioncode')	
	select count(*)
	  into :ll_count
	  from tinv
	  where areacode     = :is_areacode
	    and divisioncode = :ls_divisioncode
		 and itemcode     = :ls_itemcode
		 using sqlpis;
	if ll_count = 0 then
/*		insert into tinv
		    (areacode,divisioncode,itemcode,shipinvqty,lastemp,lastdate)
			values (:is_areacode,:ls_divisioncode,:ls_itemcode,:ll_shipqty * -1,'Y',getdate())
			using sqlpis;
*/			
	else
		update tinv 
		   set shipinvqty = shipinvqty - :ll_shipqty,
			    lastdate   = getdate(),
				 lastemp    = 'Y'
		where areacode = :is_areacode
		  and divisioncode = :ls_divisioncode
		  and itemcode = :ls_itemcode
		  using sqlpis;
	end if
	if sqlpis.sqlcode <> 0 then
      uo_status.st_message.text = 'tinv update error(wf_update_tinv)'
		lb_commit = false
		exit;
	else
		lb_commit = true
   end if	
NEXT

return lb_commit
end function

on w_piss400u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_truckno=create sle_truckno
this.dw_3=create dw_3
this.st_h_bar=create st_h_bar
this.dw_2=create dw_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_truckno
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.gb_1
end on

on w_piss400u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_truckno)
destroy(this.dw_3)
destroy(this.st_h_bar)
destroy(this.dw_2)
destroy(this.gb_1)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_2, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_3, BELOW)

of_resize()
end event

event ue_retrieve;long ll_count
string ls_truckno
setpointer(hourglass!)
ls_truckno = sle_truckno.text
ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,ls_truckno)
ll_count = dw_2.retrieve(is_areacode,is_divisioncode,ls_truckno)

setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	sle_truckno.text = ''
	sle_truckno.setfocus()
end if	

end event

event ue_save;boolean lb_commit
sqlpis.autocommit = false
lb_commit = true
if wf_update_tinv() = false then
   lb_commit = false
else
	lb_commit = true
end if
if lb_commit = true then
   if wf_update_tshipsheet() = false then
      lb_commit = false
	else
		lb_commit = true
   end if
end if	
if lb_commit = true then
	commit using sqlpis;
   SQLpis.AutoCommit	= True	
	messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	SQLpis.AutoCommit	= True
end if

sle_truckno.text = ''
dw_2.reset()
dw_3.reset()
dw_sheet.reset()
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss400u
end type

type dw_sheet from u_vi_std_datawindow within w_piss400u
boolean visible = false
integer x = 2194
integer y = 228
integer width = 1504
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss400u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss400u
integer x = 69
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)

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

type uo_division from u_pisc_select_division within w_piss400u
integer x = 617
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
dw_3.settransobject(sqlpis)

dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type st_2 from statictext within w_piss400u
integer x = 1239
integer y = 104
integer width = 274
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
string text = "차량번호"
boolean focusrectangle = false
end type

type sle_truckno from singlelineedit within w_piss400u
integer x = 1509
integer y = 88
integer width = 512
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_piss400u
integer x = 50
integer y = 1136
integer width = 411
integer height = 712
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss400u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_piss400u
integer x = 50
integer y = 1084
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_2,ABOVE)
of_register(dw_3,BELOW)
end event

type dw_2 from u_vi_std_datawindow within w_piss400u
integer x = 32
integer y = 220
integer height = 828
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_piss400u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then 
	return
end if	
string ls_divisioncode,ls_shipsheetno,ls_shipdate
ls_divisioncode = dw_2.object.divisioncode[row]
ls_shipsheetno  = dw_2.object.shipsheetno[row]
ls_shipdate     = dw_2.object.shipdate[row]

dw_3.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_shipdate)

end event

type gb_1 from groupbox within w_piss400u
integer x = 23
integer y = 28
integer width = 2039
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
borderstyle borderstyle = stylelowered!
end type

