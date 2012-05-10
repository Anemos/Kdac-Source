$PBExportHeader$w_piss490i.srw
$PBExportComments$월간출하요청현황
forward
global type w_piss490i from w_ipis_sheet01
end type
type dw_srorder from u_vi_std_datawindow within w_piss490i
end type
type uo_division from u_pisc_select_division within w_piss490i
end type
type uo_area from u_pisc_select_area within w_piss490i
end type
type dw_print from datawindow within w_piss490i
end type
type uo_1 from u_pisc_date_scroll_month within w_piss490i
end type
type gb_1 from groupbox within w_piss490i
end type
end forward

global type w_piss490i from w_ipis_sheet01
integer width = 4567
string title = "출하요청서"
event ue_postopen ( )
dw_srorder dw_srorder
uo_division uo_division
uo_area uo_area
dw_print dw_print
uo_1 uo_1
gb_1 gb_1
end type
global w_piss490i w_piss490i

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,is_custgubun,  is_mod[],is_mod1
string is_shipoemgubun,is_areacode,is_divisioncode
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount)
end prototypes

event ue_postopen;string ls_codegroup,ls_codegroupname,ls_codename
string ls_custgubun,ls_custname

dw_srorder.reset()

end event

public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount);long ll_workspace, ll_width
integer li_i
string ls_position = ''

ll_workspace = (fl_printsize - fl_leftmargin) 

ll_width = ll_workspace / ( fi_modifycount + 1 )

FOR li_i = 1 TO fi_modifycount
//						"qty"+String(li_i)+"_t.X = '"+ string( fl_startpoint + 182 * (li_i -1) + ll_width * (li_i - 1))+ " ' " + &
//						"qty"+String(li_i)+".X = '"+ string( fl_startpoint + 182 * (li_i -1) + ll_width * (li_i - 1))+ " ' "   + &

	ls_position		= ls_position +&
						"qty"+String(li_i)+"_t.X = '"+ string( fl_startpoint + li_i + 200 * (li_i - 1) )+ " ' " + &
						"qty"+String(li_i)+".X = '"+ string( fl_startpoint + li_i + 200 * (li_i - 1) )+ " ' "   + &
						"qty"+String(li_i)+"_t.width = '"+ string(200)+ " ' " + &
						"qty"+String(li_i)+".width = '"+ string(200)+ " ' " + &
						"tot"+String(li_i)+".X = '"+ string( fl_startpoint + li_i + 200 * (li_i - 1) )+ " ' " + &
						"tot"+String(li_i)+".width = '"+ string(200)+ " ' "
NEXT


return ls_position
end function

on w_piss490i.create
int iCurrent
call super::create
this.dw_srorder=create dw_srorder
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_print=create dw_print
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_srorder
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.dw_print
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_piss490i.destroy
call super::destroy
destroy(this.dw_srorder)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_print)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event open;call super::open;dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

PostEvent('ue_postopen')
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_srorder, FULL)

of_resize()

end event

event ue_retrieve;long ll_rowcount,li_i
string ls_modstring
string ls_applyfrom
setpointer(hourglass!)
For li_i = 1 To 7
	 select top 1 convert(char(10),dateadd(day,:li_i,:is_date),102)
	   into :ls_applyfrom
		from sysusers
	  using sqlpis;
	 ls_modstring	= 	ls_modstring + &
							"qty"+String(li_i)+"_t.Text = '" + ls_applyfrom + " ' " 
Next						
ll_rowcount =  dw_srorder.retrieve(is_areacode,is_divisioncode,is_date)
setpointer(arrow!)
If ll_rowcount = 0 THEN
	messagebox('조 회' ,'출하계획이 없습니다.')
	return
end if


end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt
dw_srorder.sharedata(dw_print)
//
ls_mod	= "t_msg.Text = '" + "기준월 : " + is_date + "' "
//ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '월간출하요청현황'
lstr_prt.tag			= '월간출하요청현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//
end event

event activate;call super::activate;dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss490i
end type

type dw_srorder from u_vi_std_datawindow within w_piss490i
event dobledclicked pbm_dwnlbuttondblclk
integer x = 18
integer y = 228
integer width = 4489
integer height = 1584
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss490i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
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

type uo_division from u_pisc_select_division within w_piss490i
integer x = 1193
integer y = 104
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_srorder.reset()
dw_print.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss490i
integer x = 690
integer y = 104
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_srorder.reset()
dw_print.reset()
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

type dw_print from datawindow within w_piss490i
boolean visible = false
integer x = 901
integer y = 520
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss490i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from u_pisc_date_scroll_month within w_piss490i
event destroy ( )
integer x = 59
integer y = 104
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_scroll_month::destroy
end on

event constructor;call super::constructor;is_date = is_uo_month
end event

event ue_select;call super::ue_select;is_date = is_uo_month
end event

type gb_1 from groupbox within w_piss490i
integer x = 23
integer y = 28
integer width = 1737
integer height = 184
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

