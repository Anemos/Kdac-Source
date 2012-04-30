/*
	File Name	: sp_piss120i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss120u_01
	Description	: 상차보기
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss120i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss120i_01]
GO

/*
exec sp_piss120i_01 @ps_areacode         = 'J',          -- 지역구분        
                    @ps_divisioncode	 = '%',          -- 공장코드  
                    @ps_fromtruckorder   = 1,            -- from truckorder
                    @ps_endtruckorder    = 99,          -- to truckorder
                    @ps_applydate        ='2002.12.09'  -- 기준일
*/

Create Procedure sp_piss120i_01 @ps_areacode            char(01),
        @ps_divisioncode        char(01),
        @ps_fromtruckorder      int,
        @ps_endtruckorder       int,
        @ps_applydate           char(10)

As
Begin
/*
Select	AreaCode        = A.AreaCode,
        DivisionCode    = A.Divisioncode,
        ItemCode	= A.ItemCode,
        ItemName        = B.Itemname,
        ModelId         = B.ModelId,
	RackQty		= A.RackQty
  Into	#Tmp_RackQty
  From	tmstkb A,vmstkb_model B
 where  A.AreaCode      = @ps_areacode
   and  A.DivisionCode  like @ps_divisioncode
   and  A.AreaCode      = B.AreaCode
   and  A.DivisionCode  = B.DivisionCode
   and  A.ItemCode      = B.ItemCode
Group by A.AreaCode,A.DivisionCode,A.RackQty,B.ItemName,B.ModelId,A.itemcode
*/
Select	Distinct AreaCode        = A.AreaCode,
        DivisionCode    = A.DivisionCode,
	ItemCode	= A.ItemCode,
        ItemName        = a.ItemName,
        modelid         = A.ModelId,
	RackQty		= isnull(b.RackQty,9999999)
  Into	#Tmp_RackQty
  From	vmstmodel a,tmstkb b
 Where	a.AreaCode      = @ps_areacode
   and  a.DivisionCode  like @ps_divisioncode
   and  a.areacode      *= b.areacode
   and  a.divisioncode  *= b.divisioncode
   and  a.ItemCode      *= b.ItemCode

Select 	truckorder      = A.Truckorder,
	TruckNo		= A.Truckno,
        ShipYard        = D.ShipYard,
	ShipPlanDate	= C.applyfrom,
        ShipEditNo	= A.ShipEditNo,
        ItemCode        = a.ItemCode,
        ItemName        = case isnull(e.ItemName,'') when '' then a.itemcode else e.itemname end,
        Modelid         = B.ModelId,
        ShipOrderQty    = sum(C.ShipOrderQty),
        ShipQty		= Sum(A.TruckLoadQty),
	TruckLoadQty	= IsNull(A.TruckLoadQty, 0) / isnull(B.RackQty,9999999),
        TruckDansuQty   = IsNull(A.TruckLoadQty, 0)% isnull(B.RackQty,9999999),
        orderno         = c.orderno
  From	tloadplan A,
	#Tmp_RackQty B,
	tsrorder C,
        tsrheader D,
        tmstitem e
 WHERE	A.ItemCode	*= B.ItemCode
   and  A.AreaCode      *= B.areacode
   and  A.divisioncode  *= B.divisioncode
   and	A.SRNo	        = C.SRNo
   and  A.areacode      = C.areacode
   and  A.divisioncode  = C.divisioncode
   and	A.Truckorder	>= @ps_fromtruckorder
   and	A.Truckorder	<= @ps_endtruckorder
   and  a.areacode      = @ps_areacode
   and  a.divisioncode  like @ps_divisioncode
   and	A.ApplyFrom	= @ps_applydate
   and  C.checksrno      *= D.checksrno
   and  (c.kitgubun = 'N' or (c.kitgubun = 'Y' and c.pcgubun = 'C'))
   and  a.itemcode       *= e.itemcode
--   and  c.shipgubun <> 'M'
group by A.Truckorder,A.Truckno,D.ShipYard,A.ShipPlandate,A.shipEditNo,B.itemcode,B.itemName,B.modelid,B.RackQty,A.truckDansuQty,A.truckLoadQty,e.itemname,a.itemcode,c.orderno,c.applyfrom
/*ioall
Select 	truckorder      = A.Truckorder,
	TruckNo		= A.Truckno,
        ShipYard        = D.ShipYard,
	ShipPlanDate	= A.ShipPlanDate,
        ShipEditNo	= A.ShipEditNo,
        ItemCode        = B.ItemCode,
        ItemName        = B.ItemName,
        Modelid         = B.ModelId,
        ShipOrderQty    = sum(C.ShipOrderQty),
        ShipQty		= Sum(A.TruckLoadQty),
	TruckLoadQty	= IsNull(A.TruckLoadQty, 0) / isnull(B.RackQty,9999999),
        TruckDansuQty   = IsNull(A.TruckLoadQty, 0)% isnull(B.RackQty,9999999)
  From	tloadplan A,
	#Tmp_RackQty B,
	tsrorder C,
        tsrheader D
 WHERE	A.ItemCode	*= B.ItemCode
   and  A.AreaCode      *= B.areacode
   and  A.divisioncode  *= B.divisioncode
   and	A.SRNo	        = C.SRNo
   and  A.areacode      = C.moveareacode
   and  A.divisioncode  = C.movedivisioncode
   and	A.Truckorder	>= @ps_fromtruckorder
   and	A.Truckorder	<= @ps_endtruckorder
   and	A.ApplyFrom	= @ps_applydate
   and  C.SRDivisionCode = D.SRDivisionCode
   and  C.SRAreaCode     = D.SRAreaCode
   and  C.ShipGubun      = D.ShipGubun
   and  C.SRYear         = D.SrYear
   and  C.SRMonth        = D.SRMonth
   and  C.SRSerial       = D.SRSerial
   and  C.SRSplitCount   = D.SRSplitCount
   and  (c.kitgubun = 'N' or (c.kitgubun = 'Y' and c.pcgubun = 'C'))
   and  c.shipgubun = 'M'
group by A.Truckorder,A.Truckno,D.ShipYard,A.ShipPlandate,A.shipEditNo,B.itemcode,B.itemName,B.modelid,B.RackQty,A.truckDansuQty,A.truckLoadQty
*/
drop table #Tmp_RackQty
end


GO
