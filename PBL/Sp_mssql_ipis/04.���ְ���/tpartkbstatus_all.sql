CREATE TABLE [TPARTKBSTATUS_ALL] (
	[PartKBNo] [char] (11) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[AreaCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DivisionCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[SupplierCode] [char] (5) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ItemCode] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ApplyFrom] [char] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[PartType] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[RePrintFlag] [NFlag] NOT NULL ,
	[RePrintCount] [int] NOT NULL ,
	[PartKBGubun] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[KBActiveGubun] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[PartKBStatus] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	[KBOrderPossible] [NFlag] NOT NULL ,
	[RackQty] [Qty] NOT NULL ,
	[OrderChangeFlag] [NFlag] NOT NULL ,
	[PartOrderCancel] [NFlag] NOT NULL ,
	[PartReceiptCancel] [NFlag] NOT NULL ,
	[UseCenterGubun] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	[UseCenter] [varchar] (5) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartObeyDateFlag] [bit] NOT NULL  DEFAULT (0),
	[PartObeyTimeFlag] [bit] NOT NULL  DEFAULT (0),
	[PartOrderDate] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartOrderTime] [datetime] NULL ,
	[PartForecastDate] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartForecastEditNo] [smallint] NULL ,
	[PartForecastTime] [datetime] NULL ,
	[PartReceiptDate] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartEditNo] [smallint] NULL ,
	[PartReceiptTime] [datetime] NULL ,
	[PartIncomeDate] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartIncomeTime] [datetime] NULL ,
	[PartOrderNo] [char] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[DeliveryNo] [char] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[BuyBackNo] [char] (11) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartKBCreateDate] [datetime] NOT NULL ,
	[PartKBPrintDate] [datetime] NULL ,
	[OrderChangeTime] [datetime] NULL ,
	[OrderChangeCode] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[ChangeForecastDate] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[ChangeForecastEditNo] [smallint] NULL ,
	[ChangeForecastTime] [datetime] NULL ,
	[OrderSeq] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL ,
	CONSTRAINT [PK_TPARTKBSTATUS_ALL] PRIMARY KEY  CLUSTERED 
	(
		[PartKBNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO



