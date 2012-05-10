$PBExportHeader$w_piss480i.srw
$PBExportComments$일주일간출하요청현황
forward
global type w_piss480i from w_ipis_sheet01
end type
type dw_srorder from u_vi_std_datawindow within w_piss480i
end type
type st_4 from statictext within w_piss480i
end type
type st_5 from statictext within w_piss480i
end type
type uo_division from u_pisc_select_division within w_piss480i
end type
type uo_area from u_pisc_select_area within w_piss480i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss480i
end type
type uo_date from u_pisc_date_applydate within w_piss480i
end type
type uo_scustgubun from u_pisc_select_code within w_piss480i
end type
type uo_custcode from u_piss_select_custcode within w_piss480i
end type
type dw_print from datawindow within w_piss480i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss480i
end type
type pb_excel from picturebutton within w_piss480i
end type
type pb_print from picturebutton within w_piss480i
end type
type gb_1 from groupbox within w_piss480i
end type
end forward

global type w_piss480i from w_ipis_sheet01
integer width = 4567
string title = "일주일간출하요청서"
event ue_postopen ( )
dw_srorder dw_srorder
st_4 st_4
st_5 st_5
uo_division uo_division
uo_area uo_area
uo_shipoemgubun uo_shipoemgubun
uo_date uo_date
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
dw_print dw_print
uo_productgroup uo_productgroup
pb_excel pb_excel
pb_print pb_print
gb_1 gb_1
end type
global w_piss480i w_piss480i

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,is_custgubun,  is_mod[],is_mod1
string is_shipoemgubun,is_areacode,is_divisioncode,is_productgroup
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount)
end prototypes

event ue_postopen;string ls_codegroup,ls_codegroupname,ls_codename,ls_productgroupname

f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',true,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)


string ls_custgubun,ls_custname
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
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

on w_piss480i.create
int iCurrent
call super::create
this.dw_srorder=create dw_srorder
this.st_4=create st_4
this.st_5=create st_5
this.uo_division=create uo_division
this.uo_area=create uo_area
this.uo_shipoemgubun=create uo_shipoemgubun
this.uo_date=create uo_date
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.dw_print=create dw_print
this.uo_productgroup=create uo_productgroup
this.pb_excel=create pb_excel
this.pb_print=create pb_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_srorder
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_shipoemgubun
this.Control[iCurrent+7]=this.uo_date
this.Control[iCurrent+8]=this.uo_scustgubun
this.Control[iCurrent+9]=this.uo_custcode
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.uo_productgroup
this.Control[iCurrent+12]=this.pb_excel
this.Control[iCurrent+13]=this.pb_print
this.Control[iCurrent+14]=this.gb_1
end on

on w_piss480i.destroy
call super::destroy
destroy(this.dw_srorder)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.uo_shipoemgubun)
destroy(this.uo_date)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.dw_print)
destroy(this.uo_productgroup)
destroy(this.pb_excel)
destroy(this.pb_print)
destroy(this.gb_1)
end on

event open;call super::open;idw_srorder 	= dw_srorder
idw_current		= idw_srorder

iw_this = This
dw_srorder.settransobject(sqlpis)

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
is_mod1 = ls_modstring
dw_srorder.modify(ls_modstring)
ll_rowcount =  dw_srorder.retrieve(Is_areacode,is_divisioncode,is_custgubun,is_custcode,is_Shipoemgubun,is_date,is_productgroup)
setpointer(arrow!)
If ll_rowcount = 0 THEN
	messagebox('조 회' ,'출하계획이 없습니다.')
	return
end if
dw_srorder.sharedata(dw_print)
dw_print.modify(ls_modstring)


end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

dw_print.settransobject(sqlpis)
dw_srorder.sharedata(dw_print)

ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '일주일간출하요청서'
lstr_prt.tag			= '일주일간출하요청서'
lstr_prt.dwsyntax		= is_mod1
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//

end event

event activate;call super::activate;dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss480i
end type

type dw_srorder from u_vi_std_datawindow within w_piss480i
event dobledclicked pbm_dwnlbuttondblclk
integer x = 18
integer y = 304
integer width = 4489
integer height = 1584
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss480i_01_rev1"
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

type st_4 from statictext within w_piss480i
integer x = 59
integer y = 192
integer width = 366
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

type st_5 from statictext within w_piss480i
integer x = 2395
integer y = 104
integer width = 270
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
string text = "출하구분"
boolean focusrectangle = false
end type

type uo_division from u_pisc_select_division within w_piss480i
integer x = 1271
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;string ls_productgroupname
dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
dw_srorder.reset()
dw_print.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss480i
integer x = 768
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_productgroupname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
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

type uo_shipoemgubun from u_pisc_select_code within w_piss480i
integer x = 2670
integer y = 92
integer taborder = 60
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_shipoemgubun = is_uo_codeid
if is_shipoemgubun = 'X' then //이체
   dw_srorder.dataobject = 'd_piss050i_02'
   dw_print.dataobject = 'd_piss050i_03'
else
	dw_srorder.dataobject = 'd_piss050i_01'
   dw_print.dataobject = 'd_piss050i_04'
	
end if	

idw_srorder 	= dw_srorder
idw_current		= idw_srorder

dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

event ue_select;call super::ue_select;is_shipoemgubun = is_uo_codeid
dw_srorder.settransobject(sqlpis)
dw_srorder.reset()
dw_print.reset()
end event

type uo_date from u_pisc_date_applydate within w_piss480i
integer x = 59
integer y = 96
integer taborder = 60
boolean bringtotop = true
end type

event constructor;call super::constructor;is_date = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_date = is_uo_date
end event

event ue_select;call super::ue_select;is_date = is_uo_date
dw_srorder.reset()
dw_print.reset()
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_scustgubun from u_pisc_select_code within w_piss480i
integer x = 389
integer y = 184
integer width = 709
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;string ls_custgubun,ls_custname
datawindow ldw_custcode
ldw_custcode = uo_custcode.dw_1
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(ldw_custcode,is_custgubun,'%',true,is_custcode,ls_custname)
dw_srorder.reset()
dw_print.reset()

end event

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

type uo_custcode from u_piss_select_custcode within w_piss480i
integer x = 1179
integer y = 188
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
dw_print.reset()
end event

type dw_print from datawindow within w_piss480i
boolean visible = false
integer x = 814
integer y = 488
integer width = 1609
integer height = 1164
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss480i_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_productgroup from u_pisc_select_productgroup within w_piss480i
integer x = 2437
integer y = 180
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;call super::ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup

end event

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

type pb_excel from picturebutton within w_piss480i
integer x = 4375
integer y = 136
integer width = 155
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_srorder.rowcount() > 0 then
	f_save_to_excel_execute(dw_srorder,'2')
end if
end event

type pb_print from picturebutton within w_piss480i
integer x = 4215
integer y = 136
integer width = 155
integer height = 132
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;parent.triggerevent("ue_print")
end event

type gb_1 from groupbox within w_piss480i
integer x = 23
integer y = 28
integer width = 4517
integer height = 256
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

