/*
	File Name	: sp_piss191i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss191i_02
	Description	: 입고/출하/재고현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss191i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss191i_02]
GO
/*
Exec sp_piss191i_02
        @ps_areacode     = 'D',
	@ps_divisioncode = 'A',
	@ps_applyfrom	 = '2003.02.01',
	@ps_applyto	 = '2003.02.13',
        @ps_productgroup = '%',
        @ps_itemtype      = '%',
        @ps_itemcode      = '16823809'

*/

Create Procedure sp_piss191i_02
        @ps_areacode     char(01),      -- 지역 구분
	@ps_divisioncode Char(01),	-- 공장 구분
	@ps_applyfrom	 char(10),	-- 기준 일 
	@ps_applyto	 char(10),	-- 기준 일 
	@ps_productgroup varchar(05),	-- productgroup
	@ps_itemtype 	 char(01),	-- item type
	@ps_itemcode 	 varchar(12)	-- itemcode
As
Begin

select a.itemcode     as itemcode,
       a.divisioncode as divisioncode,
       a.productgroup as productgroup,
       B.productgroupname as productgroupname,       
       case a.itemclass 
            when '10' then case a.itembuysource 
                                when '03' then '4'
                                else '2'  
                           end
            when '30' then '5'
            when '35' then '3'
            when '40' then '2'
            when '50' then '2'
            else '6' 
       end as itemtype,
       a.averageunitcost as averageunitcost
  into #tmp_itemtype
  from tmstmodel a,tmstproductgroup  b
 where a.areacode = @ps_areacode
   and a.divisioncode like @ps_divisioncode
   and a.itemcode  like @ps_itemcode
   and a.areacode = b.areacode
   and a.divisioncode = b.divisioncode
   and a.productgroup = b.productgroup

select a.itemcode     as itemcode,
       a.divisioncode as divisioncode,
       a.modelid      as modelid,
       a.sortorder    as sortorder
  into #tmp_vmstmodel
  from vmstmodel a
 where a.areacode = @ps_areacode
   and a.divisioncode like @ps_divisioncode
   and a.itemcode  like @ps_itemcode


Select  productgroupname    = C.ProductGroupName,
        ItemCode            = B.ItemCode,
        ItemName            = D.ItemName,
        Modelid             = A.Modelid,
        SortOrder           = A.SortOrder,
        AverageUnitCost     = C.AverageUnitCost,
	DayPlanQty          =  sum(isnull(B.DayPlanQty,0)),
	DayPlanAmt          = (sum(isnull(B.DayPlanqty,0)) * c.AverageUnitCost),
	MonthPlanQty        =  sum(isnull(B.MonthPlanQty,0)),
	MonthPlanAmt        = (sum(isnull(B.MonthPlanqty,0)) * c.AverageUnitCost),
	dayprdqty           =  sum(isnull(B.dayprdqty,0)),
	dayprdamt           = (sum(isnull(B.dayprdqty,0)) * C.AverageUnitCost),
	monthprdqty         =  sum(isnull(B.monthprdqty,0)),
	monthprdamt         = (sum(isnull(B.monthprdqty,0)) * C.AverageUnitCost),
	dayinqty            =  sum(isnull(B.dayinqty,0)),
	dayinamt            = (sum(isnull(B.dayinqty,0)) * C.AverageUnitCost),
	monthinqty          =  sum(isnull(B.monthinqty,0)),
	monthinamt          = (sum(isnull(B.monthinqty,0)) * C.AverageUnitCost),
	dayshipqty          =  sum(isnull(B.dayshipqty,0)),
	dayshipamt          = (sum(isnull(B.dayshipqty,0)) * C.AverageUnitCost),
	monthshipqty        =  sum(isnull(B.monthshipqty,0)),
	monthshipamt        = (sum(isnull(B.monthshipqty,0)) * C.AverageUnitCost),
	yesterdayinv	    =  sum(isnull(B.yesterdayinv,0)),
	yesterdayinvamt     = (sum(isnull(B.yesterdayinv,0)) * C.AverageUnitCost),
	todayinv	    =  sum(isnull(B.todayinv,0)),
        todayinvamt         = (sum(isnull(B.todayinv,0)) * C.AverageUnitCost)
from #tmp_vmstmodel a,
(
--생산계획
Select	ItemCode	= A.ItemCode,
        areacode        = a.areacode,
        divisioncode    = a.divisioncode,
	DayPlanQty	= Sum(case when a.plandate = @ps_applyto then (isnull(A.ReleaseKbQty, 0))
				else 0
				end),
	monthplanqty	= sum(isnull(A.releaseKBQty, 0)),
	dayprdqty       = 0,
	monthprdqty     = 0,
        dayinqty        = 0,
        monthinqty      = 0,
        dayshipqty      = 0,
        monthshipqty    = 0,
        yesterdayinv    = 0,
        todayinv        = 0
  From	tplanrelease A
 Where	A.AreaCode      = @ps_areacode
   and  A.Divisioncode	like @ps_divisioncode
   and	A.PlanDate	>= @ps_applyfrom
   and  A.Plandate      <= @ps_applyto 
--   and  A.Releasegubun  in ('Y','T')
   and  a.ReleaseKbQty > 0
   and  a.itemcode like @ps_itemcode
Group By A.ItemCode,a.divisioncode,a.areacode
union all
-- 생산실적
Select	Itemcode	= A.itemcode,
        areacode        = a.areacode,
        divisioncode    = a.divisioncode,
        0,0,
	DayPrdqty	= sum(case when a.prddate = @ps_applyto then a.prdqty
                                   else 0
                              end),
	MonthPrdQty	= Sum(IsNull(A.PrdQty, 0)),
        0,0,0,0,0,0
  from  tprdtime a
 where  a.areacode = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.prddate >= @ps_applyfrom
   and  a.prddate <= @ps_applyto
   and  A.PrdQty > 0
   and  a.itemcode like @ps_itemcode
Group by a.ItemCode,a.divisioncode,a.areacode
union all
-- 입고/출하실적
Select	ItemCode	= A.ItemCode,
        areacode        = a.areacode,
        divisioncode    = a.divisioncode,
        0,0,0,0,
	DayprdQty	= sum(Case When A.traceDate = @ps_applyto then IsNull(A.stockQty, 0) else 0 end),
	MonthprdQty	= Sum(IsNull(A.stockQty, 0)),
	DayShipQty	= sum(Case When A.traceDate = @ps_applyto then IsNull(A.ShipQty, 0) else 0 end),
	MonthShipQty	= Sum(IsNull(A.ShipQty, 0)),
        Yesterdayinv = 0,
        Ttodayinv = 0
  From	tlotno A
 where  a.areacode = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.tracedate >= @ps_applyfrom
   and  a.tracedate <= @ps_applyto
   and  (a.shipqty <> 0 or a.stockqty <> 0)
   and  a.itemcode like @ps_itemcode
Group by ItemCode,a.divisioncode,a.areacode
union all
select itemcode     = a.itemcode,
       areacode     = a.areacode,
       divisioncode = a.divisioncode,
       0,0,0,0,0,0,0,0,
       yesterdayinv = 0,
       todayinv = sum(a.todayinv + a.tlotno_qty)
from 
(Select	ItemCode     = A.ItemCode,
        areacode     = a.areacode,
        divisioncode = a.divisioncode,
	todayinv     = A.invqty + a.repairqty,
        0 tlotno_qty
 From	tinv A
 Where	A.areacode = @ps_areacode
   and  A.divisioncode like @ps_divisioncode
   and  A.invqty + a.repairqty <> 0
   and  a.itemcode like @ps_itemcode
union all
Select	ItemCode     = A.ItemCode,
        areacode     = a.areacode,
        divisioncode = a.divisioncode,
	todayinv     = 0,
        tlotno_qty  = sum(shipqty - stockqty)
 From	tlotno A
 Where	A.areacode = @ps_areacode
   and  A.divisioncode like @ps_divisioncode
   and  A.tracedate > @ps_applyto
   and  a.itemcode like @ps_itemcode
 group by a.itemcode,a.divisioncode,a.areacode) a
group by a.itemcode,a.divisioncode,a.areacode
having sum(a.todayinv + a.tlotno_qty) <> 0
) b,#tmp_itemtype c,tmstitem d
where b.itemcode      *= a.itemcode
  and b.divisioncode  *= a.divisioncode
  and b.itemcode      = c.itemcode
  and b.divisioncode  = c.divisioncode
  and b.itemcode      = d.itemcode
  and c.productgroup  like @ps_productgroup
  and c.itemtype      like @ps_itemtype
  and c.itemcode      like @ps_itemcode
group by c.ProductGroupName,
         b.ItemCode,
         d.ItemName,
         A.Modelid,
         A.SortOrder,
         C.AverageUnitCost
ORDER BY c.ProductGroupName,
         b.ItemCode
drop table #tmp_itemtype
drop table #tmp_vmstmodel

End

GO
