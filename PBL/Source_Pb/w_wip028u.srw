$PBExportHeader$w_wip028u.srw
$PBExportComments$기타사용( 외주가공품처리_부평 )
forward
global type w_wip028u from w_origin_sheet01
end type
type dw_4 from datawindow within w_wip028u
end type
type dw_1 from datawindow within w_wip028u
end type
type gb_1 from groupbox within w_wip028u
end type
end forward

global type w_wip028u from w_origin_sheet01
string title = "원재료입고취소"
dw_4 dw_4
dw_1 dw_1
gb_1 gb_1
end type
global w_wip028u w_wip028u

type variables

end variables
on w_wip028u.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_wip028u.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02

dw_1.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_4.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')

dw_4.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_4.insertrow(0)
dw_4.setitem(1,"wip001_wainptdt", g_s_date)

// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, true, false, false, false, false)
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant , ls_dvsn, ls_pitno, ls_adjdate, ls_srce,ls_mysql
int i,l_n_rowcount
dec{4} lc_qty

dw_1.reset()
dw_4.accepttext()
uo_status.st_message.text = ' '
SetPointer(HourGlass!)

ls_plant = dw_4.getitemstring( 1, 'wip001_waplant')
ls_dvsn = dw_4.getitemstring( 1, 'wip001_wadvsn')
ls_pitno = dw_4.getitemstring( 1, 'wip001_waitno')
lc_qty = dw_4.getitemnumber( 1, 'wip001_quanty')

//BOM QTEMP생성
 DECLARE up_wip_16 PROCEDURE FOR PBWIP.SP_WIP_16  
		A_COMLTD = '01',   
		A_PLANT = :ls_plant,   
		A_DVSN = :ls_dvsn,   
		A_ITNO = :ls_pitno,   
		A_DATE = :g_s_date,   
		A_CHK = 'K',
		A_DELCHK = 'Y'	using sqlca;
execute up_wip_16;

l_n_rowcount = dw_1.retrieve()

//DELETE TEMP TABLE
ls_mysql = "DROP TABLE QTEMP.BOMTEMP02"
Execute Immediate :ls_mysql using sqlca;

dw_1.object.issue_qty.background.color = rgb(255,250,239)

if l_n_rowcount > 0 then
	uo_status.st_message.text = f_message("A070")
else
	uo_status.st_message.text = f_message("E330")
	return 0
end if

dw_1.setfocus()
for i=1 to l_n_rowcount 
	dw_1.object.issue_qty[i] = dw_1.object.tcqty[i] * lc_qty
	ls_srce = dw_1.getitemstring(i,"srce")
	if ls_srce <> '03' and f_spacechk(ls_srce) <> -1 then
		dw_1.object.ip_chk[i] = 'Y'
	end if
next

return 0
end event

event ue_save;call super::ue_save;integer li_cnt, li_rowcnt, l_n_check
string  ls_srno,ls_itno,ls_spec,ls_rvno,ls_cls,ls_pitno 
string  ls_itnm,ls_xunit,ls_srce,ls_pdcd,ls_plant,ls_dvsn,ls_remk
string  ls_message
dec{4}  ld_qty, lc_convqty
dec{2}  ld_avrg

li_rowcnt = dw_1.rowcount()
if li_rowcnt < 1 then
	uo_status.st_message.text = "조정할 하위내역이 없습니다."
	return 0
end if

ls_pitno = dw_4.getitemstring(1,"wip001_waitno")
ld_qty = dw_4.getitemnumber(1,"wip001_quanty") * dw_4.getitemnumber(1,"inv101_convqty")
if ld_qty < 1 then
	uo_status.st_message.text = "재공량이 0 보다커야 조정이 가능합니다."
	return 0
end if
ls_srno = f_wip_get_serialno(g_s_company)
ls_plant = dw_4.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_4.getitemstring(1,"wip001_wadvsn")

ls_remk = "사내외주가공품:" + ls_pitno + " 에 대한수량조정"
sqlca.autocommit = false

//사내외주가공품처리
update "PBWIP"."WIP001"
	set WAUSQT8  = WAUSQT8 + :ld_qty, WAOHQT = WAOHQT - :ld_qty	  
where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :ls_plant AND
		 "PBWIP"."WIP001"."WADVSN"   = :ls_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
		 "PBWIP"."WIP001"."WAITNO"   = :ls_pitno
using sqlca;
if sqlca.sqlnrows < 1 then
	ls_message = "WIP001 업데이트 에러"
	goto Rollback_
end if

//재공트랜스에 사용이력 생성
insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, 
wdrvno, wddesc, wdspec, wdunit, wditcl, wdsrce, wdusge, 
wdpdcd, wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, wdprno, wdprdpt, wdchdpt,
wddate, wdprqt, wdchqt, wdipaddr, wdmacaddr, wdinptid,  wdupdtid, wdinptdt,  wdinpttm, wdupdtdt)
select a.comltd,'WX',:ls_srno,a.xplant,a.div,'1',a.itno,
	b.rvno,b.itnm,b.spec,a.xunit,a.cls,a.srce,'08',
	substring(a.pdcd,1,2),'','WX','','','','','','9999',
	:g_s_date,0,
	:ld_qty,:g_s_ipaddr,:g_s_macaddr,:g_s_empno,:g_s_empno,:g_s_date,
	'',:g_s_date
from pbinv.inv101 a inner join pbinv.inv002 b
	on a.comltd = b.comltd and a.itno = b.itno
where a.comltd = :g_s_company and a.xplant = :ls_plant and
	a.div = :ls_dvsn and a.itno = :ls_pitno
using sqlca;

//데이타베스 에러체크
if sqlca.sqlcode <> 0 then
	ls_message = "WIP004 불출내역 생성 에러"
	goto Rollback_
end if

insert into pbwip.wip005 (wecmcd, weslty, wesrno, weremk)
values (:g_s_company, 'WX', :ls_srno, :ls_remk) 
using sqlca;
//데이타베스 에러체크
if sqlca.sqlcode <> 0 then
	ls_message = "WIP005 불출내역 생성 에러"
	goto Rollback_
end if

for li_cnt = 1 to li_rowcnt 
	if trim(string(dw_1.object.ip_chk[li_cnt])) <> 'Y' then
		continue
	end if
	lc_convqty  = dw_1.object.convqty[li_cnt]
	ld_qty     = dw_1.object.issue_qty[li_cnt] * lc_convqty
	ls_plant    = dw_1.object.tplnt[li_cnt]
	ls_dvsn    = dw_1.object.tdvsn[li_cnt]
	ls_itno    = dw_1.object.tcitn[li_cnt]
	ls_cls     = dw_1.object.cls[li_cnt]
	ls_rvno    = dw_1.object.rvno[li_cnt]
	ls_spec    = dw_1.object.spec[li_cnt]
	ls_itnm    = dw_1.object.itnm[li_cnt]
	ls_srce    = dw_1.object.srce[li_cnt]
	ls_xunit   = dw_1.object.xunit[li_cnt]
	ls_pdcd    = dw_1.object.pdcd[li_cnt]
	//재공 시리얼번호 가져오기
	ls_srno    = dw_1.object.chk_srno[li_cnt]

	if len(ls_srno) = 1 then
		ls_message = "재공시리얼번호생성 에러" 
		goto Rollback_
	end if
	
	//재공밸런스에 품번존재유부
	select count(*) into:l_n_check from "PBWIP"."WIP001"
	where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :ls_plant AND
			 "PBWIP"."WIP001"."WADVSN"   = :ls_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
			 "PBWIP"."WIP001"."WAITNO"   = :ls_itno
	using sqlca;
	//품번이 있으면 수량 업데이트
	if l_n_check > 0 then
		update "PBWIP"."WIP001"
			set WAUSQT8  = WAUSQT8 - :ld_qty, WAOHQT = WAOHQT + :ld_qty	  
		where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :ls_plant AND
				 "PBWIP"."WIP001"."WADVSN"   = :ls_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
				 "PBWIP"."WIP001"."WAITNO"   = :ls_itno
		using sqlca;
		
		if sqlca.sqlnrows < 1 then
			ls_message = "WIP001 업데이트 에러"
			goto Rollback_
		end if
	else
		//품번이 없으면 수량을 포함한 품번생성
		select COSTAV into:ld_avrg from "PBINV"."INV101"
			where COMLTD = :g_s_company and XPLANT = :ls_plant and DIV = :ls_dvsn and ITNO = :ls_itno
		using sqlca;
		//품번이 없으면 수량을 포함한 품번생성
		insert into "PBWIP"."WIP001"
			values (:g_s_company,:ls_plant,:ls_dvsn,'9999',:ls_itno,'1',:ld_avrg,0,0,0,0,
						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,:ld_qty * (-1),0,0,0,0,0,0,:ld_qty,0 ,0,
						0,0,' ',:g_s_ipaddr,:g_s_macaddr,:g_s_date,:g_s_date)
		using sqlca;
		
		if sqlca.sqlcode <> 0 then
			ls_message = "WIP001 품번 생성 에러"
			goto Rollback_
		end if
	end if
	
	//재공트랜스에 사용이력 생성
	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, 
	wdrvno, wddesc, wdspec, wdunit, wditcl, wdsrce, wdusge, 
	wdpdcd, wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, wdprno, wdprdpt, wdchdpt,
	wddate, wdprqt, wdchqt, wdipaddr, wdmacaddr, wdinptid,  wdupdtid, wdinptdt,  wdinpttm, wdupdtdt)
   values (:g_s_company,'WX',:ls_srno,:ls_plant,:ls_dvsn,'1',:ls_itno,
				  :ls_rvno,:ls_itnm,:ls_spec,:ls_xunit,:ls_cls,:ls_srce,'08',
				  :ls_pdcd,'','WX','','','','','','9999',
				  :g_s_date,0,
				  :ld_qty * (-1),:g_s_ipaddr,:g_s_macaddr,:g_s_empno,:g_s_empno,:g_s_date,
				  '',:g_s_date )
	using sqlca;
	//데이타베스 에러체크
	if sqlca.sqlcode <> 0 then
		ls_message = "WIP004 불출내역 생성 에러"
		goto Rollback_
	end if
	
	insert into pbwip.wip005 (wecmcd, weslty, wesrno, weremk)
	values (:g_s_company, 'WX', :ls_srno, :ls_remk) 
	using sqlca;
	//데이타베스 에러체크
	if sqlca.sqlcode <> 0 then
		ls_message = "WIP005 불출내역 생성 에러"
		goto Rollback_
	end if
next

Commit using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = '정상적으로 처리되었습니다.'
dw_1.reset()

return 0

RollBack_:
Rollback using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = '저장중에 에러가 발생하였습니다.' + ls_message

return -1
end event

type uo_status from w_origin_sheet01`uo_status within w_wip028u
end type

type dw_4 from datawindow within w_wip028u
event ue_enterkey pbm_keydown
integer x = 55
integer y = 52
integer width = 4430
integer height = 396
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip028u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if

return 0
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' I')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"deptnm",trim(mid(ls_parm,16)))
		This.setitem(1,"dept",trim(mid(ls_parm,1,5)))
	end if
end if

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(1,"wip001_waplant")
	ls_dvsn = This.getitemstring(1,"wip001_wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "지역이나 공장을 먼저 선택하십시요"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(1,"wip001_waitno", mid(ls_parm,1,15))
		This.setitem(1,"inv002_itnm",mid(ls_parm,16,30))
	end if
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
dec{4} lc_bgqt, lc_convqty
string ls_itnm,ls_cls,ls_srce
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = "dept" then
	string ls_rtnvalue
	if f_spacechk(data) <> -1 then
		ls_rtnvalue = f_get_deptnm(data,'5')
		if f_spacechk(ls_rtnvalue) = -1 then
			uo_status.st_message.text = "부서코드가 틀립니다."
		else
			This.setitem(1,"deptnm",ls_rtnvalue)
		end if
	end if
end if

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
	
	SELECT decimal(A.waohqt / B.convqty,15,4), B.convqty, B.CLS, B.SRCE, C.ITNM 
	INTO :lc_bgqt, :lc_convqty, :ls_cls, :ls_srce, :ls_itnm
	FROM PBWIP.WIP001 A INNER JOIN PBINV.INV101 B
		ON A.WACMCD = B.COMLTD AND A.WAPLANT = B.XPLANT AND 
			A.WADVSN = B.DIV AND A.WAITNO = B.ITNO
		INNER JOIN PBINV.INV002 C
		ON B.COMLTD = C.COMLTD AND B.ITNO = C.ITNO
	WHERE A.WACMCD = :g_s_company AND A.WAPLANT = :ls_plant AND 
	  A.WADVSN = :ls_dvsn AND A.WAITNO = :data AND A.WAIOCD = '1'
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "정의되지 않은 품번입니다."
		return 0
	else
		This.setitem(1,"inv002_itnm",ls_itnm)
		This.setitem(1,"inv101_cls",ls_cls)
		This.setitem(1,"inv101_srce",ls_srce)
		This.setitem(1,"wip001_quanty",lc_bgqt)
		This.setitem(1,"inv101_convqty",lc_convqty)
	end if
end if
end event

type dw_1 from datawindow within w_wip028u
integer x = 23
integer y = 484
integer width = 4576
integer height = 1980
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip028u_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer li_cnt

for li_cnt = 1 to rowcount
	This.setitem(li_cnt,"chk_srno",f_wip_get_serialno(g_s_company))
next
end event

type gb_1 from groupbox within w_wip028u
integer x = 23
integer width = 4571
integer height = 460
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

