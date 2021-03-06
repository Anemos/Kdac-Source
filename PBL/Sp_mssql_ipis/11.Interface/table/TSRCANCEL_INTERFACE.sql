-- interface 용 : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSRCANCEL_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSRCANCEL_INTERFACE]
GO

-- 영업 SR 취소확정
CREATE TABLE [dbo].[TSRCANCEL_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[CancelDate]		[char] (10)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[SRNo]			[varchar] (8)	NOT NULL ,	-- SR전산번호
	[CheckSRNo]		[varchar] (11)	NOT NULL ,	-- SR번호 
	[CancelGubun]		[char] (1)	NOT NULL ,
	[SeqNo]			[int]		NOT NULL,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
	[ItemCode]		[varchar] (12)	NOT NULL ,
	[ConfirmFlag]		[char] (1)	NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TSRCANCEL_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSRCANCEL_INTERFACE].[LastDate]'
GO

setuser
GO


