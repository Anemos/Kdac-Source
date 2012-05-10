$PBExportHeader$w_manage.srw
$PBExportComments$기준정보 (업무코드,모델) 관리
forward
global type w_manage from window
end type
type pb_close from picturebutton within w_manage
end type
type st_5 from statictext within w_manage
end type
type tab_1 from tab within w_manage
end type
type tabpage_1 from userobject within tab_1
end type
type pb_code_clear from picturebutton within tabpage_1
end type
type sle_code_etc04 from singlelineedit within tabpage_1
end type
type st_10 from statictext within tabpage_1
end type
type sle_code_etc03 from singlelineedit within tabpage_1
end type
type sle_code_etc01 from singlelineedit within tabpage_1
end type
type sle_code_etc02 from singlelineedit within tabpage_1
end type
type sle_code_remark from singlelineedit within tabpage_1
end type
type sle_code_name from singlelineedit within tabpage_1
end type
type sle_code_code from singlelineedit within tabpage_1
end type
type st_9 from statictext within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type pb_code_delete from picturebutton within tabpage_1
end type
type dw_code_sub from datawindow within tabpage_1
end type
type pb_code_save from picturebutton within tabpage_1
end type
type dw_code_main from datawindow within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_code_clear pb_code_clear
sle_code_etc04 sle_code_etc04
st_10 st_10
sle_code_etc03 sle_code_etc03
sle_code_etc01 sle_code_etc01
sle_code_etc02 sle_code_etc02
sle_code_remark sle_code_remark
sle_code_name sle_code_name
sle_code_code sle_code_code
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_4 st_4
st_3 st_3
pb_code_delete pb_code_delete
dw_code_sub dw_code_sub
pb_code_save pb_code_save
dw_code_main dw_code_main
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
end type
type sle_model_remark from singlelineedit within tabpage_2
end type
type st_11 from statictext within tabpage_2
end type
type sle_model_name from singlelineedit within tabpage_2
end type
type sle_model_code from singlelineedit within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type pb_model_delete from picturebutton within tabpage_2
end type
type pb_model_save from picturebutton within tabpage_2
end type
type dw_model from datawindow within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
sle_model_remark sle_model_remark
st_11 st_11
sle_model_name sle_model_name
sle_model_code sle_model_code
st_1 st_1
pb_model_delete pb_model_delete
pb_model_save pb_model_save
dw_model dw_model
st_2 st_2
gb_2 gb_2
end type
type tabpage_3 from userobject within tab_1
end type
type st_23 from statictext within tabpage_3
end type
type st_22 from statictext within tabpage_3
end type
type sle_flag from singlelineedit within tabpage_3
end type
type st_21 from statictext within tabpage_3
end type
type st_20 from statictext within tabpage_3
end type
type sle_target_rate from singlelineedit within tabpage_3
end type
type st_19 from statictext within tabpage_3
end type
type st_18 from statictext within tabpage_3
end type
type sle_cycle_time from singlelineedit within tabpage_3
end type
type st_17 from statictext within tabpage_3
end type
type st_16 from statictext within tabpage_3
end type
type st_15 from statictext within tabpage_3
end type
type sle_input_man from singlelineedit within tabpage_3
end type
type sle_type from singlelineedit within tabpage_3
end type
type sle_model from singlelineedit within tabpage_3
end type
type st_14 from statictext within tabpage_3
end type
type st_13 from statictext within tabpage_3
end type
type st_12 from statictext within tabpage_3
end type
type dw_model_capa from datawindow within tabpage_3
end type
type pb_model_capa_delete from picturebutton within tabpage_3
end type
type pb_model_capa_save from picturebutton within tabpage_3
end type
type dw_model_list from datawindow within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_23 st_23
st_22 st_22
sle_flag sle_flag
st_21 st_21
st_20 st_20
sle_target_rate sle_target_rate
st_19 st_19
st_18 st_18
sle_cycle_time sle_cycle_time
st_17 st_17
st_16 st_16
st_15 st_15
sle_input_man sle_input_man
sle_type sle_type
sle_model sle_model
st_14 st_14
st_13 st_13
st_12 st_12
dw_model_capa dw_model_capa
pb_model_capa_delete pb_model_capa_delete
pb_model_capa_save pb_model_capa_save
dw_model_list dw_model_list
gb_3 gb_3
end type
type tab_1 from tab within w_manage
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_manage from window
integer width = 4850
integer height = 3060
boolean titlebar = true
string title = "기준정보 관리"
boolean controlmenu = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Form!"
boolean center = true
pb_close pb_close
st_5 st_5
tab_1 tab_1
end type
global w_manage w_manage

type variables
String	is_time_dt
String	is_date_fromdt, is_date_todt
String	is_model_fromdt, is_model_todt
Long		il_SelectedRow



end variables

forward prototypes
public subroutine wf_code_get_main ()
public subroutine wf_code_get_sub (string as_code)
public subroutine wf_model_search ()
public subroutine wf_model_get_list ()
public subroutine wf_model_get_capa (string as_model)
end prototypes

public subroutine wf_code_get_main ();// 업무코드 조회 (주코드) 
// 
tab_1.tabpage_1.dw_code_main.SetTransObject(SQLCA)
tab_1.tabpage_1.dw_code_main.SetRedraw(False)
tab_1.tabpage_1.dw_code_main.Reset()
tab_1.tabpage_1.dw_code_main.Retrieve()
tab_1.tabpage_1.dw_code_main.SetRedraw(True)


end subroutine

public subroutine wf_code_get_sub (string as_code);// 업무코드 조회 (부코드)
// 

SetPointer(HourGlass!)

tab_1.tabpage_1.dw_code_sub.SetTransObject(SQLCA)
tab_1.tabpage_1.dw_code_sub.SetRedraw(False)
tab_1.tabpage_1.dw_code_sub.Reset()
tab_1.tabpage_1.dw_code_sub.Retrieve(as_code)
tab_1.tabpage_1.dw_code_sub.SetRedraw(True)

SetPointer(Arrow!)


end subroutine

public subroutine wf_model_search ();// 모델 조회
// 
SetPointer(HourGlass!)

tab_1.tabpage_2.dw_model.SetTransObject(SQLCA)
tab_1.tabpage_2.dw_model.SetRedraw(False)
tab_1.tabpage_2.dw_model.Reset()
tab_1.tabpage_2.dw_model.Retrieve()
tab_1.tabpage_2.dw_model.SetRedraw(True)

SetPointer(Arrow!)



end subroutine

public subroutine wf_model_get_list ();// 모델 조회
// 
SetPointer(HourGlass!)

tab_1.tabpage_3.dw_model_list.SetTransObject(SQLCA)
tab_1.tabpage_3.dw_model_list.SetRedraw(False)
tab_1.tabpage_3.dw_model_list.Reset()
tab_1.tabpage_3.dw_model_list.Retrieve()
tab_1.tabpage_3.dw_model_list.SetRedraw(True)

SetPointer(Arrow!)
end subroutine

public subroutine wf_model_get_capa (string as_model);// 모델 조회
// 
tab_1.tabpage_3.dw_model_capa.SetTransObject(SQLCA)
tab_1.tabpage_3.dw_model_capa.SetRedraw(False)
tab_1.tabpage_3.dw_model_capa.Reset()
tab_1.tabpage_3.dw_model_capa.Retrieve(as_model)
tab_1.tabpage_3.dw_model_capa.SetRedraw(True)



end subroutine

on w_manage.create
this.pb_close=create pb_close
this.st_5=create st_5
this.tab_1=create tab_1
this.Control[]={this.pb_close,&
this.st_5,&
this.tab_1}
end on

on w_manage.destroy
destroy(this.pb_close)
destroy(this.st_5)
destroy(this.tab_1)
end on

event open;
// 업무코드 조회 
wf_code_get_main()

// 모델코드 조회 
wf_model_search()

// 모델별 설정에서 모델 조회 
wf_model_get_list()





end event

type pb_close from picturebutton within w_manage
integer x = 14
integer y = 2696
integer width = 4663
integer height = 276
integer taborder = 30
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "HyperLink!"
string text = "닫기"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 닫기 
Close(Parent) 


end event

type st_5 from statictext within w_manage
integer y = 2676
integer width = 4695
integer height = 352
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 0
boolean focusrectangle = false
end type

type tab_1 from tab within w_manage
integer x = 27
integer y = 28
integer width = 4663
integer height = 2620
integer taborder = 10
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 196
integer width = 4626
integer height = 2408
long backcolor = 67108864
string text = "  업무코드  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_code_clear pb_code_clear
sle_code_etc04 sle_code_etc04
st_10 st_10
sle_code_etc03 sle_code_etc03
sle_code_etc01 sle_code_etc01
sle_code_etc02 sle_code_etc02
sle_code_remark sle_code_remark
sle_code_name sle_code_name
sle_code_code sle_code_code
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_4 st_4
st_3 st_3
pb_code_delete pb_code_delete
dw_code_sub dw_code_sub
pb_code_save pb_code_save
dw_code_main dw_code_main
gb_1 gb_1
end type

on tabpage_1.create
this.pb_code_clear=create pb_code_clear
this.sle_code_etc04=create sle_code_etc04
this.st_10=create st_10
this.sle_code_etc03=create sle_code_etc03
this.sle_code_etc01=create sle_code_etc01
this.sle_code_etc02=create sle_code_etc02
this.sle_code_remark=create sle_code_remark
this.sle_code_name=create sle_code_name
this.sle_code_code=create sle_code_code
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_4=create st_4
this.st_3=create st_3
this.pb_code_delete=create pb_code_delete
this.dw_code_sub=create dw_code_sub
this.pb_code_save=create pb_code_save
this.dw_code_main=create dw_code_main
this.gb_1=create gb_1
this.Control[]={this.pb_code_clear,&
this.sle_code_etc04,&
this.st_10,&
this.sle_code_etc03,&
this.sle_code_etc01,&
this.sle_code_etc02,&
this.sle_code_remark,&
this.sle_code_name,&
this.sle_code_code,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_4,&
this.st_3,&
this.pb_code_delete,&
this.dw_code_sub,&
this.pb_code_save,&
this.dw_code_main,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.pb_code_clear)
destroy(this.sle_code_etc04)
destroy(this.st_10)
destroy(this.sle_code_etc03)
destroy(this.sle_code_etc01)
destroy(this.sle_code_etc02)
destroy(this.sle_code_remark)
destroy(this.sle_code_name)
destroy(this.sle_code_code)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.pb_code_delete)
destroy(this.dw_code_sub)
destroy(this.pb_code_save)
destroy(this.dw_code_main)
destroy(this.gb_1)
end on

type pb_code_clear from picturebutton within tabpage_1
integer x = 1742
integer y = 484
integer width = 302
integer height = 156
integer taborder = 90
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = "   Clear"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 입력화면 Clear 
//
sle_code_code.Text 	= ''
sle_code_name.Text 	= ''
sle_code_remark.Text = ''
sle_code_etc01.Text 	= ''
sle_code_etc02.Text 	= ''
sle_code_etc03.Text 	= ''
sle_code_etc04.Text 	= ''








end event

type sle_code_etc04 from singlelineedit within tabpage_1
integer x = 3442
integer y = 468
integer width = 1056
integer height = 108
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within tabpage_1
integer x = 3141
integer y = 476
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기타-4: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_code_etc03 from singlelineedit within tabpage_1
integer x = 3442
integer y = 340
integer width = 1056
integer height = 108
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_code_etc01 from singlelineedit within tabpage_1
integer x = 3442
integer y = 88
integer width = 1056
integer height = 108
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_code_etc02 from singlelineedit within tabpage_1
integer x = 3442
integer y = 212
integer width = 1056
integer height = 108
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_code_remark from singlelineedit within tabpage_1
integer x = 1737
integer y = 340
integer width = 1339
integer height = 108
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_code_name from singlelineedit within tabpage_1
integer x = 1737
integer y = 212
integer width = 1339
integer height = 108
integer taborder = 50
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_code_code from singlelineedit within tabpage_1
integer x = 1737
integer y = 88
integer width = 325
integer height = 108
integer taborder = 50
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within tabpage_1
integer x = 3141
integer y = 332
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기타-3: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_1
integer x = 3141
integer y = 208
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기타-2: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_1
integer x = 3141
integer y = 84
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기타-1: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_1
integer x = 1440
integer y = 332
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "비고: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 1440
integer y = 208
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "코드명: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_1
integer x = 1440
integer y = 84
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "코드: "
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_code_delete from picturebutton within tabpage_1
integer x = 2350
integer y = 484
integer width = 302
integer height = 156
integer taborder = 80
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 삭제"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 업무코드 삭제  
//

String	ls_MCD, ls_SCD
Integer 	li_rtn

ls_MCD = tab_1.tabpage_1.dw_code_main.GetItemString(il_SelectedRow, "mcd")
ls_SCD = Trim(sle_code_code.Text)

If Trim(ls_SCD) = '' Then
	MessageBox("삭제확인", "부코드를 선택후 삭제하세요.")
	Return
End If

li_rtn = MessageBox("삭제확인", "선택자료를 삭제 하시겠습니까?", StopSign!, YesNo!, 2)
If li_rtn = 1 Then
Else
	Return
End If

// 기존자료 삭제 
DELETE FROM TM_CODE
 WHERE MCD	= :ls_MCD
   AND SCD	= :ls_SCD;
	
If SQLCA.SqlCode <> 0 Then
	MessageBox("삭제오류", SQLCA.SqlErrText)
	Return	
End If

// 부코드 조회화면 Refresh 
wf_code_get_sub(ls_MCD)

end event

type dw_code_sub from datawindow within tabpage_1
integer x = 1385
integer y = 700
integer width = 3200
integer height = 1684
integer taborder = 70
string title = "none"
string dataobject = "d_manage_code_sub"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
// 선택행 반전 
If row < 1 Then Return
This.SelectRow(0,   False)
This.SelectRow(row, True)
This.ScrollToRow(row)

// 상단 입력화면에 자료 Display
sle_code_code.Text	= This.GetItemString(row, "scd")
sle_code_name.Text	= This.GetItemString(row, "cdname")
sle_code_remark.Text	= This.GetItemString(row, "remark")
sle_code_etc01.Text	= This.GetItemString(row, "etc01")
sle_code_etc02.Text	= This.GetItemString(row, "etc02")
sle_code_etc03.Text	= This.GetItemString(row, "etc03")
sle_code_etc04.Text	= This.GetItemString(row, "etc04")




end event

type pb_code_save from picturebutton within tabpage_1
integer x = 2048
integer y = 484
integer width = 302
integer height = 156
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 등록"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 업무코드 등록 
//
String	ls_MCD, ls_SCD
String	ls_CDNAME, ls_REMARK, ls_ETC01, ls_ETC02, ls_ETC03, ls_ETC04

ls_MCD = tab_1.tabpage_1.dw_code_main.GetItemString(il_SelectedRow, "mcd")
ls_SCD = Trim(sle_code_code.Text)

If Trim(ls_MCD) = '' Then
	MessageBox("입력확인", "주코드를 선택후 입력하세요.")
	Return
End If

If Trim(sle_code_code.Text) = '' Then
	MessageBox("입력확인", "코드를 입력하세요.")
	Return
End If
	
If Trim(sle_code_name.Text) = '' Then
	MessageBox("입력확인", "코드명을 입력하세요.")
	Return
End If

ls_CDNAME 	= Trim(sle_code_name.Text)
ls_REMARK 	= Trim(sle_code_remark.Text)
ls_ETC01 	= Trim(sle_code_etc01.Text)
ls_ETC02 	= Trim(sle_code_etc02.Text)
ls_ETC03 	= Trim(sle_code_etc03.Text)
ls_ETC04 	= Trim(sle_code_etc04.Text)

// 기존자료 삭제 
DELETE FROM TM_CODE
 WHERE MCD	= :ls_MCD
   AND SCD	= :ls_SCD;
	
// 신규자료 등록 
INSERT INTO TM_CODE
	(MCD, SCD, CDNAME, REMARK, ETC01, ETC02, ETC03, ETC04)
 VALUES
 	(:ls_MCD, :ls_SCD, :ls_CDNAME, :ls_REMARK, :ls_ETC01, :ls_ETC02, :ls_ETC03, :ls_ETC04);
	 
If SQLCA.SqlCode <> 0 Then
	MessageBox("등록오류", SQLCA.SqlErrText)
	Return	
End If

// 비밀번호인 경우 환경설정 파일에도 저장
//		사용자가 비밀번호를 모를경우 찿을수 있도록 하기위함   
If ls_MCD = '90' And ls_SCD = '09' Then
	SetProfileString(gs_inifile, "Common", "PASSWORD", ls_CDNAME)
End If

// 부코드 조회화면 Refresh 
wf_code_get_sub(ls_MCD)







end event

type dw_code_main from datawindow within tabpage_1
integer x = 23
integer y = 56
integer width = 1344
integer height = 2328
integer taborder = 60
string title = "none"
string dataobject = "d_manage_code_main"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String ls_cd

// 선택행 반전 
If row < 1 Then Return
This.SelectRow(0,   False)
This.SelectRow(row, True)
This.ScrollToRow(row)

// 선택자료 조회
ls_cd	= This.GetItemString(row, "mcd")
il_SelectedRow = row
wf_code_get_sub(ls_cd)


end event

type gb_1 from groupbox within tabpage_1
integer x = 1381
integer y = 28
integer width = 3200
integer height = 652
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 196
integer width = 4626
integer height = 2408
long backcolor = 67108864
string text = "  모델  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
sle_model_remark sle_model_remark
st_11 st_11
sle_model_name sle_model_name
sle_model_code sle_model_code
st_1 st_1
pb_model_delete pb_model_delete
pb_model_save pb_model_save
dw_model dw_model
st_2 st_2
gb_2 gb_2
end type

on tabpage_2.create
this.sle_model_remark=create sle_model_remark
this.st_11=create st_11
this.sle_model_name=create sle_model_name
this.sle_model_code=create sle_model_code
this.st_1=create st_1
this.pb_model_delete=create pb_model_delete
this.pb_model_save=create pb_model_save
this.dw_model=create dw_model
this.st_2=create st_2
this.gb_2=create gb_2
this.Control[]={this.sle_model_remark,&
this.st_11,&
this.sle_model_name,&
this.sle_model_code,&
this.st_1,&
this.pb_model_delete,&
this.pb_model_save,&
this.dw_model,&
this.st_2,&
this.gb_2}
end on

on tabpage_2.destroy
destroy(this.sle_model_remark)
destroy(this.st_11)
destroy(this.sle_model_name)
destroy(this.sle_model_code)
destroy(this.st_1)
destroy(this.pb_model_delete)
destroy(this.pb_model_save)
destroy(this.dw_model)
destroy(this.st_2)
destroy(this.gb_2)
end on

type sle_model_remark from singlelineedit within tabpage_2
integer x = 2496
integer y = 80
integer width = 937
integer height = 120
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type st_11 from statictext within tabpage_2
integer x = 2299
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "비고: "
boolean focusrectangle = false
end type

type sle_model_name from singlelineedit within tabpage_2
integer x = 1303
integer y = 80
integer width = 946
integer height = 120
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type sle_model_code from singlelineedit within tabpage_2
integer x = 421
integer y = 80
integer width = 576
integer height = 120
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within tabpage_2
integer x = 1038
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "모델명: "
boolean focusrectangle = false
end type

type pb_model_delete from picturebutton within tabpage_2
integer x = 3858
integer y = 60
integer width = 302
integer height = 156
integer taborder = 50
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 삭제"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 모델코드 삭제 
//
String	ls_MODEL
Integer 	li_rtn

If Trim(sle_model_code.Text) = '' Then
	MessageBox("입력확인", "모델코드를 선택하세요.")
	Return
End If

li_rtn = MessageBox("삭제확인", "선택자료를 삭제 하시겠습니까?", StopSign!, YesNo!, 2)
If li_rtn = 1 Then
Else
	Return
End If
	
ls_MODEL = Trim(sle_model_code.Text)

// 기존자료 삭제 
DELETE FROM TM_MODEL 
 WHERE MODEL	= :ls_MODEL;
	
If SQLCA.SqlCode <> 0 Then
	MessageBox("삭제오류", SQLCA.SqlErrText)
	Return	
End If

// 모델 조회화면 Refresh 
wf_model_search()



end event

type pb_model_save from picturebutton within tabpage_2
integer x = 3552
integer y = 60
integer width = 302
integer height = 156
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 등록"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 모델코드 등록 
//
String	ls_MODEL, ls_MODEL_NAME, ls_REMARK

If Trim(sle_model_code.Text) = '' Then
	MessageBox("입력확인", "모델코드를 입력하세요.")
	Return
End If
	
If Trim(sle_model_name.Text) = '' Then
	MessageBox("입력확인", "모델명을 입력하세요.")
	Return
End If

ls_MODEL 		= Trim(sle_model_code.Text)
ls_MODEL_NAME 	= Trim(sle_model_name.Text)
ls_REMARK 		= Trim(sle_model_remark.Text)


// 기존자료 삭제 
DELETE FROM TM_MODEL 
 WHERE MODEL	= :ls_MODEL;
	
// 신규자료 등록 
INSERT INTO TM_MODEL
	(MODEL, MODEL_NAME, REMARK)
 VALUES
 	(:ls_MODEL, :ls_MODEL_NAME, :ls_REMARK);
	 
If SQLCA.SqlCode <> 0 Then
	MessageBox("등록오류", SQLCA.SqlErrText)
	Return	
End If

// 모델 조회화면 Refresh 
wf_model_search()










end event

type dw_model from datawindow within tabpage_2
integer x = 23
integer y = 256
integer width = 4576
integer height = 2128
integer taborder = 70
string title = "none"
string dataobject = "d_manage_model"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
// 선택행 반전 
If row < 1 Then Return
This.SelectRow(0,   False)
This.SelectRow(row, True)
This.ScrollToRow(row)


// 상단 입력화면에 자료 Display
sle_model_code.Text		= This.GetItemString(row, "model")
sle_model_name.Text		= This.GetItemString(row, "model_name")
sle_model_remark.Text	= This.GetItemString(row, "remark")


end event

type st_2 from statictext within tabpage_2
integer x = 73
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "모델코드: "
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_2
integer x = 18
integer width = 4576
integer height = 248
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 196
integer width = 4626
integer height = 2408
long backcolor = 67108864
string text = "  모델별 설정  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_23 st_23
st_22 st_22
sle_flag sle_flag
st_21 st_21
st_20 st_20
sle_target_rate sle_target_rate
st_19 st_19
st_18 st_18
sle_cycle_time sle_cycle_time
st_17 st_17
st_16 st_16
st_15 st_15
sle_input_man sle_input_man
sle_type sle_type
sle_model sle_model
st_14 st_14
st_13 st_13
st_12 st_12
dw_model_capa dw_model_capa
pb_model_capa_delete pb_model_capa_delete
pb_model_capa_save pb_model_capa_save
dw_model_list dw_model_list
gb_3 gb_3
end type

on tabpage_3.create
this.st_23=create st_23
this.st_22=create st_22
this.sle_flag=create sle_flag
this.st_21=create st_21
this.st_20=create st_20
this.sle_target_rate=create sle_target_rate
this.st_19=create st_19
this.st_18=create st_18
this.sle_cycle_time=create sle_cycle_time
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.sle_input_man=create sle_input_man
this.sle_type=create sle_type
this.sle_model=create sle_model
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.dw_model_capa=create dw_model_capa
this.pb_model_capa_delete=create pb_model_capa_delete
this.pb_model_capa_save=create pb_model_capa_save
this.dw_model_list=create dw_model_list
this.gb_3=create gb_3
this.Control[]={this.st_23,&
this.st_22,&
this.sle_flag,&
this.st_21,&
this.st_20,&
this.sle_target_rate,&
this.st_19,&
this.st_18,&
this.sle_cycle_time,&
this.st_17,&
this.st_16,&
this.st_15,&
this.sle_input_man,&
this.sle_type,&
this.sle_model,&
this.st_14,&
this.st_13,&
this.st_12,&
this.dw_model_capa,&
this.pb_model_capa_delete,&
this.pb_model_capa_save,&
this.dw_model_list,&
this.gb_3}
end on

on tabpage_3.destroy
destroy(this.st_23)
destroy(this.st_22)
destroy(this.sle_flag)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.sle_target_rate)
destroy(this.st_19)
destroy(this.st_18)
destroy(this.sle_cycle_time)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.sle_input_man)
destroy(this.sle_type)
destroy(this.sle_model)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.dw_model_capa)
destroy(this.pb_model_capa_delete)
destroy(this.pb_model_capa_save)
destroy(this.dw_model_list)
destroy(this.gb_3)
end on

type st_23 from statictext within tabpage_3
integer x = 2729
integer y = 696
integer width = 1211
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "(한 모델에 대해 한개만 선택됩니다.)"
boolean focusrectangle = false
end type

type st_22 from statictext within tabpage_3
integer x = 3250
integer y = 588
integer width = 256
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "(Y, N)"
boolean focusrectangle = false
end type

type sle_flag from singlelineedit within tabpage_3
integer x = 2981
integer y = 584
integer width = 247
integer height = 108
integer taborder = 90
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_21 from statictext within tabpage_3
integer x = 2455
integer y = 576
integer width = 507
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "선택: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_20 from statictext within tabpage_3
integer x = 3397
integer y = 452
integer width = 165
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "%"
boolean focusrectangle = false
end type

type sle_target_rate from singlelineedit within tabpage_3
integer x = 2981
integer y = 460
integer width = 393
integer height = 108
integer taborder = 80
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_19 from statictext within tabpage_3
integer x = 2455
integer y = 452
integer width = 507
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "목표 가동율: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_18 from statictext within tabpage_3
integer x = 3397
integer y = 332
integer width = 165
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "SEC "
boolean focusrectangle = false
end type

type sle_cycle_time from singlelineedit within tabpage_3
integer x = 2981
integer y = 340
integer width = 393
integer height = 108
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_17 from statictext within tabpage_3
integer x = 2455
integer y = 332
integer width = 507
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "CYCLE TIME: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_16 from statictext within tabpage_3
integer x = 2290
integer y = 332
integer width = 133
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "명 "
boolean focusrectangle = false
end type

type st_15 from statictext within tabpage_3
integer x = 2208
integer y = 208
integer width = 389
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "(A, B, C, ...)"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_input_man from singlelineedit within tabpage_3
integer x = 1993
integer y = 340
integer width = 279
integer height = 108
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

type sle_type from singlelineedit within tabpage_3
integer x = 1993
integer y = 212
integer width = 187
integer height = 108
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 1
borderstyle borderstyle = stylelowered!
end type

type sle_model from singlelineedit within tabpage_3
integer x = 1993
integer y = 88
integer width = 411
integer height = 108
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within tabpage_3
integer x = 1614
integer y = 332
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "투입인원: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within tabpage_3
integer x = 1669
integer y = 208
integer width = 297
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "유형: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within tabpage_3
integer x = 1614
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "모델코드: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_model_capa from datawindow within tabpage_3
integer x = 1545
integer y = 868
integer width = 3045
integer height = 1516
integer taborder = 90
string title = "none"
string dataobject = "d_manage_model_capa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
// 선택행 반전 
If row < 1 Then Return
This.SelectRow(0,   False)
This.SelectRow(row, True)
This.ScrollToRow(row)

// 상단 입력화면에 자료 Display
sle_type.Text			= This.GetItemString(row, "type")
sle_input_man.Text	= string(This.GetItemNumber(row, "input_man"))
sle_cycle_time.Text	= string(This.GetItemNumber(row, "cycle_time"))
sle_target_rate.Text	= string(This.GetItemNumber(row, "target_rate")) 
sle_flag.Text			= This.GetItemString(row, "flag")



end event

type pb_model_capa_delete from picturebutton within tabpage_3
integer x = 4119
integer y = 232
integer width = 302
integer height = 156
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 삭제"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 모델별 설정삭제 

String	ls_MODEL, ls_TYPE
Integer 	li_rtn

ls_MODEL 		= Trim(sle_model.Text)
ls_TYPE			= Trim(sle_type.Text)

If Trim(ls_MODEL) = '' Then
	MessageBox("입력확인", "모델를 선택후 삭제하세요.")
	Return
End If

If Trim(ls_TYPE) = '' Then
	MessageBox("입력확인", "유형을 선택후 삭제하세요.")
	Return
End If

li_rtn = MessageBox("삭제확인", "선택자료를 삭제 하시겠습니까?", StopSign!, YesNo!, 2)
If li_rtn = 1 Then
Else
	Return
End If
	
// 기존자료 삭제 
DELETE FROM TM_MODEL_CYCLE
 WHERE MODEL	= :ls_MODEL
   AND TYPE 	= :ls_TYPE;
	
// 모델-CAPA 조회화면 Refresh 
wf_model_get_capa(ls_MODEL)



end event

type pb_model_capa_save from picturebutton within tabpage_3
integer x = 3817
integer y = 232
integer width = 302
integer height = 156
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 등록"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 모델별 설정등록 

String	ls_MODEL, ls_TYPE, ls_FLAG
Long		li_INPUT_MAN
Dec{1}   li_CYCLE_TIME
Double	li_TARGET_RATE

ls_MODEL 		= Trim(sle_model.Text)
ls_TYPE			= Trim(sle_type.Text)
ls_FLAG			= Trim(sle_flag.Text)

If Trim(ls_MODEL) = '' Then
	MessageBox("입력확인", "모델를 선택후 등록하세요.")
	Return
End If

If Trim(ls_TYPE) = '' Then
	MessageBox("입력확인", "유형을 입력하세요.")
	Return
End If

If Trim(sle_input_man.Text) = '' Then
	sle_input_man.Text = '0'
Else
	If IsNumber(Trim(sle_input_man.Text)) = False Then
		MessageBox("입력확인", "투입인원을 숫자로 입력하세요.")
		Return		
	End If
End If

If Trim(sle_cycle_time.Text) = '' Then
	sle_cycle_time.Text = '0'
Else
	If IsNumber(Trim(sle_cycle_time.Text)) = False Then
		MessageBox("입력확인", "CYCLE TIME을 숫자로 입력하세요.")
		Return		
	End If
End If

If Trim(sle_target_rate.Text) = '' Then
	sle_target_rate.Text = '0'
Else
	If IsNumber(Trim(sle_target_rate.Text)) = False Then
		MessageBox("입력확인", "표준가동율을 숫자로 입력하세요.")
		Return		
	End If
End If

li_INPUT_MAN	= lONG(Trim(sle_input_man.Text))
li_CYCLE_TIME	= TRUNCATE(DEC(Trim(sle_cycle_time.Text)),1)
li_TARGET_RATE	= DOUBLE(Trim(sle_target_rate.Text))

	
// 기존자료 삭제 
DELETE FROM TM_MODEL_CYCLE
 WHERE MODEL	= :ls_MODEL
   AND TYPE 	= :ls_TYPE;
	
// 신규자료 등록 
INSERT INTO TM_MODEL_CYCLE
	(MODEL, TYPE, INPUT_MAN, CYCLE_TIME, TARGET_RATE, FLAG)
 VALUES
 	(:ls_MODEL, :ls_TYPE, :li_INPUT_MAN, :li_CYCLE_TIME, :li_TARGET_RATE, :ls_FLAG);
	 
If SQLCA.SqlCode <> 0 Then
	MessageBox("등록오류", SQLCA.SqlErrText)
	Return	
End If

// 모델-CAPA 조회화면 Refresh 
wf_model_get_capa(ls_MODEL)








end event

type dw_model_list from datawindow within tabpage_3
integer x = 23
integer y = 32
integer width = 1509
integer height = 2352
integer taborder = 80
string title = "none"
string dataobject = "d_manage_model_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String ls_cd

// 선택행 반전 
If row < 1 Then Return
This.SelectRow(0,   False)
This.SelectRow(row, True)
This.ScrollToRow(row)

// 선택자료 조회
ls_cd	= This.GetItemString(row, "model")
sle_model.Text = ls_cd 

wf_model_get_capa(ls_cd)

end event

type gb_3 from groupbox within tabpage_3
integer x = 1550
integer width = 3040
integer height = 856
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
end type

