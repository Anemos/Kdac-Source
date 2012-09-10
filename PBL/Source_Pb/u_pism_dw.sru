$PBExportHeader$u_pism_dw.sru
$PBExportComments$DataWindow
forward
global type u_pism_dw from datawindow
end type
end forward

global type u_pism_dw from datawindow
integer width = 846
integer height = 492
integer taborder = 1
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_lbuttonup pbm_dwnlbuttonup
event ue_description pbm_custom01
event ue_accepttext pbm_custom02
event ue_key pbm_dwnkey
event ue_header_sort ( )
event type integer save_data ( )
event type integer delete_data ( long al_delrow )
end type
global u_pism_dw u_pism_dw

type variables
//Shift Key와 Ctrl Key르 사용한
//선택 option을 사용하기 위한 변수들
BOOLEAN 		ib_allow_updates = FALSE
BOOLEAN 		ib_allow_inserts =  FALSE
LONG  		il_selected_row

//validation_struct istr_validations[]

//Multi selection option을 위한 variable
BOOLEAN 		ib_action_on_buttonup = FALSE
LONG  		il_LastClickedRow
BOOLEAN		ib_multiselection = TRUE

//undo기능을 on/off
BOOLEAN		ib_undo_enabled = TRUE 

///////////////////////////////////////////////
//user object의 기능을 trigger
///////////////////////////////////////////////
//DragDrop기능
BOOLEAN		ib_dragdrop = FALSE
STRING		is_dragicon 	//= ".\resource\drag1pg.ico"
STRING		is_dropicon 	//= ".\resource\drop1pg.ico"


//row선택의 수를 결정, default는 multi 
INTEGER		ii_selection = 2

//header sort : ' A' - ascending, ' D' - desending
STRING		is_sort_ad

end variables

forward prototypes
public function boolean uf_is_modified ()
public subroutine uf_set_multirow (boolean ab_value)
public function boolean uf_selection (integer ai_option)
public function integer uf_deleterow (long al_row)
public function integer uf_setitemstatus (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status)
public function integer uf_setitemstatus1 (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status)
public subroutine uf_setdragdrop (boolean ab_value)
public function integer uf_resetstatus ()
public function integer uf_setfocus ()
public function str_undo uf_undo ()
private subroutine uf_key (long al_row)
public subroutine uf_shift_highlight (long al_aclickedrow)
public function boolean uf_check_required ()
public subroutine uf_sethsplitscroll (string as_collist)
end prototypes

event ue_lbuttonup;If This.Describe("DataWindow.Processing") <> '1' Then Return

/***********************************************************************
*		This event will be the controlling event for all of the types of
*		Highlighting that will be done.
***********************************************************************/
Long			ll_ClickedRow
String		ls_KeyDownType


//**********************************************************************
//		First make sure the user clicked on a Row.  Clicking on WhiteSpace
//		or in the header will return a clicked row value of 0.  If that 
//		occurs, just leave this event.
//**********************************************************************


//In filemanager style, the the click and ctrl-click events on a selected row take place
//on the button up event.
If ib_action_on_buttonup Then
	ib_action_on_buttonup = false

	// (CTRL KEY) keep other rows highlighted and highlight a new row or
	// turn off the currint row highlight
	If Keydown(KeyControl!) then
		this.selectrow(il_lastclickedrow,FALSE)
	Else
		this.SelectRow(0,FALSE)
		this.SelectRow(il_lastclickedrow,TRUE)
	End If

	//last action was deselecting a row , an anchor row is no longer defined
	il_lastclickedrow = 0
End If


end event

event ue_accepttext;//item이 수정된후 아직 인정이 안된상태로 남아있을 경우에 대비해서
//focus가 dw를 떠날때 수정된 내용을 item의 data로 받아들임
this.AcceptText()
end event

event ue_key;//화살표키(위,아래)와 pageUp,PageDown키 처리
LONG		ll_row
LONG		ll_rowcount

ll_row = this.GetRow()
ll_rowcount = this.RowCount()
//ll_firstrow = this.Describe( "Datawindow.FirstRowOnPage" )

IF ll_row = 0 THEN RETURN -1

Choose Case key 
	Case KeyPageDown! 
		ll_row = This.ScrollNextPage()
		uf_key(ll_row)
		This.SetRow(ll_row)
		Return 1 
	Case KeyPageUp! 
		ll_row = This.ScrollPriorPage()
		uf_key(ll_row)
		This.SetRow(ll_row)
		Return 1 
	Case KeyQuote!, KeyBackQuote!
	Case KeyDownArrow! 
		If ii_selection > 0 Then 
			This.SelectRow(0, False)
			ll_Row ++ 
			If ll_Row > ll_rowcount Then ll_Row = ll_rowcount
			This.Selectrow(ll_Row, True) 
		End If 
	Case KeyUpArrow! 
		If ii_selection > 0 Then 
			This.SelectRow(0, False)
			ll_Row -- 
			If ll_Row = 0 Then ll_Row = 1 
			This.Selectrow(ll_Row, True) 
		End If 
	Case KeyEnter! 
		send(handle(this), 256, 9, long(0,0)) 
		Return 1 
End Choose 

end event

public function boolean uf_is_modified ();//dw에 item수정(수정,추가,삭제)가 발생하였는지를 확인
//반환 TRUE  	; 수정이 발생하였음
//     FALSE	; 아무런 수정이 일어나지 않았음

//Validation Test를 통과하지 못하였으면 수정이 발생한걸로 간주
IF this.AcceptText() = -1 THEN RETURN TRUE

//수정된 row나 삭제된 row가 있으면 수정된 row
RETURN this.Modifiedcount() > 0 OR this.Deletedcount() > 0 
end function

public subroutine uf_set_multirow (boolean ab_value);//Multi Row 기능을 사용할건지 말건지
IF ab_value THEN
	ib_multiselection = TRUE
ELSE
	ib_multiselection = FALSE
END IF
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

public function integer uf_deleterow (long al_row);//Datawindow의 DeleteRow()를 대체할 Function
//이는 External인 경우 
//DeleteRow Function을 사용하여도 Delete buffer로 넘어가지 않음을 보완하기 위함이다
LONG		ll_old_deletedcount	//DeleteRow를 하기 이전의 DeletedCount
LONG		ll_new_deletedcount	//DeleteRow를 한 다음의 DeletedCount
LONG		ll_old_RowCount		//DeleteRow를 하기 이전의 RowCount
LONG		ll_new_RowCount		//DeleteRow를 한 다음의 RowCount
INTEGER	li_return

//우선 Delete Buffer에 있는 row수를 먼저 읽고 
ll_old_deletedcount = this.DeletedCount()
IF ll_old_deletedcount < 0 THEN ll_old_deletedcount = 0

////지워보고 
//li_return = this.DeleteRow(al_row)
////다시 Delete Buffer에 있는 row수를 비교해 보아서
//ll_new_deletedcount = this.DeletedCount()
//IF ll_new_deletedcount < 0 THEN ll_new_deletedcount = 0
//
//IF ll_new_deletedcount = ll_old_deletedcount + 1 THEN
//	RETURN li_return
//END IF

//제대로 수행되지 않았다면 
//강제로 Delete Buffer로 옮긴다 
li_return = this.RowsMove(al_row,al_row,primary!,&
								this,ll_old_deletedcount + 1,Delete!)
ll_new_deletedcount = this.DeletedCount()								
RETURN li_return

end function

public function integer uf_setitemstatus (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status);////////////////////////////////////////////////////////////////////////
// uf_SetItemStatus
////////////////////////////////////////////////////////////////////////
//DataWindow의 Status를 set(NotModified!)시킨다
//기존의 Function과 다른점은 row값에 0이 들어오면 datawindow전체 row를 SetStatus하고 
//buffer에  null이 들어오면 모든 buffer를 바꾼다 
////////////////////////////////////////////////////////////////////////
LONG				ll_rowcount		//Datawindow의 총 Row
LONG				ll_i				//For..Next를 위한 Temp variable
LONG				ll_start_row	//For Next를 시작할 위치 
LONG				ll_end_row		//For Next를 끝낼 위치 
INTEGER			li_return		//
DWBUFFER			lbuf_current	//3가지 buffer를 처리중 현재의 처리buffer
LONG				ll_buf			//Buffer에 따라 3번 수행하기 위해서 (1 to 3)

//참조 사항 - 변형가능한 Status
//////////////////////////////////////////////////////////////////////////////////
//	Original status	|	New!				NewModified!	DataModified!	NotModified!
//	------------------+-----------------------------------------------------------
//	New!					|	-					Yes				Yes				No
//	NewModified!		|	No					-					Yes				New!
//	DataModified!		|	NewModified!	Yes				-					Yes
//	NotModified!		|	Yes				Yes				Yes				-
//////////////////////////////////////////////////////////////////////////////////

//3가지 Buffer에 대해서 수행 
FOR ll_buf = 1 TO 3
	//Buffer확인 
	IF ll_buf = 1 THEN  			//Primary Buffer!
		IF IsNull(abuf_buffer) OR abuf_buffer = Primary! THEN 
			lbuf_current = Primary!
			ll_rowcount = THIS.RowCount()
		ELSE
			CONTINUE			
		END IF
	ELSEIF ll_buf = 2 THEN		//Filter Buffer!
		IF IsNull(abuf_buffer) OR abuf_buffer = Filter! THEN 
			lbuf_current = Filter!			
			ll_rowcount = THIS.FilteredCount()
		ELSE
			CONTINUE			
		END IF
	ELSEIF ll_buf = 3	THEN		//Delete!
		IF IsNull(abuf_buffer) OR abuf_buffer = Delete! THEN 
			lbuf_current = Delete!			
			ll_rowcount = THIS.DeletedCount()
		ELSE
			CONTINUE			
		END IF
	END IF		

	//범위를 넘어서면 
	IF al_row < 0 OR al_row > ll_rowcount THEN RETURN -1
		
	IF al_row > 0 THEN
		ll_start_row = al_row
		ll_end_row = al_row
	ELSE		//al_row = 0
		ll_start_row = 1
		ll_end_row = ll_rowcount
	END IF
	//Change
	FOR ll_i = ll_start_row TO ll_end_row
		//Set Status
		li_return = THIS.SetItemStatus(ll_i,al_column,lbuf_current,adws_status)
		IF li_return <> 1 THEN RETURN li_return
	NEXT
NEXT
end function

public function integer uf_setitemstatus1 (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status);////////////////////////////////////////////////////////////////////////
// uf_SetItemStatus1
////////////////////////////////////////////////////////////////////////
//DataWindow의 Status를 set(NotModified!)시킨다
//기존의 Function과 다른점은 row값에 0이 들어오면 datawindow전체 row를 SetStatus하고 
//buffer에  null이 들어오면 모든 buffer를 바꾼다 
//그리고 기존에 변형가능한 Status에 제한이 있었다면 
//이 fucntion은 제한이 없다 
//기냥 무조건 원하는 status로 바꾼다. 만세!
//잘하는 짓인지는 모른겠음(이 글을 보는 모든이는 고민바람)
////////////////////////////////////////////////////////////////////////
LONG				ll_rowcount		//Datawindow의 총 Row
LONG				ll_i				//For..Next를 위한 Temp variable
LONG				ll_i_go			//해당 For Next를 한번더 실행할건지 말건지를 판단하기 위해
										//이는 모든 status를 바꿀수 있게 하기위함이다
DWITEMSTATUS	ldws_status		//dw Item의 Status
LONG				ll_start_row	//For Next를 시작할 위치 
LONG				ll_end_row		//For Next를 끝낼 위치 
INTEGER			li_return		//
DWBUFFER			lbuf_current	//3가지 buffer를 처리중 현재의 처리buffer
LONG				ll_buf			//Buffer에 따라 3번 수행하기 위해서 (1 to 3)


//참조 사항 - 변형가능한 Status
//////////////////////////////////////////////////////////////////////////////////
//	Original status	|	New!				NewModified!	DataModified!	NotModified!
//	------------------+-----------------------------------------------------------
//	New!					|	-					Yes				Yes				No
//	NewModified!		|	No					-					Yes				New!
//	DataModified!		|	NewModified!	Yes				-					Yes
//	NotModified!		|	Yes				Yes				Yes				-
//////////////////////////////////////////////////////////////////////////////////

//3가지 Buffer에 대해서 수행 
FOR ll_buf = 1 TO 3
	//Buffer확인 
	IF ll_buf = 1 THEN  			//Primary Buffer!
		IF IsNull(abuf_buffer) OR abuf_buffer = Primary! THEN 
			lbuf_current = Primary!
			ll_rowcount = THIS.RowCount()
		ELSE
			CONTINUE			
		END IF
	ELSEIF ll_buf = 2 THEN		//Filter Buffer!
		IF IsNull(abuf_buffer) OR abuf_buffer = Filter! THEN 
			lbuf_current = Filter!			
			ll_rowcount = THIS.FilteredCount()
		ELSE
			CONTINUE			
		END IF
	ELSEIF ll_buf = 3	THEN		//Delete!
		IF IsNull(abuf_buffer) OR abuf_buffer = Delete! THEN 
			lbuf_current = Delete!			
			ll_rowcount = THIS.DeletedCount()
		ELSE
			CONTINUE			
		END IF
	END IF		

	//범위를 넘어서면 
	IF al_row < 0 OR al_row > ll_rowcount THEN RETURN -1
		
	IF al_row > 0 THEN
		ll_start_row = al_row
		ll_end_row = al_row
	ELSE		//al_row = 0
		ll_start_row = 1
		ll_end_row = ll_rowcount
	END IF
	//Change
	FOR ll_i = ll_start_row TO ll_end_row
		//우선 현재의 Status를 가지고 온다 
		ll_i_go = ll_i
		ldws_status = this.GetItemStatus(ll_i,al_column,lbuf_current)
		CHOOSE CASE ldws_status
			CASE New!
				CHOOSE CASE adws_status
					CASE NewModified!, DataModified!
						ldws_status = adws_status
					CASE NotModified!
						ldws_status = DataModified!
						ll_i_go --		//한번더 수행	
					CASE ELSE
						RETURN -1				
				END CHOOSE				
			CASE NewModified!
				CHOOSE CASE adws_status
					CASE New!
						ldws_status = NotModified!
					CASE DataModified!
						ldws_status = adws_status
					CASE NotModified!
						ldws_status = DataModified!
						ll_i_go --		//한번더 수행					
					CASE ELSE
						RETURN -1				
				END CHOOSE				
			CASE DataModified!
				CHOOSE CASE adws_status				
					CASE New!
						ldws_status = NotModified!
						ll_i_go --		//한번더 수행							
					CASE NewModified!
						ldws_status = adws_status
					CASE NotModified!
						ldws_status = DataModified!
					CASE ELSE
						RETURN -1				
				END CHOOSE
			CASE NotModified!
				ldws_status = adws_status
			CASE ELSE
				RETURN -1				
		END CHOOSE		
		
		//Set Status
		li_return = THIS.SetItemStatus(ll_i,al_column,lbuf_current,ldws_status)
		IF li_return <> 1 THEN RETURN li_return
		//다시한번 수행할지도
		ll_i = ll_i_go
	NEXT
NEXT

RETURN 1
end function

public subroutine uf_setdragdrop (boolean ab_value);//////////////////////////////////////////////////////////////
// Function : uf_setdragdrop
// Description : DragDrop기능을 Eanbled Disable 시킨다 
// Arguments		ab_value	TRUE  - Dragdrop Enable
//									FALSE	- Dragdrop Disable
/////////////////////////////////////////////////////////////

ib_dragdrop = ab_value
end subroutine

public function integer uf_resetstatus ();//DataWindpw의 Status를 Reset(NotModified!)시킨다

INTEGER			li_return

//Primary Buffer!
li_return = THIS.uf_setitemstatus1(0,0,Primary!,NotModified!)
IF li_return <> 1 THEN RETURN li_return

//Filter Buffer!
li_return = THIS.uf_setitemstatus1(0,0,Filter!,NotModified!)
IF li_return <> 1 THEN RETURN li_return

//Delete Buffer!
li_return = THIS.uf_setitemstatus1(0,0,Delete!,NotModified!)
IF li_return <> 1 THEN RETURN li_return

RETURN 1


end function

public function integer uf_setfocus ();THIS.Trigger Event GetFocus()
RETURN THIS.SetFocus()
end function

public function str_undo uf_undo ();STR_UNDO		lstr_rows_undid		//취소된  row count를 반환받음

//undo기능이 허용되었을 때만
IF ib_undo_enabled THEN
	IF ( this.ModifiedCount() + this.DeletedCount())  = 0 THEN
		MessageBox ("작업 무시","변경(수정,추가,삭제)된 row가 하나도 없습니다")
	ELSE
//		OpenWithParm (w_undo_r, this)
		lstr_rows_undid = message.PowerObjectParm
	END IF
END IF

RETURN lstr_rows_undid

end function

private subroutine uf_key (long al_row);//키가 눌려졌을때 click된 것처럼 해줌
LONG		ll_ClickedRow
STRING	ls_KeyDownType

ll_clickedrow = al_row

If ll_clickedrow = 0 then RETURN

CHOOSE CASE ii_selection
	CASE 0		//DISC_ZERO
		//선택기능 OFF
	CASE 1		//DISC_ONE
		//한번에 1개의 ROW만 선택
		this.SelectRow(0,FALSE)
		this.SelectRow(ll_clickedrow,TRUE)
	CASE 2		//DISC_MULTI
		//다중 선택기능이 On상태이면
		IF Keydown(KeyShift!) THEN
			//Shift KEY를 누른채로이면 여러 row선택
			uf_Shift_Highlight(ll_clickedrow)
		ELSEIF this.IsSelected(ll_clickedrow) THEN
			//이미 선택된 row이면
			il_LastClickedRow = ll_clickedrow
			ib_action_on_buttonup = true
		ELSEIF Keydown(KeyControl!) then
			//CTRL KEY가 눌려진 상태이고 이미 선택된 row가 아니라면 선택
			il_LastClickedRow = ll_clickedrow
			this.SelectRow(ll_clickedrow,TRUE)
		ELSE
			//이도저도 아미면 하나만 선택
			il_LastClickedRow = ll_clickedrow
			this.SelectRow(0,FALSE)
			this.SelectRow(ll_clickedrow,TRUE)
		END IF
END CHOOSE
end subroutine

public subroutine uf_shift_highlight (long al_aclickedrow);//**********************************************************************
//  이전에 선택된(clicked) row가 있으면 그 row와 마지막으로 선택된 row
//  사이를 모두 선택(highlight)시킨다.
//  처음으로 clicked된 row면 해당 row만 highlight시킨다
//  인수로는 현재 clicked된 row를 가져온다
//**********************************************************************
INTEGER	li_i

//우선 모든 선택(highlight)을 없앤다
this.SetRedraw(FALSE)
this.SelectRow(0,FALSE)

//이전에 선택된 ror가 없으면 해당 row만 선택(highlight)
IF il_lastclickedrow = 0 THEN
	this.SelectRow(al_aclickedrow,TRUE)
	this.setredraw(true)
	RETURN
END IF

//이전에 선택된 row가 있으면 뒤에서 부터 이전에 선택된 row까지 반저(highlight)
IF il_lastclickedrow > al_aclickedrow THEN
	FOR li_i = il_lastclickedrow TO al_aclickedrow STEP -1
		this.SelectRow(li_i,TRUE)
	NEXT
ELSE
	//selection moving forward
	FOR li_i = il_lastclickedrow TO al_aclickedrow 
		this.SelectRow(li_i,TRUE)	
	NEXT
END IF

//바뀌어진 사항을 보인다(draw)
this.SetRedraw( TRUE )
RETURN

end subroutine

public function boolean uf_check_required ();// check to see if all required fields have been entered
// position the user to the row and column in error
LONG		row
WINDOW 	parent_win
INTEGER	col
STRING	colname

row = 1
col = 1

// Loop to find all instances
DO WHILE row <> 0
// Check to be sure the function worked.
	if this.FindRequired(primary!,row,col,colname,TRUE) < 0 then return false

// If row is not 0, a required row,column was found without a value.
// Display a message.
	if row <> 0 then
		parent_win = parent
		MessageBox(parent_win.title,"Required Value Missing for "+ colname +" on row " + string (row)+'. Please enter a value.',stopsign! )

// Make the column and row without a value current.
		this.SetColumn(col)
		this.SetRow(col)
		this.ScrollToRow(row)
		return false
	end if

// This row and column was ok, increment the column to check this 
// row in the next column.
	col++
LOOP


RETURN TRUE
end function

public subroutine uf_sethsplitscroll (string as_collist);String ls_col, ls_ColX, ls_colWodth

If This.HSplitScroll Then  
	If as_colList = '' Then 
		This.Object.DataWindow.HorizontalScrollSplit = '0'
	Else
		ls_col = Left(as_colList, Pos(as_colList, ',') - 1 )
		If ls_col <> '' Then 
			ls_ColX = This.Describe(ls_col + ".X")
			This.Object.DataWindow.HorizontalScrollSplit = String( Integer( Ls_Colx ) )
			This.Object.DataWindow.HorizontalScrollPosition = '0'
		End If 
		
		ls_col = Right(as_colList, Len(as_colList) - Pos(as_colList, ',') )
		If ls_col <> '' Then 
			ls_ColX = This.Describe(ls_col + ".X")
			ls_colWodth = This.Describe(ls_col + ".width")
			This.Object.DataWindow.HorizontalScrollPosition2 = String( Integer( Ls_Colx ) + Integer(ls_colWodth) )
		End If 
	End If 
End If 

end subroutine

event dberror;//str_xcs_dberror	lstr_dberror
//
//lstr_dberror.ss_type = '1'
//lstr_dberror.sl_code = sqldbcode
//lstr_dberror.ss_text = sqlerrtext
//
//f_server_error_check(-1, lstr_dberror, 0, 1)
//Return 1

////////////////////////////////////////////////////
//// Datawindow에서 Error가 발생시 처리
////////////////////////////////////////////////////

STRING			ls_err_type		//error발생 유형(추가,삭제, 수정..)
STRING			ls_err_msg		//보여줄 error 메시지
DWITEMSTATUS	stat

CHOOSE CASE buffer
	CASE delete!		//삭제된 row처리중 error발생하였으면
		ls_err_type = "삭제"
	CASE primary!		//삭제된 row가 아닌 row처리중 error가 발생하였으면
		
		//error가 발생한 row의 편집상태를 확인한다
		stat = this.GetItemStatus(row, 0, buffer)
		IF stat = new! OR stat = newmodified! THEN 	//추가된 row이면
			ls_err_type = "추가"
		ELSE
			ls_err_type = "수정"
		END IF
END CHOOSE

//Error Message변경 => Value Display
STRING	ls_sqlerrtext
STRING	ls_values
STRING	ls_new_values = "( "
INTEGER	li_pos
STRING	ls_column
INTEGER	li_column
STRING	ls_column_datatype
STRING	ls_column_value

li_pos = Pos(sqlerrtext,"VALUES")
IF li_pos < 1 THEN
	ls_err_msg += sqlerrtext
ELSE
	ls_sqlerrtext= Left( sqlerrtext, li_pos + 5)
	ls_values = Mid(sqlerrtext,li_pos + 6 )	
	ls_values = f_global_replace(ls_values,"(","")
	ls_values = f_global_replace(ls_values,":","")
	ls_values = f_global_replace(ls_values,")","")	
	Do While ls_values <> ""
		//한 Column을 분리해 낸다
		ls_column = Trim(f_get_token(ls_values,","))
		li_column = Integer(ls_column)
		IF li_column < 1 THEN EXIT

		//ColumnType을 가져온다 
		ls_column_datatype = Lower(this.Describe("#" + ls_column + ".coltype"))
		IF Left(ls_column_datatype,4) = "char" THEN 
			ls_column_datatype = "char"
		END IF
		//Get Value
		CHOOSE CASE ls_column_datatype
			CASE "string","char"
				ls_column_value = Trim(this.GetItemString(row,li_column))
				//String은 ''로 감싼다
				IF IsNull( ls_column_value ) = FALSE THEN
					ls_column_value = "'" + ls_column_value + "'"
				END IF
			CASE "date"
				ls_column_value = String(this.GetItemDate(row,li_column))
			CASE "datetime"
				ls_column_value = String(this.GetItemDateTime(row,li_column))
			CASE "time"
				ls_column_value = String(this.GetItemTime(row,li_column))
			CASE "number"
				ls_column_value = String(this.GetItemNumber(row,li_column))
			CASE "decimal"
				ls_column_value = String(this.GetItemDecimal(row,li_column))
		END CHOOSE
		IF IsNull(ls_column_value) THEN
			ls_column_value = "[null]"
		END IF

		ls_new_values += ls_column_value + " , "
	LOOP
	//
	ls_new_values = Left( ls_new_values, len(ls_new_values) -1) + ")"
	//New Error Msg
	ls_sqlerrtext += ls_new_values
	ls_err_msg += ls_sqlerrtext	
END IF

Choose Case sqldbcode
	Case -3, 2627 
		ls_err_msg = "~r~n~r~n 조회이후 타사용자에 의해 동일품번의 Data가~r~n~r~n 선변경되었습니다." + & 
						 "~r~n~r~n 확인 후 다시 작업해 주시기 바랍니다." 
	Case Else
		ls_err_msg = ls_err_type + "된 " + String(row) + "번째 열에서 오류가 발생하였습니다"
		ls_err_msg = ls_err_msg + "~r~n DB Error 번호   : " + String(sqldbcode)
		ls_err_msg = ls_err_msg + "~r~n DB Error 메시지 :~r~n~r~n" 
End Choose 
	
WINDOW				lw_parentwindow
GRAPHICOBJECT		lgo_this
lgo_this = this
lw_parentwindow = f_get_parentwindow(lgo_this)
IF IsNull(lw_parentwindow) = TRUE THEN
	f_error_box("Datawindow DB Error!",ls_err_msg)
ELSE
	f_error_box(lw_parentwindow.title,ls_err_msg)
END IF
// messagebox("AA",sqlerrtext)
this.SetFocus()
this.SetRow(row)
this.ScrollToRow(row)

RETURN 1

end event

event clicked;// 2001.09.20
// header sorting => double clicked event로 

IF row <= 0 THEN 
	This.SelectRow(0, False) 
	RETURN
End If 

IF ib_dragdrop = TRUE  THEN
	//현재 drag되는 icon의 설명을 보임
	THIS.dragicon = THIS.is_dragicon
	THIS.drag(BEGIN!)
END IF

//THIS.SetRow(row)
CHOOSE CASE ii_selection
	CASE 0		//DISC_ZERO
		//선택기능 OFF
		THIS.SelectRow(0,FALSE)
	CASE 1		//DISC_ONE
		//한번에 1개의 ROW만 선택
		THIS.SelectRow(0,FALSE)
		THIS.SelectRow(row,TRUE)
	CASE 2		//DISC_MULTI
		//다중 선택기능이 On상태이면
		IF Keydown(KeyShift!) THEN
			//Shift KEY를 누른채로이면 여러 row선택
			uf_Shift_Highlight(row)
		ELSEIF THIS.IsSelected(row) THEN
			//이미 선택된 row이면
			il_LastClickedRow = row
			ib_action_on_buttonup = true
		ELSEIF Keydown(KeyControl!) then
			//CTRL KEY가 눌려진 상태이고 이미 선택된 row가 아니라면 선택
			il_LastClickedRow = row
			THIS.SelectRow(row,TRUE)
		ELSE
			//이도저도 아미면 하나만 선택
			il_LastClickedRow = row
			THIS.SelectRow(0,FALSE)
			THIS.SelectRow(row,TRUE)
		END IF
END CHOOSE

THIS.SetRow(row)
end event

event getfocus;///* 포커스를 받으면 현재 자신이 선택되었음을 설정 */
//
window		lw_sheet

lw_sheet = f_get_parentwindow(THIS)
lw_sheet.TriggerEvent("ue_set_focus")
end event

event losefocus;//item이 수정된후 아직 인정이 안된상태로 남아있을 경우에 대비해서
//focus가 dw를 떠날때 수정된 내용을 item의 data로 받아들임
this.PostEvent( "ue_accepttext" )
end event

event rowfocuschanged;/////////////////////////////////////////////////////
//Tab Key와 (Reverse Tab Key)를 지원하기 위해 
IF currentrow > 0 AND KeyDown( KeyTab! ) THEN 
	THIS.SetRow(currentrow)
	CHOOSE CASE ii_selection
		CASE 0		//DISC_ZERO
			//선택기능 OFF
		CASE 1		//DISC_ONE
			//한번에 1개의 ROW만 선택
			this.SelectRow(0,FALSE)
			this.SelectRow(currentrow,TRUE)
		CASE 2		//DISC_MULTI
			//다중 선택기능이 On상태이면
			IF Keydown(KeyShift!) THEN
				//Shift KEY를 누른채로이면 여러 row선택
				uf_Shift_Highlight(currentrow)
			ELSEIF this.IsSelected(currentrow) THEN
				//이미 선택된 row이면
				il_LastClickedRow = currentrow
				ib_action_on_buttonup = true
			ELSEIF Keydown(KeyControl!) then
				//CTRL KEY가 눌려진 상태이고 이미 선택된 row가 아니라면 선택
				il_LastClickedRow = currentrow
				this.SelectRow(currentrow,TRUE)
			ELSE
				//이도저도 아미면 하나만 선택
				il_LastClickedRow = currentrow
				this.SelectRow(0,FALSE)
				this.SelectRow(currentrow,TRUE)
			END IF
	END CHOOSE
END IF
/////////////////////////////////////////////////////
end event

on u_pism_dw.create
end on

on u_pism_dw.destroy
end on

event error;// after finished DW Project, Please unComment.
action = ExceptionIgnore! 
end event

event rbuttondown;//m_basic_mdi			lm_menu
//w_basic_mdi			lw_parent
//w_basic_m			lw_sheet
//
//// Get and store the parent object.
//lw_sheet = f_get_parentwindow(This)
//
//// 2001.09.16 - 윈도우가 main일 경우에만 메뉴 동작
//IF lw_sheet.WindowType = Main! THEN
//	lw_parent = lw_sheet.ParentWindow()
//	lm_menu = lw_parent.menuid
//	lm_menu.item[2].PopMenu(lw_parent.PointerX(), lw_parent.PointerY())
//ELSE
//	Return
//END IF	
end event

event itemerror;// 2001.09.20
// validation error 관련 처리
Return 1
end event

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
	
	li_tab = Pos(ls_object,"_s~t",1)
	IF li_tab > 0 THEN
		ls_header = Mid(ls_object,1,(li_tab - 1))
		lb_sort = True
	Else
		li_tab = Pos(ls_object,"_s_f~t",1)
		IF li_tab > 0 THEN
			ls_header = Mid(ls_object,1,(li_tab - 1))
			lb_sort = True
		End IF
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

event retrieveend;String ls_col, ls_ColX, ls_colList, ls_colWodth

Parent.Dynamic Event ue_retResult(rowcount)
uf_setHSplitScroll(This.Tag) 
end event

