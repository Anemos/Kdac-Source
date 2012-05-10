$PBExportHeader$w_pisq321i.srw
$PBExportComments$upload 자료조회
forward
global type w_pisq321i from w_ipis_sheet01
end type
type st_1 from statictext within w_pisq321i
end type
type dw_1 from datawindow within w_pisq321i
end type
type st_2 from statictext within w_pisq321i
end type
type uo_2 from u_pisc_date_scroll_month within w_pisq321i
end type
type uo_1 from u_pisc_date_scroll_month within w_pisq321i
end type
type uo_area from u_pisc_select_area within w_pisq321i
end type
type uo_division from u_pisc_select_division within w_pisq321i
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq321i
end type
type st_3 from statictext within w_pisq321i
end type
type dw_2 from datawindow within w_pisq321i
end type
type uo_custcode from u_piss_select_custcode within w_pisq321i
end type
type dw_3 from datawindow within w_pisq321i
end type
type st_4 from statictext within w_pisq321i
end type
type uo_scustgubun from u_pisc_select_code within w_pisq321i
end type
type cbx_all from checkbox within w_pisq321i
end type
type cb_down_english from commandbutton within w_pisq321i
end type
type cb_down_korea from commandbutton within w_pisq321i
end type
type gb_1 from groupbox within w_pisq321i
end type
end forward

global type w_pisq321i from w_ipis_sheet01
integer width = 4681
integer height = 2784
st_1 st_1
dw_1 dw_1
st_2 st_2
uo_2 uo_2
uo_1 uo_1
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
st_3 st_3
dw_2 dw_2
uo_custcode uo_custcode
dw_3 dw_3
st_4 st_4
uo_scustgubun uo_scustgubun
cbx_all cbx_all
cb_down_english cb_down_english
cb_down_korea cb_down_korea
gb_1 gb_1
end type
global w_pisq321i w_pisq321i

type variables
string is_custgubun, is_custcode
end variables

on w_pisq321i.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.st_2=create st_2
this.uo_2=create uo_2
this.uo_1=create uo_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.st_3=create st_3
this.dw_2=create dw_2
this.uo_custcode=create uo_custcode
this.dw_3=create dw_3
this.st_4=create st_4
this.uo_scustgubun=create uo_scustgubun
this.cbx_all=create cbx_all
this.cb_down_english=create cb_down_english
this.cb_down_korea=create cb_down_korea
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_area
this.Control[iCurrent+7]=this.uo_division
this.Control[iCurrent+8]=this.uo_productgroup
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.uo_custcode
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.uo_scustgubun
this.Control[iCurrent+15]=this.cbx_all
this.Control[iCurrent+16]=this.cb_down_english
this.Control[iCurrent+17]=this.cb_down_korea
this.Control[iCurrent+18]=this.gb_1
end on

on w_pisq321i.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.uo_custcode)
destroy(this.dw_3)
destroy(this.st_4)
destroy(this.uo_scustgubun)
destroy(this.cbx_all)
destroy(this.cb_down_english)
destroy(this.cb_down_korea)
destroy(this.gb_1)
end on

event ue_postopen();call super::ue_postopen;dw_1.insertrow(0)
dw_2.insertrow(0)
dw_3.settransobject(sqleis)

dw_1.setitem(1,"dtgubun",'A')
dw_2.setitem(1,"exportgubun",'%')
idw_focused = dw_3

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										TRUE, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)
end event

event ue_retrieve;call super::ue_retrieve;string ls_areacode, ls_divisioncode, ls_productgroup, ls_customercode
string ls_datechk, ls_invchk, ls_fromdt, ls_todt, ls_custcode
long ll_rowcnt

ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
if ls_areacode = 'ALL' then
	ls_areacode = '%'
else
	ls_areacode = ls_areacode + '%'
end if
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
if ls_divisioncode = 'ALL' then
	ls_divisioncode = '%'
else
	ls_divisioncode = ls_divisioncode + '%'
end if
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
if ls_productgroup = 'ALL' or isnull(ls_productgroup) then
	ls_productgroup = '%'
else
	ls_productgroup = ls_productgroup + '%'
end if
ls_customercode	= is_custcode
if cbx_all.checked then
	ls_customercode = '%'
else
	ls_customercode = ls_customercode + '%'
end if
ls_datechk = dw_1.getitemstring(1,"dtgubun")
ls_invchk = dw_2.getitemstring(1,"exportgubun")
if ls_invchk <> '%' then
	ls_invchk = ls_invchk + '%'
end if
ls_fromdt = uo_2.em_date.text
ls_todt = uo_1.em_date.text

ll_rowcnt = dw_3.retrieve(ls_datechk,ls_areacode,ls_divisioncode,ls_productgroup &
				,ls_fromdt,ls_todt,ls_invchk,ls_customercode)

if ll_rowcnt > 0 then 
	uo_status.st_message.text = "조회되었습니다."
else
	uo_status.st_message.text = "조회할자료가 없습니다."
end if
end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

String ls_codegroup, ls_codegroupname, ls_codename
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',FALSE,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

event open;call super::open;f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq321i
integer x = 18
integer y = 2592
integer width = 3579
end type

type st_1 from statictext within w_pisq321i
integer x = 105
integer y = 60
integer width = 302
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기    간:"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_pisq321i
integer x = 393
integer y = 48
integer width = 585
integer height = 76
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq321i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisq321i
integer x = 1335
integer y = 56
integer width = 46
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type uo_2 from u_pisc_date_scroll_month within w_pisq321i
integer x = 759
integer y = 52
integer taborder = 30
end type

on uo_2.destroy
call u_pisc_date_scroll_month::destroy
end on

type uo_1 from u_pisc_date_scroll_month within w_pisq321i
integer x = 1147
integer y = 52
integer taborder = 20
end type

on uo_1.destroy
call u_pisc_date_scroll_month::destroy
end on

type uo_area from u_pisc_select_area within w_pisq321i
integer x = 1760
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select();call super::ue_select;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											TRUE, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)
end event

event constructor;call super::constructor;ib_allflag = true
end event

type uo_division from u_pisc_select_division within w_pisq321i
integer x = 2267
integer y = 56
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select();call super::ue_select;f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq321i
integer x = 2839
integer y = 56
integer taborder = 50
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

type st_3 from statictext within w_pisq321i
integer x = 105
integer y = 180
integer width = 315
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "자재구분:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_pisq321i
integer x = 393
integer y = 168
integer width = 475
integer height = 72
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq321i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_custcode from u_piss_select_custcode within w_pisq321i
integer x = 1806
integer y = 164
integer taborder = 60
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select();call super::ue_select;is_custcode = is_uo_custcode
end event

event ue_post_constructor();call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type dw_3 from datawindow within w_pisq321i
integer x = 27
integer y = 288
integer width = 4581
integer height = 2284
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq321i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pisq321i
integer x = 923
integer y = 176
integer width = 178
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "구분:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq321i
integer x = 1088
integer y = 164
integer taborder = 60
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_post_constructor();call super::ue_post_constructor;string ls_custname

f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)


end event

event ue_select();call super::ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)

end event

event constructor;call super::constructor;postevent("ue_post_constructor")
end event

type cbx_all from checkbox within w_pisq321i
integer x = 2834
integer y = 172
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "전체"
boolean lefttext = true
end type

type cb_down_english from commandbutton within w_pisq321i
integer x = 3790
integer y = 40
integer width = 759
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Excel Down(영문)"
end type

event clicked;if dw_3.SaveAs() = 1 then
	uo_status.st_message.text = "저장되었습니다."
else
	uo_status.st_message.text = "저장이 실패했습니다."
end if
end event

type cb_down_korea from commandbutton within w_pisq321i
integer x = 3790
integer y = 156
integer width = 759
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Excel Down(한글)"
end type

event clicked;f_save_to_excel_number(dw_3)

end event

type gb_1 from groupbox within w_pisq321i
integer x = 32
integer width = 4567
integer height = 268
integer taborder = 11
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

