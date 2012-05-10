$PBExportHeader$uo_vsrno_pura.sru
$PBExportComments$업체 (사용업체,부품납품업체)
forward
global type uo_vsrno_pura from userobject
end type
type st_1 from statictext within uo_vsrno_pura
end type
type dw_1 from datawindow within uo_vsrno_pura
end type
end forward

global type uo_vsrno_pura from userobject
integer width = 1778
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_gubun,  string ag_color )
st_1 st_1
dw_1 dw_1
end type
global uo_vsrno_pura uo_vsrno_pura

type variables
Private :
		String is_vsrno
		DataWindowChild idwc
end variables

forward prototypes
public function string uf_get_vsrno ()
public subroutine uf_set_vsrno ()
public subroutine uf_set_color (string ag_color)
end prototypes

event ue_constructor(string ag_gubun, string ag_color);//////////////////////////////////////////
// 업체
//        argument : ag_gubun
//							'U'  - 사용업체
//							'V'  - 부품납품업체
//
//                   ag_color
//                          'S' - sky
//                          'W' - white 
/////////////////////////////////////////
dw_1.SetTransObject(sqlca)

IF Upper(ag_gubun) = 'U' Then	//사용업체
	//dw_1.Modify("vsrno.dddw.Name='dddw_use_vdcd_pura'")
	dw_1.Modify("vsrno.dddw.Name='dddw_use_vdcd_pura_all'")
	st_1.text = "사용  업체"
ElseIf UPPER(ag_gubun) = 'V' Then	//부품납품업체
	dw_1.Modify("vsrno.dddw.Name='dddw_vdcd_pura'")
	st_1.text = "부품납품업체"             	 
End IF	

dw_1.Modify("vsrno.dddw.DisplayColumn='com_vndnm'")
dw_1.Modify("vsrno.dddw.DataColumn='vsrno'")

dw_1.GetChild("vsrno",idwc)
idwc.SetTransObject(sqlca)
idwc.Retrieve()
dw_1.InsertRow(0)

IF ag_color = 'S' Then
   dw_1.Modify("vsrno.Background.Color = 15780518")	//sky
Else
	dw_1.Modify("vsrno.Background.Color = 16777215")	//white
End IF

//width
f_dddw_width_pura(dw_1,"vsrno",idwc,"vsrno",0)
end event

public function string uf_get_vsrno ();Return is_vsrno
end function

public subroutine uf_set_vsrno ();is_vsrno = " "
dw_1.SetItem(1,"vsrno", is_vsrno)
end subroutine

public subroutine uf_set_color (string ag_color);f_set_color_dw_column(dw_1,"vsrno",ag_color)
//dw_1.Post Event Constructor()
/*
dw_1.GetChild("vsrno",idwc)
idwc.SetTransObject(sqlca)
idwc.Retrieve()
dw_1.InsertRow(0)
dw_1.Object.vsrno[1] = is_vsrno

*/
end subroutine

on uo_vsrno_pura.create
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_1}
end on

on uo_vsrno_pura.destroy
destroy(this.st_1)
destroy(this.dw_1)
end on

type st_1 from statictext within uo_vsrno_pura
integer y = 24
integer width = 398
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "부품납품업체"
boolean focusrectangle = false
end type

type dw_1 from datawindow within uo_vsrno_pura
integer x = 393
integer width = 1376
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_pur010_vsrno"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;This.AcceptText()
is_vsrno = This.object.vsrno[row]
end event

event constructor;is_vsrno = ' '

end event

event itemfocuschanged;
//Choose Case dwo.Name 
//	Case 'xplan'
//		f_kor_eng_toggle( handle(This), 'KOR' ) // 키보드 한글로 설정...
//	Case Else
//		f_pur040_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
//End Choose
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' )
end event

