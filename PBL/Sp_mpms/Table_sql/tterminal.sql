/* ************************** TTERMINAL table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTERMINAL]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTERMINAL]
GO

CREATE TABLE [dbo].[TTERMINAL] (
	[TrmCode]		  [char]	  (5)   NOT NULL,
	[TrmName]			[varchar]	(30)	NULL,
	[IpAddress]   [varchar] (30)  NULL,
	[TrmEtc]			[varchar] (255) NULL,
	[LastEmp]			[char] 		(6)		NULL,
	[LastDate]		[datetime] default getdate()	NULL 
	CONSTRAINT [PK_TTERMINAL] PRIMARY KEY  CLUSTERED 
	(
		[TrmCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
