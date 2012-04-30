/*
  File Name : sp_piss611u_04.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_piss611u_04
  Description : 포드 Shipping Label
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS
  Initial   : 2004.12.06
  Author    : Kisskim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_piss611u_04]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_piss611u_04]
GO

/*
Execute sp_piss611u_04
  @ps_areacode    = 'D',
  @ps_divisioncode  = 'A',
  @ps_customercode  = 'E39111',
  @ps_customeritemcode  = '19020706',
  @ps_invoiceno   = '%',
  @ps_serialnoFrom  = 0

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/


CREATE PROCEDURE sp_piss611u_04
  @ps_areacode          char(1),
  @ps_divisioncode      char(1),
  @ps_customercode      char(6),
  @ps_customeritemcode  varchar(16),
  @ps_invoiceno         varchar(20),
  @ps_serialnoFrom      int

AS

BEGIN

Select AreaCode = @ps_areacode,
  DivisionCode = @ps_divisioncode,
  CustomerCode = aa.CustomerCode,
  CustomerItemCode = bb.CustomerItemCode,
  Unit        = bb.unit,
  SupplierCode = aa.SupplierCode,
  SupplierName = aa.SupplierName,
  Segment1 = aa.Segment1,
  Segment2 = aa.Segment2,
  SupplierCity = bb.SupplierCity,
  CountryOfOrigin = bb.CountryOfOrigin,
  CustomerDivision = bb.CustomerDivision,
  CustomerPlantAddress = bb.CustomerPlantAddress,
  CustomerPlantAddress2 = bb.CustomerPlantAddress2,
  CustomerCity = bb.CustomerPlantCity,
  CustomerState = bb.CustomerState,
  PlantDock = bb.PlantDock,
  ShipQty = cc.ShipQty,
  DeliveryLocation = bb.DeliveryLocation,
  CustomerNo  = bb.CustomerNo,
  ItemCode = bb.ItemCode,
  EngAlert = bb.EngAlert,
  SupplierNo = bb.SupplierNo,
  ContainerNo = bb.ContainerNo,
  GrossWgt = bb.GrossWgt,
  PartNo  = bb.PartNo,
  PartDesc  = bb.PartDesc,
  SerialNoFrom  = cc.SerialNoFrom,
  LabelCount = cc.LabelCount,
  StandardPackqty = bb.StandardPackQty,
  WorkCenter = bb.WorkCenter,
  Shift = bb.Shift,
  TraceDate = cc.TraceDate,
  LotSize = bb.LotSize,
  DockCode = bb.DockCode,
  LabelGubun = bb.LabelGubun,
  Bar2dCheck = bb.Bar2dCheck
From tlabelcustomer aa inner join tlabelitem bb
  on aa.customercode = bb.customercode
  inner join tlabelcontainer cc
  on bb.areacode = cc.areacode and bb.divisioncode = cc.divisioncode and
    bb.customercode = cc.customercode and bb.customeritemcode = cc.customeritemcode
Where cc.areacode = @ps_areacode and cc.divisioncode = @ps_divisioncode and
  cc.customercode = @ps_customercode and cc.customeritemcode = @ps_customeritemcode and
  cc.invoiceno = @ps_invoiceno and cc.serialnofrom = @ps_serialnofrom

END


GO
