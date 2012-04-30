/*
  File Name : sp_pisr163i_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisr163i_01
  Description : 실시간 간판운영매수 조회
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
      Where id = object_id(N'[dbo].[sp_pisr163i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr163i_01]
GO

/*
EXEC  sp_pisr163i_01 'D','A','%','%'
*/

CREATE  Procedure sp_pisr163i_01
  @ps_areacode char(1),
  @ps_divisioncode char(1),
  @ps_pdcd varchar(3),
  @ps_suppliercode varchar(6)

As
Begin

declare @li_totcnt integer, @li_cnt integer
declare @ls_areacode char(1), @ls_divisioncode char(1), @ls_itemcode varchar(12)
create table #tmp_supplier(
  areacode char(1),
  divisioncode char(1),
  itemcode varchar(12),
  suppliercode char(5),
  suppliertelno varchar(20),
  parttype char(1),
  rackqty int,
  safetystock numeric(3,1),
  usecenter varchar(5),
  usecentername varchar(50),
  duplicate int)
-- 품번이 단일업체인 경우
insert into #tmp_supplier
select aa.areacode, aa.divisioncode, aa.itemcode, aa.suppliercode, cc.suppliertelno,
  aa.parttype, aa.rackqty, aa.safetystock, aa.usecenter, '', 0
from tmstpartkbhis aa inner join 
  ( select areacode = cc.areacode,
	    divisioncode =  cc.divisioncode, 
	    itemcode = cc.itemcode
	  from tmstpartkbhis cc inner join tmstsupplier dd
	    on cc.suppliercode = dd.suppliercode and dd.xstop <> 'X'
	  where applyto >= convert(char(10),getdate(),102)
    group by cc.areacode, cc.divisioncode, cc.itemcode
    having count(*) = 1) bb
  on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
    aa.itemcode = bb.itemcode
  inner join tmstsupplier cc
  on aa.suppliercode = cc.suppliercode and cc.xstop <> 'X'
where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
  aa.applyto >= convert(char(10),getdate(),102)

-- 품번이 이원화업체인 경우
select areacode = aa.areacode, 
  divisioncode = aa.divisioncode,
  itemcode = aa.itemcode,
  IDENTITY(int, 1,1) as id_num
into #tmp_dup
from tmstpartkbhis aa inner join tmstsupplier bb
  on aa.suppliercode = bb.suppliercode and bb.xstop <> 'X'
where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
  aa.applyto >= convert(char(10),getdate(),102)
	group by aa.areacode, aa.divisioncode, aa.itemcode
	having count(*) > 1

select @li_totcnt = @@rowcount
select @li_cnt = 0

while @li_cnt <= (@li_totcnt - 1)
  Begin
    select top 1 @ls_areacode = areacode,
      @ls_divisioncode = divisioncode,
      @ls_itemcode = itemcode
    from #tmp_dup
    where id_num > @li_cnt
    order by id_num
    
    insert into #tmp_supplier
    select top 1 aa.areacode, aa.divisioncode, aa.itemcode, aa.suppliercode, bb.suppliertelno,
      aa.parttype, aa.rackqty, aa.safetystock, aa.usecenter, '', 1
    from tmstpartkbhis aa inner join tmstsupplier bb
      on aa.suppliercode = bb.suppliercode
    where aa.areacode = @ls_areacode and aa.divisioncode = @ls_divisioncode and
      aa.itemcode = @ls_itemcode and aa.applyto >= convert(char(10),getdate(),102) and aa.useflag <> 'Y'
    
    select @li_cnt = @li_cnt + 1
  End

update #tmp_supplier
set usecentername = bb.supplierkorname
from #tmp_supplier aa inner join tmstsupplier bb
  on aa.usecenter = bb.suppliercode

select AreaCode = tmp.AreaCode,
  DivisionCode = tmp.DivisionCode,
  ItemCode = tmp.ItemCode,
  ItemName = tmp.ItemName,
  SupplierCode = tmp.SupplierCode,
  SupplierName = tmp.SupplierName,
  SupplierTelno = tmp.SupplierTelno,
  SupplyTerm = tmp.SupplyTerm,
  SupplyEditNo = tmp.SupplyEditNo,
  SupplyCycle = tmp.SupplyCycle,
  PartType = tmp.PartType,
  ItemUnit = tmp.ItemUnit,
  RackQty = tmp.RackQty,
  TotalQty = tmp.TotalQty,
  ActiveQty = tmp.ActiveQty,
  SleepQty = tmp.SleepQty,
  CurrentQty = tmp.CurrentQty,
  SafetyStock = tmp.SafetyStock,
  UseCenter = tmp.UseCenter,
  UseCenterName = tmp.UseCenterName,
  DayPlanQtyD00 = tmp.DayPlanQtyD00,
  CalQtyD00 = tmp.CalQtyD00,
  DiffQtyD00 = tmp.DiffQtyD00,
  DayPlanQtyD01 = tmp.DayPlanQtyD01,
  CalQtyD01 = tmp.CalQtyD01,
  DiffQtyD01 = tmp.DiffQtyD01,
  DayPlanQtyD02 = tmp.DayPlanQtyD02,
  CalQtyD02 = tmp.CalQtyD02,
  DiffQtyD02 = tmp.DiffQtyD02,
  DayPlanQtyD03 = tmp.DayPlanQtyD03,
  CalQtyD03 = tmp.CalQtyD03,
  DiffQtyD03 = tmp.DiffQtyD03,
  DayPlanQtyD04 = tmp.DayPlanQtyD04,
  CalQtyD04 = tmp.CalQtyD04,
  DiffQtyD04 = tmp.DiffQtyD04,
  DayPlanQtyD05 = tmp.DayPlanQtyD05,
  CalQtyD05 = tmp.CalQtyD05,
  DiffQtyD05 = tmp.DiffQtyD05,
  DayPlanQtyD06 = tmp.DayPlanQtyD06,
  CalQtyD06 = tmp.CalQtyD06,
  DiffQtyD06 = tmp.DiffQtyD06,
  DayPlanQtyD07 = tmp.DayPlanQtyD07,
  CalQtyD07 = tmp.CalQtyD07,
  DiffQtyD07 = tmp.DiffQtyD07,
  DupChk = tmp.DupChk,
  Warning = case when ( ceiling(tmp.CalQtyD01 * 1.5) - tmp.currentqty < 0 and
    ceiling(tmp.CalQtyD02 * 1.5) - tmp.currentqty < 0 and
    ceiling(tmp.CalQtyD03 * 1.5) - tmp.currentqty < 0 and
    ceiling(tmp.CalQtyD04 * 1.5) - tmp.currentqty < 0 and
    ceiling(tmp.CalQtyD05 * 1.5) - tmp.currentqty < 0 and
    ceiling(tmp.CalQtyD06 * 1.5) - tmp.currentqty < 0 and
    ceiling(tmp.CalQtyD07 * 1.5) - tmp.currentqty < 0 and
    substring(tmp.usecenter,1,1) <> 'D' ) then 1 else 0 end
from ( select AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  ItemCode = aa.ItemCode,
  ItemName = aa.ItemName,
  SupplierCode = dd.suppliercode,
  SupplierName = ee.supplierkorname,
  SupplierTelno = dd.suppliertelno,
  SupplyTerm = ff.supplyterm,
  SupplyEditNo = ff.supplyeditno,
  SupplyCycle = ff.supplycycle,
  PartType = dd.parttype,
  ItemUnit = aa.itemunit,
  RackQty = dd.rackqty,
  TotalQty = aa.totalqty,
  ActiveQty = aa.activeqty,
  SleepQty = aa.sleepqty,
  CurrentQty = aa.currentqty,
  SafetyStock = dd.safetystock,
  UseCenter = dd.usecenter,
  UseCenterName = dd.usecentername,
  DayPlanQtyD00 = isnull(bb.planqtyd00,0) + isnull(bb.kdqtyD00,0) + isnull(bb.asqtyd00,0),
  CalQtyD00 = ceiling(((isnull(bb.planqtyd00,0) + isnull(bb.kdqtyD00,0) + isnull(bb.asqtyd00,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD00 = ceiling(((isnull(bb.planqtyd00,0) + isnull(bb.kdqtyD00,0) + isnull(bb.asqtyd00,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD01 = isnull(bb.planqtyd01,0) + isnull(bb.kdqtyD01,0) + isnull(bb.asqtyd01,0),
  CalQtyD01 = ceiling(((isnull(bb.planqtyd01,0) + isnull(bb.kdqtyD01,0) + isnull(bb.asqtyd01,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD01 = ceiling(((isnull(bb.planqtyd01,0) + isnull(bb.kdqtyD01,0) + isnull(bb.asqtyd01,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD02 = isnull(bb.planqtyd02,0) + isnull(bb.kdqtyD02,0) + isnull(bb.asqtyd02,0),
  CalQtyD02 = ceiling(((isnull(bb.planqtyd02,0) + isnull(bb.kdqtyD02,0) + isnull(bb.asqtyd02,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD02 = ceiling(((isnull(bb.planqtyd02,0) + isnull(bb.kdqtyD02,0) + isnull(bb.asqtyd02,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD03 = isnull(bb.planqtyd03,0) + isnull(bb.kdqtyD03,0) + isnull(bb.asqtyd03,0),
  CalQtyD03 = ceiling(((isnull(bb.planqtyd03,0) + isnull(bb.kdqtyD03,0) + isnull(bb.asqtyd03,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD03 = ceiling(((isnull(bb.planqtyd03,0) + isnull(bb.kdqtyD03,0) + isnull(bb.asqtyd03,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD04 = isnull(bb.planqtyd04,0) + isnull(bb.kdqtyD04,0) + isnull(bb.asqtyd04,0),
  CalQtyD04 = ceiling(((isnull(bb.planqtyd04,0) + isnull(bb.kdqtyD04,0) + isnull(bb.asqtyd04,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD04 = ceiling(((isnull(bb.planqtyd04,0) + isnull(bb.kdqtyD04,0) + isnull(bb.asqtyd04,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD05 = isnull(bb.planqtyd05,0) + isnull(bb.kdqtyD05,0) + isnull(bb.asqtyd05,0),
  CalQtyD05 = ceiling(((isnull(bb.planqtyd05,0) + isnull(bb.kdqtyD05,0) + isnull(bb.asqtyd05,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD05 = ceiling(((isnull(bb.planqtyd05,0) + isnull(bb.kdqtyD05,0) + isnull(bb.asqtyd05,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD06 = isnull(bb.planqtyd06,0) + isnull(bb.kdqtyD06,0) + isnull(bb.asqtyd06,0),
  CalQtyD06 = ceiling(((isnull(bb.planqtyd06,0) + isnull(bb.kdqtyD06,0) + isnull(bb.asqtyd06,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD06 = ceiling(((isnull(bb.planqtyd06,0) + isnull(bb.kdqtyD06,0) + isnull(bb.asqtyd06,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DayPlanQtyD07 = isnull(bb.planqtyd07,0) + isnull(bb.kdqtyD07,0) + isnull(bb.asqtyd07,0),
  CalQtyD07 = ceiling(((isnull(bb.planqtyd07,0) + isnull(bb.kdqtyD07,0) + isnull(bb.asqtyd07,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )),
  DiffQtyD07 = ceiling(((isnull(bb.planqtyd07,0) + isnull(bb.kdqtyD07,0) + isnull(bb.asqtyd07,0)) / dd.rackqty )
    * (ff.supplyterm * (1 +ff.supplycycle) / ff.supplyeditno + dd.safetystock )) - aa.currentqty,
  DupChk = dd.duplicate
from vsumqty_kb aa left outer join vwarning_qty bb
  on aa.areacode = bb.areacode and aa.divisioncode = bb.divisioncode and
    aa.itemcode = bb.itemcode
  inner join tmstmodel cc
	on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
	  aa.itemcode = cc.itemcode
	inner join #tmp_supplier dd
	on aa.areacode = dd.areacode and aa.divisioncode = dd.divisioncode and
	  aa.itemcode = dd.itemcode
	inner join tmstsupplier ee
  on dd.suppliercode = ee.suppliercode
  left outer join tmstpartcycle ff
  on dd.areacode = ff.areacode and dd.divisioncode = ff.divisioncode and
    dd.suppliercode = ff.suppliercode and ff.applyto >= convert(char(10),getdate(),102)
where aa.areacode = @ps_areacode and aa.divisioncode = @ps_divisioncode and
  dd.suppliercode like @ps_suppliercode and cc.productgroup like @ps_pdcd ) tmp

drop table #tmp_dup
drop table #tmp_supplier

End     -- Procedure End

GO

