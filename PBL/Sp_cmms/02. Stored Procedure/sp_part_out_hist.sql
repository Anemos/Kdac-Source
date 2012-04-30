/*
  file name : sp_part_out_hist.sql
  system    : cmms system
  procedure name  : sp_part_out_hist
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_part_out_hist]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_part_out_hist]
go

/*
execute sp_part_out_hist
*/

create procedure [dbo].[sp_part_out_hist]
AS
BEGIN -- BEGIN PROCEDURE

delete PART_OUT_HIST from
(SELECT DISTINCT a.area_code,a.factory_code,a.EQUIP_CODE, a.PART_CODE
FROM PART_OUT A,
  PART_MASTER B
wHERE A.AREA_CODE=B.AREA_CODE AND
  A.FACTORY_CODE=B.FACTORY_CODE AND
  A.PART_CODE = B.PART_CODE AND A.EQUIP_CODE IS NOT NULL AND A.EQUIP_CODE<>''
GROUP BY a.EQUIP_CODE,
  a.PART_CODE,
  b.PART_NAME,
  b.PART_SPEC,
  a.AREA_CODE,
  a.FACTORY_CODE) a, PART_OUT_HIST b
where a.area_code = b.area_code and a.factory_code = b.factory_code and
  a.equip_code = b.equip_code AND A.PART_CODE = B.PART_CODE

INSERT INTO PART_OUT_HIST( EQUIP_CODE, PART_CODE, PART_NAME, PART_SPEC, LASTDATE, AREA_CODE, FACTORY_CODE)
SELECT DISTINCT a.EQUIP_CODE, a.PART_CODE, b.PART_NAME, b.PART_SPEC, MAX(A.OUT_DATE) AS LASTDATE , a.AREA_CODE, a.FACTORY_CODE
FROM PART_OUT A,
  PART_MASTER B
wHERE A.AREA_CODE=B.AREA_CODE AND
  A.FACTORY_CODE=B.FACTORY_CODE AND
  A.PART_CODE = B.PART_CODE AND A.EQUIP_CODE IS NOT NULL AND A.EQUIP_CODE<>''
GROUP BY a.EQUIP_CODE,
  a.PART_CODE,
  b.PART_NAME,
  b.PART_SPEC,
  a.AREA_CODE,
  a.FACTORY_CODE

END -- END PROCEDURE