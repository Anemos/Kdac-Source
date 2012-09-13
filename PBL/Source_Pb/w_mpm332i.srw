$PBExportHeader$w_mpm332i.srw
$PBExportComments$공정진행율
forward
global type w_mpm332i from w_ipis_sheet01
end type
type dw_mpm332i_01 from u_vi_std_datawindow within w_mpm332i
end type
type dw_mpm332i_02 from u_vi_std_datawindow within w_mpm332i
end type
type dw_title from datawindow within w_mpm332i
end type
end forward

global type w_mpm332i from w_ipis_sheet01
dw_mpm332i_01 dw_mpm332i_01
dw_mpm332i_02 dw_mpm332i_02
dw_title dw_title
end type
global w_mpm332i w_mpm332i

on w_mpm332i.create
int iCurrent
call super::create
this.dw_mpm332i_01=create dw_mpm332i_01
this.dw_mpm332i_02=create dw_mpm332i_02
this.dw_title=create dw_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm332i_01
this.Control[iCurrent+2]=this.dw_mpm332i_02
this.Control[iCurrent+3]=this.dw_title
end on

on w_mpm332i.destroy
call super::destroy
destroy(this.dw_mpm332i_01)
destroy(this.dw_mpm332i_02)
destroy(this.dw_title)
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

dw_title.Width = newwidth - (ls_gap * 3)

dw_mpm332i_01.Width = (newwidth / 2) - (ls_gap * 3)
dw_mpm332i_01.Height= newheight - (dw_mpm332i_01.y + ls_status)

dw_mpm332i_02.x = (ls_gap * 4) + dw_mpm332i_01.Width
dw_mpm332i_02.y = dw_mpm332i_01.y
dw_mpm332i_02.Width = (newwidth / 2) - (ls_gap * 3)
dw_mpm332i_02.Height= dw_mpm332i_01.Height
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_title.settransobject(sqlmpms)
dw_mpm332i_01.settransobject(sqlmpms)
dw_mpm332i_02.settransobject(sqlmpms)

dw_title.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_title,'ingstatus',ldwc,'codename',5)

This.Triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_orderno

ll_rowcnt = dw_mpm332i_01.retrieve()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
	return 0
end if

ls_orderno = dw_mpm332i_01.getitemstring(1,"orderno")

dw_mpm332i_02.retrieve(ls_orderno)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm332i
end type

type dw_mpm332i_01 from u_vi_std_datawindow within w_mpm332i
integer x = 27
integer y = 196
integer width = 1330
integer height = 1660
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm332i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_orderno

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
ls_orderno = This.getitemstring(currentrow,"orderno")

//dw_title.reset()
//dw_mpm332i_02.reset()
if ls_orderno <> '00000000' then
	dw_title.retrieve(ls_orderno)
end if
	
dw_mpm332i_02.retrieve(ls_orderno)
end event

event constructor;call super::constructor;ii_selection = 1
end event

type dw_mpm332i_02 from u_vi_std_datawindow within w_mpm332i
integer x = 1381
integer y = 200
integer width = 1280
integer height = 1660
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm332i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;ii_selection = 1
end event

type dw_title from datawindow within w_mpm332i
integer x = 27
integer y = 16
integer width = 2789
integer height = 168
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm332i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

