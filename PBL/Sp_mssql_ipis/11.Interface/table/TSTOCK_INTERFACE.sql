-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSTOCK_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSTOCK_INTERFACE]
GO

CREATE TABLE [dbo].[TSTOCK_INTERFACE] (
	[LogID] 	[int] IDENTITY(1,1)	NOT NULL ,
        [KBNo]          [char] (11)     NOT NULL,
	[KBReleaseDate]	[char] (10)	NOT NULL,
	[KBReleaseSeq]	[smallint]	NOT NULL,
	[SeqNo]		[int]		NOT NULL,
        [MISFlag]       [char] (1)      NOT NULL,
        [InterfaceFlag] [char] (1)      NOT NULL,
	[StockDate]	[char] (10)	NOT NULL,
	[AreaCode]	[char] (1)	NOT NULL,
	[DivisionCode]	[char] (1)	NOT NULL,
	[WorkCenter]	[varchar] (5)	NOT NULL,
	[LineCode]	[char] (4)	NOT NULL,
	[ItemCode]	[varchar] (12)	NOT NULL,
	[StockQty]	[Qty]		NOT NULL,
	[LastEmp]	[LastEmp]	NULL,
	[LastDate]	[LastDate]	NULL,
	CONSTRAINT [PK_TSTOCK_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TSTOCK_INTERFACE].[StockQty]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSTOCK_INTERFACE].[LastDate]'
GO

setuser
GO


