$PBExportHeader$w_piss250i.srw
$PBExportComments$통제부서확인현황
forward
global type w_piss250i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss250i
end type
type uo_area from u_pisc_select_area within w_piss250i
end type
type dw_print from datawindow within w_piss250i
end type
type uo_division from u_pisc_select_division within w_piss250i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss250i
end type
type st_2 from statictext within w_piss250i
end type
type uo_date from u_pisc_date_firstday within w_piss250i
end type
type rb_1 from radiobutton within w_piss250i
end type
type rb_2 from radiobutton within w_piss250i
end type
type gb_1 from groupbox within w_piss250i
end type
type gb_2 from groupbox within w_piss250i
end type
end forward

global type w_piss250i from w_ipis_sheet01
string title = "통제부서확인현황"
dw_sheet dw_sheet
uo_area uo_area
dw_print dw_print
uo_division uo_division
uo_1 uo_1
st_2 st_2
uo_date uo_date
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
gb_2 gb_2
end type
global w_piss250i w_piss250i

type variables
string is_prddate,is_prddate1,is_areacode,is_divisioncode
//transaction sqltot
end variables

on w_piss250i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.dw_print=create dw_print
this.uo_division=create uo_division
this.uo_1=create uo_1
this.st_2=create st_2
this.uo_date=create uo_date
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_date
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
end on

on w_piss250i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.dw_print)
destroy(this.uo_division)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.uo_date)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;string ls_prddate,ls_areacode,ls_divisioncode
long ll_count

ll_count = dw_sheet.retrieve(is_prddate,is_prddate1,is_areacode,is_divisioncode)

if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	uo_date.setfocus()
	return
end if	



	
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt
dw_sheet.sharedata(dw_print)
//
ls_mod	= "t_msg.Text = '" + "기준일 : " + is_prddate + "' "
//ls_mod	= ls_mod + is_mod1

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
if rb_1.checked = true then
	lstr_prt.title			= '통제부서확인현황'
	lstr_prt.tag			= '통제부서확인현황'
elseif rb_2.checked = true then
	lstr_prt.title			= '통제부서 미확인현황'
	lstr_prt.tag			= '통제부서 미확인현황'
end if

lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss250i
end type

type dw_sheet from u_vi_std_datawindow within w_piss250i
integer x = 18
integer y = 232
integer width = 3575
integer height = 1656
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss250i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;if rb_2.checked = true and rowcount > 0 then
	int i=0,j=0,k=0
	string ls_deptcode,ls_subject,ls_detail,ls_check_string[],ls_mgr_mailaddr,ls_weekago_day,ls_mailchk = 'N'
	
	ls_weekago_day = String(RelativeDate(Date(String(g_s_date,"@@@@-@@-@@")),-7),"yyyy.mm.dd")
	
	for i = 1 to rowcount
		if dw_sheet.object.shipdate[i] <= ls_weekago_day then
			ls_detail += '출하전표번호 : ' + trim(dw_sheet.object.shipsheetno[i]) + '~r~n'
		end if
	next
	
	if f_spacechk(ls_detail) = -1 then
		return
	end if
	
	if messagebox("확인","출하 후 7일이 넘은 미확인현황을 생산관리팀에 통보하시겠습니까 ? ",question!,yesno!,1) <> 1 then
		return
	end if
	
	ls_subject = '출하 후 7일이 넘은 경비대 미확인 출하전표번호를 출하담당자에게 확인요망 바랍니다'
	
	i = 0
	
	declare lastemp_chk cursor for
	Select distinct	c.deptcode
		From	tshipsheet a,tloadplan b,tmstemp c
	  Where a.areacode     	= :is_areacode
		and a.confirmflag  	= 'N' 
		and a.divisioncode 	like :is_divisioncode
//		and a.shipdate     	>= :is_prddate
//		and a.shipdate     	<= :is_prddate1
		and a.shipdate     	<= :ls_weekago_day
		and a.areacode     	= b.areacode
		and a.divisioncode   = b.divisioncode
		and a.srno				= b.srno
		and a.truckno			= b.truckno
		and b.truckmodifyflag	<> 'S'
		and len(b.lastemp)	= 6
		and b.lastemp			=	c.lastemp
	using sqlpis ;
	open lastemp_chk ;
		do while true
			fetch lastemp_chk into :ls_deptcode ;
			if sqlpis.sqlcode <> 0 then			  
				exit
			end if
			ls_mgr_mailaddr		=	trim(f_mgr_mailaddr(ls_deptcode))
			messagebox("AA",ls_mgr_mailaddr)
		//f_sendmail(ls_check_String[j],ls_subject,ls_detail,'')
			ls_mailchk	=	'Y'
		loop
	close lastemp_chk ;
	if ls_mailchk	=	'Y' then
		uo_status.st_message.text	=	'관련부서로 정상적으로 메일이 발송되었습니다'
	else
		uo_status.st_message.text	=	'관련부서가 없습니다'
	end if
end if
end event

type uo_area from u_pisc_select_area within w_piss250i
integer x = 1335
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
is_areacode = is_uo_areacode
if is_areacode = 'K' or is_areacode = 'J' then
   f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
   f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)	
end if	
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
is_areacode = is_uo_areacode
datawindow ldw_division
ldw_division = uo_division.dw_1
if is_areacode = 'K' or is_areacode = 'J' then
   f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
   f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)	
end if	

end event

type dw_print from datawindow within w_piss250i
boolean visible = false
integer x = 1093
integer y = 568
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss250i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_division from u_pisc_select_division within w_piss250i
event destroy ( )
integer x = 1856
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type uo_1 from u_pisc_date_applydate_1 within w_piss250i
integer x = 832
integer y = 92
integer taborder = 40
boolean bringtotop = true
end type

event constructor;call super::constructor;is_prddate1 = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_prddate1 = is_uo_date
end event

event ue_select;call super::ue_select;is_prddate1 = is_uo_date
end event

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_2 from statictext within w_piss250i
integer x = 754
integer y = 104
integer width = 73
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_date from u_pisc_date_firstday within w_piss250i
integer x = 69
integer y = 92
integer taborder = 60
boolean bringtotop = true
end type

event constructor;call super::constructor;is_prddate = is_uo_date
end event

event ue_select;call super::ue_select;if is_prddate <> is_uo_date then
	dw_sheet.reset()
end if	
is_prddate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

on uo_date.destroy
call u_pisc_date_firstday::destroy
end on

type rb_1 from radiobutton within w_piss250i
integer x = 2523
integer y = 84
integer width = 315
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "확  인"
boolean checked = true
end type

event clicked;dw_sheet.dataobject = 'd_piss250i_01'
dw_sheet.settransobject(sqlpis)
dw_print.dataobject = 'd_piss250i_02'
dw_print.settransobject(sqlpis)


end event

type rb_2 from radiobutton within w_piss250i
integer x = 2848
integer y = 84
integer width = 302
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "미확인"
end type

event clicked;dw_sheet.dataobject = 'd_piss250i_03'
dw_sheet.settransobject(sqlpis)
dw_print.dataobject = 'd_piss250i_04'
dw_print.settransobject(sqlpis)

end event

type gb_1 from groupbox within w_piss250i
integer x = 23
integer y = 28
integer width = 2441
integer height = 172
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

type gb_2 from groupbox within w_piss250i
integer x = 2473
integer y = 28
integer width = 690
integer height = 176
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

