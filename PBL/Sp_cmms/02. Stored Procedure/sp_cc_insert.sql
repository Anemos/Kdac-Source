/*
  file name : sp_cc_insert.sql
  system    : cmms system
  procedure name  : sp_cc_insert
  description : 款康何辑 积己
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_cc_insert]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_cc_insert]
go

/*
execute sp_cc_insert
*/

create procedure [dbo].[sp_cc_insert]
as
begin -- begin procedure
  truncate table cc_master

  insert into cc_master (area_code, factory_code, cc_code, cc_name)
  select areacode, divisioncode, deptcode, deptname
  from ipis.dbo.tmstdept
  where convert(varchar(10), getdate(), 102) between applyfrom and applyto

end -- end procedure
go
