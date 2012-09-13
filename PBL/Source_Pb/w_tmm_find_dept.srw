$PBExportHeader$w_tmm_find_dept.srw
$PBExportComments$외주업체 및 사용처 찾기
forward
global type w_tmm_find_dept from window
end type
type dw_find from u_vi_std_datawindow within w_tmm_find_dept
end type
type pb_find from picturebutton within w_tmm_find_dept
end type
type rb_supp from radiobutton within w_tmm_find_dept
end type
type rb_line from radiobutton within w_tmm_find_dept
end type
type sle_1 from singlelineedit within w_tmm_find_dept
end type
type cb_2 from commandbutton within w_tmm_find_dept
end type
type cb_enter from commandbutton within w_tmm_find_dept
end type
type gb_1 from groupbox within w_tmm_find_dept
end type
type gb_2 from groupbox within w_tmm_find_dept
end type
end forward

global type w_tmm_find_dept from window
integer x = 201
integer y = 500
integer width = 1765
integer height = 1448
boolean titlebar = true
string title = "사용처 찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
dw_find dw_find
pb_find pb_find
rb_supp rb_supp
rb_line rb_line
sle_1 sle_1
cb_2 cb_2
cb_enter cb_enter
gb_1 gb_1
gb_2 gb_2
end type
global w_tmm_find_dept w_tmm_find_dept

type variables

end variables

on w_tmm_find_dept.create
this.dw_find=create dw_find
this.pb_find=create pb_find
this.rb_supp=create rb_supp
this.rb_line=create rb_line
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_enter=create cb_enter
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_find,&
this.pb_find,&
this.rb_supp,&
this.rb_line,&
this.sle_1,&
this.cb_2,&
this.cb_enter,&
this.gb_1,&
this.gb_2}
end on

on w_tmm_find_dept.destroy
destroy(this.dw_find)
destroy(this.pb_find)
destroy(this.rb_supp)
destroy(this.rb_line)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_enter)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;string ls_gubun

ls_gubun = Message.Stringparm

CHOOSE CASE ls_gubun
	CASE '1'							//1.사내
		dw_find.dataobject = "d_find001_dac002"
		dw_find.Reset()
		rb_line.Checked = True
		rb_line.Enabled = True
		rb_supp.Checked = False
	CASE '2'							//2.외주업체(전체)
		dw_find.dataobject = "d_tmm_find_supplier"
		dw_find.Reset()
		rb_line.Checked = False
		rb_supp.Checked = True
		rb_supp.Enabled = True
	CASE ELSE
		dw_find.Reset()
		rb_line.Checked = True
		rb_line.Enabled = True
		rb_supp.Checked = False
		rb_supp.Enabled = True
END CHOOSE

end event

type dw_find from u_vi_std_datawindow within w_tmm_find_dept
integer x = 18
integer y = 280
integer width = 1632
integer height = 884
integer taborder = 40
string dataobject = "d_find001_dac002"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 1
end type

event doubleclicked;call super::doubleclicked;
If row < 1 Then Return

cb_enter.TriggerEvent( "Clicked" )


end event

event ue_key;call super::ue_key;If key = KeyEnter! Then 
	cb_enter.TriggerEvent( "Clicked" )
End If 

Return 1

end event

type pb_find from picturebutton within w_tmm_find_dept
integer x = 1280
integer y = 36
integer width = 361
integer height = 228
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;String	ls_Key
Long		ll_Row

dw_find.Reset()

ls_Key = Trim(sle_1.text)

If ls_Key = ''  Or isNull(ls_Key) Then
	ls_key = '%'
Else
	ls_Key = '%' + ls_Key + '%'
End If

dw_find.SetTransObject(sqlca)

ll_Row = dw_find.retrieve(ls_key)

If ll_Row < 1 Then
	MessageBox("확인","해당자료가 없습니다", Information!)
	Return
End If

dw_find.SetFocus()
dw_find.SelectRow(1,True)


end event

type rb_supp from radiobutton within w_tmm_find_dept
integer x = 50
integer y = 164
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "사외 업체"
end type

type rb_line from radiobutton within w_tmm_find_dept
integer x = 50
integer y = 80
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "사내 부서"
end type

type sle_1 from singlelineedit within w_tmm_find_dept
integer x = 571
integer y = 112
integer width = 645
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;
String	ls_data

ls_data = this.Text

If isNull(ls_data) Or Trim(ls_data) = '' Then return

pb_find.TriggerEvent( "Clicked" )


end event

type cb_2 from commandbutton within w_tmm_find_dept
integer x = 1317
integer y = 1180
integer width = 297
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
end type

event clicked;CloseWithReturn(parent, '')
end event

type cb_enter from commandbutton within w_tmm_find_dept
integer x = 983
integer y = 1180
integer width = 297
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;Long		ll_Row
string   ls_rtnparm

ll_Row		= dw_find.GetSelectedRow(0)
If ll_Row < 1 Then
	MessageBox("확인","데이타을 선택하세요", Information!)
	Return
End If

ls_rtnparm = dw_find.getitemstring(ll_row, 'returncode')

CloseWithReturn(Parent, ls_rtnparm)


end event

type gb_1 from groupbox within w_tmm_find_dept
integer x = 23
integer y = 12
integer width = 503
integer height = 252
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "조건"
end type

type gb_2 from groupbox within w_tmm_find_dept
integer x = 530
integer y = 12
integer width = 722
integer height = 252
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "검색어"
end type

