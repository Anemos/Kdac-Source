/* ************************** TORDER table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TORDER]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TORDER]
GO

CREATE TABLE [dbo].[TORDER] (
  [OrderNo]       [char]    (8)     NOT NULL,
  [ToolName]      [varchar]    (100)   NOT NULL,
  [ProductNo]     [varchar]    (12)    NULL,
  [ProductName]   [varchar]    (50)    NULL,
  [DrawingNo]     [varchar] (10)    NULL,
  [DesignMan]     [char]    (6)     NULL,
  [MoldGubun]     [char]    (1)     NULL,
  [AssetFlag]     [char]    (1)     NULL,
  [OrderDept]     [varchar] (5)     NULL,
  [DeptGubun]     [char]    (1)     NULL,
  [OrderMan]      [varchar] (15)    NULL,
  [OrderTelNo]    [varchar] (15)    NULL,
  [UrgentFlag]    [char]    (1)     NULL,
  [IngStatus]     [char]    (1)     NULL,
  [OrderQty]      [numeric] (5,0)   NULL,
  [ForeDate]      [datetime]        NULL,
  [DueDate]       [datetime]        NULL,
  [AccessCost]    [numeric] (11,0)  NULL,
  [LaborCost]     [numeric] (8,0)   NULL,
  [Remark]        [varchar] (255)   NULL,
  [StartDate]     [datetime]        NULL,
  [EndDate]       [datetime]        NULL,
  [LastEmp]       [char]    (6)     NULL,
  [LastDate]      [datetime] default getdate()
  CONSTRAINT [PK_TORDER] PRIMARY KEY  CLUSTERED
  (
    [OrderNo]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
