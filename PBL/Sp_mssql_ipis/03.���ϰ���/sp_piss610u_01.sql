SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*
Execute sp_piss610u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'E13600'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

ALTER  Procedure sp_piss610u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_customercode	varchar(7) ,             -- �ŷ�ó�ڵ�
	@ps_itemcode	varchar(19)

As
Begin
/* �ŷ�óǰ��,�ŷ�óǰ��,kdacǰ��,�����,�������ڵ�,���߷�,
   �����ġ,rev no,�����ڵ�
*/
 
-- vmstkb_line ���� ������ ��
-- ��ȸ������ ��ǰ�� ������.
Select	CustomerItemCode	= CustomerItemCode,
	ItemCode		= ItemCode,
	LotQty          	= LotQty,
	SupplierCode		= SupplierCode,
	Weight			= Weight,
	UseLocation		= UseLocation,
	RevisionNo		= RevisionNo,
	InventoryCode		= InventoryCode
From	tshiplabelheader
Where	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
	CustomerCode	like @ps_CustomerCode And
	CustomerItemcode 	like	 @ps_itemcode
	
Return

End		-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

