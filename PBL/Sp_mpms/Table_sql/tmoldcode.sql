/* ************************** TMOLDCODE table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMOLDCODE]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMOLDCODE]
GO

CREATE TABLE [dbo].[TMOLDCODE] (
  [CodeId]      [char]    (3)     NOT NULL,
  [CodeName]    [char]    (255)   NULL,
  [IdNo]        [int]             NULL,
  [RefNo]       [int]             NULL,
  [RefText]     [varchar] (10)    NULL,
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]        NULL
  CONSTRAINT [PK_MOLDCODE] PRIMARY KEY  CLUSTERED
  (
    [CodeId]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
