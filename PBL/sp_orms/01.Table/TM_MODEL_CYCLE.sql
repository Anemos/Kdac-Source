USE [ORMS]
GO

/****** Object:  Table [dbo].[TM_MODEL_CYCLE]    Script Date: 01/17/2011 10:08:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TM_MODEL_CYCLE](
	[MODEL] [varchar](10) NOT NULL,
	[TYPE] [varchar](1) NOT NULL,
	[INPUT_MAN] [int] NULL,
	[CYCLE_TIME] [int] NULL,
	[TARGET_RATE] [float] NULL,
	[FLAG] [varchar](1) NOT NULL,
 CONSTRAINT [PK_TM_MODEL_CYCLE] PRIMARY KEY CLUSTERED 
(
	[MODEL] ASC,
	[TYPE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

