$PBExportHeader$uo_pur020_xplan.sru
$PBExportComments$���Ŵ�� ( ��籸�� - ����,����, ����-������,������)
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
// argument : ag_xplan1 - ���Ŵ�� ( '1' )  
//                        ������ ( '2' )
//
//            ag_xplan2 - ������ ('1')                    
//                        ������ ('2')
//                        ��/������ ('3')
//                        ����('Y')
//
//				  ag_color  - 'S'  : Sky
//                        'W'  : White
///////////////////////////////////////////

dw_1.SetTransObject(sqlca)

IF ag_xplan1 = '1' Then	//���Ŵ��
	st_1.text = "���Ŵ��"
	IF ag_xplan2 = '1' Then
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan01'")	//������		
	ElseIF ag_xplan2 = '2' Then
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan02'")	//������
	ElseIF ag_xplan2 = '3' Then
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan04'")	//��/������	
	ELSEIF ag_xplan2 = 'Y' Then										
		dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan05'")	//����
	End If
	
	dw_1.Modify("xplan.dddw.DisplayColumn='com_coname'")
	dw_1.Modify("xplan.dddw.DataColumn='code'")
	
	dw_1.GetChild("xplan",idwc)
	idwc.SetTransObject(sqlca)
	idwc.Retrieve()
	dw_1.InsertRow(0)

ELSE
	//�������� ����/���庰�� �ο�.
	st_1.text = "������"	
	dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan03_01'")		
	dw_1.Modify("xplan.dddw.DisplayColumn='com_coname'")
	dw_1.Modify("xplan.dddw.DataColumn='code'")
	
	uf_autdivxplan_set(dw_1)
	
END IF
//Else	//������
//	st_1.text = "������"	
//	dw_1.Modify("xplan.dddw.Name='dddw_pur010_xplan03'")		
//End IF

//dw_1.Modify("xplan.dddw.DisplayColumn='com_coname'")
//dw_1.Modify("xplan.dddw.DataColumn='code'")

//dw_1.GetChild("xplan",idwc)
//idwc.SetTransObject(sqlca)
//idwc.Retrieve()
//dw_1.InsertRow(0)

//Color ����
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
// * ���ѿ� ���� ����, ���� ���� *
//
//                        																2002.12.20  �ں���
//
// ���ѵ��: -> KDAC���������ý��� -> ���� -> �ý��۰��� -> ���α׷� -> ����ڰ���.
//          ����( ����, ���, ���� )
// ��)
//    ���� = '' And ��� = ''     --> ������ ������ ����
//    ���� = '' And ��� = 'M'    --> �������� ( �ٸ������� M, S ���� ���� ���� )
//		                     'J'    --> ��õ������ ( �ٸ������� B, L, T ���� ���� ���� )-- M,S,H
//									'K'	 --> ����							 P, N, O, K
//									'Y'	 --> ����							 Y	
//    ���� = 'D' And ��� = 'A' And ���� = 'A'   --> �뱸, ����������� Setting(���úҰ�).
/////////////////////////////////////////////////////////////////////////////////////////////////

/*  2004.06.11 �����԰��� ��û : ������ ���� ���� ����
	 ����				���				����
	 g_s_autarea   g_s_autplnt    g_s_autdiv
	 
		���� = 'D'  
		       ���� = �ش�����ڵ�
				 ���� = ' '
				        ��� = 'M'	--> �������� ( M, S )
						         'H'   --> (H,V,T,K)
									'Q'   --> (D,F)
									�׿�  --> ��ü
		���� = 'J'							
				���� = 'H'				--> T
				       'S'				--> L
						 'M'				--> B
						 �׿�				--> (B, L, T)
		
		���� = 'K'						--> K
		���� = 'Y'						--> Y
		���� = '�׿�'					--> ��ü
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
	IF g_s_autplnt = "M" Then		//��������  ( M, S )
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'M~~~', ~~~'S~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
	ElseIF g_s_autplnt = "H" Then //����������  ( H, V )
		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
		li_Pos_From += 4
		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
		
		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'H~~~', ~~~'V~~~' " + &
							 Mid( ls_Div_Syntax, li_Pos_To )		
		
		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )	
	Else
		IF g_s_autdiv = '' Then
			//�뱸 ���� ��ü ( M, S, H, V )
			li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
			li_Pos_From += 4
			li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
			
			ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'M~~~', ~~~'S~~~', ~~~'H~~~', ~~~'V~~~' " + &
								 Mid( ls_Div_Syntax, li_Pos_To )		
			
			ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
		Else
			//�ش���常
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
		//��õ ��ü ( B, L, T )
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
	//��ü
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
//	Return   // ��ü ������.
//End IF
//
//
//ls_Div_Syntax = idwc.Describe( "DataWindow.Table.Select" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'01'", "~~~'01~~~'" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "'INV070'", "~~~'INV070~~~'" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "''", "~~~'~~~'" )
//ls_Div_Syntax = f_Replace_With( ls_Div_Syntax, "not in", "in" )
//
//If g_s_autdiv = '' Then         	// ����� ��ü ������.	
//	
//	
//	If g_s_autplnt = 'M' Then        // ��������
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'M~~~', ~~~'S~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
//	ElseIf g_s_autplnt = 'H' Then   // ����������
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'H~~~', ~~~'V~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//	ElseIf g_s_autplnt = 'Q' Then   // ǰ���濵���.
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'D~~~', ~~~'F~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//	ElseIf g_s_autplnt = 'J' Then   // ��õ
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'B~~~', ~~~'L~~~', ~~~'T~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )
//		
//	ElseIf g_s_autplnt = 'K' Then   // ����
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'N~~~', ~~~'O~~~', ~~~'P~~~', ~~~'K~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
//		
//	ElseIf g_s_autplnt = 'Y' Then   // ���ִ��.
//		li_Pos_From = Pos( ls_Div_Syntax, 'in (' )
//		li_Pos_From += 4
//		li_Pos_To = Pos( ls_Div_Syntax, ')', li_Pos_From )
//		
//		ls_Div_Syntax = Mid( ls_Div_Syntax, 1, li_Pos_From ) + " ~~~'Y~~~' " + &
//							 Mid( ls_Div_Syntax, li_Pos_To )		
//		
//		ls_Rtn = idwc.Modify( "DataWindow.Table.Select = '" + ls_Div_Syntax + "'" )		
//		
//	ELSE	//��ü
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
//Else  // �ش� ������
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
//		f_kor_eng_toggle( handle(This), 'KOR' ) // Ű���� �ѱ۷� ����...
////	Case Else
////		f_pur040_toggle( handle(This), 'ENG' ) // Ű���� �������� ����...
////End Choose
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'ENG' ) // Ű���� �������� ����...
end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' ) // Ű���� �ѱ۷� ����...
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
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "���Ŵ��"
boolean focusrectangle = false
end type

