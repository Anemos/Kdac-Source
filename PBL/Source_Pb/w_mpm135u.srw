$PBExportHeader$w_mpm135u.srw
$PBExportComments$금형이력카드
forward
global type w_mpm135u from w_ipis_sheet01
end type
type dw_mpm135u_02 from datawindow within w_mpm135u
end type
type dw_mpm135u_01 from u_vi_std_datawindow within w_mpm135u
end type
type dw_mpm135u_03 from datawindow within w_mpm135u
end type
type dw_mpm135u_04 from datawindow within w_mpm135u
end type
type st_1 from statictext within w_mpm135u
end type
type st_2 from statictext within w_mpm135u
end type
type st_3 from statictext within w_mpm135u
end type
type cb_addmemo from commandbutton within w_mpm135u
end type
type cb_delmemo from commandbutton within w_mpm135u
end type
type cb_addevent from commandbutton within w_mpm135u
end type
type cb_delevent from commandbutton within w_mpm135u
end type
type dw_report from datawindow within w_mpm135u
end type
end forward

global type w_mpm135u from w_ipis_sheet01
dw_mpm135u_02 dw_mpm135u_02
dw_mpm135u_01 dw_mpm135u_01
dw_mpm135u_03 dw_mpm135u_03
dw_mpm135u_04 dw_mpm135u_04
st_1 st_1
st_2 st_2
st_3 st_3
cb_addmemo cb_addmemo
cb_delmemo cb_delmemo
cb_addevent cb_addevent
cb_delevent cb_delevent
dw_report dw_report
end type
global w_mpm135u w_mpm135u

forward prototypes
public subroutine wf_imagechange (string ag_orderno)
end prototypes

public subroutine wf_imagechange (string ag_orderno);
blob lb_gyoid_pic, lb_pic 
Int  li_FileNo, li_FileNum, l_n_chk_loops, l_n_mod, l_n_int
long ll_pic = 1, ll_length, ll_sumlen

// 도면을 기본으로 안보이게 한다
//
dw_mpm135u_02.object.p_dieimage.Visible = TRUE

SELECTBLOB dieimage
INTO :lb_gyoid_pic 
FROM TSETCARD
WHERE orderno 		= :ag_orderno
using sqlmpms;

IF sqlmpms.sqlcode <> 0 THEN
	RETURN 	
END IF

ll_length = Len(lb_gyoid_pic)

IF ll_length = 0 OR IsNull(ll_length) THEN
	RETURN 	
END IF

// 정상적인 도면일때만 보이게한다
//
dw_mpm135u_02.object.p_dieimage.Visible = TRUE

ll_pic =1
//임시파일을 열어서 작업을 준비
//
//li_FileNo = FileOpen("C:\kdac_ipis\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)
li_FileNo = FileOpen("C:\kdac\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)

l_n_chk_loops = ll_length / 32765
l_n_mod   = mod(ll_length, 32765)
if l_n_chk_loops > 0 then
	for l_n_int = 1 to l_n_chk_loops
		lb_pic = blobmid( lb_gyoid_pic, ((l_n_int - 1) * 32765) + 1, 32765)
		filewrite(li_fileno, lb_pic) 
	next
	if l_n_mod > 0 then
		lb_pic = blobmid( lb_gyoid_pic, l_n_chk_loops * 32765 + 1, l_n_mod)
		filewrite(li_fileno, lb_pic) 
	end if
else
	if l_n_mod > 0 then
		lb_pic = blobmid(lb_gyoid_pic, 1, l_n_mod)
		filewrite(li_fileno, lb_pic)
	end if
end if

//IF li_FileNo > 0 Then 
//	DO   
//	  	lb_pic=blobmid(lb_gyoid_pic, ll_pic, 32765)
//	  	If f_spacechk( String(lb_pic) ) = -1 then
//			Exit
//		End If
//	  	FileWrite(li_FileNo, lb_pic) 
//	  	ll_pic = ll_pic + 32765 
//	LOOP UNTIL long(lb_pic) = 0 
//End IF

li_fileno = FileClose(li_FileNo)
return

end subroutine

on w_mpm135u.create
int iCurrent
call super::create
this.dw_mpm135u_02=create dw_mpm135u_02
this.dw_mpm135u_01=create dw_mpm135u_01
this.dw_mpm135u_03=create dw_mpm135u_03
this.dw_mpm135u_04=create dw_mpm135u_04
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_addmemo=create cb_addmemo
this.cb_delmemo=create cb_delmemo
this.cb_addevent=create cb_addevent
this.cb_delevent=create cb_delevent
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm135u_02
this.Control[iCurrent+2]=this.dw_mpm135u_01
this.Control[iCurrent+3]=this.dw_mpm135u_03
this.Control[iCurrent+4]=this.dw_mpm135u_04
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_addmemo
this.Control[iCurrent+9]=this.cb_delmemo
this.Control[iCurrent+10]=this.cb_addevent
this.Control[iCurrent+11]=this.cb_delevent
this.Control[iCurrent+12]=this.dw_report
end on

on w_mpm135u.destroy
call super::destroy
destroy(this.dw_mpm135u_02)
destroy(this.dw_mpm135u_01)
destroy(this.dw_mpm135u_03)
destroy(this.dw_mpm135u_04)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_addmemo)
destroy(this.cb_delmemo)
destroy(this.cb_addevent)
destroy(this.cb_delevent)
destroy(this.dw_report)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm135u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm135u_01.Height= ( newheight * 3 / 10 ) - ls_split

dw_mpm135u_02.x = dw_mpm135u_01.x
dw_mpm135u_02.y = dw_mpm135u_01.y + dw_mpm135u_01.Height + ls_status
dw_mpm135u_02.Width = (newwidth * 5 / 7)	- (ls_gap * 4)
dw_mpm135u_02.Height= (newheight * 5 / 10) - (ls_status * 2)

st_1.x = dw_mpm135u_02.x
st_1.y = dw_mpm135u_02.y - 80

dw_mpm135u_04.y = dw_mpm135u_02.y + dw_mpm135u_02.Height + ls_status
dw_mpm135u_04.Width = dw_mpm135u_02.Width
dw_mpm135u_04.Height= (newheight * 2 / 10) - 60

st_3.x = dw_mpm135u_04.x
st_3.y = dw_mpm135u_04.y - 80
cb_addmemo.x = st_3.x + st_3.width + 50
cb_addmemo.y = dw_mpm135u_04.y - 90
cb_delmemo.x = cb_addmemo.x + cb_addmemo.width + 30
cb_delmemo.y = cb_addmemo.y

dw_mpm135u_03.x = (ls_gap * 4) + dw_mpm135u_02.Width
dw_mpm135u_03.y = dw_mpm135u_02.y
dw_mpm135u_03.Width = (newwidth * 2 / 7) - ( ls_gap * 2 )
dw_mpm135u_03.Height= dw_mpm135u_04.Height + dw_mpm135u_02.Height + ls_status

st_2.x = dw_mpm135u_03.x
st_2.y = st_1.y
cb_addevent.x = st_2.x + st_2.width + 50
cb_addevent.y = dw_mpm135u_02.y - 90
cb_delevent.x = cb_addevent.x + cb_addevent.width + 30
cb_delevent.y = cb_addevent.y
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm135u_01.settransobject(sqlmpms)
dw_mpm135u_02.settransobject(sqlmpms)
dw_mpm135u_03.settransobject(sqlmpms)
dw_mpm135u_04.settransobject(sqlmpms)
dw_report.settransobject(sqlmpms)

dw_mpm135u_02.GetChild('orderno', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('4')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm135u_02,'orderno',ldwc,'toolname',10)

This.Triggerevent("ue_retrieve")
end event

event ue_insert;call super::ue_insert;dw_mpm135u_02.reset()
dw_mpm135u_03.reset()
dw_mpm135u_04.reset()
dw_mpm135u_02.insertrow(0)

end event

event ue_save;call super::ue_save;string ls_message, ls_orderno
integer li_selrow

dw_mpm135u_02.accepttext()
dw_mpm135u_03.accepttext()
dw_mpm135u_04.accepttext()

if dw_mpm135u_02.rowcount() <> 1 then
	uo_status.st_message.text = "선택된 OrderNo 가 없습니다."
	return 0
end if
if dw_mpm135u_02.modifiedcount() < 1 and dw_mpm135u_03.modifiedcount() < 1 &
	and dw_mpm135u_04.modifiedcount() < 1 then
	uo_status.st_message.text = "변경된 데이타가 없습니다."
	return 0
end if
ls_orderno = dw_mpm135u_02.getitemstring(1,"orderno")

sqlmpms.AutoCommit = False

if dw_mpm135u_02.modifiedcount() > 0 then
	if dw_mpm135u_02.update() <> 1 then
		ls_message = "SetError"
		goto RollBack_
	end if
end if

if dw_mpm135u_03.modifiedcount() > 0 then
	if dw_mpm135u_03.update() <> 1 then
		ls_message = "SetEventError"
		goto RollBack_
	end if
end if

if dw_mpm135u_04.modifiedcount() > 0 then
	if dw_mpm135u_04.update() <> 1 then
		ls_message = "SetHisError"
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True

This.Triggerevent("ue_retrieve")
li_selrow = dw_mpm135u_01.find("orderno = '" + ls_orderno + "'", 1, dw_mpm135u_01.rowcount())
if li_selrow > 0 then
	dw_mpm135u_01.Post Event RowFocusChanged(li_selrow)
	dw_mpm135u_01.scrolltorow(li_selrow)
	dw_mpm135u_01.setrow(li_selrow)
end if

uo_status.st_message.text = "저장되었습니다."
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'SetError'
		uo_status.st_message.text = "기본정보 저장시에 에러가 발생하였습니다."
	case 'SetEventError'
		uo_status.st_message.text = "특기사항 저장시에 에러가 발생하였습니다."
	case 'SetHisError'
		uo_status.st_message.text = "개선및수리내역 저장시에 에러가 발생하였습니다."
	case else
		uo_status.st_message.text = "저장시에 에러가 발생하였습니다."
end choose

return 0
end event

event ue_delete;call super::ue_delete;string ls_orderno, ls_message
integer li_selrow, li_rtn

li_selrow = dw_mpm135u_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 데이타를 선택하십시요."
	return 0
end if

ls_orderno = dw_mpm135u_01.getitemstring( li_selrow, 'orderno')

li_rtn = MessageBox("경고", ls_orderno + " 금형이력카드를 삭제하시겠습니까?." &
			, Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if

sqlmpms.AutoCommit = False
	
DELETE FROM TSETCARDHIST
WHERE ORDERNO = :ls_orderno
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "SetHis_delete"
	goto RollBack_
end if
	
DELETE FROM TSETCARDEVENT
WHERE ORDERNO = :ls_orderno
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "SetEvent_delete"
	goto RollBack_
end if
	
DELETE FROM TSETCARD
WHERE ORDERNO = :ls_orderno
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "SetCard_delete"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True

This.Triggerevent("ue_retrieve")

uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'SetHis_delete'
		Messagebox("경고", "개선및수리내역 삭제시에 에러가 발생하였습니다.")
	case 'SetEvent_delete'
		Messagebox("경고", "특기사항 삭제시에 에러가 발생하였습니다.")
	case 'SetCard_delete'
		Messagebox("경고", "기본정보 삭제시에 에러가 발생하였습니다.")
end choose

return 0
end event

event ue_retrieve;call super::ue_retrieve;dw_mpm135u_01.reset()
dw_mpm135u_01.retrieve()
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string,ls_rownum,ls_orderno, l_s_command, l_s_tmp
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

li_rowcnt = dw_mpm135u_01.getselectedrow(0)

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

ls_orderno = dw_mpm135u_01.getitemstring(li_rowcnt,"orderno")

dw_report.reset()
dw_report.retrieve( ls_orderno )

////////////////////
//출력 Data -> 출력
////////////////////

//출력전 초기배율
dw_report.setredraw(true)
dw_report.Object.Datawindow.Zoom = "100"

// 용지
l_s_command = " datawindow.Print.Paper.Size = " + "9"

// orientation (1.Landscape(가로)  2.Portrait (세로)
l_s_command = l_s_command + " datawindow.Print.Orientation = " + "1"

// now alter the datawindow
l_s_tmp = dw_report.modify(l_s_command)

if len(l_s_tmp) > 0 then // if error the display the 
	messagebox("확 인", "Error message = " + l_s_tmp + "~r~nCommand = " + l_s_command)
	dw_report.Setredraw(false)
	return 0
end if
dw_report.print()
dw_report.Setredraw(false)

uo_status.st_message.Text = "출력 되었습니다."
return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm135u
end type

type dw_mpm135u_02 from datawindow within w_mpm135u
integer x = 23
integer y = 608
integer width = 1810
integer height = 788
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm135u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_diename, ls_builddate, ls_partname, ls_orderno

ls_colname = dwo.name

choose case ls_colname
	case 'orderno'
		ls_orderno = Trim(data)
		if len(ls_orderno) <> 7 then
			SELECT toolname, productname, convert(varchar(10),enddate,102)
				INTO :ls_diename, :ls_partname, :ls_builddate
			FROM TORDER
			WHERE OrderNo = :ls_orderno AND isnull(IngStatus,'') = 'C' AND 
				AssetFlag = 'A'
			using sqlmpms;
			
			if sqlmpms.sqlcode <> 0 then
				This.setitem(row,"orderno",'')
				uo_status.st_message.text = "미완료, 미세트품에 해당하는 OrderNo입니다."
				return 1
			else
				This.setitem(row,"diename", ls_diename )
				This.setitem(row,"partname", ls_partname )
				This.setitem(row,"builddate", ls_builddate )
				return 0
			end if
		end if
end choose
end event

event buttonclicked;blob{200000} lb_dieimage
blob lb_pic
Int  li_FileNo, li_FileNum, l_n_chk_loops, l_n_mod, l_n_int, li_rtn, li_selrow
long ll_pic = 1, ll_length, ll_sumlen
string ls_filepath, ls_filename, ls_orderno

ls_orderno = This.getitemstring(row,"orderno")

SELECT COUNT(*) INTO :li_rtn
FROM TSETCARD
WHERE OrderNo = :ls_orderno
using sqlmpms;

if li_rtn <> 1 or sqlmpms.sqlcode <> 0 then
	uo_status.st_message.text = "해당 OrderNo로 저장된 금형이력카드가 없습니다."
	return 0
end if

if dwo.name = 'b_upload' then
	li_rtn = GetFileOpenName("업로드 파일 선택", ls_filepath, ls_filename, "JPG", &
									"JPG Files (*.jpg), *.jpg," + "JPEG Files (*.jpeg), *.jpeg,")
	if li_rtn <> 1 then
		return
	end if

	ll_length = FileLength(ls_filepath)
	li_fileno = FileOpen(ls_filepath, StreamMode!, Read!, LockReadWrite!)
	
	IF ll_length <= 0 OR IsNull(ll_length) OR ll_length >= 200000 THEN
		uo_status.st_message.text = "사진의 크기를 확인하시기 바랍니다."
		RETURN 	
	END IF

	l_n_chk_loops = ll_length / 32765
	l_n_mod   = mod(ll_length, 32765)
	if l_n_chk_loops > 0 then
		for l_n_int = 1 to l_n_chk_loops
			li_rtn = FileRead ( li_fileno, lb_pic )
			blobedit(lb_dieimage,((l_n_int - 1) * 32765) + 1, lb_pic)
		next
		if l_n_mod > 0 then
			li_rtn = FileRead ( li_fileno, lb_pic )
			blobedit(lb_dieimage, l_n_chk_loops * 32765 + 1, lb_pic)
		end if
	else
		if l_n_mod > 0 then
			li_rtn = FileRead ( li_fileno, lb_pic )
			blobedit(lb_dieimage, 1, lb_pic)
		end if
	end if

	FileClose ( li_fileno )

	UPDATEBLOB TSETCARD
	SET DieImage = :lb_dieimage
	WHERE OrderNo = :ls_orderno
	using sqlmpms;
	
	if sqlmpms.sqlnrows > 0 then
		li_selrow = dw_mpm135u_01.find("orderno = '" + ls_orderno + "'", 1, dw_mpm135u_01.rowcount())
		if li_selrow > 0 then
			dw_mpm135u_01.Post Event RowFocusChanged(li_selrow)
			dw_mpm135u_01.scrolltorow(li_selrow)
			dw_mpm135u_01.setrow(li_selrow)
		end if
		uo_status.st_message.text = "사진붙이기 작업이 정상적으로 완료되었습니다."
	else
		uo_status.st_message.text = "사진붙이기 작업시에 에러가 발생하였습니다."
	end if
end if
end event

type dw_mpm135u_01 from u_vi_std_datawindow within w_mpm135u
integer x = 23
integer y = 20
integer width = 3200
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm135u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_orderno
integer li_rowcnt

uo_status.st_message.text = ""

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

dw_mpm135u_02.reset()

ls_orderno = dw_mpm135u_01.getitemstring(currentrow,"orderno")
wf_imagechange(ls_orderno)
dw_mpm135u_02.retrieve(ls_orderno)
dw_mpm135u_02.object.p_dieimage.filename = "C:\kdac\bmp\temp.jpg"
dw_mpm135u_03.retrieve(ls_orderno)
dw_mpm135u_04.retrieve(ls_orderno)

end event

type dw_mpm135u_03 from datawindow within w_mpm135u
integer x = 1865
integer y = 632
integer width = 1371
integer height = 1256
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm135u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

type dw_mpm135u_04 from datawindow within w_mpm135u
integer x = 23
integer y = 1512
integer width = 1815
integer height = 376
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm135u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

event itemchanged;string ls_colname

ls_colname = dwo.name

choose case ls_colname
	case 'confirmflag'
		if data = 'Y' then
			This.setitem(row,"confirmempno",g_s_empno)
		end if
end choose
end event

type st_1 from statictext within w_mpm135u
integer x = 37
integer y = 528
integer width = 645
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "금형이력 기본정보"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpm135u
integer x = 1874
integer y = 544
integer width = 571
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "특 기 사 항"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mpm135u
integer x = 37
integer y = 1428
integer width = 571
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "개선및수리내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_addmemo from commandbutton within w_mpm135u
integer x = 667
integer y = 1420
integer width = 329
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
end type

event clicked;long ll_currow
string ls_orderno

if dw_mpm135u_02.rowcount() < 1 then
	return 0
end if
ls_orderno = dw_mpm135u_02.getitemstring(1,"orderno")
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "OrderNo가 없습니다."
	return 0
end if

ll_currow = dw_mpm135u_04.insertrow(0)
dw_mpm135u_04.setitem(ll_currow,"orderno", ls_orderno)
dw_mpm135u_04.scrolltorow(ll_currow)
dw_mpm135u_04.setcolumn("eventdate")
dw_mpm135u_04.setfocus()
end event

type cb_delmemo from commandbutton within w_mpm135u
integer x = 1042
integer y = 1420
integer width = 329
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;integer li_selrow

li_selrow = dw_mpm135u_04.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 데이타를 선택하십시요"
	return 0
end if

dw_mpm135u_04.deleterow(li_selrow)
end event

type cb_addevent from commandbutton within w_mpm135u
integer x = 2491
integer y = 536
integer width = 329
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
end type

event clicked;long ll_currow
string ls_orderno

if dw_mpm135u_02.rowcount() < 1 then
	return 0
end if
ls_orderno = dw_mpm135u_02.getitemstring(1,"orderno")
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "OrderNo가 없습니다."
	return 0
end if
ll_currow = dw_mpm135u_03.insertrow(0)
dw_mpm135u_03.setitem(ll_currow,"orderno", ls_orderno)
dw_mpm135u_03.scrolltorow(ll_currow)
dw_mpm135u_03.setcolumn("eventmemo")
dw_mpm135u_03.setfocus()
end event

type cb_delevent from commandbutton within w_mpm135u
integer x = 2853
integer y = 536
integer width = 329
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;integer li_selrow

li_selrow = dw_mpm135u_03.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 데이타를 선택하십시요"
	return 0
end if

dw_mpm135u_03.deleterow(li_selrow)
end event

type dw_report from datawindow within w_mpm135u
boolean visible = false
integer x = 2834
integer y = 360
integer width = 393
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm135u_05p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

