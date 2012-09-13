$PBExportHeader$w_mpm250u.srw
$PBExportComments$외주가공발주관리
forward
global type w_mpm250u from w_ipis_sheet01
end type
type dw_mpm250u_01 from u_vi_std_datawindow within w_mpm250u
end type
type dw_mpm250u_02 from u_vi_std_datawindow within w_mpm250u
end type
type st_1 from statictext within w_mpm250u
end type
type st_2 from statictext within w_mpm250u
end type
type uo_orderno from u_mpms_select_orderno within w_mpm250u
end type
type st_3 from statictext within w_mpm250u
end type
type rb_a3 from radiobutton within w_mpm250u
end type
type rb_a4 from radiobutton within w_mpm250u
end type
type pb_down from picturebutton within w_mpm250u
end type
type dw_report from datawindow within w_mpm250u
end type
type dw_down from datawindow within w_mpm250u
end type
type gb_1 from groupbox within w_mpm250u
end type
type gb_2 from groupbox within w_mpm250u
end type
end forward

global type w_mpm250u from w_ipis_sheet01
dw_mpm250u_01 dw_mpm250u_01
dw_mpm250u_02 dw_mpm250u_02
st_1 st_1
st_2 st_2
uo_orderno uo_orderno
st_3 st_3
rb_a3 rb_a3
rb_a4 rb_a4
pb_down pb_down
dw_report dw_report
dw_down dw_down
gb_1 gb_1
gb_2 gb_2
end type
global w_mpm250u w_mpm250u

on w_mpm250u.create
int iCurrent
call super::create
this.dw_mpm250u_01=create dw_mpm250u_01
this.dw_mpm250u_02=create dw_mpm250u_02
this.st_1=create st_1
this.st_2=create st_2
this.uo_orderno=create uo_orderno
this.st_3=create st_3
this.rb_a3=create rb_a3
this.rb_a4=create rb_a4
this.pb_down=create pb_down
this.dw_report=create dw_report
this.dw_down=create dw_down
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm250u_01
this.Control[iCurrent+2]=this.dw_mpm250u_02
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_orderno
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.rb_a3
this.Control[iCurrent+8]=this.rb_a4
this.Control[iCurrent+9]=this.pb_down
this.Control[iCurrent+10]=this.dw_report
this.Control[iCurrent+11]=this.dw_down
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_mpm250u.destroy
call super::destroy
destroy(this.dw_mpm250u_01)
destroy(this.dw_mpm250u_02)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.uo_orderno)
destroy(this.st_3)
destroy(this.rb_a3)
destroy(this.rb_a4)
destroy(this.pb_down)
destroy(this.dw_report)
destroy(this.dw_down)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm250u_01.Width = newwidth 	- ( ls_gap * 4 )
dw_mpm250u_01.Height= ( newheight * 2 / 5 ) - dw_mpm250u_01.y

st_2.y = dw_mpm250u_01.y + dw_mpm250u_01.Height + ls_split
dw_mpm250u_02.x = dw_mpm250u_01.x
dw_mpm250u_02.y = st_2.y + st_2.height + ls_split
dw_mpm250u_02.Width = dw_mpm250u_01.Width
dw_mpm250u_02.Height = newheight - ( dw_mpm250u_01.y + dw_mpm250u_01.Height + 180 )


end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm250u_01.settransobject(sqlmpms)
dw_mpm250u_02.settransobject(sqlmpms)
dw_down.settransobject(sqlmpms)

rb_a4.checked = true
dw_report.dataobject = "d_mpm250u_04"
dw_report.settransobject(sqlmpms)

dw_mpm250u_01.GetChild('outstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM010')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm250u_01,'outstatus',ldwc,'codename',5)

dw_mpm250u_02.GetChild('outstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM010')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm250u_02,'outstatus',ldwc,'codename',5)
end event

event ue_retrieve;call super::ue_retrieve;string ls_orderno

dw_mpm250u_01.reset()
dw_mpm250u_02.reset()
ls_orderno = uo_orderno.is_uo_orderno

dw_mpm250u_01.retrieve(ls_orderno)
end event

event ue_delete;call super::ue_delete;integer li_selrow, li_rtn, li_cnt, li_rowcnt
string ls_outstatus, ls_message, ls_serialno, ls_orderno, ls_partno, ls_outserial

li_selrow = dw_mpm250u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 발주내역을 선택해 주십시요"
	return 0
end if

ls_outstatus = dw_mpm250u_01.getitemstring(li_selrow,"outstatus")
if ls_outstatus <> 'B' then
	uo_status.st_message.text = "확정상태인 발주내역만 삭제가 가능합니다."
	return 0
else
	li_rtn = MessageBox("확인", " 발주내역을 삭제하면 발주품번에 대한 외주가공내역을 재구성할 수 있습니다.~r~n" &
		+ " 삭제하시겠습니까?", Exclamation!, OKCancel!, 1)
	if li_rtn = 2 then
		return 0
	end if
end if
ls_serialno = dw_mpm250u_01.getitemstring(li_selrow,"serialno")

sqlmpms.Autocommit = False
// 발주세부사항에서 외주가공데이타에 대한 상태변경
li_rowcnt = dw_mpm250u_02.rowcount()
for li_cnt = 1 to li_rowcnt
	ls_orderno = dw_mpm250u_02.getitemstring(li_cnt,"orderno")
	ls_partno = dw_mpm250u_02.getitemstring(li_cnt,"partno")
	ls_outserial = dw_mpm250u_02.getitemstring(li_cnt,"outserial")
	
	//발주회수 체크 IF > 1 면 확정, 아니면 입력
	SELECT COUNT(*) INTO :li_rtn
	FROM TOUTORDERDETAIL
	WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
		OutSerial = :ls_outserial
	using sqlmpms;
	
	if li_rtn > 1 then
		UPDATE TOUTPROCESS
		SET OutStatus = 'B', OrderEmp = :g_s_empno, OrderDate = :g_s_date
		WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
			OutSerial = :ls_outserial
		using sqlmpms;
		
		if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
			ls_message = "외주가공마스타 상태변경 에러"
			goto RollBack_
		end if
		
		UPDATE TROUTING
			SET WorkStatus = 'C'
		FROM TROUTING aa INNER JOIN TOUTPROCESSDETAIL bb
			ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo AND
				aa.OperNo = bb.OperNo
			INNER JOIN TOUTPROCESS cc
			ON bb.OrderNo = cc.OrderNo AND bb.PartNo = cc.PartNo AND
				bb.OutSerial = cc.OutSerial
		WHERE cc.OrderNo = :ls_orderno AND cc.PartNo = :ls_partno AND
			cc.OutSerial = :ls_outserial
		using sqlmpms;
		
		if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
			ls_message = "공정설계 상태변경 에러"
			goto RollBack_
		end if
	else
		UPDATE TOUTPROCESS
		SET OutStatus = 'A', OrderEmp = :g_s_empno, OrderDate = :g_s_date
		WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
			OutSerial = :ls_outserial
		using sqlmpms;
		
		if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
			ls_message = "외주가공마스타 상태변경 에러"
			goto RollBack_
		end if
		
		UPDATE TROUTING
			SET WorkStatus = 'N'
		FROM TROUTING aa INNER JOIN TOUTPROCESSDETAIL bb
			ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo AND
				aa.OperNo = bb.OperNo
			INNER JOIN TOUTPROCESS cc
			ON bb.OrderNo = cc.OrderNo AND bb.PartNo = cc.PartNo AND
				bb.OutSerial = cc.OutSerial
		WHERE cc.OrderNo = :ls_orderno AND cc.PartNo = :ls_partno AND
			cc.OutSerial = :ls_outserial
		using sqlmpms;
		
		if sqlmpms.sqlcode <> 0 or sqlmpms.sqlnrows < 1 then
			ls_message = "공정설계 상태변경 에러"
			goto RollBack_
		end if
	end if
next
// 발주 세부데이타 생성
DELETE FROM TOUTORDER
WHERE SerialNo = :ls_serialno
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "발주 마스타 삭제시 에러"
	goto RollBack_
end if

// 발주 마스타 데이타 생성
DELETE FROM TOUTORDERDETAIL
WHERE SerialNo = :ls_serialno
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "발주 세부정보 삭제시 에러"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

MessageBox(ls_message,"삭제시에 오류가 발생하였습니다.")

return 0
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= True
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_print;call super::ue_print;integer li_selrow
string  mod_string, ls_serialno, ls_puritno

window 	l_to_open
str_easy l_str_prt
								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
dw_report.reset()

li_selrow = dw_mpm250u_01.getselectedrow(0)

if li_selrow < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

ls_serialno = dw_mpm250u_01.getitemstring( li_selrow, 'serialno')
ls_puritno = dw_mpm250u_01.getitemstring( li_selrow, 'puritno')

dw_report.retrieve(ls_serialno)

l_str_prt.title = "발주 외주가공상세현황"

mod_string =  "puritemno.text = '" + ls_puritno + "'" + &
			"prtdate.text  = '" + string(g_s_date,"@@@@.@@.@@") + "'"

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

type uo_status from w_ipis_sheet01`uo_status within w_mpm250u
end type

type dw_mpm250u_01 from u_vi_std_datawindow within w_mpm250u
integer x = 18
integer y = 288
integer width = 2990
integer height = 540
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm250u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_serialno

dw_mpm250u_02.reset()

If currentrow < 1 Then
	return 0
End If

this.SelectRow(0,False)
this.SelectRow(currentrow, True)

ls_serialno = This.getitemstring( currentrow, 'serialno')

dw_mpm250u_02.retrieve( ls_serialno )
end event

type dw_mpm250u_02 from u_vi_std_datawindow within w_mpm250u
integer x = 18
integer y = 948
integer width = 2962
integer height = 708
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm250u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_1 from statictext within w_mpm250u
integer x = 18
integer y = 196
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
string text = "발주내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpm250u
integer x = 18
integer y = 852
integer width = 681
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
string text = "외주가공 상세현황"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type uo_orderno from u_mpms_select_orderno within w_mpm250u
integer x = 73
integer y = 40
integer taborder = 20
boolean bringtotop = true
end type

event constructor;call super::constructor;is_option = '5'
end event

on uo_orderno.destroy
call u_mpms_select_orderno::destroy
end on

type st_3 from statictext within w_mpm250u
integer x = 1413
integer y = 72
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

type rb_a3 from radiobutton within w_mpm250u
integer x = 1755
integer y = 72
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

event clicked;dw_report.dataobject = "d_mpm250u_03"
dw_report.settransobject(sqlmpms)
end event

type rb_a4 from radiobutton within w_mpm250u
integer x = 1961
integer y = 72
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

event clicked;dw_report.dataobject = "d_mpm250u_04"
dw_report.settransobject(sqlmpms)
end event

type pb_down from picturebutton within w_mpm250u
integer x = 2217
integer y = 36
integer width = 178
integer height = 120
integer taborder = 30
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

event clicked;string ls_serialno
integer li_selrow

dw_down.reset()
li_selrow = dw_mpm250u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
	return 0
end if

ls_serialno = dw_mpm250u_01.getitemstring( li_selrow, 'serialno')
dw_down.retrieve(ls_serialno)
f_save_to_excel_execute(dw_down,"1")
end event

type dw_report from datawindow within w_mpm250u
boolean visible = false
integer x = 2501
integer y = 20
integer width = 530
integer height = 236
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_down from datawindow within w_mpm250u
boolean visible = false
integer x = 3063
integer y = 32
integer width = 421
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm250u_05"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm250u
integer x = 18
integer y = 8
integer width = 1330
integer height = 160
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mpm250u
integer x = 1362
integer y = 8
integer width = 1088
integer height = 160
integer taborder = 30
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

