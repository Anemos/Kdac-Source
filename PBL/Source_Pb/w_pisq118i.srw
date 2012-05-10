$PBExportHeader$w_pisq118i.srw
$PBExportComments$Warningǰ����ȸ
forward
global type w_pisq118i from w_ipis_sheet01
end type
type dw_pisq118i_01 from u_vi_std_datawindow within w_pisq118i
end type
type uo_area from u_pisc_select_area within w_pisq118i
end type
type uo_division from u_pisc_select_division within w_pisq118i
end type
type cb_saveas from commandbutton within w_pisq118i
end type
type st_5 from statictext within w_pisq118i
end type
type st_3 from statictext within w_pisq118i
end type
type sle_suppliercode from singlelineedit within w_pisq118i
end type
type sle_itemcode from singlelineedit within w_pisq118i
end type
type sle_itemname from singlelineedit within w_pisq118i
end type
type sle_suppliername from singlelineedit within w_pisq118i
end type
type pb_serch from picturebutton within w_pisq118i
end type
type pb_serch2 from picturebutton within w_pisq118i
end type
type dw_exceldown from datawindow within w_pisq118i
end type
type gb_1 from groupbox within w_pisq118i
end type
end forward

global type w_pisq118i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "Warningǰ�� �����ȣ����"
dw_pisq118i_01 dw_pisq118i_01
uo_area uo_area
uo_division uo_division
cb_saveas cb_saveas
st_5 st_5
st_3 st_3
sle_suppliercode sle_suppliercode
sle_itemcode sle_itemcode
sle_itemname sle_itemname
sle_suppliername sle_suppliername
pb_serch pb_serch
pb_serch2 pb_serch2
dw_exceldown dw_exceldown
gb_1 gb_1
end type
global w_pisq118i w_pisq118i

type variables

str_pisr_partkb istr_partkb

end variables

on w_pisq118i.create
int iCurrent
call super::create
this.dw_pisq118i_01=create dw_pisq118i_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_saveas=create cb_saveas
this.st_5=create st_5
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.sle_suppliername=create sle_suppliername
this.pb_serch=create pb_serch
this.pb_serch2=create pb_serch2
this.dw_exceldown=create dw_exceldown
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq118i_01
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.cb_saveas
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_suppliercode
this.Control[iCurrent+8]=this.sle_itemcode
this.Control[iCurrent+9]=this.sle_itemname
this.Control[iCurrent+10]=this.sle_suppliername
this.Control[iCurrent+11]=this.pb_serch
this.Control[iCurrent+12]=this.pb_serch2
this.Control[iCurrent+13]=this.dw_exceldown
this.Control[iCurrent+14]=this.gb_1
end on

on w_pisq118i.destroy
call super::destroy
destroy(this.dw_pisq118i_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_saveas)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.sle_suppliername)
destroy(this.pb_serch)
destroy(this.pb_serch2)
destroy(this.dw_exceldown)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq118i_01, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_itemcode

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_SupplierCode	= sle_suppliercode.Text + '%'
ls_itemcode			= sle_itemcode.Text + '%'

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq118i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_itemcode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq118i_01, 1, True)	
 
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
f_icon_set(true , false, true,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )


end event

event ue_postopen;call super::ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq118i_01.SetTransObject(SQLPIS)

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq118i_01.SetTransObject(SQLPIS)

////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// ������ �������� �缳���Ѵ�
//
f_icon_set(true , false, true,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

event ue_save;call super::ue_save;long ll_rowcnt, ll_cnt
string ls_message, ls_gubun, ls_supprevno, ls_itemcode, ls_itemcheck

dw_pisq118i_01.accepttext()
ll_rowcnt = dw_pisq118i_01.rowcount()

ll_cnt = MessageBox("Ȯ��", "���õ� ǰ���� ����Rev.No(�������)�� ����Rev.No(�˻���ؼ�)�� �����Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2)
if ll_cnt = 2 then
	return 0
end if

setpointer(hourglass!)
sqlca.Autocommit = False
sqlpis.AutoCommit = False

for ll_cnt = 1 to ll_rowcnt
	ls_itemcheck = dw_pisq118i_01.getitemstring(ll_cnt,'itemcheck')
	if ls_itemcheck = 'Y' then
		ls_itemcode = dw_pisq118i_01.getitemstring(ll_cnt,'itemcode')
		ls_supprevno = dw_pisq118i_01.getitemstring(ll_cnt,'supprevno')		
		
		UPDATE PBINV.INV002
		SET Rvno = :ls_supprevno
		WHERE Comltd = '01' and Itno = :ls_itemcode
		using sqlca;
		
		if sqlca.sqlnrows < 1 then
			ls_message = "MIS ����⺻���� �����ÿ� ������ �߻��Ͽ����ϴ�."
			goto RollBack_
		end if	
		
		UPDATE TMSTITEM
		SET ItemRevno = :ls_supprevno
		WHERE ItemCode = :ls_itemcode
		using sqlpis;
		
		if sqlpis.sqlnrows < 1 then
			ls_message = "IPIS ����⺻���� �����ÿ� ������ �߻��Ͽ����ϴ�."
			goto RollBack_
		end if
	end if
next

Commit using sqlca;
Commit using sqlpis;
sqlca.AutoCommit = True
sqlpis.AutoCommit = True

This.TriggerEvent("ue_retrieve")
uo_status.st_message.text = "���� �⺻������ �����Ǿ����ϴ�."
return 0

RollBack_:
Rollback using sqlca;
Rollback using sqlpis;
sqlca.AutoCommit = True
sqlpis.AutoCommit = True

Messagebox("���","����ÿ� ������ �߻��Ͽ����ϴ�." + ls_message)

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq118i
integer x = 18
integer width = 3598
end type

type dw_pisq118i_01 from u_vi_std_datawindow within w_pisq118i
integer x = 18
integer y = 292
integer width = 3589
integer height = 1596
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_pisq118i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_colname, ls_supprevno
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'totalcheck_t' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		ls_supprevno = This.getitemstring(ll_cnt,"supprevno")
		if f_spacechk(ls_supprevno) <> -1 then
			This.setitem(ll_cnt,'itemcheck','Y')
		else
			This.setitem(ll_cnt,'itemcheck','N')
		end if
	next
	This.object.totalcheck_t.visible = False
	This.object.eachcheck_t.visible = True
elseif ls_colname = 'eachcheck_t' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'itemcheck','N')
	next
	This.object.totalcheck_t.visible = True
	This.object.eachcheck_t.visible = False
end if
end event

event itemchanged;call super::itemchanged;string ls_colname, ls_supprevno
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'itemcheck' then
	ls_supprevno = This.getitemstring(row,"supprevno")
	if f_spacechk(ls_supprevno) <> -1 then
		This.setitem(ll_cnt,'itemcheck','Y')
	else
		MessageBox("Ȯ��", "��ü Rev.No �� �������� �ʽ��ϴ�.")
		return 1
	end if
end if

return 0
end event

type uo_area from u_pisc_select_area within w_pisq118i
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
dw_pisq118i_01.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq118i
event destroy ( )
integer x = 544
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
dw_pisq118i_01.SetTransObject(SQLPIS)

end event

type cb_saveas from commandbutton within w_pisq118i
integer x = 3410
integer y = 88
integer width = 448
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������������"
end type

event clicked;f_save_to_excel_number(dw_pisq118i_01)

//long ll_rowcnt, ll_cnt, ll_chkrow = 0, ll_currow
//string ls_itemcode, ls_itemname, ls_itemspec, ls_itemrevno, ls_itemunit, ls_itemtype, ls_selchk
//
//uo_status.st_message.text = ""
//ll_rowcnt = dw_pisq118i.rowcount()
//
//dw_exceldown.reset()
//for ll_cnt = 1 to ll_rowcnt
//	ls_selchk = dw_pisq118i.getitemstring(ll_cnt,"itemcheck")
//	if ls_selchk = 'Y' then
//		ls_itemcode = dw_pisq118i.getitemstring(ll_cnt,"itemcode")
//		ls_itemname = dw_pisq118i.getitemstring(ll_cnt,"itemname")
//		ls_itemspec = dw_pisq118i.getitemstring(ll_cnt,"itemspec")
//		ls_itemrevno = dw_pisq118i.getitemstring(ll_cnt,"supprevno")
//		ls_itemunit = dw_pisq118i.getitemstring(ll_cnt,"itemunit")
//		ls_itemtype = dw_pisq118i.getitemstring(ll_cnt,"itemtype")
//		
//		ll_currow = dw_exceldown.insertrow(0)
//		dw_exceldown.setitem(ll_currow,"itemcode",ls_itemcode)
//		dw_exceldown.setitem(ll_currow,"itemname",ls_itemname)
//		dw_exceldown.setitem(ll_currow,"itemspec",ls_itemspec)
//		dw_exceldown.setitem(ll_currow,"itemrevno",ls_itemrevno)
//		dw_exceldown.setitem(ll_currow,"itemunit",ls_itemunit)
//		dw_exceldown.setitem(ll_currow,"itemtype",ls_itemtype)
//		
//		ll_chkrow = ll_chkrow + 1
//	end if
//next
//
//if ll_chkrow > 0 then
//	f_save_to_excel_number(dw_exceldown)
//else
//	uo_status.st_message.text = "�ٿ�ε��� ǰ���� ������ �ֽʽÿ�."
//end if
//


end event

type st_5 from statictext within w_pisq118i
integer x = 1618
integer y = 172
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "ǰ��:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq118i
integer x = 50
integer y = 172
integer width = 293
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
string text = "���¾�ü:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_suppliercode from singlelineedit within w_pisq118i
integer x = 352
integer y = 160
integer width = 320
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// ��ü���� ���Ѵ�
//
sle_suppliername.Text = f_getsuppliername(sle_suppliercode.Text)



end event

type sle_itemcode from singlelineedit within w_pisq118i
integer x = 1806
integer y = 160
integer width = 425
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;
sle_itemname.Text = f_getitemname(sle_itemcode.Text)

end event

type sle_itemname from singlelineedit within w_pisq118i
integer x = 2235
integer y = 160
integer width = 786
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_suppliername from singlelineedit within w_pisq118i
integer x = 677
integer y = 160
integer width = 663
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_serch from picturebutton within w_pisq118i
integer x = 1339
integer y = 152
integer width = 238
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag		= 2			//���־�ü(����,����)
istr_partkb.remark	= sle_suppliercode.Text

OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_suppliercode.Text = lstr_Rtn.code
sle_suppliername.Text = lstr_Rtn.name


end event

type pb_serch2 from picturebutton within w_pisq118i
integer x = 3026
integer y = 152
integer width = 238
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag = 2			// ��üǰ��
OpenWithParm ( w_pisr013i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_itemcode.Text = lstr_Rtn.code
sle_itemname.Text = lstr_Rtn.name

end event

type dw_exceldown from datawindow within w_pisq118i
boolean visible = false
integer x = 3648
integer y = 300
integer width = 279
integer height = 400
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_pisq118i_01_down"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq118i
integer x = 18
integer y = 12
integer width = 3909
integer height = 264
integer taborder = 130
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

