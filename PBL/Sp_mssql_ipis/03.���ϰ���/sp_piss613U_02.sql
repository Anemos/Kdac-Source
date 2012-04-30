
/*
Execute sp_piss613U_02
	@Ps_Areacode		= 'D',
	@Ps_Divisioncode	= 'A'
	@Ps_customerCode	= 'E13600'


Dbcc Opentran

*/

ALTER   Procedure sp_piss613U_02
	@Ps_Areacode		Char(1),	-- 지역 코드
	@Ps_Divisioncode	Char(1),	-- 공장 코드
	@Ps_Customercode	Varchar(6)	-- 거래처 코드
	

As
Begin

Select	Customercode		=	a.Customercode,
	Areacode		=	a.Areacode,
	Divisioncode		=	a.Divisioncode,
	Customeritemcode    = isnull(b.customeritemcode,''),
	MixedInvoiceno		=	a.Invoiceno,
	serialnofrom		=	a.Serialnofrom,
	Labelcount		=	a.Labelcount,
	Tracedate		=	a.Tracedate,
	LabelGubun  =  isnull(c.labelgubun,'G')
From	Tlabelmixed a left outer join TlabelContainer b
  on a.areacode = b.areacode and a.divisioncode = b.divisioncode and
    a.customercode = b.customercode and b.labelgroupgubun = 'X'
  inner join Tlabelitem c
  on b.Areacode = c.Areacode and b.Divisioncode = c.Divisioncode and
    b.Customercode = c.Customercode and b.CustomerItemcode = c.CustomerItemcode
Where   a.Customercode		=	@ps_customercode	And
	a.Areacode		=	@ps_areacode		And
	a.Divisioncode		=	@ps_divisioncode

Return

End		-- Procedure End

