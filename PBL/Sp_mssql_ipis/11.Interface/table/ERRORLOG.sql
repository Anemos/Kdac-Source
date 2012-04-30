if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ERRORLOG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ERRORLOG]
GO

CREATE TABLE [dbo].[ERRORLOG] (
	[ErrorID]		[int] IDENTITY(1,1)	NOT NULL ,
	[ErrorDate]		[datetime]		NOT NULL ,
	[EmpNo]			[varchar] (10)		NOT NULL ,
	[UserID]		[smallint]		NOT NULL ,
	[LoginName]		[VarChar] (30)		NOT NULL ,	-- SYSTEM_USER
	[HostID]		[Char] (8)		NULL ,			-- HOST_ID()
	[HostName]		[NChar] (30)		NULL ,			-- HOST_NAME()
	[ErrorCode]		[Int]			NOT NULL ,
	[ErrorText]		[VarChar] (255)		NOT NULL
	CONSTRAINT [PK_ERRORLOG] PRIMARY KEY  CLUSTERED 
	(
		[ErrorID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO


insert into ERRORLOG
	(InterfaceID, InterfaceGubun, InterfaceName, Source, Destination,  EnableFlag,
	PipelineName)
values(1, 'D', 'Shop Calendar', 'MIS', 'IPIS', 'Y', 'sp_test','p_download_tcalendarshop_old')
