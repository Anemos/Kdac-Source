/* ************************** TBADHEAD table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TBADHEAD]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TBADHEAD]
GO

CREATE TABLE [dbo].[TBADHEAD] (
  [Stype]       [char]    (2)     NOT NULL,
  [Srno]        [char]    (10)    NOT NULL,
	[OrderNo]			[char]	  (8)		  NOT NULL,
	[PartNo]			[char]		(6)			NOT NULL,
	[BadOperNo]		[char] 		(3) 		NOT NULL,
	[BadDate]     [char]    (8)   	NOT NULL,
	[WcCode]      [char]    (3)     NULL,
	[WorkMan]  		[char]    (6)     NULL,
	[FindMan]			[char]    (8)     NULL,
	[PlanQty]			[numeric]	(5,0)  	NULL,
	[ScrapQty]		[numeric] (5,0) 	NULL,
	[BadReason]		[varchar]	(255)		NULL,
	[ResultFlag]  [char]    (1)     NULL,
	[LastEmp]			[char] 		(6)			NULL,
	[LastDate]		[datetime] 				NULL 
	CONSTRAINT [PK_TBADHEAD] PRIMARY KEY  CLUSTERED 
	(
		[Stype], [Srno]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
