$PBExportHeader$w_pism_prt01.srw
$PBExportComments$(공통 출력물인쇄 원판)
forward
global type w_pism_prt01 from window
end type
type dw_download from datawindow within w_pism_prt01
end type
type pb_excel from picturebutton within w_pism_prt01
end type
type rb_garo from radiobutton within w_pism_prt01
end type
type rb_sero from radiobutton within w_pism_prt01
end type
type p_garo from picture within w_pism_prt01
end type
type p_sero from picture within w_pism_prt01
end type
type ddlb_scale from singlelineedit within w_pism_prt01
end type
type st_7 from statictext within w_pism_prt01
end type
type st_2 from statictext within w_pism_prt01
end type
type cb_scroll from commandbutton within w_pism_prt01
end type
type em_scrollpage from editmask within w_pism_prt01
end type
type cbx_rulers from checkbox within w_pism_prt01
end type
type st_6 from statictext within w_pism_prt01
end type
type ddlb_previewscale from dropdownlistbox within w_pism_prt01
end type
type st_1 from statictext within w_pism_prt01
end type
type dw_preview from datawindow within w_pism_prt01
end type
type uo_status from uo_commonstatus within w_pism_prt01
end type
type gb_2 from groupbox within w_pism_prt01
end type
type gb_1 from groupbox within w_pism_prt01
end type
type gb_3 from groupbox within w_pism_prt01
end type
type gb_4 from groupbox within w_pism_prt01
end type
end forward

global type w_pism_prt01 from window
integer x = 5
integer y = 212
integer width = 4219
integer height = 2100
boolean titlebar = true
string title = "Origin07"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
event ue_print pbm_custom01
event ue_first pbm_custom02
event ue_prev pbm_custom03
event ue_next pbm_custom04
event ue_last pbm_custom05
event ue_dwset pbm_custom06
event ue_retrieve ( )
dw_download dw_download
pb_excel pb_excel
rb_garo rb_garo
rb_sero rb_sero
p_garo p_garo
p_sero p_sero
ddlb_scale ddlb_scale
st_7 st_7
st_2 st_2
cb_scroll cb_scroll
em_scrollpage em_scrollpage
cbx_rulers cbx_rulers
st_6 st_6
ddlb_previewscale ddlb_previewscale
st_1 st_1
dw_preview dw_preview
uo_status uo_status
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
gb_4 gb_4
end type
global w_pism_prt01 w_pism_prt01

type variables
// Icon의 Enabled 상태
boolean i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last

//Open시의 Activate Event Skip 여부
boolean i_b_first_open

//Security Level Check
string i_s_level

DataWindow	i_dw
str_pism_prt		i_str_prt		//출력조건

end variables

forward prototypes
public subroutine wf_icon_onoff (boolean ag_print, boolean ag_first, boolean ag_prev, boolean ag_next, boolean ag_last)
public subroutine wf_setprdw ()
end prototypes

event ue_print;str_prtoption	l_prt_option

dw_preview.Setredraw(false)

l_prt_option.datawindow = dw_preview
l_prt_option.page			= em_scrollpage.text
l_prt_option.transaction= i_str_prt.transaction
OpenWithParm(w_print_options, l_prt_option)

If Message.DoubleParm = -1 Then
	dw_preview.Setredraw(true)
	Return
end if

dw_preview.Setredraw(true)

dw_preview.Object.Datawindow.Zoom = ddlb_scale.text
cb_scroll.TriggerEvent(Clicked!)

if dw_preview.Describe("Evaluate('PageCount()',1)") = "1" then
	cb_scroll.enabled = false
	// m_next
	i_b_next   = false
	// m_last
	i_b_last   = false
end if

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

event ue_first;dw_preview.ScrollToRow(0)
em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)")

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
i_b_print  = true
i_b_first  = false
i_b_prev   = false
i_b_next   = true
i_b_last   = true

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

event ue_prev;dw_preview.ScrollPriorPage()
em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)")

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
// m_print
i_b_print  = true

if dw_preview.Describe("Evaluate('Page()',1)") = "1" then
	i_b_first  = false
	i_b_prev   = false
end if

i_b_next   = true
i_b_last   = true

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

event ue_next;dw_preview.ScrollnextPage()
em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)")

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
i_b_print  = true
i_b_first  = true
i_b_prev   = true

if dw_preview.Describe("Evaluate('Page()',1)") = &
	dw_preview.Describe("Evaluate('Pagecount()',1)")	then
	i_b_next   = false
	i_b_last   = false
end if

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

event ue_last;long l_n_forcnt, l_n_scrollpage

//첫Page Setting
dw_preview.ScrollToRow(0)

//총Page Count 구해서 Setting
l_n_scrollpage = long(dw_preview.Describe("Evaluate('PageCount()',1)"))

//Page 이동
if l_n_scrollpage > 1 then
	for l_n_forcnt = 1 to l_n_scrollpage - 1
		dw_preview.ScrollNextPage()
	next
end if

em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)")

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
i_b_print  = true
i_b_first  = true
i_b_prev   = true
i_b_next   = false
i_b_last   = false

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

event ue_dwset;i_dw = i_str_prt.datawindow
if IsNull(i_str_prt.DataObject) or Len(Trim(i_str_prt.DataObject)) = 0 then
	MessageBox("알 림", "DataObject가 지정되지 않았습니다!~r~n" + &
		 "출력을 할 수가 없습니다.", StopSign!)
	Close(This)
	Return
end if

dw_preview.DataObject = i_str_prt.DataObject
dw_preview.SettransObject(i_str_prt.transaction)
i_dw.ShareData(dw_preview)

wf_setprdw() 
end event

event ue_retrieve();String ls_Orientation 

if IsNull(i_str_prt.DataObject) or Len(Trim(i_str_prt.DataObject)) = 0 then
	MessageBox("알 림", "DataObject가 지정되지 않았습니다!~r~n" + &
		 "출력을 할 수가 없습니다.", StopSign!)
	Close(This)
	Return
end if

dw_preview.DataObject = i_str_prt.DataObject
dw_preview.SettransObject(i_str_prt.transaction)
i_str_prt.parent_win.Dynamic wf_prDataWindowRetrieve(dw_preview)

ls_Orientation = dw_preview.Describe("datawindow.Print.Orientation")
If ls_Orientation = '1' Then rb_garo.Checked = True 
If ls_Orientation = '2' Then rb_sero.Checked = True 

wf_setprdw() 

end event

public subroutine wf_icon_onoff (boolean ag_print, boolean ag_first, boolean ag_prev, boolean ag_next, boolean ag_last);//////////////////////////////////////////////////////////////////////////
//       wf_icon_onoff(인쇄, 처음, 이전, 다음, 끝)
//                 input  value true/false
//                 return value none
//////////////////////////////////////////////////////////////////////////

// m_print
m_frame.m_action.m_print.enabled    = ag_print
// m_first
m_frame.m_action.m_first.enabled    = ag_first
// m_prev
m_frame.m_action.m_prev.enabled     = ag_prev
// m_next
m_frame.m_action.m_next.enabled     = ag_next
// m_last
m_frame.m_action.m_last.enabled     = ag_last
end subroutine

public subroutine wf_setprdw ();String ls_Chk, ls_Orientation 

dw_preview.SetRedraw(False)

if i_str_prt.dwsyntax <> "" then
	ls_chk = dw_preview.modify(i_str_prt.dwsyntax)
	If ls_Chk <> '' Then MessageBox("", ls_Chk + "~n~n" + i_str_prt.dwsyntax)
end if

dw_preview.Object.DataWindow.Print.Preview = 'yes'

if cbx_rulers.Checked = True then
	dw_preview.Object.Datawindow.Print.Preview.Rulers = 'yes'
else
	dw_preview.Object.Datawindow.Print.Preview.Rulers = 'no'
end if

dw_preview.Object.DataWindow.Print.Preview.Zoom = ddlb_previewscale.Text 
IF ddlb_scale.Text <> '' THEN dw_preview.Modify("datawindow.zoom = " + ddlb_scale.Text )

If rb_garo.Checked Then 
	ls_Orientation = '1' 
ElseIf rb_sero.Checked Then 
	ls_Orientation = '2' 
End If 
dw_preview.Modify("datawindow.Print.Orientation = '" + ls_Orientation + "'") 

em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)")

dw_preview.SetRedraw(True)

end subroutine

on w_pism_prt01.create
this.dw_download=create dw_download
this.pb_excel=create pb_excel
this.rb_garo=create rb_garo
this.rb_sero=create rb_sero
this.p_garo=create p_garo
this.p_sero=create p_sero
this.ddlb_scale=create ddlb_scale
this.st_7=create st_7
this.st_2=create st_2
this.cb_scroll=create cb_scroll
this.em_scrollpage=create em_scrollpage
this.cbx_rulers=create cbx_rulers
this.st_6=create st_6
this.ddlb_previewscale=create ddlb_previewscale
this.st_1=create st_1
this.dw_preview=create dw_preview
this.uo_status=create uo_status
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.dw_download,&
this.pb_excel,&
this.rb_garo,&
this.rb_sero,&
this.p_garo,&
this.p_sero,&
this.ddlb_scale,&
this.st_7,&
this.st_2,&
this.cb_scroll,&
this.em_scrollpage,&
this.cbx_rulers,&
this.st_6,&
this.ddlb_previewscale,&
this.st_1,&
this.dw_preview,&
this.uo_status,&
this.gb_2,&
this.gb_1,&
this.gb_3,&
this.gb_4}
end on

on w_pism_prt01.destroy
destroy(this.dw_download)
destroy(this.pb_excel)
destroy(this.rb_garo)
destroy(this.rb_sero)
destroy(this.p_garo)
destroy(this.p_sero)
destroy(this.ddlb_scale)
destroy(this.st_7)
destroy(this.st_2)
destroy(this.cb_scroll)
destroy(this.em_scrollpage)
destroy(this.cbx_rulers)
destroy(this.st_6)
destroy(this.ddlb_previewscale)
destroy(this.st_1)
destroy(this.dw_preview)
destroy(this.uo_status)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;// title Setting & DataWindow Option Triggerevent
i_str_prt  = Message.PowerObjectParm
this.title = i_str_prt.title
this.tag	  = i_str_prt.tag
If i_str_prt.prscale <> '' Then ddlb_scale.Text = i_str_prt.prscale 

TriggerEvent("ue_retrieve")
//TriggerEvent("ue_dwset")

// Sheet Status Line Setting
if g_s_kornm = "" then
	g_s_kornm = "ADMIN"
end if
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")

// Action Menu Off
m_frame.m_action.visible = false

// Seperate Setting
m_frame.m_action.m_sep21.visible = true
m_frame.m_action.m_sep22.visible = true

////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
f_icon_set(false, false, false, false, true,  true,  true,  true,  true, false, &
			  false, false, false, false, false, false, false)

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
// m_print
i_b_print  = true
// m_first
i_b_first  = false
// m_prev
i_b_prev   = false
// m_next
i_b_next   = true
// m_last
i_b_last   = true

if dw_preview.Describe("Evaluate('PageCount()',1)") = "1" then
	cb_scroll.enabled = false
	// m_next
	i_b_next   = false
	// m_last
	i_b_last   = false
end if

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

// Action Menu On
m_frame.m_action.visible = true

// ToolBar 2 Setting  (전체공통)
w_frame.SetToolbar(2, true)
w_frame.SetToolbarPos(2, 2, 150, false)

DataWindowChild ldwc_prt 

If dw_preview.GetChild('dw_prt', ldwc_prt) = -1 Then 
	gb_4.Visible = False; pb_excel.Visible = False 
End If 

end event

event activate;SetPointer(HourGlass!)

if i_b_first_open = false then
	i_b_first_open = true
	return
else
	// Action Menu Off
	m_frame.m_action.visible = false
	
	// Seperate Setting
	m_frame.m_action.m_sep21.visible = true
	m_frame.m_action.m_sep22.visible = true
	
	////////////////////////////////////////////////////////////////////////////////////////////
	// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
	// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
	// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
	// ag_16 : None1,    ag_17 : None2
	////////////////////////////////////////////////////////////////////////////////////////////
	f_icon_set(false, false, false, false, true,  true,  true,  true,  true, false, &
				  false, false, false, false, false, false, false)
	
	// ToolBar 2 Setting  (전체공통)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)
	
	/////////////////////////////////////////////////////////
	// Buffered Button Status Setting
	/////////////////////////////////////////////////////////
	// 인쇄, 처음, 이전, 다음, 끝
	wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)
	
	// Action Menu On
	m_frame.m_action.visible = true
end if
end event

event deactivate;/////////////////////////////////////////////////////////
// Current Button Status Buffering
/////////////////////////////////////////////////////////
// m_dprint
i_b_print  = m_frame.m_action.m_print.enabled
// m_first
i_b_first  = m_frame.m_action.m_first.enabled
// m_prev
i_b_prev   = m_frame.m_action.m_prev.enabled
// m_next
i_b_next   = m_frame.m_action.m_next.enabled
// m_last
i_b_last   = m_frame.m_action.m_last.enabled

end event

event closequery;dw_preview.ScrollToRow(0)
end event

event resize;// status bar 위치 고정
uo_status.Move(15, This.height - uo_status.height - 110)
uo_status.Resize(This.width - (2 * 15), uo_status.height)

uo_status.st_message.width = uo_status.width - uo_status.st_winid.width - &
	uo_status.st_kornm.width - uo_status.st_date.width - 20
uo_status.st_kornm.x = uo_status.st_message.x + uo_status.st_message.width
uo_status.st_date.x = uo_status.st_kornm.x + uo_status.st_kornm.width
uo_status.st_time.x = uo_status.st_date.x + 375

dw_preview.Width = newwidth - ( dw_preview.x + 10 ) 
dw_preview.Height = newheight - ( dw_preview.y + uo_status.Height + 10 ) 
uo_status.y = dw_preview.y + dw_preview.Height 


end event

type dw_download from datawindow within w_pism_prt01
boolean visible = false
integer x = 1550
integer y = 240
integer width = 2002
integer height = 1248
integer taborder = 50
string title = "none"
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_pism_prt01
integer x = 3675
integer y = 56
integer width = 155
integer height = 132
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = right!
end type

event clicked;String l_s_docname, l_s_named, ls_Chk 
Long l_n_value 
Integer li_Chk 

If dw_download.DataObject <> dw_preview.DataObject + "_download" Then dw_download.DataObject = dw_preview.DataObject + "_download" 
i_str_prt.parent_win.Dynamic wf_prDataWindowRetrieve(dw_download) 

If dw_download.RowCount() = 0 Then Return 

l_s_docname = Parent.Title 

l_n_value = GetFileSaveName("저장 하기", l_s_docname, l_s_named, "xls", "Excel files (*.xls), *.xls")
if l_n_value = 1 then
	li_Chk = dw_download.saveas(l_s_docname, HTMLTABLE!, true) 
	If li_Chk = -1 Then 
		f_pism_messagebox(StopSign!, -1, "확 인", "파일저장 오류 입니다.") 
		Return 
	End If 
else
	Return 
end if

OleObject     myOleObject
int           i_Result
String        excel_title

myOleObject = Create OleObject //ole 오브젝트 생성

i_Result = myOleObject.ConnectToNewObject( "excel.application" )
// 엑셀에 연결
excel_title = myOleObject.Application.Caption

myOleObject.Application.Visible = True

myOleObject.WorkBooks.Open(l_s_docname)
myOleObject.WindowState = 3 
// 엑셀윈도우의 상태 지정 1-normal, 2-min, 3-max

myoleobject.DisConnectObject() //연결종료
Destroy myoleobject //오브젝트 제거

 
end event

type rb_garo from radiobutton within w_pism_prt01
integer x = 2725
integer y = 84
integer width = 256
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "가로"
end type

event clicked;//dw_preview.Modify("datawindow.Print.Orientation = '1'") 
wf_setprdw() 
end event

type rb_sero from radiobutton within w_pism_prt01
integer x = 3227
integer y = 84
integer width = 256
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "세로"
end type

event clicked;//dw_preview.Modify("datawindow.Print.Orientation = '2'") 
wf_setprdw() 
end event

type p_garo from picture within w_pism_prt01
integer x = 2551
integer y = 68
integer width = 151
integer height = 96
boolean enabled = false
string picturename = "C:\kdac\bmp\p_garo.bmp"
boolean focusrectangle = false
end type

type p_sero from picture within w_pism_prt01
integer x = 3077
integer y = 56
integer width = 123
integer height = 124
boolean enabled = false
string picturename = "C:\kdac\bmp\p_sero.bmp"
boolean focusrectangle = false
end type

type ddlb_scale from singlelineedit within w_pism_prt01
integer x = 1111
integer y = 64
integer width = 210
integer height = 96
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "100"
borderstyle borderstyle = stylelowered!
end type

event modified;wf_setprdw() 
end event

type st_7 from statictext within w_pism_prt01
integer x = 1344
integer y = 88
integer width = 64
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "％"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pism_prt01
integer x = 791
integer y = 76
integer width = 311
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "출력배율"
boolean focusrectangle = false
end type

type cb_scroll from commandbutton within w_pism_prt01
integer x = 2208
integer y = 68
integer width = 197
integer height = 96
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "이동"
end type

event clicked;long l_n_forcnt, l_n_scrollpage

l_n_scrollpage = long(em_scrollpage.text)

/////////////////////////////////////////////////////////
// Default icon Status Initialize Setting
/////////////////////////////////////////////////////////
i_b_print  = true
i_b_first  = true
i_b_prev   = true
i_b_next   = true
i_b_last   = true

//첫Page Setting
dw_preview.ScrollToRow(0)

//총Page Count 구해서 이동할 Page보다 적으면 총Page 값 Setting
if l_n_scrollpage > long(dw_preview.Describe("Evaluate('PageCount()',1)")) then
	l_n_scrollpage = long(dw_preview.Describe("Evaluate('PageCount()',1)"))
	i_b_next   = false
	i_b_last   = false
end if

//Page 이동
if l_n_scrollpage > 1 then
	for l_n_forcnt = 1 to l_n_scrollpage - 1
		dw_preview.ScrollNextPage()
	next
end if

em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)")

/////////////////////////////////////////////////////////
// Default Icon Status Setting
/////////////////////////////////////////////////////////
// m_print
i_b_print  = true

if dw_preview.Describe("Evaluate('Page()',1)") = "1" then
	i_b_first  = false
	i_b_prev   = false
end if

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

type em_scrollpage from editmask within w_pism_prt01
integer x = 1915
integer y = 68
integer width = 247
integer height = 96
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type cbx_rulers from checkbox within w_pism_prt01
integer x = 1477
integer y = 76
integer width = 311
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "눈금자"
end type

event clicked;if This.Checked = True then
	dw_preview.Object.Datawindow.Print.Preview.Rulers = 'yes'
else
	dw_preview.Object.Datawindow.Print.Preview.Rulers = 'no'
end if

end event

type st_6 from statictext within w_pism_prt01
integer x = 654
integer y = 88
integer width = 64
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "％"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_previewscale from dropdownlistbox within w_pism_prt01
integer x = 375
integer y = 68
integer width = 265
integer height = 548
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "100"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"50","60","70","80","90","100","150","200"}
borderstyle borderstyle = stylelowered!
end type

event modified;dw_preview.Object.DataWindow.Print.Preview.Zoom = This.Text 
em_scrollpage.text = dw_preview.Describe("Evaluate('Page()',1)") 
end event

type st_1 from statictext within w_pism_prt01
integer x = 64
integer y = 76
integer width = 311
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "보기배율"
boolean focusrectangle = false
end type

type dw_preview from datawindow within w_pism_prt01
integer x = 9
integer y = 224
integer width = 3584
integer height = 1592
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;wf_setprdw() 
end event

type uo_status from uo_commonstatus within w_pism_prt01
integer x = 9
integer y = 1832
boolean enabled = false
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

type gb_2 from groupbox within w_pism_prt01
integer x = 1874
integer width = 576
integer height = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[페이지이동]"
end type

type gb_1 from groupbox within w_pism_prt01
integer x = 14
integer width = 1838
integer height = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[미리보기]"
end type

type gb_3 from groupbox within w_pism_prt01
integer x = 2469
integer width = 1024
integer height = 200
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[출력방향]"
end type

type gb_4 from groupbox within w_pism_prt01
integer x = 3511
integer width = 498
integer height = 200
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Excel DownLoad"
end type

