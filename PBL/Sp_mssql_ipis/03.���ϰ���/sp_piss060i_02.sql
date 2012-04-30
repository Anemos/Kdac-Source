/*
	File Name	: sp_piss060i_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss060i_02
	Description	: SR�� ���Ͽ�û��Ȳ(��ü)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss060i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss060i_02]
GO

/*
exec sp_piss060i_02 @ps_applydate = '2002.12.11',
                    @ps_areacode = 'D',
                    @ps_divisioncode = 'S'
               
*/
CREATE PROCEDURE sp_piss060i_02
        @ps_applydate	 Char(10),     -- ������
        @ps_areacode     char(01),     -- ��������
        @ps_divisioncode char(01)      -- �����ڵ�
	
AS

BEGIN

Select	MoveRequireNo	 = A.MoveRequireNo,
        AreaCode         = A.AreaCode,
	DivisionCode	 = A.Divisioncode,
	ItemCode	 = A.itemcode,
	ShipOrderQty	 = Sum(IsNull(A.ShipOrderQty,0)),
        ShipRemainQty	 = Sum(isnull(A.ShipRemainQty,0)),
        MoveAreaCode     = A.MoveAreaCode,
	MoveDivisionCode = A.MoveDivisionCode
  Into	#Tmp_MoveOrder
  From	tsrorder A,tmstshipgubun B
 Where	ApplyFrom      <= @ps_applydate
   and  SRAreaCode     = @ps_areacode
   and  SRDivisionCode like @ps_divisioncode
--   and	A.srCancelgubun = 'N'
   and  A.shipendgubun  = 'N'
   and  A.ShipGubun     = B.Shipgubun
   and  B.ShipOemgubun  = 'X'
   and  a.pcgubun       = 'P'
   and  a.stcd          = 'Y'
Group by A.MoveRequireNo,A.AreaCode, A.DivisionCode, A.ItemCode,A.MoveAreaCode, A.MoveDivisionCode
--select * from #Tmp_MoveOrder

Select	MoveRequireNo	 = A.MoveRequireNo,
        AreaCode         = A.AreaCode,
	DivisionCode	 = A.DivisionCode,
        MoveAreaCode     = A.MoveAreaCode,
	MoveDivisionCode = A.MoveDivisionCode,
        Productgroup     = E.ProductGroup,
        ProductGroupName = E.ProductGroupName,
	ItemCode	 = A.ItemCode,
        ItemName         = isnull(E.ItemName,a.itemcode),
        ModelId          = E.ModelID,
	MoveMinapSum	 = Case When A.ShipRemainQty is Null Then 0 Else A.ShipRemainQty end,
	ShipOrderQty	 = A.ShipOrderQty
  From	#Tmp_MoveOrder A,
        vmstmodel E
 Where	A.AreaCode      = E.AreaCode
   and  A.DivisionCode  = E.DivisionCode
   and  A.ItemCode      = E.ItemCode


Drop Table #Tmp_MoveOrder

end



GO
