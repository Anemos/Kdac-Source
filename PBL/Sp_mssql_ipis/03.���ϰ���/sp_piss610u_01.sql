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
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_customercode	varchar(7) ,             -- 거래처코드
	@ps_itemcode	varchar(19)

As
Begin
/* 거래처품번,거래처품명,kdac품번,수용수,공급자코드,순중량,
   사용위치,rev no,자재코드
*/
 
-- vmstkb_line 에서 시작한 것
-- 조회조건의 제품을 구하자.
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

