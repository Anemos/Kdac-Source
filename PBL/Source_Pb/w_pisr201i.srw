$PBExportHeader$w_pisr201i.srw
$PBExportComments$제품군별 AS품 Warning관리
forward
global type w_pisr201i from w_ipis_sheet01
end type
type dw_pisr201i_01 from u_vi_std_datawindow within w_pisr201i
end type
type uo_area from u_pisc_select_area within w_pisr201i
end type
type uo_division from u_pisc_select_division within w_pisr201i
end type
type uo_product from u_pisc_select_productgroup within w_pisr201i
end type
type pb_down from picturebutton within w_pisr201i
end type
type uo_fromdate from u_pisc_date_applydate within w_pisr201i
end type
type st_2 from statictext within w_pisr201i
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisr201i
end type
type cb_register from commandbutton within w_pisr201i
end type
type gb_1 from groupbox within w_pisr201i
end type
end forward

global type w_pisr201i from w_ipis_sheet01
integer width = 4663
event ue_init ( )
dw_pisr201i_01 dw_pisr201i_01
uo_area uo_area
uo_division uo_division
uo_product uo_product
pb_down pb_down
uo_fromdate uo_fromdate
st_2 st_2
uo_todate uo_todate
cb_register cb_register
gb_1 gb_1
end type
global w_pisr201i w_pisr201i

type variables

end variables

event ue_init();// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

on w_pisr201i.create
int iCurrent
call super::create
this.dw_pisr201i_01=create dw_pisr201i_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.pb_down=create pb_down
this.uo_fromdate=create uo_fromdate
this.st_2=create st_2
this.uo_todate=create uo_todate
this.cb_register=create cb_register
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr201i_01
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_product
this.Control[iCurrent+5]=this.pb_down
this.Control[iCurrent+6]=this.uo_fromdate
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_todate
this.Control[iCurrent+9]=this.cb_register
this.Control[iCurrent+10]=this.gb_1
end on

on w_pisr201i.destroy
call super::destroy
destroy(this.dw_pisr201i_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.pb_down)
destroy(this.uo_fromdate)
destroy(this.st_2)
destroy(this.uo_todate)
destroy(this.cb_register)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr201i_01.Width = newwidth 	- ( dw_pisr201i_01.x + ls_gap * 2 )
dw_pisr201i_01.Height= newheight - ( dw_pisr201i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
	
uo_fromdate.id_uo_date = Date(String(Today(), "YYYY.MM") + ".01")
uo_fromdate.is_uo_date = String(uo_fromdate.id_uo_date, 'YYYY.MM.DD')
uo_fromdate.init_cal(uo_fromdate.id_uo_date)
uo_fromdate.set_date_format ('yyyy.mm.dd')
uo_fromdate.TriggerEvent("ue_variable_set")
uo_fromdate.TriggerEvent("ue_select")
end event

event open;call super::open;dw_pisr201i_01.settransobject(sqlpis)

this.PostEvent ( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;long ll_row
string ls_suppcode

uo_status.st_message.text = ""
dw_pisr201i_01.SetRedraw(False)
dw_pisr201i_01.SetTransObject(sqlpis)

ll_Row = dw_pisr201i_01.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	uo_product.is_uo_productgroup, uo_fromdate.is_uo_date, uo_todate.is_uo_date )
	
if ll_Row < 1 then
	uo_status.st_message.text = "조회할 데이타가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if

dw_pisr201i_01.SetRedraw(True)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr201i
end type

type dw_pisr201i_01 from u_vi_std_datawindow within w_pisr201i
integer x = 23
integer y = 296
integer width = 3767
integer height = 1440
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr210i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_pisr201i
integer x = 50
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

dw_pisr201i_01.Reset()
end event

type uo_division from u_pisc_select_division within w_pisr201i
integer x = 544
integer y = 52
integer taborder = 50
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_pisr201i_01.Reset()

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
end event

type uo_product from u_pisc_select_productgroup within w_pisr201i
integer x = 1106
integer y = 52
integer taborder = 60
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr201i_01.reset()
end event

type pb_down from picturebutton within w_pisr201i
integer x = 3383
integer y = 84
integer width = 320
integer height = 136
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
f_save_to_excel(dw_pisr201i_01)
return 0
end event

type uo_fromdate from u_pisc_date_applydate within w_pisr201i
event destroy ( )
integer x = 46
integer y = 172
integer taborder = 70
boolean bringtotop = true
end type

on uo_fromdate.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;
dw_pisr201i_01.Reset()
end event

type st_2 from statictext within w_pisr201i
integer x = 727
integer y = 172
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

type uo_todate from u_pisc_date_applydate_1 within w_pisr201i
event destroy ( )
integer x = 800
integer y = 172
integer taborder = 80
boolean bringtotop = true
end type

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_pisr201i_01.Reset()
end event

type cb_register from commandbutton within w_pisr201i
integer x = 2377
integer y = 88
integer width = 777
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Warning 담당자등록"
end type

event clicked;str_parms lstr_parm

lstr_parm.string_arg[1] = uo_area.is_uo_areacode
lstr_parm.string_arg[2] = uo_division.is_uo_divisioncode

openwithparm(w_pisr201b, lstr_parm)
end event

type gb_1 from groupbox within w_pisr201i
integer x = 23
integer width = 3790
integer height = 280
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

