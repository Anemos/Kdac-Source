$PBExportHeader$w_pisf034i.srw
$PBExportComments$반출현황조회
forward
global type w_pisf034i from w_ipis_sheet01
end type
type st_2 from statictext within w_pisf034i
end type
type dw_condition from datawindow within w_pisf034i
end type
type dw_2 from u_vi_std_datawindow within w_pisf034i
end type
type dw_3 from u_vi_std_datawindow within w_pisf034i
end type
type uo_area from u_cmms_select_area within w_pisf034i
end type
type uo_division from u_cmms_select_division within w_pisf034i
end type
type uo_from from u_cmms_date_applydate within w_pisf034i
end type
type uo_to from u_cmms_date_applydate_1 within w_pisf034i
end type
type st_hsplitbar from u_cmms_splitbar within w_pisf034i
end type
type gb_1 from groupbox within w_pisf034i
end type
type gb_3 from groupbox within w_pisf034i
end type
type gb_2 from groupbox within w_pisf034i
end type
end forward

global type w_pisf034i from w_ipis_sheet01
integer width = 3963
event ue_init ( )
st_2 st_2
dw_condition dw_condition
dw_2 dw_2
dw_3 dw_3
uo_area uo_area
uo_division uo_division
uo_from uo_from
uo_to uo_to
st_hsplitbar st_hsplitbar
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
end type
global w_pisf034i w_pisf034i

type variables
str_cmms_partkb istr_partkb

boolean ib_opened = false
end variables

event ue_init();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_hsplitbar.of_Register(dw_2, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_3, st_hsplitbar.BELOW)

String	ls_deptname, ls_Null

SetNull(ls_Null)

SELECT cc_name  
	INTO :ls_deptname  
	FROM cc_master  
	WHERE cc_code = :g_s_deptcd
	USING	sqlcmms;

If sqlcmms.SqlCode <> 0 Then 
	dw_condition.SetItem( dw_condition.GetRow(), 'deptcode', ls_Null )
	dw_condition.SetItem( dw_condition.GetRow(), 'deptname', ls_Null )
	Return 
End If
dw_condition.SetItem( dw_condition.GetRow(), 'deptcode', g_s_deptcd )
dw_condition.SetItem( dw_condition.GetRow(), 'deptname', ls_deptname )

end event

on w_pisf034i.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_condition=create dw_condition
this.dw_2=create dw_2
this.dw_3=create dw_3
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_hsplitbar=create st_hsplitbar
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_condition
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.uo_from
this.Control[iCurrent+8]=this.uo_to
this.Control[iCurrent+9]=this.st_hsplitbar
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
end on

on w_pisf034i.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_condition)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_hsplitbar)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event open;call super::open;
dw_condition.SetTransObject(sqlcmms)
dw_condition.Reset()
dw_condition.InsertRow(1)

This.TriggerEvent( "ue_init" )

uo_from.id_uo_date = Date(String(mid(g_s_date,1,6), "@@@@.@@") + ".01")
uo_from.is_uo_date = String(uo_from.id_uo_date, 'YYYY.MM.DD')
uo_from.init_cal(uo_from.id_uo_date)
uo_from.set_date_format ('yyyy.mm.dd')
uo_from.TriggerEvent("ue_variable_set")
uo_from.TriggerEvent("ue_select")

end event

event ue_retrieve;call super::ue_retrieve;String	ls_deptcode, ls_suppcode
String 	ls_From, ls_To
Long 		ll_Row

dw_condition.AcceptText()
ls_deptcode	= dw_condition.GetItemString(1, 'deptcode')
ls_suppcode	= dw_condition.GetItemString(1, 'suppliercode')

//If isNull(ls_deptcode) Or Trim(ls_deptcode) = '' Then 
//	MessageBox('확인', '조회할 부서코드를 입력하세요.', Information! )
//	return
//End If
If isNull(ls_deptcode) Or Trim(ls_deptcode) = '' Then ls_deptcode = '%'
If isNull(ls_suppcode) Or Trim(ls_suppcode) = '' Then ls_suppcode = '%'

ls_From	= uo_from.is_uo_date
ls_To		= uo_to.is_uo_date

dw_2.SetTransObject(sqlcmms)
ll_Row = dw_2.Retrieve(gs_kmarea, gs_kmdivision, ls_deptcode, ls_suppcode, ls_From, ls_To)

If ll_Row < 1 Then 
	MessageBox('확인', '발행된 사급품반출LIST가 존재하지 않습니다.', Information! )
	Return
End If	

dw_2.selectrow(1,true)
dw_2.Event RowfocusChanged(1)
Return

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

st_hsplitbar.x 		= dw_3.x
st_hsplitbar.y 		= dw_3.y - ls_split
st_hsplitbar.Width 	= dw_3.Width 

end event

event activate;call super::activate;if ib_opened then
	if uo_area.is_uo_areacode <> gs_kmarea then
		uo_area.is_uo_areacode = gs_kmarea
		uo_area.dw_1.setitem(1,"DDDWCode",gs_kmarea)
		uo_area.triggerevent('ue_select')
	end if
	uo_division.is_uo_divisioncode = gs_kmdivision
	uo_division.dw_1.setitem(1,"DDDWCode",gs_kmdivision)
end if
ib_opened = true

dw_condition.SetTransObject(sqlcmms)
dw_2.SetTransObject(sqlcmms)
dw_3.SetTransObject(Sqlcmms)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisf034i
end type

type st_2 from statictext within w_pisf034i
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

type dw_condition from datawindow within w_pisf034i
integer x = 50
integer y = 236
integer width = 2665
integer height = 216
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf_condition2"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_deptcode, ls_deptname
String	ls_Null 
//DataWindowChild ldwc

this.AcceptText ( )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode'
			ls_suppcode	= data
		  SELECT A.SupplierNo,   
					A.SupplierKorName  
			 INTO :ls_suppno,   
					:ls_suppname  
			 FROM TMSTSUPPLIER	A  
			WHERE A.SupplierCode = :ls_suppcode 
			Using	sqlpis	;
			
			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
				This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
				This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
				istr_partkb.suppcode = '%'
				Return 1
			End If
			This.SetItem( This.GetRow(), 'supplierno'			, ls_suppno )
			This.SetItem( This.GetRow(), 'supplierkorname'	, ls_suppname )
			istr_partkb.suppcode = ls_suppcode
	Case 'deptcode' 
			ls_deptcode	= data
		  SELECT TMSTDEPT.DeptName  
			 INTO :ls_deptname  
			 FROM TMSTDEPT  
			WHERE TMSTDEPT.DeptCode = :ls_deptcode
			USING	sqlpis	;

			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'deptcode', ls_Null )
				This.SetItem( This.GetRow(), 'deptname', ls_Null )
				Return 1
			End If
			This.SetItem( This.GetRow(), 'deptname', ls_deptname )
End Choose 


end event

event buttonclicked;String	ls_buttonname, ls_data[]

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
		if f_code_search('d_lookup_comp', '', ls_data[]) then
			This.SetItem( row, 'suppliercode', ls_data[1] )
			This.SetItem( row, 'supplierkorname', ls_data[2] )
		else
			return 0
		end if
	CASE 'b_dept'
		IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
			This.SetItem(row, 'deptcode', ls_data[1])
			This.SetItem(row, 'deptname', ls_data[2])
		END IF
	CASE ELSE
			Return
END CHOOSE

Return

end event

event itemerror;
return 1
end event

type dw_2 from u_vi_std_datawindow within w_pisf034i
integer x = 18
integer y = 476
integer width = 3058
integer height = 1156
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisf034i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
If currentrow <= 0 Or RowCount() = 0 Then Return 

String	ls_buybackno, ls_buybackdate
//DateTime	ldt_buybacktime

ls_buybackno = This.GetItemString(currentrow, "buybackno") 
//ls_buybackdate = This.GetItemString(currentrow, "buybackdate") 
//ldt_buybacktime = This.GetItemDateTime(currentrow, "buybacktime") 

//ls_buybackdate = String(ldt_buybacktime, 'YYYY.MM.DD' )

dw_3.SetRedraw(False)
dw_3.SetTransObject(Sqlcmms)
dw_3.Retrieve(ls_buybackno)
dw_3.SetRedraw(True)

end event

type dw_3 from u_vi_std_datawindow within w_pisf034i
integer x = 18
integer y = 1652
integer width = 3054
integer height = 244
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisf034i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_cmms_select_area within w_pisf034i
integer x = 78
integer y = 72
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_opened Then
	f_cmms_retrieve_dddw_division(uo_division.dw_1, &
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
dw_2.Reset()
dw_3.Reset()
end event

on uo_area.destroy
call u_cmms_select_area::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode

if f_spacechk(gs_kmdivision) = -1 then
	ls_divisioncode = '%'
else
	ls_divisioncode = gs_kmdivision
end if
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,ls_divisioncode,false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

type uo_division from u_cmms_select_division within w_pisf034i
integer x = 617
integer y = 72
integer taborder = 70
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)

dw_2.Reset()
dw_3.Reset()
end event

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type uo_from from u_cmms_date_applydate within w_pisf034i
integer x = 1239
integer y = 72
integer taborder = 80
boolean bringtotop = true
end type

on uo_from.destroy
call u_cmms_date_applydate::destroy
end on

event ue_select;call super::ue_select;dw_2.reset()
dw_3.reset()
end event

type uo_to from u_cmms_date_applydate_1 within w_pisf034i
integer x = 1989
integer y = 72
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call u_cmms_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;dw_2.reset()
dw_3.reset()
end event

type st_hsplitbar from u_cmms_splitbar within w_pisf034i
integer x = 14
integer y = 1632
boolean bringtotop = true
end type

type gb_1 from groupbox within w_pisf034i
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
end type

type gb_3 from groupbox within w_pisf034i
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
end type

type gb_2 from groupbox within w_pisf034i
integer x = 23
integer y = 184
integer width = 2702
integer height = 276
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

