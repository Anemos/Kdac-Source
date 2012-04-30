if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TDRACUSTOMER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TDRACUSTOMER]
GO

CREATE TABLE [dbo].[TDRACUSTOMER] (
	[CustomerCode] [varchar] (6) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[SupplierCode] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierName] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[Inputdate] [LastDate] NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TDRACUSTOMER] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[CustomerCode]
	)  ON [PRIMARY] 
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TDRACUSTOMER].[Inputdate]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TDRACUSTOMER].[LastDate]'
GO

setuser
GO

