$PBExportHeader$w_pisq040i.srw
$PBExportComments$�˻���ؼ� ��ȸ �� ���(��ȸ)
forward
global type w_pisq040i from w_ipis_sheet01
end type
type dw_pisq040i from u_vi_std_datawindow within w_pisq040i
end type
type uo_area from u_pisc_select_area within w_pisq040i
end type
type uo_division from u_pisc_select_division within w_pisq040i
end type
type st_3 from statictext within w_pisq040i
end type
type sle_suppliercode from singlelineedit within w_pisq040i
end type
type sle_suppliername from singlelineedit within w_pisq040i
end type
type st_4 from statictext within w_pisq040i
end type
type cb_print from commandbutton within w_pisq040i
end type
type uo_date from u_pisc_date_applydate within w_pisq040i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq040i
end type
type rb_consert from radiobutton within w_pisq040i
end type
type rb_return from radiobutton within w_pisq040i
end type
type rb_all from radiobutton within w_pisq040i
end type
type pb_serch from picturebutton within w_pisq040i
end type
type st_5 from statictext within w_pisq040i
end type
type sle_itemcode from singlelineedit within w_pisq040i
end type
type sle_itemname from singlelineedit within w_pisq040i
end type
type pb_serch2 from picturebutton within w_pisq040i
end type
type cb_image from commandbutton within w_pisq040i
end type
type cb_imageend from commandbutton within w_pisq040i
end type
type gb_1 from groupbox within w_pisq040i
end type
type p_image from picture within w_pisq040i
end type
type cb_fullimage from commandbutton within w_pisq040i
end type
end forward

global type w_pisq040i from w_ipis_sheet01
integer width = 4690
integer height = 2848
string title = "�˻���ؼ� ������Ȳ"
dw_pisq040i dw_pisq040i
uo_area uo_area
uo_division uo_division
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
st_4 st_4
cb_print cb_print
uo_date uo_date
uo_dateto uo_dateto
rb_consert rb_consert
rb_return rb_return
rb_all rb_all
pb_serch pb_serch
st_5 st_5
sle_itemcode sle_itemcode
sle_itemname sle_itemname
pb_serch2 pb_serch2
cb_image cb_image
cb_imageend cb_imageend
gb_1 gb_1
p_image p_image
cb_fullimage cb_fullimage
end type
global w_pisq040i w_pisq040i

type variables

str_pisr_partkb istr_partkb

end variables

forward prototypes
public subroutine wf_imagechange ()
end prototypes

public subroutine wf_imagechange ();
blob lb_gyoid_pic, lb_pic 
Int  li_FileNo, li_FileNum, l_n_chk_loops, l_n_mod, l_n_int
long ll_pic = 1, ll_length

String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno

ls_AreaCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_StandardRevno")

selectblob drawingname 
		into :lb_gyoid_pic 
   	from TQQcStandard
	  where areacode 		= :ls_areacode
		 and divisioncode	= :ls_divisioncode
		 and suppliercode	= :ls_suppliercode
		 and itemcode		= :ls_itemcode
		 and standardrevno= :ls_standardrevno
	  using sqlpis;

IF SQLPIS.SQLCode <> 0 THEN
	RETURN 	
END IF

ll_length = Len(lb_gyoid_pic)

IF ll_length = 0 OR IsNull(ll_length) THEN
	RETURN 	
END IF

ll_pic =1
//�ӽ������� ��� �۾��� �غ�
//
//li_FileNo = FileOpen("C:\kdac_ipis\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)
li_FileNo = FileOpen("c:\kdac\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)


l_n_chk_loops = ll_length / 32765
l_n_mod   = mod(ll_length, 32765)
if l_n_chk_loops > 0 then
	for l_n_int = 1 to l_n_chk_loops
		lb_pic = blobmid( lb_gyoid_pic, ((l_n_int - 1) * 32765) + 1, 32765)
		filewrite(li_fileno, lb_pic) 
	next
	if l_n_mod > 0 then
		lb_pic = blobmid( lb_gyoid_pic, l_n_chk_loops * 32765 + 1, l_n_mod)
		filewrite(li_fileno, lb_pic) 
	end if
else
	if l_n_mod > 0 then
		lb_pic = blobmid(lb_gyoid_pic, 1, l_n_mod)
		filewrite(li_fileno, lb_pic)
	end if
end if

//IF li_FileNo > 0 Then 
//	DO   
//	  lb_pic=blobmid(lb_gyoid_pic, ll_pic, 32765)
//	  FileWrite(li_FileNo, lb_pic) 
//	  ll_pic = ll_pic + 32765 
//	LOOP UNTIL long(lb_pic) = 0 
//End IF 
FileClose(li_FileNo)

end subroutine

on w_pisq040i.create
int iCurrent
call super::create
this.dw_pisq040i=create dw_pisq040i
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.st_4=create st_4
this.cb_print=create cb_print
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.rb_consert=create rb_consert
this.rb_return=create rb_return
this.rb_all=create rb_all
this.pb_serch=create pb_serch
this.st_5=create st_5
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.pb_serch2=create pb_serch2
this.cb_image=create cb_image
this.cb_imageend=create cb_imageend
this.gb_1=create gb_1
this.p_image=create p_image
this.cb_fullimage=create cb_fullimage
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq040i
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_suppliercode
this.Control[iCurrent+6]=this.sle_suppliername
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.cb_print
this.Control[iCurrent+9]=this.uo_date
this.Control[iCurrent+10]=this.uo_dateto
this.Control[iCurrent+11]=this.rb_consert
this.Control[iCurrent+12]=this.rb_return
this.Control[iCurrent+13]=this.rb_all
this.Control[iCurrent+14]=this.pb_serch
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.sle_itemcode
this.Control[iCurrent+17]=this.sle_itemname
this.Control[iCurrent+18]=this.pb_serch2
this.Control[iCurrent+19]=this.cb_image
this.Control[iCurrent+20]=this.cb_imageend
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.p_image
this.Control[iCurrent+23]=this.cb_fullimage
end on

on w_pisq040i.destroy
call super::destroy
destroy(this.dw_pisq040i)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.st_4)
destroy(this.cb_print)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.rb_consert)
destroy(this.rb_return)
destroy(this.rb_all)
destroy(this.pb_serch)
destroy(this.st_5)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.pb_serch2)
destroy(this.cb_image)
destroy(this.cb_imageend)
destroy(this.gb_1)
destroy(this.p_image)
destroy(this.cb_fullimage)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq040i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_enactmentdate_fm, ls_enactmentdate_to
String	ls_SupplierCode, ls_itemcode, ls_chkflag

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode				= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode		= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_enactmentdate_fm	= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_enactmentdate_to	= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')
ls_SupplierCode		= sle_suppliercode.Text + '%'
ls_itemcode				= sle_itemcode.Text + '%'

IF rb_consert.Checked THEN
	ls_chkflag = '2'
END IF
IF rb_return.Checked THEN
	ls_chkflag = '1'
END IF
IF rb_all.Checked THEN
	ls_chkflag = '%'
END IF

ls_enactmentdate_fm	= '0000.00.00'
ls_enactmentdate_to	= '9999.12.31'

// ���ڸ� �Է����� ������ �ּ����ڸ� ��Ʈ�Ѵ�
//
IF f_checknullorspace(ls_enactmentdate_fm) = TRUE THEN
	ls_enactmentdate_fm	= '0000.00.00'
END IF

// ���ڸ� �Է����� ������ �ִ����ڸ� ��Ʈ�Ѵ�
//
IF f_checknullorspace(ls_enactmentdate_to) = TRUE THEN
	ls_enactmentdate_to	= '9999.12.31'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq040i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate_fm, ls_enactmentdate_to, ls_SupplierCode, ls_itemcode, ls_chkflag)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq040i, 1, True)	




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


end event

event ue_postopen;call super::ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq040i.SetTransObject(SQLPIS)

uo_date.st_name.Text	= '������:'

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq040i.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq040i
integer x = 18
integer width = 3598
end type

type dw_pisq040i from u_vi_std_datawindow within w_pisq040i
integer x = 18
integer y = 292
integer width = 3589
integer height = 1596
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq040i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	cb_print.TriggerEvent(Clicked!)
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno

// �ʿ��� ������ ���Ѵ�
//
ls_AreaCode					= dw_pisq040i.GetItemString(currentrow, "as_AreaCode")
ls_DivisionCode			= dw_pisq040i.GetItemString(currentrow, "as_DivisionCode")
ls_SupplierCode			= dw_pisq040i.GetItemString(currentrow, "as_SupplierCode")
ls_ItemCode					= dw_pisq040i.GetItemString(currentrow, "as_ItemCode")
ls_StandardRevno			= dw_pisq040i.GetItemString(currentrow, "as_StandardRevno")

// �൵������ �����Ͽ� ��ư�� ó���Ѵ�
//
IF f_checkimage(ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno) THEN
	cb_fullimage.Enabled	= TRUE
	cb_image.Enabled		= TRUE
	cb_imageend.Enabled	= TRUE
ELSE
	cb_fullimage.Enabled	= FALSE
	cb_image.Enabled		= FALSE
	cb_imageend.Enabled	= FALSE
END IF
end event

type uo_area from u_pisc_select_area within w_pisq040i
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
dw_pisq040i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq040i
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
dw_pisq040i.SetTransObject(SQLPIS)


end event

type st_3 from statictext within w_pisq040i
integer x = 983
integer y = 180
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

type sle_suppliercode from singlelineedit within w_pisq040i
integer x = 1285
integer y = 168
integer width = 425
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

type sle_suppliername from singlelineedit within w_pisq040i
integer x = 1714
integer y = 168
integer width = 873
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

type st_4 from statictext within w_pisq040i
boolean visible = false
integer x = 3529
integer y = 72
integer width = 46
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "~~"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_pisq040i
integer x = 4146
integer y = 48
integer width = 453
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���ؼ� ���"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno
String	ls_SanctionCode, ls_ChargeConsertFlag, ls_SanctionConsertFlag

// ��´���� ������ ó���� ���� �ʴ´�
//
IF dw_pisq040i.GetSelectedRow(0) = 0 THEN
	MessageBox('Ȯ ��', '��´���� �����ϴ�', StopSign!)
	RETURN
END IF

// ���ؼ���¿� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode					= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode					= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_StandardRevno")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_ItemCode
istr_parms.String_arg[5] = ls_StandardRevno

// �˻���ؼ� ����ȭ�� ����
//
OpenWithParm(w_pisq040p, istr_parms)

end event

type uo_date from u_pisc_date_applydate within w_pisq040i
event destroy ( )
boolean visible = false
integer x = 2862
integer y = 60
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq040i
event destroy ( )
boolean visible = false
integer x = 3575
integer y = 60
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type rb_consert from radiobutton within w_pisq040i
integer x = 64
integer y = 160
integer width = 224
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "����"
end type

type rb_return from radiobutton within w_pisq040i
integer x = 288
integer y = 160
integer width = 224
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�ݼ�"
end type

type rb_all from radiobutton within w_pisq040i
integer x = 512
integer y = 160
integer width = 224
integer height = 92
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
boolean checked = true
end type

type pb_serch from picturebutton within w_pisq040i
integer x = 2587
integer y = 160
integer width = 238
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
string disabledname = "C:\kdac\bmp\not_search.gif"
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

type st_5 from statictext within w_pisq040i
integer x = 1097
integer y = 72
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

type sle_itemcode from singlelineedit within w_pisq040i
integer x = 1285
integer y = 60
integer width = 425
integer height = 72
integer taborder = 30
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

type sle_itemname from singlelineedit within w_pisq040i
integer x = 1714
integer y = 60
integer width = 873
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

type pb_serch2 from picturebutton within w_pisq040i
integer x = 2587
integer y = 56
integer width = 238
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
string disabledname = "C:\kdac\bmp\not_search.gif"
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

type cb_image from commandbutton within w_pisq040i
integer x = 3675
integer y = 156
integer width = 453
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���麸��"
end type

event clicked;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno

ls_areacode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_areacode')
ls_divisioncode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_divisioncode')
ls_suppliercode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_suppliercode')
ls_itemcode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_itemcode')
ls_standardrevno	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_standardrevno')

blob lb_pic

SetPointer(HourGlass!)

p_image.Visible	= True
//p_image.x			= 59
//p_image.y			= 332
//p_image.Width		= 3557
//p_image.Height		= 1844

selectblob drawingname 
		into :lb_pic 
   	from TQQcStandard
	  where areacode 		= :ls_areacode
		 and divisioncode	= :ls_divisioncode
		 and suppliercode	= :ls_suppliercode
		 and itemcode		= :ls_itemcode
		 and standardrevno= :ls_standardrevno
	 using sqlpis;

p_image.Setpicture(lb_pic)

SetPointer(Arrow!)

end event

type cb_imageend from commandbutton within w_pisq040i
integer x = 4146
integer y = 156
integer width = 453
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����ݱ�"
end type

event clicked;
p_image.Visible	= FALSE

end event

type gb_1 from groupbox within w_pisq040i
integer x = 18
integer y = 12
integer width = 4613
integer height = 264
integer taborder = 110
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type p_image from picture within w_pisq040i
boolean visible = false
integer x = 27
integer y = 300
integer width = 4594
integer height = 2280
boolean border = true
boolean focusrectangle = false
end type

event clicked;
p_image.Visible = FALSE

end event

type cb_fullimage from commandbutton within w_pisq040i
integer x = 3154
integer y = 156
integer width = 503
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��ü���麸��"
end type

event clicked;integer li_rtn
// �ش� �̹����� �ҷ��´�
//
wf_imagechange()

li_rtn = Run("explorer c:\kdac\bmp\temp.jpg", Maximized!)

return 0


end event

