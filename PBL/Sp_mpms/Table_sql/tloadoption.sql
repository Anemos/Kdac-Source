/* ************************** TLOADOPTION table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TLOADOPTION]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TLOADOPTION]
GO

CREATE TABLE [dbo].[TLOADOPTION] (
  [VersionNo]   [char]    (1)     NOT NULL,
  [ApplyRatio]  [int]             NULL,
  [OverWork]    [char]    (1)     NULL ,
  [Specialwork] [char]    (1)     NULL ,
  [NightWork]   [char]    (1)     NULL ,
  [StartDate]   [datetime]        NULL,
  [EndDate]     [datetime]        NULL,
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]  default getdate()   NULL,
  CONSTRAINT chk_applyratio CHECK (ApplyRatio BETWEEN 0 and 100 ),
  CONSTRAINT [PK_TLOADOPTION] PRIMARY KEY  CLUSTERED
  (
    [VersionNo]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
