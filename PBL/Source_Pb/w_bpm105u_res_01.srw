$PBExportHeader$w_bpm105u_res_01.srw
$PBExportComments$하위품번 복사 Response Window
forward
global type w_bpm105u_res_01 from window
end type
type p_1 from picture within w_bpm105u_res_01
end type
type cb_2 from commandbutton within w_bpm105u_res_01
end type
type cb_1 from commandbutton within w_bpm105u_res_01
end type
type sle_2 from singlelineedit within w_bpm105u_res_01
end type
type sle_1 from singlelineedit within w_bpm105u_res_01
end type
type st_1 from statictext within w_bpm105u_res_01
end type
type dw_1 from datawindow within w_bpm105u_res_01
end type
type gb_1 from groupbox within w_bpm105u_res_01
end type
type gb_2 from groupbox within w_bpm105u_res_01
end type
end forward

global type w_bpm105u_res_01 from window
integer x = 498
integer y = 500
integer width = 1879
integer height = 1172
boolean titlebar = true
string title = "품번 선택"
windowtype windowtype = response!
long backcolor = 12632256
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
global w_bpm105u_res_01 w_bpm105u_res_01

type variables
string l_s_plant, l_s_div, l_s_pitno, l_s_parm, l_s_errchk
integer l_n_rows



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

on w_bpm105u_res_01.create
this.p_1=create p_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.p_1,&
this.cb_2,&
this.cb_1,&
this.sle_2,&
this.sle_1,&
this.st_1,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on w_bpm105u_res_01.destroy
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

event open;setpointer(hourglass!)
sle_2.setfocus()
dw_1.settransobject(sqlca)

l_s_parm = message.stringparm
   
l_s_plant = mid(l_s_parm,1,1)
l_s_div = mid(l_s_parm,2,1)
l_s_pitno = mid(l_s_parm,3,12)
l_s_errchk = mid(l_s_parm,15,1)
sle_1.text = l_s_pitno

l_n_rows = dw_1.retrieve(l_s_plant,l_s_div, l_s_pitno, g_s_date)
l_s_pitno = string(l_s_pitno,"@@@@@@@@@@@@")
if l_n_rows < 1 then
	l_s_errchk = "E"
	l_s_parm = l_s_plant + l_s_div + l_s_pitno + l_s_errchk
	closewithreturn(this, l_s_parm)
end if




end event

type p_1 from picture within w_bpm105u_res_01
integer x = 795
integer y = 108
integer width = 283
integer height = 92
string picturename = "C:\kdac\bmp\focus.GIF"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_bpm105u_res_01
integer x = 1495
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
string text = "취  소"
boolean cancel = true
end type

event clicked;l_s_errchk = "C"
l_s_pitno = string(l_s_pitno,"@@@@@@@@@@@@")
l_s_parm = l_s_plant + l_s_div + l_s_pitno + l_s_errchk
closewithreturn(parent, l_s_parm)



end event

type cb_1 from commandbutton within w_bpm105u_res_01
integer x = 1161
integer y = 944
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

event clicked;string l_d_plant,l_d_div, l_d_ppitn, l_d_prout, l_d_pcitn, l_d_pchdt, l_d_pwkct, l_d_pedtm,  &
       l_d_pedte, l_d_pexdv, l_d_poscd, l_d_pebst, l_d_pindt, l_d_pemno, l_d_pexplant
dec{3}   l_d_pqtym, l_d_pqtye	
string l_s_pcitn, l_s_itno, l_s_err, l_s_wkct, l_s_itclsb, l_s_srce, l_n_column
integer l_n_cnt, i

setpointer(hourglass!)
l_s_pcitn = upper(trim(sle_2.text))
l_s_itclsb = f_bom_get_itcls(l_s_plant,l_s_div,l_s_pcitn)
l_s_srce   = f_bom_get_srce(l_s_plant,l_s_div,l_s_pcitn)
dw_1.accepttext()

if f_spacechk(l_s_pcitn) = -1 then
	    messagebox("확인","Copy 품번을 입력하세요.")
		 return
 else
	 SELECT count(*)  
    	INTO :l_n_cnt  
    	FROM "PBINV"."INV101"  
   	WHERE ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         	( "PBINV"."INV101"."XPLANT" = :l_s_plant ) AND  
         	( "PBINV"."INV101"."DIV" = :l_s_div ) AND  
         	( "PBINV"."INV101"."ITNO" = :l_s_pcitn )   
            using sqlca;

	if l_n_cnt = 0 then
		messagebox("확인","품목상세정보 미등록품입니다.")
		return   
	else
		if l_s_itclsb = "10" and ( l_s_srce = "01"  or l_s_srce = "05" or l_s_srce = "06" ) then
           messagebox("확인","하위품목 입력 불가. 계정을 확인하세요")
      	   return
        end if
		
		select count(*) into : l_n_cnt from "PBBPM"."BPM001"
		where "PBBPM"."BPM001"."PCMCD" = '01' and
				"PBBPM"."BPM001"."PLANT" = :l_s_plant and 
				"PBBPM"."BPM001"."PDVSN" = :l_s_div and 
				"PBBPM"."BPM001"."PPITN" = :l_s_pcitn AND  
         	(( "PBBPM"."BPM001"."PEDTE" = '' ) OR  
         	( "PBBPM"."BPM001"."PEDTE" <> '' AND  
         	"PBBPM"."BPM001"."PEDTE" >= :g_s_date and "PBBPM"."BPM001"."PEDTE" >= "PBBPM"."BPM001"."PEDTM" ))    
				 using sqlca;
		if l_n_cnt > 0 then
			messagebox("확인","하위품번이 존재")
			return
		else
			for i = 1 to l_n_rows
				l_s_itno = upper(trim(dw_1.object.pcitn[i]))
				if l_s_pcitn = l_s_itno then
					messagebox("확인","BOM 구조를 확인하세요.")
					return
				else
					if f_chk_bom_bpm(l_s_plant,l_s_div,l_s_pcitn,l_s_itno) = 1 then	
						messagebox("확인","BOM 구조를 확인하세요.")
						return
					end if
				end if
			next
	   end if
    end if
end if

for i = 1 to l_n_rows 
	l_s_err = ' '
	l_s_wkct = dw_1.object.pwkct[i]
	if f_spacechk(l_s_wkct) = -1  then
		l_s_err = '1'
	else
//		if l_s_wkct <> "8888" and l_s_wkct <> "9999" then
//			select count(*) into :l_n_cnt from pbcommon.dac001
//		       where duse = ' ' and dtodt = 0 and dcode = :l_s_wkct and dacttodt = 0 using sqlca;
//			if l_n_cnt < 1 then
//				l_s_err = '1'
//			end if
//		end if

		if l_s_itclsb = "40" or l_s_itclsb = "50" then
			if l_s_wkct <> "9999" then
				l_s_err = '1'
			end if
		end if
		if l_s_itclsb = "10" and l_s_srce = "02" then
			if l_s_wkct <> "8888" then
				l_s_err = '1'
			end if
		end if
		if l_s_itclsb = "30" and ( l_s_wkct = "8888" or l_s_wkct = "9999" ) then
				l_s_err = '1'
		end if
		if l_s_srce = "03" and ( l_s_wkct = "8888" or l_s_wkct = "9999" ) then
				l_s_err = '1'
		end if
		if l_s_itclsb = "10" and l_s_srce = "04" then
			if l_s_wkct <> "8888" and l_s_wkct <> "9999" then
				l_s_err = '1'
			end if
		end if
	end if
	dw_1.object.cp_chk[i] = l_s_err
next
wf_rgbset("pwkct",1,1,dw_1)

dw_1.SetRedraw(False)
l_n_column	=	''
l_s_err   =  ''
for i = 1 to l_n_rows
	l_s_err	= 	dw_1.getitemstring(i, "cp_chk")
	if f_spacechk(l_s_err) =	0 then
		if mid(l_s_err, 1, 1) = "1" then
			if f_spacechk(l_n_column)	= 	-1  then
				l_n_column  =	"pwkct"
				exit
			end if
		end if
	end if
next
dw_1.SetRedraw(True)

if len(l_n_column)  > 0 then									// Editing Error
	dw_1.setrow(i)
	dw_1.setcolumn(l_n_column)
	dw_1.setfocus()
	messagebox("확인","투입처 입력 오류")
		// 필수입력 항목을 수정 후 처리바랍니다.	
	return
end if

for i = 1 to l_n_rows
	l_d_plant = l_s_plant
   l_d_div   = l_s_div
	l_d_ppitn = l_s_pcitn
	l_d_pindt = g_s_date
	l_d_pchdt = g_s_date
	l_d_pemno = g_s_empno
	l_d_prout = ""
	l_d_pebst = ""
   l_d_pcitn = dw_1.object.pcitn[i]
	l_d_pqtym = dw_1.object.pqtym[i]
	l_d_pwkct = dw_1.object.pwkct[i]
	l_d_pedtm = ''
	l_d_pedte = dw_1.object.pedte[i]
	l_d_pqtye = dw_1.object.pqtye[i]
	l_d_pexplant = dw_1.object.pexplant[i]
	l_d_pexdv = dw_1.object.pexdv[i]
	if l_d_pwkct = '8888' then
		l_d_poscd = '1'
	elseif l_d_pwkct = '9999' then
		l_d_poscd = '2'
	else
		l_d_poscd = ''
	end if
	
	INSERT INTO "PBBPM"."BPM001"  
         ( "PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
           "PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
			  "PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
  			VALUES (:g_s_company,:l_d_plant,:l_d_div,:l_d_ppitn,:l_d_prout,:l_d_pcitn,:l_d_pchdt,:l_d_pqtym,:l_d_pqtye
			  ,:l_d_pwkct,:l_d_pedtm,:l_d_pedte,' ',:l_d_pexplant,:l_d_pexdv,'A',:l_d_poscd,:l_d_pebst
			  ,:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
  			using sqlca;
			  
	if sqlca.sqlcode <> 0 then
		rollback using sqlca ;
		messagebox("확인","BOM 입력 오류")
	   return
	end if
	 commit using sqlca;
//	 f_lolev_update(l_d_plant,l_d_div,l_d_ppitn)
next

l_s_errchk = ""
l_s_pcitn = string(l_s_pcitn,"@@@@@@@@@@@@")
l_s_parm = l_s_plant + l_s_div + l_s_pcitn + l_s_errchk
closewithreturn(parent, l_s_parm)

end event

type sle_2 from singlelineedit within w_bpm105u_res_01
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
long backcolor = 15793151
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_bpm105u_res_01
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

type st_1 from statictext within w_bpm105u_res_01
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

type dw_1 from datawindow within w_bpm105u_res_01
integer x = 69
integer y = 268
integer width = 1737
integer height = 628
integer taborder = 10
string dataobject = "d_BPM001_explo_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_bpm105u_res_01
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

type gb_2 from groupbox within w_bpm105u_res_01
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

