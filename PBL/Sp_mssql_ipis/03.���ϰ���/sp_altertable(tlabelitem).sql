CREATE TABLE [TLabelItem] (
	[AreaCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DivisionCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerCode] [varchar] (6) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerItemCode] [varchar] (18) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ItemCode] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[Unit] [char] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerDivision] [varchar] (25) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantAddress] [varchar] (25) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantAddress2] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantCity] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerState] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPostal] [char] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[PlantDock] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[DeliveryLocation] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[RevisionNo] [char] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierCity] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierPostal] [char] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[CountryOfOrigin] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[LabelGubun] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[Bar2dCheck] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerNo] [varchar] (6) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierNo] [varchar] (6) COLLATE Korean_Wansung_CI_AS NULL ,
	[PartDesc] [varchar] (70) COLLATE Korean_Wansung_CI_AS NULL ,
	[EngAlert] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[ContainerNo] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[GrossWgt] [int] NULL ,
	[DockCode] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[StandardPackQty] [int] NULL ,
	[WorkCenter] [varchar] (5) COLLATE Korean_Wansung_CI_AS NULL ,
	[Shift] [int] NULL ,
	[LotSize] [int] NULL ,
	[Inputdate] [LastDate] NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL ,
	CONSTRAINT [PK__TLabelItem__5A702B23] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[CustomerCode],
		[CustomerItemCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO


CREATE TABLE [TLabelItem] (
	[AreaCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DivisionCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerCode] [varchar] (6) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerItemCode] [varchar] (18) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ItemCode] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[Unit] [char] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerDivision] [varchar] (25) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantAddress] [varchar] (25) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPlantCity] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerState] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[CustomerPostal] [char] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[PlantDock] [varchar] (8) COLLATE Korean_Wansung_CI_AS NULL ,
	[DeliveryLocation] [varchar] (8) COLLATE Korean_Wansung_CI_AS NULL ,
	[RevisionNo] [char] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierCity] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[SupplierPostal] [char] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[CountryOfOrigin] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[LabelGubun] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[Bar2dCheck] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[Inputdate] [LastDate] NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL ,
	CONSTRAINT [PK__TLabelItem__2197A07A] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[CustomerCode],
		[CustomerItemCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

