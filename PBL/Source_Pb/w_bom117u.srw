$PBExportHeader$w_bom117u.srw
$PBExportComments$Royalty 내자관리윈도우
forward
global type w_bom117u from w_origin_sheet02
end type
type dw_priinfo from datawindow within w_bom117u
end type
type dw_reginfo from datawindow within w_bom117u
end type
type uo_1 from uo_plandiv_bom within w_bom117u
end type
end forward

global type w_bom117u from w_origin_sheet02
dw_priinfo dw_priinfo
dw_reginfo dw_reginfo
uo_1 uo_1
end type
global w_bom117u w_bom117u

type variables
datawindowchild i_dwc_dvsn,i_dwc_cust,i_dwc_dvsn2,i_dwc_cust2
datawindowchild i_dwc_plant, i_dwc_plant2, i_dwc_pdcd, i_dwc_pdcd2
string i_s_state        //'m':수정, 'i':입력
end variables

forward prototypes
public subroutine wf_dsp_reset ()
public subroutine wf_init_reset ()
public function boolean wf_check_error ()
end prototypes

public subroutine wf_dsp_reset ();dw_reginfo.object.krydvsn.background.color = rgb(192,192,192)
dw_reginfo.object.krypdcd.background.color = rgb(192,192,192)
dw_reginfo.object.kryitno.background.color = rgb(192,192,192)
dw_reginfo.object.krycust.background.color = rgb(192,192,192)
dw_reginfo.object.kryfromdt.background.color = rgb(192,192,192)
dw_reginfo.object.krytodt.background.color = rgb(192,192,192)

dw_reginfo.object.krydvsn.protect = true
dw_reginfo.object.krypdcd.protect = true
dw_reginfo.object.kryitno.protect = true
dw_reginfo.object.krycust.protect = true
dw_reginfo.object.kryfromdt.protect = true
dw_reginfo.object.krytodt.protect = true
end subroutine

public subroutine wf_init_reset ();dw_reginfo.object.krydvsn.background.color = rgb(192,192,192)
dw_reginfo.object.kryitno.background.color = rgb(250,250,239)
dw_reginfo.object.krypdcd.background.color = rgb(250,250,239)
dw_reginfo.object.krycust.background.color = rgb(250,250,239)
dw_reginfo.object.kryfromdt.background.color = rgb(250,250,239)
dw_reginfo.object.krytodt.background.color = rgb(255,255,255)

dw_reginfo.object.krydvsn.protect = true
dw_reginfo.object.kryitno.protect = false
dw_reginfo.object.krypdcd.protect = false
dw_reginfo.object.krycust.protect = false
dw_reginfo.object.kryfromdt.protect = false
dw_reginfo.object.krytodt.protect = false
end subroutine

public function boolean wf_check_error ();//error가 없으면 false, 있으면 true
string ls_column,ls_rtnstr,ls_fromdt,ls_todt,ls_plant,ls_dvsn,ls_itno,ls_clsb,ls_srce,ls_pdcd
string ls_lastyymm,ls_last_fromdt,ls_cust,ls_lastcust,ls_kpdcd
integer li_rtnfrom,li_rtnto,li_chkcnt
long ll_caldate

ls_plant = dw_reginfo.object.kryplant[1]
ls_dvsn = dw_reginfo.object.krydvsn[1]
ls_itno = dw_reginfo.object.kryitno[1]
ls_kpdcd = dw_reginfo.object.krypdcd[1]
ls_cust = dw_reginfo.object.krycust[1]
ls_todt = mid(dw_reginfo.object.krytodt[1],1,6)
ls_fromdt = mid(dw_reginfo.object.kryfromdt[1],1,6)

//적용일과 완료일 체크
li_rtnfrom = f_spacechk(ls_fromdt)
li_rtnto = f_spacechk(ls_todt)

//날짜를 말일로 입력
if li_rtnto <> -1 then
	if mid(ls_todt,5,2) = '12' then
		ll_caldate = long(mid(ls_todt,1,4)) + 1
		ls_todt = string(ll_caldate) + '0101'
	else
		ll_caldate = long(ls_todt) + 1
		ls_todt = string(ll_caldate) + '01'
	end if
	
	ls_todt = f_relativedate(ls_todt,-1)
end if
if li_rtnfrom <> -1 then
	ls_fromdt = mid(ls_fromdt,1,6) + '01'
end if

//품번 존재유무
ls_rtnstr = f_bom_get_itemnbr(ls_plant,ls_dvsn,ls_itno)
if f_spacechk(ls_itno) = -1 or f_spacechk(ls_rtnstr) = -1 then
	dw_reginfo.object.kryitno.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column = "1kryitno"
	end if
else 
	dw_reginfo.object.kryitno.background.color = rgb(250,250,239)
end if
	
//bom007에 존제유무
if i_s_state = 'i' then
	select kryitno into :ls_rtnstr
		from pbpdm.bom007
		where kryplant = :ls_plant and
				krydvsn = :ls_dvsn and
				kryitno = :ls_itno using sqlca;
				
	if sqlca.sqlcode = 0 then
		dw_reginfo.object.kryitno.background.color = rgb(250,250,239)
		if f_spacechk(ls_column) = -1 then
			ls_column = "2kryitno"
		end if
	else 
		//dw_reginfo.object.kryitno.background.color = rgb(255,255,255)
	end if
end if
//계정,구입선 체크
select cls, srce, pdcd into :ls_clsb , :ls_srce, :ls_pdcd
	from pbinv.inv101  
	where comltd = :g_s_company and 
			xplant = :ls_plant and
			div = :ls_dvsn and
			itno = :ls_itno using sqlca;

dw_reginfo.object.itclsb.text = ls_clsb
dw_reginfo.object.itsrce.text = ls_srce
if ls_clsb = '10' then
	if ls_srce = '02' or ls_srce = '04' then
		dw_reginfo.object.kryitno.background.color = rgb(250,250,239)
	else
		dw_reginfo.object.kryitno.background.color = rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column = "3kryitno"
		end if
	end if
else
	dw_reginfo.object.kryitno.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column = "3kryitno"
	end if
end if

//제품군 체크
if ls_kpdcd <> ls_pdcd or f_spacechk(ls_pdcd) = -1 then
	dw_reginfo.object.krypdcd.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column = "6krypdcd"
	end if
else
	dw_reginfo.object.krypdcd.background.color = rgb(250,250,239)
end if

//최종계산날짜 가져오기
select max(rfyymm) into :ls_lastyymm
	from pbpdm.bom006 using sqlca;
//수정인경우
if i_s_state = 'm' then	
	select kryfromdt,krycust into :ls_last_fromdt,:ls_lastcust
		from pbpdm.bom007
		where kryplant = :ls_plant and
				krydvsn = :ls_dvsn and
				kryitno = :ls_itno using sqlca;
end if
//대상업체 체크
if f_spacechk(ls_cust) = -1 then
	dw_reginfo.object.krycust.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column = "4krycust"
	end if
else 
	if i_s_state = 'm' then
		select count(*) into :li_chkcnt
			from pbpdm.bom006
			where rfcust = :ls_lastcust and
					rfplant = :ls_plant and
					rfdvsn = :ls_dvsn and
					rfcitn = :ls_itno and
					rfgubn = 'Y' using sqlca;
			
		if li_chkcnt > 0 then
			if ls_cust <> ls_lastcust then
				dw_reginfo.object.krycust.background.color = rgb(255,255,0)
				if f_spacechk(ls_column) = -1 then
					ls_column = "4krycust"
				end if
			else
				dw_reginfo.object.krycust.background.color = rgb(255,255,255)
			end if
		end if
	else
		dw_reginfo.object.krycust.background.color = rgb(255,255,255)
	end if
end if

//적용일 필수입력
if li_rtnfrom <> -1 then
	if f_dateedit(ls_fromdt) = space(8) then
		dw_reginfo.object.kryfromdt.background.color = rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column = "5kryfromdt"
		end if
	else
		//적용일은 최종계산일보다 커야한다
		if i_s_state = 'i' then
			if mid(ls_fromdt,1,6) > ls_lastyymm then
				dw_reginfo.object.kryfromdt.background.color = rgb(255,255,255)
			else
				dw_reginfo.object.kryfromdt.background.color = rgb(255,255,0)
				if f_spacechk(ls_column) = -1 then
					ls_column = "5kryfromdt"
				end if
			end if
		else
			if li_chkcnt > 0 then
				//계산된 데이타가 존제하는 경우 수정불가
				if ls_fromdt <> ls_last_fromdt then
					dw_reginfo.object.kryfromdt.background.color = rgb(255,255,0)
					if f_spacechk(ls_column) = -1 then
						ls_column = "5kryfromdt"
					end if
				else
					dw_reginfo.object.kryfromdt.background.color = rgb(255,255,255)
				end if
			else
				//적용일은 최종계산일 보다 커야한다.
				if mid(ls_fromdt,1,6) > ls_lastyymm then
					dw_reginfo.object.kryfromdt.background.color = rgb(255,255,255)
				else
					dw_reginfo.object.kryfromdt.background.color = rgb(255,255,0)
					if f_spacechk(ls_column) = -1 then
						ls_column = "5kryfromdt"
					end if
				end if
			end if
		end if
	end if
else
	dw_reginfo.object.kryfromdt.background.color = rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column = "5kryfromdt"
	end if
end if

if li_rtnto <> -1 then
	if f_dateedit(ls_todt) = space(8) then
		dw_reginfo.object.krytodt.background.color = rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column = "5krytodt"
		end if
	else
		dw_reginfo.object.krytodt.background.color = rgb(255,255,255)
	end if
end if

if li_rtnfrom <> -1 and li_rtnto <> -1 then
	if ls_todt >= ls_fromdt then
		//pass
	else
		dw_reginfo.object.kryfromdt.background.color = rgb(255,255,0)
		dw_reginfo.object.krytodt.background.color = rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column = "5kryfromdt"
		end if
	end if
end if

//수정시 적용일 과 완료일 체크
if i_s_state = 'm' then
	if li_rtnto = -1 then
		//pass
	else
		if ls_todt >= ls_lastyymm then
			//pass
		else
			dw_reginfo.object.krytodt.background.color = rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
				ls_column = "5krytodt"
			end if
		end if
	end if
end if

if len(ls_column) > 0 then
	dw_reginfo.setcolumn(mid(ls_column,2))
	dw_reginfo.setfocus()
	choose case mid(ls_column,1,1)
		case '1'
			uo_status.st_message.text=f_message("E320")
		case '2'
			uo_status.st_message.text=f_message("A060")
		case '3'
			uo_status.st_message.text=f_message("A041")
		case '5'
			uo_status.st_message.text=f_message("E290")
		case '6'
			uo_status.st_message.text= "품번의 제품군이 일치하지 않습니다."
		case else
			uo_status.st_message.text=f_message("E010")
	end choose
	i_n_erreturn=-1
	return true
end if

dw_reginfo.object.kryfromdt[1] = ls_fromdt
dw_reginfo.object.krytodt[1] = ls_todt
dw_reginfo.accepttext()
return false
end function

on w_bom117u.create
int iCurrent
call super::create
this.dw_priinfo=create dw_priinfo
this.dw_reginfo=create dw_reginfo
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_priinfo
this.Control[iCurrent+2]=this.dw_reginfo
this.Control[iCurrent+3]=this.uo_1
end on

on w_bom117u.destroy
call super::destroy
destroy(this.dw_priinfo)
destroy(this.dw_reginfo)
destroy(this.uo_1)
end on

event ue_retrieve;long ll_rowcnt,ll_parm
datawindowchild dwc_pdcd,dwc_pdcd2
string  ls_plant,ls_div,ls_div1,ls_rtncd
integer net

ll_parm = message.longparm
if i_s_level = "5" then
	dw_reginfo.accepttext()
	if dw_reginfo.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U090"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

uo_status.st_message.text = ""
ls_rtncd = uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div = mid(ls_rtncd,2,1)

//제품군 셋팅
if ls_div = "L" or ls_div = "N" then
   ls_div1 = "S"
elseif  ls_div = "T" or ls_div = "O" then
   ls_div1 = "H"
elseif ls_div = "B" or ls_div = "P" then
   ls_div1 = "M"
else
	ls_div1 = ls_div
end if
//조회용
dw_priinfo.getchild("invdaa_ipdcd",dwc_pdcd2)
dwc_pdcd2.settransobject(sqlca)

//입력용
dw_reginfo.getchild("krypdcd",dwc_pdcd)
dwc_pdcd.settransobject(sqlca)

dwc_pdcd2.retrieve(ls_div1)
dwc_pdcd.retrieve(ls_div1)

if ll_parm <> 1 then
	dw_priinfo.reset()
	dw_reginfo.reset()
else
	dw_priinfo.reset()
end if
ll_rowcnt = dw_priinfo.retrieve(ls_plant,ls_div)

if ll_rowcnt < 1 then
	uo_status.st_message.text = f_message("I020")
else
	uo_status.st_message.text = f_message("I010")
end if
end event

event ue_insert;call super::ue_insert;string ls_plant,ls_div,ls_div1,ls_rtncd
datawindowchild dwc_pdcd
integer net
if i_s_level = "5" then
	dw_reginfo.accepttext()
	if dw_reginfo.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U090"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

uo_status.st_message.text = ""
dw_priinfo.selectrow(0, false)
i_s_state = 'i'       //입력상태
dw_reginfo.reset()

ls_rtncd = uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div = mid(ls_rtncd,2,1)
//제품군 셋팅
if ls_div = "L" or ls_div = "N" then
   ls_div1 = "S"
elseif  ls_div = "T" or ls_div = "O" then
   ls_div1 = "H"
elseif ls_div = "B" or ls_div = "P" then
   ls_div1 = "M"
else
	ls_div1 = ls_div
end if

//공장 DDDW
i_dwc_plant.retrieve('SLE220')
i_dwc_dvsn.retrieve('DAC030')
//제품군 DDDW
i_dwc_pdcd.retrieve(ls_div1)

dw_reginfo.insertrow(0)
wf_init_reset()
dw_reginfo.object.krydvsn[1] = ls_div
dw_reginfo.object.kryplant[1] = ls_plant
dw_reginfo.object.itclsb.text = ""
dw_reginfo.object.itsrce.text = ""

dw_reginfo.setfocus()
dw_reginfo.setcolumn("krypdcd")
end event

event ue_save;long ll_rowcnt

ll_rowcnt = dw_reginfo.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = f_message("U060")
	return 0
end if
dw_reginfo.accepttext()

//필수, 선택항목 체크
uo_status.st_message.text = ""
if wf_check_error() then
	return 0
end if
dw_reginfo.object.krycmcd[1] = g_s_company
dw_reginfo.object.kryupid[1] = g_s_empno
dw_reginfo.object.kryipad[1] = g_s_ipaddr
dw_reginfo.object.kryupdt[1] = g_s_date

if dw_reginfo.update() = 1 then
	commit using sqlca;
	this.triggerevent("ue_retrieve",0,1)
	wf_dsp_reset()
	uo_status.st_message.text = f_message("U010")
else
	rollback using sqlca;
	uo_status.st_message.text = f_message("U020")
end if
end event

event open;call super::open;dw_reginfo.settransobject(sqlca)
dw_priinfo.settransobject(sqlca) 

dw_reginfo.getchild("krydvsn",i_dwc_dvsn)
i_dwc_dvsn.settransobject(sqlca)
i_dwc_dvsn.retrieve('DAC030')

dw_reginfo.getchild("kryplant",i_dwc_plant)
i_dwc_plant.settransobject(sqlca)
i_dwc_plant.retrieve('SLE220')

dw_reginfo.getchild("krypdcd",i_dwc_pdcd)
i_dwc_pdcd.settransobject(sqlca)
i_dwc_pdcd.retrieve('A')

dw_reginfo.getchild("krycust",i_dwc_cust)
i_dwc_cust.settransobject(sqlca)
i_dwc_cust.retrieve()

dw_priinfo.getchild("bom007_krydvsn",i_dwc_dvsn2)
i_dwc_dvsn2.settransobject(sqlca)
i_dwc_dvsn2.retrieve('DAC030')

dw_priinfo.getchild("bom007_kryplant",i_dwc_plant2)
i_dwc_plant2.settransobject(sqlca)
i_dwc_plant2.retrieve('SLE220')

dw_priinfo.getchild("inv101_pdcd",i_dwc_pdcd2)
i_dwc_pdcd2.settransobject(sqlca)
i_dwc_pdcd2.retrieve('A')

dw_priinfo.getchild("bom007_krycust",i_dwc_cust2)
i_dwc_cust2.settransobject(sqlca)
i_dwc_cust2.retrieve()

//조회,입력,저장,삭제 ,상세조회,화면인쇄,특수문자
i_b_retrieve=true
i_b_insert = true
i_b_save = true
i_b_delete = true
i_b_print = false

wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)

end event

event ue_delete;call super::ue_delete;long ll_currow,ll_chkcnt
string ls_plant,ls_dvsn,ls_itno
integer li_rtn

uo_status.st_message.text = ""
ll_currow = dw_priinfo.getselectedrow( 0)

if ll_currow = 0 then
	uo_status.st_message.text = f_message("D100")
	return 0
end if

ls_plant = dw_priinfo.object.bom007_kryplant[ll_currow]
ls_dvsn = dw_priinfo.object.bom007_krydvsn[ll_currow]
ls_itno = dw_priinfo.object.bom007_kryitno[ll_currow]

select count(*) into :ll_chkcnt
	from pbpdm.bom006
	where rfdvsn = :ls_dvsn and
			rfplant = :ls_plant and
			rfcitn = :ls_itno and
			rfgubn = 'Y' using sqlca;
if ll_chkcnt > 0 then
	uo_status.st_message.text = f_message("D040")
	return 0
end if

li_rtn = messagebox("알림",ls_itno + " 품번을 삭제하시겠습니까?",question!,yesno!,1)
if li_rtn = 2 then
	uo_status.st_message.text = f_message("D030")
	return 0
end if

delete from pbpdm.bom007
	where kryplant = :ls_plant and
			krydvsn = :ls_dvsn and
			kryitno = :ls_itno  using sqlca;
			
if sqlca.sqlcode = 0 then
	this.triggerevent("ue_retrieve",0,1)
	wf_dsp_reset()
	uo_status.st_message.text = f_message("D010")
else
	uo_status.st_message.text = f_message("D020") //bom007 delete error
	return 0
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom117u
end type

type dw_priinfo from datawindow within w_bom117u
integer x = 14
integer y = 184
integer width = 3579
integer height = 1156
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom001_117u_priinfo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row <= 0 then
	return 0
end if
this.selectrow(0, false)
this.selectrow(row,true)

end event

event doubleclicked;if row <= 0 then 
	return 0
end if

long ll_currow
string ls_plant, ls_dvsn,ls_itno,ls_rtnstr
datawindowchild dwc_pdcd
integer net
if i_s_level = "5" then
	dw_reginfo.accepttext()
	if dw_reginfo.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U090"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

uo_status.st_message.text = ""
i_s_state = 'm'      //수정상태
wf_init_reset()
ll_currow = this.getselectedrow(0)
ls_plant = this.object.bom007_kryplant[ll_currow]
ls_dvsn = this.object.bom007_krydvsn[ll_currow]
ls_itno = this.object.bom007_kryitno[ll_currow]

i_dwc_plant.retrieve('SLE220')
//공장 DDDW
i_dwc_dvsn.retrieve('DAC030')
//제품군 DDDW
i_dwc_pdcd.retrieve(ls_dvsn)

ls_rtnstr = trim(f_bom_get_balance(ls_plant,ls_dvsn,ls_itno))
dw_reginfo.object.itclsb.text = mid(ls_rtnstr,1,2)
dw_reginfo.object.itsrce.text = mid(ls_rtnstr,6,2)

if dw_reginfo.retrieve(ls_plant,ls_dvsn,ls_itno) > 0 then
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event rbuttondown;MenuBOM	newmenu
newmenu =create MenuBOM
newmenu.m_kew.m_insert.enabled = true
newmenu.m_kew.m_delete.enabled = true
newmenu.m_kew.m_retrieve.enabled = true
newmenu.m_kew.m_save.enabled = true
newmenu.m_kew.m_detail.enabled = false

newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
destroy MenuBOM

end event

type dw_reginfo from datawindow within w_bom117u
event ue_dwkeydown pbm_dwnkey
integer x = 14
integer y = 1352
integer width = 3579
integer height = 460
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom001_117u_reginfo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwkeydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if
end event

event buttonclicked;if dwo.name = 'b_find' then
	string ls_plant,ls_div,ls_pdcd,ls_parm
	uo_status.st_message.text = ""
	ls_plant = dw_reginfo.object.kryplant[1]
	ls_div = dw_reginfo.object.krydvsn[1]
	ls_pdcd  = dw_reginfo.object.krypdcd[1]
	if f_spacechk(ls_pdcd) = -1 then
		uo_status.st_message.text = "제품군을 선택해 주십시요"
		return 0
	end if
	ls_parm = ls_plant + ls_div + ls_pdcd

	openwithparm(w_bom110u_res_03,ls_parm)

	ls_parm = message.stringparm
	dw_reginfo.object.kryitno[1] = trim(ls_parm)
end if

end event

event rbuttondown;MenuBOM newmenu
newmenu =create MenuBOM
newmenu.m_kew.m_insert.enabled = true
newmenu.m_kew.m_delete.enabled = true
newmenu.m_kew.m_retrieve.enabled = true
newmenu.m_kew.m_save.enabled = true
newmenu.m_kew.m_detail.enabled = false

newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
destroy MenuBOM
end event

type uo_1 from uo_plandiv_bom within w_bom117u
integer x = 27
integer y = 20
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

