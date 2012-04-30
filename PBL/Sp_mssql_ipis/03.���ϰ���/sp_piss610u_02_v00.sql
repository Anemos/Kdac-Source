SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*
Execute sp_piss610u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '511513'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

ALTER  Procedure sp_piss610u_02
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_customercode	varchar(7),             -- �ŷ�ó�ڵ�
	@ps_itemcode	varchar(19)

As
Begin
/* �ŷ�óǰ��,�ŷ�óǰ��,kdacǰ��,�����,���ֹ�ȣ,
   ���߷�,������,����,������,Batch No, Serial
*/
       
-- vmstkb_line ���� ������ ��
-- ��ȸ������ ��ǰ�� ������.
Select	Areacode		= A.Areacode,
	DivisionCode		= A.divisioncode,
	CustomerCode		= A.CustomerCode,
	CustomerItemCode	= A.CustomerItemCode,
	ItemCode		= B.ItemCode,
	LotQty          	= A.LotQty,
	PuchaseNo		= A.PuchaseNo,
	WeightDetail		= A.Weight,
	Vessel			= A.Vessel,
	RackCount		= A.RackCount,
	PrintDate		= A.PrintDate,
	TraceNo			= A.TraceNo,
	SerialNoFrom		= A.SerialNoFrom,
	LabelCount		= A.LabelCount,
	SupplierCode		= B.SupplierCode,
	WeightHeader		= B.Weight,
	UseLocation		= B.Uselocation,
	RevisionNo		= B.RevisionNo,
	InventoryCode		= B.InventoryCode
	From	tshiplabeldetail A, Tshiplabelheader B
Where   A.AreaCode    	   = B.AreaCode		and
	A.DivisionCode     = B.DivisionCode	and
	A.CustomerCode     = B.CustomerCode	and
	A.Customeritemcode = B.CustomerItemcode	and
	A.lotqty	   = B.Lotqty		and
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode		And
	A.CustomerCode	like @ps_CustomerCode	And
	A.CustomerItemcode	like @ps_itemcode
	   
Return

End		-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

