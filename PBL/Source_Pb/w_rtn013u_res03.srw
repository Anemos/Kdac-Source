$PBExportHeader$w_rtn013u_res03.srw
$PBExportComments$장비번호 등록[결재]
forward
global type w_rtn013u_res03 from window
end type
type cb_del from commandbutton within w_rtn013u_res03
end type
type p_1 from picture within w_rtn013u_res03
end type
type cb_1 from commandbutton within w_rtn013u_res03
end type
type cb_add from commandbutton within w_rtn013u_res03
end type
type dw_2 from datawindow within w_rtn013u_res03
end type
type dw_1 from datawindow within w_rtn013u_res03
end type
type st_1 from statictext within w_rtn013u_res03
end type
type sle_dvsn from singlelineedit within w_rtn013u_res03
end type
type st_2 from statictext within w_rtn013u_res03
end type
type sle_itno from singlelineedit within w_rtn013u_res03
end type
type st_3 from statictext within w_rtn013u_res03
end type
type sle_line from singlelineedit within w_rtn013u_res03
end type
type st_4 from statictext within w_rtn013u_res03
end type
type sle_opno from singlelineedit within w_rtn013u_res03
end type
type gb_1 from groupbox within w_rtn013u_res03
end type
end forward

global type w_rtn013u_res03 from window
integer x = 901
integer y = 800
integer width = 3113
integer height = 1496
boolean titlebar = true
string title = "장비번호등록"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_del cb_del
p_1 p_1
cb_1 cb_1
cb_add cb_add
dw_2 dw_2
dw_1 dw_1
st_1 st_1
sle_dvsn sle_dvsn
st_2 st_2
sle_itno sle_itno
st_3 st_3
sle_line sle_line
st_4 st_4
sle_opno sle_opno
gb_1 gb_1
end type
global w_rtn013u_res03 w_rtn013u_res03

type variables
string i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno,i_s_wkct
end variables

on w_rtn013u_res03.create
this.cb_del=create cb_del
this.p_1=create p_1
this.cb_1=create cb_1
this.cb_add=create cb_add
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_1=create st_1
this.sle_dvsn=create sle_dvsn
this.st_2=create st_2
this.sle_itno=create sle_itno
this.st_3=create st_3
this.sle_line=create sle_line
this.st_4=create st_4
this.sle_opno=create sle_opno
this.gb_1=create gb_1
this.Control[]={this.cb_del,&
this.p_1,&
this.cb_1,&
this.cb_add,&
this.dw_2,&
this.dw_1,&
this.st_1,&
this.sle_dvsn,&
this.st_2,&
this.sle_itno,&
this.st_3,&
this.sle_line,&
this.st_4,&
this.sle_opno,&
this.gb_1}
end on

on w_rtn013u_res03.destroy
destroy(this.cb_del)
destroy(this.p_1)
destroy(this.cb_1)
destroy(this.cb_add)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.sle_dvsn)
destroy(this.st_2)
destroy(this.sle_itno)
destroy(this.st_3)
destroy(this.sle_line)
destroy(this.st_4)
destroy(this.sle_opno)
destroy(this.gb_1)
end on

event open;str_parms lstr_parm

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

lstr_parm  = message.PowerObjectParm
i_s_plant = lstr_parm.string_arg[1]
i_s_dvsn  = lstr_parm.string_arg[2]
i_s_itno  = lstr_parm.string_arg[3]
i_s_line1 = lstr_parm.string_arg[4]
i_s_line2 = lstr_parm.string_arg[5]
i_s_opno  = lstr_parm.string_arg[6]
i_s_wkct  = lstr_parm.string_arg[7]

//sle_dvsn.text = trim(f_get_coitname("01","ACC002",i_s_plant)) + '/' + f_get_coitname("01","DAC030",i_s_dvsn)
sle_dvsn.text = i_s_plant + '/' + i_s_dvsn
sle_itno.text = i_s_itno
sle_line.text = i_s_line1 + '-' + i_s_line2
sle_opno.text = i_s_opno

dw_1.retrieve(i_s_plant,i_s_dvsn,i_s_wkct)
dw_2.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno)
w_rtn013u_res03.dw_2.sharedataoff()


end event

event close;this.hide()  
end event

type cb_del from commandbutton within w_rtn013u_res03
integer x = 1577
integer y = 832
integer width = 334
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "장비삭제"
end type

event clicked;long ll_selrow, ll_chkcount
string ls_rgmcno, ls_message, ls_chtime

ll_selrow = dw_2.getselectedrow(0)
if ll_selrow < 1 then
	messagebox("확인", "오른쪽화면에서 삭제할 장비를 선택해 주십시요")
	return -1
end if

ls_rgmcno = dw_2.getitemstring(ll_selrow,"rgmcno")
ls_chtime = f_get_systemdate(sqlca)
SQLCA.AUTOCOMMIT = FALSE

DELETE FROM PBRTN.RTN017  
WHERE RGCMCD = :g_s_company AND RGPLANT = :i_s_plant AND RGDVSN = :i_s_dvsn AND
	RGITNO = :i_s_itno AND RGLINE1 = :i_s_line1 AND RGLINE2 = :i_s_line2 AND
	RGOPNO = :i_s_opno AND RGMCNO = :ls_rgmcno
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "장비를 삭제하는중에 오류가 발생했습니다."
	goto Rollback_
end if

SELECT COUNT(*) INTO :ll_chkcount
FROM PBRTN.RTN017
WHERE RGCMCD = :g_s_company AND RGPLANT = :i_s_plant AND RGDVSN = :i_s_dvsn AND
	RGITNO = :i_s_itno AND RGLINE1 = :i_s_line1 AND RGLINE2 = :i_s_line2 AND
	RGOPNO = :i_s_opno
using sqlca;

if ll_chkcount < 1 then
	update pbrtn.rtn013
		set rcmcyn = 'N', 
			 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'R',
			 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
			 rcplemp = '', rcplchk = 'N', rcpltime = '',
			 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
	where rccmcd = :g_s_company and rcplant = :i_s_plant and rcdvsn = :i_s_dvsn and 
				rcitno = :i_s_itno and rcline1 = :i_s_line1 and rcline2 = :i_s_line2 and 
				rcopno = :i_s_opno 
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "장비유무 설정시에 오류가 발행했습니다."
		goto Rollback_
	end if
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
messagebox("확인", "정상적으로 처리되었습니다.")
dw_2.reset()
dw_2.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno)
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE	
messagebox("확인", ls_message)

return -1
end event

type p_1 from picture within w_rtn013u_res03
integer x = 1646
integer y = 596
integer width = 174
integer height = 92
boolean originalsize = true
string picturename = "C:\kdac\bmp\focus.GIF"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rtn013u_res03
integer x = 2697
integer y = 1244
integer width = 320
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종  료"
end type

event clicked;close(w_rtn013u_res03)
end event

type cb_add from commandbutton within w_rtn013u_res03
integer x = 1577
integer y = 452
integer width = 334
integer height = 116
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "장비추가"
end type

event clicked;integer l_n_dw_count, i, l_n_sqlcount
string  l_s_itno, l_s_itno1, l_s_rgedfm, l_s_rgmcno, l_s_parm, ls_message, ls_chtime

l_n_dw_count = dw_1.rowcount()
ls_chtime = f_get_systemdate(sqlca)

SQLCA.AUTOCOMMIT = FALSE

for i = 1 to l_n_dw_count 
	if dw_1.object.ip_chk[i] <> 'Y' then
		continue
	end if
	l_s_rgmcno = dw_1.object.mchno[i]
	select count(*) into :l_n_sqlcount from pbrtn.rtn017
	where rgplant = :i_s_plant and rgdvsn = :i_s_dvsn and rgitno = :i_s_itno and rgline1 = :i_s_line1 and 
		rgline2 = :i_s_line2 and rgopno  = :i_s_opno  and rgmcno = :l_s_rgmcno 
	using sqlca;
	if l_n_sqlcount > 0 then
		continue
	end if
	
	SELECT RCEDFM INTO :l_s_rgedfm
	FROM PBRTN.RTN013
	WHERE RCCMCD = :g_s_company AND RCPLANT = :i_s_plant AND RCDVSN = :i_s_dvsn AND
		RCITNO = :i_s_itno AND RCLINE1 = :i_s_line1 AND RCLINE2 = :i_s_line2 AND
		RCOPNO = :i_s_opno
	using sqlca;
	
	INSERT INTO PBRTN.RTN017  
   ( RGCMCD, RGPLANT, RGDVSN, RGITNO, RGLINE1, RGLINE2, RGOPNO,   
     RGMCNO, RGEDFM, RGFLAG, RGEPNO, RGIPAD, RGUPDT, RGSYDT )
	VALUES (:g_s_company,:i_s_plant,:i_s_dvsn,:i_s_itno,:i_s_line1,:i_s_line2,:i_s_opno,
	  :l_s_rgmcno,:l_s_rgedfm,'A',:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date)
	using sqlca;
	if sqlca.sqlcode <> 0 then
		goto Rollback_
	end if
	
	select count(*) into :l_n_sqlcount from pbrtn.rtn017
	where rgplant = :i_s_plant and rgdvsn = :i_s_dvsn and rgitno = :i_s_itno and rgline1 = :i_s_line1 and 
		rgline2 = :i_s_line2 and rgopno  = :i_s_opno
	using sqlca;
	if l_n_sqlcount = 1 then
		update pbrtn.rtn013
			set rcmcyn = 'Y', 
				 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'R',
				 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
				 rcplemp = '', rcplchk = 'N', rcpltime = '',
				 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
		where rccmcd = :g_s_company and rcplant = :i_s_plant and rcdvsn = :i_s_dvsn and 
					rcitno = :i_s_itno and rcline1 = :i_s_line1 and rcline2 = :i_s_line2 and 
					rcopno = :i_s_opno 
		using sqlca;
		
		if sqlca.sqlnrows < 1 then
			//ls_message = "장비유무 설정시에 오류가 발행했습니다."
			goto Rollback_
		end if
	end if
	
	dw_2.insertrow(0)
	dw_2.object.upd_chk[dw_2.rowcount()] = 'A'
	dw_2.object.rgcmcd[dw_2.rowcount()]  = g_s_company
	dw_2.object.rgplant[dw_2.rowcount()] = i_s_plant
	dw_2.object.rgdvsn[dw_2.rowcount()]  = i_s_dvsn
	dw_2.object.rgitno[dw_2.rowcount()]  = i_s_itno
	dw_2.object.rgline1[dw_2.rowcount()] = i_s_line1
	dw_2.object.rgline2[dw_2.rowcount()] = i_s_line2
	dw_2.object.rgopno[dw_2.rowcount()]  = i_s_opno
	dw_2.object.rgedfm[dw_2.rowcount()]  = g_s_date
	dw_2.object.rgmcno[dw_2.rowcount()]  = l_s_rgmcno
	dw_2.object.rgflag[dw_2.rowcount()]  = 'A'
	dw_2.object.rgepno[dw_2.rowcount()]  = g_s_empno
	dw_2.object.rgipad[dw_2.rowcount()]  = g_s_ipaddr
	dw_2.object.rgupdt[dw_2.rowcount()]  = g_s_date
	dw_2.object.rgsydt[dw_2.rowcount()]  = g_s_date
	dw_2.setredraw(true)
	
	COMMIT USING SQLCA;
	continue
	
	Rollback_:
	ROLLBACK USING SQLCA;
next

SQLCA.AUTOCOMMIT = TRUE

dw_2.reset()
dw_2.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno)



end event

type dw_2 from datawindow within w_rtn013u_res03
event ue_keydown pbm_dwnkey
integer x = 1925
integer y = 232
integer width = 1093
integer height = 984
integer taborder = 20
string dataobject = "d_rtn01_dw_jangbi"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;// string l_s_rgmcno

if key = keyDelete! then
//	l_s_rgmcno = this.object.rgmcno[this.getselectedrow(0)]
	this.object.upd_chk[this.getselectedrow(0)] = 'D'
	dw_2.setredraw(true)
//	this.deleterow(0)
//	delete from pbrtng.rtn007 
//		where rgcmcd  = :g_s_company and rgdvsn  = :i_s_dvsn  and rgitno = :i_s_itno and
//		      rgline1 = :i_s_line1   and rgline2 = :i_s_line2 and rgopno = :i_s_opno and rgmcno = :l_s_rgmcno
//	using sqlca;
end if
end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)

end event

type dw_1 from datawindow within w_rtn013u_res03
integer x = 18
integer y = 232
integer width = 1541
integer height = 984
integer taborder = 10
string dataobject = "d_rtn01_dw_janbi_master"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rtn013u_res03
integer x = 32
integer y = 108
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "지역/공장"
boolean focusrectangle = false
end type

type sle_dvsn from singlelineedit within w_rtn013u_res03
integer x = 366
integer y = 92
integer width = 421
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_rtn013u_res03
integer x = 859
integer y = 108
integer width = 155
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_rtn013u_res03
integer x = 1019
integer y = 92
integer width = 553
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_rtn013u_res03
integer x = 1641
integer y = 108
integer width = 302
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "대체Line"
boolean focusrectangle = false
end type

type sle_line from singlelineedit within w_rtn013u_res03
integer x = 1979
integer y = 92
integer width = 393
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_rtn013u_res03
integer x = 2418
integer y = 108
integer width = 297
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공정번호"
boolean focusrectangle = false
end type

type sle_opno from singlelineedit within w_rtn013u_res03
integer x = 2752
integer y = 92
integer width = 197
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rtn013u_res03
integer x = 18
integer y = 32
integer width = 2999
integer height = 184
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
end type

