$PBExportHeader$w_piss080i.srw
$PBExportComments$ÃâÇÏ¿äÃ»¼­(¹Ì³³º¸±â)
forward
global type w_piss080i from window
end type
type st_itemcode from statictext within w_piss080i
end type
type st_invqty from statictext within w_piss080i
end type
type st_3 from statictext within w_piss080i
end type
type st_modelid from statictext within w_piss080i
end type
type st_modelname from statictext within w_piss080i
end type
type st_rackqty from statictext within w_piss080i
end type
type st_2 from statictext within w_piss080i
end type
type st_1 from statictext within w_piss080i
end type
type cb_1 from commandbutton within w_piss080i
end type
type dw_minap_detail from datawindow within w_piss080i
end type
type gb_1 from groupbox within w_piss080i
end type
type wstr_releasekb from structure within w_piss080i
end type
end forward

type wstr_releasekb from structure
	integer		stri_kborder[]
	string		strs_kbno[]
end type

global type w_piss080i from window
integer x = 1074
integer y = 484
integer width = 3803
integer height = 2160
boolean titlebar = true
string title = "¹Ì³³º¸±â"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_itemcode st_itemcode
st_invqty st_invqty
st_3 st_3
st_modelid st_modelid
st_modelname st_modelname
st_rackqty st_rackqty
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_minap_detail dw_minap_detail
gb_1 gb_1
end type
global w_piss080i w_piss080i

on w_piss080i.create
this.st_itemcode=create st_itemcode
this.st_invqty=create st_invqty
this.st_3=create st_3
this.st_modelid=create st_modelid
this.st_modelname=create st_modelname
this.st_rackqty=create st_rackqty
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_minap_detail=create dw_minap_detail
this.gb_1=create gb_1
this.Control[]={this.st_itemcode,&
this.st_invqty,&
this.st_3,&
this.st_modelid,&
this.st_modelname,&
this.st_rackqty,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.dw_minap_detail,&
this.gb_1}
end on

on w_piss080i.destroy
destroy(this.st_itemcode)
destroy(this.st_invqty)
destroy(this.st_3)
destroy(this.st_modelid)
destroy(this.st_modelname)
destroy(this.st_rackqty)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_minap_detail)
destroy(this.gb_1)
end on

event open;long 		ll_rackqty,ll_invqty
string 	ls_itemname, ls_modelid,ls_itemcode,ls_areacode,ls_divisioncode,ls_applydate
string   ls_data

ls_data = Message.StringParm

ls_areacode     = mid(ls_data,1,1)
ls_divisioncode = mid(ls_data,2,1)
ls_applydate    = mid(ls_data,3,10)
ls_itemcode = trim(mid(ls_data,13,12))
st_itemcode.text = ls_itemcode
select top 1 ModelID, RackQty 
  into :ls_modelID, :ll_rackqty 
  from tmstkb 
 where itemcode = :ls_itemcode
   and areacode = :ls_areacode
	and divisioncode = :ls_divisioncode
	using sqlpis;
st_modelid.text	= ls_modelId
st_rackqty.text	= String(ll_rackqty, "#,##0")

select top 1 invqty
  into :ll_invqty
  from tinv
 where itemcode = :ls_itemcode
   and areacode = :ls_areacode
	and divisioncode = :ls_divisioncode
	using sqlpis;
st_invqty.text	= String(ll_invqty, "#,##0")

select itemname 
  into :ls_itemname 
  from tmstitem 
  where itemcode = :ls_itemcode
  using sqlpis;

if ls_itemname = '' or isnull(ls_itemname) then
	ls_itemname = ls_itemcode
end if	
  st_modelname.text	= ls_itemname
dw_minap_detail.SetTransObject(SQLPIS)
dw_minap_detail.Retrieve(ls_areacode,ls_divisioncode,ls_applydate,ls_itemcode)
end event

type st_itemcode from statictext within w_piss080i
integer x = 471
integer y = 84
integer width = 590
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_invqty from statictext within w_piss080i
integer x = 471
integer y = 180
integer width = 590
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss080i
integer x = 91
integer y = 192
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "ÇöÀç°í¼ö·®"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_modelid from statictext within w_piss080i
integer x = 2610
integer y = 84
integer width = 594
integer height = 164
integer textsize = -24
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_modelname from statictext within w_piss080i
integer x = 1070
integer y = 84
integer width = 1335
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_rackqty from statictext within w_piss080i
integer x = 471
integer y = 272
integer width = 590
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_piss080i
integer x = 50
integer y = 280
integer width = 416
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 12632256
boolean enabled = false
string text = "±âÁØ¼ö¿ë¼ö"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_piss080i
integer x = 50
integer y = 92
integer width = 416
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 12632256
boolean enabled = false
string text = "Ç°      ¸í"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_piss080i
integer x = 2775
integer y = 272
integer width = 293
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
string text = "Á¾·á"
end type

event clicked;Close(parent)
end event

type dw_minap_detail from datawindow within w_piss080i
integer x = 14
integer y = 432
integer width = 3753
integer height = 1620
integer taborder = 30
string dataobject = "d_piss080i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss080i
integer x = 23
integer y = 24
integer width = 3255
integer height = 380
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long backcolor = 12632256
end type

