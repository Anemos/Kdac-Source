$PBExportHeader$w_piss330u.srw
$PBExportComments$��ǰ�԰���������Է�(�����)
forward
global type w_piss330u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss330u
end type
type uo_division from u_pisc_select_division within w_piss330u
end type
type uo_date from u_pisc_date_applydate within w_piss330u
end type
type dw_sheet from datawindow within w_piss330u
end type
type gb_1 from groupbox within w_piss330u
end type
end forward

global type w_piss330u from w_ipis_sheet01
string title = "��ǰ�԰������Է�"
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_sheet dw_sheet
gb_1 gb_1
end type
global w_piss330u w_piss330u

type variables
string is_kbno
string is_areacode,is_divisioncode,is_prddate,is_itemcode,is_productgroup
long  il_qty
end variables

forward prototypes
public function boolean wf_update_tstocketc ()
public function boolean wf_update_tlotno (string fs_close_date)
public function boolean wf_update_tstockcancel_interface (string fs_close_date)
public function boolean wf_errchk (string fs_column)
public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate)
end prototypes

public function boolean wf_update_tstocketc ();string ls_proofno,ls_deptcode,ls_itemcode,ls_proofno_seq,ls_year,ls_month
long   ll_inputqty

string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

select max(substring(proofno,8,4))
  into :ls_proofno
  from tstocketc
  where areacode = :is_areacode
    and divisioncode = :is_divisioncode
	 and inputdate like substring(:ls_close_date,1,7) + '%'
    using sqlpis;
if ls_proofno = '' or isnull(ls_proofno) then
	ls_proofno_seq = 'Z000'
else
	ls_proofno_seq	= 'Z' + right(ls_proofno,3)
end if
ls_year = mid(ls_close_date,4,1) 
ls_month = mid(ls_close_date,6,2)		

f_pisc_get_string_add(ls_proofno_seq,ls_proofno_seq)

ls_proofno = is_areacode + is_divisioncode + is_productgroup + ls_year + ls_month  + ls_proofno_seq
dw_sheet.object.proofno[1] = ls_proofno
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ll_inputqty = dw_sheet.object.inputqty[1]
  INSERT INTO TSTOCKETC  
         ( AreaCode,   
           DivisionCode,   
           InputDate,   
           InputFlag,   
           ProofNo,   
           DeptCode,   
           ItemCode,   
           InputQty,   
           LastEmp,   
           LastDate )  
  VALUES ( :is_areacode,   
           :is_divisioncode,   
           :ls_close_date,   
           '2',   
           :ls_proofno,   
           :ls_deptcode,   
           :ls_itemcode,   
           :ll_inputqty,   
           'Y',   
           getdate() )  
			  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tstocketc error : " + sqlpis.sqlerrtext
	return false
else
	return true
end if	
end function

public function boolean wf_update_tlotno (string fs_close_date);long ll_seqno,ll_inputqty,ll_count
string ls_kbno,ls_deptcode,ls_itemcode

ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ll_inputqty = dw_sheet.object.inputqty[1]

select count(*)
  into :ll_count
  from tlotno
 WHERE tracedate    = :fs_close_date
	and areacode     = :is_areacode
	and divisioncode = :is_divisioncode
	and itemcode     = :ls_itemcode
   and LotNo		  = 'XXXXXX'
	and custcode     = 'XXXXXX'
	and shipgubun    = 'X'
	using sqlpis;
	
if isnull(ll_count) then
	ll_count = 0
end if	
if ll_count > 0 then  
	UPDATE tlotno
		SET stockqty	= Stockqty - :ll_inputqty,
			 LastEmp		= 'N',				
			 LastDate	= GetDate()					 
	 WHERE tracedate    = :fs_close_date
		and areacode     = :is_areacode
		and divisioncode = :is_divisioncode
		and itemcode     = :ls_itemcode
		and LotNo		  = 'XXXXXX'
		and custcode     = 'XXXXXX'
		and shipgubun    = 'X'
		using sqlpis;
else
 	  INSERT INTO TLOTNO  
         ( TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,custcode,shipgubun,
			  shipusage,PrdQty,StockQty,ShipQty,
           lastemp,LastDate )  
  VALUES ( :fs_close_date,:is_areacode,:is_divisioncode,'XXXXXX',:ls_itemcode,'XXXXXX','X',
           'X',0,:ll_inputqty * -1,0,   
           'Y',getdate() )  
			  using sqlpis;
end if
If sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = 'tlotno���� ���忡 ������ �߻��Ͽ����ϴ�. '+  sqlpis.sqlerrtext
	Return false
End If

return true

end function

public function boolean wf_update_tstockcancel_interface (string fs_close_date);long ll_seqno,ll_inputqty
string ls_kbno,ls_deptcode,ls_itemcode,ls_invgubunflag

//ls_kbno     = is_areacode + is_divisioncode + 'XXXXXXXXX'
ls_kbno     = dw_sheet.object.proofno[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_invgubunflag = dw_sheet.object.invgubunflag[1]
ll_inputqty = dw_sheet.object.inputqty[1]

select max(seqno)
  into :ll_seqno
  from tstockcancel_interface
 where kbno          = :ls_kbno
	and kbreleasedate = :fs_close_date
	and kbreleaseseq  = 1
 using sqlpis;
if isnull(ll_seqno) then	  
	ll_seqno = 0
end if

ll_seqno = ll_seqno + 1
	
INSERT INTO Tstockcancel_interface  
		( kbno,kbreleasedate,kbreleaseseq,seqno,   
		  stockdate,areacode,divisioncode,workcenter,linecode,
		  itemcode,stockqty,
		  misflag,interfaceflag,lastemp,lastdate)
VALUES (:ls_kbno,:fs_close_date,1,:ll_seqno,
		  :fs_close_date,:is_areacode,:is_divisioncode,:ls_deptcode,:ls_invgubunflag,
		  :ls_itemcode,:ll_inputqty,
		  'A','Y',:g_s_empno,getdate())
  using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tstockcancel_interface : " + sqlpis.sqlerrtext
	return false
end if
return true


end function

public function boolean wf_errchk (string fs_column);string ls_deptcode,ls_deptname,ls_itemcode,ls_itemname,ls_itemspec,ls_itemtype,ls_item_check
long ll_inputqty,ll_count,ll_unitcost,ll_onhandqty

ll_inputqty = dw_sheet.object.inputqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
CHOOSE CASE fs_column
	CASE 'deptcode'
		  select deptname
		    into :ls_deptname
			 from tmstdept
  		   where deptcode = :ls_deptcode
			using sqlpis;
			  if ls_deptname = '' or isnull(ls_deptname) then
			  messagebox("Ȯ��","�̵�ϵ� �μ��Դϴ�.")
			  dw_sheet.object.deptcode[1] = ''
			  dw_sheet.object.deptname[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('deptcode')
			  return false
		  end if
		  dw_sheet.object.deptname[1] = ls_deptname
	CASE 'itemcode'
		  select itemname,itemspec
		    into :ls_itemname,:ls_itemspec
			 from tmstitem
  		   where itemcode = :ls_itemcode
//			  and areacode = :is_areacode
//			  and divisioncode = :is_divisioncode
			using sqlpis;
		  if sqlpis.sqlcode <> 0 then
			  messagebox("Ȯ��","�̵�ϵ� ǰ���Դϴ�.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  dw_sheet.object.itemname[1] = ls_itemname
		  dw_sheet.object.itemspec[1] = ls_itemspec
		  select top 1 productgroup
		    into :is_productgroup
			 from tmstmodel
			where areacode = :is_areacode
			  and divisioncode = :is_divisioncode
			  and itemcode = :ls_itemcode
			  using sqlpis;
		  if is_productgroup = '' or isnull(is_productgroup) then
			  is_productgroup = '00'
		  end if
		  ls_item_check = f_piss_itemtype_check(is_areacode,is_divisioncode,ls_itemcode)
		  if ls_item_check = 'ERROR' then
			  messagebox("Ȯ��","tmstmodel error�Դϴ�.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  if ls_item_check = '2' then
			  messagebox("Ȯ��","��ǰ�� �Է��� �� �����ϴ�.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  if ls_item_check = '3' or ls_item_check = '5' then //����ǰ �Ǵ� ����ǰ
		     select count(*) 
			    into :ll_count 
				 from tmstbom
				where areacode = :is_areacode
				  and divisioncode = :is_divisioncode
				  and bompitemno = :ls_itemcode
				  using sqlpis;
			  if ll_count = 0 then
				  messagebox("Ȯ��","BOM�� �̵�ϵ� ǰ���Դϴ�.")
				  dw_sheet.object.itemcode[1] = ''
				  dw_sheet.object.itemname[1] = ''
				  dw_sheet.object.itemspec[1] = ''
				  dw_sheet.setfocus()
				  dw_sheet.setcolumn('itemcode')
				  return false
			  end if
		     select unitcost 
			    into :ll_unitcost 
				 from tmstitemcost
				where areacode = :is_areacode
				  and divisioncode = :is_divisioncode
				  and itemcode = :ls_itemcode
				  using sqlpis;
			  if (ll_unitcost = 0) or isnull(ll_unitcost) then
				  messagebox("Ȯ��","�ܰ��� ���� ǰ���Դϴ�.")
				  dw_sheet.object.itemcode[1] = ''
				  dw_sheet.object.itemname[1] = ''
				  dw_sheet.object.itemspec[1] = ''
				  dw_sheet.setfocus()
				  dw_sheet.setcolumn('itemcode')
				  return false
			  end if
			  
		end if			     
	CASE 'inputqty'
		  if isnull(ll_inputqty) or ll_inputqty = 0 then
			  messagebox("Ȯ��","������ �Է��ϼ���.")
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('inputqty')
			  return false
		  end if
		  select invqty 
			    into :ll_onhandqty
				 from tinv
   		where areacode     = :is_areacode
			  and divisioncode = :is_divisioncode
			  and itemcode     = :ls_itemcode
		  using sqlpis;
		  if (ll_onhandqty - ll_inputqty) < 0 or isnull(ll_onhandqty) then
				messagebox("Ȯ��","��� �������� ��Ҽ����� �����ϴ�.")
			   dw_sheet.setfocus()
			   dw_sheet.setcolumn('inputqty')
			   return false
		  end if
END CHOOSE

return true
end function

public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate);dw_sheet.accepttext()
string ls_kbno,ls_temp_kbno,ls_temp_seqno,ls_deptcode,ls_productgroup,ls_itemcode,ls_invgubunflag
long ll_inputqty,ll_count,ll_invqty,ll_repairqty,ll_defectqty
string ls_close_date,ls_apply_date  //��������
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_apply_date = f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())

ll_inputqty     = dw_sheet.object.inputqty[1]
ls_deptcode     = dw_sheet.object.deptcode[1]
ls_itemcode     = dw_sheet.object.itemcode[1]
ls_invgubunflag = dw_sheet.object.invgubunflag[1]
ll_invqty = 0
ll_repairqty = 0
ll_defectqty = 0
if wf_update_tlotno(ls_close_date) = false then
	uo_status.st_message.text = "Tstockcancel_interface insert�� ������ �߻��Ͽ����ϴ�."
   Return false
End if
if wf_update_tstocketc() = false then
	uo_status.st_message.text = "Tstocketc insert�� ������ �߻��Ͽ����ϴ�."
   Return false
End if
//interface
if wf_update_tstockcancel_interface(ls_apply_date) = false then
	uo_status.st_message.text = "Tstockcancel_interface insert�� ������ �߻��Ͽ����ϴ�."
   Return false
End if

if ls_invgubunflag = 'N' then
	ll_invqty = ll_inputqty
elseif ls_invgubunflag = 'R' then
	ll_repairqty = ll_inputqty
else
	ll_defectqty = ll_inputqty
end if
	
//â�� �԰���ҽ� tinv
select count(*)
  into :ll_count
  from tinv
 where ItemCode	  = :ls_itemcode
	and areacode     = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if ll_count > 0 then
	Update tinv
		set Invqty	 = invqty - :ll_invqty,
		    repairqty = repairqty - :ll_repairqty,
			 defectqty = defectqty - :ll_defectqty,
			 LastEmp	 = 'Y',
			 LastDate = GetDate()
	 where ItemCode	  = :ls_itemcode
		and areacode     = :fs_areacode
		and divisioncode = :fs_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty,repairqty,defectqty,Lastemp, lastDate)
			Values(:fs_areacode,:fs_divisioncode,:ls_itemcode, &
					 :ll_invqty * -1,:ll_repairqty * -1, :ll_defectqty * -1,'Y', Getdate())
	using sqlpis;
end if
if sqlpis.sqlcode = 0 then
Else
	uo_status.st_message.text = "TINV insert�� ������ �߻��Ͽ����ϴ�."
	Return false
End if
return true
end function

on w_piss330u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_sheet=create dw_sheet
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_sheet
this.Control[iCurrent+5]=this.gb_1
end on

on w_piss330u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_sheet)
destroy(this.gb_1)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)

end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;//long ll_count
//
//setpointer(hourglass!)
//ll_count = dw_1.retrieve(is_prddate,is_areacode,is_divisioncode)
//setpointer(arrow!)
//if ll_count = 0 then
//	messagebox("Ȯ��","��ȸ�� �ڷᰡ �����ϴ�.")
//	uo_date.setfocus()
//	return
//end if	
end event

event ue_save;string ls_deptcode,ls_itemcode,ls_invgubunflag
long   ll_inputqty
int net
dw_sheet.accepttext()
string ls_close_date  //��������
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

ll_inputqty = dw_sheet.object.inputqty[1]
ls_deptcode = trim(dw_sheet.object.deptcode[1])
ls_itemcode = trim(dw_sheet.object.itemcode[1])
ls_invgubunflag = trim(dw_sheet.object.invgubunflag[1])

if ls_deptcode = '' or isnull(ls_deptcode) then
	messagebox("Ȯ��","�μ��ڵ带 �Է��ϼ���.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('deptcode')
	return
end if	

if ls_itemcode = '' or isnull(ls_itemcode) then
	messagebox("Ȯ��","ǰ���� �Է��ϼ���.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('itemcode')
	return
end if	
if ls_invgubunflag = '' or isnull(ls_invgubunflag) then
	messagebox("Ȯ��","������ �Է��ϼ���.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('invgubunflag')
	return
end if	
if ll_inputqty = 0 or isnull(ll_inputqty) then
	messagebox("Ȯ��","������ �Է��ϼ���.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('inputqty')
	return
end if	

sqlpis.autocommit = false
if wf_save(is_areacode,is_divisioncode,is_kbno) then
   commit using sqlpis;
else
   rollback using sqlpis;
end if

sqlpis.autocommit = true

string ls_proofno
ls_proofno = dw_sheet.object.proofno[1]
messagebox("Ȯ��",'������ ��ȣ : ' + mid(ls_proofno,1,4) + '-' + mid(ls_proofno,5,3) + '-' + right(ls_proofno,4))

dw_sheet.reset()
dw_sheet.setfocus()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
end event

event ue_postopen;call super::ue_postopen;dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
dw_sheet.setfocus()
end event

event ue_insert;dw_sheet.reset()
dw_sheet.insertrow(0)
dw_sheet.setfocus()
dw_sheet.setcolumn('deptcode')

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss330u
end type

type uo_area from u_pisc_select_area within w_piss330u
integer x = 795
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
dw_sheet.setfocus()
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

type uo_division from u_pisc_select_division within w_piss330u
integer x = 1367
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_sheet.reset()
is_divisioncode = is_uo_divisioncode
dw_sheet.insertrow(0)
dw_sheet.setcolumn('deptcode')
dw_sheet.setfocus()

end event

type uo_date from u_pisc_date_applydate within w_piss330u
integer x = 55
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;is_prddate = is_uo_date
end event

event ue_select;call super::ue_select;if is_prddate <> is_uo_date then
	dw_sheet.reset()
end if	
is_prddate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

type dw_sheet from datawindow within w_piss330u
integer x = 32
integer y = 216
integer width = 1554
integer height = 1080
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss330u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
if wf_errchk(dwo.name) = false then
    return 1
end if	 
end event

event itemerror;return 1
end event

type gb_1 from groupbox within w_piss330u
integer x = 23
integer y = 28
integer width = 2016
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

