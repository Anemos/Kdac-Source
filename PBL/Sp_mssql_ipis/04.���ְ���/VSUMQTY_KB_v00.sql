/*
  File Name : VSUMQTY_KB.SQL
  SYSTEM    : KDAC ���� ���� ���� �ý���
  View Name  : VSUMQTY_KB
  Description : ���ǻ������̺��� ���ǿ� ���� �ż� ���
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
  TotalQty = tmp.totalqty,      -- �ѹ��ణ�Ǹż�
  ActiveQty = tmp.activeqty,    -- Active ���Ǹż�
  SleepQty = tmp.sleepqty,      -- Sleep ���Ǹż�
  CurrentQty = tmp.currentqty   -- �����ż�
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
