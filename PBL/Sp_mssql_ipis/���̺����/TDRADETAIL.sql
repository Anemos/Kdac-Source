if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TDRADETAIL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TDRADETAIL]
GO

CREATE TABLE [dbo].[TDRADETAIL] (
	[AreaCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DivisionCode] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerCode] [varchar] (6) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CustomerItemCode] [varchar] (18) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[SerialNoFrom] [smallint] NOT NULL ,
	[LabelCount] [smallint] NULL ,
	[LotNo] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[ShipQTY] [int] NULL ,
	[PuchaseNo] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[TraceDate] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[PackingListNo] [char] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[Inputdate] [LastDate] NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TDRADETAIL] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[CustomerCode],
		[CustomerItemCode],
		[SerialNoFrom]
	)  ON [PRIMARY] 
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TDRADETAIL].[Inputdate]'
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TDRADETAIL].[LastDate]'
GO

setuser
GO