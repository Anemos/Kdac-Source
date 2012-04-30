/*
  File Name : sp_pisf031b_01.SQL
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf031b_01
  Description : 바코드 입력정보 칼럼
  Use DataBase  : CMMS
  Use Program :
  Parameter : 
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf031b_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf031b_01]
GO

/*
Execute sp_pisf031b_01 
*/

Create Procedure sp_pisf031b_01
 @ps_area char(1),
 @ps_division char(1)

As
Begin

select flag = b.flag,
  part_code = b.part_code,
  part_name = a.part_name,
  part_spec = a.part_spec,
  part_unit = a.part_unit,
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
Go
