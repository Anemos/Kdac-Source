USE [ORMS]
GO

/****** Object:  Table [dbo].[TH_WORK_TIME_NONE]    Script Date: 01/17/2011 10:08:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TH_WORK_TIME_NONE](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[PROD_YMD] [varchar](8) NULL,
	[PROD_SHIFT] [varchar](1) NULL,
	[UNWORK_TIME] [int] NULL,
 CONSTRAINT [PK_TH_WORK_TIME_NONE] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

