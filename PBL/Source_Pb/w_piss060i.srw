$PBExportHeader$w_piss060i.srw
$PBExportComments$출하요청서
forward
global type w_piss060i from w_ipis_sheet01
end type
type dw_srorder from u_vi_std_datawindow within w_piss060i
end type
type st_4 from statictext within w_piss060i
end type
type st_5 from statictext within w_piss060i
end type
type dw_shiporder from datawindow within w_piss060i
end type
type dw_print from datawindow within w_piss060i
end type
type uo_division from u_pisc_select_division within w_piss060i
end type
type uo_area from u_pisc_select_area within w_piss060i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss060i
end type
type uo_date from u_pisc_date_applydate within w_piss060i
end type
type cb_1 from commandbutton within w_piss060i
end type
type cb_minap from commandbutton within w_piss060i
end type
type cb_3 from commandbutton within w_piss060i
end type
type uo_scustgubun from u_pisc_select_code within w_piss060i
end type
type uo_custcode from u_piss_select_custcode within w_piss060i
end type
type st_6 from statictext within w_piss060i
end type
type gb_1 from groupbox within w_piss060i
end type
type gb_2 from groupbox within w_piss060i
end type
end forward

global type w_piss060i from w_ipis_sheet01
integer width = 4567
string title = "출하요청서"
event ue_postopen ( )
event ue_minap ( )
dw_srorder dw_srorder
st_4 st_4
st_5 st_5
dw_shiporder dw_shiporder
dw_print dw_print
uo_division uo_division
uo_area uo_area
uo_shipoemgubun uo_shipoemgubun
uo_date uo_date
cb_1 cb_1
cb_minap cb_minap
cb_3 cb_3
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
st_6 st_6
gb_1 gb_1
gb_2 gb_2
end type
global w_piss060i w_piss060i

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

event ue_postopen;idw_srorder 	= dw_srorder
idw_current		= idw_srorder

iw_this = This
dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)

string ls_codegroup,ls_codegroupname,ls_codename

f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)


string ls_custgubun,ls_custname
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()

end event

event ue_minap;string ls_parm, ls_itemcode, ls_size

If cb_minap.Enabled Then
	ls_itemcode	= idw_current.GetitemString(ii_selectrow, 'itemcode')

	ls_parm	= is_areacode + is_divisioncode + is_date + ls_itemcode

	OpenWithParm(w_piss080i, ls_parm)
End If
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

on w_piss060i.create
int iCurrent
call super::create
this.dw_srorder=create dw_srorder
this.st_4=create st_4
this.st_5=create st_5
this.dw_shiporder=create dw_shiporder
this.dw_print=create dw_print
this.uo_division=create uo_division
this.uo_area=create uo_area
this.uo_shipoemgubun=create uo_shipoemgubun
this.uo_date=create uo_date
this.cb_1=create cb_1
this.cb_minap=create cb_minap
this.cb_3=create cb_3
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.st_6=create st_6
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_srorder
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.dw_shiporder
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.uo_area
this.Control[iCurrent+8]=this.uo_shipoemgubun
this.Control[iCurrent+9]=this.uo_date
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cb_minap
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.uo_scustgubun
this.Control[iCurrent+14]=this.uo_custcode
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
end on

on w_piss060i.destroy
call super::destroy
destroy(this.dw_srorder)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_shiporder)
destroy(this.dw_print)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.uo_shipoemgubun)
destroy(this.uo_date)
destroy(this.cb_1)
destroy(this.cb_minap)
destroy(this.cb_3)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.st_6)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_srorder, FULL)

of_resize()

end event

event ue_retrieve;Integer	li_no[], li_i , li_count, li_loop, li_j
String 	ls_shipcount[], ls_visible[], ls_shipcounttemp, ls_modstring, ls_shipcountstring, ls_time[], ls_timetemp
Long 		ll_rowcount, ll_selected_row, ll_shipcount

is_date = uo_date.sle_date.text
ll_selected_row = ii_selectrow
ls_modstring = ''
li_i = 1
li_j = 1
li_count = 1
li_loop	= 1

FOR li_loop= 1 TO 25
	ls_shipcount[li_loop]	= ' '
	ls_time[li_loop] = '_____'
	ls_visible[li_loop]	= '0'
	li_count++
NEXT
setpointer(hourglass!)
ll_rowcount =  idw_current.retrieve( is_date, is_areacode,is_divisioncode,is_custcode,is_Shipoemgubun)
ll_shipcount = dw_shiporder.retrieve(is_areacode,is_divisioncode,is_date, is_custcode)
setpointer(arrow!)
If ll_rowcount = 0 THEN
	messagebox('조 회' , mid(is_date, 1, 4) + '년 ' + mid(is_date, 6, 2) + '월 ' + mid(is_date, 9, 2) + '일 ' +&
					'~r~n출하계획이 없습니다.')
ELSE
	For li_i = 1 To 25
		IF li_i <= ll_shipcount Then
			li_no[li_i]			= dw_shiporder.getitemnumber(li_i, 'ShipNo')
			ls_shipcountstring = dw_shiporder.getitemstring(li_i, 'SendTime')			
			ls_visible[li_i]		= '1'
			ls_modstring	= 	ls_modstring + &
								"qty"+String(li_i)+"_t.Text = '" + ls_shipcountstring + " ' " + &
								"qty"+String(li_i)+".Visible = '" + ls_visible[li_i] + "' " + & 								
								"qty"+String(li_i)+"_t.Visible = '" + ls_visible[li_i] + "' " + &
								"tot"+String(li_i)+".Visible = '" + ls_visible[li_i] + "' "							
			li_j = li_j +1								
		Else
			ls_modstring	= 	ls_modstring + &
									"qty"+String(li_i)+".Visible = '" + ls_visible[li_i] + "' " + &
									"qty"+String(li_i)+"_t.Visible = '" + ls_visible[li_i] + "' " + &
									"tot"+String(li_i)+".Visible = '" + ls_visible[li_i] + "' " 
		End if
	Next						
	is_mod1 = ls_modstring
	idw_current.sharedata(dw_print)
	idw_current.Modify(ls_modstring)
	is_mod1 = ls_modstring + wf_print_modify(3355,360000,3355, li_j)		
	If ll_selected_row = 1 Then
		idw_current.Post Event RowFocusChanged(1)			
	End If
END IF
idw_current.SetFocus()
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= 'SR별출하요청서'
lstr_prt.tag			= 'SR별출하요청서'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss060i
end type

type dw_srorder from u_vi_std_datawindow within w_piss060i
event dobledclicked pbm_dwnlbuttondblclk
integer x = 18
integer y = 304
integer width = 4489
integer height = 1584
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss060i_01"
boolean hscrollbar = true
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

type st_4 from statictext within w_piss060i
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

type st_5 from statictext within w_piss060i
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

type dw_shiporder from datawindow within w_piss060i
boolean visible = false
integer x = 1093
integer y = 1188
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss060i_05"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss060i
boolean visible = false
integer x = 1627
integer y = 1020
integer width = 1605
integer height = 784
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss060i_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_division from u_pisc_select_division within w_piss060i
integer x = 1271
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)

is_divisioncode = is_uo_divisioncode
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss060i
integer x = 768
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_srorder.reset()
dw_shiporder.reset()
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

type uo_shipoemgubun from u_pisc_select_code within w_piss060i
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
if is_shipoemgubun = 'X' then //이체
   dw_srorder.dataobject = 'd_piss060i_02'
   dw_print.dataobject = 'd_piss060i_03'
else
	dw_srorder.dataobject = 'd_piss060i_01'
   dw_print.dataobject = 'd_piss060i_04'
	
end if	

idw_srorder 	= dw_srorder
idw_current		= idw_srorder

dw_srorder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_srorder.sharedata(dw_print)
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()
end event

type uo_date from u_pisc_date_applydate within w_piss060i
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
dw_shiporder.reset()
dw_print.reset()
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type cb_1 from commandbutton within w_piss060i
integer x = 3607
integer y = 92
integer width = 288
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일별조회"
end type

event clicked;Long	ll_selected_row

ll_selected_row = idw_srorder.GetSelectedRow(0)
if ll_selected_row = 0 then
	messagebox("확인","데이타를 click후 조회하세요.")
	return
end if	
openwithParm(w_piss070i,is_areacode+is_divisioncode+is_itemcode)
end event

type cb_minap from commandbutton within w_piss060i
integer x = 3899
integer y = 92
integer width = 288
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "미납조회"
end type

event clicked;Long	ll_selected_row

ll_selected_row = idw_srorder.GetSelectedRow(0)

If ll_selected_row > 0 Then
	ii_selectrow	= ll_selected_row
	parent.TriggerEvent('ue_minap')
else
	messagebox("확인","데이타를 click후 조회 하세요.")
	return
END IF
end event

type cb_3 from commandbutton within w_piss060i
boolean visible = false
integer x = 4192
integer y = 92
integer width = 288
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상차계획"
end type

type uo_scustgubun from u_pisc_select_code within w_piss060i
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
f_piss_retrieve_dddw_custcode(ldw_custcode,is_custgubun,'%',false,is_custcode,ls_custname)
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()

end event

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

type uo_custcode from u_piss_select_custcode within w_piss060i
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
dw_shiporder.reset()
dw_print.reset()
end event

type st_6 from statictext within w_piss060i
integer x = 2386
integer y = 192
integer width = 1006
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
string text = "(출하구분 전체선택시 이체 제외)"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss060i
integer x = 23
integer y = 28
integer width = 3419
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
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_piss060i
integer x = 3575
integer y = 24
integer width = 635
integer height = 184
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "버튼정보"
borderstyle borderstyle = stylelowered!
end type

