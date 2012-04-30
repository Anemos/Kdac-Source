if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTPROJECT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTPROJECT]
GO

CREATE TABLE [dbo].[TMSTPROJECT] (
	[ProjectNo]		[varchar] (10)	NOT NULL ,
	[ProjectName]		[varchar] (80)	NOT NULL ,
	[FromDate]		[char] (10)	NOT NULL ,
	[ToDate]		[char] (10)	NOT NULL ,
	[ComDate]		[char] (10)	NOT NULL ,
	[StCd]			[char] (1)	NOT NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TMSTPROJECT] PRIMARY KEY  CLUSTERED 
	(
		[ProjectNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMSTPROJECT].[LastDate]'
GO

setuser
GO


