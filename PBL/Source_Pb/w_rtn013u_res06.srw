$PBExportHeader$w_rtn013u_res06.srw
$PBExportComments$조코드 일괄변경화면
forward
global type w_rtn013u_res06 from window
end type
type cb_3 from commandbutton within w_rtn013u_res06
end type
type dw_1 from datawindow within w_rtn013u_res06
end type
type sle_div from singlelineedit within w_rtn013u_res06
end type
type sle_plant from singlelineedit within w_rtn013u_res06
end type
type pb_find_postdept from picturebutton within w_rtn013u_res06
end type
type st_2 from statictext within w_rtn013u_res06
end type
type sle_postdept from singlelineedit within w_rtn013u_res06
end type
type sle_predept from singlelineedit within w_rtn013u_res06
end type
type st_1 from statictext within w_rtn013u_res06
end type
type p_1 from picture within w_rtn013u_res06
end type
type cb_2 from commandbutton within w_rtn013u_res06
end type
type cb_1 from commandbutton within w_rtn013u_res06
end type
type gb_1 from groupbox within w_rtn013u_res06
end type
type gb_2 from groupbox within w_rtn013u_res06
end type
end forward

global type w_rtn013u_res06 from window
integer x = 498
integer y = 500
integer width = 2994
integer height = 2272
boolean titlebar = true
string title = "라우팅 조코드일괄 변경화면"
windowtype windowtype = response!
long backcolor = 12632256
cb_3 cb_3
dw_1 dw_1
sle_div sle_div
sle_plant sle_plant
pb_find_postdept pb_find_postdept
st_2 st_2
sle_postdept sle_postdept
sle_predept sle_predept
st_1 st_1
p_1 p_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn013u_res06 w_rtn013u_res06

type variables



end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
end prototypes

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
ag_dw_1.setredraw(False)
if ag_n_color 	= 	1	then
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(255,255,0), rgb(255,250,239))'"
else
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(255,255,255))'"
end if
ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
end subroutine

on w_rtn013u_res06.create
this.cb_3=create cb_3
this.dw_1=create dw_1
this.sle_div=create sle_div
this.sle_plant=create sle_plant
this.pb_find_postdept=create pb_find_postdept
this.st_2=create st_2
this.sle_postdept=create sle_postdept
this.sle_predept=create sle_predept
this.st_1=create st_1
this.p_1=create p_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_3,&
this.dw_1,&
this.sle_div,&
this.sle_plant,&
this.pb_find_postdept,&
this.st_2,&
this.sle_postdept,&
this.sle_predept,&
this.st_1,&
this.p_1,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.gb_2}
end on

on w_rtn013u_res06.destroy
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.sle_div)
destroy(this.sle_plant)
destroy(this.pb_find_postdept)
destroy(this.st_2)
destroy(this.sle_postdept)
destroy(this.sle_predept)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;str_parms lstr_parm

setpointer(hourglass!)

lstr_parm = message.PowerObjectParm

sle_plant.text = lstr_parm.string_arg[2]
sle_div.text = lstr_parm.string_arg[3]




end event

type cb_3 from commandbutton within w_rtn013u_res06
integer x = 741
integer y = 308
integer width = 517
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;string l_s_rcline_pre, l_s_rcline_post, l_s_rcplant, l_s_rcdvsn

dw_1.settransobject(sqlca)
l_s_rcline_pre = sle_predept.text
l_s_rcline_post = sle_postdept.text
l_s_rcplant = sle_plant.text
l_s_rcdvsn = sle_div.text

dw_1.retrieve(l_s_rcplant, l_s_rcdvsn, l_s_rcline_pre)

end event

type dw_1 from datawindow within w_rtn013u_res06
integer x = 37
integer y = 460
integer width = 2889
integer height = 1536
integer taborder = 50
string title = "none"
string dataobject = "d_rtn013u_res06_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_div from singlelineedit within w_rtn013u_res06
integer x = 274
integer y = 156
integer width = 128
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_plant from singlelineedit within w_rtn013u_res06
integer x = 119
integer y = 156
integer width = 128
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type pb_find_postdept from picturebutton within w_rtn013u_res06
integer x = 2597
integer y = 232
integer width = 238
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = right!
end type

event clicked;string l_s_parm
openwithparm(w_find_001 , l_s_parm)
l_s_parm = message.stringparm
if f_spacechk(l_s_parm) <> -1 then
	sle_postdept.text  = mid(l_s_parm,1,5)
end if
end event

type st_2 from statictext within w_rtn013u_res06
integer x = 1714
integer y = 240
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조코드:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_postdept from singlelineedit within w_rtn013u_res06
integer x = 2098
integer y = 232
integer width = 457
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type sle_predept from singlelineedit within w_rtn013u_res06
integer x = 768
integer y = 156
integer width = 457
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rtn013u_res06
integer x = 448
integer y = 164
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조코드:"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_1 from picture within w_rtn013u_res06
integer x = 1390
integer y = 108
integer width = 233
integer height = 92
string picturename = "C:\kdac\bmp\focus.GIF"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_rtn013u_res06
integer x = 1522
integer y = 2036
integer width = 311
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫 기"
boolean cancel = true
end type

event clicked;closewithreturn(parent, 'N')



end event

type cb_1 from commandbutton within w_rtn013u_res06
integer x = 1179
integer y = 2040
integer width = 311
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
boolean default = true
end type

event clicked;string l_s_rcline_pre, l_s_rcline_post, l_s_flag, l_s_rcepno, l_s_rcupdt, l_s_rcplant, l_s_rcdvsn, l_s_rcitno
string l_s_chkitno
integer l_n_sqlcount, l_n_cnt, l_n_rowcnt
string ls_message, ls_chtime

setpointer(hourglass!)

l_s_rcline_pre = sle_predept.text
l_s_rcline_post = sle_postdept.text
l_s_rcplant = sle_plant.text
l_s_rcdvsn = sle_div.text
l_s_rcepno  = g_s_empno
l_s_rcupdt  = g_s_date

ls_chtime = f_get_systemdate(sqlca)

//select count(*) into :l_n_sqlcount from pbcommon.dac001
//where dcode = :l_s_rcline_pre and duse = ' ';
//
//if l_n_sqlcount > 0 then
//	Messagebox("확인", "변경전 조코드는 현재 사용중인 조코드입니다.")
//	return 0
//end if

l_n_rowcnt = dw_1.rowcount()

SQLCA.AUTOCOMMIT = FALSE

for l_n_cnt = 1 to l_n_rowcnt
	l_s_chkitno = dw_1.getitemstring(l_n_cnt,"chk_itno")
	
	if l_s_chkitno = 'N' then
		continue
	end if
	
	l_s_rcitno = dw_1.getitemstring(l_n_cnt,"rcitno")
	select count(*) into :l_n_sqlcount from pbrtn.rtn013
	where rccmcd = '01' and rcplant = :l_s_rcplant and rcdvsn = :l_s_rcdvsn and 
		rcitno = :l_s_rcitno and rcline3 = :l_s_rcline_pre and rcdlchk = 'N'
	using sqlca;
	
	if l_n_sqlcount > 0 then
		ls_message = "해당조코드로 결재진행중인 라우팅정보가 있어서 수정할수 없습니다."
		goto Rollback_
	else
		l_s_flag = 'R'
		
		update pbrtn.rtn013
		set rcline3 = :l_s_rcline_post ,
			 rcepno = :l_s_rcepno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = :l_s_flag,
			 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
			 rcplemp = '', rcplchk = 'N', rcpltime = '',
			 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
		where rccmcd = '01' and rcplant = :l_s_rcplant and rcdvsn = :l_s_rcdvsn and 
				rcitno = :l_s_rcitno and rcline3 = :l_s_rcline_pre 
		using sqlca;
				
		if sqlca.sqlnrows < 1 then
			ls_message = "공정별 세부내역정보 수정할때 오류가 발생했습니다."
			goto Rollback_
		end if
	end if
next

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
Messagebox("확인","정상적으로 변경완료하였습니다.")
						 
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
Messagebox("확인",ls_message)

return -1

end event

type gb_1 from groupbox within w_rtn013u_res06
integer x = 37
integer y = 60
integer width = 1285
integer height = 364
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "변경前"
end type

type gb_2 from groupbox within w_rtn013u_res06
integer x = 1646
integer y = 60
integer width = 1285
integer height = 364
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "변경後"
end type

