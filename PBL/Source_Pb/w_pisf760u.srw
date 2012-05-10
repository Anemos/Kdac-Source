$PBExportHeader$w_pisf760u.srw
$PBExportComments$수불정리
forward
global type w_pisf760u from w_cmms_sheet01
end type
type uo_area from u_cmms_select_area within w_pisf760u
end type
type uo_division from u_cmms_select_division within w_pisf760u
end type
type dw_2 from datawindow within w_pisf760u
end type
type dw_3 from datawindow within w_pisf760u
end type
type rb_release from radiobutton within w_pisf760u
end type
type rb_return from radiobutton within w_pisf760u
end type
type cb_1 from commandbutton within w_pisf760u
end type
type cb_2 from commandbutton within w_pisf760u
end type
type cb_3 from commandbutton within w_pisf760u
end type
type gb_1 from groupbox within w_pisf760u
end type
end forward

global type w_pisf760u from w_cmms_sheet01
integer width = 4782
integer height = 2732
uo_area uo_area
uo_division uo_division
dw_2 dw_2
dw_3 dw_3
rb_release rb_release
rb_return rb_return
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
gb_1 gb_1
end type
global w_pisf760u w_pisf760u

type variables
transaction sqlinterface

string i_s_gubun
end variables

on w_pisf760u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
this.dw_3=create dw_3
this.rb_release=create rb_release
this.rb_return=create rb_return
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.rb_release
this.Control[iCurrent+6]=this.rb_return
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.gb_1
end on

on w_pisf760u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.rb_release)
destroy(this.rb_return)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt

if rb_release.checked = true then
	i_s_gubun = '1'
	//dw_2.dataobject = 'd_pisf060u_02'
	dw_2.settransobject(sqlcmms)
	ll_rowcnt = dw_2.retrieve(gs_kmarea,gs_kmdivision)
else
	i_s_gubun = '2'
	//dw_2.dataobject = 'd_pisf060u_04'
	dw_2.settransobject(sqlcmms)
	ll_rowcnt = dw_2.retrieve(gs_kmarea,gs_kmdivision)
end if
end event

event open;call super::open;sqlinterface = CREATE transaction
sqlinterface.DBMS       = "MSS Microsoft SQL Server 6.x"
sqlinterface.ServerName = "121.182.130.30,1433"
sqlinterface.Database   = "IPIS"
sqlinterface.Database   = "INTERFACE"
sqlinterface.LogID      = "sa"
sqlinterface.LogPass    = "goipis"
sqlinterface.DbParm     = "appname='IPIS for KDAC, CommitOnDisconnect='No'"
sqlinterface.AutoCommit = True
	
Connect Using sqlinterface;
if sqlinterface.sqlcode <> 0 then
	messagebox("error","interface database connection error!")
end if

dw_3.settransobject(sqlca)

rb_release.checked = true

end event

event ue_delete;call super::ue_delete;//long ll_selrow, ll_rtn
//integer li_logid
//string ls_areacode, ls_divisioncode, ls_itemcode, ls_slipno
//dec{1} lc_qty
//
//ll_selrow = dw_2.getselectedrow(0)
//
//if ll_selrow < 1 then
//	uo_status.st_message.text = "삭제할 데이타가 없습니다."
//	return 0
//end if
//
//ll_rtn = MessageBox("확인", "선택된 데이타를 인터페이스와 CMMS서버에서 삭제하시겠습니까?",Question!, OKCancel!, 2)
//if ll_rtn = 2 then
//	return 0
//end if
//
//li_logid = dw_2.getitemdecimal(ll_selrow,"logid")
//ls_areacode = dw_2.getitemstring(ll_selrow,"areacode")
//ls_divisioncode = dw_2.getitemstring(ll_selrow,"divisioncode")
//ls_itemcode = dw_2.getitemstring(ll_selrow,"itemcode")
//ls_slipno = dw_2.getitemstring(ll_selrow,"slipno")
//if i_s_gubun = '1' then
//	lc_qty = dw_2.getitemdecimal(ll_selrow,"releaseqty")
//else
//	lc_qty = dw_2.getitemdecimal(ll_selrow,"returnqty")
//end if
//
//dw_2.deleterow(ll_selrow)
//
////인터페이스 데이타 삭제
//
//if dw_2.update() <> 1 then
//	uo_status.st_message.text = "인터페이스DB에서 삭제가 실패했습니다."
//	return 0
//end if
////CMMS 서버에서 데이타 삭제
//if i_s_gubun = '1' then
//	delete from part_out
//	where area_code = :ls_areacode and
//			factory_code = :ls_divisioncode and
//			part_code = :ls_itemcode and
//			part_tag = :ls_slipno using sqlcmms;
//else
//	delete from part_return
//	where area_code = :ls_areacode and
//			factory_code = :ls_divisioncode and
//			part_code = :ls_itemcode and
//			part_tag = :ls_slipno using sqlcmms;		
//end if
//if sqlcmms.sqlcode <> 0 then
//	uo_status.st_message.text = "CMMS 서버에서 삭제가 실패했습니다."
//	return 0
//end if
//
//uo_status.st_message.text = "삭제가 완료되었습니다."
//return 0
//
end event

event ue_save;call super::ue_save;int li_rtn
long ll_rowcnt, ll_cnt
string ls_xplant, ls_div, ls_itno, ls_wloc, ls_mcno
dec{1} lc_ohuqty, lc_ohrqty, lc_ohsqty, lc_exqty
dec{1} lc_asmaxq, lc_asminq
string ls_msg

li_rtn = MessageBox("확인", "자재공무재고를 설비로 업데이트하시겠습니까?", Exclamation!, OKCancel!, 2)

if li_rtn = 2 then
	return 0
end if
setpointer(hourglass!)
ll_rowcnt = dw_3.rowcount()

sqlcmms.AutoCommit = False
for ll_cnt = 1 to ll_rowcnt
	ls_xplant = trim(dw_3.getitemstring(ll_cnt, "xplant"))
	ls_div = trim(dw_3.getitemstring(ll_cnt,"div"))
	ls_itno = trim(dw_3.getitemstring(ll_cnt,"itno"))
	lc_ohuqty = dw_3.getitemdecimal(ll_cnt,"ohuqty")
	lc_ohrqty = dw_3.getitemdecimal(ll_cnt,"ohrqty")
	lc_ohsqty = dw_3.getitemdecimal(ll_cnt,"ohsqty")
	lc_exqty = dw_3.getitemdecimal(ll_cnt,"exqty")

	lc_asmaxq = dw_3.getitemdecimal(ll_cnt,"maxq")
	lc_asminq = dw_3.getitemdecimal(ll_cnt,"minq")
	ls_wloc = trim(dw_3.getitemstring(ll_cnt,"wloc"))
	ls_mcno = trim(dw_3.getitemstring(ll_cnt,"mcno"))
	
	update part_master
	set normal_qty = :lc_ohuqty, repair_qty = :lc_ohrqty, 
		scram_qty = :lc_ohsqty, etc_qty = :lc_exqty, 
		maxq = :lc_asmaxq, minq = :lc_asminq, part_location = :ls_wloc
	where area_code = :gs_kmarea and factory_code = :gs_kmdivision 
			and part_code = :ls_itno
	using sqlcmms;
	
	if sqlcmms.sqlcode <> 0 or sqlcmms.sqlnrows < 1 then
		ls_msg = sqlcmms.sqlerrtext
		RollBack USING sqlcmms;
		sqlcmms.AutoCommit = true
		messagebox("Update_error","에러 : " + ls_msg)
		return 0
	end if
	
	delete from equip_spare
	where area_code = :gs_kmarea and factory_code = :gs_kmdivision 
			and part_code = :ls_itno //and equip_code = :ls_mcno 
	using sqlcmms;
	
	if sqlcmms.sqlcode <> 0 then
		ls_msg = sqlcmms.sqlerrtext
		RollBack USING sqlcmms;
		sqlcmms.AutoCommit = false
		messagebox("delete_error","에러 : " + ls_msg)
		return 0
	end if

	if not (ls_mcno = '' or isnull(ls_mcno)) then
		insert into equip_spare (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
		values (:gs_kmarea, :gs_kmdivision, :ls_mcno, :ls_itno, 0, 'D')
		using sqlcmms;

		if sqlcmms.sqlcode <> 0 then
			ls_msg = sqlcmms.sqlerrtext
			RollBack USING sqlcmms;
			sqlcmms.AutoCommit = false
			messagebox("insert_error","에러 : " + ls_msg)
			return 0
		end if
	end if
	Commit USING sqlcmms;
next

sqlcmms.AutoCommit = true
uo_status.st_message.text = "실행완료!"


end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf760u
integer x = 5
integer y = 2524
end type

type uo_area from u_cmms_select_area within w_pisf760u
integer x = 69
integer y = 32
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_cmms_select_area::destroy
end on

event ue_select;call super::ue_select;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

uo_division.triggerevent('ue_select')
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

type uo_division from u_cmms_select_division within w_pisf760u
integer x = 613
integer y = 32
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type dw_2 from datawindow within w_pisf760u
integer x = 37
integer y = 132
integer width = 1883
integer height = 2276
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf060u_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

event doubleclicked;string ls_areacode, ls_divisioncode, ls_itemcode

ls_areacode = This.getitemstring(row,"area_code")
ls_divisioncode = This.getitemstring(row,"factory_code")
ls_itemcode = This.getitemstring(row,"part_code")

dw_3.retrieve(ls_areacode,ls_divisioncode)


end event

type dw_3 from datawindow within w_pisf760u
integer x = 1947
integer y = 132
integer width = 2565
integer height = 2268
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf060u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_release from radiobutton within w_pisf760u
integer x = 1381
integer y = 40
integer width = 416
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "자재불출"
end type

type rb_return from radiobutton within w_pisf760u
integer x = 1847
integer y = 40
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "자재반납"
end type

type cb_1 from commandbutton within w_pisf760u
integer x = 2432
integer y = 20
integer width = 457
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "비교"
end type

event clicked;long ll_rowcnt, ll_cnt, ll_findrow
string ls_partcode, ls_equipcode, ls_location, ls_wloc, ls_mcno
dec{1} lc_normal, lc_ohuqty, lc_repair, lc_ohrqty, lc_scram, lc_ohsqty
dec{1} lc_etc, lc_exqty, lc_maxq, lc_minq, lc_asmaxq, lc_asminq

setpointer(HourGlass!)
ll_rowcnt = dw_2.rowcount()

for ll_cnt = 1 to ll_rowcnt
	ls_partcode = dw_2.getitemstring(ll_cnt, "part_code")
	lc_normal = dw_2.getitemdecimal(ll_cnt,"normal_qty")
	lc_repair = dw_2.getitemdecimal(ll_cnt,"repair_qty")
	lc_scram = dw_2.getitemdecimal(ll_cnt,"scram_qty")
	lc_etc = dw_2.getitemdecimal(ll_cnt,"etc_qty")
	lc_maxq = dw_2.getitemdecimal(ll_cnt,"maxq")
	lc_minq = dw_2.getitemdecimal(ll_cnt,"minq")
	ls_location = trim(dw_2.getitemstring(ll_cnt,"part_location"))
	ls_equipcode = trim(dw_2.getitemstring(ll_cnt,"equip_code"))
	
	ll_findrow = dw_3.find("itno = '" + ls_partcode + "'", 1, dw_3.rowcount())
	if ll_findrow <= 0 then
		continue
	end if

	lc_ohuqty = dw_3.getitemdecimal(ll_findrow,"ohuqty")
	lc_ohrqty = dw_3.getitemdecimal(ll_findrow,"ohrqty")
	lc_ohsqty = dw_3.getitemdecimal(ll_findrow,"ohsqty")
	lc_exqty = dw_3.getitemdecimal(ll_findrow,"exqty")
	lc_asmaxq = dw_3.getitemdecimal(ll_findrow,"maxq")
	lc_asminq = dw_3.getitemdecimal(ll_findrow,"minq")
	ls_wloc = trim(dw_3.getitemstring(ll_findrow,"wloc"))
	ls_mcno = trim(dw_3.getitemstring(ll_findrow,"mcno"))

	if lc_normal <> lc_ohuqty or lc_repair <> lc_ohrqty or lc_scram <> lc_ohsqty &
		or lc_etc <> lc_exqty or lc_maxq <> lc_asmaxq or lc_minq <> lc_asminq or ls_location <> ls_wloc &
		or ls_equipcode <> ls_mcno then
		dw_2.setitem(ll_cnt, "area_code", 'X')
		dw_3.setitem(ll_findrow, "xplant", 'X')
	end if
	
//	if lc_normal <> lc_ohuqty or lc_repair <> lc_ohrqty or lc_scram <> lc_ohsqty &
//		or lc_etc <> lc_exqty or lc_maxq <> lc_asmaxq or lc_minq <> lc_asminq or ls_location <> ls_wloc &
//		or (ls_mcno <> '' and isnull(ls_mcno) and ls_equipcode <> ls_mcno) then
//		dw_2.setitem(ll_cnt, "area_code", 'X')
//		dw_3.setitem(ll_findrow, "xplant", 'X')
//	end if
//	if lc_normal <> lc_ohuqty or lc_repair <> lc_ohrqty or lc_scram <> lc_ohsqty &
//		or lc_etc <> lc_exqty then
//		dw_2.setitem(ll_cnt, "area_code", 'X')
//		dw_3.setitem(ll_findrow, "xplant", 'X')
//	end if	
next

setpointer(Arrow!)
uo_status.st_message.text = "작업완료"
end event

type cb_2 from commandbutton within w_pisf760u
integer x = 2939
integer y = 24
integer width = 457
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "필터"
end type

event clicked;dw_2.SetRedraw(false)
dw_2.setfilter("area_code = 'X'")
dw_2.Filter()
dw_2.SetRedraw(true)

dw_3.SetRedraw(false)
dw_3.setfilter("xplant = 'X'")
dw_3.Filter()
dw_3.SetRedraw(true)
end event

type cb_3 from commandbutton within w_pisf760u
integer x = 3479
integer y = 24
integer width = 457
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "필터취소"
end type

event clicked;dw_2.SetRedraw(false)
dw_2.setfilter("")
dw_2.Filter()
dw_2.SetRedraw(true)

dw_3.SetRedraw(false)
dw_3.setfilter("")
dw_3.Filter()
dw_3.SetRedraw(true)
end event

type gb_1 from groupbox within w_pisf760u
integer x = 1248
integer y = 4
integer width = 1074
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

