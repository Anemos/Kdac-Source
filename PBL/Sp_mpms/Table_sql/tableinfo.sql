/* ************************** TABLEINFO table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TABLEINFO]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TABLEINFO]
GO

CREATE TABLE [dbo].[TABLEINFO] (
  [TableName]          [varchar]    (100)    NOT NULL,
  [EleRows]            [numeric]    (10,0)  NULL,
  [EleSize]            [varchar]    (50)    NULL,
  [MacRows]            [numeric]    (10,0)  NULL,
  [MacSize]            [varchar]    (50)    NULL,
  [HvacRows]           [numeric]    (10,0)  NULL,
  [HvacSize]           [varchar]    (50)    NULL,
  [JinRows]            [numeric]    (10,0)  NULL,
  [JinSize]            [varchar]    (50)    NULL,
  [YouRows]            [numeric]    (10,0)  NULL,
  [YouSize]            [varchar]    (50)    NULL,
  [LastEmp]            [char]    (6)     NULL,
  [LastDate]           [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TABLEINFO] PRIMARY KEY  CLUSTERED
  (
    [TableName]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
