/*
Execute sp_piss611U_01
	@Ps_Areacode		= 'D',
	@Ps_Divisioncode	= 'E13600'
	@Ps_Invoiceno		= 'DAV-131'


Dbcc Opentran

*/

ALTER   Procedure sp_piss611U_01
	@Ps_Areacode		Char(1),	-- 지역 코드
	@Ps_Divisioncode	Char(1),	-- 공장 코드
	@Ps_Invoiceno		Varchar(10)	-- Invoice No
	

As
Begin

Select	Customercode		=	Aa.Customercode,
	Customername		=	Ee.Custname,
	Areacode		=	Aa.Areacode,
	Areaname		=	Gg.Areaname,
	Divisioncode		=	Aa.Divisioncode,
	Divisionname		=	Hh.Divisionname,
	Customeritemcode	=	Aa.Customeritemcode,
	Customeritemname	=	Ff.Custitemname,
	Itemcode		=	Aa.Itemcode,
	Invoiceno		=	Aa.Invoiceno,
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
	Puchaseno		=	Dd.Puchaseno,
	Tracedate		=	Dd.Tracedate,
  LabelGubun  = Cc.LabelGubun
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
		A.Invoiceno		=	@Ps_Invoiceno		And
		B.Custcode		Like	'E%') Aa,
	Tlabelcustomer Bb,	Tlabelitem Cc,	Tlabelcontainer Dd,	Tmstcustomer Ee,
	Tmstcustitem Ff,	Tmstarea Gg,	Tmstdivision Hh
Where   Aa.Customercode		*=	Bb.Customercode		And
	Aa.Areacode		*=	Cc.Areacode		And
	Aa.Divisioncode		*=	Cc.Divisioncode		And
	Aa.Customercode		*=	Cc.Customercode		And
	Aa.Customeritemcode	*=	Cc.Customeritemcode	And
	Aa.Areacode		*=	Dd.Areacode		And
	Aa.Divisioncode		*=	Dd.Divisioncode		And
	Aa.Customercode		*=	Dd.Customercode		And
	Aa.Customeritemcode	*=	Dd.Customeritemcode	And
	Aa.Invoiceno		*=	Dd.Invoiceno		And
	Aa.Customercode		=	Ee.Custcode		And
	Aa.Customercode		=	Ff.Custcode		And
	Aa.Customeritemcode	=	Ff.Custitemcode		And
	Aa.Areacode		=	Gg.Areacode		And
	Aa.Areacode		=	Hh.Areacode		And
	Aa.Divisioncode		=	Hh.Divisioncode
	
	
	
Return

End		-- Procedure End


GO
