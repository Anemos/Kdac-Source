/*
Execute sp_piss612U_02
	@Ps_Areacode		= 'D',
	@Ps_Divisioncode	= 'A'
	@Ps_customerCode	= 'E13600'


Dbcc Opentran

*/

ALTER  Procedure sp_piss612U_02
	@Ps_Areacode		Char(1),	-- 지역 코드
	@Ps_Divisioncode	Char(1),	-- 공장 코드
	@Ps_Customercode	Varchar(6)	-- 거래처 코드
	

As
Begin

Select	Customercode		=	a.Customercode,
	Areacode		=	a.Areacode,
	Divisioncode		=	a.Divisioncode,
	Customeritemcode	=	a.Customeritemcode,
	Customeritemname	=	b.Custitemname,
	Itemcode		=	b.Itemcode,
	MasterInvoiceno		=	a.Invoiceno,
	serialnofrom		=	a.Serialnofrom,
	Labelcount		=	a.Labelcount,
	Shipqty			=	a.Shipqty,
	Tracedate		=	a.Tracedate,
	LabelGubun  = c.LabelGubun
From	Tlabelmaster a inner join Tmstcustitem b
  on a.Customercode		=	b.custcode	And a.Customeritemcode	=	b.custitemcode
  inner join Tlabelitem c
  on a.Areacode = c.Areacode and a.Divisioncode = c.Divisioncode and
    a.Customercode = c.Customercode and a.CustomerItemcode = c.CustomerItemcode
Where   a.Customercode		=	b.custcode		And
	a.Customeritemcode	=	b.custitemcode		And
	a.Customercode		=	@ps_customercode	And
	a.Areacode		=	@ps_areacode		And
	a.Divisioncode		=	@ps_divisioncode
	
	
	
Return

End		-- Procedure End

GO
