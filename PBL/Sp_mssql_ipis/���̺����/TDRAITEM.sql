if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TDRAITEM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TDRAITEM]
GO

CREATE TABLE [dbo].[TDRAITEM] (
	[AreaCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DivisionCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerCode] [varchar] (6) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerItemCode] [varchar] (18) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerItemName] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerDivision] [varchar] (25) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantAddress] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantAddress1] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantCity] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerState] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPostal] [char] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[PlantDock] [varchar] (8) COLLATE Korean_Wansung_CI_AS NULL ,
	[DeliveryLocation] [varchar] (8) COLLATE Korean_Wansung_CI_AS NULL ,
	[RevisionNo] [char] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierCity] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierCity1] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierPostal] [char] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[CountryOfOrigin] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[Inputdate] [LastDate] NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TDRAITEM] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[CustomerCode],
		[CustomerItemCode]
	)  ON [PRIMARY] 
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TDRAITEM].[Inputdate]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TDRAITEM].[LastDate]'
GO

setuser
GO

