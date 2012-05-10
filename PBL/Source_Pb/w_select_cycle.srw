$PBExportHeader$w_select_cycle.srw
$PBExportComments$모델에 속한 CYCLE 선택화면
forward
global type w_select_cycle from window
end type
type pb_select from picturebutton within w_select_cycle
end type
type dw_cycle from datawindow within w_select_cycle
end type
type pb_close from picturebutton within w_select_cycle
end type
type st_1 from statictext within w_select_cycle
end type
end forward

global type w_select_cycle from window
integer width = 2683
integer height = 2016
boolean titlebar = true
string title = "CYCLE TIME 선택"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "Form!"
boolean center = true
pb_select pb_select
dw_cycle dw_cycle
pb_close pb_close
st_1 st_1
end type
global w_select_cycle w_select_cycle

type variables
Long	il_SelectedRow

end variables

forward prototypes
public subroutine wf_change_model_type ()
end prototypes

public subroutine wf_change_model_type ();// 적용모델 유형을 반영한다.
// 
String ls_INPUT_MAN, ls_TYPE

ls_INPUT_MAN 	= String(dw_cycle.GetItemNumber(il_SelectedRow, "input_man"))
ls_TYPE 			= dw_cycle.GetItemString(il_SelectedRow, "type")

w_main.st_input_man.Text = ls_INPUT_MAN + ' 명'

// 현재적용 유형을 반영 
DECLARE SP_ACT_MODEL_FLAG PROCEDURE FOR SP_ACT_MODEL_FLAG
		@parm_MODEL				= :gs_MODEL_CODE,
		@parm_TYPE				= :ls_TYPE;								
EXECUTE SP_ACT_MODEL_FLAG ;		
CLOSE SP_ACT_MODEL_FLAG ;
	

end subroutine

on w_select_cycle.create
this.pb_select=create pb_select
this.dw_cycle=create dw_cycle
this.pb_close=create pb_close
this.st_1=create st_1
this.Control[]={this.pb_select,&
this.dw_cycle,&
this.pb_close,&
this.st_1}
end on

on w_select_cycle.destroy
destroy(this.pb_select)
destroy(this.dw_cycle)
destroy(this.pb_close)
destroy(this.st_1)
end on

event open;// 1주일간 일자별 가동율을 조회 
dw_cycle.SetTransObject(SQLCA)
dw_cycle.SetRedraw(False)
dw_cycle.Reset()
dw_cycle.Retrieve(gs_model_code)
dw_cycle.SetRedraw(True)

end event

type pb_select from picturebutton within w_select_cycle
integer x = 18
integer y = 1624
integer width = 1586
integer height = 304
integer taborder = 20
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "선택"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 선택 
If il_SelectedRow < 1 Then Return

wf_change_model_type()
Close(Parent) 

	
	

end event

type dw_cycle from datawindow within w_select_cycle
integer x = 32
integer y = 28
integer width = 2606
integer height = 1544
integer taborder = 10
string title = "none"
string dataobject = "d_select_cycle"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// 선택행 반전 
If row < 1 Then Return
This.SelectRow(0,   False)
This.SelectRow(row, True)
This.ScrollToRow(row)

il_SelectedRow = Row

end event

event doubleclicked;
// 선택 
If row < 1 Then Return
wf_change_model_type()
Close(Parent) 

end event

type pb_close from picturebutton within w_select_cycle
integer x = 1614
integer y = 1624
integer width = 1042
integer height = 304
integer taborder = 10
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "닫기"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 닫기 
Close(Parent) 


end event

type st_1 from statictext within w_select_cycle
integer y = 1604
integer width = 2683
integer height = 352
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 0
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

