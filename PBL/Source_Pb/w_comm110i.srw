$PBExportHeader$w_comm110i.srw
$PBExportComments$승인 현황
forward
global type w_comm110i from w_origin_sheet05
end type
type pb_excel from picturebutton within w_comm110i
end type
type uo_fromdate from uo_today_kdac within w_comm110i
end type
type uo_todate from uo_today_kdac within w_comm110i
end type
type st_1 from statictext within w_comm110i
end type
type st_2 from statictext within w_comm110i
end type
type dw_graph_inputid from datawindow within w_comm110i
end type
type dw_graph_gubun from datawindow within w_comm110i
end type
type dw_retrieve from datawindow within w_comm110i
end type
type gb_1 from groupbox within w_comm110i
end type
end forward

global type w_comm110i from w_origin_sheet05
event ue_keydown pbm_keydown
pb_excel pb_excel
uo_fromdate uo_fromdate
uo_todate uo_todate
st_1 st_1
st_2 st_2
dw_graph_inputid dw_graph_inputid
dw_graph_gubun dw_graph_gubun
dw_retrieve dw_retrieve
gb_1 gb_1
end type
global w_comm110i w_comm110i

type variables
Datawindowchild	cdw_1
String		is_grade = '%' ,	is_pgmid = '%'

end variables

event ue_keydown;if 	key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

on w_comm110i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.st_1=create st_1
this.st_2=create st_2
this.dw_graph_inputid=create dw_graph_inputid
this.dw_graph_gubun=create dw_graph_gubun
this.dw_retrieve=create dw_retrieve
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_fromdate
this.Control[iCurrent+3]=this.uo_todate
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_graph_inputid
this.Control[iCurrent+7]=this.dw_graph_gubun
this.Control[iCurrent+8]=this.dw_retrieve
this.Control[iCurrent+9]=this.gb_1
end on

on w_comm110i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_graph_inputid)
destroy(this.dw_graph_gubun)
destroy(this.dw_retrieve)
destroy(this.gb_1)
end on

event open;call super::open;pb_excel.visible 	=	false
pb_excel.enabled 	= 	false 
 
end event

event ue_retrieve;call super::ue_retrieve;String		ls_fromdate,ls_todate

SetPointer(HourGlass!)
dw_graph_inputid.reset()
dw_graph_gubun.reset()
dw_Retrieve.reset()
ls_fromdate	=	string(date(uo_fromdate.is_uo_date))  
ls_todate		=	string(date(uo_todate.is_uo_date))  
if	dw_graph_inputid.retrieve(ls_fromdate,ls_todate)	+		dw_graph_gubun.retrieve(ls_fromdate,ls_todate)	+	& 
	dw_Retrieve.Retrieve(ls_fromdate,ls_todate) <	1	then
	uo_status.st_message.text	=	'조회할 정보가 없습니다'
	pb_excel.visible 	=	false
	pb_excel.enabled 	= 	false
else
	uo_status.st_message.text 	= 	'조회 완료'
	pb_excel.visible 	=	true
	pb_excel.enabled 	= 	true
end if
	
end event

type uo_status from w_origin_sheet05`uo_status within w_comm110i
integer y = 2464
end type

type pb_excel from picturebutton within w_comm110i
integer x = 4398
integer y = 44
integer width = 174
integer height = 120
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;dw_Retrieve.print()
end event

type uo_fromdate from uo_today_kdac within w_comm110i
event destroy ( )
integer x = 393
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_fromdate.destroy
call uo_today_kdac::destroy
end on

type uo_todate from uo_today_kdac within w_comm110i
event destroy ( )
integer x = 905
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_todate.destroy
call uo_today_kdac::destroy
end on

type st_1 from statictext within w_comm110i
integer x = 64
integer y = 60
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "승인일자 :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_comm110i
integer x = 837
integer y = 64
integer width = 59
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_graph_inputid from datawindow within w_comm110i
boolean visible = false
integer x = 27
integer y = 176
integer width = 4558
integer height = 1108
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_commsum_graph_inputid"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_graph_gubun from datawindow within w_comm110i
boolean visible = false
integer x = 27
integer y = 1320
integer width = 4558
integer height = 1116
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_commsum_graph_gubun"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_retrieve from datawindow within w_comm110i
event dwn_mousemove pbm_dwnmousemove
integer x = 27
integer y = 188
integer width = 4562
integer height = 2252
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_commsum_retrieve"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dwn_mousemove;//CHOOSE CASE dwo.name
//	CASE	'pgm_count','user_count'	, 'usepgm_count'	, 'pbd_count'	, 'pgm_count_group'	, 'user_count_group'	, 'usepgm_count_group',&
//			'pbd_count_group'	, 'pgm_count_total'	, 'user_count_total'	, 'usepgm_count_total'	, 'pbd_count_total'	
//			SetPointer(HourGlass!)
//	CASE ELSE
//			SetPointer(Arrow!)
//END CHOOSE

//CHOOSE CASE dwo.name
//	CASE 'pgm_count'
//	CASE 'user_count'
//	CASE 'usepgm_count'
//	CASE 'pbd_count'
//	CASE 'pgm_count_group'
//	CASE 'user_count_group'
//	CASE 'usepgm_count_group'
//	CASE 'pbd_count_group'.
//	CASE 'pgm_count_total'
//	CASE 'user_count_total'
//	CASE 'usepgm_count_total'
//	CASE 'pbd_count_total'	
//	CASE ELSE
//END CHOOSE


end event

event constructor;this.settransobject(Sqlca) 
end event

type gb_1 from groupbox within w_comm110i
integer x = 27
integer width = 4562
integer height = 168
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
end type

