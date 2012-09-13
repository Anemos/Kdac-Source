$PBExportHeader$w_bom110u_res_01.srw
$PBExportComments$하위품번 복사 Response Window
forward
global type w_bom110u_res_01 from window
end type
type st_2 from statictext within w_bom110u_res_01
end type
type p_1 from picture within w_bom110u_res_01
end type
type cb_2 from commandbutton within w_bom110u_res_01
end type
type cb_1 from commandbutton within w_bom110u_res_01
end type
type sle_2 from singlelineedit within w_bom110u_res_01
end type
type sle_1 from singlelineedit within w_bom110u_res_01
end type
type st_1 from statictext within w_bom110u_res_01
end type
type dw_1 from datawindow within w_bom110u_res_01
end type
type gb_1 from groupbox within w_bom110u_res_01
end type
type gb_2 from groupbox within w_bom110u_res_01
end type
end forward

global type w_bom110u_res_01 from window
integer x = 498
integer y = 500
integer width = 1957
integer height = 1148
boolean titlebar = true
string title = "하위품번복사화면"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_2 st_2
p_1 p_1
cb_2 cb_2
cb_1 cb_1
sle_2 sle_2
sle_1 sle_1
st_1 st_1
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_bom110u_res_01 w_bom110u_res_01

type variables
string 		is_plant, is_div, is_pitno, is_parm, is_errchk
integer 	in_rows
datawindowchild idwc_child



end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
end prototypes

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);string ls_command
long 	 ll_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
ag_dw_1.setredraw(False)
if ag_n_color 	= 	1	then
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(255,255,0), 15780518 )'"
else
	ls_command	=	ag_s_column + ".Background.Color = '" + String(ll_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," &
					+  " rgb(255,255,0), rgb(255,255,255))'"
end if
ag_dw_1.Modify(ls_command)
ag_dw_1.setredraw(True)
end subroutine

on w_bom110u_res_01.create
this.st_2=create st_2
this.p_1=create p_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_2,&
this.p_1,&
this.cb_2,&
this.cb_1,&
this.sle_2,&
this.sle_1,&
this.st_1,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on w_bom110u_res_01.destroy
destroy(this.st_2)
destroy(this.p_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;integer	ln_count

setpointer(hourglass!)
sle_2.setfocus()
dw_1.settransobject(sqlca)
is_parm 		= message.stringparm
is_plant 	= mid(is_parm,1,1)
is_div 		= mid(is_parm,2,1)
is_pitno 	= mid(is_parm,3,12)
is_errchk 	= mid(is_parm,15,1)
sle_1.text 	= is_pitno

dw_1.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
if	ln_count	>	0	then
	idwc_child.retrieve(g_s_empno)
else
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'')
	idwc_child.setitem(1,"dac001_dname",'')
	idwc_child.setitem(1,"display",'')
end if

in_rows 	= dw_1.retrieve(is_plant,is_div, is_pitno, g_s_date)
is_pitno 	= string(is_pitno,"@@@@@@@@@@@@")
if in_rows < 1 then
	is_errchk = "E"
	is_parm = is_plant + is_div + is_pitno + is_errchk
	closewithreturn(this, is_parm)
end if
//dw_1.getchild("pwkct",idwc_child)
//idwc_child.settransobject(sqlca)
//idwc_child.reset()
//if ls_srce = '03' or trim(ls_srce) = '' then
//	idwc_child.retrieve(g_s_empno)
//elseif ls_srce = '02' then
//	dw_1.getchild("pwkct",idwc_child)
//	idwc_child.settransobject(sqlca)
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(1,"dac001_dcode",'8888')
//	idwc_child.setitem(1,"dac001_dname",'유상사급')
//	idwc_child.setitem(1,"display",'8888 유상사급')
//elseif ls_srce = '04' and ls_itclsb <> '10' then
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(1,"dac001_dcode",'9999')
//	idwc_child.setitem(1,"dac001_dname",'무상사급')
//	idwc_child.setitem(1,"display",'9999 무상사급')
//elseif ls_srce = '04' and ls_itclsb  =  '10' then
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(1,"dac001_dcode",'8888')
//	idwc_child.setitem(1,"dac001_dname",'유상사급')
//	idwc_child.setitem(1,"display",'8888 유상사급')	
//	idwc_child.insertrow(0) 
//	idwc_child.setitem(2,"dac001_dcode",'9999')
//	idwc_child.setitem(2,"dac001_dname",'무상사급')
//	idwc_child.setitem(2,"display",'9999 무상사급')	
//end if
end event

type st_2 from statictext within w_bom110u_res_01
integer x = 37
integer y = 948
integer width = 1115
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "투입처 더블클릭시 전체적용!"
boolean focusrectangle = false
end type

type p_1 from picture within w_bom110u_res_01
integer x = 795
integer y = 108
integer width = 283
integer height = 92
string picturename = "C:\kdac\bmp\focus.GIF"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_bom110u_res_01
integer x = 1595
integer y = 936
integer width = 311
integer height = 100
integer taborder = 30
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
is_pitno 	= string(is_pitno,"@@@@@@@@@@@@")
is_parm 		= is_plant + is_div + is_pitno + is_errchk
closewithreturn(parent, is_parm)



end event

type cb_1 from commandbutton within w_bom110u_res_01
integer x = 1262
integer y = 936
integer width = 311
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
boolean default = true
end type

event clicked;string 	ld_plant,ld_div, ld_ppitn, ld_prout, ld_pcitn, ld_pchdt, ld_pwkct, ld_pedtm,  &
       	ld_pedte, ld_pexdv, ld_poscd, ld_pebst, ld_pindt, ld_pemno, ld_pexplant
dec{3} 	ld_pqtym, ld_pqtye	
string 	ls_pcitn, ls_itno, ls_err, ls_wkct, ls_itclsb, ls_srce, ls_column,ls_message
integer 	ln_cnt, i

setpointer(hourglass!)
ls_pcitn 	= upper(trim(sle_2.text))
ls_itclsb 	= f_bom_get_itcls(is_plant,is_div,ls_pcitn)
ls_srce   	= f_bom_get_srce(is_plant,is_div,ls_pcitn)
dw_1.accepttext()

if f_spacechk(ls_pcitn) = -1 then
	messagebox("확인","Copy 품번을 입력하세요.")
	return
else
	SELECT count(*) INTO :ln_cnt  FROM "PBINV"."INV101"  
   	WHERE ( "PBINV"."INV101"."COMLTD" 	= :g_s_company ) AND  
         	( "PBINV"."INV101"."XPLANT" 	= :is_plant ) AND  
         	( "PBINV"."INV101"."DIV" 		= :is_div ) AND  
         	( "PBINV"."INV101"."ITNO" 		= :ls_pcitn )   
            using sqlca;
	if ln_cnt = 0 then
		messagebox("확인","품목상세정보 미등록품입니다.")
		return   
	else
		if ls_itclsb = "10" and ( ls_srce = "01"  or ls_srce = "05" or ls_srce = "06" ) then
         messagebox("확인","하위품목 입력 불가. 계정을 확인하세요")
     	   return
      end if
		select count(*) into : ln_cnt from "PBPDM"."BOM001"
		where 	"PBPDM"."BOM001"."PCMCD" = '01' and
					"PBPDM"."BOM001"."PLANT" = :is_plant and 
					"PBPDM"."BOM001"."PDVSN" = :is_div and 
					"PBPDM"."BOM001"."PPITN" = :ls_pcitn AND  
					((	"PBPDM"."BOM001"."PEDTE" = '' ) OR  
					(	"PBPDM"."BOM001"."PEDTE" <> '' AND  
						"PBPDM"."BOM001"."PEDTE" > :g_s_date and "PBPDM"."BOM001"."PEDTE" >= "PBPDM"."BOM001"."PEDTM" ))    
		using sqlca;
		if ln_cnt > 0 then
			messagebox("확인","하위품번이 존재")
			return
		else
			for i = 1 to in_rows
				ls_itno = upper(trim(dw_1.object.pcitn[i]))
				if ls_pcitn = ls_itno then
					messagebox("확인","BOM 구조를 확인하세요.")
					return
				else
					if f_chk_bom(is_plant,is_div,ls_pcitn,ls_itno) = 1 then	
						messagebox("확인","BOM 구조를 확인하세요.")
						return
					end if
				end if
			next
	   end if
    end if
end if

for i = 1 to in_rows 
	dw_1.setitem(i,"ppitn",ls_pcitn)  //상위품번 셋팅
	ls_err 	= ' '
	ls_wkct = dw_1.object.pwkct[i]
	ld_pcitn 		= 	dw_1.object.pcitn[i]
	
	// 유무상 호환동일 적용(2011.09.30)
	if f_bom_check_wkct(g_s_company,is_plant,is_div,ls_pcitn,ld_pcitn,ls_wkct,f_relativedate(g_s_date,1),ls_message) = -1 then
		messagebox("확인",ls_message)
		return 0
	end if
	
	if f_spacechk(ls_wkct) = -1  then
		ls_err = '1'
	else
		if ls_wkct <> "8888" and ls_wkct <> "9999" then
				select count(*) into :ln_cnt from pbcommon.dac001
		       where duse = '' and dtodt = 0 and dcode = :ls_wkct and dacttodt = 0 using sqlca;
			if ln_cnt < 1 then
				ls_err = '1'
			end if
		end if
		if ls_itclsb = "40" or ls_itclsb = "50" then
			if ls_wkct <> "9999" then
				ls_err = '1'
			end if
		end if
		if ls_itclsb = "10" and ls_srce = "02" then
			if ls_wkct <> "8888" then
				ls_err = '1'
			end if
		end if
		if ls_itclsb = "30" and ( ls_wkct = "8888" or ls_wkct = "9999" ) then
			ls_err = '1'
		end if
		if ls_srce = "03" and ( ls_wkct = "8888" or ls_wkct = "9999" ) then
			ls_err = '1'
		end if
		if ls_itclsb = "10" and ls_srce = "04" then
			if ls_wkct <> "8888" and ls_wkct <> "9999" then
				ls_err = '1'
			end if
		end if
	end if
	dw_1.object.cp_chk[i] = ls_err
next
wf_rgbset("pwkct",1,1,dw_1)
dw_1.SetRedraw(False)
ls_column	=	''
ls_err   =  ''
for i = 1 to in_rows
	ls_err	= 	dw_1.getitemstring(i, "cp_chk")
	if f_spacechk(ls_err) =	0 then
		if mid(ls_err, 1, 1) = "1" then
			if f_spacechk(ls_column)	= 	-1  then
				ls_column  =	"pwkct"
				exit
			end if
		end if
	end if
next
dw_1.SetRedraw(True)

if len(ls_column)  > 0 then									// Editing Error
	dw_1.setrow(i)
	dw_1.setcolumn(ls_column)
	dw_1.setfocus()
	messagebox("확인","투입처 입력 오류")
	return
end if

dw_1.accepttext()
for i = 1 to in_rows
	ld_plant 		=	is_plant
   	ld_div   		= 	is_div
	ld_ppitn 		= 	ls_pcitn
	ld_pindt 		= 	g_s_date
	ld_pchdt 		= 	g_s_date
	ld_pemno 	= 	g_s_empno
	ld_prout 		= 	""
	ld_pebst 		= 	""
   	ld_pcitn 		= 	dw_1.object.pcitn[i]
	ld_pqtym 		= 	dw_1.object.pqtym[i]
	ld_pwkct 		= 	dw_1.object.pwkct[i]
	ld_pedtm 		= 	f_relativedate(g_s_date,1)
	ld_pedte 		= 	dw_1.object.pedte[i]
	if f_spacechk(ld_pedte) <> -1 then
		ld_pedtm = ld_pedte
	end if
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
	INSERT INTO "PBPDM"."BOM001"  
         		( 	"PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
           		"PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
			  	"PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
	VALUES (	:g_s_company,:ld_plant,:ld_div,:ld_ppitn,:ld_prout,:ld_pcitn,:ld_pchdt,:ld_pqtym,:ld_pqtye,
			  	:ld_pwkct,:ld_pedtm,:ld_pedte,'',:ld_pexplant,:ld_pexdv,'A',:ld_poscd,:ld_pebst,
			  	:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,'')
	Using sqlca;
			  
	if sqlca.sqlcode <> 0 then
		rollback using sqlca ;
		messagebox("확인","BOM 입력 오류")
	   return
	end if
	 commit using sqlca;
	 
	 f_bom_approve(is_plant,is_div,upper(trim(sle_2.text)),upper(trim(sle_1.text)),'B','C',dw_1,ld_pedtm,i)
//	 f_lolev_update(ld_plant,ld_div,ld_ppitn)
next

//		승인 Process 추가 - 2007.12.17
//if	f_bom_approve(is_plant,is_div,upper(trim(sle_2.text)),upper(trim(sle_1.text)),'B','C',dw_1,ld_pedtm)	<>	0	then
//	messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
//	return
//end if
//		승인 Process 끝	

//구매담당자에게 메일발송로직
f_bom_xplan_email(g_s_empno)


is_errchk = ""
ls_pcitn = string(ls_pcitn,"@@@@@@@@@@@@")
is_parm = is_plant + is_div + ls_pcitn + is_errchk
closewithreturn(parent, is_parm)

end event

type sle_2 from singlelineedit within w_bom110u_res_01
integer x = 1211
integer y = 120
integer width = 562
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;string	ls_itclsb,ls_srce

ls_itclsb 	= f_bom_get_itcls(is_plant,is_div,trim(this.text))
ls_srce   	= f_bom_get_srce(is_plant,is_div,trim(this.text))
dw_1.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
if ls_srce = '03' or trim(ls_srce) = '' then
	idwc_child.retrieve(g_s_empno)
elseif ls_srce = '02' then
	dw_1.getchild("pwkct",idwc_child)
	idwc_child.settransobject(sqlca)
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')
elseif ls_srce = '04' and ls_itclsb <> '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'9999')
	idwc_child.setitem(1,"dac001_dname",'무상사급')
	idwc_child.setitem(1,"display",'9999 무상사급')
elseif ls_srce = '04' and ls_itclsb  =  '10' then
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'8888')
	idwc_child.setitem(1,"dac001_dname",'유상사급')
	idwc_child.setitem(1,"display",'8888 유상사급')	
	idwc_child.insertrow(0) 
	idwc_child.setitem(2,"dac001_dcode",'9999')
	idwc_child.setitem(2,"dac001_dname",'무상사급')
	idwc_child.setitem(2,"display",'9999 무상사급')	
end if

end event

type sle_1 from singlelineedit within w_bom110u_res_01
integer x = 114
integer y = 112
integer width = 571
integer height = 92
integer taborder = 10
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

type st_1 from statictext within w_bom110u_res_01
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

type dw_1 from datawindow within w_bom110u_res_01
integer x = 41
integer y = 268
integer width = 1893
integer height = 628
integer taborder = 10
string dataobject = "d_bom001_explo_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if dwo.name = "pwkct_t" then
	string ls_wkct
	integer li_cnt
	
	ls_wkct = this.getitemstring(1,"pwkct")
	if f_spacechk(ls_wkct) = -1 then
		Messagebox("확인", "첫번째행 투입처를 선택해 주시기 바랍니다.")
		return -1
	end if
	for li_cnt = 2 to this.rowcount()
		this.setitem(li_cnt,"pwkct",ls_wkct)
	next
end if

return 0
end event

type gb_1 from groupbox within w_bom110u_res_01
integer x = 73
integer y = 60
integer width = 640
integer height = 172
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Copy前 품목"
end type

type gb_2 from groupbox within w_bom110u_res_01
integer x = 1161
integer y = 60
integer width = 640
integer height = 172
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Copy後 품목"
end type

