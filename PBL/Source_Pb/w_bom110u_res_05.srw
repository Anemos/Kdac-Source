$PBExportHeader$w_bom110u_res_05.srw
$PBExportComments$무상 <-> 유상 전환 상위품번
forward
global type w_bom110u_res_05 from window
end type
type em_today from editmask within w_bom110u_res_05
end type
type cb_cancel from commandbutton within w_bom110u_res_05
end type
type cb_ok from commandbutton within w_bom110u_res_05
end type
type sle_itno from singlelineedit within w_bom110u_res_05
end type
type st_1 from statictext within w_bom110u_res_05
end type
type dw_1 from datawindow within w_bom110u_res_05
end type
type gb_1 from groupbox within w_bom110u_res_05
end type
type gb_2 from groupbox within w_bom110u_res_05
end type
end forward

global type w_bom110u_res_05 from window
integer x = 498
integer y = 500
integer width = 2304
integer height = 1156
boolean titlebar = true
string title = "상위품번 유/무상전환"
windowtype windowtype = response!
long backcolor = 12632256
em_today em_today
cb_cancel cb_cancel
cb_ok cb_ok
sle_itno sle_itno
st_1 st_1
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_bom110u_res_05 w_bom110u_res_05

type variables
string 	is_plant, is_div, is_pcitn, is_parm, is_errchk
integer 	in_rows



end variables

on w_bom110u_res_05.create
this.em_today=create em_today
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_itno=create sle_itno
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.em_today,&
this.cb_cancel,&
this.cb_ok,&
this.sle_itno,&
this.st_1,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on w_bom110u_res_05.destroy
destroy(this.em_today)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_itno)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;setpointer(hourglass!)
dw_1.settransobject(sqlca)
is_parm 			= 	message.stringparm
is_plant 		= 	mid(is_parm,1,1)
is_div 			= 	mid(is_parm,2,1)
is_pcitn 		= 	trim(mid(is_parm,3,12))
is_errchk 		= 	mid(is_parm,15,1)
sle_itno.text	=	is_pcitn
em_today.text 	= 	f_relativedate(g_s_date,1)

in_rows 			= dw_1.retrieve(is_plant,is_div, is_pcitn, g_s_date)

if in_rows < 1 then
	is_pcitn 	= string(is_pcitn,"@@@@@@@@@@@@")
	is_errchk = "E"
	is_parm = is_plant + is_div + is_pcitn + is_errchk
	closewithreturn(this, is_parm)
end if


end event

type em_today from editmask within w_bom110u_res_05
integer x = 731
integer y = 112
integer width = 421
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 15780518
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX-XX-XX"
end type

type cb_cancel from commandbutton within w_bom110u_res_05
integer x = 1495
integer y = 944
integer width = 311
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취  소"
boolean cancel = true
end type

event clicked;is_errchk 	= "C"
is_pcitn 	= string(is_pcitn,"@@@@@@@@@@@@")
is_parm 		= is_plant + is_div + is_pcitn + is_errchk
closewithreturn(parent, is_parm)



end event

type cb_ok from commandbutton within w_bom110u_res_05
integer x = 1161
integer y = 944
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
boolean default = true
end type

event clicked;string 		ld_prout, ld_ppitn, ld_pchdt, ld_pwkct, ld_pedtm,ld_oldpchdt,  &
       		ld_pedte, ld_enddate,ld_pexdv, ld_poscd, ld_pebst, ld_pindt, ld_pemno, ld_pexplant
dec{3} 	ld_pqtym, ld_pqtye	
string 		ls_pcitn, ls_itno, ls_err, ls_itclsb, ls_srce, ls_column,ls_inputdate,ls_chkwkct, ls_message
integer 	ln_cnt, i

setpointer(hourglass!)
dw_1.accepttext()

em_today.getdata(ls_inputdate)

if	f_dateedit(ls_inputdate) =	space(8)	or	ls_inputdate <= g_s_date	then
	messagebox("확인","적용시작일은 오늘보다 커야 합니다")
	return -1
end if

for i = 1 to in_rows
	ld_ppitn 		= 	dw_1.object.ppitn[i]
	ld_pwkct 		= 	dw_1.object.pwkct[i]
	
//	// 유무상 호환동일 적용(2011.09.30)
//	if f_bom_check_wkct(g_s_company,is_plant,is_div,is_pitno,ld_pcitn,ld_pwkct,ls_inputdate,ls_message) = -1 then
//		messagebox("확인",ls_message)
//		return 0
//	end if
	
	ls_itclsb = dw_1.object.inv101_cls[i]
	ls_srce = dw_1.object.inv101_srce[i]
	
	if ls_itclsb = "40" or ls_itclsb = "50" then
		if ld_pwkct <> "9999" then
			messagebox("확인", "상위품번 : " + ld_ppitn + " 조코드를 확인해 주시기 바랍니다.")
			return -1
		end if
	end if
	if ls_itclsb = "10" and ls_srce = "02" then
		if ld_pwkct <> "8888" then
			messagebox("확인", "상위품번 : " + ld_ppitn + " 조코드를 확인해 주시기 바랍니다.")
			return -1
		end if
	end if
	if ( ls_itclsb = "30" or ls_srce = "03" ) and ( ld_pwkct = "8888" or ld_pwkct = "9999" ) then
			messagebox("확인", "상위품번 : " + ld_ppitn + " 조코드를 확인해 주시기 바랍니다.")
			return -1
	end if
	if ls_itclsb = "10" and ls_srce = "04" then
		if ld_pwkct <> "8888" and ld_pwkct <> "9999" then
			messagebox("확인", "상위품번 : " + ld_ppitn + " 조코드를 확인해 주시기 바랍니다.")
			return -1
		end if
	end if
next

for i = 1 to in_rows
	if	dw_1.getitemstatus(i,"pwkct",primary!)	=	DataModified!	then
		ld_pindt 		= 	g_s_date
		ld_pchdt 		= 	g_s_date
		ld_prout 		= 	""
		ld_pebst 		= 	""
		ld_oldpchdt	   =	dw_1.object.pchdt[i]	
		ld_pqtym 		= 	dw_1.object.pqtym[i]
		ld_ppitn 		= 	dw_1.object.ppitn[i]
		ld_pwkct 		= 	dw_1.object.pwkct[i]
		ld_pedtm 		= 	dw_1.object.pedtm[i]
		ld_pedte 		= 	dw_1.object.pedte[i]
		ld_pqtye 		= 	dw_1.object.pqtye[i]
		ld_pexplant 	= 	dw_1.object.pexplant[i]
		ld_pexdv 		= 	dw_1.object.pexdv[i]
		if	ld_pwkct	=	'8888'	then
			ld_poscd	=	'1'
		elseif	ld_pwkct	=	'9999'	then
			ld_poscd	=	'2'
		else	
			ld_poscd	=	''
		end if
		
		//*****
		//* 금일입력하고 금일변경하면 정상적으로 입력안됨...
		if (ld_oldpchdt = g_s_date) or ( ld_pedtm > g_s_date ) or ( ld_pedte <> '' and ld_pedte < ls_inputdate ) then
			continue
		end if
		//****
		ld_pedtm 		= 	ls_inputdate
		ld_enddate	   =	f_relativedate(ls_inputdate,-1)
		
		update	"PBPDM"."BOM001"
			set	pedte		=	:ld_enddate, pemno	= :g_s_empno, pchcd =	'D'
		where		pcmcd	   =	:g_s_company	and	plant	=	:is_plant	and	pdvsn	=	:is_div		and	prout	=	:ld_prout	and
					ppitn		=	:ld_ppitn		and	pcitn	=	:is_pcitn	and	pchdt	=	:ld_oldpchdt
		using	sqlca ;
		INSERT INTO "PBPDM"."BOM001"  
				( 	"PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
				  	"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
				  	"PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
		VALUES (	:g_s_company,:is_plant,:is_div,:ld_ppitn ,:ld_prout,:is_pcitn,:ld_pchdt,:ld_pqtym,:ld_pqtye,
		  			:ld_pwkct,:ld_pedtm,:ld_pedte,'',:ld_pexplant,:ld_pexdv,'A',:ld_poscd,:ld_pebst,
		  			:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,'')
		using sqlca;
		if sqlca.sqlcode <> 0 then
			messagebox("확인","상위품번 : " + ld_ppitn + " BOM 입력 오류")
			return -1
		end if
		//		승인 Process 추가 - 2007.12.17
		if	f_bom_approve(is_plant,is_div,is_pcitn,ld_ppitn,'B','S',dw_1,ld_pedtm,i)	<>	0	then
			messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
			return
		end if
		//		승인 Process 끝	
	end if
next

//구매담당자에게 메일발송로직
f_bom_xplan_email(g_s_empno)

is_errchk 		= 	""
ls_pcitn 		= 	string(ls_pcitn,"@@@@@@@@@@@@")
is_parm 		= 	is_plant + is_div + ls_pcitn + is_errchk
closewithreturn(parent, is_parm)

end event

type sle_itno from singlelineedit within w_bom110u_res_05
integer x = 78
integer y = 112
integer width = 571
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

type st_1 from statictext within w_bom110u_res_05
integer x = 105
integer y = 108
integer width = 457
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_bom110u_res_05
integer x = 37
integer y = 256
integer width = 2226
integer height = 640
integer taborder = 20
string dataobject = "d_bom001_explo_05"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_bom110u_res_05
integer x = 37
integer y = 60
integer width = 640
integer height = 172
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "사급소재품번"
end type

type gb_2 from groupbox within w_bom110u_res_05
integer x = 695
integer y = 60
integer width = 480
integer height = 172
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "적용시작일"
end type

