$PBExportHeader$w_pisq345i.srw
$PBExportComments$Warrantyǰ �м� SHEET ��Ȳ
forward
global type w_pisq345i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq345i
end type
type uo_division from u_pisc_select_division within w_pisq345i
end type
type dw_pisq345i_01 from u_vi_std_datawindow within w_pisq345i
end type
type gb_2 from groupbox within w_pisq345i
end type
type uo_custcode from u_piss_select_custcode within w_pisq345i
end type
type st_8 from statictext within w_pisq345i
end type
type uo_scustgubun from u_pisc_select_code within w_pisq345i
end type
type gb_3 from groupbox within w_pisq345i
end type
type st_2 from statictext within w_pisq345i
end type
type cb_saveas from commandbutton within w_pisq345i
end type
type cbx_all from checkbox within w_pisq345i
end type
type uo_dateto from u_pisc_date_applydate within w_pisq345i
end type
type uo_date from u_pisc_date_applydate within w_pisq345i
end type
end forward

global type w_pisq345i from w_ipis_sheet01
integer width = 4933
integer height = 2784
string title = "Warrantyǰ �м� SHEET ��Ȳ"
uo_area uo_area
uo_division uo_division
dw_pisq345i_01 dw_pisq345i_01
gb_2 gb_2
uo_custcode uo_custcode
st_8 st_8
uo_scustgubun uo_scustgubun
gb_3 gb_3
st_2 st_2
cb_saveas cb_saveas
cbx_all cbx_all
uo_dateto uo_dateto
uo_date uo_date
end type
global w_pisq345i w_pisq345i

type variables


string is_custgubun,is_custcode
datawindowchild	idwc_warrantycode
Boolean	ib_open

end variables

on w_pisq345i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq345i_01=create dw_pisq345i_01
this.gb_2=create gb_2
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.gb_3=create gb_3
this.st_2=create st_2
this.cb_saveas=create cb_saveas
this.cbx_all=create cbx_all
this.uo_dateto=create uo_dateto
this.uo_date=create uo_date
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq345i_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.uo_custcode
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.uo_scustgubun
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cb_saveas
this.Control[iCurrent+11]=this.cbx_all
this.Control[iCurrent+12]=this.uo_dateto
this.Control[iCurrent+13]=this.uo_date
end on

on w_pisq345i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq345i_01)
destroy(this.gb_2)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.gb_3)
destroy(this.st_2)
destroy(this.cb_saveas)
destroy(this.cbx_all)
destroy(this.uo_dateto)
destroy(this.uo_date)
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
String	ls_areacode, ls_divisioncode, ls_datefm, ls_dateto, ls_customercode

// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_datefm			= uo_date.sle_date.Text
ls_dateto			= uo_dateto.sle_date.Text
ls_customercode	= is_custcode

// ��ü�� ���õǸ�
//
IF cbx_all.Checked = TRUE THEN
	ls_customercode = '%'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq345i_01.Retrieve(ls_areacode, ls_divisioncode, ls_datefm, ls_dateto, ls_customercode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq345i_01, 1, True)	


end event

event ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq345i_01.SetTransObject(SQLPIS)

// Child Datawindow ����(�м�����ڵ�)
//
dw_pisq345i_01.GetChild ('analyzecode' , idwc_warrantycode)

idwc_warrantycode.SetTransObject( SQLPIS )

uo_date.st_name.Text	= '�м���:'

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
ib_open = True
end event

event activate;
// Ʈ������� �����Ѵ�
//
dw_pisq345i_01.SetTransObject(SQLPIS)
idwc_warrantycode.SetTransObject( SQLPIS )

String ls_codegroup, ls_codegroupname, ls_codename
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',FALSE,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq345i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq345i
integer x = 41
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

If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
End If

// Ʈ������� �����Ѵ�
//
dw_pisq345i_01.SetTransObject(SQLPIS)
idwc_warrantycode.SetTransObject( SQLPIS )

end event

event ue_post_constructor;call super::ue_post_constructor;
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

//string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
//datawindow 	ldw_division
//ldw_division = uo_division.dw_1
//ls_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
//

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq345i
event destroy ( )
integer x = 512
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
dw_pisq345i_01.SetTransObject(SQLPIS)
idwc_warrantycode.SetTransObject( SQLPIS )

//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		:	f_pisc_retrieve_dddw_productgroup
////	Access		:	public
////	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
////						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
////						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
////						string			fs_productgroup		��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
////						boolean			fb_allflag				��ȸ�� ��ǰ�� ������ 2�� �̻��� Record �� ���
////																		True : '��ü' �׸� ���� (��ǰ���ڵ�� '%', ��ǰ������ '��ü')
////																		False : '��ü' �׸� �� ����
////						string			rs_productgroup		���õ� ��ǰ�� �ڵ� (reference)
////						string			rs_productgroupname	���õ� ��ǰ�� �� (reference)
////	Returns		: none
////	Description	: ��ǰ���� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Kim Jin-Su
//// Coded Date	: 2002.09.04
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//If ib_open Then
//	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											'%', &
//											True, &
//											uo_productgroup.is_uo_productgroup, &
//											uo_productgroup.is_uo_productgroupname)
//											
//	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_productgroup.is_uo_productgroup, &
//											'%', &
//											True, &
//											uo_modelgroup.is_uo_modelgroup, &
//											uo_modelgroup.is_uo_modelgroupname)
//
////	iw_this.TriggerEvent("ue_reset")
//End If
//
//
//
end event

type dw_pisq345i_01 from u_vi_std_datawindow within w_pisq345i
integer x = 50
integer y = 216
integer width = 4530
integer height = 2336
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisq345i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;
String	ls_colname, ls_coldata
String	ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode, ls_itemcode, ls_smallgroupname

// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// �м��ڵ带 �Է��ϸ� �ش���� �����´�
	//
	CASE 'analyzecode'
		SELECT A.SMALLGROUPNAME  
		  INTO :ls_smallgroupname
		  FROM TQWARRANTYSMALL A
		 WHERE A.AREACODE			= :ls_areacode
		   AND A.DIVISIONCODE	= :ls_DivisionCode
			AND A.LARGEGROUPCODE	= SUBSTRING(:ls_coldata, 1, 1)
			AND A.MIDDLEGROUPCODE= SUBSTRING(:ls_coldata, 2, 1)
			AND A.SMALLGROUPCODE	= SUBSTRING(:ls_coldata, 3, 2)
		USING SQLPIS;

		IF SQLPIS.SQLCode = 0 THEN
			This.Setitem(row, 'smallgroupname', ls_smallgroupname)
		ELSE
			MessageBox('Ȯ ��', '�ش��ڵ�� �̵�� �ڵ��Դϴ�', StopSign!)
			This.SetColumn('analyzecode')
			This.SetFocus()
			RETURN 1
		END IF

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

type gb_2 from groupbox within w_pisq345i
integer x = 18
integer y = 12
integer width = 4594
integer height = 164
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_custcode from u_piss_select_custcode within w_pisq345i
event destroy ( )
integer x = 3035
integer y = 64
integer width = 987
integer taborder = 50
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
//dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode


end event

type st_8 from statictext within w_pisq345i
integer x = 2203
integer y = 72
integer width = 160
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "����:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq345i
event destroy ( )
integer x = 2368
integer y = 64
integer taborder = 40
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event constructor;call super::constructor;postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)
//dw_sheet.reset()

end event

event ue_post_constructor;
string ls_custname
//is_custgubun = is_uo_codeid

f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)


end event

type gb_3 from groupbox within w_pisq345i
integer x = 23
integer y = 184
integer width = 4594
integer height = 2388
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

type st_2 from statictext within w_pisq345i
integer x = 1719
integer y = 68
integer width = 46
integer height = 52
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type cb_saveas from commandbutton within w_pisq345i
integer x = 4270
integer y = 44
integer width = 311
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��������"
end type

event clicked;
//dw_pisq345i_01.SaveAs()
f_save_to_excel_number(dw_pisq345i_01)
end event

type cbx_all from checkbox within w_pisq345i
integer x = 4027
integer y = 68
integer width = 201
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��ü"
boolean lefttext = true
end type

type uo_dateto from u_pisc_date_applydate within w_pisq345i
event destroy ( )
integer x = 1531
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate::destroy
end on

type uo_date from u_pisc_date_applydate within w_pisq345i
event destroy ( )
integer x = 1047
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

