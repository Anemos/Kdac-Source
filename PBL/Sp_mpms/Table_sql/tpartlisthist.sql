/* ************************** TPARTLISTHIST table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTLISTHIST]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTLISTHIST]
GO

CREATE TABLE [dbo].[TPARTLISTHIST] (
	[DetailNo]		[int]	  		   		NOT NULL,
	[OrderNo]			[char]		(8)			NOT NULL,
	[RevNo]				[char] 		(2) 		NOT NULL,
	[RevEmp]			[char]    (6)     NULL,
	[RevDate]     [char]    (8)     NULL,
	[PartName]		[varchar]	(50)  	NULL,
	[PartNo]			[char] 		(6) 	  NULL,
	[SheetNo]			[int]							NULL,
	[Spec]				[varchar] (100) 	NULL,
	[Material]		[varchar]	(20) 		NULL,
	[Qty1]				[numeric]	(5,0)		NULL,
	[Qty2]				[numeric] (5,0) 	NULL,
	[Weight]			[numeric]	(8,1) 	NULL,
	[PartCost]		[numeric]	(11,2)	NULL,
	[Remark]			[varchar] (255) 	NULL,
	[SerialNo]    [int]             NULL,
	[LastEmp]			[char] 		(6)			NULL,
	[LastDate]		[datetime] Default getdate() 
	CONSTRAINT [PK_TPARTLISTHIST] PRIMARY KEY  CLUSTERED 
	(
		[DetailNo], [OrderNo], [RevNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
