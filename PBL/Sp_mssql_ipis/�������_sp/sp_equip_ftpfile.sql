/*
  File Name : sp_equip_ftpfile.SQL
  SYSTEM    : CMMS System
  Procedure Name  : sp_equip_ftpfile
  Description : ftp file list
  Use DataBase  : CMMS
  Use Program :
  Parameter : 
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_equip_ftpfile]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_equip_ftpfile]
GO

/*
Execute sp_equip_ftpfile 
*/

Create Procedure sp_equip_ftpfile
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

End   -- Procedure End
Go
