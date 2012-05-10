$PBExportHeader$w_qctl103b.srw
$PBExportComments$주재원과거 data 생성
forward
global type w_qctl103b from w_origin_sheet06
end type
type gb_2 from groupbox within w_qctl103b
end type
type gb_1 from groupbox within w_qctl103b
end type
type st_1 from statictext within w_qctl103b
end type
type st_a1 from statictext within w_qctl103b
end type
type st_a2 from statictext within w_qctl103b
end type
type st_3 from statictext within w_qctl103b
end type
type st_daesang from statictext within w_qctl103b
end type
type st_55 from statictext within w_qctl103b
end type
type st_saeng from statictext within w_qctl103b
end type
type uo_1 from uo_progress_bar within w_qctl103b
end type
type dw_1 from datawindow within w_qctl103b
end type
type cb_1 from commandbutton within w_qctl103b
end type
type sle_1 from singlelineedit within w_qctl103b
end type
end forward

global type w_qctl103b from w_origin_sheet06
gb_2 gb_2
gb_1 gb_1
st_1 st_1
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
end type
global w_qctl103b w_qctl103b

type variables
dec i_n_complete
end variables

on w_qctl103b.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_a1
this.Control[iCurrent+5]=this.st_a2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_daesang
this.Control[iCurrent+8]=this.st_55
this.Control[iCurrent+9]=this.st_saeng
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.sle_1
end on

on w_qctl103b.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
end on

event ue_bretrieve;long   l_n_count

setpointer(HourGlass!)

l_n_count = dw_1.importfile(sle_1.text)
st_daesang.text = string(l_n_count,"###,### ")

if l_n_count	  > 0 then
	i_b_bcreate	  = True
end if

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event ue_bcreate;setpointer(HourGlass!)
string l_s_shop_cd, l_s_save_shop_cd, l_s_car_cd, l_s_itno
int	 Net
long   l_n_ser_no, l_n_totalcnt, l_n_loopcnt, l_n_count

dw_1.accepttext()
Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 2)
if Net <> 1 then
	return
end if

l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "자료 처리중 ..."

do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
   l_s_shop_cd = dw_1.object.shop_cd[l_n_loopcnt]
   l_s_car_cd  = dw_1.object.car_cd[l_n_loopcnt]
	l_s_itno    = dw_1.object.itno[l_n_loopcnt]
	
	select count(*) into :l_n_count from comm210 
	 where comm_rpst = 'A03' and
	       comm_deta = :l_s_shop_cd using sqlcs;
	if isnull(l_n_count) or l_n_count = 0 then
		messagebox("자료 오류","정비소 코드 오류=" + l_s_shop_cd)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.		
		return
	end if
	
	select count(*) into :l_n_count from comm210 
	 where comm_rpst = 'A01' and
	       comm_deta = :l_s_car_cd using sqlcs;
	if isnull(l_n_count) or l_n_count = 0 then
		messagebox("자료 오류","차종 오류=" + l_s_car_cd)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.				
		return
	end if

	select count(*) into :l_n_count from comm210 
	 where comm_rpst = 'A02' and
	       comm_deta = :l_s_itno using sqlcs;
	if isnull(l_n_count) or l_n_count = 0 then
		messagebox("자료 오류","제품명 코드 오류=" + l_s_itno)
      uo_status.st_message.text = f_message("E310")		//자료를 수정후 처리바랍니다.				
		return
	end if	
	
	if l_s_shop_cd <> l_s_save_shop_cd then
		select max(ser_no) into :l_n_ser_no 
		  from main100 
		 where shop_cd = :l_s_shop_cd using sqlcs;
		if isnull(l_n_ser_no) then
			l_n_ser_no = 1
		else
			l_n_ser_no ++
		end if
		l_s_save_shop_cd = l_s_shop_cd
	else
		l_n_ser_no ++
	end if	
   dw_1.object.ser_no[l_n_loopcnt] = l_n_ser_no 
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

dw_1.settransobject(sqlcs)
if dw_1.update() = 1 then
   commit using sqlcs ;
else	
   rollback using sqlcs;
end if	

uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//저장이 되었습니다.

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;string l_s_yy, l_s_shtm
connect using sqlcs;

end event

event close;call super::close;disconnect using sqlcs;
end event

type uo_status from w_origin_sheet06`uo_status within w_qctl103b
end type

type gb_2 from groupbox within w_qctl103b
integer x = 805
integer y = 1536
integer width = 2011
integer height = 256
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

type gb_1 from groupbox within w_qctl103b
integer x = 805
integer y = 1236
integer width = 2011
integer height = 236
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type st_1 from statictext within w_qctl103b
integer x = 1207
integer y = 60
integer width = 1477
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  EXCEL 자료 LOAD  ◎"
boolean focusrectangle = false
end type

type st_a1 from statictext within w_qctl103b
integer x = 549
integer y = 1028
integer width = 2130
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
string text = "１. ~'대상조회~'를 눌러 대상건수를 확인 하십시오."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_qctl103b
integer x = 549
integer y = 1120
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

type st_3 from statictext within w_qctl103b
integer x = 974
integer y = 1332
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

type st_daesang from statictext within w_qctl103b
integer x = 1298
integer y = 1316
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

type st_55 from statictext within w_qctl103b
integer x = 1925
integer y = 1332
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

type st_saeng from statictext within w_qctl103b
integer x = 2245
integer y = 1316
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

type uo_1 from uo_progress_bar within w_qctl103b
event destroy ( )
integer x = 1070
integer y = 1624
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_qctl103b
integer x = 233
integer y = 168
integer width = 3195
integer height = 648
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_qctl103b_01"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_qctl103b
integer x = 622
integer y = 848
integer width = 302
integer height = 92
integer taborder = 20
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
GetFileOpenName("Select File", ls_pathname, ls_filename, "txt", "Text Files (*.TXT),*.TXT,")
sle_1.text = ls_pathname
end event

type sle_1 from singlelineedit within w_qctl103b
integer x = 942
integer y = 848
integer width = 1266
integer height = 92
integer taborder = 30
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

