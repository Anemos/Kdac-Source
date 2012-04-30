/****************************************************************************************
 File Name		: sp_piso_get_server_user.sql
 SYSTEM		: IPIS
 Procedure Name		: sp_piso_get_server_user
 Description		: DBMS에 연결된 사용자 정보
 Supply			: DAEWOO Information Systems Co., LTD IAS Dept
 Use DataBase		: IPIS
 Use Program		: 
 Parameter		: 
 Use Table		: 
 Execute Procedure	: 
 Initial			: 2000.11.14
 Author			: Kim Jin-Su
****************************************************************************************/
/*
dbcc opentran('ipis')

exec sp_piso_get_server_user

kill 56

select * from tmstterminalline

select * from toztrm
dbcc sqlperf(logspace)
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso_get_server_user]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso_get_server_user]
GO

CREATE PROCEDURE sp_piso_get_server_user

as

set nocount on

declare
@retcode         int,
@loginame     sysname

declare
@sidlow         varbinary(85),
@sidhigh        varbinary(85),
@sid1           varbinary(85),
@spidlow         int,
@spidhigh        int

declare
@charMaxLenLoginName      varchar(6),
@charMaxLenDBName         varchar(6),
@charMaxLenCPUTime        varchar(10),
@charMaxLenDiskIO         varchar(10),
@charMaxLenHostName       varchar(10),
@charMaxLenProgramName    varchar(10),
@charMaxLenLastBatch      varchar(10),
@charMaxLenCommand        varchar(10)

declare
@charsidlow              varchar(85),
@charsidhigh             varchar(85),
@charspidlow              varchar(11),
@charspidhigh             varchar(11)


select   @retcode         = 0      -- 0=good ,1=bad.

--------defaults
select @sidlow = convert(varbinary(85), (replicate(char(0), 85)))
select @sidhigh = convert(varbinary(85), (replicate(char(1), 85)))

select    @spidlow         = 0,
	@spidhigh        = 32767

IF (@loginame IS     NULL)  --Simple default to all LoginNames.
      GOTO LABEL_17PARM1EDITED

--------

select @sid1 = null
if exists(select * from master.dbo.syslogins where loginname = @loginame)
	select @sid1 = sid from master.dbo.syslogins where loginname = @loginame

IF (@sid1 IS NOT NULL)  --Parm is a recognized login name.
   begin
   select @sidlow  = suser_sid(@loginame)
         ,@sidhigh = suser_sid(@loginame)
   GOTO LABEL_17PARM1EDITED
   end

--------

IF (lower(@loginame) IN ('active'))  --Special action, not sleeping.
   begin
   select @loginame = lower(@loginame)
   GOTO LABEL_17PARM1EDITED
   end

--------

IF (patindex ('%[^0-9]%' , isnull(@loginame,'z')) = 0)  --Is a number.
   begin
   select
             @spidlow   = convert(int, @loginame)
            ,@spidhigh  = convert(int, @loginame)
   GOTO LABEL_17PARM1EDITED
   end

--------

RaisError(15007,-1,-1,@loginame)
select @retcode = 1
GOTO LABEL_86RETURN


LABEL_17PARM1EDITED:


--------------------  Capture consistent sysprocesses.  -------------------

SELECT	spid,
		status,
		sid,
		hostname,
		program_name,
		cmd,
		cpu,
		physical_io,
		blocked,
		dbid,
		convert(sysname, rtrim(loginame)) as loginname,
		spid as 'spid_sort',
		substring( convert(varchar,last_batch,111) ,6  ,5 ) + ' '  + substring( convert(varchar,last_batch,113) ,13 ,8 )   as 'last_batch_char'
  INTO    	#tb1_sysprocesses
  from 		master.dbo.sysprocesses   (nolock)


--------Screen out any rows?

IF (@loginame IN ('active'))
   DELETE #tb1_sysprocesses
         where   lower(status)  = 'sleeping'
         and     upper(cmd)    IN (
                     'AWAITING COMMAND'
                    ,'MIRROR HANDLER'
                    ,'LAZY WRITER'
                    ,'CHECKPOINT SLEEP'
                    ,'RA MANAGER'
                                  )

         and     blocked       = 0



--------Prepare to dynamically optimize column widths.


Select
    @charsidlow     = convert(varchar(85),@sidlow)
   ,@charsidhigh    = convert(varchar(85),@sidhigh)
   ,@charspidlow     = convert(varchar,@spidlow)
   ,@charspidhigh    = convert(varchar,@spidhigh)



SELECT
             @charMaxLenLoginName =
                  convert( varchar
                          ,isnull( max( datalength(loginname)) ,5)
                         )

            ,@charMaxLenDBName    =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,db_name(dbid)))) ,6)
                         )

            ,@charMaxLenCPUTime   =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,cpu))) ,7)
                         )

            ,@charMaxLenDiskIO    =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,physical_io))) ,6)
                         )

            ,@charMaxLenCommand  =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,cmd))) ,7)
                         )

            ,@charMaxLenHostName  =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,hostname))) ,8)
                         )

            ,@charMaxLenProgramName =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,program_name))) ,11)
                         )

            ,@charMaxLenLastBatch =
                  convert( varchar
                          ,isnull( max( datalength( convert(varchar,last_batch_char))) ,9)
                         )
      from
             #tb1_sysprocesses
      where
--             sid >= @sidlow
--      and    sid <= @sidhigh
--      and
             spid >= @spidlow
      and    spid <= @spidhigh



--------Output the report.


EXECUTE(
'
SET nocount off

SELECT
             SPID          = convert(char(5),spid)

            ,Status        =
                  CASE lower(status)
                     When ''sleeping'' Then lower(status)
                     Else                   upper(status)
                  END

            ,Login         = substring(loginname,1,' + @charMaxLenLoginName + ')

            ,HostName      =
                  CASE hostname
                     When Null  Then ''  .''
                     When '' '' Then ''  .''
                     Else    substring(hostname,1,' + @charMaxLenHostName + ')
                  END

            ,BlkBy         =
                  CASE               isnull(convert(char(5),blocked),''0'')
                     When ''0'' Then ''  .''
                     Else            isnull(convert(char(5),blocked),''0'')
                  END

            ,DBName        = substring(db_name(dbid),1,' + @charMaxLenDBName + ')
            ,Command       = substring(cmd,1,' + @charMaxLenCommand + ')

            ,CPUTime       = substring(convert(varchar,cpu),1,' + @charMaxLenCPUTime + ')
            ,DiskIO        = substring(convert(varchar,physical_io),1,' + @charMaxLenDiskIO + ')

            ,LastBatch     = substring(last_batch_char,1,' + @charMaxLenLastBatch + ')

            ,ProgramName   = substring(program_name,1,' + @charMaxLenProgramName + ')
            ,SPID          = convert(char(5),spid)  --Handy extra for right-scrolling users.
      from
             #tb1_sysprocesses  --Usually DB qualification is needed in exec().
      where
             spid >= 7' + '
      and    spid <= ' + @charspidhigh + ' order by ProgramName, HostName

      -- (Seems always auto sorted.)

SET nocount on
'
)
/*****AKUNDONE: removed from where-clause in above EXEC sqlstr
             sid >= ' + @charsidlow  + '
      and    sid <= ' + @charsidhigh + '
      and
**************/


LABEL_86RETURN:


if (object_id('tempdb..#tb1_sysprocesses') is not null)
            drop table #tb1_sysprocesses

return @retcode -- sp_who2



