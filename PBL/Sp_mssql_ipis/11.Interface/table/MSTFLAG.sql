if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MSTFLAG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MSTFLAG]
GO

CREATE TABLE [dbo].[MSTFLAG] (
	[ActionName]		[varchar] (30)	NOT NULL ,
	[Flag]			[char] (1)	NOT NULL ,
	[Note]			[varchar] (100)	NOT NULL ,
	[LastEmp]		[varchar] (30)	NULL ,
	[LastDate]		[lastdate]	NULL ,
	CONSTRAINT [PK_MSTFLAG] PRIMARY KEY  CLUSTERED 
	(
		[ActionName]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO


-- InterfaceGubun : U(Upload), D(Download)

