$PBExportHeader$w_wip058u.srw
$PBExportComments$라인실사 수정및 조회
forward
global type w_wip058u from w_origin_sheet02
end type
type dw_detail from datawindow within w_wip058u
end type
type dw_2 from datawindow within w_wip058u
end type
type dw_3 from datawindow within w_wip058u
end type
type cb_ok from commandbutton within w_wip058u
end type
type pb_1 from picturebutton within w_wip058u
end type
type cb_down from commandbutton within w_wip058u
end type
type dw_down from datawindow within w_wip058u
end type
type gb_2 from groupbox within w_wip058u
end type
end forward

global type w_wip058u from w_origin_sheet02
string tag = "재공 실사량 입력"
integer width = 4658
string title = "재공 실사량 입력"
dw_detail dw_detail
dw_2 dw_2
dw_3 dw_3
cb_ok cb_ok
pb_1 pb_1
cb_down cb_down
dw_down dw_down
gb_2 gb_2
end type
global w_wip058u w_wip058u

type variables
string i_s_selected
dec{0} lc_yyyymm
string i_s_yearmonth,i_s_plant,i_s_dvsn,i_s_vndr, i_s_orct

end variables

forward prototypes
public function integer wf_find_datachk ()
public function integer wf_authority_chk ()
end prototypes

public function integer wf_find_datachk ();string ls_iocd, ls_plant, ls_dvsn, ls_vndr, ls_itno, ls_pdcd, ls_rtnvalue

dw_3.accepttext()
ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")
ls_pdcd = dw_3.getitemstring(1,"inv101_pdcd")
ls_iocd = dw_3.getitemstring(1,"wip001_waiocd")
ls_itno = dw_3.getitemstring(1,"wip001_waitno")

if ls_iocd = '1' then
	if f_spacechk(ls_itno) = -1 then
		dw_3.setitem(1,"wip001_waorct",'9999')
	else
		if f_get_itemproperty(g_s_company, i_s_plant, i_s_dvsn, ls_itno, dw_3) = -1 then
			uo_status.st_message.text = "정의되지 않은 품번입니다."
			dw_3.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			SELECT "PBINV"."INV101"."PDCD"  
    			INTO :ls_rtnvalue  
    			FROM "PBINV"."INV101"  
				WHERE ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
						( "PBINV"."INV101"."XPLANT" = :ls_plant ) AND  
						( "PBINV"."INV101"."DIV" = :ls_dvsn ) AND  
						( "PBINV"."INV101"."ITNO" = :ls_itno )   
						using sqlca;
			if mid(ls_pdcd,1,2) <> mid(ls_rtnvalue,1,2) then
				uo_status.st_message.text = "제품군에 해당하는 품번이 아닙니다."
				dw_3.modify("wip001_waitno.background.color = 65535")
				return -1
			end if
			dw_3.modify("wip001_waitno.background.color = 1090519039")
			dw_3.setitem(1,"wip001_waitno",ls_itno)
			dw_3.setitem(1,"wip001_waorct",'9999')
		end if
	end if
end if

return 0
end function

public function integer wf_authority_chk ();string ls_cttp, ls_stdt, ls_stscd, ls_lstscd
//업체정산년월 셋팅
ls_cttp = 'WIP' + i_s_dvsn + '080'

select wzeddt,wzstscd,wzlstscd
	into :ls_stdt,:ls_stscd,:ls_lstscd
  	from pbwip.wip090
	where wzcmcd = '01' and wzplant = :i_s_plant and wzcttp = :ls_cttp
	using sqlca;

//dw_3.setitem(1, "wip001_wainptdt", ls_stdt)
//i_s_yearmonth = ls_stdt
if ls_stscd <> 'C' then
	dw_3.setitem(1,"inv002_itnm","재공단가계산이 완료되지 않았습니다.")
else
	dw_3.setitem(1,"inv002_itnm","재공단가계산이 완료되었습니다.")
end if

if ls_lstscd = 'C' then
	uo_status.st_message.text = "라인실사가 확정된 상태입니다."
	return -1
end if

return 0
end function

on w_wip058u.create
int iCurrent
call super::create
this.dw_detail=create dw_detail
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_ok=create cb_ok
this.pb_1=create pb_1
this.cb_down=create cb_down
this.dw_down=create dw_down
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.cb_down
this.Control[iCurrent+7]=this.dw_down
this.Control[iCurrent+8]=this.gb_2
end on

on w_wip058u.destroy
call super::destroy
destroy(this.dw_detail)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_ok)
destroy(this.pb_1)
destroy(this.cb_down)
destroy(this.dw_down)
destroy(this.gb_2)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03
dw_3.settransobject(sqlca)

dw_3.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_3.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_3.getchild("inv101_pdcd",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('A')

dw_3.insertrow(0)
dw_3.setitem(1,"wip001_waiocd",'1')

// 실사년월 및 최종확정 가능 여부
String ls_date, ls_stscd
select distinct wzeddt, wzlstscd into :ls_date, :ls_stscd
from pbwip.wip090
using sqlca;

dw_3.setitem(1,"wip001_wainptdt",ls_date)
//if ls_stscd = 'C' then
//	cb_ok.enabled = False
//else
//	cb_ok.enabled = True
//end if

dw_2.settransobject(sqlca)
dw_detail.settransobject(Sqlca)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  false,  false,  false,  false,  false,  false, false, false,  false,  false)
end event

event ue_retrieve;call super::ue_retrieve;dec{4}  l_n_waohqt
integer l_n_count, li_rtnval
string  l_s_vender, ls_adjdate, ls_vsrno, ls_plant, ls_dvsn, ls_itno, ls_pdcd

SetPointer(HourGlass!)

dw_2.reset()
dw_detail.reset()

dw_3.accepttext()
i_s_plant = dw_3.getitemstring(1,"wip001_waplant")
i_s_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")
IF f_wip_mandantory_chk(dw_3) = -1 THEN 						//필수입력 체크
	uo_status.st_message.text = f_message("E010")
	return 0
END IF

if wf_find_datachk() = -1 then
	uo_status.st_message.text = "조회조건이 잘못 입력되었습니다."
end if

li_rtnval = wf_authority_chk()

ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")
ls_pdcd = dw_3.getitemstring(1,"inv101_pdcd")
ls_adjdate = dw_3.getitemstring(1,"wip001_wainptdt")
i_s_yearmonth = ls_adjdate
if f_spacechk(ls_pdcd) = -1 then
	ls_pdcd = '%'
else
	ls_pdcd = ls_pdcd + '%'
end if

l_n_count = dw_2.retrieve(g_s_company, ls_plant, ls_dvsn, ls_pdcd, mid(ls_adjdate,1,4), mid(ls_adjdate,5,2))
if l_n_count = 0 then
	if li_rtnval = 0 then
		uo_status.st_message.text = f_message("I020")
	end if
	return 0
else
	if li_rtnval = 0 then
		uo_status.st_message.text = f_message("I010")
	end if
end if

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  true,  true,  false,  false,  false,  false, false, false,  false,  false)
dw_detail.object.phqt.background.color = rgb(255,250,239)

end event

event ue_save;call super::ue_save;string l_s_column, ls_year, ls_month, ls_itno
dec{5} l_n_avrg1
dec{4} l_n_phqt,l_n_cur_qty, lc_convqty
dec{2} l_n_retn,l_n_scrp
dec{0} l_n_amt

SetPointer(HourGlass!)
if i_s_selected <> 'C' and i_s_selected <> 'I' then
	return 0
end if
dw_detail.accepttext()
dw_detail.object.phqt.background.color = rgb(255,250,239)

if isnull(dw_detail.object.phqt[1]) = true or dw_detail.object.phqt[1] < 0 then
	dw_detail.object.phqt.background.color = rgb(255,255,0)
	if f_spacechk(l_s_column) = -1 then
		l_s_column = "phqt"
	end if
end if

if len(l_s_column) > 0 then
	dw_detail.setfocus()
	dw_detail.setcolumn(l_s_column)
	uo_status.st_message.text = f_message("E010")
	i_n_erreturn = -1
	return 
end if
lc_convqty = dw_detail.object.inv101_convqty[1]
l_n_phqt    = dw_detail.object.phqt[1] * lc_convqty 
l_n_avrg1   = dw_detail.object.avrg1[1]
ls_itno = dw_detail.getitemstring(1,"wip006_wfitno")
ls_year = mid(i_s_yearmonth,1,4)
ls_month = mid(i_s_yearmonth,5,2)

if i_s_selected = 'C' then
	update pbwip.wip006
		set wfphqt   = :l_n_phqt, wfinptdt = :g_s_empno, wfupdtdt   = :g_s_date,
          wfipaddr = :g_s_ipaddr,wfmacaddr  = :g_s_macaddr 
	where wfcmcd  = :g_s_company and wfplant = :i_s_plant and wfdvsn = :i_s_dvsn and
			wfitno  = :ls_itno  and wfyear = :ls_year and
			wfmonth = :ls_month
	using sqlca;
elseif i_s_selected = 'I' then
//	insert into pbwip.wip006 values (
//		:ls_year,:ls_month,:g_s_company,:i_s_plant ,:i_s_dvsn    ,'9999',:ls_itno,'1',
//		:l_n_phqt ,:l_n_scrp,:l_n_retn,' ' , ' '        ,:g_s_ipaddr,:g_s_macaddr,:g_s_date,:g_s_date )
//	using sqlca;
end if
if sqlca.sqlcode <> 0 then
   messagebox("SQL Error",sqlca.sqlerrtext)
	uo_status.st_message.text = f_message("U020")
	return 0
end if
			
dw_detail.object.phqt.background.color = rgb(192,192,192)
uo_status.st_message.text = f_message("U010")
i_s_selected = ' '

end event

event ue_delete;call super::ue_delete;//integer l_n_yesno
//string ls_itno, ls_year, ls_month
//
//uo_status.st_message.text = ""
//ls_itno = dw_detail.getitemstring(1,"wip006_wfitno")
//ls_year = mid(i_s_yearmonth,1,4)
//ls_month = mid(i_s_yearmonth,5,2)
//if f_spacechk(ls_itno) = -1 then
//	uo_status.st_message.text = f_message("D060")
//	return 0
//end if
//l_n_yesno = messagebox("삭제확인", " 해당 품번:" + ls_itno + " 의 실사량 정보를 삭제하시겠습니까 ?",Question!,OkCancel!,2)
//if l_n_yesno <> 1 then
//	uo_status.st_message.text = f_message("D030")
//	return 
//end if
//
//delete from pbwip.wip006
//	where wfcmcd  = :g_s_company and wfplant = :i_s_plant and wfdvsn = :i_s_dvsn and
//			wfdept  = :i_s_orct    and wfitno  = :ls_itno  and wfyear = :ls_year and
//			wfmonth = :ls_month
//using sqlca;
//
//if sqlca.sqlcode <> 0 then
//	uo_status.st_message.text = f_message("D020")
//	return 0
//end if
//
//dw_detail.object.wip006_wfscrp.background.color = rgb(192,192,192)
//dw_detail.object.wip006_wfretn.background.color = rgb(192,192,192)
//dw_detail.object.phqt.background.color = rgb(192,192,192)
//uo_status.st_message.text = f_message("D010")
//i_s_selected = ' '
//
//
end event

type uo_status from w_origin_sheet02`uo_status within w_wip058u
end type

type dw_detail from datawindow within w_wip058u
integer x = 18
integer y = 2048
integer width = 4581
integer height = 420
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip058u_wip006"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip058u
integer x = 23
integer y = 324
integer width = 4576
integer height = 1708
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip058u_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
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

event doubleclicked;string ls_itno, ls_orct, ls_year, ls_month, ls_cls, ls_srce, ls_unit, ls_chkcd
long l_n_count, ll_rowcnt
dec{5} lc_avrg

ll_rowcnt = dw_2.rowcount()
if row < 1 or row > ll_rowcnt then
	return 0
end if

dw_detail.reset()

i_s_plant = dw_2.getitemstring(row,"wip002_wbplant")
i_s_dvsn = dw_2.getitemstring(row,"wip002_wbdvsn")
ls_itno = dw_2.getitemstring(row,"wip002_wbitno")
ls_cls = dw_2.getitemstring(row,"wbitcl")
ls_srce = dw_2.getitemstring(row,"wbsrce")
ls_unit = dw_2.getitemstring(row,"inv101_xunit")
lc_avrg = dw_2.getitemdecimal(row,"avrg1")
ls_year = mid(i_s_yearmonth,1,4)
ls_month = mid(i_s_yearmonth,5,2)

if ls_cls = '30' or ls_cls = '50' or ls_srce = '03' then
	uo_status.st_message.text = "제품(30), 사내가공품(50/04), 자가품(10/03)은 재공실사대상이 될수 없습니다. "
	return 0
end if

if wf_authority_chk() = -1 then
	dw_detail.object.phqt.background.color = rgb(192,192,192)
	dw_detail.object.phqt.protect = true
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true,  false,  false,  false,  false,  false,  false,  false, false, false,  false,  false)
	return 0
else
	dw_detail.object.phqt.background.color = rgb(255,250,239)
	dw_detail.object.phqt.protect = false
	dw_detail.setfocus()
	dw_detail.setcolumn('phqt')
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true,  false,  true,  true,  false,  false,  false,  false, false, false,  false,  false)
end if

l_n_count = dw_detail.retrieve(g_s_company,i_s_plant,i_s_dvsn,ls_itno,ls_year,ls_month)
if l_n_count = 0 then
	INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
          WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
          WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
          WFINPTDT,WFUPDTDT)
	SELECT :ls_year, :ls_month, COMLTD, XPLANT, DIV,
				'9999', ITNO,0,' ',' ',' ',SUBSTRING(PDCD,1,2),' ',
   			XUNIT, 0, 0, 'A', ' ', ' ', ' ', :g_s_empno, :g_s_date
	FROM PBINV.INV101
	WHERE COMLTD = '01' AND XPLANT = :i_s_plant AND
			DIV = :i_s_dvsn AND ITNO = :ls_itno
	USING sqlca;
	
	dw_detail.retrieve(g_s_company,i_s_plant,i_s_dvsn,ls_itno,ls_year,ls_month)
end if

dw_detail.setitem(1,"avrg1",lc_avrg)
dw_detail.setitem(1,"diffqty",This.getitemdecimal(row,"diffqta"))
i_s_selected = 'C'
uo_status.st_message.text = "해당 정보를 수정하십시오"
									 
return 0
end event

type dw_3 from datawindow within w_wip058u
event ue_dwkeydown pbm_dwnkey
integer x = 41
integer y = 48
integer width = 3808
integer height = 248
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip058u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwkeydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"vndnm",trim(mid(ls_parm,16)))
		This.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
		This.setitem(1,"wip001_waorct",trim(mid(ls_parm,1,5)))
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
	end if
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_null, ls_dvsn
datawindowchild cdw_1,cdw_2

This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "정의되지 않은 품번입니다."
		return 0
	end if
end if
end event

type cb_ok from commandbutton within w_wip058u
integer x = 2912
integer y = 188
integer width = 457
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "실사확정"
end type

event clicked;integer li_rtn
string ls_year, ls_mm, ls_yyyymm, ls_nextdt, ls_plant, ls_dvsn

ls_yyyymm = dw_3.getitemstring( 1, "wip001_wainptdt")
ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")
ls_year = mid(ls_yyyymm,1,4)
ls_mm = mid(ls_yyyymm,5,2)
ls_nextdt = uf_wip_addmonth( ls_yyyymm , 1 )

If g_s_empno <> '000030' then
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 or f_spacechk(ls_yyyymm) = -1 then
		uo_status.st_message.text = "지역, 공장, 실사년월을 입력해 주세요."
	end if
	
	UPDATE "PBWIP"."WIP090"  
   SET "WZLSTSCD" = 'C' 
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company ) AND  ( "PBWIP"."WIP090"."WZPLANT" = :ls_plant ) AND
		( SUBSTRING("PBWIP"."WIP090"."WZCTTP",4,1) = :ls_dvsn )
	using sqlca;
	
	uo_status.st_message.text = "실사 확정되었습니다."
	return 0
else
	li_rtn = MessageBox("최종확정", "최종확정 완료은 재공이월에 실사데이타를 반영합니다. ~r" &
		+ ls_yyyymm + "월 최종확정을 실행하시겠습니까?", Exclamation!, OKCancel!, 2)
		
	if li_rtn = 2 then
		return 0
	end if  
End if

setpointer(hourglass!)
// WIP002 NOT EXISTS CHECK
select count(*) into :li_rtn
from pbwip.wip006 inner join pbinv.inv101
      on wfcmcd = comltd and wfplant = xplant and wfdvsn = div 
        and wfitno = itno and cls <> '30' and cls <> '50' 
        and srce <> '03'
where wfcmcd = '01' and wfyear = :ls_year and wfmonth = :ls_mm and wfdept = '9999' and wfphqt <> 0 and
	not exists ( select * from pbwip.wip002
		where wbcmcd= wfcmcd and wbyear = wfyear and wbmonth = wfmonth and
			wbplant = wfplant and wbdvsn = wfdvsn and wbitno = wfitno and
			wborct = wfdept )
using sqlca;
if li_rtn > 0 then
	uo_status.st_message.text = " 재공이월DB에 존재하지 않는 품번이 있습니다."
	// CREATE WIP002(당월, 이월), WIP001
	// sqlwork 폴더에 연간라인실사.sql파일 적용
	// end 
	return 0
end if

//라인실사 데이타 업데이트 ( wip002, wip001 )
DECLARE up_wip_21 PROCEDURE FOR PBWIP.SP_WIP_21  
         A_CMCD = :g_s_company,   
         A_CURRDT = :ls_yyyymm,   
         A_NEXTDT = :ls_nextdt,   
         A_IPADDR = :g_s_ipaddr,   
         A_MACADDR = :g_s_macaddr,   
         A_INPTDT = :g_s_date,   
         A_UPDTDT = :g_s_date  using sqlca;
Execute up_wip_21;
Close up_wip_21;

if f_wip050_cost_pcc950(ls_yyyymm) = -1 then
	uo_status.st_message.text = '원가회계 재공생성작업시 오류가 발생했습니다.'
	return 0
end if

UPDATE "PBWIP"."WIP090"  
   SET "WZLSTSCD" = 'C' 
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company )   
	using sqlca;
		
uo_status.st_message.text = "완료되었습니다."

return 0
end event

type pb_1 from picturebutton within w_wip058u
integer x = 3534
integer y = 188
integer width = 155
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)
end event

type cb_down from commandbutton within w_wip058u
integer x = 3854
integer y = 188
integer width = 626
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "편집용엑셀다운"
end type

event clicked;if dw_2.rowcount() < 1 then
	uo_status.st_message.text = "다운로드할 데이타가 없습니다."
	return 0
end if

dw_2.sharedata(dw_down)
f_save_to_excel(dw_down)
end event

type dw_down from datawindow within w_wip058u
boolean visible = false
integer x = 4000
integer y = 60
integer width = 411
integer height = 120
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip058u_detail_down"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_wip058u
integer x = 18
integer y = 4
integer width = 4571
integer height = 304
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

