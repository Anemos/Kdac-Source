/*
  File Name : VSUMQTY_KB.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  View Name  : VSUMQTY_KB
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
      Where id = object_id(N'[dbo].[VSUMQTY_KB]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[VSUMQTY_KB]
GO

/* select * from vsumqty_kb */

CREATE  View VSUMQTY_KB

As

Select AreaCode = tmp.AreaCode,
  DivisionCode = tmp.DivisionCode,
  ItemCode = tmp.ItemCode,
  ItemName = bb.ItemName,
  ItemUnit = bb.itemunit,
  TotalQty = tmp.totalqty,      -- 총발행간판매수
  ActiveQty = tmp.activeqty,    -- Active 간판매수
  SleepQty = tmp.sleepqty,      -- Sleep 간판매수
  CurrentQty = tmp.currentqty   -- 현재운영매수
From
  ( select areacode = aa.areacode,
divisioncode = aa.divisioncode,
itemcode = aa.itemcode,
totalqty = sum(case when aa.kbactivegubun in ('A','S') then 1 else 0  end),
activeqty = sum(case when aa.kbactivegubun ='A' then 1 else 0  end),
sleepqty = sum(case when aa.kbactivegubun ='S' then 1 else 0  end),
currentqty = sum(case when aa.partkbstatus in ('A','B')  then 1 else 0  end)
from tpartkbstatus aa inner join tmstpartkb cc
  on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
    aa.suppliercode = cc.suppliercode and aa.itemcode = cc.itemcode and cc.useflag <> 'Y'
  inner join tmstsupplier dd
  on cc.suppliercode = dd.suppliercode and dd.xstop <> 'X'
group by aa.areacode, aa.divisioncode, aa.itemcode
) tmp inner join tmstitem bb
  on tmp.itemcode = bb.itemcode
where not exists ( select cc.itemcode from tpartwarningno cc
  where tmp.areacode = cc.areacode and tmp.divisioncode = cc.divisioncode and tmp.itemcode = cc.itemcode )
go
