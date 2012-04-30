/* ************************** TTERMINALWORKGROUP table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTERMINALWORKGROUP]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTERMINALWORKGROUP]
GO

CREATE TABLE [dbo].[TTERMINALWORKGROUP] (
	[TrmCode]		  [char]	  (5)   NOT NULL,
	[WgCode]		  [char]	  (5)   NOT NULL,
	[LastEmp]			[char] 		(6)		NULL,
	[LastDate]		[datetime] 	default getdate()		NULL 
	CONSTRAINT [PK_TTERMINALWORKGROUP] PRIMARY KEY  CLUSTERED 
	(
		[TrmCode],[WgCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
