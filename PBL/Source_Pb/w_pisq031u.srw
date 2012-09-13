$PBExportHeader$w_pisq031u.srw
$PBExportComments$검사기준서 검토(결재자선택 레스폰스 윈도우)
forward
global type w_pisq031u from window
end type
type gb_2 from groupbox within w_pisq031u
end type
type cb_consert from commandbutton within w_pisq031u
end type
type dw_pisq031u_01 from u_vi_std_datawindow within w_pisq031u
end type
type cb_ok from commandbutton within w_pisq031u
end type
type gb_1 from groupbox within w_pisq031u
end type
type dw_pisq031u_02 from u_vi_std_datawindow within w_pisq031u
end type
type st_1 from statictext within w_pisq031u
end type
type st_2 from statictext within w_pisq031u
end type
end forward

global type w_pisq031u from window
integer width = 2181
integer height = 1712
boolean titlebar = true
string title = "결재자선택"
windowtype windowtype = response!
long backcolor = 67108864
gb_2 gb_2
cb_consert cb_consert
dw_pisq031u_01 dw_pisq031u_01
cb_ok cb_ok
gb_1 gb_1
dw_pisq031u_02 dw_pisq031u_02
st_1 st_1
st_2 st_2
end type
global w_pisq031u w_pisq031u

type variables

String	is_areadivision
end variables

on w_pisq031u.create
this.gb_2=create gb_2
this.cb_consert=create cb_consert
this.dw_pisq031u_01=create dw_pisq031u_01
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.dw_pisq031u_02=create dw_pisq031u_02
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.gb_2,&
this.cb_consert,&
this.dw_pisq031u_01,&
this.cb_ok,&
this.gb_1,&
this.dw_pisq031u_02,&
this.st_1,&
this.st_2}
end on

on w_pisq031u.destroy
destroy(this.gb_2)
destroy(this.cb_consert)
destroy(this.dw_pisq031u_01)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.dw_pisq031u_02)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;
// 레스폰스 윈도우의 좌표를 재설정한다
//
This.x = 500
This.y = 570

// 레스폰스 윈도우의 타이틀을 재설정한다
//
this.title = 'w_pisq031u(결재자선택)'

is_areadivision = Message.StringParm

// 트랜잭션을 연결한다
//
dw_pisq031u_01.SetTransObject(SQLPIS)
dw_pisq031u_02.SetTransObject(SQLPIS)

// 데이타를 조회한다
//
dw_pisq031u_01.Retrieve(g_s_empno)
dw_pisq031u_02.Retrieve(mid(is_areadivision,1,1), mid(is_areadivision,2,1), g_s_empno)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq031u_01, 1, True)	
f_SetHighlight(dw_pisq031u_02, 1, True)	

end event

type gb_2 from groupbox within w_pisq031u
integer x = 32
integer y = 28
integer width = 2080
integer height = 180
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type cb_consert from commandbutton within w_pisq031u
integer x = 974
integer y = 1484
integer width = 384
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재자지정"
end type

event clicked;
String	ls_EmpNo, ls_empname

// 결재자를 구한다
//
ls_EmpNo		= dw_pisq031u_01.GetItemString(dw_pisq031u_01.GetSelectedRow(0), "EmpNo")
ls_empname	= dw_pisq031u_01.GetItemString(dw_pisq031u_01.GetSelectedRow(0), "EmpName")

// 선택된 결제자를 우측화면에 표시한다
//
IF dw_pisq031u_02.RowCount() = 0 THEN
	dw_pisq031u_02.InsertRow(0)
END IF
dw_pisq031u_02.SetItem(1, "consertempno", ls_EmpNo)
dw_pisq031u_02.SetItem(1, "empname", ls_empname)

// 저장에 필요한 기본자료를 셋트한다
//
dw_pisq031u_02.SetItem(1, "areacode"		, mid(is_areadivision,1,1))
dw_pisq031u_02.SetItem(1, "divisioncode"	, mid(is_areadivision,2,1))
dw_pisq031u_02.SetItem(1, "empno"			, g_s_empno)

f_SetHighlight(dw_pisq031u_02, 1, True)	


// 결재자 사번을 리턴한다
//
//CloseWithReturn(Parent, ls_EmpNo)
end event

type dw_pisq031u_01 from u_vi_std_datawindow within w_pisq031u
integer x = 27
integer y = 224
integer width = 1330
integer height = 1240
integer taborder = 20
string dataobject = "d_pisq031u_01"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
// 처리를 검사기준서 검토처리로 넘겨준다
//
//cb_ok.TriggerEvent (Clicked!)
end event

type cb_ok from commandbutton within w_pisq031u
integer x = 1733
integer y = 1484
integer width = 384
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "결재자선택"
end type

event clicked;
String	ls_EmpNo = ''
Int		li_save 

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq031u_02.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF

// 결재자 선택행의 사번을 구한다
//
ls_EmpNo	= dw_pisq031u_02.GetItemString(dw_pisq031u_02.GetSelectedRow(0), "consertempno")

// 결재자 사번을 리턴한다
//
CloseWithReturn(Parent, ls_EmpNo)
end event

type gb_1 from groupbox within w_pisq031u
integer width = 2149
integer height = 1612
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type dw_pisq031u_02 from u_vi_std_datawindow within w_pisq031u
integer x = 1376
integer y = 224
integer width = 741
integer height = 1240
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisq031u_02"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
// 처리를 검사기준서 검토처리로 넘겨준다
//
//cb_ok.TriggerEvent (Clicked!)
end event

type st_1 from statictext within w_pisq031u
integer x = 50
integer y = 60
integer width = 2025
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "결재자를 지정하시고 한번 지정된 결제자는 별도의 결재자지정을"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisq031u
integer x = 50
integer y = 124
integer width = 2025
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "하기 전까지는 계속 사용되여지며 결재자는 1인만 지정 가능합니다"
boolean focusrectangle = false
end type

