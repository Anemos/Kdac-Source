$PBExportHeader$w_mpm321u.srw
$PBExportComments$재작업실적관리
forward
global type w_mpm321u from w_ipis_sheet01
end type
type dw_mpm321u_02 from u_vi_std_datawindow within w_mpm321u
end type
type dw_mpm321u_01 from u_vi_std_datawindow within w_mpm321u
end type
type st_1 from statictext within w_mpm321u
end type
type st_2 from statictext within w_mpm321u
end type
type st_3 from statictext within w_mpm321u
end type
type uo_1 from u_mpms_select_orderno within w_mpm321u
end type
type dw_mpm321u_03 from datawindow within w_mpm321u
end type
type gb_1 from groupbox within w_mpm321u
end type
end forward

global type w_mpm321u from w_ipis_sheet01
dw_mpm321u_02 dw_mpm321u_02
dw_mpm321u_01 dw_mpm321u_01
st_1 st_1
st_2 st_2
st_3 st_3
uo_1 uo_1
dw_mpm321u_03 dw_mpm321u_03
gb_1 gb_1
end type
global w_mpm321u w_mpm321u

forward prototypes
public function string wf_get_srno ()
public function integer wf_save_chk ()
public function integer wf_delete_chk (integer ag_selrow)
end prototypes

public function string wf_get_srno ();String ls_custcd

DECLARE up_get_custcode PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'SER'  
	 using sqlmpms;

Execute up_get_custcode;

if sqlmpms.sqlcode = 0 then
	fetch up_get_custcode into :ls_custcd;
	close up_get_custcode;
end if

return ls_custcd
end function

public function integer wf_save_chk ();//----------------
// 해당공정별로 불량실적은 한번만 입력할 수 있습니다.
// 정상이면 return 0, 아니면 return -1
//----------------
integer li_cnt, li_rowcnt, li_chk
string  ls_resultflag

li_rowcnt = dw_mpm321u_03.rowcount()

li_chk = 0
for li_cnt = 1 to li_rowcnt
	ls_resultflag = dw_mpm321u_03.getitemstring( li_cnt, 'resultflag')
	if ls_resultflag = 'E' then
		li_chk = li_chk + 1
	end if
next

if li_chk > 1 then
	MessageBox("알림", "불량원인공정은 공정별로 한번만 가능합니다.")
	return -1
else
	return 0
end if
end function

public function integer wf_delete_chk (integer ag_selrow);//-------------------
// 불량작업실적인 경우에 불량보고서가 작성된 경우에는 삭제할 수 없다.
// 작성되어 있으면 return -1, 없으면 return 0
//-------------------
string ls_resultflag, ls_badstype, ls_badsrno
integer li_count

ls_badstype = dw_mpm321u_03.getitemstring(ag_selrow,'badstype')
ls_badsrno  = dw_mpm321u_03.getitemstring(ag_selrow,'badsrno')
ls_resultflag = dw_mpm321u_03.getitemstring(ag_selrow,'resultflag')

if ls_resultflag = 'E' then
	SELECT COUNT(*) INTO :li_count FROM TBADHEAD
	WHERE STYPE = :ls_badstype AND SRNO = :ls_badsrno 
	using sqlmpms;
	if sqlmpms.sqlcode <> 0 or li_count > 0 then
		MessageBox("확인", "불량발생내역이 존재하는 작업실적입니다.")
		return -1
	else
		return 0
	end if
end if
	return 0
return 0
end function

on w_mpm321u.create
int iCurrent
call super::create
this.dw_mpm321u_02=create dw_mpm321u_02
this.dw_mpm321u_01=create dw_mpm321u_01
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.uo_1=create uo_1
this.dw_mpm321u_03=create dw_mpm321u_03
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm321u_02
this.Control[iCurrent+2]=this.dw_mpm321u_01
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_mpm321u_03
this.Control[iCurrent+8]=this.gb_1
end on

on w_mpm321u.destroy
call super::destroy
destroy(this.dw_mpm321u_02)
destroy(this.dw_mpm321u_01)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_1)
destroy(this.dw_mpm321u_03)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm321u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm321u_01.Height= ( newheight / 3 ) - ls_status

dw_mpm321u_02.x = dw_mpm321u_01.x
dw_mpm321u_02.y = dw_mpm321u_01.y + dw_mpm321u_01.Height + 120
dw_mpm321u_02.Width =  (dw_mpm321u_01.Width / 5 + ls_status) - ls_gap
dw_mpm321u_02.Height = newheight - (dw_mpm321u_02.y + ls_status)

st_2.x = dw_mpm321u_02.x
st_2.y = dw_mpm321u_02.y - 90

dw_mpm321u_03.x = dw_mpm321u_01.x + dw_mpm321u_02.Width + ls_gap
dw_mpm321u_03.y = dw_mpm321u_02.y
dw_mpm321u_03.Width = (dw_mpm321u_01.Width * 4 / 5) - ( ls_gap + ls_status )
dw_mpm321u_03.Height = dw_mpm321u_02.Height

st_3.x = dw_mpm321u_03.x
st_3.y = st_2.y

end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm321u_01.settransobject(sqlmpms)
dw_mpm321u_02.settransobject(sqlmpms)
dw_mpm321u_03.settransobject(sqlmpms)

dw_mpm321u_03.GetChild('resultflag', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM008')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm321u_03,'resultflag',ldwc,'codename',5)
end event

event ue_retrieve;call super::ue_retrieve;string ls_status, ls_orderno, ls_enddate

ls_orderno = uo_1.is_uo_orderno
ls_status = f_mpms_get_orderstatus(ls_orderno)

if ls_status = 'C' then
	SELECT CONVERT(CHAR(6),ENDDATE,112) INTO :ls_enddate
	FROM TORDER
	WHERE ORDERNO = :ls_orderno
	using sqlmpms;
	
	if mid(g_s_date,1,6) <> ls_enddate then
		uo_status.st_message.text = "마감확정된 Order No 입니다."
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true,  false,  false,  false,  i_b_print, & 
					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
	end if
end if

dw_mpm321u_01.reset()
dw_mpm321u_02.reset()
dw_mpm321u_03.reset()

dw_mpm321u_01.retrieve(uo_1.is_uo_orderno)
end event

event ue_insert;call super::ue_insert;integer li_selrow, li_currow
string ls_orderno, ls_partno, ls_operno, ls_badoperno, ls_baddate, ls_wccode
string ls_badstype, ls_badsrno

li_selrow = dw_mpm321u_02.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '공정순서를 선택해 주십시요'
	return 0
end if
ls_orderno = dw_mpm321u_02.getitemstring(li_selrow,'orderno')
ls_partno = dw_mpm321u_02.getitemstring(li_selrow,'partno')
ls_operno = dw_mpm321u_02.getitemstring(li_selrow,'reoperno')
ls_badoperno = dw_mpm321u_02.getitemstring(li_selrow,'badoperno')
ls_baddate = dw_mpm321u_02.getitemstring(li_selrow,'baddate')
ls_badstype = dw_mpm321u_02.getitemstring(li_selrow,'stype')
ls_badsrno = dw_mpm321u_02.getitemstring(li_selrow,'srno')
ls_wccode = dw_mpm321u_02.getitemstring(li_selrow,'wccode')

li_currow = dw_mpm321u_03.insertrow(0)
dw_mpm321u_03.setitem(li_currow,'stype','WR')
dw_mpm321u_03.setitem(li_currow,'srno',wf_get_srno())
dw_mpm321u_03.setitem(li_currow,'orderno',ls_orderno)
dw_mpm321u_03.setitem(li_currow,'partno',ls_partno)
dw_mpm321u_03.setitem(li_currow,'operno',ls_operno)
dw_mpm321u_03.setitem(li_currow,'wccode',ls_wccode)
dw_mpm321u_03.setitem(li_currow,'badstype',ls_badstype)
dw_mpm321u_03.setitem(li_currow,'badsrno',ls_badsrno)
dw_mpm321u_03.setitem(li_currow,'lastemp',g_s_empno)
dw_mpm321u_03.setitem(li_currow,'workdate', g_s_date)
dw_mpm321u_03.setitem(li_currow,'chk', 0)
end event

event ue_save;call super::ue_save;integer li_selrow, li_cnt, li_rowcnt, li_rtncnt
dec{0} lc_finalqty, lc_reworkqty
string ls_operno, ls_message, ls_stype, ls_srno
str_mpms_parm lstr_1

dw_mpm321u_03.Accepttext()
li_selrow = dw_mpm321u_02.getselectedrow(0)
li_rowcnt = dw_mpm321u_03.rowcount()

if li_selrow < 1 then
	uo_status.st_message.text = "선택된 재작업공정리스트가 없습니다."
	return 0
end if

if dw_mpm321u_03.modifiedcount() < 1 and dw_mpm321u_03.deletedcount() < 1 then
	uo_status.st_message.text = '변경된 데이타가 없습니다.'
	return 0
end if

if f_mpms_mandantory_chk(dw_mpm321u_03) = -1 then
	uo_status.st_message.text = '누락된 데이타가 있습니다.'
	return 0
end if

if wf_save_chk() = -1 then
	return 0
end if
lc_finalqty = 0
lc_reworkqty = dw_mpm321u_02.getitemnumber(li_selrow,'reworkqty')
for li_cnt = 1 to li_rowcnt
	if dw_mpm321u_03.getitemstring(li_cnt,'resultflag') = 'E' then
		ls_stype = dw_mpm321u_03.getitemstring(li_cnt,'stype')
		ls_srno  = dw_mpm321u_03.getitemstring(li_cnt,'srno')
		SELECT COUNT(*) INTO :li_rtncnt
			FROM TBADHEAD
			WHERE STYPE = :ls_stype AND SRNO = :ls_srno
		using sqlmpms;
		if li_rtncnt < 1 then
			ls_message = 'B'
			lstr_1.s_parm[3] = dw_mpm321u_03.getitemstring(li_cnt,'orderno')
			lstr_1.s_parm[4] = dw_mpm321u_03.getitemstring(li_cnt,'partno')
			lstr_1.s_parm[5] = dw_mpm321u_03.getitemstring(li_cnt,'operno')
			lstr_1.s_parm[6] = dw_mpm321u_03.getitemstring(li_cnt,'workdate')
			lstr_1.s_parm[7] = ls_stype
			lstr_1.s_parm[8] = ls_srno
			lstr_1.i_parm[1] = dw_mpm321u_03.getitemnumber(li_cnt,'scrapqty')
		end if
	end if
	lc_finalqty = lc_finalqty + dw_mpm321u_03.getitemnumber(li_cnt,'finalqty')
next

if lc_reworkqty < lc_finalqty then
	Messagebox("알림","합격수량은 재작업수량과 같거나 적어야 합니다.")
	return 0
end if

ls_operno = dw_mpm321u_02.getitemstring(li_selrow,'reoperno')
sqlmpms.Autocommit = False

if dw_mpm321u_03.update() = 1 then
	Commit using sqlmpms;
	sqlmpms.Autocommit = True
	
	li_selrow = dw_mpm321u_02.find("reoperno = '" + ls_operno + "'", 1, dw_mpm321u_02.rowcount())
	if li_selrow > 0 then
		dw_mpm321u_02.Post Event RowFocusChanged(li_selrow)
		dw_mpm321u_02.scrolltorow(li_selrow)
		dw_mpm321u_02.setrow(li_selrow)
	end if
	
	uo_status.st_message.text = '정상적으로 처리되었습니다.'

	if ls_message = 'B' then
		window lw_win
		
		lstr_1.s_parm[1] = '5'
		lstr_1.s_parm[2] = '[금형공정관리]-[불량실적등록]'
		OpenSheetwithparm(lw_win,lstr_1,'w_mpm320u',iw_this,0,Layered!)
	end if
else
	Rollback using sqlmpms;
	sqlmpms.Autocommit = True
	uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'
end if

return 0
end event

event ue_delete;call super::ue_delete;integer li_selrow, li_rtn
string ls_orderno, ls_partno, ls_operno, ls_workemp, ls_mchno, ls_workdate
string ls_stype, ls_srno

li_selrow = dw_mpm321u_02.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

li_selrow = dw_mpm321u_03.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

if wf_delete_chk(li_selrow) = -1 then
	return 0
end if

dw_mpm321u_03.DeleteRow(li_selrow)

//ls_orderno = dw_mpm321u_03.getitemstring(li_selrow,'orderno')
//ls_partno  = dw_mpm321u_03.getitemstring(li_selrow,'partno')
//ls_operno  = dw_mpm321u_03.getitemstring(li_selrow,'operno')
//ls_workemp  = dw_mpm321u_03.getitemstring(li_selrow,'workemp')
//ls_mchno  = dw_mpm321u_03.getitemstring(li_selrow,'mchno')
//ls_workdate  = dw_mpm321u_03.getitemstring(li_selrow,'workdate')
//ls_stype = dw_mpm321u_03.getitemstring(li_selrow,'stype')
//ls_srno  = dw_mpm321u_03.getitemstring(li_selrow,'srno')
//
//li_rtn = MessageBox("확인", ls_operno + " 재작업공정의 " + ls_workemp + " : " &
//		+ string(ls_workdate,'@@@@.@@.@@') + " 일자의 작업실적을 삭제하시겠습니까?" &
//		, Exclamation!, OKCancel!, 2)
//if li_rtn = 2 then
//	return 0
//end if
//
//sqlmpms.Autocommit = False
//
//DELETE FROM TWORKJOB
//WHERE STYPE = :ls_stype AND SRNO = :ls_srno 
//		using sqlmpms;
//		
//if sqlmpms.sqlcode = 0 then
//	Commit using sqlmpms;
//	sqlmpms.Autocommit = True
//
//	li_selrow = dw_mpm321u_02.find("reoperno = '" + ls_operno + "'", 1, dw_mpm321u_02.rowcount())
//	if li_selrow > 0 then
//		dw_mpm321u_02.Post Event RowFocusChanged(li_selrow)
//		dw_mpm321u_02.scrolltorow(li_selrow)
//		dw_mpm321u_02.setrow(li_selrow)
//	end if
//	uo_status.st_message.text = '정상적으로 처리되었습니다.'
//else
//	RollBack using sqlmpms;
//	sqlmpms.Autocommit = True
//	uo_status.st_message.text = '삭제시에 에러가 발생하였습니다.'
//end if
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm321u
end type

type dw_mpm321u_02 from u_vi_std_datawindow within w_mpm321u
integer x = 18
integer y = 848
integer width = 1339
integer height = 1016
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm321u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_stype, ls_srno, ls_wccode, ls_reoperno
integer li_rowcnt
datawindowchild ldwc

if currentrow < 1 then
	return -1
end if

dw_mpm321u_03.reset()

This.selectrow( 0, False )
This.selectrow( currentrow, True )

ls_wccode = This.getitemstring(currentrow,'wccode')
dw_mpm321u_03.GetChild('mchno', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve(ls_wccode)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm321u_03,'mchno',ldwc,'mchname',5)

ls_stype = This.getitemstring( currentrow, "stype" )
ls_srno  = This.getitemstring( currentrow, "srno" )
ls_reoperno = This.getitemstring( currentrow, "reoperno" )

dw_mpm321u_03.retrieve( ls_stype, ls_srno, ls_reoperno)
end event

type dw_mpm321u_01 from u_vi_std_datawindow within w_mpm321u
integer x = 18
integer y = 292
integer width = 2875
integer height = 392
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_mpm321u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_stype, ls_srno, ls_orderno, ls_partno, ls_badoperno, ls_baddate
integer li_rowcnt

if currentrow < 1 then
	return -1
end if

dw_mpm321u_02.reset()
dw_mpm321u_03.reset()

This.selectrow( 0, False )
This.selectrow( currentrow, True )

ls_stype = This.getitemstring( currentrow, "stype" )
ls_srno = This.getitemstring( currentrow, "srno" )
ls_orderno = This.getitemstring( currentrow, "orderno" )
ls_partno  = This.getitemstring( currentrow, "partno" )
ls_badoperno = This.getitemstring( currentrow, "badoperno" )
ls_baddate  = This.getitemstring( currentrow, "baddate" )

dw_mpm321u_02.retrieve( ls_stype, ls_srno )
end event

type st_1 from statictext within w_mpm321u
integer x = 18
integer y = 196
integer width = 667
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "불량발생리스트"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpm321u
integer x = 18
integer y = 752
integer width = 667
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "재작업공정리스트"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mpm321u
integer x = 1394
integer y = 752
integer width = 667
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "재작업실적"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type uo_1 from u_mpms_select_orderno within w_mpm321u
integer x = 50
integer y = 44
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;
iw_this.Triggerevent('ue_retrieve')
end event

type dw_mpm321u_03 from datawindow within w_mpm321u
event ue_key pbm_dwnkey
integer x = 1390
integer y = 848
integer width = 1495
integer height = 1016
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm321u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;If key = keyenter! Then
	iw_this.Triggerevent("ue_insert")
End If

return 0
end event

event itemchanged;String 	ls_colName, ls_null, ls_orderno, ls_partno, ls_operno, ls_chkdate, ls_result
dec{0}   lc_qty
integer 	li_count

this.AcceptText ( )
uo_status.st_message.text = ''
SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'resultflag'
		if data = 'E' then
			ls_orderno = This.getitemstring(row,'orderno')
			ls_partno = This.getitemstring(row,'partno')
			ls_operno = This.getitemstring(row,'operno')
			ls_chkdate = This.getitemstring(row,'workdate')
	
			SELECT COUNT(*) INTO :li_count FROM TBADHEAD
			WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
					BADOPERNO = :ls_operno AND BADDATE = :ls_chkdate
			using sqlmpms;
			if li_count > 0 then
				MessageBox("확인", "해당작업일로 불량발생내역이 존재합니다.")
				This.setitem( row, 'workdate', ls_chkdate)
				return 1
			end if
		end if
	Case 'workdate'
		if f_dateedit(data) = space(8) then
			Messagebox("확인","날짜형식이 올바르지 않습니다.")
			This.Setitem( row, 'workdate', '')
			return 1
		end if
		ls_result = f_mpms_get_monthjob(mid(data,1,6))
		if ls_result = 'C' then
			Messagebox("확인","재료비 계산이 확정된 년월입니다.")
			This.Setitem( row, 'workdate', g_s_date)
			return 1
		end if
End Choose
end event

event rowfocuschanged;integer li_chk

if currentrow < 1 then
	return 0
end if
li_chk = This.getitemnumber( currentrow, 'chk' )

if li_chk = 1 then
	this.SelectRow(0,FALSE)
	//this.SelectRow(currentrow,FALSE)
else
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
end if

return 0
end event

type gb_1 from groupbox within w_mpm321u
integer x = 18
integer width = 1271
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

