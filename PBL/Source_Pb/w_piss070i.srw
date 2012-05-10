$PBExportHeader$w_piss070i.srw
$PBExportComments$출하요청서(일별보기)
forward
global type w_piss070i from window
end type
type st_itemcode from statictext within w_piss070i
end type
type st_modelid from statictext within w_piss070i
end type
type st_rackqty from statictext within w_piss070i
end type
type st_6 from statictext within w_piss070i
end type
type st_itemname from statictext within w_piss070i
end type
type st_3 from statictext within w_piss070i
end type
type st_2 from statictext within w_piss070i
end type
type st_1 from statictext within w_piss070i
end type
type cb_1 from commandbutton within w_piss070i
end type
type dw_1 from datawindow within w_piss070i
end type
end forward

global type w_piss070i from window
integer x = 599
integer y = 484
integer width = 3694
integer height = 2120
boolean titlebar = true
string title = "일별보기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
st_itemcode st_itemcode
st_modelid st_modelid
st_rackqty st_rackqty
st_6 st_6
st_itemname st_itemname
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
end type
global w_piss070i w_piss070i

type variables
string is_areacode,is_divisioncode,is_itemcode
Boolean	ib_open
end variables

on w_piss070i.create
this.st_itemcode=create st_itemcode
this.st_modelid=create st_modelid
this.st_rackqty=create st_rackqty
this.st_6=create st_6
this.st_itemname=create st_itemname
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_itemcode,&
this.st_modelid,&
this.st_rackqty,&
this.st_6,&
this.st_itemname,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.dw_1}
end on

on w_piss070i.destroy
destroy(this.st_itemcode)
destroy(this.st_modelid)
destroy(this.st_rackqty)
destroy(this.st_6)
destroy(this.st_itemname)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long 		ll_rackqty, ll_currentQty
string 	ls_itemname, ls_modelid, ls_applydate
string ls_parm  
ls_parm = Trim(Message.StringParm)

is_areacode = mid(ls_parm,1,1)
is_divisioncode = mid(ls_parm,2,1)
is_itemcode = trim(mid(ls_parm,3,12))

dw_1.SetTransObject(SQLPIS)

dw_1.Retrieve(is_areacode,is_divisioncode,is_itemcode)

select distinct ModelID, RackQty 
  into :ls_modelID, :ll_rackqty 
  from tmstkb 
 where itemcode = :is_itemcode
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
	using sqlpis;
st_modelid.text	= ls_modelId
st_rackqty.text	= String(ll_rackqty, "#,##0")

select itemname into :ls_itemname 
 from tmstitem 
where itemcode = :is_itemcode
using sqlpis;
if ls_itemname = '' or isnull(ls_itemname) then
	ls_itemname = is_itemcode
end if	
st_itemcode.text  = is_itemcode
st_itemname.text	= ls_itemname

Select Invqty + repairqty
  into :ll_currentQty 
  from tinv
 where itemcode = :is_itemcode
   and areacode = :is_areacode
	and divisioncode = :is_divisioncode
 using sqlpis;
st_6.Text			= String(ll_currentQty, "#,##0")


end event

type st_itemcode from statictext within w_piss070i
integer x = 480
integer y = 56
integer width = 521
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_modelid from statictext within w_piss070i
integer x = 2779
integer y = 28
integer width = 823
integer height = 184
integer textsize = -36
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_rackqty from statictext within w_piss070i
integer x = 480
integer y = 260
integer width = 782
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_piss070i
integer x = 480
integer y = 152
integer width = 782
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_itemname from statictext within w_piss070i
integer x = 800
integer y = 56
integer width = 1577
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss070i
integer x = 105
integer y = 276
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "기준수용수"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_piss070i
integer x = 105
integer y = 168
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "현재고수량"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_piss070i
integer x = 105
integer y = 68
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "품      명"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_piss070i
integer x = 3378
integer y = 252
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;CLOSE(PARENT)
end event

type dw_1 from datawindow within w_piss070i
integer x = 50
integer y = 376
integer width = 3584
integer height = 1624
integer taborder = 10
string dataobject = "d_piss070i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

