SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






/*
Execute sp_piss614u_01
	@Ps_Areacode		= 'D',
	@Ps_Divisioncode	= 'A',
	@Ps_Customercode	= '%',
	@Ps_Itemcode	= '%',
	@Ps_Tracedate = '%'


Dbcc Opentran

*/

ALTER             Procedure sp_piss614u_01
	@Ps_Areacode			Char(1),	-- 지역 코드
	@Ps_Divisioncode		Char(1),	-- 공장 코드
	@Ps_Customercode	Varchar(7),	-- 거래처코드
	@Ps_Itemcode			Varchar(19),
	@Ps_Tracedate			Varchar(11)

As
Begin

Select	Customercode		=	Dd.Customercode,
	Customername		=	Ee.Custname,
	Areacode		=	Dd.Areacode,
	Areaname		=	Gg.Areaname,
	Divisioncode		=	Dd.Divisioncode,
	Divisionname		=	Hh.Divisionname,
	Customeritemcode	=	Dd.Customeritemcode,
	Customeritemname	=	Ff.Custitemname,
	Itemcode		=	isnull(Aa.Itemcode, Cc.itemcode),
	Invoiceno		=	isnull(Aa.Invoiceno, Dd.invoiceno),
	Srno			=	Aa.Srno,
	Shiporderqty		=	Aa.Shiporderqty,
	Suppliercode		=	Bb.Suppliercode,
	Suppliername		=	Bb.Suppliername,
	Segment1		=	Bb.Segment1,
	Segment2		=	Bb.Segment2,
	Segment3		=	Bb.Segment3,
	Unit			=	Cc.Unit,
	Plantdock		=	Cc.Plantdock,
	Deliverylocation	=	Cc.Deliverylocation,
	Revisionno		=	Cc.Revisionno,
	Suppliercity		=	Cc.Suppliercity,
	Supplierpostal		=	Cc.Supplierpostal,
	Countryoforigin		=	Cc.Countryoforigin,
	Serialnofrom		=	Dd.Serialnofrom,
	Labelcount		=	Dd.Labelcount,
	Lotno			=	Dd.Lotno,
	Shipqty			=	Dd.Shipqty,
	Purchaseno		=	Dd.Puchaseno,
	Tracedate		=	Dd.Tracedate,
	CustomerAddr1  =   	Cc.CustomerPlantAddress,
	CustomerAddr2 	=	( Cc.CustomerPlantCity + ', ' 
				+ Cc.CustomerState + ' ' + Cc.CustomerPostal ),
	Pkgid				=  	Convert(Char(7),Dd.SerialNoFrom),
	Pkglistno			= 	Convert(Char(10),Dd.SerialNoFrom),
	Customerdivision	= Cc.Customerdivision
From	(Select	Customercode		=	B.Custcode,
				Areacode		=	B.Areacode,
				Divisioncode		=	B.Divisioncode,
				Customeritemcode	=	B.Customeritemno,
				Itemcode		=	B.Itemcode,
				Invoiceno		=	A.Invoiceno,
				Srno			=	A.Checksrno,
				Shiporderqty		=	B.Shiporderqty	
			From	Tsrheader A, Tsrorder B
			Where   A.Checksrno		=	B.Checksrno		And
							B.Areacode		=	@Ps_Areacode		And
							B.Divisioncode		=	@Ps_Divisioncode	And
							B.Custcode		Like	@Ps_Customercode And
							B.Itemcode 	Like @Ps_Itemcode ) Aa 
			RIGHT OUTER JOIN Tlabelcontainer Dd 
			ON	Aa.Areacode		=	Dd.Areacode		And
					Aa.Divisioncode		=	Dd.Divisioncode		And
					Aa.Customercode		=	Dd.Customercode And
				Aa.Customeritemcode	= Dd.Customeritemcode And
				Aa.Invoiceno		= Dd.Invoiceno,
		Tlabelcustomer Bb, Tlabelitem Cc,	Tmstcustomer Ee,
		Tmstcustitem Ff,	Tmstarea Gg,	Tmstdivision Hh
Where		Gg.Areacode = Hh.Areacode And
			Bb.Customercode = Cc.Customercode And
			Cc.Areacode = Dd.Areacode And
			Cc.Divisioncode = Dd.Divisioncode And
			Cc.Customercode = Dd.Customercode And
			Cc.Customeritemcode = Dd.Customeritemcode And
			Dd.Customercode = Ff.Custcode And
			Dd.Customeritemcode = Ff.Custitemcode And
			Dd.Customercode = Ee.Custcode And
			Dd.Areacode = Hh.Areacode And
			Dd.Divisioncode = Hh.Divisioncode And
			Dd.Customeritemcode LIKE @Ps_Itemcode And
			Dd.Tracedate LIKE @Ps_Tracedate
	
Return

End		-- Procedure End












GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

