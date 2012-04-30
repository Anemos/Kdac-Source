if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTPARTKB]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTPARTKB]
GO

CREATE TABLE [dbo].[TMSTPARTKB] (
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[SupplierCode]		[char] (5)	NOT NULL ,
	[ItemCode]		[varchar] (12)	NOT NULL ,
	[ApplyFrom]		[char] (10)	NOT NULL ,
	[PartType]		[char] (1)	NOT NULL ,
	[ChangeFlag]		[YFlag]		NOT NULL ,
	[PartModelID]		[varchar] (4)	NOT NULL ,
	[PartID]		[char] (2)	NOT NULL ,
	[UseCenterGubun]	[char] (1)	NOT NULL ,
	[UseCenter]		[varchar] (5)	NULL ,
	[CostGubun]		[char] (1)	NULL ,
	[RackQty]		[Qty]		NOT NULL ,
	[RackCode]		[char] (5)	NOT NULL ,
	[StockGubun]		[char] (1)	NOT NULL ,
	[ReceiptLocation]	[varchar] (4)	NOT NULL ,
	[MailBoxNo]		[smallint]	NOT NULL ,
	[SafetyStock]		[numeric](3, 1)	NOT NULL ,
	[UseFlag]		[YFlag]		NOT NULL ,
	[AutoReorderFlag]	[YFlag]		NOT NULL ,
	[KBUseFlag]		[YFlag]		NOT NULL ,
	[ChangeDate]		[char] (10)	NOT NULL ,
	[NormalKBSN]		[char] (11)	NOT NULL ,
	[TempKBSN]		[char] (11)	NOT NULL ,
	[PartKBPrintCount]	[Qty]		NOT NULL ,
	[PartKBActiveCount]	[Qty]		NOT NULL ,
	[PartKBPlanCount]	[Qty]		NOT NULL ,
	[LastEmp]		[char] (6)	NULL ,
	[LastDate]		[datetime]	NULL ,
	CONSTRAINT [PK_TMSTPARTKB] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[SupplierCode],
		[ItemCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_FLAG_YES]', N'[TMSTPARTKB].[ChangeFlag]'
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TMSTPARTKB].[RackQty]'
GO

EXEC sp_bindefault N'[dbo].[DF_FLAG_YES]', N'[TMSTPARTKB].[UseFlag]'
GO

EXEC sp_bindefault N'[dbo].[DF_FLAG_YES]', N'[TMSTPARTKB].[AutoReorderFlag]'
GO

EXEC sp_bindefault N'[dbo].[DF_FLAG_YES]', N'[TMSTPARTKB].[KBUseFlag]'
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TMSTPARTKB].[PartKBPrintCount]'
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TMSTPARTKB].[PartKBActiveCount]'
GO

EXEC sp_bindefault N'[dbo].[DF_QTY]', N'[TMSTPARTKB].[PartKBPlanCount]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMSTPARTKB].[LastDate]'
GO

setuser
GO
