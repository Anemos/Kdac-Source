/*
	File Name	: sp_piss050i_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss050i_02
	Description	: SR�� ���Ͽ�û��Ȳ(��ü)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss050i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss050i_02]
GO

/*
exec sp_piss050i_02 @ps_applydate = '2002.11.05',
                    @ps_areacode = 'J',
                    @ps_divisioncode = 'S'
               
*/
CREATE PROCEDURE sp_piss050i_02
        @ps_applydate	 Char(10),      -- ������
        @ps_areacode     char(01),      -- ��������
        @ps_divisioncode char(01),      -- �����ڵ�
        @ps_checksrno    varchar(12)    -- SR��ȣ    
	
AS

BEGIN

Select	SRNo	         = A.checksrno,
	MoveRequireNo	 = A.MoveRequireNo,
        AreaCode         = A.AreaCode,
	DivisionCode	 = A.Divisioncode,
	ItemCode	 = A.itemcode,
	ShipOrderQty	 = Sum(IsNull(A.ShipOrderQty,0)),
        ShipRemainQty	 = Sum(isnull(A.ShipRemainQty,0)),
        MoveAreaCode     = A.MoveAreaCode,
	MoveDivisionCode = A.MoveDivisionCode
  Into	#Tmp_MoveOrder
  From	tsrorder A,tmstshipgubun B
 Where	ApplyFrom       <= @ps_applydate
   and  AreaCode        = @ps_areacode
   and  DivisionCode like @ps_divisioncode
   and  a.shipendgubun  = 'N'
--   and	A.srCancelgubun = 'N'
   and  a.stcd = 'Y'
   and  A.ShipGubun     = B.Shipgubun
   and  B.ShipOemgubun  = 'X'
   and  a.pcgubun       = 'P'
   and  a.checksrno     like @ps_checksrno
Group by A.checkSRNo, A.MoveRequireNo,A.AreaCode, A.DivisionCode, A.ItemCode,A.MoveAreaCode, A.MoveDivisionCode
--select * from #Tmp_MoveOrder

Select	SRNo	         = A.SRNo,
	MoveRequireNo	 = A.MoveRequireNo,
        AreaCode         = A.AreaCode,
	DivisionCode	 = A.DivisionCode,
        MoveAreaCode     = A.MoveAreaCode,
	MoveDivisionCode = A.MoveDivisionCode,
        Productgroup     = B.ProductGroup,
        ProductGroupName = B.ProductGroupName,
	ItemCode	 = A.ItemCode,
        ItemName         = isnull(B.ItemName,a.itemcode),
        ModelId          = B.ModelID,
	MoveMinapSum	 = Case When A.ShipRemainQty is Null Then 0 Else A.ShipRemainQty end,
	ShipOrderQty	 = A.ShipOrderQty
  From	#Tmp_MoveOrder A,
         vmstmodel B
 Where	A.AreaCode      = B.AreaCode
   and  A.DivisionCode  = B.DivisionCode
   and  A.Itemcode      = B.ItemCode

Drop Table #Tmp_MoveOrder

end



GO
