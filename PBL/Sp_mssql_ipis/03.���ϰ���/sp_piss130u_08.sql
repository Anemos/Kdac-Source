/*
	File Name	: sp_piss130u_08.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss130i_08
	Description	: 출고간판reading(상차품번별total)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_08]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_08]
GO

/*
exec sp_piss130u_08  @ps_shipdate = '2002.12.09',
                     @ps_areacode = 'D',
                     @ps_divisioncode = 'M',
                     @pi_truckorder = 1
                     
*/
CREATE PROCEDURE sp_piss130u_08
	@ps_shipdate	        Char(10),      -- 기준일
        @ps_areacode            char(01),      -- 지역구분
        @ps_divisioncode        char(01),      -- 공장코드
	@pi_truckorder          int            -- 차량순번

AS

BEGIN

Select	DivisionCode    = A.DivisionCode,
	ItemCode	= A.ItemCode,	
        Itemname        = case isnull(e.itemname,'') when '' then a.itemcode else e.itemname end,
        modelid         = d.modelid,
	PlanQty		= sum(A.TruckLoadQty),
        truckloadqty    = sum(A.TruckLoadQty) / isnull(d.RackQty,9999999),
        trucldansuqty   = sum(A.TruckLoadQty)% isnull(d.RackQty,9999999),
        shipqty         = 0,
        loadqty         = 0,
        dansuqty        = 0,
        checkflag       = 0
  From	tloadplan A,
--	tmstkb   B,
        tsrorder C,
        vmstkb_model d,
        tmstitem e
 where	
--A.DivisionCode  *= B.DivisionCode
--   and  A.areacode      *= B.areacode
--   and  a.itemcode      *= B.itemcode
--   and
  A.AreaCode      = @ps_areacode
   and  A.divisioncode  like @ps_divisioncode
   and  A.ApplyFrom     = @ps_shipdate
   and	A.Truckorder 	= @pi_truckorder
   and	A.Truckno       is Null
--   and	C.SRCancelGubun	= 'N'
   and	C.ShipRemainQty	> 0
   and  c.srareacode      = A.areacode
   and  c.srdivisioncode  = A.divisioncode
   and  A.srno          = C.srno
   and  (C.kitgubun     = 'N' or (c.kitgubun = 'Y' and c.pcgubun = 'C'))
   and  c.shipremainqty > 0 
   and  a.areacode      *= d.areacode
   and  a.divisioncode  *= d.divisioncode
   and  a.itemcode      *= d.itemcode
   and  c.stcd          = 'Y'
   and  a.itemcode      *= e.itemcode
   and  c.shipendgubun <> 'Z'
group by a.divisioncode,a.itemcode,e.itemname,d.rackqty,d.modelid


End 

GO
