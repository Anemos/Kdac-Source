-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPLANDAY_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPLANDAY_INTERFACE]
GO

CREATE TABLE [dbo].[TPLANDAY_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[PlanDay]		[varchar] (8)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[ItemCode]		[varchar] (12)	NOT NULL ,
	[PlanQty]		[int]		NOT NULL ,
	[ChangeQty]		[int]		NOT NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TPLANDAY_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TPLANDAY_INTERFACE].[LastDate]'
GO

setuser
GO


