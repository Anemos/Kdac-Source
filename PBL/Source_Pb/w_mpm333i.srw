$PBExportHeader$w_mpm333i.srw
$PBExportComments$예상대비실시간편차
forward
global type w_mpm333i from w_ipis_sheet01
end type
type dw_mpm333i_01 from u_vi_std_datawindow within w_mpm333i
end type
type dw_mpm333i_02 from u_vi_std_datawindow within w_mpm333i
end type
type uo_orderno from u_mpms_select_orderno within w_mpm333i
end type
type gb_1 from groupbox within w_mpm333i
end type
end forward

global type w_mpm333i from w_ipis_sheet01
dw_mpm333i_01 dw_mpm333i_01
dw_mpm333i_02 dw_mpm333i_02
uo_orderno uo_orderno
gb_1 gb_1
end type
global w_mpm333i w_mpm333i

on w_mpm333i.create
int iCurrent
call super::create
this.dw_mpm333i_01=create dw_mpm333i_01
this.dw_mpm333i_02=create dw_mpm333i_02
this.uo_orderno=create uo_orderno
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm333i_01
this.Control[iCurrent+2]=this.dw_mpm333i_02
this.Control[iCurrent+3]=this.uo_orderno
this.Control[iCurrent+4]=this.gb_1
end on

on w_mpm333i.destroy
call super::destroy
destroy(this.dw_mpm333i_01)
destroy(this.dw_mpm333i_02)
destroy(this.uo_orderno)
destroy(this.gb_1)
end on

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

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm333i_01.Width = (newwidth / 2) - (ls_gap * 3)
dw_mpm333i_01.Height= newheight - (dw_mpm333i_01.y + ls_status)

dw_mpm333i_02.x = (ls_gap * 4) + dw_mpm333i_01.Width
dw_mpm333i_02.y = dw_mpm333i_01.y
dw_mpm333i_02.Width = (newwidth / 2) - (ls_gap * 3)
dw_mpm333i_02.Height= dw_mpm333i_01.Height
end event

event ue_postopen;call super::ue_postopen;dw_mpm333i_01.settransobject(sqlmpms)
dw_mpm333i_02.settransobject(sqlmpms)

This.Triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_orderno, ls_partno

ls_orderno = uo_orderno.is_uo_orderno
if ls_orderno = 'ALL' or ls_orderno = '%' then
	uo_status.st_message.text = "Order No을 선택해 주십시요"
	return 0
end if
ll_rowcnt = dw_mpm333i_01.retrieve(ls_orderno)
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
	return 0
end if

ls_partno = dw_mpm333i_01.getitemstring(1,"partno")

dw_mpm333i_02.retrieve(ls_orderno, ls_partno)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm333i
end type

type dw_mpm333i_01 from u_vi_std_datawindow within w_mpm333i
integer x = 27
integer y = 200
integer width = 1330
integer height = 1680
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm333i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_orderno, ls_partno

if currentrow < 1 then
	return 0
end if
this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
ls_orderno = This.getitemstring(currentrow,"orderno")
ls_partno = This.getitemstring(currentrow,"partno")

dw_mpm333i_02.retrieve(ls_orderno, ls_partno)
end event

event constructor;call super::constructor;ii_selection = 1
end event

type dw_mpm333i_02 from u_vi_std_datawindow within w_mpm333i
integer x = 1381
integer y = 200
integer width = 1280
integer height = 1680
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm333i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;ii_selection = 1
end event

type uo_orderno from u_mpms_select_orderno within w_mpm333i
integer x = 82
integer y = 48
integer taborder = 20
boolean bringtotop = true
end type

on uo_orderno.destroy
call u_mpms_select_orderno::destroy
end on

event constructor;call super::constructor;is_option = '1'
end event

event ue_select;call super::ue_select;dw_mpm333i_01.reset()
dw_mpm333i_02.reset()
end event

type gb_1 from groupbox within w_mpm333i
integer x = 23
integer width = 1339
integer height = 180
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

