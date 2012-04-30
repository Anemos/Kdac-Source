/*
	File Name	: SP_PART_RETURN_UP.SQL
	SYSTEM		: 설비관리시스템
	Procedure Name	: SP_PART_RETURN_UP
	Description	: 설비자재 반납정보 업로드
			  여주전자 서버추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: CMMS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[SP_PART_RETURN_UP]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[SP_PART_RETURN_UP]
GO

/*
Execute SP_PART_RETURN_UP
*/

CREATE  PROCEDURE SP_PART_RETURN_UP
AS
BEGIN -- BEGIN PROCEDURE

select * into #tmp_partele
from [ipisele_svr\ipis].cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and 
  return_qty is not null and factory_code <> 'R'

if exists(select 1 from #tmp_partele )
begin
  INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCPARTRETURN
  (AREACODE,DIVISIONCODE,returndate,serialno,itemcode, slipno, orderno,
  deptcode, usage, mcno, stockstatus, returnqty, datastatus, uploadflag)
  select area_code, factory_code, convert(varchar(8),return_date,112), return_serial,
  upper(part_code), part_tag, isnull(wo_code,''), isnull(dept_code,''), isnull(part_used,''), isnull(equip_code,''), invy_state, return_qty, input_div, up_div
  from #tmp_partele

  update [ipisele_svr\ipis].cmms.dbo.part_return
  set up_div = 'Y'
  from [ipisele_svr\ipis].cmms.dbo.part_return aa, #tmp_partele bb
  where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
        aa.part_code = bb.part_code and aa.part_tag = bb.part_tag
end

select * into #tmp_partmac
from [ipismac_svr\ipis].cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and return_qty is not null

if exists(select 1 from #tmp_partmac )
begin
  INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCPARTRETURN
  (AREACODE,DIVISIONCODE,returndate,serialno,itemcode, slipno, orderno,
  deptcode, usage, mcno, stockstatus, returnqty, datastatus, uploadflag)
  select area_code, factory_code, convert(varchar(8),return_date,112), return_serial,
  upper(part_code), part_tag, isnull(wo_code,''), isnull(dept_code,''), isnull(part_used,''), isnull(equip_code,''), invy_state, return_qty, input_div, up_div
  from #tmp_partmac

  update [ipismac_svr\ipis].cmms.dbo.part_return
  set up_div = 'Y'
  from [ipismac_svr\ipis].cmms.dbo.part_return aa,#tmp_partmac bb
  where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
        aa.part_code = bb.part_code and aa.part_tag = bb.part_tag
end

select * into #tmp_parthvac
from [ipishvac_svr\ipis].cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and return_qty is not null

if exists(select 1 from #tmp_parthvac )
begin
  INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCPARTRETURN
  (AREACODE,DIVISIONCODE,returndate,serialno,itemcode, slipno, orderno,
  deptcode, usage, mcno, stockstatus, returnqty, datastatus, uploadflag)
  select area_code, factory_code, convert(varchar(8),return_date,112), return_serial,
  upper(part_code), part_tag, isnull(wo_code,''), isnull(dept_code,''), isnull(part_used,''), isnull(equip_code,''), invy_state, return_qty, input_div, up_div
  from #tmp_parthvac

  update [ipishvac_svr\ipis].cmms.dbo.part_return
  set up_div = 'Y'
  from [ipishvac_svr\ipis].cmms.dbo.part_return aa,#tmp_parthvac bb
  where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
        aa.part_code = bb.part_code and aa.part_tag = bb.part_tag

end

select * into #tmp_partjin
from ipisjin_svr.cmms.dbo.part_return
where up_div = 'N' and invy_state is not null and return_qty is not null

if exists(select 1 from #tmp_partjin )
begin
  INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCPARTRETURN
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
  INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCPARTRETURN
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
DROP TABLE #tmp_partmac
DROP TABLE #tmp_parthvac
DROP TABLE #tmp_partjin

END -- END PROCEDURE


GO
