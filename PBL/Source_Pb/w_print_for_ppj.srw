$PBExportHeader$w_print_for_ppj.srw
$PBExportComments$Print시 조건 Window for 박병주
forward
global type w_print_for_ppj from window
end type
type st_4 from statictext within w_print_for_ppj
end type
type cb_1 from commandbutton within w_print_for_ppj
end type
type cb_ok from commandbutton within w_print_for_ppj
end type
type cbx_collate from checkbox within w_print_for_ppj
end type
type cbx_file from checkbox within w_print_for_ppj
end type
type st_3 from statictext within w_print_for_ppj
end type
type em_copies from editmask within w_print_for_ppj
end type
type ddlb_range from dropdownlistbox within w_print_for_ppj
end type
type st_2 from statictext within w_print_for_ppj
end type
type st_1 from statictext within w_print_for_ppj
end type
type sle_page from singlelineedit within w_print_for_ppj
end type
type rb_page from radiobutton within w_print_for_ppj
end type
type rb_current from radiobutton within w_print_for_ppj
end type
type rb_all from radiobutton within w_print_for_ppj
end type
type gb_range from groupbox within w_print_for_ppj
end type
type gb_copy from groupbox within w_print_for_ppj
end type
end forward

global type w_print_for_ppj from window
integer width = 2491
integer height = 992
boolean titlebar = true
string title = "인쇄조건"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Information!"
st_4 st_4
cb_1 cb_1
cb_ok cb_ok
cbx_collate cbx_collate
cbx_file cbx_file
st_3 st_3
em_copies em_copies
ddlb_range ddlb_range
st_2 st_2
st_1 st_1
sle_page sle_page
rb_page rb_page
rb_current rb_current
rb_all rb_all
gb_range gb_range
gb_copy gb_copy
end type
global w_print_for_ppj w_print_for_ppj

type variables
DataWindow	idw_dw
String	is_Page = 'all'
Int	ii_RangeInclude = 0
end variables

on w_print_for_ppj.create
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_ok=create cb_ok
this.cbx_collate=create cbx_collate
this.cbx_file=create cbx_file
this.st_3=create st_3
this.em_copies=create em_copies
this.ddlb_range=create ddlb_range
this.st_2=create st_2
this.st_1=create st_1
this.sle_page=create sle_page
this.rb_page=create rb_page
this.rb_current=create rb_current
this.rb_all=create rb_all
this.gb_range=create gb_range
this.gb_copy=create gb_copy
this.Control[]={this.st_4,&
this.cb_1,&
this.cb_ok,&
this.cbx_collate,&
this.cbx_file,&
this.st_3,&
this.em_copies,&
this.ddlb_range,&
this.st_2,&
this.st_1,&
this.sle_page,&
this.rb_page,&
this.rb_current,&
this.rb_all,&
this.gb_range,&
this.gb_copy}
end on

on w_print_for_ppj.destroy
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.cbx_collate)
destroy(this.cbx_file)
destroy(this.st_3)
destroy(this.em_copies)
destroy(this.ddlb_range)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_page)
destroy(this.rb_page)
destroy(this.rb_current)
destroy(this.rb_all)
destroy(this.gb_range)
destroy(this.gb_copy)
end on

event activate;
f_center_window(This)
end event

event open;
idw_dw = Message.PowerObjectParm
end event

type st_4 from statictext within w_print_for_ppj
integer x = 197
integer y = 772
integer width = 165
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "인쇄"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_print_for_ppj
integer x = 2080
integer y = 748
integer width = 325
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
boolean cancel = true
end type

event clicked;
CloseWithReturn( Parent, 'FAIL' )
end event

type cb_ok from commandbutton within w_print_for_ppj
integer x = 1701
integer y = 748
integer width = 325
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
boolean default = true
end type

event clicked;
// Excel File 저장.

If cbx_file.Checked = True Then
	
	f_Save_To_Excel( idw_dw )
	
	CloseWithReturn( Parent, 'OK' )
	Return
End If


SetPointer( HourGlass! )

String S_command, S_copy, S_page

// 인쇄 : 0 모든 쪽, 1 짝수쪽, 2 홀수쪽

S_command = " DataWindow.Print.Page.RangeInclude = '" + String( ii_RangeInclude ) + "' "

// 인쇄 매수

S_copy = Trim( em_copies.Text )
If Len( S_copy ) > 0 Then
	S_command = S_command + " DataWindow.Print.Copies = '" + S_copy + "' "
Else
	MessageBox( "에러", "인쇄 매수가 잘못되었습니다." )
	Return
End If

// 인쇄 범위

Long l_Row

Choose Case is_Page
	Case 'all'
		
		S_page = ""
		
	Case 'current'
		
		l_Row = idw_dw.GetRow( )
		S_page = idw_dw.Describe( "Evaluate( 'page( )', " + String( l_Row ) + ")" )		

		If Len( S_page ) > 0 Then
			S_command = S_command + " DataWindow.Print.Page.Range = '" + S_page + "' "
		Else
			MessageBox( "에러", "인쇄 범위가 잘못되었습니다." )
			Return
		End If
		
	Case 'page'
		
		S_page = Trim( sle_page.Text )
		
		If Len( S_page ) > 0 Then
			S_command = S_command + " DataWindow.Print.Page.Range = '" + S_page + "' "
		Else
			MessageBox( "에러", "인쇄 범위가 잘못되었습니다." )
			Return
		End If
		
End Choose

// Check Box - 한번에 인쇄

If cbx_collate.Checked = True Then
	S_command = S_command + " DataWindow.Print.Collate = YES "
Else
	S_command = S_command + " DataWindow.Print.Collate = NO "
End If

// DataWindow Print Property Setting.
String S_rc

S_rc = idw_dw.Modify( S_command )
If S_rc <> "" Then
	MessageBox("에러", "프린트 속성 지정에 에러가 있습니다." + S_rc + "~r~n속성 = " + S_command )
	Return
End If

idw_dw.Print( )     // DataWindow Print...

CloseWithReturn( Parent, 'OK' )
end event

type cbx_collate from checkbox within w_print_for_ppj
integer x = 1742
integer y = 552
integer width = 480
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "한 부씩 인쇄"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cbx_file from checkbox within w_print_for_ppj
integer x = 1742
integer y = 440
integer width = 640
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "Excel File 저장"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_print_for_ppj
integer x = 1810
integer y = 196
integer width = 151
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "매수"
boolean focusrectangle = false
end type

type em_copies from editmask within w_print_for_ppj
integer x = 1966
integer y = 176
integer width = 361
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#,##0"
boolean spin = true
double increment = 1
string minmax = "1~~"
end type

type ddlb_range from dropdownlistbox within w_print_for_ppj
integer x = 366
integer y = 756
integer width = 1115
integer height = 336
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "범위내의 모든 Page"
boolean sorted = false
string item[] = {"범위내의 모든 Page","범위내의 짝수 Page","범위내의 홀수 Page"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
ii_RangeInclude = index - 1
end event

type st_2 from statictext within w_print_for_ppj
integer x = 233
integer y = 580
integer width = 681
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "예: 1-3, 5-9, 11, 13"
boolean focusrectangle = false
end type

type st_1 from statictext within w_print_for_ppj
integer x = 233
integer y = 504
integer width = 1102
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "Page 범위나 Page번호를 입력하세요."
boolean focusrectangle = false
end type

type sle_page from singlelineedit within w_print_for_ppj
integer x = 553
integer y = 368
integer width = 951
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type rb_page from radiobutton within w_print_for_ppj
integer x = 151
integer y = 384
integer width = 384
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "Page 번호"
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_page.Text = ""
sle_page.Enabled = True
sle_page.SetFocus( )

is_Page = 'page'
end event

type rb_current from radiobutton within w_print_for_ppj
integer x = 151
integer y = 272
integer width = 384
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "현재 Page"
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_page.Text = ""
sle_page.Enabled = False

is_Page = 'current'
end event

type rb_all from radiobutton within w_print_for_ppj
integer x = 151
integer y = 160
integer width = 270
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "모두"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_page.Text = ""
sle_page.Enabled = False

is_Page = 'all'
end event

type gb_range from groupbox within w_print_for_ppj
integer x = 46
integer y = 48
integer width = 1577
integer height = 644
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "인쇄 범위"
borderstyle borderstyle = stylelowered!
end type

type gb_copy from groupbox within w_print_for_ppj
integer x = 1673
integer y = 48
integer width = 745
integer height = 644
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "인쇄 매수"
borderstyle borderstyle = stylelowered!
end type

