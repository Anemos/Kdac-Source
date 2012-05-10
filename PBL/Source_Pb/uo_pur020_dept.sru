$PBExportHeader$uo_pur020_dept.sru
$PBExportComments$구매요구부서
forward
global type uo_pur020_dept from userobject
end type
type st_1 from statictext within uo_pur020_dept
end type
type dw_1 from datawindow within uo_pur020_dept
end type
end forward

global type uo_pur020_dept from userobject
integer width = 1042
integer height = 96
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_constructor ( string ag_color )
st_1 st_1
dw_1 dw_1
end type
global uo_pur020_dept uo_pur020_dept

type variables
Private :
			String is_dept
			DataWindowChild idwc
end variables

forward prototypes
public function string uf_get_dept ()
end prototypes

event ue_constructor(string ag_color);/////////////////////////////////////////////////
//구매요구부서 
//            argument : ag_color 색상
//                       S   - sky
//                       W   - white
////////////////////////////////////////////////

dw_1.SetTransObject(sqlca)
dw_1.GetChild("dept",idwc)
idwc.SetTransObject(sqlca)
idwc.Retrieve()
dw_1.InsertRow(0)
dw_1.object.dept[1] = g_s_deptcd

IF Upper(ag_color) = 'S' Then
	//dw_1.Modify("DataWindow.Color = 15780518")	//sky
	dw_1.Modify("dept.Background.Color = 15780518")	//white
Else
//   dw_1.Modify("DataWindow.Color = 16777215")	//white
	dw_1.Modify("dept.Background.Color = 16777215")	//white
End IF

f_dddw_width_pura(dw_1,"dept",idwc,"code",0)
end event

public function string uf_get_dept ();Return is_dept
end function

on uo_pur020_dept.create
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_1}
end on

on uo_pur020_dept.destroy
destroy(this.st_1)
destroy(this.dw_1)
end on

type st_1 from statictext within uo_pur020_dept
integer y = 28
integer width = 256
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "요구부서"
boolean focusrectangle = false
end type

type dw_1 from datawindow within uo_pur020_dept
integer x = 261
integer width = 782
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_pur010_dept"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//is_dept = ' '
is_dept = g_s_deptcd
end event

event itemchanged;This.AcceptText()
is_dept = This.object.dept[row]
end event

event getfocus;f_kor_eng_toggle( handle(This), 'KOR' )
end event

event itemfocuschanged;f_kor_eng_toggle( handle(This), 'KOR' )
end event

event losefocus;f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

