/* ************************** LINE_MASTER_BK table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LINE_MASTER_BK]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LINE_MASTER_BK]
GO

CREATE TABLE [dbo].[LINE_MASTER_BK] (
  [line_code]       [varchar]   (30)    NOT NULL,
  [line_name]       [varchar]   (50)    NULL
) ON [PRIMARY]
GO

INSERT INTO LINE_MASTER_BK
SELECT * FROM LINE_MASTER

GO

/* ************************** LINE_MASTER table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LINE_MASTER]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LINE_MASTER]
GO

CREATE TABLE [dbo].[LINE_MASTER] (
  [area_code]       [char]      (1)     NOT NULL,
  [factory_code]    [char]      (1)     NOT NULL,
  [line_code]       [varchar]   (30)    NOT NULL,
  [line_name]       [varchar]   (50)    NULL,
  [lastemp]			    [char] 		  (6)			NULL,
	[lastdate]		    [datetime] 	default getdate() 
  CONSTRAINT [PK_LINE_MASTER] PRIMARY KEY  CLUSTERED
  (
    [area_code],[factory_code],[line_code]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO

INSERT INTO LINE_MASTER(area_code, factory_code, line_code, line_name)
SELECT 'D','S',line_code,line_name FROM LINE_MASTER_BK

GO

drop table [dbo].[LINE_MASTER_BK]

GO
