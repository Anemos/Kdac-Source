if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTBOM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTBOM]
GO

CREATE TABLE [dbo].[TMSTBOM] (
	[AreaCode]		[char] (1)	NOT NULL ,
	[DivisionCode]		[char] (1)	NOT NULL ,
	[BOMPItemNo]		[varchar] (12)	NOT NULL ,
	[Routing]		[char] (4)	NOT NULL ,
	[BOMCItemNo]		[varchar] (12)	NOT NULL ,
	[BOMChangeDate]		[char] (10)	NOT NULL ,
	[BOMLUnit]		[smallint]	NULL ,
	[BOMEUnit]		[smallint]	NULL ,
	[BOMWorkCenter]		[varchar] (5)	NULL ,
	[ApplyFrom]		[char] (10)	NULL ,
	[ApplyTo]		[char] (10)	NULL ,
	[BOMAreaCode]		[char] (1)	NULL ,
	[BOMDivisionCode]	[char] (1)	NULL ,
	[CostGubun]		[char] (1)	NULL ,
	[EBOMExistFlag]		[char] (1)	NULL ,
	[BOMFirstInputDate]	[char] (10)	NULL ,
	[EmpNo]			[varchar] (6)	NULL ,
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TMSTBOM] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[BOMPItemNo],
		[Routing],
		[BOMCItemNo],
		[BOMChangeDate]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

 CREATE  INDEX [IK_TMSTBOM_CITEM] ON
 	[dbo].[TMSTBOM]([AreaCode], [DivisionCode], [BOMCItemNo],
 				[BOMPItemNo]) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMSTBOM].[LastDate]'
GO

setuser
GO


