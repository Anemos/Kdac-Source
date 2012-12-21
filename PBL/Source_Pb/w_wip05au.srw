$PBExportHeader$w_wip05au.srw
$PBExportComments$업체보관증생성
forward
global type w_wip05au from w_origin_sheet04
end type
type uo_2 from uo_yymm_boongi within w_wip05au
end type
type st_1 from statictext within w_wip05au
end type
type cb_1 from commandbutton within w_wip05au
end type
type dw_3 from datawindow within w_wip05au
end type
type dw_1 from datawindow within w_wip05au
end type
type st_2 from statictext within w_wip05au
end type
type st_3 from statictext within w_wip05au
end type
type pb_1 from picturebutton within w_wip05au
end type
type st_4 from statictext within w_wip05au
end type
type em_vndr from editmask within w_wip05au
end type
type pb_2 from picturebutton within w_wip05au
end type
type sle_vndnm from singlelineedit within w_wip05au
end type
type gb_1 from groupbox within w_wip05au
end type
end forward

global type w_wip05au from w_origin_sheet04
uo_2 uo_2
st_1 st_1
cb_1 cb_1
dw_3 dw_3
dw_1 dw_1
st_2 st_2
st_3 st_3
pb_1 pb_1
st_4 st_4
em_vndr em_vndr
pb_2 pb_2
sle_vndnm sle_vndnm
gb_1 gb_1
end type
global w_wip05au w_wip05au

forward prototypes
public subroutine wf_create_format ()
end prototypes

public subroutine wf_create_format ();string ls_lastdt, ls_firstdt, ls_yyyy, ls_mm, ls_part
string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_itnm, ls_unit
string ls_vndr, ls_vndnm, ls_chkorct, ls_addr, ls_prnm
string ls_chkvndr, ls_chkvndnm, ls_chkaddr, ls_chkprnm, ls_fdate, ls_ldate
dec{2} lc_scrp, lc_retn
dec{4} lc_convqty
long ll_cnt, ll_rowcnt, ll_currow, ll_pagecnt, ll_orctcnt

setpointer(hourglass!)

ls_lastdt = string(uo_2.uf_yyyymm())
ls_yyyy = mid(ls_lastdt,1,4)
ls_mm = mid(ls_lastdt,5,2)
choose case ls_mm
	case '03'
		ls_part = '1'
		ls_firstdt = ls_yyyy + '01'
		ls_fdate = ls_yyyy + '0101'
		ls_ldate = f_relativedate(ls_yyyy + '0401',-1)
	case '06'
		ls_part = '2'
		ls_firstdt = ls_yyyy + '04'
		ls_fdate = ls_yyyy + '0401'
		ls_ldate = f_relativedate(ls_yyyy + '0701',-1)
	case '09'
		ls_part = '3'
		ls_firstdt = ls_yyyy + '07'
		ls_fdate = ls_yyyy + '0701'
		ls_ldate = f_relativedate(ls_yyyy + '1001',-1)
	case '12'
		ls_part = '4'
		ls_firstdt = ls_yyyy + '10'
		ls_fdate = ls_yyyy + '1001'
		ls_ldate = f_relativedate(uf_wip_addmonth(ls_yyyy + '12',1) + '01',-1)
end choose
ls_lastdt = uf_wip_addmonth(ls_lastdt,-1)
//크로스체크, 수불체크를 통한 기준일까지의 업체사용수량 확정

//분기내의 이월DB데이타와 현재월의 밸런스DB데이타 비교( 업체재공의 투입이나 사용이 있는 품번 )
ll_rowcnt = dw_3.rowcount()
ls_chkorct = dw_3.getitemstring(1,"wfvsrno")
ll_pagecnt = 1
ll_orctcnt = 1
for ll_cnt = 1 to ll_rowcnt
	ls_plant = dw_3.getitemstring(ll_cnt,"wfplant")
	ls_dvsn = dw_3.getitemstring(ll_cnt,"wfdvsn")
	ls_itno = dw_3.getitemstring(ll_cnt,"wfitno")
	ls_orct = dw_3.getitemstring(ll_cnt,"wfvsrno")
	
	if ls_chkorct = ls_orct then
		ll_orctcnt = ll_orctcnt + 1
		if mod(ll_orctcnt,16) = 0 then
			ll_pagecnt = ll_pagecnt + 1
		end if
	else
		ll_orctcnt = ll_orctcnt + 1
		ls_chkvndr = dw_3.getitemstring(ll_cnt - 1 , "wfvndr")
		ls_chkvndnm = dw_3.getitemstring(ll_cnt - 1, "wfvndnm")
		ls_chkaddr = dw_3.getitemstring(ll_cnt - 1, "wfaddr")
		ls_chkprnm = dw_3.getitemstring(ll_cnt - 1, "wfprnm")
//		SELECT "PBPUR"."PUR101"."VNDR",   
//				 "PBPUR"."PUR101"."VNDNM", 
//				 "PBPUR"."PUR101"."ADDR",
//				 "PBPUR"."PUR101"."PRNM"
//			INTO :ls_chkvndr,   
//				  :ls_chkvndnm,
//				  :ls_chkaddr,
//				  :ls_chkprnm
//			FROM "PBPUR"."PUR101"  
//			WHERE ( "PBPUR"."PUR101"."COMLTD" = :g_s_company ) AND 
//					( "PBPUR"."PUR101"."SCGUBUN" = 'S' ) AND
//					( "PBPUR"."PUR101"."VSRNO" = :ls_chkorct ) 
//					using sqlca  ;
		do while mod(ll_orctcnt,16) <> 0 
			ll_currow = dw_1.insertrow(0)
			dw_1.setitem(ll_currow,"wfcmcd", g_s_company)
			dw_1.setitem(ll_currow,"wfyear", ls_yyyy)
			dw_1.setitem(ll_currow,"wfpart", ls_part)
			dw_1.setitem(ll_currow,"wfiocd", '2')
			dw_1.setitem(ll_currow,"wfserl", ' ')
			dw_1.setitem(ll_currow,"wfpage", string(ll_pagecnt))
			dw_1.setitem(ll_currow,"wfplant", ' ')
			dw_1.setitem(ll_currow,"wfdvsn", ' ')
			dw_1.setitem(ll_currow,"wfvsrno", ls_chkorct)
			dw_1.setitem(ll_currow,"wfvndnm", ls_chkvndnm)
			dw_1.setitem(ll_currow,"wfvndr", ls_chkvndr)
			dw_1.setitem(ll_currow,"wfaddr", ls_chkaddr)
			dw_1.setitem(ll_currow,"wfprnm", ls_chkprnm)
			dw_1.setitem(ll_currow,"wfitnm", ' ')
			dw_1.setitem(ll_currow,"wfitno", ' ')
			dw_1.setitem(ll_currow,"wfunit", ' ')
			dw_1.setitem(ll_currow,"wfretn", 0)
			dw_1.setitem(ll_currow,"wfscrp", 0)
			dw_1.setitem(ll_currow,"wfbgqt", 0)
			dw_1.setitem(ll_currow,"wfinqt", 0) 
			dw_1.setitem(ll_currow,"wfusqt2", 0) 
			dw_1.setitem(ll_currow,"wfusqt7", 0)
			dw_1.setitem(ll_currow,"wfohqt", 0) 
			dw_1.setitem(ll_currow,"ohqt1", 0)
			dw_1.setitem(ll_currow,"wfinptid",' ')
			dw_1.setitem(ll_currow,"wfinptdt",' ')
			dw_1.setitem(ll_currow,"fdate",ls_fdate)
			dw_1.setitem(ll_currow,"ldate",ls_ldate)
			ll_orctcnt = ll_orctcnt + 1
		loop
		
		ls_chkorct = ls_orct
		ll_pagecnt = 1
		ll_orctcnt = 1
	end if
	ll_currow = dw_1.insertrow(0)
	dw_1.setitem(ll_currow,"wfcmcd", dw_3.getitemstring(ll_cnt,"wfcmcd"))
	dw_1.setitem(ll_currow,"wfyear", dw_3.getitemstring(ll_cnt,"wfyear"))
	dw_1.setitem(ll_currow,"wfpart", dw_3.getitemstring(ll_cnt,"wfpart"))
	dw_1.setitem(ll_currow,"wfiocd", dw_3.getitemstring(ll_cnt,"wfiocd"))
	dw_1.setitem(ll_currow,"wfserl", dw_3.getitemstring(ll_cnt,"wfserl"))
	dw_1.setitem(ll_currow,"wfpage", string(ll_pagecnt))
	dw_1.setitem(ll_currow,"wfplant", dw_3.getitemstring(ll_cnt,"wfplant"))
	dw_1.setitem(ll_currow,"wfdvsn", dw_3.getitemstring(ll_cnt,"wfdvsn"))
	dw_1.setitem(ll_currow,"wfvsrno", dw_3.getitemstring(ll_cnt,"wfvsrno"))
	dw_1.setitem(ll_currow,"wfvndnm", dw_3.getitemstring(ll_cnt,"wfvndnm"))
	dw_1.setitem(ll_currow,"wfvndr", dw_3.getitemstring(ll_cnt,"wfvndr"))
	dw_1.setitem(ll_currow,"wfaddr", dw_3.getitemstring(ll_cnt,"wfaddr"))
	dw_1.setitem(ll_currow,"wfprnm", dw_3.getitemstring(ll_cnt,"wfprnm"))
	dw_1.setitem(ll_currow,"wfitnm", dw_3.getitemstring(ll_cnt,"wfitnm"))
	dw_1.setitem(ll_currow,"wfitno", dw_3.getitemstring(ll_cnt,"wfitno"))
	dw_1.setitem(ll_currow,"wfunit", dw_3.getitemstring(ll_cnt,"wfunit"))
	dw_1.setitem(ll_currow,"wfretn", dw_3.getitemdecimal(ll_cnt,"wfretn"))
	dw_1.setitem(ll_currow,"wfscrp", dw_3.getitemdecimal(ll_cnt,"wfscrp"))
	dw_1.setitem(ll_currow,"wfbgqt", dw_3.getitemdecimal(ll_cnt,"wfbgqt"))
	dw_1.setitem(ll_currow,"wfinqt", 0)
	dw_1.setitem(ll_currow,"wfusqt2", 0)
	dw_1.setitem(ll_currow,"wfusqt7", 0)
	dw_1.setitem(ll_currow,"wfohqt", 0)
	dw_1.setitem(ll_currow,"ohqt1", 0)
	dw_1.setitem(ll_currow,"wfinptid",g_s_empno)
	dw_1.setitem(ll_currow,"wfinptdt",g_s_date)
	dw_1.setitem(ll_currow,"fdate",ls_fdate)
	dw_1.setitem(ll_currow,"ldate",ls_ldate)
next
end subroutine

on w_wip05au.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_1=create dw_1
this.st_2=create st_2
this.st_3=create st_3
this.pb_1=create pb_1
this.st_4=create st_4
this.em_vndr=create em_vndr
this.pb_2=create pb_2
this.sle_vndnm=create sle_vndnm
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.em_vndr
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.sle_vndnm
this.Control[iCurrent+13]=this.gb_1
end on

on w_wip05au.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.pb_1)
destroy(this.st_4)
destroy(this.em_vndr)
destroy(this.pb_2)
destroy(this.sle_vndnm)
destroy(this.gb_1)
end on

event open;call super::open;string ls_stdt

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

//해당정산년월 체크
select wzstdt into :ls_stdt
from pbwip.wip090
where wzcmcd = :g_s_company and wzplant = 'D' and wzcttp = 'WIPA'
using sqlca;

uo_2.uf_reset(integer(mid(ls_stdt,1,4)),integer(mid(ls_stdt,5,2)))
uo_2.event post ue_modify(integer(mid(ls_stdt,1,4)),integer(mid(ls_stdt,5,2)))

// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false,  false, false, false, false, false,false)


end event

event ue_print;call super::ue_print;long ll_rowcnt, ll_cnt
window 	l_to_open
str_easy l_str_prt

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_1.reset()
ll_rowcnt = dw_3.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
else
	//보관증 인쇄화면 생성
	wf_create_format()
end if

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_1
l_str_prt.dwsyntax = ' '
l_str_prt.title = "무상사급보관증"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

event ue_retrieve;call super::ue_retrieve;string ls_lastdt, ls_yyyy, ls_mm, ls_part, ls_vndr, ls_vsrno, ls_vndnm
long ll_rowcnt

ls_lastdt = string(uo_2.uf_yyyymm())
ls_yyyy = mid(ls_lastdt,1,4)
ls_mm = mid(ls_lastdt,5,2)
choose case ls_mm
	case '03'
		ls_part = '1'
	case '06'
		ls_part = '2'
	case '09'
		ls_part = '3'
	case '12'
		ls_part = '4'
end choose

em_vndr.getdata(ls_vndr)
	
if f_spacechk(ls_vndr) <> -1 then
	select vsrno,vndnm into:ls_vsrno, :ls_vndnm from pbpur.pur101
		where comltd = :g_s_company and vsrno = :ls_vndr and scgubun = 'S'
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "업체전산번호가 잘못 입력되었습니다."
		return 0
	end if
	ls_vsrno = ls_vsrno + '%'
	sle_vndnm.text = ls_vndnm
else
	ls_vsrno = '%'
end if


ll_rowcnt = dw_3.retrieve(g_s_company,ls_yyyy,ls_part,ls_vsrno)

if ll_rowcnt > 0 then
	uo_status.st_message.text = "조회되었습니다."
	
	// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true, true, false,  false, false, false, false, false,false)
else
	uo_status.st_message.text = "조회할 자료가 없습니다."
end if


end event

type uo_status from w_origin_sheet04`uo_status within w_wip05au
end type

type uo_2 from uo_yymm_boongi within w_wip05au
integer x = 425
integer y = 64
integer taborder = 20
boolean bringtotop = true
end type

on uo_2.destroy
call uo_yymm_boongi::destroy
end on

event ue_modify;call super::ue_modify;string ls_lastdt,ls_stdt, ls_vstscd, ls_yyyy, ls_mm, ls_part
long ll_rowcnt
ls_lastdt = string(uo_2.uf_yyyymm())
ls_yyyy = mid(ls_lastdt,1,4)
ls_mm = mid(ls_lastdt,5,2)

//해당정산년월 체크
select wzstdt, wzvstscd into :ls_stdt,:ls_vstscd
from pbwip.wip090
where wzcmcd = :g_s_company and wzplant = 'D' and wzcttp = 'WIPA'
using sqlca;

if sqlca.sqlcode = 0 and ls_stdt = ls_lastdt then
	if ls_vstscd = '2' then
		//사급보관증 데이타가 생성되었는지 유무
		select ifnull(count(*),0) into :ll_rowcnt 
			from pbwip.wip009
			where wfcmcd = :g_s_company and wfyear = :ls_yyyy and
			      wfmonth = :ls_mm and wfstscd <> ' ' using sqlca;
		if sqlca.sqlcode = 0 and ll_rowcnt > 0 then
			cb_1.enabled = false
			st_3.text = '생성완료'
		else
			if ls_stdt <= mid(g_s_date,1,6) then
				cb_1.enabled = true
				st_3.text = '생성가능'
			else
				cb_1.enabled = false
				st_3.text = '진행불가'
			end if
		end if
	else
		cb_1.enabled = false
		st_3.text = '생성완료'
	end if
else
	cb_1.enabled = false
	if ls_stdt < ls_lastdt then
		st_3.text = '진행불가'
	else
		st_3.text = '생성완료'
	end if
end if

end event

type st_1 from statictext within w_wip05au
integer x = 82
integer y = 76
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "정산년월"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_wip05au
integer x = 3593
integer y = 64
integer width = 471
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "데이타생성"
end type

event clicked;string ls_lastdt,ls_yyyy, ls_mm, ls_eddt, ls_part

if g_s_empno <> 'ADMIN' then
	uo_status.st_message.text = '권한이 없습니다.'
	return 0
end if

uo_status.st_message.text = "데이타 생성중입니다..."
setpointer(hourglass!)

ls_lastdt = string(uo_2.uf_yyyymm())
ls_yyyy = mid(ls_lastdt,1,4)
ls_mm = mid(ls_lastdt,5,2)

choose case ls_mm
	case '03'
		ls_part = '1'
	case '06'
		ls_part = '2'
	case '09'
		ls_part = '3'
	case '12'
		ls_part = '4'
end choose

//마감월 가져오기
select wzeddt into :ls_eddt
from pbwip.wip090
where wzcmcd = '01' and wzplant = 'D' and
		wzcttp = 'WIPA' using sqlca;
		
if ls_lastdt <> ls_eddt then
	uo_status.st_message.text = "보관증 Creation작업을 할수 없습니다."
	return 0
end if

// 업체정상 중간 DB(wip009) 와 사급보관증(wip008) 데이타 삭제
delete from pbwip.wip009
where wfcmcd = '01' and wfyear = :ls_yyyy and
		wfmonth = :ls_mm
		using sqlca;
		
delete from pbwip.wip008
where wfcmcd = '01' and wfyear = :ls_yyyy and
		wfpart = :ls_part
		using sqlca;
		
DECLARE up_wip_023 PROCEDURE FOR PBWIP.SP_WIP_023  
         A_CMCD = :g_s_company,   
         A_YEAR = :ls_yyyy,   
         A_MONTH = :ls_mm,   
         A_IPADDR = :g_s_ipaddr,   
         A_MACADDR = :g_s_macaddr,   
         A_INPTDT = :g_s_date,   
         A_UPDTDT = :g_s_date  ;
			
execute up_wip_023;

if sqlca.sqlcode = -1 then
	messagebox("생성실패", sqlca.sqlerrtext)
	return 0
end if

DECLARE up_wip_021 PROCEDURE FOR PBWIP.SP_WIP_021  
         A_CMCD = :g_s_company,   
         A_YYYY = :ls_yyyy,   
         A_MM = :ls_mm,   
         A_INPTID = :g_s_empno,   
         A_INPTDT = :g_s_date  ;

execute up_wip_021;
if sqlca.sqlcode = -1 then
	messagebox( "업데이트실패", sqlca.sqlerrtext)
	return 0
end if

cb_1.enabled = false
st_3.text = '생성완료'

window l_s_wsheet
l_s_wsheet = w_frame.GetActiveSheet()
l_s_wsheet.TriggerEvent("ue_retrieve")

return 0


	
end event

type dw_3 from datawindow within w_wip05au
integer x = 23
integer y = 232
integer width = 4562
integer height = 2240
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip057i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_wip05au
boolean visible = false
integer x = 4443
integer y = 56
integer width = 101
integer height = 108
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip057i_03_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_wip05au
integer x = 2720
integer y = 76
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "진행상태"
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip05au
integer x = 3035
integer y = 68
integer width = 453
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "진행중"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_wip05au
integer x = 4288
integer y = 48
integer width = 155
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
end type

event clicked;f_save_to_excel(dw_3)
end event

type st_4 from statictext within w_wip05au
integer x = 974
integer y = 76
integer width = 457
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "업체전산번호"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_vndr from editmask within w_wip05au
integer x = 1445
integer y = 64
integer width = 357
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!"
end type

type pb_2 from picturebutton within w_wip05au
integer x = 1815
integer y = 56
integer width = 238
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = right!
end type

event clicked;string l_s_parm

openwithparm(w_find_001 , ' O')
l_s_parm = message.stringparm
if f_spacechk(l_s_parm) <> -1 then
	sle_vndnm.text = mid(l_s_parm,16)
	em_vndr.text  = mid(l_s_parm,1,5)
end if
end event

type sle_vndnm from singlelineedit within w_wip05au
integer x = 2062
integer y = 60
integer width = 626
integer height = 100
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_wip05au
integer x = 23
integer width = 4553
integer height = 200
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

