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
  [InWorkDate]  [char]    (10)    NULL,    -- �۾�������
  [OutWorkDate] [char]    (10)    NULL,    -- �۾��Ϸ���
  [LoadFlag]    [char]    (1)     NULL,    -- ���� �Ϸ� 'Y'
  [OutFlag]     [char]    (1)     NULL,    -- ���ְ��� 'P'
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
