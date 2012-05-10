$PBExportHeader$w_piss280u.srw
$PBExportComments$편수마스타관리
forward
global type w_piss280u from w_ipis_sheet01
end type
type dw_srorder from u_vi_std_datawindow within w_piss280u
end type
type st_4 from statictext within w_piss280u
end type
type uo_scustgubun from u_pisc_select_code within w_piss280u
end type
type uo_custcode from u_piss_select_custcode within w_piss280u
end type
type uo_division from u_pisc_select_division within w_piss280u
end type
type uo_area from u_pisc_select_area within w_piss280u
end type
type gb_1 from groupbox within w_piss280u
end type
end forward

global type w_piss280u from w_ipis_sheet01
integer width = 4567
string title = "편수마스타관리"
event ue_postopen ( )
dw_srorder dw_srorder
st_4 st_4
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
uo_division uo_division
uo_area uo_area
gb_1 gb_1
end type
global w_piss280u w_piss280u

type variables
string is_date, is_today
boolean ib_open

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,is_custgubun,  is_mod[]
string is_shipoemgubun,is_areacode,is_divisioncode
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount)
public function boolean wf_save ()
end prototypes

event ue_postopen;idw_srorder 	= dw_srorder
idw_current		= idw_srorder

iw_this = This
dw_srorder.settransobject(sqlpis)


string ls_codegroup,ls_codegroupname,ls_codename

f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
string ls_custgubun,ls_custname
datawindow ldw_custcode
ldw_custcode = uo_custcode.dw_1
f_piss_retrieve_dddw_custcode(ldw_custcode,is_custgubun,'%',false,is_custcode,ls_custname)
dw_srorder.reset()




end event

public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount);long ll_workspace, ll_width
integer li_i
string ls_position = ''

ll_workspace = (fl_printsize - fl_leftmargin) 

ll_width = ll_workspace / ( fi_modifycount + 1 )

FOR li_i = 1 TO fi_modifycount

	ls_position		= ls_position +&
						"qty"+String(li_i)+"_t.X = '"+ string( fl_startpoint + 5 * (li_i -1) + ll_width * (li_i - 1))+ " ' " + &
						"qty"+String(li_i)+".X = '"+ string( fl_startpoint + 5 * (li_i -1) + ll_width * (li_i - 1))+ " ' "
NEXT


return ls_position
end function

public function boolean wf_save ();long ll_rowcount,ll_shipeditno,i
ll_rowcount = dw_srorder.rowcount()
datetime ldt_shiparrivetime
dw_srorder.accepttext()
delete from tmsteditno 
 where custcode = :is_custcode 
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;
  
FOR i=1 TO ll_rowcount STEP 1
	ldt_shiparrivetime = dw_srorder.object.shiparrivetime[i]
	if right(string(ldt_shiparrivetime),8) <> '00:00:00' then
      INSERT INTO TMSTEDITNO  
         ( areacode,divisioncode,CustCode,   
           ShipEditNo,   
           ApplyFrom,   
           ApplyTo,   
           ShipStartTime,   
           ShipArriveTime,   
           LastEmp,   
           LastDate )  
      VALUES ( :is_areacode,:is_divisioncode,:is_custcode,   
           :i,   
           '0001.01.01',   
           '9999.99.99',   
           :ldt_shiparrivetime,   
           :ldt_shiparrivetime,   
           'Y',   
           getdate() )
			  using sqlpis;
	   if sqlpis.sqlcode <> 0 then
         uo_status.st_message.text = "tmsteditno error : " + sqlpis.sqlerrtext
		   return false
	   end if	
   end if
NEXT
return true
end function

on w_piss280u.create
int iCurrent
call super::create
this.dw_srorder=create dw_srorder
this.st_4=create st_4
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_srorder
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.uo_scustgubun
this.Control[iCurrent+4]=this.uo_custcode
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.uo_area
this.Control[iCurrent+7]=this.gb_1
end on

on w_piss280u.destroy
call super::destroy
destroy(this.dw_srorder)
destroy(this.st_4)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_srorder, FULL)

of_resize()

end event

event ue_retrieve;dw_srorder.retrieve(is_areacode,is_divisioncode,is_custcode)
dw_srorder.setfocus()

end event

event ue_save;call super::ue_save;sqlpis.autocommit = false
if wf_save() then
	commit using sqlpis;
	sqlpis.autocommit = true
	messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	sqlpis.autocommit = true
end if

	
end event

event activate;call super::activate;dw_srorder.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss280u
end type

type dw_srorder from u_vi_std_datawindow within w_piss280u
event dobledclicked pbm_dwnlbuttondblclk
integer x = 18
integer y = 236
integer width = 1134
integer height = 1652
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss280u_01"
boolean vscrollbar = true
end type

event dobledclicked;If row <= 0 then 
	return
ELSE
	ii_selectrow = row
	if dw_srorder.getitemnumber(ii_selectrow, 'minapqty') = 0 then
		return
	else
		is_itemcode = dw_srorder.getitemstring(ii_selectrow, 'itemcode')
		iw_this.TriggerEvent('ue_minap')
	End if
END IF
end event

event clicked;call super::clicked;If row <= 0 then 
	return
ELSE
	ii_selectrow = row
	is_itemcode = dw_srorder.getitemstring(ii_selectrow, 'itemcode')
END IF
end event

type st_4 from statictext within w_piss280u
integer x = 1198
integer y = 96
integer width = 338
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "거래처구분"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_piss280u
integer x = 1550
integer y = 88
integer width = 709
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;string ls_custgubun,ls_custname
datawindow ldw_custcode
ldw_custcode = uo_custcode.dw_1
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(ldw_custcode,is_custgubun,'%',false,is_custcode,ls_custname)
dw_srorder.reset()

end event

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

type uo_custcode from u_piss_select_custcode within w_piss280u
integer x = 2341
integer y = 92
integer taborder = 70
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_srorder.reset()

end event

type uo_division from u_pisc_select_division within w_piss280u
event destroy ( )
integer x = 626
integer y = 92
integer taborder = 50
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_srorder.reset()
is_divisioncode = is_uo_divisioncode
dw_srorder.settransobject(sqlpis)

end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type uo_area from u_pisc_select_area within w_piss280u
event destroy ( )
integer x = 78
integer y = 92
integer taborder = 60
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_srorder.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_srorder.reset()
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

type gb_1 from groupbox within w_piss280u
integer x = 23
integer y = 28
integer width = 3442
integer height = 168
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

