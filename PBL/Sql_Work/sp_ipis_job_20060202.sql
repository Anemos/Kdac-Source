/*
  File Name : sp_ipis_job_20060202.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_ipis_job_20060202
  Description : Shipping Label
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS
  Initial   : 2004.12.06
  Author    : Kisskim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_ipis_job_20060202]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_ipis_job_20060202]
GO

/*
Execute sp_ipis_job_20060202
  @Ps_Areacode    = 'D',
  @Ps_Divisioncode  = 'A'

Dbcc Opentran

*/


CREATE PROCEDURE sp_ipis_job_20060202
  @Ps_Areacode    Char(1),  -- 지역 코드
  @Ps_Divisioncode  Char(1) -- 공장 코드

AS

BEGIN

select suppliercode = temp.suppliercode,
        supplierno = temp.supplierno,
        supplierkorname =  temp.supplierkorname into #tmp_supplier
from [ipisele_svr\ipis].ipis.dbo.TMSTPARTCYCLE kk,
  ( select suppliercode = tmp.suppliercode,
        supplierno = tmp.supplierno,
        supplierkorname =  tmp.supplierkorname
        from (
        select areacode = A.AreaCode,
              divisioncode = A.DivisionCode,
              suppliercode = A.SupplierCode,
          supplierno = B.SupplierNo,
              supplierkorname = B.SupplierKorName
FROM [ipisele_svr\ipis].ipis.dbo.TMSTPARTCYCLE  A
   inner join  [ipisele_svr\ipis].ipis.dbo.TMSTSUPPLIER   B
        on  A.SupplierCode    = B.SupplierCode
where  A.ApplyTo    = '9999.12.31' and
    b.xstop <> 'X'
union all
select areacode = A.AreaCode,
            divisioncode = A.DivisionCode,
            suppliercode = A.SupplierCode,
        supplierno = B.SupplierNo,
            supplierkorname = B.SupplierKorName
FROM [ipismac_svr\ipis].ipis.dbo.TMSTPARTCYCLE  A
   inner join  [ipismac_svr\ipis].ipis.dbo.TMSTSUPPLIER   B
        on  A.SupplierCode    = B.SupplierCode
where  A.ApplyTo    = '9999.12.31' and
    b.xstop <> 'X'
union all
select areacode = A.AreaCode,
            divisioncode = A.DivisionCode,
            suppliercode = A.SupplierCode,
        supplierno = B.SupplierNo,
            supplierkorname = B.SupplierKorName
FROM [ipishvac_svr\ipis].ipis.dbo.TMSTPARTCYCLE A
   inner join  [ipishvac_svr\ipis].ipis.dbo.TMSTSUPPLIER    B
        on  A.SupplierCode    = B.SupplierCode
where  A.ApplyTo    = '9999.12.31' and
    b.xstop <> 'X'
union all
select areacode = A.AreaCode,
            divisioncode = A.DivisionCode,
            suppliercode = A.SupplierCode,
        supplierno = B.SupplierNo,
            supplierkorname = B.SupplierKorName
FROM [ipisjin_svr].ipis.dbo.TMSTPARTCYCLE A
   inner join  [ipisjin_svr].ipis.dbo.TMSTSUPPLIER    B
        on  A.SupplierCode    = B.SupplierCode
where  A.ApplyTo    = '9999.12.31' and
    b.xstop <> 'X' ) tmp
group by tmp.suppliercode, tmp.supplierno, tmp.supplierkorname
having count(*) > 1 ) temp
where kk.areacode = 'D' and kk.divisioncode = 'A' and
  kk.ApplyTo    = '9999.12.31' and kk.suppliercode = temp.suppliercode

-- Select Data

SELECT  areacode = case aa.AreaCode when 'D' then '대구' when 'J' then '진천' else '기타' end,
  divisioncode = case aa.DivisionCode when 'A' then '전장' when 'M' then '제동' when 'S' then '조향' 
            when 'H' then '공조' when 'V' then '압축' else '기타' end,
  suppliercode = aa.SupplierCode,
  supplierno = bb.SupplierNo,
  supplierkorname = bb.SupplierKorName,
  suppliercycle = cast(aa.SupplyTerm as varchar(10)) + '-' +
    cast(aa.SupplyEditNo as varchar(10)) + '-' +
    cast(aa.SupplyCycle as varchar(10)),
  cc.PartEditNo,
  cc.PartEditTime
FROM  [ipisele_svr\ipis].ipis.dbo.TMSTPARTCYCLE  aa inner join #tmp_supplier bb
  on  aa.SupplierCode     = bb.SupplierCode
  inner join [ipisele_svr\ipis].ipis.dbo.tmstpartedit cc
  on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
  aa.suppliercode = cc.suppliercode
WHERE  aa.ApplyTo    = '9999.12.31' and
  cc.ApplyFrom  <= aa.ApplyFrom   AND
  cc.ApplyTo  >= aa.ApplyFrom
union all
SELECT  areacode = case aa.AreaCode when 'D' then '대구' when 'J' then '진천' else '기타' end,
  divisioncode = case aa.DivisionCode when 'A' then '전장' when 'M' then '제동' when 'S' then '조향' 
            when 'H' then '공조' when 'V' then '압축' else '기타' end,
  suppliercode = aa.SupplierCode,
  supplierno = bb.SupplierNo,
  supplierkorname = bb.SupplierKorName,
  suppliercycle = cast(aa.SupplyTerm as varchar(10)) + '-' +
    cast(aa.SupplyEditNo as varchar(10)) + '-' +
    cast(aa.SupplyCycle as varchar(10)),
  cc.PartEditNo,
  cc.PartEditTime
FROM  [ipismac_svr\ipis].ipis.dbo.TMSTPARTCYCLE  aa inner join #tmp_supplier bb
  on  aa.SupplierCode     = bb.SupplierCode
  inner join [ipismac_svr\ipis].ipis.dbo.tmstpartedit cc
  on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
  aa.suppliercode = cc.suppliercode
WHERE  aa.ApplyTo    = '9999.12.31' and
  cc.ApplyFrom  <= aa.ApplyFrom   AND
  cc.ApplyTo  >= aa.ApplyFrom
union all
SELECT  areacode = case aa.AreaCode when 'D' then '대구' when 'J' then '진천' else '기타' end,
  divisioncode = case aa.DivisionCode when 'A' then '전장' when 'M' then '제동' when 'S' then '조향' 
            when 'H' then '공조' when 'V' then '압축' else '기타' end,
  suppliercode = aa.SupplierCode,
  supplierno = bb.SupplierNo,
  supplierkorname = bb.SupplierKorName,
  suppliercycle = cast(aa.SupplyTerm as varchar(10)) + '-' +
    cast(aa.SupplyEditNo as varchar(10)) + '-' +
    cast(aa.SupplyCycle as varchar(10)),
  cc.PartEditNo,
  cc.PartEditTime
FROM  [ipishvac_svr\ipis].ipis.dbo.TMSTPARTCYCLE  aa inner join #tmp_supplier bb
  on  aa.SupplierCode     = bb.SupplierCode
  inner join [ipishvac_svr\ipis].ipis.dbo.tmstpartedit cc
  on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
  aa.suppliercode = cc.suppliercode
WHERE  aa.ApplyTo    = '9999.12.31' and
  cc.ApplyFrom  <= aa.ApplyFrom   AND
  cc.ApplyTo  >= aa.ApplyFrom
union all
SELECT  areacode = case aa.AreaCode when 'D' then '대구' when 'J' then '진천' else '기타' end,
  divisioncode = case aa.DivisionCode when 'A' then '전장' when 'M' then '제동' when 'S' then '조향' 
            when 'H' then '공조' when 'V' then '압축' else '기타' end,
  suppliercode = aa.SupplierCode,
  supplierno = bb.SupplierNo,
  supplierkorname = bb.SupplierKorName,
  suppliercycle = cast(aa.SupplyTerm as varchar(10)) + '-' +
    cast(aa.SupplyEditNo as varchar(10)) + '-' +
    cast(aa.SupplyCycle as varchar(10)),
  cc.PartEditNo,
  cc.PartEditTime
FROM  [ipisjin_svr].ipis.dbo.TMSTPARTCYCLE  aa inner join #tmp_supplier bb
  on  aa.SupplierCode     = bb.SupplierCode
  inner join [ipisjin_svr].ipis.dbo.tmstpartedit cc
  on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
  aa.suppliercode = cc.suppliercode
WHERE  aa.ApplyTo    = '9999.12.31' and
  cc.ApplyFrom  <= aa.ApplyFrom   AND
  cc.ApplyTo  >= aa.ApplyFrom

drop table #tmp_supplier

END


GO
