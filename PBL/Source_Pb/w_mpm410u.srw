$PBExportHeader$w_mpm410u.srw
$PBExportComments$우선순위정보
forward
global type w_mpm410u from w_ipis_sheet01
end type
type st_1 from statictext within w_mpm410u
end type
type st_2 from statictext within w_mpm410u
end type
type dw_mpm410u_01 from u_vi_std_datawindow within w_mpm410u
end type
type dw_mpm410u_02 from u_vi_std_datawindow within w_mpm410u
end type
type st_3 from statictext within w_mpm410u
end type
type pb_run from picturebutton within w_mpm410u
end type
type gb_1 from groupbox within w_mpm410u
end type
end forward

global type w_mpm410u from w_ipis_sheet01
integer width = 3803
integer height = 2096
st_1 st_1
st_2 st_2
dw_mpm410u_01 dw_mpm410u_01
dw_mpm410u_02 dw_mpm410u_02
st_3 st_3
pb_run pb_run
gb_1 gb_1
end type
global w_mpm410u w_mpm410u

type variables
Boolean i_b_down
long i_n_row
end variables

on w_mpm410u.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_mpm410u_01=create dw_mpm410u_01
this.dw_mpm410u_02=create dw_mpm410u_02
this.st_3=create st_3
this.pb_run=create pb_run
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_mpm410u_01
this.Control[iCurrent+4]=this.dw_mpm410u_02
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.pb_run
this.Control[iCurrent+7]=this.gb_1
end on

on w_mpm410u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_mpm410u_01)
destroy(this.dw_mpm410u_02)
destroy(this.st_3)
destroy(this.pb_run)
destroy(this.gb_1)
end on

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= True
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

st_2.x = (newwidth * 3 / 5) + ls_gap
dw_mpm410u_01.Width = (newwidth * 3 / 5) - (ls_gap * 3)
dw_mpm410u_01.Height= newheight - (dw_mpm410u_01.y + ls_status)

dw_mpm410u_02.x = (ls_gap * 4) + dw_mpm410u_01.Width
dw_mpm410u_02.y = dw_mpm410u_01.y
dw_mpm410u_02.Width = (newwidth * 2 / 5) - (ls_gap * 3)
dw_mpm410u_02.Height= dw_mpm410u_01.Height
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm410u_01.settransobject(sqlmpms)
dw_mpm410u_02.settransobject(sqlmpms)

This.Triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_orderno

ll_rowcnt = dw_mpm410u_01.retrieve()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
	return 0
end if
dw_mpm410u_01.selectrow(1,true)
ls_orderno = dw_mpm410u_01.getitemstring(1,"orderno")

dw_mpm410u_02.retrieve(ls_orderno)
end event

event ue_save;call super::ue_save;string ls_message

sqlmpms.AutoCommit = False

if dw_mpm410u_01.modifiedcount() > 0 then
	if dw_mpm410u_01.update() <> 1 then
		ls_message = "금형의뢰 우선순위 저장시에 오류가 발생하였습니다."
		goto RollBack_
	end if
end if

if dw_mpm410u_02.modifiedcount() > 0 then
	if dw_mpm410u_02.update() <> 1 then
		ls_message = "금형품목 우선순위 저장시에 오류가 발생하였습니다."
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True
uo_status.st_message.text = "저장되었습니다."

return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True
uo_status.st_message.text = ls_message

return -1
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm410u
end type

type st_1 from statictext within w_mpm410u
integer x = 37
integer y = 204
integer width = 800
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "금형의뢰 우선순위"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpm410u
integer x = 2176
integer y = 204
integer width = 800
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "금형품목 우선순위"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_mpm410u_01 from u_vi_std_datawindow within w_mpm410u
event ue_mousemove pbm_dwnmousemove
integer x = 37
integer y = 304
integer width = 2112
integer height = 1396
integer taborder = 11
string dragicon = "Asterisk!"
boolean bringtotop = true
string dataobject = "d_mpm410u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_mousemove;if i_b_down then
	this.Drag (begin!)
end if
end event

event clicked;call super::clicked;String ls_orderno

i_b_down = true

if row < 1 then
	return -1
end if

dw_mpm410u_02.reset()

This.selectrow( 0, False )
This.selectrow( row, True )
end event

event ue_lbuttonup;call super::ue_lbuttonup;i_b_down = false
end event

event dragdrop;call super::dragdrop;long ll_selrow, ll_cnt, ll_priorityno

ll_selrow = this.getselectedrow(0)
ll_priorityno = this.getitemnumber(ll_selrow,"priorityno")

this.RowsMove(ll_selrow, ll_selrow, Primary!, this, row, Primary!)

if ( row >= 10 and ll_selrow >= 10 ) then return 0

if row <= ll_selrow then
	this.setitem(row,"priorityno",row)
	ll_priorityno = row + 1
	for ll_cnt = row + 1 to 10
		this.setitem(ll_cnt,"priorityno",ll_priorityno)
		ll_priorityno = ll_priorityno + 1
		if ll_cnt >= 10 then
			ll_priorityno = 10
		end if
	next
else
	for ll_cnt = ll_selrow to 10
		this.setitem(ll_cnt,"priorityno",ll_priorityno)
		ll_priorityno = ll_priorityno + 1
		
		if ll_priorityno >= 10 then
			ll_priorityno = 10
		end if
	next
end if

return 0
end event

event dragwithin;call super::dragwithin;i_n_row = row

if i_n_row = row then
	this.ScrollPriorRow()
end if
end event

event retrieveend;call super::retrieveend;string ls_orderno

do while true
	SELECT TOP 1 a.OrderNo INTO :ls_orderno
	FROM TORDER a INNER JOIN TROUTING b
		ON a.OrderNo = b.OrderNo
		INNER JOIN TPARTLIST c
		ON b.OrderNo = c.OrderNo  AND b.PartNo = c.PartNo
	WHERE a.IngStatus = '4' AND b.WorkStatus <> 'C' AND c.PriorityNo is null
	using sqlmpms;
	
	if f_spacechk(ls_orderno) = -1 or sqlmpms.sqlcode <> 0 then
		exit
	end if
	
	//품목정보 우선순위 배정 SP
	DECLARE up_mpms_setpriority_partlist PROCEDURE FOR sp_mpms_setpriority_partlist  
				@ps_orderno = :ls_orderno  using sqlmpms;
	Execute up_mpms_setpriority_partlist;
	
	if sqlmpms.sqlcode = -1 then
		uo_status.st_message.text = "품목정보 우선순위 배정 중에 에러가 발생하였습니다. : " + string(sqlmpms.sqlcode)
		exit
	end if
loop

return 0
end event

event doubleclicked;call super::doubleclicked;String ls_orderno

i_b_down = true

if row < 1 then
	return -1
end if

dw_mpm410u_02.reset()

ls_orderno = This.getitemstring(row,"orderno")

dw_mpm410u_02.retrieve(ls_orderno)
end event

type dw_mpm410u_02 from u_vi_std_datawindow within w_mpm410u
event ue_mousemove pbm_dwnmousemove
integer x = 2176
integer y = 304
integer width = 1083
integer height = 1396
integer taborder = 10
string dragicon = "Asterisk!"
boolean bringtotop = true
string dataobject = "d_mpm410u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_mousemove;if i_b_down then
	this.Drag (begin!)
end if
end event

event clicked;call super::clicked;i_b_down = true
end event

event dragdrop;call super::dragdrop;long ll_selrow, ll_cnt, ll_priorityno

ll_selrow = this.getselectedrow(0)
ll_priorityno = this.getitemnumber(ll_selrow,"priorityno")

this.RowsMove(ll_selrow, ll_selrow, Primary!, this, row, Primary!)

if row <= ll_selrow then
	this.setitem(row,"priorityno",row)
	ll_priorityno = row + 1
	for ll_cnt = row + 1 to this.Rowcount()
		this.setitem(ll_cnt,"priorityno",ll_priorityno)
		ll_priorityno = ll_priorityno + 1
	next
else
	for ll_cnt = ll_selrow to this.Rowcount()
		this.setitem(ll_cnt,"priorityno",ll_priorityno)
		ll_priorityno = ll_priorityno + 1
	next
end if

return 0
end event

event dragwithin;call super::dragwithin;i_n_row = row

if i_n_row = row then
	this.ScrollPriorRow()
end if
end event

event ue_lbuttonup;call super::ue_lbuttonup;i_b_down = false
end event

type st_3 from statictext within w_mpm410u
integer x = 78
integer y = 56
integer width = 855
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "예상납기정보 생성"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_run from picturebutton within w_mpm410u
integer x = 978
integer y = 44
integer width = 375
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\run.bmp"
end type

event clicked;//********************************* 
//  버전별 생성 작업 w_mpm410u_01 popup window를 open한다.
//*********************************

openwithparm(w_mpm410u_01, '')

iw_this.Triggerevent('ue_retrieve')

return 0
end event

type gb_1 from groupbox within w_mpm410u
integer x = 32
integer y = 12
integer width = 1362
integer height = 164
integer taborder = 10
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

