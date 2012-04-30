if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TINTERFACE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TINTERFACE]
GO

CREATE TABLE [dbo].[TINTERFACE] (
	[InterfaceID]		[smallint]	NOT NULL ,
	[InterfaceGubun]	[char] (1)	NOT NULL ,
	[InterfaceName]		[varchar] (30)	NOT NULL ,
	[Source]		[varchar] (20)	NOT NULL ,
	[Destination]		[varchar] (20)	NOT NULL ,
	[CycleOption]		[char] (2)	NULL ,
	[CycleTime]		[smallint]	NULL ,
	[EnableFlag]		[char] (1)	NOT NULL ,
	[StartTime]		[datetime]	NULL ,
	[EndTime]		[datetime]	NULL ,	
	[PipeLineName]		[varchar] (50)	NOT NULL ,
	[ProcedureName]		[varchar] (50)	NOT NULL ,
	[LastExecuted]		[lastdate]	NULL ,
	CONSTRAINT [PK_TINTERFACE] PRIMARY KEY  CLUSTERED 
	(
		[InterfaceID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO


insert into tinterface
	(InterfaceID, InterfaceGubun, InterfaceName, Source, Destination,  EnableFlag,
	PipelineName)
values(1, 'D', 'Shop Calendar', 'MIS', 'IPIS', 'Y', 'sp_test','p_download_tcalendarshop_old')
