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
  ChangeQtyD00 = Sum(convert(decimal(10,1),tmp.changeqtyd00)),
  ReleaseQtyD00 = sum(convert(decimal(10,1),tmp.releaseqtyd00)),
  PlanQtyD00 = sum(convert(decimal(10,1),tmp.planqtyd00)),
  KdQtyD00 = sum(convert(decimal(10,1),tmp.kdqtyD00)),
  AsQtyD00 = sum(convert(decimal(10,1),tmp.asqtyd00)),
  ChangeQtyD01 = Sum(convert(decimal(10,1),tmp.changeqtyd01)),
  ReleaseQtyD01 = sum(convert(decimal(10,1),tmp.releaseqtyd01)),
  PlanQtyD01 = sum(convert(decimal(10,1),tmp.planqtyd01)),
  KdQtyD01 = sum(convert(decimal(10,1),tmp.kdqtyD01)),
  AsQtyD01 = sum(convert(decimal(10,1),tmp.asqtyd01)),
  ChangeQtyD02 = Sum(convert(decimal(10,1),tmp.changeqtyd02)),
  ReleaseQtyD02 = sum(convert(decimal(10,1),tmp.releaseqtyd02)),
  PlanQtyD02 = sum(convert(decimal(10,1),tmp.planqtyd02)),
  KdQtyD02 = sum(convert(decimal(10,1),tmp.kdqtyD02)),
  AsQtyD02 = sum(convert(decimal(10,1),tmp.asqtyd02)),
  ChangeQtyD03 = Sum(convert(decimal(10,1),tmp.changeqtyd03)),
  ReleaseQtyD03 = sum(convert(decimal(10,1),tmp.releaseqtyd03)),
  PlanQtyD03 = sum(convert(decimal(10,1),tmp.planqtyd03)),
  KdQtyD03 = sum(convert(decimal(10,1),tmp.kdqtyD03)),
  AsQtyD03 = sum(convert(decimal(10,1),tmp.asqtyd03)),
  ChangeQtyD04 = Sum(convert(decimal(10,1),tmp.changeqtyd04)),
  ReleaseQtyD04 = sum(convert(decimal(10,1),tmp.releaseqtyd04)),
  PlanQtyD04 = sum(convert(decimal(10,1),tmp.planqtyd04)),
  KdQtyD04 = sum(convert(decimal(10,1),tmp.kdqtyD04)),
  AsQtyD04 = sum(convert(decimal(10,1),tmp.asqtyd04)),
  ChangeQtyD05 = Sum(convert(decimal(10,1),tmp.changeqtyd05)),
  ReleaseQtyD05 = sum(convert(decimal(10,1),tmp.releaseqtyd05)),
  PlanQtyD05 = sum(convert(decimal(10,1),tmp.planqtyd05)),
  KdQtyD05 = sum(convert(decimal(10,1),tmp.kdqtyD05)),
  AsQtyD05 = sum(convert(decimal(10,1),tmp.asqtyd05)),
  ChangeQtyD06 = Sum(convert(decimal(10,1),tmp.changeqtyd06)),
  ReleaseQtyD06 = sum(convert(decimal(10,1),tmp.releaseqtyd06)),
  PlanQtyD06 = sum(convert(decimal(10,1),tmp.planqtyd06)),
  KdQtyD06 = sum(convert(decimal(10,1),tmp.kdqtyD06)),
  AsQtyD06 = sum(convert(decimal(10,1),tmp.asqtyd06)),
  ChangeQtyD07 = Sum(convert(decimal(10,1),tmp.changeqtyd07)),
  ReleaseQtyD07 = sum(convert(decimal(10,1),tmp.releaseqtyd07)),
  PlanQtyD07 = sum(convert(decimal(10,1),tmp.planqtyd07)),
  KdQtyD07 = sum(convert(decimal(10,1),tmp.kdqtyD07)),
  AsQtyD07 = sum(convert(decimal(10,1),tmp.asqtyd07)),
  ChangeQtyD08 = Sum(convert(decimal(10,1),tmp.changeqtyd08)),
  ReleaseQtyD08 = sum(convert(decimal(10,1),tmp.releaseqtyd08)),
  PlanQtyD08 = sum(convert(decimal(10,1),tmp.planqtyd08)),
  KdQtyD08 = sum(convert(decimal(10,1),tmp.kdqtyD08)),
  AsQtyD08 = sum(convert(decimal(10,1),tmp.asqtyd08)),
  ChangeQtyD09 = Sum(convert(decimal(10,1),tmp.changeqtyd09)),
  ReleaseQtyD09 = sum(convert(decimal(10,1),tmp.releaseqtyd09)),
  PlanQtyD09 = sum(convert(decimal(10,1),tmp.planqtyd09)),
  KdQtyD09 = sum(convert(decimal(10,1),tmp.kdqtyD09)),
  AsQtyD09 = sum(convert(decimal(10,1),tmp.asqtyd09)),
  ChangeQtyD10 = Sum(convert(decimal(10,1),tmp.changeqtyd10)),
  ReleaseQtyD10 = sum(convert(decimal(10,1),tmp.releaseqtyd10)),
  PlanQtyD10 = sum(convert(decimal(10,1),tmp.planqtyd10)),
  KdQtyD10 = sum(convert(decimal(10,1),tmp.kdqtyD10)),
  AsQtyD10 = sum(convert(decimal(10,1),tmp.asqtyd10))
From (
--계획량
Select AreaCode = cc.AreaCode,
  DivisionCode = cc.DivisionCode,
  ItemCode = cc.childitemno,
-- D+0 Day
  ChangeQtyD00  = sum(case when convert(char(10), getdate(),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD00 = sum(case when convert(char(10), getdate(),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  PlanQtyD00    = sum(case when convert(char(10),getdate(),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD00      = sum(0),
	AsQtyD00      = sum(0),
-- D+1 Day
	ChangeQtyD01  = sum(case when convert(char(10), dateadd(dd,1,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1))  else 0 end ),
  ReleaseQtyD01 = sum(case when convert(char(10), dateadd(dd,1,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1))  else 0 end ),
	PlanQtyD01    = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD01      = sum(0),
	AsQtyD01      = sum(0),
-- D+2 Day
	ChangeQtyD02  = sum(case when convert(char(10), dateadd(dd,2,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1))  else 0 end ),
  ReleaseQtyD02 = sum(case when convert(char(10), dateadd(dd,2,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD02    = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD02      = sum(0),
	AsQtyD02      = sum(0),
-- D+3 Day
	ChangeQtyD03  = sum(case when convert(char(10), dateadd(dd,3,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD03 = sum(case when convert(char(10), dateadd(dd,3,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD03    = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD03      = sum(0),
	AsQtyD03      = sum(0),
-- D+4 Day
	ChangeQtyD04  = sum(case when convert(char(10), dateadd(dd,4,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD04 = sum(case when convert(char(10), dateadd(dd,4,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD04    = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD04      = sum(0),
	AsQtyD04      = sum(0),
-- D+5 Day
	ChangeQtyD05  = sum(case when convert(char(10), dateadd(dd,5,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD05 = sum(case when convert(char(10), dateadd(dd,5,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD05    = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD05      = sum(0),
	AsQtyD05      = sum(0),
-- D+6 Day
	ChangeQtyD06  = sum(case when convert(char(10), dateadd(dd,6,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD06 = sum(case when convert(char(10), dateadd(dd,6,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD06    = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD06      = sum(0),
	AsQtyD06      = sum(0),
-- D+7 Day
	ChangeQtyD07  = sum(case when convert(char(10), dateadd(dd,7,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD07 = sum(case when convert(char(10), dateadd(dd,7,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD07    = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD07      = 0,
	AsQtyD07      = 0,
-- D+8 Day
	ChangeQtyD08  = sum(case when convert(char(10), dateadd(dd,8,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD08 = sum(case when convert(char(10), dateadd(dd,8,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD08    = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD08      = 0,
	AsQtyD08      = 0,
-- D+9 Day
	ChangeQtyD09  = sum(case when convert(char(10), dateadd(dd,9,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD09 = sum(case when convert(char(10), dateadd(dd,9,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD09    = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD09      = 0,
	AsQtyD09      = 0,
-- D+10 Day
	ChangeQtyD10  = sum(case when convert(char(10), dateadd(dd,10,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD10 = sum(case when convert(char(10), dateadd(dd,10,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD10    = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD10      = 0,
	AsQtyD10      = 0
From ( select areacode, divisioncode, itemcode, plandate, sum(changeqty) as changeqty, sum(0) as releaseqty
	from tplanday
	where  Plandate >= convert(char(10),getdate(),102)  and 
				Plandate <= convert(char(10), dateadd(dd,10,getdate()),102)
	group by areacode, divisioncode, itemcode, plandate ) aa
	left outer join tpartwarningbom cc
	on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
	aa.itemcode = cc.modelitemno
	inner join tmstmodel bb
	on cc.areacode = bb.areacode and cc.divisioncode = bb.divisioncode and
	  cc.childitemno = bb.itemcode
group by cc.areacode, cc.divisioncode, cc.childitemno

union All
--지시량
Select AreaCode = cc.AreaCode,
  DivisionCode = cc.DivisionCode,
  ItemCode = cc.childitemno,
-- D+0 Day
  ChangeQtyD00  = sum(case when convert(char(10), getdate(),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD00 = sum(case when convert(char(10), getdate(),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  PlanQtyD00    = sum(case when convert(char(10),getdate(),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD00      = sum(0),
	AsQtyD00      = sum(0),
-- D+1 Day
	ChangeQtyD01  = sum(case when convert(char(10), dateadd(dd,1,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1))  else 0 end ),
  ReleaseQtyD01 = sum(case when convert(char(10), dateadd(dd,1,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1))  else 0 end ),
	PlanQtyD01    = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD01      = sum(0),
	AsQtyD01      = sum(0),
-- D+2 Day
	ChangeQtyD02  = sum(case when convert(char(10), dateadd(dd,2,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1))  else 0 end ),
  ReleaseQtyD02 = sum(case when convert(char(10), dateadd(dd,2,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD02    = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD02      = sum(0),
	AsQtyD02      = sum(0),
-- D+3 Day
	ChangeQtyD03  = sum(case when convert(char(10), dateadd(dd,3,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD03 = sum(case when convert(char(10), dateadd(dd,3,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD03    = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD03      = sum(0),
	AsQtyD03      = sum(0),
-- D+4 Day
	ChangeQtyD04  = sum(case when convert(char(10), dateadd(dd,4,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD04 = sum(case when convert(char(10), dateadd(dd,4,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD04    = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD04      = sum(0),
	AsQtyD04      = sum(0),
-- D+5 Day
	ChangeQtyD05  = sum(case when convert(char(10), dateadd(dd,5,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD05 = sum(case when convert(char(10), dateadd(dd,5,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD05    = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD05      = sum(0),
	AsQtyD05      = sum(0),
-- D+6 Day
	ChangeQtyD06  = sum(case when convert(char(10), dateadd(dd,6,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD06 = sum(case when convert(char(10), dateadd(dd,6,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD06    = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD06      = sum(0),
	AsQtyD06      = sum(0),
-- D+7 Day
	ChangeQtyD07  = sum(case when convert(char(10), dateadd(dd,7,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD07 = sum(case when convert(char(10), dateadd(dd,7,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD07    = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD07      = 0,
	AsQtyD07      = 0,
-- D+8 Day
	ChangeQtyD08  = sum(case when convert(char(10), dateadd(dd,8,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD08 = sum(case when convert(char(10), dateadd(dd,8,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD08    = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD08      = 0,
	AsQtyD08      = 0,
-- D+9 Day
	ChangeQtyD09  = sum(case when convert(char(10), dateadd(dd,9,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD09 = sum(case when convert(char(10), dateadd(dd,9,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD09    = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD09      = 0,
	AsQtyD09      = 0,
-- D+10 Day
	ChangeQtyD10  = sum(case when convert(char(10), dateadd(dd,10,getdate()),102) = aa.plandate 
    then (isnull(aa.changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
  ReleaseQtyD10 = sum(case when convert(char(10), dateadd(dd,10,getdate()),102) = aa.plandate 
    then (isnull(aa.Releaseqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end ),
	PlanQtyD10    = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = aa.plandate
	  then (isnull(aa.Changeqty,0) * isnull(cc.QuantityPerUnit,1) / isnull(bb.convertfactor,1)) else 0 end),
	KdQtyD10      = 0,
	AsQtyD10      = 0
From ( select plandate, areacode, divisioncode, itemcode, sum(0) as changeqty,Sum( ReleaseKbCount * ReleaseKbQty ) as Releaseqty
	from tplanrelease
	where plandate = convert(char(10),getdate(),102) and prdflag not in ('E','C') and releasegubun = 'Y'
	group by plandate, areacode, divisioncode, itemcode ) aa
	left outer join tpartwarningbom cc
	on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
	aa.itemcode = cc.modelitemno
	inner join tmstmodel bb
	on cc.areacode = bb.areacode and cc.divisioncode = bb.divisioncode and
	  cc.childitemno = bb.itemcode
group by cc.areacode, cc.divisioncode, cc.childitemno

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
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD00       = sum(case when convert(char(10),getdate(),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+1 Day
	ChangeQtyD01   = sum(0),
	ReleaseQtyD01  = sum(0),
	PlanQtyD01     = sum(0),
	KdQtyD01       = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD01       = sum(case when convert(char(10),dateadd(dd,1,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+2 Day
	ChangeQtyD02   = sum(0),
	ReleaseQtyD02  = sum(0),
	PlanQtyD02     = sum(0),
	KdQtyD02       = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD02       = sum(case when convert(char(10),dateadd(dd,2,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+3 Day
	ChangeQtyD03   = sum(0),
	ReleaseQtyD03  = sum(0),
	PlanQtyD03     = sum(0),
	KdQtyD03       = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD03       = sum(case when convert(char(10),dateadd(dd,3,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+4 Day
	ChangeQtyD04   = sum(0),
	ReleaseQtyD04  = sum(0),
	PlanQtyD04     = sum(0),
	KdQtyD04       = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD04       = sum(case when convert(char(10),dateadd(dd,4,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+5 Day
	ChangeQtyD05   = sum(0),
	ReleaseQtyD05  = sum(0),
	PlanQtyD05     = sum(0),
	KdQtyD05       = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD05       = sum(case when convert(char(10),dateadd(dd,5,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+6 Day
	ChangeQtyD06   = sum(0),
	ReleaseQtyD06  = sum(0),
	PlanQtyD06     = sum(0),
	KdQtyD06       = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD06       = sum(case when convert(char(10),dateadd(dd,6,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+7 Day
	ChangeQtyD07   = sum(0),
	ReleaseQtyD07  = sum(0),
	PlanQtyD07     = sum(0),
	KdQtyD07       = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD07       = sum(case when convert(char(10),dateadd(dd,7,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+8 Day
	ChangeQtyD08   = sum(0),
	ReleaseQtyD08  = sum(0),
	PlanQtyD08     = sum(0),
	KdQtyD08       = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD08       = sum(case when convert(char(10),dateadd(dd,8,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+9 Day
	ChangeQtyD09   = sum(0),
	ReleaseQtyD09  = sum(0),
	PlanQtyD09     = sum(0),
	KdQtyD09       = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD09       = sum(case when convert(char(10),dateadd(dd,9,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
--D+10 Day
	ChangeQtyD10   = sum(0),
	ReleaseQtyD10  = sum(0),
	PlanQtyD10     = sum(0),
	KdQtyD10       = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = cc.plandate then 
	  case when cc.shipgubun = 'K' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
	  else 0 end),
	AsQtyD09       = sum(case when convert(char(10),dateadd(dd,10,getdate()),102) = cc.plandate then
	  case when cc.shipgubun = 'A' then ( isnull(cc.shipremainqty,0) * isnull(ee.QuantityPerUnit,0) / isnull(dd.convertfactor,1)) else 0 end
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
	left outer join tpartwarningbom ee
	on cc.areacode = ee.areacode and cc.divisioncode = ee.divisioncode and
	  cc.itemcode = ee.modelitemno
	inner join tmstmodel dd
	on ee.areacode = dd.areacode and ee.divisioncode = dd.divisioncode and
	  ee.childitemno = dd.itemcode
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
