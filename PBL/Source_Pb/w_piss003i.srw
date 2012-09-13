$PBExportHeader$w_piss003i.srw
$PBExportComments$Trans & Balance Update
forward
global type w_piss003i from w_origin_sheet05
end type
type dw_1 from datawindow within w_piss003i
end type
type cb_delete from commandbutton within w_piss003i
end type
end forward

global type w_piss003i from w_origin_sheet05
string tag = "입고,출하 Interface"
integer width = 4667
string title = "입고,출하 Interface"
event ue_keydown pbm_keydown
dw_1 dw_1
cb_delete cb_delete
end type
global w_piss003i w_piss003i

type variables
string is_areacode,is_divisioncode

end variables

event ue_keydown;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if



end event

on w_piss003i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_delete
end on

on w_piss003i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_delete)
end on

event ue_retrieve;call super::ue_retrieve;integer ln_count
dw_1.reset()
if dw_1.retrieve() > 0 then
	cb_Delete.enabled = true
	cb_Delete.visible = true
else
	cb_Delete.enabled = false
	cb_Delete.visible = false
end if

end event

event open;call super::open;this.triggerevent("ue_retrieve")
end event

type uo_status from w_origin_sheet05`uo_status within w_piss003i
integer y = 2448
end type

type dw_1 from datawindow within w_piss003i
integer x = 416
integer y = 36
integer width = 3648
integer height = 2372
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss_003i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
if row < 1 then return ;
this.selectrow(row,true)

//dw_2.reset() ;
end event

event constructor;this.settransobject(sqlca)
end event

type cb_delete from commandbutton within w_piss003i
boolean visible = false
integer x = 4114
integer y = 40
integer width = 457
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "전체 삭제"
end type

event clicked;integer i
decimal{1} ln_tqty4
decimal	ln_tramt
string ls_xplant,ls_div,ls_itno,ls_tdte4,ls_srno,ls_srno1,ls_srno2,ls_sliptype

Setpointer(HourGlass!)

for i = 1 to dw_1.rowcount()
	ls_xplant 	= dw_1.object.xplant[i]
	ls_div	 	= dw_1.object.div[i]	
	ls_itno		= dw_1.object.inv401_itno[i]
	ls_tdte4		= dw_1.object.tdte4[i]	
	ls_sliptype	= dw_1.object.sel0006[i]
	ls_srno		= dw_1.object.sel0007[i]	
	ls_srno1		= dw_1.object.sel0008[i]		
	ls_srno2		= dw_1.object.sel0009[i]			
	ln_tqty4		= dw_1.object.tqty4[i]
	ln_tramt		= dw_1.object.inv401_tramt[i]
	delete from pbinv.inv401
	where comltd	= 	'01' 		and	sliptype = 	:ls_sliptype 	and
			srno		= 	:ls_srno	and	srno1		=	:ls_srno1		and
			srno2		=	:ls_srno2
	using sqlca ;
	update pbinv.inv101
		set intqty = intqty - :ln_tqty4 , intamt 	= intamt - :ln_tramt,
		    ohuqty = ohuqty - :ln_tqty4 , ohamt 	= ohamt 	- :ln_tramt
	where comltd = '01' and xplant = :ls_xplant and div = :ls_div and itno = :ls_itno
	using sqlca ;
next
end event

