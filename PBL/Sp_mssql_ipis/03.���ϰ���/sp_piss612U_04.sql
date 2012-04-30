/*

Execute sp_piss612U_04
	@Ps_Areacode		= 'D',
	@Ps_Divisioncode	= 'A',
	@Ps_customerCode	= 'E39111',
	@Ps_customeritemcode	= '19020706',
	@Ps_Invoiceno		= 'DA32-O026',
	@ps_serialnofrom	= 11
Dbcc Opentran

*/

ALTER   Procedure sp_piss612U_04
	@Ps_Areacode		Char(1),	-- 지역 코드
	@Ps_Divisioncode	Char(1),	-- 공장 코드
	@Ps_Customercode	Varchar(6),	-- 거래처 코드
	@ps_Customeritemcode	Varchar(20),	-- 거래처품번
	@Ps_invoiceno		Varchar(20),	-- Invoice No
	@Ps_serialnofrom	smallInt	-- Serial No
	
As
Begin

Select	Customercode		=	a.Customercode,
	Areacode		=	a.Areacode,
	Divisioncode		=	a.Divisioncode,
	Customeritemcode	=	a.Customeritemcode,
	Invoiceno		=	a.Invoiceno,
	serialnofrom		=	a.serialnofrom,
	Labelcount		=	a.Labelcount,
	Shipqty			=	a.Shipqty,
	Tracedate		=	a.Tracedate,
	segment1		=	b.segment1,
	segment2		=	b.segment2,
	segment3		=	b.segment3,
	Suppliercode		=	b.Suppliercode,
	Suppliername		=	b.Suppliername,
	DeliveryLocation	=	c.DeliveryLocation,
	PlantDock		=	c.PlantDock,
	Suppliercity		=	c.Suppliercity,
	Supplierpostal		=	c.Supplierpostal,
	Countryoforigin		=	c.Countryoforigin,	
	Customeritemname	=	e.Custitemname,
	Itemcode		=	c.Itemcode,
	Unit			=	c.Unit,
	Containerinvoiceno	=	d.invoiceno,
	CustomerDivision = c.CustomerDivision,
	CustomerPlantAddress = c.CustomerPlantAddress,
	CustomerPlantAddress2 = c.CustomerPlantAddress2,
	CustomerCity  = c.CustomerPlantCity,
	CustomerState = c.CustomerState,
	PlantDock = c.PlantDock,
	CustomerNo = c.CustomerNo,
	EngAlert = c.EngAlert,
	SupplierNo = c.SupplierNo,
	ContainerNo = c.ContainerNo,
	GrossWgt = c.GrossWgt,
	PartNo = c.PartNo,
	PartDesc = c.PartDesc,
	StandardPackQty = c.StandardPackQty,
	WorkCenter = c.WorkCenter,
	Shift = c.Shift,
	LotSize = c.LotSize,
	DockCode = c.DockCode,
	LabelGubun = c.LabelGubun,
	Bar2dCheck = c.Bar2dCheck
From	Tlabelmaster a, Tlabelcustomer b, Tlabelitem c, Tlabelcontainer d, Tmstcustitem e
Where   a.Customercode		=	b.customercode		And
	a.areacode		=	c.areacode		And
	a.Divisioncode		=	c.divisioncode		And
	a.Customercode		=	c.customercode		And
	a.Customeritemcode	=	c.customeritemcode	And
	a.areacode		=	d.areacode		And
	a.Divisioncode		=	d.divisioncode		And
	a.Customercode		=	d.customercode		And
	a.Customeritemcode	=	d.customeritemcode	And
	a.invoiceno		=	d.masterinvoiceno	And
	a.serialnofrom		=	d.labelgroupserial	And
	a.customercode		=	e.custcode		And
	a.customeritemcode	=	e.custitemcode		and
	a.Areacode		=	@ps_areacode		And
	a.Divisioncode		=	@ps_divisioncode	And
	a.Customercode		=	@ps_Customercode	And
	a.Customeritemcode	=	@ps_Customeritemcode	And
	a.InvoiceNo		=	@ps_InvoiceNo		And
	a.serialnofrom		=	@ps_SerialnoFrom	And	
	d.labelgroupgubun	=	'M'
order by	a.customercode,	a.Areacode,	a.Divisioncode,
		a.Customeritemcode,	a.Invoiceno,
		a.serialnofrom,	d.invoiceno

Return

End		-- Procedure End


GO
