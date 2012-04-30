/*
	File Name	: sp_piss130u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss130u_02
	Description	: 출고간판reading(상차계획)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_02]
GO


/*
Exec sp_piss130u_02 @ps_shipplandate = '2002.10.31',
                    @ps_areacode     = 'D',
                    @ps_divisioncode = '%',
                    @pi_truckorder   = 1
*/

Create Procedure sp_piss130u_02
	@ps_shipplandate	char(10),	-- 계획일자
	@ps_areacode            char(01),       -- 지역구분
        @ps_divisioncode        char(01),       -- 공장코드 
        @pi_truckorder          int             -- 차량순번
As
Begin
    SELECT Divisioncode = A.Divisioncode,
         TruckOrder     = A.TruckOrder,   
         ItemCode       = A.ItemCode,   
         ItemName       = b.ItemName,
         ItemQty        = sum(A.TruckLoadQty),
	 ItemID	        = b.ModelID,
	 KBNo		= '',
	 ReadingQty	= 0,
	 DansuQty	= 0,
	 CheckFlag	= 0,
         Originalqty    = 0,
         dansuflag      = '',
         total_qty      = 0,
         jan_qty        = 0
    FROM TLOADPLAN A,   
         vMSTmodel b,
         tsrorder  c
   WHERE ( A.ShipPlanDate = @ps_shipplandate ) AND  
         ( A.areacode     = @ps_areacode) AND
         ( A.DivisionCode like @ps_divisioncode ) AND  
         ( A.TruckOrder   = @pi_truckorder ) and
         ( A.ItemCode     *= b.ItemCode ) and  
         ( A.DivisionCode *= b.DivisionCode ) and  
         ( A.areacode     *= b.areacode) and
         ( a.srno         = c.srno) and
         ( c.stcd         = 'Y') and
         ( c.shipremainqty > 0 ) and
         ( c.shipendgubun = 'Z')
Group by A.ShipPlanDate,   
         A.DivisionCode,   
         A.TruckOrder,   
         A.ItemCode,   
         b.ItemName,
	 b.ModelID

End		-- Procedure End


GO
