$PBExportHeader$w_mpm320u.srw
$PBExportComments$작업불량관리
forward
global type w_mpm320u from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm320u
end type
type st_2 from statictext within w_mpm320u
end type
type st_3 from statictext within w_mpm320u
end type
type st_4 from statictext within w_mpm320u
end type
type cb_1 from commandbutton within w_mpm320u
end type
type dw_mpm320u_list from u_vi_std_datawindow within w_mpm320u
end type
type dw_mpm320u_01 from datawindow within w_mpm320u
end type
type dw_mpm320u_02 from datawindow within w_mpm320u
end type
type dw_report from datawindow within w_mpm320u
end type
type gb_1 from groupbox within w_mpm320u
end type
end forward

global type w_mpm320u from w_ipis_sheet01
uo_1 uo_1
st_2 st_2
st_3 st_3
st_4 st_4
cb_1 cb_1
dw_mpm320u_list dw_mpm320u_list
dw_mpm320u_01 dw_mpm320u_01
dw_mpm320u_02 dw_mpm320u_02
dw_report dw_report
gb_1 gb_1
end type
global w_mpm320u w_mpm320u

forward prototypes
public function integer wf_save_chk ()
public function integer wf_delete_chk (integer ag_delrow)
end prototypes

public function integer wf_save_chk ();//-------------------
// 작업실적에서 불량에 의한 실적등록이 있는지 여부 체크 
// 있으면 return 0 , 없으면 return -1
//------------------
String ls_orderno, ls_partno, ls_badoperno, ls_baddate
integer li_count

ls_orderno = dw_mpm320u_01.getitemstring( 1, 'orderno')
ls_partno = dw_mpm320u_01.getitemstring( 1, 'partno')
ls_badoperno = dw_mpm320u_01.getitemstring( 1, 'badoperno')
ls_baddate = dw_mpm320u_01.getitemstring( 1, 'baddate')

SELECT COUNT(*) INTO :li_count FROM TWORKJOB
WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND 
		OPERNO = :ls_badoperno AND WORKDATE = :ls_baddate
using sqlmpms;

if sqlmpms.sqlcode = 0 and li_count = 1 then
	return 0
else
	MessageBox("알림", "작업실적등록에서 불량원인공정이 존재하는지 확인하십시요.")
	return -1
end if
end function

public function integer wf_delete_chk (integer ag_delrow);//--------------------
// 해당불량원인에 대한 재작업실적등록 여부 체크
// 있으면 return -1 , 없으면 return 0
//--------------------
string ls_orderno, ls_partno, ls_badoperno, ls_baddate
integer li_count

ls_orderno = dw_mpm320u_list.getitemstring(ag_delrow, 'orderno')
ls_partno = dw_mpm320u_list.getitemstring(ag_delrow, 'partno')
ls_badoperno = dw_mpm320u_list.getitemstring(ag_delrow, 'badoperno')
ls_baddate = dw_mpm320u_list.getitemstring(ag_delrow, 'baddate')

SELECT COUNT(*) INTO :li_count FROM TWORKJOB
WHERE STYPE = 'WR' AND ORDERNO = :ls_orderno AND
		PARTNO = :ls_partno AND BADOPERNO = :ls_badoperno AND 
		BADDATE = :ls_baddate
using sqlmpms;

if li_count > 0 then
	Messagebox("알림","재작업실적이 존재합니다.")
	return -1
else
	return 0
end if

end function

on w_mpm320u.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.dw_mpm320u_list=create dw_mpm320u_list
this.dw_mpm320u_01=create dw_mpm320u_01
this.dw_mpm320u_02=create dw_mpm320u_02
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_mpm320u_list
this.Control[iCurrent+7]=this.dw_mpm320u_01
this.Control[iCurrent+8]=this.dw_mpm320u_02
this.Control[iCurrent+9]=this.dw_report
this.Control[iCurrent+10]=this.gb_1
end on

on w_mpm320u.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.dw_mpm320u_list)
destroy(this.dw_mpm320u_01)
destroy(this.dw_mpm320u_02)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm320u_list.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm320u_list.Height= ( newheight / 3 ) - ls_status

dw_mpm320u_01.x = dw_mpm320u_list.x
dw_mpm320u_01.y = dw_mpm320u_list.y + dw_mpm320u_list.Height + ls_status
dw_mpm320u_01.Width =  (dw_mpm320u_list.Width / 2) - ls_split
dw_mpm320u_01.Height = newheight - (dw_mpm320u_01.y + ls_status)

st_3.x = dw_mpm320u_01.x
st_3.y = dw_mpm320u_01.y - 90

dw_mpm320u_02.x = dw_mpm320u_list.x + ( dw_mpm320u_list.Width / 2 ) + ls_split
dw_mpm320u_02.y = dw_mpm320u_01.y
dw_mpm320u_02.Width = dw_mpm320u_01.Width
dw_mpm320u_02.Height = dw_mpm320u_01.Height

st_4.x = dw_mpm320u_02.x
st_4.y = st_3.y

end event

event ue_postopen;call super::ue_postopen;str_mpms_parm lstr_1

dw_report.settransobject(sqlmpms)
dw_mpm320u_list.settransobject(sqlmpms)
dw_mpm320u_01.settransobject(sqlmpms)
dw_mpm320u_02.settransobject(sqlmpms)

lstr_1 = message.PowerObjectParm

if Isvalid(lstr_1) then
	i_s_level = lstr_1.s_parm[1]
	This.title = lstr_1.s_parm[2]
	
	This.Triggerevent('ue_insert')
	
	dw_mpm320u_01.setitem( 1, 'orderno', lstr_1.s_parm[3] )
	dw_mpm320u_01.setitem( 1, 'partno', lstr_1.s_parm[4] )
	dw_mpm320u_01.setitem( 1, 'badoperno', lstr_1.s_parm[5] )
	dw_mpm320u_01.setitem( 1, 'baddate', lstr_1.s_parm[6] )
	dw_mpm320u_01.setitem( 1, 'stype', lstr_1.s_parm[7] )
	dw_mpm320u_01.setitem( 1, 'srno', lstr_1.s_parm[8] )
	dw_mpm320u_01.setitem( 1, 'scrapqty', lstr_1.i_parm[1] )
	
	dw_mpm320u_01.setcolumn('workman')
	dw_mpm320u_01.setfocus()
end if
end event

event ue_insert;call super::ue_insert;string ls_orderno

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택해 주십시요"
	return 0
end if

//해당 Order에 대한 불량발생내역 가져오기

dw_mpm320u_01.reset()
dw_mpm320u_01.insertrow(0)

dw_mpm320u_01.setitem( 1, "orderno", uo_1.is_uo_orderno)

dw_mpm320u_01.object.partno.protect = 0
dw_mpm320u_01.object.baddate.protect = 0
dw_mpm320u_01.object.badoperno.protect = 0

dw_mpm320u_01.setcolumn('partno')
dw_mpm320u_01.setfocus()

uo_status.st_message.text = "세부내역을 입력하십시요."

end event

event ue_retrieve;call super::ue_retrieve;datawindowchild ldwc
string ls_status, ls_orderno

dw_mpm320u_list.reset()
dw_mpm320u_01.reset()
dw_mpm320u_02.reset()

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if
dw_mpm320u_list.retrieve(ls_orderno)
end event

event ue_save;call super::ue_save;integer li_selrow, li_rowcnt, li_cnt
string ls_orderno, ls_partno, ls_badoperno, ls_baddate, ls_message
string ls_reoperno, ls_mchno, ls_reworkflag, ls_wccode, ls_stype, ls_srno
dec{0} lc_badtime

dw_mpm320u_01.Accepttext()
dw_mpm320u_02.Accepttext()
li_rowcnt = dw_mpm320u_02.rowcount()

if f_mpms_mandantory_chk(dw_mpm320u_01) = -1 then
	uo_status.st_message.text = '누락된 데이타가 있습니다.'
	return 0
end if

if wf_save_chk() = -1 then
	return 0
end if

ls_stype = dw_mpm320u_01.getitemstring( 1, 'stype')
ls_srno = dw_mpm320u_01.getitemstring( 1, 'srno')
ls_orderno = dw_mpm320u_01.getitemstring( 1, 'orderno')
ls_partno = dw_mpm320u_01.getitemstring( 1, 'partno')
ls_badoperno = dw_mpm320u_01.getitemstring( 1, 'badoperno')
ls_baddate = dw_mpm320u_01.getitemstring( 1, 'baddate')
ls_wccode = dw_mpm320u_01.getitemstring( 1, 'wccode')
sqlmpms.Autocommit = False

if dw_mpm320u_01.update() = 1 then
	DELETE FROM TBADDETAIL
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
			BADOPERNO = :ls_badoperno AND BADDATE = :ls_baddate
	using sqlmpms;
	if sqlmpms.sqlcode <> 0 then
		ls_message = 'baddetail_err'
		goto RollBack_
	end if
	if li_rowcnt = 0 then
		INSERT INTO TBADDETAIL  
		( Stype, Srno, OrderNo, PartNo, BadOperNo, BadDate, ReOperNo, WcCode, MchNo,   
		  BadTime, ReworkFlag, LastEmp, LastDate )  
		VALUES ( :ls_stype, :ls_srno, :ls_orderno, :ls_partno, :ls_badoperno, :ls_baddate, :ls_badoperno,   
		  :ls_wccode, ' ', 0, 'Y', :g_s_empno, getdate() )  
		using sqlmpms;
		if sqlmpms.sqlcode <> 0 then
			ls_message = 'baddetail_err'
			goto RollBack_
		end if
	else
		for li_cnt = 1 to li_rowcnt
			ls_reoperno = dw_mpm320u_02.getitemstring( li_cnt,'reoperno')
			ls_wccode = dw_mpm320u_02.getitemstring( li_cnt, 'wccode')
			ls_mchno = dw_mpm320u_02.getitemstring( li_cnt,'mchno')
			lc_badtime = dw_mpm320u_02.getitemdecimal( li_cnt,'badtime')
			ls_reworkflag = dw_mpm320u_02.getitemstring( li_cnt,'reworkflag')
			if ls_reworkflag = 'Y' then
	//			SELECT MCHNO, JOBTIME INTO :ls_mchno, :lc_badtime
	//			FROM TWORKJOB
	//			WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
	//					OPERNO = :ls_reoperno AND BADOPERNO = :ls_badoperno AND
	//					BADDATE = :ls_baddate
	//			using sqlmpms;
				
				INSERT INTO TBADDETAIL  
				( Stype, Srno, OrderNo, PartNo, BadOperNo, BadDate, ReOperNo, WcCode, MchNo,   
				  BadTime, ReworkFlag, WorkStatus, LastEmp, LastDate )  
				VALUES ( :ls_stype, :ls_srno, :ls_orderno, :ls_partno, :ls_badoperno, :ls_baddate, :ls_reoperno,   
				  :ls_wccode, :ls_mchno, :lc_badtime, :ls_reworkflag, 'R', :g_s_empno, getdate() )  
				using sqlmpms;
				if sqlmpms.sqlcode <> 0 then
					ls_message = 'baddetail_err'
					goto RollBack_
				end if
			end if
		next
	end if
else
	ls_message = 'badhead_err'
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent('ue_retrieve')
li_selrow = dw_mpm320u_list.find("orderno = '" + ls_orderno + "' and " &
			+ " partno = '" + ls_partno + "' and " &
			+ " badoperno = '" + ls_badoperno + "' and " &
			+ " baddate = '" + ls_baddate + "'", 1, dw_mpm320u_list.rowcount())
if li_selrow > 0 then
	dw_mpm320u_list.Post Event RowFocusChanged(li_selrow)
	dw_mpm320u_list.scrolltorow(li_selrow)
	dw_mpm320u_list.setrow(li_selrow)
end if
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.Autocommit = True
Choose Case ls_message
	Case 'badhead_err'
		Messagebox(ls_message,'저장중에 에러가 발생하였습니다.')
	Case 'baddetail_err'
		Messagebox(ls_message,'저장중에 에러가 발생하였습니다.')
End choose

return 0
end event

event ue_delete;call super::ue_delete;integer li_selrow, li_rtn
string ls_orderno, ls_partno, ls_badoperno, ls_baddate, ls_message

li_selrow = dw_mpm320u_list.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

ls_orderno = dw_mpm320u_list.getitemstring(li_selrow,'orderno')
ls_partno  = dw_mpm320u_list.getitemstring(li_selrow,'partno')
ls_badoperno  = dw_mpm320u_list.getitemstring(li_selrow,'badoperno')
ls_baddate  = dw_mpm320u_list.getitemstring(li_selrow,'baddate')

li_rtn = MessageBox("확인", ls_badoperno + " 불량원인공정 " &
		+ string(ls_baddate,'@@@@.@@.@@') + " 일자의 불량보고서를 삭제하시겠습니까?" &
		, Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if

if wf_delete_chk( li_selrow ) = -1 then
	return 0
end if

sqlmpms.Autocommit = False

DELETE FROM TBADHEAD
WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
		BADOPERNO = :ls_badoperno AND BADDATE = :ls_baddate
		using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = 'badhead_err'
	goto RollBack_
end if

DELETE FROM TBADDETAIL
WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
		BADOPERNO = :ls_badoperno AND BADDATE = :ls_baddate 
		using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = 'baddetail_err'
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.triggerevent('ue_retrieve')
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = '삭제시에 에러가 발생하였습니다.'
return 0
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

type uo_status from w_ipis_sheet01`uo_status within w_mpm320u
end type

type uo_1 from u_mpms_select_orderno within w_mpm320u
integer x = 59
integer y = 56
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;
iw_this.Triggerevent('ue_retrieve')

end event

event constructor;call super::constructor;is_option = '3'
end event

type st_2 from statictext within w_mpm320u
integer x = 18
integer y = 212
integer width = 512
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
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

type st_3 from statictext within w_mpm320u
integer x = 18
integer y = 1000
integer width = 539
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "불량 상세내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_4 from statictext within w_mpm320u
integer x = 1714
integer y = 1000
integer width = 512
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12639424
string text = "불량 전공정"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_mpm320u
integer x = 1490
integer y = 60
integer width = 549
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "재작업지시서"
end type

event clicked;integer li_selrow
string  mod_string, ls_stype, ls_srno

window 	l_to_open
str_easy l_str_prt

li_selrow = dw_mpm320u_list.getselectedrow(0)

if li_selrow < 1 then
	uo_status.st_message.text = "해당 불량발생데이타를 선택해 주십시요."
	return 0
end if

ls_stype = dw_mpm320u_list.getitemstring( li_selrow, 'stype')
ls_srno = dw_mpm320u_list.getitemstring( li_selrow, 'srno')

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_report.retrieve(ls_stype, ls_srno)

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0
end event

type dw_mpm320u_list from u_vi_std_datawindow within w_mpm320u
integer x = 27
integer y = 304
integer width = 3095
integer height = 676
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_mpm321u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_stype, ls_srno, ls_orderno, ls_partno, ls_badoperno, ls_baddate
String ls_status
integer li_rowcnt
datawindowchild ldwc

if currentrow < 1 then
	return -1
end if

dw_mpm320u_01.reset()
dw_mpm320u_02.reset()

This.selectrow( 0, False )
This.selectrow( currentrow, True )

ls_stype = This.getitemstring( currentrow, "stype" )
ls_srno  = This.getitemstring( currentrow, "srno" )
ls_orderno  = This.getitemstring( currentrow, "orderno" )
ls_partno  = This.getitemstring( currentrow, "partno" )
ls_badoperno  = This.getitemstring( currentrow, "badoperno" )
ls_baddate  = This.getitemstring( currentrow, "baddate" )

ls_status = f_mpms_get_orderstatus(uo_1.is_uo_orderno)

SELECT COUNT(*) INTO :li_rowcnt
FROM TWORKJOB
WHERE OrderNo = :ls_orderno AND PartNo = :ls_partno AND
	BadStype = :ls_stype AND BadSrno = :ls_srno using sqlmpms;

if ls_status = 'C' or li_rowcnt > 0 then
	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true,  false,  false,  false,  i_b_print, & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end if

dw_mpm320u_01.GetChild('partno', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve(uo_1.is_uo_orderno)

if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm320u_01,'partno',ldwc,'partname',5)

li_rowcnt = dw_mpm320u_01.retrieve( ls_stype, ls_srno )
// 부품번호, 불량발생일, 불량공정번호 수정불가
if li_rowcnt > 0 then
	dw_mpm320u_01.object.partno.protect = 1
	dw_mpm320u_01.object.baddate.protect = 1
	dw_mpm320u_01.object.badoperno.protect = 1
end if
dw_mpm320u_02.retrieve( ls_stype, ls_srno, ls_orderno, ls_partno, ls_badoperno, ls_baddate )

end event

type dw_mpm320u_01 from datawindow within w_mpm320u
integer x = 32
integer y = 1096
integer width = 1637
integer height = 776
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm320u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String 	ls_colName, ls_null, ls_material, ls_partname, ls_orderno, ls_partno
String   ls_wccode

this.AcceptText ( )
uo_status.st_message.text = ''
SetNull(ls_Null)
ls_orderno = uo_1.is_uo_orderno
ls_colName = dwo.name
Choose Case ls_colName
	Case 'partno'
		SELECT MATERIAL, PARTNAME INTO :ls_material, :ls_partname
		FROM TPARTLIST
		WHERE ORDERNO = :ls_orderno AND PARTNO = :data
		using sqlmpms;
		
		This.setitem( 1, 'material', ls_material)
		This.setitem( 1, 'partname', ls_partname)
	Case 'badoperno'
		ls_partno = This.getitemstring( 1, 'partno')
		
		SELECT WCCODE INTO :ls_wccode
		FROM TROUTING
		WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
				OPERNO  = :data
		using sqlmpms;
		
		if isnull(ls_wccode) or sqlmpms.sqlcode <> 0 then
			uo_status.st_message.text = '등록된 공정번호가 아닙니다.'
			This.setitem( 1, 'badoperno', space(3))
			This.setitem( 1, 'wccode', space(3))
			return 1
		end if
		This.setitem( 1, 'wccode', ls_wccode)
	Case 'baddate'
		if f_dateedit(data) = space(8) then
			uo_status.st_message.text = '올바른 날짜가 아닙니다.'
			This.setitem( 1, 'baddate', space(8))
			return 1
		end if
End Choose
end event

type dw_mpm320u_02 from datawindow within w_mpm320u
integer x = 1723
integer y = 1092
integer width = 1394
integer height = 776
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_mpm320u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String 	ls_colName, ls_null
String   ls_orderno, ls_partno, ls_badoperno, ls_baddate, ls_reoperno
integer  li_count

this.AcceptText ( )
SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'reworkchk'
		If data = '1' then
			This.setitem( row, 'reworkflag', 'Y')
		else
			ls_orderno = This.getitemstring( row, 'orderno')
			ls_partno = This.getitemstring(row,'partno')
			ls_badoperno = This.getitemstring(row,'badoperno')
			ls_baddate = This.getitemstring(row,'baddate')
			ls_reoperno = This.getitemstring(row,'reoperno')
			
			SELECT COUNT(*) INTO :li_count FROM TWORKJOB
			WHERE STYPE = 'WR' AND ORDERNO = :ls_orderno AND
					PARTNO = :ls_partno AND OPERNO = :ls_reoperno AND
					BADOPERNO = :ls_badoperno AND BADDATE = :ls_baddate
			using sqlmpms;
			
			if li_count > 0 or ls_badoperno = ls_reoperno then
				MessageBox("알림", "해당재작업공정은 재작업실적이 등록되어 있습니다.")
				This.setitem( row, 'reworkchk', 1)
				return 1
			else
				This.setitem( row, 'reworkflag', 'N')
			end if
		end if
End Choose
end event

type dw_report from datawindow within w_mpm320u
boolean visible = false
integer x = 2240
integer y = 88
integer width = 535
integer height = 328
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm320u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm320u
integer x = 18
integer width = 2080
integer height = 188
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

