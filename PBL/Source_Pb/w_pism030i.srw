$PBExportHeader$w_pism030i.srw
$PBExportComments$조별생산품목 표준시간 조회
forward
global type w_pism030i from w_pism_sheet01
end type
type st_2 from statictext within w_pism030i
end type
type dw_kdac_routing from datawindow within w_pism030i
end type
type st_3 from statictext within w_pism030i
end type
type dw_kdac_routing_test from datawindow within w_pism030i
end type
type dw_routing from u_pism_dw within w_pism030i
end type
type dw_wcitem from u_pism_dw within w_pism030i
end type
type dw_routing_p from datawindow within w_pism030i
end type
type dw_routing_print from datawindow within w_pism030i
end type
type dw_routing_test_print from datawindow within w_pism030i
end type
type pb_print from picturebutton within w_pism030i
end type
type st_4 from statictext within w_pism030i
end type
end forward

global type w_pism030i from w_pism_sheet01
integer width = 4663
integer height = 2728
st_2 st_2
dw_kdac_routing dw_kdac_routing
st_3 st_3
dw_kdac_routing_test dw_kdac_routing_test
dw_routing dw_routing
dw_wcitem dw_wcitem
dw_routing_p dw_routing_p
dw_routing_print dw_routing_print
dw_routing_test_print dw_routing_test_print
pb_print pb_print
st_4 st_4
end type
global w_pism030i w_pism030i

type variables
Long il_seqChg_tarRow, il_seqChg_sourceRow 
string is_olditno
end variables

forward prototypes
public function string wf_getwcitemuseflag (string as_item, string as_line, string as_lineno)
public subroutine wf_butenabled (boolean ab_enabled)
end prototypes

public function string wf_getwcitemuseflag (string as_item, string as_line, string as_lineno);String ls_useFlag 

  SELECT UseFlag INTO :ls_useFlag  
    FROM TMHWCITEM  
   WHERE ( AreaCode = :istr_retrievemh.area ) AND  
         ( DivisionCode = :istr_retrievemh.div ) AND  
         ( WorkCenter = :istr_retrievemh.wc ) AND  
         ( ItemCode = :as_item ) AND  
         ( subLineCode = :as_line ) AND  
         ( subLineNo = :as_lineno ) Using SqlPIS ;
If IsNull(ls_useFlag) or ls_useFlag = '' Then ls_useFlag = '0' 

Return ls_useFlag 
end function

public subroutine wf_butenabled (boolean ab_enabled);
end subroutine

on w_pism030i.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_kdac_routing=create dw_kdac_routing
this.st_3=create st_3
this.dw_kdac_routing_test=create dw_kdac_routing_test
this.dw_routing=create dw_routing
this.dw_wcitem=create dw_wcitem
this.dw_routing_p=create dw_routing_p
this.dw_routing_print=create dw_routing_print
this.dw_routing_test_print=create dw_routing_test_print
this.pb_print=create pb_print
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_kdac_routing
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_kdac_routing_test
this.Control[iCurrent+5]=this.dw_routing
this.Control[iCurrent+6]=this.dw_wcitem
this.Control[iCurrent+7]=this.dw_routing_p
this.Control[iCurrent+8]=this.dw_routing_print
this.Control[iCurrent+9]=this.dw_routing_test_print
this.Control[iCurrent+10]=this.pb_print
this.Control[iCurrent+11]=this.st_4
end on

on w_pism030i.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_kdac_routing)
destroy(this.st_3)
destroy(this.dw_kdac_routing_test)
destroy(this.dw_routing)
destroy(this.dw_wcitem)
destroy(this.dw_routing_p)
destroy(this.dw_routing_print)
destroy(this.dw_routing_test_print)
destroy(this.pb_print)
destroy(this.st_4)
end on

event ue_retrieve;call super::ue_retrieve;String ls_curr 

This.SetRedraw(True)

f_pism_working_msg(uo_wc.is_uo_workcentername + " 조", "조내 Routing Sheet 및 유사군별 생산모델을 조회중입니다.") 

SetNull(ls_curr); 

ls_curr = String(f_pisc_get_date_nowtime(), 'YYYY.MM.DD') 
dw_wcitem.SetFilter(""); dw_wcitem.SetTransObject(SqlPIS); dw_wcitem.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, '%', ls_curr) 
dw_routing.SetTransObject(SqlPIS) 
If dw_routing.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, ls_curr) = 0 And dw_wcitem.RowCount() = 0 Then 
	If IsValid(w_pism_working) Then Close(w_pism_working) 

		f_pism_MessageBox(Information!, 999, "Routing Sheet", uo_wc.is_uo_workcentername + " 조~n~n" + &
												  "의 Routing Data가 존재하지 않습니다.")
End If 
istr_retrievemh = istr_mh 
This.Event ue_retresult(dw_routing.RowCount() + dw_wcitem.RowCount()) 
If IsValid(w_pism_working) Then Close(w_pism_working) 
dw_routing.SetFocus() 
end event

event ue_postopen;call super::ue_postopen;If cb_wcfilter.Text = '담당조 FILTER 취소' Then wf_autworkcenter(True) 

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건
String ls_curr 

ls_curr = String(f_pisc_get_date_nowtime(), 'YYYY.MM.DD') 

dw_routing_p.SetTransObject(sqlPIS)
dw_routing_p.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, ls_curr) 

lstr_prt.Transaction = SqlPIS 
lstr_prt.datawindow = dw_routing_p 
lstr_prt.DataObject = "d_pism030u_01_p_rev" 
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'	t_prdate.Text = '기준일자 : " + ls_curr + "'" 
lstr_prt.title = idw_focused.Title 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event clicked;call super::clicked;dw_kdac_routing.visible 		= false
dw_kdac_routing_test.visible 	= false
dw_kdac_routing.enabled 		= false
dw_kdac_routing_test.enabled 	= false
end event

type uo_status from w_pism_sheet01`uo_status within w_pism030i
integer x = 0
integer y = 2496
integer width = 4608
integer height = 80
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pism030i
integer taborder = 120
end type

event uo_wc::ue_select;call super::ue_select;DataWindowChild ldwc 

Parent.TriggerEvent("ue_retrieve") 


end event

type uo_area from w_pism_sheet01`uo_area within w_pism030i
integer taborder = 140
end type

type uo_div from w_pism_sheet01`uo_div within w_pism030i
integer taborder = 160
end type

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pism030i
integer taborder = 50
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pism030i
end type

type st_2 from statictext within w_pism030i
integer x = 23
integer y = 184
integer width = 645
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[ Routing Sheet ]"
boolean focusrectangle = false
end type

type dw_kdac_routing from datawindow within w_pism030i
boolean visible = false
integer x = 37
integer y = 96
integer width = 2149
integer height = 1800
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "Routing 정보 (현재)"
string dataobject = "d_pism030u_routing"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "C:\KDAC\kdac.ico"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca) ;

end event

event clicked;if row <= 0 then return
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)
end event

type st_3 from statictext within w_pism030i
integer x = 658
integer y = 184
integer width = 1573
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 8388736
long backcolor = 12632256
string text = "더블클릭하시면 품번별 Routing 상세정보 조회됩니다"
boolean focusrectangle = false
end type

type dw_kdac_routing_test from datawindow within w_pism030i
boolean visible = false
integer x = 2194
integer y = 96
integer width = 2149
integer height = 1800
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "Routing 정보 (변경후)"
string dataobject = "d_pism030u_routing_test"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca) ;

end event

event clicked;if row <= 0 then return
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)
end event

type dw_routing from u_pism_dw within w_pism030i
integer x = 37
integer y = 256
integer width = 2267
integer height = 2208
integer taborder = 30
boolean bringtotop = true
string title = "Routing Sheet"
string dataobject = "d_pism030u_01_rev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;dw_kdac_routing.visible 		= false
dw_kdac_routing_test.visible 	= false
dw_kdac_routing.enabled 		= false
dw_kdac_routing_test.enabled 	= false
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	string ls_itno,ls_plant,ls_div,ls_line,ls_raitno,ls_wkct
	ls_plant		=	this.object.areacode[row]
	ls_div		=	this.object.divisioncode[row]
	ls_itno		=	this.object.itemcode[row]
	ls_wkct		=	this.object.workcenter[row]
	ls_line		=	trim(this.object.sublinecode[row])	+	trim(this.object.sublineno[row])
	dw_kdac_routing.reset()
	dw_kdac_routing_test.reset()
	ls_raitno	=	f_rtn_conv_itno(ls_plant,ls_div,ls_itno,g_s_date)
	if	ls_raitno	<>	ls_itno	then
		messagebox("확인", trim(ls_itno) + "  품번은 유사 품번입니다. 대표품번 " + trim(ls_raitno) + &
			                   "의 Routing 정보가 조회 됩니다 " )
		ls_itno	=	ls_raitno
	end if
	if dw_kdac_routing.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line,ls_wkct,g_s_date) +  &
	   dw_kdac_routing_test.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line,ls_wkct,g_s_date) > 0	then
		dw_kdac_routing.visible = true
		dw_kdac_routing.enabled = true
		dw_kdac_routing_test.visible = true
		dw_kdac_routing_test.enabled = true
	else
		messagebox("확인","생산기술 Routing 정보가 없는 품번입니다")
	end if
	
end if
end event

type dw_wcitem from u_pism_dw within w_pism030i
integer x = 2341
integer y = 256
integer width = 2267
integer height = 2208
integer taborder = 40
string dragicon = "bmp\row.ico"
boolean bringtotop = true
string title = "조내 유사군별 생산모델"
string dataobject = "d_pism030u_02_rev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_dragdrop = true
string is_dragicon = "bmp\row.ico"
end type

event clicked;call super::clicked;dw_kdac_routing.visible 		= false
dw_kdac_routing_test.visible 	= false
dw_kdac_routing.enabled 		= false
dw_kdac_routing_test.enabled 	= false

If row <= 0 Then Return 

		
end event

event doubleclicked;if row > 0 then
	string ls_itno,ls_plant,ls_div,ls_line,ls_raitno,ls_wkct
	ls_plant		=	this.object.areacode[row]
	ls_div		=	this.object.divisioncode[row] 
	ls_itno		=	this.object.itemcode[row]
	ls_wkct		=	this.object.workcenter[row] 
	ls_line		=	trim(this.object.sublinecode[row])	+	trim(this.object.sublineno[row])
	dw_kdac_routing.reset()
	dw_kdac_routing_test.reset()	
	ls_raitno	=	f_rtn_conv_itno(ls_plant,ls_div,ls_itno,g_s_date)
	if	ls_raitno	<>	ls_itno	then
		messagebox("확인", trim(ls_itno) + "  품번은 유사 품번입니다. 대표품번 " + trim(ls_raitno) + &
			                   "의 Routing 정보가 조회 됩니다 " )
		ls_itno	=	ls_raitno
	end if
	if dw_kdac_routing.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line,ls_wkct,g_s_date) +  &
	   dw_kdac_routing_test.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line,ls_wkct,g_s_date) > 0	then
		dw_kdac_routing.visible = true
		dw_kdac_routing.enabled = true
		dw_kdac_routing_test.visible = true
		dw_kdac_routing_test.enabled = true
	else
		messagebox("확인","생산기술 Routing 정보가 없는 품번입니다")
	end if	
end if

end event

event dragwithin;call super::dragwithin;This.Modify("dragwithin_row.Expression = '" + String(row) + "'") 
il_seqChg_tarRow = row 
This.SetRedraw(True) 
end event

event ue_lbuttonup;Integer I 
end event

type dw_routing_p from datawindow within w_pism030i
boolean visible = false
integer x = 2633
integer y = 608
integer width = 411
integer height = 432
integer taborder = 160
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_pism030u_01_p_rev"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_routing_print from datawindow within w_pism030i
boolean visible = false
integer x = 2560
integer y = 672
integer width = 686
integer height = 400
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_pism030u_routing_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

event retrieveend;integer i
for i = 1 to rowcount
	if is_olditno <> this.object.rcitno[i] then
		this.object.rcitno[i] = is_olditno
	end if
next
end event

type dw_routing_test_print from datawindow within w_pism030i
boolean visible = false
integer x = 3401
integer y = 672
integer width = 686
integer height = 400
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_pism030u_routing_test_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

event retrieveend;integer i
for i = 1 to rowcount
	if is_olditno <> this.object.rcitno[i] then
		this.object.rcitno[i] = is_olditno
	end if
next
end event

type pb_print from picturebutton within w_pism030i
integer x = 4288
integer y = 60
integer width = 183
integer height = 128
integer taborder = 120
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;if ( dw_routing.getselectedrow(0) + dw_wcitem.getselectedrow(0) ) < 1 then
	messagebox("확인","선택 후 출력이 가능합니다")
	return
end if

integer i,ln_rowcount
string ls_itno,ls_plant,ls_div,ls_line,ls_raitno,ls_wkct
ln_rowcount	=	dw_routing.rowcount()
for i = 1 to ln_rowcount
	if dw_routing.isselected(i) =true then
		dw_routing_print.reset()
		ls_plant		=	dw_routing.object.areacode[i]
		ls_div		=	dw_routing.object.divisioncode[i]
		ls_itno		=	dw_routing.object.itemcode[i]
		is_olditno	=	dw_routing.object.itemcode[i]
		ls_wkct		=	dw_routing.object.workcenter[i]
		ls_line		=	trim(dw_routing.object.sublinecode[i])	+	trim(dw_routing.object.sublineno[i])
		ls_raitno	=	f_rtn_conv_itno(ls_plant,ls_div,ls_itno,g_s_date)
//		if	ls_raitno	<>	ls_itno	then
//			ls_itno	=	ls_raitno
//		end if
		if dw_routing_print.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_raitno,ls_line,ls_wkct,g_s_date) > 0 then
			dw_routing_print.print()
		end if
		if dw_routing_test_print.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_raitno,ls_line,ls_wkct,g_s_date) > 0 then
			dw_routing_test_print.print()
		end if
	end if
next

ln_rowcount	=	dw_wcitem.rowcount()
for i = 1 to ln_rowcount
	if dw_wcitem.isselected(i) =true then
		dw_routing_test_print.reset()
		ls_plant		=	dw_wcitem.object.areacode[i]
		ls_div		=	dw_wcitem.object.divisioncode[i]
		ls_itno		=	dw_wcitem.object.itemcode[i]
		is_olditno	=	dw_wcitem.object.itemcode[i]
		ls_wkct		=	dw_wcitem.object.workcenter[i]
		ls_line		=	trim(dw_wcitem.object.sublinecode[i])	+	trim(dw_wcitem.object.sublineno[i])
		ls_raitno	=	f_rtn_conv_itno(ls_plant,ls_div,ls_itno,g_s_date)
//		if	ls_raitno	<>	ls_itno	then
//			ls_itno	=	ls_raitno
//		end if
		if dw_routing_print.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_raitno,ls_line,ls_wkct,g_s_date) > 0 then
			dw_routing_print.print()
		end if
		if dw_routing_test_print.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_raitno,ls_line,ls_wkct,g_s_date) > 0 then
			dw_routing_test_print.print()
		end if
	end if
next
messagebox("확인","Routing 정보 출력 완료")
end event

type st_4 from statictext within w_pism030i
integer x = 4169
integer y = 192
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Routing 출력"
alignment alignment = center!
boolean focusrectangle = false
end type

