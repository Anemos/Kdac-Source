$PBExportHeader$w_mpm122i.srw
$PBExportComments$Order별 완료정보
forward
global type w_mpm122i from w_ipis_sheet01
end type
type dw_mpm122i_01 from u_vi_std_datawindow within w_mpm122i
end type
type dw_mpm122i_02 from u_vi_std_datawindow within w_mpm122i
end type
type uo_year from u_mpms_date_scroll_month within w_mpm122i
end type
type gb_1 from groupbox within w_mpm122i
end type
end forward

global type w_mpm122i from w_ipis_sheet01
dw_mpm122i_01 dw_mpm122i_01
dw_mpm122i_02 dw_mpm122i_02
uo_year uo_year
gb_1 gb_1
end type
global w_mpm122i w_mpm122i

on w_mpm122i.create
int iCurrent
call super::create
this.dw_mpm122i_01=create dw_mpm122i_01
this.dw_mpm122i_02=create dw_mpm122i_02
this.uo_year=create uo_year
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm122i_01
this.Control[iCurrent+2]=this.dw_mpm122i_02
this.Control[iCurrent+3]=this.uo_year
this.Control[iCurrent+4]=this.gb_1
end on

on w_mpm122i.destroy
call super::destroy
destroy(this.dw_mpm122i_01)
destroy(this.dw_mpm122i_02)
destroy(this.uo_year)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm122i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm122i_01.Height= ( newheight * 2 / 5 ) - dw_mpm122i_01.y

dw_mpm122i_02.x = dw_mpm122i_01.x
dw_mpm122i_02.y = dw_mpm122i_01.y + dw_mpm122i_01.Height + ls_split
dw_mpm122i_02.Width = dw_mpm122i_01.Width
dw_mpm122i_02.Height = newheight - ( dw_mpm122i_01.y + dw_mpm122i_01.Height + ls_split + ls_status)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_mpm122i_01.settransobject(sqlmpms)
dw_mpm122i_02.settransobject(sqlmpms)

dw_mpm122i_02.GetChild('workstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm122i_02,'workstatus',ldwc,'codename',5)

This.Triggerevent( 'ue_retrieve')
end event

event ue_retrieve;call super::ue_retrieve;date ld_rtndt

dw_mpm122i_01.reset()
uo_year.uf_getdata(ld_rtndt)

if dw_mpm122i_01.retrieve(datetime(ld_rtndt)) < 1 then
	uo_status.st_message.text = '진행중인 금형이 없습니다.'
end if
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm122i
end type

type dw_mpm122i_01 from u_vi_std_datawindow within w_mpm122i
integer x = 18
integer y = 180
integer width = 3118
integer height = 532
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm122i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

dw_mpm122i_02.reset()
ls_orderno = This.getitemstring( currentrow, "orderno")

dw_mpm122i_02.retrieve(ls_orderno)
end event

type dw_mpm122i_02 from u_vi_std_datawindow within w_mpm122i
integer x = 18
integer y = 728
integer width = 3113
integer height = 1152
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm122i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_year from u_mpms_date_scroll_month within w_mpm122i
event destroy ( )
integer x = 110
integer y = 60
integer taborder = 11
boolean bringtotop = true
end type

on uo_year.destroy
call u_mpms_date_scroll_month::destroy
end on

type gb_1 from groupbox within w_mpm122i
integer x = 18
integer width = 800
integer height = 164
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

