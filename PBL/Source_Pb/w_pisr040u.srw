$PBExportHeader$w_pisr040u.srw
$PBExportComments$간판 이원화비율 수정
forward
global type w_pisr040u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr040u
end type
type uo_division from u_pisc_select_division within w_pisr040u
end type
type uo_today from u_pisc_date_applydate within w_pisr040u
end type
type dw_pisr040u_01 from u_vi_std_datawindow within w_pisr040u
end type
type dw_condition from datawindow within w_pisr040u
end type
type gb_3 from groupbox within w_pisr040u
end type
type gb_4 from groupbox within w_pisr040u
end type
type gb_2 from groupbox within w_pisr040u
end type
end forward

global type w_pisr040u from w_ipis_sheet01
event ue_init ( )
uo_area uo_area
uo_division uo_division
uo_today uo_today
dw_pisr040u_01 dw_pisr040u_01
dw_condition dw_condition
gb_3 gb_3
gb_4 gb_4
gb_2 gb_2
end type
global w_pisr040u w_pisr040u

type variables
str_pisr_partkb istr_partKB
String	is_searchKey, is_itemsubName
end variables

event ue_init();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회
//dw_pisr010u_02.Object.Enabled = False



end event

on w_pisr040u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_today=create uo_today
this.dw_pisr040u_01=create dw_pisr040u_01
this.dw_condition=create dw_condition
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_today
this.Control[iCurrent+4]=this.dw_pisr040u_01
this.Control[iCurrent+5]=this.dw_condition
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.gb_2
end on

on w_pisr040u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_today)
destroy(this.dw_pisr040u_01)
destroy(this.dw_condition)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr040u_01.Height= newHeight - ( dw_pisr040u_01.y + ls_status )
dw_pisr040u_01.Width = newwidth - ( dw_pisr040u_01.x + ls_gap )

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

dw_pisr040u_01.SetRedraw(False)
//dw_pisr040u_01.DataObject = "d_pisr040u_01"
dw_pisr040u_01.SetTransObject(Sqlpis)
dw_pisr040u_01.Retrieve( istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode, istr_partKB.applydate ) 
dw_pisr040u_01.SetRedraw(True)

//MessageBox( "테스트", istr_partkb.areacode+','+istr_partkb.divcode+','+istr_partkb.suppcode+','+istr_partkb.itemcode+','+istr_partkb.applydate  )


end event

event open;call super::open;
this.PostEvent ( "ue_init" )

dw_condition.SetTransObject(sqlpis)
dw_condition.InsertRow(0)

end event

event ue_save;call super::ue_save;Long 		ll_Row, ll_inputRate, ll_rateSum
String 	ls_areaCode, ls_divCode, ls_itemCode, ls_SuppCode, ls_itemName, ls_suppName
String	ls_olditemName, ls_olditem
Integer 	I
String	ls_message, ls_message1

ls_message = ''; ls_message1 = ''

ll_Row = dw_pisr040u_01.RowCount() 
IF ll_Row < 1 THEN Return 1

dw_pisr040u_01.AcceptText()

sqlpis.AutoCommit = False
ls_olditem = ''
ll_rateSum = 0

SetPointer(HourGlass!)

FOR I = 1 TO ll_Row STEP 1
	ls_areaCode		= dw_pisr040u_01.GetItemString( I, 'areacode' ) 
	ls_divCode		= dw_pisr040u_01.GetItemString( I, 'divisioncode' ) 
	ls_itemCode		= dw_pisr040u_01.GetItemString( I, 'itemcode' ) 
	ls_SuppCode		= dw_pisr040u_01.GetItemString( I, 'suppliercode' ) 
	ls_itemName		= dw_pisr040u_01.GetItemString( I, 'itemname' ) 
	ls_suppName		= dw_pisr040u_01.GetItemString( I, 'suppliername' ) 
	ll_inputRate	= dw_pisr040u_01.GetItemNumber( I, 'rerate' ) 
	IF isNull(ll_inputRate) THEN dw_pisr040u_01.SetItem( I, 'rerate', 0 ) 
	
  UPDATE TMSTORDERRATE  
	  SET OrderRate = :ll_inputRate,
			LastEmp		= 'Y',
			LastDate		= Getdate()
	WHERE TMSTORDERRATE.AreaCode 		= :ls_areaCode  AND  
			TMSTORDERRATE.DivisionCode = :ls_divCode   AND  
			TMSTORDERRATE.ItemCode 		= :ls_itemCode  AND  
			TMSTORDERRATE.SupplierCode = :ls_SuppCode    
	USING sqlpis  ;
	IF sqlpis.SqlCode <> 0 THEN
//		MessageBox( "저장실패", ls_itemName + " 의 " + ls_suppName + " 항목의 수정에 실패했습니다. ", StopSign! )
		ls_message  = 'TMSTORDERRATE_Err' 
		ls_message1 = ls_itemName + " 의 " + ls_suppName
		GOTO RollBack_
	END IF

	IF ls_olditem <> '' AND ls_olditem <> ls_itemCode THEN 
		IF ll_rateSum = 100 THEN
			ls_olditem = ls_itemCode
			ll_rateSum = ll_inputRate
		ELSE
//			MessageBox( "저장실패", ls_olditem + " : " + ls_olditemName + &
//			                        " 의 이원화비율합이 100% 가되지 않습니다. ", StopSign! )
			ls_message  = '100%'
			ls_message1 = ls_olditem + " : " + ls_olditemName
			GOTO RollBack_
		END IF
	ELSE
		ls_olditemName = ls_itemName
		ls_olditem 		= ls_itemCode
		ll_rateSum 		= ll_rateSum + ll_inputRate
	END IF
NEXT

IF ll_rateSum <> 100 THEN
//	MessageBox( "저장실패", ls_olditem + " : " + ls_olditemName + &
//									" 의 이원화비율합이 100% 가되지 않습니다. ", StopSign! )
	ls_message  = '100%'
	ls_message1 = ls_olditem + " : " + ls_olditemName
	GOTO RollBack_
END IF

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True

SetPointer(Arrow!)
MessageBox( "저장완료", "저장을 마쳤습니다.", Information! )
this.TriggerEvent( "ue_retrieve" )
Return 0

RollBack_:
Rollback Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
CHOOSE CASE ls_message
	CASE 'TMSTORDERRATE_Err'
		MessageBox( "저장실패", ls_message1 + " 항목의 수정에 실패했습니다. ", StopSign! )
	CASE '100%'
		MessageBox( "저장실패", ls_message1 + "의 이원화비율합이 100% 가되지 않습니다. ", StopSign! )
	CASE ELSE
		MessageBox( "저장실패", "저장에 실패하였습니다.", Information! )
END CHOOSE


Return -1


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

type uo_status from w_ipis_sheet01`uo_status within w_pisr040u
end type

type uo_area from u_pisc_select_area within w_pisr040u
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

type uo_division from u_pisc_select_division within w_pisr040u
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

type uo_today from u_pisc_date_applydate within w_pisr040u
event destroy ( )
integer x = 32
integer y = 72
integer taborder = 80
boolean bringtotop = true
end type

on uo_today.destroy
call u_pisc_date_applydate::destroy
end on

type dw_pisr040u_01 from u_vi_std_datawindow within w_pisr040u
integer x = 14
integer y = 388
integer width = 3584
integer height = 1108
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisr040u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;this.AcceptText()
end event

type dw_condition from datawindow within w_pisr040u
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
		  SELECT TMSTITEM.ItemName  
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

type gb_3 from groupbox within w_pisr040u
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
end type

type gb_4 from groupbox within w_pisr040u
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
end type

type gb_2 from groupbox within w_pisr040u
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
end type

