$PBExportHeader$w_bpm423i.srw
$PBExportComments$사업계획 품목별재료비
forward
global type w_bpm423i from w_origin_sheet04
end type
type pb_excel from picturebutton within w_bpm423i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm423i
end type
type tab_1 from tab within w_bpm423i
end type
type tabpage_1 from userobject within tab_1
end type
type uo_to from uo_ccyymm_mps within tabpage_1
end type
type uo_from from uo_ccyymm_mps within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type st_sort1 from statictext within tabpage_1
end type
type dw_3 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
uo_to uo_to
uo_from uo_from
cb_5 cb_5
st_7 st_7
st_6 st_6
st_5 st_5
cb_1 cb_1
st_sort1 st_sort1
dw_3 dw_3
end type
type tabpage_2 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_2
end type
type st_sort2 from statictext within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_2 cb_2
st_sort2 st_sort2
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_3
end type
type st_sort3 from statictext within tabpage_3
end type
type dw_4 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_3 cb_3
st_sort3 st_sort3
dw_4 dw_4
end type
type tabpage_4 from userobject within tab_1
end type
type dw_5 from datawindow within tabpage_4
end type
type cb_4 from commandbutton within tabpage_4
end type
type st_sort4 from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_5 dw_5
cb_4 cb_4
st_sort4 st_sort4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_6 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_6 dw_6
end type
type tab_1 from tab within w_bpm423i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type st_4 from statictext within w_bpm423i
end type
type uo_2 from uo_ccyy_mps within w_bpm423i
end type
type uo_3 from u_bpm_select_arev within w_bpm423i
end type
type st_3 from statictext within w_bpm423i
end type
type ddlb_divcode from dropdownlistbox within w_bpm423i
end type
type st_1 from statictext within w_bpm423i
end type
type sle_1 from singlelineedit within w_bpm423i
end type
type pb_1 from picturebutton within w_bpm423i
end type
type st_2 from statictext within w_bpm423i
end type
type st_8 from statictext within w_bpm423i
end type
type st_9 from statictext within w_bpm423i
end type
type st_10 from statictext within w_bpm423i
end type
type gb_1 from groupbox within w_bpm423i
end type
end forward

global type w_bpm423i from w_origin_sheet04
integer width = 4695
integer height = 2728
event keydown pbm_dwnkey
event ue_postopen ( )
pb_excel pb_excel
uo_1 uo_1
tab_1 tab_1
st_4 st_4
uo_2 uo_2
uo_3 uo_3
st_3 st_3
ddlb_divcode ddlb_divcode
st_1 st_1
sle_1 sle_1
pb_1 pb_1
st_2 st_2
st_8 st_8
st_9 st_9
st_10 st_10
gb_1 gb_1
end type
global w_bpm423i w_bpm423i

type variables
datawindowchild i_dwc_nvmo,i_dwc_mcno
datastore ids_data1,ids_data2,ids_data3,ids_data4
string i_s_chkpt,i_s_ajdate,i_s_div,i_s_plant,i_s_pdcd
end variables

event keydown;if key = keyenter! then
	this.TriggerEvent("ue_retrieve")
end if


end event

event ue_postopen();pb_excel.visible = false
pb_excel.enabled = false

string ls_refyear, ls_message, ls_revno, ls_chkrevno

ls_message = right(message.stringparm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

SELECT REVNO INTO :ls_chkrevno
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND XYEAR = :ls_refyear AND REVNO = :ls_revno
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if f_spacechk(ls_chkrevno) = -1 then
	SELECT XYEAR, REVNO INTO :ls_refyear,:ls_revno
	FROM PBBPM.BPM519
	WHERE COMLTD = '01'
	ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	
	uo_2.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
	ls_revno = '%'
else
	uo_2.uf_reset(integer(ls_refyear))
end if

tab_1.tabpage_1.uo_from.uf_reset(integer(mid(f_relativedate(ls_refyear + '0101',-1),1,4)),1)
tab_1.tabpage_1.uo_to.uf_reset(integer(mid(g_s_date,1,4)),integer(mid(f_relativedate(mid(g_s_date,1,6) + '01',-1),5,2)))

ddlb_divcode.text = '배분후'

f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										ls_revno, &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

on w_bpm423i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.tab_1=create tab_1
this.st_4=create st_4
this.uo_2=create uo_2
this.uo_3=create uo_3
this.st_3=create st_3
this.ddlb_divcode=create ddlb_divcode
this.st_1=create st_1
this.sle_1=create sle_1
this.pb_1=create pb_1
this.st_2=create st_2
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.uo_3
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.ddlb_divcode
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.sle_1
this.Control[iCurrent+11]=this.pb_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_8
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.st_10
this.Control[iCurrent+16]=this.gb_1
end on

on w_bpm423i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.tab_1)
destroy(this.st_4)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.st_3)
destroy(this.ddlb_divcode)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_itno,ls_year,ls_pdnm,ls_revno,ls_divcode,ls_expcode

ls_parm  	= 	uo_1.uf_Return()
ls_itno  	= 	trim(sle_1.text)       + '%'
ls_plant 	= 	trim(mid(ls_parm,1,1)) + '%'
ls_div   	= 	trim(mid(ls_parm,2,1)) + '%'
ls_pdcd  	= 	trim(mid(ls_parm,3,2))
ls_year  	=	uo_2.uf_return()

select prname into :ls_pdnm from pbcommon.dac007
	where comltd = '01' and prprcd = :ls_pdcd using sqlca ;
if sqlca.sqlcode <> 0 then
	ls_pdnm = '%'
end if
ls_pdnm = trim(mid(ls_pdnm,1,30)) + '%'

ls_revno = uo_3.is_uo_revno

if ddlb_divcode.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

setpointer(hourglass!)
//f_pism_working_msg(This.title,ls_year + " 년도 품목별 재료비 정보를 조회중입니다. ~r~n잠시만 기다려 주십시오.") 
if tab_1.selectedtab = 2 then
	if tab_1.tabpage_2.dw_2.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdnm,ls_itno) > 0 then
		tab_1.tabpage_2.cb_2.enabled = true 
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	=	"  " + string(tab_1.tabpage_2.dw_2.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_2.cb_2.enabled = false		
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if
elseif tab_1.selectedtab = 1 then
	if tab_1.tabpage_1.dw_3.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd + '%',ls_itno) > 0 then
		tab_1.tabpage_1.cb_1.enabled = true
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	= "  " + string(tab_1.tabpage_1.dw_3.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_1.cb_1.enabled = false
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if
elseif tab_1.selectedtab = 3 then	
	if tab_1.tabpage_3.dw_4.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd + '%',ls_itno) > 0 then
		tab_1.tabpage_3.cb_3.enabled = true
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	=	"  " +  string(tab_1.tabpage_3.dw_4.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_3.cb_3.enabled = false
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if
elseif tab_1.selectedtab = 4 then	
	if tab_1.tabpage_4.dw_5.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdnm,ls_itno) > 0 then
		tab_1.tabpage_4.cb_4.enabled = true
		pb_excel.visible = true
		pb_excel.enabled = true
		uo_status.st_message.text	=	"  " +  string(tab_1.tabpage_4.dw_5.rowcount()) + " 개의 정보가 " + f_message("I010")
	else
		tab_1.tabpage_4.cb_4.enabled = false
		pb_excel.visible = false
		pb_excel.enabled = false
		uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
	end if	
end if
//If IsValid(w_pism_working) Then Close(w_pism_working)




end event

event open;call super::open;// Post Open Event
THIS.PostEvent('ue_postopen')

end event

type uo_status from w_origin_sheet04`uo_status within w_bpm423i
end type

type pb_excel from picturebutton within w_bpm423i
integer x = 2601
integer y = 224
integer width = 155
integer height = 132
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if tab_1.selectedtab = 1 then
	f_save_to_excel_number(tab_1.tabpage_1.dw_3)
elseif tab_1.selectedtab = 2 then
	f_save_to_excel_number(tab_1.tabpage_2.dw_2)	
elseif tab_1.selectedtab = 3 then
	f_save_to_excel_number(tab_1.tabpage_3.dw_4)
elseif tab_1.selectedtab = 4 then
	f_save_to_excel_number(tab_1.tabpage_4.dw_5)
end if
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm423i
integer x = 14
integer y = 176
integer width = 2569
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type tab_1 from tab within w_bpm423i
integer x = 37
integer y = 400
integer width = 4585
integer height = 2088
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event selectionchanged;if newindex = 1 then
	tab_1.tabpage_1.tabtextcolor = rgb(255,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_3.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_4.tabtextcolor = rgb(0,0,0)  
elseif newindex = 2 then
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(255,0,0)	
	tab_1.tabpage_3.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_4.tabtextcolor = rgb(0,0,0)  
elseif newindex = 3 then
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)	
	tab_1.tabpage_3.tabtextcolor = rgb(255,0,0)	
	tab_1.tabpage_4.tabtextcolor = rgb(0,0,0)  
elseif newindex = 4 then
	tab_1.tabpage_1.tabtextcolor = rgb(0,0,0)
	tab_1.tabpage_2.tabtextcolor = rgb(0,0,0)	
	tab_1.tabpage_3.tabtextcolor = rgb(0,0,0)	
	tab_1.tabpage_4.tabtextcolor = rgb(255,0,0)  
end if

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4549
integer height = 1960
long backcolor = 12632256
string text = " 기획팀 "
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
uo_to uo_to
uo_from uo_from
cb_5 cb_5
st_7 st_7
st_6 st_6
st_5 st_5
cb_1 cb_1
st_sort1 st_sort1
dw_3 dw_3
end type

on tabpage_1.create
this.uo_to=create uo_to
this.uo_from=create uo_from
this.cb_5=create cb_5
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.cb_1=create cb_1
this.st_sort1=create st_sort1
this.dw_3=create dw_3
this.Control[]={this.uo_to,&
this.uo_from,&
this.cb_5,&
this.st_7,&
this.st_6,&
this.st_5,&
this.cb_1,&
this.st_sort1,&
this.dw_3}
end on

on tabpage_1.destroy
destroy(this.uo_to)
destroy(this.uo_from)
destroy(this.cb_5)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cb_1)
destroy(this.st_sort1)
destroy(this.dw_3)
end on

type uo_to from uo_ccyymm_mps within tabpage_1
event destroy ( )
integer x = 1582
integer y = 136
integer taborder = 70
end type

on uo_to.destroy
call uo_ccyymm_mps::destroy
end on

type uo_from from uo_ccyymm_mps within tabpage_1
event destroy ( )
integer x = 521
integer y = 132
integer taborder = 60
end type

on uo_from.destroy
call uo_ccyymm_mps::destroy
end on

type cb_5 from commandbutton within tabpage_1
integer x = 2455
integer y = 128
integer width = 805
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "입고수량및금액생성"
end type

event clicked;string ls_year,ls_pdnm,ls_revno,ls_divcode,ls_expcode,ls_from,ls_to,ls_message,ls_postyear
integer li_rtn

ls_year  	=	uo_2.uf_return()
ls_revno = uo_3.is_uo_revno

ls_from		=	uo_from.uf_yyyymm() + '01'
ls_postyear = mid(ls_from,1,4)
ls_to		=	uo_to.uf_yyyymm() + '31'

li_rtn = Messagebox("확인", ls_from + " 일부터 " + ls_to + " 일까지 입고수량,금액을 생성하시겠습니까?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then return 0

uo_status.st_message.text = "시간이 오래 걸릴수 있습니다...."
setpointer(hourglass!)
sqlca.AutoCommit = FALSE
		
// 생성로직
DELETE FROM PBBPM.BPM516A
WHERE COMLTD = '01' AND XYEAR = :ls_year AND WREV = :ls_revno
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "삭제시에 오류가 발생하였습니다."
	goto Roll_back
end if
		
//생성로직(외자)
INSERT INTO PBBPM.BPM516A
( COMLTD,XYEAR,WREV,WPLANT,WDVSN,WITNO,WVDNO,WQTY,WAMT,WQTY01,WAMT01,
WQTY02,WAMT02,WQTY03,WAMT03,WQTY04,WAMT04,WQTY05,WAMT05,WQTY06,WAMT06,
WQTY07,WAMT07,WQTY08,WAMT08,WQTY09,WAMT09,WQTY10,WAMT10,WQTY11,WAMT11,
WQTY12,WAMT12,WLASTEMP,WLASTDATE )
SELECT B.COMLTD,:ls_year,:ls_revno,B.XPLANT,
  B.DIV,B.ITNO,B.VNDR,
  SUM( CASE WHEN SUBSTRING(TDTE4,1,4) = :ls_postyear THEN B.TQTY4 ELSE 0 END) AS WQTY,
  SUM( CASE WHEN SUBSTRING(TDTE4,1,4) = :ls_postyear THEN B.TRAMT ELSE 0 END) AS WAMT,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '01' THEN B.TQTY4 ELSE 0 END) AS WQTY01,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '01' THEN B.TRAMT ELSE 0 END) AS WAMT01,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '02' THEN B.TQTY4 ELSE 0 END) AS WQTY02,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '02' THEN B.TRAMT ELSE 0 END) AS WAMT02,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '03' THEN B.TQTY4 ELSE 0 END) AS WQTY03,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '03' THEN B.TRAMT ELSE 0 END) AS WAMT03,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '04' THEN B.TQTY4 ELSE 0 END) AS WQTY04,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '04' THEN B.TRAMT ELSE 0 END) AS WAMT04,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '05' THEN B.TQTY4 ELSE 0 END) AS WQTY05,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '05' THEN B.TRAMT ELSE 0 END) AS WAMT05,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '06' THEN B.TQTY4 ELSE 0 END) AS WQTY06,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '06' THEN B.TRAMT ELSE 0 END) AS WAMT06,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '07' THEN B.TQTY4 ELSE 0 END) AS WQTY07,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '07' THEN B.TRAMT ELSE 0 END) AS WAMT07,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '08' THEN B.TQTY4 ELSE 0 END) AS WQTY08,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '08' THEN B.TRAMT ELSE 0 END) AS WAMT08,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '09' THEN B.TQTY4 ELSE 0 END) AS WQTY09,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '09' THEN B.TRAMT ELSE 0 END) AS WAMT09,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '10' THEN B.TQTY4 ELSE 0 END) AS WQTY10,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '10' THEN B.TRAMT ELSE 0 END) AS WAMT10,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '11' THEN B.TQTY4 ELSE 0 END) AS WQTY11,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '11' THEN B.TRAMT ELSE 0 END) AS WAMT11,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '12' THEN B.TQTY4 ELSE 0 END) AS WQTY12,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '12' THEN B.TRAMT ELSE 0 END) AS WAMT12,
  :g_s_empno, :g_s_date
FROM PBINV.INV401 B
WHERE B.COMLTD = '01' AND B.SLIPTYPE = 'RF' AND CLS IN ('10','50') AND
	B.TQTY4 <> 0 AND B.TDTE4 >= :ls_from AND B.TDTE4 <= :ls_to
GROUP BY B.COMLTD,B.XPLANT,B.DIV,B.ITNO,B.VNDR
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "외자생성시에 오류가 발생하였습니다."
	goto Roll_back
end if

//생성로직(내자)
INSERT INTO PBBPM.BPM516A
( COMLTD,XYEAR,WREV,WPLANT,WDVSN,WITNO,WVDNO,WQTY,WAMT,WQTY01,WAMT01,
WQTY02,WAMT02,WQTY03,WAMT03,WQTY04,WAMT04,WQTY05,WAMT05,WQTY06,WAMT06,
WQTY07,WAMT07,WQTY08,WAMT08,WQTY09,WAMT09,WQTY10,WAMT10,WQTY11,WAMT11,
WQTY12,WAMT12,WLASTEMP,WLASTDATE )
SELECT B.COMLTD,:ls_year,:ls_revno,B.XPLANT,
  B.DIV,B.ITNO,B.VSRNO,
  SUM( CASE WHEN SUBSTRING(TDTE4,1,4) = :ls_postyear THEN B.TQTY4 ELSE 0 END) AS WQTY,
  SUM( CASE WHEN SUBSTRING(TDTE4,1,4) = :ls_postyear THEN B.TRAMT ELSE 0 END) AS WAMT,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '01' THEN B.TQTY4 ELSE 0 END) AS WQTY01,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '01' THEN B.TRAMT ELSE 0 END) AS WAMT01,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '02' THEN B.TQTY4 ELSE 0 END) AS WQTY02,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '02' THEN B.TRAMT ELSE 0 END) AS WAMT02,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '03' THEN B.TQTY4 ELSE 0 END) AS WQTY03,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '03' THEN B.TRAMT ELSE 0 END) AS WAMT03,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '04' THEN B.TQTY4 ELSE 0 END) AS WQTY04,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '04' THEN B.TRAMT ELSE 0 END) AS WAMT04,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '05' THEN B.TQTY4 ELSE 0 END) AS WQTY05,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '05' THEN B.TRAMT ELSE 0 END) AS WAMT05,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '06' THEN B.TQTY4 ELSE 0 END) AS WQTY06,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '06' THEN B.TRAMT ELSE 0 END) AS WAMT06,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '07' THEN B.TQTY4 ELSE 0 END) AS WQTY07,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '07' THEN B.TRAMT ELSE 0 END) AS WAMT07,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '08' THEN B.TQTY4 ELSE 0 END) AS WQTY08,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '08' THEN B.TRAMT ELSE 0 END) AS WAMT08,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '09' THEN B.TQTY4 ELSE 0 END) AS WQTY09,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '09' THEN B.TRAMT ELSE 0 END) AS WAMT09,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '10' THEN B.TQTY4 ELSE 0 END) AS WQTY10,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '10' THEN B.TRAMT ELSE 0 END) AS WAMT10,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '11' THEN B.TQTY4 ELSE 0 END) AS WQTY11,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '11' THEN B.TRAMT ELSE 0 END) AS WAMT11,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '12' THEN B.TQTY4 ELSE 0 END) AS WQTY12,
  SUM( CASE WHEN SUBSTRING(TDTE4,5,2) = '12' THEN B.TRAMT ELSE 0 END) AS WAMT12,
  :g_s_empno, :g_s_date
FROM PBINV.INV401 B
WHERE B.COMLTD = '01' AND B.SLIPTYPE = 'RP' AND CLS IN ('10','50') AND 
	B.TQTY4 <> 0 AND B.TDTE4 >= :ls_from AND B.TDTE4 <= :ls_to
GROUP BY B.COMLTD,B.XPLANT,B.DIV,B.ITNO,B.VSRNO
using sqlca;

if sqlca.sqlcode <> 0 then
	ls_message = "내자생성시에 오류가 발생하였습니다."
	goto Roll_back
end if
	
COMMIT USING sqlca;
sqlca.AutoCommit = TRUE
uo_status.st_message.text = "생성작업이 정상적으로 수행되었습니다."

return 0

Roll_back:
ROLLBACK USING sqlca;
sqlca.AutoCommit = TRUE
uo_status.st_message.text = ls_message
return -1

end event

type st_7 from statictext within tabpage_1
integer x = 1253
integer y = 144
integer width = 293
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "완료년월"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_1
integer x = 1111
integer y = 144
integer width = 69
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_1
integer x = 91
integer y = 140
integer width = 407
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "시작년월"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within tabpage_1
integer x = 3365
integer y = 28
integer width = 201
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort ,tab_1.tabpage_1.dw_3)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_1.st_sort1.text = l_str_rtn.dspsort
tab_1.tabpage_1.dw_3.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_1.dw_3.setredraw(false)
tab_1.tabpage_1.dw_3.sort()
tab_1.tabpage_1.dw_3.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort1 from statictext within tabpage_1
integer x = 9
integer y = 28
integer width = 3337
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_3 from datawindow within tabpage_1
integer x = 5
integer y = 240
integer width = 4521
integer height = 1712
integer taborder = 100
string title = "none"
string dataobject = "d_bpm423i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if row < 1 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)
end event

event retrieveend;//setpointer(hourglass!)
//
//string 	ls_return
//dec{1} 	ln_outqty
//dec		ln_outamt
//integer	i,ln_pos
//
//for	i	=	1	to	rowcount
//	ls_return	=	f_inv402_outqty(	trim(this.object.wplant[i]),&
//												trim(this.object.wdvsn[i]),&
//												trim(this.object.witno[i]),&										
//												'200610'	)
//	ln_pos		=	pos(ls_return,',')
//	if ln_pos	=	0	then
//		ln_outqty	=	0
//		ln_outamt	=	0
//	else
//		ln_outqty	=	dec(mid(ls_return,1,ln_pos - 1))
//		ln_outamt	=	dec(mid(ls_return,ln_pos + 1,len(ls_return)))
//	end if
//	this.object.wcostyr[i]		=	ln_outqty
//	this.object.wcostyrbom[i]	=	ln_outamt
//next
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4549
integer height = 1960
long backcolor = 12632256
string text = "구매기획"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_2 cb_2
st_sort2 st_sort2
dw_2 dw_2
end type

on tabpage_2.create
this.cb_2=create cb_2
this.st_sort2=create st_sort2
this.dw_2=create dw_2
this.Control[]={this.cb_2,&
this.st_sort2,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.st_sort2)
destroy(this.dw_2)
end on

type cb_2 from commandbutton within tabpage_2
integer x = 3374
integer y = 28
integer width = 201
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort ,tab_1.tabpage_2.dw_2)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_2.st_sort2.text = l_str_rtn.dspsort
tab_1.tabpage_2.dw_2.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_2.dw_2.setredraw(false)
tab_1.tabpage_2.dw_2.sort()
tab_1.tabpage_2.dw_2.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort2 from statictext within tabpage_2
integer x = 18
integer y = 28
integer width = 3337
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_2 from datawindow within tabpage_2
integer x = 14
integer y = 128
integer width = 4517
integer height = 1816
integer taborder = 30
string dataobject = "d_bpm423i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if row < 1 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4549
integer height = 1960
long backcolor = 12632256
string text = "구매기획(업체별)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_3 cb_3
st_sort3 st_sort3
dw_4 dw_4
end type

on tabpage_3.create
this.cb_3=create cb_3
this.st_sort3=create st_sort3
this.dw_4=create dw_4
this.Control[]={this.cb_3,&
this.st_sort3,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.cb_3)
destroy(this.st_sort3)
destroy(this.dw_4)
end on

type cb_3 from commandbutton within tabpage_3
integer x = 3369
integer y = 28
integer width = 201
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort ,tab_1.tabpage_3.dw_4)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_3.st_sort3.text = l_str_rtn.dspsort
tab_1.tabpage_3.dw_4.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_3.dw_4.setredraw(false)
tab_1.tabpage_3.dw_4.sort()
tab_1.tabpage_3.dw_4.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort3 from statictext within tabpage_3
integer x = 14
integer y = 28
integer width = 3337
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_4 from datawindow within tabpage_3
integer x = 14
integer y = 128
integer width = 4521
integer height = 1824
integer taborder = 40
string dataobject = "d_bpm423i_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if row < 1 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4549
integer height = 1960
long backcolor = 12632256
string text = "구매기획(유상)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_5 dw_5
cb_4 cb_4
st_sort4 st_sort4
end type

on tabpage_4.create
this.dw_5=create dw_5
this.cb_4=create cb_4
this.st_sort4=create st_sort4
this.Control[]={this.dw_5,&
this.cb_4,&
this.st_sort4}
end on

on tabpage_4.destroy
destroy(this.dw_5)
destroy(this.cb_4)
destroy(this.st_sort4)
end on

type dw_5 from datawindow within tabpage_4
integer x = 5
integer y = 112
integer width = 4521
integer height = 1840
integer taborder = 30
string dataobject = "d_bpm423i_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type cb_4 from commandbutton within tabpage_4
integer x = 3365
integer y = 20
integer width = 201
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort ,tab_1.tabpage_4.dw_5)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tabpage_4.st_sort4.text = l_str_rtn.dspsort
tab_1.tabpage_4.dw_5.setsort(l_str_rtn.rtnsort)
tab_1.tabpage_4.dw_5.setredraw(false)
tab_1.tabpage_4.dw_5.sort()
tab_1.tabpage_4.dw_5.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_sort4 from statictext within tabpage_4
integer x = 9
integer y = 20
integer width = 3337
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4549
integer height = 1960
long backcolor = 12632256
string text = "기획팀(내자연동품)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_5.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_5.destroy
destroy(this.dw_6)
end on

type dw_6 from datawindow within tabpage_5
integer x = 18
integer y = 28
integer width = 4507
integer height = 1916
integer taborder = 40
string dataobject = "d_bpm423i_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bpm423i
integer x = 64
integer y = 68
integer width = 297
integer height = 72
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

type uo_2 from uo_ccyy_mps within w_bpm423i
integer x = 357
integer y = 56
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
end type

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										'%', &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

type uo_3 from u_bpm_select_arev within w_bpm423i
integer x = 805
integer y = 60
integer height = 88
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type st_3 from statictext within w_bpm423i
integer x = 1774
integer y = 68
integer width = 329
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "배부기준:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_divcode from dropdownlistbox within w_bpm423i
integer x = 2107
integer y = 52
integer width = 439
integer height = 324
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string item[] = {"배분전","배분후"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_bpm423i
integer x = 2642
integer y = 64
integer width = 137
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_bpm423i
event ue_slekeydown pbm_keydown
integer x = 2798
integer y = 52
integer width = 393
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_bpm423i
integer x = 3209
integer y = 40
integer width = 238
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

l_s_parm  = uo_1.uf_Return()
//if trim(mid(l_s_parm,1,4)) = '' then
//	messagebox("확인",'지역,공장,제품군 정보를 입력 후 찾기 버튼을 Click 바랍니다')
//	return
//end if

openwithparm(w_rtn_find_item, g_s_date + l_s_parm)

l_s_parm = message.stringparm
sle_1.text = l_s_parm

end event

type st_2 from statictext within w_bpm423i
integer x = 3456
integer y = 52
integer width = 681
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_bpm423i
integer x = 2967
integer y = 212
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "1. BOM단위 * 자재변환계수 = 재고단위"
boolean focusrectangle = false
end type

type st_9 from statictext within w_bpm423i
integer x = 2967
integer y = 280
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "2. 재고단위 * 구매변환계수 = 구매단위"
boolean focusrectangle = false
end type

type st_10 from statictext within w_bpm423i
integer x = 2967
integer y = 348
integer width = 1344
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "3. BOM단위 * 통합변환계수 = 구매단위"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bpm423i
integer x = 37
integer y = 16
integer width = 4210
integer height = 160
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

