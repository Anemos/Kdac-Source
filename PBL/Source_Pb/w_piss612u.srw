$PBExportHeader$w_piss612u.srw
$PBExportComments$Master Shipping Label
forward
global type w_piss612u from w_ipis_sheet01
end type
type gb_4 from groupbox within w_piss612u
end type
type uo_area from u_pisc_select_area within w_piss612u
end type
type uo_division from u_pisc_select_division within w_piss612u
end type
type gb_1 from groupbox within w_piss612u
end type
type dw_2 from u_vi_std_datawindow within w_piss612u
end type
type uo_customer from u_piss_select_labelcustomer within w_piss612u
end type
type st_3 from statictext within w_piss612u
end type
type dw_3 from datawindow within w_piss612u
end type
type dw_4 from datawindow within w_piss612u
end type
type gb_3 from groupbox within w_piss612u
end type
type gb_2 from groupbox within w_piss612u
end type
type dw_5 from datawindow within w_piss612u
end type
type st_2 from statictext within w_piss612u
end type
type em_1 from editmask within w_piss612u
end type
type em_4 from editmask within w_piss612u
end type
type st_4 from statictext within w_piss612u
end type
type em_3 from editmask within w_piss612u
end type
type st_5 from statictext within w_piss612u
end type
type dw_print from datawindow within w_piss612u
end type
end forward

global type w_piss612u from w_ipis_sheet01
gb_4 gb_4
uo_area uo_area
uo_division uo_division
gb_1 gb_1
dw_2 dw_2
uo_customer uo_customer
st_3 st_3
dw_3 dw_3
dw_4 dw_4
gb_3 gb_3
gb_2 gb_2
dw_5 dw_5
st_2 st_2
em_1 em_1
em_4 em_4
st_4 st_4
em_3 em_3
st_5 st_5
dw_print dw_print
end type
global w_piss612u w_piss612u

type variables
Boolean	ib_open
int ii_currentrow
string	is_firstareacode,	is_firstdivisioncode,	is_firstcustomercode,&
			is_firstcustomeritemcode,	is_firstinvoiceno
end variables

forward prototypes
public function integer wf_itemcheck ()
public function integer wf_replacesave ()
public function integer wf_mastercheck ()
public function integer wf_deletesave ()
public function integer wf_insertsave ()
public subroutine wf_label_ford (integer ag_printcount)
public subroutine wf_label_form (integer ag_printcount)
end prototypes

public function integer wf_itemcheck ();integer li_rowcount, li_selectcount, i

li_selectcount = 0
is_firstcustomeritemcode	=	''
is_firstinvoiceno				=	''
li_rowcount = dw_3.rowcount()
for i = 1 to li_rowcount
	if dw_3.getitemstring(i, 'instcheck') = 'Y' then
		li_selectcount ++
		if li_selectcount = 1 then
			is_firstcustomeritemcode	= dw_3.getitemstring(i, 'customeritemcode')
			is_firstareacode				= dw_3.getitemstring(i, 'areacode')
			is_firstdivisioncode			= dw_3.getitemstring(i, 'divisioncode')
			is_firstcustomercode			= dw_3.getitemstring(i, 'customercode')
			is_firstinvoiceno				= dw_3.getitemstring(i, 'invoiceno')
		else
			if dw_3.getitemstring(i, 'customeritemcode') <> is_firstcustomeritemcode then
				return -1
			end if
		end if
	end if
next

if li_selectcount = 0 then
	return -1
end if
	
return 0
end function

public function integer wf_replacesave ();string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode,&
		 ls_invoiceno, ls_tracedate
integer li_shipqty, li_serialnofrom, li_row

li_shipqty		= dw_4.getitemnumber(1, "shipqty")
ls_tracedate	= dw_4.getitemstring(1, "tracedate")

ls_areacode				= dw_2.getitemstring(ii_currentrow, "areacode")
ls_divisioncode		= dw_2.getitemstring(ii_currentrow, "divisioncode")
ls_customercode		= dw_2.getitemstring(ii_currentrow, "customercode")
ls_customeritemcode	= dw_2.getitemstring(ii_currentrow, "customeritemcode")
ls_invoiceno			= dw_2.getitemstring(ii_currentrow, "masterinvoiceno")
li_serialnofrom		= dw_2.getitemnumber(ii_currentrow, "serialnofrom")

update tlabelmaster
	set	shipqty = :li_shipqty, tracedate = :ls_tracedate		 
where areacode 			= :ls_areacode and
		divisioncode		=	:ls_divisioncode	and
		customercode		=	:ls_customercode	and
		customeritemcode	=	:ls_customeritemcode	and
		invoiceno			=	:ls_invoiceno	and
		serialnofrom		=	:li_serialnofrom	using sqlpis;

if sqlpis.sqlcode <>	0 then
	uo_status.st_message.text = '저장 실패'
	rollback using sqlpis;
	return -1
end if	


if sqlpis.sqlcode =	0 then
	commit using sqlpis;
	uo_status.st_message.text = '저장이 되었습니다.'
end if
		
dw_2.setitem(1,"Shipqty",				li_Shipqty)
dw_2.setitem(1,"Tracedate",			ls_Tracedate)	

return 0

end function

public function integer wf_mastercheck ();
if dw_4.object.labelcount[1] = 0 or isnull(dw_4.object.labelcount[1]) then
	messagebox('확인','매수정보를 정보를 입력 바랍니다.')
	return -1
end if

if dw_4.object.shipqty[1] = 0 or isnull(dw_4.object.shipqty[1]) then	
	messagebox('확인','수용수 정보를 입력 바랍니다.')
	return -1
end if

if isnull(dw_4.object.tracedate[1]) then
	messagebox('확인','출하일 정보를 입력 바랍니다.')
	return -1
end if

if trim(f_dateedit(dw_4.object.tracedate[1])) = ''	then
	messagebox('확인','날짜 체계가 틀립니다.')
	return -1
end if
return 0
end function

public function integer wf_deletesave ();integer li_serialnofrom, li_serialnofromcon, li_rowcount, i, li_count, ln_currow
string  ls_areacode,	ls_divisioncode,	ls_customercode
string	ls_customeritemcode, ls_invoiceno

li_rowcount = dw_3.rowcount()
for i = 1 to li_rowcount
	if dw_3.getitemstring(i, 'instcheck') = 'Y' then
		ls_areacode				= dw_3.getitemstring(i, 'areacode')
		ls_divisioncode		= dw_3.getitemstring(i, 'divisioncode')
		ls_customercode		= dw_3.getitemstring(i, 'customercode')
		ls_customeritemcode	= dw_3.getitemstring(i, 'customeritemcode')
		ls_invoiceno			= dw_3.getitemstring(i, 'invoiceno')
		li_serialnofromcon	=	dw_3.getitemnumber(i, 'serialnofrom')
		update tlabelcontainer
		set labelgroupgubun	=	'',	masterinvoiceno = '',	labelgroupserial = 0
		where	areacode				= :ls_areacode				and
				divisioncode		= :ls_divisioncode		and
				customercode		= :ls_customercode		and
				customeritemcode	= :ls_customeritemcode	and
				invoiceno			= :ls_invoiceno			and
				serialnofrom		= :li_serialnofromcon	using sqlpis;
		if sqlpis.sqlcode <>	0 then
			uo_status.st_message.text = '삭제	실패'
			rollback using sqlpis;
			return -1
		end if	
	end if
next
ls_areacode				=	dw_2.object.areacode[ii_currentrow]
ls_divisioncode		=	dw_2.object.divisioncode[ii_currentrow]
ls_customercode		=	dw_2.object.customercode[ii_currentrow]
ls_customeritemcode	=	dw_2.object.customeritemcode[ii_currentrow]
ls_invoiceno			=	dw_2.object.masterInvoiceNo[ii_currentrow]
li_serialnofrom		=	dw_2.object.SerialnoFrom[ii_currentrow]
select isnull(count(*),0) into :li_count from tlabelcontainer
where areacode				= :ls_areacode				and
		divisioncode		= :ls_divisioncode		and
		customercode		= :ls_customercode		and
		labelgroupgubun	= 'M'							and
		masterinvoiceno	= :ls_invoiceno			and
		labelgroupserial	= :li_serialnofrom		using sqlpis;
if sqlpis.sqlcode <>	0 then
	li_count	=	0
end if
if li_count > 0 then
	dw_2.SelectRow(0, False)
	dw_2.SelectRow(ii_currentrow, True)
	dw_2.SetRow(ii_currentrow)
	dw_2.ScrollToRow(ii_currentrow)
return 0
end if

delete	from tlabelmaster
where	areacode				=	:ls_areacode	and
		divisioncode		=	:ls_divisioncode	and
		customercode		=	:ls_customercode	and
		customeritemcode	=	:ls_customeritemcode	and
		invoiceno			=	:ls_invoiceno			and
		serialnofrom		=	:li_serialnofrom	using sqlpis;
			
if sqlpis.sqlcode <>	0 then
	uo_status.st_message.text = '삭제 실패'
	rollback using sqlpis;
	return -1
end if	
		
dw_2.deleterow(ii_currentrow)
if dw_2.rowcount() = 0 then
	dw_3.reset()
	dw_4.reset()
end if

ln_currow 	= dw_2.getrow()
dw_2.setrow(ln_currow)
dw_2.selectrow(ln_currow,false)
dw_2.selectrow(ln_currow,true)	
setpointer(arrow!)
return 0

end function

public function integer wf_insertsave ();integer li_serialnofrom, li_labelcount, li_shipqty, li_rowcount, i, li_masterrowcount
integer	li_serialnofromcon, ln_currow, li_find
string ls_tracedate, ls_areacode,	ls_divisioncode,	ls_customercode
string	ls_customeritemcode, ls_invoiceno, ls_customeritemname, ls_itemcode
string	ls_serialtext
select isnull(sum(labelcount),0) into :li_serialnofrom from tlabelmaster
where areacode				=	:is_firstareacode 			and	
		divisioncode		=	:is_firstdivisioncode		and
		customercode		=	:is_firstcustomercode		and
		customeritemcode	=	:is_firstcustomeritemcode	and
		invoiceno			=	:is_firstinvoiceno			using sqlpis;
	

if sqlpis.sqlcode <> 0 then
	li_serialnofrom = 0
end if

li_serialnofrom = li_serialnofrom + 1
li_labelcount	= dw_4.getitemnumber(1, "labelcount")
li_shipqty		= dw_4.getitemnumber(1, "shipqty")
ls_tracedate	= dw_4.getitemstring(1, "tracedate")

insert	into tlabelmaster
		(areacode,				divisioncode,			customercode,	customeritemcode,
		 invoiceno,				serialnofrom,			labelcount,		shipqty,
		 tracedate)		 
	values(:is_firstareacode,		:is_firstdivisioncode,		:is_firstcustomercode, :is_firstcustomeritemcode,
			 :is_firstinvoiceno,		:li_serialnofrom,				:li_labelcount,			:li_shipqty,
			 :ls_tracedate)  using sqlpis ;
if sqlpis.sqlcode <>	0 then
	uo_status.st_message.text = '저장 실패'
	rollback using sqlpis;
	return -1
end if	

li_rowcount = dw_3.rowcount()
for i = 1 to li_rowcount
	if dw_3.getitemstring(i, 'instcheck') = 'Y' then
		ls_areacode				= dw_3.getitemstring(i, 'areacode')
		ls_divisioncode		= dw_3.getitemstring(i, 'divisioncode')
		ls_customercode		= dw_3.getitemstring(i, 'customercode')
		ls_customeritemcode	= dw_3.getitemstring(i, 'customeritemcode')
		ls_invoiceno			= dw_3.getitemstring(i, 'invoiceno')
		li_serialnofromcon	=	dw_3.getitemnumber(i, 'serialnofrom')
		update	tlabelcontainer
			set	labelgroupgubun	=	'M', masterinvoiceno	=	:is_firstinvoiceno,
					labelgroupserial	=	:li_serialnofrom
		where	areacode				= :ls_areacode				and
				divisioncode		= :ls_divisioncode		and
				customercode		= :ls_customercode		and
				customeritemcode	= :ls_customeritemcode	and
				invoiceno			= :ls_invoiceno			and
				serialnofrom		= :li_serialnofromcon	using sqlpis;
		if sqlpis.sqlcode <>	0 then
			uo_status.st_message.text = '저장 실패'
			rollback using sqlpis;
			return -1
		end if	
	end if
next

if sqlpis.sqlcode =	0 then
	commit using sqlpis;
	uo_status.st_message.text = '저장이 되었습니다.'
end if

this.TriggerEvent("ue_retrieve")

ls_serialtext = "serialnofrom = " + string(li_serialnofrom)
li_find	= dw_2.Find("customercode = '" + is_firstcustomercode + "' And " + &
							"areacode = '" + is_firstareacode + "' And " + &
							"DivisionCode = '" + is_firstdivisioncode + "' And " + &
							"customeritemcode = '" + is_firstcustomeritemcode + "' And " + &
							"itemcode = '" + ls_itemcode + "' And " + &
							"masterinvoiceno = '" + is_firstinvoiceno + "' And " + &
							ls_serialtext, 1, dw_2.RowCount())
If li_find > 0 Then
	dw_2.SetRow(li_find)
	dw_2.selectrow(li_find,false)
	dw_2.selectrow(li_find,true)	
	setpointer(arrow!)
end if	

return 0

end function

public subroutine wf_label_ford (integer ag_printcount);boolean	lb_null = False
int		li_currow, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount
int		li_grosswgt, li_standardpackqty, li_shift, li_lotsize
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount
string 	ls_suppliername, ls_segment1, ls_segment2, ls_suppliercity, ls_countryoforigin
string	ls_customerdivision, ls_customaddr, ls_customaddr2, ls_customeritemcode
string	ls_customercity, ls_customerstate, ls_plantdock, ls_deliverylocation
string 	ls_customerno, ls_engalert, ls_supplierno, ls_containerno, ls_partdesc
string	ls_workcenter, ls_tracedate, ls_dockcode, ls_pkgid, ls_itemcode, ls_unit
string   ls_areacode, ls_divisioncode, ls_customercode, ls_invoiceno, ls_partitemcode, ls_bar2d

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	if dw_2.isselected(li_selectedcount) <> true then
		continue
	end if
	// 세부 라벨품목 조회하기
	ls_areacode					= dw_2.getitemstring(li_selectedcount,'areacode')
	ls_divisioncode			= dw_2.getitemstring(li_selectedcount,'divisioncode')
	ls_customercode			= dw_2.getitemstring(li_selectedcount,'customercode')
	ls_customeritemcode		= Trim(dw_2.getitemstring(li_selectedcount,'customeritemcode'))
	ls_invoiceno				= Trim(dw_2.getitemstring(li_selectedcount, 'masterinvoiceno'))
	li_serialnofrom			= dw_2.getitemnumber(li_selectedcount, 'serialnofrom')
	li_codecount = dw_5.retrieve(ls_areacode, ls_divisioncode, ls_customercode, &
				ls_customeritemcode,ls_invoiceno,li_serialnofrom)
	if li_codecount < 1 then
		continue
	end if
	//Null Value Check
	ls_suppliername		= dw_5.getitemstring(1,'suppliername')		
	ls_segment1				= dw_5.getitemstring(1,'segment1')
	ls_segment2				= dw_5.getitemstring(1,'segment2')
	ls_suppliercity		= dw_5.getitemstring(1,'suppliercity')
	ls_customeritemcode	= dw_5.getitemstring(1,'partno')
	ls_countryoforigin	= dw_5.getitemstring(1,'countryoforigin')
	ls_customerdivision	= dw_5.getitemstring(1,'customerdivision')
	ls_customaddr			= dw_5.getitemstring(1,'customerplantaddress')
	ls_customaddr2			= dw_5.getitemstring(1,'customerplantaddress2')
	ls_customercity		= dw_5.getitemstring(1,'customercity')
	ls_customerstate		= dw_5.getitemstring(1,'customerstate')
	ls_plantdock			= dw_5.getitemstring(1,'plantdock')
	ls_deliverylocation	= dw_5.getitemstring(1,'deliverylocation')
	ls_customerno			= dw_5.getitemstring(1,'customerno')
	ls_itemcode				= dw_5.getitemstring(1,'itemcode')
	ls_engalert				= dw_5.getitemstring(1,'engalert')
	ls_supplierno			= dw_5.getitemstring(1,'supplierno')
	ls_containerno			= dw_5.getitemstring(1,'containerno')
	ls_partdesc				= dw_5.getitemstring(1,'partdesc')
	ls_workcenter			= dw_5.getitemstring(1,'workcenter')
	ls_tracedate			= dw_5.getitemstring(1,'tracedate')
	ls_dockcode				= dw_5.getitemstring(1,'dockcode')
	ls_unit					= dw_5.getitemstring(1,'unit')
	li_shipqty				= dw_5.getitemnumber(1,'shipqty')
	li_grosswgt				= ( dw_5.getitemnumber(1, 'grosswgt') * 2.25 )
	li_standardpackqty	= dw_5.getitemnumber(1,'standardpackqty')
	li_shift					= dw_5.getitemnumber(1,'shift')
	li_lotsize				= dw_5.getitemnumber(1,'lotsize')
//	if ls_customeritemcode = '892940' then
//		ls_lotno = 'C02' + ls_lotno + '1'
//	end if
	li_serialnofrom			= dw_5.getitemnumber(1,'serialnofrom')
	li_labelcount				= dw_5.getitemnumber(1, 'labelcount')

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
			dw_print.setitem(li_currow,'countryoforigin',ls_countryoforigin)
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
			dw_print.setitem(li_currow,'tracedate', string(date(string(ls_tracedate,"@@@@-@@-@@")),"DDMMMYYYY"))
			dw_print.setitem(li_currow,'shipqty',li_shipqty)
			dw_print.setitem(li_currow,'grosswgt',li_grosswgt)
			dw_print.setitem(li_currow,'standardpackqty',li_standardpackqty)
			ls_pkgid = upper(ls_divisioncode) + upper(right(ls_invoiceno,4)) +'-'+string(li_serialnofrom1,'000')
			dw_print.setitem(li_currow,'serialnofrom', ls_pkgid)
			// Calculate Barcode by code128
			ls_partitemcode = f_replace_dash_blank(ls_customeritemcode)
			dw_print.setitem(li_currow,'customeritemcodebar', &
				char(204) + f_piss_convert_code128( 'B', 'P' + trim(ls_partitemcode) ) + char(206))
			dw_print.setitem(li_currow,'shipqtybar', &
				char(204) + f_piss_convert_code128( 'B', 'Q' + String(li_shipqty) ) + char(206))
			dw_print.setitem(li_currow,'suppliernobar', &
				char(204) + f_piss_convert_code128( 'B', 'V' + trim(ls_supplierno) ) + char(206))
			dw_print.setitem(li_currow,'serialnofrombar', &
				char(204) + f_piss_convert_code128( 'B', '4S' + Trim(ls_pkgid) ) + char(206))
			// Calculate Barcode by BAR2D
			string ls_data
			ls_data =	char(91) + char(41) + char(62) + char(30) + "06" + char(29) +  &  
						"P" + mid(ls_customeritemcode,1,4) + " " + mid(ls_customeritemcode,6,6) + " " + mid(ls_customeritemcode,13,2) + char(29) + & 
						"Q" + String(li_shipqty)       + char(29) + &
						"V" +  trim(ls_supplierno)    + char(29) + &
						"D" +  upper(string(date(string(ls_tracedate,"@@@@-@@-@@")),"YYMMDD")) +  char(29) + &
						"4S" + trim(ls_pkgid) + char(30) + char(04)
			ls_bar2d = f_get_2dbarcode( ls_data )
			dw_print.setitem(li_currow,'bar2d',ls_bar2d)
		next
	next
Next
if li_printcount > 0 then		
//	Long	ll_printjob
//	ll_printjob	= PrintOPen()
//	dw_print.modify("datawindow.Print.Orientation = 1" )
//	dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_3.Text))*100 ))
//	dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_4.Text))*100 ))
//	
//	PrintDataWindow(ll_printjob, dw_print)
//	PrintClose(ll_printjob)
//	messagebox('확인', '출력하였습니다')
else
	messagebox('확인', 'Label정보가 존재 하지 않는 품목을 선택 하셨습니다.')
end if

return
				


end subroutine

public subroutine wf_label_form (integer ag_printcount);string	ls_areacode,		ls_divisioncode,	ls_customercode, ls_customeritemcode,&
			ls_invoiceno,		ls_plantdock,		ls_segment1,		ls_segment2,&
			ls_segment3,		ls_suppliercode,	ls_tracedate,		ls_suppliername,&
			ls_suppliercity,	ls_supplierpostal,	ls_countryoforigin,&
			ls_deliverylocation, ls_customeritemname, ls_unit, ls_containerinvoiceno,&
			ls_customeritemcodebar
boolean	lb_null = False
int		li_row, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_labelcount, ln_row, li_serialcount, ll_rowcount,&
			li_containerrowcount, li_invoicecount, li_codecount, li_sumitemcode,&
			li_sumitemcode1, li_remainitemcode


//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()
dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_3.Text))*100 )  )
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_4.Text))*100 ) )

For li_selectedcount = 1 To ll_rowcount
	   if dw_2.isselected(li_selectedcount) <> true then
			continue
		end if
		
		ls_areacode					= dw_2.getitemstring(li_selectedcount,'areacode')
		ls_divisioncode			= dw_2.getitemstring(li_selectedcount,'divisioncode')
		ls_customercode			= dw_2.getitemstring(li_selectedcount,'customercode')
		ls_customeritemcode		= dw_2.getitemstring(li_selectedcount,'customeritemcode')
		ls_invoiceno				= dw_2.getitemstring(li_selectedcount, 'masterinvoiceno')
		li_serialnofrom			= dw_2.getitemnumber(li_selectedcount, 'serialnofrom')
		ln_row = dw_5.retrieve(ls_areacode, ls_divisioncode, ls_customercode,ls_customeritemcode,&
									  ls_invoiceno,li_serialnofrom)
		li_containerrowcount = dw_5.rowcount()
		li_shipqty					=	dw_5.getitemnumber(1,'shipqty')
		ls_plantdock				=	dw_5.getitemstring(1,'plantdock')
		ls_segment1					=	dw_5.getitemstring(1,'segment1')
		ls_segment2					=	dw_5.getitemstring(1,'segment2')
		ls_segment3					=	dw_5.getitemstring(1,'segment3')
		ls_suppliercode			=	dw_5.getitemstring(1,'suppliercode')
		ls_deliverylocation		=	dw_5.getitemstring(1,'deliverylocation')
		ls_tracedate				=	dw_5.getitemstring(1,'tracedate')
		ls_suppliername			=	dw_5.getitemstring(1,'suppliername')
		ls_suppliercity			=	dw_5.getitemstring(1,'suppliercity')
		ls_supplierpostal			=	dw_5.getitemstring(1,'supplierpostal')
		ls_countryoforigin		=	dw_5.getitemstring(1,'countryoforigin')
		ls_customeritemname		=	dw_5.getitemstring(1,'customeritemname')
		ls_unit						=	dw_5.getitemstring(1,'unit')
		dw_print.object.t_invoiceno1.text = ' '
		dw_print.object.t_invoiceno2.text = ' '
		dw_print.object.t_invoiceno3.text = ' '
		dw_print.object.t_invoiceno4.text = ' '
		dw_print.object.t_invoiceno5.text = ' '
		dw_print.object.t_invoiceno6.text = ' '
		dw_print.object.t_invoiceno7.text = ' '
		dw_print.object.t_invoiceno8.text = ' '
		for li_invoicecount = 1 to li_containerrowcount
			ls_containerinvoiceno = dw_5.getitemstring(li_invoicecount,'containerinvoiceno')
			if dw_print.object.t_invoiceno1.text = ' ' then
				dw_print.object.t_invoiceno1.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno1.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno2.text = ' ' then
				dw_print.object.t_invoiceno2.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno2.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno3.text = ' ' then
				dw_print.object.t_invoiceno3.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno3.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno4.text = ' ' then
				dw_print.object.t_invoiceno4.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno4.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno5.text = ' ' then
				dw_print.object.t_invoiceno5.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno5.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno6.text = ' ' then
				dw_print.object.t_invoiceno6.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno6.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno7.text = ' ' then
				dw_print.object.t_invoiceno7.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno7.text = ls_containerinvoiceno then
					continue
				end if
			end if
			if dw_print.object.t_invoiceno8.text = ' ' then
				dw_print.object.t_invoiceno8.text = ls_containerinvoiceno
				continue
			else
				if dw_print.object.t_invoiceno8.text = ls_containerinvoiceno then
					continue
				end if
			end if
		next
		
		
		if ln_row	=	0	then
			messagebox('확인','선택한 Master정보의 상세정보가 없습니다.')
			continue
		end if
		
		li_row = 0
		li_serialnofrom = li_serialnofrom - 1
		for li_currentserial = 1	to dw_2.getitemnumber(li_selectedcount, 'labelcount')
		 	li_serialcount = li_serialnofrom + li_currentserial
		 	for li_currentprintcount = 1 to ag_printcount
				li_row ++		
				li_sumitemcode = 104
				ls_customeritemcodebar = 'P'+ls_customeritemcode
				for li_codeCount	= 1 to len(ls_CustomerItemCodebar)
					if len(trim(mid(ls_customeritemcodebar,li_codecount,1))) = 0 then
						li_sumitemcode = li_sumitemcode + (00 * li_codecount)
					else
						li_sumitemcode = li_sumitemcode + ((asc(mid(ls_customeritemcodebar,li_codecount,1))-32) * li_codecount)
					end if
				next
				li_sumitemcode1 = li_sumitemcode / 103
	//			li_remainitemcode = (li_sumitemcode - (li_sumitemcode1*103))+32
				li_remainitemcode = (li_sumitemcode - (li_sumitemcode1*103))
				if li_remainitemcode = 00 then
					li_remainitemcode =	li_remainitemcode + 194
				elseif li_remainitemcode > 194 then
							li_remainitemcode =	li_remainitemcode + 100
				else
							li_remainitemcode =	li_remainitemcode + 32
				end if	
				dw_print.insertrow(li_row)
				dw_print.setitem(li_row,'customeritemcode',	ls_CustomerItemCode)
				dw_print.setitem(li_row,'remainitemcode',	li_remainitemcode)
				dw_print.setitem(li_row,'customeritemname',	ls_CustomerItemname)
				dw_print.setitem(li_row,'shipqty',	li_shipqty)
				dw_print.setitem(li_row,'divisioncode',	ls_divisioncode)
				dw_print.setitem(li_row,'invoiceno',	ls_invoiceno)
				dw_print.setitem(li_row,'serialnofrom',li_serialcount)
				dw_print.setitem(li_row,'plantdock',	ls_plantdock)
				dw_print.setitem(li_row,'segment1',	ls_segment1)
				dw_print.setitem(li_row,'segment2',	ls_segment2)
				dw_print.setitem(li_row,'segment3',	ls_segment3)
				dw_print.setitem(li_row,'suppliercode',	ls_suppliercode)
				dw_print.setitem(li_row,'deliverylocation',	ls_deliverylocation)
				dw_print.setitem(li_row,'tracedate',	ls_tracedate)
				dw_print.setitem(li_row,'suppliername',	ls_suppliername)
				dw_print.setitem(li_row,'suppliercity',	ls_suppliercity)
				dw_print.setitem(li_row,'supplierpostal',	ls_supplierpostal)
				dw_print.setitem(li_row,'countryoforigin',	ls_countryoforigin)
				dw_print.setitem(li_row,'unit',	ls_unit)
			next
		next
Next
	
//Long	ll_printjob
//////ll_printjob	= PrintOPen()
//////printSetup()
//ll_printjob	= PrintOPen()
//PrintDataWindow(ll_printjob, dw_print)
//PrintClose(ll_printjob)
//messagebox('확인', '출력하였습니다')
return
				


end subroutine

on w_piss612u.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
this.dw_2=create dw_2
this.uo_customer=create uo_customer
this.st_3=create st_3
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.dw_5=create dw_5
this.st_2=create st_2
this.em_1=create em_1
this.em_4=create em_4
this.st_4=create st_4
this.em_3=create em_3
this.st_5=create st_5
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.uo_customer
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_1
this.Control[iCurrent+15]=this.em_4
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.em_3
this.Control[iCurrent+18]=this.st_5
this.Control[iCurrent+19]=this.dw_print
end on

on w_piss612u.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.uo_customer)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.dw_5)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.em_4)
destroy(this.st_4)
destroy(this.em_3)
destroy(this.st_5)
destroy(this.dw_print)
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
f_piss_retrieve_dddw_labelcustomer(uo_customer.dw_1,'%','%',false,uo_customer.is_uo_customercode,uo_customer.is_uo_customername)

ib_open = True

iw_this.PostEvent("ue_reset")
em_1.text = '2'
em_3.text = '11'
em_4.text = '0'
end event

event ue_reset;call super::ue_reset;dw_2.ReSet()
dw_3.ReSet()

end event

event activate;call super::activate;dw_2.SetTransObject(SQLPIS)
dw_3.SetTransObject(SQLPIS)
dw_4.SetTransObject(SQLPIS)
dw_5.SetTransObject(SQLPIS)


end event

event resize;call super::resize;dw_2.Width = newwidth - ( dw_2.x + 30 ) 
dw_2.Height = newheight - ( dw_2.y + 1290 ) 
gb_2.Width = dw_2.width + 60
gb_2.Height = dw_2.height +95

dw_4.Width = newwidth - ( dw_4.x + 30 ) 
dw_4.y = newheight - 1165
dw_4.Height = newheight - ( dw_4.y + 1020 ) 
dw_3.Width = newwidth - ( dw_3.x + 30 ) 
dw_3.y = (newheight - 1007)
dw_3.Height = newheight - ( dw_3.y + 110 ) 

gb_3.y = dw_4.y - 92
gb_3.Width = dw_3.width + 60
gb_3.Height = dw_3.height + 270


st_3.y = gb_3.y
st_3.x = gb_3.x+650
end event

event ue_insert;call super::ue_insert;string ls_customercode, ls_areacode, ls_divisioncode, ls_customeritemcode
int li_selcount
dw_3.dataobject = 'd_piss612u_03'
dw_3.settransobject(sqlpis)
dw_3.reset()
li_selcount = dw_3.retrieve(uo_area.is_uo_areacode,uo_division.is_uo_divisioncode,&
									uo_customer.is_uo_customercode)
dw_4.object.labelcount.protect = false 
dw_4.reset()
dw_4.insertrow(0)
dw_4.setfocus() 

uo_status.st_message.text = "수용수 입력후 Container정보를 선택 하십시오"
i_b_retrieve	=	i_b_retrieve
i_b_insert		=	i_b_insert
i_b_save			=	i_b_save
i_b_delete		=	false
i_b_print		=	i_b_print
i_b_dretrieve	=	i_b_dretrieve
i_b_dprint		=	i_b_dprint
i_b_dchar		=	i_b_dchar
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_print;integer li_printcount, li_currow, li_rowcnt
string  ls_labelgubun
li_printcount = integer(em_1.text)
li_rowcnt = dw_2.rowcount()

if li_rowcnt < 1 then
	messagebox('확인','출력할 내용이 없습니다.')
end if
if isnull(li_printcount) then
	messagebox('확인','인쇄 매수 확인 하세요')
	return
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
	if ls_labelgubun <> dw_2.getitemstring(li_currow,'labelgubun') then
		messagebox('알림','라벨구분이 동일한 것만 선택하시기 바랍니다.')
		return 0
	end if
Next
if ls_labelgubun = 'F' then
	dw_print.dataobject = 'd_piss612u_07p'
	wf_label_ford(li_printcount)
else
	dw_print.dataobject = 'd_piss612u_06p'
	wf_label_form(li_printcount)
end if

// 라벨 인쇄 테스트
	window 	l_to_open
	str_easy l_str_prt
	
	//인쇄 DataWindow 저장
	//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
	l_str_prt.transaction  = sqlpis
	l_str_prt.datawindow   = dw_print
	//l_str_prt.title = "완성품별 사용실적"
	l_str_prt.tag			  = This.ClassName()
		
	f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
	Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)

end event
event ue_retrieve;call super::ue_retrieve;string ls_invoiceno
long    l_n_row, l_n_currow

//ls_invoiceno = em_1.text

uo_status.st_message.text	=	"조회중입니다."

dw_2.reset()
dw_3.reset()

l_n_row = dw_2.retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode,uo_customer.is_uo_customercode)
//l_n_row = dw_3.retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode,uo_customer.is_uo_customercode)

if l_n_row > 0 then
	l_n_currow 	= dw_2.getrow()
	dw_2.selectrow(0,false)
	dw_2.selectrow(l_n_currow,true)	
	uo_status.st_message.text	=	'조회되었습니다.'
else
	uo_status.st_message.text	=	'조회할 자료가 없습니다.'  	
end if		

setpointer(arrow!)

i_b_retrieve	=	i_b_retrieve
i_b_insert		=	i_b_insert
i_b_save			=	i_b_save
i_b_delete		=	true
i_b_print		=	i_b_print
i_b_dretrieve	=	i_b_dretrieve
i_b_dprint		=	i_b_dprint
i_b_dchar		=	i_b_dchar
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)


end event

event ue_save;call super::ue_save;string ls_instcheck
integer li_rowcount, li_selectcount, i
dw_2.accepttext()
dw_3.accepttext()
dw_4.accepttext()
if wf_mastercheck() = -1 then
	return
end if

if dw_3.dataobject = 'd_piss612u_03' then
	if wf_itemcheck() = -1 then
		messagebox('확인', '선택한 품목이 없거나 ~r~n 2개 이상의 품번이 선택 되었습니다.')
		return
	end if
	if wf_insertsave() = -1 then
		uo_status.st_message.text = '저장 실패'
		return
	else
		uo_status.st_message.text = '저장 되었습니다.'
		return
	end if
else
	if wf_replacesave() = -1 then
		uo_status.st_message.text = '저장 실패'
		return
	else
		uo_status.st_message.text = '저장 되었습니다.'
		return
	end if
end if

end event

event ue_delete;call super::ue_delete;
dw_2.accepttext()
dw_3.accepttext()
if wf_itemcheck() = -1 then
	messagebox('확인', '선택한 품목이 없습니다.')
	return
end if
if wf_deletesave() = -1 then
	uo_status.st_message.text = '삭제 실패'
	return
else
	uo_status.st_message.text = '삭제 되었습니다.'
	return
end if

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss612u
end type

type gb_4 from groupbox within w_piss612u
integer x = 2811
integer y = 36
integer width = 768
integer height = 128
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "여백"
end type

type uo_area from u_pisc_select_area within w_piss612u
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
	dw_4.SetTransObject(SQLPIS)
	dw_5.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	f_piss_retrieve_dddw_labelcustomer(uo_customer.dw_1,'%','%',false,uo_customer.is_uo_customercode,uo_customer.is_uo_customername)

End If

end event

type uo_division from u_pisc_select_division within w_piss612u
integer x = 590
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
	dw_4.SetTransObject(SQLPIS)
	dw_5.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_piss_retrieve_dddw_labelcustomer(uo_customer.dw_1,'%','%',false,uo_customer.is_uo_customercode,uo_customer.is_uo_customername)

End If

end event

type gb_1 from groupbox within w_piss612u
integer x = 18
integer width = 3584
integer height = 192
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_2 from u_vi_std_datawindow within w_piss612u
integer x = 59
integer y = 280
integer width = 1591
integer height = 288
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_piss612u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;int li_row
If currentrow <= 0 Then
	return
end if

ii_currentrow = currentrow
dw_3.dataobject = 'd_piss612u_01'
dw_3.settransobject(sqlpis)
dw_3.reset()
li_row = dw_3.retrieve(dw_2.object.areacode[currentrow], dw_2.object.divisioncode[currentrow],&
								dw_2.object.customercode[currentrow], 'M', dw_2.object.masterInvoiceNo[currentrow],&
								dw_2.object.SerialnoFrom[currentrow])

dw_4.reset()
dw_4.insertrow(0)

dw_4.setitem(1, "shipqty", dw_2.object.ShipQty[currentrow])
dw_4.setitem(1, "labelcount", dw_2.object.labelcount[currentrow])
dw_4.setitem(1, "tracedate", dw_2.object.tracedate[currentrow])

dw_4.setfocus() 

if li_row > 0 then
	uo_status.st_message.text	=	'조회되었습니다.'
else
	uo_status.st_message.text	=	'조회할 정보가 없습니다.'
end if
dw_4.object.labelcount.protect = true

end event

type uo_customer from u_piss_select_labelcustomer within w_piss612u
integer x = 1157
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_customer.destroy
call u_piss_select_labelcustomer::destroy
end on

type st_3 from statictext within w_piss612u
integer x = 64
integer y = 760
integer width = 1838
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217857
long backcolor = 67108864
string text = "입력은 입력 버튼 클릭후 수용수입력,대상품목 선택후 저장"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_piss612u
integer x = 59
integer y = 1084
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss612u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_piss612u
integer x = 59
integer y = 824
integer width = 786
integer height = 132
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss612u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_piss612u
integer x = 23
integer y = 964
integer width = 1797
integer height = 396
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "Container 현황"
end type

type gb_2 from groupbox within w_piss612u
integer x = 23
integer y = 204
integer width = 1659
integer height = 396
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "Master 현황"
end type

type dw_5 from datawindow within w_piss612u
boolean visible = false
integer x = 2057
integer y = 364
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "d_piss612u_05"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_piss612u
integer x = 2217
integer y = 84
integer width = 434
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labal 발행매수:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss612u
integer x = 2647
integer y = 76
integer width = 142
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type em_4 from editmask within w_piss612u
integer x = 3406
integer y = 76
integer width = 142
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_4 from statictext within w_piss612u
integer x = 3291
integer y = 84
integer width = 119
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "위:"
boolean focusrectangle = false
end type

type em_3 from editmask within w_piss612u
integer x = 3118
integer y = 76
integer width = 142
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_5 from statictext within w_piss612u
integer x = 2949
integer y = 84
integer width = 165
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "왼쪽:"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_piss612u
boolean visible = false
integer x = 1042
integer y = 516
integer width = 1591
integer height = 996
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss612u_06p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

