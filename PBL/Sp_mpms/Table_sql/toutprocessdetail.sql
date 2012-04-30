/* ************************** TOUTPROCESSDETAIL table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TOUTPROCESSDETAIL]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TOUTPROCESSDETAIL]
GO

CREATE TABLE [dbo].[TOUTPROCESSDETAIL] (
	[OrderNo]			  [char]		  (8)			NOT NULL,
	[PartNo]			  [char] 		  (6) 		NOT NULL,
	[OutSerial]		  [char] 		  (2) 		NOT NULL,
	[OperNo]        [char]      (3)     NOT NULL,
	[ApplyQty]      [numeric]   (5,0)   NULL,
	[StdTime]			  [numeric]   (10,0) 	NULL,
	[OutCostRatio]	[numeric]   (10,0) 	NULL,
	[MatCost]	      [numeric]   (10,0) 	NULL,
	[MchCost]       [numeric]   (10,0) 	NULL,
	[OutCost]	      [numeric]   (10,0) 	NULL,
	[LastEmp]			  [char] 		  (6)			NULL,
	[LastDate]		  [datetime] 	default getdate() 
	CONSTRAINT [PK_TOUTPROCESSDETAIL] PRIMARY KEY  CLUSTERED 
	(
		[OrderNo], [PartNo], [OutSerial], [OperNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
