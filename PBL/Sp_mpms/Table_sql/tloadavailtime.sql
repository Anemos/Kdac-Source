/* ************************** TLOADAVAILTIME table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TLOADAVAILTIME]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TLOADAVAILTIME]
GO

CREATE TABLE [dbo].[TLOADAVAILTIME] (
  [VersionNo]   [char]    (1)     NOT NULL,
  [PlanDate]    [char]    (10)    NOT NULL,
  [WcCode]      [char]    (3)     NOT NULL,
  [LifeTime]    [numeric] (10,0)  NULL,
  [ApplyTime]   [numeric] (10,0)  NULL,
  [RemainTime]  [numeric] (10,0)  NULL,
  [OkFlag]      [char]    (1)     NULL,                  -- �ش����ڷ� �۾��忡�� ó���� �Ϸ�Ǿ��ٴ°��� ǥ��
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]  default getdate()   NULL,
  CONSTRAINT [PK_TLOADAVAILTIME] PRIMARY KEY  CLUSTERED
  (
    [VersionNo], [PlanDate], [WcCode]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
