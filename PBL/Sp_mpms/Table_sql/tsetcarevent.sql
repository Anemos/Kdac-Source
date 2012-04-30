/* ************************** TSETCARDEVENT table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSETCARDEVENT]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSETCARDEVENT]
GO

CREATE TABLE [dbo].[TSETCARDEVENT] (
  [Logid]			      [int]	      IDENTITY(1,1),
  [OrderNo]         [char]      (8)     NOT NULL,
  [EventMemo]       [varchar]   (250)   NULL,
  [LastEmp]         [char]      (6)     NULL,
  [LastDate]        [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TSETCARDEVENT] PRIMARY KEY  CLUSTERED
  (
    [Logid]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
