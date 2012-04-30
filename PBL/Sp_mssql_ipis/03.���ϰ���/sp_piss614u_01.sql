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

ALTER              Procedure sp_piss614u_01
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
	Customeritemname	=	Cc.Customeritemname,
	PackingListNo		=	Dd.PackingListNo,
	Suppliercode		=	Bb.Suppliercode,
	Suppliername		=	Bb.Suppliername,
	Plantdock		=	Cc.Plantdock,
	Deliverylocation	=	Cc.Deliverylocation,
	Revisionno		=	Cc.Revisionno,
	Suppliercity		=	Cc.Suppliercity,
	Suppliercity1		=	Cc.Suppliercity1,
	Supplierpostal		=	Cc.Supplierpostal,
	Countryoforigin		=	Cc.Countryoforigin,
	Serialnofrom		=	Dd.Serialnofrom,
	Labelcount		=	Dd.Labelcount,
	Lotno			=	Dd.Lotno,
	Shipqty			=	Dd.Shipqty,
	Purchaseno		=	Dd.Puchaseno,
	Tracedate		=	Dd.Tracedate,
	CustomerAddr1  =   	Cc.CustomerPlantAddress,
	CustomerAddr2 	=	Cc.CustomerPlantAddress1,
	Pkgid				=  	Convert(Char(7),Dd.SerialNoFrom),
	Pkglistno			= 	Convert(Char(10),Dd.SerialNoFrom),
	Customerdivision	= Cc.Customerdivision
From	TDRADETAIL Dd,
		TDRACUSTOMER Bb, TDRAITEM Cc,	Tmstcustomer Ee,
		Tmstarea Gg,	Tmstdivision Hh
Where		Gg.Areacode = Hh.Areacode And
			Bb.Customercode = Cc.Customercode And
			Cc.Areacode = Dd.Areacode And
			Cc.Divisioncode = Dd.Divisioncode And
			Cc.Customercode = Dd.Customercode And
			Cc.Customeritemcode = Dd.Customeritemcode And
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

