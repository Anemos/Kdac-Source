/* ************************** TROUTING table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TROUTING]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TROUTING]
GO

CREATE TABLE [dbo].[TROUTING] (
	[OperNo]			[char]	    (3)		  NOT NULL,
	[OrderNo]			[char]		  (8)			NOT NULL,
	[PartNo]			[char] 		  (6) 		NOT NULL,
	[WcCode]			[char]      (3)     NULL,
	[WorkStatus]  [char]      (1)     NULL,
	[OutFlag]     [char]      (1)   	NULL,
	[WorkStart]		[datetime]      		NULL,
	[StdTime]			[numeric]   (10,0) 	NULL,
	[StdHeatCost] [numeric]   (10,0)  NULL,
  [StdOutCost]  [numeric]   (10,0)  NULL,
	[WorkMatter]	[varchar]   (255) 	NULL,
	[ResultFlag]  [char]      (1)     NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TROUTING] PRIMARY KEY  CLUSTERED 
	(
		[OperNo], [OrderNo], [PartNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
