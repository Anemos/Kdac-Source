/*
  File Name : sp_pisr145i_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisr145i_01
  Description : 간판자재 WARNING Table 조회
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter : @ps_areacode char(1),
    @ps_divisioncode char(1),
    @ps_pdcd varchar(3),
    @ps_suppliercode varchar(6)
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr145i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr145i_01]
GO

/*
EXEC  sp_pisr145i_01 'D','A','%','%'
*/

CREATE  Procedure sp_pisr145i_01
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
  duplicate int)
-- 품번이 단일업체인 경우
insert into #tmp_supplier
select aa.areacode, aa.divisioncode, aa.itemcode, aa.suppliercode, cc.suppliertelno,
  aa.parttype, aa.rackqty, 0
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
      aa.parttype, aa.rackqty, 1
    from tmstpartkbhis aa inner join tmstsupplier bb
      on aa.suppliercode = bb.suppliercode
    where aa.areacode = @ls_areacode and aa.divisioncode = @ls_divisioncode and
      aa.itemcode = @ls_itemcode and aa.applyto >= convert(char(10),getdate(),102) and aa.useflag <> 'Y'
    
    select @li_cnt = @li_cnt + 1
  End

select AreaCode = aa.AreaCode,
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
  PastComeQty = isnull(aa.pastcomeqty,0),
  ReadyInvQty = isnull(aa.readyinvqty,0),
  ReadyExamQty = isnull(aa.readyexamqty,0),
  ReadyComeQtyD00 = isnull(aa.readycomeqtyd00,0),
  ReadyComeQtyD01 = isnull(aa.readycomeqtyd01,0),
  ReadyComeQtyD02 = isnull(aa.readycomeqtyd02,0),
  ReadyComeQtyD03 = isnull(aa.readycomeqtyd03,0),
  ReadyComeQtyD04 = isnull(aa.readycomeqtyd04,0),
  ReadyComeQtyD05 = isnull(aa.readycomeqtyd05,0),
  ReadyComeQtyD06 = isnull(aa.readycomeqtyd06,0),
  ReadyComeQtyD07 = isnull(aa.readycomeqtyd07,0),
  ReadyComeQtyD08 = isnull(aa.readycomeqtyd08,0),
  ReadyComeQtyD09 = isnull(aa.readycomeqtyd09,0),
  ReadyComeQtyD10 = isnull(aa.readycomeqtyd10,0),
  ChangeQtyD00 = isnull(bb.changeqtyd00,0),
  ReleaseQtyD00 = isnull(bb.releaseqtyd00,0),
  PlanQtyD00 = isnull(bb.planqtyd00,0),
  KdQtyD00 = isnull(bb.kdqtyD00,0),
  AsQtyD00 = isnull(bb.asqtyd00,0),
  ComInvD00 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00),0),
  ComOrdD00 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00),0),
  ChangeQtyD01 = isnull(bb.changeqtyd01,0),
  ReleaseQtyD01 = isnull(bb.releaseqtyd01,0),
  PlanQtyD01 = isnull(bb.planqtyd01,0),
  KdQtyD01 = isnull(bb.kdqtyD01,0),
  AsQtyD01 = isnull(bb.asqtyd01,0),
  ComInvD01 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01),0),
  ComOrdD01 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01),0),
  ChangeQtyD02 = isnull(bb.changeqtyd02,0),
  ReleaseQtyD02 = isnull(bb.releaseqtyd02,0),
  PlanQtyD02 = isnull(bb.planqtyd02,0),
  KdQtyD02 = isnull(bb.kdqtyD02,0),
  AsQtyD02 = isnull(bb.asqtyd02,0),
  ComInvD02 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02),0),
  ComOrdD02 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02),0),
  ChangeQtyD03 = isnull(bb.changeqtyd03,0),
  ReleaseQtyD03 = isnull(bb.releaseqtyd03,0),
  PlanQtyD03 = isnull(bb.planqtyd03,0),
  KdQtyD03 = isnull(bb.kdqtyD03,0),
  AsQtyD03 = isnull(bb.asqtyd03,0),
  ComInvD03 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03),0),
  ComOrdD03 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03),0),
  ChangeQtyD04 = isnull(bb.changeqtyd04,0),
  ReleaseQtyD04 = isnull(bb.releaseqtyd04,0),
  PlanQtyD04 = isnull(bb.planqtyd04,0),
  KdQtyD04 = isnull(bb.kdqtyD04,0),
  AsQtyD04 = isnull(bb.asqtyd04,0),
  ComInvD04 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04),0),
  ComOrdD04 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04),0),
  ChangeQtyD05 = isnull(bb.changeqtyd05,0),
  ReleaseQtyD05 = isnull(bb.releaseqtyd05,0),
  PlanQtyD05 = isnull(bb.planqtyd05,0),
  KdQtyD05 = isnull(bb.kdqtyD05,0),
  AsQtyD05 = isnull(bb.asqtyd05,0),
  ComInvD05 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05),0),
  ComOrdD05 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    + aa.readycomeqtyd05 - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05),0),
  ChangeQtyD06 = isnull(bb.changeqtyd06,0),
  ReleaseQtyD06 = isnull(bb.releaseqtyd06,0),
  PlanQtyD06 = isnull(bb.planqtyd06,0),
  KdQtyD06 = isnull(bb.kdqtyD06,0),
  AsQtyD06 = isnull(bb.asqtyd06,0),
  ComInvD06 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06),0),
  ComOrdD06 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    + aa.readycomeqtyd05 - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    + aa.readycomeqtyd06 - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06),0),
  ChangeQtyD07 = isnull(bb.changeqtyd07,0),
  ReleaseQtyD07 = isnull(bb.releaseqtyd07,0),
  PlanQtyD07 = isnull(bb.planqtyd07,0),
  KdQtyD07 = isnull(bb.kdqtyD07,0),
  AsQtyD07 = isnull(bb.asqtyd07,0),
  ComInvD07 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07),0),
  ComOrdD07 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    + aa.readycomeqtyd05 - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    + aa.readycomeqtyd06 - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    + aa.readycomeqtyd07 - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07),0),
  ChangeQtyD08 = isnull(bb.changeqtyd08,0),
  ReleaseQtyD08 = isnull(bb.releaseqtyd08,0),
  PlanQtyD08 = isnull(bb.planqtyd08,0),
  KdQtyD08 = isnull(bb.kdqtyD08,0),
  AsQtyD08 = isnull(bb.asqtyd08,0),
  ComInvD08 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07)
    - (bb.planqtyd08 + bb.kdqtyd08 + bb.asqtyd08),0),
  ComOrdD08 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    + aa.readycomeqtyd05 - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    + aa.readycomeqtyd06 - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    + aa.readycomeqtyd07 - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07)
    + aa.readycomeqtyd08 - (bb.planqtyd08 + bb.kdqtyd08 + bb.asqtyd08),0),
  ChangeQtyD09 = isnull(bb.changeqtyd09,0),
  ReleaseQtyD09 = isnull(bb.releaseqtyd09,0),
  PlanQtyD09 = isnull(bb.planqtyd09,0),
  KdQtyD09 = isnull(bb.kdqtyD09,0),
  AsQtyD09 = isnull(bb.asqtyd09,0),
  ComInvD09 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07)
    - (bb.planqtyd08 + bb.kdqtyd08 + bb.asqtyd08)
    - (bb.planqtyd09 + bb.kdqtyd09 + bb.asqtyd09),0),
  ComOrdD09 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    + aa.readycomeqtyd05 - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    + aa.readycomeqtyd06 - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    + aa.readycomeqtyd07 - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07)
    + aa.readycomeqtyd08 - (bb.planqtyd08 + bb.kdqtyd08 + bb.asqtyd08)
    + aa.readycomeqtyd09 - (bb.planqtyd09 + bb.kdqtyd09 + bb.asqtyd09),0),
  ChangeQtyD10 = isnull(bb.changeqtyd10,0),
  ReleaseQtyD10 = isnull(bb.releaseqtyd10,0),
  PlanQtyD10 = isnull(bb.planqtyd10,0),
  KdQtyD10 = isnull(bb.kdqtyD10,0),
  AsQtyD10 = isnull(bb.asqtyd10,0),
  ComInvD10 = isnull(aa.readyinvqty + aa.readyexamqty - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01) 
    - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07)
    - (bb.planqtyd08 + bb.kdqtyd08 + bb.asqtyd08)
    - (bb.planqtyd09 + bb.kdqtyd09 + bb.asqtyd09)
    - (bb.planqtyd10 + bb.kdqtyd10 + bb.asqtyd10),0),
  ComOrdD10 = isnull(aa.readyinvqty + aa.readyexamqty + aa.pastcomeqty + aa.readycomeqtyd00 - (bb.planqtyd00 + bb.kdqtyd00 + bb.asqtyd00)
    + aa.readycomeqtyd01 - (bb.planqtyd01 + bb.kdqtyd01 + bb.asqtyd01)
    + aa.readycomeqtyd02 - (bb.planqtyd02 + bb.kdqtyd02 + bb.asqtyd02)
    + aa.readycomeqtyd03 - (bb.planqtyd03 + bb.kdqtyd03 + bb.asqtyd03)
    + aa.readycomeqtyd04 - (bb.planqtyd04 + bb.kdqtyd04 + bb.asqtyd04)
    + aa.readycomeqtyd05 - (bb.planqtyd05 + bb.kdqtyd05 + bb.asqtyd05)
    + aa.readycomeqtyd06 - (bb.planqtyd06 + bb.kdqtyd06 + bb.asqtyd06)
    + aa.readycomeqtyd07 - (bb.planqtyd07 + bb.kdqtyd07 + bb.asqtyd07)
    + aa.readycomeqtyd08 - (bb.planqtyd08 + bb.kdqtyd08 + bb.asqtyd08)
    + aa.readycomeqtyd09 - (bb.planqtyd09 + bb.kdqtyd09 + bb.asqtyd09)
    + aa.readycomeqtyd10 - (bb.planqtyd10 + bb.kdqtyd10 + bb.asqtyd10),0),
  DupChk = dd.duplicate
from vwarning_kb aa left outer join vwarning_qty bb
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
  dd.suppliercode like @ps_suppliercode and cc.productgroup like @ps_pdcd

drop table #tmp_dup
drop table #tmp_supplier

End     -- Procedure End

GO

