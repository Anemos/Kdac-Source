$PBExportHeader$w_bom112u.srw
$PBExportComments$Option 품목관리용윈도우
forward
global type w_bom112u from w_origin_sheet02
end type
type dw_mainitem from datawindow within w_bom112u
end type
type st_mdetail from statictext within w_bom112u
end type
type dw_regitem from datawindow within w_bom112u
end type
type pb_fitno from picturebutton within w_bom112u
end type
type st_sdetail from statictext within w_bom112u
end type
type gb_1 from groupbox within w_bom112u
end type
type dw_subitem from datawindow within w_bom112u
end type
type uo_1 from uo_plandiv_pdcd within w_bom112u
end type
type rb_1 from radiobutton within w_bom112u
end type
type rb_2 from radiobutton within w_bom112u
end type
end forward

global type w_bom112u from w_origin_sheet02
integer width = 4677
integer height = 2716
string title = "Option 품목관리"
dw_mainitem dw_mainitem
st_mdetail st_mdetail
dw_regitem dw_regitem
pb_fitno pb_fitno
st_sdetail st_sdetail
gb_1 gb_1
dw_subitem dw_subitem
uo_1 uo_1
rb_1 rb_1
rb_2 rb_2
end type
global w_bom112u w_bom112u

type variables
datastore 	ids_u_date
string 			is_selected	= "r" //수정과 입력을 구분하는 변수
string 			is_chkdata    		//새로운 주품번입력과 부품번입력을 구분하는 변수
integer 		in_chkpos
long 			ii_LastRow
end variables

forward prototypes
public function integer wf_get_chkitem (string a_plant, string a_div, string a_item)
public subroutine wf_date_update (string a_plant, string a_div, string a_opitn, string a_ofitn, string a_oedtm, string a_oedte, string a_ochdt)
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_rgbclear ()
public function integer wf_item_change (string a_plant, string a_chkmain, string a_chksub, string a_div, string a_oedtm, string a_oedte)
public function boolean wf_emp_chk ()
end prototypes

public function integer wf_get_chkitem (string a_plant, string a_div, string a_item);// Check main or subitem in DEPDMO.BOM001

string ls_check
SELECT "PBPDM"."BOM001"."PCITN"  	into :ls_check
FROM "PBPDM"."BOM001"  
WHERE 	"PBPDM"."BOM001"."PLANT" = :a_plant AND
			"PBPDM"."BOM001"."PCITN" = :a_item AND
	  		"PBPDM"."BOM001"."PDVSN" = :a_div 
Using sqlca;
if f_spacechk(ls_check) = -1 then
	return 0
else
	return 1
end if
end function

public subroutine wf_date_update (string a_plant, string a_div, string a_opitn, string a_ofitn, string a_oedtm, string a_oedte, string a_ochdt);string ls_ochdt, ls_oedte, ls_oedtm,ls_hold_oedtm, ls_hold_oedte
integer k,li_cnt,li_rtn
long ll_rowcnt,ll_currow

ids_u_date.reset()
ll_rowcnt = ids_u_date.retrieve(a_plant,a_div,a_opitn,a_ofitn,g_s_date)
ll_currow = ids_u_date.find("ochdt = '" + a_ochdt + "'", 1 , ll_rowcnt)

//적용일에서 완료일로 날짜변환
if ll_currow > 1 then
	for li_cnt = (ll_currow - 1) to 1 STEP -1
		ls_oedtm = ids_u_date.object.oedtm[li_cnt + 1]
		ls_oedte = ids_u_date.object.oedte[li_cnt]
		if (f_spacechk(ls_oedtm) <> -1 and ls_oedtm <= ls_oedte) or f_spacechk(ls_oedte) = -1 then
			ls_hold_oedte = f_relativedate(ls_oedtm,-1)
			ids_u_date.setitem( li_cnt,"oedte",ls_hold_oedte)
		elseif f_spacechk(ls_oedtm) = -1 and ls_oedtm <= ls_oedte then
			ls_hold_oedte = ls_oedtm
			ids_u_date.setitem( li_cnt,"oedte",ls_hold_oedte)
		end if	
	next
end if

//완료일에서 적용일로 날짜변환
if ll_currow < ll_rowcnt then
	for li_cnt = (ll_currow + 1) to ll_rowcnt
		ls_oedte = ids_u_date.object.oedte[li_cnt -1]
		ls_oedtm = ids_u_date.object.oedtm[li_cnt]
		if (f_spacechk(ls_oedte) <> -1 and ls_oedte >= ls_oedtm) or f_spacechk(ls_oedtm) = -1 then
			ls_hold_oedtm = f_relativedate(ls_oedte,1)
			ids_u_date.setitem( li_cnt,"oedtm",ls_hold_oedtm)
		elseif f_spacechk(ls_oedte) = -1 and f_spacechk(ls_oedtm) <> -1 then
			ls_hold_oedte = f_relativedate(ls_oedtm,-1)
			ids_u_date.setitem( li_cnt - 1,"oedte",ls_hold_oedte)
		end if		
	next
end if

li_rtn = ids_u_date.update()
if li_rtn = 1 and SQLCA.SQLNRows > 0 then
	commit using sqlca;
else
	rollback using sqlca;
end if
	
end subroutine

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	li_Idx, li_last_row

li_last_row = ii_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If li_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if li_last_row > al_aclickedrow then
	For li_Idx = li_last_row to al_aclickedrow STEP -1
		dw.selectrow(li_Idx,TRUE)	
	end for	
else
	For li_Idx = li_last_row to al_aclickedrow 
		dw.selectrow(li_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_rgbclear ();dw_regitem.object.opitn.background.color		 = 15780518				// White
dw_regitem.object.ofitn.background.color		 = 15780518
dw_regitem.object.oedtm.background.color		 = rgb(255,255,255)
dw_regitem.object.oedte.background.color		 = rgb(255,255,255)

end subroutine

public function integer wf_item_change (string a_plant, string a_chkmain, string a_chksub, string a_div, string a_oedtm, string a_oedte);string 	ls_chkmain,ls_miditem,ls_ochcd,ls_ofocd
dec{2} 	lc_orate
long 		ll_currow,ll_currow1,ll_rowcnt
integer 	li_rtn,li_cnt
ll_currow = dw_subitem.getrow()
ll_rowcnt = dw_subitem.rowcount()

for li_cnt = 1 to ll_rowcnt
	ls_chkmain 	= dw_subitem.object.ofitn[li_cnt]
	ls_ochcd 	= dw_subitem.object.ochcd[li_cnt]
	ls_ofocd 	= dw_subitem.object.ofocd[li_cnt]
	lc_orate 	= dw_subitem.object.orate[li_cnt]
	if li_cnt 	= 1 then
		if trim(ls_chkmain) <> trim(a_chksub) then
			Insert Into "PBPDM"."BOM003"  
         				( 	"OCMCD","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  			"OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
			Values (	:g_s_company,:a_plant,:a_div,:a_chksub,:ls_chkmain,:g_s_date,:a_oedtm,:a_oedte,:lc_orate,
		  				:ls_ochcd,:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date	)
			Using sqlca;
		end if
		ls_miditem = ls_chkmain
	else
		if trim(ls_chkmain) <> trim(a_chksub) and trim(ls_chkmain) <> trim(ls_miditem) then
			Insert Into "PBPDM"."BOM003"   
         				( 	"OCMCD","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  		"OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
			Values (	:g_s_company,:a_plant,:a_div,:a_chksub,:ls_chkmain,:g_s_date,:a_oedtm,:a_oedte,:lc_orate,
		  				:ls_ochcd,:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date)
			Using sqlca;
		end if
		ls_miditem = ls_chkmain
	end if	
next
//수정된 데이타 교체 Script 끝
return 1
end function

public function boolean wf_emp_chk ();string	ls_xplemp

select	xplemp	into	:ls_xplemp	from	pbpdm.bom018
where	xcmcd =	'01'	and	xinemp	=	:g_s_empno
using	sqlca	;
if	f_spacechk(ls_xplemp)	=	-1	then
	messagebox("확인","담당 PL 이 지정되지 않은 입력자입니다.~r~n BOM등록 프로그램에서 P/L선택 후 작업을 계속하시기 바랍니다 ")
	return	false
end if
return	true
end function

on w_bom112u.create
int iCurrent
call super::create
this.dw_mainitem=create dw_mainitem
this.st_mdetail=create st_mdetail
this.dw_regitem=create dw_regitem
this.pb_fitno=create pb_fitno
this.st_sdetail=create st_sdetail
this.gb_1=create gb_1
this.dw_subitem=create dw_subitem
this.uo_1=create uo_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mainitem
this.Control[iCurrent+2]=this.st_mdetail
this.Control[iCurrent+3]=this.dw_regitem
this.Control[iCurrent+4]=this.pb_fitno
this.Control[iCurrent+5]=this.st_sdetail
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_subitem
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.rb_1
this.Control[iCurrent+10]=this.rb_2
end on

on w_bom112u.destroy
call super::destroy
destroy(this.dw_mainitem)
destroy(this.st_mdetail)
destroy(this.dw_regitem)
destroy(this.pb_fitno)
destroy(this.st_sdetail)
destroy(this.gb_1)
destroy(this.dw_subitem)
destroy(this.uo_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;call super::ue_retrieve;setpointer(hourglass!)
int net
int rowcount
string ls_div,ls_plant,ls_pdcd,ls_rtncd
if i_s_level = "5" then
	dw_regitem.accepttext()
	if dw_regitem.modifiedcount() > 0 then
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
in_chkpos = 0
rb_1.hide()
rb_2.hide()
pb_fitno.hide()
dw_mainitem.reset()
dw_subitem.reset()
dw_regitem.reset()
wf_rgbclear()
ls_rtncd = 	uo_1.uf_return()
ls_div 	= 	mid(ls_rtncd,2,1)
ls_pdcd	=	trim(mid(ls_rtncd,3)) + "%"
ls_plant = 	mid(ls_rtncd,1,1)

if dw_mainitem.retrieve(ls_plant,ls_div,ls_pdcd,g_s_date) < 1 then
	uo_status.st_message.text = f_message("I020")
else
	uo_status.st_message.text = f_message("I010")
end if
//조회,입력,저장,삭제 ,상세조회,화면인쇄,특수문자
i_b_insert = true
i_b_save = true
i_b_delete = true

wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
				  i_b_dprint,    i_b_dchar)
return 0

end event

event ue_insert;int 		net
long 		ll_currow
string 	ls_cocode,ls_plant,ls_mainitem, ls_rtncd

if i_s_level = "5" then
	dw_regitem.accepttext()
	if dw_regitem.modifiedcount() > 0 then
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

in_chkpos = 0
dw_regitem.object.opitn.protect	=	false
dw_regitem.object.ofitn.protect	=	false
dw_regitem.object.gb_1.visible 	= 	false
pb_fitno.show()

wf_rgbclear()

rb_1.hide()
rb_2.hide()
dw_regitem.reset()
dw_regitem.insertrow(0)

ls_rtncd 	= uo_1.uf_return()
ls_cocode	= mid(ls_rtncd,2,1)
ls_plant 	= mid(ls_rtncd,1,1)

ll_currow	=	dw_mainitem.getselectedrow(0)
is_chkdata 	= 	'P'
dw_regitem.object.oemno[1]		= g_s_empno
dw_regitem.object.oindt[1] 	= g_s_date
dw_regitem.object.oplant[1] 	= ls_plant
dw_regitem.object.odvsn[1] 	= ls_cocode
dw_regitem.object.oedtm[1] 	= f_relativedate(g_s_date,1)

//부품번 등록초기화
if ll_currow > 0 then
	ls_mainitem = trim(dw_mainitem.object.bom003_opitn[ll_currow])
	net = messagebox("확인",ls_mainitem + "의 부품목 추가는 'Y', 신규 주품목의 추가는 'N' 입니다!",question!,yesno!,1)
	if net = 1 then
		dw_regitem.object.opitn.protect=true
		is_chkdata = 'S'
		dw_regitem.object.opitn.background.color=rgb(192,192,192)
		dw_regitem.object.opitn[1] = ls_mainitem
		dw_regitem.setcolumn("ofitn")
		dw_regitem.setfocus()
	else
		dw_regitem.object.oedte.background.color=rgb(255,255,255)
		dw_regitem.object.oedte.background.color=rgb(255,255,255)
		dw_regitem.setcolumn("opitn")
		dw_regitem.setfocus()
	end if
//주품번 등록초기화
else
	dw_regitem.object.oedte.background.color=rgb(255,255,255)
	dw_regitem.object.oedte.background.color=rgb(255,255,255)
	dw_regitem.setcolumn("opitn")
	dw_regitem.setfocus()
end if
is_selected = "i"
is_chkdata=ls_mainitem
//조회,입력,저장,삭제 ,상세조회,화면인쇄,특수문자
i_b_retrieve=true
i_b_insert = true
i_b_save = true
i_b_delete = false

wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)
return 0
end event

event ue_save;if	wf_emp_chk()	=	false	then
	return
end if

string 		ls_chkmain,ls_chksub,ls_chkdte,ls_chkdtm,ls_column,ls_div,ls_pdcd,ls_ochdt,ls_selitem1, &
			ls_ofocd,ls_oemno,ls_oindt,ls_selitem,ls_rtnchk,ls_oedte_hold,ls_oedtm_hold,ls_ochdt_hold
string 		ls_plant, ls_rtncd
integer 	li_mcnt=0,li_scnt=0,li_ucnt,li_rtn
dec{2} 	lc_orate
long 		ll_currow=0,ll_currow1=0,ll_rowcnt=0
str_option_data lstr_option

dw_regitem.accepttext()
ll_currow		=	dw_subitem.getrow()
ll_rowcnt 		= 	dw_subitem.rowcount()
ls_rtncd 		= 	uo_1.uf_return()  
ls_div			= 	mid(ls_rtncd,2,1)										//공장
ls_pdcd		=	trim(mid(ls_rtncd,3)) + "%"							//제품군
ls_plant 		= 	mid(ls_rtncd,1,1)
ls_chkmain	=	upper(trim(dw_regitem.object.opitn[1]))		//호환주품번
ls_chksub	=	upper(trim(dw_regitem.object.ofitn[1]))		//호환부품번
ls_ochdt		=	dw_regitem.object.ochdt[1]							//수정일자
ls_chkdtm		=	dw_regitem.object.oedtm[1]						//적용일자
ls_chkdte		=	dw_regitem.object.oedte[1]						//완료일자
lc_orate		=	dw_regitem.object.orate[1]							//호환율
ls_ofocd		=	dw_regitem.object.ofocd[1]							//Feature/Option Code
ls_oemno		=	dw_regitem.object.oemno[1]							//입력자사번
ls_oindt		=	dw_regitem.object.oindt[1]							//입력일자
dw_regitem.object.opitn[1]	=	ls_chkmain
dw_regitem.object.ofitn[1]		=	ls_chksub
wf_rgbclear()

//initial value
if f_spacechk(ls_chkdtm) = -1 then
	dw_regitem.object.oedtm[1] = ''
	ls_chkdtm = ''
end if
if f_spacechk(ls_chkdte) = -1 then
	dw_regitem.object.oedte[1] = ''
	ls_chkdte = ''
end if
if isnull(lc_orate) = true then
	dw_regitem.object.orate[1] = 0
	lc_orate = 0
end if
if f_spacechk(ls_ofocd) = -1 then
	dw_regitem.object.ofocd[1] = ''
	ls_ofocd = ''
end if
// Common Check Script-Insert and Modify
if f_spacechk(ls_chkmain) 		= -1 then
	dw_regitem.object.opitn.background.color=rgb(255,255,0)
	if f_spacechk(ls_column) 	= -1 then
		ls_column="opitn"
	end if
end if

if f_spacechk(ls_chksub) 		= -1 then
	dw_regitem.object.ofitn.background.color=rgb(255,255,0)
	if f_spacechk(ls_column) 	= -1 then
		ls_column="ofitn"
	end if
end if

if f_spacechk(ls_chkdte) = -1 then
	dw_regitem.object.oedte[1] = ''
else
	if f_dateedit(ls_chkdte) = "        " then
		dw_regitem.object.oedte.background.color=rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column="oedte"
		end if
	end if
end if

if f_spacechk(ls_chkdtm) = -1 then
	ls_chkdtm=f_relativedate(g_s_date,1)
	ls_oedtm_hold = g_s_date
else
	ls_oedtm_hold = f_relativedate(ls_chkdtm,-1)
	if f_dateedit(ls_chkdtm) = "        " then
		dw_regitem.object.oedtm.background.color=rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column="oedtm"
		end if
	end if
end if

// 유무상 혼용방지 체크(2011.09.29)
select pwkct into :ls_rtncd
from pbpdm.bom001 a
where a.pcmcd = :g_s_company and a.plant = :ls_plant and
a.pdvsn = :ls_div and a.pcitn = :ls_chkmain and
(( a.pedte = ' '  and a.pedtm <= :ls_chkdtm ) or
( a.pedte <> ' ' and a.pedtm <= :ls_chkdtm
					 and a.pedte >= :ls_chkdtm ))
fetch first 1 row only
using sqlca;

if ls_rtncd = '8888' or ls_rtncd = '9999' then
	select pwkct into :ls_rtnchk
	from pbpdm.bom001 a
	where a.pcmcd = :g_s_company and a.plant = :ls_plant and
	a.pdvsn = :ls_div and a.pcitn = :ls_chksub and
	(( a.pedte = ' '  and a.pedtm <= :ls_chkdtm ) or
	( a.pedte <> ' ' and a.pedtm <= :ls_chkdtm
						 and a.pedte >= :ls_chkdtm ))
	fetch first 1 row only
	using sqlca;
	
	if ls_rtnchk = '8888' or ls_rtnchk = '9999' then
		if ls_rtncd <> ls_rtnchk then
			uo_status.st_message.text = "호환주/부품번은 유무상이 동일해야 호환등록이 가능합니다."
			return -1
		end if
	end if
end if
// 수정시 Check script
if is_selected = "r" then
	if dw_regitem.modifiedcount() > 0 then
		dw_regitem.setitem( 1 ,"oemno",g_s_empno)
		ls_oemno = g_s_empno
		if f_spacechk(ls_ochdt) = -1 then
			dw_regitem.setitem( 1 ,"ochdt",g_s_date)
			ls_ochdt = g_s_date
		end if
	else
		dw_subitem.setfocus()
		uo_status.st_message.text=f_message("E020")
		return 0
	end if
	
	if dw_subitem.object.oedte[ll_currow] = g_s_date and &
      	dw_subitem.object.ochdt[ll_currow] = g_s_date then
		dw_regitem.object.oedte.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("E290")
		return 0
	end if	
	
	//Mbom에서 상위품번 Check Script
	ls_rtnchk 	= f_bom_check(ls_plant,ls_div,ls_chkmain,ls_chksub,ls_chkdtm,ls_chkdte) 
	if f_spacechk(ls_rtnchk) = -1 then
		//nothing
	elseif mid(ls_rtnchk,1,1) = "i" then
		uo_status.st_message.text=f_message("E330")
		openwithparm(w_bom112u_detail,(ls_plant + ls_div + ls_chkmain))
		return 0
	elseif mid(ls_rtnchk,1,1) = "d" then
		uo_status.st_message.text = f_message("E290")
		openwithparm(w_bom112u_detail,(ls_plant + ls_div + ls_chkmain))
		return 0
	end if

end if

//날짜 Check Script
if f_spacechk(ls_chkdtm) = -1 then
	if f_spacechk(ls_chkdte) = -1 then
		dw_regitem.object.oedtm[1] = f_relativedate(g_s_date,1)
	else
		if ls_chkdte >= g_s_date then
			//nothing
		else
			dw_regitem.object.oedte.background.color=rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
				ls_column="oedte"
			end if
		end if
	end if
else
	if f_spacechk(ls_chkdte) = -1 then
		if ls_chkdtm <= g_s_date then
			dw_regitem.object.oedtm.background.color=rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
				ls_column="oedtm"
			end if
		else
			//nothing
		end if
	else
		if ls_chkdtm > g_s_date and &
				ls_chkdte >= g_s_date and &
					ls_chkdtm <= ls_chkdte then
			//nothing
		else
			uo_status.st_message.text=f_message("E290")
			dw_regitem.object.oedtm.background.color=rgb(255,255,0)
			if f_spacechk(ls_column) = -1 then
				ls_column="oedtm"
			end if
		end if
	end if		
end if
if len(ls_column) > 0 then
	dw_regitem.setcolumn(ls_column)
	dw_regitem.setfocus()
	uo_status.st_message.text=f_message("E010")
	i_n_erreturn=-1
	return 0
end if
	
// 입력시 Check Script
if is_selected = "i" then
	dw_regitem.setitem( 1 ,"ochdt",g_s_date)
	ls_ochdt = g_s_date
	//Master에서 품번조회
	ls_selitem=f_bom_get_itemnbr(ls_plant,ls_div,ls_chkmain)
	if isnull(ls_selitem) or ls_selitem <> ls_chkmain then
		dw_regitem.object.opitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("E320")
		return 0
	else
		//nothing
	end if
	ls_selitem1=f_bom_get_itemnbr(ls_plant,ls_div,ls_chksub)
	if isnull(ls_selitem) or ls_selitem1 <> ls_chksub then
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("E320")
		return 0
	else
		//nothing
	end if
	
	//호환DB Check
	if ls_chkmain=ls_chksub then
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("A060")
		return 0
	end if
	
	//주품번의 존재
	SELECT count(*) INTO :li_mcnt	FROM "PBPDM"."BOM003"
	WHERE 	"PBPDM"."BOM003"."OPLANT"= :ls_plant AND
				"PBPDM"."BOM003"."ODVSN"= :ls_div AND
				"PBPDM"."BOM003"."OPITN"= :ls_chkmain AND
		 		"PBPDM"."BOM003"."OFITN"= :ls_chksub AND
				("PBPDM"."BOM003"."OEDTE" >= :ls_chkdtm OR
				"PBPDM"."BOM003"."OEDTE" = '')  
	using sqlca; 
	if li_mcnt > 0 then
		dw_regitem.object.opitn.background.color	=	rgb(255,255,0)
		dw_regitem.object.ofitn.background.color	=	rgb(255,255,0)
		uo_status.st_message.text						=	f_message("A060")
		return 0
	end if
	
	SELECT count(*) INTO :li_mcnt	FROM "PBPDM"."BOM003"
		WHERE 	"PBPDM"."BOM003"."OPLANT"	= :ls_plant AND
					"PBPDM"."BOM003"."ODVSN"	= :ls_div AND
					"PBPDM"."BOM003"."OPITN"	= :ls_chksub AND
					"PBPDM"."BOM003"."OFITN"	= :ls_chkmain AND
					("PBPDM"."BOM003"."OEDTE" 	>= :ls_chkdtm OR
					"PBPDM"."BOM003"."OEDTE" 	= '')  
	using sqlca; 
				 
	if li_mcnt > 0 then
		dw_regitem.object.opitn.background.color=rgb(255,255,0)
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("A060")
		return 0
	end if
	
	//Mbom에서 품번조회
	if wf_get_chkitem(ls_plant,ls_div,ls_chkmain) = 0  then
		dw_regitem.object.opitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("E330")
		return 0
	end if
	
	if wf_get_chkitem(ls_plant,ls_div,ls_chksub)=0 then
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("E330")
		return 0
	end if
	
	//Mbom에서 상위품번 Check Script
	ls_rtnchk = f_bom_check(ls_plant,ls_div,ls_chkmain,ls_chksub,ls_chkdtm,ls_chkdte) 
	if f_spacechk(ls_rtnchk) = -1 then
		//nothing
	elseif mid(ls_rtnchk,1,1) = "i" then
		uo_status.st_message.text=f_message("E330")
		lstr_option.str_plant = ls_plant
		lstr_option.str_dvsn = ls_div
		lstr_option.str_opitn = ls_chkmain
		lstr_option.str_ofitn = ls_chksub
		lstr_option.str_applydate = ls_chkdtm
		openwithparm(w_bom112u_detail,lstr_option)
		return 0
	elseif mid(ls_rtnchk,1,1) = "d" then
		uo_status.st_message.text =f_message("E290")
		lstr_option.str_plant = ls_plant
		lstr_option.str_dvsn = ls_div
		lstr_option.str_opitn = ls_chkmain
		lstr_option.str_ofitn = ls_chksub
		lstr_option.str_applydate = ls_chkdtm
		openwithparm(w_bom112u_detail,lstr_option)
		return 0
	end if

end if

// Update Logic-입력
if is_selected="i" then
	dw_regitem.object.ochcd[1] 		=	"A"
	dw_regitem.object.ocmcd[1] 		= 	g_s_company
	dw_regitem.object.omacaddr[1] 	= 	g_s_macaddr
	dw_regitem.object.oipaddr[1] 	= 	g_s_ipaddr
	if dw_regitem.update() = 1 then
		commit using sqlca;
		uo_status.st_message.text = f_message("A010")
		if is_chkdata = ls_chkmain then				// 부품번 입력후 화면 처리
			dw_subitem.reset()
			dw_regitem.reset()
			dw_subitem.retrieve(ls_plant,ls_div,ls_chkmain,g_s_date)
		else													// 주품번 입력후 화면 처리		
			dw_mainitem.reset()
			dw_subitem.reset()
			dw_regitem.reset()
			rb_1.hide()
			rb_2.hide()
			pb_fitno.hide()
			dw_mainitem.retrieve(ls_plant,ls_div,ls_pdcd,g_s_date)
		end if
	else
		i_n_erreturn = -1
		rollback using sqlca;
		uo_status.st_message.text=f_message("A020")
		return 0
	end if
	if	f_bom_approve(ls_plant,ls_div,ls_chksub,ls_chkmain,'O','A',dw_regitem,dw_regitem.object.oedtm[1],1)	<>	0	then
		messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
		return
	end if
	
	
	//MBOM 호환 CHECK CODE UPDATE
//	li_ucnt=f_upmbom_chkcode(ls_div,ls_chkmain,ls_chksub) 
//	if li_ucnt = 1 or li_ucnt = 2 then
//		uo_status.st_message.text= f_message("A020")
//		return
//	end if
// Update Logic-수정
else
	SELECT count(*) INTO :li_scnt	FROM "PBPDM"."BOM003"
		WHERE "PBPDM"."BOM003"."OPLANT"	= :ls_plant AND
				"PBPDM"."BOM003"."ODVSN"		= :ls_div AND
				"PBPDM"."BOM003"."OPITN"		= :ls_chkmain AND
				"PBPDM"."BOM003"."OFITN"			= :ls_chksub AND
				"PBPDM"."BOM003"."OCHDT"		= :g_s_date  using sqlca;
	//Update modify twice at a day
	if li_scnt > 0 then 
		if rb_1.checked = false then
			//Data 만 수정된 경우
			if dw_regitem.update() = 1 then
				commit using sqlca;
				wf_date_update( ls_plant,ls_div,ls_chkmain,ls_chksub,ls_chkdtm,ls_chkdte,ls_ochdt)
				uo_status.st_message.text=f_message("A010")
				dw_subitem.reset()
				dw_regitem.reset()
				dw_subitem.retrieve(ls_plant,ls_div,ls_chkmain,g_s_date)
				rb_1.hide()
				rb_2.hide()
				pb_fitno.hide()
			else
				i_n_erreturn = -1
				rollback using sqlca;
				uo_status.st_message.text=f_message("A020")
				return 0
			end if
			
			if	f_bom_approve(ls_plant,ls_div,ls_chksub,ls_chkmain,'O','R',dw_regitem,dw_regitem.object.oedtm[1],1)	<>	0	then
				messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
				return
			end if
			
		else
			//주품번과 부품번이 교체된 경우
			//주어진 시작일과 완료일로 UPDATE
			UPDATE 	"PBPDM"."BOM003"
				SET 	"OEDTE" = :ls_oedtm_hold 
			WHERE 	"PBPDM"."BOM003"."OPLANT" 	= :ls_plant 	AND
						"PBPDM"."BOM003"."ODVSN" 	= :ls_div 		AND
						"PBPDM"."BOM003"."OPITN"	= :ls_chkmain  AND
					(	"PBPDM"."BOM003"."OEDTE" 	> :g_s_date 	OR
						"PBPDM"."BOM003"."OEDTE" 	= '')
			using sqlca;
			INSERT INTO "PBPDM"."BOM003"  
         			(	"OCMCD","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  			"OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT"	)  
  			VALUES 	(	:g_s_company,:ls_plant,:ls_div,:ls_chksub,:ls_chkmain,:g_s_date,:ls_chkdtm,:ls_chkdte,:lc_orate,
							'A',:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date	)
			using sqlca;
			if sqlca.sqlcode < 0 then
				i_n_erreturn = -1
				uo_status.st_message.text=f_message("U020")
				return 0
			else
				uo_status.st_message.text=f_message("U010")
			end if
			//MBOM 호환 CHECK CODE UPDATE
//			li_ucnt=f_upmbom_chkcode(ls_div,ls_chksub,ls_chkmain) 
//
//			if li_ucnt = 1 or li_ucnt = 2 then
//				uo_status.st_message.text= f_message("U020")
//				return
//			end if
			
			//기타 부품번들 UPDATE
			li_rtn = wf_item_change(ls_plant,ls_chkmain,ls_chksub,ls_div,ls_chkdtm,ls_chkdte)
			if li_rtn = 0 then
				return 0
			end if
			
			if	f_bom_approve(ls_plant,ls_div,ls_chkmain,ls_chksub,'O','X',dw_regitem,ls_chkdtm,1)	<>	0	then
				messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
				return
			end if
						
			dw_mainitem.reset()
			dw_subitem.reset()
			rb_1.hide()
			rb_2.hide()
			pb_fitno.hide()
			dw_regitem.reset()
			dw_mainitem.retrieve(ls_plant,ls_div,ls_pdcd,g_s_date)	
		end if		
	else
		if rb_1.checked = false then
			//Old Record of Modification
			UPDATE 	"PBPDM"."BOM003"
				SET 	"OCHCD" = 'R'
			WHERE 	"PBPDM"."BOM003"."OPLANT" 	= :ls_plant AND
						"PBPDM"."BOM003"."ODVSN" 	= :ls_div AND
						"PBPDM"."BOM003"."OPITN"	= :ls_chkmain AND 
						"PBPDM"."BOM003"."OFITN" 	= :ls_chksub AND
						"PBPDM"."BOM003"."OCHDT"	= :ls_ochdt using sqlca;
			
			if sqlca.sqlnrows > 0 then
				commit using sqlca;
				uo_status.st_message.text=f_message("U010")
			else
				i_n_erreturn=-1
				rollback using sqlca;
				uo_status.st_message.text=f_message("U020")
				return 0
			end if
	
			//New Record of Modification
			ls_oemno=g_s_empno
			//ls_chkdtm=f_relativedate(g_s_date,1)
			INSERT INTO "PBPDM"."BOM003"  
         			(	"OCMCD","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  			"OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT"	)  
  			VALUES 	(	:g_s_company,:ls_plant,:ls_div,:ls_chkmain,:ls_chksub,:g_s_date,:ls_chkdtm,:ls_chkdte,:lc_orate,
			  		  		'A',:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date	)
			using sqlca;

			if sqlca.sqlcode < 0 then
				i_n_erreturn = -1
				uo_status.st_message.text=f_message("U020")
				return 0
			else
				wf_date_update( ls_plant,ls_div,ls_chkmain,ls_chksub,ls_chkdtm,ls_chkdte,ls_ochdt)
				uo_status.st_message.text=f_message("U010")
				dw_subitem.reset()
				rb_1.hide()
				rb_2.hide()
				pb_fitno.hide()
				dw_subitem.retrieve(ls_plant,ls_div,ls_chkmain,g_s_date)
				dw_regitem.reset()	
			end if
			
			if	f_bom_approve(ls_plant,ls_div,ls_chksub,ls_chkmain,'O','A',dw_regitem,ls_chkdtm,1)	<>	0	then
				messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
				return
			end if
			
		else
			//부품번을 주품번으로 Update
			//주어진 시작일과 완료일로 UPDATE
			UPDATE 	"PBPDM"."BOM003"
				SET 	"OEDTE" = :ls_oedtm_hold 
			WHERE 	"PBPDM"."BOM003"."OPLANT" 	= :ls_plant 	AND
						"PBPDM"."BOM003"."ODVSN" 	= :ls_div 		AND
						"PBPDM"."BOM003"."OPITN"	= :ls_chkmain  AND
					(	"PBPDM"."BOM003"."OEDTE" 	> :g_s_date 	OR
						"PBPDM"."BOM003"."OEDTE" 	= '')
			using sqlca;
			
			INSERT INTO "PBPDM"."BOM003"  
         					( 	"OCMCD","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           				"OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT"	)  
  			VALUES 	(	:g_s_company,:ls_plant,:ls_div,:ls_chksub,:ls_chkmain,:g_s_date,:ls_chkdtm,:ls_chkdte,:lc_orate,
			  				'A',:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date	)
			using sqlca;
			if sqlca.sqlcode < 0 then
				i_n_erreturn = -1
				uo_status.st_message.text=f_message("U020")
				return 0
			else
				uo_status.st_message.text=f_message("U010")
			end if
			//기타 부품번들 Update
			li_rtn = wf_item_change(ls_plant,ls_chkmain,ls_chksub,ls_div,ls_chkdtm,ls_chkdte)
			if li_rtn = 0 then
				return 0
			end if
			if	f_bom_approve(ls_plant,ls_div,ls_chksub,ls_chkmain,'O','X',dw_regitem,ls_chkdtm,1)	<>	0	then
				messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
				return
			end if
			dw_mainitem.reset()
			dw_subitem.reset()
			rb_1.hide()
			rb_2.hide()
			pb_fitno.hide()
			dw_regitem.reset()
			dw_mainitem.retrieve(ls_plant,ls_div,ls_pdcd,g_s_date)
		end if
	end if
end if
return 0

end event

event ue_delete;integer 	li_rc,li_cnt,li_tot
long 		ll_row,ll_row1,ll_curmain,ll_rowcnt
string 	ls_rtncd
if	wf_emp_chk()	=	false	then
	return
end if

string 	ls_subitem,ls_mainitem,ls_plant,ls_div,ls_pdcd,ls_ochdt, &
			ls_oedtm,ls_ofocd,ls_oindt,ls_pops=" ",ls_popf=" "
dec{2} lc_orate
// 주품번과 부품번의 삭제 선택Code
ll_row 		= dw_subitem.getselectedrow(0)
ll_curmain 	= dw_mainitem.getrow()
ll_rowcnt 	= dw_subitem.rowcount()
//삭제시 Check Script
if ll_curmain < 1 then
	uo_status.st_message.text = f_message("D100")
	return 0
end if
if is_selected = "i" then
	uo_status.st_message.text = f_message("D100")
	return 0
end if

ls_rtncd 	= uo_1.uf_return()
ls_div 		= mid(ls_rtncd,2,1)
ls_pdcd 		= mid(ls_rtncd,3)
ls_plant 	= mid(ls_rtncd,1,1)
ls_mainitem = trim(dw_mainitem.object.bom003_opitn[ll_curmain])
if ll_row <> 0 then
	li_rc = messagebox("삭제확인", "선택된 품번(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
	if li_rc <> 1 then
		uo_status.st_message.text = f_message("D030")
		return 0
	end if
else
	uo_status.st_message.text = f_message("D100")
	return 0
end if
		//Delete current row about dw_mainitem
do until ll_row = 0 
	ls_subitem	=	trim(dw_subitem.object.ofitn[ll_row])
	ls_ochdt		=	dw_subitem.object.ochdt[ll_row]
	ls_oedtm		=	dw_subitem.object.oedtm[ll_row]
	lc_orate		=	dw_subitem.object.orate[ll_row]
	ls_ofocd		=	dw_subitem.object.ofocd[ll_row]
	ls_oindt		=	dw_subitem.object.oindt[ll_row]
	//delete at current DB
	UPDATE "PBPDM"."BOM003"
		SET "OEDTE"= :g_s_date, "OCHCD" = 'D'
	WHERE "PBPDM"."BOM003"."OPLANT" 	= :ls_plant AND
			"PBPDM"."BOM003"."ODVSN" 	= :ls_div AND
			"PBPDM"."BOM003"."OPITN"	= :ls_mainitem AND 
			"PBPDM"."BOM003"."OFITN" 	= :ls_subitem AND
			"PBPDM"."BOM003"."OCHDT"	= :ls_ochdt using sqlca;
	if sqlca.sqlcode = 0 then
		commit using sqlca;
	else
		rollback using sqlca;
		i_n_erreturn = -1
		uo_status.st_message.text= f_message("D020")
		return 0
	end if
	ll_row = dw_subitem.getselectedrow(ll_row)
loop

if	f_bom_approve(ls_plant,ls_div,ls_mainitem,'','O','D',dw_subitem,g_s_date,1)	<>	0	then
	messagebox("확인","승인 정보 입력중 오류 발생.시스템개발팀으로 문의바랍니다")
	return
end if

uo_status.st_message.text=f_message("D010")
dw_subitem.reset()
rb_1.hide()
rb_2.hide()
dw_regitem.reset()
ll_row1 = dw_subitem.retrieve(ls_plant,ls_div,ls_mainitem,g_s_date)
if ll_row1 < 1 then
	dw_mainitem.reset()
	dw_mainitem.retrieve(ls_plant,ls_div,ls_pdcd,g_s_date)
end if
return 0
end event

event activate;call super::activate;wf_icon_onoff(true,true,true,true,true,false,false,false,false,false,false,false)

end event

event open;call super::open;ids_u_date = create datastore
ids_u_date.dataobject = "d_bom001_112u_redate"
ids_u_date.settransobject(sqlca)
dw_mainitem.settransobject(sqlca)
dw_subitem.settransobject(sqlca)
dw_regitem.settransobject(sqlca)
rb_1.hide() 
rb_2.hide()
in_chkpos = 0
this.pb_fitno.visible = false
end event

event closequery;call super::closequery;int net

if i_s_level = "5" then
	dw_regitem.accepttext()
	if dw_regitem.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
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
end event

event close;call super::close;destroy ids_u_date
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom112u
end type

type dw_mainitem from datawindow within w_bom112u
integer x = 23
integer y = 348
integer width = 1371
integer height = 2120
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom001_priitem"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;string ls_toitem,ls_opitn,ls_div,ls_plant, ls_rtncd
long ll_currow
ll_currow = dw_mainitem.getselectedrow(0)
MenuBOM newmenu
newmenu =create MenuBOM
newmenu.m_kew.m_insert.enabled = true
newmenu.m_kew.m_delete.enabled = false
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_save.enabled = false
newmenu.m_kew.m_detail.enabled = true

ls_rtncd = uo_1.uf_return()
ls_div = mid(ls_rtncd,2,1)
ls_plant = mid(ls_rtncd,1,1)

if ll_currow < 1 then
	ls_toitem= ls_plant + ls_div
	message.stringparm = ls_toitem
else
	ls_opitn=dw_mainitem.object.bom003_opitn[ll_currow]
	ls_toitem = ls_plant + ls_div + ls_opitn
	message.stringparm=ls_toitem
end if
newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
destroy MenuBOM

if in_chkpos = 1 then
	rb_1.show()
	rb_2.show()
end if

end event

event doubleclicked;integer li_rowcnt
string ls_data,ls_div,ls_plant,ls_rtncd

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

rb_1.hide()
rb_2.hide()
pb_fitno.hide()
dw_subitem.visible = true
dw_subitem.reset()
dw_regitem.reset()

this.selectrow(row,true)

ls_rtncd = uo_1.uf_return()
ls_div = mid(ls_rtncd,2,1)
ls_plant = mid(ls_rtncd,1,1)

ls_data = dw_mainitem.object.bom003_opitn[row]
dw_subitem.retrieve(ls_plant,ls_div,ls_data,g_s_date)


end event

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

rb_1.hide()
rb_2.hide()
pb_fitno.hide()
dw_subitem.visible = true
dw_subitem.reset()
dw_regitem.reset()
end event

type st_mdetail from statictext within w_bom112u
integer x = 27
integer y = 252
integer width = 585
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "OPTION 주품목 "
alignment alignment = right!
long bordercolor = 33554432
boolean focusrectangle = false
end type

type dw_regitem from datawindow within w_bom112u
event ue_keydown pbm_keydown
integer x = 1417
integer y = 1920
integer width = 3045
integer height = 548
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom001_regitem"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_save")
end if
end event

event rbuttondown;string 	ls_toitem,ls_opitn,ls_div,ls_plant,ls_rtncd
long 		ll_currow

ll_currow = dw_mainitem.getselectedrow(0)
MenuBOM 	newmenu
newmenu 	=	create MenuBOM
newmenu.m_kew.m_insert.enabled 	= false
newmenu.m_kew.m_delete.enabled 	= false
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_save.enabled 		= true
newmenu.m_kew.m_detail.enabled 	= true
ls_rtncd = uo_1.uf_return()
ls_div 	= mid(ls_rtncd,2,1)
ls_plant = mid(ls_rtncd,1,1)

if ll_currow < 1 then
	ls_toitem	= ls_plant + ls_div
	message.stringparm = ls_toitem
else
	ls_opitn		=	dw_mainitem.object.bom003_opitn[ll_currow]
	ls_toitem 	= 	ls_plant + ls_div + ls_opitn
	message.stringparm	=	ls_toitem
end if
newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
destroy MenuBOM

if in_chkpos = 1 then
	rb_1.show()
	rb_2.show()
end if
end event

event clicked;if dwo.name	=	'p_calendar_from' then
	openwithparm(w_bom_calendar,string(this.object.oedtm[1]))
	if	f_spacechk(trim(message.stringparm))	<>	-1	then
		this.object.oedtm[1] 		= trim(message.stringparm)
	end if
elseif dwo.name	=	'p_calendar_to' then
	openwithparm(w_bom_calendar,string(this.object.oedte[1]))
	if	f_spacechk(trim(message.stringparm))	<>	-1	then
		this.object.oedte[1] 		= trim(message.stringparm)
	end if
end if

end event

type pb_fitno from picturebutton within w_bom112u
integer x = 3099
integer y = 2060
integer width = 398
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\resume_fo.bmp"
end type

event clicked;string ls_plant, ls_div,ls_pdcd,ls_parm,ls_rtn
integer li_curcnt

li_curcnt = dw_regitem.getcolumn()
if li_curcnt = 2 or li_curcnt = 3 then
	uo_status.st_message.text = ""
	dw_regitem.object.opitn.background.color	=	rgb(255,255,255)
	dw_regitem.object.ofitn.background.color	=	rgb(255,255,255)
	ls_rtn 	= uo_1.uf_return()
	ls_div	= mid(ls_rtn,2,1)
	ls_pdcd	= trim(mid(ls_rtn,3)) + "%"
	ls_plant = mid(ls_rtn,1,1)
	ls_parm 	= ls_plant + ls_div + ls_pdcd
	openwithparm(w_bom110u_res_03,ls_parm)
	ls_rtn = message.stringparm
	if f_spacechk(ls_rtn) = -1 then
		return
	end if
	if li_curcnt = 2 then
		dw_regitem.object.opitn[1] = ls_rtn
		dw_regitem.setcolumn("ofitn")
		dw_regitem.setfocus()
	else
		dw_regitem.object.ofitn[1] = ls_rtn
		dw_regitem.setcolumn("oedtm")
		dw_regitem.setfocus()
	end if
else
	if is_chkdata = 'P' then
		dw_regitem.object.opitn.background.color	=	rgb(255,255,0)
		dw_regitem.object.ofitn.background.color	=	rgb(255,255,0)
	else
		dw_regitem.object.ofitn.background.color	=	rgb(255,255,0)
	end if
	uo_status.st_message.text = "해당 칼럼을 지정하십시요"
end if
end event

type st_sdetail from statictext within w_bom112u
integer x = 1413
integer y = 252
integer width = 585
integer height = 88
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "OPTION 부품목 "
alignment alignment = right!
long bordercolor = 33554432
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bom112u
integer x = 14
integer width = 2528
integer height = 208
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_subitem from datawindow within w_bom112u
integer x = 1422
integer y = 348
integer width = 3040
integer height = 1544
integer taborder = 30
string dataobject = "d_bom001_secitem"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row <= 0 then
	return
end if

If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event doubleclicked;long ll_mcurrow
string ls_sitem,ls_mitem,ls_ochdt,ls_oedte,ls_div,ls_plant
dw_regitem.reset()

uo_status.st_message.text = ""
in_chkpos = 1
is_selected = "r"
this.selectrow(row,true)
ls_plant = dw_subitem.object.oplant[row]
ls_div = dw_subitem.object.odvsn[row]
ls_mitem=dw_subitem.object.opitn[row]
ls_sitem = dw_subitem.object.ofitn[row]
ls_ochdt = dw_subitem.object.ochdt[row]
ls_oedte = dw_subitem.object.oedte[row]
dw_regitem.settransobject(sqlca)
dw_regitem.retrieve(ls_plant,ls_div,ls_sitem,ls_mitem,ls_ochdt)
//완료일이 금일 이면 수정불가
if ls_oedte = g_s_date then
	dw_regitem.object.oedte.protect = true
	dw_regitem.object.oedte.background.color=rgb(192,192,192)
else
	dw_regitem.object.oedte.protect = false
	dw_regitem.object.oedte.background.color=rgb(255,255,255)
end if


dw_regitem.object.opitn.protect=true
dw_regitem.object.opitn.background.color=rgb(192,192,192)
dw_regitem.object.ofitn.protect=true
dw_regitem.object.ofitn.background.color=rgb(192,192,192)
dw_regitem.object.gb_1.visible = true
pb_fitno.hide()
dw_regitem.setcolumn("oedtm")
dw_regitem.setfocus()

//wf_rgbclear()

rb_1.checked = false
rb_2.checked = true
rb_1.show()
rb_2.show()
end event

event rbuttondown;string ls_toitem,ls_opitn,ls_div,ls_plant,ls_rtncd
long ll_currow
ll_currow = dw_mainitem.getselectedrow(0)
MenuBOM newmenu
newmenu =create MenuBOM
newmenu.m_kew.m_insert.enabled = false
newmenu.m_kew.m_delete.enabled = true
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_save.enabled = false
newmenu.m_kew.m_detail.enabled = true

ls_rtncd = uo_1.uf_return()
ls_div = mid(ls_rtncd,2,1)
ls_plant = mid(ls_rtncd,1,1)

if ll_currow < 1 then
	ls_toitem= ls_plant + ls_div
	message.stringparm = ls_toitem
else
	ls_opitn=dw_mainitem.object.bom003_opitn[ll_currow]
	ls_toitem = ls_plant + ls_div + ls_opitn
	message.stringparm=ls_toitem
end if
newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
destroy MenuBOM

if in_chkpos = 1 then
	rb_1.show()
	rb_2.show()
end if
end event

type uo_1 from uo_plandiv_pdcd within w_bom112u
integer x = 46
integer y = 56
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type rb_1 from radiobutton within w_bom112u
integer x = 3008
integer y = 2120
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "주품목"
end type

type rb_2 from radiobutton within w_bom112u
integer x = 3008
integer y = 2204
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "부품목"
end type

