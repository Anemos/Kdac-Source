$PBExportHeader$w_pisg110b.srw
$PBExportComments$메시지 보내기
forward
global type w_pisg110b from window
end type
type st_row_up1 from statictext within w_pisg110b
end type
type st_row_up from statictext within w_pisg110b
end type
type dw_title from datawindow within w_pisg110b
end type
type st_select_msg from statictext within w_pisg110b
end type
type st_6 from statictext within w_pisg110b
end type
type st_linename from statictext within w_pisg110b
end type
type st_3 from statictext within w_pisg110b
end type
type p_3 from picture within w_pisg110b
end type
type p_2 from picture within w_pisg110b
end type
type dw_send_msg from datawindow within w_pisg110b
end type
type dw_line from datawindow within w_pisg110b
end type
type p_7 from picture within w_pisg110b
end type
type p_6 from picture within w_pisg110b
end type
type pb_row_up1 from picturebutton within w_pisg110b
end type
type pb_row_dn1 from picturebutton within w_pisg110b
end type
type st_7 from statictext within w_pisg110b
end type
type pb_row_up from picturebutton within w_pisg110b
end type
type pb_row_dn from picturebutton within w_pisg110b
end type
type st_5 from statictext within w_pisg110b
end type
type gb_send_info from groupbox within w_pisg110b
end type
type dw_area_info from datawindow within w_pisg110b
end type
type st_row_dn from statictext within w_pisg110b
end type
type st_row_dn1 from statictext within w_pisg110b
end type
end forward

global type w_pisg110b from window
integer width = 3625
integer height = 1950
boolean border = false
windowtype windowtype = child!
long backcolor = 32241141
event ue_info_renewal ( )
st_row_up1 st_row_up1
st_row_up st_row_up
dw_title dw_title
st_select_msg st_select_msg
st_6 st_6
st_linename st_linename
st_3 st_3
p_3 p_3
p_2 p_2
dw_send_msg dw_send_msg
dw_line dw_line
p_7 p_7
p_6 p_6
pb_row_up1 pb_row_up1
pb_row_dn1 pb_row_dn1
st_7 st_7
pb_row_up pb_row_up
pb_row_dn pb_row_dn
st_5 st_5
gb_send_info gb_send_info
dw_area_info dw_area_info
st_row_dn st_row_dn
st_row_dn1 st_row_dn1
end type
global w_pisg110b w_pisg110b

event ue_info_renewal;STRING	ls_terminalcode

// 단말기 코드
ls_terminalcode	= ProfileString(gs_inifile, "Com_Info", "Comcode", "")

// 라인명 갱신
dw_line.settransobject(sqlca)
dw_line.Retrieve(gs_area_code, gs_division_code, ls_terminalcode)

// 메시지 정보 갱신
dw_send_msg.settransobject(sqlca)
dw_send_msg.Retrieve(gs_area_code, gs_division_code)

// 첫째 라인 선택
dw_line.SelectRow(0, FALSE)
dw_line.SelectRow(1, TRUE)

dw_send_msg.SelectRow(0, FALSE)
dw_send_msg.SelectRow(1, TRUE)

// 선택되어진 정보
IF dw_line.RowCount() > 0 THEN 
	st_linename.text		= dw_line.GetItemString(1, "as_linename")
END IF

IF dw_send_msg.RowCount() > 0 THEN
	st_select_msg.text	= dw_send_msg.GetItemString(1, "messagegubun")
END IF

end event

on w_pisg110b.create
this.st_row_up1=create st_row_up1
this.st_row_up=create st_row_up
this.dw_title=create dw_title
this.st_select_msg=create st_select_msg
this.st_6=create st_6
this.st_linename=create st_linename
this.st_3=create st_3
this.p_3=create p_3
this.p_2=create p_2
this.dw_send_msg=create dw_send_msg
this.dw_line=create dw_line
this.p_7=create p_7
this.p_6=create p_6
this.pb_row_up1=create pb_row_up1
this.pb_row_dn1=create pb_row_dn1
this.st_7=create st_7
this.pb_row_up=create pb_row_up
this.pb_row_dn=create pb_row_dn
this.st_5=create st_5
this.gb_send_info=create gb_send_info
this.dw_area_info=create dw_area_info
this.st_row_dn=create st_row_dn
this.st_row_dn1=create st_row_dn1
this.Control[]={this.st_row_up1,&
this.st_row_up,&
this.dw_title,&
this.st_select_msg,&
this.st_6,&
this.st_linename,&
this.st_3,&
this.p_3,&
this.p_2,&
this.dw_send_msg,&
this.dw_line,&
this.p_7,&
this.p_6,&
this.pb_row_up1,&
this.pb_row_dn1,&
this.st_7,&
this.pb_row_up,&
this.pb_row_dn,&
this.st_5,&
this.gb_send_info,&
this.dw_area_info,&
this.st_row_dn,&
this.st_row_dn1}
end on

on w_pisg110b.destroy
destroy(this.st_row_up1)
destroy(this.st_row_up)
destroy(this.dw_title)
destroy(this.st_select_msg)
destroy(this.st_6)
destroy(this.st_linename)
destroy(this.st_3)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.dw_send_msg)
destroy(this.dw_line)
destroy(this.p_7)
destroy(this.p_6)
destroy(this.pb_row_up1)
destroy(this.pb_row_dn1)
destroy(this.st_7)
destroy(this.pb_row_up)
destroy(this.pb_row_dn)
destroy(this.st_5)
destroy(this.gb_send_info)
destroy(this.dw_area_info)
destroy(this.st_row_dn)
destroy(this.st_row_dn1)
end on

event open;/*######################################################################
#####		타이틀명 셋팅															 #####
######################################################################*/

dw_title.setitem(1, "title_name", "MESSAGE 전송")

/*######################################################################
#####		지역, 공장 명 셋팅													 #####
######################################################################*/

dw_area_info.setitem(1, "area_name", gs_area_name)
dw_area_info.setitem(1, "workcenter_name", gs_division_name)



This.TriggerEvent("ue_info_renewal")

end event

type st_row_up1 from statictext within w_pisg110b
integer x = 3214
integer y = 736
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "ROW"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_row_up from statictext within w_pisg110b
integer x = 1445
integer y = 736
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "ROW"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_title from datawindow within w_pisg110b
integer width = 3625
integer height = 200
string dataobject = "d_title_bar"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type st_select_msg from statictext within w_pisg110b
integer x = 2181
integer y = 1816
integer width = 1111
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_pisg110b
integer x = 1595
integer y = 1828
integer width = 549
integer height = 100
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 32241141
string text = "전송메세지"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_linename from statictext within w_pisg110b
integer x = 434
integer y = 1816
integer width = 1083
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisg110b
integer x = 32
integer y = 1828
integer width = 361
integer height = 100
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 32241141
string text = "라인명"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_3 from picture within w_pisg110b
integer x = 3296
integer y = 1400
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_pisg110b
integer x = 3296
integer y = 588
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type dw_send_msg from datawindow within w_pisg110b
event us_system_exit ( )
integer x = 1815
integer y = 524
integer width = 1349
integer height = 1128
integer taborder = 10
string dataobject = "d_pisg110b_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event us_system_exit;CLOSE(w_pisg010b)
end event

event clicked;/*######################################################################
#####		선택되어진 ROW 값 체크												 #####
######################################################################*/

IF ROW > 0 THEN

	/*###################################################################
	#####		하일라이트															 #####
	###################################################################*/

	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)

	st_select_msg.text	= this.GetItemString(row, "messagegubun")
END IF

end event

event dberror;IF sqldbcode = 10005 THEN
	IF gs_SerialFlag = "2" THEN
		// 통신 포트 CLOSE
		w_pisg010b.ole_comm.object.portopen	= FALSE
	END IF

	this.PostEvent("us_system_exit")
	run("ipis_down.exe	"  + gs_appname)
END IF

RETURN 1

end event

type dw_line from datawindow within w_pisg110b
event us_system_exit ( )
integer x = 18
integer y = 524
integer width = 1376
integer height = 1128
integer taborder = 80
string dataobject = "d_pisg110b_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event us_system_exit;CLOSE(w_pisg010b)

end event

event clicked;/*######################################################################
#####		선택되어진 ROW 값 체크												 #####
######################################################################*/

IF ROW > 0 THEN

	/*###################################################################
	#####		하일라이트															 #####
	###################################################################*/

	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)

	st_linename.text	= this.GetItemString(row, "as_linename")
END IF

end event

event dberror;IF sqldbcode = 10005 THEN
	IF gs_SerialFlag = "2" THEN
		// 통신 포트 CLOSE
		w_pisg010b.ole_comm.object.portopen	= FALSE
	END IF

	this.PostEvent("us_system_exit")
	run("ipis_down.exe	"  + gs_appname)
END IF

RETURN 1

end event

type p_7 from picture within w_pisg110b
integer x = 1527
integer y = 588
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type p_6 from picture within w_pisg110b
integer x = 1527
integer y = 1400
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type pb_row_up1 from picturebutton within w_pisg110b
integer x = 1403
integer y = 532
integer width = 384
integer height = 300
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		ROW UP																	 #####
######################################################################*/

IF dw_line.rowcount() > 0 THEN

	// ROW 이동
	dw_line.ScrollPriorRow()
	dw_line.SetRow(dw_line.GETROW())

	// 선택된 ROW 에 포커스를 준다.
	dw_line.SelectRow(0, FALSE)
	dw_line.SelectRow(dw_line.getrow(), TRUE)

	// 선택되어진 정보
	st_linename.text		= dw_line.GetItemString(dw_line.getrow(), "as_linename")
END IF
end event

type pb_row_dn1 from picturebutton within w_pisg110b
integer x = 1403
integer y = 1344
integer width = 384
integer height = 300
integer taborder = 90
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		ROW DOWN																	 #####
######################################################################*/

IF dw_line.rowcount() > 0 THEN

	// ROW 이동
	dw_line.ScrollNextRow()
	dw_line.SetRow(dw_line.GETROW())

	// 선택된 ROW 에 포커스를 준다.
	dw_line.SelectRow(0, FALSE)
	dw_line.SelectRow(dw_line.getrow(), TRUE)

	// 선택되어진 정보
	st_linename.text		= dw_line.GetItemString(dw_line.getrow(), "as_linename")
END IF

end event

type st_7 from statictext within w_pisg110b
integer x = 1394
integer y = 524
integer width = 402
integer height = 1128
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31516896
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_row_up from picturebutton within w_pisg110b
integer x = 3173
integer y = 532
integer width = 384
integer height = 300
integer taborder = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		ROW UP																	 #####
######################################################################*/

IF dw_send_msg.rowcount() > 0 THEN

	// ROW 이동
	dw_send_msg.ScrollPriorRow()
	dw_send_msg.SetRow(dw_send_msg.GETROW())

	// 선택된 ROW 에 포커스를 준다.
	dw_send_msg.SelectRow(0, FALSE)
	dw_send_msg.SelectRow(dw_send_msg.getrow(), TRUE)

	// 선택되어진 정보
	st_select_msg.text	= dw_send_msg.GetItemString(dw_send_msg.getrow(), "messagegubun")
END IF

end event

type pb_row_dn from picturebutton within w_pisg110b
integer x = 3173
integer y = 1344
integer width = 384
integer height = 300
integer taborder = 120
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		ROW DOWN																	 #####
######################################################################*/

IF dw_send_msg.rowcount() > 0 THEN

	// ROW 이동
	dw_send_msg.ScrollNextRow()
	dw_send_msg.SetRow(dw_send_msg.GETROW())

	// 선택된 ROW 에 포커스를 준다.
	dw_send_msg.SelectRow(0, FALSE)
	dw_send_msg.SelectRow(dw_send_msg.getrow(), TRUE)

	// 선택되어진 정보
	st_select_msg.text	= dw_send_msg.GetItemString(dw_send_msg.getrow(), "messagegubun")
END IF

end event

type st_5 from statictext within w_pisg110b
integer x = 3163
integer y = 524
integer width = 402
integer height = 1128
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31516896
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_send_info from groupbox within w_pisg110b
integer y = 1712
integer width = 3584
integer height = 272
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 32241141
string text = "전송 메시지 정보"
end type

type dw_area_info from datawindow within w_pisg110b
integer y = 200
integer width = 3625
integer height = 248
integer taborder = 50
string title = "none"
string dataobject = "d_area_info"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type st_row_dn from statictext within w_pisg110b
integer x = 1445
integer y = 1548
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "ROW"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_row_dn1 from statictext within w_pisg110b
integer x = 3214
integer y = 1548
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "ROW"
alignment alignment = center!
boolean focusrectangle = false
end type

