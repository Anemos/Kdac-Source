if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTBOMDATA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTBOMDATA]
GO

CREATE TABLE [dbo].[TMSTBOMDATA] (
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[BMDCD]			[varchar] (4)	NOT NULL ,
	[BMDNO]			[varchar] (12)	NOT NULL ,
	[BSERNO]		[int]		NOT NULL ,
	[BPRNO]			[varchar] (12)	NOT NULL ,
	[BCHNO]			[varchar] (12)	NOT NULL ,
	[BLEV]			[int]		NOT NULL ,
	[BLOLE]			[int]		NOT NULL ,
	[BUM]			[varchar] (2)	NOT NULL ,
	[BWOCT]			[varchar] (5)	NOT NULL ,
	[BPRQT]			[numeric](8, 3)	NOT NULL ,
	[BPRQT1]		[numeric](8, 3)	NOT NULL ,
	[BFMDT]			[char] (10)	NOT NULL ,
	[BTODT]			[char] (10)	NOT NULL ,
	[BALCD]			[char] (1)	NOT NULL ,
	[BYOU]			[char] (1)	NOT NULL ,
	CONSTRAINT [PK_TMSTBOMDATA] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[BMDCD],
		[BMDNO],
		[BSERNO]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

