$PBExportHeader$w_bpm403u.srw
$PBExportComments$Option 품목관리용윈도우
forward
global type w_bpm403u from w_origin_sheet02
end type
type dw_mainitem from datawindow within w_bpm403u
end type
type st_mdetail from statictext within w_bpm403u
end type
type dw_regitem from datawindow within w_bpm403u
end type
type rb_1 from radiobutton within w_bpm403u
end type
type rb_2 from radiobutton within w_bpm403u
end type
type pb_fitno from picturebutton within w_bpm403u
end type
type st_sdetail from statictext within w_bpm403u
end type
type gb_1 from groupbox within w_bpm403u
end type
type dw_subitem from datawindow within w_bpm403u
end type
type uo_1 from uo_plandiv_pdcd within w_bpm403u
end type
type uo_year from uo_ccyy_mps within w_bpm403u
end type
type st_1 from statictext within w_bpm403u
end type
type cb_stop from commandbutton within w_bpm403u
end type
type cb_go from commandbutton within w_bpm403u
end type
type uo_2 from u_bpm_select_arev within w_bpm403u
end type
type gb_2 from groupbox within w_bpm403u
end type
end forward

global type w_bpm403u from w_origin_sheet02
integer width = 4809
integer height = 3104
string title = "Option 품목관리"
event ue_postopen ( )
dw_mainitem dw_mainitem
st_mdetail st_mdetail
dw_regitem dw_regitem
rb_1 rb_1
rb_2 rb_2
pb_fitno pb_fitno
st_sdetail st_sdetail
gb_1 gb_1
dw_subitem dw_subitem
uo_1 uo_1
uo_year uo_year
st_1 st_1
cb_stop cb_stop
cb_go cb_go
uo_2 uo_2
gb_2 gb_2
end type
global w_bpm403u w_bpm403u

type variables
datastore ids_u_date
string i_s_selected="r" //수정과 입력을 구분하는 변수
string i_s_chkdata    //새로운 주품번입력과 부품번입력을 구분하는 변수
integer i_n_chkpos
long i_i_LastRow
string i_s_applyyear, i_s_revno, i_s_applydate, i_s_enddate
end variables

forward prototypes
public function integer wf_get_chkitem (string a_plant, string a_div, string a_item)
public function integer wf_item_change (string a_plant, string a_chkmain, string a_chksub, string a_div, string a_oedtm, string a_oedte)
public subroutine wf_rgbclear ()
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_date_update (string a_plant, string a_div, string a_opitn, string a_ofitn, string a_oedtm, string a_oedte, string a_ochdt)
end prototypes

event ue_postopen();ids_u_date = create datastore
ids_u_date.dataobject = "d_bpm504_106u_redate"

ids_u_date.settransobject(sqlca)
dw_mainitem.settransobject( sqlca)
dw_subitem.settransobject( sqlca)
dw_regitem.settransobject(sqlca)
i_n_chkpos = 0
this.pb_fitno.visible = false

string ls_taskstatus, ls_message
ls_message = Right(Message.StringParm,6)
i_s_revno = mid(ls_message,1,2)
i_s_applyyear = mid(ls_message,3,4)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(True,  False,  False,  False,  False,      & 
			  False,     False,    False,  False,    False,  & 
			  False,    False)
if f_bpm_check_ingflag(i_s_applyyear,i_s_revno,'w_bpm403u') = 'C' then
	cb_stop.enabled = False
	cb_go.enabled = False
else
	SELECT TASKSTATUS INTO :ls_taskstatus 
	FROM PBBPM.BPM519
	WHERE COMLTD = :g_s_company AND XYEAR = :i_s_applyyear AND 
			REVNO = :i_s_revno AND WINDOWID = 'w_bpm403u'
	using sqlca;
	
	if ls_taskstatus <> 'C' then
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(True,  True,  True,  True,  False,      & 
			     False,     False,    False,  False,    False,  & 
			     False,    False)
	end if
			
	if f_bpm_check_jobemp(i_s_applyyear,i_s_revno,'w_bpm403u',g_s_empno) <> -1 then
		if ls_taskstatus = 'C' then
			cb_stop.enabled = False
			cb_go.enabled = True
		else
			cb_stop.enabled = True
			cb_go.enabled = False
		end if
	else
		cb_stop.enabled = False
		cb_go.enabled = False
	end if
end if

if f_spacechk(i_s_applyyear) = -1 then
	uo_year.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
else
	uo_year.uf_reset(integer(i_s_applyyear))
end if

f_bpm_retrieve_dddw_arev(uo_2.dw_1, &
										uo_year.uf_return(), &
										i_s_revno, &
										False, &
										uo_2.is_uo_revno, &
										uo_2.is_uo_refyear )
										
uo_2.Triggerevent('ue_select')
end event

public function integer wf_get_chkitem (string a_plant, string a_div, string a_item);// Check main or subitem in DEPDMO.BPM504

string ls_check
  SELECT "PBBPM"."BPM504"."PCITN"  
  		into :ls_check
  FROM "PBBPM"."BPM504"  
  WHERE "PBBPM"."BPM504"."XYEAR" = :i_s_applyyear AND
  			"PBBPM"."BPM504"."REVNO" = :i_s_revno AND
  			"PBBPM"."BPM504"."PLANT" = :a_plant AND
  			"PBBPM"."BPM504"."PCITN" = :a_item AND
  		  "PBBPM"."BPM504"."PDVSN" = :a_div  using sqlca;
if f_spacechk(ls_check) = -1 then
	return 0
else
	return 1
end if
end function

public function integer wf_item_change (string a_plant, string a_chkmain, string a_chksub, string a_div, string a_oedtm, string a_oedte);string ls_chkmain,ls_miditem,ls_ochcd,ls_ofocd
dec{2} lc_orate
long ll_currow,ll_currow1,ll_rowcnt
integer li_rtn,li_cnt
ll_currow = dw_subitem.getrow()
ll_rowcnt = dw_subitem.rowcount()

for li_cnt = 1 to ll_rowcnt
	ls_chkmain = dw_subitem.object.ofitn[li_cnt]
	ls_ochcd = dw_subitem.object.ochcd[li_cnt]
	ls_ofocd = dw_subitem.object.ofocd[li_cnt]
	lc_orate = dw_subitem.object.orate[li_cnt]
	if li_cnt = 1 then
		if trim(ls_chkmain) <> trim(a_chksub) then
			INSERT INTO "PBBPM"."BPM505"  
         	( "OCMCD","XYEAR","REVNO","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  "OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
  				VALUES (:g_s_company,:i_s_applyyear,:i_s_revno,:a_plant,:a_div,:a_chksub,:ls_chkmain,:g_s_date,:a_oedtm,:a_oedte,:lc_orate
				  			,:ls_ochcd,:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date)
				using sqlca;
		end if
		ls_miditem = ls_chkmain
	else
		if trim(ls_chkmain) <> trim(a_chksub) and trim(ls_chkmain) <> trim(ls_miditem) then
			INSERT INTO "PBBPM"."BPM505"  
         	( "OCMCD","XYEAR","REVNO","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  "OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
  				VALUES (:g_s_company,:i_s_applyyear,:i_s_revno,:a_plant,:a_div,:a_chksub,:ls_chkmain,:g_s_date,:a_oedtm,:a_oedte,:lc_orate
				  			,:ls_ochcd,:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date)
				using sqlca;
		end if
		ls_miditem = ls_chkmain
	end if	
next
//수정된 데이타 교체 Script 끝
return 1
end function

public subroutine wf_rgbclear ();dw_regitem.object.opitn.background.color		 = rgb(255,255,255)				// White
dw_regitem.object.ofitn.background.color		 = rgb(255,255,255)
dw_regitem.object.oedtm.background.color		 = rgb(255,255,255)
dw_regitem.object.oedte.background.color		 = rgb(255,255,255)

end subroutine

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	l_i_Idx, l_i_last_row

l_i_last_row = i_i_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If l_i_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if l_i_last_row > al_aclickedrow then
	For l_i_Idx = l_i_last_row to al_aclickedrow STEP -1
		dw.selectrow(l_i_Idx,TRUE)	
	end for	
else
	For l_i_Idx = l_i_last_row to al_aclickedrow 
		dw.selectrow(l_i_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_date_update (string a_plant, string a_div, string a_opitn, string a_ofitn, string a_oedtm, string a_oedte, string a_ochdt);string ls_ochdt, ls_oedte, ls_oedtm,ls_hold_oedtm, ls_hold_oedte
integer k,li_cnt,li_rtn
long ll_rowcnt,ll_currow

ids_u_date.reset()
ll_rowcnt = ids_u_date.retrieve(i_s_applyyear,a_plant,a_div,a_opitn,a_ofitn,g_s_date)
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

on w_bpm403u.create
int iCurrent
call super::create
this.dw_mainitem=create dw_mainitem
this.st_mdetail=create st_mdetail
this.dw_regitem=create dw_regitem
this.rb_1=create rb_1
this.rb_2=create rb_2
this.pb_fitno=create pb_fitno
this.st_sdetail=create st_sdetail
this.gb_1=create gb_1
this.dw_subitem=create dw_subitem
this.uo_1=create uo_1
this.uo_year=create uo_year
this.st_1=create st_1
this.cb_stop=create cb_stop
this.cb_go=create cb_go
this.uo_2=create uo_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mainitem
this.Control[iCurrent+2]=this.st_mdetail
this.Control[iCurrent+3]=this.dw_regitem
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.pb_fitno
this.Control[iCurrent+7]=this.st_sdetail
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dw_subitem
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.uo_year
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.cb_stop
this.Control[iCurrent+14]=this.cb_go
this.Control[iCurrent+15]=this.uo_2
this.Control[iCurrent+16]=this.gb_2
end on

on w_bpm403u.destroy
call super::destroy
destroy(this.dw_mainitem)
destroy(this.st_mdetail)
destroy(this.dw_regitem)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.pb_fitno)
destroy(this.st_sdetail)
destroy(this.gb_1)
destroy(this.dw_subitem)
destroy(this.uo_1)
destroy(this.uo_year)
destroy(this.st_1)
destroy(this.cb_stop)
destroy(this.cb_go)
destroy(this.uo_2)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;setpointer(hourglass!)

int net
int rowcount
string l_s_div,l_s_plant, l_s_pdcd, l_s_rtncd

f_pism_working_msg(This.title,"Option 정보를 조회중입니다. 잠시만 기다려 주십시오.") 

i_n_chkpos = 0
rb_1.hide()
rb_2.hide()
pb_fitno.hide()
dw_mainitem.reset()
dw_subitem.reset()
dw_regitem.reset()
wf_rgbclear()

l_s_rtncd = uo_1.uf_return()
l_s_div = mid(l_s_rtncd,2,1)
l_s_pdcd=trim(mid(l_s_rtncd,3)) + "%"
l_s_plant = mid(l_s_rtncd,1,1)

dw_mainitem.retrieve(i_s_applyyear,i_s_revno,l_s_plant,l_s_div,l_s_pdcd,g_s_date) 

if dw_mainitem.rowcount() = 0 then
	uo_status.st_message.text = f_message("I020")
else
	uo_status.st_message.text = f_message("I010")
end if
If IsValid(w_pism_working) Then Close(w_pism_working)
//조회,입력,저장,삭제 ,상세조회,화면인쇄,특수문자
//i_b_insert = true
//i_b_save = true
//i_b_delete = true
//
//wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
//					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
//					  i_b_dprint,    i_b_dchar)
return 0

end event

event ue_insert;int net
long ll_currow
string ls_cocode,ls_plant,ls_mainitem, ls_rtncd

i_n_chkpos = 0
dw_regitem.object.opitn.protect=false
dw_regitem.object.ofitn.protect=false
dw_regitem.object.gb_1.visible = false
pb_fitno.show()

wf_rgbclear()

rb_1.hide()
rb_2.hide()
dw_regitem.reset()
dw_regitem.insertrow(0)

ls_rtncd = uo_1.uf_return()
ls_cocode= mid(ls_rtncd,2,1)
ls_plant = mid(ls_rtncd,1,1)

ll_currow=dw_mainitem.getselectedrow(0)
i_s_chkdata = 'P'
dw_regitem.object.oemno[1] = g_s_empno
dw_regitem.object.oindt[1] = g_s_date
dw_regitem.object.oplant[1] = ls_plant
dw_regitem.object.odvsn[1] = ls_cocode
dw_regitem.object.xyear[1] = i_s_applyyear
dw_regitem.object.revno[1] = i_s_revno
dw_regitem.object.oedtm[1] = i_s_applydate

//부품번 등록초기화
if ll_currow > 0 then
	ls_mainitem = trim(dw_mainitem.object.bpm505_opitn[ll_currow])
	
	net = messagebox("확인",ls_mainitem + "의 부품목 추가는 'Y', 신규 주품목의 추가는 'N' 입니다!",question!,yesno!,1)
	if net = 1 then
		dw_regitem.object.opitn.protect=true
		i_s_chkdata = 'S'
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

i_s_selected = "i"
i_s_chkdata=ls_mainitem

//조회,입력,저장,삭제 ,상세조회,화면인쇄,특수문자
//i_b_retrieve=true
//i_b_insert = true
//i_b_save = true
//i_b_delete = false
//
//wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
//					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
//					  i_b_dprint,    i_b_dchar)
return 0
end event

event ue_save;string ls_chkmain,ls_chksub,ls_chkdte,ls_chkdtm,ls_column,ls_div,ls_pdcd,ls_ochdt,ls_selitem1 &
				,ls_ofocd,ls_oemno,ls_oindt,ls_selitem,ls_rtnchk,ls_oedte_hold,ls_oedtm_hold,ls_ochdt_hold
string ls_plant, ls_rtncd
integer li_mcnt=0,li_scnt=0,li_ucnt,li_rtn
dec{2} lc_orate, lc_sumorate
long ll_currow=0,ll_currow1=0,ll_rowcnt=0

dw_regitem.accepttext()
ll_currow=dw_subitem.getrow()
ll_rowcnt = dw_subitem.rowcount()

if f_dateedit(i_s_applydate) = space(8) then
	messagebox("확인","bom기준일자가 잘못되었습니다.")
	return 
end if
setpointer(hourglass!)
//f_pism_working_msg(This.title,"Option 정보를 저장중입니다. 잠시만 기다려 주십시오.") 
f_bpm_job_start(i_s_applyyear,i_s_revno,'w_bpm403u',g_s_empno,'C','사업계획BOM호환정보 저장')

ls_rtncd = uo_1.uf_return()  
ls_div= mid(ls_rtncd,2,1)										//공장
ls_pdcd=trim(mid(ls_rtncd,3)) + "%"							//제품군
ls_plant = mid(ls_rtncd,1,1)
ls_chkmain=upper(trim(dw_regitem.object.opitn[1]))		//호환주품번
ls_chksub=upper(trim(dw_regitem.object.ofitn[1]))		//호환부품번
ls_ochdt=dw_regitem.object.ochdt[1]							//수정일자
ls_chkdtm=i_s_applydate						//적용일자
ls_chkdte=dw_regitem.object.oedte[1]						//완료일자
lc_orate=dw_regitem.object.orate[1]							//호환율
ls_ofocd=dw_regitem.object.ofocd[1]							//Feature/Option Code
ls_oemno=dw_regitem.object.oemno[1]							//입력자사번
ls_oindt=dw_regitem.object.oindt[1]							//입력일자
dw_regitem.object.opitn[1]=ls_chkmain
dw_regitem.object.ofitn[1]=ls_chksub

wf_rgbclear()

if f_spacechk(ls_chkdtm) = -1 then
	dw_regitem.object.oedtm[1] = "       "
	ls_chkdtm = "       "
end if
if f_spacechk(ls_chkdte) = -1 then
	dw_regitem.object.oedte[1] = "       "
	ls_chkdte = "       "
end if
if isnull(lc_orate) = true then
	dw_regitem.object.orate[1] = 0
	lc_orate = 0
else
	//호환율 범위 체크 2011.10.18
	select sum(orate) into :lc_sumorate
   from pbbpm.bpm505
   where ocmcd = '01' and oplant = :ls_plant
	     and xyear = :i_s_applyyear and revno = :i_s_revno
        and odvsn = :ls_div and opitn = :ls_chkmain
        and ofitn <> :ls_chksub
        and (( oedte = ' ' and  oedtm <= :i_s_applydate ) or
          ( oedte <> ' ' and oedte >= :i_s_applydate and oedtm <= :i_s_applydate ))
	using sqlca;
	if isnull(lc_sumorate) then lc_sumorate = 0
	if lc_orate > 1.00 or (lc_orate + lc_sumorate) > 1.00 then
		ls_column="orate"
	end if
	lc_orate = dw_subitem.object.com_orate[1]
end if
// 두개 이상 공장의 동일이체품이 인경우에 호환율은 동일해야 한다.


if f_spacechk(ls_ofocd) = -1 then
	dw_regitem.object.ofocd[1] = " "
	ls_ofocd = " "
end if
// Common Check Script-Insert and Modify
if f_spacechk(ls_chkmain) = -1 then
	dw_regitem.object.opitn.background.color=rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column="opitn"
	end if
end if

if f_spacechk(ls_chksub) = -1 then
	dw_regitem.object.ofitn.background.color=rgb(255,255,0)
	if f_spacechk(ls_column) = -1 then
		ls_column="ofitn"
	end if
end if

if f_spacechk(ls_chkdte) = -1 then
	dw_regitem.object.oedte[1] = ''
else
	if f_dateedit(ls_chkdte) = SPACE(8) then
		dw_regitem.object.oedte.background.color=rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column="oedte"
		end if
	end if
end if

if f_spacechk(ls_chkdtm) = -1 then
	ls_oedtm_hold = i_s_enddate
else
	ls_oedtm_hold = f_relativedate(ls_chkdtm,-1)
	if f_dateedit(ls_chkdtm) = SPACE(8) then
		dw_regitem.object.oedtm.background.color=rgb(255,255,0)
		if f_spacechk(ls_column) = -1 then
			ls_column="oedtm"
		end if
	end if
end if

// 수정시 Check script
if i_s_selected = "r" then
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
	
//	if dw_subitem.object.oedte[ll_currow] = g_s_date and &
//		      dw_subitem.object.ochdt[ll_currow] = g_s_date then
//		dw_regitem.object.oedte.background.color=rgb(255,255,0)
//		uo_status.st_message.text=f_message("E290")
//		return 0
//	end if	
	
	//Mbom에서 상위품번 Check Script
	ls_rtnchk = f_bom_check_bpm(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chkmain,ls_chksub,ls_chkdtm,ls_chkdte) 
	if f_spacechk(ls_rtnchk) = -1 then
		//nothing
	elseif mid(ls_rtnchk,1,1) = "i" then
		uo_status.st_message.text=f_message("E330")
		openwithparm(w_bPm403u_detail,(i_s_applyyear + i_s_revno + ls_plant + ls_div + ls_chkmain))
		return 0
	elseif mid(ls_rtnchk,1,1) = "d" then
		uo_status.st_message.text = f_message("E290")
		openwithparm(w_bPm403u_detail,(i_s_applyyear + i_s_revno + ls_plant + ls_div + ls_chkmain))
		return 0
	end if

end if

//날짜 Check Script
if f_spacechk(ls_chkdtm) = -1 then
	if f_spacechk(ls_chkdte) = -1 then
		dw_regitem.object.oedtm[1] = ''
	else
		if ls_chkdte >= i_s_enddate then
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
//		if ls_chkdtm <= g_s_date then
//			dw_regitem.object.oedtm.background.color=rgb(255,255,0)
//			if f_spacechk(ls_column) = -1 then
//				ls_column="oedtm"
//			end if
//		else
//			//nothing
//		end if
	else
//		if ls_chkdtm > g_s_date and &
		IF		ls_chkdte >= i_s_enddate and &
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
if i_s_selected = "i" then
	
	dw_regitem.setitem( 1 ,"ochdt",g_s_date)
	ls_ochdt = g_s_date
	
	//Master에서 품번조회
	ls_selitem=f_bpm_get_itemnbr(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chkmain)
	if isnull(ls_selitem) or ls_selitem <> ls_chkmain then
		dw_regitem.object.opitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("E320")
		return 0
	else
		//nothing
	end if
	ls_selitem1=f_bpm_get_itemnbr(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chksub)
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
	SELECT count(*) INTO :li_mcnt
		FROM "PBBPM"."BPM505"
		WHERE "PBBPM"."BPM505"."OCMCD"= :g_s_company AND
				"PBBPM"."BPM505"."XYEAR"= :i_s_applyyear AND
				"PBBPM"."BPM505"."REVNO"= :i_s_revno AND
				"PBBPM"."BPM505"."OPLANT"= :ls_plant AND
				"PBBPM"."BPM505"."ODVSN"= :ls_div AND
				"PBBPM"."BPM505"."OPITN"= :ls_chkmain AND
		 		"PBBPM"."BPM505"."OFITN"= :ls_chksub AND 
				(( "PBBPM"."BPM505"."OEDTE" = ' '  and "PBBPM"."BPM505"."OEDTM" <= :i_s_applydate ) or
  				( "PBBPM"."BPM505"."OEDTE" <> ' ' and "PBBPM"."BPM505"."OEDTM" <= :i_s_applydate
                and "PBBPM"."BPM505"."OEDTE" >= :i_s_applydate )) using sqlca; 
				 
	if li_mcnt > 0 then
		dw_regitem.object.opitn.background.color=rgb(255,255,0)
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
		uo_status.st_message.text=f_message("A060")
		return 0
	end if
	
	SELECT count(*) INTO :li_mcnt
		FROM "PBBPM"."BPM505"
		WHERE "PBBPM"."BPM505"."OCMCD"= :g_s_company AND
				"PBBPM"."BPM505"."XYEAR"= :i_s_applyyear AND
				"PBBPM"."BPM505"."REVNO"= :i_s_revno AND
				"PBBPM"."BPM505"."OPLANT"= :ls_plant AND
				"PBBPM"."BPM505"."ODVSN"= :ls_div AND
				"PBBPM"."BPM505"."OPITN"= :ls_chksub AND
		 		"PBBPM"."BPM505"."OFITN"= :ls_chkmain AND
				(( "PBBPM"."BPM505"."OEDTE" = ' '  and "PBBPM"."BPM505"."OEDTM" <= :i_s_applydate ) or
  				( "PBBPM"."BPM505"."OEDTE" <> ' ' and "PBBPM"."BPM505"."OEDTM" <= :i_s_applydate
                and "PBBPM"."BPM505"."OEDTE" >= :i_s_applydate )) using sqlca; 
				 
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
	ls_rtnchk = f_bom_check_bpm(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chkmain,ls_chksub,ls_chkdtm,ls_chkdte) 
	if f_spacechk(ls_rtnchk) = -1 then
		//nothing
	elseif mid(ls_rtnchk,1,1) = "i" then
		uo_status.st_message.text=f_message("E330")
		openwithparm(w_bPm403u_detail,(i_s_applyyear + i_s_revno + ls_plant + ls_div + ls_chkmain))
		return 0
	elseif mid(ls_rtnchk,1,1) = "d" then
		uo_status.st_message.text = f_message("E290")
		openwithparm(w_bPm403u_detail,(i_s_applyyear + i_s_revno + ls_plant + ls_div + ls_chkmain))
		return 0
	end if

end if

// Update Logic-입력
if i_s_selected="i" then
	dw_regitem.object.ochcd[1] = "A"
	dw_regitem.object.ocmcd[1] = g_s_company
	dw_regitem.object.omacaddr[1] = g_s_macaddr
	dw_regitem.object.oipaddr[1] = g_s_ipaddr
	if dw_regitem.update() = 1 then
		commit using sqlca;
		uo_status.st_message.text = f_message("A010")
		if i_s_chkdata = ls_chkmain then				// 부품번 입력후 화면 처리
			dw_subitem.reset()
			dw_regitem.reset()
			dw_subitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chkmain,i_s_applydate)
		else													// 주품번 입력후 화면 처리		
			dw_mainitem.reset()
			dw_subitem.reset()
			dw_regitem.reset()
			rb_1.hide()
			rb_2.hide()
			pb_fitno.hide()
			dw_mainitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_pdcd,i_s_applydate)
		end if
	else
		i_n_erreturn = -1
		rollback using sqlca;
		uo_status.st_message.text=f_message("A020")
		return 0
	end if
	
else
	SELECT count(*) INTO :li_scnt										
		FROM "PBBPM"."BPM505"
		WHERE "PBBPM"."BPM505"."XYEAR"= :i_s_applyyear AND
				"PBBPM"."BPM505"."REVNO"= :i_s_revno AND
				"PBBPM"."BPM505"."OPLANT"= :ls_plant AND
				"PBBPM"."BPM505"."ODVSN"= :ls_div AND
				"PBBPM"."BPM505"."OPITN"= :ls_chkmain AND
				"PBBPM"."BPM505"."OFITN"= :ls_chksub AND
				"PBBPM"."BPM505"."OCHDT"= :g_s_date  using sqlca;
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
				dw_subitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chkmain,i_s_applydate)
				rb_1.hide()
				rb_2.hide()
				pb_fitno.hide()
			else
				i_n_erreturn = -1
				rollback using sqlca;
				uo_status.st_message.text=f_message("A020")
				return 0
			end if
		else
			//주품번과 부품번이 교체된 경우
			//주어진 시작일과 완료일로 UPDATE
			UPDATE "PBBPM"."BPM505"
				SET "OEDTE" = :i_s_enddate
				WHERE "PBBPM"."BPM505"."XYEAR"= :i_s_applyyear AND
						"PBBPM"."BPM505"."REVNO"= :i_s_revno AND
						"PBBPM"."BPM505"."OPLANT" = :ls_plant AND
						"PBBPM"."BPM505"."ODVSN" = :ls_div AND
						"PBBPM"."BPM505"."OPITN"= :ls_chkmain  using sqlca;
			
			INSERT INTO "PBBPM"."BPM505"  
         	( "OCMCD","XYEAR","REVNO","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  "OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
  				VALUES (:g_s_company,:i_s_applyyear,:i_s_revno,:ls_plant,:ls_div,:ls_chksub,:ls_chkmain,:g_s_date,:ls_chkdtm,:ls_chkdte,:lc_orate
				  			,'A',:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date)
				using sqlca;

			if sqlca.sqlcode < 0 then
				i_n_erreturn = -1
				uo_status.st_message.text=f_message("U020")
				return 0
			else
				uo_status.st_message.text=f_message("U010")
			end if
			//기타 부품번들 UPDATE
			li_rtn = wf_item_change(ls_plant,ls_chkmain,ls_chksub,ls_div,ls_chkdtm,ls_chkdte)
			if li_rtn = 0 then
				return 0
			end if
						
			dw_mainitem.reset()
			dw_subitem.reset()
			rb_1.hide()
			rb_2.hide()
			pb_fitno.hide()
			dw_regitem.reset()
			dw_mainitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_pdcd,i_s_applydate)	
		end if		
	else
		if rb_1.checked = false then
			//Old Record of Modification
			UPDATE "PBBPM"."BPM505"
				SET "OCHCD" = 'R',
					"OEDTE" = :i_s_enddate
				WHERE "PBBPM"."BPM505"."XYEAR"= :i_s_applyyear AND
						"PBBPM"."BPM505"."REVNO"= :i_s_revno AND
						"PBBPM"."BPM505"."OPLANT" = :ls_plant AND
						"PBBPM"."BPM505"."ODVSN" = :ls_div AND
						"PBBPM"."BPM505"."OPITN"= :ls_chkmain AND 
						"PBBPM"."BPM505"."OFITN" = :ls_chksub AND
						"PBBPM"."BPM505"."OCHDT"= :ls_ochdt using sqlca;
			
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
			INSERT INTO "PBBPM"."BPM505"  
         	( "OCMCD","XYEAR","REVNO","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  "OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
  				VALUES (:g_s_company,:i_s_applyyear,:i_s_revno,:ls_plant,:ls_div,:ls_chkmain,:ls_chksub,:g_s_date,:ls_chkdtm,:ls_chkdte,:lc_orate
				  			,'A',:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date)
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
				dw_subitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_chkmain,i_s_applydate)
				dw_regitem.reset()	
			end if
		else
			//부품번을 주품번으로 Update
			//주어진 시작일과 완료일로 UPDATE
			UPDATE "PBBPM"."BPM505"
				SET "OEDTE" = :i_s_enddate
				WHERE "PBBPM"."BPM505"."XYEAR"= :i_s_applyyear AND
						"PBBPM"."BPM505"."REVNO"= :i_s_revno AND
						"PBBPM"."BPM505"."OPLANT" = :ls_plant AND
						"PBBPM"."BPM505"."ODVSN" = :ls_div AND
						"PBBPM"."BPM505"."OPITN"= :ls_chkmain  using sqlca;
			
			INSERT INTO "PBBPM"."BPM505"  
         	( "OCMCD","XYEAR","REVNO","OPLANT","ODVSN","OPITN","OFITN","OCHDT","OEDTM","OEDTE","ORATE",   
           	  "OCHCD","OFOCD","OMACADDR","OIPADDR","OEMNO","OINDT" )  
  				VALUES (:g_s_company,:i_s_applyyear,:i_s_revno,:ls_plant,:ls_div,:ls_chksub,:ls_chkmain,:g_s_date,:ls_chkdtm,:ls_chkdte,:lc_orate
				  			,'A',:ls_ofocd,:g_s_macaddr,:g_s_ipaddr,:g_s_empno,:g_s_date)
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
			
			dw_mainitem.reset()
			dw_subitem.reset()
			rb_1.hide()
			rb_2.hide()
			pb_fitno.hide()
			dw_regitem.reset()
			dw_mainitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_pdcd,i_s_applydate)
		end if
	end if
end if
return 0

end event

event ue_delete;integer li_rc,li_cnt,li_tot
long ll_row,ll_row1,ll_curmain,ll_rowcnt
string ls_rtncd
string ls_subitem,ls_mainitem,ls_plant,ls_div,ls_pdcd,ls_ochdt, &
			ls_oedtm,ls_ofocd,ls_oindt,ls_pops=" ",ls_popf=" "
dec{2} lc_orate

if f_dateedit(i_s_applydate) = space(8) then
	messagebox("확인","bom기준일자가 잘못되었습니다.")
	return 
end if

// 주품번과 부품번의 삭제 선택Code
ll_row = dw_subitem.getselectedrow(0)
ll_curmain = dw_mainitem.getrow()
ll_rowcnt = dw_subitem.rowcount()

//삭제시 Check Script
if ll_curmain < 1 then
	uo_status.st_message.text = f_message("D100")
	return 0
end if
if i_s_selected = "i" then
	uo_status.st_message.text = f_message("D100")
	return 0
end if

ls_rtncd = uo_1.uf_return()
ls_div = mid(ls_rtncd,2,1)
ls_pdcd = mid(ls_rtncd,3)
ls_plant = mid(ls_rtncd,1,1)

ls_mainitem = trim(dw_mainitem.object.bpm505_opitn[ll_curmain])

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
	ls_subitem=trim(dw_subitem.object.ofitn[ll_row])
	ls_ochdt=dw_subitem.object.ochdt[ll_row]
	ls_oedtm=dw_subitem.object.oedtm[ll_row]
	lc_orate=dw_subitem.object.orate[ll_row]
	ls_ofocd=dw_subitem.object.ofocd[ll_row]
	ls_oindt=dw_subitem.object.oindt[ll_row]
	//delete at current DB
   UPDATE "PBBPM"."BPM505"
	SET "OEDTE" = :i_s_enddate
	WHERE "PBBPM"."BPM505"."XYEAR" = :i_s_applyyear AND
			"PBBPM"."BPM505"."REVNO" = :i_s_revno AND
			"PBBPM"."BPM505"."OPLANT" = :ls_plant AND
			"PBBPM"."BPM505"."ODVSN" = :ls_div AND
			"PBBPM"."BPM505"."OPITN"= :ls_mainitem AND 
			"PBBPM"."BPM505"."OFITN" = :ls_subitem
//			AND
//			"PBBPM"."BPM505"."OCHDT"= :ls_ochdt 
			using sqlca;
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
uo_status.st_message.text=f_message("D010")
dw_subitem.reset()
rb_1.hide()
rb_2.hide()
dw_regitem.reset()
ll_row1 = dw_subitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_mainitem,i_s_applydate)
if ll_row1 < 1 then
	dw_mainitem.reset()
	dw_mainitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_pdcd,i_s_applydate)
end if
return 0
end event

event activate;call super::activate;wf_icon_onoff(true,true,true,true,true,false,false,false,false,false,false,false)

rb_1.hide() 
rb_2.hide()
end event

event close;call super::close;destroy ids_u_date
end event

event open;call super::open;// Post Open Event
THIS.PostEvent('ue_postopen')
end event

type uo_status from w_origin_sheet02`uo_status within w_bpm403u
end type

type dw_mainitem from datawindow within w_bpm403u
integer x = 23
integer y = 532
integer width = 1518
integer height = 1936
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_bpm504_priitem"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;//string ls_toitem,ls_opitn,ls_div,ls_plant, ls_rtncd
//long ll_currow
//ll_currow = dw_mainitem.getselectedrow(0)
//menubpm newmenu
//newmenu =create menubpm
//newmenu.m_kew.m_insert.enabled = true
//newmenu.m_kew.m_delete.enabled = false
//newmenu.m_kew.m_retrieve.enabled = false
//newmenu.m_kew.m_save.enabled = false
//newmenu.m_kew.m_detail.enabled = true
//
//ls_rtncd = uo_1.uf_return()
//ls_div = mid(ls_rtncd,2,1)
//ls_plant = mid(ls_rtncd,1,1)
//
//if ll_currow < 1 then
//	ls_toitem= ls_plant + ls_div
//	message.stringparm = ls_toitem
//else
//	ls_opitn=dw_mainitem.object.bpm505_opitn[ll_currow]
//	ls_toitem = ls_plant + ls_div + ls_opitn
//	message.stringparm=ls_toitem
//end if
//newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
//destroy menubpm
//
//if i_n_chkpos = 1 then
//	rb_1.show()
//	rb_2.show()
//end if
//
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

ls_data = dw_mainitem.object.bpm505_opitn[row]
dw_subitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_data,g_s_date)


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

type st_mdetail from statictext within w_bpm403u
integer x = 27
integer y = 432
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

type dw_regitem from datawindow within w_bpm403u
event ue_keydown pbm_keydown
integer x = 1563
integer y = 1920
integer width = 3045
integer height = 548
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_bpm504_regitem"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_save")
end if
end event

event rbuttondown;//string ls_toitem,ls_opitn,ls_div,ls_plant,ls_rtncd
//long ll_currow
//ll_currow = dw_mainitem.getselectedrow(0)
//menubpm newmenu
//newmenu =create menubpm
//newmenu.m_kew.m_insert.enabled = false
//newmenu.m_kew.m_delete.enabled = false
//newmenu.m_kew.m_retrieve.enabled = false
//newmenu.m_kew.m_save.enabled = true
//newmenu.m_kew.m_detail.enabled = true
//
//ls_rtncd = uo_1.uf_return()
//ls_div = mid(ls_rtncd,2,1)
//ls_plant = mid(ls_rtncd,1,1)
//
//if ll_currow < 1 then
//	ls_toitem= ls_plant + ls_div
//	message.stringparm = ls_toitem
//else
//	ls_opitn=dw_mainitem.object.bpm505_opitn[ll_currow]
//	ls_toitem = ls_plant + ls_div + ls_opitn
//	message.stringparm=ls_toitem
//end if
//newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
//destroy menubpm
//
//if i_n_chkpos = 1 then
//	rb_1.show()
//	rb_2.show()
//end if
end event

type rb_1 from radiobutton within w_bpm403u
integer x = 3840
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

type rb_2 from radiobutton within w_bpm403u
integer x = 3840
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

type pb_fitno from picturebutton within w_bpm403u
integer x = 3931
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

event clicked;string l_s_plant, l_s_div,l_s_pdcd,l_s_parm,l_s_rtn
integer li_curcnt

li_curcnt = dw_regitem.getcolumn()
if li_curcnt = 2 or li_curcnt = 3 then
	uo_status.st_message.text = ""
	dw_regitem.object.opitn.background.color=rgb(255,255,255)
	dw_regitem.object.ofitn.background.color=rgb(255,255,255)

	l_s_rtn = uo_1.uf_return()
	l_s_div= mid(l_s_rtn,2,1)
	l_s_pdcd= trim(mid(l_s_rtn,3)) + "%"
	l_s_plant = mid(l_s_rtn,1,1)
	
	l_s_parm = i_s_applyyear + i_s_revno + l_s_plant + l_s_div + l_s_pdcd
	openwithparm(w_bpm402u_res_03,l_s_parm)
	
	l_s_rtn = message.stringparm
	
	if f_spacechk(l_s_rtn) = -1 then
		return
	end if
	if li_curcnt = 2 then
		dw_regitem.object.opitn[1] = l_s_rtn
		dw_regitem.setcolumn("ofitn")
		dw_regitem.setfocus()
	else
		dw_regitem.object.ofitn[1] = l_s_rtn
		dw_regitem.setcolumn("oedtm")
		dw_regitem.setfocus()
	end if
else
	if i_s_chkdata = 'P' then
		dw_regitem.object.opitn.background.color=rgb(255,255,0)
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
	else
		dw_regitem.object.ofitn.background.color=rgb(255,255,0)
	end if
	uo_status.st_message.text = "해당 칼럼을 지정하십시요"
end if
end event

type st_sdetail from statictext within w_bpm403u
integer x = 1413
integer y = 432
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

type gb_1 from groupbox within w_bpm403u
integer x = 14
integer width = 3392
integer height = 388
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

type dw_subitem from datawindow within w_bpm403u
integer x = 1563
integer y = 528
integer width = 3040
integer height = 1364
integer taborder = 30
string dataobject = "d_bpm504_secitem"
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
	i_i_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	i_i_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event doubleclicked;long ll_mcurrow
string ls_sitem,ls_mitem,ls_ochdt,ls_oedte,ls_div,ls_plant
dw_regitem.reset()

uo_status.st_message.text = ""
i_n_chkpos = 1
i_s_selected = "r"
this.selectrow(row,true)
ls_plant = dw_subitem.object.oplant[row]
ls_div = dw_subitem.object.odvsn[row]
ls_mitem=dw_subitem.object.opitn[row]
ls_sitem = dw_subitem.object.ofitn[row]
ls_ochdt = dw_subitem.object.ochdt[row]
ls_oedte = dw_subitem.object.oedte[row]
dw_regitem.settransobject(sqlca)
dw_regitem.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_sitem,ls_mitem,ls_ochdt)
//완료일이 금일 이면 수정불가
//if ls_oedte = g_s_date then
//	dw_regitem.object.oedte.protect = true
//	dw_regitem.object.oedte.background.color=rgb(192,192,192)
//else
//	dw_regitem.object.oedte.protect = false
//	dw_regitem.object.oedte.background.color=rgb(255,255,255)
//end if


dw_regitem.object.opitn.protect=true
dw_regitem.object.opitn.background.color=rgb(192,192,192)
dw_regitem.object.ofitn.protect=true
dw_regitem.object.ofitn.background.color=rgb(192,192,192)
dw_regitem.object.gb_1.visible = true
pb_fitno.hide()
dw_regitem.setcolumn("orate")
dw_regitem.setfocus()

//wf_rgbclear()

rb_1.checked = false
rb_2.checked = true
rb_1.show()
rb_2.show()
end event

event rbuttondown;//string ls_toitem,ls_opitn,ls_div,ls_plant,ls_rtncd
//long ll_currow
//ll_currow = dw_mainitem.getselectedrow(0)
//menubpm newmenu
//newmenu =create menubpm
//newmenu.m_kew.m_insert.enabled = false
//newmenu.m_kew.m_delete.enabled = true
//newmenu.m_kew.m_retrieve.enabled = false
//newmenu.m_kew.m_save.enabled = false
//newmenu.m_kew.m_detail.enabled = true
//
//ls_rtncd = uo_1.uf_return()
//ls_div = mid(ls_rtncd,2,1)
//ls_plant = mid(ls_rtncd,1,1)
//
//if ll_currow < 1 then
//	ls_toitem= ls_plant + ls_div
//	message.stringparm = ls_toitem
//else
//	ls_opitn=dw_mainitem.object.bpm505_opitn[ll_currow]
//	ls_toitem = ls_plant + ls_div + ls_opitn
//	message.stringparm=ls_toitem
//end if
//newmenu.m_kew.popmenu(parent.pointerx(),parent.pointery() + 200)
//destroy menubpm
//
//if i_n_chkpos = 1 then
//	rb_1.show()
//	rb_2.show()
//end if
end event

type uo_1 from uo_plandiv_pdcd within w_bpm403u
integer x = 69
integer y = 220
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type uo_year from uo_ccyy_mps within w_bpm403u
event destroy ( )
integer x = 379
integer y = 76
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
end type

on uo_year.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;w_bpm403u.triggerevent("ue_retrieve")
end event

type st_1 from statictext within w_bpm403u
integer x = 73
integer y = 84
integer width = 297
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
boolean focusrectangle = false
end type

type cb_stop from commandbutton within w_bpm403u
integer x = 3506
integer y = 80
integer width = 293
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정"
end type

event clicked;f_bpm_job_stop(i_s_applyyear,i_s_revno,'w_bpm403u',g_s_empno,'C','BOM호환정보 확정작업')

parent.PostEvent('ue_postopen')
end event

type cb_go from commandbutton within w_bpm403u
integer x = 3877
integer y = 76
integer width = 320
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확정취소"
end type

event clicked;f_bpm_job_go(i_s_applyyear,i_s_revno,'w_bpm403u',g_s_empno,'C','BOM호환정보 확정취소작업')

parent.PostEvent('ue_postopen')
end event

type uo_2 from u_bpm_select_arev within w_bpm403u
event destroy ( )
integer x = 841
integer y = 72
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
end type

on uo_2.destroy
call u_bpm_select_arev::destroy
end on

event ue_select;call super::ue_select;//BOM생성 적용일자 가져오기
SELECT Jobstart INTO :i_s_applydate
FROM PBBPM.BPM519
WHERE COMLTD = :g_s_company AND XYEAR = :i_s_applyyear AND 
		REVNO = :i_s_revno AND Windowid = 'w_bpm407c'
using sqlca;

if f_dateedit(i_s_applydate) = space(8) then
	messagebox("확인","bom기준일자가 잘못되었습니다.")
	return 
end if

i_s_enddate = f_relativedate(i_s_applydate,-1)
end event

type gb_2 from groupbox within w_bpm403u
integer x = 3456
integer y = 24
integer width = 782
integer height = 188
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

