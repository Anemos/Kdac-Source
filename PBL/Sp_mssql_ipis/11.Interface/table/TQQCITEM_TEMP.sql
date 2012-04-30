-- interface ¿ë : interface db

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TQQCITEM_TEMP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TQQCITEM_TEMP]
GO

CREATE TABLE [dbo].[TQQCITEM_TEMP] (
	[LogID] [int] IDENTITY(1,1)	NOT NULL ,
	[AREACODE] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[DIVISIONCODE] [char] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ITEMCODE] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[SUPPLIERCODE] [char] (5) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[PRODUCTGROUP] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[MODELGROUP] [char] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[APPLYDATEFROM] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[APPLYDATETO] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[RECSTATUS] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[QCGUBUN] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[UploadFlag] [char] (1) NOT NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TQQCITEM_TEMP] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TQQCITEM_TEMP].[LastDate]'
GO
