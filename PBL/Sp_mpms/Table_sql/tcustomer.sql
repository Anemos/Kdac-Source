/* ************************** TCUSTOMER table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TCUSTOMER]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TCUSTOMER]
GO

CREATE TABLE [dbo].[TCUSTOMER] (
	[CustCode]		[char]	  (5)   NOT NULL,
	[CustName]		[varchar]	(50)	NOT NULL,
	[CustNumber]	[varchar] (10) 	NULL,
	[CustBoss]		[varchar] (20)	NULL ,
	[Address]			[varchar] (255)	NULL ,
	[FaxNo]			  [varchar] (20)	NULL ,
	[TelNo]			  [varchar] (20)	NULL ,
	[LastEmp]			[char] 		(6)		NULL ,
	[LastDate]		[datetime] 			NULL 
	CONSTRAINT [PK_TCUSTOMER] PRIMARY KEY  CLUSTERED 
	(
		[CustCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
