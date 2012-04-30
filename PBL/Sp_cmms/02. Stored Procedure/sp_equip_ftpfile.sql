/*
  file name : sp_equip_ftpfile.sql
  system    : cmms system
  procedure name  : sp_equip_ftpfile
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_equip_ftpfile]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_equip_ftpfile]
go

/*
execute sp_equip_ftpfile
*/

create Procedure [dbo].[sp_equip_ftpfile]
 @ps_area char(1),
 @ps_division char(1),
 @ps_equipcode varchar(9)

As
Begin

select file_id = a.file_id,
  area_code = a.area_code,
  factory_code = a.factory_code,
  equip_code = a.equip_code,
  file_name = a.file_name,
  file_desc = a.file_desc,
  file_size = a.file_size,
  lastemp = a.lastemp,
  lastdate = a.lastdate
from equip_ftpfile a inner join equip_master b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and
    a.equip_code = b.equip_code
where a.area_code = @ps_area and a.factory_code = @ps_division and
  a.equip_code = @ps_equipcode
order by file_name

End   -- Procedure End