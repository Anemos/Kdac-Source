$PBExportHeader$w_pisq040p.srw
$PBExportComments$�˻���ؼ� ��ȸ �� ���(���)
forward
global type w_pisq040p from w_ipis_sheet01
end type
type dw_pisq040p_01 from datawindow within w_pisq040p
end type
type gb_1 from groupbox within w_pisq040p
end type
type gb_3 from groupbox within w_pisq040p
end type
type cb_print from commandbutton within w_pisq040p
end type
type cb_exit from commandbutton within w_pisq040p
end type
type dw_image from datawindow within w_pisq040p
end type
end forward

global type w_pisq040p from w_ipis_sheet01
integer width = 4699
integer height = 2804
string title = "�˻���ؼ� ���"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq040p_01 dw_pisq040p_01
gb_1 gb_1
gb_3 gb_3
cb_print cb_print
cb_exit cb_exit
dw_image dw_image
end type
global w_pisq040p w_pisq040p

type variables

String	is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno

end variables

forward prototypes
public subroutine wf_imagechange ()
end prototypes

public subroutine wf_imagechange ();
blob lb_gyoid_pic, lb_pic 
Int  li_FileNo, li_FileNum, l_n_chk_loops, l_n_mod, l_n_int
long ll_pic = 1, ll_length, ll_sumlen

// ������ �⺻���� �Ⱥ��̰� �Ѵ�
//
dw_pisq040p_01.object.p_1.Visible = TRUE

selectblob drawingname 
		into :lb_gyoid_pic 
   	from TQQcStandard
	  where areacode 		= :is_areacode
		 and divisioncode	= :is_divisioncode
		 and suppliercode	= :is_suppliercode
		 and itemcode		= :is_itemcode
		 and standardrevno= :is_standardrevno
	  using sqlpis;

IF SQLPIS.SQLCode <> 0 THEN
	RETURN 	
END IF

//dw_pisq040p_01.Object.p_1.FileName(lb_gyoid_pic)

ll_length = Len(lb_gyoid_pic)

IF ll_length = 0 OR IsNull(ll_length) THEN
	RETURN 	
END IF

// �������� �����϶��� ���̰��Ѵ�
//
dw_pisq040p_01.object.p_1.Visible = TRUE

ll_pic =1
//�ӽ������� ��� �۾��� �غ�
//
//li_FileNo = FileOpen("C:\kdac_ipis\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)
li_FileNo = FileOpen("C:\kdac\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)

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
//	  	lb_pic=blobmid(lb_gyoid_pic, ll_pic, 32765)
//	  	If f_spacechk( String(lb_pic) ) = -1 then
//			Exit
//		End If
//	  	FileWrite(li_FileNo, lb_pic) 
//	  	ll_pic = ll_pic + 32765 
//	LOOP UNTIL long(lb_pic) = 0 
//End IF

li_fileno = FileClose(li_FileNo)
return

end subroutine

on w_pisq040p.create
int iCurrent
call super::create
this.dw_pisq040p_01=create dw_pisq040p_01
this.gb_1=create gb_1
this.gb_3=create gb_3
this.cb_print=create cb_print
this.cb_exit=create cb_exit
this.dw_image=create dw_image
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq040p_01
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_exit
this.Control[iCurrent+6]=this.dw_image
end on

on w_pisq040p.destroy
call super::destroy
destroy(this.dw_pisq040p_01)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.cb_print)
destroy(this.cb_exit)
destroy(this.dw_image)
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
is_itemcode			= istr_parms.String_arg[4]
is_standardrevno	= istr_parms.String_arg[5]

// �������� �������� ��ǥ�� �缳���Ѵ�
//
This.x = 1
This.y = 265

// �������� �������� Ÿ��Ʋ�� �缳���Ѵ�
//
this.title = 'w_pisq040p(�˻���ؼ� ���)'

// Ʈ������� �����Ѵ�
//
dw_pisq040p_01.SetTransObject(SQLPIS)
dw_image.SetTransObject(SQLPIS)

// ����ũ�� ������ ������ ��Ʈ�Ѵ�
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

event ue_postopen;
// �ش� �̹����� �ҷ��´�
//
wf_imagechange()

// �ڷḦ ��ȸ�Ѵ�
//
dw_pisq040p_01.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno)
//dw_image.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno)


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq040p
integer x = 41
integer y = 2208
integer width = 3602
end type

type dw_pisq040p_01 from datawindow within w_pisq040p
integer x = 37
integer y = 236
integer width = 4581
integer height = 2328
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq040p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;
String	ls_qcconceptionreference
Long		ll_idx

ls_qcconceptionreference = dw_pisq040p_01.GetItemString(1, 'qcconceptionreference')

// �˻� �� �������� �� ©���Ƿ� �ݾ� ������ ǥ���Ѵ�
// ���� ������ �ڷκ��� ���� �����̽��� ���� ������ ��Ȱ��ġ�� �Ѵ�
//
//IF Len(ls_qcconceptionreference) > 90 THEN
//	FOR ll_idx = 90 TO 1 STEP -1
//		IF f_checknullorspace(Mid(ls_qcconceptionreference, ll_idx, 1)) = TRUE THEN
//			dw_pisq040p_01.SetItem(1, 'qcconceptionreference', &
//											  Mid(ls_qcconceptionreference, 1, ll_idx ))
//			dw_pisq040p_01.SetItem(1, 'as_qcconceptionreference', &
//											  Mid(ls_qcconceptionreference, (ll_idx + 1), 150 - (ll_idx + 1)))
//			EXIT
//		END IF
//	NEXT
//END IF


end event

type gb_1 from groupbox within w_pisq040p
integer x = 14
integer y = 204
integer width = 4631
integer height = 2388
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

type gb_3 from groupbox within w_pisq040p
integer x = 14
integer width = 4631
integer height = 200
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
end type

type cb_print from commandbutton within w_pisq040p
integer x = 3785
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
dw_pisq040p_01.Print()

// �൵�� ������ �൵��� ����
//
IF f_checkimage(is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno) = TRUE THEN
	IF MessageBox('Ȯ ��', '������ �൵ ����� �Ͻðڽ��ϱ�?', Exclamation!, OKCancel!, 2) = 1 THEN
		dw_image.Print()
	END IF
END IF

//open(w_res_test)
end event

type cb_exit from commandbutton within w_pisq040p
integer x = 4215
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

type dw_image from datawindow within w_pisq040p
boolean visible = false
integer x = 1161
integer y = 172
integer width = 1751
integer height = 1348
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq040p_01_image"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

