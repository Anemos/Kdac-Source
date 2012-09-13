$PBExportHeader$w_piss420u.srw
$PBExportComments$�������SRȮ��
forward
global type w_piss420u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss420u
end type
type uo_division from u_pisc_select_division within w_piss420u
end type
type uo_area from u_pisc_select_area within w_piss420u
end type
type rb_1 from radiobutton within w_piss420u
end type
type rb_2 from radiobutton within w_piss420u
end type
type dw_print from datawindow within w_piss420u
end type
type dw_2 from datawindow within w_piss420u
end type
type gb_1 from groupbox within w_piss420u
end type
end forward

global type w_piss420u from w_ipis_sheet01
integer width = 4517
integer height = 2700
string title = "SR�����Ͽ�û��"
event ue_postopen ( )
dw_sheet dw_sheet
uo_division uo_division
uo_area uo_area
rb_1 rb_1
rb_2 rb_2
dw_print dw_print
dw_2 dw_2
gb_1 gb_1
end type
global w_piss420u w_piss420u

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,  is_mod[],is_custgubun
string is_shipoemgubun,is_areacode,is_divisioncode
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function boolean wf_update_tsrcancel ()
end prototypes

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
end event

public function boolean wf_update_tsrcancel ();long ll_count,i,ll_cnt,ll_found
string ls_srcancelgubun,ls_srno,ls_canceldate,ls_cancelgubun,ls_divisioncode,ls_checksrno,ls_itemcode,ls_custcode
string ls_org_srno,ls_find_string
boolean lb_commit
lb_commit = true
ll_count = dw_sheet.rowcount()
for i = 1 to ll_count step 1
	 ls_srcancelgubun = dw_sheet.object.srcancelgubun[i]
	 if ls_srcancelgubun = 'Y' then
      ls_srno = dw_sheet.object.srno[i]
      ls_checksrno = dw_sheet.object.checksrno[i]
		ls_cancelgubun  = dw_sheet.object.cancelgubun[1]
		ls_canceldate   = dw_sheet.object.canceldate[i]
		ls_itemcode     = dw_sheet.object.itemcode[i]
		ls_divisioncode = dw_sheet.object.divisioncode[i]
		ls_custcode     = dw_sheet.object.custcode[i]		
		ls_find_string = 'divisioncode = ' + "'" + ls_divisioncode + "'"
		ls_find_string = ls_find_string + ' and checksrno = ' + "'" + ls_checksrno + "'"
		ll_found = dw_2.find(ls_find_string,1,dw_2.rowcount())
		if ll_found <= 0 then
			dw_2.insertrow(1)
			dw_2.object.divisioncode[1] = ls_divisioncode
			dw_2.object.checksrno[1] = ls_checksrno
		end if
		update tsrcancel
		   set confirmflag = 'Y',
             lastemp = 'Y',
				 lastdate = getdate()
		 where areacode = :is_areacode
		   and divisioncode = :is_divisioncode
			and canceldate = :ls_canceldate
			and srno       = :ls_srno
			and checksrno  = :ls_checksrno
			and cancelgubun = :ls_cancelgubun
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrcancel update error : " + sqlpis.sqlerrtext
			lb_commit = false
			exit
		end if
		select count(*)
		  into :ll_cnt
		  from tsrcancel_interface
		  where srno      = :ls_srno
		    and areacode  = :is_areacode
			 and divisioncode = :ls_divisioncode
			 and canceldate   = :ls_canceldate
			 and cancelgubun  = :ls_cancelgubun
		  using sqlpis;

		ll_cnt = ll_cnt + 1
		INSERT INTO TSRCANCEL_INTERFACE  
                 (CancelDate,AreaCode,DivisionCode,SRNo,CancelGubun,SeqNo,   
		            MISFlag,InterfaceFlag,ItemCode,ConfirmFlag,
                  LastEmp,LastDate )  
          VALUES (:ls_canceldate,:is_areacode,:ls_divisioncode,:ls_srno,:ls_cancelgubun,:ll_cnt, 
                  'A','Y',:ls_itemcode,'Y',
				      :g_s_empno,getdate() ) 
			 using sqlpis;
		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrcancel_interface insert error : " + sqlpis.sqlerrtext
			lb_commit = false
			exit
		end if
	end if
next
if lb_commit = false then
	return lb_commit
end if	
dw_2.accepttext()

for i = 1 to dw_2.rowcount() step 1
	ls_divisioncode = dw_2.object.divisioncode[i]
	ls_checksrno = dw_2.object.checksrno[i]
   
	dw_print.retrieve(is_areacode,ls_divisioncode,ls_checksrno)
	if dw_print.rowcount() > 0 then
		dw_print.print()
	end if
next 
return lb_commit

end function

on w_piss420u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_division=create uo_division
this.uo_area=create uo_area
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_print=create dw_print
this.dw_2=create dw_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.gb_1
end on

on w_piss420u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_print)
destroy(this.dw_2)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;string ls_gubun
if rb_1.checked  then
	ls_gubun = '2'
else
	ls_gubun = '3'
end if	
setpointer(hourglass!)
dw_sheet.retrieve(is_areacode,is_divisioncode,ls_gubun)
setpointer(arrow!)
if dw_sheet.rowcount() = 0 then
	messagebox("Ȯ��","��ȸ�� �ڷᰡ �����ϴ�.")
	return
end if
end event

event ue_save;setpointer(hourglass!)
sqlpis.autocommit = false
if wf_update_tsrcancel() then
   commit using sqlpis;
	sqlpis.autocommit = true
	messagebox("Ȯ��","�۾��� �Ϸ�Ǿ����ϴ�")
else
	rollback using sqlpis;
	sqlpis.autocommit = true
end if
setpointer(arrow!)
postevent('ue_retrieve')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss420u
end type

type dw_sheet from u_vi_std_datawindow within w_piss420u
integer x = 18
integer y = 236
integer width = 4430
integer height = 2340
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss420u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_division from u_pisc_select_division within w_piss420u
integer x = 832
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_2.reset()

is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_print.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss420u
integer x = 78
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)


string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_print.reset()
dw_2.reset()

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
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type rb_1 from radiobutton within w_piss420u
integer x = 1545
integer y = 88
integer width = 357
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "����Ƿ�"
boolean checked = true
end type

event clicked;rb_2.checked = false
dw_sheet.reset()
end event

type rb_2 from radiobutton within w_piss420u
integer x = 1943
integer y = 88
integer width = 384
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "�Ƿ����"
end type

event clicked;rb_1.checked = false
dw_sheet.reset()
end event

type dw_print from datawindow within w_piss420u
boolean visible = false
integer x = 901
integer y = 392
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss420u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_piss420u
boolean visible = false
integer x = 1504
integer y = 496
integer width = 946
integer height = 744
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss420u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss420u
integer x = 23
integer y = 28
integer width = 4421
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "��ȸ����"
end type

