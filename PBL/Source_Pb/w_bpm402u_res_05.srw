$PBExportHeader$w_bpm402u_res_05.srw
$PBExportComments$품번교체 Response Window
forward
global type w_bpm402u_res_05 from window
end type
type p_1 from picture within w_bpm402u_res_05
end type
type dw_1 from datawindow within w_bpm402u_res_05
end type
type sle_1 from singlelineedit within w_bpm402u_res_05
end type
type sle_2 from singlelineedit within w_bpm402u_res_05
end type
type cb_1 from commandbutton within w_bpm402u_res_05
end type
type cb_2 from commandbutton within w_bpm402u_res_05
end type
type gb_1 from groupbox within w_bpm402u_res_05
end type
type gb_2 from groupbox within w_bpm402u_res_05
end type
end forward

global type w_bpm402u_res_05 from window
integer x = 498
integer y = 500
integer width = 1815
integer height = 1284
boolean titlebar = true
string title = "품번 선택"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
p_1 p_1
dw_1 dw_1
sle_1 sle_1
sle_2 sle_2
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
gb_2 gb_2
end type
global w_bpm402u_res_05 w_bpm402u_res_05

type variables
string l_s_plant,l_s_div, l_s_pitno, l_s_parm, l_s_errchk,l_s_applyyear,l_s_revno,l_s_applydate,l_s_enddate
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

on w_bpm402u_res_05.create
this.p_1=create p_1
this.dw_1=create dw_1
this.sle_1=create sle_1
this.sle_2=create sle_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.p_1,&
this.dw_1,&
this.sle_1,&
this.sle_2,&
this.cb_1,&
this.cb_2,&
this.gb_1,&
this.gb_2}
end on

on w_bpm402u_res_05.destroy
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;setpointer(hourglass!)
sle_2.setfocus()
dw_1.settransobject(sqlca)

l_s_parm = message.stringparm

l_s_applyyear = mid(l_s_parm,1,4)
l_s_revno = mid(l_s_parm,5,2)
l_s_plant = mid(l_s_parm,7,1)
l_s_div = mid(l_s_parm,8,1)
l_s_pitno = mid(l_s_parm,9,12)
l_s_errchk = mid(l_s_parm,21,1)

sle_1.text = l_s_pitno

l_n_rows = dw_1.retrieve(l_s_applyyear,l_s_revno,l_s_plant , l_s_div, l_s_pitno, g_s_date)
l_s_pitno = string(l_s_pitno,"@@@@@@@@@@@@")
if l_n_rows < 1 then
	l_s_errchk = "E"
	l_s_parm = l_s_plant + l_s_div + l_s_pitno + l_s_errchk
	closewithreturn(this, l_s_parm)
else
	//BOM생성 적용일자 가져오기
	SELECT Jobstart INTO :l_s_applydate
	FROM PBBPM.BPM519
	WHERE COMLTD = :g_s_company AND XYEAR = :l_s_applyyear AND 
			REVNO = :l_s_revno AND Windowid = 'w_bpm407c'
	using sqlca;
	
	if f_dateedit(l_s_applydate) = space(8) then
		messagebox("확인","bom기준일자가 잘못되었습니다.")
		return 0
	end if
	
	l_s_enddate = f_relativedate(l_s_applydate,-1)
end if

end event

type p_1 from picture within w_bpm402u_res_05
integer x = 768
integer y = 204
integer width = 283
integer height = 92
string picturename = "C:\kdac\bmp\focus.GIF"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_bpm402u_res_05
integer x = 41
integer y = 336
integer width = 1714
integer height = 584
integer taborder = 20
string dataobject = "d_bpm504_implo_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_bpm402u_res_05
integer x = 87
integer y = 200
integer width = 567
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

type sle_2 from singlelineedit within w_bpm402u_res_05
integer x = 1161
integer y = 200
integer width = 567
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

type cb_1 from commandbutton within w_bpm402u_res_05
integer x = 1120
integer y = 964
integer width = 311
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확  인"
boolean default = true
end type

event clicked;string l_d_plant, l_d_div, l_d_ppitn, l_d_prout, l_d_pcitn, l_d_pchdt, l_d_pwkct, l_d_pedtm,  &
       l_d_pedte, l_d_pexdv, l_d_poscd, l_d_pebst, l_d_pindt, l_d_pemno, l_d_pexplant, ls_nextdate, ls_origin_pcitn
dec{3}   l_d_pqtym, l_d_pqtye	
string l_s_pcitn, l_s_itno, l_s_err, l_s_wkct, l_s_itclsb, l_s_srce, l_n_column
integer l_n_cnt, i

setpointer(hourglass!)
l_s_pcitn = upper(trim(sle_2.text))
ls_origin_pcitn = upper(trim(sle_1.text))
l_s_itclsb = f_bpm_get_itcls(l_s_applyyear,l_s_revno,l_s_plant,l_s_div,l_s_pcitn)
l_s_srce   = f_bpm_get_srce(l_s_applyyear,l_s_revno,l_s_plant,l_s_div,l_s_pcitn)

dw_1.accepttext()

if f_spacechk(l_s_pcitn) = -1 then
	messagebox("확인","Copy 품번을 입력하세요.")
	return
else
	SELECT count(*)  
	INTO :l_n_cnt  
	FROM "PBBPM"."BPM503"  
	WHERE ( "PBBPM"."BPM503"."XYEAR" = :l_s_applyyear ) AND  
			( "PBBPM"."BPM503"."REVNO" = :l_s_revno ) AND  
			( "PBBPM"."BPM503"."XPLANT" = :l_s_plant ) AND  
			( "PBBPM"."BPM503"."DIV" = :l_s_div ) AND  
			( "PBBPM"."BPM503"."ITNO" = :l_s_pcitn )   
			using sqlca;
  
	if l_n_cnt = 0 then
		messagebox("확인","품목상세정보 미등록품입니다.")
		return   
	else
		if f_dateedit(l_s_applydate) = space(8) then
			messagebox("확인","bom기준일자가 잘못되었습니다.")
			return 0
		end if
		select count(*) into : l_n_cnt from "PBBPM"."BPM504"
			where "PBBPM"."BPM504"."PCMCD" = '01' and
					"PBBPM"."BPM504"."XYEAR" = :l_s_applyyear and 
					"PBBPM"."BPM504"."REVNO" = :l_s_revno and 
					"PBBPM"."BPM504"."PLANT" = :l_s_plant and 
					"PBBPM"."BPM504"."PDVSN" = :l_s_div and 
					"PBBPM"."BPM504"."PCITN" = :l_s_pcitn AND  
					(( "PBBPM"."BPM504"."PEDTE" = '' ) OR  
					( "PBBPM"."BPM504"."PEDTE" <> '' AND  
					"PBBPM"."BPM504"."PEDTE" >= :l_s_applydate and "PBBPM"."BPM504"."PEDTE" >= "PBBPM"."BPM504"."PEDTM" ))    
					using sqlca;
		if l_n_cnt > 0 then
			messagebox("확인","상위품번이 존재")
			return
		else
			for i = 1 to l_n_rows
				l_s_itno = upper(trim(dw_1.object.ppitn[i]))
				if l_s_pcitn = l_s_itno then
					messagebox("확인","BOM 구조를 확인하세요.")
					return
				else
					if f_chk_bom_bpm(l_s_applyyear,l_s_revno,l_s_plant,l_s_div,l_s_itno,l_s_pcitn,l_s_applydate) = 1 then	
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
	l_s_wkct   = dw_1.object.pwkct[i]
	l_s_itclsb = f_bpm_get_itcls(l_s_applyyear,l_s_revno,l_s_plant,l_s_div,dw_1.object.ppitn[i])
   l_s_srce   = f_bpm_get_srce(l_s_applyyear,l_s_revno,l_s_plant,l_s_div,dw_1.object.ppitn[i])

	if f_spacechk(l_s_wkct) = -1  then
		l_s_err = '1'
	else
		if l_s_wkct <> "8888" and l_s_wkct <> "9999" then
			
			SELECT count(*)  
    			INTO :l_n_cnt
    			FROM "PBCOMMON"."DAC001"  
   				WHERE ( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND  
         				( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND  
         				( "PBCOMMON"."DAC001"."DCODE" = :l_s_wkct ) AND  
         				( "PBCOMMON"."DAC001"."DACTTODT" = 0 )   
           				using sqlca;
					 
			if l_n_cnt < 1 then
				l_s_err = '1'
			end if
		end if

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
f_bpm_job_start(l_s_applyyear,l_s_revno,'w_bpm402u',g_s_empno,'C','사업계획BOM정보 품목교체 : ' + l_s_pcitn)
for i = 1 to l_n_rows
	l_d_plant 	= l_s_plant
   l_d_div 		= l_s_div
	l_d_pcitn 	= l_s_pcitn
	l_d_pindt 	= g_s_date
	l_d_pchdt 	= dw_1.object.pchdt[i]
	l_d_pemno 	= g_s_empno
	l_d_prout 	= ""
	l_d_pebst 	= ""
   l_d_ppitn 	= dw_1.object.ppitn[i]
	l_d_pqtym 	= dw_1.object.pqtym[i]
	l_d_pwkct 	= dw_1.object.pwkct[i]
	l_d_pedtm 	= ''
	l_d_pedte 	= dw_1.object.pedte[i]
	l_d_pqtye 	= dw_1.object.pqtye[i]
	l_d_pexplant = dw_1.object.pexplant[i]
	l_d_pexdv 	= dw_1.object.pexdv[i]
	if l_d_pwkct = '8888' then
		l_d_poscd = '1'
	elseif l_d_pwkct = '9999' then
		l_d_poscd = '2'
	else
		l_d_poscd = ''
	end if
	
	UPDATE PBBPM.BPM504
	SET PEDTE = :l_s_enddate
	WHERE PCMCD = :g_s_company AND XYEAR = :l_s_applyyear AND REVNO = :l_s_revno AND
	   PLANT = :l_d_plant AND PDVSN = :l_d_div AND PPITN = :l_d_ppitn AND 
		PCITN = :ls_origin_pcitn AND PROUT = :l_d_prout AND PCHDT = :l_d_pchdt
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		rollback using sqlca ;
		messagebox("확인","BOM 완료일 업데이트 오류")
		return
	end if
	
	INSERT INTO "PBBPM"."BPM504"  
         ( "PCMCD","XYEAR","REVNO","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
           "PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
			  "PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
  			VALUES (:g_s_company,:l_s_applyyear,:l_s_revno,:l_d_plant,:l_d_div,:l_d_ppitn,:l_d_prout,:l_d_pcitn,:g_s_date,:l_d_pqtym,:l_d_pqtye
			  ,:l_d_pwkct,:l_s_applydate,'99991231',' ',:l_d_pexplant,:l_d_pexdv,'A',:l_d_poscd,:l_d_pebst
			  ,:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
  			using sqlca;
	
	if sqlca.sqlcode <> 0 then
		rollback using sqlca ;
		messagebox("확인","BOM 입력 오류")
		return
	 end if
	 commit using sqlca;
//	 f_lolev_update(l_s_plant,l_d_div,l_d_ppitn)
next

l_s_errchk = ""
l_s_pcitn = string(l_s_pcitn,"@@@@@@@@@@@@")
l_s_parm = l_s_div + l_s_pcitn + l_s_errchk
closewithreturn(parent, l_s_parm)

end event

type cb_2 from commandbutton within w_bpm402u_res_05
integer x = 1454
integer y = 964
integer width = 311
integer height = 100
integer taborder = 10
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

type gb_1 from groupbox within w_bpm402u_res_05
integer x = 46
integer y = 144
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
string text = "교체前 품목"
end type

type gb_2 from groupbox within w_bpm402u_res_05
integer x = 1125
integer y = 144
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
string text = "교체後 품목"
end type

