-- interface 侩 : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSHIPETC_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSHIPETC_INTERFACE]
GO

CREATE TABLE [dbo].[TSHIPETC_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[InputDate]		[char] (10)	NOT NULL ,
	[InputFlag]		[char] (1)	NOT NULL ,
	[ConfirmNo]		[varchar] (20)	NOT NULL ,
	[SeqNo]			[int]		NOT NULL,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
        [DeptCode]		[char] (4)	NULL ,
	[ProjectNo]		[varchar] (10)	NULL ,
	[ItemCode]		[varchar] (12)	NULL ,
	[InvGubunFlag]		[NFlag]		NOT NULL ,-- N:沥前,R:夸荐府,D:企前
	[EtcQty]		[Qty]		NOT NULL ,
	[Reason]		[varchar] (100)	NULL,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TSHIPETC_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_FLAG_NO]', N'[TSHIPETC_INTERFACE].[InvGubunFlag]'
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TSHIPETC_INTERFACE].[EtcQty]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSHIPETC_INTERFACE].[LastDate]'
GO

setuser
GO


