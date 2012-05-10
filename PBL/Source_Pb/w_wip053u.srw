$PBExportHeader$w_wip053u.srw
$PBExportComments$실사대장 및 조사표 출력
forward
global type w_wip053u from w_origin_sheet02
end type
type dw_1 from datawindow within w_wip053u
end type
type uo_1 from uo_yymm_boongi within w_wip053u
end type
type st_1 from statictext within w_wip053u
end type
type dw_2 from datawindow within w_wip053u
end type
type dw_report from datawindow within w_wip053u
end type
type st_2 from statictext within w_wip053u
end type
type st_3 from statictext within w_wip053u
end type
type cb_create from commandbutton within w_wip053u
end type
type cb_regempno from commandbutton within w_wip053u
end type
type pb_down from picturebutton within w_wip053u
end type
type dw_3 from datawindow within w_wip053u
end type
type st_4 from statictext within w_wip053u
end type
type st_5 from statictext within w_wip053u
end type
type st_6 from statictext within w_wip053u
end type
type st_7 from statictext within w_wip053u
end type
type cb_knockdown from commandbutton within w_wip053u
end type
type pb_down2 from picturebutton within w_wip053u
end type
type st_9 from statictext within w_wip053u
end type
type st_10 from statictext within w_wip053u
end type
type cb_check from commandbutton within w_wip053u
end type
type gb_1 from groupbox within w_wip053u
end type
type gb_2 from groupbox within w_wip053u
end type
type gb_3 from groupbox within w_wip053u
end type
end forward

global type w_wip053u from w_origin_sheet02
event ue_init ( )
dw_1 dw_1
uo_1 uo_1
st_1 st_1
dw_2 dw_2
dw_report dw_report
st_2 st_2
st_3 st_3
cb_create cb_create
cb_regempno cb_regempno
pb_down pb_down
dw_3 dw_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
cb_knockdown cb_knockdown
pb_down2 pb_down2
st_9 st_9
st_10 st_10
cb_check cb_check
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_wip053u w_wip053u

type variables
string is_adjdt
end variables

forward prototypes
public subroutine wf_set_report (datawindow arg_dw, string arg_xdate)
end prototypes

event ue_init();String ls_adjdt, ls_stscd
datawindowchild dwc_01, dwc_02, dwc_03, dwc_04

SELECT DISTINCT WZSTDT, WZLSTSCD INTO :ls_adjdt, :ls_stscd
FROM PBWIP.WIP090
using sqlca;

if ls_stscd = 'C' then
	cb_create.enabled = false
	cb_regempno.enabled = false
	cb_knockdown.enabled = false
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
else
	cb_create.enabled = True
	cb_regempno.enabled = True
	cb_knockdown.enabled = True
//	 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
end if

uo_1.uf_reset(integer(mid(ls_adjdt,1,4)),integer(mid(ls_adjdt,5,2)))

dw_2.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_2.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_2.getchild("inv101_pdcd",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('A')
dw_2.getchild("wip001_waorct",dwc_04)
dwc_04.settransobject(sqlca)
dwc_04.retrieve('D','A',mid(ls_adjdt,1,4))
	
dw_2.insertrow(0)


end event

public subroutine wf_set_report (datawindow arg_dw, string arg_xdate);long ll_rowcnt, ll_curcnt, ll_currow
string ls_year, ls_month, ls_cmcd, ls_plant, ls_dvsn, ls_pdcd, ls_xdate

ll_rowcnt = dw_1.rowcount()

for ll_curcnt = 1 to ll_rowcnt
	ll_currow = arg_dw.insertrow(0)
//	ls_xdate = dw_1.getitemstring(ll_curcnt,"wip006_wfyear") &
//				+ dw_1.getitemstring(ll_curcnt,"wip006_wfmonth") + '31' 
	arg_dw.setitem(ll_currow,"inv101_xplant",dw_1.getitemstring(ll_curcnt,"wip006_wfplant"))
	arg_dw.setitem(ll_currow,"inv101_div",dw_1.getitemstring(ll_curcnt,"wip006_wfdvsn"))
	arg_dw.setitem(ll_currow,"inv101_iunpr",dw_1.getitemnumber(ll_curcnt,"wip006_wfserial"))
	arg_dw.setitem(ll_currow,"inv101_wloc",' ')
	arg_dw.setitem(ll_currow,"inv002_itnm",dw_1.getitemstring(ll_curcnt,"wip006_wfitnm"))
	arg_dw.setitem(ll_currow,"inv101_itno",dw_1.getitemstring(ll_curcnt,"wip006_wfitno"))
	arg_dw.setitem(ll_currow,"inv101_xunit",dw_1.getitemstring(ll_curcnt,"wip006_wfunit"))
	arg_dw.setitem(ll_currow,"inv101_srce",dw_1.getitemstring(ll_curcnt,"inv101_srce"))
	arg_dw.setitem(ll_currow,"officer2",dw_1.getitemstring(ll_curcnt,"wip010_whempbnm"))
	arg_dw.setitem(ll_currow,"officer1",dw_1.getitemstring(ll_curcnt,"wip010_whempmnm"))
	arg_dw.setitem(ll_currow,"xdate", string(arg_xdate,"@@@@.@@.@@"))
	arg_dw.setitem(ll_currow,"orct",dw_1.getitemstring(ll_curcnt,"wip006_wfdept"))
	arg_dw.setitem(ll_currow,"pdcd",dw_1.getitemstring(ll_curcnt,"wip006_wfpdcd"))
	arg_dw.setitem(ll_currow,"pdnm",dw_1.getitemstring(ll_curcnt,"wip006_wfpdnm"))
next
end subroutine

on w_wip053u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_report=create dw_report
this.st_2=create st_2
this.st_3=create st_3
this.cb_create=create cb_create
this.cb_regempno=create cb_regempno
this.pb_down=create pb_down
this.dw_3=create dw_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.cb_knockdown=create cb_knockdown
this.pb_down2=create pb_down2
this.st_9=create st_9
this.st_10=create st_10
this.cb_check=create cb_check
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_create
this.Control[iCurrent+9]=this.cb_regempno
this.Control[iCurrent+10]=this.pb_down
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.cb_knockdown
this.Control[iCurrent+17]=this.pb_down2
this.Control[iCurrent+18]=this.st_9
this.Control[iCurrent+19]=this.st_10
this.Control[iCurrent+20]=this.cb_check
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.gb_3
end on

on w_wip053u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_report)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_create)
destroy(this.cb_regempno)
destroy(this.pb_down)
destroy(this.dw_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_knockdown)
destroy(this.pb_down2)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.cb_check)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)

This.Postevent("ue_init")

end event

event ue_retrieve;call super::ue_retrieve;dec{0} ld_yyyymm
string ls_year, ls_month, ls_plant, ls_dvsn, ls_pdcd, ls_orct
long ll_rowcnt

dw_1.reset()
dw_2.accepttext()

ld_yyyymm     = uo_1.uf_yyyymm()
is_adjdt        = string(ld_yyyymm)
ls_year 	= mid(is_adjdt,1,4)
ls_month = mid(is_adjdt,5,2)

ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_2.getitemstring(1, "wip001_wadvsn")
ls_pdcd = trim(dw_2.getitemstring(1,"inv101_pdcd"))
ls_orct = trim(dw_2.getitemstring(1,"wip001_waorct"))

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "지역 또는 공장을 선택해주십시요"
	return 0
end if

// 실사 상태체크
if Not f_wip_check_applystatus('01',ls_plant,ls_dvsn, ls_year + ls_month) then
	uo_status.st_message.text = "실사년월이 아니거나 실사가 확정되었습니다."
	cb_create.enabled = false
	cb_knockdown.enabled = false
	cb_regempno.enabled = false
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
else
	cb_create.enabled = true
	cb_knockdown.enabled = true
	cb_regempno.enabled = true
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
end if

if f_spacechk(ls_pdcd) = -1 then
	ls_pdcd = '%'
else
	ls_pdcd = ls_pdcd + '%'
end if

if f_spacechk(ls_orct) = -1 then
	ls_orct = '%'
else
	ls_orct = ls_orct + '%'
end if

ll_rowcnt = dw_1.retrieve(ls_year,ls_month,g_s_company,ls_plant,ls_dvsn, ls_pdcd, ls_orct)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다. 재공실사담당자가 등록되어 있는지 확인하십시요."
else
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event ue_print;call super::ue_print;string ls_rtn, ls_printdate
long ll_rowcnt, ll_cnt
window 	l_to_open
str_easy l_str_prt

if dw_1.rowcount() < 1 then
	uo_status.st_message.text = "조회한 데이타가 없습니다."
	return 0
end if

open(w_wip053u_01)
ls_rtn = message.stringparm

if f_spacechk(ls_rtn) = -1 then
	return 0
end if

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
dw_report.sharedataoff()
dw_report.reset()
uo_status.st_message.Text = "출력 준비중 입니다..."

if mid(ls_rtn,1,1) = '1' then
	dw_report.dataobject = 'd_wip053u_report_01'
	dw_report.settransobject(sqlca)
	
	dw_1.sharedata(dw_report)
else
	dw_report.dataobject = 'd_wip053u_report_02'
	dw_report.settransobject(sqlca)
	//재고 조사표 데이타생성
	wf_set_report(dw_report,mid(ls_rtn,2))
end if

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = ' '
l_str_prt.title = "재공실사대장&조사표발행"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

event ue_save;call super::ue_save;dw_1.accepttext()

if dw_1.update() = 1 then
	uo_status.st_message.text = "저장되었습니다."
else
	uo_status.st_message.text = "저장이 실패하였습니다."
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_wip053u
end type

type dw_1 from datawindow within w_wip053u
integer x = 27
integer y = 748
integer width = 4567
integer height = 1720
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_wip053u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;//string ls_plant, ls_dvsn, ls_itno, ls_pdcd
if currentrow < 1 then
	return 0
end if

This.selectrow(currentrow,False)
This.selectrow(newrow,True)

//	ls_plant = This.getitemstring(newrow,"wip006_wfplant")
//	ls_dvsn = This.getitemstring(newrow,"wip006_wfdvsn")
//	ls_itno = This.getitemstring(newrow,"wip006_wfitno")
//	
//	select substring(pdcd,1,2) into :ls_pdcd
//	from pbinv.inv101
//	where comltd = '01' and xplant = :ls_plant and
//		div = :ls_dvsn and itno = :ls_itno
//	using sqlca;
//	
//	This.setitem(newrow,'wip006_wfpdcd',ls_pdcd)
//

end event

event itemchanged;dec{4} lc_wfphqt, lc_wfohqt
dec{4} lc_convqty
string ls_itno, ls_plant, ls_dvsn, ls_year, ls_month, ls_stscd
string ls_itnm, ls_spec, ls_unit, ls_dept, ls_chkpdcd, ls_error
integer li_serial, li_rowcnt, li_chkserial

if dwo.name = "wip006_wfitno" then
	//입력된 품번체크
	ls_itno = data
	ls_year = This.getitemstring(row,"wip006_wfyear")
	ls_month = This.getitemstring(row,"wip006_wfmonth")
	ls_plant = This.getitemstring(row,"wip006_wfplant")
	ls_dvsn = This.getitemstring(row,"wip006_wfdvsn")
	ls_stscd = This.getitemstring(row,"wip006_wfstscd")
	ls_dept = This.getitemstring(row,"wip006_wfdept")
	li_serial = This.getitemnumber(row,"wip006_wfserial")
	if f_spacechk(ls_itno) <> -1 then
		SELECT count(*) INTO :li_rowcnt
		FROM PBWIP.WIP006
		WHERE WFYEAR = :ls_year AND WFMONTH = :ls_month AND
				WFCMCD = :g_s_company AND WFPLANT = :ls_plant AND
				WFDVSN = :ls_dvsn AND WFITNO = :ls_itno AND WFDEPT = :ls_dept
		using sqlca;
	
		if li_rowcnt < 1 then
			SELECT AA.ITNM, AA.SPEC, BB.XUNIT, BB.PDCD 
				INTO :ls_itnm, :ls_spec, :ls_unit, :ls_chkpdcd
			FROM PBINV.INV002 AA, PBINV.INV101 BB
			WHERE AA.COMLTD = BB.COMLTD AND AA.ITNO = BB.ITNO AND
					BB.COMLTD = :g_s_company AND BB.XPLANT = :ls_plant AND
					BB.DIV = :ls_dvsn AND BB.ITNO = :ls_itno
			using sqlca;
			
			if sqlca.sqlcode <> 0 then
				messagebox("경고","적용한 품번 : " + ls_itno + " 은 품번기본정보에 없습니다.")
				ls_error = 'itno'
			else
				//기본정보 셋팅
				This.setitem(row,"wip006_wfpdcd",ls_chkpdcd)
				This.setitem(row,"wip006_wfitnm",ls_itnm)
				This.setitem(row,"wip006_wfspec",ls_spec)
				This.setitem(row,"wip006_wfunit",ls_unit)
				This.setitem(row,"wip006_wfipaddr",g_s_ipaddr)
				This.setitem(row,"wip006_wfmacaddr",g_s_macaddr)
				This.setitem(row,"wip006_wfupdtdt",g_s_date)
			end if
		else
			messagebox("경고","적용한 품번 : " + ls_itno + " 은 일련번호가 부여된 품번입니다.")
			ls_error = 'itno'
		end if
	else
		//기본정보 셋팅
		This.setitem(row,"wip006_wfpdcd",'')
		This.setitem(row,"wip006_wfitnm",'')
		This.setitem(row,"wip006_wfspec",'')
		This.setitem(row,"wip006_wfunit",'')
		This.setitem(row,"wip006_wfipaddr",g_s_ipaddr)
		This.setitem(row,"wip006_wfmacaddr",g_s_macaddr)
		This.setitem(row,"wip006_wfinptdt",g_s_empno)
		This.setitem(row,"wip006_wfupdtdt",g_s_date)
	end if
	if ls_error = 'itno' then
		This.setitem(row,"wip006_wfitno",'')
		This.setcolumn("wip006_wfitno")
		This.setfocus()
		return 1
	end if
end if

if dwo.name = 'phqt' then
	if dec(data) < 0 then
		messagebox("알림","실사수량은 0보다 적을수 없습니다.")
		This.setitem( row, 'phqt', 0)
		return 1
	end if
	ls_plant = This.getitemstring(row,"wip006_wfplant")
	ls_dvsn = This.getitemstring(row,"wip006_wfdvsn")
	ls_itno = This.getitemstring(row,"wip006_wfitno")
	
	select convqty into :lc_convqty
	from pbinv.inv101
	where comltd = '01' and xplant = :ls_plant and
		div = :ls_dvsn and itno = :ls_itno
	using sqlca;
	
	lc_wfphqt = DEC(data) * lc_convqty
	This.setitem(row,"wip006_wfphqt",lc_wfphqt)
	This.setitem(row,"wip006_wfipaddr",g_s_ipaddr)
	This.setitem(row,"wip006_wfmacaddr",g_s_macaddr)
	This.setitem(row,"wip006_wfinptdt",g_s_empno)
	This.setitem(row,"wip006_wfupdtdt",g_s_date)
end if

Return 0
end event

type uo_1 from uo_yymm_boongi within w_wip053u
integer x = 434
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_yymm_boongi::destroy
end on

type st_1 from statictext within w_wip053u
integer x = 87
integer y = 64
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_wip053u
integer x = 969
integer y = 36
integer width = 3122
integer height = 140
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053u_02"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_null, ls_dvsn
datawindowchild cdw_1, cdw_2

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
	
	This.SetItem(1,'wip001_waorct', ' ')
	ls_plant = This.GetItemString(1,'wip001_waplant')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("wip001_waorct",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_plant,ls_dvsn,mid(string(uo_1.uf_yyyymm()),1,4))
END IF
end event

type dw_report from datawindow within w_wip053u
boolean visible = false
integer x = 4110
integer y = 200
integer width = 393
integer height = 140
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053u_report_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_wip053u
integer x = 2459
integer y = 300
integer width = 1641
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "주의: 등록품번에 대한 일련번호( 1~~ )를 재생성합니다."
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip053u
integer x = 2619
integer y = 368
integer width = 1330
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "만약에 입력된 장부,실사수량이 있다면 삭제됩니다."
boolean focusrectangle = false
end type

type cb_create from commandbutton within w_wip053u
integer x = 1559
integer y = 284
integer width = 855
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "등록품번 일련번호 부여"
end type

event clicked;dec{0} ld_yyyymm
string ls_plant, ls_dvsn, ls_year, ls_month
long ll_rowcnt

setpointer(hourglass!)

//if g_s_empno <> 'ADMIN' then
//	uo_status.st_message.text = "생성작업은 시스템개발의 재공담당자만 가능합니다."
//	return 0
//end if
ld_yyyymm     = uo_1.uf_yyyymm()
ls_year 	= mid(string(ld_yyyymm),1,4)
ls_month = mid(string(ld_yyyymm),5,2)

ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_2.getitemstring(1, "wip001_wadvsn")

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "지역 또는 공장을 선택해주십시요"
	return 0
end if
		
if MessageBox("작업실행", "***주의 : 기존에 입력된 일련번호 모두 삭제됩니다. 일련번호가 달라집니다. *** ~r" &
		+ " 기준년월 : " + string(ld_yyyymm) &
		+ " 에대한 일련번호에 대한 재생성 " &
		+ " 작업을 실행하시겠읍니까? ", Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

f_pism_working_msg(parent.title,"해당공장 실사품번을 생성하고 있습니다. 잠시만 기다려 주십시오.") 
DECLARE up_wip_17 PROCEDURE FOR PBWIP.SP_WIP_17  
         A_CMCD = :g_s_company,   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_YEAR = :ls_year,   
         A_MONTH = :ls_month  using sqlca;

execute up_wip_17;

If IsValid(w_pism_working) Then Close(w_pism_working)
uo_status.st_message.text = "생성이 완료되었습니다."
end event

type cb_regempno from commandbutton within w_wip053u
integer x = 1559
integer y = 372
integer width = 855
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "재공실사자등록"
end type

event clicked;dec{0} ld_yyyymm
string ls_plant, ls_dvsn, ls_year, ls_month, ls_parm
long ll_rowcnt

setpointer(hourglass!)

ld_yyyymm     = uo_1.uf_yyyymm()
ls_year 	= mid(string(ld_yyyymm),1,4)
ls_month = mid(string(ld_yyyymm),5,2)

ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_2.getitemstring(1, "wip001_wadvsn")

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "지역 또는 공장을 선택해주십시요"
	return 0
end if

SELECT COUNT(*) INTO :ll_rowcnt FROM PBWIP.WIP006
WHERE WFYEAR = :ls_year AND WFMONTH = :ls_month AND
		WFCMCD = :g_s_company AND WFPLANT = :ls_plant AND
		WFDVSN = :ls_dvsn using sqlca;
		
if ll_rowcnt < 1 then
	uo_status.st_message.text = "생성된 품번이 없습니다. 먼저 일련번호에 대한 품번생성작업을 하십시요."
	return 0
end if
ls_parm = ls_year + ls_month + ls_plant + ls_dvsn
openwithparm(w_reg_checkman , ls_parm)

end event

type pb_down from picturebutton within w_wip053u
integer x = 3328
integer y = 616
integer width = 279
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;long ld_yyyymm
string ls_year, ls_month, ls_plant, ls_dvsn

ld_yyyymm     = uo_1.uf_yyyymm()
ls_year 	= mid(string(ld_yyyymm),1,4)
ls_month = mid(string(ld_yyyymm),5,2)
ls_plant = dw_2.getitemstring(1, "wip001_waplant")
ls_dvsn  = dw_2.getitemstring(1, "wip001_wadvsn")

dw_3.reset()
dw_3.retrieve(ls_year, ls_month, '01', ls_plant, ls_dvsn)
f_save_to_excel(dw_3)

return 0
end event

type dw_3 from datawindow within w_wip053u
boolean visible = false
integer x = 4315
integer y = 276
integer width = 265
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip053u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_wip053u
integer x = 59
integer y = 304
integer width = 1454
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "1. 실사등록품번에 대한 일련번호를 부여한다."
boolean focusrectangle = false
end type

type st_5 from statictext within w_wip053u
integer x = 59
integer y = 376
integer width = 1454
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "2. 일련번호부여뒤에 재공실사자를 등록한다."
boolean focusrectangle = false
end type

type st_6 from statictext within w_wip053u
integer x = 59
integer y = 640
integer width = 2190
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "4. 재공실사수량을 입력한 뒤에 ~'30~',~'10/03~'품번에 대한 KNOCK DOWN실행"
boolean focusrectangle = false
end type

type st_7 from statictext within w_wip053u
integer x = 59
integer y = 568
integer width = 1861
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "3. 조코드 9999로 실사수량을 취합하여 재공실사를 완료한다."
boolean focusrectangle = false
end type

type cb_knockdown from commandbutton within w_wip053u
integer x = 2053
integer y = 568
integer width = 1015
integer height = 116
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Knock Down 및 실사수량 취합"
end type

event clicked;//----------KNOCK DOWN 실행순서----------------------------------------------
// 1. SP_WIP_171 수행 : 데이타 초기화및 조코드 '9999' 품번 취합
// 2. Lolevel 0 에서 TopLevel 까지 While문 수행
// 3. SP_WIP_172 수행 : KNOCK DOWN PROCESS
// 4. WIP006 실사수량 취합
//---------------------------------------------------------------------------
long ld_yyyymm, ll_rowcnt, ll_cnt, ll_count
integer li_curlevel, li_toplevel
string ls_nextyear, ls_nextmonth, ls_rtndate, ls_year, ls_month, ls_plant, ls_dvsn
string ls_adjdate, ls_itno, ls_cls, ls_srce
dec{4} lc_phqt
datastore lds_01

lds_01 = create datastore
lds_01.dataobject = 'd_wip053u_04'
lds_01.settransobject(sqlca)

ld_yyyymm     = uo_1.uf_yyyymm()
ls_year 	= mid(string(ld_yyyymm),1,4)
ls_month = mid(string(ld_yyyymm),5,2)
ls_rtndate = uf_wip_addmonth(ls_year + ls_month, 1)
ls_nextyear = mid(ls_rtndate,1,4)
ls_nextmonth = mid(ls_rtndate,5,2)
ls_adjdate = ls_year + ls_month + '31'
li_curlevel = 0

ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_2.getitemstring(1, "wip001_wadvsn")

If Not f_wip_check_applystatus('01',ls_plant,ls_dvsn,ls_year + ls_month) Then
	uo_status.st_message.text = "년간 라인실사작업이 완료되어 수행할수 없습니다."
	return 0
End If

If ls_plant = 'D' then
	choose case ls_dvsn
		case 'M','S','V'
			uo_status.st_message.text = "해당공장은 이작업을 수행할수 없습니다."
			return 0
	end choose
end if

if MessageBox("KnockDown및실사수량취합", "기준년월 : " + string(ld_yyyymm) &
		+ " 에대한 입력된 실사수량이 삭제될수 있습니다. " &
		+ " 작업을 실행하시겠읍니까? ", Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

setpointer(hourglass!)

delete from pbwip.wip012
where wfyear = :ls_year and wfmonth = :ls_month and
	wfplant = :ls_plant and wfdvsn = :ls_dvsn
using sqlca;

DECLARE up_wip_171 PROCEDURE FOR PBWIP.SP_WIP_171  
         A_CMCD = '01',   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_YEAR = :ls_year,   
         A_MONTH = :ls_month,   
         A_ADJDATE = :ls_adjdate,
			A_EMPNO = :g_s_empno,
			A_INPUTDATE = :g_s_date 
			using sqlca;
Execute up_wip_171;
if sqlca.sqlcode < 0 then
	messagebox("에러", "데이타 초기화시에 에러가 발생하였습니다." + sqlca.sqlerrtext)
	return 0
end if

// Get Top-Level
select max(cc.lolevel) into :li_toplevel
  from pbwip.wip006 aa, pbinv.inv101 bb, pbinv.inv002 cc
  where aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno and
    bb.comltd = cc.comltd and bb.itno = cc.itno and
    aa.wfyear = :ls_year and
    aa.wfmonth = :ls_month and aa.wfcmcd = '01' and
    aa.wfplant = :ls_plant and aa.wfdvsn = :ls_dvsn and
    aa.wfdept = '9999' and (aa.wfphqt <> 0 or aa.wfohqt <> 0) and
    ( bb.cls in ('30','50') or bb.srce = '03' )
using sqlca;

Do While li_curlevel <= li_toplevel
	lds_01.reset()
	ll_rowcnt = lds_01.retrieve(ls_year, ls_month, '01', ls_plant, ls_dvsn, li_curlevel)
	
	for ll_cnt = 1 to ll_rowcnt
		ls_itno = lds_01.getitemstring(ll_cnt,'wfitno')
		lc_phqt = lds_01.getitemnumber(ll_cnt,'sumphqt')
		ls_cls = lds_01.getitemstring(ll_cnt,'cls')
		ls_srce = lds_01.getitemstring(ll_cnt,'srce')
		
		if ls_plant = 'J' and ls_cls = '50' and ls_srce = '04' then
			continue
		end if
		
		select count(*) into :ll_count from pbpdm.bom001
		where pcmcd = '01' AND plant = :ls_plant AND
				pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
				(( pedte = ' '  and pedtm <= :ls_adjdate ) or
				( pedte <> ' ' and pedtm <= :ls_adjdate and pedte >= :ls_adjdate ));
		if sqlca.sqlcode <> 0 or ll_count < 1 then
			messagebox("경고","해당품번 : " + ls_itno + " 은 BOM미등록품입니다. " )
			update pbwip.wip006
				set wfextd = 'X'
				where wfyear = :ls_year and wfmonth = :ls_month and
						wfcmcd = '01' and wfplant = :ls_plant and
						wfdvsn = :ls_dvsn and wfdept = '9999' and wfitno = :ls_itno
			using sqlca;
			
  			continue
		end if
		
		DECLARE up_wip_172 PROCEDURE FOR PBWIP.SP_WIP_172  
				A_CMCD = '01',   
				A_PLANT = :ls_plant,   
				A_DVSN = :ls_dvsn,   
				A_YEAR = :ls_year,   
				A_MONTH = :ls_month,   
				A_ADJDATE = :ls_adjdate,   
				A_ITNO = :ls_itno,
				A_PHQT = :lc_phqt,
				A_CLS = :ls_cls,
				A_SRCE = :ls_srce,
				A_EMPNO = :g_s_empno,
				A_INPUTDATE = :g_s_date
				using sqlca;
	
		Execute up_wip_172;
		if sqlca.sqlcode < 0 then
			messagebox("에러", "데이타크로스체크에 에러가 발생하였습니다." + ls_itno + " : " + string(sqlca.sqlcode) + " : " + sqlca.sqlerrtext)
			return 0
		end if
	next
	
	li_curlevel = li_curlevel + 1
	select max(cc.lolevel) into :li_toplevel
   from pbwip.wip006 aa, pbinv.inv101 bb, pbinv.inv002 cc
	where aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
		 aa.wfdvsn = bb.div and aa.wfitno = bb.itno and
		 bb.comltd = cc.comltd and bb.itno = cc.itno and
		 aa.wfyear = :ls_year and
		 aa.wfmonth = :ls_month and aa.wfcmcd = '01' and
		 aa.wfplant = :ls_plant and aa.wfdvsn = :ls_dvsn and
		 aa.wfdept = '9999' and (aa.wfphqt <> 0 or aa.wfohqt <> 0) and
		 ( bb.cls in ('30','50') or bb.srce = '03' )
	using sqlca;
Loop

// End Step : Total Summary Job
update pbwip.wip006
set wfphqt = wfphqt + wfohqt, wfinptdt = :g_s_empno, wfupdtdt = :g_s_date
where wfyear = :ls_year and wfmonth = :ls_month and
      wfcmcd = '01' and wfplant = :ls_plant and
      wfdvsn = :ls_dvsn and wfdept = '9999' and
		exists ( select itno from pbinv.inv101
			where wfcmcd = comltd and wfplant = xplant and
				wfdvsn= div and wfitno = itno and
				cls = '10' and srce <> '03' )
using sqlca;

update pbwip.wip006
set wfphqt = 0, wfinptdt = :g_s_empno, wfupdtdt = :g_s_date
where wfyear = :ls_year and wfmonth = :ls_month and
      wfcmcd = '01' and wfplant = :ls_plant and
      wfdvsn = :ls_dvsn and wfdept = '9999' and
		not exists ( select itno from pbinv.inv101
			where wfcmcd = comltd and wfplant = xplant and
				wfdvsn= div and wfitno = itno and
				cls = '10' and srce <> '03' )
using sqlca;

uo_status.st_message.text = "정상적으로 처리되었습니다."

return 0
end event

type pb_down2 from picturebutton within w_wip053u
integer x = 3881
integer y = 616
integer width = 279
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_1.rowcount() < 1 then
	return 0
end if

f_save_to_excel(dw_1)
end event

type st_9 from statictext within w_wip053u
integer x = 3145
integer y = 544
integer width = 617
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "취합수량다운로드"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_10 from statictext within w_wip053u
integer x = 3749
integer y = 544
integer width = 517
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "화면다운로드"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_check from commandbutton within w_wip053u
integer x = 4302
integer y = 516
integer width = 293
integer height = 216
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "KD조회"
end type

event clicked;dec{0} ld_yyyymm
string ls_year, ls_month, ls_plant, ls_dvsn

ld_yyyymm     = uo_1.uf_yyyymm()
is_adjdt        = string(ld_yyyymm)
ls_year 	= mid(is_adjdt,1,4)
ls_month = mid(is_adjdt,5,2)
ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_2.getitemstring(1, "wip001_wadvsn")

openwithparm(w_wip053u_02, ls_year + ls_month + ls_plant + ls_dvsn)
end event

type gb_1 from groupbox within w_wip053u
integer x = 27
integer width = 4265
integer height = 192
integer taborder = 10
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_wip053u
integer x = 27
integer y = 216
integer width = 4265
integer height = 248
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[실사대장 및 조사표 출력용]"
end type

type gb_3 from groupbox within w_wip053u
integer x = 23
integer y = 488
integer width = 4270
integer height = 240
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[실사수량 취합용]"
end type

