$PBExportHeader$w_mpm410u_01.srw
$PBExportComments$납기예정 옵션설정
forward
global type w_mpm410u_01 from window
end type
type st_message from statictext within w_mpm410u_01
end type
type cb_close from commandbutton within w_mpm410u_01
end type
type pb_run from picturebutton within w_mpm410u_01
end type
type dw_mpm410u_01_right from datawindow within w_mpm410u_01
end type
type dw_mpm410u_01_left from datawindow within w_mpm410u_01
end type
type gb_1 from groupbox within w_mpm410u_01
end type
type gb_2 from groupbox within w_mpm410u_01
end type
end forward

global type w_mpm410u_01 from window
integer width = 3113
integer height = 1200
boolean titlebar = true
string title = "납기예정 옵션설정"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
st_message st_message
cb_close cb_close
pb_run pb_run
dw_mpm410u_01_right dw_mpm410u_01_right
dw_mpm410u_01_left dw_mpm410u_01_left
gb_1 gb_1
gb_2 gb_2
end type
global w_mpm410u_01 w_mpm410u_01

type variables

end variables

forward prototypes
public function string wf_get_serialno ()
end prototypes

public function string wf_get_serialno ();string ls_serialno

DECLARE up_get_serialno PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'PUR'  
	 using sqlmpms;

Execute up_get_serialno;

if sqlmpms.sqlcode = 0 then
	fetch up_get_serialno into :ls_serialno;
	close up_get_serialno;
end if

return ls_serialno
end function

on w_mpm410u_01.create
this.st_message=create st_message
this.cb_close=create cb_close
this.pb_run=create pb_run
this.dw_mpm410u_01_right=create dw_mpm410u_01_right
this.dw_mpm410u_01_left=create dw_mpm410u_01_left
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_message,&
this.cb_close,&
this.pb_run,&
this.dw_mpm410u_01_right,&
this.dw_mpm410u_01_left,&
this.gb_1,&
this.gb_2}
end on

on w_mpm410u_01.destroy
destroy(this.st_message)
destroy(this.cb_close)
destroy(this.pb_run)
destroy(this.dw_mpm410u_01_right)
destroy(this.dw_mpm410u_01_left)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;datawindowchild ldwc

dw_mpm410u_01_left.settransobject(sqlmpms)
dw_mpm410u_01_right.settransobject(sqlmpms)

dw_mpm410u_01_left.insertrow(0)
dw_mpm410u_01_left.GetChild('versionno', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM011')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm410u_01_left,'versionno',ldwc,'codename',5)

dw_mpm410u_01_right.reset()

return 0
end event

type st_message from statictext within w_mpm410u_01
integer x = 32
integer y = 1004
integer width = 3035
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_mpm410u_01
integer x = 2395
integer y = 132
integer width = 517
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(w_mpm410u_01)
end event

type pb_run from picturebutton within w_mpm410u_01
integer x = 1641
integer y = 132
integer width = 658
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\run.bmp"
alignment htextalign = left!
end type

event clicked;//* BATCH 생성작업으로 서버부하에 미치는 영향이 크기땜시...
//* COMMIT, ROLLBACK 을 적용하지 않는다.

string ls_message, ls_versionno

setpointer(HourGlass!)
st_message.text = ""
if dw_mpm410u_01_right.update() <> 1 then
	ls_message = "납기생성을 위한 세부정보 저장시에 오류가 발생하였습니다."
	goto Rollback_
end if

ls_versionno = dw_mpm410u_01_left.getitemstring(1,"versionno")

//금형, 품목정보 우선순위정보 생성
DECLARE up_create_loadpriority PROCEDURE FOR sp_mpms_create_tloadpriority 
	 @ps_versionno = :ls_versionno
using sqlmpms;

Execute up_create_loadpriority;

if sqlmpms.sqlcode = -1 then
	ls_message = "우선순위정보 생성 중에 에러가 발생하였습니다. : " + string(sqlmpms.sqlcode)
	goto Rollback_
end if

//예상납기정보 생성
DECLARE up_create_tloadsimulation PROCEDURE FOR sp_mpms_create_tloadsimulation 
	 @ps_versionno = :ls_versionno
using sqlmpms;

Execute up_create_tloadsimulation;

if sqlmpms.sqlcode = -1 then
	ls_message = "예상납기정보 생성중에 에러가 발생하였습니다. : " + string(sqlmpms.sqlcode)
	goto Rollback_
end if

st_message.text = "정상적으로 처리되었습니다."
return 0

Rollback_:
st_message.text = ls_message

return -1
end event

type dw_mpm410u_01_right from datawindow within w_mpm410u_01
integer x = 69
integer y = 400
integer width = 2958
integer height = 548
integer taborder = 40
string dataobject = "d_mpm410u_01_right"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_gubun, ls_rtnparm
str_mpms_xy str_lxy

choose case dwo.name 
	case 'b_startdate'
		str_lxy.lx = parent.PointerX() + 1400
		str_lxy.ly = parent.PointerY() + 1050
		openwithparm(w_mpms_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return 0
		Else
			ls_rtnparm = Message.StringParm   // powerobject
		End If	
		
		This.SetItem(row, 'startdate', date(ls_rtnparm))
	case 'b_enddate'
		str_lxy.lx = parent.PointerX() + 1400
		str_lxy.ly = parent.PointerY() + 1050
		openwithparm(w_mpms_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return 0
		Else
			ls_rtnparm = Message.StringParm   // powerobject
		End If	
		
		This.SetItem(row, 'enddate', date(ls_rtnparm))
end choose

return 0
end event

type dw_mpm410u_01_left from datawindow within w_mpm410u_01
integer x = 55
integer y = 116
integer width = 1477
integer height = 152
integer taborder = 30
string dataobject = "d_mpm410u_01_left"
boolean border = false
borderstyle borderstyle = styleraised!
end type

event itemchanged;long ll_rowcnt

dw_mpm410u_01_right.reset()

ll_rowcnt = dw_mpm410u_01_right.retrieve(data)
if ll_rowcnt < 1 then
	dw_mpm410u_01_right.insertrow(0)
	dw_mpm410u_01_right.setitem(1,"versionno",data)
	dw_mpm410u_01_right.setitem(1,"applyratio",95)
	dw_mpm410u_01_right.setitem(1,"overwork",'N')
	dw_mpm410u_01_right.setitem(1,"specialwork",'N')
	dw_mpm410u_01_right.setitem(1,"nightwork",'N')
	dw_mpm410u_01_right.setitem(1,"startdate",date('1900-01-01'))
	dw_mpm410u_01_right.setitem(1,"enddate",date('9999-12-31'))
	dw_mpm410u_01_right.setitem(1,"lastemp",g_s_empno)
end if
end event

type gb_1 from groupbox within w_mpm410u_01
integer x = 23
integer y = 44
integer width = 3040
integer height = 244
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "납기버전"
end type

type gb_2 from groupbox within w_mpm410u_01
integer x = 23
integer y = 332
integer width = 3054
integer height = 636
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "세부정보"
end type

