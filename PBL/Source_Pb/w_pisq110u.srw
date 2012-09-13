$PBExportHeader$w_pisq110u.srw
$PBExportComments$�˻缺���� ����(���ǿ�)
forward
global type w_pisq110u from w_ipis_sheet01
end type
type dw_pisq110u_detail from u_vi_std_datawindow within w_pisq110u
end type
type dw_pisq110u_head from datawindow within w_pisq110u
end type
type cb_exit from commandbutton within w_pisq110u
end type
type cb_save from commandbutton within w_pisq110u
end type
type dw_pisq110u_kb from datawindow within w_pisq110u
end type
type cb_detailsave from commandbutton within w_pisq110u
end type
type dw_stdev from datawindow within w_pisq110u
end type
type dw_interface from datawindow within w_pisq110u
end type
type gb_1 from groupbox within w_pisq110u
end type
type gb_2 from groupbox within w_pisq110u
end type
end forward

global type w_pisq110u from w_ipis_sheet01
integer width = 4695
integer height = 2684
string title = "�˻缺���� ����(���ǿ�)"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq110u_detail dw_pisq110u_detail
dw_pisq110u_head dw_pisq110u_head
cb_exit cb_exit
cb_save cb_save
dw_pisq110u_kb dw_pisq110u_kb
cb_detailsave cb_detailsave
dw_stdev dw_stdev
dw_interface dw_interface
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq110u w_pisq110u

type variables

datawindowchild	idwc_supplierlotno
String				is_array_lotno[25], is_revno, is_qcgubun
Long					il_array_cnt

end variables
forward prototypes
public subroutine wf_xrscalc ()
end prototypes

public subroutine wf_xrscalc ();
String	ls_colname
Long		ll_row, ll_cnt, ll_incnt, ll_insrow
Dec		ld_tot, ld_x, ld_r, ld_s, ld_max, ld_min, ld_qcmeasurementx = 0

// ���γ����� ���ڵ� �Ǽ���ŭ ����ó��
// 
FOR ll_row = 1 to dw_pisq110u_detail.RowCount()
	ld_tot	= 0
	ll_incnt = 0
	ld_max	= 0
	ld_min	= 9999
	
	// ǥ���������� ����Ÿ�����츦 �����Ѵ�
	// 
	dw_stdev.ReSet()
	
	FOR ll_cnt = 1 TO 10
		ls_colname = 'qcmeasurementx' + Trim(String(ll_cnt))
		ld_qcmeasurementx = dw_pisq110u_detail.GetItemNumber(ll_row, ls_colname)

		// ���� �ִ°͸��� ��������Ѵ�
		//
		IF ld_qcmeasurementx > 0 THEN

			// ǥ���������� ����Ÿ�����쿡 ���� ��Ʈ�Ѵ�
			// 
			ll_insrow = dw_stdev.InsertRow(0)
			dw_stdev.SetItem(ll_insrow, 'an_stdev', ld_qcmeasurementx)
	
			// MAX�� ���Ѵ�
			//
			IF ld_max < ld_qcmeasurementx THEN
				ld_max = ld_qcmeasurementx 
			END IF
				
			// MIN�� ���Ѵ�
			//
			IF ld_min > ld_qcmeasurementx THEN
				ld_min = ld_qcmeasurementx 
			END IF

			// ���� �ִ°��� ���� ����
			//
			ld_tot = ld_tot + ld_qcmeasurementx
			// ���� �ִ°��� ����� ����
			//
			ll_incnt ++
		END IF
	NEXT

	IF ld_tot = 0 THEN
		// �Էµ� ���� ���� 0�ΰ��� �ʱ�ȭ�Ѵ�
		//
		dw_pisq110u_detail.SetItem(ll_row, 'qcmeasurementx', 0)
		dw_pisq110u_detail.SetItem(ll_row, 'qcmeasurementr', 0)
		dw_pisq110u_detail.SetItem(ll_row, 'qcmeasurements', 0)
	ELSE
		// �Էµ� ���� �ִ� ��츸 ���� ����Ѵ�
		//
		ld_x = ld_tot / ll_incnt
		ld_r = ld_max - ld_min
		// X��Ʈ
		//
		dw_pisq110u_detail.SetItem(ll_row, 'qcmeasurementx', ld_x)
		// R��Ʈ
		//
		dw_pisq110u_detail.SetItem(ll_row, 'qcmeasurementr', ld_r)
		// S��Ʈ
		//
		dw_pisq110u_detail.SetItem(ll_row, 'qcmeasurements', dw_stdev.GetItemNumber(1, 'stdev'))
	END IF
NEXT
end subroutine

on w_pisq110u.create
int iCurrent
call super::create
this.dw_pisq110u_detail=create dw_pisq110u_detail
this.dw_pisq110u_head=create dw_pisq110u_head
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_pisq110u_kb=create dw_pisq110u_kb
this.cb_detailsave=create cb_detailsave
this.dw_stdev=create dw_stdev
this.dw_interface=create dw_interface
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq110u_detail
this.Control[iCurrent+2]=this.dw_pisq110u_head
this.Control[iCurrent+3]=this.cb_exit
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_pisq110u_kb
this.Control[iCurrent+6]=this.cb_detailsave
this.Control[iCurrent+7]=this.dw_stdev
this.Control[iCurrent+8]=this.dw_interface
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
end on

on w_pisq110u.destroy
call super::destroy
destroy(this.dw_pisq110u_detail)
destroy(this.dw_pisq110u_head)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_pisq110u_kb)
destroy(this.cb_detailsave)
destroy(this.dw_stdev)
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
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_DeliveryNo, ls_SupplierLotno 
Long		ll_idx, ll_reccount = 0

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
this.title = 'w_pisq110u(�˻缺���� ����(���ǿ�))'

// Ʈ������� �����Ѵ�
//
dw_pisq110u_head.SetTransObject(SQLPIS)
dw_pisq110u_detail.SetTransObject(SQLPIS)
dw_pisq110u_kb.SetTransObject(SQLPIS)

ls_areacode			= istr_parms.String_arg[1]
ls_divisioncode	= istr_parms.String_arg[2]
ls_suppliercode	= istr_parms.String_arg[3]
ls_DeliveryNo		= istr_parms.String_arg[4]
ls_itemcode			= istr_parms.String_arg[5]
is_revno          = istr_parms.String_arg[6]
is_qcgubun			= istr_parms.String_arg[7]

// ������� ���� ���Ǹż� �Է�ȭ���� ����ó���ø� �ʿ��ϹǷ� ȭ�鿡 ǥ������ �ʴ´�
//
dw_pisq110u_kb.Visible = FALSE

// ���������� ��ϵ� �ڷ��ΰ��� Ȯ��

SELECT COUNT(*) 
  INTO :ll_reccount
  FROM TQQCRESULTDETAIL  A
 WHERE A.AREACODE			= :ls_AreaCode
	AND A.DIVISIONCODE	= :ls_DivisionCode
	AND A.SUPPLIERCODE	= :ls_SupplierCode
	AND A.DELIVERYNO		= :ls_DeliveryNo
	AND A.ITEMCODE			= :ls_ItemCode
 USING SQLPIS;

IF ll_reccount = 0 THEN
	MessageBox('Ȯ ��', '�˻缺���� ���γ����� ��� ó���� �Ҽ��� �����ϴ�')
	RETURN 0
END IF

// Child Datawindow ����(��üLOT NO)
//
dw_pisq110u_head.GetChild ('as_supplierlotno', idwc_supplierlotno)
idwc_supplierlotno.SetTransObject( SQLPIS )

// Child Retrieve
//
idwc_supplierlotno.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode)

// �ڷḦ ��ȸ�Ѵ�(HEAD)
//
ll_reccount = dw_pisq110u_head.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode)
if ll_reccount = 1 then
	dw_pisq110u_head.setitem( 1, 'a_slno', ls_deliveryno)
end if

// �ڷḦ ��ȸ�Ѵ�(DETAIL)
//
ls_SupplierLotno = dw_pisq110u_head.GetItemString(1, 'as_supplierlotno')
dw_pisq110u_detail.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode, ls_SupplierLotno, is_revno)

// �ڷḦ ��ȸ�Ѵ�(KB)
//
dw_pisq110u_kb.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode)

// ������� ���� ���Ǹż� �Է�ȭ���� ����ó���ø� �ʿ��ϹǷ� ȭ�鿡 ǥ������ �ʴ´�
//
dw_pisq110u_kb.Visible = FALSE

// ����Ÿ�����쿡 ��Ŀ���� �ִ� �࿡ ����ǥ�ø� ��Ÿ����(1��)
//
f_SetHighlight(dw_pisq110u_detail, 1, True)	

// �ν��Ͻ��� ����� ��� �� ��� ī���͸� �ʱ�ȭ�Ѵ�
//
FOR ll_idx = 1 TO 10
	is_array_lotno[ll_idx] = ''
NEXT
il_array_cnt = 0

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

type uo_status from w_ipis_sheet01`uo_status within w_pisq110u
boolean visible = false
integer x = 41
integer y = 2492
integer width = 3602
end type

type dw_pisq110u_detail from u_vi_std_datawindow within w_pisq110u
integer x = 46
integer y = 1340
integer width = 4581
integer height = 1080
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq110u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_pisq110u_head from datawindow within w_pisq110u
integer x = 46
integer y = 264
integer width = 4581
integer height = 1068
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq110u_01"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
String	ls_colname, ls_coldata, ls_supplierlotno
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode
Long		ll_supplierdeliveryqty, ll_Rows, ll_foundrow, ll_lotqty

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��üLOT NO�� �ٲ𶧸��� �˻缺���� ���γ����� ��ǥ���Ѵ�
	//
	CASE 'as_supplierlotno'
		// �˻缼�γ����� �������θ� Ȯ���Ѵ�
		//
		ll_Rows = dw_pisq110u_detail.ModifiedCount()		

		// �˻缼�γ����� �۾��ϰ� ���� ���������
		//
		IF ll_Rows <> 0 THEN
			// ���۾����� ��ü��Ʈ��ȣ�� ���Ѵ�
			//
			ls_supplierlotno = dw_pisq110u_detail.GetItemString(1, 'supplierlotno')
			// ���̵� ����Ÿ �����쿡�� ���۾����� ��Ʈ��ȣ�� ���ȣ�� ���Ѵ�
			//
			ll_foundrow = idwc_supplierlotno.Find( "supplierlotno = '" + ls_supplierlotno + "'", 1, idwc_supplierlotno.RowCount())
			// ȭ���� ��Ʈ��ȣ�� �۾����� ��Ʈ��ȣ�� ��ǥ���Ѵ�
			//
			idwc_supplierlotno.ScrollToRow(ll_foundrow)
			// �޼����� ǥ���ϰ� ó���� �ǵ�����
			//
			MessageBox('Ȯ ��', '�˻� ���γ����� ������ �ٸ� LOT NO�� �۾��ϼ���')
			RETURN 1
		END IF

		// ��ȸ�� �ʿ��� �׸��� ���Ѵ�
		//
		ls_areacode			= This.GetItemString(row, 'a_areacode')
		ls_divisioncode	= This.GetItemString(row, 'a_divisioncode')
		ls_suppliercode	= This.GetItemString(row, 'a_suppliercode')
		ls_DeliveryNo		= This.GetItemString(row, 'a_DeliveryNo')
		ls_itemcode			= This.GetItemString(row, 'a_itemcode')

		// ��Ʈ������ ���Ѵ�
		//
		SELECT TOp 1
				 A.lotqty  
		  INTO :ll_lotqty
		  FROM TQQCRESULTDETAIL A  
		 WHERE A.AREACODE			= :ls_areacode
		   AND A.DIVISIONCODE	= :ls_divisioncode
			AND A.SUPPLIERCODE	= :ls_suppliercode			
			AND A.DELIVERYNO		= :ls_DeliveryNo
			AND A.ITEMCODE			= :ls_itemcode
			AND A.SUPPLIERLOTNO	= :ls_coldata
       USING SQLPIS;

		dw_pisq110u_head.SetItem(1, 'as_lotqty', ll_lotqty)

		// �ڷḦ ��ȸ�Ѵ�
		//
		dw_pisq110u_detail.Retrieve(ls_areacode, ls_divisioncode, ls_suppliercode, ls_DeliveryNo, ls_itemcode, ls_coldata, is_revno)

		// ����Ÿ�����쿡 ��Ŀ���� �ִ� �࿡ ����ǥ�ø� ��Ÿ����(1��)
		//
		f_SetHighlight(dw_pisq110u_detail, 1, True)	

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
		This.SetItem(row, 'a_goodqty', (ll_supplierdeliveryqty - Long(data)))

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

event itemerror;
RETURN 1
end event

type cb_exit from commandbutton within w_pisq110u
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

type cb_save from commandbutton within w_pisq110u
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
String	ls_judgeflag, ls_badreason, ls_deliverydatetime, ls_systemdatetime, ls_deliverydate
String	ls_AreaCode, ls_DivisionCode, ls_slno, ls_slnoall, ls_leadtime
Long		ll_GoodQty, ll_BadQty, ll_supplierlotqty, ll_slno_count = 0, ll_hh, ll_mm, ll_minute, ll_supplierdeliveryqty	
String	ls_suppliercode, ls_itemcode, ls_message
str_ipis_server lstr_ipis[]
string ls_areadivision[]

IF dw_pisq110u_head.AcceptText() <> 1 THEN RETURN 0

// �Է��׸� üũ��
//
ls_AreaCode			= dw_pisq110u_head.GetItemString(1, 'a_AreaCode')
ls_DivisionCode	= dw_pisq110u_head.GetItemString(1, 'a_DivisionCode')
ls_slno 				= dw_pisq110u_head.GetItemString(1, 'a_slno')
ls_judgeflag		= dw_pisq110u_head.GetItemString(1, 'a_judgeflag')
ls_badreason		= dw_pisq110u_head.GetItemString(1, 'a_badreason')
ll_GoodQty			= dw_pisq110u_head.GetItemNumber(1, 'a_GoodQty')
ll_BadQty			= dw_pisq110u_head.GetItemNumber(1, 'a_BadQty')

ll_supplierlotqty	= dw_pisq110u_head.GetItemNumber(1, 'a_supplierlotqty')

// LOT����ŭ ��Ʈ���γ����� ����Ǿ����� Ȯ��
//
IF ll_supplierlotqty <> il_array_cnt THEN
	MessageBox('Ȯ ��', '��Ʈ��:' + String(ll_supplierlotqty) + &
				' �˻缺���� ����Ƚ��:' + String(il_array_cnt) + '�� ����Ʋ���ϴ�. �˻缺������ ��Ʈ����ŭ �����ϼ���')
	RETURN 0
END IF

// �������� Ȯ��
//
IF ls_judgeflag = '9' THEN
	MessageBox('Ȯ ��', '������ ���� �����ϼ���')
	dw_pisq110u_head.SetColumn('a_judgeflag')
	dw_pisq110u_head.SetFocus()
	RETURN 0
END IF

// ������ ���Ǹż� ���� Ȯ��
//
IF ls_judgeflag = '3' AND ll_badqty = 0 THEN
	MessageBox('Ȯ ��', '�����ô� ���հݼ����� �Է��ϼ���')
	RETURN 0
END IF

// ���հ�, �����ô� �ҷ�����/�ҷ������� �ݵ�� �����Ͽ��� �Ѵ�
//
IF ls_judgeflag = '2' or ls_judgeflag = '3' THEN
	IF ll_BadQty = 0 THEN 
		MessageBox('Ȯ ��', '���հݼ����� �ݵ�� �Է��ϼ���')
		dw_pisq110u_head.SetColumn('a_BadQty')
		dw_pisq110u_head.SetFocus()
		RETURN 0
	END IF
	IF f_checknullorspace(ls_badreason) = TRUE THEN
		MessageBox('Ȯ ��', '�ҷ������� �ݵ�� �����ϼ���')
		dw_pisq110u_head.SetColumn('a_BadReason')
		dw_pisq110u_head.SetFocus()
		RETURN 0
	END IF
END IF

// �ŷ���ǥ ��ȣ�� �ʼ��Է�
//
IF f_checknullorspace(ls_slno) = TRUE THEN
	MessageBox('Ȯ ��', '�ŷ���ǥ ��ȣ�� �ݵ�� �Է��ϼ���')
	dw_pisq110u_head.SetColumn('a_slno')
	dw_pisq110u_head.SetFocus()
	RETURN 0
END IF

// �ŷ���ǥ ��ȣ�� ã�´�(�ŷ���ǥ ��4�ڸ��� �Ϸù�ȣ �̹Ƿ� ��4�ڸ��� �߶� ���Ѵ�)
// �Ϸù�ȣ�� �ߺ��Ǹ� �ߺ��� �Ϸù�ȣ�� ������ �����쿡 ���� ǥ������ �Ѱ��� �����Ѵ�
//
if len(ls_slno) = 4 then
	SELECT COUNT(*)
	  INTO :ll_slno_count
	  FROM TQBUSINESSTEMP A
	 WHERE A.AREACODE		= :ls_AreaCode
		AND A.DIVISIONCODE= :ls_DivisionCode
		AND CAST(SUBSTRING(A.SLNO, 9, 4) AS INT) = CAST(:ls_slno AS INT)
		AND A.JUDGEFLAG	= '9'
	 USING SQLPIS;
else
	SELECT COUNT(*)
	  INTO :ll_slno_count
	  FROM TQBUSINESSTEMP A
	 WHERE A.AREACODE		= :ls_AreaCode
		AND A.DIVISIONCODE= :ls_DivisionCode
		AND A.SLNO = :ls_slno
		AND A.JUDGEFLAG	= '9'
	 USING SQLPIS;
end if

// �ߺ���ȣ�� �ִ°��
//
IF ll_slno_count > 1 THEN
	// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
	//
	istr_parms.String_arg[1] = ls_AreaCode
	istr_parms.String_arg[2] = ls_DivisionCode
	istr_parms.String_arg[3] = ls_slno
	// �ŷ���ǥ ��ȣ ����ȭ�� ����
	//
	OpenWithParm(w_pisq112u, istr_parms)

	istr_parms = Message.PowerObjectParm

	// �ŷ���ǥ ��ȣ ����ȭ�鿡�� ���õǾ��� �Ѿ�� �ŷ���ǥ ��ȣ�� ��Ʈ�Ѵ�
	//
	ls_slnoall  = istr_parms.String_arg[4]
ELSE
	if len(ls_slno) = 4 then
		SELECT A.SLNO  
		  INTO :ls_slnoall
		  FROM TQBUSINESSTEMP A
		 WHERE A.AREACODE		= :ls_AreaCode
			AND A.DIVISIONCODE= :ls_DivisionCode
			AND CAST(SUBSTRING(A.SLNO, 9, 4) AS INT) = CAST(:ls_slno AS INT)
			AND A.JUDGEFLAG	= '9'
		 USING SQLPIS;
	else
		SELECT A.SLNO  
		  INTO :ls_slnoall
		  FROM TQBUSINESSTEMP A
		 WHERE A.AREACODE		= :ls_AreaCode
			AND A.DIVISIONCODE= :ls_DivisionCode
			AND A.SLNO = :ls_slno
			AND A.JUDGEFLAG	= '9'
		 USING SQLPIS;
	end if

	IF SQLPIS.SQLCode <> 0 THEN
		MessageBox('Ȯ ��', '�ش��ϴ� �ŷ���ǥ ��ȣ�� �����ϴ�')
		dw_pisq110u_head.SetColumn('a_slno')
		dw_pisq110u_head.SetFocus()
		RETURN 0
	END IF
END IF

// �ŷ���ǥ ��ȣ�� ������ ������ ��ü + ǰ�� + ��ǰ������ �������� üũ
//
SELECT a.suppliercode,
  		 a.itemcode,
		 a.supplierdeliveryqty	
  INTO :ls_suppliercode,
  		 :ls_itemcode,
		 :ll_supplierdeliveryqty	
  FROM TQBUSINESSTEMP A
 WHERE A.AREACODE		= :ls_AreaCode
	AND A.DIVISIONCODE= :ls_DivisionCode
	AND A.SLNO			= :ls_slnoall
 USING SQLPIS;

IF ls_suppliercode <> dw_pisq110u_head.GetItemString(1, 'a_suppliercode') THEN
	MessageBox('Ȯ ��', '��ü�� Ʋ���ϴ�. ��ǥ ��ȣ��  �� Ȯ�����ּ���')
	RETURN 0
END IF

IF Upper(ls_itemcode) <> Upper(dw_pisq110u_head.GetItemString(1, 'a_itemcode')) THEN
	MessageBox('Ȯ ��', 'ǰ���� Ʋ���ϴ�. ��ǥ ��ȣ��  �� Ȯ�����ּ���')
	RETURN 0
END IF

IF ll_supplierdeliveryqty <> dw_pisq110u_head.GetItemNumber(1, 'a_supplierdeliveryqty') THEN
	MessageBox('Ȯ ��', '��ǰ������ Ʋ���ϴ�. ��ǥ ��ȣ��  �� Ȯ�����ּ���')
	RETURN 0
END IF

// �˻������� �ʿ��� �⺻������ ��Ʈ�Ѵ�
//
dw_pisq110u_head.SetItem(1, 'a_InspectorCode', g_s_empno)
dw_pisq110u_head.SetItem(1, 'a_confirmcode'	, g_s_empno)
dw_pisq110u_head.SetItem(1, 'a_confirmflag'	, 'Y')
dw_pisq110u_head.SetItem(1, 'a_QCDate'			, String(f_getsysdatetime(), 'yyyy.mm.dd'))
dw_pisq110u_head.SetItem(1, 'a_QCTime'			, String(f_getsysdatetime(), 'hh:mm:ss'))
dw_pisq110u_head.SetItem(1, 'a_QCLeadTime'	, '0')
dw_pisq110u_head.SetItem(1, 'a_slno'			, ls_slnoall)
dw_pisq110u_head.SetItem(1, 'a_lastemp'		, 'Y')

// ��ǰ���ڸ� ���Ѵ�
//
SELECT DELIVERYDATE  
  INTO :ls_deliverydate
  FROM TQBUSINESSTEMP  
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SLNO				= :ls_slnoall
 USING SQLPIS;

ls_deliverydate = Mid(ls_deliverydate, 1, 4) + '.' + &
						Mid(ls_deliverydate, 5, 2) + '.' + &
						Mid(ls_deliverydate, 7, 2) 
dw_pisq110u_head.SetItem(1, 'a_deliverydate'	, ls_deliverydate)
dw_pisq110u_head.SetItem(1, 'a_deliverytime'	, '00:00:00')

//ls_deliverydatetime	= dw_pisq110u_head.GetItemString(1, 'a_deliverydate') + ' ' +&
//				  			  dw_pisq110u_head.GetItemString(1, 'a_deliverytime')
//
//ls_systemdatetime		= String(f_getsysdatetime(), 'yyyy.mm.dd') + ' ' +&
//							  String(f_getsysdatetime(), 'hh:mm:ss')
//

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// HEAD������ �����Ѵ�
//
li_save = dw_pisq110u_head.Update()

IF li_save <> 1 THEN
	ls_message = 'ó���� �����߽��ϴ�'
	goto Rollback_
END IF

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
if is_qcgubun = 'Q' then
	//���˻� ��� ǰ��ó��
	DELETE FROM TQBUSINESSTEMP  
			WHERE TQBUSINESSTEMP.AREACODE		 = :ls_AreaCode
			  AND	TQBUSINESSTEMP.DIVISIONCODE = :ls_DivisionCode
			  AND	TQBUSINESSTEMP.SLNO			 = :ls_slnoall
	USING SQLPIS;
	
	if sqlpis.sqlcode <> 0 then
		ls_message = '�ŷ���ǥ TEMP ���� ó���� �����߽��ϴ�'
		goto Rollback_
	end if
else
	dw_interface.reset()
	li_currow = dw_interface.insertrow(0)
	dw_interface.setitem(li_currow,"logid",li_currow)
	dw_interface.setitem(li_currow,"areacode",ls_areacode)
	dw_interface.setitem(li_currow,"divisioncode",ls_divisioncode)
	dw_interface.setitem(li_currow,"slno",ls_slnoall)
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
		AND SLNO				= :ls_slnoall
	using sqlpis;
	if sqlpis.sqlcode <> 0 then
		ls_message = '�ŷ���ǥ TEMP ���� ó���� �����߽��ϴ�'
		goto Rollback_
	end if
end if

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

type dw_pisq110u_kb from datawindow within w_pisq110u
integer x = 1842
integer y = 652
integer width = 549
integer height = 336
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq110u_03"
boolean vscrollbar = true
boolean livescroll = true
end type

event losefocus;//
//Long	ll_receptionqty, ll_kbcount, ll_goodqty, ll_badqty = 0, ll_cnt 
//Long	ll_supplierdeliveryqty, ll_tqqcresult_as_kbcount
//
//dw_pisq110u_kb.AcceptText()
//
//FOR ll_cnt = 1 TO dw_pisq110u_kb.RowCount()
//	// �����/�ż��� ���Ѵ�
//	//
//	ll_receptionqty = dw_pisq110u_kb.GetItemNumber(ll_cnt, 'receptionqty')
//	ll_kbcount		 = dw_pisq110u_kb.GetItemNumber(ll_cnt, 'kbcount')
//
//	// �Ѱ��Ǹż��� ���Ѵ�
//	//
//	//ll_tqqcresult_as_kbcount = ll_tqqcresult_as_kbcount + ll_kbcount
//
//	// ���հݼ����� ����Ѵ�
//	//
//	ll_badqty = ll_badqty + (ll_receptionqty * ll_kbcount)
//NEXT
//
//// ��ǰ������ ���Ѵ�
////
//ll_supplierdeliveryqty = dw_pisq110u_head.GetItemNumber(1, 'a_as_supplierdeliveryqty')
//
//// HEAD�� �հ�/���հݼ����� ��Ʈ�Ѵ�
////
//dw_pisq110u_head.SetItem(1, 'a_goodqty', ll_supplierdeliveryqty - ll_badqty)	// ��ǰ���� - ���հݼ���
//dw_pisq110u_head.SetItem(1, 'a_badqty' , ll_badqty)
//
//// HEAD�� �ҷ����Ǹż��� ��Ʈ�Ѵ�
////
////dw_pisq110u_head.SetItem(1, 'tqqcresult_as_kbcount', ll_tqqcresult_as_kbcount)
//
end event

type cb_detailsave from commandbutton within w_pisq110u
integer x = 4128
integer y = 1000
integer width = 448
integer height = 288
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���γ�������"
end type

event clicked;
Int		li_save, li_idx
String	ls_judgeflag, ls_badreason, ls_supplierlotno, ls_kdacremark
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode

dw_pisq110u_head.AcceptText()

ls_supplierlotno = dw_pisq110u_head.GetItemString(1, 'as_supplierlotno')

// ����ø��� ����� LOT NO�� ARRAY�� �����Ѵ�
// 
FOR li_idx = 1 TO 25
	IF f_checknullorspace(is_array_lotno[li_idx]) = TRUE THEN
		is_array_lotno[li_idx] = ls_supplierlotno
		// ����� LOT NO�� �����Ѵ�
		//
		il_array_cnt ++
		EXIT
	END IF
	
	IF is_array_lotno[li_idx] = ls_supplierlotno THEN
		EXIT
	END IF
NEXT

// �˻缺���� ���γ����� X,R,S�� ����Ͽ� ȭ�鿡 ǥ��
//
wf_xrscalc()

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// �˻缺���� ���γ��� ������ �����Ѵ�
//
li_save = dw_pisq110u_detail.Update()

IF li_save <> 1 THEN
	// RollBack ó��
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN 0
END IF

// �˻缺������ ����븸�� �����Ѵ�
//
ls_AreaCode			= dw_pisq110u_head.GetItemString(1, "a_AreaCode")
ls_DivisionCode	= dw_pisq110u_head.GetItemString(1, "a_DivisionCode")
ls_SupplierCode	= dw_pisq110u_head.GetItemString(1, "a_SupplierCode")
ls_DeliveryNo		= dw_pisq110u_head.GetItemString(1, "a_DeliveryNo")
ls_ItemCode			= dw_pisq110u_head.GetItemString(1, "a_ItemCode")
ls_kdacremark 		= dw_pisq110u_head.GetItemString(1, 'a_kdacremark')

UPDATE TQQCRESULT 
	SET KDACREMARK		= :ls_kdacremark
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND DELIVERYNO		= :ls_DeliveryNo
	AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;

SQLPIS.AUTOCommit = TRUE

MessageBox('Ȯ��','���γ����� ����Ǿ����ϴ�.')
return 0
// ������ �Ϸ�Ǹ� ó���� �����Ѵ�
//
//cb_exit.TriggerEvent( Clicked! )

end event

type dw_stdev from datawindow within w_pisq110u
boolean visible = false
integer x = 1582
integer width = 1472
integer height = 200
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_stdev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_interface from datawindow within w_pisq110u
boolean visible = false
integer x = 2693
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

type gb_1 from groupbox within w_pisq110u
integer x = 14
integer y = 224
integer width = 4645
integer height = 2224
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

type gb_2 from groupbox within w_pisq110u
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

