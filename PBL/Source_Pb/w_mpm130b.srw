$PBExportHeader$w_mpm130b.srw
$PBExportComments$재료비수정
forward
global type w_mpm130b from w_ipis_sheet01
end type
type dw_mpm130b_01 from u_vi_std_datawindow within w_mpm130b
end type
type uo_2 from u_mpms_select_partno within w_mpm130b
end type
type uo_1 from u_mpms_select_orderno within w_mpm130b
end type
type st_2 from statictext within w_mpm130b
end type
type dw_mpm130b_02 from datawindow within w_mpm130b
end type
type uo_3 from u_mpms_date_scroll_month within w_mpm130b
end type
type gb_1 from groupbox within w_mpm130b
end type
end forward

global type w_mpm130b from w_ipis_sheet01
boolean minbox = true
dw_mpm130b_01 dw_mpm130b_01
uo_2 uo_2
uo_1 uo_1
st_2 st_2
dw_mpm130b_02 dw_mpm130b_02
uo_3 uo_3
gb_1 gb_1
end type
global w_mpm130b w_mpm130b

type variables
str_mpms_parm istr_1
string is_yyyymm
end variables

forward prototypes
public function string wf_get_srno ()
end prototypes

public function string wf_get_srno ();String ls_custcd

DECLARE up_get_custcode PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'MAT'  
	 using sqlmpms;

Execute up_get_custcode;

if sqlmpms.sqlcode = 0 then
	fetch up_get_custcode into :ls_custcd;
	close up_get_custcode;
end if

return ls_custcd
end function

on w_mpm130b.create
int iCurrent
call super::create
this.dw_mpm130b_01=create dw_mpm130b_01
this.uo_2=create uo_2
this.uo_1=create uo_1
this.st_2=create st_2
this.dw_mpm130b_02=create dw_mpm130b_02
this.uo_3=create uo_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm130b_01
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_mpm130b_02
this.Control[iCurrent+6]=this.uo_3
this.Control[iCurrent+7]=this.gb_1
end on

on w_mpm130b.destroy
call super::destroy
destroy(this.dw_mpm130b_01)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.dw_mpm130b_02)
destroy(this.uo_3)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm130b_01.settransobject(sqlmpms)
dw_mpm130b_02.settransobject(sqlmpms)
istr_1 = message.PowerObjectParm

dw_mpm130b_01.GetChild('matcls', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM009')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm130b_01,'matcls',ldwc,'codename',5)

dw_mpm130b_02.GetChild('matcls', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM009')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm130b_02,'matcls',ldwc,'codename',5)

if Isvalid(istr_1) then
	i_s_level = istr_1.s_parm[1]
	This.title = istr_1.s_parm[2]
	is_yyyymm = mid(istr_1.s_parm[4],1,6)
	string ls_date, ls_result
	
	ls_result = f_mpms_get_monthjob(is_yyyymm)

	if ls_result = 'C' then
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		i_b_retrieve 	= True
		i_b_insert 	 	= False
		i_b_save 		= False
		i_b_delete 		= False
		i_b_print 		= False
		i_b_dretrieve 	= False
		i_b_dprint 		= False
		i_b_dchar 		= False
	else
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
		i_b_retrieve 	= True
		i_b_insert 	 	= True
		i_b_save 		= True
		i_b_delete 		= True
		i_b_print 		= False
		i_b_dretrieve 	= False
		i_b_dprint 		= False
		i_b_dchar 		= False
	end if
	wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)

	ls_date = string(is_yyyymm + '01','@@@@-@@-@@')
	uo_3.uf_setdata( date( ls_date ) )
	This.Triggerevent('ue_retrieve')
end if
end event

event ue_insert;call super::ue_insert;string ls_orderno, ls_partno, ls_srno

dw_mpm130b_02.reset()

ls_orderno = uo_1.is_uo_orderno
ls_partno = uo_2.is_uo_partno

ls_srno = wf_get_srno()
if f_spacechk(ls_srno) = -1 then
	messagebox("알림","전산번호를 생성하는데 실패했습니다.")
	return 0
end if
dw_mpm130b_02.insertrow(0)
dw_mpm130b_02.setitem( 1, 'orderno', '' )
dw_mpm130b_02.setitem( 1, 'partno', '' )
dw_mpm130b_02.setitem( 1, 'sliptype', 'WR' )
dw_mpm130b_02.setitem( 1, 'srno', ls_srno )
dw_mpm130b_02.setitem( 1, 'srno1', '00' )
dw_mpm130b_02.setitem( 1, 'srno2', '00' )
dw_mpm130b_02.setitem( 1, 'rqno', 'WR' + ls_srno )
dw_mpm130b_02.setitem( 1, 'tdte4', istr_1.s_parm[5] )
dw_mpm130b_02.setitem( 1, 'Lastemp', g_s_empno )
dw_mpm130b_02.setitem( 1, 'lastdate', f_mpms_get_nowtime() )
end event

event ue_retrieve;call super::ue_retrieve;string ls_orderno, ls_partno

dw_mpm130b_01.reset()
dw_mpm130b_02.reset()

ls_orderno = uo_1.is_uo_orderno
ls_partno = uo_2.is_uo_partno
if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if
if f_spacechk(ls_partno) = -1 or ls_partno = 'ALL' then
	ls_partno = '%'
else
	ls_partno = ls_partno + '%'
end if

dw_mpm130b_01.retrieve( ls_orderno, ls_partno, istr_1.s_parm[4], istr_1.s_parm[5] )
end event

event ue_save;call super::ue_save;string ls_orderno, ls_partno, ls_tdte4, ls_message, ls_yyyymm
string ls_fromdt, ls_todt, ls_rtn
dec{0} lc_tramt
integer li_count

dw_mpm130b_01.accepttext()
dw_mpm130b_02.accepttext()
ls_fromdt = istr_1.s_parm[4]
ls_todt = istr_1.s_parm[5]
ls_yyyymm = mid(ls_fromdt,1,6)

if dw_mpm130b_01.modifiedcount() < 1 and dw_mpm130b_02.modifiedcount() < 1 then
	messagebox("경고","수정된 데이타가 없습니다.")
	return 0
end if

if dw_mpm130b_02.modifiedcount() > 0 then
	if f_mpms_mandantory_chk(dw_mpm130b_02) = -1 then
		messagebox("경고","저장할 정보가 누락되었습니다.")
		return 0
	end if
end if

sqlmpms.AutoCommit = False

if dw_mpm130b_01.update() <> 1 then
	ls_message = 'ERR01'
	goto Rollback_
end if

if dw_mpm130b_02.modifiedcount() > 0 then
	if dw_mpm130b_02.update() <> 1 then
		ls_message = 'ERR02'
		goto Rollback_
	end if
end if

//재료비 Summary 작업
DECLARE up_mpm130u_calc PROCEDURE FOR sp_mpm130u_calc  
         @ps_fromdt = :ls_fromdt, 
			@ps_todt = :ls_todt,
         @ps_empno = :g_s_empno  
			using sqlmpms;
Execute up_mpm130u_calc;

if sqlmpms.sqlcode = -1 then
	ls_message = 'ERR03'
	goto Rollback_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True
messagebox("알림","정상적으로 처리되었습니다.")
uo_2.triggerevent('ue_select')
return 0

Rollback_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True
Choose case ls_message
	case 'ERR01'
		Messagebox("경고", "Order No 또는 Part No 저장시에 에러가 발생하였습니다.")
	case 'ERR02'
		Messagebox("경고", "재료비 계산중에 에러가 발생하였습니다.")
End Choose
return 0
end event

event ue_delete;call super::ue_delete;integer li_selrow
string ls_sliptype, ls_srno, ls_srno1, ls_srno2, ls_orderno, ls_fromdt, ls_todt, ls_rqno

li_selrow = dw_mpm130b_01.getselectedrow(0)
if li_selrow < 1 then
	messagebox("알림", "삭제할 데이타가 존재하지 않습니다.")
	return 0
end if

ls_sliptype = dw_mpm130b_01.getitemstring(li_selrow, 'sliptype')
ls_srno = dw_mpm130b_01.getitemstring(li_selrow, 'srno')
ls_srno1 = dw_mpm130b_01.getitemstring(li_selrow, 'srno1')
ls_srno2 = dw_mpm130b_01.getitemstring(li_selrow, 'srno2')
ls_orderno = dw_mpm130b_01.getitemstring(li_selrow, 'orderno')
ls_rqno = dw_mpm130b_01.getitemstring(li_selrow, 'rqno')

if ls_sliptype <> 'WR' then
	messagebox("알림", "Stype이 'WR'인 데이타만 삭제할 수 있습니다.")
	return 0
end if

if MessageBox("확인", "구매번호: " + ls_rqno + " 을 삭제하시겠습니까?", &
		Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

sqlmpms.AutoCommit = False

DELETE FROM TITEMSTORE
WHERE SLIPTYPE = :ls_sliptype AND SRNO = :ls_srno AND
		SRNO1 = :ls_srno1 AND SRNO2 = :ls_srno2
using sqlmpms;

if sqlmpms.sqlcode = 0 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	messagebox("알림","정상적으로 처리되었습니다.")
	uo_2.triggerevent('ue_select')
else
	messagebox("알림","처리중에 에러가 발생하였습니다.")
	RollBack using sqlmpms;
	sqlmpms.AutoCommit = True	
	return 0
end if

ls_fromdt = istr_1.s_parm[4]
ls_todt = istr_1.s_parm[5]
//재료비 Summary 작업
DECLARE up_mpm130u_calc PROCEDURE FOR sp_mpm130u_calc  
         @ps_fromdt = :ls_fromdt,
			@ps_todt = :ls_todt, 
         @ps_empno = :g_s_empno  
			using sqlmpms;
Execute up_mpm130u_calc;

if sqlmpms.sqlcode = -1 then
	messagebox("경고", "재료비 재작업중에 에러가 발생하였습니다.")
end if

return 0
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm130b_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm130b_01.Height= ( newheight * 4 / 5 ) - dw_mpm130b_01.y

dw_mpm130b_02.x = dw_mpm130b_01.x
dw_mpm130b_02.y = dw_mpm130b_01.y + dw_mpm130b_01.Height + ls_split
dw_mpm130b_02.Width = dw_mpm130b_01.Width
dw_mpm130b_02.Height = newheight - ( dw_mpm130b_01.Height + dw_mpm130b_01.y + ls_status)
end event

event open;call super::open;
f_mpms_retrieve_dddw_partno(uo_2.dw_1, &
										uo_1.is_uo_orderno, &
										'%', &
										true, &
										uo_2.is_uo_partno, &
										uo_2.is_uo_partname )
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm130b
end type

type dw_mpm130b_01 from u_vi_std_datawindow within w_mpm130b
integer x = 23
integer y = 268
integer width = 3561
integer height = 1336
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_mpm130b_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;string ls_column, ls_orderno, ls_partno, ls_yyyymm, ls_null, ls_status
integer li_count

setnull(ls_null)
ls_yyyymm = mid(istr_1.s_parm[4],1,6)

ls_column = dwo.name
This.accepttext()

choose case ls_column
	case 'orderno'
		ls_orderno = data
		ls_status = f_mpms_get_orderstatus(ls_orderno)

		if ls_status = 'C' then
			SELECT CONVERT(CHAR(6), ISNULL(ENDDATE,getdate()),112) INTO :ls_yyyymm
			FROM TORDER
			WHERE ORDERNO = :ls_orderno
			using sqlmpms;
			
			if is_yyyymm > ls_yyyymm then
				MessageBox("경고", "마감확정된 Order No 입니다.")
				This.setitem(row,'orderno', ' ')
				This.setitem(row,'partno', ' ')
				return 1
			end if
		end if
		
		ls_partno = This.getitemstring(row,'partno')
		if f_spacechk(ls_partno) = -1 then
			SELECT COUNT(*) INTO :li_count
			FROM TMATCOST
			WHERE YEARMM = :ls_yyyymm AND ORDERNO = :ls_orderno
			using sqlmpms;
			if li_count < 1 then
				messagebox("경고","해당월에 존재하지 않는 Order No입니다.")
				This.setitem(row,'orderno', ' ')
				This.setitem(row,'partno', ' ')
				return 1
			end if
		else
			SELECT COUNT(*) INTO :li_count
			FROM TMATCOST
			WHERE YEARMM = :ls_yyyymm AND
					ORDERNO = :ls_orderno AND PARTNO = :ls_partno
			using sqlmpms;
			if li_count < 1 then
				messagebox("경고","해당월에 존재하지 않는 Order No 또는 Part No 입니다.")
				This.setitem(row,'orderno', ' ')
				return 1
			end if
		end if
	case 'partno'
		ls_orderno = This.getitemstring(row,'orderno')
		ls_partno = data
		SELECT COUNT(*) INTO :li_count
		FROM TMATCOST
		WHERE YEARMM = :ls_yyyymm AND
				ORDERNO = :ls_orderno AND PARTNO = :ls_partno
		using sqlmpms;
		if li_count < 1 then
			messagebox("경고","해당월에 존재하지 않는 Part No입니다.")
			This.setitem(row,'partno', ' ')
			return 1
		end if
end choose
end event

type uo_2 from u_mpms_select_partno within w_mpm130b
event destroy ( )
integer x = 1952
integer y = 56
integer taborder = 10
boolean bringtotop = true
end type

on uo_2.destroy
call u_mpms_select_partno::destroy
end on

event ue_select;call super::ue_select;iw_this.Triggerevent('ue_retrieve')
end event

type uo_1 from u_mpms_select_orderno within w_mpm130b
event destroy ( )
integer x = 745
integer y = 40
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event constructor;call super::constructor;is_option = '1'
end event

event ue_select;call super::ue_select;f_mpms_retrieve_dddw_partno(uo_2.dw_1, &
										uo_1.is_uo_orderno, &
										'%', &
										True, &
										uo_2.is_uo_partno, &
										uo_2.is_uo_partname )
										
uo_2.Triggerevent('ue_select')
end event

type st_2 from statictext within w_mpm130b
integer x = 18
integer y = 192
integer width = 558
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
string text = "입고 및 수정 내역"
boolean focusrectangle = false
end type

type dw_mpm130b_02 from datawindow within w_mpm130b
integer x = 23
integer y = 1636
integer width = 3552
integer height = 228
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm130b_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_column, ls_orderno, ls_partno, ls_yyyymm, ls_null, ls_status
integer li_count

setnull(ls_null)
ls_yyyymm = mid(istr_1.s_parm[4],1,6)

ls_column = dwo.name
This.accepttext()

choose case ls_column
	case 'orderno'
		ls_orderno = data
		ls_status = f_mpms_get_orderstatus(ls_orderno)

		if ls_status = 'C' then
			SELECT CONVERT(CHAR(6),ENDDATE,112) INTO :ls_yyyymm
			FROM TORDER
			WHERE ORDERNO = :ls_orderno
			using sqlmpms;
			
			if mid(g_s_date,1,6) <> ls_yyyymm then
				MessageBox("경고", "마감확정된 Order No 입니다.")
				This.setitem(row,'orderno', ' ')
				This.setitem(row,'partno', ' ')
				return 1
			end if
		end if
		
		ls_partno = This.getitemstring(row,'partno')
		if f_spacechk(ls_partno) = -1 then
			SELECT COUNT(*) INTO :li_count
			FROM TMATCOST
			WHERE YEARMM = :ls_yyyymm AND ORDERNO = :ls_orderno
			using sqlmpms;
			if li_count < 1 then
				messagebox("경고","해당월에 존재하지 않는 Order No입니다.")
				This.setitem(row,'orderno', ' ')
				This.setitem(row,'partno', ' ')
				return 1
			end if
		else
			SELECT COUNT(*) INTO :li_count
			FROM TMATCOST
			WHERE YEARMM = :ls_yyyymm AND
					ORDERNO = :ls_orderno AND PARTNO = :ls_partno
			using sqlmpms;
			if li_count < 1 then
				messagebox("경고","해당월에 존재하지 않는 Order No 또는 Part No 입니다.")
				This.setitem(row,'orderno', ' ')
				return 1
			end if
		end if
	case 'partno'
		ls_orderno = This.getitemstring(row,'orderno')
		ls_partno = data
		SELECT COUNT(*) INTO :li_count
		FROM TMATCOST
		WHERE YEARMM = :ls_yyyymm AND
				ORDERNO = :ls_orderno AND PARTNO = :ls_partno
		using sqlmpms;
		if li_count < 1 then
			messagebox("경고","해당월에 존재하지 않는 Part No입니다.")
			This.setitem(row,'partno', ' ')
			return 1
		end if
end choose
end event

type uo_3 from u_mpms_date_scroll_month within w_mpm130b
integer x = 64
integer y = 56
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
end type

on uo_3.destroy
call u_mpms_date_scroll_month::destroy
end on

event constructor;call super::constructor;//string ls_date
//
////ls_postdate = string(f_relativedate( mid(g_s_date,1,6) + '01', -1),'@@@@-@@-@@')
////This.uf_setdata( date( ls_postdate ) )
//
//ls_date = string(is_yyyymm + '01','@@@@-@@-@@')
//This.uf_setdata( date( ls_date ) )
end event

type gb_1 from groupbox within w_mpm130b
integer x = 9
integer width = 2994
integer height = 164
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

