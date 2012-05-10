$PBExportHeader$w_piss240u.srw
$PBExportComments$통제부서확인
forward
global type w_piss240u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss240u
end type
type uo_area from u_pisc_select_area within w_piss240u
end type
type uo_division from u_pisc_select_division within w_piss240u
end type
type st_2 from statictext within w_piss240u
end type
type sle_truckno from singlelineedit within w_piss240u
end type
type cb_1 from commandbutton within w_piss240u
end type
type st_h_bar from uo_xc_splitbar within w_piss240u
end type
type dw_3 from datawindow within w_piss240u
end type
type cb_2 from commandbutton within w_piss240u
end type
type gb_1 from groupbox within w_piss240u
end type
end forward

global type w_piss240u from w_ipis_sheet01
string title = "통제부서확인"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_truckno sle_truckno
cb_1 cb_1
st_h_bar st_h_bar
dw_3 dw_3
cb_2 cb_2
gb_1 gb_1
end type
global w_piss240u w_piss240u

type variables
string is_applydate,is_areacode,is_divisioncode
end variables

forward prototypes
public function boolean wf_save ()
end prototypes

public function boolean wf_save ();long ll_count,i
integer li_truckorder
string ls_confirmflag,ls_shipsheetno,ls_srno
long ll_totalqty
string ls_areacode,ls_divisioncode,ls_itemcode,ls_truckno,ls_custcode,ls_shipdate
datetime ldt_time
boolean lb_commit
lb_commit = true
ls_truckno = trim(sle_truckno.text)
select getdate()
  into :ldt_time
  from sysusers
  using sqlpis;
  
ll_count = dw_sheet.rowcount()

FOR i=1 TO ll_count STEP 1
	ls_confirmflag = dw_sheet.object.confirmflag[i]
	if ls_confirmflag = 'Y' then    //확정하면
		ls_divisioncode = dw_sheet.object.divisioncode[i]
		ls_shipsheetno  = dw_sheet.object.shipsheetno[i]
		li_truckorder   = dw_sheet.object.truckorder[i]
		ls_custcode     = dw_sheet.object.custcode[i]
		ls_shipdate     = dw_sheet.object.shipdate[i]
		update tshipsheet
		   set confirmflag = 'Y',
			    confirmdate = :ldt_time,
				 lastdate    = getdate(),
				 lastemp     = 'Y'
		 where areacode     = :is_areacode
		   and divisioncode = :ls_divisioncode
			and shipdate     = :ls_shipdate
			and shipsheetno  = :ls_shipsheetno
			and truckorder   = :li_truckorder
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
			lb_commit = false
			uo_status.st_message.text = "오류" + sqlpis.sqlerrtext
			exit
      end if
		insert into tshipsheet_tong
		            (shipdate,areacode,divisioncode,shipsheetno,confirmdate,truckno,
						 custcode,confirmflag,lastemp,lastdate)
				values(:ls_shipdate,:is_areacode,:ls_divisioncode,:ls_shipsheetno,:ldt_time,:ls_truckno,
				       :ls_custcode,'Y',:g_s_empno,getdate())
						 using sqlpis;
		if sqleis.sqlcode <> 0 then
			lb_commit = false
			uo_status.st_message.text = "tshipsheet_tong : " + sqleis.sqlerrtext
			exit
      end if
	
   end if
NEXT
return lb_commit
end function

on w_piss240u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_truckno=create sle_truckno
this.cb_1=create cb_1
this.st_h_bar=create st_h_bar
this.dw_3=create dw_3
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_truckno
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_1
end on

on w_piss240u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_truckno)
destroy(this.cb_1)
destroy(this.st_h_bar)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.gb_1)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_sheet, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_3, BELOW)

of_resize()
end event

event ue_retrieve;call super::ue_retrieve;dw_3.reset()
long ll_count
string ls_truckno

ls_truckno = trim(sle_truckno.text)
if (ls_truckno) = '' or isnull(ls_truckno) then
	messagebox("확인","차량번호를 입력하세요.")
	sle_truckno.setfocus()
	return
end if	
setpointer(hourglass!)
ll_count = dw_sheet.retrieve('%',is_areacode,is_divisioncode,ls_truckno)
setpointer(Arrow!)
if ll_count = 0 then
   messagebox("확인"," 조회된 자료가 없습니다.")
	dw_sheet.reset()
	sle_truckno.text = ''
	sle_truckno.setfocus()
	return
end if	

end event

event ue_save;sqlpis.autocommit = false
setpointer(hourglass!)
if wf_save() = true then
	commit using sqlpis;
   sqlpis.autocommit = true
	messagebox("확인","확인이 완료 되었습니다.")
	triggerevent('ue_retrieve')
else
	rollback using sqlpis;
   sqlpis.autocommit = true	
	messagebox("확인","확인이 안되었습니다.")		
end if;	

setpointer(arrow!)
end event

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss240u
end type

type dw_sheet from u_vi_std_datawindow within w_piss240u
integer x = 9
integer y = 196
integer width = 3593
integer height = 852
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_piss240u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;if row < 1 then 
	return
end if	
string ls_divisioncode,ls_shipsheetno,ls_shipdate

ls_divisioncode = dw_sheet.object.divisioncode[row]
ls_shipsheetno  = dw_sheet.object.shipsheetno[row]
ls_shipdate     = dw_sheet.object.shipdate[row]
dw_3.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_shipdate)

end event

type uo_area from u_pisc_select_area within w_piss240u
event destroy ( )
integer x = 64
integer y = 76
integer taborder = 40
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
if is_areacode = 'K' or is_areacode = 'J' then
   f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
   f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
end if	
dw_sheet.reset()
dw_3.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
if is_areacode = 'K' or is_areacode = 'J' then
   f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
   f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)	
end if	

end event

type uo_division from u_pisc_select_division within w_piss240u
event destroy ( )
integer x = 603
integer y = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_3.reset()

end event

type st_2 from statictext within w_piss240u
integer x = 1189
integer y = 92
integer width = 274
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
string text = "차량번호"
boolean focusrectangle = false
end type

type sle_truckno from singlelineedit within w_piss240u
integer x = 1458
integer y = 48
integer width = 809
integer height = 124
integer taborder = 20
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;//dw_sheet.reset()
end event

type cb_1 from commandbutton within w_piss240u
integer x = 2885
integer y = 48
integer width = 457
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
end type

event clicked;parent.triggerevent('ue_save')
end event

type st_h_bar from uo_xc_splitbar within w_piss240u
integer x = 50
integer y = 1084
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_sheet,ABOVE)
of_register(dw_3,BELOW)
end event

type dw_3 from datawindow within w_piss240u
integer x = 50
integer y = 1136
integer width = 411
integer height = 712
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss400u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_piss240u
integer x = 2418
integer y = 48
integer width = 457
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;parent.triggerevent('ue_retrieve')
end event

type gb_1 from groupbox within w_piss240u
integer x = 9
integer y = 8
integer width = 2309
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
string text = "조회조건"
end type

