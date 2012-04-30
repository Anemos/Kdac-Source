SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/*
Execute sp_piss614u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_customercode	= 'E39111',
	@ps_customeritemcode	= '19020706',
	@ps_serialnoFrom	= 0

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

ALTER     Procedure sp_piss614u_02
	@ps_areacode		char(1),	-- 지역 코드
	@ps_divisioncode	char(1),	-- 공장 코드
	@ps_CustomerCode	char(6),	-- 거래처 코드
	@ps_CustomerItemCode	VarChar(18),	-- 거래처품번
	@ps_serialNoFrom	smallInt	-- SerialNoFrom	

As
Begin
Create table	#tmp_container
	(CustomerCode		Varchar(6)	Null,
	 SupplierCode		VarChar(12)	Null,
	 SupplierName		VarChar(30)	Null,
	 Segment1		VarChar(30)	Null,
	 Segment2		VarChar(30)	Null,
	 Segment3		VarChar(30)	Null,
	 AreaCode		Char(1)		Null,
	 DivisionCode		Char(1)		Null,
	 CustomerItemCode	Varchar(18)	Null,
	 Unit			Char(3)		Null,
	 CustomerDivision	VarChar(25)	Null,
	 CustomerPlantAddress	VarChar(25)	Null,
	 CustomerPlantCity	VarChar(20)	Null,
	 CustomerState		Char(2)		Null,
	 CustomerPostal		Char(7)		Null,
	 PlantDock		VarChar(8)	Null,
	 DeliveryLocation	VarChar(8)	Null,
	 RevisionNo		Char(3)		Null,
	 SupplierCity		VarChar(20)	Null,
	 Supplierpostal		Char(7)		Null,
	 CountryOfOrigin	VarChar(10)	Null,
	 SerialNoFrom		SmallInt	Null,
	 LabelCount		SmallInt	Null,
	 LotNo			VarChar(10)	Null,
	 ShipQty		Int		Null,
	 PuchaseNo		VarChar(12)	Null,
	 TraceDate		VarChar(10)	Null,
	 invoiceno		Varchar(20)	Null,
	 customeritemname	VarChar(30)	Null )
	 
insert	into	#tmp_container(CustomerCode,	SupplierCode,	SupplierName,
	Segment1,	Segment2,	Segment3)
select	CustomerCode,	SupplierCode,	SupplierName,
	Segment1,	Segment2,	Segment3	
From	TLabelcustomer
Where   CustomerCode	=	@ps_Customercode

update #tmp_container
set	AreaCode		=	b.areacode,
	DivisionCode		=	b.DivisionCode,
	CustomerItemCode	=	b.Customeritemcode,
	Unit			=	b.Unit,
 	CustomerDivision	=	b.CustomerDivision,
 	CustomerPlantAddress	=	b.CustomerPlantAddress,
 	CustomerPlantCity	=	b.CustomerPlantCity,
 	CustomerState		=	b.CustomerState,
 	CustomerPostal		=	b.CustomerPostal,
 	PlantDock		=	b.PlantDock,
 	DeliveryLocation	=	b.DeliveryLocation,
 	RevisionNo		=	b.RevisionNo,
 	SupplierCity		=	b.SupplierCity,
	Supplierpostal		=	b.SupplierPostal,
	CountryOfOrigin		=	b.CountryOfOrigin
From	#tmp_container a, TLabelItem b
Where	a.customercode		=	b.customercode		And
	b.AreaCode		=	@ps_Areacode		And
	b.DivisionCode		=	@ps_DivisionCode	And
	b.CustomerItemCode	=	@ps_CustomerItemCode

update #tmp_container
set	Customeritemname	=	b.custitemname
From	#tmp_container a, Tmstcustitem b
Where	a.customercode		=	b.custcode		And
	a.CustomerItemCode	=	b.custitemcode
	
update #tmp_container
set	SerialNoFrom	=	b.SerialNoFrom,
	LabelCount	=	b.LabelCount,
	LotNo		=	b.LotNo,
	ShipQty		=	b.ShipQty,
	PuchaseNo	=	b.PuchaseNo,
	TraceDate	=	b.TraceDate,
	INVOICENO	= 	b.Invoiceno
From	#tmp_container a, TLabelContainer b
Where	a.CustomerCode		=	b.Customercode		And
	a.AreaCode		=	b.Areacode		And
	a.DivisionCode		=	b.DivisionCode		And
	a.CustomerItemCode	=	b.CustomerItemCode	And
	b.SerialNoFrom		=	@ps_SerialNoFrom
		
select * from #tmp_container
		
Return

End		-- Procedure End




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

