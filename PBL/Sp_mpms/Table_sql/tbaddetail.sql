/* ************************** TBADDETAIL table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TBADDETAIL]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TBADDETAIL]
GO

CREATE TABLE [dbo].[TBADDETAIL] (
  [Stype]       [char]    (2)     NOT NULL,
  [Srno]        [char]    (10)    NOT NULL,
	[OrderNo]			[char]	  (8)		  NOT NULL,
	[PartNo]			[char]		(6)			NOT NULL,
	[BadOperNo]		[char] 		(3) 		NOT NULL,
	[BadDate]     [char]    (8)   	NOT NULL,
	[ReOperNo]		[char]		(3)			NOT NULL,
	[WcCode]      [char]    (3)     NULL,
	[MchNo]       [char]    (5)     NULL,
	[BadTime]			[numeric]	(5,0)  	NULL,
	[ReworkFlag]	[char] 		(1) 		NULL,
	[LastEmp]			[char] 		(6)			NULL,
	[LastDate]		[datetime] 				NULL 
	CONSTRAINT [PK_TBADDETAIL] PRIMARY KEY  CLUSTERED 
	(
		[Stype], [Srno], [ReOperNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
