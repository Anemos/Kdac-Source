$PBExportHeader$w_seq114i.srw
$PBExportComments$품목별수불현황
forward
global type w_seq114i from w_origin_sheet09
end type
type uo_area from u_pisc_select_area within w_seq114i
end type
type uo_division from u_pisc_select_division within w_seq114i
end type
type uo_4 from u_pisc_date_applydate within w_seq114i
end type
type uo_5 from u_pisc_date_applydate_1 within w_seq114i
end type
type st_13 from statictext within w_seq114i
end type
type ddlb_gubun from dropdownlistbox within w_seq114i
end type
type dw_2 from datawindow within w_seq114i
end type
type st_12 from statictext within w_seq114i
end type
type pb_excel from picturebutton within w_seq114i
end type
type gb_1 from groupbox within w_seq114i
end type
type uo_itemcode from u_pisc_select_custitem_kdac within w_seq114i
end type
end forward

global type w_seq114i from w_origin_sheet09
integer height = 2720
string title = "품목별수불현황"
uo_area uo_area
uo_division uo_division
uo_4 uo_4
uo_5 uo_5
st_13 st_13
ddlb_gubun ddlb_gubun
dw_2 dw_2
st_12 st_12
pb_excel pb_excel
gb_1 gb_1
uo_itemcode uo_itemcode
end type
global w_seq114i w_seq114i

type variables
string is_areacode,is_divisioncode,is_productgroup
string is_gubun,is_shipdate,is_shipdate1,is_itemcode
end variables

on w_seq114i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_4=create uo_4
this.uo_5=create uo_5
this.st_13=create st_13
this.ddlb_gubun=create ddlb_gubun
this.dw_2=create dw_2
this.st_12=create st_12
this.pb_excel=create pb_excel
this.gb_1=create gb_1
this.uo_itemcode=create uo_itemcode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_4
this.Control[iCurrent+4]=this.uo_5
this.Control[iCurrent+5]=this.st_13
this.Control[iCurrent+6]=this.ddlb_gubun
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.st_12
this.Control[iCurrent+9]=this.pb_excel
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.uo_itemcode
end on

on w_seq114i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_4)
destroy(this.uo_5)
destroy(this.st_13)
destroy(this.ddlb_gubun)
destroy(this.dw_2)
destroy(this.st_12)
destroy(this.pb_excel)
destroy(this.gb_1)
destroy(this.uo_itemcode)
end on

event open;call super::open;ddlb_gubun.text = '전체(%)'
uo_itemcode.sle_1.backcolor = 15780518
end event

event ue_retrieve;call super::ue_retrieve;long ln_row 

ln_row = dw_2.retrieve(is_shipdate,is_shipdate1,is_Areacode,is_divisioncode,is_itemcode,is_gubun)

if ln_row < 1 then
	uo_status.st_message.text = '조회할 정보가 없습니다'
else
	uo_status.st_message.text = "  " + string(ln_row) + ' 건 조회완료'
end if
end event

event activate;call super::activate;dw_2.settransobject(sqlpis)
end event

type uo_status from w_origin_sheet09`uo_status within w_seq114i
end type

type uo_area from u_pisc_select_area within w_seq114i
event destroy ( )
integer x = 1234
integer y = 60
integer taborder = 90
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)


end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)



end event

type uo_division from u_pisc_select_division within w_seq114i
event destroy ( )
integer x = 1719
integer y = 60
integer taborder = 100
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;string ls_productname
is_divisioncode = is_uo_divisioncode
//if ib_open = true then
//	f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)
//end if
end event

event ue_post_constructor;call super::ue_post_constructor;//is_divisioncode = is_uo_divisioncode

end event

type uo_4 from u_pisc_date_applydate within w_seq114i
integer x = 55
integer y = 60
integer taborder = 80
boolean bringtotop = true
end type

event constructor;call super::constructor;//is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;//is_shipdate = is_uo_date
end event

event ue_select;if is_shipdate <> is_uo_date then
	dw_2.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_4.destroy
call u_pisc_date_applydate::destroy
end on

type uo_5 from u_pisc_date_applydate_1 within w_seq114i
event destroy ( )
integer x = 786
integer y = 60
integer taborder = 90
boolean bringtotop = true
end type

on uo_5.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date
dw_2.reset()
end event

type st_13 from statictext within w_seq114i
integer x = 3849
integer y = 72
integer width = 219
integer height = 72
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
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_seq114i
integer x = 4046
integer y = 56
integer width = 366
integer height = 324
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean sorted = false
string item[] = {"전체(%)","입고(I)","생산(P)","출하(O)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	is_gubun = '%'
elseif index = 2 then
	is_gubun = 'I'
elseif index = 3 then
	is_gubun = 'P'
elseif index = 4 then
	is_gubun = 'O'
else
	is_gubun = ''
end if
end event

event constructor;is_gubun = '%'
end event

type dw_2 from datawindow within w_seq114i
integer x = 46
integer y = 180
integer width = 4562
integer height = 2272
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_seq_transaction_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_12 from statictext within w_seq114i
integer x = 718
integer y = 68
integer width = 87
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_excel from picturebutton within w_seq114i
integer x = 4457
integer y = 32
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)



end event

type gb_1 from groupbox within w_seq114i
integer x = 41
integer width = 4393
integer height = 164
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_itemcode from u_pisc_select_custitem_kdac within w_seq114i
integer x = 2313
integer y = 44
integer taborder = 110
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode
end event

on uo_itemcode.destroy
call u_pisc_select_custitem_kdac::destroy
end on

event destructor;call super::destructor;call u_pisc_select_custitem_kdac::destroy
end event

