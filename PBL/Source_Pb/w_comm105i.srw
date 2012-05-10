$PBExportHeader$w_comm105i.srw
$PBExportComments$사용가능 Window 조회
forward
global type w_comm105i from w_origin_sheet03
end type
type sle_1 from singlelineedit within w_comm105i
end type
type st_1 from statictext within w_comm105i
end type
type gb_2 from groupbox within w_comm105i
end type
type gb_1 from groupbox within w_comm105i
end type
type rb_2 from radiobutton within w_comm105i
end type
type rb_1 from radiobutton within w_comm105i
end type
type dw_3 from datawindow within w_comm105i
end type
type tab_1 from tab within w_comm105i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tab_1 from tab within w_comm105i
tabpage_1 tabpage_1
end type
type rb_3 from radiobutton within w_comm105i
end type
type rb_4 from radiobutton within w_comm105i
end type
end forward

global type w_comm105i from w_origin_sheet03
sle_1 sle_1
st_1 st_1
gb_2 gb_2
gb_1 gb_1
rb_2 rb_2
rb_1 rb_1
dw_3 dw_3
tab_1 tab_1
rb_3 rb_3
rb_4 rb_4
end type
global w_comm105i w_comm105i

type variables
integer i_n_index
end variables

on w_comm105i.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_3=create dw_3
this.tab_1=create tab_1
this.rb_3=create rb_3
this.rb_4=create rb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.rb_4
end on

on w_comm105i.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_3)
destroy(this.tab_1)
destroy(this.rb_3)
destroy(this.rb_4)
end on

event ue_retrieve;call super::ue_retrieve;
uo_status.st_message.text	=	"조회중입니다."

Setpointer(hourglass!)

tab_1.tabpage_1.dw_1.SetTransObject(sqlca)

if tab_1.tabpage_1.dw_1.retrieve() > 0 then
	uo_status.st_message.text	=	f_message("I010")		//조회되었습니다.
	i_b_preview = True
else
	uo_status.st_message.text	=	f_message("I020")
	i_b_preview = False
end if

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

end event

event ue_preview;call super::ue_preview;
window 	l_to_open
str_easy l_str_prt

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)

uo_status.st_message.Text = "출력 준비중 입니다..."		

CHOOSE CASE i_n_index
	CASE 1
		l_str_prt.title  = "개인별 사용가능 윈도우 이름 출력"
		dw_3.DataObject  = "d_comm105i_02"
		dw_3.object.data = tab_1.tabpage_1.dw_1.object.data
END CHOOSE

//인쇄 DataWindow 저장
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_3
l_str_prt.tag			  = This.ClassName()

f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""	

end event

event open;call super::open;
i_b_insert = False

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

end event

type uo_status from w_origin_sheet03`uo_status within w_comm105i
end type

type sle_1 from singlelineedit within w_comm105i
event ue_keydown pbm_keydown
integer x = 1957
integer y = 76
integer width = 1403
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;
string l_s_search, l_s_cd
long   l_n_findrow
datawindowchild dwc_cd

if key <> KeyEnter! then return

l_s_search = sle_1.text + "%"

CHOOSE CASE i_n_index
	CASE 1
		IF tab_1.tabpage_1.dw_1.RowCount() > 0 AND l_s_search = "%" THEN
			tab_1.tabpage_1.dw_1.SetFilter("")
			tab_1.tabpage_1.dw_1.Filter()
			uo_status.st_message.text	=	"전체 자료가 검색되었습니다."
			i_b_preview = True
		ELSE
			tab_1.tabpage_1.dw_1.SetFilter("EMP_NO like " + "'" + l_s_search + "'")
			tab_1.tabpage_1.dw_1.Filter()
			IF rb_1.Checked THEN
				tab_1.tabpage_1.dw_1.SetFilter("EMP_NO like " + "'" + l_s_search + "'")
				tab_1.tabpage_1.dw_1.Filter()
			ELSE
				tab_1.tabpage_1.dw_1.SetFilter("KOR_NM like " + "'" + l_s_search + "'")
				tab_1.tabpage_1.dw_1.Filter()
			END IF
			if l_n_findrow > 0 then
				uo_status.st_message.text	=	""
				i_b_preview = True
			else
				uo_status.st_message.text	=	"검색한 자료가 없습니다."
				i_b_preview = False
			end if
		END IF
END CHOOSE

wf_icon_onoff(i_b_retrieve,   i_b_insert,   i_b_save,   i_b_delete,   i_b_preview, & 
				  i_b_dretrieve,  i_b_dprint,   i_b_dchar)

end event

type st_1 from statictext within w_comm105i
integer x = 1728
integer y = 92
integer width = 169
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "검색"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_comm105i
integer x = 9
integer y = 16
integer width = 1632
integer height = 180
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "검색키"
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_comm105i
integer x = 1632
integer y = 16
integer width = 1787
integer height = 180
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_comm105i
integer x = 983
integer y = 92
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "이름"
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_1.text = ""
end event

type rb_1 from radiobutton within w_comm105i
integer x = 361
integer y = 92
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "개인번호"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_1.text = ""
end event

type dw_3 from datawindow within w_comm105i
boolean visible = false
integer x = 3429
integer y = 60
integer width = 165
integer height = 116
integer taborder = 40
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tab_1 from tab within w_comm105i
event create ( )
event destroy ( )
integer x = 14
integer y = 208
integer width = 3589
integer height = 2280
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;
i_n_index = newindex
CHOOSE CASE i_n_index
	CASE 1
		rb_1.Visible = True
		rb_2.Visible = True
		rb_3.Visible = False
		rb_4.Visible = False
		rb_1.Checked = True
	CASE 2
		rb_1.Visible = False
		rb_2.Visible = False
		rb_3.Visible = True
		rb_4.Visible = True
		rb_3.Checked = True
END CHOOSE

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3552
integer height = 2152
long backcolor = 79741120
string text = "개인별 사용가능 윈도우"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
integer y = 12
integer width = 3552
integer height = 2132
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_comm105i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_3 from radiobutton within w_comm105i
boolean visible = false
integer x = 361
integer y = 92
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "업무구분"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_1.text = ""
end event

type rb_4 from radiobutton within w_comm105i
boolean visible = false
integer x = 983
integer y = 92
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "소속명"
borderstyle borderstyle = stylelowered!
end type

event clicked;
sle_1.text = ""
end event

