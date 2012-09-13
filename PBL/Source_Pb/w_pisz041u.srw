$PBExportHeader$w_pisz041u.srw
$PBExportComments$기준월 등록
forward
global type w_pisz041u from w_pism_resp01
end type
type cb_close from commandbutton within w_pisz041u
end type
type uo_styear from u_pism_year-1 within w_pisz041u
end type
type cb_add from commandbutton within w_pisz041u
end type
type cb_del from commandbutton within w_pisz041u
end type
type st_2 from statictext within w_pisz041u
end type
type cb_save from commandbutton within w_pisz041u
end type
type dw_source from u_pism_dw within w_pisz041u
end type
type dw_target from u_pism_dw within w_pisz041u
end type
end forward

global type w_pisz041u from w_pism_resp01
integer width = 1120
integer height = 1944
string title = "전년도 기준월 등록"
boolean controlmenu = false
cb_close cb_close
uo_styear uo_styear
cb_add cb_add
cb_del cb_del
st_2 st_2
cb_save cb_save
dw_source dw_source
dw_target dw_target
end type
global w_pisz041u w_pisz041u

type variables
Long ii_dragged_sRow, ii_dragged_tRow 
end variables

forward prototypes
public subroutine wf_stmonthinit ()
end prototypes

public subroutine wf_stmonthinit ();Integer li_rowCnt, I 

dw_target.SetTransObject(SqlPIS)
li_rowCnt = dw_target.Retrieve(istr_mh.area, istr_mh.div, istr_mh.year)
If li_rowCnt > 0 Then 
	For I = 1 To li_rowCnt
		dw_source.DeleteRow(dw_source.Find ("month = '" + dw_target.GetItemString(I, "month") + "'", 1, dw_source.RowCount()))
	Next 
End If 
end subroutine

on w_pisz041u.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_styear=create uo_styear
this.cb_add=create cb_add
this.cb_del=create cb_del
this.st_2=create st_2
this.cb_save=create cb_save
this.dw_source=create dw_source
this.dw_target=create dw_target
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_styear
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_del
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.dw_source
this.Control[iCurrent+8]=this.dw_target
end on

on w_pisz041u.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_styear)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.st_2)
destroy(this.cb_save)
destroy(this.dw_source)
destroy(this.dw_target)
end on

event ue_retrieve;call super::ue_retrieve;istr_mh.year = uo_styear.uf_setapplyyear(istr_mh)

wf_stmonthinit() 
end event

event open;call super::open;This.PostEvent("ue_retrieve")
end event

type cb_close from commandbutton within w_pisz041u
integer x = 663
integer y = 1732
integer width = 398
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;Close(Parent) 
end event

type uo_styear from u_pism_year-1 within w_pisz041u
integer x = 5
integer y = 8
integer width = 681
integer taborder = 20
end type

on uo_styear.destroy
call u_pism_year-1::destroy
end on

event ue_variable_change;call super::ue_variable_change;istr_mh.year = uo_styear.uis_appYear
end event

type cb_add from commandbutton within w_pisz041u
integer x = 448
integer y = 524
integer width = 187
integer height = 196
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "▶"
end type

event clicked;Long ll_insRow, ll_selected_count, ll_selected_rows[]  
Integer I 

ll_selected_count = f_pism_return_selected (dw_source, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_target.SetRedraw(False)
	dw_source.SelectRow(0, False)

	For i = ll_selected_count To 1 Step -1 
		
		ll_insrow = dw_target.InsertRow(0) 
		dw_target.SetItem(ll_insRow, "areacode", istr_mh.area)
		dw_target.SetItem(ll_insRow, "divisioncode", istr_mh.div)
		dw_target.SetItem(ll_insRow, "styear", istr_mh.year)
		
		dw_target.SetItem(ll_insRow, "month", dw_source.GetItemString(ll_selected_rows[I], "month"))
		dw_target.SetItem(ll_insRow, "lastemp", g_s_empno)
		
		dw_source.DeleteRow(ll_selected_rows[I]) 
		dw_target.SelectRow(ll_insRow, True) 
	Next 
	dw_target.Sort() 
	dw_target.SetRedraw(True)	
	
	cb_save.Enabled = True 
End If
end event

type cb_del from commandbutton within w_pisz041u
integer x = 448
integer y = 720
integer width = 187
integer height = 196
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "◀"
end type

event clicked;Long ll_selected_count, ll_selected_rows[], ll_insrow 
Integer I 

ll_selected_count = f_pism_return_selected (dw_target, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_source.SetRedraw(False)
	dw_target.SelectRow(0, False)
	For i = ll_selected_count To 1 Step -1 

		ll_insrow = dw_source.InsertRow(0) 
		dw_source.SetItem(ll_insRow, "month", dw_target.GetItemString(ll_selected_rows[I], "month"))
		dw_target.DeleteRow(ll_selected_rows[I])
		dw_source.SelectRow(ll_insRow, True) 		
	Next 
	dw_source.Sort() 
	dw_source.SetRedraw(True)	
	
	cb_save.Enabled = True 
End If 
end event

type st_2 from statictext within w_pisz041u
integer x = 635
integer y = 180
integer width = 448
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[기준월LIST]"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_pisz041u
integer x = 265
integer y = 1732
integer width = 398
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;If f_pism_dwupdate(dw_target, True) = -1 Then MessageBox("에러", "에러발생!!!", StopSign!)

CloseWithReturn(Parent, '1')
end event

type dw_source from u_pism_dw within w_pisz041u
integer x = 23
integer y = 244
integer width = 416
integer height = 1464
integer taborder = 30
string dragicon = "DataWindow5!"
string dataobject = "d_pism041u_01"
end type

type dw_target from u_pism_dw within w_pisz041u
integer x = 640
integer y = 248
integer width = 416
integer height = 1464
integer taborder = 30
string dragicon = "Form!"
string dataobject = "d_pism041u_02"
end type

