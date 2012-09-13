$PBExportHeader$w_mpm130u.srw
$PBExportComments$재료비계산
forward
global type w_mpm130u from w_ipis_sheet01
end type
type uo_1 from u_mpms_select_orderno within w_mpm130u
end type
type dw_mpm130u_01 from u_vi_std_datawindow within w_mpm130u
end type
type cb_cal from commandbutton within w_mpm130u
end type
type dw_mpm130u_02 from datawindow within w_mpm130u
end type
type uo_2 from u_mpms_date_scroll_month within w_mpm130u
end type
type dw_mpm130u_03 from datawindow within w_mpm130u
end type
type st_2 from statictext within w_mpm130u
end type
type st_3 from statictext within w_mpm130u
end type
type cb_confirm from commandbutton within w_mpm130u
end type
type st_4 from statictext within w_mpm130u
end type
type em_laborcost from editmask within w_mpm130u
end type
type cb_close from commandbutton within w_mpm130u
end type
type st_5 from statictext within w_mpm130u
end type
type cb_confirmcancel from commandbutton within w_mpm130u
end type
type gb_1 from groupbox within w_mpm130u
end type
end forward

global type w_mpm130u from w_ipis_sheet01
integer width = 4416
uo_1 uo_1
dw_mpm130u_01 dw_mpm130u_01
cb_cal cb_cal
dw_mpm130u_02 dw_mpm130u_02
uo_2 uo_2
dw_mpm130u_03 dw_mpm130u_03
st_2 st_2
st_3 st_3
cb_confirm cb_confirm
st_4 st_4
em_laborcost em_laborcost
cb_close cb_close
st_5 st_5
cb_confirmcancel cb_confirmcancel
gb_1 gb_1
end type
global w_mpm130u w_mpm130u

type variables

end variables

forward prototypes
public function boolean wf_down (string ag_fromdt, string ag_todt, ref string ag_message)
end prototypes

public function boolean wf_down (string ag_fromdt, string ag_todt, ref string ag_message);integer li_rtn, li_rowcnt
datastore lds_source, lds_target

lds_source = create datastore
lds_source.dataobject = "d_mpm130u_inv401_source"
lds_source.settransobject(sqlca)

lds_target = create datastore
lds_target.dataobject = "d_mpm130u_inv401_target"
lds_target.settransobject(sqlmpms)

li_rowcnt = lds_source.retrieve(ag_fromdt, ag_todt)
if li_rowcnt < 1 then
	ag_message = "다운로드할 입고정보가 없습니다."
	destroy lds_source
	destroy lds_target
	return false
end if

li_rtn = lds_source.RowsMove(1, li_rowcnt, Primary!, lds_target, 1, Primary!)
if li_rtn <> 1 then
	ag_message = "입고정보를 금형공정으로 이동시에 오류가 발생했습니다."
	destroy lds_source
	destroy lds_target
	return false
end if

DELETE FROM P_INV401 using sqlmpms;

if lds_target.update() <> 1 then
	ag_message = "입고정보를 금형공정에 저장시에 오류가 발생했습니다."
	destroy lds_source
	destroy lds_target
	return false
end if

destroy lds_source
destroy lds_target
return true
end function

on w_mpm130u.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_mpm130u_01=create dw_mpm130u_01
this.cb_cal=create cb_cal
this.dw_mpm130u_02=create dw_mpm130u_02
this.uo_2=create uo_2
this.dw_mpm130u_03=create dw_mpm130u_03
this.st_2=create st_2
this.st_3=create st_3
this.cb_confirm=create cb_confirm
this.st_4=create st_4
this.em_laborcost=create em_laborcost
this.cb_close=create cb_close
this.st_5=create st_5
this.cb_confirmcancel=create cb_confirmcancel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_mpm130u_01
this.Control[iCurrent+3]=this.cb_cal
this.Control[iCurrent+4]=this.dw_mpm130u_02
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.dw_mpm130u_03
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cb_confirm
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.em_laborcost
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.cb_confirmcancel
this.Control[iCurrent+15]=this.gb_1
end on

on w_mpm130u.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_mpm130u_01)
destroy(this.cb_cal)
destroy(this.dw_mpm130u_02)
destroy(this.uo_2)
destroy(this.dw_mpm130u_03)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_confirm)
destroy(this.st_4)
destroy(this.em_laborcost)
destroy(this.cb_close)
destroy(this.st_5)
destroy(this.cb_confirmcancel)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm130u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm130u_01.Height= ( newheight * 3 / 5 ) - dw_mpm130u_01.y

st_2.x = dw_mpm130u_01.x
st_2.y = dw_mpm130u_01.y + dw_mpm130u_01.Height + ls_split

dw_mpm130u_02.x = dw_mpm130u_01.x
dw_mpm130u_02.y = dw_mpm130u_01.y + dw_mpm130u_01.Height + st_2.Height + ls_split
dw_mpm130u_02.Width = (dw_mpm130u_01.Width * 3 / 5)
dw_mpm130u_02.Height = newheight - ( st_2.y + st_2.Height + ls_status)

st_3.x = dw_mpm130u_02.x + dw_mpm130u_02.Width + ls_split
st_3.y = st_2.y

dw_mpm130u_03.x = st_3.x
dw_mpm130u_03.y = dw_mpm130u_02.y
dw_mpm130u_03.Width = (dw_mpm130u_01.Width * 2 / 5 - ls_split)
dw_mpm130u_03.Height = dw_mpm130u_02.Height
end event

event ue_retrieve;call super::ue_retrieve;string ls_fromdt, ls_orderno

uo_2.Triggerevent("ue_select")

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 or ls_orderno = 'ALL' then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if

ls_fromdt = string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD')

dw_mpm130u_01.retrieve( mid(ls_fromdt,1,6), ls_orderno)
dw_mpm130u_03.retrieve( mid(ls_fromdt,1,6))
end event

event ue_save;call super::ue_save;//--------------------
// 1. 공순별로 변경된 열처리비, 외주가공비, 원자재비를 저장한다.
//--------------------
//integer li_selrow
//string ls_partno, ls_operno
//dw_mpm130u_02.accepttext()
//
//sqlmpms.AutoCommit = False
//
//if dw_mpm130u_02.modifiedcount() > 0 then
//	ls_partno = dw_mpm130u_02.getitemstring( 1, 'partno')
//	ls_operno = dw_mpm130u_02.getitemstring( 1, 'operno')
//	if dw_mpm130u_02.update() = 1 then
//		Commit using sqlmpms;
//		sqlmpms.AutoCommit = True
//		
//		This.Triggerevent("ue_retrieve")
//		li_selrow = dw_mpm130u_01.find("partno = '" + ls_partno + "' and operno = '" &
//							+ ls_operno + "'", 1, dw_mpm130u_01.rowcount())
//		if li_selrow > 0 then
//			dw_mpm130u_01.Post Event RowFocusChanged(li_selrow)
//			dw_mpm130u_01.scrolltorow(li_selrow)
//			dw_mpm130u_01.setrow(li_selrow)
//		end if
//		
//		uo_status.st_message.text = '저장되었습니다.'
//	else
//		RollBack using sqlmpms;
//		sqlmpms.AutoCommit = True
//		uo_status.st_message.text = '저장중에 에러가 발생하였습니다.'
//	end if
//end if
//
//return 0
end event

event activate;call super::activate;dw_mpm130u_01.settransobject(sqlmpms)
dw_mpm130u_02.settransobject(sqlmpms)
dw_mpm130u_03.settransobject(sqlmpms)

This.triggerevent('ue_retrieve')
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm130u
end type

type uo_1 from u_mpms_select_orderno within w_mpm130u
integer x = 32
integer y = 36
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;iw_this.Triggerevent('ue_retrieve')
end event

event constructor;call super::constructor;is_option = '1'
end event

type dw_mpm130u_01 from u_vi_std_datawindow within w_mpm130u
integer x = 18
integer y = 232
integer width = 3557
integer height = 1060
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm130u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno, ls_partno, ls_operno, ls_fromdt, ls_todt

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_fromdt = string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD')
ls_todt = f_relativedate(uf_mpms_addmonth(ls_fromdt,1) + '01',-1)

dw_mpm130u_02.reset()
ls_orderno = This.getitemstring( currentrow, "orderno")
ls_partno = This.getitemstring( currentrow, "partno")

dw_mpm130u_02.retrieve(ls_fromdt, ls_todt, ls_orderno, ls_partno)
end event

event rbuttondown;call super::rbuttondown;
m_pop_mpms NewMenu
string ls_name, ls_data, ls_type, ls_col_type
str_mpms_parm lstr

ls_type = dwo.type
If ls_type = 'column' Then
	ls_name = dwo.name
	ls_col_type = this.Describe(ls_name+".ColType")
	If pos(ls_col_type,'char',1) > 0 Then
		ls_data = dwo.Primary[row]
	Else
		ls_data = ''
	End if
End if

If row > 0 Then
	this.SelectRow(0,False)
	this.SelectRow(row, True)
	this.setfocus()
//Else
//	return 0
End if

lstr.w_parm = iw_this
lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[금형공정관리]-[재료비수정]'
lstr.s_parm[3] = This.getitemstring(row,'orderno')
lstr.s_parm[4] = string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD')
lstr.s_parm[5] = f_relativedate(uf_mpms_addmonth(lstr.s_parm[4],1) + '01',-1)

message.PowerObjectParm = lstr
NewMenu = CREATE m_pop_mpms
//NewMenu.mf_get_dw(this, row, ls_name, ls_data)
//Popup Menu 조정

NewMenu.m_action.m_copy.enabled = False
NewMenu.m_action.m_matadd.enabled = True
NewMenu.m_action.m_subadd.enabled = False
NewMenu.m_action.m_modify.enabled = False
NewMenu.m_action.m_wccode.enabled = False
NewMenu.m_action.m_workstatus.enabled = False
NewMenu.m_action.m_outcal.enabled = False

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

type cb_cal from commandbutton within w_mpm130u
integer x = 2523
integer y = 48
integer width = 416
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "재료비계산"
end type

event clicked;//------------------
// 재료비 계산
// 1. 월별인건비를 입력받는다.
//	2. 월별 입고된 자재를 가져온다.
//	3. 월에 대한 제작완료 여부를 Order별로 업데이트 한다.
//	4. OrderNo, PartNo별로 재료비를 배분한다.
//------------------
string ls_message, ls_rtn, ls_partno, ls_orderno, ls_fromdt, ls_todt, ls_currdt
integer li_count, li_cnt, li_currow, li_rtn
dec{0} lc_laborcost
datetime ld_nowtime
datastore lds_source, lds_target

uo_status.st_message.text = ""
em_laborcost.getdata(lc_laborcost)
ls_fromdt = string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD')
if lc_laborcost = 0 then
	uo_status.st_message.text = "인건비를 입력바랍니다."
	return 0
else
	ls_currdt = mid(ls_fromdt,1,6)
	ld_nowtime = f_mpms_get_nowtime()
	SELECT COUNT(*) INTO :li_rtn
		FROM TMONTHJOB
		WHERE TMONTHJOB.YearMm = :ls_currdt
		using sqlmpms;
	if li_rtn < 1 then
		INSERT INTO TMONTHJOB  
			( YearMm, LaborCost, ResultFlag, LastEmp, LastDate )  
		VALUES ( :ls_currdt, :lc_laborcost, 'G', :g_s_empno, :ld_nowtime )  
		using sqlmpms;
		if sqlmpms.sqlcode <> 0 then
			uo_status.st_message.text = "인건비 저장시에 에러가 발생하였습니다."
			return 0
		end if
	else
		UPDATE TMONTHJOB  
			SET LaborCost = :lc_laborcost,   
				 LastEmp = :g_s_empno,   
				 LastDate = :ld_nowtime  
			WHERE TMONTHJOB.YearMm = :ls_currdt   
			using sqlmpms;
		if sqlmpms.sqlnrows <> 1 then
			uo_status.st_message.text = "인건비 저장시에 에러가 발생하였습니다."
			return 0
		end if
	end if
end if

li_rtn = MessageBox("알림", "계산년월 : " + uo_2.is_uo_month + " 에 대한 재료비 " &
	+ "계산을 실행하시겠습니까?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if

setpointer(hourglass!)
ls_todt = f_relativedate(uf_mpms_addmonth(ls_fromdt,1) + '01',-1)

//입고 자재 다운로드
sqlmpms.AutoCommit = False
if Not wf_down( ls_fromdt, ls_todt, ls_message) then
	goto Rollback_
end if

//DATA CrossCheck
DECLARE up_mpm130u_crosscheck PROCEDURE FOR sp_mpm130u_crosscheck 
         @ps_fromdt = :ls_fromdt, 
			@ps_todt = :ls_todt,
         @ps_empno = :g_s_empno  
			using sqlmpms;
Execute up_mpm130u_crosscheck;

if sqlmpms.sqlcode = -1 then
	ls_message = "Data CrossCheck 중에 에러가 발생하였습니다. : " + string(sqlmpms.sqlcode)
	goto Rollback_
end if

//재료비 Summary 작업
DECLARE up_mpm130u_calc PROCEDURE FOR sp_mpm130u_calc  
         @ps_fromdt = :ls_fromdt, 
			@ps_todt = :ls_todt,
         @ps_empno = :g_s_empno  
			using sqlmpms;
Execute up_mpm130u_calc;

if SQLMPMS.sqlcode = -1 then
	ls_message = "재료비 계산중에 에러가 발생하였습니다. : " + string(sqlmpms.sqlcode)
	goto Rollback_
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True

iw_this.Triggerevent('activate')
uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

Rollback_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True
Messagebox("경고", ls_message)

return 0


end event

type dw_mpm130u_02 from datawindow within w_mpm130u
integer x = 23
integer y = 1392
integer width = 2158
integer height = 496
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm130u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colName, ls_null

SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'heatcost', 'outcost', 'matcost'
		This.Setitem( row, 'Lastemp', g_s_empno )
		This.Setitem( row, 'LastDate', f_mpms_get_nowtime() )
End Choose
end event

type uo_2 from u_mpms_date_scroll_month within w_mpm130u
integer x = 1184
integer y = 56
integer taborder = 30
boolean bringtotop = true
end type

on uo_2.destroy
call u_mpms_date_scroll_month::destroy
end on

event constructor;call super::constructor;string ls_postdate

ls_postdate = string(f_relativedate( mid(g_s_date,1,6) + '01', -1),'@@@@-@@-@@')
This.uf_setdata( date( ls_postdate ) )
end event

event ue_select;call super::ue_select;string ls_yyyymm, ls_rtn
dec{0} lc_laborcost

dw_mpm130u_01.reset()
dw_mpm130u_02.reset()
dw_mpm130u_03.reset()

ls_yyyymm = mid(string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD'),1,6)
ls_rtn = f_mpms_get_monthjob(ls_yyyymm)

if ls_rtn = 'G' then
	cb_cal.enabled = True
	cb_confirm.enabled = True
	cb_confirmcancel.enabled = True
	cb_close.enabled = True
	
	select laborcost into :lc_laborcost
	from tmonthjob
	where yearmm = :ls_yyyymm
	using sqlmpms;
	
	em_laborcost.text = string(lc_laborcost)
elseif ls_rtn = 'C' then
	cb_cal.enabled = False
	cb_confirm.enabled = False
	cb_confirmcancel.enabled = False
	cb_close.enabled = False
	
	select laborcost into :lc_laborcost
	from tmonthjob
	where yearmm = :ls_yyyymm
	using sqlmpms;
	
	em_laborcost.text = string(lc_laborcost)
else
	cb_cal.enabled = True
	cb_confirm.enabled = True
	cb_confirmcancel.enabled = True
	cb_close.enabled = True
end if

end event

type dw_mpm130u_03 from datawindow within w_mpm130u
integer x = 2208
integer y = 1392
integer width = 1367
integer height = 496
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm130u_03"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;
m_pop_mpms NewMenu
string ls_name, ls_data, ls_type, ls_col_type
str_mpms_parm lstr

lstr.w_parm = iw_this
lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[금형공정관리]-[소모성재료비수정]'
lstr.s_parm[3] = string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD')
lstr.s_parm[4] = f_relativedate(uf_mpms_addmonth(lstr.s_parm[3],1) + '01',-1)

message.PowerObjectParm = lstr
NewMenu = CREATE m_pop_mpms
//NewMenu.mf_get_dw(this, row, ls_name, ls_data)
//Popup Menu 조정

NewMenu.m_action.m_copy.enabled = False
NewMenu.m_action.m_matadd.enabled = False
NewMenu.m_action.m_subadd.enabled = True
NewMenu.m_action.m_modify.enabled = False
NewMenu.m_action.m_wccode.enabled = False
NewMenu.m_action.m_outcal.enabled = False

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

type st_2 from statictext within w_mpm130u
integer x = 23
integer y = 1320
integer width = 827
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "PartNo 별 상세공정 정보"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mpm130u
integer x = 2217
integer y = 1316
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
long backcolor = 12632256
string text = "소모성 원자재비"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_confirm from commandbutton within w_mpm130u
integer x = 3013
integer y = 48
integer width = 361
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "제작완료"
end type

event clicked;string ls_adjmonth, ls_rtncode

ls_adjmonth = uo_2.is_uo_month

DECLARE up_mpms_ingstatus_chk PROCEDURE FOR sp_mpms_ingstatus_chk  
        @ps_yyyymm = :ls_adjmonth,   
        @ps_empno = :g_s_empno 
		  using sqlmpms;

EXECUTE up_mpms_ingstatus_chk;

FETCH up_mpms_ingstatus_chk INTO :ls_rtncode;
CLOSE up_mpms_ingstatus_chk;

if ls_rtncode <> 'OK' then
	uo_status.st_message.text = "제작완료중에 에러가 발생하였습니다. CODE: " + ls_rtncode
else
	uo_status.st_message.text = "정상적으로 제작완료되었습니다."
end if

end event

type st_4 from statictext within w_mpm130u
integer x = 1792
integer y = 64
integer width = 238
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "인건비:"
boolean focusrectangle = false
end type

type em_laborcost from editmask within w_mpm130u
integer x = 2016
integer y = 48
integer width = 434
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,##0"
end type

type cb_close from commandbutton within w_mpm130u
integer x = 3794
integer y = 48
integer width = 416
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "마감확정"
end type

event clicked;string ls_currdt, ls_nextdt, ls_message
datetime ld_nowtime
integer li_net

li_net = MessageBox("알림", uo_2.is_uo_month + "월 마감확정이 되면 " &
		+ " 수정이 불가능합니다. 확정하시겠습니까? ", Exclamation!, OKCancel!, 2)
			
if li_net = 2 then
	return 0
end if

ls_currdt = mid(string(date(uo_2.is_uo_month + '.01'),'YYYYMMDD'),1,6)
ls_nextdt = uf_mpms_addmonth(ls_currdt, 1)

ld_nowtime = f_mpms_get_nowtime()
sqlmpms.AutoCommit = False

UPDATE TMONTHJOB  
	SET ResultFlag = 'C',   
		 LastEmp = :g_s_empno,   
		 LastDate = :ld_nowtime  
	WHERE TMONTHJOB.YearMm = :ls_currdt   
	using sqlmpms;

if sqlmpms.sqlnrows <> 1 then
	ls_message = 'ERR01'
	goto Rollback_
end if

SELECT COUNT(*) INTO :li_net
FROM TMONTHJOB
WHERE YEARMM = :ls_nextdt
using sqlmpms;

if li_net < 1 then
	INSERT INTO TMONTHJOB  
		( YearMm, LaborCost, ResultFlag, LastEmp, LastDate )  
		VALUES ( :ls_nextdt, 0, 'G', :g_s_empno, :ld_nowtime )  
		using sqlmpms;
	if sqlmpms.sqlcode <> 0 then
		ls_message = 'ERR02'
		goto Rollback_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True
iw_this.triggerevent("ue_retrieve")
uo_status.st_message.text = "정상적으로 마감확정이 되었습니다."
return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True
uo_status.st_message.text = "처리중에 에러가 발생하였습니다."
return 0



end event

type st_5 from statictext within w_mpm130u
integer x = 18
integer y = 172
integer width = 1138
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
string text = "재료비수정화면 => 오른쪽마우스버튼 사용"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_confirmcancel from commandbutton within w_mpm130u
integer x = 3397
integer y = 48
integer width = 361
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "완료취소"
end type

event clicked;string ls_adjmonth, ls_rtncode
integer li_net

ls_adjmonth = uo_2.is_uo_month
ls_adjmonth = ls_adjmonth + '.01'

li_net = MessageBox("확인", ls_adjmonth + " 월의 제작완료된 건을 취소하시겠습니까?", &
	Exclamation!, OKCancel!, 2)

IF li_net <> 1 THEN
	return -1
END IF

UPDATE torder
	SET ingstatus = '4', enddate = null
WHERE ingstatus = 'C' and 
	enddate = dateadd(dd,-1,dateadd(mm,1,convert(datetime, :ls_adjmonth)))
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	uo_status.st_message.text = "완료취소중에 에러가 발생하였습니다. CODE: " + ls_rtncode
else
	uo_status.st_message.text = "정상적으로 완료취소가 되었습니다."
end if
end event

type gb_1 from groupbox within w_mpm130u
integer x = 18
integer width = 4219
integer height = 160
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

