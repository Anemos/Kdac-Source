$PBExportHeader$uo_pur020_vsrno.sru
$PBExportComments$업체 (구분: 전체,D,P,R,운송료,폐기물)
forward
global type uo_pur020_vsrno from userobject
end type
type st_1 from statictext within uo_pur020_vsrno
end type
type dw_1 from datawindow within uo_pur020_vsrno
end type
end forward

global type uo_pur020_vsrno from userobject
integer width = 1513
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_gubun,  string ag_color )
st_1 st_1
dw_1 dw_1
end type
global uo_pur020_vsrno uo_pur020_vsrno

type variables
Private :
		String is_vsrno
		DataWindowChild idwc
end variables

forward prototypes
public function string uf_get_vsrno ()
public subroutine uf_set_vsrno ()
end prototypes

event ue_constructor(string ag_gubun, string ag_color);//////////////////////////////////////////
// 업체
//        argument : ag_gubun
//			                   ALL - 내자업체 전체
//			                   D	 - 외주개발업체
//			                   P   - 내자구매업체
//			                   R   - 연구소업체
//
//									 DS  - 사내가공업체  -> 2004.11.04			
//									 DT  - TMC 선정업체 : 생관선정업체만 -> 2004.11.04			
//
//			                   ZA  - 운송료 업체
//			                   ZB  - 폐기물 업체
//
//                          B   - 구매자금대상업체 - 내자구매업체중에서...		
//									 Y	  - 여주 
//									
//                   ag_color
//                          'S' - sky
//                          'W' - white 
/////////////////////////////////////////
dw_1.SetTransObject(sqlca)

Choose Case Upper(ag_gubun)
	Case "ALL"	//업체전체
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno01'")
	Case "D"		//외주개발
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno02'")
	Case "P"		//내자구매		
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno03'")
	Case "R"		//연구소	
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno04'")
	Case "Y"		//여주생산
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno09'")	
		
	Case "DS"	//사내가공업체
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno11'")	//2004.11.04
		
	Case "DT"	//TMC 선정업체 - 생관선정업체만
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno12'")	//2004.11.04	
		
	Case "DY"	//업체평가관리 (외주개발 + 여주생산)
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno13'")	//2004.11.04	
		
	Case "ZA"	// 운송료
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno05_01'")
	Case "ZB"	// 폐기물 - 대구	
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno05_02'")
		
	Case "ZBY" 	// 폐기물 - 여주
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno05_03'")	
	Case "ZAY" 	// 운송료 - 여주
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno05_04'")	
		
	Case "PA"	//구매자금 비대상 - 내자구매
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_01'")	
	Case "PB"	//구매자금 대상 - 내자구매	
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_02'")	
	Case "PC"	//외상매출채권 대상	- 내자구매
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_03'")				
	
	Case "DA"	//구매자금 비대상 - 외주개발
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_04'")	
	Case "DB"	//구매자금 대상 - 외주개발
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_05'")	
	Case "DC"	//외상매출채권 대상	- 외주개발
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_06'")				
		
	Case "YA"	//구매자금 비대상 - 여주생산
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_07'")			
	Case "YB"	//구매자금 대상 - 여주생산
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_08'")	
	Case "YC"	//외상매출채권 대상	- 여주생산
		dw_1.Modify("vsrno.dddw.Name='dddw_pur010_vsrno08_09'")					
		
End Choose

dw_1.Modify("vsrno.dddw.DisplayColumn='namecode'")
//dw_1.Modify("vsrno.dddw.DisplayColumn='com_namecode'")
dw_1.Modify("vsrno.dddw.DataColumn='code'")

dw_1.GetChild("vsrno",idwc)
idwc.SetTransObject(sqlca)

If UPPER(LEFT(ag_gubun,2)) = 'ZA' Then
	idwc.Retrieve('ZA')	//운송료
ElseIF UPPER(LEFT(ag_gubun,2)) = 'ZB' Then
	idwc.Retrieve('ZB')	//폐기물
Else
	idwc.Retrieve()
End IF	
dw_1.SetItem(1,'vsrno', ' ')
dw_1.InsertRow(0)

IF ag_color = 'S' Then
//	dw_1.Modify("DataWindow.Color = 15780518")	//sky
   dw_1.Modify("vsrno.Background.Color = 15780518")	//white
Else
//	dw_1.Modify("DataWindow.Color = 16777215")	//white
	dw_1.Modify("vsrno.Background.Color = 16777215")	//white
End IF

f_dddw_width_pura(dw_1,"vsrno",idwc,"code",0)

end event

public function string uf_get_vsrno ();Return is_vsrno
end function

public subroutine uf_set_vsrno ();is_vsrno = " "
//vsrno
//dw_1.GetChild("vsrno",idwc)
//idwc.SetTransObject(sqlca)
dw_1.SetItem(1,"vsrno", is_vsrno)
end subroutine

on uo_pur020_vsrno.create
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_1}
end on

on uo_pur020_vsrno.destroy
destroy(this.st_1)
destroy(this.dw_1)
end on

type st_1 from statictext within uo_pur020_vsrno
integer y = 28
integer width = 133
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "업체"
boolean focusrectangle = false
end type

type dw_1 from datawindow within uo_pur020_vsrno
integer x = 137
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
		f_kor_eng_toggle( handle(This), 'KOR' ) // 키보드 한글로 설정...
//	Case Else
//		f_pur040_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
//End Choose
end event

event losefocus;f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event getfocus;f_kor_eng_toggle( handle(This), 'KOR' )
end event

