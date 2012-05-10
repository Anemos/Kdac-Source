$PBExportHeader$w_comm261u.srw
$PBExportComments$공통코드 관리
forward
global type w_comm261u from w_origin_sheet01
end type
type dw_1 from datawindow within w_comm261u
end type
type dw_2 from datawindow within w_comm261u
end type
type dw_3 from datawindow within w_comm261u
end type
type st_1 from statictext within w_comm261u
end type
type sle_1 from singlelineedit within w_comm261u
end type
type sle_2 from singlelineedit within w_comm261u
end type
type st_2 from statictext within w_comm261u
end type
type gb_1 from groupbox within w_comm261u
end type
end forward

global type w_comm261u from w_origin_sheet01
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
st_1 st_1
sle_1 sle_1
sle_2 sle_2
st_2 st_2
gb_1 gb_1
end type
global w_comm261u w_comm261u

type variables
string i_s_selected, i_s_gb, i_s_cd, i_s_delete
end variables

forward prototypes
public subroutine wf_rgbclear ()
end prototypes

public subroutine wf_rgbclear ();dw_3.object.cogubun.background.color   = rgb(255,255,255)	//White
dw_3.object.cocode.background.color    = rgb(255,255,255)  
dw_3.object.coitname.background.color  = rgb(255,255,255)
dw_3.object.coitnamee.background.color = rgb(255,255,255)
dw_3.object.coflname.background.color  = rgb(255,255,255)
dw_3.object.coflnamee.background.color = rgb(255,255,255)
dw_3.object.coextend.background.color  = rgb(255,255,255)
dw_3.object.coeiscd.background.color   = rgb(255,255,255)
dw_3.object.cocdinwon.background.color = rgb(255,255,255)
dw_3.object.coadpdt.background.color   = rgb(255,255,255)
dw_3.object.coeddt.background.color    = rgb(255,255,255)
dw_3.object.extd.background.color    = rgb(255,255,255)
end subroutine

on w_comm261u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_1=create st_1
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.sle_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.gb_1
end on

on w_comm261u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.gb_1)
end on

event open;call super::open;Setpointer(hourglass!)

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_1.retrieve('          ', '9999999999')
dw_3.reset()

i_b_retrieve	=	true
i_b_insert   	= 	true
i_b_save     	= 	false
i_b_delete   	= 	false
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)

end event

event ue_insert;Setpointer(hourglass!)

uo_status.st_message.text	=  ""
wf_rgbclear()

dw_3.reset()
dw_3.insertrow(0)
dw_3.object.cogubun.protect	=	false
dw_3.object.cocode.protect 	= 	false
dw_3.object.comltd[1] 			= 	'01'
dw_3.object.cogubun[1] 			= 	i_s_gb
dw_3.object.cocode[1] 			= 	i_s_cd
dw_3.setcolumn("cogubun")
dw_3.setfocus()

i_s_selected = "i"

i_b_insert   		= 	True
i_b_save     		= 	True
i_b_delete   		= 	false
i_b_dretrieve  	=  False

wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)

end event

event ue_retrieve;call super::ue_retrieve;String		ls_frcd, ls_tocd

Setpointer(hourglass!)

ls_frcd	= 	sle_1.text
ls_tocd 	= 	sle_2.text
if 	f_spacechk(ls_frcd) = -1 then
	ls_frcd = '          '
end if
if 	f_spacechk(ls_tocd) = -1 then
	ls_tocd = '9999999999'
end if

dw_1.retrieve(ls_frcd, ls_tocd)
dw_2.reset()
dw_3.reset()

uo_status.st_message.text	=	f_message("I010")

i_b_retrieve 	= 	true
i_b_insert   	= 	true
i_b_save     	= 	false
i_b_delete   	= 	false
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)
	  

end event

event ue_save;call super::ue_save;String 	ls_cdgb, ls_cdcd, ls_column, ls_frcd, ls_tocd, &
       		ls_nm1, ls_nm2, ls_dt1, ls_dt2, ls_nm3, ls_nm4
Integer    ln_rowcount, ln_findrow, ln_rcnt

Setpointer(hourglass!)

uo_status.st_message.text	=  ""
wf_rgbclear()

ls_frcd	=	sle_1.text
ls_tocd 	= 	sle_2.text
if 	f_spacechk(ls_frcd) = -1 then
	ls_frcd = '          '
end if
if 	f_spacechk(ls_tocd) = -1 then
	ls_tocd = '9999999999'
end if

dw_3.accepttext()
ls_cdgb 	= 	dw_3.object.cogubun[1]
ls_cdcd 	= 	dw_3.object.cocode[1]
if 	i_s_selected = 'i' then
	if 	f_spacechk(ls_cdgb) = -1 then
		dw_3.object.cogubun.Background.Color = rgb(255,255,0)
		if 	len(ls_column) < 1 then	
			ls_column	=	"cogubun"		
		end if
	else
		if 	ls_cdgb <> 'DAC000' then
			SELECT count(*) 	INTO :ln_rcnt		
			FROM   "PBCOMMON"."DAC002"  
			WHERE  "PBCOMMON"."DAC002"."COMLTD"  = '01'     and
					 "PBCOMMON"."DAC002"."COGUBUN" = 'DAC000' and
					 "PBCOMMON"."DAC002"."COCODE"  = :ls_cdgb USING sqlca ;	
			if 	ln_rcnt < 1 then
				dw_3.object.cogubun.Background.Color = rgb(255,255,0)
				ls_column = "cogubun"
			end if
		end if
	end if
	if 	f_spacechk(ls_cdcd) = -1 then
		dw_3.object.cocode.Background.Color = rgb(255,255,0)
		if 	len(ls_column) < 1 then	
			ls_column	=	"cocode"		
		end if	
	end if
	SELECT count(*) 	INTO :ln_rcnt		
	FROM   	"PBCOMMON"."DAC002"  
	WHERE  	"PBCOMMON"."DAC002"."COMLTD"  = '01'     and
			 	"PBCOMMON"."DAC002"."COGUBUN" = :ls_cdgb and
	       		"PBCOMMON"."DAC002"."COCODE"  = :ls_cdcd Using sqlca ;	
	if 	ln_rcnt > 0 then
		uo_status.st_message.text = "입력할 자료가 이미 존재합니다." 
		dw_3.object.cogubun.Background.Color = rgb(255,255,0)
		dw_3.object.cocode.Background.Color = rgb(255,255,0)
		ls_column = "cogubun"
		return
	end if
end if
ls_nm1	=	trim(mid(dw_3.object.coitname[1], 1, 20))
if 	f_spacechk(ls_nm1) = -1 then
	ls_nm1 = ' '
end if
if 	f_spacechk(dw_3.object.coitname[1]) = -1 then
	dw_3.object.coitname.Background.Color = rgb(255,255,0)
	if 	len(ls_column) < 1 then	
		ls_column	=	"coitname"		
	end if	
end if
ls_nm2	=	trim(dw_3.object.coflname[1])
if 	f_spacechk(ls_nm2) = -1 then
	ls_nm2 = ' '
end if
if 	f_spacechk(dw_3.object.coflname[1]) = -1 then
	dw_3.object.coflname.Background.Color = rgb(255,255,0)
	if 	len(ls_column) < 1 then	
		ls_column	=	"coflname"		
	end if	
end if
ls_dt1 = dw_3.object.coadpdt[1]
if 	f_dateedit(dw_3.object.coadpdt[1]) = '        ' then
	dw_3.object.coadpdt.Background.Color = rgb(255,255,0)
	if 	len(ls_column) < 1 then	
		ls_column	=	"coadpdt"		
	end if	
end if
ls_dt2 = dw_3.object.coeddt[1]
if 	f_spacechk(dw_3.object.coeddt[1]) <> -1 then
	if 	f_dateedit(dw_3.object.coeddt[1]) = '        ' then
		dw_3.object.coeddt.Background.Color = rgb(255,255,0)
		if 	len(ls_column) < 1 then	
			ls_column	=	"coeddt"		
		end if	
	end if	
end if
ls_nm3 = trim(mid(dw_3.object.coitnamee[1], 1, 20))
if 	f_spacechk(ls_nm3) = -1 then
	ls_nm3 = ' '
end if
ls_nm4 = trim(dw_3.object.coflnamee[1])
if 	f_spacechk(ls_nm4) = -1 then
	ls_nm4 = ' '
end if

if 	len(ls_column) > 0 then
	dw_3.setcolumn(ls_column)
	dw_3.setfocus()
	uo_status.st_message.text	=	"노랑색 항목을 수정 후 처리바랍니다."	
	i_n_erreturn = -1
	return
end if
if 	i_s_selected = "r" and dw_3.ModifiedCount() = 0 then
	dw_3.setfocus()
	uo_status.st_message.text  =	f_message("E020")		// 변경내용이 없습니다.
	return
end if
f_sysdate()
if 	i_s_selected = "i" then
	dw_3.object.inptid[1] 	= 	g_s_empno
	dw_3.object.inptdt[1]	= 	g_s_datetime
end if
dw_3.object.updtid[1] 	= 	g_s_empno
dw_3.object.updtdt[1] 	= 	g_s_datetime
dw_3.object.ipaddr[1] 	= 	g_s_ipaddr
dw_3.object.macaddr[1]	= 	g_s_macaddr
if 	dw_3.update() = 1 then
   	commit using sqlca;
	i_s_selected = ' '
	ln_rowcount = 	dw_1.retrieve(ls_frcd, ls_tocd)
	ln_findrow  	= 	dw_1.find("cocode = '" + ls_cdgb + "' ", 1 , ln_rowcount)
	if 	ln_findrow > 0 then
		dw_1.scrolltorow(ln_findrow)
		dw_1.selectrow(0,false)
		dw_1.selectrow(ln_findrow,true)
	end if
	ln_rowcount	=	dw_2.retrieve(ls_cdgb)
	ln_findrow  	= 	dw_2.find("cocode = '" + ls_cdcd + "' ", 1 , ln_rowcount)
	if 	ln_findrow > 0 then
		dw_2.scrolltorow(ln_findrow)
		dw_2.selectrow(0,false)
		dw_2.selectrow(ln_findrow,true)
	end if
else
	i_n_erreturn = -1
	rollback using 	SQLCA;
	if 	i_s_selected	=	"i"	then
	   	uo_status.st_message.text 	= 	"[입력실패] 개발자에게로 연락바랍니다." 
	else
	   	uo_status.st_message.text	= 	"[저장실패] 개발자에게로 연락바랍니다." 
	end if	
end if

end event

event ue_delete;call super::ue_delete;Setpointer(hourglass!)

Integer    ln_rcnt
Long   	ll_row
String 	ls_cdgb

uo_status.st_message.text	=  ""

if 	i_s_delete = 'Y' then
	uo_status.st_message.text	=  "해당코드 삭제불가(해당코드 기 사용)" 
	return
end if

ln_rcnt = messagebox("삭제 확인","해당자료를 정말 삭제 하시겠습니까?",Question!,OkCancel!,2)
if 	ln_rcnt <> 1  then
	Return
end if

ll_row  	= 	dw_3.getrow()
ls_cdgb 	=	dw_3.object.cogubun[ll_row]
dw_3.deleterow(ll_row)
if 	dw_3.update() = 1 then
	commit using sqlca;
	uo_status.st_message.text	=  "삭제되었습니다."
	dw_3.reset()
	dw_2.retrieve(ls_cdgb)
else
	rollback using sqlca;
	uo_status.st_message.text	=  "[삭제실패] 개발자에게로 연락바랍니다." 
end if	

i_b_retrieve		=	true
i_b_insert		=	True
i_b_save			=	False
i_b_delete		=	false
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              			i_b_dprint,   i_b_dchar)

end event

type uo_status from w_origin_sheet01`uo_status within w_comm261u
integer y = 2464
end type

type dw_1 from datawindow within w_comm261u
integer x = 14
integer y = 160
integer width = 1257
integer height = 1552
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm261u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String  ls_cdcd

this.selectrow(0, false)
this.selectrow(row, true)
ls_cdcd = this.getitemstring(row, "cocode")

dw_2.reset()
dw_3.reset()
dw_2.retrieve(ls_cdcd)
dw_3.retrieve('DAC000', ls_cdcd)

i_s_delete = 'N'
dw_3.object.cogubun.protect = true
if 	i_s_delete = 'N' then
	dw_3.object.cocode.protect = true
	dw_3.setcolumn('coitname')
else
	dw_3.object.cocode.protect = false
	dw_3.setcolumn('cocode')
end if

dw_3.setfocus()
dw_3.setrow(1)

i_s_selected = "r"
uo_status.st_message.text	=  " "
		
i_b_save		=	True
i_b_delete	=	true
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  	i_b_dprint,   i_b_dchar)
end event

type dw_2 from datawindow within w_comm261u
integer x = 1280
integer y = 160
integer width = 3323
integer height = 1552
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm261u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String  	ls_cdgb, ls_cdcd
Integer    ln_rcnt

this.selectrow(0, false)
this.selectrow(row, true)

ls_cdgb = this.getitemstring(row, "cogubun")
ls_cdcd = this.getitemstring(row, "cocode")

dw_3.reset()
dw_3.retrieve(ls_cdgb, ls_cdcd)

i_s_delete = 'N'
dw_3.object.cogubun.protect = true
if 	i_s_delete = 'N' then
	dw_3.object.cocode.protect = true
	dw_3.setcolumn('coitname')
else
	dw_3.object.cocode.protect = false
	dw_3.setcolumn('cocode')
end if

dw_3.setfocus()
dw_3.setrow(1)

i_s_selected	=	"r"
uo_status.st_message.text	=  " "
		
i_b_save		=	True
i_b_delete	=	true
wf_icon_onoff(	i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  	i_b_dprint,   i_b_dchar)
end event

type dw_3 from datawindow within w_comm261u
integer y = 1724
integer width = 4608
integer height = 716
boolean bringtotop = true
string title = "none"
string dataobject = "d_comm261u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_comm261u
integer x = 50
integer y = 60
integer width = 293
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회대상"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_comm261u
integer x = 347
integer y = 48
integer width = 366
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event getfocus;f_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

type sle_2 from singlelineedit within w_comm261u
event ue_downkey pbm_dwnkey
event ue_down_key pbm_keydown
integer x = 805
integer y = 48
integer width = 366
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event ue_downkey;//If key = KeyEnter! Then
//	parent.TriggerEvent('ue_retrieve')	
//End If
end event

event ue_down_key;If key = KeyEnter! Then
	parent.TriggerEvent('ue_retrieve')	
End If
end event

event getfocus;f_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

type st_2 from statictext within w_comm261u
integer x = 741
integer y = 64
integer width = 46
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "-"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_comm261u
integer x = 14
integer width = 1253
integer height = 156
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

