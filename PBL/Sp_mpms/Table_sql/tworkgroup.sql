/* ************************** TWORKGROUP table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TWORKGROUP]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TWORKGROUP]
GO

CREATE TABLE [dbo].[TWORKGROUP] (
	[WgCode]		  [char]	  (5)   NOT NULL,
	[WgName]			[varchar]	(30)	NULL,
	[WgEtc]			  [varchar] (255) NULL,
	[LastEmp]			[char] 		(6)		NULL,
	[LastDate]		[datetime] 	default getdate()		NULL 
	CONSTRAINT [PK_TWORKGROUP] PRIMARY KEY  CLUSTERED 
	(
		[WgCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
