-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTKBDAYORDER_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTKBDAYORDER_INTERFACE]
GO

CREATE TABLE [dbo].[TPARTKBDAYORDER_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[SupplierCode]		[varchar] (5)		NOT NULL ,
	[PartKBNo]		[varchar] (11)		NOT NULL ,
	[OrderSeq]		[varchar] (10)		NOT NULL ,
	[AreaCode]		[char] (1)		NOT NULL ,
	[DivisionCode]		[char] (1)		NOT NULL ,
	[ItemCode]		[varchar] (12)		NOT NULL ,
	[RackCode]		[varchar] (5)		NOT NULL ,
	[SupplyTerm]		[Smallint]		NOT NULL ,
	[SupplyEditNo]		[Smallint]		NOT NULL ,
	[SupplyCycle]		[Smallint]		NOT NULL ,
	[UseCenter]		[varchar] (5)		NOT NULL ,
	[RackQty]		[int]			NOT NULL ,
	[PartOrderDate]		[char] (10)		NOT NULL ,
	[PartForecastDate]	[char] (10)		NOT NULL ,
	[PartForecastTime]	[datetime] 		NOT NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TPARTKBDAYORDER_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TPARTKBDAYORDER_INTERFACE].[LastDate]'
GO

setuser
GO


