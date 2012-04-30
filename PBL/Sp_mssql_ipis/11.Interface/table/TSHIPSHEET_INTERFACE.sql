-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSHIPSHEET_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSHIPSHEET_INTERFACE]
GO

CREATE TABLE [dbo].[TSHIPSHEET_INTERFACE] (
	[LogID] 	[int] IDENTITY(1,1)	NOT NULL ,
	[ShipDate]	[char] (10)	NOT NULL,
	[AreaCode]	[char] (1)	NOT NULL,
	[DivisionCode]	[char] (1)	NOT NULL,
	[SRNo]	        [varchar] (11)	NOT NULL,
        [SeqNo]         [Int]		NOT NULL,
	[MISFlag]	[char] (1)	NOT NULL ,
	[InterfaceFlag]	[char] (1)	NOT NULL ,
	[ShipSheetNo]	[char] (10)	NOT NULL,
	[KITGubun]	[char] (1)	NOT NULL ,-- Kit ±¸ºÐ(Y:Kit, N:No Kit)
	[ShipQty]	[Qty]		NOT NULL,
	[LastEmp]	[LastEmp]	NULL ,
	[LastDate]	[LastDate]	NULL ,
	CONSTRAINT [PK_TSHIPSHEET_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TSHIPSHEET_INTERFACE].[ShipQty]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSHIPSHEET_INTERFACE].[LastDate]'
GO

setuser
GO


