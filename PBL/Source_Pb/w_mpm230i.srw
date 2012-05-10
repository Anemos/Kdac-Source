$PBExportHeader$w_mpm230i.srw
$PBExportComments$도면설계이력
forward
global type w_mpm230i from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm230i
end type
type dw_mpm230i_01 from u_vi_std_datawindow within w_mpm230i
end type
type gb_1 from groupbox within w_mpm230i
end type
end forward

global type w_mpm230i from w_ipis_sheet01
uo_1 uo_1
dw_mpm230i_01 dw_mpm230i_01
gb_1 gb_1
end type
global w_mpm230i w_mpm230i

on w_mpm230i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_mpm230i_01=create dw_mpm230i_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_mpm230i_01
this.Control[iCurrent+3]=this.gb_1
end on

on w_mpm230i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_mpm230i_01)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm230i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm230i_01.Height= newheight - ( dw_mpm230i_01.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;
dw_mpm230i_01.settransobject(sqlmpms)
end event

event ue_retrieve;call super::ue_retrieve;
dw_mpm230i_01.reset()
dw_mpm230i_01.retrieve( uo_1.is_uo_orderno )
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

type uo_status from w_ipis_sheet01`uo_status within w_mpm230i
end type

type uo_1 from u_mpms_select_orderno within w_mpm230i
integer x = 46
integer y = 44
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;iw_this.triggerevent('ue_retrieve')
end event

type dw_mpm230i_01 from u_vi_std_datawindow within w_mpm230i
integer x = 18
integer y = 176
integer width = 2779
integer height = 1676
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm230i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_mpm230i
integer x = 18
integer y = 8
integer width = 1312
integer height = 156
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

