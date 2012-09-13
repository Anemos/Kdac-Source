$PBExportHeader$w_pisq030u.srw
$PBExportComments$�˻���ؼ� ����
forward
global type w_pisq030u from w_ipis_sheet01
end type
type dw_pisq030u_detail from u_vi_std_datawindow within w_pisq030u
end type
type dw_pisq030u_head from datawindow within w_pisq030u
end type
type cb_exit from commandbutton within w_pisq030u
end type
type cb_consent_yes from commandbutton within w_pisq030u
end type
type cb_consent_no from commandbutton within w_pisq030u
end type
type gb_1 from groupbox within w_pisq030u
end type
type gb_gubun from groupbox within w_pisq030u
end type
type gb_3 from groupbox within w_pisq030u
end type
type cb_modify from commandbutton within w_pisq030u
end type
type cb_image from commandbutton within w_pisq030u
end type
type dw_pisq030u_modify from datawindow within w_pisq030u
end type
type cb_modifyend from commandbutton within w_pisq030u
end type
type cb_imageend from commandbutton within w_pisq030u
end type
type cb_fullimage from commandbutton within w_pisq030u
end type
type p_image from picture within w_pisq030u
end type
end forward

global type w_pisq030u from w_ipis_sheet01
integer width = 3950
integer height = 2412
string title = "�˻���ؼ� ����"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq030u_detail dw_pisq030u_detail
dw_pisq030u_head dw_pisq030u_head
cb_exit cb_exit
cb_consent_yes cb_consent_yes
cb_consent_no cb_consent_no
gb_1 gb_1
gb_gubun gb_gubun
gb_3 gb_3
cb_modify cb_modify
cb_image cb_image
dw_pisq030u_modify dw_pisq030u_modify
cb_modifyend cb_modifyend
cb_imageend cb_imageend
cb_fullimage cb_fullimage
p_image p_image
end type
global w_pisq030u w_pisq030u

type variables

String	is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno

end variables

forward prototypes
public subroutine wf_imagechange ()
end prototypes

public subroutine wf_imagechange ();
blob lb_gyoid_pic, lb_pic 
Int  li_FileNo, li_FileNum
long ll_pic = 1, ll_length

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

ll_length = Len(lb_gyoid_pic)

IF ll_length = 0 OR IsNull(ll_length) THEN
	RETURN 	
END IF

ll_pic =1
//�ӽ������� ��� �۾��� �غ�
//
//li_FileNo = FileOpen("C:\kdac_ipis\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)
li_FileNo = FileOpen("c:\kdac\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)

IF li_FileNo > 0 Then 
	DO   
	  lb_pic=blobmid(lb_gyoid_pic, ll_pic, 32765)
	  FileWrite(li_FileNo, lb_pic) 
	  ll_pic = ll_pic + 32765 
	LOOP UNTIL long(lb_pic) = 0 
End IF 
FileClose(li_FileNo)

end subroutine

on w_pisq030u.create
int iCurrent
call super::create
this.dw_pisq030u_detail=create dw_pisq030u_detail
this.dw_pisq030u_head=create dw_pisq030u_head
this.cb_exit=create cb_exit
this.cb_consent_yes=create cb_consent_yes
this.cb_consent_no=create cb_consent_no
this.gb_1=create gb_1
this.gb_gubun=create gb_gubun
this.gb_3=create gb_3
this.cb_modify=create cb_modify
this.cb_image=create cb_image
this.dw_pisq030u_modify=create dw_pisq030u_modify
this.cb_modifyend=create cb_modifyend
this.cb_imageend=create cb_imageend
this.cb_fullimage=create cb_fullimage
this.p_image=create p_image
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq030u_detail
this.Control[iCurrent+2]=this.dw_pisq030u_head
this.Control[iCurrent+3]=this.cb_exit
this.Control[iCurrent+4]=this.cb_consent_yes
this.Control[iCurrent+5]=this.cb_consent_no
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_gubun
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.cb_modify
this.Control[iCurrent+10]=this.cb_image
this.Control[iCurrent+11]=this.dw_pisq030u_modify
this.Control[iCurrent+12]=this.cb_modifyend
this.Control[iCurrent+13]=this.cb_imageend
this.Control[iCurrent+14]=this.cb_fullimage
this.Control[iCurrent+15]=this.p_image
end on

on w_pisq030u.destroy
call super::destroy
destroy(this.dw_pisq030u_detail)
destroy(this.dw_pisq030u_head)
destroy(this.cb_exit)
destroy(this.cb_consent_yes)
destroy(this.cb_consent_no)
destroy(this.gb_1)
destroy(this.gb_gubun)
destroy(this.gb_3)
destroy(this.cb_modify)
destroy(this.cb_image)
destroy(this.dw_pisq030u_modify)
destroy(this.cb_modifyend)
destroy(this.cb_imageend)
destroy(this.cb_fullimage)
destroy(this.p_image)
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
String	ls_ChargeConsertFlag, ls_SanctionConsertFlag

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
this.title = 'w_pisq030u(�˻���ؼ� ����)'

// Ʈ������� �����Ѵ�
//
dw_pisq030u_head.SetTransObject(SQLPIS)
dw_pisq030u_detail.SetTransObject(SQLPIS)
dw_pisq030u_modify.SetTransObject(SQLPIS)

is_areacode			= istr_parms.String_arg[1]
is_divisioncode	= istr_parms.String_arg[2]
is_suppliercode	= istr_parms.String_arg[3]
is_itemcode			= istr_parms.String_arg[4]
is_standardrevno	= istr_parms.String_arg[5]

// �൵�� ������ �Ǵ��Ͽ� ��ưó���� �Ѵ�
//
IF f_checkimage(is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno) THEN
	cb_fullimage.Enabled	= TRUE
	cb_image.Enabled		= TRUE
	cb_imageend.Enabled	= TRUE
ELSE
	cb_fullimage.Enabled	= FALSE
	cb_image.Enabled		= FALSE
	cb_imageend.Enabled	= FALSE
END IF

// �ڷḦ ��ȸ�Ѵ�
//
dw_pisq030u_head.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno)
dw_pisq030u_detail.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_itemcode, is_standardrevno)

// �Է� �ڷ� �˻�
//
IF dw_pisq030u_head.AcceptText() <> 1 THEN RETURN

ls_ChargeConsertFlag		= dw_pisq030u_head.GetItemString(1, 'ChargeConsertFlag')		// ����� ���ο���
ls_SanctionConsertFlag	= dw_pisq030u_head.GetItemString(1, 'SanctionConsertFlag')	// ������ ���ο���

// ���α׷�ڽ��� ���� ��Ʈ�Ѵ�
//
IF ls_ChargeConsertFlag = 'Y' AND ls_SanctionConsertFlag	= 'X' THEN
	gb_gubun.Text = '< ������ >'
ELSE
	gb_gubun.Text = '< ����� >'
END IF

// ����Ÿ�����쿡 ��Ŀ���� �ִ� �࿡ ����ǥ�ø� ��Ÿ����(1��)
//
f_SetHighlight(dw_pisq030u_detail, 1, True)	

dw_pisq030u_head.SetColumn('applydate')		
dw_pisq030u_head.SetFocus()

// ����ũ�� ������ ������ ��Ʈ�Ѵ�
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq030u
integer x = 41
integer y = 2208
integer width = 3598
end type

type dw_pisq030u_detail from u_vi_std_datawindow within w_pisq030u
integer x = 46
integer y = 1204
integer width = 3835
integer height = 984
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq030u_02"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type dw_pisq030u_head from datawindow within w_pisq030u
integer x = 46
integer y = 320
integer width = 3835
integer height = 868
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq030u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
String	ls_colname, ls_coldata, ls_supplierlotno

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��������
	//
	CASE 'applydate'
		IF Len(Trim((ls_coldata))) <> 10 or mid(ls_coldata,5,1) <> '.' THEN
			MessageBox('Ȯ ��', '�������ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01', StopSign!)
			dw_pisq030u_head.SetColumn('applydate')		
			dw_pisq030u_head.SetFocus()
			RETURN 1
		END IF			

		IF f_checknullorspace(ls_coldata) = TRUE THEN
			MessageBox('Ȯ ��', '�������ڸ� �Է��ϼ���', StopSign!)
			dw_pisq030u_head.SetColumn('applydate')		
			dw_pisq030u_head.SetFocus()
			RETURN 1
		END IF			

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('Ȯ ��', '�������ڸ� �ٸ��� �Է��ϼ���', StopSign!)
			dw_pisq030u_head.SetColumn('applydate')		
			dw_pisq030u_head.SetFocus()
			RETURN 1
		END IF			

END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------





end event

event itemerror;
RETURN 1
end event

type cb_exit from commandbutton within w_pisq030u
integer x = 3483
integer y = 104
integer width = 389
integer height = 112
integer taborder = 30
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

type cb_consent_yes from commandbutton within w_pisq030u
integer x = 59
integer y = 104
integer width = 389
integer height = 112
integer taborder = 70
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
String	ls_ReturnReason, ls_LoginEmpno, ls_ChargeConsertFlag, ls_SanctionConsertFlag, ls_applydate, ls_areadivision
Int		li_save 

// �Է� �ڷ� �˻�
//
IF dw_pisq030u_head.AcceptText() <> 1 THEN RETURN

ls_ChargeConsertFlag		= dw_pisq030u_head.GetItemString(1, 'ChargeConsertFlag')		// ����� ���ο���
ls_SanctionConsertFlag	= dw_pisq030u_head.GetItemString(1, 'SanctionConsertFlag')	// ������ ���ο���
ls_applydate				= dw_pisq030u_head.GetItemString(1, 'applydate')				// ��������

IF Len(Trim((ls_applydate))) <> 10 THEN
	MessageBox('Ȯ ��', '�������ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01', StopSign!)
	dw_pisq030u_head.SetColumn('applydate')		
	dw_pisq030u_head.SetFocus()
	RETURN
END IF			
IF IsDate(ls_applydate) = FALSE THEN
	MessageBox('Ȯ ��', '�������ڸ� �ٸ��� �Է��ϼ���', StopSign!)
	dw_pisq030u_head.SetColumn('applydate')		
	dw_pisq030u_head.SetFocus()
	RETURN 1
END IF			
IF f_checknullorspace(ls_applydate) = TRUE THEN
	MessageBox('Ȯ ��', '�������ڸ� �Է��ϼ���', StopSign!)
	dw_pisq030u_head.SetColumn('applydate')		
	dw_pisq030u_head.SetFocus()
	RETURN
END IF			

// ���ο��θ� ��Ȯ���Ѵ�
//
IF MessageBox('Ȯ ��', '����ó���� �Ͻðڽ��ϱ�?', Exclamation!, OKCancel!, 1) = 2 THEN
	RETURN
END IF

// �����Ƿڿ��ο� ������ ��Ʈ(Y)
//
dw_pisq030u_head.SetItem(1, 'ConsertDependenceFlag', 'Y')

// ���� ����� ���ο��� �Ǵ�(����ó��)
//
IF ls_ChargeConsertFlag = 'X' THEN
	ls_areadivision = is_areacode + is_divisioncode

	// ������ ����ȭ�� ����
	//
	OpenWithParm(w_pisq031u, ls_areadivision)

	IF f_checknullorspace(Message.StringParm) = TRUE THEN
		MessageBox('Ȯ ��', '���õ� �����ڰ� ��� ����ó���� �ߴ��մϴ�', StopSign!)
		RETURN
	END IF

	// ������ ����ȭ�鿡�� ���õǾ��� �Ѿ�� ������ ����� ��Ʈ�Ѵ�
	//
	dw_pisq030u_head.SetItem(1, 'SanctionCode', Trim(Message.StringParm))// ������(������ ���� ���)

	dw_pisq030u_head.SetItem(1, 'ChargeConsertFlag', 'Y')						// ����� ���ο���
	dw_pisq030u_head.SetItem(1, 'ChargeCode', g_s_empno)						// �����(�α��� ���)

END IF
	
// ����� ���εǾ��� ������ ���ο��� �Ǵ�(����ó��)
//
IF ls_ChargeConsertFlag = 'Y' AND ls_SanctionConsertFlag	= 'X' THEN
	dw_pisq030u_head.SetItem(1, 'SanctionConsertFlag', 'Y')					// ������ ���ο���

	// ��������	(������ �ý��� ���ڸ� ��Ʈ�Ѵ�)
	//
	dw_pisq030u_head.SetItem(1, 'ConsertDate', String(f_getsysdatetime(), 'yyyy.mm.dd'))
	// ��������
	//
	dw_pisq030u_head.SetItem(1, 'ChangeFlag', 'N')	
END IF

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq030u_head.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

cb_exit.TriggerEvent(Clicked!)

end event

type cb_consent_no from commandbutton within w_pisq030u
integer x = 485
integer y = 104
integer width = 389
integer height = 112
integer taborder = 40
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
String	ls_ReturnReason, ls_LoginEmpno, ls_ChargeConsertFlag, ls_SanctionConsertFlag
Int		li_save 

// �Է� �ڷ� �˻�
//
IF dw_pisq030u_head.AcceptText() <> 1 THEN RETURN

ls_ReturnReason			= dw_pisq030u_head.GetItemString(1, 'ReturnReason')			// �ݼۻ���
ls_ChargeConsertFlag		= dw_pisq030u_head.GetItemString(1, 'ChargeConsertFlag')		// ����� ���ο���
ls_SanctionConsertFlag	= dw_pisq030u_head.GetItemString(1, 'SanctionConsertFlag')	// ������ ���ο���

// �ݼۻ����� �Է¿��θ� Ȯ���Ѵ�
//
IF f_CheckNullOrSpace(ls_ReturnReason) = TRUE THEN
	MessageBox('Ȯ ��', '�ݼۻ����� �ݵ�� �Է��ϼ���')
	dw_pisq030u_head.SetColumn('ReturnReason')
	dw_pisq030u_head.SetFocus()
	RETURN
END IF

// �ݼۿ��θ� ��Ȯ���Ѵ�
//
IF MessageBox('Ȯ ��', '�ݼ�ó���� �Ͻðڽ��ϱ�?', Exclamation!, OKCancel!, 1) = 2 THEN
	RETURN
END IF

// �����Ƿڿ��ο� �ݼ��� ��Ʈ(N)
//
dw_pisq030u_head.SetItem(1, 'ConsertDependenceFlag', 'N')			

// ���� ����� ���ο��� �Ǵ�(�ݼ�ó��)
//
IF ls_ChargeConsertFlag = 'X' THEN
	dw_pisq030u_head.SetItem(1, 'ChargeConsertFlag', 'N')						// ����� ���ο���
	dw_pisq030u_head.SetItem(1, 'ChargeCode', g_s_empno)						// �����(�α��� ���)
END IF
	
// ����� ���εǾ��� ������ ���ο��� �Ǵ�(�ݼ�ó��)
//
IF ls_ChargeConsertFlag = 'Y' AND ls_SanctionConsertFlag	= 'X' THEN
	dw_pisq030u_head.SetItem(1, 'SanctionConsertFlag', 'N')					// ������ ���ο���
	dw_pisq030u_head.SetItem(1, 'SanctionCode', g_s_empno)					// ������(�α��� ���)
END IF

// �ݼ�����(�������� �׸� ������ �ý��� ���ڸ� ��Ʈ�Ѵ�)
//
dw_pisq030u_head.SetItem(1, 'ConsertDate', String(f_getsysdatetime(), 'yyyy.mm.dd'))

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq030u_head.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

cb_exit.TriggerEvent(Clicked!)

end event

type gb_1 from groupbox within w_pisq030u
integer x = 14
integer y = 276
integer width = 3904
integer height = 2036
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_gubun from groupbox within w_pisq030u
integer x = 14
integer y = 20
integer width = 910
integer height = 244
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "  < ����� >  "
end type

type gb_3 from groupbox within w_pisq030u
integer x = 1157
integer y = 20
integer width = 2757
integer height = 244
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
end type

type cb_modify from commandbutton within w_pisq030u
integer x = 1207
integer y = 104
integer width = 389
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�����̷�"
end type

event clicked;
dw_pisq030u_modify.Visible = TRUE
dw_pisq030u_modify.Retrieve(is_areacode, is_divisioncode, is_suppliercode, is_itemcode)



end event

type cb_image from commandbutton within w_pisq030u
integer x = 2642
integer y = 104
integer width = 389
integer height = 112
integer taborder = 80
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
blob 	lb_pic

SetPointer(HourGlass!)

p_image.Visible	= True
//p_image.x			= 59
//p_image.y			= 332
//p_image.Width		= 3557
//p_image.Height		= 1844

selectblob drawingname 
		into :lb_pic 
   	from TQQcStandard
	  where areacode 		= :is_areacode
		 and divisioncode	= :is_divisioncode
		 and suppliercode	= :is_suppliercode
		 and itemcode		= :is_itemcode
		 and standardrevno= :is_standardrevno
	 using sqlpis;

p_image.Setpicture(lb_pic)

SetPointer(Arrow!)

end event

type dw_pisq030u_modify from datawindow within w_pisq030u
boolean visible = false
integer x = 50
integer y = 332
integer width = 3822
integer height = 1844
integer taborder = 30
string title = "none"
string dataobject = "d_pisq030u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
dw_pisq030u_modify.Visible = FALSE

end event

type cb_modifyend from commandbutton within w_pisq030u
integer x = 1627
integer y = 104
integer width = 448
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�����̷´ݱ�"
end type

event clicked;
dw_pisq030u_modify.Visible = FALSE




end event

type cb_imageend from commandbutton within w_pisq030u
integer x = 3063
integer y = 104
integer width = 389
integer height = 112
integer taborder = 50
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

type cb_fullimage from commandbutton within w_pisq030u
integer x = 2107
integer y = 104
integer width = 503
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��ü���麸��"
end type

event clicked;
// �ش� �̹����� �ҷ��´�
//
wf_imagechange()

Run("explorer c:\kdac\bmp\temp.jpg", Maximized!)


end event

type p_image from picture within w_pisq030u
boolean visible = false
integer x = 50
integer y = 332
integer width = 3822
integer height = 1844
boolean border = true
boolean focusrectangle = false
end type

event clicked;
p_image.Visible = FALSE

end event

