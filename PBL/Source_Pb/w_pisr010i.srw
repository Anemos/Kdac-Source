$PBExportHeader$w_pisr010i.srw
$PBExportComments$타공장 납입주기및편수조회
forward
global type w_pisr010i from window
end type
type sle_division from singlelineedit within w_pisr010i
end type
type st_3 from statictext within w_pisr010i
end type
type sle_area from singlelineedit within w_pisr010i
end type
type st_2 from statictext within w_pisr010i
end type
type pb_2 from picturebutton within w_pisr010i
end type
type dw_oldtime from datawindow within w_pisr010i
end type
type dw_1 from datawindow within w_pisr010i
end type
type gb_2 from groupbox within w_pisr010i
end type
type gb_1 from groupbox within w_pisr010i
end type
end forward

global type w_pisr010i from window
integer width = 1431
integer height = 1712
boolean titlebar = true
string title = "납입주기등록및수정"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
sle_division sle_division
st_3 st_3
sle_area sle_area
st_2 st_2
pb_2 pb_2
dw_oldtime dw_oldtime
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
end type
global w_pisr010i w_pisr010i

type variables
str_pisr_partkb 	istr_partkb
String 	is_hisFlag 	// 'N' : 신규등록, 'Y' : 수정후저장
String 	is_saveFlag 	// 'N' : 저장불능, 'Y' : 저장가능
String 	is_lastDate, is_inputDate
Boolean	ib_Open
Integer	ii_saveCount
end variables

on w_pisr010i.create
this.sle_division=create sle_division
this.st_3=create st_3
this.sle_area=create sle_area
this.st_2=create st_2
this.pb_2=create pb_2
this.dw_oldtime=create dw_oldtime
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.sle_division,&
this.st_3,&
this.sle_area,&
this.st_2,&
this.pb_2,&
this.dw_oldtime,&
this.dw_1,&
this.gb_2,&
this.gb_1}
end on

on w_pisr010i.destroy
destroy(this.sle_division)
destroy(this.st_3)
destroy(this.sle_area)
destroy(this.st_2)
destroy(this.pb_2)
destroy(this.dw_oldtime)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;//Long 		ll_rowcount
//String	ls_sleText
//
//ib_Open = True
//ii_saveCount = 0
//
//f_pisc_win_center_move(this)		//POPUP 화면가운데 정렬
//
//istr_partkb = Message.PowerObjectParm	//Argumant 받기 
//
//  SELECT TMSTAREA.AreaName  
//    INTO :ls_sleText  
//    FROM TMSTAREA  
//   WHERE TMSTAREA.AreaCode = :istr_partkb.areacode   
//	USING	sqlpis	;
//	
//sle_area.Text = ls_sleText
//
//  SELECT TMSTDIVISION.DivisionName  
//    INTO :ls_sleText  
//    FROM TMSTDIVISION  
//   WHERE TMSTDIVISION.AreaCode 		= :istr_partkb.areacode AND  
//         TMSTDIVISION.DivisionCode 	= :istr_partkb.divcode   
//	USING	sqlpis	;
//
//sle_division.Text = ls_sleText
//
//dw_cycle.ReSet()
//dw_cycle.SetTransObject(sqlpis)
//dw_cycle.InsertRow(1)
//wf_win_reset( istr_partkb.suppcode )
//
end event

type sle_division from singlelineedit within w_pisr010i
integer x = 768
integer y = 72
integer width = 384
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_pisr010i
integer x = 581
integer y = 84
integer width = 187
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "공장:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_area from singlelineedit within w_pisr010i
integer x = 247
integer y = 72
integer width = 320
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisr010i
integer x = 69
integer y = 84
integer width = 201
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "지역:"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_pisr010i
integer x = 1047
integer y = 1472
integer width = 357
integer height = 136
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
boolean originalsize = true
end type

event clicked;closewithreturn(parent, String(ii_savecount))
end event

type dw_oldtime from datawindow within w_pisr010i
integer x = 18
integer y = 748
integer width = 1381
integer height = 708
boolean enabled = false
string title = "none"
string dataobject = "d_pisr012u_03"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_pisr010i
integer x = 41
integer y = 212
integer width = 1330
integer height = 492
integer taborder = 20
string title = "none"
string dataobject = "d_pisr010i_01"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//String 	ls_colName, ls_suppCode, ls_suppName, ls_Null, ls_Date
//Integer 	li_suppTerm, li_suppCycle, li_suppEditNo, I 
//Long		ll_Row
//
//setNull(ls_Null)
//DataWindowChild ldwc
//
//ls_colName = This.GetcolumnName()
//Choose Case ls_colName
//	Case 'suppliercode'
//		IF wf_win_reset(data) <> 0 THEN
//			this.SetItem(row , "suppliercode"	, ls_Null )
//			this.SetItem(row , "supplierkorname", ls_Null )
//			this.SetItem(row , "supplierno"		, ls_Null )
//			this.SetFocus()
//			return 1
//		END IF
//		istr_partkb.suppcode = data
//	Case 'applyfrom'
//		IF (Not isDate(data)) Then
//			MessageBox( "입력오류", "적용시작일자를 YYYY.MM.DD 형식으로 입력하여주세요.", &
//			            Information!)		
//			this.SetItem(1 , "applyfrom", is_lastdate )
//			Return 1			
//		End IF
//		f_pisc_get_date_convert(ls_Date, "YYYY.MM.DD", ls_Date) 
////		ls_Date = f_pisr_getdaybefore( data, 0 )		//입력한 날자를 YYYY.MM.DD 형식으로 변경
//		If ls_Date < is_lastdate Then 
//			MessageBox( "입력오류", "적용시작일자는 시스템일자,수정이전 적용시작일자, ~r~n " + &
//			            "최근간판발주일자들보다 이후여야 합니다.", Information! )		
//			this.SetItem(1 , "applyfrom", is_lastdate )
//			this.SetFocus()
//			return -1
//		End If
//		this.SetItem(1 , "applyfrom", ls_Date )
//		is_inputDate = ls_Date 
//		ll_Row = dw_newtime.GetRow()
//		IF ll_Row > 0 THEN 
//			FOR I = 1 TO ll_Row
//				dw_newtime.SetItem(I , "applyfrom", ls_Date )
//			NEXT
//		END IF
//	Case 'supplyterm'
//		li_suppTerm = Integer(data) 
//		If li_suppTerm > 1 Then 
//			This.SetItem(row, "supplyeditno", 1)
//			wf_setnapipTime(1, '')
//		End IF 
//	Case 'supplyeditno'
//		li_suppEditNo 	= Integer(data)
//		li_suppTerm 	= This.GetItemNumber(row, "supplyterm")
//		li_suppCycle 	= This.GetItemNumber(row, "supplycycle")
//		
//		If wf_supplyTerm_validChk(ls_colName, li_suppTerm, li_suppEditNo, li_suppCycle) <> 0 Then Return 1 
//		wf_setnapipTime(li_suppEditNo, '')
//	Case 'supplycycle'
//		li_suppCycle 	= Integer(data)
//		li_suppTerm 	= This.GetItemNumber(row, "supplyterm")
//		li_suppEditNo 	= This.GetItemNumber(row, "supplyeditno")
//		If wf_supplyTerm_validChk(ls_colName, li_suppTerm, li_suppEditNo, li_suppCycle) <> 0 Then Return 1 
//End Choose 
//
//is_saveflag = 'Y'
//return 0
end event

event itemerror;Return 1
end event

event retrieveend;//String 	ls_suppCode
//Long 		ll_Row
//
//ll_Row = this.GetRow()
//ls_suppCode	= this.GetItemString( ll_Row, 'suppliercode' )
//
//If wf_win_reset( ls_suppCode ) <> 0 Then return 
//
//
end event

event buttonclicked;//str_pisr_return lstr_Rtn
//String	ls_Null
//SetNull( ls_Null )
//
//istr_partkb.flag = 2			//외주업체(전체)
//OpenWithParm ( w_pisr012i, istr_partkb )
//lstr_Rtn = Message.PowerObjectParm
//IF lstr_Rtn.code = '' Then Return
//This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
//This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
//This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
//
//IF wf_win_reset(lstr_Rtn.code) <> 0 THEN
//	this.SetItem(row , "suppliercode"	, ls_Null )
//	this.SetItem(row , "supplierkorname", ls_Null )
//	this.SetItem(row , "supplierno"		, ls_Null )
//	this.SetFocus()
//	return 1
//END IF
//
//istr_partkb.suppcode = lstr_Rtn.code
//is_saveflag = 'Y'
//
//Return
//
end event

type gb_2 from groupbox within w_pisr010i
integer x = 18
integer y = 12
integer width = 1385
integer height = 160
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

type gb_1 from groupbox within w_pisr010i
integer x = 18
integer y = 160
integer width = 1385
integer height = 572
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

