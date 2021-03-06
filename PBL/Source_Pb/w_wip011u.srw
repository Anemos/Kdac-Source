$PBExportHeader$w_wip011u.srw
$PBExportComments$재공 기본정보 등록및 수정
forward
global type w_wip011u from w_origin_sheet01
end type
type dw_itemlist from datawindow within w_wip011u
end type
type dw_itementry from datawindow within w_wip011u
end type
type dw_2 from datawindow within w_wip011u
end type
type pb_down from picturebutton within w_wip011u
end type
type gb_1 from groupbox within w_wip011u
end type
end forward

global type w_wip011u from w_origin_sheet01
dw_itemlist dw_itemlist
dw_itementry dw_itementry
dw_2 dw_2
pb_down pb_down
gb_1 gb_1
end type
global w_wip011u w_wip011u

type variables
long net
end variables

forward prototypes
public function integer wf_find_datachk ()
end prototypes

public function integer wf_find_datachk ();string ls_iocd, ls_plant, ls_dvsn, ls_vndr, ls_itno, ls_rtnvalue

dw_2.accepttext()
ls_vndr = dw_2.getitemstring(1,"vndr")
ls_plant = dw_2.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_2.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_2.getitemstring(1,"wip001_waiocd")
ls_itno = dw_2.getitemstring(1,"wip001_waitno")

if ls_iocd = '1' then
	if f_spacechk(ls_itno) = -1 then
		dw_2.setitem(1,"wip001_waorct",'9999%')
	else
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, dw_2) = -1 then
			uo_status.st_message.text = "정의되지 않은 품번입니다."
			dw_2.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			dw_2.modify("wip001_waitno.background.color = 1090519039")
			dw_2.setitem(1,"wip001_waitno",ls_itno)
			dw_2.setitem(1,"wip001_waorct",'9999%')
		end if
	end if
else
	if f_spacechk(ls_itno) = -1 then
		//pass
	else
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, dw_2) = -1 then
			uo_status.st_message.text = "정의되지 않은 품번입니다."
			dw_2.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			dw_2.modify("wip001_waitno.background.color = 1090519039")
			dw_2.setitem(1,"wip001_waitno",ls_itno)
			dw_2.setitem(1,"wip001_waorct",'9999%')
		end if
	end if
	
	if f_spacechk(ls_vndr) = -1 then
		dw_2.setitem(1,"wip001_waorct",'%')
	else
		ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
		if f_spacechk(ls_rtnvalue) <> -1 then		//사업자번호가 입력된경우
			dw_2.modify("vndr.background.color = 15780518")
			dw_2.setitem(1,"vndnm",mid(ls_rtnvalue,6))
			dw_2.setitem(1,"wip001_waorct",trim(mid(ls_rtnvalue,1,5)) + '%')
		else
			uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
			dw_2.modify("vndr.background.color = 65535")
			return -1
		end if
	end if
end if

return 0
end function

on w_wip011u.create
int iCurrent
call super::create
this.dw_itemlist=create dw_itemlist
this.dw_itementry=create dw_itementry
this.dw_2=create dw_2
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_itemlist
this.Control[iCurrent+2]=this.dw_itementry
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.pb_down
this.Control[iCurrent+5]=this.gb_1
end on

on w_wip011u.destroy
call super::destroy
destroy(this.dw_itemlist)
destroy(this.dw_itementry)
destroy(this.dw_2)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03, dwc_04
dw_itemlist.settransobject(sqlca)
dw_itementry.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_2.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')
dw_itementry.getchild("wip001_waplant",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('SLE220')
dw_itementry.getchild("wip001_wadvsn",dwc_04)
dwc_04.settransobject(sqlca)
dwc_04.retrieve('DAC030')

dw_2.insertrow(0)
dw_2.setitem(1,"wip001_waiocd",'2')

//// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, true, false, false, false, false, false)
end event

event ue_retrieve;string ls_vsrno, ls_plant, ls_dvsn, ls_iocd, ls_orct,ls_itno
long ll_rowcnt

if dw_itementry.modifiedcount() > 0 then
	net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
	if net=1 then
	triggerevent("ue_save")
	if i_n_erreturn = -1 then
	  	return 1
	end if
	elseif net=3 then
    	 return 1
   end if
end if

//dw_itemlist.reset()
dw_itementry.reset()

//dw_2.SetItemStatus(1,0,Primary!,DataModified!)
dw_2.accepttext()
IF f_wip_mandantory_chk(dw_2) = -1 THEN 						//필수입력 체크
	uo_status.st_message.text = f_message("E010")
	return 0
END IF

if wf_find_datachk() = -1 then
	uo_status.st_message.text = "조회조건이 잘못 입력되었습니다."
end if

ls_plant  = dw_2.getitemstring(1,"wip001_waplant")    //지역
ls_dvsn   = dw_2.getitemstring(1,"wip001_wadvsn")		//공장	
ls_iocd   = dw_2.getitemstring(1,"wip001_waiocd")		//재공구분	
ls_vsrno   = dw_2.getitemstring(1,"wip001_waorct")		//조코드
ls_itno = dw_2.getitemstring(1,"wip001_waitno")

if ls_iocd = '1' then
	dw_itemlist.dataobject = 'd_wip011u_line'
	dw_itemlist.settransobject(sqlca)
else
	dw_itemlist.dataobject = 'd_wip011u_vendor'
	dw_itemlist.settransobject(sqlca)
end if

dw_2.SetItemStatus(1,0,Primary!,DataModified!)

if f_spacechk(ls_itno) = -1 then
	ls_itno = '%'
else
	ls_itno = ls_itno + '%'
end if

ll_rowcnt = dw_itemlist.Retrieve(g_s_company, ls_plant, ls_dvsn, ls_itno, ls_vsrno)
IF ll_rowcnt > 0 THEN
   wf_icon_onoff(true, true, true, true, true, false,  false)
  	uo_status.st_message.text = f_message('I010')     //조회되었습니다.
ELSE
   wf_icon_onoff(true, true, false, false, true, false,  false)
  	uo_status.st_message.text = f_message('I020')     //조회데이타가 없습니다.
END IF
end event

event ue_insert;//string ls_plant, ls_dvsn, ls_iocd, ls_orct, ls_itno
//
//dw_itemlist.reset()
//dw_itementry.reset()
//uo_status.st_message.text = ""
//if dw_itementry.modifiedcount() > 0 then
//	net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
//	if net=1 then
//	triggerevent("ue_save")
//	if i_n_erreturn = -1 then
//	  	return 1
//	end if
//	elseif net=3 then
//    	 return 1
//   end if
//end if
//dw_2.accepttext()
//if f_wip_mandantory_chk(dw_2) = -1 then
//	uo_status.st_message.text = f_message("E010")
//	return 0
//end if
//
//if wf_find_datachk() = -1 then
//	uo_status.st_message.text = f_message("E010")
//	return 0
//end if
//
//ls_plant  = dw_2.getitemstring(1,"wip001_waplant")
//ls_dvsn   = dw_2.getitemstring(1,"wip001_wadvsn")
//ls_iocd   = dw_2.getitemstring(1,"wip001_waiocd")
//ls_orct   = mid(dw_2.getitemstring(1,"wip001_waorct"),1,5)
//ls_itno   = dw_2.getitemstring(1,"wip001_waitno")
//
//dw_itementry.insertrow(0)
//dw_itementry.setitem(1,"wip001_waplant",ls_plant)
//dw_itementry.setitem(1,"wip001_wadvsn",ls_dvsn)
//dw_itementry.setitem(1,"wip001_waiocd",ls_iocd)
//
//if f_spacechk(ls_itno) <> -1 then
//	dw_itementry.setitem(1,"wip001_waitno",ls_itno)
//else
//	uo_status.st_message.text = f_message("A070") //정보를 입력하시오
//end if
//if ls_iocd = '1' then
//	dw_itementry.setitem(1,"wip001_waorct",'9999')
//else
//	if f_spacechk(ls_orct) = -1 then
//		uo_status.st_message.text = "입력할 품번의 업체를 선택해 주십시요"
//		return 0
//	end if
//	dw_itementry.setitem(1,"wip001_waorct",ls_orct)
//end if
//dw_itementry.object.wip001_waitno.protect = FALSE
//dw_itementry.object.wip001_waitno.background.color=rgb(192,192,192) // silver
//dw_itementry.setcolumn("wip001_waitno")
//dw_itementry.setfocus()
//
////// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
//wf_icon_onoff(true, true, true, false, false, false,  false)
end event

event ue_save;string ls_itno, ls_cls, ls_srce, ls_plant, ls_dvsn, ls_iocd, ls_orct
integer li_rtn, li_cnt

ls_plant = dw_itementry.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_itementry.getitemstring(1,"wip001_wadvsn")
ls_itno = dw_itementry.getitemstring(1,"wip001_waitno")
ls_orct = dw_itementry.getitemstring(1,"wip001_waorct")

if f_get_itemproperty(g_s_company,ls_plant, ls_dvsn, ls_itno, dw_itementry) = -1 then
	uo_status.st_message.text = f_message("E320")
	return 0
end if

//재공밸런스에서 품번 체크
//SELECT COUNT(*) INTO :li_cnt FROM "PBWIP"."WIP001"
//	WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND
//			( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND
//			( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND
//			( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND
//			( "PBWIP"."WIP001"."WAITNO" = :ls_itno )
//			using sqlca;
//if li_cnt > 0 then
//	uo_status.st_message.text = f_message("U060")
//	return 0
//end if

f_wip_inptid(dw_itementry)			//IP,MACADDR,DATE등 기본정보입력
f_wip_null_chk(dw_itementry)      //NULL COLUMN SETTING
dw_itementry.accepttext()

ls_cls = dw_itementry.getitemstring(1,"inv101_cls")
ls_srce = dw_itementry.getitemstring(1,"inv101_srce")
ls_iocd = dw_itementry.getitemstring(1,"wip001_waiocd")

if (ls_cls = "10" or ls_cls = "20" or ls_cls = "40" or ls_cls = "50") then
	if ls_srce = "01" or ls_srce = "02" or ls_srce = "03" or ls_srce = "04" or ls_srce = "05" or ls_srce = "06" then
	else
		uo_status.st_message.text = f_message("E433") // 품번 입력후 작업 바랍니다.
		dw_itementry.object.waitno.background.color = rgb(255,255,0)
      return 0
   end if
else
   uo_status.st_message.text = f_message("E433") // 품번 입력후 작업 바랍니다.
	dw_itementry.object.waitno.background.color = rgb(255,255,0)
   return 0
end if

if ls_iocd = "1" then
	if ls_cls = '10' and ls_srce = "03" then
		uo_status.st_message.text = f_message("E433") // 품번 입력후 작업 바랍니다.
	   dw_itementry.object.waitno.background.color = rgb(255,255,0)
   end if
end if

li_rtn = dw_itementry.update()
if li_rtn = 1 then
	uo_status.st_message.text = f_message("U010")
else
	uo_status.st_message.text = f_message("U020")
end if

end event

event ue_delete;string ls_itno, ls_iocd, ls_orct, ls_plant, ls_dvsn
integer li_yesno, li_cnt
dec{2} lc_scrp, lc_retn 
uo_status.st_message.text = ""
ls_plant = dw_itementry.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_itementry.getitemstring(1, "wip001_wadvsn")
ls_orct = dw_itementry.getitemstring(1,"wip001_waorct")
ls_itno = dw_itementry.getitemstring(1,"wip001_waitno")
lc_scrp = dw_itementry.getitemdecimal(1,"wip001_wascrp")
lc_retn = dw_itementry.getitemdecimal(1,"wip001_waretn")
ls_iocd = dw_itementry.getitemstring(1,"wip001_waiocd")
if f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = f_message("D100")
	return 0
end if	
	
li_yesno = messagebox("삭제확인", dw_itementry.getitemstring(1, "wip001_waitno") + "을(를) 삭제하시겠습니까 ?",Question!,OkCancel!,2)

if li_yesno <> 1 then
   return 0
end if

// 업체품번이면서 불량율이나 반납율이 0이아닌 경우 삭제불가.
if ls_iocd = "2" then
	if lc_scrp = 0 and lc_retn = 0 then
	else
		uo_status.st_message.text = f_message("D040") //삭제 할수 없습니다.
   end if
end if
// 재공트랜스DB에 사용내역이 있을경우 삭제불가.
select count(*) into :li_cnt
 from pbwip.wip004
 where wdcmcd = :g_s_company and wdplant = :ls_plant and wddvsn = :ls_dvsn and wdchdpt = :ls_orct and wditno = :ls_itno 
 using sqlca;
if li_cnt > 0 then
	uo_status.st_message.text = f_message("D040") //삭제 할수 없습니다.
end if
// 재공이월DB에 품번이 있는경우 삭제불가.
select count(*) into :li_cnt
 from pbwip.wip002
 where wbcmcd = :g_s_company and wbplant = :ls_plant and wbdvsn = :ls_dvsn and wborct = :ls_orct and wbitno = :ls_itno 
 using sqlca;
if li_cnt > 0 then
	uo_status.st_message.text = f_message("D040") //삭제 할수 없습니다.
end if

if dw_itementry.deleterow(1) <> 1 then
	uo_status.st_message.text = f_message("I110")
	return 0
end if

if dw_itementry.update() = 1 then
	uo_status.st_message.text = f_message("D010")
else
	uo_status.st_message.text = f_message("D020")
end if

end event

type uo_status from w_origin_sheet01`uo_status within w_wip011u
end type

type dw_itemlist from datawindow within w_wip011u
integer x = 9
integer y = 364
integer width = 4608
integer height = 1436
integer taborder = 50
boolean bringtotop = true
string title = "품목현황"
string dataobject = "d_wip011u_line"
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

event doubleclicked;string ls_plant, ls_dvsn, ls_orct, ls_itno

dw_itementry.accepttext()
if dw_itementry.modifiedcount() > 0 then
	net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
	if net=1 then
	   triggerevent("ue_save")
   	if i_n_erreturn = -1 then
	    	return 1
	   end if
	elseif net=3 then
    	 return 1
   end if
end if

// 조회할 인수가져오기
ls_plant = dw_itemlist.getitemstring(row,"wip001_waplant")
ls_dvsn = dw_itemlist.getitemstring(row,"wip001_wadvsn")
ls_orct = dw_itemlist.getitemstring(row,"wip001_waorct")
ls_itno = dw_itemlist.getitemstring(row,"wip001_waitno")

dw_itementry.reset()
if dw_itementry.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno) > 0 then
	uo_status.st_message.text = f_message("I010")
else
   uo_status.st_message.text = f_message("I020")
end if

dw_itementry.object.wip001_waitno.protect = true
dw_itementry.object.wip001_waitno.background.color=rgb(192,192,192) // silver

//// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, true, true, false, false, false,  false)

end event

type dw_itementry from datawindow within w_wip011u
event ue_enterkey pbm_dwnkey
integer x = 9
integer y = 1824
integer width = 4608
integer height = 652
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip011u_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	string ls_colname, ls_plant, ls_dvsn, ls_itno
	uo_status.st_message.text = ""
	This.AcceptText()
	ls_colname = This.GetColumnName()
	IF ls_colname = 'wip001_waitno' Then
		ls_plant = this.getitemstring(1,"wip001_waplant")
		ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
		ls_itno = this.getitemstring(1,"wip001_waitno")
   	if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, dw_itementry) = -1 then
			uo_status.st_message.text = "정의되지 않은 품번입니다."
			return 0
		end if
	END IF
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if
end event

type dw_2 from datawindow within w_wip011u
event ue_dwkeydown pbm_dwnkey
integer x = 59
integer y = 60
integer width = 4338
integer height = 268
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip011u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwkeydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_null, ls_dvsn
datawindowchild cdw_1

This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

//if ls_colname = "wip001_waiocd" then
//	if data = '2' then
//		This.modify("vndr_t.visible = true")
//		This.modify("vndr.visible = true")
//		This.modify("vsrno_t.visible = true")
//		This.modify("vndnm.visible = true")
//		This.modify("b_search.visible = true")
//		This.modify("vndr.Background.Color = 15780518")
//	else
//		This.modify("vndr_t.visible = false")
//		This.modify("vndr.visible = false")
//		This.modify("vsrno_t.visible = false")
//		This.modify("vndnm.visible = false")
//		This.modify("b_search.visible = false")
//		This.modify("vndr.Background.Color = 1090519039")
//	end if
//end if

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "정의되지 않은 품번입니다."
		return 0
	end if
end if

if ls_colname = "vndr" then
	string ls_rtnvalue
	ls_rtnvalue = f_get_vendor01(g_s_company, data)
	if ls_rtnvalue <> '' then		//사업자번호가 입력된경우
		This.setitem(1,"vndnm",mid(ls_rtnvalue,6))
		This.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
	else
		uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
		return 0
	end if
end if

end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"vndnm",trim(mid(ls_parm,16)))
		This.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
		This.setitem(1,"wip001_waorct",trim(mid(ls_parm,1,5)))
	end if
end if

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(1,"wip001_waplant")
	ls_dvsn = This.getitemstring(1,"wip001_wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "지역이나 공장을 먼저 선택하십시요"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(1,"wip001_waitno", mid(ls_parm,1,15))
	end if
end if
end event

type pb_down from picturebutton within w_wip011u
integer x = 2450
integer y = 208
integer width = 329
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel_number(dw_itemlist)
end event

type gb_1 from groupbox within w_wip011u
integer x = 14
integer width = 4590
integer height = 340
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

