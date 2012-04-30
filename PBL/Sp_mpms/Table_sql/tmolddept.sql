/* ************************** TMOLDDEPT table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMOLDDEPT]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMOLDDEPT]
GO

CREATE TABLE [dbo].[TMOLDDEPT] (
	[DeptCode]		[char]	  (4)     NOT NULL,
	[DeptName]		[varchar]	(40)	  NULL,
	[ApplyFrom]		[char]    (10)    NULL,
	[ApplyTo]			[char] 		(10)		NULL,
	[LastEmp]			[char] 		(6)		  NULL,
	[LastDate]		[datetime] default getdate()	  NULL 
	CONSTRAINT [PK_TMOLDDEPT] PRIMARY KEY  CLUSTERED 
	(
		[DeptCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
