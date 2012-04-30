/*
  file name : sp_get_time.sql
  system    : cmms system
  procedure name  : sp_get_time
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_get_time]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_get_time]
go

/*
execute sp_get_time
*/

create procedure [dbo].[sp_get_time]
@dt_from  datetime,
@dt_to  datetime
AS
BEGIN
select datediff(minute,@dt_from,@dt_to)
END