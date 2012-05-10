$PBExportHeader$w_wip052i.srw
$PBExportComments$Sub실사품 Knock-Down 조회
forward
global type w_wip052i from w_origin_sheet04
end type
type dw_head from datawindow within w_wip052i
end type
type st_1 from statictext within w_wip052i
end type
type uo_from from uo_yymm_boongi within w_wip052i
end type
type rb_1 from radiobutton within w_wip052i
end type
type rb_2 from radiobutton within w_wip052i
end type
type dw_report from datawindow within w_wip052i
end type
type uo_1 from uo_wip_plandiv within w_wip052i
end type
type gb_1 from groupbox within w_wip052i
end type
end forward

global type w_wip052i from w_origin_sheet04
string tag = "Sub실사품 Knock-Down조회"
string title = "Sub실사품 Knock-Down조회"
dw_head dw_head
st_1 st_1
uo_from uo_from
rb_1 rb_1
rb_2 rb_2
dw_report dw_report
uo_1 uo_1
gb_1 gb_1
end type
global w_wip052i w_wip052i

type variables
datastore ids_data
string i_s_year,i_s_month,i_s_yearmonth
end variables

on w_wip052i.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.st_1=create st_1
this.uo_from=create uo_from
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_report=create dw_report
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_from
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.gb_1
end on

on w_wip052i.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.st_1)
destroy(this.uo_from)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_report)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event open;call super::open;this.uo_status.st_winid.text = this.classname()
this.uo_status.st_kornm.text = g_s_kornm
this.uo_status.st_date.text  = string(g_s_date, "@@@@-@@-@@")
ids_data = create datastore
ids_data.dataobject = "d_wip052i_datastore"
ids_Data.settransobject(Sqlca)
dw_head.dataobject = 'd_wip052i_head'
dw_head.settransobject(sqlca)
i_b_print    = true
wf_icon_onoff(i_b_retrieve, i_b_print,      i_b_first,   i_b_prev,   i_b_next,  & 
				  i_b_last,     i_b_dretrieve,  i_b_dprint,  i_b_dchar)


end event

event ue_retrieve;call super::ue_retrieve;dec{0}  lc_yyyymm
string  l_s_plant,l_s_dvsn,l_s_model,l_s_date, ls_mysql
integer l_n_count,i,l_n_count1

dw_head.reset()
SetPointer(HourGlass!)

lc_yyyymm = uo_from.uf_yyyymm()
i_s_year = mid(string(lc_yyyymm),1,4)
i_s_month = mid(string(lc_yyyymm),5,2)
i_s_yearmonth = i_s_year + i_s_month
l_s_date      = i_s_yearmonth + '31'
l_s_plant = trim(uo_1.dw_1.getitemstring(1,'xplant'))
l_s_dvsn  = trim(uo_1.dw_1.getitemstring(1,'div'))

l_n_count = ids_data.retrieve(g_s_company,l_s_plant,l_s_dvsn,i_s_year,i_s_month)
if l_n_count = 0 then
	uo_status.st_message.text = f_message("I020")
	return
end if
dw_head.reset()
l_n_count1 = 0
for i = 1 to l_n_count
	l_s_model = trim(ids_data.object.wfitno[i])
	
	DECLARE up_wip_16 PROCEDURE FOR PBWIP.SP_WIP_16  
         A_COMLTD = :g_s_company,   
         A_PLANT = :l_s_plant,   
         A_DVSN = :l_s_dvsn,   
         A_ITNO = :l_s_model,   
         A_DATE = :i_s_yearmonth,   
         A_CHK = 'H',   
         A_DELCHK = 'N'  using sqlca;
	Execute up_wip_16;
//   f_creation_bom_after(l_s_date,l_s_plant,l_s_dvsn,l_s_model,'H',' ')
next
dw_Report.sharedataoff()
l_n_count1 = dw_head.retrieve(g_s_company,l_s_plant,l_s_dvsn,i_s_year,i_s_month)

ls_mysql = "DROP TABLE QTEMP.BOMTEMP02"
Execute Immediate :ls_mysql using sqlca;

Close up_wip_16;

if l_n_count1 = 0 then
	uo_status.st_message.text = f_message("I020")
	return
else
	uo_status.st_message.text = f_message("I010")
end if




end event

event ue_print;call super::ue_print;integer li_rowcnt,li_cntnum
string mod_string,ls_rownum,ls_plant,ls_dvsn
string ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

li_rowcnt = dw_head.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if
if rb_1.checked = true then
	dw_report.dataobject = 'd_wip052i_head_report'
elseif rb_2.checked = true then
	dw_report.dataobject = 'd_wip052i_head_01_report'
end if

dw_head.sharedata(dw_report)

ls_kijun = i_s_year + '년 ' + i_s_month + '월' 
ls_plant  = f_get_coitname('01','ACC002', trim(dw_head.object.wfplant[1]))
ls_dvsn   = f_get_coitname('01','DAC030', trim(dw_head.object.wfdvsn[1])) 
mod_string =  "t_kijun.text = '( " + ls_kijun + " )'" + "t_plant.text = '" + ls_plant + "'" + &
									 "t_dvsn.text   = '" + ls_dvsn + "'"  + &
									 "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"
l_str_prt.title = "Sub 실사품 Knock-Down"							

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip052i
end type

type dw_head from datawindow within w_wip052i
integer x = 50
integer y = 252
integer width = 3506
integer height = 2196
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip052i_head"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_wip052i
integer x = 1381
integer y = 96
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "실사분기"
boolean focusrectangle = false
end type

type uo_from from uo_yymm_boongi within w_wip052i
integer x = 1673
integer y = 88
integer taborder = 20
boolean bringtotop = true
end type

on uo_from.destroy
call uo_yymm_boongi::destroy
end on

type rb_1 from radiobutton within w_wip052i
integer x = 2272
integer y = 52
integer width = 626
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sub 품번별 조회"
boolean checked = true
end type

event clicked;dw_head.dataobject = 'd_wip052i_head'
dw_head.settransobject(sqlca)
end event

type rb_2 from radiobutton within w_wip052i
integer x = 2272
integer y = 128
integer width = 626
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "소요품번별 조회"
end type

event clicked;dw_head.dataobject = 'd_wip052i_head_01'
dw_head.settransobject(sqlca)
end event

type dw_report from datawindow within w_wip052i
boolean visible = false
integer x = 2651
integer y = 92
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_wip_plandiv within w_wip052i
integer x = 87
integer y = 72
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type gb_1 from groupbox within w_wip052i
integer x = 50
integer width = 3474
integer height = 232
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

