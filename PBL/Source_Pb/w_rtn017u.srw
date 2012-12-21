$PBExportHeader$w_rtn017u.srw
$PBExportComments$서브출하품 등록
forward
global type w_rtn017u from w_ipis_sheet01
end type
type pb_1 from picturebutton within w_rtn017u
end type
type st_2 from statictext within w_rtn017u
end type
type st_3 from statictext within w_rtn017u
end type
type dw_rtn017u_01 from u_vi_std_datawindow within w_rtn017u
end type
type dw_rtn017u_02 from u_vi_std_datawindow within w_rtn017u
end type
type uo_1 from uo_plandiv_bom within w_rtn017u
end type
type st_1 from statictext within w_rtn017u
end type
type gb_1 from groupbox within w_rtn017u
end type
end forward

global type w_rtn017u from w_ipis_sheet01
pb_1 pb_1
st_2 st_2
st_3 st_3
dw_rtn017u_01 dw_rtn017u_01
dw_rtn017u_02 dw_rtn017u_02
uo_1 uo_1
st_1 st_1
gb_1 gb_1
end type
global w_rtn017u w_rtn017u

on w_rtn017u.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_rtn017u_01=create dw_rtn017u_01
this.dw_rtn017u_02=create dw_rtn017u_02
this.uo_1=create uo_1
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_rtn017u_01
this.Control[iCurrent+5]=this.dw_rtn017u_02
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_1
end on

on w_rtn017u.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_rtn017u_01)
destroy(this.dw_rtn017u_02)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_rtn017u_01.Width = (newwidth * 50 / 100)	- (ls_split * 3)
dw_rtn017u_01.Height= newheight - (dw_rtn017u_01.y + ls_status)

dw_rtn017u_02.x = (ls_split * 4) + dw_rtn017u_01.Width
dw_rtn017u_02.y = dw_rtn017u_01.y
dw_rtn017u_02.Width = (newwidth * 50 / 100) - (ls_gap * 4)
dw_rtn017u_02.Height= dw_rtn017u_01.Height

st_3.x = dw_rtn017u_02.x

end event

event ue_save;call super::ue_save;string  ls_message, ls_line1, ls_chkline
integer li_cnt, li_rowcnt, li_option

SetPointer(HourGlass!)
//----------- 공장 선택 ----------
uo_status.st_message.text = ''
dw_rtn017u_02.accepttext()

SQLCA.AUTOCOMMIT = FALSE

if dw_rtn017u_02.update() <> 1 then
	ls_message = "저장시 오류가 발생했습니다."
	goto Rollback_
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

this.triggerevent("ue_retrieve")
uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
end event

event ue_delete;call super::ue_delete;long ll_selrow

ll_selrow = dw_rtn017u_02.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "삭제할 서브출하품번을 선택해 주십시요."
	return -1
end if

dw_rtn017u_02.deleterow(ll_selrow)
end event

event ue_postopen;call super::ue_postopen;dw_rtn017u_01.settransobject(sqlca)
dw_rtn017u_02.settransobject(sqlca)
end event

event ue_retrieve;call super::ue_retrieve;string l_s_parm, l_s_plant, l_s_dvsn

l_s_parm     = uo_1.uf_Return()
l_s_plant    = mid(l_s_parm,1,1)
l_s_dvsn   = mid(l_s_parm,2,1)

dw_rtn017u_01.reset()
dw_rtn017u_02.reset()

dw_rtn017u_01.retrieve(l_s_plant, l_s_dvsn, g_s_date)
dw_rtn017u_02.retrieve(l_s_plant, l_s_dvsn, g_s_date)


return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_rtn017u
end type

type pb_1 from picturebutton within w_rtn017u
integer x = 1806
integer y = 248
integer width = 283
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\userright.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long	ll_SaveRow[] 
string ls_plant, ls_dvsn, ls_itno

setpointer(hourglass!)
// 선택된 행이 있는지 체크한다
//
ll_row = dw_rtn017u_01.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN 0
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_rtn017u_01.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	ls_plant  = dw_rtn017u_01.getitemstring(ll_SaveRow[ll_row],'replant')
	ls_dvsn   = dw_rtn017u_01.getitemstring(ll_SaveRow[ll_row],'redvsn')
	ls_itno = dw_rtn017u_01.getitemstring(ll_SaveRow[ll_row],'reitno')

	ll_lastrow = dw_rtn017u_02.insertrow(0)
	dw_rtn017u_02.setitem(ll_lastrow,'rcmcd', '01')
	dw_rtn017u_02.setitem(ll_lastrow,'rplant', ls_plant)
	dw_rtn017u_02.setitem(ll_lastrow,'rdvsn', ls_dvsn)
	dw_rtn017u_02.setitem(ll_lastrow,'ritno', ls_itno)
	dw_rtn017u_02.setitem(ll_lastrow,'repno', g_s_empno )
	dw_rtn017u_02.setitem(ll_lastrow,'ripad', g_s_ipaddr)
	dw_rtn017u_02.setitem(ll_lastrow,'rsydt', g_s_date)
	dw_rtn017u_02.SelectRow(0, False)
	dw_rtn017u_02.SelectRow(ll_lastrow, True)	
	dw_rtn017u_02.ScrollToRow(ll_lastrow)
	dw_rtn017u_01.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 이동이 끝난 좌측화면의 선택행은 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_rtn017u_01.RowCount() to 1 step -1
	IF dw_rtn017u_01.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_rtn017u_01.DeleteRow(ll_row)
	END IF
NEXT

return 0


end event

type st_2 from statictext within w_rtn017u
integer x = 27
integer y = 268
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "라우팅등록품번"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_rtn017u
integer x = 2217
integer y = 272
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "서브출하품번"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn017u_01 from u_vi_std_datawindow within w_rtn017u
integer x = 27
integer y = 380
integer width = 1445
integer height = 1120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_rtn017u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_rtn017u_02 from u_vi_std_datawindow within w_rtn017u
integer x = 1650
integer y = 412
integer width = 1481
integer height = 1108
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_rtn017u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_1 from uo_plandiv_bom within w_rtn017u
integer x = 78
integer y = 52
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type st_1 from statictext within w_rtn017u
integer x = 1125
integer y = 272
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "선택품번이동버튼"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_rtn017u
integer x = 32
integer width = 1367
integer height = 196
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

