-- interface 용 : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSRCONFIRM01_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSRCONFIRM01_INTERFACE]
GO

-- 생관 SR 확정
CREATE TABLE [dbo].[TSRCONFIRM01_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[ConfirmDate]		[char] (10)	NOT NULL ,
	[SRNo]			[varchar] (11)	NOT NULL ,
	[SeqNo]		        [int]    	NOT NULL ,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
        [AreaCode]              [char] (1)	NOT NULL,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TSRCONFIRM01_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TSRCONFIRM01_INTERFACE].[LastDate]'
GO

setuser
GO