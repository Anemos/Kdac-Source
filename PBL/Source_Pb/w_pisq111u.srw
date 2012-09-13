$PBExportHeader$w_pisq111u.srw
$PBExportComments$�˻缺���� �ۼ�(���ǿ�)
forward
global type w_pisq111u from w_ipis_sheet01
end type
type dw_pisq111u_detail from u_vi_std_datawindow within w_pisq111u
end type
type dw_pisq111u_head from datawindow within w_pisq111u
end type
type cb_exit from commandbutton within w_pisq111u
end type
type cb_save from commandbutton within w_pisq111u
end type
type dw_interface from datawindow within w_pisq111u
end type
type gb_1 from groupbox within w_pisq111u
end type
type gb_2 from groupbox within w_pisq111u
end type
end forward

global type w_pisq111u from w_ipis_sheet01
integer width = 4695
integer height = 2684
string title = "�˻缺���� �ۼ�(���ǿ�)"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq111u_detail dw_pisq111u_detail
dw_pisq111u_head dw_pisq111u_head
cb_exit cb_exit
cb_save cb_save
dw_interface dw_interface
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq111u w_pisq111u

type variables

end variables

forward prototypes
public function boolean wf_detail_insert ()
end prototypes

public function boolean wf_detail_insert ();
Boolean	lb_rtn
Int		li_row
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_deliveryno, ls_itemcode, ls_supplierlotno
Long		ll_orderno
Dec		ld_suppliermeasurementx1, ld_suppliermeasurementx2, ld_suppliermeasurementx3, ld_suppliermeasurementx4
Dec		ld_suppliermeasurementx5, ld_suppliermeasurementx6, ld_suppliermeasurementx7, ld_suppliermeasurementx8
Dec		ld_suppliermeasurementx9, ld_suppliermeasurementx10,ld_suppliermeasurementx,  ld_suppliermeasurementr
Dec		ld_suppliermeasurements
String	ls_supplierflagresult   
Dec		ld_qcmeasurementx1, ld_qcmeasurementx2, ld_qcmeasurementx3, ld_qcmeasurementx4, ld_qcmeasurementx5 
Dec		ld_qcmeasurementx6, ld_qcmeasurementx7, ld_qcmeasurementx8, ld_qcmeasurementx9, ld_qcmeasurementx10
Dec		ld_qcmeasurementx,  ld_qcmeasurementr,  ld_qcmeasurements
String	ls_qcflagresult 

dw_pisq111u_head.AcceptText()
dw_pisq111u_detail.AcceptText()

// HEAD�� ������ ���Ѵ�
//
ls_areacode			= dw_pisq111u_head.GetItemString(1, 'a_AreaCode')
ls_divisioncode	= dw_pisq111u_head.GetItemString(1, 'a_DivisionCode')
ls_suppliercode	= dw_pisq111u_head.GetItemString(1, 'a_suppliercode')
ls_deliveryno		= dw_pisq111u_head.GetItemString(1, 'a_deliveryno')
ls_itemcode			= dw_pisq111u_head.GetItemString(1, 'a_itemcode')	
ls_supplierlotno	= dw_pisq111u_head.GetItemString(1, 'as_supplierlotno')


IF f_checknullorspace(ls_supplierlotno) THEN
	ls_supplierlotno= '1'
END IF

lb_rtn = true

FOR li_row = 1 TO dw_pisq111u_detail.RowCount()
	// DETAIL�� ������ ���Ѵ�
	//
	ll_orderno						= li_row
	ld_suppliermeasurementx1	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx1')
	ld_suppliermeasurementx2	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx2')
	ld_suppliermeasurementx3	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx3')
	ld_suppliermeasurementx4	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx4')
	ld_suppliermeasurementx5	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx5')
	ld_suppliermeasurementx6	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx6')
	ld_suppliermeasurementx7	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx7')
	ld_suppliermeasurementx8	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx8')
	ld_suppliermeasurementx9	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx9')
	ld_suppliermeasurementx10	= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx10')
	ld_suppliermeasurementx		= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementx')
	ld_suppliermeasurementr		= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurementr')
	ld_suppliermeasurements		= dw_pisq111u_detail.GetItemNumber(li_row, 'suppliermeasurements')
	ls_supplierflagresult		= dw_pisq111u_detail.GetItemString(li_row, 'supplierflagresult')
	ld_qcmeasurementx1			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx1')
	ld_qcmeasurementx2			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx2')
	ld_qcmeasurementx3			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx3')
	ld_qcmeasurementx4			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx4')
	ld_qcmeasurementx5 			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx5')
	ld_qcmeasurementx6			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx6')
	ld_qcmeasurementx7			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx7')
	ld_qcmeasurementx8			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx8')
	ld_qcmeasurementx9			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx9')
	ld_qcmeasurementx10			= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx10')
	ld_qcmeasurementx				= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementx')
	ld_qcmeasurementr				= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurementr')
	ld_qcmeasurements				= dw_pisq111u_detail.GetItemNumber(li_row, 'qcmeasurements')
	ls_qcflagresult 				= dw_pisq111u_detail.GetItemString(li_row, 'qcflagresult')
	
	// �˻缺���� ���γ���(DETAIL)�� �����Ѵ�
	//
	INSERT INTO TQQCRESULTDETAIL  
             ( AREACODE,   DIVISIONCODE,   SUPPLIERCODE,   DELIVERYNO,   
	            ITEMCODE,   SUPPLIERLOTNO,  ORDERNO,   	  
					SUPPLIERMEASUREMENTX1,  SUPPLIERMEASUREMENTX2, SUPPLIERMEASUREMENTX3,   
	            SUPPLIERMEASUREMENTX4,  SUPPLIERMEASUREMENTX5, SUPPLIERMEASUREMENTX6,   
	            SUPPLIERMEASUREMENTX7,  SUPPLIERMEASUREMENTX8, SUPPLIERMEASUREMENTX9,   
           		SUPPLIERMEASUREMENTX10, SUPPLIERMEASUREMENTX,  SUPPLIERMEASUREMENTR,   
            	SUPPLIERMEASUREMENTS,   SUPPLIERFLAGRESULT,   
           		QCMEASUREMENTX1,   		QCMEASUREMENTX2,   	  QCMEASUREMENTX3,   
           		QCMEASUREMENTX4,   		QCMEASUREMENTX5,   	  QCMEASUREMENTX6,   
           		QCMEASUREMENTX7,   		QCMEASUREMENTX8,   	  QCMEASUREMENTX9,   
		         QCMEASUREMENTX10,   		QCMEASUREMENTX,   	  QCMEASUREMENTR,   
	           	QCMEASUREMENTS,         QCFLAGRESULT )  
      VALUES ( :ls_areacode, :ls_divisioncode, :ls_suppliercode, :ls_deliveryno, :ls_itemcode, :ls_supplierlotno, :ll_orderno,   	  
					:ld_suppliermeasurementx1, :ld_suppliermeasurementx2, :ld_suppliermeasurementx3, :ld_suppliermeasurementx4,
					:ld_suppliermeasurementx5, :ld_suppliermeasurementx6, :ld_suppliermeasurementx7, :ld_suppliermeasurementx8,
					:ld_suppliermeasurementx9, :ld_suppliermeasurementx10,:ld_suppliermeasurementx,  :ld_suppliermeasurementr,
					:ld_suppliermeasurements,  :ls_supplierflagresult,   
					:ld_qcmeasurementx1, :ld_qcmeasurementx2, :ld_qcmeasurementx3, :ld_qcmeasurementx4, :ld_qcmeasurementx5,
					:ld_qcmeasurementx6, :ld_qcmeasurementx7, :ld_qcmeasurementx8, :ld_qcmeasurementx9, :ld_qcmeasurementx10,
					:ld_qcmeasurementx,  :ld_qcmeasurementr,  :ld_qcmeasurements, :ls_qcflagresult )
		USING SQLPIS;
	IF SQLPIS.SQLCode = 0 THEN
		lb_rtn = TRUE
	ELSE 
		lb_rtn = FALSE
	END IF
	
NEXT

RETURN lb_rtn

end function

on w_pisq111u.create
int iCurrent
call super::create
this.dw_pisq111u_detail=create dw_pisq111u_detail
this.dw_pisq111u_head=create dw_pisq111u_head
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_interface=create dw_interface
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq111u_detail
this.Control[iCurrent+2]=this.dw_pisq111u_head
this.Control[iCurrent+3]=this.cb_exit
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_interface
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_pisq111u.destroy
call super::destroy
destroy(this.dw_pisq111u_detail)
destroy(this.dw_pisq111u_head)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_interface)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq030u, FULL)
//
//of_resize()
//
end event

event open;

////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// ������ �������� �缳���Ѵ�
//
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

// �����찣�� ������ ��Ʈ���� �迭�� �޴´�
//
istr_parms = message.powerobjectparm

// �������� �������� ��ǥ�� �缳���Ѵ�
//
This.x = 1
This.y = 265

// �������� �������� Ÿ��Ʋ�� �缳���Ѵ�
//
this.title = 'w_pisq111u(�˻缺���� �ۼ�(���ǿ�))'

// Ʈ������� �����Ѵ�
//
dw_pisq111u_head.SetTransObject(SQLPIS)
dw_pisq111u_detail.SetTransObject(SQLPIS)

TriggerEvent('ue_Retrieve')

// ����Ÿ�����쿡 ��Ŀ���� �ִ� �࿡ ����ǥ�ø� ��Ÿ����(1��)
//
f_SetHighlight(dw_pisq111u_detail, 1, True)	

// ����ũ�� ������ ������ ��Ʈ�Ѵ�
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")

end event

event closequery;call super::closequery;
// ������ �޼����� ������ ó���޼����� ����
//
message.powerobjectparm = istr_parms

end event

event ue_retrieve;call super::ue_retrieve;
String	ls_AreaCode, ls_AreaName, ls_DivisionCode, ls_DivisionName, ls_SLNO, ls_DeliveryDate
String	ls_SupplierCode, ls_SupplierKorName, ls_ItemCode, ls_ItemName, ls_standardrevno
Long		ll_SupplierDeliveryQty

// �ƱԸ�Ʈ�� �Ѿ�°��� ������ �����Ѵ�
//
ls_AreaCode			     = istr_parms.String_arg[01] 
ls_AreaName			     = istr_parms.String_arg[02] 
ls_DivisionCode		  = istr_parms.String_arg[03] 
ls_DivisionName		  = istr_parms.String_arg[04] 
ls_SLNO				     = istr_parms.String_arg[05] 
ls_DeliveryDate		  = istr_parms.String_arg[06] 
ls_SupplierCode		  = istr_parms.String_arg[07] 
ls_SupplierKorName	  = istr_parms.String_arg[08] 
ls_ItemCode			     = istr_parms.String_arg[09] 
ls_ItemName			     = istr_parms.String_arg[10] 
ll_SupplierDeliveryQty = istr_parms.Long_arg[01]   

// �Է��� �ο츦 �����Ѵ�(HEAD)
//
dw_pisq111u_head.InsertRow(0)

// ȭ�鿡 �ŷ���ǥ ������ ��Ʈ�Ѵ�
//
dw_pisq111u_head.SetItem(1, 'a_AreaCode'					, ls_AreaCode)
dw_pisq111u_head.SetItem(1, 'b_AreaName'					, ls_AreaName)
dw_pisq111u_head.SetItem(1, 'a_DivisionCode'				, ls_DivisionCode)
dw_pisq111u_head.SetItem(1, 'c_DivisionName'				, ls_DivisionName)
dw_pisq111u_head.SetItem(1, 'a_deliveryno'				, ls_SLNO)
dw_pisq111u_head.SetItem(1, 'a_SLNO'						, ls_SLNO)
dw_pisq111u_head.SetItem(1, 'a_DeliveryDate'				, ls_DeliveryDate)
dw_pisq111u_head.SetItem(1, 'a_SupplierCode'				, ls_SupplierCode)
dw_pisq111u_head.SetItem(1, 'd_SupplierKorName'			, ls_SupplierKorName)
dw_pisq111u_head.SetItem(1, 'a_ItemCode'					, ls_ItemCode)
dw_pisq111u_head.SetItem(1, 'e_ItemName'					, ls_ItemName)
dw_pisq111u_head.SetItem(1, 'a_SupplierDeliveryQty'	, ll_SupplierDeliveryQty)
dw_pisq111u_head.SetItem(1, 'a_as_supplierdeliveryqty', ll_SupplierDeliveryQty)
dw_pisq111u_head.SetItem(1, 'a_kdacremark', "�ڵ������� �˻缺���� �Դϴ�.")
dw_pisq111u_head.SetItem(1, 'a_makedate'					, String(Today(),'YYYY.MM.DD'))
dw_pisq111u_head.SetItem(1, 'a_qcmethod'					, '1')

// ���ؼ� Rev No.�� ���Ѵ�
//
SELECT A.STANDARDREVNO  
  INTO :ls_standardrevno
  FROM TQQCSTANDARD  A
 WHERE A.AREACODE			= :ls_AreaCode
	AND A.DIVISIONCODE	= :ls_DivisionCode
	AND A.SUPPLIERCODE	= :ls_SupplierCode
	AND A.ITEMCODE			= :ls_ItemCode
 USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	MessageBox('Ȯ ��', '�˻���ؼ��� �������� �ʽ��ϴ�')
	RETURN
END IF

dw_pisq111u_head.SetItem(1, 'a_standardrevno'				, ls_standardrevno)
dw_pisq111u_head.SetColumn('a_supplierlotqty')
dw_pisq111u_head.SetFocus()

// ���ؼ� ������ ��ȸ�Ѵ�(DETAIL)
//
dw_pisq111u_detail.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode,  ls_itemcode, ls_standardrevno)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq111u
boolean visible = false
integer x = 41
integer y = 2492
integer width = 3602
end type

type dw_pisq111u_detail from u_vi_std_datawindow within w_pisq111u
integer x = 46
integer y = 1264
integer width = 4581
integer height = 1136
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq111u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_pisq111u_head from datawindow within w_pisq111u
integer x = 46
integer y = 264
integer width = 4581
integer height = 988
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq111u_01"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
String	ls_colname, ls_coldata, ls_supplierlotno
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode
Long		ll_supplierdeliveryqty, ll_Rows, ll_foundrow 

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// �պ������� ���� ó���� �Ѵ�
	//
	CASE 'a_judgeflag'
		// ��ǰ������ ���Ѵ�
		//
		ll_supplierdeliveryqty = This.GetItemNumber(row, 'a_as_supplierdeliveryqty')
		CHOOSE CASE ls_coldata
			// �հ�
			//
			CASE '1'
				This.SetItem(row, 'a_goodqty', ll_supplierdeliveryqty)
				This.SetItem(row, 'a_badqty' , 0)
			// ���հ�
			//
			CASE '2'
				This.SetItem(row, 'a_goodqty', 0)
				This.SetItem(row, 'a_badqty' , ll_supplierdeliveryqty)
			// ����
			//
			CASE '3'
				This.SetItem(row, 'a_goodqty', 0)
				This.SetItem(row, 'a_badqty' , 0)

	END CHOOSE

	CASE 'a_badqty'
		// ��ǰ������ ���Ѵ�
		//
		ll_supplierdeliveryqty = This.GetItemNumber(row, 'a_as_supplierdeliveryqty')

		// �հݼ����� ��Ʈ�Ѵ�
		//
		This.SetItem(row, 'a_goodqty', ll_supplierdeliveryqty - Long(data))

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event itemerror;
RETURN 1
end event

type cb_exit from commandbutton within w_pisq111u
integer x = 4224
integer y = 56
integer width = 389
integer height = 124
integer taborder = 10
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

Close(parent)
end event

type cb_save from commandbutton within w_pisq111u
integer x = 3799
integer y = 56
integer width = 389
integer height = 124
integer taborder = 20
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
Int		li_save, li_currow
String	ls_judgeflag, ls_badreason, ls_supplierlotno, ls_leadtime, ls_deliverydate
String	ls_AreaCode, ls_DivisionCode, ls_slno, ls_deliverydatetime, ls_systemdatetime 
Long		ll_GoodQty, ll_BadQty, ll_supplierlotqty, ll_minute, ll_hh, ll_mm
String	ls_suppliercode, ls_itemcode, ls_message
str_ipis_server lstr_ipis[]
string ls_areadivision[]

IF dw_pisq111u_head.AcceptText() <> 1 THEN RETURN  0

// �Է��׸� üũ��
//
ls_AreaCode			= dw_pisq111u_head.GetItemString(1, 'a_AreaCode')
ls_DivisionCode	= dw_pisq111u_head.GetItemString(1, 'a_DivisionCode')
ls_slno 				= dw_pisq111u_head.GetItemString(1, 'a_slno')
ls_suppliercode 	= dw_pisq111u_head.GetItemString(1, 'a_suppliercode')
ls_itemcode			= dw_pisq111u_head.GetItemString(1, 'a_itemcode')
ls_supplierlotno  = dw_pisq111u_head.GetItemString(1, 'as_supplierlotno')
ls_judgeflag		= dw_pisq111u_head.GetItemString(1, 'a_judgeflag')
ls_badreason		= dw_pisq111u_head.GetItemString(1, 'a_badreason')
ll_supplierlotqty = dw_pisq111u_head.GetItemNumber(1, 'a_supplierlotqty')
ll_GoodQty			= dw_pisq111u_head.GetItemNumber(1, 'a_GoodQty')
ll_BadQty			= dw_pisq111u_head.GetItemNumber(1, 'a_BadQty')

//IF f_checknullorspace(String(ll_supplierlotqty)) = TRUE THEN
//	MessageBox('Ȯ ��', 'LOT���� �Է��ϼ���')
//	RETURN
//END IF
//
//IF f_checknullorspace(ls_supplierlotno) = TRUE THEN
//	MessageBox('Ȯ ��', '��üLOT NO�� �Է��ϼ���')
//	RETURN
//END IF

IF f_checknullorspace(ls_judgeflag) = TRUE THEN
	MessageBox('Ȯ ��', '������ ���� �����ϼ���')
	RETURN 0
END IF

// ���հ�, �����ô� �ҷ�����/�ҷ������� �ݵ�� �����Ͽ��� �Ѵ�
//
IF ls_judgeflag = '2' or ls_judgeflag = '3' THEN
	IF ll_BadQty = 0 THEN
		MessageBox('Ȯ ��', '�ҷ������� �ݵ�� �Է��ϼ���')
		dw_pisq111u_head.SetColumn('a_BadQty')
		dw_pisq111u_head.SetFocus()
		RETURN 0
	END IF
	IF f_checknullorspace(ls_badreason) = TRUE THEN
		MessageBox('Ȯ ��', '�ҷ������� �ݵ�� �����ϼ���')
		RETURN 0
	END IF
END IF

// �˻������� �ʿ��� �⺻������ ��Ʈ�Ѵ�
//
dw_pisq111u_head.SetItem(1, 'a_InspectorCode', g_s_empno)
dw_pisq111u_head.SetItem(1, 'a_confirmcode'	, '')
dw_pisq111u_head.SetItem(1, 'a_confirmflag'	, 'N')
dw_pisq111u_head.SetItem(1, 'a_printflag'		, 'N')
dw_pisq111u_head.SetItem(1, 'a_qckbflag'		, '2')
dw_pisq111u_head.SetItem(1, 'a_QCDate'			, String(f_getsysdatetime(), 'yyyy.mm.dd'))
dw_pisq111u_head.SetItem(1, 'a_QCTime'			, String(f_getsysdatetime(), 'hh:mm:ss'))
dw_pisq111u_head.SetItem(1, 'a_QCLeadTime'	, '0')
ls_deliverydate = Mid(istr_parms.String_arg[06], 1, 4) + '.' + &
						Mid(istr_parms.String_arg[06], 5, 2) + '.' + &
						Mid(istr_parms.String_arg[06], 7, 2) 
dw_pisq111u_head.SetItem(1, 'a_deliverydate'	, ls_deliverydate)
dw_pisq111u_head.SetItem(1, 'a_deliverytime'	, '00:00:00')
dw_pisq111u_head.SetItem(1, 'a_lastemp'		, 'Y')

///////////////////////////////////////////////////////////////////////////////////////////
// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// HEAD������ �����Ѵ�
//
li_save = dw_pisq111u_head.Update()

IF li_save <> 1 THEN
	ls_message = 'ó���� �����߽��ϴ�'
	goto Rollback_
END IF
// DETAIL������ �����Ѵ�
//
if Not wf_detail_insert() then
	ls_message = '�˻缺���� ���γ��� ���忡 �����߽��ϴ�'
	goto Rollback_
end if
// ���� �԰��� �������� ����Ÿ �̵� (2004.06.15)
if ls_areacode = 'Y' and ls_divisioncode = 'Y' then
	
	INSERT INTO TPARTINREADY  
	( AreaCode, DivisionCode, Slno, DeliveryDate, SupplierCode, ItemCode,
	  SupplierDeliveryQty, JudgeFlag, GoodQty, BadQty, Incomeflag,
	  IncomeDate, TidNo, LastEmp, LastDate )
	SELECT a.AreaCode, a.DivisionCode, a.Slno, a.DeliveryDate, a.SupplierCode,
	  a.ItemCode, a.SupplierDeliveryQty, :ls_JudgeFlag, :ll_GoodQty, :ll_BadQty, 'Y',
	  null, null, :g_s_empno, getdate()
	FROM tqbusinesstemp a 
	WHERE a.AreaCode = :ls_areacode and a.DivisionCode = :ls_divisioncode and
	  a.Slno = :ls_slno
	using sqlpis;
	
	if sqlpis.sqlcode <> 0 then
		ls_message = '�԰��� ó���߿� �����߽��ϴ�'
		goto Rollback_
	end if
end if
// ��������� �ŷ���ǥ TEMP ���Ͽ� UPDATE�Ѵ�
//
//if is_qcgubun = 'Q' then
//	//���˻� ��� ǰ��ó��
//	DELETE FROM TQBUSINESSTEMP  
//			WHERE TQBUSINESSTEMP.AREACODE		 = :ls_areacode
//			  AND	TQBUSINESSTEMP.DIVISIONCODE = :ls_divisioncode
//			  AND	TQBUSINESSTEMP.SLNO			 = :ls_slno
//	USING SQLPIS;
//	
//	if sqlpis.sqlcode <> 0 then
//		ls_message = '�ŷ���ǥ TEMP ���� ó���� �����߽��ϴ�'
//		goto Rollback_
//	end if
//else
	dw_interface.reset()
	li_currow = dw_interface.insertrow(0)
	dw_interface.setitem(li_currow,"logid",li_currow)
	dw_interface.setitem(li_currow,"areacode",ls_areacode)
	dw_interface.setitem(li_currow,"divisioncode",ls_divisioncode)
	dw_interface.setitem(li_currow,"slno",ls_slno)
	dw_interface.setitem(li_currow,"suppliercode",ls_suppliercode)
	dw_interface.setitem(li_currow,"itemcode",ls_itemcode)
	dw_interface.setitem(li_currow,"judgeflag",ls_judgeflag)
	dw_interface.setitem(li_currow,"goodqty",ll_goodqty)
	dw_interface.setitem(li_currow,"badqty",ll_badqty)
	dw_interface.setitem(li_currow,"lastemp",g_s_empno)
	dw_interface.setitem(li_currow,"lastdate",datetime(date(string(g_s_date,"@@@@-@@-@@")),time(g_s_time)))
	
	// �ǽð� �Լ� ȣ��
	ls_areadivision[1] = 'XZ'
	lstr_ipis = f_ipis_server_set_transaction('EACH',ls_areadivision)
	if f_up_ipis_mis_tqbusinesstemp(ls_message,dw_interface,lstr_ipis) = -1 then
		goto Rollback_
	end if
	
	DELETE TQBUSINESSTEMP
	WHERE AREACODE		= :ls_AreaCode
		AND DIVISIONCODE	= :ls_DivisionCode
		AND SLNO				= :ls_slno
	using sqlpis;
	if sqlpis.sqlcode <> 0 then
		ls_message = '�ŷ���ǥ TEMP ���� ó���� �����߽��ϴ�'
		goto Rollback_
	end if
//end if

COMMIT USING SQLPIS;
SQLPIS.AUTOCommit = TRUE
f_ipis_server_commit_transaction(lstr_ipis)

MessageBox('Ȯ ��', 'ó���� �Ϸ�Ǿ����ϴ�')
return 0

Rollback_:
RollBack using SQLPIS ;
SQLPIS.AUTOCommit = TRUE
f_ipis_server_rollback_transaction(lstr_ipis)

MessageBox('Ȯ ��', ls_message)
return 0

end event

type dw_interface from datawindow within w_pisq111u
boolean visible = false
integer x = 2647
integer y = 40
integer width = 686
integer height = 160
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq110u_interface_tqbusinesstemp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq111u
integer x = 14
integer y = 224
integer width = 4645
integer height = 2204
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisq111u
integer x = 3749
integer width = 910
integer height = 216
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

