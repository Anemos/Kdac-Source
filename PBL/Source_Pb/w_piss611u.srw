$PBExportHeader$w_piss611u.srw
$PBExportComments$Container Shipping Label
forward
global type w_piss611u from w_ipis_sheet01
end type
type gb_2 from groupbox within w_piss611u
end type
type uo_area from u_pisc_select_area within w_piss611u
end type
type uo_division from u_pisc_select_division within w_piss611u
end type
type gb_1 from groupbox within w_piss611u
end type
type dw_2 from u_vi_std_datawindow within w_piss611u
end type
type st_3 from statictext within w_piss611u
end type
type em_1 from editmask within w_piss611u
end type
type dw_3 from datawindow within w_piss611u
end type
type em_2 from editmask within w_piss611u
end type
type st_2 from statictext within w_piss611u
end type
type st_4 from statictext within w_piss611u
end type
type em_3 from editmask within w_piss611u
end type
type st_5 from statictext within w_piss611u
end type
type em_4 from editmask within w_piss611u
end type
type dw_print from datawindow within w_piss611u
end type
type uo_customer from u_piss_select_labelcustomer within w_piss611u
end type
type uo_label from u_piss_select_labelgubun within w_piss611u
end type
type cb_addlabel from commandbutton within w_piss611u
end type
type pb_print from picturebutton within w_piss611u
end type
type st_6 from statictext within w_piss611u
end type
end forward

global type w_piss611u from w_ipis_sheet01
integer width = 3666
gb_2 gb_2
uo_area uo_area
uo_division uo_division
gb_1 gb_1
dw_2 dw_2
st_3 st_3
em_1 em_1
dw_3 dw_3
em_2 em_2
st_2 st_2
st_4 st_4
em_3 em_3
st_5 st_5
em_4 em_4
dw_print dw_print
uo_customer uo_customer
uo_label uo_label
cb_addlabel cb_addlabel
pb_print pb_print
st_6 st_6
end type
global w_piss611u w_piss611u

type variables
Boolean	ib_open
string is_revno
end variables

forward prototypes
public function integer wf_save_form ()
public function integer wf_label_form (integer ag_printcount)
public function integer wf_label_ford (integer ag_printcount)
public function integer wf_label_dra (integer ag_printcount)
public function integer wf_label_print ()
public function integer wf_save_dra ()
public function integer wf_save_ford ()
public function integer wf_save_odette ()
public function integer wf_label_odette (integer ag_printcount)
end prototypes

public function integer wf_save_form ();
string	ls_areacode,			ls_divisioncode,				ls_customercode,&
			ls_customeritemcode,	ls_invoiceno,					ls_lotno,&
			ls_purchaseno,			ls_tracedate,					ls_unit,&
			ls_customerdivision,	ls_customerplantaddress,	ls_suppliercode,&
			ls_suppliername, 		ls_segment1, 					ls_segment2,&
			ls_segment3,			ls_customerplantcity,		ls_customerstate,&
			ls_customerpostal,	ls_plantdock,					ls_deliverylocation,&
			ls_revisionno, 		ls_suppliercity,				ls_supplierpostal,&
			ls_countryoforigin
integer	li_serialnofrom, li_serial, li_labelcount,	li_shipqty, li_selcount
string ls_customerplantaddress2, ls_customerno, ls_itemcode, ls_engalert
string ls_supplierno, ls_containerno, ls_partdesc, ls_partno
int li_grosswgt, li_standardpackqty, li_shift, li_lotsize
string ls_workcenter, ls_dockcode, ls_labelgubun, ls_message

dw_3.accepttext()
// Common Data Gathering
ls_unit						= dw_3.getitemstring(1, 'unit')
ls_customercode			= dw_3.getitemstring(1, 'customercode')
ls_suppliercode			= dw_3.getitemstring(1, 'suppliercode')
ls_suppliername			= dw_3.getitemstring(1, 'suppliername')
ls_segment1					= dw_3.getitemstring(1, 'segment1')
ls_segment2					= dw_3.getitemstring(1, 'segment2')
ls_areacode					= dw_3.getitemstring(1, 'areacode')
ls_divisioncode 			= dw_3.getitemstring(1, 'divisioncode')
ls_customeritemcode 		= dw_3.getitemstring(1, 'customeritemcode')
ls_customerdivision		= dw_3.getitemstring(1, 'customerdivision')
ls_customerplantaddress = dw_3.getitemstring(1, 'customerplantaddress')
ls_customerplantcity		= dw_3.getitemstring(1, 'customercity')
ls_customerstate			= dw_3.getitemstring(1, 'customerstate')
ls_plantdock				= dw_3.getitemstring(1, 'plantdock')
ls_deliverylocation		= dw_3.getitemstring(1, 'deliverylocation')
ls_suppliercity			= dw_3.getitemstring(1, 'suppliercity')
ls_countryoforigin		= dw_3.getitemstring(1, 'countryoforigin')
li_serialnofrom			= dw_3.getitemnumber(1, 'serialnofrom')
li_shipqty					= dw_3.getitemnumber(1, 'shipqty')
li_labelcount				= dw_3.getitemnumber(1, 'labelcount')
ls_tracedate				= dw_3.getitemstring(1, 'tracedate')
ls_labelgubun				= dw_3.getitemstring(1, 'labelgubun')
ls_invoiceno				= dw_3.getitemstring(1, 'invoiceno')
ls_customerpostal			= dw_3.getitemstring(1, 'customerpostal')
ls_supplierpostal			= dw_3.getitemstring(1, 'supplierpostal')
ls_segment3					= dw_3.getitemstring(1, 'segment3')
ls_revisionno				= dw_3.getitemstring(1, 'revisionno')
ls_lotno						= dw_3.getitemstring(1, 'lotno')
ls_purchaseno				= dw_3.getitemstring(1, 'purchaseno')

if trim(f_dateedit(ls_tracedate)) = ''	then
	messagebox('Ȯ��','��¥ ü�谡 Ʋ���ϴ�.')
	return -1
end if

sqlpis.Autocommit = False

select isnull(count(*),0) into :li_selcount
from tshiplabelcustomer
WHERE customercode = :ls_customercode and labelgubun = :ls_labelgubun 
using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tshiplabelcustomer
	set	suppliercode	= :ls_suppliercode,
			suppliername	= :ls_suppliername,
			segment1			= :ls_segment1,
			segment2			= :ls_segment2,
			segment3			= :ls_segment3
	where	customercode = :ls_customercode and labelgubun = :ls_labelgubun
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into
	tshiplabelcustomer(customercode, labelgubun, suppliercode,	suppliername,
						segment1,		segment2,			segment3)
	values(:ls_customercode,	:ls_labelgubun, :ls_suppliercode, :ls_suppliername,
				:ls_segment1, :ls_segment2, :ls_segment3)
				using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if
	
select count(*) into :li_selcount
from tshiplabelitem
WHERE areacode				= :ls_areacode and
		divisioncode		= :ls_divisioncode and
		customercode		= :ls_customercode and
		customeritemcode	= :ls_customeritemcode and
		labelgubun 			= :ls_labelgubun
		using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tshiplabelitem
	set	itemcode					= :ls_itemcode,
			unit						= :ls_unit,
			customerdivision		= :ls_customerdivision,
			customerplantaddress	= :ls_customerplantaddress,
			customerplantaddress2 = :ls_customerplantaddress2,
			customerplantcity		= :ls_customerplantcity,
			customerstate			= :ls_customerstate,
			customerpostal			= :ls_customerpostal,
			plantdock				= :ls_plantdock,
			deliverylocation		= :ls_deliverylocation,
			revisionno				= :ls_revisionno,
			suppliercity			= :ls_suppliercity,
			supplierpostal			= :ls_supplierpostal,
			countryoforigin		= :ls_countryoforigin,
			labelgubun				= :ls_labelgubun,
			customerno				= :ls_customerno,
			supplierno				= :ls_supplierno,
			partno					= :ls_partno,
			partdesc					= :ls_partdesc,
			engalert					= :ls_engalert,
			containerno				= :ls_containerno,
			dockcode					= :ls_dockcode,
			workcenter				= :ls_workcenter,
			shift						= :li_shift,
			lotsize					= :li_lotsize
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			labelgubun 			= :ls_labelgubun 
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR03 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into tshiplabelitem
			(areacode,						divisioncode,				customercode,
			 customeritemcode,			labelgubun,
			 unit,							customerdivision,
			 customerplantaddress,		customerplantcity,		customerstate,
			 customerpostal,				plantdock,					deliverylocation,
			 revisionno,					suppliercity,				supplierpostal,
		 	 countryoforigin,				customerno,
			 supplierno,					itemcode,					partdesc,
			 engalert,						containerno,				dockcode,						
			 workcenter,					shift,						lotsize,						
			 customerplantaddress2,		partno)		 
	values(:ls_areacode,					:ls_divisioncode,			:ls_customercode,
			 :ls_customeritemcode,		:ls_labelgubun,
			 :ls_unit,						:ls_customerdivision,
			 :ls_customerplantaddress,	:ls_customerplantcity,	:ls_customerstate,
			 :ls_customerpostal,			:ls_plantdock,				:ls_deliverylocation,
			 :ls_revisionno,				:ls_suppliercity,			:ls_supplierpostal,
			 :ls_countryoforigin,		:ls_customerno,
			 :ls_supplierno,				:ls_itemcode,				:ls_partdesc,
			 :ls_engalert,					:ls_containerno,			:ls_dockcode,					
			 :ls_workcenter,				:li_shift,					:li_lotsize,				
			 :ls_customerplantaddress2,:ls_partno)  
	using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR04 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if

//if li_serialnofrom = 0 or isnull(li_serialnofrom) then
	select isnull(sum(labelcount),0)	into :li_serial from tshiplabelcontainer
	where areacode				= 	:ls_areacode		 and
			divisioncode		=	:ls_divisioncode and
			customercode		=	:ls_customercode and
			customeritemcode	=	:ls_customeritemcode and
			invoiceno			=	:ls_invoiceno and
			labelgubun			=  :ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_serial = 0
	end if
	
	if li_serialnofrom = 0 then
		li_serialnofrom = li_serial + 1
	else
		li_serialnofrom = li_serialnofrom
	end if
	
	select count(*) into :li_selcount
	from tshiplabelcontainer
	where areacode				= 	:ls_areacode		 and
			divisioncode		= 	:ls_divisioncode and
			customercode		= 	:ls_customercode and
			customeritemcode	= 	:ls_customeritemcode and
			invoiceno			=	:ls_invoiceno		and
			serialnofrom		=	:li_serialnofrom	and
			labelgubun			= 	:ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_selcount = 0
	end if
	
	if li_selcount = 0 then
		insert	into tshiplabelcontainer
				(areacode,				divisioncode,			customercode,		customeritemcode,
				 invoiceno,				serialnofrom,			labelgubun,
				 labelcount,			lotno,
				 shipqty,				purchaseno,				tracedate,			grosswgt,
				 standardpackqty )		 
		values(:ls_areacode,			:ls_divisioncode,		:ls_customercode, :ls_customeritemcode,
				 :ls_invoiceno,		:li_serialnofrom,		:ls_labelgubun,
				 :li_labelcount,		:ls_lotno,
				 :li_shipqty,			:ls_purchaseno,		:ls_tracedate,		:li_grosswgt,
				 :li_standardpackqty)  using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			ls_message = "ERR05 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	else
		update	tshiplabelcontainer
		set	lotno					=	:ls_lotno,
				shipqty				=	:li_shipqty,
				labelcount			=  :li_labelcount,
				purchaseno			=	:ls_purchaseno,
				tracedate			=	:ls_tracedate,
				grosswgt				= 	:li_grosswgt,
				standardpackqty	= 	:li_standardpackqty
		where areacode				= :ls_areacode		 and
				divisioncode		= :ls_divisioncode and
				customercode		= :ls_customercode and
				customeritemcode	= :ls_customeritemcode and
				invoiceno			=	:ls_invoiceno		and
				serialnofrom		=	:li_serialnofrom	and
				labelgubun			=  :ls_labelgubun using sqlpis ;
		if sqlpis.sqlnrows = 0 then
			ls_message = "ERR06 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	end if
//end if
Commit using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
triggerevent("ue_retrieve")

RollBack_:
Rollback using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end function

public function integer wf_label_form (integer ag_printcount);string	ls_customercode, ls_customeritemcode, ls_customeritemname, ls_suppliercode,&
			ls_deliverylocation,	ls_revisionno, ls_plantdock, ls_lotno, ls_segment1,&
			ls_segment2, ls_segment3,	ls_tracedate, ls_purchaseno, ls_suppliername,&
			ls_areacode, ls_divisioncode, ls_suppliercity, ls_supplierpostal, ls_countryoforigin,&
			ls_invoiceno, ls_unit, ls_customeritemcodebar, ls_lotnobar
boolean	lb_null = False
int		li_row, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount
int			li_sumitemcode, li_sumitemcode1, li_remainitemcode
int			li_sumlotno, li_sumlotno1, li_remainlotno
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	   if dw_2.isselected(li_selectedcount) <> true then
			continue
		end if
		
		//Null Value Check
		ls_customeritemcode		= dw_2.getitemstring(li_selectedcount,'customeritemcode')
		ls_customeritemname		= dw_2.getitemstring(li_selectedcount,'customeritemname')
		li_shipqty					= dw_2.getitemnumber(li_selectedcount,'shipqty')
		ls_purchaseno				= dw_2.getitemstring(li_selectedcount,'purchaseno')
		ls_revisionno				= dw_2.getitemstring(li_selectedcount,'revisionno')
		ls_divisioncode			= dw_2.getitemstring(li_selectedcount,'Divisioncode')
		ls_deliverylocation		= dw_2.getitemstring(li_selectedcount,'deliverylocation')
		li_serialnofrom			= dw_2.getitemnumber(li_selectedcount,'serialnofrom')
		ls_plantdock				= dw_2.getitemstring(li_selectedcount,'plantdock')
		ls_lotno						= dw_2.getitemstring(li_selectedcount,'lotno')
		ls_segment1					= dw_2.getitemstring(li_selectedcount,'segment1')
		ls_segment2					= dw_2.getitemstring(li_selectedcount,'segment2')
		ls_segment3					= dw_2.getitemstring(li_selectedcount,'segment3')
		ls_suppliercode			= dw_2.getitemstring(li_selectedcount,'suppliercode')
		ls_tracedate				= dw_2.getitemstring(li_selectedcount,'tracedate')
	   ls_suppliername			= dw_2.getitemstring(li_selectedcount,'suppliername')		
	   ls_suppliercity			= dw_2.getitemstring(li_selectedcount,'suppliercity')
	   ls_supplierpostal			= dw_2.getitemstring(li_selectedcount,'supplierpostal')   	
	   ls_countryoforigin		= dw_2.getitemstring(li_selectedcount,'countryoforigin')
		li_labelcount				= dw_2.getitemnumber(li_selectedcount, 'labelcount')
		ls_invoiceno				= dw_2.getitemstring(li_selectedcount, 'invoiceno')
		ls_unit						= dw_2.getitemstring(li_selectedcount, 'unit')
//		SELECT suppliercode, inventorycode, weight, uselocation, itemcode, revisionno
//		  into :ls_suppliercode, :ls_inventorycode, :ll_weightheader, :ls_uselocation, :ls_itemcode, :ls_revisionno
//		 FROM tshiplabelheader
//		WHERE areacode 		  = :ls_areacode and
//		      divisioncode	  = :ls_divisioncode and
//				customercode 	  = :ls_customercode and
//				customeritemcode = :ls_customeritemcode and
//		      lotqty			  = :li_lotqty
//		using sqlpis  ;
//		
	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	li_row = 0
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		for li_currentprintcount = 1 to ag_printcount
			li_row ++	
			li_sumitemcode = 104
			ls_customeritemcodebar = 'P'+ls_customeritemcode
//			for li_codeCount	= 1 to len(ls_CustomerItemCodebar)
//				if len(trim(mid(ls_customeritemcodebar,li_codecount,1))) = 0 then
//					li_sumitemcode = li_sumitemcode + (00 * li_codecount)
//				else
//					li_sumitemcode = li_sumitemcode + ((asc(mid(ls_customeritemcodebar,li_codecount,1))-32) * li_codecount)
//				end if
//			next
//			li_sumitemcode1 = li_sumitemcode / 103
////			li_remainitemcode = (li_sumitemcode - (li_sumitemcode1*103))+32
//			li_remainitemcode = (li_sumitemcode - (li_sumitemcode1*103))
//			if li_remainitemcode = 00 then
//				li_remainitemcode =	li_remainitemcode + 194
//			elseif li_remainitemcode > 194 then
//						li_remainitemcode =	li_remainitemcode + 100
//			else
//						li_remainitemcode =	li_remainitemcode + 32
//			end if
			li_remainitemcode = f_piss_convert_code128_remainder( 'B', trim(ls_customeritemcodebar) )
			dw_print.insertrow(li_row)
			dw_print.setitem(li_row,'customeritemcode',ls_customeritemcode)
			dw_print.setitem(li_row,'divisioncode',ls_divisioncode)
			dw_print.setitem(li_row,'remainitemcode',li_remainitemcode)
			dw_print.setitem(li_row,'customeritemname',ls_customeritemname)
			dw_print.setitem(li_row,'shipqty',li_shipqty)
			dw_print.setitem(li_row,'purchaseno',ls_purchaseno)
			dw_print.setitem(li_row,'revisionno',ls_revisionno)
			dw_print.setitem(li_row,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_row,'divisioncode',ls_divisioncode)
			dw_print.setitem(li_row,'invoiceno',ls_invoiceno)
			dw_print.setitem(li_row,'serialnofrom',li_serialnofrom1)
			dw_print.setitem(li_row,'plantdock',ls_plantdock)
			dw_print.setitem(li_row,'lotno',ls_lotno)
			li_sumlotno = 104
			ls_lotnobar = '1T'+ls_lotno
//			for li_codeCount	= 1 to len(ls_lotnobar)
//				if len(trim(mid(ls_lotnobar,li_codecount,1))) = 0 then
//					li_sumlotno = li_sumlotno + (0 * li_codecount)
//				else
//					li_sumlotno = li_sumlotno + ((asc(mid(ls_lotnobar,li_codecount,1))-32) * li_codecount)
//				end if
//			next
//			li_sumlotno1 = li_sumlotno / 103
////			li_remainlotno = (li_sumlotno - (li_sumlotno1*103))+32
//			li_remainlotno = (li_sumlotno - (li_sumlotno1*103))
//			if li_remainlotno = 0 then
//				li_remainlotno =	li_remainlotno + 194
//			elseif li_remainlotno > 194 then
//						li_remainlotno =	li_remainlotno + 100
//			else
//						li_remainlotno =	li_remainlotno + 32
//			end if	
			li_remainlotno = f_piss_convert_code128_remainder( 'B', trim(ls_lotnobar) )
			dw_print.setitem(li_row,'remainlotno',li_remainlotno)
			dw_print.setitem(li_row,'segment1',ls_segment1)
			dw_print.setitem(li_row,'segment2',ls_segment2)
			dw_print.setitem(li_row,'segment3',ls_segment3)
			dw_print.setitem(li_row,'suppliercode',ls_suppliercode)
			dw_print.setitem(li_row,'tracedate',ls_tracedate)
			dw_print.setitem(li_row,'suppliername',ls_suppliername)
			dw_print.setitem(li_row,'suppliercity',ls_suppliercity)
			dw_print.setitem(li_row,'supplierpostal',ls_supplierpostal)
			dw_print.setitem(li_row,'countryoforigin',ls_countryoforigin)
			dw_print.setitem(li_row,'unit',ls_unit)
		next
	next
Next
if li_printcount > 0 then	
	return 0
else
	return -1
end if
				


end function

public function integer wf_label_ford (integer ag_printcount);boolean	lb_null = False
int		li_currow, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount
int		li_grosswgt, li_standardpackqty, li_shift, li_lotsize
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount
string 	ls_suppliername, ls_segment1, ls_segment2, ls_suppliercity, ls_countryoforigin
string	ls_customerdivision, ls_customaddr, ls_customaddr2, ls_customeritemcode
string	ls_customercity, ls_customerstate, ls_plantdock, ls_deliverylocation, ls_bar2d
string 	ls_customerno, ls_engalert, ls_supplierno, ls_containerno, ls_partdesc
string	ls_workcenter, ls_tracedate, ls_dockcode, ls_pkgid, ls_itemcode, ls_unit
string   ls_areacode, ls_divisioncode, ls_customercode, ls_invoiceno, ls_partitemcode

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	if dw_2.isselected(li_selectedcount) <> true then
		continue
	end if
	// ���� ��ǰ�� ��ȸ�ϱ�
	ls_customercode		= 	dw_2.getitemstring(li_selectedcount, 'customercode')
	ls_areacode				= 	dw_2.getitemstring(li_selectedcount, 'areacode')
	ls_divisioncode 		= 	dw_2.getitemstring(li_selectedcount, 'divisioncode')
	ls_customeritemcode	=	Trim(dw_2.getitemstring(li_selectedcount, 'customeritemcode'))
	ls_invoiceno 			= 	Trim(dw_2.getitemstring(li_selectedcount, 'invoiceno'))
	li_serialnofrom		= 	dw_2.getitemnumber(li_selectedcount, 'serialnofrom')

	li_codecount	=	dw_3.retrieve(ls_areacode,			ls_divisioncode,&
									  ls_customercode,	ls_customeritemcode,&
									  ls_invoiceno,		li_serialnofrom)
	if li_codecount < 1 then
		continue
	end if
	//Null Value Check
	ls_suppliername		= dw_3.getitemstring(1,'suppliername')		
	ls_segment1				= dw_3.getitemstring(1,'segment1')
	ls_segment2				= dw_3.getitemstring(1,'segment2')
	ls_suppliercity			= trim(dw_3.getitemstring(1,'suppliercity')) + ", " + dw_3.getitemstring(1,'countryoforigin')
	ls_customeritemcode	= dw_3.getitemstring(1,'partno')
//	ls_countryoforigin	= dw_3.getitemstring(1,'countryoforigin')
	ls_customerdivision	= dw_3.getitemstring(1,'customerdivision')
	ls_customaddr			= dw_3.getitemstring(1,'customerplantaddress')
	ls_customaddr2			= dw_3.getitemstring(1,'customerplantaddress2')
	ls_customercity		= dw_3.getitemstring(1,'customercity')
	ls_customerstate		= dw_3.getitemstring(1,'customerstate')
	ls_plantdock			= dw_3.getitemstring(1,'plantdock')
	ls_deliverylocation	= dw_3.getitemstring(1,'deliverylocation')
	ls_customerno			= dw_3.getitemstring(1,'customerno')
	ls_itemcode				= dw_3.getitemstring(1,'itemcode')
	ls_engalert				= dw_3.getitemstring(1,'engalert')
	ls_supplierno			= dw_3.getitemstring(1,'supplierno')
	ls_containerno			= dw_3.getitemstring(1,'containerno')
	ls_partdesc				= dw_3.getitemstring(1,'partdesc')
	ls_workcenter			= dw_3.getitemstring(1,'workcenter')
	ls_tracedate			= dw_3.getitemstring(1,'tracedate')
	ls_dockcode				= dw_3.getitemstring(1,'dockcode')
	ls_unit					= dw_3.getitemstring(1,'unit')
	li_shipqty				= dw_3.getitemnumber(1,'shipqty')
	li_grosswgt				= ( dw_3.getitemnumber(1, 'grosswgt') * 2.25 )
	li_standardpackqty	= dw_3.getitemnumber(1,'standardpackqty')
	li_shift					= dw_3.getitemnumber(1,'shift')
	li_lotsize				= dw_3.getitemnumber(1,'lotsize')
//	if ls_customeritemcode = '892940' then
//		ls_lotno = 'C02' + ls_lotno + '1'
//	end if
	li_serialnofrom			= dw_3.getitemnumber(1,'serialnofrom')
	li_labelcount				= dw_3.getitemnumber(1, 'labelcount')

	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		//ls_pkgid = string(li_serialnofrom1)
		for li_currentprintcount = 1 to ag_printcount
			li_currow = dw_print.insertrow(0)
			dw_print.setitem(li_currow,'suppliername',ls_suppliername)
			dw_print.setitem(li_currow,'segment1',ls_segment1)
			dw_print.setitem(li_currow,'segment2',ls_segment2)
			dw_print.setitem(li_currow,'suppliercity',ls_suppliercity)
//			dw_print.setitem(li_currow,'countryoforigin',ls_countryoforigin)
			dw_print.setitem(li_currow,'customerdivision',ls_customerdivision)
			dw_print.setitem(li_currow,'customerplantaddress',ls_customaddr)
			dw_print.setitem(li_currow,'customerplantaddress2',ls_customaddr2)
			dw_print.setitem(li_currow,'customerplantcity',ls_customercity)
			dw_print.setitem(li_currow,'customerstate',ls_customerstate)
			dw_print.setitem(li_currow,'plantdock',ls_plantdock)
			dw_print.setitem(li_currow,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_currow,'customerno',ls_customerno)
			dw_print.setitem(li_currow,'customeritemcode',ls_customeritemcode)
			dw_print.setitem(li_currow,'engalert',ls_engalert)
			dw_print.setitem(li_currow,'supplierno',ls_supplierno)
			dw_print.setitem(li_currow,'containerno',ls_containerno)
			dw_print.setitem(li_currow,'itemcode',ls_itemcode)
			dw_print.setitem(li_currow,'partdesc',ls_partdesc)
			dw_print.setitem(li_currow,'workcenter',ls_workcenter)
			dw_print.setitem(li_currow,'shift',li_shift)
			dw_print.setitem(li_currow,'lotsize',li_lotsize)
			dw_print.setitem(li_currow,'dockcode',ls_dockcode)
			dw_print.setitem(li_currow,'unit',ls_unit)
			dw_print.setitem(li_currow,'tracedate', upper(string(date(string(ls_tracedate,"@@@@-@@-@@")),"DDMMMYYYY")))
			dw_print.setitem(li_currow,'shipqty',li_shipqty)
			dw_print.setitem(li_currow,'grosswgt',li_grosswgt)
			dw_print.setitem(li_currow,'standardpackqty',li_standardpackqty)
			ls_pkgid = upper(ls_divisioncode) + upper(right(ls_invoiceno,4)) +'-'+string(li_serialnofrom1,'000')
			dw_print.setitem(li_currow,'serialnofrom',ls_pkgid)
			// Calculate Barcode by code128
			ls_partitemcode = f_replace_dash_blank(trim(ls_customeritemcode))
			dw_print.setitem(li_currow,'customeritemcodebar', &
				char(204) + f_piss_convert_code128( 'B', 'P' + ls_partitemcode ) + char(206))
			dw_print.setitem(li_currow,'shipqtybar', &
				char(204) + f_piss_convert_code128( 'B', 'Q' + String(li_shipqty) ) + char(206))
			dw_print.setitem(li_currow,'suppliernobar', &
				char(204) + f_piss_convert_code128( 'B', 'V' + trim(ls_supplierno) ) + char(206))
			dw_print.setitem(li_currow,'serialnofrombar', &
				char(204) + f_piss_convert_code128( 'B', '3S' + trim(ls_pkgid) ) + char(206))
			// Calculate Barcode by BAR2D
			string ls_data
			ls_data =	char(91) + char(41) + char(62) + char(30) + "06" + char(29) +  &  
						"P" + mid(ls_customeritemcode,1,4) + " " + mid(ls_customeritemcode,6,6) + " " + mid(ls_customeritemcode,13,2) + char(29) + & 
						"Q" + String(li_shipqty)       + char(29) + &
						"V" +  trim(ls_supplierno)    + char(29) + &
						"D" +  upper(string(date(string(ls_tracedate,"@@@@-@@-@@")),"YYMMDD")) +  char(29) + &
						"3S" + trim(ls_pkgid) + char(30) + char(04)
			ls_bar2d = f_get_2dbarcode( ls_data )
			dw_print.setitem(li_currow,'bar2d',ls_bar2d)
		next
	next
Next

if li_printcount > 0 then
	return 0
else
	return -1
end if
				


end function

public function integer wf_label_dra (integer ag_printcount);string	ls_suppliername, ls_suppliercity, ls_supplierpostal, ls_suppliercode
string   ls_customername, ls_customeraddr1, ls_customeraddr2, ls_plantdock, ls_deliverylocation
string   ls_customeritemcode, ls_customeritemname, ls_revisionno, ls_tracedate, ls_countryoforigin
string   ls_purchaseno, ls_pkgid, ls_pkglistno, ls_lotno, ls_plantno, ls_suppliercity1
boolean	lb_null = False
int		li_currow, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount
int			li_sumitemcode, li_sumitemcode1, li_remainitemcode
int			li_sumlotno, li_sumlotno1, li_remainlotno
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	if dw_2.isselected(li_selectedcount) <> true then
		continue
	end if
	
	//Null Value Check
	ls_suppliername			= dw_2.getitemstring(li_selectedcount,'suppliername')		
	ls_suppliercity			= dw_2.getitemstring(li_selectedcount,'suppliercity')
	ls_suppliercity1			= dw_2.getitemstring(li_selectedcount,'suppliercity1')
	ls_suppliercode			= dw_2.getitemstring(li_selectedcount,'suppliercode')
	ls_customername			= dw_2.getitemstring(li_selectedcount,'customername')
	ls_customeraddr1			= dw_2.getitemstring(li_selectedcount,'customeraddr1')
	ls_customeraddr2			= dw_2.getitemstring(li_selectedcount,'customeraddr2')
	ls_plantdock				= dw_2.getitemstring(li_selectedcount,'plantdock')
	ls_plantno					= dw_2.getitemstring(li_selectedcount,'customerdivision')
	ls_deliverylocation		= dw_2.getitemstring(li_selectedcount,'deliverylocation')
	ls_customeritemcode		= dw_2.getitemstring(li_selectedcount,'customeritemcode')
	ls_customeritemname		= dw_2.getitemstring(li_selectedcount,'customeritemname')
	ls_revisionno				= dw_2.getitemstring(li_selectedcount,'revisionno')
	ls_tracedate				= dw_2.getitemstring(li_selectedcount,'tracedate')
	ls_countryoforigin		= dw_2.getitemstring(li_selectedcount,'countryoforigin')
	li_shipqty					= dw_2.getitemnumber(li_selectedcount,'shipqty')
	ls_purchaseno				= dw_2.getitemstring(li_selectedcount,'purchaseno')
	ls_pkgid						= trim(dw_2.getitemstring(li_selectedcount,'pkgid'))
	ls_pkglistno				= trim(dw_2.getitemstring(li_selectedcount,'packinglistno'))
	ls_lotno						= dw_2.getitemstring(li_selectedcount,'lotno')
	if is_revno = 'R01' then
		if ls_customeritemcode = '19020618' or ls_customeritemcode = '892940' then
			ls_lotno = 'A02' + ls_lotno + '1'
		elseif ls_customeritemcode = '19020706' or ls_customeritemcode = '889955' then
			ls_lotno = 'C02' + ls_lotno + '1'
		elseif ls_customeritemcode = '19020707' or ls_customeritemcode = '889956' then
			ls_lotno = 'C02' + ls_lotno + '1'
		elseif ls_customeritemcode = '8400080' or ls_customeritemcode = '897755' then
			ls_lotno = 'D02' + ls_lotno + '1'
		else
			Messagebox("�˸�", "�� Revision�� ���� �ʴ� ǰ���� ���õǾ� �ֽ��ϴ�.")
			dw_print.reset()
			li_printcount = 0
			exit
		end if
	else
		ls_lotno = 'C02' + ls_lotno + '1'
	end if
	li_serialnofrom			= dw_2.getitemnumber(li_selectedcount,'serialnofrom')
	li_labelcount				= dw_2.getitemnumber(li_selectedcount, 'labelcount')

	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		ls_pkgid = string(li_serialnofrom1)
		for li_currentprintcount = 1 to ag_printcount
			li_currow = dw_print.insertrow(0)
			dw_print.setitem(li_currow,'suppliername',ls_suppliername)
			dw_print.setitem(li_currow,'suppliercity',ls_suppliercity)
			dw_print.setitem(li_currow,'supplierpostal',ls_suppliercity1)
			dw_print.setitem(li_currow,'suppliercode',ls_suppliercode)
			dw_print.setitem(li_currow,'customername',ls_customername)
			dw_print.setitem(li_currow,'customeraddr1',ls_customeraddr1)
			dw_print.setitem(li_currow,'customeraddr2',ls_customeraddr2)
			dw_print.setitem(li_currow,'plantdock',ls_plantdock)
			dw_print.setitem(li_currow,'customerdivision',ls_plantno)
			dw_print.setitem(li_currow,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_currow,'customeritemname',ls_customeritemname)
			dw_print.setitem(li_currow,'revisionno',ls_revisionno)
			dw_print.setitem(li_currow,'tracedate', string(date(string(ls_tracedate,"@@@@-@@-@@")),"MM/DD/YY"))
			dw_print.setitem(li_currow,'countryoforigin',ls_countryoforigin)
			dw_print.setitem(li_currow,'customeritemcode',ls_customeritemcode)
			dw_print.setitem(li_currow,'shipqty',li_shipqty)
			dw_print.setitem(li_currow,'purchaseno',ls_purchaseno)
			dw_print.setitem(li_currow,'pkgid',String(Integer(ls_pkgid), "00000"))
			dw_print.setitem(li_currow,'pkglistno',ls_pkglistno)
			dw_print.setitem(li_currow,'lotno',ls_lotno)
			// Calculate Barcode by code128
			dw_print.setitem(li_currow,'customeritemcodebar', &
				char(204) + f_piss_convert_code128( 'B', 'P' + trim(ls_customeritemcode) ) + char(206))
			dw_print.setitem(li_currow,'shipqtybar', &
				char(204) + f_piss_convert_code128( 'B', 'Q' + String(li_shipqty) ) + char(206))
			dw_print.setitem(li_currow,'purchasenobar', &
				char(204) + f_piss_convert_code128( 'B', 'K' + trim(ls_purchaseno) ) + char(206))
			dw_print.setitem(li_currow,'pkgidbar', &
				char(204) + f_piss_convert_code128( 'B', '3S' + ls_pkgid ) + char(206))
			dw_print.setitem(li_currow,'pkglistnobar', &
				char(204) + f_piss_convert_code128( 'B', '11K' + trim(ls_pkglistno) ) + char(206))
			dw_print.setitem(li_currow,'lotnobar', &
				char(204) + f_piss_convert_code128( 'B', '1T' + trim(ls_lotno) ) + char(206))
		next
	next
Next
if li_printcount > 0 then		
	return 0
else
	return -1
end if
				


end function

public function integer wf_label_print ();integer li_printcount, li_currow, li_rowcnt, li_selectedrow
string ls_labelgubun, ls_customeritemcode

li_printcount = integer(em_2.text)
li_rowcnt = dw_2.rowcount()

if li_rowcnt < 1 then
	return -1
end if

if isnull(li_printcount) then
	messagebox('Ȯ��','�μ� �ż� Ȯ�� �ϼ���')
	return -1
end if

li_currow = dw_2.getselectedrow(0)
if li_currow < 1 then
	return 0
end if
ls_labelgubun = dw_2.getitemstring(li_currow,'labelgubun')
For li_currow = 1 To li_rowcnt
	if dw_2.isselected(li_currow) <> true then
		continue
	end if
	li_selectedrow = li_currow
	if ls_labelgubun <> dw_2.getitemstring(li_currow,'labelgubun') then
		Messagebox("Ȯ��","�󺧱����� ������ �͸� ������ �ֽʽÿ�")
		return -1
	end if
Next

choose case ls_labelgubun
	case 'DH'
		dw_print.dataobject = "d_piss611u_02p"
		if wf_label_form(li_printcount) <> 0 then
			return -1
		end if
	case 'DA'
		ls_customeritemcode		= dw_2.getitemstring(li_selectedrow,'customeritemcode')
		if ls_customeritemcode = '19020618' or ls_customeritemcode = '892940' or &
				ls_customeritemcode = '8400080' or ls_customeritemcode = '897755' or &
				ls_customeritemcode = '19020706' or ls_customeritemcode = '889955' or &
				ls_customeritemcode = '19020707' or ls_customeritemcode = '889956' then
			dw_print.dataobject = 'd_piss611u_05p'
			is_revno = 'R01'
		else
			dw_print.dataobject = 'd_piss611u_03p'
			is_revno = 'R00'
		end if
		if wf_label_dra(li_printcount) <> 0 then
			return -1
		end if
	case 'FD'
		dw_print.dataobject = "d_piss611u_04p"
		if wf_label_ford(li_printcount) <> 0 then
			return -1
		end if
	case 'GO','GP','GQ','LD'
		dw_print.dataobject = "d_piss611u_06p"
		if wf_label_odette(li_printcount) <> 0 then
			return -1
		end if
	case else
		uo_status.st_message.text = "���ǵ� ��¶��� �����ϴ�. �ý��۰����� ����ڿ��� �����ٶ��ϴ�."
		return -1
end choose

return 0
end function

public function integer wf_save_dra ();
string	ls_areacode,			ls_divisioncode,				ls_customercode,&
			ls_customeritemcode,	ls_packinglistno,				ls_lotno,&
			ls_purchaseno,			ls_tracedate,					ls_customerplantaddress2,&
			ls_customerdivision,	ls_customerplantaddress,	ls_suppliercode,&
			ls_suppliername,		ls_customerplantcity,		ls_customerstate,&
			ls_customerpostal,	ls_plantdock,					ls_deliverylocation,&
			ls_revisionno, 		ls_suppliercity,				ls_suppliercity1,&
			ls_supplierpostal,	ls_countryoforigin, 			ls_message,&
			ls_customeritemname, ls_labelgubun, ls_invoiceno
integer	li_serialnofrom,	li_labelcount,	li_shipqty, li_selcount
dw_3.accepttext()

ls_customercode			= dw_3.getitemstring(1, 'customercode')
ls_suppliercode			= dw_3.getitemstring(1, 'suppliercode')
ls_suppliername			= dw_3.getitemstring(1, 'suppliername')
ls_areacode					= dw_3.getitemstring(1, 'areacode')
ls_divisioncode 			= dw_3.getitemstring(1, 'divisioncode')
ls_customeritemcode 		= dw_3.getitemstring(1, 'customeritemcode')
ls_customeritemname 		= dw_3.getitemstring(1, 'customeritemname')
ls_customerdivision		= dw_3.getitemstring(1, 'customerdivision')
ls_customerplantaddress = dw_3.getitemstring(1, 'customerplantaddress')
ls_customerplantaddress2 = dw_3.getitemstring(1, 'customerplantaddress2')
ls_customerplantcity		= dw_3.getitemstring(1, 'customerplantcity')
ls_customerstate			= dw_3.getitemstring(1, 'customerstate')
ls_customerpostal			= dw_3.getitemstring(1, 'customerpostal')
ls_plantdock				= dw_3.getitemstring(1, 'plantdock')
ls_deliverylocation		= dw_3.getitemstring(1, 'deliverylocation')
ls_revisionno				= dw_3.getitemstring(1, 'revisionno')
ls_suppliercity			= dw_3.getitemstring(1, 'suppliercity')
ls_suppliercity1			= dw_3.getitemstring(1, 'suppliercity1')
ls_supplierpostal			= dw_3.getitemstring(1, 'supplierpostal')
ls_countryoforigin		= dw_3.getitemstring(1, 'countryoforigin')
li_serialnofrom			= dw_3.getitemnumber(1, 'serialnofrom')
ls_lotno						= dw_3.getitemstring(1, 'lotno')
li_shipqty					= dw_3.getitemnumber(1, 'shipqty')
li_labelcount				= dw_3.getitemnumber(1, 'labelcount')
ls_purchaseno				= dw_3.getitemstring(1, 'purchaseno')
ls_tracedate				= dw_3.getitemstring(1, 'tracedate')
ls_packinglistno			= dw_3.getitemstring(1, 'packinglistno')
ls_labelgubun				= dw_3.getitemstring(1, 'labelgubun')
ls_invoiceno				= dw_3.getitemstring(1, 'invoiceno')

if isnull(ls_packinglistno) or ls_packinglistno = '' then
	messagebox('Ȯ��','Packing List No�� �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_suppliercode) or ls_suppliercode = '' then
	messagebox('Ȯ��','�������ڵ� �Է� �ٶ��ϴ�')
	return -1
end if
			
if isnull(ls_suppliername) or ls_suppliername = '' then
	messagebox('Ȯ��','�����ڸ� �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_revisionno) or ls_revisionno = '' then
	messagebox('Ȯ��','Revision No �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_customerdivision) or ls_customerdivision = '' then
	messagebox('Ȯ��','Plant No�� �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_Customerplantaddress) or ls_Customerplantaddress = '' then
	messagebox('Ȯ��','�ŷ�ó �ּ�1 �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_suppliercity) or ls_suppliercity = '' then
	messagebox('Ȯ��','������ �ּ�1 �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_countryoforigin) or ls_countryoforigin = '' then
	messagebox('Ȯ��','������ �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(li_labelcount) or li_labelcount = 0 then
	messagebox('Ȯ��','Label �ż� �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(li_shipqty) or li_shipqty = 0 then
	messagebox('Ȯ��','����� �Է� �ٶ��ϴ�')
	return -1
end if

if isnull(ls_purchaseno) or ls_purchaseno = '' then
	messagebox('Ȯ��','P/O No �Է� �ٶ��ϴ�')
	return -1
end if


if isnull(ls_tracedate) or ls_tracedate = '' then
	messagebox('Ȯ��','������ �Է� �ٶ��ϴ�')
	return -1
end if
if trim(f_dateedit(ls_tracedate)) = ''	then
	messagebox('Ȯ��','��¥ ü�谡 Ʋ���ϴ�.')
	return -1
end if

select isnull(count(*),0) into :li_selcount
from tmstcustomer
where custcode = :ls_customercode 
using sqlpis;
if li_selcount < 1 then
	messagebox('Ȯ��','�ش�ŷ�ó�� �������� �ʽ��ϴ�.')
	return -1
end if

sqlpis.autocommit = false

select isnull(count(*),0) into :li_selcount
from TSHIPLABELCUSTOMER
WHERE customercode = :ls_customercode and labelgubun = :ls_labelgubun
using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update TSHIPLABELCUSTOMER
	set	suppliercode	= :ls_suppliercode,
			suppliername	= :ls_suppliername
	where	customercode = :ls_customercode and labelgubun = :ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into
	TSHIPLABELCUSTOMER(customercode, labelgubun, suppliercode,	suppliername)
	values(:ls_customercode,	:ls_labelgubun, :ls_suppliercode, :ls_suppliername)
				using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if
	
select count(*) into :li_selcount
from TSHIPLABELITEM
WHERE areacode				= :ls_areacode and
		divisioncode		= :ls_divisioncode and
		customercode		= :ls_customercode and
		customeritemcode	= :ls_customeritemcode and
		labelgubun 			= :ls_labelgubun
		using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update TSHIPLABELITEM
	set	customeritemname			= :ls_customeritemname,
			customerdivision			= :ls_customerdivision,
			customerplantaddress		= :ls_customerplantaddress,
			customerplantaddress2	= :ls_customerplantaddress2,
			customerplantcity			= :ls_customerplantcity,
			customerstate				= :ls_customerstate,
			customerpostal				= :ls_customerpostal,
			plantdock					= :ls_plantdock,
			deliverylocation			= :ls_deliverylocation,
			revisionno					= :ls_revisionno,
			suppliercity				= :ls_suppliercity,
			suppliercity1				= :ls_suppliercity1,
			supplierpostal				= :ls_supplierpostal,
			countryoforigin			= :ls_countryoforigin
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			labelgubun 			= :ls_labelgubun 
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into TSHIPLABELITEM
			(areacode,						divisioncode,				customercode,
			 customeritemcode,			labelgubun,					
			 customerdivision,			customerplantaddress2,
			 customerplantaddress,		customerplantcity,		customerstate,
			 customerpostal,				plantdock,					deliverylocation,
			 revisionno,					suppliercity,				suppliercity1,			
			 supplierpostal,				countryoforigin, 			customeritemname)		 
	values(:ls_areacode,					:ls_divisioncode,			:ls_customercode,
			 :ls_customeritemcode,		:ls_labelgubun,
			 :ls_customerdivision,		:ls_customerplantaddress2,
			 :ls_customerplantaddress,	:ls_customerplantcity,	:ls_customerstate,
			 :ls_customerpostal,			:ls_plantdock,				:ls_deliverylocation,
			 :ls_revisionno,				:ls_suppliercity,			:ls_suppliercity1,
			 :ls_supplierpostal,			:ls_countryoforigin,		:ls_customeritemname )  
	using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if

if li_serialnofrom = 0 or isnull(li_serialnofrom) then
	select isnull(max(serialnofrom  + labelcount),0)	into :li_serialnofrom from TSHIPLABELCONTAINER
	where areacode				= 	:ls_areacode		 and
			divisioncode		=	:ls_divisioncode and
			customercode		=	:ls_customercode and
			customeritemcode	=	:ls_customeritemcode and
			invoiceno			=  :ls_invoiceno	and
			labelgubun			=  :ls_labelgubun
	using sqlpis ;

	if sqlpis.sqlcode <> 0 then
		li_serialnofrom = 0
	end if

	li_serialnofrom = li_serialnofrom + 1

	insert	into TSHIPLABELCONTAINER
			(areacode,				divisioncode,			customercode,		customeritemcode,
			 invoiceno,				serialnofrom,			labelgubun,
			 labelcount,			lotno,					packinglistno,
			 shipqty,				purchaseno,				tracedate)		 
	values(:ls_areacode,			:ls_divisioncode,		:ls_customercode, :ls_customeritemcode,
			 :ls_invoiceno,		:li_serialnofrom,		:ls_labelgubun,
			 :li_labelcount,		:ls_lotno,				:ls_packinglistno,	
			 :li_shipqty,			:ls_purchaseno,			:ls_tracedate)  using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	update	TSHIPLABELCONTAINER
	set	packinglistno		= :ls_packinglistno,
			lotno					=	:ls_lotno,
			shipqty				=	:li_shipqty,
			purchaseno			=	:ls_purchaseno,
			tracedate			=	:ls_tracedate
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			invoiceno			= :ls_invoiceno and
			serialnofrom		=	:li_serialnofrom	and
			labelgubun			= :ls_labelgubun
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if

Commit using sqlpis;
sqlpis.Autocommit = True
triggerevent("ue_retrieve")
uo_status.st_message.text = "���������� ó���Ǿ����ϴ�."

RollBack_:
Rollback using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end function

public function integer wf_save_ford ();
string	ls_areacode,			ls_divisioncode,				ls_customercode,&
			ls_customeritemcode,	ls_invoiceno,					ls_lotno,&
			ls_purchaseno,			ls_tracedate,					ls_unit,&
			ls_customerdivision,	ls_customerplantaddress,	ls_suppliercode,&
			ls_suppliername, 		ls_segment1, 					ls_segment2,&
			ls_segment3,			ls_customerplantcity,		ls_customerstate,&
			ls_customerpostal,	ls_plantdock,					ls_deliverylocation,&
			ls_revisionno, 		ls_suppliercity,				ls_supplierpostal,&
			ls_countryoforigin
integer	li_serialnofrom, li_serial, li_labelcount,	li_shipqty, li_selcount
string ls_customerplantaddress2, ls_customerno, ls_itemcode, ls_engalert
string ls_supplierno, ls_containerno, ls_partdesc, ls_partno
int li_grosswgt, li_standardpackqty, li_shift, li_lotsize
string ls_workcenter, ls_dockcode, ls_labelgubun, ls_message

dw_3.accepttext()
// Common Data Gathering
ls_unit						= dw_3.getitemstring(1, 'unit')
ls_customercode			= dw_3.getitemstring(1, 'customercode')
ls_suppliercode			= dw_3.getitemstring(1, 'suppliercode')
ls_suppliername			= dw_3.getitemstring(1, 'suppliername')
ls_segment1					= dw_3.getitemstring(1, 'segment1')
ls_segment2					= dw_3.getitemstring(1, 'segment2')
ls_areacode					= dw_3.getitemstring(1, 'areacode')
ls_divisioncode 			= dw_3.getitemstring(1, 'divisioncode')
ls_customeritemcode 		= dw_3.getitemstring(1, 'customeritemcode')
ls_customerdivision		= dw_3.getitemstring(1, 'customerdivision')
ls_customerplantaddress = dw_3.getitemstring(1, 'customerplantaddress')
ls_customerplantcity		= dw_3.getitemstring(1, 'customercity')
ls_customerstate			= dw_3.getitemstring(1, 'customerstate')
ls_plantdock				= dw_3.getitemstring(1, 'plantdock')
ls_deliverylocation		= dw_3.getitemstring(1, 'deliverylocation')
ls_suppliercity			= dw_3.getitemstring(1, 'suppliercity')
ls_countryoforigin		= dw_3.getitemstring(1, 'countryoforigin')
li_serialnofrom			= dw_3.getitemnumber(1, 'serialnofrom')
li_shipqty					= dw_3.getitemnumber(1, 'shipqty')
li_labelcount				= dw_3.getitemnumber(1, 'labelcount')
ls_tracedate				= dw_3.getitemstring(1, 'tracedate')
ls_labelgubun				= dw_3.getitemstring(1, 'labelgubun')
ls_invoiceno				= dw_3.getitemstring(1, 'invoiceno')
// Special Data Gathering

ls_customerplantaddress2 = dw_3.getitemstring(1, 'customerplantaddress2')
ls_customerno				= dw_3.getitemstring(1, 'customerno')
ls_engalert					= dw_3.getitemstring(1, 'engalert')
ls_supplierno				= dw_3.getitemstring(1, 'supplierno')
ls_containerno				= dw_3.getitemstring(1, 'containerno')
ls_itemcode					= dw_3.getitemstring(1, 'itemcode')
ls_partno					= dw_3.getitemstring(1, 'partno')
ls_partdesc					= dw_3.getitemstring(1, 'partdesc')
ls_workcenter				= dw_3.getitemstring(1, 'workcenter')
ls_dockcode					= dw_3.getitemstring(1, 'dockcode')
li_grosswgt					= dw_3.getitemnumber(1, 'grosswgt')
li_standardpackqty		= dw_3.getitemnumber(1, 'standardpackqty')
li_shift						= dw_3.getitemnumber(1, 'shift')
li_lotsize					= dw_3.getitemnumber(1, 'lotsize')

// Data Gathering End
if trim(f_dateedit(ls_tracedate)) = ''	or len(ls_tracedate) <> 8 then
	messagebox('Ȯ��','��¥ ü�谡 Ʋ���ϴ�.')
	return -1
end if

sqlpis.Autocommit = False

select isnull(count(*),0) into :li_selcount
from tshiplabelcustomer
WHERE customercode = :ls_customercode and labelgubun = :ls_labelgubun
using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tshiplabelcustomer
	set	suppliercode	= :ls_suppliercode,
			suppliername	= :ls_suppliername,
			segment1			= :ls_segment1,
			segment2			= :ls_segment2,
			segment3			= :ls_segment3
	where	customercode = :ls_customercode and labelgubun = :ls_labelgubun
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into
	tshiplabelcustomer(customercode, labelgubun, suppliercode,	suppliername,
						segment1,		segment2,			segment3)
	values(:ls_customercode,	:ls_labelgubun, :ls_suppliercode, :ls_suppliername,
				:ls_segment1, :ls_segment2, :ls_segment3)
				using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if
	
select count(*) into :li_selcount
from tshiplabelitem
WHERE areacode				= :ls_areacode and
		divisioncode		= :ls_divisioncode and
		customercode		= :ls_customercode and
		customeritemcode	= :ls_customeritemcode and
		labelgubun			= :ls_labelgubun
		using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tshiplabelitem
	set	itemcode					= :ls_itemcode,
			unit						= :ls_unit,
			customerdivision		= :ls_customerdivision,
			customerplantaddress	= :ls_customerplantaddress,
			customerplantaddress2 = :ls_customerplantaddress2,
			customerplantcity		= :ls_customerplantcity,
			customerstate			= :ls_customerstate,
			customerpostal			= :ls_customerpostal,
			plantdock				= :ls_plantdock,
			deliverylocation		= :ls_deliverylocation,
			revisionno				= :ls_revisionno,
			suppliercity			= :ls_suppliercity,
			supplierpostal			= :ls_supplierpostal,
			countryoforigin		= :ls_countryoforigin,
			labelgubun				= :ls_labelgubun,
			customerno				= :ls_customerno,
			supplierno				= :ls_supplierno,
			partno					= :ls_partno,
			partdesc					= :ls_partdesc,
			engalert					= :ls_engalert,
			containerno				= :ls_containerno,
			dockcode					= :ls_dockcode,
			workcenter				= :ls_workcenter,
			shift						= :li_shift,
			lotsize					= :li_lotsize
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			labelgubun			= :ls_labelgubun 
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR03 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into tshiplabelitem
			(areacode,						divisioncode,				customercode,
			 customeritemcode,			labelgubun,
			 unit,							customerdivision,
			 customerplantaddress,		customerplantcity,		customerstate,
			 customerpostal,				plantdock,					deliverylocation,
			 revisionno,					suppliercity,				supplierpostal,
		 	 countryoforigin,				customerno,
			 supplierno,					itemcode,					partdesc,
			 engalert,						containerno,				dockcode,						
			 workcenter,					shift,						lotsize,						
			 customerplantaddress2,		partno)		 
	values(:ls_areacode,					:ls_divisioncode,			:ls_customercode,
			 :ls_customeritemcode,		:ls_labelgubun,
			 :ls_unit,						:ls_customerdivision,
			 :ls_customerplantaddress,	:ls_customerplantcity,	:ls_customerstate,
			 :ls_customerpostal,			:ls_plantdock,				:ls_deliverylocation,
			 :ls_revisionno,				:ls_suppliercity,			:ls_supplierpostal,
			 :ls_countryoforigin,		:ls_customerno,
			 :ls_supplierno,				:ls_itemcode,				:ls_partdesc,
			 :ls_engalert,					:ls_containerno,			:ls_dockcode,					
			 :ls_workcenter,				:li_shift,					:li_lotsize,				
			 :ls_customerplantaddress2,:ls_partno)  
	using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR04 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if

//if li_serialnofrom = 0 or isnull(li_serialnofrom) then
	select isnull(sum(labelcount),0)	into :li_serial from tshiplabelcontainer
	where areacode				= 	:ls_areacode		 and
			divisioncode		=	:ls_divisioncode and
			customercode		=	:ls_customercode and
			customeritemcode	=	:ls_customeritemcode and
			invoiceno			=	:ls_invoiceno and
			labelgubun			=  :ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_serial = 0
	end if
	
	if li_serialnofrom = 0 then
		li_serialnofrom = li_serial + 1
	else
		li_serialnofrom = li_serialnofrom
	end if
	
	select count(*) into :li_selcount
	from tshiplabelcontainer
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			invoiceno			=	:ls_invoiceno		and
			serialnofrom		=	:li_serialnofrom	and
			labelgubun			=  :ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_selcount = 0
	end if
	
	if li_selcount = 0 then
		insert	into tshiplabelcontainer
				(areacode,				divisioncode,			customercode,		customeritemcode,
				 invoiceno,				serialnofrom,			labelgubun,
				 labelcount,			lotno,
				 shipqty,				purchaseno,				tracedate,			grosswgt,
				 standardpackqty )		 
		values(:ls_areacode,			:ls_divisioncode,		:ls_customercode, :ls_customeritemcode,
				 :ls_invoiceno,		:li_serialnofrom,		:ls_labelgubun,
				 :li_labelcount,	:ls_lotno,
				 :li_shipqty,			:ls_purchaseno,		:ls_tracedate,		:li_grosswgt,
				 :li_standardpackqty)  using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			ls_message = "ERR05 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	else
		update	tshiplabelcontainer
		set	lotno					=	:ls_lotno,
				shipqty				=	:li_shipqty,
				labelcount			=  :li_labelcount,
				purchaseno			=	:ls_purchaseno,
				tracedate			=	:ls_tracedate,
				grosswgt				= 	:li_grosswgt,
				standardpackqty	= 	:li_standardpackqty
		where areacode				= :ls_areacode		 and
				divisioncode		= :ls_divisioncode and
				customercode		= :ls_customercode and
				customeritemcode	= :ls_customeritemcode and
				invoiceno			=	:ls_invoiceno		and
				serialnofrom		=	:li_serialnofrom	and
				labelgubun			=  :ls_labelgubun
		using sqlpis ;
		if sqlpis.sqlnrows = 0 then
			ls_message = "ERR06 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	end if
//end if
Commit using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
triggerevent("ue_retrieve")

RollBack_:
Rollback using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end function

public function integer wf_save_odette ();
string	ls_areacode,			ls_divisioncode,				ls_customercode,&
			ls_customeritemcode,	ls_invoiceno,					ls_lotno,&
			ls_purchaseno,			ls_tracedate,					ls_unit,&
			ls_customerdivision,	ls_customerplantaddress,	ls_suppliercode,&
			ls_suppliername, 		ls_segment1, 					ls_segment2,&
			ls_segment3,			ls_customerplantcity,		ls_customerstate,&
			ls_customerpostal,	ls_plantdock,					ls_deliverylocation,&
			ls_revisionno, 		ls_suppliercity,				ls_supplierpostal,&
			ls_countryoforigin,	ls_packinglistno
integer	li_serialnofrom, li_serial, li_labelcount,	li_shipqty, li_selcount
string ls_customerplantaddress2, ls_customerno, ls_itemcode, ls_engalert
string ls_supplierno, ls_containerno, ls_partdesc
int li_grosswgt, li_standardpackqty, li_shift, li_lotsize, li_rtn
string ls_workcenter, ls_dockcode, ls_labelgubun, ls_message

dw_3.accepttext()
// Common Data Gathering
ls_unit						= dw_3.getitemstring(1, 'unit')
ls_customercode			= dw_3.getitemstring(1, 'customercode')
ls_suppliercode			= dw_3.getitemstring(1, 'suppliercode')
ls_suppliername			= dw_3.getitemstring(1, 'suppliername')
ls_segment1					= dw_3.getitemstring(1, 'segment1')
ls_segment2					= dw_3.getitemstring(1, 'segment2')
ls_areacode					= dw_3.getitemstring(1, 'areacode')
ls_divisioncode 			= dw_3.getitemstring(1, 'divisioncode')
ls_customeritemcode 		= dw_3.getitemstring(1, 'customeritemcode')
ls_customerdivision		= dw_3.getitemstring(1, 'customerdivision')
ls_customerplantaddress = dw_3.getitemstring(1, 'customerplantaddress')
ls_customerplantcity		= dw_3.getitemstring(1, 'customercity')
ls_customerstate			= dw_3.getitemstring(1, 'customerstate')
ls_plantdock				= dw_3.getitemstring(1, 'plantdock')
ls_deliverylocation		= dw_3.getitemstring(1, 'deliverylocation')
ls_suppliercity			= dw_3.getitemstring(1, 'suppliercity')
ls_countryoforigin		= dw_3.getitemstring(1, 'countryoforigin')
li_serialnofrom			= dw_3.getitemnumber(1, 'serialnofrom')
li_shipqty					= dw_3.getitemnumber(1, 'shipqty')
li_labelcount				= dw_3.getitemnumber(1, 'labelcount')
ls_tracedate				= dw_3.getitemstring(1, 'tracedate')
ls_labelgubun				= dw_3.getitemstring(1, 'labelgubun')
ls_invoiceno				= dw_3.getitemstring(1, 'invoiceno')
// Special Data Gathering

ls_customerplantaddress2 = dw_3.getitemstring(1, 'customerplantaddress2')
ls_customerno				= dw_3.getitemstring(1, 'customerno')
ls_engalert					= dw_3.getitemstring(1, 'engalert')
ls_supplierno				= dw_3.getitemstring(1, 'supplierno')
ls_containerno				= dw_3.getitemstring(1, 'containerno')
ls_itemcode					= dw_3.getitemstring(1, 'itemcode')
ls_purchaseno				= dw_3.getitemstring(1, 'purchaseno')
ls_packinglistno			= dw_3.getitemstring(1, 'packinglistno')
ls_partdesc					= dw_3.getitemstring(1, 'partdesc')
ls_workcenter				= dw_3.getitemstring(1, 'workcenter')
ls_dockcode					= dw_3.getitemstring(1, 'dockcode')
li_grosswgt					= dw_3.getitemnumber(1, 'grosswgt')
li_standardpackqty		= dw_3.getitemnumber(1, 'standardpackqty')
li_shift						= dw_3.getitemnumber(1, 'shift')
li_lotsize					= dw_3.getitemnumber(1, 'lotsize')

// Data Gathering End
if trim(f_dateedit(ls_tracedate)) = ''	or len(ls_tracedate) <> 8 then
	messagebox('Ȯ��','��¥ ü�谡 Ʋ���ϴ�.')
	return -1
end if

sqlpis.Autocommit = False

select isnull(count(*),0) into :li_selcount
from tshiplabelcustomer
WHERE customercode = :ls_customercode and labelgubun = :ls_labelgubun
using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tshiplabelcustomer
	set	suppliercode	= :ls_suppliercode,
			suppliername	= :ls_suppliername,
			segment1			= :ls_segment1,
			segment2			= :ls_segment2,
			segment3			= :ls_segment3
	where	customercode = :ls_customercode and labelgubun = :ls_labelgubun
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into
	tshiplabelcustomer(customercode, labelgubun, suppliercode,	suppliername,
						segment1,		segment2,			segment3)
	values(:ls_customercode,	:ls_labelgubun, :ls_suppliercode, :ls_suppliername,
				:ls_segment1, :ls_segment2, :ls_segment3)
				using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if
	
select count(*) into :li_selcount
from tshiplabelitem
WHERE areacode				= :ls_areacode and
		divisioncode		= :ls_divisioncode and
		customercode		= :ls_customercode and
		customeritemcode	= :ls_customeritemcode and
		labelgubun			= :ls_labelgubun
		using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tshiplabelitem
	set	itemcode					= :ls_itemcode,
			unit						= :ls_unit,
			customerdivision		= :ls_customerdivision,
			customerplantaddress	= :ls_customerplantaddress,
			customerplantaddress2 = :ls_customerplantaddress2,
			customerplantcity		= :ls_customerplantcity,
			customerstate			= :ls_customerstate,
			customerpostal			= :ls_customerpostal,
			plantdock				= :ls_plantdock,
			deliverylocation		= :ls_deliverylocation,
			revisionno				= :ls_revisionno,
			suppliercity			= :ls_suppliercity,
			supplierpostal			= :ls_supplierpostal,
			countryoforigin		= :ls_countryoforigin,
			labelgubun				= :ls_labelgubun,
			customerno				= :ls_customerno,
			supplierno				= :ls_supplierno,
			partdesc					= :ls_partdesc,
			engalert					= :ls_engalert,
			containerno				= :ls_containerno,
			dockcode					= :ls_dockcode,
			workcenter				= :ls_workcenter,
			shift						= :li_shift,
			lotsize					= :li_lotsize
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			labelgubun			= :ls_labelgubun 
	using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR03 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into tshiplabelitem
			(areacode,						divisioncode,				customercode,
			 customeritemcode,			labelgubun,
			 unit,							customerdivision,
			 customerplantaddress,		customerplantcity,		customerstate,
			 customerpostal,				plantdock,					deliverylocation,
			 revisionno,					suppliercity,				supplierpostal,
		 	 countryoforigin,				customerno,
			 supplierno,					itemcode,					partdesc,
			 engalert,						containerno,				dockcode,						
			 workcenter,					shift,						lotsize,						
			 customerplantaddress2 )		 
	values(:ls_areacode,					:ls_divisioncode,			:ls_customercode,
			 :ls_customeritemcode,		:ls_labelgubun,
			 :ls_unit,						:ls_customerdivision,
			 :ls_customerplantaddress,	:ls_customerplantcity,	:ls_customerstate,
			 :ls_customerpostal,			:ls_plantdock,				:ls_deliverylocation,
			 :ls_revisionno,				:ls_suppliercity,			:ls_supplierpostal,
			 :ls_countryoforigin,		:ls_customerno,
			 :ls_supplierno,				:ls_itemcode,				:ls_partdesc,
			 :ls_engalert,					:ls_containerno,			:ls_dockcode,					
			 :ls_workcenter,				:li_shift,					:li_lotsize,				
			 :ls_customerplantaddress2 )  
	using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR04 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if

//if li_serialnofrom = 0 or isnull(li_serialnofrom) then
	select isnull(sum(labelcount),0)	into :li_serial from tshiplabelcontainer
	where areacode				= 	:ls_areacode		 and
			divisioncode		=	:ls_divisioncode and
			customercode		=	:ls_customercode and
			customeritemcode	=	:ls_customeritemcode and
			invoiceno			=	:ls_invoiceno and
			labelgubun			=  :ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_serial = 0
	end if
	
	if li_serialnofrom = 0 then
		li_serialnofrom = li_serial + 1
	else
		li_serialnofrom = li_serialnofrom
	end if
	
	select count(*) into :li_selcount
	from tshiplabelcontainer
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			invoiceno			=	:ls_invoiceno		and
			serialnofrom		=	:li_serialnofrom	and
			labelgubun			=  :ls_labelgubun
	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_selcount = 0
	end if
	
	if li_selcount = 0 then
		// Delivery Note ����
		select cast(isnull(max(purchaseno),'0') as integer) into :li_rtn
		from tshiplabelcontainer
		where areacode				= :ls_areacode		 and
				divisioncode		= :ls_divisioncode and
				customercode		= :ls_customercode and
				customeritemcode	= :ls_customeritemcode and
				invoiceno			=	:ls_invoiceno		and
				labelgubun			=  :ls_labelgubun
		using sqlpis ;
		
//		ls_purchaseno = string(li_rtn + 1,"00000000")
		// ��
		insert	into tshiplabelcontainer
				(areacode,				divisioncode,			customercode,		customeritemcode,
				 invoiceno,				serialnofrom,			labelgubun,
				 labelcount,			lotno,
				 shipqty,				purchaseno,				tracedate,			grosswgt,
				 standardpackqty,		packinglistno )		 
		values(:ls_areacode,			:ls_divisioncode,		:ls_customercode, :ls_customeritemcode,
				 :ls_invoiceno,		:li_serialnofrom,		:ls_labelgubun,
				 :li_labelcount,	:ls_lotno,
				 :li_shipqty,			:ls_purchaseno,		:ls_tracedate,		:li_grosswgt,
				 :li_standardpackqty, :ls_packinglistno)  using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			ls_message = "ERR05 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	else
		update	tshiplabelcontainer
		set	lotno					=	:ls_lotno,
				shipqty				=	:li_shipqty,
				labelcount			=  :li_labelcount,
				purchaseno			=	:ls_purchaseno,
				packinglistno		=  :ls_packinglistno,
				tracedate			=	:ls_tracedate,
				grosswgt				= 	:li_grosswgt,
				standardpackqty	= 	:li_standardpackqty
		where areacode				= :ls_areacode		 and
				divisioncode		= :ls_divisioncode and
				customercode		= :ls_customercode and
				customeritemcode	= :ls_customeritemcode and
				invoiceno			=	:ls_invoiceno		and
				serialnofrom		=	:li_serialnofrom	and
				labelgubun			=  :ls_labelgubun
		using sqlpis ;
		if sqlpis.sqlnrows = 0 then
			ls_message = "ERR06 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	end if
//end if
Commit using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
triggerevent("ue_retrieve")

RollBack_:
Rollback using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end function

public function integer wf_label_odette (integer ag_printcount);boolean	lb_null = False
int		li_currow, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount, li_grosswgt
long		ll_rowcount
string 	ls_suppliername, ls_segment1, ls_segment2
string	ls_customerdivision, ls_customaddr, ls_customaddr2, ls_customeritemcode
string	ls_plantdock, ls_deliverylocation, ls_bar2d, ls_containerno
string 	ls_customerno, ls_partdesc, ls_deliverynote, ls_licenseplate
string	ls_workcenter, ls_tracedate, ls_dockcode, ls_serialcode, ls_itemcode
string   ls_areacode, ls_divisioncode, ls_customercode, ls_invoiceno

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	if dw_2.isselected(li_selectedcount) <> true then
		continue
	end if
	// ���� ��ǰ�� ��ȸ�ϱ�
	ls_customercode		= 	dw_2.getitemstring(li_selectedcount, 'customercode')
	ls_areacode				= 	dw_2.getitemstring(li_selectedcount, 'areacode')
	ls_divisioncode 		= 	dw_2.getitemstring(li_selectedcount, 'divisioncode')
	ls_customeritemcode	=	Trim(dw_2.getitemstring(li_selectedcount, 'customeritemcode'))
	ls_invoiceno 			= 	Trim(dw_2.getitemstring(li_selectedcount, 'invoiceno'))
	li_serialnofrom		= 	dw_2.getitemnumber(li_selectedcount, 'serialnofrom')

	li_codecount	=	dw_3.retrieve(ls_areacode,			ls_divisioncode,&
									  ls_customercode,	ls_customeritemcode,&
									  ls_invoiceno,		li_serialnofrom)
	if li_codecount < 1 then
		continue
	end if
	//Null Value Check
	ls_suppliername		= dw_3.getitemstring(1,'suppliername')		
	ls_segment1				= dw_3.getitemstring(1,'segment1')
	ls_segment2				= dw_3.getitemstring(1,'segment2')
	//ls_suppliercity			= trim(dw_3.getitemstring(1,'suppliercity')) + ", " + dw_3.getitemstring(1,'countryoforigin')
	ls_customerdivision	= dw_3.getitemstring(1,'customerdivision')
	ls_customaddr			= dw_3.getitemstring(1,'customerplantaddress')
	ls_customaddr2			= dw_3.getitemstring(1,'customerplantaddress2')
	ls_plantdock			= dw_3.getitemstring(1,'plantdock')
	ls_customerno			= dw_3.getitemstring(1,'customerno')
	ls_workcenter			= dw_3.getitemstring(1,'workcenter')
	ls_tracedate			= dw_3.getitemstring(1,'tracedate')
	ls_deliverylocation	= dw_3.getitemstring(1,'deliverylocation')
	li_shipqty				= dw_3.getitemnumber(1,'shipqty')
	li_grosswgt				= dw_3.getitemnumber(1, 'grosswgt')
	ls_itemcode				= dw_3.getitemstring(1,'itemcode')
	ls_partdesc				= dw_3.getitemstring(1,'partdesc')
	ls_deliverynote		= dw_3.getitemstring(1,'purchaseno')
	ls_dockcode				= trim(dw_3.getitemstring(1,'dockcode'))
	ls_containerno			= trim(dw_3.getitemstring(1,'containerno'))
	li_serialnofrom			= dw_3.getitemnumber(1,'serialnofrom')
	li_labelcount				= dw_3.getitemnumber(1, 'labelcount')

	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		if li_serialnofrom1 > 8 then
			ls_deliverynote		= dw_3.getitemstring(1,'packinglistno')
		end if
//		ls_deliverynote = string(integer(ls_deliverynote) + integer((li_currentserial - 1) / 8),"00000000")
		for li_currentprintcount = 1 to ag_printcount
			li_currow = dw_print.insertrow(0)
			dw_print.setitem(li_currow,'suppliername',ls_suppliername)
			dw_print.setitem(li_currow,'suppliercity',ls_segment1)
			dw_print.setitem(li_currow,'supplierpostal',ls_segment2)
			dw_print.setitem(li_currow,'customerdivision',ls_customerdivision)
			dw_print.setitem(li_currow,'customeraddr1',ls_customaddr)
			dw_print.setitem(li_currow,'customeraddr2',ls_customaddr2)
			dw_print.setitem(li_currow,'plantdock',ls_plantdock)
			dw_print.setitem(li_currow,'customerno',ls_customerno)
			dw_print.setitem(li_currow,'workcenter',ls_workcenter)
			dw_print.setitem(li_currow,'tracedate', upper(string(date(string(ls_tracedate,"@@@@-@@-@@")),"DDMMMYYYY")))	
			dw_print.setitem(li_currow,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_currow,'shipqty',li_shipqty)
			dw_print.setitem(li_currow,'grosswgt',li_grosswgt)
			dw_print.setitem(li_currow,'itemcode',ls_itemcode)
			dw_print.setitem(li_currow,'partdesc',ls_partdesc)
			dw_print.setitem(li_currow,'purchaseno',ls_deliverynote)			
			dw_print.setitem(li_currow,'customerno',ls_customerno)
			dw_print.setitem(li_currow,'customeritemcode',ls_customeritemcode)		
			ls_serialcode = ls_divisioncode + upper(right(ls_invoiceno,3)) + string(li_serialnofrom1,'000')
			dw_print.setitem(li_currow,'serialcode','S' + ls_serialcode)
			dw_print.setitem(li_currow,'licenseplate',ls_dockcode + " " + ls_containerno + " " + ls_serialcode)
			// Calculate Barcode by code128
			ls_licenseplate = ls_dockcode + ls_containerno + ls_serialcode
			dw_print.setitem(li_currow,'licenseplatebar', &
				char(204) + f_piss_convert_code128( 'B', '1J' + ls_licenseplate ) + char(206))
			dw_print.setitem(li_currow,'serialcodebar', &
				char(204) + f_piss_convert_code128( 'B', 'S' + trim(ls_serialcode) ) + char(206))
			// Calculate Barcode by BAR2D
			string ls_data
			ls_data =	char(91) + char(41) + char(62) + char(30) + "06" + char(29) +  &  
						"P" + ls_customeritemcode + char(29) + & 
						"Q" + String(li_shipqty)  + char(29) + &
						"1J" + ls_licenseplate  + char(29) + &
						"B" + ls_deliverylocation + char(29) + &
						"2S" + ls_deliverynote  + char(30) + char(04)
			ls_bar2d = f_get_2dbarcode( ls_data )
			dw_print.setitem(li_currow,'bar2d',ls_bar2d)
		next
	next
Next

if li_printcount > 0 then
	return 0
else
	return -1
end if
				


end function

on w_piss611u.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
this.dw_2=create dw_2
this.st_3=create st_3
this.em_1=create em_1
this.dw_3=create dw_3
this.em_2=create em_2
this.st_2=create st_2
this.st_4=create st_4
this.em_3=create em_3
this.st_5=create st_5
this.em_4=create em_4
this.dw_print=create dw_print
this.uo_customer=create uo_customer
this.uo_label=create uo_label
this.cb_addlabel=create cb_addlabel
this.pb_print=create pb_print
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.em_3
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_4
this.Control[iCurrent+15]=this.dw_print
this.Control[iCurrent+16]=this.uo_customer
this.Control[iCurrent+17]=this.uo_label
this.Control[iCurrent+18]=this.cb_addlabel
this.Control[iCurrent+19]=this.pb_print
this.Control[iCurrent+20]=this.st_6
end on

on w_piss611u.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.dw_3)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.em_3)
destroy(this.st_5)
destroy(this.em_4)
destroy(this.dw_print)
destroy(this.uo_customer)
destroy(this.uo_label)
destroy(this.cb_addlabel)
destroy(this.pb_print)
destroy(this.st_6)
end on

event ue_postopen;call super::ue_postopen;dw_2.SetTransObject(SQLPIS)
dw_3.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

f_piss_retrieve_dddw_labelcustomer(uo_customer.dw_1,'%','%',true,uo_customer.is_uo_customercode,uo_customer.is_uo_customername)
f_piss_retrieve_dddw_labelgubun(uo_label.dw_1,'%','%',true,uo_label.is_uo_labelcode,uo_label.is_uo_labelname)
ib_open = True
iw_this.PostEvent("ue_reset")
em_2.text = '2'
em_3.text = '11'
em_4.text = '0'
end event

event ue_reset;call super::ue_reset;dw_2.ReSet()
dw_3.ReSet()

end event

event activate;call super::activate;dw_2.SetTransObject(SQLPIS)
dw_3.SetTransObject(SQLPIS)

end event

event resize;call super::resize;dw_2.Width = newwidth - ( dw_2.x + 20 ) 
dw_2.Height = newheight - ( dw_2.y + 1290 ) 
dw_3.Width = newwidth - ( dw_3.x + 20 ) 
dw_3.y = newheight - 1280
dw_3.Height = newheight - ( dw_3.y + 80 ) 
end event

event ue_insert;call super::ue_insert;//----------------------------
// Invoice No�� �Էµ� ��쿡 �ش� ����Ÿ�� ��ȸ�Ͽ� �����ϵ��� �Ѵ�.
//----------------------------
string ls_customercode, ls_areacode, ls_divisioncode, ls_customeritemcode, ls_invoiceno
string ls_labelgubun
string ls_itemname, ls_itemcode, ls_suppliercode, ls_suppliername, ls_segment1, ls_segment2
int li_selrow, li_rowcnt
str_parms lstr_parm

ls_invoiceno = em_1.text
	
if f_spacechk(ls_invoiceno) = -1 then
	if MessageBox("Ȯ��", "InvoceNo�� �Էµ��� �ʾҽ��ϴ�. ���� �߰��Ͻðڽ��ϱ�?", &
			Exclamation!, OKCancel!, 2) = 2 then
		return 0
	end if
end if

li_selrow = dw_2.getselectedrow(0)
if li_selrow < 1 then
	ls_labelgubun = uo_label.is_uo_labelcode
	lstr_parm.string_arg[1] = uo_area.is_uo_areacode
	lstr_parm.string_arg[2] = uo_division.is_uo_divisioncode
	lstr_parm.string_arg[3] = ls_invoiceno
	lstr_parm.string_arg[4] = uo_customer.is_uo_customercode
	
	if ls_customercode = '%' or ls_labelgubun = '%' then
		uo_status.st_message.text = "�����ڵ� �� �󺧱����� ���õ��� �ʾҽ��ϴ�."
		return 0
	end if
	choose case ls_labelgubun
		case 'DH'
			dw_3.dataobject = "d_piss611u_02"
		case 'DA'
			dw_3.dataobject = "d_piss611u_03"
		case 'FD'
			dw_3.dataobject = "d_piss611u_04"
		case 'GO','GP','GQ','LD'
			dw_3.dataobject = "d_piss611u_06"		
		case else
			uo_status.st_message.text = "���ǵ� ���� �ƴմϴ�. �ý��۰����� ����ڿ��� �����ٶ��ϴ�."
			return 0
	end choose
else
	ls_labelgubun = dw_2.getitemstring(li_selrow,'labelgubun')
	lstr_parm.string_arg[1] = dw_2.getitemstring(li_selrow,'areacode')
	lstr_parm.string_arg[2] = dw_2.getitemstring(li_selrow,'divisioncode')
	lstr_parm.string_arg[3] = ls_invoiceno
	lstr_parm.string_arg[4] = dw_2.getitemstring(li_selrow,'customercode')
	choose case ls_labelgubun
		case 'DH'
			dw_3.dataobject = "d_piss611u_02"
		case 'DA'
			dw_3.dataobject = "d_piss611u_03"
		case 'FD'
			dw_3.dataobject = "d_piss611u_04"
		case 'GO','GP','GQ'
			dw_3.dataobject = "d_piss611u_06"
		case else
			uo_status.st_message.text = "���ǵ� ���� �ƴմϴ�. �ý��۰����� ����ڿ��� �����ٶ��ϴ�."
			return 0
	end choose
end if

if f_spacechk(ls_invoiceno) <> -1 then
	openwithparm(w_piss611s,lstr_parm)
	lstr_parm = message.powerobjectparm
	if lstr_parm.integer_arg[1] = -1 then
		uo_status.st_message.text = "InvoiceNo�� �ش��ϴ� SR�� �������� �ʽ��ϴ�."
		return 0
	end if
else
	if li_selrow > 0 then
		lstr_parm.string_arg[3] = dw_2.getitemstring(li_selrow,"invoiceno")
	else
		lstr_parm.string_arg[3] = "BLANK"
	end if
end if

dw_3.reset()
dw_3.settransobject(sqlpis)

if li_selrow < 1 then
	dw_3.insertrow(0)
	if ls_labelgubun = 'DA' or ls_labelgubun = 'DH' then
		dw_3.Object.customeritemcode.Protect=1
		dw_3.Modify("customeritemcode.background.color = 12632256")
	end if
	dw_3.setitem(1,'labelgubun',ls_labelgubun)
	dw_3.setitem(1,'customercode', lstr_parm.string_arg[4])
	dw_3.setitem(1,'areacode',	lstr_parm.string_arg[1])
	dw_3.setitem(1,'divisioncode', lstr_parm.string_arg[2])
	dw_3.setitem(1,'customeritemcode', lstr_parm.string_arg[5])
	dw_3.setitem(1,'customerdivision', lstr_parm.string_arg[8])
	dw_3.setitem(1,'invoiceno', lstr_parm.string_arg[3])
//	dw_3.setitem(1,'customeritemcode', '2582283')
//	dw_3.setitem(1,'customercode', 'E60300')
//	dw_3.setitem(1,'areacode',	'D')
//	dw_3.setitem(1,'divisioncode', 'S')
//	dw_3.setitem(1,'customeritemcode', '2582283')
//	dw_3.setitem(1,'customerdivision', 'DELPHI-SAGINAW')
//	dw_3.setitem(1,'invoiceno', 'DV67-R034')
	dw_3.setitem(1,'serialnofrom',0)
	dw_3.setitem(1,'labelcount',0)
	dw_3.setitem(1,'shipqty',0)
	dw_3.setitem(1,'tracedate','')
	if ls_labelgubun <> 'DA' and ls_labelgubun <> 'DH' then
		dw_3.setitem(1,'partno',lstr_parm.string_arg[5])
		dw_3.setitem(1,'itemcode',lstr_parm.string_arg[6])
		dw_3.setitem(1,'lotsize',lstr_parm.long_arg[1])
	end if
else
	li_rowcnt = dw_3.retrieve(lstr_parm.string_arg[1],lstr_parm.string_arg[2], &
				dw_2.object.customercode[li_selrow], &
				dw_2.object.customeritemcode[li_selrow], &
				dw_2.object.invoiceno[li_selrow], &
				dw_2.object.serialnofrom[li_selrow])
	if ls_labelgubun = 'DA' or ls_labelgubun = 'DH' then
		dw_3.Object.customeritemcode.Protect=0
		dw_3.Modify("customeritemcode.background.color = 16777215")
	end if
	if lstr_parm.string_arg[3] <> 'BLANK' then
		dw_3.setitem(1,'customercode', lstr_parm.string_arg[4])
		dw_3.setitem(1,'areacode',	lstr_parm.string_arg[1])
		dw_3.setitem(1,'divisioncode', lstr_parm.string_arg[2])
		dw_3.setitem(1,'customeritemcode', lstr_parm.string_arg[5])
		dw_3.setitem(1,'customerdivision', lstr_parm.string_arg[8])
		dw_3.setitem(1,'invoiceno', lstr_parm.string_arg[3])
		dw_3.setitem(1,'serialnofrom',0)
		dw_3.setitem(1,'labelcount',0)
		dw_3.setitem(1,'shipqty',0)
		dw_3.setitem(1,'tracedate','')
		if ls_labelgubun <> 'DA' and ls_labelgubun <> 'DH'  then
			dw_3.setitem(1,'partno',lstr_parm.string_arg[5])
			dw_3.setitem(1,'itemcode',lstr_parm.string_arg[6])
			dw_3.setitem(1,'lotsize',lstr_parm.long_arg[1])
		end if
	end if
	dw_3.setitem(1,'invoiceno', lstr_parm.string_arg[3])
	dw_3.setitem(1,'labelgubun',ls_labelgubun)
//	ls_itemcode = dw_2.getitemstring(li_selrow,'itemcode')
//	select itemname into :ls_itemname
//	from tmstitem
//	where itemcode = :ls_itemcode using sqlpis;
//	dw_3.setitem(1,'itemcode', ls_itemcode)
//	dw_3.setitem(1,'partdesc', ls_itemname)
//	dw_3.setitem(1,'suppliercode', dw_2.getitemstring(li_selrow,'suppliercode'))
//	dw_3.setitem(1,'suppliername', dw_2.getitemstring(li_selrow,'suppliername'))
//	dw_3.setitem(1,'segment1', dw_2.getitemstring(li_selrow,'segment1'))
//	dw_3.setitem(1,'segment2', dw_2.getitemstring(li_selrow,'segment2'))
//	dw_3.setitem(1,'customercode', dw_2.getitemstring(li_selrow,'customercode'))
//	dw_3.setitem(1,'areacode',	dw_2.getitemstring(li_selrow,'areacode'))
//	dw_3.setitem(1,'divisioncode', dw_2.getitemstring(li_selrow,'divisioncode'))
//	dw_3.setitem(1,'customeritemcode', dw_2.getitemstring(li_selrow,'customeritemcode'))
	dw_3.setitem(1,'serialnofrom',0)
	dw_3.setitem(1,'labelcount',0)
	dw_3.setitem(1,'shipqty',0)
	dw_3.setitem(1,'tracedate','')
end if

dw_3.setfocus() 
 
uo_status.st_message.text = "�ش������� �Է��Ͻʽÿ�"

end event

event ue_print;// ��ü �μ�
if wf_label_print() = -1 then
	return -1
end if

Long	ll_printjob
ll_printjob	= PrintOPen()
dw_print.modify("datawindow.Print.Orientation = 1" )
dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_3.Text))*100 ))
dw_print.Modify("datawindow.print.margin.right   = 0")
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_4.Text))*100 ))

PrintDataWindow(ll_printjob, dw_print)
PrintClose(ll_printjob)
messagebox('Ȯ��', '����Ͽ����ϴ�')

//ȭ��ǥ��
//window 	l_to_open
//str_easy l_str_prt
//
////�μ� DataWindow ����
////w_easy_prt�� dwsyntax�� ���� modify()���� �߰���
//l_str_prt.transaction  = sqlpis
//l_str_prt.datawindow   = dw_print
////l_str_prt.title = "�ϼ�ǰ�� ������"
//l_str_prt.tag			  = This.ClassName()
//	
//f_close_report("1", l_str_prt.title)			 //Open�� ���Window �ݱ�
//Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)
//��


end event

event ue_retrieve;call super::ue_retrieve;string ls_invoiceno, ls_area, ls_division, ls_customer, ls_labelgubun
long    l_n_row, l_n_currow

ls_invoiceno = em_1.text
if f_spacechk(ls_invoiceno) = -1 then
	ls_invoiceno = '%'
end if
uo_status.st_message.text	=	"��ȸ���Դϴ�."

ls_area = uo_area.is_uo_areacode
ls_division = uo_division.is_uo_divisioncode
ls_customer = uo_customer.is_uo_customercode
ls_labelgubun = uo_label.is_uo_labelcode
dw_2.reset()
dw_3.reset()
l_n_row = dw_2.retrieve(ls_area, ls_division, ls_invoiceno, ls_customer, ls_labelgubun)

if l_n_row > 0 then
	l_n_currow 	= dw_2.getrow()
	dw_2.selectrow(0,false)
	dw_2.selectrow(l_n_currow,true)	
	uo_status.st_message.text	=	'��ȸ�Ǿ����ϴ�.'
else
	uo_status.st_message.text	=	'��ȸ�� �ڷᰡ �����ϴ�.'  	
end if		

setpointer(arrow!)

return 0


end event

event ue_delete;call super::ue_delete;long 	ll_currow
integer li_rtn
string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode, ls_invoiceno
integer li_serialnofrom

ll_currow = dw_2.getselectedrow(0)
ls_customercode			= dw_2.getitemstring(ll_currow, 'customercode')
ls_areacode					= dw_2.getitemstring(ll_currow, 'areacode')
ls_divisioncode			= dw_2.getitemstring(ll_currow, 'divisioncode')
ls_customeritemcode		= dw_2.getitemstring(ll_currow, 'customeritemcode')
ls_invoiceno				= dw_2.getitemstring(ll_currow, 'invoiceno')
li_serialnofrom			= dw_2.getitemnumber(ll_currow, 'serialnofrom')
li_rtn = messagebox("�˸�", "���� ���� �Ͻðڽ��ϱ�?",question!,yesno!,1)   //���������Ͻðڽ��ϱ�?
if li_rtn = 2 then
	uo_status.st_message.text = "������ ��ҵǾ����ϴ�."
	return 0
end if

delete from tshiplabelcontainer
	where areacode = :ls_areacode and
			divisioncode = :ls_divisioncode and
			customercode = :ls_customercode and
			customeritemcode = :ls_customeritemcode and
			invoiceno			=	:ls_invoiceno	and
			serialnofrom 		= :li_serialnofrom	
using sqlpis;

if sqlpis.sqlcode = 0 then
	commit using sqlpis;
	triggerevent("ue_retrieve")
	uo_status.st_message.text = "�����Ǿ����ϴ�."
else
	rollback using sqlpis;
	uo_status.st_message.text = "err_d1; " + "�������� �����ý������� �����ٶ��ϴ�."
end if

end event

event ue_save;call super::ue_save;string ls_labelgubun
integer li_rtn

ls_labelgubun = dw_3.getitemstring(1, "labelgubun")
choose case ls_labelgubun
	case 'DH'
		li_rtn = wf_save_form()
	case 'DA'
		li_rtn = wf_save_dra()
	case 'FD'
		li_rtn = wf_save_ford()
	case 'GO','GP','GQ','LD'
		li_rtn = wf_save_odette()
	case else
		uo_status.st_message.text = "���ǵ� ���� �ƴմϴ�. �ý��۰����� ����ڿ��� �����ٶ��ϴ�."
		return 0
end choose

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss611u
end type

type gb_2 from groupbox within w_piss611u
integer x = 2798
integer y = 36
integer width = 759
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "����"
end type

type uo_area from u_pisc_select_area within w_piss611u
integer x = 46
integer y = 76
integer taborder = 10
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
	dw_2.SetTransObject(SQLPIS)
	dw_3.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)


End If

end event

type uo_division from u_pisc_select_division within w_piss611u
integer x = 535
integer y = 76
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_2.SetTransObject(SQLPIS)
	dw_3.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_piss_retrieve_dddw_labelcustomer(uo_customer.dw_1,'%','%',true,uo_customer.is_uo_customercode,uo_customer.is_uo_customername)
	f_piss_retrieve_dddw_labelgubun(uo_label.dw_1,uo_area.is_uo_areacode,uo_division.is_uo_divisioncode,true,uo_label.is_uo_labelcode,uo_label.is_uo_labelname)	
End If

end event

type gb_1 from groupbox within w_piss611u
integer x = 18
integer width = 3584
integer height = 296
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_2 from u_vi_std_datawindow within w_piss611u
integer x = 23
integer y = 312
integer width = 3584
integer height = 288
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_piss611u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_customercode, ls_areacode, ls_divisioncode,&
			ls_customeritemcode, ls_invoiceno, ls_labelgubun
integer	li_row
long ll_count
If currentrow <= 0 Then
	return 0
end if

ls_customercode		= 	dw_2.getitemstring(currentrow, 'customercode')
ls_areacode				= 	dw_2.getitemstring(currentrow, 'areacode')
ls_divisioncode 		= 	dw_2.getitemstring(currentrow, 'divisioncode')
ls_customeritemcode	=	dw_2.getitemstring(currentrow, 'customeritemcode')
ls_invoiceno 			= 	dw_2.getitemstring(currentrow, 'invoiceno')
ls_labelgubun			= 	dw_2.getitemstring(currentrow, 'labelgubun')

choose case ls_labelgubun
	case 'DH'
		dw_3.dataobject = "d_piss611u_02"
		em_3.text = '11'
		em_4.text = '0'
	case 'DA'
		dw_3.dataobject = "d_piss611u_03"
		em_3.text = '11'
		em_4.text = '0'
	case 'FD'
		dw_3.dataobject = "d_piss611u_04"
		em_3.text = '11'
		em_4.text = '0'
	case 'GO','GP','GQ','LD'
		dw_3.dataobject = "d_piss611u_06"
		em_3.text = "0"
		em_4.text = "0"
	case else
		uo_status.st_message.text = "���ǵ� ���� �ƴմϴ�. �ý��۰����� ����ڿ��� �����ٶ��ϴ�."
		return 0
end choose

dw_3.settransobject(sqlpis)

select count(*) into :ll_count
from tshiplabelcontainer
where AreaCode				=	:ls_areacode			and
		DivisionCode		=	:ls_Divisioncode		and
		CustomerCode		=	:ls_customercode		and
		CustomerItemCode	=	:ls_customeritemcode	and
		InvoiceNo			=	:ls_invoiceno 			using sqlpis ;

if ll_count > 0 then			
	li_row	=	dw_3.retrieve(ls_areacode,			ls_divisioncode,&
									  ls_customercode,	ls_customeritemcode,&
									  dw_2.object.invoiceno[currentrow],&
									  dw_2.object.serialnofrom[currentrow])
	if li_row	=	0	then
		dw_3.setitem(1,'customercode',	ls_customercode)
		dw_3.setitem(1,'areacode',			ls_areacode)
		dw_3.setitem(1,'divisioncode',	ls_divisioncode)
//		dw_3.setitem(1,'customeritemcode',ls_customeritemcode)
	end if
	
	dw_3.setfocus() 
	uo_status.st_message.text	=	'��ȸ�Ǿ����ϴ�.'
else
	uo_status.st_message.text	=	'�Էµ� ������ �����ϴ�.'
end if	

end event

type st_3 from statictext within w_piss611u
integer x = 1147
integer y = 84
integer width = 375
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
string text = "Invoice No:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss611u
integer x = 1513
integer y = 76
integer width = 457
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type dw_3 from datawindow within w_piss611u
integer x = 18
integer y = 1108
integer width = 3584
integer height = 564
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss611u_06"
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_piss611u
integer x = 2551
integer y = 76
integer width = 142
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_2 from statictext within w_piss611u
integer x = 2094
integer y = 84
integer width = 457
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
string text = "Label����ż�:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss611u
integer x = 2981
integer y = 92
integer width = 165
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "����:"
boolean focusrectangle = false
end type

type em_3 from editmask within w_piss611u
integer x = 3145
integer y = 76
integer width = 123
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_5 from statictext within w_piss611u
integer x = 3282
integer y = 92
integer width = 114
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "��:"
boolean focusrectangle = false
end type

type em_4 from editmask within w_piss611u
integer x = 3383
integer y = 76
integer width = 123
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type dw_print from datawindow within w_piss611u
boolean visible = false
integer x = 425
integer y = 840
integer width = 2907
integer height = 996
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss611u_04p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_customer from u_piss_select_labelcustomer within w_piss611u
integer x = 27
integer y = 180
integer taborder = 20
boolean bringtotop = true
end type

on uo_customer.destroy
call u_piss_select_labelcustomer::destroy
end on

type uo_label from u_piss_select_labelgubun within w_piss611u
integer x = 1070
integer y = 180
integer taborder = 30
boolean bringtotop = true
end type

on uo_label.destroy
call u_piss_select_labelgubun::destroy
end on

type cb_addlabel from commandbutton within w_piss611u
integer x = 2135
integer y = 176
integer width = 457
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���߰�"
end type

event clicked;str_parms lstr_parm

lstr_parm.string_arg[1] = uo_area.is_uo_areacode
lstr_parm.string_arg[2] = uo_division.is_uo_divisioncode

openwithparm(w_piss611r, lstr_parm)
end event

type pb_print from picturebutton within w_piss611u
string tag = "�����μ�"
integer x = 3013
integer y = 184
integer width = 302
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\Printer.bmp"
alignment htextalign = left!
end type

event clicked;string ls_pagerange

// ���� �μ�
if wf_label_print() = -1 then
	return -1
end if

open(w_piss_print_range)
ls_pagerange = message.stringparm

if f_spacechk(ls_pagerange) = -1 then
	return 0
end if

Long	ll_printjob
ll_printjob	= PrintOPen()
dw_print.object.datawindow.print.page.range = ls_pagerange
dw_print.modify("datawindow.Print.Orientation = 1" )
dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_3.Text))*100 ))
dw_print.Modify("datawindow.print.margin.right   = 0")
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_4.Text))*100 ))
PrintDataWindow(ll_printjob, dw_print)
PrintClose(ll_printjob)
messagebox('Ȯ��', '����Ͽ����ϴ�')
end event

type st_6 from statictext within w_piss611u
integer x = 2688
integer y = 196
integer width = 315
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "�����μ�:"
alignment alignment = center!
boolean focusrectangle = false
end type

