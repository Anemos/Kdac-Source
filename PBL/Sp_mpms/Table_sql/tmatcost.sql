/* ************************** TMATCOST table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMATCOST]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMATCOST]
GO

CREATE TABLE [dbo].[TMATCOST] (
  [YearMm]      [char]      (6)     NOT NULL,
	[OrderNo]			[char]		  (8)			NOT NULL,
	[PartNo]			[char] 		  (6) 		NOT NULL,
	[JobHour]     [numeric]   (6,1)   NULL,
	[HeatCost]    [numeric]   (10,0)  NULL,
	[OutCost]     [numeric]   (10,0)  NULL,
	[MatCost]     [numeric]   (10,0)  NULL,
	[ManCost]     [numeric]   (10,0)  NULL,
	[MchCost]     [numeric]   (10,0)  NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TMATCOST] PRIMARY KEY  CLUSTERED 
	(
		[YearMm], [OrderNo], [PartNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
