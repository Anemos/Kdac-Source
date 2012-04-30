/*
	File Name	: sp_piss050i_03.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss050i_03
	Description	: SR별 출하요청현황(이체)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss050i_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss050i_03]
GO

/*
exec sp_piss050i_03 @ps_applydate = '1998.08.11',
                    @ps_areacode = '1',
                    @ps_divisioncode = '1'
               
*/
CREATE PROCEDURE sp_piss050i_03
        @ps_applydate	 Char(10),       -- 기준일
        @ps_areacode     char(01),      -- 지역구분
        @ps_divisioncode char(01),      -- 공장코드
        @ps_checksrno    varchar(12)    -- Sr번호
	
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
 Where	ApplyFrom       = @ps_applydate
   and  SRAreaCode        = @ps_areacode
   and  SRDivisionCode like @ps_divisioncode
--   and	A.srCancelgubun = 'N'
   and  A.shipendgubun = 'N'
   and  A.ShipGubun     = B.Shipgubun
   and  B.ShipOemgubun  = 'X'
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
        ItemName         = B.ItemName,
        ModelId          = B.ModelID,
	MoveMinapSum	 = Case When A.ShipRemainQty is Null Then 0 Else A.ShipRemainQty end,
	ShipOrderQty	 = A.ShipOrderQty
  From	#Tmp_MoveOrder A,
        vmstkb_model B
 Where	A.AreaCode      = B.AreaCode
   and  A.DivisionCode  = B.DivisionCode
   and  A.Itemcode      = B.ItemCode

Drop Table #Tmp_MoveOrder

end



GO
