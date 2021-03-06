-- interface 용 : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TQBUSINESSTEMP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TQBUSINESSTEMP]
GO

CREATE TABLE [dbo].[TQBUSINESSTEMP] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[AREACODE] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DIVISIONCODE] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[SLNO] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DELIVERYDATE] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[SUPPLIERCODE] [char] (5) COLLATE Korean_Wansung_CI_AS NULL ,
	[ITEMCODE] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[SUPPLIERDELIVERYQTY] [int] NULL ,
	[JUDGEFLAG] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[GOODQTY] [int] NULL ,
	[BADQTY] [int] NULL ,
	[InterfaceFlag] [char] (1) NOT NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TQBUSINESSTEMP] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TQBUSINESSTEMP].[LastDate]'
GO

setuser
GO

