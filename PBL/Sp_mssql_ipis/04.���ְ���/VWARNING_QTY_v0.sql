/*
  File Name : VWARNING_QTY.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  View Name  : VWARNING_QTY
  Description : 간판자재 WARNING Table 조회 - 생산계획량, 지시량, KD / AS 소요량
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[VWARNING_QTY]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[VWARNING_QTY]
GO

/* select * from vwarning_qty */

CREATE  View VWARNING_QTY

As

Select AreaCode = tmp.areacode,
  Divisioncode = tmp.divisioncode,
  Itemcode = tmp.itemcode,
  ChangeQtyD00 = Sum(tmp.changeqtyd00),
  ReleaseQtyD00 = sum(tmp.releaseqtyd00),
  PlanQtyD00 = sum(tmp.planqtyd00),
  KdQtyD00 = sum(tmp.kdqtyD00),
  AsQtyD00 = sum(tmp.asqtyd00),
  ChangeQtyD01 = Sum(tmp.changeqtyd01),
  ReleaseQtyD01 = sum(tmp.releaseqtyd01),
  PlanQtyD01 = sum(tmp.planqtyd01),
  KdQtyD01 = sum(tmp.kdqtyD01),
  AsQtyD01 = sum(tmp.asqtyd01),
  ChangeQtyD02 = Sum(tmp.changeqtyd02),
  ReleaseQtyD02 = sum(tmp.releaseqtyd02),
  PlanQtyD02 = sum(tmp.planqtyd02),
  KdQtyD02 = sum(tmp.kdqtyD02),
  AsQtyD02 = sum(tmp.asqtyd02),
  ChangeQtyD03 = Sum(tmp.changeqtyd03),
  ReleaseQtyD03 = sum(tmp.releaseqtyd03),
  PlanQtyD03 = sum(tmp.planqtyd03),
  KdQtyD03 = sum(tmp.kdqtyD03),
  AsQtyD03 = sum(tmp.asqtyd03),
  ChangeQtyD04 = Sum(tmp.changeqtyd04),
  ReleaseQtyD04 = sum(tmp.releaseqtyd04),
  PlanQtyD04 = sum(tmp.planqtyd04),
  KdQtyD04 = sum(tmp.kdqtyD04),
  AsQtyD04 = sum(tmp.asqtyd04),
  ChangeQtyD05 = Sum(tmp.changeqtyd05),
  ReleaseQtyD05 = sum(tmp.releaseqtyd05),
  PlanQtyD05 = sum(tmp.planqtyd05),
  KdQtyD05 = sum(tmp.kdqtyD05),
  AsQtyD05 = sum(tmp.asqtyd05),
  ChangeQtyD06 = Sum(tmp.changeqtyd06),
  ReleaseQtyD06 = sum(tmp.releaseqtyd06),
  PlanQtyD06 = sum(tmp.planqtyd06),
  KdQtyD06 = sum(tmp.kdqtyD06),
  AsQtyD06 = sum(tmp.asqtyd06),
  ChangeQtyD07 = Sum(tmp.changeqtyd07),
  ReleaseQtyD07 = sum(tmp.releaseqtyd07),
  PlanQtyD07 = sum(tmp.planqtyd07),
  KdQtyD07 = sum(tmp.kdqtyD07),
  AsQtyD07 = sum(tmp.asqtyd07),
  ChangeQtyD08 = Sum(tmp.changeqtyd08),
  ReleaseQtyD08 = sum(tmp.releaseqtyd08),
  PlanQtyD08 = sum(tmp.planqtyd08),
  KdQtyD08 = sum(tmp.kdqtyD08),
  AsQtyD08 = sum(tmp.asqtyd08),
  ChangeQtyD09 = Sum(tmp.changeqtyd09),
  ReleaseQtyD09 = sum(tmp.releaseqtyd09),
  PlanQtyD09 = sum(tmp.planqtyd09),
  KdQtyD09 = sum(tmp.kdqtyD09),
  AsQtyD09 = sum(tmp.asqtyd09),
  ChangeQtyD10 = Sum(tmp.changeqtyd10),
  ReleaseQtyD10 = sum(tmp.releaseqtyd10),
  PlanQtyD10 = sum(tmp.planqtyd10),
  KdQtyD10 = sum(tmp.kdqtyD10),
  AsQtyD10 = sum(tmp.asqtyd10)
From (
--계획량 및 지시량
Select AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  ItemCode = cc.childitemno,
-- D+0 Day
  ChangeQtyD00  = sum(case when convert(char(10), getdate(),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD00 = sum(case when convert(char(10), getdate(),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  PlanQtyD00    = sum(case when convert(char(10),getdate(),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD00      = sum(0),
	AsQtyD00      = sum(0),
-- D+1 Day
	ChangeQtyD01  = sum(case when convert(char(10), dateadd(dd,1,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1))  else 0 end ),
  ReleaseQtyD01 = sum(case when convert(char(10), dateadd(dd,1,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1))  else 0 end ),
	PlanQtyD01    = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD01      = sum(0),
	AsQtyD01      = sum(0),
-- D+2 Day
	ChangeQtyD02  = sum(case when convert(char(10), dateadd(dd,2,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1))  else 0 end ),
  ReleaseQtyD02 = sum(case when convert(char(10), dateadd(dd,2,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD02    = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD02      = sum(0),
	AsQtyD02      = sum(0),
-- D+3 Day
	ChangeQtyD03  = sum(case when convert(char(10), dateadd(dd,3,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD03 = sum(case when convert(char(10), dateadd(dd,3,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD03    = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD03      = sum(0),
	AsQtyD03      = sum(0),
-- D+4 Day
	ChangeQtyD04  = sum(case when convert(char(10), dateadd(dd,4,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD04 = sum(case when convert(char(10), dateadd(dd,4,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD04    = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD04      = sum(0),
	AsQtyD04      = sum(0),
-- D+5 Day
	ChangeQtyD05  = sum(case when convert(char(10), dateadd(dd,5,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD05 = sum(case when convert(char(10), dateadd(dd,5,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD05    = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD05      = sum(0),
	AsQtyD05      = sum(0),
-- D+6 Day
	ChangeQtyD06  = sum(case when convert(char(10), dateadd(dd,6,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD06 = sum(case when convert(char(10), dateadd(dd,6,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD06    = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD06      = sum(0),
	AsQtyD06      = sum(0),
-- D+7 Day
	ChangeQtyD07  = sum(case when convert(char(10), dateadd(dd,7,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD07 = sum(case when convert(char(10), dateadd(dd,7,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD07    = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD07      = 0,
	AsQtyD07      = 0,
-- D+8 Day
	ChangeQtyD08  = sum(case when convert(char(10), dateadd(dd,8,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD08 = sum(case when convert(char(10), dateadd(dd,8,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD08    = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD08      = 0,
	AsQtyD08      = 0,
-- D+9 Day
	ChangeQtyD09  = sum(case when convert(char(10), dateadd(dd,9,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD09 = sum(case when convert(char(10), dateadd(dd,9,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD09    = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD09      = 0,
	AsQtyD09      = 0,
-- D+10 Day
	ChangeQtyD10  = sum(case when convert(char(10), dateadd(dd,10,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
  ReleaseQtyD10 = sum(case when convert(char(10), dateadd(dd,10,getdate()),102) = aa.plandate 
    then (isnull(bb.Releaseqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end ),
	PlanQtyD10    = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1)) else 0 end),
	KdQtyD10      = 0,
	AsQtyD10      = 0
From ( select areacode, divisioncode, itemcode, plandate, sum(changeqty) as changeqty
	from tplanday
	where  Plandate >= convert(char(10),getdate(),102)  and 
				Plandate <= convert(char(10), dateadd(dd,10,getdate()),102)
	group by areacode, divisioncode, itemcode, plandate ) aa left outer join
	( select plandate, areacode, divisioncode, itemcode, Sum( ReleaseKbCount * ReleaseKbQty ) as Releaseqty
	from tplanrelease
	where plandate = convert(char(10),getdate(),102) and prdflag not in ('E','C') and releasegubun = 'Y'
	group by plandate, areacode, divisioncode, itemcode ) bb
	on aa.plandate = bb.plandate and aa.areacode = bb.areacode and
	aa.divisioncode = bb.divisioncode and aa.itemcode = bb.itemcode
	left outer join tpartwarningbom cc
	on aa.itemcode = cc.modelitemno
group by aa.areacode, aa.divisioncode, cc.childitemno

Union All
-- 제품, 자가품  KD/AS 지시량
Select AreaCode = cc.areacode,
	DivisionCode = cc.divisioncode,
	ItemCode = ee.childitemno,
--D+0 Day
	ChangeQtyD00   = sum(0),
	ReleaseQtyD00  = sum(0),
	PlanQtyD00     = sum(0),
	KdQtyD00       = sum(case when convert(char(10),getdate(),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD00       = sum(case when convert(char(10),getdate(),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+1 Day
	ChangeQtyD01   = sum(0),
	ReleaseQtyD01  = sum(0),
	PlanQtyD01     = sum(0),
	KdQtyD01       = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD01       = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+2 Day
	ChangeQtyD02   = sum(0),
	ReleaseQtyD02  = sum(0),
	PlanQtyD02     = sum(0),
	KdQtyD02       = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD02       = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+3 Day
	ChangeQtyD03   = sum(0),
	ReleaseQtyD03  = sum(0),
	PlanQtyD03     = sum(0),
	KdQtyD03       = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD03       = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+4 Day
	ChangeQtyD04   = sum(0),
	ReleaseQtyD04  = sum(0),
	PlanQtyD04     = sum(0),
	KdQtyD04       = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD04       = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+5 Day
	ChangeQtyD05   = sum(0),
	ReleaseQtyD05  = sum(0),
	PlanQtyD05     = sum(0),
	KdQtyD05       = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD05       = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+6 Day
	ChangeQtyD06   = sum(0),
	ReleaseQtyD06  = sum(0),
	PlanQtyD06     = sum(0),
	KdQtyD06       = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD06       = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+7 Day
	ChangeQtyD07   = sum(0),
	ReleaseQtyD07  = sum(0),
	PlanQtyD07     = sum(0),
	KdQtyD07       = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD07       = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+8 Day
	ChangeQtyD08   = sum(0),
	ReleaseQtyD08  = sum(0),
	PlanQtyD08     = sum(0),
	KdQtyD08       = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD08       = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+9 Day
	ChangeQtyD09   = sum(0),
	ReleaseQtyD09  = sum(0),
	PlanQtyD09     = sum(0),
	KdQtyD09       = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD09       = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
--D+10 Day
	ChangeQtyD10   = sum(0),
	ReleaseQtyD10  = sum(0),
	PlanQtyD10     = sum(0),
	KdQtyD10       = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end),
	AsQtyD09       = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( cc.shipremainqty * ee.QuantityPerUnit ) else 0 end
	  else 0 end)
From ( select areacode = aa.areacode, 
				divisioncode = aa.divisioncode, 
				itemcode = aa.itemcode, 
				shipgubun = bb.shipoemgubun,
			plandate = case when applyfrom <> convert(char(10), getdate(),102)
			  then convert(char(10), dateadd(dd,-1,convert(datetime,aa.applyfrom)),102)
			  else aa.applyfrom end, 
			shipremainqty = aa.shipremainqty
	from tsrorder aa inner join tmstshipgubun bb
	on aa.shipgubun  = bb.shipgubun and bb.shipoemgubun in ('A','K')
	where aa.shipendgubun = 'N' and 
		aa.applyfrom >= convert(char(10),getdate(),102) and 
		aa.applyfrom <= convert(char(10),dateadd(dd,11,getdate()),102) ) cc
	inner join tmstmodel dd
	on cc.areacode = dd.areacode and cc.divisioncode = dd.divisioncode and
	  cc.itemcode = dd.itemcode
	left outer join tpartwarningbom ee
	on cc.areacode = ee.areacode and cc.divisioncode = ee.divisioncode and
	  cc.itemcode = ee.modelitemno
Where dd.itemclass = '30' or ( dd.itemclass = '10' and dd.itembuysource = '03' )
group by cc.areacode, cc.divisioncode, ee.childitemno, cc.plandate

Union All
-- 원재료 KD/AS 소요량
Select AreaCode = cc.areacode,
	DivisionCode = cc.divisioncode,
	ItemCode = cc.itemcode,
--D+0 Day
	ChangeQtyD00   = sum(0),
	ReleaseQtyD00  = sum(0),
	PlanQtyD00     = sum(0),
	KdQtyD00       = sum(case when convert(char(10),getdate(),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD00       = sum(case when convert(char(10),getdate(),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+1 Day
	ChangeQtyD01   = sum(0),
	ReleaseQtyD01  = sum(0),
	PlanQtyD01     = sum(0),
	KdQtyD01       = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD01       = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+2 Day
	ChangeQtyD02   = sum(0),
	ReleaseQtyD02  = sum(0),
	PlanQtyD02     = sum(0),
	KdQtyD02       = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD02       = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+3 Day
	ChangeQtyD03   = sum(0),
	ReleaseQtyD03  = sum(0),
	PlanQtyD03     = sum(0),
	KdQtyD03       = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD03       = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+4 Day
	ChangeQtyD04   = sum(0),
	ReleaseQtyD04  = sum(0),
	PlanQtyD04     = sum(0),
	KdQtyD04       = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD04       = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+5 Day
	ChangeQtyD05   = sum(0),
	ReleaseQtyD05  = sum(0),
	PlanQtyD05     = sum(0),
	KdQtyD05       = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD05       = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+6 Day
	ChangeQtyD06   = sum(0),
	ReleaseQtyD06  = sum(0),
	PlanQtyD06     = sum(0),
	KdQtyD06       = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD06       = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+7 Day
	ChangeQtyD07   = sum(0),
	ReleaseQtyD07  = sum(0),
	PlanQtyD07     = sum(0),
	KdQtyD07       = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD07       = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+8 Day
	ChangeQtyD08   = sum(0),
	ReleaseQtyD08  = sum(0),
	PlanQtyD08     = sum(0),
	KdQtyD08       = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD08       = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+9 Day
	ChangeQtyD09   = sum(0),
	ReleaseQtyD09  = sum(0),
	PlanQtyD09     = sum(0),
	KdQtyD09       = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD09       = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end),
--D+10 Day
	ChangeQtyD10   = sum(0),
	ReleaseQtyD10  = sum(0),
	PlanQtyD10     = sum(0),
	KdQtyD10       = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then cc.shipremainqty else 0 end
	  else 0 end),
	AsQtyD09       = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then cc.shipremainqty else 0 end
	  else 0 end)
From ( select areacode = aa.areacode, 
				divisioncode = aa.divisioncode, 
				itemcode = aa.itemcode, 
				shipgubun = bb.shipoemgubun,
			plandate = case when applyfrom <> convert(char(10), getdate(),102)
			  then convert(char(10), dateadd(dd,-1,convert(datetime,aa.applyfrom)),102)
			  else aa.applyfrom end, 
			shipremainqty = aa.shipremainqty
	from tsrorder aa inner join tmstshipgubun bb
	on aa.shipgubun  = bb.shipgubun and bb.shipoemgubun in ('A','K')
	where aa.shipendgubun = 'N' and 
		aa.applyfrom >= convert(char(10),getdate(),102) and 
		aa.applyfrom <= convert(char(10),dateadd(dd,11,getdate()),102) ) cc
	inner join tmstmodel dd
	on cc.areacode = dd.areacode and cc.divisioncode = dd.divisioncode and
	  cc.itemcode = dd.itemcode
Where dd.itemclass in ('10','35') and dd.itembuysource <> '03'
group by cc.areacode, cc.divisioncode, cc.itemcode, cc.plandate 
) tmp
group by tmp.areacode, tmp.divisioncode, tmp.itemcode


go
