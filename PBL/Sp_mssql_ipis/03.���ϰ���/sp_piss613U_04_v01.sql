/*

Execute sp_piss613U_04
	@Ps_Areacode		= 'D',
	@Ps_Divisioncode	= 'A',
	@Ps_customerCode	= 'E39111',
	@Ps_Invoiceno		= 'DA32-O026',
	@ps_serialnofrom	= 11
Dbcc Opentran

*/

ALTER  Procedure sp_piss613U_04
	@Ps_Areacode		Char(1),	-- 지역 코드
	@Ps_Divisioncode	Char(1),	-- 공장 코드
	@Ps_Customercode	Varchar(6),	-- 거래처 코드
	@Ps_invoiceno		Varchar(20),	-- Invoice No
	@Ps_serialnofrom	smallInt	-- Serial No
	
As
Begin

Select	Customercode		=	a.Customercode,
	Areacode		=	a.Areacode,
	Divisioncode		=	a.Divisioncode,
	Invoiceno		=	a.Invoiceno,
	serialnofrom		=	a.serialnofrom,
	Labelcount		=	a.Labelcount,
	Tracedate		=	a.Tracedate,
	Suppliercode		=	b.Suppliercode,
	Suppliername		=	b.Suppliername,
	segment1		=	b.segment1,
	segment2		=	b.segment2,
	segment3		=	b.segment3,
	PlantDock		=	c.PlantDock,
	Suppliercity		=	c.Suppliercity,
	Supplierpostal		=	c.Supplierpostal,
	Countryoforigin		=	c.Countryoforigin,	
	Containerinvoiceno	=	c.invoiceno,
	Customerdivision	=	c.customerdivision,
	Customerplantaddress	=	c.customerplantaddress,
	Customerplantcity	=	c.customerplantcity,
	Customerstate		=	c.customerstate,
	Customerpostal		=	c.customerpostal,
	Supplierno = c.SupplierNo,
	Containerno = c.Containerno,
	Customerno = c.CustomerNo,
	Grosswgt = c.GrossWgt
From	Tlabelmixed a, Tlabelcustomer b,
	(select	ww.areacode,		ww.Divisioncode,		ww.Customercode,
		ww.Customeritemcode,	xx.PlantDock,			xx.suppliercity,
		xx.Supplierpostal,	xx.Countryoforigin,		ww.invoiceno,
		xx.customerdivision,	xx.customerplantaddress,	xx.customerplantcity,
		xx.customerstate,	xx.customerpostal, xx.supplierno, xx.customerno, xx.grosswgt, xx.containerno
	from	 Tlabelcontainer ww, Tlabelitem xx
	where	ww.areacode		=	xx.areacode		and
		ww.divisioncode		=	xx.divisioncode		and
		ww.customercode		=	xx.customercode		and
		ww.customeritemcode	=	xx.customeritemcode	and
		labelgroupgubun		=	'X'			and
		Masterinvoiceno		=	@ps_invoiceno		and
		labelgroupserial	=	@ps_serialnofrom) c
Where   a.Customercode		=	b.customercode		And
	a.areacode		=	c.areacode		And
	a.Divisioncode		=	c.divisioncode		And
	a.Customercode		=	c.customercode		And
	a.Areacode		=	@ps_areacode		And
	a.Divisioncode		=	@ps_divisioncode	And
	a.Customercode		=	@ps_Customercode	And
	a.InvoiceNo		=	@ps_InvoiceNo		And
	a.serialnofrom		=	@ps_SerialnoFrom	
order by	a.customercode,	a.Areacode,	a.Divisioncode,	a.Invoiceno,
		a.serialnofrom,	c.invoiceno

Return

End		-- Procedure End

