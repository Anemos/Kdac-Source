-- interface 侩 : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSHIPBACK_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSHIPBACK_INTERFACE]
GO

CREATE TABLE [dbo].[TSHIPBACK_INTERFACE] (
	[LogID] 	[int] IDENTITY(1,1)	NOT NULL ,
	[CSRNO]			[varchar] (8)	NOT NULL ,
	[CSRNO1]		[varchar] (2)	NOT NULL ,
	[CSRNO2]		[varchar] (2)	NOT NULL ,
	[SRNo]			[varchar] (11)	NOT NULL ,
	[BillNo]		[varchar] (12)	NOT NULL ,
	[InvGubunFlag]		[char] (1)	NOT NULL ,-- N:沥前,R:夸荐府,D:企前
	[SeqNo]			[int]		NOT NULL,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
	[CancelConfirmDate]	[varchar] (10)	NULL ,
	[CancelQty]		[Qty]		NOT NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TSHIPBACK_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TSHIPBACK_INTERFACE].[CancelQty]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSHIPBACK_INTERFACE].[LastDate]'
GO

setuser
GO


