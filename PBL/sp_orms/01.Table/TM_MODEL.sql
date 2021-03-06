USE [ORMS]
GO

/****** Object:  Table [dbo].[TM_MODEL]    Script Date: 01/17/2011 10:08:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TM_MODEL](
	[MODEL] [varchar](10) NOT NULL,
	[MODEL_NAME] [varchar](40) NULL,
	[REMARK] [varchar](40) NULL,
 CONSTRAINT [PK_TM_MODEL] PRIMARY KEY CLUSTERED 
(
	[MODEL] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

