$PBExportHeader$w_pisg090i.srw
$PBExportComments$현장관리_LOT 분할 조회
forward
global type w_pisg090i from window
end type
type st_page_dn from statictext within w_pisg090i
end type
type st_row_dn from statictext within w_pisg090i
end type
type st_row_up from statictext within w_pisg090i
end type
type st_page_up from statictext within w_pisg090i
end type
type st_base_date from statictext within w_pisg090i
end type
type p_5 from picture within w_pisg090i
end type
type p_4 from picture within w_pisg090i
end type
type p_3 from picture within w_pisg090i
end type
type p_2 from picture within w_pisg090i
end type
type p_1 from picture within w_pisg090i
end type
type pb_row_up from picturebutton within w_pisg090i
end type
type uo_select_date from uo_today within w_pisg090i
end type
type em_search_date from editmask within w_pisg090i
end type
type dw_pisg090i_01 from datawindow within w_pisg090i
end type
type pb_page_up from picturebutton within w_pisg090i
end type
type pb_page_dn from picturebutton within w_pisg090i
end type
type pb_row_dn from picturebutton within w_pisg090i
end type
type st_5 from statictext within w_pisg090i
end type
type dw_title from datawindow within w_pisg090i
end type
type dw_area_info from datawindow within w_pisg090i
end type
end forward

global type w_pisg090i from window
integer width = 3625
integer height = 1950
boolean border = false
windowtype windowtype = child!
long backcolor = 32241141
event ue_info_renew ( )
st_page_dn st_page_dn
st_row_dn st_row_dn
st_row_up st_row_up
st_page_up st_page_up
st_base_date st_base_date
p_5 p_5
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
pb_row_up pb_row_up
uo_select_date uo_select_date
em_search_date em_search_date
dw_pisg090i_01 dw_pisg090i_01
pb_page_up pb_page_up
pb_page_dn pb_page_dn
pb_row_dn pb_row_dn
st_5 st_5
dw_title dw_title
dw_area_info dw_area_info
end type
global w_pisg090i w_pisg090i

event ue_info_renew();STRING	ls_applydate_close		// 마감을 고려한 DATE
DATETIME	ld_server_datetime		// SERVER DATETIME

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ld_server_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code,ld_server_datetime)

em_search_date.text	= String(today(), "yyyy년 mm월 dd일")

/*######################################################################
#####		정보갱신																	 #####
######################################################################*/

// 정보 갱신
dw_pisg090i_01.settransobject(sqlca)
dw_pisg090i_01.Retrieve(ls_applydate_close,gs_area_code, gs_division_code)

// 하일라이트
dw_pisg090i_01.SelectRow(0, FALSE)
dw_pisg090i_01.SelectRow(1, TRUE)





end event

on w_pisg090i.create
this.st_page_dn=create st_page_dn
this.st_row_dn=create st_row_dn
this.st_row_up=create st_row_up
this.st_page_up=create st_page_up
this.st_base_date=create st_base_date
this.p_5=create p_5
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.pb_row_up=create pb_row_up
this.uo_select_date=create uo_select_date
this.em_search_date=create em_search_date
this.dw_pisg090i_01=create dw_pisg090i_01
this.pb_page_up=create pb_page_up
this.pb_page_dn=create pb_page_dn
this.pb_row_dn=create pb_row_dn
this.st_5=create st_5
this.dw_title=create dw_title
this.dw_area_info=create dw_area_info
this.Control[]={this.st_page_dn,&
this.st_row_dn,&
this.st_row_up,&
this.st_page_up,&
this.st_base_date,&
this.p_5,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.pb_row_up,&
this.uo_select_date,&
this.em_search_date,&
this.dw_pisg090i_01,&
this.pb_page_up,&
this.pb_page_dn,&
this.pb_row_dn,&
this.st_5,&
this.dw_title,&
this.dw_area_info}
end on

on w_pisg090i.destroy
destroy(this.st_page_dn)
destroy(this.st_row_dn)
destroy(this.st_row_up)
destroy(this.st_page_up)
destroy(this.st_base_date)
destroy(this.p_5)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.pb_row_up)
destroy(this.uo_select_date)
destroy(this.em_search_date)
destroy(this.dw_pisg090i_01)
destroy(this.pb_page_up)
destroy(this.pb_page_dn)
destroy(this.pb_row_dn)
destroy(this.st_5)
destroy(this.dw_title)
destroy(this.dw_area_info)
end on

event open;/*######################################################################
#####		타이틀명 셋팅															 #####
######################################################################*/

dw_title.setitem(1, "title_name", "LOT분할")

/*######################################################################
#####		지역, 공장 명 셋팅													 #####
######################################################################*/

dw_area_info.setitem(1, "area_name", gs_area_name)
dw_area_info.setitem(1, "workcenter_name", gs_division_name)

/*######################################################################
#####		정보 갱신																 #####
######################################################################*/

THIS.PostEvent("ue_info_renew")

// 시간 갱신
//timer(60)
end event

event timer;/*######################################################################
#####		8:00에 정보를 갱신한다.												 #####
######################################################################*/

IF gi_page_index = 4 THEN
	// 실적등록의 LINE선택 이벤트
	THIS.TriggerEvent("ue_info_renew")
END IF

end event

type st_page_dn from statictext within w_pisg090i
integer x = 3246
integer y = 1888
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

type st_row_dn from statictext within w_pisg090i
integer x = 3246
integer y = 1584
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

type st_row_up from statictext within w_pisg090i
integer x = 3246
integer y = 1012
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

type st_page_up from statictext within w_pisg090i
integer x = 3246
integer y = 712
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

type st_base_date from statictext within w_pisg090i
integer x = 1317
integer y = 212
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

type p_5 from picture within w_pisg090i
integer x = 1207
integer y = 236
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type p_4 from picture within w_pisg090i
integer x = 3328
integer y = 1740
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pagedown.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_pisg090i
integer x = 3328
integer y = 1436
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_pisg090i
integer x = 3328
integer y = 864
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_pisg090i
integer x = 3328
integer y = 564
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pageup.gif"
boolean focusrectangle = false
end type

type pb_row_up from picturebutton within w_pisg090i
integer x = 3205
integer y = 808
integer width = 384
integer height = 300
integer taborder = 20
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
dw_pisg090i_01.ScrollPriorRow()
dw_pisg090i_01.SetRow(dw_pisg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg090i_01.SelectRow(0, FALSE)
dw_pisg090i_01.SelectRow(dw_pisg090i_01.getrow(), TRUE)

end event

type uo_select_date from uo_today within w_pisg090i
integer x = 1646
integer y = 204
integer taborder = 20
end type

on uo_select_date.destroy
call uo_today::destroy
end on

type em_search_date from editmask within w_pisg090i
event ue_keydown pbm_keydown
event ue_date_change ( )
integer x = 1929
integer y = 212
integer width = 1147
integer height = 128
integer taborder = 30
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

event ue_keydown;STRING	ls_select_date

IF KEY = KeyEnter! THEN

	ls_select_date = left(this.text,4) + '.'	+ mid(this.text,8,2) + '.' + &
							mid(this.text,13,2)

	dw_pisg090i_01.settransobject(sqlca)
	dw_pisg090i_01.Retrieve(ls_select_date, gs_area_code, gs_division_code)
	
END IF
end event

event ue_date_change;STRING	ls_select_date

INTEGER	li_total_kb_num
INTEGER	li_finish_kb_num

/*######################################################################
#####		기준일																	 #####
######################################################################*/

this.text = string(date(uo_select_date.sle_date.text))

ls_select_date = 	STRING(uo_select_date.sle_date.text)

/*######################################################################
#####		정보갱신																	 #####
######################################################################*/

// 정보 갱신
dw_pisg090i_01.settransobject(sqlca)
dw_pisg090i_01.Retrieve(ls_select_date,gs_area_code, gs_division_code)

// 하일라이트
dw_pisg090i_01.SelectRow(0, FALSE)
dw_pisg090i_01.SelectRow(1, TRUE)

end event

type dw_pisg090i_01 from datawindow within w_pisg090i
event us_system_exit ( )
integer x = 18
integer y = 500
integer width = 3173
integer height = 1488
string dataobject = "d_pisg090i_01"
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

type pb_page_up from picturebutton within w_pisg090i
integer x = 3205
integer y = 508
integer width = 384
integer height = 300
integer taborder = 10
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
dw_pisg090i_01.ScrollPriorPage ()
dw_pisg090i_01.SetRow(dw_pisg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg090i_01.SelectRow(0, FALSE)
dw_pisg090i_01.SelectRow(dw_pisg090i_01.getrow(), TRUE)

end event

type pb_page_dn from picturebutton within w_pisg090i
integer x = 3205
integer y = 1684
integer width = 384
integer height = 300
integer taborder = 40
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
dw_pisg090i_01.ScrollNextPage()
dw_pisg090i_01.SetRow(dw_pisg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg090i_01.SelectRow(0, FALSE)
dw_pisg090i_01.SelectRow(dw_pisg090i_01.getrow(), TRUE)

end event

type pb_row_dn from picturebutton within w_pisg090i
integer x = 3205
integer y = 1380
integer width = 384
integer height = 300
integer taborder = 30
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
dw_pisg090i_01.ScrollNextRow()
dw_pisg090i_01.SetRow(dw_pisg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg090i_01.SelectRow(0, FALSE)
dw_pisg090i_01.SelectRow(dw_pisg090i_01.getrow(), TRUE)

end event

type st_5 from statictext within w_pisg090i
integer x = 3195
integer y = 500
integer width = 402
integer height = 1488
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

type dw_title from datawindow within w_pisg090i
integer width = 3625
integer height = 200
integer taborder = 10
string dataobject = "d_title_bar"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type dw_area_info from datawindow within w_pisg090i
integer y = 200
integer width = 3625
integer height = 248
integer taborder = 20
string title = "none"
string dataobject = "d_area_info"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

