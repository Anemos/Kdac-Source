/*
  File Name : sp_pisr145u_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisr145u_01
  Description : 간판자재 WARNING 비대상 조회
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter : @ps_areacode char(1),
    @ps_divisioncode char(1),
    @ps_pdcd varchar(3),
    @ps_chk char(1)
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr145u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr145u_01]
GO

/*
EXEC  sp_pisr145u_01 'D','A','%','A'
*/

CREATE  Procedure sp_pisr145u_01
  @ps_areacode char(1),
  @ps_divisioncode char(1),
  @ps_pdcd varchar(3),
  @ps_chk char(1)
As
Begin

If @ps_chk = 'A'
  -- 대상, 비대상 조회
  Begin
  Select Distinct AreaCode = aa.areacode,
    DivisionCode = aa.divisioncode,
    ItemCode = aa.itemcode,
    ItemName = cc.itemname,
    ProductCode = bb.productgroup,
    ProductName = dd.productgroupname,
    ItemUnit = bb.itemunit,
    ItemClass = bb.itemclass,
    ItemSource = bb.itembuysource,
    Gubun = 'N'
  From tmstpartkbhis aa inner join tmstmodel bb
    on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
      aa.itemcode = bb.itemcode
    inner join tmstitem cc
    on aa.itemcode = cc.itemcode
    inner join tmstproductgroup dd
    on bb.areacode = dd.areacode and bb.divisioncode = dd.divisioncode and
      bb.productgroup = dd.productgroup
    inner join tmstsupplier ee
    on aa.suppliercode = ee.suppliercode and ee.xstop <> 'X'
  Where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
    bb.productgroup like @ps_pdcd and aa.applyto >= convert(char(10),getdate(),102) and
    not exists (select ee.itemcode from tpartwarningno ee
      where aa.areacode = ee.areacode and aa.divisioncode = ee.divisioncode and
        aa.itemcode = ee.itemcode )
        
  union all
  
  Select Distinct AreaCode = aa.areacode,
    DivisionCode = aa.divisioncode,
    ItemCode = aa.itemcode,
    ItemName = cc.itemname,
    ProductCode = bb.productgroup,
    ProductName = dd.productgroupname,
    ItemUnit = bb.itemunit,
    ItemClass = bb.itemclass,
    ItemSource = bb.itembuysource,
    Gubun = 'Y'
  From tpartwarningno aa inner join tmstmodel bb
    on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
      aa.itemcode = bb.itemcode
    inner join tmstitem cc
    on aa.itemcode = cc.itemcode
    inner join tmstproductgroup dd
    on bb.areacode = dd.areacode and bb.divisioncode = dd.divisioncode and
      bb.productgroup = dd.productgroup
  Where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
    bb.productgroup like @ps_pdcd
  End
  
If @ps_chk = 'B'
  -- 대상 조회
  Begin
  Select Distinct AreaCode = aa.areacode,
    DivisionCode = aa.divisioncode,
    ItemCode = aa.itemcode,
    ItemName = cc.itemname,
    ProductCode = bb.productgroup,
    ProductName = dd.productgroupname,
    ItemUnit = bb.itemunit,
    ItemClass = bb.itemclass,
    ItemSource = bb.itembuysource,
    Gubun = 'N'
  From tmstpartkbhis aa inner join tmstmodel bb
    on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
      aa.itemcode = bb.itemcode
    inner join tmstitem cc
    on aa.itemcode = cc.itemcode
    inner join tmstproductgroup dd
    on bb.areacode = dd.areacode and bb.divisioncode = dd.divisioncode and
      bb.productgroup = dd.productgroup
    inner join tmstsupplier ee
    on aa.suppliercode = ee.suppliercode and ee.xstop <> 'X'
  Where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
    bb.productgroup like @ps_pdcd and aa.applyto >= convert(char(10),getdate(),102) and
    not exists (select ee.itemcode from tpartwarningno ee
      where aa.areacode = ee.areacode and aa.divisioncode = ee.divisioncode and
        aa.itemcode = ee.itemcode )
  End

If @ps_chk = 'C'
  -- 비대상 조회
  Begin
  Select Distinct AreaCode = aa.areacode,
    DivisionCode = aa.divisioncode,
    ItemCode = aa.itemcode,
    ItemName = cc.itemname,
    ProductCode = bb.productgroup,
    ProductName = dd.productgroupname,
    ItemUnit = bb.itemunit,
    ItemClass = bb.itemclass,
    ItemSource = bb.itembuysource,
    Gubun = 'Y'
  From tpartwarningno aa inner join tmstmodel bb
    on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
      aa.itemcode = bb.itemcode
    inner join tmstitem cc
    on aa.itemcode = cc.itemcode
    inner join tmstproductgroup dd
    on bb.areacode = dd.areacode and bb.divisioncode = dd.divisioncode and
      bb.productgroup = dd.productgroup
  Where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
    bb.productgroup like @ps_pdcd
  End

End     -- Procedure End

GO

