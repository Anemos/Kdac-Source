$PBExportHeader$w_tmm420i.srw
$PBExportComments$시험분석작업현황
forward
global type w_tmm420i from w_ipis_sheet01
end type
type dw_tmm420i_01 from u_vi_std_datawindow within w_tmm420i
end type
type dw_tmm420i_02 from datawindow within w_tmm420i
end type
type dw_report from datawindow within w_tmm420i
end type
type uo_yyyymm from u_tmm_date_scroll_month within w_tmm420i
end type
type st_1 from statictext within w_tmm420i
end type
type pb_down1 from picturebutton within w_tmm420i
end type
type st_2 from statictext within w_tmm420i
end type
type pb_down2 from picturebutton within w_tmm420i
end type
type gb_1 from groupbox within w_tmm420i
end type
end forward

global type w_tmm420i from w_ipis_sheet01
dw_tmm420i_01 dw_tmm420i_01
dw_tmm420i_02 dw_tmm420i_02
dw_report dw_report
uo_yyyymm uo_yyyymm
st_1 st_1
pb_down1 pb_down1
st_2 st_2
pb_down2 pb_down2
gb_1 gb_1
end type
global w_tmm420i w_tmm420i

on w_tmm420i.create
int iCurrent
call super::create
this.dw_tmm420i_01=create dw_tmm420i_01
this.dw_tmm420i_02=create dw_tmm420i_02
this.dw_report=create dw_report
this.uo_yyyymm=create uo_yyyymm
this.st_1=create st_1
this.pb_down1=create pb_down1
this.st_2=create st_2
this.pb_down2=create pb_down2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tmm420i_01
this.Control[iCurrent+2]=this.dw_tmm420i_02
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.uo_yyyymm
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.pb_down1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.pb_down2
this.Control[iCurrent+9]=this.gb_1
end on

on w_tmm420i.destroy
call super::destroy
destroy(this.dw_tmm420i_01)
destroy(this.dw_tmm420i_02)
destroy(this.dw_report)
destroy(this.uo_yyyymm)
destroy(this.st_1)
destroy(this.pb_down1)
destroy(this.st_2)
destroy(this.pb_down2)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_tmm420i_01.Width = newwidth 	- ( ls_gap * 4 )
dw_tmm420i_01.Height= ( newheight * 1 / 4 ) - dw_tmm420i_01.y

dw_tmm420i_02.x = dw_tmm420i_01.x
dw_tmm420i_02.y = dw_tmm420i_01.y + dw_tmm420i_01.Height + ls_split
dw_tmm420i_02.Width = dw_tmm420i_01.Width
dw_tmm420i_02.Height = newheight - ( dw_tmm420i_01.y + dw_tmm420i_01.Height + ls_split + ls_status)


end event

event ue_postopen;call super::ue_postopen;
dw_tmm420i_01.SetTransObject(sqlca)
dw_tmm420i_02.SetTransObject(sqlca)
end event

event ue_retrieve;call super::ue_retrieve;string ls_fromdt, ls_yyyymm, ls_startdate, ls_enddate

dw_tmm420i_01.reset()
dw_tmm420i_01.dataobject = "d_tmm420i_01"
dw_tmm420i_01.settransobject(sqlca)
dw_tmm420i_02.reset()
dw_tmm420i_02.dataobject = "d_tmm420i_02"
dw_tmm420i_02.settransobject(sqlca)

//ls_fromdt = string(date(uo_yyyymm.is_uo_month + '.01'),'YYYYMMDD')
ls_yyyymm = mid(ls_fromdt,1,6)

ls_startdate = ls_yyyymm + '01'
ls_enddate = f_relativedate(f_relative_month(ls_startdate,1),-1)

dw_tmm420i_01.retrieve(ls_startdate, ls_enddate)

dw_tmm420i_02.retrieve(ls_startdate, ls_enddate)

uo_status.st_message.text = "조회되었습니다."

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

type uo_status from w_ipis_sheet01`uo_status within w_tmm420i
end type

type dw_tmm420i_01 from u_vi_std_datawindow within w_tmm420i
integer x = 18
integer y = 196
integer width = 3515
integer height = 704
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_tmm420i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type dw_tmm420i_02 from datawindow within w_tmm420i
event ue_key pbm_dwnkey
integer x = 18
integer y = 944
integer width = 3525
integer height = 860
boolean bringtotop = true
string dataobject = "d_tmm420i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;String ls_orderno, ls_tmgubun

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

event error;// after finished dw Project, Please unComment.
//action = ExceptionIgnore! 
end event

type dw_report from datawindow within w_tmm420i
boolean visible = false
integer x = 2793
integer y = 156
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm120u_03p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_yyyymm from u_tmm_date_scroll_month within w_tmm420i
integer x = 69
integer y = 64
integer taborder = 11
boolean bringtotop = true
end type

on uo_yyyymm.destroy
call u_tmm_date_scroll_month::destroy
end on

event constructor;call super::constructor;string ls_postdate

ls_postdate = string(f_relativedate( mid(g_s_date,1,6) + '01', -1),'@@@@-@@-@@')
This.uf_setdata( date( ls_postdate ) )
end event

type st_1 from statictext within w_tmm420i
integer x = 887
integer y = 68
integer width = 293
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "제품별:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_down1 from picturebutton within w_tmm420i
integer x = 1179
integer y = 36
integer width = 155
integer height = 132
integer taborder = 11
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
end type

event clicked;f_save_to_excel(dw_tmm420i_01)
end event

type st_2 from statictext within w_tmm420i
integer x = 1467
integer y = 68
integer width = 293
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "장비별:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_down2 from picturebutton within w_tmm420i
integer x = 1774
integer y = 36
integer width = 155
integer height = 132
integer taborder = 21
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
end type

event clicked;f_save_to_excel(dw_tmm420i_02)
end event

type gb_1 from groupbox within w_tmm420i
integer x = 18
integer width = 2062
integer height = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

