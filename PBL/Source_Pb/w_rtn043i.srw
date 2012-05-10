$PBExportHeader$w_rtn043i.srw
$PBExportComments$승인/결재 진행조회
forward
global type w_rtn043i from w_ipis_sheet01
end type
type st_1 from statictext within w_rtn043i
end type
type dw_rtn043i_01 from u_vi_std_datawindow within w_rtn043i
end type
type st_2 from statictext within w_rtn043i
end type
type dw_rtn043i_02 from u_vi_std_datawindow within w_rtn043i
end type
type st_3 from statictext within w_rtn043i
end type
end forward

global type w_rtn043i from w_ipis_sheet01
st_1 st_1
dw_rtn043i_01 dw_rtn043i_01
st_2 st_2
dw_rtn043i_02 dw_rtn043i_02
st_3 st_3
end type
global w_rtn043i w_rtn043i

type variables

end variables

on w_rtn043i.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_rtn043i_01=create dw_rtn043i_01
this.st_2=create st_2
this.dw_rtn043i_02=create dw_rtn043i_02
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_rtn043i_01
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_rtn043i_02
this.Control[iCurrent+5]=this.st_3
end on

on w_rtn043i.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_rtn043i_01)
destroy(this.st_2)
destroy(this.dw_rtn043i_02)
destroy(this.st_3)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_rtn043i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_rtn043i_01.Height= ( newheight * 2 / 5 ) - dw_rtn043i_01.y

st_2.x = dw_rtn043i_01.x
st_2.y = dw_rtn043i_01.y + dw_rtn043i_01.Height + ls_split

dw_rtn043i_02.x = dw_rtn043i_01.x
dw_rtn043i_02.y = dw_rtn043i_01.y + dw_rtn043i_01.Height + st_2.Height + ls_split
dw_rtn043i_02.Width = dw_rtn043i_01.Width
dw_rtn043i_02.Height = newheight - ( st_2.y + st_2.Height + ls_status)
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

event ue_postopen;call super::ue_postopen;dw_rtn043i_01.settransobject(sqlca)
dw_rtn043i_02.settransobject(sqlca)

This.triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt

dw_rtn043i_01.reset()
dw_rtn043i_02.reset()

if dw_rtn043i_01.retrieve() > 0 then
	dw_rtn043i_01.selectrow(0,false)
	dw_rtn043i_01.selectrow(1,true)
else
	uo_status.st_message.text = "결재진행중인 내용이 존재하지 않습니다."
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_rtn043i
end type

type st_1 from statictext within w_rtn043i
integer x = 32
integer y = 32
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15780518
string text = "결재진행내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn043i_01 from u_vi_std_datawindow within w_rtn043i
integer x = 37
integer y = 120
integer width = 3255
integer height = 724
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn043i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_chtime, ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime
string ls_dlemp, ls_dlchk, ls_dltime, ls_chk
long ll_rowcnt

if currentrow < 1 or currentrow = 100 then
	return 0
end if

dw_rtn043i_02.reset()
if this.getitemstring(currentrow,"gubun") = 'RTN011' then
	dw_rtn043i_02.dataobject = "d_rtn043i_02"
else
	dw_rtn043i_02.dataobject = "d_rtn043i_03"
end if
dw_rtn043i_02.settransobject(sqlca)

ls_inemp = this.getitemstring(currentrow,"rtn011_rainemp") + '%'
ls_inchk = this.getitemstring(currentrow,"rtn011_rainchk") + '%'
ls_intime = this.getitemstring(currentrow,"rtn011_raintime") + '%'
ls_plemp = this.getitemstring(currentrow,"rtn011_raplemp") + '%'
ls_plchk = this.getitemstring(currentrow,"rtn011_raplchk") + '%'
ls_pltime = this.getitemstring(currentrow,"rtn011_rapltime") + '%'
ls_dlemp = this.getitemstring(currentrow,"rtn011_radlemp") + '%'
ls_dlchk = this.getitemstring(currentrow,"rtn011_radlchk") + '%'
ls_dltime = this.getitemstring(currentrow,"rtn011_radltime") + '%'

ll_rowcnt = dw_rtn043i_02.retrieve(ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime, &
	ls_dlemp, ls_dlchk, ls_dltime, g_s_date)
	
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	uo_status.st_message.text = ""
end if

return 0
end event

type st_2 from statictext within w_rtn043i
integer x = 32
integer y = 904
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "결재내역 세부정보"
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn043i_02 from u_vi_std_datawindow within w_rtn043i
integer x = 37
integer y = 992
integer width = 3269
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn043i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type st_3 from statictext within w_rtn043i
integer x = 827
integer y = 40
integer width = 2171
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 12632256
string text = "최종적으로 팀장결재가 완료되면 진행내역에서 조회되지 않습니다."
boolean focusrectangle = false
end type

