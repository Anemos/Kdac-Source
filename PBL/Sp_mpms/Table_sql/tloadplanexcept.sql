/* ************************** TLOADPLANEXCEPT table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TLOADPLANEXCEPT]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TLOADPLANEXCEPT]
GO

CREATE TABLE [dbo].[TLOADPLANEXCEPT] (
  [OrderNo]     [char]    (8)     NOT NULL,
  [PartNo]      [char]    (6)     NOT NULL,
  [OperNo]      [char]    (3)     NOT NULL,
  [WcCode]      [char]    (3)     NULL,
  [StdSumTime]  [numeric] (10,0)  NULL,
  [StdTime]     [numeric] (10,0)  NULL,
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TLOADPLANEXCEPT] PRIMARY KEY  CLUSTERED
  (
    [WorkDate],[OrderNo],[PartNo],[OperNo]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
