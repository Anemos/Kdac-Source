$PBExportHeader$w_pisq611u_04.srw
$PBExportComments$�⺻�����Է�������
forward
global type w_pisq611u_04 from window
end type
type cb_cancel from commandbutton within w_pisq611u_04
end type
type cb_save from commandbutton within w_pisq611u_04
end type
type dw_1 from datawindow within w_pisq611u_04
end type
end forward

global type w_pisq611u_04 from window
integer width = 2715
integer height = 1064
boolean titlebar = true
string title = "�⺻�����Է� ������"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_save cb_save
dw_1 dw_1
end type
global w_pisq611u_04 w_pisq611u_04

type variables
string is_refcode
end variables

on w_pisq611u_04.create
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_1=create dw_1
this.Control[]={this.cb_cancel,&
this.cb_save,&
this.dw_1}
end on

on w_pisq611u_04.destroy
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;datawindowchild ldwc
str_pisqwc_parm lstr

lstr = Message.PowerObjectParm
is_refcode = lstr.s_parm[1]


choose case is_refcode
	case 'A'	//����ǰ������
		dw_1.dataobject = 'd_pisq611u_a1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('itemgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS007')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'itemgubun',ldwc,'codename',10)
		
		dw_1.GetChild('itemcheck', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS008')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'itemcheck',ldwc,'codename',10)
		
		dw_1.GetChild('productid', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'productid',ldwc,'codename',10)
		
		dw_1.GetChild('accarea', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		f_pisc_set_dddw_width(dw_1,'accarea',ldwc,'areaname',10)

		dw_1.GetChild('accdivision', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%','%')
		f_pisc_set_dddw_width(dw_1,'accdivision',ldwc,'divisionname',10)
	case 'B'	//��ǰ������
		dw_1.dataobject = 'd_pisq611u_b1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('areacode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		f_pisc_set_dddw_width(dw_1,'areacode',ldwc,'areaname',10)

		dw_1.GetChild('divisioncode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%','%')
		f_pisc_set_dddw_width(dw_1,'divisioncode',ldwc,'divisionname',10)
		
		dw_1.GetChild('division', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS006')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'division',ldwc,'codename',10)
	case 'C'	//�������
		dw_1.dataobject = 'd_pisq611u_c1'
		dw_1.settransobject(sqleis)
	case 'D'	//�����ڵ����
		dw_1.dataobject = 'd_pisq611u_d1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'mapcode',ldwc,'codename',10)
	case 'E'	//�����������
		dw_1.dataobject = 'd_pisq611u_e1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'mapcode',ldwc,'codename',10)
	case 'F'	//��������
		dw_1.dataobject = 'd_pisq611u_f1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'mapcode',ldwc,'codename',10)
	case 'G'	//�����������
		dw_1.dataobject = 'd_pisq611u_g1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'mapcode',ldwc,'codename',10)
		
		dw_1.GetChild('exportgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS003')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'exportgubun',ldwc,'codename',10)
	case 'H' //��ǰ���Կ���
		dw_1.dataobject = 'd_pisq611u_h1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('mapcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'mapcode',ldwc,'codename',10)
		
		dw_1.GetChild('exportgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS003')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'exportgubun',ldwc,'codename',10)
	case 'I'	//����д���
		dw_1.dataobject = 'd_pisq611u_i1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('carcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'carcode',ldwc,'codename',10)
		
		dw_1.GetChild('allotcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'allotcode',ldwc,'codename',10)
	case 'J'	//�����Ⱓ Master
		dw_1.dataobject = 'd_pisq611u_j1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('custcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'custcode',ldwc,'codename',10)
		
		dw_1.GetChild('exportgubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS003')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'exportgubun',ldwc,'codename',10)
		
		dw_1.GetChild('oagubun', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS004')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'oagubun',ldwc,'codename',10)
		
		dw_1.GetChild('productid', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'productid',ldwc,'codename',10)
		
		dw_1.GetChild('assurecode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'assurecode',ldwc,'codename',10)
	case 'K' //�����Ⱓ Code
		dw_1.dataobject = 'd_pisq611u_k1'
		dw_1.settransobject(sqleis)
	case 'L'	//����д��� Code
		dw_1.dataobject = 'd_pisq611u_l1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('custcode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve()
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'custcode',ldwc,'codename',10)
		
		dw_1.GetChild('itemcheck', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('WCS008')
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		f_pisc_set_dddw_width(dw_1,'itemcheck',ldwc,'codename',10)
	case 'M'	//���� Mapping
		dw_1.dataobject = 'd_pisq611u_m1'
		dw_1.settransobject(sqleis)
	case 'N'
		dw_1.dataobject = 'd_pisq611u_n1'
		dw_1.settransobject(sqleis)
	case 'O'
		dw_1.dataobject = 'd_pisq611u_o1'
		dw_1.settransobject(sqleis)
		
		dw_1.GetChild('areacode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%')
		f_pisc_set_dddw_width(dw_1,'areacode',ldwc,'areaname',10)

		dw_1.GetChild('divisioncode', ldwc)
		ldwc.settransobject(sqleis)
		ldwc.retrieve('%','%','%')
		f_pisc_set_dddw_width(dw_1,'divisioncode',ldwc,'divisionname',10)
end choose

dw_1.insertrow(0)

end event

type cb_cancel from commandbutton within w_pisq611u_04
integer x = 2167
integer y = 824
integer width = 416
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���"
end type

event clicked;closewithreturn(w_pisq611u_04,'')
end event

type cb_save from commandbutton within w_pisq611u_04
integer x = 1669
integer y = 824
integer width = 416
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;string ls_assureid

dw_1.accepttext()
choose case is_refcode
	case 'A'	//����ǰ������ 'd_pisq611u_a' 
		
	case 'B'	//��ǰ������ 'd_pisq611u_b'
		
	case 'C'	//������� 'd_pisq611u_c'
		
	case 'D'	//�����ڵ���� 'd_pisq611u_d'
		
	case 'E'	//����������� 'd_pisq611u_e'
		
	case 'F'	//�������� 'd_pisq611u_f'
		
	case 'G'	//����������� 'd_pisq611u_g'
		
	case 'H' //��ǰ���Կ��� 'd_pisq611u_h'
		
	case 'I'	//����д��� 'd_pisq611u_i' => �д��� ȭ�� �̿�
		ls_assureid = dw_1.getitemstring(1,"assureid")
	case 'J'	//�����Ⱓ Master 'd_pisq611u_j'
		
	case 'K' //�����Ⱓ Code 'd_pisq611u_k'
		
	case 'L'	//����д��� Code 'd_pisq611u_l' => �д��� ȭ�� �̿�
		
	case 'M'	//���� Mapping 'd_pisq611u_m'
		
	case 'N'
		
end choose

sqleis.autocommit = false
if dw_1.update() = 1 then
	Commit using sqleis;
	Messagebox("�˸�","����Ǿ����ϴ�.")
else
	Rollback using sqleis;
	Messagebox("�˸�","����ÿ� ������ �߻��Ͽ����ϴ�.")
	sqleis.autocommit = true
	return 0
end if
sqleis.autocommit = true
closewithreturn(w_pisq611u_04,ls_assureid)
end event

type dw_1 from datawindow within w_pisq611u_04
integer x = 18
integer y = 12
integer width = 2661
integer height = 788
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;datawindowchild ldwc

string ls_areacode, ls_divisioncode, ls_productgroup
string ls_custcode, ls_exportgubun, ls_oagubun, ls_productid, ls_assurecode

This.accepttext()
choose case is_refcode
	case 'A'	//����ǰ������ 'd_pisq611u_a' 
		if dwo.name = 'accarea' then
			//��������ÿ� ����� ��ǰid�� ����
			This.GetChild('accdivision', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'accdivision',ldwc,'divisionname',10)
		end if
	case 'B'	//��ǰ������ 'd_pisq611u_b'
		if dwo.name = 'areacode' then
			//��������ÿ� ����� ��ǰid�� ����
			This.GetChild('divisioncode', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)
		end if
		if dwo.name = 'areacode' or dwo.name = 'divisioncode' or &
			dwo.name = 'productgroup' then
			ls_areacode = This.getitemstring(row,'areacode')
			ls_divisioncode = This.getitemstring(row,'divisioncode')
			ls_productgroup = This.getitemstring(row,'productgroup')
			
			This.setitem( row,'productid', ls_productgroup + ls_areacode + ls_divisioncode )
		end if
	case 'C'	//������� 'd_pisq611u_c'
		
	case 'D'	//�����ڵ���� 'd_pisq611u_d'
		
	case 'E'	//����������� 'd_pisq611u_e'
		
	case 'F'	//�������� 'd_pisq611u_f'
		
	case 'G'	//����������� 'd_pisq611u_g'
		
	case 'H' //��ǰ���Կ��� 'd_pisq611u_h'
		
	case 'I'	//����д��� 'd_pisq611u_i' => �д��� ȭ�� �̿�
		
	case 'J'	//�����Ⱓ Master 'd_pisq611u_j'
		if dwo.name = 'custcode' or dwo.name = 'exportgubun' or &
			dwo.name = 'oagubun' or dwo.name = 'productid' or dwo.name = 'assurecode' then
			ls_custcode = Trim(This.getitemstring(row,'custcode'))
			ls_exportgubun = This.getitemstring(row,'exportgubun')
			ls_oagubun = This.getitemstring(row,'oagubun')
			ls_productid = This.getitemstring(row,'productid')
			ls_assurecode = This.getitemstring(row, 'assurecode')
			
			This.setitem( row,'assureid', ls_custcode + ls_exportgubun &
				+ ls_oagubun + ls_productid + ls_assurecode )
		end if
	case 'K' //�����Ⱓ Code 'd_pisq611u_k'
		
	case 'L'	//����д��� Code 'd_pisq611u_l' => �д��� ȭ�� �̿�
		
	case 'M'	//���� Mapping 'd_pisq611u_m'
		
	case 'N'
		
	case 'O'
		if dwo.name = 'areacode' then
			//��������ÿ� ���� ����
			This.GetChild('divisioncode', ldwc)
			ldwc.settransobject(sqleis)
			ldwc.retrieve('%',data,'%')
			f_pisc_set_dddw_width(This,'divisioncode',ldwc,'divisionname',10)
		end if
end choose
end event

