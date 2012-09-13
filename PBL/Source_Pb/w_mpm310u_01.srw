$PBExportHeader$w_mpm310u_01.srw
$PBExportComments$공정명변경 및 삭제
forward
global type w_mpm310u_01 from window
end type
type cb_close from commandbutton within w_mpm310u_01
end type
type cb_delete from commandbutton within w_mpm310u_01
end type
type cb_save from commandbutton within w_mpm310u_01
end type
type dw_1 from datawindow within w_mpm310u_01
end type
type sle_partno from singlelineedit within w_mpm310u_01
end type
type st_2 from statictext within w_mpm310u_01
end type
type sle_orderno from singlelineedit within w_mpm310u_01
end type
type st_1 from statictext within w_mpm310u_01
end type
type gb_1 from groupbox within w_mpm310u_01
end type
end forward

global type w_mpm310u_01 from window
integer width = 1733
integer height = 1064
boolean titlebar = true
string title = "공정명변경 및 공정삭제"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_delete cb_delete
cb_save cb_save
dw_1 dw_1
sle_partno sle_partno
st_2 st_2
sle_orderno sle_orderno
st_1 st_1
gb_1 gb_1
end type
global w_mpm310u_01 w_mpm310u_01

forward prototypes
public function integer wf_check_workjob (string ag_orderno, string ag_partno, string ag_operno)
end prototypes

public function integer wf_check_workjob (string ag_orderno, string ag_partno, string ag_operno);//------------------------------------
// 해당 공순에 대한 작업실적 존제유무 체크
// 실적존제 return -1, 실적이 없으면 return 0
//----------------------------------------------

integer li_count

Select count(*) into :li_count
From Tworkjob
Where orderno = :ag_orderno and partno = :ag_partno and
	operno = :ag_operno using sqlmpms;
	
if li_count > 0 then
	MessageBox("확인", "작업실적이 등록되어 있어, 변경이나 삭제할 수 없습니다.")
	return -1
else
	return 0
end if
end function

on w_mpm310u_01.create
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.dw_1=create dw_1
this.sle_partno=create sle_partno
this.st_2=create st_2
this.sle_orderno=create sle_orderno
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_delete,&
this.cb_save,&
this.dw_1,&
this.sle_partno,&
this.st_2,&
this.sle_orderno,&
this.st_1,&
this.gb_1}
end on

on w_mpm310u_01.destroy
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.sle_partno)
destroy(this.st_2)
destroy(this.sle_orderno)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;string ls_orderno, ls_partno
datawindowchild ldwc

ls_orderno = mid(Message.StringParm,1,8)
ls_partno = mid(Message.StringParm,9)
sle_orderno.text = string(ls_orderno,"@@@@-@@@@")
sle_partno.text = ls_partno
dw_1.settransobject(sqlmpms)

dw_1.GetChild('workstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_1,'workstatus',ldwc,'codename',5)

dw_1.retrieve(ls_orderno,ls_partno)
end event

type cb_close from commandbutton within w_mpm310u_01
integer x = 1248
integer y = 664
integer width = 402
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(w_mpm310u_01)
end event

type cb_delete from commandbutton within w_mpm310u_01
integer x = 1248
integer y = 468
integer width = 402
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;integer li_selrow, li_rtn
string ls_operno, ls_orderno, ls_partno

li_selrow = dw_1.getselectedrow(0)

if li_selrow < 1 then
	MessageBox("확인","선택된 데이타가 없습니다.")
	return 0
else
	ls_orderno = dw_1.getitemstring(li_selrow,'orderno')
	ls_partno = dw_1.getitemstring(li_selrow,'partno')
	ls_operno = dw_1.getitemstring(li_selrow,'operno')
	if wf_check_workjob(ls_orderno,ls_partno,ls_operno) = -1 then
		return 0
	end if
end if

li_rtn = MessageBox("확인", "해당 공순 " + ls_operno + " 을 삭제하시겠습니까?" &
			,Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if

sqlmpms.AutoCommit = False

Delete From Trouting
Where Orderno = :ls_orderno and Partno = :ls_partno and
	Operno = :ls_operno using sqlmpms;
	
if sqlmpms.sqlcode = 0 then
	MessageBox("확인","정상적으로 처리되었습니다.")
	Commit using sqlmpms;
else
	MessageBox("확인","처리중에 에러가 발생하였습니다")
	Rollback using sqlmpms;
end if
sqlmpms.AutoCommit = True

dw_1.reset()
dw_1.retrieve(ls_orderno,ls_partno)
end event

type cb_save from commandbutton within w_mpm310u_01
integer x = 1248
integer y = 272
integer width = 402
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;
if dw_1.modifiedcount() < 1 then
	return 0
end if

sqlmpms.AutoCommit = False
if dw_1.update() = 1 then
	MessageBox("확인","정상적으로 처리되었습니다.")
	Commit using sqlmpms;
else
	MessageBox("확인","처리중에 에러가 발생하였습니다.")
	Rollback using sqlmpms;
end if
sqlmpms.AutoCommit = True
end event

type dw_1 from datawindow within w_mpm310u_01
integer x = 23
integer y = 152
integer width = 1143
integer height = 780
integer taborder = 40
string title = "none"
string dataobject = "d_mpm310u_01_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
end event

event itemchanged;string ls_colname, ls_orderno, ls_partno, ls_operno
string ls_wccode

ls_colname = dwo.name

if ls_colname = 'wccode' then
	ls_orderno = This.getitemstring(row,'orderno')
	ls_partno = This.getitemstring(row,'partno')
	ls_operno = This.getitemstring(row,'operno')
	
	if wf_check_workjob(ls_orderno,ls_partno,ls_operno) = -1 then
		Select wccode into :ls_wccode
		From Trouting
		Where Orderno = :ls_orderno and Partno = :ls_partno and
			Operno = :ls_operno using sqlmpms;
			
		This.setitem(row,'wccode',ls_wccode)
		
		return 2
	end if
end if
end event

type sle_partno from singlelineedit within w_mpm310u_01
integer x = 1211
integer y = 44
integer width = 402
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mpm310u_01
integer x = 910
integer y = 52
integer width = 325
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Part No:"
boolean focusrectangle = false
end type

type sle_orderno from singlelineedit within w_mpm310u_01
integer x = 402
integer y = 44
integer width = 457
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_mpm310u_01
integer x = 59
integer y = 52
integer width = 357
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Order No:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_mpm310u_01
integer x = 23
integer width = 1673
integer height = 144
integer taborder = 10
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

