/*
  File Name : sp_pisr165i_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisr165i_01
  Description : 실시간 미납,가입고 간판현황
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter : @ps_areacode char(1),
    @ps_divisioncode char(1),
    @ps_pdcd varchar(3),
    @ps_suppliercode varchar(6),
    @ps_itemcode  varchar(12)
  Use Table :
  Initial   : 2005.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr165i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr165i_01]
GO

/*
EXEC  sp_pisr165i_01 'D','A','%','%','%'
*/

CREATE  Procedure sp_pisr165i_01
  @ps_areacode char(1),
  @ps_divisioncode char(1),
  @ps_pdcd varchar(3),
  @ps_suppliercode varchar(6),
  @ps_itemcode varchar(12)

As
Begin

select AreaCode = aa.areacode,
  DivisionCode = aa.divisioncode,
  ItemCode = aa.itemcode,
  ItemName = bb.ItemName,
  ProductGroup = cc.productgroup,
  SupplierCode = aa.suppliercode,
  SupplierName = ee.supplierkorname,
  SupplyTerm = ff.supplyterm,
  SupplyEditNo = ff.supplyeditno,
  SupplyCycle = ff.supplycycle,
  ItemUnit = bb.itemunit,
  Dayqtya = aa.dayqtya,
  Dayqtyb = aa.dayqtyb,
  Day15qtya = aa.day15qtya,
  Day15qtyb = aa.day15qtyb,
  Mon1qtya = aa.mon1qtya,
  Mon1qtyb = aa.mon1qtyb,
  Mon2qtya = aa.mon2qtya,
  Mon2qtyb = aa.mon2qtyb,
  Mon3qtya = aa.mon3qtya,
  Mon3qtyb = aa.mon3qtyb,
  Mon6qtya = aa.mon6qtya,
  Mon6qtyb = aa.mon6qtyb,
  Monnqtya = aa.monnqtya,
  Monnqtyb = aa.monnqtyb
from vsumqtycheck_kb aa inner join tmstitem bb
  on aa.itemcode = bb.itemcode
  inner join tmstmodel cc
	on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
	  aa.itemcode = cc.itemcode
	inner join tmstsupplier ee
  on aa.suppliercode = ee.suppliercode and ee.xstop <> 'X'
  left outer join tmstpartcycle ff
  on aa.areacode = ff.areacode and aa.divisioncode = ff.divisioncode and
    aa.suppliercode = ff.suppliercode and ff.applyto >= convert(char(10),getdate(),102)
where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
  aa.suppliercode like @ps_suppliercode and cc.productgroup like @ps_pdcd and
  aa.itemcode like @ps_itemcode


End     -- Procedure End

GO

