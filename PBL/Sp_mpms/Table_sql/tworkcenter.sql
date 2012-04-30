/* ************************** TWORKCENTER table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TWORKCENTER]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TWORKCENTER]
GO

CREATE TABLE [dbo].[TWORKCENTER] (
	[WcCode]		   [char]	  (3)   NOT NULL,
	[WcName]			 [varchar]	(30)	NOT NULL,
	[WcGubun]			 [char] 		(1) 	NOT NULL,
	[WcSerial]     [int]           NULL,
	[WgCode]       [char]    (5)   NULL,
	[DisplayCount] [int]          NULL,
	[LastEmp]			 [char] 		(6)		NULL,
	[LastDate]		 [datetime] 			NULL 
	CONSTRAINT [PK_TWORKCENTER] PRIMARY KEY  CLUSTERED 
	(
		[WcCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
