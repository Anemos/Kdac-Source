/*
  File Name : sp_get_cmms_serial.SQL
  SYSTEM    : CMMS System
  Procedure Name  : sp_get_cmms_serial
  Description : return code( format 00000000 ) from SERIAL
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_get_cmms_serial]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_get_cmms_serial]
GO

/*
exec sp_get_cmms_serial 'out'
*/

Create Procedure sp_get_cmms_serial
  @ps_codeid varchar(10)

As
Begin

declare @ls_nextno varchar(10), @ls_refno varchar(10)
declare @ls_rtn    varchar(10)
declare @li_cnt int, @li_totalcnt int

Begin Tran
select @ls_refno = serlal_no
from  serial
where serial_div = @ps_codeid

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
where serial_div = @ps_codeid

Commit Tran

select @ls_refno

End   -- Procedure End
Go
