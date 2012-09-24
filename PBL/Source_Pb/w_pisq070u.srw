$PBExportHeader$w_pisq070u.srw
$PBExportComments$���԰˻� ���˻�ǰ ���
forward
global type w_pisq070u from w_ipis_sheet01
end type
type dw_pisq070u_left from u_vi_std_datawindow within w_pisq070u
end type
type dw_pisq070u_right from u_vi_std_datawindow within w_pisq070u
end type
type pb_move from picturebutton within w_pisq070u
end type
type pb_del from picturebutton within w_pisq070u
end type
type uo_area from u_pisc_select_area within w_pisq070u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq070u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq070u
end type
type uo_division from u_pisc_select_division within w_pisq070u
end type
type st_2 from statictext within w_pisq070u
end type
type st_3 from statictext within w_pisq070u
end type
type rb_a from radiobutton within w_pisq070u
end type
type rb_b from radiobutton within w_pisq070u
end type
type rb_c from radiobutton within w_pisq070u
end type
type rb_all from radiobutton within w_pisq070u
end type
type st_leftcnt from statictext within w_pisq070u
end type
type st_rightcnt from statictext within w_pisq070u
end type
type dw_print from datawindow within w_pisq070u
end type
type dw_print1 from datawindow within w_pisq070u
end type
type rb_d from radiobutton within w_pisq070u
end type
type dw_interface from datawindow within w_pisq070u
end type
type gb_1 from groupbox within w_pisq070u
end type
type gb_2 from groupbox within w_pisq070u
end type
end forward

global type w_pisq070u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "���԰˻� ���˻�ǰ ���"
dw_pisq070u_left dw_pisq070u_left
dw_pisq070u_right dw_pisq070u_right
pb_move pb_move
pb_del pb_del
uo_area uo_area
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
uo_division uo_division
st_2 st_2
st_3 st_3
rb_a rb_a
rb_b rb_b
rb_c rb_c
rb_all rb_all
st_leftcnt st_leftcnt
st_rightcnt st_rightcnt
dw_print dw_print
dw_print1 dw_print1
rb_d rb_d
dw_interface dw_interface
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq070u w_pisq070u

type variables

Boolean	ib_open

end variables

on w_pisq070u.create
int iCurrent
call super::create
this.dw_pisq070u_left=create dw_pisq070u_left
this.dw_pisq070u_right=create dw_pisq070u_right
this.pb_move=create pb_move
this.pb_del=create pb_del
this.uo_area=create uo_area
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.uo_division=create uo_division
this.st_2=create st_2
this.st_3=create st_3
this.rb_a=create rb_a
this.rb_b=create rb_b
this.rb_c=create rb_c
this.rb_all=create rb_all
this.st_leftcnt=create st_leftcnt
this.st_rightcnt=create st_rightcnt
this.dw_print=create dw_print
this.dw_print1=create dw_print1
this.rb_d=create rb_d
this.dw_interface=create dw_interface
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq070u_left
this.Control[iCurrent+2]=this.dw_pisq070u_right
this.Control[iCurrent+3]=this.pb_move
this.Control[iCurrent+4]=this.pb_del
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_productgroup
this.Control[iCurrent+7]=this.uo_modelgroup
this.Control[iCurrent+8]=this.uo_division
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.rb_a
this.Control[iCurrent+12]=this.rb_b
this.Control[iCurrent+13]=this.rb_c
this.Control[iCurrent+14]=this.rb_all
this.Control[iCurrent+15]=this.st_leftcnt
this.Control[iCurrent+16]=this.st_rightcnt
this.Control[iCurrent+17]=this.dw_print
this.Control[iCurrent+18]=this.dw_print1
this.Control[iCurrent+19]=this.rb_d
this.Control[iCurrent+20]=this.dw_interface
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
end on

on w_pisq070u.destroy
call super::destroy
destroy(this.dw_pisq070u_left)
destroy(this.dw_pisq070u_right)
destroy(this.pb_move)
destroy(this.pb_del)
destroy(this.uo_area)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_a)
destroy(this.rb_b)
destroy(this.rb_c)
destroy(this.rb_all)
destroy(this.st_leftcnt)
destroy(this.st_rightcnt)
destroy(this.dw_print)
destroy(this.dw_print1)
destroy(this.rb_d)
destroy(this.dw_interface)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq020i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_qcgubun

// ��ȸ������ ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 

dw_interface.reset()

IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

IF rb_a.Checked = TRUE THEN
	ls_qcgubun = 'A'
END IF

IF rb_b.Checked = TRUE THEN
	ls_qcgubun = 'B'
END IF

IF rb_c.Checked = TRUE THEN
	ls_qcgubun = 'C'
END IF

IF rb_d.Checked = TRUE THEN
	ls_qcgubun = 'D'
END IF

IF rb_all.Checked = TRUE THEN
	ls_qcgubun = '%'
END IF

dw_pisq070u_left.ReSet()
dw_pisq070u_right.ReSet()

// ����Ÿ�� ��ȸ�Ѵ�(����ȭ��)
//
dw_pisq070u_left.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// ����Ÿ�� ��ȸ�Ѵ�(����ȭ��)
//
dw_pisq070u_right.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_qcgubun)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq070u_left, 1, True)	
f_SetHighlight(dw_pisq070u_right, 1, True)	


end event

event ue_postopen;
// ������ ��ȸ�� ������ ����� ��ưó�� �Ұ�
//
pb_move.Enabled	= m_frame.m_action.m_save.Enabled
pb_del.Enabled		= m_frame.m_action.m_save.Enabled

// Ʈ������� �����Ѵ�
//
dw_pisq070u_left.SetTransObject(SQLPIS)
dw_pisq070u_right.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)

f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										'%', &
										True, &
										uo_modelgroup.is_uo_modelgroup, &
										uo_modelgroup.is_uo_modelgroupname)
ib_open = True

end event

event ue_save;Long		ll_save, ll_row
String	ls_applydatefrom, ls_applydateto
dwItemStatus l_status

// ����ǰ���� ��ü�� üũ�Ѵ�
//
FOR ll_row = 1 TO dw_pisq070u_right.RowCount()
	ls_applydatefrom	= dw_pisq070u_right.GetItemString(ll_row, 'APPLYDATEFROM')
	ls_applydateto		= dw_pisq070u_right.GetItemString(ll_row, 'APPLYDATETO')
	l_status 			= dw_pisq070u_right.GetItemStatus(ll_row, 'APPLYDATEFROM', primary!)

	// ������ Į���� ���¸� üũ�Ѵ�(�űԳ� ������ ���ڸ��� üũ�Ѵ�)
	//	New!              Rows
	//	NewModified!      Rows
	//	NotModified!      Rows and columns
	//	DataModified!     Rows and columns
	//
	IF l_status <> NotModified! THEN
		IF Date(ls_applydatefrom) <= Date(f_getsysdatetime()) THEN
			MessageBox('Ȯ ��', '�������ڴ� �۾��Ϻ��� Ŀ���մϴ�')
			dw_pisq070u_right.SetColumn('APPLYDATEFROM')
			dw_pisq070u_right.SetFocus()
			f_SetHighlight(dw_pisq070u_right, ll_row, True)	
			RETURN 
		END IF
	END IF
	
	IF f_checknullorspace(ls_applydateto) = TRUE THEN
		dw_pisq070u_right.SetItem(ll_row, 'APPLYDATETO'		, '2999.12.31')
	END IF
NEXT

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

ll_save = dw_pisq070u_right.Update()

IF ll_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
This.TriggerEvent('ue_retrieve')

end event

event activate;call super::activate;
dw_pisq070u_left.SetTransObject(SQLPIS)
dw_pisq070u_right.SetTransObject(SQLPIS)

end event

event ue_print;call super::ue_print;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint
long		ll_rtn

// �۾������ ������ ó���� ���� �ʴ´�
//
IF dw_pisq070u_right.RowCount() = 0 THEN
	MessageBox('Ȯ ��', '��´���� �����ϴ�', StopSign!)
	RETURN
END IF

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ll_rtn = MessageBox('Ȯ ��', '��´���� ������ �ּ���.~r~n ��(Y)�� ����ǰ�� ���, �ƴϿ�(N)�� ���˻�ǰ ����Դϴ�', &
							Exclamation!, YesNo!, 1)

IF ll_rtn = 1 THEN
	dw_pisq070u_right.ShareData(dw_print)
	lstr_prt.datawindow	= 	dw_print
ELSE
	dw_pisq070u_left.ShareData(dw_print1)
	lstr_prt.datawindow	= 	dw_print1
END IF

ls_trans	= SQLPIS

// �μ� DataWindow ����
//
lstr_prt.transaction	=	ls_trans
//lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"���԰˻� ����ǰ�� ��Ȳ ���"
lstr_prt.tag			= 	This.ClassName()
//lstr_prt.dwsyntax = "t_3.text   	= '" + ls_DeliveryNo + "'"

f_close_report("2", lstr_prt.title)						// Open�� ���Window �ݱ�
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq070u
integer x = 18
integer y = 2592
integer width = 3598
end type

type dw_pisq070u_left from u_vi_std_datawindow within w_pisq070u
integer x = 41
integer y = 296
integer width = 1545
integer height = 2256
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq070u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;
st_leftcnt.Text = String(rowcount, '#,###')
end event

type dw_pisq070u_right from u_vi_std_datawindow within w_pisq070u
integer x = 1883
integer y = 296
integer width = 2720
integer height = 2256
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq070u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;

String	ls_colname, ls_coldata

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��������
	//
	CASE "applydatefrom"
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('Ȯ ��', '�������ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01', StopSign!)
			RETURN 1
		END IF	
		
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('Ȯ ��', '�������ڸ� ��Ȯ�� �Է��Ͻÿ�')
			RETURN 1
		END IF

		IF Date(ls_coldata) <= Date(f_getsysdatetime()) THEN
			MessageBox('Ȯ ��', '�������ڴ� �۾��Ϻ��� Ŀ���մϴ�')
			RETURN 1
		END IF
			
	// ��������
	//
	CASE "applydateto"
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('Ȯ ��', '�������ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01', StopSign!)
			RETURN 1
		END IF	

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('Ȯ ��', '�������ڸ� ��Ȯ�� �Է��Ͻÿ�')
			RETURN 1
		END IF
END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event retrieveend;call super::retrieveend;
st_rightcnt.Text = String(rowcount, '#,###')
end event

type pb_move from picturebutton within w_pisq070u
integer x = 1605
integer y = 672
integer width = 261
integer height = 188
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\userright.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row, ll_currow
long	ll_SaveRow[] 

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_pisq070u_left.GetSelectedRow(0)
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
		ll_row = dw_pisq070u_left.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ����ȭ���� ���õ� �ڷḦ ����ȭ������ �̵��Ѵ�
// 
FOR ll_row = 1 TO ll_index - 1
	// ����ȭ�鿡 ���྿�� ����鼭 ����ȭ���� �ڷḦ ����ȭ�鿡 ��Ʈ�Ѵ�
	//
	ll_LastRow = dw_pisq070u_right.InsertRow(0)
	dw_pisq070u_right.SetItem(ll_LastRow, 'AREACODE'			, dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'DIVISIONCODE'		, dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'PRODUCTGROUP'		, dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'AS_PRODUCTGROUP'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'MODELGROUP'			, dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'AS_MODELGROUP'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'ITEMCODE'			, dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'ITEMCODE'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'TMSTITEM_ITEMNAME', dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'ITEMNAME'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'SUPPLIERCODE'		, dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'SUPPLIERCODE'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'TMSTSUPPLIER_SUPPLIERKORNAME'	, &
																				  dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'SUPPLIERKORNAME'))
	dw_pisq070u_right.SetItem(ll_LastRow, 'QCGUBUN'				, 'C')
	// �������ڴ� ������ + 1��(�۾��� ���Ϻ��� ����)
	//
	dw_pisq070u_right.SetItem(ll_LastRow, 'APPLYDATEFROM'		, &
	String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
	//	dw_pisq070u_right.SetItem(ll_LastRow, 'APPLYDATETO'		, '2999.12.31')
	// �ǽð� �������̽� �߰�
//	ll_currow = dw_interface.insertrow(0)
//	dw_interface.setitem(ll_currow,"logid",ll_currow)
//	dw_interface.setitem(ll_currow,"areacode",dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
//	dw_interface.setitem(ll_currow,"divisioncode",dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
//	dw_interface.setitem(ll_currow,"itemcode",dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'ITEMCODE'))
//	dw_interface.setitem(ll_currow,"suppliercode",dw_pisq070u_left.GetitemString(ll_SaveRow[ll_row], 'SUPPLIERCODE'))
//	dw_interface.setitem(ll_currow,"applydatefrom",String(RelativeDate(Date(String(f_getsysdatetime(), 'yyyy.mm.dd')), 1), 'yyyy.mm.dd') )
//	dw_interface.setitem(ll_currow,"applydateto",'2999.12.31')
//	dw_interface.setitem(ll_currow,"recstatus",'C')
//	dw_interface.setitem(ll_currow,"qcgubun",'C')
//	dw_interface.setitem(ll_currow,"lastemp",g_s_empno)
//	dw_interface.setitem(ll_currow,"lastdate",datetime(date(string(g_s_date,"@@@@-@@-@@")),time(g_s_time)))

	// ����ȭ���� ���õ��࿡ ����ǥ�ø� ��Ʈ�Ѵ�
	//
	dw_pisq070u_left.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq070u_left.GetSelectedRow(0)

// �̵��� ���� ����ȭ���� �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_pisq070u_left.RowCount() to 1 step -1
	IF dw_pisq070u_left.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq070u_left.DeleteRow(ll_row)
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq070u_left.RowCount() THEN
	f_SetHighlight(dw_pisq070u_left, dw_pisq070u_left.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq070u_left, ll_select_row, True)	
END IF

f_sethighlight(dw_pisq070u_right,dw_pisq070u_right.RowCount(),TRUE)


end event

type pb_del from picturebutton within w_pisq070u
integer x = 1605
integer y = 1064
integer width = 261
integer height = 188
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\userleft.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row, ll_currow 
long	ll_SaveRow[] 

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_pisq070u_right.GetSelectedRow(0)
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
		ll_row = dw_pisq070u_right.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ������ȭ���� ���õ��࿡ ����ǥ�ø� ��Ʈ�Ѵ�
//
FOR ll_row = 1 TO ll_index - 1
	dw_pisq070u_right.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq070u_right.GetSelectedRow(0)

// �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_pisq070u_right.RowCount() to 1 step -1
	IF dw_pisq070u_right.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		
//		ll_currow = dw_interface.insertrow(0)
//		dw_interface.setitem(ll_currow,"logid",ll_currow)
//		dw_interface.setitem(ll_currow,"areacode",dw_pisq070u_right.GetItemString(ll_row, 'areacode'))
//		dw_interface.setitem(ll_currow,"divisioncode",dw_pisq070u_right.GetItemString(ll_row, 'divisioncode'))
//		dw_interface.setitem(ll_currow,"itemcode",dw_pisq070u_right.GetItemString(ll_row, 'itemcode'))
//		dw_interface.setitem(ll_currow,"suppliercode",dw_pisq070u_right.GetItemString(ll_row, 'suppliercode'))
//		dw_interface.setitem(ll_currow,"applydatefrom",dw_pisq070u_right.GetItemString(ll_row, 'applydatefrom'))
//		dw_interface.setitem(ll_currow,"applydateto",dw_pisq070u_right.GetItemString(ll_row, 'applydateto'))
//		dw_interface.setitem(ll_currow,"recstatus",'D')
//		dw_interface.setitem(ll_currow,"qcgubun",dw_pisq070u_right.GetItemString(ll_row, 'qcgubun'))
//		dw_interface.setitem(ll_currow,"lastemp",g_s_empno)
//		dw_interface.setitem(ll_currow,"lastdate",datetime(date(string(g_s_date,"@@@@-@@-@@")),time(g_s_time)))
		
		dw_pisq070u_right.DeleteRow(ll_row)
		
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq070u_right.RowCount() THEN
	f_SetHighlight(dw_pisq070u_right, dw_pisq070u_right.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq070u_right, ll_select_row, True)	
END IF

//parent.TriggerEvent('ue_save')
end event

type uo_area from u_pisc_select_area within w_pisq070u
integer x = 59
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											FALSE, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

dw_pisq070u_left.SetTransObject(SQLPIS)
dw_pisq070u_right.SetTransObject(SQLPIS)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_productgroup from u_pisc_select_productgroup within w_pisq070u
integer x = 1198
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event constructor;call super::constructor;
PostEvent("ue_select")


end event

event ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_modelgroup
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
//						string			fs_modelgroup		   ��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ�
//						string			fs_modelgroup			��ȸ�ϰ��� �ϴ� �𵨱� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� �𵨱� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�𵨱��ڵ�� '%', �𵨱����� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_mdoelgroup			���õ� �𵨱� �ڵ� (reference)
//						string			rs_modelgroupname		���õ� �𵨱� �� (reference)
//	Returns		: none
//	Description	: �𵨱��� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

If ib_open Then
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq070u
integer x = 2130
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

type uo_division from u_pisc_select_division within w_pisq070u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")

//PostEvent("ue_select")

end event

event ue_select;call super::ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_productgroup
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
//						string			fs_productgroup		��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ��ǰ�� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (��ǰ���ڵ�� '%', ��ǰ������ '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_productgroup		���õ� ��ǰ�� �ڵ� (reference)
//						string			rs_productgroupname	���õ� ��ǰ�� �� (reference)
//	Returns		: none
//	Description	: ��ǰ���� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////


If ib_open Then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
											
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)

//	iw_this.TriggerEvent("ue_reset")
End If

dw_pisq070u_left.SetTransObject(SQLPIS)
dw_pisq070u_right.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq070u
integer x = 64
integer y = 228
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< ���˻�ǰ >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq070u
integer x = 1906
integer y = 228
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< ����ǰ�� >"
boolean focusrectangle = false
end type

type rb_a from radiobutton within w_pisq070u
integer x = 3122
integer y = 60
integer width = 219
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "�ʵ�"
end type

type rb_b from radiobutton within w_pisq070u
integer x = 3378
integer y = 60
integer width = 219
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "����"
end type

type rb_c from radiobutton within w_pisq070u
integer x = 3634
integer y = 60
integer width = 219
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "����"
end type

type rb_all from radiobutton within w_pisq070u
integer x = 4146
integer y = 60
integer width = 219
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "��ü"
boolean checked = true
end type

type st_leftcnt from statictext within w_pisq070u
integer x = 1097
integer y = 240
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type st_rightcnt from statictext within w_pisq070u
integer x = 4110
integer y = 240
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_print from datawindow within w_pisq070u
boolean visible = false
integer x = 2322
integer y = 800
integer width = 1138
integer height = 1148
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq070u_02_PRINT"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print1 from datawindow within w_pisq070u
boolean visible = false
integer x = 101
integer y = 904
integer width = 1271
integer height = 1072
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq070u_02_PRINT1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_d from radiobutton within w_pisq070u
integer x = 3890
integer y = 60
integer width = 219
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "Ư��"
end type

type dw_interface from datawindow within w_pisq070u
boolean visible = false
integer x = 2377
integer y = 172
integer width = 686
integer height = 448
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_pisq070u_interface_tqqcitem"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq070u
integer x = 18
integer y = 196
integer width = 4608
integer height = 2380
integer taborder = 80
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisq070u
integer x = 18
integer y = 12
integer width = 4608
integer height = 168
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
