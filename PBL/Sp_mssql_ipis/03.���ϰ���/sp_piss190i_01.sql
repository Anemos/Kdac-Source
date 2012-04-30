/*
	File Name	: sp_piss190i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss190i_01
	Description	: 생산/출하/재고현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss190i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss190i_01]
GO
/*
Exec sp_piss190i_01
        @ps_areacode     = 'D',
	@ps_divisioncode = 'S',
	@ps_applyfrom	 = '2002.12.26',
	@ps_applyto	 = '2002.12.26',
        @ps_productgroup = '%',
        @ps_itemtype      = '%',
        @ps_itemcode      = '510403A'

*/

Create Procedure sp_piss190i_01
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
                                when '01' then '2'
                                when '02' then '2'
                                when '03' then '3'
                                when '04' then '2'
                                else '1'  
                           end
            when '30' then '5'
            when '35' then '4'
            when '40' then '2'
            when '50' then '2'
            else '6' 
       end as itemtype
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
        SrotOrder           = A.SortOrder,
        PlanQty             = sum(isnull(B.PlanQty,0)),
	dayprdqty           = sum(isnull(B.dayprdqty,0)),
	monthprdqty         = sum(isnull(B.monthprdqty,0)),
	dayshipqty          = sum(isnull(B.dayshipqty,0)),
	monthshipqty        = sum(isnull(B.monthshipqty,0)),
	yesterdayinv	    = sum(isnull(B.yesterdayinv,0)),
	todayinv	    = sum(isnull(B.todayinv,0))
from #tmp_vmstmodel a,
(
--생산계획
Select	ItemCode	= A.ItemCode,
        areacode        = a.areacode,
        divisioncode    = a.divisioncode,
	PlanQty		= Sum(IsNull(A.ReleaseKbQty, 0)),
        dayprdqty       = 0,
        monthprdqty     = 0,
        dayshipqty      = 0,
        monthshipqty    = 0,
        yesterdayinv    = 0,
        todayinv        = 0
  From	tplanrelease A
 Where	A.AreaCode      = @ps_areacode
   and  A.Divisioncode	like @ps_divisioncode
   and	A.PlanDate	= @ps_applyto
--   and  A.Releasegubun  in ('Y','T')
   and  a.ReleaseKbQty > 0
   and  a.itemcode like @ps_itemcode
Group By A.ItemCode,a.divisioncode,a.areacode
union all
-- 생산실적
Select	Itemcode	= A.itemcode,
        areacode        = a.areacode,
        divisioncode    = a.divisioncode,
        0,
	DayPrdqty	= sum(case when a.prddate = @ps_applyto then a.prdqty
                                   else 0
                              end),
	MonthPrdQty	= Sum(IsNull(A.PrdQty, 0)),
        0,0,0,0
  from  tprdtime a
 where  a.areacode = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.prddate >= @ps_applyfrom
   and  a.prddate <= @ps_applyto
   and  A.PrdQty > 0
   and  a.itemcode like @ps_itemcode
Group by a.ItemCode,a.divisioncode,a.areacode
union all
-- 출하실적
Select	ItemCode	= A.ItemCode,
        areacode        = a.areacode,
        divisioncode    = a.divisioncode,
        0,0,0,
	DayShipQty	= sum(Case When A.traceDate = @ps_applyto then IsNull(A.ShipQty, 0) else 0 end),
	MonthShipQty	= Sum(IsNull(A.ShipQty, 0)),
        0,0
  From	tlotno A
 where  a.areacode = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.tracedate >= @ps_applyfrom
   and  a.tracedate <= @ps_applyto
   and  a.shipqty <> 0
   and  a.itemcode like @ps_itemcode
Group by ItemCode,a.divisioncode,a.areacode
union all
select itemcode     = a.itemcode,
       areacode     = a.areacode,
       divisioncode = a.divisioncode,
       0,0,0,0,0,
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
--  and b.areacode      *= a.areacode
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
         A.SortOrder
ORDER BY c.ProductGroupName,
         b.ItemCode
drop table #tmp_itemtype
drop table #tmp_vmstmodel

End

GO
