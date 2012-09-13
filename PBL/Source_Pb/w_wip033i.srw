$PBExportHeader$w_wip033i.srw
$PBExportComments$재공사용량 생성 및 확인
forward
global type w_wip033i from w_origin_sheet02
end type
type dw_1 from datawindow within w_wip033i
end type
type dw_2 from datawindow within w_wip033i
end type
type dw_3 from datawindow within w_wip033i
end type
type cb_1 from commandbutton within w_wip033i
end type
type pb_1 from picturebutton within w_wip033i
end type
end forward

global type w_wip033i from w_origin_sheet02
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
pb_1 pb_1
end type
global w_wip033i w_wip033i

on w_wip033i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_1
end on

on w_wip033i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.pb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_1.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_1.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

dw_1.insertrow(0)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,true,true,true ,false, false, false, false, false,  false,false, false)
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant, ls_dvsn , ls_type, ls_srno, ls_srno1, ls_srno2
integer li_cnt

dw_1.accepttext()

ls_plant = dw_1.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_1.getitemstring(1,"wip001_wadvsn")
ls_type = dw_1.getitemstring(1,"inv401_sliptype")
ls_srno = dw_1.getitemstring(1,"inv401_srno")
ls_srno1 = dw_1.getitemstring(1,"inv401_srno1")
ls_srno2 = dw_1.getitemstring(1,"inv401_srno2")

//자재트랜스 조회
li_cnt = dw_2.retrieve(g_s_company, ls_plant, ls_dvsn,ls_type, ls_srno)
if li_cnt < 1 then
	uo_status.st_message.text = "INV401 : 조회할 자료가 없습니다."
end if

end event

event ue_save;call super::ue_save;string ls_plant, ls_dvsn , ls_type, ls_srno, ls_srno1, ls_srno2
string ls_cls, ls_srce, ls_slno, ls_itno, ls_xuse, ls_rtngub, ls_vsrno, ls_dept
string ls_date
dec{1} lc_qty4
integer li_cnt
long  ll_currow

setpointer(hourglass!)
ll_currow = dw_2.getselectedrow(0)

ls_plant = dw_2.getitemstring(ll_currow,"xplant")
ls_dvsn = dw_2.getitemstring(ll_currow,"div")
ls_type = dw_2.getitemstring(ll_currow,"sliptype")
ls_srno = dw_2.getitemstring(ll_currow,"srno")
ls_srno1 = dw_2.getitemstring(ll_currow,"srno1")
ls_srno2 = dw_2.getitemstring(ll_currow,"srno2")

select slno, itno, xuse, rtngub, vsrno, dept, tdte4, tqty4
	into :ls_slno, :ls_itno, :ls_xuse, :ls_rtngub, :ls_vsrno, :ls_dept, :ls_date, :lc_qty4
	from pbinv.inv401
	where comltd = :g_s_company and xplant = :ls_plant and div = :ls_dvsn and
			sliptype = :ls_type and srno = :ls_srno and srno1 = :ls_srno1 and
			srno2 = :ls_srno2 using sqlca;

if ls_type = 'RM' or ls_type = 'SM' or ls_type = 'IS' or ls_type = 'RS' then
	if ls_type = 'IS' or ls_type = 'RS' then
		ls_dept = ls_vsrno
	end if
	if f_wip_line_use_update(g_s_company,ls_type,ls_srno,ls_srno1,ls_srno2) = -1 then
		uo_status.st_message.text = "실패했습니다."
		return 0
	else
		uo_status.st_message.text = "성공했습니다."
	end if
end if

if ls_type = 'RP' then
	if f_wip_vendor_use_update(g_s_company,ls_type,ls_srno,ls_srno1,ls_srno2) = -1 then
		uo_status.st_message.text = "실패했습니다."
		return 0
	else
		uo_status.st_message.text = "성공했습니다."
	end if
end if

end event

event ue_delete;call super::ue_delete;string ls_plant, ls_dvsn , ls_type, ls_srno, ls_srno1, ls_srno2
long ll_selrow, ll_count

ll_selrow = dw_2.getselectedrow(0)
ls_plant = dw_2.getitemstring(ll_selrow,"xplant")
ls_dvsn = dw_2.getitemstring(ll_selrow,"div")
ls_type = dw_2.getitemstring(ll_selrow,"sliptype")
ls_srno = dw_2.getitemstring(ll_selrow,"srno")
ls_srno1 = dw_2.getitemstring(ll_selrow,"srno1")
ls_srno2 = dw_2.getitemstring(ll_selrow,"srno2")

SELECT COUNT(*) INTO :ll_count FROM "PBWIP"."WIP004"  
   WHERE ( "PBWIP"."WIP004"."WDCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP004"."WDPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP004"."WDDVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP004"."WDPRSRTY" = :ls_type ) AND  
         ( "PBWIP"."WIP004"."WDPRSRNO" = :ls_srno ) AND  
         ( "PBWIP"."WIP004"."WDPRSRNO1" = :ls_srno1 ) AND  
         ( "PBWIP"."WIP004"."WDPRSRNO2" = :ls_srno2 )   
          using sqlca;

  DELETE FROM "PBWIP"."WIP004"  
   WHERE ( "PBWIP"."WIP004"."WDCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP004"."WDPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP004"."WDDVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP004"."WDPRSRTY" = :ls_type ) AND  
         ( "PBWIP"."WIP004"."WDPRSRNO" = :ls_srno ) AND  
         ( "PBWIP"."WIP004"."WDPRSRNO1" = :ls_srno1 ) AND  
         ( "PBWIP"."WIP004"."WDPRSRNO2" = :ls_srno2 )   
          using sqlca;
			 
if sqlca.sqlcode <> 0 then
	commit using sqlca;
	uo_status.st_message.text = "실패했습니다."
else
	rollback using sqlca;
	uo_status.st_message.text = "성공했습니다. " + "삭제수 : " + string(ll_count)
end if

end event

type uo_status from w_origin_sheet02`uo_status within w_wip033i
end type

type dw_1 from datawindow within w_wip033i
integer x = 59
integer y = 36
integer width = 3694
integer height = 156
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip033i_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_null
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
end event

type dw_2 from datawindow within w_wip033i
integer x = 32
integer y = 204
integer width = 4535
integer height = 1124
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip033i_inv401"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_plant, ls_dvsn , ls_type, ls_srno, ls_srno1, ls_srno2

ls_plant = dw_2.getitemstring(row,"xplant")
ls_dvsn = dw_2.getitemstring(row,"div")
ls_type = dw_2.getitemstring(row,"sliptype")
ls_srno = dw_2.getitemstring(row,"srno")
ls_srno1 = dw_2.getitemstring(row,"srno1")
ls_srno2 = dw_2.getitemstring(row,"srno2")

if dw_3.retrieve(g_s_company, ls_plant, ls_dvsn, ls_type, ls_srno, ls_srno1, ls_srno2) < 1 then
	uo_status.st_message.text = "조회된 데이타가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event clicked;integer li_rowcnt

li_rowcnt = This.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

type dw_3 from datawindow within w_wip033i
integer x = 37
integer y = 1356
integer width = 4539
integer height = 1108
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip033i_wip004"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_wip033i
integer x = 3886
integer y = 52
integer width = 498
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "사용수 체크"
end type

event clicked;string ls_xplant, ls_xdvsn,ls_plant, ls_dvsn, ls_sliptype, ls_itno, ls_prno, ls_adjdate, ls_date02
string ls_slty, ls_srno, ls_srno1, ls_srno2
long ll_count,ll_count02, ll_cnt, ll_cntx, ll_rowcnt, ll_currow
datastore lds_01

lds_01 = create datastore
lds_01.dataobject = "d_wip033i_count"
lds_01.settransobject(sqlca)

dw_2.reset()
setpointer(hourglass!)
dw_1.accepttext()
ls_sliptype = dw_1.getitemstring(1,"inv401_sliptype")
ls_xplant = dw_1.getitemstring(1,"wip001_waplant")
ls_xdvsn = dw_1.getitemstring(1,"wip001_wadvsn")
ls_adjdate = dw_1.getitemstring(1,"wip001_wainptdt")

declare wip004_cur cursor for 
	 SELECT "PBWIP"."WIP004"."WDPLANT",   
			"PBWIP"."WIP004"."WDDVSN",
			"PBWIP"."WIP004"."WDPRSRTY",
			"PBWIP"."WIP004"."WDPRSRNO",
			"PBWIP"."WIP004"."WDPRSRNO1",
			"PBWIP"."WIP004"."WDPRSRNO2",
			"PBWIP"."WIP004"."WDPRNO",
			COUNT("PBWIP"."WIP004"."WDITNO")
	 FROM "PBWIP"."WIP004"  
	WHERE ( "PBWIP"."WIP004"."WDCMCD" = :g_s_company ) AND  
			( "PBWIP"."WIP004"."WDPLANT" = :ls_xplant ) AND  
			( "PBWIP"."WIP004"."WDDVSN" = :ls_xdvsn ) AND
			( "PBWIP"."WIP004"."WDPRSRTY" = :ls_sliptype ) AND
			( "PBWIP"."WIP004"."WDPRNO" = :ls_itno ) AND
			( {fn substring("PBWIP"."WIP004"."WDDATE",1,6)} = :ls_adjdate )
	GROUP BY "PBWIP"."WIP004"."WDPLANT",   
			"PBWIP"."WIP004"."WDDVSN",
			"PBWIP"."WIP004"."WDPRSRTY",
			"PBWIP"."WIP004"."WDPRSRNO",
			"PBWIP"."WIP004"."WDPRSRNO1",
			"PBWIP"."WIP004"."WDPRSRNO2",
			"PBWIP"."WIP004"."WDPRNO"
			using sqlca;

//for ll_cntx = 1 to 10
//	choose case ll_cntx
//		case 1
//			ls_xplant = 'D'
//			ls_xdvsn = 'A'
//		case 2
//			ls_xplant = 'D'
//			ls_xdvsn = 'H'
//		case 3
//			ls_xplant = 'D'
//			ls_xdvsn = 'M'
//		case 4
//			ls_xplant = 'D'
//			ls_xdvsn = 'S'
//		case 5
//			ls_xplant = 'D'
//			ls_xdvsn = 'V'
//		case 6
//			ls_xplant = 'J'
//			ls_xdvsn = 'M'
//		case 7
//			ls_xplant = 'J'
//			ls_xdvsn = 'S'
//		case 8
//			ls_xplant = 'J'
//			ls_xdvsn = 'H'
//		case 9
//			ls_xplant = 'K'
//			ls_xdvsn = 'S'
//		case 10
//			ls_xplant = 'K'
//			ls_xdvsn = 'H'
//	end choose
	
	lds_01.reset()
	ll_rowcnt = lds_01.retrieve(g_s_company, ls_xplant, ls_xdvsn, ls_sliptype, ls_adjdate)
	if ll_rowcnt < 1 then
		uo_status.st_message.text = "조회된 데이타가 없습니다."
		return 0
	end if
	
	for ll_cnt = 1 to ll_rowcnt
		ls_itno = lds_01.getitemstring(ll_cnt,"wdprno")
		//ls_date02 = lds_01.getitemstring(ll_cnt,"wddate")
		uo_status.st_message.text = ls_itno + " : " + string(ll_cnt) + " / " + string(ll_rowcnt)
		//모품번에 대한 CHILD수 가져오기
		ll_count = f_wip_vendor_count(g_s_company, ls_sliptype, ls_xplant, ls_xdvsn, ls_itno, ls_adjdate + '01')
		open wip004_cur ;
		  do while true
			fetch wip004_cur into :ls_plant, :ls_dvsn,:ls_slty, :ls_srno,:ls_srno1,:ls_srno2, :ls_prno, :ll_count02;
			if sqlca.sqlcode <> 0 then			  
				exit
			end if
			if ll_count <> ll_count02 then
				ll_currow = dw_2.insertrow(0)
				dw_2.setitem(ll_currow,"sliptype",ls_slty)
				dw_2.setitem(ll_currow,"srno",ls_srno)
				dw_2.setitem(ll_currow,"srno1",ls_srno1)
				dw_2.setitem(ll_currow,"srno2",ls_srno2)
				dw_2.setitem(ll_currow,"xplant",ls_plant)
				dw_2.setitem(ll_currow,"div",ls_dvsn)
				dw_2.setitem(ll_currow,"itno",ls_prno)
			end if
		  loop
		close wip004_cur ;	
	next
//next
end event

type pb_1 from picturebutton within w_wip033i
integer x = 3707
integer y = 44
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_2.rowcount() < 1 then
	uo_status.st_message.text = "저장할 자료가 없습니다."
else
	f_save_to_excel(dw_2)
end if
end event

