/*
  file name : sp_get_cmms_serial.sql
  system    : cmms system
  procedure name  : sp_get_cmms_serial
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_get_cmms_serial]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_get_cmms_serial]
go

/*
execute sp_get_cmms_serial
*/

create procedure [dbo].[sp_get_cmms_serial]
  @ps_area char(1),
  @ps_factory char(1),
  @ps_codeid varchar(10)

As

Begin

declare @ls_nextno varchar(10), @ls_refno varchar(10)
declare @ls_rtn    varchar(10)
declare @li_cnt int, @li_totalcnt int

Begin Tran
select @ls_refno = serlal_no
from  serial
where area_code = @ps_area and factory_code = @ps_factory and serial_div = @ps_codeid

select @ls_nextno = cast((cast(@ls_refno as integer) + 1) as varchar(10))
select @li_totalcnt = 8 - len(@ls_nextno)
select @li_cnt = 0
while @li_cnt < @li_totalcnt
  Begin
    select @li_cnt = @li_cnt + 1
    select @ls_nextno = '0' + @ls_nextno
  End

update serial
set serlal_no = @ls_nextno
where area_code = @ps_area and factory_code = @ps_factory and serial_div = @ps_codeid

Commit Tran

select @ls_refno

End   -- Procedure End