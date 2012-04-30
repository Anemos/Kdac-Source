-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSHIPINV_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSHIPINV_INTERFACE]
GO

CREATE TABLE [dbo].[TSHIPINV_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[MoveConfirmDate]	[char] (10)	NOT NULL ,
	[MoveRequireNo]		[varchar] (11)	NOT NULL ,
	[SeqNo]			[int]		NOT NULL,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
	[TruckLoadQty]		[int]		NULL ,
	[CheckNo]		[char] (2)	NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TSHIPINV_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSHIPINV_INTERFACE].[LastDate]'
GO

setuser
GO


