$PBExportHeader$uo_pur020_xplan.sru
$PBExportComments$구매담당 ( 담당구분 - 구매,자재, 구분-직접재,간접재)
forward
global type uo_pur020_xplan from userobject
end type
type dw_1 from datawindow within uo_pur020_xplan
end type
type st_1 from statictext within uo_pur020_xplan
end type
end forward

global type uo_pur020_xplan from userobject
integer width = 1001
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_xplan1,  string ag_xplan2,  string ag_color )
dw_1 dw_1
st_1 st_1
end type
global uo_pur020_xplan uo_pur020_xplan

type variables
Private :
			String is_xplan
			DataWindowChild idwc
end variables

forward prototypes
public function string uf_get_xplan ()
public subroutine uf_set_color (string ag_color)
public subroutine uf_autdivxplan_set (datawindow adw)
end prototypes

event ue_constructor(string ag_xplan1, string ag_xplan2, string ag_color);//////////////////////////////////////////
// argument : ag_xplan1 - 구매담당 ( '1' )  
//                        자재담당 ( '2' )
//
//            ag_xplan2 - 직접재 ('1')                    
//                        간접재 ('2')
//                        직/간접재 ('3')
//                        여주('Y')
//
//				  ag_color  - 'S'  : Sky
//                        'W'  : White
///////////////////////////////////////////

dw_1.SetTransObject(sqlca)

IF ag_xplan1 = '1' Then	//구매담당
	st_1.text = "구매담당"
	IF ag_xplan2 = '1' Then
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan01'")	//직접재		
	ElseIF ag_xplan2 = '2' Then
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan02'")	//간접재
	ElseIF ag_xplan2 = '3' Then
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan04'")	//직/간접재	
	ELSEIF ag_xplan2 = 'Y' Then										
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan05'")	//여주
	End If
	
	dw_1.Modify("xplan.dddw.DisplayColumn='com_coname'")
	dw_1.Modify("xplan.dddw.DataColumn='code'")
	
	dw_1.GetChild("xplan",idwc)
	idwc.SetTransObject(sqlca)
	idwc.Retrieve()
	dw_1.InsertRow(0)

ELSE
	//자재담당은 지역/공장별로 부여.
	st_1.text = "자재담당"	
	dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan03_01'")		
	dw_1.Modify("xplan.dddw.DisplayColumn='com_coname'")
	dw_1.Modify("xplan.dddw.DataColumn='code'")
	
	uf_autdivxplan_set(dw_1)
	
END IF
//Else	//자재담당
//	st_1.text = "자재담당"	
//	dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan03'")		
//End IF

//dw_1.Modify("xplan.dddw.DisplayColumn='com_coname'")
//dw_1.Modify("xplan.dddw.DataColumn='code'")

//dw_1.GetChild("xplan",idwc)
//idwc.SetTransObject(sqlca)
//idwc.Retrieve()
//dw_1.InsertRow(0)

//Color 변경
IF ag_color = 'S' Then
//	dw_1.Modify("DataWindow.Color = 15780518")	//sky
	dw_1.Modify("xplan.Background.Color = 15780518")	//sky
Else
//	dw_1.Modify("DataWindow.Color = 16777215")	//white
	dw_1.Modify("xplan.Background.Color = 16777215")	//white
End IF

//width
f_dddw_width_pura(dw_1,"xplan",idwc,"code",0)
end event

public function string uf_get_xplan ();Return is_xplan
end function

public subroutine uf_set_color (string ag_color);f_set_color_dw_column(dw_1,"xplan",ag_color)
end subroutine

public subroutine uf_autdivxplan_set (datawindow adw);//////////////////////////////////////////////////////////////////////////////////////////
// * 권한에 따라 지역, 공장 설정 *
//
//                        																2002.12.20  박병주
//
// 권한등록: -> KDAC종합정보시스템 -> 공통 -> 시스템관리 -> 프로그램 -> 사용자관리.
//          권한( 지역, 담당, 공장 )
// 예)
//    지역 = '' And 담당 = ''     --> 전지역 전공장 권한
//    지역 = '' And 담당 = 'M'    --> 기계생산담당 ( 다른지역의 M, S 공장 선택 가능 )
//		                     'J'    --> 진천생산담당 ( 다른지역의 B, L, T 공장 선택 가능 )-- M,S,H
//									'K'	 --> 군산							 P, N, O, K
//									'Y'	 --> 여주							 Y	
//    지역 = 'D' And 담당 = 'A' And 공장 = 'A'   --> 대구, 전장공장으로 Setting(선택불가).
/////////////////////////////////////////////////////////////////////////////////////////////////

/*  2004.06.11 박진규과정 요청 : 자재담당 선택 권한 변경
	 지역				담당				공장
	 g_s_autarea   g_s_autplnt    g_s_autdiv
	 
		지역 = 'D'  
		       공장 = 해당공장코드
				 공장 = ' '
				        담당 = 'M'	--> 기계생산담당 ( M, S )
						         'H'   --> (H,V,T,K)
									'Q'   --> (D,F)
									그외  --> 전체
		지역 = 'J'							
				공장 = 'H'				--> T
				       'S'				--> L
						 'M'				--> B
						 그외				--> (B, L, T)
		
		지역 = 'K'						--> K
		지역 = 'Y'						--> Y
		지역 = '그외'					--> 전체
*/
//////////////////////////////////////////////////////////////////////////////////////////
string ls_Rtn
String ls_Div_Syntax
Int	 li_Pos_From, li_Pos_To

adw.GetChild( 'xplan', idwc )
idwc.SetTransObject( SQLCA )
idwc.Retrieve( g_s_autarea )

ls_Div_Syntax = idwc.Describe( "DataWindow.Table.Select" )
ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'01'", "~~~'01~~~'" )
ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'INV070'", "~~~'INV070~~~'" )
ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "''", "~~~'~~~'" )
ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "not in", "in" )


If g_s_autarea = "D" Then
	IF g_s_autplnt = "M" Then		//기계생산담당  ( M, S )
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'M~~~', ~~~'S~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
	ElseIF g_s_autplnt = "H" Then //공조생산담당  ( H, V )
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'H~~~', ~~~'V~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )		
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
	Else
		IF g_s_autdiv = '' Then
			//대구 공장 전체 ( M, S, H, V )
			li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
			li_Pos_From += 4
			li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
			
			ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'M~~~', ~~~'S~~~', ~~~'H~~~', ~~~'V~~~' " + &
								 Mid( ls_Div_Syntax, li_Pos_To )		
			
			ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
		Else
			//해당공장만
			li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
			li_Pos_From += 4
			li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
			
			ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'" + g_s_autdiv + "~~~' " + &
								 Mid( ls_Div_Syntax, li_Pos_To )		
			
			ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
			
		End IF
	End IF
	
ElseIF g_s_autarea = "J" Then
	IF g_s_autdiv = "H" Then  //T
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'T~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )		
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
	ElseIF g_s_autdiv = "S" Then	//L
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'L~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )		
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
		
	ElseIF g_s_autdiv = "M" Then	//B 
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'B~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )		
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
	Else
		//진천 전체 ( B, L, T )
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'B~~~', ~~~'L~~~', ~~~'T~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )		
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
	End IF
	
ElseIF g_s_autarea = "K" Then	
	li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
	li_Pos_From += 4
	li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
	
	ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'K~~~' " + &
						 Mid( ls_Div_Syntax, li_Pos_To )		
	
	ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
ElseIF g_s_autarea = "Y" Then	
	li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
	li_Pos_From += 4
	li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
	
	ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'Y~~~' " + &
						 Mid( ls_Div_Syntax, li_Pos_To )		
	
	ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
Else 
	//전체
End IF

idwc.Retrieve()
adw.InsertRow(0)


/////////////////////////////////////////////////////////////////////////////////////////////
//string ls_Rtn
//String ls_Div_Syntax
//Int	 li_Pos_From, li_Pos_To
//
//adw.GetChild( 'xplan', idwc )
//idwc.SetTransObject( SQLCA )
//idwc.Retrieve( g_s_autarea )
//
//
//If g_s_autarea = '' And g_s_autplnt = '' Then 
//	adw.InsertRow(0)
//	Return   // 전체 권한자.
//End IF
//
//
//ls_Div_Syntax = idwc.Describe( "DataWindow.Table.Select" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'01'", "~~~'01~~~'" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'INV070'", "~~~'INV070~~~'" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "''", "~~~'~~~'" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "not in", "in" )
//
//If g_s_autdiv = '' Then         	// 담당의 전체 권한자.	
//	
//	
//	If g_s_autplnt = 'M' Then        // 기계생산담당
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'M~~~', ~~~'S~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
//	ElseIf g_s_autplnt = 'H' Then   // 공조생산담당
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'H~~~', ~~~'V~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//	ElseIf g_s_autplnt = 'Q' Then   // 품질경영담당.
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'D~~~', ~~~'F~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//	ElseIf g_s_autplnt = 'J' Then   // 진천
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'B~~~', ~~~'L~~~', ~~~'T~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//		
//	ElseIf g_s_autplnt = 'K' Then   // 군산
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'N~~~', ~~~'O~~~', ~~~'P~~~', ~~~'K~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
//		
//	ElseIf g_s_autplnt = 'Y' Then   // 여주담당.
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'Y~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
//		
//	ELSE	//전체
////		ls_Div_Syntax = idwc.Describe( "DataWindow.Table.Select" )
////		ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'01'", "~~~'01~~~'" )
////		ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'INV070'", "~~~'INV070~~~'" )
////		ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "''", "~~~'~~~'" )
////		ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "not in", "in" )
//
////		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
////		li_Pos_From += 4
////		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
////		
////		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'1~~~' " + &
////							 Mid( ls_Div_Syntax, li_Pos_To )		
////							 
////		//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "in", "not in" )
////		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//	End If
//	
//	//idwc.Retrieve( g_s_autarea )
//Else  // 해당 공장담당
//	
////	idwc.Object.Xplant.Protect = 1
//	
////	idwc.Object.Div[1] = g_s_autdiv
////	idwc.Object.Div.Protect = 1
//
//	li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//	li_Pos_From += 4
//	li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//	
//	ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'" + g_s_autdiv + "~~~' " + &
//						 Mid( ls_Div_Syntax, li_Pos_To )		
//	
//	ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//		
//End If
//
////dw_1.GetChild("xplan",idwc)
////idwc.SetTransObject(sqlca)
//idwc.Retrieve()
//adw.InsertRow(0)
end subroutine

on uo_pur020_xplan.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on uo_pur020_xplan.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

type dw_1 from datawindow within uo_pur020_xplan
integer x = 283
integer width = 713
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_pur010_xplan"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;This.AcceptText()
is_xplan = This.object.xplan[row]
end event

event constructor;is_xplan = ' '
end event

event itemfocuschanged;//
////Choose Case dwo.Name 
////	Case 'xplan'
//		f_kor_eng_toggle( handle(This), 'KOR' ) // 키보드 한글로 설정...
////	Case Else
////		f_pur040_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
////End Choose
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' ) // 키보드 한글로 설정...
end event

type st_1 from statictext within uo_pur020_xplan
integer x = 9
integer y = 24
integer width = 265
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "구매담당"
boolean focusrectangle = false
end type

