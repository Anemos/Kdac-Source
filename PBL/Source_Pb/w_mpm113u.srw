$PBExportHeader$w_mpm113u.srw
$PBExportComments$부서및인원관리
forward
global type w_mpm113u from w_ipis_sheet01
end type
type dw_mpm113u_01 from u_vi_std_datawindow within w_mpm113u
end type
type dw_mpm113u_02 from datawindow within w_mpm113u
end type
type st_1 from statictext within w_mpm113u
end type
type pb_1 from picturebutton within w_mpm113u
end type
type gb_1 from groupbox within w_mpm113u
end type
end forward

global type w_mpm113u from w_ipis_sheet01
integer width = 4041
dw_mpm113u_01 dw_mpm113u_01
dw_mpm113u_02 dw_mpm113u_02
st_1 st_1
pb_1 pb_1
gb_1 gb_1
end type
global w_mpm113u w_mpm113u

type variables

end variables

on w_mpm113u.create
int iCurrent
call super::create
this.dw_mpm113u_01=create dw_mpm113u_01
this.dw_mpm113u_02=create dw_mpm113u_02
this.st_1=create st_1
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm113u_01
this.Control[iCurrent+2]=this.dw_mpm113u_02
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_mpm113u.destroy
call super::destroy
destroy(this.dw_mpm113u_01)
destroy(this.dw_mpm113u_02)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm113u_01.Width = (newwidth * 2 / 5)	- (ls_gap * 2)
dw_mpm113u_01.Height= newheight - (dw_mpm113u_01.y + ls_status)

dw_mpm113u_02.x = (ls_gap * 3) + dw_mpm113u_01.Width
dw_mpm113u_02.y = dw_mpm113u_01.y
dw_mpm113u_02.Width = (newwidth * 3 / 5) - (ls_gap * 3)
dw_mpm113u_02.Height= dw_mpm113u_01.Height
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm113u_01.settransobject(sqlmpms)
dw_mpm113u_02.settransobject(sqlmpms)

dw_mpm113u_02.GetChild('wccode', ldwc)
f_pisc_set_dddw_width(dw_mpm113u_02,'wccode',ldwc,'wcname',16)
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;dw_mpm113u_01.reset()

if dw_mpm113u_01.retrieve() < 1 then
	uo_status.st_message.text = "조회된 데이타가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if

return 0
end event

event ue_save;call super::ue_save;string ls_message

dw_mpm113u_01.accepttext()
dw_mpm113u_02.accepttext()

if dw_mpm113u_01.modifiedcount() < 1 and dw_mpm113u_02.modifiedcount() < 1 then
	uo_status.st_message.text = "변경된 데이타가 없습니다."
	return 0
end if

sqlmpms.AutoCommit = False

if dw_mpm113u_01.modifiedcount() > 0 then
	if dw_mpm113u_01.update() <> 1 then
		ls_message = "DeptError"
		goto RollBack_
	end if
end if

if dw_mpm113u_02.modifiedcount() > 0 then
	if dw_mpm113u_02.update() <> 1 then
		ls_message = "EmpError"
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True

This.Triggerevent("ue_retrieve")

uo_status.st_message.text = "저장되었습니다."
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'DeptError'
		uo_status.st_message.text = "부서코드저장시에 에러가 발생하였습니다."
	case 'EmpError'
		uo_status.st_message.text = "작업자저장시에 에러가 발생하였습니다."
	case else
		uo_status.st_message.text = "저장시에 에러가 발생하였습니다."
end choose

return 0


end event

event ue_delete;call super::ue_delete;long ll_selrow
string ls_deptcode

ll_selrow = dw_mpm113u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "삭제할 부서코드를 선택하십시요"
	return 0
end if
ls_deptcode = dw_mpm113u_01.getitemstring(ll_selrow,"deptcode")
if MessageBox("확인", "부서코드 " + ls_deptcode + " 를 삭제하시겠습니까?", &
	Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

sqlmpms.AutoCommit = False

DELETE TMOLDDEPT
WHERE DeptCode = :ls_deptcode using sqlmpms;

if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows <> 1 then
	Rollback using sqlmpms;
	sqlmpms.AutoCommit = True
	uo_status.st_message.text = "삭제시에 오류가 발생하였습니다"
	return 0
else
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	This.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "삭제되었습니다."
	return 0
end if


end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm113u
end type

type dw_mpm113u_01 from u_vi_std_datawindow within w_mpm113u
integer x = 27
integer y = 192
integer width = 1221
integer height = 1600
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm113u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_deptcode

dw_mpm113u_02.reset()

If currentrow < 1 Then
	return 0
End If

this.SelectRow(0,False)
this.SelectRow(currentrow, True)

ls_deptcode = This.getitemstring( currentrow, 'deptcode')

dw_mpm113u_02.retrieve( ls_deptcode )
end event

type dw_mpm113u_02 from datawindow within w_mpm113u
event ue_key pbm_dwnkey
integer x = 1280
integer y = 192
integer width = 2121
integer height = 1596
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mpm113u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;If key = keyenter! Then
	iw_this.Triggerevent("ue_insert")
End If

return 0
end event

event itemchanged;String 	ls_colName, ls_null, ls_wccode

this.AcceptText ( )

SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'operno'
		if data = '000' then
			This.setitem( row, 'operno', ls_null )
			return 1
		end if
		if Not Isnumber(data) or len(data) <> 3 then
			This.setitem( row, 'operno', ls_null )
			return 1
		end if
	Case 'stdtime'
		ls_wccode = This.getitemstring( row, 'wccode')
		if ls_wccode = 'THT' then
			if integer(data) <> 0 then
				This.setitem( row, ls_colName, 0 )
				return 1
			end if
		else
			if integer(data) = 0 then
				Messagebox("알림", "예상시간을 입력바랍니다.")
			end if
		end if
//	Case 'stdheatcost'
//		ls_wccode = This.getitemstring( row, 'wccode')
//		if ls_wccode
End Choose
end event

event rowfocuschanged;integer li_chk

if currentrow < 1 then
	return 0
end if

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)
end event

type st_1 from statictext within w_mpm113u
integer x = 133
integer y = 56
integer width = 576
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "부서코드추가 :"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_mpm113u
integer x = 782
integer y = 44
integer width = 238
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
end type

event clicked;string ls_rtnparm, ls_deptname
long ll_currow

openwithparm(w_mpms_find_dept,'1')
ls_rtnparm = message.stringparm

SELECT DeptName INTO :ls_deptname
FROM TMSTDEPT
WHERE DeptCode = :ls_rtnparm using sqlmpms;

if sqlmpms.sqlcode = 0 then
	ll_currow = dw_mpm113u_01.insertrow(0)
	dw_mpm113u_01.setitem(ll_currow,'deptcode',ls_rtnparm)
	dw_mpm113u_01.setitem(ll_currow,'deptname',ls_deptname)
	dw_mpm113u_01.setitem(ll_currow,'applyfrom',string(g_s_date,"@@@@.@@.@@"))
	dw_mpm113u_01.setitem(ll_currow,'applyto','9999.12.31')
	dw_mpm113u_01.setitem(ll_currow,'lastemp',g_s_empno)
	
	iw_this.triggerevent("ue_save")
end if
end event

type gb_1 from groupbox within w_mpm113u
integer x = 27
integer width = 1143
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

