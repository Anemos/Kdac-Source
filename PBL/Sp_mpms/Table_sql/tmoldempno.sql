/* ************************** TMOLDEMPNO table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMOLDEMPNO]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMOLDEMPNO]
GO

CREATE TABLE [dbo].[TMOLDEMPNO] (
	[EmpNo]		    [varchar]	(6)     NOT NULL,
	[EmpName]		  [varchar]	(10)	  NULL,
	[DeptCode]		[char]    (4)     NULL,
	[WcCode]			[char] 		(3)		  NULL,
	[ApplyFrom]		[char]    (10)    NULL,
	[ApplyTo]			[char] 		(10)		NULL,
	[LastEmp]			[char] 		(6)		  NULL,
	[LastDate]		[datetime] default getdate()	NULL 
	CONSTRAINT [PK_TMOLDEMPNO] PRIMARY KEY  CLUSTERED 
	(
		[EmpNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
