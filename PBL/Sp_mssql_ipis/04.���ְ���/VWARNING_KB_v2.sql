/*
  File Name : VWARNING_KB.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  View Name  : VWARNING_KB
  Description : 간판자재 WARNING Table 조회 - 입고대기, 검수대기, 납입예정량, 기지시미납량
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[VWARNING_KB]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[VWARNING_KB]
GO

/* select * from vwarning_kb */

CREATE  View VWARNING_KB

As

Select AreaCode = tmp.AreaCode,
  DivisionCode = tmp.DivisionCode,
  ItemCode = tmp.ItemCode,
  ItemName = bb.ItemName,
  ItemUnit = bb.itemunit,
  PastComeQty = convert(decimal(10,1),tmp.pastcomeqty),
  ReadyInvQty = convert(decimal(10,1),tmp.readyinvqty),
  ReadyExamQty = convert(decimal(10,1),tmp.readyexamqty),
  ReadyComeQtyD00 = convert(decimal(10,1),tmp.readycomeqtyd00),
  ReadyComeQtyD01 = convert(decimal(10,1),tmp.readycomeqtyd01),
  ReadyComeQtyD02 = convert(decimal(10,1),tmp.readycomeqtyd02),
  ReadyComeQtyD03 = convert(decimal(10,1),tmp.readycomeqtyd03),
  ReadyComeQtyD04 = convert(decimal(10,1),tmp.readycomeqtyd04),
  ReadyComeQtyD05 = convert(decimal(10,1),tmp.readycomeqtyd05),
  ReadyComeQtyD06 = convert(decimal(10,1),tmp.readycomeqtyd06),
  ReadyComeQtyD07 = convert(decimal(10,1),tmp.readycomeqtyd07),
  ReadyComeQtyD08 = convert(decimal(10,1),tmp.readycomeqtyd08),
  ReadyComeQtyD09 = convert(decimal(10,1),tmp.readycomeqtyd09),
  ReadyComeQtyD10 = convert(decimal(10,1),tmp.readycomeqtyd10)
From
  ( select areacode = aa.areacode,
divisioncode = aa.divisioncode,
itemcode = aa.itemcode,
-- D Day
pastcomeqty =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A' then
        case when aa.partforecastdate < convert(char(10),getdate(),102) then aa.rackqty else 0 end
      when aa.changeforecastdate is not null and aa.partkbstatus = 'A' then
        case when aa.changeforecastdate < convert(char(10),getdate(),102) then aa.rackqty else 0 end
      else 0 end),
readyinvqty =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9' then
        case when aa.partforecastdate <= convert(char(10),getdate(),102) then aa.rackqty else 0 end
      when aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate <= convert(char(10),getdate(),102) then aa.rackqty else 0 end
      else 0  end),
readyexamqty =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate <= convert(char(10),getdate(),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate <= convert(char(10),getdate(),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd00 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),getdate(),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),getdate(),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 1 Day
readycomeqtyd01 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 2 Day
readycomeqtyd02 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 3 Day
readycomeqtyd03 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 4 Day
readycomeqtyd04 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 5 Day
readycomeqtyd05 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 6 Day
readycomeqtyd06 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 7 Day
readycomeqtyd07 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 8 Day
readycomeqtyd08 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 9 Day
readycomeqtyd09 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 10 Day
readycomeqtyd10 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,10,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,10,getdate()),102) then aa.rackqty else 0 end
      else 0 end)
from tpartkbstatus aa inner join tqqcresult bb
  on aa.suppliercode = bb.suppliercode and aa.itemcode = bb.itemcode and
    aa.deliveryno = bb.deliveryno
where aa.kbactivegubun = 'A' and aa.partkbstatus in ('A','B')
group by aa.areacode, aa.divisioncode, aa.itemcode
) tmp inner join tmstitem bb
  on tmp.itemcode = bb.itemcode
where not exists ( select cc.itemcode from tpartwarningno cc
  where tmp.areacode = cc.areacode and tmp.divisioncode = cc.divisioncode and tmp.itemcode = cc.itemcode )

go
