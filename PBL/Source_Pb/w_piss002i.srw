$PBExportHeader$w_piss002i.srw
$PBExportComments$재고정보 Check / AS400 & SQL Server
forward
global type w_piss002i from w_origin_sheet05
end type
type dw_1 from datawindow within w_piss002i
end type
type pb_excel from picturebutton within w_piss002i
end type
type uo_area from u_pisc_select_area within w_piss002i
end type
type uo_division from u_pisc_select_division within w_piss002i
end type
type dw_2 from datawindow within w_piss002i
end type
end forward

global type w_piss002i from w_origin_sheet05
string tag = "입고,출하 Interface"
integer width = 4667
string title = "입고,출하 Interface"
event ue_keydown pbm_keydown
dw_1 dw_1
pb_excel pb_excel
uo_area uo_area
uo_division uo_division
dw_2 dw_2
end type
global w_piss002i w_piss002i

type variables
string is_areacode,is_divisioncode

end variables

event ue_keydown;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if



end event

on w_piss002i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_excel=create pb_excel
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_excel
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_2
end on

on w_piss002i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.pb_excel)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
end on

event ue_retrieve;call super::ue_retrieve;integer ln_count
dw_1.reset()
dw_2.reset()
dw_2.retrieve(is_areacode,is_divisioncode)
ln_count = dw_1.retrieve(is_areacode,is_divisioncode,'%')
if ln_count > 0 then
	pb_excel.enabled = true
	pb_excel.visible = true
	uo_status.st_message.text = f_message("I010")
else
	pb_excel.enabled = false
	pb_excel.visible = false
	uo_status.st_message.text = f_message("I020")
end if

end event

event open;call super::open;pb_excel.enabled = false
pb_excel.visible = false

end event

type uo_status from w_origin_sheet05`uo_status within w_piss002i
integer y = 2448
end type

type dw_1 from datawindow within w_piss002i
integer x = 32
integer y = 136
integer width = 4571
integer height = 1316
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss_001i_07"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;string ls_areacode,ls_divisioncode,ls_itemcode,ls_date
integer i
decimal{1} ln_invqty,ln_beginqty,ln_stockqty,ln_shipqty,ln_moveinvqty,ln_shipinvqty

ls_date = mid(g_s_date,1,4) + '.' + mid(g_s_date,5,2)
for i = 1 to rowcount
	ls_areacode 			= trim(dw_1.object.xplant[i])
	ls_divisioncode		= trim(dw_1.object.div[i])
	ls_itemcode   		   = trim(dw_1.object.itno[i])
	select invqty + repairqty + defectqty + moveinvqty
		into :ln_invqty
	from tinv
		where areacode 		= :ls_areacode 
		and 	divisioncode 	= :ls_divisioncode
		and 	itemcode			= :ls_itemcode	using sqlpis ;
	if sqlpis.sqlcode <> 0  or ln_invqty = dw_1.object.useqty[i] then
		dw_1.deleterow(i)
		i = i - 1 
		continue
	end if
	select coalesce(max(invqty),0) + coalesce(max(repairqty),0) + coalesce(max(defectqty),0) +  coalesce(max(moveinvqty),0) into :ln_beginqty from tinvhis
		where areacode 		= :ls_areacode 
		and 	divisioncode 	= :ls_divisioncode
		and 	itemcode			= :ls_itemcode	
		and   applymonth		= :ls_date
	using sqlpis ;
	
	select coalesce(sum(stockqty),0),coalesce(sum(shipqty),0) 
		into :ln_stockqty,:ln_shipqty from tlotno
		where areacode 		= :ls_areacode 
		and 	divisioncode 	= :ls_divisioncode
		and 	itemcode			= :ls_itemcode	
		and   tracedate      like :ls_date + '%'
	using sqlpis ;
	dw_1.object.shipqty[i]  	= ln_shipqty				
	dw_1.object.stockqty[i]  	= ln_stockqty		
	dw_1.object.beginqty[i]  	= ln_beginqty
	dw_1.object.invqty[i] 	 	= ln_invqty
	dw_1.object.moveinvqty[i]	= ln_moveinvqty
	dw_1.object.shipinvqty[i]	= ln_shipinvqty
next

end event

event clicked;this.selectrow(0,false)
if row < 1 then return ;
this.selectrow(row,true)

//dw_2.reset() ;
end event

event constructor;this.settransobject(Sqlca)
end event

type pb_excel from picturebutton within w_piss002i
integer x = 4448
integer width = 155
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_Excel(dw_1)
end event

type uo_area from u_pisc_select_area within w_piss002i
event destroy ( )
integer x = 41
integer y = 28
integer taborder = 170
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
dw_2.settransobject(sqlpis)
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss002i
event destroy ( )
integer x = 613
integer y = 32
integer taborder = 50
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_2.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode

end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type dw_2 from datawindow within w_piss002i
integer x = 1161
integer y = 1472
integer width = 2391
integer height = 956
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss_001i_08"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

