if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMSTROUTING]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMSTROUTING]
GO

CREATE TABLE [dbo].[TMSTROUTING](
	[AreaCode] [char](1) NOT NULL,
	[DivisionCode] [char](1) NOT NULL,
	[ItemCode] [varchar](12) NOT NULL,
	[SubLineCode] [varchar](7) NOT NULL,
	[SubLineNo] [char](1) NOT NULL,
	[ProcessNo] [varchar](7) NOT NULL,
	[ApplyDate] [char](10) NOT NULL,
	[EndDate] [char](10) NULL,
	[ProcessName] [varchar](50) NULL,
	[ProcessSeq] [decimal](3, 0) NULL,
	[WorkCenter] [varchar](5) NULL,
	[GradeGubun] [char](1) NULL,
	[MCGubun] [char](1) NULL,
	[BaseMCWorkTime] [decimal](9, 4) NULL,
	[BaseManualWorkTime] [decimal](9, 4) NULL,
	[BaseWorkTime] [decimal](9, 4) NULL,
	[SideGubun] [char](1) NULL,
	[SideMCWorkTime] [decimal](9, 4) NULL,
	[SideManualWorkTime] [decimal](9, 4) NULL,
	[EmpCount] [decimal](9, 4) NULL,
	[LastEmp] [LastEmp] NULL,
	[LastDate] [LastDate] NULL,
	[BasePower] [decimal](10, 5) NULL,
 CONSTRAINT [PK_TMSTROUTING] PRIMARY KEY CLUSTERED 
(
	[AreaCode] ASC,
	[DivisionCode] ASC,
	[ItemCode] ASC,
	[SubLineCode] ASC,
	[SubLineNo] ASC,
	[ProcessNo] ASC,
	[ApplyDate] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

setuser
GO

