$PBExportHeader$uo_vi_dw.sru
$PBExportComments$데이타 윈도우 표준
forward
global type uo_vi_dw from datawindow
end type
end forward

global type uo_vi_dw from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_keydown pbm_dwnkey
event ue_vscroll pbm_vscroll
event ue_select_row ( long currentrow )
end type
global uo_vi_dw uo_vi_dw

type variables
//row선택의 수를 결정, default는 multi 
//INTEGER		ii_selection = 2
INTEGER		ii_selection = 1

//header sort : ' A' - ascending, ' D' - desending
STRING		is_sort_ad
//KeyDown True ,False
Boolean lb_KeyDown = True
end variables

forward prototypes
public subroutine uf_key (long al_row)
public function boolean uf_selection (integer ai_option)
public function boolean uf_is_modified ()
public subroutine uf_set_keydown (boolean arb_keydown)
end prototypes

event ue_keydown;//적용여부 결정 uf_set_KeyDown(Boolean lb_KeyDown)
IF lb_KeyDown = False Then Return 

// 화살표키(위,아래)와 pageUp,PageDown키 처리
LONG		ll_row
LONG		ll_rowcount

ll_row = This.GetRow()
ll_rowcount = This.RowCount()
//ll_firstrow = this.Describe( "Datawindow.FirstRowOnPage" )

IF ll_row = 0 THEN RETURN -1

IF Key = KeyTab! THEN
	Return 0
END IF

// 2001.08.01
IF Key = KeyQuote! OR Key = KeyBackQuote! THEN
	RETURN 1
END IF	

IF Key = KeyDownArrow! THEN
	IF ll_row < ll_rowcount THEN 
		ll_row++
		uf_key( ll_row )
		This.ScrollToRow(ll_row)
		This.SetRow(ll_row)		// 2001.08.16
	END IF
END IF

IF Key = KeyUpArrow! THEN
	IF ll_row > 1 THEN 
		ll_row = ll_row - 1
		uf_key( ll_row )
		This.ScrollToRow(ll_row)
		This.SetRow(ll_row)		// 2001.08.16
	END IF
END IF

IF Key = KeyPageDown! THEN
	ll_row = This.ScrollNextPage()
	uf_key(ll_row)
	This.SetRow(ll_row)
END IF

IF Key = KeyPageUp! THEN
	ll_row = This.ScrollPriorPage()
	uf_key(ll_row)
	This.SetRow(ll_row)
END IF

This.Trigger Event ue_select_row(ll_row)

Return 1
end event

event ue_vscroll;////// DataWindow Event_ID pbm_vscroll 
//
//Long ll_scrollPos, ll_detail
//String ls_Row, ls_vScrollPos, ls_Chk 
//
////ll_header		= Long(Describe("DataWindow.Header.Height"))
//ll_detail		= Long(Describe("DataWindow.Detail.Height"))
//
//If scrollcode = 0 Then 		// ▲ 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
//	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//
//	Return 1 
//ElseIf scrollcode = 1 Then 	// ▼
//	
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
//	
//	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//	If ls_Chk <> '' Then MessageBox("", ls_Chk)
//	Return 1 
//End If 
//
end event

event ue_select_row(long currentrow);//
IF currentrow < 0 Then Return 
end event

public subroutine uf_key (long al_row);//키가 눌려졌을때 click된 것처럼 해줌
If al_row = 0 then RETURN
This.SelectRow(0,FALSE)
This.SelectRow(al_row,TRUE)
end subroutine

public function boolean uf_selection (integer ai_option);///////////////////////////////////////////////////////////////
//data window에서 얼마나 많은 row의 선택을 허용할지 결정
// as_option = 0 ; selection을 허용하지 않음
// 				1 ; 1개의 row에 대해서만 selection을 허용
// 				2 ; MultiRow Selction을 허용
///////////////////////////////////////////////////////////////

ii_selection = ai_option
CHOOSE CASE ai_option
	CASE 0		//DISC_ZERO
	CASE 1		//DISC_ONE
	CASE 2		//DISC_MULTI
END CHOOSE

RETURN TRUE
end function

public function boolean uf_is_modified ();//dw에 item수정(수정,추가,삭제)가 발생하였는지를 확인
//반환 TRUE  	; 수정이 발생하였음
//     FALSE	; 아무런 수정이 일어나지 않았음

//Validation Test를 통과하지 못하였으면 수정이 발생한걸로 간주
IF this.AcceptText() = -1 THEN RETURN TRUE

//수정된 row나 삭제된 row가 있으면 수정된 row
RETURN this.Modifiedcount() > 0 OR this.Deletedcount() > 0 
end function

public subroutine uf_set_keydown (boolean arb_keydown);
lb_KeyDown =  arb_KeyDown
end subroutine

event doubleclicked;
STRING		ls_object, ls_header
INT			li_tab, li_row
BOOLEAN		lb_sort = False

// 2001.09.20
// header sort => clicked event에서 이동

IF left(This.GetBandAtPointer(), 6) = 'header' THEN
	SetPointer(HourGlass!)
	
	ls_object = This.GetObjectAtpointer()

	IF Len(ls_object) = 0 THEN Return 	// Grid type에서 header사이 누를때 오동작처리
	
	li_tab = Pos(ls_object,"_t~t",1)
	IF li_tab > 0 THEN
		ls_header = Mid(ls_object,1,(li_tab - 1))
		lb_sort = True
//	Else
//		li_tab = Pos(ls_object,"_s_f~t",1)
//		IF li_tab > 0 THEN
//			ls_header = Mid(ls_object,1,(li_tab - 1))
//			lb_sort = True
//		End IF
	End If	

	// 2001.09.24
	// _s, _s_f 일 경우에만 sort
	IF lb_sort = True THEN
		IF is_sort_ad = ' A' THEN
			is_sort_ad = ' D'
		ELSE
			is_sort_ad = ' A'
		END IF
		
		This.SetRedraw(False)
		ls_header = ls_header + is_sort_ad
		This.SetSort(ls_header)
		This.Sort()
		This.GroupCalc()				// 2001.09.24 - sort후 groupcalc
		This.SetRedraw(True)
		
		// 2001.09.20 
		// sort후 focus된 row로 scroll
		li_row = This.GetSelectedRow(0)
		IF li_row > 0 THEN
			This.SelectRow(0, False)
			This.SelectRow(li_row, True)
			This.SetRow(li_row)
			This.ScrollToRow(li_row)
		END IF	
	END IF	
	
	SetPointer(Arrow!)
END IF
end event

on uo_vi_dw.create
end on

on uo_vi_dw.destroy
end on

event itemerror;// 2001.09.20
// validation error 관련 처리
Return 1
end event

event losefocus;This.AcceptText()
end event

event rowfocuschanged;///////////////////////////////////////////////////////
////Tab Key와 (Reverse Tab Key)를 지원하기 위해
////////////////////////////////////////////////////////
//Long ln_selected , ln_i
//IF currentrow > 0 AND KeyDown( KeyTab! ) THEN
//	THIS.SetRow(currentrow)
//	CHOOSE CASE ii_selection
//		CASE 0		//DISC_ZERO
//			//선택기능 OFF
//		CASE 1		//DISC_ONE
//			//한번에 1개의 ROW만 선택
//			this.SelectRow(0,FALSE)
//			this.SelectRow(currentrow,TRUE)
//		CASE 2		//DISC_MULTI
//			//다중 선택기능이 On상태이면
//			IF KeyDown(KeyShift!) Then
//				ln_selected = This.GetSelectedRow(0)
//				IF ln_selected > 0 Then
//					For ln_i = Min(ln_selected,currentrow) To Max(ln_selected,currentrow)
//						 This.SelectRow(ln_i,True)
//					Next
//				Else
//					This.SelectRow(currentrow,True)
//				End IF
//				
//			ElseIF KeyDown(KeyControl!) Then
//				IF This.IsSelected(currentrow) Then
//					This.SelectRow(currentrow,False)
//				Else
//					This.SelectRow(currentrow,True)
//				End IF
//			Else
//				This.SelectRow(0,False)
//				This.SelectRow(currentrow,True)
//			End IF
//	END CHOOSE
//END IF
///////////////////////////////////////////////////////
end event

event getfocus;/* 포커스를 받으면 현재 자신이 선택되었음을 설정 */

window		lw_sheet

lw_sheet = f_get_parentwindow(THIS)
lw_sheet.TriggerEvent("ue_set_focus")
end event

