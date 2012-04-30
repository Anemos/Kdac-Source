if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTEMP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTEMP]
GO

CREATE TABLE [dbo].[TMSTEMP] (
	[EmpNo]		[varchar] (6)	NOT NULL ,
	[EmpName]	[varchar] (10)	NULL ,
	[EmpNameEng]	[varchar] (30)	NULL ,
	[DeptCode]	[varchar] (5)	NOT NULL ,
	[EmpGubun]	[varchar] (1)	NULL ,
	[EmpJikchek]	[varchar] (2)	NULL ,
	[RetireDate]	[varchar] (10)	NULL ,
	[EmpClass]	[varchar] (2)	NULL ,
	[EmpExtd]	[varchar] (10)	NULL ,
	[ChangeEmp]	[varchar] (6)	NULL ,
	[ChangeDate]	[varchar] (10)	NULL ,
	[RetireGubun]	[varchar] (1)	NULL ,
	[EmpBonbu]	[varchar] (1)	NULL ,
	[EmpIntDept]	[varchar] (4)	NULL ,
	[EmpLevel]	[varchar] (4)	NULL ,
	[EmpEnterDate]	[varchar] (10)	NULL ,
	[EmpClassDate]	[varchar] (10)	NULL ,
	[EmpBirthDate]	[varchar] (10)	NULL ,
	[LastEmp]	[varchar]	(6) NULL ,
	[LastDate]	[datetime]	NULL ,
	CONSTRAINT [PK_TMSTEMP] PRIMARY KEY  CLUSTERED 
	(
		[EmpNo]
	)  ON [PRIMARY]
) ON [PRIMARY]
GO

