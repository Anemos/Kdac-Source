/*
  file name : sp_pisf031a_02.sql
  system    : cmms system
  procedure name  : sp_pisf031a_02
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf031a_02]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf031a_02]
go

/*
Execute sp_pisf031a_02
*/
-- flag : 'D' 삭제, 'A':등록, 'C':저장선택(정상불출쪽에서 조회가능)
-- Stscd : A-등록, C-자재불출완료
--Part_Out 조인이유: 폼(칼럼)을만들기 위해서 그래야 Update
--한꺼번에 가능

create Procedure [dbo].[sp_pisf031a_02]
 @ps_area char(1),
 @ps_division char(1)

As
Begin

select area_code = c.area_code,
  factory_code = c.factory_code,
  part_code = c.part_code,
  part_tag = b.part_tag,
  part_name = a.part_name,
  invy_state = IsNull(b.invy_state, 'U'),
  part_used = b.part_used,
  dept_code = b.dept_code,
  out_qty = IsNull(c.out_qty,1),
  wo_code = b.wo_code,
  equip_code = b.equip_code,
  buybackflag = b.buybackflag,
  out_date = cast(c.scandate as datetime),
  out_serial = b.out_serial,
  part_spec = a.part_spec,
  part_unit = a.part_unit,
  part_location = a.part_location,
  normal_qty = a.normal_qty,
  repair_qty = a.repair_qty,
  scram_qty = a.scram_qty,
  etc_qty = a.etc_qty,
  part_cost = a.part_cost,
  scandate = c.scandate
from part_master a left outer join part_out b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and
    a.part_code = b.part_code and b.part_tag = 'x'
  inner join part_out_temp c
  on a.area_code = c.area_code and a.factory_code = c.factory_code and
    a.part_code = c.part_code and c.flag = 'C' and c.stscd <> 'C'
where c.area_code = @ps_area and c.factory_code = @ps_division

End   -- Procedure End