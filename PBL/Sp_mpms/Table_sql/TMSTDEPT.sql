if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTDEPT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTDEPT]
GO

CREATE TABLE [dbo].[TMSTDEPT] (
	[DeptCode]		[char] (4)	NOT NULL ,
	[DeptName]		[varchar] (40)	NOT NULL ,
	[ApplyFrom]		[char] (10)	NOT NULL ,
	[ApplyTo]		[char] (10)	NOT NULL ,
	[DeptGubun]		[char] (1)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[DirectGubun]		[char] (1)	NULL ,
	[DeptName1]		[varchar] (20)	NULL ,
	[DeptName2]		[varchar] (20)	NULL ,
	[DeptName3]		[varchar] (20)	NULL ,
	[DeptName4]		[varchar] (20)	NULL ,
	[DeptEmpNo]		[varchar] (6)	NULL ,
	[DeptEmpName]		[varchar] (12)	NULL ,
	[DeptShortName1]	[varchar] (10)	NULL ,
	[DeptShortName2]	[varchar] (10)	NULL ,
	[DeptShortName3]	[varchar] (10)	NULL ,
	[DeptShortName4]	[varchar] (10)	NULL ,
	[LastEmp]		[varchar]	(6) NULL ,
	[LastDate]		[datetime]	NULL ,
	CONSTRAINT [PK_TMSTDEPT] PRIMARY KEY  CLUSTERED 
	(
		[DeptCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

