$PBExportHeader$w_piso401u.srw
$PBExportComments$외주간판 운영
forward
global type w_piso401u from w_ipis_sheet01
end type
type uo_division from u_pisc_select_division within w_piso401u
end type
type uo_area from u_pisc_select_area within w_piso401u
end type
type uo_fromdate from u_pisc_date_applydate within w_piso401u
end type
type uo_todate from u_pisc_date_applydate_1 within w_piso401u
end type
type st_2 from statictext within w_piso401u
end type
type dw_2 from datawindow within w_piso401u
end type
type cb_1 from commandbutton within w_piso401u
end type
type cb_2 from commandbutton within w_piso401u
end type
type dw_3 from datawindow within w_piso401u
end type
type st_3 from statictext within w_piso401u
end type
type st_4 from statictext within w_piso401u
end type
type gb_3 from groupbox within w_piso401u
end type
type gb_4 from groupbox within w_piso401u
end type
end forward

global type w_piso401u from w_ipis_sheet01
integer width = 3826
event ue_init ( )
uo_division uo_division
uo_area uo_area
uo_fromdate uo_fromdate
uo_todate uo_todate
st_2 st_2
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
dw_3 dw_3
st_3 st_3
st_4 st_4
gb_3 gb_3
gb_4 gb_4
end type
global w_piso401u w_piso401u

type variables

end variables

on w_piso401u.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_2=create st_2
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_3=create dw_3
this.st_3=create st_3
this.st_4=create st_4
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_fromdate
this.Control[iCurrent+4]=this.uo_todate
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.gb_4
end on

on w_piso401u.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;
this.PostEvent ( "ue_init" )

uo_fromdate.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_fromdate.is_uo_date = String(uo_fromdate.id_uo_date, 'YYYY.MM.DD')
uo_fromdate.init_cal(uo_fromdate.id_uo_date)
uo_fromdate.set_date_format ('yyyy.mm.dd')
uo_fromdate.TriggerEvent("ue_variable_set")
uo_fromdate.TriggerEvent("ue_select")

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

//dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
//dw_2.Height= newheight - ( dw_2.y + ls_status )

end event

event ue_postopen;call super::ue_postopen;
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlca)
ll_rowcnt = dw_2.retrieve(uo_area.is_uo_areacode,uo_division.is_uo_divisioncode)
st_3.text = string(ll_rowcnt)
ll_rowcnt = dw_3.retrieve(uo_area.is_uo_areacode,uo_division.is_uo_divisioncode)
st_4.text = string(ll_rowcnt)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piso401u
end type

type uo_division from u_pisc_select_division within w_piso401u
event destroy ( )
integer x = 622
integer y = 72
integer taborder = 110
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)

dw_2.Reset()
dw_3.Reset()
end event

type uo_area from u_pisc_select_area within w_piso401u
event destroy ( )
integer x = 73
integer y = 72
integer taborder = 120
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;//ib_allflag = True
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)


dw_2.Reset()
dw_3.Reset()
end event

type uo_fromdate from u_pisc_date_applydate within w_piso401u
integer x = 1275
integer y = 72
integer taborder = 120
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
dw_2.Reset()
end event

on uo_fromdate.destroy
call u_pisc_date_applydate::destroy
end on

type uo_todate from u_pisc_date_applydate_1 within w_piso401u
integer x = 2030
integer y = 72
integer taborder = 130
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
dw_2.Reset()
end event

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_2 from statictext within w_piso401u
integer x = 1957
integer y = 72
integer width = 73
integer height = 52
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_piso401u
integer x = 32
integer y = 212
integer width = 1582
integer height = 1548
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso401u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_piso401u
integer x = 1650
integer y = 244
integer width = 215
integer height = 120
integer taborder = 40
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검증"
end type

event clicked;long ll_rowcnt, ll_cnt, ll_rtncnt, ll_currow
string ls_plant,ls_dvsn,ls_itno, ls_kbcd

setpointer(hourglass!)
ll_rowcnt = dw_2.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "데이타가 없습니다."
	return 0
else
	uo_status.st_message.text = "계산중입니다..."
end if

for ll_cnt = 1 to ll_rowcnt
	if ll_cnt <> 1 then
		dw_2.selectrow(ll_cnt - 1, false)
	end if
	dw_2.selectrow(ll_cnt,true)
	
	ls_plant = dw_2.getitemstring(ll_cnt,"areacode")
	ls_dvsn = dw_2.getitemstring(ll_cnt,"divisioncode")
	ls_itno = dw_2.getitemstring(ll_cnt,"itemcode")
	
	select kbcd into :ls_kbcd
	from pbinv.inv101
	where comltd = '01' and xplant = :ls_plant and
			div = :ls_dvsn and itno = :ls_itno
	using sqlca;
	
	if ls_kbcd = 'K' then
		continue
	else
		dw_2.setitem(ll_cnt,"chk",'Y')
	end if
next

uo_status.st_message.text = "완료되었습니다."
end event

type cb_2 from commandbutton within w_piso401u
integer x = 1650
integer y = 472
integer width = 215
integer height = 120
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "처리"
end type

event clicked;long ll_rowcnt, ll_cnt, ll_rtncnt, ll_currow
string ls_plant,ls_dvsn,ls_itno, ls_kbcd, ls_chk

setpointer(hourglass!)
dw_2.accepttext()
ll_rowcnt = dw_2.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "데이타가 없습니다."
	return 0
else
	uo_status.st_message.text = "처리중입니다..."
end if

for ll_cnt = 1 to ll_rowcnt
	ls_chk = dw_2.getitemstring(ll_cnt,"chk")
	if ls_chk = 'N' then
		continue
	end if
	if ll_cnt <> 1 then
		dw_2.selectrow(ll_cnt - 1, false)
	end if
	dw_2.selectrow(ll_cnt,true)
	
	ls_plant = dw_2.getitemstring(ll_cnt,"areacode")
	ls_dvsn = dw_2.getitemstring(ll_cnt,"divisioncode")
	ls_itno = dw_2.getitemstring(ll_cnt,"itemcode")
	
	update pbinv.inv101
	set kbcd = 'K'
	where comltd = '01' and xplant = :ls_plant and
			div = :ls_dvsn and itno = :ls_itno
	using sqlca;
	
next

uo_status.st_message.text = "완료되었습니다."
end event

type dw_3 from datawindow within w_piso401u
integer x = 1906
integer y = 212
integer width = 1655
integer height = 1552
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso401u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_piso401u
integer x = 690
integer y = 1788
integer width = 453
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_piso401u
integer x = 2386
integer y = 1788
integer width = 453
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_piso401u
integer x = 18
integer width = 1202
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_piso401u
integer x = 1234
integer width = 1275
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

