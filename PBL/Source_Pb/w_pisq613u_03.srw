$PBExportHeader$w_pisq613u_03.srw
$PBExportComments$이의제기 확정/취소 POP UP
forward
global type w_pisq613u_03 from window
end type
type em_manageno from editmask within w_pisq613u_03
end type
type st_2 from statictext within w_pisq613u_03
end type
type cb_cancel from commandbutton within w_pisq613u_03
end type
type cb_confirm from commandbutton within w_pisq613u_03
end type
type uo_division from u_pisc_select_division within w_pisq613u_03
end type
type uo_area from u_pisc_select_area within w_pisq613u_03
end type
type gb_1 from groupbox within w_pisq613u_03
end type
end forward

global type w_pisq613u_03 from window
integer width = 2112
integer height = 396
boolean titlebar = true
string title = "이의확정 실행 & 취소"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
em_manageno em_manageno
st_2 st_2
cb_cancel cb_cancel
cb_confirm cb_confirm
uo_division uo_division
uo_area uo_area
gb_1 gb_1
end type
global w_pisq613u_03 w_pisq613u_03

event ue_postopen();f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										TRUE, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
end event

on w_pisq613u_03.create
this.em_manageno=create em_manageno
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.cb_confirm=create cb_confirm
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_1=create gb_1
this.Control[]={this.em_manageno,&
this.st_2,&
this.cb_cancel,&
this.cb_confirm,&
this.uo_division,&
this.uo_area,&
this.gb_1}
end on

on w_pisq613u_03.destroy
destroy(this.em_manageno)
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.cb_confirm)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_1)
end on

event open;str_pisqwc_parm lstr

lstr = Message.PowerObjectParm

This.x = lstr.l_parm[1]
This.y = lstr.l_parm[2]

em_manageno.text = lstr.s_parm[1]

THIS.PostEvent('ue_postopen')
end event

type em_manageno from editmask within w_pisq613u_03
integer x = 480
integer y = 20
integer width = 539
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXX-XX-XXX"
end type

type st_2 from statictext within w_pisq613u_03
integer x = 32
integer y = 36
integer width = 466
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "보상관리번호:"
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_pisq613u_03
integer x = 1646
integer y = 144
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정취소"
end type

event clicked;int li_count
string ls_errormsg, ls_manageno, ls_area, ls_division

em_manageno.getdata(ls_manageno)
ls_area = uo_area.is_uo_areacode
ls_division = uo_division.is_uo_divisioncode

Select count(*) Into :li_count
From twclaimlist
Where ManClaimNo = :ls_manageno  
using sqleis;

if li_count < 1 then
	MessageBox("확인", "이의제기데이타가 없습니다. 확정할 수 없습니다.")
	return 0
end if

//확정데이타를 가지고 이의제기로 이동
sqleis.AutoCommit = False

UPDATE twclaimlist
Set Status = 'B'
Where ManClaimNo = :ls_manageno and AreaCode like :ls_area and
	DivisionCode like :ls_division using sqleis;

if sqleis.sqlnrows < 1 then
	ls_errormsg = 'Error03'
	Goto RollBack_
end if

UPDATE twadminlist
	Set Ingstatus = 'B'
	Where ManageNo = :ls_manageno 
	using sqleis;
	
if sqleis.sqlnrows < 1 then
	ls_errormsg = 'Error02'
	Goto RollBack_
end if

Commit using sqleis;
sqleis.AutoCommit = True
//QC담당자에게 메일발송
f_wc_send_email(ls_area,ls_division,'C','보상확정취소','해당보상청구건에 대해서 품질보증에서 ' &
	+ '보상확정을 취소하였으므로 ~r이의제기작업을 수행할 수 있습니다.' &
	,ls_manageno)
//끝
MessageBox("확인","정상적으로 처리되었습니다.")

close(w_pisq613u_03)
return 0
RollBack_:
RollBack using sqleis;
sqleis.AutoCommit = True
MessageBox("확인","처리중에 에러가 발생하였습니다." + ls_errormsg)
return 0
end event

type cb_confirm from commandbutton within w_pisq613u_03
integer x = 1184
integer y = 144
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정실행"
end type

event clicked;int li_count
string ls_errormsg, ls_manageno, ls_area, ls_division

em_manageno.getdata(ls_manageno)
ls_area = uo_area.is_uo_areacode
ls_division = uo_division.is_uo_divisioncode

Select count(*) Into :li_count
From twclaimlist
Where ManClaimNo = :ls_manageno  
using sqleis;

if li_count < 1 then
	MessageBox("확인", "이의제기데이타가 없습니다. 확정할 수 없습니다.")
	return 0
end if

sqleis.AutoCommit = False

// 이의상태, 확정수량, 확정금액 계산
UPDATE twclaimlist
Set Status = 'C',
	Confirmqty = ( aa.Payqty - bb.Objectionqty ),
	ConfirmAmount = ( aa.Payamount - bb.ObjectionAmount) 
FROM twclaimlist aa inner join twobjectionlist bb
	on aa.manclaimno = bb.manclaimno and aa.seqno = bb.seqno
Where aa.ManClaimNo = :ls_manageno and aa.AreaCode like :ls_area and
	aa.DivisionCode like :ls_division using sqleis;

if sqleis.sqlnrows < 1 then
	ls_errormsg = 'Error03'
	Goto RollBack_
end if

Select count(*) Into :li_count
From twclaimlist
Where ManClaimNo = :ls_manageno and AreaCode like :ls_area and
	DivisionCode like :ls_division and Status = 'B'
using sqleis;

if li_count > 0 then
	UPDATE twadminlist
	Set Ingstatus = 'B'
	Where ManageNo = :ls_manageno 
	using sqleis;
	
	if sqleis.sqlnrows < 1 then
		ls_errormsg = 'Error02'
		Goto RollBack_
	end if
else
	UPDATE twadminlist
	Set Ingstatus = 'D'
	Where ManageNo = :ls_manageno 
	using sqleis;
	
	if sqleis.sqlnrows < 1 then
		ls_errormsg = 'Error02'
		Goto RollBack_
	end if
end if

Commit using sqleis;
sqleis.AutoCommit = True
//QC담당자에게 메일발송
f_wc_send_email(ls_area,ls_division,'C','보상확정','해당보상청구건에 대해서 품질보증에서 ' &
	+ '보상확정을 수행하였으므로 ~r이의제기작업을 할 수 없습니다.' &
	,ls_manageno)
//끝
MessageBox("확인","정상적으로 처리되었습니다.")

close(w_pisq613u_03)
return 0
RollBack_:
RollBack using sqleis;
sqleis.AutoCommit = True
MessageBox("확인","처리중에 에러가 발생하였습니다." + ls_errormsg)
return 0
end event

type uo_division from u_pisc_select_division within w_pisq613u_03
integer x = 558
integer y = 152
integer taborder = 20
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_pisq613u_03
integer x = 59
integer y = 152
integer taborder = 10
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;ib_allflag = true
end event

event ue_select;call super::ue_select;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											TRUE, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
end event

type gb_1 from groupbox within w_pisq613u_03
integer x = 18
integer y = 108
integer width = 2057
integer height = 148
integer textsize = -4
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

