/* ************************** TPARTLIST table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTLIST]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTLIST]
GO

CREATE TABLE [dbo].[TPARTLIST] (
	[DetailNo]		[int]	  		   		NOT NULL,
	[OrderNo]			[char]		(8)			NOT NULL,
	[RevNo]				[char] 		(2) 		NULL,
	[PartName]		[varchar]	(50)  	NULL,
	[PartNo]			[char] 		(6) 		NOT NULL,
	[SheetNo]			[int]							NOT NULL,
	[Spec]				[varchar] (100) 	NULL,
	[Material]		[varchar]	(20) 		NULL,
	[Qty1]				[numeric]	(5,0)		NULL,
	[Qty2]				[numeric] (5,0) 	NULL,
	[Weight]			[numeric]	(8,1) 	NULL,
	[PartCost]		[numeric]	(10,0)	NULL,
	[Remark]			[varchar] (255) 	NULL,
	[SerialNo]    [int]             NULL,
	[LastEmp]			[char] 		(6)			NULL,
	[LastDate]		[datetime] Default getdate() 
	CONSTRAINT [PK_TPARTLIST] PRIMARY KEY  CLUSTERED 
	(
		[DetailNo], [OrderNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
