$PBExportHeader$w_pisq925i.srw
$PBExportComments$�˻缺���� ���γ��� ��Ȳ
forward
global type w_pisq925i from w_ipis_sheet01
end type
type dw_pisq925i_01 from datawindow within w_pisq925i
end type
type gb_1 from groupbox within w_pisq925i
end type
type gb_3 from groupbox within w_pisq925i
end type
type cb_print from commandbutton within w_pisq925i
end type
type cb_exit from commandbutton within w_pisq925i
end type
type cb_save from commandbutton within w_pisq925i
end type
type dw_stdev from datawindow within w_pisq925i
end type
end forward

global type w_pisq925i from w_ipis_sheet01
integer width = 4663
integer height = 2700
string title = "�˻缺���� ���γ��� ��Ȳ"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq925i_01 dw_pisq925i_01
gb_1 gb_1
gb_3 gb_3
cb_print cb_print
cb_exit cb_exit
cb_save cb_save
dw_stdev dw_stdev
end type
global w_pisq925i w_pisq925i

type variables

String	is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_deliveryno

end variables

on w_pisq925i.create
int iCurrent
call super::create
this.dw_pisq925i_01=create dw_pisq925i_01
this.gb_1=create gb_1
this.gb_3=create gb_3
this.cb_print=create cb_print
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.dw_stdev=create dw_stdev
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq925i_01
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_exit
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.dw_stdev
end on

on w_pisq925i.destroy
call super::destroy
destroy(this.dw_pisq925i_01)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.cb_print)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.dw_stdev)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq040p_head, FULL)
//
//of_resize()
//
end event

event open;call super::open;
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

is_areacode			= istr_parms.String_arg[1]
is_divisioncode	= istr_parms.String_arg[2]
is_suppliercode	= istr_parms.String_arg[3]
is_deliveryno		= istr_parms.String_arg[4]
is_itemcode			= istr_parms.String_arg[5]

dw_pisq925i_01.DataObject = 'd_pisq925i_01_update'
cb_save.Visible = TRUE

// �������� �������� ��ǥ�� �缳���Ѵ�
//
This.x = 1
This.y = 265

// �������� �������� Ÿ��Ʋ�� �缳���Ѵ�
//
this.title = 'w_pisq925ii(�˻缺���� ���γ��� ��Ȳ)'

// Ʈ������� �����Ѵ�
//
dw_pisq925i_01.SetTransObject(SQLPIS)

// ����ũ�� ������ ������ ��Ʈ�Ѵ�
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

event ue_postopen;
// �ڷḦ ��ȸ�Ѵ�
//
dw_pisq925i_01.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_deliveryno, is_itemcode)


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq925i
integer x = 41
integer y = 2208
integer width = 3602
end type

type dw_pisq925i_01 from datawindow within w_pisq925i
integer x = 37
integer y = 236
integer width = 4581
integer height = 2228
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq925i_01_update"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq925i
integer x = 14
integer y = 204
integer width = 4626
integer height = 2284
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisq925i
integer x = 14
integer width = 4626
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type cb_print from commandbutton within w_pisq925i
boolean visible = false
integer x = 2190
integer y = 56
integer width = 389
integer height = 112
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
//dw_pisq040p_01.Print()
//open(w_res_test)
end event

type cb_exit from commandbutton within w_pisq925i
integer x = 4197
integer y = 56
integer width = 389
integer height = 112
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

type cb_save from commandbutton within w_pisq925i
integer x = 3762
integer y = 56
integer width = 389
integer height = 112
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
String	ls_colname
Long		ll_row, ll_cnt, ll_incnt, ll_insrow, ll_save
Dec		ld_tot, ld_x, ld_r, ld_s, ld_max, ld_min, ld_qcmeasurementx = 0, ld_suppliermeasurementx = 0

IF dw_pisq925i_01.AcceptText() <> 1 THEN RETURN

// ���γ����� ���ڵ� �Ǽ���ŭ ����ó��(��ü ����ġ�� ǥ������ ���)
// 
FOR ll_row = 1 to dw_pisq925i_01.RowCount()
	ld_tot	= 0
	ll_incnt = 0
	ld_max	= 0
	ld_min	= 9999
	
	// ǥ���������� ����Ÿ�����츦 �����Ѵ�
	// 
	dw_stdev.ReSet()
	
	FOR ll_cnt = 1 TO 10
		ls_colname = 'tqqcresultdetail_suppliermeasurementx' + Trim(String(ll_cnt))
		ld_suppliermeasurementx = dw_pisq925i_01.GetItemNumber(ll_row, ls_colname)

		// ���� �ִ°͸��� ��������Ѵ�
		//
		IF ld_suppliermeasurementx > 0 THEN

			// ǥ���������� ����Ÿ�����쿡 ���� ��Ʈ�Ѵ�
			// 
			ll_insrow = dw_stdev.InsertRow(0)
			dw_stdev.SetItem(ll_insrow, 'an_stdev', ld_suppliermeasurementx)
	
			// MAX�� ���Ѵ�
			//
			IF ld_max < ld_suppliermeasurementx THEN
				ld_max = ld_suppliermeasurementx 
			END IF
				
			// MIN�� ���Ѵ�
			//
			IF ld_min > ld_suppliermeasurementx THEN
				ld_min = ld_suppliermeasurementx 
			END IF

			// ���� �ִ°��� ���� ����
			//
			ld_tot = ld_tot + ld_suppliermeasurementx
			// ���� �ִ°��� ����� ����
			//
			ll_incnt ++
		END IF
	NEXT

	IF ld_tot = 0 THEN
		// �Էµ� ���� ���� 0�ΰ��� �ʱ�ȭ�Ѵ�
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_suppliermeasurementx', 0)
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_suppliermeasurementr', 0)
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_suppliermeasurements', 0)
	ELSE
		// �Էµ� ���� �ִ� ��츸 ���� ����Ѵ�
		//
		ld_x = ld_tot / ll_incnt
		ld_r = ld_max - ld_min
		// X��Ʈ
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_suppliermeasurementx', ld_x)
		// R��Ʈ
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_suppliermeasurementr', ld_r)
		// S��Ʈ
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_suppliermeasurements', dw_stdev.GetItemNumber(1, 'stdev'))
	END IF
NEXT


// ���γ����� ���ڵ� �Ǽ���ŭ ����ó��(������ ����ġ�� ǥ������ ���)
// 
FOR ll_row = 1 to dw_pisq925i_01.RowCount()
	ld_tot	= 0
	ll_incnt = 0
	ld_max	= 0
	ld_min	= 9999
	
	// ǥ���������� ����Ÿ�����츦 �����Ѵ�
	// 
	dw_stdev.ReSet()
	
	FOR ll_cnt = 1 TO 10
		ls_colname = 'tqqcresultdetail_qcmeasurementx' + Trim(String(ll_cnt))
		ld_qcmeasurementx = dw_pisq925i_01.GetItemNumber(ll_row, ls_colname)

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
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementx', 0)
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementr', 0)
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurements', 0)
	ELSE
		// �Էµ� ���� �ִ� ��츸 ���� ����Ѵ�
		//
		ld_x = ld_tot / ll_incnt
		ld_r = ld_max - ld_min
		// X��Ʈ
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementx', ld_x)
		// R��Ʈ
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurementr', ld_r)
		// S��Ʈ
		//
		dw_pisq925i_01.SetItem(ll_row, 'tqqcresultdetail_qcmeasurements', dw_stdev.GetItemNumber(1, 'stdev'))
	END IF
NEXT

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// ���������� �����Ѵ�
//
ll_save = dw_pisq925i_01.Update()

IF ll_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN
END IF

MessageBox('Ȯ ��', 'ó���� �Ϸ�Ǿ����ϴ�')

end event

type dw_stdev from datawindow within w_pisq925i
boolean visible = false
integer x = 713
integer y = 4
integer width = 1472
integer height = 200
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_stdev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

