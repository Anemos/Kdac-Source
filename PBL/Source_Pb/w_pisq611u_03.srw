$PBExportHeader$w_pisq611u_03.srw
$PBExportComments$보증기간, 분담율 등록
forward
global type w_pisq611u_03 from window
end type
type cb_cancel from commandbutton within w_pisq611u_03
end type
type cb_save from commandbutton within w_pisq611u_03
end type
type dw_1 from datawindow within w_pisq611u_03
end type
end forward

global type w_pisq611u_03 from window
integer width = 2693
integer height = 1000
boolean titlebar = true
string title = "보증기간,분담율등록"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_save cb_save
dw_1 dw_1
end type
global w_pisq611u_03 w_pisq611u_03

on w_pisq611u_03.create
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_1=create dw_1
this.Control[]={this.cb_cancel,&
this.cb_save,&
this.dw_1}
end on

on w_pisq611u_03.destroy
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;datawindowchild ldwc
str_pisqwc_parm lstr
string ls_custcode

dw_1.settransobject(sqleis)
lstr = Message.PowerObjectParm
ls_custcode = lstr.s_parm[1]

dw_1.GetChild('assurecode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve()
f_pisc_set_dddw_width(dw_1,'assurecode',ldwc,'codename',10)

dw_1.GetChild('allotcode', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve(ls_custcode)
f_pisc_set_dddw_width(dw_1,'allotcode',ldwc,'codename',10)

dw_1.GetChild('itemcheck', ldwc)
ldwc.settransobject(sqleis)
ldwc.retrieve('WCS008')
f_pisc_set_dddw_width(dw_1,'itemcheck',ldwc,'codename',10)

dw_1.insertrow(0)
dw_1.setitem(1,'custcode',			lstr.s_parm[1])
dw_1.setitem(1,'exportgubun',		lstr.s_parm[2])
dw_1.setitem(1,'oagubun',			lstr.s_parm[3])
dw_1.setitem(1,'productid',		lstr.s_parm[4])
dw_1.setitem(1,'reasonitemcode',	lstr.s_parm[5])
dw_1.setitem(1,'carcode',			lstr.s_parm[6])

end event

type cb_cancel from commandbutton within w_pisq611u_03
integer x = 2167
integer y = 764
integer width = 416
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

event clicked;closewithreturn(w_pisq611u_03,'cancel')
end event

type cb_save from commandbutton within w_pisq611u_03
integer x = 1669
integer y = 764
integer width = 416
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

event clicked;string ls_custcode, ls_exportgubun, ls_oagubun, ls_productid, ls_assurecode
string ls_reasonitemcode, ls_carcode, ls_assureid, ls_message, ls_itemcheck
string ls_allotcode

dw_1.accepttext()
ls_custcode = dw_1.getitemstring(1,'custcode')
ls_exportgubun = dw_1.getitemstring(1,'exportgubun')
ls_oagubun = dw_1.getitemstring(1,'oagubun')
ls_productid = dw_1.getitemstring(1,'productid')
ls_assurecode = dw_1.getitemstring(1,'assurecode')
ls_reasonitemcode = dw_1.getitemstring(1,'reasonitemcode')
ls_carcode = dw_1.getitemstring(1,'carcode')
ls_allotcode = dw_1.getitemstring(1,'allotcode')
ls_itemcheck = dw_1.getitemstring(1,'itemcheck')

if f_spacechk(ls_assurecode) = -1 or f_spacechk(ls_allotcode) = -1 or f_spacechk(ls_itemcheck) = -1 then
	Messagebox("알림","누락된 정보가 있습니다.")
	return 0
end if

ls_assureid = ls_custcode + ls_exportgubun + ls_oagubun + ls_productid + ls_assurecode

sqleis.AutoCommit = false

UPDATE TWASSURETERM
SET CustCode = :ls_custcode,
	ExportGubun = :ls_exportgubun,
	OaGubun = :ls_oagubun,
	ProductId = :ls_productid,
	AssureCode = :ls_assurecode 
WHERE AssureId = :ls_assureid using sqleis;

if sqleis.sqlnrows < 1 then
	INSERT INTO TWASSURETERM( AssureId, CustCode, ExportGubun, OaGubun, ProductId, AssureCode)
	VALUES( :ls_assureid, :ls_custcode, :ls_exportgubun, :ls_oagubun, :ls_productid, :ls_assurecode)
	using sqleis;
	
	if sqleis.sqlcode <> 0 then
		ls_message = "보증ID 적용시에 에러가 발생하였습니다."
		goto RollBack_
	end if
end if

INSERT INTO TWAPPLYALLOT( ReasonItemCode, CarCode, AssureId, Itemcheck, AllotCode, LastEmp )
VALUES (:ls_reasonitemcode, :ls_carcode, :ls_assureid, :ls_itemcheck, :ls_allotcode, :g_s_empno )
using sqleis;
if sqleis.sqlcode <> 0 then
	ls_message = "분담율 적용시에 에러가 발생하였습니다."
	goto RollBack_
end if

Commit using sqleis;
sqleis.AutoCommit = True
Messagebox("알림", "정상적으로 저장되었습니다.")
closewithreturn(w_pisq611u_03,'OK')

RollBack_:
Rollback using sqleis;
sqleis.AutoCommit = True
Messagebox("에러", ls_message)
return 0
end event

type dw_1 from datawindow within w_pisq611u_03
integer x = 5
integer width = 2661
integer height = 788
integer taborder = 10
string title = "none"
string dataobject = "d_pisq611u_03_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

