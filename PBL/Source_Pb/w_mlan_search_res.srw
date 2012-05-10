$PBExportHeader$w_mlan_search_res.srw
$PBExportComments$품번 검색 Response Window(MRP용)
forward
global type w_mlan_search_res from window
end type
type st_1 from statictext within w_mlan_search_res
end type
type st_msg from statictext within w_mlan_search_res
end type
type cb_cancel from commandbutton within w_mlan_search_res
end type
type cb_ok from commandbutton within w_mlan_search_res
end type
type dw_1 from datawindow within w_mlan_search_res
end type
type gb_2 from groupbox within w_mlan_search_res
end type
end forward

global type w_mlan_search_res from window
integer width = 1216
integer height = 528
boolean titlebar = true
string title = "담당자일괄등록"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "C:\KDAC\kdac.ico"
event ue_opne_after ( )
st_1 st_1
st_msg st_msg
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
gb_2 gb_2
end type
global w_mlan_search_res w_mlan_search_res

type variables
String is_xplant, is_div, is_cls[], is_itno

// DataWindow Sort용~
String  is_PreColNm
Boolean ib_Sort_Desc

datawindowchild idwc_mlan


end variables

on w_mlan_search_res.create
this.st_1=create st_1
this.st_msg=create st_msg
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_2=create gb_2
this.Control[]={this.st_1,&
this.st_msg,&
this.cb_cancel,&
this.cb_ok,&
this.dw_1,&
this.gb_2}
end on

on w_mlan_search_res.destroy
destroy(this.st_1)
destroy(this.st_msg)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event open;Str_Open_Parm	lStr_Parm
String ls_itno

lStr_Parm = Message.PowerObjectParm

is_xplant = lStr_Parm.Xplant
is_div	 = lStr_Parm.Div
is_cls    = lStr_Parm.Cls
is_itno	 = lStr_Parm.Itno

////This.Event Post ue_opne_after()
////sle_1.Text = ls_itno
////sle_1.SetFocus()
////
////If f_spacechk(ls_itno) <> -1 Then
////	cb_1.PostEvent(Clicked!)
////End If
//
//If is_itno = 'TMS' then	
//	dw_1.Object.code.dddw.Name = "ddw_mlan_mmm"
//	dw_1.Modify("code.dddw.AllowEdit = no")
//	dw_1.Modify("code.dddw.VScrollBar = yes")
//	dw_1.Modify("code.dddw.Percentwidth= 100")
//	dw_1.Modify("code.dddw.displaycolumn= 'coitname'")
//	dw_1.Modify("code.dddw.datacolumn= 'code'")
//	dw_1.GetChild("code",idwc_mlan)
//	idwc_mlan.SetTransObject(Sqlca)
//	idwc_mlan.Retrieve()
//Else
//	dw_1.Object.code.dddw.Name = "dddw_mlan_tms"
//	dw_1.Modify("code.dddw.AllowEdit = no")
//	dw_1.Modify("code.dddw.VScrollBar = yes")
//	dw_1.Modify("code.dddw.Percentwidth= 100")
//	dw_1.Modify("code.dddw.displaycolumn= 'coitname'")
//	dw_1.Modify("code.dddw.datacolumn= 'code'")
//	dw_1.GetChild("code",idwc_mlan)
//	idwc_mlan.SetTransObject(Sqlca)
//	idwc_mlan.Retrieve()
//End if

If is_itno = 'TMS' then	
	dw_1.DataObject = "d_mlan_m2"
	dw_1.SetTransObject(SQLCA)
	
	dw_1.GetChild('code', idwc_mlan)
	idwc_mlan.SetTransObject( SQLCA )
	
	if is_xplant = 'Y' Or is_xplant = 'J' then
		idwc_mlan.Retrieve(is_xplant)
	Else
		idwc_mlan.Retrieve(is_div)
	End if
	
	dw_1.insertrow(0)	
Else
	dw_1.DataObject = "d_mlan_m"
	dw_1.SetTransObject(SQLCA)
	dw_1.insertrow(0)	
End if

dw_1.SetFocus()
end event

event activate;/////////////////////////////////////
//
//배경색(Column):
//
//필수:         하늘색(15780518)
//필수(X):      흰색(1090519039)
//Edit_Disable: 회색(12632256)
//확정:         연두색(12639424)
/////////////////////////////////////


f_center_window(This)
end event

type st_1 from statictext within w_mlan_search_res
integer x = 32
integer y = 52
integer width = 1115
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "담당자를 선택후 적용을 클릭하세요."
boolean focusrectangle = false
end type

type st_msg from statictext within w_mlan_search_res
boolean visible = false
integer x = 389
integer y = 1168
integer width = 1253
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean enabled = false
string text = "조건에 맞는 품번이 없습니다."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_mlan_search_res
integer x = 910
integer y = 312
integer width = 270
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "취소"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "")
end event

type cb_ok from commandbutton within w_mlan_search_res
integer x = 567
integer y = 312
integer width = 270
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "적용"
end type

event clicked;String ls_rtn
Long lL_row


lL_row = dw_1.GetRow()
ls_rtn = dw_1.GetItemString(lL_row, 'code')

CloseWithReturn(parent, ls_rtn)

end event

type dw_1 from datawindow within w_mlan_search_res
integer y = 180
integer width = 905
integer height = 116
integer taborder = 30
string title = "none"
string dataobject = "d_mlan_m"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event clicked;//If Upper(dwo.Type) = 'TEXT' Then  // 칼럼명으로 DW Sort.
//	String ls_ColNm
//	
//	ls_ColNm = f_Get_Sort_ColNm( This)
//	f_Sorting_Dw(This, ls_ColNm, is_PreColNm, ib_Sort_Desc)
//	is_PreColNm = ls_ColNm
//   Return
//End If
//
//If dwo.Type = 'column' Then	
//	cb_ok.Enabled = True
//End If
end event

event doubleclicked;If dwo.Type = 'column' Then
	cb_ok.TriggerEvent(Clicked!)
End If
end event

type gb_2 from groupbox within w_mlan_search_res
integer x = 14
integer width = 1143
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

