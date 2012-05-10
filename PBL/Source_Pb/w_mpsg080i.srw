$PBExportHeader$w_mpsg080i.srw
$PBExportComments$작업일보 조회
forward
global type w_mpsg080i from window
end type
type dw_mpsg080i_03 from datawindow within w_mpsg080i
end type
type dw_mpsg080i_02 from datawindow within w_mpsg080i
end type
type em_search_date from editmask within w_mpsg080i
end type
type uo_select_date from uo_today within w_mpsg080i
end type
type st_1 from statictext within w_mpsg080i
end type
type p_5 from picture within w_mpsg080i
end type
type st_page_dn from statictext within w_mpsg080i
end type
type st_row_dn from statictext within w_mpsg080i
end type
type st_row_up from statictext within w_mpsg080i
end type
type st_page_up from statictext within w_mpsg080i
end type
type p_4 from picture within w_mpsg080i
end type
type p_3 from picture within w_mpsg080i
end type
type p_2 from picture within w_mpsg080i
end type
type p_1 from picture within w_mpsg080i
end type
type pb_page_up from picturebutton within w_mpsg080i
end type
type pb_row_up from picturebutton within w_mpsg080i
end type
type pb_row_dn from picturebutton within w_mpsg080i
end type
type pb_page_dn from picturebutton within w_mpsg080i
end type
type st_5 from statictext within w_mpsg080i
end type
type dw_title from datawindow within w_mpsg080i
end type
type dw_mpsg080i_01 from datawindow within w_mpsg080i
end type
type dw_area_info from datawindow within w_mpsg080i
end type
end forward

global type w_mpsg080i from window
integer width = 4649
integer height = 2600
boolean border = false
windowtype windowtype = child!
long backcolor = 32241141
event ue_line_select ( )
dw_mpsg080i_03 dw_mpsg080i_03
dw_mpsg080i_02 dw_mpsg080i_02
em_search_date em_search_date
uo_select_date uo_select_date
st_1 st_1
p_5 p_5
st_page_dn st_page_dn
st_row_dn st_row_dn
st_row_up st_row_up
st_page_up st_page_up
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
pb_page_up pb_page_up
pb_row_up pb_row_up
pb_row_dn pb_row_dn
pb_page_dn pb_page_dn
st_5 st_5
dw_title dw_title
dw_mpsg080i_01 dw_mpsg080i_01
dw_area_info dw_area_info
end type
global w_mpsg080i w_mpsg080i

type variables
LONG		il_rowcount			// Rows 체크

end variables

event ue_line_select();String ls_select_date, ls_workman, ls_wcgubun

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ls_select_date = uo_select_date.sle_date.text
ls_workman = dw_mpsg080i_02.getitemstring(1,"ag_workman")
if ls_workman = 'ALL' then
	ls_workman = '%'
end if
ls_wcgubun = dw_mpsg080i_02.getitemstring(1,"ag_wcgubun")

dw_mpsg080i_03.settransobject(sqlca)
dw_mpsg080i_01.settransobject(sqlca)
dw_mpsg080i_01.Retrieve(ls_select_date, ls_wcgubun, ls_workman)

dw_mpsg080i_01.SelectRow(0, FALSE)
dw_mpsg080i_01.SelectRow(1, TRUE)
end event
on w_mpsg080i.create
this.dw_mpsg080i_03=create dw_mpsg080i_03
this.dw_mpsg080i_02=create dw_mpsg080i_02
this.em_search_date=create em_search_date
this.uo_select_date=create uo_select_date
this.st_1=create st_1
this.p_5=create p_5
this.st_page_dn=create st_page_dn
this.st_row_dn=create st_row_dn
this.st_row_up=create st_row_up
this.st_page_up=create st_page_up
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.pb_page_up=create pb_page_up
this.pb_row_up=create pb_row_up
this.pb_row_dn=create pb_row_dn
this.pb_page_dn=create pb_page_dn
this.st_5=create st_5
this.dw_title=create dw_title
this.dw_mpsg080i_01=create dw_mpsg080i_01
this.dw_area_info=create dw_area_info
this.Control[]={this.dw_mpsg080i_03,&
this.dw_mpsg080i_02,&
this.em_search_date,&
this.uo_select_date,&
this.st_1,&
this.p_5,&
this.st_page_dn,&
this.st_row_dn,&
this.st_row_up,&
this.st_page_up,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.pb_page_up,&
this.pb_row_up,&
this.pb_row_dn,&
this.pb_page_dn,&
this.st_5,&
this.dw_title,&
this.dw_mpsg080i_01,&
this.dw_area_info}
end on

on w_mpsg080i.destroy
destroy(this.dw_mpsg080i_03)
destroy(this.dw_mpsg080i_02)
destroy(this.em_search_date)
destroy(this.uo_select_date)
destroy(this.st_1)
destroy(this.p_5)
destroy(this.st_page_dn)
destroy(this.st_row_dn)
destroy(this.st_row_up)
destroy(this.st_page_up)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.pb_page_up)
destroy(this.pb_row_up)
destroy(this.pb_row_dn)
destroy(this.pb_page_dn)
destroy(this.st_5)
destroy(this.dw_title)
destroy(this.dw_mpsg080i_01)
destroy(this.dw_area_info)
end on

event open;/*######################################################################
#####		타이틀명 셋팅															 #####
######################################################################*/

dw_title.setitem(1, "title_name", "작업일보현황")

/*######################################################################
#####		지역, 공장 명 셋팅													 #####
######################################################################*/

//dw_area_info.setitem(1, "area_name", gs_area_name)
//dw_area_info.setitem(1, "workcenter_name", gs_division_name)

/*######################################################################
#####		라인 선택																 #####
######################################################################*/

//This.TriggerEvent("ue_line_select")

/*######################################################################
#####		라인수가 5라인이 넘는 경우											 #####
######################################################################*/


/*######################################################################
#####		1분마다 시간 업데이트												 #####
######################################################################*/

timer(60)

end event

event timer;/*######################################################################
#####		1분마다 정보를 갱신한다.											 #####
######################################################################*/

IF gi_page_index = 2 THEN
	// 실적등록의 LINE선택 이벤트
	THIS.TriggerEvent("ue_line_select")
END IF

end event

type dw_mpsg080i_03 from datawindow within w_mpsg080i
boolean visible = false
integer x = 1536
integer y = 644
integer width = 2889
integer height = 1912
integer taborder = 30
string title = "none"
string dataobject = "d_mpsg080i_03"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;/*######################################################################
#####		선택되어진 ROW 값 체크												 #####
######################################################################*/

IF ROW > 0 THEN

	/*###################################################################
	#####		하일라이트															 #####
	###################################################################*/

	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)
END IF

dw_mpsg080i_02.setitem(1,"ag_workman",this.getitemstring(row,"empno"))
dw_mpsg080i_03.visible = False
Parent.TriggerEvent("ue_line_select")
end event
type dw_mpsg080i_02 from datawindow within w_mpsg080i
integer x = 1961
integer y = 512
integer width = 2469
integer height = 128
integer taborder = 50
string dataobject = "d_mpsg080i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_wcgubun

if dwo.name = 'b_search' then
	ls_wcgubun = This.getitemstring(1,"ag_wcgubun")
	if dw_mpsg080i_03.visible then
		dw_mpsg080i_03.visible = false
	else
		dw_mpsg080i_03.visible = true
		dw_mpsg080i_03.settransobject(sqlca)
		dw_mpsg080i_03.retrieve(ls_wcgubun)
	end if
end if
end event

event constructor;dw_mpsg080i_02.insertrow(0)
dw_mpsg080i_02.setitem(1,"ag_wcgubun",'A')
dw_mpsg080i_02.setitem(1,"ag_workman",'ALL')
end event

event itemchanged;Parent.Triggerevent("ue_line_select")
end event
type em_search_date from editmask within w_mpsg080i
event ue_keydown pbm_keydown
event ue_date_change ( )
integer x = 795
integer y = 512
integer width = 1147
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy년 mm월 dd일"
end type

event ue_keydown;IF KEY = KeyEnter! THEN
	w_mpsg080i.em_search_date.TriggerEvent("ue_date_change")
END IF
end event

event ue_date_change();STRING	ls_select_date, ls_wcgubun, ls_workman

INTEGER	li_total_kb_num
INTEGER	li_finish_kb_num

/*######################################################################
#####		기준일																	 #####
######################################################################*/

this.text = string(date(uo_select_date.sle_date.text))

ls_select_date = uo_select_date.sle_date.text

if dw_mpsg080i_02.rowcount() = 1 then
	ls_wcgubun = dw_mpsg080i_02.getitemstring(1,"ag_wcgubun")
	ls_workman = dw_mpsg080i_02.getitemstring(1,"ag_workman")
	if ls_workman = 'ALL' then
		ls_workman = '%'
	end if
else
	ls_wcgubun = 'A'
	ls_workman = '%'
end if

dw_mpsg080i_01.settransobject(sqlca)
dw_mpsg080i_01.Retrieve(ls_select_date, ls_wcgubun, ls_workman)

// 하일라이트
dw_mpsg080i_01.SelectRow(0, FALSE)
dw_mpsg080i_01.SelectRow(1, TRUE)
end event

type uo_select_date from uo_today within w_mpsg080i
event destroy ( )
integer x = 512
integer y = 504
integer height = 148
integer taborder = 30
end type

on uo_select_date.destroy
call uo_today::destroy
end on

event ue_variable_set;call super::ue_variable_set;em_search_date.TriggerEvent("ue_date_change")
end event

type st_1 from statictext within w_mpsg080i
integer x = 206
integer y = 512
integer width = 288
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 32827087
string text = "기준일"
boolean focusrectangle = false
end type

type p_5 from picture within w_mpsg080i
integer x = 96
integer y = 536
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type st_page_dn from statictext within w_mpsg080i
integer x = 4247
integer y = 1868
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
string text = "PAGE"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_row_dn from statictext within w_mpsg080i
integer x = 4247
integer y = 1572
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

type st_row_up from statictext within w_mpsg080i
integer x = 4247
integer y = 1196
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

type st_page_up from statictext within w_mpsg080i
integer x = 4247
integer y = 900
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
string text = "PAGE"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_4 from picture within w_mpsg080i
integer x = 4329
integer y = 1720
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pagedown.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_mpsg080i
integer x = 4329
integer y = 1424
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_mpsg080i
integer x = 4329
integer y = 1048
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_mpsg080i
integer x = 4329
integer y = 752
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pageup.gif"
boolean focusrectangle = false
end type

type pb_page_up from picturebutton within w_mpsg080i
integer x = 4201
integer y = 696
integer width = 384
integer height = 300
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		PAGE UP																	 #####
######################################################################*/

// ROW 이동
dw_mpsg080i_01.ScrollPriorPage ()
dw_mpsg080i_01.SetRow(dw_mpsg080i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg080i_01.SelectRow(0, FALSE)
dw_mpsg080i_01.SelectRow(dw_mpsg080i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

end event

type pb_row_up from picturebutton within w_mpsg080i
integer x = 4201
integer y = 992
integer width = 384
integer height = 300
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

// ROW 이동
dw_mpsg080i_01.ScrollPriorRow()
dw_mpsg080i_01.SetRow(dw_mpsg080i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg080i_01.SelectRow(0, FALSE)
dw_mpsg080i_01.SelectRow(dw_mpsg080i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

end event

type pb_row_dn from picturebutton within w_mpsg080i
integer x = 4201
integer y = 1368
integer width = 384
integer height = 300
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

// ROW 이동
dw_mpsg080i_01.ScrollNextRow()
dw_mpsg080i_01.SetRow(dw_mpsg080i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg080i_01.SelectRow(0, FALSE)
dw_mpsg080i_01.SelectRow(dw_mpsg080i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

end event

type pb_page_dn from picturebutton within w_mpsg080i
integer x = 4201
integer y = 1664
integer width = 384
integer height = 300
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		PAGE DOWN																 #####
######################################################################*/

// ROW 이동
dw_mpsg080i_01.ScrollNextPage()
dw_mpsg080i_01.SetRow(dw_mpsg080i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg080i_01.SelectRow(0, FALSE)
dw_mpsg080i_01.SelectRow(dw_mpsg080i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/


end event

type st_5 from statictext within w_mpsg080i
integer x = 4197
integer y = 688
integer width = 402
integer height = 1284
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

type dw_title from datawindow within w_mpsg080i
integer width = 4617
integer height = 200
integer taborder = 30
string dataobject = "d_title_bar"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type dw_mpsg080i_01 from datawindow within w_mpsg080i
event ue_keydown pbm_keydown
event us_system_exit ( )
integer x = 18
integer y = 688
integer width = 4160
integer height = 1868
integer taborder = 20
string dataobject = "d_mpsg080i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event us_system_exit();CLOSE(w_mpsg010b)

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
END IF

/*######################################################################
#####		간판번호 입력창에 FOCUS												 #####
######################################################################*/



end event

event dberror;//IF sqldbcode = 10005 THEN
//	IF gs_SerialFlag = "2" THEN
//		// 통신 포트 CLOSE
//		w_mpsg010b.ole_comm.object.portopen	= FALSE
//	END IF
//
//	this.PostEvent("us_system_exit")
//	run("ipis_down.exe	"  + gs_appname)
//END IF
//
//RETURN 1



end event

event rowfocuschanged;// Tool명, Part 명 셋팅, 공정순서 가져오기

if currentrow < 1 then
	return 0
end if

String ls_orderno, ls_partno, ls_toolname, ls_partname
ls_orderno = This.getitemstring(currentrow,"orderno")
ls_partno = This.getitemstring(currentrow,"partno")

SELECT TOP 1 aa.ToolName, bb.PartName
INTO :ls_toolname, :ls_partname
FROM TORDER aa INNER JOIN TPARTLIST bb
	ON aa.OrderNo = bb.OrderNo
WHERE bb.Orderno = :ls_orderno AND bb.partno = :ls_partno ;

dw_area_info.setitem(1, "area_name", ls_toolname)
dw_area_info.setitem(1, "workcenter_name", ls_partname)

return 0
end event

type dw_area_info from datawindow within w_mpsg080i
integer y = 200
integer width = 4617
integer height = 476
integer taborder = 20
string title = "none"
string dataobject = "d_area_info"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

