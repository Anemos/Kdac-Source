$PBExportHeader$w_pisr201b.srw
$PBExportComments$제품군별담당자등록
forward
global type w_pisr201b from window
end type
type cb_close from commandbutton within w_pisr201b
end type
type cb_delete from commandbutton within w_pisr201b
end type
type cb_save from commandbutton within w_pisr201b
end type
type cb_insert from commandbutton within w_pisr201b
end type
type dw_pisr201b_01 from datawindow within w_pisr201b
end type
type gb_1 from groupbox within w_pisr201b
end type
end forward

global type w_pisr201b from window
integer width = 2555
integer height = 1132
boolean titlebar = true
string title = "제품군별담당자관리"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_delete cb_delete
cb_save cb_save
cb_insert cb_insert
dw_pisr201b_01 dw_pisr201b_01
gb_1 gb_1
end type
global w_pisr201b w_pisr201b

type variables
string is_area, is_division
end variables

on w_pisr201b.create
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_insert=create cb_insert
this.dw_pisr201b_01=create dw_pisr201b_01
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_delete,&
this.cb_save,&
this.cb_insert,&
this.dw_pisr201b_01,&
this.gb_1}
end on

on w_pisr201b.destroy
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_insert)
destroy(this.dw_pisr201b_01)
destroy(this.gb_1)
end on

event open;str_parms lstr_parm
datawindowchild ldwc

dw_pisr201b_01.settransobject(sqlpis)

lstr_parm = message.PowerObjectparm
is_area = lstr_parm.string_arg[1]
is_division = lstr_parm.string_arg[2]

dw_pisr201b_01.GetChild('productgroup', ldwc)
ldwc.settransobject(sqlpis)
ldwc.retrieve(is_area, is_division, '%')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_pisr201b_01,'productgroup',ldwc,'productgroupname',10)

dw_pisr201b_01.retrieve(is_area, is_division)

end event

type cb_close from commandbutton within w_pisr201b
integer x = 2117
integer y = 884
integer width = 347
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;close(w_pisr201b)
end event

type cb_delete from commandbutton within w_pisr201b
integer x = 1248
integer y = 884
integer width = 347
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;long ll_selrow

ll_selrow = dw_pisr201b_01.getselectedrow(0)
if ll_selrow < 1 then
	messagebox("알림","삭제할 데이타를 선택해 주십시요")
	return 0
end if
dw_pisr201b_01.deleterow(ll_selrow)
end event

type cb_save from commandbutton within w_pisr201b
integer x = 1682
integer y = 884
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;dw_pisr201b_01.accepttext()

if dw_pisr201b_01.update() = 1 then
	messagebox("알림","정상적으로 저장되었습니다.")
else
	messagebox("알림","저장시에 에러가 발생하였습니다.")
end if
end event

type cb_insert from commandbutton within w_pisr201b
integer x = 814
integer y = 884
integer width = 347
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
end type

event clicked;long ll_currow

ll_currow = dw_pisr201b_01.insertrow(0)
dw_pisr201b_01.setitem(ll_currow, "areacode", is_area)
dw_pisr201b_01.setitem(ll_currow, "divisioncode", is_division)
end event

type dw_pisr201b_01 from datawindow within w_pisr201b
integer x = 9
integer y = 16
integer width = 2514
integer height = 828
integer taborder = 10
string dataobject = "d_pisr210b_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String 	ls_colName, ls_empname
String	ls_Null

this.AcceptText ( )
SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'empno'
		SELECT EmpName
			INTO :ls_empname 
		FROM TMSTEMP
		WHERE EmpNo = :data	
		USING	sqlpis	;
		
		if sqlpis.sqlcode <> 0 then
			this.SetItem(This.Getrow(), 'empno', ls_Null)
			return 1
		else
			this.SetItem(This.Getrow(), 'empname', ls_empname)
		end if
End Choose 

This.setitem(row, "lastemp", g_s_empno)

return 0
end event

event rowfocuschanged;String ls_orderno

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

type gb_1 from groupbox within w_pisr201b
integer x = 14
integer y = 844
integer width = 2505
integer height = 152
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

