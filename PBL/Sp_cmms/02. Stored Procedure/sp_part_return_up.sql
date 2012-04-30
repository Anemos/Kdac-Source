/*
  file name : sp_part_return_up.sql
  system    : cmms system
  procedure name  : sp_part_return_up
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_part_return_up]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_part_return_up]
go

/*
execute sp_part_return_up
*/

create procedure [dbo].[sp_part_return_up]
AS
BEGIN -- BEGIN PROCEDURE

select * into #tmp_partele
from [ipis_daegu].cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and
  return_qty is not null and factory_code <> 'R'

if exists(select 1 from #tmp_partele )
begin
  INSERT INTO [ipis_daegu].INTERFACE.dbo.TMCPARTRETURN
  (AREACODE,DIVISIONCODE,returndate,serialno,itemcode, slipno, orderno,
  deptcode, usage, mcno, stockstatus, returnqty, datastatus, uploadflag)
  select area_code, factory_code, convert(varchar(8),return_date,112), return_serial,
  upper(part_code), part_tag, isnull(wo_code,''), isnull(dept_code,''), isnull(part_used,''), isnull(equip_code,''), invy_state, return_qty, input_div, up_div
  from #tmp_partele

  update [ipis_daegu].cmms.dbo.part_return
  set up_div = 'Y'
  from [ipis_daegu].cmms.dbo.part_return aa, #tmp_partele bb
  where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
        aa.part_code = bb.part_code and aa.part_tag = bb.part_tag
end

select * into #tmp_partjin
from ipisjin_svr.cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and return_qty is not null

if exists(select 1 from #tmp_partjin )
begin
  INSERT INTO [ipis_daegu].INTERFACE.dbo.TMCPARTRETURN
  (AREACODE,DIVISIONCODE,returndate,serialno,itemcode, slipno, orderno,
  deptcode, usage, mcno, stockstatus, returnqty, datastatus, uploadflag)
  select area_code, factory_code, convert(varchar(8),return_date,112), return_serial,
  upper(part_code), part_tag, isnull(wo_code,''), isnull(dept_code,''), isnull(part_used,''), isnull(equip_code,''), invy_state, return_qty, input_div, up_div
  from #tmp_partjin

  update ipisjin_svr.cmms.dbo.part_return
  set up_div = 'Y'
  from ipisjin_svr.cmms.dbo.part_return aa,#tmp_partjin bb
  where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
        aa.part_code = bb.part_code and aa.part_tag = bb.part_tag
end

select * into #tmp_partyeo
from [ipisyeo_svr\ipis].cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and return_qty is not null

if exists(select 1 from #tmp_partyeo )
begin
  INSERT INTO [ipis_daegu].INTERFACE.dbo.TMCPARTRETURN
  (AREACODE,DIVISIONCODE,returndate,serialno,itemcode, slipno, orderno,
  deptcode, usage, mcno, stockstatus, returnqty, datastatus, uploadflag)
  select area_code, factory_code, convert(varchar(8),return_date,112), return_serial,
  upper(part_code), part_tag, isnull(wo_code,''), isnull(dept_code,''), isnull(part_used,''), isnull(equip_code,''), invy_state, return_qty, input_div, up_div
  from #tmp_partyeo

  update [ipisyeo_svr\ipis].cmms.dbo.part_return
  set up_div = 'Y'
  from [ipisyeo_svr\ipis].cmms.dbo.part_return aa,#tmp_partyeo bb
  where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
        aa.part_code = bb.part_code and aa.part_tag = bb.part_tag

end

DROP TABLE #tmp_partyeo
DROP TABLE #tmp_partele
DROP TABLE #tmp_partjin

END -- END PROCEDURE