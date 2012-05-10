$PBExportHeader$w_rtn014b.srw
$PBExportComments$유사품번업로드
forward
global type w_rtn014b from w_origin_sheet06
end type
type st_1 from statictext within w_rtn014b
end type
type cb_1 from commandbutton within w_rtn014b
end type
type sle_1 from singlelineedit within w_rtn014b
end type
type st_a1 from statictext within w_rtn014b
end type
type st_a2 from statictext within w_rtn014b
end type
type st_3 from statictext within w_rtn014b
end type
type st_daesang from statictext within w_rtn014b
end type
type st_55 from statictext within w_rtn014b
end type
type st_saeng from statictext within w_rtn014b
end type
type uo_1 from uo_progress_bar within w_rtn014b
end type
type dw_1 from datawindow within w_rtn014b
end type
type gb_1 from groupbox within w_rtn014b
end type
type gb_2 from groupbox within w_rtn014b
end type
end forward

global type w_rtn014b from w_origin_sheet06
integer width = 3657
integer height = 2100
st_1 st_1
cb_1 cb_1
sle_1 sle_1
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn014b w_rtn014b

type variables
dec i_n_complete
end variables

on w_rtn014b.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_a1
this.Control[iCurrent+5]=this.st_a2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_daesang
this.Control[iCurrent+8]=this.st_55
this.Control[iCurrent+9]=this.st_saeng
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_rtn014b.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_bretrieve;call super::ue_bretrieve;long   l_n_count

setpointer(HourGlass!)
dw_1.reset()
l_n_count = dw_1.importfile(sle_1.text)
st_daesang.text = string(l_n_count,"###,### ")

if l_n_count	  > 0 then
	i_b_bcreate	  = True
end if

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;dw_1.settransobject(sqlca) 
end event

event ue_bcreate;call super::ue_bcreate;decimal    l_n_totalcnt,l_n_loopcnt,l_n_count,l_n_errcount
string     l_s_plant,l_s_dvsn,l_s_itno,l_s_itno1, ls_chtime
integer    Net,l_n_chkcount,l_s_find

Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 1)
if Net <> 1 then
	return -1
end if

setpointer(HourGlass!)
dw_1.accepttext()

l_n_totalcnt = dw_1.rowcount()
uo_status.st_message.text = "자료 처리중(오류 확인중)..."

l_n_errcount = 0
do while true
	
	if l_n_loopcnt = l_n_totalcnt then 
		exit
	end if
	
	l_n_loopcnt ++
    dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	
	l_s_plant  = trim(dw_1.object.raplant[l_n_loopcnt])
	l_s_dvsn   = trim(dw_1.object.radvsn[l_n_loopcnt])
	l_s_itno   = trim(dw_1.object.raitno[l_n_loopcnt])
	l_s_itno1  = trim(dw_1.object.raitno1[l_n_loopcnt])
	
	if l_n_loopcnt > 1 then
		l_s_find = dw_1.find(" raplant = '" + l_s_plant + "'" & 
             		 	   + " and radvsn = '" + l_s_dvsn + "'" + " and raitno = '" + l_s_itno + "'"  &
			               + " and raitno1  = '" + l_s_itno1  + "'"  ,1,l_n_loopcnt - 1)
		if l_s_find > 0 then				   
			dw_1.setitem(l_n_loopcnt, "errortext", "중첩된 대표,유사품번이 존재합니다")
			l_n_errcount = l_n_errcount + 1
			continue
		end if	
	end if
	
	if f_spacechk(l_s_itno) = -1 then
		dw_1.setitem(l_n_loopcnt, "errortext", "대표품번이 입력되지 않았습니다.")
		l_n_errcount = l_n_errcount + 1
	else
		SELECT count(*) into :l_n_count from "PBPDM"."BOM001"
		  WHERE "PBPDM"."BOM001"."PLANT" = :l_s_plant AND "PBPDM"."BOM001"."PPITN" = :l_s_itno AND "PBPDM"."BOM001"."PDVSN" = :l_s_dvsn and
				  ( ("PBPDM"."BOM001"."PEDTM" <= "PBPDM"."BOM001"."PEDTE" AND "PBPDM"."BOM001"."PEDTE" <> ' ' AND "PBPDM"."BOM001"."PEDTE" >= :g_s_date )
                  OR  
              ( "PBPDM"."BOM001"."PEDTE" = ' ' AND "PBPDM"."BOM001"."PEDTM" <= :g_s_date ))
		  using SQLCA ;
		  if l_n_count <= 0 then
			  dw_1.setitem(l_n_loopcnt, "errortext", "대표품번이 BOM에 등록되지 않았습니다.")
			  l_n_errcount = l_n_errcount + 1
			end if
	end if
	if f_spacechk(l_s_itno1) = -1 then
		dw_1.setitem(l_n_loopcnt, "errortext", "유사품번이 입력되지 않았습니다.")
		l_n_errcount = l_n_errcount + 1
	else
  		SELECT count(*) into :l_n_count from "PBPDM"."BOM001"
		  WHERE "PBPDM"."BOM001"."PLANT" = :l_s_plant AND "PBPDM"."BOM001"."PPITN" = :l_s_itno1 AND "PBPDM"."BOM001"."PDVSN" = :l_s_dvsn and
				  ( ("PBPDM"."BOM001"."PEDTM" <= "PBPDM"."BOM001"."PEDTE" AND "PBPDM"."BOM001"."PEDTE" <> ' ' AND "PBPDM"."BOM001"."PEDTE" >= :g_s_date )
                  OR  
              ( "PBPDM"."BOM001"."PEDTE" = ' ' AND "PBPDM"."BOM001"."PEDTM" <= :g_s_date ))
		  using SQLCA ;
      if l_n_count <= 0 then
			  dw_1.setitem(l_n_loopcnt, "errortext", "유사품번이 BOM에 등록되지 않았습니다.")
			  l_n_errcount = l_n_errcount + 1
		end if 

	end if
	
	select count(*) into :l_n_count from pbrtn.rtn015
	where ( recmcd = :g_s_company and replant = :l_s_plant and redvsn = :l_s_dvsn and
	        reitno = :l_s_itno and reedto = '9999.12.31' ) 
	using sqlca ;
	if l_n_count < 1 then
		dw_1.setitem(l_n_loopcnt, "errortext", "대표품번 라우팅상세정보 미등록.")
		l_n_errcount = l_n_errcount + 1
	end if
	
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
	end if
loop

if l_n_errcount > 0 then
   uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.	
	return -1
end if

uo_status.st_message.text = "오류 없음. 저장중..."

ls_chtime = f_get_systemdate(sqlca)
SQLCA.AUTOCOMMIT = FALSE

for l_n_loopcnt = 1 to l_n_totalcnt
	l_s_plant  = trim(dw_1.object.raplant[l_n_loopcnt])
	l_s_dvsn   = trim(dw_1.object.radvsn[l_n_loopcnt])
	l_s_itno   = trim(dw_1.object.raitno[l_n_loopcnt])
	l_s_itno1  = trim(dw_1.object.raitno1[l_n_loopcnt])
	
	select count(*) into :l_n_count from pbrtn.rtn011
 	where racmcd = :g_s_company and raplant = :l_s_plant and 
			radvsn = :l_s_dvsn and raitno = :l_s_itno and 
			raitno1 = :l_s_itno1
	using sqlca;
	
	if l_n_count > 0 then
		update pbrtn.rtn011
		set rachtime = :ls_chtime, raepno = :g_s_empno, raipad = :g_s_ipaddr, 
			rasydt = :g_s_date, raflag = 'R',
			rainemp = :g_s_empno, rainchk = 'N', raintime = '',
			raplemp = '', raplchk = 'N', rapltime = '', 
			radlemp = '', radlchk = 'N', radltime = ''
		where racmcd = :g_s_company and raplant = :l_s_plant and 
			radvsn = :l_s_dvsn and raitno = :l_s_itno and 
			raitno1 = :l_s_itno1
		using sqlca;
		if sqlca.sqlnrows < 1 then
			dw_1.setitem(l_n_loopcnt, "errortext", "기존데이타수정에러")
			goto Rollback_
		end if
	else
		INSERT INTO "PBRTN"."RTN011"( "RACMCD","RAPLANT","RADVSN","RAITNO", "RAITNO1",   
		"RACHTIME", "RAEDFM", "RAEPNO", "RAIPAD", "RASYDT", 
		"RAINEMP", "RAINCHK", "RAINTIME",   
		"RAPLEMP", "RAPLCHK", "RAPLTIME",   
		"RADLEMP", "RADLCHK", "RADLTIME", "RAFLAG" )  
		VALUES ( '01', :l_s_plant, :l_s_dvsn, :l_s_itno, :l_s_itno1,
		:ls_chtime, '', :g_s_empno, :g_s_ipaddr, :g_s_date,
		:g_s_empno, 'N', '',
		'', 'N', '',
		'', 'N', '', 'A' )
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			dw_1.setitem(l_n_loopcnt, "errortext", "유사품번 입력에러")
			goto Rollback_
		end if
	end if
	
	COMMIT USING SQLCA;
	continue
	
	Rollback_:
	ROLLBACK USING SQLCA;
next

SQLCA.AUTOCOMMIT = TRUE

uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//저장이 되었습니다.

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

type uo_status from w_origin_sheet06`uo_status within w_rtn014b
integer y = 1832
integer width = 3685
integer height = 92
end type

type st_1 from statictext within w_rtn014b
integer x = 64
integer y = 40
integer width = 3456
integer height = 92
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  EXCEL 자료 LOAD  ◎"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rtn014b
integer x = 1010
integer y = 956
integer width = 302
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료경로"
end type

event clicked;string ls_pathname,ls_filename
GetFileOpenName("Select File", ls_pathname, ls_filename, "txt", "Text Files (*.txt),*.txt,")
sle_1.text = ls_pathname
end event

type sle_1 from singlelineedit within w_rtn014b
integer x = 1321
integer y = 956
integer width = 1266
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_a1 from statictext within w_rtn014b
integer x = 809
integer y = 1104
integer width = 2103
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "１.~'대상조회~'를 눌러 대상건수를 확인 하십시오."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_rtn014b
integer x = 805
integer y = 1184
integer width = 2103
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "２. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_rtn014b
integer x = 914
integer y = 1372
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대상건수"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_rtn014b
integer x = 1239
integer y = 1364
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_55 from statictext within w_rtn014b
integer x = 1966
integer y = 1372
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "생성건수"
boolean focusrectangle = false
end type

type st_saeng from statictext within w_rtn014b
integer x = 2295
integer y = 1364
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_rtn014b
event destroy ( )
integer x = 1120
integer y = 1648
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_rtn014b
integer x = 576
integer y = 200
integer width = 2853
integer height = 676
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_rtn014b_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;messagebox("DD",row)
end event

type gb_1 from groupbox within w_rtn014b
integer x = 832
integer y = 1276
integer width = 2011
integer height = 236
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_rtn014b
integer x = 832
integer y = 1552
integer width = 2011
integer height = 256
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[처리상태]"
end type

