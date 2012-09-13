$PBExportHeader$w_pisr130i.srw
$PBExportComments$발주서(발주간판업체인계목록)발행현황
forward
global type w_pisr130i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr130i
end type
type uo_division from u_pisc_select_division within w_pisr130i
end type
type uo_from from u_pisc_date_applydate within w_pisr130i
end type
type uo_to from u_pisc_date_applydate_1 within w_pisr130i
end type
type st_2 from statictext within w_pisr130i
end type
type dw_condition from datawindow within w_pisr130i
end type
type st_3 from statictext within w_pisr130i
end type
type st_cycle from statictext within w_pisr130i
end type
type dw_pisr130i_01 from u_vi_std_datawindow within w_pisr130i
end type
type gb_1 from groupbox within w_pisr130i
end type
type gb_3 from groupbox within w_pisr130i
end type
type gb_2 from groupbox within w_pisr130i
end type
type dw_print from datawindow within w_pisr130i
end type
end forward

global type w_pisr130i from w_ipis_sheet01
integer width = 3963
boolean minbox = true
event ue_init ( )
uo_area uo_area
uo_division uo_division
uo_from uo_from
uo_to uo_to
st_2 st_2
dw_condition dw_condition
st_3 st_3
st_cycle st_cycle
dw_pisr130i_01 dw_pisr130i_01
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
dw_print dw_print
end type
global w_pisr130i w_pisr130i

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
end variables

event ue_init();
dw_print.Visible = False

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회

end event

on w_pisr130i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_2=create st_2
this.dw_condition=create dw_condition
this.st_3=create st_3
this.st_cycle=create st_cycle
this.dw_pisr130i_01=create dw_pisr130i_01
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_from
this.Control[iCurrent+4]=this.uo_to
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_condition
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_cycle
this.Control[iCurrent+9]=this.dw_pisr130i_01
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.dw_print
end on

on w_pisr130i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_2)
destroy(this.dw_condition)
destroy(this.st_3)
destroy(this.st_cycle)
destroy(this.dw_pisr130i_01)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.dw_print)
end on

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
ib_open = True
istr_partkb.areacode = uo_area.is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

end event

event open;call super::open;
dw_condition.SetTransObject(sqlpis)
dw_condition.Reset()
dw_condition.InsertRow(1)

This.TriggerEvent( "ue_init" )


end event

event ue_retrieve;call super::ue_retrieve;
If istr_partkb.suppcode = '%' Then 
	MessageBox('자료부족', '검색할 업체를 선택하세요', Information! )
	return
End If

String 	ls_From, ls_To
Long 		ll_Row

ls_From	= uo_from.is_uo_date
ls_To		= uo_to.is_uo_date

dw_pisr130i_01.SetTransObject(sqlpis)
ll_Row = dw_pisr130i_01.Retrieve(istr_partkb.areacode, istr_partkb.divcode, istr_partkb.suppcode, ls_From, ls_To)

If ll_Row < 1 Then 
	MessageBox('확인', '발행된 발주LIST가 존재하지 않습니다.', Information! )
End If	

Return

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr130i_01.Width = newwidth 	- ( dw_pisr130i_01.x + ls_gap * 2 )
dw_pisr130i_01.Height= newheight - ( dw_pisr130i_01.y + ls_status )

end event

event ue_print;call super::ue_print;
Long		ll_RowCnt
Integer	I
String	ls_suppcode, ls_orderNo
DateTime	ldt_null
Long		ll_Row
DateTime ldt_nowtime
str_easy lstr_prt

dw_condition.AcceptText()
ls_suppcode = dw_condition.GetItemString(1, 'suppliercode')
If isNull(ls_suppcode) Or trim(ls_suppcode) = '' Then 
	MessageBox( '확인', '해당 업체가 선택되지  않았습니다.', Information! )
	Return
End If

dw_pisr130i_01.AcceptText()

ll_Row = dw_pisr130i_01.GetRow()
If ll_Row < 1 Then 
	MessageBox( '확인', '출력할 발주리스트항목이 선택되지 않았습니다.', Information! )
	Return
End If

ls_orderNo = dw_pisr130i_01.GetItemString( ll_Row, 'partorderno' )
If isNull(ls_orderNo) Or Trim(ls_orderNo) = '' Then 
	MessageBox( '확인', '출력할 발주리스트항목이 선택되지 않았습니다.', Information! )
	Return
End If

dw_print.SetTransObject(Sqlpis)				
dw_print.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_suppCode, ls_orderNo)		
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '발주 LIST출력'
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

sqlpis.AutoCommit = False

ldt_nowtime	= f_pisc_get_date_nowtime()	//현재 시스템시간

  UPDATE TPARTORDERLIST  
     SET OrderRePrintDate 	= :ldt_nowtime  
   WHERE SupplierCode 		= :ls_suppCode 			AND  
         AreaCode 			= :istr_partkb.areacode AND  
         DivisionCode 		= :istr_partkb.divcode 	AND  
         PartOrderNo 		= :ls_orderNo    
   USING sqlpis       ;
If sqlpis.SqlCode = 0 Then
	//f_pisr_sqlchkopt( sqlpis, True )
	Commit Using sqlpis;
	sqlpis.AutoCommit = True
	Return  
Else 
	RollBack Using sqlpis;
	sqlpis.AutoCommit = True
	return 	
End If

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr130i
end type

type uo_area from u_pisc_select_area within w_pisr130i
integer x = 59
integer y = 72
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

End If

istr_partkb.areacode = is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)
dw_pisr130i_01.Reset()

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr130i
integer x = 571
integer y = 72
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)

dw_pisr130i_01.Reset()


end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_from from u_pisc_date_applydate within w_pisr130i
integer x = 1230
integer y = 72
integer taborder = 60
boolean bringtotop = true
end type

on uo_from.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;dw_pisr130i_01.Reset()

end event

type uo_to from u_pisc_date_applydate_1 within w_pisr130i
integer x = 2007
integer y = 72
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;
dw_pisr130i_01.Reset()

end event

type st_2 from statictext within w_pisr130i
integer x = 1929
integer y = 68
integer width = 73
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type dw_condition from datawindow within w_pisr130i
integer x = 50
integer y = 236
integer width = 2766
integer height = 124
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition3"
boolean border = false
boolean livescroll = true
end type

event itemchanged;str_pisr_return lstr_Rtn
String	ls_applyDate
Long		ll_Term, ll_editNo, ll_Cycle
String	ls_Null

SetNull(ls_Null)

dw_pisr130i_01.Reset()

lstr_Rtn.Code	= data

If isNull(lstr_Rtn.Code) Or Trim(lstr_Rtn.Code) = '' Then
	This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
	This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
	This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
	istr_partkb.suppcode = '%'
	st_cycle.Text = ''
End If

  SELECT Top 1
  			B.SupplierNo,   
			B.SupplierKorName  
	 INTO :lstr_Rtn.nicname,   
			:lstr_Rtn.name  
	 FROM TMSTPARTCYCLE	A,   
			TMSTSUPPLIER	B  
	WHERE A.SupplierCode = B.SupplierCode 			AND
			A.AreaCode 		= :istr_partkb.areacode AND  
			A.DivisionCode = :istr_partkb.divcode 	AND  
			A.SupplierCode = :lstr_Rtn.Code
	Using	sqlpis	;
	
If sqlpis.SqlCode <> 0 Then 
	MessageBox('입력오류', '업체코드가 올바르지 않습니다.', Information! )
	This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
	This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
	This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
	istr_partkb.suppcode = '%'
	st_cycle.Text = ''
	Return 1
End If

This.SetItem( This.GetRow(), 'supplierno'			, lstr_Rtn.nicname )
This.SetItem( This.GetRow(), 'supplierkorname'	, lstr_Rtn.name )
istr_partkb.suppcode = lstr_Rtn.Code


ls_applyDate = uo_from.is_uo_date

  SELECT TMSTPARTCYCLE.SupplyTerm,   
         TMSTPARTCYCLE.SupplyEditNo,   
         TMSTPARTCYCLE.SupplyCycle  
    INTO :ll_Term,   
         :ll_editNo,   
         :ll_Cycle  
    FROM TMSTPARTCYCLE  
   WHERE TMSTPARTCYCLE.AreaCode 		= :istr_partkb.areacode AND  
         TMSTPARTCYCLE.DivisionCode = :istr_partkb.divcode 	AND  
         TMSTPARTCYCLE.SupplierCode = :lstr_Rtn.code 			AND  
         TMSTPARTCYCLE.ApplyFrom 	<= :ls_applyDate			AND  
         TMSTPARTCYCLE.ApplyTo 		>= :ls_applyDate
	USING	sqlpis;

st_cycle.Text = string(ll_Term) + '-' + string(ll_editNo) + '-' + string(ll_Cycle)

Return

end event

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_applyDate
Long		ll_Term, ll_editNo, ll_Cycle

dw_pisr130i_01.Reset()

istr_partkb.flag = 3			//외주업체(지역,공장)
OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then 
	istr_partkb.suppcode = '%'
	Return
End If
This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
istr_partkb.suppcode = lstr_Rtn.code


ls_applyDate = uo_from.is_uo_date

  SELECT TMSTPARTCYCLE.SupplyTerm,   
         TMSTPARTCYCLE.SupplyEditNo,   
         TMSTPARTCYCLE.SupplyCycle  
    INTO :ll_Term,   
         :ll_editNo,   
         :ll_Cycle  
    FROM TMSTPARTCYCLE  
   WHERE TMSTPARTCYCLE.AreaCode 		= :istr_partkb.areacode AND  
         TMSTPARTCYCLE.DivisionCode = :istr_partkb.divcode 	AND  
         TMSTPARTCYCLE.SupplierCode = :lstr_Rtn.code 			AND  
         TMSTPARTCYCLE.ApplyFrom 	<= :ls_applyDate			AND  
         TMSTPARTCYCLE.ApplyTo 		>= :ls_applyDate
	USING	sqlpis;

st_cycle.Text = string(ll_Term) + '-' + string(ll_editNo) + '-' + string(ll_Cycle)

Return

end event

event itemerror;
return 1
end event

type st_3 from statictext within w_pisr130i
integer x = 2802
integer y = 260
integer width = 352
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "납입주기:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_cycle from statictext within w_pisr130i
integer x = 3163
integer y = 248
integer width = 297
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_pisr130i_01 from u_vi_std_datawindow within w_pisr130i
integer x = 18
integer y = 388
integer width = 2843
integer height = 1080
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr130i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_pisr130i
integer x = 23
integer width = 1147
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

type gb_3 from groupbox within w_pisr130i
integer x = 1189
integer width = 1303
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

type gb_2 from groupbox within w_pisr130i
integer x = 23
integer y = 184
integer width = 3470
integer height = 192
integer taborder = 20
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

type dw_print from datawindow within w_pisr130i
integer x = 2075
integer y = 488
integer width = 1093
integer height = 1032
integer taborder = 41
boolean titlebar = true
string title = "발주간판LIST 출력"
string dataobject = "d_pisr130p_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

