/*
	File Name	: sp_piss130u_07.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss130i_07
	Description	: 출고간판reading(tsrorder update)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_07]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_07]
GO


/*
exec sp_piss130u_07  @ps_shipdate = '2002.11.02',
                     @ps_areacode = 'D',
                     @ps_divisioncode = 'M',
	             @pi_truckorder = 1
*/
CREATE PROCEDURE sp_piss130u_07
	@ps_shipdate	        Char(10),      -- 기준일
        @ps_areacode            char(01),      -- 지역구분
        @ps_divisioncode        char(01),      -- 공장코드
	@pi_truckorder          int            -- 차량순번

AS

BEGIN

Select	DivisionCode    = A.DivisionCode,
        SRNo	        = A.SRNo,
	CustCode	= A.CustCode,
	ApplyFrom	= A.ApplyFrom,
	ShipEditNo	= A.ShipEditno,
	ItemCode	= A.ItemCode,	
	ShipQty		= A.TruckLoadQty 
  Into	#Tmp_shipQty
  From	tloadplan A
 where	A.AreaCode      = @ps_areacode
   and  a.divisioncode  like @ps_divisioncode
   and  A.ApplyFrom     = @ps_shipdate
   and	A.Truckorder 	= @pi_truckorder
   and	A.Truckno is Null

SELECT	DivisionCode    = A.DivisionCode,
        SRNo            = A.SRNo,
        ShipRemainQty	= A.ShipRemainQty - B.ShipQty,   
        ShipEndGubun	= Case When (A.ShipRemainQty - B.ShipQty) = 0 Then 'Y' Else 'N' end,
        ShipDate	= Case When (A.ShipRemainQty - B.ShipQty) = 0 Then @ps_shipdate Else Null End,
        shipgubun       = a.shipgubun
  FROM	tsrorder A,   
	#Tmp_ShipQty B 
 WHERE 	A.SRNo 	         = B.SRNo
   and  A.srDivisioncode = B.DivisionCode
   and  A.srareacode     = @ps_areacode
   and	A.ShipEditNo	 = B.ShipEditNo
   and	A.ItemCode	 = B.ItemCode
   and a.shipremainqty   > 0
--   and	A.SRCancelGubun	 = 'N'
   and	A.ShipRemainQty	 > 0
   and  a.stcd           = 'Y'
   and  a.shipendgubun <> 'Z'   

Drop Table #Tmp_shipQty

End 

GO
