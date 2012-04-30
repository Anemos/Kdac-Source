/*
  File Name : sp_piss610u_02.SQL
  SYSTEM    : KDAC ���� ���� ���� �ý���
  Procedure Name  : sp_piss610u_02
  Description : Shipping label gubun
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS
  Initial   : 2006.07
  Author    : Kisskim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_piss610u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_piss610u_02]
GO

/*
Execute sp_piss610u_02
	@ps_Areacode		= 'D',
	@ps_Divisioncode	= 'A',
	@ps_customercode	= '%',
	@ps_itemcode	= '%',
	@ps_prtdate	= '%',
	@ps_labeltype = 'A'
*/

Create    Procedure sp_piss610u_02
	@ps_areacode		char(1),		    -- ���� �ڵ�
	@ps_divisioncode	char(1),		  -- ���� �ڵ�
	@ps_customercode	varchar(7),   -- �ŷ�ó�ڵ�
	@ps_itemcode	varchar(19),
	@ps_prtdate		varchar(10),
	@ps_labeltype char(1)

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
	InventoryCode		= B.InventoryCode,
	LabelType   = A.LabelType
From	tshiplabeldetail A, Tshiplabelheader B
Where   A.AreaCode    	   = B.AreaCode		and
	A.DivisionCode     = B.DivisionCode	and
	A.CustomerCode     = B.CustomerCode	and
	A.Customeritemcode = B.CustomerItemcode	and
	A.lotqty	   = B.Lotqty		and
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode		And
	A.LabelType = @ps_labeltype And
	A.CustomerCode	like @ps_CustomerCode	And
	A.CustomerItemcode	like @ps_itemcode And
	A.PrintDate 	like 	@ps_prtdate
	   
Return

End		-- Procedure End


GO
