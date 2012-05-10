$PBExportHeader$w_mpm240i.srw
$PBExportComments$외주가공현황관리
forward
global type w_mpm240i from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm240i
end type
type dw_mpm240i_01 from u_vi_std_datawindow within w_mpm240i
end type
type st_3 from statictext within w_mpm240i
end type
type em_deptcode from editmask within w_mpm240i
end type
type pb_find from picturebutton within w_mpm240i
end type
type dw_report from datawindow within w_mpm240i
end type
type pb_down from picturebutton within w_mpm240i
end type
type dw_down from datawindow within w_mpm240i
end type
type st_2 from statictext within w_mpm240i
end type
type rb_a3 from radiobutton within w_mpm240i
end type
type rb_a4 from radiobutton within w_mpm240i
end type
type cb_connect from commandbutton within w_mpm240i
end type
type gb_1 from groupbox within w_mpm240i
end type
type gb_2 from groupbox within w_mpm240i
end type
end forward

global type w_mpm240i from w_ipis_sheet01
integer width = 4535
uo_1 uo_1
dw_mpm240i_01 dw_mpm240i_01
st_3 st_3
em_deptcode em_deptcode
pb_find pb_find
dw_report dw_report
pb_down pb_down
dw_down dw_down
st_2 st_2
rb_a3 rb_a3
rb_a4 rb_a4
cb_connect cb_connect
gb_1 gb_1
gb_2 gb_2
end type
global w_mpm240i w_mpm240i

on w_mpm240i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_mpm240i_01=create dw_mpm240i_01
this.st_3=create st_3
this.em_deptcode=create em_deptcode
this.pb_find=create pb_find
this.dw_report=create dw_report
this.pb_down=create pb_down
this.dw_down=create dw_down
this.st_2=create st_2
this.rb_a3=create rb_a3
this.rb_a4=create rb_a4
this.cb_connect=create cb_connect
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_mpm240i_01
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.em_deptcode
this.Control[iCurrent+5]=this.pb_find
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.pb_down
this.Control[iCurrent+8]=this.dw_down
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.rb_a3
this.Control[iCurrent+11]=this.rb_a4
this.Control[iCurrent+12]=this.cb_connect
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_mpm240i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_mpm240i_01)
destroy(this.st_3)
destroy(this.em_deptcode)
destroy(this.pb_find)
destroy(this.dw_report)
destroy(this.pb_down)
destroy(this.dw_down)
destroy(this.st_2)
destroy(this.rb_a3)
destroy(this.rb_a4)
destroy(this.cb_connect)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm240i_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm240i_01.Height= newheight - ( dw_mpm240i_01.y + ls_status )

end event

event ue_retrieve;call super::ue_retrieve;string ls_orderno, ls_deptcode, ls_out_orderno, ls_out_partno
long ll_rowcnt, ll_cnt
integer li_error_code
datastore lds_cal_outprocess
str_pism_msg lstr_msg

setpointer(hourglass!)
dw_mpm240i_01.reset()
dw_mpm240i_01.Object.t_sum_stdmatcost.text = string(0,"#,##0")
dw_mpm240i_01.Object.t_sum_stdmchcost.text = string(0,"#,##0")
dw_mpm240i_01.Object.t_sum_outcost.text = string(0,"#,##0")
ls_orderno = uo_1.is_uo_orderno
em_deptcode.getdata(ls_deptcode)

if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if

if f_spacechk(ls_deptcode) = -1 then
	ls_deptcode = '%'
else
	ls_deptcode = ls_deptcode + '%'
end if
//*******************************************
//* 외주가공데이타(입력상태) 재계산 작업수행
//*******************************************
lds_cal_outprocess = create datastore									
lds_cal_outprocess.dataobject = "d_mpm240i_05"
lds_cal_outprocess.settransobject(sqlmpms)

ll_rowcnt = lds_cal_outprocess.retrieve()
if ll_rowcnt > 0 then
	lstr_msg.headtext = "외주가공단가계산"
	lstr_msg.detailtext = "입력상태인 외주가공데이타 => 단가계산 작업중입니다."
	openwithparm(w_pism_working,lstr_msg)
	sqlmpms.Autocommit = False
	for ll_cnt = 1 to ll_rowcnt
		ls_out_orderno = lds_cal_outprocess.getitemstring(ll_cnt,"orderno")
		ls_out_partno = lds_cal_outprocess.getitemstring(ll_cnt,"partno")
		
		DECLARE actual_recording procedure for sp_mpm220u_05
			@ps_orderno  	= :ls_out_orderno,
			@ps_partno 		= :ls_out_partno,
			@ps_empno 		= :g_s_empno,
			@pi_err_code		= :li_error_code	output
		USING	SQLMPMS ;
	
		EXECUTE actual_recording ;
	
		FETCH actual_recording
			INTO :li_error_code ;
		CLOSE	actual_recording ;
	
		if li_error_code <> 0 then
			close(w_pism_working)
			goto RollBack_
		end if
	next
	close(w_pism_working)
	Commit using sqlmpms;
	sqlmpms.Autocommit = True
end if

//*********
//* 정상작업 끝
//*********

ll_rowcnt = dw_mpm240i_01.retrieve( ls_orderno, ls_deptcode)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if

return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

messagebox("알림","외주가공단가계산시에 에러가 발생하였습니다.")

return 0
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm240i_01.settransobject(sqlmpms)

rb_a4.checked = true
dw_report.dataobject = "d_mpm240i_04"
dw_report.settransobject(sqlmpms)

dw_mpm240i_01.GetChild('outstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM010')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm240i_01,'outstatus',ldwc,'codename',5)
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_prtgubun, ls_orderno, ls_deptcode
string  ls_kijun

window 	l_to_open
str_easy l_str_prt
								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
dw_report.reset()

li_rowcnt = dw_mpm240i_01.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

ls_orderno = uo_1.is_uo_orderno
em_deptcode.getdata(ls_deptcode)
if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if

if f_spacechk(ls_deptcode) = -1 then
	ls_deptcode = '%'
else
	ls_deptcode = ls_deptcode + '%'
end if

dw_report.retrieve( ls_orderno, ls_deptcode )

//choose case ls_outstatus
//	case 'A'
//		ls_prtgubun = '입력'
//	case 'B'
//		ls_prtgubun = '확정'
//	case 'C'
//		ls_prtgubun = '발주'
//	case 'D'
//		ls_prtgubun = '입고'
//	case '%'
//		ls_prtgubun = '전체'
//end choose
l_str_prt.title = "Order별 외주가공정보"

mod_string =  "prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlmpms
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

event ue_save;call super::ue_save;//string ls_orderno, ls_partno, ls_outserial, ls_message, ls_outstatus
//long ll_cnt, ll_rowcnt
//
//dw_mpm240i_01.accepttext()
//
//if dw_mpm240i_01.modifiedcount() < 1 then
//	uo_status.st_message.text = "수정된 데이타가 없습니다."
//	return 0
//end if
//
//ll_rowcnt = dw_mpm240i_01.rowcount()
//
//sqlmpms.Autocommit = False
//for ll_cnt = 1 to ll_rowcnt	
//	ls_orderno = dw_mpm240i_01.getitemstring(ll_cnt,"orderno")
//	ls_partno = dw_mpm240i_01.getitemstring(ll_cnt,"partno")
//	ls_outserial = dw_mpm240i_01.getitemstring(ll_cnt,"outserial")
//	ls_outstatus = dw_mpm240i_01.getitemstring(ll_cnt,"outstatus")
//	Choose case ls_outstatus
//		case 'A'
//			UPDATE TROUTING
//			SET WorkStatus = 'N'
//			FROM TROUTING aa INNER JOIN TOUTPROCESSDETAIL bb
//				ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo AND
//					aa.OperNo = bb.OperNo
//				INNER JOIN TOUTPROCESS cc
//				ON bb.OrderNo = cc.OrderNo AND bb.PartNo = cc.PartNo AND
//					bb.OutSerial = cc.OutSerial
//			WHERE cc.OrderNo = :ls_orderno AND cc.PartNo = :ls_partno AND
//				cc.OutSerial = :ls_outserial
//			using sqlmpms;
//			
//			if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
//				ls_message = "ERR01"
//				goto RollBack_
//			end if
//		case 'B','C','D'
//			UPDATE TROUTING
//			SET WorkStatus = 'C'
//			FROM TROUTING aa INNER JOIN TOUTPROCESSDETAIL bb
//				ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo AND
//					aa.OperNo = bb.OperNo
//				INNER JOIN TOUTPROCESS cc
//				ON bb.OrderNo = cc.OrderNo AND bb.PartNo = cc.PartNo AND
//					bb.OutSerial = cc.OutSerial
//			WHERE cc.OrderNo = :ls_orderno AND cc.PartNo = :ls_partno AND
//				cc.OutSerial = :ls_outserial
//			using sqlmpms;
//			
//			if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
//				ls_message = "ERR01"
//				goto RollBack_
//			end if
//	End Choose
//next
//
//if dw_mpm240i_01.update() <> 1 then
//	ls_message = "ERR02"
//	goto RollBack_
//end if
//
//Commit using sqlmpms;
//sqlmpms.Autocommit = True
//uo_status.st_message.text = "정상적으로 저장되었습니다."
//return 0
//
//RollBack_:
//Rollback using sqlmpms;
//sqlmpms.AutoCommit = True
//
//choose case ls_message
//	case 'ERR01'
//		uo_status.st_message.text = "공정상태변경시에 에러가 발생하였습니다."
//	case 'ERR02'
//		uo_status.st_message.text = "외주공정상태변경시에 에러가 발생하였습니다."
//end choose
//
//return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm240i
end type

type uo_1 from u_mpms_select_orderno within w_mpm240i
integer x = 59
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event constructor;call super::constructor;is_option = '5'
end event

event ue_select;call super::ue_select;dw_mpm240i_01.reset()
end event

type dw_mpm240i_01 from u_vi_std_datawindow within w_mpm240i
integer x = 18
integer y = 208
integer width = 3461
integer height = 1676
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm240i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;string ls_colname, ls_outcheck, ls_orderno, ls_partno, ls_outserial, ls_chkstatus
string ls_summatcost
long ll_cnt, ll_rowcnt
dec{0} lc_stdmatcost, lc_stdmchcost, lc_outcost

ls_colname = dwo.name

if ls_colname = "outcheck" then
	ls_orderno = this.getitemstring(row,"orderno")
	ls_partno = this.getitemstring(row,"partno")
	ls_outserial = this.getitemstring(row,"outserial")
	
	SELECT OutStatus INTO :ls_chkstatus
	FROM TOUTPROCESS
	WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
		OutSerial = :ls_outserial 
	using sqlmpms;
	
	if data = 'Y' then
		if ls_chkstatus = 'A' then
			This.setitem(row, "outstatus", 'B')
		end if
	else
		if ls_chkstatus = 'A' then
			This.setitem(row, "outstatus", 'A')
		end if
	end if

	lc_stdmatcost = DEC(This.Object.t_sum_stdmatcost.text)
	lc_stdmchcost = DEC(This.Object.t_sum_stdmchcost.text)
	lc_outcost = DEC(This.Object.t_sum_outcost.text)
	
	if data = 'Y' then
		lc_stdmatcost = lc_stdmatcost + This.getitemdecimal(row,"stdmatcost")
		lc_stdmchcost = lc_stdmchcost + This.getitemdecimal(row,"stdmchcost")
		lc_outcost = lc_outcost + This.getitemdecimal(row,"outcost")
	else
		lc_stdmatcost = lc_stdmatcost - This.getitemdecimal(row,"stdmatcost")
		lc_stdmchcost = lc_stdmchcost - This.getitemdecimal(row,"stdmchcost")
		lc_outcost = lc_outcost - This.getitemdecimal(row,"outcost")
	end if
	This.Object.t_sum_stdmatcost.text = string(lc_stdmatcost,"#,##0")
	This.Object.t_sum_stdmchcost.text = string(lc_stdmchcost,"#,##0")
	This.Object.t_sum_outcost.text = string(lc_outcost,"#,##0")
end if

return 0
end event

event buttonclicked;call super::buttonclicked;string ls_colname, ls_outcheck, ls_orderno, ls_partno, ls_outserial, ls_chkstatus
long ll_cnt, ll_rowcnt
dec{0} lc_stdmatcost, lc_stdmchcost, lc_outcost

ls_colname = dwo.name
ll_rowcnt = This.rowcount()
lc_stdmatcost = 0
lc_stdmchcost = 0
lc_outcost = 0
if ls_colname = "b_con" then
	for ll_cnt = 1 to ll_rowcnt
		ls_orderno = this.getitemstring(ll_cnt,"orderno")
		ls_partno = this.getitemstring(ll_cnt,"partno")
		ls_outserial = this.getitemstring(ll_cnt,"outserial")
		lc_stdmatcost = lc_stdmatcost + This.getitemdecimal(ll_cnt,"stdmatcost")
		lc_stdmchcost = lc_stdmchcost + This.getitemdecimal(ll_cnt,"stdmchcost")
		lc_outcost = lc_outcost + This.getitemdecimal(ll_cnt,"outcost")
		This.setitem(ll_cnt, "outcheck", 'Y')
		
		SELECT OutStatus INTO :ls_chkstatus
		FROM TOUTPROCESS
		WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
			OutSerial = :ls_outserial 
		using sqlmpms;
		
		if ls_chkstatus = 'A' then
			This.setitem(ll_cnt, "outstatus", 'B')
		end if
	next
	This.Object.t_sum_stdmatcost.text = string(lc_stdmatcost,"#,##0")
	This.Object.t_sum_stdmchcost.text = string(lc_stdmchcost,"#,##0")
	This.Object.t_sum_outcost.text = string(lc_outcost,"#,##0")
end if

return 0
end event

type st_3 from statictext within w_mpm240i
integer x = 1239
integer y = 80
integer width = 302
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
string text = "부서코드:"
boolean focusrectangle = false
end type

type em_deptcode from editmask within w_mpm240i
integer x = 1536
integer y = 72
integer width = 334
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXX"
end type

type pb_find from picturebutton within w_mpm240i
integer x = 1888
integer y = 64
integer width = 238
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_rtn

openwithparm(w_mpms_find_dept, ' ')
ls_rtn = message.stringparm
		
em_deptcode.text = ls_rtn

return 0
end event

type dw_report from datawindow within w_mpm240i
boolean visible = false
integer x = 3520
integer y = 340
integer width = 407
integer height = 400
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_mpm240i_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_mpm240i
integer x = 3886
integer y = 52
integer width = 178
integer height = 120
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_mpm240i_01.rowcount() < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
	return 0
end if

dw_mpm240i_01.sharedata(dw_down)
f_save_to_excel_execute(dw_down,"1")
end event

type dw_down from datawindow within w_mpm240i
boolean visible = false
integer x = 3520
integer y = 788
integer width = 407
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm240i_01_down"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mpm240i
integer x = 3081
integer y = 88
integer width = 329
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
string text = "출력양식:"
boolean focusrectangle = false
end type

type rb_a3 from radiobutton within w_mpm240i
integer x = 3424
integer y = 84
integer width = 192
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
string text = "A3"
end type

event clicked;dw_report.dataobject = "d_mpm240i_03"
dw_report.settransobject(sqlmpms)
end event

type rb_a4 from radiobutton within w_mpm240i
integer x = 3630
integer y = 84
integer width = 201
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
string text = "A4"
end type

event clicked;dw_report.dataobject = "d_mpm240i_04"
dw_report.settransobject(sqlmpms)
end event

type cb_connect from commandbutton within w_mpm240i
integer x = 2249
integer y = 68
integer width = 727
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "발주품번 연결작업"
end type

event clicked;//********************************* 
// 1. OrderNo 별로 작업을 수행한다.
// 2. 발주품번과 연계된 외주가공데이타는 발주상태로 처리한다.
// 3. 연계된 외주가공데이타를 삭제하면 확정상태로 처리한다.
// 4. 확정상태 즉 선택된 데이타는 발주품번 연결작업의 대상이 된다.
// 5. w_mpm240i_01 popup window를 open한다. 인수 : orderno
//*********************************
string ls_orderno, ls_rtn
integer li_count, li_cnt, li_rowcnt

uo_status.st_message.text = ""
ls_orderno = uo_1.is_uo_orderno

li_rowcnt = dw_mpm240i_01.rowcount()
if f_spacechk(ls_orderno) = -1 or li_rowcnt = 0 then
	uo_status.st_message.text = "금형의뢰번호를 선택하십시요"
	return -1
end if

li_count = 0
for li_cnt = 1 to li_rowcnt
	if dw_mpm240i_01.getitemstring(li_cnt,"outcheck") = 'Y' then
		li_count = li_count + 1
	else
		li_count = li_count + 0
	end if
next

if li_count < 1 then
	uo_status.st_message.text = "선택된 외주가공 데이타가 없습니다."
	return 0
end if

openwithparm(w_mpm240i_01, dw_mpm240i_01)
ls_rtn = Message.StringParm
if ls_rtn = "SAVE" then
	iw_this.Triggerevent('ue_retrieve')
end if

return 0
end event

type gb_1 from groupbox within w_mpm240i
integer x = 18
integer width = 2990
integer height = 196
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mpm240i
integer x = 3031
integer width = 1065
integer height = 196
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

