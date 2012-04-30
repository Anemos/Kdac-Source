/* ************************** TMPMCALENDAR table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMPMCALENDAR]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMPMCALENDAR]
GO

CREATE TABLE [TMPMCALENDAR] (
  [ApplyMonth]  [char]      (7)   NOT NULL ,
  [ApplyDate]   [char]      (10)  NOT NULL ,
  [WcCode]      [char]      (3)   NOT NULL ,
  [DayNo]       [smallint]        NOT NULL ,
  [WorkGubun]   [char]      (1)   NOT NULL CONSTRAINT [DF_TMPMCALENDAR_WorkGubun] DEFAULT ('W'),
  [OverWork]    [char]      (1)   NULL ,
  [DawnWork]    [char]      (1)   NULL ,
  [NightWork]   [char]      (1)   NULL ,
  [Remark]      [varchar]   (50)  NULL ,
  [LastEmp]     [varchar]   (6)   NULL ,
  [LastDate]    [LastDate]        NULL ,
  CONSTRAINT [PK_TMPMCALENDAR] PRIMARY KEY  CLUSTERED
  (
    [ApplyMonth],[ApplyDate],[WcCode]
  )  ON [PRIMARY] ,
  CONSTRAINT [CHK_TMPMCALENDAR_WorkGubun] CHECK ([WorkGubun] = 'W' or [WorkGubun] = 'H')
) ON [PRIMARY]
GO

setuser
GO
