/*
  File Name : VSUMQTYCHECK_KB.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  View Name  : VSUMQTYCHECK_KB
  Description : 간판상태테이블에서 간판에 대한 매수 계산
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[VSUMQTYCHECK_KB]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[VSUMQTYCHECK_KB]
GO

/* select * from vsumqtycheck_kb */

CREATE  View VSUMQTYCHECK_KB

As

select areacode = aa.areacode,
divisioncode = aa.divisioncode,
itemcode = aa.itemcode,
suppliercode = aa.suppliercode,
dayqtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) = 0 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) = 0 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
dayqtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) = 0 then
                  1
                else
                  0
                end
              else 0 end),
day15qtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) >= -15 and datediff(day,getdate(),aa.changeforecasttime) < 0 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) >= -15 and datediff(day,getdate(),aa.partforecasttime) < 0 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
day15qtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) >= -15 and datediff(day,getdate(),aa.partreceipttime) < 0 then
                  1
                else
                  0
                end
              else 0 end),
mon1qtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) >= -30 and datediff(day,getdate(),aa.changeforecasttime) < -15 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) >= -30 and datediff(day,getdate(),aa.partforecasttime) < -15 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
mon1qtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) >= -30 and datediff(day,getdate(),aa.partreceipttime) < -15 then
                  1
                else
                  0
                end
              else 0 end),
mon2qtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) >= -60 and datediff(day,getdate(),aa.changeforecasttime) < -30 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) >= -60 and datediff(day,getdate(),aa.partforecasttime) < -30 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
mon2qtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) >= -60 and datediff(day,getdate(),aa.partreceipttime) < -30 then
                  1
                else
                  0
                end
              else 0 end),
mon3qtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) >= -90 and datediff(day,getdate(),aa.changeforecasttime) < -60 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) >= -90 and datediff(day,getdate(),aa.partforecasttime) < -60 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
mon3qtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) >= -90 and datediff(day,getdate(),aa.partreceipttime) < -60 then
                  1
                else
                  0
                end
              else 0 end),
mon6qtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) >= -180 and datediff(day,getdate(),aa.changeforecasttime) < -90 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) >= -180 and datediff(day,getdate(),aa.partforecasttime) < -90 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
mon6qtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) >= -180 and datediff(day,getdate(),aa.partreceipttime) < -90 then
                  1
                else
                  0
                end
              else 0 end),
monnqtya = sum(case when aa.partkbstatus = 'A' then
                case when aa.orderchangeflag = 'Y' then
                  case when datediff(day,getdate(),aa.changeforecasttime) < -180 then
                    1
                  else
                    0
                  end
                else
                  case when datediff(day,getdate(),aa.partforecasttime) < -180 then
                    1
                  else
                    0
                  end
                end
              else 0 end),
monnqtyb = sum(case when aa.partkbstatus = 'B' then
                case when datediff(day,getdate(),aa.partreceipttime) < -180 then
                  1
                else
                  0
                end
              else 0 end)
from tpartkbstatus aa inner join tmstpartkb cc
  on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
    aa.suppliercode = cc.suppliercode and aa.itemcode = cc.itemcode and cc.useflag <> 'Y'
  inner join tmstsupplier dd
  on cc.suppliercode = dd.suppliercode and isnull(dd.xstop,'') <> 'X'
where aa.partkbstatus in ('A','B')
group by aa.areacode, aa.divisioncode, aa.itemcode, aa.suppliercode

go
