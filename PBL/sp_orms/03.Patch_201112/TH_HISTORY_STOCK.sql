/* ************************** TH_HISTORY_STOCK table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TH_HISTORY_STOCK]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TH_HISTORY_STOCK]
GO

CREATE TABLE [dbo].[TH_HISTORY_STOCK] (
	[CreateDate]		[datetime]		NOT NULL,
	[ModelCode]			[varchar]   (40) 		NULL,
	[ModelName]		  [varchar]   (40) 		NULL,
	[PlanQty]		    [integer]    NULL,         
	[ProdQty]     [integer]    NULL,
	[WorkRate]   [numeric]   (12,1)  NULL,
	[BofRate]     [numeric]   (12,1)  NULL,
	[TargetRate]   [numeric]   (12,1)  NULL,
	[InputMan]     [numeric]   (12,1)  NULL,
	[CycleTime]   [numeric]   (12,1)  NULL,
	[CdName]			[varchar]   (60) 		NULL,
	[Remark]			[varchar]   (60) 		NULL,
	[Etc01]			[varchar]   (60) 		NULL
	CONSTRAINT [PK_TH_HISTORY_STOCK] PRIMARY KEY  CLUSTERED 
	(
		[CreateDate]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO
