/*
  File Name : sp_check_tableinfo.SQL
  Procedure Name  : sp_check_tableinfo
  Description : 전서버 테이블 정보 분석
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_check_tableinfo]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_check_tableinfo]
GO

/*
Execute sp_check_tableinfo
*/

Create Procedure sp_check_tableinfo

As
Begin

declare @ls_name varchar(50)
declare @ls_errchk varchar(50)

create table #space_used (
  name varchar(50) null,
  rows char(11) null,
  reserved varchar(11) null,
  date varchar(18) null,
  index_size varchar(18) null,
  unused varchar(18) null )

SELECT object_name(id) as table_name
INTO #table_tmp
FROM sysindexes 
WHERE indid IN (1,0) AND OBJECTPROPERTY(id, 'isUserTable') = 1 
ORDER BY object_name(id)

select @ls_name = ''
if @@rowcount <> 0
  Begin
    While @@error = 0
      Begin
        select top 1 @ls_name = table_name
        from #table_tmp
        where table_name > @ls_name
        order by table_name
        
        if @@rowcount = 0
          Break
        
        insert into #space_used
        exec dbo.sp_spaceused @ls_name
        
        if @@error <> 0
          Begin 
            Select @ls_errchk = 'ERROR_03'
            Break
          End
      End
  End

select  * from #space_used

drop table #table_tmp
drop table #space_used

return
End   -- Procedure End
Go
