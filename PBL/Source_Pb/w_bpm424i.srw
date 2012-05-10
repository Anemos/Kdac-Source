$PBExportHeader$w_bpm424i.srw
$PBExportComments$제품별재료비 비교리스트
forward
global type w_bpm424i from w_origin_sheet04
end type
type pb_excel from picturebutton within w_bpm424i
end type
type uo_1 from uo_plandiv_pdcd_all within w_bpm424i
end type
type dw_bpm424i_01 from datawindow within w_bpm424i
end type
type uo_2 from uo_ccyy_mps within w_bpm424i
end type
type st_sort from statictext within w_bpm424i
end type
type cb_sort from commandbutton within w_bpm424i
end type
type st_4 from statictext within w_bpm424i
end type
type uo_3 from u_bpm_select_arev within w_bpm424i
end type
type st_3 from statictext within w_bpm424i
end type
type ddlb_divcode from dropdownlistbox within w_bpm424i
end type
type st_1 from statictext within w_bpm424i
end type
type uo_4 from uo_ccyymm_mps within w_bpm424i
end type
type rb_bpm424i_01 from radiobutton within w_bpm424i
end type
type rb_bpm424i_02 from radiobutton within w_bpm424i
end type
type tab_work from tab within w_bpm424i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_bpm424i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_bpm424i_02 from datawindow within w_bpm424i
end type
type gb_1 from groupbox within w_bpm424i
end type
type gb_2 from groupbox within w_bpm424i
end type
end forward

global type w_bpm424i from w_origin_sheet04
integer width = 4773
integer height = 3040
string title = "제품별재료비 비교리스트"
event keydown pbm_dwnkey
event ue_postopen ( )
pb_excel pb_excel
uo_1 uo_1
dw_bpm424i_01 dw_bpm424i_01
uo_2 uo_2
st_sort st_sort
cb_sort cb_sort
st_4 st_4
uo_3 uo_3
st_3 st_3
ddlb_divcode ddlb_divcode
st_1 st_1
uo_4 uo_4
rb_bpm424i_01 rb_bpm424i_01
rb_bpm424i_02 rb_bpm424i_02
tab_work tab_work
dw_bpm424i_02 dw_bpm424i_02
gb_1 gb_1
gb_2 gb_2
end type
global w_bpm424i w_bpm424i

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

ddlb_divcode.text = '배분후'

f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										ls_revno, &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

on w_bpm424i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.dw_bpm424i_01=create dw_bpm424i_01
this.uo_2=create uo_2
this.st_sort=create st_sort
this.cb_sort=create cb_sort
this.st_4=create st_4
this.uo_3=create uo_3
this.st_3=create st_3
this.ddlb_divcode=create ddlb_divcode
this.st_1=create st_1
this.uo_4=create uo_4
this.rb_bpm424i_01=create rb_bpm424i_01
this.rb_bpm424i_02=create rb_bpm424i_02
this.tab_work=create tab_work
this.dw_bpm424i_02=create dw_bpm424i_02
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_bpm424i_01
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.st_sort
this.Control[iCurrent+6]=this.cb_sort
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.uo_3
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.ddlb_divcode
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.uo_4
this.Control[iCurrent+13]=this.rb_bpm424i_01
this.Control[iCurrent+14]=this.rb_bpm424i_02
this.Control[iCurrent+15]=this.tab_work
this.Control[iCurrent+16]=this.dw_bpm424i_02
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
end on

on w_bpm424i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.dw_bpm424i_01)
destroy(this.uo_2)
destroy(this.st_sort)
destroy(this.cb_sort)
destroy(this.st_4)
destroy(this.uo_3)
destroy(this.st_3)
destroy(this.ddlb_divcode)
destroy(this.st_1)
destroy(this.uo_4)
destroy(this.rb_bpm424i_01)
destroy(this.rb_bpm424i_02)
destroy(this.tab_work)
destroy(this.dw_bpm424i_02)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_plant,ls_div,ls_pdcd,ls_yyyy,ls_mm,ls_year,ls_revno,ls_divcode,ls_expcode

ls_parm  = uo_1.uf_Return()
ls_plant = trim(mid(ls_parm,1,1)) + '%'
ls_div   = trim(mid(ls_parm,2,1)) + '%'
ls_pdcd  = trim(mid(ls_parm,3,2)) + '%'
ls_year  = uo_2.uf_return()
ls_yyyy  = mid(uo_4.uf_yyyymm(),1,4)
ls_mm    = mid(uo_4.uf_yyyymm(),5,2)
ls_revno = uo_3.is_uo_revno

if rb_bpm424i_01.checked then
	if ls_year = ls_yyyy then
		uo_status.st_message.text = "사업계획준비용에 해당하는 집계년월이 아닙니다."
		return 0
	end if
else
	if ls_year <> ls_yyyy then
		uo_status.st_message.text = "실적검토용에 해당하는 집계년월이 아닙니다."
		return 0
	end if
end if
if ddlb_divcode.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

setpointer(hourglass!)
f_pism_working_msg(This.title,ls_year + " 년도 제품별 재료비 정보를 조회중입니다. ~r~n잠시만 기다려 주십시오.") 

choose case tab_work.selectedtab
	case 1
		dw_bpm424i_01.reset()
		if dw_bpm424i_01.retrieve(ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_yyyy,ls_mm) > 0 then
			cb_sort.enabled  = true
			pb_excel.visible = true
			pb_excel.enabled = true
			uo_status.st_message.text	=	"  " + string(dw_bpm424i_01.rowcount()) + " 개의 정보가 " + f_message("I010")
		else
			cb_sort.enabled  = false
			pb_excel.visible = false
			pb_excel.enabled = false
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
		end if
	case 2
		dw_bpm424i_02.reset()
		if dw_bpm424i_02.retrieve(ls_year,ls_revno,ls_divcode,ls_yyyy,ls_mm) > 0 then
			cb_sort.enabled  = true
			pb_excel.visible = true
			pb_excel.enabled = true
			uo_status.st_message.text	=	"  " + string(dw_bpm424i_02.rowcount()) + " 개의 정보가 " + f_message("I010")
		else
			cb_sort.enabled  = false
			pb_excel.visible = false
			pb_excel.enabled = false
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
		end if
end choose

If IsValid(w_pism_working) Then Close(w_pism_working)




end event

event open;call super::open;// Post Open Event
THIS.PostEvent('ue_postopen')

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

tab_work.Width = newwidth - ( tab_work.x + 20 )
dw_bpm424i_01.Width = newwidth	- (ls_gap * 5)
dw_bpm424i_01.Height= newheight - (dw_bpm424i_01.y + ls_status)

dw_bpm424i_02.x = dw_bpm424i_01.x
dw_bpm424i_02.y = dw_bpm424i_01.y
dw_bpm424i_02.Width = dw_bpm424i_01.Width
dw_bpm424i_02.Height= dw_bpm424i_01.Height
end event

type uo_status from w_origin_sheet04`uo_status within w_bpm424i
end type

type pb_excel from picturebutton within w_bpm424i
integer x = 3831
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

event clicked;choose case tab_work.selectedtab
	case 1
		f_save_to_excel_number(dw_bpm424i_01)
	case 2
		f_save_to_excel_number(dw_bpm424i_02)
end choose
end event

type uo_1 from uo_plandiv_pdcd_all within w_bpm424i
integer x = 1189
integer y = 176
integer width = 2587
integer height = 220
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_all::destroy
end on

type dw_bpm424i_01 from datawindow within w_bpm424i
integer x = 23
integer y = 640
integer width = 1737
integer height = 1736
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm424i_01"
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

event retrieveend;long ll_cntx, ll_cnty, ll_cnt_rdcst, ll_cnt_rdqty, ll_cnt_rdort, ll_cnt_fdr, ll_cnt_fir, ll_cnt_fdv
dec{0} lc_sum_rdcst, lc_sum_rdqty, lc_sum_rdort, lc_sum_fdr, lc_sum_fir, lc_sum_fdv
dec{0} lc_won_cost,lc_bp_cost, lc_real_cost, lc_bom_cost
integer li_realcheck, li_bomcheck

for ll_cntx = 1 to rowcount
	lc_sum_rdcst = 0
	ll_cnt_rdcst = 0
	lc_sum_rdqty = 0
	ll_cnt_rdqty = 0
	lc_sum_rdort = 0
	ll_cnt_rdort = 0
	lc_bp_cost = 0
	lc_won_cost = 0
	lc_real_cost = 0
	lc_bom_cost = 0
	
	// 사업계획내자에서 고객사유상제외
	lc_won_cost = this.getitemdecimal(ll_cntx,"bpm515_mtwon") - this.getitemdecimal(ll_cntx,"mcmcd")
	this.setitem(ll_cntx,"bpm515_mtwon",lc_won_cost)
	lc_bp_cost = lc_won_cost + this.getitemdecimal(ll_cntx,"mtfor")
	
	// 실적재료비 평균값 계산
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst01") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst01")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty01") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty01")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort01") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort01")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst02") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst02")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty02") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty02")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort02") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort02")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst03") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst03")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty03") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty03")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort03") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort03")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst04") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst04")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty04") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty04")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort04") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort04")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst05") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst05")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty05") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty05")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort05") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort05")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst06") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst06")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty06") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty06")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort06") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort06")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst07") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst07")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty07") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty07")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort07") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort07")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst08") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst08")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty08") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty08")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort08") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort08")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst09") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst09")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty09") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty09")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort09") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort09")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst10") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst10")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty10") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty10")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort10") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort10")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst11") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst11")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty11") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty11")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort11") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort11")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdcst12") <> 0 then
		lc_sum_rdcst = lc_sum_rdcst + this.getitemdecimal(ll_cntx,"tmp_acc_rdcst12")
		ll_cnt_rdcst = ll_cnt_rdcst + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdqty12") <> 0 then
		lc_sum_rdqty = lc_sum_rdqty + this.getitemdecimal(ll_cntx,"tmp_acc_rdqty12")
		ll_cnt_rdqty = ll_cnt_rdqty + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_acc_rdort12") <> 0 then
		lc_sum_rdort = lc_sum_rdort + this.getitemdecimal(ll_cntx,"tmp_acc_rdort12")
		ll_cnt_rdort = ll_cnt_rdort + 1
	end if
	if ll_cnt_rdcst <> 0 then
		lc_sum_rdcst = lc_sum_rdcst / ll_cnt_rdcst
		this.setitem(ll_cntx,"sumrdcst",lc_sum_rdcst)
	end if
	if ll_cnt_rdqty <> 0 then
		lc_sum_rdqty = lc_sum_rdqty / ll_cnt_rdqty
		this.setitem(ll_cntx,"sumrdqty",lc_sum_rdqty)
	end if
	if ll_cnt_rdort <> 0 then
		lc_sum_rdort = lc_sum_rdort / ll_cnt_rdort
		this.setitem(ll_cntx,"sumrdort",lc_sum_rdort)
	end if
	
	// 사업계획재료비대비 실적재료비 5%내외 평가
	if lc_sum_rdqty <> 0 then 
		lc_real_cost = lc_sum_rdcst / lc_sum_rdqty
	else
		lc_real_cost = 0
	end if
	
	if lc_bp_cost = 0 then
		if ( abs((1 - lc_real_cost) / 1 * 100) >= 5 and lc_real_cost <> 0 ) then
			li_realcheck = 1
		else
			li_realcheck = 0
		end if
	else
		if abs((lc_bp_cost - lc_real_cost) / lc_bp_cost * 100) >= 5 then
			li_realcheck = 1
		else
			li_realcheck = 0
		end if
	end if
	this.setitem(ll_cntx,"realcheck",li_realcheck)
	//BOM월별재료비 평균값 계산
	ll_cnt_fdr = 0
	lc_sum_fdr = 0
	ll_cnt_fir = 0
	lc_sum_fir = 0
	ll_cnt_fdv = 0
	lc_sum_fdv = 0
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr01") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr01")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir01") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir01")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv01") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv01")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr02") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr02")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir02") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir02")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv02") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv02")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr03") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr03")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir03") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir03")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv03") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv03")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr04") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr04")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir04") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir04")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv04") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv04")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr05") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr05")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir05") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir05")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv05") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv05")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr06") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr06")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir06") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir06")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv06") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv06")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr07") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr07")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir07") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir07")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv07") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv07")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr08") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr08")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir08") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir08")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv08") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv08")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr09") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr09")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir09") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir09")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv09") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv09")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr10") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr10")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir10") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir10")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv10") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv10")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr11") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr11")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir11") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir11")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv11") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv11")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdr12") <> 0 then
		lc_sum_fdr = lc_sum_fdr + this.getitemdecimal(ll_cntx,"tmp_bom_fdr12")
		ll_cnt_fdr = ll_cnt_fdr + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fir12") <> 0 then
		lc_sum_fir = lc_sum_fir + this.getitemdecimal(ll_cntx,"tmp_bom_fir12")
		ll_cnt_fir = ll_cnt_fir + 1
	end if
	if this.getitemdecimal(ll_cntx,"tmp_bom_fdv12") <> 0 then
		lc_sum_fdv = lc_sum_fdv + this.getitemdecimal(ll_cntx,"tmp_bom_fdv12")
		ll_cnt_fdv = ll_cnt_fdv + 1
	end if
	if ll_cnt_fdr <> 0 then
		lc_sum_fdr = lc_sum_fdr / ll_cnt_fdr
		this.setitem(ll_cntx,"sumfdr",lc_sum_fdr )
	end if
	if ll_cnt_fir <> 0 then
		lc_sum_fir = lc_sum_fir / ll_cnt_fir
		this.setitem(ll_cntx,"sumfir",lc_sum_fir )
	end if
	if ll_cnt_fdv <> 0 then
		lc_sum_fdv = lc_sum_fdv / ll_cnt_fdv
		this.setitem(ll_cntx,"sumfdv",lc_sum_fdv )
	end if
	
	// 사업계획재료비대비 BOM재료비 5%내외 평가
	lc_bom_cost = lc_sum_fdr + lc_sum_fir
	
	if lc_bp_cost = 0 then
		if ( abs((1 - lc_bom_cost) / 1 * 100) >= 5 and lc_bom_cost <> 0 ) then
			li_bomcheck = 1
		else
			li_bomcheck = 0
		end if
	else
		if abs((lc_bp_cost - lc_bom_cost) / lc_bp_cost * 100) >= 5 then
			li_bomcheck = 1
		else
			li_bomcheck = 0
		end if
	end if
	this.setitem(ll_cntx,"bomcheck",li_bomcheck)
next
end event

type uo_2 from uo_ccyy_mps within w_bpm424i
integer x = 389
integer y = 56
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										'%', &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

type st_sort from statictext within w_bpm424i
integer x = 32
integer y = 400
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

type cb_sort from commandbutton within w_bpm424i
integer x = 3387
integer y = 400
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

openwithparm(w_gms_setsort ,dw_bpm424i_01)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

st_sort.text = l_str_rtn.dspsort
dw_bpm424i_01.setsort(l_str_rtn.rtnsort)
dw_bpm424i_01.setredraw(false)
dw_bpm424i_01.sort()
dw_bpm424i_01.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type st_4 from statictext within w_bpm424i
integer x = 96
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
string text = "사업년도"
boolean focusrectangle = false
end type

type uo_3 from u_bpm_select_arev within w_bpm424i
integer x = 837
integer y = 60
integer height = 88
integer taborder = 40
boolean bringtotop = true
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type st_3 from statictext within w_bpm424i
integer x = 1806
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

type ddlb_divcode from dropdownlistbox within w_bpm424i
integer x = 2139
integer y = 52
integer width = 439
integer height = 324
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
string item[] = {"배분전","배분후"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_bpm424i
integer x = 2725
integer y = 68
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "집계년월"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_4 from uo_ccyymm_mps within w_bpm424i
integer x = 3058
integer y = 52
integer taborder = 50
boolean bringtotop = true
end type

on uo_4.destroy
call uo_ccyymm_mps::destroy
end on

type rb_bpm424i_01 from radiobutton within w_bpm424i
integer x = 73
integer y = 264
integer width = 581
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "사업계획준비용"
boolean checked = true
end type

type rb_bpm424i_02 from radiobutton within w_bpm424i
integer x = 686
integer y = 264
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "실적검토용"
end type

type tab_work from tab within w_bpm424i
event create ( )
event destroy ( )
integer x = 23
integer y = 508
integer width = 4283
integer height = 124
integer taborder = 80
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
end type

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;Choose Case newindex 
	Case 1
		dw_bpm424i_01.Visible = True 
		dw_bpm424i_02.Visible = False 
	Case 2
		dw_bpm424i_01.Visible = False 
		dw_bpm424i_02.Visible = True 
End Choose 
end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 4247
integer height = -4
long backcolor = 12632256
string text = "사업계획기준"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 4247
integer height = -4
long backcolor = 12632256
string text = "실적기준"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_bpm424i_02 from datawindow within w_bpm424i
integer x = 1774
integer y = 640
integer width = 1737
integer height = 1736
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm424i_01_exception"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row < 1 then
	return
end if
this.selectrow(0,false)
this.selectrow(row,true)
end event

event constructor;this.settransobject(sqlca)
end event

type gb_1 from groupbox within w_bpm424i
integer x = 37
integer y = 16
integer width = 3694
integer height = 160
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_bpm424i
integer x = 37
integer y = 208
integer width = 1143
integer height = 160
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

