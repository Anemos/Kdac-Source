/*
  File Name : sp_pisf031a_02.SQL
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf031a_02
  Description : 바코드 입력정보 칼럼
  Use DataBase  : CMMS
  Use Program :
  Parameter : 
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf031a_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf031a_02]
GO

/*
Execute sp_pisf031a_02 
*/

Create Procedure sp_pisf031a_02
 @ps_area char(1),
 @ps_division char(1)

As
Begin

select area_code = c.area_code,
  factory_code = c.factory_code,
  part_code = c.part_code,
  part_tag = b.part_tag,
  part_name = a.part_name,
  invy_state = b.invy_state,
  part_used = b.part_used,
  dept_code = b.dept_code,
  out_qty = b.out_qty,
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
Go
