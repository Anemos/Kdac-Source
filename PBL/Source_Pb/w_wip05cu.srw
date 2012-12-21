$PBExportHeader$w_wip05cu.srw
$PBExportComments$클레임계산(외개)
forward
global type w_wip05cu from w_origin_sheet05
end type
type uo_1 from uo_wip_plandiv within w_wip05cu
end type
type uo_to from uo_yymm_boongi within w_wip05cu
end type
type st_1 from statictext within w_wip05cu
end type
type pb_1 from picturebutton within w_wip05cu
end type
type st_2 from statictext within w_wip05cu
end type
type st_3 from statictext within w_wip05cu
end type
type dw_wip05cu_01 from u_vi_std_datawindow within w_wip05cu
end type
type dw_wip05cu_02 from u_vi_std_datawindow within w_wip05cu
end type
type dw_2 from datawindow within w_wip05cu
end type
type rb_free from radiobutton within w_wip05cu
end type
type rb_cost from radiobutton within w_wip05cu
end type
type gb_1 from groupbox within w_wip05cu
end type
end forward

global type w_wip05cu from w_origin_sheet05
uo_1 uo_1
uo_to uo_to
st_1 st_1
pb_1 pb_1
st_2 st_2
st_3 st_3
dw_wip05cu_01 dw_wip05cu_01
dw_wip05cu_02 dw_wip05cu_02
dw_2 dw_2
rb_free rb_free
rb_cost rb_cost
gb_1 gb_1
end type
global w_wip05cu w_wip05cu

type variables
string is_adjdt
end variables

on w_wip05cu.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_to=create uo_to
this.st_1=create st_1
this.pb_1=create pb_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_wip05cu_01=create dw_wip05cu_01
this.dw_wip05cu_02=create dw_wip05cu_02
this.dw_2=create dw_2
this.rb_free=create rb_free
this.rb_cost=create rb_cost
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_to
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_wip05cu_01
this.Control[iCurrent+8]=this.dw_wip05cu_02
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.rb_free
this.Control[iCurrent+11]=this.rb_cost
this.Control[iCurrent+12]=this.gb_1
end on

on w_wip05cu.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_to)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_wip05cu_01)
destroy(this.dw_wip05cu_02)
destroy(this.dw_2)
destroy(this.rb_free)
destroy(this.rb_cost)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;dec{0} ld_yyyymm
string ls_fromdt,ls_todt, ls_plant, ls_dvsn, ls_part, ls_iocd
long ll_rowcnt

dw_wip05cu_01.reset()
dw_wip05cu_02.reset()
dw_2.reset()

ld_yyyymm     = uo_to.uf_yyyymm()
is_adjdt        = string(ld_yyyymm)
ls_fromdt      = uf_wip_addmonth(is_adjdt,-2)
ls_plant = trim(uo_1.dw_1.getitemstring(1,'xplant'))
ls_dvsn  = trim(uo_1.dw_1.getitemstring(1,'div'))

if rb_free.checked then
	ls_iocd = '2'
else
	ls_iocd = '3'
end if

//정산년월 체크
if f_wip_check_stdt( g_s_company, is_adjdt ) then
	pb_1.enabled = true
else
	pb_1.enabled = false
end if

if f_spacechk(ls_plant) = -1 then
	ls_plant = '%'
else
	ls_plant = ls_plant + '%'
end if
if f_spacechk(ls_dvsn) = -1 then
	ls_dvsn = '%'
else
	ls_dvsn = ls_dvsn + '%'
end if

dw_wip05cu_01.retrieve(mid(is_adjdt,1,4), mid(is_adjdt,5,2), '01', ls_plant, ls_dvsn, ls_iocd)
dw_wip05cu_02.retrieve(mid(is_adjdt,1,4), mid(is_adjdt,5,2), '01', ls_plant, ls_dvsn, ls_iocd)
dw_2.retrieve(mid(is_adjdt,1,4), mid(is_adjdt,5,2), ls_iocd)

uo_status.st_message.text = '조회되었습니다.'

return 0
end event

event open;call super::open;
dw_wip05cu_01.settransobject(sqlca)
dw_wip05cu_02.settransobject(sqlca)
dw_2.settransobject(sqlca)
end event

type uo_status from w_origin_sheet05`uo_status within w_wip05cu
end type

type uo_1 from uo_wip_plandiv within w_wip05cu
event destroy ( )
integer x = 73
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type uo_to from uo_yymm_boongi within w_wip05cu
event destroy ( )
integer x = 1714
integer y = 68
integer taborder = 40
boolean bringtotop = true
end type

on uo_to.destroy
call uo_yymm_boongi::destroy
end on

type st_1 from statictext within w_wip05cu
integer x = 1344
integer y = 80
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_wip05cu
integer x = 2075
integer y = 1024
integer width = 338
integer height = 480
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\userright.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long	ll_SaveRow[] 
string ls_plant, ls_dvsn, ls_vendor, ls_rtncd, ls_cttp, ls_year, ls_month, ls_iocd
dec{4} lc_ohqt002, lc_ohqt009
dec{0} lc_ohat002, lc_ohat009

setpointer(hourglass!)
// 선택된 행이 있는지 체크한다
//
ll_row = dw_wip05cu_01.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN 0
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_wip05cu_01.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	ls_year   = dw_wip05cu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfyear')
	ls_month  = dw_wip05cu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfmonth')
	ls_plant  = dw_wip05cu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfplant')
	ls_dvsn   = dw_wip05cu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfdvsn')
	ls_vendor = dw_wip05cu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfvendor')
	ls_iocd = dw_wip05cu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfiocd')
	// 해당지역, 공장에 대한 단가계산 완료여부를 체크한다.
	if f_get_stscd_wip090('01',ls_plant,ls_dvsn,ls_year + ls_month,'080') <> 'C' then
		messagebox("알림", ls_vendor + ' 업체는 아직 마감단가계산이 완료되지 않았거나, ' &
			+ '이미 경리확정된 업체입니다.')
		continue
	end if
	// 해당업체에 대한 투입, 사용, 장부수량을 입력한다.
	DECLARE up_wip_025 PROCEDURE FOR PBWIP.SP_WIP_025  
         A_CMCD = '01',   
         A_YEAR = :ls_year,   
         A_MONTH = :ls_month,   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_VENDOR = :ls_vendor,   
         A_IPADDR = :g_s_ipaddr,   
         A_MACADDR = :g_s_macaddr,   
         A_INPTDT = :g_s_date,   
         A_UPDTDT = :g_s_date ;
	EXECUTE up_wip_025;
	If sqlca.sqlcode = -1 Then
		MESSAGEBOX("경고","ERROR : 시스템개발로 연락바랍니다.")
		Return 0
	End If
	
	// 해당업체에 대한 클레임 계산을 한다.
	DECLARE up_wip_026 PROCEDURE FOR PBWIP.SP_WIP_026  
         A_CMCD = '01',   
         A_YEAR = :ls_year,   
         A_MONTH = :ls_month,   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_VENDOR = :ls_vendor,   
         A_IPADDR = :g_s_ipaddr,   
         A_MACADDR = :g_s_macaddr,   
         A_INPTDT = :g_s_date,   
         A_UPDTDT = :g_s_date  ;
	EXECUTE up_wip_026;
	If sqlca.sqlcode = -1 Then
		MESSAGEBOX("경고","CLAIM_ERROR : 시스템개발로 연락바랍니다.")
		Return 0
	End If
	// 클레임 계산 결과 확인
	select sum(wbbgqt + wbinqt - (wbusqt1 + wbusqt2 + wbusqt3 +
    	wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7 + wbusqt8)),
  		sum(wbbgat1 + wbinat1 + wbinat2 + wbinat3 - (wbusat1 + wbusat2 +
    	wbusat3 + wbusat4 + wbusat5 + wbusat6 + wbusat7 + wbusat8 +
    	wbusat9))
	into :lc_ohqt002, :lc_ohat002
  	from pbwip.wip002
  	where wbcmcd = '01' and wbyear = :ls_year and
        	wbplant = :ls_plant and wbdvsn = :ls_dvsn and
        	wbiocd = :ls_iocd and wborct = :ls_vendor and
        	wbmonth = :ls_month and
        	not (wbbgqt = 0 and wbinqt = wbusqt3 and
          	wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          	wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          	wbusqt8 = 0 )
	using sqlca;
	
	SELECT SUM(WFOHQT), SUM(WFOHAT)
		INTO :lc_ohqt009, :lc_ohat009
		FROM PBWIP.WIP009
		WHERE WFYEAR = :ls_year AND WFMONTH = :ls_month AND WFPLANT = :ls_plant AND
			WFDVSN = :ls_dvsn AND WFVENDOR = :ls_vendor and WFIOCD = :ls_iocd
		using sqlca;
		
	if ( lc_ohqt002 <> lc_ohqt009 ) or ( lc_ohat002 <> lc_ohat009 ) then
		MessageBox("확인", ls_vendor + " 클레임계산시에 에러가 발생하였습니다.")
		
		update pbwip.wip009
  			set wfstscd = '2'
  		where wfyear = :ls_year and wfmonth = :ls_month and
        wfcmcd = '01' and wfplant = :ls_plant and
        wfdvsn = :ls_dvsn and wfvendor = :ls_vendor and WFIOCD = :ls_iocd
		using sqlca;
		
		Continue
	end if
	// 클레임계산이 완료되면 상태를 클레임 계산으로 업데이트 한다.
	ll_lastrow = dw_wip05cu_02.insertrow(0)
	dw_wip05cu_02.setitem(ll_lastrow,'wip009_wfplant', ls_plant)
	dw_wip05cu_02.setitem(ll_lastrow,'wip009_wfdvsn', ls_dvsn)
	dw_wip05cu_02.setitem(ll_lastrow,'wip009_wfvendor', ls_vendor)
	dw_wip05cu_02.setitem(ll_lastrow,'pur101_vndnm', mid(f_get_vendor02('01',ls_vendor),11))
	dw_wip05cu_02.setitem(ll_lastrow,'wip009_wfstscd', '3')
	dw_wip05cu_02.setitem(ll_lastrow,'wip009_wfiocd', ls_iocd)
	dw_wip05cu_02.SelectRow(0, False)
	dw_wip05cu_02.SelectRow(ll_lastrow, True)	
	dw_wip05cu_02.ScrollToRow(ll_lastrow)
	dw_wip05cu_01.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// 이동이 끝난 좌측화면의 선택행은 삭제한다(행의 맨뒤에서부터 삭제한다)
//
FOR ll_row = dw_wip05cu_01.RowCount() to 1 step -1
	IF dw_wip05cu_01.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_wip05cu_01.DeleteRow(ll_row)
	END IF
NEXT

Parent.Triggerevent("ue_retrieve")
return 0


end event

type st_2 from statictext within w_wip05cu
integer x = 46
integer y = 268
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "클레임계산이 가능한 업체"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip05cu
integer x = 2514
integer y = 264
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "클레임계산이 완료된 업체"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_wip05cu_01 from u_vi_std_datawindow within w_wip05cu
integer x = 50
integer y = 384
integer width = 1915
integer height = 2080
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_wip05cu_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_wip05cu_02 from u_vi_std_datawindow within w_wip05cu
integer x = 2519
integer y = 384
integer width = 1915
integer height = 2080
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_wip05cu_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_2 from datawindow within w_wip05cu
integer x = 2318
integer y = 28
integer width = 2112
integer height = 172
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip05cu_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_free from radiobutton within w_wip05cu
integer x = 1445
integer y = 212
integer width = 457
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "무상사급"
boolean checked = true
boolean automatic = false
end type

type rb_cost from radiobutton within w_wip05cu
integer x = 1902
integer y = 212
integer width = 416
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "유상사급"
boolean automatic = false
end type

type gb_1 from groupbox within w_wip05cu
integer x = 32
integer width = 2235
integer height = 196
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

