$PBExportHeader$w_piss620u.srw
$PBExportComments$신규출하품creation및 조회
forward
global type w_piss620u from w_ipis_sheet01
end type
type dw_piss620u_01 from u_vi_std_datawindow within w_piss620u
end type
type gb_2 from groupbox within w_piss620u
end type
type gb_3 from groupbox within w_piss620u
end type
type dw_print from datawindow within w_piss620u
end type
type rb_iptv from radiobutton within w_piss620u
end type
type rb_dptv from radiobutton within w_piss620u
end type
type uo_month from u_pisc_date_scroll_month within w_piss620u
end type
type cb_create from commandbutton within w_piss620u
end type
end forward

global type w_piss620u from w_ipis_sheet01
integer width = 3671
integer height = 1592
string title = "신규출하품목 Creation"
dw_piss620u_01 dw_piss620u_01
gb_2 gb_2
gb_3 gb_3
dw_print dw_print
rb_iptv rb_iptv
rb_dptv rb_dptv
uo_month uo_month
cb_create cb_create
end type
global w_piss620u w_piss620u

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

forward prototypes
public function boolean wf_month_check ()
end prototypes

public function boolean wf_month_check ();
IF not isdate(uo_month.is_uo_month+'.01') then
	MessageBox('확 인', '월 체계가 들립니다.')
   return false
END IF
//messagebox('aa', uo_month.is_uo_month+String(f_getsysdatetime(), 'yyyy.mm'))
IF uo_month.is_uo_month > String(f_getsysdatetime(), 'yyyy.mm') then
	MessageBox('확 인', '당월 이후 처리 불가')
   return false
END IF

return true
end function

on w_piss620u.create
int iCurrent
call super::create
this.dw_piss620u_01=create dw_piss620u_01
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_print=create dw_print
this.rb_iptv=create rb_iptv
this.rb_dptv=create rb_dptv
this.uo_month=create uo_month
this.cb_create=create cb_create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_piss620u_01
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.dw_print
this.Control[iCurrent+5]=this.rb_iptv
this.Control[iCurrent+6]=this.rb_dptv
this.Control[iCurrent+7]=this.uo_month
this.Control[iCurrent+8]=this.cb_create
end on

on w_piss620u.destroy
call super::destroy
destroy(this.dw_piss620u_01)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_print)
destroy(this.rb_iptv)
destroy(this.rb_dptv)
destroy(this.uo_month)
destroy(this.cb_create)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_piss620u_01, FULL)
//
//of_resize()
//
gb_3.Width = newwidth - ( gb_3.x + 10 ) 
dw_piss620u_01.Width = newwidth - ( dw_piss620u_01.x + 25 ) 
gb_3.height = newheight - ( gb_3.y + 90 ) 
dw_piss620u_01.Height = newheight - ( dw_piss620u_01.y + 110 ) 

end event

event ue_retrieve;string ls_date

if wf_month_check() = false then
   return
end if

ls_date			= uo_month.is_uo_month
ls_date = left(ls_date,4)+right(ls_date,2)


// 데이타를 조회한다
//
if dw_piss620u_01.Retrieve(ls_date) > 0 then
//	commit using sqlpis;
	uo_status.st_message.text = '조회 되었습니다.'
else 
	uo_status.st_message.text = '정보가 없습니다.'
//	rollback using sqlpis;
end if

end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// 툴바의 아이콘을 재설정한다
//
f_icon_set(true , false, false,  false,  true, &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  false, &
			  false, false )


end event

event ue_postopen();
string ls_codegroup,ls_codegroupname,ls_codename

// 입력권한 setting
//
cb_create.Enabled	= m_frame.m_action.m_save.Enabled

// 트랜잭션을 연결한다
//
dw_piss620u_01.SetTransObject(SQLEIS)
										
ib_open = true										

end event

event ue_print;call super::ue_print;
String		ls_month
transaction	ls_trans
str_easy		lstr_prt
window		lw_open


dw_piss620u_01.ShareData(dw_print)


ls_trans	= SQLEIS

ls_month	= uo_month.is_uo_month + '월'

// 인쇄 DataWindow 저장
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"신규 출하 품목 현황"
lstr_prt.tag			= 	This.ClassName()
lstr_prt.dwsyntax 	= "t_month.text   	= '" + ls_month + "'"

f_close_report("2", lstr_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

event activate;call super::activate;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// 툴바의 아이콘을 재설정한다
//
f_icon_set(true , false, false,  false,  true, &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  false, &
			  false, false )


end event

type uo_status from w_ipis_sheet01`uo_status within w_piss620u
integer x = 18
integer y = 1380
integer width = 3598
end type

type dw_piss620u_01 from u_vi_std_datawindow within w_piss620u
integer x = 37
integer y = 208
integer width = 1490
integer height = 1140
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_piss620u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;//
end event

event clicked;//
end event

type gb_2 from groupbox within w_piss620u
integer x = 18
integer y = 12
integer width = 4594
integer height = 168
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_piss620u
integer x = 18
integer y = 184
integer width = 1527
integer height = 1180
integer taborder = 70
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_print from datawindow within w_piss620u
boolean visible = false
integer x = 1193
integer y = 1136
integer width = 1925
integer height = 1000
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss620u_02p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_iptv from radiobutton within w_piss620u
boolean visible = false
integer x = 2085
integer y = 72
integer width = 242
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "IPTV"
end type

type rb_dptv from radiobutton within w_piss620u
boolean visible = false
integer x = 1829
integer y = 72
integer width = 242
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "DPTV"
boolean checked = true
end type

type uo_month from u_pisc_date_scroll_month within w_piss620u
event destroy ( )
integer x = 50
integer y = 68
integer height = 80
integer taborder = 60
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type cb_create from commandbutton within w_piss620u
integer x = 786
integer y = 52
integer width = 800
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기준월 출하품 생성"
end type

event clicked;string ls_date
integer li_count

if wf_month_check() = false then
   return
end if

ls_date			= uo_month.is_uo_month
ls_date = left(ls_date,4)+right(ls_date,2)

If MessageBox("신규 출하품목 생성","기준월에 이미 생성된 정보가 있으면 삭제 됩니다. ~n~r신규 작업을 하시겠습니까 ?", Question!, YesNo!) = 2 Then
	Return
end if

uo_status.st_message.text = '생성 중....'

Declare proc_newship Procedure For sp_piss620u_01
		 @ps_date = :ls_date
USING sqleis ;

Execute proc_newship ;

//messagebox('aa', '1')
//If Sqleis.SqlCode = 0 Then 
	Close proc_newship ;
	COMMIT USING  sqleis;
//else
//	messagebox("생성오류", "기준월 신규 출하 품목 생성에 실패했습니다.") 
//	Close proc_newship ;
//	ROLLBACK USING  sqleis; 
//	sqleis.AutoCommit = True 
//End If

//sqleis.AutoCommit = True 
//messagebox("aa", "aa") 

parent.triggerevent( "ue_retrieve")
//messagebox("aa", "bb")
uo_status.st_message.text = '생성 되었습니다.'
Return 1 

end event
