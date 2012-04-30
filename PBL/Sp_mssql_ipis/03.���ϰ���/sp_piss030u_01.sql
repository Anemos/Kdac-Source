/*
	File Name	: sp_piss030u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss030u_01
	Description	: 이체확정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss030u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss030u_01]
GO

/*
Exec sp_piss030u_01 @ps_shipdate        = '2002.12.18',
                    @ps_shipdate1       = '2002.12.18',
		    @ps_areacode        = 'D',
		    @ps_divisioncode    = 'H'
*/

CREATE PROCEDURE sp_piss030u_01
	@ps_shipdate	        char(10),       --출하일
	@ps_shipdate1           char(10),       --출하일
        @ps_areacode            char(01),       --의뢰지역
        @ps_divisioncode        char(01)        --의뢰공장

AS

BEGIN
    select areacode,divisioncode,itemcode,productgroup,productgroupname,modelid
      into #tmp_vmstmodel
      from vmstmodel
     where areacode = @ps_areacode
       and divisioncode like @ps_divisioncode

    SELECT MoveRequireNo    = B.MoveRequireNo, 
           FromAreaCode     = B.FromAreaCode,
           FromDivisionCode = B.FromDivisionCode,
           SRNo  	    = B.SRNo,
           ProductGroup     = C.ProductGroup,   
           ProductGroupName = C.ProductGroupName,   
           ItemCode	    = B.ItemCode,   
           ItemName	    = D.ItemName,   
           TruckOrder	    = B.TruckOrder,   
           ModelId	    = C.ModelID,
           ShipOrderQty     = B.ShipOrderQty,
           TotalQty	    = B.TruckLoadQty + B.TruckDansuQty,
           ShipRemainQty    = B.ShipOrderQty - B.TruckLoadQty + B.TruckDansuQty,
           MoveConfirmFlag  = B.MoveConfirmFlag,   
           MoveConfirmDate  = B.MoveConfirmDate,   
           MoveConfirmTime  = B.MoveConfirmTime,
           SrDivisionCode   = B.DivisionCode,
           shipplandate     = b.shipplandate
      FROM TSHIPINV B,
           #tmp_vmstmodel C,
           tmstitem D
     WHERE (B.AreaCode         = @ps_areacode)
       and (B.DivisionCode     like @ps_divisioncode)
       and (B.ShipPlanDate     >= @ps_shipdate)
       and (B.ShipPlanDate     <= @ps_shipdate1)
       and (B.MoveConfirmFlag  = 'N')
--       and (b.moveconfirmdate  is null)
       and (B.sendflag         = 'N')
       and (b.lastemp          = 'Y')
       and (B.AreaCode         *= C.AreaCode)
       and (B.DivisionCode     *= C.DivisionCode)
       and (B.ItemCode         *= C.ItemCode)
       and (B.itemcode         *= D.itemcode)
drop table #tmp_vmstmodel
END 

GO
