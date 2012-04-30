/* ************************** TLOADSIMULATION table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TLOADSIMULATION]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TLOADSIMULATION]
GO

CREATE TABLE [dbo].[TLOADSIMULATION] (
  [VersionNo]   [char]    (1)     NOT NULL,
  [PlanDate]    [char]    (10)    NOT NULL,
  [SerialNo]    [int]             NOT NULL,
  [OrderNo]     [char]    (8)     NULL,
  [PartNo]      [char]    (6)     NULL,
  [OperNo]      [char]    (3)     NULL,
  [WcCode]      [char]    (3)     NULL,
  [RemainTime]  [numeric] (10,0)  NULL,
  [AllotTime]   [numeric] (5,0)   NULL,
  [LoadFlag]    [char]    (1)     NULL,
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]  default getdate()   NULL,
  CONSTRAINT [PK_TLOADSIMULATION] PRIMARY KEY  CLUSTERED
  (
    [VersionNo], [PlanDate], [SerialNo]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO

--SELECT DATEDIFF(minute,'2010-05-11 12:00','2010-05-11 13:30')
--SELECT DATEADD(minute,250,'2080-05-11 12:00')
