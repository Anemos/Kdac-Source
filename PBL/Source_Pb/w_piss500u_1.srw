$PBExportHeader$w_piss500u_1.srw
$PBExportComments$이체자료전송(SQLCA)
forward
global type w_piss500u_1 from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss500u_1
end type
type uo_division from u_pisc_select_division within w_piss500u_1
end type
type dw_sheet from u_vi_std_datawindow within w_piss500u_1
end type
type dw_sheet_1 from u_vi_std_datawindow within w_piss500u_1
end type
type dw_2 from datawindow within w_piss500u_1
end type
type st_v_bar from uo_xc_splitbar within w_piss500u_1
end type
type gb_1 from groupbox within w_piss500u_1
end type
end forward

global type w_piss500u_1 from w_ipis_sheet01
integer width = 5143
string title = "입고대기상태조회"
uo_area uo_area
uo_division uo_division
dw_sheet dw_sheet
dw_sheet_1 dw_sheet_1
dw_2 dw_2
st_v_bar st_v_bar
gb_1 gb_1
end type
global w_piss500u_1 w_piss500u_1

type variables
string is_prddate,is_areacode,is_divisioncode
end variables

forward prototypes
public function boolean wf_update_tshipinv ()
end prototypes

public function boolean wf_update_tshipinv ();long ll_count,i
boolean lb_boolean
string ls_shipplandate,ls_divisioncode,ls_fromareacode,ls_fromdivisioncode,ls_srno,ls_shipdate,ls_lastemp
long ll_shipqty,ll_truckorder,ll_error,ll_cnt,l
string ls_sendflag,ls_truckno,ls_moveareacode
ll_count = dw_sheet.rowcount()
lb_boolean = true
for i = 1 to ll_count step 1
	uo_status.st_message.text = string(i)+ '저장중'
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
   ls_sendflag = 'Y'
   dw_2.settransobject(sqlca)
   dw_2.retrieve(ls_shipplandate,is_areacode,ls_divisioncode,ls_srno, + &
	              ll_truckorder,ls_truckno,ls_shipdate,ll_shipqty,ls_lastemp)
   if dw_2.rowcount() <> 1 then
	   ls_sendflag = 'N'	
      lb_boolean = false
		exit
   end if
   ll_error = dw_2.object.error[1]
   if dw_2.object.error[1] <> 0 then
	   ls_sendflag = 'N'
      lb_boolean = false
		exit
   else
   end if

  if ll_error <> 0 then
     lb_boolean = false
	  exit
  end if
   SELECT COUNT(*)
     INTO :ll_cnt
     FROM TSHIPINV 
    WHERE SHIPPLANDATE = :ls_shipplandate
      and areacode     = :is_areacode
	   and divisioncode = :ls_divisioncode
	   and srno         = :ls_srno
	   and truckorder   = :ll_truckorder
	   using sqlca;
   if ll_cnt > 0 then	
		update tshipinv
			set sendflag        = :ls_sendflag,
			    moveconfirmflag = 'Y',
				 lastemp         = 'Y',
				 lastdate        = getdate()
		 WHERE SHIPPLANDATE    = :ls_shipplandate
			and areacode     = :is_areacode
			and divisioncode = :ls_divisioncode
			and srno = :ls_srno
			and truckorder = :ll_truckorder
			using sqlca;
	end if
	if sqlca.sqlcode <> 0 then
		lb_boolean = false
		exit
   end if
next
return lb_boolean
end function

on w_piss500u_1.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_sheet=create dw_sheet
this.dw_sheet_1=create dw_sheet_1
this.dw_2=create dw_2
this.st_v_bar=create st_v_bar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_sheet
this.Control[iCurrent+4]=this.dw_sheet_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_v_bar
this.Control[iCurrent+7]=this.gb_1
end on

on w_piss500u_1.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_sheet)
destroy(this.dw_sheet_1)
destroy(this.dw_2)
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

ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode)
ll_count = dw_sheet_1.retrieve(is_areacode,is_divisioncode)

end event

event ue_postopen;dw_sheet.settransobject(sqlca)
dw_sheet_1.settransobject(sqlca)
dw_2.settransobject(sqlCA)

end event

event activate;call super::activate;dw_sheet.settransobject(sqlca)
dw_sheet_1.settransobject(sqlca)
dw_2.settransobject(sqlCA)

end event

event ue_save;call super::ue_save;setpointer(hourglass!)
sqlca.autocommit = false
if wf_update_tshipinv() then
	commit using sqlca;
   sqlca.autocommit = true
	messagebox("확인","저장되었읍니다.")
else
	rollback using sqlca;
	sqlca.autocommit = true
	messagebox("오류","저장시 에러가 발생했읍니다.")	
end if


setpointer(Arrow!)
postevent('ue_retrieve')
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss500u_1
end type

type uo_area from u_pisc_select_area within w_piss500u_1
integer x = 82
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlca)
dw_sheet_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

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

type uo_division from u_pisc_select_division within w_piss500u_1
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
dw_sheet.settransobject(sqlca)
dw_sheet_1.settransobject(sqlca)
l = dw_2.settransobject(sqlca)
//messagebox("",l)


is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_sheet_1.reset()
end event

type dw_sheet from u_vi_std_datawindow within w_piss500u_1
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

type dw_sheet_1 from u_vi_std_datawindow within w_piss500u_1
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

type dw_2 from datawindow within w_piss500u_1
boolean visible = false
integer x = 2418
integer y = 656
integer width = 411
integer height = 432
integer taborder = 210
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_13"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_v_bar from uo_xc_splitbar within w_piss500u_1
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

type gb_1 from groupbox within w_piss500u_1
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
borderstyle borderstyle = stylelowered!
end type

