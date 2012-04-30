/*
  File Name : sp_pisr164u_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisr164u_01
  Description : 외주간판 안전재고율 수정
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter : @ps_areacode char(1),
    @ps_divisioncode char(1),
    @ps_pdcd varchar(3),
    @ps_suppliercode varchar(6)
  Use Table :
  Initial   : 2005.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr164u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr164u_01]
GO

/*
EXEC  sp_pisr164u_01 'D','A','%','%'
*/

CREATE  Procedure sp_pisr164u_01
  @ps_areacode char(1),
  @ps_divisioncode char(1),
  @ps_pdcd varchar(3),
  @ps_suppliercode varchar(6)

As
Begin

select AreaCode = aa.areacode,
  DivisionCode = aa.divisioncode,
  ItemCode = aa.itemcode,
  ItemName = bb.itemname,
  ProductGroup = cc.productgroup,
  SupplierCode = aa.suppliercode,
  SupplierName = ee.supplierkorname,
  Applyfrom = aa.applyfrom,
  Applyto = aa.applyto,
  SupplyTerm = ff.supplyterm,
  SupplyEditNo = ff.supplyeditno,
  SupplyCycle = ff.supplycycle,
  ItemUnit = bb.itemunit,
  PartType = aa.parttype,
  RackQty = aa.rackqty,
  SafetyStock = aa.safetystock
from tmstpartkbhis aa inner join tmstitem bb
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
  aa.applyto = '9999.12.31'


End     -- Procedure End

GO

