$PBExportHeader$w_rtn013u_res05.srw
$PBExportComments$품번전체라인 Copy 기능[결재]
forward
global type w_rtn013u_res05 from window
end type
type dw_1 from datawindow within w_rtn013u_res05
end type
type sle_line from singlelineedit within w_rtn013u_res05
end type
type st_2 from statictext within w_rtn013u_res05
end type
type st_1 from statictext within w_rtn013u_res05
end type
type p_1 from picture within w_rtn013u_res05
end type
type cb_2 from commandbutton within w_rtn013u_res05
end type
type cb_1 from commandbutton within w_rtn013u_res05
end type
type sle_1 from singlelineedit within w_rtn013u_res05
end type
type gb_1 from groupbox within w_rtn013u_res05
end type
type gb_2 from groupbox within w_rtn013u_res05
end type
end forward

global type w_rtn013u_res05 from window
integer x = 498
integer y = 500
integer width = 2976
integer height = 708
boolean titlebar = true
string title = "라우팅 품번복사 화면"
windowtype windowtype = response!
long backcolor = 12632256
dw_1 dw_1
sle_line sle_line
st_2 st_2
st_1 st_1
p_1 p_1
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn013u_res05 w_rtn013u_res05

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

on w_rtn013u_res05.create
this.dw_1=create dw_1
this.sle_line=create sle_line
this.st_2=create st_2
this.st_1=create st_1
this.p_1=create p_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_1,&
this.sle_line,&
this.st_2,&
this.st_1,&
this.p_1,&
this.cb_2,&
this.cb_1,&
this.sle_1,&
this.gb_1,&
this.gb_2}
end on

on w_rtn013u_res05.destroy
destroy(this.dw_1)
destroy(this.sle_line)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;str_parms lstr_parm

setpointer(hourglass!)

lstr_parm = message.PowerObjectParm

sle_1.text = lstr_parm.string_arg[4]

dw_1.insertrow(0)
dw_1.setitem( 1, "rccmcd", lstr_parm.string_arg[1])
dw_1.setitem( 1, "rcplant", lstr_parm.string_arg[2])
dw_1.setitem( 1, "rcdvsn", lstr_parm.string_arg[3])
dw_1.setitem( 1, "rcline1", "전체")
dw_1.setcolumn("rcitno")
dw_1.setfocus()




end event

type dw_1 from datawindow within w_rtn013u_res05
integer x = 1669
integer y = 116
integer width = 1239
integer height = 292
integer taborder = 10
string title = "none"
string dataobject = "d_rtn013u_res05_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_line from singlelineedit within w_rtn013u_res05
integer x = 402
integer y = 280
integer width = 837
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "전체"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_rtn013u_res05
integer x = 64
integer y = 300
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
string text = "대체라인:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rtn013u_res05
integer x = 64
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
string text = "품번:"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_1 from picture within w_rtn013u_res05
integer x = 1390
integer y = 108
integer width = 233
integer height = 92
string picturename = "C:\kdac\bmp\focus.GIF"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_rtn013u_res05
integer x = 1504
integer y = 484
integer width = 311
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취  소"
boolean cancel = true
end type

event clicked;closewithreturn(parent, 'N')



end event

type cb_1 from commandbutton within w_rtn013u_res05
integer x = 1170
integer y = 484
integer width = 311
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
boolean default = true
end type

event clicked;string l_s_pcitn,l_s_date, ls_chtime, ls_message, l_s_cmcd, l_s_plant, l_s_div, l_s_pitno
long   l_n_sqlcount

setpointer(hourglass!)
dw_1.accepttext()

l_s_pitno = sle_1.text
l_s_pcitn = dw_1.getitemstring(1,"rcitno")
l_s_Date  = f_relativedate(g_s_date,1)

if f_spacechk(l_s_pcitn) = -1 then
   messagebox("확인","Copy後 품번을 입력하세요.")
   return 0
end if

l_s_cmcd = dw_1.getitemstring(1,"rccmcd")
l_s_plant = dw_1.getitemstring(1,"rcplant")
l_s_div = dw_1.getitemstring(1,"rcdvsn")

select count(*) into :l_n_sqlcount from pbrtn.rtn011
	  where racmcd  = :l_s_cmcd  and raplant = :l_s_plant and radvsn = :l_s_div and raitno1 = :l_s_pcitn
using sqlca;
if l_n_sqlcount > 0 then
	messagebox("확인","품번 " + l_s_pcitn + " 은 유사품번으로 이미 입력되어있습니다.")
   return 0
end if

select count(*) into :l_n_sqlcount from pbrtn.rtn013
	  where rccmcd  = :l_s_cmcd  and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcitno = :l_s_pcitn
using sqlca;
if l_n_sqlcount > 0 then
	messagebox("확인","품번 " + l_s_pcitn + " 의 Routing 정보가 이미 입력되어있습니다.")
   return 0
end if

select count(*) into:l_n_sqlcount from pbpdm.bom001
	where pcmcd = :l_s_cmcd and plant = :l_s_plant and pdvsn = :l_s_div and ppitn = :l_s_pcitn and 
			( ( PEDTE = '' ) OR ( PEDTM <= :l_s_date AND PEDTE >= :l_s_date) ) 
using sqlca;
if l_n_sqlcount < 1 then
	messagebox("확인","품번 " + l_s_pcitn +  " 의 BOM 이 구성되어 있지 않습니다.")
   return 0
end if

ls_chtime = f_get_systemdate(sqlca)
SQLCA.AUTOCOMMIT = FALSE

insert into pbrtn.rtn013
	( rccmcd,rcplant,rcdvsn,rcitno,rcline1,rcline2,rcopno,rcchtime,rcedfm,
	rcopnm,rcopsq,rcline3,rcgrde,rcmcyn,rcbmtm,rcbltm,rcbstm,
	rcnvcd,rcnvmc,rcnvlb,rclbcnt,rcflag,rcepno,rcipad,rcupdt,rcsydt,
	rcinemp, rcinchk, rcintime, rcplemp, rcplchk, rcpltime,
	rcdlemp, rcdlchk, rcdltime, rcpower ) 
select rccmcd,rcplant,rcdvsn,:l_s_pcitn,rcline1,rcline2,rcopno,:ls_chtime,'',
	rcopnm,rcopsq,rcline3,rcgrde,rcmcyn,rcbmtm,rcbltm,rcbstm,
	rcnvcd,rcnvmc,rcnvlb,rclbcnt,'A',:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date,
	:g_s_empno, 'N', '', '', 'N','',
		'', 'N','', rcpower
from pbrtn.rtn013 
where  rccmcd  = :l_s_cmcd  and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcitno = :l_s_pitno
using sqlca ;

if sqlca.sqlcode <> 0 then
	ls_message = "RTN013 입력 에러. 정보시스템으로 연락바랍니다."
   goto Rollback_
end if

insert into pbrtn.rtn014 (rdcmcd,rdplant,rddvsn,rditno,rdline1,rdline2,rdopno,rdnvmo,rdmcno,rdterm,
	rdmctm,rdlbtm,rdremk,rdflag,rdepno,rdedfm,rdipad,rdupdt,rdsydt)
select rdcmcd,rdplant,rddvsn,:l_s_pcitn,rdline1,rdline2,rdopno,rdnvmo,rdmcno,rdterm,
	rdmctm,rdlbtm,rdremk,'A',:g_s_empno,'',:g_s_ipaddr,:g_s_date,:g_s_date 
from pbrtn.rtn014 
where  rdcmcd  = :l_s_cmcd  and rdplant = :l_s_plant and rddvsn = :l_s_div and rditno = :l_s_pitno
using sqlca ;

if sqlca.sqlcode <> 0 then
	ls_message = "RTN014 입력 에러. 정보시스템으로 연락바랍니다."
   goto Rollback_
end if

insert into pbrtn.rtn017 
select rgcmcd,rgplant,rgdvsn,:l_s_pcitn,rgline1,rgline2,rgopno,:l_s_date,rgmcno,
	'A',:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date 
from pbrtn.rtn017 
where  rgcmcd  = :l_s_cmcd  and rgplant = :l_s_plant and rgdvsn = :l_s_div and rgitno = :l_s_pitno
using sqlca ;
if sqlca.sqlcode <> 0 then
	ls_message = "RTN017 입력 에러. 정보시스템으로 연락바랍니다."
   goto Rollback_
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

closewithreturn(parent, 'Y' + l_s_pcitn)
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
messagebox("확인", ls_message)

return -1

end event

type sle_1 from singlelineedit within w_rtn013u_res05
integer x = 402
integer y = 148
integer width = 837
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rtn013u_res05
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
string text = "Copy前"
end type

type gb_2 from groupbox within w_rtn013u_res05
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
string text = "Copy後"
end type

