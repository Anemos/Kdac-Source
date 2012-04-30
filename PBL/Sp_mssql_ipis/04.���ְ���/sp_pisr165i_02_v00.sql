/*
  File Name : sp_pisr165i_02.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisr165i_02
  Description : 실시간 미납,가입고 간판현황에 대한 상세 간판정보
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter : @ps_areacode char(1),
    @ps_divisioncode char(1),
    @ps_suppliercode varchar(6),
    @ps_itemcode varchar(12),
    @ps_partstatus char(1),
    @ps_fromday int,
    @ps_today int
  Use Table :
  Initial   : 2005.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr165i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr165i_02]
GO

/*
EXEC  sp_pisr165i_02 'D','A','D0522','AAA','A','-15','-30'
*/

CREATE  Procedure sp_pisr165i_02
  @ps_areacode char(1),
  @ps_divisioncode char(1),
  @ps_suppliercode varchar(6),
  @ps_itemcode varchar(12),
  @ps_partstatus char(1),
  @ps_fromday int,
  @ps_today int

As
Begin

if @ps_partstatus = 'A' 
  Begin
    select Partkbno = aa.partkbno,
      PartType = aa.parttype,
      RackQty = aa.rackqty,
      PartOrderTime = aa.partordertime,
      PartForecastTime = aa.partforecasttime,
      PartReceiptTime = aa.partreceipttime
    from tpartkbstatus aa
    where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
      aa.suppliercode = @ps_suppliercode and aa.itemcode = @ps_itemcode and
      aa.partkbstatus = 'A' and aa.orderchangeflag <> 'Y' and
      datediff(day,getdate(),aa.partforecasttime) >= @ps_today and datediff(day,getdate(),aa.partforecasttime) < @ps_fromday
      
    union all
    
    select Partkbno = aa.partkbno,
      PartType = aa.parttype,
      RackQty = aa.rackqty,
      PartOrderTime = aa.partordertime,
      PartForecastTime = aa.partforecasttime,
      PartReceiptTime = aa.partreceipttime
    from tpartkbstatus aa
    where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
      aa.suppliercode = @ps_suppliercode and aa.itemcode = @ps_itemcode and
      aa.partkbstatus = 'A' and aa.orderchangeflag = 'Y' and
      datediff(day,getdate(),aa.changeforecasttime) >= @ps_today and datediff(day,getdate(),aa.changeforecasttime) < @ps_fromday
  End
else
  Begin
    select Partkbno = aa.partkbno,
      PartType = aa.parttype,
      RackQty = aa.rackqty,
      PartOrderTime = aa.partordertime,
      PartForecastTime = aa.partforecasttime,
      PartReceiptTime = aa.partreceipttime
    from tpartkbstatus aa
    where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
      aa.suppliercode = @ps_suppliercode and aa.itemcode = @ps_itemcode and
      aa.partkbstatus = 'B' and
      datediff(day,getdate(),aa.partreceipttime) >= @ps_today and datediff(day,getdate(),aa.partreceipttime) < @ps_fromday
  End

End     -- Procedure End

GO

