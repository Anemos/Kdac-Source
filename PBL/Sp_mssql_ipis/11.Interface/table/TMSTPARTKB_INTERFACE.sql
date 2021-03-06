-- interface 용 : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTPARTKB_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTPARTKB_INTERFACE]
GO

CREATE TABLE [dbo].[TMSTPARTKB_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[ItemCode]		[varchar] (12)	NOT NULL ,
	[ApplyFrom]		[char] (10)	NOT NULL ,
	[SeqNo]			[int]		NOT NULL ,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
	[LastEmp]		[char] (6)	NULL ,
	[LastDate]		[datetime]	NULL ,
	CONSTRAINT [PK_TMSTPARTKB_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMSTPARTKB_INTERFACE].[LastDate]'
GO

setuser
GO
