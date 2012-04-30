/* ************************** TLOADPRIORITY table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TLOADPRIORITY]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TLOADPRIORITY]
GO

CREATE TABLE [dbo].[TLOADPRIORITY] (
  [VersionNo]   [char]    (1)     NOT NULL,
  [SerialNo]    [int]	            NOT NULL,
  [OrderNo]     [char]    (8)     NOT NULL,
  [PartNo]      [char]    (6)     NOT NULL,
  [PreOperNo]   [char]    (3)     NULL,
  [OperNo]      [char]    (3)     NOT NULL,
  [PostOperno]  [char]    (3)     NULL,
  [WcCode]      [char]    (3)     NULL,
  [StdTimeSum]  [numeric] (10,0)  NULL,
  [AllotTime]   [numeric] (5,0)   NULL,
  [InWorkDate]  [char]    (10)    NULL,    -- 작업시작일
  [OutWorkDate] [char]    (10)    NULL,    -- 작업완료일
  [LoadFlag]    [char]    (1)     NULL,    -- 배정 완료 'Y'
  [OutFlag]     [char]    (1)     NULL,    -- 외주공정 'P'
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TLOADPRIORITY] PRIMARY KEY  CLUSTERED
  (
    [VersionNo], [SerialNo]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
