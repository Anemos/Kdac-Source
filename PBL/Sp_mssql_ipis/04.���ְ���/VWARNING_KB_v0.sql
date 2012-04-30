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
  SupplierCode = tmp.SupplierCode,
  SupplierName = cc.supplierkorname,
  SupplyTerm = dd.supplyterm,
  SupplyEditNo = dd.supplyeditno,
  SupplyCycle = dd.supplycycle,
  PartType = tmp.parttype,
  ItemUnit = bb.itemunit,
  RackQty = tmp.rackqty,
  PastComeQty = tmp.pastcomeqty,
  ReadyInvQtyD00 = tmp.readyinvqtyd00,
  ReadyExamQtyD00 = tmp.readyexamqtyd00,
  ReadyComeQtyD00 = tmp.readycomeqtyd00,
  ReadyInvQtyD01 = tmp.readyinvqtyd01,
  ReadyExamQtyD01 = tmp.readyexamqtyd01,
  ReadyComeQtyD01 = tmp.readycomeqtyd01,
  ReadyInvQtyD02 = tmp.readyinvqtyd02,
  ReadyExamQtyD02 = tmp.readyexamqtyd02,
  ReadyComeQtyD02 = tmp.readycomeqtyd02,
  ReadyInvQtyD03 = tmp.readyinvqtyd03,
  ReadyExamQtyD03 = tmp.readyexamqtyd03,
  ReadyComeQtyD03 = tmp.readycomeqtyd03,
  ReadyInvQtyD04 = tmp.readyinvqtyd04,
  ReadyExamQtyD04 = tmp.readyexamqtyd04,
  ReadyComeQtyD04 = tmp.readycomeqtyd04,
  ReadyInvQtyD05 = tmp.readyinvqtyd05,
  ReadyExamQtyD05 = tmp.readyexamqtyd05,
  ReadyComeQtyD05 = tmp.readycomeqtyd05,
  ReadyInvQtyD06 = tmp.readyinvqtyd06,
  ReadyExamQtyD06 = tmp.readyexamqtyd06,
  ReadyComeQtyD06 = tmp.readycomeqtyd06,
  ReadyInvQtyD07 = tmp.readyinvqtyd07,
  ReadyExamQtyD07 = tmp.readyexamqtyd07,
  ReadyComeQtyD07 = tmp.readycomeqtyd07,
  ReadyInvQtyD08 = tmp.readyinvqtyd08,
  ReadyExamQtyD08 = tmp.readyexamqtyd08,
  ReadyComeQtyD08 = tmp.readycomeqtyd08,
  ReadyInvQtyD09 = tmp.readyinvqtyd09,
  ReadyExamQtyD09 = tmp.readyexamqtyd09,
  ReadyComeQtyD09 = tmp.readycomeqtyd09,
  ReadyInvQtyD10 = tmp.readyinvqtyd10,
  ReadyExamQtyD10 = tmp.readyexamqtyd10,
  ReadyComeQtyD10 = tmp.readycomeqtyd10
From
  ( select areacode = aa.areacode,
divisioncode = aa.divisioncode,
suppliercode = aa.suppliercode,
itemcode = aa.itemcode,
parttype = aa.parttype,
rackqty = aa.rackqty,
-- D Day
pastcomeqty =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A' then
        case when aa.partforecastdate < convert(char(10),getdate(),102) then aa.rackqty else 0 end
      when aa.changeforecastdate is not null and aa.partkbstatus = 'A' then
        case when aa.changeforecastdate < convert(char(10),getdate(),102) then aa.rackqty else 0 end
      else 0 end),
readyinvqtyd00 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9' then
        case when aa.partforecastdate <= convert(char(10),getdate(),102) then aa.rackqty else 0 end
      when aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate <= convert(char(10),getdate(),102) then aa.rackqty else 0 end
      else 0  end),
readyexamqtyd00 =
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
readyinvqtyd01 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readyexamqtyd01 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd01 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,1,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 2 Day
readyinvqtyd02 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readyexamqtyd02 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd02 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,2,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 3 Day
readyinvqtyd03 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readyexamqtyd03 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd03 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,3,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 4 Day
readyinvqtyd04 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readyexamqtyd04 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd04 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,4,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
-- D + 5 Day
readyinvqtyd05 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
readyexamqtyd05 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd05 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,5,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 6 Day
readyinvqtyd06 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
readyexamqtyd06 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd06 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,6,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 7 Day
readyinvqtyd07 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
readyexamqtyd07 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd07 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,7,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 8 Day
readyinvqtyd08 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
readyexamqtyd08 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd08 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,8,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 9 Day
readyinvqtyd09 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
readyexamqtyd09 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
readycomeqtyd09 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'A'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'A'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,9,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
-- D + 10 Day
readyinvqtyd10 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,10,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag <> '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,10,getdate()),102) then aa.rackqty else 0 end
      else 0 end),
readyexamqtyd10 =
  sum(case when aa.changeforecastdate is null and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.partforecastdate = convert(char(10),dateadd(dd,10,getdate()),102) then aa.rackqty else 0 end
      when   aa.changeforecastdate is not null  and aa.partkbstatus = 'B' and bb.judgeflag = '9'  then
        case when aa.changeforecastdate = convert(char(10),dateadd(dd,10,getdate()),102) then aa.rackqty else 0 end
      else 0  end),
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
group by aa.areacode, aa.divisioncode, aa.suppliercode, aa.itemcode, aa.parttype, aa.rackqty
) tmp inner join tmstitem bb
  on tmp.itemcode = bb.itemcode
  inner join tmstsupplier cc
  on tmp.suppliercode = cc.suppliercode
  left outer join tmstpartcycle dd
  on tmp.areacode = dd.areacode and tmp.divisioncode = dd.divisioncode and
    tmp.suppliercode = dd.suppliercode and dd.applyto = '9999.12.31'

go
