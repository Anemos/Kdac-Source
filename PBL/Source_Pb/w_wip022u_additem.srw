$PBExportHeader$w_wip022u_additem.srw
$PBExportComments$품번사용량 추가윈도우
forward
global type w_wip022u_additem from window
end type
type cb_4 from commandbutton within w_wip022u_additem
end type
type cb_3 from commandbutton within w_wip022u_additem
end type
type cb_2 from commandbutton within w_wip022u_additem
end type
type cb_1 from commandbutton within w_wip022u_additem
end type
type dw_1 from datawindow within w_wip022u_additem
end type
end forward

global type w_wip022u_additem from window
integer width = 2533
integer height = 1440
boolean titlebar = true
string title = "품번 추가등록 윈도우"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_wip022u_additem w_wip022u_additem

type variables
datawindow i_dwo
end variables

on w_wip022u_additem.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_wip022u_additem.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_test

i_dwo = message.powerobjectparm

dw_1.settransobject(sqlca)
cb_1.triggerevent(Clicked!)
end event

type cb_4 from commandbutton within w_wip022u_additem
integer x = 1952
integer y = 1220
integer width = 352
integer height = 108
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;closewithreturn(parent, 'U030')
end event

type cb_3 from commandbutton within w_wip022u_additem
integer x = 1541
integer y = 1220
integer width = 352
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;long ll_cnt, ll_rowcnt, ll_chkcnt, ll_lolev01, ll_lolev02
string ls_usge, ls_pitno, ls_citno, ls_prdpt, ls_chdpt, ls_iocd, ls_chksrce
string ls_date, ls_nextdt, ls_plant, ls_dvsn, ls_rtn
dec{4} lc_convqty, lc_qty, lc_sumqty

dw_1.accepttext()
ll_rowcnt = dw_1.rowcount()

if f_wip_mandantory_chk(dw_1) = -1 then return 0

ls_plant = i_dwo.getitemstring(1,"wip002_wbplant")
ls_dvsn = i_dwo.getitemstring(1,"wip002_wbdvsn")
ls_citno = i_dwo.getitemstring(1,"wip002_wbitno")
ls_usge = i_dwo.getitemstring(1,"usge_chk")

select convqty into :lc_convqty from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant and div = :ls_dvsn and itno = :ls_citno
	using sqlca;

SELECT lolevel INTO :ll_lolev01 FROM PBINV.INV002
	WHERE COMLTD = :g_s_company AND ITNO = :ls_citno
	using sqlca;

lc_sumqty = 0
for ll_cnt = 1 to ll_rowcnt
	//자재트랜스에 해당품번의 사용내역조회
	ls_pitno = dw_1.getitemstring(ll_cnt,"wdprno")
	ls_prdpt = dw_1.getitemstring(ll_cnt,"wdprdpt")
	ls_chdpt = dw_1.getitemstring(ll_cnt,"wdchdpt")
	ls_iocd = dw_1.getitemstring(ll_cnt,"wdiocd")
	ls_date = mid(dw_1.getitemstring(ll_cnt,"wddate"),1,6)
	//Lolevel Check
	SELECT lolevel INTO :ll_lolev02 FROM PBINV.INV002
	WHERE COMLTD = :g_s_company AND ITNO = :ls_pitno
	using sqlca;
	if ll_lolev01 <= ll_lolev02 then
		ls_rtn = dw_1.modify("wdprno.background.color = 65535 ")
		messagebox("경고","모품번의 BOM레벨이 하위품번의 BOM레벨보다 같거나 하위에 있습니다.")
		return 0
	else
		ls_rtn = dw_1.modify("wdprno.background.color = 15780518")
	end if
	
	if ls_iocd = '1' then
		if ls_usge = '01' then
			SELECT COUNT(*) INTO :ll_chkcnt FROM PBINV.INV401
				WHERE COMLTD = :g_s_company and XPLANT = :ls_plant and DIV = :ls_dvsn and
						SLIPTYPE = 'RM' and ITNO = :ls_pitno and SUBSTR(TDTE4,1,6) = :ls_date
						using sqlca;
			if ll_chkcnt < 1 then
				ls_rtn = dw_1.modify("wdprno.background.color = 65535 ")
				return 0
			else
				ls_rtn = dw_1.modify("wdprno.background.color = 15780518")
			end if
		else
			SELECT COUNT(*) INTO :ll_chkcnt FROM PBINV.INV401
				WHERE COMLTD = :g_s_company and XPLANT = :ls_plant and DIV = :ls_dvsn and
						SLIPTYPE = 'IS' and ITNO = :ls_pitno and SUBSTR(TDTE4,1,6) = :ls_date and
						VSRNO = :ls_prdpt
						using sqlca;
			if ll_chkcnt < 1 then
				ls_rtn = dw_1.modify("wdprno.background.color = 65535 ")
				ls_rtn = dw_1.modify("wdprdpt.background.color = 65535 ")
				return 0
			else
				ls_rtn = dw_1.modify("wdprno.background.color = 15780518 ")
				ls_rtn = dw_1.modify("wdprno.background.color = 15780518 ")
			end if
		end if
	else
		// 구입선 체크
		SELECT SRCE INTO :ls_chksrce
		FROM PBINV.INV402
		WHERE COMLTD = :g_s_company and XPLANT = :ls_plant and DIV = :ls_dvsn and
			ITNO = :ls_pitno and XYEAR = :ls_date
		using sqlca;
		if ls_chksrce <> '04' then
			messagebox("에러","모품번:" + ls_pitno + " 은 사급완성품이 아닙니다.")
			return 0
		end if
		
		SELECT COUNT(*) INTO :ll_chkcnt FROM PBINV.INV401
				WHERE COMLTD = :g_s_company and XPLANT = :ls_plant and DIV = :ls_dvsn and
						SLIPTYPE = 'RP' and ITNO = :ls_pitno and SUBSTR(TDTE4,1,6) = :ls_date and
						VSRNO = :ls_chdpt 
						using sqlca;
		if ll_chkcnt < 1 then
			ls_rtn = dw_1.modify("wdprno.background.color = 65535 ")
			return 0
		else
			ls_rtn = dw_1.modify("wdprno.background.color = 15780518 ")
		end if
	end if
	//수량체크
	lc_qty = dw_1.getitemdecimal(ll_cnt,"repqty")
	if lc_qty = 0 then
		ls_rtn = dw_1.modify("repqty.background.color = 65535 ")
		return 0
	else
		ls_rtn = dw_1.modify("repqty.background.color = 15780518 ")
		lc_sumqty = lc_sumqty + (lc_qty * lc_convqty)
		dw_1.setitem(ll_cnt,"wdchqt", lc_qty * lc_convqty)
	end if
next

//저장하기
ls_nextdt = uf_wip_addmonth(ls_date,1)
	
ls_chdpt = trim(i_dwo.getitemstring(1,"wip002_wborct"))
if ls_usge = '01' then
	UPDATE "PBWIP"."WIP002"  
		SET "WBUSQT1" = "WBUSQT1" + :lc_sumqty 
		WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
				( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP002"."WBORCT" = :ls_chdpt ) AND  
				( "PBWIP"."WIP002"."WBITNO" = :ls_citno ) AND  
				( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_date )   
				using sqlca;
else
	UPDATE "PBWIP"."WIP002"  
		SET "WBUSQT2" = "WBUSQT2" + :lc_sumqty  
		WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
				( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP002"."WBORCT" = :ls_chdpt ) AND  
				( "PBWIP"."WIP002"."WBITNO" = :ls_citno ) AND  
				( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_date )   
				using sqlca;
end if
//기말 재공 UPDATE
UPDATE "PBWIP"."WIP002"  
	SET "WBBGQT" = "WBBGQT" - :lc_sumqty
	WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
			( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
			( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
			( "PBWIP"."WIP002"."WBORCT" = :ls_chdpt ) AND  
			( "PBWIP"."WIP002"."WBITNO" = :ls_citno ) AND  
			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_nextdt )   
			using sqlca;

if dw_1.update() = 1 then
	closewithreturn(parent, 'U010')
else
	closewithreturn(parent, 'U020')
end if
return 0

end event

type cb_2 from commandbutton within w_wip022u_additem
integer x = 1129
integer y = 1220
integer width = 352
integer height = 108
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;long ll_selrow

ll_selrow = dw_1.getselectedrow(0)

if ll_selrow < 1 then
	messagebox("확인","삭제할 행을 선택바랍니다.")
	return 0
end if

dw_1.deleterow(ll_selrow)
end event

type cb_1 from commandbutton within w_wip022u_additem
integer x = 718
integer y = 1220
integer width = 352
integer height = 108
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "추가"
end type

event clicked;long ll_currow
string ls_time, ls_serno, ls_cmcd, ls_date, ls_iocd, ls_usge, ls_rtn

//재공 전산번호(Serial No)
ls_cmcd = i_dwo.getitemstring(1,"wip002_wbcmcd")
ls_iocd = i_dwo.getitemstring(1,"wip002_wbiocd")
ls_usge = i_dwo.getitemstring(1,"usge_chk")
ls_serno = f_wip_get_serialno(ls_cmcd)
if len(ls_serno) = 1 then
	return -1
end if

ls_date = i_dwo.getitemstring(1,"wip002_wbyear") + i_dwo.getitemstring(1,"wip002_wbmonth")
ls_date = f_relativedate(uf_wip_addmonth(ls_date,1) + '01', -1)
ls_time = mid(g_s_time,1,2) + mid(g_s_time,4,2) + mid(g_s_time,7,2)
//재공 TRANS 생성

ll_currow = dw_1.insertrow(0)
dw_1.setitem(ll_currow,"wdcmcd",ls_cmcd)
dw_1.setitem(ll_currow,"wdslty",'WR')
dw_1.setitem(ll_currow,"wdsrno",ls_serno)
dw_1.setitem(ll_currow,"wdplant",i_dwo.getitemstring(1,"wip002_wbplant"))
dw_1.setitem(ll_currow,"wddvsn",i_dwo.getitemstring(1,"wip002_wbdvsn"))
dw_1.setitem(ll_currow,"wdiocd",i_dwo.getitemstring(1,"wip002_wbiocd"))
dw_1.setitem(ll_currow,"wditno",i_dwo.getitemstring(1,"wip002_wbitno"))
dw_1.setitem(ll_currow,"wdrvno",' ')
dw_1.setitem(ll_currow,"wddesc",i_dwo.getitemstring(1,"wip002_wbdesc"))
dw_1.setitem(ll_currow,"wdspec",i_dwo.getitemstring(1,"wip002_wbspec"))
dw_1.setitem(ll_currow,"wdunit",i_dwo.getitemstring(1,"wip002_wbunit"))
dw_1.setitem(ll_currow,"wditcl",i_dwo.getitemstring(1,"wip002_wbitcl"))
dw_1.setitem(ll_currow,"wdsrce",i_dwo.getitemstring(1,"wip002_wbsrce"))
dw_1.setitem(ll_currow,"wdusge",i_dwo.getitemstring(1,"usge_chk"))
dw_1.setitem(ll_currow,"wdpdcd",i_dwo.getitemstring(1,"wip002_wbpdcd"))
dw_1.setitem(ll_currow,"wdslno",' ')
dw_1.setitem(ll_currow,"wdprsrty",'WR')
dw_1.setitem(ll_currow,"wdprsrno",' ')
dw_1.setitem(ll_currow,"wdprsrno1",' ')
dw_1.setitem(ll_currow,"wdprsrno2",' ')
dw_1.setitem(ll_currow,"wdprno",' ')
dw_1.setitem(ll_currow,"wdprdpt",' ')
dw_1.setitem(ll_currow,"wdchdpt",i_dwo.getitemstring(1,"wip002_wborct"))
dw_1.setitem(ll_currow,"wddate",ls_date)
dw_1.setitem(ll_currow,"wdprqt",0)
dw_1.setitem(ll_currow,"wdchqt",0)
dw_1.setitem(ll_currow,"wdipaddr",g_s_ipaddr)
dw_1.setitem(ll_currow,"wdmacaddr",g_s_macaddr)
dw_1.setitem(ll_currow,"wdinptid",g_s_empno)
dw_1.setitem(ll_currow,"wdupdtid",g_s_empno)
dw_1.setitem(ll_currow,"wdinptdt",g_s_date)
dw_1.setitem(ll_currow,"wdinpttm",g_s_datetime)
dw_1.setitem(ll_currow,"wdupdtdt",g_s_date)

if ls_iocd = '1' and ls_usge = '02' then
	ls_rtn = dw_1.modify("wdprdpt.background.color = 15780518")
	ls_rtn = dw_1.modify("wdprdpt.protect = 0")
else
	ls_rtn = dw_1.modify("wdprdpt.background.color = 12632256")
	ls_rtn = dw_1.modify("wdprdpt.protect = 1")
end if
dw_1.setcolumn("wdprno")
dw_1.setfocus()
end event

type dw_1 from datawindow within w_wip022u_additem
integer x = 27
integer y = 32
integer width = 2464
integer height = 1164
integer taborder = 10
string title = "none"
string dataobject = "d_wip022u_additem"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_find' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		//dw_2.setitem(1,"vndnm",trim(mid(ls_parm,1,30)))
		//dw_2.setitem(1,"vndr",trim(mid(ls_parm,36,10)))
		dw_1.setitem(1,"wdprdpt",trim(mid(ls_parm,1,5)))
	end if
end if
end event

