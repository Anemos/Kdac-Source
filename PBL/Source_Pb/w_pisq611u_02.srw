$PBExportHeader$w_pisq611u_02.srw
$PBExportComments$원인품번 필요정보등록
forward
global type w_pisq611u_02 from window
end type
type cb_cancel from commandbutton within w_pisq611u_02
end type
type cb_save from commandbutton within w_pisq611u_02
end type
type dw_1 from datawindow within w_pisq611u_02
end type
end forward

global type w_pisq611u_02 from window
integer width = 2592
integer height = 892
boolean titlebar = true
string title = "원인품번 등록화면"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_save cb_save
dw_1 dw_1
end type
global w_pisq611u_02 w_pisq611u_02

on w_pisq611u_02.create
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_1=create dw_1
this.Control[]={this.cb_cancel,&
this.cb_save,&
this.dw_1}
end on

on w_pisq611u_02.destroy
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;datawindowchild ldwc
string ls_custcode, ls_reasonitemcode, ls_exportgubun, ls_oagubun, ls_carcode
string ls_crud, ls_reasonitemname
str_pisqwc_parm lstr

dw_1.settransobject(sqleis)
lstr = Message.PowerObjectParm
ls_custcode = lstr.s_parm[1]
ls_reasonitemcode = lstr.s_parm[2]
ls_crud = lstr.s_parm[3]
ls_reasonitemname = lstr.s_parm[4]

// SET CODE DATAWINDOW dw_1
dw_1.GetChild('accarea', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','D')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_1,'accarea',ldwc,'areaname',10)

dw_1.GetChild('accdivision', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('%','D','A')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_1,'accdivision',ldwc,'divisionname',10)

dw_1.GetChild('productid', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('D','A')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_1,'productid',ldwc,'codename',10)

dw_1.GetChild('itemgubun', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_pisc_set_dddw_width(dw_1,'itemgubun',ldwc,'codename',10)

if ls_crud = 'C' then
	dw_1.insertrow(0)
	dw_1.setitem(1,'reasonitemcode',ls_reasonitemcode)
	dw_1.setitem(1,'reasonitemname',ls_reasonitemname)
	dw_1.setitem(1,'custcode',ls_custcode)
	dw_1.setitem(1,'lastemp',g_s_empno)
else
	dw_1.retrieve(ls_custcode,ls_reasonitemcode)
end if
end event

type cb_cancel from commandbutton within w_pisq611u_02
integer x = 1998
integer y = 660
integer width = 393
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;closewithreturn(w_pisq611u_02,'cancel')
end event

type cb_save from commandbutton within w_pisq611u_02
integer x = 1518
integer y = 660
integer width = 393
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;string ls_accarea, ls_accdivision, ls_productid, ls_reasonitemname, ls_itemgubun
string ls_custcode, ls_reasonitemcode

dw_1.accepttext()
ls_accarea = dw_1.getitemstring(1,'accarea')
ls_accdivision = dw_1.getitemstring(1,'accdivision')
ls_productid = dw_1.getitemstring(1,'productid')
ls_reasonitemcode = dw_1.getitemstring(1,'reasonitemcode')
ls_reasonitemname = dw_1.getitemstring(1,'reasonitemname')
ls_itemgubun = dw_1.getitemstring(1,'itemgubun')
ls_custcode = dw_1.getitemstring(1,'custcode')

if f_spacechk(ls_accarea) = -1 or f_spacechk(ls_accdivision) = -1 or &
	f_spacechk(ls_productid) = -1 or f_spacechk(ls_reasonitemname) = -1 or &
	f_spacechk(ls_itemgubun) = -1 then
	messagebox("알림","입력되지 않은 정보가 있습니다.")
	return 0
end if

sqleis.AutoCommit = false
//원인품번등록
if dw_1.update() <> 1 then
	Messagebox("에러","원인품번등록시에 에러가 발생하였습니다.")
	Rollback using sqleis;
	sqleis.Autocommit = true
	return 0
end if

Commit using sqleis;
sqleis.Autocommit = true
closewithreturn(w_pisq611u_02,'OK')
end event

type dw_1 from datawindow within w_pisq611u_02
integer x = 23
integer y = 16
integer width = 2533
integer height = 624
integer taborder = 10
string title = "none"
string dataobject = "d_pisq611u_02_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_areacode, ls_custcode, ls_exportgubun, ls_oagubun
string ls_assurecode, ls_allotcode, ls_analyzecontent
datawindowchild ldwc

ls_colname = dwo.name

if ls_colname = 'accarea' then
	This.GetChild('accdivision', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve('%',data,'%')
	if ldwc.RowCount() < 1 then
		ldwc.InsertRow(0)
	end if
	f_pisc_set_dddw_width(dw_1,'accdivision',ldwc,'divisionname',5)
	
	This.GetChild('productid', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve(data,'X')
	if ldwc.RowCount() < 1 then
		ldwc.InsertRow(0)
	end if
	f_pisc_set_dddw_width(dw_1,'productid',ldwc,'codename',5)
end if

if ls_colname = 'accdivision' then
	ls_areacode = This.getitemstring(row,'accarea')
	This.GetChild('productid', ldwc)
	ldwc.settransobject(sqleis)
	ldwc.retrieve(ls_areacode,data)
	if ldwc.RowCount() < 1 then
		ldwc.InsertRow(0)
	end if
	f_pisc_set_dddw_width(dw_1,'productid',ldwc,'codename',5)
end if
end event

