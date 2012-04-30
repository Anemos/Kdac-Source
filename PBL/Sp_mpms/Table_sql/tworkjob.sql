/* ************************** TWORKJOB table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TWORKJOB]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TWORKJOB]
GO

CREATE TABLE [dbo].[TWORKJOB] (
  [Stype]       [char]      (2)     NOT NULL,
  [Srno]        [char]      (10)    NOT NULL,
  [OrderNo]     [char]      (8)     NULL,
  [PartNo]      [char]      (6)     NULL,
  [OperNo]      [char]      (3)     NULL,
  [WcCode]      [char]      (3)     NULL,
  [WorkDate]    [char]      (8)     NULL,
  [WorkEmp]     [char]      (6)     NULL,
  [MchNo]       [char]      (5)     NULL,
  [HeatCost]    [numeric]   (10,0)  NULL,
  [OutCost]     [numeric]   (10,0)  NULL,
  [ScrapQty]    [numeric]   (10,0)  NULL,
  [FinalQty]    [numeric]   (10,0)  NULL,
  [JobTime]     [numeric]   (10,0)  NULL,
  [MchTime1]    [numeric]   (10,0)  NULL,
  [MchTime2]    [numeric]   (10,0)  NULL,
  [MchTime3]    [numeric]   (10,0)  NULL,
  [ResultFlag]  [char]      (1)     NULL,
  [JobMemo]     [varchar]   (255)   NULL,
  [BadStype]    [char]      (2)     NULL,
  [BadSrno]     [char]      (10)    NULL,
  [LastEmp]     [char]      (6)     NULL,
  [LastDate]    [datetime]  default getdate()
  CONSTRAINT [PK_TWORKJOB] PRIMARY KEY  CLUSTERED
  (
    [Stype], [Srno]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
