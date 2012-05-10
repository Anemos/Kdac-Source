$PBExportHeader$w_piss004u.srw
$PBExportComments$�԰����ϵ���ǰ����
forward
global type w_piss004u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss004u
end type
type uo_division from u_pisc_select_division within w_piss004u
end type
type dw_sheet from u_vi_std_datawindow within w_piss004u
end type
type st_v_bar from uo_xc_splitbar within w_piss004u
end type
type gb_1 from groupbox within w_piss004u
end type
end forward

global type w_piss004u from w_ipis_sheet01
integer width = 5143
string title = "�԰����ϵ���ǰ��"
boolean minbox = true
uo_area uo_area
uo_division uo_division
dw_sheet dw_sheet
st_v_bar st_v_bar
gb_1 gb_1
end type
global w_piss004u w_piss004u

type variables
string is_prddate,is_areacode,is_divisioncode
end variables

forward prototypes
public function boolean wf_update_tshipinv ()
public subroutine wf_dw_set (string ps_gubun)
end prototypes

public function boolean wf_update_tshipinv ();long ll_count,i
boolean lb_boolean
string ls_shipplandate,ls_divisioncode,ls_fromareacode,ls_fromdivisioncode,ls_srno,ls_shipdate,ls_lastemp
long ll_shipqty,ll_truckorder,ll_error,ll_cnt,l
string ls_sendflag,ls_truckno,ls_moveareacode
ll_count = dw_sheet.rowcount()
lb_boolean = true
for i = 1 to ll_count step 1
	uo_status.st_message.text = string(i)+ '������'
	ls_shipplandate     = dw_sheet.object.shipplandate[i]
	ls_divisioncode     = dw_sheet.object.divisioncode[i]
	ls_fromareacode     = dw_sheet.object.fromareacode[i]
	ls_fromdivisioncode = dw_sheet.object.fromdivisioncode[i]
	ll_truckorder       = dw_sheet.object.truckorder[i]
	ls_truckno          = dw_sheet.object.truckno[i]
	ls_srno             = dw_sheet.object.srno[i]
	ls_shipdate         = dw_sheet.object.shipdate[i]
	ls_lastemp          = dw_sheet.object.lastemp[i]
	ll_shipqty          = dw_sheet.object.truckloadqty[i]
   SELECT COUNT(*)
     INTO :ll_cnt
     FROM TSHIPINV 
    WHERE SHIPPLANDATE = :ls_shipplandate
      and areacode     = :is_areacode
	   and divisioncode = :ls_divisioncode
	   and srno         = :ls_srno
	   and truckorder   = :ll_truckorder
	   using sqlpis;
   if ll_cnt > 0 then	
		update tshipinv
			set sendflag        = 'Y',
			    moveconfirmflag = 'Y',
				 moveconfirmdate = null,
				 moveconfirmtime = null,
				 lastemp         = 'X',
				 lastdate        = getdate()
		 WHERE SHIPPLANDATE = :ls_shipplandate
			and areacode     = :is_areacode
			and divisioncode = :ls_divisioncode
			and srno         = :ls_srno
			and truckorder   = :ll_truckorder
			using sqlpis;
	end if
	if sqlpis.sqlcode <> 0 then
		lb_boolean = false
		exit
   end if
	SELECT COUNT(*)
     INTO :ll_cnt
     FROM TSHIPSHEET 
    WHERE srno         = :ls_srno
   using sqlpis;
	if ll_cnt > 0 then	
		update tshipsheet
			set deliveryflag = 'Y'
		where srno = :ls_srno 
		using sqlpis;
   end if
	if sqlpis.sqlcode <> 0 then
		lb_boolean = false
		exit
   end if
next
return lb_boolean
end function

public subroutine wf_dw_set (string ps_gubun);if ps_gubun = 'A' then // �Է� 
	dw_sheet.object.itemcode.background.color 	= rgb(255,250,239)
	dw_sheet.object.itemcode.protect 				= false
else
	dw_sheet.object.itemcode.background.color 	= rgb(192,192,192)
	dw_sheet.object.itemcode.protect 				= true
end if

end subroutine

on w_piss004u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_sheet=create dw_sheet
this.st_v_bar=create st_v_bar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_sheet
this.Control[iCurrent+4]=this.st_v_bar
this.Control[iCurrent+5]=this.gb_1
end on

on w_piss004u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_sheet)
destroy(this.st_v_bar)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, full)
//of_resize_register(st_v_bar, SPLIT)
//of_resize_register(dw_sheet_1, RIGHT)
//
of_resize()
end event

event ue_retrieve;call super::ue_retrieve;string ls_prddate,ls_areacode,ls_divisioncode
long ll_count

dw_sheet.reset()
if dw_sheet.retrieve(is_areacode,is_divisioncode) <= 0 then
	messagebox('�� ȸ' ,'��ȸ�� ������ �����ϴ�')
	return
end if
//wf_dw_Set('I')

end event

event ue_postopen;dw_sheet.settransobject(sqlpis)


end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)



end event

event ue_save;call super::ue_save;setpointer(hourglass!)

dw_sheet.accepttext()

if f_spacechk(dw_sheet.object.itemcode[dw_sheet.rowcount()]) = -1 then
	dw_sheet.deleterow(dw_sheet.rowcount())
end if

if f_mandatory_chk(dw_sheet) = -1 then
	messagebox("Ȯ��","�ʼ��Է»����� Ȯ�ιٶ��ϴ�")
	return 
end if

sqlpis.autocommit = false

if dw_sheet.update() = 1 then
	commit using sqlpis;
	messagebox("Ȯ��","����Ϸ�")
else
	rollback using sqlpis ;
	messagebox("Ȯ��","�������")
end if

sqlpis.autocommit = true

postevent('ue_retrieve')
end event

event ue_insert;call super::ue_insert;int i,ln_count
string ls_divisionname

ln_count = dw_sheet.rowcount()
if ln_count > 0 then
	if f_spacechk(dw_sheet.object.itemcode[ln_count]) = -1 then
		dw_sheet.deleterow(dw_sheet.rowcount())
	end if
end if

i = dw_sheet.insertrow(0)

select divisionname into :ls_divisionname from tmstdivision
	where areacode = :is_areacode and divisioncode = :is_divisioncode 
using sqlpis ;

dw_sheet.object.areacode[i]		= is_areacode
dw_sheet.object.divisioncode[i] 	= is_divisioncode
dw_sheet.object.lastemp[i]	 		= g_s_empno
dw_sheet.object.lastdate[i]	 	= f_pisc_get_date_nowtime()
dw_sheet.object.tmstdivision_divisionname[i] 	= ls_divisionname
dw_sheet.setfocus()
dw_sheet.ScrollToRow(i)
dw_sheet.setcolumn('itemcode')

end event

event ue_delete;call super::ue_delete;int ln_row,ln_yesno

SetPointer(HourGlass!)
 
ln_row = dw_sheet.getselectedrow(0)
if ln_row <> 0 then 
	ln_yesno = messagebox("����Ȯ��", "���õ� ǰ��(��)�� �����Ͻðڽ��ϱ� ?",Question!,OkCancel!,2)
	if ln_yesno <> 1 then
		uo_status.st_message.text = f_message("D030")
		return 
	end if
else
	messagebox("Ȯ��", "���õ� ǰ���� �����ϴ�")
	return 
end if

do until ln_row = 0
	dw_sheet.deleterow(ln_row)
	ln_row = dw_sheet.getselectedrow(ln_row - 1)
loop

sqlpis.autocommit = false

if dw_sheet.update() = 1 then
	commit using sqlpis;
	messagebox("Ȯ��","�����Ϸ�")
else
	rollback using sqlpis ;
	messagebox("Ȯ��","��������")
end if

sqlpis.autocommit = true

postevent('ue_retrieve')


end event

type uo_status from w_ipis_sheet01`uo_status within w_piss004u
end type

type uo_area from u_pisc_select_area within w_piss004u
integer x = 82
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()

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

type uo_division from u_pisc_select_division within w_piss004u
integer x = 654
integer y = 100
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode

end event

event ue_select;long l
dw_sheet.settransobject(sqlpis)

is_divisioncode = is_uo_divisioncode
dw_sheet.reset()

end event

type dw_sheet from u_vi_std_datawindow within w_piss004u
integer x = 27
integer y = 216
integer width = 3419
integer height = 1636
integer taborder = 11
boolean bringtotop = true
string title = "1"
string dataobject = "d_piss_004u_01"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;string 	ls_itno,ls_dept,ls_citemcode,ls_itemclass,ls_date
int	 	ln_count
long		ln_row

this.accepttext()

ls_date = f_get_systemdate(sqlpis)
ls_date = mid(ls_date,1,4) + '.' + mid(ls_date,6,2) + '.' + mid(ls_date,9,2)  

if dwo.name = 'itemcode' then
	ls_itno	= 	trim(this.object.itemcode[row])
	if f_piss_itemtype_check(is_areacode,is_divisioncode,ls_itno) <> '5' then
		messagebox("Ȯ��","��ǰ�� �ƴմϴ�")
		this.object.itemcode[row] = ''
		this.setfocus()
		this.setcolumn('itemcode')
		return 2
	end if
	select count(*) 
		 into :ln_count 
		 from tmstkb a,tinv b
		where a.areacode = :is_areacode
		  and a.divisioncode = :is_divisioncode
		  and a.itemcode = :ls_itno
		  and ( a.prdstopgubun = 'N' or ( a.prdstopgubun = 'Y' and b.invqty > 0 ) )
		  and	a.areacode = b.areacode
		  and a.divisioncode = b.divisioncode
		  and a.itemcode = b.itemcode
		  using sqlpis;
	 if ln_count > 0 then
		  messagebox("Ȯ��","����ǰ���� �Է� �Ұ�.")
		  this.object.itemcode[row] = ''
		  this.setfocus()
		  this.setcolumn('itemcode')
		  return 2
	  end if
	select count(*) into :ln_count from tmstbom
		where	bompitemno = :ls_itno and
           	divisioncode = :is_divisioncode AND  
			  	areacode = :is_areacode AND  
           	(applyfrom <= applyto AND applyto >= :ls_date )
	using sqlpis ;
	select bomcitemno into :ls_citemcode from tmstbom
		where	bompitemno = :ls_itno and
           	divisioncode = :is_divisioncode AND  
			  	areacode = :is_areacode AND  
           	(applyfrom <= applyto AND applyto >= :ls_date )
	using sqlpis ;
	if ln_count <> 1 then
		messagebox("Ȯ��","BOM ����ǰ���� ���ų� �ΰ� �̻��Դϴ�.")
		this.object.itemcode[row] = ''
		this.setfocus()
		this.setcolumn('itemcode')
		return 2
	else
		select itembuysource into :ls_itemclass from tmstmodel
		where	itemcode = :ls_citemcode and
           	divisioncode = :is_divisioncode AND  
			  	areacode = :is_areacode 
		using sqlpis ;
		if ls_itemclass <> '04' and ls_itemclass <> '01' then
			messagebox("Ȯ��","BOM ����ǰ���� ������ ��޿ϼ�ǰ �Ǵ� ���ڿ���ᰡ �ƴմϴ�..")
			this.object.itemcode[row] = ''
			this.setfocus()
			this.setcolumn('itemcode')
			return 2
		end if
	end if
	ln_row = this.find("itemcode = '" + ls_itno + "'"  ,1, this.rowcount()) 
  	if ln_row <> row or f_piss_inoutitem_check(is_areacode,is_divisioncode,ls_itno) >= 1 then
		messagebox("Ȯ��","�̹� �����ϴ� ǰ���Դϴ�")
		this.object.itemcode[row] = ''
		this.setfocus()
		this.setcolumn('itemcode')
		return 2
	end if
elseif dwo.name = 'deptcode' then
	ls_dept	=	trim(this.object.deptcode[row] )
	select count(*) into :ln_count from tmstdept
		where deptcode = :ls_dept using sqlpis ;
//	if ln_count	= 0 then
//		select count(*) into :ln_count from tmstsupplier 
//			where suppliercode = :ls_dept using sqlpis ;
		if ln_count = 0 then
			messagebox("Ȯ��","�μ��ڵ� Ȯ�ιٶ��ϴ�.")
			this.object.deptcode[row] = ''
			this.setfocus()
			this.setcolumn('deptcode')
			return 2
		end if
//	end if
end if
end event

type st_v_bar from uo_xc_splitbar within w_piss004u
boolean visible = false
integer x = 2126
integer y = 228
integer width = 18
boolean bringtotop = true
integer textsize = -9
end type

event constructor;call super::constructor;of_register(dw_sheet,LEFT)

end event

type gb_1 from groupbox within w_piss004u
integer x = 23
integer y = 28
integer width = 1225
integer height = 172
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

