$PBExportHeader$w_pisr200i.srw
$PBExportComments$이원화업체입고현황
forward
global type w_pisr200i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr200i
end type
type uo_division from u_pisc_select_division within w_pisr200i
end type
type uo_today from u_pisc_date_applydate within w_pisr200i
end type
type dw_2 from u_vi_std_datawindow within w_pisr200i
end type
type dw_condition from datawindow within w_pisr200i
end type
type gb_3 from groupbox within w_pisr200i
end type
type gb_4 from groupbox within w_pisr200i
end type
type gb_2 from groupbox within w_pisr200i
end type
type dw_print from datawindow within w_pisr200i
end type
end forward

global type w_pisr200i from w_ipis_sheet01
event ue_init ( )
uo_area uo_area
uo_division uo_division
uo_today uo_today
dw_2 dw_2
dw_condition dw_condition
gb_3 gb_3
gb_4 gb_4
gb_2 gb_2
dw_print dw_print
end type
global w_pisr200i w_pisr200i

type variables
str_pisr_partkb istr_partKB
String	is_searchKey, is_itemsubName
end variables

event ue_init();
dw_print.Visible = False
//Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회
//dw_pisr010u_02.Object.Enabled = False



end event

on w_pisr200i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_today=create uo_today
this.dw_2=create dw_2
this.dw_condition=create dw_condition
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_2=create gb_2
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_today
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_condition
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.dw_print
end on

on w_pisr200i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_today)
destroy(this.dw_2)
destroy(this.dw_condition)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.dw_print)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Height= newHeight - ( dw_2.y + ls_status )
dw_2.Width = newwidth - ( dw_2.x + ls_gap )

end event

event ue_retrieve;call super::ue_retrieve;Long 		ll_Row
String	ls_itemCode, ls_itemName

istr_partKB.applydate = uo_today.is_uo_date
dw_condition.AcceptText()
ll_Row		= dw_condition.GetRow()
ls_itemCode	= dw_condition.GetItemString(ll_Row, 'itemcode')
ls_itemName = dw_condition.GetItemString(ll_Row, 'itemname')

If isNull(ls_itemName) Then 
	IF isNull(ls_ItemCode) Or Trim(ls_itemCode) = '' Then
		ls_itemCode = '%'
	Else
		ls_itemCode = '%' + ls_itemCode + '%'
	End If
End If

istr_partkb.itemcode = ls_itemCode

dw_2.SetRedraw(False)
dw_2.SetTransObject(Sqlpis)
dw_2.Retrieve( istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode, istr_partKB.applydate ) 
dw_2.SetRedraw(True)

//MessageBox( "테스트", istr_partkb.areacode+','+istr_partkb.divcode+','+istr_partkb.suppcode+','+istr_partkb.itemcode+','+istr_partkb.applydate  )


end event

event open;call super::open;
this.PostEvent ( "ue_init" )

dw_condition.SetTransObject(sqlpis)
dw_condition.InsertRow(0)

end event

event ue_postopen;call super::ue_postopen;
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

end event

event ue_print;call super::ue_print;Long 		ll_Row
String	ls_itemCode
str_easy lstr_prt

istr_partKB.applydate = uo_today.is_uo_date
dw_condition.AcceptText()
ls_itemCode	= dw_condition.GetItemString(1, 'itemcode')

IF isNull(ls_ItemCode) Or Trim(ls_itemCode) = '' Then	ls_itemCode = '%'

istr_partkb.itemcode = ls_itemCode

//dw_2.SetRedraw(False)
//dw_2.SetTransObject(Sqlpis)
//dw_2.Retrieve( istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode, istr_partKB.applydate ) 
//dw_2.SetRedraw(True)

//ldt_nowTime	= f_pisc_get_date_nowtime()					//현재 시스템시간
dw_print.DataObject = "d_pisr200p_01"
dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve( istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode, istr_partKB.applydate ) 
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '이원화 품번 발주현황 출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

return 

//MessageBox( "테스트", istr_partkb.areacode+','+istr_partkb.divcode+','+istr_partkb.suppcode+','+istr_partkb.itemcode+','+istr_partkb.applydate  )


//Long 		ll_Row
//String	ls_suppCode, ls_itemCode, ls_productGroup
//DateTime	ldt_nowTime
//str_easy lstr_prt
//Long		ll_days1, ll_days2
//
//dw_condition.AcceptText()
//
//ll_Row		= dw_condition.GetRow()
//ls_suppCode	= dw_condition.GetItemString(ll_Row, 'suppliercode')
//If isNull(ls_suppCode) Or Trim(ls_suppCode) = '' Then ls_suppCode = '%'
//
//ls_itemCode	= dw_condition.GetItemString(ll_Row, 'itemcode' )
//If isNull(ls_itemCode) Or Trim(ls_itemCode) = '' Then ls_itemCode = '%'
//
//dw_condition2.AcceptText()
//ll_Row				= dw_condition2.GetRow()
//ls_productGroup	= dw_condition2.GetItemString(ll_Row, 'productgroup')
//If isNull(ls_productGroup) Or Trim(ls_productGroup) = '' Then ls_productGroup = '%'
//
//ll_days1	= Long(sle_1.Text)
//ll_days2	= Long(sle_2.Text)
//
//ldt_nowTime	= f_pisc_get_date_nowtime()					//현재 시스템시간
//dw_print.DataObject = "d_pisr170p_01"
//dw_print.SetTransObject(Sqlpis)				
//dw_print.Retrieve( uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_suppCode, ls_itemCode, ls_productGroup, ll_days1, ll_days2, ldt_nowTime )
//lstr_prt.transaction = sqlpis
//lstr_prt.datawindow	= dw_print
//lstr_prt.title			= '납기지연간판리스트 출력'
//OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//
//return 
//	
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr200i
end type

type uo_area from u_pisc_select_area within w_pisr200i
event destroy ( )
integer x = 805
integer y = 72
integer taborder = 40
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;//ib_allflag = True
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode

end event

type uo_division from u_pisc_select_division within w_pisr200i
event destroy ( )
integer x = 1312
integer y = 72
integer taborder = 60
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
end event

type uo_today from u_pisc_date_applydate within w_pisr200i
event destroy ( )
integer x = 32
integer y = 72
integer taborder = 80
boolean bringtotop = true
end type

on uo_today.destroy
call u_pisc_date_applydate::destroy
end on

type dw_2 from u_vi_std_datawindow within w_pisr200i
integer x = 14
integer y = 388
integer width = 2578
integer height = 1108
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisr200i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;this.AcceptText()
end event

type dw_condition from datawindow within w_pisr200i
integer x = 50
integer y = 236
integer width = 2848
integer height = 116
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition2"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;
str_pisr_return lstr_Rtn

istr_partkb.flag = 1			//외주자재list (지역,공장)
OpenWithParm ( w_pisr013i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
This.SetItem(row,'itemcode'			, lstr_Rtn.code)
This.SetItem(row,'itemname'			, lstr_Rtn.name)
This.SetItem(row,'itemspec'			, lstr_Rtn.nicname)

Return

end event

event itemchanged;String	ls_itemCode, ls_itemName, ls_itemSpec  
Integer 	li_itemChk
String	ls_Null

SetNull(ls_Null)

ls_itemCode = data

IF IsNull(ls_itemCode) THEN
	This.SetItem(row, 'itemname', ls_Null)
	This.SetItem(row, 'itemspec', ls_Null)
ELSE
  SELECT count(*)  
    INTO :li_itemChk  
    FROM TMSTPARTKB  
   WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode AND  
         TMSTPARTKB.DivisionCode	= :istr_partkb.divcode  AND  
         TMSTPARTKB.ItemCode 		= :ls_itemCode 
	USING	sqlpis	;
	IF li_itemChk > 0 THEN
//	IF f_pisr_partkbitemvalid( istr_partkb.areacode, istr_partkb.areacode, ls_itemCode ) THEN
		  SELECT TMSTITEM.ItemName, TMSTITEM.ItemSpec    
			 INTO :ls_itemName,  
			 		:ls_itemSpec  
			 FROM TMSTITEM  
			WHERE TMSTITEM.ItemCode = :ls_itemCode
			USING sqlpis	;
		This.SetItem(row, 'itemname', ls_itemName)
		This.SetItem(row, 'itemspec', ls_itemSpec)
	ELSE
//		MessageBox( "입력오류", "품번이 올바르지 않거나 취급품목이 아닙니다.", Information! )
		This.SetItem(row, 'itemname', ls_Null)
		This.SetItem(row, 'itemspec', ls_Null)
		Return 1
	END IF
END IF


end event

event itemerror;Return 1
end event

type gb_3 from groupbox within w_pisr200i
integer x = 18
integer width = 704
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisr200i
integer x = 736
integer width = 1157
integer height = 192
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisr200i
integer x = 18
integer y = 180
integer width = 2903
integer height = 192
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_pisr200i
integer x = 2382
integer y = 528
integer width = 987
integer height = 1032
integer taborder = 71
boolean titlebar = true
string title = "납기지연간판LIST 출력"
string dataobject = "d_pisr200p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

