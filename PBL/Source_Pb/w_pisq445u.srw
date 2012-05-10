$PBExportHeader$w_pisq445u.srw
$PBExportComments$RRPPM ��ǥ�� ���
forward
global type w_pisq445u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq445u
end type
type uo_division from u_pisc_select_division within w_pisq445u
end type
type dw_pisq445u_01 from u_vi_std_datawindow within w_pisq445u
end type
type st_2 from statictext within w_pisq445u
end type
type sle_date from singlelineedit within w_pisq445u
end type
type dw_pisq445u_03 from u_vi_std_datawindow within w_pisq445u
end type
type dw_pisq445u_04 from u_vi_std_datawindow within w_pisq445u
end type
type cb_1 from commandbutton within w_pisq445u
end type
type cb_2 from commandbutton within w_pisq445u
end type
type gb_2 from groupbox within w_pisq445u
end type
type gb_3 from groupbox within w_pisq445u
end type
end forward

global type w_pisq445u from w_ipis_sheet01
integer width = 4709
integer height = 2700
string title = "RRPPM ��ǥ�� ���"
uo_area uo_area
uo_division uo_division
dw_pisq445u_01 dw_pisq445u_01
st_2 st_2
sle_date sle_date
dw_pisq445u_03 dw_pisq445u_03
dw_pisq445u_04 dw_pisq445u_04
cb_1 cb_1
cb_2 cb_2
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq445u w_pisq445u

type variables

String	is_AreaCode, is_DivisionCode
Long		il_selectcnt

end variables

forward prototypes
public subroutine wf_newinsert (string as_customercode)
public function boolean wf_checkcolumn ()
public subroutine wf_update (string as_customercode)
end prototypes

public subroutine wf_newinsert (string as_customercode);
Int		li_row
String	ls_date, ls_productgroup, ls_customercode
dec		ld_qty1, ld_qty2, ld_qty3, ld_qty4 , ld_qty5 , ld_qty6
dec		ld_qty7, ld_qty8, ld_qty9, ld_qty10, ld_qty11, ld_qty12, ld_qtyyeargoal
dec		ld_amount1, ld_amount2, ld_amount3, ld_amount4, ld_amount5, ld_amount6
dec		ld_amount7, ld_amount8, ld_amount9, ld_amount10, ld_amount11, ld_amount12, ld_amountyeargoal

ls_date = sle_date.Text
ls_customercode = as_customercode
//ls_customercode = dw_pisq445u_04.GetItemString(dw_pisq445u_04.GetSelectedRow(0), 'custcode')

// AUTO COMMIT�� FASLE�� ����
//
//SQLEIS.AUTOCommit = FALSE

// ��ü�� �ڷḸŭ LOOPó���� �ϸ鼭 �ڷḦ �μ�Ʈ�Ѵ� 
//
FOR li_row = 1 TO dw_pisq445u_01.RowCount()
	ls_productgroup= dw_pisq445u_01.GetItemString(li_row, 'tmstproductgroup_productgroup')
	ld_qty1			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty1')
	ld_qty2			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty2')
	ld_qty3			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty3')
	ld_qty4 			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty4')
	ld_qty5 			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty5')
	ld_qty6			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty6')
	ld_qty7			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty7')
	ld_qty8			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty8')
	ld_qty9			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty9')
	ld_qty10			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty10')
	ld_qty11			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty11')
	ld_qty12			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty12')
	ld_qtyyeargoal	= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qtyyeargoal')
	ld_amount1		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount1')
	ld_amount2		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount2')
	ld_amount3		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount3')
	ld_amount4		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount4')
	ld_amount5		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount5')
	ld_amount6		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount6')
	ld_amount7		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount7')
	ld_amount8		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount8')
	ld_amount9		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount9')
	ld_amount10		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount10')
	ld_amount11		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount11')
	ld_amount12		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount12')
	ld_amountyeargoal		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amountyeargoal')

	INSERT INTO tqrrppmgoalreject  
			 ( AREACODE, DIVISIONCODE, STANDARDYEAR, CUSTOMERCODE, PRODUCTGROUP,   
            qty1, qty2, qty3, qty4 , qty5 , qty6, 
				qty7, qty8, qty9, qty10, qty11, qty12, QTYYEARGOAL ,
				amount1, amount2, amount3, amount4, amount5, amount6,
				amount7, amount8, amount9, amount10, amount11, amount12, amountyeargoal)
   VALUES ( :is_areacode, :is_divisioncode, :ls_date, :ls_customercode, :ls_productgroup,
				:ld_qty1, :ld_qty2, :ld_qty3, :ld_qty4 , :ld_qty5 , :ld_qty6,
				:ld_qty7, :ld_qty8, :ld_qty9, :ld_qty10, :ld_qty11, :ld_qty12, :ld_qtyyeargoal,
				:ld_amount1, :ld_amount2, :ld_amount3, :ld_amount4, :ld_amount5, :ld_amount6,
				:ld_amount7, :ld_amount8, :ld_amount9, :ld_amount10, :ld_amount11, :ld_amount12, :ld_amountyeargoal)
	 USING SQLEIS;

	IF SQLEIS.SQLCode <> 0 THEN
		EXIT
	END IF
NEXT

//IF SQLEIS.SQLCode = 0 THEN
//	// Commit ó��
//	//
//	COMMIT USING SQLEIS;
////	SQLPIS.AUTOCommit = TRUE
//ELSE 
//	// RollBack ó��
//	//
//	RollBack using SQLEIS ;
////	SQLPIS.AUTOCommit = TRUE
//	MessageBox('Ȯ ��', 'RRPPM ��ǥ�ҷ��� �Է� ó���� �����߽��ϴ�')
//END IF


end subroutine

public function boolean wf_checkcolumn ();
Int		li_row
Boolean	lb_rtn = TRUE

IF dw_pisq445u_01.AcceptText() <> 1 THEN RETURN FALSE

// ��ü�� �ڷḦ üũ�Ѵ�
//
FOR li_row = 1 TO dw_pisq445u_01.RowCount()
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month1') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month1')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 1�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month1')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month2') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month2')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 2�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month2')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month3') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month3')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 3�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month3')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month4') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month4')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 4�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month4')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month5') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month5')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 5�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month5')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month6') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month6')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 6�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month6')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month7') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month7')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 7�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month7')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month8') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month8')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 8�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month8')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month9') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month9')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 9�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month9')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month10') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month10')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 10�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month10')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month11') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month11')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 11�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month11')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_month12') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_month12')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� 12�� �ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_month12')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq445u_01.GetItemNumber(li_row, 'as_yeargoal') = 0 OR &
		IsNull(dw_pisq445u_01.GetItemNumber(li_row, 'as_yeargoal')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� ���ǥ�ҷ����� �Է��ϼ���', StopSign!)
		dw_pisq445u_01.SetColumn('as_yeargoal')
		lb_rtn = FALSE
		EXIT
	END IF
NEXT

dw_pisq445u_01.ScrollToRow(li_row)
f_SetHighlight(dw_pisq445u_01, li_row, True)	
dw_pisq445u_01.SetFocus()

RETURN lb_rtn

end function

public subroutine wf_update (string as_customercode);
Int		li_row
String	ls_date, ls_productgroup, ls_customercode
dec		ld_qty1, ld_qty2, ld_qty3, ld_qty4 , ld_qty5 , ld_qty6
dec		ld_qty7, ld_qty8, ld_qty9, ld_qty10, ld_qty11, ld_qty12, ld_qtyyeargoal
dec		ld_amount1, ld_amount2, ld_amount3, ld_amount4, ld_amount5, ld_amount6
dec		ld_amount7, ld_amount8, ld_amount9, ld_amount10, ld_amount11, ld_amount12, ld_amountyeargoal

ls_date = sle_date.Text
ls_customercode = as_customercode 
//ls_customercode = dw_pisq445u_04.GetItemString(dw_pisq445u_04.GetSelectedRow(0), 'custcode')

// AUTO COMMIT�� FASLE�� ����
//
//SQLEIS.AUTOCommit = FALSE

// ��ü�� �ڷḸŭ LOOPó���� �ϸ鼭 �ڷḦ �μ�Ʈ�Ѵ� 
//
FOR li_row = 1 TO dw_pisq445u_01.RowCount()
	ls_productgroup= dw_pisq445u_01.GetItemString(li_row, 'tmstproductgroup_productgroup')
	ld_qty1			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty1')
	ld_qty2			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty2')
	ld_qty3			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty3')
	ld_qty4 			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty4')
	ld_qty5 			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty5')
	ld_qty6			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty6')
	ld_qty7			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty7')
	ld_qty8			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty8')
	ld_qty9			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty9')
	ld_qty10			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty10')
	ld_qty11			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty11')
	ld_qty12			= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qty12')
	ld_qtyyeargoal	= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_qtyyeargoal')
	ld_amount1		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount1')
	ld_amount2		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount2')
	ld_amount3		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount3')
	ld_amount4		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount4')
	ld_amount5		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount5')
	ld_amount6		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount6')
	ld_amount7		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount7')
	ld_amount8		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount8')
	ld_amount9		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount9')
	ld_amount10		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount10')
	ld_amount11		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount11')
	ld_amount12		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amount12')
	ld_amountyeargoal		= dw_pisq445u_01.GetItemNumber(li_row, 'tqrrppmgoalreject_amountyeargoal')

	UPDATE tqrrppmgoalreject  
	   SET qty1					= :ld_qty1,
			 qty2					= :ld_qty2,
			 qty3					= :ld_qty3,
			 qty4					= :ld_qty4,
			 qty5					= :ld_qty5,
			 qty6					= :ld_qty6,
			 qty7					= :ld_qty7,
			 qty8					= :ld_qty8,
			 qty9					= :ld_qty9,
			 qty10				= :ld_qty10,
			 qty11				= :ld_qty11,
			 qty12				= :ld_qty12,
			 QTYYEARGOAL		= :ld_qtyyeargoal,
			 amount1				= :ld_amount1,
			 amount2				= :ld_amount2,
			 amount3				= :ld_amount3,
			 amount4				= :ld_amount4,
			 amount5				= :ld_amount5,
			 amount6				= :ld_amount6,
			 amount7				= :ld_amount7,
			 amount8				= :ld_amount8,
			 amount9				= :ld_amount9,
			 amount10			= :ld_amount10,
			 amount11			= :ld_amount11,
			 amount12			= :ld_amount12,
			 amountyeargoal	= :ld_amountyeargoal
    WHERE AREACODE		= :is_areacode
	   AND DIVISIONCODE	= :is_divisioncode
	   AND STANDARDYEAR	= :ls_date
	   AND CUSTOMERCODE	= :ls_customercode
	   AND PRODUCTGROUP	= :ls_productgroup
	 USING SQLEIS;

	IF SQLEIS.SQLCode <> 0 THEN
		EXIT
	END IF
NEXT

//IF SQLEIS.SQLCode = 0 THEN
//	// Commit ó��
//	//
//	COMMIT USING SQLEIS;
////	SQLPIS.AUTOCommit = TRUE
//ELSE 
//	// RollBack ó��
//	//
//	RollBack using SQLEIS ;
////	SQLPIS.AUTOCommit = TRUE
//	MessageBox('Ȯ ��', 'RRPPM ��ǥ�ҷ��� ���� ó���� �����߽��ϴ�')
//END IF
//

end subroutine

on w_pisq445u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq445u_01=create dw_pisq445u_01
this.st_2=create st_2
this.sle_date=create sle_date
this.dw_pisq445u_03=create dw_pisq445u_03
this.dw_pisq445u_04=create dw_pisq445u_04
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq445u_01
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_date
this.Control[iCurrent+6]=this.dw_pisq445u_03
this.Control[iCurrent+7]=this.dw_pisq445u_04
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
end on

on w_pisq445u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq445u_01)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.dw_pisq445u_03)
destroy(this.dw_pisq445u_04)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq080i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_date, ls_customercode
Long		ll_insrow

dw_pisq445u_04.AcceptText()

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_date				= sle_date.Text
ls_customercode	= dw_pisq445u_04.GetItemString(dw_pisq445u_04.GetSelectedRow(0), 'custcode')

IF f_checknullorspace(ls_date) = TRUE THEN
	MessageBox('Ȯ ��', '���س⵵�� �Է��� ��ȸ�ϼ���', StopSign!)
	sle_date.SetFocus()
	RETURN
END IF

// �ű԰����� ���������� Ȯ���Ѵ�(�ű�/�����ǿ� ���� ó������� Ʋ���⶧��)
//
il_selectcnt = 0
SELECT count(*)
  INTO :il_selectcnt
  FROM TQRRPPMGOALREJECT  A
 WHERE A.AREACODE			= :is_AreaCode
   AND A.DIVISIONCODE	= :is_DivisionCode
   AND A.STANDARDYEAR	= :ls_date
   AND A.CUSTOMERCODE	= :ls_customercode
 USING SQLEIS;

IF il_selectcnt = 0 THEN
	// �ű԰�
	//
	dw_pisq445u_01.dataobject = 'd_pisq445u_01'
ELSE
	// ������
	//
	dw_pisq445u_01.dataobject = 'd_pisq445u_02'
END IF

dw_pisq445u_01.SetTransObject(SQLEIS)
dw_pisq445u_01.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_customercode)

// �ű԰��϶��� ��Ż�Է¶��� �������� ������ش�
//
IF il_selectcnt = 0 THEN
	// �ű԰�
	//
	ll_insrow = dw_pisq445u_01.InsertRow(0)
	dw_pisq445u_01.SetItem(ll_insrow, 'tmstproductgroup_productgroup', 'ZZ')
	dw_pisq445u_01.SetItem(ll_insrow, 'tmstproductgroup_productgroupname', 'TOTAL')
ELSE
	dw_pisq445u_01.SetItem(dw_pisq445u_01.RowCount(), 'tmstproductgroup_productgroup', 'ZZ')
	dw_pisq445u_01.SetItem(dw_pisq445u_01.RowCount(), 'tmstproductgroup_productgroupname', 'TOTAL')
END IF

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq445u_01, 1, True)	

end event

event ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq445u_01.SetTransObject(SQLEIS)
dw_pisq445u_03.SetTransObject(SQLEIS)
dw_pisq445u_04.SetTransObject(SQLEIS)

sle_date.Text = String(f_getsysdatetime(), 'yyyy')

dw_pisq445u_03.Retrieve('SCUSTGUBUN')
f_SetHighlight(dw_pisq445u_03, 1, True)	

end event

event ue_save;call super::ue_save;
Int	li_save

// �ڷ� ��ȸ�� ���س� �ν��Ͻ� ������ ������ �ű�/������ �Ǵ��� �Ѵ�
//
IF il_selectcnt = 0 THEN								// �ű԰��� SQL�� ó���Ѵ�
	SQLEIS.AUTOCommit = FALSE
	// �ű԰�
	//
	wf_newinsert(dw_pisq445u_04.GetItemString(dw_pisq445u_04.GetSelectedRow(0), 'custcode'))
	This.TriggerEvent('ue_retrieve')
	SQLEIS.AUTOCommit = TRUE
	RETURN
END IF

// �������� �Ŀ������� UPDATE�Լ��� �̿��Ͽ� ó���Ѵ� 
//
// AUTO COMMIT�� FASLE�� ����
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq445u_01.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF


end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

// Ʈ������� �����Ѵ�
//
dw_pisq445u_01.SetTransObject(SQLEIS)

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq445u
integer x = 18
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq445u
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_empno					��ȸ�ϰ��� �ϴ� ��� (������/���庰 ���ѿ� ���� ��ȸ�� ���Ͽ�)
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ���� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�����ڵ�� '%', ������� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_divisioncode		���õ� ���� �ڵ� (reference)
//						string			rs_divisionname		���õ� ���� �� (reference)
//						string			rs_divisionnameeng	���õ� ���� ���� �� (reference)
//	Returns		: none
//	Description	: ������ �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// Ʈ������� �����Ѵ�
//
dw_pisq445u_01.SetTransObject(SQLEIS)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq445u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
// Ʈ������� �����Ѵ�
//
dw_pisq445u_01.SetTransObject(SQLEIS)

end event

type dw_pisq445u_01 from u_vi_std_datawindow within w_pisq445u
integer x = 41
integer y = 1148
integer width = 4562
integer height = 1404
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq445u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisq445u
integer x = 1211
integer y = 72
integer width = 302
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���س⵵:"
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_pisq445u
integer x = 1513
integer y = 60
integer width = 233
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type dw_pisq445u_03 from u_vi_std_datawindow within w_pisq445u
integer x = 41
integer y = 216
integer width = 1230
integer height = 916
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq445u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
String	ls_custgubun

ls_custgubun = This.GetItemString(currentrow, 'codeid')

dw_pisq445u_04.Retrieve(ls_custgubun)
f_SetHighlight(dw_pisq445u_04, 1, True)	

end event

event clicked;call super::clicked;
//This.TriggerEvent(RowFocusChanged!)

end event

type dw_pisq445u_04 from u_vi_std_datawindow within w_pisq445u
integer x = 1614
integer y = 216
integer width = 1710
integer height = 916
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_pisq445u_04"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
Parent.TriggerEvent('ue_retrieve')

end event

type cb_1 from commandbutton within w_pisq445u
integer x = 1298
integer y = 1028
integer width = 293
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��  ��"
end type

event clicked;
long		ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long		ll_SaveRow[], ll_selectcnt
String	ls_date, ls_customercode, ls_custgubun

SetPointer(HourGlass!)

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_pisq445u_03.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq445u_03.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

ls_date	= sle_date.Text

SQLEIS.AUTOCommit = FALSE

// ���õ� �ุŭ ó���� �Ѵ�
//
FOR ll_row = 1 TO ll_index -  1
	f_SetHighlight(dw_pisq445u_03, ll_SaveRow[ll_row], True)	
	ls_custgubun = dw_pisq445u_03.GetItemString(ll_SaveRow[ll_row], 'codeid')

	// Ŀ������
	//
	DECLARE CUST_CURS CURSOR FOR
	 SELECT CUSTCODE
		FROM TMSTCUSTOMER  
	  WHERE CUSTGUBUN = :ls_custgubun
	  USING SQLEIS;	
		
	// Ŀ������
	//
	OPEN CUST_CURS ;	

	DO WHILE SQLEIS.SQLCode = 0
		// DATA FETCH
		//
		FETCH CUST_CURS INTO :ls_customercode;	

		// ������ �ѹ� �� �帣�°��� ����
		//
		IF SQLEIS.SQLCode <> 0 THEN 
			EXIT
		END IF

		// �ű԰����� ���������� Ȯ���Ѵ�(�ű�/�����ǿ� ���� ó������� Ʋ���⶧��)
		//
		ll_selectcnt = 0
		SELECT count(*)
		  INTO :ll_selectcnt
		  FROM TQRRPPMGOALREJECT  A
		 WHERE A.AREACODE			= :is_AreaCode
			AND A.DIVISIONCODE	= :is_DivisionCode
			AND A.STANDARDYEAR	= :ls_date
			AND A.CUSTOMERCODE	= :ls_customercode
		 USING SQLEIS;
		
		IF ll_selectcnt = 0 THEN
			// �ű԰�
			//
			wf_newinsert(ls_customercode)
		ELSE
			// ������
			//
			wf_update(ls_customercode)
		END IF

		SQLEIS.SQLCode = 0
	LOOP

	// Ŀ��ũ����
	//
	CLOSE CUST_CURS ;	
NEXT

//	COMMIT USING SQLEIS;

SQLEIS.AUTOCommit = TRUE

SetPointer(Arrow!)

end event

type cb_2 from commandbutton within w_pisq445u
integer x = 3351
integer y = 1028
integer width = 293
integer height = 108
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��  ��"
end type

event clicked;
long		ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long		ll_SaveRow[], ll_selectcnt
String	ls_date, ls_customercode

SetPointer(HourGlass!)

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_pisq445u_04.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq445u_04.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

ls_date	= sle_date.Text

SQLEIS.AUTOCommit = FALSE

// ���õ� �ุŭ ó���� �Ѵ�
//
FOR ll_row = 1 TO ll_index -  1
	f_SetHighlight(dw_pisq445u_04, ll_SaveRow[ll_row], True)	
	ls_customercode = dw_pisq445u_04.GetItemString(ll_SaveRow[ll_row], 'custcode')
	// �ű԰����� ���������� Ȯ���Ѵ�(�ű�/�����ǿ� ���� ó������� Ʋ���⶧��)
	//
	ll_selectcnt = 0
	SELECT count(*)
	  INTO :ll_selectcnt
	  FROM TQRRPPMGOALREJECT  A
	 WHERE A.AREACODE			= :is_AreaCode
		AND A.DIVISIONCODE	= :is_DivisionCode
		AND A.STANDARDYEAR	= :ls_date
		AND A.CUSTOMERCODE	= :ls_customercode
	 USING SQLEIS;
	
	IF ll_selectcnt = 0 THEN
		// �ű԰�
		//
		wf_newinsert(dw_pisq445u_04.GetItemString(dw_pisq445u_04.GetSelectedRow(0), 'custcode'))
	ELSE
		// ������
		//
		wf_update(dw_pisq445u_04.GetItemString(dw_pisq445u_04.GetSelectedRow(0), 'custcode'))
	END IF
NEXT

SQLEIS.AUTOCommit = TRUE

SetPointer(Arrow!)

end event

type gb_2 from groupbox within w_pisq445u
integer x = 18
integer y = 188
integer width = 4613
integer height = 2384
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisq445u
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
integer taborder = 100
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

