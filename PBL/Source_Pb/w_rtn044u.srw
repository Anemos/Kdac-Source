$PBExportHeader$w_rtn044u.srw
$PBExportComments$승인/결재 소급관리
forward
global type w_rtn044u from w_ipis_sheet01
end type
type st_1 from statictext within w_rtn044u
end type
type dw_rtn044u_01 from u_vi_std_datawindow within w_rtn044u
end type
type st_2 from statictext within w_rtn044u
end type
type dw_rtn044u_02 from u_vi_std_datawindow within w_rtn044u
end type
type cb_execute from commandbutton within w_rtn044u
end type
type st_3 from statictext within w_rtn044u
end type
type uo_from from uo_today_bom within w_rtn044u
end type
type st_4 from statictext within w_rtn044u
end type
type st_5 from statictext within w_rtn044u
end type
type uo_to from uo_today_bom within w_rtn044u
end type
type uo_1 from uo_plandiv_bom within w_rtn044u
end type
type uo_applydate from uo_today_bom within w_rtn044u
end type
type st_6 from statictext within w_rtn044u
end type
type gb_1 from groupbox within w_rtn044u
end type
type gb_2 from groupbox within w_rtn044u
end type
end forward

global type w_rtn044u from w_ipis_sheet01
st_1 st_1
dw_rtn044u_01 dw_rtn044u_01
st_2 st_2
dw_rtn044u_02 dw_rtn044u_02
cb_execute cb_execute
st_3 st_3
uo_from uo_from
st_4 st_4
st_5 st_5
uo_to uo_to
uo_1 uo_1
uo_applydate uo_applydate
st_6 st_6
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn044u w_rtn044u

type variables
// 담당 : 'PE', PL : 'PL', 팀장 : 'DL'
string is_chk_status
end variables

on w_rtn044u.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_rtn044u_01=create dw_rtn044u_01
this.st_2=create st_2
this.dw_rtn044u_02=create dw_rtn044u_02
this.cb_execute=create cb_execute
this.st_3=create st_3
this.uo_from=create uo_from
this.st_4=create st_4
this.st_5=create st_5
this.uo_to=create uo_to
this.uo_1=create uo_1
this.uo_applydate=create uo_applydate
this.st_6=create st_6
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_rtn044u_01
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_rtn044u_02
this.Control[iCurrent+5]=this.cb_execute
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.uo_from
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.uo_to
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.uo_applydate
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
end on

on w_rtn044u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_rtn044u_01)
destroy(this.st_2)
destroy(this.dw_rtn044u_02)
destroy(this.cb_execute)
destroy(this.st_3)
destroy(this.uo_from)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.uo_to)
destroy(this.uo_1)
destroy(this.uo_applydate)
destroy(this.st_6)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_rtn044u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_rtn044u_01.Height= ( newheight * 2 / 5 ) - dw_rtn044u_01.y

st_2.x = dw_rtn044u_01.x
st_2.y = dw_rtn044u_01.y + dw_rtn044u_01.Height + ls_split

dw_rtn044u_02.x = dw_rtn044u_01.x
dw_rtn044u_02.y = dw_rtn044u_01.y + dw_rtn044u_01.Height + st_2.Height + ls_split
dw_rtn044u_02.Width = dw_rtn044u_01.Width
dw_rtn044u_02.Height = newheight - ( st_2.y + st_2.Height + ls_status)
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

event ue_postopen;call super::ue_postopen;dw_rtn044u_01.settransobject(sqlca)
dw_rtn044u_02.settransobject(sqlca)
end event

event ue_retrieve;call super::ue_retrieve;// 담당 : 'PE', PL : 'PL', 팀장 : 'DL'
string ls_from, ls_to, ls_parm, ls_plant, ls_div
long ll_rowcnt

dw_rtn044u_01.reset()
dw_rtn044u_02.reset()

ls_parm    = uo_1.uf_Return()
ls_plant   = mid(ls_parm,1,1)
ls_div     = mid(ls_parm,2,1)
ls_from		=	string(date(uo_from.is_uo_date),"yyyy-mm-dd")
ls_to		=	string(f_relativedate(string(date(uo_to.is_uo_date),"yyyymmdd"),1),"@@@@-@@-@@")

if dw_rtn044u_01.retrieve( g_s_company, ls_plant, ls_div, ls_from, ls_to ) > 0 then
	dw_rtn044u_01.selectrow(0,false)
	dw_rtn044u_01.selectrow(1,true)
	dw_rtn044u_01.object.b_none.visible = True
	dw_rtn044u_01.object.b_yes.visible = False
else
	uo_status.st_message.text = "결재할 내용이 존재하지 않습니다."
end if

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_rtn044u
end type

type st_1 from statictext within w_rtn044u
integer x = 32
integer y = 260
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12639424
string text = "결재승인내역"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn044u_01 from u_vi_std_datawindow within w_rtn044u
integer x = 37
integer y = 352
integer width = 3269
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn044u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;call super::buttonclicked;string ls_colname
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'b_none' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','Y')
	next
	This.object.b_none.visible = False
	This.object.b_yes.visible = True
elseif ls_colname = 'b_yes' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','N')
	next
	This.object.b_none.visible = True
	This.object.b_yes.visible = False
end if

return 0
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_chtime, ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime
string ls_dlemp, ls_dlchk, ls_dltime, ls_itno, ls_plant, ls_dvsn, ls_line1, ls_line2

if currentrow < 1 then
	return 0
end if

dw_rtn044u_02.reset()
if this.getitemstring(currentrow,"gubun") = 'RTN018' then
	dw_rtn044u_02.dataobject = "d_rtn044u_02"
else
	dw_rtn044u_02.dataobject = "d_rtn044u_03"
end if
dw_rtn044u_02.settransobject(sqlca)

ls_plant = this.getitemstring(currentrow,"rhplant")
ls_dvsn = this.getitemstring(currentrow,"rhdvsn")
ls_itno = this.getitemstring(currentrow,"rhitno")
ls_line1 = this.getitemstring(currentrow,"line1")
ls_line2 = this.getitemstring(currentrow,"line2")
ls_inemp = this.getitemstring(currentrow,"rhinemp") + '%'
ls_inchk = this.getitemstring(currentrow,"rhinchk") + '%'
ls_intime = this.getitemstring(currentrow,"rhintime") + '%'
ls_plemp = this.getitemstring(currentrow,"rhplemp") + '%'
ls_plchk = this.getitemstring(currentrow,"rhplchk") + '%'
ls_pltime = this.getitemstring(currentrow,"rhpltime") + '%'
ls_dlemp = this.getitemstring(currentrow,"rhdlemp") + '%'
ls_dlchk = this.getitemstring(currentrow,"rhdlchk") + '%'
ls_dltime = this.getitemstring(currentrow,"rhdltime") + '%'
dw_rtn044u_02.retrieve(g_s_company,ls_plant,ls_dvsn,ls_itno,ls_line1,ls_line2, &
	ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime, ls_dlemp, ls_dlchk, ls_dltime)

return 0
end event

type st_2 from statictext within w_rtn044u
integer x = 32
integer y = 904
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "결재승인 세부정보"
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_rtn044u_02 from u_vi_std_datawindow within w_rtn044u
integer x = 37
integer y = 992
integer width = 3269
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn044u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;call super::buttonclicked;string ls_colname
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'b_none' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','Y')
	next
	This.object.b_none.visible = False
	This.object.b_yes.visible = True
elseif ls_colname = 'b_yes' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'sel_chk','N')
	next
	This.object.b_none.visible = True
	This.object.b_yes.visible = False
end if

return 0
end event

type cb_execute from commandbutton within w_rtn044u
integer x = 2208
integer y = 216
integer width = 745
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "적용일자 변경처리"
end type

event clicked;//********************
//* 1. 변경일자 검사 => 변경일자 와 '99991231' 사이에 존재하는 데이타가 없어야 한다.
//*

long ll_cnt, ll_chkcnt, ll_cnty, ll_rowcnty
string ls_gubun, ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_pltime
string ls_plant, ls_dvsn, ls_itno, ls_itno1, ls_line1, ls_line2, ls_opno
string ls_plchk, ls_dlemp, ls_dlchk, ls_dltime, ls_applydate, ls_nowtime, ls_message
string ls_min_edto, ls_min_edfm, ls_max_edto, ls_max_edfm, ls_apply_edto

setpointer(hourglass!)
ls_nowtime = f_get_systemdate(sqlca)
ls_applydate = string(date(uo_applydate.is_uo_date),"yyyymmdd")
ls_apply_edto = f_relativedate(ls_applydate,-1)

dw_rtn044u_01.accepttext()
if f_dateedit(ls_applydate) = space(8) then
	uo_status.st_message.text = "변경일자를 확인해 주십시요!"
	return -1
end if
if dw_rtn044u_01.rowcount() < 1 then
	uo_status.st_message.text = "선택된 행이 없습니다!"
	return -1
end if

SQLCA.AUTOCOMMIT = FALSE
for ll_cnt = 1 to dw_rtn044u_01.rowcount()
	if dw_rtn044u_01.getitemstring(ll_cnt,"sel_chk") <> 'Y' then
		Continue
	end if
	
	ls_plant = dw_rtn044u_01.getitemstring(ll_cnt, "rhplant")
	ls_dvsn = dw_rtn044u_01.getitemstring(ll_cnt, "rhdvsn")
	ls_itno = dw_rtn044u_01.getitemstring(ll_cnt, "rhitno")
	ls_line1 = dw_rtn044u_01.getitemstring(ll_cnt, "line1")
	ls_line2 = dw_rtn044u_01.getitemstring(ll_cnt, "line2")
	ls_gubun = dw_rtn044u_01.getitemstring(ll_cnt, "gubun")
	ls_inemp = dw_rtn044u_01.getitemstring(ll_cnt, "rhinemp")
	ls_inchk = dw_rtn044u_01.getitemstring(ll_cnt, "rhinchk")
	ls_intime = dw_rtn044u_01.getitemstring(ll_cnt, "rhintime")
	ls_plemp = dw_rtn044u_01.getitemstring(ll_cnt, "rhplemp")
	ls_plchk = dw_rtn044u_01.getitemstring(ll_cnt, "rhplchk")
	ls_pltime = dw_rtn044u_01.getitemstring(ll_cnt, "rhpltime")
	ls_dlemp = dw_rtn044u_01.getitemstring(ll_cnt, "rhdlemp")
	ls_dlchk = dw_rtn044u_01.getitemstring(ll_cnt, "rhdlchk")
	ls_dltime = dw_rtn044u_01.getitemstring(ll_cnt, "rhdltime")
	
	if ls_gubun = 'RTN018' then
		dw_rtn044u_02.reset()
		dw_rtn044u_02.dataobject = "d_rtn044u_02"
		dw_rtn044u_02.settransobject(sqlca)
		
		ll_rowcnty =  dw_rtn044u_02.retrieve(g_s_company,ls_plant,ls_dvsn,ls_itno,ls_line1,ls_line2, &
		   ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime, ls_dlemp, ls_dlchk, ls_dltime)
		
		for ll_cnty = 1 to ll_rowcnty
			ls_itno1 = dw_rtn044u_02.getitemstring(ll_cnty,"rtn018_rhitno1")
			//*
			//* 최종승인일자에 해당하는  완료일자, 적용일자 가져오기
			SELECT MIN(RHEDFM), MIN(RHEDTO),MAX(RHEDFM), MAX(RHEDTO)
			INTO :ls_min_edfm, :ls_min_edto, :ls_max_edfm, :ls_max_edto
			FROM PBRTN.RTN018
			WHERE RHCMCD = :g_s_company AND RHPLANT = :ls_plant AND
				RHDVSN = :ls_dvsn AND RHITNO = :ls_itno AND RHITNO1 = :ls_itno1 AND
				RHINEMP = :ls_inemp AND RHINTIME = :ls_intime AND 
				RHPLEMP = :ls_plemp AND RHPLTIME = :ls_pltime AND
				RHDLEMP = :ls_dlemp AND RHDLTIME = :ls_dltime
			using sqlca;
			
			SELECT COUNT(*) INTO :ll_chkcnt
			FROM PBRTN.RTN018
			WHERE RHCMCD = :g_s_company AND RHPLANT = :ls_plant AND
				RHDVSN = :ls_dvsn AND RHITNO = :ls_itno AND RHITNO1 = :ls_itno1 AND
				RHEDFM >= :ls_applydate AND RHEDFM < :ls_max_edfm
			using sqlca;
			
			if ll_chkcnt > 0 then
				ls_message = "RTN018 변경일자와 최종적용일자 사이에 변경이력이 존재합니다. :" + ls_itno
				goto Rollback_
			end if
			
			SELECT COUNT(*) INTO :ll_chkcnt 
			FROM PBRTN.RTN015
			WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND REDVSN = :ls_dvsn AND
					REITNO = :ls_itno1 AND 
					((REEDTO = '99991231' AND REEDFM <= :ls_applydate) OR
					 (REEDFM >= :ls_applydate AND REEDTO <= :ls_applydate))
			using sqlca;
			
			if ll_chkcnt > 0 then
				ls_message = "RTN015 변경일자와 최종적용일자 사이에 변경이력이 존재합니다. :" + ls_itno1
				goto Rollback_
			end if
			
			// 변경전 데이타 완료일자 변경
			if ls_min_edto <> '99991231' then
				UPDATE PBRTN.RTN018
				SET RHEDTO = :ls_apply_edto, RHEPNO = :g_s_empno, RHSYDT = :g_s_date
				WHERE RHCMCD = :g_s_company AND RHPLANT = :ls_plant AND
					RHDVSN = :ls_dvsn AND RHITNO = :ls_itno AND RHITNO1 = :ls_itno1 AND
					RHEDTO = :ls_min_edto AND
					RHINEMP = :ls_inemp AND RHINTIME = :ls_intime AND 
					RHPLEMP = :ls_plemp AND RHPLTIME = :ls_pltime AND
					RHDLEMP = :ls_dlemp AND RHDLTIME = :ls_dltime
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN018 변경전 데이타 완료일자 변경시에 오류가 발행하였습니다 :" + ls_itno
					goto Rollback_
				end if
			end if
			
			// 변경후 데이타 적용일자 변경
			UPDATE PBRTN.RTN018
			SET RHEDFM = :ls_applydate, RHEPNO = :g_s_empno, RHSYDT = :g_s_date
			WHERE RHCMCD = :g_s_company AND RHPLANT = :ls_plant AND
				RHDVSN = :ls_dvsn AND RHITNO = :ls_itno AND RHITNO1 = :ls_itno1 AND
				RHEDFM = :ls_max_edfm AND
				RHINEMP = :ls_inemp AND RHINTIME = :ls_intime AND 
				RHPLEMP = :ls_plemp AND RHPLTIME = :ls_pltime AND
				RHDLEMP = :ls_dlemp AND RHDLTIME = :ls_dltime
			using sqlca;
			
			if sqlca.sqlnrows < 1 then
				ls_message = "RTN018 변경전 데이타 적용일자 변경시에 오류가 발행하였습니다 :" + ls_itno
				goto Rollback_
			end if
			
			SELECT COUNT(*) INTO :ll_chkcnt
			FROM PBRTN.RTN011
			WHERE RACMCD ='01' AND RAPLANT = :ls_plant AND
				RADVSN = :ls_dvsn AND RAITNO = :ls_itno AND RAITNO1 = :ls_itno1 AND
				RAINEMP = :ls_inemp AND RAINTIME = :ls_intime AND 
				RAPLEMP = :ls_plemp AND RAPLTIME = :ls_pltime AND
				RADLEMP = :ls_dlemp AND RADLTIME = :ls_dltime
			using sqlca;
			
			if ll_chkcnt > 0 then
				UPDATE PBRTN.RTN011
				SET RAEDFM = :ls_applydate, RAEPNO = :g_s_empno, RASYDT = :g_s_date
				WHERE RACMCD ='01' AND RAPLANT = :ls_plant AND
					RADVSN = :ls_dvsn AND RAITNO = :ls_itno AND RAITNO1 = :ls_itno1 AND
					RAINEMP = :ls_inemp AND RAINTIME = :ls_intime AND 
					RAPLEMP = :ls_plemp AND RAPLTIME = :ls_pltime AND
					RADLEMP = :ls_dlemp AND RADLTIME = :ls_dltime
				using sqlca;
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN011 변경전 데이타 적용일자 변경시에 오류가 발행하였습니다 :" + ls_itno
					goto Rollback_
				end if
			end if
		next
	else
		dw_rtn044u_02.reset()
		dw_rtn044u_02.dataobject = "d_rtn044u_03"
		dw_rtn044u_02.settransobject(sqlca)
		ll_rowcnty =  dw_rtn044u_02.retrieve(g_s_company,ls_plant,ls_dvsn,ls_itno,ls_line1,ls_line2, &
		   ls_inemp, ls_inchk, ls_intime, ls_plemp, ls_plchk, ls_pltime, ls_dlemp, ls_dlchk, ls_dltime)
		
		for ll_cnty = 1 to ll_rowcnty
			ls_opno = dw_rtn044u_02.getitemstring(ll_cnty,"reopno")
			//*
			//* 최종승인일자에 해당하는  완료일자, 적용일자 가져오기
			SELECT MIN(REEDFM), MIN(REEDTO),MAX(REEDFM), MAX(REEDTO)
			INTO :ls_min_edfm, :ls_min_edto, :ls_max_edfm, :ls_max_edto
			FROM PBRTN.RTN015
			WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND
				REDVSN = :ls_dvsn AND REITNO = :ls_itno AND
				RELINE1 = :ls_line1 AND RELINE2 = :ls_line2 AND REOPNO = :ls_opno AND
				REINEMP = :ls_inemp AND REINTIME = :ls_intime AND 
				REPLEMP = :ls_plemp AND REPLTIME = :ls_pltime AND
				REDLEMP = :ls_dlemp AND REDLTIME = :ls_dltime
			using sqlca;
			
			SELECT COUNT(*) INTO :ll_chkcnt
			FROM PBRTN.RTN015
			WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND
				REDVSN = :ls_dvsn AND REITNO = :ls_itno AND
				RELINE1 = :ls_line1 AND RELINE2 = :ls_line2 AND REOPNO = :ls_opno AND
				REEDFM >= :ls_applydate AND REEDFM < :ls_max_edfm
			using sqlca;
			
			if ll_chkcnt > 0 then
				ls_message = "RTN015 변경일자와 최종적용일자 사이에 변경이력이 존재합니다. :" + ls_itno
				goto Rollback_
			end if
			
			SELECT COUNT(*) INTO :ll_chkcnt
			FROM PBRTN.RTN018
			WHERE RHCMCD = :g_s_company AND RHPLANT = :ls_plant AND
				RHDVSN = :ls_dvsn AND RHITNO1 = :ls_itno AND
				((RHEDTO = '99991231' AND RHEDFM <= :ls_applydate) OR
				 (RHEDFM >= :ls_applydate AND RHEDTO <= :ls_applydate))
			using sqlca;
			
			if ll_chkcnt > 0 then
				ls_message = "RTN018 변경일자와 최종적용일자 사이에 변경이력이 존재합니다. :" + ls_itno
				goto Rollback_
			end if
			
			// 변경전 데이타 완료일자 변경
			if ls_min_edto <> '99991231' then
				UPDATE PBRTN.RTN015
				SET REEDTO = :ls_apply_edto, REEPNO = :g_s_empno, REUPDT = :g_s_date
				WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND
					REDVSN = :ls_dvsn AND REITNO = :ls_itno AND REOPNO = :ls_opno AND
					RELINE1 = :ls_line1 AND RELINE2 = :ls_line2 AND REEDTO = :ls_min_edto AND
					REINEMP = :ls_inemp AND REINTIME = :ls_intime AND 
					REPLEMP = :ls_plemp AND REPLTIME = :ls_pltime AND
					REDLEMP = :ls_dlemp AND REDLTIME = :ls_dltime
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN015 변경전 데이타 완료일자 변경시에 오류가 발행하였습니다 :" + ls_itno
					goto Rollback_
				end if
			end if
			
			// 변경후 데이타 적용일자 변경
			UPDATE PBRTN.RTN015
			SET REEDFM = :ls_applydate, REEPNO = :g_s_empno, REUPDT = :g_s_date
			WHERE RECMCD = :g_s_company AND REPLANT = :ls_plant AND
				REDVSN = :ls_dvsn AND REITNO = :ls_itno AND REOPNO = :ls_opno AND
				RELINE1 = :ls_line1 AND RELINE2 = :ls_line2 AND REEDFM = :ls_max_edfm AND
				REINEMP = :ls_inemp AND REINTIME = :ls_intime AND 
				REPLEMP = :ls_plemp AND REPLTIME = :ls_pltime AND
				REDLEMP = :ls_dlemp AND REDLTIME = :ls_dltime
			using sqlca;
			
			if sqlca.sqlnrows < 1 then
				ls_message = "RTN015 변경전 데이타 적용일자 변경시에 오류가 발행하였습니다 :" + ls_itno
				goto Rollback_
			end if
			
			SELECT COUNT(*) INTO :ll_chkcnt
			FROM PBRTN.RTN013
			WHERE RCCMCD = :g_s_company AND RCPLANT = :ls_plant AND
				RCDVSN = :ls_dvsn AND RCITNO = :ls_itno AND RCOPNO = :ls_opno AND
				RCLINE1 = :ls_line1 AND RCLINE2 = :ls_line2 AND
				RCINEMP = :ls_inemp AND RCINTIME = :ls_intime AND 
				RCPLEMP = :ls_plemp AND RCPLTIME = :ls_pltime AND
				RCDLEMP = :ls_dlemp AND RCDLTIME = :ls_dltime
			using sqlca;
			
			if ll_chkcnt > 0 then
				UPDATE PBRTN.RTN013
				SET RCEDFM = :ls_applydate, RCEPNO = :g_s_empno, RCUPDT = :g_s_date
				WHERE RCCMCD = :g_s_company AND RCPLANT = :ls_plant AND
					RCDVSN = :ls_dvsn AND RCITNO = :ls_itno AND RCOPNO = :ls_opno AND
					RCLINE1 = :ls_line1 AND RCLINE2 = :ls_line2 AND
					RCINEMP = :ls_inemp AND RCINTIME = :ls_intime AND 
					RCPLEMP = :ls_plemp AND RCPLTIME = :ls_pltime AND
					RCDLEMP = :ls_dlemp AND RCDLTIME = :ls_dltime
				using sqlca;
				if sqlca.sqlnrows < 1 then
					ls_message = "RTN013 변경전 데이타 적용일자 변경시에 오류가 발행하였습니다 :" + ls_itno
					goto Rollback_
				end if
			end if
			//*** 부대작업 적용일자 변경
			// 변경전 데이타 완료일자 변경
			if ls_min_edto <> '99991231' then
				UPDATE PBRTN.RTN016
				SET RFEDTO = :ls_apply_edto, RFEPNO = :g_s_empno, RFUPDT = :g_s_date
				WHERE RFCMCD = :g_s_company AND RFPLANT = :ls_plant AND
					RFDVSN = :ls_dvsn AND RFITNO = :ls_itno AND RFOPNO = :ls_opno AND
					RFLINE1 = :ls_line1 AND RFLINE2 = :ls_line2 AND RFEDTO = :ls_min_edto
				using sqlca;
			end if
			// 변경후 데이타 적용일자 변경
			UPDATE PBRTN.RTN016
			SET RFEDFM = :ls_applydate, RFEPNO = :g_s_empno, RFUPDT = :g_s_date
			WHERE RFCMCD = :g_s_company AND RFPLANT = :ls_plant AND
				RFDVSN = :ls_dvsn AND RFITNO = :ls_itno AND RFOPNO = :ls_opno AND
				RFLINE1 = :ls_line1 AND RFLINE2 = :ls_line2 AND RFEDFM = :ls_max_edfm
			using sqlca;
			
			UPDATE PBRTN.RTN014
			SET RDEDFM = :ls_applydate, RDEPNO = :g_s_empno, RDUPDT = :g_s_date
			WHERE RDCMCD = :g_s_company AND RDPLANT = :ls_plant AND
				RDDVSN = :ls_dvsn AND RDITNO = :ls_itno AND RDOPNO = :ls_opno AND
				RDLINE1 = :ls_line1 AND RDLINE2 = :ls_line2 AND
				RDEDFM = :ls_max_edfm
			using sqlca;
			//*** 장비정보 적용일자 변경
			UPDATE PBRTN.RTN017
			SET RGEDFM = :ls_applydate, RGEPNO = :g_s_empno, RGUPDT = :g_s_date
			WHERE RGCMCD = :g_s_company AND RGPLANT = :ls_plant AND
				RGDVSN = :ls_dvsn AND RGITNO = :ls_itno AND RGOPNO = :ls_opno AND
				RGLINE1 = :ls_line1 AND RGLINE2 = :ls_line2 AND
				RGEDFM = :ls_max_edfm
			using sqlca;
		next
	end if
	COMMIT USING SQLCA;
next

SQLCA.AUTOCOMMIT = TRUE
iw_this.Triggerevent('ue_retrieve')
	
uo_status.st_message.text = '정상적으로 처리되었습니다.'
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
end event

type st_3 from statictext within w_rtn044u
integer x = 1431
integer y = 60
integer width = 283
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
string text = "시작일자"
boolean focusrectangle = false
end type

type uo_from from uo_today_bom within w_rtn044u
integer x = 1733
integer y = 56
integer taborder = 30
boolean bringtotop = true
end type

on uo_from.destroy
call uo_today_bom::destroy
end on

type st_4 from statictext within w_rtn044u
integer x = 2190
integer y = 64
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

type st_5 from statictext within w_rtn044u
integer x = 2272
integer y = 64
integer width = 274
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
string text = "완료일자"
boolean focusrectangle = false
end type

type uo_to from uo_today_bom within w_rtn044u
integer x = 2560
integer y = 56
integer taborder = 40
boolean bringtotop = true
end type

on uo_to.destroy
call uo_today_bom::destroy
end on

type uo_1 from uo_plandiv_bom within w_rtn044u
integer x = 82
integer y = 40
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type uo_applydate from uo_today_bom within w_rtn044u
integer x = 1477
integer y = 220
integer taborder = 40
boolean bringtotop = true
end type

on uo_applydate.destroy
call uo_today_bom::destroy
end on

type st_6 from statictext within w_rtn044u
integer x = 1019
integer y = 224
integer width = 443
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "변경적용일자"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_rtn044u
integer x = 27
integer y = 4
integer width = 3067
integer height = 168
integer taborder = 10
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_rtn044u
integer x = 869
integer y = 164
integer width = 2226
integer height = 172
integer taborder = 50
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

