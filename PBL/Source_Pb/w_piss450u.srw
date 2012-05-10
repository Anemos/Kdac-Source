$PBExportHeader$w_piss450u.srw
$PBExportComments$사내출하 및 반납 삭제(미사용)
forward
global type w_piss450u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss450u
end type
type uo_division from u_pisc_select_division within w_piss450u
end type
type uo_date from u_pisc_date_applydate within w_piss450u
end type
type gb_1 from groupbox within w_piss450u
end type
type dw_sheet from datawindow within w_piss450u
end type
type dw_2 from datawindow within w_piss450u
end type
type rb_1 from radiobutton within w_piss450u
end type
type rb_2 from radiobutton within w_piss450u
end type
end forward

global type w_piss450u from w_ipis_sheet01
integer width = 4517
integer height = 2752
string title = "제품입고취소정보삭제"
uo_area uo_area
uo_division uo_division
uo_date uo_date
gb_1 gb_1
dw_sheet dw_sheet
dw_2 dw_2
rb_1 rb_1
rb_2 rb_2
end type
global w_piss450u w_piss450u

type variables
string is_kbno
string is_areacode,is_divisioncode,is_prddate,is_itemcode,is_productgroup
long  il_qty
end variables

forward prototypes
public function boolean wf_save ()
public function boolean wf_delete_tshipetc ()
end prototypes

public function boolean wf_save ();dw_2.accepttext()
string ls_areacode,ls_divisioncode,ls_proofno,ls_inputdate,ls_itemcode,ls_inputflag,ls_invgubunflag
long ll_etcqty,ll_count,ll_invqty,ll_repairqty,ll_defectqty

ll_etcqty     = dw_2.object.etcqty[1]
ls_inputflag    = dw_2.object.inputflag[1]
ls_areacode     = dw_2.object.areacode[1]
ls_divisioncode = dw_2.object.divisioncode[1]
ls_itemcode     = dw_2.object.itemcode[1]
ll_invqty    = 0
ll_repairqty = 0
ll_defectqty = 0
if ls_invgubunflag = 'N' then  //정품
   ll_invqty = ll_etcqty
elseif ls_invgubunflag = 'R' then  //요수리
	    ll_repairqty = ll_etcqty
else		 
	ll_defectqty = ll_etcqty
end if	

if ls_inputflag = '2' then //반납
	ll_invqty = ll_invqty * -1
	ll_repairqty = ll_repairqty * -1
	ll_defectqty = ll_defectqty * -1
end if	
//창고 입고시 tinv
if wf_delete_tshipetc() = false then
	messagebox("오류","Tshipetc delete시 오류가 발생하였습니다." + '~r~n' + &
			 "정보시스템으로 연락바랍니다." )		
   Return false
End if
select count(*)
  into :ll_count
  from tinv
 where ItemCode	  = :ls_itemcode
	and areacode     = :ls_areacode
	and divisioncode = :ls_divisioncode
	using sqlpis;
if ll_count > 0 then
	Update tinv
		set Invqty	 = invqty	  + :ll_invqty,
		    repairqty = repairqty + :ll_repairqty,
			 defectqty = defectqty + :ll_defectqty,
			 LastEmp  = :g_s_empno,
			 LastDate = GetDate()
	 where ItemCode	  = :ls_itemcode
		and areacode     = :ls_areacode
		and divisioncode = :ls_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty, repairqty,defectqty,Lastemp, lastDate)
			Values(:ls_areacode,:ls_divisioncode,:ls_itemcode, &
					 :ll_invqty,:ll_repairqty,:ll_defectqty, :g_s_empno, Getdate())
	using sqlpis;
end if
if sqlpis.sqlcode = 0 then
Else
	messagebox("오류","TINV insert시 오류가 발생하였습니다." + '~r~n' + &
			 "정보시스템으로 연락바랍니다. : " + sqlpis.sqlerrtext )		
	Return false
End if
return true
end function

public function boolean wf_delete_tshipetc ();string ls_proofno,ls_areacode,ls_divisioncode,ls_inputdate

ls_proofno      = dw_2.object.proofno[1]
ls_inputdate    = dw_2.object.inputdate[1]
ls_areacode     = dw_2.object.areacode[1]
ls_divisioncode = dw_2.object.divisioncode[1]
delete from  TSHIPETC  
where areacode     = :ls_areacode
  and divisioncode = :ls_divisioncode
  and inputdate    = :ls_inputdate
  and proofno      = :ls_proofno
  using sqlpis;
if sqlpis.sqlcode <> 0 then
	messagebox("오류","tshipetc delete : " + sqlpis.sqlerrtext)
	return false
else
	return true
end if	
end function

on w_piss450u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
this.dw_2=create dw_2
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_sheet
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
end on

on w_piss450u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.gb_1)
destroy(this.dw_sheet)
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)

end event

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_sheet, FULL)
//
//of_resize()
//
end event

event ue_retrieve;dw_2.reset()
long ll_count
string ls_inputflag
if rb_1.checked then
	ls_inputflag = '1'
else
	ls_inputflag = '2'
end if	
setpointer(hourglass!)
ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_prddate,ls_inputflag)
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	uo_date.setfocus()
	return
end if	
end event

event ue_save;int net
dw_2.accepttext()
if dw_2.rowcount() = 0 then
	return
end if	
sqlpis.autocommit = false
if wf_save() then
   commit using sqlpis;
else
   rollback using sqlpis;
end if

sqlpis.autocommit = true

postevent('ue_retrieve')
end event

event ue_insert;call super::ue_insert;dw_sheet.reset()
dw_sheet.setfocus()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss450u
integer x = 325
integer y = 2568
end type

type uo_area from u_pisc_select_area within w_piss450u
integer x = 795
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
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

type uo_division from u_pisc_select_division within w_piss450u
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
dw_2.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode

end event

type uo_date from u_pisc_date_applydate within w_piss450u
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

type gb_1 from groupbox within w_piss450u
integer x = 23
integer y = 28
integer width = 2551
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

type dw_sheet from datawindow within w_piss450u
integer x = 41
integer y = 220
integer width = 4379
integer height = 1744
integer taborder = 50
string title = "none"
string dataobject = "d_piss450u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_inputdate,ls_proofno,ls_areacode,ls_divisioncode
if row <= 0 then
	return
end if

ls_areacode     = dw_sheet.object.areacode[row]
ls_divisioncode = dw_sheet.object.divisioncode[row]
ls_proofno      = dw_sheet.object.proofno[row]

dw_2.retrieve(ls_areacode,ls_divisioncode,ls_proofno)



end event

type dw_2 from datawindow within w_piss450u
integer x = 539
integer y = 2004
integer width = 3218
integer height = 536
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss450u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_piss450u
integer x = 1993
integer y = 100
integer width = 251
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
string text = "출하"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;rb_2.checked = false
dw_sheet.reset()
dw_2.reset()
end event

type rb_2 from radiobutton within w_piss450u
integer x = 2290
integer y = 100
integer width = 251
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
string text = "반납"
borderstyle borderstyle = stylelowered!
end type

event clicked;rb_1.checked = false
dw_sheet.reset()
dw_2.reset()
end event

