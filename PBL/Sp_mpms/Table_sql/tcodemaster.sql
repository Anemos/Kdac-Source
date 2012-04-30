/* ************************** TCODEMASTER table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TCODEMASTER]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TCODEMASTER]
GO

CREATE TABLE [dbo].[TCODEMASTER] (
  [CodeGubun]   [char]     (6)    NOT NULL,
  [GubunName]   [varchar]  (50)   NULL,
  [CoCode]      [char]     (1)    NOT NULL,
  [CodeName]    [varchar]  (50)   NULL,
  [LastEmp]     [char]     (6)    NULL,
  [LastDate]    [datetime] default getdate()
  CONSTRAINT [PK_TCODEMASTER] PRIMARY KEY  CLUSTERED
  (
    [CodeGubun], [CoCode]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
