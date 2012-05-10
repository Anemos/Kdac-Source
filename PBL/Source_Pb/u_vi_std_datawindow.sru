$PBExportHeader$u_vi_std_datawindow.sru
$PBExportComments$basic datawindow~t
forward
global type u_vi_std_datawindow from datawindow
end type
end forward

global type u_vi_std_datawindow from datawindow
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
end type
global u_vi_std_datawindow u_vi_std_datawindow

type variables
//Shift Key�� Ctrl Key�� �����
//���� option�� ����ϱ� ���� ������
BOOLEAN 		ib_allow_updates = FALSE
BOOLEAN 		ib_allow_inserts =  FALSE
LONG  		il_selected_row

//validation_struct istr_validations[]

//Multi selection option�� ���� variable
BOOLEAN 		ib_action_on_buttonup = FALSE
LONG  		il_LastClickedRow
BOOLEAN		ib_multiselection = TRUE

//undo����� on/off
BOOLEAN		ib_undo_enabled = TRUE 

///////////////////////////////////////////////
//user object�� ����� trigger
///////////////////////////////////////////////
//DragDrop���
BOOLEAN		ib_dragdrop = FALSE
STRING		is_dragicon 	//= ".\resource\drag1pg.ico"
STRING		is_dropicon 	//= ".\resource\drop1pg.ico"


//row������ ���� ����, default�� multi 
INTEGER		ii_selection = 2

//header sort : ' A' - ascending, ' D' - desending
STRING		is_sort_ad
end variables

forward prototypes
public function boolean uf_is_modified ()
public subroutine uf_set_multirow (boolean ab_value)
public function boolean uf_selection (integer ai_option)
public subroutine uf_shift_highlight (long al_aclickedrow)
public function integer uf_deleterow (long al_row)
public function integer uf_setitemstatus (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status)
public function integer uf_setitemstatus1 (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status)
public subroutine uf_setdragdrop (boolean ab_value)
public function integer uf_resetstatus ()
public function integer uf_setfocus ()
private subroutine uf_key (long al_row)
public function boolean uf_check_required ()
public function str_undo uf_undo ()
end prototypes

event ue_lbuttonup;/***********************************************************************
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

on ue_accepttext;//item�� �������� ���� ������ �ȵȻ��·� �������� ��쿡 ����ؼ�
//focus�� dw�� ������ ������ ������ item�� data�� �޾Ƶ���
this.AcceptText()
end on

event ue_key;// ȭ��ǥŰ(��,�Ʒ�)�� pageUp,PageDownŰ ó��
LONG		ll_row
LONG		ll_rowcount

ll_row = this.GetRow()
ll_rowcount = this.RowCount()
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

Return 1
end event

public function boolean uf_is_modified ();//dw�� item����(����,�߰�,����)�� �߻��Ͽ������� Ȯ��
//��ȯ TRUE  	; ������ �߻��Ͽ���
//     FALSE	; �ƹ��� ������ �Ͼ�� �ʾ���

//Validation Test�� ������� ���Ͽ����� ������ �߻��Ѱɷ� ����
IF this.AcceptText() = -1 THEN RETURN TRUE

//������ row�� ������ row�� ������ ������ row
RETURN this.Modifiedcount() > 0 OR this.Deletedcount() > 0 
end function

public subroutine uf_set_multirow (boolean ab_value);//Multi Row ����� ����Ұ��� ������
IF ab_value THEN
	ib_multiselection = TRUE
ELSE
	ib_multiselection = FALSE
END IF
end subroutine

public function boolean uf_selection (integer ai_option);///////////////////////////////////////////////////////////////
//data window���� �󸶳� ���� row�� ������ ������� ����
// as_option = 0 ; selection�� ������� ����
// 				1 ; 1���� row�� ���ؼ��� selection�� ���
// 				2 ; MultiRow Selction�� ���
///////////////////////////////////////////////////////////////

ii_selection = ai_option
CHOOSE CASE ai_option
	CASE 0		//DISC_ZERO
	CASE 1		//DISC_ONE
	CASE 2		//DISC_MULTI
END CHOOSE

RETURN TRUE
end function

public subroutine uf_shift_highlight (long al_aclickedrow);//**********************************************************************
//  ������ ���õ�(clicked) row�� ������ �� row�� ���������� ���õ� row
//  ���̸� ��� ����(highlight)��Ų��.
//  ó������ clicked�� row�� �ش� row�� highlight��Ų��
//  �μ��δ� ���� clicked�� row�� �����´�
//**********************************************************************
INTEGER	li_i

//�켱 ��� ����(highlight)�� ���ش�
this.SetRedraw(FALSE)
this.SelectRow(0,FALSE)

//������ ���õ� ror�� ������ �ش� row�� ����(highlight)
IF il_lastclickedrow = 0 THEN
	this.SelectRow(al_aclickedrow,TRUE)
	this.setredraw(true)
	RETURN
END IF

//������ ���õ� row�� ������ �ڿ��� ���� ������ ���õ� row���� ����(highlight)
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

//�ٲ���� ������ ���δ�(draw)
this.SetRedraw( TRUE )
RETURN

end subroutine

public function integer uf_deleterow (long al_row);//Datawindow�� DeleteRow()�� ��ü�� Function
//�̴� External�� ��� 
//DeleteRow Function�� ����Ͽ��� Delete buffer�� �Ѿ�� ������ �����ϱ� �����̴�
LONG		ll_old_deletedcount	//DeleteRow�� �ϱ� ������ DeletedCount
LONG		ll_new_deletedcount	//DeleteRow�� �� ������ DeletedCount
LONG		ll_old_RowCount		//DeleteRow�� �ϱ� ������ RowCount
LONG		ll_new_RowCount		//DeleteRow�� �� ������ RowCount
INTEGER	li_return

//�켱 Delete Buffer�� �ִ� row���� ���� �а� 
ll_old_deletedcount = this.DeletedCount()
IF ll_old_deletedcount < 0 THEN ll_old_deletedcount = 0

////�������� 
//li_return = this.DeleteRow(al_row)
////�ٽ� Delete Buffer�� �ִ� row���� ���� ���Ƽ�
//ll_new_deletedcount = this.DeletedCount()
//IF ll_new_deletedcount < 0 THEN ll_new_deletedcount = 0
//
//IF ll_new_deletedcount = ll_old_deletedcount + 1 THEN
//	RETURN li_return
//END IF

//����� ������� �ʾҴٸ� 
//������ Delete Buffer�� �ű�� 
li_return = this.RowsMove(al_row,al_row,primary!,&
								this,ll_old_deletedcount + 1,Delete!)
ll_new_deletedcount = this.DeletedCount()								
RETURN li_return

end function

public function integer uf_setitemstatus (long al_row, long al_column, dwbuffer abuf_buffer, dwitemstatus adws_status);////////////////////////////////////////////////////////////////////////
// uf_SetItemStatus
////////////////////////////////////////////////////////////////////////
//DataWindow�� Status�� set(NotModified!)��Ų��
//������ Function�� �ٸ����� row���� 0�� ������ datawindow��ü row�� SetStatus�ϰ� 
//buffer��  null�� ������ ��� buffer�� �ٲ۴� 
////////////////////////////////////////////////////////////////////////
LONG				ll_rowcount		//Datawindow�� �� Row
LONG				ll_i				//For..Next�� ���� Temp variable
LONG				ll_start_row	//For Next�� ������ ��ġ 
LONG				ll_end_row		//For Next�� ���� ��ġ 
INTEGER			li_return		//
DWBUFFER			lbuf_current	//3���� buffer�� ó���� ������ ó��buffer
LONG				ll_buf			//Buffer�� ���� 3�� �����ϱ� ���ؼ� (1 to 3)

//���� ���� - ���������� Status
//////////////////////////////////////////////////////////////////////////////////
//	Original status	|	New!				NewModified!	DataModified!	NotModified!
//	------------------+-----------------------------------------------------------
//	New!					|	-					Yes				Yes				No
//	NewModified!		|	No					-					Yes				New!
//	DataModified!		|	NewModified!	Yes				-					Yes
//	NotModified!		|	Yes				Yes				Yes				-
//////////////////////////////////////////////////////////////////////////////////

//3���� Buffer�� ���ؼ� ���� 
FOR ll_buf = 1 TO 3
	//BufferȮ�� 
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

	//������ �Ѿ�� 
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
//DataWindow�� Status�� set(NotModified!)��Ų��
//������ Function�� �ٸ����� row���� 0�� ������ datawindow��ü row�� SetStatus�ϰ� 
//buffer��  null�� ������ ��� buffer�� �ٲ۴� 
//�׸��� ������ ���������� Status�� ������ �־��ٸ� 
//�� fucntion�� ������ ���� 
//��� ������ ���ϴ� status�� �ٲ۴�. ����!
//���ϴ� �������� �𸥰���(�� ���� ���� ����̴� ��ιٶ�)
////////////////////////////////////////////////////////////////////////
LONG				ll_rowcount		//Datawindow�� �� Row
LONG				ll_i				//For..Next�� ���� Temp variable
LONG				ll_i_go			//�ش� For Next�� �ѹ��� �����Ұ��� �������� �Ǵ��ϱ� ����
										//�̴� ��� status�� �ٲܼ� �ְ� �ϱ������̴�
DWITEMSTATUS	ldws_status		//dw Item�� Status
LONG				ll_start_row	//For Next�� ������ ��ġ 
LONG				ll_end_row		//For Next�� ���� ��ġ 
INTEGER			li_return		//
DWBUFFER			lbuf_current	//3���� buffer�� ó���� ������ ó��buffer
LONG				ll_buf			//Buffer�� ���� 3�� �����ϱ� ���ؼ� (1 to 3)


//���� ���� - ���������� Status
//////////////////////////////////////////////////////////////////////////////////
//	Original status	|	New!				NewModified!	DataModified!	NotModified!
//	------------------+-----------------------------------------------------------
//	New!					|	-					Yes				Yes				No
//	NewModified!		|	No					-					Yes				New!
//	DataModified!		|	NewModified!	Yes				-					Yes
//	NotModified!		|	Yes				Yes				Yes				-
//////////////////////////////////////////////////////////////////////////////////

//3���� Buffer�� ���ؼ� ���� 
FOR ll_buf = 1 TO 3
	//BufferȮ�� 
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

	//������ �Ѿ�� 
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
		//�켱 ������ Status�� ������ �´� 
		ll_i_go = ll_i
		ldws_status = this.GetItemStatus(ll_i,al_column,lbuf_current)
		CHOOSE CASE ldws_status
			CASE New!
				CHOOSE CASE adws_status
					CASE NewModified!, DataModified!
						ldws_status = adws_status
					CASE NotModified!
						ldws_status = DataModified!
						ll_i_go --		//�ѹ��� ����	
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
						ll_i_go --		//�ѹ��� ����					
					CASE ELSE
						RETURN -1				
				END CHOOSE				
			CASE DataModified!
				CHOOSE CASE adws_status				
					CASE New!
						ldws_status = NotModified!
						ll_i_go --		//�ѹ��� ����							
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
		//�ٽ��ѹ� ����������
		ll_i = ll_i_go
	NEXT
NEXT

RETURN 1
end function

public subroutine uf_setdragdrop (boolean ab_value);//////////////////////////////////////////////////////////////
// Function : uf_setdragdrop
// Description : DragDrop����� Eanbled Disable ��Ų�� 
// Arguments		ab_value	TRUE  - Dragdrop Enable
//									FALSE	- Dragdrop Disable
/////////////////////////////////////////////////////////////

ib_dragdrop = ab_value
end subroutine

public function integer uf_resetstatus ();//DataWindpw�� Status�� Reset(NotModified!)��Ų��

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

private subroutine uf_key (long al_row);//Ű�� ���������� click�� ��ó�� ����
LONG		ll_ClickedRow
STRING	ls_KeyDownType

ll_clickedrow = al_row

If ll_clickedrow = 0 then RETURN

CHOOSE CASE ii_selection
	CASE 0		//DISC_ZERO
		//���ñ�� OFF
	CASE 1		//DISC_ONE
		//�ѹ��� 1���� ROW�� ����
		this.SelectRow(0,FALSE)
		this.SelectRow(ll_clickedrow,TRUE)
	CASE 2		//DISC_MULTI
		//���� ���ñ���� On�����̸�
		IF Keydown(KeyShift!) THEN
			//Shift KEY�� ����ä���̸� ���� row����
			uf_Shift_Highlight(ll_clickedrow)
		ELSEIF this.IsSelected(ll_clickedrow) THEN
			//�̹� ���õ� row�̸�
			il_LastClickedRow = ll_clickedrow
			ib_action_on_buttonup = true
		ELSEIF Keydown(KeyControl!) then
			//CTRL KEY�� ������ �����̰� �̹� ���õ� row�� �ƴ϶�� ����
			il_LastClickedRow = ll_clickedrow
			this.SelectRow(ll_clickedrow,TRUE)
		ELSE
			//�̵����� �ƹ̸� �ϳ��� ����
			il_LastClickedRow = ll_clickedrow
			this.SelectRow(0,FALSE)
			this.SelectRow(ll_clickedrow,TRUE)
		END IF
END CHOOSE
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

public function str_undo uf_undo ();STR_UNDO		lstr_rows_undid		//��ҵ�  row count�� ��ȯ����

//undo����� ���Ǿ��� ����
IF ib_undo_enabled THEN
	IF ( this.ModifiedCount() + this.DeletedCount())  = 0 THEN
		MessageBox ("�۾� ����","����(����,�߰�,����)�� row�� �ϳ��� �����ϴ�")
	ELSE
//		OpenWithParm (w_undo_r, this)
		lstr_rows_undid = message.PowerObjectParm
	END IF
END IF

RETURN lstr_rows_undid

end function

event dberror;//str_xcs_dberror	lstr_dberror
//
//lstr_dberror.ss_type = '1'
//lstr_dberror.sl_code = sqldbcode
//lstr_dberror.ss_text = sqlerrtext
//
//f_server_error_check(-1, lstr_dberror, 0, 1)
//Return 1

////////////////////////////////////////////////////
//// Datawindow���� Error�� �߻��� ó��
////////////////////////////////////////////////////

//STRING			ls_err_type		//error�߻� ����(�߰�,����, ����..)
//STRING			ls_err_msg		//������ error �޽���
//DWITEMSTATUS	stat
//
//CHOOSE CASE buffer
//	CASE delete!		//������ rowó���� error�߻��Ͽ�����
//		ls_err_type = "����"
//	CASE primary!		//������ row�� �ƴ� rowó���� error�� �߻��Ͽ�����
//		
//		//error�� �߻��� row�� �������¸� Ȯ���Ѵ�
//		stat = this.GetItemStatus(row, 0, buffer)
//		IF stat = new! OR stat = newmodified! THEN 	//�߰��� row�̸�
//			ls_err_type = "�߰�"
//		ELSE
//			ls_err_type = "����"
//		END IF
//END CHOOSE
//ls_err_msg = ls_err_type + "�� " + String(row) + "��° ������ ������ �߻��Ͽ����ϴ�"
//ls_err_msg = ls_err_msg + "~r~n DB Error ��ȣ   : " + String(sqldbcode)
//ls_err_msg = ls_err_msg + "~r~n DB Error �޽��� :~r~n~r~n" 
//
////Error Message���� => Value Display
//STRING	ls_sqlerrtext
//STRING	ls_values
//STRING	ls_new_values = "( "
//INTEGER	li_pos
//STRING	ls_column
//INTEGER	li_column
//STRING	ls_column_datatype
//STRING	ls_column_value
//
//li_pos = Pos(sqlerrtext,"VALUES")
//IF li_pos < 1 THEN
//	ls_err_msg += sqlerrtext
//ELSE
//	ls_sqlerrtext= Left( sqlerrtext, li_pos + 5)
//	ls_values = Mid(sqlerrtext,li_pos + 6 )	
//	ls_values = f_global_replace(ls_values,"(","")
//	ls_values = f_global_replace(ls_values,":","")
//	ls_values = f_global_replace(ls_values,")","")	
//	Do While ls_values <> ""
//		//�� Column�� �и��� ����
//		ls_column = Trim(f_get_token(ls_values,","))
//		li_column = Integer(ls_column)
//		IF li_column < 1 THEN EXIT
//
//		//ColumnType�� �����´� 
//		ls_column_datatype = Lower(this.Describe("#" + ls_column + ".coltype"))
//		IF Left(ls_column_datatype,4) = "char" THEN 
//			ls_column_datatype = "char"
//		END IF
//		//Get Value
//		CHOOSE CASE ls_column_datatype
//			CASE "string","char"
//				ls_column_value = Trim(this.GetItemString(row,li_column))
//				//String�� ''�� ���Ѵ�
//				IF IsNull( ls_column_value ) = FALSE THEN
//					ls_column_value = "'" + ls_column_value + "'"
//				END IF
//			CASE "date"
//				ls_column_value = String(this.GetItemDate(row,li_column))
//			CASE "datetime"
//				ls_column_value = String(this.GetItemDateTime(row,li_column))
//			CASE "time"
//				ls_column_value = String(this.GetItemTime(row,li_column))
//			CASE "number"
//				ls_column_value = String(this.GetItemNumber(row,li_column))
//			CASE "decimal"
//				ls_column_value = String(this.GetItemDecimal(row,li_column))
//		END CHOOSE
//		IF IsNull(ls_column_value) THEN
//			ls_column_value = "[null]"
//		END IF
//
//		ls_new_values += ls_column_value + " , "
//	LOOP
//	//
//	ls_new_values = Left( ls_new_values, len(ls_new_values) -1) + ")"
//	//New Error Msg
//	ls_sqlerrtext += ls_new_values
//	ls_err_msg += ls_sqlerrtext	
//END IF
//	
//WINDOW				lw_parentwindow
//GRAPHICOBJECT		lgo_this
//lgo_this = this
//lw_parentwindow = f_get_parentwindow(lgo_this)
//IF IsNull(lw_parentwindow) = TRUE THEN
//	f_error_box("Datawindow DB Error!",ls_err_msg)
//ELSE
//	f_error_box(lw_parentwindow.title,ls_err_msg)
//END IF
//
//this.SetFocus()
//this.SetRow(row)
//this.ScrollToRow(row)
//
//RETURN 1
//


end event

event clicked;// 2001.09.20
// header sorting => double clicked event�� 

IF row <= 0 THEN RETURN

IF ib_dragdrop = TRUE  THEN
	//���� drag�Ǵ� icon�� ������ ����
	THIS.dragicon = THIS.is_dragicon
	THIS.drag(BEGIN!)
END IF

THIS.SetRow(row)
CHOOSE CASE ii_selection
	CASE 0		//DISC_ZERO
		//���ñ�� OFF
	CASE 1		//DISC_ONE
		//�ѹ��� 1���� ROW�� ����
		THIS.SelectRow(0,FALSE)
		THIS.SelectRow(row,TRUE)
	CASE 2		//DISC_MULTI
		//���� ���ñ���� On�����̸�
		IF Keydown(KeyShift!) THEN
			//Shift KEY�� ����ä���̸� ���� row����
			uf_Shift_Highlight(row)
		ELSEIF THIS.IsSelected(row) THEN
			//�̹� ���õ� row�̸�
			il_LastClickedRow = row
			ib_action_on_buttonup = true
		ELSEIF Keydown(KeyControl!) then
			//CTRL KEY�� ������ �����̰� �̹� ���õ� row�� �ƴ϶�� ����
			il_LastClickedRow = row
			THIS.SelectRow(row,TRUE)
		ELSE
			//�̵����� �ƹ̸� �ϳ��� ����
			il_LastClickedRow = row
			THIS.SelectRow(0,FALSE)
			THIS.SelectRow(row,TRUE)
		END IF
END CHOOSE

end event

event getfocus;/* ��Ŀ���� ������ ���� �ڽ��� ���õǾ����� ���� */

window		lw_sheet

lw_sheet = f_get_parentwindow(THIS)
lw_sheet.TriggerEvent("ue_set_focus")
end event

on losefocus;//item�� �������� ���� ������ �ȵȻ��·� �������� ��쿡 ����ؼ�
//focus�� dw�� ������ ������ ������ item�� data�� �޾Ƶ���
this.PostEvent( "ue_accepttext" )
end on

event rowfocuschanged;/////////////////////////////////////////////////////
//Tab Key�� (Reverse Tab Key)�� �����ϱ� ���� 
IF currentrow > 0 AND KeyDown( KeyTab! ) THEN
	THIS.SetRow(currentrow)
	CHOOSE CASE ii_selection
		CASE 0		//DISC_ZERO
			//���ñ�� OFF
		CASE 1		//DISC_ONE
			//�ѹ��� 1���� ROW�� ����
			this.SelectRow(0,FALSE)
			this.SelectRow(currentrow,TRUE)
		CASE 2		//DISC_MULTI
			//���� ���ñ���� On�����̸�
			IF Keydown(KeyShift!) THEN
				//Shift KEY�� ����ä���̸� ���� row����
				uf_Shift_Highlight(currentrow)
			ELSEIF this.IsSelected(currentrow) THEN
				//�̹� ���õ� row�̸�
				il_LastClickedRow = currentrow
				ib_action_on_buttonup = true
			ELSEIF Keydown(KeyControl!) then
				//CTRL KEY�� ������ �����̰� �̹� ���õ� row�� �ƴ϶�� ����
				il_LastClickedRow = currentrow
				this.SelectRow(currentrow,TRUE)
			ELSE
				//�̵����� �ƹ̸� �ϳ��� ����
				il_LastClickedRow = currentrow
				this.SelectRow(0,FALSE)
				this.SelectRow(currentrow,TRUE)
			END IF
	END CHOOSE
END IF
/////////////////////////////////////////////////////
end event

on u_vi_std_datawindow.create
end on

on u_vi_std_datawindow.destroy
end on

event error;// after finished dw Project, Please unComment.
//action = ExceptionIgnore! 
end event

event rbuttondown;//m_basic_mdi			lm_menu
//w_basic_mdi			lw_parent
//w_basic_m			lw_sheet
//
//// Get and store the parent object.
//lw_sheet = f_get_parentwindow(This)
//
//// 2001.09.16 - �����찡 main�� ��쿡�� �޴� ����
//IF lw_sheet.WindowType = Main! THEN
//	lw_parent = lw_sheet.ParentWindow()
//	lm_menu = lw_parent.menuid
//	lm_menu.item[2].PopMenu(lw_parent.PointerX(), lw_parent.PointerY())
//ELSE
//	Return
//END IF	
end event

event itemerror;// 2001.09.20
// validation error ���� ó��
Return 1
end event

event doubleclicked;
STRING		ls_object, ls_header
INT			li_tab, li_row
BOOLEAN		lb_sort = False

// 2001.09.20
// header sort => clicked event���� �̵�

IF left(This.GetBandAtPointer(), 6) = 'header' THEN
	SetPointer(HourGlass!)
	
	ls_object = This.GetObjectAtpointer()

	IF Len(ls_object) = 0 THEN Return 	// Grid type���� header���� ������ ������ó��
	
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
	// _s, _s_f �� ��쿡�� sort
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
		This.GroupCalc()				// 2001.09.24 - sort�� groupcalc
		This.SetRedraw(True)
		
		// 2001.09.20 
		// sort�� focus�� row�� scroll
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

