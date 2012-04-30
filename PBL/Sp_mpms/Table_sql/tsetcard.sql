/* ************************** TSETCARD table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSETCARD]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSETCARD]
GO

CREATE TABLE [dbo].[TSETCARD] (
  [OrderNo]         [char]      (8)     NOT NULL,
  [DieGubun]        [char]      (1)     NULL,
  [DieNo]           [varchar]   (50)    NULL,
  [DieName]         [varchar]   (50)    NULL,
  [PressTonage]     [numeric]   (8,0)   NULL,
  [BuildDate]       [char]      (10)    NULL,
  [Model]           [varchar]   (50)    NULL,
  [PartName]        [varchar]   (50)    NULL,
  [DieSize]         [varchar]   (50)    NULL,
  [DieHeight]       [numeric]   (8,2)   NULL,
  [FeedHeight]      [numeric]   (8,2)   NULL,
  [StripPitch]      [numeric]   (8,2)   NULL,
  [Weight]          [numeric]   (8,0)   NULL,
  [DieImage]        [image]             NULL,
  [SerialNo]        [int]               NULL,
  [LastEmp]         [char]      (6)     NULL,
  [LastDate]        [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TSETCARD] PRIMARY KEY  CLUSTERED
  (
    [OrderNo]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
