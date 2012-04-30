-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTKBINCOME_INTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTKBINCOME_INTERFACE]
GO

CREATE TABLE [dbo].[TPARTKBINCOME_INTERFACE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[OrderSeq]		[varchar] (10)	NOT NULL ,
	[SeqNo]			[int]		NOT NULL ,
	[MISFlag]		[char] (1)	NOT NULL ,
	[InterfaceFlag]		[char] (1)	NOT NULL ,
	[AreaCode]		[char] (1)	NULL ,	
	[DivisionCode]		[char] (1)	NULL ,
	[SupplierCode]		[char] (5)	NULL ,
	[ItemCode]		[varchar] (12)	NULL ,
	[PartKBNo]		[char] (11)	NULL ,	
	[PartOrderDate]		[char] (10)	NULL ,
	[RackQty]		[Qty]		NULL ,
	[PartIncomeDate]	[char] (10)	NULL ,
	[PartReceiptDate]	[char] (10)	NULL ,
	[CostGubun]		[char] (1)	NULL ,
	[UseCenter]		[varchar] (5)	NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TPARTKBINCOME_INTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TPARTKBINCOME_INTERFACE].[RackQty]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TPARTKBINCOME_INTERFACE].[LastDate]'
GO

setuser
GO


