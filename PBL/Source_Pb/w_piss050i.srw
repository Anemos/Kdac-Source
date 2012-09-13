$PBExportHeader$w_piss050i.srw
$PBExportComments$SR별출하요청서
forward
global type w_piss050i from w_ipis_sheet01
end type
type dw_srorder from u_vi_std_datawindow within w_piss050i
end type
type st_5 from statictext within w_piss050i
end type
type dw_shiporder from datawindow within w_piss050i
end type
type uo_division from u_pisc_select_division within w_piss050i
end type
type uo_area from u_pisc_select_area within w_piss050i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss050i
end type
type uo_date from u_pisc_date_applydate within w_piss050i
end type
type st_8 from statictext within w_piss050i
end type
type uo_scustgubun from u_pisc_select_code within w_piss050i
end type
type uo_custcode from u_piss_select_custcode within w_piss050i
end type
type st_6 from statictext within w_piss050i
end type
type gb_1 from groupbox within w_piss050i
end type
type dw_print from datawindow within w_piss050i
end type
type st_7 from statictext within w_piss050i
end type
type sle_checksrno from singlelineedit within w_piss050i
end type
end forward

global type w_piss050i from w_ipis_sheet01
integer width = 4517
integer height = 2700
string title = "SR별출하요청서"
event ue_postopen ( )
dw_srorder dw_srorder
st_5 st_5
dw_shiporder dw_shiporder
uo_division uo_division
uo_area uo_area
uo_shipoemgubun uo_shipoemgubun
uo_date uo_date
st_8 st_8
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
st_6 st_6
gb_1 gb_1
dw_print dw_print
st_7 st_7
sle_checksrno sle_checksrno
end type
global w_piss050i w_piss050i

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname,is_mod1

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,  is_mod[],is_custgubun
string is_shipoemgubun,is_areacode,is_divisioncode,is_divisionname
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function string wf_print_modify (long fl_leftmargin, long fl_printsize, long fl_startpoint, integer fi_modifycount)
end prototypes

event ue_postopen;string ls_codegroup,ls_codegroupname,ls_codename,ls_divisionname,ls_divisionnameeng
string ls_custgubun,ls_custname

idw_srorder 	= dw_srorder
idw_current		= idw_srorder

iw_this = This
dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',FALSE,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',TRUE,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()

ib_open = true
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

on w_piss050i.create
int iCurrent
call super::create
this.dw_srorder=create dw_srorder
this.st_5=create st_5
this.dw_shiporder=create dw_shiporder
this.uo_division=create uo_division
this.uo_area=create uo_area
this.uo_shipoemgubun=create uo_shipoemgubun
this.uo_date=create uo_date
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.st_6=create st_6
this.gb_1=create gb_1
this.dw_print=create dw_print
this.st_7=create st_7
this.sle_checksrno=create sle_checksrno
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_srorder
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.dw_shiporder
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_shipoemgubun
this.Control[iCurrent+7]=this.uo_date
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.uo_scustgubun
this.Control[iCurrent+10]=this.uo_custcode
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_print
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.sle_checksrno
end on

on w_piss050i.destroy
call super::destroy
destroy(this.dw_srorder)
destroy(this.st_5)
destroy(this.dw_shiporder)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.uo_shipoemgubun)
destroy(this.uo_date)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.st_6)
destroy(this.gb_1)
destroy(this.dw_print)
destroy(this.st_7)
destroy(this.sle_checksrno)
end on

event open;call super::open;//idw_srorder 	= dw_srorder
//idw_current		= idw_srorder
//
//iw_this = This
//dw_srorder.settransobject(sqlpis)
//dw_shiporder.settransobject(sqlpis)
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',FALSE,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//PostEvent('ue_postopen')

end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_srorder, FULL)

of_resize()

end event

event ue_retrieve;Integer	li_no[], li_i , li_count, li_loop, li_j
String 	ls_shipcount[], ls_visible[], ls_shipcounttemp, ls_modstring, ls_shipcountstring, ls_time[], ls_timetemp
Long 		ll_rowcount, ll_selected_row, ll_shipcount
string   ls_checksrno
ls_checksrno = trim(sle_checksrno.text)
if ls_checksrno = '' or isnull(ls_checksrno) then
	ls_checksrno = '%'
end if	
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
ll_rowcount =  idw_current.retrieve(is_date, is_areacode,is_divisioncode,ls_checksrno,is_custcode,is_Shipoemgubun)
Ll_shipcount = dw_shiporder.retrieve(is_areacode,is_divisioncode,is_date, is_custcode)
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
	is_mod1 = ls_modstring + wf_print_modify(3360,360000,3360, li_j)		
	If ll_selected_row = 1 Then
		idw_current.Post Event RowFocusChanged(1)			
	End If
END IF
idw_current.SetFocus()
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

ls_mod	= "t_date.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
ls_mod	= ls_mod + "t_areacode.Text = '" + "지역 : " + uo_area.is_uo_areaname + "' "
ls_mod	= ls_mod + "t_divisioncode.Text = '" + "공장 : " + is_divisionname + "' "
ls_mod	= ls_mod + "t_custcode.Text = '" + "거래처 : " + uo_custcode.is_uo_custname + "' "
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

type uo_status from w_ipis_sheet01`uo_status within w_piss050i
end type

type dw_srorder from u_vi_std_datawindow within w_piss050i
integer x = 18
integer y = 368
integer width = 4430
integer height = 2212
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss050i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;call super::doubleclicked;string ls_parm,ls_size,ls_itemcode,ls_srno
long   ll_count
if row <= 0 then
	return
end if	
ls_srno = dw_srorder.object.srno[row]
ls_itemcode = dw_srorder.object.itemcode[row]
select count(*)
  into :ll_count
  from tsrorder
 where checksrno = :ls_srno
  and areacode = :is_areacode
  and divisioncode like :is_divisioncode
  and pcgubun  = 'C'
 using sqlpis;
if ll_count = 0 then  
	messagebox("확인","KIT 품번이 아닙니다")
	return
end if

ls_srno = left(ls_srno + space(11),11)
ls_itemcode = left(ls_itemcode + space(12),12)
ls_parm	= ls_srno + is_date + is_areacode + is_divisioncode

OpenWithParm(w_piss430i, ls_parm)

end event

type st_5 from statictext within w_piss050i
integer x = 2208
integer y = 116
integer width = 270
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
string text = "출하구분"
boolean focusrectangle = false
end type

type dw_shiporder from datawindow within w_piss050i
boolean visible = false
integer x = 64
integer y = 692
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss050i_05"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_division from u_pisc_select_division within w_piss050i
integer x = 1266
integer y = 100
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)

is_divisioncode = uo_division.is_uo_divisioncode
is_divisionname = uo_division.is_uo_divisionname
dw_srorder.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
is_divisionname = is_uo_divisionname
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss050i
integer x = 773
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_srorder.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = uo_area.is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',FALSE,is_divisioncode,ls_divisionname,ls_divisionnameeng)

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
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//
//
end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_shipoemgubun from u_pisc_select_code within w_piss050i
integer x = 2473
integer y = 104
integer width = 709
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
dw_srorder.sharedata(dw_print)
dw_srorder.reset()
end event

type uo_date from u_pisc_date_applydate within w_piss050i
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
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type st_8 from statictext within w_piss050i
integer x = 64
integer y = 212
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

type uo_scustgubun from u_pisc_select_code within w_piss050i
integer x = 398
integer y = 196
integer width = 709
integer taborder = 70
boolean bringtotop = true
end type

event constructor;call super::constructor;//postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()

end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

type uo_custcode from u_piss_select_custcode within w_piss050i
integer x = 1166
integer y = 196
integer taborder = 80
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_srorder.reset()
dw_shiporder.reset()
dw_print.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

type st_6 from statictext within w_piss050i
integer x = 3205
integer y = 116
integer width = 1166
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
string text = "(출하구분이 전체 선택시 이체 미포함)"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss050i
integer x = 23
integer y = 28
integer width = 4421
integer height = 296
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

type dw_print from datawindow within w_piss050i
boolean visible = false
integer x = 1074
integer y = 652
integer width = 2405
integer height = 936
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss050i_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_piss050i
integer x = 2258
integer y = 204
integer width = 201
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
string text = "SR번호"
boolean focusrectangle = false
end type

type sle_checksrno from singlelineedit within w_piss050i
integer x = 2478
integer y = 192
integer width = 690
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

