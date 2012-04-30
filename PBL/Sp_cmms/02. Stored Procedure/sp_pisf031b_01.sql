/*
  file name : sp_pisf031b_01.sql
  system    : cmms system
  procedure name  : sp_pisf031b_01
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf031b_01]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf031b_01]
go

/*
Execute sp_pisf031b_01
*/
-- 자재 불출 임시 테이블
-- flag : 'D' 삭제, 'A':등록, 'C':저장선택(정상불출쪽에서 조회가능)
-- Stscd : A-등록, C-자재불출완료

create Procedure [dbo].[sp_pisf031b_01]
 @ps_area char(1),
 @ps_division char(1)

As
Begin

select flag = b.flag,
  part_code = b.part_code,
  part_name = a.part_name,
  part_spec = a.part_spec,
  part_unit = a.part_unit,
  out_qty   = IsNull(b.out_qty, 1),
  scandate = b.scandate,
  inptid = b.inptid,
  area_code = b.area_code,
  factory_code = b.factory_code,
  stscd = b.stscd,
  inptdt = b.inptdt,
  updtid = b.updtid,
  updtdt = b.updtdt,
  ipaddr = b.ipaddr,
  macaddr = b.macaddr
from part_master a inner join part_out_temp b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and
    a.part_code = b.part_code and b.flag = 'A' and b.stscd <> 'C'
where b.area_code = @ps_area and b.factory_code = @ps_division

End   -- Procedure End