/* ************************** TMACHINE table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMACHINE]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMACHINE]
GO

CREATE TABLE [dbo].[TMACHINE] (
	[MchNo]		  	[char]	  (5)   NOT NULL,
	[WcCode]			[char]		(3)		NOT NULL,
	[MchName]			[varchar] (50) 	NULL,
	[HourCost]		[numeric]	(8,0) NULL,
	[Shift]				[numeric]	(5,0)	NULL,
	[ShiftLength]	[numeric] (5,0) NULL,
	[LastEmp]			[char] 		(6)		NULL ,
	[LastDate]		[datetime] 			NULL 
	CONSTRAINT [PK_TMACHINE] PRIMARY KEY  CLUSTERED 
	(
		[MchNo], [WcCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
