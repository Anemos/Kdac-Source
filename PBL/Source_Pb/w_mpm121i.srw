$PBExportHeader$w_mpm121i.srw
$PBExportComments$Order별 진행정보
forward
global type w_mpm121i from w_ipis_sheet01
end type
type dw_mpm121i_01 from u_vi_std_datawindow within w_mpm121i
end type
type dw_mpm121i_02 from u_vi_std_datawindow within w_mpm121i
end type
end forward

global type w_mpm121i from w_ipis_sheet01
dw_mpm121i_01 dw_mpm121i_01
dw_mpm121i_02 dw_mpm121i_02
end type
global w_mpm121i w_mpm121i

on w_mpm121i.create
int iCurrent
call super::create
this.dw_mpm121i_01=create dw_mpm121i_01
this.dw_mpm121i_02=create dw_mpm121i_02
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm121i_01
this.Control[iCurrent+2]=this.dw_mpm121i_02
end on

on w_mpm121i.destroy
call super::destroy
destroy(this.dw_mpm121i_01)
destroy(this.dw_mpm121i_02)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm121i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm121i_01.Height= ( newheight * 2 / 5 ) - dw_mpm121i_01.y

dw_mpm121i_02.x = dw_mpm121i_01.x
dw_mpm121i_02.y = dw_mpm121i_01.y + dw_mpm121i_01.Height + ls_split
dw_mpm121i_02.Width = dw_mpm121i_01.Width
dw_mpm121i_02.Height = newheight - ( dw_mpm121i_01.y + dw_mpm121i_01.Height + ls_split + ls_status)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_mpm121i_01.settransobject(sqlmpms)
dw_mpm121i_02.settransobject(sqlmpms)

dw_mpm121i_01.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm121i_01,'ingstatus',ldwc,'codename',5)

dw_mpm121i_02.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm121i_02,'ingstatus',ldwc,'codename',5)

dw_mpm121i_02.GetChild('workstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM002')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm121i_02,'workstatus',ldwc,'codename',5)

This.Triggerevent( 'ue_retrieve')
end event

event ue_retrieve;call super::ue_retrieve;
dw_mpm121i_01.reset()

if dw_mpm121i_01.retrieve() < 1 then
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

type uo_status from w_ipis_sheet01`uo_status within w_mpm121i
end type

type dw_mpm121i_01 from u_vi_std_datawindow within w_mpm121i
integer x = 18
integer y = 20
integer width = 3118
integer height = 692
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm121i_01"
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

dw_mpm121i_02.reset()
ls_orderno = This.getitemstring( currentrow, "orderno")

dw_mpm121i_02.retrieve(ls_orderno)
end event

type dw_mpm121i_02 from u_vi_std_datawindow within w_mpm121i
integer x = 18
integer y = 728
integer width = 3113
integer height = 1152
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm121i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

